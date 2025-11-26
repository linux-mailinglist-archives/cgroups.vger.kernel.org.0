Return-Path: <cgroups+bounces-12199-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A59C87D17
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 03:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E45F354B11
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 02:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006652F7453;
	Wed, 26 Nov 2025 02:23:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F6C28E0F;
	Wed, 26 Nov 2025 02:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764123804; cv=none; b=Rjju6hVPVdSSmZo9pCE8/IyjRwpG6oO1RRx5D2KEZXEWiGfEnW0D6oH33ZRrdG8NNndR550pRfbGxL8sNyxvYrk3Zmf3eBV1gVh2bZN68WKHSXLxHKlw7PtR3CBt9FVYrUbGqnql+v6fBqw8VLjLGo9U+zFz60REhcNJDhtMntY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764123804; c=relaxed/simple;
	bh=GlgTN5RBx9w+FsnBXz+wPJ2oQH8vo6HWNsNssKaBPlg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sL4PnG8piM55EFHtESfdh+75VWZWzusEIZd0uLE0qODNWbCo3j/Sute8qg4ofe2jlWL5i8D5KXaZFF4vvgkinDNQkEtD6PBetiUAjFvZhF9B7zAUyQaD2W/JBEQQUQ26VKirsluDkut1kDDx4wiiqv5TjvG96neJie9mxOCt9HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dGNch1Qx5zYQttT;
	Wed, 26 Nov 2025 10:22:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 5EB041A165C;
	Wed, 26 Nov 2025 10:23:19 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgBneAqOZCZpMBwCCA--.7537S2;
	Wed, 26 Nov 2025 10:23:19 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next] cgroup: Use descriptor table to unify mount flag management
Date: Wed, 26 Nov 2025 02:08:25 +0000
Message-Id: <20251126020825.1511671-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBneAqOZCZpMBwCCA--.7537S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuw4rKr4xAw4DWF43ZFy8uFg_yoWxJrWxpa
	n5Wayavws5Jwn8Z3yrtwnYva1fAw4rJFWxAFZ8Cw1xtw4xJF4UJ3Z7AFWUZF15AF9rCw17
	AFs8X3WYkry5K37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbiF4tUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The cgroup2 mount flags (e.g. nsdelegate, favordynmods) were previously
handled via scattered switch-case and conditional checks across
parameter parsing, flag application, and option display paths. This
leads to redundant code and increased maintenance cost when adding/removing
flags.

Introduce a `cgroup_mount_flag_desc` descriptor table to centralize the
mapping between flag bits, names, and apply functions. Refactor the
relevant paths to use this table for unified management:
1. cgroup2_parse_param: Replace switch-case with table lookup
2. apply_cgroup_root_flags: Replace multiple conditionals with table
   iteration
3. cgroup_show_options: Replace hardcoded seq_puts with table-driven output

No functional change intended, and the mount option output format remains
compatible with the original implementation.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cgroup.c | 107 +++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 58 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e717208cfb18..1e4033d05c29 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2005,6 +2005,36 @@ static const struct fs_parameter_spec cgroup2_fs_parameters[] = {
 	{}
 };
 
+struct cgroup_mount_flag_desc {
+	u64 flag;
+	const char *name;
+	void (*apply)(struct cgroup_root *root, u64 bit, bool enable);
+};
+
+static void apply_cgroup_favor_flags(struct cgroup_root *root,
+					     u64 bit, bool enable)
+{
+	return cgroup_favor_dynmods(root, enable);
+}
+
+static void __apply_cgroup_root_flags(struct cgroup_root *root,
+					      u64 bit, bool enable)
+{
+	if (enable)
+		root->flags |= bit;
+	else
+		root->flags &= ~bit;
+}
+
+static const struct cgroup_mount_flag_desc mount_flags_desc[nr__cgroup2_params] = {
+{CGRP_ROOT_NS_DELEGATE, "nsdelegate", __apply_cgroup_root_flags},
+{CGRP_ROOT_FAVOR_DYNMODS, "favordynmods", apply_cgroup_favor_flags},
+{CGRP_ROOT_MEMORY_LOCAL_EVENTS, "memory_localevents", __apply_cgroup_root_flags},
+{CGRP_ROOT_MEMORY_RECURSIVE_PROT, "memory_recursiveprot", __apply_cgroup_root_flags},
+{CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING, "memory_hugetlb_accounting", __apply_cgroup_root_flags},
+{CGRP_ROOT_PIDS_LOCAL_EVENTS, "pids_localevents", __apply_cgroup_root_flags}
+};
+
 static int cgroup2_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
