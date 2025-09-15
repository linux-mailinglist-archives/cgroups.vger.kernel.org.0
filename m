Return-Path: <cgroups+bounces-10121-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D293CB584F0
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 20:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9BF3B3D76
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 18:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F171323ABA0;
	Mon, 15 Sep 2025 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/G63OGR"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13FC84A3E
	for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757962152; cv=none; b=BCP7EXER+x19eVjSdpAIeTIKnBrCHsPoEuw3iHEkKvxc+U9yKS8Y2KY7JWWetIQ0Ynp2S0Azigcs+g2cY8t6t/cjwYi/o4LOqhEpBhWcid3nZeBYZ/N1oJG40eb5Cb+vSwlddCBib6ABCH5Es54cIt7qTNJCWlnUXJIlW12s80g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757962152; c=relaxed/simple;
	bh=Ldk2SWPviVFCNNNr0HHMvL5tbmBOCu/heCetnLeh4Ak=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Gbks/xP8DNjc1ET75xuDy3AdUQbQ8oeURKugMmjJHPMyUk0aPDxup1R9Nexm+bTUQyOOsDo+23upINxa5rqHhOc1IEpEineistLfoIxd+hCDrbvb3zjE1xMjMrLlJBTuRYaDv/KfB44nIFppiC1dOSf6knyZLKyLHrAWC7R8ypI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q/G63OGR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757962149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jm8gfVBZ7kTZ29XgGNG8P/V5RcE1ds8Nn8Aqd6J8NeY=;
	b=Q/G63OGRbEsV2ka/58WVovPfKy1AUCmIxOdBGYQyP93MkSg7SnyhfVx1RawsjcotnNrntF
	OlBYZkient9tJ81SaVPIRH9eeq2jNGDARV5qjR+Q4kDw0wIFS2OhiaAe3DYpk6g0j34pzI
	qMqlAnraFJuTW6uzlaKqldYxgvrPTrA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-Y6tJy5huMvWOXSdiojbWPQ-1; Mon, 15 Sep 2025 14:49:08 -0400
X-MC-Unique: Y6tJy5huMvWOXSdiojbWPQ-1
X-Mimecast-MFC-AGG-ID: Y6tJy5huMvWOXSdiojbWPQ_1757962148
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-778eac53ed9so56002246d6.2
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 11:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757962148; x=1758566948;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jm8gfVBZ7kTZ29XgGNG8P/V5RcE1ds8Nn8Aqd6J8NeY=;
        b=GOEfbpAUHPBqfucnpttVa9mmhPO/mESdXg82hOHi7Nw0BgxBpSYCRSitOmPJG7cnPk
         OJws0rOCUkj1Eo7ZOyb7B1sGMphfQDbU1Y/BT/k/9+KyRebO01QYCaGIN9G+TB2bRVMT
         vXYlg9hdGWft9tMcrTCkTJxvJ57PLH/7VUJFkrSSWUPHGGA4ft/VGkgfLr6ba/wDS3e2
         EhFWdSzYMsdbXNVlUbO/VyWHKxyijEbaWX2y7Couk8AtqvHipUS7lOgpiuU6/kxp8E/t
         DwXFutVu2FASi+moLm9LCh0H/+Ir/L+Cw/QmTPadEhDcBI49bvvb1OS24aB1xThJ/Fj+
         T/Ig==
X-Gm-Message-State: AOJu0Yxh5CwroAFylY+KWSog74cAgcnEzYRRBAskJfyKhjmzqeMpdOpg
	QwHKZo8xDe1+dQmEymwDWqMKVB4lfAYF1u9+ZqiZ3jrVzR/toaRyLM6Wud9wCrz0Zh/T3vfkC+t
	E8YnupZs0VFZmlk8FViY4JmMHBQEL0ljy9rk2AQbZTpFY67KQKI7NMNk+RMs=
X-Gm-Gg: ASbGncsfuc96frCiWzrkiJmmgUd18HpdxSRQuBQ3D/Lv4EwgtdfP3LbVBae6o4Q3m8p
	lHMddRlsCvCnrQzl9iL25nl8pejo4uS5XRBKYSNivfCV5HIvDwRqhQtYJlU3JEHWQtVBZhT9Tht
	SDHXiSi6BwzVZlyoNtQaRUush9krxqbZNqJh+cYt6MreenNM+3JQb+wUr3XFjPN14CpDg88j9d/
	XEPkyswWmERZurJlPEJTe4SS2iLj0gGao1NCVZFzmp5DqCyrJAg2V6z0Rbt0ZECyJqFEE9GWPCW
	cEcqbJ+/+CGlZoBGhKlOgILZdNLQLhWkxzzfTPh8NxJz4cFhS0TEFSaNqDqMqZFZxJo5rXTPU+3
	TEWVEM9xZnw==
X-Received: by 2002:ad4:5ba3:0:b0:720:e5a:fe3b with SMTP id 6a1803df08f44-767c46cd6c7mr165366546d6.58.1757962147937;
        Mon, 15 Sep 2025 11:49:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo3ntzAafInR/QDbS4xk0XJuXQBwpwYhaIwxitcYDukXsk9+FEmwXEdAJFJ8+MdNz2jYAJ2w==
X-Received: by 2002:ad4:5ba3:0:b0:720:e5a:fe3b with SMTP id 6a1803df08f44-767c46cd6c7mr165366236d6.58.1757962147479;
        Mon, 15 Sep 2025 11:49:07 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7890598971bsm13624556d6.25.2025.09.15.11.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 11:49:07 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <dfc4da47-2694-4470-ba14-ee62b91e52e0@redhat.com>
