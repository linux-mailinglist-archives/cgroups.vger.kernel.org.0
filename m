Return-Path: <cgroups+bounces-14827-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAFfHwi6t2mpUgEAu9opvQ
	(envelope-from <cgroups+bounces-14827-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2026 09:06:32 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1637295F71
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2026 09:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB3B9300FEDE
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2026 08:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6413537E6;
	Mon, 16 Mar 2026 08:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="297OAddl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yqB75Mvh"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC8624E4AF
	for <cgroups@vger.kernel.org>; Mon, 16 Mar 2026 08:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773648375; cv=none; b=gEm3GCFZxn0fqbL19E70ER6T5iYHgAZM7PeLuW7qt6Cs+/W+dzgGJMISRe1PhjzRNeOyCbl2jP/1RS8iJg3bYOAtCv3nKwtKVyEq3DxS5gCgqGGNUineXVusTorejX/17/+G4Rh4fK5zMW1jsMz5ULer9pT6PdJCdOYlulI6L0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773648375; c=relaxed/simple;
	bh=GPDIjnFjrFITQjFRHxEVmc+rlL/Jh+3l4rzt4hE5ZWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uadLIlrCf+6tWn5G3w14YYinqkMvuI2f6FNvwe4wnzER0jehsoa3X8oHDNt5n/0PZEiiiEy2V306wn8t02Xq8eu0f8TvfjXdSu3c+edq46BW2HtBgNt27oSke6ZAKX/BciqMBTtVHc5QrS9hRt90Lp0YZK/pGHmU0V3Le3f3KoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=297OAddl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yqB75Mvh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 16 Mar 2026 09:06:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773648373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2T5XEiat4AcyzU2cNJEUVlnoFi/dWcIq2LJ23mESUlQ=;
	b=297OAddlSqXv+JWNuPL/agpbOXlSRSEdJ4X0A46FZ3Vfh5J/3+G+HmI7LrE+O08+8XCpcH
	+xXvNLLdXivv6ZktD/KcdTajNnh8pROsU0OaixM9BIEDYmHL4S9cxXqYJ8CiBV4zfQoaai
	IAjAYDaWtWIRrOOxYJvNtMKhA+l+BsAR3IJjupN9G566vrHmOZFzriPj4jEg8QNK6fYVY0
	QCzvlZvaLWXOVGZ4wVlEVpixRhQ3yND5sMB9S0qQXBxyFsWGxO7DiOZKPEJpesv4xB43vL
	fjY6RDqSprBQuPv1nAkiUcVpI9R0pEju7ba7qh70oitikIsNho0QKQYWsb/mhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773648373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2T5XEiat4AcyzU2cNJEUVlnoFi/dWcIq2LJ23mESUlQ=;
	b=yqB75MvhOX5CY6ecyoO4t/jgjahEVW9oU7TCaA2rmG0yXrrNvZ43z8SbZO3kbFfxsBKqKx
	BRdNh/ntIqYBfbBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] cgroup: Move cgroup_task_dead() to task_struct clean up
Message-ID: <20260316080611.5G06G5O8@linutronix.de>
References: <20260311120829.rEHY-xh9@linutronix.de>
 <ydymxaffr2s7npif37msq5q467m2ql26ib6wifwoztuhqmg4ao@id5c532lhorb>
 <20260314091752.B7CXvQxn@linutronix.de>
 <abcTbSznpQ1qxJdj@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abcTbSznpQ1qxJdj@slm.duckdns.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14827-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1637295F71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-15 10:15:41 [-1000], Tejun Heo wrote:
> Hello,
Hi,

> Yeah, I think it's too late. That's where we tell the cgroup is becoming
> empty among other things. cgroup_task_free() waits for all task refcnts to
> drop which can take any amount of time. You can also imagine situations
> where e.g. userspace pins a specific task through pidfd unitl the cgroup it
> belongs becomes empty, which would have worked before but now would
> deadlock.

I see. What about moving it to delayed_put_task_struct() such as the
change on top below? It also RCU and only acquired by bpf_task_acquire().
Is this also a concern or would that work?

--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -138,6 +138,7 @@ extern void cgroup_cancel_fork(struct task_struct *p,
 extern void cgroup_post_fork(struct task_struct *p,
 			     struct kernel_clone_args *kargs);
 void cgroup_task_exit(struct task_struct *p);
+void cgroup_task_dead(struct task_struct *p);
 void cgroup_task_release(struct task_struct *p);
 void cgroup_task_free(struct task_struct *p);
 
@@ -681,6 +682,7 @@ static inline void cgroup_cancel_fork(struct task_struct *p,
 static inline void cgroup_post_fork(struct task_struct *p,
 				    struct kernel_clone_args *kargs) {}
 static inline void cgroup_task_exit(struct task_struct *p) {}
+static inline void cgroup_task_dead(struct task_struct *p) {}
 static inline void cgroup_task_release(struct task_struct *p) {}
 static inline void cgroup_task_free(struct task_struct *p) {}
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 684b773cd5cb4..28cdb8d3210e7 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6991,7 +6991,7 @@ void cgroup_task_exit(struct task_struct *tsk)
 	} while_each_subsys_mask();
 }
 
-static void cgroup_task_dead(struct task_struct *tsk)
+void cgroup_task_dead(struct task_struct *tsk)
 {
 	struct css_set *cset;
 	unsigned long flags;
@@ -7031,7 +7031,6 @@ void cgroup_task_free(struct task_struct *task)
 {
 	struct css_set *cset = task_css_set(task);
 
-	cgroup_task_dead(task);
 	if (!list_empty(&task->cg_list)) {
 		spin_lock_irq(&css_set_lock);
 		css_set_skip_task_iters(task_css_set(task), task);
diff --git a/kernel/exit.c b/kernel/exit.c
index ede3117fa7d41..7a94425122238 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -228,6 +228,7 @@ static void delayed_put_task_struct(struct rcu_head *rhp)
 	rethook_flush_task(tsk);
 	perf_event_delayed_put(tsk);
 	trace_sched_process_free(tsk);
+	cgroup_task_dead(tsk);
 	put_task_struct(tsk);
 }
 

> Thanks.

Sebastian

