Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACA1530BC3
	for <lists+cgroups@lfdr.de>; Mon, 23 May 2022 11:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiEWINC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 23 May 2022 04:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiEWINB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 23 May 2022 04:13:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40805A475;
        Mon, 23 May 2022 01:12:59 -0700 (PDT)
Received: from kwepemi100009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L696842p5zjX1W;
        Mon, 23 May 2022 16:12:00 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100009.china.huawei.com (7.221.188.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 16:12:57 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 16:12:56 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <mkoutny@suse.com>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v4 0/4] bugfix for blk-throttle
Date:   Mon, 23 May 2022 16:26:29 +0800
Message-ID: <20220523082633.2324980-1-yukuai3@huawei.com>
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

Changes in v4:
 - add reviewed-by tag for patch 1
 - add patch 2,3
 - use a different way to fix io hung in patch 4
Changes in v3:
 - fix a check in patch 1
 - fix link err in patch 2 on 32-bit platform
 - handle overflow in patch 2
Changes in v2:
 - use a new solution suggested by Ming
 - change the title of patch 1
 - add patch 2

Patch 1 fix that blk-throttle can't work if multiple bios are throttle,
Patch 2 fix overflow while calculating wait time
Patch 3,4 fix io hung due to configuration updates.

Previous version:
v1: https://lore.kernel.org/all/20220517134909.2910251-1-yukuai3@huawei.com/
v2: https://lore.kernel.org/all/20220518072751.1188163-1-yukuai3@huawei.com/
v3: https://lore.kernel.org/all/20220519085811.879097-1-yukuai3@huawei.com/

Yu Kuai (4):
  blk-throttle: fix that io throttle can only work for single bio
  blk-throttle: prevent overflow while calculating wait time
  blk-throttle: factor out code to calculate ios/bytes_allowed
  blk-throttle: fix io hung due to config updates

 block/blk-throttle.c | 121 ++++++++++++++++++++++++++++++++-----------
 block/blk-throttle.h |   4 ++
 2 files changed, 94 insertions(+), 31 deletions(-)

-- 
2.31.1

