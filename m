Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F906AC5B3
	for <lists+cgroups@lfdr.de>; Mon,  6 Mar 2023 16:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjCFPmp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Mar 2023 10:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjCFPmm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Mar 2023 10:42:42 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BF73252A;
        Mon,  6 Mar 2023 07:42:10 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id g9so5192248qvt.8;
        Mon, 06 Mar 2023 07:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678117329;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9pBtlfX3iX0mnIfMkXEb8DAWvw6xGcJJJjqlGD9DGtU=;
        b=HI57W0h/lsMjojvv+zd6JUMMWfpuLUUkHmJdcSeTT3huiaVqKw0ZaYXEVUHoyQoCpd
         3wcHeR6DHkno5XMBlny+fNZ2lOjN82n2YQshjBKIJr+wqAAp4HxFny5wOeIUJ6upLr/r
         216Nv2vhFDjRN01F616HEFsYeyB46dqPqDHxkh9lbfqAjGxU0VqXw9/3wS1zZ3+VyiUl
         AWuagchq1EPyD5ftP4eYCkr9P+rPwXFj2OD9PePU1jgW2gRkA9MlpwLpIeb5m2KLFiPt
         bbS1upjBPwIDNY9pav64h/RTc3NDCax2XMV3HalH+0KH+rOaOAgP7n0T0m1W9whMv+GX
         in1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678117329;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9pBtlfX3iX0mnIfMkXEb8DAWvw6xGcJJJjqlGD9DGtU=;
        b=oaWMwJFgyly7Z/xXzVTBrcegmtzidZFvDi1E5lgswzFM22q+6fgIWTUqUeXpAUm++W
         YLTZsBCiYr5xt7KPoekiCZwjoESqEfQK43Cd8Wb1hbdA+j1zO1cSQnkYvd+BkR/NVukg
         ZE2IPRgo7Oc3x9I7T33nTb4SKwr9+XwFg1WNK6QIFGo2q5q1nHFXSHnlJKHL8TEscA+Z
         VUYsvW+UzoKTU3vszVFuAjFIK/fcAObpGtX/65TXlcvkE5JgZW3NIuaboAxMHX4al1G/
         bUQDTTEyOd1pFIjkvMlvnbfJipf1BQYdSrKhPVJ7X+Vpi8ndJ5LqetkM6uEjGfmlOdoh
         vfHA==
X-Gm-Message-State: AO0yUKWj12mwuJOl58vfPHpGJauDRXaB5blOQ+I6GFQpTiJivXb9yhbu
        1dWDKTdFlr+KbjEK03wq0vM=
X-Google-Smtp-Source: AK7set+PYHXQ4/t05TqYV2yAc6h2RjGW1O2Vxvoz+ZokI1GTziV92hpARDUoYLqNanP2krsSzegEJQ==
X-Received: by 2002:a05:6214:240e:b0:56e:b91f:aeb4 with SMTP id fv14-20020a056214240e00b0056eb91faeb4mr18753964qvb.36.1678117329268;
        Mon, 06 Mar 2023 07:42:09 -0800 (PST)
Received: from MSI-FindNS.localdomain ([107.191.40.138])
        by smtp.gmail.com with ESMTPSA id u19-20020a05620a121300b007424376ca4bsm7618400qkj.18.2023.03.06.07.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:42:08 -0800 (PST)
From:   Yue Zhao <findns94@gmail.com>
To:     akpm@linux-foundation.org
Cc:     roman.gushchin@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, muchun.song@linux.dev, willy@infradead.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangyeechou@gmail.com,
        Yue Zhao <findns94@gmail.com>
Subject: [PATCH v2, 1/4] mm, memcg: Prevent memory.oom.group load/store tearing
Date:   Mon,  6 Mar 2023 23:41:35 +0800
Message-Id: <20230306154138.3775-2-findns94@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306154138.3775-1-findns94@gmail.com>
References: <20230306154138.3775-1-findns94@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The knob for cgroup v2 memory controller: memory.oom.group
is not protected by any locking so it can be modified while it is used.
This is not an actual problem because races are unlikely (the knob is
usually configured long before any workloads hits actual memcg oom)
but it is better to use READ_ONCE/WRITE_ONCE to prevent compiler from
doing anything funky.

The access of memcg->oom_group is lockless, so it can be
concurrently set at the same time as we are trying to read it.

Signed-off-by: Yue Zhao <findns94@gmail.com>
---
 mm/memcontrol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5abffe6f8389..06821e5f7604 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2067,7 +2067,7 @@ struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
 	 * highest-level memory cgroup with oom.group set.
 	 */
 	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
-		if (memcg->oom_group)
+		if (READ_ONCE(memcg->oom_group))
 			oom_group = memcg;
 
 		if (memcg == oom_domain)
@@ -6623,7 +6623,7 @@ static int memory_oom_group_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	seq_printf(m, "%d\n", memcg->oom_group);
+	seq_printf(m, "%d\n", READ_ONCE(memcg->oom_group));
 
 	return 0;
 }
@@ -6645,7 +6645,7 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
 	if (oom_group != 0 && oom_group != 1)
 		return -EINVAL;
 
-	memcg->oom_group = oom_group;
+	WRITE_ONCE(memcg->oom_group, oom_group);
 
 	return nbytes;
 }
-- 
2.17.1

