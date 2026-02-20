Return-Path: <cgroups+bounces-14042-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEbVGyCtl2nO5QIAu9opvQ
	(envelope-from <cgroups+bounces-14042-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 01:38:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC82163E01
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 01:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1EF96300B46B
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6201F09A5;
	Fri, 20 Feb 2026 00:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7SyJJwK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A161EDA32;
	Fri, 20 Feb 2026 00:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771547925; cv=none; b=IVkXw3MejERxrrSTzT2AsFzhTWQpgdbjwl8uO9YnIbmtMTSpN734YqXgjjCU0EOIKrD5wLMqhIM25Y+4/4kJjyU7FkvBdv1PO8BYx/SdCU1olsC2vg43/9+0EDf2nYksqWcbIpFQEeiIvMzAkIzHoOPVPi80BI7kN6FjhyiHi7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771547925; c=relaxed/simple;
	bh=QZ3jVMjUhxTz1y23OlYN9+hzPO/kmADiRKgb9P3oOQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LNmppF4jbCqUK6iqTn9sJqq8uRDwws472pw6MxOa01mdt6eXbxvYfvlj+51rSrkW/CY1dH1zIQMMO1a/u3GUs0Uq0SxIY4SlrfvRQUjAW2b+JPCvboXIEd5g54F7Znxn89SQ9WdoIGchYlUDl00aEtdbE+rHwW4JYF/Ug7MwAok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7SyJJwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683E5C19423;
	Fri, 20 Feb 2026 00:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771547925;
	bh=QZ3jVMjUhxTz1y23OlYN9+hzPO/kmADiRKgb9P3oOQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B7SyJJwKnhRUPaYu+LgUJKyURL0kVZHzL19za6v1KFimR6/wHdl/zeGTDrqPuGGSm
	 3YIedu66KCP/DKORsnKkZOixvK3Dy07zTiiso+A7rvEaHS/omj65GAG6clw3H4Y3qd
	 xoT/AOGesNG2NHOjgvyY5iFy9tVjJnpRlx2RvlsIx47E+RQ/66hIz62MV06BBbZAjC
	 AGY90o1hZ8A4IG8O/xwDZvcvLo4t/7MUHT2wzIUzvGCa9Bbhu8mIPDmd+52IsLfn8+
	 HZjkJ9u87/guHYmnalC6/piU/oNjA7jXzZ2jXwFejB+LWYvt118ghGQT1jRjA4H4tr
	 cZFeoe/jt2bmw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 20 Feb 2026 01:38:29 +0100
Subject: [PATCH 1/4] ns: add bpf hooks
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-work-bpf-namespace-v1-1-866207db7b83@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5458; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QZ3jVMjUhxTz1y23OlYN9+hzPO/kmADiRKgb9P3oOQk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROXyuQd8Nhz52pFZ01n5fa294KYQ9+dOvO2s8yvZoTn
 E6+W7DAsaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiCtkM/2PnN52bJ7wnuMjx
 6L1FW851nlU989525v3c39+Xn7s9V7OKkWFDeJAE9x5nbk/RYI7vvBZ3tZJYGj0ZFix1lN0gwSt
 zgRMA
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
	TAGGED_FROM(0.00)[bounces-14042-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: CCC82163E01
X-Rspamd-Action: no action

Add the three namespace lifecycle hooks and make them available to bpf
lsm program types. This allows bpf to supervise namespace creation. I'm
in the process of adding various "universal truth" bpf programs to
systemd that will make use of this. This e.g., allows to lock in a
program into a given set of namespaces.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/bpf_lsm.h | 21 +++++++++++++++++++++
 kernel/bpf/bpf_lsm.c    | 25 +++++++++++++++++++++++++
 kernel/nscommon.c       |  9 ++++++++-
 kernel/nsproxy.c        |  7 +++++++
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 643809cc78c3..5ae438fdf567 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -12,6 +12,9 @@
 #include <linux/bpf_verifier.h>
 #include <linux/lsm_hooks.h>
 
+struct ns_common;
+struct nsset;
+
 #ifdef CONFIG_BPF_LSM
 
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
@@ -48,6 +51,11 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func)
 
 int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
 			     struct bpf_retval_range *range);
