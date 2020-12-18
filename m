Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F8C2DDE75
	for <lists+cgroups@lfdr.de>; Fri, 18 Dec 2020 07:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgLRGLw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Dec 2020 01:11:52 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9227 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgLRGLw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Dec 2020 01:11:52 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cxz4D1jSXzkqj6;
        Fri, 18 Dec 2020 14:10:20 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Fri, 18 Dec 2020 14:11:02 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <tj@kernel.org>, <lizefan@huawei.com>, <hannes@cmpxchg.org>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH v2] cgroup-v1: add disabled controller check in cgroup1_parse_param()
Date:   Fri, 18 Dec 2020 14:17:55 +0800
Message-ID: <20201218061755.121205-1-chenzhou10@huawei.com>
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
Changes in v2:
- Fix line over 80 characters warning.
---
 kernel/cgroup/cgroup-v1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 191c329e482a..5190c42fea8b 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -915,6 +915,9 @@ int cgroup1_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		for_each_subsys(ss, i) {
 			if (strcmp(param->key, ss->legacy_name))
 				continue;
+			if (!cgroup_ssid_enabled(i) || cgroup1_ssid_disabled(i))
+				return invalfc(fc, "Disabled controller '%s'",
+					       param->key);
 			ctx->subsys_mask |= (1 << i);
 			return 0;
 		}
-- 
2.20.1

