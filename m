Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC7A59F4ED
	for <lists+cgroups@lfdr.de>; Wed, 24 Aug 2022 10:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbiHXIUA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Aug 2022 04:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbiHXIT6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Aug 2022 04:19:58 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C084857CD
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 01:19:58 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u22so15015165plq.12
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 01:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=KFhoipy95bP113xci+lGCwwditMpaEg770tCZfK2FCQ=;
        b=GlH6POhMxkFS95xU5zJMGW8H+X23wvpWqnYzcrsJBfEAuqIfo0ZAdpRSi3bnpYan7d
         41MJ816H6hy5iMnQ/1e99Mw7saohjTnOTAEuJIJtiEDxaE2lnFbrnalZB69bweIDitf3
         bXCr4JlID95qEy+fYmofaooTzZTbvOjnAWs1ZFIxOO8j6YG8eLh05jjact9kwCs74AnV
         SUUAORriiSdHNb5QHf5HXw4BJFeZ7pURb40oFVrAtPJjp3EgPie6UivFIl80nlVjM7xs
         8un5b5VtVGYsFbhLn5k1+U6Ycgrv63323+BtnkeAUMaLYZ9V6BBQ7BmYsxcnPgh3gSGY
         dv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KFhoipy95bP113xci+lGCwwditMpaEg770tCZfK2FCQ=;
        b=dGbogVoTqrCVe9p5CCBE3lt+bH5Xkd9rEwwjzN9bOxtYhUQ3E5hF15IIBeXnhvNCXf
         jDkdEcm0bFvhzhINrWOStVSBZ+gFCOPGU8TJ5ip9E6DVIwtbHrMJxC2L5UnIwJTMYCNw
         wAM4kLnMk0f1N9DTNleKEq/nLQEWQgTyb72Qjdv4tbiWOdlA1d/Dowmhpliv8k2Ttljx
         /XC6ceOuHbMFxI+e4R7sJFFt8yxk+7AZPaLrAbXDmK4JdN8yiS8uQW07lUKpdzhPUGTq
         ogGoR0XiR4SG8WtFrQusMhhQDeNedVU0/kyW2Hq+HP7CFCDG1YqSbbXf49FO1f/PYNWc
         VGZQ==
X-Gm-Message-State: ACgBeo1RK3CsxowdMUNhocsfRMa3Si8ne/fb6wovdBN7njTHTdv3yE4W
        fM3sY92u8Xoh9eTQqufEGeg/pQ==
X-Google-Smtp-Source: AA6agR7TdIZhRw2FWgfdn4JrRTJl6m+cOEmXzEMBbL7JNgZTvmCbh6hNMPh7aXGBDpWkjiinYDAyqg==
X-Received: by 2002:a17:90b:1901:b0:1fa:e81b:fc0e with SMTP id mp1-20020a17090b190100b001fae81bfc0emr7231297pjb.115.1661329197580;
        Wed, 24 Aug 2022 01:19:57 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id q31-20020a635c1f000000b00421841943dfsm10486587pgb.12.2022.08.24.01.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 01:19:57 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
        surenb@google.com
Cc:     gregkh@linuxfoundation.org, corbet@lwn.net, mingo@redhat.com,
        peterz@infradead.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 03/10] sched/psi: save percpu memory when !psi_cgroups_enabled
Date:   Wed, 24 Aug 2022 16:18:22 +0800
Message-Id: <20220824081829.33748-4-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220824081829.33748-1-zhouchengming@bytedance.com>
References: <20220824081829.33748-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We won't use cgroup psi_group when !psi_cgroups_enabled, so don't
bother to alloc percpu memory and init for it.

Also don't need to migrate task PSI stats between cgroups in
cgroup_move_task().

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/psi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 39463dcc16bb..77d53c03a76f 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -201,6 +201,7 @@ void __init psi_init(void)
 {
 	if (!psi_enable) {
 		static_branch_enable(&psi_disabled);
+		static_branch_disable(&psi_cgroups_enabled);
 		return;
 	}
 
@@ -950,7 +951,7 @@ void psi_memstall_leave(unsigned long *flags)
 #ifdef CONFIG_CGROUPS
 int psi_cgroup_alloc(struct cgroup *cgroup)
 {
-	if (static_branch_likely(&psi_disabled))
+	if (!static_branch_likely(&psi_cgroups_enabled))
 		return 0;
 
 	cgroup->psi = kzalloc(sizeof(struct psi_group), GFP_KERNEL);
@@ -968,7 +969,7 @@ int psi_cgroup_alloc(struct cgroup *cgroup)
 
 void psi_cgroup_free(struct cgroup *cgroup)
 {
-	if (static_branch_likely(&psi_disabled))
+	if (!static_branch_likely(&psi_cgroups_enabled))
 		return;
 
 	cancel_delayed_work_sync(&cgroup->psi->avgs_work);
@@ -996,7 +997,7 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 	struct rq_flags rf;
 	struct rq *rq;
 
-	if (static_branch_likely(&psi_disabled)) {
+	if (!static_branch_likely(&psi_cgroups_enabled)) {
 		/*
 		 * Lame to do this here, but the scheduler cannot be locked
 		 * from the outside, so we move cgroups from inside sched/.
-- 
2.37.2

