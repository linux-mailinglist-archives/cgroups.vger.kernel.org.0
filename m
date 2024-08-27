Return-Path: <cgroups+bounces-4526-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E841B961A8F
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 01:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFA1284D67
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 23:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001D21D45EB;
	Tue, 27 Aug 2024 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQxE+uaD"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC751D4165;
	Tue, 27 Aug 2024 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724801187; cv=fail; b=OzFBjir7N/tjxDXK9s0UvqHJHKxon+IYzL1Rq70rHisz+rCe6QKjqSeknmDkiPIGNgzFf+QE9hT8gpfXVbxwb+d0H6ktsHrpFfMDfWnFV6JohOyHc/zbC0Ok38K+Xs6YqWjJ0ChhdlHO0cZu2VvMqDzosU+PWJjsumg/sMB9/Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724801187; c=relaxed/simple;
	bh=P86CuDTvfOBG6qj0fSIsyYm4FVNrVd1AHOo89jPIw+g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n0e2xndPVVgMXjvrD8cXlbub3TC84XaUYI8Jx284NuiX1vEBzYcluFySEjIcPgijxGPSCupDSI20ss9hIFMbVRvUMcU0f/0iEMyuzO+xjB8YPoUxrNxHezfovI3KROhxjSoWUcQfUy5/UqtX+feEfaew8ic/rCmuOL1tAr4Odlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQxE+uaD; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724801186; x=1756337186;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P86CuDTvfOBG6qj0fSIsyYm4FVNrVd1AHOo89jPIw+g=;
  b=FQxE+uaDc5CcAoot43+MCaflltDWqa6MzStB0decyXI2x7p92nkBJmfa
   ub9hl8zehB0pZiyUukJauBpWVzesdRr9qJ1AsjDzGlqqzWuk2VeDaWE+Z
   eDKGzZvMNXsEQn5fqap4R96BItvk28xL44XrVIImxyjk+SgeY34fgJXFg
   sQJGsQmmhg7mFsOARa0T0PvYOGaailwo5YDt3vilOHloVVsPaUWCxFOfh
   3ypYDEGZImVSjykAFJW/PEhCZS8hYi7DvQuKyl1TIohXAxB2axNL49eU8
   iV6rfdhaYv5zrOgZ2aQmwhpZU8nzqef9XnGMTXAelqf66qOIPl+J1N3vI
   w==;
X-CSE-ConnectionGUID: UMA1RQ/rSpmTrDiVo/MLEA==
X-CSE-MsgGUID: 98a0cBZoTfa4aaoEJdXWwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23468528"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="23468528"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 16:26:25 -0700
X-CSE-ConnectionGUID: UH6IwkQ5Qp+6K/EIfmdelQ==
X-CSE-MsgGUID: bvYQ2f6cRMu7p3ykqYfjTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="62989856"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 16:26:26 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 16:26:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 16:26:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 16:26:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+6TCaFP0JcJq1G8CpsOJc6Ew6tV85WYQLe5W63R3kx14hhTh9qtCZgoTl/L/R7mDgkvKffiBLg4Uadw6RjawHHHHzZq5CK5JU2bswUh8pEKu+nWvp3Sb20OCmVIdMMY1wGr2PG+D77eDTMYveddoNKhPRPXsrUv1iDRm42+cBm4VgMKdJFppf9IHt2H5k52zJxmUBK4emtKlY1J8wQvHdoyn216iDbnpu08NaehTVqQ6fqdn3eaP9uMle2sghlXiYicBZOVsV/GPAdqgm2kN4lbuPPQsaWRQw5R3gE2Y44eR0cp7xvkM/H+B2FbDv+IRhvUTin15f8RV/gesPY4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dtxs8Bz1ENnLKp3jvGCupbIXp/cIGBa/1GtXemtLEJI=;
 b=kghWAkKM1LTt/+IHgd47Thz+MbjAaPeOO47WolPBibu5kfCr644u2tWoxDSDW0OvZRT9q8UXAeV3h0KpyLqTzLW12IvGx3/t9jxqMYJ1t2W1djRn0XeuQBiyp5YSXjhR6363NkTW+uXmh4bb8VmVfJ6A2ViV4oipahxrD6lhq3oqQgge4Ba+TY2HqRxuxpn5KKoE6s5VNkaL4K5Acg/WbEtNAfvrxURa0qrvHFlkfBdIZH7jSlpBMx82UhRoRDWt0q56Ofvdz/UjVQ/yFU4iazfK4iC1yNQj7EvRcVirkHe0P0NsOdXRcDDcOfptRd3DxDA5Ml9FOIW7L53K4Qgo0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH8PR11MB6754.namprd11.prod.outlook.com (2603:10b6:510:1c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 23:26:21 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 23:26:21 +0000
Message-ID: <46651daf-9e4f-4df6-8188-afaeeed2b2ad@intel.com>
Date: Wed, 28 Aug 2024 11:26:12 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 16/16] selftests/sgx: Add scripts for EPC cgroup
 testing
