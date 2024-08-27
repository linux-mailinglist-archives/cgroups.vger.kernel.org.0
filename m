Return-Path: <cgroups+bounces-4531-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C274D961ADD
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 01:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5EE1C22B07
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 23:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5991D47AD;
	Tue, 27 Aug 2024 23:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hWHADGJp"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0D7199FB9;
	Tue, 27 Aug 2024 23:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724802929; cv=fail; b=AjzPOvgP9tKdUnYKgoEua4w4SXsaifiAvDHZgTTOlsO6ek2ZlmFvZiqOUcZUKeo2hjN3/UL/MFj5us+b7RdkXBCsvKpAgPUT9BuAEj1dmJBx7gmT5d7+Sst970uYgKRthJBRWK8EuNvOsgyM7Bbgun5nR/myMBPkcOeCPP2qEcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724802929; c=relaxed/simple;
	bh=F5EVK65reY9vZIFGzgsKI+DAeexoW0s0JWrv07TVXvo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u/DDOWGH+eefZBnsxuyo++jTnf80jcmjpKnG5DE6Jz5PgzaeUFH81F4xNhSgKvEYn+qDIPsWaTStFVOZ+/GeagFUYHljUdCX1uJqNQdomREfqgzxTYFWh4E942ppcpk4YKduc6za7kdVLK2BNP6y+60BF9NAiOOFUqZ40tXKAMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hWHADGJp; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724802927; x=1756338927;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F5EVK65reY9vZIFGzgsKI+DAeexoW0s0JWrv07TVXvo=;
  b=hWHADGJpe+F/fVJolQs3fWNCOk+4cnsP1CfU/84VDt1EyhpsjdTtMYMI
   cpbbSoGzy3gYibiVn5G4fd4P4ALGJjrDNuHOPHT8jOJkoF+OT7wAgh/Sf
   sAQaBIaG7vXpD7TZWi80ioL99Zh26BR9j82iq/jxW8wE1ElT1M8rO4C6f
   zj6SplzRykYdU2Bkgvn3lUo+U+nv9VJ68VzVbQjc8+HKLH2n0NMuLY2IZ
   J/aSY5ojtbr9TNV7kGw8WjFzl1z+sOdkz7UJEWVMWwSNNuJgNBqW3pIIi
   8lBfpgvu1xl6L4OBHsQH673zma+D8CO4K8K1kUcuhAI8zwGnCqUws7Y8t
   g==;
