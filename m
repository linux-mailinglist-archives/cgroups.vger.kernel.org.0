Return-Path: <cgroups+bounces-14252-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEwcC0GDnmmGVwQAu9opvQ
	(envelope-from <cgroups+bounces-14252-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:06:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B46B191BE2
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 061EA3142A1B
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182522FFDEB;
	Wed, 25 Feb 2026 05:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eo53FaXi"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18182F745E;
	Wed, 25 Feb 2026 05:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995684; cv=none; b=LibuZKp2FNs7jYli5Z5zt+H5P+BPqdncomO5/wo3CpcFkZp/lt/eoHOLoivMcFeChI+EfBC1KgjER6UiIFkmeRNwMPabDqk6fJJ/VkMUXChiL9CnKEKvWagdngxNwxhYjY40UnJYwh3vB5BVGtzg8uT7g/nmLI4uyVUpOUj/5OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995684; c=relaxed/simple;
	bh=VvdZl4py1BpzLNrbfV+QRBdjpcwUcA71fqTaUdDAGwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0P0FNJUJ8tTfdal/I/+0BMgwVysvodJaFkXWg/1EJQRwOdWI7yx6po4Xmn9ebEi2R8zcKtvtqPJog0ETVbWoTGQvXtFKkexpQNrs1lTUQ2NMfNAWhmH3AFWLiwiY/1izelx11fF99Cx+Ymd5/hQ3hFXsbLDuehxctxqBRznJzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eo53FaXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59482C116D0;
	Wed, 25 Feb 2026 05:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995684;
	bh=VvdZl4py1BpzLNrbfV+QRBdjpcwUcA71fqTaUdDAGwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eo53FaXizgqWSYxsZvXbKQk/J4NaRD1t3C6EMFYMBxJHnt9YBiJs5TjjciS/mxPGq
	 zUkklaZBgcU0TRC8XCnM0muxrdv/j1OQrMDmAYG/0ALTAYLAQQAYbL9ykVwCxxGJgd
	 3L/dcSTNLzaCWpZi+IWlFxXOQKelNBgL5KqtIl+d6CTJxxJKkgNwrtCnYn9nfjavvq
	 t6tRFC8ejcdphjzJNf4MAbdPMxLjktwjcYk7jjCRLUH4zRNRnmmPUO+DgR3xd2sj8L
	 aqEM55OQQaAO8dz6CeLiISFDqjm8cGz8mGnzukb7ebK3FKLb697l1x6n7X5w3TFHc6
	 UXlILwzjEQF7A==
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
Subject: [PATCH 13/34] sched_ext: Refactor task init/exit helpers
Date: Tue, 24 Feb 2026 19:00:48 -1000
Message-ID: <20260225050109.1070059-14-tj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14252-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B46B191BE2
X-Rspamd-Action: no action

- Add the @sch parameter to scx_init_task() and drop @tg as it can be
  obtained from @p. Separate out __scx_init_task() which does everything
  except for the task state transition.

- Add the @sch parameter to scx_enable_task(). Separate out
  __scx_enable_task() which does everything except for the task state
  transition.

- Add the @sch parameter to scx_disable_task().

- Rename scx_exit_task() to scx_disable_and_exit_task() and separate out
  __scx_disable_and_exit_task() which does everything except for the task
  state transition.

While some task state transitions are relocated, no meaningful behavior
changes are expected.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 67 +++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 33e9129a8073..5d13b9b93249 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3107,9 +3107,9 @@ static void scx_set_task_state(struct task_struct *p, enum scx_task_state state)
 	p->scx.flags |= state << SCX_TASK_STATE_SHIFT;
 }
 
-static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork)
+static int __scx_init_task(struct scx_sched *sch, struct task_struct *p, bool fork)
 {
-	struct scx_sched *sch = scx_root;
+	struct task_group *tg = task_group(p);
 	int ret;
 
 	p->scx.disallow = false;
@@ -3128,8 +3128,6 @@ static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork
 		}
 	}
 
-	scx_set_task_state(p, SCX_TASK_INIT);
-
 	if (p->scx.disallow) {
 		if (unlikely(scx_parent(sch))) {
 			scx_error(sch, "non-root ops.init_task() set task->scx.disallow for %s[%d]",
@@ -3159,13 +3157,27 @@ static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork
 		}
 	}
 
-	p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
 	return 0;
 }
 
-static void scx_enable_task(struct task_struct *p)
+static int scx_init_task(struct scx_sched *sch, struct task_struct *p, bool fork)
+{
+	int ret;
+
+	ret = __scx_init_task(sch, p, fork);
+	if (!ret) {
+		/*
+		 * While @p's rq is not locked. @p is not visible to the rest of
+		 * SCX yet and it's safe to update the flags and state.
+		 */
+		p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
+		scx_set_task_state(p, SCX_TASK_INIT);
+	}
+	return ret;
+}
+
+static void __scx_enable_task(struct scx_sched *sch, struct task_struct *p)
 {
-	struct scx_sched *sch = scx_root;
 	struct rq *rq = task_rq(p);
 	u32 weight;
 
@@ -3191,16 +3203,20 @@ static void scx_enable_task(struct task_struct *p)
 
 	if (SCX_HAS_OP(sch, enable))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, enable, rq, p);
