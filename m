Return-Path: <cgroups+bounces-4178-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2051194C854
	for <lists+cgroups@lfdr.de>; Fri,  9 Aug 2024 03:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8184FB24F96
	for <lists+cgroups@lfdr.de>; Fri,  9 Aug 2024 01:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A40E101E6;
	Fri,  9 Aug 2024 01:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iX30sLre"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A4E171A7
	for <cgroups@vger.kernel.org>; Fri,  9 Aug 2024 01:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723168709; cv=none; b=CpXnOUYNiFBVWe+ZgEe0Sr4on/B2LPlkvbBjBcHTGRUNGuYd6qVfTGP3qjTQHsOLhoDqjH/LLYIZhHJXiG6S5JUuLp07lmWw4OkHoyVcJUgehoaeT7bjFq7OQklyLbn4uVaGh4H54BlatkIXQhAGMaXzdXCxXk/TzDVv7moemLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723168709; c=relaxed/simple;
	bh=RspK3XZzMUhwknlpSTBg7OaZnX2vuN9kVlXwGFNN9/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eAi/xwv1FK7Js7BhnvNMrOgKqrXiAYoZrok2xihtlRHOLwAt514kJp8oikRfN7Jg+jS4isir5hvrdaMd07eFDieC/1PAQ0nVTA2PZzudWdsTdnNsdFiIPlPt/kEVwoxkYT8diwpaLJOlkJEJlw3WE0LpTjj1tctdMpCorT7StG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iX30sLre; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723168706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=giEu1Qn7M0QZXZ5C+0wQv4Oi3oeQrQkmndSePzwHTTY=;
	b=iX30sLreImba9aYU6hAr4izR5AwCdeHi37cYNZUKnDioCLG6UlIdYndkIO4h4Tt/GNHK9N
	R/LP1jqyr4AdALmnTRi6REdk9UQWnrRnBtZyUCTSQFVCDfFm4ut56jdE4HvGgRctCyUHX4
	OZWNNZJplQZMzQvwWFuS7jh1WjV9Vxw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-G7QLOL6VPSqEn-uG7o2tsg-1; Thu,
 08 Aug 2024 21:58:22 -0400
X-MC-Unique: G7QLOL6VPSqEn-uG7o2tsg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A039F1945CAA;
	Fri,  9 Aug 2024 01:58:20 +0000 (UTC)
Received: from [10.2.16.232] (unknown [10.2.16.232])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 06EB31956056;
	Fri,  9 Aug 2024 01:58:17 +0000 (UTC)
Message-ID: <6f301773-2fce-4602-a391-8af7ef00b2fb@redhat.com>
Date: Thu, 8 Aug 2024 21:58:17 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [cgroup] ab03125268:
 WARNING:at_kernel/cgroup/cgroup.c:#css_release_work_fn
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Linux Memory Management List <linux-mm@kvack.org>, Tejun Heo
 <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Kamalesh Babulal <kamalesh.babulal@oracle.com>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org
References: <202408090947.ec19afd3-oliver.sang@intel.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <202408090947.ec19afd3-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


On 8/8/24 21:36, kernel test robot wrote:
>
> Hello,
>
> kernel test robot noticed "WARNING:at_kernel/cgroup/cgroup.c:#css_release_work_fn" on:
>
> commit: ab03125268679e058e1e7b6612f6d12610761769 ("cgroup: Show # of subsystem CSSes in cgroup.stat")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> [test failed on linux-next/master 222a3380f92b8791d4eeedf7cd750513ff428adf]
>
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-977d51cf-1_20240508
> with following parameters:
>
> 	group: cgroup
>
>
>
> compiler: gcc-12
> test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake) with 32G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202408090947.ec19afd3-oliver.sang@intel.com
>
>
> [  329.344633][   T27] ------------[ cut here ]------------
> [ 329.352806][ T27] WARNING: CPU: 1 PID: 27 at kernel/cgroup/cgroup.c:5468 css_release_work_fn (kernel/cgroup/cgroup.c:5468)

It is the following WARN_ON_ONCE() being triggered.

5467                 cgrp->nr_dying_subsys[ss->id]--;
5468                 WARN_ON_ONCE(css->nr_descendants || 
cgrp->nr_dying_subsys[ss->id]);
5469                 parent_cgrp = cgroup_parent(cgrp);

css->nr_descendants should be 0, but there is a possibility that 
cgrp->nr_dying_subsys[ss->id] may not be 0 if a subsystem is activated 
and deactivated multiple times. I will post a patch to remove that.

Cheers,
Longman

