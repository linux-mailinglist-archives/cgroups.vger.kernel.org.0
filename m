Return-Path: <cgroups+bounces-7025-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41002A5E73B
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 23:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F78189BD7F
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 22:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20BB1F0E2B;
	Wed, 12 Mar 2025 22:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+jD3LlE"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21191F03E4
	for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817958; cv=none; b=d8fILG0/ehnl0Z6MowggA8ZWp7O6+2V4OpodWws+ToGn+NKJ77ik16nwzaPdYpvh5iQYBoqKQcSKXJ+Zm3DTcvY2Bq1UIYUVgwBhmyp/iXbG1Q6gms5V4J79J8Z5sIy093O1uSnuLyY5QtVTXs3j9TyIXvUPpZ+y2tJ9mqZzZkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817958; c=relaxed/simple;
	bh=ED08Mt6RpE3YuROU8cM9sysjsMYzGtrc8SaX4I53Zqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pTwOlVLLdDviHfMK2R+SbCrQOJSoCwyc5LN9/lb2bxWLmBSHHQchdKLhgIWBCOJIZe0lha/3hmMbWqz1ZjU4y7RhPpvpNXej1vXbVRBSVPSSU+aHKZZGHGqNEFjpSuJZOA/oWGz8W77kI48/hHioQhS4buWTune9O4EjHL0wRlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+jD3LlE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741817954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YKs6c5vd6BryHi5UgmvOyl94KmjrndKcyGQFDHLGkR0=;
	b=V+jD3LlEc/40EUSHErUc93E1Lu/cuEvIzpJaDVp/aw2R6eOj76uvAwACrueGAc4LsYAGFv
	MhZMSEJIS/ySuvrZwIVRRhoff1YckyddDSAnudAfCePNI333/Zg1RmtmqQs3ZAJN1N18Xr
	AXQpjygs2121gbZ23pYFNUimR/rvb30=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-SJjY_tGZMVCfpQEKa-H1XA-1; Wed, 12 Mar 2025 18:19:11 -0400
X-MC-Unique: SJjY_tGZMVCfpQEKa-H1XA-1
X-Mimecast-MFC-AGG-ID: SJjY_tGZMVCfpQEKa-H1XA_1741817950
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394040fea1so1849665e9.0
        for <cgroups@vger.kernel.org>; Wed, 12 Mar 2025 15:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741817950; x=1742422750;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YKs6c5vd6BryHi5UgmvOyl94KmjrndKcyGQFDHLGkR0=;
        b=g8bCdzg5N7qbVB1GPNx2NniEBawQxmbOcK3C/i1z22NIRHueBonJVdnWvOVwX6p1B5
         DS0rpzQcHuam/kjtmbmqQnPG7hK+GTyBZamHpY785p3rPSF1M+k7V9livv+q1t8lStH3
         /4kf6GF/hVFU3i04IbCq0HFnV2peLCKtUXQ8Ofa1uzb3l74+1mxr62++luPKyfhve7XT
         oQwCRCZKX0JF7ns5MjG2t0r+YAWd/DnPjZ2SFoDf23AAZZ6fIpJUwHEO9eCUo3XYKpWP
         +M38axIYQ8sxPe0Fry8CIPxyFvnJxNyut/8dopYbS+nYwytjpt2sHsTuxzD1S/55h4QA
         fXKw==
X-Forwarded-Encrypted: i=1; AJvYcCUS0dSvm5O1kaklyPvXpTh11+FR87svVF47mjih1b2GT3mmIjt3X9EeNI7eQs/VKSgbqXVEL0ol@vger.kernel.org
X-Gm-Message-State: AOJu0YzJTRq60BoIcShkbTJABJOzfAQ9oBSkRr936seYLCrT0ZjU79Cc
	Wk1sTTz+9GQNCQWZ8A6fR/EpfFb117As2/tXtSicNQZfMlpyubrISEpXQb9fpRc1zPWcytF+dM8
	IfFutcNTxMUypH+3i1CV0rrNh7EdkGlvWqTTyvDxsqPdfal8ia/SKwDM=
X-Gm-Gg: ASbGncsQdSMiuvThKnyBGzI2wfEoRpNx9NecaLF9UERhM2S7rlp+/7d0dnPSkVTByO3
	dsnhO0SijDLxcDq4OdkJGyT7ZCtPN8hc2HR7M2fiVFWqZc7W6/HwF+dyR4cq4JYYl0UdiLebpUb
	QW7O55sfbFOcORkJ5b1EHLTDw06a0u0bvTRLuif6zONa6TJmKo7I8onK/L7OE9hUhCnkabwWy+Q
	p4QQ9rEqAMpH23BMIJGBr/Le5BZvcmhXhPDW17x6H3BpJwyXpNVFz/C6K8wkkspe1FGO26k3yKz
	rbLBjbNiEB0l0BUUAVQxb0vf4olc8d0H/j6Ss2Eo78yJsI5aFIEGad9zssZ8BaZ3HiL48TjffmA
	Z8D4AL88JqkXQRzlm2ouXcheyFh3MGzwkt0Tc2AF3giw=
X-Received: by 2002:a05:600c:5687:b0:43d:186d:a4bf with SMTP id 5b1f17b1804b1-43d186da55cmr561235e9.0.1741817949892;
        Wed, 12 Mar 2025 15:19:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFCZMzMhDcHcPaUJ7ZYKRB5yd0dTr+9E10/9yIGc6tvXc+O0vqyF/Y1Un5pGyf0sl4Nfe9rg==
X-Received: by 2002:a05:600c:5687:b0:43d:186d:a4bf with SMTP id 5b1f17b1804b1-43d186da55cmr561065e9.0.1741817949555;
        Wed, 12 Mar 2025 15:19:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1a:7c00:4ac1:c2c4:4167:8a0f? (p200300d82f1a7c004ac1c2c441678a0f.dip0.t-ipconnect.de. [2003:d8:2f1a:7c00:4ac1:c2c4:4167:8a0f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a73127esm34510605e9.8.2025.03.12.15.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 15:19:08 -0700 (PDT)
Message-ID: <c4229ea5-d991-4f5e-a0ff-45dce78a242a@redhat.com>
Date: Wed, 12 Mar 2025 23:19:06 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/5] meminfo: add a per node counter for balloon drivers
To: Nico Pache <npache@redhat.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, jerrin.shaji-george@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com,
 sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 nphamcs@gmail.com, yosry.ahmed@linux.dev, kanchana.p.sridhar@intel.com,
 alexander.atanasov@virtuozzo.com
References: <20250312000700.184573-1-npache@redhat.com>
 <20250312000700.184573-2-npache@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250312000700.184573-2-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.03.25 01:06, Nico Pache wrote:
> Add NR_BALLOON_PAGES counter to track memory used by balloon drivers and
> expose it through /proc/meminfo and other memory reporting interfaces.

In balloon_page_enqueue_one(), we perform a

__count_vm_event(BALLOON_INFLATE)

and in balloon_page_list_dequeue

__count_vm_event(BALLOON_DEFLATE);


Should we maybe simply do the per-node accounting similarly there?

-- 
Cheers,

David / dhildenb


