Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA5C508013
	for <lists+cgroups@lfdr.de>; Wed, 20 Apr 2022 06:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356186AbiDTEav (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Apr 2022 00:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355273AbiDTEat (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Apr 2022 00:30:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3972DE0;
        Tue, 19 Apr 2022 21:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=N20iLcUnxfvG1HpPozYt/60ZT2Vdv9e3jRTpgUOWF1w=; b=XJbf2V2lCOuuEltwK6+sDCYN2p
        /hOxAg7hw6fT03id8ADUEk6yQyzR5c5wqUFwkwnf8cSGrWeEP0/SOa+lMJt3eSbSEh0f1vxPV+IKk
        DrfBjlKr6kP3FH0I+0c4nr85fisZoLjNIyZunnnBoFKL8btiPs+aufbY1iZgy5sxAlhIFyCRw1lOc
        t5oSEdRvbzQXqJVPyD+5SZWIqwFeWrq+KEU+9AkA4vAgDA8naNcDBWQyt3NW8se3h1bIoi1IN/6p3
        StnBXXBUn9lLQBOP2085O3heS0HC/p2n0gLPqsbPcyQgPz/khzHtQ/MMOc93igBxrGKS7eMQku64c
        WQRrmIrA==;
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh1wf-007FXK-8A; Wed, 20 Apr 2022 04:28:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Tejun Heo <tj@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 11/15] blk-cgroup: remove unneeded includes from <linux/blk-cgroup.h>
Date:   Wed, 20 Apr 2022 06:27:19 +0200
Message-Id: <20220420042723.1010598-12-hch@lst.de>
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

Remove all the includes that aren't actually needed from
<linux/blk-cgroup.h> and push them to the actual source files where
needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.h         |  2 ++
 include/linux/blk-cgroup.h | 15 +++++----------
 mm/backing-dev.c           |  1 +
 mm/readahead.c             |  1 +
 mm/swapfile.c              |  1 +
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index a948f4eb0bff8..62ed8ed50b6e3 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -15,6 +15,8 @@
  */
 
 #include <linux/blk-cgroup.h>
+#include <linux/cgroup.h>
+#include <linux/kthread.h>
 #include <linux/blk-mq.h>
 
 struct blkcg_gq;
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index abbfa97d6d46f..9f40dbc65f82c 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -14,16 +14,11 @@
  * 	              Nauman Rafique <nauman@google.com>
  */
 
-#include <linux/cgroup.h>
-#include <linux/percpu.h>
-#include <linux/percpu_counter.h>
-#include <linux/u64_stats_sync.h>
-#include <linux/seq_file.h>
-#include <linux/radix-tree.h>
-#include <linux/blkdev.h>
-#include <linux/atomic.h>
-#include <linux/kthread.h>
-#include <linux/fs.h>
+#include <linux/types.h>
+
+struct bio;
+struct cgroup_subsys_state;
+struct request_queue;
 
 #define FC_APPID_LEN              129
 
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 98f8f62e52ca5..ff60bd7d74e07 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/blkdev.h>
 #include <linux/wait.h>
 #include <linux/rbtree.h>
 #include <linux/kthread.h>
diff --git a/mm/readahead.c b/mm/readahead.c
index 8e3775829513e..c93671a2bf0f7 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -113,6 +113,7 @@
  * ->readpage() which may be less efficient.
  */
 
+#include <linux/blkdev.h>
 #include <linux/kernel.h>
 #include <linux/dax.h>
 #include <linux/gfp.h>
diff --git a/mm/swapfile.c b/mm/swapfile.c
index a2b31fea0c42e..981a6e85c88e7 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -6,6 +6,7 @@
  *  Swap reorganised 29.12.95, Stephen Tweedie
  */
 
+#include <linux/blkdev.h>
 #include <linux/mm.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
-- 
2.30.2

