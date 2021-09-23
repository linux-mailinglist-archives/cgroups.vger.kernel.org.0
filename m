Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154D141600D
	for <lists+cgroups@lfdr.de>; Thu, 23 Sep 2021 15:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241395AbhIWNiZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Sep 2021 09:38:25 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16287 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbhIWNiY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Sep 2021 09:38:24 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HFblm5qwHz8tKq;
        Thu, 23 Sep 2021 21:36:04 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Thu, 23 Sep 2021 21:36:50 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 23
 Sep 2021 21:36:50 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 0/6] fix uaf in rq_qos_done_io()
Date:   Thu, 23 Sep 2021 21:46:25 +0800
Message-ID: <20210923134631.105719-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch set tries to fix the uaf when bio_endio() is called from
error path and is concurrent with blk_cleanup_queue().

Yu Kuai (6):
  rq-qos: introduce rq_qos_free()
  blk-wbt: introduce wbt_free()
  io-cost: introduce ioc_rqos_free()
  blk-iolatency: splict blkcg_iolatency_free() from
    blkcg_iolatency_exit()
  blk-ioprio: introduce blkcg_ioprio_free()
  rq-qos: fix uaf in rq_qos_done_io()

 block/blk-iocost.c    |  7 +++++++
 block/blk-iolatency.c |  7 +++++++
 block/blk-ioprio.c    |  7 ++++++-
 block/blk-rq-qos.c    | 12 +++++++++++-
 block/blk-rq-qos.h    |  2 ++
 block/blk-sysfs.c     |  1 +
 block/blk-wbt.c       |  7 +++++++
 7 files changed, 41 insertions(+), 2 deletions(-)

-- 
2.31.1

