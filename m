Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0641128B21F
	for <lists+cgroups@lfdr.de>; Mon, 12 Oct 2020 12:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgJLKV2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Oct 2020 06:21:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15276 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726658AbgJLKV2 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 12 Oct 2020 06:21:28 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 192CBAB7BBBF37C7E8D4;
        Mon, 12 Oct 2020 18:21:25 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 12 Oct 2020 18:21:15 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <tj@kernel.org>, <lizefan@huawei.com>, <hannes@cmpxchg.org>
CC:     <cgroups@vger.kernel.org>, <yangyingliang@huawei.com>,
        <chenzhou10@huawei.com>
Subject: [PATCH] cgroup-v1: add disabled controller check in cgroup1_parse_param()
Date:   Mon, 12 Oct 2020 18:27:57 +0800
Message-ID: <20201012102757.83192-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When mounting a cgroup hierarchy with disabled controller in cgroup v1,
all available controllers will be attached.

Add disabled controller check in cgroup1_parse_param() and return directly
if the specified controller is disabled.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 kernel/cgroup/cgroup-v1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 191c329e482a..7427d47ad26f 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -915,6 +915,8 @@ int cgroup1_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		for_each_subsys(ss, i) {
 			if (strcmp(param->key, ss->legacy_name))
 				continue;
+			if (!cgroup_ssid_enabled(i) || cgroup1_ssid_disabled(i))
+				return invalfc(fc, "Disabled controller '%s'", param->key);
 			ctx->subsys_mask |= (1 << i);
 			return 0;
 		}
-- 
2.20.1

