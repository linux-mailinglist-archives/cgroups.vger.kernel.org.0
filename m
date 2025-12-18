Return-Path: <cgroups+bounces-12499-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC44CCB669
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 11:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1723E306D0B2
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 10:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5F3333438;
	Thu, 18 Dec 2025 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hK9VnJdM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9F9332ED0
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766052480; cv=none; b=DlizkGuzpXPvAd5C4Q9JRELktnxsMK5pkLMEDNPaA2qDDVTSLIKx93DwETgI070wcRaf2VO/xB1Yd/zNdNPvTECP8zELIyot94mIw2wDaKQwwdizUjcKbCPJnzQXafEIuWzZvDjQ6RrCiOWG3xyW7D9idaaxVUQzuEjZxrDbf24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766052480; c=relaxed/simple;
	bh=0ZSIjOGLffaKT0/CaKxH6SkrGqGkRyxqGo3gny2iq5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4gV/jqdKF94fWdZ/BaXN+q9pKKw21ZjAYSjZPsNYFos/sba57/dyu2OlFCQcIYjka7tyhMm7rwcGP8uYxKIGDiPxd5tSI1egPl+8GPwBWeVqTGClelDUjGX+eFqPI/mEsv1z2BGkR6fRfGjr75Uz77akwlfCCBzkxjm9OkjXK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hK9VnJdM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso443307b3a.2
        for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 02:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766052476; x=1766657276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=luxkOlYihYEReLXqB5oChjBmxJh+ZdToiRjz0ymhJeE=;
        b=hK9VnJdMDKyKNLEoCQZuxN8EkZ2TMuACQSKeW9jnYOjG/EJyrQ506CSF/QApQ7WaZz
         HmxMye0OVwLh2Nr22z3BdYvncA1Fbkn5soxEm87n1b7siW7MU6juRyTdif1mY1PWM4qD
         7wP02w2A+OWNzqdIe5RZfOMNtWGSnnA6ZRTVCnSqtvk+zcOe6JX5FOck31bMPAGdmke9
         xEnzaQ3OxqExsnno3fTYaTN7IcarfPaLr4/eFUNdCJ6I8ylntrvhAurn7efImiBBBw65
         Lkrjo+WGE75Zj8jHtUIGouT4Am8QX7z3rOMT32hm3VKarn8ZrYoB+XY9RycE0x/bXj1w
         TyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766052476; x=1766657276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=luxkOlYihYEReLXqB5oChjBmxJh+ZdToiRjz0ymhJeE=;
        b=d+u5zLW4sZcTau9VjwqNVmDbm8fSh3NnWtsXC+bCWm79nYWkcABy9FVwTzWy1X1eJ1
         NF+2okzAuF89KJ6K68zi8HqeFsL+3musaJnNghBLxK1sCJglZnRvFpT0DoXuISeXEK3B
         +cim/OoVFhu4SywzugkVQBgEcqkmjWVKsdCFizQHiraEM+88GWmp+o2Taj/Mt7DBDQm5
         UdRGOX0uSgcxmf01ALj50nV4wdcr2mc3yuSZjIZ+Mw3I0jev3+Wb7G8nFAmX9U1ZwFtg
         jX1jpTBDpGGn4b64/GuxqUay3ZRl4venxf7lun4f0Qind0aJgNBy6Cs3lVCt3zxA/fLb
         0rzg==
X-Forwarded-Encrypted: i=1; AJvYcCXlZEXxL+e0KvUq60sYG0Uy7M7S0XcIQWZ2+rHR7VLUZXyctrEU6iMVUBFAzi1ySifnRJ3zHNbI@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg/dLiJSWZYCFWMoXI+RL/vYj6ibHcrDHqL2uSWQSShRp0huqs
	b11yu0VNOSBOgjHx9Pen7FhlcQtjFp5xCUSZqKlFYm1JMNxE0wQVFd0c
X-Gm-Gg: AY/fxX46M36JvJl2gnWEJGIKLSQYIz/VpHt6UBYLELIO5eRy+fqzI5vGDDQ845fzaq+
	XWvpbuC1/7DfoR7b2xWkQBKGKOvygzUC5Fy7NjaokaXK8Fyjh8Z7X/PNiix9Kx+Db6VW/o7a8Xq
	jdWdLFMZ9rGRFjgCAJjPBL++BpHGQlbxFz6q/1/Twb4jidKptUv/wGi6Tb6gDriuak8ZwOXtR2B
	nyGfwuvGqYHqo0hOdruVlM1Rei90tCK6HwONqoxilebsC8bKvw/eZ4HH1c5k6TdS2gDy9p9JDEA
	+urB+sDOpoLUFsjXNnir+1MGKUS2PAwQLaA2Xw2uzMEh2c1AIdWn4DbsDse/mKr7oaeEuGAiTfp
	GoXOiEentY+LymSlFPxNkoJEemawj/Jg2DggXiH4c9eRgav8A43pvhwGvBccf1Qyf7GFrME2C8U
	AVDhalEQ8bNVcabX5ws2mUElr4
X-Google-Smtp-Source: AGHT+IEEeLUr3c+MeH5hgNxe5s+/Yz9YnerWLuUnAdu2JlhdcaO5p6niN1NXpqQC5wtx+uTq6l0KqQ==
X-Received: by 2002:a05:7022:628c:b0:11b:803c:2cf5 with SMTP id a92af1059eb24-11f34c0e4b6mr18795908c88.33.1766052475127;
        Thu, 18 Dec 2025 02:07:55 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12061fceec2sm5989300c88.13.2025.12.18.02.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 02:07:54 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 18 Dec 2025 02:07:52 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH 2/3 v3] genirq: Fix interrupt threads affinity vs. cpuset
 isolated partitions
