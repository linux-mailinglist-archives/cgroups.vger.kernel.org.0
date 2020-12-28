Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2522E33E2
	for <lists+cgroups@lfdr.de>; Mon, 28 Dec 2020 04:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgL1DSj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 27 Dec 2020 22:18:39 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9936 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgL1DSj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 27 Dec 2020 22:18:39 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4D42ly1C1szhyDY;
        Mon, 28 Dec 2020 11:17:18 +0800 (CST)
Received: from [10.174.179.9] (10.174.179.9) by smtp.huawei.com (10.3.19.207)
 with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 28 Dec 2020 11:17:55
 +0800
To:     Tejun Heo <tj@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Steve Wahl <steve.wahl@hpe.com>
From:   Zefan Li <lizefan@huawei.com>
Subject: [PATCH] cpuset: Remove stale URLs in the MAINTAINERS entry
Message-ID: <42668f2c-5ea1-da38-918e-ac4c86e3f03d@huawei.com>
Date:   Mon, 28 Dec 2020 11:17:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Those URLs are no longer accessable.

Reported-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Zefan Li <lizefan@huawei.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ae9b1dd748c4..2fe8eb54639e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4477,8 +4477,6 @@ CONTROL GROUP - CPUSET
 M:	Li Zefan <lizefan@huawei.com>
 L:	cgroups@vger.kernel.org
 S:	Maintained
-W:	http://www.bullopensource.org/cpuset/
-W:	http://oss.sgi.com/projects/cpusets/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
 F:	Documentation/admin-guide/cgroup-v1/cpusets.rst
 F:	include/linux/cpuset.h
-- 
2.22.0

