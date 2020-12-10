Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54C22D5051
	for <lists+cgroups@lfdr.de>; Thu, 10 Dec 2020 02:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbgLJBXS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Dec 2020 20:23:18 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9416 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731652AbgLJBXJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Dec 2020 20:23:09 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Crx312lmZz7C5k;
        Thu, 10 Dec 2020 09:21:49 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Dec 2020 09:22:12 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH v2] cgroup: Fix memory leak when parsing multiple source parameters
Date:   Thu, 10 Dec 2020 09:29:43 +0800
Message-ID: <20201210012943.92845-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201209121322.77665-1-miaoqinglang@huawei.com>
References: <20201209121322.77665-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

A memory leak is found in cgroup1_parse_param() when multiple source
parameters overwrite fc->source in the fs_context struct without free.

unreferenced object 0xffff888100d930e0 (size 16):
  comm "mount", pid 520, jiffies 4303326831 (age 152.783s)
  hex dump (first 16 bytes):
    74 65 73 74 6c 65 61 6b 00 00 00 00 00 00 00 00  testleak........
  backtrace:
    [<000000003e5023ec>] kmemdup_nul+0x2d/0xa0
    [<00000000377dbdaa>] vfs_parse_fs_string+0xc0/0x150
    [<00000000cb2b4882>] generic_parse_monolithic+0x15a/0x1d0
    [<000000000f750198>] path_mount+0xee1/0x1820
    [<0000000004756de2>] do_mount+0xea/0x100
    [<0000000094cafb0a>] __x64_sys_mount+0x14b/0x1f0

Fix this bug by permitting a single source parameter and rejecting with
an error all subsequent ones.

Fixes: 8d2451f4994f ("cgroup1: switch to option-by-option parsing")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 v1->v2: fix compile problems caused by superfluous LF in err message.
 kernel/cgroup/cgroup-v1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 191c329e4..32596fdbc 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -908,6 +908,8 @@ int cgroup1_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	opt = fs_parse(fc, cgroup1_fs_parameters, param, &result);
 	if (opt == -ENOPARAM) {
 		if (strcmp(param->key, "source") == 0) {
+			if (fc->source)
+				return invalf(fc, "Multiple sources not supported");
 			fc->source = param->string;
 			param->string = NULL;
 			return 0;
-- 
2.23.0

