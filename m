Return-Path: <cgroups+bounces-12441-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0D1CC92B9
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 19:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A155E30783BF
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 17:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FDB35C1AB;
	Wed, 17 Dec 2025 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAQ2Xf3K";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eo//nOTO"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE07035503A
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765993775; cv=none; b=tYf+4aLJiLcf8aGNJWLimdYJJIB7CARSkqMUNqe+h0Z09KJRJKcY3Fl4arR/FLOE3oiL9K8KMtXu+QXjsQ8vwVl72hpY2IOnITEBPZJoSki9BwV/HuZuOHLIvzkGeagfLmCssB5JbSgHX+11bOn0VWhBBfhsjH3HV+dbOdBlH4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765993775; c=relaxed/simple;
	bh=r944rE44rL+mOU6FZhTBkAcBmVTsyhoN6fx7uxahIH0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OvMac4uEQu35YgeauRo/hIyErYAo5pANcbrcbffYHN7takcKf54qGiQHY1WzFykrQ8YbhC0lGS2PFOU6k2YgGp7FYUgDbFqFjDZSSlRlbGDVh5yLrxlmBKv6Ck6nWcWAukb0n+J0us7y8Gan3i9RfN3J1iOlDasrq4Zxzd97fUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAQ2Xf3K; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eo//nOTO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765993770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VeB5aky7S2GM1CFOC4rwKPGWiSh1O8kl+7faRtByBfc=;
	b=LAQ2Xf3KoEihyL8GE+i+EP05Em4tYYI5DyqTfbfyJ+1S4tMTj3JyU8p0mxJc95eJatfoSL
	VzTgQz/5bhtGXuNVDhx0tCKkPmUAaQtJtNLuKrwkySSleGHQTEgmvi5GUHdPw7wUHxOWWj
	Rtf0ae1FxZAdRcbUvx8B1fo98HXliUA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-SmAAOb-BP1O35loP6E0rgw-1; Wed, 17 Dec 2025 12:49:01 -0500
X-MC-Unique: SmAAOb-BP1O35loP6E0rgw-1
X-Mimecast-MFC-AGG-ID: SmAAOb-BP1O35loP6E0rgw_1765993740
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-341616a6fb7so6917293a91.0
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 09:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765993739; x=1766598539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VeB5aky7S2GM1CFOC4rwKPGWiSh1O8kl+7faRtByBfc=;
        b=Eo//nOTOqN6Ai7sA0XFZBbl+bUXk3SqTQMCR2dmHJHUoYGIjlq7VRkRA9r08HLpV0r
         p5Qgjy1UEJzqXUyTSbTkkuXhRQwjDFs+xBYDdApzWGjuET5WCyyecApjPo8hnqIK2qa4
         XaPie49sDUVtzUxntNfEGqbAfsxEYwUUkCc5ZDKUXi2PuERa6TLSpSzqOFFhPCi37uwg
         m4Sao/aK8NFrNKHkVaPcw3HZrlnt8KetqetSefoSA5Opta5XILzb5HBJ99vMftRUWLrm
         BApfWrO+M3pybiGFvQXjbd1ijvgwQU1QQdaKUwxB/cgYneZc4OWSQnMsNHsA+6CuXI/H
         10Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765993739; x=1766598539;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VeB5aky7S2GM1CFOC4rwKPGWiSh1O8kl+7faRtByBfc=;
        b=p/eiwSJQ843M/iIjJ+FVhHkOxnRzwtMwrxCVngJp9e6vfGArznaBwrtBpV8g4GF8IA
         +QeQczn/F2nYNfGzW5ALOJ538hLAfaxIdpYiC7mRzlIelWk2PVpDbgz8flKmDz4H2hbj
         r/P0LpulpuO7rRpXwowfxJ9FKTl150h/qmaeuUJEjt9g1QcfcJjItYtt3PxnwTgcb4P5
         dec9BXCqZr/6GtUGSY0ZGaetE8l3VgeZ4B9WQGMgDCHRm8ajA0TLi4f0OGmWKp6O0/tT
         Ge4VVXm2izUl+3EM8jmC7U393gPUssC0QEnxR4d20I6OJ9yynMvavQ+V4EybFApPBtoQ
         vnJA==
X-Gm-Message-State: AOJu0YyFmcufY0ipAwqxVHMtKZQWgdb9k94KS3w4GaFT9jLJmUDGFG9W
	WFOfGuKC7d4udtvRddwV5UGhX4U8qWSbNJgvMhnHtuUwuYij1Sa11NcRsuiT9AVe9A2uxCcF3lL
	ZTwaguGQwdEynoY+7HCx14E5ZwIMc3h/RZlUwEV5jo6ZzXIRGv0FvzujQYnQ=
