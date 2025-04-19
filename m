Return-Path: <cgroups+bounces-7648-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E70BA940FC
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 04:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58646442B0C
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 02:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A0B146A68;
	Sat, 19 Apr 2025 02:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MC2+dy0w"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28396F099
	for <cgroups@vger.kernel.org>; Sat, 19 Apr 2025 02:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745028411; cv=none; b=r2oh3IHvm2TVXFPKsC73CD1PffvibcDhmEqlrZ2ogv7GwnhYlUpdJOz9loZnUGONBe+zdU6FcD/MAVs4SvdC+j/vk7RcB38FfECyHzxGRLj2Jlb8QVeQ7lQONlzZ6i4KxAaBivmsMxam+Vrzz6XmxoU0de+6IEFl5CKyH3RmZQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745028411; c=relaxed/simple;
	bh=J8edkT/dlhLbGssrkoyx6Tobg+gIJo+zAqjLwecFDA4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xk4gx9EdvOhhBvocFGjeRQkYB9FHa0cYAZdKZyigUGuwfgrulGbxu2aw9iHRe0FEIJc43kiHoYgd12x3JUVJYcyCCl28fhDJSzP6sOrNTHsj7rg1CaQi5vJvBOUgiOBd6CixfcJlhiKQLIrTH3eD2X3rMj20G28uSJqndml9LUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MC2+dy0w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745028408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fg5jTz0E8wfSFW3z1gz+claCWc6uoPxGD1UaNbxQo8M=;
	b=MC2+dy0wMg3HwEP3cSGy8vVu7Gak3kueOgC4F9U1b8JuKjd9MWJPRz65lJU/u5BL5F387z
	qtO/u00bzw6NMB1kRxVE3J6c/ebeb75LUETjuTM5T7GpTgAbZqjZCZeDvfjt/y8VAZnBYj
	5xdy2XjgL6VMojWJgTNhErXpp8UbKdw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-qorVR5BtO4qHv5uRRGzXxQ-1; Fri, 18 Apr 2025 22:06:43 -0400
X-MC-Unique: qorVR5BtO4qHv5uRRGzXxQ-1
X-Mimecast-MFC-AGG-ID: qorVR5BtO4qHv5uRRGzXxQ_1745028403
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c793d573b2so409640585a.1
        for <cgroups@vger.kernel.org>; Fri, 18 Apr 2025 19:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745028403; x=1745633203;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fg5jTz0E8wfSFW3z1gz+claCWc6uoPxGD1UaNbxQo8M=;
        b=fTL9G1OVesknNCGO9VDGD+ydU2flNTOvg/9PVU9Q6kIRXLzS7EcBA8jw9DdX6m9hBM
         FCOsWSpBgl18adeZG4EQzitCqL+fuSTnvE2H/ejhNBbHfnnkclwqdJhHpKI1gyO7yRiJ
         UW79mXmoR4wK2/yKFj58cPBZeppJAkHpqD2nxe8igfM8wYh5+N6cQbhajDWR0T7U8btq
         VAgUmn2IygYsegFgWC3scw4yv4pr1R9WrrZeLm6vqOcrv3SDIGZXBwpqrYCuu570kQ+h
         IGT4DA24MxRApXDtZU55iV/jQpQlVGheNH2fgd+aJhLRM3YWHPkZWOq+d7vC7YxSVC3W
         djeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkDM0t2C9H8n53gdjUNqqiSngqx1WtDSu03QFg3AYw7pHHbu4CRZdrZYcifzzXb4plKkBCRZSQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwAkGXNhvObatc0xJLWbLhcfZQGkaMUrQvF23MDBhi3//0wk+pZ
	uavFxb1Fn5wHPzegQ+M3R1X1KYseXuXS22GM84OqFv3n8ODhCbe5lKi459pPvO0y9pDJl2fgOaN
	HC+hFKqnccG8SVar7u/r1lB6MS5/PxX7nuZDQWWkgMcN9I8vbWnzeaxo=
X-Gm-Gg: ASbGncucBX5ucd9+ioaGQxV0c78LVBlw4vM266JtaIPF295x6dcS5wGR6DOSGusVAMm
	PIbAF5fTEpornqp3phwXQFugp2vEG3RcME6IYZaq1EaeSL5ljGk76rzw+XbQj5XSJMWzO91N4Hr
	AivvKPFsoh6oHk6aaqBgbaWV2vVKIRwhupQom1pxzHbdVR/GcnwOx/E3ILgM4vnJkM5PLKMj7/Q
	ClSyTYf9JeSeH1tQLZzM+AczIr3lONxdUD2P145s2K3q4nWc55J1vnsYXYxyRD0tfKOHRgMzOGF
	RqIV6OOcybIpezJ9qm3nHIdw8ErpeflOz11sDqQU33HxSkwnNg==
X-Received: by 2002:a05:620a:1a88:b0:7c5:4caa:21b7 with SMTP id af79cd13be357-7c928049e4fmr805918185a.56.1745028403371;
        Fri, 18 Apr 2025 19:06:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0Vva5HgQYqt3HAguwTyJTqtBqylBMgw/o808p/lVSAP69/kKkHthGT+f5tt9sh/5MY+qQTg==
