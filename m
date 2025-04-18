Return-Path: <cgroups+bounces-7638-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D075EA933AD
	for <lists+cgroups@lfdr.de>; Fri, 18 Apr 2025 09:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586E21B606B7
	for <lists+cgroups@lfdr.de>; Fri, 18 Apr 2025 07:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC89268FE9;
	Fri, 18 Apr 2025 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="clKylB/e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aPXdGCXW"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5FB320F;
	Fri, 18 Apr 2025 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744962446; cv=fail; b=MPwKX5rLabqiiqCFnJIH8N2MaFDnooSCVSSTqZshC/lYqkvVuHKzjVMdtXTHLiokQDqCRX33mOcql8PiK1ZM+C8DFwvkVca5OD/Nf64vl/VDqu4t+DFjxxdf9JrY7qx2u0O/GY5Fd+aN3KU8t6us6d4lQZk4pN2l820BupNn6g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744962446; c=relaxed/simple;
	bh=pKGutVLWki4/vqGeIlggaDOX++iEKNyXbW3TRZfKnQA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aPqUO1w0pTYmEOOQ7eVdhglKpwjwBAYZCr/WL93YC+iHDjURkKURWScRcMQU/cZ+exb5Rz8InY7W8X6p5WmUIVbjz1Nzdykk73dT3wLQxZbt6J4GDsk8Sl8On/aYv7v2EBH5fyFhM9pgoOaFcAcKFbW6TM1kaHnVp+betjh2zJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=clKylB/e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aPXdGCXW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I5tt4p015102;
	Fri, 18 Apr 2025 07:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2O3zbZmoIZJocXx3xThw5ozlsRRTnyPIog/LA/5h7Cw=; b=
	clKylB/eA+x71HXA9suW/DGZ2gMFDES4IpRkOyXFALlaP5hrp6ulwkcKs+ZWMty5
	oMI8cVogF/vlnjp/3+ABH/bKWCiRVgWznjPpvlvHGqgrx88C32WNtPuuSEOLVsMe
	ysWUPs5nKj69jeFPd4KrfeWMdW8QVn5qJVcdi6cfEIM/73+rUhIX74wn/uTnLvso
	dgrQEnaSrcK3w3m5nr7Ps9EHrhdEoY8/NqgKdgj7Roevd/MTX2MkNmD8VVKcBaxU
	hDG0E2gb6L/gHJeLqLuGkuzpwHG++zZ61QKKe3WPCRR01T54VgDOkc/ozK755F4j
	toPRA6nmAgYI9nBCAZ6x3w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 461944fkwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Apr 2025 07:47:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53I7c1MQ031024;
	Fri, 18 Apr 2025 07:47:14 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010003.outbound.protection.outlook.com [40.93.20.3])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460dbevfa6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Apr 2025 07:47:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzEodrVggu6RK/FSHp28uzHiv04bRcePQN/HOCf1q2PZphJLTlC650obFlwqzcr/mJCGbhMm0yOsQC0Z/ZbYAYqou+CU+UTvl0t/9ke11HeC2GGsCzSFIvpNN10TgDI6gOTjFiQ1dJtWstIXpriDG0GlbMoAeCAqOZM1vDg+OjNslpnEDSAH99ZOUmCmpR4vz2DxRgkQ8RrAICJw6C8FopWjAIgpJasi1A1myc598QuWhg8wMEMvpfYfysdsGr8nmIY+HMs6ovr4x9bXyXoYj33m+eVccu/h1mClufmkLHqVIio90mkcqsXY0D5GK5o4XyJWVAfGdCMzQAuuxIW0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2O3zbZmoIZJocXx3xThw5ozlsRRTnyPIog/LA/5h7Cw=;
 b=xiXf5sfvn/fLPd9yXfk2uEeHTF+vv3uu2wLJjm/ILTDtYKl7xek+nfqmAi8ozjIO6FC4UarkDtoDYPMfTLQ4fYeGJ9NecdQBCqfGXAur+Uuipdr6q3EzNDuxyWO48mKqgJcDIaWRhy42kxqZfgf/+4FzHgCGkXmQmP0dC3oSv9kCIsSZJqsqcz8d1PMVv6wK4LR1BeArUbpyvwrQh9wU35L9I8JCX1nTZzarWZjWDVohyIp6sR6/fW8+835LBq+24LIxQ6Zez0DUCKfyH+xL1f3wn+y9q9qsq7W9yrvjoc3WruNntjJl8ePZ3AJAzWmBOAny7tNdG+pYTO7h7ZhCIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2O3zbZmoIZJocXx3xThw5ozlsRRTnyPIog/LA/5h7Cw=;
 b=aPXdGCXW+YuXU8MVohw1Xn1Lbmr7zOt7rBJlX8JVD3LKowSnVGum3RVP4y4ZWOc5K7d/GJBvAtBOcpIkXKVJ6PaG13qnawA2IvxsnUJvcU7m0p8fCn0dC3uSQWqqHM8Mb4AsvfOX9G/OEjD3yfeJjIaPynWVYe8U46h2ozMCr7k=
