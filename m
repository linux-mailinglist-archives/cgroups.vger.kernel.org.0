Return-Path: <cgroups+bounces-12470-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 282D1CCA275
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 04:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB7013018967
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 03:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DDF25DB12;
	Thu, 18 Dec 2025 03:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UM7BsEo8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kgyD2Zui"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493682264CD
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 03:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766027673; cv=none; b=H9/AALgcXsndM4nWHchn2nCOHzxIKJzkZZNgoC/r5NxwLwqiI/vDUsjcg1+ymDziE0BFgfyklRCRECOwtlJk7HFntP1DUirj8OVCzk4AUPTPfTwvB8oixJtHidS2dRUz3VoCt1nlZsklAdxAWNzf2PuNdhf4kL0k1zVRLHaGs8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766027673; c=relaxed/simple;
	bh=ITrvrb73rpM5Nz++GuBVe8EOrLS0W1M/RLmMLflItsM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uvKYPBWZJ3hqTgKoHtakt7/mqygpSIbQ75jrtW7A+zx6nmv8yJ0tKHaAnY7tmXDHoOcnAjcapL4mkhRlavPNqZX94JbK6OS8NyEPkFIa+HvlYfX8Nqu3628mKeEEW92OkKRtNXNnR0AfloUvd/WDACrD89HeqhfXmLExZ2NQwFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UM7BsEo8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kgyD2Zui; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766027670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dDdii1A6xOtpyoZciuBL4nUrdFTrmjDsM6HWwnWPBzI=;
	b=UM7BsEo8sogUVdblXB3VCe7WdspjKBJ94YR3yElssYzdPQ7kUAy1uHatN2o9vXvvjq0xqg
	043iMceNU6JOaGCOf1EBdP6zWVwJXXtN+rQuNotYwPx0OIR2QPXDA0ClzUhykEYkjwDLXt
	CxqJ8GsqXrAoOg5/dcf+qoZPrDgjlts=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-zqfo6g93N-O8R80toHEXdw-1; Wed, 17 Dec 2025 22:14:29 -0500
X-MC-Unique: zqfo6g93N-O8R80toHEXdw-1
X-Mimecast-MFC-AGG-ID: zqfo6g93N-O8R80toHEXdw_1766027669
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b1d8f56e24so50114385a.2
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 19:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766027668; x=1766632468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dDdii1A6xOtpyoZciuBL4nUrdFTrmjDsM6HWwnWPBzI=;
        b=kgyD2Zui+gm5jUWHan82QjMQ4QpuHz1YrN0TcXruGSi6I1rl9mQ2A6xX/ralaPlzLG
         oeFsVLsHsk7lRlLh9JVGA55830QmB6S73gS5CZpVWsmSXqDH9irMOctVXQGkteD85WXs
         B9GRWcq3jPh4y7N4QZR1BaL2WxNY1XbR0hLYwyBu/QKSBqVlQcHP9qlFsGKzNGpbdj6u
         n8M3NqOjOl622vTK6akRIt+Gt3komac20NlQ920vA8IXHsuw3dEkCIeJS8KHH62vuhp+
         yAH7L2YgqfMwuq5Ch9YkIE9e1UHyLhOkFxRzGQfFj12c0yOiZLEzm1v+tlIprHzuwEzp
         D9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766027668; x=1766632468;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDdii1A6xOtpyoZciuBL4nUrdFTrmjDsM6HWwnWPBzI=;
        b=UeJXclFerldJIUhXsgrlsGiYk1xDPMK69gifngtTJCNz89Bm4RhfIe76PtJDBPX35K
         Retz5JFkDAP2gpEYW/Tjy4rTblQqWC9/TwKf7jEMugUxzeNTCEPQL1G3wV2Lhmt+ZxUD
         XWhVLfs+YW695ZWhKyT4A/FtE9uyfM+52KLjfWZKTiXjG/LUNdWnXbfUCZMeqFyjeWTT
         kAXbQyv+Y3FH8CveqjfPGKcPbAwQTJJCETS9a4MOYUwnzoX9iDIN5Y/QzE4GZSncR32u
         EUu0GKNnf5mFkz3WTJHWIXN2GIJZY/I8+tWXAIx9R6iRr02sxstvY07GNxUMvXShfqTR
         GHWg==
X-Gm-Message-State: AOJu0YwYS9wYmC03XlhJjJP+Hd0aSts39jpL3mKtkX8vxXbQ19Ye4h2N
	YRR8/7g3k3FUHUG3w4xGjeoS2TiPKlmmEcDNHplnWxI6i1FLsf7adIFZGn4RaAzMd3xYplwBJuY
	LL9C26iu/alP2G/9GlBRQFEFJlPRqxdOIEkmffRfHDY46OMbcutpPy/Q0KiNZWiKBY0Q=
