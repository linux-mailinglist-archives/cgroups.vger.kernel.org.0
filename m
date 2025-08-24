Return-Path: <cgroups+bounces-9360-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59757B33191
	for <lists+cgroups@lfdr.de>; Sun, 24 Aug 2025 19:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1546B1B20FDA
	for <lists+cgroups@lfdr.de>; Sun, 24 Aug 2025 17:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B5A1F5619;
	Sun, 24 Aug 2025 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SH+J9Dm4"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07431DF968
	for <cgroups@vger.kernel.org>; Sun, 24 Aug 2025 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756055129; cv=none; b=RLiycv1/OY9kl1t4WPHWSBdinuSCJEq7JP7OB1r+OqnB8OQZ86r6qED//0JcgugVrQKO5TGsUGjDxOOLrwwTj/zLpjMyX36/yuSbNccLQAcgmondSvjI6c+PvGmijzjYkmi2ARD20XWx36SP8D1kdjIjmEHPntjRuN8NndBmduE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756055129; c=relaxed/simple;
	bh=+gXyxD/FxzgurSb+TaoB7tPfHS2XOVjo4E24unteKDs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bND+WWrn1laflOTuM+EF1LcsQxPfvsR/mqw8/qLp9FFWib0h6cXM32UbZSCuAhRGC3gKsalXhSzIcS0FGZUWfOYvZTnzoZEAthKd2r5/WffzP8GKIZSeLYEuHiANQkYJoMycOsNp8vxD6BTNacEKXhFDjIFiU92Ta11DvmGOR9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SH+J9Dm4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756055126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ebk50XJ5aBZpDlGgruPIO2wKskukMvv2mXJM5o43iUI=;
	b=SH+J9Dm4cJYrLsuX7MSSfyI+zPoxskjpwxX/Pd5o2ERZkoXK0YyzwE7jIwwv5NqsvNngQt
	xn9OM/hh06ERJg94EobdvuVyCtpWjKv2kybuKDTtm53e8yipkHMbaP8C/6PLVtkb4f08cu
	8pga/CPlJFbbAaWM9VKEF9Zd2pvABaw=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-ZwkiQGBgOKWHGT3MvPQ01A-1; Sun, 24 Aug 2025 13:05:25 -0400
X-MC-Unique: ZwkiQGBgOKWHGT3MvPQ01A-1
X-Mimecast-MFC-AGG-ID: ZwkiQGBgOKWHGT3MvPQ01A_1756055124
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-71fee811ed4so26016567b3.1
        for <cgroups@vger.kernel.org>; Sun, 24 Aug 2025 10:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756055124; x=1756659924;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ebk50XJ5aBZpDlGgruPIO2wKskukMvv2mXJM5o43iUI=;
        b=v9RCfghCsSSRHIL+D+y/kWecJnf8s4Lip0tJw7aQeEBuhSKTmGR3ZBmCjgoMp38w3a
         qdONVf58qpd8dACR7dEgzWNdBGvY64d0HXUYUg+PWqP8BMnKhMcO2ly3u4gbZ81ERBhK
         nkWQhlkl4z8Nl9v7phLT8adyP+YskA40D5sfrpjZXPxF1Cdi98Gi0gzUWDGmhXaTWEWl
         QzQmSk/KKanR7tNgaGxO64jF/Poc087bxpLEThKp3YvyqEFYPo1PhNCED8zOMi/KfNl/
         8NqM37FtB3R7urDO6EHRLVAyZTBv6bkBOTTsczoeGXg/S2AEZLHr4n+73Myxyc++7rms
         5wag==
X-Gm-Message-State: AOJu0YxiOBoUsabBdEGGG67KdifZl3zcOL+LIWJyS2Y4siD/m+v56OAl
	hy+PG6SoTS/bWMmP2oZIXK/j/4gCeeX44El0XWkFzyo6faBOmRZM7YPNjJdQ/+03qLm6ajjD0T2
	8amTxQB//uSZRKkCPmtLuhOOTphbzSuurBV2uhrsDigtY2IRrIqwl380pzj8=
