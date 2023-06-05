Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540DD7226D0
	for <lists+cgroups@lfdr.de>; Mon,  5 Jun 2023 15:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjFENFR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Jun 2023 09:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbjFENE5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Jun 2023 09:04:57 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52D1CD;
        Mon,  5 Jun 2023 06:04:56 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-655d1fc8ad8so827507b3a.1;
        Mon, 05 Jun 2023 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685970296; x=1688562296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PwnioUR0ZjoyRGzrp5k5mjXo7WPIskiZGVP9H/Ozl1w=;
        b=ikWXlcNmcjTchboSGAIljatHvSG1Z4LVpxBFkZ9O1es07NKSLDjhDfsLYrkfj8J8re
         JLiOzSxDdNlnBMcKLYmB/eFroD/t8DpaSJZLaNskfnHACkfLND8sljVzpqiA3FtKk8Hf
         bl3rK/ew+hxR6lwA9ZX/w9ulk67kwP7kJZ0katk94Gpvw76pFfAoi7r6QuYK/3QqFFbD
         +TQ5MtVRhCOp47VRQeNhtXolsiEpyYmSczhBNeDAZh5T7LjPM1S21GZa9GtZRTVMjgeP
         5WdqyznmnMtecDf/2/bMpuU9NUZKDFS1F1MIqN/S9qCaEkUnd/7tViMEV3qLUiR6vk4R
         49KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685970296; x=1688562296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PwnioUR0ZjoyRGzrp5k5mjXo7WPIskiZGVP9H/Ozl1w=;
        b=dQ2XCtinI+BmghI4xuYbqxXoa9naxvG7fvHyGG9A1dy9wM1Rx6Q8t/pxmdPWYGqPMH
         L0GYwjSBlxewz9kMSZ+CF2bbhWTfWKhGQSU5WdtpppHlT9PVj5vOwVPmPpjBW29Wq7Y8
         vXRQv+P0rrHUFm2o/kA7/qIGJ9mlKAeGEjqTOUg6T5939JQR9HYnEhHYfKrQ4D/8D0nR
         fs3wimI5XO0GAfN0Ak7We36ugnWYI05w35KlTz2br7Tz7xvc4SDoMU8QAQjnXkGn3MtL
         eLySoN2Znt9h13TWLGiyhZtyhSErsj0AZZr3xKNgZNoOP48O8YOcnEAXQEhZvkJvLepN
         HWQw==
X-Gm-Message-State: AC+VfDy3PQXncpcpxmaH5kaXut3IfGw6NPa8SRsoZxPXur3udoE5WtiO
        El+AZdjgKw8aEnfKy8zl6Gh1rfkZVhiepA==
X-Google-Smtp-Source: ACHHUZ7miuHK34uaTVj6DOG0mrTSKpA9i8bxkHFhaSRxgIqRpgqzRZ/Rou6isPLiTMK58927DUHTOQ==
X-Received: by 2002:a05:6a20:1587:b0:115:e834:7bc1 with SMTP id h7-20020a056a20158700b00115e8347bc1mr1427573pzj.30.1685970295850;
        Mon, 05 Jun 2023 06:04:55 -0700 (PDT)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id j2-20020aa78d02000000b0065ebeb9bb23sm302300pfe.149.2023.06.05.06.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 06:04:54 -0700 (PDT)
From:   Zou Cao <zoucaox@gmail.com>
X-Google-Original-From: Zou Cao <zoucao@kuaishou.com>
To:     linux-kernel@vger.kernel.org, tj@kernel.org
Cc:     cgroups@vger.kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, brauner@kernel.org,
        Zou Cao <zoucao@kuaishou.com>
Subject: [PATCH] cgroup: fixed the cset refcnt leak when fork() failed
Date:   Mon,  5 Jun 2023 21:04:44 +0800
Message-Id: <20230605130444.1421-1-zoucao@kuaishou.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

TeamID: B1486294

when fork, cset will be increased by commit "ef2c41cf38a7", the refcnt will
be decrease by child exit, but when failed in fork(), this refcnt will
be lost decrease in cgroup_cancel_fork as follow:

copy_process
     |
cgroup_can_fork    //  increase the css refcount
  ......
  spin_lock_irq(&css_set_lock);
  cset = task_css_setcurrent);
  get_css_set(cset);
  spin_unlock_irq&css_set_lock);
  ......
     |
goto cgroup_cancel_fork    // if failed in  copy_process
     |
cgroup_cancel_fork  // lost the decrease refcount if flag not CLONE_INTO_CGROUP

Fixes: ef2c41cf38a7 ("clone3: allow spawning processes into cgroups")
Signed-off-by: Zou Cao <zoucao@kuaishou.com>
---
 kernel/cgroup/cgroup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index d18c2ef..5ecd706 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6284,6 +6284,11 @@ void cgroup_cancel_fork(struct task_struct *child,
 		if (ss->cancel_fork)
 			ss->cancel_fork(child, kargs->cset);
 
+	if (!(kargs->flags & CLONE_INTO_CGROUP) &&
+			kargs->cset) {
+		put_css_set(kargs->cset);
+	}
+
 	cgroup_css_set_put_fork(kargs);
 }
 
-- 
1.8.3.1

