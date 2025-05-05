Return-Path: <cgroups+bounces-8020-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2E7AA9E73
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 23:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8117D1792FD
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 21:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896C02749EB;
	Mon,  5 May 2025 21:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qCBaJBl0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h1SVVWhf"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766B01DE3A6;
	Mon,  5 May 2025 21:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746482281; cv=fail; b=FKmBomLEAz1pNvSBeFuqKCjEjfzTj5JhjGE/iz6eHcv5826hiatdCg0HhvZsEo0xrnCuOGuOvDsm5CuZZ37m6e7rDxsziYgBIL5Yaf1CjbuzzDESVIbMiSpsD8Ixe/hQ8qVVafjoGKB5D4/uL8s9xa27xJzznOppMdVDnqgLlTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746482281; c=relaxed/simple;
	bh=KNKLBpiukJuW79E4PK//lKRtQLXfmAzGb6gM4K82JNY=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GR8TKF9SsXGGMQ7dRQ0aQLCabV6h0xMJybn/QWtB/UCOLcYXg1rnFWjLzIqiYKNlgJWs6Sl0hCirqDFevk2h8g5Im+seoLIx7syDA2PBMwBERAkJdn3JYzr8xDkoL4lICnaB6SOl/SpEnL+pBzXQr4OaPozthJSFwiTYFnOTUE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qCBaJBl0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h1SVVWhf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545LtY9j016573;
	Mon, 5 May 2025 21:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7CxS3+ajB9eK0z6b94Tpnvz4A7XdjZcxVhDHCJFzZVU=; b=
	qCBaJBl0FATHIIcUNF7dRZvDXun7ou6bFFdimoiTjGQmLI0yUaaeWTFsIRk4dME7
	cXYpciYUzIJbQOzhYRh0wzlH6nFaS4xz24bp7T6GZS/b3dNpn8NoZ7RtC9d/mJst
	l0eDGmJ3jbLRPVOkGMVpbcCj0aVE75YGmXcP39n9ZdQsE4RAu880SmCqw12Bk4SY
	e+CsQ/xkYutcvN09wrwTmg/NHef9VBK5WcE6mgNX8wqZwN/oAgpQHRfjoAFi64oX
	IYXLjxyQdWZVkUqbJFpukE8TWGLUh4rfeyTVR6mCqii5wbh6kbYez82iYFQldDga
	Urr9ZQ8e6msuPlGQ9vm3Cw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46f5nqr02e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 21:57:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 545KVINl036131;
	Mon, 5 May 2025 21:57:35 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010007.outbound.protection.outlook.com [40.93.20.7])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k8ygjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 21:57:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQGJDQ5USNa7e+U91iMCifze0nWMCyvCLg14BjCpzTW8b/UAByKxYhAq94CE2Bhj58msm8gOSO6zJ1yXJcbmx2eCBvMx381pqRryZ9nPTpBi7eOBWsFpQKDp9KhUSDKXl4IYnb0g963w54JITZapv6QOvqVoWssJQnXxkH4D9GZ+gnXOJxA7rNfH3278VwPeoTWzAEb9OcuTDQoZQax1VRkFJh5bRWgriJrDcMGePIeSxmhsT092nCVYjls2j2RbZ5R+QL7L51CrWPvp3peg7J4x23/4Lw4BYpIptxWbUbhM9aSrfNdWaCTk46AdnyhuYEYvp1FwHsjscMIpXfrEug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CxS3+ajB9eK0z6b94Tpnvz4A7XdjZcxVhDHCJFzZVU=;
 b=ssYwdGV+8/95zzY5+32s6kMDTWF59rSiFD8Y78O8jUef3IRKzkXAxY1ErY0hhmL3Hf9zBRHDTglquP9zctjRpAwMuHPmW1qy7HnNzQa+HR5u5fkJ1mU/MPdCbnqLaMinx5dVtESpfmJ5jd+c399HX8uzRo2XXjd7APeyRBIHgRxzj550I/JQkqLurHQ/5dkp1RXVF0cLqESI418Idq5asPu5/AFDtJZ7qIIeAb2Qb9jO+GqIdUqwl+VfvqIHPd7GdkRr0V8YN0bcqUxP33kBXC12txGardcQovOjWorg/iSuiLlbJK1wVijsz/X+9RPhVa7OiyBNmqejsZRKj/qrZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CxS3+ajB9eK0z6b94Tpnvz4A7XdjZcxVhDHCJFzZVU=;
 b=h1SVVWhfVKOB/nSTlB8PSPNt0wN93yuYjr9jH/NTAkTaYK3fRv/MxBMsK2Gr8+BDn5T75VtvDr6oDMXrjhj6aeFmijp/T5/9c1aa4PR/aXlUixb5nc9TsIjCkHWbKn79cBMXIMAo3w/Evk9kZqMjNb1/Qxk/fqABEMHFnx8qvd8=
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f) by SJ0PR10MB4783.namprd10.prod.outlook.com
 (2603:10b6:a03:2d9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Mon, 5 May
 2025 21:57:32 +0000
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::2072:7ae5:a89:c52a]) by DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::2072:7ae5:a89:c52a%7]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 21:57:32 +0000
Message-ID: <c20fbc3b-5adf-488c-b6f3-0d4e3c9da5c3@oracle.com>
Date: Mon, 5 May 2025 14:57:29 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH v3] sched/numa: add statistics of numa balance task
 migration
