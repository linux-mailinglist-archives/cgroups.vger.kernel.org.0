Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07055476860
	for <lists+cgroups@lfdr.de>; Thu, 16 Dec 2021 03:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbhLPCzp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Dec 2021 21:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbhLPCzp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Dec 2021 21:55:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4B8C061574;
        Wed, 15 Dec 2021 18:55:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EB7B61BF7;
        Thu, 16 Dec 2021 02:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591ADC36AEE;
        Thu, 16 Dec 2021 02:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639623343;
        bh=2/LJwvJ0GMsKI+/4k7k587C4NMuPp8DFFYNp1vhg2TE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rgm4bXynjKy1OQtDozeJhmK3x/Ey+yEwxfmuDlJH/NzQqzFTVti+6We9gjx0BpYzi
         iQZSYa3kCPybhKweV97L312CIuny1VUjtQ9cR9J1laXifEP2uLZyO38RRg205QP5em
         PG1O2zRisyU11Z+qBtC50R0hBNic+a5+XibvHsKAL91Sk95jzv30SDQo1vXCQANjoH
         Wjk2ot6jwmCqceS6ID7teNaEtEOIz6YDXx5Jtz+9RdmwW0FueYqrxEPoG8KzDtoIs3
         /a+TXUnQWCxMANchu9fvVZ+nyt8ZTHEiYn2zP88veE9tk25FT9Y7EHGDl8JrLM1G6Y
         jHpEwsgNaiX8Q==
From:   Jakub Kicinski <kuba@kernel.org>
To:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Tejun Heo <tj@kernel.org>, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org
Subject: [PATCH bpf-next v5 3/3] bpf: remove the cgroup -> bpf header dependecy
Date:   Wed, 15 Dec 2021 18:55:38 -0800
Message-Id: <20211216025538.1649516-4-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216025538.1649516-1-kuba@kernel.org>
References: <20211216025538.1649516-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Remove the dependency from cgroup-defs.h to bpf-cgroup.h and bpf.h.
This reduces the incremental build size of x86 allmodconfig after
bpf.h was touched from ~17k objects rebuilt to ~5k objects.
bpf.h is 2.2kLoC and is modified relatively often.

We need a new header with just the definition of struct cgroup_bpf
and enum cgroup_bpf_attach_type, this is akin to cgroup-defs.h.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: ast@kernel.org
CC: daniel@iogearbox.net
CC: andrii@kernel.org
CC: kafai@fb.com
CC: songliubraving@fb.com
CC: yhs@fb.com
CC: john.fastabend@gmail.com
CC: kpsingh@kernel.org
CC: lizefan.x@bytedance.com
CC: hannes@cmpxchg.org
CC: bpf@vger.kernel.org
CC: cgroups@vger.kernel.org
---
 include/linux/bpf-cgroup-defs.h | 70 +++++++++++++++++++++++++++++++++
 include/linux/bpf-cgroup.h      | 57 +--------------------------
 include/linux/cgroup-defs.h     |  2 +-
 3 files changed, 72 insertions(+), 57 deletions(-)
 create mode 100644 include/linux/bpf-cgroup-defs.h

diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
new file mode 100644
index 000000000000..695d1224a71b
--- /dev/null
+++ b/include/linux/bpf-cgroup-defs.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BPF_CGROUP_DEFS_H
+#define _BPF_CGROUP_DEFS_H
+
+#ifdef CONFIG_CGROUP_BPF
+
+#include <linux/list.h>
+#include <linux/percpu-refcount.h>
+#include <linux/workqueue.h>
+
+struct bpf_prog_array;
+
+enum cgroup_bpf_attach_type {
+	CGROUP_BPF_ATTACH_TYPE_INVALID = -1,
+	CGROUP_INET_INGRESS = 0,
+	CGROUP_INET_EGRESS,
+	CGROUP_INET_SOCK_CREATE,
+	CGROUP_SOCK_OPS,
+	CGROUP_DEVICE,
+	CGROUP_INET4_BIND,
+	CGROUP_INET6_BIND,
+	CGROUP_INET4_CONNECT,
+	CGROUP_INET6_CONNECT,
+	CGROUP_INET4_POST_BIND,
+	CGROUP_INET6_POST_BIND,
+	CGROUP_UDP4_SENDMSG,
+	CGROUP_UDP6_SENDMSG,
+	CGROUP_SYSCTL,
+	CGROUP_UDP4_RECVMSG,
+	CGROUP_UDP6_RECVMSG,
+	CGROUP_GETSOCKOPT,
+	CGROUP_SETSOCKOPT,
+	CGROUP_INET4_GETPEERNAME,
+	CGROUP_INET6_GETPEERNAME,
+	CGROUP_INET4_GETSOCKNAME,
+	CGROUP_INET6_GETSOCKNAME,
+	CGROUP_INET_SOCK_RELEASE,
+	MAX_CGROUP_BPF_ATTACH_TYPE
+};
+
+struct cgroup_bpf {
+	/* array of effective progs in this cgroup */
+	struct bpf_prog_array __rcu *effective[MAX_CGROUP_BPF_ATTACH_TYPE];
+
+	/* attached progs to this cgroup and attach flags
+	 * when flags == 0 or BPF_F_ALLOW_OVERRIDE the progs list will
+	 * have either zero or one element
+	 * when BPF_F_ALLOW_MULTI the list can have up to BPF_CGROUP_MAX_PROGS
+	 */
+	struct list_head progs[MAX_CGROUP_BPF_ATTACH_TYPE];
+	u32 flags[MAX_CGROUP_BPF_ATTACH_TYPE];
+
+	/* list of cgroup shared storages */
+	struct list_head storages;
+
+	/* temp storage for effective prog array used by prog_attach/detach */
+	struct bpf_prog_array *inactive;
+
+	/* reference counter used to detach bpf programs after cgroup removal */
+	struct percpu_ref refcnt;
+
+	/* cgroup_bpf is released using a work queue */
+	struct work_struct release_work;
+};
+
+#else /* CONFIG_CGROUP_BPF */
+struct cgroup_bpf {};
+#endif /* CONFIG_CGROUP_BPF */
+
+#endif
diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 11820a430d6c..b525d8cdc25b 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -3,10 +3,10 @@
 #define _BPF_CGROUP_H
 
 #include <linux/bpf.h>
