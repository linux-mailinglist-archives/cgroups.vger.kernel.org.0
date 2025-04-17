Return-Path: <cgroups+bounces-7630-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FC2A92C81
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 23:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6FCD1894BFF
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 21:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030FB20896E;
	Thu, 17 Apr 2025 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lu91vR4n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HP+0W9np"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F701D07BA;
	Thu, 17 Apr 2025 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744924052; cv=fail; b=qzmVVoqwtxhI4raF01A2gEZoQW89t95Kj3FUs0hrWt74C1CuWLbGe+Mgz/lj0QgZC3C28nC4LrhItKIMZ4rqlyAjbyo/gpav0Wjn857FRETBvvaQTLAZ3ZnrN4V2tCbqDDYTMb+r65Jif0nypYPzuNVtA6oWfrjmPPIwYKOzFT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744924052; c=relaxed/simple;
	bh=DGR9kgpJab1yYmasfGzl+CSpaBGkQMf3tZfxydMs6j8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hioUzKsVfIymJi+ZmZ637lkc3qNZKu6XCi2IEe9YEBPPWr1WVK3peY0DrRB0xs6FIoo7MG3By9/uZd3PV+c6hIfFx/avg++UB2CK0PKDxJ89yeHrogkVxeRaKc1Lj7qkLo6WwrvBLHmvfAtWnEdOlmuCcZHjfdXMvMOUVeMWyr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lu91vR4n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HP+0W9np; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HJscO3019940;
	Thu, 17 Apr 2025 21:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=izCYK9VlodR2io7em17/EYuf6cIkjywJDQPPTKc6zS8=; b=
	lu91vR4nfErUgpa4TAsbZLbdaJGElJjNxWRqUFWc7uV6TdHiyXysmM144JqFX+wE
	TZn7aQ6E9Pa9jiFyJmOO9cU9agNS3/oZ3omYQYYHX1Y6gQWhIWGCzBUCfoOC/0CB
	VR7K/BRU1Z/ZPLHEx+k1BHKe3l4GikhkKVfXeIGx2nTsDY0reqw7OsOg/bIbwCBh
	DP+jPdIpxu3ZDUS+YgxQmqCRcSonlHRKQM1Q7Ly5KWg9R6uHWJng6vyA2+WSG/wW
	1HEaZHSWCs/Ab79QQV/uX5+JoIgOVtuhI8LOZatlnCVRON9I/qVoEJTQBzLPoQqO
	5ECn1TdnXAVp/FZ0WvkdJA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46185my8bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 21:07:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53HJADjt024687;
	Thu, 17 Apr 2025 21:07:06 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013060.outbound.protection.outlook.com [40.93.20.60])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d542cfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 21:07:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRbjRPCRWX3rNDaRPUkmMZ0hzam+vf200gBIVbu6Q5MX8TQIQHmyMkjwxYu9L2TsYei7GwtxvZf5qAv+EtKLAdEcCWNCQXSVh9BMln7EKtZIr3RjOWAN8rF79cCNK3MZ5Z4Povg/3h274hgF8PYLR1XOdjSgxicddYGMoQH/MDlYgak0f0CwIClYbneWc4aZQ+NY+5oCJURSeLoxzTXUixjUyzoIH994v9klasivaV59JEPoZhI8C0kCe99bVvj5tdsqt0b/78L+Rcpq8cFnyXASG4spWrWaSwF2OMlBkkLJJhkEyQ/S5QlNWwYBT8EC6QkQrhzTm55NrVv318MJIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izCYK9VlodR2io7em17/EYuf6cIkjywJDQPPTKc6zS8=;
 b=fzOAnDwaX0biCHX7e2r9tW9Lc3ZAYirZ9IDcYBN++/ys8hJ91E40Z/SrNpI9EZnGpH95ypBhQ6LssgNyb3vm8Xr2fW6InQ5VnDhrYrL0EHzHLCRZf29bNkLMVSa0WzwBwAsGhtmFQZqqd54MpgdQspO9mtNc86gd8e8bcTQ95lfLEjZcnFytOQLOexwmmUmHuv7NSCbJzYZCRFqcx/ZFPlSXw/32bEXCPi8lIK8fNzBCdxzxQolkBdnCv3xQ94QNCQxF4CrGg48sNE1sRIIftugnhmyforVyNBCWtGbaPYl2Ufm9lFqgx60hDfpFITuRk+5b374h9gDyI/cLExi0IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izCYK9VlodR2io7em17/EYuf6cIkjywJDQPPTKc6zS8=;
 b=HP+0W9npJlQ9TaphmrC50u2q09dwudgX/P0fGxBaRhP8jCtZm5GZsblD1WjYKyyN4PrgZ5BTwbgh77QRtxPHF337yC8xXGrXPVzC6iyWtYCFh9T/0kQjuN9e27VkbiWj49I9cJT7vFaeT3gcbehJOBkJmIyUFwt+7wjx/lThGiQ=
