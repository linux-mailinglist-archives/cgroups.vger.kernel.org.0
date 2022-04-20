Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CBC50801A
	for <lists+cgroups@lfdr.de>; Wed, 20 Apr 2022 06:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356943AbiDTEa5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Apr 2022 00:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245608AbiDTEa5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Apr 2022 00:30:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231DF2DE0;
        Tue, 19 Apr 2022 21:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xmlR5HUFOAI8yqQFKY2MjEXGwXGx785pMDVfAqM57ow=; b=LMiuO+Sz6pZtEd/3zHUKL+74hk
        RpDt274l1HCMYrW1VFhdZfv9C/v4MJmcABLxfjJSnH1xD1FymXQDAiM1XRKJ0bfzpPnyq6JA7vTsJ
        U6ighNPhZ6WMln3DZRgZGB8IrKD8jsHv7+Zcz+q/n0qQb8Qln1SRuvSUhu8rnPRAO4NkoUS+IYw5E
        UpWlcjxj53dat92wmf8kUZLE+5nDicqZ1JW7ngiAfEgWoQyG34+GlzY5iwkasD8PrBCyhI7EY/6c5
        UV72fx2cclo9+GXOvxhux5g04dBiY3tCpN9Axb2GlbCQepBEpSDQCvzIUQQJTy26JU9m0aKkIi0li
        OvH2sV+w==;
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh1wo-007FfR-41; Wed, 20 Apr 2022 04:28:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Tejun Heo <tj@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 14/15] blk-cgroup: cleanup blkcg_maybe_throttle_current
Date:   Wed, 20 Apr 2022 06:27:22 +0200
Message-Id: <20220420042723.1010598-15-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220420042723.1010598-1-hch@lst.de>
References: <20220420042723.1010598-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Use blkcg_css instead of opencoding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 5684a8ce1f755..a91f8ae18b49b 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1808,7 +1808,6 @@ static void blkcg_maybe_throttle_blkg(struct blkcg_gq *blkg, bool use_memdelay)
 void blkcg_maybe_throttle_current(void)
 {
 	struct request_queue *q = current->throttle_queue;
-	struct cgroup_subsys_state *css;
 	struct blkcg *blkcg;
 	struct blkcg_gq *blkg;
 	bool use_memdelay = current->use_memdelay;
@@ -1820,12 +1819,7 @@ void blkcg_maybe_throttle_current(void)
 	current->use_memdelay = false;
 
 	rcu_read_lock();
-	css = kthread_blkcg();
-	if (css)
-		blkcg = css_to_blkcg(css);
-	else
-		blkcg = css_to_blkcg(task_css(current, io_cgrp_id));
-
+	blkcg = css_to_blkcg(blkcg_css());
 	if (!blkcg)
 		goto out;
 	blkg = blkg_lookup(blkcg, q);
-- 
2.30.2

