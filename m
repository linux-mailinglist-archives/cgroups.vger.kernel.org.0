Return-Path: <cgroups+bounces-13593-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LcFNO9BgGmK5QIAu9opvQ
	(envelope-from <cgroups+bounces-13593-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 07:19:27 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B44C896A
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 07:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1430B300147D
	for <lists+cgroups@lfdr.de>; Mon,  2 Feb 2026 06:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630452F60CC;
	Mon,  2 Feb 2026 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIt1CXk3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F63E2EB856
	for <cgroups@vger.kernel.org>; Mon,  2 Feb 2026 06:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770013161; cv=pass; b=Nw0fSXTqSLLozEjTGuE2sVqh1JG7bhLTpxrNhrX59DAUc9pu+h7X2rDVxFXfBOZijOjD0iu+m/cL7JpeQgwFAd/cBW03NOFaQthZ4yyEKm/R3h75voOHRMmzc11Hnp7O/TkHrgzP6yXQU8Q+5GrwzzPn/CwYQ3sQ3cOHIcAjFZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770013161; c=relaxed/simple;
	bh=wNZUeUR4EcH2QbiSSP259OGXLjyowXIrxL7tJ4WRZpo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LDG5vd1vZFKY+uwa+g/2ElHCjn3Q+7X3YEmkHyja5+shmgE4P4KNMxIISdwwbNITQltlZxJyUTz0IQmtgD0qCgYD6Nci3Yg6BHIDJGpkzU/R+KaGn3s27nWBbSnezL1DYIm7+K23ixNYqKivSqD9UyxAdmQF9Pbj6SVzNNip8Q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIt1CXk3; arc=pass smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-88a35a00506so75193156d6.2
        for <cgroups@vger.kernel.org>; Sun, 01 Feb 2026 22:19:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770013158; cv=none;
        d=google.com; s=arc-20240605;
        b=WJ7rX6IxSdpjUiL2xeoQRk8lKgZWeZhFh0S9rXdzFL4mbq2eDBnoBjsoNvmj1jWMfF
         CKYMbOP6zvCX0fsAzNkDpdrFdPOaaLPDDb0s6TREvJz/P9SLyAXJAgUGul//48zKLZ54
         h3Y4WXtmAVWuhLzsmZVm4ub+4VnprowBnQjtq7kvF/RlI0sDkctoUurNl1Xoc71Frxf3
         tlTK5FE8UJKZvWCxABhq4tZf0Kx0+Ayr2+5CUs1oB5+0spVExK94NAtwrt4ep1Qfeg6r
         9nFjBxHSh+My4NFKvD81cv6W0VNTh+40WEvv+w5U4QX8EwdG5npyXSOcDC6NUerfiKO5
         ZCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=EIvylagLR3oz/qj0VQb5hDAO7y9SysJclPXEbtnVTCU=;
        fh=1xYV4JGYcaUm8zB1E0ETZVOopagQ+Hwx8/zlHYf9L2o=;
        b=apeZDV6CrlsuaN1E+9n2AvzmgMGcnDZBZ2Ythmw8Im3z4/w1ZU4AK1Ms0BqloMmsPr
         j2oFNIpuoFl2k+HME5R375Voq1IghkArXpfiISWvPdPm0vHXQnC+L/23bsIy7uNEGYdy
         axbkFUrFYE3Cyd7+d1Z1DKlgiAktL8pY+QQLydQxLPwluNyEFnIa8N1eqjJ70kYUSL6z
         5SIG2uFEJ5V24Q/Jw2y+FqRjpb+mUWDMF7H5AxvcN8lT3RmXa08qd2MQw8FqbpEDyyi1
         VYQgAePq0O0ZBZ0UY4ZThY5mE3Jr6wisr/7vq4WP28wSwg4EXq5tahCy/hSdNo0IqKZ2
         2eVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770013158; x=1770617958; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EIvylagLR3oz/qj0VQb5hDAO7y9SysJclPXEbtnVTCU=;
        b=mIt1CXk3fgN6GtidbegS2kdjADf1mtL63K78D9SEKhD/pVYiptCkXweRVXmqxow0U0
         VvZOJs9t0FUl42SX8haaIlQPS9VDcu53CcNPkLirnx+/LfpluK673h6uAOCphBbEplEH
         KcXqKVK71NViIYYN8I548a7Lq1F/UJhWjb9iSpkyFLJIXVmDd6sE1IkGqngTkFO6RuBq
         7Nm8kbjVlWa75OmCors0X/Om7BLQj2tnwrsONqp+KjEp295PIhygPosMhsuvLb9mJqtc
         7qxC+JLaDMcteOKr2cqbq8Hbolz5p9rZMb5AHRdsTbZtqLPrD28hzhmAk823kgU5RncU
         xRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770013158; x=1770617958;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIvylagLR3oz/qj0VQb5hDAO7y9SysJclPXEbtnVTCU=;
        b=Y/giYXq9DrImP3BAaCgkylFq6x7NgXGZ2gfjOPddUXsRbqrQAwLrF4lDuCh7/FybOH
         Fne6gRDKM8Iy+Ngwd5SQ8hPQVTH9EtXkCikYhU9/4YJLNmt4Z0iouW3eEbM6jA5YA4yD
         lOCxjDlcaDQfdD+NdmY5+DJd3Gc+wOwBJcSbwwuYfCmghzFClCgzHBB50NE8b4zpAeBx
         suNR4IBRCLR1UDPK8nC7TEgJKJAx2xudyMXGdVpnJIXOK57y0qHE3zIAKC/YTlgjGG/j
         c0itNS5b2LtQPBuLx13vKWnfyVspaXzSA5XTDOAQPflvZeJtvF8ZQKs93ICevoIsW5u4
         /XRA==
X-Forwarded-Encrypted: i=1; AJvYcCVnVy3j72x+FDnda+r36d3OTwwlSo/JWF0p9VUhX2sZ/qvx1+ULIt5aMZp/TiltRppp3Y0f61Eg@vger.kernel.org
X-Gm-Message-State: AOJu0YyLJSuXrIKFDO9Lq7l5hRfXI7JsmltBPjkPUeTFEBDSMvgP1CYd
	+KQ7pb/okDxTxPWPC5Ke0Hwa0sS0MxDjjLuyrfhlA3CqW41HKoxtoMDXFpKqjV2e2G2PakZrpHC
	OqtHTCnsY2GCeJ2o75jTFaKTFUtiPVK8=
X-Gm-Gg: AZuq6aJEQyd1JtMKyXJZNntCZwW54ua7SGbYwYnsuL1ByvAqBz3x7M6D97MCL00ODML
	pLwCf+9b+gTlaQWnZZyzRtGih8qw4OHEVX5ZT3ElY8OKP8+EJAipvBvO+7072rHiHcFC6r4/YGA
	ccTiEOYRdWt9Jqkey8iXtd7RoLB+2gVqM7WI9MspKbs86LYRCLpeZJsmkWw+ANntsECd9VaoL3b
	PRgEb1zt8cvw2E04sooLiPuWIoj0wBoRRJE6B/arXkJFZF09QmuLUiao+1miEibiBI4cpsNcwpu
	jjbsB+vwDs1QQxP5sil4E5YOf258JDW3HPU=
X-Received: by 2002:ad4:5f8a:0:b0:888:626c:c06b with SMTP id
 6a1803df08f44-894ea0905e0mr156781466d6.40.1770013158214; Sun, 01 Feb 2026
 22:19:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>
Date: Mon, 2 Feb 2026 14:19:07 +0800
X-Gm-Features: AZwV_QgzFJB2VNdS2iZC5E3t8lFduUu_-zpxj-Mhp_gXWKJLT9dbqlREY1xCCyI
Message-ID: <CAHPqNmwT9oRpem3J3erS_W0uSQND47LGGSBsNxP8E6uSUish1w@mail.gmail.com>
Subject: [Kernel Bug] KASAN: slab-use-after-free Read in __blkcg_rstat_flush
To: syzkaller@googlegroups.com, tj@kernel.org, josef@toxicpanda.com, 
	axboe@kernel.dk, cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13593-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coregee2000@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63B44C896A
X-Rspamd-Action: no action

Dear Linux kernel developers and maintainers,

We would like to report a new kernel bug found by our tool. KASAN:
slab-use-after-free Read in __blkcg_rstat_flush. Details are as
follows.

Kernel commit: v6.18.2
Kernel config: see attachment
report: see attachment

We are currently analyzing the root cause and  working on a
reproducible PoC. We will provide further updates in this thread as
soon as we have more information.

Best regards,
Longxing Li

==================================================================
BUG: KASAN: slab-use-after-free in
__blkcg_rstat_flush.isra.0+0x73c/0x800 block/blk-cgroup.c:1069
Read of size 8 at addr ffff88810a8ba830 by task pool_workqueue_/3

CPU: 1 UID: 0 PID: 3 Comm: pool_workqueue_ Not tainted 6.18.2 #1 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 __blkcg_rstat_flush.isra.0+0x73c/0x800 block/blk-cgroup.c:1069
 __blkg_release+0x1a6/0x2d0 block/blk-cgroup.c:179
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0x79c/0x1530 kernel/rcu/tree.c:2861
 handle_softirqs+0x219/0x8e0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1052
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:lockdep_unregister_key+0xe9/0x140 kernel/locking/lockdep.c:6616
Code: 48 89 ef e8 b9 e5 ff ff 48 83 2d e9 3d 04 14 01 89 c3 e8 da ee
ff ff 9c 58 f6 c4 02 75 52 41 f7 c4 00 02 00 00 74 01 fb 84 db <75> 1b
5b 5d 41 5c e9 4c 79 0a 00 8b 05 6a c5 c7 0e 31 db 85 c0 74
RSP: 0000:ffffc9000005fd88 EFLAGS: 00000246
RAX: 0000000000000046 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff8d91cc66 RDI: ffffffff8bd07340
RBP: ffffffff97038a88 R08: 000000000002f4fa R09: ffffffff95a27414
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000246
R13: ffff8880204ad400 R14: ffff8880204ad408 R15: ffff88802c98b001
 wq_unregister_lockdep kernel/workqueue.c:4848 [inline]
 pwq_release_workfn+0x5e6/0xa70 kernel/workqueue.c:5144
 kthread_worker_fn+0x310/0xc50 kernel/kthread.c:1010
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 12789:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:417
 kmalloc_node_noprof include/linux/slab.h:983 [inline]
 blkg_alloc+0xb7/0xb60 block/blk-cgroup.c:305
 blkg_create+0xb66/0x1400 block/blk-cgroup.c:391
 blkg_lookup_create block/blk-cgroup.c:508 [inline]
 blkg_tryget_closest block/blk-cgroup.c:2096 [inline]
 bio_associate_blkg_from_css+0xcf3/0x13e0 block/blk-cgroup.c:2130
 bio_associate_blkg block/blk-cgroup.c:2161 [inline]
 bio_associate_blkg+0x10c/0x2a0 block/blk-cgroup.c:2147
 bio_init+0x2dd/0x5e0 block/bio.c:266
 bio_init_inline include/linux/bio.h:411 [inline]
 bio_alloc_bioset+0x2c4/0x8d0 block/bio.c:584
 bio_alloc include/linux/bio.h:372 [inline]
 do_mpage_readpage+0xd39/0x18d0 fs/mpage.c:287
 mpage_readahead+0x321/0x5a0 fs/mpage.c:371
 read_pages+0x1c4/0xc70 mm/readahead.c:163
 page_cache_ra_unbounded+0x4b9/0xa10 mm/readahead.c:302
 do_page_cache_ra mm/readahead.c:332 [inline]
 force_page_cache_ra+0x246/0x340 mm/readahead.c:361
 page_cache_sync_ra+0x20c/0xbf0 mm/readahead.c:579
 filemap_get_pages+0x717/0x1d40 mm/filemap.c:2638
 filemap_read+0x3d4/0xe60 mm/filemap.c:2748
 blkdev_read_iter+0x1ac/0x500 block/fops.c:859
 new_sync_read fs/read_write.c:491 [inline]
 vfs_read+0x8bf/0xcf0 fs/read_write.c:572
 ksys_read+0x12a/0x250 fs/read_write.c:715
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 9843:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 __kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2543 [inline]
 slab_free mm/slub.c:6642 [inline]
 kfree+0x2b8/0x6d0 mm/slub.c:6849
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:559
 insert_work+0x36/0x230 kernel/workqueue.c:2186
 __queue_work+0x97e/0x1160 kernel/workqueue.c:2341
 queue_work_on+0x1a4/0x1f0 kernel/workqueue.c:2392
 blkg_free block/blk-cgroup.c:152 [inline]
 __blkg_release+0x113/0x2d0 block/blk-cgroup.c:183
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0x79c/0x1530 kernel/rcu/tree.c:2861
 handle_softirqs+0x219/0x8e0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1052
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:559
 __call_rcu_common.constprop.0+0xa5/0xa10 kernel/rcu/tree.c:3123
 percpu_ref_put_many.constprop.0+0x26c/0x2a0 include/linux/percpu-refcount.h:335
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0x79c/0x1530 kernel/rcu/tree.c:2861
 handle_softirqs+0x219/0x8e0 kernel/softirq.c:622
 do_softirq kernel/softirq.c:523 [inline]
 do_softirq+0xb2/0xf0 kernel/softirq.c:510
 __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:450
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:835 [inline]
 nsim_dev_trap_report_work+0x8b5/0xcf0 drivers/net/netdevsim/dev.c:866
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88810a8ba800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 48 bytes inside of
 freed 512-byte region [ffff88810a8ba800, ffff88810a8baa00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10a8b8
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x57ff00000000040(head|node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000040 ffff88801b041c80 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 057ff00000000040 ffff88801b041c80 0000000000000000 dead000000000001
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 057ff00000000002 ffffea00042a2e01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask
0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC),
pid 9875, tgid 9875 (syz-executor.5), ts 476252151009, free_ts
476208805854
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1af/0x220 mm/page_alloc.c:1845
 prep_new_page mm/page_alloc.c:1853 [inline]
 get_page_from_freelist+0x10a3/0x3a30 mm/page_alloc.c:3879
 __alloc_frozen_pages_noprof+0x25f/0x2470 mm/page_alloc.c:5178
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3059 [inline]
 allocate_slab mm/slub.c:3232 [inline]
 new_slab+0x24a/0x360 mm/slub.c:3286
 ___slab_alloc+0xd79/0x1a50 mm/slub.c:4655
 __slab_alloc.constprop.0+0x63/0x110 mm/slub.c:4778
 __slab_alloc_node mm/slub.c:4854 [inline]
 slab_alloc_node mm/slub.c:5276 [inline]
 __kmalloc_cache_noprof+0x477/0x780 mm/slub.c:5766
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 binderfs_binder_device_create.isra.0+0x189/0xb10 drivers/android/binderfs.c:148
 binderfs_fill_super+0x8d4/0x13a0 drivers/android/binderfs.c:720
 vfs_get_super fs/super.c:1331 [inline]
 get_tree_nodev+0xdd/0x190 fs/super.c:1350
 vfs_get_tree+0x8e/0x340 fs/super.c:1758
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3642 [inline]
 do_new_mount fs/namespace.c:3718 [inline]
 path_mount+0x7b9/0x23a0 fs/namespace.c:4028
 do_mount fs/namespace.c:4041 [inline]
 __do_sys_mount fs/namespace.c:4229 [inline]
 __se_sys_mount fs/namespace.c:4206 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:4206
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 12738 tgid 12736 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0x7ce/0x1160 mm/page_alloc.c:2901
 stack_depot_save_flags+0x352/0x9c0 lib/stackdepot.c:727
 kasan_save_stack+0x42/0x60 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 unpoison_slab_object mm/kasan/common.c:342 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:368
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4978 [inline]
 slab_alloc_node mm/slub.c:5288 [inline]
 kmem_cache_alloc_lru_noprof+0x254/0x6e0 mm/slub.c:5307
 alloc_inode+0x64/0x240 fs/inode.c:346
 new_inode+0x22/0x1c0 fs/inode.c:1145
 debugfs_get_inode fs/debugfs/inode.c:72 [inline]
 __debugfs_create_file+0x11c/0x6b0 fs/debugfs/inode.c:442
 debugfs_create_file_full+0x41/0x60 fs/debugfs/inode.c:469
 bdi_debug_register mm/backing-dev.c:239 [inline]
 bdi_register_va+0x343/0x820 mm/backing-dev.c:1106
 super_setup_bdi_name+0xff/0x250 fs/super.c:1817
 btrfs_fill_super fs/btrfs/super.c:981 [inline]
 btrfs_get_tree_super fs/btrfs/super.c:1951 [inline]
 btrfs_get_tree_subvol fs/btrfs/super.c:2094 [inline]
 btrfs_get_tree+0x12bd/0x2710 fs/btrfs/super.c:2128
 vfs_get_tree+0x8e/0x340 fs/super.c:1758
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3642 [inline]
 do_new_mount fs/namespace.c:3718 [inline]
 path_mount+0x7b9/0x23a0 fs/namespace.c:4028
 do_mount fs/namespace.c:4041 [inline]
 __do_sys_mount fs/namespace.c:4229 [inline]
 __se_sys_mount fs/namespace.c:4206 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:4206

Memory state around the buggy address:
 ffff88810a8ba700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88810a8ba780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88810a8ba800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88810a8ba880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88810a8ba900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
   0: 48 89 ef              mov    %rbp,%rdi
   3: e8 b9 e5 ff ff        call   0xffffe5c1
   8: 48 83 2d e9 3d 04 14 subq   $0x1,0x14043de9(%rip)        # 0x14043df9
   f: 01
  10: 89 c3                mov    %eax,%ebx
  12: e8 da ee ff ff        call   0xffffeef1
  17: 9c                    pushf
  18: 58                    pop    %rax
  19: f6 c4 02              test   $0x2,%ah
  1c: 75 52                jne    0x70
  1e: 41 f7 c4 00 02 00 00 test   $0x200,%r12d
  25: 74 01                je     0x28
  27: fb                    sti
  28: 84 db                test   %bl,%bl
* 2a: 75 1b                jne    0x47 <-- trapping instruction
  2c: 5b                    pop    %rbx
  2d: 5d                    pop    %rbp
  2e: 41 5c                pop    %r12
  30: e9 4c 79 0a 00        jmp    0xa7981
  35: 8b 05 6a c5 c7 0e    mov    0xec7c56a(%rip),%eax        # 0xec7c5a5
  3b: 31 db                xor    %ebx,%ebx
  3d: 85 c0                test   %eax,%eax
  3f: 74                    .byte 0x74

https://drive.google.com/file/d/1ZjRNEOf0XFYtFl5UZ7dvpJpzmPhje8it/view?usp=drive_link

https://drive.google.com/file/d/1f695Y7Vob314irZfdduD4wnPJ51VzXrU/view?usp=drive_link

