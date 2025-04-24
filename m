Return-Path: <cgroups+bounces-7791-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3529BA9A4DE
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 09:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63BD317E3EF
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 07:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EFF1F3B89;
	Thu, 24 Apr 2025 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L0sphla0"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7378C1F2C3B;
	Thu, 24 Apr 2025 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745481151; cv=fail; b=urtuQ/JFf8cqXuC3FqtyTad/VdYhJwPJ2jMzyD3Y64dXox6tjT7azXpUfWd+YnYz9wSQxznH/B5wLpys65RvUBiT7OG3MIOCa601M3gG/5i7PS9tg9hH0PQIs6+Rwttg2UNEOZ3fu0HfKCYJJUm+BQV/anwUzbrC2uGysvseXUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745481151; c=relaxed/simple;
	bh=dPnrlJDlcj853rLdQ+oUAYFTFq4msU90lD7JoE3yXes=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h93RM8CeEZ4ICNqLYFyx+OTFmhkHT6jygo+cji5XvM6VsH+HY/zBq0uqFue0LXQJW6P3heoAChB0h860Rt/T5XDRv0pRucFvg2LdVnlPcM3dM2uZwRM4m3kBe4rZ6Z8BG3rYCXBk2h/ZFN1EATQaweAaMh0LpxiIthDbYCT06+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L0sphla0; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iy7vYeChJ5evgCsYLNx+ZFnGliRsqnriCABi/0/k7CY/ENtilRHPa6ZvJGGv4f2gkbYcvOAlpbvQcMaQqFjM5M8qrwZCbsd0UKgktBT+sl1qZ87jBH/PqxiCuN8hyFe7N7WtqARYanZ3buIGCNs6OP6QmMv/HmaDI4HRAy8nAtyls/eGnrB1I4F8mbWtJE73ZWNeCWePF/b+WismXW1YEsWKgl0Vb7ejzlpY6NMj+eXEuYg1lluP5skQwa6MCH1+3vaJyYBsh2UESFaDrVCGFBktpqCZKDjCmgoqkF5WylgVcaCyc0y5dnejz7jTYYQVML5CZRjxvgqDvgwfME16Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chScDdYdRtqO2M52xKVL8kmk/7Y2uiiLfbfVwUv8Iyg=;
 b=SUkEOUe62s2hNK0yUb1PBRFanMFbnd019Ao9WUI4yP8agn9N2Mh6+CxXmC3aI0L+oR8C/riMRPsI6nmDl0OruzFBTShV4pqYW4HmBxX9oz9udVdFLZy/sofBqS27ggP3zgUXoDqkCYdA+mKVhRbqEvkHvHZXAtWqfTwk2m4gFgTYef/UdrC0xwf3fBre16vzovTH2vCPft0RiXdFJNdwRt3gjp6z6vdH9mZPoRzpr4F5GKMLpZTGqEhezcW+AkEC420sF+ca8mvHzvjKUVzVSG34i39fI4ORn1TVtQ+ddOhxDvmdUfyjUTliuM2GohVQgQWw8FXyT5/ObeJ3vF4DTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chScDdYdRtqO2M52xKVL8kmk/7Y2uiiLfbfVwUv8Iyg=;
 b=L0sphla0zVazi9p7GLCdJVVZlrXwcvOKKsEbbGShOYZizbx824JVrQwxfjmcyMl0BftXWlkzngBlO9kSZ8EeeIm4Lp6lt0Q2zUgDggpdv1QAe5W9yoL4mb2wIMnVlzX31X6wvFO6AwvLK/5VDI2ceO++xDYawCDaY4cmLrOpxeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 by PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.24; Thu, 24 Apr
 2025 07:52:25 +0000
Received: from IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf]) by IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf%4]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 07:52:24 +0000
Message-ID: <aabedb46-8fce-4f4f-823d-b1ef7b440c8e@amd.com>
Date: Thu, 24 Apr 2025 13:22:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] sched/numa: Skip VMA scanning on memory pinned to
 one NUMA node via cpuset.mems
To: Libo Chen <libo.chen@oracle.com>, akpm@linux-foundation.org,
 rostedt@goodmis.org, peterz@infradead.org, mgorman@suse.de,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 tj@kernel.org, llong@redhat.com