> [  329.364374][   T27] Modules linked in: openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 psample btrfs blake2b_generic xor zstd_compress raid6_pq libcrc32c intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp sd_mod kvm_intel sg kvm crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 rapl ast ahci intel_wmi_thunderbolt wmi_bmof libahci video drm_shmem_helper intel_cstate ppdev drm_kms_helper mei_me intel_ish_ipc i2c_i801 i2c_designware_platform intel_uncore parport_pc libata i2c_designware_core idma64 i2c_smbus mei acpi_power_meter intel_ishtp intel_pch_thermal ie31200_edac parport acpi_ipmi wmi ipmi_devintf pinctrl_cannonlake ipmi_msghandler acpi_tad acpi_pad binfmt_misc loop fuse drm dm_mod ip_tables sch_fq_codel
> [  329.438923][   T27] CPU: 1 UID: 0 PID: 27 Comm: kworker/1:0 Not tainted 6.11.0-rc1-00007-gab0312526867 #1
> [  329.449669][   T27] Hardware name: Intel Corporation Mehlow UP Server Platform/Moss Beach Server, BIOS CNLSE2R1.R00.X188.B13.1903250419 03/25/2019
> [  329.464003][   T27] Workqueue: cgroup_destroy css_release_work_fn
> [ 329.471393][ T27] RIP: 0010:css_release_work_fn (kernel/cgroup/cgroup.c:5468)
> [ 329.478404][ T27] Code: 00 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 84 c0 74 08 3c 03 0f 8e 73 04 00 00 8b 8d b0 00 00 00 85 c9 0f 84 b2 01 00 00 <0f> 0b 49 8d bc 24 10 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89
> All code
> ========
>     0:	00 00                	add    %al,(%rax)
>     2:	fc                   	cld
>     3:	ff                   	(bad)
>     4:	df 48 89             	fisttps -0x77(%rax)
>     7:	fa                   	cli
>     8:	48 c1 ea 03          	shr    $0x3,%rdx
>     c:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
>    10:	84 c0                	test   %al,%al
>    12:	74 08                	je     0x1c
>    14:	3c 03                	cmp    $0x3,%al
>    16:	0f 8e 73 04 00 00    	jle    0x48f
>    1c:	8b 8d b0 00 00 00    	mov    0xb0(%rbp),%ecx
>    22:	85 c9                	test   %ecx,%ecx
>    24:	0f 84 b2 01 00 00    	je     0x1dc
>    2a:*	0f 0b                	ud2    		<-- trapping instruction
>    2c:	49 8d bc 24 10 01 00 	lea    0x110(%r12),%rdi
>    33:	00
>    34:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>    3b:	fc ff df
>    3e:	48                   	rex.W
>    3f:	89                   	.byte 0x89
>
> Code starting with the faulting instruction
> ===========================================
>     0:	0f 0b                	ud2
>     2:	49 8d bc 24 10 01 00 	lea    0x110(%r12),%rdi
>     9:	00
>     a:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>    11:	fc ff df
>    14:	48                   	rex.W
>    15:	89                   	.byte 0x89
> [  329.499252][   T27] RSP: 0018:ffffc90000337c90 EFLAGS: 00010202
> [  329.506527][   T27] RAX: 0000000000000003 RBX: 0000000000000000 RCX: 0000000000000000
> [  329.515801][   T27] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff88886dde0288
> [  329.525032][   T27] RBP: ffff88885d2ee068 R08: ffffffff85688cbc R09: fffffbfff0f10188
> [  329.534328][   T27] R10: ffffffff87880c47 R11: 0000000000000040 R12: ffff88886dde0000
> [  329.543601][   T27] R13: 000000000000001b R14: ffffffff85688c20 R15: ffff888118c08020
> [  329.552847][   T27] FS:  0000000000000000(0000) GS:ffff8887e3680000(0000) knlGS:0000000000000000
> [  329.563170][   T27] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  329.571124][   T27] CR2: 000055f6ec637108 CR3: 000000087927e002 CR4: 00000000003706f0
> [  329.580442][   T27] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  329.589740][   T27] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  329.599048][   T27] Call Trace:
> [  329.603695][   T27]  <TASK>
> [ 329.607990][ T27] ? __warn (kernel/panic.c:735)
> [ 329.613444][ T27] ? css_release_work_fn (kernel/cgroup/cgroup.c:5468)
> [ 329.620132][ T27] ? report_bug (lib/bug.c:180 lib/bug.c:219)
> [ 329.625961][ T27] ? handle_bug (arch/x86/kernel/traps.c:239)
> [ 329.631620][ T27] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1))
> [ 329.637638][ T27] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621)
> [ 329.644006][ T27] ? css_release_work_fn (kernel/cgroup/cgroup.c:5468)
> [ 329.650668][ T27] process_one_work (kernel/workqueue.c:3231)
> [ 329.656971][ T27] ? __pfx_lock_acquire (kernel/locking/lockdep.c:5727)
> [ 329.663388][ T27] ? __pfx_process_one_work (kernel/workqueue.c:3133)
> [ 329.670157][ T27] ? assign_work (kernel/workqueue.c:1202)
> [ 329.676137][ T27] ? lock_is_held_type (kernel/locking/lockdep.c:5500 kernel/locking/lockdep.c:5831)
> [ 329.682560][ T27] worker_thread (kernel/workqueue.c:3306 kernel/workqueue.c:3390)
> [ 329.688584][ T27] ? __pfx_worker_thread (kernel/workqueue.c:3339)
> [ 329.695127][ T27] kthread (kernel/kthread.c:389)
> [ 329.700585][ T27] ? __pfx_kthread (kernel/kthread.c:342)
> [ 329.706591][ T27] ret_from_fork (arch/x86/kernel/process.c:147)
> [ 329.712434][ T27] ? __pfx_kthread (kernel/kthread.c:342)
> [ 329.718451][ T27] ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
> [  329.724624][   T27]  </TASK>
> [  329.729125][   T27] irq event stamp: 179927
> [ 329.734853][ T27] hardirqs last enabled at (179941): console_unlock (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:97 arch/x86/include/asm/irqflags.h:155 kernel/printk/printk.c:341 kernel/printk/printk.c:2801 kernel/printk/printk.c:3120)
> [ 329.745845][ T27] hardirqs last disabled at (179954): console_unlock (kernel/printk/printk.c:339 kernel/printk/printk.c:2801 kernel/printk/printk.c:3120)
> [ 329.756837][ T27] softirqs last enabled at (179968): handle_softirqs (arch/x86/include/asm/preempt.h:26 kernel/softirq.c:401 kernel/softirq.c:582)
> [ 329.767923][ T27] softirqs last disabled at (179963): __irq_exit_rcu (kernel/softirq.c:589 kernel/softirq.c:428 kernel/softirq.c:637)
> [  329.778925][   T27] ---[ end trace 0000000000000000 ]---
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240809/202408090947.ec19afd3-oliver.sang@intel.com
>
>
>


