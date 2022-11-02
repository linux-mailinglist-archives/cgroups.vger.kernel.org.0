Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11E36161EF
	for <lists+cgroups@lfdr.de>; Wed,  2 Nov 2022 12:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiKBLok (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Nov 2022 07:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiKBLob (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Nov 2022 07:44:31 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA400286FA;
        Wed,  2 Nov 2022 04:44:28 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id p3so16313161pld.10;
        Wed, 02 Nov 2022 04:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTeNkRAzXSEVLoL3Lhip7sQ1RKcNrqLgbC54eCLx1tw=;
        b=HDp9lWuenSozaRzjerT1H0dZlQhufG/Pzy+6qbGUuQROkQ8ydTkNedBSkovOwbR2Qo
         cb4AOFtQs3G5G27oFv8KLihh9/LjmdELUsdNSXD8x51ZYESdNoSvnWerP5ifneF2Angs
         DUUx6R8MUL788RpABcGiGAWTwq6SY7IwizGMNnrRGHqPRpXBqV2G2SFvE9oezxAwF2MW
         0PToDCekpr574VXcUiycmuX6caumO8BZ9E4pnLjkFEJu1+3dWtkPyhYDIablEcZU75sW
         53xi29g1iBbjJjUBi8vTccGJxC/tTfOpRVWmXV/x3jTzC/UyVFkPsfCoVeSvjaje9sGh
         NeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTeNkRAzXSEVLoL3Lhip7sQ1RKcNrqLgbC54eCLx1tw=;
        b=yDEm74Z2W0mun7sHoRn4uXam6QkBceM2F2If0jBCSlHhbzR3XjOJOYop+d17pJ6Wk1
         JMoNAYsN8acb9/J0HIRH6ipICLeb6kP5k1TDFQNQ8Fif4D9aSAgllwXfFJvsoB60U0rl
         UdXtQtcmUV2zE1zP2ba+MmX5jrmzoJxvT7MA3CKnU/LTzU4IvzHMFeNARAdUU2eljwJg
         Igq4YWhWbrYICvXN/rXXys4htZKcAbEcPy6rXgf0XWK9zif8UvqoSgwMvT+OFMnO8uef
         NbtcX1t528eZE/uREboAgva+FgTDIuxJqk1IfpobIAGXBDt8P6WinIzJk6/h/BKnr25K
         JQOw==
X-Gm-Message-State: ACrzQf3ojEJlS5D8wEKEKuhuSdDrrbw4IObKcxVuD8j6ubjz1hbGsTVj
        PfOjP56tSxRNrzcdt2WhSoA=
X-Google-Smtp-Source: AMsMyM5RkCwt5CxI4t4m7DqzSAgVMK5xL1W8zRs5CMeSCUTjpkusJgdhTJVBKjV0f47XIdRkKg/dag==
X-Received: by 2002:a17:902:db12:b0:187:4736:f780 with SMTP id m18-20020a170902db1200b001874736f780mr3026987plx.145.1667389468355;
        Wed, 02 Nov 2022 04:44:28 -0700 (PDT)
Received: from Zbook.localdomain ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b00172e19c5f8bsm8169978plh.168.2022.11.02.04.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 04:44:27 -0700 (PDT)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org,
        josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
Subject: [PATCH 4/5] block, bfq: change type for "prio_changed"
Date:   Wed,  2 Nov 2022 19:43:53 +0800
Message-Id: <20221102114354.162-5-Yuwei.Guan@zeekrlife.com>
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

"bool" type is more suitable for "prio_changed",
so change it from int to bool.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 block/bfq-cgroup.c  |  2 +-
 block/bfq-iosched.c | 20 ++++++++++----------
 block/bfq-iosched.h |  2 +-
 block/bfq-wf2q.c    |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 144bca006463..0eaa709995a9 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1056,7 +1056,7 @@ static void bfq_group_set_weight(struct bfq_group *bfqg, u64 weight, u64 dev_wei
 		 * seen in that code.
 		 */
 		smp_wmb();
-		bfqg->entity.prio_changed = 1;
+		bfqg->entity.prio_changed = true;
 	}
 }
 
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 74b87694105f..48fdad88aa48 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1211,7 +1211,7 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 	}
 
 	/* make sure weight will be updated, however we got here */
