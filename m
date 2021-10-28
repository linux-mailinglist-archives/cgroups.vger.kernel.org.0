Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747B743F289
	for <lists+cgroups@lfdr.de>; Fri, 29 Oct 2021 00:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhJ1WSC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Oct 2021 18:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhJ1WSC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Oct 2021 18:18:02 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14728C061570;
        Thu, 28 Oct 2021 15:15:35 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id g17so7284802qtk.8;
        Thu, 28 Oct 2021 15:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CE76jWMeyxCY5I/qaaAbgmKw1EMykfKV4BEuJDaHL6g=;
        b=bC5SbaUerEviaszA0wT3TsZ+ctvQ/QnSXU7T7i7Fy6GxjbipoH+8sKTQiCIJfzRUSs
         ovm57fVyR0Cxx+fiJP1BuUI/ZaqfOCMANrxpU9SYDCxLRI5tmCJTltM2I/sGr2/Q4ZC4
         OK/KF/Ynq17jKFTkQWmmnSX5aW/JbZfmyYOIkn7ByKOju2mAb4iMZkEhe05yhUS9h/GQ
         cTLiXhEevJw8JsJxvA1tEfsVxMY/XQqddtwKcOvDn9F8USO6FAVFlday3CS6fXnTYFIK
         fNYN1JjbWPnZfqKsVhiu465bq9SDnAQvZqf141HWdEvURrdf3PdfVr0oatCtxJ+GOUdX
         Ushg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CE76jWMeyxCY5I/qaaAbgmKw1EMykfKV4BEuJDaHL6g=;
        b=dYyzQn2o5/aQ3Q3uHsCVaMSKBkJwLow8qzqqZsxHYsZlEnYzqiSDAagYZni6qBg64B
         fHMcUPJeHI5h7D23INAliVXE0ALu1SQbu+NJtJtcK4An9mlTTVEpoEsUx9B7yHvXYNnF
         n+1yK9MyTycsP2WJbKqaZJRyS2R5TZ/4f1lL9karTkHo8KaOQ6bKmhBpx6ph4K4AywlK
         1wQD19fFY7P/ecTEjcxf3SDfPjWUwotuokVUREv4ooAMu0kXLHT2wt2ZtsI+j4fkDX4B
         LYhnOEUeLX0MIFwxKc0csaVjuDQ4378O5t8K6vYWHAn6Lfk7J1B1NKmAxTb04qEeRScN
         8M5w==
X-Gm-Message-State: AOAM533Ysa/OgciufZaKQk1l3d7w1uj/Nyw/NA395R8n2X8T9HzgDeCM
        lCQ6zcFGTf+pWKjPxUM8dvc=
X-Google-Smtp-Source: ABdhPJwA0BfWj5EG71e6vKa95CPIt6z4r3DZerwPHgsjI9oACmExo0NEFIi6aqOQDyB1q5ZVRBIbYA==
X-Received: by 2002:a05:622a:14:: with SMTP id x20mr7876016qtw.372.1635459334249;
        Thu, 28 Oct 2021 15:15:34 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e592])
        by smtp.gmail.com with ESMTPSA id 10sm2958801qkv.37.2021.10.28.15.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 15:15:33 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Boris Burkov <boris@bur.io>,
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] cgroup: Fix rootcg cpu.stat guest double counting
Date:   Thu, 28 Oct 2021 15:15:27 -0700
Message-Id: <20211028221528.2174284-1-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In account_guest_time in kernel/sched/cputime.c guest time is
attributed to both CPUTIME_NICE and CPUTIME_USER in addition to
CPUTIME_GUEST_NICE and CPUTIME_GUEST respectively. Therefore, adding
both to calculate usage results in double counting any guest time at
the rootcg.

Fixes: 936f2a70f207 ("cgroup: add cpu.stat file to root cgroup")
Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
---
 kernel/cgroup/rstat.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index b264ab5652ba..1486768f2318 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -433,8 +433,6 @@ static void root_cgroup_cputime(struct task_cputime *cputime)
 		cputime->sum_exec_runtime += user;
 		cputime->sum_exec_runtime += sys;
 		cputime->sum_exec_runtime += cpustat[CPUTIME_STEAL];
-		cputime->sum_exec_runtime += cpustat[CPUTIME_GUEST];
-		cputime->sum_exec_runtime += cpustat[CPUTIME_GUEST_NICE];
 	}
 }
 
-- 
2.30.2

