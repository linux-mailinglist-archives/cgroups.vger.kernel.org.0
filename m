Return-Path: <cgroups+bounces-11894-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFA1C54A86
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 22:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 465CB343B97
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 21:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138C52E2661;
	Wed, 12 Nov 2025 21:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkUsk49j";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEPl2zYV"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1492C15B4
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984056; cv=none; b=ZXf9giSjemHx1ioG89sRqoDpo6YhtDjLNevlM0AQEJ/aBV45HJBy6FANdDkonzIR35htHz8x20qpZMEQgjzB93VSkMsfEx7xwryoSg96yVIa5kmNWl2BVUdc+PHXRbDX9jPnikrpyAQWCSUT+SKlxPucOS047lSifKdutXyBYUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984056; c=relaxed/simple;
	bh=Lwm42Hb4hUzXUXpfzF7KSl9F6xg9nPy6lde4b1jbDa4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kQAOR+hXfeaDqppvgxldpnLfLhHQaHrvxjExjsOhvGrVUUtzsBsfktCeluU6gYFAg/RwFrPI3bHPgAcB4mvt/rhz07XZNrf9mbkyJuAuhnZ0XEzQF98RS9xpav4euCXkF/C8Vbuli+UWVnL2kanqqIOZ0zMIVhvPofHxyFbPTA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IkUsk49j; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PEPl2zYV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762984053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ck8q8oI0lDTkiFTq2ghKwr6ozvgvpKJLairYN13kEJQ=;
	b=IkUsk49j9Z5Kb9/nuksGmjyjOC3hIUrHyR5bpA2PDX82s7X3s36QmHaTO5+FB3ZHJWIeWO
	9ja6l7fF92WaLS3VFI8RpDOMzVC4ywmX7UudVJaiZIw+eYwzHRuhaTp60nfLu7MG8GFloz
	2wDNZwTCpuq9pFY9G1TLtsM2svCgmTo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-ZapvGFB4OgyjAnVAh9J4yQ-1; Wed, 12 Nov 2025 16:47:32 -0500
X-MC-Unique: ZapvGFB4OgyjAnVAh9J4yQ-1
X-Mimecast-MFC-AGG-ID: ZapvGFB4OgyjAnVAh9J4yQ_1762984052
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b233e206ddso57066785a.3
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 13:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762984052; x=1763588852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ck8q8oI0lDTkiFTq2ghKwr6ozvgvpKJLairYN13kEJQ=;
        b=PEPl2zYVyM3Gl+jnaTCsOjN6JRCkUzpL9/l9wNqP0kbJcnp7areqpqpK9lUsWz/HjS
         t3Ysr56fZ4RuZCyWmDEn6hsSIRZJyJSLSROSaGQpyz5Cw9AnEHbuKji/hhABy94o2tQW
         a3Gv/6OSyFLUjDTFQuIYV2Mrri4aQV9YdJrLcpWFLoJI4OxaDAQXols6YhBqyw/5GH3H
         maNmISaeUzsSqguYrEU5611dxPRmdQgf2IjHX0Vj1kiBG/rXRRUbRrUMj8B7ZMux+qPa
         IB9FGXlKxRsLZkzPOb5z2tbA+kl98FlKsalGjC3H6ef0djPY4bdCdfKzocGAKJzWCD7T
         60CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762984052; x=1763588852;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ck8q8oI0lDTkiFTq2ghKwr6ozvgvpKJLairYN13kEJQ=;
        b=GjedjEyeOao1aM/3UDIaukTLDH1HWWSoFFnS2ei9evLcDJa8f5kuVkMdwHNv4+/tR9
         a35+lYjLWNb+cFoEwAdxjUzL0bYVzY1ZW33+px8mFhSY65qIp4jdK++c5ISAq2sWA28x
         /Lgi9owJFEajOViEEh1gz7YsqlGf3DmSekkGliDj2taBVhd0AFTstGn/fzErlHvVAm/0
         5DGCfikSD5Hsgm4aKUD7TURtz7GTFMaqRQmMEwuscaj86Ts+84cpoFvwZDux7bILr04h
         2t01L990NTrkGXB1KE7A/T3KscZMr4VyuQuIYw1SoW+w3mb+YzuJxeDW745BYX0aiPr5
         UnFg==
