Return-Path: <cgroups+bounces-5839-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128A69EDAFC
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 00:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E161688E6
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 23:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C8D1EC4FF;
	Wed, 11 Dec 2024 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c/kE7M0c"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39C61F237E;
	Wed, 11 Dec 2024 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733958500; cv=fail; b=DDLm0mS8lcVLYaDSsb3WPccg3VD7jQGT+XGIgnk4UNfSNiM4vpVdJLMU5HdK2GGuBZTNqE902mV7QUvmpw6tcYAyjVKspJeayArvEJKcws89Ovct6t4YBM6A0yjZucKbQDd5QiQHJ9OqCvLPBl5TKw7hrnFl2yKsc94TQfyg6jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733958500; c=relaxed/simple;
	bh=2+eWHsAJr2BKpH9m+ZtUtO/7LyxpUzV/xeyN9GWeNJI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vD8Ez6jSIUhGOvRnu5z0j8FBTvUZsnjGKTHJhUe2BmWahAvr1+zoy3vQXj5qHAPRuSRl20U+YHx6pFytic0jUCboa+7VC+nydVnLXD8AZm3/+gV6UR6veNNNwVRc4Y74lmIBVw6GDGn0Y1SgAUkI2olME8JSj0MTdKmKIWj32g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c/kE7M0c; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZ2ftIRfKXCDPe5DTm64jXI6PzaS0FvqPd1v7LnSjOZPUbR/SojBPNWJe4KfCW4TRtajX6U4iYNhXhnLP94kKX7AJTkJ8T2Nhr/UQn9fFmbFNh6AQnPp/erTj5uuxUuzGiKli8brsMta6Hur2zoq8D9BT4KaquoDYXhXaVMEelcLDSy6ICZvCpavzPxx5PkXIuJzrDp2k6jG5dIilrJ9bjzQRFJdB8xMRuiO3T3DOLwndRe8tYzMD2gcZlKt/khZ4nd1d8twrp2T1AWLyQK8xJtcmb7LCpz9Ar352VsPNoSu1Rx6gKU2+uU3EjKY6p9aHn9MPo+JO9ih54KQnYFmFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pq3u0rE8omMho86kTd9nHnGIB2NIqj+e4qTBh7OoyIE=;
 b=sba4mS5teIHVEEMIACrjP+dyPSjxBbCmkcBXtzSqK78d9GXihshxaI5ix9XUschYBpHWPrsAQIMdfkcA/sIP2v3V3JLo1/qsS8ZlxcJOaPMNrTc3MTMM83sijlihDyUY9i9nRNzazTG19IfSoQB9usTNeU5lzFFsKuqfeVo8JcZ1dF2HkYk6kn7axYFB9xY3zh4RH+j83SAXMnOrblVMWtawFPnIYHh3nSc7UdD9/G5xYD3aL5ERll9wckH3uY1F48RbOkKXTer0xYcnfysDzw4jCW3B2zRqB1WwJPNAsOQ/Nux92cNaAa7qqt/sKI2ozzSat6/G32afy+hnNJZ9hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pq3u0rE8omMho86kTd9nHnGIB2NIqj+e4qTBh7OoyIE=;
 b=c/kE7M0c5DNXNnbEIloJGPEomw8I1ORo0KmziyMXV3Yc+e5ODfZ8wdx/l2HpXPTHMZAwIz8Hqt5AbToWnEI1UPlXH4rIQ6QiBHwRiIKjfYWUOdtAHblvrZ7oSy7N5MYt5iuacNN/Svqatc4Zpw8BLjJmXgPi3f7ymkqikGlX5u5XwRvGjR4FKlebw1RpFYJIT5f77fg4jAJqNh8ZGufGW96OsvRNDaYcjaKW85QqMtOimNUnRjrUHeYrsD6ibUgR93/9vbcE82xMaVrReSSePP6YNn7wbL+YEYN8mWboxupWUui889lBk4Lfgdt8EX2PqozM3pbCxMfohpmwAxUt5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by PH8PR12MB6746.namprd12.prod.outlook.com (2603:10b6:510:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 11 Dec
 2024 23:08:13 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%6]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 23:08:13 +0000
