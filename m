Return-Path: <cgroups+bounces-12440-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C33B5CC9032
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 18:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 543F430B9BFA
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 17:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36273349AFE;
	Wed, 17 Dec 2025 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AewiI/QT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oIddIlAt"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A773A33F362
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765991382; cv=none; b=EabDIkQBws6+EYtXZDa8BwPfH/RGU8C6Dcky+/7j4IO2zVMngkrFeLtFIyJs7nBpyxJjEuG2bNk1kscxjB63tGcsLjiXi6t9dl4ikoE5FpeA7YDZfulolFfRwofxCZ1jpsRH/VEaxZRpAa4fXaawuG9Ll61FBoEmupDU97e8a9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765991382; c=relaxed/simple;
	bh=kKD4kzhWRMQvtxQzPfFJjPaIuXnbXKAXsUYn+tPm1Rc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nbqvKjw+QAu3YS2u65wBt8aauCyZa0RVQWIaEZuCgH9tUw9dUpTeQOcH/01hbUH3SxbtJSylgGKwhgpKIhi8NXjeLOtJARtG8Q0YRXzzd/XzqrCsNl/a2e0q3qPXDopWIvWvv4GjFi9Up1l+nYDLN1uBRhXSkFbTdQnHt/Cnilg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AewiI/QT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oIddIlAt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765991378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cbJakwZRKMBXTIGpQKPp4Wc/aDYWRMed7IM81Pt8zs8=;
	b=AewiI/QT3H6x25AetdfHPVoyHZSZSSRIgQu94jJs6qlA/bitJxS4mpM40FzByLDQBkXJWF
	gmMcbXkvGvcCsrc3Nr0jTx4Dob8N4/GFgh8+tGzXFzRuJY/GhnhlefO2LnhS7XaPVW7b9K
	PevSCZRK7lsshxJPIJ9gHoEb4V66a80=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-CFokZeWLPMCW_DXuVb87Xg-1; Wed, 17 Dec 2025 12:09:37 -0500
X-MC-Unique: CFokZeWLPMCW_DXuVb87Xg-1
X-Mimecast-MFC-AGG-ID: CFokZeWLPMCW_DXuVb87Xg_1765991377
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b24383b680so2138453885a.0
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 09:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765991377; x=1766596177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cbJakwZRKMBXTIGpQKPp4Wc/aDYWRMed7IM81Pt8zs8=;
        b=oIddIlAtA1uC9Kr5/C5qRLXIzSv8tNRsULA7ke+wo5Ju3YjDtejC/Xl0adArV/yNKK
         wCZnDjGw7KhNdmBAVeGLSa7SZFsDBAEMc8VA3IauvlXz7NlO6ILu1/bsThL0bjn9/K4S
         KNfzvM1VymmIjkk/hYDaxhgRtQ1ug9iY0/JA2i5EYJSwapiV9Y334+/+S788HcwcHOug
         LE74n2/VpD1CD8+4PR6MMUOf55saJbJowUWeNMu4xTf05ycyKREDS2e9z5QVTVCDeu7R
         8i10BrBsSjdxRWAIV5v9TlCF7aoQO1XLH+q1Rw712PDXeH8S0kdp8UjcJWU6QT9HCoW1
         TXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765991377; x=1766596177;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbJakwZRKMBXTIGpQKPp4Wc/aDYWRMed7IM81Pt8zs8=;
        b=VkbTN0tGfpANyi5fdf6fmhJeyDcY6z1LpFPBLJsQOslueVnBapnakXbL5JQNBoopoD
         ZoHR2SFetcAHJ4JHlSbGz1lSu3uZ5kBHcaqpEP7rhk6Q2SbJKyAUIq8AuO7ihaOvG32I
         IKywjqN/vqLQEVr1l2tXkOagJw2KVpfo7utqt9LvBWHzt61eVrUrBiMmPVQHgutUPZNP
         6wVrzgX5MfYszgYHj5bLNaWze1kIXIrWHkwYZigSB3Ja5aoNe9aCtdC76oC9w9fDCHf/
         vVIXG3xzTa4cSym339X04KZevEuSw4tnjKPCtaJsSjFW98RimcW1k9H4/OjM5sCpY3jM
         oDUw==
X-Gm-Message-State: AOJu0YwPpOzNfiXGXveVpxfPx7ntYGjxYLrkjUukFTJKcnkRzPQZgV7G
	lz9i1SNPm5RJk5dlUmLQfEejgCvj6JQFghuxCksLZWWpjIcDdBP+d5WKuFcdZKCcCFzBgkoaWWN
	F/AeOho+FTEIbrzwtvRZQC+yoVo66+/x4PC9KzJhdwKfcQndIx6gD5DMByEGP8vwHSLs=
X-Gm-Gg: AY/fxX4YdUJxta1hr0IWPJ4Jz5uwmwNtUrIBXFKQq2jUryWjIz4OF3raI/pSdhwBL2G
	GrIavzdSMX6x1jqSzf5SzXmGfYmpXiKy03Dd+uP5OFpPXwN0pJ+NVSBI7zl0zFyydvaawj6ro1t
	6IRDasMYfc48bj2uuil+qzCwd5FtZOivYS+Q+RuW/uA9j+EbTc8hCuW+43NUonK/7mPF8K6ghXM
	ugLxMB6+hnGD3cVfJYvH3lutJ1YH1PtSbJ8LQMUD0R8Q97TMARGJU2nw5Py11fK1Z4/wU6b0xi1
	oMlFP5HRNJHDt+hi98KkYkkxxSOMBxDUwXQlVQ9DZGQr4Rk6ob5W75H9LZij7wyha1KHgbWNfZ2
	9s/8DidxuzoZS9NWd0uwrX5JTNZK74RYUXELAjy7Ak5u9j54C+VTi1Az7