Message-ID: <9f8be25e-5aa7-41e7-a817-851eb3e55772@roeck-us.net>
References: <20251121143500.42111-1-frederic@kernel.org>
 <20251121143500.42111-3-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121143500.42111-3-frederic@kernel.org>

Hi,

On Fri, Nov 21, 2025 at 03:34:59PM +0100, Frederic Weisbecker wrote:
> When a cpuset isolated partition is created / updated or destroyed, the
> interrupt threads are affine blindly to all the non-isolated CPUs. And this
> happens without taking into account the interrupt threads initial affinity
> that becomes ignored.
> 
> For example in a system with 8 CPUs, if an interrupt and its kthread are
> initially affine to CPU 5, creating an isolated partition with only CPU 2
> inside will eventually end up affining the interrupt kthread to all CPUs
> but CPU 2 (that is CPUs 0,1,3-7), losing the kthread preference for CPU 5.
> 
> Besides the blind re-affinity, this doesn't take care of the actual low
> level interrupt which isn't migrated. As of today the only way to isolate
> non managed interrupts, along with their kthreads, is to overwrite their
> affinity separately, for example through /proc/irq/
> 
> To avoid doing that manually, future development should focus on updating
> the interrupt's affinity whenever cpuset isolated partitions are updated.
> 
> In the meantime, cpuset shouldn't fiddle with interrupt threads directly.
> To prevent from that, set the PF_NO_SETAFFINITY flag to them.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://patch.msgid.link/20251118143052.68778-2-frederic@kernel.org

This patch triggers crashes due to lockups on systems with CONFIG_PREEMPT_RT
enabled.

Example and bisect log below. Reverting this patch fixes the problem.

Guenter

