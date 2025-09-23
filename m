Return-Path: <cgroups+bounces-10384-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5A7B94FC3
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 10:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 235717A4892
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 08:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5340E31A056;
	Tue, 23 Sep 2025 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpZRkOb+"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBA41114
	for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615989; cv=none; b=BugvYcWGPo9AorB6GHbvwE+tznkQj0qcfH/ntOKeUp0i2Wsi4XjHh/kTdJwQoBqTnzL9qiOJ90fmcLG/Ce4VMFKL32CMMyFOYLzBZhZbmP0lurCUJ/gZUzrDNm58cTMpgmwm+m4R0oer64KaecJxvqGW99yI/87u6rSa1vVg5IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615989; c=relaxed/simple;
	bh=RIby1D8riReGlUS5ZL+dKJRUnb/8+ATMrYUYK3UB0Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMsRAAkuq796VONQ0O5iUGXDyhzkh9v1AudBAFBedfGnDmvoZNnfZT1h2Hm/Mxs9QOIHYcmgEthKvEir2mEdH/Xh/zVVokX+p42s7/VfQliuEJa1l1IeWmr80h91T4f067CvAPQjD0kpDjrB/bxpTyTGgY/H9YG69+2YoU00wg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UpZRkOb+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758615986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=u158U5eLLkY8pwNFzJaS9pMnHCqEcHc3FLks6NqWdoc=;
	b=UpZRkOb+x9uOE+USBLDAJg8VSHcIz9gWxOpcWbstYtbAyMj6FsTxlpRZJbk8UK13zL4h46
	N66JxVOBpww5WAAcXYdyJm5AQwWE1VUuaQ7wmroYXYTqLs0ytvcq0EosIl4HE7lj6kHww1
	A31qGkxsaO17bYjG5smN0iuI34RCFCc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-NCbCQTFDMLGpQOxXjzqAvQ-1; Tue, 23 Sep 2025 04:26:24 -0400
X-MC-Unique: NCbCQTFDMLGpQOxXjzqAvQ-1
X-Mimecast-MFC-AGG-ID: NCbCQTFDMLGpQOxXjzqAvQ_1758615984
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45f2b9b99f0so15423385e9.1
        for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 01:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758615983; x=1759220783;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u158U5eLLkY8pwNFzJaS9pMnHCqEcHc3FLks6NqWdoc=;
        b=gz5UV6vo03JFEmeDxFlfQL//2rNedF/9TfHpDWbifj/xsFC9BJup4ZyX30Eh58ewRq
         O83ug9TPe4sQapjgH1CarKwjYXYhEy723nauGW2ktFeiicn3gslIvSkXSEMts4zLQSRb
         7LSOmR52om2tOjYvvs+1rrsGlCP7SCWtiPXBlxaNc/m5LaehDTogVRsmVyz4Yin9/vPI
         EnhVFgKJK7lb309dwRp49shq1M/YJKUY+5Ow9hXFubKFxEZARR2hWi5jR4fhxfAzpFzX
         AedvbUfcyVCDYu/VhNmm7BMPVyEQdwvaUhZGHWmEYR9eHlOQyc6lpW3Nz9hOHgmXO9pG
         nacg==
X-Forwarded-Encrypted: i=1; AJvYcCXyDOpNyLkqcAL6MRpThpgADQM7w5+Az6Pe6Y8L95lffVqQoQQ472ha65XG2iTlyRy+0ptrOtXs@vger.kernel.org
X-Gm-Message-State: AOJu0YxPAaFaZ/hEVw54+dA5YmUotAjrLtiXa17BoySpp0mikJ9kYNGG
	Uco3rJd8tGMpRiYrv3PuD9vUGVJ4uf82Yfzv4TjgzlA9oQh05flNTcRaiHBjaPMGOYwvThYrCIe
	o6hg/EbPUHmDThQcTiM5MPd5wCGLpFnAj1g2BkQjgpjFzMLiijSXDjDoqpetq4j/eBrQ=
