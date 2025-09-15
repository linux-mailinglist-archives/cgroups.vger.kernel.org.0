Return-Path: <cgroups+bounces-10122-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DC3B584FA
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 20:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01D7C7A3D93
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 18:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA48A27BF93;
	Mon, 15 Sep 2025 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8eduiAQ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1A7215F42
	for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757962432; cv=none; b=CrBotFcOY2/xUf2mGeClb89uqlfWejOsv+9N9Ug9nV/VnNo0FXZPgTmeuwiQ3v8qoDO/+jXKJ4oLJR++lEVX2lGMfE4eT6GMW3ExBJz6e2s3WmENohDd42GbJ0JxBe2PwJXJcRlT4dYDBfdDBDQZIaWJgLvL53ELoMvfz1n7yNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757962432; c=relaxed/simple;
	bh=QkzCkqlzGEtis4r7JhP1vhV8hJjpKR9/PYyZ73sKa6A=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DK+hCTqADDne7KIQ08xzlyzT1+twryRO5AOL4RLi1C9v6Rf6PzL+zfWRHI26vinW/z5DD4NZt1pYnppL5TclbcD8OCSHnonKfh0+2kkgjQJkWNR0oRfp+eMZhIWH0gau3suA8ibOZKUUH/t9vJDYByeztvqnxPXmkhmWNKm2jKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W8eduiAQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757962429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQOD1HrlyQdU3WG5cibV+4OpdKoc/syBueuAerLS0/g=;
	b=W8eduiAQd/591O819ks6rvB7g78LI4QI3m7YJojpEHlXVDcMeKMPK+S++BEQHWy6ZC+mqJ
	gRbvn7YgztaAbtiJTJG1MklsGBqZgxbdxTu0q1wBtZHkiSKRlYx5x3tOVlpat0iWF73C5O
	2xnuSMFzzYFXw5uJ+pSeU8k6EvEf+W4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-JwGFX9n7OCuFFD_s_evJLg-1; Mon, 15 Sep 2025 14:53:48 -0400
X-MC-Unique: JwGFX9n7OCuFFD_s_evJLg-1
X-Mimecast-MFC-AGG-ID: JwGFX9n7OCuFFD_s_evJLg_1757962428
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-77d39d8f55aso25646786d6.0
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 11:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757962428; x=1758567228;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQOD1HrlyQdU3WG5cibV+4OpdKoc/syBueuAerLS0/g=;
        b=rzLUGthT+szOLTAUswAR05u2HP1z3D5gjtJqTAdqxOGWDrtahwwslcfiabaU6cf4it
         /OKpTn5+T1yTZyH7WWsumenQ//Vs1z1AKl5YZn5NwK4h4kTIQRSWdXKwhEuZwYhWthAg
         tvvYSvBpT95YHa5/UblUPPjVOmrmIfZAJtOaF+XjvOdzGMbYSbTDFXT02YIjf5u+45bK
         UB7D01EnnuNX5wzvdJdqzPUb6tGFOZq0htR5PAMACydN+nHzlKAxeebzdN0pMtcgQ9MD
         UoAzQQxC996L8VEtFYYOY6Z3tcclUo/BmMdFKhP2o+YcAJOxRYWdWC+Mqjgu7AIq43Nr
         3ZnA==
X-Gm-Message-State: AOJu0YxXQaQPn3ZWHUN18ctlyMr0ARyPUwkXhMwG2khLcidKxRENQyLw
	et+CdO4OqCRaTdWpOFUGfbw5x0Rlv/7kKgbV+p57TYyEL0cBSHEPfo2s4xLbdfgYitt3phgOg5a
	Qz1mcxDuCwVQQwsAvJ/svyH7v26SDqMQCk38Qfn9u1kFEInud3jOJ28qHcfI=
X-Gm-Gg: ASbGncuDSQ1m/mSzIv7XuqQVYiuRN3j08D3owItMe6wireCySj7tK3704rOjfajx0+J
	CSCLtEBZRFpBUUmKvohka2gVhXAWF/dfQzxBlB0Dy/vVoO89BIQalNCECRjvfl5bJkKfB/NI3v4
	1sPDE7/HYYov3zJrPrQeuU9IPbHLFsRoIoZLd36uM69vzdNZj0F2QufymKimxN2iLtnn4XEeHZ/
	PeLYL4SHEUPpn20pgRmiq67x/1BrBtjY19IsMQSA4hdZOnfJeNrRBfb6WNaboz2j3MMtzB2ATFU
	/MxyYTPLcKKrf6Tt2s/ut+K5aklWecZ9KNBo4qIWiM9XrtU6ayL57dKpdSlskLAWjP/t3lxO4wq
	kmzgX9DDsqQ==
