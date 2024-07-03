Return-Path: <cgroups+bounces-3518-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB34925729
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 11:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239AA28A001
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 09:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12471422B5;
	Wed,  3 Jul 2024 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mV3psNEM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hlpju7aB"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB4B13D8B5;
	Wed,  3 Jul 2024 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719999853; cv=fail; b=KX3nEM83OaCOhwXkd5nBhuCQQEsep3rM775+Xi4OLZ3HMXz9haqpvgUfyz0BRq+1UiLpsDd1VrVKuq8sAnuKIMJc2RvlbCbZiOR5Grz3d32bnDc0t9HSSKzQe+A4N0oCd4LLs3p8dmtERcTRWw3mSQF4ICocdBpZ8vVUDTW2rQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719999853; c=relaxed/simple;
	bh=Bw8pAb8JdjkpyHXwvYU8ldTU+bp5irUvb0Q6AgOzDUo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ti4EjTRwND37O1653yRxVriXMuyupJIstKB8dA+JmbnfTNC+HBNDCY4/QYdKa/FvkFO13dHgQxLAx6K1wFk5SukMMC6SvlZiVjYM6E1sjlmVVuEdIGl241+d+Y5AWt6EcK9uUAiB0Is1hTchEp7hSFheLGrqj3mGb+6hovif3ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mV3psNEM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hlpju7aB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4638OLgl012570;
	Wed, 3 Jul 2024 09:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=YqXnxOoxgtzZQbd6IL7iH1CzE9OMlmOiFq7CgoIlDl8=; b=
	mV3psNEMzILgBJ5azbUOGDx6TvH5YVJnXIwvBxzkCt3JVr1NPUIgy0pYj0TeHvUZ
	DcLlGqasnQRUUkhE6u9LN74USpGEIKvNK8rBHMzARsPssc1Y4NQs30HycJCvc0mb
	igiPtDlN+wGdhBIobbhXueGBicj9Ub7bBNhcSAcxRJS4PFeoP07xCrc4EJaqg9tG
	8yPBI/F4UpPLEgA0Uvik7XjsnrxTK0nCieSOqoajcWea3t8k00X6H2UKYjQp5Xm1
	KSAXYqcH+UC9QW56P7xTY627MhcLPM7WjRugtrkJblV+bwYuriWbW0irsXgkUBhG
	l2udFFbJJ7zIbXb8sVIxtQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402922yr0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 09:43:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4638rJc4024927;
	Wed, 3 Jul 2024 09:43:43 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n0ywhcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 09:43:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdU15+lWVXdo7fZzIRa2gBPw9VYsMjoyvOhj1JFUv3lv/fmK6Ww1gIExdwqmHP552+13PyCtGcTCGl7m+CXDeXLzjGWXd33vlie7UqtzfIQpEnmqRPU85ILotBHgC/4QAuV6fPlBGX12odEdfEjfK+sDlSLhiV4L/9KwFFmj8ROc5WwGSMuIMlTNC1dbsue7ENOlU9+oBgGt/D5qep2gVe5NTLfpMZGYagY7a6xgxGKN51VuYtISp8QOlnffdEOcUzhddT+U/BXXXGGmBoCJ+d4NMlfCoCoeO5A/O0XxX3+4jZQAGnQPonkbzNYPLwER7uGIXRgL3EUGlB7zI7Ks2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqXnxOoxgtzZQbd6IL7iH1CzE9OMlmOiFq7CgoIlDl8=;
 b=erOAwP9TIZI336tTYUh10cnTwMuEuoez7EkuwfXSOAXI81ra39L9pa+QaWaMZdIwQ/T+HU/jZ4HF0RRaeaCMM/yUJGbXDonlQcc+mKqFk2O5cPHVK0H8FMOlnjySAOvR2KoF+s16otNe3CM4oWusr3AzcG6EpRCJ+Ajr5ldtuReAekaKlvk+s7cB6342T8thosU5C3+Rhlwe4ruI59N6hGWv3oo29FoeSX68zNif1wUQnbsw/35veXlHMeWnVlAlbwDBVluDiqViiisb9PUW317gUro9lEyDcSGB6QayrUb8uRF3kb2om7j2dPKaujplLYbcfy/2vXQiTqL4z4zleQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqXnxOoxgtzZQbd6IL7iH1CzE9OMlmOiFq7CgoIlDl8=;
 b=hlpju7aBORQ/lhiubLv4KY1UckfF5PZrVhdF0Dl55zt1NhltaM7wrm8LikDvwGnEoTpUSf5RrJNpcUr61AbHq6XuBbwerPAj0VJUISr8hpZGOTFQqCAzYnfYesDQ8TSRb2O4i4YkCHVvhDUYvshfNf57aVDGGXLLZYnv1hGOOVY=
