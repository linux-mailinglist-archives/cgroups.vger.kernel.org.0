Return-Path: <cgroups+bounces-6446-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA202A2AD0A
	for <lists+cgroups@lfdr.de>; Thu,  6 Feb 2025 16:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE0A7A1C1D
	for <lists+cgroups@lfdr.de>; Thu,  6 Feb 2025 15:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE2F1F416C;
	Thu,  6 Feb 2025 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IsDt4ANb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M7vqGToa"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDC41F4165;
	Thu,  6 Feb 2025 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738857108; cv=fail; b=YtD3yV4k8Qav0OoLmS3NGLghSDVcWnJxI4EoWwpVUkYQ7n3UOIUzE+RiSrITnnNVrSMKzaB5fqvz7EOgPznstgB8J+5ldf6m5nlHsVr+rheB6cw9f+tG/tvg7UFd28HcaCoRSZZU16oaC+vlxK8hlkCP8muO6bvdKPBCAfOHmIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738857108; c=relaxed/simple;
	bh=kD4Y+QC9bX5D65qDCZS15yTUp05P4AYvn6aa9omr9E8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qPVNOaMGsbQe4IBi7CYMFrApRPdupETeQg1E2HfbYD0sFmB8aXUNXYvdXXByjtlTS6xYkkhbAzxdA3ePMXMiBb/18Y9IVrw3bR6QnuJ8FM9NsajywoyGHvY3fbj0lNCeTLdw7uCuLPtrR+z2S8430dXCDSV9a8FBK8VBCnDdKTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IsDt4ANb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M7vqGToa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516E5NOG028724;
	Thu, 6 Feb 2025 15:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Uuocbgke/OwyjY7CulkKf9dLg3ozzEJHkMxc5RhOki4=; b=
	IsDt4ANbH5lzgt+nJCBT4V+9iFo5/l0cJ9PUh11O1UV4Zy4//Zj2+QsKQckRePWj
	H7zLJYY2qUGo2LnUCrbEymLHIuFCOzeXARBRcr9mDR38nm5cfj963GdITe3BYOSq
	KIPfoYOxkjed4XGfRK2Yb1SAYjYHTzEyqdUqWSCYc20xTnJ79KhjBSiPEH+vxEIQ
	p1zpXSuSiPQjlD6QonYEcCE2zyXNNa/uB0NRHCgATSWLimGYWQ1EpWwUgBm9H1am
	DIJCqDssFb5FZpcKXi0M/Fulc3Mlauk4fSty2NFl3xBsqXx+Xrjr3g2FLxLsO9is
	Tdy99NmiM+/y8jSa+Nb52w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kku4vttq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 15:51:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 516EWYRs027944;
	Thu, 6 Feb 2025 15:51:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8dq96u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 15:51:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhQ9vNxzKKAjbKaiz/U0KtVNu0cYQCjTOWUK2YrViN76JYybKr3MaiIfGp6tm/DTTkcQ5GgVTb8y+2xEaicnuUB3XGjPr58JAcbe+6yfQdkBo0stZjOHqZQ7R0t03CZ8oRl4Xd3jCmYIvy+wMhL3qQDfgJImhbu+iBXmLmPWYF3MWFcRXV0ybGOi9UViDi5saGcOTqcUv1MFrLvSTdg62CpsOZye+UTztPrIPhbXMcbU0u2c1FCeTqMUh5u7yn9tegzk3/aG7TNrbxF9KubstJDMYRVEmbMGiPczozLm6mywxMJmt/W2fLiQn3HrFCPp+4Q+FCwwuph7mVZMR85cOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uuocbgke/OwyjY7CulkKf9dLg3ozzEJHkMxc5RhOki4=;
 b=bG1WdXulneARkpxHC7VKQ1pA3hSGvixJcuu2kFw8YV/Qd9M9cvoJbuwpKevNs2xGnl4NRwutmBoBjC1GTKkXFdD1UDHhv7SBc6FzibLIniTDATTSHpEdqIrwIOPGfnr3NUuobjWlRM5gcvlPJNxb/7riafbVV8Ez61OCI2AC5gh6K4EYsfX5XyroNVVeu7usXHRf+xByT9OeipDCiQJ9zGxqDp3wAewiWYjVmhnpx2Zv0YZytN9S9KVzKHLCaG69Zjvb8VBKjDM38ci+ZAA3IjrZKTOxu74nFhDJcmK88jr+nQV7Tg37If5Cd+Mw8+k4APq3sGVTUUbksrem0Xk+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uuocbgke/OwyjY7CulkKf9dLg3ozzEJHkMxc5RhOki4=;
 b=M7vqGToa7+kEh1XcpEmnQ5EyYeUUaB/4/hx5ewye2nTeK+eNxABFfpAHoK+2yF+ll8iuKZCc0EnlM84Z78Ke9d4JgDBl0z5GQZPprWl3gODyoqWgOI4tJsNl1nEaG9p5aIuEmu8wOgZATc9WSDCiTdBz+yBkEW0Z7a8+qZw6oN4=
