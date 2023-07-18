Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937CF757764
	for <lists+cgroups@lfdr.de>; Tue, 18 Jul 2023 11:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjGRJJR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Jul 2023 05:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGRJJQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Jul 2023 05:09:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE693E60;
        Tue, 18 Jul 2023 02:09:15 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I7EEwH007087;
        Tue, 18 Jul 2023 09:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=rFasPADKDOSC2TcKkDrajx7I4WcLOIqTqUkaIuQaH0U=;
 b=0JCatPuKVv1VkyKA6jz/jj+X0g8I2QexfBYh/hX44zjoQJINvNUGl9HHDEk6qQZKFVzj
 AxGg5x2Ev4hlw0yONHpTCO8X7cNj1aXJsvIxzj4VO8NWPjwPxNaztLgSsDsLJoVwhRN/
 cfNMHMcehIx3vNPsuUiB8YzD8SW5VIogdUQibHdhOd1PlkEVSbXVbJl1J6y+VeVpEuxg
 J0OvuPqCoef/37iZeaY9dNgAPo7nxJvOLoJZ4vGl7Piyup976nf9pxUv+NOZwAU/oC5M
 sTD/H81UrtyoAOp22vpE1MBa3J6BhTu0Au+0QRribR5GqkLtQEzcEqRxP7G7MUjiogc0 qg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run76vmsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 09:08:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36I7tYAM038307;
        Tue, 18 Jul 2023 09:08:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw4sstn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 09:08:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hI8YrZ0fHK0qlSies2QkIwDtS3blxYk0nZ77EzRrSKV5z3Rwb3SWOSkUlO4z0YXPCRJBFMCOoitzeLw7tV9VaGranQVt7Umcyd7dOdbKHCi6/VyOc5jxsVIHe4MJMhwufY+pzdtIuLYKIgLXVEWOm+zy8ZthrACJ/Y1BJlEQvTEzF5mzVIoYNyEgCfEJjBEGodjVOUtmSPyh2b/34L/Zd2gNXCkGe++WToDim3g6rjeD43AlqjZWuJiVxjNtx1fj3ew9MV73Cpg9SEtlDnQQ9gboDhNOjFtK4qfFpii4yDB6fagI1ojL41+JHAybEocXb7MsvflrCpm+etKUoeMV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFasPADKDOSC2TcKkDrajx7I4WcLOIqTqUkaIuQaH0U=;
 b=FR3KVEWVcZ8cjagT3VRqBYga+1uKCea5oy1kZ+P4tayh3ZGF93t39hpahFM22yMI5EZwa9HhRvOUPd51jqaqFTwfTuRPvw8WOHx1DMVATD1l1ozEBKSs0vhZxFyIJabgFLkJpcwdeE82qWjgj9DJKrt4mUSsgvngVfa/SOfvF6mmVHS1EigS1+TTFSXnu9NeIqJ5sOmssKqTbt64ZufLxmLHi1Z9u7A4rDyNx9W8LrE9VNp/Rssq1Ny/EjM3zwGJFiu1F1AheHRg49Rs1Y9Ekf6GdH5ntpPX0Z1pBHijWJjqRos99jYk2oB2Au809ufrFjoOEBnpKCCx6UUhkrM42w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFasPADKDOSC2TcKkDrajx7I4WcLOIqTqUkaIuQaH0U=;
 b=RFhIkgoW7rByi2xU7U1WhNrYqjqd5xL36wwq5zhp9tH/FFfCdtimKyXH40yrfej4D6jeZfkhHvCapnt5f3EsOTYTQ1s9MboscyPUvh+lMrIjPF02N2x9ycq1/GBhfXTiZ51MNIqwpohSHT0sroMJMW+uzhv40N7LkMw5fTI4dhU=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 SJ2PR10MB7734.namprd10.prod.outlook.com (2603:10b6:a03:56f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 09:08:49 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::6487:e5c7:ca75:6268]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::6487:e5c7:ca75:6268%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 09:08:49 +0000
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Kamalesh Babulal <kamalesh.babulal@oracle.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cgroup/misc: update struct members descriptions
Date:   Tue, 18 Jul 2023 14:38:34 +0530
Message-Id: <20230718090834.1829191-1-kamalesh.babulal@oracle.com>
X-Mailer: git-send-email 2.34.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::20) To DM6PR10MB3001.namprd10.prod.outlook.com
 (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3001:EE_|SJ2PR10MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: ac087430-3b6e-48a8-ed00-08db876e9928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2TIRGMdKIh01dIi/CN5zsjNoaBpKR38sF4ZsYNBpNmeiOxLkbArHyoOv8t9ZqAHT4l4+Puuz384AjH3Y7oI3I82S6v3EDW9LPqQre2BWxWAsAsSUhmX5WdPr/Bl960wl0f+TnhpzmQcVNXdt7k2q9LCqo6BwcfyzbaHg7hxKBE0uz1RvSnmDmm+rQ4OGYSRRV2ycFaEJHTVQrXUyUY3mHTgZ8T6SmtW5VgR6q0zD/BU890qQesUkxxD62+U4ZXkTykhKBKzfrQSAUFt9jnGRKlYO54qWJys9JOLnGLo0VykcpQ80AI/uEQXdbDBgtwmQnqqrXEASDxwlxU7gnLa5tqMFZLA4mmTaScILrKEOUQkm57aOBPCJ9DFMltsC+GrY8gaLaTjF+cmz8YnmqIsTUNTqgLBSmiQGmKorc/xIzs/dK3k0oZreczBZwVzHQPZzD7sXkOJEPas3oh2N7TM2UlQE0cE4QIhT7H0wl3ZAPY/W9vtaWfS/D0/pwhcwjD5XwS2XJTmbF3IB3Eyky3Rb/+YILT/GmVVS8nwNh8H/slidltYaTqqRN7iQA/e6YEDb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(54906003)(110136005)(15650500001)(2616005)(1076003)(83380400001)(6506007)(86362001)(186003)(38100700002)(478600001)(2906002)(6666004)(36756003)(6486002)(6512007)(66946007)(44832011)(8936002)(8676002)(41300700001)(66476007)(66556008)(4326008)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N67pS8HbkYEMCv2s8N8jBMU87CHMvPo++gnbHymq5mpKje0oNYscfN7EtPBg?=
 =?us-ascii?Q?GtpD4DaewnKnY4+lYCFiC9uaXPeHk0fALfORCkQSY2C58DN6FyRjTxmvoHk4?=
 =?us-ascii?Q?R4DuvwN9D3aQTPzDZuYTZfSgYoPDmVFe5pMdxD8dSLKbz/4sAGu5kCI9gKOX?=
 =?us-ascii?Q?LcRVeM61oKktjIsSx1WLCUdFZ37HQQggBIjpqZJRXY2wv1ra5IiOy6wOcHT4?=
 =?us-ascii?Q?nH1PVpgp5ShBo3KlM8nlR4FVVMCkYT0UTw7/sEtP4YhAlr6k1wyFG+GUqfxT?=
 =?us-ascii?Q?8gEoCfcvEeGEEfJ+rNezCFD/stVFmIR84S0pyUjfTs8fXwXMzEvL4fkz2mn7?=
 =?us-ascii?Q?KN/pk8eZl+OC2Bb86xOndJCDXhmdgv9KuMuTcpEzQtnhHB7fMEAv/89XiAVo?=
 =?us-ascii?Q?BFO2FGsqsZdK2wwNhSg823dzBcGxCJsJKp/JlafGNHt4/h2iLHAP99YWnFBQ?=
 =?us-ascii?Q?3VO0XEoeolA5J4Mn4tvT+1wiT+b/gh6YvNazWSOpedkhngroJepZBthDKZen?=
 =?us-ascii?Q?BCFFTmbVMECis4a6KP3OywbS6BugRPNX+H+bOEPB59AIdr7G+qXzyUu3xN3n?=
 =?us-ascii?Q?vAE88ft44Wyaatyd27fxpjaL8soxwOISWQWNn5gSBoUA7sGBIUlMZHy2BQoN?=
 =?us-ascii?Q?t2Ci7KI0YOF6ixr9s5Dxt7NS509ew0hzMvZwTEY7ZwaI07RV4RvsixxrdDoh?=
 =?us-ascii?Q?rRTakvGrcm8JzBnt3p01bx4Wn/jVtTI6qAiE1qEQEEyYQ7jNIxvhSJhdmZEv?=
 =?us-ascii?Q?7sxh2AibElGlrObzqHj+ltV8Mzc4zba/7UE+JSeIe6M6josFDnUW0XhoasKB?=
 =?us-ascii?Q?ipjHDrswk5TdehIpqRoSC/0M76HZM6oERVUb547RG8HUwcdy2dHODyMLBRSI?=
 =?us-ascii?Q?KbAncutkh8FYhnL/rWb+CgVuRx1aOnSpt5IMCtRuQZqGP9HPgl5nR/B7zatl?=
 =?us-ascii?Q?p7a/MsnGE/Hp0jqpa2FDBKQDtsJynHynlIPMjMK/RmKEbN/hj4l86dFWPQ9J?=
 =?us-ascii?Q?f3WXjeVfy8PkPpgyzQBMED+0bwQPl9jI+QjFN+KcchsvCBrut+lho4xHylM/?=
 =?us-ascii?Q?zWbfHKwtmVwddWskGD5ViWB82+yqUYSyFgHPLxlRqB9wZ5oWLWEo2IWKKyGf?=
 =?us-ascii?Q?fDyaQWgKIzrwRDFPuN0ntwgCofbZzM99f/ZnsuodP7bB7M20NaYliBP/grdM?=
 =?us-ascii?Q?IOVRN7PRw7SXY7+E7GfHekO/INQt7pATYpyxDtTiub8yC6Qo798RCm/ZBe/w?=
 =?us-ascii?Q?8f5kNBsE5IHSQfwjSzTFVweH5WnovVwXlEMfmqj2eOAK84Xs+wayJ31YwUKo?=
 =?us-ascii?Q?jT4mNIz0UYbNTEhYOngUDuluofszgzdTweQhTABix2aQ18/76rwDYFe3HBS/?=
 =?us-ascii?Q?HVIsTebwK8kTgZPoc3KAiNf2NzOb9rXgSfcUApktQKUWtZwFR9XJ1fiG3ks1?=
 =?us-ascii?Q?zMr4YqciBz607h0mnQso4XtCLNlyRbqjGkTPeJ9EticZwARuUt4r4r2/C9bj?=
 =?us-ascii?Q?q5NYKGL4cJFtI062phelKuTWjYwVmXT1tx6sMP+lL3Fbg/hMDFSK0QDb8KN6?=
 =?us-ascii?Q?uF6BE5IOXKjrQcNUSrFWXunDqDzrtpqD59YG51xyTNULl5DVjz6zyn3efFjP?=
 =?us-ascii?Q?DkQGnKWRnEEoOPu9VcsnFQOya7142nQMx09a6dtd/gRwNIpjY070/YA4LMHG?=
 =?us-ascii?Q?2e54Fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: w/KhudZgjQ+FtuL3rfHmxyfxVd5QBPqCJz9o/5NlsBpjRXo4LPXiDhu6fhbycV6bDbQIEtO03QrjV5I77wVj2hbrUWtlh775uVEtEWwGdZLvuxKAv1uU+csJzwto7tWKR/7qqDoc83Ju/PansMg6FQoaNqexpgobOTvGODT1s/Jydjvkz63AQOxGsyy/7iumjvOhC+qJY3aSaIsAm0b8Ke/PjwsJJYMbgk4kIcl78lT9MfX4710WnpVUqc5O+n5hiT1RiE0x4LxVIvs2HTj7Oixu9hBcn3e/IM63NnVGrRoxxnoeJw2mepvvv3fb87gAmsKa/KvxqzOz5LZRmi2YhV7q9KP2aaYOqNih+K1dWDbRDvozS5FMCXvSD4ZWazTR8K7JklxykLge1/i4+LKvCG4b3rUfPaTWGUbRICmm8Xy/w7dJlhucnM/0uVd+JbU36jCZZ5K0OAJ7oDMNAHEB0I7pknEnJy8PLUH8PUKG4C2iUfsw/5mR4Y3UkJYRGnmmud+azUpIu4Ge0cipVHNp6L04FDCzbOEixDZOdXf4NoTFvndGrja8Pc3j6Lr5sNryN1gZ5tM6g2wil5rixirIdFUCcF9zkcahgOcrt/ZjGaAlB7rdNXKzslsRxi2Ggs8mgB7t92nzohlrUwjbNfQSXU1f8SIDTL8kx8mudV247E/S+j5rXpDMy/JnY4qif3zDqyam4cQ+6D6M+hit1f7h4BEUiE0UZtRwueIMTnT2owRQrAxgmzG1L/cl19wgFjrYxTJdtcOW+qsSe/nfgVGwmqiOoLP6xYhpvnYwQRfvCh150DsKxDN9+XkjOoyeUFsWiZow0K+HncVaVYkP9AYu2zKoJIMYqqicxjM/8dbbD40=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac087430-3b6e-48a8-ed00-08db876e9928
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 09:08:49.0193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kENAcDqzhpNh0iyughcxNpf6h8frEW17GtqdrQCHylVdkMh7PtTYrFIZwXOd0z34aqMVvNL2GRiWjk1mNmAnSKIwcYKtOCCpPWaDFkqyaaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7734
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307180083
X-Proofpoint-GUID: PJw8XSaPR6umYQ_YXWY13m_V7D6RDY3v
X-Proofpoint-ORIG-GUID: PJw8XSaPR6umYQ_YXWY13m_V7D6RDY3v
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Update the miscellaneous controller's structure member's description of
struct misc_res and struct misc_cg.

Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
---
 include/linux/misc_cgroup.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index c238207d1615..6555c0f57158 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -31,7 +31,7 @@ struct misc_cg;
  * struct misc_res: Per cgroup per misc type resource
  * @max: Maximum limit on the resource.
  * @usage: Current usage of the resource.
- * @failed: True if charged failed for the resource in a cgroup.
+ * @events: Number of times, the resource limit exceeded.
  */
 struct misc_res {
 	unsigned long max;
@@ -42,6 +42,7 @@ struct misc_res {
 /**
  * struct misc_cg - Miscellaneous controller's cgroup structure.
  * @css: cgroup subsys state object.
+ * @events_file: Handle for the misc resources events file.
  * @res: Array of misc resources usage in the cgroup.
  */
 struct misc_cg {
-- 
2.34.3