X-Gm-Gg: AY/fxX5ZDYi02AZfDQREi8ni68RT28+ykODWxwjM9KcoXeRJIC5lPWAkeV8nkPH4Q0J
	CJDmyIQq131//4AgnsAVgtSMIqGfljb8euMCsTR8RaEFV3D5GlL5uVmWDqUGC6KPMzG6r9N8apV
	9qnLArn8PEBNiFrfJ0XfiMlRvsdSv+XfFp636zd0XU23NCgij8xM9YOdfPeP5B0zECGxpUA4vkO
	zJ8SJZh1nyhd2nAI7cJF7/uznekZoSkR8tLeTC7o5bhas00IVabJ2+42HYhqvdClx6j16RsTZhd
	e1syQJZDbYXfjQ4WD2gTXJbhFTntqPTwLdM+VpnjjIvSVS4qppGGtH+p3mATG32QQzqZolbq+dZ
	4mjuazHAHQP+o3QGOBQLUBiO0SC1QCripNozPe+BQ3FXvbdMwAgwitM5d
X-Received: by 2002:a17:90b:3f85:b0:32e:1b1c:f8b8 with SMTP id 98e67ed59e1d1-34abd826facmr17273072a91.26.1765993739521;
        Wed, 17 Dec 2025 09:48:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBbsSlP5tLppnMvNMIKV9vOpeVTUaC1xiyKmfmCxH8/hfHpZpf9Zo+9ttGqoFo64DRaWo1Ig==
X-Received: by 2002:a17:90b:3f85:b0:32e:1b1c:f8b8 with SMTP id 98e67ed59e1d1-34abd826facmr17273061a91.26.1765993739093;
        Wed, 17 Dec 2025 09:48:59 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dbc9d6sm188945a91.10.2025.12.17.09.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 09:48:58 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8d0ef5fc-f392-40f8-9803-50807c172800@redhat.com>
Date: Wed, 17 Dec 2025 12:48:53 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 5/6] cpuset: separate generate_sched_domains for v1
 and v2
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20251217084942.2666405-1-chenridong@huaweicloud.com>
 <20251217084942.2666405-6-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251217084942.2666405-6-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/25 3:49 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The generate_sched_domains() function currently handles both v1 and v2
