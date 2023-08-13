Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A05277898E
	for <lists+cgroups@lfdr.de>; Fri, 11 Aug 2023 11:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbjHKJQb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Aug 2023 05:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjHKJQ0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Aug 2023 05:16:26 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id EFDEB2D5B;
        Fri, 11 Aug 2023 02:16:24 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 46D96605E83D9;
        Fri, 11 Aug 2023 17:16:15 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li kunyu <kunyu@nfschina.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] =?UTF-8?q?cgroup:=20cgroup:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=980=E2=80=99=20values=20from=20ret?=
Date:   Sun, 13 Aug 2023 09:47:34 +0800
Message-Id: <20230813014734.2916-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ret is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 kernel/cgroup/cgroup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index f55a40db065f..cdda2a147d6b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2859,7 +2859,7 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 {
 	DEFINE_CGROUP_MGCTX(mgctx);
 	struct task_struct *task;
-	int ret = 0;
+	int ret;
 
 	/* look up all src csets */
 	spin_lock_irq(&css_set_lock);
@@ -3945,7 +3945,7 @@ static void cgroup_kill(struct cgroup *cgrp)
 static ssize_t cgroup_kill_write(struct kernfs_open_file *of, char *buf,
 				 size_t nbytes, loff_t off)
 {
-	ssize_t ret = 0;
+	ssize_t ret;
 	int kill;
 	struct cgroup *cgrp;
 
@@ -5083,7 +5083,7 @@ static int cgroup_attach_permissions(struct cgroup *src_cgrp,
 				     struct super_block *sb, bool threadgroup,
 				     struct cgroup_namespace *ns)
 {
-	int ret = 0;
+	int ret;
 
 	ret = cgroup_procs_write_permission(src_cgrp, dst_cgrp, sb, ns);
 	if (ret)
@@ -5921,7 +5921,7 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
 int cgroup_rmdir(struct kernfs_node *kn)
 {
 	struct cgroup *cgrp;
-	int ret = 0;
+	int ret;
 
 	cgrp = cgroup_kn_lock_live(kn, false);
 	if (!cgrp)
@@ -6995,7 +6995,7 @@ static ssize_t delegate_show(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	struct cgroup_subsys *ss;
 	int ssid;
-	ssize_t ret = 0;
+	ssize_t ret;
 
 	ret = show_delegatable_files(cgroup_base_files, buf + ret,
 				     PAGE_SIZE - ret, NULL);
-- 
2.18.2

