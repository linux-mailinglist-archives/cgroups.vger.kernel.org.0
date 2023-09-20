Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B2F7A7920
	for <lists+cgroups@lfdr.de>; Wed, 20 Sep 2023 12:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjITKZ7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Sep 2023 06:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbjITKZ5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Sep 2023 06:25:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6F094;
        Wed, 20 Sep 2023 03:25:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K9scb8003332;
        Wed, 20 Sep 2023 10:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=GW/xaIA28aFiYyj+ym8GGUaoHZAoEuUh24wEEtr7hJg=;
 b=YuU26mMnldm9oF+jpINcGFsWbgWMzoVEmDmrnl4248HeBKZdaaNv9TwIf1SOEw+NDImH
 WkmqbTOPs42Yr+vlBlL4v2POcWq7G5kDI2sskRTSHmbEv8gJs1721qVcEuDWwpseR3gv
 CanVBKwbeYLfJtC/5SYeI9zAeZG9s0dhRxFc0Lc5tCvdjTv2bzROU870bxQT78adeTTY
 i+hugyILHBZlzOZiukqlgwdtUbg/wMMN4XQkpsFkP8MCxdqvk8xBZlJC8sDZ4Y8Vevar
 cvcNcSw0g4z1wkVYtJrDMY3cdm/JitkuDEbWoRPBVgpuJBdyG+ThALbpWgssefk+E/kb Mw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t54wupx8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 10:25:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38K8S6TV002067;
        Wed, 20 Sep 2023 10:25:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t6n6y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 10:25:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koI6KrcfCggFRWFak+g27ZaU7W+z7Gn1V0nhw2HECqmGogC4Wj5PwGpfFMR7ix8qDS9g1ChIWYk5AlTJjLJdM48SkL1183PXdlVKAcCAU1jsIP/vgdRgQQcDHVm7McKT6uZSOn/knZCtnyx7FYQ78aZ9Ke4/w0oROgEE97QIh5em5Utj5kU2tyqxTP+aSrhWdlhextsPbzAuZgf54YBiJqFaJ5JwNKTa3JtBlT80iCag3yL3tj21OL0E5LR4tCSWitXXwLLbWVMcVnxiwAAn++65RVq4hx5TolfW8a/nOR3RNkhjIRvSpS6smECFO8jcIz60Blzyx86/dnqxx+tBvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GW/xaIA28aFiYyj+ym8GGUaoHZAoEuUh24wEEtr7hJg=;
 b=c4fPriwWbgv+89kLaT2gJTeV8WXQ2GcUKQMGEtLzVBYuGpp6DaKyhjBemRBAFPFJC0Tlv/MHonScPrKS6igkNI5FHzJhdg3KsNoApMDwkq89Dc52MWjVJx39XpTlSRDfIZeNgtfYO8q/fCPLfsM5bu9uWt47ydvKTE59RwVa2weC6jAy+l5bOE1TbwGugofUIOKpifucZFspKHftOBkYhNYXIYa85hqjO6RCmfRvxAell1uzaiT125wtMhu0G3WwlycmAfbFWhB89z9rEAPB2OqcbyByYStMqiqjd4ivOfD7tXbNkuMpS6kL6JQDh1+76NF0x+3inLByD+2d6LVM0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GW/xaIA28aFiYyj+ym8GGUaoHZAoEuUh24wEEtr7hJg=;
 b=QXR/0xDgo19ARZsy8feSqjx8s8qFTumCbJLAnWj5hxHpHSdm/ve2KpaSprpI6DE8DBN1MAoq9K3HPY2SsEi4UhM0YW+wuyGn5Np9XVTlIEtoP4/leT9bqweCqy/MUi0td+Z7cPG8EKCiX0xp+6Ia9lwm5GlKM3WJLimKO/cmQPU=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 CO1PR10MB4740.namprd10.prod.outlook.com (2603:10b6:303:9d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.28; Wed, 20 Sep 2023 10:25:24 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::3c2a:5677:55fa:2d36]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::3c2a:5677:55fa:2d36%7]) with mapi id 15.20.6813.017; Wed, 20 Sep 2023
 10:25:23 +0000
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tom Hromatka <tom.hromatka@oracle.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cgroup: In cgroup_no_v1() check v1 controllers only
Date:   Wed, 20 Sep 2023 15:55:12 +0530
Message-ID: <20230920102513.55772-1-kamalesh.babulal@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::10) To DM6PR10MB3001.namprd10.prod.outlook.com
 (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3001:EE_|CO1PR10MB4740:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d69b189-9663-48ce-af6e-08dbb9c3e64a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: utD19BGE1CrIPHXv/Z4ZY12DJyTcOkeDlzCzbV5/rEssYzQhvpblGU3gZ7nKvA9gEhYVdvuPohxD16xOQJVusRwHr+QkTzA7xCGBcmJ2t/CgfeIgFi8QOwasuUkWX30OJeBYiDem/6ltOu2hqRYLvs737eHvMp+maqmMi0Z0+v1Qzfyj2dvvJQlrJUH7T7lcaWAi5EcPvovVu/5SChy3S81QAkEVmfLc3/VaIBuhG/Gbtivzu/6MW2Gh00YrHiB0RlycjCsj8K40dxAqwuTP5jDol30hN/hqvVUPOrpen6lf4KxALOKNx/jjmfOpJXmSvytlL8Ar0iyFQHDQYXr3km7cquZHAKX8nWrMzOf5RAOh4TFVVN8iCVxypu/v42muh9Tc1mBTnqxyRnOsmEK/uT4HRfNcc4YncrSXNRToFEfBa8Rbw3st89eGWcO9ufhsfc3hsP2JgHhULodSS3uFtOEG4kRdFCcg5YWciTd9IfFN0oIMrMUEUb/hkRlUbzseC97hSmAyXW6ZHQ/IRTX5gWqXomIlhZ3WQvaxrRhNuSI4mPF+iToaX2OgHG9dNmPD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(376002)(136003)(1800799009)(186009)(451199024)(6666004)(6486002)(6506007)(6512007)(478600001)(83380400001)(44832011)(2616005)(8676002)(8936002)(2906002)(66556008)(66476007)(1076003)(66946007)(316002)(5660300002)(110136005)(41300700001)(4326008)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KSzthxltFSXZQy3eVECrc65Q9NMaV4Zaj3A9KHJf2/lJllg7N4EiTNLS29fj?=
 =?us-ascii?Q?EOa2pMExKC/pGwtzbgQbJ0FEzh1uRKeLLPYQnCFrmE5H1sxwL3JPcX2GWI8T?=
 =?us-ascii?Q?gLeeiit8Z2uTR3UdFIlR3BGkFasqxaTcJ5ioQizn7BmIlsij1MDhp9mU68oY?=
 =?us-ascii?Q?gfKzeyZ3GgiWIArKYN3uEh7jkVYpYsCR/fy1siioBgUADvQFWVTkUzfZDSAv?=
 =?us-ascii?Q?9B6g4djzQ6P1DHREpFFw/vMmND+S1I2UOn1hTnrQelmhKfhY+l6ZKAnvaPdd?=
 =?us-ascii?Q?QD+yK0QdqR3A6F5t49B6+SJe93zaW8fI7Deb7I66a+BYW7XwUT+tiOnHK3D3?=
 =?us-ascii?Q?Fu8hIQCla8KHagYTldee2+VQIIT1IA182/cgfDaSe7BcFcnKoTey6VUSp2rD?=
 =?us-ascii?Q?+ubB4PuNOvNPBD19QC6L8UM1sAUZD3Dde7HSZqm0JNhZzsD88ezQZbpM17zj?=
 =?us-ascii?Q?Ei1Beri7lGkKpp4tQ0SqDqGyxFrlVLITBrgDzgjX/64xt9AMOAwGed0seVBs?=
 =?us-ascii?Q?EknjazQaEZuTcem5fXjlIQ2Z+Re7btFFxqPYIj1/g6yapQ4y8SAtflaonZOh?=
 =?us-ascii?Q?wbhsrptVW36JZvITTlf02ZV+dn4lwwBm/FKorQBrJnoXjRw1MgoCnn4cpvkK?=
 =?us-ascii?Q?KBdEWBnNw+wsu4MjtP3w0Pn8ZQl0piKmHKio/D2nkggwpMi5rtTMjTV6nRau?=
 =?us-ascii?Q?ZD7uAL++SpXnAevAVJlOfW8af05BfNYRwVW7IDJ2SsA8lgp83efJ3VmZxVsJ?=
 =?us-ascii?Q?HzB8oL7yhWge5L9YESVmKuraZUmA0wnAJYMmu9LqDeHvUWmbBLG8PDAfDsZF?=
 =?us-ascii?Q?4zqANT2Gwrzi556jNaXcKURqQi2nHCh7z6UWvYttyuD8P/41YZH3kaFK1jZ1?=
 =?us-ascii?Q?l57rJEmRMMdqC7gHwAq1+dA4pT9E6onMjPADbmPw17S2lYU0yG8ueYzHzrgj?=
 =?us-ascii?Q?Sy+KUKBF9SfnJil8GLE/5XascMvPUQDHYYPHyU15GaGRqAvLq3zMZtXcASOt?=
 =?us-ascii?Q?KYllpmQkd98pe+Osx20fE13qcxzErxfusXnv0CmGv+nyodEPVCLqa1YbJGzf?=
 =?us-ascii?Q?ufOSU6n9CGOc5bIAhzoBy2NzhyGfzZ1XpNZZEa1jou1OfDmpj+nzS7xKFNdm?=
 =?us-ascii?Q?7FJChhdw42pcwtVOHZUXuxDrGTcEzmJZ5Xls+gt0cCGIe3O6N9sjejR87s4C?=
 =?us-ascii?Q?7WN/pJTKmOTIEjPQTSvebZUWBN9oyoPXK3OgxjEOwlpLZ75hq/uWx9rQA1j5?=
 =?us-ascii?Q?YUj3aqn1FMj6fRyY5NFY/SGhDcpuC5ah6tIaJz6N4PCt2jcZEdzDUp8yKBB7?=
 =?us-ascii?Q?SN4jr7FG5MkqKF7ZaZbs1l37p0gWfB/d8i9ipNEadxMaRjXhqNf8Orcs22kD?=
 =?us-ascii?Q?3sKtF2yP5QBx1GBY4JOF7xb/U94K09xoHhvK5851wFdljoHnHPN6ZMEqm8rQ?=
 =?us-ascii?Q?6yCKsQS1HYI22tRDTcyMGhyUJQyqeaFEkMpNhxnJDlmJhu5IZHOssMo9ys8h?=
 =?us-ascii?Q?bvmoQySpt34jyltpLn+Rj60veY41379SUBzxBa5Otxnt7arQr3OwGAmzqLRg?=
 =?us-ascii?Q?Gi5cZi5F2JTOG27W847ygBI+xTx8BmP8v2+y6fmZrkGOFeH2vQxCCBw784eT?=
 =?us-ascii?Q?WAQStoW8XcpAouiBXo0Doch2UjNwurkPA7rkQ4RUQLaIB/Dr2rWIYP89PWAY?=
 =?us-ascii?Q?4hwfHg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: clz6dvlPHFZ/LqlICvbTwNbepOnfBvflx4vyZJ8NWPGKQjX4Hcb9i1iiYWjoVG/IUURXEfXc9K3TLiLzp7+Qid4YCfavAQ7KYIRmjXaI+aFJm/A1jY2juVV3MRLydFx1cbzOjXOrFGjglg1TkyIlnCZKbGq9tOTljDpmf/Wpt79YAkQapj2GAtFIu/SvveqikXhsG+4GPM1B91nvwIwmddr0E0o7ysl/OtpJs+rem+VkeKRFIQWjW1rw37cV71oW+v+XWe8WS/U4Mw1+WrhiHATgncf3Qj1GF4GA0yQZ1dgfJISaWLNgcK4cGdKGjhh7oE3fQXOj1makLPNGJRZzaxNrgvcT2Be6+vNAgYuirC/0q1kKgd4BAPEVUYjgRV8+IA8zAb+dbuH5ZvEsqUbXG8Gn1mWh79603WvPD8QjkExqOMBD2JKUnbDgMRUcf8apHHrabdCbmnRx28DNG9ubUoVx0+uP8IEz6i8iew7sR3g5doGX9dVlOPHh3QV6SxEaczQv9dXFzP4FT/I3d2/dGvVUbROu1xMZQ8aXp5j9ooKmO4ucHlmNgQrEJYWds7TfBF4OZ7lL5qNjzg6LsyC6LfS2L5Mqn/r2plrvG/nvKNxQYIIkKLwrbApXcUnnsTydKihtMmVR/fRj6pHRCbh+lhAKv8K4zNFGjwBpyxfkA8gKK83qEqJnC/tcQ1AfpqRMOQxdfpNicSX+b5iJrPuF4NeNjg8jawWl1NrrzS7bVNlbB+7i3rYGlCoUExivCQRERh2SItAh2uXr7JuGzEG6LlTXB4V/28hy4tQpk/kz6Pn6chP7MjwIc7kO0MDYacuFuQmJ58AnDHEcJXyDK+ENRyg2iHIhysEkoYqs8rqOinI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d69b189-9663-48ce-af6e-08dbb9c3e64a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 10:25:23.8074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2pQa7Vgvh4QLfMUeSj7kLerMQ1srUwL3CCT8MjQY7rhF7yFnNVaC1SxFviz90rJK7c17Zl8BQQJUha4w8h3UJieEn7PACSo6XakxcgfDp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4740
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_05,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309200082
X-Proofpoint-GUID: D6mGFnuYPcTpQHMq-7-igqP7vvH6b-kT
X-Proofpoint-ORIG-GUID: D6mGFnuYPcTpQHMq-7-igqP7vvH6b-kT
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

Restrict the check to ss->legacy_name only, when parsing the controller
names passed to cgroup_no_v1 parameter and also, use ss->legacy_name in
pr_info(), that prints the controller disabling information.

Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
---
 kernel/cgroup/cgroup-v1.c | 3 +--
 kernel/cgroup/cgroup.c    | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index c487ffef6652..942872b83bf2 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1297,8 +1297,7 @@ static int __init cgroup_no_v1(char *str)
 		}
 
 		for_each_subsys(ss, i) {
-			if (strcmp(token, ss->name) &&
-			    strcmp(token, ss->legacy_name))
+			if (strcmp(token, ss->legacy_name))
 				continue;
 
 			cgroup_no_v1_mask |= 1 << i;
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
 

base-commit: 2cf0f715623872823a72e451243bbf555d10d032
-- 
2.41.0

