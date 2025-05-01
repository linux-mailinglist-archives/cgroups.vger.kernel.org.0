Return-Path: <cgroups+bounces-7967-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BA2AA5B4C
	for <lists+cgroups@lfdr.de>; Thu,  1 May 2025 09:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6EE462A63
	for <lists+cgroups@lfdr.de>; Thu,  1 May 2025 07:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E21231825;
	Thu,  1 May 2025 07:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U8Q2tfRS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oENtXCf2"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77F72AD32;
	Thu,  1 May 2025 07:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746082888; cv=fail; b=Kq+Ko73o5HFEROcUJhDRjqaCHHK80G7EzLzoauU5jtA/2ibP8kJq32LA2kb7kSYyqhyGLvf6HdNmCdlxHPo7Y8P3RetaNS7LF5sZjYt3F5dHzsY5QE2GWLjB2j8yIzEuTvHEonipvhfLIc9anpzrjAujK9+WH+v4/EGqTGFJBf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746082888; c=relaxed/simple;
	bh=JIzakwjcvZsi+c9o2lxAsb6sR7kSOQMKL6IIP11c6ts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JFCHGIh3ZDJnoY72x4gL5jT52AqLmBhko7G4SUrSENb/Y7TEQUTAahdfKzeMjT5G3s1+mLIjIMwSmhLbaajjoldStedkLo6olQZUTE4tTdGU5d9pw5mOXKjvMQ0cmqlMhCCN710gH2AHSdc5UB4O4IYExHhP1/Lt8KQPcG/uWAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U8Q2tfRS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oENtXCf2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UKwNvd021255;
	Thu, 1 May 2025 07:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0zS+X1gZ/nfDK90gRHbHDx4tDHooBGcfOKrzY+Ckmg8=; b=
	U8Q2tfRS2kk89zneEtEjymNMfVOYSkw+3J3d6aWoB0JH/gcxDWHLoun4gYIwe5Ou
	7sfp5k+tn0//E608sQfrE7dQy/tpMvJuTlyhcpRiW2ysjoMtjVIkJ35e4bPiZ8Iw
	YEur0mqi3/XLfFwz/fFtCvRnHsuV9xzsaJNAm49iWg/IvmuoJSAw3Tf62YEwOzOM
	/TSHXdclNCgyJ8LAvSYz9QnZLmQ06EpXGgmERLph3uytI1i1SyVwKw9ePo/s80uY
	Qbocb7cNhxqSZaCZNmpF/PItrCJXaHkBlSsuWSslVi8jEtihEr38hsvQ4aYIm/08
	mFy3NAMxs2XAavd4stOZiA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6utamn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 07:00:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54169U9v013866;
	Thu, 1 May 2025 07:00:23 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011029.outbound.protection.outlook.com [40.93.14.29])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxc9kt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 07:00:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDQEB55nUZmhG1JE19yzWP+E119MNLGGeKPPVgyBcSj9A+EJUYFzds1R/QUGxn9HAAECeQWnON60ehU+YMtwPHxd4pk9vp04WGX4amtSzeY7HH0ZBwhHe3oqfoq1F2drhAtX+DYalxP05X4v60pM8JogzSGUo7B0s4rEGhPn1b2U2cMXuMvKufXZ3L19dKwxK9WkiL3djjS0qW9tL7VqDQC/7/t/fe6b9NqFolBUJYYHeHrUob7Hw/Wd+qBxDbWy/97nCLZOiK1B3DurcY6/tcqhXUvv5kcvQHoNAhFoUVR6CaKhOfOYDzWlTjjGD/2M1LhuUsJYW58h5IUrM5z71Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zS+X1gZ/nfDK90gRHbHDx4tDHooBGcfOKrzY+Ckmg8=;
 b=zI6uP7mwHTyy7Eaz8Yf4iJ/xlreVsN+ezJwNX3EaBTdxw2apU/U0nM73wxXgV1P8u20DxvMKRY9bZ1JAc5A6Otw9hLvVcTf48VHmlgVUcEsWE59taowHMXaBN4BpNEIEDWJ/8LMa9fSmegI7atYWcCxtWh9HMY109XuPOGkPJ41koCHdJYl+qcgY3gT5FmlKEMf3q99/PLDKlWQnUFXH0Vi54Wq5YicUmvsvBFwXaqNt9MYfJEFeG3uhllltqwYylXyM9qLeeG4XfYvIyFfyINoIkoeCGWT/igJ8CI3CTM7XEZzV1jqMd2hGK6gChO2gIxIg3pLL0PiwzCIFpOenPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zS+X1gZ/nfDK90gRHbHDx4tDHooBGcfOKrzY+Ckmg8=;
 b=oENtXCf2gFqfzeLOXkNfA9swA4pkTfKN3o+YHkBYrmjdIczWh6Qz/vBMo0nd1+8Iva1fN29JEYuLBP6Q4PdJcigsgYmy4dl8hRW+V6gjRxlcBpMQ3f3FxFZMHJcay1YMZInTokis19vRZ1Tgg/YJHdtbbpEygdWckkMXvdYRk7k=
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f) by SJ2PR10MB7826.namprd10.prod.outlook.com
 (2603:10b6:a03:56b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Thu, 1 May
 2025 07:00:19 +0000
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::2072:7ae5:a89:c52a]) by DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::2072:7ae5:a89:c52a%3]) with mapi id 15.20.8678.033; Thu, 1 May 2025
 07:00:18 +0000
