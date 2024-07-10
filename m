Return-Path: <cgroups+bounces-3594-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F4992CD4D
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 10:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2201F211ED
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 08:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7416312A14C;
	Wed, 10 Jul 2024 08:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mgoeOKnW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j37Fx6bX"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A1BD535;
	Wed, 10 Jul 2024 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601039; cv=fail; b=f2VnJjIUMTnfbU4z6R4MrBtKmXJZT7L1PZtDBgxGRXzV2t15NCG4DbUdS1TVWmjgt+OTeLxNVNrWl8JySf8jyvXwGxKAhY99mm2rHhqRV+CyedXdkGcmBWy56Bsb7QUsND6JAFkYai6JTfaz1ttaYdagFwkYyDGUgGaXQu5MJas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601039; c=relaxed/simple;
	bh=x7Dzdkvw2EIs1p9IFIvdRbYeUVQH0o2aAeX1ebZNHqk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u/+2l8vCXwv3SpkTa160K1yoT7eB9cajTP92f6oRsq2bRe+j+94gb4feS7wOU1+OXguG8dqd/M/lscxJXYIekHjEACCcpoH7DWFEyiP41CKMfJcfeBqA5KqCYNzUaUfYUp3GKXLKvbQ2o+WMZrhITTVh1js1hJbLEqqdRw+w7IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mgoeOKnW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j37Fx6bX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A7fVN0003985;
	Wed, 10 Jul 2024 08:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=BKgDR/+/G0Bk+JjFPw/b3bGw2IfrI72h+uzARX1TnZk=; b=
	mgoeOKnWZtz+/4bHF2B2R2ClhSYPq3pc2C+BOnmhOoAr2hV/giHEeVpCz7bOjPVY
	L1wffAPWZh6H7D3c2G8UTpz80oBL998BPFFSIhmj4plZBRNyT0VCGl5XrfCmwGP1
	MsPPWfMH3cqI7F8351QiSMBWu5Asz0IYVoYvWg5IQnEYa+g8XR0Nf1uTvmGWmZLQ
	VQaKYNtiEly2zSIp4GpONPvxFm77xNWXXPyiFtAH128Hdz+4t0g4eWk9tWY0qSOZ
	1C27HwswVZUe6+owCDcFak0lGaZVJz+8DazR0oDBD0rEufHiwANDT2zolDZsWbx1
	s9ogmtrDCMvcGcNad1jEPQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406xfspsen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 08:43:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46A850j8014470;
	Wed, 10 Jul 2024 08:43:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407txj6rsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 08:43:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUvN+lCy4Zrh4Bx5Z6heA/61PQaoRoMf/G3Ngw5D0o/G9KSjKuak7/P/c9GO8zN3PheJoA6OYUEzt72tp45u3SMDcWBHvFLJUFmIoe9FP/taGCDbOQU3pmcv30/NddaD5g/BwvhjvkE3+Ll6nLRSQCuuUcg8doJ+kQu9xchWDZw0FDj5WQNWF1jbsRyFIsg6sI+HWX+9QytInEjPJsaw/nXFt2xJvZJZaiifKt/6HJrUonVuh3J21cFLUm4x4f8+2WZGZCM3JRNNLL9ivZhvDESZF7XtOduIfE1WFT1aHRlZwI8qTSTVB/3q+hw/BKlJ8HPll0ZjZqDZVNh6Ro5eDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKgDR/+/G0Bk+JjFPw/b3bGw2IfrI72h+uzARX1TnZk=;
 b=QJETyK+f0NWKGHpntaGPVDy3JZEiWVjYLZ4O7Gc7Q3dxH+LjdW3IegyDdjxpbbtlwjVLZYeqGE/4CkeS+anwWv7SnpxzvibLourUXq9lQgbfWF2PSUqoFZ9LlllALaYDbN1w6gSBE9U1G4Hrgt/YZEsLAPhThrAX6XlAMPCBulJMzMDPTawvv4o6C3vFnTU4XYHEN49GUakMsL1axa2e1YpKGuwoluiInX4YRYH7jElTJCEMRzNd0JkjmvbvHMlKfmpOT5jhEZuHNt0F/Eyla/SVlomzlV0hIpuNNNs0knlCfgPfkRNVqCeTBAfiNyocea5fois5FblKCQrRV+LOXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKgDR/+/G0Bk+JjFPw/b3bGw2IfrI72h+uzARX1TnZk=;
 b=j37Fx6bXeN9Hx5pT22zxufz+HSwgC2e22fqBjLFlUgAgkYa5l8ciSgRJ8dq27zqnLDBGJw4oHnTvMcrTDEVpzsNpMz69WjJ+KT8GB0mGr05DYlmXzdgsNaQ9+wQ1rnpFNpLaTDJ03keKmcbcJZTuEItHrBGcrZTrZGuIdC2HFQk=
