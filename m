Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD09591647
	for <lists+cgroups@lfdr.de>; Fri, 12 Aug 2022 22:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbiHLU2h (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Aug 2022 16:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbiHLU22 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Aug 2022 16:28:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4626B0284
        for <cgroups@vger.kernel.org>; Fri, 12 Aug 2022 13:28:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d8-20020a25bc48000000b00680651cf051so1532373ybk.23
        for <cgroups@vger.kernel.org>; Fri, 12 Aug 2022 13:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=uV12eGdKe+n9Jqdm1R4Rif6ZW3ISjbMxZHt4ROvBqtk=;
        b=cowJhBN4RmZfPCHZDpbx6s/29zO3yVrWwhM0dI70IbjeRdTmcaXepcmZIjrq3IN83r
         31/Zkxt+YLw1kgRPfxDjw7ZVoZJ7+ASNd6QU5XZQ6OiWifg906R5qKollCADwIo2SAJF
         dbQ5zC+5zpcOgQhNx+vf4ux8d9Zkp3ZDfJ8RNS25EyMyhUEoyzNIku8suoxYFn3y6Gzb
         uNLmWAdu3Sr4X9QFrFmbpQQ/ObipijbDve3gdW5cVIM0OX9OdcxIyylyiFHyY3nnTcDT
         UF4tQu7NNa9BN9Edit8KgM6E7dybHNP4Tqcjk+loU4jNTunCkCu8xl/t0BJTe/ZTvQb9
         W/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=uV12eGdKe+n9Jqdm1R4Rif6ZW3ISjbMxZHt4ROvBqtk=;
        b=gqbksTqpLKC4Thpxw+8Er1z26frIYwYPTlvxOFUO5SeUDfUlUZ0BcFPpr1h2S3EnKf
         ZsvsZOQqBCb6+HEyvPrKLKfZPBIae+At9/gKtxfhAnGwt04wACv7qR88HD7HKWgd8kyP
         n+PKa8+3kP9EvgpeI3c0rStnE7gzLnzfysC4fqI0TG8mbDQHoxuoztsvGs8vRUrunZwJ
         Cw2Wy3sltmBKg/w46ZHYQRtcMVkbIj7ZenHAJL61Xu83Ccx1wAn3dMe6C+V8wMdTa/ah
         1Sbgdr7vee+jP+Iu50z6ZKpL1B289nvwwCGEpMfPtw3G1B6bwEtsx3/ga6EZ8dxH1WGV
         3//Q==
X-Gm-Message-State: ACgBeo1IHWHOraPsafz82961yJjYgFimtO/ZA33EXq0/BRzOlwp/9vXp
        Y0+YtxFgpruV5q14DaXJiPgfSNZ2qvA=
X-Google-Smtp-Source: AA6agR4E+Ia3TBaK880cj9WwMhdSP3yr/F5TTsncj9ZK2cBq2y22i2RDLl9iElkac/ZDlrhhLNOp5UMDlQ0=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2d4:203:da3d:b609:da67:694a])
 (user=haoluo job=sendgmr) by 2002:a05:6902:120f:b0:676:aaa4:8434 with SMTP id
 s15-20020a056902120f00b00676aaa48434mr4778762ybu.218.1660336096862; Fri, 12
 Aug 2022 13:28:16 -0700 (PDT)
Date:   Fri, 12 Aug 2022 13:28:01 -0700
In-Reply-To: <20220812202802.3774257-1-haoluo@google.com>
Message-Id: <20220812202802.3774257-5-haoluo@google.com>
Mime-Version: 1.0
References: <20220812202802.3774257-1-haoluo@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next v8 4/5] selftests/bpf: extend cgroup helpers
From:   Hao Luo <haoluo@google.com>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        KP Singh <kpsingh@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Michal Koutny <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yosry Ahmed <yosryahmed@google.com>

This patch extends bpf selft cgroup_helpers [ID] n various ways:
- Add enable_controllers() that allows tests to enable all or a
  subset of controllers for a specific cgroup.
- Add join_cgroup_parent(). The cgroup workdir is based on the pid,
  therefore a spawned child cannot join the same cgroup hierarchy of the
  test through join_cgroup(). join_cgroup_parent() is used in child
  processes to join a cgroup under the parent's workdir.
- Add write_cgroup_file() and write_cgroup_file_parent() (similar to
  join_cgroup_parent() above).
