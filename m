Return-Path: <cgroups+bounces-16276-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGkVH+4GFWokSQcAu9opvQ
	(envelope-from <cgroups+bounces-16276-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 04:35:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9E65CFF72
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 04:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51C883060339
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 02:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2992F531F;
	Tue, 26 May 2026 02:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ooNt4/C7"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FF8309DB1
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 02:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779762543; cv=none; b=CkCov5w2ex2V2odKO+vPAj8TG29LraufnmtG7o7B7dkHZGaoRjVJmKAFq/8WXqp/UhYbnHSbltdg1p4MfhwQOk1uA+WefARry3AVRzTjW78Zk8BayQFPAJ8fDWprlqTbMXV+u0avxXw44CEHwm6oVIPvweoAyZdPpBT/dXyc4K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779762543; c=relaxed/simple;
	bh=Jf+YLOQx08po9vWNDiKcTwJR5Yc7FK1PYhDSF/N9q9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXrduf1bjv7WlihBlV5Y5cAuUupVnwit/B5csOPu1G56j0e/dAJqVDBOmR6MYseeJvW+RJypdw7u54B72nLTJZ1VlhNUw9pEYY/4LC3A48q6abjT+wSE2fC83yBEV62Dkh+daJUWMFhxRFl42SUjgcYmBqFpghnYpDAyAMt5iBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ooNt4/C7; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779762535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KczRhSioI0pWQzSBajeSyCSXDleWNCaV061zhAknM4U=;
	b=ooNt4/C7NQby/ceJxAVAqpuHhgObK8J1Y5g0K097oPrXuS/JoSwJdo1r5S75Bv1/0qxamv
	s0trwT96jlB56rB7j/KQAxUnEhvwdrD88dD/sGXsT0Lz2QZ6rB0poQ0nnv+thPr5vZI50W
	j+Nzz7JR2M03wk+E6p2K7DjMxkpJIS4=
From: Hui Zhu <hui.zhu@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	KP Singh <kpsingh@kernel.org>,
	Tao Chen <chen.dylane@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Tobias Klauser <tklauser@distanz.ch>,
	Eyal Birger <eyal.birger@gmail.com>,
	Rong Tao <rongtao@cestc.cn>,
	Hao Luo <haoluo@google.com>,
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
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Lance Yang <lance.yang@linux.dev>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: geliang@kernel.org,
	baohua@kernel.org,
	Hui Zhu <zhuhui@kylinos.cn>
Subject: [RFC PATCH bpf-next v7 11/11] samples/bpf: Add memcg priority control and async reclaim example
Date: Tue, 26 May 2026 10:27:56 +0800
Message-ID: <39784d6dba757f4fb82134192419094ce42c5af5.1779760876.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1779760876.git.zhuhui@kylinos.cn>
References: <cover.1779760876.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16276-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,cmpxchg.org,linux-foundation.org,davemloft.net,fomichev.me,meta.com,distanz.ch,cestc.cn,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,huaweicloud.com,vger.kernel.org,kvack.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hui.zhu@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[59];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.967];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,kylinos.cn:email,linux.dev:dkim]
X-Rspamd-Queue-Id: 5F9E65CFF72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hui Zhu <zhuhui@kylinos.cn>

Add a sample program demonstrating two complementary use cases for the
`memcg_bpf_ops` feature: priority-based memory throttling and
workqueue-driven asynchronous page reclaim.

The sample consists of a BPF program and a userspace loader:

1. memcg.bpf.c: A BPF program with the following capabilities:
   - Monitors PGFAULT events on a high-priority cgroup via a tracepoint.
     When the per-second PGFAULT sum exceeds a configurable threshold,
     a trigger timestamp is recorded.
   - Priority throttling: uses the `below_low` / `below_min` hooks on
     the high-priority cgroup and the `memcg_charged` hook on the
     low-priority cgroup to apply a configurable delay (over_high_ms),
     protecting the high-priority workload.
   - Async reclaim: uses the `memcg_charged` / `memcg_uncharged` hooks
     together with a BPF workqueue to trigger background page reclaim
     on the low-priority cgroup when its memory usage exceeds a
     configurable byte threshold (async_trigger_bytes), without
     blocking the charging context.
   - Six struct_ops variants are exported to allow userspace to attach
     only the hooks needed for the chosen feature combination:
     high_mcg_ops, high_mcg_ops_below_low, high_mcg_ops_below_min,
     low_mcg_ops (combined), low_mcg_ops_high_delay, low_mcg_ops_async.
   - A `prog_init` syscall program initialises the BPF workqueue and
     copies the configuration from userspace before struct_ops are
     attached.

