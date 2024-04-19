Return-Path: <cgroups+bounces-2604-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7D68AA689
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 03:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 069F0B220DD
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 01:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2094B1388;
	Fri, 19 Apr 2024 01:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dhuatcch"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1310FA;
	Fri, 19 Apr 2024 01:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713490358; cv=fail; b=Y7+2bwESMOEm9Kf9Q9jPF+B7WuD4Cd4KAejGzwFMZQhFKVXsUJvrEq42ZkqtrFlWmY8SfE3+WHJa6DXz92nu4XCfFe0MucRYzm5oTtObmCPC7uBqNyDw/XvOQoV82N3zu2fXb4iUK7kaLis+t3+7VMwPV+6lRtgwEuycpEIjKT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713490358; c=relaxed/simple;
	bh=JsraNVDODJMoSZ+AX5HW1LLfQ8dK4cyqJRv3xq6g9DY=;
	h=Message-ID:Date:Subject:References:From:To:CC:In-Reply-To:
	 Content-Type:MIME-Version; b=j8aTt+3SYGtrKqtUQUKowOrs8NnuqAUVnYaYHdZONN862yjgopHsJFDcWzgmk1k04FQGsLQGe1tfgAheg3AOAFOANTGMPqGcgP9Wm+d+HVghuuQPmYBUT1bFaWtLZKfAFtdm54jmi4JVkv1nwosXFlTaFCkPo7A3QG+m44hoVDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dhuatcch; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713490356; x=1745026356;
  h=message-id:date:subject:references:from:to:cc:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JsraNVDODJMoSZ+AX5HW1LLfQ8dK4cyqJRv3xq6g9DY=;
  b=Dhuatcch5iHQuVXR0BOCSnOmtljdnfVY1m9TYzVTQ31qTI4S0KpDESqD
   TBLyoO7Kxi8rUJMcpoMf0nt29dGJDVnQVbMxEC6j1Sz5K+ZH3V1C07uEr
   bqARPe+pUC9OKgmHtGkD+1AHTcN0PO/nBPPUCzkjU3SLXbLe2gxpNJtJp
   WxBwLBLkwAlWijlzOsWnwc5oEnMBOLerhd0aQoAbSU6H5STIEOuj9+aHB
   dVHS8hz9Ep9NzAKsw4RyzuGd4vI2OJ/bKDyCMcB7YeoxLCgDLpVDMrbMo
   l6hcssZ3AP7utM8XUR0s11y7QQMIvWQLpG9cTIu+MQvITROY0hK4ujlkB
   w==;
X-CSE-ConnectionGUID: QAL5XBC6Tbe2AHt8ODxQOQ==
X-CSE-MsgGUID: 85NgWm3UT/SS3//kGshr8w==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8948168"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="8948168"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 18:32:35 -0700
X-CSE-ConnectionGUID: 4ZuoKDIZQ76Kmhj8DidQJA==
X-CSE-MsgGUID: 7ap3FN3+SsedrKsZB8MsIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="54094071"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Apr 2024 18:32:36 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 18:32:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 18:32:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 18:32:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 18:32:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuxJxx2CXigiiKsqIvDZjXMFMiY6G2QLd7ZaMnbLHgGnTDY5hRztuYLhccSm4t6DyIhJSAGgT9kciynp5ElGNE7tPMOSUlHmCk7VRMvS/Bwc+E/Y97JngB1er1WpAEh4CRKqLvPjtzw1e7hm0Qp4iUstBYXHudsLRAwAmsYw5nzyJEYcauLoo9BsCBoYeEkChrEJxPQ/USK/mI/K6RxVetgzTE2vLQZVCGjeC3Ctg0EBY6j+z5w3sHen4dbIr5BWNzYZDrf93fqC4mnxqpFZwqmSbXpgrUPv3uce4iXD/MXQ7nN96iiBLPCT7fmEvhVY9HP5axuS7bjbGfCllDVJvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAIMZ+K7ti1qWJ974K42qCAxkCmHXnJpGAMM3iTLu3k=;
 b=Ln8Q+cD8z74ydx0uwDVApfQUcdQuFDIwu9r0uFMT3DDCYzQ3MBQt8DKIkwpyMnHDd8wtVQ9QBiJsnRWeNAzdbqOqEqrkGYDVPDB7bd7XGhq8JxEHAzcgjA8qLdBSNpqE/Fk3GsL1PHS0keWgOn4fgtWDaof3u3bqrIzi897CPZAUKhQK7vtpuxr44+6Qe+32Tc/LdllHpRtm5Nbmja2MewZnmWcQCU7GosqBfQAUVG1BcBV2bin09s7+5LI42Qdd8NZo9Mlb/sYtbakxpJbILGoBLccBx6k5GfBwtDg/D8VTNCPStFX9GnqNGZKL91G4YO/zZ/NN5x1RywZ6ijykiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS7PR11MB6222.namprd11.prod.outlook.com (2603:10b6:8:99::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Fri, 19 Apr
 2024 01:32:26 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 01:32:26 +0000
Message-ID: <640866c5-9fe0-4f7b-a459-7a685dbe4092@intel.com>
Date: Fri, 19 Apr 2024 13:32:14 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 09/14] x86/sgx: Implement async reclamation for cgroup
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-10-haitao.huang@linux.intel.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
To: Haitao Huang <haitao.huang@linux.intel.com>, <jarkko@kernel.org>,
	<dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
	<linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
	<x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>, <sohil.mehta@intel.com>,
	<tim.c.chen@linux.intel.com>
