Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CC2645579
	for <lists+cgroups@lfdr.de>; Wed,  7 Dec 2022 09:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLGIe1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Dec 2022 03:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiLGIeV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Dec 2022 03:34:21 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC4928E01
        for <cgroups@vger.kernel.org>; Wed,  7 Dec 2022 00:34:18 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NRrCX3d3MzJqGm;
        Wed,  7 Dec 2022 16:33:28 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Dec 2022 16:33:16 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <shuah@kernel.org>, <brauner@kernel.org>
CC:     <cgroups@vger.kernel.org>, <yosryahmed@google.com>,
        Wang Yufen <wangyufen@huawei.com>
Subject: [PATCH] selftests: cgroup: Fix the invalid check in proc_read_text()
Date:   Wed, 7 Dec 2022 16:33:09 +0800
Message-ID: <1670401989-8208-1-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Unsigned variable cannot be lesser than zero, So the return check of read_text() is invalid.
To fix, add a new ssize_t variable read for read_text() return value check.

Fixes: 6c26df84e1f2 ("selftests: cgroup: return -errno from cg_read()/cg_write() on failure")
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 4c52cc6..19137c0 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -555,6 +555,7 @@ int proc_mount_contains(const char *option)
 ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t size)
 {
 	char path[PATH_MAX];
+	ssize_t read;
 
 	if (!pid)
 		snprintf(path, sizeof(path), "/proc/%s/%s",
@@ -562,8 +563,8 @@ ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t
 	else
 		snprintf(path, sizeof(path), "/proc/%d/%s", pid, item);
 
-	size = read_text(path, buf, size);
-	return size < 0 ? -1 : size;
+	read = read_text(path, buf, size);
+	return read < 0 ? -1 : read;
 }
 
 int proc_read_strstr(int pid, bool thread, const char *item, const char *needle)
-- 
1.8.3.1