@@ -2014,28 +2044,11 @@ static int cgroup2_parse_param(struct fs_context *fc, struct fs_parameter *param
 	opt = fs_parse(fc, cgroup2_fs_parameters, param, &result);
 	if (opt < 0)
 		return opt;
+	if (opt >= nr__cgroup2_params)
+		return -EINVAL;
 
-	switch (opt) {
-	case Opt_nsdelegate:
-		ctx->flags |= CGRP_ROOT_NS_DELEGATE;
-		return 0;
-	case Opt_favordynmods:
-		ctx->flags |= CGRP_ROOT_FAVOR_DYNMODS;
-		return 0;
-	case Opt_memory_localevents:
-		ctx->flags |= CGRP_ROOT_MEMORY_LOCAL_EVENTS;
-		return 0;
-	case Opt_memory_recursiveprot:
-		ctx->flags |= CGRP_ROOT_MEMORY_RECURSIVE_PROT;
-		return 0;
-	case Opt_memory_hugetlb_accounting:
-		ctx->flags |= CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING;
-		return 0;
-	case Opt_pids_localevents:
-		ctx->flags |= CGRP_ROOT_PIDS_LOCAL_EVENTS;
-		return 0;
-	}
-	return -EINVAL;
+	ctx->flags |= mount_flags_desc[opt].flag;
+	return 0;
 }
 
 struct cgroup_of_peak *of_peak(struct kernfs_open_file *of)
@@ -2047,51 +2060,29 @@ struct cgroup_of_peak *of_peak(struct kernfs_open_file *of)
 
 static void apply_cgroup_root_flags(unsigned int root_flags)
 {
-	if (current->nsproxy->cgroup_ns == &init_cgroup_ns) {
-		if (root_flags & CGRP_ROOT_NS_DELEGATE)
-			cgrp_dfl_root.flags |= CGRP_ROOT_NS_DELEGATE;
-		else
-			cgrp_dfl_root.flags &= ~CGRP_ROOT_NS_DELEGATE;
-
-		cgroup_favor_dynmods(&cgrp_dfl_root,
-				     root_flags & CGRP_ROOT_FAVOR_DYNMODS);
-
-		if (root_flags & CGRP_ROOT_MEMORY_LOCAL_EVENTS)
-			cgrp_dfl_root.flags |= CGRP_ROOT_MEMORY_LOCAL_EVENTS;
-		else
-			cgrp_dfl_root.flags &= ~CGRP_ROOT_MEMORY_LOCAL_EVENTS;
+	int i;
 
-		if (root_flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT)
-			cgrp_dfl_root.flags |= CGRP_ROOT_MEMORY_RECURSIVE_PROT;
-		else
-			cgrp_dfl_root.flags &= ~CGRP_ROOT_MEMORY_RECURSIVE_PROT;
+	if (current->nsproxy->cgroup_ns != &init_cgroup_ns)
+		return;
 
-		if (root_flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
-			cgrp_dfl_root.flags |= CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING;
-		else
-			cgrp_dfl_root.flags &= ~CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING;
+	for (i = 0; i < nr__cgroup2_params; ++i) {
+		bool enable;
 
-		if (root_flags & CGRP_ROOT_PIDS_LOCAL_EVENTS)
-			cgrp_dfl_root.flags |= CGRP_ROOT_PIDS_LOCAL_EVENTS;
-		else
-			cgrp_dfl_root.flags &= ~CGRP_ROOT_PIDS_LOCAL_EVENTS;
+		enable = root_flags & mount_flags_desc[i].flag;
+		mount_flags_desc[i].apply(&cgrp_dfl_root, mount_flags_desc[i].flag, enable);
 	}
 }
 
 static int cgroup_show_options(struct seq_file *seq, struct kernfs_root *kf_root)
 {
-	if (cgrp_dfl_root.flags & CGRP_ROOT_NS_DELEGATE)
-		seq_puts(seq, ",nsdelegate");
-	if (cgrp_dfl_root.flags & CGRP_ROOT_FAVOR_DYNMODS)
-		seq_puts(seq, ",favordynmods");
-	if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_LOCAL_EVENTS)
-		seq_puts(seq, ",memory_localevents");
-	if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT)
-		seq_puts(seq, ",memory_recursiveprot");
-	if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
-		seq_puts(seq, ",memory_hugetlb_accounting");
-	if (cgrp_dfl_root.flags & CGRP_ROOT_PIDS_LOCAL_EVENTS)
-		seq_puts(seq, ",pids_localevents");
+	int i;
+
+	for (i = 0; i < nr__cgroup2_params; ++i) {
+		if (cgrp_dfl_root.flags & mount_flags_desc[i].flag) {
+			seq_puts(seq, ",");
+			seq_puts(seq, mount_flags_desc[i].name);
+		}
+	}
 	return 0;
 }
 
-- 
2.34.1


