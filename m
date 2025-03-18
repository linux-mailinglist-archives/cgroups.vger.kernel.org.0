Return-Path: <cgroups+bounces-7111-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B16CA6645A
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 01:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E323F1899B41
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 00:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A45D126C02;
	Tue, 18 Mar 2025 00:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R9V8cBJw"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2849D14900F
	for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 00:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742259535; cv=none; b=kycUA9N4mj9eOiGVin4I0Van09ueIGiBxyGW3mBy/ZicRVbIO2wuhQIBXQaO3PQfUXoDOEKhw70JwWmavf3LK/yYGiqTg3qrLPlqwlE1sA/7ylg6oMDTO7cPOxafUH1TEgcX7CATy4UvNxHtLk2EVhiYloDt5p2fQl8dg2MLpOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742259535; c=relaxed/simple;
	bh=+LA0Pxbp+49RwYsU6oTKqhnfhU+aXclP/UDJchls5Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJ+6fzwfHHWDAlno8gsqbSsuxIue8lxq56xDXiud0h5uqbqDtQl+mbmO/YyuExV/O/g86ZCVPksezI4U9uwca1pCe2sqZhzUyKz7uEnMyPUb98NvExD+ao7APMQBeysU8AOObeX6fXFE+ZZNHItdu9+0ci8GxneBg6XXyCAM7Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R9V8cBJw; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 18 Mar 2025 00:58:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742259520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cP0s4VETbk8t0bBy6Octd+t99xFNYIjMSoL8GoR+Dok=;
	b=R9V8cBJwgDwVeOohEDJts4r7UTTfSFY5leoQ5bxE0kKt+0VAIZi5jhZnm8DQ8z4aoYgrw8
	OvmiGMSDV9FWurOe6F9T/1NRxnEeIaIhXFn7vuDKGZgOziWCzjLZM+f7aDuVh8EJOXxXMf
	2pKYnc0v/9XqK+Nusf9BRDY/h0XgdjM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 4/9] memcg: manually inline __refill_stock
Message-ID: <Z9jFPP7HsTzs_aW0@google.com>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315174930.1769599-5-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315174930.1769599-5-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 15, 2025 at 10:49:25AM -0700, Shakeel Butt wrote:
> There are no more multiple callers of __refill_stock(), so simply inline
> it to refill_stock().
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/memcontrol.c | 32 ++++++++++++--------------------
>  1 file changed, 12 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b54e3a1d23bd..7054b0ebd207 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1865,14 +1865,21 @@ static void drain_local_stock(struct work_struct *dummy)
>  	obj_cgroup_put(old);
>  }
>  
> -/*
> - * Cache charges(val) to local per_cpu area.
> - * This will be consumed by consume_stock() function, later.
> - */
> -static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
> +/* Should never be called with root_mem_cgroup. */

How about adding something like this?

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 768d6b15dbfa..5c26002f2168 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1881,6 +1881,8 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
        unsigned long flags;

+       VM_WARN_ON_ONCE(mem_cgroup_is_root(memcg));
+
        local_lock_irqsave(&memcg_stock.stock_lock, flags);
        __refill_stock(memcg, nr_pages);
        local_unlock_irqrestore(&memcg_stock.stock_lock, flags);


Other than that,
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

