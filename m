Return-Path: <cgroups+bounces-7766-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CB1A99B0B
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 23:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0D45A675F
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 21:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF39020010C;
	Wed, 23 Apr 2025 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a8b0MZA8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489D82701CA;
	Wed, 23 Apr 2025 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745445554; cv=none; b=EMUA1UEuMQBD/G5uEA7i0bvZCWK6qYcpXfhou4lSih0Xqk2vuApolFkjcwbDidAbaKWZgDVZSynaN8L2kQyiO+rbhVOOK/+BEIHd/w1oKsNlbm88TDA2hW+XLPu2mjqJdh85f+qfTV68Ogzuka/ajyWvLUrTP6V5JDTWd4wW+Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745445554; c=relaxed/simple;
	bh=Miz9NzWnAK/CmNDcN+idx6rTUbeCo5M/yRi7KWMyvNo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QWDGw4+7CKe0XhSzh9h4IQzHNKnDuA5tUWAZPiD4rIHhVeEIxN0V0kUu6NuJhc3P7vU1ZeUQhWMB4SGoDQDNpA4ER3aKEaNy713TLGVwloKYlXWRn+THYBa0iOoUSW+nUouzfo2mVE4KHUvrsCjeBPONWJRlD8DltTmmRjEgq8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=a8b0MZA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B2FC4CEE2;
	Wed, 23 Apr 2025 21:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1745445553;
	bh=Miz9NzWnAK/CmNDcN+idx6rTUbeCo5M/yRi7KWMyvNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a8b0MZA8XSIoNLMnm+Ac5ypsUHn8EM7NNXSX+bVAWtewvIavk7rAlPbeurLfchJfB
	 3HSdgyJjsG3+NvIZtYC/T95BvvbKz5jqOxaOYTQgwRbAinynQAQelaf1UTaoevSNOE
	 WsBgGp1yw7GGL68uNUm8hN0x/9wUEuU8uTCRRPAk=
Date: Wed, 23 Apr 2025 14:59:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Huan Yang <link@vivo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
 <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
Subject: Re: [PATCH 1/2] mm/memcg: use kmem_cache when alloc memcg
Message-Id: <20250423145912.3e0062864b6969b3623c8ff6@linux-foundation.org>
In-Reply-To: <20250423084306.65706-2-link@vivo.com>
References: <20250423084306.65706-1-link@vivo.com>
	<20250423084306.65706-2-link@vivo.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 16:43:04 +0800 Huan Yang <link@vivo.com> wrote:

> @@ -3652,7 +3654,10 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
>  	int __maybe_unused i;
>  	long error;
>  
> -	memcg = kzalloc(struct_size(memcg, nodeinfo, nr_node_ids), GFP_KERNEL);
> +	memcg = likely(memcg_cachep) ?
> +			kmem_cache_zalloc(memcg_cachep, GFP_KERNEL) :
> +			kzalloc(struct_size(memcg, nodeinfo, nr_node_ids),
> +				GFP_KERNEL);

Why are we testing for memcg_cachep=NULL?

> @@ -5055,6 +5061,10 @@ static int __init mem_cgroup_init(void)
>  		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
>  			  drain_local_stock);
>  
> +	memcg_size = struct_size_t(struct mem_cgroup, nodeinfo, nr_node_ids);
> +	memcg_cachep = kmem_cache_create("mem_cgroup", memcg_size, 0,
> +					 SLAB_PANIC | SLAB_HWCACHE_ALIGN, NULL);

If it's because this allocation might have failed then let's not
bother.  If an __init-time allocation failed, this kernel is unusable
anyway.



