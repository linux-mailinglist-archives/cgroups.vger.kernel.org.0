Return-Path: <cgroups+bounces-865-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EA4806F34
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 12:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307FB281C0D
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 11:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A4F358AD;
	Wed,  6 Dec 2023 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDP1DuQc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE60910C7;
	Wed,  6 Dec 2023 03:53:41 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6ce6d926f76so590532b3a.1;
        Wed, 06 Dec 2023 03:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701863621; x=1702468421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7mEvnvlfFVPbJKnG6vNfNJSUIO1dwSv0/95HJsiQ+Y=;
        b=KDP1DuQcwYrY/sjjH02qGuN1AM89/+kiTfFGppbM4U+440Y3g0cjv8M2FPYu9uUGus
         s8l7KmpY2au2aP1yB/LdaOU5eDtrvDu6splZ7nC/OOUpwO1KjWSJixLVSQxrqIJtQoJa
         EYNih4FBXPpR6Jd8LfzlQ1r9r8X9U52krlv8OZMTuTuH+gxLJpK/Qir2Xv8DKGfO1vWQ
         s2hf9/IYDZa46kq/sYytF9izqCIB+AWbSEW/w+BemDthv4yJd2l+ffdsQaGiRHUyHplo
         QbVKtvHxKC8x0WCzKiCCv2nR7w/SH5FSR160bANhGFrUWkjwI16xJZFPZsiWr6OnWFfr
         1xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701863621; x=1702468421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7mEvnvlfFVPbJKnG6vNfNJSUIO1dwSv0/95HJsiQ+Y=;
        b=Zcg3UuvcbXi8302ZhMF02aAaWpEJxB5CyFMGzX0uSdnT/hgkfHvV1OhQzh3uBMh5Xv
         mK2EotVzrO4he3ePSqcrA/wAqOBXmf3P88mELmP1lU+Enx/rxgAzO/vR96nDc8YUQ3Nd
         Wu3PVs9Myle/orxHrZiELzJKvuHa9XiTu6y9RzyjekEjZMFQCfkKkuThe2JiEKdKY4jf
         NPyW7Dh8KhutqhGeohtQiAd3+JKYzQDSmugmveYGDWT06MxZYARZ6aBChNLj9W79ydDj
         vdhhtRE1a+jVKKSz4VYlnPi8fKuWe3KZ/0RzX8x6Zvok23+XVTGQWnqmJJLopnTpGXaE
         aXbw==
X-Gm-Message-State: AOJu0Yx5sQALgGukoID9wRc0ncZ6UiKrNtAW5LXREHllyaPaVQdzZWP1
	W5x/KGbwEOdugO88oaDn+KGtd7yFdZhYcTP2
X-Google-Smtp-Source: AGHT+IEdEMolsVSDL0Wli5RFxzotcZlG8+Njukzpu1rCSwttR/IoNoO5Z8i8bsKpsLkHvcgij13UNQ==
X-Received: by 2002:a05:6a20:8e1f:b0:18d:d16:e84 with SMTP id y31-20020a056a208e1f00b0018d0d160e84mr4014884pzj.7.1701863620645;
        Wed, 06 Dec 2023 03:53:40 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id n15-20020a638f0f000000b005c6801efa0fsm5484665pgd.28.2023.12.06.03.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 03:53:40 -0800 (PST)
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
	tj@kernel.org
Cc: bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add selftests for cgroup1 local storage
Date: Wed,  6 Dec 2023 11:53:26 +0000
Message-Id: <20231206115326.4295-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231206115326.4295-1-laoar.shao@gmail.com>
References: <20231206115326.4295-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expanding the test coverage from cgroup2 to include cgroup1. The result
as follows,

Already existing test cases for cgroup2:
  #48/1    cgrp_local_storage/tp_btf:OK
  #48/2    cgrp_local_storage/attach_cgroup:OK
  #48/3    cgrp_local_storage/recursion:OK
  #48/4    cgrp_local_storage/negative:OK
  #48/5    cgrp_local_storage/cgroup_iter_sleepable:OK
  #48/6    cgrp_local_storage/yes_rcu_lock:OK
  #48/7    cgrp_local_storage/no_rcu_lock:OK

Expanded test cases for cgroup1:
  #48/8    cgrp_local_storage/cgrp1_tp_btf:OK
  #48/9    cgrp_local_storage/cgrp1_recursion:OK
  #48/10   cgrp_local_storage/cgrp1_negative:OK
  #48/11   cgrp_local_storage/cgrp1_iter_sleepable:OK
  #48/12   cgrp_local_storage/cgrp1_yes_rcu_lock:OK
  #48/13   cgrp_local_storage/cgrp1_no_rcu_lock:OK

