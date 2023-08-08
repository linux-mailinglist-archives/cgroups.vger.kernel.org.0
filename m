Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD38773675
	for <lists+cgroups@lfdr.de>; Tue,  8 Aug 2023 04:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjHHCXF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Aug 2023 22:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjHHCXE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Aug 2023 22:23:04 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27AA170B;
        Mon,  7 Aug 2023 19:23:03 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3782J4Zq031658;
        Tue, 8 Aug 2023 02:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PPS06212021; bh=AIPZU
        svPanUaYFy4CGvgvEVpmAFpszDXG2gqN2PuzBQ=; b=UethCzakofiuKA7BWnceH
        IJMw0tMeWg92lPunK+L74LWxfl0WMtfPhghAZCRRiFwoczIKuk32hXjBJ9PltW+O
        Q5uGWTlAXYpdmL+klE9cZUMbh1XktSH5mbZg8Ej4LHuVgGYqRjJOAnC6MfeYtAWn
        Vt9PVtvWdYkL+uMFuLXAjuZjCo43lXVFfw1sHLeIWtsR1WFmojbIcs1tgEtnhpAs
        FbAD1gsWIvUDnwJ3ftVAZxqpW9L6IQHy7ixsYydsmQVquCTaox2xWWfPMmDpPi8W
        Jc8hd/rA8fCLaHm0yE187j5zl6Zyz1eq0rqhjn0b1+dPOPYWIqJbO/YlTZhqlthY
        A==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s9dd625hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Aug 2023 02:22:44 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 19:22:42 -0700
Received: from pek-lpd-ccm4.wrs.com (147.11.1.11) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 7 Aug 2023 19:22:40 -0700
From:   <xiongwei.song@windriver.com>
To:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <roman.gushchin@linux.dev>, <shakeelb@google.com>,
        <muchun.song@linux.dev>, <akpm@linux-foundation.org>
CC:     <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/memcontrol: add tips for kmem.slabinfo
Date:   Tue, 8 Aug 2023 10:22:29 +0800
Message-ID: <20230808022229.1560559-1-xiongwei.song@windriver.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: t5m8IOcx_rEJ4vRHtZzbZNnRWl2zp0Al
X-Proofpoint-ORIG-GUID: t5m8IOcx_rEJ4vRHtZzbZNnRWl2zp0Al
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_28,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=604 impostorscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 adultscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308080020
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Xiongwei Song <xiongwei.song@windriver.com>

No any output from kmem.slabinfo, which is not friendly. Adding
tips for it.

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
 mm/memcontrol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8ca4bdcb03c..58d3bd93890b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5002,10 +5002,8 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 #if defined(CONFIG_MEMCG_KMEM) && (defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG))
 static int mem_cgroup_slab_show(struct seq_file *m, void *p)
 {
-	/*
-	 * Deprecated.
-	 * Please, take a look at tools/cgroup/memcg_slabinfo.py .
-	 */
+	seq_puts(m, "This file is deprecated.\n"
+		"Please use tools/cgroup/memcg_slabinfo.py, which is in kernel source.\n");
 	return 0;
 }
 #endif
-- 
2.37.3

