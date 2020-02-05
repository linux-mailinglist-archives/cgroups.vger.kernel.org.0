Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C702A1531C8
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2020 14:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgBEN0t (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Feb 2020 08:26:49 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56954 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgBEN0r (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Feb 2020 08:26:47 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1izKhZ-00035h-4u; Wed, 05 Feb 2020 13:26:45 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH v6 2/6] cgroup: add cgroup_get_from_file() helper
Date:   Wed,  5 Feb 2020 14:26:19 +0100
Message-Id: <20200205132623.670015-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200205132623.670015-1-christian.brauner@ubuntu.com>
References: <20200205132623.670015-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add a helper cgroup_get_from_file(). The helper will be used in
subsequent patches to retrieve a cgroup while holding a reference to the
struct file it was taken from.

Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: cgroups@vger.kernel.org
Acked-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v1 */
patch not present

/* v2 */
patch not present

/* v3 */
Link: https://lore.kernel.org/r/20200117002143.15559-3-christian.brauner@ubuntu.com
patch introduced
- Tejun Heo <tj@kernel.org>:
  - split cgroup_get_from_file() changes into separate commmit

/* v4 */
Link: https://lore.kernel.org/r/20200117181219.14542-3-christian.brauner@ubuntu.com
unchanged

/* v5 */
Link: https://lore.kernel.org/r/20200121154844.411-3-christian.brauner@ubuntu.com
unchanged

/* v6 */
unchanged
- Christian Brauner <christian.brauner@ubuntu.com>:
  - add Acked-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 5f84177e2065..7c1c8677849e 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5875,6 +5875,24 @@ void cgroup_fork(struct task_struct *child)
 	INIT_LIST_HEAD(&child->cg_list);
 }
 
+static struct cgroup *cgroup_get_from_file(struct file *f)
+{
+	struct cgroup_subsys_state *css;
+	struct cgroup *cgrp;
+
+	css = css_tryget_online_from_dir(f->f_path.dentry, NULL);
+	if (IS_ERR(css))
+		return ERR_CAST(css);
+
+	cgrp = css->cgroup;
+	if (!cgroup_on_dfl(cgrp)) {
+		cgroup_put(cgrp);
+		return ERR_PTR(-EBADF);
+	}
+
+	return cgrp;
+}
+
 /**
  * cgroup_can_fork - called on a new task before the process is exposed
  * @child: the task in question.
@@ -6163,7 +6181,6 @@ EXPORT_SYMBOL_GPL(cgroup_get_from_path);
  */
 struct cgroup *cgroup_get_from_fd(int fd)
 {
-	struct cgroup_subsys_state *css;
 	struct cgroup *cgrp;
 	struct file *f;
 
@@ -6171,17 +6188,8 @@ struct cgroup *cgroup_get_from_fd(int fd)
 	if (!f)
 		return ERR_PTR(-EBADF);
 
-	css = css_tryget_online_from_dir(f->f_path.dentry, NULL);
+	cgrp = cgroup_get_from_file(f);
 	fput(f);
-	if (IS_ERR(css))
-		return ERR_CAST(css);
-
-	cgrp = css->cgroup;
-	if (!cgroup_on_dfl(cgrp)) {
-		cgroup_put(cgrp);
-		return ERR_PTR(-EBADF);
-	}
-
 	return cgrp;
 }
 EXPORT_SYMBOL_GPL(cgroup_get_from_fd);
-- 
2.25.0

