Return-Path: <cgroups+bounces-10841-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC4ABEB1F3
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 19:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853F11AE060C
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 17:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B0332C92D;
	Fri, 17 Oct 2025 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCpzcIIU"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE40261595
	for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760723573; cv=none; b=u2AZzkZR+EEQTO/XUkAceXuQS6fsnOKrQi1RdAllBU2NNIlQbCYLF7o6U0Vjy+kQDO07giu+R0oVyC5zkmtTWvsvJGljGu6JZkm4f+Ol5mjWVv7mMhJxMLp1dEARG2LLqyt+LM+jjk9kgxR+ZChqr9FSD4n4TToKjD75bOdqubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760723573; c=relaxed/simple;
	bh=g88HbHHTSRSg4gKlhrfAykhenuBvTbK02JjqS/jVAfk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Pvh2YNeFndhZ0MdpsLRlSDugbZE8PtHNAjPjjhQAB61dLBp9lZZh+EPhlHcAZEORNGT0TI7MLd7SDPKhQ5E0AQXfcD4qwAaewWejKd5QLKMyHs55rm+Xdj3SVlMrF+thzMwInmzckUXJiqayRdYivzIqiD1ydO9VHjypHYNaJcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CCpzcIIU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760723569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7uFNgRkQxgrcaDrhBce90BY6iLcFw7TEYkoT72st+3g=;
	b=CCpzcIIUcv8YneLlGgAnvTE0DZKGXi/pCNQehABONgrd8WPXVvzmr/sgPtYJ1HlDf6rlZk
	XRx8d1GRCV+wb2WYHrpLjp2XV+PdQKDhQIf6dd5ZS+TzwsgY/CWnflSA3EU6OMB/ILemp/
	eXhdU1sN8eE2iKeT/j8aetRd3E6HAwc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-jrmZjiyQNnCn56JHorBgzA-1; Fri, 17 Oct 2025 13:52:48 -0400
X-MC-Unique: jrmZjiyQNnCn56JHorBgzA-1
X-Mimecast-MFC-AGG-ID: jrmZjiyQNnCn56JHorBgzA_1760723568
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-272b7bdf41fso29337605ad.0
        for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 10:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760723567; x=1761328367;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7uFNgRkQxgrcaDrhBce90BY6iLcFw7TEYkoT72st+3g=;
        b=JcWdiA/q++5Ymcs9nslBSUjHUM46TrSd/8nkeIwK5cDFfy0CmvtoOdKA//gWuYhuYx
         7ccYRa9BWe0dT1pk/sAmABb6ngzQdHez5ZeRX07X4E0mJrPIgtx3xLaJz1b+WoAOhADG
         UjK0Y7fY3F3iQBcvjK8DGhQxRTg16p5DWB4Q2RsUOxfXEkm3NwZ4gHDyaCWvS0pdLw3m
         cHGwkkmUOxUgsIFhhtg4iWbPm0+ce8jgVtyLD6XOoGnnJZGMEqmq7Au7M0OLHZcpAq75
         dXDEHr6p4PosBs/06qLIjgfNJe090U+CCx2FjLCr0JVDGeRBbJN0wMh3UBKHplZq8T2W
         W7Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUhr/u+d3kPxY6gph9w3qTdHPDhn7rZT34pOMyVdvvuMQuZQ3ly2fXCWpZEH0F+c+0YXj8SrvMs@vger.kernel.org
X-Gm-Message-State: AOJu0YwhzbkBBzNsLBPYAu/CJScgbpx3ASgZuQEzBvHCEyrKCuZsSxXi
	9WoJnv0U/0PjXDkYfaAc8fcs7g0kkY8NChHAHUVO3ZookMroVFWGDlQujMjxnx+oP0lh+9Jcjz/
	DTCGmzzyPuFUkilMouxuJpS9cOFVphBFQMaTHVamEQ/bllVzcQsJRZhmlUPs=