X-CSE-ConnectionGUID: cdYLr6lQTKeSXGksuonYZQ==
X-CSE-MsgGUID: Mc9HpFoiQUSwqM9qXxKPhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23453708"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="23453708"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 16:55:27 -0700
X-CSE-ConnectionGUID: nFzEmqdWQsmwobBJHi/DLQ==
X-CSE-MsgGUID: svUQdam9QDq4sjMtpLbv9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="67184617"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 16:55:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 16:55:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 16:55:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 16:55:25 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 16:55:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKm5auoK8tItQlhjkDG/1bs2/Q5LfEwlpwGBWqB4czo1HiwccaaRj4USmsb/wQ0eBwNHy0LX1Nq0nHTgtZhOPUJYzc9ZiWzA9cwkMJjr8+WYWhCJFWWGRJUgD2Zc3W9MPRRDb+9QKlOoO6g7Qg39XiXMeyi1/GLdLCI9SUBmQUXWAXB8k5gmtCOcqvdUAHGAPUUGOfvCoQe0dNm1NM/THzzkt75tcY0POAwmpe88jOZCyYEJzFaNhORtphMA8I3WeUjQf2y9+spXe44NsR8HcVYFkJSmw/c/5fqF2bEpZz/xfLc+hIzY66IzQxRhhQK4rIZ46BhT4gNZVg/9jlp4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XntuDM0nmuxBe+j2JGwPMjrszVyc0CzSDdm9XCmnGck=;
 b=mP7Puwow2BhJ3DyCGeFKIScx0M3clGxz4BQXTJx8fdr4t0Pm4EtXY4kgLE87+ZzNaeuKk1HGLYsn4zy4AFshJJLoesUsONSdyaai1ZOmDKGHOqXy18j2qE14WlNaM3yikzMxkgcglI3utFbLeEpuRtD5D66G8TUqWi152N+V3gldrovrEYhW/ABdx1a1rJzYI2WEb11B+vv2k8jIWGz6cbOSxr/wrDAZmZKwMb8GOmu7576W0ElQbLGq9AUzrZ09pke6KZYkmTKzTySZulERnDXUbK4cmDk525BlqyxM8o0ToorYOtOVvcyVle4TxwA0+mAN9W38D/tY0uJd3zuNjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by LV3PR11MB8727.namprd11.prod.outlook.com (2603:10b6:408:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 27 Aug
 2024 23:55:17 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 23:55:17 +0000
Message-ID: <6562ecf0-c9e4-44ce-9bb0-91cf96b3f866@intel.com>
Date: Wed, 28 Aug 2024 11:55:06 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 13/16] x86/sgx: implement direct reclamation for
 cgroups
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
 <20240821015404.6038-14-haitao.huang@linux.intel.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <20240821015404.6038-14-haitao.huang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0089.namprd05.prod.outlook.com
 (2603:10b6:a03:332::34) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|LV3PR11MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: 98062463-0a93-4a12-3147-08dcc6f3b375
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0QzRlBtV0lCelhBdWNlZUZWelo2TGhxQ1FzdEhuZzY0WEcvbkxxRzZha3Bl?=
 =?utf-8?B?dGhsWGlqTUEzVndBdk1QcTVYMEtnN3JsK3dCR0dXZzNBdy83cGgzNGNId3la?=
 =?utf-8?B?WkZqQVFWSGFOdXVBb2o0bnVuWUdZSFBORllPS0FGZE52ZzUyM3puaUEwOElk?=
 =?utf-8?B?L2wxRndURWZqeTV1K1pyWmxlbnJTaXNnV0NiZ3E5TFU5bUZBT0FQNk9kdXRy?=
 =?utf-8?B?Qlh1eFFtQ29OS2xwRVNHU2ExeHAyM0JETWZoYlN4Qy9Ca0xRY2VYRU9KLzhu?=
 =?utf-8?B?WURpam1Wb1Nrd3VUbnVPOFZwcUh5Y0lXQThQcXdDZ21yMk9sZU1NVkl2T1BF?=
 =?utf-8?B?Q2lUUVJibE84a2NZTXVBZDRFcDJzcGNQVlVNWmc0c1J3WFdMaG1lSHFUbkZq?=
 =?utf-8?B?RkRPRllOUnp2ZXJxdEE3S1YxNHFNLzh6aWdIRHB2bms0bjN4UGg5L0JSbXR5?=
 =?utf-8?B?VkVMYlNSWVltUThVOThaTTVyTGtjLzVqaTJCRmdsLytJd05zMmtETXh5cS91?=
 =?utf-8?B?ZStGdjJoTm94SHZVVVFiWU9FMXl2b3dqVFpHQUxGUDhUK1RSbng0U1pUUE5v?=
 =?utf-8?B?U2xla3VJdnYvOC9pSGtEUmE5SWRoZEI1RnAyQzY4VU5XbGpTK1RPVmVKWG5P?=
 =?utf-8?B?VVdDKzRyTXpyOUxiNXdrV1lPVjBpQks2dlhhZldYL2p4SW4zZDFURW02WEVI?=
 =?utf-8?B?QWhBQkhoR2k3cDdrMUFITEM4RGZ5SFBGeVJPdm1LNVdkeHRkclRmSDhzYmpx?=
 =?utf-8?B?VjMrTTRFRlAyMlhzdTJmMDQ0a2RlS0NsV1NvQTcrdEgvU2Rldlo0ekN1bHRF?=
 =?utf-8?B?Zy90RmFtS3BnSm5JUTNQdWROdkxMbWloRDc4M1lIdE1kSlgxSTRCUHlhdHVH?=
 =?utf-8?B?M240c2FWdERRSis0d1JPSXBHQmwyd0k5Sy9qaDk2VnhZQjlwd3pNY3dzcTJG?=
 =?utf-8?B?S1pxOGdwbCtZWHFjK3YyNmFKMGRPL1FmaXlzVDJCT28vR3AxVm9Kdk8zekQz?=
 =?utf-8?B?L1ZvQWo5cWcwTUljL0RVRytzd2tKRWYzQWNvUmhjeFRISTg2bFhFVGZablZH?=
 =?utf-8?B?UU5GYjNVSm43bFVCVEpnRFVpRW5PemxRd1dqR3BBNHR2clZyUjNKY0ZFK2Y2?=
 =?utf-8?B?R2lYMkJ5TytHbGVXanVFdU9paEFwdklvR2FDM1daSzVTU2NaWW8veVhvd3RY?=
 =?utf-8?B?K05uQTFJcHhITjVLS0ZLUUttVUNLVU5OcWZKdlJaQUtWRTdpSWwvVzE1V242?=
 =?utf-8?B?SmxIb0I0SlEzR1I1Ni9PS2loOU5iWmJ2aThhQSs2aTlHeWF2ekpaUlRqbEJz?=
 =?utf-8?B?bWNxSUYzNmRJcW9DUUwzcm5DZkRLclBXZGxVcE82QlQ2MEQ3ZHc5N3hPYzJz?=
 =?utf-8?B?SkdrQnR3dmZPRjlFQzdORWdrakRIOTR4Ri9Rd1QvTVE3T3Jud1d4a1pPYlZr?=
 =?utf-8?B?NzNBWVhtaWd4MlMvWWdoMUZMYy9WcjA1MTlTWVFsUGVyNTVvak9ycGlTWkpW?=
 =?utf-8?B?UUZ2T3NVVElobm9sbnozc1Jlb1lZekNCS2Rza0sxajBITkVOSkwxM2V4aGhv?=
 =?utf-8?B?dFJlc0VTdFBBWS91aTcxODJ3WE9QMTFSRENvUW13bWExcFBqdS9ZVlFVbkli?=
 =?utf-8?B?ek90VkppbmhCY2hnZ25HN2Qra3FGVzY5ekNsVk5SalUvSjc5UnoxNkNOc09L?=
 =?utf-8?B?bllvRnRwaG5Tell4aFZsYXZlS1NYU1huL0p6a1VScDJMTnlqY2NzWXlLV2hx?=
 =?utf-8?B?cUFFVk1lWmZmdUVLRjJMUGg5bFFxeVN0NHRvcklKZCtoT2NRTUZMTXF5b0Na?=
 =?utf-8?B?ODlFZ2plZUsxblJpNVdOQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjRtMTBhTjk2WUF1bkpXWlFFYTc5QmRLYWQweG1XR0xlb1ltMmVTQkg0dzY3?=
 =?utf-8?B?UVhiWEoyb2cwT09OQ05Vc2NBZ2lPWElyVVlkMWZwbUExWWh0QUpRbFk5cXVj?=
 =?utf-8?B?elMzeHF4dS83UlhSVi9BaWxTYW51UytGSjdpUmJhRW5UWG43b1pCcmlueENY?=
 =?utf-8?B?WE5YUmJiMExTMG1CV1VMNVN3eUl3MXdOcE92OXNMYmhBWG1XdjZyV1B0TVl5?=
 =?utf-8?B?STRUbkxjVXdQeGsrK0RLeU1zWFFsR0pTTE1lbjBLTEJYdERKMEN6MVFsQ3B0?=
 =?utf-8?B?a1N1andldVhEU0VJMzhTaCtEYUN3VGdnZnM5V1lUMjgwMEVmcm8xeTJXUGF1?=
 =?utf-8?B?SmdlYTdEMnZhai9ObWdNWVV2bS9IaW1vU21kdkFIUlpydzE4WGppb3JOM2pJ?=
 =?utf-8?B?ODQrcTFWdkhEUVBUVVRFanFrR1U2d3BVUEs5QnhBTjhhM0VzT1Fla0dHcEtj?=
 =?utf-8?B?Rno0VlRTKzY4bjZkOERsQ2x3a2g5UFg5N3k4TlpkNVB3QU1TSHZSNGtxMFJG?=
 =?utf-8?B?VE8yd1JQbGVmRmR3dHIwd1haNkZRYjVTY1dpOThXSk5sUzlEa3dFV2xRTzBq?=
 =?utf-8?B?cFMxZ1RrdWVqZFFPc1dRaW13aXkyejI4V1hRL1BQNWhZQXg0MkZSUmM4VHpp?=
 =?utf-8?B?RytSODhnNlZxV3hiTFBwaVpVcUdQRnpOdzYwTTVHUnk2bDBtQXptWFRUbS9Z?=
 =?utf-8?B?ZlJVdkhGblZHVWc4aFh5YWtkVVE3Wm1Lc2g5UW9sNCs1SHMrS2ZIdHlZa0V6?=
 =?utf-8?B?RktYeThONjdYTGdJT2hFRmNLZUg3d0NaQWJta1V3b0oyd0NWWkRVQkV1QjNI?=
 =?utf-8?B?OVRTTEpVdWZXUzhkMFU2MzlnQTZFYlhNdzZCZGQvaU5yNmd4ckVMbDZxc1RR?=
 =?utf-8?B?UzIvQzBEQjBmM09MakV1M2FxMC9BVHU2ZFB6Ti9hdXg2ZUNUMDR3em5qYWFs?=
 =?utf-8?B?bGRSaXBqVXlLOFIyTU4xeWphR0hvZ0RlQ1NNa0J1VkFycHJSdm5LT0VGcHBa?=
 =?utf-8?B?aXVkL3hUYk04MmVJQlNac1FlTkJQZHdBNTFibFU1ak1ITUFRZlY4WmlDLzNp?=
 =?utf-8?B?VGt3UTVRM0paUnhyR2JWZ1dOaVJRQU8wdzVrYjA2R0U0NGlBRTNJenM0TzFs?=
 =?utf-8?B?UFpQMExPNmRrWTFMdmNCTmNhbTNLby9nN2dBUVJXUCt5aTNyZE9NTmMvdE1H?=
 =?utf-8?B?WnJOT0x4bkptTkxhY21YcFpOKzdSYmpYcDRoTC93NmNVVEw4cS8xUFlmK0ZE?=
 =?utf-8?B?dVY0aUl5OXA3NUN0dDFGSEtocGhxbk4zQ1g3Rm1Rd0pBaUFuemVJNS82TlRh?=
 =?utf-8?B?YU5CRlk2amJIeXNqRXRMdzQ0ZURSSmxNd3N2MVZHRmxqemtTREg3cm4zdkx6?=
 =?utf-8?B?NTRnYnhQV0NleWpIak53VmRXTlJHdkIwY2diSzJlZUZqZkdadkg4UFYzNHRi?=
 =?utf-8?B?cHRuQVlnaWlwMllrQUUxVXZ0WUR4UFlTWG5pNERKTktFeWJ3Y3BuaHNTdE03?=
 =?utf-8?B?WVJkOGVCbk9QL2Mzb0F1RTZXUngzVmFNUllSU0RsMkUwWWJycE9kVGRPQk00?=
 =?utf-8?B?cHQxNm1xOC9OaVJZUnZUcnU1VEpQY0ZkTmdKU3R3cTVaellmUFFlMDk3N1pN?=
 =?utf-8?B?TlJtTU1jMUt0RktiZkkzcG40UFVJcmlpOWsvZU5qNWVaVDdBZy9maGlIMVZr?=
 =?utf-8?B?aStNYUtDTnVydktpbCt5UE1RUmx3Yzhyajg3VytGTEwzWjRqbFpKbGhKQjhE?=
 =?utf-8?B?SGI0RFJoeU82SURrRDc5ZGlWVHhka1M2Wk5RRTNZdHhLd3BzUWFQSG44cmxp?=
 =?utf-8?B?ZDhxRHV4RGkzb0g2eUNCdzZPeWVRV0VZeHRxU0FGemZKMExnOVd2Y1VldjAw?=
 =?utf-8?B?TDlSVG5vdDUzT0NXcW0zd1ovK21Dd2JQd2F1K09vUTlKMjBNV2JvUXZWUjhl?=
 =?utf-8?B?RCtrQ2xKSy9XSlZEUEQ2VTc0cE5iUkFYa040ZW4ydjhCRXFlMUU3SUpGL29y?=
 =?utf-8?B?RFBIWGUxVjBrbUFzQjNsZW5oSVBYazZaQnRzUWdubEYySkpOUTUzVFFha1Fw?=
 =?utf-8?B?T3VpcFZ4UDdvelZvcmVudy8yZVpoZTZ6NnhEL3JzYXZzOFNvU1RmNVBmRDRN?=
 =?utf-8?Q?D6xyC43OEd1wGE6r7bWiMO+GM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98062463-0a93-4a12-3147-08dcc6f3b375
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 23:55:17.1527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgIqQvOn6Ackkc63w5PrQbdNSIrmtIk+QUIbpVdR8hzi23+v0VvmJGnnTUZx9xm/AxxTfDBOnZkI4wVFlOID3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8727
X-OriginatorOrg: intel.com