Received: from SA2PR10MB4777.namprd10.prod.outlook.com (2603:10b6:806:116::5)
 by SJ1PR10MB5953.namprd10.prod.outlook.com (2603:10b6:a03:48c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 08:43:38 +0000
Received: from SA2PR10MB4777.namprd10.prod.outlook.com
 ([fe80::1574:73dc:3bac:83ce]) by SA2PR10MB4777.namprd10.prod.outlook.com
 ([fe80::1574:73dc:3bac:83ce%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 08:43:38 +0000
Message-ID: <74324c35-e116-44eb-abfe-a1ec21feba60@oracle.com>
Date: Wed, 10 Jul 2024 14:13:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup v2] cgroup: Show # of subsystem CSSes in root
 cgroup.stat
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240709132814.2198740-1-longman@redhat.com>
 <1c0d9ee1-e80a-46da-a48d-2ab23dd04673@oracle.com>
 <4291c0ed-bc37-46de-b081-271e8b299b1d@redhat.com>
Content-Language: en-US
From: Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <4291c0ed-bc37-46de-b081-271e8b299b1d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To SA2PR10MB4777.namprd10.prod.outlook.com
 (2603:10b6:806:116::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4777:EE_|SJ1PR10MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0ad231-7032-475b-9736-08dca0bc64b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TTdlSCtOaC82eEpzZ0tLQmRYSU9XdW9uUHlIVVB6MEJKSEFpMDYvaXRYRjFi?=
 =?utf-8?B?WlduTTBsZE9BeFIrZFQ3U09tbUtPYSs1RjFQbnZjWjJaQ1VWSGFaSkxsZ1RS?=
 =?utf-8?B?eWVWK0hUSEVYNXlOVXdrSjVMVVlhUVppU0ZVY09KSlQ1cldONkttd2E1c1lY?=
 =?utf-8?B?dmt5YkorZmduTWRFcFR2SUhuWEorZkg5V0oyeUgzZFVFRU9Cc3E3VXhPdWxu?=
 =?utf-8?B?YWxabFFQdVVBd0NYdGY1NUFaUm1yT3RreDRmczdncXFmRkxVVFV5SkZSc2JB?=
 =?utf-8?B?UTIwVTBZKzIvOEU2R1dtWi9oNXBRcWNWcGswaHNsN0JxM1U1anE1b2hicmxW?=
 =?utf-8?B?N3gzL3QwcGRFOC9HbjdmajhsVDZBSjZxUGh0bWZiQVBwNDRQTzJiRkwyT2I4?=
 =?utf-8?B?Q2FkbGNVZDF4Sjg0Z2RHWUtnV1Jaelh2QmNHbXhjU1Q4VFhZNGxXVjNjYVFh?=
 =?utf-8?B?cHY0bFNVZHNtTVo4T2pUMkRoTlFUMjBMaTMvR0swbC9WRGtPS2cxbUxCdGVH?=
 =?utf-8?B?cEtsZGlOV1ZGeENoQlZ6akN4aGF6SXhMbGs4aDhZWnVONVI3MENZZ3VrSm5E?=
 =?utf-8?B?UHRCc1NHb0o1UG0zTDdCKzdHZS9QNDltV1o5RzYvRGUxWEhlSnYwNzBlNnVS?=
 =?utf-8?B?MmpEcmVyaFV1bDJvcG9EbzZlbXBYRkFNWHQ3SzJTaTV1YmFnV1VJUkxUZFAw?=
 =?utf-8?B?OW0yZEZzMHFwNEZGMkU5UDhOdjdreStmOEJVaWtMbnZGNGN4bFpRVGhEZ3B1?=
 =?utf-8?B?R3BnRFpxclVrcG1XdTYwbXZmTWowOHJHczlWUE90am9ZYnJCZWpzQzVEeGV2?=
 =?utf-8?B?NWM3NWNYUFZhb0lEUFBEU1F6LzgraXZrYjFnZTdRQVhBZ3loaTR0SllVK2Np?=
 =?utf-8?B?RWpoa1hxWm1QbllDeUxLWTcxOWJkSEM0ODMrQ2dlbmF2RExKL3NkanYzQ0s4?=
 =?utf-8?B?MFo5bis4dTBWdUFPQmJuZXV4RWNId1h2TTZFMS8wcEUzbEF2OHBJb3UxOVp0?=
 =?utf-8?B?TUoyMGV2SWltdGhvU1BLT3RSYWdJREhUQ01UOFFQRVlVUk01akRTY3dnNDQz?=
 =?utf-8?B?NjFUcWxYaXJrMUhFSk4xbDA2RGFvU3RGQWFrUFp1dXJZS2R2TzNkYmplSUdl?=
 =?utf-8?B?RFA1dW9UUTJycXV2OG5VaDFhVnNLdDg5dVA4c2J1dkZ0NWpLNXQ2eWNVaHRx?=
 =?utf-8?B?UGVaQThwd1NBelk2ZE5ZL3pJMVQwTVd5MUw3ZXZscnJxeXBJbng2S3JqRlhl?=
 =?utf-8?B?ZWs4Mk1NRDVNY3RoZ2lRSnJkRGsrTVBhMDNwelBVSklML0hYbE9HY3pxa3Y3?=
 =?utf-8?B?VkZEeHZ2M3pzbFBIcDZ5NWluNnJzdk1YajVpMHRRb1Q1Vk9Ed3dIUG5ZaC9B?=
 =?utf-8?B?Z3FXdzIwYkpqVng0SlJOME5mZHRUd3htK2pnSFYvbnM4dllSaU4zeHhQTUcw?=
 =?utf-8?B?M0VlR20wWXkzeFI3UnI2ZE1SY1ltSTBtTHBnZElXN0VXK3RnUkJ3TldFNTVD?=
 =?utf-8?B?YmVxYjRzRVQrWWhrMUl4RC9ybmZ1aVFUYXFJMDdsRFVVeit5NWF5SGdNS0pK?=
 =?utf-8?B?b2Q5emJHTzY1czh5cWF4WkZVOXRHbHd3UytZYjhITDFJYUc1VGJiMHBld2kw?=
 =?utf-8?B?T2V1ZVNhWmx0MU5acm4xNnFkTVhoaFNjcVV2RXdkdGk2Mm9EaDJ2SGJLRUJl?=
 =?utf-8?B?UHNCcUJiMSsxQmgzTjFpblBmc0pSTGJ0aTZsOUo3emtpeWtiR2lORC9xRW5G?=
 =?utf-8?B?WVNBQVVaZXZLanFxMWpBMzc2YjBGUnU0eXUwaUt6UjRHZTNWN0hVVUFtZHM2?=
 =?utf-8?B?cVhIaERWMHdjUE9pSVZ4QT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aHp6UU5NdjhXTG81TEYxeks2WU5abGdIS2h0NFIvSHJ4RkFsNnJhZElzeitJ?=
 =?utf-8?B?eU40NjJONFJnZ2trTlNCbGx3a0dIRTJIWjdCNUNTcWp4SURtTXNSQlNXQitL?=
 =?utf-8?B?SEt5aWFldkJ5bi84Zkx6V2xtZEh4cThBZm5aemVweW5PdldnMDJtNVczV0N6?=
 =?utf-8?B?ODAyMWRGRGRyK3FPU2dQak1paGUvdXlrZnhLclR1M3dQY3duYTJuc1lLNzd0?=
 =?utf-8?B?UEQvbG9RNEVEWE4wd1ZXcnI0Qkpyb3NFdnlKRDB4dE5MajNkd01rNUZQWHhr?=
 =?utf-8?B?ZTJ3d2pnUFEvSVU4Q3RtaHFhT1ErOHhqZDV2V0I3WFZDYS9xUVVRSFEyVExB?=
 =?utf-8?B?Uzhia2F1eFV6dmc0eVBQY3NzVWFSWHBlSzNZaS9Cbm5qUmtuWVova3hJR2h2?=
 =?utf-8?B?Ry9hd1ZGYXRoWEo4NHY1ZTMzVTZnV1JqSHhKSjFadjNoQ3A3RXJpVW0xZXB0?=
 =?utf-8?B?VElhang3c1hpeURjRStPMXRJY2VYNWRvWVBpVzMyRWxZbm5xU2VKM3hLNldL?=
 =?utf-8?B?TllBQ0hMYW1KMFhsbDlhbXE2VEtUVjhDYnVoaWhjZWFZczZVMlVXaWlvWVZB?=
 =?utf-8?B?SUd5cHIzb28wTGRTQ21RdVZKMFZFWlpqaGFuOHBkTGdNK00zVnIzYmhxeG1U?=
 =?utf-8?B?TVRSWnZyYWh5U1NBeHQxV0tBbUdKSmZXUDhuWG51RVJ6S3ZNdGYycnkzZGwv?=
 =?utf-8?B?TW1UU3g3eTlydGRJY2NzcmZYY0cxSEd3aFlNaTZEVG9OUEtnQXlKSDVzbit2?=
 =?utf-8?B?MHo1MTVEUUVBVVRGVTU0QkFXc3Q3d3VFMFIyWCtYazVzSURWaDRxMTgyK2ZM?=
 =?utf-8?B?cmV6TGNXQm9UZ3J1QnJjS1B4ekJPa1NjS2E2VDNSRTBoeEVsNkRMQWNqSHk1?=
 =?utf-8?B?emY1VDdmZ3JyT1FBWmY2aVpTaHoxOGs1U2QzNkJja24zSkEwcmJQVXRCVEZW?=
 =?utf-8?B?VEE3RGFIV0FYdkwwMFZRRUZtcVlJZHppcGprRnY5RUhUVktVR3NRRFpUdUpG?=
 =?utf-8?B?NTEzeGdtN2thYk5kMU14Q1BiakRhZzQ2QUhESUUzeTZTMVpQdUxxV2N4K3Jj?=
 =?utf-8?B?MnROQTF0dWRabjJOZ0h1ZHZvK2w2QUpyeEF4M1FMSWRBK2w0MEsyMHdIWnpk?=
 =?utf-8?B?VC81d2ozdWpPYlRvb041TERzU0JuQytzRGxvS3AwK2VnSHA1YTYxQnozRGZV?=
 =?utf-8?B?eFVNTFYzVFpnRVF5MmNXV0tjcE9CM3FFSjg2ZlozUmU0WjRaS2tmYW5TNWV1?=
 =?utf-8?B?cVRMUjlHUHFrOGNOMW1vZko2dWE3SWRIa2dabjIvMWlCVEVXRXJqMFoyeHo0?=
 =?utf-8?B?eG1qZEFGcmVNQWszUDNxWEQ4MnYrWVAySDAxTjVXenA1YnorNjdHK2c5RTRC?=
 =?utf-8?B?bjB2VlEwNjR6YVFsMEtrQ0Q1K09mVzFHd1JuWXphRkJJUVNnL2tMekx2NjlZ?=
 =?utf-8?B?VVc2a1dLOUpoZkZDTHJmUVFYOFowZEJZekVuN3hoYXl0UnZMdEtsOFZEazFY?=
 =?utf-8?B?TnBaRHQycVYrQjYxVGNmM2ZVcjVYanhqTkZ3NTlHYmZGWjFPZ2lTZzluSmhK?=
 =?utf-8?B?cjlpOWdiUzdNNFZzcmRWQWE0QjNuQXN0UXd5cHVvblRic2ZpZ1IzTWpjUHdt?=
 =?utf-8?B?VFEwTzNSdTJzZEE4NU1uZkJ1RG5UWE9ISDcxdzJwcWxTdUdmTCtGL3laeVlp?=
 =?utf-8?B?OUdMbWpsb1BDbmI5aXdUTmxzSnF0NWwvODRqMDVHTWVSc3prWkJJZjBPMEZ3?=
 =?utf-8?B?eCtkVzNYeUdrVHFsRm1ndStGYWRBQkV3TVkvODRmcnc2VENlbUFHRTNZYXZh?=
 =?utf-8?B?QzNOQjZ1R2pQa0ZUMWlJeUdRRG9WM2drTGpkMWc2bFhhUDN3UmNiME4rd0c3?=
 =?utf-8?B?QXdoYnhqMmFzVm11RFpHWUFyQmkwQVB2SGJWRzFCTVFVNGs0RGZUcGpxdUoz?=
 =?utf-8?B?cGtQOS82bVdISFJ6dnpFRHZ3NnVSWC9MekFHZTJPNm1TNEpiWUhlSWNPbHRn?=
 =?utf-8?B?NDVXL2pTR3ZOZmsvRC90RDFpMzZ5UkluVHJBbnMweU1zbWpmVlVsejBpdkhp?=
 =?utf-8?B?RmtzK09ENnhTNDVuOXRQbWlBaHYyQXlsOGJDSjBwbEJYOXN3V3ZiNHM5OEgw?=
 =?utf-8?B?T2RNaVFtZTJLRC9kMzJlVUpsVzl6akxURE9PT0ZYd05hRWlNNHZIRDlXZ2lN?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AjKSItDE138hV3qPh52lKfMSiKfleeOKp9qtgXNsbq+l4ILNFaDX6e1qKm4v2Gp+LVRd3w7ZISwqSOivUeBxDwTmHk33n768B/04HIOIv2BFoa3L1pVv2ZHVlc0QMwdGI7yD/nwd9ac2AMwxY6Qy3xkYFNPRiVIGoi7SqJgveztf0aNRvW7AGnxCU6Htz+i1/t2BImQCavJZ+0iYToqvpCcAAroXA4RdkGDbRkhyE1CN2/ECMyIfXjh/ycxP8kG+YwMIK/vI9l33ixe3LLb+Ba9TFVUDV1GUT35DUR+CtRjprXHMUK/Kf/DpCmGQAfw6II43YSwy2UJ4I5SYrGL1lzvUNsBzyFir+Y1ceIkokTJNOyScIkzFS9OBiUWMa8zeRqWPTK280yW2pc8S6zu9mvjrty/FuB2sgrbP6O3RDO3fkXFIcs+pKxlHIhh9hWUReTkiHjhcB842nTDnbTNBlMImkai0FCwlOxIBrG3ZSIk7Xf5W0ho1xgQsLblNJDX8EofyIsSCA34bIw0cDkmdp3n6haJvEazVSpe1PaeAJvi8sGCWdiXqdNAXu8Sp4Vp7NoZE9dQdJqxCkmNLJ1oD29Pf1mCFMLNZatFAYcgbzFU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0ad231-7032-475b-9736-08dca0bc64b9
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 08:43:38.7273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHz6lhCYztIuEYieG5JDy06h3fZ/Vkdlv8uD3lyT1c7g7UgUqPEE+Lnw3UFs0asDLr+8LyqsQEwJ7aQoi58gsmUYmtbHO/j2kB0HDwJmePI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5953
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_04,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407100058
X-Proofpoint-ORIG-GUID: eyLCDmCkztW1bFLZiynd4TYcV2wPMJO2
X-Proofpoint-GUID: eyLCDmCkztW1bFLZiynd4TYcV2wPMJO2



On 7/9/24 9:39 PM, Waiman Long wrote:
> On 7/9/24 11:58, Kamalesh Babulal wrote:
>>
>> On 7/9/24 6:58 PM, Waiman Long wrote:
>>> The /proc/cgroups file shows the number of cgroups for each of the
>>> subsystems.  With cgroup v1, the number of CSSes is the same as the
>>> number of cgroups. That is not the case anymore with cgroup v2. The
>>> /proc/cgroups file cannot show the actual number of CSSes for the
>>> subsystems that are bound to cgroup v2.
>>>
>>> So if a v2 cgroup subsystem is leaking cgroups (usually memory cgroup),
>>> we can't tell by looking at /proc/cgroups which cgroup subsystems may be
>>> responsible.  This patch adds CSS counts in the cgroup_subsys structure
>>> to keep track of the number of CSSes for each of the cgroup subsystems.
>>>
>>> As cgroup v2 had deprecated the use of /proc/cgroups, the root
>>> cgroup.stat file is extended to show the number of outstanding CSSes
>>> associated with all the non-inhibited cgroup subsystems that have been
>>> bound to cgroup v2.  This will help us pinpoint which subsystems may be
>>> responsible for the increasing number of dying (nr_dying_descendants)
>>> cgroups.
>>>
>>> The cgroup-v2.rst file is updated to discuss this new behavior.
>>>
>>> With this patch applied, a sample output from root cgroup.stat file
>>> was shown below.
>>>
>>>     nr_descendants 53
>>>     nr_dying_descendants 34
>>>     nr_cpuset 1
>>>     nr_cpu 40
>>>     nr_io 40
>>>     nr_memory 87
>>>     nr_perf_event 54
>>>     nr_hugetlb 1
>>>     nr_pids 53
>>>     nr_rdma 1
>>>     nr_misc 1
>>>
>>> In this particular case, it can be seen that memory cgroup is the most
>>> likely culprit for causing the 34 dying cgroups.
>>>
>>> Signed-off-by: Waiman Long <longman@redhat.com>

[...]

>>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>>> index c8e4b62b436a..48eba2737b1a 100644
>>> --- a/kernel/cgroup/cgroup.c
>>> +++ b/kernel/cgroup/cgroup.c
>>> @@ -3669,12 +3669,27 @@ static int cgroup_events_show(struct seq_file *seq, void *v)
>>>   static int cgroup_stat_show(struct seq_file *seq, void *v)
>>>   {
>>>       struct cgroup *cgroup = seq_css(seq)->cgroup;
>>> +    struct cgroup_subsys *ss;
>>> +    int i;
>>>         seq_printf(seq, "nr_descendants %d\n",
>>>              cgroup->nr_descendants);
>>>       seq_printf(seq, "nr_dying_descendants %d\n",
>>>              cgroup->nr_dying_descendants);
>>>   +    if (cgroup_parent(cgroup))
>>> +        return 0;
>>> +
>>> +    /*
>>> +     * For the root cgroup, shows the number of csses associated
>>> +     * with each of non-inhibited cgroup subsystems bound to it.
>>> +     */
>>> +    do_each_subsys_mask(ss, i, ~cgrp_dfl_inhibit_ss_mask) {
>>> +        if (ss->root != &cgrp_dfl_root)
>>> +            continue;
>>> +        seq_printf(seq, "nr_%s %d\n", ss->name,
>>> +               atomic_read(&ss->nr_csses));
>>> +    } while_each_subsys_mask();
>>>       return 0;
>>>   }
>>>   
>> Thanks for adding nr_csses, the patch looks good to me. A preference comment,
>> nr_<subsys>_css format, makes it easier to interpret the count.
>>
>> With or without the changes to the cgroup subsys format:
>>
>> Reviewed-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
> 
> Thanks for the review.
> 
> CSS is a kernel internal name for cgroup subsystem state. Non kernel developers or users may not know what CSS is and cgroup-v2.rst doesn't mention CSS at all. So I don't think it is a good idea to add the "_css" suffix. From the user point of view, the proper term to use here is the number of cgroups, just like what "nr_descendants" and "nr_dying_descendants" are referring to before this patch. The only issue that I didn't address is the use of the proper plural form which is hard for cgroup subsystem names that we have.

Agreed, css might not be a familiar term to many outside kernel development,
though it has been introduced to an extent in cgroup-v1 documentation.
nr_<subsys> count is the sum of all subsys state objects, and suffix "_css"
sounded preferable to me, but might not be so intuitive to the user.
nr_<subsys>_cgrps was the other suffix, I thought of, but it was more redundant
when read from cgroups.stat file.

-- 
Thanks,
Kamalesh

