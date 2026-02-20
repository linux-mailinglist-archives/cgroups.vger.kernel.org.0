Return-Path: <cgroups+bounces-14043-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPIHGCitl2nO5QIAu9opvQ
	(envelope-from <cgroups+bounces-14043-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 01:39:04 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90029163E17
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 01:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2AB7E300E4B0
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA2F1F1932;
	Fri, 20 Feb 2026 00:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FL0K6bXF"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8951F4180;
	Fri, 20 Feb 2026 00:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771547928; cv=none; b=GPmmKUXpAanuiJMfxY0D7WXPeT6LDFRaG3HywmQIrrjEx+zRiX3a0NjW/DjmtihjLmPx8pNQqAe5jXaMZAuWdoqaIIzrxwrOT15S2YEzgxy2y5i2fkb1k/nwWgJEmff2FuuE15WI210Ffasd2Z9tR/x+iKdxCUwQrRPvSypvQBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771547928; c=relaxed/simple;
	bh=rQtRX5ohX7vGBGBjzVHcp0rW36b98A2mn7TXYUJHP4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A6kVk6caTrR7504iMSGmA0GOYHpsNdTxLkCGwTYcRSquggvGU597cQLUZfVP7/qgCIqyBHv66Y0Z39CPN1GuF8kfmZ8R5vaKhxFn28D3GsV3k56cciX1ZuKRHK38wZ/N2nQQTAl+GOPwGlV4uLQtimWcTgI5HdJZjGxaBOlXYV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FL0K6bXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330C1C4CEF7;
	Fri, 20 Feb 2026 00:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771547928;
	bh=rQtRX5ohX7vGBGBjzVHcp0rW36b98A2mn7TXYUJHP4Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FL0K6bXFqg4jIllEBmUHk3Xk8hYcNar9d4pesEyDEPuGTWtQCR9e9Rk2vZunQTvht
	 PygePh15IsSKliaXnNJBDC9ZDPJTmMK6kRjPAvDLvfj9FohXS9MFAqhxukiwekfsNn
	 HN0D51SiDyp0FAtm9cmNqS5q3h+XPkD4pKq+eSS9DWcClbUz0DxE2Xbyt/Bh9ilSgh
	 fzCcSpHDHdUT6yGBU6ucfC6tQD9f4Hg40zk7TN4Mu1TdJ0mbBWSsS2auIa8c3Jexfp
	 Hy1uhqcPrKMzoUTvRtDh6qI7jroOZr/K+BJ8/aKnKDX5LjsVGw06O4G9f/USMyc06T
	 lUribCddDssow==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 20 Feb 2026 01:38:30 +0100
Subject: [PATCH 2/4] cgroup: add bpf hook for attach
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-work-bpf-namespace-v1-2-866207db7b83@kernel.org>
References: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
In-Reply-To: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Tejun Heo <tj@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 Lennart Poettering <lennart@poettering.net>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=6350; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rQtRX5ohX7vGBGBjzVHcp0rW36b98A2mn7TXYUJHP4Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROXyvAv7x/5U7GLz9cpMJnX7ruWG/l+r143/L3Gfndy
 Xd9Gi3dO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYiMIORYcMl3gj3l10hazzL
 m+N2csfxNfksmj1t7aOrAfvd2hJS3zL8lfPc8OjB+lNfd+s8rDzzRtVVQEbiJZd8klX5r7y0vhu
 b2QE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14043-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90029163E17
X-Rspamd-Action: no action

Add a hook to manage attaching tasks to cgroup. I'm in the process of
adding various "universal truth" bpf programs to systemd that will make
use of this.

This has been a long-standing request (cf. [1] and [2]). It will allow us to
enforce cgroup migrations and ensure that services can never escape their
cgroups. This is just one of many use-cases.

Link: https://github.com/systemd/systemd/issues/6356 [1]
Link: https://github.com/systemd/systemd/issues/22874 [2]
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/bpf_lsm.h | 15 +++++++++++++++
 kernel/bpf/bpf_lsm.c    | 12 ++++++++++++
 kernel/cgroup/cgroup.c  | 18 +++++++++++-------
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 5ae438fdf567..bc1d35b271f5 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -12,8 +12,11 @@
 #include <linux/bpf_verifier.h>
 #include <linux/lsm_hooks.h>
 
+struct cgroup;
+struct cgroup_namespace;
 struct ns_common;
 struct nsset;
+struct super_block;
 
 #ifdef CONFIG_BPF_LSM
 
@@ -55,6 +58,9 @@ int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
 int bpf_lsm_namespace_alloc(struct ns_common *ns);
 void bpf_lsm_namespace_free(struct ns_common *ns);
 int bpf_lsm_namespace_install(struct nsset *nsset, struct ns_common *ns);
+int bpf_lsm_cgroup_attach(struct task_struct *task, struct cgroup *src_cgrp,
+			   struct cgroup *dst_cgrp, struct super_block *sb,
+			   bool threadgroup, struct cgroup_namespace *ns);
 
 int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
 				const struct bpf_dynptr *value_p, int flags);
