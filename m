Return-Path: <cgroups+bounces-12469-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A9ACCA249
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 04:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00EA9300A86A
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 03:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89425221F12;
	Thu, 18 Dec 2025 03:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ak98cMXp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNWXZkKe"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBC513A258
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 03:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766027386; cv=none; b=BCmQfMddwJuRvWdyX/WEUngMxw43pVA/yhFwOGUTQt25Zy5ndYzrg65WuCetGlchYWAHGSNSMnO2D67PD2b4iymdNJE6zbl8FmPjC5F+PS4kMTY747SjuZLfoLTCp63PDyXroZ0yAJQubnoUBsDL3oSnqyYsHkNd27yDvZN1k0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766027386; c=relaxed/simple;
	bh=8OzoQH2BVKXwy1lDzvmTTv8tkC5ItNbbK+pnGIStnNw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VMzmgAiz5VIR91WNuN3HCNaSu0V2253vS8OxKpQh617Y5SDy3dhxHs9FS6vxems5vmaEgHdP/WBWv9DgXjgFRmo7Zq2jkTe10J26LUHbhlZwEiqFH0fFvhXb/xiQ1HJ7nF8AqF+/pXuV4vMByXh2mf77fB7FhaRdyo2jgR3hers=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ak98cMXp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aNWXZkKe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766027383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5frkWbj5hQyNr7KWPAHX0G/9kdfoB7NIk+obPkh6UA0=;
	b=Ak98cMXpMMBBGkrsQyYE2Rwc9x9RloHaOd3zojvYpVL1Ha1K3nw5BQiyJM2vdN/3wgFawg
	9oQpL9CCqs6QvqVlaZ8hgOTX9ck4pjDGOhRwUK72UBU4BcSyetu2M9BoWLVgeP856ITYT/
	QHGXm12jcFw4TGuMHycY7RsLB4JkBo4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-d6QuF3zJPe-Ms5FGAvs-Zw-1; Wed, 17 Dec 2025 22:09:41 -0500
X-MC-Unique: d6QuF3zJPe-Ms5FGAvs-Zw-1
X-Mimecast-MFC-AGG-ID: d6QuF3zJPe-Ms5FGAvs-Zw_1766027381
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ee0488e746so3756091cf.0
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 19:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766027381; x=1766632181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5frkWbj5hQyNr7KWPAHX0G/9kdfoB7NIk+obPkh6UA0=;
        b=aNWXZkKe1I0eiOSjObTn6Cu0aDjeQ8g5sV0wGLva3mfVmV16zRpN62FWP41DBLdWua
         p4A66AIZ3Tgy43FwsRpEDVa3zSCuGQPso4jFxd70tnw/JJ9PDB/gr4dkUp62T0U25AzE
         iva2PptwX+4PEA2WcLacfnBLzN/fVr0up3VfxY4Cm1NtlpPCEK6MFfMnqp9/y30WKSsl
         7Vod6fmIM3dsS8B2p2TZmmrkh/vy6xXdD8n12MuBRFslPQRNGi8TYBreSS2yTsifE1ug
         AWVhkTfepGMqRS4ZAdJg7FiiFHp3vQjnAsiI2YEy3CapTv/wEqIrRGTuF0eNl/w49Tek
         Ef4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766027381; x=1766632181;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5frkWbj5hQyNr7KWPAHX0G/9kdfoB7NIk+obPkh6UA0=;
        b=l/Mb7/0bCImZJBTekiiQH757K+IkUJts0qbvWPK4dlJPZcInHUoc6nPfyTpgyOWZ4E
         ONVchDBTl/7YjfDejm7ngOgYa+QHchpnjY6Y7b8RkEdSGOCoXUi8Z7zDr+Gmn3tsX9m9
         4qWnlyLJmqE973XiKwTSKy6/6bpT4BokJ3X2doNGILSfg+wo9Ft71LpRTlJHzr34hUC0
         nXUIsno2FTUlcRu4rsXOooFynLvMaWDocF0XL4F5UjttQoOExf6opiqN4TGfI75u/JDU
         8HU/1BeZzv/yICcpC5Wa8UAFhVB0laCGMXHmIIonEXjkcdlxMJwbHN854z7rCo4Hq+KZ
         6dVg==
