Return-Path: <cgroups+bounces-14249-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMqwDXSCnmmGVwQAu9opvQ
	(envelope-from <cgroups+bounces-14249-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:02:44 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0F6191B66
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1870A307C897
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B407C2D77F5;
	Wed, 25 Feb 2026 05:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNdhozCy"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7578D2D77E6;
	Wed, 25 Feb 2026 05:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995681; cv=none; b=neMpP/ACiZzxTh3qOW8MzyUL228xZi9BpyYwfjrjL2GXb7v6aedpstnhKUcJf+e5CEWa4Wec4Rm092TfS81aHyDb3EjterOQl5JprGPNgslDKJoeGuDxlf7Xis/3ILIJfZ7h0angWPAge68GaRB6LSn2BjCbDYSB9rRHSdwBZjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995681; c=relaxed/simple;
	bh=Z077ddcPGOiCKNd/K3en5ZhE5g3u53bizh1Rzm4B5Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sg39vEmCZqTasUrJ0bzZSMlbJGC4aD+tJzDd5A2cMNuWIkYFuMCU7WYRV+C9z0oyeyBb7B8CUGbeQo6vbgBcfMnasRBe3TJFlxgR2P9lm4xMjcHSbEdXuBO1QFvUgom/oVri4fsMr16GrixGv5HYFgKIExQZhSj0e5qa2ysvG+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNdhozCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C609C116D0;
	Wed, 25 Feb 2026 05:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995681;
	bh=Z077ddcPGOiCKNd/K3en5ZhE5g3u53bizh1Rzm4B5Sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XNdhozCyLJmGYipzZNt0Le2EEMgL4DPI6TjI21ftQLsKAHek7p0twG0rysGnyFURs
	 yycwZ/zgFIDgT757SI7AnOU9Dw2iLzraHxI/NZQFp2iqq5hdBa8yUnEn1duw+a1bf8
	 DgcRtvqjyMv2J7awDIfzycAciHkhqnbA5EjZGkk15bxSVROTIilvmnaqmR3mvO+5Us
	 ddgGVgfcUgZnfDtlebfTFNo/fdWSSWKULaiDYDELJQ9rjNDEaB+1Bh1EGYCiFsz1QT
	 fjWSVuL6mE9K4jDDWfM6yneI82qgTQtmcJTke3KTdZEcUxv6FWiCeAdwuXkhZt1hNW
	 A8jmbSC6jChxw==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/34] sched_ext: Enforce scheduling authority in dispatch and select_cpu operations
Date: Tue, 24 Feb 2026 19:00:45 -1000
Message-ID: <20260225050109.1070059-11-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225050109.1070059-1-tj@kernel.org>
References: <20260225050109.1070059-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14249-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B0F6191B66
X-Rspamd-Action: no action

Add checks to enforce scheduling authority boundaries when multiple
schedulers are present:

1. In scx_dsq_insert_preamble() and the dispatch retry path, ignore attempts
   to insert tasks that the scheduler doesn't own, counting them via
   SCX_EV_INSERT_NOT_OWNED. As BPF schedulers are allowed to ignore
   dequeues, such attempts can occur legitimately during sub-scheduler
   enabling when tasks move between schedulers. The counter helps distinguish
   normal cases from scheduler bugs.

2. For scx_bpf_dsq_insert_vtime() and scx_bpf_select_cpu_and(), error out
   when sub-schedulers are attached. These functions lack the aux__prog
   parameter needed to identify the calling scheduler, so they cannot be used
   safely with multiple schedulers. BPF programs should use the arg-wrapped
   versions (__scx_bpf_dsq_insert_vtime() and __scx_bpf_select_cpu_and())
   instead.

These checks ensure that with multiple concurrent schedulers, scheduler
identity can be properly determined and unauthorized task operations are
prevented or tracked.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 26 ++++++++++++++++++++++++++
 kernel/sched/ext_idle.c     | 11 +++++++++++
 kernel/sched/ext_internal.h | 12 ++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 30dd65b33802..56ac2d5655a2 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2321,6 +2321,12 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
 		if ((opss & SCX_OPSS_QSEQ_MASK) != qseq_at_dispatch)
 			return;
 
