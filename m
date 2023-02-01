Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABFE68671A
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 14:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjBANld (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 08:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjBANlc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 08:41:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4B645F6A;
        Wed,  1 Feb 2023 05:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VWwPZdmK4rNkY5M0ChzWfV9yf3Jd1QwvNFbGSddgKhc=; b=10zii5TNG0st7Zv65RkwkFDyLA
        PvTSbbH2UzbvL/0RbqzGV/vc1PTIXLHGhBAASJcB6M4XYwk+FMDQ2FCivm8QHuXC1GFVnNASyM94Q
        h4Lbv6U+nAVwDmft8Lna+PZ2RHm9e2H38/fYVtEExy/r4dGfNzbQo6CN6rwzPX/r5ZJdi0lL3HGXS
        k9kVdJHVwFi8CpuHNDtZKmqgwPP7KAFopIpTfoH9QIyWPkXNXQTAFmE5SH9fSNYVoqFi1sbV9gjQb
        wF45qa8Mw8+NMLqpEGyOZg3QefwA86EfC4ZKvUtD9wuvuVqdZwaV00j8iWIJGlI4vI7WEbsDTaZk/
        LtDVNjXw==;
Received: from [2001:4bb8:19a:272a:3635:31c6:c223:d428] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNDMf-00C7Rq-07; Wed, 01 Feb 2023 13:41:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: [PATCH 01/19] block: don't call blk_throtl_stat_add for non-READ/WRITE commands
Date:   Wed,  1 Feb 2023 14:41:05 +0100
Message-Id: <20230201134123.2656505-2-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230201134123.2656505-1-hch@lst.de>
References: <20230201134123.2656505-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

blk_throtl_stat_add is called from blk_stat_add explicitly, unlike the
other stats that go through q->stats->callbacks.  To prepare for cgroup
data moving to the gendisk, ensure blk_throtl_stat_add is only called
for the plain READ and WRITE commands that it actually handles internally,
as blk_stat_add can also be called for passthrough commands on queues that
do not have a gendisk associated with them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
---
 block/blk-stat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-stat.c b/block/blk-stat.c
index 2ea01b5c1aca04..c6ca16abf911e2 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -58,7 +58,8 @@ void blk_stat_add(struct request *rq, u64 now)
 
 	value = (now >= rq->io_start_time_ns) ? now - rq->io_start_time_ns : 0;
 
-	blk_throtl_stat_add(rq, value);
+	if (req_op(rq) == REQ_OP_READ || req_op(rq) == REQ_OP_WRITE)
+		blk_throtl_stat_add(rq, value);
 
 	rcu_read_lock();
 	cpu = get_cpu();
-- 
2.39.0

