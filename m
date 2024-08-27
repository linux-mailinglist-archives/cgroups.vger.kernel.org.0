Return-Path: <cgroups+bounces-4518-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AA2961A3B
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 01:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747581C22DD3
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 23:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE73A1D417D;
	Tue, 27 Aug 2024 23:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aB425/lo"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A130684A2F;
	Tue, 27 Aug 2024 23:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800285; cv=fail; b=JLXSjMdKVr8MJHJjWH5hNYRpTHMntLu9+0B0EorN43skLkQfJaLrtLblPXwSk10W6BqFIH4NKL+fTKrCQU2OHoZFGA317fc5gelqQd11f0Jzojn0fFYmlw545wgDMICxv36KADRpWtT9mDpSbmW2u4kZDJoqYXAIUPEukgfjFaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800285; c=relaxed/simple;
	bh=dlokoxq5d1Fz56W0DM9r4pu9bqIvHfHny66nC2A8kYo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p9c0hPnqNkhD7+WIXVjuYDhPeno/qp7QkQUkr/E8KQ0j7YWyo5keK7qZQ8o69Zkh4qyqGTsgZpTyBFrzdEKvHW7ZV95eJzETmogujAWCrMxJ5j+Jj3rIkUKrv5rNw55E9MFPGBvS0ZLyS0YMhuIiXKalKoUQYQbeTRgiWKxyn4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aB425/lo; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724800283; x=1756336283;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dlokoxq5d1Fz56W0DM9r4pu9bqIvHfHny66nC2A8kYo=;
  b=aB425/lonq4TjGRCTwbAmcPZCs8NsiFZz7lVUOGP/RYrFRuvlDh9Q15p
   hzq63/Gm/pcfJfDtc8sposF9aphmyrx/yWvLF1B7zNhKAV2NbxrNgNvjL
   pokym02pythAiDJU6lIHpczkWqcEcjmbRgRavS5yKM9TlVUu/ogoj8Q6r
   dElZNt2qiSH4+ZdO7+GBqD9QnM5gqMYKUVOF3nFUJdwKq7DK84u4pMJZ8
   2Ki63joiO3av2TxkAPG5JDTfBN3siG6gofVEfsIeAwqNBMN8jjcNNHfMN
   O2aMUVWL3QHdIpYmBV7KtwJZgkI4SKRfYjhfzNmrRBJ3vLxxjF9AAgbFI
   Q==;
X-CSE-ConnectionGUID: 5QFce5ZARDab1x804Kzl8w==
X-CSE-MsgGUID: mUcs4ck/TYmFgwXxKSuAqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="26207731"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="26207731"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 16:11:23 -0700
X-CSE-ConnectionGUID: lnCN8MjFStCWgxQ2soyt1w==
X-CSE-MsgGUID: DIAIr8C5S52Qyo5o4P8Jdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="67390449"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 16:11:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 16:11:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 16:11:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 16:11:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUjG/IAJp3ZWVS0yNJzVhc3b6wR2ufH1h3v7AjWe8/zzR80E7CFaygRERLMRvpx6PqV1vmkbiN03N1/3uE8Bz+eKVPohAm0yvtwm2iRxza4AeZ+I1b7Kw7HOAldj1xQWJFa/RZbI0/THHzPK561dmNqMtM6FfzarqYNLElp1Vva9J31SHMFjfsoXMNQNRVFghf8D1i3b8Pj7ToQoGD/nV7iGgZPbtY1/CdxAQKH61pg7XhSrZRjx4paXEeZs1WuXF2nd1KEnVSbg4vkxAopz14pmvq1hbbqVbQyP1rlfZFEd1ihhq3dxoxGxX5DOf1T15rh3UgmzISgSWG882DCoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8CbWj/KummsK+KLD/GOLCH0CwUDe1cS1p3Lm43NxBg=;
 b=NvP6T+GUC6uvCdG5gvpnqHni8GHYp+g0E75pF17vi46Pedg0q1k0TKM15r28rc8NNuwftqRJ3oCoFHZOrefQAKdb6z83B99wscbQj6/KfMmc+9uUxdR3rcjQVyhQ3U3VfHyfTcc+CvdHfC1Rlu6fx1ou6fXRSBGdDRdsRtCdhtWC7DHTVyQiy5mmITeNvBLrPQktv00anEW9TRAn6iAtfixA8a6f6vRb73Jb8KSB34e2o0T2ntnL1EzmU5YfKTVGudAOvsFH2Wcdx/PoFrIVQalhQtIUgHRv2urrMMRR+vtjSlkGNopnz9NeUp0KBd7GUBFKZtWP1mceWReSox95xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 23:11:17 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 23:11:17 +0000
