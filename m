Return-Path: <cgroups+bounces-2815-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C60158BD868
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 02:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A51282C25
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 00:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3192C37C;
	Tue,  7 May 2024 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jdcam4OI"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4359317C;
	Tue,  7 May 2024 00:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715040660; cv=fail; b=F/T4bFBZzkBWBbuLS72mSEkNpsgcJMLfRZZZgV2049ZRN5sZ7PdFnDaNrncqef/D4Qu+FeO5cHwen3t8wosBz26RNIQMDkIlxYILw8WHN5q8d/tg/UEZEIfaAfIjABNrlLmePFTWwLeqF0v6mehFs0rGMrIAuXaFVoaLk36ti8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715040660; c=relaxed/simple;
	bh=EohOHF5qvNs5/zZ5pZuz5yJvGpsfEo/PMi14lVVt1vM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZK9RMwestOZ1NccDUTwLOpciwgyzSkXfmd5tAFiMUnJ7RXC+q4crmwGxnZfSNCj9e4+WxNv8qc+9a0Ic9By1Vyf9j28ZLO8uNp0rFvtNENpEYdwXpopQ9qh5QgIKWCco44/FrwdAt4+sOnoTaBNLPCXh1d8Apyfu40Lmll0TbfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jdcam4OI; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715040659; x=1746576659;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EohOHF5qvNs5/zZ5pZuz5yJvGpsfEo/PMi14lVVt1vM=;
  b=Jdcam4OI1XUQuUXsNl01pAzoKwt48QkR0aHi3U1xww6+iXWgfCvShAvE
   +OpTCCTnrHCGQiLMKbYOIG9G9W76xXlSY+24nOG+RAfXQ9FdNwUW76KYk
   hgJC0ZxX14LmY2GYQCV5Zda9do8KPUsTmktG+c7AfPzdC7vhKFCq0cDp6
   RifVawFLbdyHlQO89PxkXPKXiyEWiM86z9TEdj3Eu78EMGNzREMqnOTQ+
   PUXTrZEF+hy59Af5CkkcQJD/z6gh6TKGv3eOChv+E/FQIsfhsm0zoJnNl
   sdBJBU+qbdVJr9qswwbMkok1Sb6VWlBYox+5rvQVKtLUyu8DLha3PwjkN
   w==;