+
+int bpf_lsm_namespace_alloc(struct ns_common *ns);
+void bpf_lsm_namespace_free(struct ns_common *ns);
+int bpf_lsm_namespace_install(struct nsset *nsset, struct ns_common *ns);
+
 int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
 				const struct bpf_dynptr *value_p, int flags);
 int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str);
@@ -104,6 +112,19 @@ static inline bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog)
 {
 	return false;
 }
+
+static inline int bpf_lsm_namespace_alloc(struct ns_common *ns)
+{
+	return 0;
+}
+static inline void bpf_lsm_namespace_free(struct ns_common *ns)
+{
+}
+static inline int bpf_lsm_namespace_install(struct nsset *nsset,
+					    struct ns_common *ns)
+{
+	return 0;
+}
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 0c4a0c8e6f70..f6378db46220 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -30,10 +30,32 @@ __weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK
 
+__bpf_hook_start();
+
+__weak noinline int bpf_lsm_namespace_alloc(struct ns_common *ns)
+{
+	return 0;
+}
+
+__weak noinline void bpf_lsm_namespace_free(struct ns_common *ns)
+{
+}
+
+__weak noinline int bpf_lsm_namespace_install(struct nsset *nsset,
+					  struct ns_common *ns)
+{
+	return 0;
+}
+
+__bpf_hook_end();
+
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
 BTF_SET_START(bpf_lsm_hooks)
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK
+BTF_ID(func, bpf_lsm_namespace_alloc)
+BTF_ID(func, bpf_lsm_namespace_free)
+BTF_ID(func, bpf_lsm_namespace_install)
 BTF_SET_END(bpf_lsm_hooks)
 
 BTF_SET_START(bpf_lsm_disabled_hooks)
@@ -383,6 +405,8 @@ BTF_ID(func, bpf_lsm_task_prctl)
 BTF_ID(func, bpf_lsm_task_setscheduler)
 BTF_ID(func, bpf_lsm_task_to_inode)
 BTF_ID(func, bpf_lsm_userns_create)
+BTF_ID(func, bpf_lsm_namespace_alloc)
+BTF_ID(func, bpf_lsm_namespace_install)
 BTF_SET_END(sleepable_lsm_hooks)
 
 BTF_SET_START(untrusted_lsm_hooks)
@@ -395,6 +419,7 @@ BTF_ID(func, bpf_lsm_sk_alloc_security)
 BTF_ID(func, bpf_lsm_sk_free_security)
 #endif /* CONFIG_SECURITY_NETWORK */
 BTF_ID(func, bpf_lsm_task_free)
+BTF_ID(func, bpf_lsm_namespace_free)
 BTF_SET_END(untrusted_lsm_hooks)
 
 bool bpf_lsm_is_sleepable_hook(u32 btf_id)
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index bdc3c86231d3..c3613cab3d41 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2025 Christian Brauner <brauner@kernel.org> */
 
+#include <linux/bpf_lsm.h>
 #include <linux/ns_common.h>
 #include <linux/nstree.h>
 #include <linux/proc_ns.h>
@@ -77,6 +78,7 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 		ret = proc_alloc_inum(&ns->inum);
 	if (ret)
 		return ret;
+
 	/*
 	 * Tree ref starts at 0. It's incremented when namespace enters
 	 * active use (installed in nsproxy) and decremented when all
@@ -86,11 +88,16 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 		atomic_set(&ns->__ns_ref_active, 1);
 	else
 		atomic_set(&ns->__ns_ref_active, 0);
-	return 0;
+
+	ret = bpf_lsm_namespace_alloc(ns);
+	if (ret && !inum)
+		proc_free_inum(ns->inum);
+	return ret;
 }
 
 void __ns_common_free(struct ns_common *ns)
 {
+	bpf_lsm_namespace_free(ns);
 	proc_free_inum(ns->inum);
 }
 
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 259c4b4f1eeb..5742f9664dbb 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -9,6 +9,7 @@
  *             Pavel Emelianov <xemul@openvz.org>
  */
 
+#include <linux/bpf_lsm.h>
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/nsproxy.h>
@@ -379,6 +380,12 @@ static int prepare_nsset(unsigned flags, struct nsset *nsset)
 
 static inline int validate_ns(struct nsset *nsset, struct ns_common *ns)
 {
+	int ret;
+
+	ret = bpf_lsm_namespace_install(nsset, ns);
+	if (ret)
+		return ret;
+
 	return ns->ops->install(nsset, ns);
 }
 

-- 
2.47.3


