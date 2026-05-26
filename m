Return-Path: <cgroups+bounces-16267-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IYoM/EDFWroSAcAu9opvQ
	(envelope-from <cgroups+bounces-16267-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 04:22:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCCF5CFD99
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 04:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7717C3038D10
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 02:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F832F8EB6;
	Tue, 26 May 2026 02:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wiGodmtV"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53372F8E84
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 02:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779762084; cv=none; b=Ptu0Ku8Lc4gESzQ4OiOxAVCKWBw1YALo4K3VAX3GqUIEHvqC4RNbo5pCN+QsAoRSOzYn7qtjNuxx6gDSM7vV8IWXrN5upAfoTENKBkG5SfFQhBGdIXt3hDVlmj5ZXH6FJlvJgmg54z1PFh735kVImNostNieafNNeq2KJf2yYA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779762084; c=relaxed/simple;
	bh=fgA7u0xlWi4suAXNZnu+tx4g2KqAjMocBcVjgaWION0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWnMbwIQGxS0kW4xx+8TTLKx/6UOtzGyxAtFeGCOt/faSSqdy3VSz15hNEOGBi7RkGg387ZEewylFIWiE3i+tP6j3kgej71YtkF47xGD5TXqg05iXCKNQr2l0VGoj6cg6wBGXeAwJkfXcaZGoCXGf1gvLaPP9nV9J73SFM2tIg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wiGodmtV; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779762079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=br8xrpTcjYEeEq9ZZA1EyJzq2nS+XRXxEmKl1Ist3v4=;
	b=wiGodmtV5GoWbSCEJi9JPwrvbkx7m30YOeF5uIWsGhhlUbhafnKUtItj/EevaM/NxfT8ja
	u3AP4vqDOlKk47XLpoM/oHjHn2+klsc/ke30PeE48JVEC6bSlVlKtai1ksbzdLSIyEk2PA
	mabyDHlxCtpc44Gv01bRz0OcbpO8fXk=
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
	baohua@kernel.org
Subject: [RFC PATCH bpf-next v7 02/11] bpf: allow attaching struct_ops to cgroups
Date: Tue, 26 May 2026 10:20:02 +0800
Message-ID: <a7bf069cbc39930fad3740269aa82f1acadb029b.1779760876.git.zhuhui@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16267-lists,cgroups=lfdr.de];
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
	RCPT_COUNT_GT_50(0.00)[58];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.965];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,kylinos.cn:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4DCCF5CFD99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Roman Gushchin <roman.gushchin@linux.dev>

Introduce an ability to attach bpf struct_ops'es to cgroups.

>From user's standpoint it works in the following way:
a user passes a BPF_F_CGROUP_FD flag and specifies the target cgroup
fd while creating a struct_ops link. As the result, the bpf struct_ops
link will be created and attached to a cgroup.

The cgroup.bpf structure maintains a list of attached struct ops links.
If the cgroup is getting deleted, attached struct ops'es are getting
auto-detached and the userspace program gets a notification.

This change doesn't answer the question how bpf programs belonging
to these struct ops'es will be executed. It will be done individually
for every bpf struct ops which supports this.

Please, note that unlike "normal" bpf programs, struct ops'es
are not propagated to cgroup sub-trees.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/bpf-cgroup-defs.h |  3 ++
 include/linux/bpf-cgroup.h      | 16 +++++++++
 include/linux/bpf.h             |  3 ++
 include/uapi/linux/bpf.h        |  3 ++
 kernel/bpf/bpf_struct_ops.c     | 59 ++++++++++++++++++++++++++++++---
 kernel/bpf/cgroup.c             | 46 +++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h  |  1 +
 7 files changed, 127 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
