Return-Path: <cgroups+bounces-6979-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD7BA5C4DD
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 16:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA9057A4698
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 15:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75FF25E83C;
	Tue, 11 Mar 2025 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYxmACJ4"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E2525E473
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705630; cv=none; b=cEktkLdM+FtG/Rd67b3C/oke8dAncdqGMyICVjIjSgKwZHNC415I8GLOf6XNVgV/3W8Gnn50bwd2NXf02YaruF2hlJqMvaaX+DWwKT+kB54MPiM+7bail8v/BNZpRLhaYRZbwL+LdvECbN2kYWQLqujXgkhi27yx3XBmNRQCt7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705630; c=relaxed/simple;
	bh=Dawmuk4eFgkgU5MwhrBGTiEGZORF2E7FMEQk1S+++ok=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iTLx4h2SdgC6gVfES5JBdXF9JDEmLIlcSrisj3aWTNgxx42W7soE8dPpa19NeEHEVinJASjdaawlMjBlbHIkmkpToHHbQ3ruJ2BeJqqBfaUocX9eqBSz42aeLRLZFPyPIjdztzxdvRThXWmem6N5+m0U5iH8B1hn+qjMj/2tgcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WYxmACJ4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741705627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JFd1ExBPEt0Dfyww2+rzGd1ksO5mjGdVVVOBajHIlYI=;
	b=WYxmACJ41X5Bqc1zO8Rw+7gF2Zz3pwrtMYaO2ZLV1BTq/XI3KMlAh9zDs8f061hIEixNec
	LMIELm5WUQ+v/orksBBUvZaQQe2GmKcfwaud04NtkOvrkn39qDQF2sBV3jghO+/MZIyqfI
	r8SEFkTuEXJ4A18jI5vZciCMOMq603g=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-dQCClkn1O-GDo6skDAeCfw-1; Tue, 11 Mar 2025 11:07:06 -0400
X-MC-Unique: dQCClkn1O-GDo6skDAeCfw-1
X-Mimecast-MFC-AGG-ID: dQCClkn1O-GDo6skDAeCfw_1741705625
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-47686947566so41706171cf.3
        for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 08:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741705625; x=1742310425;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JFd1ExBPEt0Dfyww2+rzGd1ksO5mjGdVVVOBajHIlYI=;
        b=lnukykyQsTv0WeIfI/czuqYJPPIhM51z+i3buZsWnXrRnF451ZU2dG4mfaYTVTBJNa
         T5s7IcQ3hpl1AYnGGCuGLltoa6/8+esoFDDe4wkedoDrDWSQXJVnv/uFpL3r9SXI8Pq2
         KgEIsCccMBsC12N3JHxZmtN/blAY1hB2vFaqSpDXgN9bgNgi/I/zOg4M3pHijxkuk/yL
         dt+cqu3BNefJ2Z5k0LlnV+KoKzyX0p9K8UCMFUsYmIhhbTAwiiMscQ4LQQ414RXrLSiG
         +KUgV3bLa5MAM7TDLLB2//nEiwxu1xv7gmDmY/IX8KHixxarUP3mYrMxovU1xaCV2loS
         xugw==
X-Forwarded-Encrypted: i=1; AJvYcCVHTO5uI9KLM9lkk2XKnCHMvf+5E0HDPmgccUWISw94ZCCxgqyfQXevHiO7bSn73boqdxq8mOzi@vger.kernel.org
X-Gm-Message-State: AOJu0YzYNYrLyu24R60s6kFp6f+GrJUmv/kWTTT8mtUKclmAagGB65HL
	xEDFclJI7nf8H74xwA6Fhv7Xat0Y3UnFoTqgM1YeycgucKpzOSjnY6Mz/EEhrBWMhKjy9O2C73U
	53C5YoYJSLrEdF9lRvbC0I0VDE8sXzEchqiWjynFbgBYRDm6G9Z//+3s=
X-Gm-Gg: ASbGnculEBqiNATR/a4AI7pyQUiZBN77Fm6tHSQLrGEnQ/iTmdBvVRhtlXCI1mMvJXG
	FKSDgAnmKFCBncMjL/Qj+bXF+8j9SCoLubiGMI93UCWDkQfe3qSytEHtz5Vv0OGi62ux7z9eCnu
	ERQUtaZ1agKq5XKjTwQLZMbrZWg1ihIFnsxxyiT77gCyeA6BpJZIpWuoAmOOuDwSZXBGYUmWd1q
	RxmhmgMIQxawnSAmLiI3GYqa/3M9vSgjzTjMtYdasqtWrrxxdSyhhGVdtcn8WXphxFzCjy+fy5Z
	sKFrY5YKdKNnzj5BaT6TJgfjZPRQSNLTV6BsaNPkt1FVdZE4OusVQ/UEJ27Y8A==
X-Received: by 2002:ac8:5956:0:b0:476:5fd5:4de7 with SMTP id d75a77b69052e-4769960eaf4mr63992371cf.41.1741705625653;
        Tue, 11 Mar 2025 08:07:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcTKH15BMvz0iV4fiI1KTJpmb6vk5YFJA1fTIm45MoXYHgz9eGSlC/+8KqB1nS3XsadACJ8g==
X-Received: by 2002:ac8:5956:0:b0:476:5fd5:4de7 with SMTP id d75a77b69052e-4769960eaf4mr63991921cf.41.1741705625335;
        Tue, 11 Mar 2025 08:07:05 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4765f877398sm50151521cf.4.2025.03.11.08.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 08:07:04 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <d2a3328e-c8b1-4697-9a97-c198fe672f40@redhat.com>
Date: Tue, 11 Mar 2025 11:07:03 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] cgroup/cpuset-v1: Add deprecation messages to
 memory_spread_page and memory_spread_slab
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
References: <20250311123640.530377-1-mkoutny@suse.com>
 <20250311123640.530377-3-mkoutny@suse.com>
Content-Language: en-US
In-Reply-To: <20250311123640.530377-3-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/11/25 8:36 AM, Michal Koutný wrote:
> There is MPOL_INTERLEAVE for user explicit allocations.
> Deprecate spreading of allocations that users carry out unwittingly.
> Use straight warning level for slab spreading since such a knob is
> unnecessarily intertwined with slab allocator.
>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   kernel/cgroup/cpuset-v1.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 9d47b20c03c4b..fea8a0cb7ae1d 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -441,9 +441,11 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
>   		cpuset_memory_pressure_enabled = !!val;
>   		break;
>   	case FILE_SPREAD_PAGE:
> +		pr_info_once("cpuset.%s is deprecated\n", cft->name);
>   		retval = cpuset_update_flag(CS_SPREAD_PAGE, cs, val);
>   		break;
>   	case FILE_SPREAD_SLAB:
> +		pr_warn_once("cpuset.%s is deprecated\n", cft->name);
>   		retval = cpuset_update_flag(CS_SPREAD_SLAB, cs, val);
>   		break;
>   	default:
Acked-by: Waiman Long <longman@redhat.com>


