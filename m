Return-Path: <cgroups+bounces-13665-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOpRKNYKg2lbhAMAu9opvQ
	(envelope-from <cgroups+bounces-13665-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 10:01:10 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80271E378A
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 10:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7EB32300826A
	for <lists+cgroups@lfdr.de>; Wed,  4 Feb 2026 09:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631DC257423;
	Wed,  4 Feb 2026 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sHwlZ+KI"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54F83A1A3A
	for <cgroups@vger.kernel.org>; Wed,  4 Feb 2026 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770195657; cv=none; b=gQtRDmHjLRp56NvFGap/5/s0E4+PG2+uF+R9fmIO5Umin1NaqoYZS6UhvhgJ/iwJu3D0Oy/feTvtafKXlWMbcDriCwziLNJaL0NuIZ9njsN/DF6ImXyquCUfShOxygaNZBrZL4GvYOgRiRwDl4/dBa3Rk0jewL0TvmNQM3g1R4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770195657; c=relaxed/simple;
	bh=7n/ZWkhhSmX/bM1+idT+9nVo4QT/mYuahLNKLZEZygI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BL0w2B/QDSJpVV5fASgFRgVvqc3uy1ankGT94UiI1W2+rcL597FRm3BJgYuCTST16sawOFdZrhUsp4E9TghJTbPU7MQTY6I2JvUnlghLya0slLbsnzMEmd5YjueF+pmyfDpLTlABGlvJMWzSrFrZuUWWFq5ogjoCBtqVVQk1Zsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sHwlZ+KI; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770195654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02bC3wLGkJMCPZocNUNmDvfJdZ5oYWKuLWlE+zWAVtQ=;
	b=sHwlZ+KIrkjmT8iMhOhU5ry32MfsCMiUe+8X/0XbVzLl3NmcvjOVCJo7BXyaA8G9zd1Qxa
	mk2sRIbzGQZ1ySfLtQZBWSURBKgWkc7RWUP1os3scyETheY1GIhbu+BeYhkOwXGNjTJVql
	I4/yiayOYSOiv3KkllgMOj4lulRQjZ8=
From: Hui Zhu <hui.zhu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	mkoutny@suse.com,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Lance Yang <lance.yang@linux.dev>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC PATCH bpf-next v6 08/12] mm: memcontrol: Add BPF struct_ops for memory controller
Date: Wed,  4 Feb 2026 17:00:04 +0800
Message-ID: <0cee91e9ef9c1fdc125a8b2cef395eb99f8f1683.1770194182.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1770194182.git.zhuhui@kylinos.cn>
References: <cover.1770194182.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13665-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,davemloft.net,huaweicloud.com,vger.kernel.org,kvack.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hui.zhu@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[51];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:dkim,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: 80271E378A
X-Rspamd-Action: no action

From: Hui Zhu <zhuhui@kylinos.cn>

Introduce BPF struct_ops support to the memory controller, enabling
custom and dynamic control over memory pressure. This is achieved
through a new struct_ops type, `memcg_bpf_ops`.

This new interface allows a BPF program to implement hooks that
influence a memory cgroup's behavior. The `memcg_bpf_ops` struct
provides the following hooks:

- `get_high_delay_ms`: Returns a custom throttling delay in
  milliseconds for a cgroup that has breached its `memory.high`
  limit. This is the primary mechanism for BPF-driven throttling.

- `below_low`: Overrides the `memory.low` protection check. If this
  hook returns true, the cgroup is considered to be protected by its
  `memory.low` setting, regardless of its actual usage.

- `below_min`: Similar to `below_low`, this overrides the `memory.min`
  protection check.

- `handle_cgroup_online`/`offline`: Callbacks invoked when a cgroup
  with an attached program comes online or goes offline, allowing for
  state management.

This patch integrates these hooks into the core memory control logic.
The `get_high_delay_ms` value is incorporated into charge paths like
`try_charge_memcg` and the high-limit handler
`__mem_cgroup_handle_over_high`. The `below_low` and `below_min`
hooks are checked within their respective protection functions.