From: Libo Chen <libo.chen@oracle.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: "Jain, Ayush" <ayushjai@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgormanmgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        "Chen, Tim C" <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Neeraj.Upadhyay@amd.com,
        Peter Zijlstra <peterz@infradead.org>
References: <20250430103623.3349842-1-yu.c.chen@intel.com>
 <8b248ff3-43ae-4e40-9fa4-ba4a04f3c18b@amd.com>
 <bd936eba-e536-4825-ae64-d1bd23c6eb4c@intel.com>
 <tkfh4h5ntl42jc2tnwyj6dhiqouf6mowin7euvrnbs2tyiqlay@bpzdptv3plsf>
 <0bdc72c0-8f4a-4d91-8e67-f8d56dc26788@intel.com>
 <5735cb9d-86ae-4c8d-b0b0-5b0365843707@oracle.com>
 <c7444174-fa5e-44c1-bd16-c8971d118b1b@oracle.com>
Content-Language: en-US
In-Reply-To: <c7444174-fa5e-44c1-bd16-c8971d118b1b@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::12) To DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF5ADB4ADFC:EE_|SJ0PR10MB4783:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd70941-8102-4cd1-c8d4-08dd8c1fd608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tytoc2R2SndiRU5NUFlzdHUwNkE1NjJKdlBlM2txVzFRUExua1F4WHJxaER0?=
 =?utf-8?B?bFVZZ2VhNG5oM2xZUlUrTE9SemhOdytJTStQWWRWME9tN0xhTVplajR2eEQr?=
 =?utf-8?B?L29hVG5YZ1hrOVlCdVp1RW4xVmQzTGJsVFAySGhmQ2xyWlFtQ0dVTHhpL01j?=
 =?utf-8?B?TEk4N0dFRnJoK2NRUG14bUVsNXpZWlZDNDgyMkVFeTZ1QmNYWktEdkU2Wk9y?=
 =?utf-8?B?b21KWXNxOGJYTnNmcElhOFkwWklJRnliSWhwWVhaM1kxNFFML3ZBMC81Z3ND?=
 =?utf-8?B?eExUU1VUenVFd2pXbnFQbjlMSnM3M3ZFYXkweUJ6ZTN5RUlvem54Q0EzM2Fy?=
 =?utf-8?B?RTFYQWhvRC82NXFWRUhtdk5XMHlhWXZQYjhVYmRJRTlIT0lKVVNYYkNvTW5s?=
 =?utf-8?B?UU1aTjNxQWwvWUdkN0hEZW9jQk9WRm1ldHJldG1Zc09Nd0thLzk5U3FwV0Zx?=
 =?utf-8?B?bG9FVno4bDlKR2dnd2hyM21qSXpqZnlKelJwSmUreGMrT29tWnVXcC9tVWlr?=
 =?utf-8?B?QW5BVDBRTll2WW92SWJWdWJBT2pwSHRIQUFxNStOZHptYmNJSFB5a0ZOK0JS?=
 =?utf-8?B?a3NQWUF1RE0zZzJFY3hCZFVxaGJMRTF0bGdZK0thNzJHejA0cUh1YkNYSUF1?=
 =?utf-8?B?NEVkMG85U2poNVVLd1ZhZ1N6UFF1SzN2WitmMzRYUm5ReTRBNlpkc29WL0Nz?=
 =?utf-8?B?cGtGSnovVUtoeWNqb254cUU3Y0NUM3BtWDc3UzZBNDNyVXRSVXdrR0dHWUFv?=
 =?utf-8?B?cXRIbUptK3V2QnYyMG80QUNlTFVOeE1TdGJLa2dkUVJaNVRLYk9waFQ3V2hs?=
 =?utf-8?B?SzloOWppZGc4MzM5RVgxZ1pxREhhTUUxSGczL1BCOHJoY1htS3FvU05VWkdm?=
 =?utf-8?B?MENqZzR2RC85Q01sRlRHZ0UwWkNDY3RSeEZCUE02Wm9JbGFVRWFQN3NobVhI?=
 =?utf-8?B?dHlaMmxLODdSd3ZLTjV6NTQraDFVMGlpK09pVTE1bTM5TVM5K2hGWmVRaUxW?=
 =?utf-8?B?Z1VybmxCWld4c2gxN2E0cHNBRmN1TWg3THM5Q2ZVZTdBZTg5WmtNN0svS3pD?=
 =?utf-8?B?SkVKZXNEYXM0SlFQaWZmUFVOMmZEWnZhd2NDM3dvTWZ6WDVVYlllQmZoNW9B?=
 =?utf-8?B?aVl3ZytVMDlhM3NSMjZLQjFkSndVOW1WbFI1TFlXL1V6WWFHV2RONXJvRUth?=
 =?utf-8?B?ZnhuR2RhNmQ4UnhEbnQzY25IZmsrQU5kM3kwVEpzZXJzMndCTHlkRDE5T3U3?=
 =?utf-8?B?K1NUWU9tN3BFSVppVGxHWHFWcXNqNTlza3kxc3cxY0JSaURZaTMrMGk1RjZX?=
 =?utf-8?B?eVpOZGtURkdKcGR5NzlWYjFRYWJFc1d5U3ZwUXd0bWxXWnROc0YxR0RLRVYx?=
 =?utf-8?B?TzhqL3J0d1JMWnRYU2srbWI5Znlhc1JuaUkvVXVOcWRrZ2tMTzI0VmJ2bTdU?=
 =?utf-8?B?dVBNL0xlZzZ4eWNEVmExVFdqaEtiamJOZmROVWZrRWdtRkdlZVpHWXEyNUwx?=
 =?utf-8?B?TmpmRUttN3R2amNMblp5YnF2R2YwTkk0UGw2NzVUK3FGNmNrOSs3bVFSTHBJ?=
 =?utf-8?B?b05XcnZFTzhNT1dwbVNLZmhsTkYxRy95UnI3WTJTVzJwUEd6OHlsQmtqN1RM?=
 =?utf-8?B?SlhITWxlblg2c2hxVmtTVzUzWTg5dXlzL2dhNlJEQk5kbHFnblE2SmdrUTRH?=
 =?utf-8?B?dG1nbmJwNU5ObEJWdWJady9ydWE0Q1N0WjZrR1RsOXVEL2hkQnNsMExPak1l?=
 =?utf-8?B?MXI4T2w0OUgzak82dWFQYncraUJKbTdZY0tnaHVFK2tRazNSQlB6NUUzdDFZ?=
 =?utf-8?B?VDY1TytjSkFwVXBKTnpzaHpEd2hMMTgvNG50cGxBV09UOGkySmJUUisvWk8w?=
 =?utf-8?B?UGRtYWVUbm1BenJZOXgxelpjWVFCT0s1Q3FZNEdZelozaHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF5ADB4ADFC.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUhvMW9VRjBId2QzeUJhSzNJREx0V2V6SWtrUTIxamhzYjY3ZnZwZUM1Tis0?=
 =?utf-8?B?dWJuL3g5dlZaM0pIa1QwVUxzRHpwc3J1OG53amdDS2JSWjlWYXk4enVzd2dQ?=
 =?utf-8?B?NGM4ZU90RWVpdmpjZFdCNDBSTkM5aUhzMkZteFBWVE16MWo0c2NadDIvZGNV?=
 =?utf-8?B?OEJlRnljbUh4Q1BNRVd5eU5zUHA1Nnd4c0hkNWF2STBPVXpOU1FrbWZPeVhM?=
 =?utf-8?B?RjdIUDZwYm1QaFpiNGhDZk1oRFRwMnJJREQ1MnJ2R2ZaL3RCRzdmYnBQWG5n?=
 =?utf-8?B?RDAxd1lvdmxxd01LZ1kyeEtpc0pWTDhFZ0dYc0RlUWFRdENOaVpmdlFOQVht?=
 =?utf-8?B?YTRmWmNjZkhaTHBCVkFRTGtkZ1RCRmthbkxCL0FvL29MbGNkdWZiNUxHVjZw?=
 =?utf-8?B?V2RXVjM3VUVYYXlnZWl2c3FMQ0VjSzdINjY1NkVJQzArZFM0SnFtTzRpQ2ZO?=
 =?utf-8?B?UjRtQVdOODk1SDVkam1rNW5qamFmNjh2b0lseE1rZ3E2TGZWYk0rUVgwSEpQ?=
 =?utf-8?B?UTNFSHFUemFIT2w5Tyt4RkttaDV6UXBGNUVVYzBsUlo0VjNldW82cXFhejFO?=
 =?utf-8?B?Z0tXZWoyeHhsQTVSUWFLbXZiNDhDTWE1U1V2eDV5eTJkTHN6QWpvTUZjNTNS?=
 =?utf-8?B?WjNMWEp5WWpKTkN4VHQ2d1RvelV0NkU0UVBiS3JiZE04VFB6amN5cU9qYW94?=
 =?utf-8?B?bGRlc1ZkeUNJdG1jOCtKMlBTVDNVTi9oS0tsN0FyVzVjakYzVCtyTE45dkpF?=
 =?utf-8?B?NTI4WkNHNE9LelhvU3dIVHNuU3Iyd3hRM0ptNTNQdDZ6a3dDeU96K3cyc0wy?=
 =?utf-8?B?Sk1Sa0JmK2h5QWVCQS82Z0tVNFUwOVJid1NiU2I3Ykw0bjJ0R1ZKS2pMY1RZ?=
 =?utf-8?B?UGxnYWwxc2Z6b2FVQjJ4alJGVFpZTFNZZ3dWeE9RS0ZsWHdFMUdsUnFmR2ZY?=
 =?utf-8?B?MCtvOVd6NTJCMWYzR3NqWUtVUFhXTGx5THd6M3pKWUlUYUxMc054cFMwSFh0?=
 =?utf-8?B?cVB1SFpUM0JwbUMzNFhRZTVJa3prbXgrU1ZkcDZ1YS9BUzhVaHN4eFpUS01u?=
 =?utf-8?B?NE04NU9QNkFDL20yQnA1aEhROUZpQWJrVW1Ib1ZYUlY5MnlKZFlCOEZsN01X?=
 =?utf-8?B?Zk1DU0EvUk4wODMzV1lxd2ZIQ1NLT0p1RUc3VTJyWk9ELzJKd0UrUlNxZWlC?=
 =?utf-8?B?S3VrU2ZmcHJiWGZjejcrTXpZQWliQTlFd2wyQitSQkVzclp1UzhoQkVDTENz?=
 =?utf-8?B?NHVsRFYvelVJT0d4OERrUlBSb3Ruc3Y5cjdCRGFzemNDaVIrWVpaV0E1OGlv?=
 =?utf-8?B?cCtFQ0szOEtiTXdxSzJ2VE5BRGFEd1B3QnFOZEpQTHorVVV1NmZlYWJpOXJx?=
 =?utf-8?B?d2k4Y0xVRU10ZG1oUGNaRU5EV3ZmTlBRNFNXdTlRMSsxTnhjc2NLTDVvQVBG?=
 =?utf-8?B?Sk92U2FEQWIzUjF6akJqQmY1NWFYSUhRaXJYazQzMUcybEt2VWlvR2FJRGsv?=
 =?utf-8?B?d3M4MWFDSU9SN1haWFNtcjNyc1lwRnJzd0cwNURiL2lRdWJCTmRveDRPYlRv?=
 =?utf-8?B?c0RCQ2l2NlJuK2Z6NkhVb0pMZTgrZHBHZFNZcmVDMUtzNWNDYVhvaUZndzBi?=
 =?utf-8?B?MzhGYTNFMERJaFJOMEdlYVRCdVdqUVplN3hvOEdkM2V0aURIRWJJemZGUWEy?=
 =?utf-8?B?cVQzUEhObmo0R3BJQkFuU3Z5cWRRa0JSVDNrNDBQWU1EcjZDcyt5M3pWcCtT?=
 =?utf-8?B?Zm0yVHlVeDMzVjc0M1hRRVhUWjFhaU5JaUJRbkd2KzVxSmdiU2FrUGIxQ0dR?=
 =?utf-8?B?eEx6UDkvQnMxVE1jL2ZYSVRDZkY3cFlwaTQwLy9FV0xqM3pyakZSWDNyWmZO?=
 =?utf-8?B?YXI3VndxMUVuZlNRNy8zeWJQcVFIbGo1QnUraVdveDBTVmUwQ25hOTcyKzkw?=
 =?utf-8?B?R0tIOWJxTC9NdUsxWE9ETjJtSUFtNnVndU1pOGFGSi9hRjRoQnpNS3hmUXVB?=
 =?utf-8?B?UFJmSFFDT05kYVdjdTQ3NVM0R2U0Y2RSVG54d1Y3K3I2MkZtSkpNUlJXYVAw?=
 =?utf-8?B?OHh4WEpnd01NaGNMVy9YWmRFUHhmQ0FCTkZCYW1peFNsQmFtVnp2ZlVERVpK?=
 =?utf-8?Q?z/8EIQ4+CEi41xl0WpMNJWvHj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dRa/zhW3Kf0CFRhBAO7s8Mw4jcVGTbMq6EQo+PEk9qK+om+44KPkUwenBk7H0Lu4zOCAsk33qZT+yhW/Icw0tD4KepXTsvrmS0PEI/T5soG/s6nRAXtYhGvCV3LbdFWAW60tXnfOJf90vF1a+F0EnttPh+Iwy27S0tLe1P8PkRjU8z0WQpoEl2JeDftqh2DhNAkJ7dcTnkj/Y3+a1VVaErdq94uxfhjsfqC4M2iI/0BbEbTwK0kdCvIwMmgrHJHniJX7cSI/nVqoSwj7PlPWlXRuEBCPJJ1i73cLX/XJSjTxrgY3B94jMGshrIetXvaFGssiiS+pZIu9ppCM5f+Ko7Luh+2dNr0EEReQwQql09U/Hs2GXGiXcslD++mu3/FEkxNYmYMJOZLKptvLLVyf0CeGZsuvMIFIbzKSlQX4hK+NPk29dmGUrkc4ql06N+1LXUUu+rMt5DAXzSS5sbQYRa5Nnf7CmjpKnE0Wn4bZlS1xImVAPZB9excToVz4HvE9EEmlp0aLiQZhDbzu7vNpt3U6ijjLIoo3+9NHYls/VVrQPoiIqso0/p42dLDKAAwGKzBaDhQ39KUn4cmw0J8TBVhRO7fjWc+ePfsIwyafD4A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd70941-8102-4cd1-c8d4-08dd8c1fd608
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 21:57:32.1185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlR/Yt1BxEwzZbIMR1TUjWb2jbgKJT8jK+Gaqzz5nWl5LVkRiSrr+dKsvZ28UsdQjavxhDFEhrYQej58z6agHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4783
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_09,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505050206
X-Proofpoint-ORIG-GUID: TGuwG4LykgTNpMfJCOo4I9o4NRYyzZWx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDIwNiBTYWx0ZWRfX36Grb/amlpaT /2O2hINGeFoWB+yd7Ej4u3mA1VJvceSbTsANd1OiE9JaG6VZs+tYnK4L33pjRJha0mrJNs23WwS kt6Pz7RM3+5wyShDo90xA1Hy8a40I1R83OZSHloaY8Da9M4oiDG/LrFuNIcynSCqmyUrXULMUhX
 OASadHVKM5sDkP/0o7/NGiEx3d8E1H9N6x0lkAETYkeAYXBJ5ypxOjP98g/B4tpI8VrD8veEGXX 13uzotvVYR92RIQnEr+i264pw0kgzGBEQ2qYOt9oknDcqvTLshf/urvlpcQs8h25rJ/t+GV6Dw6 +HvBu0LqvhlSDzBBJONhihDX2nVFHf/OxCYYFFZNOC84doNNBN6clRjEiDppE8RcZ5UK6nkvAhW
 WTKFuLvnTbfEQq3kmDDObVNkg1WIBVijxw3dgxoiW2FrUSg86SMUpuB8Syk146xPdu7uNp7X
