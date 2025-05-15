Return-Path: <cgroups+bounces-8210-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA508AB86FF
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 14:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03175188F034
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 12:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2727229A339;
	Thu, 15 May 2025 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m5WX5GPl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xrBaAhNk"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A30298CA1;
	Thu, 15 May 2025 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313261; cv=fail; b=IpswdQYV3rqePhcY/e/huYCy6lEWjyvGVQinJkqkzEb7wgjzAMrh4k10+ytaJi565WMcTsrFebktFWBi0YUSjqmQkv9WbzBW/o6IZP9K20iOWDT8ZHCbCnjhRu7kb/PP7W9w2s01/DmhXvEnng8qxksDsq2c3trX4l9HfaxZojA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313261; c=relaxed/simple;
	bh=5+/a0Aex0quUMDLBa2bUW0XfrDbQDG47UbMoFcu0ayc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uHk+VFECoTDdxsQnzRo4pIeLRSSp3dPK71YMyAexOg4yYt4q1dQjopWWdeWONMMjQmSkPBAXMb+3EJdLO8+B4EW0d6ei002gS6LRA2PxZGs0YRJpcN9lrj93B3xrAKlBcLdtKD8mkrsZl2J+fZ62IYKbM0JbmSJ96k563fgNCqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m5WX5GPl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xrBaAhNk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F7Blns027067;
	Thu, 15 May 2025 12:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=aJsZJhUkCLD+TXdmnNgE5OQV6C1WIc8P0lKKkhanp+w=; b=
	m5WX5GPlyH0wIHzYXin6qVH5vMh5uF5iDeIY3iIb+YeqLVFI1EnDIou0rokHY1Po
	1Mp5Y9J4O7l/x6JvzDsWXxZ+tU5ZBtf5pqxWa0m3R9b9VedyS3q/REwFowre1Chu
	Oa7HbRltIky1tEjDpI64lvYUXBMMAt1rO5A8urjxQwwz//i6cEmhbqhDU9MB9Z0a
	QS3eS7oOZlY26dJBZs0gzRi9Di5eIsaihTH86e/rSR1KarT7t8MMS9AoKcSYMoUv
	pf3ZLRnHdBBY3ydAnTQ2Ab3aLa8RAy1aDYHK4xNfJuHnpjH8abOYRxABvEgEEvBX
	zsPK59kD/sTcP4dfLQlpsA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcduxs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 12:47:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54FBj2WH026181;
	Thu, 15 May 2025 12:47:17 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013077.outbound.protection.outlook.com [40.93.6.77])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mbt98tsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 12:47:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRjAhM5jUtP2hFaBXT3NGbtRQhJHWZ62bWhawycJd7pcXIu5La68b1zRw5pAQ0z0erLk/YXu7IqrWItAKhb2aWfICCdablYfBo7RCZvV7Cm8G6vZ1n4rbaFPi07mxUrGf2cAK07vLk7zCd1ATb80X/fbLnb3n3XdP27/gExHdiH/SMkDvAO41f5DcMb1KHBgLdCfIXBoADoeD9yxXcVL6+XwUOE/tg28eAfDWMBylfVd01HXYX414ohigiCwlU7O8SiGGKvYLmKNmoS/wwVIfOrGSekV5zN3tHLCPx9i99x+bneoju49hibNGf29dUIVi86uvNjKAXDCd/hsBy9Npw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJsZJhUkCLD+TXdmnNgE5OQV6C1WIc8P0lKKkhanp+w=;
 b=iDnpxzLSdXpnttTFnq8hV9W3w5SGZf2mHWwghfOHj3b7sqdmH1pJAtR2g5+xz0cUJkVxcNro1fi7K9lqll1g4yjKCD3XW/SZ2zNorz3ov9rFMg4D1cDnbRXiHa0v3HCsi30GD0B0GTYt8PMPe3vnLlJr1C5lbBD8HW5HCXTnzWe60rzD5xFuQwmzPJJLKEvQe32Eio/cZ6pmka4mzp1ZtngmMZ8w8OdUaAxvHvKr5S0hQd/yl0diucJRCufwToPEy70/k+BtgzObVYo1frVOLIUv2BqsgmaeHjF7uDzUZ/1G0Gz1kY/shmKhyM38haY3iNeirnPwffBCENyRpYl/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJsZJhUkCLD+TXdmnNgE5OQV6C1WIc8P0lKKkhanp+w=;
 b=xrBaAhNkrQPdKyyqd2bLLa6BK+uPfiT9Rs5lQyjhW1XS4TLUcyD5EExiG0aQJEJEOc6pxK2BIhIrydni7xWPnyzHTIBhIyX29HHfYAs2Ia77zAn8+kS4v2iUEHlijbtVIFO4q49eDTThGIy+rqul/Q8tRDCnSiAgDTiJBwjbmDM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB5098.namprd10.prod.outlook.com (2603:10b6:610:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Thu, 15 May
 2025 12:47:14 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8699.022; Thu, 15 May 2025
 12:47:14 +0000
Date: Thu, 15 May 2025 13:47:11 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
        Alexei Starovoitov <ast@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
        bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2 1/7] memcg: memcg_rstat_updated re-entrant safe
 against irqs
