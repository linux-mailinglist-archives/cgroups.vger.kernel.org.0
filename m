Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305381D76B0
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2020 13:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgERLS7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 May 2020 07:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgERLS6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 May 2020 07:18:58 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EC9C061A0C;
        Mon, 18 May 2020 04:18:58 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n11so4647468pgl.9;
        Mon, 18 May 2020 04:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fAEtST8it9y3Jfre9o9oyKCGxnCx5adRG8P+6yLwwis=;
        b=bYuxNSy0mFLe5uddMp3pxXj5gpk9EIwKmV2Jz6OmMfoKg0OLtKscTLNkYPsvHRrLzH
         ICl9UewF27897C1ez01XzJWRT8iQXzBMZ7X4fZEiZ7fbhWPZAwiD9tGjCaybIkrkq19o
         sKoPqKPJ9zyqUHx1TvUIlPZY2Ur/DsvbuBsU6hmOBoZn4X2mGdUjj36ENkq09q2LbH9a
         vmlpQMKhH/pHWLmyQDl41B+dnZRT0voT/JY+JZWRQ7nVENxmmNeGMsbT2iXkCb9q1VRZ
         +qObI95Vntet1/Zqz+H/TbQ93xr5G4rQht8eVKyk5ucfkk8oHR68PJAxAI4Mq6gWm55j
         yX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fAEtST8it9y3Jfre9o9oyKCGxnCx5adRG8P+6yLwwis=;
        b=GlokXYXOc1AxfW1VLorLS4Bt42OCV8fJY1TL7Rln5vuqXCXD5Aj65n9BjG98xGZE8a
         sl13bzoiDaFcCM5pp7HDkyditi6MN5AC/Efo4ek22+VJOwQhTGSk7cW2fyqOHKMWXBi5
         pCBhyrmmdsqFrUU/o5wN4nueeklXy7zN8HS+VAJWVvycRdq0ScdpOllAvPDiUuu3k00D
         NlvCUALdAvrnW0IXtf1qvLwW9oFpCsmBYUTGYSg+3c8HL3HQkxsq0BjWAQLLmwJGC6am
         Zr6jIaR7cpUBYDSgSkt1TuFyAfV0AjRJF386qMRfvKp+HHurFK6Fz0UMIrqFG7aJxI4c
         y2Rw==
X-Gm-Message-State: AOAM533OJJqq+wovtzZ4TAplLlFbIAYgTQo0O/I3cQf9sFAerC6pkfTG
        99b60qMKdpkjQXy4N4Hp/BTcbTgggevCPw==
X-Google-Smtp-Source: ABdhPJyYdSrXy9kUnNolrBcjxaV55RBVl/+PV8BHvF7WKCf2aUAUJTi0X4Df3zJcxMj++vuILIwOZw==
X-Received: by 2002:a63:64b:: with SMTP id 72mr14873235pgg.437.1589800738334;
        Mon, 18 May 2020 04:18:58 -0700 (PDT)
Received: from dev-dsk-sblbir-1c-a524888b.ap-northeast-1.amazon.com ([27.0.3.145])
        by smtp.gmail.com with ESMTPSA id g1sm8214774pfo.142.2020.05.18.04.18.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 04:18:54 -0700 (PDT)
From:   Balbir Singh <bsingharora@gmail.com>
X-Google-Original-From: Balbir Singh <sblbir@dev-dsk-sblbir-1c-a524888b.ap-northeast-1.amazon.com>
Date:   Mon, 18 May 2020 11:18:50 +0000
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 01/19] mm: fix NUMA node file count error in
 replace_page_cache()
Message-ID: <20200518111850.GA107644@dev-dsk-sblbir-1c-a524888b.ap-northeast-1.amazon.com>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
 <20200508183105.225460-2-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508183105.225460-2-hannes@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 08, 2020 at 02:30:48PM -0400, Johannes Weiner wrote:
> When replacing one page with another one in the cache, we have to
> decrease the file count of the old page's NUMA node and increase the
> one of the new NUMA node, otherwise the old node leaks the count and
> the new node eventually underflows its counter.
> 
> Fixes: 74d609585d8b ("page cache: Add and replace pages using the XArray")
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  mm/filemap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index af1c6adad5bd..2b057b0aa882 100644
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


Reviewed-by: Balbir Singh <bsingharora@gmail.com>
