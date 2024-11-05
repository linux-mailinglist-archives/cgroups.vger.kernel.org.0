Return-Path: <cgroups+bounces-5449-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DA09BD376
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2024 18:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F94E1F2351F
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2024 17:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F4A1E1C11;
	Tue,  5 Nov 2024 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efT2tFFg"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227CB1D9A71
	for <cgroups@vger.kernel.org>; Tue,  5 Nov 2024 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828105; cv=none; b=ZBxu6XrFmpM+RZs3+3MUkxldnoHpEmFoDrLrlAjYc7knCHHoJTXUeEvOc3xkFgPRVBFi1sTW0sQwvpK860shnCy34nmDXfLUlbuKyK+13BMRNjbanyCHlQKqRTTYpjcDQZmCYGCAo+hCGYkI0I5d9zCDJyzwmXkhGwV4pEpZg2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828105; c=relaxed/simple;
	bh=LOZTuliOS2gtQij5+GoflF8AmSxZNSmB9lITIQs5krQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZmI9ktlFaS3diE0ZQ0o2po4mruy+6vfeioBQNF+fcILaFgtXPD25m+/FluYVTHDJDMfPZWKo3LBDlAlL+ZJnEay+X66KWeAojj4mdmGdpv65WUo5unzn+WM+NB7wLAc4ho+8lp2UFGQSONxo66+cvSRlCsGz4WKnzz+J532a2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=efT2tFFg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730828103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1mUnNkdhUU0vKrW5HhuOr6BbhCUcWOAVXK2JluGYHBw=;
	b=efT2tFFgXHMVvzbNGd3G8EJB7h0rRsj1wUgTjs4eLduTXY+m3ecKgANzXHWPra0mjtGoVw
	rmM5BoyOaCXKC7BPpkOfYZyyPK0igGZOo1E/L8njNThs4D8FOsaBV9uCMb5y8CyWQS6Ntw
	KYRlb0iG+/LRNiup4FNhQp/JTp5oaIw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-0sT9TpaFOv6KXrW2rlAYEA-1; Tue, 05 Nov 2024 12:35:01 -0500
X-MC-Unique: 0sT9TpaFOv6KXrW2rlAYEA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d47fdbbd6so3185735f8f.3
        for <cgroups@vger.kernel.org>; Tue, 05 Nov 2024 09:35:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730828100; x=1731432900;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1mUnNkdhUU0vKrW5HhuOr6BbhCUcWOAVXK2JluGYHBw=;
        b=clR2PFuai3a3K4iAUYPpG6L/kQwt7JhTOEbh/tnTYhMX0xg99reT8Br/oR5wWV2ZWR
         T8cM75tzf7tVZgBR0UM6r+aNk3Ybt72oYJff0epfhkxPsnRFDDCxbftXDj9ndnZvK7KU
         oORHEnE+yEO9WTD/69kpdJrAUjJQQu2NuODr98CoyRR7jBFnmoIBIBQM4w0uGb2I7lor
         l16W88HSg1hx5u6Q3dAC5msgDoGnybdzzKxGlnBM7kaj+1ajBPXwQAm4LL4VCWARGGVt
         ipGf0ldY00o7BuEX5ySJ7MB/roh4epnRdVQOUWZrRszjOiKOvuIyeL+85GqVz+7ue/JX
         gl8A==
X-Forwarded-Encrypted: i=1; AJvYcCXl9Dn5os1PbyJ3jEvzxFtNOako3Nikx0IUlGirGq5oerpNIeo8JpoT7NZLz1GsZaUvd7RQ4E1Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yzng6nbfTsiSIGZa2X1TYBYJ/TRmFJLT6OS+Qdf6YA6EdR/NygJ
	8DkV5j+xUNWGhNkGXb7l5cUm5EzyhQMn5udyLGnJlf54368cQPtY5uPMppVwgJmEl2EA7PcTJIF
	xrxuwcFTaRu3G9xp35d2KgsTZ4bZch6Vw+2xOzOLhfjn9kE291M+0pQ8=
