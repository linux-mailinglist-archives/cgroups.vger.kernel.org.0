Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87DE45F025
	for <lists+cgroups@lfdr.de>; Fri, 26 Nov 2021 15:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347563AbhKZOwk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Nov 2021 09:52:40 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42806 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353830AbhKZOuj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Nov 2021 09:50:39 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1E7252191A;
        Fri, 26 Nov 2021 14:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637938046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PKL1IwZU7Sf8I1Sm2EzfejGP6wBBqbshtaIBDh1BofM=;
        b=C7pAf4h3g07Q2TWEZLwk8oQE5GvplJ6GetAKD4txvg72bG6VjE+6KthzoQjO1k9oShms+4
        ltCzTwMsLuLSos6qiLd7NjWDoh9O/ph1xXqPW7Sd6PzhH0SLRJY7vG3VATsD+l821NZDrA
        Fcxw3JXd4BxcE402EXYfJULMexR4ftc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A6B713C60;
        Fri, 26 Nov 2021 14:47:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id U4npAX7zoGHAWgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 26 Nov 2021 14:47:26 +0000
Date:   Fri, 26 Nov 2021 15:47:24 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, fvogdt@suse.de,
        cgroups@vger.kernel.org
Subject: Re: Use after free with BFQ and cgroups
Message-ID: <20211126144724.GA31093@blackbody.suse.cz>
References: <20211125172809.GC19572@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211125172809.GC19572@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello.

On Thu, Nov 25, 2021 at 06:28:09PM +0100, Jan Kara <jack@suse.cz> wrote:
[...]
+Cc cgroups ML
https://lore.kernel.org/linux-block/20211125172809.GC19572@quack2.suse.cz/


I understand there are more objects than blkcgs but I assume it can
eventually boil down to blkcg references, so I suggest another
alternative. (But I may easily miss the relations between BFQ objects,
so consider this only high-level opinion.)

> After some poking, looking into crashdumps, and applying some debug patches
> the following seems to be happening: We have a process P in blkcg G. Now
> G is taken offline so bfq_group is cleaned up in bfq_pd_offline() but P
> still holds reference to G from its bfq_queue. Then P submits IO, G gets
> inserted into service tree despite being already offline.

(If G is offline, P can only be zombie, just saying. (I guess it can
still be Q's IO on behalf of G.))

IIUC, the reference to G is only held by P. If the G reference is copied
into another structure (the service tree) it should get another
reference. My naïve proposal would be css_get(). (1)

> IO completes, P exits, bfq_queue pointing to G gets destroyed, the
> last reference to G is dropped, G gets freed although is it still
> inserted in the service tree.  Eventually someone trips over the freed
> memory.

Isn't it the bfq_queue.bfq_entity that's inserted in the service tree
(not blkcg G)?
You write bfq_queue is destroyed, shouldn't that remove it from the
service tree? (2)

> Now I was looking into how to best fix this. There are several
> possibilities and I'm not sure which one to pick so that's why I'm writing
> to you. bfq_pd_offline() is walking all entities in service trees and
> trying to get rid of references to bfq_group (by reparenting entities).
> Is this guaranteed to see all entities that point to G? From the scenario
> I'm observing it seems this can miss entities pointing to G - e.g. if they
> are in idle tree, we will just remove them from the idle tree but we won't
> change entity->parent so they still point to G. This can be seen as one
> culprit of the bug.

There can be two types of references to blkcg (transitively via
bfq_group):
a) "plain" (just a pointer stored somewhere),
b) "pinned" (marked by css_get() of the respective blkcg).

The bfq_pd_offline() callback should erase all plain references (e.g. by
reparenting) or poke the holders of pinned references to release (unpin)
them eventually (so that blkcg goes away).

I reckon it's not possible to traverse all references in the
bfq_pd_offline().

> Or alternatively, should we e.g. add __bfq_deactivate_entity() to
> bfq_put_queue() when that function is dropping last queue in a bfq_group?

I guess this is what I wondered about in (2). (But I'm not sure this
really is proof against subsequent re-insertions into the tree.)

> Or should we just reparent bfq queues that have already dead parent on
> activation?

If (1) used css_tryget_online(), the parent (or ancestor if it happened
to be offlined too) could be the fallback.

> What's your opinion?

The question here is how long would stay the offlined blkcgs around if
they were directly pinned upon the IO submission. If it's unbound, then
reparenting makes more sense.


Michal
