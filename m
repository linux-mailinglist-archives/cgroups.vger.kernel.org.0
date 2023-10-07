Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F34F7BC833
	for <lists+cgroups@lfdr.de>; Sat,  7 Oct 2023 16:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343969AbjJGODS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Oct 2023 10:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343934AbjJGODS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Oct 2023 10:03:18 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C66BA;
        Sat,  7 Oct 2023 07:03:17 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c3d8fb23d9so22730875ad.0;
        Sat, 07 Oct 2023 07:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696687397; x=1697292197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0XN7Vex7MkGdSDdhpaAp8dz+3fJJkVdmToBRqKC+GA=;
        b=QGu9kd9HrQBeWBOll61sV782W7azIZk3t3+HZzRqEzi1oryreVe3kI5JRwAeqqxHAl
         YaurZrAA+jWQafGaDHmLDs31EMAV9SEx26D7YiYFXWKyuioiM9FRWYvDes+e652YYvjc
         O/eA/Yk/hR8trX5z4GzyClizPlbp5nlqd2YfhvEeDr/OI3uFE9e4TCZVcpOdvO0QG48B
         NDzWS4Q+PrO90Wj+QLB8Sy9NNMQIBcOk+5/dtgJkvKqh3ybfUr3AD5hF1Cr60gIE8c6r
         Fcp/gb25c4kAIOAuT8P45JhtACMbKL5KtFcAE1HAuvBOyly+uGstaApQPLrQOFzpztrl
         exhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696687397; x=1697292197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0XN7Vex7MkGdSDdhpaAp8dz+3fJJkVdmToBRqKC+GA=;
        b=jA+ELtQ40Us1RwlSIA+14UFz2viRRhXguCaKtjgLqAL+Q3iUwgdHRwh3uaHUfB/m7X
         rEx5rIll9RDtX277b8kr/J3b4lDJNkEhQ3wZwFFtZA0FRxiUPmYBh4Tb/dZd9Hzvrzzn
         Ez+FM+rK/hbVxsY1x+KwOOQPA+7tTBsGHHpVXShjiZL8Pagxws7KkArKoj39hVO8kiT2
         7rmDek/WEBUtWzb0xQ9TeG9SOpgz4JWppV0/sG3mY7LSId2nLTpQYJ4LqSe621pVbDsD
         UvLFL3/hu+r2Exjqb7X6hBNaYZZZgPdMrWDzGNk6HPFduFgUpsnt78GrvJnKTpeMHo6J
         OMIw==
X-Gm-Message-State: AOJu0YxQFi5Ctr5lkT8lN0K6SD74Syr0nq4lcK8Ne6kHmMaWFNebmx8O
        3ztEygrwTC9lCQG/vLJABGU=
X-Google-Smtp-Source: AGHT+IG3kaDi0ghKnwH1wunGSJ9WRy7cYwWt06n6MnRzZ+SH1YfRKbazOlN2CKSbuK+9nyXZn+wy+A==
X-Received: by 2002:a17:902:dac3:b0:1bb:b86e:8d60 with SMTP id q3-20020a170902dac300b001bbb86e8d60mr12849206plx.46.1696687396664;
        Sat, 07 Oct 2023 07:03:16 -0700 (PDT)
Received: from vultr.guest ([45.77.191.53])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b001c0a414695dsm5897550plg.62.2023.10.07.07.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 07:03:16 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com, sinquersw@gmail.com
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 1/8] cgroup: Don't have to hold cgroup_mutex in task_cgroup_from_root()
Date:   Sat,  7 Oct 2023 14:02:57 +0000
Message-Id: <20231007140304.4390-2-laoar.shao@gmail.com>
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

The task cannot modify cgroups if we have already acquired the
css_set_lock, thus eliminating the need to hold the cgroup_mutex. Following
this change, task_cgroup_from_root() can be employed in non-sleepable contexts.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/cgroup/cgroup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1fb7f562289d..bd1692f48be5 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1453,7 +1453,7 @@ static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
 
 /*
  * Return the cgroup for "task" from the given hierarchy. Must be
- * called with cgroup_mutex and css_set_lock held.
+ * called with css_set_lock held.
  */
 struct cgroup *task_cgroup_from_root(struct task_struct *task,
 				     struct cgroup_root *root)
@@ -1462,7 +1462,8 @@ struct cgroup *task_cgroup_from_root(struct task_struct *task,
 	 * No need to lock the task - since we hold css_set_lock the
 	 * task can't change groups.
 	 */
-	return cset_cgroup_from_root(task_css_set(task), root);
+	lockdep_assert_held(&css_set_lock);
+	return __cset_cgroup_from_root(task_css_set(task), root);
 }
 
 /*
-- 
2.30.1 (Apple Git-130)