X-Received: by 2002:a5d:59a4:0:b0:37e:f8a1:596e with SMTP id ffacd0b85a97d-381be7ad255mr18796238f8f.11.1730828100535;
        Tue, 05 Nov 2024 09:35:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEb67RXG7gg4reG9aH+APrEu5DU88SXNov5UkfGKKI1PQMJ8lrhhXBBktuE4+XOvNor+097fw==
X-Received: by 2002:a5d:59a4:0:b0:37e:f8a1:596e with SMTP id ffacd0b85a97d-381be7ad255mr18796216f8f.11.1730828100155;
        Tue, 05 Nov 2024 09:35:00 -0800 (PST)
Received: from ?IPV6:2003:cb:c73b:db00:b0d7:66ca:e3e9:6528? (p200300cbc73bdb00b0d766cae3e96528.dip0.t-ipconnect.de. [2003:cb:c73b:db00:b0d7:66ca:e3e9:6528])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d698405sm200578605e9.41.2024.11.05.09.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 09:34:59 -0800 (PST)
Message-ID: <ecbbf668-0122-41cb-a0b9-3e287b280776@redhat.com>
Date: Tue, 5 Nov 2024 18:34:57 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm: Simplify split_page_memcg()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
 linux-mm@kvack.org
References: <20241104210602.374975-1-willy@infradead.org>
 <20241104210602.374975-3-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241104210602.374975-3-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.11.24 22:05, Matthew Wilcox (Oracle) wrote:
> The last argument to split_page_memcg() is now always 0, so remove it,
> effectively reverting commit b8791381d7ed.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/memcontrol.h |  4 ++--
>   mm/memcontrol.c            | 26 ++++++++++++++------------
>   mm/page_alloc.c            |  4 ++--
>   3 files changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 5502aa8e138e..a787080f814f 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1044,7 +1044,7 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
>   	rcu_read_unlock();
>   }
>   
> -void split_page_memcg(struct page *head, int old_order, int new_order);
> +void split_page_memcg(struct page *first, int order);
>   
>   #else /* CONFIG_MEMCG */
>   
> @@ -1463,7 +1463,7 @@ void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
>   {
>   }
>   
> -static inline void split_page_memcg(struct page *head, int old_order, int new_order)
> +static inline void split_page_memcg(struct page *first, int order)
>   {
>   }
>   #endif /* CONFIG_MEMCG */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5e44d6e7591e..506439a5dcfe 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3034,25 +3034,27 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
>   }
>   
>   /*
> - * Because folio_memcg(head) is not set on tails, set it now.
> + * The memcg data is only set on the first page, now transfer it to all the
> + * other pages.
>    */
> -void split_page_memcg(struct page *head, int old_order, int new_order)
> +void split_page_memcg(struct page *first, int order)
>   {
> -	struct folio *folio = page_folio(head);
> +	unsigned long memcg_data = first->memcg_data;
> +	struct obj_cgroup *objcg;
>   	int i;
> -	unsigned int old_nr = 1 << old_order;
> -	unsigned int new_nr = 1 << new_order;
> +	unsigned int nr = 1 << order;
>   
> -	if (mem_cgroup_disabled() || !folio_memcg_charged(folio))
> +	if (!memcg_data)
>   		return;
 >   > -	for (i = new_nr; i < old_nr; i += new_nr)
> -		folio_page(folio, i)->memcg_data = folio->memcg_data;
> +	VM_BUG_ON_PAGE((memcg_data & OBJEXTS_FLAGS_MASK) != MEMCG_DATA_KMEM,
> +			first);
> +	objcg = (void *)(memcg_data & ~OBJEXTS_FLAGS_MASK);

I'm not sure if dropping the

	if (mem_cgroup_disabled() || !folio_memcg_charged(folio))

end adding that OBJEXTS_FLAGS_MASK magic here is the right thing to do.

It also isn't really part of a revert of b8791381d7ed.


-- 
Cheers,

David / dhildenb


