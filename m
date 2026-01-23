Return-Path: <cgroups+bounces-13392-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKvTKhs5c2l/tQAAu9opvQ
	(envelope-from <cgroups+bounces-13392-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 10:02:19 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F007A72E89
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 10:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF3F2300A5AE
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 09:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C0C322539;
	Fri, 23 Jan 2026 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s16CndXY"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2774923D2B4
	for <cgroups@vger.kernel.org>; Fri, 23 Jan 2026 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769158865; cv=none; b=MDa9Xf+lSm0Y1Y9JJsQHnrztcuV7HC9FIvXJT6PfYsO1hYfLFwyu6HJHXjQ6teAI7d+AAGk6azFC423Mm9n6TVbOZNFYiRFzl/eHOpOLiH8j+OcStCZjP1foNI3hLg0N/cB6uVnA/DxKDbApk5EPsJywAgIB+SUGp88tTAmjFdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769158865; c=relaxed/simple;
	bh=TokOtLPJOxzGUdwmcKHQxoHBN5+zFmo6iC5kHiyYT0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JT41PSOB/4b4G++p1LcxsKd86urE4ITDk2a/XlTbGzKT3l2qhv4qQleNicVJJY2iEQUYtJyo9f9FyPj5uqyIAW1mhwAfUOqkTs3EBENf17IRHC9pYggQ1Qi2RYtvEc8B0Jyfc78CViTjfp7kWBCEIstCkpZJRawP3Z0+vwGNSD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s16CndXY; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769158861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jSd5dZjazXtYLKnDww1Cz0qa7pIOMhPfOmKjHC0vcEI=;
	b=s16CndXYTk+3Ju3wcxjkAVQN+AwotBloPZ2BQeqwtwTfv+LXFsf84cvqam5EaIE7lkaEd8
	ofv8AdNIzdVXwHkmNupiHKj8MoRrlfwN7Pew8/Tj2oC4qNitnirZER/RXQGEqLMwsS7W3y
	xC1vcB3c1zIqaov6OqWQX1lZ5ATaK0w=
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
Subject: [RFC PATCH bpf-next v3 10/12] mm/bpf: Add BPF_F_ALLOW_OVERRIDE support for  memcg_bpf_ops
Date: Fri, 23 Jan 2026 17:00:15 +0800
Message-ID: <9f072e53f79ceaea43e3730476494517e453530a.1769157382.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1769157382.git.zhuhui@kylinos.cn>
References: <cover.1769157382.git.zhuhui@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13392-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: F007A72E89
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
 mm/bpf_memcontrol.c        | 77 ++++++++++++++++++++++++--------------
 2 files changed, 49 insertions(+), 29 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d71e86b85ba7..a37b78d3853d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -354,6 +354,7 @@ struct mem_cgroup {
 
 #ifdef CONFIG_BPF_SYSCALL
 	struct memcg_bpf_ops *bpf_ops;
+	u32 bpf_ops_flags;
 #endif
 
 	struct mem_cgroup_per_node *nodeinfo[];
diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
index 3eae1af49519..d6126b94f521 100644
--- a/mm/bpf_memcontrol.c
+++ b/mm/bpf_memcontrol.c
@@ -213,6 +213,7 @@ void memcontrol_bpf_online(struct mem_cgroup *memcg)
 		goto out;
 
 	WRITE_ONCE(memcg->bpf_ops, ops);
+	memcg->bpf_ops_flags = parent_memcg->bpf_ops_flags;
 
 	/*
 	 * If the BPF program implements it, call the online handler to
@@ -340,29 +341,6 @@ static int bpf_memcg_ops_init_member(const struct btf_type *t,
 	return 0;
 }
 
-/**
- * clean_memcg_bpf_ops - Detach BPF programs from a cgroup hierarchy.
- * @memcg: The root of the cgroup hierarchy to clean.
- * @ops:   The specific ops struct to detach. If NULL, detach any ops.
- *
- * Iterates through all descendant cgroups of @memcg (including itself)
- * and clears their bpf_ops pointer. This is used when a BPF program
- * is detached or if attachment fails midway.
- */
-static void clean_memcg_bpf_ops(struct mem_cgroup *memcg,
-				struct memcg_bpf_ops *ops)
-{
-	struct mem_cgroup *iter = NULL;
-
-	while ((iter = mem_cgroup_iter(memcg, iter, NULL))) {
-		if (ops) {
-			if (!WARN_ON(READ_ONCE(memcg->bpf_ops) != ops))
-				WRITE_ONCE(memcg->bpf_ops, NULL);
-		} else
-			WRITE_ONCE(iter->bpf_ops, NULL);
-	}
-}
-
 static int bpf_memcg_ops_reg(void *kdata, struct bpf_link *link)
 {
 	struct bpf_struct_ops_link *ops_link
@@ -371,21 +349,44 @@ static int bpf_memcg_ops_reg(void *kdata, struct bpf_link *link)
 	struct mem_cgroup *memcg, *iter = NULL;
 	int err = 0;
 
+	if (ops_link->flags & ~BPF_F_ALLOW_OVERRIDE) {
+		pr_err("attach only support BPF_F_ALLOW_OVERRIDE\n");
+		return -EOPNOTSUPP;
+	}
+
 	memcg = mem_cgroup_get_from_ino(ops_link->cgroup_id);
 	if (IS_ERR_OR_NULL(memcg))
 		return PTR_ERR(memcg);
 
 	cgroup_lock();
+
+	if (READ_ONCE(memcg->bpf_ops)) {
+		/* Check if bpf_ops of the parent is BPF_F_ALLOW_OVERRIDE. */
+		if (memcg->bpf_ops_flags & BPF_F_ALLOW_OVERRIDE) {
+			iter = parent_mem_cgroup(memcg);
+
+			if (!iter)
+				goto busy_out;
+			if (READ_ONCE(iter->bpf_ops) !=
+			    READ_ONCE(memcg->bpf_ops))
+				goto busy_out;
+		} else {
+busy_out:
+			err = -EBUSY;
+			goto unlock_out;
+		}
+	}
+
 	while ((iter = mem_cgroup_iter(memcg, iter, NULL))) {
 		if (READ_ONCE(iter->bpf_ops)) {
-			mem_cgroup_iter_break(memcg, iter);
-			err = -EBUSY;
-			break;
+			/* cannot override existing bpf_ops of sub-cgroup. */
+			continue;
 		}
 		WRITE_ONCE(iter->bpf_ops, ops);
+		iter->bpf_ops_flags = ops_link->flags;
 	}
-	if (err)
-		clean_memcg_bpf_ops(memcg, NULL);
+
+unlock_out:
 	cgroup_unlock();
 
 	mem_cgroup_put(memcg);
@@ -399,13 +400,31 @@ static void bpf_memcg_ops_unreg(void *kdata, struct bpf_link *link)
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


