Return-Path: <cgroups+bounces-10897-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB01BF2162
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 17:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C27918C03BE
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 15:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD4A259C9C;
	Mon, 20 Oct 2025 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sa/dQgAZ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E640824168D
	for <cgroups@vger.kernel.org>; Mon, 20 Oct 2025 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973921; cv=none; b=fID+66sDzRmOs872M2HhdGdvgLp0722GxwQ9A5L763Mer9Rg5TZElsFJRFjp8IIdi6kcylp54uJrg2d640J9cnjOfokmmYGxyZNhhEr/6TzcSK4cUv1jTuBK6Nq0imJLmkUEE4JS9ilgoV3UfUkNL+yfSlT4uu6WOORxTA635hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973921; c=relaxed/simple;
	bh=pLUYdX14TVkK6qp6cwL+4fkblkG6szYqABLa3e8K5UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1gHwj7ok9TUf7qRjSGz90a1sNzJKm9CS3Dz8GrkKqnvHbXoyfzMezsoqMEhnlEtayacHMpDQXyrPY7ugl+9IyUTt61qrAp/WRdvrtxqiyzf56OIuSAz8XY7EI3E4+/JZTXvhE99azEGbDZbkfs3KddavObz5Z0pcZQOBNA3Xto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sa/dQgAZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760973918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wkx0venH/0+M/xvXo8nDdRC/w2dO56wGC/PsCNs51oM=;
	b=Sa/dQgAZBf8B3ndcGGOoYbXEsTRreJJbX0X20y2eE18/RZQ6fYNIXTw9DiA68FuqhFjDhG
	MKtX/KffaQMMKPgsthi6cEiwQm1ePX6+q+KSUZWt891Y5nz5xyl/Lx1FqpKQLBsV3V+VLW
	5FgNfe7eRfYlz+TQlQEoIA4hWox3jhk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-oxxizNi3NDK0NBIwmOhAqw-1; Mon, 20 Oct 2025 11:25:17 -0400
X-MC-Unique: oxxizNi3NDK0NBIwmOhAqw-1
X-Mimecast-MFC-AGG-ID: oxxizNi3NDK0NBIwmOhAqw_1760973916
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4278c82dce6so1615413f8f.3
        for <cgroups@vger.kernel.org>; Mon, 20 Oct 2025 08:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760973916; x=1761578716;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wkx0venH/0+M/xvXo8nDdRC/w2dO56wGC/PsCNs51oM=;
        b=mb1Hz4Cz6W5svt8922PgtVDeY3WcNt2eUd+O//6zbLPhy66htPeNni7M6ZhCITHRMQ
         QfAN36llWPMwRvqTY5pKBaqxQ/2j0gSN5qf0lcHf9CAwndRDEoNO1+d9oCdZ8/R/T29i
         bIteqJNyJsuHlHFyTlSWR4HVef2WHWy9Z/yR+sBDGHelPg+JQ88riqEUwpxneN0QVEmQ
         Icpy+gy6B6jK1ZzMlLhPZeID4iRanEMmjVGgKirKOrdLbYjdDLhVW4sMITd/XwpM7sRK
         appQxkAi2czdqok3xiMfG9bEuEsX/fhEVnlJCXJwPt/+7JheY6GAntEFsLbrZkuRszCD
         SZJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+vFiC0FP8py6tyTjsvW869DimZU4FstDPqafvVVzXa9M0r+Ob/9G3M1QkCmqD1Plub0movO+Y@vger.kernel.org
X-Gm-Message-State: AOJu0YyJPsttEwCAXO2yUu3WZnmDCpH5kLNQDTBWHuMOVusXIKaFXYwA
	3L2U9tRKXbdaJLLTLyja+Ywy2OPPbAY+8VFpSmZW4AH6eevTOLZ9dj3pikgX4+M0MkREG0Bnnv7
	UegXHv2h18/94Y1nCvMX8Kcj1M4oRLyUzgralhyl8YtkUW0+G7e5jjkJ/DIY=
X-Gm-Gg: ASbGnct4qbuoHjZike6uxA06AlIIO5VApSgSNMpLhWgua0cOYloReT7or8y+QbK3pdE
	SL5XWMlBj0MwpTG39dx9jJc2dj0ZGWyMncjdxczsijGkB/0jM8C1ObTxjNjU4qJMjG8aMZKM2bH
	VtFIipBCPfIevGFwDpXy4XT/IYxQFEtTW98zpeJ3Fv5SLGf9LY1u8vBqlyo8kY7O+RJWQEmjjtM
	P8LdX/YgoynIAq4wILELPopOAYoRJCz321UYZ49mvU/KRYXDbro+DHOJnbC3VBe0p+fneVKQ1Be
	dVLcUkxZGZDjFg6bVkgoeKZ6Pxeyy5pHGFgQykpNQt8TNtCiw2NbL/fkKXVnxk0qnyEdD3nQn4u
	I0Fqx9oON5jk+DWxt9DCx95CMEq+Nng==