+		/* see SCX_EV_INSERT_NOT_OWNED definition */
+		if (unlikely(!scx_task_on_sched(sch, p))) {
+			__scx_add_event(sch, SCX_EV_INSERT_NOT_OWNED, 1);
+			return;
+		}
+
 		/*
 		 * While we know @p is accessible, we don't yet have a claim on
 		 * it - the BPF scheduler is allowed to dispatch tasks
@@ -4011,6 +4017,7 @@ static ssize_t scx_attr_events_show(struct kobject *kobj,
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DURATION);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DISPATCH);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_ACTIVATE);
+	at += scx_attr_event_show(buf, at, &events, SCX_EV_INSERT_NOT_OWNED);
 	return at;
 }
 SCX_ATTR(events);
@@ -5131,6 +5138,7 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 	scx_dump_event(s, &events, SCX_EV_BYPASS_DURATION);
 	scx_dump_event(s, &events, SCX_EV_BYPASS_DISPATCH);
 	scx_dump_event(s, &events, SCX_EV_BYPASS_ACTIVATE);
+	scx_dump_event(s, &events, SCX_EV_INSERT_NOT_OWNED);
 
 	if (seq_buf_has_overflowed(&s) && dump_len >= sizeof(trunc_marker))
 		memcpy(ei->dump + dump_len - sizeof(trunc_marker),
@@ -6409,6 +6417,12 @@ static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p
 		return false;
 	}
 
+	/* see SCX_EV_INSERT_NOT_OWNED definition */
+	if (unlikely(!scx_task_on_sched(sch, p))) {
+		__scx_add_event(sch, SCX_EV_INSERT_NOT_OWNED, 1);
+		return false;
+	}
+
 	return true;
 }
 
@@ -6601,6 +6615,17 @@ __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
 	if (unlikely(!sch))
 		return;
 
+#ifdef CONFIG_EXT_SUB_SCHED
+	/*
+	 * Disallow if any sub-scheds are attached. There is no way to tell
+	 * which scheduler called us, just error out @p's scheduler.
+	 */
+	if (unlikely(!list_empty(&sch->children))) {
+		scx_error(scx_task_sched(p), "__scx_bpf_dsq_insert_vtime() must be used");
+		return;
+	}
+#endif
+
 	scx_dsq_insert_vtime(sch, p, dsq_id, slice, vtime, enq_flags);
 }
 
@@ -7933,6 +7958,7 @@ static void scx_read_events(struct scx_sched *sch, struct scx_event_stats *event
 		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_DURATION);
 		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_DISPATCH);
 		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_ACTIVATE);
+		scx_agg_event(events, e_cpu, SCX_EV_INSERT_NOT_OWNED);
 	}
 }
 
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 34487a83d3f7..321efd7b14fb 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -1061,6 +1061,17 @@ __bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64
 	if (unlikely(!sch))
 		return -ENODEV;
 
+#ifdef CONFIG_EXT_SUB_SCHED
+	/*
+	 * Disallow if any sub-scheds are attached. There is no way to tell
+	 * which scheduler called us, just error out @p's scheduler.
+	 */
+	if (unlikely(!list_empty(&sch->children))) {
+		scx_error(scx_task_sched(p), "__scx_bpf_select_cpu_and() must be used");
+		return -EINVAL;
+	}
+#endif
+
 	return select_cpu_from_kfunc(sch, p, prev_cpu, wake_flags,
 				     cpus_allowed, flags);
 }
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 679325e8c19b..3b17180ba3dd 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -911,6 +911,18 @@ struct scx_event_stats {
 	 * The number of times the bypassing mode has been activated.
 	 */
 	s64		SCX_EV_BYPASS_ACTIVATE;
+
+	/*
+	 * The number of times the scheduler attempted to insert a task that it
+	 * doesn't own into a DSQ. Such attempts are ignored.
+	 *
+	 * As BPF schedulers are allowed to ignore dequeues, it's difficult to
+	 * tell whether such an attempt is from a scheduler malfunction or an
+	 * ignored dequeue around sub-sched enabling. If this count keeps going
+	 * up regardless of sub-sched enabling, it likely indicates a bug in the
+	 * scheduler.
+	 */
+	s64		SCX_EV_INSERT_NOT_OWNED;
 };
 
 struct scx_sched_pcpu {
-- 
2.53.0


