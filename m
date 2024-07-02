Return-Path: <cgroups+bounces-3482-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4374B91EFF9
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 09:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3C8286377
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 07:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4D512EBE1;
	Tue,  2 Jul 2024 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oe0lJDm8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TzEOj9hq"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0EB199BC;
	Tue,  2 Jul 2024 07:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719905101; cv=fail; b=L4lscqI/zY03XBtmR3b+iWPTryVuYlzNWPvxex+u+dV4xN6IXlRcuFDZK1Z8cXB79viVvhRzs8eC85V6FexATpB6LAOSYZe1dFAuSebCSztmqFJPeKqIZo1K477GHpPp7YBGfb5hFD89ddVgLq75Gok6X/DyaqoBUNU9+kNnQ0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719905101; c=relaxed/simple;
	bh=UTkGeYxG7ifYS5595wmcDA+Y2cb/LnFj5yPGsyxYa4s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mH8nmgOs7trFQljKTeuM2D+DFt5vttH4cQyubb/6XMhAMQeFR/TlrRkeNf6iqF7Ne+cthpF3T8GoWTgsriocoqaewwGOipqNwgZtBCVlkiq59RsYzH8LwnOo3BL+nhWcCjFpIm0pggkoJsvc0xNzkad5cNYfYjK3HlKJDcorCD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oe0lJDm8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TzEOj9hq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4625NRWm021756;
	Tue, 2 Jul 2024 07:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=dTTKfL5U7LD84Br4iCoLZQSsK896qcPYmN5Fiaya0DE=; b=
	oe0lJDm8c6qP9EHjO+zDbcL6UVR9W6ixsuFwqiekA+u4yN7droS53cOTDnHEoMnH
	JBMdKbu4P2B8MvBFMF6D3/IQ1nevDy+Gn85LdvSI5d+7mXv4OQMSGyZpSPqssIsp
	U5sazEoDfCMDhddFDpE9Bd6amAQOgeDM/mw+giOLBZ68fqcCJfuutTMSrVzLyVQG
	PxH/XV6SJFkJDPwJhGXHl+eQBMy3kdydGWa6ZRT7WaIGHo6zzNZiqC6W5tpwKDci
	l1pfrLv+lJz11eCArWmjXQBg8F82HkJyrwV6yYjjLl4s9h+z7oL6F1KjEio0UykG
	XB20MgSeG+bV/cvgwW1b4w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029vsn428-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 07:24:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 462785WM018345;
	Tue, 2 Jul 2024 07:24:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qdsy0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 07:24:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTGEvUu0z8MdeNw/qyepyZ6oaMrjOaBRTliTFQnOTCEeV7Yyt8h1U3u0eEZuGZzmvbNyReoXpWYLNDKryi++g2fjtR54iybwwAkA+arM45tEHmEg9PrR2D0A+K0rWZ/96g0JbJw3eYz4hyOgLVEEs6x5tN8aznmEl9P18CDqkaZ2Ggj5pvt2MMnr3V7+/HHrIjwA2SFQnwBqfPEh0sZa2wJEMgFeCaZiK1AAQBEIL9Gsg29/i1dlb9Ukdof6qREM5AQFvAMnirNKdlRiPk2obVwdyVycckirRmjwPDMlZmqW6LgLHDFuw0A5vVZ6mVEpNM7EzXStd0KVCdUN6+k3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTTKfL5U7LD84Br4iCoLZQSsK896qcPYmN5Fiaya0DE=;
 b=bCtZNJ7VvfaEFOxl/qfurOChW1E/6yMpumYTX2HNUWiYnn6jsPbGdUWM+CfkV+usITJkJz8k11FWAPrGmzRT1TWBIahXTFF2SIWT01BiX9mm7WOE+4rlOHNpvdp2Q4YiQN0LMMp5SGYF4yQXsKBLJgrJZNFIrAB7/3ISsH81+xJF3uOrnn9IXgNUTaoASkP11Qsl5mjVsK6DuzXfzZ96ClvWgf9/+OpV2baLh6Xs0CsYyHRKpwx4ieJisKpJjH8izCJ9BNDmtZ+dFH7pbwquHpzhPNct0pikKyNTDr3k59gKEmUjyRHDQb3ms+IAgaTVEJsRcRMdLNHKDycWm4xFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTTKfL5U7LD84Br4iCoLZQSsK896qcPYmN5Fiaya0DE=;
 b=TzEOj9hqp2oPrdeprP4WXFl8ANZP4ojs2AGVQJ7W+Yop/Jg0rUVeTIUNCkhSg22MAeL0ytjGsytT2fy9qMw74NV7aNstSgcl18AIQ77FJ2rzW6x4IhJ/uFlJku0uLJkN07kOkO0SEgY5hs6zcYEvW/xZgarvbXvMt/j6FQUF8zk=
