Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8F62E06FF
	for <lists+cgroups@lfdr.de>; Tue, 22 Dec 2020 09:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgLVIBF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Dec 2020 03:01:05 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:40078 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgLVIBF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Dec 2020 03:01:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UJQTnsf_1608624020;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UJQTnsf_1608624020)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Dec 2020 16:00:20 +0800
Subject: Re: [PATCH v2 2/3] mm/memcg: remove rcu locking for lock_page_lruvec
 function series
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     hughd@google.com
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hui Su <sh_def@163.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
References: <1608614453-10739-1-git-send-email-alex.shi@linux.alibaba.com>
 <1608614453-10739-2-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <398f089d-250b-39f7-691a-9ce495b30700@linux.alibaba.com>
Date:   Tue, 22 Dec 2020 16:00:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1608614453-10739-2-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Cc: Hui Su and Alexander Duyck as Hugh suggested.

ÔÚ 2020/12/22 ÏÂÎç1:20, Alex Shi Ð´µÀ:
> lock_page_lruvec() and its variants used rcu_read_lock() with the
> intention of safeguarding against the mem_cgroup being destroyed
> concurrently; but so long as they are called under the specified
> conditions (as they are), there is no way for the page's mem_cgroup
> to be destroyed.  Delete the unnecessary rcu_read_lock() and _unlock().
> 
> Hugh Dickin's polished the commit log, Thanks a lot!
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/memcontrol.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8d400efc81b9..0af13c4fe4b3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1356,10 +1356,8 @@ struct lruvec *lock_page_lruvec(struct page *page)
>  	struct lruvec *lruvec;
>  	struct pglist_data *pgdat = page_pgdat(page);
>  
> -	rcu_read_lock();
>  	lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  	spin_lock(&lruvec->lru_lock);
> -	rcu_read_unlock();
>  
>  	lruvec_memcg_debug(lruvec, page);
>  
> @@ -1371,10 +1369,8 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
>  	struct lruvec *lruvec;
>  	struct pglist_data *pgdat = page_pgdat(page);
>  
> -	rcu_read_lock();
>  	lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  	spin_lock_irq(&lruvec->lru_lock);
> -	rcu_read_unlock();
>  
>  	lruvec_memcg_debug(lruvec, page);
>  
> @@ -1386,10 +1382,8 @@ struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
>  	struct lruvec *lruvec;
>  	struct pglist_data *pgdat = page_pgdat(page);
>  
> -	rcu_read_lock();
>  	lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  	spin_lock_irqsave(&lruvec->lru_lock, *flags);
> -	rcu_read_unlock();
>  
>  	lruvec_memcg_debug(lruvec, page);
>  
> 