CC: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
	<zhanb@microsoft.com>, <anakrish@microsoft.com>,
	<mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
	<chrisyan@microsoft.com>
In-Reply-To: <20240416032011.58578-10-haitao.huang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::16) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|DS7PR11MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 6473134e-03e8-40eb-739b-08dc60109215
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ppp9VnLx5PsKnzp49BFIAQ6UMw52nvrC6aPF6PI2Z0OPlqDd4qmGPPmKqSyXj5rVdQvFh3DjJMlc0ipTwEIX6EeuNcImbQin7kTuGA9DFN/ZL48YFlmUsPhhCGyqSsa4bUDbrz7VThF+XsWGkUkwCAK75klsTVt6S1VoFxucr4ar2kDlMYorRedm+EQyIQSFqQElfHUWM/SIBG6Yw5Y6C3OXzFchUsvWTrD7hzaVUrSA/w9kfjuZtugI7CDhq2usL+wUSALZGPFf4mD7vxhW9e+ay+B90D+Z1M6NFreV8RZFmSSW7pFxEgfCnTo0M3ph5GiNNzgmzE+mTJ7O8RjK9XGxfKAlPaJsTaHKKWTS5GJEu+zPEpbB4OdPMraUX0b1C7Q3f/rFzc+NOgbtxdvhu8Sgyq/x5343L9l7uOAEo13Srvu4zYpXh2P9JfyGD8zJF39CcvseEPdEtuOnc9E5rca/1/Ve0u4/wwYPGf/8ZynFyYcd3hPl3kLODzu7LYRP828oTNPtR3xI+aSWqPDCB+rvhIlt1MyKaIFDHRBqspCmzlzDwN+FT2AEHQeyAJiQu1fC085qqiErBpah/BV0IybhJsUhHNzLaf85eDILvThOWehW1v6E87TZiYUbdNaeTob2LbSUzZvKKfpwwTB8hTIy8NbxJ3yEQ2dCuZIBIFoIg529K9iMbt11yT9tcUMGU7/GH9576u/oYuZopBnWLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEFpaEhseTQydmw5dERGL1h1d0FRdVFZM2tjNlNCRkpjMGFaUTZKNEhuTDFZ?=
 =?utf-8?B?Rk5IZDB3TVVwL1NXd2N4eGZseVFIZjR4R0JiOXUwbW8xdnYrZnloRzFRMWw1?=
 =?utf-8?B?Mjl3c2hSM0ZrdVRtY3k2S2lUdHBnRXJiUWNnNTJVRVJpc3NNS2RjM1M5Nzhk?=
 =?utf-8?B?aUVaallxNEYwWUR0OFkxMGo4aXMzTlFhSTRhQ1ZvVGNoQ0xmMW82Ym9hZWFD?=
 =?utf-8?B?ZlRyRStGT1I2enJ5cmUwL0tYUUZmRzZ6ZUQ2eTFXR3BsRGJnMW1WOHFJdWpD?=
 =?utf-8?B?T1cyYlhQb3FPU0FMbWUvZjF1SDJscHFOeldEODd1Z09ob0s4REptYmltaVFS?=
 =?utf-8?B?YlhzR0Rwakt4V1dqZ01zZFlFVUpaZ2FUcjNRZDNEdzd4OUN4Wk1LL1BaSktF?=
 =?utf-8?B?cm1SMThCa1hndW5ydEZhMEcrTjFpY09OL052MS9hRUhqWEpiVmZrS0VtRWV1?=
 =?utf-8?B?M3E4VkZiRkpvZzRVRVJRMlRBTEFjcEFuSjEvZUJGckp2aWswbUVtQUZ1RHBS?=
 =?utf-8?B?aU0xVjZTSTFZOVFkUktYSWlaUnYzQ1hmU3prQlN6a2dIRVVlVnhUcTVSbWxR?=
 =?utf-8?B?UlQzc2FXcS94Zmhhek4xVjR2WVdrRDhiS0JDMzhZYUpTWXhZK1c3Q1VqVFNS?=
 =?utf-8?B?ZkFoNlY3eGRuWVIrZ2FLUjY0RzlkVHVVN0hTQkw0VktrbzRuY1RhZG9vcG5B?=
 =?utf-8?B?bHUwYmQxRWl5ZFE1V0Y4OFQycHdzMk5Zd2xXWDdzbmN5cm5iRFhCYWM3dFls?=
 =?utf-8?B?Y3NQMERzL1VKbXFVcHdELzdJU0pNR2NIWWZJWTdXQk5Zb0JBdmVUeWIxVzE1?=
 =?utf-8?B?WUxQUzREa1dYT0twMnI5bkRqd2tYQWx0TzJxdWphWVZSa3lDQWU1ZmdyZ211?=
 =?utf-8?B?RFpuTUt6djJoQzNTTm9tdFBZemFnemNLMTB0V1ZYVU53RFhiT0ZsbTRlVXpj?=
 =?utf-8?B?Q25kU2dMcDErTXIySnNBcWZIL0s0M2RRZDN3OFJxVHA3VEZTTXhqYjdGa0VN?=
 =?utf-8?B?d1hLSEdDc0NVTDRtVFlrQUpQY1IydVVlMWZIUXE0cWJxNXNjck54alpmMnp0?=
 =?utf-8?B?MTd0MUxqVkJmUVFUMFZlY2dOUG53UTRzVDArWm5rb0dqTjI5NHdsU05qYWV3?=
 =?utf-8?B?TjhqUmpVTDR4MFlqRU5iWnJvbjlPZnN2bE5hUGlFMmRpek9zaDYrTWdjWmkr?=
 =?utf-8?B?TmsyMTBCWEVxMG9OcDFFcGlGQk94cWJRbThtUVJPNTliaHZ6VWUxdHQvL2tv?=
 =?utf-8?B?K1E1MXZBQUVsZmhJbUlKdFpwNXFlSFFLczFXN21QMWMxaEdLMTBMY3ZPMmda?=
 =?utf-8?B?UW14b042eHNDL2I1bGk5S0ttUVVMOTVWTkNuazJDdTNDd0s1RTI0RkR0bW9i?=
 =?utf-8?B?MUtISDZNVThBbDdXQXZnbEV1U0w4UXlpdzl2L2RaSmJEcm5nWlgvdUk3SEdx?=
 =?utf-8?B?bGdwQXc1OFF4MzdlWTV1dFBFMjV3eVp5WVBpU093b3lDRVU5dFJYeks5Rm5z?=
 =?utf-8?B?UlE3ODNxMVlzdEEzSFlJc0VhMGJrei9aR1ZWTkhrYTBxQzByd2R4YWVzaWVN?=
 =?utf-8?B?TWlHWEdTT3pXQVlXUVNNWmtGSmhOZWI4UTJmSERTZ0MvMWpRVVZhZklwMTVN?=
 =?utf-8?B?NXhiUTdsZ214OHNKMmg5aFFuUDlFNFJoNnhpbmVhb01kWVBNS1MwdUErMi9E?=
 =?utf-8?B?RjFWaGhmZGdpbnFrR1J1aFQwYjZNU0FlcDh0REFRQllKWms2YnBUYTFrRnZH?=
 =?utf-8?B?U21FclRJSENXQ2o2LzEvcysvdzdNWDMvcTdHcDJlNm9DU3FJWHRPbVFkeG10?=
 =?utf-8?B?ZHRTTkczaTFGNmF6M0VQcmNMcDlQN0JBMFpPaXdWRjZBVjhzajc0Q08yNHJw?=
 =?utf-8?B?bjFPV3VwTG9aNGNUNi9qRHN0VEZzSGZoRWxJb3RpeHI1b2lWeU5GekplaWpi?=
 =?utf-8?B?cWdBR2lsNzc3MGRzWUFYdFNWY0gxMHJQRCtXSzJ5Zzd3c2M3V3h6dkcyeW9C?=
 =?utf-8?B?UzJZMXl6VVRPc3lleUI3S2xxYy9hTk9mSzNDZm5mL0VnK04xWFZ6bTlIMEFT?=
 =?utf-8?B?R0JjYk83Q1psZ2dWY0NldDBUUjJKRmtDMENWQXFjeDVCenBaeVFqa3lNYlRj?=
 =?utf-8?Q?5giyPpqcPdpL2hRJGTS9PjPcc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6473134e-03e8-40eb-739b-08dc60109215
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 01:32:26.8036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U64ZlP+YB9YFcv3whQl0lyfvlaJJkRsZRfJtQOZHlJU2TyBaitHepJWH9+53YUgne7kN8O4lTkKLAW7S6KkfDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6222
X-OriginatorOrg: intel.com