X-CSE-ConnectionGUID: rcVGa6iZT3CjRPAm0bMONQ==
X-CSE-MsgGUID: eqkGp3ECR6m/hHLK7xbyCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="14594178"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="14594178"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 17:10:58 -0700
X-CSE-ConnectionGUID: 4BPhHzL6RTyOqm+HrxHBrA==
X-CSE-MsgGUID: /GgWiVzwQ+i+DRueNJW11g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="51524032"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 May 2024 17:10:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 17:10:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 17:10:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 17:10:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgHrVfNa3yxr/jsBFPo8jjYiW8RVRmpxtMgamn3RZOWnKGG/b8hOCudj5z9zYIXBAHt3WNsD/Imyxkbap7D9bBMdPPRhmWs8K7NtlTc7ANMw/YemL4SmJ9DkHpSNxMviDzBwKivSnc/PgbAlnpCARYQXHHQ64IbbbzCVKFK3pXr+Y/gHNjwIFpsWRcL+nWw37pqlVdy82dnHuVGxTGlo1QflagooB+wwGEZdblc+O+MHpr7r6LgIX8kLBXFHIipxXZfytemaeCdKSTYb9zZzgxgB7H69qzbGAk7TL3pMxhIsLz7twJY3AOwh81GMhEF1dNSjmyO+x/RyHImMC9cQwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pwKV7LPfMCTy16AvKoJfROQ6eEqdTyleijfReo43c8=;
 b=FVw71MN/Mz5vAsQJy7DxYwRF2YyNND3U6V3nPDM+ZFMxX8trcqWSRy55+VRHuXQtFO96W16MH966lwi5Jh5Fp+AwTSC08+qOEZy/hzA4ExH/gTqnyfxAHljdiYpnlfi33kyVpPijJhyFNQPuBxRC+kY9oF+sSlEt9GXPq+DH01kFPIJ+bjgPJ62SPGrmQG8EGW6ahMg0bQeZI9gWvl3TfOq+W0CrAa5DjlcVQI5C6mgWHVQN+ZeDD3N/o7Q6X84qTxV5ZSuV1yqc1+hrjT7q2AZgSiBt5eYxWMQnKLY+AJhrUfveCmWpSmNA5K0mXOJzet03U33EUJ5UmM2fTSeB7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB5957.namprd11.prod.outlook.com (2603:10b6:510:1e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Tue, 7 May
 2024 00:10:54 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 00:10:54 +0000
Message-ID: <966e4afe-b177-4527-80c9-1146d2503c93@intel.com>
Date: Tue, 7 May 2024 12:10:42 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 12/14] x86/sgx: Turn on per-cgroup EPC reclamation
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
 <20240430195108.5676-13-haitao.huang@linux.intel.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <20240430195108.5676-13-haitao.huang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0194.namprd03.prod.outlook.com
 (2603:10b6:303:b8::19) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|PH7PR11MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: c778b8e3-36d6-4968-8c4a-08dc6e2a296d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFpENE9Ld3d2WW1NWEgvU3hkcnlRU0pIZUU4U2tqUFlGWGNqZjRld09UL2dS?=
 =?utf-8?B?TzNnTklFUUMvbUtrRVRjSmZKTzFnNG9USUs4NWVOV0MrU2dlM1RPRW9saEZq?=
 =?utf-8?B?UUFwNS9xbUtOQ0RqZkQvTU5MTFdlV2F6WEVjMWw4bXVJc05jb3dMeFp5M1hR?=
 =?utf-8?B?OW40eE1HOGZxQ2dtZy95aGhWMXZZY2FPQWRVMURHQmI3LzhWMDNXbHBFcjky?=
 =?utf-8?B?c3N0aFl1elQySzBPdnBLNjZSQkpBYU1LSGI0VzJvT2RFNGlJcGxhOGtRN2Nl?=
 =?utf-8?B?Sk15RzdtU2ZUOE1wVkw1SUsxMUhmTVBkVCt3Z0wxaTV2L2hlSHFKNC9qNWRa?=
 =?utf-8?B?azA1aldseW8zc1hPSm5PbDhycFhyUGI4U2xyeThqK2toNlAyeUx3WFpNa3Bm?=
 =?utf-8?B?Zms5Q1pSZHNFUkVETnRra3lZUjJpZ3ZabGgwNXJYMzV0ZFpoWWdLQU84TCs4?=
 =?utf-8?B?STkzY09nODhaMUZWdkhKR0RrSndlZTc4MldtMzl4UjJOSVdPVW9mVHErcDIz?=
 =?utf-8?B?TmcwTVBxTFhUaUFlUEtEd1RHcGxxNU83bHQ1NEpSckgrUXNkN3kwYW5LVE95?=
 =?utf-8?B?Sk5hZzBaU2wyL1FZZU5hTlZQbTNFRHM4STY4OEtLSnpBS3loLzFwOEpMYURi?=
 =?utf-8?B?SlV6S3Vkc2hpVkM2c1ZnajRXam1RUGYzMXN6aTgrWExSZ2VPUXN4TVc5ajZx?=
 =?utf-8?B?UWsvTlNoaFBwekk4SzVPMlU0Wm5oejM2YW81UnBCWEp6bkUyZksxWndxVmdT?=
 =?utf-8?B?anNBQjVFWUsvVjdTR3RZZERkd2VWRzVaaGlYTzlpVUlLV2dVdFBGektpeHhX?=
 =?utf-8?B?REc3MTNNaE94eEtSTklMekVHdU94RHhNdEJxQk5nMkhFeXorVzg1ZHVzTDc2?=
 =?utf-8?B?d3hHcFVZNlZCd1VNNUVMQWxwS1RvcElSRDA0TmFrTy9sNWxyQzM5ZktiRytO?=
 =?utf-8?B?TFZBWFZ6WkNrVWxsc0dmTHgzNDV5d01waU0yYjhzWkFmc09rc3dEdnRza0JW?=
 =?utf-8?B?cWhMUU0rS1RiYmxxdzJ0RUg4dURhdm1INk1MVmJJeVhnNWViMzZqVTFtaXpO?=
 =?utf-8?B?MnROSlQ2NXhnZ1pmSXlPSVhtR0M1Zzk4cE14TzR5M3JINm94emw0Zkxja284?=
 =?utf-8?B?M2oyajNVR0Fyc3M0R0NldHlOazZGbmFacHhCRmdMNHR1M0REWkpxWDZ4NTdl?=
 =?utf-8?B?V3lWUmlOM1pPNm5yVDJpQ1VrMmNKZnViek0rRUdWUzk2bTJkMXJMTWUyYk9t?=
 =?utf-8?B?a3dwbDZGZWRma0NWaHhSdzh0ZWpRdG04N3MzZFNUbnRoUnVBbEF5a1FPNVps?=
 =?utf-8?B?b2xHSXY1OUY4M09iUEhlVTk0dDVCb0RjSWswU1haVmd3R29SdzZ6d245ZGM4?=
 =?utf-8?B?bGVtblVqTDErMTNRVkNSSjdPK2tHcHBLbUFBR2VzN3Q5QzJxc1BTMlVvNUZ1?=
 =?utf-8?B?M3pCckhIak9zdDUvOW9kcnd5TW1JakVhUDRHbEg3azV3dHBNb1RzR0RnUDZI?=
 =?utf-8?B?UVhBWmE1SUR5Rzd3NXFDUktONUF0WnlWcmRoVzZDRXVGaHI4NTl4TUpXc2x4?=
 =?utf-8?B?TGJtZ1g5dHhpU1hZdHVoalNtbjhlZFpUY1dVNDFTZVZka0NJbVdwMVFyc2NF?=
 =?utf-8?B?OTgyNWF6c2czTDhrVlhRN2t3N0hDNjFZWXpYTCtaUEdBZGhkT2JxMXkwZ21x?=
 =?utf-8?B?SVp1NGo0UU0wQ2lIUnZwaUlRNlB4dDM2NC90OTU1bUx1MWRXTy9zaVJBc1hs?=
 =?utf-8?Q?7u1YIp/llsn0WFxgfEcN/05pKIqSMLwxVGHNu10?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emZxaWlvZVhreG5rOVB3bU16a213eU5hbU1tUGxtRUZqOFNCWmNNcFczSnI2?=
 =?utf-8?B?WFlCajc3TzFieDZPR0Y5a05iWkgxcDAzeU9BWU5aR2tzVjVJNXJNMTFXa0hB?=
 =?utf-8?B?QkUwcElDYzV4elI1TGJObWlYM1hNaDRacTZzRThWSjVHVWJ1VEU1T2JZWXJv?=
 =?utf-8?B?ZzRBQVk5WEVuOE4wSDhEQjY5M3NtL2QzYThzZlVKUnlaUEx4MmVIanRUQlU3?=
 =?utf-8?B?aTBBTmprOUR1UFBPWXo2OUZKcUphZ21ZSmlMallITzdPa3RJdmhvNzcxOEEy?=
 =?utf-8?B?K0pYcStlelV2bDliZUpYK2FBWnFEWEVMbW9MQW5teWoxTEptMHFDeEI0NnFi?=
 =?utf-8?B?SUIwaGlVN0U2Ynkva2w5T3VsTlplcFJUTkhlSTlqK2pKR1MwZzExNEdXS1Jt?=
 =?utf-8?B?NGloOWhFaXY0VU53RjdPV1UrMEdoZTBRZnU5R3RTMlZRTE1ncFlMNUlTbmxk?=
 =?utf-8?B?TkdtU0FOYnBHdm53a09WMHV5dStXYlJtNjlMS2NrOVBpeFg4ZDdlcUUvaitN?=
 =?utf-8?B?bUZyU3Y5ZFNleEY1cXllcTAyOUdFV3I1V25VTzJXS3NIU1p3QkhRQkVyZEZQ?=
 =?utf-8?B?Rit1L0RsQjdRaHhIYU9XNkdqSUR2MEM1TGNUV2ZDTmp4Q3JYN202dEVqNEll?=
 =?utf-8?B?aHBFN1l0eGh4TTZNcXRxMUlHZ3VwdFB4MTBabjRLb0RESkx6N3pJU2VYOG9F?=
 =?utf-8?B?cDlyUzdWYkVnZ3BhM3dOaDZ6dlFqNHNaTWVpTmVuQjlBSGg5NW9VZVpzK2la?=
 =?utf-8?B?UzFFV0d0a1FQUUlPYkhQdXc3MU1lTEpGUVpSY3JoaDRZQkMyajhZYmpibjEv?=
 =?utf-8?B?VTh5U2c1WG1sZWZVbFN2am1Na2drakRkTSs0RVVsUXh6b3JnL1kxKzFqanJt?=
 =?utf-8?B?cTQ1cGVMYm05cXlVU3NnbjVFeXcyeGNwV0JIZnlPS1dDYkRvRVdDOGsvYWw3?=
 =?utf-8?B?dCtLakVrVkF6SkcvSG1oZDVNMmxCd0pKSUVrY2U2TWJ0OWs5M0Y4NDVRM2Iy?=
 =?utf-8?B?cFQ3aE5EQy9UV1loU1ZjSVdENDZ2Y0lqeVlZTW11TmZZaUFnZnJkcW43UjJq?=
 =?utf-8?B?czBsQ09QcHpIYTZwT2piOTNnMTJrclNwWHhFUFUvZ3BzWElrR0xUVkxaK2NK?=
 =?utf-8?B?SUtldGVjVGVHcmJKdURwUFhibUk3ZEhtaWZBTGEyaUVqK29PWWl3L1g4NGpO?=
 =?utf-8?B?aGsrbnJIOWZXYlJxS3dBVmhBb3pKWk82OWlVWFpiWFhyQ1laaTRnSzhGeUd1?=
 =?utf-8?B?TjcxYTlmTlZoNEVhWUxrZ3lPek8xNU5uNHptWitmNUhXTVY0WTR4aGNVTmhH?=
 =?utf-8?B?YlZWYnIzTDJzZGp4eHlJWUFGYWlqSkxIcmVyaElpaDJSODZjWmtCa2JGRTBj?=
 =?utf-8?B?SDdUSWxpRzZZOUlick4vaUdmZThCVWlzcHlOeUhKblF1K1dGU3FuV2xUZHdv?=
 =?utf-8?B?VXN6M1dtVUhERDNXSWZTUTQyUVpnNlRRYVl5RWlRTW1TUmQ3NnhwdGd0RWVC?=
 =?utf-8?B?QklQMURzNTlULzRPOEVDSHpOMzZCWEhtQ2NBR2luMUMwWHlCeWc5aUdOd3Jz?=
 =?utf-8?B?cXZmSTlEdmJhOGdLeU1sc0tab2hraUNJejFtdnhKRlVNdGQ2Z1MzTHF0UFc4?=
 =?utf-8?B?eUJxMEdEMlV1MC9zV3h6RU9VZXZmMkdkcUh1VEdjMDRjWDZtUjNxemhqbXVx?=
 =?utf-8?B?WkZlWURKL0xHTVlTelpuQjJiWkIyRnpEUWZ2L0JvMGgwaFBXejNta1BMMXRm?=
 =?utf-8?B?RzJWWFNvdWZlSXpJOFZUdkhKZ3R6Y2RIWURETHlKUVdYNXB1d1NMZnJPeGxt?=
 =?utf-8?B?RUNaT1cvMXU1ekVRak5jQlQvRW11emJ1ZGdmcngyMXpNWUxDNndsdEp5YitS?=
 =?utf-8?B?bVV3OXpaQVU3akJMZGtmTFBHemVsWWNyZlFXVUhleDcxYm1JcTNsd0RnOHFZ?=
 =?utf-8?B?Tkx4ZjdFcWlxRlZFZUpPdDltUFRsRHVkM2grMEhYbC9tYlRtNTNBNDFWN09V?=
 =?utf-8?B?eGVHaW04Z3phSWEvQ2pJaWl0dHU1SktRMDdsbkJLbTUwMTVrUVduR09mcjhn?=
 =?utf-8?B?dlVyMFM3SnRab2h1QmoyWmVaWUxTaytoVm5kam9kcFJ1MmhHZWRXWjhYRzg2?=
 =?utf-8?Q?zWk6mYFqEHSHnIP20P8DxUp3e?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c778b8e3-36d6-4968-8c4a-08dc6e2a296d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 00:10:54.4645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALFTYmwvWeCUDgXuff7j8UKuYWsIExsYqtygyW1Ws7yMEihqVi8XB3AU9fzZfpXZrDM8d7x+96fEkrcZTLDEOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5957
