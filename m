Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E1652C665
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 00:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiERWir (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 May 2022 18:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiERWip (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 May 2022 18:38:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B168187209;
        Wed, 18 May 2022 15:38:44 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24ILmTaJ022038;
        Wed, 18 May 2022 22:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=cWTccgEFni0SxdgeQnDGBy9L1Zho1qh6R/OThU17sl8=;
 b=ZOZcebrJGbgwHxCcYecMtKnjvK4wLXM9H04DjFyVCjX3ux0bJgJlOKB7ZnmbAu2cnL0b
 pHTobF0gikeR9oo+GUGFJh7ytrxzP8nKyyd2VO1bdD5bi/ggvsiEZkqBjrr8+3oAyswW
 g6nooA2efPDT45R51URRzKY7JaU944KOYKDjpKIYifat4B6N7zdDCUrtS/gopBvGtt+A
 rae5DRO4L7qh/wSJf0DzfJwHYuEQSL8HhK0MiGIYWszZHXi4fwaCovtM8xBlu7nxICTV
 L9U7BDa+reXdgayM4Kjf/qgkmEDXemte+07rre1yQ4UIfTRmOK9/2lghvaYbyUHR3Kzj sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g591s0ykk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 22:38:36 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24IMMZVP002682;
        Wed, 18 May 2022 22:38:36 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g591s0yjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 22:38:36 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24IMcIbm028428;
        Wed, 18 May 2022 22:38:33 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3g2429e9my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 22:38:33 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24IMcU6f22020420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 22:38:30 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 755844C050;
        Wed, 18 May 2022 22:38:30 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2AB64C044;
        Wed, 18 May 2022 22:38:25 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.43.77.53])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 18 May 2022 22:38:25 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Thu, 19 May 2022 04:08:24 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Vaibhav Jain <vaibhav@linux.ibm.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH] memcg: provide reclaim stats via 'memory.reclaim'
Date:   Thu, 19 May 2022 04:08:15 +0530
Message-Id: <20220518223815.809858-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WW_Zj-4Qv0pvqo8tFz9-I-3xNtkXyPAI
X-Proofpoint-ORIG-GUID: dBh774JKVVFITszzeWAwa8USh6ZJW1U6
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_06,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1011
 mlxlogscore=999 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205180125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

[1] Provides a way for user-space to trigger proactive reclaim by introducing
a write-only memcg file 'memory.reclaim'. However reclaim stats like number
of pages scanned and reclaimed is still not directly available to the
user-space.

This patch proposes to extend [1] to make the memcg file 'memory.reclaim'
readable which returns the number of pages scanned / reclaimed during the
reclaim process from 'struct vmpressure' associated with each memcg. This should
let user-space asses how successful proactive reclaim triggered from memcg
'memory.reclaim' was ?

With the patch following command flow is expected:

 # echo "1M" > memory.reclaim

 # cat memory.reclaim
   scanned 76
   reclaimed 32

[1]:  https://lore.kernel.org/r/20220425190040.2475377-1-yosryahmed@google.com

Cc: Shakeel Butt <shakeelb@google.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 15 ++++++++++++---
 mm/memcontrol.c                         | 14 ++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 27ebef2485a3..44610165261d 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1209,18 +1209,27 @@ PAGE_SIZE multiple when read back.
 	utility is limited to providing the final safety net.
 
   memory.reclaim
-	A write-only nested-keyed file which exists for all cgroups.
+	A nested-keyed file which exists for all cgroups.
 
-	This is a simple interface to trigger memory reclaim in the
-	target cgroup.
+	This is a simple interface to trigger memory reclaim and retrieve
+	reclaim stats in the target cgroup.
 
 	This file accepts a single key, the number of bytes to reclaim.
 	No nested keys are currently supported.
 
+	Reading the file returns number of pages scanned and number of
+	pages reclaimed from the memcg. This information fetched from
+	vmpressure info associated with each cgroup.
+
 	Example::
 
 	  echo "1G" > memory.reclaim
 
+	  cat memory.reclaim
+
+	  scanned 78
+	  reclaimed 30
+
 	The interface can be later extended with nested keys to
 	configure the reclaim behavior. For example, specify the
 	type of memory to reclaim from (anon, file, ..).
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2e2bfbed4717..9e43580a8726 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6423,6 +6423,19 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+static int memory_reclaim_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+	struct vmpressure *vmpr = memcg_to_vmpressure(memcg);
+
+	spin_lock(&vmpr->sr_lock);
+	seq_printf(m, "scanned %lu\nreclaimed %lu\n",
+		   vmpr->scanned, vmpr->reclaimed);
+	spin_unlock(&vmpr->sr_lock);
+
+	return 0;
+}
+
 static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 			      size_t nbytes, loff_t off)
 {
@@ -6525,6 +6538,7 @@ static struct cftype memory_files[] = {
 		.name = "reclaim",
 		.flags = CFTYPE_NS_DELEGATABLE,
 		.write = memory_reclaim,
+		.seq_show  = memory_reclaim_show,
 	},
 	{ }	/* terminate */
 };
-- 
2.35.1

