Return-Path: <cgroups+bounces-6238-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2495A164D4
	for <lists+cgroups@lfdr.de>; Mon, 20 Jan 2025 02:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5333A7170
	for <lists+cgroups@lfdr.de>; Mon, 20 Jan 2025 01:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365038827;
	Mon, 20 Jan 2025 01:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="WuiRoiS2"
X-Original-To: cgroups@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010048.outbound.protection.outlook.com [52.101.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F9DDDD2;
	Mon, 20 Jan 2025 01:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737336178; cv=fail; b=WLpX7mYmDkyESedQHEU++CzMNF+op1zGpf+313cSQAy3v8sCO+pKC+rFQJCEOk3QrUFL6/fowhjlYzl5d0o60Gc7bWNgJEtk6Yv4w4I6rhTpXpn6MR46cAOPfDJoAbDqTIZJhVBxhrte0MlR2srpDnhhny+ZhUgIng8Qj+pLLZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737336178; c=relaxed/simple;
	bh=/22dGDVB508y/7E8bo/lLrKBgHb1vyVRN2ztXA65vp4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jSSBDZedTGGwo+tWRWSyJC5aUpXMnezIXvWFm1V8MAYrqZRQnc4EqWBiKMr2T+i7PnnFWuk3dG7MIsxuJXYjL05fp7DOthi0/46Eg88fyfy/oUbvBEvbivBWOtAIDgXzyx0hLY2tiYCf82xu0+2aAmyCIVdNUtizxXAK7DfDQxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=WuiRoiS2; arc=fail smtp.client-ip=52.101.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7CPUt5/wSuwrauIsDiHP3dCGO8jIbSP6QI/5f9R3la5mDViLgVchHqMlS9MQmufpe2G/JsiW3zCMmMidIMyGoKh8BlDHDHcGl5dzX0adcnSnjX3l3tJR5PuK28Oq/AYKtvBXvTqGsbcDNyGXo4U5i/yAO3uUipxSntCNLwl1Hzaipt1xgHnxz4LP45zsQdu/duNkaj+rfs2K4M+YeUA9MiZ/Xu9dLyR80P1XHjj/jVEem5qYhvWFKckPSKrfRxw14Rk96fOUrB006lEyDXb+tCqie3hS/fXGUw56V6DVJZG2wU7N7W57K1hTyy/G3OLfm9O9shGgPOqt3J3d8wAoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwsVObBFiBmr4crx7Bf/h8epJuOA6heJ6L63t3xeEMQ=;
 b=u/OIydmWfcq2TWYwk7FSeShdAXBYfNP3VsFDqZZxyWz9tJXvIk9fPKJCgD8Q5vtGK04c229CNIeM2mXj+BoAlPjKipYbe/6VaVBtvciPBYbCE4e80k9JgExjddu5vddk8kyuwVgtA7atG9us3QaUM44kaHdWCDxtExfGN1+x9VUvNhlP+W1+H+pSWVGgMOu0WMPYbEyoUQ3+Cek7oz1kxvB7tM1/bTF8Ad1L1hG4ePHTqySHWcu52o3q+R1GZsqV+IGyoHHntcWrgY/XWEfJP2NYe1qQYoRe9r9hTCS+lOn7dHfqK2jnLmkJll8tEaoAMXne9Lgedaee0duBGmGUvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwsVObBFiBmr4crx7Bf/h8epJuOA6heJ6L63t3xeEMQ=;
 b=WuiRoiS2q9pxWyussq9uFeXkN/buqPenD08slOnqmVCTNdfmUkKwvlW6997iV/XncIVvQMdELM2camRZYpa6+Dmr8eUo7sSYqHtM//mnBmjapAR5SH9mTk6IFZtnzyuRS+bk78HOO2HrGRSZy47pAmbNTLh9YvlttX05mRRjPqkxlaibTNOPnMKFlj9LCCt+lMOZB+FW2ZtZ161OoyhE39KBb/jnBrSmIdXfY5rd1QxjZg+81VIFqmELjmbHPpT7DN//7ekmYlJvgJHv+whAGuyIi9L9+e0XNO6vCek2lmURk017XW7gmsfwhDlQ5j1RoxJm+QdN7As6sARYjIs4QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB6690.apcprd06.prod.outlook.com (2603:1096:101:17b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.6; Mon, 20 Jan
 2025 01:22:50 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%6]) with mapi id 15.20.8377.004; Mon, 20 Jan 2025
 01:22:49 +0000
