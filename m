Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF6068F306
	for <lists+cgroups@lfdr.de>; Wed,  8 Feb 2023 17:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjBHQSP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Feb 2023 11:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjBHQSJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Feb 2023 11:18:09 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF3F4C23;
        Wed,  8 Feb 2023 08:17:54 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id ay1so13437065pfb.7;
        Wed, 08 Feb 2023 08:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CLR2LM9bOa8i4/I3y14C5vPCowOG7PM+DN198h0+VAs=;
        b=n87yh6bfvYPCTO66tuyXJeAxOYVtR5er8Gk+eHejQ2btZam1yZWJTqT47teGvikGq3
         phDI1MRYT59/UiaAWI2BUi+1Q4j2oVxq2XK3Ke0b25NlcjfyH1ieBcd5CkQ0WEvDGV+h
         vADCrHGRBuuIf+qtxatJPOUIB0SG13dfhTFR45h8JE/oJDeaTp08BAIcVxxJyQ8FmMI2
         4ZJDP/ie/FD8+Aq9LP0zmJrEW1D3ByYmyWYsj+f4RYb8Pidapbovhyko7B6avejII/Pw
         lqDBkiZyH32dIDkG+lGBV/qDRoa1L2jKFIsHQS71X8mq/n07nyo+77OHdYAd/MxQTufX
         0Y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLR2LM9bOa8i4/I3y14C5vPCowOG7PM+DN198h0+VAs=;
        b=SQE93ar+zSydvIo9RYzye9xzLkkI22AfyaQUGEYUuWbl0EaeabwnQfZRJH2ZUDaf53
         sxPh8SEXg4wHKrANqLy1157bVdkYFF0gg3Qi1/3sKl43x62lJDbpVNxEupopTNS2dNTf
         t7ijIlEF5KK73C8pO5dbGdgHlmgX+wupObcYGKukDiymZOtj4NiPsvKHXybqHSSZCdrh
         WrQwo644Aap0yV5XgQHTKFtAY/Pjp2mQkuN1Us8Nws01c6EItqIBQ37jt8QWDYytghsl
         6q10cKze+jieGgZeCGmiTb1ifLmZ1MiPyN3415FAWFYuAcmT9ygzqnn2kk3gibz4QaJp
         YB2Q==
X-Gm-Message-State: AO0yUKVm/YVrlClo2QhK/Z8CFCuccpMmSIOeAQMcVy1jbx2BzP7iGH+8
        941uK/rSgilMdvCISJXPKQY=
X-Google-Smtp-Source: AK7set/rF4RJH6cPn5P48nOywhRtC5HwV75dLt4GS3pJ46OGetRSMumoSCqGE3klXX1yNVB8Iw/bwQ==
X-Received: by 2002:a62:14cc:0:b0:5a8:4e08:19f9 with SMTP id 195-20020a6214cc000000b005a84e0819f9mr442565pfu.26.1675873073933;
        Wed, 08 Feb 2023 08:17:53 -0800 (PST)
Received: from KASONG-MB0.tencent.com ([115.171.40.195])
        by smtp.gmail.com with ESMTPSA id s21-20020a056a00195500b0059252afc069sm11445485pfk.64.2023.02.08.08.17.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Feb 2023 08:17:53 -0800 (PST)
From:   Kairui Song <ryncsn@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: [PATCH 1/2] sched/psi: simplify cgroup psi retrieving
Date:   Thu,  9 Feb 2023 00:16:53 +0800
Message-Id: <20230208161654.99556-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20230208161654.99556-1-ryncsn@gmail.com>
References: <20230208161654.99556-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
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

From: Kairui Song <kasong@tencent.com>

Since the only case where cgroup_psi should return psi_system instead of
the cgroup's psi_group is the root cgroup, just set root cgroup's psi to
point to psi_system to remove the if branch.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/psi.h    | 2 +-
 kernel/cgroup/cgroup.c | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index b029a847def1..9c3a1638b618 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -33,7 +33,7 @@ __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
 #ifdef CONFIG_CGROUPS
 static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
 {
-	return cgroup_ino(cgrp) == 1 ? &psi_system : cgrp->psi;
+	return cgrp->psi;
 }
 
 int psi_cgroup_alloc(struct cgroup *cgrp);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c099cf3fa02d..1491d63b06b6 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -163,7 +163,12 @@ static struct static_key_true *cgroup_subsys_on_dfl_key[] = {
 static DEFINE_PER_CPU(struct cgroup_rstat_cpu, cgrp_dfl_root_rstat_cpu);
 
 /* the default hierarchy */
-struct cgroup_root cgrp_dfl_root = { .cgrp.rstat_cpu = &cgrp_dfl_root_rstat_cpu };
+struct cgroup_root cgrp_dfl_root = {
+	.cgrp.rstat_cpu = &cgrp_dfl_root_rstat_cpu,
+#ifdef CONFIG_PSI
+	.cgrp.psi = &psi_system
+#endif
+};
 EXPORT_SYMBOL_GPL(cgrp_dfl_root);
 
 /*
-- 
2.39.1

