Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933A53102FE
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 03:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhBECye (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Feb 2021 21:54:34 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12078 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhBECyb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Feb 2021 21:54:31 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DX0Lv3v6HzMVNg;
        Fri,  5 Feb 2021 10:52:07 +0800 (CST)
Received: from [10.174.179.241] (10.174.179.241) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 10:53:43 +0800
Subject: Re: [PATCH v2] mm: memcontrol: replace the loop with a
 list_for_each_entry()
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <hannes@cmpxchg.org>,
        <mhocko@kernel.org>, <vdavydov.dev@gmail.com>,
        <akpm@linux-foundation.org>
References: <20210204163055.56080-1-songmuchun@bytedance.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6f8d9e82-5903-e983-8c93-9dfe3e9b14ca@huawei.com>
Date:   Fri, 5 Feb 2021 10:53:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210204163055.56080-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi:
On 2021/2/5 0:30, Muchun Song wrote:
> The rule of list walk has gone since:
> 
>  commit a9d5adeeb4b2 ("mm/memcontrol: allow to uncharge page without using page->lru field")
> 
> So remove the strange comment and replace the loop with a
> list_for_each_entry().
> 
> There is only one caller of the uncharge_list(). So just fold it into
> mem_cgroup_uncharge_list() and remove it.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

LGTM. Thanks.
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
> v2:
>  - Fold uncharge_list() to mem_cgroup_uncharge_list().
> 
>  mm/memcontrol.c | 35 ++++++++---------------------------
>  1 file changed, 8 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ed5cc78a8dbf..8c035846c7a4 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6862,31 +6862,6 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  	css_put(&ug->memcg->css);
>  }
>  
> -static void uncharge_list(struct list_head *page_list)
> -{
> -	struct uncharge_gather ug;
> -	struct list_head *next;
> -
> -	uncharge_gather_clear(&ug);
> -
> -	/*
> -	 * Note that the list can be a single page->lru; hence the
> -	 * do-while loop instead of a simple list_for_each_entry().
> -	 */
> -	next = page_list->next;
> -	do {
> -		struct page *page;
> -
> -		page = list_entry(next, struct page, lru);
> -		next = page->lru.next;
> -
> -		uncharge_page(page, &ug);
> -	} while (next != page_list);
> -
> -	if (ug.memcg)
> -		uncharge_batch(&ug);
> -}
> -
>  /**
>   * mem_cgroup_uncharge - uncharge a page
>   * @page: page to uncharge
> @@ -6918,11 +6893,17 @@ void mem_cgroup_uncharge(struct page *page)
>   */
>  void mem_cgroup_uncharge_list(struct list_head *page_list)
>  {
> +	struct uncharge_gather ug;
> +	struct page *page;
> +
>  	if (mem_cgroup_disabled())
>  		return;
>  
> -	if (!list_empty(page_list))
> -		uncharge_list(page_list);
> +	uncharge_gather_clear(&ug);
> +	list_for_each_entry(page, page_list, lru)
> +		uncharge_page(page, &ug);
> +	if (ug.memcg)
> +		uncharge_batch(&ug);
>  }
>  
>  /**
> 