X-Gm-Message-State: AOJu0Yyt3jlnnK/26vHVbu0rVYObCBG3OTTcVqvb+s2AwoYEhEmaACd8
	1PDVrfN4ADHLQ2G/2Wxi33g6U3+O21cgGMXGL/QwgBku74kxhgYmnyEPamFXJIbqMlxd9QjU4aM
	Wlk8AqZCJTPnPdOJJdOiWf2usWcRZWge8neF82cQTKSI8BBS4mvDAb1EeHDw=
X-Gm-Gg: AY/fxX4g0NQqQCf+f4T15fjKAvwCvIjaZKVcFH6aLxItpg56QdlLUhpJTIHNUHCHr3R
	rJzVqf0xz0Z+erT/jAsek8it5oLkwpJPhquPKM/roOPdMm0HtSQhwaDDhXqwrt/2uloNHAxUCB3
	OUsF4t30ULTQXkAOefO4u5Svuip+02oQ68l4nXOWzClbFPpDk3pV7j7mmuTWhRPQnxuaKg8D4MB
	1MNC9aRs4QmGW90d+deTupnAu0u3l2u7aRGKzOx9zRd7kf9tUZxxgcDoqRDALXmqAR7QqUEHZjf
	JIwiWrM5eu+fgNSpW2QZL0vmQ9yy+mHkhYTVrGaiOOC7XsFz8IQ7zcV/VN2Kpils60TrvANGA2i
	pj/EoIexIHP62BERUXeGGjjSF2+btC87HeTUONujf8ocVKo6WWN1RQGkh
X-Received: by 2002:a05:622a:110b:b0:4ee:13dc:1040 with SMTP id d75a77b69052e-4f35f3b734dmr30144231cf.3.1766027381350;
        Wed, 17 Dec 2025 19:09:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfdLZ30w5pRfA9Ih4W+u/jeo5THTLc+le32L9IwQXYObCxXbDvZau3P65WhpH51pQIVagBNg==
X-Received: by 2002:a05:622a:110b:b0:4ee:13dc:1040 with SMTP id d75a77b69052e-4f35f3b734dmr30143971cf.3.1766027380956;
        Wed, 17 Dec 2025 19:09:40 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f35fcb439csm7643781cf.15.2025.12.17.19.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 19:09:40 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <08b26d6b-2a8b-491a-aa38-b93e21728445@redhat.com>
Date: Wed, 17 Dec 2025 22:09:39 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 5/6] cpuset: separate generate_sched_domains for v1
 and v2
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20251217084942.2666405-1-chenridong@huaweicloud.com>
 <20251217084942.2666405-6-chenridong@huaweicloud.com>
 <8d0ef5fc-f392-40f8-9803-50807c172800@redhat.com>
 <3ca5c423-1b9e-4e59-acf0-ffe3f1086b7e@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <3ca5c423-1b9e-4e59-acf0-ffe3f1086b7e@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/17/25 8:28 PM, Chen Ridong wrote:
