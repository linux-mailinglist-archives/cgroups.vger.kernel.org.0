Return-Path: <cgroups+bounces-4529-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6025961AC6
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 01:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1597F1C224A3
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 23:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D921D415F;
	Tue, 27 Aug 2024 23:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ah1SfT4x"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02991A0B00;
	Tue, 27 Aug 2024 23:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724802395; cv=fail; b=i51o/KIo8xRZmKdLtKIID4o94cfjKN0+okbGQXrLsyYyS1f6Up6bLqGrw0tYAfZJWlUB6alKbRj3v1p+D9fD0ttMApElo9FdSdcCmAT3HbcBNEJVkTadXpU95SHgtEpnjM1STN5Z7vBTqnbvm5sBFiyjN+ln5LuwIcr6+YBYu0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724802395; c=relaxed/simple;
	bh=Dt+Rh2Sk82HYtJ6JabUB6sXYdiufka8VdmeKGMGdD/Y=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JraOu+S1sgr1mo7xykvWlFEZmNHtvw9uvA7c3rPwtagpXs/Jn5uTrCuJeAMDQJsVsRlrKR//7jkBUOZgMEgo9f3RTLp8vCmaMn83Y2LUmvvjZ1fvhWzkoTXfTm689ZbE3gl7NNI0U4wC9V7Nh1gqFp+IfbVudqmfmOGaXRGvggk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ah1SfT4x; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724802394; x=1756338394;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Dt+Rh2Sk82HYtJ6JabUB6sXYdiufka8VdmeKGMGdD/Y=;
  b=Ah1SfT4xPxhMdOBmG1FLGrB5Rn8kKvjPVy4Uis5BmSzPYe/K+S1PKBRX
   G9yFaWWyggI3VlIIiO3fGpn+rj8q48hbX6rnP0v1tHgN3hm5E+5u8rR/1
   Ro3HXBvnJRGIGiND+fHEAipZkOprZ+GO0y4CDEANdmnHAbz4OigqvUFrW
   DO8asbbZ/dQ1RybT8igWEltx5rHPVrNrFIHzpsqTxYEhcg4bCinfxf/rH
   Md2ntTB5H7TWH45XAS6UBlxHArdxEj2JPMnR/TxxfLVdjHZ9S/IaeaAbA
   oYauQY/WeSpbzJrBop5N+uRIqUiJ0V5N4ksTt0HU3Jw36LZOfwWU1LH78
   Q==;
X-CSE-ConnectionGUID: 7J9WJpg1QYKRwva9G+mQ1A==
X-CSE-MsgGUID: YRQqAK2kS9GhaeGXHnIfzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="34466672"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="34466672"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 16:46:34 -0700
X-CSE-ConnectionGUID: QOiOl0BASi+Rp4FaBUqwrA==
X-CSE-MsgGUID: QKqPQexER9GIyFYXRwDMDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="67895498"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 16:46:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 16:46:33 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 16:46:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 16:46:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 16:46:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKNoI9yVZXOS+nizTZ5xtk1tFK5QtvtUmZrlvWl+ml6x+V20+VN/GfL6hEQ5ZMTI2KCFjWi8jpGI97yDAubUbtRLyrrAN1QjRJ7gvrI2IzKFjJXbyJJL0Oc5qvjmixWf83aSmioKgb3evcopgbARTjrV0ROOipJrlqNYPxvapNE+1W/M1gNH2a8s54jdkwNb3sMaFniGr+zeoNT+RIjPWeFb32ZnBgOnX9tyL+Y0KpFlHfg0gt6+T3uoXpgUxn0ce3HS+Q5W5LwQHlGfl9FFWkptP+Cv0QrtIm+gaHzNaRBO/D3dEuzRwEjEjlWVgc7ky4zacOie4ExHvPCtfQOIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63wZduFObTnBxiFDhqyKhFKrJggSAK3BsgRjxzHq8Do=;
 b=kvCLhfsqsfL2P6j2WfKX3IWJ1JBT0jFL5ChUVNotnO98cFc1tz3A+WYQ2mJtHp1XVr72aXaWwJrmb9aqZORqn4P7avvrIk38XFuGUv8vj70iNksgQcSqmTc3PLJZM/9bTqmUQIM1C+x2xvVN+Fo4dROyJKnDL5f3YxscZ8Xr2GIHufR5m39JatabfLYxfuip/Iod+n3vukM82vvtTIEMSdZePyK5CngSFindnlq7YaZ/QtWfB5kvH8YNCtZFmLNtKwyoq9WjxMqkj61GP9PD8oj6G88muMCjOftjOmdPG8M1/A8OUCEu4/d42ulxgG8DdMd+HY4L5BJ+miFdFg5e6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CO1PR11MB5012.namprd11.prod.outlook.com (2603:10b6:303:90::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 23:46:29 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 23:46:29 +0000
Message-ID: <ff491ab3-7423-4c70-b496-cda679e143d2@intel.com>
Date: Wed, 28 Aug 2024 11:46:17 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 10/16] x86/sgx: Implement async reclamation for cgroup
From: "Huang, Kai" <kai.huang@intel.com>
To: "chenridong@huawei.com" <chenridong@huawei.com>,
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "mkoutny@suse.com"
	<mkoutny@suse.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "haitao.huang@linux.intel.com"
	<haitao.huang@linux.intel.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "tj@kernel.org" <tj@kernel.org>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
