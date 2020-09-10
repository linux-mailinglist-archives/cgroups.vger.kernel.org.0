Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4ADD263CCA
	for <lists+cgroups@lfdr.de>; Thu, 10 Sep 2020 07:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgIJFyT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Sep 2020 01:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgIJFwS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Sep 2020 01:52:18 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CDBC061757
        for <cgroups@vger.kernel.org>; Wed,  9 Sep 2020 22:52:18 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t7so2476904pjd.3
        for <cgroups@vger.kernel.org>; Wed, 09 Sep 2020 22:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JhBvYsUMnScXaBA5KnUjCNRfXR+H5/aWPwXH05u5u10=;
        b=QMBMTVn1/0teJQBbE4s2cRDJzLUfflgfw51IBIi/7uOamKRUZGLzy1hFu2Z7u+XM9N
         zpdJMVvkwBzsAzd/rURxvizqhGeBQFWtEJstUun0YroG4nts7YlW2RTRItwID69AuHCd
         1MIEw4ZbMQ0aKCLcb1dvFmcnFIheN3J09dUD7R0T9la323uHYDabT+YQFkuPoWeEL3BE
         x9kt9q65YijGcWUT4/iMpmTL5DEIEg3yxZoWlElskWXF8jLtr2fFdR6FywlDtnE/Cnzx
         D6ACBpHxqji1e6VHFWzSldcean1NpnDbgvXEgAh8w6n5GazQjeZWACyR6T5bH57HkDY4
         AmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JhBvYsUMnScXaBA5KnUjCNRfXR+H5/aWPwXH05u5u10=;
        b=oHTdyIAENXNKHzapSks+OdwFsk7Z/xlMIgkokqUaQMNWEtBTo0+9rHyRi4CWsB35Oc
         AHqf3cGS+DkeidgpAw2MeDpdGqq8xl1k5UeKeCuHKVZl59RoYfBanEKTp+om1Z/WEmM5
         jth7Fc993ijL43MBhfnc2+aukDfdQNKR++KVcoD9/XXMhXv4Ue47V9lFU7YLtDofR1Al
         z9g/jNm0YXHjametvSdgkevYRKn6vLGvSle6OszsjUlW+mxmSSEahFZbvLTQL8NfNCqF
         5rFRLfqaF9JRF/xiDe/mhW5GT84RYapP83Sf9NGxLFqLZo8C0YOvg0fsP9j3pPp5j2d0
         gk8g==
X-Gm-Message-State: AOAM531Qv/E+LBsccyTx7smkRmZIl+ZktFiUrKyqU/s4GKtY9hi7qkwJ
        kRYLXy48jxu4uGXWdtWfDIeszw==
X-Google-Smtp-Source: ABdhPJwX0FSZMBqsN1Bw7Iw2/5GjJ5ww7IbtxIstM4kVt0iFQ8vZCWDlXYYi+jndCqe3T+RehQ0GFA==
X-Received: by 2002:a17:902:c410:: with SMTP id k16mr4130294plk.123.1599717137640;
        Wed, 09 Sep 2020 22:52:17 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([103.136.221.67])
        by smtp.gmail.com with ESMTPSA id t14sm3633590pgm.42.2020.09.09.22.52.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 22:52:17 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zhouchengming@bytedance.com, luodaowen.backend@bytedance.com
Subject: [PATCH] taskstats: fix CGROUPSTATS_CMD_GET for cgroup v2
Date:   Thu, 10 Sep 2020 13:52:07 +0800
Message-Id: <20200910055207.87702-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We found cgroupstats_build would return -EINVAL when using netlink
CGROUPSTATS_CMD_GET interface to get stats on cgroup v2. Fix it by
supporting cgroup v2 kernfs directory in cgroupstats_build, and export
cgroup2_fs_type like we did for cgroup_fs_type.

Reported-by: Daowen Luo <luodaowen.backend@bytedance.com>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/cgroup/cgroup-internal.h | 1 +
 kernel/cgroup/cgroup-v1.c       | 5 +++--
 kernel/cgroup/cgroup.c          | 3 +--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index bfbeabc17a9d..9ca05fb513c2 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -151,6 +151,7 @@ extern spinlock_t css_set_lock;
 extern struct cgroup_subsys *cgroup_subsys[];
 extern struct list_head cgroup_roots;
 extern struct file_system_type cgroup_fs_type;
+extern struct file_system_type cgroup2_fs_type;
 
 /* iterate across the hierarchies */
 #define for_each_root(root)						\
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 191c329e482a..6d9e9b553276 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -686,13 +686,14 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
 int cgroupstats_build(struct cgroupstats *stats, struct dentry *dentry)
 {
 	struct kernfs_node *kn = kernfs_node_from_dentry(dentry);
+	struct file_system_type *s_type = dentry->d_sb->s_type;
 	struct cgroup *cgrp;
 	struct css_task_iter it;
 	struct task_struct *tsk;
 
 	/* it should be kernfs_node belonging to cgroupfs and is a directory */
-	if (dentry->d_sb->s_type != &cgroup_fs_type || !kn ||
-	    kernfs_type(kn) != KERNFS_DIR)
+	if ((s_type != &cgroup_fs_type && s_type != &cgroup2_fs_type) ||
+	    !kn || kernfs_type(kn) != KERNFS_DIR)
 		return -EINVAL;
 
 	mutex_lock(&cgroup_mutex);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index dd247747ec14..0e23ae3b1e56 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -206,7 +206,6 @@ struct cgroup_namespace init_cgroup_ns = {
 	.root_cset	= &init_css_set,
 };
 
-static struct file_system_type cgroup2_fs_type;
 static struct cftype cgroup_base_files[];
 
 static int cgroup_apply_control(struct cgroup *cgrp);
@@ -2162,7 +2161,7 @@ struct file_system_type cgroup_fs_type = {
 	.fs_flags		= FS_USERNS_MOUNT,
 };
 
-static struct file_system_type cgroup2_fs_type = {
+struct file_system_type cgroup2_fs_type = {
 	.name			= "cgroup2",
 	.init_fs_context	= cgroup_init_fs_context,
 	.parameters		= cgroup2_fs_parameters,
-- 
2.11.0

