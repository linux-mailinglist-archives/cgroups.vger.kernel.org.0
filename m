Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E88B64C74E
	for <lists+cgroups@lfdr.de>; Wed, 14 Dec 2022 11:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237878AbiLNKnY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Dec 2022 05:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiLNKnX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Dec 2022 05:43:23 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CFD14038;
        Wed, 14 Dec 2022 02:43:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 202AB22181;
        Wed, 14 Dec 2022 10:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671014601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pOLj6orCcUIQaK1bmDnm+LNeXET6CuRHzqb6smtqDhg=;
        b=tjmQwSC5l46EbQoMLj96F7w8R2nfE0/DWBVttEI5sO7CPV/4mkrC5QCI+5wL64xI56tI7L
        5hAXErj/GwBzqruajdRn2lNn/w4NwtVCIjzOJxpqurEpCJwoK24hFs04eu91K98KkKeLZ+
        B2dlnycoWRyJ6RfyHL2Jp/tyTWWG/KA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB6B61333E;
        Wed, 14 Dec 2022 10:43:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lEwKN8iomWPJKQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 14 Dec 2022 10:43:20 +0000
Date:   Wed, 14 Dec 2022 11:43:20 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Mina Almasry <almasrymina@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, bagasdotme@gmail.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: Add nodes= arg to memory.reclaim
Message-ID: <Y5moyNXfgQ6cfLbO@dhcp22.suse.cz>
References: <20221202223533.1785418-1-almasrymina@google.com>
 <Y5bsmpCyeryu3Zz1@dhcp22.suse.cz>
 <CAHS8izM-XdLgFrQ1k13X-4YrK=JGayRXV_G3c3Qh4NLKP7cH_g@mail.gmail.com>
 <Y5g41HF2TcLzro4o@dhcp22.suse.cz>
 <Y5iet+ch24YrvExA@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5iet+ch24YrvExA@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 13-12-22 16:58:50, Johannes Weiner wrote:
> On Tue, Dec 13, 2022 at 09:33:24AM +0100, Michal Hocko wrote:
> > I do recognize your need to control the demotion but I argue that it is
> > a bad idea to rely on an implicit behavior of the memory reclaim and an
> > interface which is _documented_ to primarily _reclaim_ memory.
> 
> I think memory.reclaim should demote as part of page aging. What I'd
> like to avoid is *having* to manually control the aging component in
> the interface (e.g. making memory.reclaim *only* reclaim, and
> *requiring* a coordinated use of memory.demote to ensure progress.)

Yes, I do agree with that. Demotion is a part of the aging. I meant to say
that the result of the operation should be reclaimed charges but that
doesn't mean that demotion is not a part of that process.

I am mostly concerned about demote only behavior that Mina is targetting
and want to use memory.reclaim interface.

> > Really, consider that the current demotion implementation will change
> > in the future and based on a newly added heuristic memory reclaim or
> > compression would be preferred over migration to a different tier.  This
> > might completely break your current assumptions and break your usecase
> > which relies on an implicit demotion behavior.  Do you see that as a
> > potential problem at all? What shall we do in that case? Special case
> > memory.reclaim behavior?
> 
> Shouldn't that be derived from the distance propertiers in the tier
> configuration?
> 
> I.e. if local compression is faster than demoting to a slower node, we
> should maybe have a separate tier for that. Ignoring proactive reclaim
> or demotion commands for a second: on that node, global memory
> pressure should always compress first, while the oldest pages from the
> compression cache should demote to the other node(s) - until they
> eventually get swapped out.
> 
> However fine-grained we make proactive reclaim control over these
> stages, it should at least be possible for the user to request the
> default behavior that global pressure follows, without jumping through
> hoops or requiring the coordinated use of multiple knobs. So IMO there
> is an argument for having a singular knob that requests comprehensive
> aging and reclaiming across the configured hierarchy.
> 
> As far as explicit control over the individual stages goes - no idea
> if you would call the compression stage demotion or reclaim. The
> distinction still does not make much of sense to me, since reclaim is
> just another form of demotion.

From the external visibility POV the major difference between the two is
that the reclaim decreases the overall charged memory. And there are
pro-active reclaim usecases which rely on that. Demotion is mostly
memory placement rebalancing. Sure still visible in per-node stats and
with implications to performance but that is a different story.

> Sure, page faults have a different
> access latency than dax to slower memory. But you could also have 3
> tiers of memory where the difference between tier 1 and 2 is much
> smaller than the difference between 2 and 3, and you might want to
> apply different demotion rates between them as well.
> 
> The other argument is that demotion does not free cgroup memory,
> whereas reclaim does. But with multiple memory tiers of vastly
> different performance, isn't there also an argument for granting
> cgroups different shares of each memory?

Yes. We have already had requests for per node limits in the past. And I
do expect this will show up as a problem here as well but with a
reasonable memory.reclaim and potentially memory.demote interfaces the
balancing and policy making can be outsourced to the userspace .

> So that a higher priority
> group has access to a bigger share of the fastest memory, and lower
> prio cgroups are relegated to lower tiers. If we split those pools,
> then "demotion" will actually free memory in a cgroup.
> 
> This is why I liked adding a nodes= argument to memory.reclaim the
> best. It doesn't encode a distinction that may not last for long.
> 
> The problem comes from how to interpret the input argument and the
> return value, right? Could we solve this by requiring the passed
> nodes= to all be of the same memory tier? Then there is no confusion
> around what is requested and what the return value means.

Just to make sure I am on the same page. This means that if a node mask
is specified then it always implies demotion without any control over
how the demotion is done, right?

> And if no nodes are passed, it means reclaim (from the lowest memory
> tier) X pages and demote as needed, then return the reclaimed pages.

IMO this is rather constrained semantic which will completely rule out
some potentially interesting usecases. E.g. fine grained control over
the demotion path or enforced reclaim for node balancing. Also if we
ever want a promote interface then it would better fit with demote
counterpart.

> > Now to your specific usecase. If there is a need to do a memory
> > distribution balancing then fine but this should be a well defined
> > interface. E.g. is there a need to not only control demotion but
> > promotions as well? I haven't heard anybody requesting that so far
> > but I can easily imagine that like outsourcing the memory reclaim to
> > the userspace someone might want to do the same thing with the numa
> > balancing because $REASONS. Should that ever happen, I am pretty sure
> > hooking into memory.reclaim is not really a great idea.
> 
> Should this ever happen, it would seem fair that that be a separate
> knob anyway, no? One knob to move the pipeline in one direction
> (aging), one knob to move it the other way.

Yes, this is what I am inclining to as well.

-- 
Michal Hocko
SUSE Labs
