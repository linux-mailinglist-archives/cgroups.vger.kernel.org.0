Return-Path: <cgroups+bounces-2442-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC2F8A2420
	for <lists+cgroups@lfdr.de>; Fri, 12 Apr 2024 05:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC32E1C22421
	for <lists+cgroups@lfdr.de>; Fri, 12 Apr 2024 03:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3247D1429A;
	Fri, 12 Apr 2024 03:00:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3061214F70;
	Fri, 12 Apr 2024 03:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890859; cv=none; b=uDY7H+M2UuIZJEMSIDQvznvrV/PGo4BGGUlnO6OBrMAeoy86xCQqazSXOaCvPY9nHQfKs62dZUMnx9msWWUc6yYHx2s1mYX+l5Ja58UYIHkaj1E4YFOY/gjm1ZpGOzkLHNVMBBnvczPWn0YxvwYstMhLTttT4OPIujyJFxUVDFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890859; c=relaxed/simple;
	bh=7xpF9gk+Z73V/R643zePirjdWWYSTl9zp1dt3/U6OZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sak+rpOQK+UtJI6JUHx5Um+pyhG91l6MwxgrsRwgiNClXFgd69nrLUSNi7FGkPJdRBGzCUwcE8Mjmkesn1ciWU9kVOFcqUYKVIwe6bhkYlAqVe5DBDP00G9ntnOw9pq8cAY+arqF8nnku6jBTsTwL5izzvbF8lVFBPKT8OoXu0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VG1XY4J1Rz4f3jdB;
	Fri, 12 Apr 2024 11:00:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 812A81A016E;
	Fri, 12 Apr 2024 11:00:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.26])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7koxhmW+8EJw--.45873S4;
	Fri, 12 Apr 2024 11:00:52 +0800 (CST)
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH -next] cgroup: move proc_cgroupstats_show() to cgroup.c
Date: Fri, 12 Apr 2024 02:54:02 +0000
Message-Id: <20240412025402.780603-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g7koxhmW+8EJw--.45873S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4fGFyrAF4UJFW3tF48Xrb_yoW5AF17pF
	n8A343Aw45GFyUKw17t34q9ryfKw4Fqw4UKw4DK34ftr12yr1Iqr1vvw18XryF9FySkF1a
	qF4Yvryjkw1UtrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr
	1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
	vfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/

From: Xiu Jianfeng <xiujianfeng@huawei.com>

Currently proc_cgroupstats_show() is in cgroup-v1.c, however it can be
used for v2 too, so it's better to move it cgroup.c.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/cgroup/cgroup-internal.h |  1 -
 kernel/cgroup/cgroup-v1.c       | 21 ---------------------
 kernel/cgroup/cgroup.c          | 21 +++++++++++++++++++++
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 520b90dd97ec..9afb39da0d8d 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -284,7 +284,6 @@ extern struct cftype cgroup1_base_files[];
 extern struct kernfs_syscall_ops cgroup1_kf_syscall_ops;
 extern const struct fs_parameter_spec cgroup1_fs_parameters[];
 
-int proc_cgroupstats_show(struct seq_file *m, void *v);
 bool cgroup1_ssid_disabled(int ssid);
 void cgroup1_pidlist_destroy_all(struct cgroup *cgrp);
 void cgroup1_release_agent(struct work_struct *work);
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 520a11cb12f4..ca22f66b5c64 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -663,27 +663,6 @@ struct cftype cgroup1_base_files[] = {
 	{ }	/* terminate */
 };
 
-/* Display information about each subsystem and each hierarchy */
-int proc_cgroupstats_show(struct seq_file *m, void *v)
-{
-	struct cgroup_subsys *ss;
-	int i;
-
-	seq_puts(m, "#subsys_name\thierarchy\tnum_cgroups\tenabled\n");
-	/*
-	 * Grab the subsystems state racily. No need to add avenue to
-	 * cgroup_mutex contention.
-	 */
-
-	for_each_subsys(ss, i)
-		seq_printf(m, "%s\t%d\t%d\t%d\n",
-			   ss->legacy_name, ss->root->hierarchy_id,
-			   atomic_read(&ss->root->nr_cgrps),
-			   cgroup_ssid_enabled(i));
-
-	return 0;
-}
-
 /**
  * cgroupstats_build - build and fill cgroupstats
  * @stats: cgroupstats to fill information into
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a66c088c851c..dcdc23d66aa0 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6028,6 +6028,27 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 	cgroup_unlock();
 }
 
+/* Display information about each subsystem and each hierarchy */
+static int proc_cgroupstats_show(struct seq_file *m, void *v)
+{
+	struct cgroup_subsys *ss;
+	int i;
+
+	seq_puts(m, "#subsys_name\thierarchy\tnum_cgroups\tenabled\n");
+	/*
+	 * Grab the subsystems state racily. No need to add avenue to
+	 * cgroup_mutex contention.
+	 */
+
+	for_each_subsys(ss, i)
+		seq_printf(m, "%s\t%d\t%d\t%d\n",
+			   ss->legacy_name, ss->root->hierarchy_id,
+			   atomic_read(&ss->root->nr_cgrps),
+			   cgroup_ssid_enabled(i));
+
+	return 0;
+}
+
 /**
  * cgroup_init_early - cgroup initialization at system boot
  *
-- 
2.34.1


