Return-Path: <cgroups+bounces-2331-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9D1899385
	for <lists+cgroups@lfdr.de>; Fri,  5 Apr 2024 05:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846671F228D8
	for <lists+cgroups@lfdr.de>; Fri,  5 Apr 2024 03:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862FB17BAF;
	Fri,  5 Apr 2024 03:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iAnEzdOP"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB9B125C9;
	Fri,  5 Apr 2024 03:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712286300; cv=fail; b=H05X13H2px8XZojtOl/5LfiIfwV8JnLJ6Xa7xXwhXgiz8GkBUp5NxiA/Ye6i2PgmAaOYxS9m6EBYzjdlRpjh/3vCAqrY4kOisnIK5KfjUXex7vT2QlG5pT17a/ww7lRYXq+lOhVcGzoZ8cDdwtPeY6pR2tNaod6rKZmRFzdNtwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712286300; c=relaxed/simple;
	bh=yC6tJf6HamYovw2m4CqtT139VEEfIQw0WXK4S8fQPf4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DBMSI4Giqvg8QAvvuSfYfFYJScoOhaAFZCJt2ZZtW2nqcTD1kCc1fOXIJFby6CBFAMTGpAEgkVcYsny7sUXd4ra3rWWMzkN1HawMWYdmfmAhP7BSfS7AXl0TodaXBqV+JWnlB/fNqiiyaC0BR04P6K4N8KOYpq+y0azlSDwHN4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iAnEzdOP; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712286299; x=1743822299;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yC6tJf6HamYovw2m4CqtT139VEEfIQw0WXK4S8fQPf4=;
  b=iAnEzdOPwThdb3Fwdu8A4mc/Be10eqsZrP0MmZJN86lGrfvWOlkFUsxX
   jgzuHvt+rA+T/coFdxay8Okxce5icKK1JdhZtj5L1vt22XMGfzeI3UqGq
   F8gawMyG3jEcKeuevU7P0q8APs9e1w1TgvR3qiUz+AVJ2gZWEDqXdOBAW
   KZ/lQpV/9o3YxG63gBbFAZjQQSpwY+ptmV7fCzrRtt45h6zZfQCuxzWLS
   fR3FOBow4oouQIRd4M0rxdHTDF+/8HGN14z1z4IyhKSt6D4sEp2L8sfYR
   fwQqGWeOoNyX2yC3JzioVpwNtatW/WUpULnh/4gYqYxJL+HXfTsiNcz6J
   w==;
X-CSE-ConnectionGUID: nOo2BIjhRSaAOwTXQQeIoA==
X-CSE-MsgGUID: K5UtOaa3SGW3CBCrC1Pizg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7465691"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="7465691"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 20:04:55 -0700
X-CSE-ConnectionGUID: 3+AsNK19RZWeozeD1xkMZQ==
X-CSE-MsgGUID: bsDkDzvWQWKzxZuwMTR28g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="23659278"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 20:04:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 20:04:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 19:59:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 19:59:25 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 19:59:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVyw/Qma6+MNs8tcSR5NX24Zs3e9QvTYPH3g18aF49GcJeFTIxH56jf30cObwyNjpVUsuoLfaYtUm6IfSIpWNevQ3PTfL9jM++bXh/CI+X7Ok3Z4HsATFksK/pjxX2eAUKzYohvKalZ5tOFrDNi7iRi+ADo6WP6dn9x9zjgGw7iDimYcbWD23Ek2CgiLImeSMmx/jDB+32FgP2uznan6ZYfZbHCG01+CHHS5YUT8zLP2pchVHT0KHI0B7WSpnbm8FcqkFiZmZyyyAeJ1O2u8RSbwlbATWGceFBV7xCZHs0uoMDVVmm6qtZqiEYUpUEdkeu3qZQMbIOoQ6zMgBv/rmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yC6tJf6HamYovw2m4CqtT139VEEfIQw0WXK4S8fQPf4=;
 b=muTyWpWVO5Mx6OrWfsHsBm5VyjEBYtS3TmZXzKLw0kExgn+9h4XiYtGOzP+Ez3nf52Lllz910RttrhHv/LJV71G9HUy1ixhM05BhnddjeABKlfGEz4M/TM4mDBsewEk6liKbq5uj/I4gkMe79m5GJdMUNAOnIvEnlBcLbHiPZee38amCpgQSlIPF8M9TWgyEws6eNZ7w9YgIgpZ+qqaYKWdCHTrg41iJENwBCmwqlvDLRL+QSwRQsTxU75FI0ssqDoNd/pAPS8mWZbt6+2gQbVEkGA/pIMwiWGVkNrHDnTQptwSpEVa8OfyE6F8Tt0rYJITF9vMxMj7LxHaYJYOEdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.27; Fri, 5 Apr
 2024 02:59:23 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.019; Fri, 5 Apr 2024
 02:59:23 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "jarkko@kernel.org" <jarkko@kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "mkoutny@suse.com"
	<mkoutny@suse.com>, "haitao.huang@linux.intel.com"
	<haitao.huang@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"tj@kernel.org" <tj@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v10 08/14] x86/sgx: Add basic EPC reclamation flow for
 cgroup
