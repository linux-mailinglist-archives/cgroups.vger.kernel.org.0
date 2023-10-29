Return-Path: <cgroups+bounces-111-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8897DAB1D
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 07:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87042817CF
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 06:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656126108;
	Sun, 29 Oct 2023 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miYtJ1lr"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B12B8F60;
	Sun, 29 Oct 2023 06:15:01 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE22D3;
	Sat, 28 Oct 2023 23:15:00 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b5e6301a19so3422930b3a.0;
        Sat, 28 Oct 2023 23:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698560099; x=1699164899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WGPpwvnjBN7lnD2fLR5fUdnGAqoZjDwFnJqTNXRdHE=;
        b=miYtJ1lr2EwiNR6HZnqsgKm6jDSke7XxX/744VYSS1x1PAVLSO7QDoKsyjZOIDoQwW
         4A9KyRiyic5PJWSZhnz5c9dtGiA8MXqD5tpDogconBnLC0xHVTIdfzuJIBfa5OZK5Amy
         LqFK0Ciq8gt6El8x0VXzvAA/vKcavIgvx5yAaMAuGQ0b8yf434/B9ZWIVb08voMp9vkQ
         fxZvo7KLJUP6jtjAxv32Eaq0HfBg6fJqMmCqoX4SmdQVhl73IPkAa4TuaUK+cJPJ/yPv
         uvgi+F/kBh8oWbCWQNkR8xLEbHfAr1FR4wv/qovkcBzVl++EX2Y0W20fbmN3528R8e7H
         q6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698560099; x=1699164899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WGPpwvnjBN7lnD2fLR5fUdnGAqoZjDwFnJqTNXRdHE=;
        b=rLvlcpQRYteMxZSUbFyPuzry/kGNSSwgb99XrGTd/DwKpzturCiHT0i/lmRPwxvxSV
         f3pqSNP70xO+0R7G1o0qgjAD6rXCy8RjxgbUewWatRs13iasB8DWFKgNGNA7lV+2LEek
         XvsHO4ACgXfYL1R+9ntShUXyhgD28h3l76QeURm7q1fRBUv59IfGhWOgcPON+F50gDYH
         6Mef6v/KXpPDPxwmC2HSZvirN/4i8vk0qHOu7mXKhbfRXUVwkCzW0I+AJPe8nDUJw0IX
         iLTCi8pNK9H4kNjv0LXAjMCv6Bf93YXZVT7rxXshdeqjA8vo467e7oO1Shi0K+Y+yGOR
         aFBw==
X-Gm-Message-State: AOJu0YyyDj8ovTov5PNfGBIlV/vqZ6UQtObJt2KHZpCj2p8MUHgNCuOn
	kLzEOGdEmRE9G/5dP+a9dF4=
X-Google-Smtp-Source: AGHT+IFcHD54lCioxi35XUAefYmbg48pl0iYFvjsVywudDNbnRraEoFm73JMX0cwBjueGpkmZ0A9ig==
X-Received: by 2002:a05:6300:8088:b0:17f:fef8:1f3f with SMTP id ap8-20020a056300808800b0017ffef81f3fmr3467702pzc.4.1698560099531;
        Sat, 28 Oct 2023 23:14:59 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:2b5:5400:4ff:fea0:d066])
        by smtp.gmail.com with ESMTPSA id m2-20020aa79002000000b006b225011ee5sm3775106pfo.6.2023.10.28.23.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 23:14:59 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	mkoutny@suse.com,
	sinquersw@gmail.com,
	longman@redhat.com
Cc: cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	oliver.sang@intel.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 bpf-next 08/11] selftests/bpf: Add parallel support for classid
Date: Sun, 29 Oct 2023 06:14:35 +0000
Message-Id: <20231029061438.4215-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231029061438.4215-1-laoar.shao@gmail.com>
References: <20231029061438.4215-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include the current pid in the classid cgroup path. This way, different
testers relying on classid-based configurations will have distinct classid
cgroup directories, enabling them to run concurrently. Additionally, we
leverage the current pid as the classid, ensuring unique identification.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c         | 18 +++++++++++-------
 tools/testing/selftests/bpf/cgroup_helpers.h         |  2 +-
 tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c |  2 +-
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 10b5f42..f18649a 100644
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
index 5c2cb9c..92fc41d 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -29,7 +29,7 @@ int write_cgroup_file_parent(const char *relative_path, const char *file,
 void cleanup_cgroup_environment(void);
 
 /* cgroupv1 related */
-int set_classid(unsigned int id);
+int set_classid(void);
 int join_classid(void);
 
 int setup_classid_environment(void);
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c b/tools/testing/selftests/bpf/prog_tests/cgroup_v1v2.c
index 9026b42..addf720 100644
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
1.8.3.1


