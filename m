Return-Path: <cgroups+bounces-3914-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BC493D138
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 12:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03DB282368
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 10:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC65C178372;
	Fri, 26 Jul 2024 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TQaItRAo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U9EzZLPE"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9BC73478;
	Fri, 26 Jul 2024 10:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989969; cv=fail; b=U86/VLlxZb8AYtQb/5iXNF2rlYoP0mm69fb/EsNzOa0H5KfmUdcg5bbua/KWbeTkbSdvVHwuCHNhyP27TPlmMHDVteQVwZi6XkAD87AZAUYI75Fe9I2mBFKS46cH2p/5dwTsIu5YB1tQtJXf5RtSwJGNHqWfaIYsKgJKHbDEx3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989969; c=relaxed/simple;
	bh=helD4CyauXNngNl4kd/YXQarHmuBKgljV045/WBv4tM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o7SI31QItXvodbfQpmNCT4uKel8YZS+vd+kmw5sv00mi+0an/wMaKFlL7NPTr9yjCu9nb3iAyerh7UBN8gEV8zg5q6bNCXl0INeSHVa7MPzsus3OIrE7vUWdOW0micoa29e8JYgoShsyUD4alG9uIkb9lPXdddV0su8cFWo2vB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TQaItRAo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U9EzZLPE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46Q8tb0U019642;
	Fri, 26 Jul 2024 10:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=zNjAfW8sMAIQY/Bft+g97UkwMsIbTbb77y+gP52MMTs=; b=
	TQaItRAoVdvxkeJuzkyEE4xSVd/l63scuWIVoFqvjJi/sYu0aNf0AYFjGcKtKk5A
	9QBW4zSF6jaKbF5HfqIIycICIyGfP0I5soXzaHjMUaV3MIJBd8Mwc57peVu6FYc1
	lDs+kgVPL6P0nGqCgKqIBrf0lj0g55lXaDiYfziHO+AXW1pOvvyJb5XrcVmJqSwx
	1cYhW2qq5tMWDzYmZHHzJzmLQjbqsVpiR2LluZwdkE45yFADFZ+qJjiPpVzbRUFK
	sj+R4hKS1JeSe0aINemlrRTP9IqZTA4gupcDyuQXhG0Iy0H9o30jsOLFTGMpPhd/
	MNHFoG0M4VlG3LRfv70cDA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgktd9bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 10:32:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46Q8is8N038991;
	Fri, 26 Jul 2024 10:32:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29v92u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 10:32:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVYY5CUwkEeHaTCxu37+JSVPZ6c1Ba+4amGYvygCgL1OPeogMu8nXLwUxeHzloUwVgodkzgpDai12T0cURd/0PQ6wBs/Pib3ad7Xcvq6yt/shEbCq1QkNkaSaMspAE6x+Ldp77IvKcNMok8431x+vws6/RxtjwWYAD44EczjRhLZZLKu8fYZMetmRSp51vkwClTXvCWhIilNl3qs54PAbGlY0k3yIsOfD8cCMZ3bULTikXicKSvaW/53CAMPjxpLCoX1zJwyGG5XIVGQY0Iteg+iGSfLmJvDMpYosIf3O0TV64QzgIMSluQv/dkwX5O6Yl8D7/0kqZNi72KXBNL1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNjAfW8sMAIQY/Bft+g97UkwMsIbTbb77y+gP52MMTs=;
 b=ES1Jw7Zs3Ekn7Z4zLYEjCh6KZM+BY+fK4Z5OlzbacZB+7mr5j0H643DPb1/vYS8yiULS/l9SfxZNBeEUNTfTW+Ithq9fynDR3Y1L+7hr5Bq5Wcp2h8k2w7x17kAHC7Ab5s2s+85L4s6Agn1oJ9F2YWdG31m5NC/M9ehAQgPrx0ahUMZ2mk/kBPGwX2XqhHCmg6GYvS9dPbBEORNs6Cr32mIPWOAF81qrP6m4ZPmw+0vka/MLRssc/FGtLYcSyQVr4/RJXawCwne6d+fxIFNtfnXlejv0vKuEspe5vR1yGtTVFxnszvmVQ2vlWYirKvM0qRrA7ZL/2pVbOP63PPSxAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNjAfW8sMAIQY/Bft+g97UkwMsIbTbb77y+gP52MMTs=;
 b=U9EzZLPEve94VlCtXCHpPUMdlPWXYSFtbC+66UNxQ9tjIeN02xUESrJMylFq9myJTcGgDec3ezNwQ0s9aRrcA/+iWzS1I8bNj3j+LCxdYuSaCfO9D+lNLavcZ7cbTn4V6N3L7RoP8oFY6IOmhLb1eCs+xdGVtO1FHVgwqSbldbM=