Message-ID: <22f69e6e-7908-4e92-96ca-5c70d535c439@lucifer.local>
References: <20250514184158.3471331-1-shakeel.butt@linux.dev>
 <20250514184158.3471331-2-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250514184158.3471331-2-shakeel.butt@linux.dev>
X-ClientProxiedBy: LO4P265CA0052.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB5098:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f9defd-9443-4d17-4dc0-08dd93ae9e23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YW5uMlJzcVBDaG1zektJRTZhUndLa2Mzd2ZUSEtrSkVuektOT0RrczI0UFhT?=
 =?utf-8?B?Qjd0bHJlMlVCRnFxM3NCMHFRRmdLVkxMbGdRc1N6MW83cHBWKzJiQWlZb1hO?=
 =?utf-8?B?WS9qNDBwZldRdER5Z3BseW1jS2pnMEdPUk5udXMxVmNXTnlaN2JGNWROWDJ3?=
 =?utf-8?B?aFdIczFxWmFqamtYQ0M2Wml2V1FHaEJ5cUg3M1daMUx1aHVqeFpiYnFaL0Rj?=
 =?utf-8?B?cnRmcHQzNjFlUG54eTE0WjgvSWhWU3dCTVUvTTNsdnF4MEQ5QWlvV0EwbU94?=
 =?utf-8?B?NWcyejIwdjhFejNkRTRXSGNkSGRvemgwZ1JRem9NNmVhYk12T3ZVNWdjUlF6?=
 =?utf-8?B?MHhhSStBb3B0TDFsejV4UEUwNEE1NS9FVlhTZWM0aFNoVmw2cjlzczBRTkkw?=
 =?utf-8?B?cUFsc2RFZ3l3M2l3OEFOM0NPYjhLRWpRSDFWMDNGc3oxUWRreW5CK3ZFQ3Rp?=
 =?utf-8?B?eEpHUTh2azZrdmhCUS91cEVZSmgxTWRBanBZMEVodWVvY0FrWmVmREpMZXZ4?=
 =?utf-8?B?Ny92YVpiVmdCR3hlMGtIdlZPNjI5TkllTTg0WlhtaUhhVy9PWnFmdUtIS21W?=
 =?utf-8?B?Rjh4UXZsR1JtaXFvdDI0K09wOW42aVVnenBBR0ljaGh2U1pIdDRBNXROTjZI?=
 =?utf-8?B?blFMY0JoSkI3ZTVKNDJTdlgzb1M5Q2V5STFtMkRxQkhQOVkzZ25KMG5VeW1m?=
 =?utf-8?B?RWVFNEduMUxTWFJ0K0tJekZSWjRudUh1blk1SmNFZ203QUdIOXJGRjFCWis4?=
 =?utf-8?B?c1pkaWJVMzBQMEtvWmt5QU42TEdDR2g0bkdualBqVk9ZN2xZVnRoSjFKYjRQ?=
 =?utf-8?B?K1hJb3hmWEVrSERyQ1QwZU9TZlcyM2pRbW1EL0t4L09mR2lMTFNzVlNhR2pD?=
 =?utf-8?B?Y3dyMEI0ckE0VE5KNmNKWkpEdlZzVTdTQmNrdnFsejQ1eHN2SjN2WWJLTWpD?=
 =?utf-8?B?Q1p4UlNGK0dqUGI1aHVVbU4rSEJ6Tm1aRW02a0ZjR1hpbjVtWWF3NU83TEQz?=
 =?utf-8?B?NUllb0NWLzFPbi80ZGFHMDRxclNaRWRyZDgwK3FoNkJPa2lHek9pRnBvMVR1?=
 =?utf-8?B?WEhaRWsrWVZPdWJ3UFpxb2NCSjlySEZucEt6N3N4dGtUZFJwUjErZy9jb1Zn?=
 =?utf-8?B?U2VMTkF6V1NzZjU5K0gvOFpaUkVGdVgxYTBnL1poQmtXOXY1M2ppVDI4cjhG?=
 =?utf-8?B?OVc1TDlURlAwZE1jZC9lSmUyOXNmR0NBdUpMYjE1emVhc2dXdStQc2ZlSUNa?=
 =?utf-8?B?K09hdmVkSW05c0hCenFpbVR5WW80cEtNU2MvK0pIQ2tZcS9ldytDb2owRk54?=
 =?utf-8?B?aEc5ZHVTMjFCRDNmak5UVlJFRnBwTGZZZkNwdmJ4ZkZSZzhoVk52M1pxN2t2?=
 =?utf-8?B?K0ZpY1pVMWpyRUw2YWNxNzljR0lqUnJlbTZwUHU0dmVwamxuQnZZc3VkS0dl?=
 =?utf-8?B?dnZPNmM1MUgrU0tKcHBZcll3OVRkQUdZcURtOTVqZ0h4TFRWMUZDQWNrTGVK?=
 =?utf-8?B?L0ltcnU4V3BrU0ZEWWpRYXN0QUo0NDRkc25xbTNmK29DaVBnU1NtTWc4NUI4?=
 =?utf-8?B?MXBOSjFyNmxQYnZBeE1DdFo4YVMrRjJoQU42Q0txSU11TU9uZysvSnlGbzVl?=
 =?utf-8?B?WTIrVWpSNkU5bU9FcHdzUUh1VkR0UWtjcURkRDFSWWJ2Y0xqckxlZXRMVVJa?=
 =?utf-8?B?TVNLRFdjZk9TcjhoOVV1QWNVQXVMb3NvbXdlR2VDQUVrM2JnbUFVdklIOTlo?=
 =?utf-8?B?cldzdVJsM1k4eTlWemdBczZPMnd1eEx1OS80eTIxTDhNSXcwd212MGExeXVy?=
 =?utf-8?B?SkxpRmgrM1BwemtsY1M5UHlqR01vYWEvS20vMm9ISVRsR21oMDZ3UjVaMjN6?=
 =?utf-8?B?SWkybWVteGV3VDRpSVB6MVVuUm14NWVlRjR2ZlptcjcrNVMxUzAwT055eUsz?=
 =?utf-8?Q?ZnTyMixQlrA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGNMTFVUWjJkTUdROGNaWlNPV1FRVk5pbWNsWUhuTk4xcXRRTWUzempuaGdj?=
 =?utf-8?B?TXJGaFZyMm9DNWhSc1pFOHpBeUo2WkM3dHlEM2tMdkNEWmljK3V1dWdFSzhS?=
 =?utf-8?B?TGh5bkFDdzBhZjRsYnBGOGVneUxGdW9rR1hKQ2hnWVNvZGh5QW9rMzZWQVVh?=
 =?utf-8?B?bVdUMkYyeEhpMUVGNFhPRDV1cElXZ3BiV01LcjhEeWI2RVZQU0hsNWxBZk9o?=
 =?utf-8?B?L3o2dmE2TlB5ck1TeEpGTld2WEVNcEtlckFtei91M3ZPb0RjRDlZSkg0TzNI?=
 =?utf-8?B?VjVCMlM5L3Y1SGo5QWJHKzZjcHJkUG8xY09HcW1idmdhZEg5bWd3VlRINFRZ?=
 =?utf-8?B?Mlg3Q1JZbGUxY0NxYk81L0E3dUgvVnJIbU84RnVaVnhkS1dmbG42Rm5pekxk?=
 =?utf-8?B?YUtRMmVNYUs4SVFPOWdhRlAwWHpxTmpQZEw3bkFscVBrbnFZbi9OZ0MrTXph?=
 =?utf-8?B?Uisyc0lIc0lycjZvdVVWTzFjUHViNnZEaFJsazU5QzJaK01zN1Nqb056MkFr?=
 =?utf-8?B?SE9LNENZZDlvTThQUnM0NmJmNTQwOG9jRVVRd3libmlsYlFKK3Q2aUY3YmFy?=
 =?utf-8?B?MDhicE5BNGFibHlDTmp2MDhiT3g0Nk9JeGtmcm1UUHV3SFJqRUhaVjdTSUJa?=
 =?utf-8?B?SUZlMWlXZCtWNFZGYWdPYnBZdzJrOU12Sk9KQ2s2blhEWWp4RWN0S0YzZStI?=
 =?utf-8?B?RHRuSnV4RHNVUnUwUXZDVjFmK05iekhMeURuenZ4bGZnQzdaKzV5ZlNrYTFn?=
 =?utf-8?B?U0lHRVhQT1ltNGZHeFdIVlk5c2ZMMXRNK3F3UWxtYXFMa1A3RFdNdWNxV1A0?=
 =?utf-8?B?a3VyaEpHaFF2QlVZSXcxaWhQM1BFT1ZHREY3WDhpV09mTS9oTkpVejhOOWxE?=
 =?utf-8?B?UEVJcEpOSDRrSXN3SncrYkRQTENyVHdkeUk4Z3RRTG5UdnA4WFE3Q2VQWEJR?=
 =?utf-8?B?aXFXVXM5dmtldG1CODVQcld5RE0vVlhDdWFlL0xoRFBPaS9lc1pLbnY5a1ds?=
 =?utf-8?B?bytHK0tJQ2gwTTBkWHdpalRiSXVwQXpjbDQyUjdlb0dPR09EbG85QnpPWVJ3?=
 =?utf-8?B?WmdVNXd5QnJnaGZTcDRBZ05nTzFNdTV4SHNBUGQyQmpWNUswc2JIWDBuVGdQ?=
 =?utf-8?B?UHdnWXlEb1BoTUtuNFVRUTVXTnA4OHRQQ09LRFNhbzdFajRIU1NCR2tCVDk0?=
 =?utf-8?B?QzIzM2YySVlCRCt0cVVtN2ZvWnhwb2RtdlVDa2VtSjRQMFVjZTlWN0QwSit2?=
 =?utf-8?B?c1lUcHhaaVNPcnpnQ09zeGVkcHVKUzRkZDA1NjR3Z0gzbTdxd0dtN21vWWlL?=
 =?utf-8?B?Z2hvMTFKekhCZWFFNG5jQkYyRWF2VGljK09CTTBjTCtiVitwWVQ3RTdoYkdW?=
 =?utf-8?B?cVFlWmprZlUra3FVUllZR1M4cm1hL3haOFNoWWR2dmdrNnA2S3pNWktQMWRs?=
 =?utf-8?B?WDJ5c1FjK2tnMnBmTy8zUm1ZcmNScVFyN2crU2dvUklEU0IybDdIMXpiLzc3?=
 =?utf-8?B?YmxEL1JHU2o1NWZEaUUzNkpURTZBUTUwM0ZIa2hvWGlrcnpaM25keloxY0I1?=
 =?utf-8?B?RG9UY2xMTG50S002Y2RVc2UzZEZuZXhOU3VrcnVpYTdCWk9VWHhXVVhMVmtT?=
 =?utf-8?B?a0xLUHN0VnR4dStqdEVQNHhGNUVBVUQ5MjNWb0t3a0VQeVFVR1E5VmhFRGRM?=
 =?utf-8?B?ejR5eWl1Y2gxWXV0Wi95WWxQZ2RHMXFIcVFOd0poR2kyaUVUVE5sdjJiVmJR?=
 =?utf-8?B?VGhTRTV3UGRpSmF3MnhKY1VwaFZBMTZLYVRadEF4cTVleWsrWngyeXE4SEdM?=
 =?utf-8?B?Mm9wV0RNOTJDeUc1RjhmeE9tbEZNNVB0SGIxQkVuNllhNFk2cm93NGEzaks3?=
 =?utf-8?B?MnlMUU54b01xR3JtQ0ZST0JuYWhTaXVNUFpwYm1Pd1FGSnB2TWp1RU93UU96?=
 =?utf-8?B?Nnl0QS81RjNvenh4RWZhOURBamRDN1c1SjZKNUloNDNVSUE0Q1ZiUUx6dnRG?=
 =?utf-8?B?NFNTQjUxZFhzZ0RPbU1aN29PdzM2YXlpZHYyWXczSnE5UDEramJxdFNwNW5N?=
 =?utf-8?B?eGVoN3Y4M0JSZWc5TE1qNlFJVnQzK1pTa1RpTHZOZGM3Y3BHSmRCbFV5dXo3?=
 =?utf-8?B?UmM5M0N2ZmNuMklreDh5OXIzSFBLdy9JenZsYnFnZ3kzeU1IdmZQcjh2UXcr?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QlCRNlc7qTM5MVM/Ww5EPtaFQb0vtGSLXDs96AkE49y+q4eIP+BzakmPpJ1AdHlW63JaUdqgFj/WhhTmanEbKozyTfPyI4Ffm9R0QYxsFR0HauFFBiImtyy3KlpBPGEs1MV/BU46/ok/p4DW2T3NfBoWR2B5qGyYDMilU+KtCyUN19cvoJ27D55HWgHc3IjoAetolYnprekv/h4aKTHthx/YSr1NeHtuITTzNX0hPeJ+IYKrASpZJeMy/gw8SzOM2yQkPgsJ/cwTVMaoCHzFkQbrNoN6YNvVMwnNBAZMgP8Jw2FBhVQP2Q8CE11S99xqVHYutdnL+MyJqXkDD/gpWG+7dHfGLyjWFI7Opi0fEm23ldUL7F2fXP/0OCJ42/Eb4miF+7Q/99+4IpMdHnHZtviB4CaP4ogQRkrkRMo3XoWcQztm2Z7wRA2VUH1PK+r+W1iUiP6O8Yl7Ypif9GGQupLQ6KWbfLTkNBvyF0UHIvjojVFzQ2DbjohNPo7etTsnvpXa//frU813mwemEvewL5pt/UDuuGCiZ19TitGeMbLERtUSI3qpDZ62D8LMMqJh/yCB4+Zvx/XToeK6llEggRxiVpbWIM3UuOVism3TW4o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f9defd-9443-4d17-4dc0-08dd93ae9e23
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 12:47:14.4344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Byknk0UpOog8l3XxrutZOJS6hajyOo3I4qe6Y2tNppewc8Z42Yy6lFbxeOlGhZ6xG8bf0NZSHhuTLa4umwS2UfN0GO2HiAO5tlncsqJLBeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_05,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505150125
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDEyNiBTYWx0ZWRfX++EceuZ+dM8P wml+gtBgaF3dA7CSuYjzES15NZ19TAfM/mlN5LGz+D+mfTcB1pY3QnxUBmY2GL/p/8fKDI3F7Fp 55mka99mBWT/e1Kc+egkZt52GW/zpQWZ1NQ+QKcS+jzVRJuosnUTBBEuZ1zvaVKZhgyPngS4L3O
 goEGL+AMAoKA9hx1z/OkWqpOQsPPMIDKibM2YWD5ucBOpQrX5SAxCYG22npJSkX1/Lx08ZsK3fC Td+J7urWkKwUmtBaxSPwKfHQhdHP15z+/CsGCQ2ipbr4Qm5xi5/GAfYh2V1ZaeWuQovdPXQH3YD VBeuMcYgTCruNYC4XThAbXqsZvccooj81nW3HBf7YCo1GseRZLgK4T+UcEq1RVCO0bMl/Ww3eLr
 WdUgutaDUELmazQu3Lm/pOxchzVBWgd/KbLg7Xqj5v9rH/p7OcVOWkd/l5Td5JW0J4vzmiA8
