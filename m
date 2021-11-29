Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F264461C88
	for <lists+cgroups@lfdr.de>; Mon, 29 Nov 2021 18:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347285AbhK2RQe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Nov 2021 12:16:34 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55290 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239871AbhK2ROe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Nov 2021 12:14:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8FE2C1FCA1;
        Mon, 29 Nov 2021 17:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638205875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W99YQayPw77wzqXrx6MLXl/dSR3NLPlo5KdeeMbjv2s=;
        b=BXp+b30+BGkNmEJB4Oq4HGpNDwueooCz+LMEk1UUiZU3/P2dK/AxKjp0IpfqzPlMdfWRAa
        tA+rXNjtgOKNguPjhFaUuOCQZ2nWVZ7fYHFWnTBzJV9vdmWQxw138VelsEfBzWB8pNlPop
        imT8qRFKtiV/44U3cQCVXL71XyWxuaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638205875;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W99YQayPw77wzqXrx6MLXl/dSR3NLPlo5KdeeMbjv2s=;
        b=a8YoAADl546MO/ok6S7UfrVJBGzQ39c1AaASnakkJ+fm8p7rWXgv9zdGmrgY5AKuZT57j8
        y/n5IzGDpSioyBBw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 7FA7AA3B87;
        Mon, 29 Nov 2021 17:11:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5FBA21E1494; Mon, 29 Nov 2021 18:11:15 +0100 (CET)
Date:   Mon, 29 Nov 2021 18:11:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Jan Kara <jack@suse.cz>, Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, fvogt@suse.de, cgroups@vger.kernel.org
Subject: Re: Use after free with BFQ and cgroups
Message-ID: <20211129171115.GC29512@quack2.suse.cz>
References: <20211125172809.GC19572@quack2.suse.cz>
 <20211126144724.GA31093@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211126144724.GA31093@blackbody.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 26-11-21 15:47:24, Michal Koutný wrote:
> Hello.
> 
> On Thu, Nov 25, 2021 at 06:28:09PM +0100, Jan Kara <jack@suse.cz> wrote:
> [...]
> +Cc cgroups ML
> https://lore.kernel.org/linux-block/20211125172809.GC19572@quack2.suse.cz/
> 
> 
> I understand there are more objects than blkcgs but I assume it can
> eventually boil down to blkcg references, so I suggest another
> alternative. (But I may easily miss the relations between BFQ objects,
> so consider this only high-level opinion.)
> 
> > After some poking, looking into crashdumps, and applying some debug patches
> > the following seems to be happening: We have a process P in blkcg G. Now
> > G is taken offline so bfq_group is cleaned up in bfq_pd_offline() but P
> > still holds reference to G from its bfq_queue. Then P submits IO, G gets
> > inserted into service tree despite being already offline.
> 
> (If G is offline, P can only be zombie, just saying. (I guess it can
> still be Q's IO on behalf of G.))
> 
> IIUC, the reference to G is only held by P. If the G reference is copied
> into another structure (the service tree) it should get another
> reference. My naïve proposal would be css_get(). (1)

So I was looking into this puzzle. The answer is following:

The process P (podman, pid 2571) is currently attached to the root cgroup
but it has io_context with BFQ queue that points to the already-offline G
as a parent. The bio is thus associated with the root cgroup (via
bio->bi_blkg) but BFQ uses io_context to lookup the BFQ queue where IO
should be queued and then uses its parent to determine blkg which it should
be charged and thus gets to the dying cgroup.

Apparently P got recently moved from G to the root cgroup and there was
reference left in the BFQ queue structure to G.

> > IO completes, P exits, bfq_queue pointing to G gets destroyed, the
> > last reference to G is dropped, G gets freed although is it still
> > inserted in the service tree.  Eventually someone trips over the freed
> > memory.
> 
> Isn't it the bfq_queue.bfq_entity that's inserted in the service tree
> (not blkcg G)?

Yes, it is. But the entity is part of bfq_group structure which is the pd
for the blkcg.

> You write bfq_queue is destroyed, shouldn't that remove it from the
> service tree? (2)

Yes, BFQ queue is removed from the service trees on destruction. But its
parent - bfq_group - is not removed from its service tree. And that's where
we hit the problem.

> > Now I was looking into how to best fix this. There are several
> > possibilities and I'm not sure which one to pick so that's why I'm writing
> > to you. bfq_pd_offline() is walking all entities in service trees and
> > trying to get rid of references to bfq_group (by reparenting entities).
> > Is this guaranteed to see all entities that point to G? From the scenario
> > I'm observing it seems this can miss entities pointing to G - e.g. if they
> > are in idle tree, we will just remove them from the idle tree but we won't
> > change entity->parent so they still point to G. This can be seen as one
> > culprit of the bug.
> 
> There can be two types of references to blkcg (transitively via
> bfq_group):
> a) "plain" (just a pointer stored somewhere),
> b) "pinned" (marked by css_get() of the respective blkcg).
> 
> The bfq_pd_offline() callback should erase all plain references (e.g. by
> reparenting) or poke the holders of pinned references to release (unpin)
> them eventually (so that blkcg goes away).
> 
> I reckon it's not possible to traverse all references in the
> bfq_pd_offline().

So bfq_pd_offline() does erase all plain references AFAICT. But later it
can create new plain references (service tree) from the existing "pinned"
ones and once pinned references go away, those created plain references
cause trouble. And the more I'm looking into this the more I'm convinced
bfq_pd_offline() should be more careful and remove also the pinned
references from bfq queues. It actually does it for most queues but it can
currently miss some... I'll look into that.

Thanks for your very good questions and hints!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