Received: from PH8PR10MB6387.namprd10.prod.outlook.com (2603:10b6:510:1c2::17)
 by DS7PR10MB5053.namprd10.prod.outlook.com (2603:10b6:5:3a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 07:47:11 +0000
Received: from PH8PR10MB6387.namprd10.prod.outlook.com
 ([fe80::f218:31a2:a748:3c21]) by PH8PR10MB6387.namprd10.prod.outlook.com
 ([fe80::f218:31a2:a748:3c21%4]) with mapi id 15.20.8632.035; Fri, 18 Apr 2025
 07:47:11 +0000
Message-ID: <af289b54-de43-4d7c-bf74-926abfad7808@oracle.com>
Date: Fri, 18 Apr 2025 13:17:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup: Fix compilation issue due to cgroup_mutex not
 being exported
To: gaoxu <gaoxu2@honor.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "surenb@google.com" <surenb@google.com>,
        yipengxiang <yipengxiang@honor.com>
References: <5df9200f0e7c4bc586af76e21b380f67@honor.com>
Content-Language: en-US
From: Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <5df9200f0e7c4bc586af76e21b380f67@honor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::10) To PH8PR10MB6387.namprd10.prod.outlook.com
 (2603:10b6:510:1c2::17)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6387:EE_|DS7PR10MB5053:EE_
