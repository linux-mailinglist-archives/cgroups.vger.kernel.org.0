Return-Path: <cgroups+bounces-9492-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AC6B3C3CE
	for <lists+cgroups@lfdr.de>; Fri, 29 Aug 2025 22:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD87EA24B55
	for <lists+cgroups@lfdr.de>; Fri, 29 Aug 2025 20:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B73E33EAF0;
	Fri, 29 Aug 2025 20:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFHtCbdh"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C82F335BCC
	for <cgroups@vger.kernel.org>; Fri, 29 Aug 2025 20:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756499534; cv=none; b=b02im8qylXHsoKmwx0ICfO7MKK2H8IZ/E0KLePk8lRnt2PV/Scx/jlY0/UQ+nmxbp8tPbay8Xpcj3pIoStMoZDEfnpuF2UwWHhBw+KoJr9FFb0iYBMkJOCReHT+q4Bo85ojZGKA/1QpV4q7FbMphzsen2V0UJNXyJl87b0Ull/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756499534; c=relaxed/simple;
	bh=4b0ERqGboD0025/EE6BpdNyy7bjwsY2FJPKRwOTE8Ho=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=u5xQ8PeX/rMvofRW6RX/d0hSZvN1LGX61s03tQjOjxUJYlduOjtEsHTamSj6yiMOy4yBvuMlX4FwvQzYanQCxXJx4+yIaA+9b4UX305O2fD3iq17/wHuf5yzoO1t44NMfxck9ppzGU/ejCWkvJJ45d8YBnsdBUm9uq1ZT1zbRXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFHtCbdh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756499530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYHPKYQYJqiOAQju2ZuT3ez1AVlcLrBw2m0yDrDYMKo=;
	b=HFHtCbdhhqKPD9sqC3Gy0e+oEhdvwqJ2nAA9NYJuRCypQMoUsmEZXCCxZayIPMgbmMKQew
	CrdybkCB65x1p1eFIhym9piYRpZjqIpBsSUpbUyb5zv5qHvP6txJSfm1n1mno5lOEraRmB
	VExknwDR86IoZaeHx/oBKiKy+T6/hyc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-HJB5mRTtOFGFJZIN1pnYPQ-1; Fri, 29 Aug 2025 16:32:09 -0400
X-MC-Unique: HJB5mRTtOFGFJZIN1pnYPQ-1
X-Mimecast-MFC-AGG-ID: HJB5mRTtOFGFJZIN1pnYPQ_1756499529
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b302991b39so37264271cf.2
        for <cgroups@vger.kernel.org>; Fri, 29 Aug 2025 13:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756499528; x=1757104328;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jYHPKYQYJqiOAQju2ZuT3ez1AVlcLrBw2m0yDrDYMKo=;
        b=TkSI3LZwg1UX6lXNsrRJo/42wgjhaIKyjbJyhsjgyEO3LAzWUBP2MlusXW9hqU8j6n
         Z3Px6Mgm/KICXnjwW3awbDEY7IOLChMg8gDY/9YM9y5/jMOAsuSyK0nKfqWzjXAeWTjB
         bXSt0jvNbO5Dlw4m0Jkbp299MXWpkCePpDRgYj9mmtOP0kGj7i2RkIXw05pcnOIMC1WX
         QSGEJ6tZesIFs/JQ0anZdHPP6F2XVJp1clImTlEh5PwzEuYFRajL/jIP6MLeJfIiIob9
         h8tdU/wqENjDKWF77S0sjRzkQoOXERdZ70HNJzo6rxnmD5FI+wOx9lr8AKwgnwnGyJ9n
         VMQg==
X-Gm-Message-State: AOJu0YwRYTsXgpEbiaqZbwcjZRNS9CaPN+zIMgRvgpRp7uBNoFuo83hi
	87bUj6z7fiY+Z3p4v8rXBjU/2vpIQz5Ksxx/+Tgk8pcgEMPznQ39EnNWBDbqlfpp6n5oB7iqZb6
	ekk1lBL2kJEqXnW0/D2L4r4m7xaUYJd2CWop5uZ6ZoIQvKiieGLRPbk2J/Y4lk02Mkjo=
