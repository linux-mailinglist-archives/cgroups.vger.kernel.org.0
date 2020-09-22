Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A9C273A56
	for <lists+cgroups@lfdr.de>; Tue, 22 Sep 2020 07:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgIVFoV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Sep 2020 01:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbgIVFoV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Sep 2020 01:44:21 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F25C0613CF
        for <cgroups@vger.kernel.org>; Mon, 21 Sep 2020 22:44:21 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id z26so19741025oih.12
        for <cgroups@vger.kernel.org>; Mon, 21 Sep 2020 22:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=VqM0C5aizd06EEJhbPcKDGQSZnlrNdjhm1j3MXU1V80=;
        b=OCgfz6fy1qQPxVmz3FNoiB4+LRJSLY2XeCFt6IARQmhRwm/sfZYsUv+N4gUa7j3oe0
         iI8TK21X75WMXgA/oWIHyWGLTVX/UyWjTkPygXM01E7XHpWRo1ksBgMPlf6Dg2LTWkut
         8iVQ/GrKomUCJyx+l5lRaIE9kijzB/RlhSJMgIA5jx2wW0Ik0QWJxo3N068QOeg7LJ8A
         xca37W+dQsM7pfSykEykegXvuqOnWYf1COCWncsk7ZO8g3gHy7/n1mB0L71KWd2nAjAq
         FmIbVNw/01E9uWvCkYQKreyCjuFeQVtKvYJsbZ4UBJSf6QGj6yO5Kh/S9VcryWOQJlC5
         Vikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=VqM0C5aizd06EEJhbPcKDGQSZnlrNdjhm1j3MXU1V80=;
        b=apgW3yxlOCzvI1p9N5AXKNaKEfeAle2UzK9jagC+5UrHlxqvAKpNW4eYR4mM0c29XO
         cYTImGmRxJfR4FeNc/390dkNuuGqdmBiy1wBRHUG6Sr5MpVuKXxs6dfX5bJESMM1PLIx
         7tGi2/qtzwyo+RSjMH/Edefn0xqLemw/l/OUGGdJaZW0tWrd6o344i4y5rVNKoGoziB7
         LlxzpEi5jVSr8iEwkNMKmP2NW/BjZ5CtwAZ4Fp4NT+K566pzfNViv1c6+6NixqkgPySC
         v/CphsnLQVKpLDVj6mlDIVmsRmx6BYOtLFaGuf2UWlGlG/sRwXkvJ5mmyqtgTHFSNfRF
         OdfA==
X-Gm-Message-State: AOAM533A7i6N38lQDrJ3dSI/38v9f98qgUY7v0vL2dsfz8VuWxNZKvgF
        feNrWZ8ab1rOsCfK6KWYqQaQbg==
X-Google-Smtp-Source: ABdhPJz9mr06E8lR+a9ctR9n2j7lf85iEC1McaCI7ikNKeazb7Qs3U6uP/Z5VvAHxzga9O9Nc8N4/Q==
X-Received: by 2002:aca:d9c2:: with SMTP id q185mr1715051oig.28.1600753460499;
        Mon, 21 Sep 2020 22:44:20 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c19sm8114703ooq.35.2020.09.21.22.44.17
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 21 Sep 2020 22:44:19 -0700 (PDT)
Date:   Mon, 21 Sep 2020 22:44:16 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v18 22/32] mm/vmscan: use relock for move_pages_to_lru
In-Reply-To: <1598273705-69124-23-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2009212240370.6434@eggly.anvils>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com> <1598273705-69124-23-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 24 Aug 2020, Alex Shi wrote:

> From: Hugh Dickins <hughd@google.com>
> 
> Use the relock function to replace relocking action. And try to save few
> lock times.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

NAK. Who wrote this rubbish? Oh, did I? Maybe something you extracted
from my tarball. No, we don't need any of this now, as explained when
going through 20/32.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: cgroups@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  mm/vmscan.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2c94790d4cb1..04ef94190530 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1848,15 +1848,15 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  	enum lru_list lru;
>  
>  	while (!list_empty(list)) {
> -		struct lruvec *new_lruvec = NULL;
> -
>  		page = lru_to_page(list);
>  		VM_BUG_ON_PAGE(PageLRU(page), page);
>  		list_del(&page->lru);
>  		if (unlikely(!page_evictable(page))) {
> -			spin_unlock_irq(&lruvec->lru_lock);
> +			if (lruvec) {
> +				spin_unlock_irq(&lruvec->lru_lock);
> +				lruvec = NULL;
> +			}
>  			putback_lru_page(page);
> -			spin_lock_irq(&lruvec->lru_lock);
>  			continue;
>  		}
>  
> @@ -1871,12 +1871,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  		 *     list_add(&page->lru,)
>  		 *                                        list_add(&page->lru,)
>  		 */
> -		new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> -		if (new_lruvec != lruvec) {
> -			if (lruvec)
> -				spin_unlock_irq(&lruvec->lru_lock);
> -			lruvec = lock_page_lruvec_irq(page);
> -		}
> +		lruvec = relock_page_lruvec_irq(page, lruvec);
>  		SetPageLRU(page);
>  
>  		if (unlikely(put_page_testzero(page))) {
> @@ -1885,8 +1880,8 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  
>  			if (unlikely(PageCompound(page))) {
>  				spin_unlock_irq(&lruvec->lru_lock);
> +				lruvec = NULL;
>  				destroy_compound_page(page);
> -				spin_lock_irq(&lruvec->lru_lock);
>  			} else
>  				list_add(&page->lru, &pages_to_free);
>  
> -- 
> 1.8.3.1
