Return-Path: <cgroups+bounces-8353-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 541FEAC4BEA
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 12:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC30189D2E7
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 10:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF5D248F5D;
	Tue, 27 May 2025 10:04:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51241D63C0;
	Tue, 27 May 2025 10:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748340272; cv=none; b=skkuFz/X2EtCOFlvcvzs/hNtWRgp420mUYPC5tBeYhi5Bn7QYGIeWthwHdxJakv1GwFF1G/XSQSVBkHBsMN6DmEi3/GQ5DTb9VUfNNEKJbLlLM9Yh5JGOCq2jubp3X9nqtgSBL3D8kgJ/3ktm8JZZ/Ye00UbSrDj+UVpmI6I698=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748340272; c=relaxed/simple;
	bh=3LSkO5LxP4lyBs/sM3VzszK69ZpVwVLLQTHhqFlVz4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvMLdObL79cYwxIZIWvtFkSp4HOL6LuCoreHtb98PXguDLW7O7hKlG7eAOixLaZiqfhv56JKzkcV81ds991/tdsBW1R/9xN+PJRLYL1crixYquQkK3lWVPhHToJVW+eDMs/+goCXixDjd7AhDGLqNvBpQW3D9jRgPQ5zGJDmyWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6021b8b2c5fso6112964a12.2;
        Tue, 27 May 2025 03:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748340267; x=1748945067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFIfIK4ADX5O+SVrFsZMZF7P/e0zVh2UBTpMLSIjLOg=;
        b=uFIvQ6UBX1jT+PdmrrBBGNEpeBRNKGirAz6oFr6VFuomFyF50R9I4fa0GJsd3vq2yN
         wkVeHbq03FHjowrLMPGHkuxc1JC+jmXjQO3tY6uT9cisAt98DTfHx7Xp8GQv3G01wofy
         GZy0D5Qtrvka3+1Qo09hZvy6K0sGzyqcrGkoaD8pC1nbJ+wjgVb6grvVFAUK2CK7X7O5
         vRHEmALDv8K9lGkxIwTxpazUz69qRhMsTszRkNm0TwzqsmzJ0I+o1rHyEKQgCWT9Md+P
         YuyBJBX96HyVQVUnXdFaODujhhSodam6UzhHOWC9RtFUOGvzT/kzvF9eAMLPBA+vXNIb
         n9uA==
X-Forwarded-Encrypted: i=1; AJvYcCUZAyFi8VLWuvyBsFg5krvTxG1RIvI0Bq6XCsmSZ4qhXe46DZSzgw7NVQp5OJiNnLY9s9qzWwISvM+vCaPo@vger.kernel.org, AJvYcCV4ZqTG5pO2sJS/c7lIkGQqEvQ4XhUvCTsHI4Z+B/5w5ezjI1H364T+3wTkFoq32/vHgDlkPw6e@vger.kernel.org
X-Gm-Message-State: AOJu0YwN6J+E2MYYN2N/a1QzPzEKCGAXjTE8UMzkiUBYNKbz07Xrb8d1
	ISHp147cutddElMkjSQGVbIkDSiLqLCUT0D2JwXqs798BBNQfsuozFP6
X-Gm-Gg: ASbGncs9kxoxWMjeiuSumMjWwiAxWO8xPQRLHtdxoJrCHtcRSEnEny2Dua9dfek6uT5
	N/mZyjWdDaZcnnv4B+uS4f8uCngA6Q3A4lhZX5E4a0Q97jz+Kh7OoxOr5rQy5o5oDSZ7fOpg/gp
	FFwAjmu7STLQ1RTzKz8UrGdt1BjnGx5WwjRpFtQ5wqClkX2oBNP9w7BKVYwEzv0jOg77/5rpbiN
	Xl9qx4HhPRjMjoQzeKgzIgDkyWlciJfMZugXScA5H7oNsSGnAn9zqFp78kVFt9HYpkzGRIyYqK/
	NXKR/VrqXNGMyzKd6UMuZHlucrwWzRRPM6JPOtDRAbE=
X-Google-Smtp-Source: AGHT+IE2BWkUJ4uvhTni0eOx9zKK0hJ92IBH7mDXXjjatUyvvKCqhQPHMIQQV9Fk6+wWbr9kfJbJfw==
X-Received: by 2002:a17:907:3e13:b0:ad8:9257:5731 with SMTP id a640c23a62f3a-ad89257599dmr134142166b.16.1748340266716;
        Tue, 27 May 2025 03:04:26 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad88b1195e6sm107707066b.120.2025.05.27.03.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 03:04:26 -0700 (PDT)
