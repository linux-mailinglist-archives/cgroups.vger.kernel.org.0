Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78F563CE1D
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 04:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiK3D4K (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Nov 2022 22:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiK3D4J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Nov 2022 22:56:09 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784F169DC3;
        Tue, 29 Nov 2022 19:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669780567; x=1701316567;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=wstP/Vj3b/bx7v6BDCKgttREqYEPOTLSqNXoVk7Grsg=;
  b=PmZpwdXhWg30AfIbwE+5BNZSK0jFr+kkFnao4N5hnVDCWeYeUYxQEfao
   0nYDpfUU53fw3uc2vAj7O1TweyemLOBgA2PGz0iqoeQtyJnnZqw+fqGcM
   ArBcvpqZGyeTMS4S0f5PH4AFXwafrpA4YFERjPe5uBsj5V1KKHQyFtz1k
   2A45rhDixaMqEJpdH6XJ7m7Ojz5U2QX3qPpRDW/iLpGWVGUQijdKistBY
   z2XsjUupmo8G3jpzWslRfSjAwBPtNCTM3WC0YjwVLYzAnmJY8KfpyMUI3
   nuBFXTBgYO72I+VRZIxZG/cRd0lnBF+CSYLHelxauvHCgrVX9N4q07iGv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="312911108"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="312911108"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 19:56:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="644055798"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="644055798"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 19:56:02 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Mina Almasry <almasrymina@google.com>,
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
Date:   Wed, 30 Nov 2022 11:55:12 +0800
In-Reply-To: <Y4ZKgXdUXZ3ycMp4@cmpxchg.org> (Johannes Weiner's message of
        "Tue, 29 Nov 2022 13:08:01 -0500")
Message-ID: <87wn7dayfz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> writes:

> Hello Ying,
>
> On Thu, Nov 24, 2022 at 01:51:20PM +0800, Huang, Ying wrote:
>> Johannes Weiner <hannes@cmpxchg.org> writes:
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
>
> If they're hotter than reclaim candidates on the toptier, shouldn't
> they get promoted instead and make room that way? We may have to tweak
> the watermark logic a bit to facilitate that (allow promotions where
> regular allocations already fail?). But this sort of resorting would
> be preferable to age inversions.

Now it's legal to enable demotion and disable promotion.  Yes, this is
wrong configuration in general.  But should we trigger OOM for these
users?

And now promotion only works for default NUMA policy (and MPOL_BIND to
both promotion source and target nodes with MPOL_F_NUMA_BALANCING).  If
we use some other NUMA policy, the pages cannot be promoted too.

> The mlock scenario sounds possible. In that case, it wouldn't be an
> aging inversion, since there is nothing colder on the CXL node.
>
> Maybe a bypass check should explicitly consult the demotion target
> watermarks against its evictable pages (similar to the file_is_tiny
> check in prepare_scan_count)?

Yes.  This sounds doable.

> Because in any other scenario, if there is a bug in the promo/demo
> coordination, I think we'd rather have the OOM than deal with age
> inversions causing intermittent performance issues that are incredibly
> hard to track down.

Previously, I thought that people will always prefer performance
regression than OOM.  Apparently, I am wrong.

Anyway, I think that we need to reduce the possibility of OOM or falling
back to reclaim as much as possible firstly.  Do you agree?

One possibility, can we fall back to reclaim only if the sc->priority is
small enough (even 0)?

Best Regards,
Huang, Ying
