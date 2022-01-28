Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8FC49F52C
	for <lists+cgroups@lfdr.de>; Fri, 28 Jan 2022 09:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347326AbiA1Iei (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jan 2022 03:34:38 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:32128 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347325AbiA1Iei (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jan 2022 03:34:38 -0500
Received: from kwepemi100013.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JlVzr53VXz8wcq;
        Fri, 28 Jan 2022 16:31:36 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100013.china.huawei.com (7.221.188.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 16:34:35 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 28 Jan
 2022 16:34:35 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <ming.lei@redhat.com>, <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v7 0/2] cancel all throttled bios in del_gendisk()
Date:   Fri, 28 Jan 2022 16:45:20 +0800
Message-ID: <20220128084522.3169961-1-yukuai3@huawei.com>
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

Changes in v7:
 - use the new solution as suggested by Ming.

Yu Kuai (2):
  blk-throtl: introduce a new flag THROTL_TG_CANCELING
  block: cancel all throttled bios in del_gendisk()

 block/blk-throttle.c | 49 ++++++++++++++++++++++++++++++++++++++++----
 block/blk-throttle.h |  2 ++
 block/genhd.c        |  2 ++
 3 files changed, 49 insertions(+), 4 deletions(-)

-- 
2.31.1

