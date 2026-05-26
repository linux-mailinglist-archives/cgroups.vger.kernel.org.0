Return-Path: <cgroups+bounces-16272-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNOJJx0FFWroSAcAu9opvQ
	(envelope-from <cgroups+bounces-16272-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 04:27:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A575CFE76
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 04:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2E823038500
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 02:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005773064B2;
	Tue, 26 May 2026 02:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o/QG/lw4"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAAE2F8EA4
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 02:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779762345; cv=none; b=vBaX0Bs5AxHnxcqqqdf1bz8RJNvVYjf+wlqk3GYmeD5d85ipZdCuepXrdBZ/2yKzL2uTGYczAbTk49fq6h2FIwFfYBFrF7iExRsq3GWMzG6mzUnMLBN3TYf8eJSTux9Gz1hNzLxQX4CzYqoASqbApxRMwN2895sdZ4H1Q5BCNVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779762345; c=relaxed/simple;
	bh=QirGPpr7fVdMCewDL8EqmwoSapxySrhGmmXCGr0oWK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHyTrkksPc+taGTuh5+PJHRTUhGrpZpLoNoOIjCNfML/JuvYe9vcZdFmz+hZWP39rC2i9UrLoQqwq7wKRaqxmJMCnACNRrlyVoGtBPRwaoXb52DBZfzBDEEtbJsnjMf+qhPHjm8Opx/ybBXtZq1KPJmQU5+FsyDqu6E7LAMf12E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o/QG/lw4; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779762341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPt8FtuCxts2rIT8LYxYlii0QfD3k+uu3aBbt0C8m+w=;
	b=o/QG/lw4IOwQFCUm2A4fnOGTcp+vWpVJ60NU5X0Gvezz8ozDsWYZrgcuzcv03ZqfCU2qTL
	M3iUvaqT4i/xAb93I9pkkdTfnXLSapL2BROqTcHinjolD1mvo89anYgM8mLuwe5rZpZAMK
	2GXMFd35Gsz3WpGtAk2tGr4XzzK8I4A=
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
Subject: [RFC PATCH bpf-next v7 07/11] mm/bpf: Add bpf_try_to_free_mem_cgroup_pages kfunc
Date: Tue, 26 May 2026 10:24:55 +0800
Message-ID: <13b10d91aff4307580d1a601f1592efe42a92b05.1779760876.git.zhuhui@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16272-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.973];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: F2A575CFE76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hui Zhu <zhuhui@kylinos.cn>

Expose the memory cgroup reclaim interface to BPF programs by adding
the bpf_try_to_free_mem_cgroup_pages kfunc. This allows BPF to
trigger memory reclamation for a specific cgroup.

The kfunc wraps try_to_free_mem_cgroup_pages and introduces a
swappiness parameter with the following semantics:
Values in [MIN_SWAPPINESS, SWAPPINESS_ANON_ONLY] are passed through
as an explicit swappiness override.
Values below MIN_SWAPPINESS indicate the use of the system default
(passed as NULL to the core reclaim path).
Values above SWAPPINESS_ANON_ONLY are rejected as invalid (-EINVAL).

Note that the swappiness override is only respected by the core
reclaim path if the MEMCG_RECLAIM_PROACTIVE flag is set in
reclaim_options.

Swap usage during reclaim is gated on reclaim_options: swap is
considered only when MEMCG_RECLAIM_MAY_SWAP is set. Without this
flag, reclaim is restricted to file-backed pages regardless of the
swappiness value or the cgroup's swappiness setting.

Also include <linux/swap.h> for the swappiness macro definitions and
register the function with the KF_SLEEPABLE flag.

Signed-off-by: Barry Song <baohua@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 mm/bpf_memcontrol.c | 57 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
index 1f726a7b22e3..0353c8736aa5 100644
--- a/mm/bpf_memcontrol.c
+++ b/mm/bpf_memcontrol.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/memcontrol.h>
+#include <linux/swap.h>
 #include <linux/bpf.h>
 
 /* Protects memcg->bpf_ops pointer for read and write. */
@@ -162,6 +163,60 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 	mem_cgroup_flush_stats(memcg);
 }
 
+/**
+ * bpf_try_to_free_mem_cgroup_pages - attempt to reclaim pages from
+ *                                    a memory cgroup
+ * @memcg:           the target memory cgroup to reclaim from
+ * @nr_pages:        the number of pages to reclaim
+ * @gfp_mask:        GFP flags controlling the reclaim behavior
+ * @reclaim_options: bitmask of MEMCG_RECLAIM_* flags to tune
+ *                   reclaim strategy
+ * @swappiness:      swappiness override value, or a sentinel to use
+ *                   the default
+ *
+ * BPF-facing wrapper around try_to_free_mem_cgroup_pages() that
+ * validates and translates the @swappiness argument before
+ * delegating to the core reclaim path.
+ *
+ * The @swappiness parameter follows these semantics:
+ *   - Values in [MIN_SWAPPINESS, SWAPPINESS_ANON_ONLY] are passed
+ *     through as an explicit swappiness override.
+ *   - Values below MIN_SWAPPINESS are treated as "use the system
+ *     default"; the override pointer is set to NULL and the cgroup's
+ *     own swappiness setting takes effect.
+ *   - Values above SWAPPINESS_ANON_ONLY are rejected as invalid.
+ *   - If @reclaim_options does not include MEMCG_RECLAIM_PROACTIVE,
+ *     the @swappiness override is ignored entirely by the core
+ *     reclaim path and the system default is used regardless.
+ *
+ * Swap usage during reclaim is gated on @reclaim_options: swap is
+ * considered only when MEMCG_RECLAIM_MAY_SWAP is set.  Without this
+ * flag, reclaim is restricted to file-backed pages regardless of the
+ * @swappiness value or the cgroup's swappiness setting.
+ *
+ * Return:
+ *   The number of pages actually reclaimed on success, or -%EINVAL
+ *   if @swappiness exceeds SWAPPINESS_ANON_ONLY.
+ */
+unsigned long bpf_try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
+					       unsigned long nr_pages,
+					       gfp_t gfp_mask,
+					       unsigned int reclaim_options,
+					       int swappiness)
+{
+	int *swapiness_ptr;
+
+	if (swappiness > SWAPPINESS_ANON_ONLY)
+		return -EINVAL;
+	else if (swappiness < MIN_SWAPPINESS)
+		swapiness_ptr = NULL;
+	else
+		swapiness_ptr = &swappiness;
+
+	return try_to_free_mem_cgroup_pages(memcg, nr_pages, gfp_mask,
+					    reclaim_options, swapiness_ptr);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
@@ -175,6 +230,8 @@ BTF_ID_FLAGS(func, bpf_mem_cgroup_usage)
 BTF_ID_FLAGS(func, bpf_mem_cgroup_page_state)
 BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_SLEEPABLE)
 
+BTF_ID_FLAGS(func, bpf_try_to_free_mem_cgroup_pages, KF_SLEEPABLE)
+
 BTF_KFUNCS_END(bpf_memcontrol_kfuncs)
 
 static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set = {
-- 
2.43.0


