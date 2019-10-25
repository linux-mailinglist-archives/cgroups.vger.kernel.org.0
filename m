Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40192E42C3
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2019 07:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391382AbfJYFFt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Oct 2019 01:05:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36272 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390186AbfJYFFt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Oct 2019 01:05:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9P53TCP115439;
        Fri, 25 Oct 2019 05:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=kMz1HFVMBBKyR/kOznC/EfIyfbOqS6EqEW29I2iHCrM=;
 b=SJtEKUcUG2runR6pCdY6lpWQaj5hXZDYk89X/1c0lZUvAsnO8MvjoWvZrtf4xtzmCngM
 2mkfw+DwjdXcnNq/WXtfqTvFnS2hCOJyUgJWPM5ZgmLm0+YDh3c5l7BSziG+raWlQfsF
 2SYwHh9nnIbgYW1TuD4zqAviU7I/hL0VysSnLdLC0AYwJBF+osWJQNQc6q4SagcX3pgB
 2Vjpa4MfbhujoO5ua3rI6yLyVVu/TuAJzu6wvr/EMJhB8KBL7XWEYWEcwz2KVrh+upBe
 5V0W8GU6voINfMElsaF7s4Wc/eOhPUNA40uJdM/+Ix2qGt5gmLrkU/8lPpLzdb0iiVbn sg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2vqswu076g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 05:05:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9P53OaJ050120;
        Fri, 25 Oct 2019 05:05:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vu0fqry85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 05:05:23 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9P55Itr029240;
        Fri, 25 Oct 2019 05:05:18 GMT
Received: from oracle.com (/10.182.71.227)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Oct 2019 22:05:18 -0700
From:   Honglei Wang <honglei.wang@oracle.com>
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org, guro@fb.com,
        oleg@redhat.com
Cc:     cgroups@vger.kernel.org
Subject: [PATCH v2] cgroup: freezer: don't change task and cgroups status unnecessarily
Date:   Fri, 25 Oct 2019 13:05:26 +0800
Message-Id: <20191025050526.19950-1-honglei.wang@oracle.com>
X-Mailer: git-send-email 2.17.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=641
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910250048
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=723 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910250048
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It's not necessary to adjust the task state and revisit the state
of source and destination cgroups if the cgroups are not in freeze
state and the task itself is not frozen.

And in this scenario, it wakes up the task who's not supposed to be
ready to run.

Don't do the unnecessary task state adjustment can help stop waking
up the task without a reason.

Signed-off-by: Honglei Wang <honglei.wang@oracle.com>
Acked-by: Roman Gushchin <guro@fb.com>
---
 kernel/cgroup/freezer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index 8cf010680678..3984dd6b8ddb 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -230,6 +230,15 @@ void cgroup_freezer_migrate_task(struct task_struct *task,
 	if (task->flags & PF_KTHREAD)
 		return;
 
+	/*
+	 * It's not necessary to do changes if both of the src and dst cgroups
+	 * are not freezing and task is not frozen.
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

