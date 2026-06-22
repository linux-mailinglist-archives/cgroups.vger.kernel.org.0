Return-Path: <cgroups+bounces-17122-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B7p4Aka6OGqrgwcAu9opvQ
	(envelope-from <cgroups+bounces-17122-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 06:29:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FE56AC849
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 06:29:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=ieCQHQ2d;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17122-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17122-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A22A930065EF
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 04:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841523537F5;
	Mon, 22 Jun 2026 04:29:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27B233F36D
	for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 04:29:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782102595; cv=none; b=uz6YkLNKnSyQsTMvRu9dmNwskTq4KnkgX2NEmoABx9K7KciQk8Rg8Ibdvf+HcbYPtFZNpuWx+LCGXAIYO2gjslPeuN6dylCuWMtGiBhX2zXheZlEujpzhgB/KcROYKGblnxX07ZjVIvkidGB6QX2kMsNnIn3vDqIgwtEW4Cf+Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782102595; c=relaxed/simple;
	bh=l7BxCslFh8INkGNeb+nQ2dSygEcgotBHy62qrpKjK1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6ZKlHqgGDWoaZwLpfaz1itDDnFDCzZcW8H3FsxwZ1cD19KoGmpIP+oZoqn9yd8gYPzHHRVA8e5U/NFUb4Tj6SCwYzHQ1SUsX1kxzM99OW51AxJjg3HtI9TTyXuyLC8DObGitgke+w86knXwAPcBk2kiR4EsFIR2o2tZnrzmMV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ieCQHQ2d; arc=none smtp.client-ip=91.218.175.188
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782102575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0N/PPU5hMDuPcxDKVT07dl4VsMT4dEBTAX2VcBexvA=;
	b=ieCQHQ2d3enbbGkNm28eneTrFqy9uqtbpGNzuLJhNK6WPtryodGq/spbhbW7rnD63Sq1FA
	0OX9tGC7A8VJdKI1GGeCn1cqmOm0y+xm+Oi++lbMaxguelWyYPRwMJRbn28rnDCf+135uU
	8CjMgSKstUV8jdnZGsckuZ9mNy7iC9s=
From: Kaitao Cheng <kaitao.cheng@linux.dev>
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Maarten Lankhorst <dev@lankhorst.se>,
	Maxime Ripard <mripard@kernel.org>,
	Natalie Vock <natalie.vock@gmx.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Kees Cook <kees@kernel.org>,
	Balbir Singh <bsingharora@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	John Stultz <jstultz@google.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	David Vernet <void@manifault.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	cgroups@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	live-patching@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rcu@vger.kernel.org,
	sched-ext@lists.linux.dev,
	llvm@lists.linux.dev,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH v3 5/7] kernel: Use mutable list iterators
