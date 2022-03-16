Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604A74DB021
	for <lists+cgroups@lfdr.de>; Wed, 16 Mar 2022 13:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344222AbiCPMyt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Mar 2022 08:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354040AbiCPMys (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Mar 2022 08:54:48 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF8BAE57;
        Wed, 16 Mar 2022 05:53:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V7Mec2u_1647435209;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V7Mec2u_1647435209)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Mar 2022 20:53:30 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     paolo.valente@linaro.org
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] block: Add parameter description in kernel-doc comment
Date:   Wed, 16 Mar 2022 20:53:27 +0800
Message-Id: <20220316125327.126996-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add the description of @ioprio_class in bfq_reparent_leaf_entity()
and bfq_reparent_active_queues() kernel-doc comment to remove
warning found by running scripts/kernel-doc, which is caused by
using 'make W=1'.

block/bfq-cgroup.c:848: warning: Function parameter or member
'ioprio_class' not described in 'bfq_reparent_leaf_entity'
block/bfq-cgroup.c:878: warning: Function parameter or member
'ioprio_class' not described in 'bfq_reparent_active_queues'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 block/bfq-cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 420eda2589c0..af92c2e5fd98 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -841,6 +841,7 @@ static void bfq_flush_idle_tree(struct bfq_service_tree *st)
  * @bfqd: the device data structure with the root group.
  * @entity: the entity to move, if entity is a leaf; or the parent entity
  *	    of an active leaf entity to move, if entity is not a leaf.
+ * @ioprio_class: the offset used to manipulate the service_tree
  */
 static void bfq_reparent_leaf_entity(struct bfq_data *bfqd,
 				     struct bfq_entity *entity,
@@ -870,6 +871,7 @@ static void bfq_reparent_leaf_entity(struct bfq_data *bfqd,
  * @bfqd: the device data structure with the root group.
  * @bfqg: the group to move from.
  * @st: the service tree to start the search from.
+ * @ioprio_class: the offset used to manipulate the service_tree
  */
 static void bfq_reparent_active_queues(struct bfq_data *bfqd,
 				       struct bfq_group *bfqg,
-- 
2.20.1.7.g153144c

