Return-Path: <cgroups+bounces-8034-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BB1AABB1F
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 09:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB393A4311
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 07:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D33286D65;
	Tue,  6 May 2025 05:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yk+gI+0M"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3204B1E7A;
	Tue,  6 May 2025 05:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746509862; cv=fail; b=NtCxGn4VcrqSLmXhGacIZ7e4n+Wq2h64Q9oUYD4qCrLHcdEKAFB0x7avGRGpR30zuHYTtKA1rBEC6ecg/RQBpPzFrkBPk3GDgTEQS7MAF+IAboJgTruVlYE8OJjoh7gxarVuhiTHRB1MKE60s7U0lt5aVOP0B+1VuJicvC2m/Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746509862; c=relaxed/simple;
	bh=GPvrie/KCz6ecFliwmmBDGMCVvy8u5nXD908sdGQ5BI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RJD66UcuAj0UJHkJz7OsPErs/+itGWO0SCcK9yjcYvjGMCD9a6f5ia36izN8LFqAY5k0cl5gdCsOOzD+RFgsPu3aoAxNOy+JtIIVnB9ksq0smuBlaNNQJLm/spkYFeUKJdQbaoNou9qh+4NidCus7RpcG2vczcqE+6JHO+rGkSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yk+gI+0M; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746509860; x=1778045860;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GPvrie/KCz6ecFliwmmBDGMCVvy8u5nXD908sdGQ5BI=;
  b=Yk+gI+0MSq/2M9ceDVczvk9GSWrl1nZD1sMcapWo4/L+Cp5vjsnNkas9
   AVPjaYCaDhFekaPy4Ghr9hk8zQOM2xxI5wQa7lvUNwuzYD1foB5bBZO7E
   jkwA63/2NuMAzTzPL4jdm2eLTN/oBftpaNmVdR5rykBLF4a1RwGs62bNK
   EdaOmBx5dLzmawvsZR/83eCnB3nTeE2nfHopW+swlJHDn0t3nQ945pL1h
   2ga2s08Z9aiKS0Sk2iyRWmMp4MhEA0t+5TQcdm4UnHJxD4RkYd74HzENw
   RiFFvsGz0ZdUbq3evT4CD5luQSStidPWrriz2+36zmxnEXE6GUyIiaKod
   Q==;
X-CSE-ConnectionGUID: vlqTeR3KT+GL500n1fMAvA==
X-CSE-MsgGUID: Idk64pexRRyQg3JFCub3HA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="58816873"
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; 
   d="scan'208";a="58816873"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 22:37:39 -0700
