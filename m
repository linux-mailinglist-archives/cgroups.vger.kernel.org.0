Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022B97AB0AC
	for <lists+cgroups@lfdr.de>; Fri, 22 Sep 2023 13:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjIVL3a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 07:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjIVL32 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 07:29:28 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16160192;
        Fri, 22 Sep 2023 04:29:21 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-691c05bc5aaso1561782b3a.2;
        Fri, 22 Sep 2023 04:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695382160; x=1695986960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Un+n8gtPu2H9LbD/gWmNkEsxWWkM8C1lnBzSSmQYUiM=;
        b=IJGudsSt17I0f0TkZxOSBzk8SJG/ttozDfBKztpBpbs0BiDCUrtBTyhckTrFQY1r2a
         1SoCIlA46/vg4U5Ct+CTX5KTn9GnjzZF/hjIKb1DSS8sbJygU4MPjXiihMdbuAJEkcmb
         /fkIneBqcO0KBG+K2kN1cb5Hv8DHx/oAREm1+pMj0bsWAAl79g+6Cuq8RDdwTihe85lm
         1cyiD7L76R+K8OVrNYGB6Bg0faOiSFjU0SPzENkfxjV1p4Akcm5GisIhlcTPuVosnoln
         egsrOVqOj5GyS/hbBzXsSuElU1iGAaiaJcWbOU1aZAAHfUCdCgPJvJ5y2OV/jbkMMBOn
         3uMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695382160; x=1695986960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Un+n8gtPu2H9LbD/gWmNkEsxWWkM8C1lnBzSSmQYUiM=;
        b=NEfqnMRd/68oBEyLLSF7AjctNXnwpkMpXefZPzkBxdSxnZl68Jd+Bd+K0GaDQoOUky
         GMmzRsnjj7J9kg6pQW8PTUrMZxOqy8Me6HrO13rWB5fvkMb0vsa36m5vUvvPQpEpI8Su
         gqgU0hy0ITFtuJKUb8pZkV6KLDPQ5Cg+7SS52kKicnD98tOyEpTDhGinpAHr4cK5OHva
         SiVhiug6R/Bmdh4cnaZN6Dslfz2QAJN5D+5x0TZ9oKC58I5fxdaNz9ohxt7QnZi98IGW
         gzNqMDCI5VywFWQ8e1RrX2YuTnUy4IDhiO+0estHau+ih45Mg2twgXvVIBU0hk/zc+Nf
         rd6g==
X-Gm-Message-State: AOJu0YzILDV9ne5VUGPqKEl+mttRG4AFSVIb6kHKp3j8JPPZU9dYMIc4
        +ClB7v7RprMNl+TsKxuCzl4=
X-Google-Smtp-Source: AGHT+IH3eZlhv6LvJjmd5UZXNQdXaGgqt+GUQPlIBT0xIFRh3ng3xKbjhu7DQ7c4+LzIBT0TWWGuDg==
X-Received: by 2002:a05:6a00:2493:b0:682:4c1c:a0fc with SMTP id c19-20020a056a00249300b006824c1ca0fcmr9602277pfv.19.1695382160467;
        Fri, 22 Sep 2023 04:29:20 -0700 (PDT)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id v16-20020aa78090000000b00690beda6987sm2973493pff.77.2023.09.22.04.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 04:29:20 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 8/8] selftests/bpf: Add selftests for cgroup controller
Date:   Fri, 22 Sep 2023 11:28:46 +0000
Message-Id: <20230922112846.4265-9-laoar.shao@gmail.com>
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

Add selftests for cgroup controller on both cgroup1 and cgroup2.
The result as follows,

  $ tools/testing/selftests/bpf/test_progs --name=cgroup_controller
  #40/1    cgroup_controller/test_cgroup1_controller:OK
  #40/2    cgroup_controller/test_invalid_cgroup_id:OK
  #40/3    cgroup_controller/test_sleepable_prog:OK
  #40/4    cgroup_controller/test_cgroup2_controller:OK
  #40      cgroup_controller:OK

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../bpf/prog_tests/cgroup_controller.c        | 149 ++++++++++++++++++
 .../bpf/progs/test_cgroup_controller.c        |  80 ++++++++++
 2 files changed, 229 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_controller.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cgroup_controller.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_controller.c b/tools/testing/selftests/bpf/prog_tests/cgroup_controller.c
