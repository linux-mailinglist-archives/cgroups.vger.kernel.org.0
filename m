Return-Path: <cgroups+bounces-15753-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PZnDKfGAWoRjwEAu9opvQ
	(envelope-from <cgroups+bounces-15753-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 14:08:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CA150D57C
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 14:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94AF03015852
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 12:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09863A3815;
	Mon, 11 May 2026 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VF8ceFE+"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A922837B40C;
	Mon, 11 May 2026 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501244; cv=none; b=pVewIgGPyjalleN6cdMluS9lLIPi0pTWUzINb0Cb6wAVK9sZCHc6nl7S/dUnDGSaSZIhF6bfHQnaxaSz9QAI9CGHXXCou+i4/Iz1rgsuoeZyGpM/2U2oxBMVDvA57F78ieprqv3trxut5G1OErzoS/36Dy9inLGXVRqoa/i78ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501244; c=relaxed/simple;
	bh=7WZiidKf/QSpiQu+Wq97gNh/r7ibrr9HmrfjaGfAEtA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rg+LeFpjia9T90lw98AG9t3IwpwFR8Xbaw7TeAx+L/gBnDSa/8mx5MlUzuylXxi9YXU4/jA582NQV6ayf/yuz9Pxd5VeWBl+QGZdyPFlUHSmoIjdAQUczTDFAsQTSjCHBFaQ7wWAyduVoLHPb5duDBD7EgvFlYIFh8+MnJg7XO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VF8ceFE+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=H9fAEjauTnGfYqGrALj1lwI49DvVQ9DpcV3mAqAYu5I=; b=VF8ceFE+Ap4xxRZHvdWwkKjPNs
	tL8VLChZWU6jILDjoCrQub9kOiELAvymLlvQbbSY2npy/dEJJYaCDGE/Vo44oWEM9rxR4/Sr6M/Ck
	5FmkqdAB08UT7t2gAPFixNMLwBMrtcf4p3kToLIFDS/WusPKog5/cU3RfafkiZu0FRpAbq275ZXZr
	EUZA2xw5KoJF18WoO3waRnCiTEniqlTBb9DsVvz/Fn9MIGa1IaRiu9laxGw/Uhp0GBy6o/V6UR9R0
	/SNWRaM3sid2FXcSD50xCTiD2Rnkn6xql8bG70Xfs1faKx9NlCsxkE/zWvFUrPkxRszqw14bUm43l
	Hnbs6aWQ==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPPa-000000088mQ-0tbT;
	Mon, 11 May 2026 12:07:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 20E62303038; Mon, 11 May 2026 14:07:00 +0200 (CEST)
Message-ID: <20260511120627.592793383@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 11 May 2026 13:31:09 +0200
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
Subject: [PATCH v2 05/10] sched/fair: Add cgroup_mode: UP
References: <20260511113104.563854162@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: E0CA150D57C
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-15753-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:email,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Action: no action

Instead of calculating the proportional fraction of tg->shares for
each CPU, just give each CPU the full measure, ignoring these pesky
SMP problems.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/debug.c |    3 ++-
 kernel/sched/fair.c  |   21 ++++++++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -589,9 +589,10 @@ static void debugfs_fair_server_init(voi
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
@@ -4150,7 +4150,7 @@ static inline int throttled_hierarchy(st
  *
  * hence icky!
  */
-static long calc_group_shares(struct cfs_rq *cfs_rq)
+static long calc_smp_shares(struct cfs_rq *cfs_rq)
 {
 	long tg_weight, tg_shares, load, shares;
 	struct task_group *tg = cfs_rq->tg;
@@ -4185,6 +4185,25 @@ static long calc_group_shares(struct cfs
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
+	int mode = READ_ONCE(cgroup_mode);
+
+	if (mode == 0)
+		return calc_up_shares(cfs_rq);
+
+	return calc_smp_shares(cfs_rq);
+}
+
+/*
  * Recomputes the group entity based on the current state of its group
  * runqueue.
  */