2. memcg.c: A userspace loader that parses command-line arguments,
   resolves cgroup IDs from filesystem inodes, loads the BPF skeleton,
   calls prog_init via bpf_prog_test_run_opts(), and selects and
   attaches the appropriate struct_ops map for the requested feature
   combination. It supports BPF_F_ALLOW_OVERRIDE for stackable policies.

Users can run workloads of different priorities in two cgroups and
observe the low-priority workload being throttled or proactively
reclaimed to protect the high-priority one.

Example usage:
  # Priority throttling only:
  # ./memcg --low_path /sys/fs/cgroup/low \
  #         --high_path /sys/fs/cgroup/high \
  #         --threshold 1000 --over_high_ms 500 --use_below_low

  # Async reclaim only:
  # ./memcg --low_path /sys/fs/cgroup/low \
  #         --threshold 1000 --async_trigger_bytes 33554432

  # Both features combined:
  # ./memcg --low_path /sys/fs/cgroup/low \
  #         --high_path /sys/fs/cgroup/high \
  #         --threshold 1000 --over_high_ms 500 \
  #         --async_trigger_bytes 33554432

Signed-off-by: Barry Song <baohua@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 MAINTAINERS             |   2 +
 samples/bpf/.gitignore  |   1 +
 samples/bpf/Makefile    |   8 +-
 samples/bpf/memcg.bpf.c | 380 +++++++++++++++++++++++++++++++++++++
 samples/bpf/memcg.c     | 411 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 801 insertions(+), 1 deletion(-)
 create mode 100644 samples/bpf/memcg.bpf.c
 create mode 100644 samples/bpf/memcg.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b2e64ef8c60c..a3f737a506b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6566,6 +6566,8 @@ F:	mm/memcontrol-v1.c
 F:	mm/memcontrol-v1.h
 F:	mm/page_counter.c
 F:	mm/swap_cgroup.c
