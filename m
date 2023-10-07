Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103097BC840
	for <lists+cgroups@lfdr.de>; Sat,  7 Oct 2023 16:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344022AbjJGODb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Oct 2023 10:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344000AbjJGODa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Oct 2023 10:03:30 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA64B6;
        Sat,  7 Oct 2023 07:03:29 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c61acd1285so21559925ad.2;
        Sat, 07 Oct 2023 07:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696687408; x=1697292208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOZHmpDxZlsRaziqYq5XhmSN+iTkRWEd1l7APG5ymMQ=;
        b=I6XUzClOpVXM31rwCuTKagSS6RTgvHtNpn7o+ZV6RSpJjeuVkoUh4XIAVhIR78qBAU
         ZLdAQAUIj8rxlPmWLXwvogf+aV8f8yXatlCiYKGeU08jAgj7eOqJ9ihFMVC2Wo7lhEKG
         hWz0jT8NXcAXZKYpXp66QvjasEcClj2LziX0QKVapcnZ7wgOeEvwEpHL72E0Wbpn3I8Q
         3XBhGJWoGHck4O60m082MfBcCtq87c3xcLydwUArsWhi8FJFgprI1VjPfn7feAO3mcYr
         WmcFnWsoTsVszWxdGAjpXWovU4cWXT4eYXMPv9u1L8NHVC6eNvN4TXBFtMDZlGVdZcwq
         Qw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696687408; x=1697292208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOZHmpDxZlsRaziqYq5XhmSN+iTkRWEd1l7APG5ymMQ=;
        b=nhFwC1SbEPujKcz1ttSyxDLLK46cumf2Is5Eqff7PTFxhjtWwaGbJYX/6M2kvLSTnS
         nLwzJqN9oN2yBHUs2hBe5Omf+IEfmeFgPslc8Imc35uBlpVUPOV9eLnSlJw5wzbRBr4h
         Q3gT0YozCc2TvbAbGL51W+1LKHx1W6qZL4FXz3nhseCe80AD5HhxHa670NHzTSJbP4Op
         y39GxynW5kJdjHbkTD6kUroHNk/ijHrinuAm+IHMa595YrC+GbLdTsvQabYu0nbCX8vQ
         k10w14PjFdNPc42FrIXFMIRvccQDZxksBgorUSGfORzEXtqP6xn7c7IyeOPEsiIm6pEv
         6NOw==
X-Gm-Message-State: AOJu0YwRuK9J05awm4bYYQGzqxmxx3asyya0vht/Vns9a9JPmaW04SnD
        9yUClWPgLxElzIIRND3kshc=
X-Google-Smtp-Source: AGHT+IFgu5qJyLsOlq9OtiabwHdiLMmH4cC8/KW7dHKWID3Fv5Yi+2/V0cRoFTGicmCzb3ZJdG4K4g==
X-Received: by 2002:a17:902:e5cb:b0:1c8:852f:241a with SMTP id u11-20020a170902e5cb00b001c8852f241amr7974552plf.40.1696687408481;
        Sat, 07 Oct 2023 07:03:28 -0700 (PDT)
Received: from vultr.guest ([45.77.191.53])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b001c0a414695dsm5897550plg.62.2023.10.07.07.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 07:03:28 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com, sinquersw@gmail.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 8/8] selftests/bpf: Add selftests for cgroup1 hierarchy
Date:   Sat,  7 Oct 2023 14:03:04 +0000
Message-Id: <20231007140304.4390-9-laoar.shao@gmail.com>
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

Add selftests for cgroup1 hierarchy.
The result as follows,

  $ tools/testing/selftests/bpf/test_progs --name=cgroup1_hierarchy
  #36/1    cgroup1_hierarchy/test_cgroup1_hierarchy:OK
  #36/2    cgroup1_hierarchy/test_root_cgid:OK
  #36/3    cgroup1_hierarchy/test_invalid_level:OK
  #36/4    cgroup1_hierarchy/test_invalid_cgid:OK
  #36/5    cgroup1_hierarchy/test_invalid_hid:OK
  #36/6    cgroup1_hierarchy/test_invalid_cgrp_name:OK
  #36/7    cgroup1_hierarchy/test_invalid_cgrp_name2:OK
  #36/8    cgroup1_hierarchy/test_sleepable_prog:OK
  #36      cgroup1_hierarchy:OK
  Summary: 1/8 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../bpf/prog_tests/cgroup1_hierarchy.c        | 159 ++++++++++++++++++
 .../bpf/progs/test_cgroup1_hierarchy.c        |  62 +++++++
 2 files changed, 221 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c b/tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c