On 16/04/2024 3:20 pm, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
> 
> In cases EPC pages need be allocated during a page fault and the cgroup
> usage is near its limit, an asynchronous reclamation needs be triggered
> to avoid blocking the page fault handling.
> 
> Create a workqueue, corresponding work item and function definitions
> for EPC cgroup to support the asynchronous reclamation.
> 
> In case the workqueue allocation is failed during init, disable cgroup.

It's fine and reasonable to disable (SGX EPC) cgroup.  The problem is 
"exactly what does this mean" isn't quite clear.

Given SGX EPC is just one type of MISC cgroup resources, we cannot just 
disable MISC cgroup as a whole.

So, the first interpretation is we treat the entire MISC_CG_RES_SGX 
resource type doesn't exist, that is, we just don't show control files 
in the file system, and all EPC pages are tracked in the global list.

But it might be not straightforward to implement in the SGX driver, 
i.e., we might need to do more MISC cgroup core code change to make it 
being able to support disable particular resource at runtime -- I need 
to double check.

So if that is not something worth to do, we will still need to live with 
the fact that, the user is still able to create SGX cgroup in the 
hierarchy and see those control files, and being able to read/write them.

The second interpretation I suppose is, although the SGX cgroup is still 
seen as supported in userspace, in kernel we just treat it doesn't exist.

