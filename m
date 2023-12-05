Return-Path: <cgroups+bounces-812-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4BB80577C
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 15:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941BC1F21675
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F6865ED3;
	Tue,  5 Dec 2023 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a83sCJQL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81165129;
	Tue,  5 Dec 2023 06:37:40 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d06d42a58aso30676605ad.0;
        Tue, 05 Dec 2023 06:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701787060; x=1702391860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLNlcnn6IIodVjt3HMRzPbHdYWplCsrOQ7VtLRR6mVg=;
        b=a83sCJQLHpQ1uzVTa8lZrurtu0L1sq3glO37l+i+5wE2PdhwZpGV3UPaZL98gRBSAl
         HsVBdbP93qaHqFzjyW0R5TPhdiuackioqcWAN1QGTsbBZCuW1Ml29Yz0mVOZ/YC01078
         KzuMRg81f7tHyQhtAOpD7M6czLygIdkVNl0gIr/soeFtLT3YD/LQTfLMgA1cq0Ezla1A
         wP7alv2L/9uUyRJ1fKA+t9BZnkJYzEMd5+3rJm0kzA1MEHSAoEUgZAS9vni5Z/w3KA/U
         wdEMy4bXq2JXyOAUluOOG9wZLQJvdDr7meXgs+q3ORR5vltAW8XHe52FVz2F2NluTgf7
         wdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701787060; x=1702391860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLNlcnn6IIodVjt3HMRzPbHdYWplCsrOQ7VtLRR6mVg=;
        b=clfUvZ2klsSHUtT3T3nr/IpcqZxh5lpSkCbCZ4JJXdxDz+X+9k3UKRQSmHqlIyUXDe
         w0cFl8yrUEoLddA12NaqoTTN+cnNyXvdTwMJqFN5n46yT5Jy4TJiuVnq+fhEjH9F04YP
         mxV2F3NXXMHSm49wtXI0prfe7wtymlHT94mwzBbKnzfq+9hpiiNTdwWvHBMV6kyo7Axw
         AW1rHgf8Nb9Ei9TOIFoTDdh1igL/F7KTX6EgLsM9+qkp1Nv9RDVlqzkhQQtPzjaFCUTG
         jU3Z3BdQoNay7yP8aAot7BcudzxJ8mDhFHJNjCmPBOKXXYn4Tdur6bQnO+ltkVFdT7Bj
         X+pw==
X-Gm-Message-State: AOJu0YyuiqHDm4RaECFaNt3CqBWw4we+4tqL20fby5nbaDfuNZllc40N
	Ja/vtMs6sctBVYOVpN80WV0=
X-Google-Smtp-Source: AGHT+IGmbEHmldbToIktb5FJ3SQRRwB1TrI9XPo1StGNNewhXokPfTo4pg2XGVmQK73kxUCQOzVu/w==
X-Received: by 2002:a17:902:a603:b0:1d0:6ffd:e2eb with SMTP id u3-20020a170902a60300b001d06ffde2ebmr5057080plq.133.1701787059874;
        Tue, 05 Dec 2023 06:37:39 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id g9-20020a1709026b4900b001a9b29b6759sm10286502plt.183.2023.12.05.06.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 06:37:39 -0800 (PST)
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
Subject: [RFC PATCH bpf-next 3/3] selftests/bpf: Add selftests for cgroup1 local storage
Date: Tue,  5 Dec 2023 14:37:25 +0000
Message-Id: <20231205143725.4224-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231205143725.4224-1-laoar.shao@gmail.com>
References: <20231205143725.4224-1-laoar.shao@gmail.com>
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
---
 .../bpf/prog_tests/cgrp_local_storage.c       | 92 ++++++++++++++++++-
 .../selftests/bpf/progs/cgrp_ls_recursion.c   | 84 +++++++++++++----
 .../selftests/bpf/progs/cgrp_ls_sleepable.c   | 67 ++++++++++++--
 .../selftests/bpf/progs/cgrp_ls_tp_btf.c      | 82 ++++++++++++-----
 4 files changed, 278 insertions(+), 47 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