X-OriginatorOrg: intel.com



On 1/05/2024 7:51 am, Haitao Huang wrote:
>   
>   static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
>   {
> -	sgx_reclaim_pages(&sgx_global_lru, charge_mm);
> +	if (IS_ENABLED(CONFIG_CGROUP_MISC))
> +		sgx_cgroup_reclaim_pages(misc_cg_root(), charge_mm);
> +	else
> +		sgx_reclaim_pages(&sgx_global_lru, charge_mm);
>   }
>   

I think we have a problem here when we do global reclaim starting from 
the ROOT cgroup:

This function will mostly just only try to reclaim from the ROOT cgroup, 
but won't reclaim from the descendants.

The reason is the sgx_cgroup_reclaim_pages() will simply return after 
"scanning" SGX_NR_TO_SCAN (16) pages w/o going to the descendants, and 
the "scanning" here simply means "removing the EPC page from the 
cgroup's LRU list".

So as long as the ROOT cgroup LRU contains more than SGX_NR_TO_SCAN (16) 
pages, effectively sgx_cgroup_reclaim_pages() will just scan and return 
w/o going into the descendants.  Having 16 EPC pages should be a "almost 
always true" case I suppose.

When the sgx_reclaim_pages_global() is called again, we will start from 
the ROOT again.

That means the this doesn't truly reclaim "from global" at all.

IMHO the behaviour of sgx_cgroup_reclaim_pages() is OK for per-cgroup 
reclaim because I think in this case our intention is we should try best 
to reclaim from the cgroup, i.e., whether we can reclaim from 
descendants doesn't matter.

But for global reclaim this doesn't work.

Am I missing anything?

