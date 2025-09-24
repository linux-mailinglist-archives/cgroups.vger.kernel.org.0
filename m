Return-Path: <cgroups+bounces-10430-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0916B99DE6
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 14:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828D73B4BFC
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 12:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F052FDC25;
	Wed, 24 Sep 2025 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZShnzjuv"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0236C2417C2
	for <cgroups@vger.kernel.org>; Wed, 24 Sep 2025 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717526; cv=none; b=qbrE8S9KZXr+s+tIXcxXNuU9Cg40szje7gnkUybmpd7haKRqQ5C6b9J8Z7s6yHNMt9gqTx6Fl0+tq+P32ZCsQ77LeUZPDN4/BevO+djOdpzWKcpRgdEyoHqTi5oSwxgXYJQs8AHLKeGUeupksYm6j2B90FI+TUt1uvVCIEV8Ecs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717526; c=relaxed/simple;
	bh=+4ZKfWEcexel5KoU1Ye0etPWmee3qFMkby77GOlb2Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mc9uTy0dPVr/9xCFtYDStc6f/qLbytOFoQLoUzhosrXmU4hzC6Ot/jwKd2qIUbGN2o9SGnUwhk2Y9CBDihKOwVqZ79P1MDRUHnvPIa4PamCui1YpMcPlGWgMnG0VKfjNQ//OGRkg2ariCXscvARXnt4iN7tDnLb8tWD39+JKY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZShnzjuv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758717523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aPF6Jvl0Op5T7a596f1x716IHLymgMCe8uM8IFM2SCQ=;
	b=ZShnzjuvndEzIbuPFBQRHzZo7tqGw0XzVnZpMEt9n6U5iurYvtT7TSq2GEDztGb2AqM4YF
	LzbVftl0LTaQ2qzhDblD03eVxLfoljC08rniAdDLt3G/fJAWha7VzuvJvmrGB9pTma/GuU
	ZiHJQQBmIUT7rPobWc2mKhxdPef/yNI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-Ou-LV6xbOV-0W4QLyLj8dg-1; Wed, 24 Sep 2025 08:38:42 -0400
X-MC-Unique: Ou-LV6xbOV-0W4QLyLj8dg-1
X-Mimecast-MFC-AGG-ID: Ou-LV6xbOV-0W4QLyLj8dg_1758717520
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso29302005e9.2
        for <cgroups@vger.kernel.org>; Wed, 24 Sep 2025 05:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758717520; x=1759322320;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aPF6Jvl0Op5T7a596f1x716IHLymgMCe8uM8IFM2SCQ=;
        b=PUFj37/gZ8TwmkaNhf7KSAou1rPRDrpYO9bg/duYzCuOBjN/1bs8iAOo3QpU4dxzrJ
         me3YkzRAl3NqsWA+LNV8MTLb8KTKu6dtclCU8d7/vjpFevyMigolFjg9jyRXgPJm1APB
         WbSZZwkvqsiMlIxkedP5arjLv7LHTt5zugu3gvlK8LMGxa9lM1ZHQholQBMt/KcUVnIO
         cbCcLYKV/tDKt88MeoCrENzkh1NLRdXpFXpweV7xo5qxgNtSOxYOCkTpxuySYKKT1yNo
         rMs3/Tp8RZ5MuGVCZJn6W4pJwoakNy12rOSAh0myQTYad0ZoJ544kYuuntKbP8dPtd/9
         ueZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgHifCLXedjQABws8DTKbzzQtJMVKBiuO9VVi9wXDwX2AX0BOp9yPfkMM9JO5Redw5W7o4kKgF@vger.kernel.org
X-Gm-Message-State: AOJu0YzNvNFK4Y3eYrlS/AsqMzipijEmJUQKrUClufbHuVZixK+m2/wN
	MzlVtLgPrQz09u6v5yq2UzWtsRxyZxEo6OEWIBL0mTdD194NvraQzQdwmyTUZ9Y6cyu0uJMNt5r
	2Zotb67XL4/0pfpb7OTAR7XK54vFf1CeXCcUmXf9MKLfbHqIn7XOBWryIXBA=
X-Gm-Gg: ASbGncumNpJDg4U0dqHlI/cjebejDRs+mRtnSvI6XTeY3hrLW9ZJUvA6BEZU7YIYW4B
	uSnS4UNaQ2/bB3TjElFPyQZMnSysAHKugxlq2IViNQTzpFhiYrQL0SjbYyC/fsaFd5uxUkCUeeu
	ER6xzHXgU1teWc+LQFjGqwmRmZTm7gJxQzu4pUNzRJ+C8L2+bKFgfY9zA2OQg8nOZO3covFI3E6
	9fZCL4yZ+BAQ6XHUhLf9ucmh59T0cjBzjrbSD0J18iRncqNYNZamg0o+ZJfHDnxKpoph2qFeF9k
	GnZ6YAhPGgJD1SLNqQpTlxx+wZjm777bX7CVaHvefZ7vuS4zYRI+3tBSHfMZGt4ETMHoYFLi0bz
	CJ2osR6aErAYtJiv3/xExhRqTBK/3txl3dZHJsJ+C5l4ssmcYvZSk2RPUq+IGjFztZQ==