References: <20240821015404.6038-1-haitao.huang@linux.intel.com>
 <20240821015404.6038-11-haitao.huang@linux.intel.com>
 <93b68e3bf58c78d5a2b941cd2331b838c7824625.camel@intel.com>
Content-Language: en-US
In-Reply-To: <93b68e3bf58c78d5a2b941cd2331b838c7824625.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0077.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::18) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|CO1PR11MB5012:EE_
X-MS-Office365-Filtering-Correlation-Id: 1183b063-0440-4706-3b6d-08dcc6f278df
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0pJYlpHQkFwT3Q4ZTFLNGF2d2w3aFFiNjh2cGIwZDdSWm9OZWk1N1F0Z0xM?=
 =?utf-8?B?Z2l5Tlp5MVh1UDlVcDJBam1kaVFkSkRMcEFkbFhxeVpYdzZKN1dCdE9aeWhU?=
 =?utf-8?B?ME5UTDRMZU9QRGtvaEQzS2pVR21xMStzVVhDSjc3eEpLanFWSUd1ZElIMysv?=
 =?utf-8?B?d3NQb3pXaTFCR0dnK0xmVW84WVVxQkdzQy9MMndaSXJTdnEvbU9NcTR2c1Nq?=
 =?utf-8?B?YjV4aW9BdENTeGhDd09XK0tBcmJBYS9VTkZ5cHJ6dmRqSTd0SHdDSlFyMWNB?=
 =?utf-8?B?WDZaNXp2Qks1SDFyb25aczhxWFBTWCtOZXAzWTRpVnByZkZWemlDOEdqN3gy?=
 =?utf-8?B?NFhZS2FDZmxjUmhlcUptblhxVzFFVnROQUdXaG02cDlRNEJ3NkZnbEpTNHds?=
 =?utf-8?B?NXNLVTZRMVFzbGUzVHRxT2kxTEYveDBtRmJHNlhDUEpUNmUxaVJuT3pLcUwr?=
 =?utf-8?B?dG1INWk0ZFdsRXVNUExUWkhDeFB5M282bS9HZWR6UWE2OWlNUGJsZWZZQUxJ?=
 =?utf-8?B?dVJEUWZQc25vcFRZZ0MwTE5vMWZ4b1UvQk50alBwSXNDa2d6RTlzWjdBbGho?=
 =?utf-8?B?dGsrSFFsMGFpdk40eWE5QnFVeFFJdkJQVWp4L2RsTUlMUUNIV21RMVBEWkZn?=
 =?utf-8?B?Q0NJNUZLSHZtc0J0T3o3VVVheldsT0tKSzBaK2E0RFFBTnFrVzJKTmZqS3kr?=
 =?utf-8?B?LzRQT214VXZUYzB3RXB0UzlkcEVmUWlUU2Yya0x5TW9jYTdBKzlTejdyQ2ZS?=
 =?utf-8?B?eFczNHh2WTc3YVhHQ2tMZmR0RjZSdEFRUGZZOERqQ2hMUldMdjdjNHl4c2Nw?=
 =?utf-8?B?Yk9udmdWcGI4bUtoTlIxenliZWNMMUVnbUF0UVR6OVhyT0JXNHFMblo4cDJR?=
 =?utf-8?B?KzNwbENQNUtzeHVuTGxFdWJuRTA1K2NFR1c4dTNuTTRLanZTc0wxNDZPTzNx?=
 =?utf-8?B?TlQ0VzFUdkFIT2VxZjFjVDZMRlNUdmx3OGVTdjEyOXpRZXF0ZDBzRWNuSi9o?=
 =?utf-8?B?bTFoSDVFYWZ1b29OTHNxbVhETjg4a2FvTG5pWjAzVUZPSnBXa3ltQmRuOWk0?=
 =?utf-8?B?SGdHdEpUV2EwOEsxRUMzQkdHQXc5S0d5ck1OM0gxTThIbnFPL21uV0F4cVhQ?=
 =?utf-8?B?K2M4aHNWNlJnZUJaRjIwUkR5aDZ6VFpwVEVkWDN2SU54MXZ4OXNTU3JpZzNN?=
 =?utf-8?B?bURCVHZoUDFRRzdMNzd2dUMzamM1ZHYzT3duQ0Nobzc4L281MUlkOUNDckVS?=
 =?utf-8?B?VXJsNzNYYXN0YlZob2FlVU5XR2w3WVhONVpLbGtQdCtweFNjOU1vVW5qck9j?=
 =?utf-8?B?d0lwNWpwbUJaejViM2VQMU5OWTZBdVNQV3NXVjNIekVpRDRvZk5yTmxoVmlD?=
 =?utf-8?B?ZnpEd0EraXNpZ2pKcy9xOWVuVWtURWtCSEJIa3NYb3NscTk0RjFnVHhvWmgz?=
 =?utf-8?B?cWFFZGRUYTV5OGZwZ0Q3RG9Eb0x1bnYwZm9USnF4bXdaSnhTMmp4b1FSZWVH?=
 =?utf-8?B?aDNyTlkrNW1pT1dBQVB3N05MaUVXenJSaVVoeWJMZkRmM0E2ZFJ5aVRpUWYx?=
 =?utf-8?B?ZHJIbm0rQWFMTVF4TWdjMStyRHFhbGYrUzN6THk3VWhOVVZ4Ujc0NEIxWDBz?=
 =?utf-8?B?YnlnTXNwTUZhOEJCNWhGR2NyU1hLaTlFV3dhV3BvVmhEODhSNkg4S3VOM2dK?=
 =?utf-8?B?MnpRc29CMzlvbFpVTEN5WWwrZDJ5WGFKcHY0S0JWK3FMdUhIZTMvQkdCWUZD?=
 =?utf-8?B?VHZhV3hjSGMxd3dOTi9HK2JkL21WYkFhT0JxTnBZY04zTStnSE5JOWtWRS90?=
 =?utf-8?B?bDZQNitlSlRJUWd6aGtmZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0JOOGhoU3BDT2IxSnQwWlFuZUo2SHhlL3dqSHg3VGlOeVZ0cTNtNW1ZQWRZ?=
 =?utf-8?B?QWVPd2IydzN1N1k1V0NXb0Q4dnhQN3FaZjBubDFLNS9DUzI0Yk96WTBMc3FE?=
 =?utf-8?B?alp0L3VrbXdyazVWRVBPR3ROQi84UXpDTHozNDBRbTRxVmpnUnZRVHVEanlW?=
 =?utf-8?B?cXNqaGF1ZUNFZ1RNUUpJWlZuVVovVWRtZTR3VG9QMUNmdXE5VmhpTVp1a2R5?=
 =?utf-8?B?T3BGaGJseCtBd3RYcmx4ZGRlN0lrZHVYOFQ5dDhpdDdGWFBPYXZBQ0NoaWpE?=
 =?utf-8?B?eFpUWWhJR0YxTHVOamZ4Nk5DbS9EWnpvdFBPRXRhNituV0MwWXZ3R2IzS1NS?=
 =?utf-8?B?aGt6Rm1aQmc3algyUjRRUjJLQlhuTFRnQVF1ZG9Ub0k0ckM5bmpDUlVhOWpC?=
 =?utf-8?B?YXBQdy9nRVpLQVpnNjd6NFNQdnFIMTBmSmNNTVAvVzQraEx1c1Rua29HK1Q3?=
 =?utf-8?B?cTR2ZEgxZ3NBK0RkaGs2WVp5MzRybE8wcFoxN3pxM0FkVWxGNTNTa1RvbVlW?=
 =?utf-8?B?RnJuV2xvMEZjc3VOZUhyWFZialF6UEVzT1VycXlKWnFVNXcvMEw3dkMwZysw?=
 =?utf-8?B?NzlTdnAwQjdXdHJlOW5PWnZFOTFyOTQ1VXZ2UEtlWGZmMm4rbUpNZ1FMS29Q?=
 =?utf-8?B?d3hwSVMrWE1wcXRMbU9DSXdUOVNNV0JWWGQ1T0s1UmJwL3BXa0JOblZCNjZP?=
 =?utf-8?B?cU80NDdlZThmbWR5VzdmSjE4K3YvOWw0dkYvMlhsNUUrWmczTHJaUkU3S0pP?=
 =?utf-8?B?V3RDZVVkZUNhejlvM0xBK0kyRGpxZWMvK3RqeHhISXVBUnA0a1VlakZwMys4?=
 =?utf-8?B?dmY1cjZKNDJQSDZySVRoR3JudHVzUWhZTlpNeWJUTzB1VEVvMjZRU0daQ3Vm?=
 =?utf-8?B?TUVPc0wyWFhzQ1pmUENORUUxZXZDS0FpN3A4VFVQV2k1ZGVRNW13UTUzV0Jk?=
 =?utf-8?B?WVdpa2xoRXpzaTgyTklMTkU0aUM4bm0xNWtNSzEyU2x2aHVzR0k1THlaaVlM?=
 =?utf-8?B?K3BRU0s5K1RrOGFlb2Z0NnpDekdpdFFIRWNPSGJsazQ2UkNrVzIzbEE1TXJF?=
 =?utf-8?B?OUxaaXkxQndwRjJtaStrOEdZZlZrTGdrK2NZa0FlL04veTVGYjNtM2ErNlZL?=
 =?utf-8?B?ZDFDOHY4ODRmbFpRbVVkbmkyeG15czd2bDRnMXM4ZVRkSzRHalliSzJEbU5O?=
 =?utf-8?B?K2J5WXhpRnhyeFE4UmlsSzEwSXJzWlJQaVFxR3dGblEza1pRWS9QK3pPQjBl?=
 =?utf-8?B?QWE5MXM3dGJSdjVQMVZ1ZlptTFFHaTZ0M1VJditpMVBIcUtNTllxWmZQQ1NY?=
 =?utf-8?B?aXlxYTFPQkZLU3g5VWtDMitDVXVtVVZuRFRqY2ZOdFVyRmxUWklBQUpLaGlk?=
 =?utf-8?B?aDgwQ0ZiZTZ4M291bW9rVTRsb0h5OStjR1owbkZKeWJ0aThEbzhiRXlnbXNu?=
 =?utf-8?B?UkxJN1NPMmdqWEFHMWdZT3dkSDNhYWJIZWxzUmlub0IzMURPR3VSa2R4NGNL?=
 =?utf-8?B?dHhGdC85SWFNU05BeXF2a1l6dzJyaVJKbGNPMDJsTG1LdkttRFlRMVM1c3ZN?=
 =?utf-8?B?T0p2RVRxQ01UcGhFNmlsWmJBcEZUWnplNXJvNUk5Mlh3aGZLN3dlR1IwczFO?=
 =?utf-8?B?cUtKWFAwKzdrYjRMTlQ0YkN2UGJIT0lSdVhtNDRZNjdEWWxDYkVnUDBGUSsx?=
 =?utf-8?B?RGhKSC9jcXNBZnpjbHlUc01pZHh0QWFXRkJGaER5Z1JFUDJIV2t3emJiS3dE?=
 =?utf-8?B?S0xlN3o5WHc2UG1HTjhxUklRY2ZEUGs1SDdvdGt3WU1obTRZRko5VmhHYjhx?=
 =?utf-8?B?WDI5bEltK0xSTVdqOUl2ZTZxK3pYMnJtV0cxdUlPRXA0Rm8xbEVkQXk4WG8z?=
 =?utf-8?B?UHBBRk9ZZFR4c0NEUW56ZjlBRWQwaFRTSGFqK3lLRlBkVS9PYkk1eXJ6K296?=
 =?utf-8?B?Ty9nQWZjendPZkZvN21TZmRpS2JnNUNBeHByUXVVNkJMN0lNQ2JqWVZ4b2tx?=
 =?utf-8?B?QXlFUkNMOFN1a21rODFjZjNyVDBwaFBKbEtaa29UZXlhUnVEL1NMcitQNjJE?=
 =?utf-8?B?RnlveEFMbGJSTjZBOHlpYlRhQ0NJT1hzc2orQy90UkE2VThGVWlsMGtEM3kw?=
 =?utf-8?Q?wtpFR4gLMjPTihxjCNwp2hgqj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1183b063-0440-4706-3b6d-08dcc6f278df
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 23:46:29.3779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhQycxvDvrpOeF/yw6YsDU+5G00pc7t+UdQstl+ZXkF/aGuGnBRJhWbgDDzdaNG0k2SKuaSFkeU0IhsOh5CtfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5012
X-OriginatorOrg: intel.com



On 27/08/2024 10:22 pm, Huang, Kai wrote:
> On Tue, 2024-08-20 at 18:53 -0700, Haitao Huang wrote:
>> +/**
>> + * Only called during init to unwind what's done in sgx_cgroup_init()
>> + */
>> +void __init sgx_cgroup_deinit(void)
>> +{
>> +	destroy_workqueue(sgx_cg_wq);
>> +}
>> +
> 
> Ditto:
> 
> arch/x86/kernel/cpu/sgx/epc_cgroup.c:412: warning: This comment starts with
> '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-
> doc.rst
>   * Only called during init to unwind what's done in sgx_cgroup_init()

With this fixed, and things mentioned in ..

https://lore.kernel.org/lkml/D3QWEFR2E2BZ.187FVXI3QQU9U@kernel.org/T/#md5267379c3787d436d3297295fe4da587522444c

.. done:

Reviewed-by: Kai Huang <kai.huang@intel.com>

