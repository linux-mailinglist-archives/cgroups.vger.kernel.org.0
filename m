Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3525A216C6D
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2020 14:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgGGMAp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Jul 2020 08:00:45 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:42670 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726900AbgGGMAp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Jul 2020 08:00:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0U20KAQo_1594123241;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U20KAQo_1594123241)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Jul 2020 20:00:42 +0800
Subject: Re: [PATCH v15 05/21] mm/thp: move lru_add_page_tail func to
 huge_memory.c
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        "Kirill A. Shutemov" <kirill@shutemov.name>
References: <1594122412-28057-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594122412-28057-6-git-send-email-alex.shi@linux.alibaba.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <9fa2cf92-c4a0-02ca-1f02-7ef71952de18@linux.alibaba.com>
Date:   Tue, 7 Jul 2020 20:00:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1594122412-28057-6-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/7/7 ÏÂÎç7:46, Alex Shi Ð´µÀ:
>  
> +static void lru_add_page_tail(struct page *page, struct page *page_tail,
> +				struct lruvec *lruvec, struct list_head *list)
> +{
> +	VM_BUG_ON_PAGE(!PageHead(page), page);
> +	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
> +	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
> +	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
> +
> +	if (!list)
> +		SetPageLRU(page_tail);
> +
> +	if (likely(PageLRU(page)))
> +		list_add_tail(&page_tail->lru, &page->lru);
> +	else if (list) {
> +		/* page reclaim is reclaiming a huge page */
> +		get_page(page_tail);
> +		list_add_tail(&page_tail->lru, list);
> +	} else {
> +		/*
> +		 * Head page has not yet been counted, as an hpage,
> +		 * so we must account for each subpage individually.
> +		 *
> +		 * Put page_tail on the list at the correct position
> +		 * so they all end up in order.
> +		 */
> +		add_page_to_lru_list_tail(page_tail, lruvec,
> +					  page_lru(page_tail));


I missed some points for this function, since in the call chain:
split_huge_page() to lru_add_page_tail, the head page's lru won't be
set when !PageLRU(head). But the other page_tail are add to lru list here
Is it ok for this situation?

Thanks!
Alex

> +	}
> +}
