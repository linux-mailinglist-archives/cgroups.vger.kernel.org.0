Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D9D489A16
	for <lists+cgroups@lfdr.de>; Mon, 10 Jan 2022 14:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbiAJNhT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jan 2022 08:37:19 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:34893 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbiAJNgt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jan 2022 08:36:49 -0500
Received: from kwepemi100006.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JXZbY2W4vzccTZ;
        Mon, 10 Jan 2022 21:36:09 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100006.china.huawei.com (7.221.188.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 21:36:47 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 10 Jan
 2022 21:36:46 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <mkoutny@suse.com>, <paulmck@kernel.org>, <tj@kernel.org>,
        <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v6 0/2] cancel all throttled bios in del_gendisk()
Date:   Mon, 10 Jan 2022 21:47:56 +0800
Message-ID: <20220110134758.2233758-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If del_gendisk() is done when some io are still throttled, such io
will not be handled until the throttle is done, which is not
necessary.

Changes in v2:
 - move WARN_ON_ONCE() from throtl_rb_first() to it's caller
 - merge some patches into one.

Changes in v3:
 - some code optimization in patch 1
 - hold queue lock to cancel bios in patch 2

Changes in v4:
 - delete rcu_read_lock() and rcu_read_unlock() in patch 2

Changes in v5:
 - add comment about rcu lock

Changes in v6:
 - revert to include rcu lock with some comments.

Jagan Teki (1):
  ARM: dts: stm32: Enable LVDS panel on i.Core STM32MP1 EDIMM2.2

Yu Kuai (1):
  blk-throtl: move WARN_ON_ONCE() from throtl_rb_first() to it's caller

Yu Kuai (2):
  blk-throtl: move WARN_ON_ONCE() from throtl_rb_first() to it's caller
  block: cancel all throttled bios in del_gendisk()

 block/blk-throttle.c | 82 ++++++++++++++++++++++++++++++++++++++++++--
 block/blk-throttle.h |  2 ++
 block/genhd.c        |  2 ++
 3 files changed, 83 insertions(+), 3 deletions(-)

-- 
2.31.1

