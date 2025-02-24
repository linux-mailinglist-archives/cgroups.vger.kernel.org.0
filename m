Return-Path: <cgroups+bounces-6693-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D986A42F58
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 22:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4CFB7A86AF
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 21:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB161DE3AD;
	Mon, 24 Feb 2025 21:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPFEea1Y"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B45469D
	for <cgroups@vger.kernel.org>; Mon, 24 Feb 2025 21:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433375; cv=none; b=l2rRari09hsE/N50NtS2faPQnvJpOK27VGrAf0advyYUpk/ReeN5Et4WSKVYAbFueE1z4aLcuX+tZGn+Xa9LPZaSHsEe5AbUDDtgxoa8g63dSwLG6uxJUTDy3qGyt0T147m/PPd/6a0+KbfLK6DMFHqLfeuAri937WkNCKxwkkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433375; c=relaxed/simple;
	bh=ekkAEapecpumjjiwkGzpz44LQrXMuL5VpfcbknyWX6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JhVPZhM5RiAF17+D7ZAwXUtur4QhBvLYQYKRhp+RetIJwjPXVON5BHnekdo8zMOQE/JqZpCDqYDnCOqU91X5PMjQ0lmerGrXXbR1HyY+XoRT9PmGRERtTsqy7JqbJaSpCqVob+kj6yS2HU3C/1q4f8+Bc10on2kkScabWcIBzCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IPFEea1Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740433372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rJdaIppcAF+FxsFQkO0OqCCOm0uBPZoLqjFlhCs6lzk=;
	b=IPFEea1YA1qy2BW5NbgN7NQHNrXFygYVK9DAsqvdC5rF9s/7f6ETEZUqq2axa0s7T4QKho
	opuZl62z2F9ytP+mfH1ctuwzJ1RLoKD5ZIUrY7Mm4PK6mgi/MYv/j/vazVxUSwTMun/lJu
	dq8bNSjkta9jw8TijCkIzsfsv0KGtVU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-HjkMAcytOJiQ-7LfTrx5KA-1; Mon, 24 Feb 2025 16:42:51 -0500
X-MC-Unique: HjkMAcytOJiQ-7LfTrx5KA-1
X-Mimecast-MFC-AGG-ID: HjkMAcytOJiQ-7LfTrx5KA_1740433370
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43995bff469so40522905e9.2
        for <cgroups@vger.kernel.org>; Mon, 24 Feb 2025 13:42:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740433370; x=1741038170;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rJdaIppcAF+FxsFQkO0OqCCOm0uBPZoLqjFlhCs6lzk=;
        b=scqYGIgQVZlq0oPgNTc23fgTdGBD7kJdR0Ak8G1Sn/qH/IzZzuXzcYZEPg+lNN/TVb
         Vor1oqyrf6zbB7ow6Mmfk7YNt+5ViZhNfw8ZHldiPg1L16mHawcl7mUTb6vi5mu43dLv
         GT9PtXRCC0LcoLeVEEXDQHRR2sPjlJTL1lu/VYWNY57PmCni1XuavTSTHMGSWj68qFPG
         vtIRCw3m9IhOmVEkfhxHTOLBWpuPtI6gP2qWvbKMyoJYPiuM9R5I7/KWelpK27NLOBsG
         LjtC4ABsXtQB88fGB5vgM5VtqiEO2/qIViJHoGZOJwh0Wnpy3rqq0iOkq66OYLUPUTBL
         9G+g==
X-Forwarded-Encrypted: i=1; AJvYcCUWelg4/ox1K1TZGHDQq7gUi0mvyL0ekGnCesgPDtwC9BZPPBbT2292jbejXM+6T0s5q02+Zc4R@vger.kernel.org
X-Gm-Message-State: AOJu0YyKUfonAEBt3IUFd8bzFkHzN3n84iCmxPRq30z2wxTDb/Bvtfad
	R8+d2PlV1M97aNdQbhku4WdYH/xdVgR7kTTF8ta4lctZOVRBFdvnpmwAaD9a7LcHM1kMXuwWjd8
	7PU4OdW/Kyfk87wU1Jsv515shxh+CpasfHOcZkMqZlGVhxdPXBQN8dek=
X-Gm-Gg: ASbGnct5gfsSHvxyshKX/sjzS6isN7qeMxAtIu583yKZVU9FDCVe8T42IQ0nq/dmezF
	hupqkvZxMpC+bsaj9+n1UHpWwCGhhQvUdzt88BYV4fCRy2jqqqGRsUz3MzsY0oONEsL61NRIJEZ
	uKMDzPH3Ek2fUIa49eFA9TvlR7zNKUcWYDZaKCsqd8+xwWoS6tKLPv7AnI3/wv/bEIAz8LiCet7
	IDK+nwRT5pUUXC7a+wZlv0LKe7hVlbY/wF5JdFktbmtJRZaGROUuuv8NKjC77txZrvju5uuexSa
	RhdKEWZuHZM1LQD/UWRyEATBEx4lpYNIUVUZqkb7OVC94tYS76fGbQVp4AKd7ACtoT6qd1jsOUY
	oT4Tfl/zAMWndn7Bgr7fqryB2tzYzuTe8BEF4aA4pW3c=