Message-ID: <f25c789f-e7af-4a6e-8c49-f5e9bbc386d0@intel.com>
Date: Wed, 28 Aug 2024 11:11:05 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 05/16] x86/sgx: Implement basic EPC misc cgroup
 functionality
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
 <20240821015404.6038-6-haitao.huang@linux.intel.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <20240821015404.6038-6-haitao.huang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:a03:505::21) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|SJ2PR11MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c7dd3f-ee31-43c7-0f0f-08dcc6ed8dd9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGZxdlo5ZUVvWko2TnhUdXVmbmlla1Btb1oxMFJJWjkrQStORHZ3TXRBMjUz?=
 =?utf-8?B?bXIySzRoci9qWG01T1dDYmJmMnBoV3JPYjMyTGRFTHEycTh2aGRwVURTcHM1?=
 =?utf-8?B?ekxwaTY0U2lBMVUvL3pRSHY2ejhOU21yOVg4KzIwVUoxK3pacnpacHBPTUNS?=
 =?utf-8?B?VkFkU25mWVFoUmlFbW1DY0E4MDZNOStYVHl4SGE2Y0JzZjB2UlhReTdhV0R3?=
 =?utf-8?B?R2U5eWx5c0o4VnQvOWp5bCtrNXhpc2FyNExnNGJicEwyeHhKYXg0aDRkZVJJ?=
 =?utf-8?B?VFFoeXQxeTM0NWtESGxZam1TeVRlNUNNMVBEV0VjQzE3VTN6QzZSczYwRXRr?=
 =?utf-8?B?Q0MyTlNmdWs1a1VyOXprRFVRMFRLcThDUnorMXlYZWNWWXEwVVlnYW0zSC9S?=
 =?utf-8?B?RHVCb0llTE5aU3BQcG1zWFRnaFhKQWRQWUFHZEFnM1NvTXdTdzh4MkRiMGpk?=
 =?utf-8?B?eTFENnFXMVZnOGxhUzZOTFFrUzh4NlhUVzBiOE4zdXZnblpxUW5aWVVYOXl3?=
 =?utf-8?B?aTVKZ0F4NldZbS9oYTJwNVRwU2cxUUc3cWY3dFZUUU5TQVM4a2ZCOEVndGtN?=
 =?utf-8?B?WGdVclJKNGdLd0lzM1pnZDZSTFI5aEVGRzQ5UDhUWEdNSENWQzlYWnErcXdV?=
 =?utf-8?B?SVhyMHRrd25UUHMvMmt3VlZ3REhuSUFaU2J0ZUJ0eElndkpZTWhCNnF0Rm11?=
 =?utf-8?B?QWZQOGpnQytBNHhGS3BuOXJUYXBtM1c0Wklld1FNbWo1ZkZHTWdFejZ6TTJU?=
 =?utf-8?B?UjVTeGdubU9FazA4enhVTS8zTlFFU0tOVFUvcEE4K1d5dDNYMUtTRHNHVUpm?=
 =?utf-8?B?T1JkZjg4Mm8rcWhXRERTTC9iK2JTNTBoVEZUTUpVMkViOTJCZDdoWVZsL0pS?=
 =?utf-8?B?QlpZb3hqcVVnU0xJdzVIclN2YXFsaU0ydzZEVHZGcFV3MkMvYUlEWVprdlRP?=
 =?utf-8?B?emptajd5K2RwMkZkT1FFWTZud3NjbDg1OVI4QitmNmNtUFZxN04ydENXTXlF?=
 =?utf-8?B?WXdEdWlVYlI3QURpVEV1b2pZTjJoTXZTY09PMnVwN2lCUWVpNUNsd25kcjda?=
 =?utf-8?B?RG0xUTJqdk95bkxZMWRHTit6ME9PWWllL3I2ZWthTnpmS01wQVJnK0JvZC92?=
 =?utf-8?B?UiswR05nTlgyMVdKMktsaFlvK3MvNVhEcGtpRHRmOStLMUxFbUhkdkp0cVFY?=
 =?utf-8?B?b05rdm9mZFNRVlpjRC85VzNiRkZHeHFrcHMyaVN5RkVuWWFkT25zdlkyaGNY?=
 =?utf-8?B?K0xhOU5LRytCNE02dk9xdFZsV05tYkxaeUJua3ZqUkgvajNGUXgxb09vM2Zw?=
 =?utf-8?B?bnd5ZS9PbHpDckNDWnA0NHordVArYVBpSXlZdFh0dHdxNkxCbzFkeXUzTGZP?=
 =?utf-8?B?emx1NWE5TDFrTXdhR3hnTHNGSEU2UHdsdm1FckVtY2ZpQmNHdFhFdnRaREp4?=
 =?utf-8?B?WUQyaTdmQUJqUUwrb0FtREF3Q0EzR1dTZ2c1UTJNOVErZUMra0U4QWhiZXRP?=
 =?utf-8?B?ZWxoZnpxaHdVUHdxd0Z6RFRSa3Jxd2F2RkxZNjR5ZXd2ZWFlQkk0NlJLOGx3?=
 =?utf-8?B?d2R6YUlPRC9MZVFHbURSdVgwbXYyUWJVQk9XWElUOUpnZDlBUVc0ek54TnRv?=
 =?utf-8?B?OEhLRlFkeGlZOVd6K20zSzNiUU1EZ0hTU1JRMHcyWDRBOHZWbnJTT0Uzbm8x?=
 =?utf-8?B?NzArd2w2a1FQbzkrTnhCangzaGpyaTlLSFVGVG9ET1d0UGdtVkZ3dEZNNXJE?=
 =?utf-8?B?MzdWWWt5anZLLzNsc2JOTTNDU3krQm9FU2xGOTY4QW5KVFZRVjRyOHFNVmNk?=
 =?utf-8?B?VFVIdkIzQzJvVVBIWUhoUjJsbHRWaTkrRUVkRGpQNnQ1Ylh4L005MU9wRHg5?=
 =?utf-8?Q?pdyWSH6wbrHVz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmVSTkVKdlVmSzlrMzQ1NmFkclg4Z0xycWNNTTNaYkpGcitTelBSb3ZaVGVG?=
 =?utf-8?B?M25aTk44SEF6OCtCMTNVMXdoMFFYZlJPK1REVGFmUjJSWUJja290SFZIUVBw?=
 =?utf-8?B?MUFwRVFTLy8zZ25mRVhWNVNac1g0a2pab0dGK1MyalRTZG13MFZhWDJYWmtZ?=
 =?utf-8?B?MklsNDUyS0RMSTlzV1ZoQTBHdnRORmorTXg3aklnZzdRNU1xWS8xOWl5RHB1?=
 =?utf-8?B?THRwei82ZGZUWGxNTTJuaDdrZHNaU1pPMjkvbWs0QzVTTGlMc3c0TnR6OXNl?=
 =?utf-8?B?bzBaV3JYbVlyRERFQnduSzNPT2wzVTRRT29GN0hBUUVIQjhEclBGd0R6Yys1?=
 =?utf-8?B?dkFCMkNERGJNMEhMUHdqSCtJSFNTeStyL2FmUFdneHcwYzl2RGNXMHZrU3Jy?=
 =?utf-8?B?ZkpzczNXdi9XQlpBbkJ3Tk1SYzFZdU1MVStOZVFQTHJudUl3U21adGRCUldU?=
 =?utf-8?B?NFF2UE81aGpxZURtNmVsQ3NhY3RpUm5nQ1Zld0xDcWR4TEtkSVBHcGc3eHV2?=
 =?utf-8?B?M3c1bUlPNFhHdDBXWkxpenhaZVk3ZDBqcHFNcWxSODJrSWUwME0wYWRVSGtO?=
 =?utf-8?B?eStQNXJhbUtPYTRsVXp1dXQvSU55Z29rOXFsaXkwb2VtUzlyMVYvczg3ZjdM?=
 =?utf-8?B?cXBpeUZWTjNvTW1PSkI4NDAxSGlURTJ6Q1MwaVJTSDhwRzNTTmI4V29sTUMz?=
 =?utf-8?B?NlJSNW1rYWM0SlhQZlMvM2d4bGF1aUJ3SnpKc2VRQkl1UnZxRzdCRW9UemQ2?=
 =?utf-8?B?YVI1NDFiSk8wZGZvQ1NpNlZuU3VMSnBsK25IL1N0NnZ0NW9STGtTWGlmU1VX?=
 =?utf-8?B?b2dMZjFmb0Z5QTE4UUdDcnh2RTlTdGp0aFBvYlpzTXpWSElJQmp0dGp6QW1F?=
 =?utf-8?B?ZWwydnR0TGhpUTNhUWM1S0xPRGNxejA4WWNkbHlJTC9PeU1mMm9KWHpDMXlU?=
 =?utf-8?B?eWYrbUo3cHlWRitOOExydDUyNjJHK3N3azJaZ29CQlVHWmZxdnNtdTZlYnFy?=
 =?utf-8?B?cmoyYTZMREVqb0VWbTNoQnZJV3h5eXZFMW1rejdNY0kvV3dMMzBoeUNPSEtO?=
 =?utf-8?B?R3dSbHZCbWg0ZzNvSFgySldOdnNsN2JJNlhwc2dYSW4vQjVuT0hDam9wQ0lW?=
 =?utf-8?B?S3RteG1icU1PN281UXFXWXlnRVlYVVhLdXowcTc3TnllMzFGODJ2bTR5d3N1?=
 =?utf-8?B?ei8vYnRtM1BZQlFqTXFWcmpLNDJQUi9nQXlOV2JZa1RNTlQ2KytPZWlveFlr?=
 =?utf-8?B?b0xJMytid0U5K1NDN3FMRjZ1ZVljV0J3UmFiUVJ3dzNTQ1Vublc3UUM2UW5M?=
 =?utf-8?B?YjZBanVFaldEclQ3VklaZVZLM2ovaTd3NlF6NmR1citvNzgyQjBDSkg0SVpU?=
 =?utf-8?B?WjhOd1dHeGlFNTZXbFRSbjliUUVIdmxtbFZFWlNJUWxkUXlZdko2OVhTS0hM?=
 =?utf-8?B?Y0xqZDJ1dHpIdjNVeUVDSFQycmgwOEpBKzJhK1l2ZkVKNkRkNCtNS2VYZ0hq?=
 =?utf-8?B?U1VzQm9sL3J3ZTdQTGhQNG0wREpyM1lqYWkxZzNjc3Z3eVpQTER1L3BFWGZL?=
 =?utf-8?B?YzdUZ2I1b1YyZnZGUGM4L1NLNjBJdVNhRDRUcG92anV0aElVNDU3TkNmdmRD?=
 =?utf-8?B?eGUrNE9xRXBrejJEMGc3SGFRQ0w1ZTU5YUc2UXVnM1F4eUswOHVnaG5sRlVW?=
 =?utf-8?B?REFvL3pkbDA5a1A1QlNrZEtjeUlOWVFlZ1prcXJzVHNFRlIyMkExU1hxUU44?=
 =?utf-8?B?ZVV1OWZMSWNXcFEwWDNlNm83bDFBUkZjTjR2YTRvL3lwNERCa01SckdhTFBX?=
 =?utf-8?B?emRxelJTbDNyamZTajB4SU9ZTHhPMld0Wm02bjJXcjZNeFl3OXZqU2l2Y3FO?=
 =?utf-8?B?ZzFjbmhxaGtXR0RXK2JkV0hIS1M4M2V6dU40L0tpK1RyK3I1NTQwaXQ4YVJQ?=
 =?utf-8?B?NGlmbGZqTm52dkFUVjBHRWdHTzhySFcxdDkvSGtyVVZqN1BWNU9EUVlMTUdN?=
 =?utf-8?B?ME1ybFVJUUt3QkEvcnVaV1hkZ3JnV1ZRN1l3dXhlRlNTaHFYTTFnbllsSkdi?=
 =?utf-8?B?cUJWY2czQStVUlFjelhnM3hWT2xDQVdsRzc0UXc4amh2ajdtTEtBRC9RWVd6?=
 =?utf-8?Q?NQeEnBkv+YDcdxzgqp7QPHpZp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c7dd3f-ee31-43c7-0f0f-08dcc6ed8dd9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 23:11:17.1114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uM3nUsudK9MAW/5+ezPzOxoeZ8mgvFT3FYlzZMzvRM1hDPjQ1lz/pgFdX8G/m6r/N0Sq81A+SFn+H7Zh0V3+dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7546