On 21/08/2024 1:54 pm, Haitao Huang wrote:
> sgx_reclaim_direct() was introduced to preemptively reclaim some pages
> as the best effort to avoid on-demand reclamation that can stall forward
> progress in some situations, e.g., allocating pages to load previously
> reclaimed page to perform EDMM operations on [1].
> 
> Currently when the global usage is close to the capacity,
> sgx_reclaim_direct() makes one invocation to sgx_reclaim_pages_global()
> but does not guarantee there are free pages available for later
> allocations to succeed. In other words, the only goal here is to reduce
> the chance of on-demand reclamation at allocation time. In cases of
> allocation failure, the caller, the EDMM ioctl()'s, would return -EAGAIN
> to user space and let the user space to decide whether to retry or not.
> 
> With EPC cgroups enabled, usage of a cgroup can also reach its limit
> (usually much lower than capacity) and trigger per-cgroup reclamation.
> Implement a similar strategy to reduce the chance of on-demand
> per-cgroup reclamation for this use case.

I wish there's some explanation about why we don't just try to bring 
down the usage to limit here, but I guess that's OK since what we do is 
just _trying_ to increase the success rate of the later EPC allocation.

Also, when this is invoked, it should be very rare that the limit is way 
lower than the usage, so ...

> 
> Create a wrapper, sgx_cgroup_reclaim_direct(), to perform a preemptive
> reclamation at cgroup level, and have sgx_reclaim_direct() call it when
> EPC cgroup is enabled.
> 
> [1] https://lore.kernel.org/all/a0d8f037c4a075d56bf79f432438412985f7ff7a.1652137848.git.reinette.chatre@intel.com/T/#u
> 
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>

