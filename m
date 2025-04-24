Return-Path: <cgroups+bounces-7778-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB20A99DE1
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 03:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7E23AC792
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 01:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF99148FE6;
	Thu, 24 Apr 2025 01:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GtZBa64A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CTcZfUmi"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C2513AA2A;
	Thu, 24 Apr 2025 01:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745457229; cv=fail; b=fGQvf0/OBbfZ3JT3hW45wcwJyIA7roGD0FEAkvWXimByWsUaK9w32vcTsic1329jsj4S4DCIT5bgIR4cPtHPQuym7LOCWFkI8gvCBACVMfajpcU5ZsvxlYWInM7rk56ognEflydXKFJsTIxEJu0l/HzkXsY+xYKPbRji9r9CPxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745457229; c=relaxed/simple;
	bh=+TrY1+kcvrBwTAvT1Y5PQCKgC9u6vz/AfC+zN8OkZHE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AcQqD9tmr5AokkdtKSVex+79+C2FJSmxMX0tZ6MPKOlKGq+MkeNod9t+N80Tnh6koferUlxhIQmNHOkGO3IoueIV6OnECdrUt3bxpi0QCis2mZNk/b8l4SM2V0uDmG7dY4I8U2O77lR/PWnv22ZcRF3c9gLTf2B/sKiVCDpnwBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GtZBa64A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CTcZfUmi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NLNGMm015057;
	Thu, 24 Apr 2025 01:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Z6UopWeVQvD+D0GIknj1XOyp2EI5bbP5+yTpoAriozw=; b=
	GtZBa64AyR83NU9WO/rm3kluWNjgVPGK6O141QILkP+K1PLzpG0hrhJ8Q31gmLSb
	EvhApT/PIlOcfXoJ0eBE4WM4G25Rd7ftRaMnb02yGSuo06hoqkfNIbaKYukFMnok
	GkCy8rch+c1JQ9cD332TtehjmpWXdrbZHB1jTa9F0LNThnTnk+Ftba7fnt1qkCbQ
	8zCfdYoEMuaczVvUjDggfEl+BYxJSiK2CTPKi+Eo+e4AEBFf/b4Kse7QCDQCeIZa
	8TC8yHOs8C87dmDDgrdAHSpUMDuknNbYkH90HaSTi7HjgFl3U/eSu8vu3cri0JrU
	BmuEiQgELzURnuU9/EPs1g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jhdjsvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 01:13:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53NNk0Jk017325;
	Thu, 24 Apr 2025 01:13:25 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013078.outbound.protection.outlook.com [40.93.1.78])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jvfw2w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 01:13:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGQt1FHtipmSzXfQLmLc5VUwJMhdePM5YtI4JQBBvwDdgvU73SCNQgT7w+eFBlxEas2eO/mORsPVDPSVKfA+B+ZGmqFRSmQ0jbtxVA+z/qngHD2vGnBH/r0rzyBCfbgP6iCn5r1hmN9ZcybAnME/B9HcNVIceNj8freoUnGj5P8Izxa2Z+vTuUeBD0L2SLKsQ+Zw/42x8yKFHZP+TRqWHLLX9eiR4BP+/Zs7u+t3JI+qlWc5FsWYERDWiM3TfNHYcKlfnuGZ+622xIFLoHJcPw0PKxtzelncvEvdsGfPemU6CrxggeP6wgXuR3/8NIt2oGAoLa3x5Vs12Ng/qwcl4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6UopWeVQvD+D0GIknj1XOyp2EI5bbP5+yTpoAriozw=;
 b=reUSWyRLNpLXSyzE+eVF6qsK0Z8riyNpDAyQXpkrlNVEy7z3kVc5pgmb2d/peixSFH1AOyggm0a+LG7FFHhr00bEpzDwkHEFM4kY6Ea70EW05VNIHnWrhbUJ/Yf16zHMdvzkJKxuVewukU4gVMNfp5Cjjjy7/hcEkUr2lTPoS90lxttzB3fzrx/bx/trba3IYuwQ1tML6eyo9FqmpT3n5+itMtqCsuVGUPvWMtUumxZkMAKWk1ks0+MgSTVkEVVaYKB+mPz7I+E3YUioGW4upoWwQHWzgTUlBWSPQrRfboC7MkUMMRFTUsRDgtMSMPx74uzUC6+P1BfcVq/vI9Xa1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6UopWeVQvD+D0GIknj1XOyp2EI5bbP5+yTpoAriozw=;
 b=CTcZfUmiMyAAdoCY6AAgX83HaI0FPxeyfXuUiZc69sZPkvatQ/e5PHuTR2rahRus11biTddx6mYix0DcayiV4dfgJF1kS0oXiYzZjrKsw7eZkwNTZn6/BKZfkdxb375fJR6I1oyI/QL8aN4r8uy7FB6CJE9+lxcFRjdxsIPpxIM=
