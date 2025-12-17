Return-Path: <cgroups+bounces-12443-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DF8CC95AB
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 20:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EB6F3072E33
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 19:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB4C299A94;
	Wed, 17 Dec 2025 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h25EzEU9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIXlMzBk"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEEF257852
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765998346; cv=none; b=n7HVmxi6QgnbP0XMy/ysrWfIvNhA1KpfmiE6iG/3UOWuuiMw4xedQMI3L9IeN+lrtf7ZWdbRqWj7dLUpo9xp1pG5xDEd1sCl7v8B7q1aOujphAjCbcK1JbGSRSwnwhBsdA9u+8xPEyNvMFAEPWcmj+5mKHzdOXzHpyV6JnPhNbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765998346; c=relaxed/simple;
	bh=TV0rjjub+I25Xkm+hLsl+L4zaaLuFCM/LIHWruIf//E=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PgykQiiCyLaPK+ER8NaKKl7wtqqdUI8tKgxr8uRmY//nKGOEeOldZHT6DUVarXOAK3XR59ild3KFBDnjD4vxJEWU0iPFMI4bI9kHPffzTnKQulGz/PzQlnqVRApGNFXM8oVrI4YV4jS5ciRRcvFYnSEMSxGs+dXC2aDigCaG1cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h25EzEU9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FIXlMzBk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765998343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OlTSEJRi7dCYSHQr/1YE2xBIR91vQs4bjEv3mQ6RJT4=;
	b=h25EzEU9B2M+ND/4DY1NXh+xIuCKrt3fpQuKUdaiLdVPe9MMfEK5igLtczLj0f5a1Fa+6Q
	pYf1Ns3sDe3Q/OINMbKtbDjO3neeTJV5v1FkC4RStsf4nA+YgVD5GJ6/ea/o72Ffl9t8IG
	RSlY48ifjaITgFb5SUNStDojUBm8BbE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-ps4u6GyFPbCUVdBmFGXFXg-1; Wed, 17 Dec 2025 14:05:42 -0500
X-MC-Unique: ps4u6GyFPbCUVdBmFGXFXg-1
X-Mimecast-MFC-AGG-ID: ps4u6GyFPbCUVdBmFGXFXg_1765998341
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4edad69b4e8so20132041cf.1
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 11:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765998341; x=1766603141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OlTSEJRi7dCYSHQr/1YE2xBIR91vQs4bjEv3mQ6RJT4=;
        b=FIXlMzBkrfs6D3bwkXQ1t0cGXy4wXcfTUfJEWpmJcN+O5yASkOQedj9A0vWEExGvY2
         r1GeAfxf5IIM46T5tJdfHY7Jhs0VtZfL1j0XPb27ZWELOKqOVy1OKbfLcfUmOnn/Mm9n
         GFOj6gtSwvxkTtYoW+v4oiUjiyyu0DOZe5ROSfmhmLM7ChxHu99SzXJ/dO0JNY5XT+JK
         mcGAZKPqtQWRFtjY4L46wxZ3YLzJq3MTfG/yz3PhYfy9rVth0ORyGIJR4pRfTS8uIbRC
         NnAWHrKwFs3iP/TLSXY0OnjGdbRamK/57N3VQ5QB7Criim/j+xDvvK2GMQu0auifBMoJ
         tiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765998341; x=1766603141;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OlTSEJRi7dCYSHQr/1YE2xBIR91vQs4bjEv3mQ6RJT4=;
        b=q6/JE3QJ0b4xyHCi6djkULct/+N6B2r98YB3KGCjCdPti8qDQQa9kGM0arbohQVK2i
         3dJ20pU/ygNm3WvM+fH9Xn0vpZWbRaK/yOjv5eN/iETKSjhJ0gKEYcQ8+deDpm16oqUx
         J7yOkLZyxqq2TniP6lAfI2Q2zqmv0ebrldZ6e9T0VR6Ha22/gd+n8CX22Xw2f4kLhdBn
         AxYN5IVoUs5++SjBBm4pX3GGOGErmhZ/bjTNvgp55xdo3Xepfv8yRDc2xciMraEKN5Ae
         LQO2AHHfBiJLPOCP9tl0Sx4q6TxfJ3qus+lywsy7utW87QDUhG8bUujYgYRFHe/eZYNv
         pdWw==