Received: from SA2PR10MB4777.namprd10.prod.outlook.com (2603:10b6:806:116::5)
 by CO1PR10MB4771.namprd10.prod.outlook.com (2603:10b6:303:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.31; Fri, 26 Jul
 2024 10:32:14 +0000
Received: from SA2PR10MB4777.namprd10.prod.outlook.com
 ([fe80::1574:73dc:3bac:83ce]) by SA2PR10MB4777.namprd10.prod.outlook.com
 ([fe80::1574:73dc:3bac:83ce%6]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 10:32:14 +0000
Message-ID: <f0b665bb-111d-4c25-b539-ba0d11c30025@oracle.com>
Date: Fri, 26 Jul 2024 16:02:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next] cgroup/cpuset: add decrease attach_in_progress
 helpers
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
        adityakali@google.com, sergeh@kernel.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240726010502.2226806-1-chenridong@huawei.com>
Content-Language: en-US
From: Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <20240726010502.2226806-1-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::6) To SA2PR10MB4777.namprd10.prod.outlook.com
 (2603:10b6:806:116::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4777:EE_|CO1PR10MB4771:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e6c319-3310-4028-deb1-08dcad5e36b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFdyRXZkd1VnblRjQnNBZkpySUc0cEZHVjd1K0tqSmpYYTh2eDI1Q0ZyN0hJ?=
 =?utf-8?B?dTBpVUxkR1gzeVBlNUlQRGF1WkxrTEU0NTR6amhRV0NKdlhoeHl4em1UOU1T?=
 =?utf-8?B?S0tFUURmREdraHVsSm93MWVvZ0JDVWdBZFZwTUNZVk9DQXYzSFc0WVVqRXNj?=
 =?utf-8?B?VDE1dTFacWNJZXZZRkRXUGU0WitpY0ZoZldic3ZScTJONHhkbkZHR1R1VmpL?=
 =?utf-8?B?QU1RcUREUFIzWmxpTzVxVnhPbHFuOGlTMmJnWU1BVnBERnJoODJxNnY1UHEr?=
 =?utf-8?B?NVJscDQvQ010Vi9pSmoxMlZ2ZTZsTXhQb3dnYjZVR1RXSXdxN2V1dGFCNVhW?=
 =?utf-8?B?b284M3dvNVlVQjRoa29YelNodUg4TFJVYko1Qjg1bXEyMWxwNHR0Y25mRTZY?=
 =?utf-8?B?V2wyNFpZYTgyTFBOcGNMeEUyV211UmFEMkR2TkFuemdwUDRFekE1WjV4aEVI?=
 =?utf-8?B?ek5vU2wyZ0RxMW5acjd5VjdWR3lOSENpSTEyQWJ2V2V0aEJySmtoQ0FMVVZ6?=
 =?utf-8?B?RDUvSk4xYmxsNmpubmllc3BVWVZKZXlzMDZha2ZwS2dzUGlyYkN0MHZjbVB4?=
 =?utf-8?B?YzhYcmhzcGNnWGk2S3IvYkFmRTZnaVE1S0NOZ1RhZzQ2cm5JTGRKT2lxeGFE?=
 =?utf-8?B?WEx5TnRHL2hQeVZPbjNsbThEYmIvVWphK3ZBaEJabmFTeHB6RVpNM2s3eGxh?=
 =?utf-8?B?VmpEWWlyeUdzRUJUS0ptWitTZmNXVjRTd3Q2VTlvcmdRZWVVNktNT2FjemN0?=
 =?utf-8?B?M0RxQk1ONFRweXJwTk1NOHFXY0xLNktGaVFTeElSSDk2K3JDVlByb3pZancr?=
 =?utf-8?B?dEdKVWZwdjV5MjdzczAvb01mSXhsS1RFc0tJWTFkd3hwNTZDZEJhcVpjOVBn?=
 =?utf-8?B?UC9oSFltcUNBL0p2RmR2dlNmM3FLS1lReFFpRmFXWUlQY05qZm1TM29sZ3lB?=
 =?utf-8?B?dDU3dGFBcWhCQUNwcHRaR0Y0L1pOaHM5NTIrY2J6cVh5RUVwSW5oSWRpdzlY?=
 =?utf-8?B?UmpRMDhoYnlhZ2lIczY3YXFkR2JSZHkxbldTSG84a3VGc3Z5WnFHOVpzbjh1?=
 =?utf-8?B?M2xwa1FkNjhVSG9XNkVORlBURlZLWjhrbVEzYUl5OU5BQWZaQlVUZ3g4WXFk?=
 =?utf-8?B?SlN1V1RsbDZjTDdWOHk4RTY0b1lKbWRSNVpBK0RtMmJoNldOOUc2aFNMcE1U?=
 =?utf-8?B?WFMxTi9jK28rY1ZXdGFXSGx3UEQ5V0Y3NlpVdW9EajZtaFBoSHUrcjVRYTQ5?=
 =?utf-8?B?akp0WGgxS2dpYzI3Vlo3T2p2bm9BR1crWUNjaDlKQ05YdTM5TC94TTltd0JO?=
 =?utf-8?B?Zkh6d3Q1TmFFV29qM3dGVEtLeHNHd2JUNlNKNDhWdFpqNExOQk1VdWhWb2RX?=
 =?utf-8?B?QndlMTMyWXNPM3RIZ2d1STZkZ0lZMkpJc015NlZzODRXckpSN2hzbHhCZFZi?=
 =?utf-8?B?eGFhMU1KQTFQVmRDYzVFbjkzcmhqaVhPOSt4MFhwUUs3bzZtUzh4TWJMUzA2?=
 =?utf-8?B?OXJITjJCM3pyQWQxaUgxdmZQZmpLYVZPRGNEMFAvMDZqQmZBUjB2UEkrMHNs?=
 =?utf-8?B?Y2IwNWpjR3ZjUVN3V2tBMXVsK2l0SDJiaEc5L3NNQzdCS3Y4M1NCMk1rbmJZ?=
 =?utf-8?B?WW9nMUM5eXlKdzR4dWtPSEQxbUdQK21uak4xSVJWeHh5b3JScVFJSlQzSUI3?=
 =?utf-8?B?dDFqZUpPdE9xZEQ3dWxNUVRvVWpMdUNHdTdXekZCcnpnMjhVd0J5aDJ5YXU5?=
 =?utf-8?B?eXFIRGdJMUhTbnRMU1BrTWo4bzdFZmFQK1ZZUzZrMFFiNVVzNWhETkVnTmpG?=
 =?utf-8?B?VjB4cDNvdzNHQS92R2pOZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2tlajJ2bm1JdG1pc3lwcU4wNVJqNldwaFQzblBqd3RId2ZBWnhDVWpvVTVj?=
 =?utf-8?B?VCtEaXo0bmhyZ0dlb3NjZkM1eWE2YkZYV3YyNUZXUFpyeFNZYXV3VzlhV2l4?=
 =?utf-8?B?Z1QvWjhIdktuNitqajQ2eE1nbUNicFZaVTR5Q1ZYK1NJZzhwTDVSMEJFODlJ?=
 =?utf-8?B?ZzhaWWtiTHg2eVFWMmo1Z1N4VFg4eTRIbzFBQzJ4K2QzUFczQkJiRWZ1SmU4?=
 =?utf-8?B?ZjBDSzY0dEFKV2tEYWlzQzEvVW1uV0dzakQzbGpRSWp0cEI5OWZzTUI0NlJx?=
 =?utf-8?B?aVM2WFdUamxzNnRHbUpxWENDOFVMdFkxNWF2WGtqcEYyZjVoL0NacVVGaXFl?=
 =?utf-8?B?aUtRcFpiTmduRTJ0KzlJbHprQWFzakN5VzUydk1KeHN4TGZZL3VPUkRURzJy?=
 =?utf-8?B?bUVadFZWamp6Y3ZmL3VoejFuTWJ6YXhVMDIrbXZoKzd0TGVROUpIeHYwU2Fi?=
 =?utf-8?B?TjY0WmRjdWhtUW9mWGNjZi84bGZ1TFNCcy8vSHZBM2JrQ0grK0ZpQk1vdFJE?=
 =?utf-8?B?M0k4SmMwd2s1WkhsRXRGRnBaSzlFWUVMZWlqbWFmODh2d3hHMXAyMDQ1SG9o?=
 =?utf-8?B?YTZlVWpPUEdHMk5ZekF6bTYwUnB4RnRUVjlKaUdzQTEyc0QxY0pEb3d4QWpH?=
 =?utf-8?B?MTJWcGpzNUdOUzVaSTBaejIwbTJ4eHF5TUs0Y0t2ZHExTCtKRW10dFNZTEMr?=
 =?utf-8?B?MTF6OEFMRlJTSEcwZ0Jwc1VrS3JhTjhnVlIvZ3BsZzZ4TUhnZlpyV2Flbzhy?=
 =?utf-8?B?TThCV2NzcWRhTTJqL1Q0eUhzQlBQc1JhMjNnaWordGZPRXVoN0hwaEFucTNR?=
 =?utf-8?B?cWh6ejlTMzcrakZiaFhsOWMreFRVWlhKNHM5aUMwT1BYd0x3SUtTbEdPOGNh?=
 =?utf-8?B?TzcyMHR1d3MzeVg2KzArWUt3NmlGdXArUU15T3lVVnY1NVYwL1dJaVRsLzBk?=
 =?utf-8?B?SjV3d2FJTHJPc2FKUEtQbXF0T2tjdHlKdXV6TnNPOTRSNU1vcjRzeWlkQ3Nh?=
 =?utf-8?B?dUpBNDNjNVVidVJPUXowUFF3NlNwVzlnSSswU3oyeGpSOVJld3JZY2lmTFg1?=
 =?utf-8?B?bUJOb2oxdU9mOC9oY0Z0U2dzcTI5elFlangyM0NlSEZTRld0UUgrNXdNdTlq?=
 =?utf-8?B?NnFRN2NyUVczc1VyWnpFQXJjRk12dmhJY0JKekMzb2plZlVQZmZ5aHNKdDRu?=
 =?utf-8?B?bDhEeDNoY3BONm1BaGN5cDFrbmdKTjlTdVhHVis0SkRLdURaUVFVLzNVa1Q2?=
 =?utf-8?B?WlVLVWF5R243RzhsT1JZeFRrNDZsQndlWkhhVlJVOTJrZCtmV2Y4VEZSSkJK?=
 =?utf-8?B?YXhWVVQ5Vk56dThqdDdTN1dGMEZqR0xXbFp0REhTcGMySlA2VVVnQVl1dVY2?=
 =?utf-8?B?dkIxbGZKeUE0VzFnS1JRaHBXdi9UUUVaWGd2dXBhSVFlNGhtbEhVWnQ0c2NO?=
 =?utf-8?B?U1RpQ1J2WVFLUW1STVVGQlJPdE1yTHRaMWNvN2NOOFI2am51L3EzMGxneGoz?=
 =?utf-8?B?bXE5cUtFNEpEbis0MzNvVmxVYys4ZExJN2xGVU9RODlsdG9SQ1RqOTRqa0Vn?=
 =?utf-8?B?RDFUeHMvalJLaEMrTkwxVWY1RER4THpZUEtuTG1LVVJJWFpYWDVVeVpicjRl?=
 =?utf-8?B?VHUzQjk3VmZYR2I3NWZqaXEvd1A4MVlRMFRyR0RwUjM5cXFXY1c2N3VUWkFJ?=
 =?utf-8?B?Nk5VUER3cGNXN0NMSUtFSEJFZzdUZTdCbnR3Q1NYVGYrYU92YjA2bG1PRXlG?=
 =?utf-8?B?NkU5a0VjQ3ZBNE9KMmFWMnhMVEhWWnc2cTJuWEQwdlU2OTFidWlPbmZkeXM3?=
 =?utf-8?B?ZjJGUERyMHhRdmhHVjkzZGVvZlFNUzNseUsyaDhLVGljUWFDL0NyRm85ZnZI?=
 =?utf-8?B?akttLzc1UlZpdGFkTTVKazZtbWNxV2hVMU9XS0pqRGtaWE9HQ0hnaDkrd0dC?=
 =?utf-8?B?c00wT21RQ0JwYm5CbEFHQlRoeU4wNHVCNUdkVjArRzB6V2hBaE1RSjlYeUNa?=
 =?utf-8?B?am1NKzFQRi9mOVNPdGZvUmZwODhlVHcwWWU5QU85Znlya2tCMkl6d3BOZVpJ?=
 =?utf-8?B?RFdYN1dXaTVDZjh4UGJncGJ2OGVBcUJtNitYbDN2MzhHaEwrMjJYOWZZN0xQ?=
 =?utf-8?B?VW1KVzFpVktmMnV0eDA1M0MxZmFWQ3gzKzhmMXYrWEVJWE1ndktIcllOYUph?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jLh59frJmjHOEAkQNMjOacGXw8FU+zI+lx0dlW3EzenInz5fcHZ3NuXVkeXcyJpzcLk+VhpLO/Lmn89vs1rBA5l5vKQe2grwmqEzeEGn5XZfT2y5lRxSHbe7oEh4gdPwY8Dm1gen8qw0F9ZhKXt483Bs2RvQFVGWyn6PBLkqb529ZCdssju0lB48jC6qzlj+utRarkkZOSXY8VaGzaM28IXcuOO6t7JO98m45l+QhAfSd08HRNxpl2t85cUwvWWISypoVa+qriCpEO6MqYvGphWGBTG6JObfv5DNa/LK6EAf+Fm51mM81VkV/232dFPWyIlsSMoP6krBEO+SRYazlm7jxUF1SnMYiASiIax7BVRlXZnn29mIebACC/QJN0hRJIGRrMFmRApVVDNwoUGmxTTW6CObId5+ZSv8C/e2VHqqxXGa+7fcIKesZlqivP1qTb0oCPdDMaxD3Hh4Ce9tLkOZQHPGbojJRaloqZs4fmomyvU/Z0c8gFUaIljdb5TcLDTEjGPhfKRAKdbkdZsKn73fXS1RrKXPhBxjAcvZk1kSiIQpZ5vnB3+5kf/j5tXL3kckk3vxjTXmZz1CY14kxjOaozum11HhLHErH7RVjIY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e6c319-3310-4028-deb1-08dcad5e36b4
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 10:32:14.0007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiJkAV0JsNjdYWTEkRh/PWoJSwEX5SO8j1kZvR5xVH3huJnmYOdfsDwKpYRdUrGSJpBJpU1Io3hrRl5E1L4WL82y61nwCBpaYNJx7glAQe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4771
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_09,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=840 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407260069
X-Proofpoint-GUID: -gp-6dVXlUVY6SPHUdFFxNKPwlZXTggd
X-Proofpoint-ORIG-GUID: -gp-6dVXlUVY6SPHUdFFxNKPwlZXTggd



On 7/26/24 6:35 AM, Chen Ridong wrote:
> There are several functions to decrease attach_in_progress, and they
> will wake up cpuset_attach_wq when attach_in_progress is zero. So,
> add a helper to make it concise.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Looks good to me.

Reviewed-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

