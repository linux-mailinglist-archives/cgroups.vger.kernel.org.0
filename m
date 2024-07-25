Return-Path: <cgroups+bounces-3894-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B294693C080
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2024 13:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9201C21586
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2024 11:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A931D198E88;
	Thu, 25 Jul 2024 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ihZ+Cx1Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GhBqnD6a"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD44EAC0;
	Thu, 25 Jul 2024 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721905318; cv=fail; b=IhrxqjrsdxV3tqt4njy+xsCTSI/RTngjiT3hayy/5FR80hbiWfhbR6jwMffQzISr8p1t/8MvDjpGRnxe3FqOv5mrHprhnRx2mIM6vkBnbrMETbVWHfx2QAnRxDPuWO1esVQhf/O0ol/ar/2g4uIO75GrfdSrYAdG4jhdXEGEpKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721905318; c=relaxed/simple;
	bh=J7yl7VD5nEozyoIWupyNIx5jOM5YbSVLQZhcDzhl8Vc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sSl1clzZ/87c95MtL6AMQOBiCUao9+mW/HIvwFJF/8gFcy3tkrQZH3W+Stmn5C8o+Ik/s5FSh2wiHMplAbrylB3caGicoF+trgmFyApWxESkheOkna9w2CXuQhfGf+vBzAYIfTNC41B66eIIUdo0SOpnrwwaRxz4Ts51s1t5lKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ihZ+Cx1Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GhBqnD6a; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P8fWj4008104;
	Thu, 25 Jul 2024 11:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=qDQZ7kFUDUGcKCqaloQ1lqrZLJM5to02Oj+oQegK24E=; b=
	ihZ+Cx1Zfk+T8aC2Lz8GtXw6SrNOMpiResonHC+DtJVw4zqvFuta36+2mYTj642r
	O6iQghT4/CUGo+encbP61a8LeFOyUXyqw8+0jTmnAFUG77kV0HR/4UPeLu8bOFQy
	tUZmA5JLJK8XkJz4UzeanCM3MM7frMZwxzfpggXiUqFTOVLCFMGeT+YWWtgoSohg
	TE+Tl/HvVNDN5tkZpb6zijNi1TkRMIkmsGdxbd6olFd95csdaZQ/Sn0Pfsv65VuG
	ytHJQmt9NXSSeZxBM6Mm9sKOFAtzo4CUqp5t1K6AxJ3fIWobk8W1gSloHUfiW869
	qED1soxLmFmEMxN+JDf1Gg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft0k3hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jul 2024 11:01:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46P99ITn010739;
	Thu, 25 Jul 2024 11:01:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h282a5sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jul 2024 11:01:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAGLR6RgSjNyufEQohV4ZLQG4lYJeIBM8rALhC/5L3HZ4MzJSjl3HTd7V5gyRWhEYjC2vUBZOylUAD8XsYsLh9DAjEU03KKQL95oYOCzt/X8V2NruwYRCa23uCIW/gCXgDZ63dAG+32O6ew//OtHhAMkvypM8GscU2lrjhWmhCykS5/kBjp25KuCnz6WGpLzu6KJkqLW8HsKyyLZHp3nlHpk45rHfCQmx+2mKdswJOFQCNWVB/44X2NXsVQz56uH8peUvFhhFVBbQRPp277jgkJrjnWi693Y+gWyeaBz+8+f/LzFgNyNuW/2btqAEUK8dcXmiIDDKTThf1xx9sX+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDQZ7kFUDUGcKCqaloQ1lqrZLJM5to02Oj+oQegK24E=;
 b=ujwjt6ajZK6hQjSogLZAbk6P4mFU2a2xUlT8XKeOHlaOk+ta/3xNg9zHLmBoe7gnjQsWemdQsnDvo0pFTX8vZf0lZfkVu3vH0mAN6arVCuWMNTY/vYc2NNZHvQNS5Th7eLzmAKte0BZs8+jqfgpEdNRAmRRQO3Xa1DFoRa3cRx4iagqJuo+uMRyPFHwNhLJg7WXx88aZNbV+0aTHFCl8bU4RVOJb0jz18oymoZFKBiVOXYTzoOdoZUW/I5DD5emK5/J/E+Y/F0Q2bMUcnU+/bjLJO9ycIKB2PdpmCI8nDrHGqRFOJ45+e4W6DUYmnRFYLJaC8Y8hJ4PIbTKcOjfRsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDQZ7kFUDUGcKCqaloQ1lqrZLJM5to02Oj+oQegK24E=;
 b=GhBqnD6aDClw+9yjU01DBoytj+3MLHT01+gke0ljuNbbPqMcE01E62IsS6aDxXy9QWVNBFbeUKyA0NjliHe0TgkATfQ9MFR6i24uZlRHGKsA0sEE9RF1prlGGwFiyVy9bdMo1T54jiBmMnrDKRznsqVb+bdAKb0i9Ki+LDhfa7I=
