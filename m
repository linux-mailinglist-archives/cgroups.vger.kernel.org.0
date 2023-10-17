Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2787CC386
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 14:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbjJQMqN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Oct 2023 08:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbjJQMqM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Oct 2023 08:46:12 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A0583;
        Tue, 17 Oct 2023 05:46:10 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6c4b9e09528so3821012a34.3;
        Tue, 17 Oct 2023 05:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697546770; x=1698151570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGlzNf6WdsmkGHoptnlJhKt/0P2xY3kxLxvh9NU6HqI=;
        b=Yl/lG7wcQKqkenRNoy09FzI71o2a4StV0UIMHsf33iFCYoWarFqf+OPpKwXZq74dE1
         MilIzmZxJ9f08+5PHlsJdx/t4V5gUo9r9CZfM0Xrm9tGgrW7RwGuzSkkd3enxfGuWePs
         qo2jaNyUtlBWk9GuIvFa8tnTNrX7Pghcd/hUmVsZblAFtxC0m0dV4BSEjLdsEJbTBMzs
         pngb48uUXLw7A+Py+LfmxI7ZDVGtoGY3Odo1EkcXyeHvZnLoHxVLHKqok6k0DTvXmbyV
         mvLGzMqSWiJLL8gbJLkJDB+n7K8A65f3xcHu0+1hbBHSmkbn6cSwjNnu4+tj+GsvooUK
         fNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697546770; x=1698151570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGlzNf6WdsmkGHoptnlJhKt/0P2xY3kxLxvh9NU6HqI=;
        b=aJFd7YmR220oLotoziR1TXpnr2ydT//IjwsAUcRtkOUymjUVBLlYxn0fuAYyWK1M/p
         fFCFegCKJ6x1grAsttoA27fvOSLyN8TVPt4Xvlbmk3tkbc6397LKlhkX+Y89mIL6BAr8
         B+LgF2lW+tlWSTqcMMmVZwVc0Iatf4oYf0zv1aOxbbIDfZtOzf2EC5BYc4Sg7Ad3YYBj
         FELVIl2a43LCP86boxQDCJJMTe3ep/kZZSdM57eGox4StSvqQ59MvKhjVfB5xAPflHU0
         nrT6uyH1UPrPW+Rg13R3BuziGFKS98IpNEbDOsyhQ+Go+dZgmUYEylGvw9uUNzvbaZjh
         BErQ==
X-Gm-Message-State: AOJu0Yw2lTsg8C/Tq3ClhytH5rnRDbM0HAPa2i/XnS4DPnbzSyX1vcvY
        Ok9Mu/E918+DPMtaJJBW6X4=
X-Google-Smtp-Source: AGHT+IHJcsuTDiUuaPpXZLWALWPW2owS5P6jdDAXIg+MkS/VjV+JAvCzmQUi9KL0wnpm0RbWS1szhw==
X-Received: by 2002:a05:6830:56:b0:6b8:6785:ed0b with SMTP id d22-20020a056830005600b006b86785ed0bmr2266465otp.30.1697546769877;
        Tue, 17 Oct 2023 05:46:09 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:3b2:5400:4ff:fe9b:d21b])
        by smtp.gmail.com with ESMTPSA id fa36-20020a056a002d2400b006bdf4dfbe0dsm1375595pfb.12.2023.10.17.05.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:46:09 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com, sinquersw@gmail.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next v2 3/9] cgroup: Add a new helper for cgroup1 hierarchy
Date:   Tue, 17 Oct 2023 12:45:40 +0000
Message-Id: <20231017124546.24608-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231017124546.24608-1-laoar.shao@gmail.com>
References: <20231017124546.24608-1-laoar.shao@gmail.com>
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

A new helper is added for cgroup1 hierarchy:

- task_get_cgroup1_within_hierarchy
  Acquires the associated cgroup of a task within a specific cgroup1
  hierarchy. The cgroup1 hierarchy is identified by its hierarchy ID.