new file mode 100644
index 000000000000..f76ec1e65b2a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_controller.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include <sys/types.h>
+#include <unistd.h>
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "test_cgroup_controller.skel.h"
+
+#define CGROUP2_DIR "/cgroup2_controller"
+
+static void bpf_cgroup1_controller(bool sleepable, __u64 cgrp_id)
+{
+	struct test_cgroup_controller *skel;
+	int err;
+
+	skel = test_cgroup_controller__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	skel->bss->target_pid = getpid();
+	skel->bss->ancestor_cgid = cgrp_id;
+
+	err = bpf_program__set_attach_target(skel->progs.fentry_run, 0, "bpf_fentry_test1");
+	if (!ASSERT_OK(err, "fentry_set_target"))
+		goto cleanup;
+
+	err = test_cgroup_controller__load(skel);
+	if (!ASSERT_OK(err, "load"))
+		goto cleanup;
+
+	/* Attach LSM prog first */
+	if (!sleepable) {
+		skel->links.lsm_net_cls = bpf_program__attach_lsm(skel->progs.lsm_net_cls);
+		if (!ASSERT_OK_PTR(skel->links.lsm_net_cls, "lsm_attach"))
+			goto cleanup;
+	} else {
+		skel->links.lsm_s_net_cls = bpf_program__attach_lsm(skel->progs.lsm_s_net_cls);
+		if (!ASSERT_OK_PTR(skel->links.lsm_s_net_cls, "lsm_attach_sleepable"))
+			goto cleanup;
+	}
+
+	/* LSM prog will be triggered when attaching fentry */
+	skel->links.fentry_run = bpf_program__attach_trace(skel->progs.fentry_run);
+	if (cgrp_id) {
+		ASSERT_NULL(skel->links.fentry_run, "fentry_attach_fail");
+	} else {
+		if (!ASSERT_OK_PTR(skel->links.fentry_run, "fentry_attach_success"))
+			goto cleanup;
+	}
+
+cleanup:
+	test_cgroup_controller__destroy(skel);
+}
+
+static void cgroup_controller_on_cgroup1(bool sleepable, bool invalid_cgid)
+{
+	__u64 cgrp_id;
+	int err;
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
+	cgrp_id = get_classid_cgroup_id();
+	if (invalid_cgid)
+		bpf_cgroup1_controller(sleepable, 0);
+	else
+		bpf_cgroup1_controller(sleepable, cgrp_id);
+
+cleanup:
+	/* Cleanup cgroup1 hierarchy */
+	cleanup_classid_environment();
+}
+
+static void bpf_cgroup2_controller(__u64 cgrp_id)
+{
+	struct test_cgroup_controller *skel;
+	int err;
+
+	skel = test_cgroup_controller__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	skel->bss->target_pid = getpid();
+	skel->bss->ancestor_cgid = cgrp_id;
+
+	err = bpf_program__set_attach_target(skel->progs.fentry_run, 0, "bpf_fentry_test1");
+	if (!ASSERT_OK(err, "fentry_set_target"))
+		goto cleanup;
+
+	err = test_cgroup_controller__load(skel);
+	if (!ASSERT_OK(err, "load"))
+		goto cleanup;
+
+	skel->links.lsm_cpu = bpf_program__attach_lsm(skel->progs.lsm_cpu);
+	if (!ASSERT_OK_PTR(skel->links.lsm_cpu, "lsm_attach"))
+		goto cleanup;
+
+	skel->links.fentry_run = bpf_program__attach_trace(skel->progs.fentry_run);
+	ASSERT_NULL(skel->links.fentry_run, "fentry_attach_fail");
+
+cleanup:
+	test_cgroup_controller__destroy(skel);
+}
+
+static void cgroup_controller_on_cgroup2(void)
+{
+	int cgrp_fd, cgrp_id, err;
+
+	err = setup_cgroup_environment();
+	if (!ASSERT_OK(err, "cgrp2_env_setup"))
+		goto cleanup;
+
+	cgrp_fd = test__join_cgroup(CGROUP2_DIR);
+	if (!ASSERT_GE(cgrp_fd, 0, "cgroup_join_cgroup2"))
+		goto cleanup;
+
+	err = enable_controllers(CGROUP2_DIR, "cpu");
+	if (!ASSERT_OK(err, "cgrp2_env_setup"))
+		goto close_fd;
+
+	cgrp_id = get_cgroup_id(CGROUP2_DIR);
+	if (!ASSERT_GE(cgrp_id, 0, "cgroup2_id"))
+		goto close_fd;
+	bpf_cgroup2_controller(cgrp_id);
+
+close_fd:
+	close(cgrp_fd);
+cleanup:
+	cleanup_cgroup_environment();
+}
+
+void test_cgroup_controller(void)
+{
+	if (test__start_subtest("test_cgroup1_controller"))
+		cgroup_controller_on_cgroup1(false, false);
+	if (test__start_subtest("test_invalid_cgroup_id"))
+		cgroup_controller_on_cgroup1(false, true);
+	if (test__start_subtest("test_sleepable_prog"))
+		cgroup_controller_on_cgroup1(true, false);
+	if (test__start_subtest("test_cgroup2_controller"))
+		cgroup_controller_on_cgroup2();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_cgroup_controller.c b/tools/testing/selftests/bpf/progs/test_cgroup_controller.c
new file mode 100644
index 000000000000..958804a34794
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_cgroup_controller.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+//#endif
+/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+__u64 ancestor_cgid;
+int target_pid;
+
+struct cgroup *bpf_cgroup_acquire_from_id_within_controller(u64 cgid, int ssid) __ksym;
+u64 bpf_cgroup_id_from_task_within_controller(struct task_struct *task, int ssid) __ksym;
+u64 bpf_cgroup_ancestor_id_from_task_within_controller(struct task_struct *task,
+						       int ssid, int level) __ksym;
+long bpf_task_under_cgroup(struct task_struct *task, struct cgroup *ancestor) __ksym;
+void bpf_cgroup_release(struct cgroup *p) __ksym;
+
+static int bpf_link_create_verify(int cmd, union bpf_attr *attr, unsigned int size, int ssid)
+{
+	struct cgroup *cgrp = NULL;
+	struct task_struct *task;
+	__u64 cgid, root_cgid;
+	int ret = 0;
+
+	if (cmd != BPF_LINK_CREATE)
+		return 0;
+
+	task = bpf_get_current_task_btf();
+	/* Then it can run in parallel */
+	if (target_pid != BPF_CORE_READ(task, pid))
+		return 0;
+
+	cgrp = bpf_cgroup_acquire_from_id_within_controller(ancestor_cgid, ssid);
+	if (!cgrp)
+		goto out;
+
+	if (bpf_task_under_cgroup(task, cgrp))
+		ret = -1;
+	bpf_cgroup_release(cgrp);
+
+	cgid = bpf_cgroup_id_from_task_within_controller(task, ssid);
+	if (cgid != ancestor_cgid)
+		ret = 0;
+
+	/* The level of root cgroup is 0, and its id is always 1 */
+	root_cgid = bpf_cgroup_ancestor_id_from_task_within_controller(task, ssid, 0);
+	if (root_cgid != 1)
+		ret = 0;
+
+out:
+	return ret;
+}
+
+SEC("lsm/bpf")
+int BPF_PROG(lsm_net_cls, int cmd, union bpf_attr *attr, unsigned int size)
+{
+	return bpf_link_create_verify(cmd, attr, size, net_cls_cgrp_id);
+}
+
+SEC("lsm.s/bpf")
+int BPF_PROG(lsm_s_net_cls, int cmd, union bpf_attr *attr, unsigned int size)
+{
+	return bpf_link_create_verify(cmd, attr, size, net_cls_cgrp_id);
+}
+
+SEC("lsm/bpf")
+int BPF_PROG(lsm_cpu, int cmd, union bpf_attr *attr, unsigned int size)
+{
+	return bpf_link_create_verify(cmd, attr, size, cpu_cgrp_id);
+}
+
+SEC("fentry")
+int BPF_PROG(fentry_run)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.30.1 (Apple Git-130)