>
> On 2025/12/18 1:48, Waiman Long wrote:
> Thank you Longman:
>> On 12/17/25 3:49 AM, Chen Ridong wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> The generate_sched_domains() function currently handles both v1 and v2
>>> logic. However, the underlying mechanisms for building scheduler domains
>>> differ significantly between the two versions. For cpuset v2, scheduler
>>> domains are straightforwardly derived from valid partitions, whereas
>>> cpuset v1 employs a more complex union-find algorithm to merge overlapping
>>> cpusets. Co-locating these implementations complicates maintenance.
>>>
>>> This patch, along with subsequent ones, aims to separate the v1 and v2
>>> logic. For ease of review, this patch first copies the
>>> generate_sched_domains() function into cpuset-v1.c as
>>> cpuset1_generate_sched_domains() and removes v2-specific code. Common
>>> helpers and top_cpuset are declared in cpuset-internal.h. When operating
>>> in v1 mode, the code now calls cpuset1_generate_sched_domains().
>>>
>>> Currently there is some code duplication, which will be largely eliminated
>>> once v1-specific code is removed from v2 in the following patch.
>>>
>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>> ---
>>>    kernel/cgroup/cpuset-internal.h |  24 +++++
>>>    kernel/cgroup/cpuset-v1.c       | 167 ++++++++++++++++++++++++++++++++
>>>    kernel/cgroup/cpuset.c          |  31 +-----
>>>    3 files changed, 195 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>>> index 677053ffb913..bd767f8cb0ed 100644
>>> --- a/kernel/cgroup/cpuset-internal.h
>>> +++ b/kernel/cgroup/cpuset-internal.h
>>> @@ -9,6 +9,7 @@
>>>    #include <linux/cpuset.h>
>>>    #include <linux/spinlock.h>
>>>    #include <linux/union_find.h>
>>> +#include <linux/sched/isolation.h>
>>>      /* See "Frequency meter" comments, below. */
>>>    @@ -185,6 +186,8 @@ struct cpuset {
>>>    #endif
>>>    };
>>>    +extern struct cpuset top_cpuset;
>>> +
>>>    static inline struct cpuset *css_cs(struct cgroup_subsys_state *css)
>>>    {
>>>        return css ? container_of(css, struct cpuset, css) : NULL;
>>> @@ -242,6 +245,22 @@ static inline int is_spread_slab(const struct cpuset *cs)
>>>        return test_bit(CS_SPREAD_SLAB, &cs->flags);
>>>    }
>>>    +/*
>>> + * Helper routine for generate_sched_domains().
>>> + * Do cpusets a, b have overlapping effective cpus_allowed masks?
>>> + */
>>> +static inline int cpusets_overlap(struct cpuset *a, struct cpuset *b)
>>> +{
>>> +    return cpumask_intersects(a->effective_cpus, b->effective_cpus);
>>> +}
>>> +
>>> +static inline int nr_cpusets(void)
>>> +{
>>> +    assert_cpuset_lock_held();
>> For a simple helper like this one which only does an atomic_read(), I don't think you need to assert
>> that cpuset_mutex is held.
>>
> Will remove it.
>
> I added the lock because the location where it’s removed already includes the comment:
> /* Must be called with cpuset_mutex held.  */
>
>>> +    /* jump label reference count + the top-level cpuset */
>>> +    return static_key_count(&cpusets_enabled_key.key) + 1;
>>> +}
>>> +
>>>    /**
>>>     * cpuset_for_each_child - traverse online children of a cpuset
>>>     * @child_cs: loop cursor pointing to the current child
>>> @@ -298,6 +317,9 @@ void cpuset1_init(struct cpuset *cs);
>>>    void cpuset1_online_css(struct cgroup_subsys_state *css);
>>>    void update_domain_attr_tree(struct sched_domain_attr *dattr,
>>>                        struct cpuset *root_cs);
>>> +int cpuset1_generate_sched_domains(cpumask_var_t **domains,
>>> +            struct sched_domain_attr **attributes);
>>> +
>>>    #else
>>>    static inline void cpuset1_update_task_spread_flags(struct cpuset *cs,
>>>                        struct task_struct *tsk) {}
>>> @@ -311,6 +333,8 @@ static inline void cpuset1_init(struct cpuset *cs) {}
>>>    static inline void cpuset1_online_css(struct cgroup_subsys_state *css) {}
>>>    static inline void update_domain_attr_tree(struct sched_domain_attr *dattr,
>>>                        struct cpuset *root_cs) {}
>>> +static inline int cpuset1_generate_sched_domains(cpumask_var_t **domains,
>>> +            struct sched_domain_attr **attributes) { return 0; };
>>>      #endif /* CONFIG_CPUSETS_V1 */
>>>    diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
>>> index 95de6f2a4cc5..5c0bded46a7c 100644
>>> --- a/kernel/cgroup/cpuset-v1.c
>>> +++ b/kernel/cgroup/cpuset-v1.c
>>> @@ -580,6 +580,173 @@ void update_domain_attr_tree(struct sched_domain_attr *dattr,
>>>        rcu_read_unlock();
>>>    }
>>>    +/*
>>> + * cpuset1_generate_sched_domains()
>>> + *
>>> + * Finding the best partition (set of domains):
>>> + *    The double nested loops below over i, j scan over the load
>>> + *    balanced cpusets (using the array of cpuset pointers in csa[])
>>> + *    looking for pairs of cpusets that have overlapping cpus_allowed
>>> + *    and merging them using a union-find algorithm.
>>> + *
>>> + *    The union of the cpus_allowed masks from the set of all cpusets
>>> + *    having the same root then form the one element of the partition
>>> + *    (one sched domain) to be passed to partition_sched_domains().
>>> + */
>>> +int cpuset1_generate_sched_domains(cpumask_var_t **domains,
>>> +            struct sched_domain_attr **attributes)
>>> +{
>>> +    struct cpuset *cp;    /* top-down scan of cpusets */
>>> +    struct cpuset **csa;    /* array of all cpuset ptrs */
>>> +    int csn;        /* how many cpuset ptrs in csa so far */
>>> +    int i, j;        /* indices for partition finding loops */
>>> +    cpumask_var_t *doms;    /* resulting partition; i.e. sched domains */
>>> +    struct sched_domain_attr *dattr;  /* attributes for custom domains */
>>> +    int ndoms = 0;        /* number of sched domains in result */
>>> +    int nslot;        /* next empty doms[] struct cpumask slot */
>>> +    struct cgroup_subsys_state *pos_css;
>>> +    bool root_load_balance = is_sched_load_balance(&top_cpuset);
>>> +    int nslot_update;
>>> +
>>> +    assert_cpuset_lock_held();
>>> +
>>> +    doms = NULL;
>>> +    dattr = NULL;
>>> +    csa = NULL;
>>> +
>>> +    /* Special case for the 99% of systems with one, full, sched domain */
>>> +    if (root_load_balance) {
>>> +single_root_domain:
>>> +        ndoms = 1;
>>> +        doms = alloc_sched_domains(ndoms);
>>> +        if (!doms)
>>> +            goto done;
>>> +
>>> +        dattr = kmalloc(sizeof(struct sched_domain_attr), GFP_KERNEL);
>>> +        if (dattr) {
>>> +            *dattr = SD_ATTR_INIT;
>>> +            update_domain_attr_tree(dattr, &top_cpuset);
>>> +        }
>>> +        cpumask_and(doms[0], top_cpuset.effective_cpus,
>>> +                housekeeping_cpumask(HK_TYPE_DOMAIN));
>>> +
>>> +        goto done;
>>> +    }
>>> +
>>> +    csa = kmalloc_array(nr_cpusets(), sizeof(cp), GFP_KERNEL);
>>> +    if (!csa)
>>> +        goto done;
>>> +    csn = 0;
>>> +
>>> +    rcu_read_lock();
>>> +    if (root_load_balance)
>>> +        csa[csn++] = &top_cpuset;
>>> +    cpuset_for_each_descendant_pre(cp, pos_css, &top_cpuset) {
>>> +        if (cp == &top_cpuset)
>>> +            continue;
>>> +
>>> +        /*
>>> +         * v1:
>> Remove this v1 line.
> Will do.
>
>>> +         * Continue traversing beyond @cp iff @cp has some CPUs and
>>> +         * isn't load balancing.  The former is obvious.  The
>>> +         * latter: All child cpusets contain a subset of the
>>> +         * parent's cpus, so just skip them, and then we call
>>> +         * update_domain_attr_tree() to calc relax_domain_level of
>>> +         * the corresponding sched domain.
>>> +         */
>>> +        if (!cpumask_empty(cp->cpus_allowed) &&
>>> +            !(is_sched_load_balance(cp) &&
>>> +              cpumask_intersects(cp->cpus_allowed,
>>> +                     housekeeping_cpumask(HK_TYPE_DOMAIN))))
>>> +            continue;
>>> +
>>> +        if (is_sched_load_balance(cp) &&
>>> +            !cpumask_empty(cp->effective_cpus))
>>> +            csa[csn++] = cp;
>>> +
>>> +        /* skip @cp's subtree */
>>> +        pos_css = css_rightmost_descendant(pos_css);
>>> +        continue;
>>> +    }
>>> +    rcu_read_unlock();
>>> +
>>> +    /*
>>> +     * If there are only isolated partitions underneath the cgroup root,
>>> +     * we can optimize out unneeded sched domains scanning.
>>> +     */
>>> +    if (root_load_balance && (csn == 1))
>>> +        goto single_root_domain;
>> This check is v2 specific and you can remove it as well as the "single_root_domain" label.
>>
> Thank you.
>
> Will remove.
>
> Just a note — I removed this code for cpuset v2. Please confirm if that's acceptable. If we drop the
> v1-specific logic, handling this case wouldn’t take much extra work.

This code is there because of the single dom check above that handles 
both v1 and v2. With just one version to support, this extra code isn't 
necessary.

Cheers,
Longman


>


