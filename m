Return-Path: <cgroups+bounces-15058-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F55KbnhxGnz4gQAu9opvQ
	(envelope-from <cgroups+bounces-15058-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2026 08:35:21 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E23A1330821
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2026 08:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38EAA30185C3
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2026 07:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C05034F48A;
	Thu, 26 Mar 2026 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r+rKw+EZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VYlAc2x8"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB292D77F7;
	Thu, 26 Mar 2026 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774510518; cv=none; b=gIJYb255EsLRdqkrz4IR1GjiZe8xUgZuOdcg+ONDJ7axN7QZ+oMCK9j90Mf0bd6gVN3VpINicmLjH9kUp7fMoCqC1uWFnCQcWWhWnIjhghpf16MUidkUv+Pe+Gns4NmbYgniKykGc4EBqx2D9sZoryDHAOC81MlP4IrJdOFl/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774510518; c=relaxed/simple;
	bh=ICVgkSP9x1RL+ZNNbdwpbQogni1rlYOJj5D37twFpsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obZnRlkHX1qM5MUwfnPzqmmMVsAsr6d+rEuVrxu9k7nPwwWAHErAhS9YJbUcH2eLfUnsCdNvu+Mp8LdZhaQ4vKOZ21gx5nxggtTSjBt8+RL7xXPuQiKJo0fJLwrI0QIFJ7d0JYj+AjAci1WIq7Cx8GUrzrq1kvqLb+LAfByelY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r+rKw+EZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VYlAc2x8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Mar 2026 08:35:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774510513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qfVplKbbtqt40VG5NEqtnXlXKgcuFZMJR5v/Th3qZTw=;
	b=r+rKw+EZZ045fvwKpzQsEgrwOw6xuzad0TC5czEfZL3Lk0F8tjIqqPA9DyRMOaaychHai3
	Dx+wvrrrPpIaLdNqTjfJJxc6EJrZu2BgNdWa2RLQS5BL0P/pv2N7343bG2i+a/Nv8TTF2w
	zmKL/mNoo6Me4r4iIvqoqI5a5mXFXWpepuGTNoWjP0Jp6rsMndlnb68psXpPOuoHA5VjRC
	PlmnOYWuWbcoRYBhv3csHcEKMVWaYbYthlhmX1VmjffAxNauZbR8dmVPMwkGGHXIBZMMpQ
	qFcnkTczYiYqUtRmjZ6hFPJ6AbXXOmoJoqiKTILreNsLTCsb48VPXrTF6+o6qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774510513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qfVplKbbtqt40VG5NEqtnXlXKgcuFZMJR5v/Th3qZTw=;
	b=VYlAc2x8t2CCfEgV2N8yUSCGZ1CtZemlRUXWahqLxinmAVob4Qw47Po+g94tdqCDNeA0JP
	gMc5Z5Ks/H7OiuDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bert Karwatzki <spasswolf@web.de>, Michal Koutny <mkoutny@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v3 cgroup/for-7.0-fixes] cgroup: Fix cgroup_drain_dying()
 testing the wrong condition
Message-ID: <20260326073511.0rcA5AGb@linutronix.de>
References: <68d8881fd985a410c0f619f009334c28@kernel.org>
 <20260325180623.EcyNsp2L@linutronix.de>
 <acR3fYVD_blwD93_@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acR3fYVD_blwD93_@slm.duckdns.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,web.de,suse.com,cmpxchg.org,intel.com];
	TAGGED_FROM(0.00)[bounces-15058-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: E23A1330821
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-25 14:02:05 [-1000], Tejun Heo wrote:
> > The only issue I see is if I delay the irq_work callback by a second.
> > Other than that, I don't see any problems.
> 
> What issue do you see when delaying it by a second? Just things being slowed
> down?

This is during boot:

[  OK  ] Mounted sys-kernel-debug.mount - Kernel Debug File System.
[  OK  ] Mounted sys-kernel-tracing.mount - Kernel Trace File System.
[  OK  ] Mounted tmp.mount - Temporary Directory /tmp.
[   20.845878] INFO: task systemd:1 blocked for more than 10 seconds.
[   20.845885]       Not tainted 7.0.0-rc5+ #178
[   20.845887] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   20.845888] task:systemd         state:D stack:0     pid:1     tgid:1     ppid:0      task_flags:0x400100 flags:0x00080000
[   20.845906] Call Trace:
[   20.845911]  <TASK>
[   20.845915]  __schedule+0x3db/0xf90
[   20.845947]  schedule+0x27/0xd0
[   20.845950]  cgroup_drain_dying+0x9b/0x190
[   20.845971]  cgroup_rmdir+0x2d/0x100
[   20.845980]  kernfs_iop_rmdir+0x6a/0xd0
[   20.845993]  vfs_rmdir+0x11a/0x280
[   20.846002]  filename_rmdir+0x16f/0x1e0
[   20.846009]  __x64_sys_rmdir+0x28/0x40
[   20.846015]  do_syscall_64+0x119/0x5a0
[   20.846152]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   20.846158] RIP: 0033:0x7ff495627337
[   20.846164] RSP: 002b:00007ffd7efa66f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
[   20.846170] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff495627337
[   20.846172] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 00005646ca9583a0
[   20.846173] RBP: 00005646ca9583a0 R08: 000000000000000c R09: 0000000000000000
[   20.846174] R10: 0000000000000000 R11: 0000000000000246 R12: 00005646ca957ac0
[   20.846175] R13: 0000000000000001 R14: 0000000000000004 R15: 0000000000000000
[   20.846178]  </TASK>

It does not recover. Therefore I think there might be another race
lurking. This is what I talk about:

--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -7112,9 +7112,9 @@ static void do_cgroup_task_dead(struct task_struct *tsk)
  * irq_work to allow batching while ensuring timely completion.
  */
 static DEFINE_PER_CPU(struct llist_head, cgrp_dead_tasks);
-static DEFINE_PER_CPU(struct irq_work, cgrp_dead_tasks_iwork);
+static DEFINE_PER_CPU(struct delayed_work, cgrp_delayed_tasks_iwork);
 
-static void cgrp_dead_tasks_iwork_fn(struct irq_work *iwork)
+static void cgrp_dead_tasks_iwork_fn(struct work_struct *iwork)
 {
 	struct llist_node *lnode;
 	struct task_struct *task, *next;
@@ -7131,9 +7131,11 @@ static void __init cgroup_rt_init(void)
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
+		struct delayed_work *dwork;
+
 		init_llist_head(per_cpu_ptr(&cgrp_dead_tasks, cpu));
-		per_cpu(cgrp_dead_tasks_iwork, cpu) =
-			IRQ_WORK_INIT_LAZY(cgrp_dead_tasks_iwork_fn);
+		dwork = &per_cpu(cgrp_delayed_tasks_iwork, cpu);
+		INIT_DELAYED_WORK(dwork, cgrp_dead_tasks_iwork_fn);
 	}
 }
 
@@ -7141,7 +7143,7 @@ void cgroup_task_dead(struct task_struct *task)
 {
 	get_task_struct(task);
 	llist_add(&task->cg_dead_lnode, this_cpu_ptr(&cgrp_dead_tasks));
-	irq_work_queue(this_cpu_ptr(&cgrp_dead_tasks_iwork));
+	schedule_delayed_work(this_cpu_ptr(&cgrp_delayed_tasks_iwork), HZ);
 }
 #else	/* CONFIG_PREEMPT_RT */
 static void __init cgroup_rt_init(void) {}

> Thanks.
> 

Sebastian

