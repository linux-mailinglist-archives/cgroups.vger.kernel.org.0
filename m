Return-Path: <cgroups+bounces-10652-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 100B5BD1C58
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 09:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DAB018979C2
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 07:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6327A2E8894;
	Mon, 13 Oct 2025 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YaV9Kput"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931602E2657
	for <cgroups@vger.kernel.org>; Mon, 13 Oct 2025 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340248; cv=none; b=Qv0fSpjZP0FTkIYPGTQLvM1r6zGxiKlY2bE0cfVDF0Hi12wRmkoUk332qnGFTB4a4tVr7moiZFIwZs/LtO61OFP1HwYbr+kA6YYwfWSC0By6l8Z+m/WWBoyHSUZ5JyrO047jfAlxlnzqHnlOwIfB0i7+oHoo6uiOiWzjOO3EWzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340248; c=relaxed/simple;
	bh=UP4UcMcf1M/aB8HA2sSVPaLwr/P3zIFFPlbXEK7uKAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i0WQeCW2Ra1rqjHyh0yVnx4faVwXVmJQaqcujo85gBOHPbsxnFLblWkbIxBUB1yD4+TVW0Jv9FTS382U+fBwJG9+59ke896bSrfcG1EmUo0I0jyz0AAvDHf55e9HQBaTXRgPA+7D6KEOp4suzkZcp84wE4S8OYkoukxn/cSJb5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YaV9Kput; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <df9a3e22-caca-4298-b7d8-5334ce5446a0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760340243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UTwHrwesb3gXBh5bL8coyxDbz9vOysract+Yrr0Kj7w=;
	b=YaV9KputqEfryJZ9woWyM5/zhH/ZA62+Oem+AOEj/cH7gRxqqEL0LqKj3ErwRVjyutjVBA
	dzSGzbLKxmWPuyJr8VMAR1Yznm3r9wVlHX1nx7J0hKMaY6GaWUqCUC8RoLGRFlct5r2tcj
	YvZAQeGaCyIIMBtI+NGjFdYdUBD3cdc=
Date: Mon, 13 Oct 2025 15:23:53 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/4] reparent the THP split queue
To: Zi Yan <ziy@nvidia.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, harry.yoo@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1759510072.git.zhengqi.arch@bytedance.com>
 <925E0247-2976-4D85-A8AA-E8C92C64CED4@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <925E0247-2976-4D85-A8AA-E8C92C64CED4@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Zi,

On 10/11/25 12:25 AM, Zi Yan wrote:
> On 3 Oct 2025, at 12:53, Qi Zheng wrote:

[snip]

>>
> 
> Hi Qi,
> 
> I got CPU soft locks when run "echo 3 | sudo tee /proc/sys/vm/drop_caches"
> with today's mm-new on a freshly booted system. Reverting Patch 3 (and Patch 4)
> of your patchset solves the issue.
> 
> My config file is attached. My kernel relevant kernel parameters are:
> "cgroup_no_v1=all transparent_hugepage=always thp_shmem=2M:always".
> The machine is a 8GB 8-core x86_64 VM.
> 
> The kernel log:
> 
> [   36.441539] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [tee:810]
> [   36.441549] Modules linked in:
> [   36.441566] CPU: 0 UID: 0 PID: 810 Comm: tee Not tainted 6.17.0-mm-everything-2024-01-29-07-19-no-mglru+ #526 PREEMPT(voluntary)
> [   36.441570] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> [   36.441574] RIP: 0010:_raw_spin_unlock_irqrestore+0x19/0x40

It seems that the softlockup is not caused by lock contention. I have
also seen the following stack locally:

[14819.914867][    C2] watchdog: BUG: soft lockup - CPU#2 stuck for 49s! 
[kswapd0:202]
[14819.914873][    C2] Modules linked in:
[14819.914877][    C2] CPU: 2 UID: 0 PID: 202 Comm: kswapd0 Tainted: G 
           L      6.1
