Return-Path: <cgroups+bounces-3163-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BF4905167
	for <lists+cgroups@lfdr.de>; Wed, 12 Jun 2024 13:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD731F22A98
	for <lists+cgroups@lfdr.de>; Wed, 12 Jun 2024 11:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BC716D9A0;
	Wed, 12 Jun 2024 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DpUKXFIu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="edlLKCq+"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61DC15624C;
	Wed, 12 Jun 2024 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718192020; cv=fail; b=Y9qWh0zRpLBCsjjrQ1zy6bqilzf4qUQp/xud4/7WoUZkt4XatZdRtVdjNQzQye8BBoQ/Sxs4fMyQ1AtFiJrOO3v9pt5jdEMEpRQTZrH4tmtZoBFhXD41gAy/yFikAZPpInicaDd0eLqSUtbIfsV5kGX+s71zicPDZHbKWwEGK0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718192020; c=relaxed/simple;
	bh=eFdCvhSb7Ns3zX3r05M1P9t4V9h1rHPFP1CrhaYr1lM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=buaA2bKYiThVy17aiekKlYGPBFUdsniBzgHyLWZik/O0mXjpNdLkxSqCgQInEu+UH5xAAuT14Gjzk+xoUekNBfEigHPr3pZkxXv6faRC7advOwrifLznWQCFk3qBFx/bOCk9JlUL1Rif/NEWUl/b5kVZC25yq0F+gFS1gsm2Thw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DpUKXFIu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=edlLKCq+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C7BQZo031260;
	Wed, 12 Jun 2024 11:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=LUjyuG/JKsy5kDkstlbh/HZbXO/iDUrxQ79VVdC/LM8=; b=
	DpUKXFIu1Xv9fd12jRZBOamsxL+DmREzWJEAm8xSMyfro5VeBe69ZeE/mXXforhn
	4sc1eN61fb7sKIofgLGqmmTkuBb4Tk/YRz+gAu3tCpVBxABozIJfM9e5kApr5/BS
	PDBufeUjzUhe9ckfEyOxlYVz8X8uzvlTwLjMMKvT9+cjWbsC9Q7d8cmOAcikV1PM
	bcgY3s+GH9pN/KzaLt4cSGfHK8EQE6HNPP8AsV3g4ogfLSUPRTF0g6Ipc+6KWOZa
	wR55TzZ49jFpGCRFgRsD72d/Fhpch1cmjwvAqp4vRB18Fyg9Ek7JKgT6XMVRaifR
	YiVjF8W3WDt/z/HCvLM+aw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhaj6yx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 11:33:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45C9oOuU012419;
	Wed, 12 Jun 2024 11:33:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync9y9uys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 11:33:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DE/yEyVOMuOwY1ZRpRF76pEojmSHAixQ64QrjVYqOqHtn7x12UM1OcPX/8BF9hO5Lq0WZ+q1kAm5oKuu391HpTXpbKc2+iG47N184nFWjk9i54w0WAdnWA0MarRnRTH9CjxC5gldzSi6OHAgJL3Eqm3/wYe9kkhCeL2VYavzSUDxDRYtO848+PABDhOvJT7yuFgyEWAnVj6kndhuNCz+Utc6pvyjzh1/S/VednLZuCUwUXz2mUAs4pPF2odzbo+a5RkYvraMFhc7sQodZqosyKLYRNw/OCEeAiGz7PMfbpjTPZpn4OG5okz7UIydiKHRU5lCCNoIS3yKD+nGUYr8Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUjyuG/JKsy5kDkstlbh/HZbXO/iDUrxQ79VVdC/LM8=;
 b=Bl1ONi9PIMPKCqTzt32R+zMKMwMsATZiu/Cn6zwoHAu36ZyQq67Iaf/PqPSVqAn/42QwVGkaj03YAq40BoD+4ghScMvrX6mn8nFW2muqwN8iIqHjvlflddHrcszgOlSsEHFr7UqbuuntTqNY89Jcg81pA7C6SdySF1r+l/OqqHLZfySAZyUb2Rn39Y0ysIlhqa1fi8H0oz8q2vWLIKqrkfSyue32GigkJzGiwofh160TMAH3e2EopPQ6PAvPMWb1M4+EynqaY7QagaYGyAe3zRN8vpHmdarix4A4/Wy33IdYkL2ygJ5caL6c4rFNyMavngAslzXvLUYHT1s2qVcl7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUjyuG/JKsy5kDkstlbh/HZbXO/iDUrxQ79VVdC/LM8=;
 b=edlLKCq+DvcxqgbMfl/N3EasiNe+EPPGD88VK1yI8X05fLKLY2zhSYoWPvBi2+sGP/V45V8OREFflRMDF9kXL9lx5ahGsPY+Yfdq7HCP98Vfoy3oh2/TWUqGkYNcuKJJVbubsRpdJsGxbQcUWWgNnbacMpekxDrbO7j2/NH1KTg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ1PR10MB5932.namprd10.prod.outlook.com (2603:10b6:a03:489::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 11:33:24 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 11:33:24 +0000
Message-ID: <45603be5-65ae-4d45-bfbe-22c3c1e22280@oracle.com>
Date: Wed, 12 Jun 2024 12:33:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/27] blk-iocost: grab ioc->lock for debt handling
To: Tejun Heo <tj@kernel.org>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com,
        hch@lst.de
