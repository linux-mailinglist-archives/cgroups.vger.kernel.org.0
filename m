Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1666E1BE8
	for <lists+cgroups@lfdr.de>; Fri, 14 Apr 2023 07:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDNFth (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Apr 2023 01:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjDNFtg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Apr 2023 01:49:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF902D57;
        Thu, 13 Apr 2023 22:49:34 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DKxKsf015013;
        Fri, 14 Apr 2023 05:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=OsOBWYvu/Lm1pD1VvzZJTfdgLTp7Ke02iEezDWNfZ7A=;
 b=a4HqpPhskuLwya015YsqoJ038Vyck71G9OZ6m3QcB4kvw4Tv8yc+Ux3sU4b6oD6oDock
 f5Ar3Mo8uXCRKtEZU840k5ba8637zXtsm1HXhqzLUQ8iIz3eFLBTveInYlx46WKTjK0a
 wCruRy2pHWX1Wpfca9oPRtQ7wUmyvOO/EKvJFQ2BFdYHkMuIiPmLMF2Db19LlBRnbBil
 8xMK8o7u46kmwN/0sl5YalXiE/dj5L0IASGLLlZzKjEKmM1hs3I/63NjYpmPPbigyYZw
 Ap2I6zpknVfXGEvaVQRMbvDmYRdJEkxQalzNZ+EQOMFulPk3W/hMW/Z2GUyE02mFE13c HQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0b3580y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 05:49:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33E4JCVu012885;
        Fri, 14 Apr 2023 05:49:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pwwgs1twa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 05:49:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+owpYQMG3ooYGvYNiRNs5QugqZFIrd7OAYbPRmRkQJb4Tc5wwhluooqWW/xKuJDeEGx1pvYxrX/F+kpyWkCOEvPbZvwZ9iSHQ+u+VUT2DfKgmwjayYpjHk+1LFP7QSVczNcUJ4me+bW/IPSWxCf89ZkrKM7qHnFi0p+M3XTQnjoend0vV5+BKtjpMO/0gHwswuR8d3IRzQ51PId8UHxKjL2XTaNspLy21okzcTI1DOu3YoagjgTqr8gsPI4WLr27izFL6XpId3kCBI3aw3aQCvsL2UiL6whgGioyQxp5+QX93mRTAHHDU3Od65DHYVxtHj6JN1r41w4EgZrZKQBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsOBWYvu/Lm1pD1VvzZJTfdgLTp7Ke02iEezDWNfZ7A=;
 b=lB4R5pDFv+W4yCjV+cGnvPt+joULS7HeP02wJ+w10RBhPZeatQ1jndKQ1NJA/Kf8WnfyRfAS4bgG0zgYsCu99Zq84CjA+IYExllP8yopDwcDaS1Jmj44TilmcJ2KSrpfCb/mhTd3UqZk6BneMKlq6cFT5E1WEf2QZnIxhIGuJyhb6nzawIAAOgvIjgDWgHgWGvd0jUjmg05KN++81XepiB04GwxLDd/XQmot+9gxIKaidq6wHJRDo4131JOab7hK+E9R/sc5kOj91ahFk7uUCta/yPPkVY5+k/VohF1AhWSANodWWss1AbzgC1GTAPp3ks9byQqP55BTH9z4nvq13Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsOBWYvu/Lm1pD1VvzZJTfdgLTp7Ke02iEezDWNfZ7A=;
 b=bFp3leX24EidrRMY75GwDhxyf0di0p8aY+BYJV8oEZA8Jj259TA3RG7NGizJrpbg6lxOOHvoEX4TUtfuwxLzvLh5fDUhFcimvQcbXVP4JpERuGB7K0NCYvcIwUN1VJWvJJxwjBGj308Ug+aT8QVLm28ioIrki5/XOBiIG6IUrPE=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 DM6PR10MB4169.namprd10.prod.outlook.com (2603:10b6:5:21b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30; Fri, 14 Apr 2023 05:49:02 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::86d0:5648:fbdd:6c84]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::86d0:5648:fbdd:6c84%7]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 05:49:02 +0000
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
To:     Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Tom Hromatka <tom.hromatka@oracle.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: cgroup-v1/cpusets: update libcgroup project link
Date:   Fri, 14 Apr 2023 11:18:49 +0530
Message-Id: <20230414054849.320414-1-kamalesh.babulal@oracle.com>
X-Mailer: git-send-email 2.34.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::13) To DM6PR10MB3001.namprd10.prod.outlook.com
 (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3001:EE_|DM6PR10MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: a576c717-565a-4a18-6b1f-08db3cabf2f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K0YfK43suQfBevy2DdgoCK1jJkgfs7VTctBxHGFyU8vyM/tWNEESANgCqrALGrd6jkK/roio4GMqdYx3xDszTQ26HxDZjNb409eY0o8xhiCQIDQn2v7LeEOQUGXa7qO4Eret3CVZaOzlCy6Xfk6ubvCGyJ5DGFf5GI5hnaJerp7ug0WChh2wb+JCZcoTcLXn/707cb5P5qHVLQ7hSwGRO7lrhRTB7XKy2KSaDSbam+PAeGRY89sndPcSm059kqF+l+lOhUiRQeahf4aoM6uiRZ/A/DrYgz+ZcFQ3BOfj+9W1dLWTUHEdw5wFa/OCQ7YbiWyGc0CZlWTjXlhYztCCx0oxPW1GE5VHL1RvaMsHvULq+PB8CqJ9J1sV/Wd+b22d+28GHKwmyMOHLTA5rY542RrjatwPekqbQ5ImcJwxboda33zD7vQiZ9mkSvjJxXvaSOwT34Px+BbZkWZ+OnNbVSuAl7Z61udgJjiBQmfqj2tGUcRhbHh3OMrfS7uuPYhwXRtJwzhEc8gYb0wo/ygND81co4WU/ewb3XxiQzukf5kgipLealMDHNmucE3UFfyCRysksR1Z41J+qoIbpbHc4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199021)(86362001)(15650500001)(36756003)(38100700002)(2906002)(5660300002)(44832011)(316002)(4744005)(8676002)(8936002)(66946007)(66556008)(41300700001)(4326008)(66476007)(83380400001)(6506007)(2616005)(1076003)(110136005)(6512007)(6486002)(186003)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HUUS//C7FP2HgsC2/xnKcZverlGCZjHYeFjbyVe64CtoJT5DGCkdOxQpuf+d?=
 =?us-ascii?Q?ynyYDjH4EPyFvILHm0OM96iEbdfYJvUMwdTDHFf2oySrBK9ibYaWqypqzE3O?=
 =?us-ascii?Q?hgYlBhYHACdBmwccFXp0OyeKGOJ4zt9IGqwZLTI2uWKOQbtCdYFnck2sj50J?=
 =?us-ascii?Q?RLyDFAdNbkjj5G1JTS1Mj0MBoF73j9rEDE1utOU8c+IVRpnvopsAGv+0cMWi?=
 =?us-ascii?Q?UTrAJvRB+J0Bo4cU8tvzYdsx7WEstdXXnsOin5aSbDFinNRQGDOWTZ3xWawe?=
 =?us-ascii?Q?ZgNszJRgyQQD87Vy3PQ6Lafkfa3OCHYKCpKGNAq0hI1kP6lX81YlxAUpgeth?=
 =?us-ascii?Q?lPYV23oF2r5I0Mp0YJanndRNgmiGMymrBHVlpV86Xz/auWAJo15zIc9CWg8h?=
 =?us-ascii?Q?hnEYKToBE7KTMhNaoMrqNKubUuvFUMxcm+Ls8Bk9PZAe69xj99vlIfeUhVT3?=
 =?us-ascii?Q?DGZATD3pJhgF4HRosrFW0cgjUEkwK85M0JE6Q0dZsXzhbqlE/Q1SGuZ+cGUn?=
 =?us-ascii?Q?p7I8XDEK+6lYcSvh2aPrlGBBUNXf3bA+Jq88DBXPPcPzOzaN5iEZJZ9TM94u?=
 =?us-ascii?Q?frXL5nx3/8Ur39dWmA2evBOTYtZKogyxJujazX4fUeMlwnq/M6vuL0fXzEcZ?=
 =?us-ascii?Q?lHt2wsUGkAyx4U1Dh7hMeVU3tMEZzxoE2ScIaZNlMtOjuTDwgtYnllZW0wQq?=
 =?us-ascii?Q?Bsokm41mfcBChmkhY6AWqQTZgjM/ZKuv0vUeDeyo3YlJjPmR3+fxfpF+Mcdh?=
 =?us-ascii?Q?3+0+Q7LqjLXImLvXe0mPWKiGTqCQ+XMnEiqjPnZQCmQ8WHqVf0aSusjl30VP?=
 =?us-ascii?Q?YqUy4QmuU8TCDAJXvBe1fvro6yhXQzD43CLfJpSl0KBPnfet1salDu8lb3Ia?=
 =?us-ascii?Q?k8Vu2jU+PUqawqmggp1T1j/2haeMRouZcW81VnvjiLdf+4kVJpzw81mhyfuq?=
 =?us-ascii?Q?5T2v3LuDa5HqMnkH7C3IHXZirME+8aO+Guzlonw9xGgtC7/6VkzNNsZw9dfy?=
 =?us-ascii?Q?IJ4WqH5j+WX3Cq6CCYlATftFdzwWGMEUllHwPjcNyNR6h4RH09VD3jGyV+1H?=
 =?us-ascii?Q?EpHO6g/QuruPhxRXMSp9DsuRIiYdg1hmrVCm58zAPcPCf8njh8OV7bLosRhu?=
 =?us-ascii?Q?fcaXDImg8VS6c9Ecplc6bcs3q4aUvy2BbFifFdyNkouo4MjY4mcqP8BuwsFT?=
 =?us-ascii?Q?JLOj+he8h6kQtohe5ESb524508r/qLi1YM+yJEvlzclOCvOtdF5fnCagOFRP?=
 =?us-ascii?Q?Y5kgnYeST6SuorMnfz/Yh3fY0aYyx9VKInR75G388TxGp3o8q4l+ra3f2oQ9?=
 =?us-ascii?Q?5rTQl6UMlTmxEYkuRaw2UeRlOiaMm/4AevN/8KzvCMOktKU0qPEs5WoBi0kS?=
 =?us-ascii?Q?t39GyiJhtUsOxaKxcnks4SHMDEde7tFpW7RmI8CcdoFI+B9vr7rhHF3Ent8I?=
 =?us-ascii?Q?VgZydYchAI0pKEOnNcU52Usz63TXfHKd4VLYjK9L7fqmU8Z3ZbxCMUXBV1mw?=
 =?us-ascii?Q?GUxu3DcDLJ6eXdlLqPD7iDLdRvzG8xnvpUAk1rm/kVMgMtWxDcg3SVPXOgVo?=
 =?us-ascii?Q?9/hev4NOkZADsf9s4nGKQJLtCiaWuem1o7UwOiqoXb1D+9HQhGHeD3Q5Cav6?=
 =?us-ascii?Q?iIf9L9+E9jb1f9ghLNX+HlWeZE+78bwSmQ0LHgCEHOQ1qvH0hM4A25WfGrSJ?=
 =?us-ascii?Q?ECUhOA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iaascX7zpAFr1Ms+y40NwJ3a18yvuJURP6FLi8K8kStcSnT5EX544s4XdvX/2XPftnMN2MKGLonlYOgU7XmGX+Nt4X1N9Yl5wJhut+tIp/JfmvZoz4wCrem1h6QZRXNh+kBCeC/HSAuuUlZVaHu5ARfM3dpcbub5XhFwVfQWOnVpmQCtRiD55ZOdoB8EMywRBP6gQQaysJMb9JQIA3bGaHVIVHwNwQ+11T2L/yv9MmY7KoYiAJ9NmflwuElMOcKJveI1OByPtIZPWDFYf7Ox81jcGl4et3Bzy8bRAsGzcRzUEDGZ1Xj5srHz3MLW7QEnCQIB91JDjtV7PUommUQEbaMZeOukpxTk6gP3Y4UFqDYDT1ZvclTnYIIuvA+cLik05fDopFAGoS1XF/F0UJnnhLEskicnGsEpm9rNz+DAY6q/8CmT42CJ8Lu5tEPT+KZ3KCWVHGnogsLpgqS0ekwFIGsw6B9wu2DpAjFwIFAMWuvhey7/Y72ZjPVrnVjobfTUvUsRmd6kcmRM5W4Io5PqakRr2cV1t+c7iWtdlgkOZ2BDfv6DfDkMs8tqrXE2PXP6OQvTOAqKyVfx7wQCzQYFBzm4rUQckDm54XvCNwsEVyZ+TDxh0gR4/6rQMGAFRzqOlED2Rybcedk2j+T67RxyEr+Rk54e0bWK2kwlqufWjAlwAw+v7lmWASCgZrZF03CiTdtYfwd6RNMxVze5s0pEPV9Q79F3c7Mbj2wgjgHzd8VAddJ8frbcbbe5FlZr5WbLI/7yQGL44PoTitGkXLwAGm51oMOpjEyVeGUq7zawlUv8aXt2dVwyvzI0GDK0CUlqGwn5NqnLNnL3VOJlSczInehIdORB3lS3R6CrZUXbfqC6oGuIjIVGBhxPBgWO6gdzDtmcXO7JBcspRlMFbufXoSN7JEfJnaXCzCYZg4nFmNI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a576c717-565a-4a18-6b1f-08db3cabf2f2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 05:49:01.7709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7gzdb4Aq2grufxyGpk4ytgtakp6jayKtx1cWYy2N+XfTpgEE5g4B/oW5YQdtDlus1wPcld/yR0876voyp+oGBt83RCJTxjDGPuaJpOez9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_02,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140052
X-Proofpoint-GUID: wB7kmc13DVfJNFsTHfGapU43-oVrcbTy
X-Proofpoint-ORIG-GUID: wB7kmc13DVfJNFsTHfGapU43-oVrcbTy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Update the libcgroup project link, in the cgroup v1/cpusets
documentation.

Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
---
 Documentation/admin-guide/cgroup-v1/cpusets.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentation/admin-guide/cgroup-v1/cpusets.rst
index 5d844ed4df69..ae646d621a8a 100644
--- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
+++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
@@ -719,7 +719,7 @@ There are ways to query or modify cpusets:
    cat, rmdir commands from the shell, or their equivalent from C.
  - via the C library libcpuset.
  - via the C library libcgroup.
-   (http://sourceforge.net/projects/libcg/)
+   (https://github.com/libcgroup/libcgroup/)
  - via the python application cset.
    (http://code.google.com/p/cpuset/)
 
-- 
2.34.3

