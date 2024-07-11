Return-Path: <cgroups+bounces-3616-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D3592E97D
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 15:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AFBC285C27
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 13:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C12F15ECD9;
	Thu, 11 Jul 2024 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h5snWg0y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gMGM5ljm"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D0C15ECC0;
	Thu, 11 Jul 2024 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720704403; cv=fail; b=AacSW6kICeSteNjZ79+1OA/W8iTfgJ2x6yRlnf6wggQVouzavROv29bBE4Vwu0dwaj8877WjCbQdaU0/T1+5Fcyksc6eYEy0LRAwxu3UvYQgWinoIT+0dii81raxtz/I8gYUa45Hp9n9wYJZeDNnB5tdQ4N0mFKLYL2Nh1Mu9SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720704403; c=relaxed/simple;
	bh=eZUeN7PO9jFk6ZEs5tMqLIuugeLgSC7mr1MCWyR+HdA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kXnkw1/CPLY8aPs2qtGxT0G14SDYMFPlbC70kztqTbiCQQTs/TN2O6em775WpKl4jkvYzzki2wjHmoESz652tdHIUbJBDJ6BhpEE/OTru7qgc7dQwntBbZ5VJ+zRxvDdJd69dxvZ1sJhUBGWsVCT7K6ioYcC96TMHcluTVNbQc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h5snWg0y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gMGM5ljm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7u9qt028376;
	Thu, 11 Jul 2024 13:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=Lz1/Kc2REQ8s+enb3wK5TXWTo+yGL1yt02lgwInosEk=; b=
	h5snWg0yNZSFODTkZEv4ASbVdCwVsnnqzJoCuY4tqDerpqdNyHmnKoEd2dkknB6+
	zYGUOBwbsPHrwygU2AQoLf5bYSzqhV04kLofLhTm+7vdJGKjkJD0MxLnsnQ/tO2G
	43VlfCItH7unm9+zs/gBLMM9P0GkKi2NaZl0BrOzfiWZgdFjoV162HXl3Kc59nWr
	2rbf/ce9BZlUQF9dmCUq4s7TcV2EzyfcdkB9ls/RMJiEfHs8C19nd5aSmYdkkJKP
	q6mIUChW6+OCfHzOlgZkh70f9sOAwLpB/cA+97WdA8YyifwFzXhF69bGd+mc9EwM
	sewgeN1pA9PWX3VyjsmwEA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknsku0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 13:26:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BCZePl008867;
	Thu, 11 Jul 2024 13:26:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv4j2ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 13:26:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jfz5xMXK0lhN7TOjA0g+TArPl/i9DMz2OqOh1enYaLi6/uasxsTocsB52kJr4jcScZIdcIdegdMOvtbcIcJMr+F5cKeUceF5exTrDeY5087B3SUd6Mf2Tzu1NAmiFIhSa0M2thv3BzUee0Br7GXS0PwH8f+iawwVTMtLLyVAgRH95JHEcDM6d8lsuDzTmzAjkysc7AWSWwIqITGLwF/e9JoacUmjwbm2I+9BmHaUcfE8BAXKL/54U4rbypicUQ/K37r5cbWF+wyRCm+EqNaNlBRTeLSVSJE9pZ9z5LhwjDT4NEMVpVMgaq0qNxsDZ0VOthfuoCzOwAXIsR1Q2gStGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lz1/Kc2REQ8s+enb3wK5TXWTo+yGL1yt02lgwInosEk=;
 b=Y/xCfy/O1D4FzK/3Vh8ZBiqqKxS74ppwCTKuhSl5D/nZRTlFRkwXpQuRgDsalM7XaRkb6gAzkmGMC5GRUWQGVcVNJCljH8TmG++7G+keegWOWCSuQ2pIy4M7jQ5Fc9qut2A4O4oGnD2EawHEfaW3+1kgwkM/T2is25Jej3O0fBXPr7aXfo9AO14Dg4R6FlY67lJ+VemmrDCii0eEAYCG/hcxZWte+5plkbXA0jV0xfuuRZfuRPKaPc7p6WVDdEU0FQpKw/7rRxzwoJNdXXEh96jA3urKyy/zsWQsPAke3OBcdMLhFQHq4ns1OF7VIf1smZXj2grWjpsJO2CJFgL9Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lz1/Kc2REQ8s+enb3wK5TXWTo+yGL1yt02lgwInosEk=;
 b=gMGM5ljm8pjX25lzufnsFIguqYXlG9E5mZXK8D42qq32tz5YlaiAzxZFtA2z5nlO0t9g+Iwt6ejzXGeY7gQSpDENry5pBLMSUHDhrwNBhOLYoHpUWKd37fbLy5pMGbhJB7bVSN5vK+n8eKH66rjz5gHoSxGIdMPjywcC/sC+N9c=
