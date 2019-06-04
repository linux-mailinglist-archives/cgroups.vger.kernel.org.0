Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2C0F33CF3
	for <lists+cgroups@lfdr.de>; Tue,  4 Jun 2019 03:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfFDB63 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Jun 2019 21:58:29 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:36020 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726076AbfFDB63 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Jun 2019 21:58:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TTN908l_1559613506;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TTN908l_1559613506)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Jun 2019 09:58:27 +0800
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org,
        Tejun Heo <tj@kernel.org>,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Caspar Zhang <caspar@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [RFC PATCH 1/3] psi: make cgroup psi helpers public
Date:   Tue,  4 Jun 2019 09:57:43 +0800
Message-Id: <20190604015745.78972-2-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190604015745.78972-1-joseph.qi@linux.alibaba.com>
References: <20190604015745.78972-1-joseph.qi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Make cgroup psi helpers public for later cgroup v1 support.

Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 include/linux/cgroup.h | 21 +++++++++++++++++++++
 kernel/cgroup/cgroup.c | 33 ++++++++++++++++++---------------
 2 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index c0077adeea83..a5adb98490c9 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -682,6 +682,27 @@ static inline union kernfs_node_id *cgroup_get_kernfs_id(struct cgroup *cgrp)
 
 void cgroup_path_from_kernfs_id(const union kernfs_node_id *id,
 					char *buf, size_t buflen);
+
+#ifdef CONFIG_PSI
+int cgroup_io_pressure_show(struct seq_file *seq, void *v);
+int cgroup_memory_pressure_show(struct seq_file *seq, void *v);
+int cgroup_cpu_pressure_show(struct seq_file *seq, void *v);
+
+ssize_t cgroup_io_pressure_write(struct kernfs_open_file *of,
+				 char *buf, size_t nbytes,
+				 loff_t off);
+ssize_t cgroup_memory_pressure_write(struct kernfs_open_file *of,
+				     char *buf, size_t nbytes,
+				     loff_t off);
+ssize_t cgroup_cpu_pressure_write(struct kernfs_open_file *of,
+				  char *buf, size_t nbytes,
+				  loff_t off);
+
+__poll_t cgroup_pressure_poll(struct kernfs_open_file *of,
+			      struct poll_table_struct *pt);
+void cgroup_pressure_release(struct kernfs_open_file *of);
+#endif /* CONFIG_PSI */
+
 #else /* !CONFIG_CGROUPS */
 
 struct cgroup_subsys_state;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 426a0026225c..cd3207454f8c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3550,21 +3550,23 @@ static int cpu_stat_show(struct seq_file *seq, void *v)
 }
 
 #ifdef CONFIG_PSI
-static int cgroup_io_pressure_show(struct seq_file *seq, void *v)
+int cgroup_io_pressure_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgroup = seq_css(seq)->cgroup;
 	struct psi_group *psi = cgroup->id == 1 ? &psi_system : &cgroup->psi;
 
 	return psi_show(seq, psi, PSI_IO);
 }
-static int cgroup_memory_pressure_show(struct seq_file *seq, void *v)
+
+int cgroup_memory_pressure_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgroup = seq_css(seq)->cgroup;
 	struct psi_group *psi = cgroup->id == 1 ? &psi_system : &cgroup->psi;
 
 	return psi_show(seq, psi, PSI_MEM);
 }
-static int cgroup_cpu_pressure_show(struct seq_file *seq, void *v)
+
+int cgroup_cpu_pressure_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgroup = seq_css(seq)->cgroup;
 	struct psi_group *psi = cgroup->id == 1 ? &psi_system : &cgroup->psi;
@@ -3598,34 +3600,35 @@ static ssize_t cgroup_pressure_write(struct kernfs_open_file *of, char *buf,
 	return nbytes;
 }
 
-static ssize_t cgroup_io_pressure_write(struct kernfs_open_file *of,
-					  char *buf, size_t nbytes,
-					  loff_t off)
+ssize_t cgroup_io_pressure_write(struct kernfs_open_file *of,
+				 char *buf, size_t nbytes,
+				 loff_t off)
 {
 	return cgroup_pressure_write(of, buf, nbytes, PSI_IO);
 }
 
-static ssize_t cgroup_memory_pressure_write(struct kernfs_open_file *of,
-					  char *buf, size_t nbytes,
-					  loff_t off)
+ssize_t cgroup_memory_pressure_write(struct kernfs_open_file *of,
+				     char *buf, size_t nbytes,
+				     loff_t off)
 {
 	return cgroup_pressure_write(of, buf, nbytes, PSI_MEM);
 }
 
-static ssize_t cgroup_cpu_pressure_write(struct kernfs_open_file *of,
-					  char *buf, size_t nbytes,
-					  loff_t off)
+ssize_t cgroup_cpu_pressure_write(struct kernfs_open_file *of,
+				  char *buf, size_t nbytes,
+				  loff_t off)
 {
 	return cgroup_pressure_write(of, buf, nbytes, PSI_CPU);
 }
 
-static __poll_t cgroup_pressure_poll(struct kernfs_open_file *of,
-					  poll_table *pt)
+struct poll_table_struct;
+__poll_t cgroup_pressure_poll(struct kernfs_open_file *of,
+			      struct poll_table_struct *pt)
 {
 	return psi_trigger_poll(&of->priv, of->file, pt);
 }
 
-static void cgroup_pressure_release(struct kernfs_open_file *of)
+void cgroup_pressure_release(struct kernfs_open_file *of)
 {
 	psi_trigger_replace(&of->priv, NULL);
 }
-- 
2.19.1.856.g8858448bb

