Return-Path: <cgroups+bounces-7520-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA112A88A05
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 19:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCB717C781
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 17:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783EE28A1E8;
	Mon, 14 Apr 2025 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PpARBoJD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D6228A1E6
	for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652412; cv=none; b=XXMsEKcoREn6DDpiOklDxEYYvavYVvKCMk5RPvDLCjfsyZXqZSMvxIvvGkbDLxNrdCmFl1Z1SILbB0Y4qtJUcO2+g1CeU0Yve8kzWm6+/KN6dYjyprCTUjV0U8sTdqEJyZRUG9/7VluNH47ZothwxuxE/i4saMetNJ7oglwdyXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652412; c=relaxed/simple;
	bh=el+EWGVVVlsSPiNWhUCmSngU5ZjP56e6V/sY+ghs8Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9+PjadbEAYEwMbiG0NpTZSM0Xa+7bbiFaulkqWo06Aapw4cswbR0ZxE30weKCA+E8YZCCluLrIF2rvBaz+ri/cdYhZ0AwGGEnpSvrMx2+Whe/mIbE5p/B4Bc6kVOFzL1sUxJ2294RK6YwyBWvOfehvlxK/F0XasTdoW8zyI4zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PpARBoJD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so31867095e9.0
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744652407; x=1745257207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LuUfucCgJFwoqNT6wjM/MRaneZkQpA3bt6ajps/e51Y=;
        b=PpARBoJDxrzNgZ1mlMoTV5hhV3WQLEHCztv9+oQDcUtt757hBJyU2HQA9lK/jNMH/w
         4Bu1nZpQYOmwJBRp8BcI47N0qS4bfm+jnZbFyi5cxin2SfSpXFF3EIHe+CsgvpokNoXG
         O232lbf4blBZOi4BCPXS381y/6gfaDWK3hq0tV152P7/USNDAH4AsiE+n8DKqfd/sWLw
         6bHHuI3dChle8okAk1y0kbilS0kr11ZJk2+Qcxk5mErMZVPdhyTy8gsSmxcxPxvL6WJW
         Z0v7wys9Br8rkYo7Curz9MflQJmyyM7zs3kUeu290zQo5L7c63WHNLgUeJGxm347UgwY
         Yp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744652407; x=1745257207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuUfucCgJFwoqNT6wjM/MRaneZkQpA3bt6ajps/e51Y=;
        b=Inwwj3EI1TKY7bjvMssZSgJUXzeRMbQqjtXDNyezWm70CjvqumZmUTmjnIgHgyZ3Ls
         QpRaKXLzWiN4LKLyXK11NgtMPUHVz/D6j5eta7eycPM8iJ3QWyBBo080FW/hfNUhAzud
         fd2sKoBg1w58+8JHAQxdc0zXI6TbvlkIaJBMNL7M0e5p/GhcuORkOykK38df3YOYV4Gi
         1N7sFMzZ3/9QYe1FnCj5g1nS5M4TYIzB6HHBucp1RVM0FyO67i6b2L7jdgl+cMRO+n8z
         gSb5hXSrLnMlqOTDA1schwx1ykshJsXebp+e1Vswh07CKZf6OPRPF2tTENZXAzltivSQ
         6Lpg==
X-Forwarded-Encrypted: i=1; AJvYcCW4SkGQrQMXA4NaTJwYmb6dU9MB/Z7XYcj2sP2AGI9SNfGa7atnvTzCycAYlxWIB+S4T/64Rhux@vger.kernel.org
X-Gm-Message-State: AOJu0YzE3Chjo+QyKT1vG8JYOIPzaJD9E5Y1eHDEigkwh34Ijq71bRMr
	XsfiQPklKDNla9wQKYDU0tyFsTBvizKxHD9du62xdj0XfvTTxh6YFaLOrVvsq5A=
X-Gm-Gg: ASbGncvyEMfsQAUHEr+bqL4z2J8HNgeoR66m3ghFcMrgpZXSFzv949QLz26G30eA3qA
	QkYF7d3F0h21cLXw/Zrs5DCGp/2FikNqH/fGRtUuq3pY8nZ9xqfnYMZoCEX4H2M7A8dCoLPJrkZ
	yZKvD/75B9IUhTBLiysE3QI2SZZWeGQL3yuz+98SqliYfGNICWyANBf4/w/U1hz05dsz7BJVhZg
	C6hIkFOko8bhh2JAWzxI2Rtm9e9vT6irTvBbJz8aWQMLxoRrlNVB5jJgMqa5ZdApyyAauGVjSg/
	sjR8Mr6jcVd18DOhY4D8iXQYLVm4v4zuY50HYlGad/Y=
