Return-Path: <cgroups+bounces-2588-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0508A9E05
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 17:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84EC286CC3
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 15:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7D516C457;
	Thu, 18 Apr 2024 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gcrl2TOa"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAA616C445
	for <cgroups@vger.kernel.org>; Thu, 18 Apr 2024 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452989; cv=none; b=oJWZAWLjNm9d7P7fjftu8YuLDAUp4GPMbu3X0Ir5aeOefqOu40oruFc0qf/xv7oT3tSipoPKb43em9/0gVKJftSWCU6D+duY4QXLEjfFr3Lj2gQztT75p7Kg8iChqXsMkGh+rm5LLHkHrjPFebibVjQx52GFJOpJzTEM3TgzV6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452989; c=relaxed/simple;
	bh=Pg4War1EBSgo4DT2T7yT4CMqRvEKyWd4B12VFZv1LMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4AWsSaRE1TklnREK+WkWSxYJj2Q/Yi/OrO3Lcau+QzywFlAC8VSDxwoBddbtkn24dYEKKHS64yGFzQEzxKBHZLpP32P58tD/SuoQkI0Blirg6DJyPRYgWyungV21pyB2v+rhClcKMPLjox7HRD3W8x2TY7vVSq3Xn86m8ez/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gcrl2TOa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713452987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vwjfiFQnjjbAD99CHjoCNe/Mj9Dk40lmq8ErGQAJMSo=;
	b=Gcrl2TOaZAI23dUqAkxi7v2aircG3m1HsD44L4w8wQUGBTznEVKX50WY+GdVeAHtBQulUY
	9QTCYc/zRcOzbSOXe8+ZaGK+ZsQoqr+TpRvp8gUDmGPlSzPT72B7Pw73ZU6CffKr6Icwm5
	gXnPbty86MgVGtX3s3e+M/8Baf48Hf4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-foWG4iMcPdy1EcWVG04zPQ-1; Thu, 18 Apr 2024 11:09:45 -0400
X-MC-Unique: foWG4iMcPdy1EcWVG04zPQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-417c5cc7c96so5518625e9.1
        for <cgroups@vger.kernel.org>; Thu, 18 Apr 2024 08:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713452984; x=1714057784;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vwjfiFQnjjbAD99CHjoCNe/Mj9Dk40lmq8ErGQAJMSo=;
        b=RAdGMZmPOH9eq0Ab4G0fJu1x9Io4A7nexbO3cZSttciXKZKiBa90xhTJ+RoQ2tMPfZ
         OJSs9hLc0BHHSJOc252iSt/Nach4zVJRSpuYCaoZTNKPWZ23UN/6i1s9hfSpEn6KZjL+
         MLFk+s3YLzJbONSGRRSbsGkGtaoDPm3hNUNfcqZsklxdKDqaZOBJF9O8UtD/J8DX+MHT
         ota+4NG8hjD3RzcsOOMDWqAGshWWH4kC/eiTMabAeVLw9eVj/HKgtxcMR7/Z9Vw5h26C
         cavdiYkztty2c0EWoP9Jw6RSG9oapcxE5y17Dh1ALsDJs3BkhSdbbLMXE8o0WXc1jS08
         DVmA==
X-Forwarded-Encrypted: i=1; AJvYcCV5FhXfJk0kWKOO7Uvu9La5IRX9ICYp7w1lmIIynGr4/boxwSHr98Gu+LUIdwZ+ls4u4kpwh5Da2S3l+CYmG6ajFGfx7TcTmg==
X-Gm-Message-State: AOJu0YxeXu2p8S7mi6gFYlTcnBpCQoxiXQHY+P2ySIyHC+KQkrpDA/aP
	ZmxD42prxt0WjnvgxRQ5M/LtdTZu5+wBZ9yZB6YnOl2bfOPP9DPGLrH1Y9A0aOYdDhHh/rO3/NT
	GISUszwz5eyByoaot46j2kdhZM6M1EtDCK+3Zd6r4IeFockjMaM7Evjw=
X-Received: by 2002:a05:600c:524a:b0:416:3db7:74b4 with SMTP id fc10-20020a05600c524a00b004163db774b4mr2040029wmb.24.1713452984170;
        Thu, 18 Apr 2024 08:09:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTNhHILxv2DrETC17o2+9HAaRjsk+gWsTIv9PW4hja8gy+K29xAShokS3+g00FJ+3co5c44Q==
X-Received: by 2002:a05:600c:524a:b0:416:3db7:74b4 with SMTP id fc10-20020a05600c524a00b004163db774b4mr2040006wmb.24.1713452983695;
        Thu, 18 Apr 2024 08:09:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:4e00:fd61:512:d944:28f6? (p200300cbc7084e00fd610512d94428f6.dip0.t-ipconnect.de. [2003:cb:c708:4e00:fd61:512:d944:28f6])
        by smtp.gmail.com with ESMTPSA id hg12-20020a05600c538c00b00415dfa709dasm2976731wmb.15.2024.04.18.08.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 08:09:43 -0700 (PDT)
Message-ID: <f8f30747-1313-4939-a2ad-3accd14ba01f@redhat.com>
Date: Thu, 18 Apr 2024 17:09:41 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/18] mm: track mapcount of large folios in single
 value
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, cgroups@vger.kernel.org, chris@zankel.net,
 corbet@lwn.net, dalias@libc.org, fengwei.yin@intel.com,
 glaubitz@physik.fu-berlin.de, hughd@google.com, jcmvbkbc@gmail.com,
 linmiaohe@huawei.com, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-sh@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, muchun.song@linux.dev,
 naoya.horiguchi@nec.com, peterx@redhat.com, richardycc@google.com,
 ryan.roberts@arm.com, shy828301@gmail.com, willy@infradead.org,
 ysato@users.sourceforge.jp, ziy@nvidia.com
References: <20240409192301.907377-5-david@redhat.com>
 <20240418145003.8780-1-ioworker0@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240418145003.8780-1-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.04.24 16:50, Lance Yang wrote:
> Hey David,
> 
> FWIW, just a nit below.

Hi!

Thanks, but that was done on purpose.

This way, we'll have a memory barrier (due to at least one 
atomic_inc_and_test()) between incrementing the folio refcount 
(happening before the rmap change) and incrementing the mapcount.

Is it required? Not 100% sure, refcount vs. mapcount checks are always a 
bit racy. But doing it this way let me sleep better at night ;)

[with no subpage mapcounts, we'd do the atomic_inc_and_test on the large 
mapcount and have the memory barrier there again; but that's stuff for 
the future]

Thanks!

> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2608c40dffad..08bb6834cf72 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1143,7 +1143,6 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
>   		int *nr_pmdmapped)
>   {
>   	atomic_t *mapped = &folio->_nr_pages_mapped;
> -	const int orig_nr_pages = nr_pages;
>   	int first, nr = 0;
>   
>   	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
> @@ -1155,6 +1154,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
>   			break;
>   		}
>   
> +		atomic_add(nr_pages, &folio->_large_mapcount);
>   		do {
>   			first = atomic_inc_and_test(&page->_mapcount);
>   			if (first) {
> @@ -1163,7 +1163,6 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
>   					nr++;
>   			}
>   		} while (page++, --nr_pages > 0);
> -		atomic_add(orig_nr_pages, &folio->_large_mapcount);
>   		break;
>   	case RMAP_LEVEL_PMD:
>   		first = atomic_inc_and_test(&folio->_entire_mapcount);
> 
> Thanks,
> Lance
> 

-- 
Cheers,

David / dhildenb