- Add get_root_cgroup() for tests that need to do checks on root cgroup.
- Distinguish relative and absolute cgroup paths in function arguments.
  Now relative paths are called relative_path, and absolute paths are
  called cgroup_path.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Hao Luo <haoluo@google.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 202 +++++++++++++++----
 tools/testing/selftests/bpf/cgroup_helpers.h |  19 +-
 2 files changed, 174 insertions(+), 47 deletions(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 9d59c3990ca8..e914cc45b766 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -33,49 +33,52 @@
 #define CGROUP_MOUNT_DFLT		"/sys/fs/cgroup"
 #define NETCLS_MOUNT_PATH		CGROUP_MOUNT_DFLT "/net_cls"
 #define CGROUP_WORK_DIR			"/cgroup-test-work-dir"
-#define format_cgroup_path(buf, path) \
+
+#define format_cgroup_path_pid(buf, path, pid) \
 	snprintf(buf, sizeof(buf), "%s%s%d%s", CGROUP_MOUNT_PATH, \
-	CGROUP_WORK_DIR, getpid(), path)
+	CGROUP_WORK_DIR, pid, path)
+
+#define format_cgroup_path(buf, path) \
+	format_cgroup_path_pid(buf, path, getpid())
+
+#define format_parent_cgroup_path(buf, path) \
+	format_cgroup_path_pid(buf, path, getppid())
 
 #define format_classid_path(buf)				\
 	snprintf(buf, sizeof(buf), "%s%s", NETCLS_MOUNT_PATH,	\
 		 CGROUP_WORK_DIR)
 