X-Google-Smtp-Source: AGHT+IHePyx0eAm2A7l1OCIwA1D5BItv3vcMzxmiSG50uj3BVszCc2LCGkd+UlJqolWJoxB5fBZwZA==
X-Received: by 2002:a05:600c:500e:b0:43d:7588:667b with SMTP id 5b1f17b1804b1-43f3a93ca20mr141092925e9.10.1744652407136;
        Mon, 14 Apr 2025 10:40:07 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c49f7sm180610845e9.17.2025.04.14.10.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 10:40:06 -0700 (PDT)
Date: Mon, 14 Apr 2025 19:40:04 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: ffhgfv <xnxc22xnxc22@qq.com>
Cc: tj <tj@kernel.org>, hannes <hannes@cmpxchg.org>, 
	cgroups <cgroups@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: KASAN: slab-use-after-free Read in cgroup_rstat_flush
Message-ID: <djupj4qfnd2izxhtzkmmhx6bfmnn3462dqi45qwbmdj46twart@424eqzhhh2s3>
References: <tencent_084EDA1878C098FFB951DC70F6FFCC896408@qq.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ic7eei2twj4wpn3i"
Content-Disposition: inline
In-Reply-To: <tencent_084EDA1878C098FFB951DC70F6FFCC896408@qq.com>


--ic7eei2twj4wpn3i
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: KASAN: slab-use-after-free Read in cgroup_rstat_flush
MIME-Version: 1.0

Hello.

On Mon, Apr 07, 2025 at 07:59:58AM -0400, ffhgfv <xnxc22xnxc22@qq.com> wrot=
e:
> Hello, I found a bug titled "   KASAN: slab-use-after-free Read in cgroup=
_rstat_flush " with modified syzkaller in the Linux6.14.
> If you fix this issue, please add the following tag to the commit:  Repor=
ted-by: Jianzhou Zhao <xnxc22xnxc22@qq.com>,    xingwei lee <xrivendell7@gm=
ail.com>,Penglei Jiang <superman.xpt@gmail.com>
> I use the same kernel as syzbot instance upstream: f6e0150b2003fb2b926502=
8a618aa1732b3edc8f
> kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&amp;=
x=3Dda4b04ae798b7ef6
> compiler: gcc version 11.4.0
>=20
> Unfortunately, we do not have a repro.

Thanks for sharing the report.

> ------------[ cut here ]-----------------------------------------
>  TITLE:  KASAN: slab-use-after-free Read in cgroup_rstat_flush
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> bridge_slave_0: left allmulticast mode
> bridge_slave_0: left promiscuous mode
> bridge0: port 1(bridge_slave_0) entered disabled state
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in cgroup_rstat_cpu kernel/cgroup/rstat.c=
:19 [inline]
> BUG: KASAN: slab-use-after-free in cgroup_base_stat_flush kernel/cgroup/r=
stat.c:422 [inline]
> BUG: KASAN: slab-use-after-free in cgroup_rstat_flush+0x16ce/0x2180 kerne=
l/cgroup/rstat.c:328

I read this like the struct cgroup is gone when the code try flushing
its respective stats (its ->rstat_cpu more precisely).

Namely,
	__mem_cgroup_flush_stats
		cgroup_rstat_flush(memcg->css.cgroup);
this reference is taken at cgroup creation in init_and_link_css()
and released only in css_free_rwork_fn().

