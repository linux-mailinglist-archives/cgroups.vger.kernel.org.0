Return-Path: <cgroups+bounces-11816-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8FBC4EB15
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 16:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918763BE146
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 14:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4E033F36B;
	Tue, 11 Nov 2025 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnEyeh/p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qZQgeEBv"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311BB28FFF6
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873005; cv=none; b=EengUOUIZFoJYAVzkC0GItPhm6r0QkEX/N0pviPU/qzpOrj1QAPcTbi8sSfsjYsyAPpET3IMc08m9zQajcJXMrpP0VhTw6AqTc4ROCVa2KAHfX8UdWoS9Hsxg6qfXPE5ooude5cASTqTINjf+O1r9RRkseOvbUaDyjZFJJ7pQl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873005; c=relaxed/simple;
	bh=DjX4+Bnt6nCSaTOh31I+NVtamBU63UWP22wg01klHls=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HhK38Kw3mO4mFYiHYXq1dASniw9mqKZSjyJXPsqg7rB3OfrzBSLlhf6FrDtuQAwfYdedaZTnRrWoc7Yu+16W78S0PElKvsMkGx3A2khfBZGrglHRSuRfgZz7Nyed/wlz2z4VQuBhpxsv+IywI73vBJsHvGo7DsUIs7qWWEvOrzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BnEyeh/p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qZQgeEBv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762873002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGO7wZ0zR6bxjpI3h5K0xPQHJOsx28xRrKSKYu9tvms=;
	b=BnEyeh/pGLH0LvS8ixPTX15gVABdti1xy+aqUaKLx2LNCok+yavtVUdbKD9kmAmoU7e74q
	Hb0NQ4F600lntwbWYysiJp2y5ZkrLT+R6z+gOqc4MLnMmJXo0tOTlPrpLbS8snDVtXvEQI
	QTGIeijOuZg1OHwdad9II9Id6tnXp9k=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-fiLU5HaoMgeLG3hKEpUQAw-1; Tue, 11 Nov 2025 09:56:40 -0500
X-MC-Unique: fiLU5HaoMgeLG3hKEpUQAw-1
X-Mimecast-MFC-AGG-ID: fiLU5HaoMgeLG3hKEpUQAw_1762873000
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88237204cc8so112628516d6.2
        for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 06:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762873000; x=1763477800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OGO7wZ0zR6bxjpI3h5K0xPQHJOsx28xRrKSKYu9tvms=;
        b=qZQgeEBvLe28tJW6qYYn8wQ2imnaGmJ8NIZURCI9E8FLIUok2F4gAj1e3532fZUEsD
         b3d2F7eZDUsTt5YaCrFey9cPZ1DPBQYq6FcsyYfTfcguNbvP2o6ru4hpOIlQJa/W9FHI
         HEzpbcU2oea0q3QPiiefOis4UKU92M/Qo4R5WQ9hHECshRcT3gPNDpaHnA7TOnBwhU/B
         tE9mzkiDk0dfn8YAoHBMIpLG5pNu8X3ZQv7SwxkWlatzz/7QKIWEuLZuu66TEqu+6TIR
         ILSiZcTpjIHtd2vOBuFjjoJg0AmHGMNw9QY8g6oFBhddYC6Q42U5u0r71gXFb5EORAXX
         sArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762873000; x=1763477800;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGO7wZ0zR6bxjpI3h5K0xPQHJOsx28xRrKSKYu9tvms=;
        b=nhEcj8co0Q2hATVRGouUrcOIeMEFw5Me1tzO5z4ygh5+a+xA9O2WF7lMsSbcOFsMO3
         LVKgL/fkQBsiXzxz7KECkIzoGk9DJOMiZeGuprBz+ObFnZikBChE7TEkDCpjV61ytkn1
         qdZhtnLVRaS1XlklxqsvFuFw9s8+AT3E4atAotnAlVL1CfQD0pDmiFjjQvPZ4sRY1QQZ
         V0ieCrmUDie/j5jdKJygTDo9gOHtLwrwm8SpRQ82zENkGFLpHGzD66pEe4eDodyD57OT
         JurE+QODPC4UOgvtHYgtD7OEjHPhbcciLQNBRI4UcycTIQERsRbyqBbZEaqdw9r2Aa47
         n2gA==
X-Gm-Message-State: AOJu0YxNZgqM2kIw7nnXlqATJWxGYPtTtCWRirzJxmjxYvg0k046TY7V
	ovOQK1WjrS+baWZz9BcfCL7lbKE2RLyWjV4hMVilThcV7+EWhp/ha7WkHLj+jRjw4SNb5V+Sw0v
	ATM5IeXynUvmi6xOhFlzYxqiRMLeRljX4JZNl0Ho78EYLqEv2bUqPnMFDxvg=
X-Gm-Gg: ASbGnctvA3Pbm5mgZoUU+k8ZURsKaUnkwI76xSYvuyDEy4v2YsdKpnwyBb0gpJpfKN6
	2e5udPQ0FB8qD0suA2oLurFsmSPuvWPCEB9UVUKo3cDLqmI05nI8CMItlXe7zdbobBY0BIbvtW6
	zemKyU7rTOiqXBtCgPnHujjjwVfRVB50AEQKM23IxCrp6vuXt6dQj78wDfGHBrqMGpqD8CQv+1j
	vbQIxmoVSQVwMSbacevIzV09KmrmW1D37NIy6HIEwUJdASJzj80C7tyCqvmA8IqQBIWq71pYJDZ
	VVyFFX/RhbqWBCaJPQcB+JCa8x3MqNSbg1rvsPtehGudsMejR5PvA93VJCiROUI9xW9ScjQ9HOG
	qYyxgvsAlFD29UBRm7a2zwfObjrOMovWd/dzxtmVIwSpUlQ==
