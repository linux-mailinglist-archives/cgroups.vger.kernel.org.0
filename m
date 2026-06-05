Return-Path: <cgroups+bounces-16663-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fjq9LzzGImordgEAu9opvQ
	(envelope-from <cgroups+bounces-16663-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 14:51:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D937648539
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 14:51:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=desiato.20200630 header.b=fy0qlg1+;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16663-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16663-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBCC93077BA4
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 12:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7393DCD8A;
	Fri,  5 Jun 2026 12:43:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3473CCFAF;
	Fri,  5 Jun 2026 12:43:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780663419; cv=none; b=hoy9ElROiZUcpjbIterwhiJsVoLVygYwQmNZQladcwBJXqfVMsB2ixM1VLwp5fXsPAqPfKzvndF1J5Du/RZYCgwN13f55mQ5wnHHEdytyuADzVMvSIz6ERwa1Ms3LHRjLqxxxFckUaqfNONXgKAaLSsuF6Fc6CpBFD6jwqfCPz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780663419; c=relaxed/simple;
	bh=lbzlG6CnYK/XlgVM9FGh8L8DRqCeQViAtJK/BYTj3Ck=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Qi8kJnF4XywpBrnURy70NG6m/aFZfiq8NlFOL/v7Mm+FUwRELkL96yT5H4I/m4J3T0XkXkKJ/9eyJzQwcXkeT5cwodfrEFbrXJpfZwc/sNjnNpOHUtsMxMJZcJWKiMBuqpKerK7GlMCpyb/EdvEIDolWGiGIoRdstHZfufMhVX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fy0qlg1+; arc=none smtp.client-ip=90.155.92.199
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Cok1Asq6labJWXMXmPjojFgpwVmhgYai3/1aGF0Onxk=; b=fy0qlg1+Q3tsdt8eA4ds4ROGZi
	1O8Dupxx1PBpvPgSHWPa8WP+zEMG7FknkNH/DTMdWkCLGTILaU/7VWYmBsQM6ym5rKQFMcZbJksew
	vPjEWw4YEt5UR4sz4KT6EYsDT2qSfvGPns0hgur9R7SL8DmOPTqTbgXcEKhewG/xcSVGG64nigoTL
	Ep7iuy9u0YeGpx7knY78sGL0JAl/oalUVA0A4Dr4j7Y14X8GAAWpJdBI5Y30FZgyBLWWE48XG/NWj
	CD5xft0D6ZTpB4MWvh9KT3VbzuQPWKzwfeRwTnTJ9MEsVNT0dAO1IItJ5+PqtbcuW/aiqaVSSCGTd
	yUXbdkSg==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVTtJ-0000000FbIG-1Any;
	Fri, 05 Jun 2026 12:43:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 28653302D6E; Fri, 05 Jun 2026 14:43:11 +0200 (CEST)
Message-ID: <20260605124051.450303977@infradead.org>
User-Agent: quilt/0.68
Date: Fri, 05 Jun 2026 14:40:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Cc: longman@redhat.com,
 chenridong@huaweicloud.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tj@kernel.org,
 hannes@cmpxchg.org,
 mkoutny@suse.com,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 jstultz@google.com,
 kprateek.nayak@amd.com,
 qyousef@layalina.io
Subject: [PATCH v3 2/7] sched/fair: Add cgroup_mode: up
References: <20260605105513.354837583@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16663-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mingo@kernel.org,m:longman@redhat.com,m:chenridong@huaweicloud.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jstultz@google.com,m:kprateek.nayak@amd.com,m:qyousef@layalina.io,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,infradead.org:mid,infradead.org:dkim,infradead.org:from_mime,infradead.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D937648539

Instead of calculating the proportional fraction of the group weight for each
CPU, just give each CPU the full measure, ignoring these pesky SMP problems.

This makes the SMP cgroup fraction (F_g_n) equal to 1, and ensures a single
task in a cgroup competes on equal footing to a task in a level above.

However, as already explored, this is not a very good policy because it gets
the SMP weight distribution wrong. Included for completeness.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/debug.c |    5 ++++-
 kernel/sched/fair.c  |   31 +++++++++++++++++++++++++++++--
 kernel/sched/sched.h |    1 +
 3 files changed, 34 insertions(+), 3 deletions(-)

--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -271,6 +271,7 @@ static ssize_t sched_dynamic_write(struc
 	if (mode < 0)
 		return mode;
 
+	__sched_cgroup_mode_update(mode);
 	sched_dynamic_update(mode);
 
 	*ppos += cnt;
@@ -634,9 +635,11 @@ static void debugfs_fair_server_init(voi
 }
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-static int cgroup_mode = 0;
+static int cgroup_mode = 1;
 
+/* See __sched_cgroup_mode_update(). */
 static const char *cgroup_mode_str[] = {
+	"up",
 	"smp",
 };
 
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -38,6 +38,7 @@
 #include <linux/sched/isolation.h>
 #include <linux/sched/nohz.h>
 #include <linux/sched/prio.h>
+#include <linux/static_call.h>
 
 #include <linux/cpuidle.h>
 #include <linux/interrupt.h>
@@ -4800,7 +4801,7 @@ static inline int throttled_hierarchy(st
  *
  * hence icky!
  */
-static long calc_group_shares(struct cfs_rq *cfs_rq)
+static long calc_smp(struct cfs_rq *cfs_rq)
 {
 	long tg_weight, tg_shares, load, shares;
 	struct task_group *tg = cfs_rq->tg;
@@ -4835,6 +4836,32 @@ static long calc_group_shares(struct cfs
 }
 
 /*
+ * Ignore this pesky SMP stuff, use (4).
+ */
+static long calc_up_shares(struct cfs_rq *cfs_rq)
+{
+	struct task_group *tg = cfs_rq->tg;
+	return READ_ONCE(tg->shares);
+}
+
+DEFINE_STATIC_CALL(calc_group_shares, calc_smp_shares);
+
+void __sched_cgroup_mode_update(int mode)
+{
+	long (*func)(struct cfs_rq *);
+	switch (mode) {
+	case 0:
+		func = &calc_up_shares;
+		break;
+	case 1:
+	default:
+		func = &calc_smp_shares;
+		break;
+	}
+	static_call_update(calc_group_shares, func);
+}
+
+/*
  * Recomputes the group entity based on the current state of its group
  * runqueue.
  */
@@ -4850,7 +4877,7 @@ static void update_cfs_group(struct sche
 	if (!gcfs_rq || !gcfs_rq->load.weight)
 		return;
 
-	shares = calc_group_shares(gcfs_rq);
+	shares = static_call(calc_group_shares)(gcfs_rq);
 	if (unlikely(se->load.weight != shares))
 		reweight_entity(cfs_rq_of(se), se, shares);
 }
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -571,6 +571,7 @@ extern void free_fair_sched_group(struct
 extern int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent);
 extern void online_fair_sched_group(struct task_group *tg);
 extern void unregister_fair_sched_group(struct task_group *tg);
+extern void __sched_cgroup_mode_update(int mode);
 #else /* !CONFIG_FAIR_GROUP_SCHED: */
 static inline void free_fair_sched_group(struct task_group *tg) { }
 static inline int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)



