Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110AB3EBEEC
	for <lists+cgroups@lfdr.de>; Sat, 14 Aug 2021 02:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbhHNAPs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Aug 2021 20:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbhHNAPs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Aug 2021 20:15:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00064C061756;
        Fri, 13 Aug 2021 17:15:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id a8so17689883pjk.4;
        Fri, 13 Aug 2021 17:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Xt4LhTfmIYJLNZv3Sql9WLAUI0QXOS6TD45Qib/plF0=;
        b=ULyQNxlRZbk30c63JGFG/iifhh8sARTJ8DYHaOoSdNw2OeOTtETxedxvne9rsjblxq
         fj0PylvbXCqT3p78s4MP/QxC5qMIerNDPcKU1B5wcdgl8iaf4QPvG7N3JDpuuRWlHv+X
         ZsFvhB+NM4/cNcFSSKLd9T077hHwf4CdsYAF1Ge9oO+LNerug25AYR/WXp+b740DXX9T
         ybdPuC62p8+hJinbaN5lhSS7p3bnN1Aa9Auuu19xOhvlWQLGhA8pPvG1Dvv89WbD5BFL
         rXMrlLkvQOK+1llQsgpaF3NurZ2G7JrdHF0A+dZEAdOkdBH8yCJyB1HJjOi/rxo/BdY9
         Xvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Xt4LhTfmIYJLNZv3Sql9WLAUI0QXOS6TD45Qib/plF0=;
        b=hwjwVO+Q3I2Zp3/vwZxM0rhxukjgpyhCw37fzyLL7L1cDOsE7/L+8PTBbNysjgHWLZ
         /PFRzyAk/NmZYxDtq+r0VI0joYpA3jaJCLDblmYkyNDkmzuvuRgcCzHVLEwh7Bb9UQr2
         iSMYDxvL3kaAvUGMEWqD0Y6BwwIT3BXbnP+zcu2cocBEf2O7TddYqOdpkbUw9BNPHqLW
         yzS4fK4cEiCY/MaU5vcxZZoyDPhWAaBfqe49OtZ6G7P+x+Ch08mpxfan1LeI8ZpCc//4
         RUmN6o6APx7KrQH9sBwbuzZwHqK/P7qjVIkRDPskqjr7hHfLl5uI0cbFmer9l1wbSWWH
         7rjw==
X-Gm-Message-State: AOAM532E+GfbAq6H7DdX75Z5P70nONxA1ypUfh73eSpd0xWT1M4WgBn3
        /90r1ImYHBK5OAhVl7ZZgbQ=
X-Google-Smtp-Source: ABdhPJx5KhgPakcYFeAGWF0JsYxfx2LmRTMucKWwZ9I0i11X1O288s2gxovW011/l9jgwXbXO7plwg==
X-Received: by 2002:a62:6042:0:b029:3cd:d392:643 with SMTP id u63-20020a6260420000b02903cdd3920643mr4835199pfb.43.1628900120478;
        Fri, 13 Aug 2021 17:15:20 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id d134sm3551557pfd.60.2021.08.13.17.15.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 17:15:18 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     vipinsh@google.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [PATCH v2] misc_cgroup: use a counter to count the number of failures
Date:   Sat, 14 Aug 2021 08:15:16 +0800
Message-Id: <a09f381462b1ce9c506a22713b998e21b459f7e9.1628899295.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

For a container, we only print an error log when the resource
charge fails. There may be some problems here:

1. If a large number of containers are created and deleted,
   there will be a lot of error logs.
2. According to an error log, we cannot better understand
   the actual pressure of resources.

Therefore, perhaps we should use a failcnt counter to count
the number of failures, so that we can easily understand the
actual pressure of resources and avoid too many error log..

v2: rename failcnt to nr_fails.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 include/linux/misc_cgroup.h |  4 ++--
 kernel/cgroup/misc.c        | 37 ++++++++++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index da2367e..59706b2 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -31,12 +31,12 @@ enum misc_res_type {
  * struct misc_res: Per cgroup per misc type resource
  * @max: Maximum limit on the resource.
  * @usage: Current usage of the resource.
- * @failed: True if charged failed for the resource in a cgroup.
+ * @nr_fails: Failure count of the resource
  */
 struct misc_res {
 	unsigned long max;
 	atomic_long_t usage;
-	bool failed;
+	atomic_long_t nr_fails;
 };
 
 /**
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index ec02d96..c35477e 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -157,13 +157,7 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
 		new_usage = atomic_long_add_return(amount, &res->usage);
 		if (new_usage > READ_ONCE(res->max) ||
 		    new_usage > READ_ONCE(misc_res_capacity[type])) {
-			if (!res->failed) {
-				pr_info("cgroup: charge rejected by the misc controller for %s resource in ",
-					misc_res_name[type]);
-				pr_cont_cgroup_path(i->css.cgroup);
-				pr_cont("\n");
-				res->failed = true;
-			}
+			atomic_long_inc(&res->nr_fails);
 			ret = -EBUSY;
 			goto err_charge;
 		}
@@ -312,6 +306,29 @@ static int misc_cg_current_show(struct seq_file *sf, void *v)
 }
 
 /**
+ * misc_cg_failcnt_show() - Show the fail count of the misc cgroup.
+ * @sf: Interface file
+ * @v: Arguments passed
+ *
+ * Context: Any context.
+ * Return: 0 to denote successful print.
+ */
+static int misc_cg_failcnt_show(struct seq_file *sf, void *v)
+{
+	int i;
+	unsigned long nr_fails;
+	struct misc_cg *cg = css_misc(seq_css(sf));
+
+	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
+		nr_fails = atomic_long_read(&cg->res[i].nr_fails);
+		if (READ_ONCE(misc_res_capacity[i]) || nr_fails)
+			seq_printf(sf, "%s %lu\n", misc_res_name[i], nr_fails);
+	}
+
+	return 0;
+}
+
+/**
  * misc_cg_capacity_show() - Show the total capacity of misc res on the host.
  * @sf: Interface file
  * @v: Arguments passed
@@ -349,6 +366,11 @@ static int misc_cg_capacity_show(struct seq_file *sf, void *v)
 		.flags = CFTYPE_NOT_ON_ROOT,
 	},
 	{
+		.name = "failcnt",
+		.seq_show = misc_cg_failcnt_show,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{
 		.name = "capacity",
 		.seq_show = misc_cg_capacity_show,
 		.flags = CFTYPE_ONLY_ON_ROOT,
@@ -382,6 +404,7 @@ static int misc_cg_capacity_show(struct seq_file *sf, void *v)
 	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
 		WRITE_ONCE(cg->res[i].max, MAX_NUM);
 		atomic_long_set(&cg->res[i].usage, 0);
+		atomic_long_set(&cg->res[i].nr_fails, 0);
 	}
 
 	return &cg->css;
-- 
1.8.3.1