Specifically, that means: 1) we always return the root SGX cgroup for 
any EPC page when allocating a new one; 2) as a result, we still track 
all EPC pages in a single global list.

But from the code below ...


>   static int __sgx_cgroup_try_charge(struct sgx_cgroup *epc_cg)
>   {
>   	if (!misc_cg_try_charge(MISC_CG_RES_SGX_EPC, epc_cg->cg, PAGE_SIZE))
> @@ -117,19 +226,28 @@ int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim)
>   {
>   	int ret;
>   
> +	/* cgroup disabled due to wq allocation failure during sgx_cgroup_init(). */
> +	if (!sgx_cg_wq)
> +		return 0;
> +

..., IIUC you choose a (third) solution that is even one more step back:

It just makes try_charge() always succeed, but EPC pages are still 
managed in the "per-cgroup" list.

But this solution, AFAICT, doesn't work.  The reason is when you fail to 
allocate EPC page you will do the global reclaim, but now the global 
list is empty.

Am I missing anything?

So my thinking is, we have two options:

1) Modify the MISC cgroup core code to allow the kernel to disable one 
particular resource.  It shouldn't be hard, e.g., we can add a 
'disabled' flag to the 'struct misc_res'.

Hmm.. wait, after checking, the MISC cgroup won't show any control files 
if the "capacity" of the resource is 0:

"
  * Miscellaneous resources capacity for the entire machine. 0 capacity
  * means resource is not initialized or not present in the host.
"

So I really suppose we should go with this route, i.e., by just setting 
the EPC capacity to 0?

Note misc_cg_try_charge() will fail if capacity is 0, but we can make it 
return success by explicitly check whether SGX cgroup is disabled by 
using a helper, e.g., sgx_cgroup_disabled().

And you always return the root SGX cgroup in sgx_get_current_cg() when 
sgx_cgroup_disabled() is true.

And in sgx_reclaim_pages_global(), you do something like:

	static void sgx_reclaim_pages_global(..)
	{
	#ifdef CONFIG_CGROUP_MISC
		if (sgx_cgroup_disabled())
			sgx_reclaim_pages(&sgx_root_cg.lru);
		else
			sgx_cgroup_reclaim_pages(misc_cg_root());
	#else
		sgx_reclaim_pages(&sgx_global_list);
	#endif
	}

I am perhaps missing some other spots too but you got the idea.

At last, after typing those, I believe we should have a separate patch 
to handle disable SGX cgroup at initialization time.  And you can even 
put this patch _somewhere_ after the patch

	"x86/sgx: Implement basic EPC misc cgroup functionality"

and before this patch.

It makes sense to have such patch anyway, because with it we can easily 
to add a kernel command line 'sgx_cgroup=disabled" if the user wants it 
disabled (when someone has such requirement in the future).




