Return-Path: <cgroups+bounces-2258-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7FF893968
	for <lists+cgroups@lfdr.de>; Mon,  1 Apr 2024 11:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34821F211DA
	for <lists+cgroups@lfdr.de>; Mon,  1 Apr 2024 09:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8DF13AD9;
	Mon,  1 Apr 2024 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZAHgKEZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FF4DDD9;
	Mon,  1 Apr 2024 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711963793; cv=fail; b=cUT1SJMV//RhlGyp93Q9caBuFZWARtpSM7IYSh4gGVUNUbm5jD/xIzOX24efSiPOe8V5TypA48DJHz8cG+YMW3phLbYbGwRBcHI8csi2rWabwHFOJVtTjKoreWdFcG5fnimJPCQh/H3ZHrCksjxIpCbbiRq8HJo2ivpdRdMGpjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711963793; c=relaxed/simple;
	bh=MUlOfCSd+sEUcOS11Nj/4jjQ91C9SId+O1EQ2ACjogk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cmcDZ9YBV1oYsXNkCv1LRg3ePjscsMYIKDXb9gm1n84ZVjGieRUABVMIIFXY55ZQLbGRXEXLoUjAmu7GXsEKLXqydnbRXtp3LP3DWIaEUflpkrCcraLjMKoVsb2Ow8Ovyj/RaljgZSuzjwgogNb3N4GsYoalTjmTzMq1VpCiGAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZAHgKEZ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711963791; x=1743499791;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MUlOfCSd+sEUcOS11Nj/4jjQ91C9SId+O1EQ2ACjogk=;
  b=DZAHgKEZSAw+6WOSTGSt9A61QvqBPpE1SoBifSPfAayxRXyd/zhbN1dy
   B3HTlDfNGaxkRyJd+gvAFEbxlF5mXbJYn+f9/iRaQKOMDFZHuox78vs0i
   +KTr6UcThredcbbV2CdN8aCi/OHRyKbtQUgDNDWV7VExgHqTvC3x/+IV9
   CGUn84K74Kjr8b3Ey5amANq6aVb8OBj34P7ZwHHXdjW+3Oq88XZTLuR2F
   C3eBRdj7h4RHkbL98NSlDnbxGj3IifByic3+CeWjQm23Pvl3Wp2lx63Fb
   voAjNfM6lkrKXwopFs2TazEkurwnJqaIcaIbzajIcsG2QlAhfHlYs0qTs
   Q==;
X-CSE-ConnectionGUID: nS7mjBjtT3mdskEIZCZTpg==
X-CSE-MsgGUID: BZMfFIDlQI6bqtvH9m2KMA==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="6918187"
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="6918187"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 02:29:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="55141560"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 02:29:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 02:29:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 02:29:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 02:29:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 02:29:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=es0GU+PmScWHgrnnFAj4rnlFGybfQtJh0BrF6Z/dDZpLX3sq9k7mqe6w3OQ4eC78Q3nOzIaJuyitFlmU37dxtur1pjayLlqGffb0Q0TMMFCf13bfXzMItaC/ntxNbIRIbLTIETosisWHd7+3DEzZKAMiVOK+o1B+9ErjHS6CA1Rh90oi8Y5aqJSRCzP6gVZGzaec5pjOXz4PwCT/mslnL4/HVvc6BleFNZ1zDAVqHH9MZbNVmTnettIcK2AaYmZYPaEQCt9G8q3L16r8A9ls7Jmj0Qv2sYfnE3MmdML3HuUKAymh0Sq7a0X1CCubd2l8CNkkfc+zz7xlyLVKur4Wxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUlOfCSd+sEUcOS11Nj/4jjQ91C9SId+O1EQ2ACjogk=;
 b=k6E4JauMYFuHlmxI1Td8XqBBT5pZqgYXGlfsiNaxcHDI4fqwMEKDMKEvXMNb76hRhSR0QqHN+2/bqcgbcUZAS1BgcOskTDzVHMXZid7j7W90jc1wZp1y0DYi0l0SCuUfkPh2lJR0YaCdxYj/kGaCWmxeEuG2z8KH/7I/jP5PDQEPIeV9A42plRCNkkyaEyzzsA2swZx4noJqh+P3gzp3MhAhxz4J9A4KFiRzEgHvVsc7/Fz9WbiMVqXaRkaE3+th7r1val/F3q+bhQ5ziOUHg+aM/BZNKF1RqLInF22X4sPI0y4qZiHQk/Q4RTsi4N2iNAP5guVy9iiEj/2xOnDpqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA1PR11MB5828.namprd11.prod.outlook.com (2603:10b6:806:237::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Mon, 1 Apr
 2024 09:29:06 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.019; Mon, 1 Apr 2024
 09:29:06 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "mingo@redhat.com" <mingo@redhat.com>, "jarkko@kernel.org"
	<jarkko@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mkoutny@suse.com" <mkoutny@suse.com>, "haitao.huang@linux.intel.com"
	<haitao.huang@linux.intel.com>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "tj@kernel.org" <tj@kernel.org>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"bp@alien8.de" <bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v10 05/14] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Topic: [PATCH v10 05/14] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Index: AQHagKYLsFT4s142u0e+3dOpqX6L9LFNHJ0AgAMJvQCAAwZqAA==
