Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E00D6161F1
	for <lists+cgroups@lfdr.de>; Wed,  2 Nov 2022 12:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiKBLoi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Nov 2022 07:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiKBLo2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Nov 2022 07:44:28 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC33328716;
        Wed,  2 Nov 2022 04:44:24 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id k7so6600473pll.6;
        Wed, 02 Nov 2022 04:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TO3AKUnGTYlpFDHE0inxQ4G6Kp5byNURiimvggoLdA=;
        b=Dfn45f8qMlZMxWk8SdtU4g1j/0dksy4HKNil57zO838ijzFZAvF94pr0JzkIJqBfCE
         xRyWpDyx0dwfOBqGQBnN4T1c1KjR16kBL0CPPaQccxbmDPbREWvCI+XI4fRhGvv7RusC
         F9j2/nqV0l/9FY/LuHNolayQKAOZtO9YGsBPBP5NjJaP7FcQyszh47B80tpIEdxJSqZ/
         sp5vKwNEjQ8ZmoNyX3LEfvcSAyfioYKKnp0aDtbdWjAL7s6Cw9Y7sK8Kx/Q9MPIjhmbM
         ofpi6YBJHwpGYdcd7pccfr1BaG1HjobH03lbzFrTutIYM0d7qUkML8/YrBM+7f5j7AIo
         iPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TO3AKUnGTYlpFDHE0inxQ4G6Kp5byNURiimvggoLdA=;
        b=YZxUg2bDjxPRnWJxZhRDbUp2fGONIPpMiggTlwVJn38QynjGbrlC0fxASN4+ohguCJ
         bS4j+jXBn39xUdfVzcHpJjXhKY5U+bl0ax6a03UKZbU15pBJQaGHtxyAhgL8mWHStDBW
         hTJlwRJe1Q+xycU1zKQkcut5+eJpc5p4cVFlgeJKAD4ruw6UrjYan0Kn8YsgbtG8fcCV
         1LKxqLqGvHN0tonmXL5eoHG/qFEDAAKGWpc+CLQXUTL0oRjFQph0aDMs5A29E59iZelL
         r+csJr9HMY6i27s637vrWOt1T52ZRgM91wOusj/uYdRkuadcXsSlG8rQXwJKcLxfXh7I
         1ZwA==
X-Gm-Message-State: ACrzQf1on3w2AA6QpvhdTOIfI56RpOcG+k5xQs85dsfkvehtWVhUDMzh
        rmTx0pAsrPHpwukJ5vDEsBClWMw3hTRerBup
X-Google-Smtp-Source: AMsMyM6Vhpl383YXRdKXBDbatOJModzSMTkR7qLQrvoINEDGoty8TKOnEKR7Mae5fu6qqJVeG3EBDg==
X-Received: by 2002:a17:90b:1d90:b0:213:d0a2:72ab with SMTP id pf16-20020a17090b1d9000b00213d0a272abmr18587259pjb.221.1667389464293;
        Wed, 02 Nov 2022 04:44:24 -0700 (PDT)
Received: from Zbook.localdomain ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b00172e19c5f8bsm8169978plh.168.2022.11.02.04.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 04:44:23 -0700 (PDT)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org,
        josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
Subject: [PATCH 3/5] block, bfq: remove redundant max_t() in bfq_bfqq_charge_time()
Date:   Wed,  2 Nov 2022 19:43:52 +0800
Message-Id: <20221102114354.162-4-Yuwei.Guan@zeekrlife.com>
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

The "tot_serv_to_charge" is great than or equal to "entity->service",
so no need to do max_t() again.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 block/bfq-wf2q.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 8fc3da4c23bb..3da08f4be633 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -867,8 +867,7 @@ void bfq_bfqq_charge_time(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	if (tot_serv_to_charge > entity->budget)
 		entity->budget = tot_serv_to_charge;
 
-	bfq_bfqq_served(bfqq,
-			max_t(int, 0, tot_serv_to_charge - entity->service));
+	bfq_bfqq_served(bfqq, tot_serv_to_charge - entity->service);
 }
 
 static void bfq_update_fin_time_enqueue(struct bfq_entity *entity,
-- 
2.34.1