> logic. However, the underlying mechanisms for building scheduler domains
> differ significantly between the two versions. For cpuset v2, scheduler
> domains are straightforwardly derived from valid partitions, whereas
> cpuset v1 employs a more complex union-find algorithm to merge overlapping
> cpusets. Co-locating these implementations complicates maintenance.
>
> This patch, along with subsequent ones, aims to separate the v1 and v2
> logic. For ease of review, this patch first copies the
> generate_sched_domains() function into cpuset-v1.c as
> cpuset1_generate_sched_domains() and removes v2-specific code. Common
> helpers and top_cpuset are declared in cpuset-internal.h. When operating
> in v1 mode, the code now calls cpuset1_generate_sched_domains().
>
> Currently there is some code duplication, which will be largely eliminated
> once v1-specific code is removed from v2 in the following patch.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset-internal.h |  24 +++++
>   kernel/cgroup/cpuset-v1.c       | 167 ++++++++++++++++++++++++++++++++
>   kernel/cgroup/cpuset.c          |  31 +-----
>   3 files changed, 195 insertions(+), 27 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index 677053ffb913..bd767f8cb0ed 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -9,6 +9,7 @@
>   #include <linux/cpuset.h>
>   #include <linux/spinlock.h>
>   #include <linux/union_find.h>
> +#include <linux/sched/isolation.h>
>   
>   /* See "Frequency meter" comments, below. */
>   
> @@ -185,6 +186,8 @@ struct cpuset {
>   #endif
>   };
>   
> +extern struct cpuset top_cpuset;
> +
>   static inline struct cpuset *css_cs(struct cgroup_subsys_state *css)
>   {
>   	return css ? container_of(css, struct cpuset, css) : NULL;
> @@ -242,6 +245,22 @@ static inline int is_spread_slab(const struct cpuset *cs)
>   	return test_bit(CS_SPREAD_SLAB, &cs->flags);
>   }
>   
> +/*
> + * Helper routine for generate_sched_domains().
> + * Do cpusets a, b have overlapping effective cpus_allowed masks?
> + */
> +static inline int cpusets_overlap(struct cpuset *a, struct cpuset *b)
> +{
> +	return cpumask_intersects(a->effective_cpus, b->effective_cpus);
> +}
> +
> +static inline int nr_cpusets(void)
> +{
> +	assert_cpuset_lock_held();

For a simple helper like this one which only does an atomic_read(), I 
don't think you need to assert that cpuset_mutex is held.

> +	/* jump label reference count + the top-level cpuset */
> +	return static_key_count(&cpusets_enabled_key.key) + 1;
> +}
> +
>   /**
>    * cpuset_for_each_child - traverse online children of a cpuset
>    * @child_cs: loop cursor pointing to the current child
> @@ -298,6 +317,9 @@ void cpuset1_init(struct cpuset *cs);
>   void cpuset1_online_css(struct cgroup_subsys_state *css);
>   void update_domain_attr_tree(struct sched_domain_attr *dattr,
>   				    struct cpuset *root_cs);
> +int cpuset1_generate_sched_domains(cpumask_var_t **domains,
> +			struct sched_domain_attr **attributes);
> +
>   #else
>   static inline void cpuset1_update_task_spread_flags(struct cpuset *cs,
>   					struct task_struct *tsk) {}
> @@ -311,6 +333,8 @@ static inline void cpuset1_init(struct cpuset *cs) {}
>   static inline void cpuset1_online_css(struct cgroup_subsys_state *css) {}
>   static inline void update_domain_attr_tree(struct sched_domain_attr *dattr,
>   				    struct cpuset *root_cs) {}
> +static inline int cpuset1_generate_sched_domains(cpumask_var_t **domains,
> +			struct sched_domain_attr **attributes) { return 0; };
>   
>   #endif /* CONFIG_CPUSETS_V1 */
>   
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 95de6f2a4cc5..5c0bded46a7c 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -580,6 +580,173 @@ void update_domain_attr_tree(struct sched_domain_attr *dattr,
>   	rcu_read_unlock();
>   }
>   
> +/*
> + * cpuset1_generate_sched_domains()
> + *
> + * Finding the best partition (set of domains):
> + *	The double nested loops below over i, j scan over the load
> + *	balanced cpusets (using the array of cpuset pointers in csa[])
> + *	looking for pairs of cpusets that have overlapping cpus_allowed
> + *	and merging them using a union-find algorithm.
> + *
> + *	The union of the cpus_allowed masks from the set of all cpusets
> + *	having the same root then form the one element of the partition
> + *	(one sched domain) to be passed to partition_sched_domains().
> + */
> +int cpuset1_generate_sched_domains(cpumask_var_t **domains,
> +			struct sched_domain_attr **attributes)
> +{
> +	struct cpuset *cp;	/* top-down scan of cpusets */
> +	struct cpuset **csa;	/* array of all cpuset ptrs */
> +	int csn;		/* how many cpuset ptrs in csa so far */
> +	int i, j;		/* indices for partition finding loops */
> +	cpumask_var_t *doms;	/* resulting partition; i.e. sched domains */
> +	struct sched_domain_attr *dattr;  /* attributes for custom domains */
> +	int ndoms = 0;		/* number of sched domains in result */
> +	int nslot;		/* next empty doms[] struct cpumask slot */
> +	struct cgroup_subsys_state *pos_css;
> +	bool root_load_balance = is_sched_load_balance(&top_cpuset);
> +	int nslot_update;
> +
> +	assert_cpuset_lock_held();
> +
> +	doms = NULL;
> +	dattr = NULL;
> +	csa = NULL;
> +
> +	/* Special case for the 99% of systems with one, full, sched domain */
> +	if (root_load_balance) {
> +single_root_domain:
> +		ndoms = 1;
> +		doms = alloc_sched_domains(ndoms);
> +		if (!doms)
> +			goto done;
> +
> +		dattr = kmalloc(sizeof(struct sched_domain_attr), GFP_KERNEL);
> +		if (dattr) {
> +			*dattr = SD_ATTR_INIT;
> +			update_domain_attr_tree(dattr, &top_cpuset);
> +		}
> +		cpumask_and(doms[0], top_cpuset.effective_cpus,
> +			    housekeeping_cpumask(HK_TYPE_DOMAIN));
> +
> +		goto done;
> +	}
> +
> +	csa = kmalloc_array(nr_cpusets(), sizeof(cp), GFP_KERNEL);
> +	if (!csa)
> +		goto done;
> +	csn = 0;
> +
> +	rcu_read_lock();
> +	if (root_load_balance)
> +		csa[csn++] = &top_cpuset;
> +	cpuset_for_each_descendant_pre(cp, pos_css, &top_cpuset) {
> +		if (cp == &top_cpuset)
> +			continue;
> +
> +		/*
> +		 * v1:
Remove this v1 line.
> +		 * Continue traversing beyond @cp iff @cp has some CPUs and
> +		 * isn't load balancing.  The former is obvious.  The
> +		 * latter: All child cpusets contain a subset of the
> +		 * parent's cpus, so just skip them, and then we call
> +		 * update_domain_attr_tree() to calc relax_domain_level of
> +		 * the corresponding sched domain.
> +		 */
> +		if (!cpumask_empty(cp->cpus_allowed) &&
> +		    !(is_sched_load_balance(cp) &&
> +		      cpumask_intersects(cp->cpus_allowed,
> +					 housekeeping_cpumask(HK_TYPE_DOMAIN))))
> +			continue;
> +
> +		if (is_sched_load_balance(cp) &&
> +		    !cpumask_empty(cp->effective_cpus))
> +			csa[csn++] = cp;
> +
> +		/* skip @cp's subtree */
> +		pos_css = css_rightmost_descendant(pos_css);
> +		continue;
> +	}
> +	rcu_read_unlock();
> +
> +	/*
> +	 * If there are only isolated partitions underneath the cgroup root,
> +	 * we can optimize out unneeded sched domains scanning.
> +	 */
> +	if (root_load_balance && (csn == 1))
> +		goto single_root_domain;

This check is v2 specific and you can remove it as well as the 
"single_root_domain" label.

Cheers,
Longman


