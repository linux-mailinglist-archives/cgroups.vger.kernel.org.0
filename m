Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A169A432BCE
	for <lists+cgroups@lfdr.de>; Tue, 19 Oct 2021 04:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhJSCbV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Oct 2021 22:31:21 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:25230 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhJSCbS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Oct 2021 22:31:18 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HYHhk57vhz8tlt;
        Tue, 19 Oct 2021 10:27:50 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Tue, 19 Oct 2021 10:28:56 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Tue, 19
 Oct 2021 10:28:56 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <avanzini.arianna@gmail.com>, <fchecconi@gmail.com>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v3 -next 0/2] blk-cgroup: synchoronize blkg creation against policy deactivation
Date:   Tue, 19 Oct 2021 10:41:30 +0800
Message-ID: <20211019024132.432458-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Changes in V3:
 - grab q_usage_counter in blkg_conf_prep() instead of introducing a
 new mutex.

Changes in V2:
 - rename the patch title
 - instead of checking policy in blkg_create(), using a new solution.

Yu Kuai (2):
  blk-cgroup: don't call blk_mq_freeze_queue() in
    blkcg_deactivate_policy()
  blk-cgroup: synchoronize blkg creation against policy deactivation

 block/blk-cgroup.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

-- 
2.31.1