Received: from PH0PR10MB7080.namprd10.prod.outlook.com (2603:10b6:510:28c::6)
 by SA6PR10MB8013.namprd10.prod.outlook.com (2603:10b6:806:447::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 07:24:28 +0000
Received: from PH0PR10MB7080.namprd10.prod.outlook.com
 ([fe80::3d6b:7c00:50d4:9936]) by PH0PR10MB7080.namprd10.prod.outlook.com
 ([fe80::3d6b:7c00:50d4:9936%7]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 07:24:28 +0000
Message-ID: <8bd9b2a6-e1c2-423c-9cea-45b14763e251@oracle.com>
Date: Tue, 2 Jul 2024 12:54:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 -next] cgroup/misc: Introduce misc.peak
To: Xiu Jianfeng <xiujianfeng@huawei.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
        haitao.huang@linux.intel.com
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240702004820.2645868-1-xiujianfeng@huawei.com>
Content-Language: en-US
From: Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <20240702004820.2645868-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::14)
 To PH0PR10MB7080.namprd10.prod.outlook.com (2603:10b6:510:28c::6)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB7080:EE_|SA6PR10MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: ffaac64c-382b-4715-8176-08dc9a68020a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VkoxTGVGQW5naGJ1Z05qWWw1OEtLZUdaamNTZXBlZlErMDR0eG5VT2l6blQ1?=
 =?utf-8?B?Tktoem1NQUdteitpQ0FuK3JSbUdqN0I4NUNxNGcydTRNK2JILzRKd0JLcGRr?=
 =?utf-8?B?V1JUb1BaQ0xZdHpST1E4Z28wbE1kTHU0Y2F0dFMyem9PZG5UWG5pY0QrS3Ux?=
 =?utf-8?B?K1krcW9aRDcvQ3VnUW0xSUVlcS9ER3dBWTkxVWJGSEhxVzcrTC83SE9KdmFN?=
 =?utf-8?B?UE81N0I2ckpXdlZBbnJNY3RabEtHdnBDTWsrMG1PYlh4a0tlMnRYV3dUVy8w?=
 =?utf-8?B?bW91REczQzEyc3B4Qjd3Z3psdEVVcjNFSGF5cHRVeWtTcTNudm9LK0tFYk1H?=
 =?utf-8?B?enhqQlhwVWN4ekJiTnF3UXpnRlIyRzFWU0JzK01aMlZMRjVUS2kxeUJhWFdw?=
 =?utf-8?B?cDlUNGR6dllrNktZYzdvWWZZaXpQNUMzQldENVpHWXdncGw1cjdGY0w4VDFh?=
 =?utf-8?B?YkxaeGx5UFpCbjZpZkcrS0szWVlVQU5hZVNvSzI1VXBGVVF0Nmc2TVJJSTk2?=
 =?utf-8?B?aTh3ZmZlbUNsN3hQRTJYb1c4NWRHMGg2YmRWSkdha1dRWE9OR1VwaStMLzE4?=
 =?utf-8?B?eWpta1VKZ2FFV3pncWdsRVBabzI4N2lLTVNJVjJaOVFLSGI5cWZUNUVDQnVI?=
 =?utf-8?B?cG9sektad2kwZ1pCRjJmcHhLN0xHb2FDRWVOc1lmb2w4T2pVYU52b09md1ls?=
 =?utf-8?B?MDh6cm00d2JObGxqVHByKzkxQVUzbEdQVFVBN2N2YytFMmlkUjNXS3FtNnBo?=
 =?utf-8?B?YmYxUmdJTjFhZmM2N0psQTU2dC9MY1hhbUNVYVdHNWxEN0RUbCt6N1RPczlJ?=
 =?utf-8?B?STNVSkZXNlcwOG5yKzR0eW1NMlZvUnJWQzJCanNTdkFHaUJmSkgxSC9DYTNO?=
 =?utf-8?B?MEtyRFZ0ZHBheFQ5WUpMb2JIcVcwSFhvY1JNd3Z4ZFlWY00wWmdUQXlmRzJQ?=
 =?utf-8?B?dTVURmpnWjBzNHoxWTZpazEzTm90c2ticWhlS0UvODVSTFZBZ3laMmNRRGp5?=
 =?utf-8?B?ZnZvOUJpa2NVSFRGelRtb2FiS3ZKSFlBT2svT20zOElaaVhKMFE5VStTVWwy?=
 =?utf-8?B?RU4xejZ5TlgzVlRDQjk2Z3BsTzQzSUo4QzBUT3pnN1U1aUVIZnhFaGJQTkZZ?=
 =?utf-8?B?cUVOMWhEazRLdkZseGFtUGR1dldMa1lWN1NYbjhITWdhRmhreVhzM3dRejlE?=
 =?utf-8?B?eFNwTlpvTUw5QVlmeUNkUHVZWEVpT2hWRm1hYUhEYlBWVGdQb1c5ODZkOWQ3?=
 =?utf-8?B?a2ExU3JYQ01ETFJCK1NUZ2FseUF1czk2K2dKMTNPTGswMUd1em83STZ4dGZ3?=
 =?utf-8?B?dG4raEx3bGVUU2dHZzF1OWcwUEZMUGUwclNUdEl5Y0RJUlhSUDRRVGhQaXdZ?=
 =?utf-8?B?Wi84b1ROYlZNeUFaZGRBOW1RQ0c2NkFlblZLQWlEajJiT0ZRTGJrem1UeEtw?=
 =?utf-8?B?eVpuYmpkRFZXZjdWQjJuTmxUYTRKU3ozUGhES3BGbzFDQWV6UVdHOE5zcmNC?=
 =?utf-8?B?aGlacTJtK0lIKzZMbi8vRkFrbEVtMGhaWXdHTFRvaWwxZ2ZIV09SZ1hhOElE?=
 =?utf-8?B?OTVEbU4yeEhuL2QzR0hROUt2dFlTRzBYSTM3OG1sYUtwbmYyZlU5UjZuekM4?=
 =?utf-8?B?UmJMWkI1dUkzZis2eHpPNEJGOXlXVjArWm1VSWZDQUEvRkRZK0E2by96NnJS?=
 =?utf-8?B?aitGdVNuc0xFZHlsclUxNWtkdnU2ZmtVbkFIRnR6ZnM3c0k2UzhBZE95MStH?=
 =?utf-8?B?YzNyRllsaGo1YlpMbXQwenhPZ1NMTFNrdmU4b082SEt0NFFSczdqMXdHTDYy?=
 =?utf-8?B?cU9EdXNEMEpKUFJlVVRjQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB7080.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N2Ftb2lGTk5CN0ZTLytqTjVzMmwzcDJtYUlvV3JUQW1WZTR0eDVkYmRlbHI0?=
 =?utf-8?B?RnQ1bFJxQ0NtYXQxQ0xYZ25YL2FrRXdHUkVJTXFGT2VqR3RaWGdWeUszRU5H?=
 =?utf-8?B?S042L1NhK0J1RjE3UXNpdzJuTFZYNmd2UGtvVy9nRCtvOWw2OTVVZVB4aGly?=
 =?utf-8?B?VHgwYnhPNlZ2eWlDSVlpT1BMQ0lKb093Yk9KUmlNYlZPdXY0MGhTYnZQSEcr?=
 =?utf-8?B?YUZVQmVlZW4xTDdNZWplLzdPYlRmMytlYlRsNUlDOXNYc0dmV1ExZmZPWXQx?=
 =?utf-8?B?ZU40bVZxYkJEU1dwTFRuSXB4K1p2MjVreEc3WXBObmg1bUZTVXZ5WlBHNks4?=
 =?utf-8?B?TTUvVE1IaVlwdlR3YTBiZGI5cDN2M2NXQU1FcjBSRDBIUlMza3FrV0dBNkcv?=
 =?utf-8?B?QmNRS3QwS05XRmZYdlJCREU1ck9YekFSSXd4T1hwYzFadlpJanNjTVZycmdh?=
 =?utf-8?B?YWVEUmQxVXRPeEJWUlQreVJDYVAveVRKZHNEbWxCZkdPNEZ6dEQxc0RKNnpG?=
 =?utf-8?B?eUIxRTRVNkYwS3RWajVUT3BFUjF4R21ua09jVnZPNWZBcUtaY0x0N0ljcHdP?=
 =?utf-8?B?TUw4UkRrY0VPa1UvUnh5RjJQVzR3OWN6Y3NISlBNN0Z0aWkwQ3JpWnljVkVH?=
 =?utf-8?B?MTByYXhCTjFRSDgyNi9CUyswQVJiOFRPc2VGSkdvR3EyVWdTc1RQRGdMdzRK?=
 =?utf-8?B?K1VqUlhHMktKTHBlOFVIbENDV1lNVnk5ZzNCcG1NdmxwNmpkZ1F6VHRTNG9T?=
 =?utf-8?B?cU5XQTJqRmpuY1dBVmt2NnZQWjlVNVNFZVJET0Z3OFVGeFAzVHRsQUdBMzFH?=
 =?utf-8?B?cEhndWlCbWpMc0lLWnhOMXBMMElBT1BCVXpkUThGNkdTWXdqVFc2cnBhME5t?=
 =?utf-8?B?dlN4cEZGSkh1N2NSREhKRmw2a2FzakZQRmxZNnhOd2thY2NjT2RhQ0R5Tm1q?=
 =?utf-8?B?Q1JoV09KZ1pFSEdoUHFTMFlQamVOUy9vMEVpM3R0a3d2TTUyUE1oSmorOXpi?=
 =?utf-8?B?MnA5SmxsZmc0OGNoY1ZZM011NVlXUDZLMkJJOXNxejM1WGlmQTNPeUNlYWYx?=
 =?utf-8?B?SGxLdGZxK0NYNC9oSFFCdWxja0VnQ3NhZWhpVEZRK0FtYjlkNjlvU3dqcDRr?=
 =?utf-8?B?ZEEweHoxL2VEMWthTmNMeVhzWHZEQkpKWG85d08vRlRkZ0NPbG5MTzRPOVFh?=
 =?utf-8?B?STNhbi8yTTgzNWpDOXpwTUMvUStBVjF3aUVyNXFWdEZhUHdDMzZBU1BGaGQw?=
 =?utf-8?B?ZXJKbFVzMVoyU3BPY2ZxOVlueVp0czhpMC9sUG5wQmc0Rit5QmdJeW5OTXJu?=
 =?utf-8?B?bmlHbVRHWGkyVUJzY3R2N3JiUDhadmZpZThzelNUQ0ZsYnNYZWlINGpTQkxx?=
 =?utf-8?B?emtsMmo0and1Z2xQMmV1UTBiSTNTR0hoZ0NrM0xoR1VyVHJ1eGZKazE4YURL?=
 =?utf-8?B?MUJ4cEFPZ25sYWR6b2xydGJmQk95Z0V3K2VNWmFUdmovWU5IOUtaUHVTcUpC?=
 =?utf-8?B?V1BVVHJnODFTTVhlamhsK3R3WUlMd2FUanJwTWMxYU1GRm8rYVlLVUlEaHZT?=
 =?utf-8?B?eFcvd1VnZUtjSnNkbUdBZStHN1dOeTdnREN1V0s3V2xRcE1UNWhLYWp5MFIy?=
 =?utf-8?B?emlwVllpelNWRnZhTnNHdDlkK0diUk1pUXNiM0h3OGgyRFNqN3dyQmliU1F1?=
 =?utf-8?B?dVFTak9JV0t3U3ZWdy9ack5zajJPV3Fyc243aWI3eHp6bHhTUVVuQ1QvUjJS?=
 =?utf-8?B?cTZFdm11Y3JNT0tkOC96SE85a0o5Z2tFbUhpM0hiYjlMQzZ3OWM5UFprRjBW?=
 =?utf-8?B?QzhpVVlOQ0h4TFdLU3VteGJ4a0JFODNzd296d0VmRjNlT3h5WWYzWkZFUXB4?=
 =?utf-8?B?OHk3ZjZrMU9MeWhlbkZSMjE2Vk1DbE5nczlZTVB0dlpRRGV1ZFE0R0kxeGlC?=
 =?utf-8?B?cHRUNTdRaFg2czQ0L3k1anEyc25TREorZXhrNlg0bm4rTXk3L1U4YVR5WlY5?=
 =?utf-8?B?SVMwaTI1YS9oR0d0WUErSVZubkRLZXFvZm5GMVBsOW93QWw0WHNoVVF1ZTlE?=
 =?utf-8?B?QStJN2JxRjUzK1RvU3JXWFRUbkJDUGR3S3JmOFRaSFpYeGRNclB4Mk8yL1hw?=
 =?utf-8?B?aXZrUEhJWXBiSEdvWXZsYzF2SE0xdnRPRGp1cGJRMXJSM2hKMktzTjhOZ3Vs?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1JSd9UBsPI8wuxc4WTy9TFrhbiwR7yzR4OUSTnObQQvJCLmSNmx7C6j6/+5XH0kj9M2gHcOjuSElg6Nr+/wlg+s7NIzQP8aCb7R86Ec75b34XNq2PyXGfb4R+EY2Ss64Sw+eo8x9wSpAFyZW8SMZefb0rGsieyuohJbh3oRkj1iF9quyc9qCVO9S84HyS4KtO9OKmlWuHrKz3pjhqb04U+KeCLm/Yu9aXYRYpL6VG2Au7i6HZOTuWWTz0vzRi65wRB7tdqMqZC/ShF9+dzbWZP1lN4CbA4/AY88b/wWkrCRjXIq5FXBHH43LvqGUi5CNMOUW/O8E/nxtgqZoc8O3reIOELNBCfzlCPchOyIOBBSAUvQRNgZ3xRZLsoDGXNSWEQXwH0/MWXyAH4ZIm/iluNldxWAEHBBd/0D+UouXocXD7uBUSnHQY+zroPkBqrk8isURR2qGlrmg4lNtKhpC6GxRiiiGsNXFevDdDozCiFG53RMG4eawxj0yh1VdopI87vBCnYjXWV/OXZNSirJWmVwJHAIbPJjdwfqelJgVEIZbf/XtHFarrlfEQdl+fU1YDF8ZO9l1lWzOfFB4sDaQGjlcbKBi1ddHJZR6wpB0RWk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffaac64c-382b-4715-8176-08dc9a68020a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB7080.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 07:24:28.4163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hiJjar0kg5VuT/Gyu9cBzeiy3Pg5dBq21fHSLEmiGlF5eNWVS1vru+1FmU8DEB1ZMrAjGZjIMKImVRkT6skJJqyDh/gY+Qp7vOJNhzhGniM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8013
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_04,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407020055
X-Proofpoint-GUID: PC-x83NJPLeejXW8bGpV8CFFR2mZaLt4
X-Proofpoint-ORIG-GUID: PC-x83NJPLeejXW8bGpV8CFFR2mZaLt4

