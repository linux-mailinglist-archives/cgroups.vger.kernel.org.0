Return-Path: <cgroups+bounces-7873-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66B1A9FDA9
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 01:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13CA9172BB2
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 23:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69354212D8A;
	Mon, 28 Apr 2025 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hwOOy2fg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QPBWRBL6"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA0220299E;
	Mon, 28 Apr 2025 23:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745882429; cv=fail; b=I88Aj8sDQO4tYbwTRfZSE+b7iD9O+z0BHmCG8aD9LRBSgupIHvg350yubnQy01RQwiTjNLMcFEZNmV0iCeTKb9M4OY1OUKI4Lpt4yaOzeaNH6x4qT/JvQjZwKqD3CTfIqJs0/8zNt+V9+8Qvqs8NKW2R9DVMPorINdfM7rhTZ68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745882429; c=relaxed/simple;
	bh=4yTrloA31rwk1n9M1GuPOzfAg4lL3r8s7/+fJKBaJ4A=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SmgWIXrlLdSZte7qfC/+ZQfshyp3S+b3lSW3Ld9gZR51hnnokZ2wHayfH6bkzKdakUumyWuuxj0DOpPEp044c0QkiROEXu5ni7aDNEsIEk0wMAA0q7FShEmn1wXK+SVmuaowi79oyaKYQ6nDBhzIPZEkTtMixYn5DYsNv/0iJbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hwOOy2fg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QPBWRBL6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SNBvXr014584;
	Mon, 28 Apr 2025 23:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1AsNgwn5fjiQ54o9ONiotjD8eP3wI4voaXmpMdA1HYA=; b=
	hwOOy2fg3HLNi66t0RzynD+Kv+OXsyzyfDVH4Cr8VsuPJ/Yjl8nLtQXKahZjMzKP
	QU3RgaGLCadK0sAZcvYvNs1QUtetJeng94NGHrusfvsDltZQyv2yW6TGzZNG0H0g
	rCnteHwqf5zjDVGYc95m/oRYDNL0KHti636JGYPXdxYnQouSWjtkTVxrhz9LKpKQ
	0Y4aF8O1amujHZBQcwQTZVJr4s+ZdYZg1LwzTLaJ3NgQo4yz178SghYwhBQJVAQw
	wEcwEhMcJtzpIjdcYKnNMKwCnUp6+yghsDVAB0AjrXlPLEtpyEbN/CbDbPMULgGX
	HwMJ3tXm9dNSi75btEnC+w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ak4u005m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 23:20:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SMfltx023752;
	Mon, 28 Apr 2025 23:20:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxfav3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 23:20:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvbMXEuJigineVGBIUudz0wxYHBw5SiZRjw9kSBDCHsn1igT0pGwAjHY1yu3XDxqR7kuEn+pyK9R6JPF9s+Ant+9XmEIhKCmW2jK4pfb/vZ6yxkVEBVGvf4W/pILH1lPLlFuuCu/8sTYNowL4hB6yrZJQXPWDfgH3cKjgWa8kl7X0zSVtsdMglj1zZDQ2DFeguBc12M8XhEjFZi3NyFySXGiLcrrRZ5905K6bxSPOuChXjRjdG6zDEn2CxqwYoDVFlnVLVLu7uQBaUdanGrHXD6XX9ghFZ5o6s8+0kzodOLJ+mOT7MQU7WPFSownZ6LOEYrO1mINV/FgJeXAayGAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AsNgwn5fjiQ54o9ONiotjD8eP3wI4voaXmpMdA1HYA=;
 b=pHGAFie3FhbxCWlCEiXkN3jqxiUw1dJhr+kMMYHuhjOMjBhAfWyCC3xmjLeTBhQQNAVrTfGhf9/1JVtya4kZ6MVm/yQ0U3V66M61hQjsd0MF8oQ+i17U52OyVu0LAlbaeQqHC1rMdffnoY0KYrTTpTHaWCcXhL+fbbZAoIMnbDa7HwcHWrKqJy1rSDK61HSSEG4jX0tdqMxg2VfNWYduPOebGfl/SfRXH2q/F0xi6wPU1dj6/n2kf6uUnUw0d9ajR5mR6mgXeHqyq/NnFyRwQRHKbdt3ALCzqgSz06qzkgmrNqzdvSh3FG86CmPCAHvU+FZ194PXGrzEHVg59E5PVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AsNgwn5fjiQ54o9ONiotjD8eP3wI4voaXmpMdA1HYA=;
 b=QPBWRBL6izwAQPfp/LKWh2ss3lWNLwQSFkTERbXy853q/aD7iErof/OQfdeepznAqc4hJ5EhiC6+wTfw7OVIaxBRycnF7Srd1aTZWsg/UKfxP0smflEeyr9IjcGVisNO36mwjvFk+c3bRxzHvMcr62nmGpCkvqjoxmH/PXUYzc8=
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f) by SJ0PR10MB5672.namprd10.prod.outlook.com
 (2603:10b6:a03:3ef::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 23:19:59 +0000
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::2072:7ae5:a89:c52a]) by DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::2072:7ae5:a89:c52a%3]) with mapi id 15.20.8678.033; Mon, 28 Apr 2025
 23:19:58 +0000