Received: from MW4PR10MB5749.namprd10.prod.outlook.com (2603:10b6:303:184::12)
 by CO1PR10MB4514.namprd10.prod.outlook.com (2603:10b6:303:9d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Thu, 24 Apr
 2025 01:12:59 +0000
Received: from MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454]) by MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454%3]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 01:12:58 +0000
Message-ID: <752119fe-b5fc-473e-8968-0b4a5ef34d3b@oracle.com>
Date: Wed, 23 Apr 2025 18:12:55 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH v4 2/2] sched/numa: Add tracepoint that tracks the
 skipping of numa balancing due to cpuset memory pinning
To: Steven Rostedt <rostedt@goodmis.org>
Cc: akpm@linux-foundation.org, peterz@infradead.org, mgorman@suse.de,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        tj@kernel.org, llong@redhat.com, sraithal@amd.com,
        venkat88@linux.ibm.com, kprateek.nayak@amd.com, raghavendra.kt@amd.com,
        yu.c.chen@intel.com, tim.c.chen@intel.com, vineethr@linux.ibm.com,
        chris.hyser@oracle.com, daniel.m.jordan@oracle.com,
        lorenzo.stoakes@oracle.com, mkoutny@suse.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250424000146.1197285-1-libo.chen@oracle.com>
 <20250424000146.1197285-3-libo.chen@oracle.com>
 <20250423201829.17d4c382@gandalf.local.home>
 <d3a458d0-5f39-4374-957e-a2a3edf4983a@oracle.com>
 <20250423210108.5b2452ad@gandalf.local.home>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <20250423210108.5b2452ad@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::18) To MW4PR10MB5749.namprd10.prod.outlook.com
 (2603:10b6:303:184::12)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB5749:EE_|CO1PR10MB4514:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd1b7c1-bca6-430d-41ff-08dd82cd26cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHJ5U1lmNmdjSkhpRmkwR2NoNlpXSnBhK24yc3AwMmxyK3BFNGpGWjRLNHVw?=
 =?utf-8?B?bUk4bVpkTjBteWVrUVozWnpiU2tDN0NCMGRNM2w0SnhDa29nem5Cck1lVW9R?=
 =?utf-8?B?Nm14VFhMRFVRMzM5U0RIczg2M1NhN1BJc1FLV21PQ1ZLUWVXN1hFU0FocHVn?=
 =?utf-8?B?NEdSRHNBWkVVa1B5a3B2bXludnhBeXcwNDBENmU2NEVFVnA1ME9PbENlWWJz?=
 =?utf-8?B?V2didlF4bEd3UmplTHpjaHBpVHVhdmphdDBkOEJNODZkS210Qlg2aWtTQm04?=
 =?utf-8?B?NkQ2bys5bVRMNlpWZU5JY29BNlpGdG5EUVlWaFVjK2xpWUtDL2luRzNVeUpR?=
 =?utf-8?B?ODNZK1VnVy9yQ2NMTzN1cVFweUF1Q1RHdFlCdUoweXcwejB1MnRaNmdiSCtZ?=
 =?utf-8?B?WlIxRFFtY2VuNUZreE9EQng4SmJHRU9mQjlFbE90VzZ6MVc2Mnl6MDA5RVov?=
 =?utf-8?B?Wk05dmplMTJyV1d0Z2NpcXR0dGcxMkI0K1N0QnVFOW55WGc2cm1PUUJ0N20r?=
 =?utf-8?B?eHd5VktwWGgzUDUxS1cwMUF4U2RHbkkwb3IwaWFaMWVSOVk4MU1MY2w0Sll6?=
 =?utf-8?B?eEVIT3JldDJkbFpZeTRzYmczUit4OXBDdk00akdjUW5Gc3VhdkxjWjdqZ1hy?=
 =?utf-8?B?UmgrbmpoVkJrRStrZEQ3NDE3eFlJYmF6d3d0TXRhSFd2NHM5N1oxSlNXTWVn?=
 =?utf-8?B?RlVtUlhGRFNZWGxPbU1paVZGWW1yUW50T0JCdHIrSVdqeThnTTR5QW9Cejc4?=
 =?utf-8?B?Zk9MSnpoWkdjT3hEMW93TnM3YUtVNEdqaWxKdG13eTBmV0g5WC9GQzRhUzJL?=
 =?utf-8?B?R1F4c0tnTnlvRkZkeFJhQmdhTEkvajBoRHZEam1lZVJ3R2dSdHEvMVdZd0Zn?=
 =?utf-8?B?WWxzeXJkZ2dXZzkwY3dZaWYyeXQwdmgyT2Y2d2NNeFJjK3p5eUowQk1hUzQ5?=
 =?utf-8?B?T2k0RVRFRTJabGwyaXk2UmtudFNPQ0NMT3JVdTJleDVZTHp0b3RXRnFnVHJp?=
 =?utf-8?B?TE5jWExPSWpTdzBFbEgxVjFvOXUyVkZON1A3QUUwOVRWcldTejQyU05ZYnZC?=
 =?utf-8?B?U3QzRitmb2dicUNjdGRNeFhiYkRPWWFQSkFrV3BFZGRwOVdXQXg1elVSd2FR?=
 =?utf-8?B?Q2Zhb2JXK2dQVnd3eVZaekpDZ0plcktna1pNRXdiUFN5Q2ZOVFljOXBBZGtt?=
 =?utf-8?B?dWpRVHZPMnRWaWZnQ1M5RWFCME9neUlORjAwbnBpcnNURlBzVkFlWGo3WWkv?=
 =?utf-8?B?YjZvNmxqei9zZkluZ2Y1OHY1OXg5WTFxMHRCTWlvTEFBZ1grQ3REdjdUc2Jl?=
 =?utf-8?B?U2U5czRJdkM4ZW5rbkl1bmdEQTQ1U2VjUE5DdWRPdzVzSXBjd1pxT09OcCsy?=
 =?utf-8?B?dE40WEtzK2tTMmJ3WFlMQ2t2cGR2VTU4cDhRU1JLQitXemZpQ3NyUzhLRk85?=
 =?utf-8?B?WVBRQnI5WTJqdDFDY204M3pyVjVpZllMWmo2SjBSU3BxZ25wMXIyTGpUMkpS?=
 =?utf-8?B?cFhxUkFTbC9tblUzUWh2b3hiWVRYRExSaTdaL2VyY1k0WVdYemNaejNBbXhh?=
 =?utf-8?B?WXBLODJNS2xxalFBTmpmWUtzazZCZ3M2REhNMHF5TWZQRFNnWVV2T1RRNUsy?=
 =?utf-8?B?RThrWTZHZGxrck5TTVdMakt4aEw0dWJ5ZVJHdjhrbVNORjdwUGRIYVZJZEE0?=
 =?utf-8?B?c0Q4T21NUzQ0aVpLeUtRNGNzQjVEdjFUMEg1eGU3WlBoTzY5TkdVdUU0VzBp?=
 =?utf-8?B?Y1kraitPWUpnMlJXWEhESTZqdmw3SDdYNUpxSXpEYlB4eVNoVDlsWExtTDhz?=
 =?utf-8?B?LzI1YXlDV1EvbjZEbW5vblpqVys0UmFKNHI2Wi9GNldNVXBPYVV5MmQybm9E?=
 =?utf-8?B?bHBHU25ITVlIdTRzUVN1eTJmWmZMZXoxL05oc1lzSVBNbDUvVHowZzd0SzNT?=
 =?utf-8?Q?foLdxGLXaBo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB5749.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXlsMXdjbW9PYWdFck9ZYk5uRWl0ZUlhcWJsTWZsL1RKcVJKS3k0ZnNxK3lO?=
 =?utf-8?B?TVVWSGxnbit1dGlSOWxTUHcvTWMrcEUvMzdiVEE5Lzhjb3BrNU15Q1RmQ2JH?=
 =?utf-8?B?YXowcDRYUE5ML0FHMVRCejRBM1RjNE9Xc1hFSEZDTURSWWp0c2xoQnhncEk1?=
 =?utf-8?B?RmJDczA3TzJkbEZaalk3YW5BZTdXTTF3enIrVE0vUXZ2OUt1aWFTbzRYci9Q?=
 =?utf-8?B?MXFRYWVTci9EbFgzWWtDbTRGZnh3aEx3bHIwNWZlcW90S2wrTURIdEFUOXFj?=
 =?utf-8?B?cmJyMUp0YjF1N1UwVzRkblJCR1dSckdudWZMM0J2bHVTMTJ4T2FMbkVWS2VK?=
 =?utf-8?B?cTZJS3JGVGhjR1NhN0ttR1ZOS0w4am12L29DRXI1TzJROWZJcWlKb3pNdldx?=
 =?utf-8?B?Q2QzWVhObExaY0hzV3N2NVNINUZKcFdNNVZYc29kZkFsVkRPcENDUnFYWFJa?=
 =?utf-8?B?SWdUVWNqQTBicU11cWMwdGdldWM5d2ZkWFRPUVYrd1RzSnJHU3pWTFFLNXMw?=
 =?utf-8?B?d2pNSWZqVm4veE5NWTl6VE5xNGV2OVhGTFFHQkUrd0ExclVuNmptbXF1MWRJ?=
 =?utf-8?B?Vzhvb3dhb0dySXMyUVZEZlZOUzNkWGlWWnJaMlpmMzBVOVhwbTlhMHJUZGJY?=
 =?utf-8?B?dGFIdldpSWF0aE01UDFLQTd1WUFsMkhTams0cmtQajZKeGxrRzZWTUxhQlpP?=
 =?utf-8?B?eEtRK2tTUVVJdVJOcDd6SzFxb04vVWp4QSt4WmhHODl1QzU0VFUvYlNMOW05?=
 =?utf-8?B?TlkxK2hJeWkvR1lXNERkcjhEcnVZVXBqaXZGeXphZ0dBR2IwYUs5bVZPSTZl?=
 =?utf-8?B?cVVtMHdDUUEvZjVCcGF6NTQzclAraXRjeTkzS3RHT2tCdlpmbE5QUHJpa25Z?=
 =?utf-8?B?d2pjeTkyQUhWU3Zjelp0Z0xWQ0lnZzRmK21Fa1Q4Tzh0eW0rd1hoRVBSTmU5?=
 =?utf-8?B?K1VCUjNycXdVWXF5TVdMSEY0bUxTakJrQjhoaUViL0UvMVBibWlrU0xMRkJY?=
 =?utf-8?B?cDk3OEZTaThBUHBZUWJNYmdRV3hTdy8rQm5DSkhtc3lISGxmUkJybkx0WWFn?=
 =?utf-8?B?c3B5WXJYZjlHMVZuRVM1Z24zb0FxZUZuOW5uUnNDN0Z0Rks1RWpPZWhpeTVW?=
 =?utf-8?B?a1I4NXFyTFJQbXpQM2s4NXphVVAyS1Fwam1NclloQ2hRdnk1MEx0cDYxRS9l?=
 =?utf-8?B?bVI2cC90RC9pYWZ0bDdCVW5WRnNYMlNTQVhFRzEwT1hPN3NpMDVXM0tCZWgx?=
 =?utf-8?B?SWRtQ0pNeENIbjloQTUwdkFuWWhMNGx4WER6aC8rcnNPZlhId0NmOUIxa2h4?=
 =?utf-8?B?U014czZXUGg2RjRmMmw0WHV0QkpGNnpyU1dFVjlDTlMwUWl5ZFFpYTI0OC9X?=
 =?utf-8?B?RWNzcDRrTlNDbzF3RkM5Uytpd29EbkhWMHB4ejFUaS8veEF1eSt5dU5ObHV3?=
 =?utf-8?B?SW5VdzdkMHN2amxZOHpXRWhzZXhuOHR3MnRrK0Vkdk1ROG03VGQ2QTNpM0hY?=
 =?utf-8?B?UGt4QVpaQThlaUFYQ1I1dW9KQ0g2bzVUL2FhZW9oVU9HekFkOUFGZmo1MTRz?=
 =?utf-8?B?ajl1YTF0Z2E2cHZ1bGlMUjJGaUhMRGU0aHR2RUszSnVjZnZvVDNMSU1SRFhB?=
 =?utf-8?B?UWlFd2xVV043OUpHaVhLU3FjbE5CM2FDUGZFL21jaE5zbDhhS3lWUGpJb3I4?=
 =?utf-8?B?MEVWRGdoQnQ1V1ZSekhubXlRTmRCR05TSjdDZHlibHMzQ3cwSEoyL0lSZCs4?=
 =?utf-8?B?Ukwrd3FpYTVqVmhRMVhYQmYxaEtpQUZGMkJIa3V2dkpXT1I5UldMdEZTQlFy?=
 =?utf-8?B?R05rME5qVHlLcUFNNzA4RENsczN1ZnZ1MHhlR3hVSXJSMStMbytoWENXMjkx?=
 =?utf-8?B?OXlMV1pyNSs1ZjVMYTQ3MlkxV0xrZVB1UlRoNkswczdPZU1wTjFJd0EwZjNs?=
 =?utf-8?B?SzZYUFowZXgwaUNYRWZCdktSbm1hTlpSMTlub1lOV0laRnhDYjZ1cnpuU2s0?=
 =?utf-8?B?TXpNWnFyMVVoRElEd0hsUXJhb0h0clduTkVkN3BLcUc1KzQrUzFSS1lPdFBl?=
 =?utf-8?B?Q081WktHWjRlWDZaQjBEOFg1YVFHOTI1SW9ZYzlPRXZKQUk0bElCRHZDa3oy?=
 =?utf-8?Q?7VgYtgFZzVluUnQbGbb3LZAE+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ptZCliwxubxoydSSpLGM34mdbas5GQAFzGbvxaeOfaut1DOXMVB7ByQIFtAV8FWjVmHyQkT4hN2fgZGY9s75nbaXpzT9XUipfKZin5VxGT+Fl0seKK3sxfRtvjnh2gckEjfVD9tOUgt3AQeXYFfODsj4H4gj66yPnD9wZ93xfLkLh+8I07KYgXhGVMNiglyaLPkMvu41HBjjs87QCLWbZFTKk+1pyzBfXtrVJx7lHaDK30M55EJxtqpxyj7HPWOGeUjsbuNhT9MPAf5WA2M3tx2rpQpr1nki5JHHpxxo2M0dYpFCwbUiL6vgLbYv7ndmaORoVmQPG0PEMYIcheUlcAhCxzbVNWNkzyM/3VLrtxaLq8qx5MShGOqi5fr1e30YnsPlCuZ6anAiXDzjHiM+gnSu+Lsel2bqMzVtvYJ+35Ybq8KFK1g0c8tCZQ5OqeOVBezoyGiE4ZBRsVuHGmz45ayuhiX7Tdd/IMHvchJ4ji8CmNdQisaw7/f8hFOruo8BPpAKAfdbyVev7o8304xNx0rmWwC8JZvg4f1M9bPwbPOJ9PWF9WI4JlPPdyrhN4k2yeYCHeGPT774jyeYl1+2K4SeESK0UZ5SkOvhojS7iOw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd1b7c1-bca6-430d-41ff-08dd82cd26cf
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB5749.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 01:12:58.8958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxiRnW9Fmvnx/wGvBlLDlRujnoJSbyJ31dnimo5es18NuTmeFee0oSUwpvloI276itRsv0qasx+UjkVuDp86Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4514
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_01,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504240005
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDAwNCBTYWx0ZWRfX1cOA3tfrLXhu I/eMj1z4hZ7W1Hg5pIeYXkef2I7WLEUk/INjP+wV/X/CMnZboWUCyZEIIArvaloWP/Sa6SG+q2X nE9uCXjF7Bb5a+dHbyBhAC/zlo95pbr0Rpm1hmeaogxs4JzwXg+RvIH0HoIYfIbhseSX+d4CJMv
 7I2Qntuyq+tz+cFUIDM6rrO8E23dRxDFFB8uU6OO0tTbv1sND8o/nJRnL+GOLZWgne8hjw+fjRM s28ZaYai5lhNIXjMrjKtDEGwjq5LJ4xVqQr8ckk5yFrtLX/Emies9xukSjRi97OYpLkib+lXNof UihOZT1wTMyl3eBuNkeQn24Ry/djFcOp3wJVpV4GgrFdkcq/3FLaTy+nFzISiKT+fhf3QxYXlRf tXNNF1pI
