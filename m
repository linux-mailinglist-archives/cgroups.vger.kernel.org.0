Return-Path: <cgroups+bounces-6537-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87943A34005
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 14:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E853A6E63
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 13:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D842A22170F;
	Thu, 13 Feb 2025 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bm+7SXIP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lqZ0HWfm"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64F820A5E5
	for <cgroups@vger.kernel.org>; Thu, 13 Feb 2025 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452549; cv=fail; b=LbYl/bHaM1Qw/5nV9lexcz7DJVefb1qzXDIhFlPawTtsi08lLVCnEzCpGq38UlaY/wkAUK+LjTqq6luHSeFTeBftSBEsJ9q0qO5BScZhkulqGXCX6E5B3OP5mG1YWIgorfcW1Eaq6he5xwfBjb4njmdCDV+ng8c2O8/I5mUgzPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452549; c=relaxed/simple;
	bh=KcKTwnW0Z5dynNkGYKnlAh+2HHO6PJkuWMI+Y+xEnaw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YHaKdMqizRQX2CaoxiYkIGRPfhWAgTxK/+EIaRcRsti7crjGR9vF/vpQQe3GrUFSzBN0VeKAkV1AcVudGGglnFK74gfYbXA4PktCZWpNqJdxGOu5saiboDVGwzkJ4FCBcRCzbAJln1gUikIDij75wVmWhczVDZS33MLo6PXRjjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bm+7SXIP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lqZ0HWfm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8gFxK027363;
	Thu, 13 Feb 2025 13:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=3vFBIru+L5UVrc+B6FexkZbK3DBPybu1vlMfmHfb1Ik=; b=
	Bm+7SXIP8/9s4SFb5KpFNfOkG6cxdvqExXbJL/lUgeAkwircYwmjSWFPv46iVHbA
	28MfMmlppNv0O0a65zVzONi7qp6vQhPoKeugggo8WdPb6v4sdI/L85308/WQJuBT
	zL5Vr50q2vcTZJRx9uOanZi6LMIPmAkeTLqypFQWRkrFBsMIT8Ple8hNXBwhPI6X
	qjTifinZMzoUAh4Kn0+krhqVtFEM0Fvj/gJ63N5FcnUz5IUoXAvnqzGa/hZ/i1Vl
	wDVTHsNbf6NG4JVp8rxrlDpPTwaAfuu8wSma2VB3ZiB3JMgretceAGEp9bUOL6AB
	ScTuxKE2NlcFF+bczxLDqw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tg9n7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:15:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DC4UO2012412;
	Thu, 13 Feb 2025 13:15:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqbp681-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:15:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdFbjzdJlGJbUKZSJ0ph4HcNz6Ms7eqP854EAqiyUCHPeoQJ1OOBKRrE+0nxEAjFQTKQvQOJQaVJNdYGVLf3FVnBbO72jmN3Jd8eJIwhKYNECmb553qKoKmSOaPNo6J/jCpUFMBJGHwwVrV1GONIQqKHrpW91bEYsKgfGiafDtpPJ+FfuxstuEJZxWzn0NFKKHCu94ivFWYrAEQDyIwBysNBLV/NngpgQFMN/VEcmqLRTuNLfTburs9MtGY+k12F+2aNRdPjOSXdMgtlHnca4W74YL+B8K9xbDotaxG6fYPNmFRa6fANICVv4OPCeEwyAOamVx9ReocFUe0CMUgF5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vFBIru+L5UVrc+B6FexkZbK3DBPybu1vlMfmHfb1Ik=;
 b=nvlLgaYxrvrLNeiQpWQ8n5LWQkQ8ZYUfncBeFY0eJbc/sZuDy1owS6P5aMAvUjF9ZX+h7IWYU+bp9GGp5JJXuhvw+r6bLAX3byJQwbA+WvAKNFtdWU+DKsJ17qi9XYrYAlc8anPEH2J4s/I/qRdXM1K6P5MB3zqPENpJ6R2pS9e6P2H36cS7r0peeJWYpARbCKFUGHXp+CWDTbuhVzgag4KJqn/fGPnT6D8iccXN/9CnvBsZDC5g4/NnuOWzvuX75TVfBJBC3du8FSumgPCn84BhaT+le1cA5lu/mAvyPQbXhwVt1WgYs9flJLTCx+1Yx5PY26AJySLt2si9JykbOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vFBIru+L5UVrc+B6FexkZbK3DBPybu1vlMfmHfb1Ik=;
 b=lqZ0HWfmGrrmDG5v/ZHQStlbr8oqzDOO42Kszz/H02PWCVfAfxSODja9YzfAoOPalDfgBDcQO4LCSqVOXGyd91W9qTzwlTRcB0vb+tsZTnDKuO31mGeD+1tLRIuTdwIU3aKMbwz6regv+4Ai1NPWcYSf4v+qVtnzgU1GHjgot9w=
