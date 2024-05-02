Return-Path: <cgroups+bounces-2754-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358AA8BA3EE
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 01:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F911C20B6F
	for <lists+cgroups@lfdr.de>; Thu,  2 May 2024 23:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FB21CF8B;
	Thu,  2 May 2024 23:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/lALaWl"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4FD57C96;
	Thu,  2 May 2024 23:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714692206; cv=fail; b=OnPJbzWxSTuysoNf1h9w1xFiroXoCE6WM+Lh0OcWgwSkhEkh10WiPtc/rMCGdr3BTHfZQ2OTTCcTJs1KClFSJCVg/reuB7lE7L3qQ1er2xpf995AAEA8TxIW6cjYt/vmRsFH4NlB1suli/JSqj2cE4kJX+jgG/UkzlagMpQKJT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714692206; c=relaxed/simple;
	bh=e4Yqm/wVvyDOJ7CxViUd9VeVZNlwiWvTk9cGBHVo6NQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JIsrruMPE0htMabLj8Y/FskEXlIr/gxwR7WDW1fq/TB6vouytlGnRB/oxmclcZYGjCMMq88dx2Hc6E0I431tv/7k7GI1hPHg0ahy/39BLtapkX1OlbWRfL50i0xpaOCR8BEcd/UJL2CNHHN+OlwDzbLTqpUwDUV4bVvapWFiNso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/lALaWl; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714692205; x=1746228205;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e4Yqm/wVvyDOJ7CxViUd9VeVZNlwiWvTk9cGBHVo6NQ=;
  b=P/lALaWlalBaDsNs0vX3BF14MWsFlDwaXkcGAMKCQ6AW/RdbSCqSnIfM
   TPYVQ02SBy0FwFh5VqyIdY3m/uCQ/jZ9Sxx849T/9+nx4vMYJUi/BGMej
   oM4q6jzlksMIr/msRU+nt673aD4g95Ti3wxSwDmaAaZuZyXAJ2Dk6f5bw
   wpebbhmA4cFJdJwmdhepBrp0jRjN4QqZrHsAngV15uTJnh1/uHNcpIm59
   HIRl2knFSeBz9osF/uqF9gvL+j5OimupwviKfIShk7CrjG2Bck3putFpB
   yt5YroDHUioGPAPrJeOQ8P9Jft7WGqXDpTNEj26vmG4+AMXVYUzi6pGkz
   Q==;
