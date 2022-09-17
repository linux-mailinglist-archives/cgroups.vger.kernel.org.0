Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390B75BB74A
	for <lists+cgroups@lfdr.de>; Sat, 17 Sep 2022 10:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiIQIk5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 17 Sep 2022 04:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiIQIky (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 17 Sep 2022 04:40:54 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 654B818B35;
        Sat, 17 Sep 2022 01:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vO2ff
        7f+cjYtcbeBGzWru6y8NNAZmlNdhrWX/ZBZ7DE=; b=Rlv2gthXQP/yutEvEmIMG
        JRGcgkdPhTXIbKSo1WPWccwfkFON3yL4tA006dk8D8N1qRnhJ6QJ+TxqD2v88fcm
        g6/YomqSDOzDQ6V9yPG96srFUpnmmZmbNwEY5YljUrCFOKMyZPndqUN5z4CQryF0
        CX5H+LnWMlcXjzxbI26AeI=
Received: from DESKTOP-CE2KKHI.localdomain (unknown [124.160.210.227])
        by smtp1 (Coremail) with SMTP id GdxpCgBXHdYIiCVjibP5dQ--.36181S2;
        Sat, 17 Sep 2022 16:40:41 +0800 (CST)
From:   williamsukatube@163.com
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     William Dean <williamsukatube@163.com>
Subject: [PATCH -next] cgroup: simplify code in cgroup_apply_control
Date:   Sat, 17 Sep 2022 16:40:39 +0800
Message-Id: <20220917084039.3177-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgBXHdYIiCVjibP5dQ--.36181S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFWkZF43KFWxZw1DGF48JFb_yoW3Crg_Aw
        1xZrsFgr92ya4jyrWqqFs8WFZ7Wrs8CF9Y9r47tFW7J3W8Grs5AwnxA3s8GrsrAa4kJFyU
        Cr9xGryvyrs3GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMVyIJUUUUU==
X-Originating-IP: [124.160.210.227]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/xtbBSQl-g1aEEv3ZsQAAsp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: William Dean <williamsukatube@163.com>

It could directly return 'cgroup_update_dfl_csses' to simplify code.

Signed-off-by: William Dean <williamsukatube@163.com>
---
 kernel/cgroup/cgroup.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e4bb5d57f4d1..1958f8bd93d6 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3292,11 +3292,7 @@ static int cgroup_apply_control(struct cgroup *cgrp)
 	 * making the following cgroup_update_dfl_csses() properly update
 	 * css associations of all tasks in the subtree.
 	 */
-	ret = cgroup_update_dfl_csses(cgrp);
-	if (ret)
-		return ret;
-
-	return 0;
+	return cgroup_update_dfl_csses(cgrp);
 }

 /**
--
2.25.1

