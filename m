Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86420671C6C
	for <lists+cgroups@lfdr.de>; Wed, 18 Jan 2023 13:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjARMp3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Jan 2023 07:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjARMnX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Jan 2023 07:43:23 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF55210A83;
        Wed, 18 Jan 2023 04:07:40 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NxkzB6RLTz4f3m7B;
        Wed, 18 Jan 2023 20:07:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCHgR8G4cdjY2MdBw--.48220S4;
        Wed, 18 Jan 2023 20:07:36 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     tj@kernel.org, hch@lst.de, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next v2 0/3] blk-cgroup: make sure pd_free_fn() is called in order
Date:   Wed, 18 Jan 2023 20:31:49 +0800
Message-Id: <20230118123152.1926314-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCHgR8G4cdjY2MdBw--.48220S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKFyfKF4DGryfAr1xuw1DGFg_yoWkXFgEka
        4vgryrC34UA3W2kF92krn0vFZ8KrWjqr18XayqqrWxWF17Xw4xtan3K34ruF47ua109r15
        Jasavrs2qrnFqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoO
        J5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

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

 block/blk-cgroup.c     | 61 +++++++++++++++++++++++++++++++-----------
 block/blk-cgroup.h     |  1 +
 include/linux/blkdev.h |  1 +
 3 files changed, 48 insertions(+), 15 deletions(-)

-- 
2.31.1

