Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1437579C7A1
	for <lists+cgroups@lfdr.de>; Tue, 12 Sep 2023 09:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjILHFe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Sep 2023 03:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjILHFb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Sep 2023 03:05:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE299B;
        Tue, 12 Sep 2023 00:05:26 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BJSOAl028444;
        Tue, 12 Sep 2023 07:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=1b8I90tAdz+bE6JZJ/5tIQJobWNFIwRGJFQzIURIWZ8=;
 b=mu8EXXGXnMounHiTfobQeETY3J9A6KgAubU6jPqiBGRyDNnyQmmC6esXq18xPQDnG/KU
 KS9R+g6N9HrKnHECuz1Z7cnZb/f7vSo+PzoY697afD0H7vavh0Nb/jV9igoth/Eta/c5
 yPvDa+dx6mkq2M23YtALEZPydH9NX6qnwY7CRz66T1z3Rxs/w/392CbLLS+oFaT52YYz
 vBkX5Cfl7xYSYuWRq02Esc0oV/7KK673qRCP0cpZfjswDF1BCJX1SWLB1+jE46WJUg4O
 oT1ekhRNQFik9aSaBMKll0XhgHuRCOKAXbSY4cnRE5omDyGXzXdEtZcDXRt+E5McRmmY qQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jp7b806-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 07:05:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38C5Fg81004375;
        Tue, 12 Sep 2023 07:05:11 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5636g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 07:05:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R72GyMiHnwM1w0PlyNZGelCwSReM6Yy3WTg2zq3aqlkPPp4xKQj85X0OG16cfiVl0kXXKRevoGHltqzWOqekMa5sQbP2Z1AjO1wq9rK//cqO8ikqjESZq2DW8YNlVQC4UOZZ4zOy8DA+xP+lrL0Rv1I+GmYV/yTWvdHoPRnTTqVYcXbm9dSi0r1waHaY8wor20zJqx6GH1XbC4fch+nYM2UExM3OeJ7aVSHwE3wgVMLupqD6MdpLXOV2ybrIFdj6Pp1s+w18hCjg7ZPRPMPfWvSjdeG4z5evXrduB3Y9plrPiVx/Y9F64djlCL/XFYXm3OSalFqwPcj4PINN1o/E2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1b8I90tAdz+bE6JZJ/5tIQJobWNFIwRGJFQzIURIWZ8=;
 b=m5vkwXzda57PutSNSuhSWRaMnrU3A3xyDL9/uYGCWqfKQk0qJhLu77lDiY44lxi0ofiQ/p9PIvDhOIOxCJKHwOaB1K1QSruFAtBlTHY2xLcBEnkSwmT+D5G/2qzTdYNUuZWf/zRnCM6UQBPM8cQnJV/qVE7aSRJnx8nZea2VwZOhYuOxoJdZtuEbRXdiO+CpaTO1o19ZAqKyFb9IVS5xvkYeWt7a1GGqRE+JyA9kxDdnPLAecJs/WFRnJnuBUjB9rx2IS9nA81aePPLUAvGSL2XbF9hGcnZhqGO+pFMUloPj94tQp0IHOa0vrRb34Fl8MH0BsgaBE/v5bxSgFc7SKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1b8I90tAdz+bE6JZJ/5tIQJobWNFIwRGJFQzIURIWZ8=;
 b=D8Ei0jItgRhTL5P/z7Crw9FRkx7JUTOE1ZXS+LUwxenHAfTuqfND0na1pEGImEejob9zjRuUuJHZRpUXw2/2ey2aARDvZOs9X4VWNlQecQuvrFCBLKNRrauwz7Nn8D8Bs0oD8CTKRLC1vEZxvNGxbYLHqONJv0mgTAZJT3NGDFM=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 CH3PR10MB6689.namprd10.prod.outlook.com (2603:10b6:610:153::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 07:05:09 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::3c2a:5677:55fa:2d36]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::3c2a:5677:55fa:2d36%7]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 07:05:09 +0000
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tom Hromatka <tom.hromatka@oracle.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cgroup: Avoid extra dereference in css_populate_dir()
Date:   Tue, 12 Sep 2023 12:34:35 +0530
Message-ID: <5870fc2459d97b2e47c5a8dc47f1a2a3837c5e03.1694501024.git.kamalesh.babulal@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <96694dfc5f4caf4d84a740c3b18b0a456c9ff522.1694501024.git.kamalesh.babulal@oracle.com>
References: <96694dfc5f4caf4d84a740c3b18b0a456c9ff522.1694501024.git.kamalesh.babulal@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::11) To DM6PR10MB3001.namprd10.prod.outlook.com
 (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3001:EE_|CH3PR10MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 197d33f3-9074-4bc4-6dd6-08dbb35e99ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jiq7fUoT/iilzomZTKko8Xqd7jo3sUr7OX6igufTiDV7CEmqVq5NBhw6GPmIr+uMhVtjkairuhehwEiNOUWo5Ox8T5fH+fnN3IMLv1bOMOYOubfaAXxcLuqa3Gdia24XBCOsYs5VCaM9RT/bXJEGmaTrqDyfTsKfpnVzkSezLPWnHe7jIexr/GPhahowOx/ZeeisQCoOagBTXFyWPPWarrf8icuGm0ktSvH16C93uOFgOo9yHRYdANR3DKbeGgqKJy8Nb/9dJ2xPwGvR+0ArdzGb62xp0+3rZVKFCMYrpD3/qmvZmPLb3cJ7DmlI0+cjySFGdsb0hm3Bxg6RmCMr9bpyc4iC8yKKivAMcRRmW25Ntb3txVOoeDKxXUFdWpRGj6n4sac4zt72CcBUtAA6fTc9YWeiCDX5BIt5UO4iel7IStLKdM39/M2V0TZzG2c7MjyvqipbmXCQde+MsBGAFotgUtYza5GIAxT4xNl/D89eItBJsLDfUYcyRsO2g5remNQuijDBpnmLu2R+8DAJfKRSPQjReCbCDHupqRqKKTxDMoqBfhy6mlN8hpfImIjF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199024)(186009)(1800799009)(41300700001)(5660300002)(38100700002)(6666004)(6512007)(478600001)(83380400001)(2906002)(6506007)(6486002)(2616005)(66556008)(66946007)(44832011)(66476007)(86362001)(316002)(110136005)(36756003)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+37z2nvEMD5/8X2fEzhwCQFQ37zjvfFa0KoLhzJQL4aQBP+k0ktJP0ByGgUp?=
 =?us-ascii?Q?MXHz6MJKS0Ve+a+O4Bbhw7R8r08nvy1tLCD7Uh+sabGlzVT3i1oOHeSZ8ATk?=
 =?us-ascii?Q?HZAUR38nSZgYuAabptlVtR3fCFIzRwXLdoBA+Q6ThK64BeVxG/C+lqZsEVRj?=
 =?us-ascii?Q?IVWwipBiLHn6/1/iEtRchBT4dtO6L672jXCk+joia7PD/K9cdiUqSXN5VpBS?=
 =?us-ascii?Q?ToxZ4vHQQpH2l350SRW+AZvM5LYS1iCxSXmZR9U+7NSgfxtt5XsPaYzOsdN+?=
 =?us-ascii?Q?4L1aHE7ujiu5JSjvQcsi+4IQ0/tvDA2FKcCFcpjjUUmbUDCVhjMjdfK7LKcg?=
 =?us-ascii?Q?lDVe49IOmSD2hszAxJVpORwcK4wfWVJwAd53kIRWH7ZYmkoAMYvLfpunLkFa?=
 =?us-ascii?Q?VPNNkzWM+0Jinykt7MeIS9CDirS4KNzZH7oa0pytf+uYeLqWHCpW/lpwIDWL?=
 =?us-ascii?Q?hjM0fM0hELNGFZRj3rn63gexMuxc7atfWeoQwC3Ly8nA6yi1n8IdenMOZxJa?=
 =?us-ascii?Q?0pwt64IklVgKdsUKXuU9gD7cctdsnWOyzwyvQNJn0NyD/Gcz087hZRuUjusf?=
 =?us-ascii?Q?Cxn+mppoARJmkU7CPNnZatcHfkDItFoKNI2mfrMH/l3okybqiU1rE4+KScQI?=
 =?us-ascii?Q?6ZmKvkFwJyE+saOW9OxSnQ2+5dat++SYzZ2wdYd50D+9/EQe4vN5w784yQ3O?=
 =?us-ascii?Q?nJXdVmznwLT8mOLGIKqXqhAk69JODFyhL+uGPD6TwA8XxINbk2+KdoQcUgaQ?=
 =?us-ascii?Q?kok2DDMaTLflu6u0XFzo2YvHvGhncJ+1Q7SDvX5x4OUBeQNAkND0LUdbPiyj?=
 =?us-ascii?Q?OFZJYu3vzJ6HQnNX2SAwe7hkT/giXU4h9oQkxnQOWXnmAUz+Lfo2g2vRMisI?=
 =?us-ascii?Q?nGe9eJoyChd2m3/qkLmgnPRCueoHoZvja8q+3s6pJhBdO4G7JLhFobZaPGnJ?=
 =?us-ascii?Q?wrNCw/7SDMkK0funsYQ5U3NWNGw5g6eCFgDPJHUKJgwZYnhVDCVKohtXu+mF?=
 =?us-ascii?Q?B12OdwOfVByOU5L66lCcm4IyYHRjhqmJeGFT3Bb04yiliLQf1f+2F4WvFjom?=
 =?us-ascii?Q?v4a32hXd8Ouj8R5nEDm7GQFebtw3nlz5XVn+Qk+h31p1aSje340XZGpyNwbN?=
 =?us-ascii?Q?gtAqZMA3cBA4KYBQcX+3nktPc7NWEwAfRtuXmxSN38w2IuhWsXOAvN5qecxR?=
 =?us-ascii?Q?a0ZohLqskkX4S+kQ14gwz0JsOJ8snfCDmMDoFTNExwMR+v4x9Z8mb/a5HKvr?=
 =?us-ascii?Q?eiq8YCD/pUww7jDman9EkSb9Enje9BZZ/JNc1clwkA8WrUwM3t4ctb6fVpQE?=
 =?us-ascii?Q?27SGL8X/QOtIhiHKGpD+0xNkkY722X/o5w/xid8XzyNUTRMf0jlOzqKGtrbT?=
 =?us-ascii?Q?YCt+5esGm3Gutr1OMejej5MhLrd53+HNzy0NCb568X/yyPWSAKd444NJrXPp?=
 =?us-ascii?Q?Eb0zZOveQncXJyrctjHnc346Qzy7xKHaDN3lqDxy1cP1u/qpBvtywlwoJrQo?=
 =?us-ascii?Q?qUSWkVeOLPYFbmRYXZGifYYrFRyTaAIJ2ChMFGske9g2468xpIHm/G2nntqi?=
 =?us-ascii?Q?80XkqVPhK/EWHEWV2LRx58keSy5TUfjsqslphFHuYHysdGqA3QDO61nLFm9p?=
 =?us-ascii?Q?ZSJO8jjcPNGFLKS3UOe+3+DZ6sfhQbAyySqHI+ydsYxKV5MQrRJFdeSl4D/V?=
 =?us-ascii?Q?x7WDbQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2i/ofW1SxHZFOlpcNT7Ge65XxzLWKZyXn/bEJFBJv66zO/RB6f+Ie0lvM8iDCXR6fs6xbCR3SriPMrhEGJxQUxSEILnx7xLOvrtwurmgQtkyedxLEvqexiJh8iPDnlObmu6KdlC1z3hiAWUZOeuxVZAATMFFarNeGU7Qfg63miR4EfhFWRZVhjWx0f8Xl9oue7Id3N6HAioefSLQJ1yuCvuVfe3+LXOuww4gpPfLzDdgv1WwfNutHjSo5opQBWLqhZ5SVvBCgfR0Rsojm7y2lSpu+2pIe1S8tlL4/iGVJxfHMLTKZtGn5PfHaag0/QE7EpuKYyOip0GlyyrKLdVifBhbY54spwXenY+dHne9fYXTegLMdClHSlOcUXirEwtNmKlzGi8LtsCQ/nl9MaJoXfoGNQvoGhz0QE0hkEGCNz2nWwIeTGlRYui8DWarMG2pX6f+KMdGxxYQM2LhfYCfjFTRdA6U91AV4nr64j1NJNHRTLL4tPkgK6yDV/jzMbV8vGMFwXNqErW3m6rceCNCHlDJSjt3ipsshBaWxbQQLLCgo96EkJqOqevNHJ5hTGGrhH8CXhTNlakSYeGq+fSSPz0YMRVh6zbmeNzVAbt8kUjK2hyPeQj58wyGBXn0Y40RlcEi/fPYXx8gBnGKoZtC+oIogBs9/r/We+dzMEy4FlLZd3HnzHbdbVKILVhWsd747AIk0MPcOmWLBd4WWHCwZ2nibdFWNs9StikfWD6rtoHwSj9l3ImjRBMaEG881T/kxWlbXCOAG04nZnHshKjB73jT6PSce3yrBdHO9NB5R3o4A2tb1SNB2LJGqNPGTyZNERgesmY4TwWyQzXzbXGz9dWsPtrkrZeUFq2ywy9Lmtc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 197d33f3-9074-4bc4-6dd6-08dbb35e99ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 07:05:09.4806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8m/8fUv8MXG1Ta0a333OcT4oEyFhb0QBIKgJOCzsuBS0w5x6Astmpp60v+v2pSAjwRGuzUFSzzzcnX2o6U9rCrshitXDOc5tHwptPcgcnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_04,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=862 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309120059
X-Proofpoint-GUID: FQXGoZ8vA68ldli-vK952ASrNNx--xGB
X-Proofpoint-ORIG-GUID: FQXGoZ8vA68ldli-vK952ASrNNx--xGB
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Use css directly instead of dereferencing it from &cgroup->self, while
adding the cgroup v2 cft base and psi files in css_populate_dir(). Both
points to the same css, when css->ss is NULL, this avoids extra deferences
and makes code consistent in usage across the function.

Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
---
 kernel/cgroup/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a6b1ea324b0e..f8ff85033e5a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1719,13 +1719,13 @@ static int css_populate_dir(struct cgroup_subsys_state *css)
 
 	if (!css->ss) {
 		if (cgroup_on_dfl(cgrp)) {
-			ret = cgroup_addrm_files(&cgrp->self, cgrp,
+			ret = cgroup_addrm_files(css, cgrp,
 						 cgroup_base_files, true);
 			if (ret < 0)
 				return ret;
 
 			if (cgroup_psi_enabled()) {
-				ret = cgroup_addrm_files(&cgrp->self, cgrp,
+				ret = cgroup_addrm_files(css, cgrp,
 							 cgroup_psi_files, true);
 				if (ret < 0)
 					return ret;
-- 
2.41.0

