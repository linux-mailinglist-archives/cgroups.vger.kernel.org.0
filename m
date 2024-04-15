Return-Path: <cgroups+bounces-2485-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54BD8A5240
	for <lists+cgroups@lfdr.de>; Mon, 15 Apr 2024 15:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143631C212CC
	for <lists+cgroups@lfdr.de>; Mon, 15 Apr 2024 13:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0725745C0;
	Mon, 15 Apr 2024 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MT5SryFL"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8B7316E;
	Mon, 15 Apr 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189076; cv=fail; b=aVdSW6RRkIZ7EyVXpCGLoHB7oTjZPbYVFTgrmjWSO0NrANWd+a2QQjLSI2pMCbpcQ280CzWA/6Zj57B4SizkXgOTfzI9yxAEjyahcZNxgYe+lAuXTijVZ1KxA42qOYplSoTxG2w4vEqMEakb/tiFQcKoN4MHxgdL3WmeFoHziQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189076; c=relaxed/simple;
	bh=OxrRsYqhXOudAQ4KkvbKHwAq/JsoSCUphgHU3Peeux0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C2jxkTT8k55lZEN6dDU0hm1TjuCxJ1JyVcM3MyQT3Es2dmd/r9Mqg4PYOTpRZnuhQznj6IOu60FfTWDLLTyY8Uxu0JaD6oOTdqxpZ2CzH4ee8CF6J7KeGNS1qBZcIVwIlSzinbQ5mnGDukH5iXflEnUvzThtwRvsHDhfPDdR6TM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MT5SryFL; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713189075; x=1744725075;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OxrRsYqhXOudAQ4KkvbKHwAq/JsoSCUphgHU3Peeux0=;
  b=MT5SryFLFOd4XKsTL5iI7t82kXN5WG3n4G8a4pb+x2Bt1giPtmaGtQO+
   0qw4aFcOGd5bz6FzkBVGdzIUqtmFChM67rJdg/THLLwCFuY3aqV/gBJ1m
   nbzkDxvr9VCzFJgkiwyIF953qP+g3MOvhBlsT0r7YrsW7USy3Zoqpx7YI
   dgKtzbjgt7AzyK45/n/uTCGPHNbyJkEQl6/MW40jVfpy9wr8KqrgqoH0F
   8pRMB0D1STmbo7YAaZV6dnaiHd+wjEsf8fbHIYz1GPRv69mgB0j94IJkC
   RaHpUAvnIuicYAi9pdURESiYfTenoczU1C0yGxoPNwv4AzzSy7fTFxPG3
   g==;
