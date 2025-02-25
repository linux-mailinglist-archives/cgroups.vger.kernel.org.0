Return-Path: <cgroups+bounces-6708-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E610A43C68
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 11:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 801DD3A3C06
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 10:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAE9267738;
	Tue, 25 Feb 2025 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tls+c4Bs"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FA32676F9
	for <cgroups@vger.kernel.org>; Tue, 25 Feb 2025 10:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481020; cv=none; b=SgjCmWRS1kHFscjrPUDit+vK/Bso6yXey7mEg3jrakvBFMtklAob8U40MfMZF+e5ePWL+uEH0MKLs0QdeiXOmBWmTTvEc4TFIPfHJBFUKE7uKLNND+bBxggDgqPhD2yvhFNhEQKcHYZbo9Am/qVeBuPLroQSLTvOMvM8bwUzRcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481020; c=relaxed/simple;
	bh=9q4cs9uEBdO4R2hDf9yXRHC8PAzNjxSOOBtTkoVzNrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOg0pqEuPHBZIXGnwqhPA8xS6vdNRQhk+yXqwTZfonMA2D2l6mKvZFPLOaxiqRzrmgfDE53VYAjKJTioUke6JcVJfNGQCpAdzCnfczU+ozyaTUe7lEXlwwioxufzm3lpHcfxs5A713UAYAXz4Rcy7LDCCT4BJup3OjeTKbACN/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tls+c4Bs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740481016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KHznIi52/FgGQYw2G9QY1Aa3XRPiRKbnQIO5wwNLKYY=;
	b=Tls+c4BszAWJwNE604QrHy4xIl2auaiR96cB0jjKFqNu04shpC8nqwiatb1Ucyq0l+fav9
	OeVJnIIwiIV66eqJilz4b40VqEXUiYPzxPGWI6rej1ahOqQFtYhh+AKrN1AoP8HivPlxzu
	GJIaf2bKv2rpSlfcylA80pLbzUxyhuI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-LiN80pgmMrWJ75kQyBedHA-1; Tue, 25 Feb 2025 05:56:54 -0500
X-MC-Unique: LiN80pgmMrWJ75kQyBedHA-1
X-Mimecast-MFC-AGG-ID: LiN80pgmMrWJ75kQyBedHA_1740481014
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4399c5baac3so37776095e9.2
        for <cgroups@vger.kernel.org>; Tue, 25 Feb 2025 02:56:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481013; x=1741085813;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KHznIi52/FgGQYw2G9QY1Aa3XRPiRKbnQIO5wwNLKYY=;
        b=V8PVm/U+1GNI6fi87feK9+RFr6YCuvb5Kj/I5vkJtCPUR4SPNMUBpeaGBYW4R4mXsO
         /i6fhJl7dNfw/SKu4jY+dkhzHS8ICYdRtrZ76G96aWCEZ5yrtYty5nPkCaKfunQIxiD5
         kjcH7S4sxv3ltjEsVFFHqzc9jV/shuRm4h4hx72qx87wSzKcNOafD6YohO6zZB1KIoBa
         W1x7d29GM8OCcPs1fBcP5c6Z7237y0WAR8W3s9P5pRHL4D/Xr9kxnUSDMVDlVtgs7uXB
         /OIahh8jYNUcrFCpzzsqHb6/hHWQb9vphq1WJBtZkNMpyXMUjdkB13cUjP/GI/cALatF
         u4mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXRInFBy8kB+/UkNF37J8Yc8SzXrpWjyl4IIalwFdEJ+6DT9nq8dJVSF8IostNGAFMFKzjKOOf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9c5MsVJ7WbW4bJq+FuaEMYuEpGqKCp1LkVg8InXSyQU+1KDMb
	v3UBvqaiBjunjZav//HqTi0kSMLhk1s6YviTqE7YerUE+X7CgFSoPGZPeLkNBoqF09aTemLC3EI
	vXhGrLohKSZkgQZaZYJeUCpskHnHbX+PokzM5KmzGf+9QpTzkPDKnWN0=
