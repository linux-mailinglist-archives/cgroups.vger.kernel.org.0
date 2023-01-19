Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CE46735BE
	for <lists+cgroups@lfdr.de>; Thu, 19 Jan 2023 11:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjASKjr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Jan 2023 05:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjASKjn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Jan 2023 05:39:43 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFB02105;
        Thu, 19 Jan 2023 02:39:41 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NyJzC4dW0z4f41Sv;
        Thu, 19 Jan 2023 18:39:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUyHmHclj45hSBw--.55879S4;
        Thu, 19 Jan 2023 18:39:36 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, hch@lst.de, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next v3 0/3] blk-cgroup: make sure pd_free_fn() is called in order
Date:   Thu, 19 Jan 2023 19:03:47 +0800
Message-Id: <20230119110350.2287325-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUyHmHclj45hSBw--.55879S4
X-Coremail-Antispam: 1UD129KBjvJXoWrur4DtF13tw1rtrWxXr4xWFg_yoW8Jry3pF
        sxK3y5GrsxAFsrAa1aka12qa4Sgw4rJa4jgryft34rCrWqyrykCwn29ws8GFyUAr97GayU
        XrnI9Fyvk34jy37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Changes in v3:
 - add ack tag from Tejun for patch 1,2
 - as suggested by Tejun, update commit message and comments in patch 3

The problem was found in iocost orignally([1]) that ioc can be freed in
ioc_pd_free(). And later we found that there are more problem in
iocost([2]).

After some discussion, as suggested by Tejun([3]), we decide to fix the
problem that parent pd can be freed before child pd in cgroup layer
first. And the problem in [1] will be fixed later if this patchset is
applied.

[1] https://lore.kernel.org/all/20221130132156.2836184-8-linan122@huawei.com/
[2] https://lore.kernel.org/all/aa924294-2f54-1b53-fc6e-e4f8fa019b14@huaweicloud.com/
[3] https://lore.kernel.org/all/20221227125502.541931-1-yukuai1@huaweicloud.com/

Yu Kuai (3):
  blk-cgroup: dropping parent refcount after pd_free_fn() is done
  blk-cgroup: support to track if policy is online
  blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and
    blkcg_deactivate_policy()

 block/blk-cgroup.c     | 63 ++++++++++++++++++++++++++++++++----------
 block/blk-cgroup.h     |  1 +
 include/linux/blkdev.h |  1 +
 3 files changed, 50 insertions(+), 15 deletions(-)

-- 
2.31.1