Summary:
  #48      cgrp_local_storage:OK
  Summary: 1/13 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/cgrp_local_storage.c  | 98 +++++++++++++++++++++-
 .../selftests/bpf/progs/cgrp_ls_recursion.c        | 84 +++++++++++++++----
 .../selftests/bpf/progs/cgrp_ls_sleepable.c        | 61 ++++++++++++--
 tools/testing/selftests/bpf/progs/cgrp_ls_tp_btf.c | 82 +++++++++++++-----
 4 files changed, 278 insertions(+), 47 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
index 63e776f..317da4d 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
@@ -19,6 +19,21 @@ struct socket_cookie {
 	__u64 cookie_value;
 };
 
+bool is_cgroup1;
+int target_hid;
+
+#define CGROUP_MODE_SET(skel)			\
+{						\
+	skel->bss->is_cgroup1 = is_cgroup1;	\
+	skel->bss->target_hid = target_hid;	\
+}
+
+static void cgroup_mode_value_init(bool cgroup, int hid)
+{
+	is_cgroup1 = cgroup;
+	target_hid = hid;
+}
+
 static void test_tp_btf(int cgroup_fd)
 {
 	struct cgrp_ls_tp_btf *skel;
@@ -29,6 +44,8 @@ static void test_tp_btf(int cgroup_fd)
 	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
 		return;
 
+	CGROUP_MODE_SET(skel);
+
 	/* populate a value in map_b */
 	err = bpf_map_update_elem(bpf_map__fd(skel->maps.map_b), &cgroup_fd, &val1, BPF_ANY);
 	if (!ASSERT_OK(err, "map_update_elem"))
@@ -130,6 +147,8 @@ static void test_recursion(int cgroup_fd)
 	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
 		return;
 
+	CGROUP_MODE_SET(skel);
+
 	err = cgrp_ls_recursion__attach(skel);
 	if (!ASSERT_OK(err, "skel_attach"))
 		goto out;
@@ -165,6 +184,8 @@ static void test_cgroup_iter_sleepable(int cgroup_fd, __u64 cgroup_id)
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
+	CGROUP_MODE_SET(skel);
+
 	bpf_program__set_autoload(skel->progs.cgroup_iter, true);
 	err = cgrp_ls_sleepable__load(skel);
 	if (!ASSERT_OK(err, "skel_load"))
@@ -202,6 +223,7 @@ static void test_yes_rcu_lock(__u64 cgroup_id)
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
+	CGROUP_MODE_SET(skel);
 	skel->bss->target_pid = syscall(SYS_gettid);
 
 	bpf_program__set_autoload(skel->progs.yes_rcu_lock, true);
@@ -229,6 +251,8 @@ static void test_no_rcu_lock(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
+	CGROUP_MODE_SET(skel);
+
 	bpf_program__set_autoload(skel->progs.no_rcu_lock, true);
 	err = cgrp_ls_sleepable__load(skel);
 	ASSERT_ERR(err, "skel_load");
@@ -236,7 +260,25 @@ static void test_no_rcu_lock(void)
 	cgrp_ls_sleepable__destroy(skel);
 }
 
-void test_cgrp_local_storage(void)
+static void test_cgrp1_no_rcu_lock(void)
+{
+	struct cgrp_ls_sleepable *skel;
+	int err;
+
+	skel = cgrp_ls_sleepable__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	CGROUP_MODE_SET(skel);
+
+	bpf_program__set_autoload(skel->progs.cgrp1_no_rcu_lock, true);
+	err = cgrp_ls_sleepable__load(skel);
+	ASSERT_OK(err, "skel_load");
+
+	cgrp_ls_sleepable__destroy(skel);
+}
+
+void cgrp2_local_storage(void)
 {
 	__u64 cgroup_id;
 	int cgroup_fd;
@@ -245,6 +287,8 @@ void test_cgrp_local_storage(void)
 	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup /cgrp_local_storage"))
 		return;
 
+	cgroup_mode_value_init(0, -1);
+
 	cgroup_id = get_cgroup_id("/cgrp_local_storage");
 	if (test__start_subtest("tp_btf"))
 		test_tp_btf(cgroup_fd);
@@ -263,3 +307,55 @@ void test_cgrp_local_storage(void)
 
 	close(cgroup_fd);
 }
+
+void cgrp1_local_storage(void)
+{
+	int cgrp1_fd, cgrp1_hid, cgrp1_id, err;
+
+	/* Setup cgroup1 hierarchy */
+	err = setup_classid_environment();
+	if (!ASSERT_OK(err, "setup_classid_environment"))
+		return;
+
+	err = join_classid();
+	if (!ASSERT_OK(err, "join_cgroup1"))
+		goto cleanup;
+
+	cgrp1_fd = open_classid();
+	if (!ASSERT_GE(cgrp1_fd, 0, "cgroup1 fd"))
+		goto cleanup;
+
+	cgrp1_id = get_classid_cgroup_id();
+	if (!ASSERT_GE(cgrp1_id, 0, "cgroup1 id"))
+		goto close_fd;
+
+	cgrp1_hid = get_cgroup1_hierarchy_id("net_cls");
+	if (!ASSERT_GE(cgrp1_hid, 0, "cgroup1 hid"))
+		goto close_fd;
+
+	cgroup_mode_value_init(1, cgrp1_hid);
+
+	if (test__start_subtest("cgrp1_tp_btf"))
+		test_tp_btf(cgrp1_fd);
+	if (test__start_subtest("cgrp1_recursion"))
+		test_recursion(cgrp1_fd);
+	if (test__start_subtest("cgrp1_negative"))
+		test_negative();
+	if (test__start_subtest("cgrp1_iter_sleepable"))
+		test_cgroup_iter_sleepable(cgrp1_fd, cgrp1_id);
+	if (test__start_subtest("cgrp1_yes_rcu_lock"))
+		test_yes_rcu_lock(cgrp1_id);
+	if (test__start_subtest("cgrp1_no_rcu_lock"))
+		test_cgrp1_no_rcu_lock();
+
+close_fd:
+	close(cgrp1_fd);
+cleanup:
+	cleanup_classid_environment();
+}
+
+void test_cgrp_local_storage(void)
+{
+	cgrp2_local_storage();
+	cgrp1_local_storage();
+}
diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c b/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
index a043d8f..610c2427 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
@@ -21,50 +21,100 @@ struct {
 	__type(value, long);
 } map_b SEC(".maps");
 
+int target_hid = 0;
+bool is_cgroup1 = 0;
+
+struct cgroup *bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id) __ksym;
+void bpf_cgroup_release(struct cgroup *cgrp) __ksym;
+
+static void __on_lookup(struct cgroup *cgrp)
+{
+	bpf_cgrp_storage_delete(&map_a, cgrp);
+	bpf_cgrp_storage_delete(&map_b, cgrp);
+}
+
 SEC("fentry/bpf_local_storage_lookup")
 int BPF_PROG(on_lookup)
 {
 	struct task_struct *task = bpf_get_current_task_btf();
+	struct cgroup *cgrp;
+
+	if (is_cgroup1) {
+		cgrp = bpf_task_get_cgroup1(task, target_hid);
+		if (!cgrp)
+			return 0;
 
-	bpf_cgrp_storage_delete(&map_a, task->cgroups->dfl_cgrp);
-	bpf_cgrp_storage_delete(&map_b, task->cgroups->dfl_cgrp);
+		__on_lookup(cgrp);
+		bpf_cgroup_release(cgrp);
+		return 0;
+	}
+
+	__on_lookup(task->cgroups->dfl_cgrp);
 	return 0;
 }
 