X-Received: by 2002:a05:620a:1a88:b0:7c5:4caa:21b7 with SMTP id af79cd13be357-7c928049e4fmr805915785a.56.1745028402963;
        Fri, 18 Apr 2025 19:06:42 -0700 (PDT)
Received: from [192.168.130.170] (67-212-218-66.static.pfnllc.net. [67.212.218.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a90ce7sm167726485a.47.2025.04.18.19.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 19:06:42 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <162f1ae4-2adf-4133-8de4-20f240e5469e@redhat.com>
Date: Fri, 18 Apr 2025 22:06:40 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] vmscan,cgroup: apply mems_effective to reclaim
To: Gregory Price <gourry@gourry.net>, cgroups@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 akpm@linux-foundation.org
References: <20250418031352.1277966-1-gourry@gourry.net>
 <20250418031352.1277966-2-gourry@gourry.net>
Content-Language: en-US
In-Reply-To: <20250418031352.1277966-2-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/25 11:13 PM, Gregory Price wrote:
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
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>   .../ABI/testing/sysfs-kernel-mm-numa          | 14 ++++---
>   include/linux/cgroup.h                        |  7 ++++
>   include/linux/cpuset.h                        |  5 +++
>   include/linux/memcontrol.h                    |  9 ++++
>   kernel/cgroup/cgroup.c                        |  5 +++
>   kernel/cgroup/cpuset.c                        | 22 ++++++++++
>   mm/vmscan.c                                   | 41 +++++++++++--------
>   7 files changed, 82 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-numa b/Documentation/ABI/testing/sysfs-kernel-mm-numa
> index 77e559d4ed80..27cdcab901f7 100644
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
> +		is performed before swap if an eligible numa node is
> +		present in cpuset.mems for the cgroup. If cpusets.mems
> +		changes at runtime, it may move data to a NUMA node that
> +		does not fall into the cpuset of the new cpusets.mems,
> +		which might be construed to violate the guarantees of
> +		cpusets.  Shared memory, such as libraries, owned by
> +		another cgroup may still be demoted and result in memory
> +		use on a node not present in cpusets.mem. This should not
> +		be enabled on systems which need strict cpuset location
>   		guarantees.
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index f8ef47f8a634..2915250a3e5e 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -632,6 +632,8 @@ static inline void cgroup_kthread_ready(void)
>   
>   void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen);
>   struct cgroup *cgroup_get_from_id(u64 id);
> +
> +extern bool cgroup_node_allowed(struct cgroup *cgroup, int nid);
>   #else /* !CONFIG_CGROUPS */
>   
>   struct cgroup_subsys_state;
> @@ -681,6 +683,11 @@ static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
>   
>   static inline void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
>   {}
> +
> +static inline bool cgroup_node_allowed(struct cgroup *cgroup, int nid)
> +{
> +	return true;
> +}
>   #endif /* !CONFIG_CGROUPS */
>   
>   #ifdef CONFIG_CGROUPS
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 893a4c340d48..c64b4a174456 100644
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
> +	return false;
> +}
>   #endif /* !CONFIG_CPUSETS */
>   
>   #endif /* _LINUX_CPUSET_H */
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 53364526d877..2906e4bb12e9 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1736,6 +1736,11 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
>   	rcu_read_unlock();
>   }
>   
> +static inline bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
> +{
> +	return memcg ? cgroup_node_allowed(memcg->css.cgroup, nid) : true;
> +}
> +
>   #else
>   static inline bool mem_cgroup_kmem_disabled(void)
>   {
> @@ -1793,6 +1798,10 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
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
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index afc665b7b1fe..ba0b90cd774c 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -7038,6 +7038,11 @@ int cgroup_parse_float(const char *input, unsigned dec_shift, s64 *v)
>   	return 0;
>   }
>   
> +bool cgroup_node_allowed(struct cgroup *cgroup, int nid)
> +{
> +	return cpuset_node_allowed(cgroup, nid);
> +}
> +
>   /*
>    * sock->sk_cgrp_data handling.  For more info, see sock_cgroup_data
>    * definition in cgroup-defs.h.
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index d6ed3f053e62..31e4c4cbcdfc 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4163,6 +4163,28 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
>   	return allowed;
>   }
>   
> +bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> +{
> +	struct cgroup_subsys_state *css;
> +	unsigned long flags;
> +	struct cpuset *cs;
> +	bool allowed;
> +
> +	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
> +	if (!css)
> +		return true;
> +
> +	cs = container_of(css, struct cpuset, css);
> +	spin_lock_irqsave(&callback_lock, flags);
> +	/* At least one parent must have a valid node list */
> +	while (nodes_empty(cs->effective_mems))
> +		cs = parent_cs(cs);

For cgroup v2, effective_mems should always be set and walking up the 
tree isn't necessary. For v1, it can be empty, but memory cgroup and 
cpuset are unlikely in the same hierarchy.

Cheers,
Longman


