Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0C1779DE4
	for <lists+cgroups@lfdr.de>; Sat, 12 Aug 2023 09:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjHLHV0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 12 Aug 2023 03:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHLHVY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 12 Aug 2023 03:21:24 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFF49C;
        Sat, 12 Aug 2023 00:21:24 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b9cf1997c4so2509678a34.3;
        Sat, 12 Aug 2023 00:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691824884; x=1692429684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IEENV70+bdbkoZdaUV5XqhM/23tTitj6To+lYwver7M=;
        b=o7GwMmBzt4k4OkA91irOXoOtbUDgvM2iz+y5d7B6/5HN74c1sjPuZ6uZJQa3Ce+sc7
         vGTTqxblgVyVBvKDBfMPjt8Exmr1eHtAb8vexkXuORyuHK/BOil+XQUl7R7uhPIzFQQj
         OQbd/KCOE/okri3p5POGhiZwk0my/2A5dfjbz8T4qb8D+6IwPItdM9J1s7AkKdjxymSd
         IOx/678dJNyXnwZnxzdeahovq7hwmyCqCDj0BFvrhqWnZj8ZL9Fhv2idMpVuXAPp78H0
         BTSXV3rRqQSWLUwzzkdRwYJD40P/f/4licOGWFA2z9WeIrpAOZ2yiaOLM6UMIzuvEN6V
         dXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691824884; x=1692429684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IEENV70+bdbkoZdaUV5XqhM/23tTitj6To+lYwver7M=;
        b=kJqeFwTgAOlkCAoJX/wGbQHr9J4vi1ZzJe0uCG0RPZec1jrrtIgQb+RNs38kfEqL77
         yrjC8vsS9cR6Ce7Jjul1hcfBPt4c04RXw/ewMXIZD1KlSJ532ZKNd2pQn2bN2ZUG1QFg
         p7oZ3GPZ82Au8WgqKhe7XPleOBDG6AeUh/Y51R2Z324FJIeKfsgAVl2GszSSd7leR8N9
         lM8FXsFxoAOCDPRdAtT9sZ2oabuEQIE1wQwvWO/CKckH+5urI+/x8DQ8AQy+0y2AvIyh
         HohFt6Dk4EEuLhMAIquaXvH4wzcmJNjygWtpU8Y5FtlX2/SLJqebn7MxgZGnvV0xsPKN
         afaA==
X-Gm-Message-State: AOJu0Yzu122veFTY+KJPxAqQyIH4aJSUcNex2WgN0Q8iXgkDy9tsRmAb
        WHtFANEaNLE7Giu0qTg1pBg=
X-Google-Smtp-Source: AGHT+IFG7p9TE3X3rIEFB70uFATNJGmL2bU2k9WiS033dEXIJJVhKb4LFIjniIFD6IFDn/3RcMEJ/g==
X-Received: by 2002:a9d:7d90:0:b0:6bc:da49:676c with SMTP id j16-20020a9d7d90000000b006bcda49676cmr4234990otn.24.1691824883752;
        Sat, 12 Aug 2023 00:21:23 -0700 (PDT)
Received: from MacBook-Pro.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id q22-20020a62ae16000000b006687b4f2044sm4356649pff.164.2023.08.12.00.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 00:21:23 -0700 (PDT)
From:   zhuxiaohui <zhuxiaohui400@gmail.com>
X-Google-Original-From: zhuxiaohui <zhuxiaohui.400@bytedance.com>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, zhuxiaohui <zhuxiaohui.400@bytedance.com>
Subject: [PATCH 1/1] blk-throttle: fix throttle configuring not effective
Date:   Sat, 12 Aug 2023 15:21:16 +0800
Message-ID: <20230812072116.42321-1-zhuxiaohui.400@bytedance.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

when updating block throttle limit with persistence and stable io
pressure, especially a relative high io pressure, fio test e.g.,
there may never be a change to start a new slice, and carryover_ios &
carryover_bytes will not be cleared.

As a result, when reconfiguring block throttle limit, we can notice that
the actual iops and throughput is a random value far away from what is
set

So we need to update carryover value when dispatching bio

Signed-off-by: zhuxiaohui <zhuxiaohui.400@bytedance.com>
---
 block/blk-throttle.c | 26 ++++++++++++++++++++++++++
 block/blk-throttle.h |  4 ++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 7397ff199d66..13c9d87a7201 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -821,6 +821,30 @@ static void tg_update_carryover(struct throtl_grp *tg)
 		   tg->carryover_ios[READ], tg->carryover_ios[WRITE]);
 }
 
+static void tg_charge_carryover(struct throtl_grp *tg, struct bio *bio)
+{
+	bool rw = bio_data_dir(bio);
+
+	if (unlikely(tg->carryover_bytes[rw])) {
+		unsigned int bio_size = throtl_bio_data_size(bio);
+		unsigned int carryout_size = abs(tg->carryover_bytes[rw]);
+
+		carryout_size = min(carryout_size, bio_size);
+
+		if (tg->carryover_bytes[rw] < 0)
+			tg->carryover_bytes[rw] += carryout_size;
+		else
+			tg->carryover_bytes[rw] -= carryout_size;
+	}
+
+	if (unlikely(tg->carryover_ios[rw])) {
+		if (tg->carryover_ios[rw] < 0)
+			tg->carryover_ios[rw] += 1;
+		else
+			tg->carryover_ios[rw] -= 1;
+	}
+}
+
 static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio,
 				 u32 iops_limit)
 {
@@ -965,6 +989,8 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
 
 	tg->io_disp[rw]++;
 	tg->last_io_disp[rw]++;
+
+	tg_charge_carryover(tg, bio);
 }
 
 /**
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index d1ccbfe9f797..8f1642becb23 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -127,8 +127,8 @@ struct throtl_grp {
 	 * bytes/ios are waited already in previous configuration, and they will
 	 * be used to calculate wait time under new configuration.
 	 */
-	uint64_t carryover_bytes[2];
-	unsigned int carryover_ios[2];
+	int64_t carryover_bytes[2];
+	int carryover_ios[2];
 
 	unsigned long last_check_time;
 
-- 
2.39.2