X-OriginatorOrg: intel.com

> +static void sgx_cgroup_misc_init(struct misc_cg *cg, struct sgx_cgroup *sgx_cg)
> +{
> +	cg->res[MISC_CG_RES_SGX_EPC].priv = sgx_cg;
> +	sgx_cg->cg = cg;
> +}
> +

[...]

> +int __init sgx_cgroup_init(void)
> +{
> +	sgx_cgroup_misc_init(misc_cg_root(), &sgx_cg_root);
> +
> +	return 0;
> +} > +
> +/**
> + * Register capacity and ops for SGX cgroup.
> + * Only called at the end of sgx_init() when SGX is ready to handle the ops
> + * callbacks.
> + */
> +void __init sgx_cgroup_register(void)
> +{
> +	unsigned int nid = first_node(sgx_numa_mask);
> +	unsigned int first = nid;
> +	u64 capacity = 0;
> +
> +	misc_cg_set_ops(MISC_CG_RES_SGX_EPC, &sgx_cgroup_ops);
> +
> +	/* sgx_numa_mask is not empty when this is called */
> +	do {
> +		capacity += sgx_numa_nodes[nid].size;
> +		nid = next_node_in(nid, sgx_numa_mask);
> +	} while (nid != first);
> +	misc_cg_set_capacity(MISC_CG_RES_SGX_EPC, capacity);
> +}

