Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1500052538B
	for <lists+cgroups@lfdr.de>; Thu, 12 May 2022 19:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357016AbiELR1m (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 May 2022 13:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356850AbiELR1m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 May 2022 13:27:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D335994C8;
        Thu, 12 May 2022 10:27:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CDD141F8EF;
        Thu, 12 May 2022 17:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652376459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7XEGm/1PGoEXcO1HFP5KFYVz2HoDo+VVY6EzV48qjEY=;
        b=FzNR/9sgSrYP2DPIDbJYhi2A7TQZTkeEClVE8X88trBQ+zDeTp6YXcGexdIzHN9WVt1CXT
        6ppZ2fr+wNOvNGpQiGz6QiiimHTY0fyVoPFyBeCsw0Wxl9Pe77+R+JdNfKLcpjL+emZ331
        gZhmVXUA0C5FWdFhgV4XQ8ieop+pvys=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9396713ABE;
        Thu, 12 May 2022 17:27:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zMdGI4tDfWJwJQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 12 May 2022 17:27:39 +0000
Date:   Thu, 12 May 2022 19:27:38 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Vernet <void@manifault.com>, tj@kernel.org,
        roman.gushchin@linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Chris Down <chris@chrisdown.name>
Subject: Re: [PATCH v2 2/5] cgroup: Account for memory_recursiveprot in
 test_memcg_low()
Message-ID: <20220512172738.GB16096@blackbody.suse.cz>
References: <20220423155619.3669555-1-void@manifault.com>
 <20220423155619.3669555-3-void@manifault.com>
 <20220427140928.GD9823@blackbody.suse.cz>
 <20220429010333.5rt2jwpiumnbuapf@dev0025.ash9.facebook.com>
 <20220429092620.GA23621@blackbody.suse.cz>
 <20220506164015.fsdsuv226nhllos5@dev0025.ash9.facebook.com>
 <Ynkum8DeJIAtGi9y@cmpxchg.org>
 <20220509174424.e43e695ffe0f7333c187fba8@linux-foundation.org>
 <20220510174341.GC24172@blackbody.suse.cz>
 <Ynv4AdjeVjptnjrH@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ynv4AdjeVjptnjrH@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 11, 2022 at 01:53:05PM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
> Can you indeed elaborate on the problem you see with low events?

My mistake. I realized I was testing on a system without
memory_recursiveprot enabled. Therefore I saw no events in children with
memory.low=0.

However, it also means that my previous evaluation of the "simple" fix
(dropping the SWAP_CLUSTER_MAX rounding) was incorrect and it actually
doesn't resolve the problem of two differently active siblings I posted
earlier.

> So your proposed patch looks like the right thing to do to me. And I
> would ack it, but please do explain your concerns around low event
> reporting after it.

I retract it (at least for now), it doesn't really help. It can be seen
(after application) [1] that once (low) protected memory is opened for
reclaim, the sibling proportions change suddenly (neither sibling is
protected during sc->memcg_low_reclaim, however, the formerly protected
suddenly provides good supply of reclaimable pages).

OTOH, without memory_recursiveprot [2], the elow growth of the victim
sibling is absent and situation stabilizes with only partial reclaim
from the (explicitly) protected sibling. 

In both variants (recursive/non-recursive) the parent ends up with same
amount of unreclaimed memory, however, the gradual tranfer of elow with
the recursive protection is undesired. (I'm only thinking how to solve
it simply.)

Michal

[1] https://bugzilla.suse.com/attachment.cgi?id=858869
[2] https://bugzilla.suse.com/attachment.cgi?id=858870