Lifecycle management is handled to ensure BPF programs are correctly
inherited by child cgroups and cleaned up on detachment. SRCU is used
to protect concurrent access to the `memcg->bpf_ops` pointer.

Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 include/linux/memcontrol.h | 117 +++++++++++++++++-
 mm/bpf_memcontrol.c        | 247 ++++++++++++++++++++++++++++++++++++-
 mm/memcontrol.c            |  33 +++--
 3 files changed, 384 insertions(+), 13 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f3b8c71870d8..d91dbb95069b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -23,6 +23,7 @@
 #include <linux/writeback.h>
 #include <linux/page-flags.h>
 #include <linux/shrinker.h>
+#include <linux/srcu.h>
 
 struct mem_cgroup;
 struct obj_cgroup;
@@ -181,6 +182,37 @@ struct obj_cgroup {
 	};
 };
 
+#ifdef CONFIG_BPF_SYSCALL
+/**
+ * struct memcg_bpf_ops - BPF callbacks for memory cgroup operations
+ * @handle_cgroup_online: Called when a cgroup comes online
+ * @handle_cgroup_offline: Called when a cgroup goes offline
+ * @below_low: Override memory.low protection check. If this callback returns
+ *             true, mem_cgroup_below_low() will return true immediately without
+ *             performing the standard comparison. If it returns false, the
+ *             original memory.low threshold comparison will proceed normally.
+ * @below_min: Override memory.min protection check. If this callback returns
+ *             true, mem_cgroup_below_min() will return true immediately without
+ *             performing the standard comparison. If it returns false, the
+ *             original memory.min threshold comparison will proceed normally.
+ * @get_high_delay_ms: Return custom throttle delay in milliseconds
+ *
+ * This structure defines the interface for BPF programs to customize
+ * memory cgroup behavior through struct_ops programs.
+ */
+struct memcg_bpf_ops {
+	void (*handle_cgroup_online)(struct mem_cgroup *memcg);
+
+	void (*handle_cgroup_offline)(struct mem_cgroup *memcg);
+
+	bool (*below_low)(struct mem_cgroup *memcg);
+
+	bool (*below_min)(struct mem_cgroup *memcg);
+
+	unsigned int (*get_high_delay_ms)(struct mem_cgroup *memcg);
+};
+#endif /* CONFIG_BPF_SYSCALL */
+
 /*
  * The memory controller data structure. The memory controller controls both
  * page cache and RSS per cgroup. We would eventually like to provide
@@ -321,6 +353,10 @@ struct mem_cgroup {
 	spinlock_t event_list_lock;
 #endif /* CONFIG_MEMCG_V1 */
 
+#ifdef CONFIG_BPF_SYSCALL
+	struct memcg_bpf_ops *bpf_ops;
+#endif
+
 	struct mem_cgroup_per_node *nodeinfo[];
 };
 
@@ -554,6 +590,76 @@ static inline bool mem_cgroup_disabled(void)
 	return !cgroup_subsys_enabled(memory_cgrp_subsys);
 }
 
