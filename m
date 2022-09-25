Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E1B5E95F8
	for <lists+cgroups@lfdr.de>; Sun, 25 Sep 2022 22:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiIYUnp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Sun, 25 Sep 2022 16:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiIYUnp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 25 Sep 2022 16:43:45 -0400
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED3929809;
        Sun, 25 Sep 2022 13:43:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1664138617; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=CxWPDr+6PpIS9FJN9t3HAJjIlR+WQX9Nl1AV1scnoM7fuzqs3JUF1Ic3T9PS4SWzjWHJ2AMxOuUpw6LwmfvDHyOuJGyLnMCeoifkREeeHj/eiur8mQ3ivh9CsXpNgWMdsro/xT3Ig98VqvUAGotd0skzXJhPmeoKBTPjlQCXZYI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1664138617; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=M1o6VYCEO3rN6tWfxJLUX6T5akpzLESxPs/fQhv9osc=; 
        b=kgkunP2E0KcAEbrnk5Yb93cGfBbgf5NPpDAydDW9FhCA3SXR4v/i+afvsnvlcRhile1775SF3VkbHn8AA/lkApYti/kbZqlKWvvh6xWKmE+B6KqnnYi+OG4rDVexbajG98rdJHh2hfxGtGlHTmx+NaeUPgZJa+CWhsTaszp5CEM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=business@elijahpepe.com;
        dmarc=pass header.from=<business@elijahpepe.com>
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1664138616608189.88288784422514; Sun, 25 Sep 2022 13:43:36 -0700 (PDT)
Date:   Sun, 25 Sep 2022 13:43:36 -0700
From:   Elijah Conners <business@elijahpepe.com>
To:     "axboe" <axboe@kernel.dk>
Cc:     "tj" <tj@kernel.org>, "newella" <newella@fb.com>,
        "linux-block" <linux-block@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "cgroups" <cgroups@vger.kernel.org>
Message-ID: <18376641f12.db248b2f186661.4401757561282192350@elijahpepe.com>
In-Reply-To: 
Subject: [PATCH] blk-iocost: explicitly declare long in seq_printf
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On lines 3038 and 3048, seq_printf() is used with iocg->cfg_weight /
WEIGHT_ONE. This operation is a long, not an unsigned int, so the usage
of %u in this printf() function is unusual. While C will automatically
promote iocg->cfg_weight / WEIGHT_ONE to an unsigned int—and safely—it
is ultimately better to tell seq_printf() that this is a long.

Signed-off-by: Elijah Conners <business@elijahpepe.com>
---
 block/blk-iocost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 7936e5f5821c..78aae116793e 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3035,7 +3035,7 @@ static u64 ioc_weight_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 	struct ioc_gq *iocg = pd_to_iocg(pd);
 
 	if (dname && iocg->cfg_weight)
-		seq_printf(sf, "%s %u\n", dname, iocg->cfg_weight / WEIGHT_ONE);
+		seq_printf(sf, "%s %ld\n", dname, iocg->cfg_weight / WEIGHT_ONE);
 	return 0;
 }
 
@@ -3045,7 +3045,7 @@ static int ioc_weight_show(struct seq_file *sf, void *v)
 	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
 	struct ioc_cgrp *iocc = blkcg_to_iocc(blkcg);
 
-	seq_printf(sf, "default %u\n", iocc->dfl_weight / WEIGHT_ONE);
+	seq_printf(sf, "default %ld\n", iocc->dfl_weight / WEIGHT_ONE);
 	blkcg_print_blkgs(sf, blkcg, ioc_weight_prfill,
 			  &blkcg_policy_iocost, seq_cft(sf)->private, false);
 	return 0;
-- 
2.29.2.windows.2
