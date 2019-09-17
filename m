Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5B13B47A6
	for <lists+cgroups@lfdr.de>; Tue, 17 Sep 2019 08:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfIQGrE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Sep 2019 02:47:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35480 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404329AbfIQGrE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Sep 2019 02:47:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8H6iMrg057381;
        Tue, 17 Sep 2019 06:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=v5Oi8CHVpx5zevAE3CSdTwh9u0qHpoyxijY0H4hs6Lc=;
 b=CeOBLE4BEx1ZPhx+hLpexX4sCenBD9JrvtuobPoAnj21R2/g7Cyr4DG0vzLfbVal42Zd
 O3hkkAkisX/oCEKB+vxFMwRvwxVzJTvlaCexRJeqiEOqKDxXoGfZHlSr0qVfH/AjEdOk
 rZeA+3ClUZNg++VuH8YSSkJeOjpNt6tCK1sJx8wLGtgp/IS66qzYYizqxv+aXwEMVncU
 cWqWJws1PPB+jvZ7a8Av3SSCSjGRPOoBLp7hNqjVqLE/cb7g3KjIH1B6+4RaM7M5UssU
 7diLjQgUIZLlpbR3GKsvFYRVDGin+VSC09HlkI1QocQ0H/TZnmYHdKePZJsxXrFf1mn3 DA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2v0ruqm1df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Sep 2019 06:46:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8H6iH8i084644;
        Tue, 17 Sep 2019 06:46:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2v2jjsq3td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Sep 2019 06:46:54 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8H6kpqp022992;
        Tue, 17 Sep 2019 06:46:51 GMT
Received: from oracle.com (/10.182.69.197)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Sep 2019 23:46:51 -0700
From:   Honglei Wang <honglei.wang@oracle.com>
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, honglei.wang@oracle.com
Subject: [PATCH] cgroup: freezer: Don't wake up process really blocked on signal
Date:   Tue, 17 Sep 2019 14:46:45 +0800
Message-Id: <20190917064645.14666-1-honglei.wang@oracle.com>
X-Mailer: git-send-email 2.17.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909170073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909170073
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Process who's waiting for specific sigset shouldn't be woke up
neither it is moved between different cgroups nor the cgroup it
belongs to changes the frozen state. We'd better keep it as is
and let it wait for the desired signals coming.

Following test case is one scenario which will get "Interrupted
system call" error if we wake it up in cgroup_freeze_task().

int main(int argc, char *argv[])
{
        sigset_t waitset;
        int signo;

        sigemptyset(&waitset);
        sigaddset(&waitset, SIGINT);
        sigaddset(&waitset, SIGUSR1);

        pthread_sigmask(SIG_BLOCK, &waitset, NULL);

        for (;;) {
                signo = sigwaitinfo(&waitset, NULL);
                if (signo < 0)
                        err(1, "sigwaitinfo() failed");

                if (signo == SIGUSR1)
                        printf("Receive SIGUSR1\n");
                else
                        break;
        }

        return 0;
}

Signed-off-by: Honglei Wang <honglei.wang@oracle.com>
---
 kernel/cgroup/freezer.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index 8cf010680678..08f6abacaa75 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -162,10 +162,14 @@ static void cgroup_freeze_task(struct task_struct *task, bool freeze)
 
 	if (freeze) {
 		task->jobctl |= JOBCTL_TRAP_FREEZE;
-		signal_wake_up(task, false);
+
+		if (sigisemptyset(&task->real_blocked))
+			signal_wake_up(task, false);
 	} else {
 		task->jobctl &= ~JOBCTL_TRAP_FREEZE;
-		wake_up_process(task);
+
+		if (sigisemptyset(&task->real_blocked))
+			wake_up_process(task);
 	}
 
 	unlock_task_sighand(task, &flags);
-- 
2.17.0

