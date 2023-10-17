Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202047CC38D
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 14:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbjJQMqT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Oct 2023 08:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343562AbjJQMqR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Oct 2023 08:46:17 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677A195;
        Tue, 17 Oct 2023 05:46:15 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b201a93c9cso3353834b3a.0;
        Tue, 17 Oct 2023 05:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697546775; x=1698151575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QiU9AAAE0pUaYi7vmDEGmJj0rpR0kjK+y05BuChJhI=;
        b=D44Lpzod3MAln59bsY9yUKWEMgaS7dbETKcNfIMVjxpAUAvEU7JbzUMNKkExWCC3q5
         bQFklM8cIWFLM8zIXJxtRKCVmYutLwkZPMsP6eaWKbIHbH26+ctoFCd2z/4o/vZCT/ec
         esH7uuAE1T0AHDyTLVcXGaZo5DK4VrrKlhly84cn4iVEOw1whvU2fY9hO8KqjdJExANP
         bM34SUF5bsvJo9M1opgmPvhEddMSD0kiJrx1C+XUFEQmzQJkquIpV5iRHyXPxlXK8HPP
         ioALZP6rY8PSK0NOn8zQX6M2tJMuLDQpUAksQ5ORBoKSafjIgUjhHxnQZu1HsVMRm+wn
         oYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697546775; x=1698151575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QiU9AAAE0pUaYi7vmDEGmJj0rpR0kjK+y05BuChJhI=;
        b=ffCljzZqr5v/9XSurk46qzs0AN30H7EEo7RIHFWFkVNkewn3XZrm/3wA2EE5Scgicr
         twtZa3f70V92+KAHOFNIs1hx0Qed5ciV3fwo/dzJPiAM/y63v6HhdrObdh4yDyzA725L
         vFVmAlBh4BmTJ3BQQYOz2akSArjnzuBbZOL9XnMAOE5apei5/A5YZPHENN5nP1s/1SgC
         /NESCS+5FtGnaZYOt2t3cUdDmkJbCdafPikw52Q9Gy0M5C6a4JZz40PKWRt6vsu0QAic
         ZUce6yaJnZmXpLAddl9kSggtLUhcA077GCnM9nzMFEDqZPOsCRNhZDAJcuuJg+kNn/OO
         aopg==
X-Gm-Message-State: AOJu0YzvSTOoCigTNtz5kINkBfFdz9ATDJ2kScO29OJWqmYJzOfoKueN
        H0evMwgzB+tGOlSiE/OwWJI=
X-Google-Smtp-Source: AGHT+IHF2vvIgoRrEFpx6PDzLtkN727GQVblAAIU8qsHNiCX2BySfyA+t9LSCoimWNoQTDjSFGd0fg==
X-Received: by 2002:a05:6a00:2283:b0:6b4:c21c:8b56 with SMTP id f3-20020a056a00228300b006b4c21c8b56mr2374713pfe.23.1697546774839;
        Tue, 17 Oct 2023 05:46:14 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:3b2:5400:4ff:fe9b:d21b])
        by smtp.gmail.com with ESMTPSA id fa36-20020a056a002d2400b006bdf4dfbe0dsm1375595pfb.12.2023.10.17.05.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:46:14 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com, sinquersw@gmail.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next v2 6/9] selftests/bpf: Add parallel support for classid
Date:   Tue, 17 Oct 2023 12:45:43 +0000
Message-Id: <20231017124546.24608-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231017124546.24608-1-laoar.shao@gmail.com>
References: <20231017124546.24608-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Include the current pid in the classid cgroup path. This way, different
testers relying on classid-based configurations will have distinct classid
cgroup directories, enabling them to run concurrently. Additionally, we
leverage the current pid as the classid, ensuring unique identification.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c   | 18 +++++++++++-------
 tools/testing/selftests/bpf/cgroup_helpers.h   |  2 +-
 .../selftests/bpf/prog_tests/cgroup_v1v2.c     |  2 +-
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 10b5f42e65e7..f18649a79d64 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -45,9 +45,12 @@
 #define format_parent_cgroup_path(buf, path) \
 	format_cgroup_path_pid(buf, path, getppid())
 
-#define format_classid_path(buf)				\
-	snprintf(buf, sizeof(buf), "%s%s", NETCLS_MOUNT_PATH,	\
-		 CGROUP_WORK_DIR)
+#define format_classid_path_pid(buf, pid)				\
+	snprintf(buf, sizeof(buf), "%s%s%d", NETCLS_MOUNT_PATH,	\
+		 CGROUP_WORK_DIR, pid)
+
+#define format_classid_path(buf)	\
+	format_classid_path_pid(buf, getpid())
 
 static __thread bool cgroup_workdir_mounted;
 
@@ -551,15 +554,16 @@ int setup_classid_environment(void)
 
 /**
  * set_classid() - Set a cgroupv1 net_cls classid
- * @id: the numeric classid
  *
- * Writes the passed classid into the cgroup work dir's net_cls.classid
+ * Writes the classid into the cgroup work dir's net_cls.classid
  * file in order to later on trigger socket tagging.
  *
+ * We leverage the current pid as the classid, ensuring unique identification.
+ *
  * On success, it returns 0, otherwise on failure it returns 1. If there
  * is a failure, it prints the error to stderr.
  */
-int set_classid(unsigned int id)
+int set_classid(void)
 {
 	char cgroup_workdir[PATH_MAX - 42];
 	char cgroup_classid_path[PATH_MAX + 1];
@@ -575,7 +579,7 @@ int set_classid(unsigned int id)
 		return 1;
 	}
 
-	if (dprintf(fd, "%u\n", id) < 0) {
+	if (dprintf(fd, "%u\n", getpid()) < 0) {
 		log_err("Setting cgroup classid");
 		rc = 1;
 	}
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index 5c2cb9c8b546..92fc41daf4a4 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -29,7 +29,7 @@ int setup_cgroup_environment(void);
 void cleanup_cgroup_environment(void);
 
 /* cgroupv1 related */
-int set_classid(unsigned int id);
+int set_classid(void);
 int join_classid(void);
 
 int setup_classid_environment(void);
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c b/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
index 9026b42914d3..addf720428f7 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
@@ -71,7 +71,7 @@ void test_cgroup_v1v2(void)
 	}
 	ASSERT_OK(run_test(cgroup_fd, server_fd, false), "cgroup-v2-only");
 	setup_classid_environment();
-	set_classid(42);
+	set_classid();
 	ASSERT_OK(run_test(cgroup_fd, server_fd, true), "cgroup-v1v2");
 	cleanup_classid_environment();
 	close(server_fd);
-- 
2.30.1 (Apple Git-130)

