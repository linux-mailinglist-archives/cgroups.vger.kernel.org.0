Return-Path: <cgroups+bounces-8003-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D88EBAA8C63
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 08:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9031892DD9
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 06:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254341C861B;
	Mon,  5 May 2025 06:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2REZ6BYm"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9EF1B3F3D;
	Mon,  5 May 2025 06:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746427439; cv=fail; b=qwpjnYBRl5JvFoAV0aBZdSjaXz0cqh4Yq3oy2mM5pyYDFnRHmxRIT0VpNa0UiP5vtpLpNQMbh7a/s8JdVT4xRVWkok+7X6HnjLjZfGxDdZwz62B1vh+fE7vIr7at/AS+SYtPU+NViemkvCIRK6vSmns4hz8ey9FPddtq+eIZdPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746427439; c=relaxed/simple;
	bh=q/e9bBVCUrDrJYi7E+P+meQCwqG6Gk+apWs/WlSAWfY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I6iF1cXeen5seMwG0xSKR3/zSwxdxfQrviCUb6LBxF9/Si9VHqDLHtKY+qdxuhxB3+swfzh6vcYtwebxArsuQNeXXclL/pPJ83YYwL1QHHaGbnS/cFQLk7hUx6uZ9VIYf9QENvWW+MMgcHKpTUo6as8MvDtyVCt5nV1RaaHnASw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2REZ6BYm; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s68S/gImVDR2lmXqMaQ6txt3V9ztdU1Y6mQ2yxpz/nTujH+Td9dW8Ol30aeVo+D4j6pIjrugMlp4h/4RSmSYQeJOWtcNaNV6o176CU3wDmYIPrxJ/Rq29MVRrbp0RbuZkiOV8yhfUZ7J5Ktkz4PjkGfJT1aMtxqMPiuP0Xso4bnqM3HwEB1sXHZ2ZmruCFce8pzQEfYA2zbBONWr3T685iItmnYAKCvA0Y2Ud2l0uiSk6njDLaUxDhcS71+eSK201ByKHiHAPwCNC4ZXED9wcUFQGaRbxw71KRZ1FJF86b+y9/WjVFeADE/mrnzbC2cXAI1Xiq3weeSHOdNqMXLoSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDVfnRlTHd7N+4nHMNwMfXQZ145Fv2x1A4ULT7ZprP0=;
 b=ZRjs6mGRgWGOxwBjHOexgAobQpSwzsMCrRPoinbkMskb31Hgdwu3/K4CAbUxVPiTvZ8b+MsLc4K524HVBxxTOwSBhRi3mN5B7aC8FAay7f2OwAbFmaBV+IMrc8t4ubeAB663WujH6+f3WBoKssixu/lamCp4hMjeaLP80/Cd7cUj06lDJcN7QAcywrJ+ajZEzhjX6scAsT24AbqDy3OIvgTMhrRMoePQE68K5aZl+42kBsayDRKuNV0GnvCF4Efq3JYsvuKBY3TFA6I/CIv5ll2e0ru/nmnsLLrpkieX8MpfiehT2zcfbtco9UoQ1ki2AS6iAJcgIAGafGdP5d194g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDVfnRlTHd7N+4nHMNwMfXQZ145Fv2x1A4ULT7ZprP0=;
 b=2REZ6BYmVyo5McBsv8D0B0wplkhoDm+L35DY7ayX2R9uFs8WeF5Lx54MiuT58u+xiIIsqzCa6zRhSZp+puWdFMWlkqFMLizXx1VODtT0PUwfEDN+iHPQv6MhizxFajqyb7tgBT23Jri8ng4cJCBDB8MY46/lbHlWM5L4tqEgo10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Mon, 5 May
 2025 06:43:54 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::1fc8:2c4c:ea30:a42f]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::1fc8:2c4c:ea30:a42f%7]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 06:43:54 +0000
Message-ID: <8b248ff3-43ae-4e40-9fa4-ba4a04f3c18b@amd.com>
Date: Mon, 5 May 2025 12:13:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/numa: add statistics of numa balance task
 migration
To: Chen Yu <yu.c.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Mel Gorman <mgormanmgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
 Michal Koutny <mkoutny@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, "Chen, Tim C" <tim.c.chen@intel.com>,
 Aubrey Li <aubrey.li@intel.com>, Libo Chen <libo.chen@oracle.com>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Neeraj.Upadhyay@amd.com
