Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DA563FDE7
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 03:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiLBCCv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Dec 2022 21:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiLBCCu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Dec 2022 21:02:50 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28BF275F6;
        Thu,  1 Dec 2022 18:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669946569; x=1701482569;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=DUxVs+XVQBl0UL/Tbqjptes7IbkNXXTyQuoYBy96rpk=;
  b=j6dshGYfJbKwqWnN4MuAxALAQwRM98LrhOmPN9c8yLkOYVX/DQLEEUMN
   j9UWv1+dgZLaRYH3laGgTbIRk9YkL6KoEOZkajW2fJzyjjIQPx9cM7TzG
   eRxvHSPzih+0Wm6wKYZOtgPbVeQl7S48Z3qjwmQr//fvxWl86/hAXOqhu
   KHZldeZ+I7A1o+F/9cL3iEJ6/89SffI534jrm8hado448uYtUTeMVOqzI
   zHRKkRem4TpZ3XIrzjKXQj4j38dJHBLcGBcoPzfPYLeSqAAWxdxfloEJ7
   EZfhK3VwhV0nXDFTNWBUBXua/y5AumMxMWuOF1vKQe8DuRPKxT1ikYx8G
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="378006745"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="378006745"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 18:02:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="889970343"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="889970343"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 18:02:29 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        shakeelb@google.com, gthelen@google.com, fvdl@google.com,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH V1] mm: Disable demotion from proactive reclaim
References: <20221122203850.2765015-1-almasrymina@google.com>
        <Y35fw2JSAeAddONg@cmpxchg.org>
        <CAHS8izN+xqM67XLT4y5qyYnGQMUWRQCJrdvf2gjTHd8nZ_=0sw@mail.gmail.com>
        <Y36XchdgTCsMP4jT@cmpxchg.org>
        <874juonbmv.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y4ZKgXdUXZ3ycMp4@cmpxchg.org>
        <87wn7dayfz.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAHS8izNc=NeMcNudOB0r4aYbZURpU+Y9xpek_KpO=55R+7ec5g@mail.gmail.com>
Date:   Fri, 02 Dec 2022 10:01:39 +0800
In-Reply-To: <CAHS8izNc=NeMcNudOB0r4aYbZURpU+Y9xpek_KpO=55R+7ec5g@mail.gmail.com>
        (Mina Almasry's message of "Thu, 1 Dec 2022 12:40:16 -0800")
Message-ID: <87tu2e36nw.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Mina Almasry <almasrymina@google.com> writes:

> On Tue, Nov 29, 2022 at 7:56 PM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Johannes Weiner <hannes@cmpxchg.org> writes:
>>
>> > Hello Ying,
>> >
>> > On Thu, Nov 24, 2022 at 01:51:20PM +0800, Huang, Ying wrote:
>> >> Johannes Weiner <hannes@cmpxchg.org> writes:
>> >> > The fallback to reclaim actually strikes me as wrong.
>> >> >
>> >> > Think of reclaim as 'demoting' the pages to the storage tier. If we
>> >> > have a RAM -> CXL -> storage hierarchy, we should demote from RAM to
>> >> > CXL and from CXL to storage. If we reclaim a page from RAM, it means
>> >> > we 'demote' it directly from RAM to storage, bypassing potentially a
>> >> > huge amount of pages colder than it in CXL. That doesn't seem right.
>> >> >
>> >> > If demotion fails, IMO it shouldn't satisfy the reclaim request by
>> >> > breaking the layering. Rather it should deflect that pressure to the
>> >> > lower layers to make room. This makes sure we maintain an aging
>> >> > pipeline that honors the memory tier hierarchy.
>> >>
>> >> Yes.  I think that we should avoid to fall back to reclaim as much as
>> >> possible too.  Now, when we allocate memory for demotion
>> >> (alloc_demote_page()), __GFP_KSWAPD_RECLAIM is used.  So, we will trigger
>> >> kswapd reclaim on lower tier node to free some memory to avoid fall back
>> >> to reclaim on current (higher tier) node.  This may be not good enough,
>> >> for example, the following patch from Hasan may help via waking up
>> >> kswapd earlier.
>> >>
>> >> https://lore.kernel.org/linux-mm/b45b9bf7cd3e21bca61d82dcd1eb692cd32c122c.1637778851.git.hasanalmaruf@fb.com/
>> >>
>> >> Do you know what is the next step plan for this patch?
>> >>
>> >> Should we do even more?
>> >>
>> >> From another point of view, I still think that we can use falling back
>> >> to reclaim as the last resort to avoid OOM in some special situations,
>> >> for example, most pages in the lowest tier node are mlock() or too hot
>> >> to be reclaimed.
>> >
>> > If they're hotter than reclaim candidates on the toptier, shouldn't
>> > they get promoted instead and make room that way? We may have to tweak
>> > the watermark logic a bit to facilitate that (allow promotions where
>> > regular allocations already fail?). But this sort of resorting would
>> > be preferable to age inversions.
>>
>> Now it's legal to enable demotion and disable promotion.  Yes, this is
>> wrong configuration in general.  But should we trigger OOM for these
>> users?
>>
>> And now promotion only works for default NUMA policy (and MPOL_BIND to
>> both promotion source and target nodes with MPOL_F_NUMA_BALANCING).  If
>> we use some other NUMA policy, the pages cannot be promoted too.
>>
>> > The mlock scenario sounds possible. In that case, it wouldn't be an
>> > aging inversion, since there is nothing colder on the CXL node.
>> >
>> > Maybe a bypass check should explicitly consult the demotion target
>> > watermarks against its evictable pages (similar to the file_is_tiny
>> > check in prepare_scan_count)?
>>
>> Yes.  This sounds doable.
>>
>> > Because in any other scenario, if there is a bug in the promo/demo
>> > coordination, I think we'd rather have the OOM than deal with age
>> > inversions causing intermittent performance issues that are incredibly
>> > hard to track down.
>>
>> Previously, I thought that people will always prefer performance
>> regression than OOM.  Apparently, I am wrong.
>>
>> Anyway, I think that we need to reduce the possibility of OOM or falling
>> back to reclaim as much as possible firstly.  Do you agree?
>>
>
> I've been discussing this with a few folks here. I think FWIW general
> feeling here is that demoting from top tier nodes is preferred, except
> in extreme circumstances we would indeed like to run with a
> performance issue rather than OOM a customer VM. I wonder if there is
> another way to debug mis-tiered pages rather than trigger an oom to
> debug.
>
> One thing I think/hope we can trivially agree on is that proactive
> reclaim/demotion is _not_ an extreme circumstance. I would like me or
> someone from the team to follow up with a patch that disables fallback
> to reclaim on proactive reclaim/demotion (sc->proactive).

Yes.  This makes sense to me.

Best Regards,
Huang, Ying

>> One possibility, can we fall back to reclaim only if the sc->priority is
>> small enough (even 0)?
>>
>
> This makes sense to me.
>
>> Best Regards,
>> Huang, Ying
>>
