Return-Path: <cgroups+bounces-6182-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAC6A134AB
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 09:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78051888578
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 08:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CE61990AF;
	Thu, 16 Jan 2025 08:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i6dGbyKt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NSCUwy7k"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFF5381AA
	for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 08:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014856; cv=fail; b=XfeppvAnQsJpXSnY3WJ9irhJCgWiixwJp9VZMiRq5/x8Auo35SDJdZEYrvso3suwld0c8XdyxXZFu88Ccsx9RXbMIjYHJGRNCPYhfwn+X8Ktce7jUk0uFibhyYzUIYnedL6B2LzZ6MS+sN1rso3p/8+eF3AKijJMR/m6QHWQFOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014856; c=relaxed/simple;
	bh=tIvJ/BmNgk5tEagzdY/YeD0frvunOOda24ooK9qItYs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rva2GnTNZRT995xHzXAE9GLQNzxNcYg1lGcgAGgZ6EjBEetxTEQkGgeNIf1wTTsxacfiCZ3D62tOuFFBvw1gJJrPvZbcevZt0/3HNJxmsFFNimDvFc3h5ySXmt8tSU9ndPIwpJs2qcG7B563nGwu/tKAdB+lSaLgr+sTWpp6gvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i6dGbyKt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NSCUwy7k; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50G1uF3p015798;
	Thu, 16 Jan 2025 08:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=tIvJ/BmNgk5tEagzdY/YeD0frvunOOda24ooK9qItYs=; b=
	i6dGbyKtb9HGbDMl4r6SfNi32e3u1sqWJfcztk3zTYgOCppC/XY4KX/RPSkj55pq
	2WcM10176obYjdVhD5QKcc3cFWMelN1xoT5BStI1BtvQXumC2T1gytI/n31SL1Pj
	NM7Pfe1McWMPEBiCRym2f+5GZQfoOiVSTfKUAE12eBm0i1Q3DlHQaWNSmHDmhjvb
	kP8kW2Q9FdBvD6wH5IlE/lUGlGQx2mObCujedWNjraaT4gP6Rw+nR7PiLYvJW6I3
	ooRnGuZnCu9dX7qEh8yvtnvh7MEQx0QnuKJZCcE0kbMcz5Ab25FUWdjVoPZvEaG6
	GHrfIZAvxZxAAdNNHpUrXw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443f7y9qh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 08:07:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50G6hQUk032082;
	Thu, 16 Jan 2025 08:07:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3ag6e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 08:07:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVfDos/WEDbdKmIt2BTSAGIw80JG1bneubUJOtP3TP77vLXfMICCVkuzcTkc9yueqwUIi1zWcg+YFFTsXZyINsIB4RBGZmUU6mypcKbs0wauL0UCOwjrn5W3h7V5QkN5dFDuELjDUfjhHVME7C3/1c2FGWSzPch0RDhZclB20C3MFkOivyY0rGp4e7p7QG4cZjqbYg8G27KtkRdIPFPL/neX4c+qLxS7YwPyMqR49vSiDuC3I/wrERCwFKaSKTvGnRzaapFsBb0W+uzkSJgF/7Xai2e8qAx7ro4iSNizA4w/gcKiyXOTmuOZg0x/OuY5ZWn3kPhwKz/9sGpv00HzGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIvJ/BmNgk5tEagzdY/YeD0frvunOOda24ooK9qItYs=;
 b=rIPKEevEoOC7C6Onk8MX2t4WtEIZV0+VEBwpSdfH6P1dA5EIS+NxPxT6YPUsSdUD6mPEQ3l4Sl1QbUe1i6DZTvqaRM5EiXsUuGzWIsNXtMofWceM37VpMz4BzgN2OZkQ4vGS+Tx3WcUP1oIxEreB33Q9DmCHfY0rZqVhlvzGtTmv1G+pels/MQs9eiq4fim9bYM5soVNZRf451pw+jBfTQK2JrVQZTetNAWczBIyj1Xf1wsWAdeRkNmU6gqiFo1trWIkKRaQ4MXxDko+E3V7xeXUKO0iH7Gs4mlgo4wsg6XdcxGsqc2w6uw96K0L/iFF9Hywax9IkYZsZ79amRIRMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIvJ/BmNgk5tEagzdY/YeD0frvunOOda24ooK9qItYs=;
 b=NSCUwy7kBI6Decr82o38DmtHtVO75KAAAClwT4xR2FXhke40sd7FFvHYbe/LocdyWVnF2pD3owW5vVRbNM7l+HzyC8eRNlJQitJiCPs16YeyMMt7WsyhxPqkMugs9efsKlnUuylq2FaqPErO9BEI5NflWDLpZ9MAJqsdihifn7s=