References: <20250430103623.3349842-1-yu.c.chen@intel.com>
Content-Language: en-US
From: "Jain, Ayush" <ayushjai@amd.com>
In-Reply-To: <20250430103623.3349842-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0213.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::7) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4401:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: 310ddfcb-b52f-4160-4d78-08dd8ba033b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmNpN3hBSmx2ZTI3UFFLaVpocm1hSkJiaElJNUN6MjFDM05DZitONDJNNlBK?=
 =?utf-8?B?azFObXNHc25pMTN5bmw5aThEakFHSGZUUVdRY2YwVUdoL0JzZU9Bb1NwOXlJ?=
 =?utf-8?B?NmtuMjlLNGNXMWlHS2s5NWdLeGY4Ly9rWXF4UjFDMWV4Z1liMkJ3ajhPazlW?=
 =?utf-8?B?dlRtVW5kNFY2eXFVNmt4R3lUQ3Z5K3UyOU9OdnlXWDFkMWhIMWF1ZVJhRUVw?=
 =?utf-8?B?MkYyWStURnJRMzBxUlVUcUtnWm0zSGJXejdFTDJFeC9WR3FWYlJnZEdpcDA4?=
 =?utf-8?B?T0hXb3FLMmllamVmclU4Wk5PNXZmWENsaHdGbE9yNy8rN0xaNTF6MkdhUlA2?=
 =?utf-8?B?aytqekJkRGR4bklGNkwzU2tEbVJiU3F5T0ZTYmQxRSt6THAzMlhDS0ZYcFBi?=
 =?utf-8?B?UFU0bXBBVnhMNmlBbjNiS0F5eUYyZFZUTVhZZERRWi9EaG1ZNGp0a0pwRzBU?=
 =?utf-8?B?WURTOHNQclBxQnUxcEVqOGRDb2hlYS84anpqYjhQdTdqMDJpbmdxWk1ibUJB?=
 =?utf-8?B?a3BFdDhqQ0Y5VmVRYlZBVTc5TG82TWVPUWRaeENnaDFUcUZ3M09nSzFPc3Y2?=
 =?utf-8?B?UVhPOGwzRVd3YmY2WHRHY0RleHlXTFFUS2NaUWFhRjB3ejV6MHpITzJTbENl?=
 =?utf-8?B?bXVnN0tOZUlwR1o5Q3IrbmZSTS9PR293bHc3VE9kNWlsUEZ2RThOYkhNR3BZ?=
 =?utf-8?B?QStrc1o5eTEwU2czTVpNaDNOL29acmhjOTlPNGhtbWhaQlJ1eXVvb3NsSHE3?=
 =?utf-8?B?cVFiK1lub1JKc1B1R2lhWG9mUml3S3QwVWZjbTQwREQyeGRocllId09OcmZi?=
 =?utf-8?B?T29OTS8yMFV2a3g3N21sMG94ZC9WRmtjMldSMlM3bnBuWlZFeW9XS2pDN3pB?=
 =?utf-8?B?KzlZZ0M0a0d4RTdwWGdWVDNmMlRzUmNWMlMySEhSQXA2aXl5OGpSbDl6Vy9n?=
 =?utf-8?B?VUJSSGVMK0d1b1JSWE8xTlR4U0IyTVkwQUp5L001aFlCOUFwelh1aHNyNUhL?=
 =?utf-8?B?Z2NHaVNQZUJYekIzcUxZNUxBeWNGdDVZenF0RENiajUybmxNR1YvTUl5VXZD?=
 =?utf-8?B?dGNUbVM1WFJtamZyV0hJZnNvV1ZUTVNFV3RPaGdFVnFsZVN6MXNybmI4MlVG?=
 =?utf-8?B?UFVPTG4wY2xramFoL2x6b0Y1bXl5YUJ1QXJnWUFWd1NBWlZ6SzAzTXMvVmxW?=
 =?utf-8?B?TjVtcFVhYzVnVmozY0V2M1U1UXJwTE9VNnl6Vi9CMjhxMEd5ZURaQ2REbmo1?=
 =?utf-8?B?M0l2Sy82ZkZrcVVRdkhPZlE2Tk5aenZiZGoybDdudCt3alBYdDVwTVhheHh0?=
 =?utf-8?B?Qk9JL2dvUFd6NWdGYjc4U0JENXFtbEFtSXY4bDhvSnFZQlhEbGF4QjFuYjlv?=
 =?utf-8?B?MVB3UUZDOHhZNVVIT3EvMWtZSnhUVnZPTTlnVFJsRmRPaXpqMDhHQWw0NUZC?=
 =?utf-8?B?eEEyM0dwY3ZaTWJ4aTlJelBoR1ZKaHo0b1hoeHJ1alYzTm1JTXR2cGZXUXFT?=
 =?utf-8?B?Z0ZFdWo0T3d5RjFyZW00NnRpczlWVnBSemVLZTdyc3ZkSjJGRW9ZbVRlYjZI?=
 =?utf-8?B?ZU0xQjRQSVppTXZQN1l1R0xoRDdtZk5FSUptamc0WGE1cEIzMDdENy9BUGdz?=
 =?utf-8?B?QWpKcXAyQVIxR2I2ZC9KY3ZTM3lSN1A4QjZxaWs4cFUwUDhNOEFkVkora0FJ?=
 =?utf-8?B?REhiaFU4Rk8ydlF0TFJUZll3cTNsODliWHBIS0E4b1BDdWtMMDN3SWFheVpN?=
 =?utf-8?B?bHozNzdOV0dSTG10SFB4M2NsS3ZjbHJqb01aWUNEaWRRQTFkSWtVYzZaZktP?=
 =?utf-8?B?S2JYelZSYlZIQ1VJbXhzV1Q1aEZTYWZyUEJJWFRMdTgzWlFsWU44d3QrN3VJ?=
 =?utf-8?Q?eOCsn38kkxgsH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWhxNE8xWUpIWTJnUG1HcWxHN3E5ZkErcnhPanp2cEZUR1YxUGpCSm15dUZB?=
 =?utf-8?B?K1VuTkxpL0lTTmEvVk9OcGxsMTBvbGJsTm1DOStUK3cyeS9ZYkY3QzY0dm5j?=
 =?utf-8?B?b0czeEluQjEySVlIS3Y4UExROHhoeTlOL3o5bHVZWnZ2dHh1SVp4QmIxWC9q?=
 =?utf-8?B?UXZmTmpIbnR0VGQwUVVibkg1WUdsVVN5K0hGbUlGTFF0czhFczVCSCtJamQw?=
 =?utf-8?B?eWYrVmZiMnRoeU8vUE1Gb29yNnF6MSsvL25JZjVtclo1ZnptaW5qaEZ5bkhB?=
 =?utf-8?B?L3plYmtkcmFzYUdhcHIxNnBxTS9UanpKRXlNSERZeXVTdmNDL04vRnNqNnM1?=
 =?utf-8?B?ajRCRWNnTFdTWUZscEY4MCtNRU5vd3hYY3daWlVVZ1JPRUJZQjRJL3VNM0VO?=
 =?utf-8?B?NENHMzFwNld0Z0RodHJMS0w2ckxEMlZNalAyZXZadlFaN3dwalp0cXA4MXhD?=
 =?utf-8?B?ZWJ1MkRBUDRXSjdVUzQva0paMnUyY2kzQ0xMMUZ5WmttaFovQ09JVndDRmZs?=
 =?utf-8?B?Y0hRR0owUVBEMjk3ZjIyOXNNZm5reFEzZHJrdnJoUE9XZUZWZVQ3ZjNOTjhH?=
 =?utf-8?B?Zlh3czRoT1JsYVI1TlpWRGJDMGtvZEkrWTZDZ1BNVU5sem05a1dWLzZnNFp6?=
 =?utf-8?B?TzNTTjhVMG00NCszS042Zll2Q2VCRkNURzNjTERuT2xOS05EYkd3ZXR6Q3px?=
 =?utf-8?B?ZDZ1OGpOQ05BN3JYMmNqMjN4a0Q0NDQ3N0ZFK2tzSXptV0JlTERHc0ltK3l2?=
 =?utf-8?B?dXBZYVI4TGhtejRhVEVXRzlpSkxhNGF3VXM5R3A2a1FDM1lGclNwTjZZZndR?=
 =?utf-8?B?c2ttZFdZczhyeEp5YUVKZll1MlJVY0ZxalBpdUlQSXN4TkZVVjdBRGlHMjNV?=
 =?utf-8?B?Tmt5OVJNOE9GRVZtN2Q2VTYvZDFmQ2wveHVBWVZBbHhneFV5b3QzOHlYUk9i?=
 =?utf-8?B?LzYxWXJiUHd3Wmo0M2VRU1R6K2JPZzhxVXc3SkQ4WGJVSExyZGNTYXV2TDBL?=
 =?utf-8?B?WEsxZ2JlVllNcTdYc0g4VDNSc0RYYlp1QU9NRHJad0lvV253NzNxcTBaSkxv?=
 =?utf-8?B?NDJZT0xYMkdFTXdZQjdvZ09JM1JpOExMZy8vWTkzeXhtbWxGcUVLL0hzV2pt?=
 =?utf-8?B?Z1F2Ylc3MzdISzlRcERnWTY0V3JQVTU4dGxYWDdBdGsrLzZrOTFMTFJHTXNR?=
 =?utf-8?B?MGtTRmc2YWk3RndSajJ5L0RTV0F4UkxFOFhrcFBla3VJV09vd3o3YTNZcitE?=
 =?utf-8?B?OWxUWnlzV2M1ejVrdjgrMXk1NGRGeUcrOFFRMDFuc1dvcmY5dE1YMUxzTTVB?=
 =?utf-8?B?aEZQRk14WllxeHZxU3RLM1pucWRLbTZpUTRqemJobFNJU014amdoNktjWGVB?=
 =?utf-8?B?QXd1T2toRWZjNytOZFdabWR0OFpIcFN1MDJ2Zk43MVI0dWRkNXQyN2RoQjZU?=
 =?utf-8?B?Y3cyMUVTdFZDblNwSlRwSUU4TktLVkJaQ0RRUERHNFVKcUFCem9HS3hLMGJj?=
 =?utf-8?B?QWZaUUpWTmlUZHFSY2VUbkRwTVBDcjVkVkYxYm4wV2ZvUy9uUmtPRnF1TmZJ?=
 =?utf-8?B?VXBKQzc2VDNrREF5NWRiSERaOEY1UTE4UHhhMXhha2wyNnh5L0JpTVMvbTdr?=
 =?utf-8?B?Ym9HM2VJWHpCZkJzRHpzRzdFN3U5TU1FL3VuZXB5YnZrdVZtZEs2RnBma29Z?=
 =?utf-8?B?QlJlRGtWY2Z0L1pNNitRc2ZhQzEyQnZWMGZsd1IwcVV4OWtlZHc0aFhEMGxE?=
 =?utf-8?B?OWxBUE5yYS9oSHFlN1ZqMmgyR0FOdlkrTzhreUU1bUFLYUM2WGNCOFFXL1RV?=
 =?utf-8?B?QjMxck9ncmpBbi9LM3hxTUpXZlhzRGU3b0JteXFQYllINjU3MHM4UHFZZUh4?=
 =?utf-8?B?SzI1azlFdTNCYThTTmpTbXIzVFlzK3RZejFiVmNOMy8xdGV5T2pua1lyb1ZI?=
 =?utf-8?B?VjFxQ2VWcEI1L3FaSDVMdVlrakJhSUVaUzJSK29GMXBRbktrcVJhRkFydCsw?=
 =?utf-8?B?M0ZlSTRqMHBGWEduVUxTSXU0VVZvK1FsRTYyUkx0bUR6aGJ6VTAvM3hUU2Q1?=
 =?utf-8?B?bHJyK1l5Rkl3bWlQcjlUL243WTlJTUQ0Q2srQk9jcU9tNVF0UUhUbmJydnli?=
 =?utf-8?Q?/BqRxyK+wulJhl95SHDrTk3sA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310ddfcb-b52f-4160-4d78-08dd8ba033b0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 06:43:53.8338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQHQn3rh/JNBfOvek1kqmxaK4azzIAlMWhq7eNkpI/N1b8ZCSlNXMsGKaU4ZkPc2alZ4bMWPhSrpVuf0qtJ9qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372


