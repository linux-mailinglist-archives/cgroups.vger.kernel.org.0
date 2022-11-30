Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE66F63CEC7
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 06:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiK3FkQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 00:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiK3FkP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 00:40:15 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74567615B;
        Tue, 29 Nov 2022 21:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669786813; x=1701322813;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=7bushIMDrKj/fAEl186WlCQe8w0m5wH7S69eqHtJo14=;
  b=VcX5thZV6v4dpN3lhTOsQqKOAcC7LjqZCKPrj9rUOik27NfdgI3SidX3
   F+UT8q/pZJOgEM3nu22SExipvp9bHedN+lgYGT62YK+6CG+mqJtQVUAjx
   AZ7jfpmXbH/jYfaR7kV8lmFD4ZTDMkftaRPyEeCjDvsKLZqe8vqwOHmc8
   wz7wm883CtSlI5CW7Q3DiDgQrlR4rJtfMZox1LBYFZ2OF4MXmjYTB0rZF
   jRK4A6PF1ZmTyMRhsPb+w/MP/IsYvZuJRDpyzc3oJ0X6ZuRAcezXq1iDY
   Dp12zuat4voL6fRGZOb5aKeAtxEXZmWZwnHsNov9firvQTD0yGuQ+fr+B
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="295005340"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="295005340"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 21:40:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="768706794"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="768706794"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 21:40:09 -0800
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
        <CAHS8izMhoHVCGxXGt8qRtf-fPpAR8=pTy7Rc3j2=Wf8vJz-C+g@mail.gmail.com>
Date:   Wed, 30 Nov 2022 13:39:19 +0800
In-Reply-To: <CAHS8izMhoHVCGxXGt8qRtf-fPpAR8=pTy7Rc3j2=Wf8vJz-C+g@mail.gmail.com>
        (Mina Almasry's message of "Tue, 29 Nov 2022 18:14:49 -0800")
Message-ID: <87edtlatmg.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Mina Almasry <almasrymina@google.com> writes:

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
>
> I may be missing something but as far I can tell reclaim is disabled
> for allocations from lower tier memory:
> https://elixir.bootlin.com/linux/v6.1-rc7/source/mm/vmscan.c#L1583

#define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM)

We have GFP_NOWAIT set in gfp.

> I think this is maybe a good thing when doing proactive demotion. In
> this case we probably don't want to try to reclaim from lower tier
> nodes and instead fail the proactive demotion.

Do you have some real use cases for this?  If so, we can tweak the
logic.

> However I can see this being desirable when the top tier nodes are
> under real memory pressure to deflect that pressure to the lower tier
> nodes.

Yes.

Best Regards,
Huang, Ying

>> kswapd reclaim on lower tier node to free some memory to avoid fall back
>> to reclaim on current (higher tier) node.  This may be not good enough,
>> for example, the following patch from Hasan may help via waking up
>> kswapd earlier.
>>
>> https://lore.kernel.org/linux-mm/b45b9bf7cd3e21bca61d82dcd1eb692cd32c122c.1637778851.git.hasanalmaruf@fb.com/
>>
>> Do you know what is the next step plan for this patch?
>>
>> Should we do even more?
>>
>> From another point of view, I still think that we can use falling back
>> to reclaim as the last resort to avoid OOM in some special situations,
>> for example, most pages in the lowest tier node are mlock() or too hot
>> to be reclaimed.
>>
>> > So I'm hesitant to design cgroup controls around the current behavior.
>
> I sent RFC v2 patch:
> https://lore.kernel.org/linux-mm/20221130020328.1009347-1-almasrymina@google.com/T/#u
>
> Please take a look when convenient. Thanks!
>
>> >
>>
>> Best Regards,
>> Huang, Ying
>>
