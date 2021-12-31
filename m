Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364E44821B4
	for <lists+cgroups@lfdr.de>; Fri, 31 Dec 2021 04:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242571AbhLaDMd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Dec 2021 22:12:33 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:29311 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbhLaDMb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Dec 2021 22:12:31 -0500
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JQ9Cz1c46zbjjc;
        Fri, 31 Dec 2021 11:11:59 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 31 Dec 2021 11:12:29 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 31 Dec
 2021 11:12:28 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <tj@kernel.org>, <axboe@kernel.dk>,
        <paolo.valente@linaro.org>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v2 0/3] block, bfq: minor cleanup and fix
Date:   Fri, 31 Dec 2021 11:23:51 +0800
Message-ID: <20211231032354.793092-1-yukuai3@huawei.com>
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

