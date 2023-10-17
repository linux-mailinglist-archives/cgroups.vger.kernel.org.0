Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0407CC387
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 14:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbjJQMqO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Oct 2023 08:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbjJQMqN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Oct 2023 08:46:13 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21253F9;
        Tue, 17 Oct 2023 05:46:12 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6bd73395bceso1897126b3a.0;
        Tue, 17 Oct 2023 05:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697546771; x=1698151571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6DXnZqpwxGmHcVwEgywrJ/8DnoqhP9n19zgbidGVUw=;
        b=cqmg5RF1J7MPT+hoHIs48KB3yUiYT5O144exHgtL47MzKYEdbbH11O4rymLL43TrCC
         IoeTUMlR4PNCm+WRoi9HVzOWCxWJXTzyJjE9J8umvoV1BqOtHKP2Qr09bRIyBi8GoGWV
         bfTjNIfRETRvZeb9totUdkxEuOvw16G6j6+cm1w5o7iILgFI4tvochP6ENcgUiqnfllL
         i5DvPzdkPcXwBuiSP20K4pNBovBXe8KkdSYzXkSfWiEZq4EJrDMmmIWEUEdjc4FuvP6V
         MeeT3HPP1ECTzJB41/aMIg3Qn8UMyNsRYbU/+qBAbkqdTm+h1/6lUW6eKXsEObfWw/WX
         k5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697546771; x=1698151571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6DXnZqpwxGmHcVwEgywrJ/8DnoqhP9n19zgbidGVUw=;
        b=cIiCUUKNurMJsDFzpJMpLneGuvXmnNlWyBPAC0hBKvflyWpyLEu6WVf1tQS2RaBHwB
         23a5iZxfvYF8uSgY0o48ktIlnRx5zWRf2s1FH+7jFGZrkbmp5m0vE7brCVjTMkNF/BVH
         pktnNMZyJkUHGITNXxQZrtKx3Qf1rl5BwuvZmIlDKNyQqNKlFalJqezXdKJ6J18kDlXD
         iECDSd2TW/Gwvq8lGRLQs3RWoibYvgBdQz2/JV0QvF6XSxvT3LtorJLa38mnCwneNv8O
         ryuRds/bNTiDxiEk0QEm5hg3/T+WBfEJBkrlskFLNRaojOZv945J9Vk5kBwowispqOvX
         RaGw==
X-Gm-Message-State: AOJu0YyXB68axjmZjtW1tgkBlbIs+43R9lbSSTOfF47uq4I2t8CUdJtB
        /U0zxpVi6bAej8ZeKNaWY6M=
X-Google-Smtp-Source: AGHT+IGqcaXnMwulC+pJu4pw5aIquM6SPB8oKRJnDDhse9jwl6ywuTc4Dp8+SHfIM6J6vKnYQAOJSQ==
X-Received: by 2002:a05:6a00:2293:b0:693:43b5:aaf3 with SMTP id f19-20020a056a00229300b0069343b5aaf3mr2855789pfe.13.1697546771499;
        Tue, 17 Oct 2023 05:46:11 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:3b2:5400:4ff:fe9b:d21b])
        by smtp.gmail.com with ESMTPSA id fa36-20020a056a002d2400b006bdf4dfbe0dsm1375595pfb.12.2023.10.17.05.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:46:11 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com, sinquersw@gmail.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next v2 4/9] bpf: Add a new kfunc for cgroup1 hierarchy
Date:   Tue, 17 Oct 2023 12:45:41 +0000
Message-Id: <20231017124546.24608-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231017124546.24608-1-laoar.shao@gmail.com>
References: <20231017124546.24608-1-laoar.shao@gmail.com>
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

A new kfunc is added to acquire cgroup1:

- bpf_task_get_cgroup1_within_hierarchy
  Acquires the associated cgroup of a task whithin a specific cgroup1
  hierarchy. The cgroup1 hierarchy is identified by its hierarchy ID.

This new kfunc enables the tracing of tasks within a designated
container or cgroup directory in BPF programs.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/helpers.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 62a53ebfedf9..a682b47d3b97 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2217,6 +2217,25 @@ __bpf_kfunc long bpf_task_under_cgroup(struct task_struct *task,
 {
 	return task_under_cgroup_hierarchy(task, ancestor);
 }
+
+/**
+ * bpf_task_get_cgroup_within_hierarchy - Acquires the associated cgroup of
+ * a task within a specific cgroup1 hierarchy. The cgroup1 hierarchy is
+ * identified by its hierarchy ID.
+ * @task: The target task
+ * @hierarchy_id: The ID of a cgroup1 hierarchy
+ *
+ * On success, the cgroup is returen. On failure, NULL is returned.
+ */
+__bpf_kfunc struct cgroup *
+bpf_task_get_cgroup1_within_hierarchy(struct task_struct *task, int hierarchy_id)
+{
+	struct cgroup *cgrp = task_get_cgroup1_within_hierarchy(task, hierarchy_id);
+
+	if (IS_ERR(cgrp))
+		return NULL;
+	return cgrp;
+}
 #endif /* CONFIG_CGROUPS */
 
 /**
@@ -2523,6 +2542,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
+BTF_ID_FLAGS(func, bpf_task_get_cgroup1_within_hierarchy, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
-- 
2.30.1 (Apple Git-130)

