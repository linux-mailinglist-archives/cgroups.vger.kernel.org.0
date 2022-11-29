Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887A263B6C9
	for <lists+cgroups@lfdr.de>; Tue, 29 Nov 2022 01:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbiK2Aym (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 19:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbiK2Ayj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 19:54:39 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA59132BA7;
        Mon, 28 Nov 2022 16:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669683278; x=1701219278;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=4P2+jl1RIyYOuHVHfl3LKEnthZGh8okJ/3m5N/abcaU=;
  b=mv0eUFejlhHqmi48wjkhbZxd7n2qUEVnd/VcS7i/wSTBV3B92KaePOW9
   +xFQNawG1eiZmktgVRS3/02RcyJIPtlIcjprNaWp88gLxfy2Te2mr1XWi
   2wgGFiU0cgW5qvi9yjMyLnq3wtcXDrOYxVzYVH5/VZSnDjjcN7K6Z8Inq
   5NSt5L3hLT+fTgctUi+REtD10jNkfEj4AjYGzDCqiZZVZHuaSlKkfXETI
   ae+nEdfU5RHaxbMa0fhBUtz03nPJk228fcyuz8OFdBw6VejG9pThhlIBT
   TpJDcBXQo2DaJsL3cOERuw7ReAbsAX5quNkN/x3d6CWYQEmWCy3Oh4io3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="379248994"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="379248994"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 16:54:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="768248692"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="768248692"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 16:54:27 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Mina Almasry <almasrymina@google.com>,
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
In-Reply-To: <CAHbLzkrmxyzH4R7a9sJQavrUyKCEiNYeA543+sdJLsgRPrwBwQ@mail.gmail.com>
        (Yang Shi's message of "Mon, 28 Nov 2022 14:24:03 -0800")
References: <20221122203850.2765015-1-almasrymina@google.com>
        <Y35fw2JSAeAddONg@cmpxchg.org>
        <CAHS8izN+xqM67XLT4y5qyYnGQMUWRQCJrdvf2gjTHd8nZ_=0sw@mail.gmail.com>
        <Y36XchdgTCsMP4jT@cmpxchg.org>
        <874juonbmv.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAHbLzkrmxyzH4R7a9sJQavrUyKCEiNYeA543+sdJLsgRPrwBwQ@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Tue, 29 Nov 2022 08:53:24 +0800
Message-ID: <87a64ad1iz.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Yang Shi <shy828301@gmail.com> writes:

> On Wed, Nov 23, 2022 at 9:52 PM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Hi, Johannes,
>>
>> Johannes Weiner <hannes@cmpxchg.org> writes:
>> [...]
>> >
>> > The fallback to reclaim actually strikes me as wrong.
>> >
>> > Think of reclaim as 'demoting' the pages to the storage tier. If we
>> > have a RAM -> CXL -> storage hierarchy, we should demote from RAM to
>> > CXL and from CXL to storage. If we reclaim a page from RAM, it means
>> > we 'demote' it directly from RAM to storage, bypassing potentially a
>> > huge amount of pages colder than it in CXL. That doesn't seem right.
>> >
>> > If demotion fails, IMO it shouldn't satisfy the reclaim request by
>> > breaking the layering. Rather it should deflect that pressure to the
>> > lower layers to make room. This makes sure we maintain an aging
>> > pipeline that honors the memory tier hierarchy.
>>
>> Yes.  I think that we should avoid to fall back to reclaim as much as
>> possible too.  Now, when we allocate memory for demotion
>> (alloc_demote_page()), __GFP_KSWAPD_RECLAIM is used.  So, we will trigger
>> kswapd reclaim on lower tier node to free some memory to avoid fall back
>> to reclaim on current (higher tier) node.  This may be not good enough,
>> for example, the following patch from Hasan may help via waking up
>> kswapd earlier.
>
> For the ideal case, I do agree with Johannes to demote the page tier
> by tier rather than reclaiming them from the higher tiers. But I also
> agree with your premature OOM concern.
>
>>
>> https://lore.kernel.org/linux-mm/b45b9bf7cd3e21bca61d82dcd1eb692cd32c122c.1637778851.git.hasanalmaruf@fb.com/
>>
>> Do you know what is the next step plan for this patch?
>>
>> Should we do even more?
>
> In my initial implementation I implemented a simple throttle logic
> when the demotion is not going to succeed if the demotion target has
> not enough free memory (just check the watermark) to make migration
> succeed without doing any reclamation. Shall we resurrect that?

Can you share the link to your throttle patch?  Or paste it here?

> Waking kswapd sooner is fine to me, but it may be not enough, for
> example, the kswapd may not keep up so remature OOM may happen on
> higher tiers or reclaim may still happen. I think throttling the
> reclaimer/demoter until kswapd makes progress could avoid both. And
> since the lower tiers memory typically is quite larger than the higher
> tiers, so the throttle should happen very rarely IMHO.
>
>>
>> From another point of view, I still think that we can use falling back
>> to reclaim as the last resort to avoid OOM in some special situations,
>> for example, most pages in the lowest tier node are mlock() or too hot
>> to be reclaimed.
>>
>> > So I'm hesitant to design cgroup controls around the current behavior.

Best Regards,
Huang, Ying