-	scx_set_task_state(p, SCX_TASK_ENABLED);
 
 	if (SCX_HAS_OP(sch, set_weight))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, set_weight, rq,
 				 p, p->scx.weight);
 }
 
-static void scx_disable_task(struct task_struct *p)
+static void scx_enable_task(struct scx_sched *sch, struct task_struct *p)
+{
+	__scx_enable_task(sch, p);
+	scx_set_task_state(p, SCX_TASK_ENABLED);
+}
+
+static void scx_disable_task(struct scx_sched *sch, struct task_struct *p)
 {
-	struct scx_sched *sch = scx_root;
 	struct rq *rq = task_rq(p);
 
 	lockdep_assert_rq_held(rq);
@@ -3218,9 +3234,9 @@ static void scx_disable_task(struct task_struct *p)
 	WARN_ON_ONCE(p->scx.flags & SCX_TASK_IN_CUSTODY);
 }
 
-static void scx_exit_task(struct task_struct *p)
+static void __scx_disable_and_exit_task(struct scx_sched *sch,
+					struct task_struct *p)
 {
-	struct scx_sched *sch = scx_task_sched(p);
 	struct scx_exit_task_args args = {
 		.cancelled = false,
 	};
@@ -3237,7 +3253,7 @@ static void scx_exit_task(struct task_struct *p)
 	case SCX_TASK_READY:
 		break;
 	case SCX_TASK_ENABLED:
-		scx_disable_task(p);
+		scx_disable_task(sch, p);
 		break;
 	default:
 		WARN_ON_ONCE(true);
@@ -3247,6 +3263,13 @@ static void scx_exit_task(struct task_struct *p)
 	if (SCX_HAS_OP(sch, exit_task))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, exit_task, task_rq(p),
 				 p, &args);
+}
+
+static void scx_disable_and_exit_task(struct scx_sched *sch,
+				      struct task_struct *p)
+{
+	__scx_disable_and_exit_task(sch, p);
+
 	scx_set_task_sched(p, NULL);
 	scx_set_task_state(p, SCX_TASK_NONE);
 }
@@ -3282,7 +3305,7 @@ int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 	percpu_rwsem_assert_held(&scx_fork_rwsem);
 
 	if (scx_init_task_enabled) {
-		ret = scx_init_task(p, task_group(p), true);
+		ret = scx_init_task(scx_root, p, true);
 		if (!ret)
 			scx_set_task_sched(p, scx_root);
 		return ret;
@@ -3306,7 +3329,7 @@ void scx_post_fork(struct task_struct *p)
 			struct rq *rq;
 
 			rq = task_rq_lock(p, &rf);
-			scx_enable_task(p);
+			scx_enable_task(scx_task_sched(p), p);
 			task_rq_unlock(rq, p, &rf);
 		}
 	}
@@ -3326,7 +3349,7 @@ void scx_cancel_fork(struct task_struct *p)
 
 		rq = task_rq_lock(p, &rf);
 		WARN_ON_ONCE(scx_get_task_state(p) >= SCX_TASK_READY);
-		scx_exit_task(p);
+		scx_disable_and_exit_task(scx_task_sched(p), p);
 		task_rq_unlock(rq, p, &rf);
 	}
 
@@ -3385,7 +3408,7 @@ void sched_ext_dead(struct task_struct *p)
 		struct rq *rq;
 
 		rq = task_rq_lock(p, &rf);
-		scx_exit_task(p);
+		scx_disable_and_exit_task(scx_task_sched(p), p);
 		task_rq_unlock(rq, p, &rf);
 	}
 }
@@ -3417,7 +3440,7 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 	if (task_dead_and_done(p))
 		return;
 
-	scx_enable_task(p);
+	scx_enable_task(sch, p);
 
 	/*
 	 * set_cpus_allowed_scx() is not called while @p is associated with a
@@ -3433,7 +3456,7 @@ static void switched_from_scx(struct rq *rq, struct task_struct *p)
 	if (task_dead_and_done(p))
 		return;
 
-	scx_disable_task(p);
+	scx_disable_task(scx_task_sched(p), p);
 }
 
 static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_flags) {}
@@ -4662,7 +4685,7 @@ static void scx_root_disable(struct scx_sched *sch)
 
 	/*
 	 * Shut down cgroup support before tasks so that the cgroup attach path
-	 * doesn't race against scx_exit_task().
+	 * doesn't race against scx_disable_and_exit_task().
 	 */
 	scx_cgroup_lock();
 	scx_cgroup_exit(sch);
@@ -4691,7 +4714,7 @@ static void scx_root_disable(struct scx_sched *sch)
 			p->sched_class = new_class;
 		}
 
-		scx_exit_task(p);
+		scx_disable_and_exit_task(scx_task_sched(p), p);
 	}
 	scx_task_iter_stop(&sti);
 
@@ -5567,7 +5590,7 @@ static s32 scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 		scx_task_iter_unlock(&sti);
 
-		ret = scx_init_task(p, task_group(p), false);
+		ret = scx_init_task(sch, p, false);
 		if (ret) {
 			put_task_struct(p);
 			scx_task_iter_stop(&sti);
-- 
2.53.0