Received: from MW4PR10MB6510.namprd10.prod.outlook.com (2603:10b6:303:224::8)
 by BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 08:07:19 +0000
Received: from MW4PR10MB6510.namprd10.prod.outlook.com
 ([fe80::299:724:f009:e817]) by MW4PR10MB6510.namprd10.prod.outlook.com
 ([fe80::299:724:f009:e817%4]) with mapi id 15.20.8335.017; Thu, 16 Jan 2025
 08:07:19 +0000
Message-ID: <6ee7b877-19cc-4eda-9ea7-abf3af0a1b57@oracle.com>
Date: Thu, 16 Jan 2025 13:37:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [LTP] Issue faced in memcg_stat_rss while running mainline
 kernels between 6.7 and 6.8
To: Michal Hocko <mhocko@suse.com>, Petr Vorel <pvorel@suse.cz>
Cc: Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>,
        ltp@lists.linux.it, cgroups@vger.kernel.org
References: <e66fcf77-cf9d-4d14-9e42-1fc4564483bc@oracle.com>
 <PH7PR10MB650583A6483E7A87B43630BDAC302@PH7PR10MB6505.namprd10.prod.outlook.com>
 <20250115125241.GD648257@pevik> <20250115225920.GA669149@pevik>
 <Z4i6-WZ73FgOjvtq@tiehlicka>