index 63e776f4176e..9524cde4cbf6 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
@@ -19,6 +19,9 @@ struct socket_cookie {
 	__u64 cookie_value;
 };
 
+bool is_cgroup1;
+int target_hid;
+
 static void test_tp_btf(int cgroup_fd)
 {
 	struct cgrp_ls_tp_btf *skel;
@@ -29,6 +32,9 @@ static void test_tp_btf(int cgroup_fd)
 	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
 		return;
 
+	skel->bss->is_cgroup1 = is_cgroup1;
+	skel->bss->target_hid = target_hid;
+
 	/* populate a value in map_b */
 	err = bpf_map_update_elem(bpf_map__fd(skel->maps.map_b), &cgroup_fd, &val1, BPF_ANY);
 	if (!ASSERT_OK(err, "map_update_elem"))
@@ -130,6 +136,9 @@ static void test_recursion(int cgroup_fd)
 	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
 		return;
 
+	skel->bss->target_hid = target_hid;
+	skel->bss->is_cgroup1 = is_cgroup1;
+
 	err = cgrp_ls_recursion__attach(skel);
 	if (!ASSERT_OK(err, "skel_attach"))
 		goto out;
@@ -165,6 +174,9 @@ static void test_cgroup_iter_sleepable(int cgroup_fd, __u64 cgroup_id)
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
+	skel->bss->target_hid = target_hid;
+	skel->bss->is_cgroup1 = is_cgroup1;
+
 	bpf_program__set_autoload(skel->progs.cgroup_iter, true);
 	err = cgrp_ls_sleepable__load(skel);
 	if (!ASSERT_OK(err, "skel_load"))
@@ -202,6 +214,8 @@ static void test_yes_rcu_lock(__u64 cgroup_id)
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
+	skel->bss->target_hid = target_hid;
+	skel->bss->is_cgroup1 = is_cgroup1;
 	skel->bss->target_pid = syscall(SYS_gettid);
 
 	bpf_program__set_autoload(skel->progs.yes_rcu_lock, true);
@@ -229,6 +243,9 @@ static void test_no_rcu_lock(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
+	skel->bss->target_hid = target_hid;
+	skel->bss->is_cgroup1 = is_cgroup1;
+
 	bpf_program__set_autoload(skel->progs.no_rcu_lock, true);
 	err = cgrp_ls_sleepable__load(skel);
 	ASSERT_ERR(err, "skel_load");
@@ -236,7 +253,26 @@ static void test_no_rcu_lock(void)
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
+	skel->bss->target_hid = target_hid;
+	skel->bss->is_cgroup1 = is_cgroup1;
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
@@ -245,6 +281,8 @@ void test_cgrp_local_storage(void)
 	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup /cgrp_local_storage"))
 		return;
 
+	is_cgroup1 = 0;
+	target_hid = -1;
 	cgroup_id = get_cgroup_id("/cgrp_local_storage");
 	if (test__start_subtest("tp_btf"))
 		test_tp_btf(cgroup_fd);
@@ -263,3 +301,55 @@ void test_cgrp_local_storage(void)
 
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
+	target_hid = cgrp1_hid;
+	is_cgroup1 = 1;
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
index a043d8fefdac..610c2427fd93 100644
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
index 4c7844e1dbfa..985ff419249c 100644
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
 
@@ -37,23 +41,56 @@ int cgroup_iter(struct bpf_iter__cgroup *ctx)
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
+	if (!is_cgroup1)
+		return 0;
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
+
+	if (is_cgroup1)
+		return 0;
 
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
 
@@ -68,6 +105,22 @@ int yes_rcu_lock(void *ctx)
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
index 9ebb8e2fe541..1c348f000f38 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_ls_tp_btf.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_ls_tp_btf.c
@@ -27,62 +27,100 @@ pid_t target_pid = 0;
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
2.30.1 (Apple Git-130)


