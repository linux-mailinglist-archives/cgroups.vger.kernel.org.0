Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EEC464A9B
	for <lists+cgroups@lfdr.de>; Wed,  1 Dec 2021 10:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348239AbhLAJbb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Dec 2021 04:31:31 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32863 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348241AbhLAJbb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Dec 2021 04:31:31 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J3tzj2snpzcbfQ;
        Wed,  1 Dec 2021 17:28:01 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 17:28:08 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 1 Dec
 2021 17:28:07 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <hch@infradead.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v3 0/2] cancel all throttled bios in del_gendisk()
Date:   Wed, 1 Dec 2021 17:40:12 +0800
Message-ID: <20211201094014.330165-1-yukuai3@huawei.com>
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

Yu Kuai (2):
  blk-throtl: move WARN_ON_ONCE() from throtl_rb_first() to it's caller
  block: cancel all throttled bios in del_gendisk()

 block/blk-throttle.c | 77 ++++++++++++++++++++++++++++++++++++++++++--
 block/blk-throttle.h |  2 ++
 block/genhd.c        |  2 ++
 3 files changed, 78 insertions(+), 3 deletions(-)

-- 
2.31.1

