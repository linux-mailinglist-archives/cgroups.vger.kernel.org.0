Return-Path: <cgroups+bounces-13469-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOUCL1eKeGmqqwEAu9opvQ
	(envelope-from <cgroups+bounces-13469-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 10:50:15 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8FE920ED
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 10:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8ECE93045A3C
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 09:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A2F33554B;
	Tue, 27 Jan 2026 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KimfuEVO"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968DE335077
	for <cgroups@vger.kernel.org>; Tue, 27 Jan 2026 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769507294; cv=none; b=o7EmUkiV1P5nec3XlBO+x8uuDIl2El7Fms9Preh1MohemVchhHqGAy3bwAcYzOcnRLkq6KQbM/v7uGpv38Z0TikEcw4n/bD+i2JFLnJQLhDD/qJOSbeITFu0myMbtT/kK86PObNOGJ8sJNJX0VaJaepGbJcrkah8GXi6tLfW7QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769507294; c=relaxed/simple;
	bh=FCFy1j/Ma2OsiV9AvUNgxQIAPG/9M6RdjHZidkT7GR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsUbHL2epqZqcbKrY68q1oUUrLzzOVwZaKoYKknKDQaW+Ac4cauwnzkBewhjqXFmIo0kxZTUfpVsHNRGs53zRrskfIgz9+q6BGpn8P1WwriB65bVZy2dkx53LNWeff/qczRxig/No7HmUKKDHQu5g+1apTDMjwQVdqaSSBLjkfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KimfuEVO; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769507290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDAnxBm956aOF5ZEWN5PM3SfgIASeIOgGwSIT/GymGw=;
	b=KimfuEVO0LaSFIx1vLjDfszO3hna5+Nma5FK1NDslPhcUrH/gP7YCHp6FkQNCIp4Rrzvxh
	HcXQNqhZRXxjjgOraT/91ord6ZcUnFisKaRTUxDxWmtCQ3F8UykYDH28W8zxPQ9101jV/z
	YcM2Z+FHQD7uvJ4j8I97lOIPgKGAtUo=
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
Subject: [RFC PATCH bpf-next v5 10/12] mm/bpf: Add BPF_F_ALLOW_OVERRIDE support for memcg_bpf_ops
Date: Tue, 27 Jan 2026 17:47:35 +0800
Message-ID: <4a1ad099a2db96b92318cb924d2a7b76ee530209.1769506741.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1769506741.git.zhuhui@kylinos.cn>
References: <cover.1769506741.git.zhuhui@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13469-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: 3E8FE920ED
X-Rspamd-Action: no action

From: Hui Zhu <zhuhui@kylinos.cn>

To allow for more flexible attachment policies in nested cgroup
hierarchies, this patch introduces support for the
`BPF_F_ALLOW_OVERRIDE` flag for `memcg_bpf_ops`.

When a `memcg_bpf_ops` is attached to a cgroup with this flag, it
permits child cgroups to attach their own, different `memcg_bpf_ops`,
overriding the parent's inherited program. Without this flag,
attaching a BPF program to a cgroup that already has one (either
directly or via inheritance) will fail.

The implementation involves:
- Adding a `bpf_ops_flags` field to `struct mem_cgroup`.
- During registration (`bpf_memcg_ops_reg`), checking for existing
  programs and the `BPF_F_ALLOW_OVERRIDE` flag.
- During unregistration (`bpf_memcg_ops_unreg`), correctly restoring
  the parent's BPF program to the cgroup hierarchy.
- Ensuring flags are inherited by child cgroups during online events.

This change enables complex, multi-level policy enforcement where
different subtrees of the cgroup hierarchy can have distinct memory
management BPF programs.

Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 include/linux/memcontrol.h |  1 +
 mm/bpf_memcontrol.c        | 82 ++++++++++++++++++++++++++------------
 2 files changed, 57 insertions(+), 26 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 24c4df864401..98c16e8dcd5b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -354,6 +354,7 @@ struct mem_cgroup {
 
 #ifdef CONFIG_BPF_SYSCALL
 	struct memcg_bpf_ops *bpf_ops;
+	u32 bpf_ops_flags;
 #endif
 
 	struct mem_cgroup_per_node *nodeinfo[];
diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
index e746eb9cbd56..7cd983e350d7 100644
--- a/mm/bpf_memcontrol.c
+++ b/mm/bpf_memcontrol.c
@@ -213,6 +213,7 @@ void memcontrol_bpf_online(struct mem_cgroup *memcg)
 		goto out;
 
 	WRITE_ONCE(memcg->bpf_ops, ops);
+	memcg->bpf_ops_flags = parent_memcg->bpf_ops_flags;
 
 	/*
 	 * If the BPF program implements it, call the online handler to
@@ -338,33 +339,19 @@ static int bpf_memcg_ops_init_member(const struct btf_type *t,
 	return 0;
 }
 
-/**
- * clean_memcg_bpf_ops - Clear BPF ops from a memory cgroup hierarchy
- * @memcg: Root memory cgroup to start from
- * @ops: The specific BPF ops to remove
- *
- * Walks the cgroup hierarchy and clears bpf_ops for any cgroup that
- * matches @ops.
- */
-static void clean_memcg_bpf_ops(struct mem_cgroup *memcg,
-				struct memcg_bpf_ops *ops)
-{
-	struct mem_cgroup *iter = NULL;
-
-	while ((iter = mem_cgroup_iter(memcg, iter, NULL))) {
-		if (READ_ONCE(iter->bpf_ops) == ops)
-			WRITE_ONCE(iter->bpf_ops, NULL);
-	}
-}
-
 static int bpf_memcg_ops_reg(void *kdata, struct bpf_link *link)
 {
 	struct bpf_struct_ops_link *ops_link
 		= container_of(link, struct bpf_struct_ops_link, link);
-	struct memcg_bpf_ops *ops = kdata;
+	struct memcg_bpf_ops *ops = kdata, *old_ops;
 	struct mem_cgroup *memcg, *iter = NULL;
 	int err = 0;
 
+	if (ops_link->flags & ~BPF_F_ALLOW_OVERRIDE) {
+		pr_err("attach only support BPF_F_ALLOW_OVERRIDE\n");
+		return -EOPNOTSUPP;
+	}
+
 	memcg = mem_cgroup_get_from_ino(ops_link->cgroup_id);
 	if (!memcg)
 		return -ENOENT;
@@ -372,16 +359,41 @@ static int bpf_memcg_ops_reg(void *kdata, struct bpf_link *link)
 		return PTR_ERR(memcg);
 
 	cgroup_lock();
+
+	/*
+	 * Check if memcg has bpf_ops and whether it is inherited from
+	 * parent.
+	 * If inherited and BPF_F_ALLOW_OVERRIDE is set, allow override.
+	 */
+	old_ops = READ_ONCE(memcg->bpf_ops);
+	if (old_ops) {
+		struct mem_cgroup *parent_memcg = parent_mem_cgroup(memcg);
+
+		if (!parent_memcg ||
+		    !(memcg->bpf_ops_flags & BPF_F_ALLOW_OVERRIDE) ||
+		    READ_ONCE(parent_memcg->bpf_ops) != old_ops) {
+			err = -EBUSY;
+			goto unlock_out;
+		}
+	}
+
+	/* Check for incompatible bpf_ops in descendants. */
 	while ((iter = mem_cgroup_iter(memcg, iter, NULL))) {
-		if (READ_ONCE(iter->bpf_ops)) {
-			mem_cgroup_iter_break(memcg, iter);
+		struct memcg_bpf_ops *iter_ops = READ_ONCE(iter->bpf_ops);
+
+		if (iter_ops && iter_ops != old_ops) {
+			/* cannot override existing bpf_ops of sub-cgroup. */
 			err = -EBUSY;
-			break;
+			goto unlock_out;
 		}
+	}
+
+	while ((iter = mem_cgroup_iter(memcg, iter, NULL))) {
 		WRITE_ONCE(iter->bpf_ops, ops);
+		iter->bpf_ops_flags = ops_link->flags;
 	}
-	if (err)
-		clean_memcg_bpf_ops(memcg, ops);
+
+unlock_out:
 	cgroup_unlock();
 
 	mem_cgroup_put(memcg);
@@ -395,13 +407,31 @@ static void bpf_memcg_ops_unreg(void *kdata, struct bpf_link *link)
 		= container_of(link, struct bpf_struct_ops_link, link);
 	struct memcg_bpf_ops *ops = kdata;
 	struct mem_cgroup *memcg;
+	struct mem_cgroup *iter;
+	struct memcg_bpf_ops *parent_bpf_ops = NULL;
+	u32 parent_bpf_ops_flags = 0;
 
 	memcg = mem_cgroup_get_from_ino(ops_link->cgroup_id);
 	if (IS_ERR_OR_NULL(memcg))
 		goto out;
 
 	cgroup_lock();
-	clean_memcg_bpf_ops(memcg, ops);
+
+	/* Get the parent bpf_ops and bpf_ops_flags */
+	iter = parent_mem_cgroup(memcg);
+	if (iter) {
+		parent_bpf_ops = READ_ONCE(iter->bpf_ops);
+		parent_bpf_ops_flags = iter->bpf_ops_flags;
+	}
+
+	iter = NULL;
+	while ((iter = mem_cgroup_iter(memcg, iter, NULL))) {
+		if (READ_ONCE(iter->bpf_ops) == ops) {
+			WRITE_ONCE(iter->bpf_ops, parent_bpf_ops);
+			iter->bpf_ops_flags = parent_bpf_ops_flags;
+		}
+	}
+
 	cgroup_unlock();
 
 	mem_cgroup_put(memcg);
-- 
2.43.0


