Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4590A528C28
	for <lists+cgroups@lfdr.de>; Mon, 16 May 2022 19:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344331AbiEPRjn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 May 2022 13:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344248AbiEPRjm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 May 2022 13:39:42 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B94036B42;
        Mon, 16 May 2022 10:39:41 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id l16so19492027oil.6;
        Mon, 16 May 2022 10:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QlC2UOYMPKKudwLjLWBF40eX+oeG8Yvuxzp6LWYy94=;
        b=lN5q6KoGnMVKq8KOjsovYc0Ea9Rz2wCpQaF48i5eMxFhf3pMQhJODDGAvdMNRqWL2n
         1kuhXkOG7R5wJOM/NAWz7J4UIEiIRaBQzILAI5v2Su+zwhL0GL/t0lZWPP9pPWi9X5w1
         TRmLsarTXjfHK8MzG/jFj58z06sJ6O70HdWHKxHpNJMABQaWzn4ySx0XB977Cqy6L+Ms
         68LQaNkjgqCJaydfqryJPKMsb++N4qxHLOKJWhJR9AvA7TVZ0iSC6ytp/1cGqiViasIS
         jDUUNTS1nVh0xyNxGTDlH8awrM/IWxq4zVYrTKv/Qp1yO7yesfSIN0YJWuUzfIiCwqMP
         08PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QlC2UOYMPKKudwLjLWBF40eX+oeG8Yvuxzp6LWYy94=;
        b=PrrEPO3UnuNlR/bEApMOP3sHY/XbqzTnnXMP3jqLlb1LD31D7cdZHHhseJIMjLs6pj
         iideI1NSAyEWkx2dyf4v0zuh5lCwl7R3/ZMTcR1I01DYKDWfISJT7BNWM1ng3llrcYrH
         93R3ITf79Wdi525htb2D9RYrhx5BsB1ypPg0bC8v2kly1NmpZOiYiR7pdlpqYhTi+3y9
         bD2T/1b1iMWn0VgHlX6Y6mYcBCI2JPz4kcYLDYvUU9fIpYrcMSFxb2GsXMDSbCRFq3JF
         W6N/2+eA6Wy+iUyvP7GX7MgeMcJaUGUAmmk4JwqAbKUIl7+UaJWgLCbB+uvyHAUp1h7B
         mJzQ==
X-Gm-Message-State: AOAM533EBZ0Lq1VQhPu17HpWUaecnvIyrIqqwrtptbnMEf6HydQJ7UTR
        jHt2RQOJrzCEAKjTjIQxB8Y=
X-Google-Smtp-Source: ABdhPJygSNZJhhtbXnU4GGWyPg8tyF+H+RqlJkjIxzimnUGLIq1vRXiWXdwn9GweAfMMT4GBb11GiQ==
X-Received: by 2002:a05:6808:2117:b0:326:4798:88cc with SMTP id r23-20020a056808211700b00326479888ccmr14071383oiw.78.1652722780974;
        Mon, 16 May 2022 10:39:40 -0700 (PDT)
Received: from localhost ([199.180.249.178])
        by smtp.gmail.com with ESMTPSA id o129-20020acabe87000000b003264e122a9asm4002748oif.54.2022.05.16.10.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 10:39:40 -0700 (PDT)
From:   bh1scw@gmail.com
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Fanjun Kong <bh1scw@gmail.com>
Subject: [PATCH] blk-cgroup: Remove unnecessary rcu_read_lock/unlock()
Date:   Tue, 17 May 2022 01:39:30 +0800
Message-Id: <20220516173930.159535-1-bh1scw@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Fanjun Kong <bh1scw@gmail.com>

spin_lock_irq/spin_unlock_irq contains preempt_disable/enable().
Which can serve as RCU read-side critical region, so remove
rcu_read_lock/unlock().

Signed-off-by: Fanjun Kong <bh1scw@gmail.com>
---
 block/blk-cgroup.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index a91f8ae18b49..7bdc16a36560 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1283,14 +1283,13 @@ int blkcg_init_queue(struct request_queue *q)
 	preloaded = !radix_tree_preload(GFP_KERNEL);
 
 	/* Make sure the root blkg exists. */
-	rcu_read_lock();
+	/* spin_lock_irq can serve as RCU read-side critical section. */
 	spin_lock_irq(&q->queue_lock);
 	blkg = blkg_create(&blkcg_root, q, new_blkg);
 	if (IS_ERR(blkg))
 		goto err_unlock;
 	q->root_blkg = blkg;
 	spin_unlock_irq(&q->queue_lock);
-	rcu_read_unlock();
 
 	if (preloaded)
 		radix_tree_preload_end();
@@ -1316,7 +1315,6 @@ int blkcg_init_queue(struct request_queue *q)
 	return ret;
 err_unlock:
 	spin_unlock_irq(&q->queue_lock);
-	rcu_read_unlock();
 	if (preloaded)
 		radix_tree_preload_end();
 	return PTR_ERR(blkg);
-- 
2.36.0

