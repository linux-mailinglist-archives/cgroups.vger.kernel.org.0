Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473DA6134D2
	for <lists+cgroups@lfdr.de>; Mon, 31 Oct 2022 12:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiJaLp5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Oct 2022 07:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiJaLpk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Oct 2022 07:45:40 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD1CF023;
        Mon, 31 Oct 2022 04:45:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AE1A0CE134C;
        Mon, 31 Oct 2022 11:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09213C433D6;
        Mon, 31 Oct 2022 11:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667216723;
        bh=/nzQwQ7t8fEd/Xbji8T5TlBeyziGmIQJxHg8N9W/ml4=;
        h=From:To:Cc:Subject:Date:From;
        b=di1R1BCGvDv5KIfYWJ/0WhYLVQzNM99ivj4PXRekT4VkQArg598dXS6df8fUPt/qy
         PL7JlHCF5TrQNlt3ISUO9gHqjDWWpnPw59eVNi+FnE3fdzrdJwgelZYr/afK5L3XED
         1pzWTJ7nkI2/uAXIJxOcL0Dav5rcI9YuEo0A+RLi4JgST/jFmnjJP01UiUjrVDVT+P
         mVRYq+GU/7y1c+/YSLmuUlnkBzD0IB9LQH5DMOAhzOis2HHkm43zRFeUMhdJMxH5ST
         yhcLFqhAA7VpSOeTeuObjthPMQHzBdvW3rwzZFb8ml+x7C9qatEeJXaez50ykda6cH
         q+lcUjCfNPo/g==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     tj@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Martin Liska <mliska@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH] block/blk-iocost (gcc13): cast enum members to int in prints
Date:   Mon, 31 Oct 2022 12:45:20 +0100
Message-Id: <20221031114520.10518-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since gcc13, each member of an enum has the same type as the enum [1]. And
that is inherited from its members. Provided:
  VTIME_PER_SEC_SHIFT     = 37,
  VTIME_PER_SEC           = 1LLU << VTIME_PER_SEC_SHIFT,
the named type is unsigned long.

This generates warnings with gcc-13:
  block/blk-iocost.c: In function 'ioc_weight_prfill':
  block/blk-iocost.c:3037:37: error: format '%u' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int'

  block/blk-iocost.c: In function 'ioc_weight_show':
  block/blk-iocost.c:3047:34: error: format '%u' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int'

Cast the enum members to int when printing them.

Alternatively, we can cast them to ulong (to silence gcc < 12) and use %lu.
Alternatively, we can move VTIME_PER_SEC away from the enum.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=36113

Cc: Martin Liska <mliska@suse.cz>
Cc: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: cgroups@vger.kernel.org
Cc: linux-block@vger.kernel.org
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 block/blk-iocost.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index f01359906c83..a257ba17183b 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3034,7 +3034,8 @@ static u64 ioc_weight_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 	struct ioc_gq *iocg = pd_to_iocg(pd);
 
 	if (dname && iocg->cfg_weight)
-		seq_printf(sf, "%s %u\n", dname, iocg->cfg_weight / WEIGHT_ONE);
+		seq_printf(sf, "%s %d\n", dname,
+				iocg->cfg_weight / (int)WEIGHT_ONE);
 	return 0;
 }
 
@@ -3044,7 +3045,8 @@ static int ioc_weight_show(struct seq_file *sf, void *v)
 	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
 	struct ioc_cgrp *iocc = blkcg_to_iocc(blkcg);
 
-	seq_printf(sf, "default %u\n", iocc->dfl_weight / WEIGHT_ONE);
+	seq_printf(sf, "default %d\n",
+			iocc->dfl_weight / (int)WEIGHT_ONE);
 	blkcg_print_blkgs(sf, blkcg, ioc_weight_prfill,
 			  &blkcg_policy_iocost, seq_cft(sf)->private, false);
 	return 0;
-- 
2.38.1