X-Received: by 2002:a5d:5888:0:b0:3ec:2ef7:2134 with SMTP id ffacd0b85a97d-42704d54b25mr7392898f8f.18.1760973916021;
        Mon, 20 Oct 2025 08:25:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrkTZGUki80kEN99jETTEj3LLhJMJRJ9BpumnjK7nGd3eAKd3aSn5VDqKvZVyT72bPGbS1Hg==
X-Received: by 2002:a5d:5888:0:b0:3ec:2ef7:2134 with SMTP id ffacd0b85a97d-42704d54b25mr7392867f8f.18.1760973915513;
        Mon, 20 Oct 2025 08:25:15 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.131.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a96asm15884540f8f.31.2025.10.20.08.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 08:25:14 -0700 (PDT)
Date: Mon, 20 Oct 2025 17:25:12 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCHv3] sched/deadline: Walk up cpuset hierarchy to decide
 root domain when hot-unplug
Message-ID: <aPZUWF_bhli1CEcn@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017122636.17671-1-piliu@redhat.com>
 <1b510c7e-6d48-4f3c-b3cb-8a7a0834784c@redhat.com>
 <aPWqsui-7HCUB5g-@fedora>
 <aPXQra4TWR0NVwDQ@jlelli-thinkpadt14gen4.remote.csb>
 <aPY6VeMfcu_iddY4@fedora>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPY6VeMfcu_iddY4@fedora>

