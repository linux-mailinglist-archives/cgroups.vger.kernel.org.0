Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D090615738
	for <lists+cgroups@lfdr.de>; Wed,  2 Nov 2022 03:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiKBCEE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Nov 2022 22:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKBCED (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Nov 2022 22:04:03 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1950A11477;
        Tue,  1 Nov 2022 19:04:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N299J70l0zKG3f;
        Wed,  2 Nov 2022 10:01:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgCnP9QN0GFjGqzfBA--.48110S4;
        Wed, 02 Nov 2022 10:03:59 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     jack@suse.cz, axboe@kernel.dk, paolo.valente@linaro.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH -next v4 0/5] multiple cleanup patches for bfqd
Date:   Wed,  2 Nov 2022 10:25:37 +0800
Message-Id: <20221102022542.3621219-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgCnP9QN0GFjGqzfBA--.48110S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKry3Gw15CFW7CF48uw45ZFb_yoW3KFg_Xa
        s7AFWfCFnrC3W5Ca48AF15Aay0k3yrXw1DKF98trZxJr17tF4jy347tr4xXan0qan7Ga4Y
        yr1Yvr4fJr1jqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Changes in v4:
 - move first two patches from v3 into another thread.
 - add patch 1

Changes in v3:
 - resend v2 with new mail address

Changes in v2:
 - add missing blank line in patch 1.
 - remove patch 7,8, since they are wrong.
 - add reviewed-by tag

Yu Kuai (5):
  block, bfq: remove set but not used variable in
    __bfq_entity_update_weight_prio
  block, bfq: factor out code to update 'active_entities'
  block, bfq: cleanup bfq_activate_requeue_entity()
  block, bfq: remove dead code for updating 'rq_in_driver'
  block, bfq: don't declare 'bfqd' as type 'void *' in bfq_group

 block/bfq-cgroup.c  |  2 +-
 block/bfq-iosched.c | 16 ---------
 block/bfq-iosched.h |  2 +-
 block/bfq-wf2q.c    | 88 ++++++++++++++++++---------------------------
 4 files changed, 37 insertions(+), 71 deletions(-)

-- 
2.31.1

