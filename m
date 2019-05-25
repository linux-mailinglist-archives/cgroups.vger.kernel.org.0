Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E58D72A561
	for <lists+cgroups@lfdr.de>; Sat, 25 May 2019 18:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfEYQh7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 25 May 2019 12:37:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53628 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727178AbfEYQh6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 25 May 2019 12:37:58 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4PGYSKW030581
        for <cgroups@vger.kernel.org>; Sat, 25 May 2019 09:37:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=hEwoFaXVL/HglBrqsLOtogi6noPUZq4QBxwNtQ1Bp8g=;
 b=lvDzl8FPnHq9BSZzdc+4arJEGZznB6sUG8r37gLhmE36tBxiOQaPz+Hv0Ir/Ylb8UTCr
 tduwvBk3bvguPBkJUrMQy/isSFX7gqtR/m3w8R9sBXGgNokoXX3wJkj8Y2BIBCCaiOBz
 EGnBs/wCaNy2dHvd1LF0DpTDff9qgnzXGNQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sq3ee8p6s-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <cgroups@vger.kernel.org>; Sat, 25 May 2019 09:37:57 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 25 May 2019 09:37:55 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 2FEE2126D83B3; Sat, 25 May 2019 09:37:43 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Alexei Starovoitov <ast@kernel.org>, <bpf@vger.kernel.org>
CC:     Daniel Borkmann <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <cgroups@vger.kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Yonghong Song <yhs@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>, <jolsa@redhat.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v5 bpf-next 1/4] bpf: decouple the lifetime of cgroup_bpf from cgroup itself
Date:   Sat, 25 May 2019 09:37:39 -0700
Message-ID: <20190525163742.2616471-2-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190525163742.2616471-1-guro@fb.com>
References: <20190525163742.2616471-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=827 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905250117
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently the lifetime of bpf programs attached to a cgroup is bound
to the lifetime of the cgroup itself. It means that if a user
forgets (or intentionally avoids) to detach a bpf program before
removing the cgroup, it will stay attached up to the release of the
cgroup. Since the cgroup can stay in the dying state (the state
between being rmdir()'ed and being released) for a very long time, it
leads to a waste of memory. Also, it blocks a possibility to implement
the memcg-based memory accounting for bpf objects, because a circular
reference dependency will occur. Charged memory pages are pinning the
corresponding memory cgroup, and if the memory cgroup is pinning
the attached bpf program, nothing will be ever released.

A dying cgroup can not contain any processes, so the only chance for
an attached bpf program to be executed is a live socket associated
with the cgroup. So in order to release all bpf data early, let's
count associated sockets using a new percpu refcounter. On cgroup
removal the counter is transitioned to the atomic mode, and as soon
as it reaches 0, all bpf programs are detached.

Because cgroup_bpf_release() can block, it can't be called from
the percpu ref counter callback directly, so instead an asynchronous
work is scheduled.

The reference counter is not socket specific, and can be used for any
other types of programs, which can be executed from a cgroup-bpf hook
outside of the process context, had such a need arise in the future.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: jolsa@redhat.com
---
 include/linux/bpf-cgroup.h | 11 ++++++++--
 include/linux/cgroup.h     | 18 +++++++++++++++++
 kernel/bpf/cgroup.c        | 41 ++++++++++++++++++++++++++++++++++----
 kernel/cgroup/cgroup.c     | 11 +++++++---
 4 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index cb3c6b3b89c8..9f100fc422c3 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -6,6 +6,7 @@
 #include <linux/errno.h>
 #include <linux/jump_label.h>
 #include <linux/percpu.h>
+#include <linux/percpu-refcount.h>
 #include <linux/rbtree.h>
 #include <uapi/linux/bpf.h>
 
@@ -72,10 +73,16 @@ struct cgroup_bpf {
 
 	/* temp storage for effective prog array used by prog_attach/detach */
 	struct bpf_prog_array __rcu *inactive;
+
+	/* reference counter used to detach bpf programs after cgroup removal */
+	struct percpu_ref refcnt;
+
+	/* cgroup_bpf is released using a work queue */
+	struct work_struct release_work;
 };
 
-void cgroup_bpf_put(struct cgroup *cgrp);
 int cgroup_bpf_inherit(struct cgroup *cgrp);
+void cgroup_bpf_offline(struct cgroup *cgrp);
 
 int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 			enum bpf_attach_type type, u32 flags);