X-Gm-Gg: ASbGncu120Qn5tNISfg0xV6DXWxJWNW7HthJxWPGUDFZFfbsMSr+XiIUElME6+qBMQU
	5AAazTssWU8cmZygfshjbSwO6qb52M/064qJK0eMwqohZ2cYNknhkIWrwyItJ1UEeE49uYPK1kg
	0+tm+u3heQMOy4v+PuiuQxtX+WFXkk0OkXdoCBEGD9IVH476HfL6wjwBGH0sUjva/fkZDu2dX/M
	vGBvQBCvCW2cfQNnhvhKX25rjwudGKlmZvIGB/LkezOt09kNj4XtT97qiGqIF8YA4MdskkA+QYK
	f2xIvB/6cgUVji0yLUpGMpj0rK7Nl+GqsdkqFoMxuXfr1sZ/PHwlYOrWYk5ZohVSjjxepV2EchB
	bVTVwHVYKVPFaN82F8IKzqPtJo7HOMhFARNELxsQNL/JZ/Q==
X-Received: by 2002:a17:902:ce8d:b0:27e:dc53:d239 with SMTP id d9443c01a7336-290caf84628mr52931075ad.35.1760723567604;
        Fri, 17 Oct 2025 10:52:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtHI8zEiYjDKM4Y0n1dEzB5SaaQjotwDpGDbW63VJ9IKLOCmrbNidjMc/GBXbcWjXcLUPAwg==
X-Received: by 2002:a17:902:ce8d:b0:27e:dc53:d239 with SMTP id d9443c01a7336-290caf84628mr52930715ad.35.1760723567190;
        Fri, 17 Oct 2025 10:52:47 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdce3sm981955ad.90.2025.10.17.10.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 10:52:46 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1b510c7e-6d48-4f3c-b3cb-8a7a0834784c@redhat.com>
Date: Fri, 17 Oct 2025 13:52:45 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] sched/deadline: Walk up cpuset hierarchy to decide root
 domain when hot-unplug
