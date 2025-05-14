Return-Path: <cgroups+bounces-8175-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8C3AB61B7
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 06:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6753A3A3D76
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 04:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381401E9B16;
	Wed, 14 May 2025 04:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUHnn/X3"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E258A101EE;
	Wed, 14 May 2025 04:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747197974; cv=none; b=UWtDKx9yzcosLsCORstf9oaOGx0eYaaV/6mDe5URArmhl+FxacVj3RxCcJR4dnvn7qJ31Mr3IyvUojVA+hAIAZhDjMb11nRex3qpOcPSGq9U13IOrflgDOecWMXEFknYCn730l+3hte91BgytAeMgMyApiwelowHuuZIIAZuRLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747197974; c=relaxed/simple;
	bh=w19z6GWVSncZnVbjxFphyPXRA2BivxniQSnbDNhu5TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYn3lgMnYBAi1MeTNSirp5zFtoccJficAdiXnaaVqaJ6GPPXNdBwdRNAHOWag2nSFmoSs7/7U6UYvJLXlqqEXbPtfMXbAXl6tsHh3DvSgGYpTcFDGWM9gDoscZ2IqLCMysQ9lLhZnnduRGjyndDazm+8vDyXIzDyePpVii9GWdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUHnn/X3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35ED5C4CEED;
	Wed, 14 May 2025 04:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747197973;
	bh=w19z6GWVSncZnVbjxFphyPXRA2BivxniQSnbDNhu5TI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WUHnn/X3u3Vhp+MR2Fcs7zZCYyUEWA2YeDZVsVaYR/XuL27kCUnFAt1f0c/epLkHY
	 k1yn/kvFdi08hrCLZKxf7K6YVbvfcBLQzrp+d+c8ng4P/uS8ILNbr8xbRNWy31Jx2S
	 OkaJDu4FX2xXJIwsLBzhjLKBG66R8PtoUQeZZjkM4nfT3s9VocmE+2ECEgDinoyKFJ
	 5STM89svBp29BMsZglvI9Q0D9nAtW7AoNVLnI0PN6+4hIJJhGJ+Rzq8GuOzKaSb4z4
	 Tb78KMxiucR2dMj286Rw5E8KeAGpTJkFZqUJI8IkRq9bWKUEgLcbrliMZlPzis+37T
	 E9aTFDXgqprKA==
Date: Wed, 14 May 2025 00:46:12 -0400
From: Tejun Heo <tj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 3/3 cgroup/for-6.16] sched_ext: Convert cgroup BPF support to
 use cgroup_lifetime_notifier
Message-ID: <aCQgFIxz82oxLf8v@mtj.duckdns.org>
References: <aCQfffBvNpW3qMWN@mtj.duckdns.org>
 <aCQfvCuVWOYkv_X5@mtj.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCQfvCuVWOYkv_X5@mtj.duckdns.org>

Replace explicit cgroup_bpf_inherit/offline() calls from cgroup
creation/destruction paths with notification callback registered on
cgroup_lifetime_notifier.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/bpf-cgroup.h |    9 +++++----
 kernel/bpf/cgroup.c        |   38 ++++++++++++++++++++++++++++++++++++--
 kernel/cgroup/cgroup.c     |   20 +++-----------------
 3 files changed, 44 insertions(+), 23 deletions(-)

--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -114,8 +114,7 @@ struct bpf_prog_list {
 	u32 flags;
 };
 