Message-ID: <b2d25ba9-8773-4e17-b5d9-2dbc90382eb5@vivo.com>
Date: Mon, 20 Jan 2025 09:22:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: memcg supports freeing the specified zone's memory
To: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20250116142242.615-1-justinjiang@vivo.com>
 <Z4kZa0BLH6jexJf1@tiehlicka> <a0c310ba-8a43-4f61-ba01-f0d385f1253e@vivo.com>
 <Z4okBYrYD8G1WdKx@tiehlicka> <3156c69f-b52d-4777-ba38-4c32ebc16b24@vivo.com>
 <Z4pCe_B9cwilD7zh@tiehlicka>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <Z4pCe_B9cwilD7zh@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f04281-af24-4ac3-ce8d-08dd38f0f434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzRJY21SY1Z0TWNGc1hPWkJHZmliSTJjVWVKNlJMSUZNZHVYMlNsdzJlVXBt?=
 =?utf-8?B?dzZGSjB6ZjZCOTRLZ1VxQ1VOWSs5OS9MRC9jNVBINFdra2VyKzRYRXE2dUJT?=
 =?utf-8?B?bVBRNlROZ1cwWGZhbjRhaUFnN2VQMWNYSDB3MEtJZ0NpRkptdmlTUXlnTE5K?=
 =?utf-8?B?WGhOTExEUVFPTDVCUWFHN282YTZDMWUyMHhCbUN3VVZmb1RhNW41MmJTRmsv?=
 =?utf-8?B?Nzdna2l4alJudW5POFVKUXBiWm0rUWZSQzRwRGQyb1h5OHY2L3ovWWtFL0Z5?=
 =?utf-8?B?U0pGdStiNDN3T1VCZENOSUdSTno1a3FBazJQRmxuYUdIemUrVVdVTFovL3U3?=
 =?utf-8?B?aTlhTXhOMXVmc3kyVnhXdXpvYWkwT2xlZ0l0SzhrN0tleGNaNS94N25JM0w5?=
 =?utf-8?B?ODdwdXYwdFV4aFdTLzdnT2tKR1VsNkl3S3VhOUF1aXFVTk5yMWZPYi9NZldG?=
 =?utf-8?B?cTc5V3UveVRMOWVMNlFkMERCN3QvTlg3WXQ0eTd0ZE5VaC92UTNDZ2xYSDBY?=
 =?utf-8?B?NUg0a1JYNzRLZjF0aTkrUzlHVkh4ZXlOUDRYOE1uWUF6UzhpZFkvOXkvRFhi?=
 =?utf-8?B?SVhYdS9TcSswMGxZNGFVdHUzTEZsS3VjSEROSUhBbnU0UEFIZGFBK0paNm9r?=
 =?utf-8?B?cU0wcGVkM0sxd3VyZWN1TGxKOHJqeVNQV1BHS3dFMXZNaFJWeXlXV1lSQnZC?=
 =?utf-8?B?UUlTTjROYjZpTFZCMmtSemFrclZuSXJSYUdxV2JPeXB5QzRzOFB6UGQwUUs3?=
 =?utf-8?B?eFFaWkNsNG5YOWxqVmR4Q0NBcEdEbzlCQ2FBMy9UOEYxL1RZeHBEU2FiQUgy?=
 =?utf-8?B?RnZrUE96cUZlQWRQRlJxN2ltZ2x5SzRPOEVEVjcrdGFvK3lWcUh6UklRMHR2?=
 =?utf-8?B?MmtOZVI0dUFZTy9xM0dFemcwWlhnSE5HVDFsK1RORnJmczBGSXBtVXAyeDJm?=
 =?utf-8?B?bko1dzl5dXgyUVkwQXU0L3g2Qlg2OFEwSGwwL1R0enozV0xINVRKUDlqNXR6?=
 =?utf-8?B?cnhvZ0tiMmxWcnBEYzdWc2JhWXJ3bnc5dHNqMExhMkMxTTdVVlEvcUJydVZp?=
 =?utf-8?B?eEQzUGhYN3BiUEQ5eVMrVmRSamxTMTM1UFpVQURrbGlPK1ByNUxnWTVhVnhH?=
 =?utf-8?B?Y21ZWHBoQWVMRWFRcUV0QlV6UlU5N1ZPYXFiTm9UQ21zcTA4T2VNNElUVCs0?=
 =?utf-8?B?UUZZcjlDSnU5UFFwaWN2cDF4MWVhTFloeXZoTGhQZUhSVGFFdjZURjBMRXRx?=
 =?utf-8?B?dm1zVlE1UFhFc0dZQmpIZWk4aHNSdk5SL3lGbkhwV0J3RVQzblNjMUVtazEy?=
 =?utf-8?B?c2VlZDhqVnhBUGRNVUFCaElTRkVjdzZNd1pvS2NQRzdWTmM4aGwyWFkwaW5Y?=
 =?utf-8?B?ODF4R1cxbmhtdCs2OVdkSUwzQlozT1QrejlGZUlvQ2lCSThOUitIYnlrQ2lX?=
 =?utf-8?B?SG9nUlhvTWl5TTVQL3pTNVk4QnlqbXRZTWpHdXR1NUloSVJuekt5UWdCMytL?=
 =?utf-8?B?WjRUcllwai94bFJPRVV3WmI1bUZ5bk9JQWZ1WWZ4THN5YUFySGk2c04yRFJj?=
 =?utf-8?B?OHUyRWlXQTJ3cGxGVXBMSEJNZy9KcHZWWXdPazJNTnJhVWpZZDZBeE9qbXBp?=
 =?utf-8?B?ZVA5akZLK3VKYllHQWY1TDcxd1dSV3dPZFVqcmU4NFg0UHdXYXBYc0dURThX?=
 =?utf-8?B?MXMxSTNKM0RuVnhmSnJweDliZTloMFZabWl4eUQ3R05xRVM0dENXbU50azdx?=
 =?utf-8?B?Qm9KZElneG1wNzQweGI2WDM2K1ZnVkk2NHA0V3VCRnl3eXFHeG1Lc2F0dnNR?=
 =?utf-8?B?TFpMYnFua0ozWkRNZGY2VjdOYW9vK3pNQVYzNWhUS2V3RW5WOFNCQnVQYml4?=
 =?utf-8?B?L3ZVZlpmcGI0U0pybGVpRzhTSFpJNWx3TmZ4ZnBIZ1dEM29jNG9UZGRqWjNU?=
 =?utf-8?Q?ajtojNcH0yg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVh2aTZkQ1VDMzRFa3JvUUFJNDk5ejlYVnRlN1lzdkVWRnFEaG9xbXU5Sjd4?=
 =?utf-8?B?Sm40bHJNSkhjWWZMNXZlbWxuVVo5eXZ3ZHBpdURTNXIvQlZmdHFKQVhuRnBR?=
 =?utf-8?B?cEFlZGVSZG56RThhOXdlQVZRenkyd01mRWJVR2dGRmdITWlwNm10TlA0aWE3?=
 =?utf-8?B?Rk1UL0N3eSsrSGhrS3psYTZlbmJaN0V1ZTdsL1I0bnlSa0t1clJGTlJoR29I?=
 =?utf-8?B?WmZ6ZzluU24rbjhzM3JCcVI5aTcyTGR5QkxlSFFKZ0xySFhNT0F2VlNWWjdZ?=
 =?utf-8?B?SWVYYTJVVEkxTGhDTDB3VmlGVVZ2a2xNNWZ5ZFFGVWlYdUdlb0hQdGVzaVND?=
 =?utf-8?B?b2JkRGgyVXNOOU1mZ01rMEk2SnJpUlJaRWZDL2JBY1ZPQ3JDLzVhd3JqYU9K?=
 =?utf-8?B?S3EvT2lsNEVVaFMrYTBMaUM3K1ZzejJYR0l0MFR6bzc1N1lhd3REaERpN2FL?=
 =?utf-8?B?TzhqdC9nSkJIY3FSd1laMW5TcjhWcFFLeXM1MWU3OUhlKzhyUEhoaXhhN1pN?=
 =?utf-8?B?aDNaUUVmZnRxN2VzQlo1enEzYWxBdG9UY3MzTDFWNDlMUVVsL2tReGhyelpm?=
 =?utf-8?B?NkZoU0lzWEp3RU5LWEczVGJQQks2UlBUR3JQUTJsUHp1b0FHOEpXWDNQek03?=
 =?utf-8?B?RWd1ankwRlpmdGVsU05pWTJRWGtxdjFYN09SUG5lbUdjaVlYMUFnSjNDZGxr?=
 =?utf-8?B?YWdTbERTYkJxRTR4MmNvSEUvc3JjQmN4TXhiY2lTVmJVbFg2YVdrS3g3bSt3?=
 =?utf-8?B?THA0K0JYSi9pYW5LeXl2MStobXBPM2xHQjE5L3dGaXNmTStVb2JmUjVBZG40?=
 =?utf-8?B?dWpNK3B3QXZsWis2elBUVitDZTRZbVN2cVh1ZWYvcTlnN0RJaWp4enVmN09P?=
 =?utf-8?B?U1YyeW5SOElOVmhjMXg2aGg3RHU2WGZiOWZTdG83SlBEeGJacm5WUUpuZ3My?=
 =?utf-8?B?RkdOaDkwMnFWK3dwRnpFNEpoNVpFMWNRQXA4WHk2WUpITDdLVW1lZkJNMmc5?=
 =?utf-8?B?L2s4VFEydzhLL1ZOVmR2eDVvR3JBbGJKNDNiKzVSM3BPKzRDQzVvdDJMRmNI?=
 =?utf-8?B?M3RJUkw0OFBvWVFMK1Z0ZG9IUE5JMXN2cjJrN0tZNUpQQjZTSVAxbExVODQ4?=
 =?utf-8?B?b0JXQVV6U1JUUDFCTForWk0rY25DVnFIYjZsWmpiWDEvcVNPc2RHdllWYlc2?=
 =?utf-8?B?R3YwK09ZNWE3bEZkZGVJeGcxYnRzbksvY3B2U292TW1WSjg5K3Z1NEtobDRs?=
 =?utf-8?B?SFNvTXl5d2h1OGFnQXdUSXRHV2lTYXkzZGNHSVpMK3Z6VEc4ZVhiYkNlL3FC?=
 =?utf-8?B?bTdmT2piVEs5WjlHNm9ZL2tmSlFnQVpuWDBlQ0F3bEltQUg0c1ZIMFdOQS9B?=
 =?utf-8?B?SkdWNnZpVWJMZ25vSnczMnZUOVBLOTdWLzhSZithaS9GMEVyNVRTVjhwWGZR?=
 =?utf-8?B?WDdZODBKMTBvbU56NzVZYlRQU09xS3FERndGc21oNGwwRXdhOUgyR2czdnNI?=
 =?utf-8?B?K0ZCNXZZOThLbXh3V2NBYzNBVVQxTWQxVkVUQzd5Vm45amVBdWpCODRxSHFW?=
 =?utf-8?B?ZUZhMWVJbFhRNERYNFB6VmprVTZQRlNGVkxhd0hqbCtEZVBRdi9HT1Z6Z1hS?=
 =?utf-8?B?U2hMTjN1WmhvNzhLMU42OERyN2poeW5hL1dGcFlRRUttUVlpMjZxakJjODR1?=
 =?utf-8?B?RFMvWnNpUTVLOE1YUmNQV1daaHd1RitKc3NJai9DMGdBa2dWb0dsbStYcjZs?=
 =?utf-8?B?eUxaK1pPNGx3QXhnYWhycEdVbDRGUzRsUU5vbm5tbU8zdDZ4cWpzeC9QNkIr?=
 =?utf-8?B?bHozb3FKQXhQY3k4dlkxcTlQcGhmMXBHbng1TExNZjhjMy81anNYOWlXVzlj?=
 =?utf-8?B?NVB1SEZ3Y0tialZadmN5VGE1S3hmenVsQnBLNkVKa21QMUFya3krNkYzV2U3?=
 =?utf-8?B?ZlJ2eStPTjcrNzFoeVFJbkxUb3RxM1VqVnpUclJjK2ZrTmd1QVBvVWRickxm?=
 =?utf-8?B?WGVoNGllcU9KczJPeGZ1dVpQdWlwckp0OFluZ0hHczJXRWs5M1N3cGpvS3Ar?=
 =?utf-8?B?Slo0bGJkQVpWNnpMeVhJbUlBWHVpK3FBKzFpbCtGT2hldnBkcEJEREFKbjNF?=
 =?utf-8?Q?5WuDEB/yvqvzOGR1cyQCiKnmY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f04281-af24-4ac3-ce8d-08dd38f0f434
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 01:22:49.9069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6p7hIxNp7BRG0BK0d4xQGzP+Eatcj8F4eibD7WXwbJi7ga9I75+7pYBlvhBUZ061kE+ZPKpzzQ/z6nJRiGJu9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6690



在 2025/1/17 19:43, Michal Hocko 写道:
> On Fri 17-01-25 18:25:13, zhiguojiang wrote:
> [...]
>>> Could you describe problem that you are trying to solve?
>> In a dual zone system with both movable and normal zones, we encountered
>> the problem where the GFP_KERNEL flag failed to allocate memory from the
>> normal zone and crashed. Analyzing the logs, we found that there was
>> very little free memory in the normal zone, but more free memory in the
>> movable zone at this time. Therefore, we want to reclaim accurately
>> the normal zone's memory occupied by memcg through
>> try_to_free_mem_cgroup_pages().
> Could you be more specific please? What was the allocation request. Has
> the allocation or charge failed? Do you have allocation failure memory
> info or oom killer report?
Hi Michal Hocko,

RAM12GB, Normal zone 7GB, Movable zone 5GB.
Issue: kmalloc-order3 fails from Normal zone and triggers oom-killer. At 
this time,
there is no order3 memory in Normal zone, but there is still a lot in 
Movable zone.