X-Gm-Gg: ASbGnctCnWvq8cLvco7fZYU0Lqt2RIk/uq+92gYX8PJtohRO/UP4QxpNLH4u20kLeol
	izdgC0UTs1d3QCS9ogO6JYLA6VJcC8hPQ6b/YsBiTHeqFWvgI2IRjFFeB5iOcQMljnH02MDoRWV
	jkno6XlC59Fjw6RscvrZw9fJEhGu4hVNwjAV42+V129cFoPX4kUVXhMQ+RFwIeOR/eo5gzSxeD2
	LsKyM/lPKgrq6NfuHbFlJrnMcxqbpVbW9TMZWveQIaxWuG7Z28yS6s61ONVMDSwJKzBajDWPrpJ
	D3iS1dARYKiLshW69RQLXNuh23XJnMx3mIbra+zAlRaT7KnMz0UbkxNdzco0PSKsCtxcAMjHOjN
	jO9mR22f/+A==
X-Received: by 2002:a05:690c:7286:b0:71e:6583:7d37 with SMTP id 00721157ae682-71fc9f1ecf0mr125649707b3.14.1756055124345;
        Sun, 24 Aug 2025 10:05:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/J+Luf7Qg54td3ILGcBBdVf0JpOfbrxB1sftPC23mthSTIISxqOToHijO+yObw95KPV/nMg==
X-Received: by 2002:a05:690c:7286:b0:71e:6583:7d37 with SMTP id 00721157ae682-71fc9f1ecf0mr125649357b3.14.1756055123743;
        Sun, 24 Aug 2025 10:05:23 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff173633esm12308057b3.27.2025.08.24.10.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 10:05:23 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0b918f11-d850-4cdb-b9af-ffa436b8fd1e@redhat.com>
Date: Sun, 24 Aug 2025 13:05:21 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v4 2/3] cpuset: separate tmpmasks and cpuset
 allocation logic
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250818064141.1334859-1-chenridong@huaweicloud.com>
 <20250818064141.1334859-3-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250818064141.1334859-3-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/18/25 2:41 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The original alloc_cpumasks() served dual purposes: allocating cpumasks