[14819.914880][    C2] Tainted: [L]=SOFTLOCKUP
[14819.914881][    C2] Hardware name: QEMU Standard PC (i440FX + PIIX, 
1996), BIOS 1.12.0-1 04
[14819.914883][    C2] RIP: 0010:folios_put_refs+0x34/0x210
[14819.914889][    C2] Code: 57 41 56 49 89 fe 41 55 41 54 55 53 48 83 
ec 18 65 48 8b 05 36 51
[14819.914891][    C2] RSP: 0000:ffffc900039db8e8 EFLAGS: 00000246
[14819.914893][    C2] RAX: 0000000000000000 RBX: ffff888109e64330 RCX: 
ffffffff82848bb8
[14819.914895][    C2] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 
ffffc900039db960
[14819.914896][    C2] RBP: ffff888109e642a0 R08: ffff888100403058 R09: 
ffff888100402fe8
[14819.914897][    C2] R10: 0000000000000000 R11: ffffffff82711328 R12: 
ffff888109e64328
[14819.914898][    C2] R13: ffffc900039dbb30 R14: ffffc900039db960 R15: 
ffffc900039dbb30
[14819.914916][    C2] FS:  0000000000000000(0000) 
GS:ffff888332ad7000(0000) knlGS:00000000000
[14819.914918][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[14819.914919][    C2] CR2: 00007f8d211b3000 CR3: 000000010833c000 CR4: 
00000000000006f0
[14819.914921][    C2] Call Trace:
[14819.914923][    C2]  <TASK>
[14819.914927][    C2]  deferred_split_scan+0x30d/0x420
[14819.914934][    C2]  do_shrink_slab+0x105/0x350
[14819.914937][    C2]  shrink_slab+0x2fa/0x3f0
[14819.914939][    C2]  ? try_to_shrink_lruvec+0x1a6/0x270
[14819.914944][    C2]  shrink_one+0x11d/0x1b0
[14819.914947][    C2]  shrink_node+0x9a4/0xb90
[14819.914952][    C2]  balance_pgdat+0x548/0x910
[14819.914955][    C2]  ? __sched_fork+0x160/0x180
[14819.914964][    C2]  ? __timer_delete_sync+0x2b/0x40
[14819.914970][    C2]  kswapd+0x1b9/0x320
[14819.914973][    C2]  ? __pfx_autoremove_wake_function+0x10/0x10
[14819.914978][    C2]  ? __pfx_kswapd+0x10/0x10
[14819.914981][    C2]  kthread+0xfd/0x250
[14819.914984][    C2]  ? finish_task_switch+0x90/0x270
[14819.914987][    C2]  ? __pfx_kthread+0x10/0x10
[14819.914989][    C2]  ? __pfx_kthread+0x10/0x10
[14819.914991][    C2]  ret_from_fork+0x170/0x190
[14819.914995][    C2]  ? __pfx_kthread+0x10/0x10
[14819.914996][    C2]  ret_from_fork_asm+0x1a/0x30
[14819.915002][    C2]  </TASK>

It seems that the reason is that deferred_split_scan() has been executed
for too long.

Could you please help test the following changes? I applied them locally
and no softlockup occurred.

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b5eea2091cdf6..5353c7bd2c9af 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4286,8 +4286,10 @@ static unsigned long deferred_split_scan(struct 
shrinker *shrink,
         }
         folios_put(&fbatch);

-       if (sc->nr_to_scan)
+       if (sc->nr_to_scan) {
+               cond_resched();
                 goto retry;
+       }

         /*
          * Stop shrinker if we didn't split any page, but the queue is 
empty.

Thanks,
Qi

> [   36.441592] Code: 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 53 48 89 f3 e8 92 68 fd fe 80 e7 02 74 06 fb 0f 1f 44 00 00 <65> ff 0d d0 5f 7e 01 74 06 5b c3 cc cc cc cc 0f 1f 44 00 00 5b c3
> [   36.441594] RSP: 0018:ffffc900029afb60 EFLAGS: 00000202
> [   36.441598] RAX: 0000000000000001 RBX: 0000000000000286 RCX: ffff888101168670
> [   36.441601] RDX: 0000000000000001 RSI: 0000000000000286 RDI: ffff888101168658
> [   36.441602] RBP: 0000000000000001 R08: ffff88813ba44ec0 R09: 0000000000000000
> [   36.441603] R10: 00000000000001a8 R11: 0000000000000000 R12: ffff8881011685e0
> [   36.441604] R13: 0000000000000000 R14: ffff888101168000 R15: ffffc900029afd60
> [   36.441606] FS:  00007f7fe3655740(0000) GS:ffff8881b7e5d000(0000) knlGS:0000000000000000
> [   36.441607] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   36.441608] CR2: 0000563d4d439bf0 CR3: 000000010873c006 CR4: 0000000000370ef0
> [   36.441614] Call Trace:
> [   36.441616]  <TASK>
> [   36.441619]  deferred_split_scan+0x1e0/0x480
> [   36.441627]  ? _raw_spin_unlock_irqrestore+0xe/0x40
> [   36.441630]  ? kvfree_rcu_queue_batch+0x96/0x1c0
> [   36.441634]  ? do_raw_spin_unlock+0x46/0xd0
> [   36.441639]  ? kfree_rcu_monitor+0x1da/0x2c0
> [   36.441641]  ? list_lru_count_one+0x47/0x90
> [   36.441644]  do_shrink_slab+0x153/0x360
> [   36.441649]  shrink_slab+0xd3/0x390
> [   36.441652]  drop_slab+0x7d/0x130
> [   36.441655]  drop_caches_sysctl_handler+0x98/0xb0
> [   36.441660]  proc_sys_call_handler+0x1c7/0x2c0
> [   36.441664]  vfs_write+0x221/0x450
> [   36.441669]  ksys_write+0x6c/0xe0
> [   36.441672]  do_syscall_64+0x50/0x200
> [   36.441675]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   36.441678] RIP: 0033:0x7f7fe36e7687
> [   36.441685] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
> [   36.441686] RSP: 002b:00007ffdffcbba10 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> [   36.441688] RAX: ffffffffffffffda RBX: 00007f7fe3655740 RCX: 00007f7fe36e7687
> [   36.441689] RDX: 0000000000000002 RSI: 00007ffdffcbbbb0 RDI: 0000000000000003
> [   36.441690] RBP: 00007ffdffcbbbb0 R08: 0000000000000000 R09: 0000000000000000
> [   36.441691] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
> [   36.441692] R13: 0000558d40be64c0 R14: 00007f7fe383de80 R15: 0000000000000002
> [   36.441694]  </TASK>
> [   64.441531] watchdog: BUG: soft lockup - CPU#0 stuck for 53s! [tee:810]
> [   64.441537] Modules linked in:
> [   64.441545] CPU: 0 UID: 0 PID: 810 Comm: tee Tainted: G             L      6.17.0-mm-everything-2024-01-29-07-19-no-mglru+ #526 PREEMPT(voluntary)
> [   64.441548] Tainted: [L]=SOFTLOCKUP
> [   64.441552] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> [   64.441555] RIP: 0010:_raw_spin_unlock_irqrestore+0x19/0x40
> [   64.441565] Code: 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 53 48 89 f3 e8 92 68 fd fe 80 e7 02 74 06 fb 0f 1f 44 00 00 <65> ff 0d d0 5f 7e 01 74 06 5b c3 cc cc cc cc 0f 1f 44 00 00 5b c3
> [   64.441566] RSP: 0018:ffffc900029afb60 EFLAGS: 00000202
> [   64.441568] RAX: 0000000000000001 RBX: 0000000000000286 RCX: ffff888101168670
> [   64.441570] RDX: 0000000000000001 RSI: 0000000000000286 RDI: ffff888101168658
> [   64.441571] RBP: 0000000000000001 R08: ffff88813ba44ec0 R09: 0000000000000000
> [   64.441572] R10: 00000000000001a8 R11: 0000000000000000 R12: ffff8881011685e0
> [   64.441573] R13: 0000000000000000 R14: ffff888101168000 R15: ffffc900029afd60
> [   64.441574] FS:  00007f7fe3655740(0000) GS:ffff8881b7e5d000(0000) knlGS:0000000000000000
> [   64.441576] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   64.441577] CR2: 0000563d4d439bf0 CR3: 000000010873c006 CR4: 0000000000370ef0
> [   64.441581] Call Trace:
> [   64.441583]  <TASK>
> [   64.441591]  deferred_split_scan+0x1e0/0x480
> [   64.441598]  ? _raw_spin_unlock_irqrestore+0xe/0x40
> [   64.441599]  ? kvfree_rcu_queue_batch+0x96/0x1c0
> [   64.441603]  ? do_raw_spin_unlock+0x46/0xd0
> [   64.441607]  ? kfree_rcu_monitor+0x1da/0x2c0
> [   64.441610]  ? list_lru_count_one+0x47/0x90
> [   64.441613]  do_shrink_slab+0x153/0x360
> [   64.441618]  shrink_slab+0xd3/0x390
> [   64.441621]  drop_slab+0x7d/0x130
> [   64.441624]  drop_caches_sysctl_handler+0x98/0xb0
> [   64.441629]  proc_sys_call_handler+0x1c7/0x2c0
> [   64.441632]  vfs_write+0x221/0x450
> [   64.441638]  ksys_write+0x6c/0xe0
> [   64.441641]  do_syscall_64+0x50/0x200
> [   64.441645]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   64.441648] RIP: 0033:0x7f7fe36e7687
> [   64.441654] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
> [   64.441656] RSP: 002b:00007ffdffcbba10 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> [   64.441658] RAX: ffffffffffffffda RBX: 00007f7fe3655740 RCX: 00007f7fe36e7687
> [   64.441659] RDX: 0000000000000002 RSI: 00007ffdffcbbbb0 RDI: 0000000000000003
> [   64.441660] RBP: 00007ffdffcbbbb0 R08: 0000000000000000 R09: 0000000000000000
> [   64.441661] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
> [   64.441662] R13: 0000558d40be64c0 R14: 00007f7fe383de80 R15: 0000000000000002
> [   64.441663]  </TASK>
> 
> 
> 
> --
> Best Regards,
> Yan, Zi