+F:	samples/bpf/memcg.bpf.c
+F:	samples/bpf/memcg.c
 F:	samples/cgroup/*
 F:	tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
 F:	tools/testing/selftests/bpf/prog_tests/memcg_ops.c
diff --git a/samples/bpf/.gitignore b/samples/bpf/.gitignore
index 0002cd359fb1..0de6569cdefd 100644
--- a/samples/bpf/.gitignore
+++ b/samples/bpf/.gitignore
@@ -49,3 +49,4 @@ iperf.*
 /vmlinux.h
 /bpftool/
 /libbpf/
+memcg
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 95a4fa1f1e44..b00698bdc53b 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -37,6 +37,7 @@ tprogs-y += xdp_fwd
 tprogs-y += task_fd_query
 tprogs-y += ibumad
 tprogs-y += hbm
+tprogs-y += memcg
 
 # Libbpf dependencies
 LIBBPF_SRC = $(TOOLS_PATH)/lib/bpf
@@ -122,6 +123,7 @@ always-y += task_fd_query_kern.o
 always-y += ibumad_kern.o
 always-y += hbm_out_kern.o
 always-y += hbm_edt_kern.o
+always-y += memcg.bpf.o
 
 COMMON_CFLAGS = $(TPROGS_USER_CFLAGS)
 TPROGS_LDFLAGS = $(TPROGS_USER_LDFLAGS)
@@ -289,6 +291,8 @@ $(obj)/hbm_out_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
 $(obj)/hbm.o: $(src)/hbm.h
 $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
 
+memcg: $(obj)/memcg.skel.h
+
 # Override includes for xdp_sample_user.o because $(srctree)/usr/include in
 # TPROGS_CFLAGS causes conflicts
 XDP_SAMPLE_CFLAGS += -Wall -O2 \
@@ -347,11 +351,13 @@ $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h $(src)/x
 		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
 		-c $(filter %.bpf.c,$^) -o $@
 
-LINKED_SKELS := xdp_router_ipv4.skel.h
+LINKED_SKELS := xdp_router_ipv4.skel.h memcg.skel.h
 clean-files += $(LINKED_SKELS)
 
 xdp_router_ipv4.skel.h-deps := xdp_router_ipv4.bpf.o xdp_sample.bpf.o
 
+memcg.skel.h-deps := memcg.bpf.o
+
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
 
 BPF_SRCS_LINKED := $(notdir $(wildcard $(src)/*.bpf.c))
diff --git a/samples/bpf/memcg.bpf.c b/samples/bpf/memcg.bpf.c
new file mode 100644
index 000000000000..0995284794ac
--- /dev/null
+++ b/samples/bpf/memcg.bpf.c
@@ -0,0 +1,380 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define ONE_SECOND_NS		1000000000
+#define ONE_MB_PAGE_COUNT 256
+
+/* GFP flags needed by bpf_try_to_free_mem_cgroup_pages() */
+#define BIT(nr)			(1UL << (nr))
+#define ___GFP_IO		BIT(___GFP_IO_BIT)
+#define ___GFP_FS		BIT(___GFP_FS_BIT)
+#define ___GFP_DIRECT_RECLAIM	BIT(___GFP_DIRECT_RECLAIM_BIT)
+#define ___GFP_KSWAPD_RECLAIM	BIT(___GFP_KSWAPD_RECLAIM_BIT)
+#define __GFP_IO		((gfp_t)___GFP_IO)
+#define __GFP_FS		((gfp_t)___GFP_FS)
+#define __GFP_DIRECT_RECLAIM	((gfp_t)___GFP_DIRECT_RECLAIM)
+#define __GFP_KSWAPD_RECLAIM	((gfp_t)___GFP_KSWAPD_RECLAIM)
+#define __GFP_RECLAIM ((gfp_t)(___GFP_DIRECT_RECLAIM|___GFP_KSWAPD_RECLAIM))
+#define GFP_KERNEL		(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
+
+#define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
+#define MEMCG_RECLAIM_PROACTIVE (1 << 2)
+
+#define ASYNC_FREE_BATCH	32
+#define ASYNC_FREE_LOOP_MAX	16
+
+#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
+#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) = (val))
+
+struct local_config {
+	u64		threshold;
+	u64		high_cgroup_id;
+	u64		low_cgroup_id;
+	bool		use_below_low;
+	bool		use_below_min;
+	unsigned int	over_high_ms;
+	u64		async_trigger_bytes;
+} local_config;
+
+struct AggregationData {
+	u64 sum;
+	u64 window_start_ts;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, struct AggregationData);
+} aggregation_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, u64);
+} trigger_ts_map SEC(".maps");
+
+struct wq_elem {
+	struct bpf_wq work;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct wq_elem);
+} wq_map SEC(".maps");
+
+static s64 allocated;
+static s64 old_allocated;
+/*
+ * async_free_run: 0 = idle, 1 = workqueue item is queued/running.
+ * Acts as a one-shot guard: only one reclaim task is in-flight at
+ * a time.  Cleared by async_free() once reclaim is complete and
+ * re-armed by __memcg_charged_impl() on the next trigger.
+ */
+static u64 async_free_run;
+
+/*
+ * wq_initialized: flipped from 0 -> 1 by prog_init() to make init
+ * idempotent if prog_init() is called more than once.
+ */
+static u64 wq_initialized;
+
+struct cgroup_memcg {
+	struct cgroup	 *cgrp;
+	struct mem_cgroup *memcg;
+};
+
+static int get_cgroup_memcg_from_id(u64 cgroup_id, struct cgroup_memcg *cm)
+{
+	cm->cgrp = bpf_cgroup_from_id(cgroup_id);
+	if (!cm->cgrp)
+		return -1;
+
+	cm->memcg = bpf_get_mem_cgroup(&cm->cgrp->self);
+	if (!cm->memcg) {
+		bpf_cgroup_release(cm->cgrp);
+		return -1;
+	}
+	return 0;
+}
+
+static void put_cgroup_memcg(struct cgroup_memcg *cm)
+{
+	bpf_put_mem_cgroup(cm->memcg);
+	bpf_cgroup_release(cm->cgrp);
+}
+
+static int async_free(void *map, int *key, void *value)
+{
+	struct cgroup_memcg cm;
+	bool started_wq = false;
+	int i;
+
+	if (get_cgroup_memcg_from_id(local_config.low_cgroup_id, &cm) != 0)
+		return 0;
+
+	for (i = 0; i < ASYNC_FREE_LOOP_MAX; i++) {
+		if (bpf_try_to_free_mem_cgroup_pages(cm.memcg, ASYNC_FREE_BATCH,
+						     GFP_KERNEL,
+						     MEMCG_RECLAIM_MAY_SWAP,
+						     -1) <= 0)
+			break;
+
+		if (bpf_mem_cgroup_usage(cm.memcg) <
+		    local_config.async_trigger_bytes)
+			break;
+	}
+
+	if (i == ASYNC_FREE_LOOP_MAX) {
+		__u32 k = 0;
+		struct wq_elem *elem = bpf_map_lookup_elem(&wq_map, &k);
+
+		if (elem) {
+			bpf_wq_start(&elem->work, 0);
+			started_wq = true;
+		}
+	}
+
+	put_cgroup_memcg(&cm);
+
+	if (!started_wq)
+		__atomic_exchange_n(&async_free_run, 0, __ATOMIC_RELEASE);
+	return 0;
+}
+
+SEC("syscall")
+int prog_init(struct local_config *ctx)
+{
+	struct wq_elem *elem;
+	__u32 key = 0;
+	u64 expected = 0;
+	int ret = -1;
+
+	/* Guard against double-initialisation */
+	if (!__atomic_compare_exchange_n(&wq_initialized, &expected, 1,
+					 false,
+					 __ATOMIC_ACQ_REL,
+					 __ATOMIC_RELAXED))
+		goto out;
+
+	elem = bpf_map_lookup_elem(&wq_map, &key);
+	if (!elem)
+		goto out;
+	ret = bpf_wq_init(&elem->work, &wq_map, 0);
+	if (ret)
+		goto out;
+	ret = bpf_wq_set_callback(&elem->work, async_free, 0);
+	if (ret)
+		goto out;
+
+	allocated = 0;
+	async_free_run = 0;
+	__builtin_memcpy(&local_config, ctx, sizeof(local_config));
+
+out:
+	return ret;
+}
+
+SEC("tp/memcg/count_memcg_events")
+int handle_count_memcg_events(
+		struct trace_event_raw_memcg_rstat_events *ctx)
+{
+	u32 key = 0;
+	struct AggregationData *data;
+	u64 current_ts;
+
+	if (ctx->id != local_config.high_cgroup_id ||
+	    ctx->item != PGFAULT)
+		goto out;
+
+	data = bpf_map_lookup_elem(&aggregation_map, &key);
+	if (!data)
+		goto out;
+
+	current_ts = bpf_ktime_get_ns();
+
+	if (current_ts - data->window_start_ts < ONE_SECOND_NS) {
+		data->sum += ctx->val;
+	} else {
+		data->window_start_ts = current_ts;
+		data->sum = ctx->val;
+	}
+
+	if (data->sum > local_config.threshold) {
+		bpf_map_update_elem(&trigger_ts_map, &key, &current_ts,
+				    BPF_ANY);
+		data->sum = 0;
+		data->window_start_ts = current_ts;
+	}
+
+out:
+	return 0;
+}
+
+static bool need_threshold(void)
+{
+	u32 key = 0;
+	u64 *trigger_ts;
+	bool ret = false;
+	u64 current_ts;
+
+	trigger_ts = bpf_map_lookup_elem(&trigger_ts_map, &key);
+	if (!trigger_ts || *trigger_ts == 0)
+		goto out;
+
+	current_ts = bpf_ktime_get_ns();
+	if (current_ts - *trigger_ts < ONE_SECOND_NS)
+		ret = true;
+
+out:
+	return ret;
+}
+
+SEC("struct_ops/below_low")
+bool below_low_impl(struct mem_cgroup *memcg, unsigned long elow,
+		    unsigned long usage)
+{
+	return need_threshold();
+}
+
+SEC("struct_ops/below_min")
+bool below_min_impl(struct mem_cgroup *memcg, unsigned long elow,
+		    unsigned long usage)
+{
+	return need_threshold();
+}
+
+static u64 get_usage(void)
+{
+	u64 ret = 0;
+	struct cgroup_memcg cm;
+
+	if (get_cgroup_memcg_from_id(local_config.low_cgroup_id, &cm) != 0)
+		return 0;
+
+	ret = bpf_mem_cgroup_usage(cm.memcg);
+
+	put_cgroup_memcg(&cm);
+
+	return ret;
+}
+
+static __always_inline s64 abs_diff(s64 a, s64 b)
+{
+	return a > b ? a - b : b - a;
+}
+
+static __always_inline unsigned int
+__memcg_charged_impl(struct mem_cgroup *memcg, unsigned int nr_pages)
+{
+	struct wq_elem *elem;
+	__u32 key = 0;
+	u64 expected = 0;
+	s64 cur_allocated;
+	s64 cur_old_allocated;
+
+	__atomic_add_fetch(&allocated, nr_pages, __ATOMIC_RELAXED);
+	cur_allocated = READ_ONCE(allocated);
+	cur_old_allocated = READ_ONCE(old_allocated);
+	if (abs_diff(cur_allocated, cur_old_allocated) < ONE_MB_PAGE_COUNT)
+		goto out;
+	WRITE_ONCE(old_allocated, cur_allocated);
+
+	if (get_usage() < local_config.async_trigger_bytes)
+		goto out;
+
+	if (__atomic_compare_exchange_n(&async_free_run,
+					&expected, 1,
+					false,
+					__ATOMIC_ACQ_REL,
+					__ATOMIC_RELAXED)) {
+		elem = bpf_map_lookup_elem(&wq_map, &key);
+		if (!elem)
+			return 0;
+
+		bpf_wq_start(&elem->work, 0);
+	}
+
+out:
+	return 0;
+}
+
+SEC("struct_ops/memcg_charged")
+unsigned int BPF_PROG(memcg_charged_impl, struct mem_cgroup *memcg,
+		      unsigned int nr_pages)
+{
+	return __memcg_charged_impl(memcg, nr_pages);
+}
+
+SEC("struct_ops/memcg_uncharged")
+void BPF_PROG(memcg_uncharged_impl, struct mem_cgroup *memcg,
+	      unsigned int nr_pages)
+{
+	__atomic_sub_fetch(&allocated, nr_pages, __ATOMIC_RELAXED);
+}
+
+unsigned int
+__get_high_delay_ms_impl(struct mem_cgroup *memcg, unsigned int nr_pages)
+{
+	if (need_threshold())
+		return local_config.over_high_ms;
+
+	return 0;
+}
+
+SEC("struct_ops/memcg_charged")
+unsigned int BPF_PROG(get_high_delay_ms_impl, struct mem_cgroup *memcg,
+		      unsigned int nr_pages)
+{
+	return __get_high_delay_ms_impl(memcg, nr_pages);
+}
+
+SEC("struct_ops/memcg_charged")
+unsigned int BPF_PROG(low_mcg_impl, struct mem_cgroup *memcg,
+		      unsigned int nr_pages)
+{
+	__memcg_charged_impl(memcg, nr_pages);
+
+	return __get_high_delay_ms_impl(memcg, nr_pages);
+}
+
+SEC(".struct_ops.link")
+struct memcg_bpf_ops high_mcg_ops = {
+	.below_low = (void *)below_low_impl,
+	.below_min = (void *)below_min_impl,
+};
+
+SEC(".struct_ops.link")
+struct memcg_bpf_ops high_mcg_ops_below_low = {
+	.below_low = (void *)below_low_impl,
+};
+
+SEC(".struct_ops.link")
+struct memcg_bpf_ops high_mcg_ops_below_min = {
+	.below_min = (void *)below_min_impl,
+};
+
+SEC(".struct_ops.link")
+struct memcg_bpf_ops low_mcg_ops = {
+	.memcg_charged = (void *)low_mcg_impl,
+	.memcg_uncharged = (void *)memcg_uncharged_impl,
+};
+
+SEC(".struct_ops.link")
+struct memcg_bpf_ops low_mcg_ops_high_delay = {
+	.memcg_charged = (void *)get_high_delay_ms_impl,
+};
+
+SEC(".struct_ops.link")
+struct memcg_bpf_ops low_mcg_ops_async = {
+	.memcg_charged = (void *)memcg_charged_impl,
+	.memcg_uncharged = (void *)memcg_uncharged_impl,
+};
+
+char LICENSE[] SEC("license") = "GPL";
diff --git a/samples/bpf/memcg.c b/samples/bpf/memcg.c
new file mode 100644
index 000000000000..0929d868e6d8
--- /dev/null
+++ b/samples/bpf/memcg.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <getopt.h>
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#ifndef __MEMCG_RSTAT_SIMPLE_BPF_SKEL_H__
+#define u64 uint64_t
+#endif
+
+struct local_config {
+	u64		threshold;
+	u64		high_cgroup_id;
+	u64		low_cgroup_id;
+	bool		use_below_low;
+	bool		use_below_min;
+	unsigned int	over_high_ms;
+	u64		async_trigger_bytes;
+};
+
+#include "memcg.skel.h"
+
+static bool exiting;
+
+static void sig_handler(int sig)
+{
+	exiting = true;
+}
+
+static void usage(const char *name)
+{
+	fprintf(stderr,
+		"Usage: %s --low_path=<path> --high_path=<path>\n"
+		"          --threshold=<value> [OPTIONS]\n\n",
+		name);
+
+	fprintf(stderr, "Required arguments:\n");
+	fprintf(stderr,
+		"  -l, --low_path=PATH      Low priority memcgroup path\n");
+	fprintf(stderr,
+		"  -g, --high_path=PATH     High priority memcgroup path\n");
+	fprintf(stderr,
+		"  -t, --threshold=VALUE    Sum of PGFAULT 'val' events from\n"
+		"                           the high-priority cgroup per second\n"
+		"                           needed to trigger low-priority\n"
+		"                           cgroup throttling\n\n");
+
+	fprintf(stderr, "Priority throttling options:\n");
+	fprintf(stderr,
+		"  -L, --use_below_low      Enable the below_low hook on the\n"
+		"                           high-priority cgroup\n");
+	fprintf(stderr,
+		"  -M, --use_below_min      Enable the below_min hook on the\n"
+		"                           high-priority cgroup\n");
+	fprintf(stderr,
+		"  -o, --over_high_ms=VALUE Delay (ms) returned by memcg_charged\n"
+		"                           for the low-priority cgroup while\n"
+		"                           throttling is active (default: 0)\n");
+	fprintf(stderr,
+		"  -a, --async_trigger_bytes=BYTES\n"
+		"                           Memory threshold bytes for\n"
+		"                           the async-reclaim Low priority\n"
+		"                           memcgroup above which background\n"
+		"                           page reclaim is triggered.\n"
+		"                           0 or omitted = feature disabled.\n");
+	fprintf(stderr,
+		"  -O, --allow_override     Set BPF_F_ALLOW_OVERRIDE when\n"
+		"                           attaching struct_ops\n\n");
+
+	fprintf(stderr, "Misc:\n");
+	fprintf(stderr, "  -h, --help              Show this help message\n\n");
+
+	fprintf(stderr, "Examples:\n");
+	fprintf(stderr,
+		"  # Priority throttling only:\n"
+		"  %s --low_path=/sys/fs/cgroup/low \\\n"
+		"     --high_path=/sys/fs/cgroup/high \\\n"
+		"     --threshold=1000 --over_high_ms=500 --use_below_low\n\n",
+		name);
+	fprintf(stderr,
+		"  # Async reclaim only (no throttling):\n"
+		"  %s --low_path=/sys/fs/cgroup/low \\\n"
+		"     --threshold=1000 \\\n"
+		"     --async_trigger_bytes=33554432\n\n",
+		name);
+	fprintf(stderr,
+		"  # Both features combined:\n"
+		"  %s --low_path=/sys/fs/cgroup/low \\\n"
+		"     --high_path=/sys/fs/cgroup/high \\\n"
+		"     --threshold=1000 --over_high_ms=500 \\\n"
+		"     --async_trigger_bytes=33554432\n",
+		name);
+}
+
+static uint64_t get_cgroup_id(const char *cgroup_path)
+{
+	struct stat st;
+
+	if (!cgroup_path) {
+		fprintf(stderr, "Error: cgroup_path is NULL\n");
+		return 0;
+	}
+
+	if (stat(cgroup_path, &st) < 0) {
+		fprintf(stderr, "Error: stat(%s) failed: %d\n",
+			cgroup_path, errno);
+		return 0;
+	}
+
+	return (uint64_t)st.st_ino;
+}
+
+static uint64_t parse_u64(const char *str, const char *prog)
+{
+	uint64_t value;
+
+	errno = 0;
+	value = strtoull(str, NULL, 10);
+	if (errno != 0) {
+		fprintf(stderr, "ERROR: strtoull '%s' failed: %d\n",
+			str, errno);
+		usage(prog);
+		exit(-errno);
+	}
+	return value;
+}
+
+static int
+attach_ops(struct bpf_object *obj, __u32 opts_flags, const char *name, int fd,
+	   struct bpf_link **link_ptr)
+{
+	int err;
+	struct bpf_map *map;
+	struct bpf_link *link;
+	DECLARE_LIBBPF_OPTS(bpf_struct_ops_opts, opts,
+		.flags    = opts_flags | BPF_F_CGROUP_FD,
+		.target_fd = fd,
+	);
+
+	map = bpf_object__find_map_by_name(obj, name);
+	if (!map) {
+		fprintf(stderr,
+			"ERROR: Failed to find %s map\n", name);
+		err = -ESRCH;
+		goto out;
+	}
+	link = bpf_map__attach_struct_ops_opts(map, &opts);
+	err = libbpf_get_error(link);
+	if (err) {
+		link = NULL;
+		fprintf(stderr,
+			"Failed to attach struct ops %s: %d\n",
+			name, err);
+		goto out;
+	}
+	*link_ptr = link;
+
+out:
+	return err;
+}
+
+int main(int argc, char **argv)
+{
+	int low_cgroup_fd = -1, high_cgroup_fd = -1;
+	struct local_config local_config = {
+		.threshold = 1,
+		.high_cgroup_id = 0,
+		.low_cgroup_id = 0,
+		.use_below_low = false,
+		.use_below_min = false,
+		.over_high_ms = 0,
+		.async_trigger_bytes = 0,
+	};
+	LIBBPF_OPTS(bpf_test_run_opts, run_opts,
+		.ctx_in = &local_config,
+		.ctx_size_in = sizeof(local_config)
+	);
+	int prog_init_fd;
+	__u32 opts_flags = 0;
+	const char *low_path = NULL;
+	const char *high_path = NULL;
+	struct memcg *skel = NULL;
+	struct bpf_program *prog = NULL;
+	struct bpf_link *link = NULL, *link_low = NULL, *link_high = NULL;
+	int err = -EINVAL;
+	int opt;
+	int option_index = 0;
+
+	static struct option long_options[] = {
+		/* required */
+		{"low_path",		  required_argument, 0, 'l'},
+		{"high_path",		  required_argument, 0, 'g'},
+		{"threshold",		  required_argument, 0, 't'},
+		/* priority throttling */
+		{"over_high_ms",	  required_argument, 0, 'o'},
+		{"use_below_low",	  no_argument,	     0, 'L'},
+		{"use_below_min",	  no_argument,	     0, 'M'},
+		{"async_trigger_bytes",	  required_argument, 0, 'a'},
+		{"allow_override",	  no_argument,	     0, 'O'},
+		/* misc */
+		{"help",		  no_argument,	     0, 'h'},
+		{0,			  0,		     0,	 0 }
+	};
+
+	while ((opt = getopt_long(argc, argv, "l:g:t:o:LMOa:h",
+				  long_options, &option_index)) != -1) {
+		switch (opt) {
+		case 'l':
+			low_path = optarg;
+			break;
+		case 'g':
+			high_path = optarg;
+			break;
+		case 't':
+			local_config.threshold = parse_u64(optarg, argv[0]);
+			break;
+		case 'o':
+			local_config.over_high_ms
+				= (unsigned int)parse_u64(optarg, argv[0]);
+			break;
+		case 'L':
+			local_config.use_below_low = true;
+			break;
+		case 'M':
+			local_config.use_below_min = true;
+			break;
+		case 'O':
+			opts_flags = BPF_F_ALLOW_OVERRIDE;
+			break;
+		case 'a':
+			local_config.async_trigger_bytes
+				= parse_u64(optarg, argv[0]);
+			break;
+		case 'h':
+			usage(argv[0]);
+			return 0;
+		default:
+			usage(argv[0]);
+			return -EINVAL;
+		}
+	}
+
+	if ((!local_config.use_below_low &&
+	     !local_config.use_below_min &&
+	     !local_config.async_trigger_bytes &&
+	     !local_config.over_high_ms) ||
+		((local_config.use_below_low || local_config.use_below_min) &&
+	     !high_path) ||
+	    (local_config.async_trigger_bytes && !low_path) ||
+	    (local_config.over_high_ms && (!high_path || !low_path))) {
+		fprintf(stderr, "ERROR: Missing required arguments\n\n");
+		usage(argv[0]);
+		goto out;
+	}
+
+
+	if (low_path) {
+		low_cgroup_fd = open(low_path, O_RDONLY);
+		if (low_cgroup_fd < 0) {
+			fprintf(stderr,
+				"ERROR: open low cgroup '%s' failed: %d\n",
+				low_path, errno);
+			err = -errno;
+			goto out;
+		}
+
+		local_config.low_cgroup_id = get_cgroup_id(low_path);
+		if (!local_config.low_cgroup_id) {
+			fprintf(stderr,
+				"ERROR: get low cgroup '%s' id failed: %d\n",
+				low_path, errno);
+			err = -errno;
+			goto out;
+		}
+	}
+
+	if (high_path) {
+		high_cgroup_fd = open(high_path, O_RDONLY);
+		if (high_cgroup_fd < 0) {
+			fprintf(stderr,
+				"ERROR: open high cgroup '%s' failed: %d\n",
+				high_path, errno);
+			err = -errno;
+			goto out;
+		}
+
+		local_config.high_cgroup_id = get_cgroup_id(high_path);
+		if (!local_config.high_cgroup_id) {
+			fprintf(stderr,
+				"ERROR: get high cgroup '%s' id failed: %d\n",
+				high_path, errno);
+			err = -errno;
+			goto out;
+		}
+	}
+
+	skel = memcg__open_and_load();
+	if (!skel) {
+		err = -errno;
+		fprintf(stderr,
+			"ERROR: opening and loading BPF skeleton failed: %d\n",
+			err);
+		goto out;
+	}
+
+	prog_init_fd = bpf_program__fd(skel->progs.prog_init);
+	err = bpf_prog_test_run_opts(prog_init_fd, &run_opts);
+	if (err || run_opts.retval) {
+		fprintf(stderr,
+			"ERROR: prog_init failed (err=%d retval=%d)\n",
+			err, run_opts.retval);
+		err = err ? err : -run_opts.retval;
+		goto out;
+	}
+
+	if (local_config.use_below_low && local_config.use_below_min) {
+		err = attach_ops(skel->obj, opts_flags, "high_mcg_ops",
+				 high_cgroup_fd, &link_high);
+		if (err)
+			goto out;
+	} else if (local_config.use_below_low) {
+		err = attach_ops(skel->obj, opts_flags,
+				 "high_mcg_ops_below_low",
+				 high_cgroup_fd, &link_high);
+		if (err)
+			goto out;
+	} else if (local_config.use_below_min) {
+		err = attach_ops(skel->obj, opts_flags,
+				 "high_mcg_ops_below_min",
+				 high_cgroup_fd, &link_high);
+		if (err)
+			goto out;
+	}
+
+	if (local_config.over_high_ms && local_config.async_trigger_bytes) {
+		err = attach_ops(skel->obj, opts_flags,
+				 "low_mcg_ops",
+				 low_cgroup_fd, &link_low);
+		if (err)
+			goto out;
+	} else if (local_config.over_high_ms) {
+		err = attach_ops(skel->obj, opts_flags,
+				 "low_mcg_ops_high_delay",
+				 low_cgroup_fd, &link_low);
+		if (err)
+			goto out;
+	} else if (local_config.async_trigger_bytes) {
+		err = attach_ops(skel->obj, opts_flags,
+				 "low_mcg_ops_async",
+				 low_cgroup_fd, &link_low);
+		if (err)
+			goto out;
+	}
+
+	if (local_config.use_below_low || local_config.use_below_min ||
+	    local_config.over_high_ms) {
+		prog = bpf_object__find_program_by_name(skel->obj,
+						"handle_count_memcg_events");
+		if (!prog) {
+			fprintf(stderr,
+			"ERROR: finding a prog in BPF object file failed\n");
+			goto out;
+		}
+
+		link = bpf_program__attach(prog);
+		err = libbpf_get_error(link);
+		if (err) {
+			link = NULL;
+			fprintf(stderr,
+				"ERROR: bpf_program__attach failed: %d\n",
+				err);
+			goto out;
+		}
+	}
+
+	printf("Successfully attached!\n");
+
+	signal(SIGINT,  sig_handler);
+	signal(SIGTERM, sig_handler);
+
+	while (!exiting)
+		pause();
+
+	printf("Exiting...\n");
+	err = 0;
+
+out:
+	bpf_link__destroy(link);
+	bpf_link__destroy(link_low);
+	bpf_link__destroy(link_high);
+	if (skel) {
+		memcg__detach(skel);
+		memcg__destroy(skel);
+	}
+	if (low_cgroup_fd >= 0)
+		close(low_cgroup_fd);
+	if (high_cgroup_fd >= 0)
+		close(high_cgroup_fd);
+	return err;
+}
-- 
2.43.0