... feel free to add:

Reviewed-by: Kai Huang <kai.huang@intel.com>

> ---
>   arch/x86/kernel/cpu/sgx/epc_cgroup.c | 15 +++++++++++++++
>   arch/x86/kernel/cpu/sgx/epc_cgroup.h |  3 +++
>   arch/x86/kernel/cpu/sgx/main.c       |  4 ++++
>   3 files changed, 22 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> index 23a61689e0d9..b7d60b2d878d 100644
> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
> @@ -252,6 +252,21 @@ void sgx_cgroup_reclaim_pages_global(struct mm_struct *charge_mm)
>   	sgx_cgroup_reclaim_pages(&sgx_cg_root, charge_mm, SGX_NR_TO_SCAN);
>   }
>   
> +/**
> + * sgx_cgroup_reclaim_direct() - Preemptive reclamation.
> + *
> + * Scan and attempt to reclaim %SGX_NR_TO_SCAN as best effort to allow caller
> + * make quick progress.
> + */

Nit:

I don't think this is to allow the "caller" to make quick(er) progress?

I should be making the "later EPC allocation" quicker?

> +void sgx_cgroup_reclaim_direct(void)
> +{
> +	struct sgx_cgroup *sgx_cg = sgx_get_current_cg();
> +
> +	if (sgx_cgroup_should_reclaim(sgx_cg))
> +		sgx_cgroup_reclaim_pages(sgx_cg, current->mm, SGX_NR_TO_SCAN);
> +	sgx_put_cg(sgx_cg);
> +}
> +
>   /*
>    * Asynchronous work flow to reclaim pages from the cgroup when the cgroup is
>    * at/near its maximum capacity.
> diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
> index c0390111e28c..cf2b946d993e 100644
> --- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
> +++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
> @@ -38,6 +38,8 @@ static inline void __init sgx_cgroup_register(void) { }
>   
>   static inline void sgx_cgroup_reclaim_pages_global(struct mm_struct *charge_mm) { }
>   
> +static inline void sgx_cgroup_reclaim_direct(void) { }
> +
>   #else /* CONFIG_CGROUP_MISC */
>   
>   struct sgx_cgroup {
> @@ -90,6 +92,7 @@ static inline void sgx_put_cg(struct sgx_cgroup *sgx_cg)
>   int sgx_cgroup_try_charge(struct sgx_cgroup *sgx_cg, enum sgx_reclaim reclaim);
>   void sgx_cgroup_uncharge(struct sgx_cgroup *sgx_cg);
>   void sgx_cgroup_reclaim_pages_global(struct mm_struct *charge_mm);
> +void sgx_cgroup_reclaim_direct(void);
>   int __init sgx_cgroup_init(void);
>   void __init sgx_cgroup_register(void);
>   void __init sgx_cgroup_deinit(void);
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index d00cb012838b..9a8f91ebd21b 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -428,6 +428,10 @@ static void sgx_reclaim_pages_global(struct mm_struct *charge_mm)
>    */
>   void sgx_reclaim_direct(void)
>   {
> +	/* Reduce chance of per-cgroup reclamation for later allocation */
> +	sgx_cgroup_reclaim_direct();

See.  It says "for later allocation" here.

