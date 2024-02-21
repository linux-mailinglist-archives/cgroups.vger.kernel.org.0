Return-Path: <cgroups+bounces-1734-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6573985D70C
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 12:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E4F1C22F2A
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 11:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A233FE28;
	Wed, 21 Feb 2024 11:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPAkbnPW"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CEE3DB86;
	Wed, 21 Feb 2024 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515280; cv=fail; b=mJHEZMeMIhdRgcvrfNR4vzb9s9mTQegEx01oh78a508XcbOVaVgQ1HaHcZAWJsyRawxUSCK1KwoZ+023TgmLZnI8qk+LNxlziVz650zUqYJE30bGKWlG17E9gRlQGj42ZBOZsl8rPZ4XezCuORk4yYON9TZXDqm+lh+2mL+oN/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515280; c=relaxed/simple;
	bh=OrmREsU0pnEZN+yqKfyF+6AIOtmXUHv9qf4+J4v2nwA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KG43jxmGndc0yN6/70VuWdwo9bdm0M2VTczuOI5f+VK5OwI/1hzSJ3HDYCtY88LptLszkUXEqBqH7VmAVgoBW4+Hb8PlPEu8n9wRXTwRBFrzwvYVkoBFsGnzFgxuHqSY4xgqdv+rNeTf9aYnIgJOVUqkVa/UfR2mB68NRsrdsPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPAkbnPW; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708515278; x=1740051278;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OrmREsU0pnEZN+yqKfyF+6AIOtmXUHv9qf4+J4v2nwA=;
  b=OPAkbnPWx7F4UBVYG4hFzY6TN6MmchUgUEuOI4rW3A+dTZ5m2D3FYkJc
   tgvrrrebUUoYvRHVf6907a693HCXpxJRVHxRAZQQf39WR0eKkdsM/nzyq
   zul13wpo/bQ72N8cqUcnC+u6ca+q5lEiFhLYW7DbiEaA1BaeL1SfhiEYv
   WEpFwQLK2g6HV6l9iUHKxl9a/cQR3vYwnh8e4yaec6s7l0etZU7JYwMbF
   Qpk679RYj6y1mDReLM+cVSP/0LKZiRv4Bz2H/pZkbB9DfRLqNU2OxSwKS
   wUoEEWGzdyh0v94sZbjdufmeLE6b6kp9y08qc44HPYBROKfFRVz++eCcT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="13790672"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="13790672"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 03:34:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="36143384"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 03:34:37 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 03:34:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 03:34:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 03:34:35 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 03:34:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsGeLG3etdJFC8XyVnvPrLBUYWx/plkrVyYIPww6HaReep6rY6OEEnq02/pcaSb6msbUVZQEmP23dEg1AkbTiKLUfexDHrWZ2Pd8X863XMsTdJIq3tztyVXMcjapAObuBqgfTiIgTG5ZqHCfDkOoLdVZXk4WrXjBycbWxwW7jij6aRKiSjhvOf6FBgFObnqZ6uWXy/wp9iAQ0+1z3CxHB97R/Sbeb5UWwvO6hg8GFkKiRqm7FH6r8Zao/w8sJRZjThD5nvKdOMpYaw3FHCZEJ9x6uyuqhwpiW/z4oBdHSLWGOeCw2+LbipASYrK89ntRII8alAEKM98bRiXW1BJ/ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrmREsU0pnEZN+yqKfyF+6AIOtmXUHv9qf4+J4v2nwA=;
 b=LaXvoGffe5GV7/lrbS7p07VpSQ4LL7XaWQAIVx4z2NxiovwZWHKCoFg8GQbeYWLwMvSI+qGuF8PC10T92xaMVpkivxi6qaiaEQ4NwmO8KdRGx+UM1QyqO7r6ctpcfJ6ZX9Wsv6gfOgqiPmrMk7N2KC5fK4BiPzGQxv14B+DxTjfTJkeDlg7nSnTdnkahxY1AGdwbOQcQh9v9FVAxQ5VBsTYriOUQNlInPVz/whQbBNNSE+M3WDnQsi66ZWzezr+36MmMyNL8lkRBzB/9nsUa5aBWK9O6GME82cBQL3Q4WtWMJ9yxryGSuq4RVE8FpOl65eNgYFlq2XkFv0dqfFm2sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB8138.namprd11.prod.outlook.com (2603:10b6:610:158::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Wed, 21 Feb
 2024 11:34:28 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab%6]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 11:34:27 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "hpa@zytor.com" <hpa@zytor.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "haitao.huang@linux.intel.com"
	<haitao.huang@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"tj@kernel.org" <tj@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v9 11/15] x86/sgx: Abstract check for global reclaimable
 pages