X-CSE-ConnectionGUID: hfp2rythRSOnEu+nzKN2Vg==
X-CSE-MsgGUID: D3BEiVavRk2QTU/463yDmA==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="21638882"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="21638882"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 16:23:24 -0700
X-CSE-ConnectionGUID: ANQM1SMbTyepa+KfDDTeiQ==
X-CSE-MsgGUID: aAB4k83XTYWc10Mvi+2duQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27305734"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 May 2024 16:23:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 16:23:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 2 May 2024 16:23:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 16:23:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHoJKKRyShGWu2k3XP8yb6wOIAnhQ1snG00F59VmSPHyQPvw1yhX2Pb4ZN4mINPjvDpQK90wqVJd1sIVy780mplsB195zNh+gdK9yblduWa3tijAqwiLI968AwFJn6BiZ31MHTcfVeYhZej0JcF3Vhto6eY1t4jbruiqA4sblw4RGY32uDoq3r/rklUEcFr4pq8nKrStEAApQI8KosS51Yr+4pAU84ynWgP2lbPC9KIrwWVHNqWg092tfWhUyHuEjF/gUa8gt17jKW8ulQ0BNAsiysx39ITr4iA7fl2eAfpJJxNB3Q9jb1/Rvu0c3IesWg9HpoA9KYhq7Rzi9xwNAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrsD2FvaBm1etwKaX90QJevT/fAD4r5WaLxrEFy1nk4=;
 b=CXnB0RQmbvfsR4WL98aItFFd9tC9U5/2/M0gFFiuXlTWQfUA1/ULQYfhqxGCPqUTvjemJRRHVKExx8RR/+I2KdLOIxn/7HtjfVpLkKH5ZUibOxU09bcwYxH9OdMvLfBOkLe+kNUo2rbOOIMtsv5q6Hx8dFPvk6LMWVwXR2u5XerFCXFUpHn9xSg/7qzrGaSx5cBdHa89zFklplgqtqUgeUPWfWwMXo4VFKq05Co+hru6OwHpqwXBW3iWBrz7Cd+Vs9LgNwLiJrJqlIatfDYwdnhIRzI2ZbUeY8Cq0JvM+XYLzkW6/iiUHhZA2jK67+6AIdiq8kEWbaatRZrvwZVf+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA0PR11MB4717.namprd11.prod.outlook.com (2603:10b6:806:9f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Thu, 2 May
 2024 23:23:20 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 23:23:20 +0000
Message-ID: <3eb37a6d-ff52-41b0-8f74-d9d049e6ce05@intel.com>
Date: Fri, 3 May 2024 11:23:06 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 11/14] x86/sgx: Abstract check for global reclaimable
 pages
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
References: <20240430195108.5676-1-haitao.huang@linux.intel.com>
 <20240430195108.5676-12-haitao.huang@linux.intel.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <20240430195108.5676-12-haitao.huang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0207.namprd04.prod.outlook.com
 (2603:10b6:303:86::32) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|SA0PR11MB4717:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dede960-bb03-449f-5829-08dc6afedad7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEI4Uml3T2FDdmdKK0JFMDd2NlFoUHNnVmwyZDY0dlFFc0NyVUROSFNzRDFC?=
 =?utf-8?B?aCs5bG9QaXNtVXpUeWhMN1F1d0dhdGxROElBZTdCdnpBVWpRUHRoeHhrRXpz?=
 =?utf-8?B?Q09jN3FYT0tNczZJMEtrUUY3Z1h6VW5EYk1kdWZZQjA3SDFIby91bFNVTkV1?=
 =?utf-8?B?ZEZzQkk1bDBER2pmV0hXMmFYck9TT0JQNFppdmtsTmtQUDlNU1hzeGxCMG1K?=
 =?utf-8?B?SzIvUldOWlN5dG9CK2V0RVpDeGw3NXozRUhvKzZxa3ZGUWt4cHh5NDI4WTFs?=
 =?utf-8?B?ajVOQ3p3YTgya2JuRXNuVVBUQlcrUkd0Y2NiNHNBMU5pbjhFZG4xWEEvNWpR?=
 =?utf-8?B?ZDRHMEdvdDV4TGNYTE1KaG9VN0NDenB3cUhqYjZqZ3hoZjdPK1ZxZEFpZ1gz?=
 =?utf-8?B?QWl6RWFoZUtRUjliL2ZsdkNZalBrNGUwSmhpRkhXalh5SmM3b1dKYndONnRj?=
 =?utf-8?B?endQOElWN2ZuU2hPQWxEUmxDY3VqZE13T0tkSmtRVkJoNWhoN3E2NkJSS3pO?=
 =?utf-8?B?VkM5ei93VGZHQ1l5andsUXNHQ05Bd1NlZWhNcFhrSzdaY2pDMjV1NTYrQUU0?=
 =?utf-8?B?eEhOZGdodnpERHY3UnV5K0VRVS9Xbnl5SmhiR1h3c21McHZZd3JXbFV2dXA0?=
 =?utf-8?B?TlBEL1VWUHlxcDVMYlNJcmU4bHpma1NPemh4S1dUMFVUSzN4QkcvaUtjYU4x?=
 =?utf-8?B?bTJ3V1RqdWdBTUhkUUJYa2Y4U2JveUdrNWdMSkpwd2RaNVhOdUsyRWJiL2V2?=
 =?utf-8?B?WUw1a1lFRWJQU0VYdFNsUWF3bWNwVm1OV3lpU2ZiWEo4VStoOU82d29HUEpQ?=
 =?utf-8?B?RGI5ZEVreWpSc1VlVWc2RnA4M0VlMHpYZE1qb2s3RHlZbjhyWDkxMWxLSmll?=
 =?utf-8?B?Y1FUUVd2QlVhVS91QmkxQ3NiNkJ0WHRkNXlxQi9vSTIyYWd3b2NsRUM3KzB0?=
 =?utf-8?B?aDlhYVI0RE1PcUNYS0puME1DSk81dGNUUC9Ed0txK0h0MDNISDdRUG1idUtR?=
 =?utf-8?B?ckxNSFpZZ29qN0NTeFo5S0c5UUZWNFU1SVlJOXRlSUh4ZjhjN2s4aW5tQnlB?=
 =?utf-8?B?OTlCbE9LRjV4Q3RkanF3MkZNR0VBKzNHWEN6dmRhSXVnbUpVVEo1ZVhZZU9C?=
 =?utf-8?B?bVo4Lzg2ODRPbmJzd3QxNEVrTDdTR3FyMEJOZU55MWd5QlU1V3Mva1dEK2xl?=
 =?utf-8?B?VnpLM2JodGxHNHRPNDdXSEt1NHFjKytLKzdTRnBhOUJPc21lbWRZT3lxcnR4?=
 =?utf-8?B?cHV1WkE5cWJBS3JkQVZVS0xpRzZvOERkWGcyNEUyQW1HRHA1eHpuQk9zRytG?=
 =?utf-8?B?R3RuUGV0ZndxZG00Mk84Uk1qc2pnUTlmcjBaQ0JaV0FGTm15TnZtQ0tpQU0y?=
 =?utf-8?B?NGVpd2x4MVlXNjR3TmVuZ2NsdFl3aEk1NHJlTE9YVEpidmJQY0Fqc2MyK1Bn?=
 =?utf-8?B?RUFocWhrdHM5WEo0MWloQTM1NWlSNEVCUm5XSDBnNHdmK3IzdWVueGQyd1U0?=
 =?utf-8?B?OWRaVTVIVC9LOFI4S1J2WVVCQlR3dDFHamZXamRzOFNNd0NhWW5sQk9lb1g3?=
 =?utf-8?B?R1hkNitPbG94Mk1VQ1pOaE9ZRHlqUys2T0p0aVZEdkJuRldyL3lRWFlDYnls?=
 =?utf-8?B?M1RnQ0hlWGMrVnBBak1xQlZSbGhXZGFTYkE2bUNVR3VQcEZYWkdPK1FDUjhH?=
 =?utf-8?B?ODNpYUZ0Sm1PODZxTW5pR1E2TEpxNkk5Y0RJcWVpMStYcURyZzZ1ZUdIbFlG?=
 =?utf-8?Q?pYko8APM7NfFxzSPV+CyUyLBdvWxrN+7lEPTx/T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHQ2aGRMc21nUFBGUzZXRVdsZmxkTDdCVXoyRi9BcURmeUZxTmQrem41Y0lV?=
 =?utf-8?B?Ly9oWkxlbzJvMGZ3YXRNVWlaZmZ3WTQrL0N0bW16M0tvakZkNEc0KzRxL3pn?=
 =?utf-8?B?TzlYL0hyYWhwWTl2ZEVlTXZpTXFRSkliSDBGczlhbjNpT2F5cmxiSnZKOVBH?=
 =?utf-8?B?b0tlNmprNXFyK1N4RkFmQ3VkMjZWRDlrbXpTc2hncWY1ZE45V2U3dSsvWTlD?=
 =?utf-8?B?S3c3WlBMTHJvZEd0SGRtZHEyM1RRRzRnQUpRQkRvVlN0TDNpVlAvQWs4NUlw?=
 =?utf-8?B?Wkpyakp1Vk85eGdNWWxnYTkwdE1ueXZVdEVDYkpPaG1yY0xpcUpxcGE1R0Nm?=
 =?utf-8?B?Y1kwZXRDNHhkbmJmbHpEMVpwMXFoQjNsSktsajR3SG5JNzF1RW1UNHZqV2VF?=
 =?utf-8?B?WUk1YUJ5KytGVHdOdGIxN3NiQVZMTDEveG9RL1VaZmhqS2VVcEZxKzhVSEVw?=
 =?utf-8?B?ZXBGS0htQTI0Y3JhNzJ0ZjNwUEpNakh3SEwzcndPVW8yZnFwamxJWlhXUjdj?=
 =?utf-8?B?Kyt1ejhvbFFKSE4veFJJS01SUVdMQlZ3ME9VTGc2RTN1U2xkRlk0YUV2aUQz?=
 =?utf-8?B?TjFXRXZNZlM4ZGw3T09MeHJZUWY2TSt3ajI2QVZoMUp3bHJhQW1rSUo1OU5u?=
 =?utf-8?B?d2o3N1RWQ2VjeVAvT2RZRmVoODRSVkNRelFmYSszM1l4eUVYNjEwVnpXekZM?=
 =?utf-8?B?VUhWalNEWGNuV0JDRzJoSWNyMDhHQnU2TWViM29HWWlMa3JTbGF4aFkvcUtD?=
 =?utf-8?B?QmVDZW1tQjhKZ3hwbG5BSEVsMnU0ZmFaWWJQTkFNTStjVUZxL1F2M1F1Zm1k?=
 =?utf-8?B?R2pGVjk0REl6VTgwSDFpWUZsb3RxUUZZUFFyWHNnK3VRWEpQcmR6MGJlc01s?=
 =?utf-8?B?L3ZIY0JEOUVNY1d3NjJKQWZCbDlYWk5oYUE4Sko5RnYwbm9VNUxVdXVLQmtt?=
 =?utf-8?B?Z1ZNbzJTOFdkTExuVkJ0WU9jV1dPSWhyS2hzbHpvdVdmUGxiTjRqbGVuVmNo?=
 =?utf-8?B?SlpWTk4zUCtJQktiNWdrSGdmN0h3V0YvUU54OGk0dytKUVFPZ0poVDVicURO?=
 =?utf-8?B?V2V1VDAvNnZCRlBvS2kzb2grZFFzNnl1QTdneDdNQmxEMG40SDhIaXllRC9t?=
 =?utf-8?B?K3hNTDUrb3dMKzBsU09UV2NFaXFvZlNzTEFCcFJ3em9Mb04vN2dJSExleWlE?=
 =?utf-8?B?SmhqdVBnRXZEVXRuemZ5dTEza3BnMXViUGc3VEZRbitFRkhWTUNFQTZueTY1?=
 =?utf-8?B?OUg2TS8zSXJEeXBJdklHSHhXdUxMbkNDeDlUTGpYeWJpTkpQd2pzRTBYQnBm?=
 =?utf-8?B?WU5adUNsOTlNaFFCWUtYbExUZzNyN21HZzh1MVZPZFZkbnNjL01SbDVsSjdn?=
 =?utf-8?B?ZkdpdytVRTF1UVE3M296UElnRk1lNmd1RlAwaDJydnM3dlBHWG9ucytkYm9S?=
 =?utf-8?B?WDN2R21sZ2RhTEVoZG1maW1pWVVmbUZNWWJhWjR4dlU2b242elcwa1dBZlNR?=
 =?utf-8?B?THJNZXVkWVArelVTMGN5NklEU21KZHo3aTgrYnRUUUJuaG5rajFLaHFuUzZs?=
 =?utf-8?B?WjBrUW5wU09qUGU4bzBBMUpaVThsTVE0SGJMS21RTWtPbU5LTzNjMkFWUllC?=
 =?utf-8?B?dWJsdW05Z0xQek8yYzJHYmcvMFdSS1Mxc2MzYTl2SnZUMktIRGtIS0JOS3Vq?=
 =?utf-8?B?YzYza2VxcE00YzRJNzhzaDFpbmJXanNPa3AzQ2dhNU1NYzhLNnI1anFBQXNF?=
 =?utf-8?B?dmUza2s2b1BjWWx5VTVwUy9zMzh1RnNUam85aGEyTDNsQzZSRU5jb0JQV1lK?=
 =?utf-8?B?V0h3RmZiOXhFVFR6dXdYYTYvVVVhSlNYQzFCT0VBYVNlcTZLU3ljNmt0aUg1?=
 =?utf-8?B?VHFqM3J1Q0NoZzNGb1EwTGJrMk91S1cvdElNRnlwUmpyMytZcllHWmQxUU1D?=
 =?utf-8?B?MytLV1VFeHlGckttNDE1MDVGeHMzYU12VzAwcnhGRmwvQXdzN0lTa3ByRG5i?=
 =?utf-8?B?Z0VIdW1RSDdKMkNYbGV3MjlJOGJiSys3ejlkNjVERS91dmRTUDF1VUdKdXJH?=
 =?utf-8?B?ZERQSkdyWnY4RTBIYXZsR3Qxd0loRnFlVHQ2eTA1VXBuOU9mTHR3bVkycDAr?=
 =?utf-8?Q?DhkSJUzhThcn64GVuiDhgIfBj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dede960-bb03-449f-5829-08dc6afedad7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 23:23:20.7146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAkZibxeRARI9SKYBUtTkJkZ4Vz50vdGjDCGarSGv2QICj7GHK+WsAsxiCm6u1TrOgn9QqbVqPaQAU9afweQWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4717
