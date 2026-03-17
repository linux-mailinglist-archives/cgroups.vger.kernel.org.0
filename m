Return-Path: <cgroups+bounces-14843-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEcLEmUxuWn4uAEAu9opvQ
	(envelope-from <cgroups+bounces-14843-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 11:48:05 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 286002A837C
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 11:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B89623025266
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 10:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2160037C0F9;
	Tue, 17 Mar 2026 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bECMsyEM"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830FA364925;
	Tue, 17 Mar 2026 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744469; cv=none; b=M/74pH3YEMpRnYKQnVHARQcOraJr4VZwkQGkumdgmnAZm2BIGVdLvgpb+QW2AIgnzxc2HyDDVcrpGMLuTKu/ULS8q8M19fg21ZRsJPimuKu+i2VndwzUs98J4h85ZoKP67GZjUXX6bonkh95PfpPDq1SRaAG07efJbt7LC0MCK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744469; c=relaxed/simple;
	bh=BGCul55Vi9g6OEb/YK/4n28IrjDLTj1cMq11HW01sMA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GnyrU89YiX51HA7Y0fi07RHjHH6Nqj2gSPoXP3bD5+oJIorzBdENqlIq9dfY5YkpTRdWlQL8nWhz5jvhe2ZbI6kQS+PjA8/YZmzir7uWHuRjn5oQKkZbYE1L1ZmQ7WbZ00gq+qLHjj+8fUY+Xv1j+H4YHi6CFaGyA2j/no+VpvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bECMsyEM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=1uNe0XdInvRjclNE9H5+/v0jGlGWKmLTRIC+ImkMMgE=; b=bECMsyEMEcS35UkOR0CvcVT6Jm
	OG/caR4uU65ZsfZopdqAp6ocB44xslaF8rE9D+xhPqP5iOYtyob2YE0bn4b85YeY3xsXxsiRkEfVw
	ysSXVk3bss3jzlYShCzg4NEogniQNNUBvZPGVJjz6GL7mE+Y4Ie/RUNX2UMvZeHaKgm8YfALOvjrr
	yNceYQsCpgk7cp3j7lendqD6JtRzYh5R1yUvFum0YGB5c3vdio4T7YplzwSu8HghUjJuc4Gyub/LK
	Cfv/qoGFXVzliTKyjvZIJb2BwADo0fFCvGLW4iXksTQcU+3sXCRV9X5QH6GZoM0PToObzEbLj1AAr
	ol0ccsmQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2RxY-00000002YWq-0siI;
	Tue, 17 Mar 2026 10:47:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 21A083032BC; Tue, 17 Mar 2026 11:47:35 +0100 (CET)
Message-ID: <20260317104342.700967988@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 17 Mar 2026 10:51:16 +0100
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
 kprateek.nayak@amd.com
Subject: [RFC][PATCH 3/8] sched/fair: Add cgroup_mode: UP
References: <20260317095113.387450089@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14843-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:dkim,infradead.org:email,infradead.org:mid]
X-Rspamd-Queue-Id: 286002A837C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Instead of calculating the proportional fraction of tg->shares for
each CPU, just give each CPU the full measure, ignoring these pesky
SMP problems.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/debug.c |    3 ++-
 kernel/sched/fair.c  |   19 ++++++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -588,9 +588,10 @@ static void debugfs_fair_server_init(voi
 }
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-int cgroup_mode = 0;
+int cgroup_mode = 1;
 
 static const char *cgroup_mode_str[] = {
+	"up",
 	"smp",
 };
 
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4152,7 +4152,7 @@ static inline int throttled_hierarchy(st
  *
  * hence icky!
  */
-static long calc_group_shares(struct cfs_rq *cfs_rq)
+static long calc_smp_shares(struct cfs_rq *cfs_rq)
 {
 	long tg_weight, tg_shares, load, shares;
 	struct task_group *tg = cfs_rq->tg;
@@ -4187,6 +4187,23 @@ static long calc_group_shares(struct cfs
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
+static long calc_group_shares(struct cfs_rq *cfs_rq)
+{
+	if (cgroup_mode == 0)
+		return calc_up_shares(cfs_rq);
+
+	return calc_smp_shares(cfs_rq);
+}
+
+/*
  * Recomputes the group entity based on the current state of its group
  * runqueue.
  */



