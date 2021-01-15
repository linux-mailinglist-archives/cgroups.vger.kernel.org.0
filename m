Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFD62F7580
	for <lists+cgroups@lfdr.de>; Fri, 15 Jan 2021 10:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbhAOJcq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Jan 2021 04:32:46 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10659 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbhAOJcp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Jan 2021 04:32:45 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DHGBm3z4gz15pqt;
        Fri, 15 Jan 2021 17:30:56 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Fri, 15 Jan 2021 17:31:51 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>
CC:     <mkoutny@suse.com>, <viro@zeniv.linux.org.uk>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>, <huawei.libin@huawei.com>
Subject: [PATCH v3] cgroup-v1: add disabled controller check in cgroup1_parse_param()
Date:   Fri, 15 Jan 2021 17:37:17 +0800
Message-ID: <20210115093717.79474-1-chenzhou10@huawei.com>
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
For example, boot with cgroup_no_v1=cpu or cgroup_disable=cpu, and then
mount with "mount -t cgroup -ocpu cpu /sys/fs/cgroup/cpu", then all
enabled controllers will be attached except cpu.

Fix this by adding disabled controller check in cgroup1_parse_param().
If the specified controller is disabled, just return error with information
"Disabled controller xx" rather than attaching all the other enabled
controllers.

Fixes: f5dfb5315d34 ("cgroup: take options parsing into ->parse_monolithic()")
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Reviewed-by: Zefan Li <lizefan.x@bytedance.com>
---
Changes in v3:
- Update the description of commit message.
- Add Reviewed-by from Zefan.

Changes in v2:
- Fix line over 80 characters warning.
---
 kernel/cgroup/cgroup-v1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 32596fdbcd5b..a5751784ad74 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -917,6 +917,9 @@ int cgroup1_parse_param(struct fs_context *fc, struct fs_parameter *param)
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

