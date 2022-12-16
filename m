Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA7464EB5B
	for <lists+cgroups@lfdr.de>; Fri, 16 Dec 2022 13:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiLPMXC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Dec 2022 07:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLPMXB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Dec 2022 07:23:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC9AB7F;
        Fri, 16 Dec 2022 04:22:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 925605CE05;
        Fri, 16 Dec 2022 12:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671193378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=55VqnW9Ao+0rvOaOMf07LBD98sXobnFCsHQn11Sa8t4=;
        b=qTjnrQi98XS8giC/67pmAob3YyoPo4ZM/zR1IGDfJwcrnEnkNJPPLopN/OTTMUMzIJ8c4Y
        SV3VhlBCaTZjtUjYsP2UF4YSdQx9N6gOee+Ph1pbnXW7kDupixd8iKm+dyK4yHSLWQYJp9
        bBqvbuzBcSUu3TZgVuDgzpvu0J1zrZw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FCF1138FD;
        Fri, 16 Dec 2022 12:22:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iCJrHiJjnGN5KQAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 16 Dec 2022 12:22:58 +0000
Date:   Fri, 16 Dec 2022 13:22:58 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, bagasdotme@gmail.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] Revert "mm: add nodes= arg to memory.reclaim"
Message-ID: <Y5xjIrrf0yNTJb/T@dhcp22.suse.cz>
References: <20221202223533.1785418-1-almasrymina@google.com>
 <Y5bsmpCyeryu3Zz1@dhcp22.suse.cz>
 <Y5xASNe1x8cusiTx@dhcp22.suse.cz>
 <CAHS8izP9RAYuVFs+e7JSKJui4u=oA4smqaRDGG2jn_3ssKvi8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izP9RAYuVFs+e7JSKJui4u=oA4smqaRDGG2jn_3ssKvi8A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 16-12-22 04:02:12, Mina Almasry wrote:
> On Fri, Dec 16, 2022 at 1:54 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > Andrew,
> > I have noticed that the patch made it into Linus tree already. Can we
> > please revert it because the semantic is not really clear and we should
> > really not create yet another user API maintenance problem. I am
> > proposing to revert the nodemask extension for now before we grow any
> > upstream users. Deeper in the email thread are some proposals how to
> > move forward with that.
> 
> There are proposals, many which have been rejected due to not
> addressing the motivating use cases and others that have been rejected
> by fellow maintainers, and some that are awaiting feedback. No, there
> is no other clear-cut way forward for this use case right now. I have
> found the merged approach by far the most agreeable so far.

There is a clear need for further discussion and until then we do not
want to expose interface and create dependencies that will inevitably
hard to change the semantic later.

> > From 7c5285f1725d5abfcae5548ab0d73be9ceded2a1 Mon Sep 17 00:00:00 2001
> > From: Michal Hocko <mhocko@suse.com>
> > Date: Fri, 16 Dec 2022 10:46:33 +0100
> > Subject: [PATCH] Revert "mm: add nodes= arg to memory.reclaim"
> >
> > This reverts commit 12a5d3955227b0d7e04fb793ccceeb2a1dd275c5.
> >
> > Although it is recognized that a finer grained pro-active reclaim is
> > something we need and want the semantic of this implementation is really
> > ambiguous.
> >
> > From a follow up discussion it became clear that there are two essential
> > usecases here. One is to use memory.reclaim to pro-actively reclaim
> > memory and expectation is that the requested and reported amount of memory is
> > uncharged from the memcg. Another usecase focuses on pro-active demotion
> > when the memory is merely shuffled around to demotion targets while the
> > overall charged memory stays unchanged.
> >
> > The current implementation considers demoted pages as reclaimed and that
> > break both usecases.
> 
> I think you're making it sound like this specific patch broke both use
> cases, and IMO that is not accurate. commit 3f1509c57b1b ("Revert
> "mm/vmscan: never demote for memcg reclaim"") has been in the tree for
> around 7 months now and that is the commit that enabled demotion in
> memcg reclaim, and implicitly counted demoted pages as reclaimed in
> memcg reclaim, which is the source of the ambiguity. Not the patch
> that you are reverting here.
> 
> The irony I find with this revert is that this patch actually removes
> the ambiguity and does not exacerbate it. Currently using
> memory.reclaim _without_ the nodes= arg is ambiguous because demoted
> pages count as reclaimed. On the other hand using memory.reclaim
> _with_ the nodes= arg is completely unambiguous: the kernel will
> demote-only from top tier nodes and reclaim-only from bottom tier
> nodes.

Yes, demoted patches are indeed counted as reclaimed but that is not a
major issue because from the external point of view charges are getting
reclaimed. It is nodes specification which makes the latent problem much
more obvious.

> 
> > [1] has tried to address the reporting part but
> > there are more issues with that summarized in [2] and follow up emails.
> >
> 
> I am the one that put effort into resolving the ambiguity introduced
> by commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> reclaim"") and proposed [1]. Reverting this patch does nothing to
> resolve ambiguity that it did not introduce.
> 
> > Let's revert the nodemask based extension of the memcg pro-active
> > reclaim for now until we settle with a more robust semantic.
> >
> 
> I do not think we should revert this. It enables a couple of important
> use cases for Google:
> 
> 1. Enables us to specifically trigger proactive reclaim in a memcg on
> a memory tiered system by specifying only the lower tiered nodes using
> the nodes= arg.
> 2. Enabled us to specifically trigger proactive demotion in a memcg on
> a memory tiered system by specifying only the top tier nodes using the
> nodes= arg.

That is clear and the aim of the revert is not to disallow those
usecases. We just need a clear and futureproof interface for that.
Changing the semantic after the fact is a nogo, hence the revert.
> 
> Both use cases are broken with this revert, and no progress to resolve
> the ambiguity is made with this revert.

There cannot be any regression with the revert now because the code
hasn't been upstream.

So let's remove the interface until we can agree on the exact semantic
and build the interface from there.
-- 
Michal Hocko
SUSE Labs
