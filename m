Return-Path: <cgroups+bounces-11149-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF468C06D73
	for <lists+cgroups@lfdr.de>; Fri, 24 Oct 2025 17:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE47A5076D1
	for <lists+cgroups@lfdr.de>; Fri, 24 Oct 2025 15:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487E02F8BF1;
	Fri, 24 Oct 2025 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OX1uzaiD"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB722C21EF;
	Fri, 24 Oct 2025 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317980; cv=none; b=TEJ2g8oMBIrYJP/OlHzupgYLhWAtq/FVg5x61H1i0D8Lmz73yqHVNi7/7I641p67/piHruyzKq9Tg59utRRw9Scc8qXCfzsvDEqr5wAjnp04ormlUXkXh4vxf2+N5NDjaazUUdyq7exEEiGM/oHSkKYlmEmNObuZ+iP1wgCsWso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317980; c=relaxed/simple;
	bh=7E3LSJX6xrgM7B2931lECH8kQ8UfZiM2NDVAdxu9TKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4gDR/gFpCCU9GZ+ajNdSBHUDeXxmaDmdJkJlXI3HtYMudk1B/78ZKfjvN7yfxKO5LeQHA2wMKXkslbnXTfxEN/mj0lbTGEu8EUpwT7Xy17lUCz2nvChr3RaZRysogGTrmVYMgCr0X1Yq8BHtmfNWRCLZprd4wwBrtkv7B4or7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OX1uzaiD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O4hw04008513;
	Fri, 24 Oct 2025 14:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8TJ4qf6Pb5L6+HHFM
	aAQfB40Sn0Ki5YNuLu7cZVkhls=; b=OX1uzaiDBmwlGBkXB1a6UZMOW3DRR1AlG
	7tGMPYhdzv7Xf0LPjSq7+rOh4cC/9kN7HfcQ7FX9KF3GCeOAVIpZ61I/l3uUR5tI
	iCiEQvLemiHNId2jlu/IiucMHeInGLqKs8mUDX4U9MYb9oopzBjB79V00pf+hDec
	xrX7lojUeuJDCwBWgbPfszzbMakheT4JSae+AFuqt1mGgI9a7w/dDJ8lLyV8ui4O
	0nRXtWJ3jsoj3AZz4Q6Ko5h1USSei4KyiQ3CGm4a9+zBP3+skCricpd6VX0RjvTG
	vuGuP124ExSZl/pOYv/xaekIGgFCs/sIvo10ck6k6PIJhdj8qkN9g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hx7fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 14:59:00 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59OEeBA9023676;
	Fri, 24 Oct 2025 14:58:59 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hx7ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 14:58:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59OBSGIx011020;
	Fri, 24 Oct 2025 14:58:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx1kakm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 14:58:58 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59OEwuid42402220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 14:58:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A59B320049;
	Fri, 24 Oct 2025 14:58:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 611522004D;
	Fri, 24 Oct 2025 14:58:56 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Oct 2025 14:58:56 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: peterz@infradead.org
Cc: arighi@nvidia.com, bsegall@google.com, cgroups@vger.kernel.org,
        changwoo@igalia.com, dietmar.eggemann@arm.com, hannes@cmpxchg.org,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        liuwenfang@honor.com, longman@redhat.com, mgorman@suse.de,
        mingo@kernel.org, mkoutny@suse.com, rostedt@goodmis.org,
        sched-ext@lists.linux.dev, tglx@linutronix.de, tj@kernel.org,
        vincent.guittot@linaro.org, void@manifault.com, vschneid@redhat.com