Thread-Topic: [PATCH v9 11/15] x86/sgx: Abstract check for global reclaimable
 pages
Thread-Index: AQHaWH7maRXdElt9O06f37NvTi3kA7EUwtmA
Date: Wed, 21 Feb 2024 11:34:27 +0000
Message-ID: <236bc3fde058d70da93830dda917bfa734134dca.camel@intel.com>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
	 <20240205210638.157741-12-haitao.huang@linux.intel.com>
In-Reply-To: <20240205210638.157741-12-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH3PR11MB8138:EE_
x-ms-office365-filtering-correlation-id: e0c53cce-46e7-4568-63e5-08dc32d11016
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jjDaSiqy6aRu160OwV2VbMDkjKrEhFsCrrNl18HI5GsSI7vcFXRsXaZ613VyRd9Vbv3ujyd/gzGkNvGzOsNqDOB+TKDtF4f5dMyllL413LiJjNmzIVQrOr9Ea/x+8xtQ0Ua1Ekw2ADnwrVFYW4Dd/L7UeUrjJF0xb5QE6j07p36SYqBN1dSaQ/ToUn05BHIe1nGti+FLYnmuKfOpj2HRvP0PEQqnCroqMwhHnhHKLfQDXhFzJau75GuW/sY4ah4AYYk3l+aEl53ctCThdF/9L42Bhe1jUqhQKGdcNv4qFZSHkx6wuu0TQNJT+QTiEbMG/amwbFn+jLkJCK9ryDuqeIg57yO0HEph42kuE+vuLfvmUDZkOlryaThHviSO49jTkni4XhW/99xkf6+nRMaBdckkXzZR8D0bbg9R5/wbrr8Kpdzdw3VrvfgOlAIOa/68Hvnvto41drhMrelD8mXtWUJbx8wBxU3O+Y1vot9zCOkG1ZIiatl6XkxMu6L+z6We5FSFVfK8L1QzZ5IgrHw8y6N+GVpfP4mAPKZ+sOSUXMfO6pMYWAxWDKKrI9G2mr+Zqf20WWglgKbtQhAKd+kEPwp6wwQ9xMofRsqLGtxcHyxX4NxCpufLcRBVIgYhynCRU+GmZFqCpAiZmEREwiXuDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1VWRUY1SlAwOU5tR3pDdkI4YUNseHhkU3p4bWhLZDRjOHNCNnVCS0lzc3Yw?=
 =?utf-8?B?ZktiYmlxdlAza09uZEJURG5acGdMVi9jczhwZTNteEM3eGoxeUY2a01hcVdm?=
 =?utf-8?B?ZjhQR3RNQ2FWV3lDa1d0Y21ncUtvK0RvUUsyU2pLclNLdmZjZUcxV2ZWQmda?=
 =?utf-8?B?L0w1dXNNeGtuWCtTNUVXb1M2QSsxaHNzQ1doZ2VPUkhrYi9SZ0liakYyNDdt?=
 =?utf-8?B?UFZTQmkxTGhpR1Q2TGVFWGNpZzA4dU9UTk1CclMwNkh1ekk1d2N1d3RtQUFR?=
 =?utf-8?B?RXpTZTViNDJlWGhxeHQ3VCtTcUdlOFhxNzZxaU50eVk0NkI1VitBWUFuV21O?=
 =?utf-8?B?aDRRdGF1b3l3dEpXREhzdTZpUkxXMTZ1KzFGQldCMUZZQktuN2dXUVdXT0Nl?=
 =?utf-8?B?UFQ3LzBIVU1PbWVuaXMwakVtM2tITEpjeGZveXNkWUhKQTkxMGNWZkt6bGxU?=
 =?utf-8?B?T293d3BsdWV6V2k5QWk1OE5RWno1Z3dMV2dCZVNPb3dDTjI1aGRzNEhIVUlu?=
 =?utf-8?B?Y1hPdklHeEJSUFZVV1FGSTZmNHREYmQ2N29SZVVkR3lqVWtITjd5VDZjSk5U?=
 =?utf-8?B?dURqeGN6d3FRcis5TG5YQVBLeFpLVVZoOTE1bHdIaE1tSSt2OFhKOXh0a2FQ?=
 =?utf-8?B?Y0c0bmxhaEp2c3hJZVhvbG1HdTVud2xINTc3Qy83MzF2TUZTaHVHeDl2SjVZ?=
 =?utf-8?B?YzlSbmhySkFxNGowcXp6dHFqZlAyNVhYdlY1eXAxRlZDNlZsTkRMZFgwRWMz?=
 =?utf-8?B?ZVVOVVg0NzhDNHQ1emhmNGFIa0F4bm5YMGtoRks4K2NSbUdtREEvdmVxazlI?=
 =?utf-8?B?TDQ0dFhWaW9qa0VLejFBTDhzVkU1Vkk4QnN5emNyS2VpcUJHOEp0QlVBN0lk?=
 =?utf-8?B?Wm1pSnRsQmdzckVFZmhXYTlNS3ZtblIzZjhwNFlFWHV4MU1LVHhocEtHZi8z?=
 =?utf-8?B?UE10MFFYWnJ5eW1XZ1UraUlwRTdiV0NVaUR6M0Z0dEVsbGpZaU0rYnpPc2VU?=
 =?utf-8?B?ZUttOGJqbXIvWVBJdE12eXdHckdSK2tZTFlnV3ZKbVpENUpEckxRd0V0SG5Q?=
 =?utf-8?B?NEFtR1J0VFlCSGxwRURFZ1NhQ21rNU5iK3AyL3V2WjJUcWJFQktwWG9BWUZy?=
 =?utf-8?B?RWk3MzU4Y2RJN2FNaTQ2OFNNMm9Ub1hZd015OE5POUF1ZnJmK0xnRW8zbnRu?=
 =?utf-8?B?clFiSjRlMno1bjhCWjdlNXIvWFRkcjBVa0h5NWRXYVd5K0s1MHhGRFZzMTd0?=
 =?utf-8?B?TnFlNU9rRytmNmkwUU45V1NpZG4vajFxN3c5bnpTOXZDV0FwVmliYmJ4cFpX?=
 =?utf-8?B?ZDYvaHBoVlhQRWpCTndCWTh6a1FpQ2RVcXBqOVcrK2hqWG80RWtJMjVrb1pG?=
 =?utf-8?B?N0UzVHhtd2dnbkpvQW9tV1E5UW5YbTRqaXZpOGxTLzI5bmlXbEhxZkdMRUtP?=
 =?utf-8?B?Ylc3RzI1RThBWlphb3ZWaGEvMXlFM3ZDUVg0NFJHYm1Md2FxYTRvR3R3ZXp1?=
 =?utf-8?B?RFN3WVhRTTQybmhCOWZIT0wwSTU5TjFYalFON0IxMHpKQ0h1TzU3d25Vb2xG?=
 =?utf-8?B?YjRHU1hhODJLMVk1QlZQSWxRa3RJZW1nV3VnZDN1V3o1bExiUURBcW1LSjdv?=
 =?utf-8?B?NGtmam5NOGJRbzVCRVdBUXo3Mzg1Z0lub2hCZ1VPZy9hVnZHQWxtQmxNSmlz?=
 =?utf-8?B?MG4rRDhJT3BJRy9OVFV4ejRQcjF4VmtmRGNSYmJrcWQ4QlpOK2w0WnNhZVl4?=
 =?utf-8?B?UVYvNWdzaFlobWtjRWVkZGhSWDdqa0kvTjMwZFBuQ0V3TmdsaDdZNmoxRTBH?=
 =?utf-8?B?Y3RpSUp5ejlZV0wxUkNoT3d1dmVvc1I0RVk5cVFYZENaMzFndVY4MjBlQ3RX?=
 =?utf-8?B?RFNJUHNkSVM0ekRkVEJUMWF1L1ByVTBoTkJCN2wxUlk4cTZjcDMzdzRLNlBh?=
 =?utf-8?B?U1dwT3hzSjRwakdvS3FjR1UzcWVoYjJEcUhZcHdMSjY4RTdYbWhyTW55c2Fo?=
 =?utf-8?B?TXNpTndObHo1b1FhMXVCRVNLWXFBY2lnNVVMSUtlS1pVZ29FRm43YTViclc4?=
 =?utf-8?B?QnloSXNBZzdodVBTMzhDeXQ4VWdOY2VNR3FBRkZQSnJTR29WL21nK2ZEZDdv?=
 =?utf-8?B?aWxubUMvdzZaNmtDOWVIWm9vNm1XdEs4TlBOS3pWd2t3bkppeS9KdnQyMlFO?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D6258200097B449B218B27A31796FB7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c53cce-46e7-4568-63e5-08dc32d11016
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 11:34:27.8953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0RZyjjVUAkXEMCbtCiFYW+4Mzb3PiaQm/j+tHtneWdj4q/HnkOB+HKrfXOaTbnnYhafcJ85cBOQAZ0VbOdTfag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8138
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTAyLTA1IGF0IDEzOjA2IC0wODAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEZyb206IEtyaXN0ZW4gQ2FybHNvbiBBY2NhcmRpIDxrcmlzdGVuQGxpbnV4LmludGVsLmNvbT4N
Cj4gDQo+IFRvIGRldGVybWluZSBpZiBhbnkgcGFnZSBhdmFpbGFibGUgZm9yIHJlY2xhbWF0aW9u
IGF0IHRoZSBnbG9iYWwgbGV2ZWwsDQo+IG9ubHkgY2hlY2tpbmcgZm9yIGVtcHRpbmVzcyBvZiB0
aGUgZ2xvYmFsIExSVSBpcyBub3QgYWRlcXVhdGUgd2hlbiBwYWdlcw0KPiBhcmUgdHJhY2tlZCBp
biBtdWx0aXBsZSBMUlVzLCBvbmUgcGVyIGNncm91cC4gRm9yIHRoaXMgcHVycG9zZSwgY3JlYXRl
IGENCj4gbmV3IGhlbHBlciwgc2d4X2Nhbl9yZWNsYWltKCksIGN1cnJlbnRseSBvbmx5IGNoZWNr
cyB0aGUgZ2xvYmFsIExSVSwNCj4gbGF0ZXIgd2lsbCBjaGVjayBlbXB0aW5lc3Mgb2YgTFJVcyBv
ZiBhbGwgY2dyb3VwcyB3aGVuIHBlci1jZ3JvdXANCj4gdHJhY2tpbmcgaXMgdHVybmVkIG9uLiBS
ZXBsYWNlIGFsbCB0aGUgY2hlY2tzIG9mIHRoZSBnbG9iYWwgTFJVLA0KPiBsaXN0X2VtcHR5KCZz
Z3hfZ2xvYmFsX2xydS5yZWNsYWltYWJsZSksIHdpdGggY2FsbHMgdG8NCj4gc2d4X2Nhbl9yZWNs
YWltKCkuDQo+IA0KPiBDby1kZXZlbG9wZWQtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW4u
ai5jaHJpc3RvcGhlcnNvbkBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQ2hyaXN0
b3BoZXJzb24gPHNlYW4uai5jaHJpc3RvcGhlcnNvbkBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IEtyaXN0ZW4gQ2FybHNvbiBBY2NhcmRpIDxrcmlzdGVuQGxpbnV4LmludGVsLmNvbT4NCj4g
Q28tZGV2ZWxvcGVkLWJ5OiBIYWl0YW8gSHVhbmcgPGhhaXRhby5odWFuZ0BsaW51eC5pbnRlbC5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IEhhaXRhbyBIdWFuZyA8aGFpdGFvLmh1YW5nQGxpbnV4Lmlu
dGVsLmNvbT4NCj4gLS0tDQo+IHY3Og0KPiAtIFNwbGl0IHRoaXMgb3V0IGZyb20gdGhlIGJpZyBw
YXRjaCwgIzEwIGluIFY2LiAoRGF2ZSwgS2FpKQ0KPiAtLS0NCj4gIGFyY2gveDg2L2tlcm5lbC9j
cHUvc2d4L21haW4uYyB8IDkgKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5l
bC9jcHUvc2d4L21haW4uYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L21haW4uYw0KPiBpbmRl
eCAyMjc5YWU5Njc3MDcuLjZiMGMyNmNhYzYyMSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2Vy
bmVsL2NwdS9zZ3gvbWFpbi5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L21haW4u
Yw0KPiBAQCAtMzcsNiArMzcsMTEgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3Qgc2d4X2VwY19scnVf
bGlzdCAqc2d4X2xydV9saXN0KHN0cnVjdCBzZ3hfZXBjX3BhZ2UgKmVwY19wYWcNCj4gIAlyZXR1
cm4gJnNneF9nbG9iYWxfbHJ1Ow0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgaW5saW5lIGJvb2wgc2d4
X2Nhbl9yZWNsYWltKHZvaWQpDQo+ICt7DQo+ICsJcmV0dXJuICFsaXN0X2VtcHR5KCZzZ3hfZ2xv
YmFsX2xydS5yZWNsYWltYWJsZSk7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBhdG9taWNfbG9uZ190
IHNneF9ucl9mcmVlX3BhZ2VzID0gQVRPTUlDX0xPTkdfSU5JVCgwKTsNCj4gIA0KPiAgLyogTm9k
ZXMgd2l0aCBvbmUgb3IgbW9yZSBFUEMgc2VjdGlvbnMuICovDQo+IEBAIC0zOTgsNyArNDAzLDcg
QEAgdW5zaWduZWQgaW50IHNneF9yZWNsYWltX3BhZ2VzKHN0cnVjdCBzZ3hfZXBjX2xydV9saXN0
ICpscnUsIHVuc2lnbmVkIGludCAqbnJfdG8NCj4gIHN0YXRpYyBib29sIHNneF9zaG91bGRfcmVj
bGFpbSh1bnNpZ25lZCBsb25nIHdhdGVybWFyaykNCj4gIHsNCj4gIAlyZXR1cm4gYXRvbWljX2xv
bmdfcmVhZCgmc2d4X25yX2ZyZWVfcGFnZXMpIDwgd2F0ZXJtYXJrICYmDQo+IC0JICAgICAgICFs
aXN0X2VtcHR5KCZzZ3hfZ2xvYmFsX2xydS5yZWNsYWltYWJsZSk7DQo+ICsJCXNneF9jYW5fcmVj
bGFpbSgpOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBzZ3hfcmVjbGFpbV9wYWdlc19nbG9i
YWwoYm9vbCBpbmRpcmVjdCkNCj4gQEAgLTYwMSw3ICs2MDYsNyBAQCBzdHJ1Y3Qgc2d4X2VwY19w
YWdlICpzZ3hfYWxsb2NfZXBjX3BhZ2Uodm9pZCAqb3duZXIsIGJvb2wgcmVjbGFpbSkNCj4gIAkJ
CWJyZWFrOw0KPiAgCQl9DQo+ICANCj4gLQkJaWYgKGxpc3RfZW1wdHkoJnNneF9nbG9iYWxfbHJ1
LnJlY2xhaW1hYmxlKSkgew0KPiArCQlpZiAoIXNneF9jYW5fcmVjbGFpbSgpKSB7DQo+ICAJCQlw
YWdlID0gRVJSX1BUUigtRU5PTUVNKTsNCj4gIAkJCWJyZWFrOw0KPiAgCQl9DQoNClNlZW1zIGEg
YmFzaWMgZWxlbWVudGFsIGNoYW5nZS4gIFdoeSBkaWQgeW91IHB1dCB0aGlzIHBhdGNoIGF0IGFs
bW9zdCBlbmQgb2YNCnRoaXMgc2VyaWVzIGJ1dCBub3QgYXQgYW4gZWFybGllciBwbGFjZT8NCg0K
SSB0aGluayBvbmUgYWR2YW50YWdlIG9mIHB1dHRpbmcgZWxlbWVudGFsIGNoYW5nZXMgYXQgZWFy
bHkgcGxhY2UgaXMsIGlmIHRoZXJlJ3MNCmFueSBjb2RlIGNoYW5nZSByZWxhdGVkIHRvIHRoZXNl
ICh0aGUgY29kZSBjaGFuZ2VzIHNneF9nbG9iYWxfbHJ1IGluIHRoaXMgcGF0Y2gpDQppbiBhbnkg
bGF0ZXIgcGF0Y2gsIHRoZSB1cGRhdGVkIG9uZSBjYW4gYmUgdXNlZC4gIE90aGVyd2lzZSBpZiB5
b3UgZG8gZWxlbWVudGFsDQpjaGFuZ2UgYXQgbGF0ZXIgcGxhY2UsIHdoZW4geW91IHJlcGxhY2Ug
eW91IGhhdmUgdG8gcmVwbGFjZSBhbGwgdGhlIHBsYWNlcyB0aGF0DQp3ZXJlIG1vZGlmaWVkIGlu
IHByZXZpb3VzIHBhdGNoZXMuDQo=

