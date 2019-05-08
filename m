Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C94A01811A
	for <lists+cgroups@lfdr.de>; Wed,  8 May 2019 22:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfEHUed (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 May 2019 16:34:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55540 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726163AbfEHUed (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 May 2019 16:34:33 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x48KCiGi013909
        for <cgroups@vger.kernel.org>; Wed, 8 May 2019 13:34:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Qt+4ylLnsNwTDXffLjsnqCa0p2J66ZSO/dTW7jmxMrs=;
 b=i5gP1jg6fN0KMm6q0bZqZ+iYGFQKj0c1t9mvLuNSGFkqNUhXD1/9xqDcid3Su183xR0L
 aT5aKwIUhe+VVOfxuoJDmj0XAwJABxHxSUhVPok4tmhvHssnapi4ZzB/z7iCZiJiOp/d
 I2FVUglTsKu4EHrLYKwDzgrZVZWpwgYebGg= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sc05qshuu-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <cgroups@vger.kernel.org>; Wed, 08 May 2019 13:34:32 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 8 May 2019 13:34:31 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id E81D811CDD2A0; Wed,  8 May 2019 13:34:30 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Tejun Heo <tj@kernel.org>
CC:     Oleg Nesterov <oleg@redhat.com>, <kernel-team@fb.com>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qian Cai <cai@lca.pw>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH] cgroup: never call do_group_exit() with task->frozen bit set
Date:   Wed, 8 May 2019 13:34:20 -0700
Message-ID: <20190508203420.580163-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-08_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

I've got two independent reports that cgroup_task_frozen() check
in cgroup_exit() has been triggered by lkp libhugetlbfs-test and
LTP ptrace01 tests.

For example:
[   44.576072] WARNING: CPU: 1 PID: 3028 at kernel/cgroup/cgroup.c:5932 cgroup_exit+0x148/0x160
[   44.577724] Modules linked in: crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sr_mod cdrom
bochs_drm sg ttm ata_generic pata_acpi ppdev drm_kms_helper snd_pcm syscopyarea aesni_intel snd_timer
sysfillrect sysimgblt snd crypto_simd cryptd glue_helper soundcore fb_sys_fops joydev drm serio_raw pcspkr
ata_piix libata i2c_piix4 floppy parport_pc parport ip_tables
[   44.583106] CPU: 1 PID: 3028 Comm: ptrace-write-hu Not tainted 5.1.0-rc3-00053-g9262503 #5
[   44.584600] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   44.586116] RIP: 0010:cgroup_exit+0x148/0x160
[   44.587135] Code: 0f 84 50 ff ff ff 48 8b 85 c8 0c 00 00 48 8b 78 70 e8 ec 2e 00 00 e9 3b ff ff ff f0 ff 43 60
0f 88 72 21 89 00 e9 48 ff ff ff <0f> 0b e9 1b ff ff ff e8 3c 73 f4 ff 66 90 66 2e 0f 1f 84 00 00 00
[   44.590113] RSP: 0018:ffffb25702dcfd30 EFLAGS: 00010002
[   44.591167] RAX: ffff96a7fee32410 RBX: ffff96a7ff1d6000 RCX: dead000000000200
[   44.592446] RDX: ffff96a7ff1d6080 RSI: ffff96a7fec75290 RDI: ffff96a7fec75290
[   44.593715] RBP: ffff96a7fec745c0 R08: ffff96a7fec74658 R09: 0000000000000000
[   44.594985] R10: 0000000000000000 R11: 0000000000000001 R12: ffff96a7fec75101
[   44.596266] R13: ffff96a7fec745c0 R14: ffff96a7ff3bde30 R15: ffff96a7fec75130
[   44.597550] FS:  0000000000000000(0000) GS:ffff96a7dd700000(0000) knlGS:0000000000000000
[   44.598950] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   44.600098] CR2: 00000000f7a00000 CR3: 000000000d20e000 CR4: 00000000000406e0
[   44.601417] Call Trace:
[   44.602777]  do_exit+0x337/0xc40
[   44.603677]  do_group_exit+0x3a/0xa0
[   44.604610]  get_signal+0x12e/0x8d0
[   44.605533]  ? __switch_to_asm+0x40/0x70
[   44.606503]  do_signal+0x36/0x650
[   44.607409]  ? __switch_to_asm+0x40/0x70
[   44.608383]  ? __schedule+0x267/0x860
[   44.609329]  exit_to_usermode_loop+0x89/0xf0
[   44.610349]  do_fast_syscall_32+0x251/0x2e3
[   44.611357]  entry_SYSENTER_compat+0x7f/0x91
[   44.612376] ---[ end trace e4ca5cfc4b7f7964 ]---

The problem is caused by the ptrace_signal() call in the for loop
in get_signal(). There is a cgroup_enter_frozen() call inside
ptrace_signal(), so after exit from ptrace_signal() the task->frozen
bit might be set. In this case do_group_exit() can be called with the
task->frozen bit set and trigger the warning. This is only place where
we can leave the loop with the task->frozen bit set and without
setting JOBCTL_TRAP_FREEZE and TIF_SIGPENDING.

To resolve this problem, let's move cgroup_leave_frozen(true) call to
just after the fatal label. If the task is going to die, the frozen
bit must be cleared no matter how we get into this point.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Reported-by: Qian Cai <cai@lca.pw>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Roman Gushchin <guro@fb.com>
---
 kernel/signal.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 16b72f4f14df..8607b11ff936 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2483,10 +2483,6 @@ bool get_signal(struct ksignal *ksig)
 		ksig->info.si_signo = signr = SIGKILL;
 		sigdelset(&current->pending.signal, SIGKILL);
 		recalc_sigpending();
-		current->jobctl &= ~JOBCTL_TRAP_FREEZE;
-		spin_unlock_irq(&sighand->siglock);
-		if (unlikely(cgroup_task_frozen(current)))
-			cgroup_leave_frozen(true);
 		goto fatal;
 	}
 
@@ -2608,8 +2604,10 @@ bool get_signal(struct ksignal *ksig)
 			continue;
 		}
 
-		spin_unlock_irq(&sighand->siglock);
 	fatal:
+		spin_unlock_irq(&sighand->siglock);
+		if (unlikely(cgroup_task_frozen(current)))
+			cgroup_leave_frozen(true);
 
 		/*
 		 * Anything else is fatal, maybe with a core dump.
-- 
2.20.1

