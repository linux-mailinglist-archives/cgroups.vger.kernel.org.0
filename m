Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CFE6371F0
	for <lists+cgroups@lfdr.de>; Thu, 24 Nov 2022 06:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiKXFwV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Nov 2022 00:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKXFwQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Nov 2022 00:52:16 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C26A627EA;
        Wed, 23 Nov 2022 21:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669269135; x=1700805135;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=6G7nnH68EGLhd5S/EKcOEOe5slAPl+r6rFU7g2dJ4Z8=;
  b=Npo54Z8yRkPyCdpPwpwFxFJVtkQIIFMp33BhLHwbrHOZrzvW0lcQnHjj
   u2GpjVdBjFJUEu07WGee9+xEG8fo0XgXXT2aVzzXrzLj1FQ6/kj0h7Fkw
   YhhFYfKD91w3l+DZHutE6ZE+k/yeVsumwI0DmnG6MRJlB3hHBKgPFERcy
   43DSLEL3YnAe+/Yr1PiCU62mDTNlaOdUp2KHz42ppfDrGvYGy4DeV1gFA
   5kWFKiuy6CociveVI2ny/4YdYHrfB2eXpAeNdKM84LdRnid3MZAga1jI5
   idasOP0yZseugaz7H0lWqc7B4VwKdvkS2eZITvkSgwCIS4Pe4waodpd7d
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="311858645"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="311858645"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 21:52:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="644367190"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="644367190"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 21:52:10 -0800
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
Date:   Thu, 24 Nov 2022 13:51:20 +0800
In-Reply-To: <Y36XchdgTCsMP4jT@cmpxchg.org> (Johannes Weiner's message of
        "Wed, 23 Nov 2022 16:58:10 -0500")
Message-ID: <874juonbmv.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Hi, Johannes,

Johannes Weiner <hannes@cmpxchg.org> writes:
[...]
>
> The fallback to reclaim actually strikes me as wrong.
>
> Think of reclaim as 'demoting' the pages to the storage tier. If we
> have a RAM -> CXL -> storage hierarchy, we should demote from RAM to
> CXL and from CXL to storage. If we reclaim a page from RAM, it means
> we 'demote' it directly from RAM to storage, bypassing potentially a
> huge amount of pages colder than it in CXL. That doesn't seem right.
>
> If demotion fails, IMO it shouldn't satisfy the reclaim request by
> breaking the layering. Rather it should deflect that pressure to the
> lower layers to make room. This makes sure we maintain an aging
> pipeline that honors the memory tier hierarchy.

Yes.  I think that we should avoid to fall back to reclaim as much as
possible too.  Now, when we allocate memory for demotion
(alloc_demote_page()), __GFP_KSWAPD_RECLAIM is used.  So, we will trigger
kswapd reclaim on lower tier node to free some memory to avoid fall back
to reclaim on current (higher tier) node.  This may be not good enough,
for example, the following patch from Hasan may help via waking up
kswapd earlier.

https://lore.kernel.org/linux-mm/b45b9bf7cd3e21bca61d82dcd1eb692cd32c122c.1637778851.git.hasanalmaruf@fb.com/

Do you know what is the next step plan for this patch?

Should we do even more?

From another point of view, I still think that we can use falling back
to reclaim as the last resort to avoid OOM in some special situations,
for example, most pages in the lowest tier node are mlock() or too hot
to be reclaimed.

> So I'm hesitant to design cgroup controls around the current behavior.
>

Best Regards,
Huang, Ying