X-Gm-Gg: AY/fxX7H9x7wMl/CFJ4w3/6nw8xmt6u2kaPjozSOudd+JoY4cy//2wUWKkrpnhFPlpz
	EkY6RMMT/+7PJ4T8ZVyz+O26uAHYTYSo8jvwt6zDXBic5J7yq2gD3SeGZhLhnsjIfgl4jPRMEqi
	i6qAy75tPJhH3s6uaT1JmmR+AhFVlnlKbrXUqypf84cmrHTiJxg17JT8/+bN/tnkJtveWQ/0T3Z
	ebRF6GBxHrRSlZz4cEmXe1O/1DWzTHKqchLBeYA74vgzwnGKucYCnajEdSZAOqqtcp2qIAx6qEg
	oMdpwgALqNh1oHbmzJe8grfjXdULOteImCfTP2hRJtXXU+ARroZN8HHb2plP1jnGurja5PPdWfF
	4r4nNMLB1/F2LZ7btAx7JPPPGWibGpyi185vGsNVD3xd4FdKMO6Iyvh1Y
X-Received: by 2002:a05:620a:40ca:b0:8b2:d72d:e41c with SMTP id af79cd13be357-8bb399d8ee4mr2909060485a.5.1766027668420;
        Wed, 17 Dec 2025 19:14:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfHwzcjJ8SrkkYlqKP2DImLQsaRQuSzNXu8V+TLg58mh0e54nxMchn1H7ovokdhm1CNn4A7g==
X-Received: by 2002:a05:620a:40ca:b0:8b2:d72d:e41c with SMTP id af79cd13be357-8bb399d8ee4mr2909058985a.5.1766027668039;
        Wed, 17 Dec 2025 19:14:28 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8beeb5c3e13sm81320785a.8.2025.12.17.19.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 19:14:27 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5a4927e2-ff7f-4f81-b8e3-183f3acb84f4@redhat.com>
Date: Wed, 17 Dec 2025 22:14:26 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 6/6] cpuset: remove v1-specific code from
 generate_sched_domains
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20251217084942.2666405-1-chenridong@huaweicloud.com>
 <20251217084942.2666405-7-chenridong@huaweicloud.com>
 <47029555-aba6-4d85-ace3-0580ec606e5d@redhat.com>
 <c6dfcbc9-c7e1-4221-b79c-b4c745e5b167@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <c6dfcbc9-c7e1-4221-b79c-b4c745e5b167@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/17/25 8:39 PM, Chen Ridong wrote:
>
> On 2025/12/18 3:05, Waiman Long wrote:
>> On 12/17/25 3:49 AM, Chen Ridong wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> Following the introduction of cpuset1_generate_sched_domains() for v1
>>> in the previous patch, v1-specific logic can now be removed from the
>>> generic generate_sched_domains(). This patch cleans up the v1-only
>>> code and ensures uf_node is only visible when CONFIG_CPUSETS_V1=y.
>>>
>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>> ---
>>>    kernel/cgroup/cpuset-internal.h |  10 +--
>>>    kernel/cgroup/cpuset-v1.c       |   2 +-
>>>    kernel/cgroup/cpuset.c          | 144 +++++---------------------------
>>>    3 files changed, 27 insertions(+), 129 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>>> index bd767f8cb0ed..ef7b7c5afd4c 100644
>>> --- a/kernel/cgroup/cpuset-internal.h
>>> +++ b/kernel/cgroup/cpuset-internal.h
>>> @@ -175,14 +175,14 @@ struct cpuset {
>>>        /* Handle for cpuset.cpus.partition */
>>>        struct cgroup_file partition_file;
>>>    -    /* Used to merge intersecting subsets for generate_sched_domains */
>>> -    struct uf_node node;
>>> -
>>>    #ifdef CONFIG_CPUSETS_V1
>>>        struct fmeter fmeter;        /* memory_pressure filter */
>>>          /* for custom sched domain */
>>>        int relax_domain_level;
>>> +
>>> +    /* Used to merge intersecting subsets for generate_sched_domains */
>>> +    struct uf_node node;
>>>    #endif
>>>    };
>>>    @@ -315,8 +315,6 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
>>>    int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial);
>>>    void cpuset1_init(struct cpuset *cs);
>>>    void cpuset1_online_css(struct cgroup_subsys_state *css);
>>> -void update_domain_attr_tree(struct sched_domain_attr *dattr,
>>> -                    struct cpuset *root_cs);
>>>    int cpuset1_generate_sched_domains(cpumask_var_t **domains,
>>>                struct sched_domain_attr **attributes);
>>>    @@ -331,8 +329,6 @@ static inline int cpuset1_validate_change(struct cpuset *cur,
>>>                    struct cpuset *trial) { return 0; }
>>>    static inline void cpuset1_init(struct cpuset *cs) {}
>>>    static inline void cpuset1_online_css(struct cgroup_subsys_state *css) {}
>>> -static inline void update_domain_attr_tree(struct sched_domain_attr *dattr,
>>> -                    struct cpuset *root_cs) {}
>>>    static inline int cpuset1_generate_sched_domains(cpumask_var_t **domains,
>>>                struct sched_domain_attr **attributes) { return 0; };
>>>    diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
>>> index 5c0bded46a7c..0226350e704f 100644
>>> --- a/kernel/cgroup/cpuset-v1.c
>>> +++ b/kernel/cgroup/cpuset-v1.c
>>> @@ -560,7 +560,7 @@ update_domain_attr(struct sched_domain_attr *dattr, struct cpuset *c)
>>>            dattr->relax_domain_level = c->relax_domain_level;
>>>    }
>>>    -void update_domain_attr_tree(struct sched_domain_attr *dattr,
>>> +static void update_domain_attr_tree(struct sched_domain_attr *dattr,
>>>                        struct cpuset *root_cs)
>>>    {
>>>        struct cpuset *cp;
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index 6bb0b201c34b..3e3468d928f3 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -789,18 +789,13 @@ static int generate_sched_domains(cpumask_var_t **domains,
>>>    {
>>>        struct cpuset *cp;    /* top-down scan of cpusets */
>>>        struct cpuset **csa;    /* array of all cpuset ptrs */
>>> -    int csn;        /* how many cpuset ptrs in csa so far */
>>>        int i, j;        /* indices for partition finding loops */
>>>        cpumask_var_t *doms;    /* resulting partition; i.e. sched domains */
>>>        struct sched_domain_attr *dattr;  /* attributes for custom domains */
>>>        int ndoms = 0;        /* number of sched domains in result */
>>> -    int nslot;        /* next empty doms[] struct cpumask slot */
>>>        struct cgroup_subsys_state *pos_css;
>>> -    bool root_load_balance = is_sched_load_balance(&top_cpuset);
>>> -    bool cgrpv2 = cpuset_v2();
>>> -    int nslot_update;
>>>    -    if (!cgrpv2)
>>> +    if (!cpuset_v2())
>>>            return cpuset1_generate_sched_domains(domains, attributes);
>>>          doms = NULL;
>>> @@ -808,70 +803,25 @@ static int generate_sched_domains(cpumask_var_t **domains,
>>>        csa = NULL;
>>>          /* Special case for the 99% of systems with one, full, sched domain */
>>> -    if (root_load_balance && cpumask_empty(subpartitions_cpus)) {
>>> -single_root_domain:
>>> +    if (cpumask_empty(subpartitions_cpus)) {
>>>            ndoms = 1;
>>> -        doms = alloc_sched_domains(ndoms);
>>> -        if (!doms)
>>> -            goto done;
>>> -
>>> -        dattr = kmalloc(sizeof(struct sched_domain_attr), GFP_KERNEL);
>>> -        if (dattr) {
>>> -            *dattr = SD_ATTR_INIT;
>>> -            update_domain_attr_tree(dattr, &top_cpuset);
>>> -        }
>>> -        cpumask_and(doms[0], top_cpuset.effective_cpus,
>>> -                housekeeping_cpumask(HK_TYPE_DOMAIN));
>>> -
>>> -        goto done;
>>> +        goto generate_doms;
>> That is not correct. The code under the generate_doms label will need to access csa[0] which is not
>> allocated yet and may cause panic. You either need to keep the current code or move it after the csa
>> allocation and assign top_cpuset to csa[0].
>>
> Thank you, Longman.
>
> Sorry, I should note that I made a small change. I added a !csa check: if csa is not allocated, then
> ndoms should equal 1, and we only need the top_cpuset (no csa is indeed required). I think it's
> cleaner to avoid allocating csa when there's no valid partition.
>
> ```
> +	for (i = 0; i < ndoms; i++) {
> +		/*
> +		 * The top cpuset may contain some boot time isolated
> +		 * CPUs that need to be excluded from the sched domain.
> +		 */
> +		if (!csa || csa[i] == &top_cpuset)
> +			cpumask_and(doms[i], top_cpuset.effective_cpus,
> +				    housekeeping_cpumask(HK_TYPE_DOMAIN));
> +		else
> +			cpumask_copy(doms[i], csa[i]->effective_cpus);
> +		if (dattr)
> +			dattr[i] = SD_ATTR_INIT;
>   	}
> ```
>
> Tested with single‑domain generation — no panic or warning observed.

Yes, !csa check here should be good enough to handle the NULL csa case 
here. Maybe adding a comment in the goto line saying that !csa will be 
correctly handled.

Cheers,
Longman