To: Haitao Huang <haitao.huang@linux.intel.com>, <jarkko@kernel.org>,
	<dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
	<chenridong@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-sgx@vger.kernel.org>, <x86@kernel.org>, <cgroups@vger.kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
	<sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
CC: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
	<zhanb@microsoft.com>, <anakrish@microsoft.com>,
	<mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
	<chrisyan@microsoft.com>
References: <20240821015404.6038-1-haitao.huang@linux.intel.com>
 <20240821015404.6038-17-haitao.huang@linux.intel.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <20240821015404.6038-17-haitao.huang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0037.namprd08.prod.outlook.com
 (2603:10b6:a03:117::14) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|PH8PR11MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c31082-825d-4015-e795-08dcc6efa91e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3lLWDRLLy91SzFlQ01Rb3ExSUVqYzNjb1o5dDY4NTFnQ2ZBb0VFMkJnY2tB?=
 =?utf-8?B?OUZIek9mNGZwWElGbTZPdjVSZk9SS2hpdm5yMTR1eVhvZ21xY3hxMXcrMitM?=
 =?utf-8?B?TGJRMFlwSy9ZVFFLbWNmd2p3MUM3L3QxbEM5U1l5L1diZUZ1VmZQOE4weTVR?=
 =?utf-8?B?aTlRdEozT1Z4RDgxc1JaUCt2WTNQQ2FMcDRZUXN0TDJubmhlT01oUkxBMlFn?=
 =?utf-8?B?NkcxQW9iMWdrMFl2eVY1UXZGRnQ2SnRJajVNekUydWtpWWNCUW1MT3hNclZx?=
 =?utf-8?B?TDNLc1Y0bFQxQ0pNRzlSQ2tmNHAyNWJVZEdRZ2pIMkVEcVQ5dWJlSDBwSk0x?=
 =?utf-8?B?dzg1WFpWN25vc2IxQkt2MWFkT3NBd0lGY0NVMStrMXk1cHVmSlpjZXdpYitr?=
 =?utf-8?B?cU9IdEF6ZEREUzRUbGtkeEZYalIwWFQxTG9JVVhIQ0duR1VXTmJPRXdUVE9M?=
 =?utf-8?B?UExGOHVSeHUvOWhtUmc2bVlhWmdkWHdYbm5waTEyRDdFb3RVbm0wREZCd2Yr?=
 =?utf-8?B?aU1MQU8zajNnNFliVVZOWnpnWWMzRkhZYUJzQUxJUGhiN1g1ZVp5bzBzN3dn?=
 =?utf-8?B?UzN6ZWducWtpWTduZHoxRzZBOXEzRlpHNE4xRW05Ny9ZL0pVZXVPclAxUUJv?=
 =?utf-8?B?TFMzTUlJQzdndU9DdUxnRzlGZXZLVDBKTnp2N0c5MjNsbFZtSUV5ZjhvS0RJ?=
 =?utf-8?B?cmJML1R5Tlo5NXlGSU1sS0ZtTnZSYklpV2kwc0xHQWEyR3puclcvckE0UzUy?=
 =?utf-8?B?c1lFUUxEMmhoRVVORFQvVnQ1Z3dkQUMycW9FQlhqaE9qVDYxcUdUNSt6ZUxu?=
 =?utf-8?B?NEJDMzBncHgwek1HNU9xbExaNlFyVjVzVHJFQ2d5cWRQdjNCeHJWc0tpVmJ0?=
 =?utf-8?B?ZWo5WklEWVNXOWZwaUhTeWxXTjVORXBYcFJUSGxEM2djL2tiUFY1M3FDdVNk?=
 =?utf-8?B?NGFsYmM3ZU03ZCttNERqTHU2V0JVTTFvRDBrWm1BWWExWmovWUEyRzRYN1p2?=
 =?utf-8?B?WmdYNnFPVHpmcHhIbmFiZXhwcnNtUGdkK29UaGNtQUU1SzVXTHNqd2hHSk15?=
 =?utf-8?B?aTNMYXlZUmtBOVlHdWhONFY1d0pXaXJFR3JvM3VLTjdWdlVMRklQK1RWbk9Y?=
 =?utf-8?B?RjM0dXd3R0VFb0ZyZmNtc2VCajAxOU42amVSbnp6bWVVeXpTRjZKaEUzd0NZ?=
 =?utf-8?B?VmNDUXd4dVBwMmdWS0ZnMXNaakc4OGE1SGJwUEhDMm95WlJqSCsvMHFmeElJ?=
 =?utf-8?B?Q1RBVmJvT1Q0bGRFTmE5Vk41UnhjQzNsbE9SaExPRTRUblVFZHQwaytHYWti?=
 =?utf-8?B?M1Y3bkZYK2FNTXNWTmlyS2RpKytNcHk3aCs1Y0VCclZjaEtiS3EzYnVlU2l6?=
 =?utf-8?B?RS9Nb21SdFZRQjJ6YzJLRjJ1TWZ2RUJ1TXZ2dlIvSDFuck12MVluTWZKLzl3?=
 =?utf-8?B?TXlXYzBZYUI4c2U5NUh6bEpOWHpIS2tiOEk3QUlzMXl2OG9GcDdxZXhzVm5s?=
 =?utf-8?B?bExRNVVPVkIvNmE2WEhZK2lPMmk4aENhYUF3N3BmbHArZlJSNG1pVU9VaTZu?=
 =?utf-8?B?ajZVdTZyejhxREdkTkxla0RPbGhnTytjYUNLWEFPZXExcGdhT25tYzFVVmtu?=
 =?utf-8?B?WEdqMDVnWjEvSVBlYU1iUjRWUlFGR0VSS0pZdGU5K2VpNmFWcTJySlBMZURn?=
 =?utf-8?B?US9oOUpMSmdEMUxYbjNRWmpPS0hiakJUVkZZdjZNcjJqK3dIMkQwWXcvVm5I?=
 =?utf-8?B?WlhXZTh2cU5nSVQ5MmVkNXhEb0xZUm1ha3E1N0ZnTjZKeWl6bXovVlJSWlZk?=
 =?utf-8?B?SEZEb1JrUFlIRWh6bFhmS0dtS20wZnk0cXN5dVYvRzFCeUZTUWNmOHVPTDg3?=
 =?utf-8?Q?j4L4K1vrHqjzh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akpIOVVDOXJ0MmVsak95K3FZTEVzWFJEdnFXdUJRNmdxVXpkcGdKNGprVHh4?=
 =?utf-8?B?dFJjTU9BRDFqZm9QWmxBMk16WmxOaWVpMGdJRURNWDJMemxsMlA1OWVQRHZj?=
 =?utf-8?B?ZHFsZUFBMCsyMkgvMGR3V1pNbEkzeWlNNlQ5cEFjL3NnM2tqM2hZWUVqb2l2?=
 =?utf-8?B?a3Vad3N4RXNvaExSUUZvdUpsUTh4Y3ROSHplcmVIcDdaTHh2THpUSW5LNWlr?=
 =?utf-8?B?SjBqNGdFMEpZRllOa1lsa3ZCZ1pJTkR5eWp5dU1ydjk2UUVlckJ4bDQ0dG1L?=
 =?utf-8?B?M1Jvb2xQV3M1NTVMdGRxSFh3K0h3Y2piZ2FXdVhud0lJdGFURndGZUxUa3pJ?=
 =?utf-8?B?amt5Vy9tSElMWG5SY0MwYXlnQmlGc1lUZVMvenB4R0xvRUtYaHlKaDRPaURk?=
 =?utf-8?B?cExaTFFZN1hKVGIxZFZnOERtaTEzY1VXenpMVnNBaytMaWZoUHNOY2tUOUNP?=
 =?utf-8?B?SkxQV0Y2aEJHV09DbHRJUEUrSm92b01sWWNDN0NGK01SbEhWVkt3b3F5VWF5?=
 =?utf-8?B?NXM5OGx5QnVuNUxmcUNEMUtqUjdOUW9WNDVsR1AzSGVXMWFJelR5dVlGczNm?=
 =?utf-8?B?UWlzWllLb2lEemxxWVIyZFpwalVlaTlzajdtTzhVNzNlQmpiU3U4OWtNM3lo?=
 =?utf-8?B?KzByOGdveTdpMVZYTFhRdWRVby9vdHRjdXduN0d1aFFxSVpuNDF4b3V5SFk4?=
 =?utf-8?B?WWp2WjY4dFVLK0pkWVpUSlIrLzBWQ25QdE0rTTAxNVFSS2VXZWx6T1h1K3A2?=
 =?utf-8?B?T2sxYW9ndEZ1MytRM3FlNVFZcXZoMHl5eG5wVHBlRWlKNG53dGF4N0Juc2hw?=
 =?utf-8?B?dkdFN3ByUkxqMTlKcmpIcUN1R3V2QVNqK3ZxT1pndU00NXBZQjhvcUZFcE94?=
 =?utf-8?B?YW96WnE4eTYvZERLeGJhMDl6YWJ6ejFadlhoRC9hUjRNZmJ1S3JCREUvTlZ3?=
 =?utf-8?B?RWxlRUJuelU2V053NFByTjE3alJLaWpjTWlhbW1sUVJNbmp2b0Zrd0RsTDlp?=
 =?utf-8?B?NXAvL2RZUWJTTTY1M3FJa0pOK201ejdMZzMrdzZMZWZTMW9HKzZqUkJjWXF5?=
 =?utf-8?B?TlhwN3NRekQ0TFNNcFhQNnZuT3RkUUNBN2JsbjFIYTBabXhDaEt0YVU4VWpj?=
 =?utf-8?B?ZWZQSXE4aW84Snp6S0w2cVJZVkkyK1NqWkFxdnZUQWMvMHVib2ZNSmZuOW1T?=
 =?utf-8?B?dDI5aWJYNi9ZMmxhK0VDajJKVnJSb0JXZ3VPSWdkeU9EUTdON0lDVlpiRjJH?=
 =?utf-8?B?VkZMRjltb3liV3BwajcvUzgxWVRTMnFJV1FRSnNZS1prZFRMZ1Z0UEM3dUs3?=
 =?utf-8?B?U2h0cW5GdHJsT2JvVlp0SlhLNUE1dklVOWdMOVczc2dQclhUN0dXVWFvenY3?=
 =?utf-8?B?QXVqdVh2UVY5Z2RNajlsWHpJbEltbEQvcGw2Z0kyc2FwbWlUWWM2MFFTeGFM?=
 =?utf-8?B?aXlTdDFhVXdGMXRvd2tDSjhyZFFMQ0Q2R1Baa1hxZUVqZGlvVEdCNkFVVnRO?=
 =?utf-8?B?MVJ2SXVjWTM2TTlXeTM1WUVSQVRRdkt3eUVsWU9Ud3VJUFBtNlNrNHQraHdt?=
 =?utf-8?B?Lyt0YXRLQ3VFaXJNMmtGT2tWYVBmSS9wQnhEcXN6blFsUG5mT1pvaGowOS83?=
 =?utf-8?B?VkRYN3V4M1RYbE1PUlBHbVE0RjY1MGdwRklDa1VJTjJoR0U5NXQzQkx0L1NN?=
 =?utf-8?B?RUVsRkt0ZFdFRnlaKzFRb29yTHpvSGthdkxWb3dHdytPS1RNWHJYUHN1dUVp?=
 =?utf-8?B?L3hmMjJLZ0VZc0JIVU4ydWdlYnd0T1k1SFNVVFJHbFVTR3h1ek1relZjcUlw?=
 =?utf-8?B?Mm42NE9WMlMyTDRhZVNBc2taS1N4b0ZEZWs2T2pHU3pLbkplMHVVZFczbW03?=
 =?utf-8?B?eW5PUE9PdHd4ZlJ2ZmdCZzhqUytIaThJV0ZycHFub3JUTEFSTGd3YVlwb3dj?=
 =?utf-8?B?VnVYdTcxV2lWV0FUQ2hKM0lEa1VLeXNJbVhxMmZsc25kOHQ2clBQMXpmR2Qw?=
 =?utf-8?B?cVBGQlFBZy9uOVB2SWczTmhHQTQ5c0lXS0hwaEh2dFpVaHFBcXZyTWNzYkhO?=
 =?utf-8?B?UXQyT1paZENoa1hheDhPOGh0NFdPUXJSdFhMcEFMUmhBdzQ0Tncyck9hRkVl?=
 =?utf-8?Q?2BrzZCxd/oRc+DIl0cuu7E3ow?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c31082-825d-4015-e795-08dcc6efa91e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 23:26:21.8201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xm4e3dWL3YT6GSqx7J7ZN5glTDC9R6d3XoUGzeZ1JPFBIYMZZTaA21KB5u15YgP0pTyv7hf4MyxsF1yWVpzu1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6754