X-Gm-Gg: ASbGncuc81Gy8SJsduuU3fp5eevu3/XphNADZS72EdpCWowbj+u8QNeHk0tEdN2E1E7
	dcvq419+Oot+o2lEUFITVdgQtkF34ZF2lCykFdfUF/Whht0duOpIlrNc0LmwG2VFbpAjVbGc36n
	QCQjDxAy/xwj7eIBzuZ/1D2DPZ0ETDdrgMm52VgIMOP03kYyQlOBlDuDpjB84oCmSVRE7AGZbXP
	WrSQZM7M3j5tueW1B7JYSIl66qpV8OUTMbRd4sxcT7kXnAlu8+mzBUgN2h19LNwqnTd/euLbqEa
	AT+UzeG29Va4TkgGgCl7pmHMKDObjs7IZjfOVSBkAq7Dko/jenYmy6tCtLkD/RoimexEW2VD382
	5T5kbay15Ow==
X-Received: by 2002:a05:622a:1dc6:b0:4b3:102c:9263 with SMTP id d75a77b69052e-4b3102c9b0cmr41101951cf.39.1756499528278;
        Fri, 29 Aug 2025 13:32:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuLreJrdFJjGtn3cUS5D29Z+8SrJhNxhNMSxo5X+GBKky4gSUhSoxX+szSFygwpu/2zxBOnw==
X-Received: by 2002:a05:622a:1dc6:b0:4b3:102c:9263 with SMTP id d75a77b69052e-4b3102c9b0cmr41101531cf.39.1756499527758;
        Fri, 29 Aug 2025 13:32:07 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc0d869743sm242177085a.1.2025.08.29.13.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 13:32:07 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <632cd2ab-9803-4b84-8dd9-cd07fbe73c95@redhat.com>
Date: Fri, 29 Aug 2025 16:32:06 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 09/11] cpuset: refactor partition_cpus_change
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250828125631.1978176-1-chenridong@huaweicloud.com>
 <20250828125631.1978176-10-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250828125631.1978176-10-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/25 8:56 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Refactor the partition_cpus_change function to handle both regular CPU
> set updates and exclusive CPU modifications, either of which may trigger
> partition state changes. This generalized function will also be utilized
> for exclusive CPU updates in subsequent patches.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 59 ++++++++++++++++++++++++++----------------
>   1 file changed, 36 insertions(+), 23 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 75ad18ab40ae..e3eb87a33b12 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2447,6 +2447,41 @@ static int acpus_validate_change(struct cpuset *cs, struct cpuset *trialcs,
>   	return retval;
>   }
>   
> +/**
> + * partition_cpus_change - Handle partition state changes due to CPU mask updates
> + * @cs: The target cpuset being modified
> + * @trialcs: The trial cpuset containing proposed configuration changes
> + * @tmp: Temporary masks for intermediate calculations
> + *
> + * This function handles partition state transitions triggered by CPU mask changes.
> + * CPU modifications may cause a partition to be disabled or require state updates.
> + */
> +static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
> +					struct tmpmasks *tmp)
> +{
> +	if (cs_is_member(cs))
> +		return;
> +
> +	invalidate_cs_partition(trialcs);
> +	if (trialcs->prs_err)
> +		cs->prs_err = trialcs->prs_err;
> +
> +	if (is_remote_partition(cs)) {
> +		if (trialcs->prs_err)
> +			remote_partition_disable(cs, tmp);
> +		else
> +			remote_cpus_update(cs, trialcs->exclusive_cpus,
> +					   trialcs->effective_xcpus, tmp);
> +	} else {
> +		if (trialcs->prs_err)
> +			update_parent_effective_cpumask(cs, partcmd_invalidate,
> +							NULL, tmp);
> +		else
> +			update_parent_effective_cpumask(cs, partcmd_update,
> +							trialcs->effective_xcpus, tmp);
> +	}
> +}
> +
>   /**
>    * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
>    * @cs: the cpuset to consider
> @@ -2483,29 +2518,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	 */
>   	force = !cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus);
>   
> -	invalidate_cs_partition(trialcs);
> -	if (trialcs->prs_err)
> -		cs->prs_err = trialcs->prs_err;
> -
> -	if (is_partition_valid(cs) ||
> -	   (is_partition_invalid(cs) && !trialcs->prs_err)) {
> -		struct cpumask *xcpus = trialcs->effective_xcpus;
> -
> -		if (cpumask_empty(xcpus) && is_partition_invalid(cs))
> -			xcpus = trialcs->cpus_allowed;

This if statement was added in commit 46c521bac592 ("cgroup/cpuset: 
Enable invalid to valid local partition transition") that is missing in 
your new partition_cpus_change() function. Have you run the 
test_cpuset_prs.sh selftest with a patched kernel to make sure that 
there is no test failure?

Cheers,
Longman