References: <20200901185257.645114-1-tj@kernel.org>
 <20200901185257.645114-13-tj@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20200901185257.645114-13-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0253.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ1PR10MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: f64ae51e-9a6b-47dc-e2f8-08dc8ad3782a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RU1LSWtrUlByK204Sm5xejR6cW0ra3JyNlFPQTZCcjJtajNlWm13Z004dW1I?=
 =?utf-8?B?N3dFWHNhNXJtSUJjSmxhek51Q1lUV1J0TEhZR3U3TWYvSUNhVEtOMElvVG90?=
 =?utf-8?B?Z3pEbGh6cFpXYVRHTUdtKzJYakpuL1E2Z2xDYXU4TWM3L3hXYTZscXdlWTZB?=
 =?utf-8?B?dWlDcjNZVDg2VWZpOHUraFFCSzEzOWtmSGlma2FvOHVzYzBtOUhjSlMycUhs?=
 =?utf-8?B?eHNsL0VGMVE2Q2lRaFZiS3B5WlB0SEVZMVVZOGRTNEhQK21EMGJ1SS9uVlQ5?=
 =?utf-8?B?bmNDZ0Z1WmRyUE1NM1hhTjFyb3BUWlBXMU5OUGViS0Rzb1lLZ1dneVA1THZD?=
 =?utf-8?B?WVBvZ3g4TThhR1B3Y2dHa0plQWJXbmtCNVVUZTRhRFcvN0x2RVo4NklJdThG?=
 =?utf-8?B?ajlrT1BmNlRqRC8xV0hHNVdzd0grS3NzSHBYVjVmbENVTkRCZ0RlV2pSYVlF?=
 =?utf-8?B?NlpBWlJhTEJOemxBajI2dEM1RzZHSWxZVzBoY3FobXNWYmZrMkpJZFBWZjZ4?=
 =?utf-8?B?TENKQmRWV2Z5U25ER1VBT3NEYkNEbGJlTWxlVEtvTCtUM01XRVorcGtlcG9P?=
 =?utf-8?B?WnVhME1RT2E2Z3o0bWxiamhBN2F6aFRjKzV2QXFFZWNKRFVReVdSd0MrTlN0?=
 =?utf-8?B?NE1CV0NyTGpJb3BERFJ3U1lZdURobkgyVEJEQ05RQkNONmhBWHNwVUVqaUxU?=
 =?utf-8?B?TFFub0dVQ1QvejJkOHdpS0N6VHVwV0NhWHhwZzVCVHZpMDBWNmRKQ2h1Z0Nu?=
 =?utf-8?B?TGE1ZGt2VEt0Wm5BdHBhcnNLMmNObWwyc0lRbkxpcDdDNnlLUFNBdzMzNm9y?=
 =?utf-8?B?R0poVFV2VE9HcVRwMVV1VTZITW9qdms2UE15dVFEVTB3NDNkTnVaaWJHNGFi?=
 =?utf-8?B?SVJtcHBXTjJxcGU3QlRMYUNvSU1rcDkrMkJRWk0wMzhrY1FpRVlaL0hRTmsw?=
 =?utf-8?B?MEZjdENFcU5ISFFST0gzc3FmVGxhV2w2M1Z5Y01TUGdQUjAwUG1vUTI1ZlN2?=
 =?utf-8?B?alp3UUFONnJESkVobnlTaHgzVVZhRHdUajQxcDhlbmYzU0k1cEw4Uk1VbStN?=
 =?utf-8?B?T3RiSUJWdnd2dytkYjlJaC9ZaG9uYjUxdXd6VklyL1VQVmdabG9acjMweldL?=
 =?utf-8?B?RmwwdzZXYlIwK0NvSGFXZFB0OUtjSnNTNkxjMVYxanZoVWtJTFp4ZVBWMzNP?=
 =?utf-8?B?NStnOEQxditkM2E2NWNVMnBCTm5NVmcxUnhadU5Vbk1UQzN4WlJVSWhTbm9B?=
 =?utf-8?B?Z0ZQblZBeXZsanUxSnljZzZYdm1MQytMTGdkdDhza0QwZ3AwcktqVkUxR1Fy?=
 =?utf-8?B?N2VybENIMjRwOVk5SVJOVnppT3lUcEdzNHdXUUd1OTNUV1hjenBLcjdtZERP?=
 =?utf-8?B?MTZERmd4SW9kZnhob25SM3laUHJucUpIbGd4dkpkTnhkdjhPa2orUXM3Y1NX?=
 =?utf-8?B?UWZhU3cycXZIRnA2d055UkpXdFlRRFRRRENMMDZqNWhnMFEvcHgvRWwzajI5?=
 =?utf-8?B?akxSVExUd1BUdGJZRGdNVkFGY2xVdUxqMFBMVEFoaGtzTm05cnA0UGF4Zm5t?=
 =?utf-8?B?UmZjVG4rRUdkK1hVaDhuanhXSGxoaUtuWFVWSm9YdzlDVXE2NkFaWlpMWFdy?=
 =?utf-8?B?RlpXR1ZuMVJxQnhNN3JqRnNEMFFDeGdoNmFXbW1ZK0pmMUtZQkVoci9maFoz?=
 =?utf-8?B?YUExUTQyOFFyeWViQ0VlRE5KcDI0d0Y3Wkx0d0RBYzcxNEdYT2VsV0dHclha?=
 =?utf-8?Q?CLfEd9p0/q8cDGTQmFofnD6wRz9L/jLQgphHrmg?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ME5XWEpzOUVjelIzVXJadzg2SlFtOTM5WVp4cEVFbHJnZDhEOVU1NktEZHFY?=
 =?utf-8?B?dkZmTGY4Z2QyMmlyc3djVDBqbWVlZ3k3VXU3VkhOSm5sSTJ4MUQ4bU16NFVU?=
 =?utf-8?B?bWQ4RWdkcHdGNDQzYTU0UjdHWDl3eHpvZVZxRzVWQWlPS0V5N2NEai9LREJ0?=
 =?utf-8?B?NlhBY3JuQXd4WjhpWGNLTG04L2pGdWhUSVptbS9mdkM3cENJWGFwZkQ1SU8v?=
 =?utf-8?B?dGZ4d0N3OSsxVERxVnRWOEsvNGYwdW1VMytDazhXSkg0NnZYV0pNM25wSERH?=
 =?utf-8?B?RmMzYUxES00wVk1jTkN1UzRlaTF5WWp6clhDSDBoYTJyYXNVUU5ZQTQraVNK?=
 =?utf-8?B?aDFKa251M3lkSEJwQzYraWJuUWJrOGJCemR6dDVFUkRzUzZDUEdSVkNRVlJM?=
 =?utf-8?B?dTV4WCsrcEMxcFI2VjhJeW9yUHl1MnNOSXo2N2hIaUdkU1BoNHZNanozU3VL?=
 =?utf-8?B?OTg1WDNFQmNYRmoxSVB2dVIzUU4yb0owRUtmN003REk1VGxJMC9SWk1EYU9M?=
 =?utf-8?B?TVpsc0Q0NS9nYTFuV3l3Nkxxbm5EY0NHdFlkVlIwNE5zNEFlaW96aUNWTmlx?=
 =?utf-8?B?S2tseXFPTzRJZ2FjTndQSWs2Vi9qcHo5bVNSd09yY1pWdTFBaGEwWFkzdEIw?=
 =?utf-8?B?UXpKMDBHN2g3MmN2Q1ZWdEdVR2Z6Szg3d1VDNklsZ2VVRjN2NVdhWGJNUHEw?=
 =?utf-8?B?NzFWMkIrZE9NYy8zZEhGRngxcXJOZ2x6N0gwUjM4dHpLa3MyUFNTYUFXYzJP?=
 =?utf-8?B?Yit1V01nWDVpdjZrRXI3a1dNRmxlRGd2NlpPSm42WmpsUmxSUEVjeHp5SHRV?=
 =?utf-8?B?bDRoY2JkT2Y0OG0rNjFFTDFZbE01V0VkQUVRY2tLaUduU0ZYMkJGL1hYcEc0?=
 =?utf-8?B?bWVqcGl4U09EdWJ3NmNPT2RqekdpTHR2NTkyb1RHaXk5RXAvUHZmdDJPcnJi?=
 =?utf-8?B?alJNeUtIc0NrUmQ1WklheE1QVHoxczkyQjU4YkNraEdlejZZanJ0N3JpbnJS?=
 =?utf-8?B?a0NkVlRZNEJva0c5RFhRTEFhbFBDaW5laUdIRy9FZkp0ZmViTXRRUy9iNDh4?=
 =?utf-8?B?UThBbFFlcXhiWWxRekUwSVVtQVU5WTBPSmRpd3BhZzJta0JDYlJ3RkN5RzRD?=
 =?utf-8?B?QUM0UFBsWDQvMVdraTdSZnIvaHhVV1hUUkJFaFd0aXlpWVJ1akhKK0srakNv?=
 =?utf-8?B?L0tHMTg3a2U1WHVvVW9GRGRmMmFzRGJaYTZvZENuVE1kYjZQZW9JbjBmdXYw?=
 =?utf-8?B?NThkTGdscjRNQm8yNGdZUHFIRVFkTUNad0lyWG9aN3hjc0tYbkpqOE02am9V?=
 =?utf-8?B?ZEw2MjA5QXdjcUhPS2VLdTF6b243b1A2WjJXMjhRdXg4RWhBN1Nyc0QyZGY4?=
 =?utf-8?B?aXVEZzhydVpMclpqdDIvNFlxUkZuSjRIVjBVUVB1eWJNV3p4RkFYNmpXWDQw?=
 =?utf-8?B?WXdwdmo5c3NVWjY0ZVhBeXBqalJRZytPbFFiRmJkUkZtN2hjVU9oTWlVclBX?=
 =?utf-8?B?YmdhUEQzR0dHcFBvN3FZVHluZDlEQk9DeXU1NTQ1S2d1TnNHL25EL3lPeFFP?=
 =?utf-8?B?YVZuOGV6VnVwbjNybExNcERGbmtEWUlrWXZabVQzSEEvcG5LdnUxQmV5NktL?=
 =?utf-8?B?ZmI3UVBiTFdBaFFCMVk3TlJPMVJlZzFJb0dldkluSlhwN0lwYUJXUFlzUFZj?=
 =?utf-8?B?R2RNVis3K0pzamN0L3drcDJIOFpHV0JCZVE1KzhjNzJsaFJndCtKYzVvMERQ?=
 =?utf-8?B?QnNoUjZUNFBxcUtHbGlUcUFBMnV4QTdmRnFHQzJ3QlFPR25hcFVmRjJmb1RS?=
 =?utf-8?B?Ymc1enlrYzM0MnJQZmltMFd0NktEUUkzMys1aVB2blRRNllCeWhmbGo4Wk9r?=
 =?utf-8?B?SlphWUhKSFVwVzl1SEswWUQ5MDNLeFNZc0xKUUVPcXJpT0wrOUNaNUtZWEM4?=
 =?utf-8?B?VnhITzNXa1VSZzg1WjdKUWRncExKU1Z0K05NU3RacG02QjJWYmsyT2llZzI5?=
 =?utf-8?B?d2srK083akR3QnNlS2VIVlB3ZGE1Rmt3K2xETnMzNGZOQkJNV2YyZUpsd0t4?=
 =?utf-8?B?RTJaSzhDZzJzL0p1S1VrZEJqTktUaVBMT2w4bm9kaVNhR3I3RFVtdUk5RUZB?=
 =?utf-8?B?MWxJcjQzOHE3Q3ZiZWFJLzRkR0RpM3Q3QXIxbjNnZFRITkY3RUFXWjk4Wkdz?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2eiT7rMfeGxshfFMpsBU/JO3KDmXdv/H99RAyyVXonsfJNBc3ENojWrFnVmjod6MF65CDCK7BQqZVD+kAG/Xdlxf1WKp9bnmWu+hVdhXJB8NqzpIflPgqkZ9SRDr+7TLurJDy+VOl17eflW/MQ5hKaYW2siNXPcwl9/UdsoaOnmPabkasLJLhN85lRHDxTNVN/fnvhyVUZpcrzZynPnp+d6UnXqku17E8iufF9/KATqe90Osy43rUnc+hZ7CBKxpzE7Q3izZ8HsxP8S2xbk9Xly8fN8yxRb2tAq47FWDmHTsTC9Q6vHb8i2t58DlUOI0Ss/VcgL3Kw/vR2JXM7BEAZcWQCzvrpLfJjNrde//E2/hxd3yqr3gvFwmQNuonV9CKn+Ml3AjNxxAda7MZWAThRGV4rJplmyUNbgeQcVQ+vGAxZSCKYhRMJq2H8yx/LGOs6dsBWTa8H/q9M562CebItfwTubxRRaXigTTyP8AT1SJFGZ34pO1htKP+fS8z026Ud/c52ZEwtx/lsASthmmk5I/A7MiVJefiywLXtcmlt8bH/Y6St6ug8zkA3piWHgJ00TdMgE1qh7xmC/RazyadfRgLAyHAdhQmIFDFQIMJ+s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64ae51e-9a6b-47dc-e2f8-08dc8ad3782a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 11:33:24.0734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Zqax6CJx6mCfpPoKJ8hV/th3CY5V1I92hiXnJCNaZ6lm4dYds8R3yW21rXaJy8y8KKmAZhTPbn1dq+JaHmejw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5932
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_06,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406120084
X-Proofpoint-GUID: QletfVoY3h_oTn-nZBmJ7K8elbkwNtWE
X-Proofpoint-ORIG-GUID: QletfVoY3h_oTn-nZBmJ7K8elbkwNtWE