X-Proofpoint-ORIG-GUID: XzqPWItUBKBqC4bJfz3PPKlZzRAU9CsR
X-Proofpoint-GUID: XzqPWItUBKBqC4bJfz3PPKlZzRAU9CsR



On 4/23/25 18:01, Steven Rostedt wrote:
> On Wed, 23 Apr 2025 17:36:30 -0700
> Libo Chen <libo.chen@oracle.com> wrote:
> 
>>>> +	TP_fast_assign(
>>>> +		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
>>>> +		__entry->pid		 = task_pid_nr(tsk);
>>>> +		__entry->tgid		 = task_tgid_nr(tsk);
>>>> +		__entry->ngid		 = task_numa_group_id(tsk);
>>>> +		memcpy(__entry->mem_allowed, mem_allowed_ptr->bits,
>>>> +		       sizeof(__entry->mem_allowed));  
>>>
>>> Is mem_allowed->bits guaranteed to be the size of BITS_TO_LONGS(MAX_NUM_NODES)
>>> in size? If not, then memcpy will read beyond that size.
>>>   
>>
>> Yes, evidence can be found in the definitions of nodemask_t and DECLARE_BITMAP:
>>
>> // include/linux/nodemask_types.h 
>> typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
>>
>> // include/linux/types.h
>> #define DECLARE_BITMAP(name,bits) \
>> 	unsigned long name[BITS_TO_LONGS(bits)]
>>
> 
> Hmm, I wonder then if we should add in TP_fast_assign():
> 
> 	BUILD_BUG_ON(sizeof(nodemask_t) != BITS_TO_LONGS(MAX_NUM_NODES) * sizeof(long));
> 

to guard against potential changes in nodemask_t definition? 


 
> -- Steve