Date: Tue, 27 May 2025 03:03:34 -0700
From: Breno Leitao <leitao@debian.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Ridong <chenridong@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Michael van der Westhuizen <rmikey@meta.com>,
	Usama Arif <usamaarif642@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] memcg: Always call cond_resched() after fn()
Message-ID: <aDWN9mP3wPQnwo4m@gmail.com>
References: <20250523-memcg_fix-v1-1-ad3eafb60477@debian.org>
 <ucarls72c6j7xzhdjsbb2wj5ovlzthatmh7kzwhepvudszap4h@xetgnupdm5ui>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ucarls72c6j7xzhdjsbb2wj5ovlzthatmh7kzwhepvudszap4h@xetgnupdm5ui>

Hello Shakeel,

On Fri, May 23, 2025 at 11:21:39AM -0700, Shakeel Butt wrote:
> On Fri, May 23, 2025 at 10:21:06AM -0700, Breno Leitao wrote:
> > I am seeing soft lockup on certain machine types when a cgroup
> > OOMs. This is happening because killing the process in certain machine
> > might be very slow, which causes the soft lockup and RCU stalls. This
> > happens usually when the cgroup has MANY processes and memory.oom.group
> > is set.
> > 
> > Example I am seeing in real production:
> > 
> >        [462012.244552] Memory cgroup out of memory: Killed process 3370438 (crosvm) ....
> >        ....
> >        [462037.318059] Memory cgroup out of memory: Killed process 4171372 (adb) ....
> >        [462037.348314] watchdog: BUG: soft lockup - CPU#64 stuck for 26s! [stat_manager-ag:1618982]
> >        ....
> > 
> 
> > Quick look at why this is so slow, it seems to be related to serial
> > flush for certain machine types. For all the crashes I saw, the target
> > CPU was at console_flush_all().
> > 
> > In the case above, there are thousands of processes in the cgroup, and
> > it is soft locking up before it reaches the 1024 limit in the code
> > (which would call the cond_resched()). So, cond_resched() in 1024 blocks
> > is not sufficient.
> > 
> > Remove the counter-based conditional rescheduling logic and call
> > cond_resched() unconditionally after each task iteration, after fn() is
> > called. This avoids the lockup independently of how slow fn() is.
> > 
> > Cc: Michael van der Westhuizen <rmikey@meta.com>
> > Cc: Usama Arif <usamaarif642@gmail.com>
> > Cc: Pavel Begunkov <asml.silence@gmail.com>
> > Suggested-by: Rik van Riel <riel@surriel.com>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Fixes: 46576834291869457 ("memcg: fix soft lockup in the OOM process")
> 
> Can you share the call stack but I think from the above, it seems to be
> from oom_kill_memcg_member().

