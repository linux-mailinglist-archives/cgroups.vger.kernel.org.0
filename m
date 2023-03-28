Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C3C6CC3E3
	for <lists+cgroups@lfdr.de>; Tue, 28 Mar 2023 16:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjC1O6M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 10:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbjC1O6H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 10:58:07 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4842FD538
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 07:58:06 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so15376032pjp.1
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 07:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680015486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bq/FNHJyM6VL3GySeYH7whuNpSDOXfegBXORfrv0Wd0=;
        b=gjeUX9N/SZSVreSCgBBOw1Qw3SvaO9BulRKZFa9FyzIBnTyw04c02sekVQEgIM9rIX
         GBYeifm4ppvE4m2nrikaPAj3YSUKwne5xcZwXa1x08/SUo8pKH0jL/9uaE0YzjjJKWH5
         +IQ6UpCaQ0skcosDMsJ6DB9E/8AOPxqejhYko3LGCE/xwRl9jjGZFBWSzf7CHMnJW7Sn
         5ZvdrLMWzlSBrb1U6z1yXAtrL6G20+j5YfRsafiry3WpHRYLRKQnP/LZ1oBdlo9O0Xhm
         +eJLgX+JpPVZA045FloYbVpJecxawrYj1IP83C+8SMNjRfLs8X67VdNeK+gbWJkd6eu3
         qngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680015486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bq/FNHJyM6VL3GySeYH7whuNpSDOXfegBXORfrv0Wd0=;
        b=SMih3Ro7sYjKOKM53JwzwRS8Cj9XMBNN7FhS6N1hu5TIM1k2kwjpXZKimBX+JCNidG
         KNWS1YAkRKJ8VJIqXPsWdR97BhgIYQ19lifpWDDqDTVR+L0Z6UL/f6oFOC0BxEcq6SWV
         5QCFfGJRgvovOlTTbeZ/RTquYyILaHjB54r4zX6HNy06avOEoB3YadplEDO6Tndbhv+g
         jUeH3xJG924Pnk9O4LuvsV8EKmsh9yHEwJ0cQUKA5gQ/YVLvYsbVorqMRYjW+YN6h2Pi
         5db1M8HNVW6PUp7pBxuRcM7yK2nPEmSdwmV8ZvDivULN/pFQqgu89vgm6j27CfchMFJs
         xURg==
X-Gm-Message-State: AAQBX9eD1BslQR10MFGK2ryWuYdIeiYw62faunvP+SVidU4w7S91P8S9
        Wr+YJQtfhYHebsFuhj0Ru5Y9PA==
X-Google-Smtp-Source: AKy350bsOMKykidZMTfGdRua7QdjJGu0JUcqyIYnK51VJ3/7o6PSqWLvzcEq7eErON9tTEHI22gg3Q==
X-Received: by 2002:a17:90a:10d7:b0:234:f77:d6d2 with SMTP id b23-20020a17090a10d700b002340f77d6d2mr17046206pje.45.1680015485946;
        Tue, 28 Mar 2023 07:58:05 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e6d:5da0:f469:aa9c:494f:b32f])
        by smtp.gmail.com with ESMTPSA id nk13-20020a17090b194d00b0023b3179f0fcsm6382250pjb.6.2023.03.28.07.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:58:05 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org,
        josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 4/4] blk-cgroup: change BLKCG_MAX_POLS back to 5
Date:   Tue, 28 Mar 2023 22:57:01 +0800
Message-Id: <20230328145701.33699-4-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230328145701.33699-1-zhouchengming@bytedance.com>
References: <20230328145701.33699-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

BLKCG_MAX_POLS is changed from 5 to 6 when mq-deadline-cgroup introduced,
then commit 0f7839955114 ("Revert "block/mq-deadline: Add cgroup support"")
reverted it. So change BLKCG_MAX_POLS back to 5.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 941304f17492..398f288bcf30 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -54,7 +54,7 @@ extern struct class block_class;
  * Maximum number of blkcg policies allowed to be registered concurrently.
  * Defined here to simplify include dependency.
  */
-#define BLKCG_MAX_POLS		6
+#define BLKCG_MAX_POLS		5
 
 #define DISK_MAX_PARTS			256
 #define DISK_NAME_LEN			32
-- 
2.39.2

