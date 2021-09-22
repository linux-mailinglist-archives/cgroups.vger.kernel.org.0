Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5A441492D
	for <lists+cgroups@lfdr.de>; Wed, 22 Sep 2021 14:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbhIVMnM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Sep 2021 08:43:12 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:16228 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbhIVMnM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Sep 2021 08:43:12 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HDyZ646Cwz1DH82;
        Wed, 22 Sep 2021 20:40:30 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 22 Sep 2021 20:41:40 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Wed, 22
 Sep 2021 20:41:39 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 0/4] cancel all throttled bios in blk_cleanup_queue()
Date:   Wed, 22 Sep 2021 20:51:11 +0800
Message-ID: <20210922125115.381752-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If blk_cleanup_queue() is called when some io are still throttled,
such io will not be handled until the throttle is done, which is not
necessary because the queue is already dying.

This patch series handle such in blk_cleanup_queue().

Yu Kuai (4):
  Revert "blk-throttle: remove tg_drain_bios"
  blk-throtl: don't warn in tg_drain_bios()
  blk-throtl: introduce blk_throtl_cancel_bios()
  block: cancel all throttled bios in blk_cleanup_queue()

 block/blk-core.c     |  3 ++
 block/blk-throttle.c | 70 +++++++++++++++++++++++++++++++++++++++++---
 block/blk.h          |  2 ++
 3 files changed, 71 insertions(+), 4 deletions(-)

-- 
2.31.1

