Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94D41D04AC
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2020 04:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgEMCNQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 May 2020 22:13:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55562 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727792AbgEMCNQ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 12 May 2020 22:13:16 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9D0CB1D573112B1D5684;
        Wed, 13 May 2020 10:13:14 +0800 (CST)
Received: from [10.133.206.78] (10.133.206.78) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 13 May
 2020 10:13:12 +0800
To:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
CC:     Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Zefan Li <lizefan@huawei.com>
Subject: [PATCH] cgroup: Remove stale comments
Message-ID: <0ce73f20-6b19-38c7-81c5-b0b71013fcb7@huawei.com>
Date:   Wed, 13 May 2020 10:13:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.206.78]
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

- The default root is where we can create v2 cgroups.
- The __DEVEL__sane_behavior mount option has been removed long long ago.

Signed-off-by: Li Zefan <lizefan@huawei.com>
---

found these when fixing the netprio cgroup bug.

---
 kernel/cgroup/cgroup.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 06b5ea9..7a01674 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -153,11 +153,7 @@ static struct static_key_true *cgroup_subsys_on_dfl_key[] = {
 
 static DEFINE_PER_CPU(struct cgroup_rstat_cpu, cgrp_dfl_root_rstat_cpu);
 
-/*
- * The default hierarchy, reserved for the subsystems that are otherwise
- * unattached - it never has more than a single cgroup, and all tasks are
- * part of that cgroup.
- */
+/* the default hierarchy */
 struct cgroup_root cgrp_dfl_root = { .cgrp.rstat_cpu = &cgrp_dfl_root_rstat_cpu };
 EXPORT_SYMBOL_GPL(cgrp_dfl_root);
 
@@ -251,9 +247,6 @@ bool cgroup_ssid_enabled(int ssid)
  * cases where a subsystem should behave differnetly depending on the
  * interface version.
  *
- * The set of behaviors which change on the default hierarchy are still
- * being determined and the mount option is prefixed with __DEVEL__.
- *
  * List of changed behaviors:
  *
  * - Mount options "noprefix", "xattr", "clone_children", "release_agent"
-- 
2.7.4