Received: from SA2PR10MB4777.namprd10.prod.outlook.com (2603:10b6:806:116::5)
 by CO1PR10MB4642.namprd10.prod.outlook.com (2603:10b6:303:6f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Thu, 11 Jul
 2024 13:26:07 +0000
Received: from SA2PR10MB4777.namprd10.prod.outlook.com
 ([fe80::1574:73dc:3bac:83ce]) by SA2PR10MB4777.namprd10.prod.outlook.com
 ([fe80::1574:73dc:3bac:83ce%5]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 13:26:07 +0000
Message-ID: <e286add1-05a0-4ba1-a9a3-38bfa23deb22@oracle.com>
Date: Thu, 11 Jul 2024 18:55:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup v4] cgroup: Show # of subsystem CSSes in
 cgroup.stat
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>
References: <20240711025153.2356213-1-longman@redhat.com>
 <Zo9Q063eF8CdVyR1@google.com>
Content-Language: en-US
From: Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <Zo9Q063eF8CdVyR1@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16)
 To SA2PR10MB4777.namprd10.prod.outlook.com (2603:10b6:806:116::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4777:EE_|CO1PR10MB4642:EE_
X-MS-Office365-Filtering-Correlation-Id: f579f0cb-4f4d-4044-d4a2-08dca1ad056d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eDF0YTRodWdTd1JzVEtiYjhwMUZyUDdWSTk5NFlDM1p6Z2s5elR5bWE1Ymlu?=
 =?utf-8?B?NEROZExXNTFuQWlKNE9RTURTaXlLR2JSTDNPalFiMlViYXlKb0UrOHljZ1Fm?=
 =?utf-8?B?VnN4aDVlNjRMaDVWMU14dENibTc0YmpOdzAwMHY0eWFvWnVBdUxlUU9iMzR5?=
 =?utf-8?B?MGZpQjFHWW5oRWQyb2FybGhVQ0lleEo0cGhmeWozOTdjWWw4TDJ4QzNudHRv?=
 =?utf-8?B?TnpKcHVMTXhLbFdXdlFDRDkzU2swNFFHTE5jMytTTVdqaklKajI2MXN3Y1Q5?=
 =?utf-8?B?dmRxNzVFWnBNQi9nV1dZc1B1M0Z4Ti9hYTd2d1VVaC9NamZkdzV2MEJmMmJ4?=
 =?utf-8?B?S2JlaUNRMlY4bzdnbHFWRWpZMUFzQjFQNVRtaTZvQzU2a0RxbGNPWkJQcGN0?=
 =?utf-8?B?WlFGUFhHZ3IydTlRVE90cXdzREU0K015NGU3Mms5SVRmNWRkOTQ4cDFCQ3pm?=
 =?utf-8?B?c1JsdGhEdk1veXNJSHNreWRmRkUvZ2x3aDFKbHA3cmMwdmJ3WW1SWkUySDdU?=
 =?utf-8?B?TWFMdHd0N3ova1RNVjd3OXdlSVBaTGtSODdkZmx2M3hxWXRIRy83bUVxZ1Rn?=
 =?utf-8?B?V0x1bytQbmpyQmxlQnVIWHFCZFFkeWFwY252V3U1OVp5U0pUU1JJcDI5NzZ2?=
 =?utf-8?B?azh6Z3ZFSjlXVXJHRjhlU1pJakxFRHZwc2M0UU1iRVFuMHpTS0JTQkdUQk9i?=
 =?utf-8?B?ZERuQkRUMG45bmFZM0tpcFUrbXFtVC9VcUdTRmk2ek4rdGlZejNINFd5R2xU?=
 =?utf-8?B?VmhwcEt2OVNzT21EYW5yYjdaREZIRTl5bUtzSFBsbm80ZVpKZEo1dUpBanZ1?=
 =?utf-8?B?WWlWQklqL3RYMTBUQ2ViS2ttR3pXRTc2ZDczbnlOWjFBU29CQXdkSkZEUkZW?=
 =?utf-8?B?Uzh2U09oUEJ4TElLRTR4UTI5c09wTnV6bGUyMGdYczZGZVUvMXpWS1hLd3BH?=
 =?utf-8?B?NUxUdnkxSTU3UTc0THFJMWZocDBpb20zK1BFakZ3bUQ1VGJLTkdTN3BZU2tK?=
 =?utf-8?B?ZU9Hb282bnJydmhxQlRQYjJNd3c5QWswOFRCeEV2SU9oWVFGcGpvYVNCNXk5?=
 =?utf-8?B?MlpocWNUVGEySk1JeG9OekdFTHBUZmN2SDNtdGJkRDA2TnJCZ0hHT1ZGRjBI?=
 =?utf-8?B?Y2hjeGxXSVN2eGFSZE9EQzZJbm83SlBTMVJrdmZtWjRwaXNkTEVJcnhUa1FI?=
 =?utf-8?B?bE42RDBIeERsWlVOSlRoYmxtUnNEOVdXSGdDWFhkTVNoUVFLaG0rS3NqKzZQ?=
 =?utf-8?B?dEc5NmNXRHcxR1NpejVMek1GY0xHNm8reVBuc3Y1OEM4T3l1VDhTTVM1a2tt?=
 =?utf-8?B?K0tvL1JjQmRGL0RlWEVyZlJXL3p0Rk5sRUNqbmF1NkUvS0xxRjdoSzJaemlE?=
 =?utf-8?B?WitqazFYcXl1UWE3dmdEbGZhUFNBZ1drY1pHblRsSW9ucVFNVFBKbmJLblQ2?=
 =?utf-8?B?THFrR3I5NkhCWGsyTFNhbHF1dXdPNW5TNHZqYjZVd2lKeWpFdm5hdWZwS1hX?=
 =?utf-8?B?bXowTnEvNkhHZlByQ3RtR3lCSGVZK0M2clRvTktneVF6L0ZXWkxzdDNJbWJY?=
 =?utf-8?B?TVhYZHEwazd3VjZOMUZla1B3amFPbFFVSDMrUFlPeGRDRGNxMkJJTWtOYjJF?=
 =?utf-8?B?ek55c0lPMmhRUlBkYUFzaUFPaEsxQzliRUU2YVFlNE9JUmluUFRvVTAwZHEr?=
 =?utf-8?B?aFNBWmJLdGVtYUtjeXZRMkpaMEdBdDVRb3YwMnIzOXJOZHZoOFVDSWpNN0Zk?=
 =?utf-8?Q?vFx/5L9q508870iU10=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c3c3YnhMKzEvbndwVysrK0svTkN0VGdnbWlOTlZ1NSszM09vWnZwcXNlT0lK?=
 =?utf-8?B?aG1VYUtiT09RcngxZ3NESk1kMFppell6VHlZOGd6aDRPYUp4L05VZkhNQlZW?=
 =?utf-8?B?VmVaK0JYRCtaZUFaV3l1WlpyZkwzTEJISXdpYWN2dGVCbGlQdGRrZGdJM2RL?=
 =?utf-8?B?SVE2S3UxdmdDcFord1JaZm93bld4YlNrUkxOczhPTXROcWhBdHV1cGk3c0RM?=
 =?utf-8?B?UGVGUEh0SVpaZHVNMDVRZnhlWm1LVmxlT3M2aXYydGtzeWJ2M3JzK1FBODRZ?=
 =?utf-8?B?SUNqcEJUSDNpckN5WHR5eUp3NHFqbE9YYlZQTnA0M055b1ZLZkRTb2RzM3Bl?=
 =?utf-8?B?WWdWUHdLNW84clZuSElDcnBiUVI3Y1hLL1Q4eURuSzNXcXZKcG9SY0FIMzV4?=
 =?utf-8?B?MEpYb2RYQXIrczB2d3BOeEs5TTQ1elJGRm1PYkZOK3RJeGlEU2JyZURmMUpJ?=
 =?utf-8?B?Vmh2dU5rS2JzSHZXRFluZFNDbCtCaVlpT3F5Z2lTdyt6U2ZGc1UvZFE2L1pF?=
 =?utf-8?B?VjF1S3dkdGVHRVk2SjVyZ245VzVrbVNYditkd2JKVXZ0MW9FMHV5NjJlRHF3?=
 =?utf-8?B?ODBSalVicXRDZVM4eXZaUkUvUVVndGM0eks4SmdVeEdXRVpiV1MwRDhvbGUy?=
 =?utf-8?B?aG01SjhFNmxOaU9ySDdycGN1aDliM3Avenp2cmUxM1p3QU9rMDl4bnZEUERP?=
 =?utf-8?B?SHhTWFZmSHdkQkYzZXd4QkpWZDNhdlRPNDJJU2Z5eTlsbzZFeVNQNmx6MFds?=
 =?utf-8?B?dDlBdUV6b0N3L2tDMjgyc1dQNVoxamJxdWtRb0F0eno3ak9qdWh0U3pzZldC?=
 =?utf-8?B?dmR6UytyT0ZmeUNVTjJHSVN5SHhzSCtzOGRHMkxsaCtvd2xJTEZiNUtlTWFE?=
 =?utf-8?B?SjdmMjk2MEExTzcrV0VLRSt5YVUvZ0pNTzFQVjIydTRseWhqZDZhSldvamg5?=
 =?utf-8?B?d1gyMWFoRGJ6dU92L3ZUOVJTNS9qd1lpdm1zazVSQzExa0VZMFpocXROSEU5?=
 =?utf-8?B?eU1raG8xTG91U1VueEJuaE0rUVI0UDRKVDY1eEZFbGxyMGNXZ3ExM0hnMWNT?=
 =?utf-8?B?enlkZXhxUVNHdFJ5SWY4L2lXUElQR1hQN3ZtZDhna0xBSDlYUmhNMC9ld0hi?=
 =?utf-8?B?eWVQRms1UktHRUhjWlBoaUdlcXFBSXBBUFgxYnBZY3dtYnRhQXZWQkJxaVBP?=
 =?utf-8?B?aVpJWTFnUnYwU2JJRUxUKzFWR0lsdTR6NGpQQmZYKzBCanVsdkNYM0ZmRG52?=
 =?utf-8?B?VlFRWVZrSTdSVjcvMmpFdWJEQ0ZoYzZObGE5SHRoYVRHSTNJMTZydzI0TVN6?=
 =?utf-8?B?bVRrdHpla3J6dUl4K0xDaFZVNTBKSUxaYVlXOFdadE9IK2hCYlRQMmZ2SSth?=
 =?utf-8?B?U2Y0RjRBSmw2ZG9CajJuREFwS20xZ2RhK24yN29rby9YSll1YUdFN2V5SDNB?=
 =?utf-8?B?SHFYRzl3djZndk5xYU5aMXdBZG0rUTQxN2ZTRkNOdDdWeWk5aVhycDdzeUFM?=
 =?utf-8?B?a1VmK0VCSUFEMTNHZjFhRjZQQTYvSjdtay9UdC90dkhlMFp1WTZJMjhMM3dC?=
 =?utf-8?B?Y2FmWWZGcGlQWlNhajI1UElhUmdHSlo5UDlIeVZ1RnhzbWZHT09NSzhIWE04?=
 =?utf-8?B?UmxjTmQ0ajdpb1dZRUc2RHBodGFOWWxPMGJxZm12eDhsRnhMVkNUQW84UW9o?=
 =?utf-8?B?aW1DUnQyZ3A1NllueTBsRXp1U0VzK0Exd0EzVkpzaGQxQU5WdElidTJtbEJV?=
 =?utf-8?B?RVNtdUY3OHJYNmFDci8yVUU2b0JtTXdXejc0em04VW5KNmh4dEZhbFA2TDQx?=
 =?utf-8?B?WXRNdC9La0FkZWpzMTBlNHUyM1dNUlRWcWxsQk1KeE1xYlpjVzZINFRja3lM?=
 =?utf-8?B?blJsM0FVYXhROHpUT3N0LzZVaFJPRE04bFoydkZOcXZWTHMzVGl2Rnh2elNx?=
 =?utf-8?B?amRyM0YzUmlKYk1kNDlCZiszUmtPZ0YwcGZOeU9abzg0KytPaUY1NXdPQkJM?=
 =?utf-8?B?Z3ZBU1ZLaXoyR0ZkeFM3WjE0azRBMVMrYVN4ZktIMU9PRTF5c1ZNYlBUcmJW?=
 =?utf-8?B?MmV0SUI2Q2wrSWtxbFByTEVFdmpIVWVvRnNZNUVON3RjK1A2NHpSY3NRMVY5?=
 =?utf-8?B?aWpIT0RpemtLU2VjSDZSTVlNYXBtRWplRVpsbEsrWGM5bGNndzFGUkVlZERM?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6dhxT6BWRV5qvJ28WFCqXvf8zLmtrGlgEw6fL7aVQQ1X+L/UvL4vYZ1XbmmqNW+bbLcblE7S64vjmX/q7VRF6bpzCdG1mN/JKaLKPHe5LQTXm30NZnFgAKEfQQnH+a3EngzC5RRHuDnbGg+XEzHvocphQ0PHJThevLIqECWBLs6IxTlDXTQX6rIU64Nckf/5QTVROTTUQqw3Rf32nkzY6JoUa75eSLE8WgVF7dF1QYmk11hvNctozKi4Fu6kzuR6uOJpjG1E7LOgbupGSItttmio7izW7JWwNy/3U4FWB4RAWtiVBb0zYnllfPgg+LYz9CwQV1bczWq3pHh/rSBic/zfryuKqvm55Uvj2VYAPN3u0Rln4S0PVh2Ulrn/hrG57uCq/LFF6giYq92ZKc1HaIKz5H1BnBMXJ+cojbZAoy0F3cKD/ICLqsLvO1qNq5U2B5rE/umasvi9MunMOJcc2VXuJarqmRQdp80cm+GsUhmDXVFncA1xbnCZDBQ4ZzprREdba52QOMql0ZSTkp4cp8YuJfbz5R6F6ucJ7V/W7JSWAVOVjnm9NrDEJoRS1ew3jM96stzAqQw9ICbGV2nlsYIXI0Au3Wiaq9yWh4j3of4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f579f0cb-4f4d-4044-d4a2-08dca1ad056d
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 13:26:07.3649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XiEtE/1dphRjkduRu69ZnEIh+RWXJYSbnlIXvjEVLhrD2npbic1rWwjmUcTxNJpKnmOkOD1VotD/uFBL91GX5TYRY/YvcNH09QYxl4npeG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110096
X-Proofpoint-GUID: gwQ1EGo34lPMsIfGpA0ZFb7gFiRXS273
X-Proofpoint-ORIG-GUID: gwQ1EGo34lPMsIfGpA0ZFb7gFiRXS273



On 7/11/24 8:56 AM, Roman Gushchin wrote:
> On Wed, Jul 10, 2024 at 10:51:53PM -0400, Waiman Long wrote:
>> Cgroup subsystem state (CSS) is an abstraction in the cgroup layer to
>> help manage different structures in various cgroup subsystems by being
>> an embedded element inside a larger structure like cpuset or mem_cgroup.
>>
>> The /proc/cgroups file shows the number of cgroups for each of the
>> subsystems.  With cgroup v1, the number of CSSes is the same as the
>> number of cgroups.  That is not the case anymore with cgroup v2. The
>> /proc/cgroups file cannot show the actual number of CSSes for the
>> subsystems that are bound to cgroup v2.
>>
>> So if a v2 cgroup subsystem is leaking cgroups (usually memory cgroup),
>> we can't tell by looking at /proc/cgroups which cgroup subsystems may
>> be responsible.
>>
>> As cgroup v2 had deprecated the use of /proc/cgroups, the hierarchical
>> cgroup.stat file is now being extended to show the number of live and
>> dying CSSes associated with all the non-inhibited cgroup subsystems
>> that have been bound to cgroup v2 as long as it is not zero.  The number
>> includes CSSes in the current cgroup as well as in all the descendants
>> underneath it.  This will help us pinpoint which subsystems are
>> responsible for the increasing number of dying (nr_dying_descendants)
>> cgroups.
>>
>> The cgroup-v2.rst file is updated to discuss this new behavior.
>>
>> With this patch applied, a sample output from root cgroup.stat file
>> was shown below.
>>
>> 	nr_descendants 55
>> 	nr_dying_descendants 35
>> 	nr_subsys_cpuset 1
>> 	nr_subsys_cpu 40
>> 	nr_subsys_io 40
>> 	nr_subsys_memory 55
>> 	nr_dying_subsys_memory 35
>> 	nr_subsys_perf_event 56
>> 	nr_subsys_hugetlb 1
>> 	nr_subsys_pids 55
>> 	nr_subsys_rdma 1
>> 	nr_subsys_misc 1
>>
>> Another sample output from system.slice/cgroup.stat was:
>>
>> 	nr_descendants 32
>> 	nr_dying_descendants 33
>> 	nr_subsys_cpu 30
>> 	nr_subsys_io 30
>> 	nr_subsys_memory 32
>> 	nr_dying_subsys_memory 33
>> 	nr_subsys_perf_event 33
>> 	nr_subsys_pids 32
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  Documentation/admin-guide/cgroup-v2.rst | 14 ++++++-
>>  include/linux/cgroup-defs.h             |  7 ++++
>>  kernel/cgroup/cgroup.c                  | 52 ++++++++++++++++++++++++-
>>  3 files changed, 70 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 52763d6b2919..356cd430c888 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -981,6 +981,16 @@ All cgroup core files are prefixed with "cgroup."
>>  		A dying cgroup can consume system resources not exceeding
>>  		limits, which were active at the moment of cgroup deletion.
>>  
>> +	  nr_subsys_<cgroup_subsys>
>> +		Total number of live cgroups associated with that cgroup
>> +		subsystem (e.g. memory) at and beneath the current
>> +		cgroup.  An entry will only be shown if it is not zero.
>> +
>> +	  nr_dying_subsys_<cgroup_subsys>
>> +		Total number of dying cgroups associated with that cgroup
>> +		subsystem (e.g. memory) beneath the current cgroup.
>> +		An entry will only be shown if it is not zero.
>> +
>>    cgroup.freeze
>>  	A read-write single value file which exists on non-root cgroups.
>>  	Allowed values are "0" and "1". The default is "0".
>> @@ -2930,8 +2940,8 @@ Deprecated v1 Core Features
>>  
>>  - "cgroup.clone_children" is removed.
>>  
>> -- /proc/cgroups is meaningless for v2.  Use "cgroup.controllers" file
>> -  at the root instead.
>> +- /proc/cgroups is meaningless for v2.  Use "cgroup.controllers" or
>> +  "cgroup.stat" files at the root instead.
>>  
>>  
>>  Issues with v1 and Rationales for v2
>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
>> index b36690ca0d3f..62de18874508 100644
>> --- a/include/linux/cgroup-defs.h
>> +++ b/include/linux/cgroup-defs.h
>> @@ -210,6 +210,13 @@ struct cgroup_subsys_state {
>>  	 * fields of the containing structure.
>>  	 */
>>  	struct cgroup_subsys_state *parent;
>> +
>> +	/*
>> +	 * Keep track of total numbers of visible and dying descendant CSSes.
>> +	 * Protected by cgroup_mutex.
>> +	 */
>> +	int nr_descendants;
>> +	int nr_dying_descendants;
>>  };
>>  
>>  /*
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index c8e4b62b436a..cf4fc1c109e2 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -3669,12 +3669,36 @@ static int cgroup_events_show(struct seq_file *seq, void *v)
>>  static int cgroup_stat_show(struct seq_file *seq, void *v)
>>  {
>>  	struct cgroup *cgroup = seq_css(seq)->cgroup;
>> +	struct cgroup_subsys_state *css;
>> +	int ssid;
>>  
>>  	seq_printf(seq, "nr_descendants %d\n",
>>  		   cgroup->nr_descendants);
>>  	seq_printf(seq, "nr_dying_descendants %d\n",
>>  		   cgroup->nr_dying_descendants);
>>  
>> +	/*
>> +	 * Show the number of live and dying csses associated with each of
>> +	 * non-inhibited cgroup subsystems bound to cgroup v2 if non-zero.
>> +	 *
>> +	 * Without proper lock protection, racing is possible. So the
>> +	 * numbers may not be consistent when that happens.
>> +	 */
>> +	rcu_read_lock();
>> +	for_each_css(css, ssid, cgroup) {
>> +		if ((BIT(ssid) & cgrp_dfl_inhibit_ss_mask) ||
>> +		    (cgroup_subsys[ssid]->root !=  &cgrp_dfl_root))
>> +			continue;
>> +
>> +		seq_printf(seq, "nr_subsys_%s %d\n", cgroup_subsys[ssid]->name,
>> +			   css->nr_descendants + 1);
>> +		/* Current css is online */
>> +		if (css->nr_dying_descendants)
>> +			seq_printf(seq, "nr_dying_subsys_%s %d\n",
>> +				   cgroup_subsys[ssid]->name,
>> +				   css->nr_dying_descendants);
>> +	}
>> +	rcu_read_unlock();
>>  	return 0;
>>  }
>>  
>> @@ -5424,6 +5448,8 @@ static void css_release_work_fn(struct work_struct *work)
>>  	list_del_rcu(&css->sibling);
>>  
>>  	if (ss) {
>> +		struct cgroup_subsys_state *parent_css;
>> +
>>  		/* css release path */
>>  		if (!list_empty(&css->rstat_css_node)) {
>>  			cgroup_rstat_flush(cgrp);
>> @@ -5433,6 +5459,14 @@ static void css_release_work_fn(struct work_struct *work)
>>  		cgroup_idr_replace(&ss->css_idr, NULL, css->id);
>>  		if (ss->css_released)
>>  			ss->css_released(css);
>> +
>> +		WARN_ON_ONCE(css->nr_descendants || css->nr_dying_descendants);
>> +		parent_css = css->parent;
>> +		while (parent_css) {
>> +			parent_css->nr_dying_descendants--;
>> +			parent_css = parent_css->parent;
>> +		}
>> +		css_put(css->parent);	/* Parent can be freed now */
>>  	} else {
>>  		struct cgroup *tcgrp;
>>  
>> @@ -5517,8 +5551,11 @@ static int online_css(struct cgroup_subsys_state *css)
>>  		rcu_assign_pointer(css->cgroup->subsys[ss->id], css);
>>  
>>  		atomic_inc(&css->online_cnt);
>> -		if (css->parent)
>> +		if (css->parent) {
>>  			atomic_inc(&css->parent->online_cnt);
>> +			while ((css = css->parent))
>> +				css->nr_descendants++;
>> +		}
>>  	}
>>  	return ret;
>>  }
>> @@ -5540,6 +5577,19 @@ static void offline_css(struct cgroup_subsys_state *css)
>>  	RCU_INIT_POINTER(css->cgroup->subsys[ss->id], NULL);
>>  
>>  	wake_up_all(&css->cgroup->offline_waitq);
>> +
>> +	/*
>> +	 * Get a reference to parent css to ensure reliable access to its
>> +	 * nr_dying_descendants until after this child css is ready to be
>> +	 * freed.
>> +	 */
>> +	if (css->parent)
>> +		css_get(css->parent);
> 
> I think this blob can be dropped: css has a reference to their parent up to
> very last moment, see css_free_rwork_fn().
> And the corresponding css_put() can be dropped too.
> 
> With this thing fixed, please, feel free to add
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev> .
> 


The nr_subsys_<subsy>, nr_dying_subsys_<subsys> format is more appealing.
I tested it with Roman's suggestion, with a simple test of creating,
enabling cpu, memory controllers, and removing 1000 cgroups as descendants.
While parallelly read /sys/fs/cgroup/cgroup.stat as root and non-root user
over a loop. I did run a few test runs and saw no issues.

-- 
Thanks,
Kamalesh

