Return-Path: <cgroups+bounces-10891-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 23050BEF2E8
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 05:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9CD04343C80
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 03:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB6C29BD90;
	Mon, 20 Oct 2025 03:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQzaY5yq"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BED281504
	for <cgroups@vger.kernel.org>; Mon, 20 Oct 2025 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760930506; cv=none; b=Eo6PCo2D0vP4GMCpkntzCH8blKCc145u495sEuFK8FrezokqV09S3ncJaF/jp/yIm4fTgj8y41nmsdV0eJGw2VODAKwn2jWXAr2/1u9z17QrDS8WIj2WaZfx/J8c3YSMaiCEvESk6xHyiy1wE8zfM+vXPVirUAr/xgEsRi1VOhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760930506; c=relaxed/simple;
	bh=iAHbKOlodD1oxWd5bp7bH8X2p0ded5kYJMwBBjJ9nmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOy7uvOsTCGf8xbLlRMBTIFyFoCWXJQIulJTsiDALsUDXCHB29TGpr96NYTq2ywTyxebDFi8Iv04nxXSszI86ZqW5DWWJ2eCFcTva+UdOiDVhT9pjGLCFoa3b1nMjqTyrNY7YejPdX9/xAWl/sVQSbPGu7ZLl6s3Bc37JVMsTs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQzaY5yq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760930501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F0JKqsT+pVGb3yUUgF+L5kb6vD8xkT98BOWqh/DjwhU=;
	b=dQzaY5yqLiWMgyWZs20g/qIe2XXFQl2WgzSg8JkbSkbXxIbOLzDvfAI/2J51fLFNzpd29z
	OeqZq4gm59iagkZEWzObOmSYfExBusMYUA1/Tq9eSbrbb0yoT7JSX2FkMidovLbBeS/den
	hYVdq67xt6zyVwkh9B67UWwB7Z6zpDY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-ld6iHKT8PCer6Wz2wzS7-w-1; Sun,
 19 Oct 2025 23:21:31 -0400
X-MC-Unique: ld6iHKT8PCer6Wz2wzS7-w-1
X-Mimecast-MFC-AGG-ID: ld6iHKT8PCer6Wz2wzS7-w_1760930489
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B159F18002C9;
	Mon, 20 Oct 2025 03:21:27 +0000 (UTC)
Received: from localhost (unknown [10.72.112.104])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 047E3300019F;
	Mon, 20 Oct 2025 03:21:24 +0000 (UTC)
Date: Mon, 20 Oct 2025 11:21:22 +0800
From: Pingfan Liu <piliu@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCHv3] sched/deadline: Walk up cpuset hierarchy to decide
 root domain when hot-unplug
Message-ID: <aPWqsui-7HCUB5g-@fedora>
References: <20251017122636.17671-1-piliu@redhat.com>
 <1b510c7e-6d48-4f3c-b3cb-8a7a0834784c@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b510c7e-6d48-4f3c-b3cb-8a7a0834784c@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Waiman,

I appreciate your time in reviewing my patch. Please see the comment
belows.