-	bfqq->entity.prio_changed = 1;
+	bfqq->entity.prio_changed = true;
 
 	if (likely(!busy))
 		return;
@@ -1917,7 +1917,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 							 soft_rt);
 
 			if (old_wr_coeff != bfqq->wr_coeff)
-				bfqq->entity.prio_changed = 1;
+				bfqq->entity.prio_changed = true;
 		}
 	}
 
@@ -2315,7 +2315,7 @@ static void bfq_add_request(struct request *rq)
 			bfqq->wr_cur_max_time = bfq_wr_duration(bfqd);
 
 			bfqd->wr_busy_queues++;
-			bfqq->entity.prio_changed = 1;
+			bfqq->entity.prio_changed = true;
 		}
 		if (prev != bfqq->next_rq)
 			bfq_updated_next_req(bfqd, bfqq);
@@ -2634,7 +2634,7 @@ static void bfq_bfqq_end_wr(struct bfq_queue *bfqq)
 	 * Trigger a weight change on the next invocation of
 	 * __bfq_entity_update_weight_prio.
 	 */
-	bfqq->entity.prio_changed = 1;
+	bfqq->entity.prio_changed = true;
 }
 
 void bfq_end_wr_async_queues(struct bfq_data *bfqd,
@@ -3154,12 +3154,12 @@ bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
 			bfqq->wr_start_at_switch_to_srt;
 		if (bfq_bfqq_busy(new_bfqq))
 			bfqd->wr_busy_queues++;
-		new_bfqq->entity.prio_changed = 1;
+		new_bfqq->entity.prio_changed = true;
 	}
 
 	if (bfqq->wr_coeff > 1) { /* bfqq has given its wr to new_bfqq */
 		bfqq->wr_coeff = 1;
-		bfqq->entity.prio_changed = 1;
+		bfqq->entity.prio_changed = true;
 		if (bfq_bfqq_busy(bfqq))
 			bfqd->wr_busy_queues--;
 	}
@@ -4987,7 +4987,7 @@ static void bfq_update_wr_data(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 				  * interactive weight raising
 				  */
 				switch_back_to_interactive_wr(bfqq, bfqd);
-				bfqq->entity.prio_changed = 1;
+				bfqq->entity.prio_changed = true;
 			}
 		}
 		if (bfqq->wr_coeff > 1 &&
@@ -5457,7 +5457,7 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
 	bfqq->entity.new_weight = bfq_ioprio_to_weight(bfqq->new_ioprio);
 	bfq_log_bfqq(bfqd, bfqq, "new_ioprio %d new_weight %d",
 		     bfqq->new_ioprio, bfqq->entity.new_weight);
-	bfqq->entity.prio_changed = 1;
+	bfqq->entity.prio_changed = true;
 }
 
 static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
@@ -5831,7 +5831,7 @@ bfq_update_io_seektime(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			  * raising
 			  */
 			switch_back_to_interactive_wr(bfqq, bfqd);
-			bfqq->entity.prio_changed = 1;
+			bfqq->entity.prio_changed = true;
 		}
 	}
 }
@@ -7099,7 +7099,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	 * oom_bfqq's first activation. The oom_bfqq's ioprio and ioprio
 	 * class won't be changed any more.
 	 */
-	bfqd->oom_bfqq.entity.prio_changed = 1;
+	bfqd->oom_bfqq.entity.prio_changed = true;
 
 	bfqd->queue = q;
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 256a9d267204..b022e5ec0871 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -195,7 +195,7 @@ struct bfq_entity {
 	struct bfq_sched_data *sched_data;
 
 	/* flag, set to request a weight, ioprio or ioprio_class change  */
-	int prio_changed;
+	bool prio_changed;
 
 	/* flag, set if the entity is counted in groups_with_pending_reqs */
 	bool in_groups_with_pending_reqs;
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 3da08f4be633..d9cef0f68d5a 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -751,7 +751,7 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 		 * is not pending any longer.
 		 */
 		if (!bfqq || bfqq->ioprio_class == bfqq->new_ioprio_class)
-			entity->prio_changed = 0;
+			entity->prio_changed = false;
 
 		/*
 		 * NOTE: here we may be changing the weight too early,
-- 
2.34.1