Date: Mon, 15 Sep 2025 14:49:06 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC -v2 05/11] cpuset: refactor CPU mask buffer
 parsing logic
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250909033233.2731579-1-chenridong@huaweicloud.com>
 <20250909033233.2731579-6-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250909033233.2731579-6-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/25 11:32 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The current implementation contains redundant handling for empty mask
> inputs, as cpulist_parse() already properly handles these cases. This
> refactoring introduces a new helper function parse_cpuset_cpulist() to
> consolidate CPU list parsing logic and eliminate special-case checks for
> empty inputs.
>
> Additionally, the effective_xcpus computation for trial cpusets has been
> simplified. Rather than computing effective_xcpus only when exclusive_cpus
> is set or when the cpuset forms a valid partition, we now recalculate it
> on every cpuset.cpus update. This approach ensures consistency and allows
> removal of redundant effective_xcpus logic in subsequent patches.
>
> The trial cpuset's effective_xcpus calculation follows two distinct cases:
> 1. For member cpusets: effective_xcpus is determined by the intersection
>     of cpuset->exclusive_cpus and the parent's effective_xcpus.
> 2. For non-member cpusets: effective_xcpus is derived from the intersection
>     of user_xcpus and the parent's effective_xcpus.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 59 +++++++++++++++++++++---------------------
>   1 file changed, 30 insertions(+), 29 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 6015322a10ac..55674a5ad2f9 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -169,6 +169,11 @@ static inline bool is_partition_invalid(const struct cpuset *cs)
>   	return cs->partition_root_state < 0;
>   }
>   
> +static inline bool cs_is_member(const struct cpuset *cs)
> +{
> +	return cs->partition_root_state == PRS_MEMBER;
> +}
> +
>   /*
>    * Callers should hold callback_lock to modify partition_root_state.
>    */
> @@ -1478,7 +1483,13 @@ static int compute_trialcs_excpus(struct cpuset *trialcs, struct cpuset *cs)
>   	struct cpuset *parent = parent_cs(trialcs);
>   	struct cpumask *excpus = trialcs->effective_xcpus;
>   
> -	cpumask_and(excpus, user_xcpus(trialcs), parent->effective_xcpus);
> +	/* trialcs is member, cpuset.cpus has no impact to excpus */
> +	if (cs_is_member(cs))
> +		cpumask_and(excpus, trialcs->exclusive_cpus,
> +				parent->effective_xcpus);
> +	else
> +		cpumask_and(excpus, user_xcpus(trialcs), parent->effective_xcpus);
> +
>   	return rm_siblings_excl_cpus(parent, cs, excpus);
>   }
>   
> @@ -2348,6 +2359,19 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
>   	rcu_read_unlock();
>   }
>   
> +static int parse_cpuset_cpulist(const char *buf, struct cpumask *out_mask)
> +{
> +	int retval;
> +
> +	retval = cpulist_parse(buf, out_mask);
> +	if (retval < 0)
> +		return retval;
> +	if (!cpumask_subset(out_mask, top_cpuset.cpus_allowed))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>   /**
>    * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
>    * @cs: the cpuset to consider
> @@ -2364,34 +2388,9 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	bool force = false;
>   	int old_prs = cs->partition_root_state;
>   
> -	/*
> -	 * An empty cpus_allowed is ok only if the cpuset has no tasks.
> -	 * Since cpulist_parse() fails on an empty mask, we special case
> -	 * that parsing.  The validate_change() call ensures that cpusets
> -	 * with tasks have cpus.
> -	 */
> -	if (!*buf) {
> -		cpumask_clear(trialcs->cpus_allowed);
> -		if (cpumask_empty(trialcs->exclusive_cpus))
> -			cpumask_clear(trialcs->effective_xcpus);
> -	} else {
> -		retval = cpulist_parse(buf, trialcs->cpus_allowed);
> -		if (retval < 0)
> -			return retval;
> -
> -		if (!cpumask_subset(trialcs->cpus_allowed,
> -				    top_cpuset.cpus_allowed))
> -			return -EINVAL;
> -
> -		/*
> -		 * When exclusive_cpus isn't explicitly set, it is constrained
> -		 * by cpus_allowed and parent's effective_xcpus. Otherwise,
> -		 * trialcs->effective_xcpus is used as a temporary cpumask
> -		 * for checking validity of the partition root.
> -		 */
> -		if (!cpumask_empty(trialcs->exclusive_cpus) || is_partition_valid(cs))
> -			compute_trialcs_excpus(trialcs, cs);
> -	}
> +	retval = parse_cpuset_cpulist(buf, trialcs->cpus_allowed);
> +	if (retval < 0)
> +		return retval;
>   
>   	/* Nothing to do if the cpus didn't change */
>   	if (cpumask_equal(cs->cpus_allowed, trialcs->cpus_allowed))
> @@ -2400,6 +2399,8 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	if (alloc_tmpmasks(&tmp))
>   		return -ENOMEM;
>   
> +	compute_trialcs_excpus(trialcs, cs);
> +
>   	if (old_prs) {
>   		if (is_partition_valid(cs) &&
>   		    cpumask_empty(trialcs->effective_xcpus)) {
Reviewed-by: Waiman Long <longman@redhat.com>