Content-Language: en-US
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
In-Reply-To: <Z4i6-WZ73FgOjvtq@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1P15301CA0039.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::27) To MW4PR10MB6510.namprd10.prod.outlook.com
 (2603:10b6:303:224::8)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6510:EE_|BY5PR10MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: ddaada56-1f95-476d-b27e-08dd3604cc63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0ppd253amREWDFITHNCOEc1RnF2SlZZSFNnSGpta3VWVUMwK2RmYnc5WE5h?=
 =?utf-8?B?VXhIazlUcGVNcXlaSENQTWp5aVE3R0RjK29EUmVTeElrMktVWGNSeEN1VHI2?=
 =?utf-8?B?eU1JVTFTQVRmc3pGaFk0UGtyVjJlQlhlYnFuQkl2TmRJTzA2K2JISTdqcFRh?=
 =?utf-8?B?bE1ReDBTTWIxYmxzeUFwVHV6bkJpUWI0T0NjWnU5U0VQdmg2aWRhRE1XM1NL?=
 =?utf-8?B?WlZkVndDNmkycFZjK1FqSzNHamtlVGpaSHpKcHRvbmtEZGV1SS9oZVlENzFS?=
 =?utf-8?B?Vzh3c1YxOU9vT3A5ZTVDRGF5d0lEVUVNSThBbmowaTVFZ1JJTVNwclltM2xn?=
 =?utf-8?B?Ny92RWhIblR2WmlaclVWQW9PUGF4TUVtRXYxTmpud0xERjFnZXVRTzdtZW9u?=
 =?utf-8?B?Q04xRWMvc01ienp4ckFSdUFMdDhPWndCWlhlTVk0YlVmZDlNZHRGOFNiOE02?=
 =?utf-8?B?R29hZ25ndHRBd2VGZlZXKzhieUp5TFBIbG9rdFVadjlCaTg3Wkl0N3NFdVR3?=
 =?utf-8?B?SzRzNFlXMGdOT08ySGdSdmFXSHFKWWZVL1o2d2ZkYXI3VDNiSzc3dTl5Sk12?=
 =?utf-8?B?TmppMW1ndC94VjA5S1hsUmlGRkR0ZXhBd3RMY0ppRlFPRXRnWFRJUGdLWmNt?=
 =?utf-8?B?SW9LM1VDOXp2aVo2QWx6ZDFQOVh4bEhGYXljNnVQbWxaTEZxeTVrQnFKRWt6?=
 =?utf-8?B?OUF3R3hDSDBwRmFHQ1p0ZitkaFlHVnhVT29KM3ZOSjdraDJ3VGFrcUJEZmhz?=
 =?utf-8?B?NFdmb0ZMcm51RysyUXBVSzVTMGR0ZlJub0dQWlZjK2t4SzBjcjJWU1NCZnpa?=
 =?utf-8?B?NjhTQkhud1kyTk1Yb1ZKS1Bqb0RSbUpxSlBNUFo1NExjMWlTV1pCSVZQK28w?=
 =?utf-8?B?UmtaTVlBaUkrL3pVQ1hiYjJ1ZlJrZzdxMEZqYUlTQ1YvSkh5V0lYdUIveGdN?=
 =?utf-8?B?WHhtOTZtYk1aWGhkem5SMlBRWHg0UG9UMThzMCtoT2dnTmV2U3AwTkFNK3hF?=
 =?utf-8?B?dXBvTnZkSUxBd0w2b0UveXhzYXloc05TWmUxUWZvcHd1ZHpkY3ZQaFhkVzNk?=
 =?utf-8?B?Q0pYWHh5UEpJVldPMnhxdVBrZ1dxT2NDbXVmb05GRWJod3BrMGZpZlJPNTJZ?=
 =?utf-8?B?WjZYK3psKzN1NmlDejBRc09WNThOeVpBeWkwV1Vzdi9wcStkMjlETlNxTE5L?=
 =?utf-8?B?MHdTNGJsdmlibzVZOTdObE5KM3hybVpEOGhvY0pCVnUwcjBCSE1sNVZIbU9N?=
 =?utf-8?B?V3N0Wlhjdnp5UFJpMkJHZUo0RFpXUWpKNm9BM1FOM0tUZTQyeE1FZ0VuU3hN?=
 =?utf-8?B?RU44ZWYvQmVIRkYrd1BWYzlkdTg0c3pmejdxUDdRZGo1STdWK25MVEFGVFlX?=
 =?utf-8?B?RXBHck1hRXI5bWlxUy8vQzZza0NFaWtKUitzN3NBby9TeDJHQm14eDNjMkl6?=
 =?utf-8?B?dERyK0RjeG5BL0haSDZJcTVZUnhrOTM5bWViZDUyOXlYMjVVQm1sc1Yyazkv?=
 =?utf-8?B?cFQzT2tGNWZpUW80V2VVRlZjdWl1akZhL0tOSkxOb25uQXdjaDJrK1c0SEpQ?=
 =?utf-8?B?Vm1SL2QxT1FpcU5QdWRkWEg4RFVGUmlQbVlOT0pSOHloT1ZhQ0kyRktMUmJO?=
 =?utf-8?B?WFFxbmdTaEw5UldLOVk5TCswMTJXS1YrKzZ1TmRZNnBHRFllbXA3MVNIS0ox?=
 =?utf-8?B?VFR2TWd3ZnZRRFdvckRIamNtUkNJZW10d1Q2TUZENGY0NTVycldnRFhReENo?=
 =?utf-8?B?eXNwcFo3MVAyVDJlUFlubkVtOUxTMnUxaEFia3ZBNGlJNE8xNnlhd0VQK0xV?=
 =?utf-8?B?OURnUjFEMysyMENQR3lpK0hzTGtKN0ZTM2Mxd0I5NTl2MG5hdEg3T0NkM3Fa?=
 =?utf-8?Q?jBNmqhvpEG5Nb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6510.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3RKUFhGWjEwK2MvQ1I1RHJScFo2dTV6R3JGUGlwWDdndWhoa2VWRWZPUVA1?=
 =?utf-8?B?VHB2czlKS1NYMFh0a3dod09JRFNwcFVaVmltYy84STFzQSt2ZlpvNmVTS3Rx?=
 =?utf-8?B?QmFvM2l2a1dGcHIrUFVXWldPTkQ3SFdBWWY3SzNsMUVaVHF1c0VPVFZmNzI0?=
 =?utf-8?B?QUdRM3RqempoNWVneG5qQWJHRGVCWER6Z2RHR1NUcFU3WEVxQmYzMzhyenRj?=
 =?utf-8?B?MzFscUV2OFlDOW9EYVcrR0tpQUVSS29VbnVSU0MvT043bHM5VUNjNkswRTF4?=
 =?utf-8?B?SUFaSHRVWUdidlcraC9Gb3lVeng5UXlnMmJQcXFaSjFrOWdBUDhHM3VHQTRW?=
 =?utf-8?B?U2FwanR3WGZFSUROZk00dm9vYU41NGdmVDdkUTlHMC9XNHU2NmRhWkRmTGE5?=
 =?utf-8?B?MFdwZGdTbllhSFlyWUVnUkVscGE0OWhoWUlpNGYxc0pvNCtJWFJpUHY4ZW4w?=
 =?utf-8?B?Vkw0NGRRSHc0K24vbUhjZDRLa1VjWXQzYnFsUVMydU42M3dPMUt3SnhsM0xH?=
 =?utf-8?B?WXJSeFN1aVdzVCtkMHZCZ000ZTYrdWloaG5tLzQrQ2d6aEpiYUE2dEoyWTM2?=
 =?utf-8?B?QkkwN0VyYzZxMHZZbC9EZTZzVlpQd21wNWUzWC9aRUxaR3NGcy9GNVBsM3BL?=
 =?utf-8?B?WE9UQmsvc1BoMjlCWXJBL0hmME5aU1VtTXB3RlU5cjZXRDMzSVF0ZHR4QlU0?=
 =?utf-8?B?eE05YmlNeGk0bm9VbmtxUjFkS3pLYkNFdU5tV3NHajRVVnYxQ2syQTlIWkNz?=
 =?utf-8?B?VllKU0VCSnFHK1V1RFRMbG5Db001a0ZsS1lXY1d0Tkplbkw3RzZGUkFzc2ky?=
 =?utf-8?B?MzkzWTI0VktJNmNCQ1FaZ3I5TjhEQ3ZzZDhuSDg3bVY2Z0FUUkM4UXZFTFRj?=
 =?utf-8?B?UU9GYWQxcXdnQytGS3BabmtnN1VQTjhwRlJkelVYM09yUyt5Y0xDTEpVQTBl?=
 =?utf-8?B?NzNPUDd3V0Q3VWtJQzBhejc0YXAvRXFEd2pySkZvNGY4QUM2dExsWFZZelF3?=
 =?utf-8?B?K0Z0bXYzRkFzWlBXaDFMamluVEoveXlCTWFTU0Z1NzF2djExS2NPaU00NjhD?=
 =?utf-8?B?ZEtCNVpVVlFraVROSWVoRk02c0NBYVJnNEdOVkI4TzVSWDMreHJQdWxKRG1Y?=
 =?utf-8?B?RVJ4c05vV0YyWFkzWWFsZkVpVjRVb1BFTVdtVHhEaHM4WUZjOVBNOHlrUmMr?=
 =?utf-8?B?T3hkK1hiUW44eVhWMFhiRHlpelk4eGNZYmM3VER5dVdqRFBNd1hvRFVDRDJs?=
 =?utf-8?B?RG81L1JFWHpGdHdxVWpvZk53Rjg0YmRaV0IyWVBpVjZUYWcvcitSQk9ieXhX?=
 =?utf-8?B?MG9kUXQ1SGFVRVErNHN6bjZZVk1Va1JHZlJWZ0tsNWZ1RHVwTENBWDR0Mnhv?=
 =?utf-8?B?bjBRWWNCcmpFNFhwanFXamVjTXUxaE5lYW9CTXUvQTRpeWxoK01hQzIrVGxx?=
 =?utf-8?B?Y3JLaS9lb3RvQ3BWRzdTRVBZcEZuWFUxVVlLSE1qcVcvQlROWVk2eWVTK3Fu?=
 =?utf-8?B?NG5nRnF1V0I1R0NuMnJLVkZ5ZVNqeG54U21VcWhWMFZ1QWR5SEdyRG5BTExN?=
 =?utf-8?B?RkRDM0JldnN5SkZzdVk0eUZFa0hpK2pBTXoxYmFUZ2VpbE4ydWJLMlNvWGtl?=
 =?utf-8?B?MjlNUXNleThaVmhLTlZON1ZrMGNRODNqK1RkejVhb1RCTjN2V0RpZ1NIa2xt?=
 =?utf-8?B?dCt3UkdqWEZZZWpnbWd6aGZZZkt4djA4aU11ektWeUJVUHVuODQvQlRiOGI2?=
 =?utf-8?B?QUwxNk5JQ3VIQndTN25kYmM4N2RyVEZGMDFFTmNLVi80cE9JNVpEL2szbitZ?=
 =?utf-8?B?MWNSMVl2UTlqMUlwT0k0K2ltS252OWo0YVhzSkFCdmMraEkxZmphZlB0dGIx?=
 =?utf-8?B?U2N4ekt1QTdQT2d3RzRhRi9YbjhHdlBNQkRoQWozNHl2Q1JEZnh1akJJVTZB?=
 =?utf-8?B?SDJzcnczUjVwSytlZUhTTXpZNXBEZlg1aE9WSS9haURoU2N5VEgvaFVXYVNm?=
 =?utf-8?B?aEIzOXg5UVE1STNjMFJPdU9RcllaN3V6aGFKamFSRlZOVk14ZXRHdVN2Rk54?=
 =?utf-8?B?a0NzdjY3K1ZBZjV2dXJqZG5BWmFrUjdoL2JiU2lKVGg4NFdURVArSlhZUjlT?=
 =?utf-8?B?dW1QUk5paS9pcE9Cd1V4ZXpGNkdVaC9YRm1yckp1T2MwZU9GeWJ0bHhhQkZI?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cZBpKewocKUF8YccZwgEtNjvrr4rus3APvwkdS3M2UfG/f3/ISUt43vBSmurcAY3ppDRcYFdQEYZZus/c6C7Hn7f7wSq95o2a1NlQRbVkNdvFON0c9ApVyNdYkOTbilsU8UGqNZXpHtAITo0OTAJUReMAsii19dY3tLn4Fd3y0spIM47h4pgSrJ47eJFDuwYMAAmmSwK6uVUQLWHhILErWYhCX8xuG170D6Y1Btx5eXhnXXJOLFk0c/CYutttoF18UeT0sjUfw4BNFRhfigMgQYdZV0d0YabgjbV9x/Fxpu4HK/+8RAKxbi6Fln31gpX2ciLGUGJbmV8IjGb9Pw4sU73cf8casxiHRnRqsV/aWoB2ft14Y1Cz5HMk7kGsishLEyEATZ+YdmCfSTfB/CQgZ2Kxyx1fL++1RWSh0a4PohRyp1jsCKaVmgu2Wb9fg7aDQ0Bx/vQMIbTohN4/x4P0MlWJj5s0HKNed4mWIJUAIyGYuoac4mZBkKely+xl8KQNDtDFyfh3rmaUcQg05bipNz5aaCVRx35awp85v/SGHoX2UGgichG4e+wPtOP1KHFnQwoVTooWzGbpf5RwXawsaQt95ajUNrAJvRLYtJU4NE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddaada56-1f95-476d-b27e-08dd3604cc63
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6510.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 08:07:19.6062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6duwwZud9ZlnNmYAg05Fq7jrOhxK24AldPDE3vDhY8cHEfOP0wIULJklLtIJ1dLUeYbwNgsbwpVq65/geotmRQeNbER8AQgilHyV2qI2NI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4306
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_03,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501160058
X-Proofpoint-ORIG-GUID: j3EqMnTMCf8iUFebqanJE_LS2fRacjwm
X-Proofpoint-GUID: j3EqMnTMCf8iUFebqanJE_LS2fRacjwm

