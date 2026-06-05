Return-Path: <cgroups+bounces-16660-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Qs5fC2TFImrydQEAu9opvQ
	(envelope-from <cgroups+bounces-16660-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 14:47:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF686484CA
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 14:47:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=desiato.20200630 header.b="CH/VSXrf";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16660-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16660-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1B533047072
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 12:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E5B3C343B;
	Fri,  5 Jun 2026 12:43:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19D33BE178;
	Fri,  5 Jun 2026 12:43:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780663417; cv=none; b=r2eKlBP6P8eY6KwTEDbp0X2xub1EomXzr8s+msrcKSKVbJDXurk/wAkN2nHOcVbVSgkY/M7S9C7zPzIp2HGAxoFDgOX9U0uUFcwm8S/jgyJNgCAJ2qPE9JIZdXfUJy06xAgEkxHKXBSlNycFSb+1s/PNi8u2wmQR0IrLUvmhOh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780663417; c=relaxed/simple;
	bh=wPXmGodprzDP+VkF82WYp0drWRnJQcEqtntT6G1+gto=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sC6HKoyZ+NnBcwyT4UwRsLp9S9oWRTAZshS9VGM0juEvj56eR3HOluu1AmHaMZF3zDFE7stPm4BkiINA3j+7KQwemUyjDGzsKoxeT2B+USShsc27kprGtjDxZNj02/YypFTbnWYcsLikBc6WrOHDiIyZ9yA7fIFBGww3t63bZ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CH/VSXrf; arc=none smtp.client-ip=90.155.92.199
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=DFUPfbO4QZ1wRkdXk7p/tFg3ovHGoKUf1O97CDPHAEI=; b=CH/VSXrfdeRZMoyKl1RKWY7GSY
	jYART92EHPk5R+WquOVRNPPzZhBqCfNoL6B/biXOpuvErHkt8t9dl5TkDUwuETV8Vzd0/LtlXqqf+
	nOeZqsFzKGS8PfzphN5D4CrRy+K/O+OeoTExW7d9snvHqGVFPNBZeD2OufcvVHRjPlepn3p/sgHlA
	9h9FHMnp8n+v8RZ1tLegXdCUV/t8IbHm7uGc1O1DgRNiLTFA3523gm3aSzg7BDy/7mAgt9oIe5VuT
	Rp95sUuFp0owkkeYU55JZMLz7izQCon95o/kdXCxlPdFfry7oyWrM1wmAxCxM7HGN7jD61HXnjzV4
	hxnCnMvw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVTtJ-0000000FbIK-3GTu;
	Fri, 05 Jun 2026 12:43:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 3749B3030E7; Fri, 05 Jun 2026 14:43:11 +0200 (CEST)
Message-ID: <20260605124051.921991975@infradead.org>
User-Agent: quilt/0.68
Date: Fri, 05 Jun 2026 14:40:18 +0200
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
Subject: [PATCH v3 5/7] sched/fair: Add cgroup_mode: tasks
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16660-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,infradead.org:mid,infradead.org:dkim,infradead.org:from_mime,infradead.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBF686484CA

Since we are exploring this space; include a scheme that scales by total number
of runnable tasks. This results in:

	F_g_n' = M * F_g_n

This will obviously have: avg(F_g_n') > 1, (it will be ~M/N in fact).

And while that sounds odd, it actually has a fairly straight foward meaning for
"cpu.weight": average weight per member task.

This is an entirely valid and workable option, it is however wildly different
from the traditional meaning.

Included for completeness (and curiosity).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/debug.c |    1 +
 kernel/sched/fair.c  |   16 ++++++++++++++++
 2 files changed, 17 insertions(+)

--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -643,6 +643,7 @@ static const char *cgroup_mode_str[] = {
 	"smp",
 	"concur",
 	"max",
+	"tasks",
 };
 
 static int sched_cgroup_mode(const char *str)
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4852,6 +4852,19 @@ static inline int tg_tasks(struct task_g
 }
 
 /*
+ * Func: fraction(nr_tasks * tg->shares)
+ *
+ * Scale tg->shares by the number of tasks.
+ */
+static long calc_tasks_shares(struct cfs_rq *cfs_rq)
+{
+	struct task_group *tg = cfs_rq->tg;
+	int nr = tg_tasks(tg);
+	long tg_shares = READ_ONCE(tg->shares);
+	return __calc_smp_shares(cfs_rq, nr * tg_shares, nr * tg_shares);
+}
+
+/*
  * Func: min(fraction(nr_cpus * tg->shares), nice -20)
  *
  * Scale tg->shares by the maximal number of CPUs; but clip the max shares at
@@ -4921,6 +4934,9 @@ void __sched_cgroup_mode_update(int mode
 	case 3:
 		func = &calc_max_shares;
 		break;
+	case 4:
+		func = &calc_tasks_shares;
+		break;
 	}
 	static_call_update(calc_group_shares, func);
 }