On 01/09/2020 19:52, Tejun Heo wrote:

Background:

I have been trying to solve some block/ sparse issues, and it has led me 
to digging up this old mail.

> Currently, debt handling requires only iocg->waitq.lock. In the future, we
> want to adjust and propagate inuse changes depending on debt status. Let's
> grab ioc->lock in debt handling paths in preparation.
> 
> * Because ioc->lock nests outside iocg->waitq.lock, the decision to grab
>    ioc->lock needs to be made before entering the critical sections.
> 
> * Add and use iocg_[un]lock() which handles the conditional double locking.
> 
> * Add @pay_debt to iocg_kick_waitq() so that debt payment happens only when
>    the caller grabbed both locks.
> 
> This patch is prepatory and the comments contain references to future
> changes.
> 
> Signed-off-by: Tejun Heo<tj@kernel.org>
> ---
>   block/blk-iocost.c | 92 ++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 73 insertions(+), 19 deletions(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index f36988657594..23b173e34591 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -680,6 +680,26 @@ static void iocg_commit_bio(struct ioc_gq *iocg, struct bio *bio, u64 cost)
>   	atomic64_add(cost, &iocg->vtime);
>   }
>   
> +static void iocg_lock(struct ioc_gq *iocg, bool lock_ioc, unsigned long *flags)
> +{
> +	if (lock_ioc) {
> +		spin_lock_irqsave(&iocg->ioc->lock, *flags);
> +		spin_lock(&iocg->waitq.lock);
> +	} else {
> +		spin_lock_irqsave(&iocg->waitq.lock, *flags);
> +	}
> +}

