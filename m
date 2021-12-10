Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2768146FC8D
	for <lists+cgroups@lfdr.de>; Fri, 10 Dec 2021 09:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238416AbhLJIX0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Dec 2021 03:23:26 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16357 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238389AbhLJIX0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Dec 2021 03:23:26 -0500
Received: from kwepemi100005.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J9P254Sqlz93L6;
        Fri, 10 Dec 2021 16:19:09 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100005.china.huawei.com (7.221.188.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 16:19:49 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 10 Dec
 2021 16:19:48 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <mkoutny@suse.com>, <hch@infradead.org>,
        <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v5 0/2] cancel all throttled bios in del_gendisk()
Date:   Fri, 10 Dec 2021 16:31:41 +0800
Message-ID: <20211210083143.3181535-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Yu Kuai (2):
  blk-throtl: move WARN_ON_ONCE() from throtl_rb_first() to it's caller
  block: cancel all throttled bios in del_gendisk()

 block/blk-throttle.c | 75 ++++++++++++++++++++++++++++++++++++++++++--
 block/blk-throttle.h |  2 ++
 block/genhd.c        |  2 ++
 3 files changed, 76 insertions(+), 3 deletions(-)

-- 
2.31.1

