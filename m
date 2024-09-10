Return-Path: <cgroups+bounces-4792-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CC2972C18
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 10:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8600B22005
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 08:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B42184555;
	Tue, 10 Sep 2024 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PU4UCaKr"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA9617BB08
	for <cgroups@vger.kernel.org>; Tue, 10 Sep 2024 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725956805; cv=none; b=tNqUWPfUAxX/G4Vpzxff6IdweDBlqdc5MiBHY36bwDUGaY2zAGGxpl0qbdvyGG1kD4lXc2GVD3JtOk/z6O11xl+1A4IuFdISlmmxwXVEHHhNNuyrPhm7397NFI3ifh2mBQjIXDpvkN9D/JTHb13gle14rZVRRUhG/Nf/HiNaFg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725956805; c=relaxed/simple;
	bh=8DG7C71HXbYIpYYP7/gjnqoOvPL7kjOkH44Sjm6b5GY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bUAjtHUJRBQuhCERIShKnxaEYCsSvwyxV7WuLjkynMQ2tPJuUVQK7w7WnhEc9DO2l4Fomcu3ta+A6IpgYyjVQS8YZgrpjFRb9bEJARX6KfoUWUjEDF10hauAPz3c3rFOuaIPK88QkPUW3EPwGc3LJZc1jq7WhZgm9NBh2cYerQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PU4UCaKr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725956801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/f3xKucSZstOyu20HXtUEhNFbLGLB7gxrDvpwkC6hI=;
	b=PU4UCaKrl78Q/0w/p0K2MGJxU8lQza3qdrPZDvtXFHXDJHsWldaKl+sZQ6GpbVwojrOGZb
	wn62kunHAl+gL5PXBtwxJTxTsdqmye9jsf3X6shjQujlvZvZr++loV2ec4HVyB0gFoI7Fe
	QcPU72Y8lFQsHpOHz4Wyfr87qjkGlyA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-xQ_FI2ZLN4SzueHak75ivA-1; Tue, 10 Sep 2024 04:26:40 -0400
X-MC-Unique: xQ_FI2ZLN4SzueHak75ivA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb0ed9072so23931565e9.1
        for <cgroups@vger.kernel.org>; Tue, 10 Sep 2024 01:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725956799; x=1726561599;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/f3xKucSZstOyu20HXtUEhNFbLGLB7gxrDvpwkC6hI=;
        b=vrsm3IbAr8sNEGXUwsJ4Z0nT5g+IJovBVQxOSTvSQuWl28IEKVBvjNk1w/CL5iDtW7
         /ERNUOJy+D7YyThbcCzqzA9c6FbNZ7QHXvKte7ZIlfP3oj45sS5erhApxJq40HUr4eoT
         X3YWjWTbGypCSioZD9LKmnwB6RXZ9kOKEDWWQa+kOdFocF8JV9VAyzyGgbweuzQLXKfA
         WSBuLFfkdjN9HhK/rCjXLGGcmJy2UjybzdjLJ9ZwIKDgIQmBdwkBPaJX1iVigYy/a72t
         +TN/l/cKQRLZeGUoBWe2wfzO01XuK2udX3OQyD65p7SdzTS7sJzjKMYg5sFkm8Z9mu2x
         wo4g==
X-Forwarded-Encrypted: i=1; AJvYcCV0GIvJPxkZpWVDNzOms+A6dL3iwsbUBxqaVaMbY24VuJAVGSabCnKzXjYP1dEUmk2P5uUQ+u9g@vger.kernel.org
X-Gm-Message-State: AOJu0YyFyu3ZAB17MPmDzj8hxvd0GeBx70Wp9flRkInxJtpAeaEVR0Fm
	rD597up66uByskQEhHQeqdIEOVf8V13ziZZkwbgzv+jWd6SP+Fl32PAeHfQ2PhReRPOW5DWFckL
	5xTRCTCkh0wC7hJavdwox9MUIJ01DoTQq/LZs7YNXPVPBXji26aRrb/A=
X-Received: by 2002:a05:600c:34ce:b0:42c:aeaa:6b0d with SMTP id 5b1f17b1804b1-42caeaa6d63mr87920345e9.9.1725956799121;
        Tue, 10 Sep 2024 01:26:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEDyrPSKH2mkRn9e1Vet7iGJS2hDUtsGPa3BCEFXCXiRlZt2EERC3XThHVOSGVofUnbC+P5A==
