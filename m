Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16A31D786B
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2020 14:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgERMWo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 May 2020 08:22:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4812 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726585AbgERMWo (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 18 May 2020 08:22:44 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C07DBD3A8A3B99E9CC35;
        Mon, 18 May 2020 20:22:41 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 18 May 2020
 20:22:33 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <Markus.Elfring@web.de>, <linux-kernel@vger.kernel.org>,
        <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>,
        <wubo40@huawei.com>
Subject: [PATCH] blkcg:Fix memory leaks in blkg_conf_prep()
Date:   Mon, 18 May 2020 20:36:06 +0800
Message-ID: <1589805366-328489-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Wu Bo <wubo40@huawei.com>

If a call of the function blkg_lookup_check() failed,
we should be release the previously allocated block group 
before jumping to the lable 'fail_unlock' in the implementation of 
the function blkg_conf_prep().

Suggested-by: Markus Elfring <Markus.Elfring@web.de>
Signed-off-by: Wu Bo <wubo40@huawei.com>

---
V2: omit the source code quotation from 
    the change description

---
 block/blk-cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 930212c..afeb769 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -682,6 +682,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		blkg = blkg_lookup_check(pos, pol, q);
 		if (IS_ERR(blkg)) {
 			ret = PTR_ERR(blkg);
+			blkg_free(new_blkg);
 			goto fail_unlock;
 		}
 
-- 
1.8.3.1