This generates the following sparse warnings on mainline today:

   CHECK   block/blk-iocost.c
block/blk-iocost.c:685:9: warning: context imbalance in 'iocg_lock' -
wrong count at exit
block/blk-iocost.c:696:28: warning: context imbalance in 'iocg_unlock'
- unexpected unlock

If we try to break iocg_lock() into one version for lock_ioc set and 
another for lock_ioc unset, we can solve the sparse issues for those 
functions, but then we get another sparse issue from the callsites for 
those functions:

block/blk-iocost.c:2679:17: warning: context imbalance in
'ioc_rqos_throttle' - different lock contexts for basic block

I tried to solve with a total ioc_rqos_throttle() re-org and much code 
duplication by calling the different lock and unlock versions from 
effectively 2x separate copies of ioc_rqos_throttle(), as sparse seems 
confused with how we call these functions. It's a total no-go.

Any simpler idea to solve these? Or just something to live with?

Thanks,
John

> +
> +static void iocg_unlock(struct ioc_gq *iocg, bool unlock_ioc, unsigned long *flags)
> +{
> +	if (unlock_ioc) {
> +		spin_unlock(&iocg->waitq.lock);
> +		spin_unlock_irqrestore(&iocg->ioc->lock, *flags);
> +	} else {
> +		spin_unlock_irqrestore(&iocg->waitq.lock, *flags);
> +	}
> +}