---
Linux version 6.19.0-rc1 (groeck@mars) (x86_64-linux-gcc (GCC) 14.3.0, GNU ld (GNU Binutils) 2.44) #1 SMP PREEMPT_RT Mon Dec 15 11:02:44 PST 2025
[   66.503958]
[   66.503982] ============================================
[   66.503990] WARNING: possible recursive locking detected
[   66.504114] 6.19.0-rc1 #1 Tainted: G                 N
[   66.504126] --------------------------------------------
[   66.504135] irq/22-eth0/3560 is trying to acquire lock:
[   66.504195] ffff9eca0442ce40 (&ei_local->page_lock){+.+.}-{3:3}, at: ei_start_xmit+0x83/0x3b0
[   66.504386]
[   66.504386] but task is already holding lock:
[   66.504393] ffff9eca0442ce40 (&ei_local->page_lock){+.+.}-{3:3}, at: __ei_interrupt.isra.0+0x2c/0x310
[   66.504454]
[   66.504454] other info that might help us debug this:
[   66.504487]  Possible unsafe locking scenario:
[   66.504487]
[   66.504494]        CPU0
[   66.504500]        ----
[   66.504505]   lock(&ei_local->page_lock);
[   66.504524]   lock(&ei_local->page_lock);
[   66.504542]
[   66.504542]  *** DEADLOCK ***
[   66.504542]
[   66.504548]  May be due to missing lock nesting notation
[   66.504548]
[   66.504577] 11 locks held by irq/22-eth0/3560:
[   66.504599]  #0: ffff9eca0442ce40 (&ei_local->page_lock){+.+.}-{3:3}, at: __ei_interrupt.isra.0+0x2c/0x310
[   66.504636]  #1: ffffffffb8c0f260 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0xe3/0x1d0
[   66.504699]  #2: ffffffffb8c0f260 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0x141/0x220
[   66.504722]  #3: ffffffffb8c0f260 (rcu_read_lock){....}-{1:3}, at: process_backlog+0x25/0x2b0
[   66.504746]  #4: ffffffffb8c0f260 (rcu_read_lock){....}-{1:3}, at: __neigh_update+0x3e6/0xfd0
[   66.504767]  #5: ffffffffb8b18a40 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x22/0x220
[   66.504809]  #6: ffffffffb8c0f220 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit+0x6e/0x15a0
[   66.504830]  #7: ffff9eca064d4328 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{3:3}, at: __dev_queue_xmit+0xf7a/0x15a0
[   66.504853]  #8: ffffffffb8c0f260 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x52/0x110
[   66.504873]  #9: ffff9eca04473958 (_xmit_ETHER#2){+...}-{3:3}, at: sch_direct_xmit+0x118/0x2b0
[   66.504909]  #10: ffffffffb8c0f260 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0xe3/0x1d0
[   66.504939]
[   66.504939] stack backtrace:
[   66.505132] CPU: 1 UID: 0 PID: 3560 Comm: irq/22-eth0 Tainted: G                 N  6.19.0-rc1 #1 PREEMPT_{RT,(full)}
[   66.505194] Tainted: [N]=TEST
[   66.505210] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-stable202408-prebuilt.qemu.org 08/13/2024
[   66.505323] Call Trace:
[   66.505390]  <TASK>
[   66.505454]  dump_stack_lvl+0x6f/0xb0
[   66.505513]  print_deadlock_bug.cold+0xbd/0xcc
[   66.505531]  __lock_acquire+0x1396/0x1d20
[   66.505556]  lock_acquire+0xce/0x2d0
[   66.505570]  ? ei_start_xmit+0x83/0x3b0
[   66.505590]  ? __lock_acquire+0x7a3/0x1d20
[   66.505605]  rt_spin_lock+0x3a/0x1d0
[   66.505615]  ? ei_start_xmit+0x83/0x3b0
[   66.505632]  ei_start_xmit+0x83/0x3b0
[   66.505659]  dev_hard_start_xmit+0x67/0x210
[   66.505676]  sch_direct_xmit+0x142/0x2b0
[   66.505696]  __dev_queue_xmit+0xfe6/0x15a0
[   66.505711]  ? lock_acquire+0xce/0x2d0
[   66.505719]  ? __neigh_update+0x310/0xfd0
[   66.505729]  ? find_held_lock+0x2b/0x80
[   66.505745]  ? mark_held_locks+0x40/0x70
[   66.505756]  ? eth_header+0x25/0xb0
[   66.505772]  ? __neigh_update+0x3e6/0xfd0
[   66.505783]  __neigh_update+0x310/0xfd0
[   66.505808]  arp_process+0x2e5/0xb50
[   66.505832]  ? process_backlog+0x25/0x2b0
[   66.505846]  ? rt_mutex_slowunlock+0x3ca/0x430
[   66.505861]  ? process_backlog+0x25/0x2b0
[   66.505870]  __netif_receive_skb_one_core+0x87/0x90
[   66.505887]  process_backlog+0x3c/0x2b0
[   66.505904]  __napi_poll.constprop.0+0x25/0x1b0
[   66.505919]  net_rx_action+0x308/0x410
[   66.505965]  handle_softirqs.isra.0+0xac/0x310
[   66.505985]  __local_bh_enable_ip+0xab/0x170
[   66.505997]  netif_rx+0x116/0x180
[   66.506007]  ei_receive+0x290/0x2f0
[   66.506027]  __ei_interrupt.isra.0+0x1d0/0x310
[   66.506045]  ? irq_thread+0xc1/0x2c0
[   66.506055]  irq_thread_fn+0x1e/0x60
[   66.506068]  irq_thread+0x1a3/0x2c0
[   66.506078]  ? __pfx_irq_thread_fn+0x10/0x10
[   66.506090]  ? __pfx_irq_thread_dtor+0x10/0x10
[   66.506104]  ? __pfx_irq_thread+0x10/0x10
[   66.506115]  kthread+0x108/0x230
[   66.506129]  ? __pfx_kthread+0x10/0x10
[   66.506144]  ret_from_fork+0x248/0x290
[   66.506154]  ? __pfx_kthread+0x10/0x10
[   66.506166]  ret_from_fork_asm+0x1a/0x30
[   66.506213]  </TASK>
Network interface test failed
TPM selftest failed
[   67.609615] exFAT-fs (sda2): invalid boot record signature
[   67.609656] exFAT-fs (sda2): failed to read boot sector
[   67.609683] exFAT-fs (sda2): failed to recognize exfat type
[   67.926789] ntfs3(sda2): Primary boot signature is not NTFS.
[   67.927057] ntfs3(sda2): try to read out of volume at offset 0x3fffe00
[   67.990642] NILFS (sda2): segctord starting. Construction interval = 5 seconds, CP frequency < 30 seconds
[   68.378765] random: crng init done
[   92.888600] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   92.888748] rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-3): P3560/6:b..l
[   92.889076] rcu: 	(detected by 1, t=26002 jiffies, g=18041, q=1569 ncpus=4)
[   92.889337] task:irq/22-eth0     state:D stack:12048 pid:3560  tgid:3560  ppid:2      task_flags:0x4208040 flags:0x00080000
[   92.889517] Call Trace:
[   92.889604]  <TASK>
[   92.889630]  __schedule+0x5d4/0x1110
[   92.889691]  schedule_rtlock+0x1e/0x40
[   92.889707]  rtlock_slowlock_locked+0x61e/0x1bf0
[   92.889761]  rt_spin_lock+0x9b/0x1d0
[   92.889786]  ei_start_xmit+0x83/0x3b0
[   92.889827]  dev_hard_start_xmit+0x67/0x210
[   92.889853]  sch_direct_xmit+0x142/0x2b0
[   92.889880]  __dev_queue_xmit+0xfe6/0x15a0
[   92.889905]  ? lock_acquire+0xce/0x2d0
[   92.889918]  ? __neigh_update+0x310/0xfd0
[   92.889930]  ? find_held_lock+0x2b/0x80
[   92.889950]  ? mark_held_locks+0x40/0x70
[   92.889965]  ? eth_header+0x25/0xb0
[   92.889988]  ? __neigh_update+0x3e6/0xfd0
[   92.890004]  __neigh_update+0x310/0xfd0
[   92.890037]  arp_process+0x2e5/0xb50
[   92.890070]  ? process_backlog+0x25/0x2b0
[   92.890088]  ? rt_mutex_slowunlock+0x3ca/0x430
[   92.890108]  ? process_backlog+0x25/0x2b0
[   92.890119]  __netif_receive_skb_one_core+0x87/0x90
[   92.890138]  process_backlog+0x3c/0x2b0
[   92.890162]  __napi_poll.constprop.0+0x25/0x1b0
[   92.890188]  net_rx_action+0x308/0x410
[   92.890252]  handle_softirqs.isra.0+0xac/0x310
[   92.890280]  __local_bh_enable_ip+0xab/0x170
[   92.890295]  netif_rx+0x116/0x180
[   92.890310]  ei_receive+0x290/0x2f0
[   92.890343]  __ei_interrupt.isra.0+0x1d0/0x310
[   92.890365]  ? irq_thread+0xc1/0x2c0
[   92.890383]  irq_thread_fn+0x1e/0x60
[   92.890402]  irq_thread+0x1a3/0x2c0
[   92.890416]  ? __pfx_irq_thread_fn+0x10/0x10
[   92.890431]  ? __pfx_irq_thread_dtor+0x10/0x10
[   92.890449]  ? __pfx_irq_thread+0x10/0x10
[   92.890463]  kthread+0x108/0x230
[   92.890488]  ? __pfx_kthread+0x10/0x10
[   92.890511]  ret_from_fork+0x248/0x290
[   92.890527]  ? __pfx_kthread+0x10/0x10
[   92.890542]  ret_from_fork_asm+0x1a/0x30
[   92.890584]  </TASK>
[  123.205685] INFO: task pool_workqueue_:3 blocked for more than 30 seconds.
[  123.205742]       Tainted: G                 N  6.19.0-rc1 #1
[  123.205763] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  123.205796] task:pool_workqueue_ state:D stack:14744 pid:3     tgid:3     ppid:2      task_flags:0x208040 flags:0x00080000
[  123.205833] Call Trace:
[  123.205841]  <TASK>
[  123.205861]  __schedule+0x5d4/0x1110
[  123.205911]  schedule+0x35/0x130
[  123.205926]  schedule_timeout+0xd1/0x120
[  123.205961]  __wait_for_common+0xbf/0x1f0
[  123.205975]  ? __pfx_schedule_timeout+0x10/0x10
[  123.206006]  synchronize_rcu_normal+0xf8/0x2c0
[  123.206074]  ? _raw_spin_lock_irqsave+0x3f/0x60
[  123.206088]  ? lock_acquire+0x284/0x2d0
[  123.206102]  ? lock_acquire+0x284/0x2d0
[  123.206111]  ? lock_acquire+0x284/0x2d0
[  123.206120]  ? lock_release+0x204/0x2c0
[  123.206138]  synchronize_rcu_expedited+0x31b/0x560
[  123.206173]  pwq_release_workfn+0x1a6/0x270
[  123.206197]  ? kthread_worker_fn+0x47/0x340
[  123.206207]  ? __pfx_pwq_release_workfn+0x10/0x10
[  123.206218]  kthread_worker_fn+0xce/0x340
[  123.206234]  ? __pfx_kthread_worker_fn+0x10/0x10
[  123.206255]  kthread+0x108/0x230
[  123.206274]  ? __pfx_kthread+0x10/0x10
[  123.206293]  ret_from_fork+0x248/0x290
[  123.206306]  ? __pfx_kthread+0x10/0x10
[  123.206321]  ret_from_fork_asm+0x1a/0x30
[  123.206363]  </TASK>
[  123.206393] INFO: task rcub/0:19 blocked for more than 30 seconds.
[  123.206403]       Tainted: G                 N  6.19.0-rc1 #1
[  123.206409] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  123.206414] task:rcub/0          state:D stack:14376 pid:19    tgid:19    ppid:2      task_flags:0x208040 flags:0x00080000
[  123.206438] Call Trace:
[  123.206589]  <TASK>
[  123.206609]  __schedule+0x5d4/0x1110
[  123.206646]  rt_mutex_schedule+0x2e/0x50
[  123.206662]  rt_mutex_slowlock_block.constprop.0+0x1b8/0x350
[  123.206678]  ? lock_acquire+0x284/0x2d0
[  123.206697]  __rt_mutex_slowlock_locked.constprop.0+0x113/0x320
[  123.206738]  rt_mutex_slowlock.constprop.0+0x48/0xb0
[  123.206760]  rt_mutex_lock_nested+0x85/0xa0
[  123.206774]  ? rcu_boost_kthread+0x41/0x530
[  123.206786]  rcu_boost_kthread+0x14b/0x530
[  123.206802]  ? __pfx_rcu_boost_kthread+0x10/0x10
[  123.206817]  kthread+0x108/0x230
[  123.206834]  ? __pfx_kthread+0x10/0x10
[  123.206853]  ret_from_fork+0x248/0x290
[  123.206865]  ? __pfx_kthread+0x10/0x10
[  123.206880]  ret_from_fork_asm+0x1a/0x30
[  123.206921]  </TASK>
[  123.206990] INFO: task umount:3611 blocked for more than 30 seconds.
[  123.207001]       Tainted: G                 N  6.19.0-rc1 #1
[  123.207007] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  123.207012] task:umount          state:D stack:13096 pid:3611  tgid:3611  ppid:3590   task_flags:0x400100 flags:0x00080000
[  123.207036] Call Trace:
[  123.207041]  <TASK>
[  123.207055]  __schedule+0x5d4/0x1110
[  123.207088]  schedule+0x35/0x130
[  123.207102]  schedule_timeout+0xd1/0x120
[  123.207137]  __wait_for_common+0xbf/0x1f0
[  123.207150]  ? __pfx_schedule_timeout+0x10/0x10
[  123.207180]  synchronize_rcu_normal+0xf8/0x2c0
[  123.207220]  ? check_bytes_and_report+0x56/0x100
[  123.207234]  ? lock_acquire+0x284/0x2d0
[  123.207251]  ? lock_acquire+0x284/0x2d0
[  123.207266]  ? lock_release+0x204/0x2c0
[  123.207276]  ? lock_release+0x204/0x2c0
[  123.207297]  synchronize_rcu_expedited+0x31b/0x560
[  123.207313]  ? rt_mutex_slowunlock+0x3ca/0x430
[  123.207344]  namespace_unlock+0x285/0x370
[  123.207373]  path_umount+0x186/0x580
[  123.207401]  __x64_sys_umount+0x78/0x90
[  123.207420]  do_syscall_64+0xbd/0x430
[  123.207439]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  123.207638] RIP: 0033:0x7efdfcc7721d
[  123.207876] RSP: 002b:00007ffc3c2d3d00 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[  123.207916] RAX: ffffffffffffffda RBX: 00007efdfccf2dc0 RCX: 00007efdfcc7721d
[  123.207932] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007efdfccf29e0
[  123.207948] RBP: 00007efdfccf29f0 R08: 00007efdfccf29f0 R09: 0000000000000012
[  123.207963] R10: 00007efdfccf29fc R11: 0000000000000246 R12: 00007efdfccf2dc0
[  123.207977] R13: 00007efdfccf29e0 R14: 0000000000000000 R15: 00007ffc3c2d3e58
[  123.208037]  </TASK>
[  123.208106] INFO: lockdep is turned off.
[  153.413565] INFO: task pool_workqueue_:3 blocked for more than 60 seconds.
[  153.413607]       Tainted: G                 N  6.19.0-rc1 #1
[  153.413615] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  153.413621] task:pool_workqueue_ state:D stack:14744 pid:3     tgid:3     ppid:2      task_flags:0x208040 flags:0x00080000
[  153.413656] Call Trace:
[  153.413665]  <TASK>
[  153.413685]  __schedule+0x5d4/0x1110
[  153.413735]  schedule+0x35/0x130
[  153.413749]  schedule_timeout+0xd1/0x120
[  153.413785]  __wait_for_common+0xbf/0x1f0
[  153.413798]  ? __pfx_schedule_timeout+0x10/0x10
[  153.413829]  synchronize_rcu_normal+0xf8/0x2c0
[  153.413878]  ? _raw_spin_lock_irqsave+0x3f/0x60
[  153.413891]  ? lock_acquire+0x284/0x2d0
[  153.413904]  ? lock_acquire+0x284/0x2d0
[  153.413914]  ? lock_acquire+0x284/0x2d0
[  153.413923]  ? lock_release+0x204/0x2c0
[  153.413940]  synchronize_rcu_expedited+0x31b/0x560
[  153.413976]  pwq_release_workfn+0x1a6/0x270
[  153.413999]  ? kthread_worker_fn+0x47/0x340
[  153.414010]  ? __pfx_pwq_release_workfn+0x10/0x10
[  153.414022]  kthread_worker_fn+0xce/0x340
[  153.414037]  ? __pfx_kthread_worker_fn+0x10/0x10
[  153.414050]  kthread+0x108/0x230
[  153.414067]  ? __pfx_kthread+0x10/0x10
[  153.414087]  ret_from_fork+0x248/0x290
[  153.414100]  ? __pfx_kthread+0x10/0x10
[  153.414115]  ret_from_fork_asm+0x1a/0x30
[  153.414157]  </TASK>
[  153.414171] INFO: task rcub/0:19 blocked for more than 60 seconds.
[  153.414180]       Tainted: G                 N  6.19.0-rc1 #1
[  153.414187] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  153.414191] task:rcub/0          state:D stack:14376 pid:19    tgid:19    ppid:2      task_flags:0x208040 flags:0x00080000
[  153.414214] Call Trace:
[  153.414219]  <TASK>
[  153.414232]  __schedule+0x5d4/0x1110
[  153.414265]  rt_mutex_schedule+0x2e/0x50
[  153.414282]  rt_mutex_slowlock_block.constprop.0+0x1b8/0x350
[  153.414297]  ? lock_acquire+0x284/0x2d0
[  153.414316]  __rt_mutex_slowlock_locked.constprop.0+0x113/0x320
[  153.414357]  rt_mutex_slowlock.constprop.0+0x48/0xb0
[  153.414379]  rt_mutex_lock_nested+0x85/0xa0
[  153.414393]  ? rcu_boost_kthread+0x41/0x530
[  153.414405]  rcu_boost_kthread+0x14b/0x530
[  153.414422]  ? __pfx_rcu_boost_kthread+0x10/0x10
[  153.414580]  kthread+0x108/0x230
[  153.414606]  ? __pfx_kthread+0x10/0x10
[  153.414627]  ret_from_fork+0x248/0x290
[  153.414640]  ? __pfx_kthread+0x10/0x10
[  153.414655]  ret_from_fork_asm+0x1a/0x30
[  153.414696]  </TASK>
[  153.414765] INFO: task umount:3611 blocked for more than 60 seconds.
[  153.414776]       Tainted: G                 N  6.19.0-rc1 #1
[  153.414782] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  153.414787] task:umount          state:D stack:13096 pid:3611  tgid:3611  ppid:3590   task_flags:0x400100 flags:0x00080000
[  153.414811] Call Trace:
[  153.414816]  <TASK>
[  153.414830]  __schedule+0x5d4/0x1110
[  153.414864]  schedule+0x35/0x130
[  153.414878]  schedule_timeout+0xd1/0x120
[  153.414912]  __wait_for_common+0xbf/0x1f0
[  153.414926]  ? __pfx_schedule_timeout+0x10/0x10
[  153.414956]  synchronize_rcu_normal+0xf8/0x2c0
[  153.414996]  ? check_bytes_and_report+0x56/0x100
[  153.415010]  ? lock_acquire+0x284/0x2d0
[  153.415022]  ? lock_acquire+0x284/0x2d0
[  153.415035]  ? lock_release+0x204/0x2c0
[  153.415046]  ? lock_release+0x204/0x2c0
[  153.415067]  synchronize_rcu_expedited+0x31b/0x560
[  153.415083]  ? rt_mutex_slowunlock+0x3ca/0x430
[  153.415114]  namespace_unlock+0x285/0x370
[  153.415141]  path_umount+0x186/0x580
[  153.415169]  __x64_sys_umount+0x78/0x90
[  153.415188]  do_syscall_64+0xbd/0x430
[  153.415207]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  153.415221] RIP: 0033:0x7efdfcc7721d
[  153.415235] RSP: 002b:00007ffc3c2d3d00 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[  153.415247] RAX: ffffffffffffffda RBX: 00007efdfccf2dc0 RCX: 00007efdfcc7721d
[  153.415255] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007efdfccf29e0
[  153.415262] RBP: 00007efdfccf29f0 R08: 00007efdfccf29f0 R09: 0000000000000012
[  153.415269] R10: 00007efdfccf29fc R11: 0000000000000246 R12: 00007efdfccf2dc0
[  153.415275] R13: 00007efdfccf29e0 R14: 0000000000000000 R15: 00007ffc3c2d3e58
[  153.415313]  </TASK>
[  153.415324] INFO: lockdep is turned off.
[  170.893470] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  170.893501] rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-3): P3560/6:b..l
[  170.893534] rcu: 	(detected by 0, t=104007 jiffies, g=18041, q=1569 ncpus=4)
[  170.893549] task:irq/22-eth0     state:D stack:12048 pid:3560  tgid:3560  ppid:2      task_flags:0x4208040 flags:0x00080000
[  170.893582] Call Trace:
[  170.893592]  <TASK>
[  170.893612]  __schedule+0x5d4/0x1110
[  170.893661]  schedule_rtlock+0x1e/0x40
[  170.893676]  rtlock_slowlock_locked+0x61e/0x1bf0
[  170.893730]  rt_spin_lock+0x9b/0x1d0
[  170.893751]  ei_start_xmit+0x83/0x3b0
[  170.893789]  dev_hard_start_xmit+0x67/0x210
[  170.893814]  sch_direct_xmit+0x142/0x2b0
[  170.893839]  __dev_queue_xmit+0xfe6/0x15a0
[  170.893859]  ? lock_acquire+0xce/0x2d0
[  170.893872]  ? __neigh_update+0x310/0xfd0
[  170.893884]  ? find_held_lock+0x2b/0x80
[  170.893904]  ? mark_held_locks+0x40/0x70
[  170.893919]  ? eth_header+0x25/0xb0
[  170.893938]  ? __neigh_update+0x3e6/0xfd0
[  170.893952]  __neigh_update+0x310/0xfd0
[  170.893984]  arp_process+0x2e5/0xb50
[  170.894007]  ? process_backlog+0x25/0x2b0
[  170.894024]  ? rt_mutex_slowunlock+0x3ca/0x430
[  170.894044]  ? process_backlog+0x25/0x2b0
[  170.894055]  __netif_receive_skb_one_core+0x87/0x90
[  170.894074]  process_backlog+0x3c/0x2b0
[  170.894096]  __napi_poll.constprop.0+0x25/0x1b0
[  170.894115]  net_rx_action+0x308/0x410
[  170.894172]  handle_softirqs.isra.0+0xac/0x310
[  170.894199]  __local_bh_enable_ip+0xab/0x170
[  170.894214]  netif_rx+0x116/0x180
[  170.894228]  ei_receive+0x290/0x2f0
[  170.894253]  __ei_interrupt.isra.0+0x1d0/0x310
[  170.894275]  ? irq_thread+0xc1/0x2c0
[  170.894289]  irq_thread_fn+0x1e/0x60
[  170.894306]  irq_thread+0x1a3/0x2c0
[  170.894319]  ? __pfx_irq_thread_fn+0x10/0x10
[  170.894335]  ? __pfx_irq_thread_dtor+0x10/0x10
[  170.894353]  ? __pfx_irq_thread+0x10/0x10
[  170.894367]  kthread+0x108/0x230
[  170.894385]  ? __pfx_kthread+0x10/0x10
[  170.894405]  ret_from_fork+0x248/0x290
[  170.894418]  ? __pfx_kthread+0x10/0x10
[  170.894432]  ret_from_fork_asm+0x1a/0x30
[  170.894474]  </TASK>
[  183.621585] INFO: task pool_workqueue_:3 blocked for more than 90 seconds.
[  183.621630]       Tainted: G                 N  6.19.0-rc1 #1
[  183.621639] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  183.621645] task:pool_workqueue_ state:D stack:14744 pid:3     tgid:3     ppid:2      task_flags:0x208040 flags:0x00080000
[  183.621688] Call Trace:
[  183.621697]  <TASK>
[  183.621721]  __schedule+0x5d4/0x1110
[  183.621770]  schedule+0x35/0x130
[  183.621785]  schedule_timeout+0xd1/0x120
[  183.621820]  __wait_for_common+0xbf/0x1f0
[  183.621833]  ? __pfx_schedule_timeout+0x10/0x10
[  183.621864]  synchronize_rcu_normal+0xf8/0x2c0
[  183.621913]  ? _raw_spin_lock_irqsave+0x3f/0x60
[  183.621925]  ? lock_acquire+0x284/0x2d0
[  183.621939]  ? lock_acquire+0x284/0x2d0
[  183.621948]  ? lock_acquire+0x284/0x2d0
[  183.621957]  ? lock_release+0x204/0x2c0
[  183.621974]  synchronize_rcu_expedited+0x31b/0x560
[  183.622009]  pwq_release_workfn+0x1a6/0x270
[  183.622032]  ? kthread_worker_fn+0x47/0x340
[  183.622043]  ? __pfx_pwq_release_workfn+0x10/0x10
[  183.622054]  kthread_worker_fn+0xce/0x340
[  183.622070]  ? __pfx_kthread_worker_fn+0x10/0x10
[  183.622082]  kthread+0x108/0x230
[  183.622100]  ? __pfx_kthread+0x10/0x10
[  183.622119]  ret_from_fork+0x248/0x290
[  183.622132]  ? __pfx_kthread+0x10/0x10
[  183.622147]  ret_from_fork_asm+0x1a/0x30
[  183.622189]  </TASK>
[  183.622203] INFO: task rcub/0:19 blocked for more than 90 seconds.
[  183.622212]       Tainted: G                 N  6.19.0-rc1 #1
[  183.622218] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  183.622223] task:rcub/0          state:D stack:14376 pid:19    tgid:19    ppid:2      task_flags:0x208040 flags:0x00080000
[  183.622246] Call Trace:
[  183.622250]  <TASK>
[  183.622264]  __schedule+0x5d4/0x1110
[  183.622296]  rt_mutex_schedule+0x2e/0x50
[  183.622312]  rt_mutex_slowlock_block.constprop.0+0x1b8/0x350
[  183.622327]  ? lock_acquire+0x284/0x2d0
[  183.622345]  __rt_mutex_slowlock_locked.constprop.0+0x113/0x320
[  183.622386]  rt_mutex_slowlock.constprop.0+0x48/0xb0
[  183.622408]  rt_mutex_lock_nested+0x85/0xa0
[  183.622422]  ? rcu_boost_kthread+0x41/0x530
[  183.622568]  rcu_boost_kthread+0x14b/0x530
[  183.622592]  ? __pfx_rcu_boost_kthread+0x10/0x10
[  183.622608]  kthread+0x108/0x230
[  183.622626]  ? __pfx_kthread+0x10/0x10
[  183.622645]  ret_from_fork+0x248/0x290
[  183.622662]  ? __pfx_kthread+0x10/0x10
[  183.622677]  ret_from_fork_asm+0x1a/0x30
[  183.622717]  </TASK>
[  183.622785] INFO: task umount:3611 blocked for more than 90 seconds.
[  183.622796]       Tainted: G                 N  6.19.0-rc1 #1
[  183.622802] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  183.622807] task:umount          state:D stack:13096 pid:3611  tgid:3611  ppid:3590   task_flags:0x400100 flags:0x00080000
[  183.622830] Call Trace:
[  183.622835]  <TASK>
[  183.622849]  __schedule+0x5d4/0x1110
[  183.622882]  schedule+0x35/0x130
[  183.622896]  schedule_timeout+0xd1/0x120
[  183.622930]  __wait_for_common+0xbf/0x1f0
[  183.622943]  ? __pfx_schedule_timeout+0x10/0x10
[  183.622973]  synchronize_rcu_normal+0xf8/0x2c0
[  183.623012]  ? check_bytes_and_report+0x56/0x100
[  183.623026]  ? lock_acquire+0x284/0x2d0
[  183.623037]  ? lock_acquire+0x284/0x2d0
[  183.623051]  ? lock_release+0x204/0x2c0
[  183.623061]  ? lock_release+0x204/0x2c0
[  183.623081]  synchronize_rcu_expedited+0x31b/0x560
[  183.623098]  ? rt_mutex_slowunlock+0x3ca/0x430
[  183.623128]  namespace_unlock+0x285/0x370
[  183.623155]  path_umount+0x186/0x580
[  183.623183]  __x64_sys_umount+0x78/0x90
[  183.623201]  do_syscall_64+0xbd/0x430
[  183.623221]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  183.623235] RIP: 0033:0x7efdfcc7721d
[  183.623248] RSP: 002b:00007ffc3c2d3d00 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[  183.623260] RAX: ffffffffffffffda RBX: 00007efdfccf2dc0 RCX: 00007efdfcc7721d
[  183.623267] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007efdfccf29e0
[  183.623273] RBP: 00007efdfccf29f0 R08: 00007efdfccf29f0 R09: 0000000000000012
[  183.623280] R10: 00007efdfccf29fc R11: 0000000000000246 R12: 00007efdfccf2dc0
[  183.623287] R13: 00007efdfccf29e0 R14: 0000000000000000 R15: 00007ffc3c2d3e58
[  183.623324]  </TASK>
[  183.623336] INFO: lockdep is turned off.
[  213.829537] INFO: task pool_workqueue_:3 blocked for more than 120 seconds.
[  213.829581]       Tainted: G                 N  6.19.0-rc1 #1
[  213.829589] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  213.829595] task:pool_workqueue_ state:D stack:14744 pid:3     tgid:3     ppid:2      task_flags:0x208040 flags:0x00080000
[  213.829631] Call Trace:
[  213.829641]  <TASK>
[  213.829664]  __schedule+0x5d4/0x1110
[  213.829715]  schedule+0x35/0x130
[  213.829730]  schedule_timeout+0xd1/0x120
[  213.829765]  __wait_for_common+0xbf/0x1f0
[  213.829787]  ? __pfx_schedule_timeout+0x10/0x10
[  213.829819]  synchronize_rcu_normal+0xf8/0x2c0
[  213.829875]  ? _raw_spin_lock_irqsave+0x3f/0x60
[  213.829890]  ? lock_acquire+0x284/0x2d0
[  213.829903]  ? lock_acquire+0x284/0x2d0
[  213.829913]  ? lock_acquire+0x284/0x2d0
[  213.829922]  ? lock_release+0x204/0x2c0
[  213.829940]  synchronize_rcu_expedited+0x31b/0x560
[  213.829976]  pwq_release_workfn+0x1a6/0x270
[  213.830000]  ? kthread_worker_fn+0x47/0x340
[  213.830010]  ? __pfx_pwq_release_workfn+0x10/0x10
[  213.830023]  kthread_worker_fn+0xce/0x340
[  213.830038]  ? __pfx_kthread_worker_fn+0x10/0x10
[  213.830052]  kthread+0x108/0x230
[  213.830070]  ? __pfx_kthread+0x10/0x10
[  213.830089]  ret_from_fork+0x248/0x290
[  213.830104]  ? __pfx_kthread+0x10/0x10
[  213.830119]  ret_from_fork_asm+0x1a/0x30
[  213.830161]  </TASK>
[  213.830195] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
[  213.830291] INFO: lockdep is turned off.
[  248.899451] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  248.899481] rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-3): P3560/6:b..l
[  248.899513] rcu: 	(detected by 2, t=182013 jiffies, g=18041, q=1569 ncpus=4)
[  248.899528] task:irq/22-eth0     state:D stack:12048 pid:3560  tgid:3560  ppid:2      task_flags:0x4208040 flags:0x00080000
[  248.899556] Call Trace:
[  248.899565]  <TASK>
[  248.899588]  __schedule+0x5d4/0x1110
[  248.899638]  schedule_rtlock+0x1e/0x40
[  248.899653]  rtlock_slowlock_locked+0x61e/0x1bf0
[  248.899708]  rt_spin_lock+0x9b/0x1d0
[  248.899730]  ei_start_xmit+0x83/0x3b0
[  248.899769]  dev_hard_start_xmit+0x67/0x210
[  248.899794]  sch_direct_xmit+0x142/0x2b0
[  248.899820]  __dev_queue_xmit+0xfe6/0x15a0
[  248.899840]  ? lock_acquire+0xce/0x2d0
[  248.899854]  ? __neigh_update+0x310/0xfd0
[  248.899867]  ? find_held_lock+0x2b/0x80
[  248.899887]  ? mark_held_locks+0x40/0x70
[  248.899903]  ? eth_header+0x25/0xb0
[  248.899922]  ? __neigh_update+0x3e6/0xfd0
[  248.899937]  __neigh_update+0x310/0xfd0
[  248.899970]  arp_process+0x2e5/0xb50
[  248.899994]  ? process_backlog+0x25/0x2b0
[  248.900012]  ? rt_mutex_slowunlock+0x3ca/0x430
[  248.900032]  ? process_backlog+0x25/0x2b0
[  248.900043]  __netif_receive_skb_one_core+0x87/0x90
[  248.900062]  process_backlog+0x3c/0x2b0
[  248.900091]  __napi_poll.constprop.0+0x25/0x1b0
[  248.900110]  net_rx_action+0x308/0x410
[  248.900168]  handle_softirqs.isra.0+0xac/0x310
[  248.900197]  __local_bh_enable_ip+0xab/0x170
[  248.900213]  netif_rx+0x116/0x180
[  248.900227]  ei_receive+0x290/0x2f0
[  248.900253]  __ei_interrupt.isra.0+0x1d0/0x310
[  248.900276]  ? irq_thread+0xc1/0x2c0
[  248.900289]  irq_thread_fn+0x1e/0x60
[  248.900306]  irq_thread+0x1a3/0x2c0
[  248.900320]  ? __pfx_irq_thread_fn+0x10/0x10
[  248.900336]  ? __pfx_irq_thread_dtor+0x10/0x10
[  248.900355]  ? __pfx_irq_thread+0x10/0x10
[  248.900369]  kthread+0x108/0x230
[  248.900388]  ? __pfx_kthread+0x10/0x10
[  248.900407]  ret_from_fork+0x248/0x290
[  248.900420]  ? __pfx_kthread+0x10/0x10
[  248.900435]  ret_from_fork_asm+0x1a/0x30
[  248.900478]  </TASK>
qemu-system-x86_64: terminating on signal 15 from pid 1344874 (/bin/bash)