Message-ID: <20ca34f1-9777-4c43-a180-89bef4de1976@nvidia.com>
Date: Thu, 12 Dec 2024 10:08:07 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vmalloc: Fix accounting with i915
Content-Language: en-GB
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 cgroups@vger.kernel.org, stable@vger.kernel.org
References: <20241211202538.168311-1-willy@infradead.org>
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20241211202538.168311-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:806:20::13) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|PH8PR12MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: 67550db8-780b-4f73-f96d-08dd1a38b005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWs1OHU0WFVYNmEza1NLQ3pWVjAraTcxZGtaQWtZYThOWityaW1BYkdWTVdO?=
 =?utf-8?B?YnVKYy9KVkE3TUxuRWxtLzBjS3QyLy9haVJqOFhhd1kzNFlHaUlRUCsvTHhx?=
 =?utf-8?B?a2dOZXNvbGFvMnRETlp0dHBvTEJQUEU1eVBZNnZoSzJRMThtOCtnbEQwYW9G?=
 =?utf-8?B?Wk9JOS9KVkRYZm5zQUM2dVFzNTVKQjdUSzh4MCt3T0tTSTl4Lzlqd0pqTkxQ?=
 =?utf-8?B?NUpFQVYrZU03MWhBMFZTc0ltUFZOSEVCMEY4ekhFQ250ZHhCSWdCQWE3TmIx?=
 =?utf-8?B?Z2NaeVp4ejhSRTdQOVpNMEU1eTFpUCtYRkpYQW1yQnY3NEhoRkIycjM0ZU9B?=
 =?utf-8?B?M0xoNjczTlgwSW1TZWVDeVF3WkFnL1J0Y2ZmN2t2Yys5OThyNjlGa3NWQWo0?=
 =?utf-8?B?Wk1MNlZla1VNSXI1cnFOSzVHNHludkxVMU1MV3FIWFdNQzdPL0xCMnRxcDdK?=
 =?utf-8?B?eE9zUmJJc1orWVBPb3Qwdy81UG9lMDJXSnA5aE1Wa09Jd1RFSFFKeFZ1cEdh?=
 =?utf-8?B?TndSRk1SL2hidE1TelZ5ZWNncGlrUmE1ek9INnJqQklYTlNaL2pBSkx2NkFL?=
 =?utf-8?B?d3MxRVQrZTd5NTJ0cTNRTTczREtka3FVZnArVkpqZHNBdzlEU3BZZVVzYzFB?=
 =?utf-8?B?MVlURVUyUXVpb1c4WE1Fd0xyR3lYQlBRcUFScmtMRjlWaVA1WThsTk1mU01J?=
 =?utf-8?B?ckFPQkd3UEJtUm9yNFJuZjQ5Tm5yZTJHUXczSTlDOE5TYXZ4dVVZbG9vSTFR?=
 =?utf-8?B?cDBBL1VWSWlIcU4zcERGeHEyMXBla3RSYjJzSzJzU3hSRFE0WXFXRjhxb3dG?=
 =?utf-8?B?ZFJlQ3pNbDBYeFRReDBFMHlobTczZkpTOEE0V0tUS3RVMnhnc3FzZEt0NVRp?=
 =?utf-8?B?Vjlhc0NSOEV6SCtZa0x0ZVEyOVRxeUsrVG9yZGtxMzdjSFh4cis3THB1c3hJ?=
 =?utf-8?B?T2phNmZYaFg3SWtzVEhvUHBKTmlITlc0Vk9TMEpjU05Vam5zZUxuZ1IrY3FY?=
 =?utf-8?B?U3V3MDJRMm1GK3FDSGZEVFlhSGRZOG9TZnBJNWRUdTZQeitXclg3Z09BeXNW?=
 =?utf-8?B?MW93N0pEUXNUUE5ZU0J4SjZ2U2RYZVRGQzdOV2c3S2JPU1FWaWRlYTBKRzRi?=
 =?utf-8?B?MlpVZTlXSnd0enNlMmpVdUEwdzJ5aGJWcVpNeWRDUUszazUyYXlldm9paGRR?=
 =?utf-8?B?WkQ0VFNqeEFaaFhtcmlmVzRvd01kc2NiYmhoM2dJNW9GUzdJZUlHUk5Sdzlm?=
 =?utf-8?B?K0ZPZHhHV0ErTWRwdUVXTG1LeTdGVVUyWWlrZ2FJYjRVMzQxODRLWHhBYmNn?=
 =?utf-8?B?U3B2WGI3TGJDSVY0SW10bjgyS3B3SlN5dG5RZzhHbDRrSWRUemF1c2NKMDcx?=
 =?utf-8?B?VVExU2RaL280Zm1LUE92YXdEeWJ1MERIYWcwNmlSYkkrdTJSTFRXSGgwbUdB?=
 =?utf-8?B?UktXT3o3bmFjLzBlSGRJMU1oQU5MUGlCTVVxeVRlNnVOdWoyMzJCRElzVkwy?=
 =?utf-8?B?dUpycFgvaUl3Rk1tL2luM3ZSWEs1Y1AzTUpPR25NVDUrc1dSaEt2a2VUVnVM?=
 =?utf-8?B?T3E5NmVxa040aFFoK2hBVCtkUEpOdFM4TUhIK3pCVm5BUTRrTEFNMVhFcUd4?=
 =?utf-8?B?djFiS3NWbHROR255VzVOY0x6V293SC9qWTdJampjUzQ1WHM0NjY2YnZUNGhv?=
 =?utf-8?B?MkU0b3ZobnNpbEtPQmNhZlVUSlB2WVFCNWJGYzNucHJmeVRDZ2d0ZzFSby9T?=
 =?utf-8?B?dVRjU0djWnFHWldINkg3d09CeXJZNTFIRHVBNE96VkEwano3RDhycFVUMWZ0?=
 =?utf-8?B?S01UZnVRRFA0SjZhMUNIQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ti90OTFCNkpVWHZLbzlkY0lLK1ZPcnI1UDVObHJnL1ZzT2dhQjVybXphM1BN?=
 =?utf-8?B?aGZJbkZLSUNUb1V2MmNyVzdBMko4dlFQdmJad0s3RzErKzlrbFdjWnhZb3Nu?=
 =?utf-8?B?REsrY28valhXNWZ4N2NkZVU1SnAvN0hZY2gxd2VXTDlDZFpVVGtybm5QTnZt?=
 =?utf-8?B?cXV5Rm1NUUY0cHJyanNkUElWelZ0Zkw0QnFzeVNic3dmSzJhcGkwMXNjd2J1?=
 =?utf-8?B?ektIU0xtd1pERXhVYlFHK0NRQitmU1I2M3NzNlF0SFM2N1RIdFkyVDJWTWVl?=
 =?utf-8?B?ODI0a2wwZ2kyZDA5MmszT1VRZmpNMWs3ajd5aytTUDdOaWs0TDM0ZnlXb2VT?=
 =?utf-8?B?cmdybG1RSU5MUXZzKzNJaU5BZzhBWDFFY01oUEx5QnBCM3c0Tm9zaXlhM05V?=
 =?utf-8?B?VjZ4YTEvc2JUbkRMbXJldnVOVWdZQXNxeFZFcnFXYUNES2NyV0pCbHZ4STVu?=
 =?utf-8?B?L3FmaXpuTGZRYVE4cGpCdGRTWkt4aHFOQVNkRE51Njl6TmJsZ2ovRWpScGF3?=
 =?utf-8?B?YURBbGtlTW4rVlZrNVJBc3hSNVdVZ294clpSUVB4RnlJeWc0VWYwVlQwdEhj?=
 =?utf-8?B?Z2xlbnc2YzE5d2dCa0sxYnhyRVVjMkM1dGFNdzJ1a2J1b2x4WDY5UWUvRGsz?=
 =?utf-8?B?NFliczZOTWkzR252Y01NYU1SVTlXb2ErM29UZm9OYlZhMWtLLzlqd2lrTVpv?=
 =?utf-8?B?emNyaU42WGd2Yy9GVmZWbElTeWhYRVFGUFJrUkRaSnRCR2ZJMHk3OU04OEZN?=
 =?utf-8?B?Q1RFVVNlTW1mNC9TNjNRa1A1U09Rb3RGbnpOL2lpYzN6OGE1QTF0SnJPYmdj?=
 =?utf-8?B?SExvOERvVU5jZjl6RDRlUW14NkVNR2dUdmgyVy9aRVdQcUdPSnh2amQ2Zk1r?=
 =?utf-8?B?WUt5RWtTYTRReDYzanhXM3ZZTEEvdlV3K1V4WTk0cVgrNWdEVy9lSWdVNUFv?=
 =?utf-8?B?WjFCMVdpdUgxbU9OOU5yalRTWXZ0b0tMRy9yYjg4SkFDNWdtT0ZsOE1MUmRr?=
 =?utf-8?B?YU9mbHdDeWo2TTE2YlErTFlNWURFK0dFamU4Rmh3YXFrUXdzVjB1Z3pINDhy?=
 =?utf-8?B?U0NCdUFNTytJYzRDYVg4NmZrcVhPSGswSWRmSHowSGNRSVdkSEhKckpoa24w?=
 =?utf-8?B?UDhiUWZ1RDhVZWV5VGlSMVZlSEZObGtBcUdzRzk1VXpzNkxaRDMzR1p0bS8x?=
 =?utf-8?B?UVRJMXhCN0NONTlqUlZ5ZXZxMnVKcnJXRE9JSjlKdzJXNVVaZ1A1RFN6Vklv?=
 =?utf-8?B?TFlNNWdTSFRCYWU1VHh2RnI2TzIzRjZ3dWUyeHJxTHFuSnVqbmRRL2E2QlBS?=
 =?utf-8?B?MFk3OWVFZVhkOHFzVVJ6cWZEaC93QUZLN3JmdkRURmFUWVlmY3NCRjAva0Zq?=
 =?utf-8?B?ZG5JcnRyZ0cvV1Zpb1FKdjRkbGFUdGlxM29ZZzlObThtUzUvZDJrS1IwZE8y?=
 =?utf-8?B?eEtVQjBaVCtXQU1obncxNWtJUWxOditoQ2xTRnlYdW9WWGRZVWlsbDUrWlVZ?=
 =?utf-8?B?cUhjeXFLTGZPZHBOaHBZbHhjaDlFcC85OG0wWkJISnVuU3RoNmVsM0dHUlpB?=
 =?utf-8?B?Qkk5T1p4ZmgxVFkwZ1hxM0ZIOUpMK3pWS2F1NWlMaVdFMTcyMWNHR3cwcmtO?=
 =?utf-8?B?Y2VLRGN0eEUxaFN6SGVvSnJKbEJJc0s4RVdRT05lY290dmFnSDFiemRIT3FB?=
 =?utf-8?B?NDNRUmFtV3NIcVhCZFRjU283M3pWeHFkWVI0QURjcjMrbXZPSzZtSGp2Y0xz?=
 =?utf-8?B?eEhuMlc5TjhoZTlWZFZoNDhIVHcrdmtpOVZSM3dod3YxWit5YnNIWGdjZHF0?=
 =?utf-8?B?YTVPZ3V3K2E5TXdyTVdoT2p3dzVVck1PUGtQV2pJVVYwWlRPZWtzNnVXVDdn?=
 =?utf-8?B?NFowVVBtOGhyRFUyTm1BakZnSkFXMGxWSmRtbEJYcDkzck1rUDRMWTZHdk5K?=
 =?utf-8?B?M0NtWFFmTzJFTkZiZkxoUEN0Z3hjUUNyVzRUejRUTGVjVnZIMU5hdkhSUXVX?=
 =?utf-8?B?dWZ5TXM3bUk2UkZISXYramJsRk9wYXBzb0pxYkUzaFpoME56WkxCN2UreVRN?=
 =?utf-8?B?SE9mUVRDNUhXQkl1Q1pEd0x0emFrckc1M0s4V2ZFd0l3ZmdvQkkyTXRBcnhi?=
 =?utf-8?Q?iXBSRQ6ydUvRS7xH5mAfjrXsH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67550db8-780b-4f73-f96d-08dd1a38b005
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 23:08:13.1184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2oIPuoyegkG/esfntKvMA7usaOPDYw5mdbw2T5gNj5RPQD00dvyrRHHDTvFvGQCwpISD9oekIDN0qulQxT5PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6746