Message-ID: <9a6402ca-ce63-430b-b60b-1a36971e37e4@oracle.com>
Date: Thu, 1 May 2025 00:00:15 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH v3] sched/numa: add statistics of numa balance task
 migration
To: Chen Yu <yu.c.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgormanmgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Michal Koutny <mkoutny@suse.com>, Muchun Song <muchun.song@linux.dev>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        "Chen, Tim C" <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250430103623.3349842-1-yu.c.chen@intel.com>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <20250430103623.3349842-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0094.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::30) To DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF5ADB4ADFC:EE_|SJ2PR10MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: 3607cf98-26a6-4942-5cfc-08dd887dd543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnpibWtjaUpsYjNNUkJFNndJMjlkeklCVElMbXVTdXpOeXRxVnN6em9JMnJs?=
 =?utf-8?B?TkRkN0YyRGtHVlFMTGdZMXE3R1BtREkwbElhZXJCdlEyN0Y2M2kycFNRbFRY?=
 =?utf-8?B?d3NVR3lJMEpiMUIrRDZlR3l5QmhHckRPeVRqVENwVjFqVThHNG53a0VnbDBY?=
 =?utf-8?B?dkUyTDIwVm14K3MxbXdKSTNMRUdlTmM4WnQzQ3J1bDlZMUkvNXM1OGJRZ0xj?=
 =?utf-8?B?WEZ6dDBHUGRQLzFMQnBTalJhdzNoc1JnU3VndXZTTDVkYkZzOU9UdytaVWdk?=
 =?utf-8?B?L05sUmROQ2VzUVhsRDhKZytDOHJuNm1vcUZIWjRWbDVPaXpmc2o0WGhCMlh1?=
 =?utf-8?B?MVUvbHg3RDZzZ1JCT2FWb1FPRHYxdmNVbndaeGZNSU8wbFpCZ2RGSGkzKzZQ?=
 =?utf-8?B?eUhPcEZ2VllIdXNLNG9ob1FYMzVsakU4bFluZ0ZiSWRWS3F4Zy81ZlZjR08w?=
 =?utf-8?B?OHNxK2xDU2tuZk5UcXF1NlBvQUtQTTZVT05BY0M4eGMvdnJkeGViL3FSUmtq?=
 =?utf-8?B?ZjZEY05FYXE3T2s5NHk2eWh6N092Ull1TEE4RldnU3l5bGNtRDhJdko3TWw0?=
 =?utf-8?B?NDdoQUx2UURvTFpqSklxTEh3SzVjcXpkTXphZW9KY1Q3QnNjZGVwelBYN0R4?=
 =?utf-8?B?L3VhQlppRGR4NERmdlNJSC9qRkdJNjAydms0MzdjeGoxWGNCRHN5cy9BYnNP?=
 =?utf-8?B?RFloNnViSjJFY2l0V0tnNXY3Vkh5SktuRmdsWVBtZHJBOXBjd3Ixdm9JU2I5?=
 =?utf-8?B?UlRxY1hlOXN3TjZKc2tBblI2L3JMWTE5UTdEbC9NSS9idytXWjlPcTNWMFQy?=
 =?utf-8?B?Skd2TkFWWlRjMFNqbXMvQVRpZXBPM2FkdDFCZFhRSGhLNjlhVGpuS21Jb0hi?=
 =?utf-8?B?aitDdkN6b1AwRDZmd3VQV3pEQVZkV2pHLzN1cUNTZWRnc1BOTVJ2bWJmVEZ0?=
 =?utf-8?B?cVNWWS9KRGJtRU53S09QcGVlZVRqU0Q2Q0kyODFDTGVsQ0U2N0VGS09nQmpW?=
 =?utf-8?B?dTc4Ty9mL1JaeUU0STFFazY0eDhZR0tCK1hrZ3dVbVc5Qk11dXJpS0w3QWty?=
 =?utf-8?B?WFlSa1kyQzU5UXNraU12UEMyTW85Tk1zOThIUnNVTmkxN1RTZ2FoT1lXOWZt?=
 =?utf-8?B?R3RzdTZSalE5YVlWcEZWekdEY2NlcTR5QTlTNjZ0SkRXUTJVMGlHYUgzbkgr?=
 =?utf-8?B?REVLaWFPUUduQ1M3RmxjalAvNGVPdEVoaUxOQ250Vm01ck93VENXNHF2bGlP?=
 =?utf-8?B?bngzRzJSQlZleVVkblVtZUtSN0M0ZVVCL05LeVA1SGFzajNIU3o4S2RnSTB6?=
 =?utf-8?B?TlYwUHF5R2hqTE5SZU56cmtXRlZBUlZEeUdzVDRrRi9HZm8xTW1Zcnpzb1Fw?=
 =?utf-8?B?cTFkZ0RsZTZ2K3M1QmdpRkUrZmFnTmlzVjRDZVlYNExIVlhyb1dxTlo4YXhx?=
 =?utf-8?B?NnVva2RhUHRTMXRNdW5jU2V2bjdHaTRQTkRURDQwYkxyQjV5S0VYdWlhdEFS?=
 =?utf-8?B?WER2Z2pFZG44a0ZOUUY4c3h5a1lvN3JWaUkrODVVVzVGNk9rdVBBNzlLRE15?=
 =?utf-8?B?d2JnOXhKS3pMV2pOSlBnRGJ1M0xRcS9pTDcySHZFSXliR0xBKzdpa1ZhYTVu?=
 =?utf-8?B?SllaRVVoRFd6d3dac1JtOGM3TWhSVks4OGNienNBcDZ2RFFGNHhWWmdKQWgz?=
 =?utf-8?B?NEFEZEtGOU9KbmM5ZCtRM0M4MWhNcWdVVHIwYjNOWGUyVkYwSWo2d1Zjd09L?=
 =?utf-8?B?eFQ1eWtYL3g1dHIrNzFIK2RFRTkyQnhUYzJGY2k5MC9VZEVUcjRHanlDbjE1?=
 =?utf-8?B?dldscDlYMndBNzQvalJUdEN5UFYrNlNDVldUcW40d0JFRjRGYXFTVVdXQ1hV?=
 =?utf-8?B?QjBFY3lQV1c0S3FocUFCUzgyeW1YSUFrOUxlTC9OaGNTMWJuZ1ZjMFI5SWNB?=
 =?utf-8?Q?hL5h9EajGGM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF5ADB4ADFC.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDNieGxGeWlKdEljZ1B5em5KWHdmeDBmdVZoOTNwS3l0QndMajMvWFdjZzNT?=
 =?utf-8?B?dFRFMnFWNE45bnh6UnI5R3ZtRzE0NHZtVEN4QUhvOEtrVVBQMzlDUzJUdDRs?=
 =?utf-8?B?ZzhuUStBS0xFYmlnSGhkckg3TDBpVUUwcEc3dVVYUGFQV3hZUFg3NjZNRVM1?=
 =?utf-8?B?VjNoQ1hPRlBoU3d2RTVoSWVsRytKN2xrbjltOWpjTExqTkpkaERSQi9jem9E?=
 =?utf-8?B?eG9LcXlGUThYVlV6Rm5XOGcrWUxyQXUyaUhkSTg5TG5rc3hHeXpGRkVETU94?=
 =?utf-8?B?OVp6bFVDOTRPeERxTis3Z2MzWjB3Z2RaZlR3MEFjZlQwR3plUkg0aFg3U0Y3?=
 =?utf-8?B?T3EraW5RTDNmczlDbklRVy9BTFNjUlZqSndTTVhpSG90WUVCU2NwM3RyL1BM?=
 =?utf-8?B?UG5IT0IrRFNsVnc2Y1d2Z2J1bUwzekpEc3p3MjVIMTU4cVpURExVak9DRHZh?=
 =?utf-8?B?MFF2Y3JXWlBhQ2VzdTJJeHh6dksvWlJGQ2wyS0RPN0V2OC9UbGQzcnowWXQ1?=
 =?utf-8?B?RlNuWERlSlVmbjFTbnpSQVBOVFNhdk9nMHdyK1F0SGo5NHorWGpYUm1meGV4?=
 =?utf-8?B?K2V3YmF1TkJXdzg0d25Od2V0bXRpZ0ZYbHhvc0lGK0RhUktDQlVuWUZnTU1E?=
 =?utf-8?B?RVp3bnRVZzFsdXQ2dS85d0puMGc3M05UcklRTWNiZEZzemNyeW5GaTZxVFdU?=
 =?utf-8?B?ZTVUYVJjaFhxUjR1UUpNK3VpbDQvblZGN3NndWlWdWI2N2VMNGNxOUNGNTYr?=
 =?utf-8?B?OCtCRmJteDd3d3NrZHl5UEMrZmhLa1JHaFFOUkJYZCs3Z2xQblJOUWk1MnhW?=
 =?utf-8?B?dXl3SkZHdFlBYS9Cb3k4Vks1YUhTbitzZDY5alROa0tPZzNwd1FHOFhQTzBr?=
 =?utf-8?B?NWZyWmMxQVZwMVcxN05aeU9LT3h5TWNaMHFzRCttKytCQU83bU82UW8rUVFu?=
 =?utf-8?B?L2JnYzlkY3pvWjFzWkppakJFN0RLR3BUTlNtcll0c1RqVDBWUE4zbEpBWWMy?=
 =?utf-8?B?cU94YWtKTG9TVTNzeWp6a2FkVGJXTndDRFdOR1NyZzdLdHZLVXF4Wms5cnhj?=
 =?utf-8?B?aVRObzJIbUhJNFdYUFEzRENUYXl0cjYrOGNTQXBibThSdHlNd3dhajNTY1ov?=
 =?utf-8?B?cHFFRGxlWHlmRjRVSEJyMWc3dHlIb2kzR2U5L1BRZlJCaEpWTDZlMkJjM2l3?=
 =?utf-8?B?MGRRLzFDN2EwRmp4S3lwOFRSUDM4RjJxa0Qyc09LR3hjUTVsYTNOVXlUV0t2?=
 =?utf-8?B?ODZzdUN5YkY0VTVROW03YU9ja3FlRHRnZFBNbk9OTitWRVVsdGZtQVpqNkQ4?=
 =?utf-8?B?YmgvOEdpaXlUNis4dXhETnFMY1BCVmFyZFhTWDQ4NUtNMDdicHhnT1lzN1hH?=
 =?utf-8?B?d1l6bFpyTUwvcUlTMVBobXBzbm5OakplQWtFK2JZL2xXMjJRR3dtTm5GUTFh?=
 =?utf-8?B?SVlSTVB2YVJvR2taQm0yWkd1NkJIY1prQXQxWC9PK2c1RWNrVXVTa3dvei96?=
 =?utf-8?B?OEpxaDJscjRRc2liUTBzcy9nRTkwdGZzcVFUenc3UElqQ1p2ZzduTnhzdXlH?=
 =?utf-8?B?R29vWndGWEZYSVViYnhZd1FRQXV1OHc3VVJReUtwOFlkV0E2bjJuTXpOSmNw?=
 =?utf-8?B?ek5kSkJCcVJBWjJXU2tRMWJWdXVYTWY3bExLUzJheHlGT2ZrMnhzeHQvaU8v?=
 =?utf-8?B?SmdScElGYXViYTI5YWxnNW5JSVZ3a2pBMEJwa0tlNzg5Z2NIRXZTWXRjOEM4?=
 =?utf-8?B?VUVOOHZVdThyZnNmK2dTaE1OWmtYTWlqWG1Fam9WZ0FzUUJGaUJjVVk0OU9p?=
 =?utf-8?B?a1dqaDdGcHlYbVQrLzlmczRvV3F4MHAzVXdGZG5RcFdIeTd1SXpUc0pyRmNI?=
 =?utf-8?B?YmNyVktpZmtvM3hodnRzMHM3bVBwd0xkQ0NucFJ1L2MrektjZ2hRc0dQSGRM?=
 =?utf-8?B?SmVEbkh3eXhQWmFuNnRPU0I2REZuSW42Vzl6ckUrVXdZVERWRGtWYVE4NDlI?=
 =?utf-8?B?ZkMvREdJczVjL05Wck9HMUNGNlNaYjF2ZjJ5NGRLT1Q0NmtwSGJadEdyVVpW?=
 =?utf-8?B?R2MxS2cvQ1d1WXFHc3pHbTU3M1g2N3J6L2dpZWZYOUR0Y3R4ZVVXR1d6UFIz?=
 =?utf-8?Q?1jCa3XbUyWRneRsiemdbiDYlF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A4ABOB/Q+EKnT0aUp7O6INgg1zSMi5wOXAPzsv/mmQBHLLNNK2HA5QM3S3q8pdBJkfDoOpH149FTEuHQuzIvlQYTcYxmHs/kt0ZAhv6TAXGFrsPke7GpaGnPZO/aIq2FqQnJOjvVJyXy/mtWJi71lHA72V/gd5sUWKGuwDxB2G4D3KbGRSU0vec9F09MySo5ZwUOTQaO3UnVY01qVAReO5gAhkl8AkP9tgNti/lC2FgGiNF+aK/r1HvZD3T3x2bUJUmPnmtUfaYGCiZdfiLii3i/bJXzpWqXptIMB9cmIPfjOotJThF0E6ZXaLX6oWWV2/OmrUBKXmwSpaRIFbqtiT4jQcgBkJ61jKeD6Da16NnCxrDt3Cp0zSl3SGPVLpGpUrzWITruulHCvMBl5rjxm1ujBUilINVSMjL/paBn6DRGEb1Am9kiO0hzuj6J0nVoc4xiQeW5PsfeHNWBuq2nZsPBn2H44Cpg7IY+3RzH7NWJPWA4F3GBkQLJw+myi/NlSetQTAEqd+K2CV5hGWb7Zkk6wFy2OujTwZGtJ4ZNzn02YP+kMGFYbDhmCTLizpNkhGSil6KCHauNGCKYbT7BWmHJu+ZSKAmcTNm5tymT0HY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3607cf98-26a6-4942-5cfc-08dd887dd543
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 07:00:18.9197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixKYG4N1/aDqRyijiXGFVpA3R448oj0fX3h3jsPhASBXeBXmwfbRMB8HXwCPSISNk7gRR93Co+1ck94F8qq7Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7826
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505010051
X-Proofpoint-GUID: UgEapqtfWXPN8JIGsP0929FKxX3TYipD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDA1MSBTYWx0ZWRfX8dRibJ8XmHs2 GzGiyKcZbiIRisJ38E8ciw4R/OkxbV3WzeuSH+HW8HL4uyEOqPTzg79a31h0eGitME/cHbPTJfM TqXhxtuHVhYLdPzDpzzOm/DwU2c4z2sd3J4C4pNmSwZSvXEGWjoyEkjoUGfY21WiEVE7ZOCPz01
 m9ASxgt9IzmFVbG/QhqSuXhCF+l+rE6ZZnSXjFy121VnQAJEwZL5StAJxE3xHZ0/4SX3K9uQvX9 QTPbynN+55StcPIeDbqTondAjOe2L/g12LugijY0Didzta9c40WSjA6Sba7UBtpzsmVUd//BkrJ iX6CQPfkwupJqQtOD0A9xi/y4L0IZmszvPAYDlwfVP24fAGPeI/9RCzvynrmRxWJfk2obLWn3VQ
 dqVkc0Boh0UuF4H7tWfujvVrsQNmjN+upqL3QkawXhARg0Dag4tkceVtsHBGfCEsI4JSOXWc