Date: Mon, 1 Apr 2024 09:29:05 +0000
Message-ID: <5a5dee86713a2852fc2c1ebef28ae08927d2c95f.camel@intel.com>
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
	 <20240328002229.30264-6-haitao.huang@linux.intel.com>
	 <89b4e053db21c31859cf2572428fd9d4ab4475ab.camel@intel.com>
	 <D071JQZYBH2W.399N43JS6GY6Z@kernel.org>
In-Reply-To: <D071JQZYBH2W.399N43JS6GY6Z@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA1PR11MB5828:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: shhxkFy9fnedjndye70QqRg4eFtb52CUhn5MwmnyMX4uFGrORwgD1/s+AQ/UTPLVe5xaWjJq/N5dMDGp+pqb9+SVKiiCK90DNRxb6cwJrpe4ARakgncWHqZWEbf7B65UMdY50ttlLjz3bRrQYXrS2a9I1uhkVuHDXvadjFScmRcPj2PydmDRzsZO625FND0Y/S+n/DQ0CkNpgRCZUnz0QFGUZKqHVG9Q+BV3W005dJKPqlZYkSNPJtcDC/4FP+u9swlOMHqlmZHyBZjXgKLuooV/PUT/ChbgKn3ezK9/Bj5noKzqMxP2x/Fexkf6rRe+kQU28Ju6BlPXx0kP5Nj914eqUo28xuWlyNpeMZV+JG7UvvKlYMGYVENu9RHxQ1mBf5f2iWhgFBeiIWlvvta8CndulwSec6bexzM2qz179n8Q+GbI0rBIVAqCP/p+1T2696HkX5RuZce0JVXZV4OOHblC8WcMaSMT1n1lirChvnZ47K6iBtsgimNKWz6qFwYw/06l5G6SLS42X51YI4xNz3RkbUPCbdD/4J/CBQmZGzHQ7gKBUuzBdWnVEDaMdn2bmtuhERZ/4tyFRZm2Zd5QA9C+oCuBi8jsKFR7g1zevYC9wXOzmrTRCp/C5p2P0tOr2Rop/rMQaDSgkmXkmNr2Dk+ZnSjz8uYSmouLG79namX1G3/kSoJt0YdprmhS81z4QZRgwZOOlrz18UEBCcxzGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1B0VStyWFM0dWs4dzdCblpvRU9BZUx3TWhGSXY1SVRGV1pYMnlzTmFZM3ZU?=
 =?utf-8?B?NEhKVHh2UVRsQS94NkF2eHhMZ3R3bkI4TlpGaityNktyaVFqeG1EcHhTU3FW?=
 =?utf-8?B?QnZTeXc1SkJWV2xpQ2VSKzViR1VDOHAzcG1FM1BISUJLZkxYL2V6dWpCdXZz?=
 =?utf-8?B?cmFTSmZMemM5NUV1VkhJMkNvc0twS1M3Rk9tUXkvY1B3NmRHNHFMd3VPd1l6?=
 =?utf-8?B?SXdrSHBWWUdGbG9zUERyekpYV1F4VC9QVWNHRW5wZjAwc3hObEppSmd0Z1Mx?=
 =?utf-8?B?WWpEWnpnYlM0MWZOUmxYS0NCOENkY1ZDRElUeFpYcW5WbHVxUUEwVjdGUXdW?=
 =?utf-8?B?WVo0WXNvUUhydkF5Skxnd090Q2NGZDdyY2p1ZWJqKzYvTlRmSG1jMnQxWXBx?=
 =?utf-8?B?OSs0TlBPdjA0SWNxOUd5UVBPM0dHcW84Q3NGQm04U20vNGwvaXAweFp6RGw2?=
 =?utf-8?B?dDd1L0U1ckhpdENlN3dXYUh2MWFPSVFUZ0VOQ2JudmVFSWFVaWc1cDJxQ2xR?=
 =?utf-8?B?akRtdHM2TlFUZWNHRnNKTWpkeFUvRTZpQWFGaFlyWGZtL3ZaWldXcGVya1c3?=
 =?utf-8?B?MTdxaGsrZjJTNzQxTVRQRlBWaFpuZGtETmxiWEg2d0NaL3c3WFcxWUhYajdE?=
 =?utf-8?B?YWExdGRoeWh5TFpjOUc3T0ZhUURwMTNWVDFoMjBTVGR6T1lDeUppTnk4dE9H?=
 =?utf-8?B?ajlXbHoxVWViSHY0V0NYUjB0MzFMY3hadWVubFAzU1FzZm42b0E1ZytpbmVN?=
 =?utf-8?B?dFQzM0VxN3ptS2FQZUh3aWdvZEM1bVdGM1BuaW9QL0hUZlNkeGRPYjVLdnF5?=
 =?utf-8?B?K3M4Q0ZhMTU0MnlnZVp1YlFsSk5pckRjaTJYdTJQbXdwM0xCQ0Q2Zm42N3M4?=
 =?utf-8?B?dldQTjNSTFpQZzZjeWlHTFlHRjNmT2RBR0FXMEVFRThBVmtoMlYzajg5dVRZ?=
 =?utf-8?B?NVJRRkxjNjZuc1FadUd6MHlIK0JKZTZaUjRhb0hscm5PMVBhRjhRNUhuM1V3?=
 =?utf-8?B?akhsODBhaFRjNnc0T1dHT1BpSDVXbko0MjY0dURONUVUZkxKUHhGVU9ISUhI?=
 =?utf-8?B?clhDK2pCT0lkYndrNi93WDVwOEpONWljWk1DOGYwNzJiRlprUmtqbXZBc1Vr?=
 =?utf-8?B?WUplc3VIdy84NkxyTmVtNkk5c2IxdnFuT1I4ZlhaWmk0MWpoWlRES3ZvZnhO?=
 =?utf-8?B?NjhrdWwybFVxcTB0Q2NHR2ZFOC9HOHRhWHBCdm94T0JyM21sbUhHaUhabTly?=
 =?utf-8?B?UHE3Y3lHa0xUWDZrdytSYzhsWVhrWG90dlV5S2UzQnRyODhkNCtDSnBRNG5R?=
 =?utf-8?B?Nk8wNEs2cVJYWEZ1cnd2RlBpbTJNOGdiR0MwNGk0a1RkTGJqRDNlS0pUY2xQ?=
 =?utf-8?B?N0tJOVBBQmxYOG55SXFrdWJ2a3J4STVZQWZ2ajNlYmVlNHErdTh0WmNaYVkv?=
 =?utf-8?B?NENjaU5DQkJMS0ZvN1lnNy83SFBNSUNPRVhyWnRoVHloWm01NzEzVmlNTjVJ?=
 =?utf-8?B?MUwwejR6RVlmR3ZwQ0RZRXdOcmRNa2NXbGlyZXZ1UytOT3NKckY5bUI1MFNi?=
 =?utf-8?B?Si90bWYzaUJweUxBMWhseHI1dVBpOWUwYWhHUk0wMytpZHVBWit0Q1dyNWpT?=
 =?utf-8?B?dFdCRHdmRmpOMVl3MURYMFV3TmxyY21xY0twN2pEbFliUml4Y3ZMVmxEb0hi?=
 =?utf-8?B?aUx6Z2JUTnp4WXh1YnlmYkpaZ21MbHZMdW1uK1ZVSVcyRHN5SUFYRW50QmN5?=
 =?utf-8?B?VDdxbVRuWWRtcS9qRzVoTmtyZzVPcmlCV1RVT21JR2xDdFlNczg4ckdXelMv?=
 =?utf-8?B?ZWxxVGlMK1k1dksvOXFhWHNGaDlhdU1tTC9lSHc0eTkzcmkvRWtlVnNzbE94?=
 =?utf-8?B?Z0pxNlNzZXNjNTFjWmFCWWV0KzdKWDBucG5RQzBrYlp2c01JbWV5Z2xYUHlp?=
 =?utf-8?B?SGhxalV5SGRmcXNuZGwzbFBWQWsyMzBiZU0rTFI3TXROQTREUjZxWEw2dU9h?=
 =?utf-8?B?VHpTTFBpVEl5K2JkRXZRK0ZUU0kvZGwzZGlaREkzUm82RlBQeWQwN0IxR2JE?=
 =?utf-8?B?a3hBbHZSUWd6NFoyTXRwNGkrdUhQQitJVWIxV1ZjKzFSSzE2L1o3TmVlK25m?=
 =?utf-8?B?TDUxa2pJeTJlV1lHQytWYmhZRXQ3TlhqUTVvdjA0cUNFYlgwc3Q1T3hFSElM?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <300DCF99415AEA499A802E88A1C21C13@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d8fda6-681d-4fcf-9126-08dc522e2d32
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 09:29:05.9457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +BeawhGC4/n4UWeUBQvstM3gBHHgc/mvDOqtN26K/JUCETw6Tv6dP03HcanVyR+MC06w6O2/jB8vsXr/sUjmEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5828
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI0LTAzLTMwIGF0IDEzOjE3ICswMjAwLCBKYXJra28gU2Fra2luZW4gd3JvdGU6
DQo+IE9uIFRodSBNYXIgMjgsIDIwMjQgYXQgMjo1MyBQTSBFRVQsIEh1YW5nLCBLYWkgd3JvdGU6
DQo+ID4gDQo+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwv
Y3B1L3NneC9lcGNfY2dyb3VwLmMNCj4gPiA+IEBAIC0wLDAgKzEsNzQgQEANCj4gPiA+ICsvLyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+ID4gKy8vIENvcHlyaWdodChjKSAy
MDIyIEludGVsIENvcnBvcmF0aW9uLg0KPiA+IA0KPiA+IEl0J3MgMjAyNCBub3cuDQo+ID4gDQo+
ID4gQW5kIGxvb2tzIHlvdSBuZWVkIHRvIHVzZSBDIHN0eWxlIGNvbW1lbnQgZm9yIC8qIENvcHly
aWdodCAuLi4gKi8sIGFmdGVyIGxvb2tpbmcNCj4gPiBhdCBzb21lIG90aGVyIEMgZmlsZXMuDQo+
IA0KPiBUbyBiZSBmYWlyLCB0aGlzIGhhcHBlbnMgKmFsbCB0aGUgdGltZSogdG8gZXZlcnlvbmUg
Oi0pDQo+IA0KPiBJJ3ZlIHByb3Bvc2VkIHRoaXMgZmV3IHRpbWVzIGluIFNHWCBjb250ZXh0IGFu
ZCBnb2luZyB0byBzYXkgaXQgbm93Lg0KPiBHaXZlbiB0aGUgbmF0dXJlIG9mIEdpdCBjb3B5cmln
aHRzIHdvdWxkIGFueXdheSBuZWVkIHRvIGJlIHNvcnRlZCBieQ0KPiB0aGUgR2l0IGxvZyBub3Qg
cG9zc2libHkgaW5jb3JyZWN0IGNvcHlyaWdodCBwbGF0dGVycyBpbiB0aGUgaGVhZGVyDQo+IGFu
ZCBzb3VyY2UgZmlsZXMuDQo+IA0KDQpTdXJlIGZpbmUgdG8gbWUgZWl0aGVyIHdheS4gIFRoYW5r
cyBmb3IgcG9pbnRpbmcgb3V0Lg0KDQpJIGhhdmUgc29tZSB2YWd1ZSBtZW1vcnkgdGhhdCB3ZSBz
aG91bGQgdXBkYXRlIHRoZSB5ZWFyIGJ1dCBJIGd1ZXNzIEkgd2FzIHdyb25nLg0K

