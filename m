Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CB462B2EF
	for <lists+cgroups@lfdr.de>; Wed, 16 Nov 2022 06:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiKPFof (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Nov 2022 00:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiKPFoe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Nov 2022 00:44:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B9B62C7;
        Tue, 15 Nov 2022 21:44:32 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG3qTSq022313;
        Wed, 16 Nov 2022 05:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=jhSVHIUZfvFwsvGyEJwDiFx8Fn6QcA5O4eLJOA7BiSk=;
 b=3McIG5aA5Dw94XTVmrxS5nddi7fsYR/Zu3boldh7iUxTPaQ/+GGhtkiVvjXhb1aQPvz1
 z0Emyw6I0Trj/cycDerFjHPYCA8yF1cQOkhDtO5g7lwouBqgRy2+aa+e3d9jrD/ADPYw
 X7UbEwN6H1DhlqXhGY4n0cyZnf9qukedFmw6zVn5ppxttT0xEXfJSHqEtAUAv93TOA29
 UCO7skQYnbnVb+GW8z5qKN+kyF+w/CNiHNZx9P84AjQiup0P+ak07O9qHcW0pLQH4TTt
 XJwEvYJBisQgMgp7ap1yx+mBgpFGpJRwhrq7Ifndr0Hc06i8/aZPRun644p8Oa43qWB2 Yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3hduj20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 05:44:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AG4VZGn010206;
        Wed, 16 Nov 2022 05:44:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xd6n6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 05:44:26 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AG5iQg9017863;
        Wed, 16 Nov 2022 05:44:26 GMT
Received: from jarvis3.oracle.com (dhcp-10-191-244-159.vpn.oracle.com [10.191.244.159])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3kt1xd6n4a-1;
        Wed, 16 Nov 2022 05:44:25 +0000
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Hromatka <tom.hromatka@oracle.com>
Subject: [PATCH] cgroup/cpuset: Improve cpuset_css_alloc() description
Date:   Wed, 16 Nov 2022 11:14:15 +0530
Message-Id: <20221116054415.79157-1-kamalesh.babulal@oracle.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211160040
X-Proofpoint-ORIG-GUID: d-tKLSEvS8ce2m1ZPJVu0jTKihiIdOJp
X-Proofpoint-GUID: d-tKLSEvS8ce2m1ZPJVu0jTKihiIdOJp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Change the function argument in the description of cpuset_css_alloc()
from 'struct cgroup' -> 'struct cgroup_subsys_state'.  The change to the
argument type was introduced by commit eb95419b023a ("cgroup: pass
around cgroup_subsys_state instead of cgroup in subsystem methods").
Also, add more information to its description.

Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
---
 kernel/cgroup/cpuset.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b474289c15b8..aac790462e74 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3046,9 +3046,14 @@ static struct cftype dfl_files[] = {
 };
 
 
-/*
- *	cpuset_css_alloc - allocate a cpuset css
- *	cgrp:	control group that the new cpuset will be part of
+/**
+ * cpuset_css_alloc - Allocate a cpuset css
+ * @parent_css: Parent css of the control group that the new cpuset will be
+ *              part of
+ * Return: cpuset css on success, -ENOMEM on failure.
+ *
+ * Allocate and initialize a new cpuset css, for non-root cpuset or return the
+ * top cpuset css for root cpuset.
  */
 
 static struct cgroup_subsys_state *
-- 
2.34.3

