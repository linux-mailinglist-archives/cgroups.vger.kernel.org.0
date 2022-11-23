Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C749B63525E
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 09:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiKWIXu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 03:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbiKWIXp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 03:23:45 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56EF60373
        for <cgroups@vger.kernel.org>; Wed, 23 Nov 2022 00:23:42 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id t17so14620603pjo.3
        for <cgroups@vger.kernel.org>; Wed, 23 Nov 2022 00:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yo2K84hmvJF9oKmVUE8rVWn5muORVTM6UmA/7exBFUM=;
        b=VmEnvFprI1mHKVy+07lphANsK+RLSjSH8ZZGVFzeZ0SQCYsAvYfb8tQwV+GaQs4jMd
         Fhfh4ZC4WvVGyUc3TlX3vl0ZqD5kHFvh/BahqrDF0S8wapyOl1nAVvuhgDLPI6yPojVw
         LuFg+XX0OxUSgPe8Zq2RVjTjeKnvONyFn0cZRTsjOuIaEo7QUKwVu9hXgIFK9LgJ14Ym
         u3w+77ooTwpLJsCE55lO0l2qS8XmJ7T/0uHynGwdGMPgSlRm37X1Cfy9zcnQgo28/bZd
         G3Tcu28J0Id40ep5xIQ7m6QU0kNdS5nxA2SEjOkuuftUUfY2jdqRM7I4BdF79Ew+iIXI
         HGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yo2K84hmvJF9oKmVUE8rVWn5muORVTM6UmA/7exBFUM=;
        b=uE4Nr8M1a4/Cg5FL9NX5N/0ahel0062VbWFI31HHSeqxjaFuP5fhet5MRRJ/mSRqqR
         qXn+5jXz1+K8B7SQFybNJow+F7J5jsFzJZBYQpvQkhy+ZoYNLJZSdlF1sqkBSQcnrtE7
         zm+onNDMp21eApWhPff4tb98bfd3n/AirbcxcMZoZGVmkdKc6P4Ny+aX9VFcoaib3Tv9
         YBNT8E9HbB44IRYHdNnFqdR6wJ2LlGqBReasWczPrDxWcPgeHxUMTuZxiJcFwOyVyUsd
         4u0uXKMt0t7UnRgMhp+MmXXZz9Ju6X4ythe6IC0BI25gpRVaaa7TvL8taBJTWHqhbRi5
         4f7g==
X-Gm-Message-State: ANoB5pk+KNQsE9BhXYVJvx1W6v30N0nSeqhn6h+6CYJNCkCQ29CwRgIK
        IB3/HigXCwMrUtuEsM6g/0yb4os0Q0a8fw==
X-Google-Smtp-Source: AA0mqf4FevgVKHdekbRNTFvbZELocM4lIaNfW3Nt4RsG+HYtzkflHLBVWeGWOkbsn/f2CXfPF6KLSA==
X-Received: by 2002:a17:90b:2688:b0:218:b9e1:ebef with SMTP id pl8-20020a17090b268800b00218b9e1ebefmr12795766pjb.65.1669191822401;
        Wed, 23 Nov 2022 00:23:42 -0800 (PST)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id h17-20020aa79f51000000b0056c2e497b02sm12454017pfr.173.2022.11.23.00.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 00:23:42 -0800 (PST)
From:   "haifeng.xu" <haifeng.xu@shopee.com>
To:     longman@redhat.com
Cc:     lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "haifeng.xu" <haifeng.xu@shopee.com>
Subject: [PATCH] cgroup/cpuset: Optimize update_tasks_nodemask()
Date:   Wed, 23 Nov 2022 08:21:57 +0000
Message-Id: <20221123082157.71326-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When change the 'cpuset.mems' under some cgroup, system will hung
for a long time. From the dmesg, many processes or theads are
stuck in fork/exit. The reason is show as follows.

thread A:
cpuset_write_resmask /* takes cpuset_rwsem */
  ...
    update_tasks_nodemask
      mpol_rebind_mm /* waits mmap_lock */

thread B:
worker_thread
  ...
    cpuset_migrate_mm_workfn
      do_migrate_pages /* takes mmap_lock */

thread C:
cgroup_procs_write /* takes cgroup_mutex and cgroup_threadgroup_rwsem */
  ...
    cpuset_can_attach
      percpu_down_write /* waits cpuset_rwsem */

Once update the nodemasks of cpuset, thread A wakes up thread B to
migrate mm. But when thread A iterates through all tasks, including
child threads and group leader, it has to wait the mmap_lock which
has been take by thread B. Unfortunately, thread C wants to migrate
tasks into cgroup at this moment, it must wait thread A to release
cpuset_rwsem. If thread B spends much time to migrate mm, the
fork/exit which acquire cgroup_threadgroup_rwsem also need to
wait for a long time.

There is no need to migrate the mm of child threads which is
shared with group leader. Just iterate through the group
leader only.

Signed-off-by: haifeng.xu <haifeng.xu@shopee.com>
---
 kernel/cgroup/cpuset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 589827ccda8b..43cbd09546d0 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1968,6 +1968,9 @@ static void update_tasks_nodemask(struct cpuset *cs)
 
 		cpuset_change_task_nodemask(task, &newmems);
 
+		if (!thread_group_leader(task))
+			continue;
+
 		mm = get_task_mm(task);
 		if (!mm)
 			continue;
-- 
2.25.1

