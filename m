Return-Path: <cgroups+bounces-14455-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOp2LaUKoWmJpwQAu9opvQ
	(envelope-from <cgroups+bounces-14455-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 04:08:21 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1DA1B22FC
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 04:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDBFD301A3A3
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 03:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA7830C60A;
	Fri, 27 Feb 2026 03:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BY1nop6Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HYk/ZMtR"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C520C30AD02
	for <cgroups@vger.kernel.org>; Fri, 27 Feb 2026 03:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772161687; cv=fail; b=SlCTI+NnddO341mzKjagratMgxByK2VxvacgFlbtQ5ZIZd/HJmgYJgZ93pagxxHfm+cysL43IFzUAKg62fVS6CyrpTSyI4hdPa5FzcUnCm1q3CnKAsrQJFRfDcUcKa/TeuoHGzYGmHkvTP4+AyDKsWVeDeVaKhQWbIqIlRuKe+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772161687; c=relaxed/simple;
	bh=J79faxP6KaISk7jbrXGBGJOthYYdK+NfR+iY9zAf/CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eqWc0yGXPVT/7KgqIW6OjVBPzSN/y+uJvCqNMHnEpq1QMYqMkJiEFvkZKeeiw0N/gPWQ5j1fan+v1bb0TqOGapVDJZlumbaQpk5/ACJsAfRAHX0xYHgODT9VUt2MPTTqNx8Eo/s50+7yCHMqJXjgx3QBEGUO7ppeA5RNpgQ6ATY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BY1nop6Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HYk/ZMtR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QL2ahD669812;
	Fri, 27 Feb 2026 03:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=YZmbpr/zczQv/qMD77EqHFB2rlL9r9Ug8jysY38aN2o=; b=
	BY1nop6ZF4oYLJHQjUk/6RocSRZyL53m1nd0nWnUwNDA8CEVespdDoMu1lWDZETl
	FeqWwE/jQYbe2QAaZXVJkK/3nTvn69PMObeSfolO3Ce8A8IGVGd3EauYGW54qR/d
	Jf3pQ0btFtK6aZBg1cB9Y/mmTo01mFUGtuBz3lg2bHX1GCbtsERrGDJWWDAigTSQ
	br+UtjC9BgkKWCXkOxbb388JlzlkNH0IV8GbX81ms5wDfo33i26sYccrUhHVFOUw
	pjcJ6JP3mJu9MFjvUhje5EuYNM+gw01Olb/W97UY09TKtQbwR1fFu5ONNPjbhQIS
	mIGvQexOu1mo+DA9HOhgWA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3m81hc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 03:07:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61R0g1LS006268;
	Fri, 27 Feb 2026 03:07:46 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012059.outbound.protection.outlook.com [40.107.200.59])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35dj11a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 03:07:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUyRQXXej1SDzvgz0GlIGlpCYTt3EIyQY+EZHzZCs4+N+v5AeJMDgtcJbnOcbIKPc3hb0eJIwpx5C4saPSxEDXa16NSje0nAizYX39+uo+cynlb9ILZTaZwhf+jnPSHJJU1LuLwAQqrw85XPQhVPHdHOa8l2NgpqrCd6qaB02hUzGNr9JKGnTy7U/c1nJF9LWGILPI1Gl0dsTPKe+3buhvsAqvYWgIEGd2oxlKOUL1x/O0qacm2VTOmiGUtBzO0q+987rAPriMQx0c/HXT+laXF0/X2gvNwt4ukpwsiv5RVHWUq6ckKhIK117EWtmgOBGzIL74TLZl89IV3UJjgGSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZmbpr/zczQv/qMD77EqHFB2rlL9r9Ug8jysY38aN2o=;
 b=ac1eyEhaHePuQsHrv6wxuzNgW+3I5AT5e38RT9ieMbO6T2R7fDisLsb7AgZtAk/7sxc4gbeuz+N8Kx9I0WYI/92/I0rIkUkXt/0dEqIOk/oU37YavMMOBqwovTWpgx/KnLjr69Cfzyu6gLbWrl9WjCpmHB9T0JK6mttLRDv//5zpvnGn2D+2m5DG7KB3MDIf6HoMtSnL9b4khoauabcyDyeRf0X0+cZurT1enM/na6v6cg8NJRnIufEzYHFPuI/q7oBU2v/KxXHtktpZAm7sDvndj9aBTQFwJx3OPVdB2K5Uo9Q8QMuMm9OQBTMjRb6qQ6P69cQMjLPyhV3WN0dEPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZmbpr/zczQv/qMD77EqHFB2rlL9r9Ug8jysY38aN2o=;
 b=HYk/ZMtRymCjqBB7llsRvJvShUbZT3C0OiUa/HW7vOQWOvgGo5TPBgX77RJKjRljEtKfrjFd3BjmApfA+S1qfBmFF5doxMz2AOVUjXt9yA4L784DXxZ/H1IxZSiyl4Rz46nqyy1qSlHSduSDc0S4ef6ToU2zZRx2MAPgGLY3Cak=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA2PR10MB4537.namprd10.prod.outlook.com (2603:10b6:806:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 03:07:43 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 03:07:42 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: venkat88@linux.ibm.com
Cc: akpm@linux-foundation.org, ast@kernel.org, cgroups@vger.kernel.org,
        cl@gentwo.org, hannes@cmpxchg.org, hao.li@linux.dev,
        harry.yoo@oracle.com, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        shakeel.butt@linux.dev, surenb@google.com, vbabka@suse.cz
Subject: [PATCH] mm/slab: a debug patch to investigate the issue further
Date: Fri, 27 Feb 2026 12:07:33 +0900
Message-ID: <20260227030733.9517-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <84492f08-04c2-485c-9a18-cdafd5a9c3e5@linux.ibm.com>
References: <84492f08-04c2-485c-9a18-cdafd5a9c3e5@linux.ibm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0184.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c5::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA2PR10MB4537:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a15545b-c56c-46fe-480f-08de75ad5f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	2iLyRGpKurtPYdMyGRP9hE+lhQ43J6Uf2NjA8DflQI4qI9kBopOL2dEbuLXBl2esIlRuct84l4fjpr368Zuoz+bI4c6vxqWP67TBIHvWcG6WUFROS7vfYuUuYM75JqJF6Qk1YkzUh5jKZxVy72Qa61LYFcGfRLWNvLMs5SRLAAjoiUgNbdwYgU4HS9q0EAL4R/XYk+l9B1KemOoTw4UPzeRoUwfqgcVfL5pssYaSZtRcaRitU55ACQs2EIj3HUB8IssYlsJsNRZnPpLa3SU9v1mq7iaYg3xMhO0sFRHdwpti02H/nY9w0Hw1IGlii89nqO2mm9AIFOV0Qo2+uzAMKNRgVRYh45JaUwPct9QmTnKpFZRcvAlgDt6SfGOROtreAE7hxIr+UYAHBHVSgPjdz4Hf1yc7UXyJTDvZwjOrdBH+5cQbVg8jW2iXJ9zWcnpIYRzxDgeHHA/zs3Qzyd68Yqz1jbiuTuzFoij0umiVNsKnghlILJd1VkEp2xxgh0xKr/UXCCpQmMcljIBywkMDbm6R2+OY3rLioz44qg7ptfZCo0L9ujhb2t+waoGA8N/EsdyNEXXJjLbufZecVm2uZWSwzZVM8QAzmE6kH1Lt5SeGiixtIQJHCoz1Op8FsM+laVVuiJUYyejGULkRR91iKCLAYVMvTx8/1pXhZZijn6HXdTlF0erOXt8i+jg90BWkhnHr4Fm3wr4t29CCEhhGKBz9kWU0SU/e7Yxtg4XJa7E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?igCQonxkKCF+nXYLT3uxgTPlHpku49VYTP5MMuYBqhdEcCvvXGFjEtkdhDl7?=
 =?us-ascii?Q?2WBtrTpUi5VUlszrWbXA8lrI2bCENI4Svvw9eB5afB5d9vLoPYnbZl2HjdnI?=
 =?us-ascii?Q?C7bgeCSsA6V0PfG6/X2KnBYXLlHPWFOLjBtZnfbWlQ/N+bK7f39CzYr1Ye2U?=
 =?us-ascii?Q?tMg6WDl54RMh4d0llg2rxjWT+hvVfLVa24GR4PBEded7qYVX/TCtjdVh9Ch0?=
 =?us-ascii?Q?ighCqZs+CvwO4mFHJMV7kYG6poksxTqWMsQoADsAo7oclklDujjMnh5pfOml?=
 =?us-ascii?Q?y32CWeiLgQjci2h8J3LVXqHsTI9tQ1aZmO7QtgQ2XozcdTsttpqLp3Wil7y9?=
 =?us-ascii?Q?xKhbcMZrYSYOdP/ZI6Zbi+zqbgypZiXiBPIBJUXz6NuvS9xczedI10ZRXNOZ?=
 =?us-ascii?Q?Lk6mLVniwJewo/gE/KXVdXZ/NlHDqEXJvXXQb+M7DpsaqWaDQ4+qhBYCqs+M?=
 =?us-ascii?Q?cGIa48uUMDSGGIw9Evrf0fFzjHdZr1Vdt+7V/FMzEBYWJMhyVAVzyu/IInRn?=
 =?us-ascii?Q?VqDTHh2giHTSLfs++dZAQ422eGhiqTm5XG2Hi0mARbNbuTpR+lF7wUgMFgPY?=
 =?us-ascii?Q?jhfEpOC318Plha2266z+LiRECX6plOurumRxMSzrLrQGJmN7qj5DMwCy19GZ?=
 =?us-ascii?Q?Jt1WXpNYhyEo754B8vHbjMsNM/obOZX81uR1PNENPojxaQ7X0k+RP8KjJ0Sp?=
 =?us-ascii?Q?SNP1mMSfu3iA9IAtOAbajBlBc1jctPtCKInMRI2RNR5WJe7xlY7SEr1OAlSL?=
 =?us-ascii?Q?kXOpUgTGBsjLnXFkI/ij5Pz75ZSgAAz4KtlWLYTt+6PvLIlLDvNNPrgJ8wnm?=
 =?us-ascii?Q?lNt2DJH1KlfjKFC43B/FEPwnLGSZ0bN9l5DRw45FivbGZmEYdQIGi6ObsfKs?=
 =?us-ascii?Q?Rt5qlW1HMtxslJSGo54YJl9eGesgaXitVVaJNZL21FKNPm2L6vuXluYAOrSo?=
 =?us-ascii?Q?p4En9hWSHyN4ipGIvOVtU86njaWL13e4ybQowOtRJfHuFFj4rfanf3/UExe9?=
 =?us-ascii?Q?yl2emTuyAFQW/x1zz+W1VHPEYF1dM+hgdncvpMm/n/iCokH8j2KhipiwlZM2?=
 =?us-ascii?Q?S3KLGLwdtBWtRlficZPehXOq1FO/7+RLAdTZD7fHjkpYvvnaO4kKfYQaMVNh?=
 =?us-ascii?Q?UpY9Q8AavfIUDfWE88DnIWeaZScFn8z06rHJmot7zatMFCpFPsF6u53DJDPS?=
 =?us-ascii?Q?XHYvUNV8TlM6pSCKP40OnJScd98E1ZFjFsUmezhJs24T6dGd16uN+viQYEF/?=
 =?us-ascii?Q?DcccUMOy6c96c8VaSC8N3cZu2vCOx3txhTNWFxz3W/+4aFTkguUm6ZNmyJTe?=
 =?us-ascii?Q?xs32CeAwCJCaF+YfBeG7B6PbrIZbgbOPvRKkO8t+OzYJW4kcPKrBxo8Vl87A?=
 =?us-ascii?Q?JBT+MgXa1GkdW4tOai3dL7tGoGZUrKlx4FFhx/08rg5TjnnCjZ29g/I7vdEl?=
 =?us-ascii?Q?5PJQDD2YA88v5nv36q6g17YsJaGm4DWTuKr6fa9Edpu9ui54C6DhLWVNebFk?=
 =?us-ascii?Q?23w7zvjq8nBEHX14bRKpzd0wwmQI4c/dbkokQybi9x7MTNKXkehtnrqrAAj7?=
 =?us-ascii?Q?8E+s+CwI3uX3CXeinizAHS+pN6Vz5Zo5IXUSWLTnXeRlhrKbuQmkLJZzcS8s?=
 =?us-ascii?Q?gHre8IFU2jssgqTlaoDMlcUhyTkjxFSxVmoRJLeqXOnYteUeQwvmCIkYFpLg?=
 =?us-ascii?Q?EfoD6sQGVF/3oBNbl9UXf6yYA2Z2IRl4x/nypliVMu6yW16A+m4KC3BPAIl+?=
 =?us-ascii?Q?WQhKDWg4BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LE/HYbtxHo7RYcW3ZM+aTCVS5ZDrxt+urB2unvPpZE1HcbLijDEuYOqS6gBEpKyOTEPeTXiFhAWjT8uKV3KvXUCdCs6CIEN/+cXVlGYosEYh7HZqDgj25HsdoUiLVxLY792QSXPW1sD8bnDixc8heFKBPQYrtAVSeqd7nisVmy5lkOBMjEPCVgMblhSMTSGNh7406vkpz98mDpuJfaad8smmf5CVyw8/oaNWDmfdB8fweS8vwhjZjuOKKte2PZm0L7VkdNLE8hGw+gowIToZYq1KJerfiQ8VSe3FMpXYngduuJ7nlAk/rXG5PFkE5MI0yAkaZ7H8E5VBMOtWCi7Jr+WYi0+6Mc/KXjcDGRTxtYBuigydSskN9jBaZc1TrKT17vH1X2z6qbqa32Oy+ltpeuOZGiTa2yqKfl2/Aie+2RwrS4P2SVVkK/P3eueJJsni6ES3Q9oDaq3V3hewNREHCrQRtTtKtefJPyN4jAersE2XNCfHc7HwAtRXF6uXqj2W2tDCKaDJvEDZY0QAkr0iSBazMbSUxx9U3O0++nQlQUHq5zKUXtoAlpWOvfqLMuOifIGTYLvgm6IEDbUU6T260tGlcGblSpkDWINpQk8Mb9Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a15545b-c56c-46fe-480f-08de75ad5f83
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 03:07:42.7703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZx7xY7SHvFkWEnoKm6WzSYOjLzH2LB1P/K04T7A7fhyDvHGL/wqNK4mtw5vgUKe4DC5OR6gUO/3Y8UvXb7wpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_04,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602270021
X-Authority-Analysis: v=2.4 cv=O5U0fR9W c=1 sm=1 tr=0 ts=69a10a83 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=bFrn26Ckjei5HVmXeJEA:9
X-Proofpoint-GUID: U56YpuhBK3LtF7AcpehNn7wpNVLXjhJW
X-Proofpoint-ORIG-GUID: U56YpuhBK3LtF7AcpehNn7wpNVLXjhJW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDAyMSBTYWx0ZWRfXxe0yg1qxmFtz
 rl6SWjix2NECbrQ/A1uiBJ+xOSxfQ7Dq7AuTkBw81n/lukhQy0hwsuwopERFV7+y20GpOqv/+1A
 VGMxo0KWw/E8zBjV704Obgis1B1E88tP0XhxHSpKglM+JjB0TB5fyo2OiSPi6qzhdNm1JcVXt+X
 Lr9SDEh8QYv5T45KYvVLItnYSuWzASquMtIKmYes5lajSuoiHeaDTW3LZVguht16MvgkZPqjjss
 ojpeGW2RG+UHegYg1Ops+EO/mXa0Q5rgfxPbrOSRRDfeRVSDAj7flUAu/BBafXv3Ws+D9PT5bQ4
 dhRpe4bEpQ4ROZ6l+qTlWBaNe806GLaOi1Fpk0oGBmYiFreX8FYRXNfGFimkp8rhWQh6w2Xkx8R
 g7FIdep3udZVZrDJy09gHMzHlegKaDgDoPL5Y432GuW5OC+fmuooRuGXUUYsf33tnbJ03WMDIAJ
 N3PF7tCDdu5bjg6psQg==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14455-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2E1DA1B22FC
X-Rspamd-Action: no action

Hi Venkat, could you please help testing this patch and
check if it hits any warning? It's based on v7.0-rc1 tag.

This (hopefully) should give us more information
that would help debugging the issue.

1. set stride early in alloc_slab_obj_exts_early()
2. move some obj_exts helpers to slab.h
3. in slab_obj_ext(), check three things:
   3-1. is the obj_ext address is the right one for this object?
   3-2. does the obj_ext address change after smp_rmb()?
   3-3. does obj_ext->objcg change after smp_rmb()?

No smp_wmb() is used, intentionally.

It is expected that the issue will still reproduce.

Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/slab.h | 131 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 mm/slub.c | 100 ++---------------------------------------
 2 files changed, 130 insertions(+), 101 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 71c7261bf822..d1e44cd01ea1 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -578,6 +578,101 @@ static inline unsigned short slab_get_stride(struct slab *slab)
 }
 #endif
 
