Return-Path: <cgroups+bounces-10117-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08295B584DC
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 20:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1D04C34ED
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 18:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D0F2BE048;
	Mon, 15 Sep 2025 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4pBNRhp"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717A023ABA0
	for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961839; cv=none; b=Fr0qMHbhF+6bcJveEsWuXwYeFsVW5BmtR/qKsXVeiGRJTOnafj2CS5W7r1O9k6BB+tHdrVRW/lxtEb/005aVhK75eu8ZBSLBoTwqil+XwgIj7b9V5um9zSS5/AvJ79Acm6GqXOoX6hcW3ca1Yu/phMEQLNEQoc0aCn7aO4QFPsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961839; c=relaxed/simple;
	bh=Xe69ZycSnxkAv+tFgSs4kTC+1YYI/h1RrnEw2sRwib8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=N25Wpx8IG7eNSLMLu26N2X2KfU6KcFDScIRq7s2BgcUkIB+P+flw4IJA+JJs3KBadXCLKJv8aUFOq+RQ8DcGljE3ZlsF0KPVG06p+pmnPi0woHmueSpq6PuLzNdy5qjx8yJcdYrCFP3px1YuiPLL7xq0AbspX/8HXx57Z8eEJak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K4pBNRhp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757961835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xTFzJZe1TMhIRhfgSSVSHI05Oabd4gnGJJuthvYMYXY=;
	b=K4pBNRhpgsyOYIrPNyfwlyYdjlGtk7EI8SQYMRCN4cXe8wnQVOcIerprg3CRdvILtluasC
	UIsj/CdiU4b3l3iI+lRqlWhsRiaBgQc/Rpa59QAKTw+grr3IhzssMEbBFOUEXw7L+LZVQj
	Nzot1wPQzJHtc5pPy3KK01HdPm6wbjA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-F6M-pOyyP8u1rbsuEexQ2g-1; Mon, 15 Sep 2025 14:43:54 -0400
X-MC-Unique: F6M-pOyyP8u1rbsuEexQ2g-1
X-Mimecast-MFC-AGG-ID: F6M-pOyyP8u1rbsuEexQ2g_1757961834
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8286b42f46bso470941285a.1
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 11:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961833; x=1758566633;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTFzJZe1TMhIRhfgSSVSHI05Oabd4gnGJJuthvYMYXY=;
        b=ujQL8OCNSfRi4R8HpCpU0t7kGcKsGFNK/Jspg2epBL/MEaWt8cfUgAfyfuQzlYoYMQ
         Y0mlpbCQ/GYIOPzYq0kpu1tkWSCuSiuxHokZUPNRhdDcpwCULHO/NVHJPaFPH8zNiyxu
         fwF9I2dSKi7dq0ZHezeorj1hYEUX1cg3fmPSLFet9pFqHGvMOUuCc/7/L2gim385SGAB
         4HDH+U8cHXImrKeaQUlRLTrJxCVPWyEnA3fG8h47Hr3TCdwBhair2LAxzyklBJQA7evE
         0nrNwoQve6zJS+LtCJji1+xQ1qmdFCD1Uw4wodociwLCiYkXixsFw10Fmq5dMt27TWhw
         Ohgw==
X-Gm-Message-State: AOJu0YxA72ub/KGZtk81Jnj8H/ISHnxeDTTUo+OLewWWHVkpSq2NyFBS
	Moo6tPErwAp7RiH6+8lVq7gIMut3OIR+qURCmm+hxyLZlmygc43TqmZjoHrYuU1AiIpnwnMULNN
	4J1wTu3h6OYAetAci2ziiadAsa0Xg5wIyudYwoUIbAwTcfv+lmgW/TcVa2gk=
X-Gm-Gg: ASbGncubGap7qKAtCic+47EpMmyL1FAJs9VmixIS1UmkJN+bNe6Q0JQYAO5ycHSosXE
	IKg8rZ2trCG+lH2pVeXpW5L1JKkaSuof4OH+KNMrFvtHvsXm30DanvcUrj7D7Z2QdNs/+aMXik+
	DPBNq3Lt2zjYVVofdx3FULtrtjMBo06efxDFGUwkJIzMNjrMeI8OYWYISNiodYLYzNhr5yKxxwr
	K/bHB0G0+HMLhBFjhxElY2Tv1AN73h5p3xMBU/rQp9+0V4s1j0+eA3cMDrqrL69ezzahp3/VDXo
	BZFKBw9tKPrOHU+6qMHvjICrwPWFDYjTUGEySvbV14r+NcRAGupKLg4LiNgFnVHSyowEY5RZ0K+
	tnSpRXK3QJg==
X-Received: by 2002:a05:620a:6130:b0:822:f45b:a5ef with SMTP id af79cd13be357-823fc8907acmr1435005185a.29.1757961833446;
        Mon, 15 Sep 2025 11:43:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtR8/kPRSpVnEke+LQPRhFvuExyZBTLBlDXrgzBUmmpDA9jhGoDD+QCY0rwmCwcJ/NX9tS+A==
X-Received: by 2002:a05:620a:6130:b0:822:f45b:a5ef with SMTP id af79cd13be357-823fc8907acmr1435001885a.29.1757961832890;
        Mon, 15 Sep 2025 11:43:52 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c974dbbbsm835279585a.21.2025.09.15.11.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 11:43:52 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ed4962d3-d54c-4b05-bfd1-dd71d6ae169e@redhat.com>
Date: Mon, 15 Sep 2025 14:43:51 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC -v2 01/11] cpuset: move the root cpuset write
 check earlier
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250909033233.2731579-1-chenridong@huaweicloud.com>
 <20250909033233.2731579-2-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250909033233.2731579-2-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/25 11:32 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The 'cpus' or 'mems' lists of the top_cpuset cannot be modified.