new file mode 100644
index 000000000000..4aafbc921254
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include <sys/types.h>
+#include <unistd.h>
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "test_cgroup1_hierarchy.skel.h"
+
+static void bpf_cgroup1(struct test_cgroup1_hierarchy *skel)
+{
+	int err;
+
+	/* Attach LSM prog first */
+	skel->links.lsm_run = bpf_program__attach_lsm(skel->progs.lsm_run);
+	if (!ASSERT_OK_PTR(skel->links.lsm_run, "lsm_attach"))
+		return;
+
+	/* LSM prog will be triggered when attaching fentry */
+	skel->links.fentry_run = bpf_program__attach_trace(skel->progs.fentry_run);
+	ASSERT_NULL(skel->links.fentry_run, "fentry_attach_fail");
+
+	err = bpf_link__destroy(skel->links.lsm_run);
+	ASSERT_OK(err, "destroy_lsm");
+	skel->links.lsm_run = NULL;
+}
+
+static void bpf_cgroup1_sleepable(struct test_cgroup1_hierarchy *skel)
+{
+	int err;
+
+	/* Attach LSM prog first */
+	skel->links.lsm_s_run = bpf_program__attach_lsm(skel->progs.lsm_s_run);
+	if (!ASSERT_OK_PTR(skel->links.lsm_s_run, "lsm_attach"))
+		return;
+
+	/* LSM prog will be triggered when attaching fentry */
+	skel->links.fentry_run = bpf_program__attach_trace(skel->progs.fentry_run);
+	ASSERT_NULL(skel->links.fentry_run, "fentry_attach_fail");
+
+	err = bpf_link__destroy(skel->links.lsm_s_run);
+	ASSERT_OK(err, "destroy_lsm");
+	skel->links.lsm_s_run = NULL;
+}
+
+static void bpf_cgroup1_invalid_id(struct test_cgroup1_hierarchy *skel)
+{
+	int err;
+
+	/* Attach LSM prog first */
+	skel->links.lsm_run = bpf_program__attach_lsm(skel->progs.lsm_run);
+	if (!ASSERT_OK_PTR(skel->links.lsm_run, "lsm_attach"))
+		return;
+
+	/* LSM prog will be triggered when attaching fentry */
+	skel->links.fentry_run = bpf_program__attach_trace(skel->progs.fentry_run);
+	if (!ASSERT_OK_PTR(skel->links.fentry_run, "fentry_attach_success"))
+		goto cleanup;
+
+	err = bpf_link__destroy(skel->links.lsm_run);
+	ASSERT_OK(err, "destroy_lsm");
+	skel->links.lsm_run = NULL;
+
+cleanup:
+	err = bpf_link__destroy(skel->links.fentry_run);
+	ASSERT_OK(err, "destroy_fentry");
+	skel->links.fentry_run = NULL;
+}
+
+void test_cgroup1_hierarchy(void)
+{
+	struct test_cgroup1_hierarchy *skel;
+	__u64 current_cgid;
+	int hid, err;
+
+	skel = test_cgroup1_hierarchy__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	skel->bss->target_pid = getpid();
+
+	err = bpf_program__set_attach_target(skel->progs.fentry_run, 0, "bpf_fentry_test1");
+	if (!ASSERT_OK(err, "fentry_set_target"))
+		goto destroy;
+
+	err = test_cgroup1_hierarchy__load(skel);
+	if (!ASSERT_OK(err, "load"))
+		goto destroy;
+
+	/* Setup cgroup1 hierarchy */
+	err = setup_classid_environment();
+	if (!ASSERT_OK(err, "setup_classid_environment"))
+		goto destroy;
+
+	err = join_classid();
+	if (!ASSERT_OK(err, "join_cgroup1"))
+		goto cleanup;
+
+	current_cgid = get_classid_cgroup_id();
+	if (!ASSERT_GE(current_cgid, 0, "cgroup1 id"))
+		goto cleanup;
+
+	hid = get_cgroup1_hierarchy_id("net_cls");
+	if (!ASSERT_GE(hid, 0, "cgroup1 id"))
+		goto cleanup;
+	skel->bss->target_hid = hid;
+
+	if (test__start_subtest("test_cgroup1_hierarchy")) {
+		skel->bss->target_ancestor_cgid = current_cgid;
+		bpf_cgroup1(skel);
+	}
+
+	if (test__start_subtest("test_root_cgid")) {
+		skel->bss->target_ancestor_cgid = 1;
+		skel->bss->target_ancestor_level = 0;
+		bpf_cgroup1(skel);
+	}
+
+	if (test__start_subtest("test_invalid_level")) {
+		skel->bss->target_ancestor_cgid = 1;
+		skel->bss->target_ancestor_level = 1;
+		bpf_cgroup1_invalid_id(skel);
+	}
+
+	if (test__start_subtest("test_invalid_cgid")) {
+		skel->bss->target_ancestor_cgid = 0;
+		bpf_cgroup1_invalid_id(skel);
+	}
+
+	if (test__start_subtest("test_invalid_hid")) {
+		skel->bss->target_ancestor_cgid = 1;
+		skel->bss->target_ancestor_level = 0;
+		skel->bss->target_hid = -1;
+		bpf_cgroup1_invalid_id(skel);
+	}
+
+	if (test__start_subtest("test_invalid_cgrp_name")) {
+		skel->bss->target_hid = get_cgroup1_hierarchy_id("net_cl");
+		skel->bss->target_ancestor_cgid = current_cgid;
+		bpf_cgroup1_invalid_id(skel);
+	}
+
+	if (test__start_subtest("test_invalid_cgrp_name2")) {
+		skel->bss->target_hid = get_cgroup1_hierarchy_id("net_cls,");
+		skel->bss->target_ancestor_cgid = current_cgid;
+		bpf_cgroup1_invalid_id(skel);
+	}
+
+	if (test__start_subtest("test_sleepable_prog")) {
+		skel->bss->target_hid = hid;
+		skel->bss->target_ancestor_cgid = current_cgid;
+		bpf_cgroup1_sleepable(skel);
+	}
+
+cleanup:
+	cleanup_classid_environment();
+destroy:
+	test_cgroup1_hierarchy__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c b/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
new file mode 100644
index 000000000000..95d9031892e4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+//#endif
+/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+__u32 target_ancestor_level;
+__u64 target_ancestor_cgid;
+int target_pid, target_hid;
+
+u64 bpf_task_cgroup1_id_within_hierarchy(struct task_struct *task, int hierarchy_id) __ksym;
+u64 bpf_task_ancestor_cgroup1_id_within_hierarchy(struct task_struct *task, int hierarchy_id,
+						 int ancestor_level) __ksym;
+
+static int bpf_link_create_verify(int cmd)
+{
+	__u64 cgid, ancestor_cgid;
+	struct task_struct *task;
+	int ret = 0;
+
+	if (cmd != BPF_LINK_CREATE)
+		return 0;
+
+	task = bpf_get_current_task_btf();
+	/* Then it can run in parallel */
+	if (task->pid != target_pid)
+		return 0;
+
+	/* Refuse it if its cgid or its ancestor's cgid is the target cgid */
+	cgid = bpf_task_cgroup1_id_within_hierarchy(task, target_hid);
+	if (cgid == target_ancestor_cgid)
+		ret = -1;
+
+	ancestor_cgid = bpf_task_ancestor_cgroup1_id_within_hierarchy(task, target_hid,
+								      target_ancestor_level);
+	if (ancestor_cgid == target_ancestor_cgid)
+		ret = -1;
+	return ret;
+}
+
+SEC("lsm/bpf")
+int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
+{
+	return bpf_link_create_verify(cmd);
+}
+
+SEC("lsm.s/bpf")
+int BPF_PROG(lsm_s_run, int cmd, union bpf_attr *attr, unsigned int size)
+{
+	return bpf_link_create_verify(cmd);
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