X-Authority-Analysis: v=2.4 cv=Y8T4sgeN c=1 sm=1 tr=0 ts=6825e256 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=jurYaOB-0Ni3S-p0_64A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14694
X-Proofpoint-GUID: ufn-MxHXRHdlB4hqkOClZ9_ByLwdUeip
X-Proofpoint-ORIG-GUID: ufn-MxHXRHdlB4hqkOClZ9_ByLwdUeip

Shakeel - This breaks the build in mm-new for me:

  CC      mm/pt_reclaim.o
In file included from ./arch/x86/include/asm/rmwcc.h:5,
                 from ./arch/x86/include/asm/bitops.h:18,
                 from ./include/linux/bitops.h:68,
                 from ./include/linux/radix-tree.h:11,
                 from ./include/linux/idr.h:15,
                 from ./include/linux/cgroup-defs.h:13,
                 from mm/memcontrol.c:28:
mm/memcontrol.c: In function ‘mem_cgroup_alloc’:
./arch/x86/include/asm/percpu.h:39:45: error: expected identifier or ‘(’ before ‘__seg_gs’
   39 | #define __percpu_seg_override   CONCATENATE(__seg_, __percpu_seg)
      |                                             ^~~~~~
./include/linux/args.h:25:24: note: in definition of macro ‘__CONCAT’
   25 | #define __CONCAT(a, b) a ## b
      |                        ^
./arch/x86/include/asm/percpu.h:39:33: note: in expansion of macro ‘CONCATENATE’
   39 | #define __percpu_seg_override   CONCATENATE(__seg_, __percpu_seg)
      |                                 ^~~~~~~~~~~
./arch/x86/include/asm/percpu.h:93:33: note: in expansion of macro ‘__percpu_seg_override’
   93 | # define __percpu_qual          __percpu_seg_override
      |                                 ^~~~~~~~~~~~~~~~~~~~~
././include/linux/compiler_types.h:60:25: note: in expansion of macro ‘__percpu_qual’
   60 | # define __percpu       __percpu_qual BTF_TYPE_TAG(percpu)
      |                         ^~~~~~~~~~~~~
mm/memcontrol.c:3700:45: note: in expansion of macro ‘__percpu’
 3700 |         struct memcg_vmstats_percpu *statc, __percpu *pstatc_pcpu;
      |                                             ^~~~~~~~
mm/memcontrol.c:3731:25: error: ‘pstatc_pcpu’ undeclared (first use in this function); did you mean ‘kstat_cpu’?
 3731 |                         pstatc_pcpu = parent->vmstats_percpu;
      |                         ^~~~~~~~~~~
      |                         kstat_cpu
mm/memcontrol.c:3731:25: note: each undeclared identifier is reported only once for each function it appears in

The __percpu macro seems to be a bit screwy with comma-delimited decls, as it
seems that putting this on its own line fixes this problem:


From 28275e5d054506746d310cf5ebd1fafdb0881dba Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Thu, 15 May 2025 13:43:46 +0100
Subject: [PATCH] fix

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/memcontrol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2464a58fbf17..40fcc2259e5f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3697,7 +3697,8 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)

 static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 {
-	struct memcg_vmstats_percpu *statc, __percpu *pstatc_pcpu;
+	struct memcg_vmstats_percpu *statc;
+	struct memcg_vmstats_percpu __percpu *pstatc_pcpu;
 	struct mem_cgroup *memcg;
 	int node, cpu;
 	int __maybe_unused i;
--
2.49.0


I have duplicated this again at the end of this mail for easy application.

Could we get this fix in or drop the series so the build is fixed for
mm-new? Thanks!


On Wed, May 14, 2025 at 11:41:52AM -0700, Shakeel Butt wrote:
> The function memcg_rstat_updated() is used to track the memcg stats
> updates for optimizing the flushes. At the moment, it is not re-entrant
> safe and the callers disabled irqs before calling. However to achieve
> the goal of updating memcg stats without irqs, memcg_rstat_updated()
> needs to be re-entrant safe against irqs.
>
> This patch makes memcg_rstat_updated() re-entrant safe using this_cpu_*
> ops. On archs with CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS, this patch is
> also making memcg_rstat_updated() nmi safe.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/memcontrol.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 89476a71a18d..2464a58fbf17 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -505,8 +505,8 @@ struct memcg_vmstats_percpu {
>  	unsigned int			stats_updates;
>
>  	/* Cached pointers for fast iteration in memcg_rstat_updated() */
> -	struct memcg_vmstats_percpu	*parent;
> -	struct memcg_vmstats		*vmstats;
> +	struct memcg_vmstats_percpu __percpu	*parent_pcpu;
> +	struct memcg_vmstats			*vmstats;
>
>  	/* The above should fit a single cacheline for memcg_rstat_updated() */
>
> @@ -588,16 +588,21 @@ static bool memcg_vmstats_needs_flush(struct memcg_vmstats *vmstats)
>
>  static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>  {
> +	struct memcg_vmstats_percpu __percpu *statc_pcpu;
>  	struct memcg_vmstats_percpu *statc;
> -	int cpu = smp_processor_id();
> +	int cpu;
>  	unsigned int stats_updates;
>
>  	if (!val)
>  		return;
>
> +	/* Don't assume callers have preemption disabled. */
> +	cpu = get_cpu();
> +
>  	cgroup_rstat_updated(memcg->css.cgroup, cpu);
> -	statc = this_cpu_ptr(memcg->vmstats_percpu);
> -	for (; statc; statc = statc->parent) {
> +	statc_pcpu = memcg->vmstats_percpu;
> +	for (; statc_pcpu; statc_pcpu = statc->parent_pcpu) {
> +		statc = this_cpu_ptr(statc_pcpu);
>  		/*
>  		 * If @memcg is already flushable then all its ancestors are
>  		 * flushable as well and also there is no need to increase
> @@ -606,14 +611,15 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>  		if (memcg_vmstats_needs_flush(statc->vmstats))
>  			break;
>
> -		stats_updates = READ_ONCE(statc->stats_updates) + abs(val);
> -		WRITE_ONCE(statc->stats_updates, stats_updates);
> +		stats_updates = this_cpu_add_return(statc_pcpu->stats_updates,
> +						    abs(val));
>  		if (stats_updates < MEMCG_CHARGE_BATCH)
>  			continue;
>
> +		stats_updates = this_cpu_xchg(statc_pcpu->stats_updates, 0);
>  		atomic64_add(stats_updates, &statc->vmstats->stats_updates);
> -		WRITE_ONCE(statc->stats_updates, 0);
>  	}
> +	put_cpu();
>  }
>
>  static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
> @@ -3691,7 +3697,7 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
>
>  static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
>  {
> -	struct memcg_vmstats_percpu *statc, *pstatc;
> +	struct memcg_vmstats_percpu *statc, __percpu *pstatc_pcpu;
>  	struct mem_cgroup *memcg;
>  	int node, cpu;
>  	int __maybe_unused i;
> @@ -3722,9 +3728,9 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
>
>  	for_each_possible_cpu(cpu) {
>  		if (parent)
> -			pstatc = per_cpu_ptr(parent->vmstats_percpu, cpu);
> +			pstatc_pcpu = parent->vmstats_percpu;
>  		statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
> -		statc->parent = parent ? pstatc : NULL;
> +		statc->parent_pcpu = parent ? pstatc_pcpu : NULL;
>  		statc->vmstats = memcg->vmstats;
>  	}
>
> --
> 2.47.1
>
>

----8<----
From 28275e5d054506746d310cf5ebd1fafdb0881dba Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Thu, 15 May 2025 13:43:46 +0100
Subject: [PATCH] fix

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/memcontrol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2464a58fbf17..40fcc2259e5f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3697,7 +3697,8 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)

 static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 {
-	struct memcg_vmstats_percpu *statc, __percpu *pstatc_pcpu;
+	struct memcg_vmstats_percpu *statc;
+	struct memcg_vmstats_percpu __percpu *pstatc_pcpu;
 	struct mem_cgroup *memcg;
 	int node, cpu;
 	int __maybe_unused i;
--
2.49.0