-/**
- * enable_all_controllers() - Enable all available cgroup v2 controllers
- *
- * Enable all available cgroup v2 controllers in order to increase
- * the code coverage.
- *
- * If successful, 0 is returned.
- */
-static int enable_all_controllers(char *cgroup_path)
+static int __enable_controllers(const char *cgroup_path, const char *controllers)
 {
 	char path[PATH_MAX + 1];
-	char buf[PATH_MAX];
+	char enable[PATH_MAX + 1];
 	char *c, *c2;
 	int fd, cfd;
 	ssize_t len;
 
-	snprintf(path, sizeof(path), "%s/cgroup.controllers", cgroup_path);
-	fd = open(path, O_RDONLY);
-	if (fd < 0) {
-		log_err("Opening cgroup.controllers: %s", path);
-		return 1;
-	}
-
-	len = read(fd, buf, sizeof(buf) - 1);
-	if (len < 0) {
+	/* If not controllers are passed, enable all available controllers */
+	if (!controllers) {
+		snprintf(path, sizeof(path), "%s/cgroup.controllers",
+			 cgroup_path);
+		fd = open(path, O_RDONLY);
+		if (fd < 0) {
+			log_err("Opening cgroup.controllers: %s", path);
+			return 1;
+		}
+		len = read(fd, enable, sizeof(enable) - 1);
+		if (len < 0) {
+			close(fd);
+			log_err("Reading cgroup.controllers: %s", path);
+			return 1;
+		} else if (len == 0) { /* No controllers to enable */
+			close(fd);
+			return 0;
+		}
+		enable[len] = 0;
 		close(fd);
-		log_err("Reading cgroup.controllers: %s", path);
-		return 1;
+	} else {
+		strncpy(enable, controllers, sizeof(enable));
 	}
-	buf[len] = 0;
-	close(fd);
-
-	/* No controllers available? We're probably on cgroup v1. */
-	if (len == 0)
-		return 0;
 
 	snprintf(path, sizeof(path), "%s/cgroup.subtree_control", cgroup_path);
 	cfd = open(path, O_RDWR);
@@ -84,7 +87,7 @@ static int enable_all_controllers(char *cgroup_path)
 		return 1;
 	}
 
-	for (c = strtok_r(buf, " ", &c2); c; c = strtok_r(NULL, " ", &c2)) {
+	for (c = strtok_r(enable, " ", &c2); c; c = strtok_r(NULL, " ", &c2)) {
 		if (dprintf(cfd, "+%s\n", c) <= 0) {
 			log_err("Enabling controller %s: %s", c, path);
 			close(cfd);
@@ -95,6 +98,87 @@ static int enable_all_controllers(char *cgroup_path)
 	return 0;
 }
 
+/**
+ * enable_controllers() - Enable cgroup v2 controllers
+ * @relative_path: The cgroup path, relative to the workdir
+ * @controllers: List of controllers to enable in cgroup.controllers format
+ *
+ *
+ * Enable given cgroup v2 controllers, if @controllers is NULL, enable all
+ * available controllers.
+ *
+ * If successful, 0 is returned.
+ */
+int enable_controllers(const char *relative_path, const char *controllers)
+{
+	char cgroup_path[PATH_MAX + 1];
+
+	format_cgroup_path(cgroup_path, relative_path);
+	return __enable_controllers(cgroup_path, controllers);
+}
+
+static int __write_cgroup_file(const char *cgroup_path, const char *file,
+			       const char *buf)
+{
+	char file_path[PATH_MAX + 1];
+	int fd;
+
+	snprintf(file_path, sizeof(file_path), "%s/%s", cgroup_path, file);
+	fd = open(file_path, O_RDWR);
+	if (fd < 0) {
+		log_err("Opening %s", file_path);
+		return 1;
+	}
+
+	if (dprintf(fd, "%s", buf) <= 0) {
+		log_err("Writing to %s", file_path);
+		close(fd);
+		return 1;
+	}
+	close(fd);
+	return 0;
+}
+
+/**
+ * write_cgroup_file() - Write to a cgroup file
+ * @relative_path: The cgroup path, relative to the workdir
+ * @file: The name of the file in cgroupfs to write to
+ * @buf: Buffer to write to the file
+ *
+ * Write to a file in the given cgroup's directory.
+ *
+ * If successful, 0 is returned.
+ */
+int write_cgroup_file(const char *relative_path, const char *file,
+		      const char *buf)
+{
+	char cgroup_path[PATH_MAX - 24];
+
+	format_cgroup_path(cgroup_path, relative_path);
+	return __write_cgroup_file(cgroup_path, file, buf);
+}
+
+/**
+ * write_cgroup_file_parent() - Write to a cgroup file in the parent process
+ *                              workdir
+ * @relative_path: The cgroup path, relative to the parent process workdir
+ * @file: The name of the file in cgroupfs to write to
+ * @buf: Buffer to write to the file
+ *
+ * Write to a file in the given cgroup's directory under the parent process
+ * workdir.
+ *
+ * If successful, 0 is returned.
+ */
+int write_cgroup_file_parent(const char *relative_path, const char *file,
+			     const char *buf)
+{
+	char cgroup_path[PATH_MAX - 24];
+
+	format_parent_cgroup_path(cgroup_path, relative_path);
+	return __write_cgroup_file(cgroup_path, file, buf);
+}
+
 /**
  * setup_cgroup_environment() - Setup the cgroup environment
  *
@@ -133,7 +217,9 @@ int setup_cgroup_environment(void)
 		return 1;
 	}
 
-	if (enable_all_controllers(cgroup_workdir))
+	/* Enable all available controllers to increase test coverage */
+	if (__enable_controllers(CGROUP_MOUNT_PATH, NULL) ||
+	    __enable_controllers(cgroup_workdir, NULL))
 		return 1;
 
 	return 0;
@@ -173,7 +259,7 @@ static int join_cgroup_from_top(const char *cgroup_path)
 
 /**
  * join_cgroup() - Join a cgroup
- * @path: The cgroup path, relative to the workdir, to join
+ * @relative_path: The cgroup path, relative to the workdir, to join
  *
  * This function expects a cgroup to already be created, relative to the cgroup
  * work dir, and it joins it. For example, passing "/my-cgroup" as the path
@@ -182,11 +268,27 @@ static int join_cgroup_from_top(const char *cgroup_path)
  *
  * On success, it returns 0, otherwise on failure it returns 1.
  */
-int join_cgroup(const char *path)
+int join_cgroup(const char *relative_path)
+{
+	char cgroup_path[PATH_MAX + 1];
+
+	format_cgroup_path(cgroup_path, relative_path);
+	return join_cgroup_from_top(cgroup_path);
+}
+
+/**
+ * join_parent_cgroup() - Join a cgroup in the parent process workdir
+ * @relative_path: The cgroup path, relative to parent process workdir, to join
+ *
+ * See join_cgroup().
+ *
+ * On success, it returns 0, otherwise on failure it returns 1.
+ */
+int join_parent_cgroup(const char *relative_path)
 {
 	char cgroup_path[PATH_MAX + 1];
 
-	format_cgroup_path(cgroup_path, path);
+	format_parent_cgroup_path(cgroup_path, relative_path);
 	return join_cgroup_from_top(cgroup_path);
 }
 
@@ -212,9 +314,27 @@ void cleanup_cgroup_environment(void)
 	nftw(cgroup_workdir, nftwfunc, WALK_FD_LIMIT, FTW_DEPTH | FTW_MOUNT);
 }
 
+/**
+ * get_root_cgroup() - Get the FD of the root cgroup
+ *
+ * On success, it returns the file descriptor. On failure, it returns -1.
+ * If there is a failure, it prints the error to stderr.
+ */
+int get_root_cgroup(void)
+{
+	int fd;
+
+	fd = open(CGROUP_MOUNT_PATH, O_RDONLY);
+	if (fd < 0) {
+		log_err("Opening root cgroup");
+		return -1;
+	}
+	return fd;
+}
+
 /**
  * create_and_get_cgroup() - Create a cgroup, relative to workdir, and get the FD
- * @path: The cgroup path, relative to the workdir, to join
+ * @relative_path: The cgroup path, relative to the workdir, to join
  *
  * This function creates a cgroup under the top level workdir and returns the
  * file descriptor. It is idempotent.
@@ -222,14 +342,14 @@ void cleanup_cgroup_environment(void)
  * On success, it returns the file descriptor. On failure it returns -1.
  * If there is a failure, it prints the error to stderr.
  */
-int create_and_get_cgroup(const char *path)
+int create_and_get_cgroup(const char *relative_path)
 {
 	char cgroup_path[PATH_MAX + 1];
 	int fd;
 
-	format_cgroup_path(cgroup_path, path);
+	format_cgroup_path(cgroup_path, relative_path);
 	if (mkdir(cgroup_path, 0777) && errno != EEXIST) {
-		log_err("mkdiring cgroup %s .. %s", path, cgroup_path);
+		log_err("mkdiring cgroup %s .. %s", relative_path, cgroup_path);
 		return -1;
 	}
 
@@ -244,13 +364,13 @@ int create_and_get_cgroup(const char *path)
 
 /**
  * get_cgroup_id() - Get cgroup id for a particular cgroup path
- * @path: The cgroup path, relative to the workdir, to join
+ * @relative_path: The cgroup path, relative to the workdir, to join
  *
  * On success, it returns the cgroup id. On failure it returns 0,
  * which is an invalid cgroup id.
  * If there is a failure, it prints the error to stderr.
  */
-unsigned long long get_cgroup_id(const char *path)
+unsigned long long get_cgroup_id(const char *relative_path)
 {
 	int dirfd, err, flags, mount_id, fhsize;
 	union {
@@ -261,7 +381,7 @@ unsigned long long get_cgroup_id(const char *path)
 	struct file_handle *fhp, *fhp2;
 	unsigned long long ret = 0;
 
-	format_cgroup_path(cgroup_workdir, path);
+	format_cgroup_path(cgroup_workdir, relative_path);
 
 	dirfd = AT_FDCWD;
 	flags = 0;
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index fcc9cb91b211..3358734356ab 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -10,11 +10,18 @@
 	__FILE__, __LINE__, clean_errno(), ##__VA_ARGS__)
 
 /* cgroupv2 related */
-int cgroup_setup_and_join(const char *path);
-int create_and_get_cgroup(const char *path);
-unsigned long long get_cgroup_id(const char *path);
-
-int join_cgroup(const char *path);
+int enable_controllers(const char *relative_path, const char *controllers);
+int write_cgroup_file(const char *relative_path, const char *file,
+		      const char *buf);
+int write_cgroup_file_parent(const char *relative_path, const char *file,
+			     const char *buf);
+int cgroup_setup_and_join(const char *relative_path);
+int get_root_cgroup(void);
+int create_and_get_cgroup(const char *relative_path);
+unsigned long long get_cgroup_id(const char *relative_path);
+
+int join_cgroup(const char *relative_path);
+int join_parent_cgroup(const char *relative_path);
 
 int setup_cgroup_environment(void);
 void cleanup_cgroup_environment(void);
@@ -26,4 +33,4 @@ int join_classid(void);
 int setup_classid_environment(void);
 void cleanup_classid_environment(void);
 
-#endif /* __CGROUP_HELPERS_H */
\ No newline at end of file
+#endif /* __CGROUP_HELPERS_H */
-- 
2.37.1.595.g718a3a8f04-goog

