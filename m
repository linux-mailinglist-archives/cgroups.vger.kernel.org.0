Return-Path: <cgroups+bounces-14558-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IHRLbPfpmlkYAAAu9opvQ
	(envelope-from <cgroups+bounces-14558-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 14:18:43 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 088991F0136
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 14:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABC7430F0F31
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 13:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0676B423A77;
	Tue,  3 Mar 2026 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lIb1i6qL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o29c4EBL"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9294935F169
	for <cgroups@vger.kernel.org>; Tue,  3 Mar 2026 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772543586; cv=none; b=EnrcVppdp69EdEpOMO1dsYUMMftXPicAwL/lngS9kXpDmev278ZOn2PiZku8TomLFX3skJ+KIMfspwYXmuH+pwBmgv4xkOkH5cGa+3YTUOzQ6R6lvwiaif3YbTFio8d/8AIAsXbkWev0WSPwnYrHbIKnwrossYvPL+KoXpbbM7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772543586; c=relaxed/simple;
	bh=N59rhKekYSzO90t0Z7GXfxgOY++spj7v6aQcINF0/l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epMlC3oIKQ2HKyHhSEsVXQLXqikF1hIpQ5EJ7F3lQlW+ahVpmFpu31tAsuch+1cvuFD8wTR3k02wZtfltnMBpmYOto4DU/QQcdOtyw0eSr4MsanwKL2oNwdwgS/F5LiaGT3wp4SJiSc/h0CWQDGVJKYmWEPUfecc+loWVx1SB/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lIb1i6qL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o29c4EBL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 3 Mar 2026 14:13:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772543583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sAffNeouQczhPYqzPOrjv2nqytQtFK/BWssDR6V5N1s=;
	b=lIb1i6qL8h9MiRz42pmMwbLciNyDm5IQ6eABURTTARl7DsaIUiasoYaVSxaVP4jwRtIRia
	GjRl31HlqzJ37onhVJie3y5ct3884XS6frlcXGpgCn7OtufgB/qTwVM5+Cj+vVhWHUrgYT
	wr7GiMRUQfSOtVYWyhvsjOkwNLKH+KKJtEQNx8ASUw+QcC/XtYNEOXFlZb8JZ5/BnqDH1G
	PLM77SIOfFOlpBUIe/rDdfWXZk8O5Jq0hdClHf4oAGOhxkr5WF120bXylGhSTvzH9amx3/
	yCTJn9S+A7FX+7kntjyLkSr72YnKW76EaQMshLAekWjx0gxCA0HXlgY4a7YN7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772543583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sAffNeouQczhPYqzPOrjv2nqytQtFK/BWssDR6V5N1s=;
	b=o29c4EBLvJKzIMvSBUfZqFdIYT6eJwH/q6/QO6+gsueadrZwXrIjWoptJSI87JG/zCTr1K
	onyzCHoNtItEeqAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: linux-rt-devel@lists.linux.dev, cgroups@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH] cgroup: Don't expose dead tasks in cgroup
Message-ID: <20260303131301.ieSSCM4n@linutronix.de>
References: <20260302120738.6KkDipsR@linutronix.de>
 <aaYHmCV2CW-tOT-Z@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaYHmCV2CW-tOT-Z@slm.duckdns.org>
X-Rspamd-Queue-Id: 088991F0136
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,cmpxchg.org,suse.com,kernel.org,goodmis.org,web.de];
	TAGGED_FROM(0.00)[bounces-14558-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 2026-03-02 11:56:40 [-1000], Tejun Heo wrote:
> Hello, Seb.
Hi Tejun,

> On Mon, Mar 02, 2026 at 01:07:38PM +0100, Sebastian Andrzej Siewior wrote:
> > Tejun, with this change, would it be okay to
> > - replace the irq-work with kworker? With this change it should address
> >   your concern regarding "run in definite time" as mentioned in [0]. So
> >   it might be significantly delayed but it shouldn't be visible.
> >   This would lift the restriction that a irq-work needs to run on this
> >   CPU and the kworker could run on any CPU. 
> 
> Yeah, that's fine.

Okay.

> > - would it be okay to treat RT and !RT equally here (and do this delayed
> >   cgroup_task_dead() in both cases)
> 
> I don't see why we'd bounce on !RT. Are there any benefits?

You would have the same bugs if any and not two separate types if at
all. It would get rid of the ifdef. No other benefit.

> > @@ -5283,6 +5283,11 @@ static void *cgroup_procs_start(struct seq_file *s, loff_t *pos)
> >  
> >  static int cgroup_procs_show(struct seq_file *s, void *v)
> >  {
> > +	struct task_struct *tsk = v;
> > +
> > +	if (READ_ONCE(tsk->__state) & TASK_DEAD)
> > +		return 0;
> 
> Does this actually close the window for systemd through operation ordering
> or does it just reduce the race window?

I see the task in questing exiting via sched_process_exit() and after
its schedule() it is removed from the cgroup list as per current logic.

The parent systemd task doing all its cleanup gets probably active
because its child died/ SIGCHLD. So we have sched_process_exit(), wake
parent, final schedule() leaving as zombie removing itself from the
cgroup list.
Judging from do_exit(), a preemption after exit_notify() before
do_task_dead() should lead to the same problem. By adding a delay

--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -893,6 +893,7 @@ static void synchronize_group_exit(struct task_struct *tsk, long code)
 		coredump_task_exit(tsk, core_state);
 }
 
+#include <linux/delay.h>
 void __noreturn do_exit(long code)
 {
 	struct task_struct *tsk = current;
@@ -1004,6 +1005,7 @@ void __noreturn do_exit(long code)
 	exit_task_stack_account(tsk);
 
 	check_stack_usage();
+	ssleep(1);
 	preempt_disable();
 	if (tsk->nr_dirtied)
 		__this_cpu_add(dirty_throttle_leaks, tsk->nr_dirtied);

I get the same timeout behaviour on !PREEMPT_RT. So it seems like I did
reduce the race window.

So what about doing the removal before sending the signal about the
upcoming death? Something like:

--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6975,6 +6975,7 @@ void cgroup_post_fork(struct task_struct *child,
  * Description: Detach cgroup from @tsk.
  *
  */
+static void do_cgroup_task_dead(struct task_struct *tsk);
 void cgroup_task_exit(struct task_struct *tsk)
 {
 	struct cgroup_subsys *ss;
@@ -6984,6 +6985,7 @@ void cgroup_task_exit(struct task_struct *tsk)
 	do_each_subsys_mask(ss, i, have_exit_callback) {
 		ss->exit(tsk);
 	} while_each_subsys_mask();
+	do_cgroup_task_dead(tsk);
 }
 
 static void do_cgroup_task_dead(struct task_struct *tsk)
@@ -7050,16 +7052,12 @@ static void __init cgroup_rt_init(void)
 
 void cgroup_task_dead(struct task_struct *task)
 {
-	get_task_struct(task);
-	llist_add(&task->cg_dead_lnode, this_cpu_ptr(&cgrp_dead_tasks));
-	irq_work_queue(this_cpu_ptr(&cgrp_dead_tasks_iwork));
 }
 #else	/* CONFIG_PREEMPT_RT */
 static void __init cgroup_rt_init(void) {}
 
 void cgroup_task_dead(struct task_struct *task)
 {
-	do_cgroup_task_dead(task);
 }
 #endif	/* CONFIG_PREEMPT_RT */
 

cgroup_task_exit() is invoked a few functions before exit_notify(). Not
sure what else I might have broken but the race window should be closed.

> Thanks.

Sebastian