X-Gm-Message-State: AOJu0YxMsvbaFc7dvHduSnQRKdIB7aQBlaZis6/XYaGI3RfVaJGdNE2/
	2RozGtSeNLjPd56aAhDOqIEGyvUAVXPn0n65uAIod0RWuY9yzUj1iErWaMtsN24pxR6oo0pC1K9
	otHQEfCwjMa3/hdh3d5DnkX6jrnzlPLByA8s+1Kejukd1Rq14k6kdr7IAOZ0=
X-Gm-Gg: ASbGncuj3n8OiHRRinORQBL/I91TWiZMQrBIoj7pgX+LrCUI57tUi9pk0vgzQhgX9lu
	rRfPF4J322t00skjrGpgataBs7n0fjpAxIZZ4qyj6b5m9ZgETnFhZsIWnaYHHH/BYjTyjtC0+h2
	4R5UlSfZgbvCrB/Ga5Qj3BPLu/PkPrzRUhw547KEflR9nIOqLyh/LMYuWRkn0ksGH1ScNfa38/r
	uQgqkNGOTUbZMUwWNsXZTzfJtSeGVimHs6z7QrHfGVzk0zSq3Gh8DfqVWwg6qJ8sGMKpTqfMAvb
	uEIbV08/6+zNNc6DrGDiCuRtUvRK+OGez34hqT5lynb5qpIEk+YiUMCTaPsORW4cTTPksyrb1ws
	RprvHi6d4XucmzY13tR2gRjNLB86uMgSYGPGqpYhHfoIVjA==
X-Received: by 2002:a05:620a:bc2:b0:8b0:f2bd:476a with SMTP id af79cd13be357-8b29b7678cdmr652755685a.7.1762984052060;
        Wed, 12 Nov 2025 13:47:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3uFERiAdoN0Er5gEHDn8EMz1PnIBjBfP+y3k2X2VOwH+a1gXv/ywyhBgSyOl/GYcEIhsXBg==
X-Received: by 2002:a05:620a:bc2:b0:8b0:f2bd:476a with SMTP id af79cd13be357-8b29b7678cdmr652752885a.7.1762984051591;
        Wed, 12 Nov 2025 13:47:31 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aeeb541esm4330885a.18.2025.11.12.13.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 13:47:31 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <71121d12-0cb2-4ffe-92e5-caf25bf4596e@redhat.com>