X-CSE-ConnectionGUID: +N4vgoQETKSLIQ1Z2UgWGw==
X-CSE-MsgGUID: kdtXTEviQtW3YpoqgUiDfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; 
   d="scan'208";a="135205706"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 22:37:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 5 May 2025 22:37:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 5 May 2025 22:37:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 5 May 2025 22:37:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQCsD8qDjABe5zafMFMw9RmjzIO3eN0KOIvM1Mf8r9tCiTUTKDxUr+P2kLnYX1fuLMtTifQQ/SutSmETSW3SXm/Gtffv/lMx8U/a+KEXr/VVZ/8e0FQ8MeHk4QwrLRLcGqfJAA/GRD2rHq+LED3EZxDAL1KV5Y3JMIJPUu0WsknEkSqlIgt3StX2aJTBqhinoZmtnY4ofiu84ILcjv8fmyaINYI6GeSQYFCRORBsVpQ3UW3LWl3nQmbDzA4u/JYiFpom2YguX1sSHlXY/T9kuUNEGGUr66xIImUg494y9wt3VUj54coPAvWCl+dGEmtndVte7sB0TNjz6rBLfPnsoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZB1MF7vnolTZR6SpxI9fwp3G9XRPmaABpyczBf01EA=;
 b=X5O74YW9ZoM3n4qOtWIlzD+STNu+NmkHpVVSbFg740X5UIjs225m1oEAWeKDB5iuG2A6VwU/MuhHdt702qxJLaFYfo5gzfCeq/WlrSyzUlX9vQPIPH2zvGbRHSxq7KyuE2ufyFB7VsU0LSMUSAl9DxmPcqhYyFprgdFiuLE8yRQbmTwrDvcu7eh7+XtkjhrHZGmoaqEmJCD+9j3v5Rp6bgRJGZb7DEzs3RnmgCREA5A+FDFHHRDsaNrI09GgkpWn0t0fqy6YHoquy7WXRDAnagbgK7UWOR3mYND2QXOb4bwMXCTl68SqA4+zmlwGUF+g9bbkOEMHR8/H8vYvwnbJ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 LV8PR11MB8534.namprd11.prod.outlook.com (2603:10b6:408:1f7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.29; Tue, 6 May 2025 05:37:07 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 05:37:07 +0000
Message-ID: <bc93c650-ba55-4434-98f6-3b7f556ae44b@intel.com>
Date: Tue, 6 May 2025 13:36:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/numa: add statistics of numa balance task
 migration
To: Libo Chen <libo.chen@oracle.com>
CC: "Jain, Ayush" <ayushjai@amd.com>, Andrew Morton
	<akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Tejun Heo
	<tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet
	<corbet@lwn.net>, Mel Gorman <mgormanmgorman@suse.de>, Michal Hocko
	<mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, Roman Gushchin
	<roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, "Chen, Tim
 C" <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>,
	<cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>, <Neeraj.Upadhyay@amd.com>,
	Peter Zijlstra <peterz@infradead.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
	<mkoutny@suse.com>
References: <20250430103623.3349842-1-yu.c.chen@intel.com>
 <8b248ff3-43ae-4e40-9fa4-ba4a04f3c18b@amd.com>
 <bd936eba-e536-4825-ae64-d1bd23c6eb4c@intel.com>
 <tkfh4h5ntl42jc2tnwyj6dhiqouf6mowin7euvrnbs2tyiqlay@bpzdptv3plsf>
 <0bdc72c0-8f4a-4d91-8e67-f8d56dc26788@intel.com>
 <5735cb9d-86ae-4c8d-b0b0-5b0365843707@oracle.com>
 <c7444174-fa5e-44c1-bd16-c8971d118b1b@oracle.com>
 <c20fbc3b-5adf-488c-b6f3-0d4e3c9da5c3@oracle.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <c20fbc3b-5adf-488c-b6f3-0d4e3c9da5c3@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|LV8PR11MB8534:EE_
X-MS-Office365-Filtering-Correlation-Id: b4cc4195-503e-4fea-01c5-08dd8c600a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTdSbnBFRWk5emkwVTRXQkIzRENmNkRWVHlzdjVkZVpUZHRuWDI5a0EzVEI4?=
 =?utf-8?B?Qnc2NU9FV2k4YlhCM214N0hNRWJDdDlXYWVyUWpQVlNMM09nZnhQdVBNNzAw?=
 =?utf-8?B?VW9DWFNNQkl4T1pNZmtYMk1MbUNHMlRZQ0F1WU8yVVd2UGNEd2srN0QzWitl?=
 =?utf-8?B?WVZ0MXZ1Vkp5S1pGWGF1SlUxL1dwS1llMll2b1lrM3J3QlJBcTJmK3kvUUFZ?=
 =?utf-8?B?UFk3U05IcG5EZVhpVngxSkNWaHVucEplRGV3ekNTZzdWeUFnV3N2UVh1Kyth?=
 =?utf-8?B?WmRuVG1aaGMrTG00Vzk0bG1XMmdtdHdYOXdCREZJbU8wVDR4QWFZWnIyd05I?=
 =?utf-8?B?VHVnQThWcWY4eU9tekQ4dEExSUhSQVAwYTR2ZVhsZlVsN08rL2VtSm9OU2t1?=
 =?utf-8?B?dWM2VkU2eUZaM24vMGMvNHpFUms5NkdmekZVekx0SCs3ZUg3c0FnVjU2Z21W?=
 =?utf-8?B?amNaWjZxMlpGcHBUNEFHNDJUL3JKUFFXRmFPSThrSTF6WDR1TkJrTmVyQlRR?=
 =?utf-8?B?RHJKWXNkNG9DRG1UUGtkYlA1OGxzSmFIVVdmY25KdGlqcmUydXFycUVjaEFH?=
 =?utf-8?B?SWtsNzRPZUx4MFg5cnIrQ2M5VENkSnhyUXlDaVpnZzJ5MU5rRG9MN1p3V2FX?=
 =?utf-8?B?RmFzeU1idE5Qbnk4VFdRZmpDb3VTYzlZTTJ0Yld3clZ1TXl0bmpPalJFbjAw?=
 =?utf-8?B?M2dqODBvMUlMck9MYTA2MHRubHhUQVFtR2dybkhKblNqSDhYdE5OZURiSElD?=
 =?utf-8?B?MHVRNlg0NU5mVVhyYnI1aEZ1RFc0ajk1RkY3eGw5L05jUnphaUdha25FY0d1?=
 =?utf-8?B?Q2RUUE9PTmtXMWVVTnJxS09Ubk9WNXBiQXcwcVQxQmF1SzBDSGNwTGJkWkph?=
 =?utf-8?B?Ry9XTDYrazdlWmRZMEg4VXVWWWJVRzFJTDUyWDlpbTRkdmNjeDJhSjR1eUNz?=
 =?utf-8?B?QlJQTU1jZm1ReUZva3lyR1BrMWxFOHJDbWtkdkF4RmhWeXpxYW9DNWNvRUpq?=
 =?utf-8?B?WHVHVU1LVTN0R2pzR2JVWUgvUURBSTM0aEZGdXgwZ3NRN2dHUUpKdklYNTFB?=
 =?utf-8?B?MldQalQ4Yk4rSDRQTzJhb2szWHZhTFVkVDFCWUdtMHZqWEY2TTdaYlJmTStX?=
 =?utf-8?B?VWw4MVdMZVRhTkpGMDNmSkcySWp4ZGtDOTJEQXZEVGtzdm13NG5tUFhBK3Za?=
 =?utf-8?B?YzBsM3FWZnE1SXZjdU5xeWs2M2cwMGhDTTZxMkxFeXl1QUd2K1NhcllMVmxs?=
 =?utf-8?B?NDc1WHhvWm1PK3hFLzJNNlBoMmxzYUI0OVlxRkJncHUyN0Fld1ZSeGczbzJ0?=
 =?utf-8?B?SnJTdlY5WjhZbnh3dEJyTDIvaVlVeHFNZk41QVVjUkhybUtjcW00ejk1Y1FZ?=
 =?utf-8?B?NkVBR0RiSTVPemNoOEFma2FQSzNGU29XVDhWMUQxSlNRampBN2IrL0FBNVpy?=
 =?utf-8?B?clBSekJjNEhqTkFpRFNUZENOTnVobE10ZFpLOXJIWDNMbUFlZGlQbzhrWmxM?=
 =?utf-8?B?VWVBVnhwaTZFZTZCZlplQjlTdUMrOEhpK2NkTTZlQW5nUTVwcUpUSU82b0NG?=
 =?utf-8?B?a0FKMEdibFI0YmxNNHBNcHFDLzhBenQ4R3czUFBDSUJnZVQxazhJYTM0eXhH?=
 =?utf-8?B?VVF0TytGMlQ3SHdRNS9pTkhOUUZPeFkwTmdtOEdIU0kwSkFNTTEvTVlDbnpx?=
 =?utf-8?B?NUVUSFF0YzdFck5rcWhCQmxTbnplQ0k4UXJIcENzaUVvVWp6QXRZcTQzNXNn?=
 =?utf-8?B?aDNLSVdQRHRCQU01MmZQMnQ2eWtpU3Q0RUVoaFBMMkJUNzNjS1puZjBUZXRN?=
 =?utf-8?B?NzFpbXE2TSticWlRT2VTWVNzRUhBcGN0ZmFuZFNXRXZzRld3OVE4NVlBVTJu?=
 =?utf-8?B?TXI4cndwY3czcHlBWVBkQ2FmOXBHbjhpYnZPQkc4ZFg0eFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXhKTlhtbWZ1MHRyY0ttVzlCaVptcTZxRi80clc0ZURvc3pPZU5vUWxVcTN2?=
 =?utf-8?B?cXh1Q1hMeGk4S1NmeklpeGRLM0hUVVo1WUJIbXpCZnRhU0xmZ1pFR3Bad2Za?=
 =?utf-8?B?cTBxWElXd3lSS2lQL1VZa0IwL0Q3MDB4V1RnWEVUZkhHUXdhWFk2YnlReHVM?=
 =?utf-8?B?Nk04UE5hU3dRTE9SOFlxUWxPNTc5d1VtTHlHZlNkem95SWthTDJhQ1lhL1E4?=
 =?utf-8?B?VklzV3Ficm5Ia3cyNzZoOXMwNHNKWGEyTDI2NkNQbzc5cVI3VGV1N29UVHdS?=
 =?utf-8?B?VS9ucmtlNkJEak81SUh3WFBjd2RaVk5XWkM1R3NRbG5UWlhMTlR4YkQxYmpF?=
 =?utf-8?B?MFBqcWNOU2t6OGpzY1M5UWsrYy9FZ3FKNVF3UEdSN3RnV0NhUVBvckZ5eWps?=
 =?utf-8?B?bHREbFVaUnI0ZEpWejh3WWtEdDg2aVZocVBVazJOcU05K3dKK2pOMUpqb1ZL?=
 =?utf-8?B?b2Ezd3RVWHI0M0k2N25MMHFldDFUbkpxa2cvVTFLOXI1VmlEamkvRWdzaXM0?=
 =?utf-8?B?L01PSmhIb1ZVWStsOEFabG9sTzNxaFpTRHV3a3BMWnB4SGE4UlJPU3RLNTFU?=
 =?utf-8?B?OGtzQzhiZ2QzU1VtdnByMnYvb216NUpsR1ZyZXhQZkhzM0RiczJTVjE3NE83?=
 =?utf-8?B?clA2WjUxdmd0QjE5dkhIa2hCVllRUURRUHpkNENjb1V1ZGM5bW5vYzdEa1Nh?=
 =?utf-8?B?WTNGejAxTFhQcmd4YVVWanIvbDJ5d1I0VnQ3Ui9tMWp5WldMU0RmNHVKUS8x?=
 =?utf-8?B?b2NFcXNaVGYrVzgwa2lROWVJZ1NpMTUydVhxbWI2S2g3V1dCZ1RYV1BSZnZr?=
 =?utf-8?B?RjVDQU1ZazVMZC8zQUxZY0xOc2NXT1dhVnMyUXJLdE1ocm9PVjRVQTM0MUFH?=
 =?utf-8?B?Z0M4b202bkJjRk1FZUZiKzZWcTllcUtESENrclU3RkFva0wvTExOWUZ3ajlV?=
 =?utf-8?B?ZmpQTGFnbFZqZEt0NU94MXg2QlplQTJ4NTBIeUJ3SFJrWVZZYVI1NWtUOExV?=
 =?utf-8?B?alR2NWhtUHVuZE9RTDNWNGtQWTZJUllIdEFPUFJiSFVNMVlCSVcyMUxMTVRS?=
 =?utf-8?B?Ti9MSW4xaWhGc09vd0dscmhRT2FXWVBGM0E0T0srby9SR2l4Y2lGK1RkbXdP?=
 =?utf-8?B?R01PZFRzU1pJTjVETnl0RzhMYWtHZTcxNS96VkVXMkd6MmlhQzArSWtobDBL?=
 =?utf-8?B?c0ZFcld3ZkxPMkVDTSsyK0cvemdqS1F1ZWcxZGpYZStBNTdDV0FiTFlZNms1?=
 =?utf-8?B?KzZpOUpCbWtQbjBPanNnVHROQ3RVZ1B5bElPTVVXdXN6TTJVQjhXQnZhNnJU?=
 =?utf-8?B?eGw1NzgyN2MzcHVTV25BVVJ5VUdmc1phS0hVT2ErZFVZRGJrWTdOZHhsQ0xj?=
 =?utf-8?B?TWFGNVZWQjlzZW1URVkwUlVGdHY0QXgvR0VBKzh1VlRIeWMrZ0hwQ1pFVW5F?=
 =?utf-8?B?SUxhdWJLNHJKbkxYVml1cFVrdFFBaVNUL3R2YlBKc1VvODE3cHBUTTlCS1J2?=
 =?utf-8?B?YTdmSXRQbC9BZGNUZndCSHNtSGxVaVVaNXBvTU14YTJRMDY1UXBKRUZYMzhB?=
 =?utf-8?B?Z05xa2dwdUhjbC9CZlFvYVRuc2lFUyt1NitkdFJxWEtvdkF1K1I0cmdYRHRG?=
 =?utf-8?B?dTYvZ2l1cUVkVERhb215L0dBVTc2bC9QR2NSZkJUQlRNcFRJcU5INjVtVkRW?=
 =?utf-8?B?aUE0dXJsZTBFbXhMU2RuYXhjQUVqYUFSdStRODJpWG5jNmRGSG9ZNmtOYW5n?=
 =?utf-8?B?SmNrMTlVN3JHd2pETHZYYTJQdFNiRkQzM1FLcHNGVC9tSFBDckVWaXpXY2ky?=
 =?utf-8?B?aHdBN3dLcGNMT0dIYWhocjdjbW5rdHp2S3pQZWhFNnlpWlFoYWRqNHdaTGNz?=
 =?utf-8?B?OEVTVW9KcElXKzNTaGJkdGhhbGZZelYvZ3FHOFc5cWpIc3RiZytidGd1YzNN?=
 =?utf-8?B?cnFxTXVoRW8wYXZHV2NBdzZqN3BWVnJjZEtnbUcyL0VLSk8xVzVFTTRlQkt2?=
 =?utf-8?B?cjJiUm9YSTZKYXZOWUtZbEpmRzhyWjYvMkY4Z0EwZEkvSUJWSG4zYWhLVTNr?=
 =?utf-8?B?OFZHRGVhM2paNmk3NzRiSndGaTVLeno5VDhTdnlOVUxSTXFGVDhwZzBFWHcv?=
 =?utf-8?Q?llJ/s8p5AxZGByFL1Fr5LCg7u?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4cc4195-503e-4fea-01c5-08dd8c600a38
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 05:37:07.5831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpIzgEtTZmI+XwdyNOBWxoLKQ0ccYzHOSkwYXUYg1kHg6kEm4fI7lhGRhAeT2H1zwBLHTdW83VLtHyFvaghceg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8534
X-OriginatorOrg: intel.com

On 5/6/2025 5:57 AM, Libo Chen wrote:
> 
> 
> On 5/5/25 14:32, Libo Chen wrote:
>>
>>
>> On 5/5/25 11:49, Libo Chen wrote:
>>>
>>>
>>> On 5/5/25 11:27, Chen, Yu C wrote:
>>>> Hi Michal,
>>>>
>>>> On 5/6/2025 1:46 AM, Michal Koutný wrote:
>>>>> On Mon, May 05, 2025 at 11:03:10PM +0800, "Chen, Yu C" <yu.c.chen@intel.com> wrote:
>>>>>> According to this address,
>>>>>>      4c 8b af 50 09 00 00    mov    0x950(%rdi),%r13  <--- r13 = p->mm;
>>>>>>      49 8b bd 98 04 00 00    mov    0x498(%r13),%rdi  <--- p->mm->owner
>>>>>> It seems that this task to be swapped has NULL mm_struct.
>>>>>
>>>>> So it's likely a kernel thread. Does it make sense to NUMA balance
>>>>> those? (I naïvely think it doesn't, please correct me.) ...
>>>>>
>>>>
>>>> I agree kernel threads are not supposed to be covered by
>>>> NUMA balance, because currently NUMA balance only considers
>>>> user pages via VMAs, and one question below:
>>>>
>>>>>>    static void __migrate_swap_task(struct task_struct *p, int cpu)
>>>>>>    {
>>>>>>           __schedstat_inc(p->stats.numa_task_swapped);
>>>>>> -       count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);
>>>>>> +       if (p->mm)
>>>>>> +               count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);
>>>>>
>>>>> ... proper fix should likely guard this earlier, like the guard in
>>>>> task_numa_fault() but for the other swapped task.
>>>> I see. For task swapping in task_numa_compare(),
>>>> it is triggered when there are no idle CPUs in task A's
>>>> preferred node.
>>>> In this case, we choose a task B on A's preferred node,
>>>> and swap B with A. This helps improve A's Numa locality
>>>> without introducing the load imbalance between Nodes.
>>>>
>> Hi Chenyu
>>
>> There are two problems here:
>> 1. Many kthreads are pinned, with all the efforts in task_numa_compare()
>> and task_numa_find_cpu(), the swapping may not end up happening. I only see a
>> check on source task: cpumask_test_cpu(cpu, env->p->cpus_ptr) but not dst task.
> 
> NVM I was blind. There is a check on dst task in task_numa_compare()
> 
>> 2. Assuming B is migratable, that can potentially make B worse, right? I think
>> some kthreads are quite cache-sensitive, and we swap like their locality doesn't
>> matter.

This makes sense. I wonder if it could be extended beyond kthreads.
We don't want to swap task B that has no explicit NUMA preference,
do we?

>>
>> Ideally we probably just want to stay off kthreads, if we cannot find any others
>> p->mm tasks, just don't swap (?). That sounds like a brand new patch though.
>>
> 
> A change as simple as that should work:
> 
> @@ -2492,7 +2492,7 @@ static bool task_numa_compare(struct task_numa_env *env,
> 
>          rcu_read_lock();
>          cur = rcu_dereference(dst_rq->curr);
> -       if (cur && ((cur->flags & PF_EXITING) || is_idle_task(cur)))
> +       if (cur && ((cur->flags & PF_EXITING) || !cur->mm || is_idle_task(cur)))

something like
if (cur && ((cur->flags & PF_EXITING) ||
     cur->numa_preferred_nid == NUMA_NO_NODE ||
    !cur->numa_faults || is_idle_task(cur)))

But overall it looks good to me, would you like to post this as a
formal patch, or do you want me to fold your change into a patch set?

thanks,
Chenyu

>                  cur = NULL;
>


  

>>
>>
>> Libo
>>>> But B's Numa node preference is not mandatory in
>>>> current implementation IIUC, because B's load is mainly
>>>
>>> hmm, that's doesn't seem to be right, can we choose B that
>>> is not a kthread from A's preferred node?
>>>
>>>> considered. That is to say, is it legit to swap a
>>>> Numa sensitive task A with a non-Numa sensitive kernel
>>>> thread B? If not, I think we can add kernel thread
>>>> check in task swap like the guard in
>>>> task_tick_numa()/task_numa_fault().
>>>>
>>>
>>>
>>>> thanks,
>>>> Chenyu
>>>>
>>>>>
>>>>> Michal
>>>>
>>>
>>
> 

