Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECF34C3A63
	for <lists+cgroups@lfdr.de>; Fri, 25 Feb 2022 01:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiBYAfP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Feb 2022 19:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbiBYAfO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Feb 2022 19:35:14 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0C6279440
        for <cgroups@vger.kernel.org>; Thu, 24 Feb 2022 16:34:43 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id c6so5176056edk.12
        for <cgroups@vger.kernel.org>; Thu, 24 Feb 2022 16:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uV4wBUWA2UECsFZTXgl5VjPgFRRqp+MEQd9SNZm1H5k=;
        b=a6Vnlb+DXvatZ1kODfxsl4neHMsRZDeRD7PR3nUDh+j1AyWLtpam8eSKeAKpB7+2tx
         K283KMzgr1d7YmT6BpKMBWNBjK/AbqGXSgoAYFd1XPSC5QzRDch5RhpeI+EvMXFCv/ht
         H67m6Oj03Z7rnpxO2scQmQ5AC/DV8lEKCT4T1Qr1/HenZEtC4hkFTZKMfZDWhpgZ70LM
         T0+ZcMd3F2C/ZFIaJlh5+4tpwfGoFPG12Yh/MWAh4c9HxdVrCLDhyI5qKcBfSlXXPijP
         PzKY2w+OfX5pLMziBPbIevhlkHMHG6QNplCeS1qXYwpH4LR8aZwiKXwG8iGtIdB+JC6a
         0JzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uV4wBUWA2UECsFZTXgl5VjPgFRRqp+MEQd9SNZm1H5k=;
        b=C0hTigh9Nyn2/mlUXt3LnF1zUVhnNDK5iPmPFfIReFfzYPmJFKz5on7ZsZQv9QNKIP
         GeUOBoiLuabpZrkYzGEv9HYRqZmxEz0lYFfJTLi7S1KZ3ZVfC/9t076PFMkDOU4GgQNV
         qVa2R6MkyHod06oxDkPtEAxLS6dpHxekKL+UA2i8XNJQi97te8VmJo/3E99OzSRZyt0k
         bREmAV96j9Sut7Y/pj+AGlMSFauSZGkxJV+DuvuuCBJmRZy3wmOAR3hxxsghnvdwG4Yx
         YXMRNzyg1FjWVKec7pMOBOK91NJsv8tcm5ucfENdUhg0Bsi94IiYpNaZxZ5gtNRBV3Hx
         +PsA==
X-Gm-Message-State: AOAM530AgICIjlGBCucT+tx3K/Hcbj2CHWxZCdLk5m/G53mRo6mZOCH3
        vimK55yPIoHGI2Ye4WsAJdI=
X-Google-Smtp-Source: ABdhPJyt8lkUIMqItrJ/qgRwB3FiJ3nB/EIBnPDeJ8equOOsrEMp4CSPfOLuDO1HxBd3h70Q0HCSRg==
X-Received: by 2002:a05:6402:1d54:b0:410:f02d:4765 with SMTP id dz20-20020a0564021d5400b00410f02d4765mr4719468edb.28.1645749281926;
        Thu, 24 Feb 2022 16:34:41 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id r11-20020aa7cfcb000000b00412c58c43ccsm528200edy.37.2022.02.24.16.34.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Feb 2022 16:34:41 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 2/3] mm/memcg: set pos to prev unconditionally
Date:   Fri, 25 Feb 2022 00:34:36 +0000
Message-Id: <20220225003437.12620-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220225003437.12620-1-richard.weiyang@gmail.com>
References: <20220225003437.12620-1-richard.weiyang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Current code set pos to prev based on condition (prev && !reclaim),
while we can do this unconditionally.

Since:

  * If !reclaim, pos is the same as prev no matter it is NULL or not.
  * If reclaim, pos would be set properly from iter->position.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/memcontrol.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9464fe2aa329..03399146168f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -980,7 +980,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 	struct mem_cgroup_reclaim_iter *iter;
 	struct cgroup_subsys_state *css = NULL;
 	struct mem_cgroup *memcg = NULL;
-	struct mem_cgroup *pos = NULL;
+	struct mem_cgroup *pos = prev;
 
 	if (mem_cgroup_disabled())
 		return NULL;
@@ -988,9 +988,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 	if (!root)
 		root = root_mem_cgroup;
 
-	if (prev && !reclaim)
-		pos = prev;
-
 	rcu_read_lock();
 
 	if (reclaim) {
-- 
2.33.1