X-Authority-Analysis: v=2.4 cv=CrW/cm4D c=1 sm=1 tr=0 ts=68193450 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8 a=94XYBJeqWKdSvao_CTAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TGuwG4LykgTNpMfJCOo4I9o4NRYyzZWx



On 5/5/25 14:32, Libo Chen wrote:
> 
> 
> On 5/5/25 11:49, Libo Chen wrote:
>>
>>
>> On 5/5/25 11:27, Chen, Yu C wrote:
>>> Hi Michal,
>>>
>>> On 5/6/2025 1:46 AM, Michal Koutný wrote:
>>>> On Mon, May 05, 2025 at 11:03:10PM +0800, "Chen, Yu C" <yu.c.chen@intel.com> wrote:
>>>>> According to this address,
>>>>>     4c 8b af 50 09 00 00    mov    0x950(%rdi),%r13  <--- r13 = p->mm;
>>>>>     49 8b bd 98 04 00 00    mov    0x498(%r13),%rdi  <--- p->mm->owner
>>>>> It seems that this task to be swapped has NULL mm_struct.
>>>>
>>>> So it's likely a kernel thread. Does it make sense to NUMA balance
>>>> those? (I naïvely think it doesn't, please correct me.) ...
>>>>
>>>
>>> I agree kernel threads are not supposed to be covered by
>>> NUMA balance, because currently NUMA balance only considers
>>> user pages via VMAs, and one question below:
>>>
>>>>>   static void __migrate_swap_task(struct task_struct *p, int cpu)
>>>>>   {
>>>>>          __schedstat_inc(p->stats.numa_task_swapped);
>>>>> -       count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);
>>>>> +       if (p->mm)
>>>>> +               count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);
>>>>
>>>> ... proper fix should likely guard this earlier, like the guard in
>>>> task_numa_fault() but for the other swapped task.
>>> I see. For task swapping in task_numa_compare(),
>>> it is triggered when there are no idle CPUs in task A's
>>> preferred node.
>>> In this case, we choose a task B on A's preferred node,
>>> and swap B with A. This helps improve A's Numa locality
>>> without introducing the load imbalance between Nodes.
>>>
> Hi Chenyu
> 
> There are two problems here:
> 1. Many kthreads are pinned, with all the efforts in task_numa_compare()
> and task_numa_find_cpu(), the swapping may not end up happening. I only see a
> check on source task: cpumask_test_cpu(cpu, env->p->cpus_ptr) but not dst task.