On 12/12/24 07:25, Matthew Wilcox (Oracle) wrote:
> If the caller of vmap() specifies VM_MAP_PUT_PAGES (currently only the
> i915 driver), we will decrement nr_vmalloc_pages and MEMCG_VMALLOC in
> vfree().  These counters are incremented by vmalloc() but not by vmap()
> so this will cause an underflow.  Check the VM_MAP_PUT_PAGES flag before
> decrementing either counter.
> 
> Fixes: b944afc9d64d (mm: add a VM_MAP_PUT_PAGES flag for vmap)
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/vmalloc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index f009b21705c1..5c88d0e90c20 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3374,7 +3374,8 @@ void vfree(const void *addr)
>  		struct page *page = vm->pages[i];
>  
>  		BUG_ON(!page);
> -		mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
> +		if (!(vm->flags & VM_MAP_PUT_PAGES))
> +			mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
>  		/*
>  		 * High-order allocs for huge vmallocs are split, so
>  		 * can be freed as an array of order-0 allocations
> @@ -3382,7 +3383,8 @@ void vfree(const void *addr)
>  		__free_page(page);
>  		cond_resched();
>  	}
> -	atomic_long_sub(vm->nr_pages, &nr_vmalloc_pages);
> +	if (!(vm->flags & VM_MAP_PUT_PAGES))
> +		atomic_long_sub(vm->nr_pages, &nr_vmalloc_pages);
>  	kvfree(vm->pages);
>  	kfree(vm);
>  }

I found another user kunit_iov_vector.c, but even it though it uses
VM_MAP_PUT_PAGES, it does not call into vfree() (which I need to check
for further bugs)

Reviewed-by: Balbir Singh <balbirs@nvidia.com>