X-OriginatorOrg: intel.com



On 1/05/2024 7:51 am, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
> 
> For the global reclaimer to determine if any page available for
> reclamation at the global level, it currently only checks for emptiness
> of the global LRU. That will be inadequate when pages are tracked in
> multiple LRUs, one per cgroup. For this purpose, create a new helper,
> sgx_can_reclaim_global(), to abstract this check. Currently it only
> checks the global LRU, later will check emptiness of LRUs of all cgroups
> when per-cgroup tracking is turned on.
> 
> Replace all the checks for emptiness of the global LRU,
> list_empty(&sgx_global_lru.reclaimable), with calls to
> sgx_can_reclaim_global().
> 
> Rename sgx_should_reclaim() to sgx_should_reclaim_global() as it is used
> to check if a global reclamation should be performed.
> 
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---

Free free to add:

Reviewed-by: Kai Huang <kai.huang@intel.com>

One thing below:

[...]

> -static bool sgx_should_reclaim(unsigned long watermark)
> +static bool sgx_should_reclaim_global(unsigned long watermark)
>   {
>   	return atomic_long_read(&sgx_nr_free_pages) < watermark &&
> -	       !list_empty(&sgx_global_lru.reclaimable);
> +		sgx_can_reclaim_global();
>   }
>   
>   static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
> @@ -405,7 +413,7 @@ static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
>    */
>   void sgx_reclaim_direct(void)
>   {
> -	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
> +	if (sgx_should_reclaim_global(SGX_NR_LOW_PAGES))
>   		sgx_reclaim_pages_global(current->mm);
>   }
>   

Hmm.. Sorry for not pointing out in the previous version.

Perhaps it makes more sense to do the rename in the patch ...

   x86/sgx: Add basic EPC reclamation flow for cgroup

... where we have actually introduced the concept of per-cgroup reclaim, 
and we literally have below change in that patch:

  void sgx_reclaim_direct(void)
  {
  	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
-		sgx_reclaim_pages();
+		sgx_reclaim_pages_global();
  }

So in that patch, the sgx_should_reclaim() literally just means we 
should do gloabl reclaim, but not the per-cgruop reclaim.  Thus, perhaps 
we just do the renaming here together with the new 
sgx_reclaim_pages_global().

If there's a new version needed, please move the renaming to that patch?

