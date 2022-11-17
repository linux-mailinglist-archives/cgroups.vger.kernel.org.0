Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBED62D3E4
	for <lists+cgroups@lfdr.de>; Thu, 17 Nov 2022 08:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiKQHQW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Nov 2022 02:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbiKQHQU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Nov 2022 02:16:20 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9909063B6;
        Wed, 16 Nov 2022 23:16:19 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AH5OLnK011670;
        Thu, 17 Nov 2022 07:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=9kopYNd6jIPcxgzNvcy2sDx186qQDHRpN+Dt2XgO6jk=;
 b=2fk7wvcguQPJsQt27KH18YVDsK0dxAJgIAOiB6dNsvXhbUP5H+Q7DoJYRFD86oQrQ1YH
 li9rLPrZPwY3rQDOc9NAS0Fx+oMNi6FTRWHRKrT1v6HJrUILUBWnmwwbHgjeKDz4mlCf
 rafvqWqtZtDjrztrl1M4LzH7gn7Fo+Hw8gQ57pPAZo019GfsG9T+YWyj2lEy4sNlWSfA
 +GtMjI8iRnUfPECor7wkfk4QCRYm+htH/NwkVd1ANYU6r28CG4tzx0bCfnkIMuHQ21vD
 igwtMXWF4fLuec+Vev9OYMPG1WulctC8J4AAKk921IoiQVY2ltlXOUMDPvI5CRLrl+J8 bg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3jsr3jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 07:16:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AH6gRhO016820;
        Thu, 17 Nov 2022 07:16:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kuk1yh83m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 07:16:10 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AH7GAv9029452;
        Thu, 17 Nov 2022 07:16:10 GMT
Received: from jarvis3.oracle.com (dhcp-10-76-54-85.vpn.oracle.com [10.76.54.85])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kuk1yh81d-1;
        Thu, 17 Nov 2022 07:16:10 +0000
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Hromatka <tom.hromatka@oracle.com>
Subject: [PATCH v2] cgroup/cpuset: Improve cpuset_css_alloc() description
Date:   Thu, 17 Nov 2022 12:45:57 +0530
Message-Id: <20221117071557.165742-1-kamalesh.babulal@oracle.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_04,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170054
X-Proofpoint-ORIG-GUID: TJtROg19GrMyBSACY64Twub5WEpeNIDg
X-Proofpoint-GUID: TJtROg19GrMyBSACY64Twub5WEpeNIDg
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
v2: Reworded the description to be more accurate, as suggested
    by Waiman Long

 kernel/cgroup/cpuset.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b474289c15b8..ce789e1b2a2f 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3046,11 +3046,15 @@ static struct cftype dfl_files[] = {
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
+ * Allocate and initialize a new cpuset css, for non-NULL @parent_css, return
+ * top cpuset css otherwise.
  */
-
 static struct cgroup_subsys_state *
 cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
 {
-- 
2.34.3