To: Pingfan Liu <piliu@redhat.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20251017122636.17671-1-piliu@redhat.com>
Content-Language: en-US
In-Reply-To: <20251017122636.17671-1-piliu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/17/25 8:26 AM, Pingfan Liu wrote:
> When testing kexec-reboot on a 144 cpus machine with
> isolcpus=managed_irq,domain,1-71,73-143 in kernel command line, I
> encounter the following bug:
>
> [   97.114759] psci: CPU142 killed (polled 0 ms)
> [   97.333236] Failed to offline CPU143 - error=-16
> [   97.333246] ------------[ cut here ]------------
> [   97.342682] kernel BUG at kernel/cpu.c:1569!
> [   97.347049] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
> [   97.353281] Modules linked in: rfkill sunrpc dax_hmem cxl_acpi cxl_port cxl_core einj vfat fat arm_smmuv3_pmu nvidia_cspmu arm_spe_pmu coresight_trbe arm_cspmu_module rndis_host ipmi_ssif cdc_ether i2c_smbus spi_nor usbnet ast coresight_tmc mii ixgbe i2c_algo_bit mdio mtd coresight_funnel coresight_stm stm_core coresight_etm4x coresight cppc_cpufreq loop fuse nfnetlink xfs crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce sbsa_gwdt nvme nvme_core nvme_auth i2c_tegra acpi_power_meter acpi_ipmi ipmi_devintf ipmi_msghandler dm_mirror dm_region_hash dm_log dm_mod
> [   97.404119] CPU: 0 UID: 0 PID: 2583 Comm: kexec Kdump: loaded Not tainted 6.12.0-41.el10.aarch64 #1
> [   97.413371] Hardware name: Supermicro MBD-G1SMH/G1SMH, BIOS 2.0 07/12/2024
> [   97.420400] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> [   97.427518] pc : smp_shutdown_nonboot_cpus+0x104/0x128
> [   97.432778] lr : smp_shutdown_nonboot_cpus+0x11c/0x128
> [   97.438028] sp : ffff800097c6b9a0
> [   97.441411] x29: ffff800097c6b9a0 x28: ffff0000a099d800 x27: 0000000000000000
> [   97.448708] x26: 0000000000000000 x25: 0000000000000000 x24: ffffb94aaaa8f218
> [   97.456004] x23: ffffb94aaaabaae0 x22: ffffb94aaaa8f018 x21: 0000000000000000
> [   97.463301] x20: ffffb94aaaa8fc10 x19: 000000000000008f x18: 00000000fffffffe
> [   97.470598] x17: 0000000000000000 x16: ffffb94aa958fcd0 x15: ffff103acfca0b64
> [   97.477894] x14: ffff800097c6b520 x13: 36312d3d726f7272 x12: ffff103acfc6ffa8
> [   97.485191] x11: ffff103acf6f0000 x10: ffff103bc085c400 x9 : ffffb94aa88a0eb0
> [   97.492488] x8 : 0000000000000001 x7 : 000000000017ffe8 x6 : c0000000fffeffff
> [   97.499784] x5 : ffff003bdf62b408 x4 : 0000000000000000 x3 : 0000000000000000
> [   97.507081] x2 : 0000000000000000 x1 : ffff0000a099d800 x0 : 0000000000000002
> [   97.514379] Call trace:
> [   97.516874]  smp_shutdown_nonboot_cpus+0x104/0x128
> [   97.521769]  machine_shutdown+0x20/0x38
> [   97.525693]  kernel_kexec+0xc4/0xf0
> [   97.529260]  __do_sys_reboot+0x24c/0x278
> [   97.533272]  __arm64_sys_reboot+0x2c/0x40
> [   97.537370]  invoke_syscall.constprop.0+0x74/0xd0
> [   97.542179]  do_el0_svc+0xb0/0xe8
> [   97.545562]  el0_svc+0x44/0x1d0
> [   97.548772]  el0t_64_sync_handler+0x120/0x130
> [   97.553222]  el0t_64_sync+0x1a4/0x1a8
> [   97.556963] Code: a94363f7 a8c47bfd d50323bf d65f03c0 (d4210000)
> [   97.563191] ---[ end trace 0000000000000000 ]---
> [   97.595854] Kernel panic - not syncing: Oops - BUG: Fatal exception
> [   97.602275] Kernel Offset: 0x394a28600000 from 0xffff800080000000
> [   97.608502] PHYS_OFFSET: 0x80000000
> [   97.612062] CPU features: 0x10,0000000d,002a6928,5667fea7
> [   97.617580] Memory Limit: none
> [   97.648626] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]
>
> Tracking down this issue, I found that dl_bw_deactivate() returned
> -EBUSY, which caused sched_cpu_deactivate() to fail on the last CPU.
> When a CPU is inactive, its rd is set to def_root_domain. For an
> blocked-state deadline task (in this case, "cppc_fie"), it was not
> migrated to CPU0, and its task_rq() information is stale. As a result,
> its bandwidth is wrongly accounted into def_root_domain during domain
> rebuild.

First of all, in an emergency situation when we need to shutdown the 
kernel, does it really matter if dl_bw_activate() returns -EBUSY? Should 
we just go ahead and ignore this dl_bw generated error?