Hello,

Hitting Kernel Panic on latest-next while running rcutorture tests

37ff6e9a2ce3 ("Add linux-next specific files for 20250502")

reverting this patch fixes it
3b2339eeb032 ("sched-numa-add-statistics-of-numa-balance-task-migration-v3")
https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/kernel/sched/core.c?id=3b2339eeb032627e9329daf70a4ba8cd62c9cc8d

by looking at RIP pointer

$ ./scripts/faddr2line vmlinux __migrate_swap_task+0x2e/0x180
__migrate_swap_task+0x2e/0x180:
count_memcg_events_mm at include/linux/memcontrol.h:987
(inlined by) count_memcg_events_mm at include/linux/memcontrol.h:978
(inlined by) __migrate_swap_task at kernel/sched/core.c:3356

memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
mm->owner -> NULL

Attaching kernel logs below:

[ 1070.635450] rcu-torture: rcu_torture_read_exit: End of episode
[ 1074.047617] BUG: kernel NULL pointer dereference, address:
0000000000000498
[ 1074.054577] #PF: supervisor read access in kernel mode
[ 1074.059718] #PF: error_code(0x0000) - not-present page
[ 1074.064856] PGD 0 P4D 0
[ 1074.067395] Oops: Oops: 0000 [#1] SMP NOPTI
[ 1074.071583] CPU: 48 UID: 0 PID: 307 Comm: migration/48 Not tainted
6.15.0-rc4-next-20250502-37ff6e9a2ce3-1746413815614 #1 PREEMPT(voluntary)
[ 1074.084258] Hardware name: Dell Inc. PowerEdge R6515/0R4CNN, BIOS
2.16.0 07/09/2024
[ 1074.091913] Stopper: multi_cpu_stop+0x0/0x130 <- migrate_swap+0xad/0x120
[ 1074.098619] RIP: 0010:__migrate_swap_task+0x2e/0x180
[ 1074.103585] Code: 00 55 48 89 e5 41 57 41 56 41 55 41 54 49 89 fc 53
48 63 de 48 83 87 a0 03 00 00 01 66 90 4c 8b af 50 09 00 00 e8 c2 47 07
00 <49> 8b bd 98 04 00 00 e8 26 11 36 00 48 89 c7 48 85 c0 74 0a be 3b
[ 1074.122332] RSP: 0018:ffffa4bc4d54bdb0 EFLAGS: 00010002
[ 1074.127557] RAX: 0000000000000001 RBX: 0000000000000007 RCX:
0000000000000000
[ 1074.134688] RDX: ffff8d80c01fcec0 RSI: 0000000000000007 RDI:
ffff8d2153c93480
[ 1074.141822] RBP: ffffa4bc4d54bdd8 R08: 000000fa1239fb41 R09:
ffff8d9f3e832380
[ 1074.148955] R10: 0000000000000004 R11: 0000000000000001 R12:
ffff8d2153c93480
[ 1074.156088] R13: 0000000000000000 R14: ffff8d60dc9ac14c R15:
ffff8d2153c9414c
[ 1074.163218] FS:  0000000000000000(0000) GS:ffff8d9f8a626000(0000)
knlGS:0000000000000000
[ 1074.171306] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1074.177051] CR2: 000000000000049op+0x10/0x10
[ 1074.203665]  cpu_stopper_thread+0xa6/0x160
[ 1074.207767]  smpboot_thread_fn+0x122/0x280
[ 1074.211866]  kthread+0x11a/0x230
[ 1074.215098]  ? __pfx_smpboot_thread_fn+0x10/0x10
[ 1074.219717]  ? _raw_spin_unlock_irq+0x28/0x50
[ 1074.224076]  ? __pfx_kthread+0x10/0x10
[ 1074.227829]  ret_from_fork+0x40/0x60
[ 1074.231407]  ? __pfx_kthread+0x10/0x10
[ 1074.235161]  ret_from_fork_asm+0x1a/0x30
[ 1074.239089]  </TASK>
[ 1074.241279] Modules linked in: rcutorture torture xt_tcpudp
nft_compat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 nf_tables nfnetlink binfmt_misc ipmi_ssif nls_iso8859_1
intel_rapl_msr intel_rapl_common amd64_edac edac_mce_amd kvm_amd
dell_smbios wmi_bmof kvm dell_wmi_descriptor dcdbas rapl ccp k10temp
acpi_power_meter ptdma wmi ipmi_si acpi_ipmi ipmi_devintf
ipmi_msghandler mac_hid sch_fq_codel dm_multipath scsi_dh_rdac
scsi_dh_emc scsi_dh_alua msr fuse efi_pstore ip_tables x_tables autofs4
btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq raid1 raid0 mgag200
drm_client_lib i2c_algo_bit drm_shmem_helper drm_kms_helper nvme
ghash_clmulni_intel drm tg3 mpt3sas nvme_core ahci bnxt_en i2c_piix4
raid_class libahci i2c_smbus scsi_transport_sas aesni_intel [last
unloaded: torture]
[ 1074.316817] CR2: 0000000000000498
[ 1074.320135] ---[ end trace 0000000000000000 ]---
[ 1074.418846] pstore: backend (erst) writing error (-28)
[ 1074.423983] RIP: 0010:__migrate_swap_task+0x2e/0x180
[ 1074.428949] Code: 00 55 48 89 e5 41 57 41 56 41 55 41 54 49 89 fc 53
48 63 de 48 83 87 a0 03 00 00 01 66 90 4c 8b af 50 09 00 00 e8 c2 47 07
00 <49> 8b bd 98 04 00 00 e8 26 11 36 00 48 89 c7 48 85 c0 74 0a be 3b
[ 1074.447694] RSP: 0018:ffffa4bc4d54bdb0 EFLAGS: 00010002
[ 1074.452919] RAX: 0000000000000001 RBX: 0000000000000007 RCX:
0000000000000000
[ 1074.460051] RDX: ffff8d80c01fcec0 RSI: 0000000000000007 RDI:
ffff8d2153c93480
[ 1074.467184] RBP: ffffa4bc4d54bdd8 R08: 000000fa1239fb41 R09:
ffff8d9f3e832380
[ 1074.474317] R10: 0000000000000004 R11: 0000000000000001 R12:
ffff8d2153c93480
[ 1074.481450] R13: 0000000000000000 R14: ffff8d60dc9ac14c R15:
ffff8d2153c9414c
[ 1074.488581] FS:  0000000000000000(0000) GS:ffff8d9f8a626000(0000)
knlGS:0000000000000000
[ 1074.496666] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1074.502414] CR2: 0000000000000498 CR3: 000000409341a002 CR4:
0000000000770ef0
[ 1074.509547] PKRU: 55555554
[ 1074.512258] note: migration/48[307] exited with irqs disabled
[ 1084.683268] watchdog: CPU6: Watchdog detected hard LOCKUP on cpu 6
[ 1084.683274] Modules linked in: rcutorture torture xt_tcpudp
nft_compat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 nf_tables nfnetlink binfmt_misc ipmi_ssif nls_iso8859_1
intel_rapl_msr intel_rapl_common amd64_edac edac_mce_amd kvm_amd
dell_smbios wmi_bmof kvm dell_wmi_descriptor dcdbas rapl ccp k10temp
acpi_power_meter ptdma wmi ipmi_si acpi_ipmi ipmi_devintf
ipmi_msghandler mac_hid sch_fq_codel dm_multipath scsi_dh_rdac
scsi_dh_emc scsi_dh_alua msr fuse efi_pstore ip_tables x_tables autofs4
btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq raid1 raid0 mgag200
drm_client_lib i2c_algo_bit drm_shmem_helper drm_kms_helper nvme
ghash_clmulni_intel drm tg3 mpt3sas nvme_core ahci bnxt_en i2c_piix4
raid_class libahci i2c_smbus scsi_transport_sas aesni_intel [last
unloaded: torture]
[ 1084.683352] CPU: 6 UID: 0 PID: 83659 Comm: rcu_torture_rea Tainted: G
     D             6.15.0-rc4-next-20250502-37ff6e9a2ce3-1746413815614