Hello Michal
On 16/01/25 1:23 PM, Michal Hocko wrote:
> Hi,
>
> On Wed 15-01-25 23:59:20, Petr Vorel wrote:
>> Hi Harshvardhan,
>>
>> [ Cc cgroups@vger.kernel.org: FYI problem in recent kernel using cgroup v1 ]
> It is hard to decypher the output and nail down actual failure. Could
> somebody do a TL;DR summary of the failure, since when it happens, is it
> really v1 specific?

The test ltp_memcg_stat_rss is indeed cgroup v1 specific.

The test started failing soon after this commit 7d7ef0a4686ab mm: memcg:
restore subtree stats flushing

This commit was part of a 5 patch series:
508bed884767a mm: memcg: change flush_next_time to flush_last_time
e0bf1dc859fdd mm: memcg: move vmstats structs definition above flushing code
8d59d2214c236 mm: memcg: make stats flushing threshold per-memcg
b006847222623 mm: workingset: move the stats flush into
workingset_test_recent()
7d7ef0a4686ab mm: memcg: restore subtree stats flushing

The test log returns this:

<<<test_start>>>
tag=memcg_stat_rss stime=1731755339
cmdline="memcg_stat_rss.sh"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
memcg_stat_rss 1 TINFO: Running: memcg_stat_rss.sh
memcg_stat_rss 1 TINFO: Tested kernel: Linux harjha-ol9kdevltp
6.7.0-masterpost.2024111.el9.rc1.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Nov
15 11:55:41 PST 2024 x86_64 x86_64 x86_64 GNU/Linux
memcg_stat_rss 1 TINFO: Using
/tempdir/ltp-G6cge4CkrR/LTP_memcg_stat_rss.1zrm6X02CO as tmpdir (xfs
filesystem)
memcg_stat_rss 1 TINFO: timeout per run is 0h 5m 0s
memcg_stat_rss 1 TINFO: set /sys/fs/cgroup/memory/memory.use_hierarchy
to 0 failed
memcg_stat_rss 1 TINFO: Setting shmmax
memcg_stat_rss 1 TINFO: Running memcg_process --mmap-anon -s 266240
memcg_stat_rss 1 TINFO: Warming up pid: 9083
memcg_stat_rss 1 TINFO: Process is still here after warm up: 9083
memcg_stat_rss 1 TFAIL: rss is 0, 266240 expected
memcg_stat_rss 1 TBROK: timed out on memory.usage_in_bytes 4096 266240
266240
/opt/ltp-20240930/testcases/bin/tst_test.sh: line 158:  9083
Killed                  memcg_process "$@"  (wd:
/sys/fs/cgroup/memory/ltp/test-9024/ltp_9024)

Summary:
passed   0
failed   1
broken   1
skipped  0
warnings 0
<<<execution_status>>>

It is important to note that the entire test suite didn't even execute
as the second test itself was broken.
The latest 6.12 also shows errors in this test suite upon explicitly
enabling cgroups v1.

Thanks & Regards,
Harshvardhan