X-CSE-ConnectionGUID: N+qaPLU6T1CRw/UqPMBiFg==
X-CSE-MsgGUID: 8S7YM5fLRbCXmqszA5C60w==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="20003690"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="20003690"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 06:51:14 -0700
X-CSE-ConnectionGUID: wKI0ijPGQimo2JYsUmZ1xg==
X-CSE-MsgGUID: QRnYIdKsSAqOO8lbZh4bVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="45222735"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 06:51:13 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 06:51:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 06:51:13 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 06:51:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4ADmAobdIeCG0nPw1y7IXRomZRIVRCIs9zLcDt/tbTlLfA5J4UtciAgATUtT2tRhI8qHH31uNLnq25mt5O3cLm8NV/9elPh3i2fbdKVUNhZotgcTOtEPBSRKcYX2e59/FJZZBoEvZHokLytu0aWSVoQYpSs7exLFc4zZh4fleFjxgkzZKOz9pmsmyq0XJrgsVpsOM3RAaD6t6QvCEeXYpYamBq2S/0l3AjlhLc73umQkZiUjam6XgXStcld41B8WnKsRdDhYZ7QdoHsHY2QZfdsjK7/yrD2ETxR4dkrPE/7vSd4wqquplgWilccSDhF4m6ayX9F+OA8+oBmUhLy4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxrRsYqhXOudAQ4KkvbKHwAq/JsoSCUphgHU3Peeux0=;
 b=RSTanOr1Y0rWJ+VZ3hBfx9EudLluIOojqGM0DBAddETmWyNzwvfYsbXNNn89oseNUMieXE6kFz4WShDbVBrdGDwu0P66PS61Vrz99/mEbYqROlQxm5X0uj0AZ5ZVVKaKeJGhf6iMNyVf2IVQB+Mo7JEgV1rtJwpjCuQYDC/4Y0d8isdBmLTOwBVxnJTkRKMRU/LRlEgH2u/Eynz3b3zScYLIkfgGY/EbpUCThrlRfdgOwNjRVYaED90vUK0CO9BR6bQtNYGkhp4t+1J65E49gXO9sYvViujNzhlxna477GNFV8Uv7qyq4CJm9WBB1x6UHyIlUE/ZkGL6vROt0USoJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CO1PR11MB5169.namprd11.prod.outlook.com (2603:10b6:303:95::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Mon, 15 Apr
 2024 13:51:10 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 13:51:09 +0000
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
Subject: Re: [PATCH v11 06/14] x86/sgx: Add sgx_epc_lru_list to encapsulate
 LRU list
Thread-Topic: [PATCH v11 06/14] x86/sgx: Add sgx_epc_lru_list to encapsulate
 LRU list
Thread-Index: AQHai3SM1zhSd2sg0E2ZXajiWAucX7FpYQEA
Date: Mon, 15 Apr 2024 13:51:09 +0000
Message-ID: <0121396cabd6f7c5304e5040892a5934a4f65b89.camel@intel.com>
References: <20240410182558.41467-1-haitao.huang@linux.intel.com>
	 <20240410182558.41467-7-haitao.huang@linux.intel.com>
In-Reply-To: <20240410182558.41467-7-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CO1PR11MB5169:EE_
x-ms-office365-filtering-correlation-id: aa351d13-386e-4a8c-4608-08dc5d531b2b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qfVq8KzmCQ2fXwn4k0C613j8qivthtzb5EQVCFPZXCGwqYqBdEuqUBISb29IDKLjEPnwuWw0oEl4rUgLBd71oTc6ZXJ2Yz8r4N3YoWCf/CiTW+aAYO5h/hAs2pMUXgYgopoRDN8fxX6Bi19vUkYOqSwVZgJdEmizOweQDZ7qZDvs4nmGfefcR7DkXg6stKq0dr0membYWFj47vbd7vKnd+FDYLe3UDkh+60qOMQk7/E2X6vPQY8g09dbQmbajS2mc3rjRl92DeY6hujpkpqDLHNNFyAUfmqeYtPdWA8Qc2n30gNa3fkc/N60ECGKgLkA2nW5I7355FGf8Jgm9cXJ3+ozgbKGJPRKXnSGEBmDA/vo5aZCC3kfLF3+QMpsQiEWAK6BiWIsEkkf2vRW6U2LwsyzdR23wnjHUlZVmpqjjSYj5o95dl8lhxYssQKo4xBgOkmgv0guMvtJiX7d8m11z71lTCpzepRR0KkubPrHJ3ifchtMR2W71r0B81xoV4LmTmbpfXb3CR+z9l/Uxw1kM54erNDnWj0La9KaocIghdiKvDLFnh282zgde/WqDu+8JlqMOsEJ3lK+4Fj4d2Q9wfi9q52GaYvGQUVNI83mKuS3CxUaKcJ7Tx9hlJSryZpyKI43t2mxtupGTEoeK3nUiEmQyUhJvksMIqlEitwX+rAZRT+F7j8Gd0T7fY91DrE+VNPRiaU6VFyw3Xy0uJP7eap/FgJb6xc/p6rtMHpbSeg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0phTHJRRTFRRFVSalhVWTVoVVFLZk83UVZLbG0wV0EwamFncHZXVmR3bWVU?=
 =?utf-8?B?d1JQQlBOcDd5RzRrRGNES0kxT25aM0ZMV3FPWG9TWCtqbFFjaU05NWZqUUpN?=
 =?utf-8?B?dFN1VHp2SDgwVzhNZ2l0NnNQSHh3R0FjbzJkQXZvYUcrdnUrOC84MldLQ1Mz?=
 =?utf-8?B?Qmp6MU0vejBPSVZhUXo2RlB5NThzQkVhK1kxVWdqMFdHb3BjamovY0NwSzBL?=
 =?utf-8?B?aGJNSHZDd0pwWE9aaUpINmNwa0VhK01kYkRmM2tJZFNvV05mMUVHaDZNckV2?=
 =?utf-8?B?TTVPSHNQS05aaWc3WGR0b1ljMnJrZURyQmpPa2JLOStvV2VwbUQyRTY1azYx?=
 =?utf-8?B?OWhnSWxHZ090TndnUWxBVWllajJBVjVEZXBpcUlDR1IwcWtncS9JTWJhQWN4?=
 =?utf-8?B?MFBDWWtQb1VaTzh3a3VuZVh5WmUzQXlta3FqL1FER3IzQ1ErUFVmTk1UMjNY?=
 =?utf-8?B?bkNYVnRPVHVxT2R6bGlZanNWN1JkRC9GZTh5SWU4RjZGTkREYVlTTjA3T2wx?=
 =?utf-8?B?d0g3cUtpL3lOR1RFVk1DdERNaUFzeWd5U1hRMVJiNnFRWnMrQVdianYrcjBr?=
 =?utf-8?B?enVLN2lBUjJ5QzZhdEQ4Y2NZa3VSZGl3dFR3SlhjdVVENktCMjBuNjNIZFk5?=
 =?utf-8?B?S0RHRGpwOThYL2V6OFBIMFlFbWZSZmp6cXZyQnVKaW5LVUF5Ui9ScUREQlJD?=
 =?utf-8?B?Z2JqTDNSKzZ5WTlVYXRHTVZ1OUZDenBMdE43cVFNR2NpZGNuMzRxMGJIekMy?=
 =?utf-8?B?TVJoa0VvSGtDelQwYllBQXROQkhaOFIvNk91Mm42RmxQVW1hV004MHpjUCtD?=
 =?utf-8?B?VVdFM0M0MExDZHJWRVlUZW9yTUtxa1hmTmZtR09tTm1CWUxSeFVRcnRPOHVM?=
 =?utf-8?B?RDM2K3BtcHZTdkRITGFFWnd1ck5GbkFZNnZnTHU0citPVU1ZRC9ud25VVDNW?=
 =?utf-8?B?dEZkdmZUTkpGTE5vb0J5eDEvQTdkY25YK2c0Qnc4U2VmZzJObVNrUUI0b0Y3?=
 =?utf-8?B?d2o2WjBTZkRpVVlsdUxtMjlhUjE5VGlnNEVWdXJoek1TQmR4VytMRXpXZVla?=
 =?utf-8?B?ekhublZLbkJqajNkZ1Y2dDMyL0drTDlsU2lsb0ZhZlJoYXRoR2pDTHRyS0h5?=
 =?utf-8?B?b3ZzUExCM1lPa1Q2ekNzUExzTkNNNjBLazBvU05BN01teE9kaXd0QjFWREkx?=
 =?utf-8?B?VzFwM0FxYUE4Z2Y3Y3U2b1pKSnl6MENoYnVla1VjQWF4KzhubndpbGhQZ1RF?=
 =?utf-8?B?ellER0dUaDdmT2xBbUhXeVV4dldxRDNZRDBHK1RnbWlPZmF0RXoxVG9iOXZo?=
 =?utf-8?B?Nko3eFh0OEI1emhucm1TOXZYSVpHTzJ3cSt6VURlZ3FneUVxVm5xNUdldXRB?=
 =?utf-8?B?cGdhaUVpOWlWNHBxcGlnSjZxd2lUNXlCL3A1a1RwS0Q4U25MVFBFbjBLY1Ew?=
 =?utf-8?B?eU9CMlBaT21lRm9qbGZNMVlmMlQ1ZjJod3pqMWpucG9LSkg5dHRTNENrbEVx?=
 =?utf-8?B?ZXh2TkdyMGRqRWpKQjg2RS9hWGU5UDBOQ0V0UVYxTHdYcWlUOTRCUHRBdFlo?=
 =?utf-8?B?SWJ0R1NHL1gvMW13U1ZHcG5vRzc0MjhaL0UwVXFjdlE2Ny8zYkJsYVRQME1x?=
 =?utf-8?B?RTVqV1JnczVWdU94OWRqVTd0QTFxa0RqNkRxT0krVk9CVUVxU0NwVG1DbWJU?=
 =?utf-8?B?Z2Eybk0vMWQ0NWFKcjY0V0hXODdwejdGM1hBY0xQTzVSZmpScldOZGtUczlG?=
 =?utf-8?B?STBFWTRtZGUwNVYwbkxWZjI5UGJQTkN3K3d1YmpOOWdmTGd2ZU9PTnVwQktY?=
 =?utf-8?B?b0hOTUlUQVVvVCtvSW42YWpqYXN4NnJQQmFaeGY3aGVqdENXYUVkajFQNzht?=
 =?utf-8?B?UXltNnRsUVZtVlFEeEtqeG1yWnVSek5YaVlSUVcxVUZiTk5ncFRqU3Ftc1c0?=
 =?utf-8?B?Q09PdmtCeFRIVlN2TEMzZ0ViU2R6aWIxTEF0S2NtU2dzdzdBZWV5Q3pFS2FR?=
 =?utf-8?B?NDF3UkV6RFFKelRpL1IwWXBkNEd5NG15ZlF1VytlMkV5MFp2UkRaZ2hxdGpW?=
 =?utf-8?B?NDZHYmNsd0NkdGF4T2IxZjRPaGhHaFVjS1ppcUVXSXZNOUFRTUVDN2JqQllh?=
 =?utf-8?B?WmFtVlZGQjRuR2k2OW9VRDBxSlBQSVhPZ24vVHlOM3lON3dORDZWWEFUU0JQ?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A26944E12C302A4AB6650F6715E6E0D9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa351d13-386e-4a8c-4608-08dc5d531b2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 13:51:09.8681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uo2u17ibWqB6/qENfkZimy7daWh7TriaT9wEOIF2tHwyY41HCRgd/QfJ5yf50DOa8UCGkBM17cUTNQo3h3s2sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5169
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA0LTEwIGF0IDExOjI1IC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEZyb206IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW4uai5jaHJpc3RvcGhlcnNvbkBpbnRlbC5j
b20+DQo+IA0KPiBJbnRyb2R1Y2UgYSBkYXRhIHN0cnVjdHVyZSB0byB3cmFwIHRoZSBleGlzdGlu
ZyByZWNsYWltYWJsZSBsaXN0IGFuZCBpdHMNCj4gc3BpbmxvY2suIEVhY2ggY2dyb3VwIGxhdGVy
IHdpbGwgaGF2ZSBvbmUgaW5zdGFuY2Ugb2YgdGhpcyBzdHJ1Y3R1cmUgdG8NCj4gdHJhY2sgRVBD
IHBhZ2VzIGFsbG9jYXRlZCBmb3IgcHJvY2Vzc2VzIGFzc29jaWF0ZWQgd2l0aCB0aGUgc2FtZSBj
Z3JvdXAuDQo+IEp1c3QgbGlrZSB0aGUgZ2xvYmFsIFNHWCByZWNsYWltZXIgKGtzZ3hkKSwgYW4g
RVBDIGNncm91cCByZWNsYWltcyBwYWdlcw0KPiBmcm9tIHRoZSByZWNsYWltYWJsZSBsaXN0IGlu
IHRoaXMgc3RydWN0dXJlIHdoZW4gaXRzIHVzYWdlIHJlYWNoZXMgbmVhcg0KPiBpdHMgbGltaXQu
DQo+IA0KPiBVc2UgdGhpcyBzdHJ1Y3R1cmUgdG8gZW5jYXBzdWxhdGUgdGhlIExSVSBsaXN0IGFu
ZCBpdHMgbG9jayB1c2VkIGJ5IHRoZQ0KPiBnbG9iYWwgcmVjbGFpbWVyLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2Vhbi5qLmNocmlzdG9waGVyc29uQGludGVs
LmNvbT4NCj4gQ28tZGV2ZWxvcGVkLWJ5OiBLcmlzdGVuIENhcmxzb24gQWNjYXJkaSA8a3Jpc3Rl
bkBsaW51eC5pbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEtyaXN0ZW4gQ2FybHNvbiBBY2Nh
cmRpIDxrcmlzdGVuQGxpbnV4LmludGVsLmNvbT4NCj4gQ28tZGV2ZWxvcGVkLWJ5OiBIYWl0YW8g
SHVhbmcgPGhhaXRhby5odWFuZ0BsaW51eC5pbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEhh
aXRhbyBIdWFuZyA8aGFpdGFvLmh1YW5nQGxpbnV4LmludGVsLmNvbT4NCj4gQ2M6IFNlYW4gQ2hy
aXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KPiBSZXZpZXdlZC1ieTogSmFya2tvIFNh
a2tpbmVuIDxqYXJra29Aa2VybmVsLm9yZz4NCj4gDQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcg
PGthaS5odWFuZ0BpbnRlbC5jb20+DQo=