On Fri, Oct 17, 2025 at 01:52:45PM -0400, Waiman Long wrote:
> On 10/17/25 8:26 AM, Pingfan Liu wrote:
> > When testing kexec-reboot on a 144 cpus machine with
> > isolcpus=managed_irq,domain,1-71,73-143 in kernel command line, I
> > encounter the following bug:
> > 
> > [   97.114759] psci: CPU142 killed (polled 0 ms)
> > [   97.333236] Failed to offline CPU143 - error=-16
> > [   97.333246] ------------[ cut here ]------------
> > [   97.342682] kernel BUG at kernel/cpu.c:1569!
> > [   97.347049] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
> > [   97.353281] Modules linked in: rfkill sunrpc dax_hmem cxl_acpi cxl_port cxl_core einj vfat fat arm_smmuv3_pmu nvidia_cspmu arm_spe_pmu coresight_trbe arm_cspmu_module rndis_host ipmi_ssif cdc_ether i2c_smbus spi_nor usbnet ast coresight_tmc mii ixgbe i2c_algo_bit mdio mtd coresight_funnel coresight_stm stm_core coresight_etm4x coresight cppc_cpufreq loop fuse nfnetlink xfs crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce sbsa_gwdt nvme nvme_core nvme_auth i2c_tegra acpi_power_meter acpi_ipmi ipmi_devintf ipmi_msghandler dm_mirror dm_region_hash dm_log dm_mod
> > [   97.404119] CPU: 0 UID: 0 PID: 2583 Comm: kexec Kdump: loaded Not tainted 6.12.0-41.el10.aarch64 #1
> > [   97.413371] Hardware name: Supermicro MBD-G1SMH/G1SMH, BIOS 2.0 07/12/2024
> > [   97.420400] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> > [   97.427518] pc : smp_shutdown_nonboot_cpus+0x104/0x128
> > [   97.432778] lr : smp_shutdown_nonboot_cpus+0x11c/0x128
> > [   97.438028] sp : ffff800097c6b9a0
> > [   97.441411] x29: ffff800097c6b9a0 x28: ffff0000a099d800 x27: 0000000000000000
> > [   97.448708] x26: 0000000000000000 x25: 0000000000000000 x24: ffffb94aaaa8f218
> > [   97.456004] x23: ffffb94aaaabaae0 x22: ffffb94aaaa8f018 x21: 0000000000000000
> > [   97.463301] x20: ffffb94aaaa8fc10 x19: 000000000000008f x18: 00000000fffffffe
> > [   97.470598] x17: 0000000000000000 x16: ffffb94aa958fcd0 x15: ffff103acfca0b64
> > [   97.477894] x14: ffff800097c6b520 x13: 36312d3d726f7272 x12: ffff103acfc6ffa8
> > [   97.485191] x11: ffff103acf6f0000 x10: ffff103bc085c400 x9 : ffffb94aa88a0eb0
> > [   97.492488] x8 : 0000000000000001 x7 : 000000000017ffe8 x6 : c0000000fffeffff
> > [   97.499784] x5 : ffff003bdf62b408 x4 : 0000000000000000 x3 : 0000000000000000
> > [   97.507081] x2 : 0000000000000000 x1 : ffff0000a099d800 x0 : 0000000000000002
> > [   97.514379] Call trace:
> > [   97.516874]  smp_shutdown_nonboot_cpus+0x104/0x128
> > [   97.521769]  machine_shutdown+0x20/0x38
> > [   97.525693]  kernel_kexec+0xc4/0xf0
> > [   97.529260]  __do_sys_reboot+0x24c/0x278
> > [   97.533272]  __arm64_sys_reboot+0x2c/0x40
> > [   97.537370]  invoke_syscall.constprop.0+0x74/0xd0
> > [   97.542179]  do_el0_svc+0xb0/0xe8
> > [   97.545562]  el0_svc+0x44/0x1d0
> > [   97.548772]  el0t_64_sync_handler+0x120/0x130
> > [   97.553222]  el0t_64_sync+0x1a4/0x1a8
> > [   97.556963] Code: a94363f7 a8c47bfd d50323bf d65f03c0 (d4210000)
> > [   97.563191] ---[ end trace 0000000000000000 ]---
> > [   97.595854] Kernel panic - not syncing: Oops - BUG: Fatal exception
> > [   97.602275] Kernel Offset: 0x394a28600000 from 0xffff800080000000
> > [   97.608502] PHYS_OFFSET: 0x80000000
> > [   97.612062] CPU features: 0x10,0000000d,002a6928,5667fea7
> > [   97.617580] Memory Limit: none
> > [   97.648626] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]
> > 
> > Tracking down this issue, I found that dl_bw_deactivate() returned
> > -EBUSY, which caused sched_cpu_deactivate() to fail on the last CPU.
> > When a CPU is inactive, its rd is set to def_root_domain. For an
> > blocked-state deadline task (in this case, "cppc_fie"), it was not
> > migrated to CPU0, and its task_rq() information is stale. As a result,
> > its bandwidth is wrongly accounted into def_root_domain during domain
> > rebuild.
> 
> First of all, in an emergency situation when we need to shutdown the kernel,
> does it really matter if dl_bw_activate() returns -EBUSY? Should we just go
> ahead and ignore this dl_bw generated error?
> 

Ah, sorry - the previous test example was misleading. Let me restate it
as an equivalent operation on a system with 144 CPUs:
  sudo bash -c 'taskset -cp 0 $$ && for i in {1..143}; do echo 0 > /sys/devices/system/cpu/cpu$i/online 2>/dev/null; done'

That extracts the hot-removal part, which is affected by the bug, from
the kexec reboot process. It expects that only cpu0 is online, but in
practice, the cpu143 refused to be offline due to this bug.

As for the ignorance of dl_bw in the kexec process, I have a dedicated
draft for it. Later I will send it out and cc you.

