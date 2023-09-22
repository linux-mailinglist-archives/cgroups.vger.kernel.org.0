Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3927AB0A0
	for <lists+cgroups@lfdr.de>; Fri, 22 Sep 2023 13:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjIVL3V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 07:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjIVL3U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 07:29:20 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D655139;
        Fri, 22 Sep 2023 04:29:13 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso1651311b3a.0;
        Fri, 22 Sep 2023 04:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695382152; x=1695986952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XT7WoTwvT3Nj7+0W/TJCIkVvjE4LDdWtuhMgBEm65Q=;
        b=KqduS1WQ3tt/XGwC/26Nnm/PIg1S8yuPI7ISaGucHojbIEBJwigNaj1k7WHB7GWPGp
         k46upGiZet85LZaaHB6RRt0cipiPiaYNOQKBkUBqgsN+stPDDSfjGQAHGoOUuDiUIPAN
         NIyJ5wCdH/mN3EtsLhDmD0n4IReFd/psh3BsZn6o0xfzfKzfHGX0f1goutjOIS3A8UKb
         HB+DL0svNVJCC4ripMfbxH5jJiWDjlms/jvbu8nR3unU+Q5x+qV/tH4wxqtQMdABGrHd
         wXOiqLYWoFCsInAU/L86sSQL6EtzD8en9BQdneGWyIk0SCn/mMsUI+X/BofCHO94Pc47
         A6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695382152; x=1695986952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XT7WoTwvT3Nj7+0W/TJCIkVvjE4LDdWtuhMgBEm65Q=;
        b=s7wTdRwLBxxO/IgRpSPlLiu8rOPbnw3Nml0GocMsnNPz5Qkc5qMHLSjlEisUFpdla6
         ClFNSFcE0Fa66fv2zcjLClih1oN/9YWMUMb+DAHzQK4NEwVSohm008IoEI+xYyvVgeTA
         IA5lc562wyTeMeXxNbP0at3S+jUrb7TIRYhmxDu1sQbdLBy26FtwZZOqLK7+anWaZhqp
         N1iDsiXH5BL8GwD9TZusuHTMLQflrn9zjrfXY4GcmgLK0arm08l0tDIDHYduH1MNdIs6
         GdbqDVs7kuKM8tIcsPDvEMsqe3zz9eHbeXC2Yx63chTzn9TyMZNVV/2rzu0BM8GzGkmk
         3hoQ==
X-Gm-Message-State: AOJu0YyxiaiAhV2Btztdv3mannx6vpkfrlxqQyStBESfn25nYgzGzM1W
        uRPh6reRuNO7MNzMMgRAoHs=
X-Google-Smtp-Source: AGHT+IEid2y4WfFDIqcd3beU088Pykw/qGeUvYEDMfDDP6X8AncVjx4AkGmGv+ViCPJ95sTYM6DVEQ==
X-Received: by 2002:a05:6a20:4293:b0:125:3445:8af0 with SMTP id o19-20020a056a20429300b0012534458af0mr3442783pzj.7.1695382152506;
        Fri, 22 Sep 2023 04:29:12 -0700 (PDT)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id v16-20020aa78090000000b00690beda6987sm2973493pff.77.2023.09.22.04.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 04:29:11 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 4/8] bpf: Add new kfuncs support for cgroup controller
Date:   Fri, 22 Sep 2023 11:28:42 +0000
Message-Id: <20230922112846.4265-5-laoar.shao@gmail.com>
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

Introducing new kfuncs:

- bpf_cgroup_id_from_task_within_controller
  Retrieves the cgroup ID from a task within a specific cgroup controller.
- bpf_cgroup_acquire_from_id_within_controller
  Acquires the cgroup from a cgroup ID within a specific cgroup controller.
- bpf_cgroup_ancestor_id_from_task_within_controller
  Retrieves the ancestor cgroup ID from a task within a specific cgroup
  controller.

These functions eliminate the need to consider cgroup hierarchies,
regardless of whether they involve cgroup1 or cgroup2.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/helpers.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bb521b181cc3..1316b5fda349 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2219,6 +2219,73 @@ __bpf_kfunc long bpf_task_under_cgroup(struct task_struct *task,
 	rcu_read_unlock();
 	return ret;
 }
+
+/**
+ * bpf_cgroup_id_from_task_within_controller - To get the associated cgroup_id from
+ * a task within a specific cgroup controller.
+ * @task: The target task
+ * @ssid: The id of cgroup controller, e.g. cpu_cgrp_id, memory_cgrp_id and etc.
+ */
+__bpf_kfunc u64 bpf_cgroup_id_from_task_within_controller(struct task_struct *task, int ssid)
+{
+	struct cgroup *cgroup;
+	int id = 0;
+
+	rcu_read_lock();
+	cgroup = task_cgroup(task, ssid);
+	if (!cgroup)
+		goto out;
+	id = cgroup_id(cgroup);
+
+out:
+	rcu_read_unlock();
+	return id;
+}
+
+/**
+ * bpf_cgroup_id_from_task_within_controller - To get the associated cgroup_id from
+ * a task within a specific cgroup controller.
+ * @task: The target task
+ * @ssid: The id of cgroup subsystem, e.g. cpu_cgrp_id, memory_cgrp_id and etc.
+ * @level: The level of ancestor to look up
+ */
+__bpf_kfunc u64 bpf_cgroup_ancestor_id_from_task_within_controller(struct task_struct *task,
+								   int ssid, int level)
+{
+	struct cgroup *cgrp, *ancestor;
+	int id = 0;
+
+	rcu_read_lock();
+	cgrp = task_cgroup(task, ssid);
+	if (!cgrp)
+		goto out;
+	ancestor = cgroup_ancestor(cgrp, level);
+	if (ancestor)
+		id = cgroup_id(ancestor);
+
+out:
+	rcu_read_unlock();
+	return id;
+}
+
+/**
+ * bpf_cgroup_acquire_from_id_within_controller - To acquire the cgroup from a
+ * cgroup id within specific cgroup controller. A cgroup acquired by this kfunc
+ * which is not stored in a map as a kptr, must be released by calling
+ * bpf_cgroup_release().
+ * @cgid: cgroup id
+ * @ssid: The id of a cgroup controller, e.g. cpu_cgrp_id, memory_cgrp_id and etc.
+ */
+__bpf_kfunc struct cgroup *bpf_cgroup_acquire_from_id_within_controller(u64 cgid, int ssid)
+{
+	struct cgroup *cgrp;
+
+	cgrp = cgroup_get_from_id_within_subsys(cgid, ssid);
+	if (IS_ERR(cgrp))
+		return NULL;
+	return cgrp;
+}
+
 #endif /* CONFIG_CGROUPS */
 
 /**
@@ -2525,6 +2592,9 @@ BTF_ID_FLAGS(func, bpf_cgroup_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
+BTF_ID_FLAGS(func, bpf_cgroup_id_from_task_within_controller)
+BTF_ID_FLAGS(func, bpf_cgroup_ancestor_id_from_task_within_controller)
+BTF_ID_FLAGS(func, bpf_cgroup_acquire_from_id_within_controller, KF_ACQUIRE | KF_RET_NULL)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
-- 
2.30.1 (Apple Git-130)

