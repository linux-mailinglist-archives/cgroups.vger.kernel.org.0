Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1BD7AB09F
	for <lists+cgroups@lfdr.de>; Fri, 22 Sep 2023 13:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjIVL3U (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 07:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbjIVL3T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 07:29:19 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048AE91;
        Fri, 22 Sep 2023 04:29:11 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso1651276b3a.0;
        Fri, 22 Sep 2023 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695382150; x=1695986950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHx9zaz06OEXWU+TLyQGeUCpNolCvM+zvySDcLZVKEk=;
        b=e6XHujtU2Xmv56Jn0+m+2DYhpGsthOUu9Gte9bZzvYYRAIDR0u29uGpH//SACfBzLI
         MQrgx5QZnM8YL3OQxZvjXzYscm18DEr9t5cuO5dih6pUDkW11ejfi2nol1lrvKNWHpXK
         dkrvX5fCWdvVh68V2SZJhBoPunsf8YH2tpmxfFQBT+N6R9S1p1TqBdrCddg+9m0JT14J
         lqW1aBfBnS2iXB3y+/g0zDZSBdosQQlIDNLx6rcVP7MvIGEQ6oyuysubH9rhlMUGwB5T
         z7UxooOhIwl+Cs+/ZCc5VEUgUxAZmNls+tsHfLt2PARq5Tjp+GElRAZZbCUDawbdYtj7
         zcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695382150; x=1695986950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHx9zaz06OEXWU+TLyQGeUCpNolCvM+zvySDcLZVKEk=;
        b=WJkutIzUJwdk5ItVg0zT1Khnx5B6GLnYziRMzn4ZoBkHhx1Y5kMTONEF+nmPMAhU3U
         yHlW81QreVALCe8s2OGZPAF7lKhwYbUer7Aeq3cbCtcxbvPf2g4nICoOkkUWsHyoB3PE
         2n70nNHpe5ghLCaFdSmjpui8RSugqT7rMqyL2xyNYSGeu5aSef+GAe4n3xiR/e51xyy0
         7s827xVmolNob4x7zRHKZW6Bdt99nl6xbpA8RMjcJUFi7x8rgC6q6i3psmNiT8S0X9Sy
         5iDrMwPyyAUlcf0SOpYSLQkci6m6Fyt3Scb4Qboc97TeEf+b16+5RAJ6vQspdnpocpgI
         bx5g==
X-Gm-Message-State: AOJu0YxNmM171ngABFTfuxFeMqa7JbmXkhGyGn4kHLeUdQTR8077u2lz
        SCaDLFPSiSDXOttGtyYyKxc=
X-Google-Smtp-Source: AGHT+IFmdHkwv++M6SDNQlmrcG9FGrpSN70P30Er1/YnrdybTEQ90BaY94ATOGJvWNJaZSPWlHimpQ==
X-Received: by 2002:a05:6a20:258f:b0:134:73f6:5832 with SMTP id k15-20020a056a20258f00b0013473f65832mr3745501pzd.16.1695382150344;
        Fri, 22 Sep 2023 04:29:10 -0700 (PDT)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id v16-20020aa78090000000b00690beda6987sm2973493pff.77.2023.09.22.04.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 04:29:09 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 3/8] cgroup: Add cgroup_get_from_id_within_subsys()
Date:   Fri, 22 Sep 2023 11:28:41 +0000
Message-Id: <20230922112846.4265-4-laoar.shao@gmail.com>
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

Introduce a new helper function to retrieve the cgroup associated with a
specific cgroup ID within a particular subsystem.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/cgroup.h |  1 +
 kernel/cgroup/cgroup.c | 32 +++++++++++++++++++++++++++-----
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index e16cfb98b44c..9f7616cbf710 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -656,6 +656,7 @@ static inline void cgroup_kthread_ready(void)
 
 void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen);
 struct cgroup *cgroup_get_from_id(u64 id);
+struct cgroup *cgroup_get_from_id_within_subsys(u64 cgid, int ssid);
 #else /* !CONFIG_CGROUPS */
 
 struct cgroup_subsys_state;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1fb7f562289d..d30a62eed14c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6195,17 +6195,28 @@ void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
 }
 
 /*
- * cgroup_get_from_id : get the cgroup associated with cgroup id
- * @id: cgroup id
+ * cgroup_get_from_id_within_subsys - get the cgroup associated with cgroup id
+ *                                    within specific subsystem
+ * @cgid: cgroup id
+ * @ssid: cgroup subsystem id, -1 for cgroup default tree
  * On success return the cgrp or ERR_PTR on failure
  * Only cgroups within current task's cgroup NS are valid.
  */
-struct cgroup *cgroup_get_from_id(u64 id)
+struct cgroup *cgroup_get_from_id_within_subsys(u64 cgid, int ssid)
 {
+	struct cgroup_root *root;
 	struct kernfs_node *kn;
-	struct cgroup *cgrp, *root_cgrp;
+	struct cgroup *cgrp;
 
-	kn = kernfs_find_and_get_node_by_id(cgrp_dfl_root.kf_root, id);
+	if (ssid == -1) {
+		root = &cgrp_dfl_root;
+	} else {
+		if (ssid >= CGROUP_SUBSYS_COUNT)
+			return ERR_PTR(-EINVAL);
+		root = cgroup_subsys[ssid]->root;
+	}
+
+	kn = kernfs_find_and_get_node_by_id(root->kf_root, cgid);
 	if (!kn)
 		return ERR_PTR(-ENOENT);
 
@@ -6226,6 +6237,17 @@ struct cgroup *cgroup_get_from_id(u64 id)
 	if (!cgrp)
 		return ERR_PTR(-ENOENT);
 
+	return cgrp;
+}
+
+struct cgroup *cgroup_get_from_id(u64 id)
+{
+	struct cgroup *root_cgrp, *cgrp;
+
+	cgrp = cgroup_get_from_id_within_subsys(id, -1);
+	if (IS_ERR(cgrp))
+		return cgrp;
+
 	root_cgrp = current_cgns_cgroup_dfl();
 	if (!cgroup_is_descendant(cgrp, root_cgrp)) {
 		cgroup_put(cgrp);
-- 
2.30.1 (Apple Git-130)