+#ifdef CONFIG_BPF_SYSCALL
+
+/* SRCU for protecting concurrent access to memcg->bpf_ops */
+extern struct srcu_struct memcg_bpf_srcu;
+
+/**
+ * BPF_MEMCG_CALL - Safely invoke a BPF memcg callback
+ * @memcg: The memory cgroup
+ * @op: The operation name (struct member)
+ * @default_val: Default return value if no BPF program attached
+ *
+ * This macro safely calls a BPF callback under SRCU protection.
+ *
+ * The first READ_ONCE() serves as a fast-path check to avoid the overhead
+ * of SRCU read lock acquisition when no BPF program is attached. This keeps
+ * the common no-BPF case performance unchanged. The second READ_ONCE() under
+ * SRCU protection ensures we see a consistent view of bpf_ops after acquiring
+ * the lock, protecting against concurrent updates.
+ */
+#define BPF_MEMCG_CALL(memcg, op, default_val) ({		\
+	typeof(default_val) __ret = (default_val);		\
+	struct memcg_bpf_ops *__ops;				\
+	int __idx;						\
+								\
+	if (unlikely(READ_ONCE((memcg)->bpf_ops))) {		\
+		__idx = srcu_read_lock(&memcg_bpf_srcu);	\
+		__ops = READ_ONCE((memcg)->bpf_ops);		\
+		if (__ops && __ops->op)				\
+			__ret = __ops->op(memcg);		\
+		srcu_read_unlock(&memcg_bpf_srcu, __idx);	\
+	}							\
+	__ret;							\
+})
+
+static inline bool bpf_memcg_below_low(struct mem_cgroup *memcg)
+{
+	return BPF_MEMCG_CALL(memcg, below_low, false);
+}
+
+static inline bool bpf_memcg_below_min(struct mem_cgroup *memcg)
+{
+	return BPF_MEMCG_CALL(memcg, below_min, false);
+}
+
+static inline unsigned long bpf_memcg_get_high_delay(struct mem_cgroup *memcg)
+{
+	unsigned int ret;
+
+	ret = BPF_MEMCG_CALL(memcg, get_high_delay_ms, 0U);
+	return msecs_to_jiffies(ret);
+}
+
+#undef BPF_MEMCG_CALL
+
+extern void memcontrol_bpf_online(struct mem_cgroup *memcg);
+extern void memcontrol_bpf_offline(struct mem_cgroup *memcg);
+
+#else /* CONFIG_BPF_SYSCALL */
+
+static inline unsigned long
+bpf_memcg_get_high_delay(struct mem_cgroup *memcg) { return 0; }
+static inline bool
+bpf_memcg_below_low(struct mem_cgroup *memcg) { return false; }
+static inline bool
+bpf_memcg_below_min(struct mem_cgroup *memcg) { return false; }
+static inline void memcontrol_bpf_online(struct mem_cgroup *memcg) { }
+static inline void memcontrol_bpf_offline(struct mem_cgroup *memcg) { }
+
+#endif /* CONFIG_BPF_SYSCALL */
+
 static inline void mem_cgroup_protection(struct mem_cgroup *root,
 					 struct mem_cgroup *memcg,
 					 unsigned long *min,
@@ -625,6 +731,9 @@ static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
 	if (mem_cgroup_unprotected(target, memcg))
 		return false;
 
+	if (bpf_memcg_below_low(memcg))
+		return true;
+
 	return READ_ONCE(memcg->memory.elow) >=
 		page_counter_read(&memcg->memory);
 }
@@ -635,6 +744,9 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
 	if (mem_cgroup_unprotected(target, memcg))
 		return false;
 
+	if (bpf_memcg_below_min(memcg))
+		return true;
+
 	return READ_ONCE(memcg->memory.emin) >=
 		page_counter_read(&memcg->memory);
 }
@@ -909,12 +1021,13 @@ unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
 	return READ_ONCE(mz->lru_zone_size[zone_idx][lru]);
 }
 
-void __mem_cgroup_handle_over_high(gfp_t gfp_mask);
+void __mem_cgroup_handle_over_high(gfp_t gfp_mask,
+				   unsigned long bpf_high_delay);
 
 static inline void mem_cgroup_handle_over_high(gfp_t gfp_mask)
 {
 	if (unlikely(current->memcg_nr_pages_over_high))
-		__mem_cgroup_handle_over_high(gfp_mask);
+		__mem_cgroup_handle_over_high(gfp_mask, 0);
 }
 
 unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg);
diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
index 716df49d7647..72b720400628 100644
--- a/mm/bpf_memcontrol.c
+++ b/mm/bpf_memcontrol.c
@@ -8,6 +8,9 @@
 #include <linux/memcontrol.h>
 #include <linux/bpf.h>
 