X-Received: by 2002:a05:600c:1d02:b0:45d:d2d2:f081 with SMTP id 5b1f17b1804b1-46e1dab45bemr71219475e9.20.1758717520176;
        Wed, 24 Sep 2025 05:38:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoOcDJrZXb/FAj2GHp5vwDQ3FVAghlcebAFZ1Ij8pdYpyP5A1mb01GFXI6T1WFSkm200TrjA==
X-Received: by 2002:a05:600c:1d02:b0:45d:d2d2:f081 with SMTP id 5b1f17b1804b1-46e1dab45bemr71219115e9.20.1758717519643;
        Wed, 24 Sep 2025 05:38:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b? (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de. [2003:d8:2f14:2400:afc:9797:137c:a25b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e1ce10bacsm40101155e9.0.2025.09.24.05.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 05:38:39 -0700 (PDT)
Message-ID: <b041b58d-b0e4-4a01-a459-5449c232c437@redhat.com>
Date: Wed, 24 Sep 2025 14:38:37 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm: thp: reparent the split queue during memcg
 offline
To: Qi Zheng <zhengqi.arch@bytedance.com>, hannes@cmpxchg.org,
 hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, harry.yoo@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
 <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.09.25 11:16, Qi Zheng wrote:
> In the future, we will reparent LRU folios during memcg offline to
> eliminate dying memory cgroups, which requires reparenting the split queue
> to its parent.
> 
> Similar to list_lru, the split queue is relatively independent and does
> not need to be reparented along with objcg and LRU folios (holding
> objcg lock and lru lock). So let's apply the same mechanism as list_lru
> to reparent the split queue separately when memcg is offine.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   include/linux/huge_mm.h |  2 ++
>   include/linux/mmzone.h  |  1 +
>   mm/huge_memory.c        | 39 +++++++++++++++++++++++++++++++++++++++
>   mm/memcontrol.c         |  1 +
>   mm/mm_init.c            |  1 +
>   5 files changed, 44 insertions(+)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index f327d62fc9852..a0d4b751974d2 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -417,6 +417,7 @@ static inline int split_huge_page(struct page *page)
>   	return split_huge_page_to_list_to_order(page, NULL, ret);
>   }
>   void deferred_split_folio(struct folio *folio, bool partially_mapped);
> +void reparent_deferred_split_queue(struct mem_cgroup *memcg);
>   
>   void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>   		unsigned long address, bool freeze);
> @@ -611,6 +612,7 @@ static inline int try_folio_split(struct folio *folio, struct page *page,
>   }
>   
>   static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
> +static inline void reparent_deferred_split_queue(struct mem_cgroup *memcg) {}
>   #define split_huge_pmd(__vma, __pmd, __address)	\
>   	do { } while (0)
>   
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 7fb7331c57250..f3eb81fee056a 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1346,6 +1346,7 @@ struct deferred_split {
>   	spinlock_t split_queue_lock;
>   	struct list_head split_queue;
>   	unsigned long split_queue_len;
> +	bool is_dying;

It's a bit weird to query whether the "struct deferred_split" is dying. 
Shouldn't this be a memcg property? (and in particular, not exist for 
the pglist_data part where it might not make sense at all?).

>   };
>   #endif
>   
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 48b51e6230a67..de7806f759cba 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1094,9 +1094,15 @@ static struct deferred_split *folio_split_queue_lock(struct folio *folio)
>   	struct deferred_split *queue;
>   
>   	memcg = folio_memcg(folio);
> +retry:
>   	queue = memcg ? &memcg->deferred_split_queue :
>   			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
>   	spin_lock(&queue->split_queue_lock);
> +	if (unlikely(queue->is_dying == true)) {

if (unlikely(queue->is_dying))

> +		spin_unlock(&queue->split_queue_lock);
> +		memcg = parent_mem_cgroup(memcg);
> +		goto retry;
> +	}
>   
>   	return queue;
>   }
> @@ -1108,9 +1114,15 @@ folio_split_queue_lock_irqsave(struct folio *folio, unsigned long *flags)
>   	struct deferred_split *queue;
>   
>   	memcg = folio_memcg(folio);
> +retry:
>   	queue = memcg ? &memcg->deferred_split_queue :
>   			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
>   	spin_lock_irqsave(&queue->split_queue_lock, *flags);
> +	if (unlikely(queue->is_dying == true)) {

if (unlikely(queue->is_dying))

> +		spin_unlock_irqrestore(&queue->split_queue_lock, *flags);
> +		memcg = parent_mem_cgroup(memcg);
> +		goto retry;
> +	}
>   
>   	return queue;
>   }

Nothing else jumped at me, but I am not a memcg expert :)

-- 
Cheers

David / dhildenb