X-Received: by 2002:a05:6214:4004:b0:753:c0ea:b052 with SMTP id 6a1803df08f44-767c1aa526bmr199160296d6.32.1757962427677;
        Mon, 15 Sep 2025 11:53:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHppdcMBvJ2WP5Fi36gAhmWPSKLhdFB9UoLjIzluvCGRkdZF8W61RhlzlHJjN8ifFtnRv99EA==
X-Received: by 2002:a05:6214:4004:b0:753:c0ea:b052 with SMTP id 6a1803df08f44-767c1aa526bmr199159876d6.32.1757962427051;
        Mon, 15 Sep 2025 11:53:47 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763b54a20b6sm82855186d6.17.2025.09.15.11.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 11:53:46 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <90fb9914-3c6f-4d2a-8512-cebcaa5ddbb6@redhat.com>
Date: Mon, 15 Sep 2025 14:53:45 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC -v2 07/11] cpuset: refactor out
 validate_partition
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250909033233.2731579-1-chenridong@huaweicloud.com>
 <20250909033233.2731579-8-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250909033233.2731579-8-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/25 11:32 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Refactor the validate_partition function to handle cpuset partition
> validation when modifying cpuset.cpus. This refactoring also makes the
> function reusable for handling cpuset.cpus.exclusive updates in subsequent
> patches.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 48 +++++++++++++++++++++++++++++++-----------
>   1 file changed, 36 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 389dfd5be6c8..770b33e30576 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2386,6 +2386,37 @@ static int parse_cpuset_cpulist(const char *buf, struct cpumask *out_mask)
>   	return 0;
>   }
>   
> +/**
> + * validate_partition - Validate a cpuset partition configuration
> + * @cs: The cpuset to validate
> + * @trialcs: The trial cpuset containing proposed configuration changes
> + *
> + * If any validation check fails, the appropriate error code is set in the
> + * cpuset's prs_err field.
> + *
> + * Return: PRS error code (0 if valid, non-zero error code if invalid)
> + */
> +static enum prs_errcode validate_partition(struct cpuset *cs, struct cpuset *trialcs)
> +{
> +	struct cpuset *parent = parent_cs(cs);
> +
> +	if (cs_is_member(trialcs))
> +		return PERR_NONE;
> +
> +	if (cpumask_empty(trialcs->effective_xcpus))
> +		return PERR_INVCPUS;
> +
> +	if (prstate_housekeeping_conflict(trialcs->partition_root_state,
> +					  trialcs->effective_xcpus))
> +		return PERR_HKEEPING;
> +
> +	if (tasks_nocpu_error(parent, cs, trialcs->effective_xcpus))
> +		return PERR_NOCPUS;
> +
> +	return PERR_NONE;
> +}
> +
> +
>   /**
>    * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
>    * @cs: the cpuset to consider
> @@ -2401,6 +2432,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	bool invalidate = false;
>   	bool force = false;
>   	int old_prs = cs->partition_root_state;
> +	enum prs_errcode prs_err;
>   
>   	retval = parse_cpuset_cpulist(buf, trialcs->cpus_allowed);
>   	if (retval < 0)
> @@ -2415,18 +2447,10 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   
>   	compute_trialcs_excpus(trialcs, cs);
>   
> -	if (old_prs) {
> -		if (is_partition_valid(cs) &&
> -		    cpumask_empty(trialcs->effective_xcpus)) {
> -			invalidate = true;
> -			cs->prs_err = PERR_INVCPUS;
> -		} else if (prstate_housekeeping_conflict(old_prs, trialcs->effective_xcpus)) {
> -			invalidate = true;
> -			cs->prs_err = PERR_HKEEPING;
> -		} else if (tasks_nocpu_error(parent, cs, trialcs->effective_xcpus)) {
> -			invalidate = true;
> -			cs->prs_err = PERR_NOCPUS;
> -		}
> +	prs_err = validate_partition(cs, trialcs);
> +	if (prs_err) {
> +		invalidate = true;
> +		cs->prs_err = prs_err;
>   	}
>   
>   	/*
Reviewed-by: Waiman Long <longman@redhat.com>