On 20/10/25 21:34, Pingfan Liu wrote:
> Hi Juri,
> 
> Thanks for following up on this topic. Please check my comment below.
> 
> On Mon, Oct 20, 2025 at 08:03:25AM +0200, Juri Lelli wrote:
> > Hi!
> > 
> > On 20/10/25 11:21, Pingfan Liu wrote:
> > > Hi Waiman,
> > > 
> > > I appreciate your time in reviewing my patch. Please see the comment
> > > belows.
> > > 
> > > On Fri, Oct 17, 2025 at 01:52:45PM -0400, Waiman Long wrote:
> > > > On 10/17/25 8:26 AM, Pingfan Liu wrote:
> > > > > When testing kexec-reboot on a 144 cpus machine with
> > > > > isolcpus=managed_irq,domain,1-71,73-143 in kernel command line, I
> > > > > encounter the following bug:
> > > > > 
> > > > > [   97.114759] psci: CPU142 killed (polled 0 ms)
> > > > > [   97.333236] Failed to offline CPU143 - error=-16
> > > > > [   97.333246] ------------[ cut here ]------------
> > > > > [   97.342682] kernel BUG at kernel/cpu.c:1569!
> > > > > [   97.347049] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
> > > > > [   97.353281] Modules linked in: rfkill sunrpc dax_hmem cxl_acpi cxl_port cxl_core einj vfat fat arm_smmuv3_pmu nvidia_cspmu arm_spe_pmu coresight_trbe arm_cspmu_module rndis_host ipmi_ssif cdc_ether i2c_smbus spi_nor usbnet ast coresight_tmc mii ixgbe i2c_algo_bit mdio mtd coresight_funnel coresight_stm stm_core coresight_etm4x coresight cppc_cpufreq loop fuse nfnetlink xfs crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce sbsa_gwdt nvme nvme_core nvme_auth i2c_tegra acpi_power_meter acpi_ipmi ipmi_devintf ipmi_msghandler dm_mirror dm_region_hash dm_log dm_mod
> > > > > [   97.404119] CPU: 0 UID: 0 PID: 2583 Comm: kexec Kdump: loaded Not tainted 6.12.0-41.el10.aarch64 #1
> > > > > [   97.413371] Hardware name: Supermicro MBD-G1SMH/G1SMH, BIOS 2.0 07/12/2024
> > > > > [   97.420400] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> > > > > [   97.427518] pc : smp_shutdown_nonboot_cpus+0x104/0x128
> > > > > [   97.432778] lr : smp_shutdown_nonboot_cpus+0x11c/0x128
> > > > > [   97.438028] sp : ffff800097c6b9a0
> > > > > [   97.441411] x29: ffff800097c6b9a0 x28: ffff0000a099d800 x27: 0000000000000000
> > > > > [   97.448708] x26: 0000000000000000 x25: 0000000000000000 x24: ffffb94aaaa8f218
> > > > > [   97.456004] x23: ffffb94aaaabaae0 x22: ffffb94aaaa8f018 x21: 0000000000000000
> > > > > [   97.463301] x20: ffffb94aaaa8fc10 x19: 000000000000008f x18: 00000000fffffffe
> > > > > [   97.470598] x17: 0000000000000000 x16: ffffb94aa958fcd0 x15: ffff103acfca0b64
> > > > > [   97.477894] x14: ffff800097c6b520 x13: 36312d3d726f7272 x12: ffff103acfc6ffa8
> > > > > [   97.485191] x11: ffff103acf6f0000 x10: ffff103bc085c400 x9 : ffffb94aa88a0eb0
> > > > > [   97.492488] x8 : 0000000000000001 x7 : 000000000017ffe8 x6 : c0000000fffeffff
> > > > > [   97.499784] x5 : ffff003bdf62b408 x4 : 0000000000000000 x3 : 0000000000000000
> > > > > [   97.507081] x2 : 0000000000000000 x1 : ffff0000a099d800 x0 : 0000000000000002
> > > > > [   97.514379] Call trace:
> > > > > [   97.516874]  smp_shutdown_nonboot_cpus+0x104/0x128
> > > > > [   97.521769]  machine_shutdown+0x20/0x38
> > > > > [   97.525693]  kernel_kexec+0xc4/0xf0
> > > > > [   97.529260]  __do_sys_reboot+0x24c/0x278
> > > > > [   97.533272]  __arm64_sys_reboot+0x2c/0x40
> > > > > [   97.537370]  invoke_syscall.constprop.0+0x74/0xd0
> > > > > [   97.542179]  do_el0_svc+0xb0/0xe8
> > > > > [   97.545562]  el0_svc+0x44/0x1d0
> > > > > [   97.548772]  el0t_64_sync_handler+0x120/0x130
> > > > > [   97.553222]  el0t_64_sync+0x1a4/0x1a8
> > > > > [   97.556963] Code: a94363f7 a8c47bfd d50323bf d65f03c0 (d4210000)
> > > > > [   97.563191] ---[ end trace 0000000000000000 ]---
> > > > > [   97.595854] Kernel panic - not syncing: Oops - BUG: Fatal exception
> > > > > [   97.602275] Kernel Offset: 0x394a28600000 from 0xffff800080000000
> > > > > [   97.608502] PHYS_OFFSET: 0x80000000
> > > > > [   97.612062] CPU features: 0x10,0000000d,002a6928,5667fea7
> > > > > [   97.617580] Memory Limit: none
> > > > > [   97.648626] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]
> > > > > 
> > > > > Tracking down this issue, I found that dl_bw_deactivate() returned
> > > > > -EBUSY, which caused sched_cpu_deactivate() to fail on the last CPU.
> > > > > When a CPU is inactive, its rd is set to def_root_domain. For an
> > > > > blocked-state deadline task (in this case, "cppc_fie"), it was not
> > > > > migrated to CPU0, and its task_rq() information is stale. As a result,
> > > > > its bandwidth is wrongly accounted into def_root_domain during domain
> > > > > rebuild.
> > > > 
> > > > First of all, in an emergency situation when we need to shutdown the kernel,
> > > > does it really matter if dl_bw_activate() returns -EBUSY? Should we just go
> > > > ahead and ignore this dl_bw generated error?
> > > > 
> > > 
> > > Ah, sorry - the previous test example was misleading. Let me restate it
> > > as an equivalent operation on a system with 144 CPUs:
> > >   sudo bash -c 'taskset -cp 0 $$ && for i in {1..143}; do echo 0 > /sys/devices/system/cpu/cpu$i/online 2>/dev/null; done'
> > > 
> > > That extracts the hot-removal part, which is affected by the bug, from
> > > the kexec reboot process. It expects that only cpu0 is online, but in
> > > practice, the cpu143 refused to be offline due to this bug.
> > 
> > I confess I am still perplexed by this, considering the "particular"
> > nature of cppc worker that seems to be the only task that is able to
> > trigger this problem. First of all, is that indeed the case or are you
> > able to reproduce this problem with standard (non-kthread) DEADLINE
> > tasks as well?
> > 
> 
> Yes, I can. I wrote a SCHED_DEADLINE task that waits indefinitely on a
> semaphore (or, more precisely, for a very long period that may span the
> entire CPU hot-removal process) to emulate waiting for an undetermined
> driver input.  Then I spawned multiple instances of this program to
> ensure that some of them run on CPU 72. When I attempted to offline CPUs
> 1–143 one by one, CPU 143 failed to go offline.
> 
> > I essentially wonder how cppc worker affinity/migration on hotplug is
> > handled. With your isolcpus configuration you have one isolated root
> 
> The affinity/migration on hotplug work fine. The keypoint is that they
> only handle the task on rq. For the blocked-state tasks (here it is cppc
> worker), they just ignore them.

OK. Thanks for confirming/clarifying.