Received: from SA2PR10MB4777.namprd10.prod.outlook.com (2603:10b6:806:116::5)
 by DM4PR10MB7474.namprd10.prod.outlook.com (2603:10b6:8:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Thu, 6 Feb
 2025 15:51:22 +0000
Received: from SA2PR10MB4777.namprd10.prod.outlook.com
 ([fe80::1574:73dc:3bac:83ce]) by SA2PR10MB4777.namprd10.prod.outlook.com
 ([fe80::1574:73dc:3bac:83ce%6]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 15:51:22 +0000
Message-ID: <5316c4b3-fae5-4525-a934-a56c45dade42@oracle.com>
Date: Thu, 6 Feb 2025 21:21:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: A path forward to cleaning up dying cgroups?
To: Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
        Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, linux-mm@kvack.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        Allen Pais <apais@linux.microsoft.com>,
        Yosry Ahmed <yosryahmed@google.com>
References: <Z6OkXXYDorPrBvEQ@hm-sls2>
 <ccd67fd2-268a-4e83-9491-e401fa57229c@linux.microsoft.com>
 <20250205180842.GC1183495@cmpxchg.org>
 <7nqk5crpp7wi65745uiqgpvlomy3cyg3oaimaoz4fg2h4mf7jp@zclymjsovknp>
 <91D2E468-B89A-4DD7-B1B0-B892FA4482E3@linux.dev>
Content-Language: en-US
From: Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <91D2E468-B89A-4DD7-B1B0-B892FA4482E3@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0194.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::22) To SA2PR10MB4777.namprd10.prod.outlook.com
 (2603:10b6:806:116::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4777:EE_|DM4PR10MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: 905ed7c7-b10b-40c1-1752-08dd46c61aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHhZM1Z4R0R2dkVKd0xhaWFDL0pNT3NxRjFuTXdpNUhKNzNCUjVhN3JCZ0JR?=
 =?utf-8?B?SDJSenAwQmVIMUxXb0x4dHlYNGVDVDZJK1pnR0pDbW84ZmplcG1HUUgvcGps?=
 =?utf-8?B?ZjA1bWYwYXVPc2VDR3JlTk5kM0lCZ0NIamdqTkhZY0svR0lDbkVQZUJicFRH?=
 =?utf-8?B?bld4ZEQ1K2JweHM5cDljTXR4OC9xM05TdjBFWkxzME1nUEcyeCtudWcvL3Fi?=
 =?utf-8?B?Rll1LzNRU0NuUDFuRVhOVFo1NW9aS2lrVGsveW5Jc3Q2M3BRMEZnRTRheDZS?=
 =?utf-8?B?QlB1bnJwOVJRKzlxczM2Qk1YN1BmUTV6TG56cHdUd25HVW5VMjdYb2VlT3Zw?=
 =?utf-8?B?ZXpQU242UTdtaHJHR2xrV3FLWkE0SjhZMjlqUlA3Nk9VRm5YOVlqb1RrQnZo?=
 =?utf-8?B?VElaZ2tsTmVEVUhqYUNaNG1UQUJpaXpYSWlYd3hVUXNDdHMvZmNOT25wNGh6?=
 =?utf-8?B?U2NiTk1CRmIzZWtzVm5VNDNwWjdQZS9VOGh0Rlp6L1ZJV2dMditNdFcydmhD?=
 =?utf-8?B?TngwOTBDRTcrSFNLR1BaMHl4MzF4cjQ1ekZNdmplSUUwejhGK0dpWDhWamRm?=
 =?utf-8?B?N09MUjFDSTdBdVcxSHZDS0Y1Wlc3ajRkTTNqbk53SklJdlo1N0lTalRDcllH?=
 =?utf-8?B?aHdKUUFSTnhNb3RZUmxwMWdVdGd3WFhobE16bytzclMxQ2hvekkxUjA0V1hG?=
 =?utf-8?B?cG1MMzhJSTNDaWxHRGt4OTBDZGZtY05va2d1c0c1U0RqUWt3Y2dUKzUrMVU4?=
 =?utf-8?B?d3Y0ZU5DSHIyL2MyRENmWXFtL1dzTGVwWitFR0ZpTEhxWEZJd213ZW9tZVpn?=
 =?utf-8?B?SGZJeSt3VWViQlM3aHJYNXhEbjJ4dWVOSlVNSjhhdzJyUUtSb0xESWdDcWJQ?=
 =?utf-8?B?TG51VGhVSTRkMDRRQ0FCU2ljU1ZHZzBRMTdDVUlmckVZbXV2R1F2cVV0MXls?=
 =?utf-8?B?a0ZORWpodnE2UksxN1RhbFVxeTBSRjJ6SzJ3N1JBcURZTHNxTkFzMW5sOE05?=
 =?utf-8?B?V2JaVUtmbkI4WlJxZjVrMjlzdnJ5WW10a2xKVnk3ZlpGM0ZMb1dSRGlyR3hY?=
 =?utf-8?B?YVY3dGZSMzdncWNvdjYzTjcxNkhZMTNkMDN3SGh4L1U3dXN1N21MYVlDS0kw?=
 =?utf-8?B?RjR2YUFxVTc2Tzc1RFd5QU1SQWlySDUwMTVoZ2Q1VE11Qnp0NS8xcnk5MFUw?=
 =?utf-8?B?blVEa0FkaGg5Z1JFN2YwODhhQ1lvNGF3SlZCWlJRalVVeFByUVFQODVodEtS?=
 =?utf-8?B?Z2xpTFR5Qzg5NUt1THRLSkp6UDJnbE1RVzI5NkprNytoN1QxMzUyaFkvY2tW?=
 =?utf-8?B?NmR5VlhzeUJoMzZnbDBLTXAxVDl1V3hlQWVLcmFpSDJBSXlKeU13V09zT2lT?=
 =?utf-8?B?MHhTSThua0NzUlZxRHpyU2orNExDMUJJK29kTDBCWXRJaEg0TXpOaThISlI2?=
 =?utf-8?B?aEhyN2pGRjA5TUNqU0dpSG5VdGw4dzFMZlNkOUF0RzVxS241WE54Wlo3RlVI?=
 =?utf-8?B?eUcwT3VjYkIrWEdnM3hXMXdBWGZyYmtiZGVILzhtcXg1QUJHdnRSb05Va0Nv?=
 =?utf-8?B?NWE0dkVYUnZYUXhueFB5bnNYa00yRmdXNG5ReVdCN0dlckFFZE8xWDFOVnY2?=
 =?utf-8?B?bGwxSEJlZndzM1d3WTB3eXFFNVo0anVBdk5OeVdtQ1h1TkxQR2Z6R3AzRlNN?=
 =?utf-8?B?TlZFOVpGeVVsOGpkQWlMVG5vUCtIR3lKRWdCZFRYaGhMb2Z6QUJNVlNoLzVC?=
 =?utf-8?B?SngxNkppV0Jja3BYeGZOYUtjbTFaVGdPSlNNR29qNThqNnpRRXJlZUx6eEpL?=
 =?utf-8?B?SzdROVpvWWxyTXRFRWdMcHJuMEUvSGNnM2ZoRzRWN0JjYVVjOEZZMmdkcnJO?=
 =?utf-8?Q?VOM09jWBHSRz5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDY4bUYzZzhTMkduTWxyM0djdnRPY3R2Qy85Wjd3cWtuaXlnNEJXKzBMa1JB?=
 =?utf-8?B?TzNScXk4ek1GSUY1ZXowcHkxcndBalE3RVM4TjFQZHp6WkZWVWxSbWkrQXpz?=
 =?utf-8?B?cGtTK0tkOFI0Z0dXajhjcGVDV2I0TVBJcTFMVzNjVi9hUFBlQmxHRStXdWVj?=
 =?utf-8?B?dGZpRzZvNDNmVkYvNXJmZVZsM1h0ejFIK09ZN0J0RWFrRGZWVkNHMWNuSFVN?=
 =?utf-8?B?bkhaVnR5cnlBWHhwY3ZEMkJKSGN5d0gzRzEvWVZEK29KSjkyV1NHMU00T25v?=
 =?utf-8?B?VUYwQ25zVVVsajVxbWQvbTZEcDZxeWU5bFlqeEJnM1FGY2c3bExqOUN0cU9X?=
 =?utf-8?B?am9yam9PMWt6d21jVVZvSlFVNUk3SExDWENhRndEUG1tQXVsNi9RbFFUV0ZT?=
 =?utf-8?B?M1I1NWZQSVYzT0tQQlZiWjZjdktOSXBkMXJTRHR1MTQwN29PMDU1NDhGT1hD?=
 =?utf-8?B?TG40c1lURHluYmdGTERCcElSZUNPQzc3UXB2cE9tZjJkS09TZHV1NkY2a3E5?=
 =?utf-8?B?RGhIeWdnNTNNK2hIa0ptSVBJM1Z4UkZ1ZUJYYlJyeHVLamFVRGdGRkVQeVhW?=
 =?utf-8?B?RXE3TTFnUTF3cHgyc29uR2N2RWlZek1TQVc0eWxIdkdtNHltUFNibXNiWGNs?=
 =?utf-8?B?WGl2UW9vOFhTYnE4R2czeXRER3hZZUppVy85UUhtanI0OGVtS1JWRm1MRUlT?=
 =?utf-8?B?MVB1WGFqMmtJWHZKaVJOQldyY3RmV0FCSWp4MkpiL3g1SmZFYnl4aVlyUkpV?=
 =?utf-8?B?aStOVXp0WFIwTjI3d21nc0xzdmNqcHpCSHBkYnN4bFo1c2xmWk5XVVBmUkkx?=
 =?utf-8?B?QnZvdGtvbGxkdmFxTG93R0JuQnc3WExHZGtGVzBLZUR1a1BNZkNRSVlka3F0?=
 =?utf-8?B?Y1V5RDBGTkNRRnlCYU5RM0ZMaVl2Mmx0UUtEYS9vcFdjRDJkVGIwdkxETTJZ?=
 =?utf-8?B?cHZlYm5QL1RrSGtmSm0rSjZpWjI2aVVLQ04vWHBHdUcxa2tKV3dyOGowbzJG?=
 =?utf-8?B?R2VEUkFITXErVTErVFI5aW9KNVNmb2VSeDJBSUN1L1NQWUVTakVrdXl2K3Qv?=
 =?utf-8?B?Vmpja21SRTVTbmpzWFpyTzh1WU5VVmRwSUJJd2ZPT1BpWlExTHhERGVQc2pl?=
 =?utf-8?B?dXpSR0FRNE1wUUEvYm95RldrL3g2RnV5Uy92ak9NbmpPSFc4VXhrSzhUSFlw?=
 =?utf-8?B?YjFDc2NVWDBJMHNvSS9ERWdLV21aQ0VackYwbjNyN01ENmYxUFlhVkJIakIv?=
 =?utf-8?B?dUZEMWNCQjQyN3dXc2FJL3d4Y05JZ0NNa09valM0eTlKUElvbnpnUVJBdWhQ?=
 =?utf-8?B?UldSQzF5TWtoemxwZ1VKK05VRkRYd25NMXNLRnJWREVsRTNkdGtEQ0pqd04v?=
 =?utf-8?B?NHh3NzRuWHM1YWRwT2JFT1RGbXNXT2NMYy9SMzgrWDhibWJtSldMRm0wZUI4?=
 =?utf-8?B?aElIWVRrd3YyUlV0aHZ4S2N4RCs0Yi9nbklETWo5Z3J1WEJRb0swT1l3UHl0?=
 =?utf-8?B?cW1lYU9uYW9JNDE5YVRhOFdHdVU0aUxISDdweGNMVlg1cHgrZE50YmlFVnRm?=
 =?utf-8?B?eWwxVzJJMG9yb2l4TFUwT2ZmVGhDa2hYdkxsckkwTWhNQmJaWHRmTDJUQzEy?=
 =?utf-8?B?L0pmZ1p5azZRYnlVaFFiWjJnUGpEZDhjditzOGZsS2JvTktrMzJ3UDhwS1Jw?=
 =?utf-8?B?S2hNMWdqelBUK3hIR0NZYldtMjQxZU9FTVpZeFVDTWdCNFhmSE95Qi9CSWtn?=
 =?utf-8?B?ZTVXaWN3MWo1WEErQ2hFSkZkLzJvVW9KdStGWDg1UURrWDZ5VENSYjlYNjdo?=
 =?utf-8?B?aEF3Q3ltSmlQSUJMVnZ6WHB3TktOZnM2cTFpb2VRTGJ1Z1VKNWY3SjZVWnd4?=
 =?utf-8?B?dXFrc2VpaXhsVloxVjRjbXpGckRjVUIzMFZab1pHZFh6MWcxbUtCVmRLVlYw?=
 =?utf-8?B?WnJmaFhQOWJjVHE3a0lHbFdsQXRkcm1Pb3FkYWdZS1JQa2N0RWxOam4wWUI1?=
 =?utf-8?B?SS91VVViUCtOQ0ZFbGZQdHk3d3E0UlNkUmxIUHdCeHhudkZQVzNYUTNKN295?=
 =?utf-8?B?bndUSWN1ZUZ0ejR3Y2pQV2NtT1ZDYzF5NW1KbUl6eFRWb3pFZ1dDaHQydlVB?=
 =?utf-8?B?MEFVbUJxWW9zRWgwRVRwcVl1bll0ZTFFWk9EWVZOTXk2MGVtOE1RYXU5dmk4?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J1YniJwmVWPFzQjQByoX/GVKJwYBp5rzU5TetUtu9+RJDMlOUWXWpv7dzttotIkUvymKO2SyUR/EgGgPebuOIXxMyyrhcse8tFdfdRK857fR1rLuZFEEZ459MjwYeahUNVflbBG6Rtu8VcWCZVDrFM/PpZl0co08xYGZpIUa2UDwg4UN+VxTlpi8aideANtgperCI/7gDF1YMpX+rCl0MX6UqQXR7kphUDpE6BTqX8c+7cmrYjvY2E44rT7SrfKQwNNckv5YWuHCDb/g/o9fugJCf/k3oITOdBAInnQPMtvORFSTwTCQwcFBIfJFSAuzjWD5/XLRgxYM80SHQ3qGBghq6jv/GmgZ4C7fZpo4lzZPysAXEzv82V8E7Oe+UuXKdpKTKCdn7Vtz+OKT9rY9SrtSgMNRZWGzK8rdnY2TQL/3v5dx/OEXTTOv7mbWS/YbfwTb16v7ba8KcH3jYg3bE135zEVKECmHyc/vqIXXS5zq6qV1hmEVceVXKPzaa1T6nlAbGJh7IoVVGDoDIDmKcrUgE4vroqd9Woh9lia3nVgjzaeU0J5F92wUYmbr8plOzx2a7OmxUGGPPjyzAbMtgtwBQgu0dhaylUJG0/aKRo4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905ed7c7-b10b-40c1-1752-08dd46c61aa6
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 15:51:22.5237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNH9ml0kFWCtPD6hZ1OLGgh7k8bYiv/NI+6/wARBuXY1s7D1fKrdKcgVYFU3Ee5QN/hmuanH/ScAi36GyTeOg2zRHd93RDQTA/1rkI4V5sQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7474
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502060128
X-Proofpoint-GUID: 2kBSCL7wvzS6W9X7bUEasBe1OFjWMDd9
X-Proofpoint-ORIG-GUID: 2kBSCL7wvzS6W9X7bUEasBe1OFjWMDd9



On 06/02/25 09:00, Muchun Song wrote:
> 
> 
>> On Feb 6, 2025, at 02:46, Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>
>> On Wed, Feb 05, 2025 at 01:08:42PM -0500, Johannes Weiner wrote:
>>> On Wed, Feb 05, 2025 at 12:50:19PM -0500, Hamza Mahfooz wrote:
>>>> Cc: Shakeel Butt <shakeel.butt@linux.dev>
>>>>
>>>> On 2/5/25 12:48, Hamza Mahfooz wrote:
>>>>> I was just curious as to what the status of the issue described in [1]
>>>>> is. It appears that the last time someone took a stab at it was in [2].
>>>
>>> If memory serves, the sticking point was whether pages should indeed
>>> be reparented on cgroup death, or whether they could be moved
>>> arbitrarily to other cgroups that are still using them.
>>>
>>> It's a bit unfortunate, because the reparenting patches were tested
>>> and reviewed, and the arbitrary recharging was just an idea that
>>> ttbomk nobody seriously followed up on afterwards.
>>>
>>> We also recently removed the charge moving code from cgroup1, along
>>> with the subtle page access/locking/accounting rules it imposed on the
>>> rest of the MM. I'm doubtful there is much appetite in either camp for
>>> bringing this back.
>>>
>>> So I would still love to see Muchun's patches merged. They fix a
>>> seemingly universally experienced operational issue in memcg, and we
>>> shouldn't hold it up unless somebody actually posts alternative code.
>>>
>>> Thoughts?
>>
>> I think the recharging (or whatever the alternative) can be a followup
>> to this. I agree this is a good change.
> 
> I agree with you. We've been encountering dying memory issues for years
> on our servers. As Roman said, I need to refresh my patches. So I need
> some time for refreshing.
> 

We have seen the dying cgroups issue too and look forward to your patches.
Happy to help with testing/reviewing.

-- 
Thanks,
Kamalesh


