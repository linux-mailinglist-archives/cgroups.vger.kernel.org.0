Return-Path: <cgroups+bounces-14276-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNQ8GR+EnmmGVwQAu9opvQ
	(envelope-from <cgroups+bounces-14276-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:09:51 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0837C191CB9
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 46A32308BAE5
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6120A33B6EC;
	Wed, 25 Feb 2026 05:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/tU8nsi"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20829336EE7;
	Wed, 25 Feb 2026 05:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995715; cv=none; b=t+6RF/Def6Jzlc6sfjpTURyuw1IS7Cy8CodDapfz/Teu6yKx296qNXAvcHVEHgBwZDyoI9UOJdOYNAcBAk3VPVeBMjhAEJRCltaYIe/QVB2x9pMZDZclCSIJZCjspG2/ZA/QhiMcxxGZQOSGJoCryg7kQDhYFMC/h77KZtr7U7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995715; c=relaxed/simple;
	bh=nC/y+Q1GXw/2eyYYfy80AaGlsw6Nuh7Pb1KJE/rv2U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agBn/7Az8kvsO3aUhm1ZIsMWuWdHM9ZJVcQ/96Ksm9bzwxPehW0ixQTWW2C9R1PAHihpJcuNJFINS+vGdxwUa8d/lEaMUTphjyO6IXragaKILecjKZiIWJDH97Iot1jBOeDoD4MbPgIhvgwpIMzfKQnrLe4iQy/fhFvvcVPNABU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/tU8nsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACAFC116D0;
	Wed, 25 Feb 2026 05:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995715;
	bh=nC/y+Q1GXw/2eyYYfy80AaGlsw6Nuh7Pb1KJE/rv2U8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R/tU8nsiTork1H2uyPXlyt8vbV1JPU6gQj3ZL1byw0x+g44QFs0vj9aKI96/fwo7N
	 Vpg2ctmdGlJtmTcWrGIN+h1/wJSXUtuLEpp1LYOyfvkHZrZX83CodwK6OfJ74f1aR5
	 b4VGxByuvKIWIYD3xQlvib7hUU/nCpxeRb9puZa5XrPlAPgrY8nApWr/ReZW/QCZiG
	 x4IoPocnfX4Zh/2Lu//pF095XhkAU52dov3L2SpdsnmQrg4mhI9s7Ad4jqpLBXlMJN
	 aQOX05QvX/2caf/xwze0AtNp6Mizzjdwij8wHCBRqoJva3mlpWQHEsPFb3had2k72Y
	 aq0Nc8NEKZjcA==
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
Date: Tue, 24 Feb 2026 19:01:20 -1000
Message-ID: <20260225050152.1070601-3-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225050152.1070601-1-tj@kernel.org>
References: <20260225050152.1070601-1-tj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14276-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0837C191CB9
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


