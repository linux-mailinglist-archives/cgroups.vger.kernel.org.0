Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E787AA9B1
	for <lists+cgroups@lfdr.de>; Fri, 22 Sep 2023 09:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjIVHFy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 03:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjIVHFw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 03:05:52 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC595195
        for <cgroups@vger.kernel.org>; Fri, 22 Sep 2023 00:05:46 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3adf115ba79so1170568b6e.3
        for <cgroups@vger.kernel.org>; Fri, 22 Sep 2023 00:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1695366346; x=1695971146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XVblwGEZgzzMamuC2lPhj14gVXLYTQn0EwcGLXw/zVI=;
        b=Yi3IgC1J4m1C1Iaz12L0Qr/sEJYpVFT7xpKLE/VYVUXL7BIzQ4AAfW8GK8ivNTU++L
         fISQcvxWPyVVy2J7XsL8bFQu/gHRdVNyt1hmKSn+3OBGzUMOoe4+zUoVtKuz2IS/8tmb
         JFA+RMSRsDqSNxR3BcZdVzqLeu8iUhmr2kOzUsOIiUZc6wwwsu3oM2VEqx4FiR6w/L/Z
         nInXOAoZztjSv1UmyyMHiqf0t4U4hMuUjPk51jbTsLM3yw534hqv2OEiZy2myh5YvIcv
         p/J8P/gELrybiQmttcV04RxQ+Ns1LRcwlbsBWoSUG+fJ2I2czj+DDyUFJufmqB5Jkhr8
         E3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695366346; x=1695971146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVblwGEZgzzMamuC2lPhj14gVXLYTQn0EwcGLXw/zVI=;
        b=KOekaujAYwf5x9gsUoRmVwWpc55g/YFRYrraqflF+BTVoWi3iqgbAjfNsjL6hVOTOY
         6XcmBkaW2BNMqK3BXJZAAMMhrkjYfUatM+vmm/giuLb8CWZkD2w6kzbhdq8Lsv+U1CAq
         AZLvG+GsUPj5TH3ljfpqHnGXMPGHMSoCSADAyYl5A8Ge66/nwVrRfGOUruZfC4nnmxD1
         e9SacJ6DjowTP1urRSq9bi3n2nA6+rrEMQS1iZ2fxGoFuIt9d0hSWzUM2dsUhJM2XbLe
         wkn+U6rgnccIZ2OksxuYzD9EQ/IDlUUZ/jXeW9v+U6K/95kPC6sN3c5ncAQ7rLeP5w/P
         K+Zw==
X-Gm-Message-State: AOJu0YytLpFfm/UtQ54rD3WwKgyfBeF7vqGoFrV7ZIQoKNwuqJARpJ/u
        WfZRCOBF7A5/EUYmlTeJDioS+QZe6pSmMc6RX76qKQ==
X-Google-Smtp-Source: AGHT+IH9MSQlxPTmkRds3kblO6QJzbPrCLMsYiY6pIkK+VRtBVthOwW96tHki/2mFPqvo3VMINXFNQ==
X-Received: by 2002:a05:6808:1b23:b0:3a7:73e0:d18f with SMTP id bx35-20020a0568081b2300b003a773e0d18fmr9552660oib.14.1695366346098;
        Fri, 22 Sep 2023 00:05:46 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id k17-20020a637b51000000b0056b27af8715sm2443723pgn.43.2023.09.22.00.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 00:05:45 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     mhocko@kernel.org
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH 2/2] memcg, oom: do not wake up memcg_oom_waitq if waitqueue is empty
Date:   Fri, 22 Sep 2023 07:05:29 +0000
Message-Id: <20230922070529.362202-2-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Only when memcg oom killer is disabled, the task which triggers memecg
oom handling will sleep on a waitqueue. Except this case, the waitqueue
is empty though under_oom is true. There is no need to step into wake
up path when resolve the oom situation. So add a check that whether the
waitqueue is empty.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0b6ed63504ca..2bb98ff5be3d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1918,7 +1918,7 @@ static void memcg_oom_recover(struct mem_cgroup *memcg)
 	 * achieved by invoking mem_cgroup_mark_under_oom() before
 	 * triggering notification.
 	 */
-	if (memcg && memcg->under_oom)
+	if (memcg && memcg->under_oom && !list_empty(&memcg_oom_waitq.head))
 		__wake_up(&memcg_oom_waitq, TASK_NORMAL, 0, memcg);
 }
 
-- 
2.25.1

