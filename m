Return-Path: <cgroups+bounces-7851-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AC0A9E699
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 05:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7683B6E6D
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 03:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B0019E96A;
	Mon, 28 Apr 2025 03:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Za8NqbMH"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E433215687D
	for <cgroups@vger.kernel.org>; Mon, 28 Apr 2025 03:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745811400; cv=none; b=M00y3xI16nxOGNiBZfGspw13imTDQ5+wYeW9uhtp21mMW6wuQR7mHZ2be6ANTTur9eoVCF/4XQBLAgBjvSqYSbpCUbv1GGDMcmrMWTm6nDL1li1jGxdHYB+OWs0xQlY0Cn25vmui1xxQFGQb/M07wirh5PKJnakYKuoHhwWbqoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745811400; c=relaxed/simple;
	bh=0jxF6XE1cAAhERd7I3gZluVPfQ7SYQN1hU2Tv5Ku2+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmNiwBNC3CkTSzAnfnyseI2I/2FqfDL4+yoDd16NdPDFwPQ8zGnONFEdj5rHzAO0M70cEcj+M4wC3uahW623AyZ2U7mKjDFwOJ9lMz2uyN4iITjoZK5+S2epSs6n35i6aNHim3HEDBy2uVF+2+lppqjjqKT0D1p9XS/8DtzThUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Za8NqbMH; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745811396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yq8ss53Ru7Jhn38FBmHilN70R4el49iAxHid+VDVZdc=;
	b=Za8NqbMHlD/frdFKXQJ5cvdJMNbcCS/DRf5Jb1yVC4ngasstbn9VZgMIgtWblQFur+Y235
	RN3ru9mjapI3Yt9K1ImzzZaqvTSrJu9HtMPrd8jZPA3hcXgk9TZ+vffZlihzedD7x2HEhK
	G7bxkMHe5bocYEvWA6a+Ku/DHw1wj0Q=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>,
	Josh Don <joshdon@google.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH rfc 01/12] mm: introduce a bpf hook for OOM handling
Date: Mon, 28 Apr 2025 03:36:06 +0000
Message-ID: <20250428033617.3797686-2-roman.gushchin@linux.dev>
In-Reply-To: <20250428033617.3797686-1-roman.gushchin@linux.dev>
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce a bpf hook for implementing custom OOM handling policies.

The hook is int bpf_handle_out_of_memory(struct oom_control *oc)
function, which expected to return 1 if it was able to free some
memory and 0 otherwise. In the latter case it's guaranteed that
the in-kernel OOM killer will be invoked. Otherwise the kernel
also checks the bpf_memory_freed field of the oom_control structure,
which is expected to be set by kfuncs suitable for releasing memory.
It's a safety mechanism which prevents a bpf program to claim
forward progress without actually releasing memory.

The hook program is sleepable to enable using iterators, e.g.
cgroup iterators.

The hook is executed just before the kernel victim task selection
algorithm, so all heuristics and sysctls like panic on oom,
sysctl_oom_kill_allocating_task and sysctl_oom_kill_allocating_task
are respected.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/oom.h |  5 ++++
 mm/oom_kill.c       | 68 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index 1e0fc6931ce9..cc14aac9742c 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -51,6 +51,11 @@ struct oom_control {
 
 	/* Used to print the constraint info. */
 	enum oom_constraint constraint;
+
+#ifdef CONFIG_BPF_SYSCALL
+	/* Used by the bpf oom implementation to mark the forward progress */
+	bool bpf_memory_freed;
+#endif
 };
 
 extern struct mutex oom_lock;
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 25923cfec9c6..d00776b63c0a 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -45,6 +45,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/cred.h>
 #include <linux/nmi.h>
+#include <linux/bpf.h>
 
 #include <asm/tlb.h>
 #include "internal.h"
@@ -1100,6 +1101,30 @@ int unregister_oom_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(unregister_oom_notifier);
 
+#ifdef CONFIG_BPF_SYSCALL
+int bpf_handle_out_of_memory(struct oom_control *oc);
+
+/*
+ * Returns true if the bpf oom program returns 1 and some memory was
+ * freed.
+ */
+static bool bpf_handle_oom(struct oom_control *oc)
+{
+	if (WARN_ON_ONCE(oc->chosen))
+		oc->chosen = NULL;
+
+	oc->bpf_memory_freed = false;
+
+	return bpf_handle_out_of_memory(oc) && oc->bpf_memory_freed;
+}
+
+#else
+static inline bool bpf_handle_oom(struct oom_control *oc)
+{
+	return 0;
+}
+#endif
+
 /**
  * out_of_memory - kill the "best" process when we run out of memory
  * @oc: pointer to struct oom_control
@@ -1161,6 +1186,13 @@ bool out_of_memory(struct oom_control *oc)
 		return true;
 	}
 
+	/*
+	 * Let bpf handle the OOM first. If it was able to free up some memory,
+	 * bail out. Otherwise fall back to the kernel OOM killer.
+	 */
+	if (bpf_handle_oom(oc))
+		return true;
+
 	select_bad_process(oc);
 	/* Found nothing?!?! */
 	if (!oc->chosen) {
@@ -1264,3 +1296,39 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	return -ENOSYS;
 #endif /* CONFIG_MMU */
 }
+
+#ifdef CONFIG_BPF_SYSCALL
+
+__bpf_hook_start();
+
+/*
+ * Bpf hook to customize the oom handling policy.
+ */
+__weak noinline int bpf_handle_out_of_memory(struct oom_control *oc)
+{
+	return 0;
+}
+
+__bpf_hook_end();
+
+BTF_KFUNCS_START(bpf_oom_hooks)
+BTF_ID_FLAGS(func, bpf_handle_out_of_memory, KF_SLEEPABLE)
+BTF_KFUNCS_END(bpf_oom_hooks)
+
+static const struct btf_kfunc_id_set bpf_oom_hook_set = {
+	.owner = THIS_MODULE,
+	.set   = &bpf_oom_hooks,
+};
+static int __init bpf_oom_init(void)
+{
+	int err;
+
+	err = register_btf_fmodret_id_set(&bpf_oom_hook_set);
+	if (err)
+		pr_warn("error while registering bpf oom hooks: %d", err);
+
+	return err;
+}
+late_initcall(bpf_oom_init);
+
+#endif
-- 
2.49.0.901.g37484f566f-goog


