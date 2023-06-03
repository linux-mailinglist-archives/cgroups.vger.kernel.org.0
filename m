Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB07E720E73
	for <lists+cgroups@lfdr.de>; Sat,  3 Jun 2023 09:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjFCHNT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 3 Jun 2023 03:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFCHNS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 3 Jun 2023 03:13:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9C4D3;
        Sat,  3 Jun 2023 00:13:16 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QY9y50hcDztQWp;
        Sat,  3 Jun 2023 15:10:53 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 3 Jun
 2023 15:13:10 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <lizefan.x@bytedance.com>, <tj@kernel.org>, <hannes@cmpxchg.org>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] cgroup: make cgroup_is_threaded() and cgroup_is_thread_root() static
Date:   Sat, 3 Jun 2023 15:13:04 +0800
Message-ID: <20230603071304.1077085-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

They're only called inside cgroup.c. Make them static.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/cgroup/cgroup-internal.h | 2 --
 kernel/cgroup/cgroup.c          | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 367b0a42ada9..c56071f150f2 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -220,8 +220,6 @@ static inline void get_css_set(struct css_set *cset)
 
 bool cgroup_ssid_enabled(int ssid);
 bool cgroup_on_dfl(const struct cgroup *cgrp);
-bool cgroup_is_thread_root(struct cgroup *cgrp);
-bool cgroup_is_threaded(struct cgroup *cgrp);
 
 struct cgroup_root *cgroup_root_from_kf(struct kernfs_root *kf_root);
 struct cgroup *task_cgroup_from_root(struct task_struct *task,
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 8b8ca2e01019..824e3b465f6f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -357,7 +357,7 @@ static bool cgroup_has_tasks(struct cgroup *cgrp)
 	return cgrp->nr_populated_csets;
 }
 
-bool cgroup_is_threaded(struct cgroup *cgrp)
+static bool cgroup_is_threaded(struct cgroup *cgrp)
 {
 	return cgrp->dom_cgrp != cgrp;
 }
@@ -396,7 +396,7 @@ static bool cgroup_can_be_thread_root(struct cgroup *cgrp)
 }
 
 /* is @cgrp root of a threaded subtree? */
-bool cgroup_is_thread_root(struct cgroup *cgrp)
+static bool cgroup_is_thread_root(struct cgroup *cgrp)
 {
 	/* thread root should be a domain */
 	if (cgroup_is_threaded(cgrp))
-- 
2.27.0

