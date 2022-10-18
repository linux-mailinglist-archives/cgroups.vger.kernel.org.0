Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47AB6029EA
	for <lists+cgroups@lfdr.de>; Tue, 18 Oct 2022 13:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJRLMu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Oct 2022 07:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJRLMt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Oct 2022 07:12:49 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6CB9AFF0;
        Tue, 18 Oct 2022 04:12:45 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MsB3K18K4zJn2S;
        Tue, 18 Oct 2022 19:10:05 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 19:12:42 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH v2 0/3] A few cleanup patches for blk-iolatency.c
Date:   Tue, 18 Oct 2022 19:12:37 +0800
Message-ID: <20221018111240.22612-1-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This series contains three cleanup patches to remove redundant check,
correct comment and simplify struct iolatency_grp in blk-iolatency.c.

---
v2:
 Thanks Josef for review and comment!
 Add Reviewed-by tag from Josef 
 Improve the corrected comment in patch 2/3
---

Kemeng Shi (3):
  block: Remove redundant parent blkcg_gp check in check_scale_change
  block: Correct comment for scale_cookie_change
  block: Replace struct rq_depth with unsigned int in struct
    iolatency_grp

 block/blk-iolatency.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

-- 
2.30.0