X-Authority-Analysis: v=2.4 cv=ZuHtK87G c=1 sm=1 tr=0 ts=68131c08 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=zd2uoN0lAAAA:8 a=VnNF1IyMAAAA:8 a=JfrnYn6hAAAA:8 a=QyXUC8HyAAAA:8 a=0HtfRG4N_MvV5BcoYjgA:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: UgEapqtfWXPN8JIGsP0929FKxX3TYipD

Hi Chen Yu

On 4/30/25 03:36, Chen Yu wrote:
> On systems with NUMA balancing enabled, it is found that tracking
> the task activities due to NUMA balancing is helpful. NUMA balancing
> has two mechanisms for task migration: one is to migrate the task to
> an idle CPU in its preferred node, the other is to swap tasks on
> different nodes if they are on each other's preferred node.
> 
> The kernel already has NUMA page migration statistics in
> /sys/fs/cgroup/mytest/memory.stat and /proc/{PID}/sched,
> but does not have statistics for task migration/swap.
> Add the task migration and swap count accordingly.
> 
> The following two new fields:
> 
> numa_task_migrated
> numa_task_swapped
> 
> will be displayed in both
> /sys/fs/cgroup/{GROUP}/memory.stat and /proc/{PID}/sched
> 

Both stats show up in expected places, but I notice they are also in
/proc/vmstat and are always 0. 