#1 PREEMPT(voluntary)
[ 1084.683357] Tainted: [D]=DIE
[ 1084.683358] Hardware name: Dell Inc. PowerEdge R6515/0R4CNN, BIOS
2.16.0 07/09/2024
[ 1084.683360] RIP: 0010:native_queued_spin_lock_slowpath+0x2b4/0x300
[ 1084.683368] Code: 63 ff 4c 8d a8 c0 d1 20 b4 49 81 ff ff 1f 00 00 77
46 4e 03 2c fd e0 5e f7 b2 49 89 5d 00 8b 43 08 85 c0 75 09 f3 90 8b 43
08 <85> c0 74 f7 48 8b 13 48 85 d2 0f 84 5e ff ff ff 0f 0d 0a e9 56 ff
[ 1084.683370] RSP: 0018:ffffa4bc6b503a28 EFLAGS: 00000046
[ 1084.683373] RAX: 0000000000000000 RBX: ffff8d403f9b31c0 RCX:
0000000000000008
[ 1084.683375] RDX: 0000000000000047 RSI: 00000000011c0100 RDI:
ffff8d403f9f2280
[ 1084.683376] RBP: ffffa4bc6b503a50 R08: 0000000000000080 R09:
ffffffffffffff00
[ 1084.683377] R10: 0000000000000000 R11: 0000000000000080 R12:
ffff8d403f9f2280
[ 1084.683379] R13: ffff8d403fdb31c0 R14: 00000000001c0000 R15:
0000000000000046
[ 1084.683380] FS:  0000000000000000(0000) GS:ffff8d408b7a6000(0000)
knlGS:0000000000000000
[ 1084.683382] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1084.683384] CR2: 00007f54f32a3010 CR3: 000000209f547008 CR4:
0000000000770ef0
[ 1084.683385] PKRU: 55555554
[ 1084.683387] Call Trace:
[ 1084.683388]  <TASK>
[ 1084.683395]  _raw_spin_lock+0x3c/0x50
[ 1084.683399]  raw_spin_rq_lock_nested+0x28/0xa0
[ 1084.683404]  _raw_spin_rq_lock_irqsave+0x29/0x60
[ 1084.683408]  sched_balance_rq+0x6c8/0x1430
[ 1084.683412]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1084.683422]  sched_balance_newidle+0x1ba/0x450
[ 1084.683426]  pick_next_task_fair+0x39/0x500
[ 1084.683429]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1084.683431]  ? dequeue_task_fair+0xb1/0x1b0
[ 1084.683433]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1084.683436]  __pick_next_task+0x43/0x1b0
[ 1084.683440]  __schedule+0x20c/0x15b0
[ 1084.683443]  ? trace_preempt_on+0x1f/0x70
[ 1084.683447]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1084.683450]  ? preempt_count_sub+0x50/0x80
[ 1084.683452]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1084.683455]  ? hrtimer_start_range_ns+0x137/0x4b0
[ 1084.683459]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1084.683463]  schedule+0x_us+0x23/0x30 [torture]
[ 1084.683489]  rcu_torture_reader+0x138/0x200 [rcutorture]
[ 1084.683496]  ? __pfx_rcu_torture_timer+0x10/0x10 [rcutorture]
[ 1084.683503]  kthread+0x11a/0x230
[ 1084.683507]  ? __pfx_rcu_torture_reader+0x10/0x10 [rcutorture]
[ 1084.683512]  ? _raw_spin_unlock_irq+0x28/0x50
[ 1084.683516]  ? __pfx_kthread+0x10/0x10
[ 1084.683519]  ret_from_fork+0x40/0x60
[ 1084.683524]  ? __pfx_kthread+0x10/0x10
[ 1084.683527]  ret_from_fork_asm+0x1a/0x30
[ 1084.683535]  </TASK>
[ 1084.683537] Kernel panic - not syncing: Hard LOCKUP
[ 1086.154471] Shutting down cpus with NMI
[ 1086.169269] Kernel Offset: 0x30200000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 1086.583614] ---[ end Kernel panic - not syncing: Hard LOCKUP ]---


