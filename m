Return-Path: <cgroups+bounces-3621-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A74092E9D3
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 15:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2CC1C23362
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 13:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F23A15EFB8;
	Thu, 11 Jul 2024 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YNGG3Tb7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wUtK+3hn"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1685C1DFFC;
	Thu, 11 Jul 2024 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720705583; cv=fail; b=iTQEGGG7n40uDI57/QcG0QQwJovHF4g4bVXVIHEedGZwnfiUBtrTIFJeeJbPIRqMAux+GsvuhEaGSwU3qpTSXQdpJdw4oFdM+mIVxjaeB20bGHTGsIlDcy0Zl18ETaQqN/9zcEgqAcV70V+wGbsd5dKRx7H5S61oNqLA0vwV3Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720705583; c=relaxed/simple;
	bh=jGwwABYe2PBlR1h72gkGxkImDqp8nBxcJybknINW0FQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OfQiq/Gp86Nrul+gQm8wOaVbvwKA1Dco5wMrQJklAavwrG9PQA6lZAoIua9ISUBnNs/etA6cjoYZWcvX4S0aymNtDQfMpfCivewPVq+MeWVYVfveO9ciifFygF5uCWyEcdAajKm2lS8mloUdX/dXUAMj2uzfufbcTM0Wyt4aYdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YNGG3Tb7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wUtK+3hn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7taip025404;
	Thu, 11 Jul 2024 13:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=WfmgzeadgjbUYDqvYN90WLkW+PJ/F4iYNl+BEFMf9hk=; b=
	YNGG3Tb7i1uO5lsR/aXPX1iAn787+Wf9IM2ziPwsERm/oXa5WPznA2vunGpPaGJD
	HyxghlG1e9nur7lEVgwWaLMDFzh3bBnWv0X3OM+M8zg9RX4vGe+z51uY2wz/Oem3
	lP5MsDAzM7Cxk/hct15ejiuSOln1bT6CRc/Ole4qBO/PxmnbJwiUbIrfYrNm7cxt
	g9TFs5o1Ce9OXB9hhN2yCTylVv0EMBtKIhqHrJ4hdYmeIKxdhL/Ds0CtfXxVwU9c
	fACqS1PHsRHfG/R9yIbZ5fzq7BlPkVwTuR5ZJy/OAHN/HICp8Al0Sj8wKuZFFw8g
	PllPMKUesm+fpy1ptSQd3g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emt0y65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 13:45:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BCBdUe008728;
	Thu, 11 Jul 2024 13:45:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv4jvvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 13:45:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ae/ZT1bX0wuOZT71/4/4i1QDoodwXcM0kSpOkHIC8fjGDTsHdA1T3ykyG1SwHudIFbOADy/LUuybO2x7YSH7K0sGH3qRbZAuTneqqiIZGARuSrxuyFDCewuo5JSnmJxmpHLxXA1DxF2/ytABTBUGl8Ydp8QV8MqXeDeEIwDDhZUSu3ATuCxofrQVOyxXta75K0tfqVdASUYu/QRg63LZDNYphcAXX2k/NkrtbHccQuQl80t7lMM6HUPjYiKFDGUM/K6SSLICnpbfhLfb9rjUbzxecfLIi97sp7Qc9guDiF7/Pm6Pp2n6p8titlxz2iazdskHKZJ+v2BMq4jIlmrHDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfmgzeadgjbUYDqvYN90WLkW+PJ/F4iYNl+BEFMf9hk=;
 b=bAZcxK/1nvjyjyeUYasHB/YkX/LLZZZXDuCOS4SIIuEXNctOTgO6MPc2KFht/fhMKAtjAOThx4UgCY5/MVJOucs1c+XtuSnzX/cz+JIinVsXqe/dDCc/ZjZhMbaqO7VHcLgVCJfDNupXSbW0/l8krVr4VmvSgxPLeLTWaUkmSfnVU8bdRw3dGitK6KKlne1vYC3vLBZ2txWUeAHZ7azDHilKzFxUMaHNhUi/1wN/ESWGxoix/zzaTCb69cfw/eAvCekOycN1RGIk1H26fs0baMj1BExmwWnu/0m6AtBgElvD+2CKZA6U/0NnjLwzECBi7M7iGa515E+dgcsJFl5JcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfmgzeadgjbUYDqvYN90WLkW+PJ/F4iYNl+BEFMf9hk=;
 b=wUtK+3hnAU1H/nivI2YWROdDAgcAiIyg0VUYCM1crn9kmTeIhgPBadUQ9bu9NoM67qy7gZXrmBbj3T82n5ZaLdcBT7oJ8btG9AX8y9oU3BNnibD+ULw9OxBEW7X93EtJETx2LreCbLqAPpeWac8x7c542NXoAj8VA+U9ef0omjc=
