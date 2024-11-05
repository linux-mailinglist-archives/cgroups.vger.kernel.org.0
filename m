Return-Path: <cgroups+bounces-5448-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F5B9BD366
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2024 18:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF031F22D83
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2024 17:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524EC15C144;
	Tue,  5 Nov 2024 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R67Cl5UV"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB4C5674D
	for <cgroups@vger.kernel.org>; Tue,  5 Nov 2024 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827828; cv=none; b=iwutEBuoJiLs6vfQWhjT8tdUHfZIsyeLhkojJ3AHftLL9OYgB8cH3f/s3P5I7qjrjdNHjk5qKuhHVxeMmelX0Aw284mKuGpWfNxHaK97D4HnlOn5cTjjhmft7DUrS1uzZtzYbyEYSRUrSSGH/NY9h7Q27EWoVIRwkg0ehiym0ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827828; c=relaxed/simple;
	bh=n4wi/7q185bnU/y1qeM2QA7cQeA5J4BA8yvFxnx8lwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSPWaN+fp3dyy7wB4Lt4+H2kg0IqqNPz61qbLw6avOyBeCMpslSg+b7KuycfIznKSSl5KHJjSogagYXkZeJFZQBEUuklUACjtCr7ruwzQziN6Gi4Uhpomhu78gjYaEpEhz8EQpMJKN1Zb/FdPoBpZORpwAO0AL1V+hyzQAKdO6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R67Cl5UV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730827825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=afEv9GEFv9ZYOvN0eXrvv63Lz1O4DC9pouw/Ti/HkAE=;
	b=R67Cl5UVdOQb9+qGjWb8P8Ulq6rsIr4zqm4jDIAh4R+fhtrmckDAr6saKn1DcXsjmLm4J4
	82GSQyJOVWcULe165JFqD2cg7FzK7AkLPnlnrDE6igxQGV23XaZPTtYYsxxc53VvDN219u
	Tg6PAzpgGuuuOapK27Rz+y0SUhNnIIY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-qA539jxEMBen8plBalolyw-1; Tue, 05 Nov 2024 12:30:24 -0500
X-MC-Unique: qA539jxEMBen8plBalolyw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4316e2dde9eso48794185e9.2
        for <cgroups@vger.kernel.org>; Tue, 05 Nov 2024 09:30:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730827823; x=1731432623;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=afEv9GEFv9ZYOvN0eXrvv63Lz1O4DC9pouw/Ti/HkAE=;
        b=i+hEZxkijzklLcaiFa3oPIPdxmElFNAUhAEhJD6yc0pe5TZzkENnQPAxhC9xoNwlbb
         0wmoU7w/ZYGUEcDaSj6tGcI+Td6O4Uckddhsc4cVhdYqJVwbIW2l7QeLoVwFJfWI3ULx
         ViQcLqfpP4tNQqLuKNpezt0I3NneXQOLopGkoQRmcY+had72/TSMVoLyg/63U/fOxWky
         RCP4l7LzYg8zlwVzwHO0URnMUdAA5Yq8Bg9MixgaDD7d+VymLBtQ+4EMjVpQyo1k1Rfu
         e3jsPtRU5kFmIy0DRsoV9vuoMMCmuNAeP1U0u2HgyR8LmDdIeKunbAqfDLPyf4FbQOMM
         OCpg==
X-Forwarded-Encrypted: i=1; AJvYcCVlvHz9Sr5dChG0fsBfiGsdGR2q/2GSJ7gYrtW/Mqd7XI1dgzJ9cGZ6UeQP7MAj3qFnrmtUwXiV@vger.kernel.org
X-Gm-Message-State: AOJu0YzOPWamxoWNMVcVeIyYjf3FpMgwhoY+4iUoLHCxqs20S140Bu/R
	tVLV5J/3JCgNMVsrQBOPHfqloFhaEmeFmSqJrAGOHSc/et27b+8MbWuIozYvHSOJfUZbSHYr9X5
	SKshmDEF0yM5+mea6atSzyGMr6eeYL0L0au2kEzko2YuCtCihtNeqxltLPa04Yg8=
X-Received: by 2002:a05:6000:2ce:b0:37d:52fc:edf9 with SMTP id ffacd0b85a97d-381c7a5cf91mr16782773f8f.20.1730827822893;
        Tue, 05 Nov 2024 09:30:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfbmKWhZJf5mJv47Dm8DcJ0zBX0x3r/SrUb57O3943S/LTobo7w+YYS2O6RSnBG3ychpCp+g==
X-Received: by 2002:a05:6000:2ce:b0:37d:52fc:edf9 with SMTP id ffacd0b85a97d-381c7a5cf91mr16782741f8f.20.1730827822458;
        Tue, 05 Nov 2024 09:30:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c73b:db00:b0d7:66ca:e3e9:6528? (p200300cbc73bdb00b0d766cae3e96528.dip0.t-ipconnect.de. [2003:cb:c73b:db00:b0d7:66ca:e3e9:6528])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7a9esm16701247f8f.21.2024.11.05.09.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 09:30:22 -0800 (PST)
Message-ID: <85f36754-a05d-40b7-b606-2515ac921c82@redhat.com>
Date: Tue, 5 Nov 2024 18:30:20 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm: Opencode split_page_memcg() in
 __split_huge_page()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
 linux-mm@kvack.org
References: <20241104210602.374975-1-willy@infradead.org>
 <20241104210602.374975-2-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241104210602.374975-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.11.24 22:05, Matthew Wilcox (Oracle) wrote:
> This is in preparation for only handling kmem pages in
> __split_huge_page().

Did you mean "in split_page_memcg()"?

> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/huge_memory.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f92068864469..44d25a74b611 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3234,6 +3234,10 @@ static void __split_huge_page_tail(struct folio *folio, int tail,
>   		folio_set_large_rmappable(new_folio);
>   	}
>   
> +#ifdef CONFIG_MEMCG
> +	new_folio->memcg_data = folio->memcg_data;
 > +#endif> +
>   	/* Finally unfreeze refcount. Additional reference from page cache. */
>   	page_ref_unfreeze(page_tail,
>   		1 + ((!folio_test_anon(folio) || folio_test_swapcache(folio)) ?
> @@ -3267,8 +3271,11 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>   	int order = folio_order(folio);
>   	unsigned int nr = 1 << order;
>   
> -	/* complete memcg works before add pages to LRU */
> -	split_page_memcg(head, order, new_order);
> +#ifdef CONFIG_MEMCG
> +	if (folio_memcg_charged(folio))

Do we have the mem_cgroup_disabled() call here?

Apart from that LGTM.

-- 
Cheers,

David / dhildenb