Test recreate steps:
1. Load rcutorture module to machine
2. Toggle cpu status (Online/offline)

https://github.com/avocado-framework-tests/avocado-misc-tests/blob/master/generic/rcutorture.py


Reported same at:
https://lore.kernel.org/linux-next/8f746aa3-9ee6-45a8-84b1-da335be17c2e@amd.com/T/#mc98b701dcd3667ff8a18de8581936ee257238884

Reported-by: Ayush Jain <Ayush.jain3@amd.com>
Let me know, if more details are needed from my end

Thanks and Regards,
Ayush Jain

On 4/30/2025 4:06 PM, Chen Yu wrote:
> On systems with NUMA balancing enabled, it is found that tracking
> the task activities due to NUMA balancing is helpful. NUMA balancing
> has two mechanisms for task migration: one is to migrate the task to
> an idle CPU in its preferred node, the other is to swap tasks on
> different nodes if they are on each other's preferred node.
> 
> The kernel already has NUMA page migration statistics in
> /sys/fs/cgroup/mytest/memory.stat and /proc/{PID}/sched,
> but does not have statistics for task migration/swap.
> Add the task migration and swap count accordingly.
> 
> The following two new fields:
> 
> numa_task_migrated
> numa_task_swapped
> 
> will be displayed in both
> /sys/fs/cgroup/{GROUP}/memory.stat and /proc/{PID}/sched
> 
> Introducing both pertask and permemcg NUMA balancing statistics helps
> to quickly evaluate the performance and resource usage of the target
> workload. For example, the user can first identify the container which
> has high NUMA balance activity and then narrow down to a specific task
> within that group, and tune the memory policy of that task.
> In summary, it is plausible to iterate the /proc/$pid/sched to find the
> offending task, but the introduction of per memcg tasks' Numa balancing
> aggregated  activity can further help users identify the task in a
> divide-and-conquer way.
> 
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v2->v3:
> Remove unnecessary p->mm check because kernel threads are
> not supported by Numa Balancing. (Libo Chen)
> v1->v2:
> Update the Documentation/admin-guide/cgroup-v2.rst. (Michal)
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 6 ++++++
>  include/linux/sched.h                   | 4 ++++
>  include/linux/vm_event_item.h           | 2 ++
>  kernel/sched/core.c                     | 7 +++++--
>  kernel/sched/debug.c                    | 4 ++++
>  mm/memcontrol.c                         | 2 ++
>  mm/vmstat.c                             | 2 ++
>  7 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 1a16ce68a4d7..d346f3235945 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1670,6 +1670,12 @@ The following nested keys are defined.
>  	  numa_hint_faults (npn)
>  		Number of NUMA hinting faults.
>  
> +	  numa_task_migrated (npn)
> +		Number of task migration by NUMA balancing.
> +
> +	  numa_task_swapped (npn)
> +		Number of task swap by NUMA balancing.
> +
>  	  pgdemote_kswapd
>  		Number of pages demoted by kswapd.
>  
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index f96ac1982893..1c50e30b5c01 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -549,6 +549,10 @@ struct sched_statistics {
>  	u64				nr_failed_migrations_running;
>  	u64				nr_failed_migrations_hot;
>  	u64				nr_forced_migrations;
> +#ifdef CONFIG_NUMA_BALANCING
> +	u64				numa_task_migrated;
> +	u64				numa_task_swapped;
> +#endif
>  
>  	u64				nr_wakeups;
>  	u64				nr_wakeups_sync;
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index 9e15a088ba38..91a3ce9a2687 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -66,6 +66,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  		NUMA_HINT_FAULTS,
>  		NUMA_HINT_FAULTS_LOCAL,
>  		NUMA_PAGE_MIGRATE,
> +		NUMA_TASK_MIGRATE,
> +		NUMA_TASK_SWAP,
>  #endif
>  #ifdef CONFIG_MIGRATION
>  		PGMIGRATE_SUCCESS, PGMIGRATE_FAIL,
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c81cf642dba0..25a92f2abda4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3352,6 +3352,9 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
>  #ifdef CONFIG_NUMA_BALANCING
>  static void __migrate_swap_task(struct task_struct *p, int cpu)
>  {
> +	__schedstat_inc(p->stats.numa_task_swapped);
> +	count_memcg_events_mm(p->mm, NUMA_TASK_SWAP, 1);
> +
>  	if (task_on_rq_queued(p)) {
>  		struct rq *src_rq, *dst_rq;
>  		struct rq_flags srf, drf;
> @@ -7953,8 +7956,8 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
>  	if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
>  		return -EINVAL;
>  
> -	/* TODO: This is not properly updating schedstats */
> -
> +	__schedstat_inc(p->stats.numa_task_migrated);
> +	count_memcg_events_mm(p->mm, NUMA_TASK_MIGRATE, 1);
>  	trace_sched_move_numa(p, curr_cpu, target_cpu);
>  	return stop_one_cpu(curr_cpu, migration_cpu_stop, &arg);
>  }
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 56ae54e0ce6a..f971c2af7912 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -1206,6 +1206,10 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>  		P_SCHEDSTAT(nr_failed_migrations_running);
>  		P_SCHEDSTAT(nr_failed_migrations_hot);
>  		P_SCHEDSTAT(nr_forced_migrations);
> +#ifdef CONFIG_NUMA_BALANCING
> +		P_SCHEDSTAT(numa_task_migrated);
> +		P_SCHEDSTAT(numa_task_swapped);
> +#endif
>  		P_SCHEDSTAT(nr_wakeups);
>  		P_SCHEDSTAT(nr_wakeups_sync);
>  		P_SCHEDSTAT(nr_wakeups_migrate);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c96c1f2b9cf5..cdaab8a957f3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -463,6 +463,8 @@ static const unsigned int memcg_vm_event_stat[] = {
>  	NUMA_PAGE_MIGRATE,
>  	NUMA_PTE_UPDATES,
>  	NUMA_HINT_FAULTS,
> +	NUMA_TASK_MIGRATE,
> +	NUMA_TASK_SWAP,
>  #endif
>  };
>  
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 4c268ce39ff2..ed08bb384ae4 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1347,6 +1347,8 @@ const char * const vmstat_text[] = {
>  	"numa_hint_faults",
>  	"numa_hint_faults_local",
>  	"numa_pages_migrated",
> +	"numa_task_migrated",
> +	"numa_task_swapped",
>  #endif
>  #ifdef CONFIG_MIGRATION
>  	"pgmigrate_success",


