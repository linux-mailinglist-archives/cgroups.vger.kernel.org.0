Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF8750E90F
	for <lists+cgroups@lfdr.de>; Mon, 25 Apr 2022 21:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244787AbiDYTEG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Apr 2022 15:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244806AbiDYTED (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Apr 2022 15:04:03 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E53E5E16
        for <cgroups@vger.kernel.org>; Mon, 25 Apr 2022 12:00:58 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id t12-20020a170902a5cc00b001590717a080so9993174plq.10
        for <cgroups@vger.kernel.org>; Mon, 25 Apr 2022 12:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OERxjUiMWr1cQdsDG2DOpxyattqqP1OOWWgJQWH3L+Q=;
        b=jny3uMCrVBnmU4KDEBjxFsNJ+VQFDuZs2Of3Od5sz8dt2N8StM4QwzqkfKRfsR2PfJ
         04xxC8sY4WVBXUNIHQnO3TDQtNk2mQI5Bv9TrMkGE46T+NAgqKUPQzVfhj1gB8tDph5u
         UmK+li0N/cdU24sX+whw1L8S1DSaDJ4Y+wD/WlGONCStk3DPn7EmkqUT0OgZ8aYJ6dyn
         D5vmzhn/g+i+rRip2IlvPQOMq/Yv8PFURN8S3CPi5j868Dex+B48+XwMpbVAMJy/W7AT
         cJzzCERjoZDLjEcEDQyUGJOSErR614eYQY7PZP9qDV4G7CSk3yjVAqmJHqS+FU2WYbGN
         gDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OERxjUiMWr1cQdsDG2DOpxyattqqP1OOWWgJQWH3L+Q=;
        b=I795nFJtFQa2yxKKmJVWAkOhEqhNq808LXPUmssySzWhFUuw/A6Hd1RTJEDftbgXtL
         Zi7Zt34E8/TYhXQGJoTicOizGLAQsPSNxq8pcSmUJYlpwQu/JBiP6X9RqKiwiUpP9cD1
         +VGpRxk09tIIUYxPPlqMz6LXC22seQTPU/xVNk7/47nnauXvOJac2azQhSgkaJzvjAnh
         Nlg+uO/qQtWXrLKG9RJ1f92RRRS3tfim5p7OY8TWb4jUhKjbExCRTk5+JGUJDk7/OalS
         fXZLs3kdCAdwDlWN+1RCHurNuI++wFOs9nfUWEeqDo80WeJhZsSjIIBxsehEMK+D5p8J
         l6Xw==
X-Gm-Message-State: AOAM533BoKQPj3t9LFuhkmpfAASUjtYbpHY/KWSr+cfBEcqJ5bJCu4o0
        qcI00dRwMCSf1DlXJcEfk3HBhxhAZ+P00r1C
X-Google-Smtp-Source: ABdhPJyuLEwI6VGaaT+2zi+YCPqvG9+iIGmxhIFRCLcY9IfcS41UvuhS+EBApDVh5mp5ySwJen6WcU1Wg3Nk6iDY
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:c986:b0:1d9:56e7:4e83 with SMTP
 id w6-20020a17090ac98600b001d956e74e83mr693654pjt.1.1650913256918; Mon, 25
 Apr 2022 12:00:56 -0700 (PDT)
Date:   Mon, 25 Apr 2022 19:00:38 +0000
In-Reply-To: <20220425190040.2475377-1-yosryahmed@google.com>
Message-Id: <20220425190040.2475377-3-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220425190040.2475377-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v5 2/4] selftests: cgroup: return -errno from
 cg_read()/cg_write() on failure
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, cg_read()/cg_write() returns 0 on success and -1 on failure.
Modify them to return the -errno on failure.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c | 44 +++++++++-----------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index dbaa7aabbb4a..e6f3679cdcc0 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -19,6 +19,7 @@
 #include "cgroup_util.h"
 #include "../clone3/clone3_selftests.h"
 
+/* Returns read len on success, or -errno on failure. */
 static ssize_t read_text(const char *path, char *buf, size_t max_len)
 {
 	ssize_t len;
@@ -26,35 +27,29 @@ static ssize_t read_text(const char *path, char *buf, size_t max_len)
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
-		return fd;
+		return -errno;
 
 	len = read(fd, buf, max_len - 1);
-	if (len < 0)
-		goto out;
 
-	buf[len] = 0;
-out:
+	if (len >= 0)
+		buf[len] = 0;
+
 	close(fd);
-	return len;
+	return len < 0 ? -errno : len;
 }
 
+/* Returns written len on success, or -errno on failure. */
 static ssize_t write_text(const char *path, char *buf, ssize_t len)
 {
 	int fd;
 
 	fd = open(path, O_WRONLY | O_APPEND);
 	if (fd < 0)
-		return fd;
+		return -errno;
 
 	len = write(fd, buf, len);
-	if (len < 0) {
-		close(fd);
-		return len;
-	}
-
 	close(fd);
-
-	return len;
+	return len < 0 ? -errno : len;
 }
 
 char *cg_name(const char *root, const char *name)
@@ -87,16 +82,16 @@ char *cg_control(const char *cgroup, const char *control)
 	return ret;
 }
 
+/* Returns 0 on success, or -errno on failure. */
 int cg_read(const char *cgroup, const char *control, char *buf, size_t len)
 {
 	char path[PATH_MAX];
+	ssize_t ret;
 
 	snprintf(path, sizeof(path), "%s/%s", cgroup, control);
 
-	if (read_text(path, buf, len) >= 0)
-		return 0;
-
-	return -1;
+	ret = read_text(path, buf, len);
+	return ret >= 0 ? 0 : ret;
 }
 
 int cg_read_strcmp(const char *cgroup, const char *control,
@@ -177,17 +172,15 @@ long cg_read_lc(const char *cgroup, const char *control)
 	return cnt;
 }
 
+/* Returns 0 on success, or -errno on failure. */
 int cg_write(const char *cgroup, const char *control, char *buf)
 {
 	char path[PATH_MAX];
-	ssize_t len = strlen(buf);
+	ssize_t len = strlen(buf), ret;
 
 	snprintf(path, sizeof(path), "%s/%s", cgroup, control);
-
-	if (write_text(path, buf, len) == len)
-		return 0;
-
-	return -1;
+	ret = write_text(path, buf, len);
+	return ret == len ? 0 : ret;
 }
 
 int cg_find_unified_root(char *root, size_t len)
@@ -545,7 +538,8 @@ ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t
 	else
 		snprintf(path, sizeof(path), "/proc/%d/%s", pid, item);
 
-	return read_text(path, buf, size);
+	size = read_text(path, buf, size);
+	return size < 0 ? -1 : size;
 }
 
 int proc_read_strstr(int pid, bool thread, const char *item, const char *needle)
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

