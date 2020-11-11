Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0387F2AF738
	for <lists+cgroups@lfdr.de>; Wed, 11 Nov 2020 18:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgKKRMe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Nov 2020 12:12:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:35408 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgKKRMe (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 11 Nov 2020 12:12:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51074AC24;
        Wed, 11 Nov 2020 17:12:32 +0000 (UTC)
To:     Alex Shi <alex.shi@linux.alibaba.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
 <1604566549-62481-16-git-send-email-alex.shi@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v21 15/19] mm/compaction: do page isolation first in
 compaction
Message-ID: <a0b8c198-6bd0-2ccb-fe55-970895c26a0b@suse.cz>
Date:   Wed, 11 Nov 2020 18:12:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604566549-62481-16-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/5/20 9:55 AM, Alex Shi wrote:
> Currently, compaction would get the lru_lock and then do page isolation
> which works fine with pgdat->lru_lock, since any page isoltion would
> compete for the lru_lock. If we want to change to memcg lru_lock, we
> have to isolate the page before getting lru_lock, thus isoltion would
> block page's memcg change which relay on page isoltion too. Then we
> could safely use per memcg lru_lock later.
> 
> The new page isolation use previous introduced TestClearPageLRU() +
> pgdat lru locking which will be changed to memcg lru lock later.
> 
> Hugh Dickins <hughd@google.com> fixed following bugs in this patch's
> early version:
> 
> Fix lots of crashes under compaction load: isolate_migratepages_block()
> must clean up appropriately when rejecting a page, setting PageLRU again
> if it had been cleared; and a put_page() after get_page_unless_zero()
> cannot safely be done while holding locked_lruvec - it may turn out to
> be the final put_page(), which will take an lruvec lock when PageLRU.
> And move __isolate_lru_page_prepare back after get_page_unless_zero to
> make trylock_page() safe:
> trylock_page() is not safe to use at this time: its setting PG_locked
> can race with the page being freed or allocated ("Bad page"), and can
> also erase flags being set by one of those "sole owners" of a freshly
> allocated page who use non-atomic __SetPageFlag().
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org

Acked-by: Vlastimil Babka <vbabka@suse.cz>

A question below:

> @@ -979,10 +995,6 @@ static bool too_many_isolated(pg_data_t *pgdat)
>   					goto isolate_abort;
>   			}
>   
> -			/* Recheck PageLRU and PageCompound under lock */
> -			if (!PageLRU(page))
> -				goto isolate_fail;
> -
>   			/*
>   			 * Page become compound since the non-locked check,
>   			 * and it's on LRU. It can only be a THP so the order
> @@ -990,16 +1002,13 @@ static bool too_many_isolated(pg_data_t *pgdat)
>   			 */
>   			if (unlikely(PageCompound(page) && !cc->alloc_contig)) {
>   				low_pfn += compound_nr(page) - 1;
> -				goto isolate_fail;
> +				SetPageLRU(page);
> +				goto isolate_fail_put;
>   			}

IIUC the danger here is khugepaged will collapse a THP. For that, 
__collapse_huge_page_isolate() has to succeed isolate_lru_page(). Under the new 
scheme, it shouldn't be possible, right? If that's correct, we can remove this part?