-SEC("fentry/bpf_local_storage_update")
-int BPF_PROG(on_update)
+static void __on_update(struct cgroup *cgrp)
 {
-	struct task_struct *task = bpf_get_current_task_btf();
 	long *ptr;
 
-	ptr = bpf_cgrp_storage_get(&map_a, task->cgroups->dfl_cgrp, 0,
-				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	ptr = bpf_cgrp_storage_get(&map_a, cgrp, 0, BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (ptr)
 		*ptr += 1;
 
-	ptr = bpf_cgrp_storage_get(&map_b, task->cgroups->dfl_cgrp, 0,
-				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	ptr = bpf_cgrp_storage_get(&map_b, cgrp, 0, BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (ptr)
 		*ptr += 1;
+}
 
+SEC("fentry/bpf_local_storage_update")
+int BPF_PROG(on_update)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct cgroup *cgrp;
+
+	if (is_cgroup1) {
+		cgrp = bpf_task_get_cgroup1(task, target_hid);
+		if (!cgrp)
+			return 0;
+
+		__on_update(cgrp);
+		bpf_cgroup_release(cgrp);
+		return 0;
+	}
+
+	__on_update(task->cgroups->dfl_cgrp);
 	return 0;
 }
 
-SEC("tp_btf/sys_enter")
-int BPF_PROG(on_enter, struct pt_regs *regs, long id)
+static void __on_enter(struct pt_regs *regs, long id, struct cgroup *cgrp)
 {
-	struct task_struct *task;
 	long *ptr;
 
-	task = bpf_get_current_task_btf();
-	ptr = bpf_cgrp_storage_get(&map_a, task->cgroups->dfl_cgrp, 0,
-				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	ptr = bpf_cgrp_storage_get(&map_a, cgrp, 0, BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (ptr)
 		*ptr = 200;
 
-	ptr = bpf_cgrp_storage_get(&map_b, task->cgroups->dfl_cgrp, 0,
-				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	ptr = bpf_cgrp_storage_get(&map_b, cgrp, 0, BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (ptr)
 		*ptr = 100;
+}
+
+SEC("tp_btf/sys_enter")
+int BPF_PROG(on_enter, struct pt_regs *regs, long id)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct cgroup *cgrp;
+
+	if (is_cgroup1) {
+		cgrp = bpf_task_get_cgroup1(task, target_hid);
+		if (!cgrp)
+			return 0;
+
+		__on_enter(regs, id, cgrp);
+		bpf_cgroup_release(cgrp);
+		return 0;
+	}
+
+	__on_enter(regs, id, task->cgroups->dfl_cgrp);
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c b/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
index 4c7844e..facedd8 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
@@ -17,7 +17,11 @@ struct {
 
 __u32 target_pid;
 __u64 cgroup_id;
+int target_hid;
+bool is_cgroup1;
 
+struct cgroup *bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id) __ksym;
+void bpf_cgroup_release(struct cgroup *cgrp) __ksym;
 void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;
 
@@ -37,23 +41,50 @@ int cgroup_iter(struct bpf_iter__cgroup *ctx)
 	return 0;
 }
 
+static void __no_rcu_lock(struct cgroup *cgrp)
+{
+	long *ptr;
+
+	/* Note that trace rcu is held in sleepable prog, so we can use
+	 * bpf_cgrp_storage_get() in sleepable prog.
+	 */
+	ptr = bpf_cgrp_storage_get(&map_a, cgrp, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (ptr)
+		cgroup_id = cgrp->kn->id;
+}
+
 SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
-int no_rcu_lock(void *ctx)
+int cgrp1_no_rcu_lock(void *ctx)
 {
 	struct task_struct *task;
 	struct cgroup *cgrp;
-	long *ptr;
+
+	task = bpf_get_current_task_btf();
+	if (task->pid != target_pid)
+		return 0;
+
+	/* bpf_task_get_cgroup1 can work in sleepable prog */
+	cgrp = bpf_task_get_cgroup1(task, target_hid);
+	if (!cgrp)
+		return 0;
+
+	__no_rcu_lock(cgrp);
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int no_rcu_lock(void *ctx)
+{
+	struct task_struct *task;
 
 	task = bpf_get_current_task_btf();
 	if (task->pid != target_pid)
 		return 0;
 
 	/* task->cgroups is untrusted in sleepable prog outside of RCU CS */
-	cgrp = task->cgroups->dfl_cgrp;
-	ptr = bpf_cgrp_storage_get(&map_a, cgrp, 0,
-				   BPF_LOCAL_STORAGE_GET_F_CREATE);
-	if (ptr)
-		cgroup_id = cgrp->kn->id;
+	__no_rcu_lock(task->cgroups->dfl_cgrp);
 	return 0;
 }
 
@@ -68,6 +99,22 @@ int yes_rcu_lock(void *ctx)
 	if (task->pid != target_pid)
 		return 0;
 
+	if (is_cgroup1) {
+		bpf_rcu_read_lock();
+		cgrp = bpf_task_get_cgroup1(task, target_hid);
+		if (!cgrp) {
+			bpf_rcu_read_unlock();
+			return 0;
+		}
+
+		ptr = bpf_cgrp_storage_get(&map_a, cgrp, 0, BPF_LOCAL_STORAGE_GET_F_CREATE);
+		if (ptr)
+			cgroup_id = cgrp->kn->id;
+		bpf_cgroup_release(cgrp);
+		bpf_rcu_read_unlock();
+		return 0;
+	}
+
 	bpf_rcu_read_lock();
 	cgrp = task->cgroups->dfl_cgrp;
 	/* cgrp is trusted under RCU CS */
diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_tp_btf.c b/tools/testing/selftests/bpf/progs/cgrp_ls_tp_btf.c
index 9ebb8e2..1c348f0 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_ls_tp_btf.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_ls_tp_btf.c
@@ -27,62 +27,100 @@ struct {
 int mismatch_cnt = 0;
 int enter_cnt = 0;
 int exit_cnt = 0;
+int target_hid = 0;
+bool is_cgroup1 = 0;
 
-SEC("tp_btf/sys_enter")
-int BPF_PROG(on_enter, struct pt_regs *regs, long id)
+struct cgroup *bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id) __ksym;
+void bpf_cgroup_release(struct cgroup *cgrp) __ksym;
+
+static void __on_enter(struct pt_regs *regs, long id, struct cgroup *cgrp)
 {
-	struct task_struct *task;
 	long *ptr;
 	int err;
 
-	task = bpf_get_current_task_btf();
-	if (task->pid != target_pid)
-		return 0;
-
 	/* populate value 0 */
-	ptr = bpf_cgrp_storage_get(&map_a, task->cgroups->dfl_cgrp, 0,
+	ptr = bpf_cgrp_storage_get(&map_a, cgrp, 0,
 				   BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!ptr)
-		return 0;
+		return;
 
 	/* delete value 0 */
-	err = bpf_cgrp_storage_delete(&map_a, task->cgroups->dfl_cgrp);
+	err = bpf_cgrp_storage_delete(&map_a, cgrp);
 	if (err)
-		return 0;
+		return;
 
 	/* value is not available */
-	ptr = bpf_cgrp_storage_get(&map_a, task->cgroups->dfl_cgrp, 0, 0);
+	ptr = bpf_cgrp_storage_get(&map_a, cgrp, 0, 0);
 	if (ptr)
-		return 0;
+		return;
 
 	/* re-populate the value */
-	ptr = bpf_cgrp_storage_get(&map_a, task->cgroups->dfl_cgrp, 0,
+	ptr = bpf_cgrp_storage_get(&map_a, cgrp, 0,
 				   BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!ptr)
-		return 0;
+		return;
 	__sync_fetch_and_add(&enter_cnt, 1);
 	*ptr = MAGIC_VALUE + enter_cnt;
-
-	return 0;
 }
 
-SEC("tp_btf/sys_exit")
-int BPF_PROG(on_exit, struct pt_regs *regs, long id)
+SEC("tp_btf/sys_enter")
+int BPF_PROG(on_enter, struct pt_regs *regs, long id)
 {
 	struct task_struct *task;
-	long *ptr;
+	struct cgroup *cgrp;
 
 	task = bpf_get_current_task_btf();
 	if (task->pid != target_pid)
 		return 0;
 
-	ptr = bpf_cgrp_storage_get(&map_a, task->cgroups->dfl_cgrp, 0,
+	if (is_cgroup1) {
+		cgrp = bpf_task_get_cgroup1(task, target_hid);
+		if (!cgrp)
+			return 0;
+
+		__on_enter(regs, id, cgrp);
+		bpf_cgroup_release(cgrp);
+		return 0;
+	}
+
+	__on_enter(regs, id, task->cgroups->dfl_cgrp);
+	return 0;
+}
+
+static void __on_exit(struct pt_regs *regs, long id, struct cgroup *cgrp)
+{
+	long *ptr;
+
+	ptr = bpf_cgrp_storage_get(&map_a, cgrp, 0,
 				   BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!ptr)
-		return 0;
+		return;
 
 	__sync_fetch_and_add(&exit_cnt, 1);
 	if (*ptr != MAGIC_VALUE + exit_cnt)
 		__sync_fetch_and_add(&mismatch_cnt, 1);
+}
+
+SEC("tp_btf/sys_exit")
+int BPF_PROG(on_exit, struct pt_regs *regs, long id)
+{
+	struct task_struct *task;
+	struct cgroup *cgrp;
+
+	task = bpf_get_current_task_btf();
+	if (task->pid != target_pid)
+		return 0;
+
+	if (is_cgroup1) {
+		cgrp = bpf_task_get_cgroup1(task, target_hid);
+		if (!cgrp)
+			return 0;
+
+		__on_exit(regs, id, cgrp);
+		bpf_cgroup_release(cgrp);
+		return 0;
+	}
+
+	__on_exit(regs, id, task->cgroups->dfl_cgrp);
 	return 0;
 }
-- 
1.8.3.1


