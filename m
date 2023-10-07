Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61727BC839
	for <lists+cgroups@lfdr.de>; Sat,  7 Oct 2023 16:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344004AbjJGODZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Oct 2023 10:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343933AbjJGODZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Oct 2023 10:03:25 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099D2BD;
        Sat,  7 Oct 2023 07:03:24 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c5c91bec75so23168595ad.3;
        Sat, 07 Oct 2023 07:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696687403; x=1697292203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STXdhtnmTI3etV8zPaY3R9oC/tPAoDIEDC13dA2eLMM=;
        b=FwSZbahfWgi2/baWR7klHWtCrdDGwmkX4RmxB1y7tD7wn5+Bkq+Y7jgCw0WjEvD+xd
         e6rQXD/Day6GlBv9zry/8Nl5Vn3eny8nfrCKrq2FxUMnDDF9m2wZ9zoqQWCa7uXBXYk1
         xjLaxvfJiU88jpXHWHarBscV++DDBLexkn8fF/IHnFgaIcwBh77dAr+qeQ+4z22cpeTu
         gDk7kKBYvh63pEsJG6NUL0DO+CZ0Ajiu5tPWHR7Qp9fyDoVucjKLSTmnl0higF3EgeTq
         yMDiTN8uXv/V+nSa+Ek8pcvS6YK4Y2+iurSFu9sJCbMUUoklLaP+f3aL7+0xqlRLF1qe
         wbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696687403; x=1697292203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STXdhtnmTI3etV8zPaY3R9oC/tPAoDIEDC13dA2eLMM=;
        b=IYXT2CIoa/G9xlEhFaWSyQCQV5kfj40WNZs0G0ArpKvuUqQ0QZM4TW8YXVaFeNzsmk
         mx1W1XimZxArvb7XVu8SDvY6s5sXWCb8+5LBHfCygBtMFEIS7dtB4ydiDmyVaTO/ErUS
         hOzUguHEgCT6XSuTVVOT6Ndb8kz+kH48pLcVIiedUxpQ9X8EiXpzWIC2bGhe+GVuNCEI
         XHQ/owpTMErmB6/qrSWT+g4W5/xUvz5dtdqmhX7fEBksIBsYQOIJjU41YV3VPk0+s80o
         rEDjFizOS/PEMB7VtjL+mogb59Xe9gW7+Wsk/L4E3M5wuQx7YI7VdCfGHCiHAubBo8Ex
         +e/Q==
X-Gm-Message-State: AOJu0Yx0X6rHj5RtMK3Luggx+nG0oGC6ou01FDaN7YRNe4BAR1Wc2d+Z
        QAbgTJizTkj0k3NhhYtSkZM=
X-Google-Smtp-Source: AGHT+IHtvkrd6iYtNGvkTLbptz6laKnr44PN3Ek6NbIjaWkMapFuSct5onQ0NQ6wq5211TZ8p4QYVQ==
X-Received: by 2002:a17:902:be03:b0:1c4:c5d:d7fa with SMTP id r3-20020a170902be0300b001c40c5dd7famr9316704pls.45.1696687403452;
        Sat, 07 Oct 2023 07:03:23 -0700 (PDT)
Received: from vultr.guest ([45.77.191.53])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b001c0a414695dsm5897550plg.62.2023.10.07.07.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 07:03:22 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com, sinquersw@gmail.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 5/8] selftests/bpf: Add parallel support for classid
Date:   Sat,  7 Oct 2023 14:03:01 +0000
Message-Id: <20231007140304.4390-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231007140304.4390-1-laoar.shao@gmail.com>
References: <20231007140304.4390-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 tools/testing/selftests/bpf/cgroup_helpers.c  | 19 ++++++++++++-------
 tools/testing/selftests/bpf/cgroup_helpers.h  |  2 +-
 .../selftests/bpf/prog_tests/cgroup_v1v2.c    |  2 +-
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 9c36d1db9f94..e378fa057757 100644
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
 
@@ -546,15 +549,17 @@ int setup_classid_environment(void)
 
 /**
  * set_classid() - Set a cgroupv1 net_cls classid
- * @id: the numeric classid
  *
- * Writes the passed classid into the cgroup work dir's net_cls.classid
+ * Writes the classid into the cgroup work dir's net_cls.classid
  * file in order to later on trigger socket tagging.
  *
+ * To make sure different classid testers have different classids, we use
+ * the current pid as the classid by default.
+ *
  * On success, it returns 0, otherwise on failure it returns 1. If there
  * is a failure, it prints the error to stderr.
  */
-int set_classid(unsigned int id)
+int set_classid(void)
 {
 	char cgroup_workdir[PATH_MAX - 42];
 	char cgroup_classid_path[PATH_MAX + 1];
@@ -570,7 +575,7 @@ int set_classid(unsigned int id)
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

