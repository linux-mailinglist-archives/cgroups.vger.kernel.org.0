Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBAD4033B9
	for <lists+cgroups@lfdr.de>; Wed,  8 Sep 2021 07:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbhIHFZx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Sep 2021 01:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbhIHFZt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Sep 2021 01:25:49 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88476C06175F;
        Tue,  7 Sep 2021 22:24:42 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so649093pjx.5;
        Tue, 07 Sep 2021 22:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=chwGnJXtYzYfFAb2xocoJoG9ap7jKymOQv0bE0NKq/4=;
        b=UT+9Jq5isRNyTNrE6lq+yYmAhDNeRDmV3DjYgMAyjHhcD3OiHLVBbkNi5UcgN2KDv/
         H11zy3fg5q1Ci9yYB8MwLodUHv+K8CJdSI6trnshnNKTThp8Eo4X5y0S3DvRPtn/vjBd
         bpjnmRCmy/caQFiuIYhWSwKuVfuD2shR5nvKWPy8/DDx3HjdUUa7wk5SXrtvfJsDJUcY
         fumLL5lVzx6JAWfbh+sjGLBkQk8wzTEutStNBSBXDohk4rfwShhyaiTtM8+NYlV4kSHb
         4S/oSyRSV/+5P9oOkkp2wE0sEGktS4Bc1RfM9GT/KRZ9jSXUuWcoTrv7gwxkV/80xTSO
         q+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=chwGnJXtYzYfFAb2xocoJoG9ap7jKymOQv0bE0NKq/4=;
        b=EmSbxYSYN8C0/J9SFjXQq03SfCiOTsVaUEget3hDe10+e2njCSOH9ZThF/y5XLV3FR
         ISEnX27YYrVOgLLrSUiLLeiTUEqYQsAjQqxZxhiyld0ifEx4V/Voc7VrlCEwlg7HHAYJ
         bBPugGgQuU0EHtb8NS0VO41ZsqOy7hcgLXt/MJl4SS0PLyvGrr3qcS2BJFR81elhxkzF
         8wvu/r0p9jpl+VA5lHda1+YF3r4K/Cutu4fdJACtfO0L7g8twQTpJ9Kh5qu/Ale/WOtZ
         04w24JsjjX4DcH1F3UmXPhxr2deauHogH4CGwsFVu7xuQLdQwTzJu0z0cGAsZnKwQhwG
         rK7w==
X-Gm-Message-State: AOAM530AbSSFgdyOAR9JuoEQ3mpUswyF4zqg5jYDH0h06735UjMbuQ/3
        lFB+c1PfC89SSjEXiG0WZpg=
X-Google-Smtp-Source: ABdhPJxRuPlvuKXcOXMxFDWhDRWwl5C1UeQzwCusI7Oh6tgUyHLALxSmloiEADnMwOQa2XEabVrphQ==
X-Received: by 2002:a17:902:b694:b0:138:a031:610d with SMTP id c20-20020a170902b69400b00138a031610dmr1718866pls.36.1631078682063;
        Tue, 07 Sep 2021 22:24:42 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id k190sm769674pfd.211.2021.09.07.22.24.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 22:24:41 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     vipinsh@google.com, mkoutny@suse.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [RFC PATCH 2/3] misc_cgroup: introduce misc.failcnt for V1
Date:   Wed,  8 Sep 2021 13:24:35 +0800
Message-Id: <c4e091c8c0208554b97f751ae80a093f55f19883.1631077837.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
References: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
In-Reply-To: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
References: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

introduce misc.failcnt for cgroup v1 to make it easier for us to
understand the pressure of resources.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 include/linux/misc_cgroup.h |  3 +++
 kernel/cgroup/misc.c        | 54 +++++++++++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index d29f1743fae9..4d630cd3e4bd 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -55,6 +55,9 @@ struct misc_cg {
 	atomic_long_t events_local[MISC_CG_RES_TYPES];
 	struct cgroup_file events_local_file;
 
+	/* misc.failcnt for v1 only */
+	atomic_long_t nr_failed[MISC_CG_RES_TYPES];
+
 	struct misc_res res[MISC_CG_RES_TYPES];
 };
 
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index 2a3d14be21e5..d8f99fd58981 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -179,7 +179,8 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
 			atomic_long_inc(&k->events[type]);
 			cgroup_file_notify(&k->events_file);
 		}
-	}
+	} else
+		atomic_long_inc(&i->nr_failed[type]);
 
 	for (j = cg; j != i; j = parent_misc(j))
 		misc_cg_cancel_charge(type, j, amount);
@@ -371,6 +372,29 @@ static int misc_events_local_show(struct seq_file *sf, void *v)
 	return 0;
 }
 
+/**
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
+	unsigned long failcnt;
+	struct misc_cg *cg = css_misc(seq_css(sf));
+
+	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
+		failcnt = atomic_long_read(&cg->nr_failed[i]);
+		if (READ_ONCE(misc_res_capacity[i]) || failcnt)
+			seq_printf(sf, "%s %lu\n", misc_res_name[i], failcnt);
+	}
+
+	return 0;
+}
+
 /* Misc cgroup interface files */
 static struct cftype misc_cg_files[] = {
 	{
@@ -404,6 +428,32 @@ static struct cftype misc_cg_files[] = {
 	{}
 };
 
+/* Misc cgroup interface files for v1*/
+static struct cftype misc_cg_legacy_files[] = {
+	{
+		.name = "max",
+		.write = misc_cg_max_write,
+		.seq_show = misc_cg_max_show,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{
+		.name = "current",
+		.seq_show = misc_cg_current_show,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{
+		.name = "capacity",
+		.seq_show = misc_cg_capacity_show,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+	},
+	{
+		.name = "failcnt",
+		.seq_show = misc_cg_failcnt_show,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{}
+};
+
 /**
  * misc_cg_alloc() - Allocate misc cgroup.
  * @parent_css: Parent cgroup.
@@ -450,6 +500,6 @@ static void misc_cg_free(struct cgroup_subsys_state *css)
 struct cgroup_subsys misc_cgrp_subsys = {
 	.css_alloc = misc_cg_alloc,
 	.css_free = misc_cg_free,
-	.legacy_cftypes = misc_cg_files,
+	.legacy_cftypes = misc_cg_legacy_files,
 	.dfl_cftypes = misc_cg_files,
 };
-- 
2.30.0