@@ -283,8 +290,8 @@ int cgroup_bpf_prog_query(const union bpf_attr *attr,
 
 struct bpf_prog;
 struct cgroup_bpf {};
-static inline void cgroup_bpf_put(struct cgroup *cgrp) {}
 static inline int cgroup_bpf_inherit(struct cgroup *cgrp) { return 0; }
+static inline void cgroup_bpf_offline(struct cgroup *cgrp) {}
 
 static inline int cgroup_bpf_prog_attach(const union bpf_attr *attr,
 					 enum bpf_prog_type ptype,
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index c0077adeea83..49e8facf7c4a 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -924,4 +924,22 @@ static inline bool cgroup_task_frozen(struct task_struct *task)
 
 #endif /* !CONFIG_CGROUPS */
 
+#ifdef CONFIG_CGROUP_BPF
+static inline void cgroup_bpf_get(struct cgroup *cgrp)
+{
+	percpu_ref_get(&cgrp->bpf.refcnt);
+}
+
+static inline void cgroup_bpf_put(struct cgroup *cgrp)
+{
+	percpu_ref_put(&cgrp->bpf.refcnt);
+}
+
+#else /* CONFIG_CGROUP_BPF */
+
+static inline void cgroup_bpf_get(struct cgroup *cgrp) {}
+static inline void cgroup_bpf_put(struct cgroup *cgrp) {}
+
+#endif /* CONFIG_CGROUP_BPF */
+
 #endif /* _LINUX_CGROUP_H */
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index fcde0f7b2585..d995edbe816d 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -22,12 +22,21 @@
 DEFINE_STATIC_KEY_FALSE(cgroup_bpf_enabled_key);
 EXPORT_SYMBOL(cgroup_bpf_enabled_key);
 
+void cgroup_bpf_offline(struct cgroup *cgrp)
+{
+	cgroup_get(cgrp);
+	percpu_ref_kill(&cgrp->bpf.refcnt);
+}
+
 /**
- * cgroup_bpf_put() - put references of all bpf programs
- * @cgrp: the cgroup to modify
+ * cgroup_bpf_release() - put references of all bpf programs and
+ *                        release all cgroup bpf data
+ * @work: work structure embedded into the cgroup to modify
  */
-void cgroup_bpf_put(struct cgroup *cgrp)
+static void cgroup_bpf_release(struct work_struct *work)
 {
+	struct cgroup *cgrp = container_of(work, struct cgroup,
+					   bpf.release_work);
 	enum bpf_cgroup_storage_type stype;
 	unsigned int type;
 
@@ -47,6 +56,22 @@ void cgroup_bpf_put(struct cgroup *cgrp)
 		}
 		bpf_prog_array_free(cgrp->bpf.effective[type]);
 	}
+
+	percpu_ref_exit(&cgrp->bpf.refcnt);
+	cgroup_put(cgrp);
+}
+
+/**
+ * cgroup_bpf_release_fn() - callback used to schedule releasing
+ *                           of bpf cgroup data
+ * @ref: percpu ref counter structure
+ */
+static void cgroup_bpf_release_fn(struct percpu_ref *ref)
+{
+	struct cgroup *cgrp = container_of(ref, struct cgroup, bpf.refcnt);
+
+	INIT_WORK(&cgrp->bpf.release_work, cgroup_bpf_release);
+	queue_work(system_wq, &cgrp->bpf.release_work);
 }
 
 /* count number of elements in the list.
@@ -167,7 +192,12 @@ int cgroup_bpf_inherit(struct cgroup *cgrp)
  */
 #define	NR ARRAY_SIZE(cgrp->bpf.effective)
 	struct bpf_prog_array __rcu *arrays[NR] = {};
-	int i;
+	int ret, i;
+
+	ret = percpu_ref_init(&cgrp->bpf.refcnt, cgroup_bpf_release_fn, 0,
+			      GFP_KERNEL);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < NR; i++)
 		INIT_LIST_HEAD(&cgrp->bpf.progs[i]);
@@ -183,6 +213,9 @@ int cgroup_bpf_inherit(struct cgroup *cgrp)
 cleanup:
 	for (i = 0; i < NR; i++)
 		bpf_prog_array_free(arrays[i]);
+
+	percpu_ref_exit(&cgrp->bpf.refcnt);
+
 	return -ENOMEM;
 }
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 217cec4e22c6..ef9cfbfc82a9 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4955,8 +4955,6 @@ static void css_release_work_fn(struct work_struct *work)
 		if (cgrp->kn)
 			RCU_INIT_POINTER(*(void __rcu __force **)&cgrp->kn->priv,
 					 NULL);
-
-		cgroup_bpf_put(cgrp);
 	}
 
 	mutex_unlock(&cgroup_mutex);
@@ -5482,6 +5480,8 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
 
 	cgroup1_check_for_release(parent);
 
+	cgroup_bpf_offline(cgrp);
+
 	/* put the base reference */
 	percpu_ref_kill(&cgrp->self.refcnt);
 
@@ -6221,6 +6221,7 @@ void cgroup_sk_alloc(struct sock_cgroup_data *skcd)
 		 * Don't use cgroup_get_live().
 		 */
 		cgroup_get(sock_cgroup_ptr(skcd));
+		cgroup_bpf_get(sock_cgroup_ptr(skcd));
 		return;
 	}
 
@@ -6232,6 +6233,7 @@ void cgroup_sk_alloc(struct sock_cgroup_data *skcd)
 		cset = task_css_set(current);
 		if (likely(cgroup_tryget(cset->dfl_cgrp))) {
 			skcd->val = (unsigned long)cset->dfl_cgrp;
+			cgroup_bpf_get(cset->dfl_cgrp);
 			break;
 		}
 		cpu_relax();
@@ -6242,7 +6244,10 @@ void cgroup_sk_alloc(struct sock_cgroup_data *skcd)
 
 void cgroup_sk_free(struct sock_cgroup_data *skcd)
 {
-	cgroup_put(sock_cgroup_ptr(skcd));
+	struct cgroup *cgrp = sock_cgroup_ptr(skcd);
+
+	cgroup_bpf_put(cgrp);
+	cgroup_put(cgrp);
 }
 
 #endif	/* CONFIG_SOCK_CGROUP_DATA */
-- 
2.21.0

