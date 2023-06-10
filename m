Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445EC72A8F5
	for <lists+cgroups@lfdr.de>; Sat, 10 Jun 2023 05:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjFJD56 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Jun 2023 23:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjFJD55 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Jun 2023 23:57:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D063A8C;
        Fri,  9 Jun 2023 20:57:56 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QdPJ86Jj0zLmly;
        Sat, 10 Jun 2023 11:56:08 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 10 Jun
 2023 11:57:54 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <tj@kernel.org>, <hannes@cmpxchg.org>, <lizefan.x@bytedance.com>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] cgroup: remove unused task_cgroup_path()
Date:   Sat, 10 Jun 2023 11:57:37 +0800
Message-ID: <20230610035737.1046651-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

task_cgroup_path() is not used anymore. So remove it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/cgroup.h |  1 -
 kernel/cgroup/cgroup.c | 39 ---------------------------------------
 2 files changed, 40 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 567c547cf371..b307013b9c6c 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -118,7 +118,6 @@ int cgroup_rm_cftypes(struct cftype *cfts);
 void cgroup_file_notify(struct cgroup_file *cfile);
 void cgroup_file_show(struct cgroup_file *cfile, bool show);
 
-int task_cgroup_path(struct task_struct *task, char *buf, size_t buflen);
 int cgroupstats_build(struct cgroupstats *stats, struct dentry *dentry);
 int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 		     struct pid *pid, struct task_struct *tsk);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index d0d033a48f61..48278adb7522 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2364,45 +2364,6 @@ int cgroup_path_ns(struct cgroup *cgrp, char *buf, size_t buflen,
 }
 EXPORT_SYMBOL_GPL(cgroup_path_ns);
 
-/**
- * task_cgroup_path - cgroup path of a task in the first cgroup hierarchy
- * @task: target task
- * @buf: the buffer to write the path into
- * @buflen: the length of the buffer
- *
- * Determine @task's cgroup on the first (the one with the lowest non-zero
- * hierarchy_id) cgroup hierarchy and copy its path into @buf.  This
- * function grabs cgroup_mutex and shouldn't be used inside locks used by
- * cgroup controller callbacks.
- *
- * Return value is the same as kernfs_path().
- */
-int task_cgroup_path(struct task_struct *task, char *buf, size_t buflen)
-{
-	struct cgroup_root *root;
-	struct cgroup *cgrp;
-	int hierarchy_id = 1;
-	int ret;
-
-	cgroup_lock();
-	spin_lock_irq(&css_set_lock);
-
-	root = idr_get_next(&cgroup_hierarchy_idr, &hierarchy_id);
-
-	if (root) {
-		cgrp = task_cgroup_from_root(task, root);
-		ret = cgroup_path_ns_locked(cgrp, buf, buflen, &init_cgroup_ns);
-	} else {
-		/* if no hierarchy exists, everyone is in "/" */
-		ret = strscpy(buf, "/", buflen);
-	}
-
-	spin_unlock_irq(&css_set_lock);
-	cgroup_unlock();
-	return ret;
-}
-EXPORT_SYMBOL_GPL(task_cgroup_path);
-
 /**
  * cgroup_attach_lock - Lock for ->attach()
  * @lock_threadgroup: whether to down_write cgroup_threadgroup_rwsem
-- 
2.27.0

