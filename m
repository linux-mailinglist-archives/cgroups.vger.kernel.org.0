Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAB29DE61B
	for <lists+cgroups@lfdr.de>; Mon, 21 Oct 2019 10:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfJUISo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Oct 2019 04:18:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36102 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfJUISn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Oct 2019 04:18:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L8DoN8114053;
        Mon, 21 Oct 2019 08:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=GEV5eDxaAaefE+AM1c/+DNqpVbXw/mq2vyf+KRGVU8I=;
 b=KLoJYoNPahqPCHhNRAYP8Y/9XvxJkRTqHexDqcpWynd1CKVuymYJGOmkjazQt9CHIGG6
 aoYeV1XCJ97GJ2ykQ6dSVnPQik6zzKMKKe+p1wHcLQIIjmhoK9aF+D7kV+MKPWT+D2rw
 UIVRbvbwuMFs9cnVSr12RiomPyMtESTnZZDl3rmVFx4f1Okp5KjB/+JXQ+d1NAjjFV/B
 KLHPL6UakZ05AbDWn3aClLw10Zz4tK2yCrg+TgDfbYp9wcVahY/LATKW+8mGpsVh1lAk
 2H484DMg8mMEeijuzx7NmJXTY7qhU5gVDPWnmXGyTDykDxdE1cnGzU6X3ZScWYc3wM5i xQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vqswt5w1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Oct 2019 08:18:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L8CpKE083284;
        Mon, 21 Oct 2019 08:18:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vrbxsp4w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Oct 2019 08:18:21 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9L8IHvI011750;
        Mon, 21 Oct 2019 08:18:17 GMT
Received: from oracle.com (/10.182.71.227)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Oct 2019 01:18:17 -0700
From:   Honglei Wang <honglei.wang@oracle.com>
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, guro@fb.com, oleg@redhat.com
Subject: [PATCH] cgroup: freezer: don't change task and cgroups status unnecessarily
Date:   Mon, 21 Oct 2019 16:18:26 +0800
Message-Id: <20191021081826.8769-1-honglei.wang@oracle.com>
X-Mailer: git-send-email 2.17.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9416 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=586
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910210077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9416 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=673 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910210077
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Seems it's not necessary to adjust the task state and revisit the
state of source and destination cgroups if the cgroups are not in
freeze state and the task itself is not frozen.

Signed-off-by: Honglei Wang <honglei.wang@oracle.com>
---
 kernel/cgroup/freezer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index 8cf010680678..2dd66551d9a6 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -230,6 +230,15 @@ void cgroup_freezer_migrate_task(struct task_struct *task,
 	if (task->flags & PF_KTHREAD)
 		return;
 
+	/*
+	 * It's not necessary to do changes if both of the src and dst cgroups
+	 * are not freeze and task is not frozen.
+	 */
+	if (!test_bit(CGRP_FREEZE, &src->flags) &&
+	    !test_bit(CGRP_FREEZE, &dst->flags) &&
+	    !task->frozen)
+		return;
+
 	/*
 	 * Adjust counters of freezing and frozen tasks.
 	 * Note, that if the task is frozen, but the destination cgroup is not
-- 
2.17.0

