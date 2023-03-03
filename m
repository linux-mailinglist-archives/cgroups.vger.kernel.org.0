Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB8D6A9484
	for <lists+cgroups@lfdr.de>; Fri,  3 Mar 2023 10:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjCCJx5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Mar 2023 04:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjCCJx4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Mar 2023 04:53:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C4F11E9C;
        Fri,  3 Mar 2023 01:53:46 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3233hxeF004859;
        Fri, 3 Mar 2023 09:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=j4QrVGlUy6GZXwvXk8mnEiaktchXZHN8ttjjIUPSIos=;
 b=sO7mtWmSZ415HB6EFbeF0sK3s8K2nAFfaLeJW4iu6zjamy/qc0EjZPMSyGlZUx6XN9k5
 6XllNK/1ItuMBD95AEPIzDhVjB4XfXID/PrCupdp6jG+59ejC7+/MCsg0iwWAYRk0JHQ
 WDHha1Em4FxaorITqtS1d0AWbv8mOjr8x1ZaVhnUzL1rJHG18SrOjGCLWVV3lbwRLSed
 RKpbQ7gdx0JK12LMjLNSvxP6rds4ONahlXuzVLiVEbrYbFys0uASUf7EEfHpeXNkWmOX
 NcqDSGwcXmPnQbbI97v2Zj4mYnsoVpwTMSEo5sg5bZCgQezroRmfTTc5such4g9YbGtA Yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb72nsja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 09:53:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3239ba6w031278;
        Fri, 3 Mar 2023 09:53:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sj3wm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 09:53:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCtI9pdNkq+EKJXb02O5UJmmCPXdGTQIzLmPbMP7FWGFYUqojU5gtPaTmLN7W8VbSpT7zhhdDbn02tNWDiwgw7ir0Xs8OyAO5orzEXUFUUUe7jnl62gXlMndD+5eB/kPWrjE/2lo/d0H9DGZ9K2LnRAs2yWR1Elf4/6uW5Hm0p5h19rpUWr4T1BTAd+n7LEftnnO2Xcwrs8PtuUUsPZT26gpMMDfLbrh4EWQfHaWOVYhAr/0a3bC1CSqIxP7aGIxdOcV5wBgtAq18cphKNDVhM+V5WlOtwwKEY1wubQUob3cC/fdhfMYNurVRbgqnbYn02emR/euWgj1MG+cHIJJzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4QrVGlUy6GZXwvXk8mnEiaktchXZHN8ttjjIUPSIos=;
 b=WIw0eUZDimglJFNIpSUhm9vTXG914tmcKo2zwrliBSSGhJYfO23PGylpU7ugv/wMJTqdz/wpgNcCSeY0GXZIqF6gxS7fIsnIyvIzT3aTcEM52hfB00FWhA63wBh5Flkv2BOPOR0DaFVbfQcj91iZFCQs8f2BBGzcMGCr2GD57xOYilQ1C+P1C1o9z0Oc0OffQlKSI36YzyjeJqyuA4coaNbzk31kflAdPT80WfiWNJyrElFavxhI8MXc4wATeo8LXHH8eIf9ivYJ/MyJ1OCrAsZWslTTgEVMKIQOrzp1B/aRkM99a6U0gQ42BCaLJpI+pVq22eiAceiRwdSmQ1/Dsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4QrVGlUy6GZXwvXk8mnEiaktchXZHN8ttjjIUPSIos=;
 b=oNS4JQ3vdtR8iZkPBYeOShx1zEPWL12lFLIfUQoAQEr4lhMc0iTpCaPFKonNiUyej2c/e6eM0zAVEdIxcQkZHMzrgew1YLNa80XSUXbmFBVwfEBegnNQT/K27CYcTiegLUzpUctcd9TKsp3hTus8kcYBIda6o4xtDRVO0VRSd1E=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 CO1PR10MB4658.namprd10.prod.outlook.com (2603:10b6:303:91::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.21; Fri, 3 Mar 2023 09:53:20 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::e7b4:258a:2ada:db1d]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::e7b4:258a:2ada:db1d%4]) with mapi id 15.20.6156.019; Fri, 3 Mar 2023
 09:53:20 +0000
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Tom Hromatka <tom.hromatka@oracle.com>, cgroups@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cgroup: bpf: use cgroup_lock()/cgroup_unlock() wrappers
Date:   Fri,  3 Mar 2023 15:23:10 +0530
Message-Id: <20230303095310.238553-1-kamalesh.babulal@oracle.com>
X-Mailer: git-send-email 2.34.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::18) To DM6PR10MB3001.namprd10.prod.outlook.com
 (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3001:EE_|CO1PR10MB4658:EE_
X-MS-Office365-Filtering-Correlation-Id: 164949db-d3f1-4f67-b736-08db1bcd1eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NyzgG+DgKV8GXsUaDJLCynhTJAN2HyJAgktng+Llz9na3NNAYuxiY6X9riA0VNx2ZDAzY6nL20jPNBYq70NEQPjpuetpci+RDldCOjf35j4LbVqCEZ3DX++7Iwsy4B4nFz/SRgQGHzL9KqtDDUrTCk5QbNwW/OC9E9vMwAhP9kEm/i9k+yMM1KVo4fLL0CZDiTHldD18MGbAFFpGOg2VP4U9Z5uK/LfxFFvGWiVQE//9V2N1mdvuApfNmxlmJWNE7MPn+WAyzpucYKjw5E/fmmyng8xdtmPckx31IKxLxcAeyQobiGTnTOgfl2/VL1+D0UVIFbl8ZT/ZHeIssJK1Um7XJ0PWC0OB5GnH6Y75j5XNNiioKsoYBk7GqFrxaXBosLl1K866UIRwTRHB0fUl4UJJsr/xPc9fzogHZPTC108avWTu738YPkfYNygKaT1tI48Xogu4S1MbzwKQ672LfLA2uoBhaAQrorYRQRlzHycneJ07BD641+wUJWDIybQU6FFQucukm9BpQnH8Bo+0S6mMO2ShiVPD2765d0JW6pHyrdtqrqdaOAVlpxhq/Vi7htoOofCA13ZI3wZthn0/5FQfNhqo5IvNAPtU4BQTie9vsvBy40prnuD1XBbSj2Af18HzX9yznr/NH5L7oP0FZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199018)(478600001)(83380400001)(2616005)(6666004)(6512007)(6506007)(6486002)(1076003)(186003)(110136005)(316002)(66476007)(66556008)(8676002)(66946007)(4326008)(41300700001)(5660300002)(8936002)(38100700002)(44832011)(30864003)(2906002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r50Q5wJ61hMwssoUG1vEl0JjT9GRgDZ18pChQwj9wWyVCf909w+0x2U5vH8b?=
 =?us-ascii?Q?m9x/i0GOaZ/L+5g21Yl/Jf/V2oCoJklGdnyhzrIigQ2asMcmY4EMa5xm1Ycs?=
 =?us-ascii?Q?bFlXr2611VVpaIxCSi3SIVl+EuArJX5ZB66uOOpgZE7GHu8F9ucI9+LHascD?=
 =?us-ascii?Q?SSVALUIXvDTal4sjeVt1mFQhoi7vPHQ9f9wCdtAyAtxB/XwuT0WKldCYjyCq?=
 =?us-ascii?Q?W/j1NuCv/4nrZKpX07QsK7ATuYyxpzcrHv6lpePQbiO5+EIYkHASR2rEQC4d?=
 =?us-ascii?Q?uP03kDCS8/JW8Wr1pw7emGFN9r0KNL43HWhiZYz1T37PFnF8wv+8uQxj4YmJ?=
 =?us-ascii?Q?U2ZW0G6CdzJcK+FLo/y6WVQypHuDPzMCVbVW9P6vwZwHW+rq9EHcKgeQdnOi?=
 =?us-ascii?Q?TUCpbYjZcjlOVl/2PgU8j9hh2ThKSmt1pjb6McjHx5vdEnXruqFYx+yBQTUz?=
 =?us-ascii?Q?uqUUfP5s4fkrSo4frDPrJVWLCj3fxpZLW1IVfGS88PXAiDCg7VftEabfhZgC?=
 =?us-ascii?Q?bha8AMYwI4GRCgdCNJZh1bawBT09ERb/Rv6jOkzafyURYz6lTXbrwReFRlZQ?=
 =?us-ascii?Q?KeplWL/CyhVVVIzc7c/efHxAXxRS20PaHMe3Yn13RQXqvPTVv4kh944jX4Bm?=
 =?us-ascii?Q?aNhjUWNczRO7r5l/glGyHJdWAUJU0Ymiabz9eHb15UPTX1Hqc0s6nCOLdCbs?=
 =?us-ascii?Q?2sdOsFsE65VmG2tBJz4qeNRPxPM3/8UqcFETSzwzcayRMOeDNqsLO8ENEqY7?=
 =?us-ascii?Q?5giQ52TsLwtvrkUzObAQHbHCuj5rg4jctJzu97zpSVgUMwJffdL/wK7aS4CW?=
 =?us-ascii?Q?mLJrX3oWj4bCcFKmokyoLSfXJ2z4NjTPM8atjueQsmPNs+ejfAoAEVoWpEJ2?=
 =?us-ascii?Q?NYkV77sc4zrIDIwtUyi2EGEU/G1+EqPHUYvHGVHMa+PoJdAEJPtCtlbTPH9B?=
 =?us-ascii?Q?FsKlS3+Yk90AKxEx808NRXCkVj2g/fyLJnr81XWtTK2yU2y03NP80RQr6RXt?=
 =?us-ascii?Q?sPLOBm7tj5S3GhLhgYRdX309SLgbrCTnmEMakPvk+c+EmGFq9NUW5pgGrSF+?=
 =?us-ascii?Q?ajMUUVePiYBqA7VfjeKXRIKnaxtKRxhLjqkgc5ho1MaRn+wlJV7IwmEV6IYq?=
 =?us-ascii?Q?shzuNxj94oDAsFaE5ARQ1LslQeBIHEXcUX0qSL8JH4nrbgbejKDxU1ANlWqR?=
 =?us-ascii?Q?kyhlTRYoPghB/4urs6kMZBVOcdrXikichLqLpbWyyl/5zD3eixB++UWoLOnB?=
 =?us-ascii?Q?W8lb8/wpk4CH1SZJpUiqE83NNDhyDkufn/+p7BRT6y+RYOwI6/kN1J41uQHC?=
 =?us-ascii?Q?U42hrJH0pPl+LDgw10+raxSVxJ0qOzv4O5IzejxzPbBR0irJLGyLanZ6Bnik?=
 =?us-ascii?Q?SNtnKy76GXSmA7kY1hqbBu0485Mg1LbvTh7Pi2ymr44FlX1RIFJ2Emah/XtD?=
 =?us-ascii?Q?78UMZkMk/FoZQl6efnTmMDLl7I0HoUX+scmr/rorXM4ixMYf7zFqUj91arKX?=
 =?us-ascii?Q?IhZGKLh5PJmSNYHppjyO9SFPUl8OWWuTvJ3468REpH8W0fn/H0gHilOF/9ox?=
 =?us-ascii?Q?DzVFryvD+UrFAz7tGYV0JzeesmqXtk6Hb3D+iRdLh2McviCfSX34t3nW1ReZ?=
 =?us-ascii?Q?GwoUu/x18pYysYVrj/w0U92m8octvcmBVf/c4L6NXOdZLaPNi+8vSONozqk6?=
 =?us-ascii?Q?qM4pCA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IWOqg+DmzM36Mne5Du+45WM9MTWnblZB/OlZ8qQ/hM34d2tWdHPSFFRgRPdxMzF6iDONzDJ4cOfKiCv06oIvnE7lyQKKh0EYsXeIWFB1fQBv7XYCoritwUy0l5rJshQDugaMdPbDPITA1lv5DOl87AIohYPN9q0g5oY5rl3SihBdzn/mQSiuHvS/n8ZsUE+UJwVtkOJOk4KQ9po5o7OoG9xAZ3jzo0LeIiixWx+m/3DrQb77jmYQpUF8aSxYjM4BXMtKh2CKZxe1CZ5jGtsZ5QmCKvdBWrzamPDnbTpUAYJ4E5Yx5AsuU42vJjvTJEh4PdQj60ldbfsHouOYgRgAshH5nmzLbnn88DFI3kkjMx8ggwXsDSyS//BOCx8mB1TuQr42FEvw4KB91rHssHgNobLmeuzZIs4j5ZJOQmUtjOOab0UqSXvoU9d7VcE/2wgcK+q9TZVAzKvexqUc6ka3mNJYxS01SeKtzKO8t8qVx4CS56q2TqvGfHGbxUAT7urKR42L/cPMU5W3umrW94CDMBrStOFM+GOsHl1wRYt+t1QdVJF5y/GiMx+ISfdKGrFeikVJ3kSJ31L0Zvdy+zxjZOULywyWR8u1ftN/YVMd1S+3RnKbpUIbyJwD0ZoDhtDvIqbcTFcQ4QL6sW90NURsjElg2I+EPA5igy0o5lnEUpynJ3jJuDfQ1UEpPhuJD0dSxOf1wLenYPFFUtR36e0JeNGJIGE2+tiEts359bEL4jkIwM6mxPTe0R1RlCnD/jNNPf5AyW5H7NaKq5BKTpv7VvuwLQTB9wBaLXSA8HqYgEPjJjjyhtFWe/Jbnq/Wm/bZZVMTXEBDD3wigNmXvAZUwp66pw4Jko0dRonjlX8xvJxq85baVMzyxBqDvkh8d4S6
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 164949db-d3f1-4f67-b736-08db1bcd1eda
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 09:53:20.4046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +O5v2qcQgRcq/NZBJyB5oS282fU4GOb8Tt6osv+M+i50mMMnhzs4YmWP3MAwPWyyPsnfKZ0KoVewV+9xVVsJ9a6hUp1jl5JhQLNpYtXAL+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4658
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303030087
X-Proofpoint-ORIG-GUID: vaIC_xqe9phsgL_LTl08hUXR9aXJTqBb
X-Proofpoint-GUID: vaIC_xqe9phsgL_LTl08hUXR9aXJTqBb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Replace mutex_[un]lock() with cgroup_[un]lock() wrappers to stay
consistent across cgroup core and other subsystem code, while
operating on the cgroup_mutex.

Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
---
 kernel/bpf/cgroup.c        | 38 ++++++++++++------------
 kernel/bpf/cgroup_iter.c   |  4 +--
 kernel/bpf/local_storage.c |  4 +--
 kernel/cgroup/cgroup-v1.c  | 16 +++++-----
 kernel/cgroup/cgroup.c     | 60 +++++++++++++++++++-------------------
 5 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index bf2fdb33fb31..3458701dcb28 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -173,11 +173,11 @@ void bpf_cgroup_atype_put(int cgroup_atype)
 {
 	int i = cgroup_atype - CGROUP_LSM_START;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	if (--cgroup_lsm_atype[i].refcnt <= 0)
 		cgroup_lsm_atype[i].attach_btf_id = 0;
 	WARN_ON_ONCE(cgroup_lsm_atype[i].refcnt < 0);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 }
 #else
 static enum cgroup_bpf_attach_type
@@ -282,7 +282,7 @@ static void cgroup_bpf_release(struct work_struct *work)
 
 	unsigned int atype;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	for (atype = 0; atype < ARRAY_SIZE(cgrp->bpf.progs); atype++) {
 		struct hlist_head *progs = &cgrp->bpf.progs[atype];
@@ -315,7 +315,7 @@ static void cgroup_bpf_release(struct work_struct *work)
 		bpf_cgroup_storage_free(storage);
 	}
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	for (p = cgroup_parent(cgrp); p; p = cgroup_parent(p))
 		cgroup_bpf_put(p);
@@ -729,9 +729,9 @@ static int cgroup_bpf_attach(struct cgroup *cgrp,
 {
 	int ret;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	ret = __cgroup_bpf_attach(cgrp, prog, replace_prog, link, type, flags);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -831,7 +831,7 @@ static int cgroup_bpf_replace(struct bpf_link *link, struct bpf_prog *new_prog,
 
 	cg_link = container_of(link, struct bpf_cgroup_link, link);
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	/* link might have been auto-released by dying cgroup, so fail */
 	if (!cg_link->cgroup) {
 		ret = -ENOLINK;
@@ -843,7 +843,7 @@ static int cgroup_bpf_replace(struct bpf_link *link, struct bpf_prog *new_prog,
 	}
 	ret = __cgroup_bpf_replace(cg_link->cgroup, cg_link, new_prog);
 out_unlock:
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -1009,9 +1009,9 @@ static int cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 {
 	int ret;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	ret = __cgroup_bpf_detach(cgrp, prog, NULL, type);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -1120,9 +1120,9 @@ static int cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 {
 	int ret;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	ret = __cgroup_bpf_query(cgrp, attr, uattr);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -1189,11 +1189,11 @@ static void bpf_cgroup_link_release(struct bpf_link *link)
 	if (!cg_link->cgroup)
 		return;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	/* re-check cgroup under lock again */
 	if (!cg_link->cgroup) {
-		mutex_unlock(&cgroup_mutex);
+		cgroup_unlock();
 		return;
 	}
 
@@ -1205,7 +1205,7 @@ static void bpf_cgroup_link_release(struct bpf_link *link)
 	cg = cg_link->cgroup;
 	cg_link->cgroup = NULL;
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	cgroup_put(cg);
 }
@@ -1232,10 +1232,10 @@ static void bpf_cgroup_link_show_fdinfo(const struct bpf_link *link,
 		container_of(link, struct bpf_cgroup_link, link);
 	u64 cg_id = 0;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	if (cg_link->cgroup)
 		cg_id = cgroup_id(cg_link->cgroup);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	seq_printf(seq,
 		   "cgroup_id:\t%llu\n"
@@ -1251,10 +1251,10 @@ static int bpf_cgroup_link_fill_link_info(const struct bpf_link *link,
 		container_of(link, struct bpf_cgroup_link, link);
 	u64 cg_id = 0;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	if (cg_link->cgroup)
 		cg_id = cgroup_id(cg_link->cgroup);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	info->cgroup.cgroup_id = cg_id;
 	info->cgroup.attach_type = cg_link->type;
diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index 06989d278846..810378f04fbc 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -58,7 +58,7 @@ static void *cgroup_iter_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	struct cgroup_iter_priv *p = seq->private;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	/* cgroup_iter doesn't support read across multiple sessions. */
 	if (*pos > 0) {
@@ -89,7 +89,7 @@ static void cgroup_iter_seq_stop(struct seq_file *seq, void *v)
 {
 	struct cgroup_iter_priv *p = seq->private;
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	/* pass NULL to the prog for post-processing */
 	if (!v) {
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index e90d9f63edc5..9bceefee14d5 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -333,14 +333,14 @@ static void cgroup_storage_map_free(struct bpf_map *_map)
 	struct list_head *storages = &map->list;
 	struct bpf_cgroup_storage *storage, *stmp;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	list_for_each_entry_safe(storage, stmp, storages, list_map) {
 		bpf_cgroup_storage_unlink(storage);
 		bpf_cgroup_storage_free(storage);
 	}
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	WARN_ON(!RB_EMPTY_ROOT(&map->root));
 	WARN_ON(!list_empty(&map->list));
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 52bb5a74a23b..aeef06c465ef 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -58,7 +58,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 	struct cgroup_root *root;
 	int retval = 0;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	cgroup_attach_lock(true);
 	for_each_root(root) {
 		struct cgroup *from_cgrp;
@@ -72,7 +72,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 			break;
 	}
 	cgroup_attach_unlock(true);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	return retval;
 }
@@ -106,7 +106,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 	if (ret)
 		return ret;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	percpu_down_write(&cgroup_threadgroup_rwsem);
 
@@ -145,7 +145,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 out_err:
 	cgroup_migrate_finish(&mgctx);
 	percpu_up_write(&cgroup_threadgroup_rwsem);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -847,13 +847,13 @@ static int cgroup1_rename(struct kernfs_node *kn, struct kernfs_node *new_parent
 	kernfs_break_active_protection(new_parent);
 	kernfs_break_active_protection(kn);
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	ret = kernfs_rename(kn, new_parent, new_name_str);
 	if (!ret)
 		TRACE_CGROUP_PATH(rename, cgrp);
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	kernfs_unbreak_active_protection(kn);
 	kernfs_unbreak_active_protection(new_parent);
@@ -1119,7 +1119,7 @@ int cgroup1_reconfigure(struct fs_context *fc)
 	trace_cgroup_remount(root);
 
  out_unlock:
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -1246,7 +1246,7 @@ int cgroup1_get_tree(struct fs_context *fc)
 	if (!ret && !percpu_ref_tryget_live(&ctx->root->cgrp.self.refcnt))
 		ret = 1;	/* restart */
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	if (!ret)
 		ret = cgroup_do_get_tree(fc);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 935e8121b21e..83ea13f2ccb1 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1391,7 +1391,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 	cgroup_favor_dynmods(root, false);
 	cgroup_exit_root_id(root);
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	cgroup_rstat_exit(cgrp);
 	kernfs_destroy_root(root->kf_root);
@@ -1625,7 +1625,7 @@ void cgroup_kn_unlock(struct kernfs_node *kn)
 	else
 		cgrp = kn->parent->priv;
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	kernfs_unbreak_active_protection(kn);
 	cgroup_put(cgrp);
@@ -1670,7 +1670,7 @@ struct cgroup *cgroup_kn_lock_live(struct kernfs_node *kn, bool drain_offline)
 	if (drain_offline)
 		cgroup_lock_and_drain_offline(cgrp);
 	else
-		mutex_lock(&cgroup_mutex);
+		cgroup_lock();
 
 	if (!cgroup_is_dead(cgrp))
 		return cgrp;
@@ -2167,13 +2167,13 @@ int cgroup_do_get_tree(struct fs_context *fc)
 		struct super_block *sb = fc->root->d_sb;
 		struct cgroup *cgrp;
 
-		mutex_lock(&cgroup_mutex);
+		cgroup_lock();
 		spin_lock_irq(&css_set_lock);
 
 		cgrp = cset_cgroup_from_root(ctx->ns->root_cset, ctx->root);
 
 		spin_unlock_irq(&css_set_lock);
-		mutex_unlock(&cgroup_mutex);
+		cgroup_unlock();
 
 		nsdentry = kernfs_node_dentry(cgrp->kn, sb);
 		dput(fc->root);
@@ -2356,13 +2356,13 @@ int cgroup_path_ns(struct cgroup *cgrp, char *buf, size_t buflen,
 {
 	int ret;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	spin_lock_irq(&css_set_lock);
 
 	ret = cgroup_path_ns_locked(cgrp, buf, buflen, ns);
 
 	spin_unlock_irq(&css_set_lock);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	return ret;
 }
@@ -2388,7 +2388,7 @@ int task_cgroup_path(struct task_struct *task, char *buf, size_t buflen)
 	int hierarchy_id = 1;
 	int ret;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	spin_lock_irq(&css_set_lock);
 
 	root = idr_get_next(&cgroup_hierarchy_idr, &hierarchy_id);
@@ -2402,7 +2402,7 @@ int task_cgroup_path(struct task_struct *task, char *buf, size_t buflen)
 	}
 
 	spin_unlock_irq(&css_set_lock);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(task_cgroup_path);
@@ -3111,7 +3111,7 @@ void cgroup_lock_and_drain_offline(struct cgroup *cgrp)
 	int ssid;
 
 restart:
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	cgroup_for_each_live_descendant_post(dsct, d_css, cgrp) {
 		for_each_subsys(ss, ssid) {
@@ -3125,7 +3125,7 @@ void cgroup_lock_and_drain_offline(struct cgroup *cgrp)
 			prepare_to_wait(&dsct->offline_waitq, &wait,
 					TASK_UNINTERRUPTIBLE);
 
-			mutex_unlock(&cgroup_mutex);
+			cgroup_unlock();
 			schedule();
 			finish_wait(&dsct->offline_waitq, &wait);
 
@@ -4374,9 +4374,9 @@ int cgroup_rm_cftypes(struct cftype *cfts)
 	if (!(cfts[0].flags & __CFTYPE_ADDED))
 		return -ENOENT;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	ret = cgroup_rm_cftypes_locked(cfts);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -4408,14 +4408,14 @@ static int cgroup_add_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
 	if (ret)
 		return ret;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	list_add_tail(&cfts->node, &ss->cfts);
 	ret = cgroup_apply_cftypes(cfts, true);
 	if (ret)
 		cgroup_rm_cftypes_locked(cfts);
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	return ret;
 }
 
@@ -5385,7 +5385,7 @@ static void css_release_work_fn(struct work_struct *work)
 	struct cgroup_subsys *ss = css->ss;
 	struct cgroup *cgrp = css->cgroup;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	css->flags |= CSS_RELEASED;
 	list_del_rcu(&css->sibling);
@@ -5426,7 +5426,7 @@ static void css_release_work_fn(struct work_struct *work)
 					 NULL);
 	}
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
 	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
@@ -5774,7 +5774,7 @@ static void css_killed_work_fn(struct work_struct *work)
 	struct cgroup_subsys_state *css =
 		container_of(work, struct cgroup_subsys_state, destroy_work);
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	do {
 		offline_css(css);
@@ -5783,7 +5783,7 @@ static void css_killed_work_fn(struct work_struct *work)
 		css = css->parent;
 	} while (css && atomic_dec_and_test(&css->online_cnt));
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 }
 
 /* css kill confirmation processing requires process context, bounce */
@@ -5967,7 +5967,7 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 
 	pr_debug("Initializing cgroup subsys %s\n", ss->name);
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	idr_init(&ss->css_idr);
 	INIT_LIST_HEAD(&ss->cfts);
@@ -6011,7 +6011,7 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 
 	BUG_ON(online_css(css));
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 }
 
 /**
@@ -6071,7 +6071,7 @@ int __init cgroup_init(void)
 
 	get_user_ns(init_cgroup_ns.user_ns);
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 
 	/*
 	 * Add init_css_set to the hash table so that dfl_root can link to
@@ -6082,7 +6082,7 @@ int __init cgroup_init(void)
 
 	BUG_ON(cgroup_setup_root(&cgrp_dfl_root, 0));
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 
 	for_each_subsys(ss, ssid) {
 		if (ss->early_init) {
@@ -6134,9 +6134,9 @@ int __init cgroup_init(void)
 		if (ss->bind)
 			ss->bind(init_css_set.subsys[ssid]);
 
-		mutex_lock(&cgroup_mutex);
+		cgroup_lock();
 		css_populate_dir(init_css_set.subsys[ssid]);
-		mutex_unlock(&cgroup_mutex);
+		cgroup_unlock();
 	}
 
 	/* init_css_set.subsys[] has been updated, re-hash */
@@ -6241,7 +6241,7 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 	if (!buf)
 		goto out;
 
-	mutex_lock(&cgroup_mutex);
+	cgroup_lock();
 	spin_lock_irq(&css_set_lock);
 
 	for_each_root(root) {
@@ -6296,7 +6296,7 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 	retval = 0;
 out_unlock:
 	spin_unlock_irq(&css_set_lock);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	kfree(buf);
 out:
 	return retval;
@@ -6380,7 +6380,7 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	struct file *f;
 
 	if (kargs->flags & CLONE_INTO_CGROUP)
-		mutex_lock(&cgroup_mutex);
+		cgroup_lock();
 
 	cgroup_threadgroup_change_begin(current);
 
@@ -6455,7 +6455,7 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 
 err:
 	cgroup_threadgroup_change_end(current);
-	mutex_unlock(&cgroup_mutex);
+	cgroup_unlock();
 	if (f)
 		fput(f);
 	if (dst_cgrp)
@@ -6482,7 +6482,7 @@ static void cgroup_css_set_put_fork(struct kernel_clone_args *kargs)
 		struct cgroup *cgrp = kargs->cgrp;
 		struct css_set *cset = kargs->cset;
 
-		mutex_unlock(&cgroup_mutex);
+		cgroup_unlock();
 
 		if (cset) {
 			put_css_set(cset);
-- 
2.34.3