X-Gm-Message-State: AOJu0YwFWcM2A9HF3iEowfJu4j502IHpjxj00nOeJhSVzL0NpjLewN4a
	z5kZLq59hFpUhVw5ZLNElVo5cmQz8mPZ8ndmAPKtAzkxq1RkH3PZydW6v3ypNY2CFtq9cFBlQN/
	o9Pr+nnl6Wa2uXL7uelv7h5HiA9RWethmj7KTZNxCSvtRXeSLfvBzsowiWPQ=
X-Gm-Gg: AY/fxX46fMSuHWE8s71d4YQRYwsq4IjoFv6qgBvlo0pxqMS8DOhz2Z5sN9heZW78yOv
	zcPZzRvIiMNJkz9VihCdBKekJWPlbMga86qQsKz6DXIHa4hMx7uRJEK9evbSI3t1YoMBWi4t+Pp
	K6IM/GVY8Kpqm8sxDUsl2LI9p+n7URW0R1n6brryRz/woe8VXravYQCGxnPdxRuE/z1RMm3npjZ
	pzmE6j71MIKsLQd3/zJTwxuNByoSenAMt6kfTklK6b9KCKE+QpeYmbK6xcCjSfawwVDCGdXyvUL
	SNUS+wSPw38X1rOZ0JlAV4ELD1XfTl6a/3+YP6SoPaoGGD4T1w1CMW1+AGUAoGxDgu3MBzUwM3Q
	BFYYi3Q4SCrFIV0x1lClGmAfXSX5IUo/VfWq+ewvHFJ09PhOg4GcX+Ybb
X-Received: by 2002:a05:622a:7c92:b0:4f1:de87:ad90 with SMTP id d75a77b69052e-4f35f654617mr4551761cf.4.1765998341228;
        Wed, 17 Dec 2025 11:05:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQznSQisiUUcnVgm/CLrf2yKzdEiJf0C9rsNCIn1mJpUe3j12gru2r09NEUmy+pEcn/BbE/Q==
X-Received: by 2002:a05:622a:7c92:b0:4f1:de87:ad90 with SMTP id d75a77b69052e-4f35f654617mr4551331cf.4.1765998340650;
        Wed, 17 Dec 2025 11:05:40 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f35fd83984sm657231cf.24.2025.12.17.11.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 11:05:40 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <47029555-aba6-4d85-ace3-0580ec606e5d@redhat.com>
Date: Wed, 17 Dec 2025 14:05:39 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 6/6] cpuset: remove v1-specific code from
 generate_sched_domains
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20251217084942.2666405-1-chenridong@huaweicloud.com>
 <20251217084942.2666405-7-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251217084942.2666405-7-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/25 3:49 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Following the introduction of cpuset1_generate_sched_domains() for v1