> 
> > The key point is that root_domain is only tracked through active rq->rd.
> > To avoid using a global data structure to track all root_domains in the
> > system, we need a way to locate an active CPU within the corresponding
> > root_domain.
> > 
> > The following rules stand for deadline sub-system and help locating the
> > active cpu
> >    -1.any cpu belongs to a unique root domain at a given time
> >    -2.DL bandwidth checker ensures that the root domain has active cpus.
> > 
> > Now, let's examine the blocked-state task P.
> > If P is attached to a cpuset that is a partition root, it is
> > straightforward to find an active CPU.
> > If P is attached to a cpuset that has changed from 'root' to 'member',
> > the active CPUs are grouped into the parent root domain. Naturally, the
> > CPUs' capacity and reserved DL bandwidth are taken into account in the
> > ancestor root domain. (In practice, it may be unsafe to attach P to an
> > arbitrary root domain, since that domain may lack sufficient DL
> > bandwidth for P.) Again, it is straightforward to find an active CPU in
> > the ancestor root domain.
> > 
> > This patch groups CPUs into isolated and housekeeping sets. For the
> > housekeeping group, it walks up the cpuset hierarchy to find active CPUs
> > in P's root domain and retrieves the valid rd from cpu_rq(cpu)->rd.
> > 
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: "Michal Koutný" <mkoutny@suse.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Pierre Gondois <pierre.gondois@arm.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > To: cgroups@vger.kernel.org
> > To: linux-kernel@vger.kernel.org
> > ---
> >   include/linux/cpuset.h  | 18 ++++++++++++++++++
> >   kernel/cgroup/cpuset.c  | 27 +++++++++++++++++++++++++++
> >   kernel/sched/deadline.c | 30 ++++++++++++++++++++++++------
> >   3 files changed, 69 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> > index 2ddb256187b51..7c00ebcdf85d9 100644
> > --- a/include/linux/cpuset.h
> > +++ b/include/linux/cpuset.h
> > @@ -130,6 +130,7 @@ extern void rebuild_sched_domains(void);
> >   extern void cpuset_print_current_mems_allowed(void);
> >   extern void cpuset_reset_sched_domains(void);
> > +extern void task_get_rd_effective_cpus(struct task_struct *p, struct cpumask *cpus);
> >   /*
> >    * read_mems_allowed_begin is required when making decisions involving
> > @@ -276,6 +277,23 @@ static inline void cpuset_reset_sched_domains(void)
> >   	partition_sched_domains(1, NULL, NULL);
> >   }
> > +static inline void task_get_rd_effective_cpus(struct task_struct *p,
> > +		struct cpumask *cpus)
> > +{
> > +	const struct cpumask *hk_msk;
> > +	struct cpumask msk;
> > +
> > +	hk_msk = housekeeping_cpumask(HK_TYPE_DOMAIN);
> > +	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
> > +		if (!cpumask_and(&msk, p->cpus_ptr, hk_msk)) {
> > +			/* isolated cpus belong to a root domain */
> > +			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
> > +			return;
> > +		}
> > +	}
> > +	cpumask_and(cpus, cpu_active_mask, hk_msk);
> > +}
> 
> The size of struct cpumask can be large depending on the extra value of
> NR_CPUS. For a x86-64 RHEL kernel, it is over 1 kbytes. We can actually
> eliminate the use of a struct cpumask variable by replacing cpumask_and()
> with cpumask_intersects().
> 

OK.

> You said that isolated CPUs belong to a root domain. In the case of CPUs
> within an isolated partition, the CPUs are in a null root domain which I
> don't know if it is problematic or not.
> 

If I understand correctly, during CPU hot-removal, the following rules apply:

-1.Check whether the total dl_bw of all DL tasks in the affected root
domain can be satisfied by the remaining CPUs in the same root domain.
If it can, the hot-removal proceeds; otherwise, the hot-removal is rejected.

-2.During the CPU hot-removal process, migratable tasks on the dying CPU
are forcibly migrated to other CPUs in the same root domain, regardless
of their CPU affinity.

My patch does not violate these rules.

> We usually prefix an externally visible function from cpuset with the cpuset
> prefix to avoid namespace collision. You should consider doing that for this
> function.
> 

OK.

> Also I am still not very clear about the exact purpose of this function. You
> should probably add comment about this.
> 

> > +
> >   static inline void cpuset_print_current_mems_allowed(void)
> >   {
> >   }
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index 27adb04df675d..f7b18892ed093 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -1102,6 +1102,33 @@ void cpuset_reset_sched_domains(void)
> >   	mutex_unlock(&cpuset_mutex);
> >   }
> > +/* caller hold RCU read lock */
> > +void task_get_rd_effective_cpus(struct task_struct *p, struct cpumask *cpus)
> > +{
> > +	const struct cpumask *hk_msk;
> > +	struct cpumask msk;
> > +	struct cpuset *cs;
> > +
> > +	hk_msk = housekeeping_cpumask(HK_TYPE_DOMAIN);
> > +	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
> > +		if (!cpumask_and(&msk, p->cpus_ptr, hk_msk)) {
> > +			/* isolated cpus belong to a root domain */
> > +			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
> > +			return;
> > +		}
> > +	}
> > +	/* In HK_TYPE_DOMAIN, cpuset can be applied */
> > +	cs = task_cs(p);
> > +	while (cs != &top_cpuset) {
> > +		if (is_sched_load_balance(cs))
> > +			break;
> > +		cs = parent_cs(cs);
> > +	}
> > +
> > +	/* For top_cpuset, its effective_cpus does not exclude isolated cpu */
> > +	cpumask_and(cpus, cs->effective_cpus, hk_msk);
> > +}
> > +
> 
> Similar problems with the non-CONFIG_CPUSETS version in cpuset.h.
> 

OK, I will fix it.

Thanks,

Pingfan