Subject: [REGRESSION] Deadlock during CPU hotplug caused by abfc01077df6
Date: Fri, 24 Oct 2025 16:58:13 +0200
Message-ID: <20251024145813.3535989-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251006104527.331463972@infradead.org>
References: <20251006104527.331463972@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX1lG0d+9jWs2i
 qjW+YL88euygrb/TDxHflBUsITHkXldfkSdl+NmpWHgDVVC5I7yJWq+G8H8qRlf7Xh9SpwcaBQS
 yaGl9hoQFhMc/ZXvx6OqYIgPmuR6+p+4ZBDat8fJ6I+I+/Wtc5l7kKf+xOEmOyMcmBVmeAnQCH/
 F9abKagwY1ka6KrAhjIupLutCMEzYQT/PcKe359kLNUFrwAyseixq1kWn0VlQ26KHGENP21MGAr
 s3PhUSG8jT8FTh4fRYo6hE/HhrHhv08NKNnQhL1mhMw8N45fZbELisTflh+84E1jN4bH8Gsb0AV
 fmmYep/yttoFtdx/BKjomze+s/ClDMSuQzuPUOq0EiV/gfsbv8dW3M/y1PMfhT1LjMQarnzm3hx
 2sKbFXImc/wf24HfYDkAHQl0v89rEg==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68fb9434 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=URV6e8FYp2escMi8J3AA:9
 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-GUID: NpgHxX1xjup5R5nTAXr8ZAdnZjBDxJY6
X-Proofpoint-ORIG-GUID: -0TDq8IPZJWfnl-VYFVFqWZReKs3ooxm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1011 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

We've identified a regression introduced by commit abfc01077df6 ("sched: Fix
do_set_cpus_allowed() locking") that causes a reproducible deadlock during CPU
hotplug testing on s390x.

While running the cpuhotplug02.sh test from LTP, which dynamically
offlines and onlines CPUs, the system consistently enters a stalled
state.

Observed behavior:
- migration/N attempts to migrate a task currently executing on another
  CPU.
- Concurrently, rcu_sched tries to complete an RCU grace period.
- Both threads are blocked on spinlocks (e.g., arch_spin_lock_wait),
  likely due to lock contention.
- Neither thread progresses; the grace period stalls.
- The kernel detects the stall and triggers a crash dump.

Sys info:
	RELEASE: 6.18.0-20251021.rc2.git224.fe45352cd106.63.fc42.s390x+next
	CPUS: 32
	TASKS: 623
	MEMORY: 16 GB

Crash log excerpt:
    [ 6146.992159] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
    [ 6146.992173] rcu:     1-...0: (5 ticks this GP) idle=cea4/1/0x4000000000000000 softirq=1055899/1055901 fqs=4769
    [ 6146.992236] rcu:     (detected by 3, t=240013 jiffies, g=2041729, q=14778 ncpus=32)
    [ 6146.992240] Task dump for CPU 1:
    [ 6146.992241] task:migration/1     state:R  running task     stack:0     pid:22    tgid:22    ppid:2      task_flags:0x4208040 flags:0x00000000
    [ 6146.992246] Stopper: __balance_push_cpu_stop+0x0/0x230 <- balance_push+0xea/0x170
    [ 6146.992254] Call Trace:
    [ 6146.992255]  [<000000009d9e2300>] 0x9d9e2300
    [ 6146.992280] rcu: rcu_sched kthread starved for 210010 jiffies! g2041729 f0x2 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=23
    [ 6146.992287] rcu:     Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
    [ 6146.992288] rcu: RCU grace-period kthread stack dump:
    [ 6146.992289] task:rcu_sched       state:R  running task     stack:0     pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00000010
    [ 6146.992294] Call Trace:
    [ 6146.992295]  [<0700000000000001>] 0x700000000000001
    [ 6146.992298]  [<000002e1fb072998>] arch_spin_lock_wait+0xc8/0x110
    [ 6146.992303]  [<000002e1fa239d06>] raw_spin_rq_lock_nested+0x96/0xc0
    [ 6146.992306]  [<000002e1fa23bc90>] resched_cpu+0x50/0xc0
    [ 6146.992309]  [<000002e1fa29d646>] force_qs_rnp+0x306/0x3e0
    [ 6146.992314]  [<000002e1fa29ed30>] rcu_gp_fqs_loop+0x430/0x6e0
    [ 6146.992316]  [<000002e1fa2a1b0e>] rcu_gp_kthread+0x1ee/0x270
    [ 6146.992320]  [<000002e1fa228edc>] kthread+0x12c/0x250
    [ 6146.992323]  [<000002e1fa19ccfc>] __ret_from_fork+0x3c/0x150
    [ 6146.992328]  [<000002e1fb0800ba>] ret_from_fork+0xa/0x30