Message-ID: <babe4db9-8b58-4d5f-8bf8-0bcda1d07f6e@oracle.com>
Date: Mon, 28 Apr 2025 16:19:56 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH v2] sched/numa: Add statistics of numa balance task
 migration and swap
From: Libo Chen <libo.chen@oracle.com>
To: Chen Yu <yu.c.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Michal Koutny <mkoutny@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>, Chen Yu <yu.chen.surf@foxmail.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250408101444.192519-1-yu.c.chen@intel.com>
 <9b64be76-b5b1-4695-97c2-bd2af777ec71@oracle.com>
Content-Language: en-US
In-Reply-To: <9b64be76-b5b1-4695-97c2-bd2af777ec71@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::12) To DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF5ADB4ADFC:EE_|SJ0PR10MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 14893d06-2c72-40ba-ac55-08dd86ab31a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVhDcFQ5VnkySWh0L0FlMUJSVHZGWTZFYm9VU0ttaUowZ2VkZDVXb2ExVnZs?=
 =?utf-8?B?bXRNMHJHbWR6ZmNWOHJTS2I4WFFSeGJxMDdVRzBTMmdreHdsLzl6QzZ1U2V0?=
 =?utf-8?B?OUtLTE9lNGN2VkxlTERaNGN2MFFwSG9wMDRNeWRVMXluc0p5WVNtU3UxakRq?=
 =?utf-8?B?Njd2YzV2T3B0bk5nTmlxeUhjK3NRdFF2MHpnV1MrclpYY1ZlVnpEYVVKQlo4?=
 =?utf-8?B?OXZDMWdEakdzTTB2ZnpFSTBwNGdmQmR0ZFpycFFUbFNUaXpSdi9WUThDL3JM?=
 =?utf-8?B?Ui9OMGltcWJwMjQxTHJMRFowNUszZ3NtU3hBaFdrcWx4c2ZGNmxaWEVZUHVS?=
 =?utf-8?B?MlZ0VHIycGRnK1FkWHpuK1NWVllKNmJ5Ty9kaEtRTk9idUJ5YmQ0L2s0K2Zh?=
 =?utf-8?B?ZjhrSFMwM3Q5aDFWS0tHdEpZVWQrQytqY3dZbU43TU4xWExyL21tMXExWlVn?=
 =?utf-8?B?RUt5TVRoeGw4TGNvVjQwME56Nk9hMFFjMW9kSkhETituU280SkFKbXRNYUdZ?=
 =?utf-8?B?L3A4M0djY21ta25oaFhIdFZKT1k1YmwvdnBKRDJHTzJnSVRHWUtXalNOd1Rh?=
 =?utf-8?B?YytYKzdtWC92MDNTV1hnL1RuSHJubTVWVWZUR1NZTzFvTkE3Q2RYWXp0eWtm?=
 =?utf-8?B?TVNtZTJMOTAvcGRteGxJRHF1N01XU3BQRU8rOVViSTVMUUFIYlNzdUc4bno0?=
 =?utf-8?B?Q0RpSzdocVUxMk9zeW55R1NlbHFDRllUM0VyRUNBZHJQcHZUTUE5MHRBenE1?=
 =?utf-8?B?VnRCb20zcmsyVmJNYllJMDhrVGZBd3o4aXh5QUY1TlhncjRYK0F0K2pLeVFo?=
 =?utf-8?B?Nm04aStGdXhpZWZtL3ozdzUweTBvNTJmVzlLWEYzeFlIa1FPZFpsdlVKZXl1?=
 =?utf-8?B?VzM0TjVEZzNRRDlRVERQb0lxZmZyMzY2WE5TZW5FT1BaMXBkZjJFME1qaE1t?=
 =?utf-8?B?aEFPTS8wRkZ0dXJoU2w1Vkk3Z0crc2RoV1phUnFVd0MwRzJKVks3WC9XcStz?=
 =?utf-8?B?VkRxKzEvWTVxZEpoYVFnR1pVZ09qODkvbytrOThyY1MxelZGQ0ZldXhRR3Az?=
 =?utf-8?B?Tkg3V1FoeXV0NFR2bkd2YjBDMGdud3h1K3FYQ2dFaGVkUlJyd0U4NzIwS1M4?=
 =?utf-8?B?UWJDVkd3WG1qb0xTbjlCNU1jZ3UvWVpodi9LYzRzMGRzUHhLbkk4M3loS3lx?=
 =?utf-8?B?VGM4VVd5QzNTVjJtTVJJZUlMZUxzcG5ZWElPRnZacWJFQklYWmpVNnlMbmpj?=
 =?utf-8?B?b25ETjdWRDZPcDc4VDJ6OVpvZGs1YjgzcW9xY096cHIxNmVPU1FYMUx5dElv?=
 =?utf-8?B?N1cxcFdWajF2ZjVDVDdKWDdtb2JyUDNHUkZvTmhyQ0ErMjZKQkpFMmYrckQr?=
 =?utf-8?B?TVAyV2tNeXFsdVRnUTFNOXFjODU4aUorMzd3Unk2ZzlDMUlPcmVQRVNTR2sv?=
 =?utf-8?B?b2J1emFPNUZkR3llN25ydm02SkEyRlhOMVF0Z3licTUvTXZxWHJIc1E0aEMv?=
 =?utf-8?B?OW9uUUxOZGF4bTlOVXF6Q3pOeXBzNzlDYXlQSVpaQzM2cURJV0RBcmRWVDQ3?=
 =?utf-8?B?YWpUTlpRY3dxaUdtOE9WYXdoeDd4WFNHdDllWWl2TW5uQTNNcUJ4SjZwcTZH?=
 =?utf-8?B?b1NVYTRFd0lrMXNscnVjRDBnQ3hwQW9UbXdkOEJnQ1FPWTJSWEloSHZSVzln?=
 =?utf-8?B?RWIxRnVvQWM4c2g0eGx4MWdkSFlpMXBYdVE0VlRxc2pjcVI4NFIxcGFMeFdw?=
 =?utf-8?B?MVMwYzZReWc5eE1ITCtqR0FRWm1LYjUvQU5iWThvc3VpSkxRSVpCYnI4S0pt?=
 =?utf-8?B?TVFpeERaZmNQblZndHVvVk5YaExnckZkeHYyS2FiZXJiaGpvNytUU2ttM1cw?=
 =?utf-8?B?ZmlFb2wyR3JDZzU5UnJrWXE3UDhoazN0YnllcVRrU2QxWUdMVFQ4b0EvZ3Vw?=
 =?utf-8?B?VW1ON1pMUTNkeVZEWEdobzhNYmpHMUFGcDNBQmdlTTlSdUhWbHJ2RDFJK09R?=
 =?utf-8?B?RWROaVVuUkpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF5ADB4ADFC.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGc1U1ZDcTEzYWpINUUvSStwRkZqS0xNYzdDMDhUUEFNMktOOFVrSGhySndM?=
 =?utf-8?B?eE82UjhEOTVFRjBYdWFVVlJkS04rbHBGRjBMY05ITzFkQTRwWE51aGhYdGR0?=
 =?utf-8?B?RkorSDhRTXRrM3NRcFB6YzV1SHdzSkhiU1ZhT1hvdUpMQVk4ZUFqQ3ZSTTdI?=
 =?utf-8?B?TEcvZEZ2UTJ0R2dBZ0dUU0xGS1dvVXh4MW1JZGFuOGxNYTErc3BhbTljcGJy?=
 =?utf-8?B?QWUzTllYM0tTMkJlMXJTS1UvLzRuY21KNER4ZTlMQ203ZExtV1dFRGZLNGNw?=
 =?utf-8?B?MlpWYWVvVmVzVFk2dFNjRm5rYUNiSFByVWd4ZUpRZ0Y3bmFKU05MODlYOEJQ?=
 =?utf-8?B?RWdndFFYa2g1dEUwazJmVWxrdWNuUjFwbGxOTjdRczFHNWgwcm1uVWVydDRK?=
 =?utf-8?B?TWFYQ1IvUVRyMG5zeWJiWmhpS2d2citTU1U4Y1QydkVDbWdYOW5xQ2RCejZl?=
 =?utf-8?B?VXkrWWlSc0RaajNHcUVqVDNYLyttSUh2V28zdTc2dmJ5TkhtOFNyRjBzUGtq?=
 =?utf-8?B?WUxhUC82WG1CbEpKMjFTN1Y1WXNVVVlyTDlhQmNUR2srNGtaU3NjUXNkNHFZ?=
 =?utf-8?B?eTRzRmtYaDNIWk81OHFvV3JvU093YTJUS3JpQzFvNFUxb05oRWI2bnV6YXpC?=
 =?utf-8?B?Qi9MTGIrcnlNM0Q5Q003T3Q5aUFobDZDVDZST0RxUWhzaGlnTjlBbFQrYkNU?=
 =?utf-8?B?SUZ2YWRwWW10Z2p5QXByRDRHWEpicnlCZWNvMUxMYlJ0cXprRkpxTmg0cWl0?=
 =?utf-8?B?S3NjUzVlMEkza2NQR0F3bExwdVhFb2puVEpSM3ZpaHBPQUhqNFhrV0YyY2x3?=
 =?utf-8?B?ZUF2MFRRcFpOblpyeEJ3b2c1ZzJ6VjdlbHo4TFhyTlBkL3ZocENzS3MwdHk5?=
 =?utf-8?B?M09EcmpXYzc4TGFodVd6bGthT2JXcGwyYmZqdElFZGdUSUk3RkFJYS9WVDBG?=
 =?utf-8?B?dmpra1dnQUYwNnRjS2lNTWhBbmw2QlhHN1Z3Y3J4RitUMzZuc3ZwNC9YWW1E?=
 =?utf-8?B?MjF4RHFhdGljTVBtQ3NtcWJ1MUI0RFFKZ2ZIamthV3U1cEU2SXhVN3ZEbzZ2?=
 =?utf-8?B?MFRYZTlCTS9mSTJpUFpCNGNzZUZRclNmNXhUazE1S2VZYUR1dTRWK2ZFbVIv?=
 =?utf-8?B?akdRcXo5NkQ4VWx2cHcyZkhKSDcvZWl0SmRJZTF6U3BRTlkzcWFSeE4zOUlI?=
 =?utf-8?B?Zng5SWxjM0tneXdjS0RtZFloeEpuSTc2VXZoWG52L2Faa1l2dzNCamFnckJB?=
 =?utf-8?B?VzBOT3BWQzh0bFpVTVhPZWN5QTU4Y3Q0ZkpOU212Z2dJbmJkTk5tVG5OVVBm?=
 =?utf-8?B?eTR0dlFoanF4M1pDRjkvVnZveHhFQ3Y1K3hmUHV1dDBUZTZPT2I5VWxNa2kv?=
 =?utf-8?B?TXROUnA1WHBvMFZQYTJmNHR0SUhkOGJpRE9pNFBiSFJHb1lRdDF3d0ZadWhq?=
 =?utf-8?B?cVdMNndRVkF2MVAwbGtoTDgwZktTeXN1U244VnFPTjlwMnlHQjZvWVpVMno4?=
 =?utf-8?B?azFSVFdWdzBydmFRSm1sdk1mZE1oNE9WcW56Mm40U2Rxa2ZORDR0RnZ0cXp3?=
 =?utf-8?B?NHYrdk5NTSs4YWo3bGdCbXZRQnhVb09oeEVCRzk3dTloTnNFM2JNSlBhYUNX?=
 =?utf-8?B?OXAzYmMzTko0VkxLYlpaVlVSbEpTRGdDMnRJbmZKNU9Kc0JqYVNCaEVhb1B5?=
 =?utf-8?B?VGhjKzU3YWlNaWZHY1pyRmpiaGpaZURlMkZiR2F2eGtoZlFTRlVmdWxIQXNW?=
 =?utf-8?B?a1c0MmRQaTZxeWt5L0tjR1NKTCtNZE5nak1ya3Q1TEd4MDlGKy9wcTBYWnpG?=
 =?utf-8?B?Q25SZ1YzMzU4MGNlcGZtUW01R0tBU2p1TmFGY1RHZGprMVJlM1NGN3B0SjR0?=
 =?utf-8?B?Qml6RjNQWHlOazhKbnFDUDJzNnhVSmF0bFJOc2djRVRmZWxydCsrcVNQZGFX?=
 =?utf-8?B?cERJWXVsOGcwczdCR0hRMlFEN3lURVBWcHJBWXVzdlhNWDltdXZ4Rm5ucHNl?=
 =?utf-8?B?QjRNT2JvL0Y3Sjllc3crWFN6VHpoaWd2L2U3Q1dQb2xiK3FzZFJpQzNzdmE1?=
 =?utf-8?B?K1M0TnYxYWdHWTYydVprYUZod2JiTTMxeDNra3RsZXJ5b3RmSDZ5bDR0SGw4?=
 =?utf-8?Q?0az38vvx0xbxeA1VJB3dJtSaZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jXiLcx2pzmsoTDT/zSM0jEeNG0ACcth1x+madoyWoaGNGXgP7pxok4cnVETtWveg2bT3IBbSLzEFdCP28iLErJ5U3ur4fxNl+UJ4G13NV+mEudhjdULv9YEMHARKeComxyLEPKjC2TyIyOZty5Go8nwZMVOwFWT+MjoypZkoFybRfqhPQ+++kC+DEhaOYp0rbaO3UEzh7iTVUAPmaWR4dWoDaRO6GVxtBefSbtlAc9a8Iz8tGv0hj9Jm7osOBUn3vPiyK/RSn7ci6idPE1Ar4cEoerxkvwq58p6IqiFYYrGspDNpq2iBCqdHjC7g67L0oINLsPc3RRT8tfIneWUi9vqwhl6sPK4FLKRkhWZE6aQ4oECzmuqRVoBOs+wQKZoxTHsl3W9m7p/yuh7xdivFE0mc5VEpUPCG54D0/bevd571uhy/fRMbn3128ZRqqmF8+Ty1q1hsm5gIvvSzzCgjAAHSt9XIw4CDFBf6FN4MkoOTviiMQKfbRf74O/mJCEZeXq0dZAllsMW/Z+E7w6kreBCo2doRydYITwskaBid00Y70P845Uw/Dl6NgW0NeN1A3xZ8BuNDHmO57UmPElEq8S1yflPNbelfv/wPmU8pfzw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14893d06-2c72-40ba-ac55-08dd86ab31a3
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 23:19:58.9002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arWiloOSp6BGtjBXTuQ6/010Xf7xIh9mPF42f35Y0znUnUHKomVuv96jD8M8h2Ai8PBz5elSG4rzBPILYOHVJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504280186
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDE4NiBTYWx0ZWRfX8KAhL9vnS9gZ jH/Y2GkIDPDUzem4fk8ZVFAGQqUAGLxdEwzB6h7F7ViHFqayHMSZxDqam4ZgQfZ0kJWLPalKShK 33hzTF6tAA2brTDxvILK1NXHKjBWMdAPCbCS4ofc9YkOaYorVfgtu2ax6Qpuo24JvlUSAC8A/46
 mWg/Em70o+8tTJOihyMVDpK/2I0zdhcBO1L4j4gScaOlttkoTxJ1DuvSZjdhmCWgUPfn1QCz35N H5vip21tewXwosW0e+CbxF0COqMHvCxgiHT13CCwNlHGT1aSgXIuluZ8mgxYjA4Nyr/WLsfpZTM XcHhJfYF1B4ObXLN9TMl+JVqSZ5JD0crilt/DaPdiXMwMZmqDJGpygqsSVQRv3QXkBzxVjJnZ5a UvYEN4B1
