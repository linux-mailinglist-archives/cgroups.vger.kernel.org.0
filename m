Return-Path: <cgroups+bounces-7699-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DBDA95AC6
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 04:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9EFE3B3094
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 02:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7DD15B54A;
	Tue, 22 Apr 2025 02:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnnGJgt5"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5617D2C18A
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 02:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745287352; cv=none; b=pgHrwike4uvHlYaibxub6KpdV7l7H6zYXlg4Urtb58Yw6OkCxq/JI1eDTHW0DTSrjDbRAxmKtIyy8l4hN6SFvg7GU4GlpCr9C7CtcRKUOHxALYCHLINL27e/PSV4NxdvEDHB1XAdEPDI0USNQdj89Pxq33QZL7LPb/MkSOo+Qx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745287352; c=relaxed/simple;
	bh=szMKRwJiwLsdV0adILb1Q27nFRzkAr38HS14FqDJhSU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kU3ySangC2pP/wJ8Z1Ziofk00zLJk5Qnk5qPSqwZ4xedRJIib8IPnIpmq3yFAnxnREA3E8zmCAAPWWiXGEiK8a+xjAM/6bJ1cBwFPGmHgmvXg2q9QjTMWaYPiJWS7Slm1px8tCbtcJLOgtNK0WPyNxPqZE62EEZDlivbv5+0oB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OnnGJgt5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745287349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wVDUl4XVuutoa7W6ehuEIlOCIvIKUBN9QU/AW89gF3Q=;
	b=OnnGJgt5/StjmY8ay6Eh2Zuq3uhO++qBHgMMgrq4Xss4lIVsR73qeKulpFW1ANfB/zxRG7
	DGDkf521G+vyGc20iNLZjEd/l0MA8HuPaCQRRaYQrlSSoxGrhwDQW8G4E2ZeHApYG5HEoD
	Dpl0wWjxeX9RVub8Y1ic0S37lf+yI2s=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-FIZNqUm5M8-L9jWTq36FHg-1; Mon, 21 Apr 2025 22:02:27 -0400
X-MC-Unique: FIZNqUm5M8-L9jWTq36FHg-1
X-Mimecast-MFC-AGG-ID: FIZNqUm5M8-L9jWTq36FHg_1745287347
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c5d608e6f5so668914585a.0
        for <cgroups@vger.kernel.org>; Mon, 21 Apr 2025 19:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745287347; x=1745892147;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVDUl4XVuutoa7W6ehuEIlOCIvIKUBN9QU/AW89gF3Q=;
        b=r7HQkSv5p5wNWeANpjeAv1nGqeUJEB3s0jX1pXnhPCfAs636Ne/sl9FRloHw+kJtqq
         rDm5qyWbnaMIil5uTlRaU1u4MKoJ3i06RWSm0xDcTxSOAr+feF2vuk1AaSO/JxlYlJvS
         Jk6YWwvI3Ak5QpwHNRP43uscnV68uU/k74msZWJWV1wGDsSGXkd8bl9RFzjv80Qixb3u
         Sxo4aWUof/jlBChDJeP6kl5ODHflEoj3nkQ2eChSmd4gBE0SlFI5PI9HaahkA3uY2tOM
         FaxrgE9mebbHBDVqX2qC880N28yWalTAFLb+KCyEAxgH/lP5AvBKtWlaqT1ZCOSCk8zN
         9fOg==
X-Gm-Message-State: AOJu0YzJlHt9569f2Y6NMhP7PfEFnJuYUB6M60ECso4kiodo8YKHqz/e
	xX3BR6Yww7qHYpdVkchJgizE9N4VQj6O0R8ZLdMcgAXd8rJaTlUNAeyb6eSO6P32vUL+km4hVmJ
	SDy0s/wVUhu0OV+QKB9dCFmxIVH5CntGxVfN0qHyS4xeku8elj8ldiFc=
X-Gm-Gg: ASbGncsu6US/KmiDUxZLW8LZrPsJexHaG2W8ZDvNjdslyIHUpoUwOrjvwtqcwmHWRSH
	nmuONeUJlapK3QqcVkQKyZYCcBsumSKC77txhiOE0xVBQH1xO4IO/c/GDVYq6gZ5DzuHvG81pjy
	IQaiP+kMA8V0IMf40HxCc5N/MzCiie5+cZX7BlLUKOsqgNO1fbXbDvz2H9Dy0bqabE0U/RQBI2A
	deSTqCPZi0oa7HoLl6ahd/sDQODdPcR+Nw/CJAbFN9ncHY7v1o/nc7Gn2nEgWUN9PQRUNLtCIjp
	Th6/GK0wvW8VzAH4AkMB9cuz6kgEZ6GgSne4RtaWOWEcHJ4bfiumsece0A==
X-Received: by 2002:a05:620a:394e:b0:7c5:e2fe:f431 with SMTP id af79cd13be357-7c928049fc1mr2423339485a.52.1745287346679;
        Mon, 21 Apr 2025 19:02:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkvsVukE5sYNg24vtRwuD8ekLBV3eTy0mZIwunL0RQt6blOekbXA8+cDInRCyblxUVlgDdrw==