I think you may have to add count_vm_numa_event() in migrate_task_to()
and __migrate_swap_task() unless there is a way to not show both stats
in /proc/vmstat.


> Introducing both pertask and permemcg NUMA balancing statistics helps
> to quickly evaluate the performance and resource usage of the target
> workload. For example, the user can first identify the container which
> has high NUMA balance activity and then narrow down to a specific task
> within that group, and tune the memory policy of that task.
> In summary, it is plausible to iterate the /proc/$pid/sched to find the
> offending task, but the introduction of per memcg tasks' Numa balancing
> aggregated  activity can further help users identify the task in a
> divide-and-conquer way.
> 
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v2->v3:
> Remove unnecessary p->mm check because kernel threads are
> not supported by Numa Balancing. (Libo Chen)
> v1->v2:
> Update the Documentation/admin-guide/cgroup-v2.rst. (Michal)
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 6 ++++++
>  include/linux/sched.h                   | 4 ++++
>  include/linux/vm_event_item.h           | 2 ++
>  kernel/sched/core.c                     | 7 +++++--
>  kernel/sched/debug.c                    | 4 ++++
>  mm/memcontrol.c                         | 2 ++
>  mm/vmstat.c                             | 2 ++
>  7 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 1a16ce68a4d7..d346f3235945 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1670,6 +1670,12 @@ The following nested keys are defined.
>  	  numa_hint_faults (npn)
>  		Number of NUMA hinting faults.
>  
> +	  numa_task_migrated (npn)
> +		Number of task migration by NUMA balancing.
> +
> +	  numa_task_swapped (npn)
> +		Number of task swap by NUMA balancing.
> +
>  	  pgdemote_kswapd
>  		Number of pages demoted by kswapd.
>  
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index f96ac1982893..1c50e30b5c01 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -549,6 +549,10 @@ struct sched_statistics {
>  	u64				nr_failed_migrations_running;
>  	u64				nr_failed_migrations_hot;
>  	u64				nr_forced_migrations;
> +#ifdef CONFIG_NUMA_BALANCING
> +	u64				numa_task_migrated;
> +	u64				numa_task_swapped;
> +#endif
>  

This one is more of personal preference. I understand they show up only if
you turn on schedstats, but will it be better to put them in sched_show_numa()
so they will be printed out next to other numa stats such as numa_pages_migrated?

@@ -1153,6 +1153,10 @@ static void sched_show_numa(struct task_struct *p, struct seq_file *m)
        if (p->mm)
                P(mm->numa_scan_seq);

+       if (schedstat_enabled()) {
+               P_SCHEDSTAT(numa_task_migrated);
+               P_SCHEDSTAT(numa_task_swapped);
+       }
        P(numa_pages_migrated);
        P(numa_preferred_nid);
        P(total_numa_faults);


Thanks,
Libo
>  	u64				nr_wakeups;
>  	u64				nr_wakeups_sync;
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index 9e15a088ba38..91a3ce9a2687 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -66,6 +66,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  		NUMA_HINT_FAULTS,
>  		NUMA_HINT_FAULTS_LOCAL,
>  		NUMA_PAGE_MIGRATE,
> +		NUMA_TASK_MIGRATE,
> +		NUMA_TASK_SWAP,
>  #endif
>  #ifdef CONFIG_MIGRATION
>  		PGMIGRATE_SUCCESS, PGMIGRATE_FAIL,
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c81cf642dba0..25a92f2abda4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3352,6 +3352,9 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
>  #ifdef CONFIG_NUMA_BALANCING
>  static void __migrate_swap_task(struct task_struct *p, int cpu)
>  {
> +	__schedstat_inc(p->stats.numa_task_swapped);
> +	count_memcg_events_mm(p->mm, NUMA_TASK_SWAP, 1);
> +
>  	if (task_on_rq_queued(p)) {
>  		struct rq *src_rq, *dst_rq;
>  		struct rq_flags srf, drf;
> @@ -7953,8 +7956,8 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
>  	if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
>  		return -EINVAL;
>  
> -	/* TODO: This is not properly updating schedstats */
> -
> +	__schedstat_inc(p->stats.numa_task_migrated);
> +	count_memcg_events_mm(p->mm, NUMA_TASK_MIGRATE, 1);
>  	trace_sched_move_numa(p, curr_cpu, target_cpu);
>  	return stop_one_cpu(curr_cpu, migration_cpu_stop, &arg);
>  }
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 56ae54e0ce6a..f971c2af7912 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -1206,6 +1206,10 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>  		P_SCHEDSTAT(nr_failed_migrations_running);
>  		P_SCHEDSTAT(nr_failed_migrations_hot);
>  		P_SCHEDSTAT(nr_forced_migrations);
> +#ifdef CONFIG_NUMA_BALANCING
> +		P_SCHEDSTAT(numa_task_migrated);
> +		P_SCHEDSTAT(numa_task_swapped);
> +#endif
>  		P_SCHEDSTAT(nr_wakeups);
>  		P_SCHEDSTAT(nr_wakeups_sync);
>  		P_SCHEDSTAT(nr_wakeups_migrate);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c96c1f2b9cf5..cdaab8a957f3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -463,6 +463,8 @@ static const unsigned int memcg_vm_event_stat[] = {
>  	NUMA_PAGE_MIGRATE,
>  	NUMA_PTE_UPDATES,
>  	NUMA_HINT_FAULTS,
> +	NUMA_TASK_MIGRATE,
> +	NUMA_TASK_SWAP,
>  #endif
>  };
>  
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 4c268ce39ff2..ed08bb384ae4 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1347,6 +1347,8 @@ const char * const vmstat_text[] = {
>  	"numa_hint_faults",
>  	"numa_hint_faults_local",
>  	"numa_pages_migrated",
> +	"numa_task_migrated",
> +	"numa_task_swapped",
>  #endif
>  #ifdef CONFIG_MIGRATION
>  	"pgmigrate_success",


