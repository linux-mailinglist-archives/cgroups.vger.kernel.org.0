Return-Path: <cgroups+bounces-9386-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA923B34906
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 19:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CACAF1B23079
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 17:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1D7301020;
	Mon, 25 Aug 2025 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjWSR4uL"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DD7306D21
	for <cgroups@vger.kernel.org>; Mon, 25 Aug 2025 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143467; cv=none; b=fRmqRYmhtRwVj1oYPO/aZ2ncQbvDk1djl3KVZeZUMgJkYVGO8ANY1lPSv1u4bdX30fjX4Xpahs53eTtUv3uBa5PWMra99NDND0bqzSJsujTqWb1stYIo29SnDKL12mtJ1PRyvcLRakvzOCKegNwfvLWaf/4RzdlcgRR6kZVKNsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143467; c=relaxed/simple;
	bh=gKFp+3LWEZd2OskwR6+PdmPLElHNh5RF2wqDkE0XTtk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hTxyIujzmLuJZ8ileQFs2bbOfLYU+N20UPY+7Rvn/KH6/e2q/Wglp0ZfEC0quz3QeBXavcas0udBM3NOPQY1OkQE6tql0t2y60f+fLXSao+HmuCBZo8g2NjgwewNDTwdD1FD0CSmwNLYokNK7szDUFXTsNJ2kUOAq2sug8RYucM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YjWSR4uL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756143462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ve+LT1gr3RmdXu0cmIXtW+TLkn86wKGFR73EOyV/lw=;
	b=YjWSR4uLtqyAt2T+JALnPFOIpTIDQDxBDM1VaqLHM+elyr+1BbDnJRPIfL2OKKVt/v5Ztv
	QGxpSN747ERzlaMqkqRa55hSIg4wQBmIPltG6Z6DTwhCIXw31R4nX2jcTsVzEpiNClOlmS
	UKDnjZp7OP509Blp2lpTE0D/Rd/knxo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-FEZ_m7GJMrySezWvW2TyHQ-1; Mon, 25 Aug 2025 13:37:41 -0400
X-MC-Unique: FEZ_m7GJMrySezWvW2TyHQ-1
X-Mimecast-MFC-AGG-ID: FEZ_m7GJMrySezWvW2TyHQ_1756143460
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70d9eb2ec70so30768856d6.0
        for <cgroups@vger.kernel.org>; Mon, 25 Aug 2025 10:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756143460; x=1756748260;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ve+LT1gr3RmdXu0cmIXtW+TLkn86wKGFR73EOyV/lw=;
        b=tsQaaG3bg55V+mK6Y9P9Y7u4FCQ18qsG+0iqx+YtThgwIbQ8gXPBZJhxGgfcnQH2sR
         XfSuLFyIZ7nmZy9f3CyGzNTrciAVn7MvBY1ovnmnAcdz9VkMN0/quRbYYAor8ndGpBim
         QRccVo+pZqjMT3yXy8uVq4RGf88amtrlGSkkq9ma9vBzQgTfTE3WJ/Zp0WX5qcb6vfrO
         JbV5BKaWjOjnhDjRDm/UOacVbrr+nptNAhHQpKX++8p/6136ti9Lh+7q/hU9C7PXsEpc
         Ljhov3v9iTP6tBT1DbTc2EdhAER3TyVnfG2MYj9wChjNTGXsNc2T1B7hQhk1ovnA9giP
         grfA==
X-Gm-Message-State: AOJu0YyV80PeXEx647LtrJi0EM+Q2ucA+3rVcjVKsyh9AeMgvng/oOXp
	1Rni8tcwtBEX/EQ23ibvLV5qu0D+0HPWLFySTZgvekHkZXmKOOsv/j6AeYkvlxjy/zYl5VREOaa
	uuBgpuxiXsrf3ncetXIGBs6XWBXEMo2CRVmxCpiABrQ2dvV/JnsArbiWbQq8=
X-Gm-Gg: ASbGncvAG4ZmApRUCJQqyWKofdGB4H4/RNpMcVWmQymwHBcDK/e4p20QVpg0vYdHTY/
	OTED34gbaJw9jeHOa5rUsyyYTnKdoVm8qLMOdvZZT/txbEqJMVnknsWY1LsmsfKZkwN7wuzXh9E
	jpf1YbyCDLFvMK+Dgx1riUIiFU9QE9AAVCsTv45JIhJAaoU7drjbasg4+3/hMOTupeEWP3ZbqH8
	jSUIk2Cl0uZocLWeEBPRhoMLipTar2Jy0H0sqVFe/IV4wSIUwyi2yldi63Dj3f2tbaLNJjFEX9D
	wcQDr8QFAcrUkonmpb4+pmJVQAAuOnnjVp+gbG0IDsQ2MffHaKuYVRpW5h8uriWsUze453C4dfG
	dafxnjm0gBg==