Received: from PH0PR10MB7080.namprd10.prod.outlook.com (2603:10b6:510:28c::6)
 by CH0PR10MB5036.namprd10.prod.outlook.com (2603:10b6:610:dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 09:43:41 +0000
Received: from PH0PR10MB7080.namprd10.prod.outlook.com
 ([fe80::3d6b:7c00:50d4:9936]) by PH0PR10MB7080.namprd10.prod.outlook.com
 ([fe80::3d6b:7c00:50d4:9936%7]) with mapi id 15.20.7719.028; Wed, 3 Jul 2024
 09:43:39 +0000
Message-ID: <cb6bc4b9-bbf3-4d43-aeb8-8efdcbf94a9c@oracle.com>
Date: Wed, 3 Jul 2024 15:13:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 -next] cgroup/misc: Introduce misc.peak
To: Xiu Jianfeng <xiujianfeng@huawei.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
        haitao.huang@linux.intel.com
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240703003646.2762150-1-xiujianfeng@huawei.com>
Content-Language: en-US
From: Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <20240703003646.2762150-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
 To PH0PR10MB7080.namprd10.prod.outlook.com (2603:10b6:510:28c::6)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB7080:EE_|CH0PR10MB5036:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3b3cd6-8983-4f3c-a605-08dc9b449e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?REV1cnZOUHBVM2ppNW16QkpOdzhkUmxLVm9OYVVYYkRHS0NVWkowQzdLRmpn?=
 =?utf-8?B?dEtUb0I1UGFxMWorMEFtaDlrVWFMYzlTdktKUXJSdW9hcnVyZVlSOFo1dHg2?=
 =?utf-8?B?RzFyaFpVSUxDREx5ZFEvN0pxREZNRHB3K3B6aU5uSncwRi9xdTBrTEU2YTla?=
 =?utf-8?B?R3FUYjc3bFZtb1JiU3FBa1RxSlZ2VnZNc2NKa3pMdzJ2WUFBSTlQYks1ZFR1?=
 =?utf-8?B?S3NTZTgrRFMwY0FGcU1CTHUySUhVaVRXODJEdFp6NjU2aUNLMmx2Q1FaQXBP?=
 =?utf-8?B?WHBTWjBwMjlPUCtvVjRSV01IREppanB6MzlRQVl4Q2x2ZmVQSnBKM3RCT3lv?=
 =?utf-8?B?eHQ2a0FqMnMzQmpRdDVaVnNtZE9GcXBMeVlQMEQ4eGtPWEp4dlFKM09aKzFY?=
 =?utf-8?B?RGVZdzZQcVkrTVdzR2FjSzhCbElmc3kwWjRxYWIxRXJGdjdVV2Y4TVFZWm81?=
 =?utf-8?B?OFF5N25YckNhcFpsMVFwQmhQbHJZb2tQN0FRM0dabStLUGFaUFo3WkYxbEpP?=
 =?utf-8?B?TjlxYkxKTmF6eUxHTU1IQmFBemdla1ZnY2tsUnh3b2c1V2VjdGdXV0w4ckV0?=
 =?utf-8?B?NjlEcGlqM1QxVW02NDVSMjhGVXFmTTJVVHVLN2tRTFJYK0NmdXozK05jemk3?=
 =?utf-8?B?eTBMbmxKaWZ5dEdyLy8wdVBGV3BrZHViUTVYS1liN0EzOTN1WTFDbEhoTWZN?=
 =?utf-8?B?RGxGNHhnMlhpR2ppRXlZRS94OUNZblR0cm5FNzgxeXhFYXpGU0R6a2xuVUMw?=
 =?utf-8?B?TWMzbjRUck1BVktmeVFxc1FsZml5TEhPS3p6ci9CdUhiMWdqM2F4UHEyUTNl?=
 =?utf-8?B?TjRKTFhzdTAwUVU4WlN3V1dKbWxhRnJlbFFmUnEzdU1QQkRMY2lIN3dKQVVp?=
 =?utf-8?B?Wnp3NVZ4YW42cmEvbDFzZUhuNHk0dnM3K2VFS1NUUVBDT2dML1VKczVJdGN5?=
 =?utf-8?B?eEcwdVRocjkvM0ZnWEQ2cU9SV3gvWk1KdEt0aGFDZDhHa3lPRXlUNHBLN0pX?=
 =?utf-8?B?blJhTnR3NmwvdW42bVJRbXJQaC96eWtpOHEzelJwZXBnNWdHem16NklTOS9Q?=
 =?utf-8?B?VDMzZFB1UWdEdkNjRDRyYi9kbEYxUVpLS0h2cjdYdlBuOE80VTJKVmVhWkNx?=
 =?utf-8?B?SHZBRVhvNzZZSXkzOWNrVmNmb3ZVRTVTSDJ4bmYrSkdNaStMMGVQdFhpdlNC?=
 =?utf-8?B?dUNWQlFxZEI2aGM1QTZEaDJBeFA4OGJWajZRYkFjREJMQ1hYaExZOTQ1NXBV?=
 =?utf-8?B?b1dzLzJQOWt5bUlLZ2szV0FFVGFMU3RWNkpqRFVmK1p1ZjZCQzJsNm9TdmY3?=
 =?utf-8?B?NFBJNnEyS05ZMlNSVHpDczN3NjVKM0JNaTAydmZseUxZQWN0VEt1OUxIcmN5?=
 =?utf-8?B?QWFheW9sVFpDaHQwWG83NU5STjg4cFMxMng5bUVsWE04YTZPdGsrcCtaL0V5?=
 =?utf-8?B?c1NEaUxFUWFycm5YRCswbWtNT3hkNHhoalVYUmhyZ2hWU2pCYWJ0Q1FHNTdR?=
 =?utf-8?B?VXIwWjJQRWJjalk0RlM4MEhJbWFHQ2NYZEJ6WXVabktaUVorWUl4T1R3R2tV?=
 =?utf-8?B?dHR0MlJWU2RXeXFZV1JuMnFoQnZqSDR6QmhrSDFEUjJ0ZFkrTENYb0FxVmRp?=
 =?utf-8?B?dzV5Q0JkdEtzT2p3VnNsVmlJYkxySXpDUy9xUURMMmFUYmhLeU1YSWYzQ3BF?=
 =?utf-8?B?Z0tZdlRmR3d6ZE9uYXNNWEVKT0VTNjlyNWhBZkROSGs2WW5jZHFDbjNSZk5B?=
 =?utf-8?B?WDdxVFhMejJ5K0RPdFFxOUtpckhqcUYxS2tDZENMVzVycno4ZCtXOEExdUhy?=
 =?utf-8?B?VkVpeWxBQ3RkTmFPc3hxQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB7080.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VHJpSDFucElZUFF1d01jbDhpTnNzT2M2SHJHS3c5OFpxQmxZNTY2dERYZlJq?=
 =?utf-8?B?RmNNNm9ISUxUVXNvU1hGdXJxOGtJQ0hlUXJHRnhmUFN4bDU5TDVjNndZTWZS?=
 =?utf-8?B?bUl3L2pmNFlXWEdtQkE3MEwveWVPSC8zM0dlZHQvUTJQMXJoekkxUkozR1Ni?=
 =?utf-8?B?clljMGw0NFBMbFhMTDdjV0RGWExvWHdzcTVZMGtVWGVlQ1pGM2p3Q0xOTkY2?=
 =?utf-8?B?S3BWUGtWZ1lMSkZaMmdQNWZiRjc3b3VHZWNWZzNUYzFWWFdPRkxQZTdNR250?=
 =?utf-8?B?RnV3SXp4a3A4MVFxNi80RXNKM0I4UVg0WWtFbUY5dUNvVnZlSExzTEx5QnVu?=
 =?utf-8?B?OE43VUxXUURCWW03akNIR2hDb0hNY0dOOVl0dXJBYmNDNnFiSnNCZ1g1UkNz?=
 =?utf-8?B?WFBnUUwzby85cXlRNHVJKzdIT3VUU2M1bm93NDg1cTlWaXhiR1ZYUzdGOGdE?=
 =?utf-8?B?VWxKdmNBcTlrU1l2RHVoVjRYejBtdmRrWXBISnNOcWNPWENOZWhPVHhwU1JO?=
 =?utf-8?B?c3ZjZjJJOG5QUThlMG45Sk84NURJU3Ixa2phcFFuUTRFY0hyNEdJSTJpdVk1?=
 =?utf-8?B?SjdaVVZSd1BtLzF6Wk1GL1hXQmlJSmVLVnRyOElKVW5KK0NRakY0Z0dOUUxt?=
 =?utf-8?B?N1hJQWpML0huZXFoSHVyM3VmVmlHOHZ0RGIwMHdyWCtBUWx2aWVQRzRtTFRa?=
 =?utf-8?B?VXJtdktraUE5V2VNYThIQ3F5N0V6dS9BRHVvUWp6cXNDdTRDTjdTSVoxZlla?=
 =?utf-8?B?OUMyb2QzQWRkQTVld2E1MDN3NXpqTmhrK2JETnVoVkhXelZGNHpKNElnZFB2?=
 =?utf-8?B?UXBIRlBEOERkRnE0R3FtN3l1VzlkY0dheVF1eHVnWHl6Y1BsdDBHTVRtYXVt?=
 =?utf-8?B?VUlXNU1BdVN0VXFyVW8vZ1A2bmZKOVlpTEsyRUtvRDZIR3UzS1MzcGZ3NWF1?=
 =?utf-8?B?UUw4QWhQdFp2RjRtOHdTZWYzd2lUby9ZZzJWN2xVMFM0QUdKMURQL1JVVXh0?=
 =?utf-8?B?TVpjcEZaT1owKzRERXNOaTlYSS9Sakw3MmhrNDFDcy9xaWVrSEMrOVhPeVVP?=
 =?utf-8?B?TTl6OHR6RmpYdjM2VTk2Uy96QnczQmNtdFdxWFM0NTdCVWgrdFFNSFlnTXVJ?=
 =?utf-8?B?elNnZGNhaXNKWncwZ1VZQ0hnNzg5OUtxMjY5NDIyWkNuN2VHZ2xxRVFoclFB?=
 =?utf-8?B?MzA4d2NCdDFSYmUvRmJPdmZSZkxBZGFWR25kT0tLZlA0bUEvUk1ubEpKYkYx?=
 =?utf-8?B?TEhUMFB4akJiQmVpckVFaSswbGZ1SnM1NHRjVjRCcGJwTTZBTjgydjlFcEdN?=
 =?utf-8?B?dkh4Vi9tdFlMVCtoN0o3bk5Oci9RVEdIOUJlQk9ac1RSY00rNkpCQkdkVWRo?=
 =?utf-8?B?bFNXSFFrL2dPbjQvNDVyTURGem1SWkFnYTNtU2M5VzZGVWJBV3BQaUdkUjVS?=
 =?utf-8?B?STIxenFyK29adkh3UjlhcTFWWkhRL051K0hjcVJlbG9Eei9hdFhGVFYvV3di?=
 =?utf-8?B?Z3M0RXIyQm1FOTRHUTJ4bzM1VDMyMW5VMlg0K2NpTUNoV3JtZWNXQ3BqUmJF?=
 =?utf-8?B?ZWtrdS8zMGtFcng1Ti92RXljNGFHbVFwL29Kb3YvT1Vhc2d5YnFEeXZ1alpJ?=
 =?utf-8?B?RlhUbWJsTkRwc1Q5WFprbXJ4RFhxRVJBV09FNXhvRm9qRVZzRTI5RXpJcDQw?=
 =?utf-8?B?T0JZaHUyMC9SZTlTV2hUSVdjR0c0OE84YzBLU2cySW1jQXR0aEd6UithaWxa?=
 =?utf-8?B?bzNHeDh1cnlqcGFjVFMzaDMyckVsWVE4OXVORGI2ZytvNktlT0pTd2dHMEtZ?=
 =?utf-8?B?emxjQ2hodmpMZEFTLzhEZ2g5cHdsZFZRb2NnMkVLS2p0UlpBY3VVUWllQTJF?=
 =?utf-8?B?TkpOWDBadS9UNm1LN3dPcld2UHY1MVBVUDRlT28xRjgxV0dyYU9BSkNkWmNa?=
 =?utf-8?B?YXJqZE9GV0ZKd3Q1MFEwOVVNaTAwWHErcXlHS3o5REpDUlE0NFpuM2RvbFNw?=
 =?utf-8?B?VTBUelNNU0pqUTd1dzlCMloyVVhnd21jbUJ5b3JqT0RFTExFcXdaRHdXamht?=
 =?utf-8?B?TWZzTUY2Rnp2QnU1MEJJTjRxSlA1MXM0Tk9ZT3hZU0pxM2dGNUtrZ0ZJbmpN?=
 =?utf-8?B?N3Q2bmExOEh4VEw4aVhtSU9HVktYNEdtT0NldTlmYUV3NklFSTZFME80cjBk?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lQqvoLPZwiolvMfU0R9AhB1rElwLzfqxiX9CQ/DtmkwAr+u9Ks6x0Eb1YqwrtzbPYZm8BDrVfR/yrtIc+WTKwrVgEED55dAS+DSXzCXVIalzmmR9vnxn0s7nJFh6S7E96J2Vk366vvPPtM8p0/4SKn7lfUACllePHtEkZltYZq7mxGXiMSWzfgL2h4rGQ4OsQOevYdrLrZI+miIhLlutJ3tYSDG0qa7TcNy4SMpt8/+7PMwykL7hZTt4TjwlQb29XtW3jqqft+UbJJnESL+LPuO0j0mZIZGLOw5nvlQ36SvKqQY+986To8ja/b+ORja0FkRAZbpke0WDxSYMrGwroTFhll5eXiJQCddhRUPZQJmrqsrDEz8oKX8LbnXD3ZG3HhCfxNuezv4h0zVJgrrEdqrEkCFB4Huep8efnX62+8Cm+jXQrv919SF6EPQWwB6WqAV/jo1Xe8rrmr2t03uHrJSLMoDil2JBNJwuIyz8PCEKiiT4odNNWF6flmk+BvH/SbLtb/lK5KE2WsdoSSumpWzmyF+mz37WVPsr8KJ0D+ccfdr9U0NKtfW1qyFhJY0hZVIEc1w3LkD2jT0kyquF1njC5vKRCb55kKyPaMNFNcU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3b3cd6-8983-4f3c-a605-08dc9b449e3b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB7080.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 09:43:39.7581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcGUghY3/MFghGNuRuH/1reRC9out5O7kpAHTOGT6O4pYmzrBAM2QwKxr4GTiXMBDGqxfmFKQOZqhnuKWP3Y/rR8GP/XjHpNstFfN3uZVCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5036
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_06,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407030071
X-Proofpoint-GUID: cdBEGEpVT0TgPeiAteJCk6MNaCzHRYxW
X-Proofpoint-ORIG-GUID: cdBEGEpVT0TgPeiAteJCk6MNaCzHRYxW



On 7/3/24 6:06 AM, Xiu Jianfeng wrote:
> Introduce misc.peak to record the historical maximum usage of the
> resource, as in some scenarios the value of misc.max could be
> adjusted based on the peak usage of the resource.
> 

[...]

>  /**
>   * misc_cg_capacity_show() - Show the total capacity of misc res on the host.
>   * @sf: Interface file
> @@ -357,6 +394,10 @@ static struct cftype misc_cg_files[] = {
>  		.name = "current",
>  		.seq_show = misc_cg_current_show,
>  	},
> +	{
> +		.name = "peak",
> +		.seq_show = misc_cg_peak_show,
> +	},
>  	{
>  		.name = "capacity",
>  		.seq_show = misc_cg_capacity_show,


The patch looks good to me after the atomic conversion. Sorry for bringing up
this question so late into the discussion. Given that misc.max is available
only for non-root cgroups,  does it make sense for misc.peak too, available
for non-root cgroups only?

-- 
Thanks,
Kamalesh

