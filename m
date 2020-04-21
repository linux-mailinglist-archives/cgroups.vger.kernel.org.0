Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280A91B2192
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 10:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgDUI3c (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Apr 2020 04:29:32 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:40828 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbgDUI3b (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Apr 2020 04:29:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TwDHj5a_1587457757;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TwDHj5a_1587457757)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Apr 2020 16:29:17 +0800
Subject: Re: [PATCH 01/18] mm: fix NUMA node file count error in
 replace_page_cache()
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
 <20200420221126.341272-2-hannes@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <c5c379d5-d580-58ec-c9d1-f05d6cdc57b4@linux.alibaba.com>
Date:   Tue, 21 Apr 2020 16:28:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420221126.341272-2-hannes@cmpxchg.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/4/21 ÉÏÎç6:11, Johannes Weiner Ð´µÀ:
> When replacing one page with another one in the cache, we have to
> decrease the file count of the old page's NUMA node and increase the
> one of the new NUMA node, otherwise the old node leaks the count and
> the new node eventually underflows its counter.
> 
> Fixes: 74d609585d8b ("page cache: Add and replace pages using the XArray")
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>

> ---
>  mm/filemap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 23a051a7ef0f..49e3b5da0216 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -808,11 +808,11 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask)
>  	old->mapping = NULL;
>  	/* hugetlb pages do not participate in page cache accounting. */
>  	if (!PageHuge(old))
> -		__dec_node_page_state(new, NR_FILE_PAGES);
> +		__dec_node_page_state(old, NR_FILE_PAGES);
>  	if (!PageHuge(new))
>  		__inc_node_page_state(new, NR_FILE_PAGES);
>  	if (PageSwapBacked(old))
> -		__dec_node_page_state(new, NR_SHMEM);
> +		__dec_node_page_state(old, NR_SHMEM);
>  	if (PageSwapBacked(new))
>  		__inc_node_page_state(new, NR_SHMEM);
>  	xas_unlock_irqrestore(&xas, flags);
> 
