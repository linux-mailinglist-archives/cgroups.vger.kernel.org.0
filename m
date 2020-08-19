Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC672497BF
	for <lists+cgroups@lfdr.de>; Wed, 19 Aug 2020 09:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgHSHwL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Aug 2020 03:52:11 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:37520 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726691AbgHSHwJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Aug 2020 03:52:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U6D1B9t_1597823522;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6D1B9t_1597823522)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 19 Aug 2020 15:52:03 +0800
Subject: Re: [RFC PATCH v2 3/5] mm: Add explicit page decrement in exception
 path for isolate_lru_pages
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     yang.shi@linux.alibaba.com, lkp@intel.com, rong.a.chen@intel.com,
        khlebnikov@yandex-team.ru, kirill@shutemov.name, hughd@google.com,
        linux-kernel@vger.kernel.org, daniel.m.jordan@oracle.com,
        linux-mm@kvack.org, shakeelb@google.com, willy@infradead.org,
        hannes@cmpxchg.org, tj@kernel.org, cgroups@vger.kernel.org,
        akpm@linux-foundation.org, richard.weiyang@gmail.com,
        mgorman@techsingularity.net, iamjoonsoo.kim@lge.com
References: <20200819041852.23414.95939.stgit@localhost.localdomain>
 <20200819042722.23414.2654.stgit@localhost.localdomain>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <cc993d93-a5af-dd29-19f4-176ba86000e1@linux.alibaba.com>
Date:   Wed, 19 Aug 2020 15:50:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200819042722.23414.2654.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/8/19 下午12:27, Alexander Duyck 写道:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> In isolate_lru_pages we have an exception path where if we call
> get_page_unless_zero and that succeeds, but TestClearPageLRU fails we call
> put_page. Normally this would be problematic but due to the way that the
> calls are ordered and the fact that we are holding the LRU lock we know
> that the caller must be holding another reference for the page. Since we
> can assume that we can replace the put_page with a call to
> put_page_testzero contained within a WARN_ON. By doing this we should see
> if we ever leak a page as a result of the reference count somehow hitting
> zero when it shouldn't, and can avoid the overhead and confusion of using
> the full put_page call.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  mm/vmscan.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 5bc0c2322043..3ebe3f9b653b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1688,10 +1688,13 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>  
>  			if (!TestClearPageLRU(page)) {
>  				/*
> -				 * This page may in other isolation path,
> -				 * but we still hold lru_lock.
> +				 * This page is being isolated in another
> +				 * thread, but we still hold lru_lock. The
> +				 * other thread must be holding a reference
> +				 * to the page so this should never hit a
> +				 * reference count of 0.
>  				 */
> -				put_page(page);
> +				WARN_ON(put_page_testzero(page));

seems WARN_ON is always enabled.

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>

>  				goto busy;
>  			}
>  
> 
