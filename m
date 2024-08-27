Return-Path: <cgroups+bounces-4528-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15901961ABD
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 01:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D61A1F244E9
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 23:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92521D47A8;
	Tue, 27 Aug 2024 23:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BnTIxj/p"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77F81D461C;
	Tue, 27 Aug 2024 23:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724802180; cv=fail; b=Q6YLnpiX0lCwlInFrxhlfjjiTUiy6f7j6vL0tbY9W0n1ns4iZKEjl5DC3F/qNslsypTttCFKwf+W0CCLq40ckAIw1R7/w3xNSdVpZZE2AS9C7IXZGGNzstS94lbPzbn7Gmwr2N8meqqWzPM/oKCCdOkbtmiWaPlTz4uqG9uiHbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724802180; c=relaxed/simple;
	bh=87jdKWBMFPL1mrrYRmue6oK4MlJpIzkmqxcr5Ja9CH8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IN9mMnSZXDFGoCVxlcoSoEArDxLMCeSZoo81dX82P6ExLGODZUGtRBB49ntigGAfWbWWH5Q6qHsSQ05DerV2m4ClAHuIi/Pf8IHd1B8HQVUwI4MfXc5laP9P8bQKgstdEA1JL03oYASZ7VFkiFuPMVLDVN9LN6qEfNxy2qZQq8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BnTIxj/p; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724802179; x=1756338179;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=87jdKWBMFPL1mrrYRmue6oK4MlJpIzkmqxcr5Ja9CH8=;
  b=BnTIxj/pIFMk4MPAJsbUrwbGJctp3m3AX3jjdKc1uZXgZ7GqIt0pg+np
   1GO+di8oNuLgGeZ6qCyYkrmf7rUJR8NkRzIfi7HPD2SBtHUIPxuaTlK1/
   EwhnW1Hc1LrSA35KMycU6nvFg4GrcDnSvMDjW3d5WB9sAOu7agYy/HPT5
   /uFbLqPiIxrrMtAFPrJZ2XHY0O73lKvqb/Vks/cHV/l0JAHO/ROBvNm7U
   4gzcdq4A/+YTz9n1YMImAPbAGS3KPhVfKi2HQP58lMxavKVUzx1fWcZFa
   p5ckME4uKH1CCNtpFBEoeNXdoxXAB8vS5XW2C3fmaqG+MqDNcVRdGWPR0
   g==;
X-CSE-ConnectionGUID: 57FV/4obRGyXB1RqJhbcog==
X-CSE-MsgGUID: me+3d4xHTwqVwUyW+6ZiPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23488641"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="23488641"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 16:42:58 -0700
X-CSE-ConnectionGUID: G5rq6PHqSC2vMYD7J7PfgA==
X-CSE-MsgGUID: ybCzgvdeSY6ZvhqaQqNDfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="93752619"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 16:42:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 16:42:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 16:42:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 16:42:57 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 16:42:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtaqkhjTHgu3TsKv6M7oy8htZRNTY7Xmaf+iZSvjx5H1cFNkZhY2I6s9eizmjWQ94XAUYPi4YlXQi6pWfJhbMqlekPh/oTGKWDasUKRlxLb3fEiHzYBPjobgiR8HKlOG835jb+KEDawJOhBV0TcBKl6d0hx/DwX/RadwMVNbGQZQtms1NMrmKgJmshypPpFd8Si9uxZ5d4DNZSuHp1Y/7tNVy5k/482x3J8t7BO8As3f4y6wzeka39d6JVf1bvTNgjaPC+xtmHdlafAlDMnRutYeH22iJUgtd+28JHIEphkJKLNL+PupGKfCoJ1Iw/NiBxqMcwTnhXt2DmoyVIDS2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqUwRhgp5n6xiLJL2JIdd0ATAQWUdxh/e90JaUXo8uY=;
 b=vdhKzCAGGKvk/qziaUsj7hXNdT0Kgu/y8WS2xe10VzuXOBDQSx+gIiDT4D6g43qY4gQBysRod+vu9SJa/mBbUS3rBMXP1WeyNm7SEwp7rCRLleu2V11JRI1NKgPxv9NMQvixDUGhXEaJxn0Mp6/H1nNk8NX413uUfUiyoQlfemJVzaARkTPT2R7bY3KfvAkv32X1M2PADq3RYJqVno5+hxjcFOk0SxEFjog6Kfykfeipy+xVED7WZjw+L12xVyyk8/NGYFRcIiCsvjcu8mm1iUvz5iSkXNFIlCAm30CaO321FEj3YhqpixjK9jhR6CsD4oshjCyOz6GrCSnDOEDGyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CO1PR11MB5012.namprd11.prod.outlook.com (2603:10b6:303:90::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 23:42:54 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 23:42:53 +0000
Message-ID: <dfd9172f-b414-43bf-974d-b30f942715d1@intel.com>
Date: Wed, 28 Aug 2024 11:42:42 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 09/16] x86/sgx: Add basic EPC reclamation flow for
 cgroup
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
 <20240821015404.6038-10-haitao.huang@linux.intel.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <20240821015404.6038-10-haitao.huang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0093.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::8) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|CO1PR11MB5012:EE_