Sure, this is what I see at the crash time:

	[73963.996160]  Memory cgroup out of memory: Killed process 177737 (adb) total-vm:24896kB, anon-rss:0kB, file-rss:0kB, shmem-rss:0kB, UID:0 pgtables:320kB oom_score_adj:0
	[73964.026146]  Memory cgroup out of memory: Killed process 177738 (sh) total-vm:8064kB, anon-rss:0kB, file-rss:0kB, shmem-rss:0kB, UID:0 pgtables:320kB oom_score_adj:0
	[73964.055784]  Memory cgroup out of memory: Killed process 177739 (adb) total-vm:24896kB, anon-rss:0kB, file-rss:0kB, shmem-rss:0kB, UID:0 pgtables:320kB oom_score_adj:0
	[73964.085773]  Memory cgroup out of memory: Killed process 177740 (sh) total-vm:8064kB, anon-rss:0kB, file-rss:0kB, shmem-rss:0kB, UID:0 pgtables:320kB oom_score_adj:0
	[73964.115468]  Memory cgroup out of memory: Killed process 177742 (adb) total-vm:24896kB, anon-rss:0kB, file-rss:0kB, shmem-rss:0kB, UID:0 pgtables:320kB oom_score_adj:0
	[73964.145375]  watchdog: BUG: soft lockup - CPU#20 stuck for 26s! [node-linux-arm6:159076]
	[73964.145376]  CPU#20 Utilization every 4s during lockup:
	[73964.145377]  	#1:   4% system,	  0% softirq,	  0% hardirq,	  0% idle
	[73964.145379]  	#2:   4% system,	  0% softirq,	  0% hardirq,	  0% idle
	[73964.145380]  	#3:   4% system,	  0% softirq,	  0% hardirq,	  0% idle
	[73964.145380]  	#4:   4% system,	  0% softirq,	  0% hardirq,	  0% idle
	[73964.145381]  	#5:   6% system,	  0% softirq,	  0% hardirq,	  0% idle
	[73964.145382]  Modules linked in: vhost_vsock(E) ghes_edac(E) bpf_preload(E) tls(E) tcp_diag(E) inet_diag(E) sch_fq(E) act_gact(E) cls_bpf(E) ipmi_ssif(E) ipmi_devintf(E) crct10dif_ce(E) sm3_ce(E) sm3(E) sha3_ce(E) nvidia_cspmu(E) sha512_ce(E) sha512_arm64(E) arm_smmuv3_pmu(E) arm_cspmu_module(E) coresight_trbe(E) arm_spe_pmu(E) coresight_stm(E) coresight_tmc(E) ipmi_msghandler(E) coresight_etm4x(E) stm_core(E) coresight_funnel(E) spi_tegra210_quad(E) coresight(E) cppc_cpufreq(E) sch_fq_codel(E) vhost_net(E) tun(E) vhost(E) vhost_iotlb(E) tap(E) mpls_gso(E) mpls_iptunnel(E) mpls_router(E) fou(E) acpi_power_meter(E) loop(E) drm(E) backlight(E) drm_panel_orientation_quirks(E) autofs4(E) efivarfs(E)
	[73964.145407]  CPU: 20 UID: 0 PID: 159076 Comm: node-linux-arm6 Kdump: loaded Tainted: G            E      
	[73964.145409]  Tainted: [E]=UNSIGNED_MODULE
	[73964.145410]  Hardware name: .....
	[73964.145411]  pstate: 63401009 (nZCv daif +PAN -UAO +TCO +DIT +SSBS BTYPE=--)
	[73964.145412]  pc : console_flush_all+0x3bc/0x550
	[73964.145418]  lr : console_flush_all+0x3b4/0x550
	[73964.145419]  sp : ffff80014baceff0
	[73964.145420]  x29: ffff80014bacf040 x28: 0000000000000001 x27: ffff800082d2d008
	[73964.145421]  x26: 0000000000000000 x25: 0000000000000000 x24: ffff00017bd00000
	[73964.145422]  x23: 0000000000000000 x22: 0000000000000084 x21: ffff80008253a718
	[73964.145423]  x20: ffff800082526b08 x19: ffff80014bacf0ac x18: 0000000000000018
	[73964.145424]  x17: 0000000000000058 x16: 00000000ffffffff x15: 0000000000003638
	[73964.145425]  x14: 0000000000000001 x13: 65636f7270206465 x12: 6c6c694b203a7972
	[73964.145427]  x11: ffff800083086000 x10: ffff80008308625c x9 : 00000000ffffffff
	[73964.145428]  x8 : 0000000000000000 x7 : 205d383634353131 x6 : 312e34363933375b
	[73964.145429]  x5 : ffff8000830864f7 x4 : ffff80014bacee7f x3 : ffff8000803ce390
	[73964.145430]  x2 : 00000000000000aa x1 : 0000000000000000 x0 : 0000000000000000
	[73964.145432]  Call trace:
	[73964.145433]   console_flush_all+0x3bc/0x550 (P)
	[73964.145434]   console_unlock+0x90/0x188
	[73964.145437]   vprintk_emit+0x3c8/0x560
	[73964.145439]   vprintk_default+0x3c/0x50
	[73964.145441]   vprintk+0x2c/0x40
	[73964.145443]   _printk+0x50/0x68
	[73964.145444]   __oom_kill_process+0x36c/0x5f8
	[73964.145445]   oom_kill_memcg_member+0x54/0xb8
	[73964.145447]   mem_cgroup_scan_tasks+0xa4/0x190
	[73964.145449]   oom_kill_process+0x124/0x290
	[73964.145450]   out_of_memory+0x194/0x4b8
	[73964.145451]   mem_cgroup_out_of_memory+0xcc/0x110
	[73964.145452]   __mem_cgroup_charge+0x5d8/0x9e0
	[73964.145454]   filemap_add_folio+0x44/0xe0
	[73964.145456]   alloc_extent_buffer+0x2a8/0xaa8
	[73964.145458]   read_block_for_search+0x204/0x308
	[73964.145460]   btrfs_search_slot+0x5bc/0x998
	[73964.145463]   btrfs_lookup_file_extent+0x44/0x58
	[73964.145465]   btrfs_get_extent+0x130/0x900
	[73964.145467]   btrfs_do_readpage+0x2d8/0x798
	[73964.145469]   btrfs_readahead+0x64/0x198
	[73964.145470]   read_pages+0x58/0x370
	[73964.145471]   page_cache_ra_unbounded+0x218/0x260
	[73964.145473]   page_cache_ra_order+0x2d0/0x338
	[73964.145474]   filemap_fault+0x418/0xe68
	[73964.145475]   __do_fault+0xb0/0x270
	[73964.145476]   do_pte_missing+0x73c/0x1148
	[73964.145477]   handle_mm_fault+0x2c8/0xeb8
	[73964.145478]   do_translation_fault+0x250/0x820
	[73964.145479]   do_mem_abort+0x40/0xc8
	[73964.145481]   el0_ia+0x60/0x100
	[73964.145483]   el0t_64_sync_handler+0xe8/0x100
	[73964.145484]   el0t_64_sync+0x168/0x170
	[73964.145486]  Kernel panic - not syncing: softlockup: hung tasks
	[73964.145487]  CPU: 20 UID: 0 PID: 159076 Comm: node-linux-arm6 Kdump: loaded Tainted: G            EL    
	[73964.145489]  Tainted: [E]=UNSIGNED_MODULE, [L]=SOFTLOCKUP
	[73964.145490]  Call trace:
	[73964.145491]   show_stack+0x1c/0x30 (C)
	[73964.145492]   dump_stack_lvl+0x38/0x80
	[73964.145494]   panic+0x11c/0x370
	[73964.145496]   watchdog_timer_fn+0x5c0/0x968
	[73964.145498]   __hrtimer_run_queues+0x100/0x310
	[73964.145500]   hrtimer_interrupt+0x110/0x400
	[73964.145502]   arch_timer_handler_phys+0x34/0x50
	[73964.145503]   handle_percpu_devid_irq+0x88/0x1c0
	[73964.145505]   generic_handle_domain_irq+0x48/0x80
	[73964.145506]   gic_handle_irq+0x4c/0x108
	[73964.145507]   call_on_irq_stack+0x24/0x30
	[73964.145509]   do_interrupt_handler+0x50/0x78
	[73964.145511]   el1_interrupt+0x30/0x48
	[73964.145512]   el1h_64_irq_handler+0x14/0x20
	[73964.145513]   el1h_64_irq+0x6c/0x70
	[73964.145514]   console_flush_all+0x3bc/0x550 (P)
	[73964.145515]   console_unlock+0x90/0x188
	[73964.145517]   vprintk_emit+0x3c8/0x560
	[73964.145517]   vprintk_default+0x3c/0x50
	[73964.145519]   vprintk+0x2c/0x40
	[73964.145520]   _printk+0x50/0x68
	[73964.145521]   __oom_kill_process+0x36c/0x5f8
	[73964.145522]   oom_kill_memcg_member+0x54/0xb8
	[73964.145524]   mem_cgroup_scan_tasks+0xa4/0x190
	[73964.145525]   oom_kill_process+0x124/0x290
	[73964.145526]   out_of_memory+0x194/0x4b8
	[73964.145527]   mem_cgroup_out_of_memory+0xcc/0x110
	[73964.145528]   __mem_cgroup_charge+0x5d8/0x9e0
	[73964.145530]   filemap_add_folio+0x44/0xe0
	[73964.145531]   alloc_extent_buffer+0x2a8/0xaa8
	[73964.145532]   read_block_for_search+0x204/0x308
	[73964.145534]   btrfs_search_slot+0x5bc/0x998
	[73964.145536]   btrfs_lookup_file_extent+0x44/0x58
	[73964.145538]   btrfs_get_extent+0x130/0x900
	[73964.145540]   btrfs_do_readpage+0x2d8/0x798
	[73964.145542]   btrfs_readahead+0x64/0x198
	[73964.145544]   read_pages+0x58/0x370
	[73964.145545]   page_cache_ra_unbounded+0x218/0x260
	[73964.145546]   page_cache_ra_order+0x2d0/0x338
	[73964.145547]   filemap_fault+0x418/0xe68
	[73964.145548]   __do_fault+0xb0/0x270
	[73964.145549]   do_pte_missing+0x73c/0x1148
	[73964.145549]   handle_mm_fault+0x2c8/0xeb8
	[73964.145550]   do_translation_fault+0x250/0x820
	[73964.145552]   do_mem_abort+0x40/0xc8
	[73964.145554]   el0_ia+0x60/0x100
	[73964.145556]   el0t_64_sync_handler+0xe8/0x100
	[73964.145557]   el0t_64_sync+0x168/0x170
	[73964.145560]  SMP: stopping secondary CPUs
	[73964.145803]  Starting crashdump kernel...
	[73964.145804]  Bye!

> Have you tried making __oom_kill_process
> not chatty? Basically instead of dumping to serial directly, use local
> buffer and then dump once it is full.

Not sure I followed you here. __oom_kill_process is doing the following:

  static void __oom_kill_process(struct task_struct *victim, const char *message)
  {
	...
        pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB, UID:%u pgtables:%lukB oom_score_adj:%hd\n",


Would you use a buffer to print to, and them flush it at the same time
(with pr_err()?)

> Anyways, that would be a bit more involved and until then this seems
> fine to me.

Agree. Thanks for the review.