X-Received: by 2002:a05:6214:240c:b0:77b:2925:a85b with SMTP id 6a1803df08f44-8823866c6e7mr159348536d6.44.1762873000227;
        Tue, 11 Nov 2025 06:56:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEORJX30Vv4A6mzZNTTYVEP1dBmzzuthZd5tIvL3PbtzkKoRMI26cc5glhHR4AHIslhhMKAQ==
X-Received: by 2002:a05:6214:240c:b0:77b:2925:a85b with SMTP id 6a1803df08f44-8823866c6e7mr159348246d6.44.1762872999906;
        Tue, 11 Nov 2025 06:56:39 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8823c56b387sm67927066d6.24.2025.11.11.06.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 06:56:39 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <307e7687-4320-4b2b-a552-5d8409522cfe@redhat.com>
Date: Tue, 11 Nov 2025 09:56:37 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 2/3] cpuset: remove global remote_children list
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251111132429.950343-1-chenridong@huaweicloud.com>
 <20251111132429.950343-3-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251111132429.950343-3-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/25 8:24 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The remote_children list is used to track all remote partitions attached
> to a cpuset. However, it serves no other purpose. Using a boolean flag to
> indicate whether a cpuset is a remote partition is a more direct approach,
> making remote_children unnecessary.
>
> This patch replaces the list with a remote_partition flag in the cpuset
> structure and removes remote_children entirely.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset-internal.h | 10 +++++++---
>   kernel/cgroup/cpuset.c          | 13 ++++---------
>   2 files changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index 5cac42c5fd97..01976c8e7d49 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -158,6 +158,13 @@ struct cpuset {
>   	/* partition root state */
>   	int partition_root_state;
>   
> +	/*
> +	 * Whether cpuset is a remote partition.
> +	 * It used to be a list anchoring all remote partitions — we can switch back
> +	 * to a list if we need to iterate over the remote partitions.
> +	 */
> +	bool remote_partition;
> +
>   	/*
>   	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
>   	 * know when to rebuild associated root domain bandwidth information.
> @@ -172,9 +179,6 @@ struct cpuset {
>   	/* Handle for cpuset.cpus.partition */
>   	struct cgroup_file partition_file;
>   
> -	/* Remote partition silbling list anchored at remote_children */
> -	struct list_head remote_sibling;
> -
>   	/* Used to merge intersecting subsets for generate_sched_domains */
>   	struct uf_node node;
>   };
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index c90476d52f09..aff3ddc67393 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -94,9 +94,6 @@ static bool isolated_cpus_updating;
>   static cpumask_var_t	boot_hk_cpus;
>   static bool		have_boot_isolcpus;
>   
> -/* List of remote partition root children */
> -static struct list_head remote_children;
> -
>   /*
>    * A flag to force sched domain rebuild at the end of an operation.
>    * It can be set in
> @@ -219,7 +216,7 @@ static struct cpuset top_cpuset = {
>   		 BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
>   	.partition_root_state = PRS_ROOT,
>   	.relax_domain_level = -1,
> -	.remote_sibling = LIST_HEAD_INIT(top_cpuset.remote_sibling),
> +	.remote_partition = false,
I forgot to notify you that this init is also not needed. Anyway, this 
is a minor issue.
>   };
>   
>   /*
> @@ -1572,7 +1569,7 @@ static int compute_trialcs_excpus(struct cpuset *trialcs, struct cpuset *cs)
>   
>   static inline bool is_remote_partition(struct cpuset *cs)
>   {
> -	return !list_empty(&cs->remote_sibling);
> +	return cs->remote_partition;
>   }
>   
>   static inline bool is_local_partition(struct cpuset *cs)
> @@ -1621,7 +1618,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>   
>   	spin_lock_irq(&callback_lock);
>   	partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
> -	list_add(&cs->remote_sibling, &remote_children);
> +	cs->remote_partition = true;
>   	cpumask_copy(cs->effective_xcpus, tmp->new_cpus);
>   	spin_unlock_irq(&callback_lock);
>   	update_isolation_cpumasks();
> @@ -1651,7 +1648,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
>   	WARN_ON_ONCE(!cpumask_subset(cs->effective_xcpus, subpartitions_cpus));
>   
>   	spin_lock_irq(&callback_lock);
> -	list_del_init(&cs->remote_sibling);
> +	cs->remote_partition = false;
>   	partition_xcpus_del(cs->partition_root_state, NULL, cs->effective_xcpus);
>   	if (cs->prs_err)
>   		cs->partition_root_state = -cs->partition_root_state;
> @@ -3603,7 +3600,6 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
>   	__set_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
>   	fmeter_init(&cs->fmeter);
>   	cs->relax_domain_level = -1;
> -	INIT_LIST_HEAD(&cs->remote_sibling);
>   
>   	/* Set CS_MEMORY_MIGRATE for default hierarchy */
>   	if (cpuset_v2())
> @@ -3874,7 +3870,6 @@ int __init cpuset_init(void)
>   	nodes_setall(top_cpuset.effective_mems);
>   
>   	fmeter_init(&top_cpuset.fmeter);
> -	INIT_LIST_HEAD(&remote_children);
>   
>   	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
>   
Reviewed-by: Waiman Long <longman@redhat.com>