Received: from MW4PR10MB5749.namprd10.prod.outlook.com (2603:10b6:303:184::12)
 by MN2PR10MB4141.namprd10.prod.outlook.com (2603:10b6:208:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 21:07:03 +0000
Received: from MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454]) by MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454%3]) with mapi id 15.20.8632.025; Thu, 17 Apr 2025
 21:07:03 +0000
Message-ID: <66884086-39fc-4f65-b207-08758c0756b8@oracle.com>
Date: Thu, 17 Apr 2025 14:07:00 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH v3 0/2] sched/numa: Skip VMA scanning on memory pinned
To: Andrew Morton <akpm@linux-foundation.org>
Cc: peterz@infradead.org, mgorman@suse.de, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, tj@kernel.org,
        rostedt@goodmis.org, llong@redhat.com, kprateek.nayak@amd.com,
        raghavendra.kt@amd.com, yu.c.chen@intel.com, tim.c.chen@intel.com,
        vineethr@linux.ibm.com, chris.hyser@oracle.com,
        daniel.m.jordan@oracle.com, lorenzo.stoakes@oracle.com,
        mkoutny@suse.com, Dhaval.Giani@amd.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250417191543.1781862-1-libo.chen@oracle.com>
 <20250417131236.c47ce477c0e68dbb06a4fabb@linux-foundation.org>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <20250417131236.c47ce477c0e68dbb06a4fabb@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:510:23d::26) To MW4PR10MB5749.namprd10.prod.outlook.com
 (2603:10b6:303:184::12)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB5749:EE_|MN2PR10MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0f4ae9-1d3a-47f6-79da-08dd7df3cd57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXEzUnR6enVlVHBQNlE2NWxyS2lGUlpBTS9WMEFsY0ZPbmF5NEQyaFFINkdy?=
 =?utf-8?B?azJ0b2phbUt2OFlnUk83TXRSRmZMVmJZc3M1VUlrejhicmRuRnVhTFp0cmQw?=
 =?utf-8?B?dW5rOXlRaEYzSWZlWXlnRjdrbUczaHNVZXNGemxRQ0M3ZS9NMWVnVEEzMlhh?=
 =?utf-8?B?QkIzMUFjaE1DUUt5Yk5CUmRwaXdxNml4aWVhLzRqZjk2TDllSHhTOHluZGVa?=
 =?utf-8?B?Q253N0d3Z0RBOVM4NmN1MTBCYnF4a0gyaU52ZXlIOHlkMTNGcUNwUldIS3Z0?=
 =?utf-8?B?VU12eFFXOGZBd29kVVVmdTVnbEdSZy94M3kwc2E1UmJaYmJFVUlXK3AxUmha?=
 =?utf-8?B?WDBaU3RqamJRTVNxQ3VWaWlLL0I1UGZQVm1ReTU5V21OZzlobkFnNkdncVpC?=
 =?utf-8?B?SzBaNGtSWVY4QW9DUnoraTVoTS93WURIS0drdTVhK1EyZlFrNVVsQm1tOVdo?=
 =?utf-8?B?V1A1MU1qbjVHV0VyOU0yeW54RTJlS3JKTXRtYjA3eFIxSis3d21mdExrOU1t?=
 =?utf-8?B?WXIvSklObUoxYlQ2TGpmY1FTcDF2L2J0dU5hd2ZlSW1WWUNXeFVTaC9DMUVS?=
 =?utf-8?B?YnBKaTFuUWxiMFE2S0RaV2hSTkNUQjhydjhWQnFMV0dxMldIbnpUY3cwRjJm?=
 =?utf-8?B?MWw2cjBVM2hWWC9qNm0yMFBNZzF0SnEveEdyUFlTdHRNV2FRSmJlVVhoNzYw?=
 =?utf-8?B?WWNBYWJieERVaXZ3Um5FeFIwbWNKWDJhWDczMkNmcTAwZm5XM1Z3ZVhLVi9X?=
 =?utf-8?B?cjVGOWxDQ1IyejEzOUx1TE1Od3JnMGcra0I3V0lnMHVleTZid1BjVHdSUlNU?=
 =?utf-8?B?Z1JmeUxVb1pkTmw4TXM1ZUozaTZ3Uld2RXRnZUMvQ3dudExESU03R1RabzN1?=
 =?utf-8?B?NUlNMkhrOFdmUlJhOVJHOUxVMW1nSVhobUZKdUxWZkwyNVlvVGQya1gwWFpx?=
 =?utf-8?B?V2tIUHJFUVN2TUlHcmJmdjRqZmZidXA4VEZ6cUw2Tk9vT1krUHk0NkE5Qk0r?=
 =?utf-8?B?dlc0b2pmSU95bkMrbUY2bWZlU2Q5QUNyUWhucXhBK21UaWEwdklPc2RvM3dZ?=
 =?utf-8?B?VXBzUFd6dGdzYzFhZm5ITUhXOUZmVXdpZ2FBa2pOMU5rTjlQeGRrOWFRNUow?=
 =?utf-8?B?dlRUTWU1L3JJOTZ0S2E5SGJBanZpdXRXb2RGd1Nmc1lBdHVmMUI2SXZneVhw?=
 =?utf-8?B?dm5xQUFiREo5RlJtS1ord2g3QSttNlBPQ2tObzFQemdyVjNFZnBwaGhOYzBC?=
 =?utf-8?B?TWlsK3pPTGhLdmVkMGVvdHRTOWNhN0Q4Nkh5cGpha2ZTbURnd0NWa2Q5aHRx?=
 =?utf-8?B?LzFlSnRwWlhieFJHMlpDbStuUGxRU2RsWFdzRHNpVnFRT1h2REVVbzJOS3Z3?=
 =?utf-8?B?OWxFZG81Z1owOGVIUkRMdlBTT2ZpUTJ6UVpUSk16bEVmK2pGN1F3WllJb2xl?=
 =?utf-8?B?c0VaZUFUQ3QvZU9wVXhaNGo1OEZ5bVdnY3hpd0QwRGVxU1F5cGRBVHpTV21a?=
 =?utf-8?B?a2V1RmNSalN2eGVmQ3RLQVdLVDdGL1pKb3ZaSG1iQjlaWklvNDY5ejRTZHRX?=
 =?utf-8?B?anNhc2wxR2libzN0WStXRzJERFZSN0hLdmJ2RStaZXNNRnc3UUlHUDZ4NEUw?=
 =?utf-8?B?ZndkcjhhK3BHRVpqa1VpN21UaDFIMlFUV2hOZzdkUnVTMjFZQkg1eFdnVFA0?=
 =?utf-8?B?VFZhK1psY2EvTkYxWW93ZXJzeFlTWTFJYlNNVFY0VkpaSGFWb1ZHazhmOG9r?=
 =?utf-8?B?elJmQStyeEdUYUJ3WDhhbGdGOWxkMkFqVzQwUVlnYld2d29mMzlzM3g4OW1D?=
 =?utf-8?B?cFh6bFVtNmQ1R1dpUFpUbFRHOG8vb2wwSlhZWU1abkgvc1Z4L2Nya2tha242?=
 =?utf-8?B?Y3p2dW9mcHhQcU54ak0yY2xObjN4M2c0MXBHcUJHTDhiNGtHeHFNRUlIUUxv?=
 =?utf-8?Q?E6U7Z1FVgcI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB5749.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1BvcHFEZi93YmVoV2ZMbHk3QU94WmdMRVV2ZjJNWi9XZy9SZWlNbDh2b2VM?=
 =?utf-8?B?c1VLZ2U5eWxYVUxsa2dpZkRWMjRnbWNEOWR3dkpSOFZZakY2VHl1YkVjQkFZ?=
 =?utf-8?B?bVBZZy9SK2p5aUJBai9oWmlqeWJKWVdzeGl4L05PaUJ6NXVwU1d4M0E0bmcv?=
 =?utf-8?B?bzJMbVA1U3ZJbHZqT1dYZXNMNDg1S2ZaWkR2SUxobDBxMkt6WXlodHFpdGox?=
 =?utf-8?B?cmZzdE4vSldKdVVQcE5ZWGVOMXh2alh4Q2FaUHYwL1RqUDFzN0VuUHduMVRk?=
 =?utf-8?B?YlBaRk5xRk5kOGdFdVpibW1YbXg3VEZ6c1BVQkxLOUdhK0FvOEJPTkcvYk5v?=
 =?utf-8?B?RGxsQ3ZwRUQ2UisydTE0bmZ1WVNZTEozQktzeithRE9vSC9jQVNldFdZR2Rp?=
 =?utf-8?B?UWtLSFdjVHp3dUJ4cGo1V2ZKcTl1eGFBUkQ4WnVBUUpIM2JJUFJVNVhMaE5I?=
 =?utf-8?B?bzhKb0tUd0p4MTJ3aWpaaHQvVnFnbzlYSmx1cVdDNHpRZnVXZ0dWUVdtSW1l?=
 =?utf-8?B?WGcyNmUvbEFpYWpMOVdJd0V4eWEwd2p6OTA3TUhDR01GUEZmYms0ZXdCNFdZ?=
 =?utf-8?B?eHpFbHcyQUhuNXlwTjBvQnhFSExhODNLVjNONkxlUFU5dkRTcHpoV0NXRksy?=
 =?utf-8?B?TUtvdWtnbEhzeE01Z29Ub09RdTdpdlkzdkxyNnVoelFKTHVKdGpNaVRUN0lP?=
 =?utf-8?B?WSs1d1RHSHB3RW5FL2xFMDIvR2RIVmY1aENQM1BybkcvSnBKWDQ3Y0puaGdS?=
 =?utf-8?B?dzlQN0I2c0F3dUtnYmhUQit6UWNVek0vS1NOQ2tDWHNqS3FSeGU1bDE0eFlq?=
 =?utf-8?B?dTVYb2M4N2liYzFYWmdmZlJVdlliYys5QWpUUWtTd2FuaUJzbm9DUVFERFE4?=
 =?utf-8?B?OGZUY2hTUTFIbTh0THFMU3hkalJnSXNXU1U4UmY0ZFRMcnU1V01nZVgrV2g4?=
 =?utf-8?B?aVBQcUtsQWtVaHVObEFoMFFwVkZSdTUydFhweEo5QTRQbDdGbkpva2tFWmZJ?=
 =?utf-8?B?VE82c0N3MFZSYlZPUnhteTB1ZHg4eWhPRzlRUUhpOXpId2NSWGhTODVyejBq?=
 =?utf-8?B?dGR1enM3ZWlWMHFQTW10Z3dwZitTQXZtbGtqSXFiUVZhZERqbkg2WlRJVllU?=
 =?utf-8?B?WmFoMmg1bmY0UzVUWGRhQWdjWTJ6K3M5THNibzRvWnhqaXRzSnh5a3JHcWZi?=
 =?utf-8?B?Ymh1UjY4ZzZXQjlnRU44ZjdWQmh1OVJINHJ3Sk1yM1JWSURzTW1ZRU01dmJv?=
 =?utf-8?B?NUVIb0RUUjlNek9oeDlkd2xmelI3L2NteE1ibnJGU2JMckNpVmM1dVdDd1Jp?=
 =?utf-8?B?bFpBbDM1Q1BHL1hKb1V3Vm1YWGhCb0I1ZktQM0dBL0hZOTA1alZaVmFPV1lJ?=
 =?utf-8?B?ZVR4VmFKT0JBK2VyZ2xRNXNkWVNOT3NLT1MycHp4SXp1SDY1L3ZjdE1jNVNG?=
 =?utf-8?B?MlFQZzBIQzZkNmh0Nk5PeGxDOWFUY1U0di9KM0tzTWd2dEc4RjJVNmJuUGxM?=
 =?utf-8?B?VGVSZmw5YlRvUXNXRjFHVFAvT0ViMjZZYUZRNU1yNEFzYVpVZXZoMmd5am1J?=
 =?utf-8?B?VWUwT1YyUzJTMldjUCtXbUVSNktGM2ZHUFZiRzY3dnhpaDV1NTY4WHo3RVl0?=
 =?utf-8?B?andVUFFaWmh5RFg0c1FBQXJzcjZSelhwRmszWDg5OTNYZDEyNWkvYTJRamI3?=
 =?utf-8?B?dkowdUJmWk9weHFKT0E4d1c2SUhqMUxsSEVSUWtPTU1aU0NHTUR4TXlsTklB?=
 =?utf-8?B?ZUIzaWQwYTNFT0taNWh4dTZOZW1yNG5mWkpQb2tnbmhzYkx3RXM4TElNeHd5?=
 =?utf-8?B?azI0Z3d3QTdvekY5NU56NksxcjVKdDRkY1F1Lzk3enQ0YmJUdVRHbjlFZzRP?=
 =?utf-8?B?Vmo2R2FlZG5ZL1MybWFTd1BSdkhBTTBJQVNBK3ZaempnQUFXd2dpbEJaUEUw?=
 =?utf-8?B?RXAwRUZtU0RUdFhrd3Z1SHdhMmtXM0pPYXg1T1ZUUEZZWGxTN3dGWVJFY3oz?=
 =?utf-8?B?SWhqTzZwUWJiY2l6bjVvYlE5VVpVUVE3Y0FnSjY5aVBlSVVvSUdRRlA2NE1p?=
 =?utf-8?B?TFZUK0tOSkhMVURZZjhhbWVJQTY3R0xUWEY2U1VTL1VjNDR4RXRRYkVtNS90?=
 =?utf-8?Q?o8m5GUGkkoIIrZi+qCHEVp0n4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sB4WWroZZhY1Fn4pPcPo10ayJkjpFKW6wBT3ABYLwtWroe4RIAUcRviJ+ORzNno+nxMCw6RNGrjKpc/4qclGNrIclNXNuq0uoaL1C4CTAwCSkYUv/3nUh/TCdZOKT91IUBVrLt+Q7B/aO4r3VFojrEEVL7yoGoOQth/Y2jI6wc0QCxDd0616m/glgJUlfBWgXUl0KmCM/764QoM2a+gx9cuQxFhKNkASlkit62NRA6oidtx8tGQg4L5X2GllVzJ2Pam8xtjCuL5kyy9fyJP7a8/ox2vj5XNb0le6+HxDw7EghcgjwgSlfEOg5ATo0QI3djcI/olKqErqlTTH6ztedshabUPOj29V5weHgCcpLAWw1itcDvMz39abJA4pC4AfYNz4Tc6g9Vje3g8WxYl6BUakQKj76xs4fdhSmA4iu6n2Erw92Kymusw2lta2T3yZAjvzB86OikINM0VaTUe9jrilQY9rTOonFTw3pCdoOKYvLJSptplEywhN20hkfmrOEyfHHASxVWt5ZDlDHKSxWX+eG8sL0qh1AOoLLvZtnlIfu0n9HdvBijvgmX+aFRN6/q0PbfaY+VW7v+N3gqvLDKnRS3zyBiCJR3v/GlhT+8I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0f4ae9-1d3a-47f6-79da-08dd7df3cd57
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB5749.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:07:03.4035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVK9bxPXj3mXjefWEKHaBpPQK/QIQ3paFd102dq1CCY+unKT2u7Q0+eb+uagUQVmeBhUcX6YLeT8/A7nt6BMTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504170155
X-Proofpoint-ORIG-GUID: 8S--FOMfz5NhnkCPXzvKqXJQGSFDQYGJ
X-Proofpoint-GUID: 8S--FOMfz5NhnkCPXzvKqXJQGSFDQYGJ



On 4/17/25 13:12, Andrew Morton wrote:
> On Thu, 17 Apr 2025 12:15:41 -0700 Libo Chen <libo.chen@oracle.com> wrote:
> 
>> v1->v2:
>> 1. add perf improvment numbers in commit log. Yet to find perf diff on
>> will-it-scale, so not included here. Plan to run more workloads.
>> 2. add tracepoint.
>> 3. To peterz's comment, this will make it impossible to attract tasks to
>> those memory just like other VMA skippings. This is the current
>> implementation, I think we can improve that in the future, but at the
>> moment it's probabaly better to keep it consistent.
>>
>> v2->v3:
>> 1. add enable_cpuset() based on Mel's suggestion but again I think it's
>> redundant
>> 2. print out nodemask with %*p.. format in the tracepoint
> 
> I do agree with Mel - bitmap_weight() is somewhat expensive and
> cpusets_enabled() is super fast.  So the benefit to
> cpusets_enabled()=false kernels will exceed to cost to
> cpusets_enabled()=true kernels.
> 
Ah yes, that's right. Thanks for grabbing it~

Libo

> This isn't traditionally mm.git material, but it's close.  I'll grab
> the patchset for some testing.  and shall drop it again if it turns up
> via another tree.
> 


