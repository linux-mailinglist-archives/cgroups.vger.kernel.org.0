Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21CE7BB6F1
	for <lists+cgroups@lfdr.de>; Fri,  6 Oct 2023 13:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjJFLva (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Oct 2023 07:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjJFLv3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Oct 2023 07:51:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02327C5;
        Fri,  6 Oct 2023 04:51:25 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3969DvTx015058;
        Fri, 6 Oct 2023 11:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=c/+qaoyryYIy1wZAUF7Dj6jQ22EXFhLlqtq2idJNKhk=;
 b=rDCxaVm+dAoqTAvmX/IPJ4WA2gUcpLJJRSCnkWNWjwAWZwycxrWAhm7L8J3q7HkhREoy
 Ih5VX7WCYHXUMZIvAZLXhdXqH5u0JnJQfJflsnr28MRc7fkixSU7USwkk+/p+CQkdIRQ
 EM+LOFePgsckC4fELPetpcPUtKnmDYUuuYOWFiJms8x/Tl85l4WuZjQrXgjDZ0Di5vKA
 UXvFkYPIpxvR34Mue0YTRCtTCxag+IPYvynRyQcYpc7wtM66Dm4iFA50u5wKjFblKp4Z
 AGsRh3P3S9npCxIWa3qXSsBLrfFH9fWXU5Wt7ZceQQio+nvOB1ROcEoHVXdksUPOMr7Q pg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teaf4bqw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 11:51:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3969gMfb008659;
        Fri, 6 Oct 2023 11:51:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4b2eu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 11:51:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ng+GvJLM0TvMa94NmF7cvoe4da6QWQLufjPy4RQcC7e3wbdNXfepXFieZ+X3FlanfK3tj/+98bXuk1y3oNZQDAQnrLS1y4D5fSYmJ0OZgdky7OCNebFJXlE9PhGS5Gx9gwXohtGGVrox7Dhy9AOg7zDE/f9cWrG2Nr/q5ZNAuZj15X1QJHFamfvoYLmpjt/ll4WMDGMbvkOichAPl+dLthbL/6LoRUYrUXjD/NfWt6XVggr7zEbY81cEaCtiLA//wvnSov2UGLNXQTDBhpJWOG1B6+p9p2A4a+utnmebClkdTCrt9+UKXskmsJp6ia99LI8P7lvhuCVI3qSvkK9SpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/+qaoyryYIy1wZAUF7Dj6jQ22EXFhLlqtq2idJNKhk=;
 b=UIuyaIx6NMw70tEXxz9y6LXlB1fA/oF+LLCQhCvwQCS8D/EiWoz+vaVpEmPkxte0oG98ITU1pNJaMcVUIkja4cszoYDTjSyoTCa7Ua4CRM42/mbeX78Cvf2QHxGkZbednnUZBgwrvEj6SHloTONRulxvIunoDGpB72nnSzcc0MfRg7yxfNivattFX5ocnM+kVj7rCM1MHqGHtYRa5mTccSjydGJ9ZILBC/YnL59WQn4TZCW3UN7mtPpe4+ZE/Dcuzxi8pgnwDg/RkKUJwpxm6KSFJHv4by4XqqSbDe0iTb4Ca9HHUyaujC25BpKHgb6MK1mQyfkHj8LPal0gysEgjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/+qaoyryYIy1wZAUF7Dj6jQ22EXFhLlqtq2idJNKhk=;
 b=DDe0ftkS4zsqQP56INekaFpp2G4woLFVIJ4YnZcSUG1eMgTLdJUPbUlSe4Fcdv9zRwNbHaJsbIt8gUS9kW2KC41WlQ1drn+gzM1IdC30x3jsULht2dE32EnfqQeds6QUcu6YDufT1M5k5GpHkBD5wtdL6EN1ZbXpHSD5IWvppFY=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 MW4PR10MB5884.namprd10.prod.outlook.com (2603:10b6:303:180::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.23; Fri, 6 Oct
 2023 11:51:07 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::3c2a:5677:55fa:2d36]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::3c2a:5677:55fa:2d36%7]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 11:51:07 +0000
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tom Hromatka <tom.hromatka@oracle.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] cgroup: use legacy_name for cgroup v1 disable info
Date:   Fri,  6 Oct 2023 17:20:32 +0530
Message-ID: <20231006115034.86615-1-kamalesh.babulal@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::8) To DM6PR10MB3001.namprd10.prod.outlook.com
 (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3001:EE_|MW4PR10MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c95bad-57b1-490e-7afa-08dbc6628651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G6b8hZI7JmG3RNITVquW/dnfztyn7K7F1HxvnuN1f+qrArmS1/AT9yYN8JEYtEu1t50YA7+1UOqzJX4cfq6Mncn5xcVX5f14mXdXxJKp0EX0OX0ui9MQVwX9rqGb4QQI7MyVMwBy9hrGg9DanWRzdJc97HzpYdQtcCtlzCH/NMW/SpmFMR0Yfav/964PZNJqZvsRJhZHgUyopCvLMoELDn/ahFS3csdZoFxjZdaY3Frb0PKbR/t3TJWWhsUlBmcvsiKVHoOER2wX7zshEhLq1FiSFH4YlIO13MitMlsA7UsQsJ2pzjow+pkvOav3Ww+r7RbxOG5sQEKz/0SfAEWPfz8xuCube+rfxR8TlCs2RJmagx7c7lXyTpK7tYO2iBzUe4bHL0DkfyaoCJ/8JcHgaLItwPT18jv+r1bdDA7fp3PY3QEQRwZv9Kv6XBIa4elsIEJP3bdwtE72OKABoyGhsqBjIeKJaIYlJQB5Jfel1uPxi6dZPEvaLzUa4GOcNIp+OzrJ94qBKG8Plq+uN68RzacxVTQtfr6UTS9xOjgyrevUCBEY3CsNI22vGgXnzoq0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6506007)(6666004)(478600001)(6486002)(6512007)(2616005)(1076003)(2906002)(316002)(41300700001)(110136005)(66476007)(66556008)(66946007)(44832011)(5660300002)(8676002)(8936002)(4326008)(36756003)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CZHu6ZJK5Sh6Ec+UX+lkBo+TVjhgYCIE4rhzGioKIAgTAgFZRM3hO5Ajcy7u?=
 =?us-ascii?Q?30oc38p33o9U9mJqt3WURDNra05B4qzFjIGS8Ruh9tVLi2Pfauqtr7usgHXu?=
 =?us-ascii?Q?0W242J+za18fMv2Tr5P3X2jY4NKJJjFlA3EENJ+gvrrnv1utSwQehmiOARB0?=
 =?us-ascii?Q?cBj8vYOm5OT9vdlhR8gDrnkRjmXMNXC0H0L47q+qg3W8kR2c+2OC71Z40SeU?=
 =?us-ascii?Q?urYfVPi9om3eB9XqxHZoGCBKiU9uZDe6vV5mUC72hiEE6Q5oAG6pMKSSHYLM?=
 =?us-ascii?Q?MLfzvsUW322fT42IVRrAAyNhTloXCCAl6xnD2mxgY3eAUloLjseK3Fn0LaVT?=
 =?us-ascii?Q?m52WR8wSPnDA5PJtgyZeQiLQcXLOQ+BWtdids+89ydGi6U+Y5oedRH3pQoPf?=
 =?us-ascii?Q?M0uB4snYokT2tWDS8MHPeFDpsCpGredIiK8xLO2TZ0XKKgswLolSfBt0omwb?=
 =?us-ascii?Q?bykVUi4INbzZg+S3jf7+bujkhtMqskxw7rQHronbrWmYAhk7CK2J9bnLR3Vo?=
 =?us-ascii?Q?ZpOYQtbRS8YSMSKOIHPUq90+QLoLmWommzc/r5HPOx9ur/fvdOcG7GYTXjoR?=
 =?us-ascii?Q?ApPPQNPmQ7bvDONN1MzioUPa5xrP/P/u0ffh4vGcBNn485K/Vz71Rm6Zmly+?=
 =?us-ascii?Q?3FZ6nPoWCig14n7bWtbNCqM6BByto5zjOJ0A6JQDyDS9FIWup9gQ/1Z8b+8V?=
 =?us-ascii?Q?DV3qhpyP52Jqv2MJAv6xCHxzHFmfzhrUZLMghAxyLBJTZsXJHjGNirSK9R8K?=
 =?us-ascii?Q?TyR2liF7u/XMnTlMVGrAAdSuFqNFdfBHtnoqG5xucsuno1wJJViwpkCVAQfM?=
 =?us-ascii?Q?dviA0/iMpQ5lGroVv5nWipmudqeg88eE34JrNPHpS8gLIrlfVFcVRA3C5L8V?=
 =?us-ascii?Q?Nt5eYgxGEk3CXE9lkq9XxUx2+xv4roHXXqtKY2810pWNA7pvTNIwgPw0L17V?=
 =?us-ascii?Q?O/aby1q7GbUXLp8G3V6IOOuKyMrAXdQdWdkvfpNCaJRREF7UAleQP4A1fV7v?=
 =?us-ascii?Q?HkLTaPjszsAANEzdCzfewIEwKugXw+L1y849sjezjrXUTqDSc0SIDKh3iR7q?=
 =?us-ascii?Q?RUXJYlSyuojVFeDMtFq7TRm84sO59v8gICGsT1hy6n1LkJ3gW4n97TBT3Y8x?=
 =?us-ascii?Q?TLetJSYuwo0uecPFFIzItZxsqVUv/4D1twhSYS8/LxvAkPq7jwtK0OfrBCtY?=
 =?us-ascii?Q?08DtKF0b027VS3ToHSXkMzv079GiFL73DeNgf0Ne1s1uqIk2KvP9aYcrXUYm?=
 =?us-ascii?Q?G3J+J4Da4FWDzZDViao1i1aJWw/WTzDrLOyXXThdH2wmNB6iLTzUlzuK5J0B?=
 =?us-ascii?Q?mwrOGGYRGSb6/RuMFIyZY0VabF/IU1lun0nwZjih95M3qS4G61T+f98JQ71i?=
 =?us-ascii?Q?DClYxVYvrpY9Jot+W4QG4LWSCmavmKbw4OxXOnVliQ/Ip5mu2Pw9/yOzr5D7?=
 =?us-ascii?Q?VfopZWOSx3IuK+WCuvy4qdsKMQvCnlFNRLXbcnYwXkIiiD9lg/3ExL5yRPIZ?=
 =?us-ascii?Q?23Vk9VLmvtbp8xf6p4IEHsouW30XNon+mpFyk0bw6vCVNwMJL31REyKYxS6s?=
 =?us-ascii?Q?Op7H+G2i77KqrfGmwTH+PUPpx/oRUGkcGd9I4aBaDmMLoZeTWE2Tt/wyza7v?=
 =?us-ascii?Q?iSJGdjOyDLzHWrr5eHIt13ebMVlAnvbJGrNfaWDJ2OGAFtDzhTjQUP2VnkqN?=
 =?us-ascii?Q?FrZx/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cvOwA2oi7e7YtstMSjLKLeBOClEeswmUaqb4S27Q8cIBEv5OHHVLimep01oNkxVVGL7zQYGCOKdgKU3ehNcK+h2MVBwT/hRmryljekW2Q+ZsvIqUT4JLpHTht9A4eN3Qr4q7bzZZp4G1vnIcerXiWtjFAL5PKDRRf3VsiL6NwsVsMYWdSS0vwwA/2URVdQKk6oreY6sl0PEFEgn2JEcnjOpDW3XMgOvbA/IlFICOi3u+5afGZEI6UAFKBO9oM84cv7DDA7vrSK0F9l6NeVdIjinAd+kCyQGx6Qgbhk2KqAithNHlFcH3DHSh4bYTQ/7RDi+yxfiGlnP4O69b9PCY5+QiOzJAT0m9x7d8jOLxyIOllngEIhb0lsl+5NSryC/SFSoWsEgbL2BUUWoyO2dkkmsbaps+ogkcjCUdkEMYwelXI6irNdsPHjfnUJxRZzfFFr4Lk5InGboOd1S2ufZ5oMRr7xA6gpfE6rGvgBPyW/HbYcxZXSdADaOvqgdu/Z/Azcjcbha7g72fmMM7GBDZYB1SkRP/FvNf64HkVa5AISdOe5nsqDvoWcMCcDN8rVHsoN9G0VWJj8fkrLaY1iwOcG1h9vc3rVUTrn1vCxFblHMhNPKs8LYc3nRLrRdtx4+R7vGTjTZqKKX+AmaxLz+30tZCqq56c4mJGNgasWLfTGyk6aX75yci9VGx0YBpbTGmTl0ZWDbvUOqXv7Qldl7mON8sywibU88XyNFWQgg6eGy7A9jfmZaRxQhUMG7GCMsGVAm4BcZpDJIK2YnLXwojHv/U4MxSVkaGvRkSfd20FQkBLN4xwgIH+5R58GwksCVaDuCLUbBYUneqgvac0P30HB4AA2Cm11jeKshoOp2dyXE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c95bad-57b1-490e-7afa-08dbc6628651
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 11:51:07.0041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6bwTKJ6wlWht4+3EWUHw94UwRgwxlX7XPUojVMmrPwL4xmuPXP0r1adsya4OagjwmRFrsccHVdPWC5LGc7RPgajTPvjmCO/J/xtFk4MBI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_09,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060087
X-Proofpoint-GUID: qdTZ8gNLaeepLD28vq7mwUaV9Gyk6Cvr
X-Proofpoint-ORIG-GUID: qdTZ8gNLaeepLD28vq7mwUaV9Gyk6Cvr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cgroup v1 or v2 or both controller names can be passed as arguments to
the 'cgroup_no_v1' kernel parameter, though most of the controller's
names are the same for both cgroup versions. This can be confusing when
both versions are used interchangeably, i.e., passing cgroup_no_v1=io

$ sudo dmesg |grep cgroup
...
cgroup: Disabling io control group subsystem in v1 mounts
cgroup: Disabled controller 'blkio'

Make it consistent across the pr_info()'s, by using ss->legacy_name, as
the subsystem name, while printing the cgroup v1 controller disabling
information in cgroup_init().

Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
---
v2 changes:
- Dropped the subsys name comparison with ss->legacy_name only while
  parsing cgroup_no_v1 cmdline
- Adapt the commit subject to match the partial change

 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1fb7f562289d..622fb53a806b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6121,7 +6121,7 @@ int __init cgroup_init(void)
 
 		if (cgroup1_ssid_disabled(ssid))
 			pr_info("Disabling %s control group subsystem in v1 mounts\n",
-				ss->name);
+				ss->legacy_name);
 
 		cgrp_dfl_root.subsys_mask |= 1 << ss->id;
 

base-commit: b78b18fb8ee19f7a05f20c3abc865b3bfe182884
-- 
2.41.0

