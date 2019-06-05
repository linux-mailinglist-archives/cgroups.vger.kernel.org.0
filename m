Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 241BA35DFF
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2019 15:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfFENh4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jun 2019 09:37:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56080 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfFENhz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Jun 2019 09:37:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x55DTE1i119488;
        Wed, 5 Jun 2019 13:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=u+zLCba4ifvorqHECxdb8NWOVORyLACPhu1rUxGfaiU=;
 b=04/ccSPIDB9rw0yaqtcHi0KxfYmVhroln6GrxIIJzj+KGMwFDFX7hLTbB5o3fTLxBF89
 f6L2rcGShr+HLDMtx402CIThkjTlkqOfuo5U4Vd+MJrso7BezPsVTOmqkth7JJQ+RTEc
 kb14qh1piCluKWghlyGA2hLFa4230l30Vnc3+2m6xnNZIVg07MSAiWxocE7bA/4j0m0+
 TK9uMGn+1S+nIxB5mvY6N/WRTOKYBwl3FYzT/tWQhVUECUikgTVXITWKP/BEzEeEU74+
 6ZJYd4KTUVHwSCKtYk7FLDVi+4/BwJsFLksq3zUNl7MKDZf0qHnUIp/9vO+eJvVWqjYF RA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2sugstjn49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 13:37:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x55DZsPL069366;
        Wed, 5 Jun 2019 13:37:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2swnghw2j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 13:37:08 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x55Db0GP027121;
        Wed, 5 Jun 2019 13:37:01 GMT
Received: from localhost.localdomain (/73.60.114.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Jun 2019 06:37:00 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     hannes@cmpxchg.org, jiangshanlai@gmail.com, lizefan@huawei.com,
        tj@kernel.org
Cc:     bsd@redhat.com, dan.j.williams@intel.com,
        daniel.m.jordan@oracle.com, dave.hansen@intel.com,
        juri.lelli@redhat.com, mhocko@kernel.org, peterz@infradead.org,
        steven.sistare@oracle.com, tglx@linutronix.de,
        tom.hromatka@oracle.com, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC v2 1/5] cgroup: add cgroup v2 interfaces to migrate kernel threads
Date:   Wed,  5 Jun 2019 09:36:46 -0400
Message-Id: <20190605133650.28545-2-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605133650.28545-1-daniel.m.jordan@oracle.com>
References: <20190605133650.28545-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=870
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906050087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=902 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906050087
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Prepare for cgroup aware workqueues by introducing cgroup_attach_kthread
and a helper cgroup_attach_kthread_to_dfl_root.

A workqueue worker will always migrate itself, so for now use @current
in the interfaces to avoid handling task references.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 include/linux/cgroup.h |  6 ++++++
 kernel/cgroup/cgroup.c | 48 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 81f58b4a5418..ad78784e3692 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -103,6 +103,7 @@ struct cgroup_subsys_state *css_tryget_online_from_dir(struct dentry *dentry,
 struct cgroup *cgroup_get_from_path(const char *path);
 struct cgroup *cgroup_get_from_fd(int fd);
 
+int cgroup_attach_kthread(struct cgroup *dst_cgrp);
 int cgroup_attach_task_all(struct task_struct *from, struct task_struct *);
 int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from);
 
@@ -530,6 +531,11 @@ static inline struct cgroup *task_dfl_cgroup(struct task_struct *task)
 	return task_css_set(task)->dfl_cgrp;
 }
 
+static inline int cgroup_attach_kthread_to_dfl_root(void)
+{
+	return cgroup_attach_kthread(&cgrp_dfl_root.cgrp);
+}
+
 static inline struct cgroup *cgroup_parent(struct cgroup *cgrp)
 {
 	struct cgroup_subsys_state *parent_css = cgrp->self.parent;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 3f2b4bde0f9c..bc8d6a2e529f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2771,21 +2771,59 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup)
 	return tsk;
 }
 
-void cgroup_procs_write_finish(struct task_struct *task)
-	__releases(&cgroup_threadgroup_rwsem)
+static void __cgroup_procs_write_finish(struct task_struct *task)
 {
 	struct cgroup_subsys *ss;
 	int ssid;
 
-	/* release reference from cgroup_procs_write_start() */
-	put_task_struct(task);
+	lockdep_assert_held(&cgroup_mutex);
 
-	percpu_up_write(&cgroup_threadgroup_rwsem);
 	for_each_subsys(ss, ssid)
 		if (ss->post_attach)
 			ss->post_attach();
 }
 
+void cgroup_procs_write_finish(struct task_struct *task)
+	__releases(&cgroup_threadgroup_rwsem)
+{
+	lockdep_assert_held(&cgroup_mutex);
+
+	/* release reference from cgroup_procs_write_start() */
+	put_task_struct(task);
+
+	percpu_up_write(&cgroup_threadgroup_rwsem);
+	__cgroup_procs_write_finish(task);
+}
+
+/**
+ * cgroup_attach_kthread - attach the current kernel thread to a cgroup
+ * @dst_cgrp: the cgroup to attach to
+ *
+ * The caller is responsible for ensuring @dst_cgrp is valid until this
+ * function returns.
+ *
+ * Return: 0 on success or negative error code.
+ */
+int cgroup_attach_kthread(struct cgroup *dst_cgrp)
+{
+	int ret;
+
+	if (WARN_ON_ONCE(!(current->flags & PF_KTHREAD)))
+		return -EINVAL;
+
+	mutex_lock(&cgroup_mutex);
+
+	percpu_down_write(&cgroup_threadgroup_rwsem);
+	ret = cgroup_attach_task(dst_cgrp, current, false);
+	percpu_up_write(&cgroup_threadgroup_rwsem);
+
+	__cgroup_procs_write_finish(current);
+
+	mutex_unlock(&cgroup_mutex);
+
+	return ret;
+}
+
 static void cgroup_print_ss_mask(struct seq_file *seq, u16 ss_mask)
 {
 	struct cgroup_subsys *ss;
-- 
2.21.0