Date: Wed, 12 Nov 2025 16:47:30 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 10/22] cpuset: introduce local_partition_enable()
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <20251025064844.495525-11-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251025064844.495525-11-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/25/25 2:48 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The partition_enable() function introduced in the previous patch can be
> reused to enable local partitions.
>
> The local_partition_enable() function is introduced, which factors out the
> local partition enablement logic from update_parent_effective_cpumask().
> After passing local partition validation checks, it delegates to
> partition_enable() to complete the partition setup.
>
> This refactoring creates a clear separation between local and remote
> partition operations while maintaining code reuse through the shared
> partition_enable() infrastructure.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 94 ++++++++++++++++++++++++++----------------
>   1 file changed, 59 insertions(+), 35 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 5b57c5370641..b308d9f80eef 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1822,6 +1822,61 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>   	remote_partition_disable(cs, tmp);
>   }
>   
> +/**
> + * local_partition_enable - Enable local partition for a cpuset
> + * @cs: Target cpuset to become a local partition root
> + * @new_prs: New partition root state to apply
> + * @tmp: Temporary masks for CPU calculations
> + *
> + * This function enables local partition root capability for a cpuset by
> + * validating prerequisites, computing exclusive CPUs, and updating the
> + * partition hierarchy.
> + *
> + * Return: 0 on success, error code on failure
> + */
> +static int local_partition_enable(struct cpuset *cs,
> +				int new_prs, struct tmpmasks *tmp)
> +{
> +	struct cpuset *parent = parent_cs(cs);
> +	enum prs_errcode part_error;
> +	bool cpumask_updated = false;
> +
> +	lockdep_assert_held(&cpuset_mutex);
> +	WARN_ON_ONCE(is_remote_partition(cs));	/* For local partition only */
> +
> +	/*
> +	 * The parent must be a partition root.
> +	 * The new cpumask, if present, or the current cpus_allowed must
> +	 * not be empty.
> +	 */
> +	if (!is_partition_valid(parent)) {
> +		return is_partition_invalid(parent)
> +			? PERR_INVPARENT : PERR_NOTPART;
> +	}
> +
> +	/*
> +	 * Need to call compute_excpus() in case
> +	 * exclusive_cpus not set. Sibling conflict should only happen
> +	 * if exclusive_cpus isn't set.
> +	 */
> +	if (compute_excpus(cs, tmp->new_cpus))
> +		WARN_ON_ONCE(!cpumask_empty(cs->exclusive_cpus));
> +
> +	part_error = validate_partition(cs, new_prs, tmp->new_cpus);
> +	if (part_error)
> +		return part_error;
> +
> +	cpumask_updated = cpumask_andnot(tmp->addmask, tmp->new_cpus,
> +					 parent->effective_cpus);

What is the purpose of this cpumask_andnot() operation? Is it just to 
create the cpumask_updated boolean? At this point, cpumask_updated 
should always be true. If not, we have to add validation check to return 
an error.

Cheers,
Longman

> +	partition_enable(cs, parent, new_prs, tmp->new_cpus);
> +
> +	if (cpumask_updated) {
> +		cpuset_update_tasks_cpumask(parent, tmp->addmask);
> +		update_sibling_cpumasks(parent, cs, tmp);
> +	}
> +	return 0;
> +}
> +
>   /**
>    * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
>    * @cs:      The cpuset that requests change in partition root state
> @@ -1912,34 +1967,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   
>   	nocpu = tasks_nocpu_error(parent, cs, xcpus);
>   
> -	if ((cmd == partcmd_enable) || (cmd == partcmd_enablei)) {
> -		/*
> -		 * Need to call compute_excpus() in case
> -		 * exclusive_cpus not set. Sibling conflict should only happen
> -		 * if exclusive_cpus isn't set.
> -		 */
> -		xcpus = tmp->delmask;
> -		if (compute_excpus(cs, xcpus))
> -			WARN_ON_ONCE(!cpumask_empty(cs->exclusive_cpus));
> -		new_prs = (cmd == partcmd_enable) ? PRS_ROOT : PRS_ISOLATED;
> -
> -		part_error = validate_partition(cs, new_prs, xcpus);
> -		if (part_error)
> -			return part_error;
> -		/*
> -		 * This function will only be called when all the preliminary
> -		 * checks have passed. At this point, the following condition
> -		 * should hold.
> -		 *
> -		 * (cs->effective_xcpus & cpu_active_mask) ⊆ parent->effective_cpus
> -		 *
> -		 * Warn if it is not the case.
> -		 */
> -		cpumask_and(tmp->new_cpus, xcpus, cpu_active_mask);
> -		WARN_ON_ONCE(!cpumask_subset(tmp->new_cpus, parent->effective_cpus));
> -
> -		deleting = true;
> -	} else if (cmd == partcmd_disable) {
> +	if (cmd == partcmd_disable) {
>   		/*
>   		 * May need to add cpus back to parent's effective_cpus
>   		 * (and maybe removed from subpartitions_cpus/isolated_cpus)
> @@ -3062,14 +3090,10 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   		 * If parent is valid partition, enable local partiion.
>   		 * Otherwise, enable a remote partition.
>   		 */
> -		if (is_partition_valid(parent)) {
> -			enum partition_cmd cmd = (new_prs == PRS_ROOT)
> -					       ? partcmd_enable : partcmd_enablei;
> -
> -			err = update_parent_effective_cpumask(cs, cmd, NULL, &tmpmask);
> -		} else {
> +		if (is_partition_valid(parent))
> +			err = local_partition_enable(cs, new_prs, &tmpmask);
> +		else
>   			err = remote_partition_enable(cs, new_prs, &tmpmask);
> -		}
>   	} else if (old_prs && new_prs) {
>   		/*
>   		 * A change in load balance state only, no change in cpumasks.