+/* Protects memcg->bpf_ops pointer for read and write. */
+DEFINE_SRCU(memcg_bpf_srcu);
+
 __bpf_kfunc_start_defs();
 
 /**
@@ -179,15 +182,255 @@ static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set = {
 	.set            = &bpf_memcontrol_kfuncs,
 };
 
+/**
+ * memcontrol_bpf_online - Inherit BPF programs for a new online cgroup.
+ * @memcg: The memory cgroup that is coming online.
+ *
+ * When a new memcg is brought online, it inherits the BPF programs
+ * attached to its parent. This ensures consistent BPF-based memory
+ * control policies throughout the cgroup hierarchy.
+ *
+ * After inheriting, if the BPF program has an online handler, it is
+ * invoked for the new memcg.
+ */
+void memcontrol_bpf_online(struct mem_cgroup *memcg)
+{
+	struct memcg_bpf_ops *ops;
+	struct mem_cgroup *parent_memcg;
+
+	/* The root cgroup does not inherit from a parent. */
+	if (mem_cgroup_is_root(memcg))
+		return;
+
+	/*
+	 * Because only functions bpf_memcg_ops_reg and bpf_memcg_ops_unreg
+	 * write to memcg->bpf_ops under the protection of cgroup_mutex,
+	 * ensuring that cgroup_mutex is already locked here allows safe
+	 * reading and writing of memcg->bpf_ops without needing to acquire
+	 * a lock on memcg_bpf_srcu.
+	 */
+	lockdep_assert_held(&cgroup_mutex);
+
+	parent_memcg = parent_mem_cgroup(memcg);
+
+	/* Inherit the BPF program from the parent cgroup. */
+	ops = READ_ONCE(parent_memcg->bpf_ops);
+	if (!ops)
+		return;
+	WRITE_ONCE(memcg->bpf_ops, ops);
+
+	/*
+	 * If the BPF program implements it, call the online handler to
+	 * allow the program to perform setup tasks for the new cgroup.
+	 */
+	if (ops->handle_cgroup_online)
+		ops->handle_cgroup_online(memcg);
+}
+
+/**
+ * memcontrol_bpf_offline - Run BPF cleanup for an offline cgroup.
+ * @memcg: The memory cgroup that is going offline.
+ *
+ * If a BPF program is attached and implements an offline handler,
+ * it is invoked to perform cleanup tasks before the memcg goes
+ * completely offline.
+ */
+void memcontrol_bpf_offline(struct mem_cgroup *memcg)
+{
+	struct memcg_bpf_ops *ops;
+
+	/* Same with function memcontrol_bpf_online. */
+	lockdep_assert_held(&cgroup_mutex);
+
+	ops = READ_ONCE(memcg->bpf_ops);
+	if (!ops || !ops->handle_cgroup_offline)
+		return;
+
+	ops->handle_cgroup_offline(memcg);
+}
+
+static int memcg_ops_btf_struct_access(struct bpf_verifier_log *log,
+					const struct bpf_reg_state *reg,
+					int off, int size)
+{
+	return -EACCES;
+}
+
+static bool memcg_ops_is_valid_access(int off, int size, enum bpf_access_type type,
+	const struct bpf_prog *prog,
+	struct bpf_insn_access_aux *info)
+{
+	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
+}
+
+const struct bpf_verifier_ops bpf_memcg_verifier_ops = {
+	.get_func_proto = bpf_base_func_proto,
+	.btf_struct_access = memcg_ops_btf_struct_access,
+	.is_valid_access = memcg_ops_is_valid_access,
+};
+
+static void cfi_handle_cgroup_online(struct mem_cgroup *memcg)
+{
+}
+
+static void cfi_handle_cgroup_offline(struct mem_cgroup *memcg)
+{
+}
+
+static bool cfi_below_low(struct mem_cgroup *memcg)
+{
+	return false;
+}
+
+static bool cfi_below_min(struct mem_cgroup *memcg)
+{
+	return false;
+}
+
+static unsigned int cfi_get_high_delay_ms(struct mem_cgroup *memcg)
+{
+	return 0;
+}
+
+static struct memcg_bpf_ops cfi_bpf_memcg_ops = {
+	.handle_cgroup_online = cfi_handle_cgroup_online,
+	.handle_cgroup_offline = cfi_handle_cgroup_offline,
+	.below_low = cfi_below_low,
+	.below_min = cfi_below_min,
+	.get_high_delay_ms = cfi_get_high_delay_ms,
+};
+
+static int bpf_memcg_ops_init(struct btf *btf)
+{
+	return 0;
+}
+
+static int bpf_memcg_ops_check_member(const struct btf_type *t,
+				const struct btf_member *member,
+				const struct bpf_prog *prog)
+{
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+
+	switch (moff) {
+	case offsetof(struct memcg_bpf_ops, handle_cgroup_online):
+	case offsetof(struct memcg_bpf_ops, handle_cgroup_offline):
+	case offsetof(struct memcg_bpf_ops, below_low):
+	case offsetof(struct memcg_bpf_ops, below_min):
+	case offsetof(struct memcg_bpf_ops, get_high_delay_ms):
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (prog->sleepable)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int bpf_memcg_ops_init_member(const struct btf_type *t,
+				const struct btf_member *member,
+				void *kdata, const void *udata)
+{
+	return 0;
+}
+
+/**
+ * clean_memcg_bpf_ops - Clear BPF ops from a memory cgroup hierarchy
+ * @memcg: Root memory cgroup to start from
+ * @ops: The specific BPF ops to remove
+ *
+ * Walks the cgroup hierarchy and clears bpf_ops for any cgroup that
+ * matches @ops.
+ */
+static void clean_memcg_bpf_ops(struct mem_cgroup *memcg,
+				struct memcg_bpf_ops *ops)
+{
+	struct mem_cgroup *iter = NULL;
+
+	while ((iter = mem_cgroup_iter(memcg, iter, NULL))) {
+		if (READ_ONCE(iter->bpf_ops) == ops)
+			WRITE_ONCE(iter->bpf_ops, NULL);
+	}
+}
+
+static int bpf_memcg_ops_reg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_struct_ops_link *ops_link
+		= container_of(link, struct bpf_struct_ops_link, link);
+	struct memcg_bpf_ops *ops = kdata;
+	struct mem_cgroup *memcg, *iter = NULL;
+	int err = 0;
+
+	memcg = mem_cgroup_get_from_ino(ops_link->cgroup_id);
+	if (IS_ERR(memcg))
+		return PTR_ERR(memcg);
+
+	cgroup_lock();
+	while ((iter = mem_cgroup_iter(memcg, iter, NULL))) {
+		if (READ_ONCE(iter->bpf_ops)) {
+			mem_cgroup_iter_break(memcg, iter);
+			err = -EBUSY;
+			break;
+		}
+		WRITE_ONCE(iter->bpf_ops, ops);
+	}
+	if (err)
+		clean_memcg_bpf_ops(memcg, ops);
+	cgroup_unlock();
+
+	mem_cgroup_put(memcg);
+	return err;
+}
+
+/* Unregister the struct ops instance */
+static void bpf_memcg_ops_unreg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_struct_ops_link *ops_link
+		= container_of(link, struct bpf_struct_ops_link, link);
+	struct memcg_bpf_ops *ops = kdata;
+	struct mem_cgroup *memcg;
+
+	memcg = mem_cgroup_get_from_ino(ops_link->cgroup_id);
+	if (IS_ERR_OR_NULL(memcg))
+		goto out;
+
+	cgroup_lock();
+	clean_memcg_bpf_ops(memcg, ops);
+	cgroup_unlock();
+
+	mem_cgroup_put(memcg);
+
+out:
+	synchronize_srcu(&memcg_bpf_srcu);
+}
+
+static struct bpf_struct_ops bpf_memcg_bpf_ops = {
+	.verifier_ops = &bpf_memcg_verifier_ops,
+	.init = bpf_memcg_ops_init,
+	.check_member = bpf_memcg_ops_check_member,
+	.init_member = bpf_memcg_ops_init_member,
+	.reg = bpf_memcg_ops_reg,
+	.unreg = bpf_memcg_ops_unreg,
+	.name = "memcg_bpf_ops",
+	.owner = THIS_MODULE,
+	.cfi_stubs = &cfi_bpf_memcg_ops,
+};
+
 static int __init bpf_memcontrol_init(void)
 {
-	int err;
+	int err, err2;
 
 	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
 					&bpf_memcontrol_kfunc_set);
 	if (err)
 		pr_warn("error while registering bpf memcontrol kfuncs: %d", err);
 
