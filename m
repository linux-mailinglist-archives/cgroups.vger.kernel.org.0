Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B546161F6
	for <lists+cgroups@lfdr.de>; Wed,  2 Nov 2022 12:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiKBLoZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Nov 2022 07:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiKBLoW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Nov 2022 07:44:22 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FF328701;
        Wed,  2 Nov 2022 04:44:20 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id b62so5634092pgc.0;
        Wed, 02 Nov 2022 04:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OL88kv80oEtPFlhgWDeAL7//i16MAHkHlHkRbfyZx1Q=;
        b=FOPNzZy38c/VAGwXAxbK8HSyAK8zPJuDMlM+oR1AmBZx207mlxlXpuUbYs0Sm6zN0I
         FDZH8eBGDg2obX+2T3dbYTpgJlOqIMFI1y9Sa1Fej4zAOOb5BtprFj/hvqjcCcWcNDLd
         bhE++hmOrDAw8Qhjp26M2xX+pmgpFZ6l4TXVgkM82ov2t6F4nhwSqsU44JSZQulA06Vn
         sg4H9s34WmpH8s2GwyoHGWRBH/yhsbEg55TY6UTHaP6SYgH9tvuyXwUS76+WgwfH87DK
         +NHcjOJrhWFy/oF5nsITm20Hve7ACJzLz1Iw3aj3z0OM7gpgJVAlWpdRmKk7F5PxmGMY
         4Ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OL88kv80oEtPFlhgWDeAL7//i16MAHkHlHkRbfyZx1Q=;
        b=KiXGhjDSqjkaFSaruwAU0jot9Y8ycpIQTmvlXy7LRcN3xT/hOTT5/JioVSAfFLoXJ+
         90edT8FEq1+dMaays3fUlnjEUkjUXAD6yqDo122MTcU/haioNWeYSZc/ns/XzNmBgEjP
         ExQLzo15w0RUn1ZP00bcozNYO0ME29UpUMPLoYzc0sdALSZILN/XYY8UbLpkhYyEeKhl
         peewy2L5TAveIYAI4IMm5xKOSYwlH9Xd20V/AxJ4YZrMNernyfjJM2Ll7XrZQZG/6DBH
         +mmqIksLptjFhB1hEGv43AK2/pX5GYZO9W7SLIiusmukUL4hCEye1NCiI0boL2oaDRob
         8rjw==
X-Gm-Message-State: ACrzQf2mHfJJBt9Oz8Mds5mZYN7yIJLUS7H6fZnHZe2tOjxn91LY4L/C
        xJvmgU9Cc5qSLxz8lmWszhelzwspsJNG7UZg
X-Google-Smtp-Source: AMsMyM4TRsZoI1U0sewXvT9hys4AtWg5QqxRaDxehzu5j5l6Yc8tpizC6U8Jl4zOL2sLILzAu8+3IQ==
X-Received: by 2002:a63:1849:0:b0:43c:8346:57f7 with SMTP id 9-20020a631849000000b0043c834657f7mr21160618pgy.222.1667389460480;
        Wed, 02 Nov 2022 04:44:20 -0700 (PDT)
Received: from Zbook.localdomain ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b00172e19c5f8bsm8169978plh.168.2022.11.02.04.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 04:44:20 -0700 (PDT)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org,
        josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
Subject: [PATCH 2/5] block, bfq: remove unused bfq_log_bfqg
Date:   Wed,  2 Nov 2022 19:43:51 +0800
Message-Id: <20221102114354.162-3-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102114354.162-1-Yuwei.Guan@zeekrlife.com>
References: <20221102114354.162-1-Yuwei.Guan@zeekrlife.com>
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

No callers left of bfq_log_bfqg, so remove it.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 block/bfq-iosched.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 3de849e97e4e..256a9d267204 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -1103,11 +1103,6 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
 			"%s " fmt, pid_str, ##args);			\
 } while (0)
 
-#define bfq_log_bfqg(bfqd, bfqg, fmt, args...)	do {			\
-	blk_add_cgroup_trace_msg((bfqd)->queue,				\
-		&bfqg_to_blkg(bfqg)->blkcg->css, fmt, ##args);		\
-} while (0)
-
 #else /* CONFIG_BFQ_GROUP_IOSCHED */
 
 #define bfq_log_bfqq(bfqd, bfqq, fmt, args...) do {	\
@@ -1117,7 +1112,6 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
 	bfq_bfqq_name((bfqq), pid_str, MAX_BFQQ_NAME_LENGTH);		\
 	blk_add_trace_msg((bfqd)->queue, "%s " fmt, pid_str, ##args);	\
 } while (0)
-#define bfq_log_bfqg(bfqd, bfqg, fmt, args...)		do {} while (0)
 
 #endif /* CONFIG_BFQ_GROUP_IOSCHED */
 
-- 
2.34.1