Cc: venkat88@linux.ibm.com, kprateek.nayak@amd.com, raghavendra.kt@amd.com,
 yu.c.chen@intel.com, tim.c.chen@intel.com, vineethr@linux.ibm.com,
 chris.hyser@oracle.com, daniel.m.jordan@oracle.com,
 lorenzo.stoakes@oracle.com, mkoutny@suse.com, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250424024523.2298272-1-libo.chen@oracle.com>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <20250424024523.2298272-1-libo.chen@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::15) To IA1PR12MB6460.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6460:EE_|PH8PR12MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c349ec3-3b58-400a-3236-08dd8304f37f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c056eFdaendlZjlMNDRUSVJjdWliMXpTTHY2S3RNM25WdVdDZTJvV01nYzlT?=
 =?utf-8?B?M3U1SGQwQVVwb21JckkxcTFHMHV5YWErUVRCTTZuL2txRFRhZGd0Tlkyb3NG?=
 =?utf-8?B?K01YU0k2WXdWa3lMUUdSU0JQRmUvNEVxamJuMFcxb0ZUd3kvRUpWY0IycGdp?=
 =?utf-8?B?SE96SUg5S05PRFpla3Z0cno0LzFKem5LOTFFSFhCVVlCWGoyamlpc2JSSmI4?=
 =?utf-8?B?Y1RJdCtidjlmaVFaUjNsbitnbDk0TGl6ay9neVRvLzQydmkrR3VNY3JTNXpX?=
 =?utf-8?B?QlVLc1QzRkt5Z3hYZ05KazA5NHNNWE5GTDg0VXkwTGFiZnkxMEFPOXNnTEtO?=
 =?utf-8?B?Z3VwbERWb3pucHdEazRBZVBGenZ4NzRWZUVkUG5ESmRSbnhNdGtKY000ZVVi?=
 =?utf-8?B?ODY4VkNmUVZDbVhZQWJGZnp2THYwOCtKdHRESnBTM1FReEMwN0x2ZWRXYzU3?=
 =?utf-8?B?Rm5PRjNOVnNDampiRkpRdmhsQXo2UnlxYWVDdFBHUWUyN2YyVXBnSmQrSklz?=
 =?utf-8?B?TUJaTXFaRGN1Um9xVEkwOTlUUkxtaVA5bFBLTU9USkRSUFBTOTdtQW5SNHBs?=
 =?utf-8?B?WDZRVEtoRUFucXpMYTNFaXhUN2hpMlMvdCtYUWlMaDFFbTBYY0hyUWpJSGV4?=
 =?utf-8?B?dFdIZTFVejVwaE9GWG5PbUFIUGVURTUyNHpSVjU5eEI5ZTBwWlVXOHgzWW1N?=
 =?utf-8?B?RTlwd1A2enFaNFZ6aHF6b3RVSUVzZXJ5QUl5SUs1UGNvZjhXMVNlSmtwOE95?=
 =?utf-8?B?eitGQm1TYTMrbEM1djBMVURQSnRXQ2NkZGVTTnE5Y2hES0c2NzdNN2VPb1FQ?=
 =?utf-8?B?ZEExVC9OMGpMbmNRVlBwS3p6YlJFMUx3d1dnUlFqR2ExKy82UnFVOTlxVFFH?=
 =?utf-8?B?TzlJTWxJVURUd0JZNjBrcmFxbXpRVFJLZ2hhSnBMM0V0QUV3a2lKTWtwZEdE?=
 =?utf-8?B?ZFErSEVVYmJudXVlUTBpcC85NldsODg3b3IyUy9SUGE0SEhVZVVtY2ordUZV?=
 =?utf-8?B?cUw3VEdDMHpObFcyWk5OZ1N1UWFpRmlPYm5xRUJCWGl2dEM5eTB2cjVwZ2li?=
 =?utf-8?B?dzVSZUtOYWFHc3ZiMDRqYWZiZ2ZnTW8zOTRxL21CUFBCVVYwVFA3UWhTTUxB?=
 =?utf-8?B?bVplb1dVMnUrYWgvRGJGMlNES0N4UjBjOVovWjNzZ2hzemlBRFdGOE5zQnNn?=
 =?utf-8?B?aGJjeEpkK1FLQ3RIM3RTem9sUzNaWFZOVmtDSE9DZDBrckhmNUw3WUxOenlp?=
 =?utf-8?B?ckRQcEx2Ny8zbXF5NjZMRi9PRWt1aHNOOGNlUlVPTGN3bXU5aU56SUJqTlpJ?=
 =?utf-8?B?L0lvRDRxaDA0VnI3MzFkWWZuOXJuOG93MFRYYXAraTllRndpYW50emVZMEZ5?=
 =?utf-8?B?LzV1bmhhU2NDcVRiWXI5MjVmbThKS2tFQ2c3eVNtWlR1WThWWEJzKytXVGxI?=
 =?utf-8?B?V3VNRFQ1SloxczVOcUZzVGxsNHBpUWdJOEZ6WWNaaytETERTczN5VlRIaE5r?=
 =?utf-8?B?cEU4cWFpbldOZ2VXbk5kWWJsd0krdVh2ajhjR0lWQ255VmZtYVlIWndNcE05?=
 =?utf-8?B?QXdsdUlPUVd2bHg5SnpvdkhoOWFHdlpLelozQWs4N0pCM1AwTjFZN2hpbjhn?=
 =?utf-8?B?RWF2TlUyWEQwTzhOT0drMFYxa3FYUlZxdE9UaFA1ZnZUL1NvTHV1RFBmSlJ2?=
 =?utf-8?B?aFJnbU5SWUZQdFdtY3FNaURLVndCc1ZmdVdBZ3BLN0RYbXVlVW1yZzg4cEh1?=
 =?utf-8?B?QW9RaDFXVTBWZGRIRCtpUy9pUzZUZTlPcjc2VGZqU1l5Z3hVODVFUE9DeDgv?=
 =?utf-8?B?RW1yL1FvZjJ0ejd1TWNvT2tZeUV3VmFmbHN0T1pDVWZkS2ZNNW5NNVJWR0RO?=
 =?utf-8?B?Z3U4QmhHQWpvcWZ5T1RMMi9WKzcralY5SXM2clkwRytXM1JaZHluL0ZLWnMr?=
 =?utf-8?B?em1ZRmFYSUNkcTN0THdWRVVSaElSNmNkUHVrcGV2Mm1veU9KZU82WWg4UU5z?=
 =?utf-8?B?bTJ1WFQxQUNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXBSMXNYUHFaVXIyT0N6R1RDSFJqWHN5eGR5SDVjUzFacnNxZVNaVndVSEY1?=
 =?utf-8?B?YU5ITm4xeHEyRUFqd1Bpb1FjaEtSYmRsYWxLbnlJdmIzTWR4NmhuOGV4M0Ra?=
 =?utf-8?B?YzFSOGtaR2JZVWduUEtVWkFHckpJbHM2a0JqNXkzeDhRcWk2RHVqTjZPWUFx?=
 =?utf-8?B?QzRuYWZFQSs4ejFBOXl0Z2VvUGIzOVd3OGJWYkpnbnlnYVh0SHMxWURJcHYw?=
 =?utf-8?B?dHhkTzU3QjIyTXhCOG5zU01TNmRkb1JteFVVM3pjbzZIZmNGM1Z0WHNDOU43?=
 =?utf-8?B?WU1iNWhrNmZWN201cUZFTitpRkUyUUREMGoreTY1UXB2U29BNndpSmw5NlZa?=
 =?utf-8?B?d3hlMElrcHRZMkQvYXZ0RzJEMnZuUm54VUpXTGdYcnE5clhNcWVpRlNtbnZs?=
 =?utf-8?B?SkNCSUJDQTRFRGx0ZHR6QWg4R1NHYzdCQ0Fla0c2Z1lreDdkMExScDBNR0xP?=
 =?utf-8?B?N2NjVmVIbmNLcWZuZWM0QU0rcEVkbDRORHFNZGFrMHd0MnlZaWJXcnFDSUth?=
 =?utf-8?B?enZ5WFg1cDY1WHZWQkNsa2lxSko0cWQ1MEdnRzQxVkFQQ3pLandReUg1ci90?=
 =?utf-8?B?MUppVUY5emxrcTlVRXE4Q0FIT1dBZ29hNENydkdDZCtHZzBuWGZyWXcrRnZR?=
 =?utf-8?B?bnZpVGQyT0kzUVd1VmpINXZXQmpzM2VHR0VQZWdFbXFXVzArd2h6R21VYTdB?=
 =?utf-8?B?ZWNXNkVzaDFhMG5KR0xPczBWQTEzbUVWd0o2czU3RHczVkF3OWhlcUF6TjZi?=
 =?utf-8?B?alJKTUxkcjljbXdTWW4wNTFSSWJEMGJ3NW5QV0RqMVFpT3VpejZlaEZCWHFq?=
 =?utf-8?B?bGRrQkdJK0VkUGhtNVI2eExnQmYrejhqTmNxdEp6d0gxVjJsSTU5YlQyU3JM?=
 =?utf-8?B?VDg4TVJzcHNsZzEyalkrNTZvbkdjcG9tTGtSc3hLYTdEZHlVdjE4ZzZodUlr?=
 =?utf-8?B?cHNYdUpXSC9SbnBSUVgxNGo4bEV2WTBLM2ZjZG43a3doYThiUnhCZnpDS3pa?=
 =?utf-8?B?NHFqamNheExLWnlUbmRjY05ZWGVLR1pEYmxQMllyVWVpWGYvWVc5ZUNVdmZo?=
 =?utf-8?B?bnU0Z1ZlTEhUTGREamxpN2NLOHcrQ1BtdU5UanJxb2tORHp4YTZybEZzd0cv?=
 =?utf-8?B?Qnhoby9BOFlaY1Z1Um10R0NPdFRDUmxuQkhBNDBXcWtoT0U2VVFqeEorN1d6?=
 =?utf-8?B?NkdPbXVuTCtsak1NN2ZjeHMrZGhITTlOZjFtd1NubDFReFRWSHZuMTI3NU5P?=
 =?utf-8?B?T3pyei9udGdzQUVGS0hqNytIWjdXWnNyWnRUdGp6MkhyL1NOUTA3NXg4Rnkv?=
 =?utf-8?B?ZHVRNSttdnY3eUp5NWI1WlczNWdWcWhDWTVhNlFHS0hpeS9FcmZrenRMU01k?=
 =?utf-8?B?b0hiN3FFVjhYcitEZTFjVDJRVHZKQncxakN2R2tRM0xiTUJSS1gxVUY3Y29M?=
 =?utf-8?B?ejhqNmhVclpUNlJ3Q21QQkpLOE1QV3loVUcrU1pRTE8xMmhHdTEvMHJxUU1i?=
 =?utf-8?B?WVZ2M3F2VmppMjRsai8ySThtZHJLVDIwU0QySzBjRHFmaDNZRUgxSjkxR0tY?=
 =?utf-8?B?a2lkOU85eDNCOHJhaDNPNVdta1IyZXZBY05vSUkwbUQ1bEhVemVZamUzT2Nl?=
 =?utf-8?B?dGZaY1pieTVhWmdyN21JRWpqTkxXT2lseHNqKzFoWlhEdWUzS0lqUGoyYUxm?=
 =?utf-8?B?b2VuMmVWTkQvMlJVNU53YnFMVGo4eU1DM0VqQzhUdmVuVi83MEYrWFduN0lj?=
 =?utf-8?B?TE9Ba1NoUkZLMXUvdVZqRU5ScDFJWUZndy8vajlGQlVncWZNRzBDdGQvTmla?=
 =?utf-8?B?WkVJMUJmVExGSTVVTlNhL3B4Vk9kdVVRaWUveEdHblhtNWJxeGV0UERZNlJy?=
 =?utf-8?B?cUhHTnVWRDV4SFRUWU9pem9OQXJqdUhpYThiSklOL3UzOEtXcE1VTllsMldt?=
 =?utf-8?B?YTNNUG5XeVAwYUZ3N3lvYkxqUnFNMHRTbC9IY3djeWhZejQ4Wk1jb0dPcHF0?=
 =?utf-8?B?bGQ4bzN6eWYyNEd6UU80VldtRjNJNjlOaldWUTliMkRSak1yd1NOa2kydEI4?=
 =?utf-8?B?OFBSeDM5Q0grZURvQ0VZanF1S0xwdVdDemNaamdheGZzK082ajFpbFVkK29w?=
 =?utf-8?Q?96lW5KVlAxjnx6h4nFGaVor/C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c349ec3-3b58-400a-3236-08dd8304f37f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 07:52:24.7909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhZsBIyH7vtAkwxYTXY2RHzgir8zgIrCvr/4QymUn04Dt9P5LVy9Sk5Hm+lZGb7UjXd1pSA5w/rbdJRpd0gbwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841