X-Gm-Gg: ASbGnctKp7FAZbSwa618+Q3zcBuHyOCJ2O48vdPF55+wTcHrg7UgY0xf3UcizbYdRcB
	TD4oe4FBWSBbtAeSnhnCvOdPmgS2c0sYRftZ9u46G4LXejwiK/nhylsmr7Uykl5M1Gb/TqtJC7d
	O/7bhrymjMoprKqzu3V04ZZz6/01nF/HXuZXoP07cXGE5AEBgz6gHsGmkI528MnVrNAN0BKJi98
	lFrkVotM1QWYQjkp3MQwbsJZG096fpjNhZ3R1lj2EJ0JBuLCH8bDXapZfVt2BBgPTYmV0EPW7JV
	DgnADI9NcBlbc9RKvLF9b+vmlnFJnJVCGZJAhAGezmcDjUeq6G2XZVUebMJKQVsOKAuyMezKPwH
	46frSwANeq+T2c8gU6hgVc7kLAcnc2/nkqIOTp6PfmpvjvXuI7vHl891D2jnDEAxctA==
X-Received: by 2002:a05:600c:6610:b0:45f:29eb:2148 with SMTP id 5b1f17b1804b1-46e1e12731cmr16208705e9.7.1758615983564;
        Tue, 23 Sep 2025 01:26:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqzL6FPtVZMWa7SDdaAzcN92tCv1s8XBSB/8rSC0slsXilfs71hU7mkj+ZOiqZYqL/7Rz7Hg==
X-Received: by 2002:a05:600c:6610:b0:45f:29eb:2148 with SMTP id 5b1f17b1804b1-46e1e12731cmr16208405e9.7.1758615983159;
        Tue, 23 Sep 2025 01:26:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:700:c9db:579f:8b2b:717c? (p200300d82f4f0700c9db579f8b2b717c.dip0.t-ipconnect.de. [2003:d8:2f4f:700:c9db:579f:8b2b:717c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46d7a566a27sm66347685e9.20.2025.09.23.01.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 01:26:22 -0700 (PDT)
Message-ID: <0a5482ad-3625-4c22-9eef-574eabd7c2bf@redhat.com>
Date: Tue, 23 Sep 2025 10:26:21 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next v3 0/6] memcg: Support per-memcg KSM metrics
To: xu.xin16@zte.com.cn, akpm@linux-foundation.org, shakeel.butt@linux.dev,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev
Cc: chengming.zhou@linux.dev, muchun.song@linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org
References: <20250921230726978agBBWNsPLi2hCp9Sxed1Y@zte.com.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250921230726978agBBWNsPLi2hCp9Sxed1Y@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.09.25 17:07, xu.xin16@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> v2->v3:
> ------
> Some fixes of compilation error due to missed inclusion of header or missed
> function definition on some kernel config.
> https://lore.kernel.org/all/202509142147.WQI0impC-lkp@intel.com/
> https://lore.kernel.org/all/202509142046.QatEaTQV-lkp@intel.com/
> 
> v1->v2:
> ------
> According to Shakeel's suggestion, expose these metric item into memory.stat
> instead of a new interface.
> https://lore.kernel.org/all/ir2s6sqi6hrbz7ghmfngbif6fbgmswhqdljlntesurfl2xvmmv@yp3w2lqyipb5/
> 
> Background
> ==========
> 
> With the enablement of container-level KSM (e.g., via prctl [1]), there is
> a growing demand for container-level observability of KSM behavior. However,
> current cgroup implementations lack support for exposing KSM-related metrics.
> 
> So add the counter in the existing memory.stat without adding a new interface.
> To diaplay per-memcg KSM statistic counters,  we traverse all processes of a
> memcg and summing the processes' ksm_rmap_items counters instead of adding enum
> item in memcg_stat_item or node_stat_item and updating the corresponding enum
> counter when ksmd manipulate pages.
> 
> Now Linux users can look up all per-memcg KSM counters by:
> 
> # cat /sys/fs/cgroup/xuxin/memory.stat | grep ksm
> ksm_rmap_items 0
> ksm_zero_pages 0
> ksm_merging_pages 0
> ksm_profit 0


No strong opinion from my side: seems to mostly only collect stats from 
all tasks to summarize them per memcg.

-- 
Cheers

David / dhildenb


