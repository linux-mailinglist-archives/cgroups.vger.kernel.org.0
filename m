Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC241B228E
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 11:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgDUJWK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Apr 2020 05:22:10 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:46602 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725920AbgDUJWK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Apr 2020 05:22:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TwDn7z8_1587460926;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TwDn7z8_1587460926)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Apr 2020 17:22:07 +0800
Subject: Re: [PATCH 18/18] mm: memcontrol: update page->mem_cgroup stability
 rules
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <js1304@gmail.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-19-hannes@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <1f905391-5676-2db6-efb9-74ade130740e@linux.alibaba.com>
Date:   Tue, 21 Apr 2020 17:20:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420221126.341272-19-hannes@cmpxchg.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/4/21 ÉÏÎç6:11, Johannes Weiner Ð´µÀ:
> The previous patches have simplified the access rules around
> page->mem_cgroup somewhat:
> 
> 1. We never change page->mem_cgroup while the page is isolated by
>    somebody else. This was by far the biggest exception to our rules
>    and it didn't stop at lock_page() or lock_page_memcg().
> 
> 2. We charge pages before they get put into page tables now, so the
>    somewhat fishy rule about "can be in page table as long as it's
>    still locked" is now gone and boiled down to having an exclusive
>    reference to the page.
> 
> Document the new rules. Any of the following will stabilize the
> page->mem_cgroup association:
> 
> - the page lock
> - LRU isolation
> - lock_page_memcg()
> - exclusive access to the page
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>

> ---
>  mm/memcontrol.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a8cce52b6b4d..7b63260c9b57 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1201,9 +1201,8 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>   * @page: the page
>   * @pgdat: pgdat of the page
>   *
> - * This function is only safe when following the LRU page isolation
> - * and putback protocol: the LRU lock must be held, and the page must
> - * either be PageLRU() or the caller must have isolated/allocated it.
> + * This function relies on page->mem_cgroup being stable - see the
> + * access rules in commit_charge().
>   */
>  struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgdat)
>  {
> @@ -2605,18 +2604,12 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg)
>  {
>  	VM_BUG_ON_PAGE(page->mem_cgroup, page);
>  	/*
> -	 * Nobody should be changing or seriously looking at
> -	 * page->mem_cgroup at this point:
> -	 *
> -	 * - the page is uncharged
> -	 *
> -	 * - the page is off-LRU
> -	 *
> -	 * - an anonymous fault has exclusive page access, except for
> -	 *   a locked page table
> +	 * Any of the following ensures page->mem_cgroup stability:
>  	 *
> -	 * - a page cache insertion, a swapin fault, or a migration
> -	 *   have the page locked
> +	 * - the page lock
> +	 * - LRU isolation
> +	 * - lock_page_memcg()
> +	 * - exclusive reference
>  	 */
>  	page->mem_cgroup = memcg;
>  }
> 
