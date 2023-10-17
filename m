Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F117CC383
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 14:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbjJQMqL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Oct 2023 08:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbjJQMqJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Oct 2023 08:46:09 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F7E10E;
        Tue, 17 Oct 2023 05:46:07 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-581de3e691dso226036eaf.3;
        Tue, 17 Oct 2023 05:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697546767; x=1698151567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCXtSvPvz316d1Voc+hvRatGwRHZV08vgvHRUKG7YWA=;
        b=E0EWeZq6RgytvYJvN0y+Ga/WkK88rEYn8Lr8Rqt5vb4L1Ep0p6901ta9lrpYVNnpC3
         IBoPqV+Ibm9CpSQZvUVK7Cm2TkOHROuO03+jBaPuoygUANzE07jrCZfp+uj+CPLAURct
         RzBt4xm4Nr2o3i/VyAu/DqBMF8N1DIoSjgqscDBHwE6gdBnlW7NXD/aEXHsQhG61fXWl
         cL7GuPDLFAVVXCIZnFYZOAHkFlbTO632PZpkSIyobr4nvqTyaKflJ7igOM4KiSgaLiKm
         bv5AIidOprjR9hoDVkxo0BKjHDQFDeWRZEqjw1+S7GI6SVyFu6UlWQnIk0noxc2Hm32q
         JkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697546767; x=1698151567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yCXtSvPvz316d1Voc+hvRatGwRHZV08vgvHRUKG7YWA=;
        b=O7QvY/snbobqJ3/l+NCmGLDTm1eS7v7Cd1rwLQABsAV3zLDvSDG6Y6HxM7t2dDbwLl
         tvtQZOiO38txENVY5EQx6QwbCbDpziPhDzlkuY0lNeIsn0zvu+88WNnAy89BXBjvNA0O
         uu8d6mjZw2Uo9KB+CPYhDKpRzBCb3+/5XaRWmT/TdQEUxyHdephA0jg+JNEUZjBaOTUG
         8JW57WUWf2mwcXm+vvlixKRzkh31pV1gtYNVqVuYPGRZ0tIz+dYVXEs+Y3EJKbLd4Tax
         0lb2vtRFMzRIAotVA1ZoHTm6C7GPGEIA/i1VbRZMHTLYuzk079CaifTQ84Tifn7ZAXN8
         /2Ug==
X-Gm-Message-State: AOJu0YwkToMh8W2yY28N/ljGVVixJh8t27iwlEc/P695ySdBojqEVgSp
        EDbeF3XIElvA6pOnsdDxXBvDcKc7/NOEuSpJ
X-Google-Smtp-Source: AGHT+IEEJqflxC8e3DYCx6Y5qEdFTsXJBr8j9YkChDHIK4M0U4dIb2kAryppGN93U4HIcrSrwzxp0A==
X-Received: by 2002:a05:6359:100e:b0:166:cc78:ee9b with SMTP id ib14-20020a056359100e00b00166cc78ee9bmr2385097rwb.8.1697546766634;
        Tue, 17 Oct 2023 05:46:06 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:3b2:5400:4ff:fe9b:d21b])
        by smtp.gmail.com with ESMTPSA id fa36-20020a056a002d2400b006bdf4dfbe0dsm1375595pfb.12.2023.10.17.05.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:46:06 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com, sinquersw@gmail.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next v2 1/9] cgroup: Make operations on the cgroup root_list RCU safe
Date:   Tue, 17 Oct 2023 12:45:38 +0000
Message-Id: <20231017124546.24608-2-laoar.shao@gmail.com>
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

At present, when we perform operations on the cgroup root_list, we must
hold the cgroup_mutex, which is a relatively heavyweight lock. In reality,
we can make operations on this list RCU-safe, eliminating the need to hold
the cgroup_mutex during traversal. Modifications to the list only occur in
the cgroup root setup and destroy paths, which should be infrequent in a
production environment. In contrast, traversal may occur frequently.
Therefore, making it RCU-safe would be beneficial.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/cgroup-defs.h     |  1 +
 kernel/cgroup/cgroup-internal.h |  3 ++-
 kernel/cgroup/cgroup.c          | 17 ++++++++++-------
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index f1b3151ac30b..8505eeae6e41 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -558,6 +558,7 @@ struct cgroup_root {
 
 	/* A list running through the active hierarchies */
 	struct list_head root_list;
+	struct rcu_head rcu;
 
 	/* Hierarchy-specific flags */
 	unsigned int flags;
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index c56071f150f2..321af20ea15f 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -170,7 +170,8 @@ extern struct list_head cgroup_roots;
 
 /* iterate across the hierarchies */
 #define for_each_root(root)						\
-	list_for_each_entry((root), &cgroup_roots, root_list)
+	list_for_each_entry_rcu((root), &cgroup_roots, root_list,	\
+				!lockdep_is_held(&cgroup_mutex))
 
 /**
  * for_each_subsys - iterate all enabled cgroup subsystems
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1fb7f562289d..bae8f9f27792 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1313,7 +1313,7 @@ static void cgroup_exit_root_id(struct cgroup_root *root)
 
 void cgroup_free_root(struct cgroup_root *root)
 {
-	kfree(root);
+	kfree_rcu(root, rcu);
 }
 
 static void cgroup_destroy_root(struct cgroup_root *root)
@@ -1346,7 +1346,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 	spin_unlock_irq(&css_set_lock);
 
 	if (!list_empty(&root->root_list)) {
-		list_del(&root->root_list);
+		list_del_rcu(&root->root_list);
 		cgroup_root_count--;
 	}
 
@@ -1386,13 +1386,15 @@ static inline struct cgroup *__cset_cgroup_from_root(struct css_set *cset,
 		}
 	}
 
-	BUG_ON(!res_cgroup);
+	WARN_ON_ONCE(!res_cgroup && lockdep_is_held(&cgroup_mutex));
 	return res_cgroup;
 }
 
 /*
  * look up cgroup associated with current task's cgroup namespace on the
- * specified hierarchy
+ * specified hierarchy. Umount synchronization is ensured via VFS layer,
+ * so we don't have to hold cgroup_mutex to prevent the root from being
+ * destroyed.
  */
 static struct cgroup *
 current_cgns_cgroup_from_root(struct cgroup_root *root)
@@ -1445,7 +1447,6 @@ static struct cgroup *current_cgns_cgroup_dfl(void)
 static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
 					    struct cgroup_root *root)
 {
-	lockdep_assert_held(&cgroup_mutex);
 	lockdep_assert_held(&css_set_lock);
 
 	return __cset_cgroup_from_root(cset, root);
@@ -1453,7 +1454,9 @@ static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
 
 /*
  * Return the cgroup for "task" from the given hierarchy. Must be
- * called with cgroup_mutex and css_set_lock held.
+ * called with css_set_lock held to prevent task's groups from being modified.
+ * Must be called with either cgroup_mutex or rcu read lock to prevent the
+ * cgroup root from being destroyed.
  */
 struct cgroup *task_cgroup_from_root(struct task_struct *task,
 				     struct cgroup_root *root)
@@ -2097,7 +2100,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	 * care of subsystems' refcounts, which are explicitly dropped in
 	 * the failure exit path.
 	 */
-	list_add(&root->root_list, &cgroup_roots);
+	list_add_rcu(&root->root_list, &cgroup_roots);
 	cgroup_root_count++;
 
 	/*
-- 
2.30.1 (Apple Git-130)