X-Proofpoint-GUID: iuBoYvZ3CuTof4Ro05jmnXsh_hTEPxEm
X-Proofpoint-ORIG-GUID: iuBoYvZ3CuTof4Ro05jmnXsh_hTEPxEm



On 4/28/25 16:10, Libo Chen wrote:
> Hi Chen Yu,
> 
> I think this is quite useful! I hope it can be picked up.
> 

oops, my bad. It looks like this has been picked up. But I
think my comment still applies~

> I have one comment below
> 
> On 4/8/25 03:14, Chen Yu wrote:
>> On systems with NUMA balancing enabled, it is found that tracking
>> the task activities due to NUMA balancing is helpful. NUMA balancing
>> has two mechanisms for task migration: one is to migrate the task to
>> an idle CPU in its preferred node, the other is to swap tasks on
>> different nodes if they are on each other's preferred node.
>>
>> The kernel already has NUMA page migration statistics in
>> /sys/fs/cgroup/mytest/memory.stat and /proc/{PID}/sched,
>> but does not have statistics for task migration/swap.
>> Add the task migration and swap count accordingly.
>>
>> The following two new fields:
>>
>> numa_task_migrated
>> numa_task_swapped
>>
>> will be displayed in both
>> /sys/fs/cgroup/{GROUP}/memory.stat and /proc/{PID}/sched
>>
>> Introducing both pertask and permemcg NUMA balancing statistics helps
>> to quickly evaluate the performance and resource usage of the target
>> workload. For example, the user can first identify the container which
>> has high NUMA balance activity and then narrow down to a specific task
>> within that group, and tune the memory policy of that task.
>> In summary, it is plausible to iterate the /proc/$pid/sched to find the
>> offending task, but the introduction of per memcg tasks' Numa balancing
>> aggregated  activity can further help users identify the task in a
>> divide-and-conquer way.
>>
>> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
>> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>> ---
>> v1->v2:
>> Update the Documentation/admin-guide/cgroup-v2.rst. (Michal)
>> ---
>>  Documentation/admin-guide/cgroup-v2.rst |  6 ++++++
>>  include/linux/sched.h                   |  4 ++++
>>  include/linux/vm_event_item.h           |  2 ++
>>  kernel/sched/core.c                     | 10 ++++++++--
>>  kernel/sched/debug.c                    |  4 ++++
>>  mm/memcontrol.c                         |  2 ++
>>  mm/vmstat.c                             |  2 ++
>>  7 files changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index f293a13b42ed..b698be14942c 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -1652,6 +1652,12 @@ The following nested keys are defined.
>>  	  numa_hint_faults (npn)
>>  		Number of NUMA hinting faults.
>>  
>> +	  numa_task_migrated (npn)
>> +		Number of task migration by NUMA balancing.
>> +
>> +	  numa_task_swapped (npn)
>> +		Number of task swap by NUMA balancing.
>> +
>>  	  pgdemote_kswapd
>>  		Number of pages demoted by kswapd.
>>  
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 56ddeb37b5cd..2e91326c16ec 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -549,6 +549,10 @@ struct sched_statistics {
>>  	u64				nr_failed_migrations_running;
>>  	u64				nr_failed_migrations_hot;
>>  	u64				nr_forced_migrations;
>> +#ifdef CONFIG_NUMA_BALANCING
>> +	u64				numa_task_migrated;
>> +	u64				numa_task_swapped;
>> +#endif
>>  
>>  	u64				nr_wakeups;
>>  	u64				nr_wakeups_sync;
>> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
>> index 5a37cb2b6f93..df8a1b30930f 100644
>> --- a/include/linux/vm_event_item.h
>> +++ b/include/linux/vm_event_item.h
>> @@ -64,6 +64,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>>  		NUMA_HINT_FAULTS,
>>  		NUMA_HINT_FAULTS_LOCAL,
>>  		NUMA_PAGE_MIGRATE,
>> +		NUMA_TASK_MIGRATE,
>> +		NUMA_TASK_SWAP,
>>  #endif
>>  #ifdef CONFIG_MIGRATION
>>  		PGMIGRATE_SUCCESS, PGMIGRATE_FAIL,
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index b434c2f7e3c1..54e7d63f7785 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -3352,6 +3352,11 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
>>  #ifdef CONFIG_NUMA_BALANCING
>>  static void __migrate_swap_task(struct task_struct *p, int cpu)
>>  {
>> +	__schedstat_inc(p->stats.numa_task_swapped);
>> +
>> +	if (p->mm)
>> +		count_memcg_events_mm(p->mm, NUMA_TASK_SWAP, 1);
>> +
> 
> Is p->mm check necessary? I am pretty sure a !p->mm task cannot reach to this point,
> task_tick_numa() will filter out those tasks, no hinting page fault on such ones.
> We can add a likely() macro here to minimize the overhead if there is a reason to
> keep that check.
> 
> Same comment to the other one in migrate_task_to().
> 
> 
> Thanks,
> Libo
> 
>>  	if (task_on_rq_queued(p)) {
>>  		struct rq *src_rq, *dst_rq;
>>  		struct rq_flags srf, drf;
>> @@ -7955,8 +7960,9 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
>>  	if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
>>  		return -EINVAL;
>>  
>> -	/* TODO: This is not properly updating schedstats */
>> -
>> +	__schedstat_inc(p->stats.numa_task_migrated);
>> +	if (p->mm)
>> +		count_memcg_events_mm(p->mm, NUMA_TASK_MIGRATE, 1);
>>  	trace_sched_move_numa(p, curr_cpu, target_cpu);
>>  	return stop_one_cpu(curr_cpu, migration_cpu_stop, &arg);
>>  }
>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>> index 56ae54e0ce6a..f971c2af7912 100644
>> --- a/kernel/sched/debug.c
>> +++ b/kernel/sched/debug.c
>> @@ -1206,6 +1206,10 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>>  		P_SCHEDSTAT(nr_failed_migrations_running);
>>  		P_SCHEDSTAT(nr_failed_migrations_hot);
>>  		P_SCHEDSTAT(nr_forced_migrations);
>> +#ifdef CONFIG_NUMA_BALANCING
>> +		P_SCHEDSTAT(numa_task_migrated);
>> +		P_SCHEDSTAT(numa_task_swapped);
>> +#endif
>>  		P_SCHEDSTAT(nr_wakeups);
>>  		P_SCHEDSTAT(nr_wakeups_sync);
>>  		P_SCHEDSTAT(nr_wakeups_migrate);
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 83c2df73e4b6..1ba1fa9ed8cb 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -460,6 +460,8 @@ static const unsigned int memcg_vm_event_stat[] = {
>>  	NUMA_PAGE_MIGRATE,
>>  	NUMA_PTE_UPDATES,
>>  	NUMA_HINT_FAULTS,
>> +	NUMA_TASK_MIGRATE,
>> +	NUMA_TASK_SWAP,
>>  #endif
>>  };
>>  
>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>> index 651318765ebf..4abd2ca05d2a 100644
>> --- a/mm/vmstat.c
>> +++ b/mm/vmstat.c
>> @@ -1342,6 +1342,8 @@ const char * const vmstat_text[] = {
>>  	"numa_hint_faults",
>>  	"numa_hint_faults_local",
>>  	"numa_pages_migrated",
>> +	"numa_task_migrated",
>> +	"numa_task_swapped",
>>  #endif
>>  #ifdef CONFIG_MIGRATION
>>  	"pgmigrate_success",
> 


