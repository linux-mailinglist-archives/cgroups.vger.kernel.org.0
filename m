Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A40B3141087
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2020 19:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgAQSMa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Jan 2020 13:12:30 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52144 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbgAQSM3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Jan 2020 13:12:29 -0500
Received: from ip5f5bd679.dynamic.kabel-deutschland.de ([95.91.214.121] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1isW6d-0005Yu-DN; Fri, 17 Jan 2020 18:12:27 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org
Subject: [PATCH v4 4/6] cgroup: add cgroup_may_write() helper
Date:   Fri, 17 Jan 2020 19:12:17 +0100
Message-Id: <20200117181219.14542-5-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200117181219.14542-1-christian.brauner@ubuntu.com>
References: <20200117181219.14542-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add a cgroup_may_write() helper which we can use in the
CLONE_INTO_CGROUP patch series to verify that we can write to the
destination cgroup.

Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: cgroups@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v1 */
patch not present

/* v2 */
patch not present

/* v3 */
patch not present

/* v4 */
patch introduced
---
 kernel/cgroup/cgroup.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 49d8cf087e10..b110b435ae49 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4649,13 +4649,28 @@ static int cgroup_procs_show(struct seq_file *s, void *v)
 	return 0;
 }
 
+static int cgroup_may_write(const struct cgroup *cgrp, struct super_block *sb)
+{
+	int ret;
+	struct inode *inode;
+
+	lockdep_assert_held(&cgroup_mutex);
+
+	inode = kernfs_get_inode(sb, cgrp->procs_file.kn);
+	if (!inode)
+		return -ENOMEM;
+
+	ret = inode_permission(inode, MAY_WRITE);
+	iput(inode);
+	return ret;
+}
+
 static int cgroup_procs_write_permission(struct cgroup *src_cgrp,
 					 struct cgroup *dst_cgrp,
 					 struct super_block *sb)
 {
 	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
 	struct cgroup *com_cgrp = src_cgrp;
-	struct inode *inode;
 	int ret;
 
 	lockdep_assert_held(&cgroup_mutex);
@@ -4665,12 +4680,7 @@ static int cgroup_procs_write_permission(struct cgroup *src_cgrp,
 		com_cgrp = cgroup_parent(com_cgrp);
 
 	/* %current should be authorized to migrate to the common ancestor */
-	inode = kernfs_get_inode(sb, com_cgrp->procs_file.kn);
-	if (!inode)
-		return -ENOMEM;
-
-	ret = inode_permission(inode, MAY_WRITE);
-	iput(inode);
+	ret = cgroup_may_write(com_cgrp, sb);
 	if (ret)
 		return ret;
 
-- 
2.25.0