> This check can be moved before acquiring any locks as a common code
> block to improve efficiency and maintainability.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 17 ++++-------------
>   1 file changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index c0c281a8860d..7e1bc1e1bde1 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2337,10 +2337,6 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	bool force = false;
>   	int old_prs = cs->partition_root_state;
>   
> -	/* top_cpuset.cpus_allowed tracks cpu_active_mask; it's read-only */
> -	if (cs == &top_cpuset)
> -		return -EACCES;
> -
>   	/*
>   	 * An empty cpus_allowed is ok only if the cpuset has no tasks.
>   	 * Since cpulist_parse() fails on an empty mask, we special case
> @@ -2786,15 +2782,6 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
>   {
>   	int retval;
>   
> -	/*
> -	 * top_cpuset.mems_allowed tracks node_stats[N_MEMORY];
> -	 * it's read-only
> -	 */
> -	if (cs == &top_cpuset) {
> -		retval = -EACCES;
> -		goto done;
> -	}
> -
>   	/*
>   	 * An empty mems_allowed is ok iff there are no tasks in the cpuset.
>   	 * Since nodelist_parse() fails on an empty mask, we special case
> @@ -3260,6 +3247,10 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   	struct cpuset *trialcs;
>   	int retval = -ENODEV;
>   
> +	/* root is read-only */
> +	if (cs == &top_cpuset)
> +		return -EACCES;
> +
>   	buf = strstrip(buf);
>   	cpuset_full_lock();
>   	if (!is_cpuset_online(cs))
Reviewed-by: Waiman Long <longman@redhat.com>


> 3. The 'cpuset.cpus' of one cpuset must not form a subset of another
>     cpuset's 'cpuset.cpus.exclusive'.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 74 +++++++++++++++++++++++++-----------------
>   1 file changed, 44 insertions(+), 30 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 55674a5ad2f9..389dfd5be6c8 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -582,6 +582,47 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>   	return true;
>   }
>   
> +/**
> + * cpus_excl_conflict - Check if two cpusets have exclusive CPU conflicts
> + * @cs1: first cpuset to check
> + * @cs2: second cpuset to check
> + *
> + * Returns: true if CPU exclusivity conflict exists, false otherwise
> + *
> + * Conflict detection rules:
> + * 1. If either cpuset is CPU exclusive, they must be mutually exclusive
> + * 2. exclusive_cpus masks cannot intersect between cpusets
> + * 3. The allowed CPUs of one cpuset cannot be a subset of another's exclusive CPUs
> + */
> +static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
> +{
> +	/* If either cpuset is exclusive, check if they are mutually exclusive */
> +	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
> +		return !cpusets_are_exclusive(cs1, cs2);
> +
> +	/* Exclusive_cpus cannot intersect */
> +	if (cpumask_intersects(cs1->exclusive_cpus, cs2->exclusive_cpus))
> +		return true;
> +
> +	/* The cpus_allowed of one cpuset cannot be a subset of another cpuset's exclusive_cpus */
> +	if (!cpumask_empty(cs1->cpus_allowed) &&
> +	    cpumask_subset(cs1->cpus_allowed, cs2->exclusive_cpus))
> +		return true;
> +
> +	if (!cpumask_empty(cs2->cpus_allowed) &&
> +	    cpumask_subset(cs2->cpus_allowed, cs1->exclusive_cpus))
> +		return true;
> +
> +	return false;
> +}
> +
> +static inline bool mems_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
> +{
> +	if ((is_mem_exclusive(cs1) || is_mem_exclusive(cs2)))
> +		return nodes_intersects(cs1->mems_allowed, cs2->mems_allowed);
> +	return false;
> +}
> +
>   /*
>    * validate_change() - Used to validate that any proposed cpuset change
>    *		       follows the structural rules for cpusets.
> @@ -663,38 +704,11 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
>   	 */
>   	ret = -EINVAL;
>   	cpuset_for_each_child(c, css, par) {
> -		bool txset, cxset;	/* Are exclusive_cpus set? */
> -
>   		if (c == cur)
>   			continue;
> -
> -		txset = !cpumask_empty(trial->exclusive_cpus);
> -		cxset = !cpumask_empty(c->exclusive_cpus);
> -		if (is_cpu_exclusive(trial) || is_cpu_exclusive(c) ||
> -		    (txset && cxset)) {
> -			if (!cpusets_are_exclusive(trial, c))
> -				goto out;
> -		} else if (txset || cxset) {
> -			struct cpumask *xcpus, *acpus;
> -
> -			/*
> -			 * When just one of the exclusive_cpus's is set,
> -			 * cpus_allowed of the other cpuset, if set, cannot be
> -			 * a subset of it or none of those CPUs will be
> -			 * available if these exclusive CPUs are activated.
> -			 */
> -			if (txset) {
> -				xcpus = trial->exclusive_cpus;
> -				acpus = c->cpus_allowed;
> -			} else {
> -				xcpus = c->exclusive_cpus;
> -				acpus = trial->cpus_allowed;
> -			}
> -			if (!cpumask_empty(acpus) && cpumask_subset(acpus, xcpus))
> -				goto out;
> -		}
> -		if ((is_mem_exclusive(trial) || is_mem_exclusive(c)) &&
> -		    nodes_intersects(trial->mems_allowed, c->mems_allowed))
> +		if (cpus_excl_conflict(trial, c))
> +			goto out;
> +		if (mems_excl_conflict(trial, c))
>   			goto out;
>   	}
>   


