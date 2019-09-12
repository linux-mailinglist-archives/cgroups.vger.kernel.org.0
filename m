Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D135B142D
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2019 19:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfILR4t (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Sep 2019 13:56:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56396 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726740AbfILR4t (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Sep 2019 13:56:49 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8CHrFW9011956
        for <cgroups@vger.kernel.org>; Thu, 12 Sep 2019 10:56:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=DiB/JXN9MiGhOXyaA1IgQrfA2ly3wM/1C1ucZaXosR4=;
 b=JKSb3CP/Bw2i+foP7KE87GSWZtaROeAwj6jVHNNFz5ljU0B2UHXJxUw9TPdGYLYn8qAu
 vIEt07HcijFyxWE2JHVjnfk0Z1Q9C8rGLDw19E4NFW1n7LyuE1q50IU877LRL0KPG4Wq
 +UFr3dnVSuKD4fB6gcU6WMsgxQ7fhDAvpNg= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2uytdj85pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <cgroups@vger.kernel.org>; Thu, 12 Sep 2019 10:56:48 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 12 Sep 2019 10:56:47 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id D7FD917690C07; Thu, 12 Sep 2019 10:56:46 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Tejun Heo <tj@kernel.org>, <cgroups@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Mark Crossen <mcrossen@fb.com>, Roman Gushchin <guro@fb.com>,
        Shuah Khan <shuah@kernel.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH 1/2] kselftests: cgroup: add freezer mkdir test
Date:   Thu, 12 Sep 2019 10:56:44 -0700
Message-ID: <20190912175645.2841713-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-12_09:2019-09-11,2019-09-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 suspectscore=2 clxscore=1015 mlxscore=0
 mlxlogscore=246 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909120188
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add a new cgroup freezer selftest, which checks that if a cgroup is
frozen, their new child cgroups will properly inherit the frozen
state.

It creates a parent cgroup, freezes it, creates a child cgroup
and populates it with a dummy process. Then it checks that both
parent and child cgroup are frozen.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/cgroup/test_freezer.c | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_freezer.c b/tools/testing/selftests/cgroup/test_freezer.c
index 8219a30853d2..0fc1b6d4b0f9 100644
--- a/tools/testing/selftests/cgroup/test_freezer.c
+++ b/tools/testing/selftests/cgroup/test_freezer.c
@@ -447,6 +447,59 @@ static int test_cgfreezer_forkbomb(const char *root)
 	return ret;
 }
 
+/*
+ * The test creates a cgroups and freezes it. Then it creates a child cgroup
+ * and populates it with a task. After that it checks that the child cgroup
+ * is frozen and the parent cgroup remains frozen too.
+ */
+static int test_cgfreezer_mkdir(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *parent, *child = NULL;
+	int pid;
+
+	parent = cg_name(root, "cg_test_mkdir_A");
+	if (!parent)
+		goto cleanup;
+
+	child = cg_name(parent, "cg_test_mkdir_B");
+	if (!child)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup;
+
+	if (cg_freeze_wait(parent, true))
+		goto cleanup;
+
+	if (cg_create(child))
+		goto cleanup;
+
+	pid = cg_run_nowait(child, child_fn, NULL);
+	if (pid < 0)
+		goto cleanup;
+
+	if (cg_wait_for_proc_count(child, 1))
+		goto cleanup;
+
+	if (cg_check_frozen(child, true))
+		goto cleanup;
+
+	if (cg_check_frozen(parent, true))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (child)
+		cg_destroy(child);
+	free(child);
+	if (parent)
+		cg_destroy(parent);
+	free(parent);
+	return ret;
+}
+
 /*
  * The test creates two nested cgroups, freezes the parent
  * and removes the child. Then it checks that the parent cgroup
@@ -815,6 +868,7 @@ struct cgfreezer_test {
 	T(test_cgfreezer_simple),
 	T(test_cgfreezer_tree),
 	T(test_cgfreezer_forkbomb),
+	T(test_cgfreezer_mkdir),
 	T(test_cgfreezer_rmdir),
 	T(test_cgfreezer_migrate),
 	T(test_cgfreezer_ptrace),
-- 
2.21.0

