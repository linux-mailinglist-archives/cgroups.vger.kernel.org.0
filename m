Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588167BC835
	for <lists+cgroups@lfdr.de>; Sat,  7 Oct 2023 16:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343979AbjJGODW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Oct 2023 10:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343934AbjJGODV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Oct 2023 10:03:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1F3BD;
        Sat,  7 Oct 2023 07:03:20 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c723f1c80fso22655865ad.1;
        Sat, 07 Oct 2023 07:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696687400; x=1697292200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LivZSfWCIUy5PpRi4LmDDyNFOui9+vIDSPEwDR4bKrQ=;
        b=KU23cJD0fQVql8ViEE/maaRDtcoGXWt0mtsIRir78EuFkRiZk5cj7xevhr0N4LWu9u
         6pBbHffamFLbWmmTerx3YdbTUnqNPGfRyIy1zY1t56jRBduT5eHrAsN/+yE8KZvvW+VS
         cZkzaBReNyjxY/2AI5KL6oMbqxfhw1YZW1f3X82r1fBStWKJFoS1G/V+lNHXOOhWBYfb
         +MakrpWp9NTXABUKFkC9G+6jlMNl+p5PVb+Yygro2boqnXeGVPxqxsbMdDGGxktuUQl2
         KPfU3v065OrZ/I9MCfznacbkrtpfig5tV2cO+QBrdylWlJ65jrX/gds9MpR1HyheNqiW
         ys1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696687400; x=1697292200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LivZSfWCIUy5PpRi4LmDDyNFOui9+vIDSPEwDR4bKrQ=;
        b=sU4ryyMYJHaFdYjHXEQ9XXrWqpHWnMJYC0dTBE4Lr5f3oIa9lgWeBpRaNqZzze8EtQ
         6aDdrguoutM8Zbt/pMGdtldU9cy1x1TFOx9dFO1qxj8MFoiZapqxjysQ3bF9RlyjEJ+7
         A5v/nNQtfxWtB4hWEi1gsstl+v7GCrQIRbNkoV07MxbvYOfUfUwSw7v4GHPzG/f7plSV
         BMGLi2Yen6rGeVUcc16c3IY3QzCcK/LNCFU0n/TF4p7hrX3zVT/6t95YcFPRLxhHIvro
         ZM50P43fbrkweXlkxzydVID9ADVbhqCelJoGKNiJO+B5yPO4YszVAm0VkR3xeDZXX16C
         PFxw==
X-Gm-Message-State: AOJu0Yyp+dbyY0QhtogTv8GzoK7avmjg1kbr1pALxsM5KbQWjenZGdZ4
        cYWR0lTYbEw/PD4kqtIouoE=
X-Google-Smtp-Source: AGHT+IGnJGM/pQcim+t2+9WjcgTCzzeVDoPAyYRShRNA04b+Tvx3soDrYvABnMi3D4KMNSmDUQ3nQg==
X-Received: by 2002:a17:903:32cf:b0:1c7:56b9:eae with SMTP id i15-20020a17090332cf00b001c756b90eaemr12318684plr.32.1696687399959;
        Sat, 07 Oct 2023 07:03:19 -0700 (PDT)
Received: from vultr.guest ([45.77.191.53])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b001c0a414695dsm5897550plg.62.2023.10.07.07.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 07:03:19 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com, sinquersw@gmail.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 3/8] bpf: Add kfuncs for cgroup1 hierarchy
Date:   Sat,  7 Oct 2023 14:02:59 +0000
Message-Id: <20231007140304.4390-4-laoar.shao@gmail.com>
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

Two new kfuncs are added to retrieve the cgroup1 IDs.

- bpf_task_cgroup1_id_within_hierarchy
  Retrieves the associated cgroup ID of a task whithin a specific
  cgroup1 hierarchy. The cgroup1 hierarchy is identified by its
  hierarchy ID.
- bpf_task_ancestor_cgroup1_id_within_hierarchy
  Retrieves the associated ancestor cgroup ID of a task whithin a
  specific cgroup1 hierarchy. he specific ancestor cgroup is determined by
  the ancestor level within the cgroup1 hierarchy.

These two new kfuncs enable the tracing of tasks within a designated
container or cgroup directory in BPF programs.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/helpers.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index dd1c69ee3375..39ec6f9f2027 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2214,6 +2214,30 @@ __bpf_kfunc long bpf_task_under_cgroup(struct task_struct *task,
 {
 	return task_under_cgroup_hierarchy(task, ancestor);
 }
+
+/**
+ * bpf_task_cgroup_id_within_hierarchy - Retrieves the associated cgroup ID of a
+ * task within a specific cgroup1 hierarchy.
+ * @task: The target task
+ * @hierarchy_id: The ID of a cgroup1 hierarchy
+ */
+__bpf_kfunc u64 bpf_task_cgroup1_id_within_hierarchy(struct task_struct *task, int hierarchy_id)
+{
+	return task_cgroup1_id_within_hierarchy(task, hierarchy_id);
+}
+
+/**
+ * bpf_task_ancestor_cgroup_id_within_hierarchy - Retrieves the associated
+ * ancestor cgroup ID of a task within a specific cgroup1 hierarchy.
+ * @task: The target task
+ * @hierarchy_id: The ID of a cgroup1 hierarchy
+ * @ancestor_level: The cgroup level of the ancestor in the cgroup1 hierarchy
+ */
+__bpf_kfunc u64 bpf_task_ancestor_cgroup1_id_within_hierarchy(struct task_struct *task,
+							      int hierarchy_id, int ancestor_level)
+{
+	return task_ancestor_cgroup1_id_within_hierarchy(task, hierarchy_id, ancestor_level);
+}
 #endif /* CONFIG_CGROUPS */
 
 /**
@@ -2520,6 +2544,8 @@ BTF_ID_FLAGS(func, bpf_cgroup_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
+BTF_ID_FLAGS(func, bpf_task_cgroup1_id_within_hierarchy, KF_RCU)
+BTF_ID_FLAGS(func, bpf_task_ancestor_cgroup1_id_within_hierarchy, KF_RCU)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
-- 
2.30.1 (Apple Git-130)

