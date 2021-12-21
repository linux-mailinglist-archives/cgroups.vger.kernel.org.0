Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B110D47B8D5
	for <lists+cgroups@lfdr.de>; Tue, 21 Dec 2021 04:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbhLUDJ7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Dec 2021 22:09:59 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15953 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhLUDJ7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Dec 2021 22:09:59 -0500
Received: from kwepemi500010.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JJ1Zd2qqNzZdkd;
        Tue, 21 Dec 2021 11:06:49 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500010.china.huawei.com (7.221.188.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 11:09:56 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 21 Dec
 2021 11:09:55 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <jack@suse.cz>, <fchecconi@gmail.com>, <avanzini.arianna@gmail.com>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 0/4] block, bfq: minor cleanup and fix
Date:   Tue, 21 Dec 2021 11:21:31 +0800
Message-ID: <20211221032135.878550-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Yu Kuai (4):
  block, bfq: cleanup bfq_bfqq_to_bfqg()
  block, bfq: avoid moving bfqq to it's parent bfqg
  block, bfq: don't move oom_bfqq
  block, bfq: update pos_root for idle bfq_queue in bfq_bfqq_move()

 block/bfq-cgroup.c  | 25 ++++++++++++++++++++-----
 block/bfq-iosched.c |  4 ++--
 block/bfq-iosched.h |  1 -
 block/bfq-wf2q.c    | 15 ---------------
 4 files changed, 22 insertions(+), 23 deletions(-)

-- 
2.31.1