> for both temporary masks (tmpmasks) and cpuset structures. This patch:
>
> 1. Decouples these allocation paths for better code clarity
> 2. Introduces dedicated alloc_tmpmasks() and dup_or_alloc_cpuset()
>     functions
> 3. Maintains symmetric pairing:
>     - alloc_tmpmasks() ↔ free_tmpmasks()
>     - dup_or_alloc_cpuset() ↔ free_cpuset()
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 128 ++++++++++++++++++++++-------------------
>   1 file changed, 69 insertions(+), 59 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index aebda14cc67f..d5588a1fef60 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -411,51 +411,46 @@ static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
>   }
>   
>   /**
> - * alloc_cpumasks - allocate three cpumasks for cpuset
> - * @cs:  the cpuset that have cpumasks to be allocated.
> - * @tmp: the tmpmasks structure pointer
> - * Return: 0 if successful, -ENOMEM otherwise.
> + * alloc_cpumasks - Allocate an array of cpumask variables
> + * @pmasks: Pointer to array of cpumask_var_t pointers
> + * @size: Number of cpumasks to allocate
>    *
> - * Only one of the two input arguments should be non-NULL.
> + * Allocates @size cpumasks and initializes them to empty. Returns 0 on
> + * success, -ENOMEM on allocation failure. On failure, any previously
> + * allocated cpumasks are freed.

The convention for the kernel-doc is to have a "Return:" tag if the 
function has a returned value. That "Return:" tag is deleted by this 
change. Your description does describe the returned value and no test 
robot failure was reported. Other than that, the rest of the patch looks 
good to me.

Cheers,
Longman

>    */
> -static inline int alloc_cpumasks(struct cpuset *cs, struct tmpmasks *tmp)
> +static inline int alloc_cpumasks(cpumask_var_t *pmasks[], u32 size)
>   {
> -	cpumask_var_t *pmask1, *pmask2, *pmask3, *pmask4;
> +	int i;
>   
> -	if (cs) {
> -		pmask1 = &cs->cpus_allowed;
> -		pmask2 = &cs->effective_cpus;
> -		pmask3 = &cs->effective_xcpus;
> -		pmask4 = &cs->exclusive_cpus;
> -	} else {
> -		pmask1 = &tmp->new_cpus;
> -		pmask2 = &tmp->addmask;
> -		pmask3 = &tmp->delmask;
> -		pmask4 = NULL;
> +	for (i = 0; i < size; i++) {
> +		if (!zalloc_cpumask_var(pmasks[i], GFP_KERNEL)) {
> +			while (--i >= 0)
> +				free_cpumask_var(*pmasks[i]);
> +			return -ENOMEM;
> +		}
>   	}
> -
> -	if (!zalloc_cpumask_var(pmask1, GFP_KERNEL))
> -		return -ENOMEM;
> -
> -	if (!zalloc_cpumask_var(pmask2, GFP_KERNEL))
> -		goto free_one;
> -
> -	if (!zalloc_cpumask_var(pmask3, GFP_KERNEL))
> -		goto free_two;
> -
> -	if (pmask4 && !zalloc_cpumask_var(pmask4, GFP_KERNEL))
> -		goto free_three;
> -
> -
>   	return 0;
> +}
>   
> -free_three:
> -	free_cpumask_var(*pmask3);
> -free_two:
> -	free_cpumask_var(*pmask2);
> -free_one:
> -	free_cpumask_var(*pmask1);
> -	return -ENOMEM;
> +/**
> + * alloc_tmpmasks - Allocate temporary cpumasks for cpuset operations.
> + * @tmp: Pointer to tmpmasks structure to populate
> + * Return: 0 on success, -ENOMEM on allocation failure
> + */
> +static inline int alloc_tmpmasks(struct tmpmasks *tmp)
> +{
> +	/*
> +	 * Array of pointers to the three cpumask_var_t fields in tmpmasks.
> +	 * Note: Array size must match actual number of masks (3)
> +	 */
> +	cpumask_var_t *pmask[3] = {
> +		&tmp->new_cpus,
> +		&tmp->addmask,
> +		&tmp->delmask
> +	};
> +
> +	return alloc_cpumasks(pmask, ARRAY_SIZE(pmask));
>   }
>   
>   /**
> @@ -470,26 +465,46 @@ static inline void free_tmpmasks(struct tmpmasks *tmp)
>   }
>   
>   /**
> - * alloc_trial_cpuset - allocate a trial cpuset
> - * @cs: the cpuset that the trial cpuset duplicates
> + * dup_or_alloc_cpuset - Duplicate or allocate a new cpuset
> + * @cs: Source cpuset to duplicate (NULL for a fresh allocation)
> + *
> + * Creates a new cpuset by either:
> + * 1. Duplicating an existing cpuset (if @cs is non-NULL), or
> + * 2. Allocating a fresh cpuset with zero-initialized masks (if @cs is NULL)
> + *
> + * Return: Pointer to newly allocated cpuset on success, NULL on failure
>    */
> -static struct cpuset *alloc_trial_cpuset(struct cpuset *cs)
> +static struct cpuset *dup_or_alloc_cpuset(struct cpuset *cs)
>   {
>   	struct cpuset *trial;
>   
> -	trial = kmemdup(cs, sizeof(*cs), GFP_KERNEL);
> +	/* Allocate base structure */
> +	trial = cs ? kmemdup(cs, sizeof(*cs), GFP_KERNEL) :
> +		     kzalloc(sizeof(*cs), GFP_KERNEL);
>   	if (!trial)
>   		return NULL;
>   
> -	if (alloc_cpumasks(trial, NULL)) {
> +	/* Setup cpumask pointer array */
> +	cpumask_var_t *pmask[4] = {
> +		&trial->cpus_allowed,
> +		&trial->effective_cpus,
> +		&trial->effective_xcpus,
> +		&trial->exclusive_cpus
> +	};
> +
> +	if (alloc_cpumasks(pmask, ARRAY_SIZE(pmask))) {
>   		kfree(trial);
>   		return NULL;
>   	}
>   
> -	cpumask_copy(trial->cpus_allowed, cs->cpus_allowed);
> -	cpumask_copy(trial->effective_cpus, cs->effective_cpus);
> -	cpumask_copy(trial->effective_xcpus, cs->effective_xcpus);
> -	cpumask_copy(trial->exclusive_cpus, cs->exclusive_cpus);
> +	/* Copy masks if duplicating */
> +	if (cs) {
> +		cpumask_copy(trial->cpus_allowed, cs->cpus_allowed);
> +		cpumask_copy(trial->effective_cpus, cs->effective_cpus);
> +		cpumask_copy(trial->effective_xcpus, cs->effective_xcpus);
> +		cpumask_copy(trial->exclusive_cpus, cs->exclusive_cpus);
> +	}
> +
>   	return trial;
>   }
>   
> @@ -2332,7 +2347,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	if (cpumask_equal(cs->cpus_allowed, trialcs->cpus_allowed))
>   		return 0;
>   
> -	if (alloc_cpumasks(NULL, &tmp))
> +	if (alloc_tmpmasks(&tmp))
>   		return -ENOMEM;
>   
>   	if (old_prs) {
> @@ -2476,7 +2491,7 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	if (retval)
>   		return retval;
>   
> -	if (alloc_cpumasks(NULL, &tmp))
> +	if (alloc_tmpmasks(&tmp))
>   		return -ENOMEM;
>   
>   	if (old_prs) {
> @@ -2820,7 +2835,7 @@ int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
>   	int spread_flag_changed;
>   	int err;
>   
> -	trialcs = alloc_trial_cpuset(cs);
> +	trialcs = dup_or_alloc_cpuset(cs);
>   	if (!trialcs)
>   		return -ENOMEM;
>   
> @@ -2881,7 +2896,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   	if (new_prs && is_prs_invalid(old_prs))
>   		old_prs = PRS_MEMBER;
>   
> -	if (alloc_cpumasks(NULL, &tmpmask))
> +	if (alloc_tmpmasks(&tmpmask))
>   		return -ENOMEM;
>   
>   	err = update_partition_exclusive_flag(cs, new_prs);
> @@ -3223,7 +3238,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   	if (!is_cpuset_online(cs))
>   		goto out_unlock;
>   
> -	trialcs = alloc_trial_cpuset(cs);
> +	trialcs = dup_or_alloc_cpuset(cs);
>   	if (!trialcs) {
>   		retval = -ENOMEM;
>   		goto out_unlock;
> @@ -3456,15 +3471,10 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
>   	if (!parent_css)
>   		return &top_cpuset.css;
>   
> -	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
> +	cs = dup_or_alloc_cpuset(NULL);
>   	if (!cs)
>   		return ERR_PTR(-ENOMEM);
>   
> -	if (alloc_cpumasks(cs, NULL)) {
> -		kfree(cs);
> -		return ERR_PTR(-ENOMEM);
> -	}
> -
>   	__set_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
>   	fmeter_init(&cs->fmeter);
>   	cs->relax_domain_level = -1;
> @@ -3920,7 +3930,7 @@ static void cpuset_handle_hotplug(void)
>   	bool on_dfl = is_in_v2_mode();
>   	struct tmpmasks tmp, *ptmp = NULL;
>   
> -	if (on_dfl && !alloc_cpumasks(NULL, &tmp))
> +	if (on_dfl && !alloc_tmpmasks(&tmp))
>   		ptmp = &tmp;
>   
>   	lockdep_assert_cpus_held();