X-Received: by 2002:a05:600c:3b91:b0:439:9e13:2dd7 with SMTP id 5b1f17b1804b1-43aa7a63c45mr41135015e9.2.1740433369803;
        Mon, 24 Feb 2025 13:42:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoC4d2j9rOE4cUzpqqA+7hSEc5qzv5dgNmeVhVNJED4tEkT5V3b2VPb/OWSe0Z/WHiHe1vcw==
X-Received: by 2002:a05:600c:3b91:b0:439:9e13:2dd7 with SMTP id 5b1f17b1804b1-43aa7a63c45mr41134845e9.2.1740433369369;
        Mon, 24 Feb 2025 13:42:49 -0800 (PST)
Received: from ?IPV6:2003:cb:c735:1900:ac8b:7ae5:991f:54fc? (p200300cbc7351900ac8b7ae5991f54fc.dip0.t-ipconnect.de. [2003:cb:c735:1900:ac8b:7ae5:991f:54fc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab155eb61sm3615755e9.29.2025.02.24.13.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 13:42:48 -0800 (PST)
Message-ID: <3f6b7e66-3412-4af2-97d9-6d31d6373079@redhat.com>
Date: Mon, 24 Feb 2025 22:42:47 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/20] fs/proc/page: remove per-page mapcount
 dependency for /proc/kpagecount (CONFIG_NO_PAGE_MAPCOUNT)
To: Zi Yan <ziy@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Muchun Song <muchun.song@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
References: <20250224165603.1434404-1-david@redhat.com>
 <20250224165603.1434404-17-david@redhat.com>
 <D80YSXJPTL7M.2GZLUFXVP2ZCC@nvidia.com>
 <8a5e94a2-8cd7-45f5-a2be-525242c0cd16@redhat.com>
 <9010E213-9FC5-4900-B971-D032CB879F2E@nvidia.com>
 <567b02b0-3e39-4e3c-ba41-1bc59217a421@redhat.com>
 <30C2A030-7438-4298-87D8-287BED1EA473@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <30C2A030-7438-4298-87D8-287BED1EA473@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.02.25 22:23, Zi Yan wrote:
> On 24 Feb 2025, at 16:15, David Hildenbrand wrote:
> 
>> On 24.02.25 22:10, Zi Yan wrote:
>>> On 24 Feb 2025, at 16:02, David Hildenbrand wrote:
>>>
>>>> On 24.02.25 21:40, Zi Yan wrote:
>>>>> On Mon Feb 24, 2025 at 11:55 AM EST, David Hildenbrand wrote:
>>>>>> Let's implement an alternative when per-page mapcounts in large folios
>>>>>> are no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.
>>>>>>
>>>>>> For large folios, we'll return the per-page average mapcount within the
>>>>>> folio, except when the average is 0 but the folio is mapped: then we
>>>>>> return 1.
>>>>>>
>>>>>> For hugetlb folios and for large folios that are fully mapped
>>>>>> into all address spaces, there is no change.
>>>>>>
>>>>>> As an alternative, we could simply return 0 for non-hugetlb large folios,
>>>>>> or disable this legacy interface with CONFIG_NO_PAGE_MAPCOUNT.
>>>>>>
>>>>>> But the information exposed by this interface can still be valuable, and
>>>>>> frequently we deal with fully-mapped large folios where the average
>>>>>> corresponds to the actual page mapcount. So we'll leave it like this for
>>>>>> now and document the new behavior.
>>>>>>
>>>>>> Note: this interface is likely not very relevant for performance. If
>>>>>> ever required, we could try doing a rather expensive rmap walk to collect
>>>>>> precisely how often this folio page is mapped.
>>>>>>
>>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>>> ---
>>>>>>     Documentation/admin-guide/mm/pagemap.rst |  7 +++++-
>>>>>>     fs/proc/internal.h                       | 31 ++++++++++++++++++++++++
>>>>>>     fs/proc/page.c                           | 19 ++++++++++++---
>>>>>>     3 files changed, 53 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
>>>>>> index caba0f52dd36c..49590306c61a0 100644
>>>>>> --- a/Documentation/admin-guide/mm/pagemap.rst
>>>>>> +++ b/Documentation/admin-guide/mm/pagemap.rst
>>>>>> @@ -42,7 +42,12 @@ There are four components to pagemap:
>>>>>>        skip over unmapped regions.
>>>>>>       * ``/proc/kpagecount``.  This file contains a 64-bit count of the number of
>>>>>> -   times each page is mapped, indexed by PFN.
>>>>>> +   times each page is mapped, indexed by PFN. Some kernel configurations do
>>>>>> +   not track the precise number of times a page part of a larger allocation
>>>>>> +   (e.g., THP) is mapped. In these configurations, the average number of
>>>>>> +   mappings per page in this larger allocation is returned instead. However,
>>>>>> +   if any page of the large allocation is mapped, the returned value will
>>>>>> +   be at least 1.
>>>>>>      The page-types tool in the tools/mm directory can be used to query the
>>>>>>     number of times a page is mapped.
>>>>>> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
>>>>>> index 1695509370b88..16aa1fd260771 100644
>>>>>> --- a/fs/proc/internal.h
>>>>>> +++ b/fs/proc/internal.h
>>>>>> @@ -174,6 +174,37 @@ static inline int folio_precise_page_mapcount(struct folio *folio,
>>>>>>     	return mapcount;
>>>>>>     }
>>>>>>    +/**
>>>>>> + * folio_average_page_mapcount() - Average number of mappings per page in this
>>>>>> + *				   folio
>>>>>> + * @folio: The folio.
>>>>>> + *
>>>>>> + * The average number of present user page table entries that reference each
>>>>>> + * page in this folio as tracked via the RMAP: either referenced directly
>>>>>> + * (PTE) or as part of a larger area that covers this page (e.g., PMD).
>>>>>> + *
>>>>>> + * Returns: The average number of mappings per page in this folio. 0 for
>>>>>> + * folios that are not mapped to user space or are not tracked via the RMAP
>>>>>> + * (e.g., shared zeropage).
>>>>>> + */
>>>>>> +static inline int folio_average_page_mapcount(struct folio *folio)
>>>>>> +{
>>>>>> +	int mapcount, entire_mapcount;
>>>>>> +	unsigned int adjust;
>>>>>> +
>>>>>> +	if (!folio_test_large(folio))
>>>>>> +		return atomic_read(&folio->_mapcount) + 1;
>>>>>> +
>>>>>> +	mapcount = folio_large_mapcount(folio);
>>>>>> +	entire_mapcount = folio_entire_mapcount(folio);
>>>>>> +	if (mapcount <= entire_mapcount)
>>>>>> +		return entire_mapcount;
>>>>>> +	mapcount -= entire_mapcount;
>>>>>> +
>>>>>> +	adjust = folio_large_nr_pages(folio) / 2;
>>>>
>>>> Thanks for the review!
>>>>
>>>>>
>>>>> Is there any reason for choosing this adjust number? A comment might be
>>>>> helpful in case people want to change it later, either with some reasoning
>>>>> or just saying it is chosen empirically.
>>>>
>>>> We're dividing by folio_large_nr_pages(folio) (shifting by folio_large_order(folio)), so this is not a magic number at all.
>>>>
>>>> So this should be "ordinary" rounding.
>>>
>>> I thought the rounding would be (mapcount + 511) / 512.
>>
>> Yes, that's "rounding up".
>>
>>> But
>>> that means if one subpage is mapped, the average will be 1.
>>> Your rounding means if at least half of the subpages is mapped,
>>> the average will be 1. Others might think 1/3 is mapped,
>>> the average will be 1. That is why I think adjust looks like
>>> a magic number.
>>
>> I think all callers could tolerate (or benefit) from folio_average_page_mapcount() returning at least 1 in case any page is mapped.
>>
>> There was a reason why I decided to round to the nearest integer instead.
>>
>> Let me think about this once more, I went back and forth a couple of times on this.
> 
> Sure. Your current choice might be good enough for now. My intend of
> adding a comment here is just to let people know the adjust can be
> changed in the future. :)

The following will make the callers easier to read, while keeping
the rounding to the next integer for the other cases untouched.

+/**
+ * folio_average_page_mapcount() - Average number of mappings per page in this
+ *                                folio
+ * @folio: The folio.
+ *
+ * The average number of present user page table entries that reference each
+ * page in this folio as tracked via the RMAP: either referenced directly
+ * (PTE) or as part of a larger area that covers this page (e.g., PMD).
+ *
+ * The average is calculated by rounding to the nearest integer; however,
+ * if at least a single page is mapped, the average will be at least 1.
+ *
+ * Returns: The average number of mappings per page in this folio.
+ */
+static inline int folio_average_page_mapcount(struct folio *folio)
+{
+       int mapcount, entire_mapcount, avg;
+
+       if (!folio_test_large(folio))
+               return atomic_read(&folio->_mapcount) + 1;
+
+       mapcount = folio_large_mapcount(folio);
+       if (unlikely(mapcount <= 0))
+               return 0;
+       entire_mapcount = folio_entire_mapcount(folio);
+       if (mapcount <= entire_mapcount)
+               return entire_mapcount;
+       mapcount -= entire_mapcount;
+
+       /* Round to closest integer ... */
+       avg = (mapcount + folio_large_nr_pages(folio) / 2) >> folio_large_order(folio);
+       avg += entire_mapcount;
+       /* ... but return at least 1. */
+       return max_t(int, avg, 1);
+}


-- 
Cheers,

David / dhildenb