> The key point is that root_domain is only tracked through active rq->rd.
> To avoid using a global data structure to track all root_domains in the
> system, we need a way to locate an active CPU within the corresponding
> root_domain.
>
> The following rules stand for deadline sub-system and help locating the
> active cpu
>    -1.any cpu belongs to a unique root domain at a given time
>    -2.DL bandwidth checker ensures that the root domain has active cpus.
>
> Now, let's examine the blocked-state task P.
> If P is attached to a cpuset that is a partition root, it is
> straightforward to find an active CPU.
> If P is attached to a cpuset that has changed from 'root' to 'member',
> the active CPUs are grouped into the parent root domain. Naturally, the
> CPUs' capacity and reserved DL bandwidth are taken into account in the
> ancestor root domain. (In practice, it may be unsafe to attach P to an
> arbitrary root domain, since that domain may lack sufficient DL
> bandwidth for P.) Again, it is straightforward to find an active CPU in
> the ancestor root domain.
>
> This patch groups CPUs into isolated and housekeeping sets. For the
> housekeeping group, it walks up the cpuset hierarchy to find active CPUs
> in P's root domain and retrieves the valid rd from cpu_rq(cpu)->rd.
>
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: "Michal Koutný" <mkoutny@suse.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Pierre Gondois <pierre.gondois@arm.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> To: cgroups@vger.kernel.org
> To: linux-kernel@vger.kernel.org
> ---
>   include/linux/cpuset.h  | 18 ++++++++++++++++++
>   kernel/cgroup/cpuset.c  | 27 +++++++++++++++++++++++++++
>   kernel/sched/deadline.c | 30 ++++++++++++++++++++++++------
>   3 files changed, 69 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 2ddb256187b51..7c00ebcdf85d9 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -130,6 +130,7 @@ extern void rebuild_sched_domains(void);
>   
>   extern void cpuset_print_current_mems_allowed(void);
>   extern void cpuset_reset_sched_domains(void);
> +extern void task_get_rd_effective_cpus(struct task_struct *p, struct cpumask *cpus);
>   
>   /*
>    * read_mems_allowed_begin is required when making decisions involving
> @@ -276,6 +277,23 @@ static inline void cpuset_reset_sched_domains(void)
>   	partition_sched_domains(1, NULL, NULL);
>   }
>   
> +static inline void task_get_rd_effective_cpus(struct task_struct *p,
> +		struct cpumask *cpus)
> +{
> +	const struct cpumask *hk_msk;
> +	struct cpumask msk;
> +
> +	hk_msk = housekeeping_cpumask(HK_TYPE_DOMAIN);
> +	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
> +		if (!cpumask_and(&msk, p->cpus_ptr, hk_msk)) {
> +			/* isolated cpus belong to a root domain */
> +			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
> +			return;
> +		}
> +	}
> +	cpumask_and(cpus, cpu_active_mask, hk_msk);
> +}

The size of struct cpumask can be large depending on the extra value of 
NR_CPUS. For a x86-64 RHEL kernel, it is over 1 kbytes. We can actually 
eliminate the use of a struct cpumask variable by replacing 
cpumask_and() with cpumask_intersects().

You said that isolated CPUs belong to a root domain. In the case of CPUs 
within an isolated partition, the CPUs are in a null root domain which I 
don't know if it is problematic or not.

We usually prefix an externally visible function from cpuset with the 
cpuset prefix to avoid namespace collision. You should consider doing 
that for this function.

Also I am still not very clear about the exact purpose of this function. 
You should probably add comment about this.

> +
>   static inline void cpuset_print_current_mems_allowed(void)
>   {
>   }
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 27adb04df675d..f7b18892ed093 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1102,6 +1102,33 @@ void cpuset_reset_sched_domains(void)
>   	mutex_unlock(&cpuset_mutex);
>   }
>   
> +/* caller hold RCU read lock */
> +void task_get_rd_effective_cpus(struct task_struct *p, struct cpumask *cpus)
> +{
> +	const struct cpumask *hk_msk;
> +	struct cpumask msk;
> +	struct cpuset *cs;
> +
> +	hk_msk = housekeeping_cpumask(HK_TYPE_DOMAIN);
> +	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
> +		if (!cpumask_and(&msk, p->cpus_ptr, hk_msk)) {
> +			/* isolated cpus belong to a root domain */
> +			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
> +			return;
> +		}
> +	}
> +	/* In HK_TYPE_DOMAIN, cpuset can be applied */
> +	cs = task_cs(p);
> +	while (cs != &top_cpuset) {
> +		if (is_sched_load_balance(cs))
> +			break;
> +		cs = parent_cs(cs);
> +	}
> +
> +	/* For top_cpuset, its effective_cpus does not exclude isolated cpu */
> +	cpumask_and(cpus, cs->effective_cpus, hk_msk);
> +}
> +

Similar problems with the non-CONFIG_CPUSETS version in cpuset.h.

Cheers,
Longman