> Read of size 8 at addr ffff888044f1a580 by task kworker/u8:3/10725
>=20
> CPU: 0 UID: 0 PID: 10725 Comm: kworker/u8:3 Not tainted 6.14.0-03565-gf6e=
0150b2003-dirty #3 PREEMPT(full)=20
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> Workqueue: netns cleanup_net
> Call Trace:
>  <task>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:408 [inline]
>  print_report+0xc1/0x630 mm/kasan/report.c:521
>  kasan_report+0xca/0x100 mm/kasan/report.c:634
>  cgroup_rstat_cpu kernel/cgroup/rstat.c:19 [inline]
>  cgroup_base_stat_flush kernel/cgroup/rstat.c:422 [inline]
>  cgroup_rstat_flush+0x16ce/0x2180 kernel/cgroup/rstat.c:328
>  zswap_shrinker_count+0x280/0x570 mm/zswap.c:1272
>  do_shrink_slab+0x80/0x1170 mm/shrinker.c:384
>  shrink_slab+0x33d/0x12c0 mm/shrinker.c:664
>  shrink_one+0x4a8/0x7c0 mm/vmscan.c:4868
>  shrink_many mm/vmscan.c:4929 [inline]


I'm looking at this:

        rcu_read_lock();

        hlist_nulls_for_each_entry_rcu(lrugen, pos, &pgdat->memcg_lru.fifo[=
gen][bin], list) {
                ...

                mem_cgroup_put(memcg);
                memcg =3D NULL;

                if (gen !=3D READ_ONCE(lrugen->gen))
                        continue;

                lruvec =3D container_of(lrugen, struct lruvec, lrugen);
                memcg =3D lruvec_memcg(lruvec);

                if (!mem_cgroup_tryget(memcg)) {
                        lru_gen_release_memcg(memcg);
                        memcg =3D NULL;
                        continue;
                }

                rcu_read_unlock();

                op =3D shrink_one(lruvec, sc);

where shrink_one() may get a dead reference to memcg (where
shrink_slab_memcg() bails out when it's not online) but it's still _a_
reference, so css_free_rwork_fn() should not be executed yet.
And despite some indirections, the references of a chosen memcg seem
well-paired in shrink_many to me.

Then, I'm not so familiar with MGLRU to be able to tell whether
lrugens/memcgs are always properly referenced when stored into
pgdat->memcg_lru.fifo[gen][bin] (I Cc linux-mm). That'd be where I'd
look next...

>  lru_gen_shrink_node mm/vmscan.c:5007 [inline]
>  shrink_node+0x2687/0x3dc0 mm/vmscan.c:5978
>  shrink_zones mm/vmscan.c:6237 [inline]
>  do_try_to_free_pages+0x377/0x19b0 mm/vmscan.c:6299
>  try_to_free_pages+0x2a1/0x690 mm/vmscan.c:6549
>  __perform_reclaim mm/page_alloc.c:3929 [inline]
>  __alloc_pages_direct_reclaim mm/page_alloc.c:3951 [inline]
>  __alloc_pages_slowpath mm/page_alloc.c:4383 [inline]
>  __alloc_frozen_pages_noprof+0xaca/0x2200 mm/page_alloc.c:4753
>  alloc_pages_mpol+0x1f1/0x540 mm/mempolicy.c:2301
>  alloc_slab_page mm/slub.c:2446 [inline]
>  allocate_slab mm/slub.c:2610 [inline]
>  new_slab+0x242/0x340 mm/slub.c:2663
>  ___slab_alloc+0xb5f/0x1730 mm/slub.c:3849
>  __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3939
>  __slab_alloc_node mm/slub.c:4014 [inline]
>  slab_alloc_node mm/slub.c:4175 [inline]
>  __kmalloc_cache_noprof+0x272/0x3f0 mm/slub.c:4344
>  kmalloc_noprof include/linux/slab.h:902 [inline]
>  netdevice_queue_work drivers/infiniband/core/roce_gid_mgmt.c:664 [inline]
>  netdevice_event+0x36b/0x9e0 drivers/infiniband/core/roce_gid_mgmt.c:823
>  notifier_call_chain+0xb9/0x420 kernel/notifier.c:85
>  call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2206
>  __netdev_upper_dev_unlink+0x14c/0x430 net/core/dev.c:8459
>  netdev_upper_dev_unlink+0x7f/0xb0 net/core/dev.c:8486
>  del_nbp+0x70d/0xd20 net/bridge/br_if.c:363
>  br_dev_delete+0x99/0x1a0 net/bridge/br_if.c:386
>  br_net_exit_batch_rtnl+0x116/0x1f0 net/bridge/br.c:376
>  cleanup_net+0x551/0xb80 net/core/net_namespace.c:645
>  process_one_work+0x9f9/0x1bd0 kernel/workqueue.c:3245
>  process_scheduled_works kernel/workqueue.c:3329 [inline]
>  worker_thread+0x674/0xe70 kernel/workqueue.c:3410
>  kthread+0x3af/0x760 kernel/kthread.c:464
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </task>
>=20
> Allocated by task 1:
>  kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>  __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
>  kasan_kmalloc include/linux/kasan.h:260 [inline]
>  __do_kmalloc_node mm/slub.c:4318 [inline]
>  __kmalloc_noprof+0x219/0x540 mm/slub.c:4330
>  kmalloc_noprof include/linux/slab.h:906 [inline]
>  kzalloc_noprof include/linux/slab.h:1036 [inline]
>  cgroup_create kernel/cgroup/cgroup.c:5677 [inline]
>  cgroup_mkdir+0x254/0x10d0 kernel/cgroup/cgroup.c:5827
>  kernfs_iop_mkdir+0x15a/0x1f0 fs/kernfs/dir.c:1247
>  vfs_mkdir+0x593/0x8d0 fs/namei.c:4324
>  do_mkdirat+0x2dc/0x3d0 fs/namei.c:4357
>  __do_sys_mkdir fs/namei.c:4379 [inline]
>  __se_sys_mkdir fs/namei.c:4377 [inline]
>  __x64_sys_mkdir+0xf3/0x140 fs/namei.c:4377
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcb/0x250 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Freed by task 12064:
>  kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
>  poison_slab_object mm/kasan/common.c:247 [inline]
>  __kasan_slab_free+0x54/0x70 mm/kasan/common.c:264
>  kasan_slab_free include/linux/kasan.h:233 [inline]
>  slab_free_hook mm/slub.c:2376 [inline]
>  slab_free mm/slub.c:4633 [inline]
>  kfree+0x148/0x4d0 mm/slub.c:4832
>  css_free_rwork_fn+0x58f/0x1250 kernel/cgroup/cgroup.c:5435
>  process_one_work+0x9f9/0x1bd0 kernel/workqueue.c:3245
>  process_scheduled_works kernel/workqueue.c:3329 [inline]
>  worker_thread+0x674/0xe70 kernel/workqueue.c:3410
>  kthread+0x3af/0x760 kernel/kthread.c:464
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>=20
> Last potentially related work creation:
>  kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
>  kasan_record_aux_stack+0xb8/0xd0 mm/kasan/generic.c:548
>  insert_work+0x36/0x230 kernel/workqueue.c:2183
>  __queue_work+0x9d1/0x1110 kernel/workqueue.c:2344
>  rcu_work_rcufn+0x5c/0x90 kernel/workqueue.c:2613
>  rcu_do_batch kernel/rcu/tree.c:2568 [inline]
>  rcu_core+0x79e/0x14f0 kernel/rcu/tree.c:2824
>  handle_softirqs+0x1d1/0x870 kernel/softirq.c:561
>  __do_softirq kernel/softirq.c:595 [inline]
>  invoke_softirq kernel/softirq.c:435 [inline]
>  __irq_exit_rcu+0x109/0x170 kernel/softirq.c:662
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inli=
ne]
>  sysvec_apic_timer_interrupt+0xa8/0xc0 arch/x86/kernel/apic/apic.c:1049
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.=
h:702
>=20
> Second to last potentially related work creation:
>  kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
>  kasan_record_aux_stack+0xb8/0xd0 mm/kasan/generic.c:548
>  __call_rcu_common.constprop.0+0x99/0x9e0 kernel/rcu/tree.c:3082
>  call_rcu_hurry include/linux/rcupdate.h:115 [inline]
>  queue_rcu_work+0xa9/0xe0 kernel/workqueue.c:2638
>  process_one_work+0x9f9/0x1bd0 kernel/workqueue.c:3245
>  process_scheduled_works kernel/workqueue.c:3329 [inline]
>  worker_thread+0x674/0xe70 kernel/workqueue.c:3410
>  kthread+0x3af/0x760 kernel/kthread.c:464
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>=20
> The buggy address belongs to the object at ffff888044f1a000
>  which belongs to the cache kmalloc-4k of size 4096
> The buggy address is located 1408 bytes inside of
>  freed 4096-byte region [ffff888044f1a000, ffff888044f1b000)
>=20
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x44f18
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> anon flags: 0x4fff00000000040(head|node=3D1|zone=3D1|lastcpupid=3D0x7ff)
> page_type: f5(slab)
> raw: 04fff00000000040 ffff88801b042140 0000000000000000 dead000000000001
> raw: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
> head: 04fff00000000040 ffff88801b042140 0000000000000000 dead000000000001
> head: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
> head: 04fff00000000003 ffffea000113c601 ffffffffffffffff 0000000000000000
> head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(=
__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tg=
id 1 (systemd), ts 113702677351, free_ts 113428419852
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x193/0x1c0 mm/page_alloc.c:1551
>  prep_new_page mm/page_alloc.c:1559 [inline]
>  get_page_from_freelist+0xe41/0x2b40 mm/page_alloc.c:3477
>  __alloc_frozen_pages_noprof+0x21b/0x2200 mm/page_alloc.c:4740
>  alloc_pages_mpol+0x1f1/0x540 mm/mempolicy.c:2301
>  alloc_slab_page mm/slub.c:2446 [inline]
>  allocate_slab mm/slub.c:2610 [inline]
>  new_slab+0x242/0x340 mm/slub.c:2663
>  ___slab_alloc+0xb5f/0x1730 mm/slub.c:3849
>  __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3939
>  __slab_alloc_node mm/slub.c:4014 [inline]
>  slab_alloc_node mm/slub.c:4175 [inline]
>  __do_kmalloc_node mm/slub.c:4317 [inline]
>  __kmalloc_noprof+0x2b2/0x540 mm/slub.c:4330
>  kmalloc_noprof include/linux/slab.h:906 [inline]
>  tomoyo_realpath_from_path+0xc3/0x600 security/tomoyo/realpath.c:251
>  tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
>  tomoyo_check_open_permission+0x298/0x3a0 security/tomoyo/file.c:771
>  tomoyo_file_open+0x69/0x90 security/tomoyo/tomoyo.c:334
>  security_file_open+0x88/0x200 security/security.c:3114
>  do_dentry_open+0x575/0x1c20 fs/open.c:933
>  vfs_open+0x82/0x3f0 fs/open.c:1086
>  do_open fs/namei.c:3845 [inline]
>  path_openat+0x1d53/0x2960 fs/namei.c:4004
>  do_filp_open+0x1f7/0x460 fs/namei.c:4031
> page last free pid 1 tgid 1 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1127 [inline]
>  free_frozen_pages+0x719/0xfe0 mm/page_alloc.c:2660
>  discard_slab mm/slub.c:2707 [inline]
>  __put_partials+0x176/0x1d0 mm/slub.c:3176
>  qlink_free mm/kasan/quarantine.c:163 [inline]
>  qlist_free_all+0x50/0x120 mm/kasan/quarantine.c:179
>  kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
>  __kasan_slab_alloc+0x67/0x90 mm/kasan/common.c:329
>  kasan_slab_alloc include/linux/kasan.h:250 [inline]
>  slab_post_alloc_hook mm/slub.c:4138 [inline]
>  slab_alloc_node mm/slub.c:4187 [inline]
>  kmem_cache_alloc_noprof+0x160/0x3e0 mm/slub.c:4194
>  getname_flags.part.0+0x48/0x540 fs/namei.c:146
>  getname_flags+0x95/0xe0 include/linux/audit.h:322
>  user_path_at+0x27/0x90 fs/namei.c:3084
>  __do_sys_chdir fs/open.c:557 [inline]
>  __se_sys_chdir fs/open.c:551 [inline]
>  __x64_sys_chdir+0xb6/0x260 fs/open.c:551
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcb/0x250 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Memory state around the buggy address:
>  ffff888044f1a480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888044f1a500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> &gt;ffff888044f1a580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                    ^
>  ffff888044f1a600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888044f1a680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20
> I hope it helps.
> Best regards
> Jianzhou Zhao</superman.xpt@gmail.com></xrivendell7@gmail.com></xnxc22xnx=
c22@qq.com>


Michal

--ic7eei2twj4wpn3i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ/1IcgAKCRAt3Wney77B
SVgxAP95Bic3bjP3xKnjfkPQwkq2vqZwyNfzfrNZztv2DR2c5QEAjH73Lv2/Qw3L
6boTz6ldRv49YzaCmquRungdfNIrDgw=
=mkIp
-----END PGP SIGNATURE-----

--ic7eei2twj4wpn3i--