X-MS-Office365-Filtering-Correlation-Id: b727c3bf-e2ad-45fb-73c1-08dd7e4d3a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NllpZWREUDUyZ0YzT1h1UzhKdHUwRG5TTU5Pb2dYdzhRUmIyTXYxQTdVemEv?=
 =?utf-8?B?U3ozbm5ZWnVMZkVOa2ZDRXVUV1hJcnFINmMzRU1ESjhDaW9TcVc3cEd0N2Fo?=
 =?utf-8?B?bUc5Z3NwRXFCWTNReDYybkdxeGtBN1c0Yk00ZzNjQWIxc0FpUmxrQ205QmtP?=
 =?utf-8?B?RG96d3JUUHhtUXhIdWZZOUY3SG5EbmZyZGNwb3M5WFErV3RGcXFoVURIK1F4?=
 =?utf-8?B?VHBMaGxKSGhWRlQ2RmV5WWRBMjZ0bXJRdWVLSFhLK2t4Q21hZTFIakZ3N3RC?=
 =?utf-8?B?aGdIemdvM3FKRFkxckkvODV3dUhweXUzc1NwVVp6bUlGelBjR015c3FYVTdH?=
 =?utf-8?B?K2FjeVFnWUtBdmFwSWdacjg0VGFQdWYyR1lNQUtmU3FSUDh4andSWWhFdHVl?=
 =?utf-8?B?N2Y4N3c2eDYyRkhzUGVWdy84ZWJNT0RLdUd6VnVRc2ZacDgvVEJkaUhvdG0r?=
 =?utf-8?B?dkpZWFU0ZzdaZVkzbTJ5a1VVOWFEellHUndjM2UzQ0VocWJTTVViQXhlNXJy?=
 =?utf-8?B?TThLbTVZUi96Y3ZtOXQ2NGlweGlQZTdnV0hpK0lTSlp3N2dhbHhsMzZ6c3pP?=
 =?utf-8?B?eU4wSHZ4MHFRUGh2NmtBUGFQai9HTlJPWlFoNVZyQVZqTXljMzAvdTVORURr?=
 =?utf-8?B?eGFZWE5sRDUvalFsOEdCdU5iQ2ZWV01pNlhHR3ppU0xNdGpScmFCSURsUGhL?=
 =?utf-8?B?aitKQnpvY0ZUd3FBNnhrY29OUndmSDZBdFd5L3FFN0FrSE5weElzS1BpUGJT?=
 =?utf-8?B?bng2aXpOL3Q0QjkvTmU3Y1NoMEVmRlE0V0JzMDQwYzFDR0RkeWRRYzlKeHpL?=
 =?utf-8?B?Nk9IYzArTUdOS05uNlNHNzNvbExObGhOLzd4SnNPWCtBSjVBT3JyRHFvZ0U1?=
 =?utf-8?B?bEk3NnFQZ0tTc2VOUGhVY1B6NHM1V3pSZXR4UjJBMm85ck1kd3ZkVnZZZHQx?=
 =?utf-8?B?Q25KSnF4eGw2VVQ1SkZpcEo5SmR5VkdYREd6Z21zakgyelkvbWRVT05kblg3?=
 =?utf-8?B?eE5sbWhMVDZiVnhBanF3MTF0Tlc5cUpGTytIdVRUUDZQN2FZaHFmWDV6SDBW?=
 =?utf-8?B?eEZtY1BqYVR1Y0RIL3l3S0ppQ0ZTd2pSalAwYzFta20ydmo2LzZoYzg3bE0v?=
 =?utf-8?B?aGVXcTJTRll0WlhyRVE0TkxCOXVncGk3cEc0V2NCVk5FL3RtMGZBRVQ1WnN4?=
 =?utf-8?B?TEl0WmZiNXBaaGJQMGxBb1NLWE11RldzSHp2NW10NUh2L0QwVWF5MjdhT3FF?=
 =?utf-8?B?eHl2WWpOdE1GSnBPY09sMFZ4ZmJRT1lFUW01TjIxNlNEOHd0WnJLZjVjZlNk?=
 =?utf-8?B?Ung2T0JkTjN5eGg0OWJnVVRsV3laMnNnUDhKY21jMUwxang2S0FoeEZ3OXZ5?=
 =?utf-8?B?cUxmRlAvYmx5bHNmZHlyNnpOWDBlZzJwS2NWN0x3MXBONDVXM3BOalhVZWVx?=
 =?utf-8?B?Q2JYdW1wYmhqOW9IZS93UDY4RXU0Z1FpWXhFMTVCaWxEeXJhT1lTeE5WK2ho?=
 =?utf-8?B?cU9MbzRYZ2hGK0l5aVE0UDNjWnJkSnUzK25YNjhNSjdVUkVRYTQwdGdyNmdx?=
 =?utf-8?B?VUFIZzBQYlkvdndoWVArdEtHeFhBc1dTYUxLUjJEaFFNK3JXbFNtZEcwSGpC?=
 =?utf-8?B?L0FjQVA5WDFjNjVjTE4zNW0yaENRS1RUNjZWYmtONkhxbW43WU5HRDNvL2Rv?=
 =?utf-8?B?YVZ6Q1hzUUwreVZabXYvNHdEbDBTcEVuRkdiNGZ4RVFlLzROUHp5empUaity?=
 =?utf-8?B?RER4elViMTBraFBJOUxWNlZRaVcvOSswSk43QmNqL01INmlqQjNXTEluQ1hs?=
 =?utf-8?B?ZmZ3K1R3cm83NTRiT1ZWeVhDUlBqbnI1M3luZEdlSjExck9hUGFzT0ozaUg3?=
 =?utf-8?B?RDhuN28zVnJJZ0luSUxGWDJUMjFRS3d0WGRkcHV6bGVycTIvOENRR2c2azJT?=
 =?utf-8?Q?CLyhvZOnS2E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6387.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ellWd3NZakhyR1dkeUdKRVBldzRZeXZGNWxCME41SnpqamFDeExScUxVMUZC?=
 =?utf-8?B?bXp4M0s0M2tNWTFtbE4ybDRSYklVQzRQZmlPV3FRVmplNFBQSGhid29RMHVY?=
 =?utf-8?B?ajF1REFtZUwyRnhjaVhsdE9oUjNzb2hqQVV6MWc2ODdTbllHRmdpbXRWRGRX?=
 =?utf-8?B?aGMyRGl4ZDFnRFhlVzJ5UXVjVnB0clVOL1NaRG11Nk1ydVNJQmU4bVBSeXli?=
 =?utf-8?B?ZlBNa1RmRUpqeTZnajBjRzE0SkVNcExwSXRGWnRrbGIzZHRtcFJPOVo4RVFE?=
 =?utf-8?B?aXZRbmcrVWRIcUNuWVpwVWU4VkpWZzhFc3E2bEJlQ3FpTXljdTEvTThad2RN?=
 =?utf-8?B?angycHFIM3habnFSRUtJbEJhWjg5cnBYaUlhbU5KcWZWVTFlVW5oaHBlNjZj?=
 =?utf-8?B?MXp3MUttWk5EM1RrMkZZWjlNTEwvVmJhVXlOa1J6eVVhVlpYbmtRbUJ4QVJj?=
 =?utf-8?B?K1c1eTJRRkJ0MnJvK1piUmNLMTV5Wm5hTzY1Zk5CQWY1M25HaXFnTW11OFd3?=
 =?utf-8?B?bkE3eUJYVmVhNFZLV2s4d0NlNXpmRUFjcllkT3ZsTWpvK0R2VkoyZDJJNHZy?=
 =?utf-8?B?WjhzSnNRZ0czZUtuM253QXlxUXJPbXRVaittcmFDVUZXUnJtaGViejU5VjJS?=
 =?utf-8?B?ZllEV1lzRzB3Y3BTUEtvVHZtSFRpbW9pTStxdWVJa29WY1g4NlVpL1FpMGk2?=
 =?utf-8?B?YldBNVVVTTQydmFlNVMwSlk1Q1BwbW14eG9nS3pOTENNWXlvWTNOVURyc053?=
 =?utf-8?B?Y3NBZGtlcXEvbE8rNThLZkx2dmJVbnZpK0JPUHhZRzJWT1BHb04wMkFKb1Z4?=
 =?utf-8?B?bnRtd240SEtHRGZCYU5aSXI3RHRwbTRpY0tkaWFOc2VXbU5jUVJ0L0VBQ05V?=
 =?utf-8?B?TDdHcUliZVc5aDZwdU5yZVcrQ0hoVEhTN3R4UjNmTkRLUGxSMGRWdXpBUkM4?=
 =?utf-8?B?SnlNZWRUSEFNcC8yUmhEM0tGa050QUM5YWpRbmJBUDhmeHM4Y0ZoTEEwN0xB?=
 =?utf-8?B?UFFkLzlwM29HUDVyYmpuZ2xDVWtWaWVPcXRwaEJtcU9yTkZuYlRxNEg4bzl6?=
 =?utf-8?B?UmRhRVpUQzlnVFRZUmlGT2xWdkg0dkYySnNValY1Mll3MkZRUER5MHVEMk9o?=
 =?utf-8?B?dDMvTms3Y0Z0RW1rSnBZSC93N0RuVzhNSXhIanUrTmswYWg4Y2hESFZSRTZB?=
 =?utf-8?B?ZnN2dWwxRDNaKytlTHptS0thOEI4WE4wWGhsYzM0VDZiakJxakJnTmJ2QXl1?=
 =?utf-8?B?WE5oU0NxSnY4YXprWnJPbzJMODhab09aNDUyaUR6YkVCN3pEcjFXK01ibDJW?=
 =?utf-8?B?c0NPWXVKNWp1MzRGajk1aVZKdFcrY3F0S2tLRFMrdC9xdHRndGNJdEJKZFFm?=
 =?utf-8?B?NDhEemhHaXpXSHFVZ3lCSEdkMnAvTlM1aVowa3dZdCsyYnQ0V1pSQW90OG5l?=
 =?utf-8?B?K1hzU2g4am1wZ3grUmdGSHFtRjdxSjhuenhsaiszdUNRRXBaRXpySlpKRzlp?=
 =?utf-8?B?T0dRcEcrZGtOT3NIVFJBREdVWlVzNzBIYUxRUDUzNUJlYWJlbTR1c1ZUU3ha?=
 =?utf-8?B?T3FLcDJVaHloWXZ0c0hkZmh4bkJCNkJhcHVZYzJldFdMZzA0Z0MwVHp1WDFh?=
 =?utf-8?B?Tzl3dDdYWUlqdStmbWVYcHZwcmw5WGlMNUZTRjhXY1RkNVZxTEYxMk0weElC?=
 =?utf-8?B?TktucG9UTUFzK285UUlVeFZYZ2IvTUhMVlFlY000WXByYjVDNmorTUtsNHZv?=
 =?utf-8?B?MndpVzFFVzJqdGxENTY0djlPZ3pUVDgxNjJ3K0t3Z0RqSU43cGorbzgrQk1O?=
 =?utf-8?B?UHlwaFJHcjI2MkVLbE5tcTB0MjBLczZYM0xPem14WEUwVEhXd1JCMnNtTkVL?=
 =?utf-8?B?MkdRb0FaMlZZTUg2S2V5QTRtLzkwRVltS2w3VnBzdHBXZzZtT1ZoMHE3NEsw?=
 =?utf-8?B?bkpRZncxR3J3OTJ1OEUwMDhTUTJ6SGRZWkduVG9zSGQzMkJlRzIxTE5Tdkxu?=
 =?utf-8?B?cE56dzFlN0wyRVpJOEd3WkhDcVdtZGNRbk9rZkNGRFJrc1U3WUZHK3ZjYnJ0?=
 =?utf-8?B?NUZka0Mzdk9MTkZNWlRNZHVZOVdKTUlpVktTVHFsa012QTJoOWN5UklWSjcw?=
 =?utf-8?B?SDlWNmc2ZUNiL1ZmeEdxVm9lSDJsVnhFZFhIQm45byt3Skx3RXZ4WTEwc1gy?=
 =?utf-8?B?Y3hvTjhkUjNxWTY3WlJVTU9aR1JKVEtZRjJ5Yk1jelZYaUd6bzVQZ3B3VnB1?=
 =?utf-8?B?aDR5OG1LRkRWRm9CMmtPWEp1TU9nPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uhVUOpR0fxzpH8FMWBx4UFUdsqWC4AIlmr9b8/zfijexqAz+XaNAcpJFI7r1Kz7JkGp1sbRMP1zg/zvxNqfEqg68X04a3VGkCfaNcapOufm7KcrT6sYfS37QwGHWP+aT3ArmFOC5F3vjHrt0vgLlQDRe4BNYhNN28z5PWijFJN2pL+xNJLhUuLwDrdNdSawcrqeZnJ53RZ1isYntCurR5UCTyIwsyAlLPQkaVF1R3Kq8ZEpLdwK8NzcoSl9oegzJo+b9Ad7P9JKOTyfZ8ylgp92jEpNHA1LR/D1ZC2Rgjf8sFdqK7mn60Ke2QKNRuy4U/kVkwjrnEe7Vc90f1z6c1khwd0xkpExUBKGpCr1YKNq5mlbcNTrhk7O5MNlY+dN4+QZdOicJhr1tYxSZCCMK/S67ZyNSFPWC4srvDsPcr7sHbVTvJvysVrpBMGmD4n52B70KFPRfypqB4zmpkfx/t6BLbm/5UJxXM1vTuAfzcT/XR5QCfmyF082lda7p5VKB8Z3XJpOng+MCVpCOGY+bfDOq4Qb94RYJYwOCN6ihUxknHvgNsvBuJzPGI3hbVfxEDFAWnyyiutTKMXWdVZ6wsTjkoNa1tYio9ToICEquSVY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b727c3bf-e2ad-45fb-73c1-08dd7e4d3a3b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6387.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 07:47:11.4830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CVKG+jAioigDnAKOBu2efCrjRISoH4XKotAJcd6iIe+60+7GwmRceE/EQxEamWXaiVwm/KzB/urD255uvLWan8LhY64RgALE1NTAODzvvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5053
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_02,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504180055
X-Proofpoint-GUID: nx85xo04atG03p9du6JpnmniCyineazr
X-Proofpoint-ORIG-GUID: nx85xo04atG03p9du6JpnmniCyineazr

Hi,

On 4/18/25 8:12 AM, gaoxu wrote:

[...]
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 447ac857e..c1bc51058 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -84,13 +84,13 @@
>   * css_set_lock protects task->cgroups pointer, the list of css_set
>   * objects, and the chain of tasks off each css_set.
>   *
> - * These locks are exported if CONFIG_PROVE_RCU so that accessors in
> - * cgroup.h can use them for lockdep annotations.
> + * These locks are exported if CONFIG_PROVE_RCU or CONFIG_LOCKDEP so that
> + * accessors in cgroup.h can use them for lockdep annotations.
>   */

Tejun has already merged the initial version of the patch without
the updated description. You may want to send the description change
as a separate patch, rebased on top of the cgroup/for-next branch.

I've rephrased the description to clarify that lockdep annotations
can occur even without CONFIG_PROVE_RCU. Feel free to use this
version or modify it further:
"Export locks for lockdep annotations. Use CONFIG_PROVE_RCU for
accessors in cgroup.h, and CONFIG_LOCKDEP for accessors that do not
require CONFIG_PROVE_RCU."

-- 
Cheers,
Kamalesh