Thread-Topic: [PATCH v10 08/14] x86/sgx: Add basic EPC reclamation flow for
 cgroup
Thread-Index: AQHagKYK1xl+sWyc3ESn0fLYsxjIorFWjreAgAHUcQCAAKYOAA==
Date: Fri, 5 Apr 2024 02:59:22 +0000
Message-ID: <282665c8a86b16d02175d671c6aa56ffd41b5a80.camel@intel.com>
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
	 <20240328002229.30264-9-haitao.huang@linux.intel.com>
	 <e616e520b021e2e7ac385b5b1c41febb781706de.camel@intel.com>
	 <op.2lpq2mtswjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2lpq2mtswjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|LV3PR11MB8508:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HHwYoqpzPyfPhI0ifRzg45NLxi6U6dictop7Fb/zCwFIUzneUItYvTfDttDVSTXLxIO3WDLOc/YSNni0S27/mm9uoVw9Y8Brv2NfBgx6IGQ0OwW/hH7FbTP3M0o81pFFKhXzBKKc9Dt6gAVCLRoONWbp8cevCXosObQdwNEYVtEAWWyLQUKX3BolwFQlZcXy092ZCxJq6bYh7KCOyC6TXwlJQ1drFoJIPGymWtH9cby33Wb+PC88CeReLassyVnRxQ2ahsBvFnOXEh1B1nECeFtOyfclYbD3En0oyymmJnghxA7PC0pm1EYM9yvI9V/fkNT0kdXbbc7b/R07tKS7Du6cMcJom40swJpfxzR4mhmTIDKP7lcVHb2yoE7wGjoVx45WBkOZxHqxfsRZPpaWIrIw+j+c4VdrkEQdIdm5lbUvZkXlQo3tDjtIcK21fA1bDQZA1WIkXhvQKgUMKX/lBwVO6p1DDlnZErJ15UUvcW2T6B1c+dOAEOvI3DWmS/PuldJ19GVZofHbsCkBfXr9PBJogJPyLDLT0Dt+Ra98T8qa2T8xB/CWFzQbwEiEl0Kz2YuYeu2zaQqBSpAsKchoIj+y3x3tVB6mCJr7f7SNd7Xp82Gnb9ZD3JJVtCuZfypbQpyOgu/R2fo4GqhN8RNVdDnF/tv7HfNosFxmixeb7Ctd79kiyAp76KbiJYv+O/sVuWDXNslS4y5hkSlcTk/Zow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVNBK0htKzNhTWQya2N3Y2R5UVcyckdzYmpXVjNYQW9BOFQ3U2JCZ3ZPK090?=
 =?utf-8?B?ZjBXNWp3VHhaTWljWHo4TXRmcytWS2laM3FVejdIR0hlYmJCSm5yRlZVMVhX?=
 =?utf-8?B?empvd3hRMlVWUm9ZNGFRdTEveEVoVHlURU44ODJteGhhN3NNWnhWN3lJdm40?=
 =?utf-8?B?cVV6eUpiaEwvWGFUSzc5Q2ZBT3NSMHp2MjhvSGd5UTQxeitRK3JFWkZXc2Ir?=
 =?utf-8?B?YXRwdWVnRDdzYjN2ZHlJamdvSWFaUldacWtZWTZKUlozdjFhNERWWnlPT1Rk?=
 =?utf-8?B?RE5FczBQelI2RmtVOEhCV3gwM3A1aFQwTnNnL0ZQcTNvcDZCaGdVTzlUZllD?=
 =?utf-8?B?Yy8reVRoTWF0MFczNGJiR2FqK3dnZCtYRGJJV2l4Ym9uTzZUL1B1SVhwTFBJ?=
 =?utf-8?B?Vk52bnFjcHZpNTh1Y0hFS0F0cTFWa01FVTVhOCtqWmtOaGlOQi9BcGg4SzBN?=
 =?utf-8?B?bmZPdk0wbzRGSmtVazlXeXltUXFQZGRndFhYZEpheHp4dXBXYVZpTlhyeTQr?=
 =?utf-8?B?dTMyUW00UVAxVWFZM01vRm93bVRmSWt3WVBhVDJ1WURCb3RtZFV1RWM2Q1Az?=
 =?utf-8?B?M3JhY0J6cjZNU2NUMlBEelFCd3NWR1NVTFZzL1FFV1NhVklqWHVOQWxpd2NT?=
 =?utf-8?B?UGtyV280dFduVnhSYWFEU0Z6dUEvb1E2ZzRiQ25OWCtzQkpoNDZzOGF5OUNX?=
 =?utf-8?B?TzByTk1BUUtPek43Y2NIY1FMRHNJVDRreFJkdm5VNGlqNWY3eUI4UUtac2FT?=
 =?utf-8?B?KzlkbDl5QmlrWHRsNUZqaTZnS1ZsSllmME9McnZhOVBJN0FwUEVJUVNLREtU?=
 =?utf-8?B?dGVtZGsvdUxpOVZwMDYrTjRjQ3lWN2xHMERxK2xxK016RU52UDBhYkExMEdN?=
 =?utf-8?B?QlY1dzBvZlZRRGZyRTNQT2RJT0VlV2w5cy9waThFQmFmblZTVTBpTHZnRm94?=
 =?utf-8?B?TldQRDhhd2lZaTdwaU53RWZaRmNCWmMyL2o1SjNTcGNCWmJ3WlI4bDNNOVZY?=
 =?utf-8?B?aVVSVkQxZzhvWVRFSHRlaVFSV0R1Q0Z2OXROYm9WNEVHVituSm9DRkQ5VXFz?=
 =?utf-8?B?YkQ2YlBuM2g2WVBFYWtka3BTTWxmenBhYUc1Q0h2OXFEWk9JWktRaE1iVXVF?=
 =?utf-8?B?dzRtNVlHR29INnF1S0tCdnFNOUx2eVIvQ05oVVh6MDV6Uit3NUdTR3FnMmdX?=
 =?utf-8?B?VTllNEp4RUZXZGJBZVA0c1JHS0QzTkZ4Zkg1T0VDQ1dLUXdnd3JmVU8zSVow?=
 =?utf-8?B?N0wvbElkT0VvRjhyNWIyaXovS3RyTlM3bW5JaG5SK0FuWWsyd1hiZTlvTDh2?=
 =?utf-8?B?Nm9xa0RpaDZPZ1h0REh5eVNnZFlTelZndjVKRXIrSnZ5VGhwMzgzYlYzNTBR?=
 =?utf-8?B?c0grd3RWTDUwd2o5N2ZhTHQ4RHBSbmJKU3ZGNGpkTkUyVnFKK0FwMlJZNzRR?=
 =?utf-8?B?OEU4Z2lvTEpWSlV2VjJQOWJDOWY0R2VwVE0xMWpaSThGTXR4RlptVmFUenBG?=
 =?utf-8?B?aUxiZDdkT2MzVEdiSEJPbmNKQTVVekg1M2JXSTZ4WEhXS3JIdCsxRFlVRXox?=
 =?utf-8?B?US9KNEQ4dmZFblFXY0tUUWhoL21RTmpENHNEblJXMnZ3TGMvRENsYnJZaDNl?=
 =?utf-8?B?dzgzc1l1NTNnOVRjMG5YUmQzSFRZSHUwTlBXazB5N3MxeGoyTmttS3h4M2xV?=
 =?utf-8?B?NTFqVW9IL2lNQ1h0UElIaHovcFZEN09IeVNheHkxL1BBM2pkaUFVTjI0bElG?=
 =?utf-8?B?UWdwdUtuSGI1REdXenJaRFkxM3UvZ0hqcU1CUTBwWHJYeDNqbm1aM2FXOUlO?=
 =?utf-8?B?WXM1bzd0M3AzREZ4cUl3Zk94TVZzVStZY1g5bHRiUTFFODdTOGxzMXZiSnBQ?=
 =?utf-8?B?MUdabGUzR2NkZVhvUnBJaUEydEw3cFpaZVRhMmNxY2NpdUxWM1JEYlJRd2xh?=
 =?utf-8?B?WEZrcVphc2ZEWVRYUTVhakZHd3Y3Qk5nNWt2bUlYdmNLT3F0WWZhbjYrSEkr?=
 =?utf-8?B?V0dCV3ZSa2F5R05sVGxZYnRGTUhaVlU1a3pMMEIzdmR4MWNLdjlFbVoxQnps?=
 =?utf-8?B?azlEQ0hhMU1kNk1Bb21IVkYrQWtPOGlRSFlydGJiRVF0TzdVVkpabGc3V3FH?=
 =?utf-8?B?Rjd3U2dBWVNQUmpHNzgrK2djam13emx3NFJMaHMwUkdvWkM0K2RWektTendy?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EABB3E730411240A581B19E1FC3D614@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3859fa1-c48b-48e6-79d8-08dc551c657b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 02:59:22.9631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9CO0zSGGleilZOW1m8r07IWhGFrge6SmM8wMv/YYVn2bsZF+G1PJe5X3JXEqXHguJqMJyUoHcxUV8Ht12xe69g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8508
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA0LTA0IGF0IDEyOjA1IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
ID4gUGxlYXNlIGFsc28gbWVudGlvbiB3aHkgImxlYXZpbmcgYXN5bmNocm9ub3VzIHJlY2xhbWF0
aW9uIHRvIGxhdGVywqAgDQo+ID4gcGF0Y2goZXMpIiBpcw0KPiA+IGZpbmUuwqAgRS5nLiwgaXQg
d29uJ3QgYnJlYWsgYW55dGhpbmcgSSBzdXBwb3NlLg0KPiA+IA0KPiANCj4gUmlnaHQuIFBhZ2Vz
IGFyZSBzdGlsbCBpbiB0aGUgZ2xvYmFsIGxpc3QgYXQgdGhlIG1vbWVudCBhbmQgb25seSBnbG9i
YWzCoCANCj4gcmVjbGFpbWluZyBpcyBhY3RpdmUgdW50aWwgdGhlICJ0dXJuIG9uIiBwYXRjaC4g
U2VwYXJhdGluZyBvdXQgaXMgcmVhbGx5wqAgDQo+IGp1c3QgZm9yIHRoZSBwdXJwb3NlIG9mIHJl
dmlldyBJTUhPLg0KDQpTb3VuZHMgZ29vZCB0byBtZS4gIFRoYW5rcy4NCg==

