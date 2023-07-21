Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FE275BE00
	for <lists+cgroups@lfdr.de>; Fri, 21 Jul 2023 07:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjGUFva (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jul 2023 01:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjGUFvA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jul 2023 01:51:00 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714CE2D58;
        Thu, 20 Jul 2023 22:50:16 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36L4QrOS016769;
        Fri, 21 Jul 2023 05:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PPS06212021; bh=ujkXA
        VCxBZj9F45iQ5IJ+YX1d9OwAy1El3x8A5hKVp0=; b=XDMMhe7OQC17YJgu6jhIY
        nub0gACJkbdJJgC07Mqzhr3CvvcnnNxFIoLXNmGb4w09TbB/bvKGDJfUBDwX6Fg/
        SZJUKgwvJLuoq5HLSWHaZE/shhqGxat5BRy+pCYQDMRvuvLJmdoQH/6MP50eOfOz
        SjHdgHAk0u9d33LAvKks7VDK2k5OuHnn91qOc6GwYJQCJzDfWiwQS1GO/LFXJv9x
        6/M2vrc/noUk8HtjJHFh3abFHPFNWcA4WUI6uKu0edAKXK73uQs0/KZYcV2fUCfW
        KIjTMoR+c3tyVx2FEZv0RbOL5RDqdIl2cg0EyANEPzuINmft9iz4hCIFHgClNyUK
        g==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3run8adcjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Jul 2023 05:49:49 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 22:49:48 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.1.11) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 22:49:46 -0700
From:   <xiongwei.song@windriver.com>
To:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <corbet@lwn.net>
CC:     <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] docs: cgroup-v1: correct the term of Page Cache organization in inode
Date:   Fri, 21 Jul 2023 13:49:37 +0800
Message-ID: <20230721054938.1666475-1-xiongwei.song@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: bySpQadOfK_eOMn0m_uI2mgwQQfnU01d
X-Proofpoint-ORIG-GUID: bySpQadOfK_eOMn0m_uI2mgwQQfnU01d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_02,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=908 clxscore=1011 adultscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2307210052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Xiongwei Song <xiongwei.song@windriver.com>

The radix-tree for Page Cache has been replaced with xarray, see
commit eb797a8ee0ab ("page cache: Rearrange address_space"), so move
"radix-tree" to "xarray".

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 47d1d7d932a8..dcb65b49bb22 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -197,11 +197,11 @@ are not accounted. We just account pages under usual VM management.
 
 RSS pages are accounted at page_fault unless they've already been accounted
 for earlier. A file page will be accounted for as Page Cache when it's
-inserted into inode (radix-tree). While it's mapped into the page tables of
+inserted into inode (xarray). While it's mapped into the page tables of
 processes, duplicate accounting is carefully avoided.
 
 An RSS page is unaccounted when it's fully unmapped. A PageCache page is
-unaccounted when it's removed from radix-tree. Even if RSS pages are fully
+unaccounted when it's removed from xarray. Even if RSS pages are fully
 unmapped (by kswapd), they may exist as SwapCache in the system until they
 are really freed. Such SwapCaches are also accounted.
 A swapped-in page is accounted after adding into swapcache.
-- 
2.25.1