X-Received: by 2002:a05:620a:4114:b0:88f:561:d956 with SMTP id af79cd13be357-8bb398d7595mr2382685985a.13.1765991376597;
        Wed, 17 Dec 2025 09:09:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFqhJsrNzhCydzFRijBg7qqhqLAk21JTEuiW09xtDklyd0t69U4Zf/j6JkVlZU6SBaA1zm+Q==
X-Received: by 2002:a05:620a:4114:b0:88f:561:d956 with SMTP id af79cd13be357-8bb398d7595mr2382681385a.13.1765991376127;
        Wed, 17 Dec 2025 09:09:36 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be30d869ecsm437757885a.14.2025.12.17.09.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 09:09:35 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <249786b2-f715-4a46-be47-d6d3d6f35c10@redhat.com>
Date: Wed, 17 Dec 2025 12:09:34 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 4/6] cpuset: move update_domain_attr_tree to
 cpuset_v1.c
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20251217084942.2666405-1-chenridong@huaweicloud.com>
 <20251217084942.2666405-5-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251217084942.2666405-5-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/17/25 3:49 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Since relax_domain_level is only applicable to v1, move
> update_domain_attr_tree() to cpuset-v1.c, which solely updates
> relax_domain_level,
>
> Additionally, relax_domain_level is now initialized in cpuset1_inited.
> Accordingly, the initialization of relax_domain_level in top_cpuset is
> removed. The unnecessary remote_partition initialization in top_cpuset
> is also cleaned up.
>
> As a result, relax_domain_level can be defined in cpuset only when
> CONFIG_CPUSETS_V1=y.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset-internal.h | 11 ++++++++---
>   kernel/cgroup/cpuset-v1.c       | 28 ++++++++++++++++++++++++++++
>   kernel/cgroup/cpuset.c          | 31 -------------------------------
>   3 files changed, 36 insertions(+), 34 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index a32517da8231..677053ffb913 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -150,9 +150,6 @@ struct cpuset {
>   	 */
>   	int attach_in_progress;
>   
> -	/* for custom sched domain */
> -	int relax_domain_level;
> -
>   	/* partition root state */
>   	int partition_root_state;
>   
> @@ -182,6 +179,9 @@ struct cpuset {
>   
>   #ifdef CONFIG_CPUSETS_V1
>   	struct fmeter fmeter;		/* memory_pressure filter */
> +
> +	/* for custom sched domain */
> +	int relax_domain_level;
>   #endif
>   };
>   
> @@ -296,6 +296,8 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
>   int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial);
>   void cpuset1_init(struct cpuset *cs);
>   void cpuset1_online_css(struct cgroup_subsys_state *css);
> +void update_domain_attr_tree(struct sched_domain_attr *dattr,
> +				    struct cpuset *root_cs);
>   #else
>   static inline void cpuset1_update_task_spread_flags(struct cpuset *cs,
>   					struct task_struct *tsk) {}
> @@ -307,6 +309,9 @@ static inline int cpuset1_validate_change(struct cpuset *cur,
>   				struct cpuset *trial) { return 0; }
>   static inline void cpuset1_init(struct cpuset *cs) {}
>   static inline void cpuset1_online_css(struct cgroup_subsys_state *css) {}
> +static inline void update_domain_attr_tree(struct sched_domain_attr *dattr,
> +				    struct cpuset *root_cs) {}
> +
>   #endif /* CONFIG_CPUSETS_V1 */
>   
>   #endif /* __CPUSET_INTERNAL_H */
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 574df740f21a..95de6f2a4cc5 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -502,6 +502,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
>   void cpuset1_init(struct cpuset *cs)
>   {
>   	fmeter_init(&cs->fmeter);
> +	cs->relax_domain_level = -1;
>   }
>   
>   void cpuset1_online_css(struct cgroup_subsys_state *css)
> @@ -552,6 +553,33 @@ void cpuset1_online_css(struct cgroup_subsys_state *css)
>   	cpuset_callback_unlock_irq();
>   }
>   
> +static void
> +update_domain_attr(struct sched_domain_attr *dattr, struct cpuset *c)
> +{
> +	if (dattr->relax_domain_level < c->relax_domain_level)
> +		dattr->relax_domain_level = c->relax_domain_level;
> +}
> +
> +void update_domain_attr_tree(struct sched_domain_attr *dattr,
> +				    struct cpuset *root_cs)
> +{
> +	struct cpuset *cp;
> +	struct cgroup_subsys_state *pos_css;
> +
> +	rcu_read_lock();
> +	cpuset_for_each_descendant_pre(cp, pos_css, root_cs) {
> +		/* skip the whole subtree if @cp doesn't have any CPU */
> +		if (cpumask_empty(cp->cpus_allowed)) {
> +			pos_css = css_rightmost_descendant(pos_css);
> +			continue;
> +		}
> +
> +		if (is_sched_load_balance(cp))
> +			update_domain_attr(dattr, cp);
> +	}
> +	rcu_read_unlock();
> +}
> +
>   /*
>    * for the common functions, 'private' gives the type of file
>    */
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e836a1f2b951..88ca8b40e01a 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -215,8 +215,6 @@ static struct cpuset top_cpuset = {
>   	.flags = BIT(CS_CPU_EXCLUSIVE) |
>   		 BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
>   	.partition_root_state = PRS_ROOT,
> -	.relax_domain_level = -1,

As the cpuset1_init() function will not be called for top_cpuset, you 
should not remove the initialization of relax_domain_level. Instead, put 
it inside a "ifdef CONFIG_CPUSETS_V1 block.

> -	.remote_partition = false,

Yes, this is not really needed and can be removed.

Cheers,
Longman