X-Gm-Gg: ASbGncukiICdnNTd8ztL4KvtaYfs+5m2fUqz/EZLXv9xQ9S9ZMgwdwHzfmp5D4fX1tE
	kWmaIM1we2Op6hGiPQwMCzFScIO900LU40hVWhKouzPsJDeQb8BThoE8INo287cBXQGzMKS3BRU
	3sGXzRmOFSeSYd9kynQNNVYpicxai8+Z6sD/qwwr3zzBdmkIRRo6WQDgWfaQd5UooymwcMAQyrM
	ZoUuJe7vD5ZuE3in76Vx33kHFR0R31CSZHnqHXGQ6i5HWC+GUIorCCW9VcvoEYjDGV/MntW2Bog
	/SnHLAje8fYsfxTJtnPY465l457Pkqom+pf6J9xJ57n9MOT70yCODB7vcw3I8fEdNljXAn4G7az
	Hwujk4cRLWsV9ER0xUGWZaNrxPFDCU92X2EYBV7yCw1M=
X-Received: by 2002:a05:600c:19c9:b0:439:331b:e34f with SMTP id 5b1f17b1804b1-439ae1f2f86mr146823015e9.17.1740481013600;
        Tue, 25 Feb 2025 02:56:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGW3mMOogekUIK13+DQ2ZUntepuE1eAIIBacqwgCVYjSJPleAtrr9tg3z2f4jLkg6/quOTcA==
X-Received: by 2002:a05:600c:19c9:b0:439:331b:e34f with SMTP id 5b1f17b1804b1-439ae1f2f86mr146822585e9.17.1740481013125;
        Tue, 25 Feb 2025 02:56:53 -0800 (PST)
Received: from ?IPV6:2003:cb:c73e:aa00:c9db:441d:a65e:6999? (p200300cbc73eaa00c9db441da65e6999.dip0.t-ipconnect.de. [2003:cb:c73e:aa00:c9db:441d:a65e:6999])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02d5700sm138556775e9.9.2025.02.25.02.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 02:56:52 -0800 (PST)
Message-ID: <c41ddeb7-ddf3-4465-8567-bde5f8d3aaec@redhat.com>
Date: Tue, 25 Feb 2025 11:56:51 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/20] fs/proc/task_mmu: remove per-page mapcount
 dependency for PM_MMAP_EXCLUSIVE (CONFIG_NO_PAGE_MAPCOUNT)
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
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
 <20250224165603.1434404-18-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250224165603.1434404-18-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.02.25 17:55, David Hildenbrand wrote:
> Let's implement an alternative when per-page mapcounts in large folios are
> no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.
> 
> PM_MMAP_EXCLUSIVE will now be set if folio_likely_mapped_shared() is
> true -- when the folio is considered "mapped shared", including when
> it once was "mapped shared" but no longer is, as documented.
> 
> This might result in and under-indication of "exclusively mapped", which
> is considered better than over-indicating it: under-estimating the USS
> (Unique Set Size) is better than over-estimating it.
> 
> As an alternative, we could simply remove that flag with
> CONFIG_NO_PAGE_MAPCOUNT completely, but there might be value to it. So,
> let's keep it like that and document the behavior.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   Documentation/admin-guide/mm/pagemap.rst |  9 +++++++++
>   fs/proc/task_mmu.c                       | 11 +++++++++--
>   2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
> index 49590306c61a0..131c86574c39a 100644
> --- a/Documentation/admin-guide/mm/pagemap.rst
> +++ b/Documentation/admin-guide/mm/pagemap.rst
> @@ -37,6 +37,15 @@ There are four components to pagemap:
>      precisely which pages are mapped (or in swap) and comparing mapped
>      pages between processes.
>   
> +   Note that in some kernel configurations, all pages part of a larger
> +   allocation (e.g., THP) might be considered "mapped shared" if the large
> +   allocation is considered "mapped shared": if not all pages are exclusive to
> +   the same process. Further, some kernel configurations might consider larger
> +   allocations "mapped shared", if they were at one point considered
> +   "mapped shared", even if they would now be considered "exclusively mapped".
> +   Consequently, in these kernel configurations, bit 56 might be set although
> +   the page is actually "exclusively mapped"

I rewrote this yet another time to maybe make it clearer ...

+   Traditionally, bit 56 indicates that a page is mapped exactly once and bit
+   56 is clear when a page is mapped multiple times, even when mapped in the
+   same process multiple times. In some kernel configurations, the semantics
+   for pages part of a larger allocation (e.g., THP) differ: bit 56 is set if
+   all pages part of the corresponding large allocation are *certainly* mapped
+   in the same process, even if the page is mapped multiple times in that
+   process. Bit 56 is clear when any page page of the larger allocation
+   is *maybe* mapped in a different process. In some cases, a large allocation
+   might be treated as "maybe mapped by multiple processes" even though this
+   is no longer the case.

(talking about "process" is not completely correct, it's actually "MMs"; but
that might add more confusion here)

-- 
Cheers,

David / dhildenb


