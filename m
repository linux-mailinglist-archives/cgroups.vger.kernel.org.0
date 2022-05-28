Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D387C536C0F
	for <lists+cgroups@lfdr.de>; Sat, 28 May 2022 11:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbiE1Jqd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 28 May 2022 05:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiE1Jqb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 28 May 2022 05:46:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A331E65A0;
        Sat, 28 May 2022 02:46:30 -0700 (PDT)
Received: from kwepemi500018.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L9Gxc2jf7zjX54;
        Sat, 28 May 2022 17:45:24 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500018.china.huawei.com (7.221.188.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 28 May 2022 17:46:28 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 28 May
 2022 17:46:27 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>, <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v3 0/6] multiple cleanup patches for bfq
Date:   Sat, 28 May 2022 17:59:52 +0800
Message-ID: <20220528095958.270455-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Resend just in case v2 end up in spam (for Paolo).

Changes in v2:
 - add missing blank line in patch 1.
 - remove patch 7,8, since they are wrong.
 - add reviewed-by tag

There are no functional changes in this patchset, just some places
that I think can be improved during code review.

Previous version:
v1: https://lore.kernel.org/all/20220514090522.1669270-1-yukuai3@huawei.com/

Yu Kuai (6):
  block, bfq: cleanup bfq_weights_tree add/remove apis
  block, bfq: cleanup __bfq_weights_tree_remove()
  block, bfq: factor out code to update 'active_entities'
  block, bfq: don't declare 'bfqd' as type 'void *' in bfq_group
  block, bfq: cleanup bfq_activate_requeue_entity()
  block, bfq: remove dead code for updating 'rq_in_driver'

 block/bfq-cgroup.c  |  2 +-
 block/bfq-iosched.c | 38 +++----------------
 block/bfq-iosched.h | 11 ++----
 block/bfq-wf2q.c    | 91 ++++++++++++++++++++-------------------------
 4 files changed, 51 insertions(+), 91 deletions(-)

-- 
2.31.1