+#ifdef CONFIG_SLAB_OBJ_EXT
+
+/*
+ * Check if memory cgroup or memory allocation profiling is enabled.
+ * If enabled, SLUB tries to reduce memory overhead of accounting
+ * slab objects. If neither is enabled when this function is called,
+ * the optimization is simply skipped to avoid affecting caches that do not
+ * need slabobj_ext metadata.
+ *
+ * However, this may disable optimization when memory cgroup or memory
+ * allocation profiling is used, but slabs are created too early
+ * even before those subsystems are initialized.
+ */
+static inline bool need_slab_obj_exts(struct kmem_cache *s)
+{
+	if (s->flags & SLAB_NO_OBJ_EXT)
+		return false;
+
+	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
+		return true;
+
+	if (mem_alloc_profiling_enabled())
+		return true;
+
+	return false;
+}
+
+static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
+{
+	return sizeof(struct slabobj_ext) * slab->objects;
+}
+
+static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s,
+						    struct slab *slab)
+{
+	unsigned long objext_offset;
+
+	objext_offset = s->size * slab->objects;
+	objext_offset = ALIGN(objext_offset, sizeof(struct slabobj_ext));
+	return objext_offset;
+}
+
+static inline bool obj_exts_fit_within_slab_leftover(struct kmem_cache *s,
+						     struct slab *slab)
+{
+	unsigned long objext_offset = obj_exts_offset_in_slab(s, slab);
+	unsigned long objext_size = obj_exts_size_in_slab(slab);
+
+	return objext_offset + objext_size <= slab_size(slab);
+}
+
+static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
+{
+	unsigned long obj_exts;
+	unsigned long start;
+	unsigned long end;
+
+	obj_exts = slab_obj_exts(slab);
+	if (!obj_exts)
+		return false;
+
+	start = (unsigned long)slab_address(slab);
+	end = start + slab_size(slab);
+	return (obj_exts >= start) && (obj_exts < end);
+}
+#else
+static inline bool need_slab_obj_exts(struct kmem_cache *s)
+{
+	return false;
+}
+
+static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
+{
+	return 0;
+}
+
+static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s,
+						    struct slab *slab)
+{
+	return 0;
+}
+
+static inline bool obj_exts_fit_within_slab_leftover(struct kmem_cache *s,
+						     struct slab *slab)
+{
+	return false;
+}
+
+static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
+{
+	return false;
+}
+
+#endif
+
 /*
  * slab_obj_ext - get the pointer to the slab object extension metadata
  * associated with an object in a slab.
@@ -592,13 +687,41 @@ static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
 					       unsigned long obj_exts,
 					       unsigned int index)
 {
-	struct slabobj_ext *obj_ext;
+	struct slabobj_ext *ext_before;
+	struct slabobj_ext *ext_after;
+	struct obj_cgroup *objcg_before;
+	struct obj_cgroup *objcg_after;
 
 	VM_WARN_ON_ONCE(obj_exts != slab_obj_exts(slab));
 
-	obj_ext = (struct slabobj_ext *)(obj_exts +
-					 slab_get_stride(slab) * index);
-	return kasan_reset_tag(obj_ext);
+	ext_before = (struct slabobj_ext *)(obj_exts +
+					    slab_get_stride(slab) * index);
+	objcg_before = ext_before->objcg;
+	// re-read things after rmb
+	smp_rmb();
+	// is ext_before the right obj_ext for this object?
+	if (obj_exts_in_slab(slab->slab_cache, slab)) {
+		struct kmem_cache *s = slab->slab_cache;
+
+		if (obj_exts_fit_within_slab_leftover(s, slab))
+			WARN(ext_before != (struct slabobj_ext *)(obj_exts + sizeof(struct slabobj_ext) * index),
+			     "obj_exts array in leftover");
+		else
+			WARN(ext_before != (struct slabobj_ext *)(obj_exts + s->size * index),
+			     "obj_ext in object");
+
+	} else {
+		WARN(ext_before != (struct slabobj_ext *)(obj_exts + sizeof(struct slabobj_ext) * index),
+		     "obj_exts array allocated from slab");
+	}
+
+	ext_after = (struct slabobj_ext *)(obj_exts +
+					   slab_get_stride(slab) * index);
+	objcg_after = ext_after->objcg;
+
+	WARN(ext_before != ext_after, "obj_ext pointer has changed");
+	WARN(objcg_before != objcg_after, "obj_ext->objcg has changed");
+	return kasan_reset_tag(ext_before);
 }
 
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
diff --git a/mm/slub.c b/mm/slub.c
index 862642c165ed..8eb64534370e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -757,101 +757,6 @@ static inline unsigned long get_orig_size(struct kmem_cache *s, void *object)
 	return *(unsigned long *)p;
 }
 
-#ifdef CONFIG_SLAB_OBJ_EXT
-
-/*
- * Check if memory cgroup or memory allocation profiling is enabled.
- * If enabled, SLUB tries to reduce memory overhead of accounting
- * slab objects. If neither is enabled when this function is called,
- * the optimization is simply skipped to avoid affecting caches that do not
- * need slabobj_ext metadata.
- *
- * However, this may disable optimization when memory cgroup or memory
- * allocation profiling is used, but slabs are created too early
- * even before those subsystems are initialized.
- */
-static inline bool need_slab_obj_exts(struct kmem_cache *s)
-{
-	if (s->flags & SLAB_NO_OBJ_EXT)
-		return false;
-
-	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
-		return true;
-
-	if (mem_alloc_profiling_enabled())
-		return true;
-
-	return false;
-}
-
-static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
-{
-	return sizeof(struct slabobj_ext) * slab->objects;
-}
-
-static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s,
-						    struct slab *slab)
-{
-	unsigned long objext_offset;
-
-	objext_offset = s->size * slab->objects;
-	objext_offset = ALIGN(objext_offset, sizeof(struct slabobj_ext));
-	return objext_offset;
-}
-
-static inline bool obj_exts_fit_within_slab_leftover(struct kmem_cache *s,
-						     struct slab *slab)
-{
-	unsigned long objext_offset = obj_exts_offset_in_slab(s, slab);
-	unsigned long objext_size = obj_exts_size_in_slab(slab);
-
-	return objext_offset + objext_size <= slab_size(slab);
-}
-
-static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
-{
-	unsigned long obj_exts;
-	unsigned long start;
-	unsigned long end;
-
-	obj_exts = slab_obj_exts(slab);
-	if (!obj_exts)
-		return false;
-
-	start = (unsigned long)slab_address(slab);
-	end = start + slab_size(slab);
-	return (obj_exts >= start) && (obj_exts < end);
-}
-#else
-static inline bool need_slab_obj_exts(struct kmem_cache *s)
-{
-	return false;
-}
-
-static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
-{
-	return 0;
-}
-
-static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s,
-						    struct slab *slab)
-{
-	return 0;
-}
-
-static inline bool obj_exts_fit_within_slab_leftover(struct kmem_cache *s,
-						     struct slab *slab)
-{
-	return false;
-}
-
-static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
-{
-	return false;
-}
-
-#endif
-
 #if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
 static bool obj_exts_in_object(struct kmem_cache *s, struct slab *slab)
 {
@@ -2196,7 +2101,6 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 retry:
 	old_exts = READ_ONCE(slab->obj_exts);
 	handle_failed_objexts_alloc(old_exts, vec, objects);
-	slab_set_stride(slab, sizeof(struct slabobj_ext));
 
 	if (new_slab) {
 		/*
@@ -2272,6 +2176,9 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
 	void *addr;
 	unsigned long obj_exts;
 
+	/* Initialize stride early to avoid memory ordering issues */
+	slab_set_stride(slab, sizeof(struct slabobj_ext));
+
 	if (!need_slab_obj_exts(s))
 		return;
 
@@ -2288,7 +2195,6 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
 		obj_exts |= MEMCG_DATA_OBJEXTS;
 #endif
 		slab->obj_exts = obj_exts;
-		slab_set_stride(slab, sizeof(struct slabobj_ext));
 	} else if (s->flags & SLAB_OBJ_EXT_IN_OBJ) {
 		unsigned int offset = obj_exts_offset_in_object(s);
 
-- 
2.43.0


