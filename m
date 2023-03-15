Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57C06BBF3C
	for <lists+cgroups@lfdr.de>; Wed, 15 Mar 2023 22:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjCOVkg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Mar 2023 17:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjCOVkf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Mar 2023 17:40:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD1C4EDB
        for <cgroups@vger.kernel.org>; Wed, 15 Mar 2023 14:40:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g5-20020a25a485000000b009419f64f6afso21753236ybi.2
        for <cgroups@vger.kernel.org>; Wed, 15 Mar 2023 14:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678916433;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0vT5pZgC3odOnq/dCWudlRqWXNT/3pXxM4U4p7g/Zps=;
        b=GBOhli6DgB6C2e3UwLY3hOUyIJJCYvBv89mVgUJNI9rwDtzV+xfm8MeOiM6FEn49Og
         dac3udvhEPDGv68VxZ6KhmgYa4bE5Dz2pnI3o8WNC7zwpdH+SXm0yGK2BrWrxEibNsx8
         QKnsQoEIsXs+afDVgCAFeywJEHRVjsD4xI8bX3UKIZ4GhZqHkz0b+XtP5oLct1tiKV/F
         iYR9De56Y/qllKPi2/15D5E/kuCmnylV9fo3Kt/lp51pvJt+dzgVvcEIMWJNH5RgUhn3
         wmDFBrCXDyMivyyL/lELOeFVcxU8TifaiKU3oAM6dlFLK+vrPqZNEe2nDCphqMJtMcz7
         t7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678916433;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0vT5pZgC3odOnq/dCWudlRqWXNT/3pXxM4U4p7g/Zps=;
        b=y6jU7vbXxK6ygOe5Bh3WEBIok9RPhQjRM03AHVmeiBaeQ2Fq9KDMk8Ri9Xous0hwDE
         efIyhGlhYYrvff91g+MmVunvlrmr8rS8dx4j7F4E9O3jtjHawr3cVspCVnsgWycjosf4
         X2pw+MyPccOHZ6GO0pBee+9WFHdzZZhKSm5IfGuXc6aOxASznFjGx6oqDlIBGVeC7ed+
         uuaYmRNqBcUoB6v6oTkchJjEuxRwTqN6/YVD4BVqoTOv7etz294K5tZ1XPi2z/mNIQV+
         zEzxBgNEpy/qEd+lRv/xzBhAHE3Kls/HCRyArMrnRJEtxYnmJxBkUbE0+1vxAsUDLBNj
         Rq4A==
X-Gm-Message-State: AO0yUKWrDrBdHRKU3jtH1U5DjUkuCGPNJ3GvEOnTYBUqURbnfoPAPHg1
        km6+r9HTpFqA2eCrBgGwbZTIRITo2pSY
X-Google-Smtp-Source: AK7set+CKIA9ZIEye56laL62srsDkRhvodbIp2AR/zSjX2tYwzng91U5EIxkNpMgpy6cESV4UeWNIkmL36mi
X-Received: from joshdon-desktop.svl.corp.google.com ([2620:15c:2d4:203:d03e:7c5d:386a:dce3])
 (user=joshdon job=sendgmr) by 2002:a05:690c:68d:b0:521:daa4:d687 with SMTP id
 bp13-20020a05690c068d00b00521daa4d687mr1098786ywb.0.1678916433410; Wed, 15
 Mar 2023 14:40:33 -0700 (PDT)
Date:   Wed, 15 Mar 2023 14:40:29 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230315214029.899573-1-joshdon@google.com>
Subject: [PATCH] cgroup: fix display of forceidle time at root
From:   Josh Don <joshdon@google.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We need to reset forceidle_sum to 0 when reading from root, since the
bstat we accumulate into is stack allocated.

To make this more robust, just replace the existing cputime reset with a
memset of the overall bstat.

Signed-off-by: Josh Don <joshdon@google.com>
---
 kernel/cgroup/rstat.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 831f1f472bb8..0a2b4967e333 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -457,9 +457,7 @@ static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
 	struct task_cputime *cputime = &bstat->cputime;
 	int i;
 
-	cputime->stime = 0;
-	cputime->utime = 0;
-	cputime->sum_exec_runtime = 0;
+	memset(bstat, 0, sizeof(*bstat));
 	for_each_possible_cpu(i) {
 		struct kernel_cpustat kcpustat;
 		u64 *cpustat = kcpustat.cpustat;
-- 
2.40.0.rc1.284.g88254d51c5-goog