+#include <linux/bpf-cgroup-defs.h>
 #include <linux/errno.h>
 #include <linux/jump_label.h>
 #include <linux/percpu.h>
-#include <linux/percpu-refcount.h>
 #include <linux/rbtree.h>
 #include <uapi/linux/bpf.h>
 
@@ -23,33 +23,6 @@ struct ctl_table_header;
 struct task_struct;
 
 #ifdef CONFIG_CGROUP_BPF
-enum cgroup_bpf_attach_type {
-	CGROUP_BPF_ATTACH_TYPE_INVALID = -1,
-	CGROUP_INET_INGRESS = 0,
-	CGROUP_INET_EGRESS,
-	CGROUP_INET_SOCK_CREATE,
-	CGROUP_SOCK_OPS,
-	CGROUP_DEVICE,
-	CGROUP_INET4_BIND,
-	CGROUP_INET6_BIND,
-	CGROUP_INET4_CONNECT,
-	CGROUP_INET6_CONNECT,
-	CGROUP_INET4_POST_BIND,
-	CGROUP_INET6_POST_BIND,
-	CGROUP_UDP4_SENDMSG,
-	CGROUP_UDP6_SENDMSG,
-	CGROUP_SYSCTL,
-	CGROUP_UDP4_RECVMSG,
-	CGROUP_UDP6_RECVMSG,
-	CGROUP_GETSOCKOPT,
-	CGROUP_SETSOCKOPT,
-	CGROUP_INET4_GETPEERNAME,
-	CGROUP_INET6_GETPEERNAME,
-	CGROUP_INET4_GETSOCKNAME,
-	CGROUP_INET6_GETSOCKNAME,
-	CGROUP_INET_SOCK_RELEASE,
-	MAX_CGROUP_BPF_ATTACH_TYPE
-};
 
 #define CGROUP_ATYPE(type) \
 	case BPF_##type: return type
@@ -127,33 +100,6 @@ struct bpf_prog_list {
 	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE];
 };
 
-struct bpf_prog_array;
-
-struct cgroup_bpf {
-	/* array of effective progs in this cgroup */
-	struct bpf_prog_array __rcu *effective[MAX_CGROUP_BPF_ATTACH_TYPE];
-
-	/* attached progs to this cgroup and attach flags
-	 * when flags == 0 or BPF_F_ALLOW_OVERRIDE the progs list will
-	 * have either zero or one element
-	 * when BPF_F_ALLOW_MULTI the list can have up to BPF_CGROUP_MAX_PROGS
-	 */
-	struct list_head progs[MAX_CGROUP_BPF_ATTACH_TYPE];
-	u32 flags[MAX_CGROUP_BPF_ATTACH_TYPE];
-
-	/* list of cgroup shared storages */
-	struct list_head storages;
-
-	/* temp storage for effective prog array used by prog_attach/detach */
-	struct bpf_prog_array *inactive;
-
-	/* reference counter used to detach bpf programs after cgroup removal */
-	struct percpu_ref refcnt;
-
-	/* cgroup_bpf is released using a work queue */
-	struct work_struct release_work;
-};
-
 int cgroup_bpf_inherit(struct cgroup *cgrp);
 void cgroup_bpf_offline(struct cgroup *cgrp);
 
@@ -451,7 +397,6 @@ int cgroup_bpf_prog_query(const union bpf_attr *attr,
 			  union bpf_attr __user *uattr);
 #else
 
-struct cgroup_bpf {};
 static inline int cgroup_bpf_inherit(struct cgroup *cgrp) { return 0; }
 static inline void cgroup_bpf_offline(struct cgroup *cgrp) {}
 
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index db2e147e069f..411684c80cf3 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -19,7 +19,7 @@
 #include <linux/percpu-rwsem.h>
 #include <linux/u64_stats_sync.h>
 #include <linux/workqueue.h>
-#include <linux/bpf-cgroup.h>
+#include <linux/bpf-cgroup-defs.h>
 #include <linux/psi_types.h>
 
 #ifdef CONFIG_CGROUPS
-- 
2.31.1

