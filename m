Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FD279C79F
	for <lists+cgroups@lfdr.de>; Tue, 12 Sep 2023 09:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjILHF1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Sep 2023 03:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjILHFX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Sep 2023 03:05:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9E710DF;
        Tue, 12 Sep 2023 00:05:19 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BJjYBH000817;
        Tue, 12 Sep 2023 07:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=IbtARqtEJtnIVj732ScqBaTY+yhWlXka1stGRULn0WE=;
 b=oTpm8pNo5rQ94xix2FhjyHu0uQx+3AEeddCPk21mhA5rDJloPLjL+BE73cTSvk3hVUwp
 Ef24r8BErllHf1t1PK80ALCXUzPQ3LALoIUrLDQW1awNsJecDyo04EGlgB4j7dOMRvdW
 vOearD+gJrQc9O2xng3JRe2Ab0ri6mqyrGgK60IQfVPtcXpU1Aow4tM7Ds71xOZk/EZF
 Y5P9wV6TEhvNMD9RS05eOEVhuuG6uMu0DZOpLtJOuL7WrpWDv9MqlsK2BFZEA2z/j0Rn
 R1qXYM/za6ELjJwltaFpFXRB5qXb3gYEJg3pgmFxLcsZz5S1R1l6Jx3i/L+seuBu/LID 5w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1k4cu8cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 07:05:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38C71mhe007708;
        Tue, 12 Sep 2023 07:05:00 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f55bgeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 07:05:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQQQHjoAc6fx2vhv8wrkB8Oaq2CeDHkwB21brOfQz4q+BC1rnB49Tko3LTA01UdNynmrYyhiW9tQx7t4DiBicAIk+kTV+9ewLsnQC2PQrv9icBuB84LWH+8NmecRkXvjUulY88uiGaMmCPmjclsjQ36fYkhUeL+MJ+owhYc2c6yyiFsXKiFJMVkZil/qRjW6p2XmVTxGmw4dn4eCSrFfBn8xkKCE8ZGj7U/8bGZGxZhwSYA2+Fm8o6HXZsg1WGlogWABV425R6uHxkQDrK1FWfdXm0P1LjOpqWP4s9DddVOm9TidHCZ/V7DU8sMUYK8c45HwNaFePfRYY/U2BE3O1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbtARqtEJtnIVj732ScqBaTY+yhWlXka1stGRULn0WE=;
 b=SJnwHr0ZYN0xf/w0LJVcT0vSdZ8wyrarzTXYQJM5SgGLe6DnHIPQIHi1YvTCo/puwKCn4D0Wgb+xqqyMkkMnDqw7VeGo+1/GAzFG0ZqQiEVZkN6kRZAIdJfkJUwB/SkmIMY5sBkaiS9V2M5/VQm1wFpexBgeW45b51wm1LImCTbdkHsMpofyKgHsp4GdMYhplb9zQEVVA/aBC8a8iwTs+ckxDs08Xm67IlnafW7onpupo5eTeu2CIAkefQdzg80SqR1NiJ59qKV7p57Npys9DCwRf/Tfz/Qu9sAYBYkjlZZTPwWKiW/+2NojpCdlRNyGspnRQFFGY08BvXZkul6GZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbtARqtEJtnIVj732ScqBaTY+yhWlXka1stGRULn0WE=;
 b=EqOPPeqW1mnQ70nNOw0HQbZTh8p9Wx8QAHcmm7/iNmcgWRw/UxH43zbr1I4Td1RaEH9VTD4Vz992OU05OXx7sgthc+uQNqgKXi7Jh21JVYFtMWtU3E/kAmw+TZNnkSUexTTC1DkUW6wcwiyAVDtqaoz1xSaPVv/LeT2y/RYaeTI=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 CH3PR10MB6689.namprd10.prod.outlook.com (2603:10b6:610:153::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 07:04:58 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::3c2a:5677:55fa:2d36]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::3c2a:5677:55fa:2d36%7]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 07:04:58 +0000
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tom Hromatka <tom.hromatka@oracle.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cgroup: Check for ret during cgroup1_base_files cft addition
Date:   Tue, 12 Sep 2023 12:34:34 +0530
Message-ID: <96694dfc5f4caf4d84a740c3b18b0a456c9ff522.1694501024.git.kamalesh.babulal@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::16) To DM6PR10MB3001.namprd10.prod.outlook.com
 (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3001:EE_|CH3PR10MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d55c30-b5a8-40c5-a105-08dbb35e9369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6UVbpx/WvUJEEtpcHgDw4yMLxPPb7vaAMwEHHtzcBK3qVmyNnXZfuXCkMFNlud59ZJ67wNQ0UKevU4rMlmw5a11T461/W/1muDlUoXmkhf5mncjQtWACGbI1BjO4w02i5PBTdrUNpYfrLixtU0hTO+YuFIuG+UHvFUAu1HJitSxaH6+ZfFnpsgeLbyMeJZoEas+0CzL8sEoQCaXRJ9fiPqRYNtjLfJe1V/YntHgxE3+HSJCHsOY4tOR81i+uvi5vnytDdjzCLzqmOqP0RbuJ1/sSlHR508PY1u9Kmk0rRBj/OwsBQ9gwyAC2VSK2p4EoPWZ/61LL7kep8Rk1nhl9adMd0FLty69or6+I4RIWaYIe6RTIZdpHsYFc419EIJ98pZSk0yBi0/DgHE8/Jl1NyP7Aaws+nXmEOzj8UjXJ/IEi/j/CM0sPH1Fsv9WEO59Aki3ypyYQj+DGOyPCPHzNCnwSSzT1aTdtZW+S3HbLAMEXCrYHtWiQ9yOT3k4NH/k2WDlbmDChBYSGMU/xIMXQUC78sBMnPdE8tuJ0A0h1z8VqFeKK4YjTAf1WAs6yB1bx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199024)(186009)(1800799009)(41300700001)(5660300002)(38100700002)(6666004)(6512007)(478600001)(83380400001)(2906002)(6506007)(6486002)(2616005)(4744005)(66556008)(66946007)(44832011)(66476007)(86362001)(316002)(110136005)(36756003)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DenBZuBWRv130BUwQk8Cw0zLI87w3mh/n9zsdpKsjbhNL0lDMfzYrGo5zsBs?=
 =?us-ascii?Q?p9gp88aMODMnZhrXdC0VqNsefB0blXKWbCSLwnDUfFcHshxgDrdclKfhtQSo?=
 =?us-ascii?Q?4er4lnXpNYl5aWP2E7rSON0nv4JtpzGX9GNr0mKLiCrtFl3nYjn2ZInab0p4?=
 =?us-ascii?Q?ZLvbqKjgi6t9TCXeAAIFAFH8DsTKdH8qxNrJFWDUFond5QRd86lv30f7I80N?=
 =?us-ascii?Q?qzW3fW+chnQDtgZAH8+vqmNfT0+Un1eRoDJ9sjk3RJ+Ga/agvv+4pVkS5ewr?=
 =?us-ascii?Q?jOaizaAM8KlhJc562t0qsTAdl3jsUU+heJ8C/3BwhH8/rFO9jhy9YbZzJ3xM?=
 =?us-ascii?Q?OQ4BoYuEGdXHRr6rN6IYZbyiqxGZslgYdIzHPFyC5x664D2iDyWXLTW8btFu?=
 =?us-ascii?Q?b4Wofwikw5578ZNnQERewFnG2IO4nBlmcdq6NlNbTd4sOv5HsXJXO8TW6z1H?=
 =?us-ascii?Q?ekRnTSd3Sz80j6jxSxTUCdf3kRjw6+FHlsF+Ob904fJHplFJir/pnCW11+Bv?=
 =?us-ascii?Q?KyB3g5kFuDqL5fK4/3E3fV+XzwJp5HqE+myYdx5q2EAa4JtTDrvXBrzIj5iC?=
 =?us-ascii?Q?rLwBjWfMP7IiJX7gnNzohG2d3BCdU2Zy8zS9eQXyYh8pFfrq2D6UERsWiH7l?=
 =?us-ascii?Q?58KdLrl1qZ7JYmcaLmWdUFcujBjFPYsiRGPr9fAOg6rcTBTsyI7sVJ/ep3vH?=
 =?us-ascii?Q?PdJrPwP4eIUSV9TP2m8haYC1IVIgsaC8qhl6TPcNG3gaE7aNaxo0Sz3FntiP?=
 =?us-ascii?Q?SpLF+TtyVDwZrayqCnEvp2KUC+a/DZx9mNnPse6k78KnvdITiSwi/96kjpTH?=
 =?us-ascii?Q?HwTLDgsa0MFRcyuR1EXpr3F4OtoD3Rk2W4ZP6n6AIiqbNT4IkZ1pk/hoyz3b?=
 =?us-ascii?Q?kVkLHF41ETnLGGINnlktgSKhr1599toi2agz5WJQPAWIgtmBJoN3a9KhK6tq?=
 =?us-ascii?Q?z/QRNxKAIflF9kqIioEr01lt5KL+spYZPUftb3Z6uVuQezbP5y4KU+FFJtV/?=
 =?us-ascii?Q?wAS+DzptUaV4E2vms06Xf+Mlq3CAJP5wAzq0kGlnBo9iqjsS7WG/x/H00Vh6?=
 =?us-ascii?Q?tDOS3BZfAvJz6JTFFE586u4JBZ+Cx/tf9J/srEJ+USr3XptkNpRR9XiksFRr?=
 =?us-ascii?Q?osnX8LempObHyHcnsNswfRl3pMlaHch190KY0A2plVJvGJnbPfCPN/NGsC8T?=
 =?us-ascii?Q?UUGfmfZqER/DQCBw3Z4SRqSAoOVjwt27pRmvQmzVp2ppHjSkfBOAJe9zn1Nj?=
 =?us-ascii?Q?QkdaKFPwk0iC/G98lBPJHsu94z4eM+5B4v1CxrIIBbccdxT5HZSAzyizjNz7?=
 =?us-ascii?Q?GmDOvb4s9/DwXNv0IqdHKKdvzs1Uz8Q2TGGmAAhdLHf7zUQ6kHEqCABbJI82?=
 =?us-ascii?Q?vwDzyIRWAu0Ga9x8VHfmd+HdWmD6a1oUWHuUsCexe1RObiCl3eHvib2vXPYZ?=
 =?us-ascii?Q?n1SNBLaXSrFdvgKCjbE0xlthqatFnEOfLrZUZrBoPuof5NRi6AZ44hWPyA+Z?=
 =?us-ascii?Q?+hRJAn9suYdQCj8voZT4ARcJtsIUjJJUwUB3B/vi8l/qnWRa7dzwrtVoACOR?=
 =?us-ascii?Q?79k9KRLG6MPvcFCzZmQrC8gTrCR97iszVmWI36PlEKPLnF2JNRknML+F4HUJ?=
 =?us-ascii?Q?tVxHN41Xw1/fEWEUOJRpkx6+yUwPEtk4ZaWGdZMmDpghe3hFeKGhtAl1g7JV?=
 =?us-ascii?Q?3Wy0/A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: THndrcsiYDv2Cy3gL0ll3pZrbA+Qd3469cX711rf1oocPtvrYFoJiPkUGVu+vbtgpRbgDL+qikyx9B4NjP10yAQ0Cd0M553EFmhOtsPgUiFqc2gW6EsbhWrM/DtUfF5Ew+/j5DcuEE/H9GhhU9Fy1GV+vmWsl8hrqG0C8H08xJzaoQo4ySsLp9u6ZexWrXt2dnm+mffZsrzcdeEFAJTnDi29q2kVi+rLz1D7fhJVv95SOGX6nxvjXh5QxEbX3lHARLfmHQ0e7BePK5h+9otoU5NoFHLhXO+nVsACgcM+lHS2bRU/pZzjXS6FICPBc8W8drpW00ztzjMYkbknS3vteq/hNmVltn9thwZ05Q15coNPrcjBhgxyIBsPfVMJs0vJZJDjRkdoBlMVEIoHyo+Y0rtKjEt4lr/r+ky7P6nKLoWPcBeypJFpFVY69HS0WLn4VnTGLEeMfPWB+Lhf8/Ntu0fjHb82wPXKqTJGeodc7hoZ5swFobgReE//i6BArrwFlN4RKCXNKljIwgb6W+0U0PRzqAvar374m86+45dk7wpYF+B4ir8hRyUvETXOEp+NHRDnurex++JxDHmIjta8KEOZRrwxJ6MUMt+Xk2k/aigEJY+sslHDTn/OTYxxKI7R0dZJLOqX5UIVwhevJU6G4OeWfSJxTycCXojI+XUA5onPDnmCSPmueASAOP7UxRmUS99Ttf7SFyp06ok3Nl52mFJbP27Me9WTiAjtu+dSqVRQzd3bSmwfpMqKfvq8Wfoohl0Gp4JJDc2ZjLfCKHQ4F60SWb0WsSKvH36t1tCf4cuE3LKSoG0FR1TNEQgogqqB6hU/3PRyT+YQt6QfEKEZtNqIkyFO8CI0aE6/3I/ck8s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d55c30-b5a8-40c5-a105-08dbb35e9369
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 07:04:58.5700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxz9r9gpWODmWZJc9dp1kmscUpoWOUrKomyixnveWy+28GAIGIPsyLIFhbnFTyO2pu2GkUXzuYmQoan0tfoYO1vCG9ICpGtFsHbEGIBC56g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_04,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120059
X-Proofpoint-GUID: _VMCm9yoGPwK1U7qHjUlNY_YXHCnORka
X-Proofpoint-ORIG-GUID: _VMCm9yoGPwK1U7qHjUlNY_YXHCnORka
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There is no check for possible failure while populating
cgroup1_base_files cft in css_populate_dir(), like its cgroup v2 counter
parts cgroup_{base,psi}_files.  In case of failure, the cgroup might not
be set up right.  Add ret value check to return on failure.

Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
---
 kernel/cgroup/cgroup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1fb7f562289d..a6b1ea324b0e 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1731,8 +1731,10 @@ static int css_populate_dir(struct cgroup_subsys_state *css)
 					return ret;
 			}
 		} else {
-			cgroup_addrm_files(css, cgrp,
-					   cgroup1_base_files, true);
+			ret  =  cgroup_addrm_files(css, cgrp,
+						   cgroup1_base_files, true);
+			if  (ret  < 0)
+				return ret;
 		}
 	} else {
 		list_for_each_entry(cfts, &css->ss->cfts, node) {

base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.41.0

