Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F925FA8CC
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 01:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiJJX67 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Oct 2022 19:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiJJX65 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Oct 2022 19:58:57 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D93B7FE7F
        for <cgroups@vger.kernel.org>; Mon, 10 Oct 2022 16:58:56 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id x13-20020a170902ec8d00b00177f0fa642cso8775001plg.10
        for <cgroups@vger.kernel.org>; Mon, 10 Oct 2022 16:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PtNrUd9EMj0I502bSB6YBXD5TgTiX1+1yTi9Pa6f94M=;
        b=OOeBo8F1N0lTKOQnJQ6gjRzmWKqHpT7+Pw3vXDR73IrU1E4xpR1RXW0AyAeAg98DF2
         0VRGJGzEExjWy4Eg3AmeCRoU3WPGIEEXBA0X7oh2O/sJbrOpwxwlzWb5LuTekNFwBvIG
         agxHCGqzT5FvWIUf5V5ApkseZkzZBxDzx9jXXKTyJYIqwOdRA4tN8+jfet9kWaF4NfCX
         FLMYscR4F9y/dAqOnhNfzFJWY/dHzkzWWoWcvxMjpnLX7GuAKSt3YHkJcQumbIWwOiY7
         eBd79d0IbBy9hPp0PiaMdgnTCOUqu7e/v+fyukJ3ulE+P7KGO7pFFXtwydwkWvfJ+gZQ
         +baQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PtNrUd9EMj0I502bSB6YBXD5TgTiX1+1yTi9Pa6f94M=;
        b=Z6rco1a2ZCyXVDhcZc4cMGlX4rA9zYYqIrkgV9D35lSjxztW3w/Dexs+ZJKl8DpaTN
         3O3xsDkrwss84NoO0H8qjlHSY90qvTkBTCRfgF2TKa84qceyrqk5KeLTgy7J1OJL4D5I
         yt3+W+jy11TMLAMQuvOR+iEbtgthYmbXFhylv+HaYvH2EuGyZ2XPHeHDztX2WKp//cNU
         AacWXoRHwpzd4FBeDS4vM90LRVZXVCCA+J42By08UzHqgME0Z6OtpqmvvxHAP9FAgONh
         xgTEzL1IwcQwTmbpFlmS893BuXl1OJrj5jZBEPBqz5d1nKesuUN3b/d0GkjsDslbAiQD
         zTgw==
X-Gm-Message-State: ACrzQf2WZedrcqbeFiR7er51nT3VkqRn1pp1dVRgzGTlbyN/zCsgMIxd
        kENBaUR1/nDtW5u4OFYBz0c1krEpuG6cyZ0U
X-Google-Smtp-Source: AMsMyM4gQxpJ/Q5TSIfcUWEs+Y/lGTQRc+zkjm6wS56Km93ixi79nS80a1vD78Y+PM0wkfH/W6VVBszkE8R+JvG4
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90b:3d8b:b0:20d:3e7f:32d3 with SMTP
 id pq11-20020a17090b3d8b00b0020d3e7f32d3mr8765393pjb.22.1665446335496; Mon,
 10 Oct 2022 16:58:55 -0700 (PDT)
Date:   Mon, 10 Oct 2022 23:58:44 +0000
In-Reply-To: <20221010235845.3379019-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20221010235845.3379019-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221010235845.3379019-3-yosryahmed@google.com>
Subject: [PATCH v1 2/3] cgroup: add cgroup_all_get_from_[fd/file]()
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add cgroup_all_get_from_fd() and cgroup_all_get_from_file() that
support both cgroup1 and cgroup2.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/cgroup.h |  1 +
 kernel/cgroup/cgroup.c | 50 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 398f0bce7c21..cd847f4f47ed 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -106,6 +106,7 @@ struct cgroup_subsys_state *css_tryget_online_from_dir(struct dentry *dentry,
 
 struct cgroup *cgroup_get_from_path(const char *path);
 struct cgroup *cgroup_get_from_fd(int fd);
+struct cgroup *cgroup_all_get_from_fd(int fd);
 
 int cgroup_attach_task_all(struct task_struct *from, struct task_struct *);
 int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 72e97422e9d9..c3bd6f17246a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6208,16 +6208,36 @@ void cgroup_fork(struct task_struct *child)
 	INIT_LIST_HEAD(&child->cg_list);
 }
 
-static struct cgroup *cgroup_get_from_file(struct file *f)
+/**
+ * cgroup_all_get_from_file - get a cgroup pointer from a file pointer
+ * @f: file corresponding to cgroup_dir
+ *
+ * Find the cgroup from a file pointer associated with a cgroup directory.
+ * Returns a pointer to the cgroup on success. ERR_PTR is returned if the
+ * cgroup cannot be found.
+ */
+static struct cgroup *cgroup_all_get_from_file(struct file *f)
 {
 	struct cgroup_subsys_state *css;
-	struct cgroup *cgrp;
 
 	css = css_tryget_online_from_dir(f->f_path.dentry, NULL);
 	if (IS_ERR(css))
 		return ERR_CAST(css);
 
-	cgrp = css->cgroup;
+	return css->cgroup;
+}
+
+/**
+ * cgroup_get_from_file - same as cgroup_all_get_from_file, but only supports
+ * cgroup2.
+ */
+static struct cgroup *cgroup_get_from_file(struct file *f)
+{
+	struct cgroup *cgrp = cgroup_all_get_from_file(f);
+
+	if (IS_ERR(cgrp))
+		return ERR_CAST(cgrp);
+
 	if (!cgroup_on_dfl(cgrp)) {
 		cgroup_put(cgrp);
 		return ERR_PTR(-EBADF);
@@ -6720,14 +6740,14 @@ EXPORT_SYMBOL_GPL(cgroup_get_from_path);
 
 /**
  * cgroup_get_from_fd - get a cgroup pointer from a fd
- * @fd: fd obtained by open(cgroup2_dir)
+ * @fd: fd obtained by open(cgroup_dir)
  *
  * Find the cgroup from a fd which should be obtained
  * by opening a cgroup directory.  Returns a pointer to the
  * cgroup on success. ERR_PTR is returned if the cgroup
  * cannot be found.
  */
-struct cgroup *cgroup_get_from_fd(int fd)
+struct cgroup *cgroup_all_get_from_fd(int fd)
 {
 	struct cgroup *cgrp;
 	struct file *f;
@@ -6736,10 +6756,28 @@ struct cgroup *cgroup_get_from_fd(int fd)
 	if (!f)
 		return ERR_PTR(-EBADF);
 
-	cgrp = cgroup_get_from_file(f);
+	cgrp = cgroup_all_get_from_file(f);
 	fput(f);
 	return cgrp;
 }
+
+/**
+ * cgroup_get_from_fd - same as cgroup_all_get_from_fd, but only supports
+ * cgroup2.
+ */
+struct cgroup *cgroup_get_from_fd(int fd)
+{
+	struct cgroup *cgrp = cgroup_all_get_from_fd(fd);
+
+	if (IS_ERR(cgrp))
+		return ERR_CAST(cgrp);
+
+	if (!cgroup_on_dfl(cgrp)) {
+		cgroup_put(cgrp);
+		return ERR_PTR(-EBADF);
+	}
+	return cgrp;
+}
 EXPORT_SYMBOL_GPL(cgroup_get_from_fd);
 
 static u64 power_of_ten(int power)
-- 
2.38.0.rc1.362.ged0d419d3c-goog