This helper function is added to facilitate the tracing of tasks within
a particular container or cgroup dir in BPF programs. It's important to
note that this helper is designed specifically for cgroup1 only.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/cgroup.h          |  6 +++++-
 kernel/cgroup/cgroup-internal.h |  1 -
 kernel/cgroup/cgroup-v1.c       | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index b307013b9c6c..0cd3983822c3 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -71,6 +71,7 @@ struct css_task_iter {
 extern struct file_system_type cgroup_fs_type;
 extern struct cgroup_root cgrp_dfl_root;
 extern struct css_set init_css_set;
+extern spinlock_t css_set_lock;
 
 #define SUBSYS(_x) extern struct cgroup_subsys _x ## _cgrp_subsys;
 #include <linux/cgroup_subsys.h>
@@ -159,6 +160,8 @@ void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
 			 struct css_task_iter *it);
 struct task_struct *css_task_iter_next(struct css_task_iter *it);
 void css_task_iter_end(struct css_task_iter *it);
+struct cgroup *task_cgroup_from_root(struct task_struct *task,
+				     struct cgroup_root *root);
 
 /**
  * css_for_each_child - iterate through children of a css
@@ -388,7 +391,6 @@ static inline void cgroup_unlock(void)
  * as locks used during the cgroup_subsys::attach() methods.
  */
 #ifdef CONFIG_PROVE_RCU
-extern spinlock_t css_set_lock;
 #define task_css_set_check(task, __c)					\
 	rcu_dereference_check((task)->cgroups,				\
 		rcu_read_lock_sched_held() ||				\
@@ -855,4 +857,6 @@ static inline void cgroup_bpf_put(struct cgroup *cgrp) {}
 
 #endif /* CONFIG_CGROUP_BPF */
 
+struct cgroup *task_get_cgroup1_within_hierarchy(struct task_struct *tsk, int hierarchy_id);
+
 #endif /* _LINUX_CGROUP_H */
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 321af20ea15f..3a7b0cc911f7 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -164,7 +164,6 @@ struct cgroup_mgctx {
 #define DEFINE_CGROUP_MGCTX(name)						\
 	struct cgroup_mgctx name = CGROUP_MGCTX_INIT(name)
 
-extern spinlock_t css_set_lock;
 extern struct cgroup_subsys *cgroup_subsys[];
 extern struct list_head cgroup_roots;
 
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index c487ffef6652..571071d45e4d 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1263,6 +1263,39 @@ int cgroup1_get_tree(struct fs_context *fc)
 	return ret;
 }
 
+/**
+ * task_cgroup_id_within_hierarchy - Acquires the associated cgroup of a task
+ * within a specific cgroup1 hierarchy. The cgroup1 hierarchy is identified by
+ * its hierarchy ID.
+ * @tsk: The target task
+ * @hierarchy_id: The ID of a cgroup1 hierarchy
+ *
+ * On success, the cgroup is returned. On failure, ERR_PTR is returned.
+ * We limit it to cgroup1 only.
+ */
+struct cgroup *task_get_cgroup1_within_hierarchy(struct task_struct *tsk, int hierarchy_id)
+{
+	struct cgroup *cgrp = ERR_PTR(-ENOENT);
+	struct cgroup_root *root;
+
+	rcu_read_lock();
+	list_for_each_entry(root, &cgroup_roots, root_list) {
+		/* cgroup1 only*/
+		if (root == &cgrp_dfl_root)
+			continue;
+		if (root->hierarchy_id != hierarchy_id)
+			continue;
+		spin_lock_irq(&css_set_lock);
+		cgrp = task_cgroup_from_root(tsk, root);
+		if (!cgrp || !cgroup_tryget(cgrp))
+			cgrp = ERR_PTR(-ENOENT);
+		spin_unlock_irq(&css_set_lock);
+		break;
+	}
+	rcu_read_unlock();
+	return cgrp;
+}
+
 static int __init cgroup1_wq_init(void)
 {
 	/*
-- 
2.30.1 (Apple Git-130)