X-Received: by 2002:a05:600c:34ce:b0:42c:aeaa:6b0d with SMTP id 5b1f17b1804b1-42caeaa6d63mr87919835e9.9.1725956798487;
        Tue, 10 Sep 2024 01:26:38 -0700 (PDT)
Received: from [192.168.88.27] (146-241-69-130.dyn.eolo.it. [146.241.69.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb43d73sm105918415e9.24.2024.09.10.01.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 01:26:38 -0700 (PDT)
Message-ID: <5d48fe26-1e18-4941-99d4-8c03e83f5e76@redhat.com>
Date: Tue, 10 Sep 2024 10:26:36 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v4] memcg: add charging of already allocated slab objects
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, David Rientjes <rientjes@google.com>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240905173422.1565480-1-shakeel.butt@linux.dev>
Content-Language: en-US
In-Reply-To: <20240905173422.1565480-1-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 19:34, Shakeel Butt wrote:
> At the moment, the slab objects are charged to the memcg at the
> allocation time. However there are cases where slab objects are
> allocated at the time where the right target memcg to charge it to is
> not known. One such case is the network sockets for the incoming
> connection which are allocated in the softirq context.
> 
> Couple hundred thousand connections are very normal on large loaded
> server and almost all of those sockets underlying those connections get
> allocated in the softirq context and thus not charged to any memcg.
> However later at the accept() time we know the right target memcg to
> charge. Let's add new API to charge already allocated objects, so we can
> have better accounting of the memory usage.
> 
> To measure the performance impact of this change, tcp_crr is used from
> the neper [1] performance suite. Basically it is a network ping pong
> test with new connection for each ping pong.
> 
> The server and the client are run inside 3 level of cgroup hierarchy
> using the following commands:
> 
> Server:
>   $ tcp_crr -6
> 
> Client:
>   $ tcp_crr -6 -c -H ${server_ip}
> 
> If the client and server run on different machines with 50 GBPS NIC,
> there is no visible impact of the change.
> 
> For the same machine experiment with v6.11-rc5 as base.
> 
>            base (throughput)     with-patch
> tcp_crr   14545 (+- 80)         14463 (+- 56)
> 
> It seems like the performance impact is within the noise.
> 
> Link: https://github.com/google/neper [1]
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
> v3: https://lore.kernel.org/all/20240829175339.2424521-1-shakeel.butt@linux.dev/
> Changes since v3:
> - Add kernel doc for kmem_cache_charge.
> 
> v2: https://lore.kernel.org/all/20240827235228.1591842-1-shakeel.butt@linux.dev/
> Change since v2:
> - Add handling of already charged large kmalloc objects.
> - Move the normal kmalloc cache check into a function.
> 
> v1: https://lore.kernel.org/all/20240826232908.4076417-1-shakeel.butt@linux.dev/
> Changes since v1:
> - Correctly handle large allocations which bypass slab
> - Rearrange code to avoid compilation errors for !CONFIG_MEMCG builds
> 
> RFC: https://lore.kernel.org/all/20240824010139.1293051-1-shakeel.butt@linux.dev/
> Changes since the RFC:
> - Added check for already charged slab objects.
> - Added performance results from neper's tcp_crr
> 
> 
>   include/linux/slab.h            | 20 ++++++++++++++
>   mm/slab.h                       |  7 +++++
>   mm/slub.c                       | 49 +++++++++++++++++++++++++++++++++
>   net/ipv4/inet_connection_sock.c |  5 ++--
>   4 files changed, 79 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index eb2bf4629157..68789c79a530 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -547,6 +547,26 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
>   			    gfp_t gfpflags) __assume_slab_alignment __malloc;
>   #define kmem_cache_alloc_lru(...)	alloc_hooks(kmem_cache_alloc_lru_noprof(__VA_ARGS__))
>   
> +/**
> + * kmem_cache_charge - memcg charge an already allocated slab memory
> + * @objp: address of the slab object to memcg charge.
> + * @gfpflags: describe the allocation context
> + *
> + * kmem_cache_charge is the normal method to charge a slab object to the current
> + * memcg. The objp should be pointer returned by the slab allocator functions
> + * like kmalloc or kmem_cache_alloc. The memcg charge behavior can be controller
> + * through gfpflags parameter.
> + *
> + * There are several cases where it will return true regardless. More
> + * specifically:
> + *
> + * 1. For !CONFIG_MEMCG or cgroup_disable=memory systems.
> + * 2. Already charged slab objects.
> + * 3. For slab objects from KMALLOC_NORMAL caches.
> + *
> + * Return: true if charge was successful otherwise false.
> + */
> +bool kmem_cache_charge(void *objp, gfp_t gfpflags);
>   void kmem_cache_free(struct kmem_cache *s, void *objp);
>   
>   kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
> diff --git a/mm/slab.h b/mm/slab.h
> index dcdb56b8e7f5..9f907e930609 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -443,6 +443,13 @@ static inline bool is_kmalloc_cache(struct kmem_cache *s)
>   	return (s->flags & SLAB_KMALLOC);
>   }
>   
> +static inline bool is_kmalloc_normal(struct kmem_cache *s)
> +{
> +	if (!is_kmalloc_cache(s))
> +		return false;
> +	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT));
> +}
> +
>   /* Legal flag mask for kmem_cache_create(), for various configurations */
>   #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
>   			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
> diff --git a/mm/slub.c b/mm/slub.c
> index c9d8a2497fd6..3f2a89f7a23a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2185,6 +2185,41 @@ void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
>   
>   	__memcg_slab_free_hook(s, slab, p, objects, obj_exts);
>   }
> +
> +static __fastpath_inline
> +bool memcg_slab_post_charge(void *p, gfp_t flags)
> +{
> +	struct slabobj_ext *slab_exts;
> +	struct kmem_cache *s;
> +	struct folio *folio;
> +	struct slab *slab;
> +	unsigned long off;
> +
> +	folio = virt_to_folio(p);
> +	if (!folio_test_slab(folio)) {
> +		return folio_memcg_kmem(folio) ||
> +			(__memcg_kmem_charge_page(folio_page(folio, 0), flags,
> +						  folio_order(folio)) == 0);
> +	}
> +
> +	slab = folio_slab(folio);
> +	s = slab->slab_cache;
> +
> +	/* Ignore KMALLOC_NORMAL cache to avoid circular dependency. */
> +	if (is_kmalloc_normal(s))
> +		return true;
> +
> +	/* Ignore already charged objects. */
> +	slab_exts = slab_obj_exts(slab);
> +	if (slab_exts) {
> +		off = obj_to_index(s, slab, p);
> +		if (unlikely(slab_exts[off].objcg))
> +			return true;
> +	}
> +
> +	return __memcg_slab_post_alloc_hook(s, NULL, flags, 1, &p);
> +}
> +
>   #else /* CONFIG_MEMCG */
>   static inline bool memcg_slab_post_alloc_hook(struct kmem_cache *s,
>   					      struct list_lru *lru,
> @@ -2198,6 +2233,11 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
>   					void **p, int objects)
>   {
>   }
> +
> +static inline bool memcg_slab_post_charge(void *p, gfp_t flags)
> +{
> +	return true;
> +}
>   #endif /* CONFIG_MEMCG */
>   
>   /*
> @@ -4062,6 +4102,15 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
>   }
>   EXPORT_SYMBOL(kmem_cache_alloc_lru_noprof);
>   
> +bool kmem_cache_charge(void *objp, gfp_t gfpflags)
> +{
> +	if (!memcg_kmem_online())
> +		return true;
> +
> +	return memcg_slab_post_charge(objp, gfpflags);
> +}
> +EXPORT_SYMBOL(kmem_cache_charge);
> +
>   /**
>    * kmem_cache_alloc_node - Allocate an object on the specified node
>    * @s: The cache to allocate from.
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index 64d07b842e73..3c13ca8c11fb 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -715,6 +715,7 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
>   	release_sock(sk);
>   	if (newsk && mem_cgroup_sockets_enabled) {
>   		int amt = 0;
> +		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
>   
>   		/* atomically get the memory usage, set and charge the
>   		 * newsk->sk_memcg.
> @@ -731,8 +732,8 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
>   		}
>   
>   		if (amt)
> -			mem_cgroup_charge_skmem(newsk->sk_memcg, amt,
> -						GFP_KERNEL | __GFP_NOFAIL);
> +			mem_cgroup_charge_skmem(newsk->sk_memcg, amt, gfp);
> +		kmem_cache_charge(newsk, gfp);
>   
>   		release_sock(newsk);
>   	}

The networking bits looks sane to me - with a very minor nit about the 
reverse xmas tree order in variables declaration above.

Acked-by: Paolo Abeni <pabeni@redhat.com>