Received: from SA2PR10MB4777.namprd10.prod.outlook.com (2603:10b6:806:116::5)
 by DS7PR10MB7300.namprd10.prod.outlook.com (2603:10b6:8:e3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.28; Thu, 25 Jul 2024 11:01:22 +0000
Received: from SA2PR10MB4777.namprd10.prod.outlook.com
 ([fe80::1574:73dc:3bac:83ce]) by SA2PR10MB4777.namprd10.prod.outlook.com
 ([fe80::1574:73dc:3bac:83ce%6]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 11:01:22 +0000
Message-ID: <e5c92f54-d767-4e71-9f57-9352923bd3e7@oracle.com>
Date: Thu, 25 Jul 2024 16:31:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup/cpuset: add dec_attach_in_progress helper
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
        adityakali@google.com, sergeh@kernel.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240725015551.2221867-1-chenridong@huawei.com>
Content-Language: en-US
From: Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <20240725015551.2221867-1-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::7) To SA2PR10MB4777.namprd10.prod.outlook.com
 (2603:10b6:806:116::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4777:EE_|DS7PR10MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f395a2a-b50d-4fbe-2a75-08dcac991eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnU1T3lqLzZvZnRCOHdQZEhBNkVsd0RwZ1VBZTM4REVnV2F2dXRiUG84Mnc1?=
 =?utf-8?B?cE9Tak50OVRYU2o5K3dkQU1lNmQyank5ZlRYb2tuR1p2Z1g5VC9mNW93SVdE?=
 =?utf-8?B?cXRncW1QMTlRL2Ywem52VmpXMDdZbWE1RFBCbkVZMmhHZkFLTHZCYTQzTktp?=
 =?utf-8?B?eCtpeTFzcG1udFhqYjJjMi9yblgzdUJBeEQ0azFGa1BXWVdkZGxncEk5bStu?=
 =?utf-8?B?Y1dzUVQwQnd3ejdKRWhjRVQrbjV6U2k2NzdsL01PclI2M0thOWtDZC9hWlpY?=
 =?utf-8?B?YkZaV0ZNS1FpVkRNdDE4YlljbFJYQXVpM2FEd3BGNC8vTDhkWkU3a2ZLTlFJ?=
 =?utf-8?B?MG1kVDR0SGhpQzVJdzZtM0pFNTgyb3B3OXJzcjB6cDA2cmdmWmFNdzBJN084?=
 =?utf-8?B?UlJybEdxYW42MTNXTHFTcnZZemtjMUwyTmVKakdPYkVOaHY5TXN1YTNkbys3?=
 =?utf-8?B?bHdqNm56d0FubHorY0drcG9BTHFWRVkvbXpWNlRwYkFaV2VXUUtiZDBSVTZa?=
 =?utf-8?B?andJQTJCcFZmeWhrbW81RkQrcWIvZWZzYlZZVXJLTWlmYS9Eb2RzRzJDdHdp?=
 =?utf-8?B?WHE4WmFPVXo2VmZ3RzVaekY3ZzQ3clhkWExIK0U3a0ttZ3QvTC9hak56b1Vn?=
 =?utf-8?B?SHErOC9BTjlFQXlzUUp5MkNMRVBaT1lNZ0xCMUZFYUtXNGl2LzFVRFNXWGFP?=
 =?utf-8?B?WEZVMzA2N2pRVkp2UUZMdUo4NVpLTDdjQllsdGdNTFY5dnF1eFNPYlFkRVNi?=
 =?utf-8?B?YzNkd0E5UU1zdDFIRjc2N2JYVGs0a1lLTnpwakN1Yk5jY2pPTDJ1b0ptcUtq?=
 =?utf-8?B?Y1hybFA1QnJYRzJoUytwa01UVzBRUUc3dEQwVy8xODhtUDFrVTFaSUdGOFdJ?=
 =?utf-8?B?Z2paVHUxQzNpY2pQMUp4UExyeGU1VTZYRWpNYmdSQ09sd3VEZlllYkJkZGNG?=
 =?utf-8?B?MkZ3UFVORmMxSFRBMy9WR3dZaEtTTVRLZjc2ck9HS205MW10WEpIYXF0bUtL?=
 =?utf-8?B?WEUrS1hyVHFPYmpGb1hVZUg3SVNqSmozWE1oL1gzeFNwWFJEcURQTzNXb1pN?=
 =?utf-8?B?RjNUcTc0K3dJaUZkVzUwWmpYelo1TkFtdDBvN0lvOGt5aXd5b2tjdHdmbHlV?=
 =?utf-8?B?UGxvZmowU1pZZ042TGcxUkl5OUloNEw4Yi91dU5YbkZHNkE3NTdkRWF0c24w?=
 =?utf-8?B?TGxkMnlqbG1GYzJ1M1JTMWxFTWxBOC9YVTZrYzVvb0N2ei9ldS8yUlEwL1NN?=
 =?utf-8?B?V1lwQ2JpT1lIRGlJTk1WWTVBSStwY0wraEdabkJxdmk4Vk5PUlFJci9tYzMy?=
 =?utf-8?B?STVpNVMvSVV4TUZ1d0FyWHlCRFVOeDBXQTRvNDViU1VGSHB6b0F0MFpVRHFV?=
 =?utf-8?B?bVdvS09VVkxnR1V2c0N2YXZkVjRBYUJTL0pDcjJzTk0ycGEybXQ2RDdqaVpY?=
 =?utf-8?B?Z2V5Z3FBK21XZDZlQ25NRWFIcXBVN1BLMEZUSU50aE13Ty8rVkFFcTFoY1JG?=
 =?utf-8?B?aXM1Q2hvN1RUcE1hbDVQQXBONEVZakwvWUVCSHBHSjFwQlN3eCtWRHl5RzVp?=
 =?utf-8?B?SDN3RDNRK3k5dW51TFErZm53eU5rTTlsYlhVeUV3TlB3KzlHakxUQjZPRWE5?=
 =?utf-8?B?ODlKRVNHNURWdjBOc3RLNzlPVFk1MTBTSXBnM2JqdGxNblNNZEw1SHNIYTFU?=
 =?utf-8?B?SEcvVm9tdWRFOFFubzY2V3BxanlRMjVMWFhpSUhWTThmYkR3Ym1CaTB6cjFD?=
 =?utf-8?B?eFhSdnFkeDM2eDJ2ZHVHNDZ1WVlzbnlScFBwUFljYTBPT2xxZTJvZzRHRWZo?=
 =?utf-8?B?MDlHUXA0L1ArQmEwOFU4dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NW02cUVNWE1LUk9VU1R2TTV0d0xXeXF0ZUJNMGM5Snl5ZHJrdzdJUWN1eFpo?=
 =?utf-8?B?K3BaMEdRUS91Rmh0MWcyT0tBQVRBOFVaYTVhMGljOEF1U0V6cWJRdldNWkQ4?=
 =?utf-8?B?bk9ZeStIQ2lCaU5aRzJvWXZpL1JkTnZlYmRPc05Bcm02dEI0akJxakVDUUNl?=
 =?utf-8?B?ZE1FL1JoMHU0YXI5azBYWGpUQlpucnVpekNkVk5HUk1CTXg3ZExWY0M1RnN0?=
 =?utf-8?B?QUJ6SmljQ2ZMVzBSMjB0UjkzL3hJZldlZVZqQklRbU9UZnBaM1pYemFEblkx?=
 =?utf-8?B?Wm5tZ3J1WVVvTHV4WXpwRHpIRFpIQytXeHRGWjI5RXFhTFhHdjJ5cW9IaXRG?=
 =?utf-8?B?ME50QUtNQytYaEVoM084b3hldWlicklMZTU1YlQ3dThpRkhySk5nVzFWREJq?=
 =?utf-8?B?M2RWRXFXbWtrWE5Fb1lkTWlsd3d2VU1Cd0lzMEI3RTNQd2xOUUhGekpXWWU2?=
 =?utf-8?B?bmhVQ0NjT3lWZklxMVlkeGY5aUdTRGt1ek5XV3dxbm9XNFdQNkh4d2ttbEhh?=
 =?utf-8?B?TU93YitlblIwZUdMRjd2VXNQRXRQZUh4M0Z5TGtFckhpU3ZtL0V0Rlgzdm5J?=
 =?utf-8?B?d0ZHYnF0MTNNdmlZRklucjRHM0NBOWVnRGZvVXoya2ppVlRWcGo2QW1pOUFV?=
 =?utf-8?B?T09ENWVIekpieCtMMVMyeDFSRVh5ZVJVempQbkVNazY3b0tFanVqLzR3VzN2?=
 =?utf-8?B?TVNIM0lZT21WeitmbUgrb0dtRXJ5ZTFiTVMxZktKaHhjVWNiNUtQU2M4K2VI?=
 =?utf-8?B?VEt0Zys1RW5XY01aNmx6VkhER0xhcUJqNlFDVnBkNWk2ek8xeFp6YXQ1cHR6?=
 =?utf-8?B?YTFQaXFoMkhtZ2ZJVTdYdzJvaWp1M1RQa2ZPMkxkMVNybktNV2pqWHBYVkUv?=
 =?utf-8?B?SDNOb0lUWld1L0xzaDc2L3NRL0lPbFZkNnJWWUNNeVY3Rm1RcmxsV2kzeC9z?=
 =?utf-8?B?UlNDOG8wU1B0bTdVNHFjYVdlbVUweENHVjQxdDhUeVN2ZnkrdXpVcGNmZFRk?=
 =?utf-8?B?WDY2UERiQTJaQWQvbE96ZURiZGxEa3NLMkh3R1FJWUE0VUxJM0ppNHMwMkhQ?=
 =?utf-8?B?eUFrT1N2K214VEZodjFyZHQ4QVQzcUtKV2t0RVptTXdmbU9Ic2lHM3dPTUJJ?=
 =?utf-8?B?NTc4N1VjNjNZcGhLc0JnU2tQcS9WVzBOOGpDZk5HekJPM3pRMTB5QWdaNWhN?=
 =?utf-8?B?MENreGVmSEhmWTluVTVWZElEUFFUT0F2OFJjUjVWbkFuWXlKcmRIb05jMVgv?=
 =?utf-8?B?SVBZNFl2WWNvQ0FJZ0JCS2hsNlZQS0o4V1g0S0hIREV5VU11dWw3T2dVODFO?=
 =?utf-8?B?SlhNV0FjZ0NYNzFjRTlrenB5OERFay9Eb1dPMVhaTUFZS2NqbDhvMDBIQ2w2?=
 =?utf-8?B?aitqYmhrTGdOdTlqbjZ2YnR6WDltTUFwKzZHdXlacldkRVR2QTdrQnNCbExk?=
 =?utf-8?B?MFhYZUl2YXVhSEZQcDlMUVNpUmkwNXUxRzlSQ1hwWDlnY1JqbktZTitGNVdk?=
 =?utf-8?B?U0xreHB4OGlWU21mQ1dGaEE5YWR6WmlTZ1QvTzBkbG8wUitjTlJ1K1ZoelJN?=
 =?utf-8?B?Zmdib0F3azdkemd1TzB5M2k5alFiUjAwUDZHaWwyajhCNnJEa2hWa04vUHh0?=
 =?utf-8?B?TWw4eHp1alVRbG9JWEhCZGltQTZFS0FVaGo3Yi9vV3hoVEg2TGx6SU4raFF3?=
 =?utf-8?B?VHpnVDk4dWY1MjZEU0hNWUpFcldMVWsyUjZLVXZCeVA3R1BBaXAycjYxbHFD?=
 =?utf-8?B?WFVEOEF4OElUOEZRY0dJY2hSeFpkbE03VklkdTRSdVpZbUtQTFQwQkFwQUJO?=
 =?utf-8?B?UVpneFh1OHh1d2ZVK1ZCVlh1Y3pJM2U4TnhIaVh1ajNGMU9TckRnM2s4ekox?=
 =?utf-8?B?RUFnVnU1aXdmUHFqaEhDMnNaSW5xeW10d3JwK281ZVNMS2c2dGliVkQwdTNR?=
 =?utf-8?B?Yi94c1pZaWdsWlM2VnJEemY5R3JNV04xdHY3K2tKd09OTVZ5am9YVXdzNjQ4?=
 =?utf-8?B?VTNQbGR2b24wQ1duTFhOWTN3dHpHVW1KbHZsMXJlcm50UlZhWUUyUUFDcTQr?=
 =?utf-8?B?MXVXdTFtSVZ2YmwwUXZPeis1M2NnNnNwZTlVMERxRjVHbmg2T1FKSTA1ekRS?=
 =?utf-8?B?WUIrbHdoazdJR3J0K3NNS3hXMGdSa3RXMEpJTlFCZ3dsODhmZnlIdU45VjRs?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	45KLjdZ/08DLoxSdz/305dyGvgcVr0AdMt99BL5XRL+SZhLeJ5ENcZGjWIe/s8SlfnhCxMxeRrnH9KA7EJFa7BVpL5v5G849psW52JvYH6AN+4pXN2DxRC9uqM/IPIBcaLr25Zxo6cgDZoGZ8nmoIGYdy5G8kZTvFhKfM5iutPgDU9T/1580DVtGdSWz4YBYlRQ+jMk+r2xh/RRmgx0NxwQrbIwJci7X3X3+G1jEbsPxZpSEt81M4L1ChNpk864bVqv7fBPenRBe238YVbMjNrEfWtw8EFoc3P4AwxAgHkghtX8V2udlJHAp99kIkyBJpzv0vsEE1PsWOlXu/a/YYi5il5cfz2K8MjKqpI43D8ViKtc9OI0pAjRrymYMI7q0Yvo9zexGc+22bD4gC6vmiKCx5LBqQggnVzwb8hmJ5kg9LY2eg03ZysLPcN8UJPj1XmMZEPNOIrasQHrXj/W2peL4momxKs1eazJMk3w04FTrNFSBCWejotpq7SBcK8sNl7RoiVU1zjiGj59zAIrVcXZLErrIdBJ62/nvY19GAk23RgClsHmrpFjMn91ZS+OFcfaX1EutUjEgLGwFDcF8RlshKcXKZ/2tsC0veoM2bkM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f395a2a-b50d-4fbe-2a75-08dcac991eb6
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 11:01:22.8284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vea+brRT2/q8Dbz+L8Q0GSCRjLTMn4qAsSkkjUw+FWeJdROlOVIosyiYzh1CjqTbZJMAplgVonhqjQFMtwL7NDyG3hSS7SwAIbSf8OeaByw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7300
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_11,2024-07-25_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407250074
X-Proofpoint-GUID: HCSfov8HCzhxCiP64RjsTiV9mavHjQRv
X-Proofpoint-ORIG-GUID: HCSfov8HCzhxCiP64RjsTiV9mavHjQRv



On 7/25/24 7:25 AM, Chen Ridong wrote:
> There are several functions to decrease attach_in_progress, and they
> will wake up cpuset_attach_wq when attach_in_progress is zero. So,
> add a helper to make it concise.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  kernel/cgroup/cpuset.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index d4322619e59a..c241845694ac 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -490,6 +490,17 @@ static inline void check_insane_mems_config(nodemask_t *nodes)
>  	}
>  }
>  
> +/*
> + * decrease cs->attach_in_progress.
> + * wake_up cpuset_attach_wq if cs->attach_in_progress==0.

In the description, adding locking constraint of cpuset_mutex would be helpful.
Something like "cpuset_mutex must be held by the caller."

> + */
> +static inline void dec_attach_in_progress(struct cpuset *cs)
> +{
> +	cs->attach_in_progress--;
> +	if (!cs->attach_in_progress)
> +		wake_up(&cpuset_attach_wq);
> +}
> +
>  /*
>   * Cgroup v2 behavior is used on the "cpus" and "mems" control files when
>   * on default hierarchy or when the cpuset_v2_mode flag is set by mounting
> @@ -3421,9 +3432,7 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>  	cs = css_cs(css);
>  
>  	mutex_lock(&cpuset_mutex);
> -	cs->attach_in_progress--;
> -	if (!cs->attach_in_progress)
> -		wake_up(&cpuset_attach_wq);
> +	dec_attach_in_progress(cs);
>  
>  	if (cs->nr_migrate_dl_tasks) {
>  		int cpu = cpumask_any(cs->effective_cpus);
> @@ -3538,9 +3547,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>  		reset_migrate_dl_data(cs);
>  	}
>  
> -	cs->attach_in_progress--;
> -	if (!cs->attach_in_progress)
> -		wake_up(&cpuset_attach_wq);
> +	dec_attach_in_progress(cs);
>  
>  	mutex_unlock(&cpuset_mutex);
>  }
> @@ -4284,9 +4291,7 @@ static void cpuset_cancel_fork(struct task_struct *task, struct css_set *cset)
>  		return;
>  
>  	mutex_lock(&cpuset_mutex);
> -	cs->attach_in_progress--;
> -	if (!cs->attach_in_progress)
> -		wake_up(&cpuset_attach_wq);
> +	dec_attach_in_progress(cs);
>  	mutex_unlock(&cpuset_mutex);
>  }
>  
> @@ -4319,10 +4324,7 @@ static void cpuset_fork(struct task_struct *task)
>  	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
>  	cpuset_attach_task(cs, task);
>  
> -	cs->attach_in_progress--;
> -	if (!cs->attach_in_progress)
> -		wake_up(&cpuset_attach_wq);
> -
> +	dec_attach_in_progress(cs);
>  	mutex_unlock(&cpuset_mutex);
>  }
>  

-- 
Thanks,
Kamalesh