---
bisect:

# bad: [559e608c46553c107dbba19dae0854af7b219400] Merge tag 'ntfs3_for_6.19' of https://github.com/Paragon-Software-Group/linux-ntfs3
# good: [7d0a66e4bb9081d75c82ec4957c50034cb0ea449] Linux 6.18
git bisect start '559e608c4655' 'v6.18'
# bad: [015e7b0b0e8e51f7321ec2aafc1d7fc0a8a5536f] Merge tag 'bpf-next-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
git bisect bad 015e7b0b0e8e51f7321ec2aafc1d7fc0a8a5536f
# bad: [2547f79b0b0cd969ae6f736890af4ebd9368cda5] Merge tag 's390-6.19-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
git bisect bad 2547f79b0b0cd969ae6f736890af4ebd9368cda5
# good: [63e6995005be8ceb8a1d56a18df1a1a40c28356d] Merge tag 'objtool-core-2025-12-01' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 63e6995005be8ceb8a1d56a18df1a1a40c28356d
# bad: [15b87bec89cb227b55b3689bf5de31b85cf88559] Merge tag 'irq-drivers-2025-11-30' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 15b87bec89cb227b55b3689bf5de31b85cf88559
# good: [4a26e7032d7d57c998598c08a034872d6f0d3945] Merge tag 'core-bugs-2025-12-01' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 4a26e7032d7d57c998598c08a034872d6f0d3945
# good: [2b09f480f0a1e68111ae36a7be9aa1c93e067255] Merge tag 'core-rseq-2025-11-30' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 2b09f480f0a1e68111ae36a7be9aa1c93e067255
# bad: [3de5e46e50abc01a1cee7e12b657e083fc5ed638] genirq: Remove cpumask availability check on kthread affinity setting
git bisect bad 3de5e46e50abc01a1cee7e12b657e083fc5ed638
# good: [bdf4e2ac295fe77c94b570a1ad12c0882bc89b53] genirq: Allow per-cpu interrupt sharing for non-overlapping affinities
git bisect good bdf4e2ac295fe77c94b570a1ad12c0882bc89b53
# good: [ee2d50a9f524ae829d1a8ec296d7a0170e7b8ade] genirq: Kill irq_{g,s}et_percpu_devid_partition()
git bisect good ee2d50a9f524ae829d1a8ec296d7a0170e7b8ade
# good: [9ea2b810d51ae662cc5b5578f9395cb620a34a26] genirq/proc: Fix race in show_irq_affinity()
git bisect good 9ea2b810d51ae662cc5b5578f9395cb620a34a26
# good: [9d3faec60b1303fbec53d7a9b48a8c0fc5ae029b] genirq: Use raw_spinlock_irq() in irq_set_affinity_notifier()
git bisect good 9d3faec60b1303fbec53d7a9b48a8c0fc5ae029b
# bad: [801afdfbfcd90ff62a4b2469bbda1d958f7a5353] genirq: Fix interrupt threads affinity vs. cpuset isolated partitions
git bisect bad 801afdfbfcd90ff62a4b2469bbda1d958f7a5353
# good: [68775ca79af3b8d4c147598983ece012d7007bac] genirq: Prevent early spurious wake-ups of interrupt threads
git bisect good 68775ca79af3b8d4c147598983ece012d7007bac
# first bad commit: [801afdfbfcd90ff62a4b2469bbda1d958f7a5353] genirq: Fix interrupt threads affinity vs. cpuset isolated partitions

