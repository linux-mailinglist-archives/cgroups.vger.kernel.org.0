Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5863664C450
	for <lists+cgroups@lfdr.de>; Wed, 14 Dec 2022 08:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237414AbiLNHQW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Dec 2022 02:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiLNHQV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Dec 2022 02:16:21 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B4D23381;
        Tue, 13 Dec 2022 23:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671002180; x=1702538180;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=VwZs05pVUP7LqVeCoKXF+sKs0Nd4RnRQHbZbxbbWEUM=;
  b=F/ZCHz4f9CQXiU0q0fu9QtlL8zYjBMOhbvA4fnPZZjW5VBAnqYqCw9VR
   6jByAKuS0r0v0LOkwx8aysVGrM0Z2RYn3r+m2JkaoIKghDReNRmgXn+oW
   xZcpiTaU94BuJUbAUBAkgQ5pyXDr40PBus7JL0YB2Vtzn3+Qhtwr+4HfN
   YDEGRicmrQRXzylyUSJRLm337TANrumheHebkhyOtNVfSL91J388t2GVQ
   E69ZfrfU1ERyWnsrd7x24OYlybDvhwlukzwQfXogprKl09oipkmtF1W4f
   6K3XRsKm6nkIha/f9SkGfo8uYZLsVeL6nuqUqCHjlz+C4NU6PYhJqcc6o
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="298013865"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="298013865"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 23:16:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="894183341"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="894183341"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 23:16:15 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Mina Almasry <almasrymina@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, bagasdotme@gmail.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: Add nodes= arg to memory.reclaim
References: <20221202223533.1785418-1-almasrymina@google.com>
        <Y5bsmpCyeryu3Zz1@dhcp22.suse.cz>
        <CAHS8izM-XdLgFrQ1k13X-4YrK=JGayRXV_G3c3Qh4NLKP7cH_g@mail.gmail.com>
        <Y5g41HF2TcLzro4o@dhcp22.suse.cz> <Y5iet+ch24YrvExA@cmpxchg.org>
Date:   Wed, 14 Dec 2022 15:15:17 +0800
In-Reply-To: <Y5iet+ch24YrvExA@cmpxchg.org> (Johannes Weiner's message of
        "Tue, 13 Dec 2022 16:58:50 +0100")
Message-ID: <87fsdifoca.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> writes:

> On Tue, Dec 13, 2022 at 09:33:24AM +0100, Michal Hocko wrote:
>> I do recognize your need to control the demotion but I argue that it is
>> a bad idea to rely on an implicit behavior of the memory reclaim and an
>> interface which is _documented_ to primarily _reclaim_ memory.
>
> I think memory.reclaim should demote as part of page aging. What I'd
> like to avoid is *having* to manually control the aging component in
> the interface (e.g. making memory.reclaim *only* reclaim, and
> *requiring* a coordinated use of memory.demote to ensure progress.)
>
>> Really, consider that the current demotion implementation will change
>> in the future and based on a newly added heuristic memory reclaim or
>> compression would be preferred over migration to a different tier.  This
>> might completely break your current assumptions and break your usecase
>> which relies on an implicit demotion behavior.  Do you see that as a
>> potential problem at all? What shall we do in that case? Special case
>> memory.reclaim behavior?
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
> just another form of demotion. Sure, page faults have a different
> access latency than dax to slower memory. But you could also have 3
> tiers of memory where the difference between tier 1 and 2 is much
> smaller than the difference between 2 and 3, and you might want to
> apply different demotion rates between them as well.
>
> The other argument is that demotion does not free cgroup memory,
> whereas reclaim does. But with multiple memory tiers of vastly
> different performance, isn't there also an argument for granting
> cgroups different shares of each memory? So that a higher priority
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

Yes.  The definition is clear if nodes= from the same memory tier.

> And if no nodes are passed, it means reclaim (from the lowest memory
> tier) X pages and demote as needed, then return the reclaimed pages.

It appears that the definition isn't very clear here.  How many pages
should be demoted?  The target number is the value echoed to
memory.reclaim?  Or requested_number - pages_in_lowest_tier?  Should we
demote in as many tiers as possible or in as few tiers as possible?  One
possibility is to take advantage of top tier memory as much as
possible.  That is, try to reclaim pages in lower tiers only.

>> Now to your specific usecase. If there is a need to do a memory
>> distribution balancing then fine but this should be a well defined
>> interface. E.g. is there a need to not only control demotion but
>> promotions as well? I haven't heard anybody requesting that so far
>> but I can easily imagine that like outsourcing the memory reclaim to
>> the userspace someone might want to do the same thing with the numa
>> balancing because $REASONS. Should that ever happen, I am pretty sure
>> hooking into memory.reclaim is not really a great idea.
>
> Should this ever happen, it would seem fair that that be a separate
> knob anyway, no? One knob to move the pipeline in one direction
> (aging), one knob to move it the other way.

Agree.

Best Regards,
Huang, Ying
