Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C7B75BE04
	for <lists+cgroups@lfdr.de>; Fri, 21 Jul 2023 07:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGUFvv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jul 2023 01:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjGUFvO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jul 2023 01:51:14 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3869E358B;
        Thu, 20 Jul 2023 22:50:23 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36L4vQBf022133;
        Thu, 20 Jul 2023 22:49:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PPS06212021; bh=Y7PvSi6Jz/OCrGdAUcZr7M636MU29kh116d0H+MDGEA=; b=
        I/d6EqMCqjTlA3ovVY1WGqsspYwCRtaZhLkhDBq8WSwd0vGxGzQu9lO5CUI3tF1m
        BxiJAJJmgH2wV3SFz4SID/lf6dftuaM5Fmf8v1JUgtHYcicH13ht1o9l+AR7zsOh
        JkveqU1yZt962/Zi3X8xFRBqEGAOlaGEJQuhLF1vapFwjFr8vhyxKPz0f/x1eADz
        PRl0NqCivIJgf8Ydg/SEcR4FP2pNeT+LmjA2+oFFK/clrWSBSB+oVGlG1AyJdyrr
        nWOz2uDgcb4sdgEZdf2z5Wqlm8nSNTYrOR84ZrSbic2QxaaTdVj9n23Oj1rCMzSI
        df7/qKoCVbgm9llOAcfisA==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3rutyew7nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 20 Jul 2023 22:49:51 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 22:49:50 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.1.11) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 22:49:48 -0700
From:   <xiongwei.song@windriver.com>
To:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <corbet@lwn.net>
CC:     <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] docs: cgroup-v1: fix typo
Date:   Fri, 21 Jul 2023 13:49:38 +0800
Message-ID: <20230721054938.1666475-2-xiongwei.song@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721054938.1666475-1-xiongwei.song@windriver.com>
References: <20230721054938.1666475-1-xiongwei.song@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: aX545k4kvfVlBYJA-4_x8SnITXLLpFMz
X-Proofpoint-GUID: aX545k4kvfVlBYJA-4_x8SnITXLLpFMz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_02,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=635 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2306200000
 definitions=main-2307210052
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

"listers" -> "listeners"

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index dcb65b49bb22..1f239fa938c2 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -909,7 +909,7 @@ experiences some pressure. In this situation, only group C will receive the
 notification, i.e. groups A and B will not receive it. This is done to avoid
 excessive "broadcasting" of messages, which disturbs the system and which is
 especially bad if we are low on memory or thrashing. Group B, will receive
-notification only if there are no event listers for group C.
+notification only if there are no event listeners for group C.
 
 There are three optional modes that specify different propagation behavior:
 
-- 
2.25.1