@@ -125,6 +131,15 @@ static inline int bpf_lsm_namespace_install(struct nsset *nsset,
 {
 	return 0;
 }
+static inline int bpf_lsm_cgroup_attach(struct task_struct *task,
+					 struct cgroup *src_cgrp,
+					 struct cgroup *dst_cgrp,
+					 struct super_block *sb,
+					 bool threadgroup,
+					 struct cgroup_namespace *ns)
+{
+	return 0;
+}
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index f6378db46220..1da5585082fa 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -47,6 +47,16 @@ __weak noinline int bpf_lsm_namespace_install(struct nsset *nsset,
 	return 0;
 }
 
+__weak noinline int bpf_lsm_cgroup_attach(struct task_struct *task,
+					   struct cgroup *src_cgrp,
+					   struct cgroup *dst_cgrp,
+					   struct super_block *sb,
+					   bool threadgroup,
+					   struct cgroup_namespace *ns)
+{
+	return 0;
+}
+
 __bpf_hook_end();
 
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
@@ -56,6 +66,7 @@ BTF_SET_START(bpf_lsm_hooks)
 BTF_ID(func, bpf_lsm_namespace_alloc)
 BTF_ID(func, bpf_lsm_namespace_free)
 BTF_ID(func, bpf_lsm_namespace_install)
+BTF_ID(func, bpf_lsm_cgroup_attach)
 BTF_SET_END(bpf_lsm_hooks)
 
 BTF_SET_START(bpf_lsm_disabled_hooks)
@@ -407,6 +418,7 @@ BTF_ID(func, bpf_lsm_task_to_inode)
 BTF_ID(func, bpf_lsm_userns_create)
 BTF_ID(func, bpf_lsm_namespace_alloc)
 BTF_ID(func, bpf_lsm_namespace_install)
+BTF_ID(func, bpf_lsm_cgroup_attach)
 BTF_SET_END(sleepable_lsm_hooks)
 
 BTF_SET_START(untrusted_lsm_hooks)
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 8af4351536cf..16535349b22f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -28,6 +28,7 @@
 #include "cgroup-internal.h"
 
 #include <linux/bpf-cgroup.h>
+#include <linux/bpf_lsm.h>
 #include <linux/cred.h>
 #include <linux/errno.h>
 #include <linux/init_task.h>
@@ -5334,7 +5335,8 @@ static int cgroup_procs_write_permission(struct cgroup *src_cgrp,
 	return 0;
 }
 
-static int cgroup_attach_permissions(struct cgroup *src_cgrp,
+static int cgroup_attach_permissions(struct task_struct *task,
+				     struct cgroup *src_cgrp,
 				     struct cgroup *dst_cgrp,
 				     struct super_block *sb, bool threadgroup,
 				     struct cgroup_namespace *ns)
@@ -5350,9 +5352,9 @@ static int cgroup_attach_permissions(struct cgroup *src_cgrp,
 		return ret;
 
 	if (!threadgroup && (src_cgrp->dom_cgrp != dst_cgrp->dom_cgrp))
-		ret = -EOPNOTSUPP;
+		return -EOPNOTSUPP;
 
-	return ret;
+	return bpf_lsm_cgroup_attach(task, src_cgrp, dst_cgrp, sb, threadgroup, ns);
 }
 
 static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
@@ -5384,7 +5386,7 @@ static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
 	 * inherited fd attacks.
 	 */
 	scoped_with_creds(of->file->f_cred)
-		ret = cgroup_attach_permissions(src_cgrp, dst_cgrp,
+		ret = cgroup_attach_permissions(task, src_cgrp, dst_cgrp,
 						of->file->f_path.dentry->d_sb,
 						threadgroup, ctx->ns);
 	if (ret)
@@ -6669,6 +6671,7 @@ static struct cgroup *cgroup_get_from_file(struct file *f)
 
 /**
  * cgroup_css_set_fork - find or create a css_set for a child process
+ * @task: the task to be attached
  * @kargs: the arguments passed to create the child process
  *
  * This functions finds or creates a new css_set which the child
@@ -6683,7 +6686,8 @@ static struct cgroup *cgroup_get_from_file(struct file *f)
  * before grabbing cgroup_threadgroup_rwsem and will hold a reference
  * to the target cgroup.
  */
-static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
+static int cgroup_css_set_fork(struct task_struct *task,
+			       struct kernel_clone_args *kargs)
 	__acquires(&cgroup_mutex) __acquires(&cgroup_threadgroup_rwsem)
 {
 	int ret;
@@ -6752,7 +6756,7 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	 * cgroup.procs of the cgroup indicated by @dfd_cgroup. This allows us
 	 * to always use the caller's credentials.
 	 */
-	ret = cgroup_attach_permissions(cset->dfl_cgrp, dst_cgrp, sb,
+	ret = cgroup_attach_permissions(task, cset->dfl_cgrp, dst_cgrp, sb,
 					!(kargs->flags & CLONE_THREAD),
 					current->nsproxy->cgroup_ns);
 	if (ret)
@@ -6824,7 +6828,7 @@ int cgroup_can_fork(struct task_struct *child, struct kernel_clone_args *kargs)
 	struct cgroup_subsys *ss;
 	int i, j, ret;
 
-	ret = cgroup_css_set_fork(kargs);
+	ret = cgroup_css_set_fork(child, kargs);
 	if (ret)
 		return ret;
 

-- 
2.47.3


