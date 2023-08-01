Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC88D76A9E2
	for <lists+cgroups@lfdr.de>; Tue,  1 Aug 2023 09:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjHAHXH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Aug 2023 03:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjHAHXE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Aug 2023 03:23:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79234DA;
        Tue,  1 Aug 2023 00:22:58 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VKldFn011010;
        Tue, 1 Aug 2023 07:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=V+kYGbsJzklsoofs/xc8UeJfE4hfedq+SXIGbVs2jIE=;
 b=xSBTJTD32TEmS/5/KbhAgmPuk/2cOohqg71QyfmQkFReojvCnNuDAjpAKlu2Dv7lGgou
 2cOqQfbCzvD7fs1BJzmVb2Zs/uiXm7/gmlsR0SvWjrIF4qx9r1dP+FD1jVsn7Gcr0qWE
 TYg+yuVjac0CISgqEQ3OYjP9YhwWYxHGArIsFtKNqA2fIusK0pqcv9i9IdKFNWlqvtf1
 WmdVNK8AMxG6CrRbi/SABLrAViEEpPNQ38rxJm90RONGe4T1/qRQVmhus3cjyZGGW89Y
 D/zhG0i3eJ13c6ovgmaeFAFE9KYfHgO7/3BBGmYVVvHCqcXrQieW1QwMqS7u10Gw+Rvj jw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sj3vau0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Aug 2023 07:22:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3716pUTJ000729;
        Tue, 1 Aug 2023 07:22:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s75vd3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Aug 2023 07:22:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVc2eg/hR1qCxU+OQvXDQgxpJNCxg9VeWu53uKM3p7mGV6pcDyWHjOAB3EuSMmNRX/Grb95yRt3jpPmhz6ZXRY8g1I4GvNfenTj1HYa7A8cmcmb7OpKEgKp5AJkaXTXSBB68AEVj0eHQ3iBz9lSam1y4A0HcwxsaFqKvzn3tT1uqUuq4TxezX0KssnPSUVPmvYPtFSIu8CTD7eSYAgk5iOoELNzple+LORkurMvqpe1NaLvmp/h7Bdlii9yBvX1MGEOqCaLaoHl+kDzPJ+4glLVcqLwE+b9Rtp+IW3+iWwUk7QYYotjRGStYIFFG+KZNk1txnenXIV7J2rs++oKm7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+kYGbsJzklsoofs/xc8UeJfE4hfedq+SXIGbVs2jIE=;
 b=gHyv6Rq3QoU7177eXhvxpRDpnzoqxhN7r0eYJF8Vzcxyk6r4zpyjdTeunAQ1H6s2wvQC1/hz5vn0wWRaxNJEvBGdSOngVSjLpAq8DfxEETuK9C2qGCjgv2IZZ1c1N1djvMkcYQ+YDEQm48MT0ZzFZM3pYGDtUybZW8eWn++swkxfLTKiywltWrDQMDBorMpWBD/14xmENHBm0LwOhHgnGVlYslJb2kBdh34rY7rHe0dgmbRuDHlDxGm3M1Hc0L6/m9TiLybFFgJtkNqrjwktRyn5r6c3/ybWxoEZOfg2cV+F5g9oSvfa1JupiGWgce45DXe1ljRrM9riZROcm/mI4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+kYGbsJzklsoofs/xc8UeJfE4hfedq+SXIGbVs2jIE=;
 b=jX6Ia1i1YSmhJ15pM/dqZPQ2/RvUX6KWMbtw3POaNlQnIBwKaR1bQBPQUDaH/OpBWnPl2S1sjMAJQsp8eq3B6FN6rWrn6ye+j1MrPARN5zQ3xKM6AC/PY/Tt81V8hYr1oprJlYh1uktPO4miQKV2hGBjtTrS8420h0JTHA7ImSA=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44; Tue, 1 Aug 2023 07:22:33 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::6487:e5c7:ca75:6268]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::6487:e5c7:ca75:6268%3]) with mapi id 15.20.6631.034; Tue, 1 Aug 2023
 07:22:32 +0000
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tom Hromatka <tom.hromatka@oracle.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cgroup: clean up printk()
Date:   Tue,  1 Aug 2023 12:52:14 +0530
Message-ID: <20230801072217.103554-1-kamalesh.babulal@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::8) To DM6PR10MB3001.namprd10.prod.outlook.com
 (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3001:EE_|CH2PR10MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ebf3599-537d-4894-0ec1-08db92601238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jt5FMtH94lacU3LotOUGWGol/VL064bfkwRzuID7SOBFTpqJu80oCQ7N18jYK+GIfuZABJO6nHWysTzv4AAQtLro/YfxGroWBt3DGs2PtjkQf0O+XsXuj5LqhwL6lt3pzS+fcPdcQcWHQt0cmNC9L5BRqi0gw6e3naVWjSoH6J9Muxj8Yc3D/On3tBsIMQsgkewlLzpCnH57iU6TB5UvB4DIMn/TX3baidTBt9OdLyjS9CUvB2v222oh+6qOJmno39/amP0VzdDJdRSQt0bVgvG8bZ8u6gPg8+rlIjRi0Wt4W1sUIG9TgOxdeFeo/C/Z2X8JSth/ObZczwl4044lQIYCM9kjwzbtexvgoDCg2jB/Ha1OCZ7l8MOqR7T03JTyzxtxzjKa1gxNjRcpC2xy5VvENGs3tFOjw9AIexQAa825mU/C5lND8QWcuROtLIlFrSat71OtrAhWMMPRgkrkc/pPrvhOGsobP6PO+5h9JYL2HUkkH90cLzF9O9QLEAdQ9Kvx8S3XNtQ5XyGsbAow4o7cHC0KaxJHvD4/f8ZOgVrj1Btu4oDR2kDhuyVbs2W+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199021)(38100700002)(1076003)(6506007)(5660300002)(4326008)(66946007)(66556008)(66476007)(110136005)(6512007)(478600001)(2906002)(4744005)(2616005)(8936002)(8676002)(6486002)(41300700001)(36756003)(186003)(316002)(86362001)(6666004)(44832011)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?muV1uqpXVyGJn7oaOyEyu5TwICtDq6gkslRY8uzIed/eDMpyKpRBERBXk3Og?=
 =?us-ascii?Q?gEsCacLtTx8QcaAXZ6yfihkuv2mRz2BWn49ltj7frFcLEDIFHSiov37sWNlC?=
 =?us-ascii?Q?0f6+TSOk1RWw3ZEGIptVMuDYO6vH22wn1CTFDsjbyq9uwladRBoSdLfVJvhz?=
 =?us-ascii?Q?+eJxZ5+JQ/q99mIdZ3kD3ZVRFI8Sb1h2pK9vDHh00uA2PABoX50KI7ogepMU?=
 =?us-ascii?Q?4S8v0c1/+oaEkwdlJIkGXQ44Ssa8Ae9ZTjmhh5jLG2gP1SPC0i6g/K9LbUHy?=
 =?us-ascii?Q?lcYNvSjs3llgyligEovNR4642QLcQBJxRmd1iiCfDxicDerLBsj/X54KH5Bn?=
 =?us-ascii?Q?AwFRnpJdvTxubFaXh2YJqcxZa8rGejxcyPLERH74oae/oKLbdubgUJdrdbBQ?=
 =?us-ascii?Q?3UmQreM9GgT51ghzTV5UaAs0IhPYtAM5BopyM4XDwocr7kVbCoZCJhuTvaFn?=
 =?us-ascii?Q?9lSZ7dOpki2GIU2pQoHbWnTHjJ8fNGKjrwBwAOjaZpg7acYq+HYlGTYUcFiR?=
 =?us-ascii?Q?23mef3cTEH7fMgXNU6ZLvk+CQFXIQhn1Ngb2TSA+UiS9SlrtTbNk/vobiuDK?=
 =?us-ascii?Q?uSmQ4cdArBrEE8rVa1VYXlDl3u18wZsnYZhANLAY0Zrz9Idf01a23Yz7e2/o?=
 =?us-ascii?Q?DICGj7jr42I2T7+pu7BiXqqYt0cq8JJsDc2/P7//SdjHrJwCpDMP5QB5XG46?=
 =?us-ascii?Q?h4Bgh5tpejZEP2U2P5VWPNqIAdfLt6ensgTZd/t7QqxATp8U4PKa0nVNBBmK?=
 =?us-ascii?Q?5Lmvsgwpf0ve6UVh9lMZE5m2J4reRd9WGhFbI63x3Ar4kZDcbl7s2pksWVHM?=
 =?us-ascii?Q?xmHQOTyUdBspYrEVTrcbLzhROuMIKFcclXfSCqOtaJQl67TQawL5EUHiAWlA?=
 =?us-ascii?Q?el/9pu0DNtba14byzkqthUGulEatQTj+1oR09HtBxFW/udxTEP5JkFcwa6oT?=
 =?us-ascii?Q?aQA5D9FthnF63gRD3jaa7i5y6a5zmSFWEl39/SJySPJb/cgz5BMoKjVTWRPF?=
 =?us-ascii?Q?705Bg70Qc8EjrbJVyW1QmfTCsKPPBxcuuHkUJW7KAkQPwxMDIomOpfXxkutR?=
 =?us-ascii?Q?ZP36bIi2mantRzoktH9345zFQgtbCQIpSGrdyY7y1v2WIjd2Ec7cEdcnWCbr?=
 =?us-ascii?Q?HLBltyanfcPB6O9t2ZhzWOOfxqr9XJhM8EpkK/xW6p1NZm/HC9J0I/rSCKky?=
 =?us-ascii?Q?NZMx+lGgytCIokTLEucU3XEiLHTjfn6JMlG1SfoRM+Vn7qeZjrKy1owLbLxK?=
 =?us-ascii?Q?oLcajy4aLqIGbsXoVuAEHK2oteH+jyTAuBUM0T3K3AYza136/B413vP7KePi?=
 =?us-ascii?Q?arejDKEZGvcveY/BQYJHY908CobUKiPDLqS1BZSblw4LHBvEoje9UuqqmaAn?=
 =?us-ascii?Q?UPdEiJOXOhyLHqAC+H5OlZTh8MD6YrjAovyMylmZS67nGF1QlDHEjV+cK0aS?=
 =?us-ascii?Q?LmU22Chzw4/Zgvw2/9BZ/7n3+UyVO5GcupTIREohPEkoMyLlTrWcxkb/tq5m?=
 =?us-ascii?Q?Kcf/ms7N6YyFIv0vF9sBO/c5wjc7npOKdERrP4XAKWGWmQVfZis96hvgI9Z2?=
 =?us-ascii?Q?cH9RCXPamMNPv4Tc2srWncPyVVCJHvba0lgkqGIwjLTHDQCVU1rBMUXwnuH5?=
 =?us-ascii?Q?McW/K0FZoVHGkNvnnDJnnfjWFVw5NQ8NlZ5ExbhX4DgXKf7skL0iv4UHcT2S?=
 =?us-ascii?Q?FabneQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Bfu9z579rcISUOfNcdQ7Mn7rIRC5kNrvFLtRcGRILxCijBadynjJajg0uonaU2qHtYCgkOQ+I+2yDajPP0g1wQz3pnB5SLeSe19WWavftfBWvR6EIpidRM7uTHpoaoPYxoY6HnVlyTQ5BkdBQTRVWYH/55w7UcY8D/CEZvMO4iL4W8FhAW6kWC1y7SRdlydPwoTXi21ILcN6V7OvyMKqVL15ZGyWIdzp0VIpzGLSxOEYyRIEdXPy611VyruusR5nImHeo5SI0XYw9z6daHaR67K7PgzSBy3TfuBdJW6rhTRqO/vO99433h8Nsf8ELmW8hefMJRHLkmCJLLIuinVq0jkvm0b6YzfGngx0JW+UdWt0CkDuzH9J6DsNl2I6DhhEEIH2n0dHUFf8wr571oRnSnoDC3lnWowJgqnCWZ7PawjJu5YIuceSvjjEcNNjo1tm/DwHBkFZKvA78saDO3ARibRVmTsOgW4ILW9qqHwNTlwBgmtQFKExtdB4znbF/pCM3sbvWMsxdNa/q1SJvrnh6VTzbniXaPSbURd95sfyT8BOrRk2X3ub6/kbrLzSuVw892qC+B1FlI1zyCKZv8E9d9sjPY/PUH4Jg70HYjzXm3wC2DnGqPvLJpwYh1sWjj6Evao3bQRy8JYPFAeDXhqxqGna7RmmcEke8YktC4LHfvRSN2T/QrHHKt8DHNyez9EkXRbaoel+/FayzSdgJq0gJ7HQbxwEDIyLLe2wKjYYNGk1LxBKIEDX/tPx4B2MO+yOSOJ2fyoOKOG+VwGAt6JNib90LoX3HRXt5UAbUUFNdxdY1qXsPo940+SaapXrbH8n1kXXF0HN3/d4dTZZHvjEepSD5APgRDGEemTABHoUthI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebf3599-537d-4894-0ec1-08db92601238
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 07:22:32.4721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Opxo2n0+xhqXGUiXBG/ZfWtELkhB4gohR0yTFKD7xLVF1dXDjqO6Mrb1lkknXcIF9ydeNIq3BNORhDKX2Arie4LAezw83rjbMweB3uNc4+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_03,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010065
X-Proofpoint-GUID: 2EkA7nGXCDh2NvAODqixI87v-Ujolbqa
X-Proofpoint-ORIG-GUID: 2EkA7nGXCDh2NvAODqixI87v-Ujolbqa
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Convert the only printk() to use pr_*() helper. No functional change.

Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
---
 kernel/cgroup/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c7aafb59ecf2..33b586db14ef 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6086,8 +6086,8 @@ int __init cgroup_init(void)
 			continue;
 
 		if (cgroup1_ssid_disabled(ssid))
-			printk(KERN_INFO "Disabling %s control group subsystem in v1 mounts\n",
-			       ss->name);
+			pr_info("Disabling %s control group subsystem in v1 mounts\n",
+				ss->name);
 
 		cgrp_dfl_root.subsys_mask |= 1 << ss->id;
 
-- 
2.41.0

