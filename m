Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815F87AFB8D
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 08:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjI0G6n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 02:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjI0G6m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 02:58:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9B7D6;
        Tue, 26 Sep 2023 23:58:41 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QLTNqi006223;
        Wed, 27 Sep 2023 06:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=1JPRMkBEdyKk7oKqtMorRqkKFZiq/eCbKVfKVWvw/8s=;
 b=j4f7qUPE1xQaJtTa6nZl4W//hfXjWP5a2DFCPZl8T0jADiS8+vk+ZlihvKPLWcndWMDR
 Io99PmShvV3XhYzlX9ToHqCUbz3Jbsk7DSwMOdZqem/pFY3tYzdT584CxVORSTojonz4
 NB32mTuF0HPRr+J5G10VoYlxUDcF6l/J2GItREUnlJfN1puMP3GaH4cwQy84KxCeBZbM
 omffYvkUO2xYO+AofidEXUfZ9qoBPZbSX9C4fkZ0kyOsn25EmBVNOCFsPCzaRMmimFYD
 vBOJQAYCoj93OdOnBvpG+dacfNDwgplgn35foQRey2IleSHdCzuaJO6+swavPa1B7zYk dA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pxc0pjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 06:58:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38R6CI0V030811;
        Wed, 27 Sep 2023 06:58:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfdd2yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 06:58:05 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38R6u0dh023218;
        Wed, 27 Sep 2023 06:58:05 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3t9pfdd2xb-1;
        Wed, 27 Sep 2023 06:58:05 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com,
        kamalesh.babulal@oracle.com, kernel test robot <lkp@intel.com>
Subject: [PATCH next] cgroup/cpuset: Cleanup signedness issue in cpu_exclusive_check()
Date:   Tue, 26 Sep 2023 23:58:01 -0700
Message-ID: <20230927065801.2139969-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_03,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270058
X-Proofpoint-GUID: TdBcfUHpmIQ-MCe_6iUo7Dn4JgRp97J1
X-Proofpoint-ORIG-GUID: TdBcfUHpmIQ-MCe_6iUo7Dn4JgRp97J1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Smatch complains about returning negative error codes from a type
bool function.

kernel/cgroup/cpuset.c:705 cpu_exclusive_check() warn:
	signedness bug returning '(-22)'

The code works correctly, but it is confusing.  The current behavior is
that cpu_exclusive_check() returns true if it's *NOT* exclusive.  Rename
it to cpusets_are_exclusive() and reverse the returns so it returns true
if it is exclusive and false if it's not.  Update both callers as well.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202309201706.2LhKdM6o-lkp@intel.com/
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is based on sattic analysis, only compile tested
---
 kernel/cgroup/cpuset.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 15f399153a2e..afefddd33c3e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -719,18 +719,18 @@ static inline struct cpumask *fetch_xcpus(struct cpuset *cs)
 }
 
 /*
- * cpu_exclusive_check() - check if two cpusets are exclusive
+ * cpusets_are_exclusive() - check if two cpusets are exclusive
  *
- * Return 0 if exclusive, -EINVAL if not
+ * Return true if exclusive, false if not
  */
-static inline bool cpu_exclusive_check(struct cpuset *cs1, struct cpuset *cs2)
+static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
 {
 	struct cpumask *xcpus1 = fetch_xcpus(cs1);
 	struct cpumask *xcpus2 = fetch_xcpus(cs2);
 
 	if (cpumask_intersects(xcpus1, xcpus2))
-		return -EINVAL;
-	return 0;
+		return false;
+	return true;
 }
 
 /*
@@ -833,7 +833,7 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 	cpuset_for_each_child(c, css, par) {
 		if ((is_cpu_exclusive(trial) || is_cpu_exclusive(c)) &&
 		    c != cur) {
-			if (cpu_exclusive_check(trial, c))
+			if (!cpusets_are_exclusive(trial, c))
 				goto out;
 		}
 		if ((is_mem_exclusive(trial) || is_mem_exclusive(c)) &&
@@ -1864,7 +1864,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 			cpuset_for_each_child(child, css, parent) {
 				if (child == cs)
 					continue;
-				if (cpu_exclusive_check(cs, child)) {
+				if (!cpusets_are_exclusive(cs, child)) {
 					exclusive = false;
 					break;
 				}
-- 
2.41.0

