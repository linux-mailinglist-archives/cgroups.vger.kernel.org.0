Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D5445FDE6
	for <lists+cgroups@lfdr.de>; Sat, 27 Nov 2021 11:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353903AbhK0KEh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Nov 2021 05:04:37 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:27305 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353889AbhK0KCh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Nov 2021 05:02:37 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J1Rsd2703zbj7m;
        Sat, 27 Nov 2021 17:59:17 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 27 Nov 2021 17:59:21 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Sat, 27 Nov
 2021 17:59:20 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH RFC 0/9] support concurrent sync io for bfq on a specail occasion
Date:   Sat, 27 Nov 2021 18:11:23 +0800
Message-ID: <20211127101132.486806-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Bfq can't handle sync io concurrently as long as the io are not issued
from root group currently.

Previous patch set:
https://lore.kernel.org/lkml/20211014014556.3597008-2-yukuai3@huawei.com/t/

During implemting the method mentioned by the above patch set, I found
more problems that will block implemting concurrent sync io. The
modifications of this patch set are as follows:

1) count root group into 'num_groups_with_pending_reqs';
2) don't idle if 'num_groups_with_pending_reqs' is 1;
3) If the group doesn't have pending requests while it's child groups
have pending requests, don't count the group.
4) Once the group doesn't have pending requests, decrease
'num_groups_with_pending_reqs' immediately. Don't delay to when all
it's child groups don't have pending requests.

Noted that I just tested basic functionality of this patchset, and I
think it's better to see if anyone have suggestions or better
solutions.

Yu Kuai (9):
  block, bfq: add new apis to iterate bfq entities
  block, bfq: apply news apis where root group is not expected
  block, bfq: handle the case when for_each_entity() access root group
  block, bfq: count root group into 'num_groups_with_pending_reqs'
  block, bfq: do not idle if only one cgroup is activated
  block, bfq: only count group that the bfq_queue belongs to
  block, bfq: record how many queues have pending requests in bfq_group
  block, bfq: move forward __bfq_weights_tree_remove()
  block, bfq: decrease 'num_groups_with_pending_reqs' earlier

 block/bfq-cgroup.c  |  3 +-
 block/bfq-iosched.c | 92 +++++++++++++++++++++++----------------------
 block/bfq-iosched.h | 41 +++++++++++++-------
 block/bfq-wf2q.c    | 44 +++++++++++++++-------
 4 files changed, 106 insertions(+), 74 deletions(-)

-- 
2.31.1

