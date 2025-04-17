Return-Path: <cgroups+bounces-7618-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA357A92276
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 18:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F671889E62
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 16:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD1E253944;
	Thu, 17 Apr 2025 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oVdKD6+N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ihUxsKR6"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADC122371B;
	Thu, 17 Apr 2025 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744906581; cv=fail; b=dicmHG3N9L/+NsIxgorNil2SPd1R/Vq2sQtTjFr3hjXwwUQQ5gB+4teDHqeHvSi822uk870bQOxe9cO9P8SJ52nkmmD2BYWBMgKgk8PICInuTedpfsglaUjz5tpNlilfkviRIB3jwBWTUvCTykEaqfx4bbT6I7+WHc/2MFypi4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744906581; c=relaxed/simple;
	bh=fha0uhpxXRp/fm45KOCuJ4pBaEgmrAiggQ3XLLnVsVg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pDuPmu6PdKTMLW9YRk5PGnZapd4V32ZwLSOHPKREb7nfCDR8TqNTahyqMC3qqWBB5NWL+UmJKmjNUnaKmSljHnV+EZbs+LQcTmQCn0mYI5BU+byZumDo+Bac99z0VpW+Y9TgcQAUXwQcf1BFwJUBORiuNUXXyY7ImnHCfMpTgMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oVdKD6+N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ihUxsKR6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HBpiXW005222;
	Thu, 17 Apr 2025 16:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=d1+h/aKetLDSc5qRJD5Cbl9CY2X1iX1TJ/FI4Z7Z7/8=; b=
	oVdKD6+NcSLJUeT7g+NNB8SQa06rLIxcLa7i9jMzSAdDCCr1d1yDDj/9QSOsugE8
	jKru13RTpXqf4qjJZRgYhDCRMAJ5cW8DfDoHsiZkYnH9QgsjAp5+D0/Emf7S053J
	EoAlCIpWgV9BKJBM0C5hz8DMeJY+RlVlFoNs+xG42mOC3PONFTOffdAmNDkRZcJz
	f08/YOAN1Bb5E8gOedpqZ32C3G9kdbU6bhtnxbZ9eeJO/KQlSuLzeXnyE42XvSSU
	gm+2Kzm4GUE0qN0QbEX86HQu3rJHjwoIugwkypk6fWqR5GjUDpkO3Xd9FUagjO9j
	IBNR6Qs6EK2zUfaZbmM73Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4619446ms8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 16:16:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53HG7CgF005732;
	Thu, 17 Apr 2025 16:16:08 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011027.outbound.protection.outlook.com [40.93.6.27])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d5yq01q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 16:16:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlvF2jR+GS/DrefU6eaJEHIHOondFEKhZvOB5ikwKlZ6222J5IEFaKextBqEESV56sZ2XecHwZL9t8dZe62yvzIwq40r7NxoqDh4mHAMhqh9kgRA82kITaj1yb0esc/KwVR3iP9HnXfhU+LUkFc+BoqwxjWc9Hd4JeqEF884ZAS+ZYgUPlzed8uOum+EbvTXFdlXnWvCp/o/KqGMo+p4i8NdFzT6mSQaON44g57iN01rK6AIvCiuj1mkCXGcZ7ls+A433S95sgWVzTepBFamohqjYCDnTOx01vSIUnFkVMVcvWkRep+fsgID5AOZVzYyuPrHIE9mJuwUEFVdaLtQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1+h/aKetLDSc5qRJD5Cbl9CY2X1iX1TJ/FI4Z7Z7/8=;
 b=Hkxf4g7c6yGOxTf4FuFXMOe55u8Mu5mU6kFbBS7aEYE/zFUuS9JIHpIfikRSS/y25qHQMtyweD8HQSO8m0PLxkTYGyK+DE5gPJNVMJx7pCge/wjHU9dh1/Dh0rPBImpT7VIHozeyseCwKf9/HPsI+pMxlfMap8rwKJhlQIJvY5uvJ+g0alNIlAVB02O+klweEpeL+o+KiJVm1DKC4zcDqZQiuSgG2IZAblSWxPj+JZ3uqaN1KKuMKyxRekVZHzk0F6t12nGCkIG+CDhPZis3xrBo4DS5a9tkn51TZom9hJAUg4F3j9/sDSKGe1HraLR94d5bmm5h7dg49lhTKYFfpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1+h/aKetLDSc5qRJD5Cbl9CY2X1iX1TJ/FI4Z7Z7/8=;
 b=ihUxsKR6RCR39xTzipHdzVDBiPyDpYYPzsb2rXUVYjaC040PjgIxeY9wdc0FkBJtsao3SK9Ec35e+y8U5K2NDjf+t3TGy34J7ueNGXvvEd58maBEntDjAimXZNzyjh+h7MDp0CZMeIJ+Hbx8MSlVhLTnYocjEn95/P6aWffuaDE=
