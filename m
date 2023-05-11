Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8E66FE991
	for <lists+cgroups@lfdr.de>; Thu, 11 May 2023 03:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbjEKBru (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 May 2023 21:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjEKBrt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 May 2023 21:47:49 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4775B89;
        Wed, 10 May 2023 18:47:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QGvsq6x6Nz4f3jYF;
        Thu, 11 May 2023 09:47:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP2 (Coremail) with SMTP id Syh0CgA33eo_SVxkrgJdJA--.7260S4;
        Thu, 11 May 2023 09:47:45 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next 0/6] blk-wbt: minor fix and cleanup
Date:   Thu, 11 May 2023 09:45:03 +0800
Message-Id: <20230511014509.679482-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA33eo_SVxkrgJdJA--.7260S4
X-Coremail-Antispam: 1UD129KBjvdXoWrCryrCF1rXr4xtF48JF47Jwb_yoWxWFb_JF
        WUJFWkXFn8Xan3CF98CF1DXFWUKr4rZr4UZF1vg3y5tr13Jw1DKws5Jr4rZrW3ZF4IkF98
        XF15Gr4xXr48tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
        XdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Yu Kuai (6):
  blk-wbt: fix that wbt can't be disabled by default
  blk-wbt: don't create wbt sysfs entry if CONFIG_BLK_WBT is disabled
  blk-wbt: don't enable wbt for bio based device
  blk-wbt: remove deadcode to handle wbt enable/disable with io inflight
  blk-wbt: cleanup rwb_enabled() and wbt_disabled()
  blk-iocost: move wbt_enable/disable_default() out of spinlock

 block/blk-iocost.c |   7 ++-
 block/blk-sysfs.c  | 147 ++++++++++++++++++++++++---------------------
 block/blk-wbt.c    |  26 ++------
 block/blk-wbt.h    |  19 ------
 4 files changed, 88 insertions(+), 111 deletions(-)

-- 
2.39.2

