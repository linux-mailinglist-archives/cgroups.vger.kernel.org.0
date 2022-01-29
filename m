Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DCC4A2B0D
	for <lists+cgroups@lfdr.de>; Sat, 29 Jan 2022 02:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352079AbiA2Bsl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jan 2022 20:48:41 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:31252 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344830AbiA2Bsl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jan 2022 20:48:41 -0500
Received: from kwepemi100007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JlxzQ5y4wzbkCP;
        Sat, 29 Jan 2022 09:47:46 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100007.china.huawei.com (7.221.188.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 29 Jan 2022 09:48:39 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 29 Jan
 2022 09:48:38 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <paolo.valente@linaro.org>, <jack@suse.cz>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v3 0/3] block, bfq: minor cleanup and fix
Date:   Sat, 29 Jan 2022 09:59:21 +0800
Message-ID: <20220129015924.3958918-1-yukuai3@huawei.com>
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

Changes in v3:
 - fix a clerical error in patch 2

Chagnes in v2:
 - add comment in patch 2
 - remove patch 4, since the problem do not exist.

Yu Kuai (3):
  block, bfq: cleanup bfq_bfqq_to_bfqg()
  block, bfq: avoid moving bfqq to it's parent bfqg
  block, bfq: don't move oom_bfqq

 block/bfq-cgroup.c  | 16 +++++++++++++++-
 block/bfq-iosched.c |  4 ++--
 block/bfq-iosched.h |  1 -
 block/bfq-wf2q.c    | 15 ---------------
 4 files changed, 17 insertions(+), 19 deletions(-)

-- 
2.31.1

