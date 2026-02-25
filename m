Return-Path: <cgroups+bounces-14241-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MZtNkaCnmmTVwQAu9opvQ
	(envelope-from <cgroups+bounces-14241-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:01:58 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E448191B31
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7FA130747B5
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEF82D7DD9;
	Wed, 25 Feb 2026 05:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abDuhjD4"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFF02D77FA;
	Wed, 25 Feb 2026 05:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995673; cv=none; b=MdHuMS8gnPFz0cXSEALzUX70MYenyu2e1LIKRZT2zzUrpaosKtkVw8eRM/WkBzMBaRTxkugjTR2bKNlIT+aKzIo4x8WL5FxNoIpr+445zYwr1Fwpz6UW+PmD5GoF2XKKzCgMTjzcS0ahMaf3f5pNQ9OT6eztnltkyiHvf8a/nzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995673; c=relaxed/simple;
	bh=nC/y+Q1GXw/2eyYYfy80AaGlsw6Nuh7Pb1KJE/rv2U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQ13cnlO3TwnM4urkdAeM+Zs+Lxjt7g0cDYHIe96Vk2zWDwJ/1ZxlQA04fePIO8Zg6NBPjV5jC4gpf5IQWtl3Y0lVWkKn8sNSDxuXPXdatLlbfRw9xhlfoVCVeItyjEd9WoZJiUkU8NayVL6D6cMMLf91nIr0E3LUYpUGAJhSm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abDuhjD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2FCC19422;
	Wed, 25 Feb 2026 05:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995672;
	bh=nC/y+Q1GXw/2eyYYfy80AaGlsw6Nuh7Pb1KJE/rv2U8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=abDuhjD4ZYLJR6VOWISRW61bxiQQnY+ZyDcklm1xqbbX20zDGDhyPIT+GtHJ4opdD
	 3jv2ZNk9C6Nirabaz4aPipL6CaLvuyJInJryfrPcbVZNi8Lp3Zi0fXZgKjclUU0GwE
	 /nCXzg8y6E+n4OwxEgWcJ0MN6UjOeVr4jWebrUdz54/Aq+RI34ylJQm9R7GdFtL1aN
	 FQEO5gN8/9za/iz6bC2aZFJtbWlrPDEOckjEF+V2Df9PBXrS2pc1yabBOojMFmP2YG
	 dSAcTkbfuih5pncr9ynAO254eMgwWLEMh13/aH/1IpQ5Ytx5FjXPF0QLmjt7KL1XnW
	 EO0CgXugXaHmA==
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
	Tejun Heo <tj@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 02/34] sched_ext: Add @kargs to scx_fork()
Date: Tue, 24 Feb 2026 19:00:37 -1000
Message-ID: <20260225050109.1070059-3-tj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14241-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 9E448191B31
X-Rspamd-Action: no action

Make sched_cgroup_fork() pass @kargs to scx_fork(). This will be used to
determine @p's cgroup for cgroup sub-sched support.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c | 2 +-
 kernel/sched/ext.c  | 2 +-
 kernel/sched/ext.h  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 759777694c78..7ba80220a276 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4721,7 +4721,7 @@ int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 		p->sched_class->task_fork(p);
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 
-	return scx_fork(p);
+	return scx_fork(p, kargs);
 }
 
 void sched_cancel_fork(struct task_struct *p)
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 25b9b488ed1f..edc88c1f744d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3167,7 +3167,7 @@ void scx_pre_fork(struct task_struct *p)
 	percpu_down_read(&scx_fork_rwsem);
 }
 
-int scx_fork(struct task_struct *p)
+int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 {
 	percpu_rwsem_assert_held(&scx_fork_rwsem);
 
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 43429b33e52c..0b7fc46aee08 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -11,7 +11,7 @@
 void scx_tick(struct rq *rq);
 void init_scx_entity(struct sched_ext_entity *scx);
 void scx_pre_fork(struct task_struct *p);
-int scx_fork(struct task_struct *p);
+int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs);
 void scx_post_fork(struct task_struct *p);
 void scx_cancel_fork(struct task_struct *p);
 bool scx_can_stop_tick(struct rq *rq);
@@ -44,7 +44,7 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 
 static inline void scx_tick(struct rq *rq) {}
 static inline void scx_pre_fork(struct task_struct *p) {}
-static inline int scx_fork(struct task_struct *p) { return 0; }
+static inline int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs) { return 0; }
 static inline void scx_post_fork(struct task_struct *p) {}
 static inline void scx_cancel_fork(struct task_struct *p) {}
 static inline u32 scx_cpuperf_target(s32 cpu) { return 0; }
-- 
2.53.0