-	return err;
+	err2 = register_bpf_struct_ops(&bpf_memcg_bpf_ops, memcg_bpf_ops);
+	if (err2)
+		pr_warn("error while registering memcontrol bpf ops: %d\n",
+			err2);
+
+	return err ? err : err2;
 }
 late_initcall(bpf_memcontrol_init);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1f74fce27677..3f358d9bc412 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2252,7 +2252,8 @@ static unsigned long calculate_high_delay(struct mem_cgroup *memcg,
  * try_charge() (context permitting), as well as from the userland
  * return path where reclaim is always able to block.
  */
-void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
+void
+__mem_cgroup_handle_over_high(gfp_t gfp_mask, unsigned long bpf_high_delay)
 {
 	unsigned long penalty_jiffies;
 	unsigned long pflags;
@@ -2294,11 +2295,15 @@ void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
 	 * memory.high is breached and reclaim is unable to keep up. Throttle
 	 * allocators proactively to slow down excessive growth.
 	 */
-	penalty_jiffies = calculate_high_delay(memcg, nr_pages,
-					       mem_find_max_overage(memcg));
+	if (nr_pages) {
+		penalty_jiffies = calculate_high_delay(
+			memcg, nr_pages, mem_find_max_overage(memcg));
 
-	penalty_jiffies += calculate_high_delay(memcg, nr_pages,
-						swap_find_max_overage(memcg));
+		penalty_jiffies += calculate_high_delay(
+			memcg, nr_pages, swap_find_max_overage(memcg));
+	} else
+		penalty_jiffies = 0;
+	penalty_jiffies = max(penalty_jiffies, bpf_high_delay);
 
 	/*
 	 * Clamp the max delay per usermode return so as to still keep the
@@ -2356,6 +2361,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	bool raised_max_event = false;
 	unsigned long pflags;
 	bool allow_spinning = gfpflags_allow_spinning(gfp_mask);
+	struct mem_cgroup *orig_memcg;
 
 retry:
 	if (consume_stock(memcg, nr_pages))
@@ -2481,6 +2487,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (batch > nr_pages)
 		refill_stock(memcg, batch - nr_pages);
 
+	orig_memcg = memcg;
 	/*
 	 * If the hierarchy is above the normal consumption range, schedule
 	 * reclaim on returning to userland.  We can perform reclaim here
@@ -2530,10 +2537,15 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * kernel. If this is successful, the return path will see it
 	 * when it rechecks the overage and simply bail out.
 	 */
-	if (current->memcg_nr_pages_over_high > MEMCG_CHARGE_BATCH &&
-	    !(current->flags & PF_MEMALLOC) &&
-	    gfpflags_allow_blocking(gfp_mask))
-		__mem_cgroup_handle_over_high(gfp_mask);
+	if (!(current->flags & PF_MEMALLOC) &&
+	    gfpflags_allow_blocking(gfp_mask)) {
+		unsigned long bpf_high_delay;
+
+		bpf_high_delay = bpf_memcg_get_high_delay(orig_memcg);
+		if (bpf_high_delay ||
+		    current->memcg_nr_pages_over_high > MEMCG_CHARGE_BATCH)
+			__mem_cgroup_handle_over_high(gfp_mask, bpf_high_delay);
+	}
 	return 0;
 }
 
@@ -3906,6 +3918,8 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	 */
 	xa_store(&mem_cgroup_ids, memcg->id.id, memcg, GFP_KERNEL);
 
+	memcontrol_bpf_online(memcg);
+
 	return 0;
 offline_kmem:
 	memcg_offline_kmem(memcg);
@@ -3925,6 +3939,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 
 	zswap_memcg_offline_cleanup(memcg);
 
+	memcontrol_bpf_offline(memcg);
 	memcg_offline_kmem(memcg);
 	reparent_deferred_split_queue(memcg);
 	reparent_shrinker_deferred(memcg);
-- 
2.43.0