X-OriginatorOrg: intel.com



On 21/08/2024 1:54 pm, Haitao Huang wrote:
> With different cgroups, the script starts one or multiple concurrent SGX
> selftests (test_sgx), each to run the unclobbered_vdso_oversubscribed
> test case, which loads an enclave of EPC size equal to the EPC capacity
> available on the platform. The script checks results against the
> expectation set for each cgroup and reports success or failure.
> 
> The script creates 3 different cgroups at the beginning with following
> expectations:
> 
> 1) small - intentionally small enough to fail the test loading an
> enclave of size equal to the capacity.
> 2) large - large enough to run up to 4 concurrent tests but fail some if
> more than 4 concurrent tests are run. The script starts 4 expecting at
> least one test to pass, and then starts 5 expecting at least one test
> to fail.
> 3) larger - limit is the same as the capacity, large enough to run lots of
> concurrent tests. The script starts 8 of them and expects all pass.
> Then it reruns the same test with one process randomly killed and
> usage checked to be zero after all processes exit.
> 
> The script also includes a test with low mem_cg limit and large sgx_epc
> limit to verify that the RAM used for per-cgroup reclamation is charged
> to a proper mem_cg. For this test, it turns off swapping before start,
> and turns swapping back on afterwards.
> 
> Add README to document how to run the tests.
> 
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---

Acked-by: Kai Huang <kai.huang@intel.com>