index c9e6b26abab6..6c5e37190dad 100644
--- a/include/linux/bpf-cgroup-defs.h
+++ b/include/linux/bpf-cgroup-defs.h
@@ -71,6 +71,9 @@ struct cgroup_bpf {
 	/* temp storage for effective prog array used by prog_attach/detach */
 	struct bpf_prog_array *inactive;
 
+	/* list of bpf struct ops links */
+	struct list_head struct_ops_links;
+
 	/* reference counter used to detach bpf programs after cgroup removal */
 	struct percpu_ref refcnt;
 
diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index b2e79c2b41d5..88b643568012 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -423,6 +423,11 @@ int cgroup_bpf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 int cgroup_bpf_prog_query(const union bpf_attr *attr,
 			  union bpf_attr __user *uattr);
 
+int cgroup_bpf_attach_struct_ops(struct cgroup *cgrp,
+				 struct bpf_struct_ops_link *link);
+void cgroup_bpf_detach_struct_ops(struct cgroup *cgrp,
+				  struct bpf_struct_ops_link *link);
+
 const struct bpf_func_proto *
 cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
 #else
@@ -451,6 +456,17 @@ static inline int cgroup_bpf_link_attach(const union bpf_attr *attr,
 	return -EINVAL;
 }
 
+static inline int cgroup_bpf_attach_struct_ops(struct cgroup *cgrp,
+					       struct bpf_struct_ops_link *link)
+{
+	return -EINVAL;
+}
+
+static inline void cgroup_bpf_detach_struct_ops(struct cgroup *cgrp,
+						struct bpf_struct_ops_link *link)
+{
+}
+
 static inline int cgroup_bpf_prog_query(const union bpf_attr *attr,
 					union bpf_attr __user *uattr)
 {
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 01c0bf5a9cd0..743b4f0546b5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1911,6 +1911,9 @@ struct bpf_raw_tp_link {
 struct bpf_struct_ops_link {
 	struct bpf_link link;
 	struct bpf_map __rcu *map;
+	struct cgroup *cgroup;
+	bool cgroup_removed;
+	struct list_head list;
 	wait_queue_head_t wait_hup;
 };
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index aec171ccb6ef..f547613986cc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1246,6 +1246,7 @@ enum bpf_perf_event_type {
 #define BPF_F_AFTER		(1U << 4)
 #define BPF_F_ID		(1U << 5)
 #define BPF_F_PREORDER		(1U << 6)
+#define BPF_F_CGROUP_FD		(1U << 7)
 #define BPF_F_LINK		BPF_F_LINK /* 1 << 13 */
 
 /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
@@ -6793,6 +6794,8 @@ struct bpf_link_info {
 		} xdp;
 		struct {
 			__u32 map_id;
+			__u32 :32;
+			__u64 cgroup_id;
 		} struct_ops;
 		struct {
 			__u32 pf;
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index cf3c604d48ef..5333290957cb 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -13,6 +13,8 @@
 #include <linux/btf_ids.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/poll.h>
+#include <linux/bpf-cgroup.h>
+#include <linux/cgroup.h>
 
 struct bpf_struct_ops_value {
 	struct bpf_struct_ops_common_value common;
@@ -1220,6 +1222,10 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
 		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
 		bpf_map_put(&st_map->map);
 	}
+
+	if (st_link->cgroup)
+		cgroup_bpf_detach_struct_ops(st_link->cgroup, st_link);
+
 	kfree(st_link);
 }
 
@@ -1228,6 +1234,7 @@ static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link *link,
 {
 	struct bpf_struct_ops_link *st_link;
 	struct bpf_map *map;
+	u64 cgrp_id = 0;
 
 	st_link = container_of(link, struct bpf_struct_ops_link, link);
 	rcu_read_lock();
@@ -1235,6 +1242,14 @@ static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link *link,
 	if (map)
 		seq_printf(seq, "map_id:\t%d\n", map->id);
 	rcu_read_unlock();
+
+	cgroup_lock();
+	if (st_link->cgroup)
+		cgrp_id = cgroup_id(st_link->cgroup);
+	cgroup_unlock();
+
+	if (cgrp_id)
+		seq_printf(seq, "cgroup_id:\t%llu\n", cgrp_id);
 }
 
 static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
@@ -1242,6 +1257,7 @@ static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
 {
 	struct bpf_struct_ops_link *st_link;
 	struct bpf_map *map;
+	u64 cgrp_id = 0;
 
 	st_link = container_of(link, struct bpf_struct_ops_link, link);
 	rcu_read_lock();
@@ -1249,6 +1265,13 @@ static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
 	if (map)
 		info->struct_ops.map_id = map->id;
 	rcu_read_unlock();
+
+	cgroup_lock();
+	if (st_link->cgroup)
+		cgrp_id = cgroup_id(st_link->cgroup);
+	cgroup_unlock();
+
+	info->struct_ops.cgroup_id = cgrp_id;
 	return 0;
 }
 
@@ -1327,6 +1350,9 @@ static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
 
 	mutex_unlock(&update_mutex);
 
+	if (st_link->cgroup)
+		cgroup_bpf_detach_struct_ops(st_link->cgroup, st_link);
+
 	wake_up_interruptible_poll(&st_link->wait_hup, EPOLLHUP);
 
 	return 0;
@@ -1339,6 +1365,9 @@ static __poll_t bpf_struct_ops_map_link_poll(struct file *file,
 
 	poll_wait(file, &st_link->wait_hup, pts);
 
+	if (st_link->cgroup_removed)
+		return EPOLLHUP;
+
 	return rcu_access_pointer(st_link->map) ? 0 : EPOLLHUP;
 }
 
@@ -1357,8 +1386,12 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	struct bpf_link_primer link_primer;
 	struct bpf_struct_ops_map *st_map;
 	struct bpf_map *map;
+	struct cgroup *cgrp;
 	int err;
 
+	if (attr->link_create.flags & ~BPF_F_CGROUP_FD)
+		return -EINVAL;
+
 	map = bpf_map_get(attr->link_create.map_fd);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
@@ -1378,11 +1411,26 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_map_lops, NULL,
 		      attr->link_create.attach_type);
 
+	init_waitqueue_head(&link->wait_hup);
+
+	if (attr->link_create.flags & BPF_F_CGROUP_FD) {
+		cgrp = cgroup_get_from_fd(attr->link_create.target_fd);
+		if (IS_ERR(cgrp)) {
+			err = PTR_ERR(cgrp);
+			goto err_out;
+		}
+		link->cgroup = cgrp;
+		err = cgroup_bpf_attach_struct_ops(cgrp, link);
+		if (err) {
+			cgroup_put(cgrp);
+			link->cgroup = NULL;
+			goto err_out;
+		}
+	}
+
 	err = bpf_link_prime(&link->link, &link_primer);
 	if (err)
-		goto err_out;
-
-	init_waitqueue_head(&link->wait_hup);
+		goto err_put_cgroup;
 
 	/* Hold the update_mutex such that the subsystem cannot
 	 * do link->ops->detach() before the link is fully initialized.
@@ -1393,13 +1441,16 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 		mutex_unlock(&update_mutex);
 		bpf_link_cleanup(&link_primer);
 		link = NULL;
-		goto err_out;
+		goto err_put_cgroup;
 	}
 	RCU_INIT_POINTER(link->map, map);
 	mutex_unlock(&update_mutex);
 
 	return bpf_link_settle(&link_primer);
 
+err_put_cgroup:
+	if (link && link->cgroup)
+		cgroup_bpf_detach_struct_ops(link->cgroup, link);
 err_out:
 	bpf_map_put(map);
 	kfree(link);
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 876f6a81a9b6..b593ebb30a4e 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -16,6 +16,7 @@
 #include <linux/bpf-cgroup.h>
 #include <linux/bpf_lsm.h>
 #include <linux/bpf_verifier.h>
+#include <linux/poll.h>
 #include <net/sock.h>
 #include <net/bpf_sk_storage.h>
 
@@ -307,12 +308,23 @@ static void cgroup_bpf_release(struct work_struct *work)
 					       bpf.release_work);
 	struct bpf_prog_array *old_array;
 	struct list_head *storages = &cgrp->bpf.storages;
+	struct bpf_struct_ops_link *st_link, *st_tmp;
 	struct bpf_cgroup_storage *storage, *stmp;
+	LIST_HEAD(st_links);
 
 	unsigned int atype;
 
 	cgroup_lock();
 
+	list_splice_init(&cgrp->bpf.struct_ops_links, &st_links);
+	list_for_each_entry_safe(st_link, st_tmp, &st_links, list) {
+		st_link->cgroup = NULL;
+		st_link->cgroup_removed = true;
+		cgroup_put(cgrp);
+		if (IS_ERR(bpf_link_inc_not_zero(&st_link->link)))
+			list_del(&st_link->list);
+	}
+
 	for (atype = 0; atype < ARRAY_SIZE(cgrp->bpf.progs); atype++) {
 		struct hlist_head *progs = &cgrp->bpf.progs[atype];
 		struct bpf_prog_list *pl;
@@ -346,6 +358,11 @@ static void cgroup_bpf_release(struct work_struct *work)
 
 	cgroup_unlock();
 
+	list_for_each_entry_safe(st_link, st_tmp, &st_links, list) {
+		st_link->link.ops->detach(&st_link->link);
+		bpf_link_put(&st_link->link);
+	}
+
 	for (p = cgroup_parent(cgrp); p; p = cgroup_parent(p))
 		cgroup_bpf_put(p);
 
@@ -525,6 +542,7 @@ static int cgroup_bpf_inherit(struct cgroup *cgrp)
 		INIT_HLIST_HEAD(&cgrp->bpf.progs[i]);
 
 	INIT_LIST_HEAD(&cgrp->bpf.storages);
+	INIT_LIST_HEAD(&cgrp->bpf.struct_ops_links);
 
 	for (i = 0; i < NR; i++)
 		if (compute_effective_progs(cgrp, i, &arrays[i]))
@@ -2755,3 +2773,31 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return NULL;
 	}
 }
+
+int cgroup_bpf_attach_struct_ops(struct cgroup *cgrp,
+				 struct bpf_struct_ops_link *link)
+{
+	int ret = 0;
+
+	cgroup_lock();
+	if (percpu_ref_is_zero(&cgrp->bpf.refcnt)) {
+		ret = -EBUSY;
+		goto out;
+	}
+	list_add_tail(&link->list, &cgrp->bpf.struct_ops_links);
+out:
+	cgroup_unlock();
+	return ret;
+}
+
+void cgroup_bpf_detach_struct_ops(struct cgroup *cgrp,
+				  struct bpf_struct_ops_link *link)
+{
+	cgroup_lock();
+	if (link->cgroup == cgrp) {
+		list_del(&link->list);
+		link->cgroup = NULL;
+		cgroup_put(cgrp);
+	}
+	cgroup_unlock();
+}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 37142e6d911a..fa075dc3b7eb 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1246,6 +1246,7 @@ enum bpf_perf_event_type {
 #define BPF_F_AFTER		(1U << 4)
 #define BPF_F_ID		(1U << 5)
 #define BPF_F_PREORDER		(1U << 6)
+#define BPF_F_CGROUP_FD		(1U << 7)
 #define BPF_F_LINK		BPF_F_LINK /* 1 << 13 */
 
 /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
-- 
2.43.0