> in the previous patch, v1-specific logic can now be removed from the
> generic generate_sched_domains(). This patch cleans up the v1-only
> code and ensures uf_node is only visible when CONFIG_CPUSETS_V1=y.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset-internal.h |  10 +--
>   kernel/cgroup/cpuset-v1.c       |   2 +-
>   kernel/cgroup/cpuset.c          | 144 +++++---------------------------
>   3 files changed, 27 insertions(+), 129 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index bd767f8cb0ed..ef7b7c5afd4c 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -175,14 +175,14 @@ struct cpuset {
>   	/* Handle for cpuset.cpus.partition */
>   	struct cgroup_file partition_file;
>   
> -	/* Used to merge intersecting subsets for generate_sched_domains */
> -	struct uf_node node;
> -
>   #ifdef CONFIG_CPUSETS_V1
>   	struct fmeter fmeter;		/* memory_pressure filter */
>   
>   	/* for custom sched domain */
>   	int relax_domain_level;
> +
> +	/* Used to merge intersecting subsets for generate_sched_domains */
> +	struct uf_node node;
>   #endif
>   };
>   
> @@ -315,8 +315,6 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
>   int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial);
>   void cpuset1_init(struct cpuset *cs);
>   void cpuset1_online_css(struct cgroup_subsys_state *css);
> -void update_domain_attr_tree(struct sched_domain_attr *dattr,
> -				    struct cpuset *root_cs);
>   int cpuset1_generate_sched_domains(cpumask_var_t **domains,
>   			struct sched_domain_attr **attributes);
>   
> @@ -331,8 +329,6 @@ static inline int cpuset1_validate_change(struct cpuset *cur,
>   				struct cpuset *trial) { return 0; }
>   static inline void cpuset1_init(struct cpuset *cs) {}
>   static inline void cpuset1_online_css(struct cgroup_subsys_state *css) {}
> -static inline void update_domain_attr_tree(struct sched_domain_attr *dattr,
> -				    struct cpuset *root_cs) {}
>   static inline int cpuset1_generate_sched_domains(cpumask_var_t **domains,
>   			struct sched_domain_attr **attributes) { return 0; };
>   
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 5c0bded46a7c..0226350e704f 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -560,7 +560,7 @@ update_domain_attr(struct sched_domain_attr *dattr, struct cpuset *c)
>   		dattr->relax_domain_level = c->relax_domain_level;
>   }
>   
> -void update_domain_attr_tree(struct sched_domain_attr *dattr,
> +static void update_domain_attr_tree(struct sched_domain_attr *dattr,
>   				    struct cpuset *root_cs)
>   {
>   	struct cpuset *cp;
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 6bb0b201c34b..3e3468d928f3 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -789,18 +789,13 @@ static int generate_sched_domains(cpumask_var_t **domains,
>   {
>   	struct cpuset *cp;	/* top-down scan of cpusets */
>   	struct cpuset **csa;	/* array of all cpuset ptrs */
> -	int csn;		/* how many cpuset ptrs in csa so far */
>   	int i, j;		/* indices for partition finding loops */
>   	cpumask_var_t *doms;	/* resulting partition; i.e. sched domains */
>   	struct sched_domain_attr *dattr;  /* attributes for custom domains */
>   	int ndoms = 0;		/* number of sched domains in result */
> -	int nslot;		/* next empty doms[] struct cpumask slot */
>   	struct cgroup_subsys_state *pos_css;
> -	bool root_load_balance = is_sched_load_balance(&top_cpuset);
> -	bool cgrpv2 = cpuset_v2();
> -	int nslot_update;
>   
> -	if (!cgrpv2)
> +	if (!cpuset_v2())
>   		return cpuset1_generate_sched_domains(domains, attributes);
>   
>   	doms = NULL;
> @@ -808,70 +803,25 @@ static int generate_sched_domains(cpumask_var_t **domains,
>   	csa = NULL;
>   
>   	/* Special case for the 99% of systems with one, full, sched domain */
> -	if (root_load_balance && cpumask_empty(subpartitions_cpus)) {
> -single_root_domain:
> +	if (cpumask_empty(subpartitions_cpus)) {
>   		ndoms = 1;
> -		doms = alloc_sched_domains(ndoms);
> -		if (!doms)
> -			goto done;
> -
> -		dattr = kmalloc(sizeof(struct sched_domain_attr), GFP_KERNEL);
> -		if (dattr) {
> -			*dattr = SD_ATTR_INIT;
> -			update_domain_attr_tree(dattr, &top_cpuset);
> -		}
> -		cpumask_and(doms[0], top_cpuset.effective_cpus,
> -			    housekeeping_cpumask(HK_TYPE_DOMAIN));
> -
> -		goto done;
> +		goto generate_doms;

That is not correct. The code under the generate_doms label will need to 
access csa[0] which is not allocated yet and may cause panic. You either 
need to keep the current code or move it after the csa allocation and 
assign top_cpuset to csa[0].

>   	}
>   
>   	csa = kmalloc_array(nr_cpusets(), sizeof(cp), GFP_KERNEL);
>   	if (!csa)
>   		goto done;
> -	csn = 0;
>   
> +	/* Find how many partitions and cache them to csa[] */
>   	rcu_read_lock();
> -	if (root_load_balance)
> -		csa[csn++] = &top_cpuset;
>   	cpuset_for_each_descendant_pre(cp, pos_css, &top_cpuset) {

The cpuset_for_each_descendant_pre() macro will visit the root 
(top_cpuset) first and so it should be OK to remove the above 2 lines of 
code.

Cheers,
Longman


