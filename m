Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D064881E1
	for <lists+cgroups@lfdr.de>; Sat,  8 Jan 2022 07:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiAHGiQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 8 Jan 2022 01:38:16 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:59045 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229913AbiAHGiQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 8 Jan 2022 01:38:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V1E-qCD_1641623893;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V1E-qCD_1641623893)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 08 Jan 2022 14:38:14 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tj@kernel.org
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] cgroup: Fix cgroup_can_fork() and cgroup_post_fork() kernel-doc comment
Date:   Sat,  8 Jan 2022 14:38:12 +0800
Message-Id: <20220108063812.50370-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add the description of @kargs in cgroup_can_fork() and
cgroup_post_fork() kernel-doc comment to remove warnings found
by running scripts/kernel-doc, which is caused by using 'make W=1'.

kernel/cgroup/cgroup.c:6235: warning: Function parameter or member
'kargs' not described in 'cgroup_can_fork'
kernel/cgroup/cgroup.c:6296: warning: Function parameter or member
'kargs' not described in 'cgroup_post_fork'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/cgroup/cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b31e1465868a..37c49e1a672f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6224,6 +6224,7 @@ static void cgroup_css_set_put_fork(struct kernel_clone_args *kargs)
 /**
  * cgroup_can_fork - called on a new task before the process is exposed
  * @child: the child process
+ * @kargs: the arguments passed to create the child process
  *
  * This prepares a new css_set for the child process which the child will
  * be attached to in cgroup_post_fork().
@@ -6286,6 +6287,7 @@ void cgroup_cancel_fork(struct task_struct *child,
 /**
  * cgroup_post_fork - finalize cgroup setup for the child process
  * @child: the child process
+ * @kargs: the arguments passed to create the child process
  *
  * Attach the child process to its css_set calling the subsystem fork()
  * callbacks.
-- 
2.20.1.7.g153144c