-int cgroup_bpf_inherit(struct cgroup *cgrp);
-void cgroup_bpf_offline(struct cgroup *cgrp);
+void __init cgroup_bpf_lifetime_notifier_init(void);
 
 int __cgroup_bpf_run_filter_skb(struct sock *sk,
 				struct sk_buff *skb,
@@ -431,8 +430,10 @@ const struct bpf_func_proto *
 cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
 #else
 
-static inline int cgroup_bpf_inherit(struct cgroup *cgrp) { return 0; }
-static inline void cgroup_bpf_offline(struct cgroup *cgrp) {}
+static inline void cgroup_bpf_lifetime_notifier_init(void)
+{
+	return;
+}
 
 static inline int cgroup_bpf_prog_attach(const union bpf_attr *attr,
 					 enum bpf_prog_type ptype,
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -41,6 +41,19 @@ static int __init cgroup_bpf_wq_init(voi
 }
 core_initcall(cgroup_bpf_wq_init);
 
+static int cgroup_bpf_lifetime_notify(struct notifier_block *nb,
+				      unsigned long action, void *data);
+
+static struct notifier_block cgroup_bpf_lifetime_nb = {
+	.notifier_call = cgroup_bpf_lifetime_notify,
+};
+
+void __init cgroup_bpf_lifetime_notifier_init(void)
+{
+	BUG_ON(blocking_notifier_chain_register(&cgroup_lifetime_notifier,
+						&cgroup_bpf_lifetime_nb));
+}
+
 /* __always_inline is necessary to prevent indirect call through run_prog
  * function pointer.
  */
@@ -206,7 +219,7 @@ bpf_cgroup_atype_find(enum bpf_attach_ty
 }
 #endif /* CONFIG_BPF_LSM */
 
-void cgroup_bpf_offline(struct cgroup *cgrp)
+static void cgroup_bpf_offline(struct cgroup *cgrp)
 {
 	cgroup_get(cgrp);
 	percpu_ref_kill(&cgrp->bpf.refcnt);
@@ -491,7 +504,7 @@ static void activate_effective_progs(str
  * cgroup_bpf_inherit() - inherit effective programs from parent
  * @cgrp: the cgroup to modify
  */
-int cgroup_bpf_inherit(struct cgroup *cgrp)
+static int cgroup_bpf_inherit(struct cgroup *cgrp)
 {
 /* has to use marco instead of const int, since compiler thinks
  * that array below is variable length
@@ -534,6 +547,27 @@ cleanup:
 	return -ENOMEM;
 }
 
+static int cgroup_bpf_lifetime_notify(struct notifier_block *nb,
+				      unsigned long action, void *data)
+{
+	struct cgroup *cgrp = data;
+	int ret = 0;
+
+	if (cgrp->root != &cgrp_dfl_root)
+		return NOTIFY_OK;
+
+	switch (action) {
+	case CGROUP_LIFETIME_ONLINE:
+		ret = cgroup_bpf_inherit(cgrp);
+		break;
+	case CGROUP_LIFETIME_OFFLINE:
+		cgroup_bpf_offline(cgrp);
+		break;
+	}
+
+	return notifier_from_errno(ret);
+}
+
 static int update_effective_progs(struct cgroup *cgrp,
 				  enum cgroup_bpf_attach_type atype)
 {
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2162,11 +2162,6 @@ int cgroup_setup_root(struct cgroup_root
 	if (ret)
 		goto exit_stats;
 
-	if (root == &cgrp_dfl_root) {
-		ret = cgroup_bpf_inherit(root_cgrp);
-		WARN_ON_ONCE(ret);
-	}
-
 	ret = blocking_notifier_call_chain(&cgroup_lifetime_notifier,
 					   CGROUP_LIFETIME_ONLINE, root_cgrp);
 	WARN_ON_ONCE(notifier_to_errno(ret));
@@ -5759,20 +5754,12 @@ static struct cgroup *cgroup_create(stru
 
 	cgrp->self.serial_nr = css_serial_nr_next++;
 
-	if (cgrp->root == &cgrp_dfl_root) {
-		ret = cgroup_bpf_inherit(cgrp);
-		if (ret)
-			goto out_psi_free;
-	}
-
 	ret = blocking_notifier_call_chain_robust(&cgroup_lifetime_notifier,
 						  CGROUP_LIFETIME_ONLINE,
 						  CGROUP_LIFETIME_OFFLINE, cgrp);
 	ret = notifier_to_errno(ret);
-	if (ret) {
-		cgroup_bpf_offline(cgrp);
+	if (ret)
 		goto out_psi_free;
-	}
 
 	/* allocation complete, commit to creation */
 	spin_lock_irq(&css_set_lock);
@@ -6059,9 +6046,6 @@ static int cgroup_destroy_locked(struct
 
 	cgroup1_check_for_release(parent);
 
-	if (cgrp->root == &cgrp_dfl_root)
-		cgroup_bpf_offline(cgrp);
-
 	ret = blocking_notifier_call_chain(&cgroup_lifetime_notifier,
 					   CGROUP_LIFETIME_OFFLINE, cgrp);
 	WARN_ON_ONCE(notifier_to_errno(ret));
@@ -6215,6 +6199,8 @@ int __init cgroup_init(void)
 	hash_add(css_set_table, &init_css_set.hlist,
 		 css_set_hash(init_css_set.subsys));
 
+	cgroup_bpf_lifetime_notifier_init();
+
 	BUG_ON(cgroup_setup_root(&cgrp_dfl_root, 0));
 
 	cgroup_unlock();

