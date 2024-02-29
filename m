Return-Path: <cgroups+bounces-1911-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A1B86C683
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 11:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90269B29B67
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 10:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500716350A;
	Thu, 29 Feb 2024 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GHcwZ3yM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iQbA1x47"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CE863501;
	Thu, 29 Feb 2024 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201551; cv=fail; b=Sz5lXO85YCQ5bYtMVPMp2YNLrkmsFFskMpzVi0rA2Qpr8zQoPE1yBdbdYfWfQ4d6HfM9RaRC7d+dPu9SBnaF2drlaHtPCYIouaYH47SqWbZ9cmy8OL72nqZXcUaVc72Z6lOenCEJa9jdMhGr7t3E/zbRwYYPUPhnWjDwzQAR+fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201551; c=relaxed/simple;
	bh=bEfkuE/kZEUoBkGTrGatYYNjiBEg/WVbP9zdS94aJBY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gG/1A2vjLOyd8OtThTcS4Woab+19S61BFIzB7geJLmaIEVn4knHNWv88emPw9aOSgDRhD/sBDu9BsEyfupm0Bp4Ps+LSJmsq5AjggQhD7cWqSYTwvNpWPUVeSl/pkQhMCrkl+1Tdz5U16EFpwTMZpLBDrj4235L5LGx9R+3lMio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GHcwZ3yM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iQbA1x47; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41T9FYqe020466;
	Thu, 29 Feb 2024 10:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=cSj7rddjhuXKPU0unTMP0ct6rFgIQr8/bNBgCeLQcYs=;
 b=GHcwZ3yMBqc5UXI9Tk3Z6mhZtUzrnAYoOmelrJULd+dOG2l0TNx8ANms9kjBytmsZrGj
 yabzcfC6ITPiLOWJKMTCx7gjNb24GlKW6TOF+sceyV9l8nW8ddY6WtiE0w6vpanEWrjE
 yNumTJiWkNvESxHH8nN30eOzr0CTeBZIXq2q6z8qmBi9gr5DqCY0mrw2UMXTMbinHlaU
 jkbxqoCbrrffr/AFCVC6bb+XKSHLoMnQmvPanwqon1O7zmeCZQ41umYVjvxRQdmLLgGJ
 lMcaqGpGS2qciIwvEZ4U0KDZw7Tg4wlfBItodwA7z64bsmGMbJY5El8zTmkglPvWzE7L Hg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf722n2sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 10:12:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41T8Rivn015274;
	Thu, 29 Feb 2024 10:12:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wafbak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 10:12:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9Wcslcfkryc47JChSBU7HmrH6ARNgNSStmwJLeRdIENjcZkqWkQEaeHN6yIIFK29LCCrXz2i2kUNkJLMei7xJ3qRogkhxGLVhgEaX7DUnLD9zJuKYenTc2RXsZprH2iVgIbQK0U+a7Gc0WePztbpbaj/6+0lMP2Cw2mPl3rEGdqT0FjMF35jFKJyRfyia6WhuTSMZ3TVdYPLWnJ6Yb1n36xUbQg3sMg8+u1NzTrIf/L3ED1lDkrLgW4+C91REazYXUWyWlNpdJ7kAXJ0ypIK2b5l9GeEOInREjTUNV/Oc0bdWfm3dLCYXb11VrDC0SMcvCVmhXSEfRZNLj/hJSx5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSj7rddjhuXKPU0unTMP0ct6rFgIQr8/bNBgCeLQcYs=;
 b=mEWYmzw2lnvWVwWoG46rYTtiD8lEfHxaaqkVKTXVEJl4XlrEsZzH0pbjy/Y7n34DjS/NXh0Cb2d+HrpjFmgOfM32DOMoR0QP4IPyvQFKWz+mVIk4v/22lj/lp2EEdGA6062E2rtK24BB3O2nB2bt1XGbOk3jYIPuYL6C6YRlFIwFq0yOkUdI7SDPjhBm0z5UltAfjQdWb4CYISg4HWk47KxZryj6WkVpK0Pn3kzSPADzh7RyJCCZ2IqkOHZuEYmm+qYzIHltlikLUGyAc9mNGWrhsoqwwT+PlaD6OwEglGdIXHJcE/wfm37dtVcPWm+ZkY4bfnSgeNuzCUMbqwzUsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSj7rddjhuXKPU0unTMP0ct6rFgIQr8/bNBgCeLQcYs=;
 b=iQbA1x47AbqxaGQe2EmmQN/lfXUUq04o/KyWPIfkGJQtmLWhwEVbBAg2g7V6QWk7+KJyYzOegL3NSz2n8B3ml4mWcnxdGcUFHayv3tlcMBR7YJcdl26woyLRLkC7cR0Hk3yAoPk0QiFVJkNSLLeRhxh1k60LGdJTeYHdvAg+C5Q=