---------------------------------------------------------------------
4,19685342,241227987454,-,caller=T12845;dumpsys invoked oom-killer: 
gfp_mask=0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), order=3, 
oom_score_adj=200
4,19685343,241227987463,-,caller=T12845;CPU: 7 PID: 12845 Comm: dumpsys 
Tainted: G        WC O      5.10.168-gki-gade08d90ed8c-dirty #1
4,19685344,241227987465,-,caller=T12845;Hardware name: Qualcomm 
Technologies, Inc. Parrot QRD PD2312 (DT)
4,19685345,241227987467,-,caller=T12845;Call trace:
4,19685346,241227987473,-,caller=T12845; dump_backtrace.cfi_jt+0x0/0x8
4,19685347,241227987479,-,caller=T12845; dump_stack_lvl+0xdc/0x138
4,19685348,241227987483,-,caller=T12845; dump_header+0x5c/0x318
4,19685349,241227987485,-,caller=T12845; oom_kill_process+0x124/0x304
4,19685350,241227987486,-,caller=T12845; out_of_memory+0x25c/0x5e0
4,19685351,241227987491,-,caller=T12845; __alloc_pages_slowpath+0x670/0xe10
4,19685352,241227987493,-,caller=T12845; __alloc_pages_nodemask+0x1f4/0x3dc
4,19685353,241227987496,-,caller=T12845; kmalloc_order+0x54/0x338
4,19685354,241227987498,-,caller=T12845; kmalloc_order_trace+0x34/0x1bc
4,19685355,241227987501,-,caller=T12845; __kmalloc+0x614/0x9ec
4,19685356,241227987504,-,caller=T12845; 
binder_alloc_mmap_handler+0x88/0x1f8
4,19685357,241227987508,-,caller=T12845; binder_mmap+0x90/0x10c
4,19685358,241227987510,-,caller=T12845; mmap_region+0x44c/0xc14
4,19685359,241227987513,-,caller=T12845; do_mmap+0x518/0x680
4,19685360,241227987515,-,caller=T12845; vm_mmap_pgoff+0x15c/0x378
4,19685361,241227987518,-,caller=T12845; ksys_mmap_pgoff+0x80/0x108
4,19685362,241227987521,-,caller=T12845; __arm64_sys_mmap+0x38/0x48
4,19685363,241227987523,-,caller=T12845; el0_svc_common+0xd4/0x270
4,19685364,241227987526,-,caller=T12845; el0_svc+0x28/0x98
4,19685365,241227987528,-,caller=T12845; el0_sync_handler+0x8c/0xf0
4,19685366,241227987530,-,caller=T12845; el0_sync+0x1b4/0x1c0
4,19685367,241227987532,c,caller=T12845;[ dump_slubinfo ]: 
Slubmirror-Info begin:
4,19685368,241227987534,c,caller=T12845;[ dump_slubinfo ]: 
Slubmirror-Info end
4,19685369,241227987535,-,caller=T12845;Mem-Info:
4,19685370,241227987540,-,caller=T12845;active_anon:174140 
inactive_anon:569656 isolated_anon:32\x0a active_file:115388 
inactive_file:174776 isolated_file:0\x0a unevictable:379892 dirty:104 
writeback:0\x0a slab_reclaimable:46841 slab_unreclaimable:180452\x0a 
mapped:244977 shmem:376107 pagetables:100398 bounce:0\x0a free:535262 
free_pcp:52 free_cma:138
4,19685371,241227987545,-,caller=T12845;Node 0 active_anon:696560kB 
inactive_anon:2278624kB active_file:461552kB inactive_file:699104kB 
unevictable:1519568kB isolated(anon):128kB isolated(file):0kB 
mapped:979908kB dirty:416kB writeback:0kB shmem:1504428kB shmem_thp: 0kB 
shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB 
kernel_stack:297280kB shadow_call_stack:74444kB all_unreclaimable? no
4,19685372,241227987550,c,caller=T12845;Normal free:106384kB min:40864kB 
low:81732kB high:91948kB reserved_highatomic:4096KB active_anon:61300kB 
inactive_anon:90240kB active_file:461552kB inactive_file:699104kB 
unevictable:1518396kB writepending:416kB present:6724288kB 
managed:6520292kB mlocked:5732kB pagetables:401592kB bounce:0kB 
free_pcp:204kB local_pcp:100kB free_cma:552kB
4,19685373,241227987551,-,caller=T12845;lowmem_reserve[]: 0 0 40960
4,19685374,241227987558,c,caller=T12845;Movable free:2034664kB 
min:32860kB low:65716kB high:73928kB reserved_highatomic:0KB 
active_anon:635260kB inactive_anon:2188384kB active_file:0kB 
inactive_file:0kB unevictable:1172kB writepending:0kB present:5242880kB 
managed:5242880kB mlocked:828kB pagetables:0kB bounce:0kB free_pcp:4kB 
local_pcp:0kB free_cma:0kB
4,19685375,241227987559,-,caller=T12845;lowmem_reserve[]: 0 0 0
4,19685376,241227987563,c,caller=T12845;Normal: 8939*4kB (UMEC) 6885*8kB 
(UECH) 810*16kB (UECH) 8*32kB (CH) 5*64kB (H) 1*128kB (H) 1*256kB (H) 
1*512kB (H) 1*1024kB (H) 0*2048kB 0*4096kB = 106292kB
4,19685377,241227987577,c,caller=T12845;Movable: 147666*4kB (M) 
103543*8kB (M) 28850*16kB (M) 3728*32kB (M) 140*64kB (M) 28*128kB (M) 
2*256kB (M) 1*512kB (M) 1*1024kB (M) 0*2048kB 5*4096kB (M) = 2034976kB
4,19685378,241227987598,-,caller=T12845;682191 total pagecache pages
4,19685379,241227987612,-,caller=T12845;1903 pages in swap cache
4,19685380,241227987614,-,caller=T12845;Swap cache stats: add 70971717, 
delete 70981528, find 28723407/55049936
4,19685381,241227987616,-,caller=T12845;Free swap  = 10291152kB
4,19685382,241227987617,-,caller=T12845;Total swap = 11534332kB
4,19685383,241227987618,-,caller=T12845;2991792 pages RAM
4,19685384,241227987620,-,caller=T12845;0 pages HighMem/MovableOnly
4,19685385,241227987621,-,caller=T12845;50999 pages reserved
4,19685386,241227987622,-,caller=T12845;66560 pages cma reserved
6,19685387,241227987624,-,caller=T12845;Tasks state (memory values in 
pages):
6,19685388,241227987625,-,caller=T12845;[  pid  ]   uid  tgid 
total_vm      rss pgtables_bytes swapents oom_score_adj name
6,19685389,241227987642,-,caller=T12845;[    265]     0   265 
2716383      169   225280      684         -1000 init
6,19685390,241227987644,-,caller=T12845;[    267]     0   267 
2712617     1048   262144      343         -1000 ueventd
6,19685391,241227987646,-,caller=T12845;[    303]  1013   303 
2720877      709   180224      258         -1000 audioadsprpcd
6,19685392,241227987659,-,caller=T12845;[    670]  1069   670 
2759316     2120   225280        0         -1000 lmkd
6,19685393,241227987663,-,caller=T12845;[    683]  1000   683 
2704602      914   249856      221         -1000 servicemanager
6,19685394,241227987667,-,caller=T12845;[    697]  1000   697 
2719773     1201   258048      251         -1000 hwservicemanage
6,19685395,241227987670,-,caller=T12845;[    707]  1000   707 
2714873      716   180224      211         -1000 vndservicemanag
6,19685396,241227987673,-,caller=T12845;[    712]  1000   712 
2720604      946   217088      161         -1000 configstore@1.0
6,19685397,241227987680,-,caller=T12845;[    787]  1000   787 
2723139      548   196608      253         -1000 keymaster@4.1-s
6,19685398,241227987682,-,caller=T12845;[    788]  1000   788 
2723972      879   221184      242         -1000 android.hardwar
6,19685399,241227987684,-,caller=T12845;[    789]  1000   789 
2757477      569   253952      266         -1000 qseecomd
6,19685400,241227987686,-,caller=T12845;[    790]  1000   790 
2718076      696   192512      236         -1000 qseecom@1.0-ser
6,19685401,241227987688,-,caller=T12845;[    791]     0   791 
2728293      462   299008      605         -1000 binder:791_2
6,19685402,241227987689,-,caller=T12845;[    795]     0   795 
2718326      666   225280      330         -1000 vendor.vivo.har
6,19685403,241227987693,-,caller=T12845;[    853]  1000   853 
2760196      900   307200      162         -1000 suspend@1.0-ser
6,19685404,241227987695,-,caller=T12845;[    854]  1017   854 
2793946     2233   348160      626         -1000 binder:854_2
6,19685405,241227987697,-,caller=T12845;[    856]  1000   856 
2714316      808   184320      155         -1000 atrace@1.0-serv
6,19685406,241227987699,-,caller=T12845;[    857]     0   857 
2702338      627   221184      258         -1000 boot@1.2-servic
6,19685407,241227987700,-,caller=T12845;[    859]  1000   859 
2714511      670   184320      235         -1000 gatekeeper@1.0-
6,19685408,241227987702,-,caller=T12845;[    862]  1000   862 
2709074      730   200704      260         -1000 esepowermanager
6,19685409,241227987704,-,caller=T12845;[    864]  1000   864 
2751205      689   229376      334         -1000 qteeconnector@1
6,19685410,241227987706,-,caller=T12845;[    865]  1000   865 
2712176      459   172032      202         -1000 sscrpcd
6,19685411,241227987707,-,caller=T12845;[    867]  1000   867 
2723612      705   217088      259         -1000 analysis@1.1-se
6,19685412,241227987711,-,caller=T12845;[    917]  1058   917 
2706494      624   163840      125         -1000 tombstoned
6,19685413,241227987713,-,caller=T12845;[    942]  1000   942 
2736042      733   172032      182         -1000 time_daemon
6,19685414,241227987715,-,caller=T12845;[    978]  1066   978 
2744675      612   266240      306         -1000 binder:978_2
6,19685415,241227987717,-,caller=T12845;[    979]     0   979 
2784246     1733   339968      327         -1000 binder:979_4
6,19685416,241227987719,-,caller=T12845;[    980]     0   980 
3907230     8737  1208320     6173         -1000 main
6,19685417,241227987721,-,caller=T12845;[    981]     0   981 
484373      792   974848     9256         -1000 main
6,19685418,241227987723,-,caller=T12845;[   1047]  1000  1047 
2911794      468   311296      541         -1000 ssgtzd
6,19685419,241227987725,-,caller=T12845;[   1050]  1000  1050 
2723643      869   241664      789         -1000 diag-router
6,19685420,241227987727,-,caller=T12845;[   1077]  1000  1077 
2710940      694   167936      131         -1000 allocator@1.0-s
6,19685421,241227987729,-,caller=T12845;[   1089]     0  1089 
2849254     1243   372736     1071         -1000 vivoatcmd@1.0-s
6,19685422,241227987731,-,caller=T12845;[   1096]  1000  1096 
2740813      806   208896      219         -1000 qccsyshal@1.2-s
6,19685423,241227987733,-,caller=T12845;[   1115]  1041  1115 
2990378     3040   634880     5817         -1000 audio.service_6
6,19685424,241227987735,-,caller=T12845;[   1127]  1013  1127 5570       
68    61440      208         -1000 cas@1.2-service
6,19685425,241227987736,-,caller=T12845;[   1133]  1013  1133 
2737692      356   204800      299         -1000 drm@1.4-service
6,19685426,241227987738,-,caller=T12845;[   1135]  1013  1135 
2796390      424   286720      277         -1000 drm@1.4-service
6,19685427,241227987740,-,caller=T12845;[   1140]  1021  1140 
2861145      297   389120      580         -1000 binder:1140_2
6,19685428,241227987742,-,caller=T12845;[   1144]  1000  1144 
2698610      714   184320      154         -1000 health@2.1-serv
6,19685429,241227987745,-,caller=T12845;[   1151]  1000  1151 
2727279      846   180224      185         -1000 android.hardwar
6,19685430,241227987746,-,caller=T12845;[   1154]  1000  1154 
2826037     1113   315392      485         -1000 sensors@2.1-ser
6,19685431,241227987748,-,caller=T12845;[   1159]     0  1159 
2730640      698   208896      177         -1000 usb@1.2-service
6,19685432,241227987750,-,caller=T12845;[   1162]  1010  1162 
2752709     3012   290816      215         -1000 wifi@1.0-servic
6,19685433,241227987752,-,caller=T12845;[   1165]  1000  1165 
2736915      702   245760      422         -1000 android.hardwar
6,19685434,241227987753,-,caller=T12845;[   1167]     0  1167 
2710815      836   221184      241         -1000 poweropt-servic
6,19685435,241227987755,-,caller=T12845;[   1169]     0  1169 
2726186      636   204800      337         -1000 vivoasem@1.0-se
6,19685436,241227987757,-,caller=T12845;[   1171]     0  1171 
2739515      614   225280      225         -1000 vivoem@1.0-serv
6,19685437,241227987759,-,caller=T12845;[   1177]  1000  1177 
2790805     1091   311296      770         -1000 AGMIPC@1.0-serv
6,19685438,241227987761,-,caller=T12845;[   1178]  1000  1178 
2729529      728   184320      223         -1000 capabilityconfi
6,19685439,241227987762,-,caller=T12845;[   1180]  1000  1180 
2733357      999   208896      235         -1000 allocator-servi
6,19685440,241227987764,-,caller=T12845;[   1191]  1000  1191 
2846189     1436   458752     2240         -1000 composer-servic
6,19685441,241227987766,-,caller=T12845;[   1204]  1000  1204 
2727196      671   180224      235         -1000 dspservice
6,19685442,241227987768,-,caller=T12845;[   1208]     0  1208 
2729658      730   204800      231         -1000 iop@2.0-service
6,19685443,241227987769,-,caller=T12845;[   1211]  1000  1211 
2711137      713   151552      199         -1000 vendor.qti.hard
6,19685444,241227987771,-,caller=T12845;[   1213]     0  1213 
2736500      619   188416      224         -1000 limits@1.1-serv
6,19685445,241227987773,-,caller=T12845;[   1217]     0  1217 
2879462      680   376832      807         -1000 perf-hal-servic
6,19685446,241227987774,-,caller=T12845;[   1218]  1000  1218 
2716355      665   192512      279         -1000 vendor.qti.hard
6,19685447,241227987776,-,caller=T12845;[   1224]  1000  1224 
2723102      671   184320      239         -1000 sensorscalibrat
6,19685448,241227987778,-,caller=T12845;[   1227]  1000  1227 
2721671      618   188416      180         -1000 servicetracker@
6,19685449,241227987780,-,caller=T12845;[   1229]  1000  1229 
2724735      703   200704      239         -1000 soter@1.0-servi
6,19685450,241227987782,-,caller=T12845;[   1230]  1000  1230 
2714556      690   212992      361         -1000 trustedui@1.0-s
6,19685451,241227987783,-,caller=T12845;[   1231]  1000  1231 
2719859      625   188416      229         -1000 tui_comm@1.0-se
6,19685452,241227987785,-,caller=T12845;[   1234]  1000  1234 
2696944      842   155648      162         -1000 vendor.qti.hard
6,19685453,241227987786,-,caller=T12845;[   1237]  1046  1237 
2995078     7585   630784      808         -1000 vendor.qti.medi
6,19685454,241227987788,-,caller=T12845;[   1244]  1046  1244 
2794803      439   307200      736         -1000 vendor.qti.medi
6,19685455,241227987790,-,caller=T12845;[   1249]  1000  1249 
2717725      810   192512      208         -1000 pasrmanager@1.0
6,19685456,241227987791,-,caller=T12845;[   1250]  1000  1250 
2716504      668   192512      176         -1000 qspmhal@1.0-ser
6,19685457,241227987793,-,caller=T12845;[   1251]  1000  1251 
2719116      700   180224      165         -1000 bbkts@1.0-servi
6,19685458,241227987794,-,caller=T12845;[   1253]  1000  1253 
2722541      890   172032      164         -1000 capacity_key@1.
6,19685459,241227987796,-,caller=T12845;[   1255]  1000  1255 
2707846      680   176128      214         -1000 dualleds@1.0-se
6,19685460,241227987798,-,caller=T12845;[   1257]  1000  1257 
2708255      677   176128      214         -1000 eid@1.0-service
6,19685461,241227987799,-,caller=T12845;[   1258]  1000  1258 
2711954      592   180224      230         -1000 fido@1.0-servic
6,19685462,241227987801,-,caller=T12845;[   1259]  1000  1259 
2710481      700   184320      236         -1000 lcmctl@1.0-serv
6,19685463,241227987803,-,caller=T12845;[   1260]  1000  1260 
2725618      679   180224      213         -1000 omnipotentservi
6,19685464,241227987804,-,caller=T12845;[   1262]  1000  1262 
2735904      823   208896      165         -1000 sensorfactory@1
6,19685465,241227987806,-,caller=T12845;[   1263]  1000  1263 
2718172      694   180224      211         -1000 vcode@1.0-servi
6,19685466,241227987807,-,caller=T12845;[   1266]  1000  1266 
2719481      703   188416      215         -1000 vcustom@1.0-ser
6,19685467,241227987809,-,caller=T12845;[   1272]  1000  1272 
2719993      679   184320      212         -1000 vdtf@1.0-servic
6,19685468,241227987810,-,caller=T12845;[   1279]  1000  1279 
2723293      759   180224      203         -1000 vgnss@1.0-servi
6,19685469,241227987813,-,caller=T12845;[   1284]  1000  1284 
2703323      708   180224      185         -1000 vmediametrics@1
6,19685470,241227987814,-,caller=T12845;[   1291]     0  1291 
2961592     1176   454656     2121         -1000 vperf@1.0-servi
6,19685471,241227987816,-,caller=T12845;[   1299]  2906  1299 
2697201      608    94208      165         -1000 qrtr-ns
6,19685472,241227987817,-,caller=T12845;[   1305]  1000  1305 
2715206      620   167936      203         -1000 pd-mapper
6,19685473,241227987819,-,caller=T12845;[   1310]  1000  1310 
2738504      586   192512      224         -1000 pm-service
6,19685474,241227987821,-,caller=T12845;[   1334]  1041  1334 
3142577     2774   716800     3314         -1000 audioserver
6,19685475,241227987822,-,caller=T12845;[   1341]  1076  1341 
2706117      863   167936      280         -1000 credstore
6,19685476,241227987824,-,caller=T12845;[   1351]  1072  1351 
2752977      846   237568      327         -1000 binder:1351_2
6,19685477,241227987826,-,caller=T12845;[   1356]  1000  1356 2919410    
12170   602112     3334         -1000 surfaceflinger
6,19685478,241227987827,-,caller=T12845;[   1366]  9999  1366 
2730524      662   155648      165         -1000 rmt_storage
6,19685479,241227987829,-,caller=T12845;[   1384]  2903  1384 
2704052      560   143360      209         -1000 tftp_server
6,19685480,241227987831,-,caller=T12845;[   1385]  1000  1385 
2729705      699   167936      332         -1000 sensors.qti
6,19685481,241227987833,-,caller=T12845;[   1439]  1000  1439 
2724369      694   192512      285         -1000 color@1.0-servi
6,19685482,241227987835,-,caller=T12845;[   1446]  1000  1446 
2729910      701   167936      219         -1000 cdsprpcd
6,19685483,241227987837,-,caller=T12845;[   1460]  1000  1460 
2716064      652   151552      223         -1000 vts_app
6,19685484,241227987839,-,caller=T12845;[   1490]  1000  1490 
2709446      626   167936      220         -1000 pm-proxy
6,19685485,241227987840,-,caller=T12845;[   1500]  1000  1500 
2746244      706   212992      273         -1000 sensors.logger
6,19685486,241227987842,-,caller=T12845;[   1510]     0  1510 
2718900      666   147456      263         -1000 atcid_vendor
6,19685487,241227987843,-,caller=T12845;[   1523]  1000  1523 
2909210     1310   434176     1227         -1000 dcdiming
6,19685488,241227987846,-,caller=T12845;[   1524]  1019  1524 8787      
123    98304      280         -1000 drmserver
6,19685489,241227987847,-,caller=T12845;[   1548]  9999  1548 
2729167      781   200704      148         -1000 traced
6,19685490,241227987849,-,caller=T12845;[   1556]  1000  1556 
2716601      863   176128      205         -1000 tcmd
6,19685491,241227987851,-,caller=T12845;[   1560]  1000  1560 
2738738      694   192512      277         -1000 dpmQmiMgr
6,19685492,241227987853,-,caller=T12845;[   1562]  1001  1562 
3184820      366   663552     1983         -1000 binder:1562_2
6,19685493,241227987854,-,caller=T12845;[   1566]  1001  1566 
3120522      131   647168     2018         -1000 binder:1566_2
6,19685494,241227987856,-,caller=T12845;[   1571]  1001  1571 
2744666      396   188416      267         -1000 qmipriod
6,19685495,241227987858,-,caller=T12845;[   1574]  1001  1574 
2762619      843   245760      438         -1000 shsusrd
6,19685496,241227987860,-,caller=T12845;[   1576]  1000  1576 
2727071      719   229376     1649         -1000 vendor.dpmd
6,19685497,241227987861,-,caller=T12845;[   1582]     0  1582 
2721160      705   184320      333         -1000 qcom-system-dae
6,19685498,241227987863,-,caller=T12845;[   1596]  1000  1596 
2711591     1211   237568      262         -1000 cnss_diag
6,19685499,241227987865,-,caller=T12845;[   1598]     0  1598 
2784934      988   270336      267         -1000 vivo_daemon
6,19685500,241227987867,-,caller=T12845;[   1600]     0  1600 
2724012      900   200704      238         -1000 vdtf
6,19685501,241227987868,-,caller=T12845;[   1610]  1047  1610 
2914860      977   573440     1615         -1000 cameraserver
6,19685502,241227987870,-,caller=T12845;[   1618]  1000  1618 
2717339      649   163840      170         -1000 binder:1618_2
6,19685503,241227987872,-,caller=T12845;[   1623]     0  1623 
2709894      668   139264      147         -1000 dr
6,19685504,241227987874,-,caller=T12845;[   1628]  1067  1628 
2725118      788   167936      243         -1000 binder:1628_2
6,19685505,241227987875,-,caller=T12845;[   1629]     0  1629 
2787866     1240   294912      428         -1000 binder:1629_2
6,19685506,241227987877,-,caller=T12845;[   1636]  1040  1636 
2932362     2898   659456     1653         -1000 mediaextractor
6,19685507,241227987878,-,caller=T12845;[   1641]  1013  1641 
2804473     2567   356352      444         -1000 mediametrics
6,19685508,241227987880,-,caller=T12845;[   1644]  1013  1644 
3109046     9492  1183744     1691         -1000 mediaserver64
6,19685509,241227987882,-,caller=T12845;[   1652]  1046  1652 
2847333      765   413696     1245         -1000 mediavivocodec
6,19685510,241227987883,-,caller=T12845;[   1657]  1000  1657 
2799868     1452   798720     2944         -1000 mobile_log_d
6,19685511,241227987885,-,caller=T12845;[   1662]     0  1662 
2724814     2116   286720      259         -1000 storaged
6,19685512,241227987887,-,caller=T12845;[   1665]     0  1665 7472      
139    81920      273         -1000 cameralog@1.0-s
6,19685513,241227987888,-,caller=T12845;[   1674]  1047  1674 
2761770      532   253952      585         -1000 vivocameraserve
6,19685514,241227987890,-,caller=T12845;[   1677]  1000  1677 
2769298      944   237568      195         -1000 vivoperfservice
6,19685515,241227987892,-,caller=T12845;[   1682]     0  1682 
2706257      771   147456      151         -1000 vivosymphonyser
6,19685516,241227987894,-,caller=T12845;[   1685]  1010  1685 
2710831     1019   229376      224         -1000 wificond
6,19685517,241227987896,-,caller=T12845;[   1691]  1000  1691 
2745212      440   212992      297         -1000 wfdhdcphalservi
6,19685518,241227987898,-,caller=T12845;[   1695]  1046  1695 11577      
134   143360      712         -1000 omx@1.0-service
6,19685519,241227987899,-,caller=T12845;[   1699]  1000  1699 
2802069      510   344064      688         -1000 cnd
6,19685520,241227987901,-,caller=T12845;[   1706]  1000  1706 
2737170      700   229376      450         -1000 wifidisplayhals
6,19685521,241227987903,-,caller=T12845;[   1710]  1001  1710 
2834042      396   348160      948         -1000 imsdaemon
6,19685522,241227987905,-,caller=T12845;[   1723]  1001  1723 
2715666      664   151552      262         -1000 ipacm-diag
6,19685523,241227987906,-,caller=T12845;[   1736]  1001  1736 
2730585      501   253952      282         -1000 ipacm
6,19685524,241227987908,-,caller=T12845;[   1739]  1001  1739 
2973999      688   520192     1611         -1000 netmgrd
6,19685525,241227987910,-,caller=T12845;[   1741]  1001  1741 
2719201      343   151552      209         -1000 port-bridge
6,19685526,241227987912,-,caller=T12845;[   1744]  1001  1744 
2751805      630   245760      425         -1000 qms
6,19685527,241227987913,-,caller=T12845;[   1752]  1000  1752 
2722230      676   163840      249         -1000 adsprpcd
6,19685528,241227987915,-,caller=T12845;[   1775]  1000  1775 
2720257      977   249856      508         -1000 sectee@1.0-serv
6,19685529,241227987916,-,caller=T12845;[   1782]  1000  1782 
2698485      637   188416      219         -1000 tam@1.0-service
6,19685530,241227987918,-,caller=T12845;[   1783]  1000  1783 
2713021      705   188416      233         -1000 trust@1.0-servi
6,19685531,241227987920,-,caller=T12845;[   1785]  1000  1785 
2730178      648   184320      257         -1000 wfdvndservice
6,19685532,241227987921,-,caller=T12845;[   1788]  1046  1788 
3056837     2402   835584      945         -1000 mediaswcodec
6,19685533,241227987923,-,caller=T12845;[   1802]  1000  1802 
2743167      708   225280      269         -1000 cnss-daemon
6,19685534,241227987925,-,caller=T12845;[   1804]  1001  1804 3490       
69    45056      124         -1000 ssgqmigd
6,19685535,241227987927,-,caller=T12845;[   1806]  1021  1806 
2737722      683   139264      227         -1000 mlid
6,19685536,241227987928,-,caller=T12845;[   1813]  1000  1813 
2747757      627   204800      276         -1000 ATFWD-daemon
6,19685537,241227987930,-,caller=T12845;[   1827]  1000  1827 
2721526      967   167936      210         -1000 gatekeeperd
6,19685538,241227987932,-,caller=T12845;[   1834]     0  1834 
2725787      949   262144      354         -1000 update_engine
6,19685539,241227987934,-,caller=T12845;[   1840]  1000  1840 
2804911      599   286720      477         -1000 qcc-trd
6,19685540,241227987935,-,caller=T12845;[   1855]  1021  1855 
2733702      721   172032      275         -1000 loc_launcher
6,19685541,241227987937,-,caller=T12845;[   1879]  1000  1879 
2718861      680   192512      239         -1000 trusteduilisten
6,19685542,241227987939,-,caller=T12845;[   1890]  1000  1890 
2735179      706   258048      342         -1000 fingerprint@3.1
6,19685543,241227987941,-,caller=T12845;[   2010]  1001  2010 
2737036      708   176128      334         -1000 qti
6,19685544,241227987943,-,caller=T12845;[   2088]  1001  2088 
2733953      677   172032      333         -1000 adpl
6,19685545,241227987945,-,caller=T12845;[   2399]  1000  2399 6304356   
103581  5689344    18033          -900 system_server
6,19685546,241227987949,-,caller=T12845;[   2620]     0  2620 
2706756      658   229376      272         -1000 thermal@2.0-ser
6,19685547,241227987951,-,caller=T12845;[   2650]  1021  2650 
2756841      402   253952      996         -1000 lowi-server
6,19685548,241227987953,-,caller=T12845;[   2651]  1021  2651 
2783632      491   266240      336         -1000 xtra-daemon
6,19685549,241227987955,-,caller=T12845;[   2652]  1021  2652 
2714264      699   208896      265         -1000 edgnss-daemon
6,19685550,241227987956,-,caller=T12845;[   2679]  1001  2679 
2780150      542   278528      577         -1000 ims_rtp_daemon
6,19685551,241227987959,-,caller=T12845;[   4864]  1000  4864 4203953    
16483  1699840     7812          -800 com.vivo.sps
6,19685552,241227987960,-,caller=T12845;[   4924]  1000  4924 4447751    
24425  2174976    17139          -800 com.vivo.abe
6,19685553,241227987962,-,caller=T12845;[   5038]  1000  5038 4013128    
12628  1343488     7260          -800 com.vivo.vms
6,19685554,241227987964,-,caller=T12845;[   5065] 10135  5065 3951342    
19156  1404928     9351          -800 ivo.pushservice
6,19685555,241227987966,-,caller=T12845;[   5225] 10164  5225 3811078    
10883  1155072     6356          -800 alcomm.location
6,19685556,241227987968,-,caller=T12845;[   5276]  1053  5276 
469605      574   798720     9369         -1000 webview_zygote
6,19685557,241227987970,-,caller=T12845;[   5323]  1000  5323 3867442    
11904  1265664     6568          -800 com.vivo.epm
6,19685558,241227987972,-,caller=T12845;[   5347]  1000  5347 4084038    
21019  1634304     6659          -800 com.vivo.pem
6,19685559,241227987974,-,caller=T12845;[   5364] 10138  5364 3850322    
11300  1200128     7293          -800 qtidataservices
6,19685560,241227987976,-,caller=T12845;[   5373] 10165  5373 3780634    
11483  1146880     6271          -800 com.qti.phone
6,19685561,241227987978,-,caller=T12845;[   5402] 10167  5402 3804832    
10826  1146880     6737          -800 .codeaurora.ims
6,19685562,241227987979,-,caller=T12845;[   5416]  1000  5416 4277328    
31191  2035712     8709          -800 m.vivo.aiengine
6,19685563,241227987981,-,caller=T12845;[   5425]  1000  5425 4227616    
23162  1724416     7495          -800 o.daemonService
6,19685564,241227987982,-,caller=T12845;[   5441]  1068  5441 
3761997     9817  1126400     6913          -800 com.android.se
6,19685565,241227987985,-,caller=T12845;[   5473] 10091  5473 3938843    
18507  1540096    10469          -800 .iqoo.logsystem
6,19685566,241227987986,-,caller=T12845;[   5489]  1000  5489 
3867122     9398  1212416     7038          -800 com.vivo.faceui
6,19685567,241227987988,-,caller=T12845;[   5524]  1000  5524 3863846    
12009  1269760     6459          -800 .vivo.gamewatch
6,19685568,241227987990,-,caller=T12845;[   5550]  1001  5550 4247272    
22947  1937408     7232          -800 m.android.phone
6,19685569,241227987992,-,caller=T12845;[   5556]  1000  5556 3823578    
11858  1175552     6676          -800 o.fingerprintui
6,19685570,241227987994,-,caller=T12845;[   5665]  1001  5665 3797713    
11910  1150976     6418          -800 .dataservices
6,19685571,241227987995,-,caller=T12845;[   5727] 10182  5727 3841492    
16971  1347584     7993           100 id.ext.services
6,19685572,241227987997,-,caller=T12845;[   5994]  1000  5994 3849760    
11139  1196032     5907          -700 gamecube:daemon
6,19685573,241227987999,-,caller=T12845;[   6270] 10172  6270 
3752689     9453  1093632     6430           100 android.smspush
6,19685574,241227988001,-,caller=T12845;[   6507]     0  6507 
2705151      709   163840      189         -1000 qvirtmgr
6,19685575,241227988003,-,caller=T12845;[   6528]     0  6528 
2707216      765   131072      152         -1000 msm_irqbalance
6,19685576,241227988004,-,caller=T12845;[   6594]  1000  6594 3970691    
21787  1495040     6468           100 .aiengine:vcode
6,19685577,241227988006,-,caller=T12845;[   6595]  1000  6595 
2707337      752   155648      192         -1000 qspmsvc
6,19685578,241227988008,-,caller=T12845;[   6660]     0  6660 
3334071      660   651264      957         -1000 thermal-engine-
6,19685579,241227988011,-,caller=T12845;[   7078] 10000  7078 3926560    
21578  1437696     5600          -700 rs.media.module
6,19685580,241227988012,-,caller=T12845;[   7134]  1000  7134 3962506    
18402  1581056     7546           100 om.vivo.apitest
6,19685581,241227988014,-,caller=T12845;[   7142] 10140  7142 3761753    
10636  1097728     6310          -800 .pasr
6,19685582,241227988015,-,caller=T12845;[   7151] 10033  7151 4025354    
12951  1454080     6696          -800 m.vivo.connbase
6,19685583,241227988017,-,caller=T12845;[   7194] 10174  7194 3777638    
20302  1216512     6731          -800 kloadclassifier
6,19685584,241227988019,-,caller=T12845;[   7212]  1000  7212 4390127    
16885  1986560    10259          -800 .vivo.assistant
6,19685585,241227988021,-,caller=T12845;[   7356] 10045  7356 3793362    
13498  1175552     5610           200 du.map.location
6,19685586,241227988022,-,caller=T12845;[   7434] 10039  7434 3850395    
13112  1212416     6104           200 ndroid.location
6,19685587,241227988024,-,caller=T12845;[   7776] 10035  7776 3829372    
13196  1179648     5748             0 d.process.media
6,19685588,241227988026,-,caller=T12845;[   7974] 10064  7974 3879621    
16583  1429504     7570           100 com.bbk.account
6,19685589,241227988027,-,caller=T12845;[  11290]  1000 11290 4027750    
23745  1617920     6907           200 .android.bbklog
6,19685590,241227988029,-,caller=T12845;[  13183] 10060 13183 4312481    
34364  1884160    10552           200 thod.sogou.vivo
6,19685591,241227988030,-,caller=T12845;[  17737] 10290 17737 3771705    
10561  1159168     6630          -800 com.qti.qcc
6,19685592,241227988033,-,caller=T12845;[  26674]     0 26674 
2855625     1234   385024     1119         -1000 binder:26674_2
6,19685593,241227988035,-,caller=T12845;[  31607] 10360 31607 
9162868      517  2736128       52           950 undanmaku.video
6,19685594,241227988037,-,caller=T12845;[  31774] 10360 31774 
4175596        0  1441792       34           950 ideo:messagesdk
6,19685595,241227988038,-,caller=T12845;[  31899] 99297 31899 
393998        0  1114112       73           950 ocessService0:0
6,19685596,241227988040,-,caller=T12845;[  32090] 10360 32090 
4148178        0  1400832       45           950 .video:lelinkps
6,19685597,241227988042,-,caller=T12845;[  21303] 10095 21303 3996490    
13319  1429504     9128           100 m.vivo.magazine
6,19685598,241227988044,-,caller=T12845;[   4050] 10319  4050 
3987574        0  1617920       34           950 j.qimingjieming
6,19685599,241227988046,-,caller=T12845;[  16663] 10305 16663 
4101409       66  1601536       33           950 c10086.activity
6,19685600,241227988048,-,caller=T12845;[  31025] 10246 31025 
4609941     2176  2482176       68           985 achievo.vipshop
6,19685601,241227988050,-,caller=T12845;[  32211] 10246 32211 
8596986      521  2097152       45           995 ievo.vipshop:h5
6,19685602,241227988052,-,caller=T12845;[  32572] 99618 32572 
400671        0  1216512       78           985 ocessService0:0
6,19685603,241227988054,-,caller=T12845;[  24485]  1036 24485 
2749382     3575   331776      172         -1000 logd
6,19685604,241227988056,-,caller=T12845;[  21728] 10133 21728 3915337    
13924  1400832     6535           100 ivo.tws.vivotws
6,19685605,241227988058,-,caller=T12845;[   4546] 10056  4546 4615552    
93448  3645440    17535          -800 ndroid.systemui
6,19685606,241227988060,-,caller=T12845;[   3970]  1000  3970 3797463    
12629  1167360     6245           100 com.vivo.dr
6,19685607,241227988062,-,caller=T12845;[  25672] 10336 25672 
4110999      143  1470464       43           950 dong.hongzhuang
6,19685608,241227988063,-,caller=T12845;[  13920] 10092 13920 9006910    
40735  3063808    11835           100 om.vivo.hiboard
6,19685609,241227988065,-,caller=T12845;[  13972] 10441 13972 
4456166      112  2048000       42           940 cubic.choosecar
6,19685610,241227988067,-,caller=T12845;[  14097] 10441 14097 
4071054        0  1359872       33           940 c.choosecar:ipc
6,19685611,241227988069,-,caller=T12845;[  14123] 10441 14123 
4067877        0  1351680       39           766 io.rong.push
6,19685612,241227988074,-,caller=T12845;[  26183] 10408 26173 
18797428      910  4313088       36           930 Signal Catcher
6,19685613,241227988075,-,caller=T12845;[  26400] 10408 26400 
4207851        0  1695744       37           975 ome:pushservice
6,19685614,241227988078,-,caller=T12845;[  26540] 10408 26540 
4076887        0  1511424       30           940 ic.autohome:ipc
6,19685615,241227988080,-,caller=T12845;[  26855] 99836 26855 
413825        0  1384448       68           940 ocessService0:0
6,19685616,241227988081,-,caller=T12845;[  28454] 10414 28454 
4127185        0  1490944       34           930 qidian.QDReader
6,19685617,241227988083,-,caller=T12845;[  12476]  1047 12476 3135648    
10460  1216512    15288         -1000 vendor.qti.came
6,19685618,241227988085,-,caller=T12845;[  12481]  1000 12481 
3312330     5301  1224704     5245         -1000 cam3rd0_12481
6,19685619,241227988087,-,caller=T12845;[  27984] 10304 27984 
9077026      132  2408448       64           930 s.android.homed
6,19685620,241227988089,-,caller=T12845;[  28522] 99874 28522 
405069        0  1269760       46           930 ocessService0:0
6,19685621,241227988091,-,caller=T12845;[   4886] 10352  4886 
9586767     1235  2826240       79           965 com.storm.smart
6,19685622,241227988093,-,caller=T12845;[   8874] 99878  8874 
376786        0   806912       78           975 ocessService0:0
6,19685623,241227988096,-,caller=T12845;[  26378] 10338 26378 
3834986        0  1323008       57           920 .armorbear.vivo
6,19685624,241227988098,-,caller=T12845;[  26647] 10131 26647 4363307    
21482  1732608     9561           200 .vivo.sdkplugin
6,19685625,241227988100,-,caller=T12845;[   6845] 10367  6845 
8412049      360  1703936       22           920 com.kmxs.reader
6,19685626,241227988102,-,caller=T12845;[   7059] 99908  7059 
399860        0  1241088       53           920 ocessService0:0
6,19685627,241227988104,-,caller=T12845;[   8426] 10307  8426 
9473348     1159  3760128       21           955 m.lianjia.beike
6,19685628,241227988106,-,caller=T12845;[   8830] 10307  8830 
4189347        0  1482752       33           910 ike:pushservice
6,19685629,241227988107,-,caller=T12845;[   9301] 10307  9301 
4132913        0  1445888       46           920 ianjia.beike:vr
6,19685630,241227988109,-,caller=T12845;[   9454] 10307  9454 
4193200        0  1523712       52           910 beike:guideroom
6,19685631,241227988111,-,caller=T12845;[   9677] 99909  9677 
376786        0   802816       54           955 ocessService0:0
6,19685632,241227988113,-,caller=T12845;[  10496]  1020 10496 
2711987      494   167936      150         -1000 mdnsd
6,19685633,241227988115,-,caller=T12845;[  26918]  1000 26918 3999739    
18306  1404928     5832           100 om.vivo.sps:rms
6,19685634,241227988117,-,caller=T12845;[  15288] 10378 15288 
9209126      126  2736128       30           945 .chargetreasure
6,19685635,241227988120,-,caller=T12845;[  16116] 99937 16116 
412294        0  1335296       41           955 ocessService0:0
6,19685636,241227988123,-,caller=T12845;[   5907] 10337  5907 
8998190     1178  2494464       61           935 com.laidian.xiu
6,19685637,241227988124,-,caller=T12845;[   6206] 99957  6206 
401068        0  1224704       56           945 ocessService0:0
6,19685638,241227988126,-,caller=T12845;[  22578] 10401 22578 
8898186      257  3104768       69           910 iang.soyoungapp
6,19685639,241227988128,-,caller=T12845;[  25658] 99966 25658 
402826        0  1277952       72           910 ocessService0:1
6,19685640,241227988130,-,caller=T12845;[  25979] 10248 25979 
9369355        0  3301376       83           925 com.xingin.xhs
6,19685641,241227988132,-,caller=T12845;[  26432] 10248 26432 
2705805      700   180224      191             0 sh
6,19685642,241227988134,-,caller=T12845;[  26710] 10248 26710 
3619558     4142   962560     7233             0 sh
6,19685643,241227988136,-,caller=T12845;[  26838] 10248 26838 
3695711     3153   950272     7956             0 app_process
6,19685644,241227988138,-,caller=T12845;[  27034] 10248 27034 
3645822       32   655360     7258             0 zygote
6,19685645,241227988140,-,caller=T12845;[  27035] 99967 27035 
404761        0  1302528       57           925 ocessService0:0
6,19685646,241227988142,-,caller=T12845;[  27128] 10393 27128 
8400933        0  1712128       69           900 ndroid.haoche_c
6,19685647,241227988144,-,caller=T12845;[  27209] 99968 27209 
376786        0   798720       69           900 ocessService0:0
6,19685648,241227988145,-,caller=T12845;[  28060] 10248 28060 
4286015        0  1695744       64           925 xhs:pushservice
6,19685649,241227988147,-,caller=T12845;[  29176] 10448 29176 
10562919      635  5165056      109           905 ss.android.auto
6,19685650,241227988149,-,caller=T12845;[  29610] 10448 29610 
8571536        0  1884160       93           905 droid.auto:push
6,19685651,241227988151,-,caller=T12845;[  30245] 10448 30245 
61259689        0  1970176       45           905 dboxed_process1
6,19685652,241227988153,-,caller=T12845;[  30863] 10448 30863 
8560389        0  1835008      101           905 uto:pushservice
6,19685653,241227988155,-,caller=T12845;[   5006] 10239  5006 
3784213        0  1142784       49           995 .omronplus.vivo
6,19685654,241227988156,-,caller=T12845;[  11490] 10434 11490 
8786160        0  2596864       89           900 reader.activity
6,19685655,241227988158,-,caller=T12845;[  12135] 99970 12135 
394786        0  1126400       70           900 ocessService0:0
6,19685656,241227988160,-,caller=T12845;[  20709]  1000 20709 3972742    
23695  1495040     5369          -800 om.vivo.upslide
6,19685657,241227988162,-,caller=T12845;[  19550]  1002 19550 
2771930      894   278528      216         -1000 bluetooth@1.0-s
6,19685658,241227988164,-,caller=T12845;[  19880]  1002 19880 4074212    
15680  1671168     5683          -700 droid.bluetooth
6,19685659,241227988167,-,caller=T12845;[   5840]  2000  5840 
2888417     1569   430080     1071         -1000 vdfs
6,19685660,241227988169,-,caller=T12845;[   8646]  1010  8646 
2757236     1251   282624      295         -1000 wpa_supplicant
6,19685661,241227988171,-,caller=T12845;[  24918] 10418 24918 
4145830     1028  1527808       44           768 .miniworld.vivo
6,19685662,241227988172,-,caller=T12845;[   3469] 10294  3469 
9596312      795  2478080       33           764 ebbrowser.wnllq
6,19685663,241227988174,-,caller=T12845;[   3748] 99009  3748 
437598        0  1478656       72           764 ocessService0:0
6,19685664,241227988176,-,caller=T12845;[   4353] 10236  4353 
6108983     1054  4235264       42           762 com.dragon.read
6,19685665,241227988178,-,caller=T12845;[   6252] 10236  6252 
14011426        5  2019328       75           762 dboxed_process1
6,19685666,241227988180,-,caller=T12845;[   7006] 10236  7006 
8685732        5  1933312       69           762 ragon.read:push
6,19685667,241227988181,-,caller=T12845;[  10396] 10236 10396 
8708382        6  1966080       71           762 ead:pushservice
6,19685668,241227988184,-,caller=T12845;[  18536] 10071 18536 4606558    
47365  2543616     6057           200 m.bbk.launcher2
6,19685669,241227988186,-,caller=T12845;[  18793] 10322 18793 
9480091     1119  3235840       45           756 m.cssq.recharge
6,19685670,241227988187,-,caller=T12845;[  19628] 99011 19628 
426647        0  1511424       65           756 ocessService0:0
6,19685671,241227988189,-,caller=T12845;[  20289]  1000 20289 3875119    
18058  1286144     5701           100 martmultiwindow
6,19685672,241227988191,-,caller=T12845;[  22123] 10245 22123 
9271513     3559  3551232       37           752 .baidu.BaiduMap
6,19685673,241227988193,-,caller=T12845;[  22182] 10245 22182 
8909235      867  2535424       72           752 :SandBoxProcess
6,19685674,241227988195,-,caller=T12845;[  22282] 10245 22282 
8350382        6  1679360       57           752 :MapCoreService
6,19685675,241227988197,-,caller=T12845;[  22379] 10245 22379 
4130407        5  1449984       56           752 MapVoiceProcess
6,19685676,241227988199,-,caller=T12845;[  22449] 10245 22449 
4047589        5  1392640       40           752 ap:bdservice_v1
6,19685677,241227988200,-,caller=T12845;[  22550] 10245 22550 
4055372        5  1372160       54           752 ap:remotewidget
6,19685678,241227988202,-,caller=T12845;[  22910] 99015 22910 
427514        0  1359872       85           752 ocessService0:0
6,19685679,241227988205,-,caller=T12845;[  23651] 10245 23651 
4049654        5  1429504       34           752 .BaiduMap:swan0
6,19685680,241227988206,-,caller=T12845;[  24103] 99016 24103 
413455        0  1441792       63           752 ocessService0:1
6,19685681,241227988208,-,caller=T12845;[  24957] 10245 24957 
4029201        5  1351680       23           752 idu.BaiduMap:na
6,19685682,241227988210,-,caller=T12845;[  25301] 10358 25301 
4899558      979  3018752       41           750 com.qiyi.video
6,19685683,241227988212,-,caller=T12845;[  27600] 10341 27600 
18782603      206  4743168       50           748 com.tencent.mtt
6,19685684,241227988214,-,caller=T12845;[  28113] 10341 28113 
4352108        5  1847296       64           500 ent.mtt:service
6,19685685,241227988216,-,caller=T12845;[  29199] 10341 29199 
10569933        2  1921024       45           748 ileged_process0
6,19685686,241227988218,-,caller=T12845;[  29457] 10354 29457 
19186367     1397  3973120       59           744 utonavi.minimap
6,19685687,241227988220,-,caller=T12845;[  29613] 10354 29613 
8584616        7  1794048       25           500 locationservice
6,19685688,241227988222,-,caller=T12845;[  31312] 10354 31312 
4120319        6  1380352       34           744 :widgetProvider
6,19685689,241227988223,-,caller=T12845;[  31997] 10354 31997 
4115941        6  1441792       33           744 vilege_process0
6,19685690,241227988225,-,caller=T12845;[   1383] 10347  1383 
9375065      616  3280896       37           742 om.baidu.haokan
6,19685691,241227988227,-,caller=T12845;[   1703] 10347  1703 
4416757        5  1818624       46           742 du.haokan:media
6,19685692,241227988229,-,caller=T12845;[   1980] 10347  1980 
4100220        6  1392640       40           500 an:bdservice_v1
6,19685693,241227988231,-,caller=T12845;[   2710] 99017  2710 
376786        4   798720       39           742 ocessService0:0
6,19685694,241227988233,-,caller=T12845;[   3835] 10353  3835 
10476998       12  3129344       39           740 om.tencent.news
6,19685695,241227988235,-,caller=T12845;[   4345] 10353  4345 
4147328        5  1458176       26           500 :xg_vip_service
6,19685696,241227988237,-,caller=T12845;[   5527] 10353  5527 
4205844        4  1515520       30           500 s:wnsnetservice
6,19685697,241227988239,-,caller=T12845;[  11310]  1000 11310 3770794    
12931  1105920     6148           100 .doubleinstance
6,19685698,241227988242,-,caller=T12845;[  15623] 10090 15623 3902435    
24820  1785856     6525           100 vo.globalsearch
6,19685699,241227988245,-,caller=T12845;[  23937] 10339 23929 
4757233     3362  2904064      163           732 Signal Catcher
6,19685700,241227988247,-,caller=T12845;[  24604] 10339 24604 4594555    
25641  2314240     8004           200 android.support
6,19685701,241227988249,-,caller=T12845;[  29478] 10362 29458 
10063691       21  3981312      170           730 Signal Catcher
6,19685702,241227988251,-,caller=T12845;[  30636] 99020 30636 
376786        4   798720       80           730 ocessService0:0
6,19685703,241227988253,-,caller=T12845;[  30984] 10362 30984 
4137864        5  1896448       47           730 eo:AgentService
6,19685704,241227988255,-,caller=T12845;[  31282] 10362 31273 
8872804        9  2674688       62           730 Signal Catcher
6,19685705,241227988257,-,caller=T12845;[  32616] 10362 32616 
2726452      876   126976       56             0 logcat
6,19685706,241227988259,-,caller=T12845;[   1722] 10362  1722 
4115111        5  1806336       34           730 .cmvideo:remote
6,19685707,241227988261,-,caller=T12845;[   2069] 99021  2069 
396125        6  1150976       49           730 ocessService0:1
6,19685708,241227988262,-,caller=T12845;[   2173] 10362  2173 
4093289        4  1757184       31           500 deo:pushservice
6,19685709,241227988264,-,caller=T12845;[   2984] 10362  2984 4939      
279    32768       13             0 sh
6,19685710,241227988267,-,caller=T12845;[  10959] 10343 10959 
9732271      351  4485120       64           728 ndroid.ugc.live
6,19685711,241227988270,-,caller=T12845;[  14557] 10255 14557 
8893002      291  2592768       50           726 tv.danmaku.bili
6,19685712,241227988272,-,caller=T12845;[  14873] 10255 14873 
4555035        3  1994752       34           726 bili:ijkservice
6,19685713,241227988274,-,caller=T12845;[  14890] 10255 14890 
4285145        5  1794048       53           726 ili:pushservice
6,19685714,241227988276,-,caller=T12845;[  15581] 10255 15581 
8630499        9  2236416       70           500 anmaku.bili:web
6,19685715,241227988277,-,caller=T12845;[  15744] 99023 15744 
397131        2  1126400       63           800 ocessService0:0
6,19685716,241227988283,-,caller=T12845;[  21872] 10237 21872 
10304862     2676  4505600      160           714 com.youku.phone
6,19685717,241227988285,-,caller=T12845;[  24051] 10237 24051 
2896418     8738   565248     1038             0 libweexjsb.so
6,19685718,241227988287,-,caller=T12845;[  24089] 10237 24089 
4095538        8  1503232      109           714 one:gpu_process
6,19685719,241227988289,-,caller=T12845;[  24142] 10237 24142 
4187932        5  1552384      116           714 vilege_process0
6,19685720,241227988291,-,caller=T12845;[  24695] 10237 24695 
4253788        8  1617920       44           714 u.phone:channel
6,19685721,241227988294,-,caller=T12845;[  25379] 10300 25358 
4932005       16  2568192      233           500 Signal Catcher
6,19685722,241227988296,-,caller=T12845;[  29868] 10108 29868 3872851    
16486  1622016     5587           300 vivo.safecenter
6,19685723,241227988298,-,caller=T12845;[  30954] 10068 30954 3806142    
16608  1200128     5801           300 eather.provider
6,19685724,241227988300,-,caller=T12845;[  31568]  1000 31568 3783753    
14082  1105920     5775           300 catcher:persist
6,19685725,241227988301,-,caller=T12845;[  32377] 10300 32377 
4397498       15  1937408      170           500 :xg_vip_service
6,19685726,241227988303,-,caller=T12845;[    863] 10217   863 3914251    
17831  1708032     5647           300 o.secure:remote
6,19685727,241227988305,-,caller=T12845;[    974]     0   974 
2702874      866   155648       62         -1000 iptables-restor
6,19685728,241227988307,-,caller=T12845;[    975]     0   975 
2697754      702   172032       64         -1000 ip6tables-resto
6,19685729,241227988310,-,caller=T12845;[   5217] 10257  5205 
4844710      448  2768896       67           435 Signal Catcher
6,19685730,241227988312,-,caller=T12845;[   5808] 10257  5783 
4167072       14  1691648       75           435 Signal Catcher
6,19685731,241227988314,-,caller=T12845;[   8137] 10240  8137 9618749    
61152  4202496    11135           100 droid.ugc.aweme
6,19685732,241227988316,-,caller=T12845;[  10480] 10300 10469 
20131863      916  4292608      148           708 Signal Catcher
6,19685733,241227988318,-,caller=T12845;[  13373] 10240 13373 4377743    
30016  2121728     6280           100 .ugc.aweme:push
6,19685734,241227988320,-,caller=T12845;[  13741] 10240 13741 8541586    
38289  2523136     5818           100 eme:pushservice
6,19685735,241227988322,-,caller=T12845;[  13782] 10240 13782 9618749    
61152  4202496    11135             0 #TTDownLoadExec
6,19685736,241227988324,-,caller=T12845;[  17802] 10363 17802 
5502424      891  3489792       86           706 d.article.video
6,19685737,241227988326,-,caller=T12845;[  18497] 10363 18497 
8631963       55  2002944      120           706 icle.video:push
6,19685738,241227988327,-,caller=T12845;[  18529] 10363 18529 
13870011       54  1970176      122           706 dboxed_process1
6,19685739,241227988329,-,caller=T12845;[  18898] 10260 18898 
9236544      108  3035136       66           704 inkan.ugc.video
6,19685740,241227988332,-,caller=T12845;[  21704] 99028 21704 
376786      172   794624       88           704 ocessService0:0
6,19685741,241227988334,-,caller=T12845;[  25050] 10261 25050 4282178    
37475  1986560     5651           430 ifmaker:push_v3
6,19685742,241227988335,-,caller=T12845;[  25216] 10261 25216 4304157    
36501  1921024     5578           430 aker:messagesdk
6,19685743,241227988338,-,caller=T12845;[  27833] 10127 27833 4313336    
58377  2379776     6238             0 om.vivo.gallery
6,19685744,241227988339,-,caller=T12845;[  32382] 10110 32382 3788121    
18194  1150976     6130           200 .secime.service
6,19685745,241227988341,-,caller=T12845;[   4342] 10261  4342 4471356    
54897  2310144     5754           250 .smile.gifmaker
6,19685746,241227988348,-,caller=T12845;[   9113]  1000  9113 3851496    
28952  1253376     5618           100 iengine:persona
6,19685747,241227988351,-,caller=T12845;[   9227] 10128  9227 3837846    
26979  1241088     5661           100 .musicwidgetmix
6,19685748,241227988353,-,caller=T12845;[   9749]  1001  9749 3766165    
18111  1101824     5740           800 lcomm.telephony
6,19685749,241227988355,-,caller=T12845;[   9761] 10083  9761 3801569    
23545  1183744     5538           800 amilycare.local
6,19685750,241227988357,-,caller=T12845;[   9779] 10351  9779 4406817    
49360  1896448     4978           450 tencent.mm:push
6,19685751,241227988358,-,caller=T12845;[   9834] 10114  9834 3753051    
17879  1081344     5657           800 ter.soterserver
6,19685752,241227988360,-,caller=T12845;[   9857]  1000  9857 4012658    
20624  1138688     5496           800 .vivo.smartshot
6,19685753,241227988362,-,caller=T12845;[   9877] 10057  9877 3778757    
20460  1138688     5587           800 ivo.share:proxy
6,19685754,241227988364,-,caller=T12845;[   9923] 10224  9923 4310512    
40456  1769472     4785           704 oid.VideoPlayer
6,19685755,241227988365,-,caller=T12845;[   9940]  1001  9940 3806495    
24348  1171456     5050           800 .vivo.devicereg
6,19685756,241227988367,-,caller=T12845;[   9963]  1000  9963 3767702    
20908  1114112     5270           800 ivo.voicewakeup
6,19685757,241227988368,-,caller=T12845;[  10003] 10346 10003 4108520    
38528  1794048     5014           450 nt.mobileqq:MSF
6,19685758,241227988371,-,caller=T12845;[  10059] 10346 10059 4122361    
42800  1851392     5027           455 encent.mobileqq
6,19685759,241227988372,-,caller=T12845;[  10082] 10118 10082 3779309    
19109  1122304     5195           999 o.tam.tamserver
6,19685760,241227988374,-,caller=T12845;[  10192] 10188 10192 3783298    
25062  1183744     5229           999 agent:amservice
6,19685761,241227988377,-,caller=T12845;[  10528] 10224 10528 
12208149     3544   323584        0           704 libweexjsb.so
6,19685762,241227988378,-,caller=T12845;[  10708] 10063 10708 3759817    
20194  1118208     5218           999 o.aiservice:tts
6,19685763,241227988380,-,caller=T12845;[  11003] 10063 11003 3786045    
21918  1159168     5135           999 .vivo.aiservice
6,19685764,241227988382,-,caller=T12845;[  11214] 10351 11214 4538312    
62153  2027520     4711           450 com.tencent.mm
6,19685765,241227988384,-,caller=T12845;[  11707]  1000 11707 
2880638     8900   475136        0           200 screenrecord
6,19685766,241227988389,-,caller=T12845;[  12845]  1000 12845 
2696244     1019   118784        0           200 dumpsys
6,19685767,241227988392,-,caller=T12845;oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=foreground,mems_allowed=0,global_oom,task_memcg=/apps/in_active_bg,task=agent:amservice,pid=10192,uid=10188
3,19685768,241227988581,-,caller=T12845;Out of memory: Killed process 
10192 (agent:amservice) total-vm:15133192kB, anon-rss:27500kB, 
file-rss:71344kB, shmem-rss:1404kB, UID:10188 pgtables:1156kB 
oom_score_adj:999

---------------------------------------------------------------------

Thanks