NVM I was blind. There is a check on dst task in task_numa_compare()

> 2. Assuming B is migratable, that can potentially make B worse, right? I think
> some kthreads are quite cache-sensitive, and we swap like their locality doesn't
> matter.
> 
> Ideally we probably just want to stay off kthreads, if we cannot find any others
> p->mm tasks, just don't swap (?). That sounds like a brand new patch though.
> 

A change as simple as that should work:

@@ -2492,7 +2492,7 @@ static bool task_numa_compare(struct task_numa_env *env,

        rcu_read_lock();
        cur = rcu_dereference(dst_rq->curr);
-       if (cur && ((cur->flags & PF_EXITING) || is_idle_task(cur)))
+       if (cur && ((cur->flags & PF_EXITING) || !cur->mm || is_idle_task(cur)))
                cur = NULL;
                                                                                                   
> 
> 
> Libo 
>>> But B's Numa node preference is not mandatory in
>>> current implementation IIUC, because B's load is mainly
>>
>> hmm, that's doesn't seem to be right, can we choose B that
>> is not a kthread from A's preferred node?
>>
>>> considered. That is to say, is it legit to swap a
>>> Numa sensitive task A with a non-Numa sensitive kernel
>>> thread B? If not, I think we can add kernel thread
>>> check in task swap like the guard in
>>> task_tick_numa()/task_numa_fault().
>>>
>>
>>
>>> thanks,
>>> Chenyu
>>>
>>>>
>>>> Michal
>>>
>>
> 