Received: from PH0PR10MB7080.namprd10.prod.outlook.com (2603:10b6:510:28c::6)
 by SJ0PR10MB4591.namprd10.prod.outlook.com (2603:10b6:a03:2af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 10:12:02 +0000
Received: from PH0PR10MB7080.namprd10.prod.outlook.com
 ([fe80::5bd9:10a1:f938:2ee5]) by PH0PR10MB7080.namprd10.prod.outlook.com
 ([fe80::5bd9:10a1:f938:2ee5%5]) with mapi id 15.20.7316.034; Thu, 29 Feb 2024
 10:12:02 +0000
From: Kamalesh Babulal <kamalesh.babulal@oracle.com>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Tom Hromatka <tom.hromatka@oracle.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cgroup/cpuset: Fix retval in update_cpumask()
Date: Thu, 29 Feb 2024 15:41:14 +0530
Message-ID: <20240229101116.60043-1-kamalesh.babulal@oracle.com>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::17) To PH0PR10MB7080.namprd10.prod.outlook.com
 (2603:10b6:510:28c::6)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB7080:EE_|SJ0PR10MB4591:EE_
X-MS-Office365-Filtering-Correlation-Id: 607de5c7-6777-448c-b4d2-08dc390edfc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	P1ycU8cG7JwRAGozywjxiiT200ClhwJTAdFoP1hqnN/RiE/nbVAc8k+99J2xiPzJ7Qemq96S+UZYpGAZufqwDBYzG238J4S4nXMW9XOk9WwkEPCV0/P9ld0DMbGRzP2BN9/c0/VsgXX8IvDBoMCQb4e2ho2f0Ylo019a4muMnAgWIsHoD3kIQevetRPdcQueO6NpjFJVdUJgjzVE87Od9Mo+ewApLtBy2Y7qtZHvFOO5y6m2QUJEFR0yI2qNwYERKnHfbn1UAYOT+7DzADe0IAVbwjhx1C0HOelVrTPDbsrD2KYB632Nz7h9a1u7jlMzatmOvCmr3HQxBi97a1R7YItxeLbtQMMxqYdmAZORwdvOFIraIEfn4OyMMzYjvw0lK8sP7MBF1JP1IS9HFolxE9TMjUxX/Ri+m9wqGhV9or9yooJPg0gtj+UwceN0llLLnq0Ac9zfLGDVwAxRUO0goUo+8G0OmTcvYFP7Kpk1qgORQ/b1ldTMHPV8cmuYGtzH1Tj67WmZODpywWZkVyYiLOhVOSDLIR4atXysFpmSTdG3+EVu5BlJl6NBWD/Sco+ljjN+6s7x3cNoOvz/e8p85x8feLXHs3VzSch+La7HTs6Xc9oNtIx9OJLIqziLNZhABPH3ZEl1y8xW4e4fe1Oidw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB7080.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ghXwvXWZJu3Ji3idirpruk433/0ksErGqFvsuE8HrqNkIoqQ/ifqzqLyr9zU?=
 =?us-ascii?Q?r3Fy8tn7R/eqBy2VSEARVAajI42z/AHdhdOR8+cdIOjJArYqL/Mze7NunON2?=
 =?us-ascii?Q?P4PN3v1NhzCENHQEgZpNEi3wOQ6XJiJlizTyNNJumWIK75OajTv6sl48xhnH?=
 =?us-ascii?Q?MijpjbX2tGwiuKQfMhMOaq5BgUf6XE6vGnEgTHVv4VihbYxIOOV2xmler0fe?=
 =?us-ascii?Q?4coSHe7o1cXKSFk0OYczFtwRWpUEDKbKN/oWY8kvvN0qhs9M21hJazytZOUR?=
 =?us-ascii?Q?mPrtf1fv3aa9Kz+uvhJm4QdRYB8spfl22M9O0M1XlbOoN6FltcrQes2S55A/?=
 =?us-ascii?Q?v6AwLiLtWS105r180VRyCZUWXc60XThr6qXDbWY4jDcnEPlm5jyrKwlwZsLO?=
 =?us-ascii?Q?93Lu9wuZ4o0Q+bK7EWhnFClLAJ0SM2rd3UKYC8e/hCODd7lwTrcl9J/tQ6Jm?=
 =?us-ascii?Q?01SRJ/w/GBsLQB+aCadFQaZYzMK1vgQf5S5O6ZmRG6ME0cj/CYsc+3Q9trzR?=
 =?us-ascii?Q?4hCQRRjJb4Wcst636wuE4zmu2jx6mtXbYc4dwHtaZ0uJSoyoozILWBXPtqSr?=
 =?us-ascii?Q?EuUcDwdGWXZktrG6gufjHVL791wAXZTKweI0KDxcSDYeOnLcXJqSKmdsbxPy?=
 =?us-ascii?Q?bq6RfrxW5IMRiWKrKsgs5IX7RF1pCvtp+T6dr3VxScxcsTQWZyHrroHDIN7T?=
 =?us-ascii?Q?bgaIqrnwMXsbdJawCok/7va83kxN4QibnSizMo9Dc2mMvTFgfgCTmyi3R4Yy?=
 =?us-ascii?Q?uMhmEBXNetjkwnixnYAQkFQ9eUNUzcP/NfKhIGYs6i2P3x0Ng0QP0dKriehc?=
 =?us-ascii?Q?KUTK84bv6Ke+k+ZnJge+v6CeNWJHVzhsghmqtDSJ0NRFDoKNmLMw1HDFcEln?=
 =?us-ascii?Q?v6n1Dw/Lt39Y2aj+rLqB+ChszDhF/uulVjR2VcvKlfLQFleLECsNhFY3tDWJ?=
 =?us-ascii?Q?vB+y0Q6EP/LV+oyw8HHS+L3JvNLoLkNU65FgKpgdjCWNQ4v/h9gxkk6ATxO+?=
 =?us-ascii?Q?npX/YzUv9b0IQpMgy+W+L1JkRK/DFBrsApw2VnpUcFlZ58FuFZbnosOVsens?=
 =?us-ascii?Q?hwyUZ1VTi9BXALYpJDcjYz+PbQjrXlRu1T+ziCfYcwAleQkC2rJhxjDaZ6pR?=
 =?us-ascii?Q?CQPkQCEbTzn51fNhDIUhHXQYrlY5rjwmh4DwR7TTvXyHxJOdxrz1HZPo2ys9?=
 =?us-ascii?Q?P0XrxqmiERdCSMzDzJWPC3kBb3RSbWXckck3tcrvOps/lzeseUYJwINKRI8q?=
 =?us-ascii?Q?5IMGNUX+lVAKGr7p2qmtRoG8sVdxej0Q/2axrZD29EuMPns8Fbwix4E+TS3h?=
 =?us-ascii?Q?u7WCND3h/4q0aTGG19ztvaA/hBlJxbCV0Hr4gGLfwCop3Z1V7pA4RZbsCpjb?=
 =?us-ascii?Q?LibH2eCsvZyXqKrgD/LfHNugwzKUxG5DeZchzPC3fjatWuDgLlWX0yuzrFrf?=
 =?us-ascii?Q?Z0XsH92CPxAIwKA1u4zE59vIpXA+shw2m+OCU0KLNhAEqHWpfIHNMgCa/NeT?=
 =?us-ascii?Q?WAWkwqN/HwyZPYODZ9mhWCgRv+nVJggGWN5DxYHuiXmNOZy+kBDUBsXfmWiu?=
 =?us-ascii?Q?IyJ3iHKyKZZxjOSbnR00xMrq8f17YhYtqu8jMXBhrAYWniWhYoCVb8iIun1l?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	F5/0b/MRNH2y4MjW6IJmpwTikagAQZdi22uzc9vAOEQMG6aZa7c9Cm5MV2FWT+sXgwF05Non5/ZSXPvf9bFfBJ+k+4t7FM44fH0XMLSo6Nn8L6qjawXd0z3q4YyfQ598UujaKT7B4lCfyv79QsgF1wwSXp8QdxDLsuaJo9CWA23MiYfzKOUXKkcYcSpZPDad3DPeQ5iAQDrfpS6zYnQ3jcF0sJhPekCy95I5zXCxbiVVLUAlHwfoTp6pNHS2tFsNInaMq8KBj5Y3SWFzjae5Dmu+5qpVsYSGzm/Kfv6ccAVSeNmMyfT8oU+Tokuip0fabxb/de1rfjYm1IYv5LG6FbCQIDz070IqO3eV9F5p0Nn9neti/OGJAzgdQeb2sk47N0ONjrEDgHShkgC0otqfgeWCXa8Obbrd2H1ZQ/6CHMBb6yUX5b1J7IPqhuFXDF3KnxxYA8Oy2bc2L1EO/FqT/YbQ4/KR8SmXEy8zxO2gmSHTHljEMmzgBDEaHxTVMpS9p49JnneUhLzg845S1wJoI1YnnUw61WMq8xinJNnnNPWF6VYqDgaSgbJ0Ivd3j08vM55cAzwOLn7OZVxiJ+QF5MtVqY2ERxm/cHvRmEpFXJM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607de5c7-6777-448c-b4d2-08dc390edfc1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB7080.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 10:12:02.6917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RjP8noqipW4hpaYfdXGpz3OepJghLbczsnT9SWYt//DAY1v71encV6MmGmIeuh10lMN4e1vlFUxdVZzQWb8LWqCHa0cqYAML6/QwDbXhdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4591
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290077
X-Proofpoint-ORIG-GUID: jIAC-M-2iJgC4AFT_gMs7pdgGrOsSu21
X-Proofpoint-GUID: jIAC-M-2iJgC4AFT_gMs7pdgGrOsSu21

The update_cpumask(), checks for newly requested cpumask by calling
validate_change(), which returns an error on passing an invalid set
of cpu(s). Independent of the error returned, update_cpumask() always
returns zero, suppressing the error and returning success to the user
on writing an invalid cpu range for a cpuset. Fix it by returning
retval instead, which is returned by validate_change().

Fixes: 99fe36ba6fc1 ("cgroup/cpuset: Improve temporary cpumasks handling")
Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index ba36c073304a..2ddbfaa4efa9 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2562,7 +2562,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		update_partition_sd_lb(cs, old_prs);
 out_free:
 	free_cpumasks(NULL, &tmp);
-	return 0;
+	return retval;
 }
 
 /**

base-commit: cf1182944c7cc9f1c21a8a44e0d29abe12527412
-- 
2.44.0


