Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94677790C6D
	for <lists+cgroups@lfdr.de>; Sun,  3 Sep 2023 16:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjICO2N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 3 Sep 2023 10:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237907AbjICO2N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 3 Sep 2023 10:28:13 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A8697;
        Sun,  3 Sep 2023 07:28:09 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68c0cb00fb3so585550b3a.2;
        Sun, 03 Sep 2023 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693751289; x=1694356089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMXLcIWio9WW57rG1glRWMEPDKGAafnI6Sr1JX6PcGQ=;
        b=LzVEieRrkSFlJ8mJ+2vRTvgW+b8tuZ1vl3MVX0HWrPwLSZpeV2sJGWL3iZ6LtUg3We
         aIoe90saY0SE/4qVQTwIq496PdeKhSpaZHQFnmuEeS6BpoRNvz9SnXjtBK8qUPbQYy1C
         XOPZc6WMep7QcvL9nMB/jlhT2+1/6D5BfllT5fNX15djA+4qvqFP365NbRAu+CGjLTqF
         bkaheS4ccN4TYmzML38Dh6IhVwMD3mrCjyj4g17UZJRERfG0q3X9rgOrjtDC4OTCiSY5
         /YxFUU7KgA5zRBQvYBVIDRPy4LQp1MpZFPEHwwzX+bGceV4mqwEdKRniJOA27wCRfk6D
         e1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693751289; x=1694356089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMXLcIWio9WW57rG1glRWMEPDKGAafnI6Sr1JX6PcGQ=;
        b=MMSz60v7pIN3jgnsw0KTstU0Z/78K+0DBH/2EWH96/CaNY4NEaSrBuL8pGxEgc5sRo
         LdSeMBRz3rBH0uJz9ERMgJH9WwXwv/+kuTHhcKW3Oh/3/WcrxFrlttLSa86xMN6zbzGW
         nNCJdifkqFfxXxZKsF7nRbVsrpnlTUFF3ohmI7VOzByxAtPQblcZByQezyXO8EpVjXoX
         ZLOpkN5FsjxXyIl159hI+r6jj1DakQwsB1UQtPL4VIW7vN6joCtjzq+uBgj9hrVK4sS+
         yX4Y7a5bFuh1LcpFWQaGlmxjxH/Ym6UNQoNazjXLByrUkfRNMwMZTMSRZixf+dgm3asI
         2SXg==
X-Gm-Message-State: AOJu0Yxc8zWFb1Kg2LGiedozMq9umdYsDXCkwq5Uzc0M6x0oOMbyRQ5V
        lbZU2p2jkvWeukrHE41kk04=
X-Google-Smtp-Source: AGHT+IGOu8boHCQGqBvBcdoaGjSTQeTtKihvjht+tXjBHfxM2y+irCbA+orNtXS9XNif83fvsXPpmQ==
X-Received: by 2002:a05:6a00:22c7:b0:68c:4c29:9c59 with SMTP id f7-20020a056a0022c700b0068c4c299c59mr9909256pfj.14.1693751289245;
        Sun, 03 Sep 2023 07:28:09 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:185:5400:4ff:fe8f:9150])
        by smtp.gmail.com with ESMTPSA id b23-20020aa78117000000b0065a1b05193asm5809977pfi.185.2023.09.03.07.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 07:28:08 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 1/5] cgroup: Enable task_under_cgroup_hierarchy() on cgroup1
Date:   Sun,  3 Sep 2023 14:27:56 +0000
Message-Id: <20230903142800.3870-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230903142800.3870-1-laoar.shao@gmail.com>
References: <20230903142800.3870-1-laoar.shao@gmail.com>
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

Currently, the function task_under_cgroup_hierarchy() allows us to
determine if a task resides exclusively within a cgroup2 hierarchy.
Nevertheless, given the continued prevalence of cgroup1, it's useful that
we make a minor adjustment to extend its functionality to cgroup1 as well.
Once this modification is implemented, we will have the ability to
effortlessly verify a task's cgroup membership within BPF programs. For
instance, we can easily check if a task belongs to a cgroup1 directory,
such as /sys/fs/cgroup/cpu,cpuacct/kubepods/burstable/ or
/sys/fs/cgroup/cpu,cpuacct/kubepods/besteffort/.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/cgroup.h | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index b307013..5414a2c 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -543,15 +543,33 @@ static inline struct cgroup *cgroup_ancestor(struct cgroup *cgrp,
  * @ancestor: possible ancestor of @task's cgroup
  *
  * Tests whether @task's default cgroup hierarchy is a descendant of @ancestor.
- * It follows all the same rules as cgroup_is_descendant, and only applies
- * to the default hierarchy.
+ * It follows all the same rules as cgroup_is_descendant.
  */
 static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
 					       struct cgroup *ancestor)
 {
 	struct css_set *cset = task_css_set(task);
+	struct cgroup *cgrp;
+	bool ret = false;
+	int ssid;
+
+	if (ancestor->root == &cgrp_dfl_root)
+		return cgroup_is_descendant(cset->dfl_cgrp, ancestor);
+
+	for (ssid = 0; ssid < CGROUP_SUBSYS_COUNT; ssid++) {
+		if (!ancestor->subsys[ssid])
+			continue;
 
-	return cgroup_is_descendant(cset->dfl_cgrp, ancestor);
+		cgrp = task_css(task, ssid)->cgroup;
+		if (!cgrp)
+			continue;
+
+		if (!cgroup_is_descendant(cgrp, ancestor))
+			return false;
+		if (!ret)
+			ret = true;
+	}
+	return ret;
 }
 
 /* no synchronization, the result can only be used as a hint */
-- 
1.8.3.1