Date: Mon, 22 Jun 2026 12:28:11 +0800
Message-ID: <20260622042811.31684-1-kaitao.cheng@linux.dev>
In-Reply-To: <20260622040533.29824-1-kaitao.cheng@linux.dev>
References: <20260622040533.29824-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17122-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[kaitao.cheng@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:eparis@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:dev@lankhorst.se,m:mripard@kernel.org,m:natalie.vock@gmx.de,m:peterz@infradead.org,m:mingo@redhat.com,m:acme@kernel.org,m:namhyung@kernel.org,m:mhiramat@kernel.org,m:oleg@redhat.com,m:oberpar@linux.ibm.com,m:akpm@linux-foundation.org,m:baoquan.he@linux.dev,m:rppt@kernel.org,m:pasha.tatashin@soleen.com,m:pratyush@kernel.org,m:naveen@kernel.org,m:jpoimboe@kernel.org,m:jikos@kernel.org,m:mbenes@suse.cz,m:pmladek@suse.com,m:will@kernel.org,m:boqun@kernel.org,m:mcgrof@kernel.org,m:petr.pavlu@suse.com,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:steffen.klassert@secunet.com,m:daniel.m.jordan@oracle.com,m:rafael@kernel.org,m:dave@stgolabs.net,m:paulmck@kernel.org,m:josh@joshtriplett
 .org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:urezki@gmail.com,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:kees@kernel.org,m:bsingharora@gmail.com,m:anna-maria@linutronix.de,m:tglx@kernel.org,m:jstultz@google.com,m:kpsingh@kernel.org,m:mattbobrowski@google.com,m:nathan@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:mark.rutland@arm.com,m:mathieu.desnoyers@efficios.com,m:dietmar.eggemann@arm.com,m:void@manifault.com,m:rostedt@goodmis.org,m:audit@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:cgroups@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-perf-users@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:kexec@lists.infradead.org,m:live-patching@vger.kernel.org,m:linux-modules@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-pm@vger.kernel.org,m:rcu@vger.kernel.org,m:sched-ext@lists.linux.dev,m:llvm@lists.linux.dev,m:chengkaitao@kylinos.cn,m:johnfastabend@gmai
 l.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[paul-moore.com,redhat.com,kernel.org,iogearbox.net,gmail.com,davemloft.net,cmpxchg.org,suse.com,lankhorst.se,gmx.de,infradead.org,linux.ibm.com,linux-foundation.org,linux.dev,soleen.com,suse.cz,google.com,secunet.com,oracle.com,stgolabs.net,joshtriplett.org,nvidia.com,linaro.org,linutronix.de,arm.com,efficios.com,manifault.com,goodmis.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[84];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaitao.cheng@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87FE56AC849

From: Kaitao Cheng <chengkaitao@kylinos.cn>

The safe list iteration helpers require callers to provide a temporary
cursor even when the cursor is only used internally by the loop. This
leaves many functions with otherwise unused variables whose only purpose
is to satisfy the old iterator interface.

Use the mutable list iteration helpers for those cases. The mutable
helpers keep the same removal-safe traversal semantics, while allowing
the temporary cursor to be internal to the macro when the caller does
not need to observe it.

Convert list, hlist and llist users under kernel/ where the temporary
cursor is not used outside the iteration. Keep the explicit cursor form
where the next entry is still needed by the surrounding code.

No functional change intended.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/audit_tree.c                 |  4 +--
 kernel/audit_watch.c                | 16 ++++-----
 kernel/auditfilter.c                |  4 +--
 kernel/auditsc.c                    |  4 +--
 kernel/bpf/arena.c                  | 10 +++---
 kernel/bpf/arraymap.c               |  8 ++---
 kernel/bpf/bpf_local_storage.c      |  3 +-
 kernel/bpf/bpf_lru_list.c           | 25 ++++++-------
 kernel/bpf/btf.c                    | 18 +++++-----
 kernel/bpf/cgroup.c                 |  7 ++--
 kernel/bpf/cpumap.c                 |  4 +--
 kernel/bpf/devmap.c                 | 10 +++---
 kernel/bpf/helpers.c                |  8 ++---
 kernel/bpf/local_storage.c          |  4 +--
 kernel/bpf/memalloc.c               | 16 ++++-----
 kernel/bpf/offload.c                |  8 ++---
 kernel/bpf/states.c                 |  4 +--
 kernel/bpf/stream.c                 |  4 +--
 kernel/bpf/verifier.c               |  6 ++--
 kernel/cgroup/cgroup-v1.c           |  4 +--
 kernel/cgroup/cgroup.c              | 54 ++++++++++++++---------------
 kernel/cgroup/dmem.c                | 12 +++----
 kernel/cgroup/rdma.c                |  8 ++---
 kernel/events/core.c                | 44 +++++++++++------------
 kernel/events/uprobes.c             | 12 +++----
 kernel/exit.c                       |  8 ++---
 kernel/fail_function.c              |  4 +--
 kernel/gcov/clang.c                 |  4 +--
 kernel/irq_work.c                   |  4 +--
 kernel/kexec_core.c                 |  4 +--
 kernel/kprobes.c                    | 16 ++++-----
 kernel/livepatch/core.c             |  4 +--
 kernel/livepatch/core.h             |  4 +--
 kernel/liveupdate/kho_block.c       |  4 +--
 kernel/liveupdate/luo_flb.c         |  4 +--
 kernel/locking/rwsem.c              |  2 +-
 kernel/locking/test-ww_mutex.c      |  2 +-
 kernel/module/main.c                | 11 +++---
 kernel/padata.c                     |  4 +--
 kernel/power/snapshot.c             |  8 ++---
 kernel/power/wakelock.c             |  4 +--
 kernel/printk/printk.c              | 11 +++---
 kernel/ptrace.c                     |  4 +--
 kernel/rcu/rcutorture.c             |  3 +-
 kernel/rcu/tasks.h                  |  9 +++--
 kernel/rcu/tree.c                   |  6 ++--
 kernel/resource.c                   |  4 +--
 kernel/sched/core.c                 |  4 +--
 kernel/sched/ext.c                  | 22 ++++++------
 kernel/sched/fair.c                 | 28 +++++++--------
 kernel/sched/topology.c             |  4 +--
 kernel/sched/wait.c                 |  4 +--
 kernel/seccomp.c                    |  4 +--
 kernel/signal.c                     | 11 +++---
 kernel/smp.c                        |  4 +--
 kernel/taskstats.c                  |  8 ++---
 kernel/time/clockevents.c           |  6 ++--
 kernel/time/clocksource.c           |  4 +--
 kernel/time/posix-cpu-timers.c      |  4 +--
 kernel/time/posix-timers.c          |  3 +-
 kernel/torture.c                    |  3 +-
 kernel/trace/bpf_trace.c            |  4 +--
 kernel/trace/ftrace.c               | 49 +++++++++++---------------
 kernel/trace/ring_buffer.c          | 25 +++++++------
 kernel/trace/trace.c                | 12 +++----
 kernel/trace/trace_dynevent.c       |  6 ++--
 kernel/trace/trace_dynevent.h       |  5 ++-
 kernel/trace/trace_events.c         | 35 +++++++++----------
 kernel/trace/trace_events_filter.c  |  4 +--
 kernel/trace/trace_events_hist.c    |  8 ++---
 kernel/trace/trace_events_trigger.c | 17 ++++-----
 kernel/trace/trace_events_user.c    | 16 ++++-----
 kernel/trace/trace_stat.c           |  4 +--
 kernel/user-return-notifier.c       |  3 +-
 kernel/workqueue.c                  | 16 ++++-----
 75 files changed, 353 insertions(+), 381 deletions(-)

diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index 1ed19b775912..9652b0595ad4 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -543,10 +543,10 @@ static void audit_tree_log_remove_rule(struct audit_context *context,
 
 static void kill_rules(struct audit_context *context, struct audit_tree *tree)
 {
-	struct audit_krule *rule, *next;
+	struct audit_krule *rule;
 	struct audit_entry *entry;
 
-	list_for_each_entry_safe(rule, next, &tree->rules, rlist) {
+	list_for_each_entry_mutable(rule, &tree->rules, rlist) {
 		entry = container_of(rule, struct audit_entry, rule);
 
 		list_del_init(&rule->rlist);
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 06dd0ebe73e2..f56812c8186f 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -247,14 +247,14 @@ static void audit_update_watch(struct audit_parent *parent,
 			       u64 ino, unsigned int invalidating,
 			       struct audit_watch_ctx *ctx)
 {
-	struct audit_watch *owatch, *nwatch, *nextw;
-	struct audit_krule *r, *nextr;
+	struct audit_watch *owatch, *nwatch;
+	struct audit_krule *r;
 	struct audit_entry *oentry, *nentry;
 
 	mutex_lock(&audit_filter_mutex);
 	/* Run all of the watches on this parent looking for the one that
 	 * matches the given dname */
-	list_for_each_entry_safe(owatch, nextw, &parent->watches, wlist) {
+	list_for_each_entry_mutable(owatch, &parent->watches, wlist) {
 		if (audit_compare_dname_path(dname, owatch->path,
 					     AUDIT_NAME_FULL))
 			continue;
@@ -275,7 +275,7 @@ static void audit_update_watch(struct audit_parent *parent,
 		nwatch->dev = dev;
 		nwatch->ino = ino;
 
-		list_for_each_entry_safe(r, nextr, &owatch->rules, rlist) {
+		list_for_each_entry_mutable(r, &owatch->rules, rlist) {
 
 			oentry = container_of(r, struct audit_entry, rule);
 			list_del(&oentry->rule.rlist);
@@ -322,13 +322,13 @@ static void audit_update_watch(struct audit_parent *parent,
 /* Remove all watches & rules associated with a parent that is going away. */
 static void audit_remove_parent_watches(struct audit_parent *parent)
 {
-	struct audit_watch *w, *nextw;
-	struct audit_krule *r, *nextr;
+	struct audit_watch *w;
+	struct audit_krule *r;
 	struct audit_entry *e;
 
 	mutex_lock(&audit_filter_mutex);
-	list_for_each_entry_safe(w, nextw, &parent->watches, wlist) {
-		list_for_each_entry_safe(r, nextr, &w->rules, rlist) {
+	list_for_each_entry_mutable(w, &parent->watches, wlist) {
+		list_for_each_entry_mutable(r, &w->rules, rlist) {
 			e = container_of(r, struct audit_entry, rule);
 			audit_watch_log_rule_change(r, w, "remove_rule");
 			if (e->rule.exe)
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 4401119b5275..6a4936870903 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1445,14 +1445,14 @@ static int update_lsm_rule(struct audit_krule *r)
  * updated rule. */
 int audit_update_lsm_rules(void)
 {
-	struct audit_krule *r, *n;
+	struct audit_krule *r;
 	int i, err = 0;
 
 	/* audit_filter_mutex synchronizes the writers */
 	mutex_lock(&audit_filter_mutex);
 
 	for (i = 0; i < AUDIT_NR_FILTERS; i++) {
-		list_for_each_entry_safe(r, n, &audit_rules_list[i], list) {
+		list_for_each_entry_mutable(r, &audit_rules_list[i], list) {
 			int res = update_lsm_rule(r);
 			if (!err)
 				err = res;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6610e667c728..df9c6c9e9e49 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -929,9 +929,9 @@ static inline void audit_free_module(struct audit_context *context)
 }
 static inline void audit_free_names(struct audit_context *context)
 {
-	struct audit_names *n, *next;
+	struct audit_names *n;
 
-	list_for_each_entry_safe(n, next, &context->names_list, list) {
+	list_for_each_entry_mutable(n, &context->names_list, list) {
 		list_del(&n->list);
 		if (n->name)
 			putname(n->name);
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 80b7b8a69446..597c3cd428eb 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -842,7 +842,7 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	long kaddr, pgoff;
 	struct page *page;
 	struct llist_head free_pages;
-	struct llist_node *pos, *t;
+	struct llist_node *pos;
 	struct arena_free_span *s;
 	struct clear_range_data cdata;
 	unsigned long flags;
@@ -889,7 +889,7 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 		/* bulk zap if multiple pages being freed */
 		zap_pages(arena, full_uaddr, page_cnt);
 
-	llist_for_each_safe(pos, t, __llist_del_all(&free_pages)) {
+	llist_for_each_mutable(pos, __llist_del_all(&free_pages)) {
 		page = llist_entry(pos, struct page, pcp_llist);
 		if (page_cnt == 1 && page_ref_count(page) > 1) /* maybe mapped by user space */
 			/* Optimization for the common case of page_cnt==1:
@@ -963,7 +963,7 @@ static void arena_free_worker(struct work_struct *work)
 {
 	struct bpf_arena *arena = container_of(work, struct bpf_arena, free_work);
 	struct mem_cgroup *new_memcg, *old_memcg;
-	struct llist_node *list, *pos, *t;
+	struct llist_node *list, *pos;
 	struct arena_free_span *s;
 	u64 arena_vm_start, user_vm_start;
 	struct llist_head free_pages;
@@ -1002,7 +1002,7 @@ static void arena_free_worker(struct work_struct *work)
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 
 	/* Iterate the list again without holding spinlock to do the tlb flush and zap_pages */
-	llist_for_each_safe(pos, t, list) {
+	llist_for_each_mutable(pos, list) {
 		s = llist_entry(pos, struct arena_free_span, node);
 		page_cnt = s->page_cnt;
 		full_uaddr = clear_lo32(user_vm_start) + s->uaddr;
@@ -1018,7 +1018,7 @@ static void arena_free_worker(struct work_struct *work)
 	}
 
 	/* free all pages collected by apply_to_existing_page_range() in the first loop */
-	llist_for_each_safe(pos, t, __llist_del_all(&free_pages)) {
+	llist_for_each_mutable(pos, __llist_del_all(&free_pages)) {
 		page = llist_entry(pos, struct page, pcp_llist);
 		__free_page(page);
 	}
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 248b4818178c..1150179a90f7 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -1083,12 +1083,12 @@ static int prog_array_map_poke_track(struct bpf_map *map,
 static void prog_array_map_poke_untrack(struct bpf_map *map,
 					struct bpf_prog_aux *prog_aux)
 {
-	struct prog_poke_elem *elem, *tmp;
+	struct prog_poke_elem *elem;
 	struct bpf_array_aux *aux;
 
 	aux = container_of(map, struct bpf_array, map)->aux;
 	mutex_lock(&aux->poke_mutex);
-	list_for_each_entry_safe(elem, tmp, &aux->poke_progs, list) {
+	list_for_each_entry_mutable(elem, &aux->poke_progs, list) {
 		if (elem->aux == prog_aux) {
 			list_del_init(&elem->list);
 			kfree(elem);
@@ -1196,11 +1196,11 @@ static struct bpf_map *prog_array_map_alloc(union bpf_attr *attr)
 
 static void prog_array_map_free(struct bpf_map *map)
 {
-	struct prog_poke_elem *elem, *tmp;
+	struct prog_poke_elem *elem;
 	struct bpf_array_aux *aux;
 
 	aux = container_of(map, struct bpf_array, map)->aux;
-	list_for_each_entry_safe(elem, tmp, &aux->poke_progs, list) {
+	list_for_each_entry_mutable(elem, &aux->poke_progs, list) {
 		list_del_init(&elem->list);
 		kfree(elem);
 	}
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 6fc6a4b672b5..5f01ba032b12 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -161,14 +161,13 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 static void bpf_selem_free_list(struct hlist_head *list, bool reuse_now)
 {
 	struct bpf_local_storage_elem *selem;
-	struct hlist_node *n;
 
 	/* The "_safe" iteration is needed.
 	 * The loop is not removing the selem from the list
 	 * but bpf_selem_free will use the selem->rcu_head
 	 * which is union-ized with the selem->free_node.
 	 */
-	hlist_for_each_entry_safe(selem, n, list, free_node)
+	hlist_for_each_entry_mutable(selem, list, free_node)
 		bpf_selem_free(selem, reuse_now);
 }
 
diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index 5ed7cb4b98c0..4b7306ade684 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -126,11 +126,11 @@ static void __bpf_lru_list_rotate_active(struct bpf_lru *lru,
 					 struct bpf_lru_list *l)
 {
 	struct list_head *active = &l->lists[BPF_LRU_LIST_T_ACTIVE];
-	struct bpf_lru_node *node, *tmp_node, *first_node;
+	struct bpf_lru_node *node, *first_node;
 	unsigned int i = 0;
 
 	first_node = list_first_entry(active, struct bpf_lru_node, list);
-	list_for_each_entry_safe_reverse(node, tmp_node, active, list) {
+	list_for_each_entry_mutable_reverse(node, active, list) {
 		if (bpf_lru_node_is_ref(node))
 			__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_ACTIVE);
 		else
@@ -196,11 +196,11 @@ __bpf_lru_list_shrink_inactive(struct bpf_lru *lru,
 			       enum bpf_lru_list_type tgt_free_type)
 {
 	struct list_head *inactive = &l->lists[BPF_LRU_LIST_T_INACTIVE];
-	struct bpf_lru_node *node, *tmp_node;
+	struct bpf_lru_node *node;
 	unsigned int nshrinked = 0;
 	unsigned int i = 0;
 
-	list_for_each_entry_safe_reverse(node, tmp_node, inactive, list) {
+	list_for_each_entry_mutable_reverse(node, inactive, list) {
 		if (bpf_lru_node_is_ref(node) &&
 		    !READ_ONCE(node->pending_free)) {
 			__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_ACTIVE);
@@ -247,7 +247,7 @@ static unsigned int __bpf_lru_list_shrink(struct bpf_lru *lru,
 					  enum bpf_lru_list_type tgt_free_type)
 
 {
-	struct bpf_lru_node *node, *tmp_node;
+	struct bpf_lru_node *node;
 	struct list_head *force_shrink_list;
 	unsigned int nshrinked;
 
@@ -262,8 +262,7 @@ static unsigned int __bpf_lru_list_shrink(struct bpf_lru *lru,
 	else
 		force_shrink_list = &l->lists[BPF_LRU_LIST_T_ACTIVE];
 
-	list_for_each_entry_safe_reverse(node, tmp_node, force_shrink_list,
-					 list) {
+	list_for_each_entry_mutable_reverse(node, force_shrink_list, list) {
 		if (READ_ONCE(node->pending_free) ||
 		    lru->del_from_htab(lru->del_arg, node)) {
 			__bpf_lru_node_move_to_free(l, node, free_list,
@@ -279,10 +278,9 @@ static unsigned int __bpf_lru_list_shrink(struct bpf_lru *lru,
 static void __local_list_flush(struct bpf_lru_list *l,
 			       struct bpf_lru_locallist *loc_l)
 {
-	struct bpf_lru_node *node, *tmp_node;
+	struct bpf_lru_node *node;
 
-	list_for_each_entry_safe_reverse(node, tmp_node,
-					 &loc_l->pending_list, list) {
+	list_for_each_entry_mutable_reverse(node, &loc_l->pending_list, list) {
 		if (READ_ONCE(node->pending_free))
 			__bpf_lru_node_move_in(l, node, BPF_LRU_LIST_T_FREE);
 		else if (bpf_lru_node_is_ref(node))
@@ -313,7 +311,7 @@ static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
 					   struct bpf_lru_locallist *loc_l)
 {
 	struct bpf_lru_list *l = &lru->common_lru.lru_list;
-	struct bpf_lru_node *node, *tmp_node;
+	struct bpf_lru_node *node;
 	unsigned int nfree = 0;
 	LIST_HEAD(tmp_free);
 
@@ -324,8 +322,7 @@ static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
 
 	__bpf_lru_list_rotate(lru, l);
 
-	list_for_each_entry_safe(node, tmp_node, &l->lists[BPF_LRU_LIST_T_FREE],
-				 list) {
+	list_for_each_entry_mutable(node, &l->lists[BPF_LRU_LIST_T_FREE], list) {
 		__bpf_lru_node_move_to_free(l, node, &tmp_free,
 					    BPF_LRU_LOCAL_LIST_T_FREE);
 		if (++nfree == lru->target_free)
@@ -343,7 +340,7 @@ static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
 	 * Transfer the harvested nodes from the temporary list_head into
 	 * the lockless per-CPU free llist.
 	 */
-	list_for_each_entry_safe(node, tmp_node, &tmp_free, list) {
+	list_for_each_entry_mutable(node, &tmp_free, list) {
 		list_del(&node->list);
 		llist_add(&node->llist, &loc_l->free_llist);
 	}
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 15ae7c43f594..983928bd774b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8439,7 +8439,7 @@ static void purge_cand_cache(struct btf *btf);
 static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			     void *module)
 {
-	struct btf_module *btf_mod, *tmp;
+	struct btf_module *btf_mod;
 	struct module *mod = module;
 	struct btf *btf;
 	int err = 0;
@@ -8512,7 +8512,7 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 		break;
 	case MODULE_STATE_LIVE:
 		mutex_lock(&btf_module_mutex);
-		list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
+		list_for_each_entry_mutable(btf_mod, &btf_modules, list) {
 			if (btf_mod->module != module)
 				continue;
 
@@ -8523,7 +8523,7 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 		break;
 	case MODULE_STATE_GOING:
 		mutex_lock(&btf_module_mutex);
-		list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
+		list_for_each_entry_mutable(btf_mod, &btf_modules, list) {
 			if (btf_mod->module != module)
 				continue;
 
@@ -8567,10 +8567,10 @@ struct module *btf_try_get_module(const struct btf *btf)
 {
 	struct module *res = NULL;
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
-	struct btf_module *btf_mod, *tmp;
+	struct btf_module *btf_mod;
 
 	mutex_lock(&btf_module_mutex);
-	list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
+	list_for_each_entry_mutable(btf_mod, &btf_modules, list) {
 		if (btf_mod->btf != btf)
 			continue;
 
@@ -8596,7 +8596,7 @@ struct module *btf_try_get_module(const struct btf *btf)
 static struct btf *btf_get_module_btf(const struct module *module)
 {
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
-	struct btf_module *btf_mod, *tmp;
+	struct btf_module *btf_mod;
 #endif
 	struct btf *btf = NULL;
 
@@ -8609,7 +8609,7 @@ static struct btf *btf_get_module_btf(const struct module *module)
 
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	mutex_lock(&btf_module_mutex);
-	list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
+	list_for_each_entry_mutable(btf_mod, &btf_modules, list) {
 		if (btf_mod->module != module)
 			continue;
 
@@ -8773,7 +8773,7 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
 static int btf_check_kfunc_name(struct btf *btf, const char *func_name, u32 kind)
 {
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
-	struct btf_module *btf_mod, *tmp;
+	struct btf_module *btf_mod;
 #endif
 	s32 id;
 
@@ -8789,7 +8789,7 @@ static int btf_check_kfunc_name(struct btf *btf, const char *func_name, u32 kind
 
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	guard(mutex)(&btf_module_mutex);
-	list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
+	list_for_each_entry_mutable(btf_mod, &btf_modules, list) {
 		if (btf_mod->btf == btf)
 			continue;
 		id = btf_find_by_name_kind(btf_mod->btf, func_name, kind);
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 83ce66296ac1..a3bd18ab9246 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -328,7 +328,7 @@ static void cgroup_bpf_release(struct work_struct *work)
 					       bpf.release_work);
 	struct bpf_prog_array *old_array;
 	struct list_head *storages = &cgrp->bpf.storages;
-	struct bpf_cgroup_storage *storage, *stmp;
+	struct bpf_cgroup_storage *storage;
 
 	unsigned int atype;
 
@@ -337,9 +337,8 @@ static void cgroup_bpf_release(struct work_struct *work)
 	for (atype = 0; atype < ARRAY_SIZE(cgrp->bpf.progs); atype++) {
 		struct hlist_head *progs = &cgrp->bpf.progs[atype];
 		struct bpf_prog_list *pl;
-		struct hlist_node *pltmp;
 
-		hlist_for_each_entry_safe(pl, pltmp, progs, node) {
+		hlist_for_each_entry_mutable(pl, progs, node) {
 			hlist_del(&pl->node);
 			if (pl->prog) {
 				if (pl->prog->expected_attach_type == BPF_LSM_CGROUP)
@@ -360,7 +359,7 @@ static void cgroup_bpf_release(struct work_struct *work)
 		bpf_prog_array_free(old_array);
 	}
 
-	list_for_each_entry_safe(storage, stmp, storages, list_cg) {
+	list_for_each_entry_mutable(storage, storages, list_cg) {
 		bpf_cgroup_storage_unlink(storage);
 		bpf_cgroup_storage_free(storage);
 	}
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 5e59ab896f05..fa3a1b3559e2 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -821,9 +821,9 @@ int cpu_map_generic_redirect(struct bpf_cpu_map_entry *rcpu,
 
 void __cpu_map_flush(struct list_head *flush_list)
 {
-	struct xdp_bulk_queue *bq, *tmp;
+	struct xdp_bulk_queue *bq;
 
-	list_for_each_entry_safe(bq, tmp, flush_list, flush_node) {
+	list_for_each_entry_mutable(bq, flush_list, flush_node) {
 		local_lock_nested_bh(&bq->obj->bulkq->bq_lock);
 		bq_flush_to_queue(bq);
 		local_unlock_nested_bh(&bq->obj->bulkq->bq_lock);
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index dc7b859e8bbf..d85e4f955061 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -219,11 +219,10 @@ static void dev_map_free(struct bpf_map *map)
 		for (i = 0; i < dtab->n_buckets; i++) {
 			struct bpf_dtab_netdev *dev;
 			struct hlist_head *head;
-			struct hlist_node *next;
 
 			head = dev_map_index_hash(dtab, i);
 
-			hlist_for_each_entry_safe(dev, next, head, index_hlist) {
+			hlist_for_each_entry_mutable(dev, head, index_hlist) {
 				hlist_del_rcu(&dev->index_hlist);
 				if (dev->xdp_prog)
 					bpf_prog_put(dev->xdp_prog);
@@ -426,9 +425,9 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
  */
 void __dev_flush(struct list_head *flush_list)
 {
-	struct xdp_dev_bulk_queue *bq, *tmp;
+	struct xdp_dev_bulk_queue *bq;
 
-	list_for_each_entry_safe(bq, tmp, flush_list, flush_node) {
+	list_for_each_entry_mutable(bq, flush_list, flush_node) {
 		local_lock_nested_bh(&bq->dev->xdp_bulkq->bq_lock);
 		bq_xmit_all(bq, XDP_XMIT_FLUSH);
 		bq->dev_rx = NULL;
@@ -1124,11 +1123,10 @@ static void dev_map_hash_remove_netdev(struct bpf_dtab *dtab,
 	for (i = 0; i < dtab->n_buckets; i++) {
 		struct bpf_dtab_netdev *dev;
 		struct hlist_head *head;
-		struct hlist_node *next;
 
 		head = dev_map_index_hash(dtab, i);
 
-		hlist_for_each_entry_safe(dev, next, head, index_hlist) {
+		hlist_for_each_entry_mutable(dev, head, index_hlist) {
 			if (netdev != dev->dev)
 				continue;
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c18f1e16edee..cfaf97dd970a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1662,7 +1662,7 @@ static void bpf_async_process_op(struct bpf_async_cb *cb, u32 op,
 static void bpf_async_irq_worker(struct irq_work *work)
 {
 	struct bpf_async_cb *cb = container_of(work, struct bpf_async_cb, worker);
-	struct llist_node *pos, *n, *list;
+	struct llist_node *pos, *list;
 
 	list = llist_del_all(&cb->async_cmds);
 	if (!list)
@@ -1670,7 +1670,7 @@ static void bpf_async_irq_worker(struct irq_work *work)
 
 	list = llist_reverse_order(list);
 	this_cpu_write(async_cb_running, cb);
-	llist_for_each_safe(pos, n, list) {
+	llist_for_each_mutable(pos, list) {
 		struct bpf_async_cmd *cmd;
 
 		cmd = container_of(pos, struct bpf_async_cmd, node);
@@ -2247,7 +2247,7 @@ EXPORT_SYMBOL_GPL(bpf_base_func_proto);
 void bpf_list_head_free(const struct btf_field *field, void *list_head,
 			struct bpf_spin_lock *spin_lock)
 {
-	struct list_head *head = list_head, drain, *pos, *n;
+	struct list_head *head = list_head, drain, *pos;
 
 	BUILD_BUG_ON(sizeof(struct list_head) > sizeof(struct bpf_list_head));
 	BUILD_BUG_ON(__alignof__(struct list_head) > __alignof__(struct bpf_list_head));
@@ -2262,7 +2262,7 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
 	__bpf_spin_lock_irqsave(spin_lock);
 	if (!head->next || list_empty(head))
 		goto unlock;
-	list_for_each_safe(pos, n, head) {
+	list_for_each_mutable(pos, head) {
 		struct bpf_list_node_kern *node;
 
 		node = container_of(pos, struct bpf_list_node_kern, list_head);
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 23267213a17f..2595c5a4d171 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -342,11 +342,11 @@ static void cgroup_storage_map_free(struct bpf_map *_map)
 {
 	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
 	struct list_head *storages = &map->list;
-	struct bpf_cgroup_storage *storage, *stmp;
+	struct bpf_cgroup_storage *storage;
 
 	cgroup_lock();
 
-	list_for_each_entry_safe(storage, stmp, storages, list_map) {
+	list_for_each_entry_mutable(storage, storages, list_map) {
 		bpf_cgroup_storage_unlink(storage);
 		bpf_cgroup_storage_free(storage);
 	}
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index e9662db7198f..09adb1d0e101 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -264,10 +264,10 @@ static void free_one(void *obj, bool percpu)
 
 static int free_all(struct bpf_mem_cache *c, struct llist_node *llnode, bool percpu)
 {
-	struct llist_node *pos, *t;
+	struct llist_node *pos;
 	int cnt = 0;
 
-	llist_for_each_safe(pos, t, llnode) {
+	llist_for_each_mutable(pos, llnode) {
 		if (c->dtor)
 			c->dtor((void *)pos + LLIST_NODE_SZ, c->dtor_ctx);
 		free_one(pos, percpu);
@@ -296,7 +296,7 @@ static void enque_to_free(struct bpf_mem_cache *c, void *obj)
 
 static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 {
-	struct llist_node *llnode, *t;
+	struct llist_node *llnode;
 
 	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)) {
 		if (unlikely(READ_ONCE(c->draining))) {
@@ -307,7 +307,7 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 	}
 
 	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp_ttrace));
-	llist_for_each_safe(llnode, t, llist_del_all(&c->free_by_rcu_ttrace))
+	llist_for_each_mutable(llnode, llist_del_all(&c->free_by_rcu_ttrace))
 		llist_add(llnode, &c->waiting_for_gp_ttrace);
 
 	if (unlikely(READ_ONCE(c->draining))) {
@@ -326,7 +326,7 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 static void free_bulk(struct bpf_mem_cache *c)
 {
 	struct bpf_mem_cache *tgt = c->tgt;
-	struct llist_node *llnode, *t;
+	struct llist_node *llnode;
 	unsigned long flags;
 	int cnt;
 
@@ -346,7 +346,7 @@ static void free_bulk(struct bpf_mem_cache *c)
 	} while (cnt > (c->high_watermark + c->low_watermark) / 2);
 
 	/* and drain free_llist_extra */
-	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra))
+	llist_for_each_mutable(llnode, llist_del_all(&c->free_llist_extra))
 		enque_to_free(tgt, llnode);
 	do_call_rcu_ttrace(tgt);
 }
@@ -374,13 +374,13 @@ static void __free_by_rcu(struct rcu_head *head)
 
 static void check_free_by_rcu(struct bpf_mem_cache *c)
 {
-	struct llist_node *llnode, *t;
+	struct llist_node *llnode;
 	unsigned long flags;
 
 	/* drain free_llist_extra_rcu */
 	if (unlikely(!llist_empty(&c->free_llist_extra_rcu))) {
 		inc_active(c, &flags);
-		llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra_rcu))
+		llist_for_each_mutable(llnode, llist_del_all(&c->free_llist_extra_rcu))
 			if (__llist_add(llnode, &c->free_by_rcu))
 				c->free_by_rcu_tail = llnode;
 		dec_active(c, &flags);
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 0d6f5569588c..32a21613fe79 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -137,8 +137,8 @@ static void __bpf_offload_dev_netdev_unregister(struct bpf_offload_dev *offdev,
 						struct net_device *netdev)
 {
 	struct bpf_offload_netdev *ondev, *altdev = NULL;
-	struct bpf_offloaded_map *offmap, *mtmp;
-	struct bpf_prog_offload *offload, *ptmp;
+	struct bpf_offloaded_map *offmap;
+	struct bpf_prog_offload *offload;
 
 	ASSERT_RTNL();
 
@@ -165,9 +165,9 @@ static void __bpf_offload_dev_netdev_unregister(struct bpf_offload_dev *offdev,
 			offmap->netdev = altdev->netdev;
 		list_splice_init(&ondev->maps, &altdev->maps);
 	} else {
-		list_for_each_entry_safe(offload, ptmp, &ondev->progs, offloads)
+		list_for_each_entry_mutable(offload, &ondev->progs, offloads)
 			__bpf_prog_offload_destroy(offload->prog);
-		list_for_each_entry_safe(offmap, mtmp, &ondev->maps, offloads)
+		list_for_each_entry_mutable(offmap, &ondev->maps, offloads)
 			__bpf_map_offload_destroy(offmap);
 	}
 
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 32f346ce3ffc..ec7942049c06 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -1241,7 +1241,7 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	struct bpf_verifier_state *cur = env->cur_state, *new;
 	bool force_new_state, add_new_state, loop;
 	int n, err, states_cnt = 0;
-	struct list_head *pos, *tmp, *head;
+	struct list_head *pos, *head;
 
 	force_new_state = env->test_state_freq || bpf_is_force_checkpoint(env, insn_idx) ||
 			  /* Avoid accumulating infinitely long jmp history */
@@ -1267,7 +1267,7 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 
 	loop = false;
 	head = bpf_explored_state(env, insn_idx);
-	list_for_each_safe(pos, tmp, head) {
+	list_for_each_mutable(pos, head) {
 		sl = container_of(pos, struct bpf_verifier_state_list, node);
 		states_cnt++;
 		if (sl->state.insn_idx != insn_idx)
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index be9ce98e9469..3d722cfd1d07 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -96,9 +96,9 @@ static void bpf_stream_free_elem(struct bpf_stream_elem *elem)
 
 static void bpf_stream_free_list(struct llist_node *list)
 {
-	struct bpf_stream_elem *elem, *tmp;
+	struct bpf_stream_elem *elem;
 
-	llist_for_each_entry_safe(elem, tmp, list, node)
+	llist_for_each_entry_mutable(elem, list, node)
 		bpf_stream_free_elem(elem);
 }
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2abc79dbf281..7cd5d10b390a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18285,7 +18285,7 @@ static void sanitize_dead_code(struct bpf_verifier_env *env)
 static void free_states(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_state_list *sl;
-	struct list_head *head, *pos, *tmp;
+	struct list_head *head, *pos;
 	struct bpf_scc_info *info;
 	int i, j;
 
@@ -18293,7 +18293,7 @@ static void free_states(struct bpf_verifier_env *env)
 	env->cur_state = NULL;
 	while (!pop_stack(env, NULL, NULL, false));
 
-	list_for_each_safe(pos, tmp, &env->free_list) {
+	list_for_each_mutable(pos, &env->free_list) {
 		sl = container_of(pos, struct bpf_verifier_state_list, node);
 		bpf_free_verifier_state(&sl->state, false);
 		kfree(sl);
@@ -18316,7 +18316,7 @@ static void free_states(struct bpf_verifier_env *env)
 	for (i = 0; i < state_htab_size(env); i++) {
 		head = &env->explored_states[i];
 
-		list_for_each_safe(pos, tmp, head) {
+		list_for_each_mutable(pos, head) {
 			sl = container_of(pos, struct bpf_verifier_state_list, node);
 			bpf_free_verifier_state(&sl->state, false);
 			kfree(sl);
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index a4337c9b5287..1c777b28861f 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -205,10 +205,10 @@ struct cgroup_pidlist {
  */
 void cgroup1_pidlist_destroy_all(struct cgroup *cgrp)
 {
-	struct cgroup_pidlist *l, *tmp_l;
+	struct cgroup_pidlist *l;
 
 	mutex_lock(&cgrp->pidlist_mutex);
-	list_for_each_entry_safe(l, tmp_l, &cgrp->pidlists, links)
+	list_for_each_entry_mutable(l, &cgrp->pidlists, links)
 		mod_delayed_work(cgroup_pidlist_destroy_wq, &l->destroy_dwork, 0);
 	mutex_unlock(&cgrp->pidlist_mutex);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 38f8d9df8fbc..2b619c1553ee 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -872,9 +872,9 @@ static void css_set_update_populated(struct css_set *cset, bool populated)
 static void css_set_skip_task_iters(struct css_set *cset,
 				    struct task_struct *task)
 {
-	struct css_task_iter *it, *pos;
+	struct css_task_iter *it;
 
-	list_for_each_entry_safe(it, pos, &cset->task_iters, iters_node)
+	list_for_each_entry_mutable(it, &cset->task_iters, iters_node)
 		css_task_iter_skip(it, task);
 }
 
@@ -951,7 +951,7 @@ static unsigned long css_set_hash(struct cgroup_subsys_state **css)
 
 void put_css_set_locked(struct css_set *cset)
 {
-	struct cgrp_cset_link *link, *tmp_link;
+	struct cgrp_cset_link *link;
 	struct cgroup_subsys *ss;
 	int ssid;
 
@@ -970,7 +970,7 @@ void put_css_set_locked(struct css_set *cset)
 	hash_del(&cset->hlist);
 	css_set_count--;
 
-	list_for_each_entry_safe(link, tmp_link, &cset->cgrp_links, cgrp_link) {
+	list_for_each_entry_mutable(link, &cset->cgrp_links, cgrp_link) {
 		list_del(&link->cset_link);
 		list_del(&link->cgrp_link);
 		if (cgroup_parent(link->cgrp))
@@ -1129,9 +1129,9 @@ static struct css_set *find_existing_css_set(struct css_set *old_cset,
 
 static void free_cgrp_cset_links(struct list_head *links_to_free)
 {
-	struct cgrp_cset_link *link, *tmp_link;
+	struct cgrp_cset_link *link;
 
-	list_for_each_entry_safe(link, tmp_link, links_to_free, cset_link) {
+	list_for_each_entry_mutable(link, links_to_free, cset_link) {
 		list_del(&link->cset_link);
 		kfree(link);
 	}
@@ -1372,7 +1372,7 @@ void cgroup_free_root(struct cgroup_root *root)
 static void cgroup_destroy_root(struct cgroup_root *root)
 {
 	struct cgroup *cgrp = &root->cgrp;
-	struct cgrp_cset_link *link, *tmp_link;
+	struct cgrp_cset_link *link;
 	int ret;
 
 	trace_cgroup_destroy_root(root);
@@ -1395,7 +1395,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 	 */
 	spin_lock_irq(&css_set_lock);
 
-	list_for_each_entry_safe(link, tmp_link, &cgrp->cset_links, cset_link) {
+	list_for_each_entry_mutable(link, &cgrp->cset_links, cset_link) {
 		list_del(&link->cset_link);
 		list_del(&link->cgrp_link);
 		kfree(link);
@@ -1887,7 +1887,7 @@ int rebind_subsystems(struct cgroup_root *dst_root, u32 ss_mask)
 		struct cgroup_root *src_root = ss->root;
 		struct cgroup *scgrp = &src_root->cgrp;
 		struct cgroup_subsys_state *css = cgroup_css(scgrp, ss);
-		struct css_set *cset, *cset_pos;
+		struct css_set *cset;
 		struct css_task_iter *it;
 
 		WARN_ON(!css || cgroup_css(dcgrp, ss));
@@ -1912,8 +1912,8 @@ int rebind_subsystems(struct cgroup_root *dst_root, u32 ss_mask)
 		spin_lock_irq(&css_set_lock);
 		css->cgroup = dcgrp;
 		WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
-		list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id],
-					 e_cset_node[ss->id]) {
+		list_for_each_entry_mutable(cset, &scgrp->e_csets[ss->id],
+					    e_cset_node[ss->id]) {
 			list_move_tail(&cset->e_cset_node[ss->id],
 				       &dcgrp->e_csets[ss->id]);
 			/*
@@ -2689,8 +2689,8 @@ static int cgroup_migrate_execute(struct cgroup_mgctx *mgctx)
 {
 	struct cgroup_taskset *tset = &mgctx->tset;
 	struct cgroup_subsys *ss;
-	struct task_struct *task, *tmp_task;
-	struct css_set *cset, *tmp_cset;
+	struct task_struct *task;
+	struct css_set *cset;
 	int ssid, failed_ssid, ret;
 
 	/* check that we can legitimately attach to the cgroup */
@@ -2714,7 +2714,7 @@ static int cgroup_migrate_execute(struct cgroup_mgctx *mgctx)
 	 */
 	spin_lock_irq(&css_set_lock);
 	list_for_each_entry(cset, &tset->src_csets, mg_node) {
-		list_for_each_entry_safe(task, tmp_task, &cset->mg_tasks, cg_list) {
+		list_for_each_entry_mutable(task, &cset->mg_tasks, cg_list) {
 			struct css_set *from_cset = task_css_set(task);
 			struct css_set *to_cset = cset->mg_dst_cset;
 
@@ -2767,7 +2767,7 @@ static int cgroup_migrate_execute(struct cgroup_mgctx *mgctx)
 out_release_tset:
 	spin_lock_irq(&css_set_lock);
 	list_splice_init(&tset->dst_csets, &tset->src_csets);
-	list_for_each_entry_safe(cset, tmp_cset, &tset->src_csets, mg_node) {
+	list_for_each_entry_mutable(cset, &tset->src_csets, mg_node) {
 		list_splice_tail_init(&cset->mg_tasks, &cset->tasks);
 		list_del_init(&cset->mg_node);
 	}
@@ -2825,14 +2825,14 @@ int cgroup_migrate_vet_dst(struct cgroup *dst_cgrp)
  */
 void cgroup_migrate_finish(struct cgroup_mgctx *mgctx)
 {
-	struct css_set *cset, *tmp_cset;
+	struct css_set *cset;
 
 	lockdep_assert_held(&cgroup_mutex);
 
 	spin_lock_irq(&css_set_lock);
 
-	list_for_each_entry_safe(cset, tmp_cset, &mgctx->preloaded_src_csets,
-				 mg_src_preload_node) {
+	list_for_each_entry_mutable(cset, &mgctx->preloaded_src_csets,
+				    mg_src_preload_node) {
 		cset->mg_src_cgrp = NULL;
 		cset->mg_dst_cgrp = NULL;
 		cset->mg_dst_cset = NULL;
@@ -2840,8 +2840,8 @@ void cgroup_migrate_finish(struct cgroup_mgctx *mgctx)
 		put_css_set_locked(cset);
 	}
 
-	list_for_each_entry_safe(cset, tmp_cset, &mgctx->preloaded_dst_csets,
-				 mg_dst_preload_node) {
+	list_for_each_entry_mutable(cset, &mgctx->preloaded_dst_csets,
+				    mg_dst_preload_node) {
 		cset->mg_src_cgrp = NULL;
 		cset->mg_dst_cgrp = NULL;
 		cset->mg_dst_cset = NULL;
@@ -2917,13 +2917,13 @@ void cgroup_migrate_add_src(struct css_set *src_cset,
  */
 int cgroup_migrate_prepare_dst(struct cgroup_mgctx *mgctx)
 {
-	struct css_set *src_cset, *tmp_cset;
+	struct css_set *src_cset;
 
 	lockdep_assert_held(&cgroup_mutex);
 
 	/* look up the dst cset for each src cset and link it to src */
-	list_for_each_entry_safe(src_cset, tmp_cset, &mgctx->preloaded_src_csets,
-				 mg_src_preload_node) {
+	list_for_each_entry_mutable(src_cset, &mgctx->preloaded_src_csets,
+				    mg_src_preload_node) {
 		struct css_set *dst_cset;
 		struct cgroup_subsys *ss;
 		int ssid;
@@ -3225,10 +3225,10 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 	spin_lock_irq(&css_set_lock);
 	list_for_each_entry(src_cset, &mgctx.preloaded_src_csets,
 			    mg_src_preload_node) {
-		struct task_struct *task, *ntask;
+		struct task_struct *task;
 
 		/* all tasks in src_csets need to be migrated */
-		list_for_each_entry_safe(task, ntask, &src_cset->tasks, cg_list)
+		list_for_each_entry_mutable(task, &src_cset->tasks, cg_list)
 			cgroup_migrate_add_task(task, &mgctx);
 	}
 	spin_unlock_irq(&css_set_lock);
@@ -7106,10 +7106,10 @@ static DEFINE_PER_CPU(struct irq_work, cgrp_dead_tasks_iwork);
 static void cgrp_dead_tasks_iwork_fn(struct irq_work *iwork)
 {
 	struct llist_node *lnode;
-	struct task_struct *task, *next;
+	struct task_struct *task;
 
 	lnode = llist_del_all(this_cpu_ptr(&cgrp_dead_tasks));
-	llist_for_each_entry_safe(task, next, lnode, cg_dead_lnode) {
+	llist_for_each_entry_mutable(task, lnode, cg_dead_lnode) {
 		do_cgroup_task_dead(task);
 		put_task_struct(task);
 	}
diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 4753a67d0f0f..1daa8fb49fbe 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -203,10 +203,10 @@ static void dmemcs_offline(struct cgroup_subsys_state *css)
 static void dmemcs_free(struct cgroup_subsys_state *css)
 {
 	struct dmemcg_state *dmemcs = css_to_dmemcs(css);
-	struct dmem_cgroup_pool_state *pool, *next;
+	struct dmem_cgroup_pool_state *pool;
 
 	spin_lock(&dmemcg_lock);
-	list_for_each_entry_safe(pool, next, &dmemcs->pools, css_node) {
+	list_for_each_entry_mutable(pool, &dmemcs->pools, css_node) {
 		/*
 		 *The pool is dead and all references are 0,
 		 * no need for RCU protection with list_del_rcu or freeing.
@@ -444,9 +444,9 @@ get_cg_pool_locked(struct dmemcg_state *dmemcs, struct dmem_cgroup_region *regio
 static void dmemcg_free_rcu(struct rcu_head *rcu)
 {
 	struct dmem_cgroup_region *region = container_of(rcu, typeof(*region), rcu);
-	struct dmem_cgroup_pool_state *pool, *next;
+	struct dmem_cgroup_pool_state *pool;
 
-	list_for_each_entry_safe(pool, next, &region->pools, region_node)
+	list_for_each_entry_mutable(pool, &region->pools, region_node)
 		free_cg_pool(pool);
 	kfree(region->name);
 	kfree(region);
@@ -467,7 +467,7 @@ static void dmemcg_free_region(struct kref *ref)
  */
 void dmem_cgroup_unregister_region(struct dmem_cgroup_region *region)
 {
-	struct dmem_cgroup_pool_state *pool, *next;
+	struct dmem_cgroup_pool_state *pool;
 
 	if (!region)
 		return;
@@ -477,7 +477,7 @@ void dmem_cgroup_unregister_region(struct dmem_cgroup_region *region)
 	/* Remove from global region list */
 	list_del_rcu(&region->region_node);
 
-	list_for_each_entry_safe(pool, next, &region->pools, region_node) {
+	list_for_each_entry_mutable(pool, &region->pools, region_node) {
 		list_del_rcu(&pool->css_node);
 		list_del(&pool->region_node);
 		dmemcg_pool_put(pool);
diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
index 5e82a03b3270..5527375c16e1 100644
--- a/kernel/cgroup/rdma.c
+++ b/kernel/cgroup/rdma.c
@@ -444,7 +444,7 @@ EXPORT_SYMBOL(rdmacg_register_device);
  */
 void rdmacg_unregister_device(struct rdmacg_device *device)
 {
-	struct rdmacg_resource_pool *rpool, *tmp;
+	struct rdmacg_resource_pool *rpool;
 
 	/*
 	 * Synchronize with any active resource settings,
@@ -457,7 +457,7 @@ void rdmacg_unregister_device(struct rdmacg_device *device)
 	 * Now that this device is off the cgroup list, its safe to free
 	 * all the rpool resources.
 	 */
-	list_for_each_entry_safe(rpool, tmp, &device->rpools, dev_node)
+	list_for_each_entry_mutable(rpool, &device->rpools, dev_node)
 		free_cg_rpool_locked(rpool);
 
 	mutex_unlock(&rdmacg_mutex);
@@ -747,11 +747,11 @@ rdmacg_css_alloc(struct cgroup_subsys_state *parent)
 static void rdmacg_css_free(struct cgroup_subsys_state *css)
 {
 	struct rdma_cgroup *cg = css_rdmacg(css);
-	struct rdmacg_resource_pool *rpool, *tmp;
+	struct rdmacg_resource_pool *rpool;
 
 	/* Clean up rpools kept alive by non-zero peak values */
 	mutex_lock(&rdmacg_mutex);
-	list_for_each_entry_safe(rpool, tmp, &cg->rpools, cg_node)
+	list_for_each_entry_mutable(rpool, &cg->rpools, cg_node)
 		free_cg_rpool_locked(rpool);
 	mutex_unlock(&rdmacg_mutex);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 00e6dcb931d9..dd93436f8f2d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2346,7 +2346,7 @@ static inline struct list_head *get_event_list(struct perf_event *event)
 static void perf_group_detach(struct perf_event *event)
 {
 	struct perf_event *leader = event->group_leader;
-	struct perf_event *sibling, *tmp;
+	struct perf_event *sibling;
 	struct perf_event_context *ctx = event->ctx;
 
 	lockdep_assert_held(&ctx->lock);
@@ -2376,7 +2376,7 @@ static void perf_group_detach(struct perf_event *event)
 	 * upgrade the siblings to singleton events by adding them
 	 * to whatever list we are on.
 	 */
-	list_for_each_entry_safe(sibling, tmp, &event->sibling_list, sibling_list) {
+	list_for_each_entry_mutable(sibling, &event->sibling_list, sibling_list) {
 
 		/*
 		 * Events that have PERF_EV_CAP_SIBLING require being part of
@@ -2405,8 +2405,8 @@ static void perf_group_detach(struct perf_event *event)
 	}
 
 out:
-	for_each_sibling_event(tmp, leader)
-		perf_event__header_size(tmp);
+	for_each_sibling_event(sibling, leader)
+		perf_event__header_size(sibling);
 
 	perf_event__header_size(leader);
 }
@@ -3528,7 +3528,7 @@ static void __pmu_ctx_sched_out(struct perf_event_pmu_context *pmu_ctx,
 				enum event_type_t event_type)
 {
 	struct perf_event_context *ctx = pmu_ctx->ctx;
-	struct perf_event *event, *tmp;
+	struct perf_event *event;
 	struct pmu *pmu = pmu_ctx->pmu;
 
 	if (ctx->task && !(ctx->is_active & EVENT_ALL)) {
@@ -3543,16 +3543,14 @@ static void __pmu_ctx_sched_out(struct perf_event_pmu_context *pmu_ctx,
 
 	perf_pmu_disable(pmu);
 	if (event_type & EVENT_PINNED) {
-		list_for_each_entry_safe(event, tmp,
-					 &pmu_ctx->pinned_active,
-					 active_list)
+		list_for_each_entry_mutable(event, &pmu_ctx->pinned_active,
+					    active_list)
 			group_sched_out(event, ctx);
 	}
 
 	if (event_type & EVENT_FLEXIBLE) {
-		list_for_each_entry_safe(event, tmp,
-					 &pmu_ctx->flexible_active,
-					 active_list)
+		list_for_each_entry_mutable(event, &pmu_ctx->flexible_active,
+					    active_list)
 			group_sched_out(event, ctx);
 		/*
 		 * Since we cleared EVENT_FLEXIBLE, also clear
@@ -4738,7 +4736,7 @@ static void perf_event_exit_event(struct perf_event *event,
 static void perf_event_remove_on_exec(struct perf_event_context *ctx)
 {
 	struct perf_event_context *clone_ctx = NULL;
-	struct perf_event *event, *next;
+	struct perf_event *event;
 	unsigned long flags;
 	bool modified = false;
 
@@ -4747,7 +4745,7 @@ static void perf_event_remove_on_exec(struct perf_event_context *ctx)
 	if (WARN_ON_ONCE(ctx->task != current))
 		goto unlock;
 
-	list_for_each_entry_safe(event, next, &ctx->event_list, event_entry) {
+	list_for_each_entry_mutable(event, &ctx->event_list, event_entry) {
 		if (!event->attr.remove_on_exec)
 			continue;
 
@@ -11833,9 +11831,9 @@ perf_addr_filter_new(struct perf_event *event, struct list_head *filters)
 
 static void free_filters_list(struct list_head *filters)
 {
-	struct perf_addr_filter *filter, *iter;
+	struct perf_addr_filter *filter;
 
-	list_for_each_entry_safe(filter, iter, filters, entry) {
+	list_for_each_entry_mutable(filter, filters, entry) {
 		path_put(&filter->path);
 		list_del(&filter->entry);
 		kfree(filter);
@@ -14436,7 +14434,7 @@ static void __perf_pmu_install_event(struct pmu *pmu,
 static void __perf_pmu_install(struct perf_event_context *ctx,
 			       int cpu, struct pmu *pmu, struct list_head *events)
 {
-	struct perf_event *event, *tmp;
+	struct perf_event *event;
 
 	/*
 	 * Re-instate events in 2 passes.
@@ -14446,7 +14444,7 @@ static void __perf_pmu_install(struct perf_event_context *ctx,
 	 * leader will enable its siblings, even if those are still on the old
 	 * context.
 	 */
-	list_for_each_entry_safe(event, tmp, events, migrate_entry) {
+	list_for_each_entry_mutable(event, events, migrate_entry) {
 		if (event->group_leader == event)
 			continue;
 
@@ -14458,7 +14456,7 @@ static void __perf_pmu_install(struct perf_event_context *ctx,
 	 * Once all the siblings are setup properly, install the group leaders
 	 * to make it go.
 	 */
-	list_for_each_entry_safe(event, tmp, events, migrate_entry) {
+	list_for_each_entry_mutable(event, events, migrate_entry) {
 		list_del(&event->migrate_entry);
 		__perf_pmu_install_event(pmu, ctx, cpu, event);
 	}
@@ -14592,7 +14590,7 @@ perf_event_exit_event(struct perf_event *event,
 static void perf_event_exit_task_context(struct task_struct *task, bool exit)
 {
 	struct perf_event_context *ctx, *clone_ctx = NULL;
-	struct perf_event *child_event, *next;
+	struct perf_event *child_event;
 
 	ctx = perf_pin_task_context(task);
 	if (!ctx)
@@ -14642,7 +14640,7 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
 	if (exit)
 		perf_event_task(task, ctx, 0);
 
-	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
+	list_for_each_entry_mutable(child_event, &ctx->event_list, event_entry)
 		perf_event_exit_event(child_event, ctx, exit ? task : NULL, false);
 
 	mutex_unlock(&ctx->mutex);
@@ -14675,13 +14673,13 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
  */
 void perf_event_exit_task(struct task_struct *task)
 {
-	struct perf_event *event, *tmp;
+	struct perf_event *event;
 
 	WARN_ON_ONCE(task != current);
 
 	mutex_lock(&task->perf_event_mutex);
-	list_for_each_entry_safe(event, tmp, &task->perf_event_list,
-				 owner_entry) {
+	list_for_each_entry_mutable(event, &task->perf_event_list,
+				    owner_entry) {
 		list_del_init(&event->owner_entry);
 
 		/*
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4084e926e284..61aa48e3b5a6 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -258,13 +258,13 @@ static void delayed_uprobe_delete(struct delayed_uprobe *du)
 
 static void delayed_uprobe_remove(struct uprobe *uprobe, struct mm_struct *mm)
 {
-	struct list_head *pos, *q;
+	struct list_head *pos;
 	struct delayed_uprobe *du;
 
 	if (!uprobe && !mm)
 		return;
 
-	list_for_each_safe(pos, q, &delayed_uprobe_list) {
+	list_for_each_mutable(pos, &delayed_uprobe_list) {
 		du = list_entry(pos, struct delayed_uprobe, list);
 
 		if (uprobe && du->uprobe != uprobe)
@@ -1562,13 +1562,13 @@ static void build_probe_list(struct inode *inode,
 /* @vma contains reference counter, not the probed instruction. */
 static int delayed_ref_ctr_inc(struct vm_area_struct *vma)
 {
-	struct list_head *pos, *q;
+	struct list_head *pos;
 	struct delayed_uprobe *du;
 	unsigned long vaddr;
 	int ret = 0, err = 0;
 
 	mutex_lock(&delayed_uprobe_lock);
-	list_for_each_safe(pos, q, &delayed_uprobe_list) {
+	list_for_each_mutable(pos, &delayed_uprobe_list) {
 		du = list_entry(pos, struct delayed_uprobe, list);
 
 		if (du->mm != vma->vm_mm ||
@@ -1597,7 +1597,7 @@ static int delayed_ref_ctr_inc(struct vm_area_struct *vma)
 int uprobe_mmap(struct vm_area_struct *vma)
 {
 	struct list_head tmp_list;
-	struct uprobe *uprobe, *u;
+	struct uprobe *uprobe;
 	struct inode *inode;
 
 	if (no_uprobe_events())
@@ -1622,7 +1622,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
 	 * removed. But in this case filter_chain() must return false, all
 	 * consumers have gone away.
 	 */
-	list_for_each_entry_safe(uprobe, u, &tmp_list, pending_list) {
+	list_for_each_entry_mutable(uprobe, &tmp_list, pending_list) {
 		if (!fatal_signal_pending(current) &&
 		    filter_chain(uprobe, vma->vm_mm)) {
 			unsigned long vaddr = offset_to_vaddr(vma, uprobe->offset);
diff --git a/kernel/exit.c b/kernel/exit.c
index 1056422bc101..62ef6553253a 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -630,7 +630,7 @@ static struct task_struct *find_child_reaper(struct task_struct *father,
 {
 	struct pid_namespace *pid_ns = task_active_pid_ns(father);
 	struct task_struct *reaper = pid_ns->child_reaper;
-	struct task_struct *p, *n;
+	struct task_struct *p;
 
 	if (likely(reaper != father))
 		return reaper;
@@ -644,7 +644,7 @@ static struct task_struct *find_child_reaper(struct task_struct *father,
 
 	write_unlock_irq(&tasklist_lock);
 
-	list_for_each_entry_safe(p, n, dead, ptrace_entry) {
+	list_for_each_entry_mutable(p, dead, ptrace_entry) {
 		list_del_init(&p->ptrace_entry);
 		release_task(p);
 	}
@@ -766,7 +766,7 @@ static void forget_original_parent(struct task_struct *father,
 static void exit_notify(struct task_struct *tsk, int group_dead)
 {
 	bool autoreap;
-	struct task_struct *p, *n;
+	struct task_struct *p;
 	LIST_HEAD(dead);
 
 	write_lock_irq(&tasklist_lock);
@@ -800,7 +800,7 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 		wake_up_process(tsk->signal->group_exec_task);
 	write_unlock_irq(&tasklist_lock);
 
-	list_for_each_entry_safe(p, n, &dead, ptrace_entry) {
+	list_for_each_entry_mutable(p, &dead, ptrace_entry) {
 		list_del_init(&p->ptrace_entry);
 		release_task(p);
 	}
diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index 2eaf55005f49..357c810c4908 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -226,9 +226,9 @@ static void fei_attr_remove(struct fei_attr *attr)
 
 static void fei_attr_remove_all(void)
 {
-	struct fei_attr *attr, *n;
+	struct fei_attr *attr;
 
-	list_for_each_entry_safe(attr, n, &fei_attr_list, list) {
+	list_for_each_entry_mutable(attr, &fei_attr_list, list) {
 		fei_attr_remove(attr);
 	}
 }
diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
index fd98ced0e51d..e9a86a04d793 100644
--- a/kernel/gcov/clang.c
+++ b/kernel/gcov/clang.c
@@ -347,9 +347,9 @@ struct gcov_info *gcov_info_dup(struct gcov_info *info)
  */
 void gcov_info_free(struct gcov_info *info)
 {
-	struct gcov_fn_info *fn, *tmp;
+	struct gcov_fn_info *fn;
 
-	list_for_each_entry_safe(fn, tmp, &info->functions, head) {
+	list_for_each_entry_mutable(fn, &info->functions, head) {
 		kvfree(fn->counters);
 		list_del(&fn->head);
 		kfree(fn);
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index f7e2dc2c30c6..ce454e12cd86 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -234,7 +234,7 @@ void irq_work_single(void *arg)
 
 static void irq_work_run_list(struct llist_head *list)
 {
-	struct irq_work *work, *tmp;
+	struct irq_work *work;
 	struct llist_node *llnode;
 
 	/*
@@ -248,7 +248,7 @@ static void irq_work_run_list(struct llist_head *list)
 		return;
 
 	llnode = llist_del_all(list);
-	llist_for_each_entry_safe(work, tmp, llnode, node.llist)
+	llist_for_each_entry_mutable(work, llnode, node.llist)
 		irq_work_single(work);
 }
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index dc770b9a6d05..d50d15d4709f 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -318,9 +318,9 @@ static void kimage_free_pages(struct page *page)
 
 void kimage_free_page_list(struct list_head *list)
 {
-	struct page *page, *next;
+	struct page *page;
 
-	list_for_each_entry_safe(page, next, list, lru) {
+	list_for_each_entry_mutable(page, list, lru) {
 		list_del(&page->lru);
 		kimage_free_pages(page);
 	}
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index bfc89083daa9..8e8fd6833d1c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -228,12 +228,12 @@ static bool collect_one_slot(struct kprobe_insn_page *kip, int idx)
 
 static int collect_garbage_slots(struct kprobe_insn_cache *c)
 {
-	struct kprobe_insn_page *kip, *next;
+	struct kprobe_insn_page *kip;
 
 	/* Ensure no-one is interrupted on the garbages */
 	synchronize_rcu();
 
-	list_for_each_entry_safe(kip, next, &c->pages, list) {
+	list_for_each_entry_mutable(kip, &c->pages, list) {
 		int i;
 
 		if (kip->ngarbage == 0)
@@ -563,7 +563,7 @@ static void do_optimize_kprobes(void)
  */
 static void do_unoptimize_kprobes(void)
 {
-	struct optimized_kprobe *op, *tmp;
+	struct optimized_kprobe *op;
 
 	lockdep_assert_held(&text_mutex);
 	/* See comment in do_optimize_kprobes() */
@@ -573,7 +573,7 @@ static void do_unoptimize_kprobes(void)
 		arch_unoptimize_kprobes(&unoptimizing_list, &freeing_list);
 
 	/* Loop on 'freeing_list' for disarming and removing from kprobe hash list */
-	list_for_each_entry_safe(op, tmp, &freeing_list, list) {
+	list_for_each_entry_mutable(op, &freeing_list, list) {
 		/* Switching from detour code to origin */
 		op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
 		/* Disarm probes if marked disabled and not gone */
@@ -594,9 +594,9 @@ static void do_unoptimize_kprobes(void)
 /* Reclaim all kprobes on the 'freeing_list' */
 static void do_free_cleaned_kprobes(void)
 {
-	struct optimized_kprobe *op, *tmp;
+	struct optimized_kprobe *op;
 
-	list_for_each_entry_safe(op, tmp, &freeing_list, list) {
+	list_for_each_entry_mutable(op, &freeing_list, list) {
 		list_del_init(&op->list);
 		if (WARN_ON_ONCE(!kprobe_unused(&op->kp))) {
 			/*
@@ -2598,9 +2598,9 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
 /* Remove all symbols in given area from kprobe blacklist */
 static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
 {
-	struct kprobe_blacklist_entry *ent, *n;
+	struct kprobe_blacklist_entry *ent;
 
-	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
+	list_for_each_entry_mutable(ent, &kprobe_blacklist, list) {
 		if (ent->start_addr < start || ent->start_addr >= end)
 			continue;
 		list_del(&ent->list);
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 28d15ba58a26..6e433519bfff 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -788,9 +788,9 @@ void klp_free_patch_async(struct klp_patch *patch)
 
 void klp_free_replaced_patches_async(struct klp_patch *new_patch)
 {
-	struct klp_patch *old_patch, *tmp_patch;
+	struct klp_patch *old_patch;
 
-	klp_for_each_patch_safe(old_patch, tmp_patch) {
+	klp_for_each_patch_safe(old_patch) {
 		if (old_patch == new_patch)
 			return;
 		klp_free_patch_async(old_patch);
diff --git a/kernel/livepatch/core.h b/kernel/livepatch/core.h
index 38209c7361b6..274c8108062f 100644
--- a/kernel/livepatch/core.h
+++ b/kernel/livepatch/core.h
@@ -7,8 +7,8 @@
 extern struct mutex klp_mutex;
 extern struct list_head klp_patches;
 
-#define klp_for_each_patch_safe(patch, tmp_patch)		\
-	list_for_each_entry_safe(patch, tmp_patch, &klp_patches, list)
+#define klp_for_each_patch_safe(patch)		\
+	list_for_each_entry_mutable(patch, &klp_patches, list)
 
 #define klp_for_each_patch(patch)	\
 	list_for_each_entry(patch, &klp_patches, list)
diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.c
index 0d2a342ef422..40e42a47751c 100644
--- a/kernel/liveupdate/kho_block.c
+++ b/kernel/liveupdate/kho_block.c
@@ -298,9 +298,9 @@ int kho_block_set_restore(struct kho_block_set *bs, u64 head_pa)
  */
 void kho_block_set_destroy(struct kho_block_set *bs)
 {
-	struct kho_block *block, *tmp;
+	struct kho_block *block;
 
-	list_for_each_entry_safe(block, tmp, &bs->blocks, list) {
+	list_for_each_entry_mutable(block, &bs->blocks, list) {
 		list_del(&block->list);
 		kho_block_free_ser(bs, block->ser);
 		kfree(block);
diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
index 5c27134ce7ba..cf5d577e25e4 100644
--- a/kernel/liveupdate/luo_flb.c
+++ b/kernel/liveupdate/luo_flb.c
@@ -359,13 +359,13 @@ static void luo_flb_unregister_one(struct liveupdate_file_handler *fh,
 void luo_flb_unregister_all(struct liveupdate_file_handler *fh)
 {
 	struct list_head *flb_list = &ACCESS_PRIVATE(fh, flb_list);
-	struct luo_flb_link *iter, *tmp;
+	struct luo_flb_link *iter;
 
 	if (!liveupdate_enabled())
 		return;
 
 	lockdep_assert_held_write(&luo_register_rwlock);
-	list_for_each_entry_safe(iter, tmp, flb_list, list)
+	list_for_each_entry_mutable(iter, flb_list, list)
 		luo_flb_unregister_one(fh, iter->flb);
 }
 
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index b9c180ac1eee..8db6caf31e41 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -567,7 +567,7 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 		atomic_long_add(adjustment, &sem->count);
 
 	/* 2nd pass */
-	list_for_each_entry_safe(waiter, next, &wlist, list) {
+	list_for_each_entry_mutable(waiter, &wlist, list) {
 		struct task_struct *tsk;
 
 		tsk = waiter->task;
diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 838d631544ed..f290061a8b48 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -546,7 +546,7 @@ static void stress_reorder_work(struct work_struct *work)
 	} while (!time_after(jiffies, stress->timeout));
 
 out:
-	list_for_each_entry_safe(ll, ln, &locks, link)
+	list_for_each_entry_mutable(ll, &locks, link)
 		kfree(ll);
 	kfree(order);
 }
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 46dd8d25a605..471448804053 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -725,10 +725,10 @@ static int ref_module(struct module *a, struct module *b)
 /* Clear the unload stuff of the module. */
 static void module_unload_free(struct module *mod)
 {
-	struct module_use *use, *tmp;
+	struct module_use *use;
 
 	mutex_lock(&module_mutex);
-	list_for_each_entry_safe(use, tmp, &mod->target_list, target_list) {
+	list_for_each_entry_mutable(use, &mod->target_list, target_list) {
 		struct module *i = use->target;
 		pr_debug("%s unusing %s\n", mod->name, i->name);
 		module_put(i);
@@ -3041,14 +3041,14 @@ struct mod_initfree {
 
 static void do_free_init(struct work_struct *w)
 {
-	struct llist_node *pos, *n, *list;
+	struct llist_node *pos, *list;
 	struct mod_initfree *initfree;
 
 	list = llist_del_all(&init_free_list);
 
 	synchronize_rcu();
 
-	llist_for_each_safe(pos, n, list) {
+	llist_for_each_mutable(pos, list) {
 		initfree = container_of(pos, struct mod_initfree, node);
 		execmem_free(initfree->init_text);
 		execmem_free(initfree->init_data);
@@ -3701,11 +3701,10 @@ static int idempotent_complete(struct idempotent *u, int ret)
 	const void *cookie = u->cookie;
 	int hash = hash_ptr(cookie, IDEM_HASH_BITS);
 	struct hlist_head *head = idem_hash + hash;
-	struct hlist_node *next;
 	struct idempotent *pos;
 
 	spin_lock(&idem_lock);
-	hlist_for_each_entry_safe(pos, next, head, entry) {
+	hlist_for_each_entry_mutable(pos, head, entry) {
 		if (pos->cookie != cookie)
 			continue;
 		hlist_del_init(&pos->entry);
diff --git a/kernel/padata.c b/kernel/padata.c
index 0d3ea1b68b1f..270f7b0eca0a 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -134,13 +134,13 @@ static void padata_work_free(struct padata_work *pw)
 
 static void __init padata_works_free(struct list_head *works)
 {
-	struct padata_work *cur, *next;
+	struct padata_work *cur;
 
 	if (list_empty(works))
 		return;
 
 	spin_lock_bh(&padata_works_lock);
-	list_for_each_entry_safe(cur, next, works, pw_list) {
+	list_for_each_entry_mutable(cur, works, pw_list) {
 		list_del(&cur->pw_list);
 		padata_work_free(cur);
 	}
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index d933b5b2c05d..c4802f2a2e35 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -610,9 +610,9 @@ struct mem_extent {
  */
 static void free_mem_extents(struct list_head *list)
 {
-	struct mem_extent *ext, *aux;
+	struct mem_extent *ext;
 
-	list_for_each_entry_safe(ext, aux, list, hook) {
+	list_for_each_entry_mutable(ext, list, hook) {
 		list_del(&ext->hook);
 		kfree(ext);
 	}
@@ -633,7 +633,7 @@ static int create_mem_extents(struct list_head *list, gfp_t gfp_mask)
 
 	for_each_populated_zone(zone) {
 		unsigned long zone_start, zone_end;
-		struct mem_extent *ext, *cur, *aux;
+		struct mem_extent *ext, *cur;
 
 		zone_start = zone->zone_start_pfn;
 		zone_end = zone_end_pfn(zone);
@@ -665,7 +665,7 @@ static int create_mem_extents(struct list_head *list, gfp_t gfp_mask)
 
 		/* More merging may be possible */
 		cur = ext;
-		list_for_each_entry_safe_continue(cur, aux, list, hook) {
+		list_for_each_entry_mutable_continue(cur, list, hook) {
 			if (zone_end < cur->start)
 				break;
 			if (zone_end < cur->end)
diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
index fd763da06a87..c8718aacfa5a 100644
--- a/kernel/power/wakelock.c
+++ b/kernel/power/wakelock.c
@@ -102,13 +102,13 @@ static inline void wakelocks_lru_most_recent(struct wakelock *wl)
 
 static void __wakelocks_gc(struct work_struct *work)
 {
-	struct wakelock *wl, *aux;
+	struct wakelock *wl;
 	ktime_t now;
 
 	mutex_lock(&wakelocks_lock);
 
 	now = ktime_get();
-	list_for_each_entry_safe_reverse(wl, aux, &wakelocks_lru_list, lru) {
+	list_for_each_entry_mutable_reverse(wl, &wakelocks_lru_list, lru) {
 		u64 idle_time_ns;
 		bool active;
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2fe9a963c823..3f524c6bdf6e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3787,7 +3787,6 @@ static struct syscore printk_syscore = {
  */
 static void printk_kthreads_check_locked(void)
 {
-	struct hlist_node *tmp;
 	struct console *con;
 
 	lockdep_assert_console_list_lock_held();
@@ -3805,7 +3804,7 @@ static void printk_kthreads_check_locked(void)
 			 * are any nbcon consoles, they will set up their own
 			 * kthread.
 			 */
-			hlist_for_each_entry_safe(con, tmp, &console_list, node) {
+			hlist_for_each_entry_mutable(con, &console_list, node) {
 				if (con->flags & CON_NBCON)
 					continue;
 
@@ -3833,7 +3832,7 @@ static void printk_kthreads_check_locked(void)
 	if (printk_kthreads_running)
 		return;
 
-	hlist_for_each_entry_safe(con, tmp, &console_list, node) {
+	hlist_for_each_entry_mutable(con, &console_list, node) {
 		if (!(con->flags & CON_NBCON))
 			continue;
 
@@ -4209,9 +4208,8 @@ void register_console(struct console *newcon)
 	if (bootcon_registered &&
 	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV) &&
 	    !keep_bootcon) {
-		struct hlist_node *tmp;
 
-		hlist_for_each_entry_safe(con, tmp, &console_list, node) {
+		hlist_for_each_entry_mutable(con, &console_list, node) {
 			if (con->flags & CON_BOOT)
 				unregister_console_locked(con);
 		}
@@ -4426,12 +4424,11 @@ void __init console_init(void)
  */
 static int __init printk_late_init(void)
 {
-	struct hlist_node *tmp;
 	struct console *con;
 	int ret;
 
 	console_list_lock();
-	hlist_for_each_entry_safe(con, tmp, &console_list, node) {
+	hlist_for_each_entry_mutable(con, &console_list, node) {
 		if (!(con->flags & CON_BOOT))
 			continue;
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index d041645d9d17..8032b653af83 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -619,9 +619,9 @@ static int ptrace_detach(struct task_struct *child, unsigned int data)
  */
 void exit_ptrace(struct task_struct *tracer, struct list_head *dead)
 {
-	struct task_struct *p, *n;
+	struct task_struct *p;
 
-	list_for_each_entry_safe(p, n, &tracer->ptraced, ptrace_entry) {
+	list_for_each_entry_mutable(p, &tracer->ptraced, ptrace_entry) {
 		if (unlikely(p->ptrace & PT_EXITKILL))
 			send_sig_info(SIGKILL, SEND_SIG_PRIV, p);
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 882a158ada7b..9eb0007411a9 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -537,11 +537,10 @@ static void
 rcu_torture_pipe_update(struct rcu_torture *old_rp)
 {
 	struct rcu_torture *rp;
-	struct rcu_torture *rp1;
 
 	if (old_rp)
 		list_add(&old_rp->rtort_free, &rcu_torture_removed);
-	list_for_each_entry_safe(rp, rp1, &rcu_torture_removed, rtort_free) {
+	list_for_each_entry_mutable(rp, &rcu_torture_removed, rtort_free) {
 		if (rcu_torture_pipe_update_one(rp)) {
 			list_del(&rp->rtort_free);
 			rcu_torture_free(rp);
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index f4da5fad70f5..e79380d93c85 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1052,12 +1052,11 @@ static void rcu_tasks_postscan(struct list_head *hop)
 	for_each_possible_cpu(cpu) {
 		unsigned long j = jiffies + 1;
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
-		struct task_struct *t;
-		struct task_struct *t1;
+		struct task_struct *t, *t1;
 		struct list_head tmp;
 
 		raw_spin_lock_irq_rcu_node(rtpcp);
-		list_for_each_entry_safe(t, t1, &rtpcp->rtp_exit_list, rcu_tasks_exit_list) {
+		list_for_each_entry_mutable(t, t1, &rtpcp->rtp_exit_list, rcu_tasks_exit_list) {
 			if (list_empty(&t->rcu_tasks_holdout_list))
 				rcu_tasks_pertask(t, hop);
 
@@ -1120,9 +1119,9 @@ static void check_holdout_task(struct task_struct *t,
 static void check_all_holdout_tasks(struct list_head *hop,
 				    bool needreport, bool *firstreport)
 {
-	struct task_struct *t, *t1;
+	struct task_struct *t;
 
-	list_for_each_entry_safe(t, t1, hop, rcu_tasks_holdout_list) {
+	list_for_each_entry_mutable(t, hop, rcu_tasks_holdout_list) {
 		check_holdout_task(t, needreport, firstreport);
 		cond_resched();
 	}
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 03a43d3d2616..7c7792d62ac5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1664,7 +1664,7 @@ static void rcu_sr_normal_complete(struct llist_node *node)
 
 static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
 {
-	struct llist_node *done, *rcu, *next, *head;
+	struct llist_node *done, *rcu, *head;
 
 	/*
 	 * This work execution can potentially execute
@@ -1694,7 +1694,7 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
 	 * nodes is removed, in next round of cleanup
 	 * work execution.
 	 */
-	llist_for_each_safe(rcu, next, head) {
+	llist_for_each_mutable(rcu, head) {
 		if (!rcu_sr_is_wait_head(rcu)) {
 			rcu_sr_normal_complete(rcu);
 			continue;
@@ -1726,7 +1726,7 @@ static void rcu_sr_normal_gp_cleanup(void)
 	/*
 	 * Process (a) and (d) cases. See an illustration.
 	 */
-	llist_for_each_safe(rcu, next, wait_tail->next) {
+	llist_for_each_mutable(rcu, next, wait_tail->next) {
 		if (rcu_sr_is_wait_head(rcu))
 			break;
 
diff --git a/kernel/resource.c b/kernel/resource.c
index e60539a55541..19b89b09e291 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1951,9 +1951,9 @@ EXPORT_SYMBOL(resource_list_create_entry);
 
 void resource_list_free(struct list_head *head)
 {
-	struct resource_entry *entry, *tmp;
+	struct resource_entry *entry;
 
-	list_for_each_entry_safe(entry, tmp, head, node)
+	list_for_each_entry_mutable(entry, head, node)
 		resource_list_destroy_entry(entry);
 }
 EXPORT_SYMBOL(resource_list_free);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e97e98c33be5..873e26f2a032 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3892,7 +3892,7 @@ void sched_ttwu_pending(void *arg)
 {
 	struct llist_node *llist = arg;
 	struct rq *rq = this_rq();
-	struct task_struct *p, *t;
+	struct task_struct *p;
 	struct rq_flags rf;
 
 	if (!llist)
@@ -3901,7 +3901,7 @@ void sched_ttwu_pending(void *arg)
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 
-	llist_for_each_entry_safe(p, t, llist, wake_entry.llist) {
+	llist_for_each_entry_mutable(p, llist, wake_entry.llist) {
 		if (WARN_ON_ONCE(p->on_cpu))
 			smp_cond_load_acquire(&p->on_cpu, !VAL);
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0db6fa2daea3..2119f2629fd1 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4121,7 +4121,7 @@ static void process_ddsp_deferred_locals(struct rq *rq)
 	 * Now that @rq can be unlocked, execute the deferred enqueueing of
 	 * tasks directly dispatched to the local DSQs of other CPUs. See
 	 * direct_dispatch(). Keep popping from the head instead of using
-	 * list_for_each_entry_safe() as dispatch_local_dsq() may unlock @rq
+	 * list_for_each_entry_mutable() as dispatch_local_dsq() may unlock @rq
 	 * temporarily.
 	 */
 	while ((p = list_first_entry_or_null(&rq->scx.ddsp_deferred_locals,
@@ -4186,7 +4186,7 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 {
 	LIST_HEAD(tasks);
 	u32 nr_enqueued = 0;
-	struct task_struct *p, *n;
+	struct task_struct *p;
 
 	lockdep_assert_rq_held(rq);
 
@@ -4200,8 +4200,8 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 	 * @rq->scx.local_dsq. Move all candidate tasks off to a private list
 	 * first to avoid processing the same tasks repeatedly.
 	 */
-	list_for_each_entry_safe(p, n, &rq->scx.local_dsq.list,
-				 scx.dsq_list.node) {
+	list_for_each_entry_mutable(p, &rq->scx.local_dsq.list,
+				    scx.dsq_list.node) {
 		struct scx_sched *task_sch = scx_task_sched(p);
 		u32 reason;
 
@@ -4234,7 +4234,7 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 		list_add_tail(&p->scx.dsq_list.node, &tasks);
 	}
 
-	list_for_each_entry_safe(p, n, &tasks, scx.dsq_list.node) {
+	list_for_each_entry_mutable(p, &tasks, scx.dsq_list.node) {
 		list_del_init(&p->scx.dsq_list.node);
 
 		do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
@@ -4786,9 +4786,9 @@ static void free_dsq_rcufn(struct rcu_head *rcu)
 static void free_dsq_irq_workfn(struct irq_work *irq_work)
 {
 	struct llist_node *to_free = llist_del_all(&dsqs_to_free);
-	struct scx_dispatch_q *dsq, *tmp_dsq;
+	struct scx_dispatch_q *dsq;
 
-	llist_for_each_entry_safe(dsq, tmp_dsq, to_free, free_node)
+	llist_for_each_entry_mutable(dsq, to_free, free_node)
 		call_rcu(&dsq->rcu, free_dsq_rcufn);
 }
 
@@ -5684,7 +5684,7 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 	 */
 	for_each_possible_cpu(cpu) {
 		struct rq *rq = cpu_rq(cpu);
-		struct task_struct *p, *n;
+		struct task_struct *p;
 
 		raw_spin_rq_lock(rq);
 		raw_spin_lock(&scx_sched_lock);
@@ -5711,14 +5711,14 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 		}
 
 		/*
-		 * The use of list_for_each_entry_safe_reverse() is required
+		 * The use of list_for_each_entry_mutable_reverse() is required
 		 * because each task is going to be removed from and added back
 		 * to the runnable_list during iteration. Because they're added
 		 * to the tail of the list, safe reverse iteration can still
 		 * visit all nodes.
 		 */
-		list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list,
-						 scx.runnable_node) {
+		list_for_each_entry_mutable_reverse(p, &rq->scx.runnable_list,
+						    scx.runnable_node) {
 			if (!scx_is_descendant(scx_task_sched(p), sch))
 				continue;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d78467ec6ee1..0f21a168fd9a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -408,9 +408,9 @@ static inline void assert_list_leaf_cfs_rq(struct rq *rq)
 }
 
 /* Iterate through all leaf cfs_rq's on a runqueue */
-#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)			\
-	list_for_each_entry_safe(cfs_rq, pos, &rq->leaf_cfs_rq_list,	\
-				 leaf_cfs_rq_list)
+#define for_each_leaf_cfs_rq_safe(rq, cfs_rq)			\
+	list_for_each_entry_mutable(cfs_rq, &(rq)->leaf_cfs_rq_list,	\
+				    leaf_cfs_rq_list)
 
 /* Do the two (enqueued) entities belong to the same group ? */
 static inline struct cfs_rq *
@@ -494,8 +494,8 @@ static inline void assert_list_leaf_cfs_rq(struct rq *rq)
 {
 }
 
-#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)	\
-		for (cfs_rq = &rq->cfs, pos = NULL; cfs_rq; cfs_rq = pos)
+#define for_each_leaf_cfs_rq_safe(rq, cfs_rq)	\
+		for (cfs_rq = &(rq)->cfs; cfs_rq; cfs_rq = NULL)
 
 static inline struct sched_entity *parent_entity(struct sched_entity *se)
 {
@@ -6724,7 +6724,7 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 {
 	struct rq *rq = data;
 	struct cfs_rq *cfs_rq = tg_cfs_rq(tg, cpu_of(rq));
-	struct task_struct *p, *tmp;
+	struct task_struct *p;
 	LIST_HEAD(throttled_tasks);
 
 	/*
@@ -6765,7 +6765,7 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 	list_splice_init(&cfs_rq->throttled_limbo_list, &throttled_tasks);
 
 	/* Re-enqueue the tasks that have been throttled at this level. */
-	list_for_each_entry_safe(p, tmp, &throttled_tasks, throttle_node) {
+	list_for_each_entry_mutable(p, &throttled_tasks, throttle_node) {
 		/*
 		 * Back to being throttled! Break out and put the remaining
 		 * tasks back onto the limbo_list to prevent running them
@@ -6966,7 +6966,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 static void __cfsb_csd_unthrottle(void *arg)
 {
-	struct cfs_rq *cursor, *tmp;
+	struct cfs_rq *cursor;
 	struct rq *rq = arg;
 
 	guard(rq_lock)(rq);
@@ -6988,8 +6988,8 @@ static void __cfsb_csd_unthrottle(void *arg)
 	 */
 	guard(rcu)();
 
-	list_for_each_entry_safe(cursor, tmp, &rq->cfsb_csd_list,
-				 throttled_csd_list) {
+	list_for_each_entry_mutable(cursor, &rq->cfsb_csd_list,
+				    throttled_csd_list) {
 		list_del_init(&cursor->throttled_csd_list);
 
 		if (cfs_rq_throttled(cursor))
@@ -11118,14 +11118,14 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 static bool __update_blocked_fair(struct rq *rq, bool *done)
 {
-	struct cfs_rq *cfs_rq, *pos;
+	struct cfs_rq *cfs_rq;
 	bool decayed = false;
 
 	/*
 	 * Iterates the task_group tree in a bottom up fashion, see
 	 * list_add_leaf_cfs_rq() for details.
 	 */
-	for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
+	for_each_leaf_cfs_rq_safe(rq, cfs_rq) {
 		struct sched_entity *se;
 
 		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
@@ -15401,10 +15401,10 @@ DEFINE_SCHED_CLASS(fair) = {
 
 void print_cfs_stats(struct seq_file *m, int cpu)
 {
-	struct cfs_rq *cfs_rq, *pos;
+	struct cfs_rq *cfs_rq;
 
 	rcu_read_lock();
-	for_each_leaf_cfs_rq_safe(cpu_rq(cpu), cfs_rq, pos)
+	for_each_leaf_cfs_rq_safe(cpu_rq(cpu), cfs_rq)
 		print_cfs_rq(m, cpu, cfs_rq);
 	rcu_read_unlock();
 }
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 622e2e01974c..062887738bff 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1753,7 +1753,7 @@ static inline void asym_cpu_capacity_update_data(int cpu)
  */
 static void asym_cpu_capacity_scan(void)
 {
-	struct asym_cap_data *entry, *next;
+	struct asym_cap_data *entry;
 	int cpu;
 
 	list_for_each_entry(entry, &asym_cap_list, link)
@@ -1762,7 +1762,7 @@ static void asym_cpu_capacity_scan(void)
 	for_each_cpu_and(cpu, cpu_possible_mask, housekeeping_cpumask(HK_TYPE_DOMAIN))
 		asym_cpu_capacity_update_data(cpu);
 
-	list_for_each_entry_safe(entry, next, &asym_cap_list, link) {
+	list_for_each_entry_mutable(entry, &asym_cap_list, link) {
 		if (cpumask_empty(cpu_capacity_span(entry))) {
 			list_del_rcu(&entry->link);
 			call_rcu(&entry->rcu, free_asym_cap_entry);
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 20f27e2cf7ae..3411f9ac2073 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -92,7 +92,7 @@ EXPORT_SYMBOL(remove_wait_queue);
 static int __wake_up_common(struct wait_queue_head *wq_head, unsigned int mode,
 			int nr_exclusive, int wake_flags, void *key)
 {
-	wait_queue_entry_t *curr, *next;
+	wait_queue_entry_t *curr;
 
 	lockdep_assert_held(&wq_head->lock);
 
@@ -101,7 +101,7 @@ static int __wake_up_common(struct wait_queue_head *wq_head, unsigned int mode,
 	if (&curr->entry == &wq_head->head)
 		return nr_exclusive;
 
-	list_for_each_entry_safe_from(curr, next, &wq_head->head, entry) {
+	list_for_each_entry_mutable_from(curr, &wq_head->head, entry) {
 		unsigned flags = curr->flags;
 		int ret;
 
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 066909393c38..7212e47703f9 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1168,7 +1168,7 @@ static int seccomp_do_user_notification(int this_syscall,
 	u32 flags = 0;
 	long ret = 0;
 	struct seccomp_knotif n = {};
-	struct seccomp_kaddfd *addfd, *tmp;
+	struct seccomp_kaddfd *addfd;
 
 	mutex_lock(&match->notify_lock);
 	err = -ENOSYS;
@@ -1225,7 +1225,7 @@ static int seccomp_do_user_notification(int this_syscall,
 
 interrupted:
 	/* If there were any pending addfd calls, clear them out */
-	list_for_each_entry_safe(addfd, tmp, &n.addfd, list) {
+	list_for_each_entry_mutable(addfd, &n.addfd, list) {
 		/* The process went away before we got a chance to handle it */
 		addfd->ret = -ESRCH;
 		list_del_init(&addfd->list);
diff --git a/kernel/signal.c b/kernel/signal.c
index 9c2b32c4d755..072231bebf52 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -748,7 +748,7 @@ static void sigqueue_free_ignored(struct task_struct *tsk, struct sigqueue *q)
 /* Remove signals in mask from the pending set and queue. */
 static void flush_sigqueue_mask(struct task_struct *p, sigset_t *mask, struct sigpending *s)
 {
-	struct sigqueue *q, *n;
+	struct sigqueue *q;
 	sigset_t m;
 
 	lockdep_assert_held(&p->sighand->siglock);
@@ -758,7 +758,7 @@ static void flush_sigqueue_mask(struct task_struct *p, sigset_t *mask, struct si
 		return;
 
 	sigandnsets(&s->signal, &s->signal, mask);
-	list_for_each_entry_safe(q, n, &s->list, list) {
+	list_for_each_entry_mutable(q, &s->list, list) {
 		if (sigismember(mask, q->info.si_signo)) {
 			list_del_init(&q->list);
 			sigqueue_free_ignored(p, q);
@@ -1899,12 +1899,12 @@ EXPORT_SYMBOL(kill_pid);
 static void __flush_itimer_signals(struct sigpending *pending)
 {
 	sigset_t signal, retain;
-	struct sigqueue *q, *n;
+	struct sigqueue *q;
 
 	signal = pending->signal;
 	sigemptyset(&retain);
 
-	list_for_each_entry_safe(q, n, &pending->list, list) {
+	list_for_each_entry_mutable(q, &pending->list, list) {
 		int sig = q->info.si_signo;
 
 		if (likely(q->info.si_code != SI_TIMER)) {
@@ -2101,7 +2101,6 @@ static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueu
 static void posixtimer_sig_unignore(struct task_struct *tsk, int sig)
 {
 	struct hlist_head *head = &tsk->signal->ignored_posix_timers;
-	struct hlist_node *tmp;
 	struct k_itimer *tmr;
 
 	if (likely(hlist_empty(head)))
@@ -2114,7 +2113,7 @@ static void posixtimer_sig_unignore(struct task_struct *tsk, int sig)
 	 * rearmed or not. This cannot be decided here w/o dropping sighand
 	 * lock and creating a loop retry horror show.
 	 */
-	hlist_for_each_entry_safe(tmr, tmp , head, ignored_list) {
+	hlist_for_each_entry_mutable(tmr, head, ignored_list) {
 		struct task_struct *target;
 
 		/*
diff --git a/kernel/smp.c b/kernel/smp.c
index a0bb56bd8dda..305187e50b58 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -544,7 +544,7 @@ static void __flush_smp_call_function_queue(bool warn_cpu_offline)
 	 * First; run all SYNC callbacks, people are waiting for us.
 	 */
 	prev = NULL;
-	llist_for_each_entry_safe(csd, csd_next, entry, node.llist) {
+	llist_for_each_entry_mutable(csd, csd_next, entry, node.llist) {
 		/* Do we wait until *after* callback? */
 		if (CSD_TYPE(csd) == CSD_TYPE_SYNC) {
 			smp_call_func_t func = csd->func;
@@ -572,7 +572,7 @@ static void __flush_smp_call_function_queue(bool warn_cpu_offline)
 	 * Second; run all !SYNC callbacks.
 	 */
 	prev = NULL;
-	llist_for_each_entry_safe(csd, csd_next, entry, node.llist) {
+	llist_for_each_entry_mutable(csd, csd_next, entry, node.llist) {
 		int type = CSD_TYPE(csd);
 
 		if (type != CSD_TYPE_TTWU) {
diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 2cd0172d0516..08932d4776d1 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -111,7 +111,7 @@ static void send_cpu_listeners(struct sk_buff *skb,
 					struct listener_list *listeners)
 {
 	struct genlmsghdr *genlhdr = nlmsg_data(nlmsg_hdr(skb));
-	struct listener *s, *tmp;
+	struct listener *s;
 	struct sk_buff *skb_next, *skb_cur = skb;
 	void *reply = genlmsg_data(genlhdr);
 	int delcount = 0;
@@ -145,7 +145,7 @@ static void send_cpu_listeners(struct sk_buff *skb,
 
 	/* Delete invalidated entries */
 	down_write(&listeners->sem);
-	list_for_each_entry_safe(s, tmp, &listeners->list, list) {
+	list_for_each_entry_mutable(s, &listeners->list, list) {
 		if (!s->valid) {
 			list_del(&s->list);
 			kfree(s);
@@ -299,7 +299,7 @@ static void fill_tgid_exit(struct task_struct *tsk)
 static int add_del_listener(pid_t pid, const struct cpumask *mask, int isadd)
 {
 	struct listener_list *listeners;
-	struct listener *s, *tmp, *s2;
+	struct listener *s, *s2;
 	unsigned int cpu;
 	int ret = 0;
 
@@ -343,7 +343,7 @@ static int add_del_listener(pid_t pid, const struct cpumask *mask, int isadd)
 	for_each_cpu(cpu, mask) {
 		listeners = &per_cpu(listener_array, cpu);
 		down_write(&listeners->sem);
-		list_for_each_entry_safe(s, tmp, &listeners->list, list) {
+		list_for_each_entry_mutable(s, &listeners->list, list) {
 			if (s->pid == pid) {
 				list_del(&s->list);
 				kfree(s);
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 0014d163f989..a13eeab8d83f 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -678,7 +678,7 @@ void clockevents_resume(void)
  */
 void tick_offline_cpu(unsigned int cpu)
 {
-	struct clock_event_device *dev, *tmp;
+	struct clock_event_device *dev;
 
 	raw_spin_lock(&clockevents_lock);
 
@@ -689,13 +689,13 @@ void tick_offline_cpu(unsigned int cpu)
 	 * Unregister the clock event devices which were
 	 * released above.
 	 */
-	list_for_each_entry_safe(dev, tmp, &clockevents_released, list)
+	list_for_each_entry_mutable(dev, &clockevents_released, list)
 		list_del(&dev->list);
 
 	/*
 	 * Now check whether the CPU has left unused per cpu devices
 	 */
-	list_for_each_entry_safe(dev, tmp, &clockevent_devices, list) {
+	list_for_each_entry_mutable(dev, &clockevent_devices, list) {
 		if (cpumask_test_cpu(cpu, dev->cpumask) &&
 		    cpumask_weight(dev->cpumask) == 1 &&
 		    !tick_is_broadcast_device(dev)) {
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index e48c4d379a7c..ac857d7ce4bb 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -776,12 +776,12 @@ static void clocksource_dequeue_watchdog(struct clocksource *cs)
 
 static int __clocksource_watchdog_kthread(void)
 {
-	struct clocksource *cs, *tmp;
+	struct clocksource *cs;
 	unsigned long flags;
 	int select = 0;
 
 	spin_lock_irqsave(&watchdog_lock, flags);
-	list_for_each_entry_safe(cs, tmp, &watchdog_list, wd_list) {
+	list_for_each_entry_mutable(cs, &watchdog_list, wd_list) {
 		if (cs->flags & CLOCK_SOURCE_UNSTABLE) {
 			list_del_init(&cs->wd_list);
 			clocksource_change_rating(cs, 0);
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 5e633d8750d1..1f2c5533d598 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1296,7 +1296,7 @@ static inline bool posix_cpu_timers_enable_work(struct task_struct *tsk,
 
 static void handle_posix_cpu_timers(struct task_struct *tsk)
 {
-	struct k_itimer *timer, *next;
+	struct k_itimer *timer;
 	unsigned long flags, start;
 	LIST_HEAD(firing);
 
@@ -1369,7 +1369,7 @@ static void handle_posix_cpu_timers(struct task_struct *tsk)
 	 * each timer's lock before clearing its firing flag, so no
 	 * timer call will interfere.
 	 */
-	list_for_each_entry_safe(timer, next, &firing, it.cpu.elist) {
+	list_for_each_entry_mutable(timer, &firing, it.cpu.elist) {
 		bool cpu_firing;
 
 		/*
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 436ba794cc0b..d89307c4adb0 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1085,7 +1085,6 @@ SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 void exit_itimers(struct task_struct *tsk)
 {
 	struct hlist_head timers;
-	struct hlist_node *next;
 	struct k_itimer *timer;
 
 	/* Clear restore mode for exec() */
@@ -1099,7 +1098,7 @@ void exit_itimers(struct task_struct *tsk)
 		hlist_move_list(&tsk->signal->posix_timers, &timers);
 
 	/* The timers are not longer accessible via tsk::signal */
-	hlist_for_each_entry_safe(timer, next, &timers, list) {
+	hlist_for_each_entry_mutable(timer, &timers, list) {
 		scoped_guard (spinlock_irq, &timer->it_lock)
 			posix_timer_delete(timer);
 		posix_timer_unhash_and_free(timer);
diff --git a/kernel/torture.c b/kernel/torture.c
index 77cb3589b19f..047dcde729dd 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -510,10 +510,9 @@ EXPORT_SYMBOL_GPL(torture_shuffle_task_register);
 static void torture_shuffle_task_unregister_all(void)
 {
 	struct shuffle_task *stp;
-	struct shuffle_task *p;
 
 	mutex_lock(&shuffle_task_mutex);
-	list_for_each_entry_safe(stp, p, &shuffle_task_list, st_l) {
+	list_for_each_entry_mutable(stp, &shuffle_task_list, st_l) {
 		list_del(&stp->st_l);
 		kfree(stp);
 	}
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 82f8feea6931..7f6d8b287adb 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2276,7 +2276,7 @@ subsys_initcall(send_signal_irq_work_init);
 static int bpf_event_notify(struct notifier_block *nb, unsigned long op,
 			    void *module)
 {
-	struct bpf_trace_module *btm, *tmp;
+	struct bpf_trace_module *btm;
 	struct module *mod = module;
 	int ret = 0;
 
@@ -2297,7 +2297,7 @@ static int bpf_event_notify(struct notifier_block *nb, unsigned long op,
 		}
 		break;
 	case MODULE_STATE_GOING:
-		list_for_each_entry_safe(btm, tmp, &bpf_trace_modules, list) {
+		list_for_each_entry_mutable(btm, &bpf_trace_modules, list) {
 			if (btm->module == module) {
 				list_del(&btm->list);
 				kfree(btm);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f93e34dd2328..422665c687ff 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1252,7 +1252,6 @@ void ftrace_hash_remove(struct ftrace_hash *hash)
 {
 	struct ftrace_func_entry *entry;
 	struct hlist_head *hhd;
-	struct hlist_node *tn;
 	int size;
 	int i;
 
@@ -1261,7 +1260,7 @@ void ftrace_hash_remove(struct ftrace_hash *hash)
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
 		hhd = &hash->buckets[i];
-		hlist_for_each_entry_safe(entry, tn, hhd, hlist)
+		hlist_for_each_entry_mutable(entry, hhd, hlist)
 			remove_hash_entry(hash, entry);
 	}
 	FTRACE_WARN_ON(hash->count);
@@ -1270,7 +1269,6 @@ void ftrace_hash_remove(struct ftrace_hash *hash)
 static void ftrace_hash_clear(struct ftrace_hash *hash)
 {
 	struct hlist_head *hhd;
-	struct hlist_node *tn;
 	struct ftrace_func_entry *entry;
 	int size = 1 << hash->size_bits;
 	int i;
@@ -1280,7 +1278,7 @@ static void ftrace_hash_clear(struct ftrace_hash *hash)
 
 	for (i = 0; i < size; i++) {
 		hhd = &hash->buckets[i];
-		hlist_for_each_entry_safe(entry, tn, hhd, hlist)
+		hlist_for_each_entry_mutable(entry, hhd, hlist)
 			free_hash_entry(hash, entry);
 	}
 	FTRACE_WARN_ON(hash->count);
@@ -1296,14 +1294,14 @@ static void free_ftrace_mod(struct ftrace_mod_load *ftrace_mod)
 
 static void clear_ftrace_mod_list(struct list_head *head)
 {
-	struct ftrace_mod_load *p, *n;
+	struct ftrace_mod_load *p;
 
 	/* stack tracer isn't supported yet */
 	if (!head)
 		return;
 
 	mutex_lock(&ftrace_lock);
-	list_for_each_entry_safe(p, n, head, list)
+	list_for_each_entry_mutable(p, head, list)
 		free_ftrace_mod(p);
 	mutex_unlock(&ftrace_lock);
 }
@@ -1451,7 +1449,6 @@ static struct ftrace_hash *__move_hash(struct ftrace_hash *src, int size)
 	struct ftrace_func_entry *entry;
 	struct ftrace_hash *new_hash;
 	struct hlist_head *hhd;
-	struct hlist_node *tn;
 	int bits = 0;
 	int i;
 
@@ -1474,7 +1471,7 @@ static struct ftrace_hash *__move_hash(struct ftrace_hash *src, int size)
 	size = 1 << src->size_bits;
 	for (i = 0; i < size; i++) {
 		hhd = &src->buckets[i];
-		hlist_for_each_entry_safe(entry, tn, hhd, hlist) {
+		hlist_for_each_entry_mutable(entry, hhd, hlist) {
 			remove_hash_entry(src, entry);
 			add_ftrace_hash_entry(new_hash, entry);
 		}
@@ -3327,7 +3324,6 @@ static int append_hash(struct ftrace_hash **hash, struct ftrace_hash *new_hash,
 static void remove_hash(struct ftrace_hash *hash, struct ftrace_hash *notrace_hash)
 {
 	struct ftrace_func_entry *entry;
-	struct hlist_node *tmp;
 	int size;
 	int i;
 
@@ -3337,7 +3333,7 @@ static void remove_hash(struct ftrace_hash *hash, struct ftrace_hash *notrace_ha
 
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
-		hlist_for_each_entry_safe(entry, tmp, &hash->buckets[i], hlist) {
+		hlist_for_each_entry_mutable(entry, &hash->buckets[i], hlist) {
 			if (!__ftrace_lookup_ip(notrace_hash, entry->ip))
 				continue;
 			remove_hash_entry(hash, entry);
@@ -5084,7 +5080,7 @@ static int ftrace_hash_move_and_update_ops(struct ftrace_ops *ops,
 static int cache_mod(struct trace_array *tr,
 		     const char *func, char *module, int enable)
 {
-	struct ftrace_mod_load *ftrace_mod, *n;
+	struct ftrace_mod_load *ftrace_mod;
 	struct list_head *head = enable ? &tr->mod_trace : &tr->mod_notrace;
 
 	guard(mutex)(&ftrace_lock);
@@ -5096,7 +5092,7 @@ static int cache_mod(struct trace_array *tr,
 		func++;
 
 		/* Look to remove this hash */
-		list_for_each_entry_safe(ftrace_mod, n, head, list) {
+		list_for_each_entry_mutable(ftrace_mod, head, list) {
 			if (strcmp(ftrace_mod->module, module) != 0)
 				continue;
 
@@ -5124,7 +5120,7 @@ static int cache_mod(struct trace_array *tr,
 static void process_mod_list(struct list_head *head, struct ftrace_ops *ops,
 			     char *mod, bool enable)
 {
-	struct ftrace_mod_load *ftrace_mod, *n;
+	struct ftrace_mod_load *ftrace_mod;
 	struct ftrace_hash **orig_hash, *new_hash;
 	LIST_HEAD(process_mods);
 	char *func;
@@ -5143,7 +5139,7 @@ static void process_mod_list(struct list_head *head, struct ftrace_ops *ops,
 
 	mutex_lock(&ftrace_lock);
 
-	list_for_each_entry_safe(ftrace_mod, n, head, list) {
+	list_for_each_entry_mutable(ftrace_mod, head, list) {
 
 		if (strcmp(ftrace_mod->module, mod) != 0)
 			continue;
@@ -5165,7 +5161,7 @@ static void process_mod_list(struct list_head *head, struct ftrace_ops *ops,
 
 	mutex_unlock(&ftrace_lock);
 
-	list_for_each_entry_safe(ftrace_mod, n, &process_mods, list) {
+	list_for_each_entry_mutable(ftrace_mod, &process_mods, list) {
 
 		func = ftrace_mod->func;
 
@@ -5616,7 +5612,6 @@ unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
 	struct ftrace_hash **orig_hash;
 	struct ftrace_hash *old_hash;
 	struct ftrace_hash *hash = NULL;
-	struct hlist_node *tmp;
 	struct hlist_head hhd;
 	char str[KSYM_SYMBOL_LEN];
 	int count = 0;
@@ -5677,7 +5672,7 @@ unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
 
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
-		hlist_for_each_entry_safe(entry, tmp, &hash->buckets[i], hlist) {
+		hlist_for_each_entry_mutable(entry, &hash->buckets[i], hlist) {
 
 			if (func_g.search) {
 				kallsyms_lookup(entry->ip, NULL, NULL,
@@ -5715,7 +5710,7 @@ unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
 				       &old_hash_ops);
 	synchronize_rcu();
 
-	hlist_for_each_entry_safe(entry, tmp, &hhd, hlist) {
+	hlist_for_each_entry_mutable(entry, &hhd, hlist) {
 		hlist_del(&entry->hlist);
 		if (probe_ops->free)
 			probe_ops->free(probe_ops, tr, entry->ip, probe->data);
@@ -5738,9 +5733,9 @@ unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
 
 void clear_ftrace_function_probes(struct trace_array *tr)
 {
-	struct ftrace_func_probe *probe, *n;
+	struct ftrace_func_probe *probe;
 
-	list_for_each_entry_safe(probe, n, &tr->func_probes, list)
+	list_for_each_entry_mutable(probe, &tr->func_probes, list)
 		unregister_ftrace_function_probe_func(NULL, tr, probe->probe_ops);
 }
 
@@ -5771,11 +5766,11 @@ __init int register_ftrace_command(struct ftrace_func_command *cmd)
  */
 __init int unregister_ftrace_command(struct ftrace_func_command *cmd)
 {
-	struct ftrace_func_command *p, *n;
+	struct ftrace_func_command *p;
 
 	guard(mutex)(&ftrace_cmd_mutex);
 
-	list_for_each_entry_safe(p, n, &ftrace_commands, list) {
+	list_for_each_entry_mutable(p, &ftrace_commands, list) {
 		if (strcmp(cmd->name, p->name) == 0) {
 			list_del_init(&p->list);
 			return 0;
@@ -7876,10 +7871,9 @@ static void ftrace_free_mod_map(struct rcu_head *rcu)
 {
 	struct ftrace_mod_map *mod_map = container_of(rcu, struct ftrace_mod_map, rcu);
 	struct ftrace_mod_func *mod_func;
-	struct ftrace_mod_func *n;
 
 	/* All the contents of mod_map are now not visible to readers */
-	list_for_each_entry_safe(mod_func, n, &mod_map->funcs, list) {
+	list_for_each_entry_mutable(mod_func, &mod_map->funcs, list) {
 		kfree(mod_func->name);
 		list_del(&mod_func->list);
 		kfree(mod_func);
@@ -7891,7 +7885,6 @@ static void ftrace_free_mod_map(struct rcu_head *rcu)
 void ftrace_release_mod(struct module *mod)
 {
 	struct ftrace_mod_map *mod_map;
-	struct ftrace_mod_map *n;
 	struct dyn_ftrace *rec;
 	struct ftrace_page **last_pg;
 	struct ftrace_page *tmp_page = NULL;
@@ -7903,7 +7896,7 @@ void ftrace_release_mod(struct module *mod)
 	 * To avoid the UAF problem after the module is unloaded, the
 	 * 'mod_map' resource needs to be released unconditionally.
 	 */
-	list_for_each_entry_safe(mod_map, n, &ftrace_mod_maps, list) {
+	list_for_each_entry_mutable(mod_map, &ftrace_mod_maps, list) {
 		if (mod_map->mod == mod) {
 			list_del_rcu(&mod_map->list);
 			call_rcu(&mod_map->rcu, ftrace_free_mod_map);
@@ -8290,7 +8283,7 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 	struct dyn_ftrace *rec;
 	struct dyn_ftrace key;
 	struct ftrace_mod_map *mod_map = NULL;
-	struct ftrace_init_func *func, *func_next;
+	struct ftrace_init_func *func;
 	LIST_HEAD(clear_hash);
 
 	key.ip = start;
@@ -8341,7 +8334,7 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 	}
 	mutex_unlock(&ftrace_lock);
 
-	list_for_each_entry_safe(func, func_next, &clear_hash, list) {
+	list_for_each_entry_mutable(func, &clear_hash, list) {
 		clear_func_from_hashes(func);
 		kfree(func);
 	}
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 56a328e94395..24b2deb1f7a6 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2362,7 +2362,7 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 {
 	struct trace_buffer *buffer = cpu_buffer->buffer;
 	struct ring_buffer_cpu_meta *meta = NULL;
-	struct buffer_page *bpage, *tmp;
+	struct buffer_page *bpage;
 	bool user_thread = current->mm != NULL;
 	struct ring_buffer_desc *desc = NULL;
 	long i;
@@ -2450,7 +2450,7 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 	return 0;
 
 free_pages:
-	list_for_each_entry_safe(bpage, tmp, pages, list) {
+	list_for_each_entry_mutable(bpage, pages, list) {
 		list_del_init(&bpage->list);
 		free_buffer_page(bpage);
 	}
@@ -2609,7 +2609,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct list_head *head = cpu_buffer->pages;
-	struct buffer_page *bpage, *tmp;
+	struct buffer_page *bpage;
 
 	irq_work_sync(&cpu_buffer->irq_work.work);
 
@@ -2621,7 +2621,7 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 	if (head) {
 		rb_head_page_deactivate(cpu_buffer);
 
-		list_for_each_entry_safe(bpage, tmp, head, list) {
+		list_for_each_entry_mutable(bpage, head, list) {
 			list_del_init(&bpage->list);
 			free_buffer_page(bpage);
 		}
@@ -3163,9 +3163,9 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 
 	/* free pages if they weren't inserted */
 	if (!success) {
-		struct buffer_page *bpage, *tmp;
-		list_for_each_entry_safe(bpage, tmp, &cpu_buffer->new_pages,
-					 list) {
+		struct buffer_page *bpage;
+
+		list_for_each_entry_mutable(bpage, &cpu_buffer->new_pages, list) {
 			list_del_init(&bpage->list);
 			free_buffer_page(bpage);
 		}
@@ -3395,7 +3395,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 
  out_err:
 	for_each_buffer_cpu(buffer, cpu) {
-		struct buffer_page *bpage, *tmp;
+		struct buffer_page *bpage;
 
 		cpu_buffer = buffer->buffers[cpu];
 		cpu_buffer->nr_pages_to_update = 0;
@@ -3403,8 +3403,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		if (list_empty(&cpu_buffer->new_pages))
 			continue;
 
-		list_for_each_entry_safe(bpage, tmp, &cpu_buffer->new_pages,
-					list) {
+		list_for_each_entry_mutable(bpage, &cpu_buffer->new_pages, list) {
 			list_del_init(&bpage->list);
 			free_buffer_page(bpage);
 
@@ -7316,7 +7315,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_get);
 int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	struct buffer_page *bpage, *tmp;
+	struct buffer_page *bpage;
 	int old_order, old_size;
 	int nr_pages;
 	int psize;
@@ -7436,7 +7435,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
 		/* Free old sub buffers */
-		list_for_each_entry_safe(bpage, tmp, &old_pages, list) {
+		list_for_each_entry_mutable(bpage, &old_pages, list) {
 			list_del_init(&bpage->list);
 			free_buffer_page(bpage);
 		}
@@ -7461,7 +7460,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		if (!cpu_buffer->nr_pages_to_update)
 			continue;
 
-		list_for_each_entry_safe(bpage, tmp, &cpu_buffer->new_pages, list) {
+		list_for_each_entry_mutable(bpage, &cpu_buffer->new_pages, list) {
 			list_del_init(&bpage->list);
 			free_buffer_page(bpage);
 		}
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1146b83b711a..f1049850e986 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1380,7 +1380,7 @@ static int do_run_tracer_selftest(struct tracer *type)
 
 static __init int init_trace_selftests(void)
 {
-	struct trace_selftests *p, *n;
+	struct trace_selftests *p;
 	struct tracer *t, **last;
 	int ret;
 
@@ -1394,7 +1394,7 @@ static __init int init_trace_selftests(void)
 	pr_info("Running postponed tracer tests:\n");
 
 	tracing_selftest_running = true;
-	list_for_each_entry_safe(p, n, &postponed_selftests, list) {
+	list_for_each_entry_mutable(p, &postponed_selftests, list) {
 		/* This loop can take minutes when sanitizers are enabled, so
 		 * lets make sure we allow RCU processing.
 		 */
@@ -1434,11 +1434,11 @@ static void __init apply_trace_boot_options(void);
 
 static void free_tracers(struct trace_array *tr)
 {
-	struct tracers *t, *n;
+	struct tracers *t;
 
 	lockdep_assert_held(&trace_types_lock);
 
-	list_for_each_entry_safe(t, n, &tr->tracers, list) {
+	list_for_each_entry_mutable(t, &tr->tracers, list) {
 		list_del(&t->list);
 		kfree(t->flags);
 		kfree(t);
@@ -6906,11 +6906,11 @@ void tracing_log_err(struct trace_array *tr,
 
 static void clear_tracing_err_log(struct trace_array *tr)
 {
-	struct tracing_log_err *err, *next;
+	struct tracing_log_err *err;
 
 	guard(mutex)(&tracing_err_log_lock);
 
-	list_for_each_entry_safe(err, next, &tr->err_log, list) {
+	list_for_each_entry_mutable(err, &tr->err_log, list) {
 		list_del(&err->list);
 		free_tracing_log_err(err);
 	}
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index c4dfbc293bae..9e076106bee7 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -100,7 +100,7 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 		return -EINVAL;
 
 	mutex_lock(&event_mutex);
-	for_each_dyn_event_safe(pos, n) {
+	for_each_dyn_event_safe(pos) {
 		if (type && type != pos->ops)
 			continue;
 		if (!pos->ops->match(system, event,
@@ -207,7 +207,7 @@ static const struct seq_operations dyn_event_seq_op = {
  */
 int dyn_events_release_all(struct dyn_event_operations *type)
 {
-	struct dyn_event *ev, *tmp;
+	struct dyn_event *ev;
 	int ret = 0;
 
 	mutex_lock(&event_mutex);
@@ -219,7 +219,7 @@ int dyn_events_release_all(struct dyn_event_operations *type)
 			goto out;
 		}
 	}
-	for_each_dyn_event_safe(ev, tmp) {
+	for_each_dyn_event_safe(ev) {
 		if (type && ev->ops != type)
 			continue;
 		ret = ev->ops->free(ev);
diff --git a/kernel/trace/trace_dynevent.h b/kernel/trace/trace_dynevent.h
index beee3f8d7544..a4dc0812284f 100644
--- a/kernel/trace/trace_dynevent.h
+++ b/kernel/trace/trace_dynevent.h
@@ -115,10 +115,9 @@ int dyn_event_create(const char *raw_command, struct dyn_event_operations *type)
 /*
  * for_each_dyn_event	-	iterate over the dyn_event list safely
  * @pos:	the struct dyn_event * to use as a loop cursor
- * @n:		the struct dyn_event * to use as temporary storage
  */
-#define for_each_dyn_event_safe(pos, n)	\
-	list_for_each_entry_safe(pos, n, &dyn_event_list, list)
+#define for_each_dyn_event_safe(pos)	\
+	list_for_each_entry_mutable(pos, &dyn_event_list, list)
 
 extern void dynevent_cmd_init(struct dynevent_cmd *cmd, char *buf, int maxlen,
 			      enum dynevent_type type,
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c46e623e7e0d..a34fb3e688d5 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -75,8 +75,7 @@ static int system_refcount_dec(struct event_subsystem *system)
 
 #define do_for_each_event_file_safe(tr, file)			\
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {	\
-		struct trace_event_file *___n;				\
-		list_for_each_entry_safe(file, ___n, &tr->events, list)
+		list_for_each_entry_mutable(file, &tr->events, list)
 
 #define while_for_each_event_file()		\
 	}
@@ -219,11 +218,11 @@ static int trace_define_common_fields(void)
 
 static void trace_destroy_fields(struct trace_event_call *call)
 {
-	struct ftrace_event_field *field, *next;
+	struct ftrace_event_field *field;
 	struct list_head *head;
 
 	head = trace_get_fields(call);
-	list_for_each_entry_safe(field, next, head, link) {
+	list_for_each_entry_mutable(field, head, link) {
 		list_del(&field->link);
 		kmem_cache_free(field_cachep, field);
 	}
@@ -928,9 +927,9 @@ static void free_event_mod(struct event_mod_load *event_mod)
 
 static void clear_mod_events(struct trace_array *tr)
 {
-	struct event_mod_load *event_mod, *n;
+	struct event_mod_load *event_mod;
 
-	list_for_each_entry_safe(event_mod, n, &tr->mod_events, list) {
+	list_for_each_entry_mutable(event_mod, &tr->mod_events, list) {
 		free_event_mod(event_mod);
 	}
 }
@@ -938,10 +937,10 @@ static void clear_mod_events(struct trace_array *tr)
 static int remove_cache_mod(struct trace_array *tr, const char *mod,
 			    const char *match, const char *system, const char *event)
 {
-	struct event_mod_load *event_mod, *n;
+	struct event_mod_load *event_mod;
 	int ret = -EINVAL;
 
-	list_for_each_entry_safe(event_mod, n, &tr->mod_events, list) {
+	list_for_each_entry_mutable(event_mod, &tr->mod_events, list) {
 		if (strcmp(event_mod->module, mod) != 0)
 			continue;
 
@@ -3557,7 +3556,7 @@ static void update_event_fields(struct trace_event_call *call,
 /* Update all events for replacing eval and sanitizing */
 void trace_event_update_all(struct trace_eval_map **map, int len)
 {
-	struct trace_event_call *call, *p;
+	struct trace_event_call *call;
 	const char *last_system = NULL;
 	bool first = false;
 	bool updated;
@@ -3565,7 +3564,7 @@ void trace_event_update_all(struct trace_eval_map **map, int len)
 	int i;
 
 	down_write(&trace_event_sem);
-	list_for_each_entry_safe(call, p, &ftrace_events, list) {
+	list_for_each_entry_mutable(call, &ftrace_events, list) {
 		/* events are usually grouped together with systems */
 		if (!last_system || call->class->system != last_system) {
 			first = true;
@@ -3892,9 +3891,9 @@ EXPORT_SYMBOL_GPL(trace_remove_event_call);
 #ifdef CONFIG_MODULES
 static void update_mod_cache(struct trace_array *tr, struct module *mod)
 {
-	struct event_mod_load *event_mod, *n;
+	struct event_mod_load *event_mod;
 
-	list_for_each_entry_safe(event_mod, n, &tr->mod_events, list) {
+	list_for_each_entry_mutable(event_mod, &tr->mod_events, list) {
 		if (strcmp(event_mod->module, mod->name) != 0)
 			continue;
 
@@ -3940,18 +3939,18 @@ static void trace_module_add_events(struct module *mod)
 
 static void trace_module_remove_events(struct module *mod)
 {
-	struct trace_event_call *call, *p;
-	struct module_string *modstr, *m;
+	struct trace_event_call *call;
+	struct module_string *modstr;
 
 	down_write(&trace_event_sem);
-	list_for_each_entry_safe(call, p, &ftrace_events, list) {
+	list_for_each_entry_mutable(call, &ftrace_events, list) {
 		if ((call->flags & TRACE_EVENT_FL_DYNAMIC) || !call->module)
 			continue;
 		if (call->module == mod)
 			__trace_remove_event_call(call);
 	}
 	/* Check for any strings allocated for this module */
-	list_for_each_entry_safe(modstr, m, &module_strings, next) {
+	list_for_each_entry_mutable(modstr, &module_strings, next) {
 		if (modstr->module != mod)
 			continue;
 		list_del(&modstr->next);
@@ -4483,9 +4482,9 @@ void __trace_early_add_events(struct trace_array *tr)
 static void
 __trace_remove_event_dirs(struct trace_array *tr)
 {
-	struct trace_event_file *file, *next;
+	struct trace_event_file *file;
 
-	list_for_each_entry_safe(file, next, &tr->events, list)
+	list_for_each_entry_mutable(file, &tr->events, list)
 		remove_event_file_dir(file);
 }
 
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 609325f57942..d82128084a87 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1352,9 +1352,9 @@ struct filter_head {
 
 static void free_filter_list(struct filter_head *filter_list)
 {
-	struct filter_list *filter_item, *tmp;
+	struct filter_list *filter_item;
 
-	list_for_each_entry_safe(filter_item, tmp, &filter_list->list, list) {
+	list_for_each_entry_mutable(filter_item, &filter_list->list, list) {
 		__free_filter(filter_item->filter);
 		list_del(&filter_item->list);
 		kfree(filter_item);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 82ce492ab268..ff6016acab20 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6765,7 +6765,7 @@ static bool hist_file_check_refs(struct trace_event_file *file)
 
 static void hist_unreg_all(struct trace_event_file *file)
 {
-	struct event_trigger_data *test, *n;
+	struct event_trigger_data *test;
 	struct hist_trigger_data *hist_data;
 	struct synth_event *se;
 	const char *se_name;
@@ -6775,7 +6775,7 @@ static void hist_unreg_all(struct trace_event_file *file)
 	if (hist_file_check_refs(file))
 		return;
 
-	list_for_each_entry_safe(test, n, &file->triggers, list) {
+	list_for_each_entry_mutable(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_EVENT_HIST) {
 			hist_data = test->private_data;
 			list_del_rcu(&test->list);
@@ -7002,9 +7002,9 @@ hist_enable_trigger(struct event_trigger_data *data,
 
 static void hist_enable_unreg_all(struct trace_event_file *file)
 {
-	struct event_trigger_data *test, *n;
+	struct event_trigger_data *test;
 
-	list_for_each_entry_safe(test, n, &file->triggers, list) {
+	list_for_each_entry_mutable(test, &file->triggers, list) {
 		if (test->cmd_ops->trigger_type == ETT_HIST_ENABLE) {
 			list_del_rcu(&test->list);
 			update_cond_flag(file);
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 655db2e82513..8654cd83f64d 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -40,7 +40,7 @@ static void trigger_create_kthread_locked(void)
 
 static void trigger_data_free_queued_locked(void)
 {
-	struct event_trigger_data *data, *tmp;
+	struct event_trigger_data *data;
 	struct llist_node *llnodes;
 
 	lockdep_assert_held(&trigger_data_kthread_mutex);
@@ -51,14 +51,14 @@ static void trigger_data_free_queued_locked(void)
 
 	tracepoint_synchronize_unregister();
 
-	llist_for_each_entry_safe(data, tmp, llnodes, llist)
+	llist_for_each_entry_mutable(data, llnodes, llist)
 		kfree(data);
 }
 
 /* Bulk garbage collection of event_trigger_data elements */
 static int trigger_kthread_fn(void *ignore)
 {
-	struct event_trigger_data *data, *tmp;
+	struct event_trigger_data *data;
 	struct llist_node *llnodes;
 
 	/* Once this task starts, it lives forever */
@@ -74,7 +74,7 @@ static int trigger_kthread_fn(void *ignore)
 		/* make sure current triggers exit before free */
 		tracepoint_synchronize_unregister();
 
-		llist_for_each_entry_safe(data, tmp, llnodes, llist)
+		llist_for_each_entry_mutable(data, llnodes, llist)
 			kfree(data);
 	}
 
@@ -477,11 +477,11 @@ __init int register_event_command(struct event_command *cmd)
  */
 __init int unregister_event_command(struct event_command *cmd)
 {
-	struct event_command *p, *n;
+	struct event_command *p;
 
 	guard(mutex)(&trigger_cmd_mutex);
 
-	list_for_each_entry_safe(p, n, &trigger_commands, list) {
+	list_for_each_entry_mutable(p, &trigger_commands, list) {
 		if (strcmp(cmd->name, p->name) == 0) {
 			list_del_init(&p->list);
 			return 0;
@@ -632,8 +632,9 @@ clear_event_triggers(struct trace_array *tr)
 	struct trace_event_file *file;
 
 	list_for_each_entry(file, &tr->events, list) {
-		struct event_trigger_data *data, *n;
-		list_for_each_entry_safe(data, n, &file->triggers, list) {
+		struct event_trigger_data *data;
+
+		list_for_each_entry_mutable(data, &file->triggers, list) {
 			trace_event_trigger_enable_disable(file, 0);
 			list_del_rcu(&data->list);
 			if (data->cmd_ops->free)
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index c4ba484f7b38..090d645eebf0 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -761,9 +761,9 @@ static struct user_event_mm *current_user_event_mm(void)
 
 static void user_event_mm_destroy(struct user_event_mm *mm)
 {
-	struct user_event_enabler *enabler, *next;
+	struct user_event_enabler *enabler;
 
-	list_for_each_entry_safe(enabler, next, &mm->enablers, mm_enablers_link)
+	list_for_each_entry_mutable(enabler, &mm->enablers, mm_enablers_link)
 		user_event_enabler_destroy(enabler, false);
 
 	mmdrop(mm->mm);
@@ -1085,10 +1085,10 @@ static int user_field_size(const char *type)
 
 static void user_event_destroy_validators(struct user_event *user)
 {
-	struct user_event_validator *validator, *next;
+	struct user_event_validator *validator;
 	struct list_head *head = &user->validators;
 
-	list_for_each_entry_safe(validator, next, head, user_event_link) {
+	list_for_each_entry_mutable(validator, head, user_event_link) {
 		list_del(&validator->user_event_link);
 		kfree(validator);
 	}
@@ -1096,10 +1096,10 @@ static void user_event_destroy_validators(struct user_event *user)
 
 static void user_event_destroy_fields(struct user_event *user)
 {
-	struct ftrace_event_field *field, *next;
+	struct ftrace_event_field *field;
 	struct list_head *head = &user->fields;
 
-	list_for_each_entry_safe(field, next, head, link) {
+	list_for_each_entry_mutable(field, head, link) {
 		list_del(&field->link);
 		kfree(field);
 	}
@@ -2611,7 +2611,7 @@ static long user_events_ioctl_unreg(unsigned long uarg)
 {
 	struct user_unreg __user *ureg = (struct user_unreg __user *)uarg;
 	struct user_event_mm *mm = current->user_event_mm;
-	struct user_event_enabler *enabler, *next;
+	struct user_event_enabler *enabler;
 	struct user_unreg reg;
 	unsigned long flags;
 	long ret;
@@ -2636,7 +2636,7 @@ static long user_events_ioctl_unreg(unsigned long uarg)
 	 */
 	mutex_lock(&event_mutex);
 
-	list_for_each_entry_safe(enabler, next, &mm->enablers, mm_enablers_link) {
+	list_for_each_entry_mutable(enabler, &mm->enablers, mm_enablers_link) {
 		if (enabler->addr == reg.disable_addr &&
 		    ENABLE_BIT(enabler) == reg.disable_bit) {
 			set_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler));
diff --git a/kernel/trace/trace_stat.c b/kernel/trace/trace_stat.c
index 856ece13b7dc..3240b1ff7418 100644
--- a/kernel/trace/trace_stat.c
+++ b/kernel/trace/trace_stat.c
@@ -344,10 +344,10 @@ int register_stat_tracer(struct tracer_stat *trace)
 
 void unregister_stat_tracer(struct tracer_stat *trace)
 {
-	struct stat_session *node, *tmp;
+	struct stat_session *node;
 
 	mutex_lock(&all_stat_sessions_mutex);
-	list_for_each_entry_safe(node, tmp, &all_stat_sessions, session_list) {
+	list_for_each_entry_mutable(node, &all_stat_sessions, session_list) {
 		if (node->ts == trace) {
 			list_del(&node->session_list);
 			destroy_session(node);
diff --git a/kernel/user-return-notifier.c b/kernel/user-return-notifier.c
index 870ecd7c63ed..9f1dcd72b756 100644
--- a/kernel/user-return-notifier.c
+++ b/kernel/user-return-notifier.c
@@ -35,11 +35,10 @@ EXPORT_SYMBOL_GPL(user_return_notifier_unregister);
 void fire_user_return_notifiers(void)
 {
 	struct user_return_notifier *urn;
-	struct hlist_node *tmp2;
 	struct hlist_head *head;
 
 	head = &get_cpu_var(return_notifier_list);
-	hlist_for_each_entry_safe(urn, tmp2, head, link)
+	hlist_for_each_entry_mutable(urn, head, link)
 		urn->on_user_return(urn);
 	put_cpu_var(return_notifier_list);
 }
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 78f25afb4a9d..8fbdf1664c38 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1167,7 +1167,7 @@ static void move_linked_works(struct work_struct *work, struct list_head *head,
 	 * Linked worklist will always end before the end of the list,
 	 * use NULL for list head.
 	 */
-	list_for_each_entry_safe_from(work, n, NULL, entry) {
+	list_for_each_entry_mutable_from(work, n, NULL, entry) {
 		list_move_tail(&work->entry, head);
 		if (!(*work_data_bits(work) & WORK_STRUCT_LINKED))
 			break;
@@ -1193,7 +1193,7 @@ static void move_linked_works(struct work_struct *work, struct list_head *head,
  *
  * If @nextp is not NULL, it's updated to point to the next work of the last
  * scheduled work. This allows assign_work() to be nested inside
- * list_for_each_entry_safe().
+ * list_for_each_entry_mutable().
  *
  * Returns %true if @work was successfully assigned to @worker. %false if @work
  * was punted to another worker already executing it.
@@ -2912,9 +2912,9 @@ static void detach_dying_workers(struct list_head *cull_list)
 
 static void reap_dying_workers(struct list_head *cull_list)
 {
-	struct worker *worker, *tmp;
+	struct worker *worker;
 
-	list_for_each_entry_safe(worker, tmp, cull_list, entry) {
+	list_for_each_entry_mutable(worker, cull_list, entry) {
 		list_del_init(&worker->entry);
 		kthread_stop_put(worker->task);
 		kfree(worker);
@@ -3550,7 +3550,7 @@ static bool assign_rescuer_work(struct pool_workqueue *pwq, struct worker *rescu
 		work = list_next_entry(cursor, entry);
 
 	/* find the next work item to rescue */
-	list_for_each_entry_safe_from(work, n, &pool->worklist, entry) {
+	list_for_each_entry_mutable_from(work, n, &pool->worklist, entry) {
 		if (get_work_pwq(work) == pwq && assign_work(work, rescuer, &n)) {
 			pwq->stats[PWQ_STAT_RESCUED]++;
 			/* put the cursor for next search */
@@ -4157,7 +4157,7 @@ void __flush_workqueue(struct workqueue_struct *wq)
 		struct wq_flusher *next, *tmp;
 
 		/* complete all the flushers sharing the current flush color */
-		list_for_each_entry_safe(next, tmp, &wq->flusher_queue, list) {
+		list_for_each_entry_mutable(next, &wq->flusher_queue, list) {
 			if (next->flush_color != wq->flush_color)
 				break;
 			list_del_init(&next->list);
@@ -7080,7 +7080,7 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 	LIST_HEAD(ctxs);
 	int ret = 0;
 	struct workqueue_struct *wq;
-	struct apply_wqattrs_ctx *ctx, *n;
+	struct apply_wqattrs_ctx *ctx;
 
 	lockdep_assert_held(&wq_pool_mutex);
 
@@ -7097,7 +7097,7 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 		list_add_tail(&ctx->list, &ctxs);
 	}
 
-	list_for_each_entry_safe(ctx, n, &ctxs, list) {
+	list_for_each_entry_mutable(ctx, &ctxs, list) {
 		if (!ret)
 			apply_wqattrs_commit(ctx);
 		apply_wqattrs_cleanup(ctx);
-- 
2.43.0