Hi,

On 7/2/24 6:18 AM, Xiu Jianfeng wrote:
[...]

> diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
> index 79a3717a5803..7f5180a8f461 100644
> --- a/kernel/cgroup/misc.c
> +++ b/kernel/cgroup/misc.c
> @@ -121,6 +121,17 @@ static void misc_cg_cancel_charge(enum misc_res_type type, struct misc_cg *cg,
>  		  misc_res_name[type]);
>  }
>  
> +static void misc_cg_update_watermark(struct misc_res *res, u64 new_usage)
> +{
> +	u64 old;
> +
> +	do {
> +		old = READ_ONCE(res->watermark);
> +		if (cmpxchg(&res->watermark, old, new_usage) == old)
> +			break;
> +	} while (1);
> +}
> +
>  /**
>   * misc_cg_try_charge() - Try charging the misc cgroup.
>   * @type: Misc res type to charge.
> @@ -159,6 +170,7 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount)
>  			ret = -EBUSY;
>  			goto err_charge;
>  		}

you may need to re-introduce the check:
	if (new_usage > READ_ONCE(res->watermark))

without it, the res->watermark will be updated unconditionally.

> +		misc_cg_update_watermark(res, new_usage);
>  	}
>  	return 0;
>  


-- 
Thanks,
Kamalesh