[...]

>   
> @@ -930,6 +961,9 @@ static int __init sgx_init(void)
>   	if (ret)
>   		goto err_kthread;
>   
> +	ret = sgx_cgroup_init();
> +	if (ret)
> +		goto err_provision;
>   	/*
>   	 * Always try to initialize the native *and* KVM drivers.
>   	 * The KVM driver is less picky than the native one and
> @@ -943,6 +977,8 @@ static int __init sgx_init(void)
>   	if (sgx_vepc_init() && ret)
>   		goto err_provision;

In sgx_cgroup_init():

     sgx_cgroup_misc_init(misc_cg_root(), &sgx_cg_root);

.. also cannot fail.

I think it should be moved to the sgx_cgroup_register().  Otherwise, if 
any step after sgx_cgroup_init() fails, there's no unwind for the above 
operation.

The consequence is the misc_cg_root()->res[EPC].priv will remain 
pointing to the SGX root cgroup.

It shouldn't cause any real issue for now, but it's weird to have that 
set, and can potentially cause problem in the future.

>   
> +	sgx_cgroup_register();
> +
>   	return 0;
>   
>   err_provision:

So, I think we should do:

1) Rename sgx_cgroup_register() -> sgx_cgroup_init(), and move the

	sgx_cgroup_misc_init(misc_cg_root(), &sgx_cg_root);

to it.  All operations in the (new) sgx_cgroup_init() won't fail.

2) Remove (existing) sgx_cgroup_init() form this patch, but introduce it 
in the patch "x86/sgx: Implement async reclamation for cgroup" and 
rename it to sgx_cgroup_prepare() or something.  It just allocates 
workqueue inside.  And sgx_cgroup_deinit() -> sgx_cgroup_cleanup().

Makes sense?