Received: from PH8PR10MB6387.namprd10.prod.outlook.com (2603:10b6:510:1c2::17)
 by CY8PR10MB7193.namprd10.prod.outlook.com (2603:10b6:930:76::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 16:16:06 +0000
Received: from PH8PR10MB6387.namprd10.prod.outlook.com
 ([fe80::f218:31a2:a748:3c21]) by PH8PR10MB6387.namprd10.prod.outlook.com
 ([fe80::f218:31a2:a748:3c21%4]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 16:16:06 +0000
Message-ID: <d7cf14f0-213f-4e15-abe8-cc09a293c4fc@oracle.com>
Date: Thu, 17 Apr 2025 21:46:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: Fix compilation issue due to cgroup_mutex not
 being exported
To: gaoxu <gaoxu2@honor.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "surenb@google.com" <surenb@google.com>,
        yipengxiang <yipengxiang@honor.com>
References: <24763f5c8a13421fa6dc3672a57a7836@honor.com>
Content-Language: en-US
From: Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <24763f5c8a13421fa6dc3672a57a7836@honor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::26) To PH8PR10MB6387.namprd10.prod.outlook.com
 (2603:10b6:510:1c2::17)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6387:EE_|CY8PR10MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: d9261bbb-8b38-4421-2cdc-08dd7dcb27de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NktBWDJ5WmkzTnJhV3IzRS9UL3JYUEdWVXhCbEcvVHhuQStrc0JRZ2N2aDRG?=
 =?utf-8?B?YlZWTUREc25NdmE4cWs2Y2l3YlJTRENhNktYZEh5NWxteVIrcTBFK2M4dURV?=
 =?utf-8?B?M0VSK2dkRXdnVVN1SXpnTUI1Z084Z1VvSk8zMFJTK01OemI2ZWFxWnpnT1pr?=
 =?utf-8?B?S1FsVWVlUG02NjZpNzdUTm1QNWVzdHhiUzBVOFh4WDdkK1pFdm1yRjBuRXhE?=
 =?utf-8?B?T3kxSHZ6WW9RMWpNUzZzcTRMcWpZMTRFZmFCK0UwVTVtT2hEdTlVQ2VOM2pP?=
 =?utf-8?B?K0x4SHBONzBDN3dUTXpBZHlJNUtLczhyeWJ3NW5ZMmlETTJoRTJOcVNXYmFo?=
 =?utf-8?B?OWJJQlBXTFBGa3Z3dVdpRzcxWEE0WGhSS2llbjFDQWljV1h3VWlIUkdJcTVC?=
 =?utf-8?B?bHA2ZjlaVTlYbDArL2hka2dtbDRxZVVnREgwNWN1eDJjUVZJbkR1M2k0bWo0?=
 =?utf-8?B?czVpcElkWm5PZGgvZTZQVkpSVHJRZ0V3VXJFYmJYMkxJZHRMWWQwRm5uMkFT?=
 =?utf-8?B?MjcyR0w2eS9hTS9jNFVLUDdBRTBhM0RWZmhSdzRwRExaclFvYWEya1NLNFBx?=
 =?utf-8?B?UDVtT1gyYlgxTW5vNVlrRzBweDRtSVVGYmthUllHanAweGJRS2RQank2U3JQ?=
 =?utf-8?B?SkJXeTdaRzliWGd0aEpKakYwaWF1VVZxbXNDQUpzNEx0Z2RtYlh2d3RkcXJK?=
 =?utf-8?B?ZUFscWxIOXZnbG03VnpCZU5YaGc5WUtSMGZqdzdNWnRlTHhYdTA2dnpwa0Zo?=
 =?utf-8?B?czYybzNSZTRueStZVFVyWE5zTHl4OVQvUnB2V2srOTRjRit0WTBoVmMyWGtp?=
 =?utf-8?B?MlVSNzJMaW5GdncybHA5VkI4MGsyWEEyYm1BWXV0VFJxUXpCZGdZTVJld0NQ?=
 =?utf-8?B?dWpwZ0V4dG03OXpNSHdDZmEwUW1RS3JRV1c0YlFIbmQwRjlpN2NSS3dIaS9s?=
 =?utf-8?B?c1k5OVQxVzRIbFVna0FzcG83YW1UdGlTWTc1L0FpKzg0dXIvTndGTSthbElJ?=
 =?utf-8?B?a0FxSk5kWXhQVzN5M0V6c0N1MXVNR2JpUE9SeHE5a2gzTVJvcHVPMEpoNlFm?=
 =?utf-8?B?SVN4NFJLckgzblgvNEZ4c1pVQTRRVGVvZHpENWtWMWRMREFBYUdQUFhxekpx?=
 =?utf-8?B?MXM5UXpMUkJWSFFORjhwK0xwS2t1UERSUmdBN2ZrUEV1N0FXcVdwZk83dDhv?=
 =?utf-8?B?Q0E4RlVlUXJubU40OTEzNVZKZnlTc2Jqamg0RkVZb2hDa1FtT1NuVW1kd3JP?=
 =?utf-8?B?MjFzQTBIRkMrVGJBQjNxdk1vY2lBbkNPRitLaVoxWUQ4d3FwN1JHaTQ4bHhK?=
 =?utf-8?B?dThpdnU3clkraDhpZVRhRnBLVC9MdXArOXZxcWE1QTVFb0F3Z3dlOURadlQx?=
 =?utf-8?B?TVJsdWQrUjNRMktoQ3BNK1QzSmNqTDVMdmgrZTdHays5RzlLdFZZdGEwNytJ?=
 =?utf-8?B?djJFQTd2M3EzeGtQWjRIeTZSY0N1T0RrSHVLTXJIRTArWUNvbWl1VXJ0SnN3?=
 =?utf-8?B?RXoyZzcvdEwvMmwya1lHckF5cHFHaitpeXRZSEFBOGNsWWJTNHAyQ1ZZMXo4?=
 =?utf-8?B?TmNuS0NBOWNHbDNzMUhJdytBcWZ1Mk5hZDI5WStHd25tdk04MXdVYXFVUUJQ?=
 =?utf-8?B?YUxwdHk4eGNiWWtPUUVmVHpEWm1tMWx4UUtIRDY3M1VZTjdjS3YrVi8vU2wy?=
 =?utf-8?B?NFRoc2FVUGZQYVBZRVh5aitnbVdxS1hJYnNNR3k5K2dMMG0yaFFCNHgwTERk?=
 =?utf-8?B?SFovQlZTZDBpdDFZYncrSmxmMVFOUkFKSzdJKzhabGl0SVFwYTV0UGpzUGxK?=
 =?utf-8?B?VjVVS0puK200MEZhOEF2cGdNQWQ4QlNORWdrekY4MDFZZjdidzNrOFhEajJq?=
 =?utf-8?B?RzNuRmJUT0oxdkZEMHUxVVNQQkI4Wk5ZVk5pTlZWOERTTWoyUWpiWjBpZDAy?=
 =?utf-8?Q?JweMu8RT3dI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6387.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N01jVFRIVWkrQjhLSmdQcmlYc1IxU2QyQnZ2SXNBK2N1UmhGN1BMNEIreXdr?=
 =?utf-8?B?aXZnYjVuQ3dsQmM4WG1UUjNkQzR1VERlR3ZOay9ibnB3blY4K0hFNmlZU001?=
 =?utf-8?B?NnBjYW5qNTluSFg2SE5TYTFoUWZINWpmUEM5dHhndTRkd1NzTUZwQmRrWk4r?=
 =?utf-8?B?aitIc1BhVS8zN1UwaEFXdWsvSmpUNGNabVpVMWxzdk9oTDBTV0hLd3k1ZTBQ?=
 =?utf-8?B?VFdYdVNvRXZvVWxtL3BJdG1sNjNsbzY4MWlXWjMxUUgyRm1Sa0daR04vckIr?=
 =?utf-8?B?YnJkL2lZVS9OWU9hR1ExY0pJMnE0Sk9Ub1padW5xNTlNMWx6MXJTbElpU01s?=
 =?utf-8?B?eUZ6dXZIT21DSjNVSnVvblhhdENJMEhuUkUwQkkzOTVINml0Ym9vdzRycFdL?=
 =?utf-8?B?dHh5WWZnV1Nua2ZVSENTdTQzSjBCdGpkMFNuREMvZUpoR0RadExwdWNmc2RR?=
 =?utf-8?B?S0dUeVRUYXZsRHJmU3pVNTYxeHBzTnVaWHFKWjN5WEVwSUlvd0Uxb3RIL3Z0?=
 =?utf-8?B?N21tR0pFSjhQNThNcDJIVUR0UWdyaU5teEp0MElEMGt1cjgrdXNWSVJ4Vnoy?=
 =?utf-8?B?aFZlQnIvbjFQZGtpS0VYSnJwKzRBbXhtaytjbFcxa2tBYVdWNFYvbjNRWjMy?=
 =?utf-8?B?Q1V0NkI4aGZuR2NsNm1zTTJocTBOcW1NNzN2MXRKVHNGSjJ6TGIxMTFYTi94?=
 =?utf-8?B?SVptc3VyMURxVzVLSGhpRXowd0VMcmhvdXdrbk9lTE5DT3AvY1UrOVhscmJF?=
 =?utf-8?B?RmFpWU5rM2JwMDA0U0h4cHVYUFRqRXlGL3VMWS9SZHdseCtwSFQ0TllnQkwr?=
 =?utf-8?B?alhOVTZjaC9BbG9zRnV4bVVtNzVEdnNKdDJWU0RzL1luZ0dHRGdiUzZ0aEhy?=
 =?utf-8?B?ZTdDWjBkakZ6OHZNY3lUWFo3RFFJcm5SenNjQTlkRWVvUjNtVUJPdVJlU2Zo?=
 =?utf-8?B?dUtQNk9QV29GeUVjMlMwTUk3aldqQVJvQ3BCNUNwMEY0YUdITy8zRkhNRVI3?=
 =?utf-8?B?Y21ySUJkaDhwRU1QMGlMVjJNd3grTWNWdm5RdmRVZ256SHYvblUyd2tQQ1FN?=
 =?utf-8?B?WlVSbGwxaTlwbS8yeUs4ZDYyckRDS0lMUFFrbnI1elFyREExOWxkVERSQW0v?=
 =?utf-8?B?NWdlZWNPZU9IanV6RmpMdS9zbE8wV0lUY1locXZlTXVBclZWQWY2Um8xNUVs?=
 =?utf-8?B?S3R4eDRWZnZBVzFGMnhzcm1MYkJqcHpqVmozTUlRbjJ2Y3MvKzFBUGszSXZF?=
 =?utf-8?B?NzdQa3VTeG9LekZ3bWl2NzR0Z1RiQzRHNVROeHdzZEMwZnpxZjR0NTYzMXlE?=
 =?utf-8?B?bGNZVHM3cktBYWZidGlaVFhIUGtrLysyWmdpYlVwRnBYOGlBVk8rVFQzZ0JG?=
 =?utf-8?B?dWljdVhiUmZjQTliSFM4clhPWldCS2pYWExRQnJqVzhVWG1RQW00TnVFUjhP?=
 =?utf-8?B?TzFUYW1vQjU1OHRBU3lnbU1PY1FjZERYUlUwTmJGWko4V1FJdCtUMDY1Rm45?=
 =?utf-8?B?SCtBL2dMcW1OVENicm5sMTgzVGVPMnlXSzZBbXRXbDJuTFV2SDlPa0Uyait2?=
 =?utf-8?B?Rkc3NitRREdSbEEvVllpbllQYjRnMDNVcW9vMXl6cUZRZEtOdzhnVWljcDY5?=
 =?utf-8?B?NG5jamE1R3EvNWxHSTdlemxhaXhvYnZxd3kxTm9oYlVVUWN3bzlha1dWM3hF?=
 =?utf-8?B?cGZ6UjNvWjExaWxzNmpxalJkQjExdTlwNURwRitqM3ExenFvcGUvOG52azY2?=
 =?utf-8?B?WGNFNk8vY3JGV203NjlHd3B3TSsvb1ZzTENpQjZNRFVsL2VlV0JXNUVnT1BS?=
 =?utf-8?B?SzMwSFYrWUp1NTdXNmxodEVWczhZNW1ERGNDZFVWUHZvRGYxK0dSbGFZUE0r?=
 =?utf-8?B?cGc0dEc2TlB2VHZRNlE0czBvTGpEMUhlMEluWDJQSlNZN0ZKcjdkSXRicUk2?=
 =?utf-8?B?RGJRN2xJQm5Ub3hXU1g3ODk0T0pna01nYjdKQm81QWhOK3Y1SXFsMElHK3Fv?=
 =?utf-8?B?VUZYdmprY2NhVHAzSkZ6bDR4RzZ5Zi9adGRrSkJaQU5vOEFqN0JVVlVZVmtY?=
 =?utf-8?B?WXFrZG9DcU1KUkhRbXVFSW55MWE3dDNQK1o1RktvblJrSTYrWUQyUWVZQjlK?=
 =?utf-8?B?Y2RHWmF1OTJMMFY5OGYyenZyWndaYm0xbXNLb2NPb0pwZ0JqZHJWQllnSU9B?=
 =?utf-8?B?b2IxTzZFUnRXemV6TlFwN1dFL0IxKy90Q0duT3l6ZjFJZTc5b2JNcXIvK0tp?=
 =?utf-8?B?OUxlZUl6YjZEb0dkUHY3Z3lmKzNRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GcSQoon7giZccWzG4cvQEWWJK/PrXgvgwJ5Y9Ok+7I1KCxiNXSVlzoLRt3BUc8BLJGVXSoSDf3m7nnXl0RM3yyIQe46JJeTscsKlGwQjmHkXMftLkbgFPwPghk1A8jrQf+tUqnsNHjNZQgPiA0451YOs4mx4+JxrJSxoW9BoFJAi7RI+7TGNBR8Z9k2Z6AYB/BpbHgHC8ia5WDZKcaczmlj7jSl9vP3dP2Ukpr9oeDKsnUiGiKNJtZIXXTM60tUmA7/CSPBDPxXiKxKFw+i1ZUayG1FQDcprGnXF8elXwldrdpdQ1Qh/eXgCjw+a5QcMS7QcEjIH6RATEtnT5YAcYgGhSzR9R7YOLeC9LS08z6Tu/mVkAlK5nQiW5Itwcqh5qDuYnV+MHCNeGvOfwviy6aSsqllv2Wl3KBUQ7yc5hF/GxQp4KwMKRiSNkfeRnaSV0/EkM1WT/c6/f+QqeM6b2o/B5xnssEt/SnsE3lamkDeEHC6q/YEC4MYyJESJXVCfVFfd3Mmf9cs7Agzz1WYcsNKWXUCKp/kaskndFbxX65ioYyI2m8wnX6J0whYlr0f4G9W5Arfd/AN+X7p8JIgzo+hiLWfVOxT3h7P5g0EGI6Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9261bbb-8b38-4421-2cdc-08dd7dcb27de
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6387.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 16:16:06.1434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vFrhwGYnbZfxD7D02np5Yy8ZM4LXaDoIOLiO77KJasgvHZqybjSnDWLx7YHocnWPgAoWBdn3e8zsvrKihKM/v6gGSJhOnIdwBnM5lgxcwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504170120
X-Proofpoint-GUID: vZcHKydI362mmNl6i5MGBhiGv4GcowSY
X-Proofpoint-ORIG-GUID: vZcHKydI362mmNl6i5MGBhiGv4GcowSY



On 4/17/25 1:00 PM, gaoxu wrote:
[...]

> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 447ac857e..9e60ff629 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -90,7 +90,7 @@
>  DEFINE_MUTEX(cgroup_mutex);
>  DEFINE_SPINLOCK(css_set_lock);
>  
> -#ifdef CONFIG_PROVE_RCU
> +#if (defined CONFIG_PROVE_RCU || defined CONFIG_LOCKDEP)
>  EXPORT_SYMBOL_GPL(cgroup_mutex);
>  EXPORT_SYMBOL_GPL(css_set_lock);
>  #endif


It can be triggered when CONFIG_LOCK_STAT=y is enabled, which
selects CONFIG_LOCKDEP=y and sets CONFIG_PROVE_RCU=n. The patch
looks good to me.

You may also want to update the description above DEFINE_MUTEX(cgroup_mutex);
to reflect the modifications introduced by this patch.

-- 
Cheers,
Kamalesh


