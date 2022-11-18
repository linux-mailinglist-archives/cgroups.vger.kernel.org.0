Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089D462EE18
	for <lists+cgroups@lfdr.de>; Fri, 18 Nov 2022 08:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiKRHGw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Nov 2022 02:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiKRHGu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Nov 2022 02:06:50 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF525D689
        for <cgroups@vger.kernel.org>; Thu, 17 Nov 2022 23:06:49 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AI6IfiZ002186;
        Fri, 18 Nov 2022 07:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=N4KdvjMJHC5x6ymTMDf532HEFw4KhYB9MxBma68Whaw=;
 b=K5qeR2rkczKSqUDb9c6M3vsH+9E2EUIt61DQ32yuEHhRtOf/FNttWepddKFc17VfBdmV
 K9XtCesE74O3wcO/nb0vAfcDZDRce6d+vaesm0Mfk2hTEw0vjvSYIWUIgbwLgrj0Mpxr
 +chs28agSzM96IR44JniRCXZnPyfulB50j6dpQWn91VljgL/ganHvslFll6ommP/ZZSH
 tU4kUexLPZZISQF41cuk7VY4/NDCaPkjvoF5Xgt8/Qf/MsJd3Ac0nQC9d0utUZMYxL7B
 ADPPZukB0CUSnEk3JxH73vYslTLy+m74uT0YR8Et7Oskc7zpLnjp35t4v0fir8ky4keM xA== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kx4nxrx0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 07:06:40 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AI74veO021301;
        Fri, 18 Nov 2022 07:06:38 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01wdc.us.ibm.com with ESMTP id 3kt349x4gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 07:06:38 +0000
Received: from smtpav02.dal12v.mail.ibm.com ([9.208.128.128])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AI76Y2n47317370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 07:06:34 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 759A35805F;
        Fri, 18 Nov 2022 07:06:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F368F5805E;
        Fri, 18 Nov 2022 07:06:33 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.38.233])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 18 Nov 2022 07:06:33 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, stable@kernel.org
Subject: [PATCH] mm/cgroup/reclaim: Fix dirty pages throttling on cgroup v1
Date:   Fri, 18 Nov 2022 12:36:03 +0530
Message-Id: <20221118070603.84081-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eQuWpoFTu9NJ90eS_0oqrMunQX0yUx92
X-Proofpoint-GUID: eQuWpoFTu9NJ90eS_0oqrMunQX0yUx92
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 mlxlogscore=906
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180048
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

balance_dirty_pages doesn't do the required dirty throttling on cgroupv1. See
commit 9badce000e2c ("cgroup, writeback: don't enable cgroup writeback on
traditional hierarchies"). Instead, the kernel depends on writeback throttling
in shrink_folio_list to achieve the same goal. With large memory systems, the
flusher may not be able to writeback quickly enough such that we will start
finding pages in the shrink_folio_list already in writeback. Hence for cgroupv1
let's do a reclaim throttle after waking up the flusher.

The below test which used to fail on a 256GB system completes till the
the file system is full with this change.

root@lp2:/sys/fs/cgroup/memory# mkdir test
root@lp2:/sys/fs/cgroup/memory# cd test/
root@lp2:/sys/fs/cgroup/memory/test# echo 120M > memory.limit_in_bytes
root@lp2:/sys/fs/cgroup/memory/test# echo $$ > tasks
root@lp2:/sys/fs/cgroup/memory/test# dd if=/dev/zero of=/home/kvaneesh/test bs=1M
Killed

Cc: <stable@kernel.org>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/vmscan.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 04d8b88e5216..388022c5ef2b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2514,8 +2514,20 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	 * the flushers simply cannot keep up with the allocation
 	 * rate. Nudge the flusher threads in case they are asleep.
 	 */
-	if (stat.nr_unqueued_dirty == nr_taken)
+	if (stat.nr_unqueued_dirty == nr_taken) {
 		wakeup_flusher_threads(WB_REASON_VMSCAN);
+		/*
+		 * For cgroupv1 dirty throttling is achieved by waking up
+		 * the kernel flusher here and later waiting on folios
+		 * which are in writeback to finish (see shrink_folio_list()).
+		 *
+		 * Flusher may not be able to issue writeback quickly
+		 * enough for cgroupv1 writeback throttling to work
+		 * on a large system.
+		 */
+		if (!writeback_throttling_sane(sc))
+			reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK);
+	}
 
 	sc->nr.dirty += stat.nr_dirty;
 	sc->nr.congested += stat.nr_congested;
-- 
2.38.1

