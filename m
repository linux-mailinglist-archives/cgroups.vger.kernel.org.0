Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24A75BFB33
	for <lists+cgroups@lfdr.de>; Wed, 21 Sep 2022 11:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiIUJmZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Sep 2022 05:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiIUJmY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Sep 2022 05:42:24 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDB78275E;
        Wed, 21 Sep 2022 02:42:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MXYLG6L70z6T2Zg;
        Wed, 21 Sep 2022 17:40:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgA3inN73CpjFoetBA--.3521S4;
        Wed, 21 Sep 2022 17:42:21 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH 0/2] blk-throttle: improve bypassing bios checkings
Date:   Wed, 21 Sep 2022 17:53:07 +0800
Message-Id: <20220921095309.1481289-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA3inN73CpjFoetBA--.3521S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZryfuFWfXFWrZr17ur1ftFb_yoWDJwbE9F
        WxJFW5JwnxX3W8JFW0yF1rXrZIgw4UWrW8Z3Z0vrW7Xrn7Zr1DKFZrJr4aqFy7ZF4kKrn8
        Kr40va18CF1YvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbz8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Currently, "tg->has_rules" and "tg->flags & THROTL_TG_HAS_IOPS_LIMIT"
both try to bypass bios that don't need to be throttled, however, they are
a little redundant and both not perfect:

1) "tg->has_rules" only distinguish read and write, but not iops and bps
   limit.
2) "tg->flags & THROTL_TG_HAS_IOPS_LIMIT" only check if iops limit
   exist, read and write is not distinguished, and bps limit is not
   checked.

With this patchset, biowon't be bypassedd if:

1) Bio is read/write, and corresponding read/write iops limit exist.
2) If corresponding iops limit doesn't exist, corresponding bps limit
exist and bio is not throttled before.

Yu Kuai (2):
  blk-throttle: remove THROTL_TG_HAS_IOPS_LIMIT
  blk-throttle: improve bypassing bios checkings

 block/blk-throttle.c | 21 +++++++--------------
 block/blk-throttle.h | 28 +++++++++++++++++++---------
 2 files changed, 26 insertions(+), 23 deletions(-)

-- 
2.31.1