X-Received: by 2002:a05:6214:5242:b0:70d:9aaa:f796 with SMTP id 6a1803df08f44-70d9aaaff18mr144667196d6.8.1756143460585;
        Mon, 25 Aug 2025 10:37:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkzSCnUYXG2ipGW+y0grlRf78bEPwIBBCyN2G+85pDlkPkyeL3S9WDWNSchLDNYel3xABy8Q==
X-Received: by 2002:a05:6214:5242:b0:70d:9aaa:f796 with SMTP id 6a1803df08f44-70d9aaaff18mr144666826d6.8.1756143460046;
        Mon, 25 Aug 2025 10:37:40 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da7187f30sm50327946d6.34.2025.08.25.10.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 10:37:39 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f581b215-ade9-44c5-8e93-7181690d55ab@redhat.com>
Date: Mon, 25 Aug 2025 13:37:38 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v5 2/3] cpuset: separate tmpmasks and cpuset
 allocation logic
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250825032352.1703602-1-chenridong@huaweicloud.com>
 <20250825032352.1703602-3-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250825032352.1703602-3-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/24/25 11:23 PM, Chen Ridong wrote:
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
>   kernel/cgroup/cpuset.c | 127 ++++++++++++++++++++++-------------------
>   1 file changed, 69 insertions(+), 58 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index aebda14cc67f..7b0b81c835bf 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -411,51 +411,47 @@ static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
>   }
>   
>   /**
> - * alloc_cpumasks - allocate three cpumasks for cpuset
> - * @cs:  the cpuset that have cpumasks to be allocated.
> - * @tmp: the tmpmasks structure pointer
> + * alloc_cpumasks - Allocate an array of cpumask variables
> + * @pmasks: Pointer to array of cpumask_var_t pointers
> + * @size: Number of cpumasks to allocate
>    * Return: 0 if successful, -ENOMEM otherwise.
>    *
> - * Only one of the two input arguments should be non-NULL.
> + * Allocates @size cpumasks and initializes them to empty. Returns 0 on
> + * success, -ENOMEM on allocation failure. On failure, any previously
> + * allocated cpumasks are freed.
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
> @@ -470,26 +466,46 @@ static inline void free_tmpmasks(struct tmpmasks *tmp)
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
> @@ -2332,7 +2348,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	if (cpumask_equal(cs->cpus_allowed, trialcs->cpus_allowed))
>   		return 0;
>   
> -	if (alloc_cpumasks(NULL, &tmp))
> +	if (alloc_tmpmasks(&tmp))
>   		return -ENOMEM;
>   
>   	if (old_prs) {
> @@ -2476,7 +2492,7 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	if (retval)
>   		return retval;
>   
> -	if (alloc_cpumasks(NULL, &tmp))
> +	if (alloc_tmpmasks(&tmp))
>   		return -ENOMEM;
>   
>   	if (old_prs) {
> @@ -2820,7 +2836,7 @@ int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
>   	int spread_flag_changed;
>   	int err;
>   
> -	trialcs = alloc_trial_cpuset(cs);
> +	trialcs = dup_or_alloc_cpuset(cs);
>   	if (!trialcs)
>   		return -ENOMEM;
>   
> @@ -2881,7 +2897,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   	if (new_prs && is_prs_invalid(old_prs))
>   		old_prs = PRS_MEMBER;
>   
> -	if (alloc_cpumasks(NULL, &tmpmask))
> +	if (alloc_tmpmasks(&tmpmask))
>   		return -ENOMEM;
>   
>   	err = update_partition_exclusive_flag(cs, new_prs);
> @@ -3223,7 +3239,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   	if (!is_cpuset_online(cs))
>   		goto out_unlock;
>   
> -	trialcs = alloc_trial_cpuset(cs);
> +	trialcs = dup_or_alloc_cpuset(cs);
>   	if (!trialcs) {
>   		retval = -ENOMEM;
>   		goto out_unlock;
> @@ -3456,15 +3472,10 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
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
> @@ -3920,7 +3931,7 @@ static void cpuset_handle_hotplug(void)
>   	bool on_dfl = is_in_v2_mode();
>   	struct tmpmasks tmp, *ptmp = NULL;
>   
> -	if (on_dfl && !alloc_cpumasks(NULL, &tmp))
> +	if (on_dfl && !alloc_tmpmasks(&tmp))
>   		ptmp = &tmp;
>   
>   	lockdep_assert_cpus_held();
Reviewed-by: Waiman Long <longman@redhat.com>