X-MS-Office365-Filtering-Correlation-Id: 849b82d4-eb2d-4d44-1e09-08dcc6f1f85d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVNSNEhFMVpEbGtlcHVxOWdzWkRlUklJNVBTZWg0cmZ3OUMvWVRjRHlYNDVM?=
 =?utf-8?B?M25VdE5xa045ZjNORlZoSmVuc2xDK1FJNzNWamJ5REF3eENIOFZoRUoyakxQ?=
 =?utf-8?B?Q0E3bWpNOVE0TWtOc2J2d1ZaYm9mZEVvUEh3c3I1bk5ka0RUZytDUFZsbXNF?=
 =?utf-8?B?WmJYYnRJZ0pDZ3N2RXY5NkVjVnpoWFBxV2tXS3dmalBtQlZ1WDMySU5oMG9Z?=
 =?utf-8?B?eGl4Q3h3bnpMcnNtYUJPU3dPaDlxYmF4d3daa3FMamY0eGdsTy9FaUpRNURa?=
 =?utf-8?B?a2U4bEhWS2xrVk9XOEFDbVErTHN3dzYxejJMNFpCMDBHcTQvTExzei9sS3ND?=
 =?utf-8?B?NnV5Q1d4aEQ5Tml4SHoybTIwK25McGR6YTUzVXF4ZTA0aFZJYjNOdmJpaUtl?=
 =?utf-8?B?YlpmZktTMXNZRVZKRkZhZnJxRXFjTnFzWURTV093aUoxNXlrSEE4QmRlOG0z?=
 =?utf-8?B?bytqSlBZYWtEZWJFWXFKWFJRRUxmTmlYMUZ5ZDFNb01WRndjOEdwV3J6ZE1j?=
 =?utf-8?B?c0FXZmtMdXBkMVFYeVBLcjJDb00yNStBZjMyTGcyWURUUitxUW1aZVJhRE9N?=
 =?utf-8?B?NEFjWktkbnRWUGwyalphOUNMSFRnQUV3RldXNGx6ckZDUmozYU1LUDNiUksx?=
 =?utf-8?B?cml0dnV3RlcxWFJzZWpSZExERlNDYWdTRUYwVURscjVTODZCZDUvU1lxbXQ2?=
 =?utf-8?B?Z1BURUlYcWFZYlk0RkljbzBqd0xKdTA1ZXRNaDBQQkM5WGlBUmtuallpTU1y?=
 =?utf-8?B?QWxvVUIzcC92bmVQOW84UjFBR0d5SmxMTkxrRTExb2x0VWp2eml0U2VMYWl3?=
 =?utf-8?B?YnpQcHJLWWMrSGc3YXphaVZ4MFZkNlVlU0lxS1JtVWRvR2YyV2ZuY3RrWGZy?=
 =?utf-8?B?Y1pjMk93SWNVbUZ2dXNDVmNWUmhwYkRmU09pVVRBTTJITi9IT0syN0MrUEV3?=
 =?utf-8?B?c0J4NHgzeElaUUxLZjVQMmZOeEdHeWNXNmNwMlRjNzF0bTJpMnY4R0QzUEpG?=
 =?utf-8?B?cE81eDVTY2dDV2RBdUhFVVN3YWhEb0hFOHNGKzVOTGhKTFlkWDVtMkNWdjVz?=
 =?utf-8?B?SkhDOG1GeE9rN09WMVNua1BxQW13dDhTcmpGbXJZdlVrSWNSeFV4QkNvcndw?=
 =?utf-8?B?cUhGRUxIam9PZDVEVEFQeGFiY0htck0xU2kzWWZzTGtWMXA4RkxqZzZBb2tR?=
 =?utf-8?B?WEN4bVpJOUZnSTB1L3R1emN4VXE5YnU3UHVUME90VkkvemRaa3dTcW82Rm9J?=
 =?utf-8?B?aW9YZ2Z2YUdKd2YzRWZ5SWxlMEtuNTlSWjlYT21UK2FON0JrWWhHWDNXTW1H?=
 =?utf-8?B?cjkyeDhTSmYrZ1pjNXdqb2U2ckZCOUx1ZERKNElQOS9FYlFNVm85OUdoWXdI?=
 =?utf-8?B?VytoUHdYM3ltR1AvNmJKNXVDTGZzL2c2Q2JoSjJMcys5MkhiVTk1TFU5YVBy?=
 =?utf-8?B?NFJsdlJ2MWYvMnprTTBjcE82ai9sZi8zU0ZuUm5mZE55YUYvZHVjYkZ6UEY0?=
 =?utf-8?B?bWlEdTlPMk1hMUx3Y1o5aEhCbTJ3TG84cUwxdnZPcXo3L1AvV0diSkVEM3Y0?=
 =?utf-8?B?QWgxU3NaL1RwS2MrbmJVTUFCVGdBQmhjTmtRR0hUUVgrNHRERnFKMlJVUHM5?=
 =?utf-8?B?Rmxkd1RCalh3R2piVGRJMldtNnY0WnY1TjRNZXZDWTJ4dERxenk2RGE4NjUx?=
 =?utf-8?B?bFFJMWVBOU5wN2lQOUlJSTdnc2RxUlAycVJ0cW50bGRDanBRVDNkQkdwQkcx?=
 =?utf-8?B?ZjVONGpXSkZ4R1Z5OTM1YmRGWk5LcTRRTklVMGcyS055SUZCUjk2R0NhWjhu?=
 =?utf-8?B?UGZuenJnOVdTalhETlRFRVZHcmpaMzdDUEZ2Ky95d3FKSXllNzBpb2JFK05I?=
 =?utf-8?Q?JjLAnZZqfODbb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXZMN1V6d1RneE9oZkVraVM2TmVIcnJnS3I4dkNTbkh4bFJTSXZ3QnY0eVhC?=
 =?utf-8?B?UittWHl5cURldnlvTkhRM2l5OFVxK21XVzhJZU52NTliVWwyWVNVQ250aTJv?=
 =?utf-8?B?LzlqVWRsOENYMDBaOFFzeitqcmJLUGh6Q1VXVUZ2SS9DdzY4djRLeHM1OG5o?=
 =?utf-8?B?VVhybXNVSjJNU05yRWIzZDF5TmFiK05CNlZQbWlaa3dQejZkS0hpL0lXZmo3?=
 =?utf-8?B?enRvRTJXN1RCNnpJWlpvTTZERW1pckkzUFRqMSs1UCtwVWs4V2x2VllNeWhM?=
 =?utf-8?B?SWJRbTlRaUJHQ2JqaG5lVks0elZLdUxCUlp6REw3NVBQRVptM2dZMjRkcTc4?=
 =?utf-8?B?UkxBMnJjZVBkblI3OWJEVEs0YjRDanFVb3prZjRsR1NrbmNhNVl4YUdrMjEy?=
 =?utf-8?B?KzZtb0I2MGJnYnVJQUtwanU5aFJ2RC96Qk9jUmgzRkViMGZLeitzcWUvd1Q1?=
 =?utf-8?B?S2dMdW1oTmtVUU5Iamhyc1N6Q09XUkpvMEVONzUzVGlRZUxpckIzNGpReFV4?=
 =?utf-8?B?dm1xYW1lZmNEQWhUekdIZjByWlcwR1BzUTRTd2lrZFpVazd6MjJMbHJPa1Z1?=
 =?utf-8?B?blMzSDdQTGxudUpya3hwNEpSSXJTdWVtUlhUK05teTQvRkVuc2w1ZW92SDBi?=
 =?utf-8?B?QjZ0dSs0aGg4elJKY2hyMldoOXZXNUtpRWt6blZYaHVkK0pDZkZRN0paRU1I?=
 =?utf-8?B?QmY3VlYxY21yelpxS3RYUUdlaDZnUVFxd0tSbzZIY0R0SUtEQ3BxRWJNcDl0?=
 =?utf-8?B?TGpDUU5MZEVQVGNmZTVwakJSbjVxVjluZTNxZ0kxZ0RFVDk4WGltQjdacjFM?=
 =?utf-8?B?UHZBUTY5SkdOU25jcG5Od0s5WU5QaXV5Q2RSMElTV0lNTGNrZTlMOGhKczc5?=
 =?utf-8?B?dmh5T25GbitITzVSakdRUk00bUlDRnZVZnNucGU1M0gvV0tCbGdtWmtSWWg4?=
 =?utf-8?B?T2Y4a1ExeTArbUFtK2lPNkF0T2NCbGg4dHBQQ25ZQVU0UlhwbytlaUZKUUQx?=
 =?utf-8?B?VmhHb1BtTklVOEFHZnBJU2dCZytueE9aTjNCNjZXdHN5WXFCQnorTTNrV29D?=
 =?utf-8?B?Uk4yeEp3bHFXZit2M3NkVFVEYXVybDNFZnVrci8ra1o5L3R5NlMwMVFSZzNC?=
 =?utf-8?B?WDA4b0lCeXVBbmN0ZFAyMURZOVFYNW11ZXc4aDgyeVZlb2lkSFlpNWZWaUU3?=
 =?utf-8?B?U0YxRlBMLzg0bURJSnBlWDl1N1NQcHJnUEJqWEY3NXpFanVzL2l0SzMxeW9u?=
 =?utf-8?B?eGMrK045ODY4M3pXMU43TjhvejYwNFZyN1ZJS1Axc3M5WXcrQVB6THJhZUUr?=
 =?utf-8?B?MzFxeng0cTRHYWJWNnllM3VxdHZ2UTNXSlhlVzNyTzRsZWc4dSticnVBa3h3?=
 =?utf-8?B?MUNwQW81RXFoQ3c4a050Rk9OS1lxME1VQmxkTnU1TGFWeWxlNXlsWU1Jck8y?=
 =?utf-8?B?RkN4RzhzTUR1dkpWQmcvTVVxcnUrUlludDVEd0tzRXNqbndNd3RnUjFMZ3ZW?=
 =?utf-8?B?aXFEUktnanlxQkVmNjBSQUVqZXdORmlzS3pKaEJJUXNHYlg5NTNnREdCYVFN?=
 =?utf-8?B?ZVhCN2tWY1p4bUFZRjR3QXY2ak41UHhaN2lGWE5wemtHblo2NUljN1g2TzFm?=
 =?utf-8?B?bDBGTndyRHNxOU96d1FGT25TWERaOFVzNXpoc2lHNGJtT2tGR21RYzJyQTZR?=
 =?utf-8?B?QzNjQWZtb3p0NG9Ic0w5ck1YRlhmTzZFR2U0WWJzY3U3a1YzNERXQldhQk9l?=
 =?utf-8?B?UXBrMXRtcUozYnVTQ0ZaYkswWHhJekN1STdUa3AwZ3hBMzRzRHg3QkJ2ZjB0?=
 =?utf-8?B?SGZJd09UdmZNZUFhSHpmdEpxbzQ2K2hGd3RCdHJQVllzNys0eU5GS2FJdFdn?=
 =?utf-8?B?bkRPTjMxNys4SzYvVFpjVmN4ZkR0RHBvcmwzU1FhRjI4ZUZKUXhKVWg5OWp3?=
 =?utf-8?B?SUh1WFJkVFM2S2xkMFVzN2FwcVNRa2ZzWThGU3VNaXFOaW9XQ0k3ekhuLzla?=
 =?utf-8?B?UTk0VXBOWkJ3a2RnMk14WFdHaFNrYm00OEZ1UFdqQXVCSVVGaExmVlExcUkv?=
 =?utf-8?B?dkc0b1V2WDlJanErNXRNSzlXUy81ZDlld3NtR2Vac1hPcEEwd1ROOXYzbXMy?=
 =?utf-8?Q?5Txhd5UAoCpEocwt5MTgDeagb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 849b82d4-eb2d-4d44-1e09-08dcc6f1f85d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 23:42:53.8146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQ/1/7x6knrURRgf2c7TcWVlFlJtRDhr8zU6duWzf6UwHMPU4/he8/lg5kGzKjrnVApMUXaEr9T0DpOgzFpm/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5012
X-OriginatorOrg: intel.com


> 2) For on-demand synchronous reclamation, sgx_cgroup_try_charge() needs
>     to invoke the per-cgroup reclamation until the cgroup usage become

"become" -> "becomes"

>   
> +/*
> + * Return the next descendant in a preorder walk, given a root, @root and a
> + * cgroup, @cg, to start the walk from. Return @root if no descendant left for
> + * this walk, Otherwise, return next descendant and has its refcnt incremented.

"," -> "." before the "Otherwise".

"has its refcnt ..." -> "have its refcnt ...",

Or, "return ... with its refcnt ..." (which is better I guess).

> + */
> +static struct sgx_cgroup *sgx_cgroup_next_descendant_pre(struct sgx_cgroup *root,
> +							 struct sgx_cgroup *cg)
> +{

Reviewed-by: Kai Huang <kai.huang@intel.com>

