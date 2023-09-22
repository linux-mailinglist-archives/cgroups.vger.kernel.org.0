Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6317AB0A7
	for <lists+cgroups@lfdr.de>; Fri, 22 Sep 2023 13:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjIVL3Y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 07:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbjIVL3Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 07:29:24 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD579199;
        Fri, 22 Sep 2023 04:29:17 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3ae2896974bso68019b6e.0;
        Fri, 22 Sep 2023 04:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695382157; x=1695986957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STXdhtnmTI3etV8zPaY3R9oC/tPAoDIEDC13dA2eLMM=;
        b=VJVgdirrilR5NCu94OPVPuUO+rsu6ytGZT1jYdL1t69d2JVdBMrn9jt1C9ESa+odsB
         9FQBELLq8rW7mfaaAk5vToLzCZVABoJ5VnTAykiAEHL5IyX78VhOXQu7smTuNFpdYvLf
         v5tVVGI1pel85vXetGx6c3FBzgHj/0irasYJGWZg1mlZLgRmYze7XDBLcvMJcSf6293B
         r6AJKgq9dzFphzca9w/xfBX/PURN4CJs5nPEH1sgstEn5LLEvkGcHYpMdrgi+cbdfGRi
         KjNb0UTacpp0RrlTf+8IWwvCQI5rSLNp6hxur0rWgBxXj7TXABMxXyFaDyeNCUSAiYca
         jj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695382157; x=1695986957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STXdhtnmTI3etV8zPaY3R9oC/tPAoDIEDC13dA2eLMM=;
        b=aIlEJUK2HVVnXUALydw/lyA7iXFCFyNUx+flU+lVKKp8Kd9YpitL8ExxVoDRJC7LTm
         h/+BYmYFFBNycsFQTTBp/1xDPo1MDEgeK9eLX6ebRApSpoFZp6bxLSGnteXEw8JA3YRK
         qU8lenKxaoCIg8CvlLnUNF2sRZrELWAtB5M12C2WL9QYcc/k6a84IzOrfiW4IFYGxR6V
         BZV6IDLtAoYGVQPD1S3caUnUNDtDJpxSwPwsQGTNxyWmZOvgXKhAUTGeuR+jTFC8vBcE
         EEiPBfp4msbOfPRX3X/Gw3lzl8P53ob0QN3deBG/FMUsSNoGHIZaupANldGvZEHCJcv4
         GhKg==
X-Gm-Message-State: AOJu0YyySoDQucN4AF15YzfsYDhw6bUEXNV1tkvHSDsf6dxNB6I8Be64
        fvgrMjmSxz4gOp4O2vWVRKY=
X-Google-Smtp-Source: AGHT+IE9nreh70tEqpwmNq6jBs01TxsDmeDiMnloh1NpfA8gxIsoQ6hZs77V3I2AQqB1ByS5qLOdmw==
X-Received: by 2002:a05:6808:1291:b0:3ad:f6ad:b9c5 with SMTP id a17-20020a056808129100b003adf6adb9c5mr7844656oiw.59.1695382156931;
        Fri, 22 Sep 2023 04:29:16 -0700 (PDT)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id v16-20020aa78090000000b00690beda6987sm2973493pff.77.2023.09.22.04.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 04:29:15 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 6/8] selftests/bpf: Add parallel support for classid
Date:   Fri, 22 Sep 2023 11:28:44 +0000
Message-Id: <20230922112846.4265-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230922112846.4265-1-laoar.shao@gmail.com>
References: <20230922112846.4265-1-laoar.shao@gmail.com>
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