On 4/24/2025 8:15 AM, Libo Chen wrote:
> v1->v2:
> 1. add perf improvment numbers in commit log. Yet to find perf diff on
> will-it-scale, so not included here. Plan to run more workloads.
> 2. add tracepoint.
> 3. To peterz's comment, this will make it impossible to attract tasks to
> those memory just like other VMA skippings. This is the current
> implementation, I think we can improve that in the future, but at the
> moment it's probabaly better to keep it consistent.
> 
> v2->v3:
> 1. add enable_cpuset() based on Mel's suggestion but again I think it's
> redundant.
> 2. print out nodemask with %*p.. format in the tracepoint.
> 
> v3->v4:
> 1. fix an unsafe dereference of a pointer to content not on ring buffer,
> namely mem_allowed_ptr in the tracepoint.
> 
> v4->v5:
> 1. add BUILD_BUG_ON() in TP_fast_assign() to guard against future
> changes (particularly in size) in nodemask_t.
> 
> Libo Chen (2):
>    sched/numa: Skip VMA scanning on memory pinned to one NUMA node via
>      cpuset.mems
>    sched/numa: Add tracepoint that tracks the skipping of numa balancing
>      due to cpuset memory pinning
> 
>   include/trace/events/sched.h | 33 +++++++++++++++++++++++++++++++++
>   kernel/sched/fair.c          |  9 +++++++++
>   2 files changed, 42 insertions(+)
> 

Tested on top of next-20250424. The boot warning[1] is fixed with this 
version.

Tested-by: Srikanth Aithal <sraithal@amd.com>


[1]: https://lore.kernel.org/all/20250422205740.02c4893a@canb.auug.org.au/