Received: from PH7PR10MB6505.namprd10.prod.outlook.com (2603:10b6:510:200::11)
 by PH0PR10MB5896.namprd10.prod.outlook.com (2603:10b6:510:146::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 13 Feb
 2025 13:15:38 +0000
Received: from PH7PR10MB6505.namprd10.prod.outlook.com
 ([fe80::83d9:1bf1:52cf:df54]) by PH7PR10MB6505.namprd10.prod.outlook.com
 ([fe80::83d9:1bf1:52cf:df54%3]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 13:15:38 +0000
Message-ID: <7baba4f6-3560-4965-b62d-43efc09555fd@oracle.com>
Date: Thu, 13 Feb 2025 18:45:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [LTP] Test failures obtained on 6.14 kernel in memcontrol04 test
To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it, cgroups@vger.kernel.org
References: <cf44d644-bfce-4c88-8011-7fa5c15a8d9d@oracle.com>
 <CAEemH2fxMxbApmaszJGLvRSG9e0T7ZAYUD=hxBSw9JFZgqan7A@mail.gmail.com>
 <CAEemH2cmPbDp15DOmOy3dmoLjRYHPcAD9Q_fts==EF8YDUJMGQ@mail.gmail.com>
Content-Language: en-US
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
In-Reply-To: <CAEemH2cmPbDp15DOmOy3dmoLjRYHPcAD9Q_fts==EF8YDUJMGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:820:d::6) To PH7PR10MB6505.namprd10.prod.outlook.com
 (2603:10b6:510:200::11)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6505:EE_|PH0PR10MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 89492fba-a77b-476c-dfd1-08dd4c30823b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmJTK1VzYTRzMFUzMDYzc2NLakE3K1FDZ3RWL1g0YnZrdFZLNlJ0VGRmVmdl?=
 =?utf-8?B?b0RzOHMyRGJEeEFqWHFIUWtTZFBUYlowWHFRWEhMdDdzRlFaeDdvU1lROFNk?=
 =?utf-8?B?RWVPankvWHNZRHBJcGdhbUp2Y3pra2lSTFNLUExyeEhoa2tidGNoR015TjFP?=
 =?utf-8?B?dkZDbGpFRk5qVS9mQUxCL1UramhibnQ0TFRZMEhSLzJCQUx5RlVMOHhIU2dl?=
 =?utf-8?B?ZkgyeGlXWXRQM1dXVitHN3gyU0d6cHBwT0dwN2ZaTHVGMGhXS1JkdU1ocDQ1?=
 =?utf-8?B?bmxXeFFWcHZJekxjbFlvNlU1eTBYL1B1SjFyMG13ZSsxKzBxd2VsZzM4a21K?=
 =?utf-8?B?WiszMnJtNUhPM1VqVmFTSG9ZTnJ6QnM3OTBSK0VmM2NUSGhRaEdneGs2aS9j?=
 =?utf-8?B?QUtFeXZnM09jdWNRRWh1SXVIR25sUlZjbGtvS05BcTE2Y1duZVFVd2dOK0NM?=
 =?utf-8?B?VTZSVCtRY2VFeHpCc3c2STBNUHNQVy9qQ0pRUlphUFJvRmhQNGk5WVNZZmZK?=
 =?utf-8?B?a241b3pmeERwaTEvUnhLS3I5UTJCdnhUVlVCWHZnRHhSakgybzdURklpVHZn?=
 =?utf-8?B?UzNTV080NXQ5Um92T2NidGVOd2d0YVAwa3Qyd2ZMZ2pxdTBuSStwYlpvTm9k?=
 =?utf-8?B?TG1GbDNYT3VpNGdiR0JOTmcyTjR6bzYycmtPSS9nQW9vZm5tdllYVjY0TTVx?=
 =?utf-8?B?aGppOWFjN0FHeFF5aEhuY0FYcWVhaGRsa3grK2lUODcvTlJvOTRlb2JubTFB?=
 =?utf-8?B?NUE3N1RTTGwvZCtRNU0vWVRhQXVOSG1SWFBCTHg2b01pbmpnMGpmdzFWOUxl?=
 =?utf-8?B?QzBDUWt4NGpTZVk0SkFnN0R6SzlWcGhhSVFyd2ZSellWVzhobllVcys0dDRG?=
 =?utf-8?B?UUJxeG5maFhKZWpLTlIwWjRqbzlwZ09kS2IrdHBaeldHUStLT2JLMHBzV2xi?=
 =?utf-8?B?dzZzZWdUUzdzU1ljY2VOclgwMlV3bkVhTk5pL3luS2JMMVZ3V1o5NysvTGNU?=
 =?utf-8?B?UXNHaWdEQVEzSjhLMzF6YnRGMVIwaUcrMnpIaEZxNXEzN1VrZW9ING9kYlM1?=
 =?utf-8?B?OWFkQ1dGRTFHbzI3VnlPSzAwZzhBdXZ4bVg3Uy9UaytvRkVkTVdSZzE5S2lz?=
 =?utf-8?B?OXdlTzVJNVE4UUgvRTJjK2E1a2hGREhDSmlFUVpXMHRibTBxZnM1R3NZVytt?=
 =?utf-8?B?TXJRRnRvWlp1NjJjSjBrSEl4dHJNRkFpU2FCclI3UWVicDB3c1FDSy9rYW50?=
 =?utf-8?B?YWtDaStNM05uVFlFTmErQkpjSkRGOWJVRi9IbDF5dllheXU0VFpBN2JqZHB0?=
 =?utf-8?B?VFFrc0NCYnAxaXNqZDRMblRnYTV5bDRqd2FzMUlaWktiWkF6dnhHZFRvOVh6?=
 =?utf-8?B?MDhzZWpnSlRYemFaM2tnYzBaVFZreUd6dGJsYVBKUFNJeGI4MnBMY2laakg1?=
 =?utf-8?B?MDRNdGQxYnRKdHlCbXFTRndNNFhQaVpHb0xPeVRuUEtEWHY5QWtmTkw3NElm?=
 =?utf-8?B?SVY3a0x6NTcvR3F4ekRmcVBHcHB6WTN6NUllcFNja0xkTHJzbHFDcE5IZlQ2?=
 =?utf-8?B?OTRleXJJSWgxSDlMMHBlbEJzYlMzczY4M0VsSUlmc2JrOUNKVTJxNEVEcklk?=
 =?utf-8?B?N0xkWTBveFRQZEFPREFhNkVXQVlzTmJzdGpuRmdRKzRYdE1TN0dBRkVwZGRZ?=
 =?utf-8?B?WlN3ZXd1WkVYNGVQNGk2NmlUTHlteFh0NUtsM21MNFp4ckM4NUszMyt5SWxY?=
 =?utf-8?B?RER6VzdLbDdKWlZ1SEJNb2NnMXlmQzBETFh2aVBxU3ZVQmdQYStSclJneGl3?=
 =?utf-8?B?ZUZjRytwNi9Oa2xITCs2UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZW50UW4wUzlyTlJ3UVRTQ2NvclR1eFBIVWthYmdwNmlkRUw3MGJwNmV4WGdZ?=
 =?utf-8?B?b2hlK0x2TFdEbEExbTZpMTBzd05pYjhMZTQ3ejBORWw0Vnp5YVhHU3hsRmdP?=
 =?utf-8?B?RFVXc0N2U1V4WUdUSGQxTUJkaTVOWXZKTDdZMXNqekhkcVVoV3VXL3c3TlI4?=
 =?utf-8?B?cnRJdzI5YkhITTA5SW13YTAvK3hqSzUzSWdrWXFkWUV4bkpQOElFZ2lMYkdW?=
 =?utf-8?B?QW43TldDK3BOTXVUSjV3eDJ1MmExMm91ekZtWGNZZWUrTHk3ay9pS1pvakxF?=
 =?utf-8?B?ald5V0RDUXJIaUwvSzkzdm9QL28yYmVqZ1pINVBBcVhQbSsrSjFHVTZwcmFB?=
 =?utf-8?B?K3MxdzdtSGpjbXNEMnRZUTcxYjdXWThDREUwZ09wMXlkNXd3YnBUbTlsb01u?=
 =?utf-8?B?L1dQWHZSRisvcHNjRHZ2QkQ1R2s0NUkyRVJXdVBtOE1YclBQV3VCQ2VnTE5w?=
 =?utf-8?B?WU1ZZ1diVUQ5Z25MM3M1TnNmY1ZaMkc2cGZzaEQwMDh2aVlEMnZQU3haNTVD?=
 =?utf-8?B?K1VYbWJHQTdEZXFOVlFjVHJFbHZsSWdzakZINkxUVEl3azZCREZxZG8zK2dI?=
 =?utf-8?B?S21sVmJCTmtiSkpsa0Z6aGgrdjlLWStCT1ZPaFlPY0ZUWXQ0K3dBbzd6V2Rk?=
 =?utf-8?B?ZytLRDJ1NVAvcTVINU9ZVzZScXBjdCswbVRaWWdseEtkKzZUYVI1M2QwdmxR?=
 =?utf-8?B?MWNQNG1ZWDJSL2tVTEl6M0lPV1FQanJRRlJZVUczNWZSQ2lTaVVqWmN3ZGsr?=
 =?utf-8?B?YXZ4UXUxNW1tdnJVZytkeElnb3dsWFhwVUxaeWt5TDNIdG5hb3l0djA3Vkt0?=
 =?utf-8?B?V051Mld2NTcrYlhLcGtudHRRR1lZOHVQRWg5aHVvRk8xSjFSTlYvd3k4eDR5?=
 =?utf-8?B?UW4rTjIvMFJyN0VNLzl5ZEluNUdLM3lDalVqU0hZL1N0a0dlbzRuL2FTMnJn?=
 =?utf-8?B?dnlZb3pNTjQ0THdoWDJYQkgwOFowcUhQdDFUKzBKMU94VWpVaDdjaXVXeDBW?=
 =?utf-8?B?dmxyM25IZFAzWW1ta2FHaXR1WnRpbjg4bUlxRWErM1h0VzA1U1hTbS9Gd2pT?=
 =?utf-8?B?VWFkcnBVTGZWYXRkWFM3dGJpR2tLa2F6czBQaDM0b1dPY2hPR2pEQjVqVmVr?=
 =?utf-8?B?cWlKdG93WmlBSGsrVUxVZHovanZjWDNmMUlidWpBSnRmNzVOMFpwMXlHZ2FV?=
 =?utf-8?B?WC95M2YvS1JZN3RxdFpMczJpaUZFNG9vSDF0UTNSQmVreExjV1Z3ejFwMnR2?=
 =?utf-8?B?NzdwSTJDOFB5bDkzbTRlZ0VzZEJIRENVTisydVB3aFl2WGxuVmc0OTRQWk94?=
 =?utf-8?B?YnVldzJXcnVIa2dPM3laWWROSmhTZmFoV3dMVHBVWEYvZnpKdzNPWWROZU5P?=
 =?utf-8?B?YmJXQ1locC90Z2VwdzhKM01DRFk0SW5WQUo1T2Q4dDJqTVBiQXI0UVFFcUxZ?=
 =?utf-8?B?K3kzd3A0STNNakt1Z0ZYcGxpc1Izd0dTdW5NTWlud0hwd1EwRFE3OXgwUzM3?=
 =?utf-8?B?R0JmaEVZRCt4UFJFR1ZJOS9JSFlibHpDSnc0dDN5b01HejArSnB2bVU0U1gx?=
 =?utf-8?B?RUdWVXRBakFyUXlZZXdrUlVwY3NUemtSc01vcUJta2Z1YytLdVI3NUY0L3gx?=
 =?utf-8?B?U0xuT2VzVHBnREtJUUl1VE5lMFdZUWUrNkVHZUtpT2pRd3JTR1h6eERmWlNB?=
 =?utf-8?B?TmZ5MUVEZHNtcE9EQVNFQ0tpTHM0RFMvUElOY0hpN2lWWllMTGZpd2F2Q2hj?=
 =?utf-8?B?YmdHblNIZlRsZ01pUlNBY2xkVW9BWTVKQStCSDBYejg3M3NiK01ROXZFNUN6?=
 =?utf-8?B?dC9Ia2pxUDBqbHk2bGJhcmQvaEZjbXBNZ0NocUNmTzh3SDdKZFJKRTluSUc4?=
 =?utf-8?B?UlhtSlE4cWdNeUV2djlPbGw5OUlQaEtiZVY5QzR0OEVxN1R2SDBPbWFCc1JK?=
 =?utf-8?B?NGovaG9WUU1YaXhyQ3o3QWhRRzlVZ1RoS2FJd1ZGQ3hGUUtOTnRTOEwwYjdo?=
 =?utf-8?B?WHViVUNNWGRBOWw1cDh1RnBxdjhGb2hIMFo2Z0hpdzhyQVFveEIvazVqcHRX?=
 =?utf-8?B?ZEN0L3pheUxEbmVZcGhIM2RGdmlJTmdOa2F0UjUwQjhhRmRzZXBrQnJXN1hV?=
 =?utf-8?B?eXd4MUp5L3dBRVVjdENPcTRaUkNSTW10Uk93UXBqVTVZVVpXdkl4R0Ywa3gy?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iNIMN4G5498L+9Syq/VZLodJEqSz5+kYNa/baByui0SDkDGgW9+W8W4mMqUIKviufiuP1wiPd7lq/ImY4CjzlYWOrC76TMQqSN+W4w08jt/etGiol8TxvIG5e05WJUwWtn6tXS3Z+y9E7TWQ/HxZD6HaftgaHPjEQi5gIctRu84j2jpi/sHuX5RYiAmWUxnQDlyjHOEnlXyvIlV8VuydhzK+ZHiUw01K2dVzcbaG0r+ABKhYARF37vDm9UbDDASYWiA1V5RcTDymK1ouRmf0TkNkDajtLuI7v/ZKiOMutyuYLl77FvPlRU/sk/z/kROCo0sYj2E5cxZABTQfqUl4+v28iEsChExdz33X7K0sGlkIOeTthfQBwCLAkmK7tpjOMzH+CukBHZtvRrWF9THBYahoVC5iNoJgJAUVRYC9Sd5i1wnbuOv0kiiP88JHQrCvwFdAUcXMBzR3BQswzdNGc+MlIY/Kf81Wbn1uBZFIOB5grdKbkXUz1ONhww/A89TGNbQNBtNly0lmjisL7U9VF1cCKm34vWCOUjwPTQyaFoLeb27+Hvr93ZBZJZugee823iWEToELJjc8VRZqlJW/CiWfsOT7gjnovxJii86DXZg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89492fba-a77b-476c-dfd1-08dd4c30823b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 13:15:38.6756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqQOFz3oSAtAJDJ5DMJxsEz1bnV0oJkXU9xcQyr8oADEZIW+ugnlJvgmBTIHPEFRTDmHAHySLT6u8OKmEXoImL4Kf9+oVGgLVgPhyJWKC5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5896
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130102
X-Proofpoint-GUID: J0y3FNKZXe_tPEz3CDwVbAviHPtZBJZx
X-Proofpoint-ORIG-GUID: J0y3FNKZXe_tPEz3CDwVbAviHPtZBJZx


On 13/02/25 5:47 PM, Li Wang wrote:
>
>
> On Thu, Feb 13, 2025 at 8:16 PM Li Wang <liwang@redhat.com> wrote:
>
>     What kind of failures did you hit?
>     Can you try this solution to see if it properly works (with Cgroup
>     v2)?
>
>
> I mean this:
> https://lists.linux.it/pipermail/ltp/2025-January/041653.html
> <https://urldefense.com/v3/__https://lists.linux.it/pipermail/ltp/2025-January/041653.html__;!!ACWV5N9M2RV99hQ!MNBFhOrfTUXbdjG8HagfmItqqD1I1N_dn5QjlWv9i-KAeEJHS0Nq67fE1spHEQRD2ia4G0PdnZQX1bMrP8qCPQ$>
>

I'm not able to apply it:

❯ b4 am
https://lore.kernel.org/ltp/CA+B+MYSmAjFQTbt98AZj-CRFSWT-dMc-3dAd5mQ=S6rDEYq+Sw@mail.gmail.com/
Analyzing 5 messages in the thread
Analyzing 0 code-review messages
Checking attestation on all messages, may take a moment...
---
  ✗ [PATCH v3] memcg/memcontrol04: Fix judgment for recursive_protection
    + Reviewed-by: Li Wang <liwang@redhat.com> (✗ DKIM/redhat.com)
    + Acked-by: Petr Vorel <pvorel@suse.cz> (✗ DKIM/suse.cz)
  ---
  ✗ BADSIG: DKIM/gmail.com
---
Total patches: 1
---
 Link:
https://lore.kernel.org/r/CA+B+MYSmAjFQTbt98AZj-CRFSWT-dMc-3dAd5mQ=S6rDEYq+Sw@mail.gmail.com
 Base: not specified
       git am
./v3_20250115_guojie_jin_memcg_memcontrol04_fix_judgment_for_recursive_protection.mbx

❯ git am -3 *.mbx
Applying: memcg/memcontrol04: Fix judgment for recursive_protection
error: corrupt patch at line 56
error: could not build fake ancestor
Patch failed at 0001 memcg/memcontrol04: Fix judgment for
recursive_protection
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".


>  
>
>
>
>     On Thu, Feb 13, 2025 at 6:57 PM Harshvardhan Jha via ltp
>     <ltp@lists.linux.it> wrote:
>
>         Hi there,
>         I encountered a few variables for memcontrol04 test on 6.14
>         kernel.
>         These had cgroup v2 enabled. The failures disappear whenever
>         cgroup v1
>         is instead used.
>
>
>         Thanks & Regards,
>         Harshvardhan
>
>         -- 
>         Mailing list info: https://lists.linux.it/listinfo/ltp
>         <https://urldefense.com/v3/__https://lists.linux.it/listinfo/ltp__;!!ACWV5N9M2RV99hQ!MNBFhOrfTUXbdjG8HagfmItqqD1I1N_dn5QjlWv9i-KAeEJHS0Nq67fE1spHEQRD2ia4G0PdnZQX1bMubNlpmA$>
>
>
>
>     -- 
>     Regards,
>     Li Wang
>
>
>
> -- 
> Regards,
> Li Wang
Thanks & Regards,
Harshvardhan