Received: from SA2PR10MB4777.namprd10.prod.outlook.com (2603:10b6:806:116::5)
 by CY8PR10MB6682.namprd10.prod.outlook.com (2603:10b6:930:91::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 13:45:49 +0000
Received: from SA2PR10MB4777.namprd10.prod.outlook.com
 ([fe80::1574:73dc:3bac:83ce]) by SA2PR10MB4777.namprd10.prod.outlook.com
 ([fe80::1574:73dc:3bac:83ce%5]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 13:45:49 +0000
Message-ID: <307f7763-765f-4965-b1d2-2897e5e7735c@oracle.com>
Date: Thu, 11 Jul 2024 19:15:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup v5] cgroup: Show # of subsystem CSSes in
 cgroup.stat
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>
References: <20240711133745.2376401-1-longman@redhat.com>
Content-Language: en-US
From: Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <20240711133745.2376401-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:820:c::18) To SA2PR10MB4777.namprd10.prod.outlook.com
 (2603:10b6:806:116::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4777:EE_|CY8PR10MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: b551ac2c-0f8c-4773-41e4-08dca1afc59d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eTdzcmd0dy9ucmg1NkxhZVZFaDdvTzBDMzEwTVRibjlnQnZLcVVMNW1hN2dS?=
 =?utf-8?B?TDZtbzVwTkM2T2VaUm1ZamdCWkpQRjBlWmlYQ0ZWWjM5endHak05SEJkekhG?=
 =?utf-8?B?UUlEaU1IUUU5c0JTQ25BSVZpZy9pMDhhYmtmWHZIOU92YUtjRURZbm9RaFlm?=
 =?utf-8?B?N2VQTmVCL1lMYVM2WW9XcWJyVFQrazR1S2dGT3RXN3JTbU01U0JYTVlsYmM1?=
 =?utf-8?B?ZWx1bDNtb1QvSlVnWWFuUVExRitBVktnS2tjL05LN3dsSnBKRkJnNTl4Q0ZC?=
 =?utf-8?B?MU82Q2F1N28rOVZVTHd4VlhOMy92cnFYQVAyT2kxYndGZ1JQY1RTbHdad1Fr?=
 =?utf-8?B?NmZvVy9VVS91ZTJaK2I2MzZvOVRkeEFXV3JHcEhKUGlyN1NmMUltdVpWdjJG?=
 =?utf-8?B?OCtsRjJneWszWVg4ZnhrTXdqZXI5RytlTjRjb2lYRU5UdExyN1dvVjVGZWpu?=
 =?utf-8?B?aC9WZFVCM2VoZU1qRTlWOTdTWjFuK2hENER0by9lK1AvN3J0SzhvZWcvU3hk?=
 =?utf-8?B?TGk0aU1lN0Z2RDFocmRVU1hoTHB3V1B3TEl5Tm90c2UxWHFEdkZjcUVSdnZJ?=
 =?utf-8?B?SFBObDduZ29GZGFiRkFUWWpwa0JQQUtNTUM0TG9WOFhRS3FyQnFiT2xkSE9B?=
 =?utf-8?B?VnBXemVGeVgwb3pybngvaW1yWlZRTjV6NUQ3a3JpNHk1S3lZbUNabDk4M3Zm?=
 =?utf-8?B?cUV5V24zZzNFRWYveUxQUnNWNnllSmx1ZG8wOFlBUnJkbWdrL2tqcE5sUEk2?=
 =?utf-8?B?SHRBRW5zWU9rVzNvVndZdlNZcjhpL2RCRkltTndsWW5yS2p6MXIxdmZFdU8v?=
 =?utf-8?B?NEZRL2RVZVBZWTNiRWtva3BnL3JtdDdZVTJMa1YyWEFEMTZtUkFwRE9lZ0dk?=
 =?utf-8?B?RHpqbnQ0VUQ2Ry9wK0V6Mi9nbW5MNUJmcmxHU2pQaTF5cXI5d0FpNTZvaEJl?=
 =?utf-8?B?M01yeDBkVWN4OEkwYmgwdEZXRmRtYW0xcTNQalc4cDgyeVQ1Ry9EUk5NOTRK?=
 =?utf-8?B?RUxSVU14djNvSFNBM0FWZUVvdWNncEthdHBxL3h1cGN1anV6ZkFHeGYzdElQ?=
 =?utf-8?B?YjlpVmNINHRuZnFyaWY4a3NtdnFCbFpMZ3NuMkxZQzMvcVNWREFDV0tYelVM?=
 =?utf-8?B?djJjVm5KYnFSd1gxaFVSVjJJRGZ5Mm4xZ0xmRDlqbHJkUW55aW5jbktaRlpH?=
 =?utf-8?B?b3grU1NGRG5pRitWNDAwcUdWcnNOTS9nVWlBUE1lSnpNLzdub1E3UnduU24v?=
 =?utf-8?B?UlZoSkdhT2VyODlpMHY5djJlT1RGclpUWmRCVVRROUhtZ2w5V2tVbXNSQmNJ?=
 =?utf-8?B?TkMycmFLYm9wc1FnSG84dWZuSnRrSFQvRHBSRThhRTdQaDNrMXovRXRqVnp2?=
 =?utf-8?B?Um1EUEUzY0swMDY0RUpLTXE0VXFtbzIzVnFBL09NN05nZk9HbzZGbjVNczhn?=
 =?utf-8?B?OHdTUm1EbmNocWZqV1ltWWw4SVU4c25ZTWxLVTQ4dmQySGt3bk84eGVZMWhm?=
 =?utf-8?B?bnRhSmMvMU5jbDZNYUREc0tEMEs4aVY5OXRaNzBCWmI4cFpwQk9wZ085ajh0?=
 =?utf-8?B?MURFaFFhc2dzSWlNeWZ5Y29Hd0dUdXFmMnhva01kNnVLSURRUXRRT3I1MkQv?=
 =?utf-8?B?bFdCSUl4bG1oNjVmbXN2SEpUNWEzWE96cVZ4eXdPTklNL0g0b3VoaTJwVndI?=
 =?utf-8?B?WExrb1Y1RXp3eHVsdlBYbFR2WW9lUkVnNXBoa0hJUk43WDBURm1WRlY0bTM1?=
 =?utf-8?Q?wECHBttRpm6IXjDtwk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TTNwR05qN1ptejJhRVRDcXYyTCtnSGtxL1dVNExtN1cyUVM1dGFXVmZQaUZk?=
 =?utf-8?B?WXM5TkNzVk9PQXRCa1pTVi9SZnVtTE5wZXFnVGlCWVJEZnNRTU0yOVg5a2Z5?=
 =?utf-8?B?U1BpNzJGVGQwanZBYXVVcHV5czRPdExrbFBaMjBldXhIekVKbjhVaFNhYVJp?=
 =?utf-8?B?QTkvRlJNM2J0dVo1MG5LYWdpQ3NleHNKYVZOemd3UThrYi9QZjc0eWUyUWZa?=
 =?utf-8?B?ZWhIcU15Nk9BYVdHaEpGMjNrMkVvRVZWUHk4NEU0UkRSN3ZlV21Ra1NGQ1Az?=
 =?utf-8?B?Ym4vdWZXeDIxaVV2WVhvemFmVFA3OHBFTEtpbkNtdUIraG1TdG9tT3p1cVRT?=
 =?utf-8?B?bTdXSGNUWGl5S2IxL2JEMHJtSUxlbUh6Z2xiNUIydzZoakIrakRnVklaMG9H?=
 =?utf-8?B?ODczbHJ4K0kwNDUzUnI0TXlzRVJWL3lmM1ZJSklZaVJudnVFRjQxd1VBQlFC?=
 =?utf-8?B?OTBGTnRHMzByUHlud1hxbmUxUy90UGJUN09UaWcvdzcxb1Q3dkIrd0pyQWpO?=
 =?utf-8?B?N3dRNldTeUNhS29mMXV3RFhhWmJvYnBIOG1ZdkRHRVpUYzFzY3lxd21ZSCtX?=
 =?utf-8?B?SzNpc2M5YmpPTzVhSUp6N0lDQ25kb01mc2ZzOEYyVUZSaFV4MTVZamJ2R2pD?=
 =?utf-8?B?c2MybnJxZHVmYUNra1BBakZERSt2KzBqUVFwQkwyUFJIVnh3VVJBbytRSFFH?=
 =?utf-8?B?QUNNbkNHbXl3emFXUGlTZndZN0VOL1JJSTNCUnpiNVY4TGh3S3VBZVgrYTI5?=
 =?utf-8?B?dUNwK2plVHpoSVEyZ0hISHNXemtjUDBxN3AzUml4MjF3TjFGdjEwKzlETkNW?=
 =?utf-8?B?ZTA4UG5QclRxampYbEJldGx0elpLZ0RKQzNBdm51eGY3d2xNYUpJVVdMNVUw?=
 =?utf-8?B?Mk9KM3IybXVJT2tMUENzVFFiaDY3bkNiUk1ycEhzVVBCdXp2cllYMWJGZkVT?=
 =?utf-8?B?aU5GMWFTMmx4bzhNYUZ1QWo4Rk9zRXl0RWsrbkxLdmgrV09ndng0UHIzOEha?=
 =?utf-8?B?emV4eDFYQ00vK1NnRmYzTk1idWRNM2ZnSnB0YzJFVFRHcHFPTG0wRnlWeVBZ?=
 =?utf-8?B?VHc5bjNsK3dGM1grT2ZtN3Q3dDNBMWNwVmpFMXJ6b3hxdW1mV240NDlPUlBN?=
 =?utf-8?B?SndHcEtJQjlHWnpJNkhJOXErQWJrQ09zYTFUckdFMFdZdW1SZHpZbndzVzZn?=
 =?utf-8?B?NkNqOWVuT1F2T3dXSmYrL00rWmlEZGxUK3BHanVpNzRYcnpGamQyK2xjZ2NE?=
 =?utf-8?B?UEJraWZYbnJpRWY4QkdwWGkwMzhVaTFMaEdtSmJHMUZQbDlxbjZINjA1MVRY?=
 =?utf-8?B?UEVKWDlPUTN2TktQWEZ6QWdVWW5lc0ZOdDNYb0RFVmw1ZnFGdDZNMXZmOWdC?=
 =?utf-8?B?YnMwaWtsN3hLOEhXZXZHVEc5dkNraVVneGRUUnBjTWlLTDZGNHgrUFJvbkJ2?=
 =?utf-8?B?blFHcmN2U1UzckhXMFlXVEVicWQvNWR0WEI3b21OQVRyYmlYbzkvWWxaRlli?=
 =?utf-8?B?VHhsc0I0S1JSQTF1a3ZRSnRGQTh1MjluSHR1QXB1b1JwcHZCUk5pSXVmYTRa?=
 =?utf-8?B?UnNqY1ZsNVNsenNaQjdKR1RIWVMrWlFQTkVhUk1vRDV6N3E1ZGhzaGVVNnZU?=
 =?utf-8?B?cnBZc3NKcGZCeU5wanRCQmNUZGtlSTR0TFMySDVWSFQ5K1dRWmJJRHFVR0ty?=
 =?utf-8?B?ZUtzZXpoa2J6QkRmSUhYR2hYOHIrQjR5d1Z4OXBZc05KZitqbEdMZ21qNGs1?=
 =?utf-8?B?ak8wRXBGMjB3bTNwM0p5citYVTlxSlJXSjduK20rN2xhcHNabE43ZGtZY1pM?=
 =?utf-8?B?QnRuSUFmQ3JxYnZJeFNPSldNVVJHaHU0eXgxMFBXMDdxR3pXQlBOalhscmpJ?=
 =?utf-8?B?VjJqeTJFZ29LSUltOUczbDlvR1QwK2ZKbG5ON0FOYlI5WjJLTUFicXJ4ZGo3?=
 =?utf-8?B?TTR5alpsbkRtV2hEUVdxaFdNSHpNWEdZU0w4VUlrT2ZjWWkwZTFNaWgrOUhu?=
 =?utf-8?B?amRkR1Njc0NGSGQ2SG4rQUl0VTV0TkpRMkIzUEZ1UUtocStqU3ZwaDEvb3k3?=
 =?utf-8?B?bFF2U3B5cDJEZWZwWTE0NHBEeEcxUnExNGRLd0EvRWg3OE9lZHh3dnl5by9k?=
 =?utf-8?B?Zm43dE5Ydmg3N3dJbjNCa2tabGZxUGhNUXFaMnR3Y01uVzJFdVJ2TFFvaG5W?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	68GWUIhEYFr2TEjdR331KA4yjpKSN+Hz4bhoJzQF0pncUs1MYBI/SH15YghkM/5fv4j7Uhq1BTUC0uLS6X/pBSsNQEov3T5Ods17ygNSyeamH6hq/MGaBDDlLSVEZdVaUttbY+qcYWVf4NfEbKXb3LqWRyU16MaCliZT3ojOErT+FiZrS0HDa9EZZJa8GWN4q4kK06FjZa8MOsLV6pohcUfinu/lLIvI/IoGZ7xLWrAGQrwDnKIaKrKYUE5PhtIIfPQeK+ZHqbl13fumc2zWmCSCOY5AeW+qkJP5DGI45wHklOqNGmQi7soAEV5pVqynpjO4q5kF88T7uBr1Xb/0z/gGMqI/PEz+GGV0Mq+EEw6Efwrb6amjz8wryySVAzAij6BoARDIR/aRuejTm/Q+mLUTgFaSPmZSyUecZJQsKOPJQDNLTkAENXA71wpCN3PTmTcLwrKL4UNWeeKGednSEKo6MPGyOtrsPv+YacUEH0dbCG3rle1ZA9xpb++31XitO3Mch8BPnfK2ij9d5i2Iq2o5h9IFWUf3rU4Q2WkzutURb7bl6o1ELKO/TBqhXgMvgFkiWr2qT/Mf8wQ0g4kKLNfU8J8NhMoTOhT4+/2vT8s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b551ac2c-0f8c-4773-41e4-08dca1afc59d
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 13:45:48.9833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFguRpm31TxBqtx4pcutTFtUTUBHCZdaOfnTmL9ThGuMAZWq9INNYzUNOWURckB01MqeDorqjnsiBCxuDHLqcDwxyaZX7xuR+OoIMV6kBNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6682
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110098
X-Proofpoint-GUID: bmJzqp7_zK509qNuvFIW3EVSbFGTpc2U
X-Proofpoint-ORIG-GUID: bmJzqp7_zK509qNuvFIW3EVSbFGTpc2U



On 7/11/24 7:07 PM, Waiman Long wrote:
> Cgroup subsystem state (CSS) is an abstraction in the cgroup layer to
> help manage different structures in various cgroup subsystems by being
> an embedded element inside a larger structure like cpuset or mem_cgroup.
> 
> The /proc/cgroups file shows the number of cgroups for each of the
> subsystems.  With cgroup v1, the number of CSSes is the same as the
> number of cgroups.  That is not the case anymore with cgroup v2. The
> /proc/cgroups file cannot show the actual number of CSSes for the
> subsystems that are bound to cgroup v2.
> 
> So if a v2 cgroup subsystem is leaking cgroups (usually memory cgroup),
> we can't tell by looking at /proc/cgroups which cgroup subsystems may
> be responsible.
> 
> As cgroup v2 had deprecated the use of /proc/cgroups, the hierarchical
> cgroup.stat file is now being extended to show the number of live and
> dying CSSes associated with all the non-inhibited cgroup subsystems
> that have been bound to cgroup v2 as long as it is not zero.  The number
> includes CSSes in the current cgroup as well as in all the descendants
> underneath it.  This will help us pinpoint which subsystems are
> responsible for the increasing number of dying (nr_dying_descendants)
> cgroups.
> 
> The cgroup-v2.rst file is updated to discuss this new behavior.
> 
> With this patch applied, a sample output from root cgroup.stat file
> was shown below.
> 
> 	nr_descendants 55
> 	nr_dying_descendants 35
> 	nr_subsys_cpuset 1
> 	nr_subsys_cpu 40
> 	nr_subsys_io 40
> 	nr_subsys_memory 55
> 	nr_dying_subsys_memory 35
> 	nr_subsys_perf_event 56
> 	nr_subsys_hugetlb 1
> 	nr_subsys_pids 55
> 	nr_subsys_rdma 1
> 	nr_subsys_misc 1
> 
> Another sample output from system.slice/cgroup.stat was:
> 
> 	nr_descendants 32
> 	nr_dying_descendants 33
> 	nr_subsys_cpu 30
> 	nr_subsys_io 30
> 	nr_subsys_memory 32
> 	nr_dying_subsys_memory 33
> 	nr_subsys_perf_event 33
> 	nr_subsys_pids 32
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Reviewed-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

-- 
Thanks,
Kamalesh