X-Received: by 2002:a05:620a:394e:b0:7c5:e2fe:f431 with SMTP id af79cd13be357-7c928049fc1mr2423335585a.52.1745287346244;
        Mon, 21 Apr 2025 19:02:26 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b78f0csm492272385a.105.2025.04.21.19.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 19:02:25 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <d7568176-6199-488f-b45a-c494c8baec25@redhat.com>
Date: Mon, 21 Apr 2025 22:02:22 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] vmscan,cgroup: apply mems_effective to reclaim
To: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 tj@kernel.org, mkoutny@suse.com, akpm@linux-foundation.org
References: <20250422012616.1883287-1-gourry@gourry.net>
 <20250422012616.1883287-3-gourry@gourry.net>
Content-Language: en-US
In-Reply-To: <20250422012616.1883287-3-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/21/25 9:26 PM, Gregory Price wrote:
> It is possible for a reclaimer to cause demotions of an lruvec belonging
> to a cgroup with cpuset.mems set to exclude some nodes. Attempt to apply
> this limitation based on the lruvec's memcg and prevent demotion.
>
> Notably, this may still allow demotion of shared libraries or any memory
> first instantiated in another cgroup. This means cpusets still cannot
> cannot guarantee complete isolation when demotion is enabled, and the
> docs have been updated to reflect this.
>
> This is useful for isolating workloads on a multi-tenant system from
> certain classes of memory more consistently - with the noted exceptions.
>
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>   .../ABI/testing/sysfs-kernel-mm-numa          | 16 +++++---
>   include/linux/cpuset.h                        |  5 +++
>   include/linux/memcontrol.h                    |  6 +++
>   kernel/cgroup/cpuset.c                        | 26 ++++++++++++
>   mm/memcontrol.c                               |  6 +++
>   mm/vmscan.c                                   | 41 +++++++++++--------
>   6 files changed, 78 insertions(+), 22 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-numa b/Documentation/ABI/testing/sysfs-kernel-mm-numa
> index 77e559d4ed80..90e375ff54cb 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-numa
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-numa
> @@ -16,9 +16,13 @@ Description:	Enable/disable demoting pages during reclaim
>   		Allowing page migration during reclaim enables these
>   		systems to migrate pages from fast tiers to slow tiers
>   		when the fast tier is under pressure.  This migration
> -		is performed before swap.  It may move data to a NUMA
> -		node that does not fall into the cpuset of the
> -		allocating process which might be construed to violate
> -		the guarantees of cpusets.  This should not be enabled
> -		on systems which need strict cpuset location
> -		guarantees.
> +		is performed before swap if an eligible numa node is
> +		present in cpuset.mems for the cgroup (or if cpuset v1
> +		is being used). If cpusets.mems changes at runtime, it
> +		may move data to a NUMA node that does not fall into the
> +		cpuset of the new cpusets.mems, which might be construed
> +		to violate the guarantees of cpusets.  Shared memory,
> +		such as libraries, owned by another cgroup may still be
> +		demoted and result in memory use on a node not present
> +		in cpusets.mem. This should not be enabled on systems
> +		which need strict cpuset location guarantees.
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 893a4c340d48..5255e3fdbf62 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -171,6 +171,7 @@ static inline void set_mems_allowed(nodemask_t nodemask)
>   	task_unlock(current);
>   }
>   
> +extern bool cpuset_node_allowed(struct cgroup *cgroup, int nid);
>   #else /* !CONFIG_CPUSETS */
>   
>   static inline bool cpusets_enabled(void) { return false; }
> @@ -282,6 +283,10 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
>   	return false;
>   }
>   
> +static inline bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> +{
> +	return true;
> +}
>   #endif /* !CONFIG_CPUSETS */
>   
>   #endif /* _LINUX_CPUSET_H */
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 53364526d877..a6c4e3faf721 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1736,6 +1736,8 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
>   	rcu_read_unlock();
>   }
>   
> +bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid);
> +
>   #else
>   static inline bool mem_cgroup_kmem_disabled(void)
>   {
> @@ -1793,6 +1795,10 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
>   {
>   }
>   
> +static inline bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
> +{
> +	return true;
> +}
>   #endif /* CONFIG_MEMCG */
>   
>   #if defined(CONFIG_MEMCG) && defined(CONFIG_ZSWAP)
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index f8e6a9b642cb..c52348bfd5db 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4163,6 +4163,32 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
>   	return allowed;
>   }
>   
> +bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> +{
> +	struct cgroup_subsys_state *css;
> +	struct cpuset *cs;
> +	bool allowed;
> +
> +	/*
> +	 * In v1, mem_cgroup and cpuset are unlikely in the same hierarchy
> +	 * and mems_allowed is likely to be empty even if we could get to it,
> +	 * so return true to avoid taking a global lock on the empty check.
> +	 */
> +	if (!cpuset_v2())
> +		return true;
> +
> +	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
> +	if (!css)
> +		return true;
> +
> +	cs = container_of(css, struct cpuset, css);
> +	rcu_read_lock();

Sorry, I missed the fact that cgroup_get_e_css() will take a reference 
to the css and so it won't go away. In that case, rcu_read_lock() isn't 
really needed. However, I do want a comment to say that accessing 
effective_mems should normally requrie taking either a cpuset_mutex or 
callback_lock, but is skipped in this case to avoid taking a global lock 
in the reclaim path at the expense that the result may be inaccurate in 
some rare cases.

Cheers,
Longman

Cheers,
Longman


