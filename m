Return-Path: <cgroups+bounces-2286-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F69A896FE2
	for <lists+cgroups@lfdr.de>; Wed,  3 Apr 2024 15:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D881F25D38
	for <lists+cgroups@lfdr.de>; Wed,  3 Apr 2024 13:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C2A147C6C;
	Wed,  3 Apr 2024 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KVDgoNeY"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4006146A8E;
	Wed,  3 Apr 2024 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149747; cv=fail; b=jMr/n5el39zg2N39oDOOK1+y19Re6LQ60ZleRnBm1I3bRSfBplR+48i0GlQs+6wIQKIe8i/nYptHaTYtEwrHpgszPr/9Bqwj3ovy+zsk1k43H/hjH1OigDYAtpygwZRqdyuiOgPbkVtlZbuwjd1WOtBE1SECxX9y1KaE7ZvIQA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149747; c=relaxed/simple;
	bh=9WBzjlBj3IjFCcPusMqxuYo9MxiKYkjhUrwf1Owgmcs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H3e+bhoaueisdWeDY3rVZTiLTSDzAW+3+5jctFkPX0X1TYm/JzmGXmItAlbjkuj12s+fhAKOU+5fiD0EMKLJggiNrnBGRHVqkAEiGe8CVTci+PlzHo2PLVuMmSqYCQe6VidbQmyW8FSAtTUBN6V7cr7g5i7zJ3jLDDAcCJP/9eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KVDgoNeY; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712149744; x=1743685744;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9WBzjlBj3IjFCcPusMqxuYo9MxiKYkjhUrwf1Owgmcs=;
  b=KVDgoNeYxk+G5k4xwYfpiliMalOTaa5ERGcQx4YNrFwzNG9Fe9Demrf0
   tK9hE/RYVaoPxp48udL10fMQLt2wADqnBximf+eNHLVeMrKVwY1MjVRag
   vCoGOxr1pOJX+mlWmTRAbrys6VPK0lNDjioS15fdTWCj+zfgBiN3vV11K
   oMrNNbryOj12xugfT+3jf/me3tJb4QAL3QVtVivsopKv2VTdqawtLHXlS
   lakYgs7Kc08Fhf2Us7bsZKGMWZbt3Ya0MnUlNuDGd8lX6iWbVA5pSLCRo
   HaB6jywrPYSwxFrPxJ5Hf9x/5GWRWHinjsKSKkKyg2qnKhekR477y7TXe
   A==;
X-CSE-ConnectionGUID: aUHKOCxXS7SnypbXco338A==
X-CSE-MsgGUID: vuu05B0gQkePHf1lYxTfAA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7505257"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7505257"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 06:09:04 -0700
X-CSE-ConnectionGUID: i1rjb4LLT66ixSYP2l7CRg==
X-CSE-MsgGUID: ibQgnrhWS8qMgS6kZi02hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="55890519"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 06:09:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 06:09:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 06:09:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 06:09:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajxO02yDDscjmyjR26kQPM1706YDWbuutsqzgMdpWaA/FGF2Y5hT4gfhgezRFog9hQOjNvCMweRBr1F6eQQ8pKTR5MdVOYG3c2jTPxZRhyqfLNqMqzhS8qawq4IhvqhmeFciIYkj5vJndLpiqxqz6NjY/pf8nfWMOm5ru4pf7leYX7+cQQ92bp8aV0HNnNhRDJ66PtDrT0sDVa8lNXX7VCVXmuue/ra4z0Ka/r3tpXcbyvoahI2AXzrt73YeF3om1ZuClQ4IJLfrrWveE3r2rReYTQOSmV0OuNyUOVbuJD6ZcAf12XyX5Fwq9fwe69xbe+OzXy4IBfNhDN+rqV4PUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WBzjlBj3IjFCcPusMqxuYo9MxiKYkjhUrwf1Owgmcs=;
 b=V9zVjDo5ySoTPfn082C2OZ+HhcvL01PGVD1M7wWh348A3M3SWpusPWD7LfuU9W9uuFT2P9MAnav9Kguj3NtM9Uo22ayKnmsK/EvjYZ17rbpP6T6IYvw9M0TGt95KpLWJxP1wlxdDjaG+e34bSiqko/3qE7NnLKtK4m+tnXB3KdmjLYzPtNU95twYb2GJLXv3MNxdAEgVviPGuwbUKjfsnD8lZcKP41jmKkmTpb5GBy6RrGBC3ecqf/eZajLUYDe+cikPLdaXPdCvcoQUClTqiiju3m9JkI5v+Ft+6XTorhYoxJobZ6pJx0pUccgT2MrtTGnRLoFveG9ll2e/ff5VeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CO1PR11MB4817.namprd11.prod.outlook.com (2603:10b6:303:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 3 Apr
 2024 13:08:28 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 13:08:28 +0000
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
Subject: Re: [PATCH v10 08/14] x86/sgx: Add basic EPC reclamation flow for
 cgroup
Thread-Topic: [PATCH v10 08/14] x86/sgx: Add basic EPC reclamation flow for
 cgroup
Thread-Index: AQHagKYK1xl+sWyc3ESn0fLYsxjIorFWjreA
Date: Wed, 3 Apr 2024 13:08:28 +0000
Message-ID: <e616e520b021e2e7ac385b5b1c41febb781706de.camel@intel.com>
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
	 <20240328002229.30264-9-haitao.huang@linux.intel.com>
In-Reply-To: <20240328002229.30264-9-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CO1PR11MB4817:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DzW9PfMWE0qtx7mWhxm5IGgZ/CK11DsKKvjr4/P24OXDuJjdXG6BY/rZe7xUtRcswesTjA0/xYXg4a0blWW/Xur44KYeZVEh3vj72q3TXVITToRlxEcXbuAWRIGksvM/G1+q3q234pnLSGDJ5iQ0xrUuPe+/axCD8vsZrYFYdGYTwtTqC4/b7C8K18TccadDOt/Y/mKfS9QAIzQ26ujAbVHaelz6/CS5cD7cKQeTEsyszobw9Bj9JKxF6VJnQ+KRSoc13VXjLyCwjrGFes7iTOYLM7wjUy0JfIDQZPmw+r06bh4x9dFEunoqDdwWlTs2tnigEb8uspWlJNOGbsFrDaC3EX7JpPiBk9hv6l99nOzll71q7E9LujzHd0UQ6bwkSQacfOcPdQla9tB2nMwQIVjDem4gOZ3AK4DHSv0U1/XhI7mpJcz8tA35guO8NJ4kEq8DNYDrZUznWBFmKHeorDXwYr04MzhDlUfASNPNbxcCtq3AzLPkYVEtbfdbuEWzfR1SqYUpTZJDzjJYQnbHcP6MS+lQA/wCEDl/IPkFtZWCsBF1Ipfs5oLaW1p3oLbRMWk9AS9YmIy3t2JYeR9+josVAI5SuXKL/l3VMCzUDajuo6RYgJi28FkHzqeZB5Q4qH8BOyENvrt38aCR2LiCvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTQ1OXY5Y2h4d2ZqOGo4OUQwbStZaVdMbkl2MlE5QW1JcVRHdVNPeUs2U1RD?=
 =?utf-8?B?ZmhTUEVUbkJaM1BBTUVteC9aQnVVNmNneHJWYi91eVNTSW1BdkhicDlVQlVx?=
 =?utf-8?B?Uk8xSGZLeUFabUFyMEJMMFhSVDcveWR6MUNwdE9PVlRoNG53VkVpUGNCdWZK?=
 =?utf-8?B?aHVnMm96NEZkTjF6blhkQWxxZHBEalYrUVZ4ejFlWTlZMmlBMzNIMkhGS3ht?=
 =?utf-8?B?MkxidVdsVXdENUdEOEdtelM1YUNJeWZrU1ViRXBaVTUwTlIzd3lqZmszSkZJ?=
 =?utf-8?B?OFppaHUxOHRmZ0FlN0NuVHNmM3RRN2JaTFBlaDNtRWVlT1hHeDYzU3Z1ZXNW?=
 =?utf-8?B?MTNtTkY2WllSQzZURXRqaVUrK1B4elBUWWZ6RUpDWG9oVkFsaWdoa3dJTGRR?=
 =?utf-8?B?TGJ1dUI3OXRrU21xbEFLdGM4MmVXS3k0ZEVpcE5QUjFFZGt3c3JWSlg5RUtJ?=
 =?utf-8?B?d3UrV0pmNXBidjltc1cvY0VtcUI4bUFtZXdHK2IxWFlCS2tvNGxIVlVDVlMw?=
 =?utf-8?B?Sml1MUxVbittRjBxNFpzbDFhbFFhb3oreDJUL1lhL1I1ZUhYZGtEbisvMThx?=
 =?utf-8?B?RStoN3lDUjM1TTZBd3NQTFd5b3crNjlrZ29pOTZsbFBNekg5ZTl0c3FrcTlN?=
 =?utf-8?B?T245Tk1DVFAyOU12V1ZQbE5OMGxNUTBsT0hKcTcveEF1NktHVG9TQkMvSTkz?=
 =?utf-8?B?dHlnNXVTRWVUWFh6akN2YlBnSGhyVHNVTVBjQm52VXNXUlI0aU5jaVRGTXl1?=
 =?utf-8?B?UlkvbGV2aXhlMzZsb1ZaNGN3NTFPbFJxR1l5T01MRzd1enFWa2tyTWtrZU5P?=
 =?utf-8?B?N1M0bEZ5VnE5T1dBckRYRUFWK0IxbGpjTnBncEluckN2RHliNXNtUHNFQy9w?=
 =?utf-8?B?VUorU0lOU2RLZXdoVEUzUGwwRFZtTXRGSUFwNmVQSXRNR05ra2pENVo4TWVV?=
 =?utf-8?B?R1I2MGRubnl4VTU0NjVNUGVpUGtHUTg3LzNzZXMwRXRBNVpTdWM4SDB5WTFt?=
 =?utf-8?B?M1dIZWJRWjIrYmx3UnlscmNQMkFLNkVWUWVxSlYwdFFac003UnM1bm9FU3l0?=
 =?utf-8?B?ZGJCWHpyM1FOZmlWcGU0M1ZwVW1CcWd2UXVTOVVXbndrd3FmRk1RRGd1Wkh0?=
 =?utf-8?B?TDJjZWE5V2pzZ3FPcjZkaHF1QkJrS2gyN0RlNXo1WUFJRUtNQlJhYjR5QzNP?=
 =?utf-8?B?OTkvaW9keE4xNjMwbFJPbk14YkUzM3RQdks4WUY1TkpNUC95OGR5cGdoa1hE?=
 =?utf-8?B?N3Q4TlVld1lNQWZHdFB2cFVnRzJhZmJ0ZS9TT1k0R1FlUk1SWGMwcVV0RjV2?=
 =?utf-8?B?SW04SDZ3UVE5VHRyM2xFWFhwaGZQeGVHS1YwL1RqRHNob0IvNVZWbVRrRHlv?=
 =?utf-8?B?a3A3OElNSXc0bWRrK3pOUzMveGlRRlowNlJrNlVUWmtySDlPRThyR0ZyTXVw?=
 =?utf-8?B?NUxaNGNXWCtVSjMwZnJzU1JsdkJtb0h6WXFsOEIwek93OEtreEl4YTE0cVBx?=
 =?utf-8?B?UGYxUm5YWVFDTkljS3JGOEE0TzdYRlB1M0ZmNFI4M0RRODhjcExOL1pHaHBx?=
 =?utf-8?B?RWxWSFg1K3A4UUNqZk5NQllwcDEvcXdvRW5CemxLTEViKzhCTlRoTUVnZmZ4?=
 =?utf-8?B?b1prUjNFM2NyVEFtdGlURHUxU0N6ZXdvR25EamVZdThPa2tndGpwa0dOT2hI?=
 =?utf-8?B?WmhHKzRYQXJCRitoS1FWcnZJcEVxV0ZOTXg3WHliYmV5NFZmQXZEMDk0UGw4?=
 =?utf-8?B?cElLMFR3aFBqUTExaDd0UzM5OE5kMnNSYnZ0Z2wwWitONytBbGovcWRsdFAr?=
 =?utf-8?B?S0J1Y1BQZFljWFlnRkpCY0lJWE4rVEQyRkhSTEp1R3JQc0NzQjZMUk5oSHQw?=
 =?utf-8?B?MlJ6SllwMzNrVWUrZDdwbmQ2WHZZSkhQcktuMy9hcGRWdU4xZ0ZnYmk3NVp3?=
 =?utf-8?B?bElKSTBNajF4UVZjZk1abWV4aStBMlNlSUFENXVzSFYrSkJlQ1hqbFZDS2Ez?=
 =?utf-8?B?UWwrZ05nbGVkZVB5dTdJKzUrS1ZOZDE4Y3grRGZzZWpiZ2VIT1ZtK3o1TjEz?=
 =?utf-8?B?bTRsc3hlWlhCeEp2UVkyMEYxdlcydUhrUlh5UUMvOWVLTENuWDNvcEtPbU5Y?=
 =?utf-8?B?SHFZVTN2VTVwUmRQcU5KUDRYdUpJaW5sWE5jTGVQZW1kOEdtd0ZGZlJLK2Nn?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5787AE10AB76F74DADBA4D340D985488@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2cd3cf-6dad-4a4f-652a-08dc53df276c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 13:08:28.3667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /1lERnTBE3A55DMM7U67DizUfmMe4VlEd7prHxtd15ie7lfTMEGr4rwUumldbqCVBEYYWzArIwoANlkUqDOlKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4817
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAzLTI3IGF0IDE3OjIyIC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEZyb206IEtyaXN0ZW4gQ2FybHNvbiBBY2NhcmRpIDxrcmlzdGVuQGxpbnV4LmludGVsLmNvbT4N
Cj4gDQo+IFdoZW4gYSBjZ3JvdXAgdXNhZ2UgcmVhY2hlcyBpdHMgbGltaXQsIGFuZCBpdCBpcyB0
byBiZSBjaGFyZ2VkLCBpLmUuLA0KPiBzZ3hfY2dyb3VwX3RyeV9jaGFyZ2UoKSBjYWxsZWQgZm9y
IG5ldyBhbGxvY2F0aW9ucywgdGhlIGNncm91cCBuZWVkcyB0bw0KPiByZWNsYWltIHBhZ2VzIGZy
b20gaXRzIExSVSBvciBMUlVzIG9mIGl0cyBkZXNjZW5kYW50cyB0byBtYWtlIHJvb20gZm9yDQo+
IGFueSBuZXcgYWxsb2NhdGlvbnMuIFRoaXMgcGF0Y2ggYWRkcyB0aGUgYmFzaWMgYnVpbGRpbmcg
YmxvY2sgZm9yIHRoZQ0KPiBwZXItY2dyb3VwIHJlY2xhbWF0aW9uIGZsb3cgYW5kIHVzZSBpdCBm
b3Igc3luY2hyb25vdXMgcmVjbGFtYXRpb24gaW4NCj4gc2d4X2Nncm91cF90cnlfY2hhcmdlKCku
DQoNCkl0J3MgYmV0dGVyIHRvIGZpcnN0bHkgbWVudGlvbiBfd2h5XyB3ZSBuZWVkIHRoaXMgZmly
c3Q6DQoNCkN1cnJlbnRseSBpbiB0aGUgRVBDIHBhZ2UgYWxsb2NhdGlvbiwgdGhlIGtlcm5lbCBz
aW1wbHkgZmFpbHMgdGhlIGFsbG9jYXRpb24NCndoZW4gdGhlIGN1cnJlbnQgRVBDIGNncm91cCBm
YWlscyB0byBjaGFyZ2UgZHVlIHRvIGl0cyB1c2FnZSByZWFjaGluZyBsaW1pdC4gDQpUaGlzIGlz
IG5vdCBpZGVhbC4gIFdoZW4gdGhhdCBoYXBwZW5zLCBhIGJldHRlciB3YXkgaXMgdG8gcmVjbGFp
bSBFUEMgcGFnZShzKQ0KZnJvbSB0aGUgY3VycmVudCBFUEMgY2dyb3VwIChhbmQvb3IgaXRzIGRl
c2NlbmRhbnRzKSB0byByZWR1Y2UgaXRzIHVzYWdlIHNvIHRoZQ0KbmV3IGFsbG9jYXRpb24gY2Fu
IHN1Y2NlZWQuDQoNCkFkZCB0aGUgYmFzaWMgYnVpbGRpbmcgYmxvY2tzIHRvIHN1cHBvcnQgdGhl
IHBlci1jZ3JvdXAgcmVjbGFtYXRpb24gZmxvdyAuLi4NCg0KPiANCj4gRmlyc3QsIG1vZGlmeSBz
Z3hfcmVjbGFpbV9wYWdlcygpIHRvIGxldCBjYWxsZXJzIHRvIHBhc3MgaW4gdGhlIExSVSBmcm9t
DQo+IHdoaWNoIHBhZ2VzIGFyZSByZWNsYWltZWQsIHNvIGl0IGNhbiBiZSByZXVzZWQgYnkgYm90
aCB0aGUgZ2xvYmFsIGFuZA0KPiBjZ3JvdXAgcmVjbGFpbWVycy4gQWxzbyByZXR1cm4gdGhlIG51
bWJlciBvZiBwYWdlcyBhdHRlbXB0ZWQsIHNvIGENCj4gY2dyb3VwIHJlY2xhaW1lciBjYW4gdXNl
IGl0IHRvIHRyYWNrIHJlY2xhbWF0aW9uIHByb2dyZXNzIGZyb20gaXRzDQo+IGRlc2NlbmRhbnRz
Lg0KDQpJTUhPIHlvdSBhcmUganVtcGluZyB0b28gZmFzdCB0byB0aGUgaW1wbGVtZW50YXRpb24g
ZGV0YWlscy4gIEJldHRlciB0byBoYXZlDQpzb21lIG1vcmUgYmFja2dyb3VuZDoNCg0KIg0KQ3Vy
cmVudGx5IHRoZSBrZXJuZWwgb25seSBoYXMgb25lIHBsYWNlIHRvIHJlY2xhaW0gRVBDIHBhZ2Vz
OiB0aGUgZ2xvYmFsIEVQQyBMUlUNCmxpc3QuICBUbyBzdXBwb3J0IHRoZSAicGVyLWNncm91cCIg
RVBDIHJlY2xhaW0sIG1haW50YWluIGFuIExSVSBsaXN0IGZvciBlYWNoDQpFUEMgY2dyb3VwLCBh
bmQgaW50cm9kdWNlIGEgImNncm91cCIgdmFyaWFudCBmdW5jdGlvbiB0byByZWNsYWltIEVQQyBw
YWdlKHMpDQpmcm9tIGEgZ2l2ZW4gRVBDIGNncm91cCAoYW5kIGl0cyBkZXNjZW5kYW50cykuDQoi
DQoNCj4gDQo+IEZvciB0aGUgZ2xvYmFsIHJlY2xhaW1lciwgcmVwbGFjZSBhbGwgY2FsbCBzaXRl
cyBvZiBzZ3hfcmVjbGFpbV9wYWdlcygpDQo+IHdpdGggY2FsbHMgdG8gYSBuZXdseSBjcmVhdGVk
IHdyYXBwZXIsIHNneF9yZWNsYWltX3BhZ2VzX2dsb2JhbCgpLCB3aGljaA0KPiBqdXN0IGNhbGxz
IHNneF9yZWNsYWltX3BhZ2VzKCkgd2l0aCB0aGUgZ2xvYmFsIExSVSBwYXNzZWQgaW4uDQo+IA0K
PiBGb3IgY2dyb3VwIHJlY2xhbWF0aW9uLCBpbXBsZW1lbnQgYSBiYXNpYyByZWNsYW1hdGlvbiBm
bG93LCBlbmNhcHN1bGF0ZWQNCj4gaW4gdGhlIHRvcC1sZXZlbCBmdW5jdGlvbiwgc2d4X2Nncm91
cF9yZWNsYWltX3BhZ2VzKCkuIEl0IHBlcmZvcm1zIGENCj4gcHJlLW9yZGVyIHdhbGsgb24gYSBn
aXZlbiBjZ3JvdXAgc3VidHJlZSwgYW5kIGNhbGxzIHNneF9yZWNsYWltX3BhZ2VzKCkNCj4gYXQg
ZWFjaCBub2RlIHBhc3NpbmcgaW4gdGhlIExSVSBvZiB0aGF0IG5vZGUuIEl0IGtlZXBzIHRyYWNr
IG9mIHRvdGFsDQo+IGF0dGVtcHRlZCBwYWdlcyBhbmQgc3RvcHMgdGhlIHdhbGsgaWYgZGVzaXJl
ZCBudW1iZXIgb2YgcGFnZXMgYXJlDQo+IGF0dGVtcHRlZC4NCg0KVGhlbiBpdCdzIHRpbWUgdG8g
anVtcCB0byBpbXBsZW1lbnRhdGlvbiBkZXRhaWxzOg0KDQoiDQpDdXJyZW50bHkgdGhlIGtlcm5l
bCBkb2VzIHRoZSBnbG9iYWwgRVBDIHJlY2xhaW0gaW4gc2d4X3JlY2xhaW1fcGFnZSgpLiAgSXQN
CmFsd2F5cyB0cmllcyB0byByZWNsYWltIEVQQyBwYWdlcyBpbiBiYXRjaCBvZiBTR1hfTlJfVE9f
U0NBTiAoMTYpIHBhZ2VzLiANClNwZWNpZmljYWxseSwgaXQgYWx3YXlzICJzY2FucyIsIG9yICJp
c29sYXRlcyIgU0dYX05SX1RPX1NDQU4gcGFnZXMgZnJvbSB0aGUNCmdsb2JhbCBMUlUsIGFuZCB0
aGVuIHRyaWVzIHRvIHJlY2xhaW0gdGhlc2UgcGFnZXMgYXQgb25jZSBmb3IgYmV0dGVyDQpwZXJm
b3JtYW5jZS4NCg0KVXNlIHNpbWlsYXIgd2F5IHRvIGltcGxlbWVudCB0aGUgImNncm91cCIgdmFy
aWFudCBFUEMgcmVjbGFpbSwgYnV0IGtlZXAgdGhlDQppbXBsZW1lbnRhdGlvbiBzaW1wbGU6IDEp
IGNoYW5nZSBzZ3hfcmVjbGFpbV9wYWdlcygpIHRvIHRha2UgYW4gTFJVIGFzIGlucHV0LA0KYW5k
IHJldHVybiB0aGUgcGFnZXMgdGhhdCBhcmUgInNjYW5uZWQiIChidXQgbm90IGFjdHVhbGx5IHJl
Y2xhaW1lZCk7IDIpIGxvb3ANCnRoZSBnaXZlbiBFUEMgY2dyb3VwIGFuZCBpdHMgZGVzY2VuZGFu
dHMgYW5kIGRvIHRoZSBuZXcgc2d4X3JlY2xhaW1fcGFnZXMoKQ0KdW50aWwgU0dYX05SX1RPX1ND
QU4gcGFnZXMgYXJlICJzY2FubmVkIi4NCg0KVGhpcyBpbXBsZW1lbnRhdGlvbiBhbHdheXMgdHJp
ZXMgdG8gcmVjbGFpbSBTR1hfTlJfVE9fU0NBTiBwYWdlcyBmcm9tIHRoZSBMUlUgb2YNCnRoZSBn
aXZlbiBFUEMgY2dyb3VwLCBhbmQgb25seSBtb3ZlcyB0byBpdHMgZGVzY2VuZGFudHMgd2hlbiB0
aGVyZSdzIG5vIGVub3VnaA0KcmVjbGFpbWFibGUgRVBDIHBhZ2VzIHRvICJzY2FuIiBpbiBpdHMg
TFJVLiAgSXQgc2hvdWxkIGJlIGVub3VnaCBmb3IgbW9zdCBjYXNlcy4NCiINCg0KVGhlbiBJIHRo
aW5rIGl0J3MgYmV0dGVyIHRvIGV4cGxhaW4gd2h5ICJhbHRlcm5hdGl2ZXMiIGFyZSBub3QgY2hv
c2VuOg0KDQoiDQpOb3RlLCB0aGlzIHNpbXBsZSBpbXBsZW1lbnRhdGlvbiBkb2Vzbid0IF9leGFj
dGx5XyBtaW1pYyB0aGUgY3VycmVudCBnbG9iYWwgRVBDDQpyZWNsYWltICh3aGljaCBhbHdheXMg
dHJpZXMgdG8gZG8gdGhlIGFjdHVhbCByZWNsYWltIGluIGJhdGNoIG9mIFNHWF9OUl9UT19TQ0FO
DQpwYWdlcyk6IHdoZW4gTFJVcyBoYXZlIGxlc3MgdGhhbiBTR1hfTlJfVE9fU0NBTiByZWNsYWlt
YWJsZSBwYWdlcywgdGhlIGFjdHVhbA0KcmVjbGFpbSBvZiBFUEMgcGFnZXMgd2lsbCBiZSBzcGxp
dCBpbnRvIHNtYWxsZXIgYmF0Y2hlcyBfYWNyb3NzXyBtdWx0aXBsZSBMUlVzDQp3aXRoIGVhY2gg
YmVpbmcgc21hbGxlciB0aGFuIFNHWF9OUl9UT19TQ0FOIHBhZ2VzLg0KDQpBIG1vcmUgcHJlY2lz
ZSB3YXkgdG8gbWltaWMgdGhlIGN1cnJlbnQgZ2xvYmFsIEVQQyByZWNsYWltIHdvdWxkIGJlIHRv
IGhhdmUgYQ0KbmV3IGZ1bmN0aW9uIHRvIG9ubHkgInNjYW4iIChvciAiaXNvbGF0ZSIpIFNHWF9O
Ul9UT19TQ0FOIHBhZ2VzIF9hY3Jvc3NfIHRoZQ0KZ2l2ZW4gRVBDIGNncm91cCBfQU5EXyBpdHMg
ZGVzY2VuZGFudHMsIGFuZCB0aGVuIGRvIHRoZSBhY3R1YWwgcmVjbGFpbSBpbiBvbmUNCmJhdGNo
LiAgQnV0IHRoaXMgaXMgdW5uZWNlc3NhcmlseSBjb21wbGljYXRlZCBhdCB0aGlzIHN0YWdlLg0K
DQpBbHRlcm5hdGl2ZWx5LCB0aGUgY3VycmVudCBzZ3hfcmVjbGFpbV9wYWdlcygpIGNvdWxkIGJl
IGNoYW5nZWQgdG8gcmV0dXJuIHRoZQ0KYWN0dWFsICJyZWNsYWltZWQiIHBhZ2VzLCBidXQgbm90
ICJzY2FubmVkIiBwYWdlcy4gIEhvd2V2ZXIgdGhpcyBzb2x1dGlvbiBhbHNvDQpoYXMgY29uczog
PENPTlM+DQoiDQoNCjxDT05TPjoNCg0KSSByZWNhbGwgeW91IG1lbnRpb25lZCAidW5hYmxlIHRv
IGNvbnRyb2wgbGF0ZW5jeSBvZiBlYWNoIHJlY2xhaW0iIGV0YywgYnV0IElJVUMNCm9uZSBjb3Vs
ZCBiZToNCg0KVGhpcyBhcHByb2FjaCBtYXkgcmVzdWx0IGluIGhpZ2hlciBjaGFuY2Ugb2YgInJl
Y2xhaW1pbmcgRVBDIHBhZ2VzIGZyb20NCmRlc2NlbmRhbnRzIGJ1dCBub3QgdGhlIHJvb3QvZ2l2
ZW4gRVBDIGNnb3J1cCIsIGUuZy4sIHdoZW4gYWxsIEVQQyBwYWdlcyBpbiB0aGUNCnJvb3QgRVBD
IGNncm91cCBhcmUgYWxsIHlvdW5nIHdoaWxlIHRoZXNlIGluIGl0cyBkZXNjZW5kYW50cyBhcmUg
bm90LiAgVGhpcyBtYXkNCm5vdCBiZSBkZXNpcmVkLg0KDQpNYWtlcyBzZW5zZT8NCg0KPiANCj4g
RmluYWxseSwgcGFzcyBhIHBhcmFtZXRlciB0byBzZ3hfY2dyb3VwX3RyeV9jaGFyZ2UoKSB0byBp
bmRpY2F0ZSB3aGV0aGVyDQo+IGEgc3luY2hyb25vdXMgcmVjbGFtYXRpb24gaXMgYWxsb3dlZC4g
SWYgdGhlIGNhbGxlciBhbGxvd3MgYW5kIGNncm91cA0KPiB1c2FnZSBpcyBhdCBpdHMgbGltaXQs
IHRyaWdnZXIgdGhlIHN5bmNocm9ub3VzIHJlY2xhbWF0aW9uIGJ5IGNhbGxpbmcNCj4gc2d4X2Nn
cm91cF9yZWNsYWltX3BhZ2VzKCkgaW4gYSBsb29wIHdpdGggY29uZF9yZXNjaGVkKCkgaW4gYmV0
d2Vlbg0KPiBpdGVyYXRpb25zLg0KDQpUaGlzIGlzbid0IG5lZWRlZCBJTUhPIGFzIHlvdSBjYW4g
ZWFzaWx5IHNlZSBpbiB0aGUgY29kZSwgYW5kIHRoZXJlJ3Mgbm8gImRlc2lnbg0KY2hvaWNlcyIg
aGVyZS4NCg0KR2VuZXJhbCBydWxlOiBmb2N1cyBvbiBleHBsYWluaW5nICJ3aHkiLCBhbmQgImRl
c2lnbiBjaG9pY2VzIiwgYnV0IG5vdA0KaW1wbGVtZW50YXRpb24gZGV0YWlscywgd2hpY2ggY2Fu
IGJlIHNlZW4gaW4gdGhlIGNvZGUuDQoNCj4gDQo+IEEgbGF0ZXIgcGF0Y2ggd2lsbCBhZGQgc3Vw
cG9ydCBmb3IgYXN5bmNocm9ub3VzIHJlY2xhbWF0aW9uIHJldXNpbmcNCj4gc2d4X2Nncm91cF9y
ZWNsYWltX3BhZ2VzKCkuDQoNClBsZWFzZSBhbHNvIG1lbnRpb24gd2h5ICJsZWF2aW5nIGFzeW5j
aHJvbm91cyByZWNsYW1hdGlvbiB0byBsYXRlciBwYXRjaChlcykiIGlzDQpmaW5lLiAgRS5nLiwg
aXQgd29uJ3QgYnJlYWsgYW55dGhpbmcgSSBzdXBwb3NlLg0KDQooVGhhdCBiZWluZyBzYWlkLCBh
cyBtZW50aW9uZWQgaW4gcHJldmlvdXMgdmVyc2lvbiwgSSBfdGhpbmtfIGl0J3MgYmV0dGVyIHRv
DQpoYXZlIG9uZSBwYXRjaCB0byBpbXBsZW1lbnQgdGhlICJjZ3JvdXAiIHZhcmlhbnQgRVBDIHJl
Y2xhaW0gZnVuY3Rpb24sIGFuZA0KYW5vdGhlciBwYXRjaCB0byB1c2UgaXQ6IGJvdGggInN5bmMi
IGFuZCAiYXN5bmMiIHdheS4gIEJ1dCBmb3IgdGhlIHNha2Ugb2YNCm1vdmluZyBmb3J3YXJkLCBJ
IGFtIGZpbmUgd2l0aCB0aGUgY3VycmVudCB3YXkgaWYgbm90aGluZyBpcyBicm9rZW4uKQ0KDQo+
IA0KPiBDby1kZXZlbG9wZWQtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW4uai5jaHJpc3Rv
cGhlcnNvbkBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24g
PHNlYW4uai5jaHJpc3RvcGhlcnNvbkBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEtyaXN0
ZW4gQ2FybHNvbiBBY2NhcmRpIDxrcmlzdGVuQGxpbnV4LmludGVsLmNvbT4NCj4gQ28tZGV2ZWxv
cGVkLWJ5OiBIYWl0YW8gSHVhbmcgPGhhaXRhby5odWFuZ0BsaW51eC5pbnRlbC5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IEhhaXRhbyBIdWFuZyA8aGFpdGFvLmh1YW5nQGxpbnV4LmludGVsLmNvbT4N
Cj4gLS0tDQo+IFYxMDoNCj4gLSBTaW1wbGlmeSB0aGUgc2lnbmF0dXJlIGJ5IHJlbW92aW5nIGEg
cG9pbnRlciB0byBucl90b19zY2FuIChLYWkpDQo+IC0gUmV0dXJuIHBhZ2VzIGF0dGVtcHRlZCBp
bnN0ZWFkIG9mIHJlY2xhaW1lZCBhcyBpdCBpcyByZWFsbHkgd2hhdCB0aGUNCj4gY2dyb3VwIGNh
bGxlciBuZWVkcyB0byB0cmFjayBwcm9ncmVzcy4gVGhpcyBmdXJ0aGVyIHNpbXBsaWZpZXMgdGhl
IGRlc2lnbi4NCj4gLSBNZXJnZSBwYXRjaCBmb3IgZXhwb3Npbmcgc2d4X3JlY2xhaW1fcGFnZXMo
KSB3aXRoIGJhc2ljIHN5bmNocm9ub3VzDQo+IHJlY2xhbWF0aW9uLiAoS2FpKQ0KDQooQXMgbWVu
dGlvbmVkIGFib3ZlLCBJIGFtIG5vdCBzdXJlIEkgc3VnZ2VzdGVkIHRoaXMgYnV0IGFueXdheS4u
LikNCg0KPiAtIFNob3J0ZW4gbmFtZXMgZm9yIEVQQyBjZ3JvdXAgZnVuY3Rpb25zLiAoSmFya2tv
KQ0KPiAtIEZpeC9hZGQgY29tbWVudHMgdG8ganVzdGlmeSB0aGUgZGVzaWduIChLYWkpDQo+IC0g
U2VwYXJhdGUgb3V0IGEgaGVscGVyIGZvciBmb3IgYWRkcmVzc2luZyBzaW5nbGUgaXRlcmF0aW9u
IG9mIHRoZSBsb29wDQo+IGluIHNneF9jZ3JvdXBfdHJ5X2NoYXJnZSgpLiAoSmFya2tvKQ0KPiAN
Cj4gVjk6DQo+IC0gQWRkIGNvbW1lbnRzIGZvciBzdGF0aWMgdmFyaWFibGVzLiAoSmFya2tvKQ0K
PiANCj4gVjg6DQo+IC0gVXNlIHdpZHRoIG9mIDgwIGNoYXJhY3RlcnMgaW4gdGV4dCBwYXJhZ3Jh
cGhzLiAoSmFya2tvKQ0KPiAtIFJlbW92ZSBhbGlnbm1lbnQgZm9yIHN1YnN0cnVjdHVyZSB2YXJp
YWJsZXMuIChKYXJra28pDQo+IA0KPiBWNzoNCj4gLSBSZXdvcmtlZCBmcm9tIHBhdGNoIDkgb2Yg
VjYsICJ4ODYvc2d4OiBSZXN0cnVjdHVyZSB0b3AtbGV2ZWwgRVBDIHJlY2xhaW0NCj4gZnVuY3Rp
b24iLiBEbyBub3Qgc3BsaXQgdGhlIHRvcCBsZXZlbCBmdW5jdGlvbiAoS2FpKQ0KPiAtIERyb3Bw
ZWQgcGF0Y2hlcyA3IGFuZCA4IG9mIFY2Lg0KPiAtIFNwbGl0IHRoaXMgb3V0IGZyb20gdGhlIGJp
ZyBwYXRjaCwgIzEwIGluIFY2LiAoRGF2ZSwgS2FpKQ0KPiAtLS0NCj4gIGFyY2gveDg2L2tlcm5l
bC9jcHUvc2d4L2VwY19jZ3JvdXAuYyB8IDEyNyArKysrKysrKysrKysrKysrKysrKysrKysrKy0N
Cj4gIGFyY2gveDg2L2tlcm5lbC9jcHUvc2d4L2VwY19jZ3JvdXAuaCB8ICAgNSArLQ0KPiAgYXJj
aC94ODYva2VybmVsL2NwdS9zZ3gvbWFpbi5jICAgICAgIHwgIDQ1ICsrKysrKy0tLS0NCj4gIGFy
Y2gveDg2L2tlcm5lbC9jcHUvc2d4L3NneC5oICAgICAgICB8ICAgMSArDQo+ICA0IGZpbGVzIGNo
YW5nZWQsIDE1NiBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9lcGNfY2dyb3VwLmMgYi9hcmNoL3g4Ni9rZXJu
ZWwvY3B1L3NneC9lcGNfY2dyb3VwLmMNCj4gaW5kZXggYTFkZDQzYzE5NWIyLi5mN2E0ODdhMjll
ZDEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L2VwY19jZ3JvdXAuYw0K
PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9lcGNfY2dyb3VwLmMNCj4gQEAgLTksMTYg
KzksMTM2IEBADQo+ICBzdGF0aWMgc3RydWN0IHNneF9jZ3JvdXAgc2d4X2NnX3Jvb3Q7DQo+ICAN
Cj4gIC8qKg0KPiAtICogc2d4X2Nncm91cF90cnlfY2hhcmdlKCkgLSB0cnkgdG8gY2hhcmdlIGNn
cm91cCBmb3IgYSBzaW5nbGUgRVBDIHBhZ2UNCj4gKyAqIHNneF9jZ3JvdXBfbHJ1X2VtcHR5KCkg
LSBjaGVjayBpZiBhIGNncm91cCB0cmVlIGhhcyBubyBwYWdlcyBvbiBpdHMgTFJVcw0KPiArICog
QHJvb3Q6CVJvb3Qgb2YgdGhlIHRyZWUgdG8gY2hlY2sNCj4gKyAqDQo+ICsgKiBVc2VkIHRvIGF2
b2lkIGxpdmVsb2NrcyBkdWUgdG8gYSBjZ3JvdXAgaGF2aW5nIGEgbm9uLXplcm8gY2hhcmdlIGNv
dW50IGJ1dA0KPiArICogbm8gcGFnZXMgb24gaXRzIExSVXMsIGUuZy4gZHVlIHRvIGEgZGVhZCBl
bmNsYXZlIHdhaXRpbmcgdG8gYmUgcmVsZWFzZWQgb3INCj4gKyAqIGJlY2F1c2UgYWxsIHBhZ2Vz
IGluIHRoZSBjZ3JvdXAgYXJlIHVucmVjbGFpbWFibGUuDQoNCkkgZG9uJ3QgdGhpbmsgdGhpcyBj
b21tZW50ICh0aGUgcGFyYWdyYXBoIHN0YXJ0aW5nIGZyb20gIlVzZWQiKSBzaG91bGQgYmUgaGVy
ZSwNCmJ1dCBzaG91bGQgYmUgcHV0IHRvIHRoZSBjb2RlIHdoZXJlIGl0IGFwcGxpZXMuDQrCoA0K
Q29tbWVudCB3aGF0IHRoaXMgZnVuY3Rpb24gZG9lcyBpbnN0ZWFkLg0KDQo+ICsgKg0KPiArICog
UmV0dXJuOiAldHJ1ZSBpZiBhbGwgY2dyb3VwcyB1bmRlciB0aGUgc3BlY2lmaWVkIHJvb3QgaGF2
ZSBlbXB0eSBMUlUgbGlzdHMuDQo+ICsgKi8NCj4gK3N0YXRpYyBib29sIHNneF9jZ3JvdXBfbHJ1
X2VtcHR5KHN0cnVjdCBtaXNjX2NnICpyb290KQ0KPiArew0KPiArCXN0cnVjdCBjZ3JvdXBfc3Vi
c3lzX3N0YXRlICpjc3Nfcm9vdDsNCj4gKwlzdHJ1Y3QgY2dyb3VwX3N1YnN5c19zdGF0ZSAqcG9z
Ow0KPiArCXN0cnVjdCBzZ3hfY2dyb3VwICpzZ3hfY2c7DQo+ICsJYm9vbCByZXQgPSB0cnVlOw0K
PiArDQo+ICsJLyoNCj4gKwkgKiBDYWxsZXIgZW5zdXJlIGNzc19yb290IHJlZiBhY3F1aXJlZA0K
PiArCSAqLw0KDQoJLyogVGhlIGNhbGxlciBtdXN0IGVuc3VyZSAuLi4gKi8NCg0KPiArCWNzc19y
b290ID0gJnJvb3QtPmNzczsNCj4gKw0KPiArCXJjdV9yZWFkX2xvY2soKTsNCj4gKwljc3NfZm9y
X2VhY2hfZGVzY2VuZGFudF9wcmUocG9zLCBjc3Nfcm9vdCkgew0KPiArCQlpZiAoIWNzc190cnln
ZXQocG9zKSkNCj4gKwkJCWJyZWFrOw0KPiArDQo+ICsJCXJjdV9yZWFkX3VubG9jaygpOw0KPiAr
DQo+ICsJCXNneF9jZyA9IHNneF9jZ3JvdXBfZnJvbV9taXNjX2NnKGNzc19taXNjKHBvcykpOw0K
PiArDQo+ICsJCXNwaW5fbG9jaygmc2d4X2NnLT5scnUubG9jayk7DQo+ICsJCXJldCA9IGxpc3Rf
ZW1wdHkoJnNneF9jZy0+bHJ1LnJlY2xhaW1hYmxlKTsNCj4gKwkJc3Bpbl91bmxvY2soJnNneF9j
Zy0+bHJ1LmxvY2spOw0KPiArDQo+ICsJCXJjdV9yZWFkX2xvY2soKTsNCj4gKwkJY3NzX3B1dChw
b3MpOw0KPiArCQlpZiAoIXJldCkNCj4gKwkJCWJyZWFrOw0KPiArCX0NCj4gKw0KPiArCXJjdV9y
ZWFkX3VubG9jaygpOw0KPiArDQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiArLyoqDQo+
ICsgKiBzZ3hfY2dyb3VwX3JlY2xhaW1fcGFnZXMoKSAtIHJlY2xhaW0gRVBDIGZyb20gYSBjZ3Jv
dXAgdHJlZQ0KPiArICogQHJvb3Q6CVRoZSByb290IG9mIGNncm91cCB0cmVlIHRvIHJlY2xhaW0g
ZnJvbS4NCj4gICAqDQo+ICsgKiBUaGlzIGZ1bmN0aW9uIHBlcmZvcm1zIGEgcHJlLW9yZGVyIHdh
bGsgaW4gdGhlIGNncm91cCB0cmVlIHVuZGVyIHRoZSBnaXZlbg0KPiArICogcm9vdCwgYXR0ZW1w
dGluZyB0byByZWNsYWltIHBhZ2VzIGF0IGVhY2ggbm9kZSB1bnRpbCBhIGZpeGVkIG51bWJlciBv
ZiBwYWdlcw0KPiArICogKCVTR1hfTlJfVE9fU0NBTikgYXJlIGF0dGVtcHRlZCBmb3IgcmVjbGFt
YXRpb24uwqBObyBndWFyYW50ZWUgb2Ygc3VjY2VzcyBvbg0KPiArICogdGhlIGFjdHVhbCByZWNs
YW1hdGlvbiBwcm9jZXNzLiBJbiBleHRyZW1lIGNhc2VzLCBpZiBhbGwgcGFnZXMgaW4gZnJvbnQg
b2YNCj4gKyAqIHRoZSBMUlVzIGFyZSByZWNlbnRseSBhY2Nlc3NlZCwgaS5lLiwgY29uc2lkZXJl
ZCAidG9vIHlvdW5nIiB0byByZWNsYWltLCBubw0KPiArICogcGFnZSB3aWxsIGFjdHVhbGx5IGJl
IHJlY2xhaW1lZCBhZnRlciB3YWxraW5nIHRoZSB3aG9sZSB0cmVlLg0KPiArICoNCj4gKyAqIENh
bGxlcnMgY2hlY2sgZm9yIHRoZSBuZWVkIGZvciByZWNsYW1hdGlvbiBiZWZvcmUgY2FsbGluZyB0
aGlzIGZ1bmN0aW9uLiBTb21lDQo+ICsgKiBjYWxsZXJzIG1heSBydW4gdGhpcyBmdW5jdGlvbiBp
biBhIGxvb3AgZ3VhcmRlZCBieSBzb21lIGNyaXRlcmlhIGZvcg0KPiArICogdHJpZ2dlcmluZyBy
ZWNsYW1hdGlvbiwgYW5kIGNhbGwgY29uZF9yZXNjaGVkKCkgaW4gYmV0d2VlbiBpdGVyYXRpb25z
IHRvDQo+ICsgKiBhdm9pZCBpbmRlZmluaXRlIGJsb2NraW5nLg0KDQpEaXR0byBJTUhPIHRoZSBz
ZWNvbmQgcGFyYWdyYXBoIGlzbid0IG5lY2Vzc2FyeS4gIEJ1dCBhbnl3YXkuDQoNCj4gKyAqLw0K
PiArc3RhdGljIHZvaWQgc2d4X2Nncm91cF9yZWNsYWltX3BhZ2VzKHN0cnVjdCBtaXNjX2NnICpy
b290KQ0KPiArew0KPiArCXN0cnVjdCBjZ3JvdXBfc3Vic3lzX3N0YXRlICpjc3Nfcm9vdDsNCj4g
KwlzdHJ1Y3QgY2dyb3VwX3N1YnN5c19zdGF0ZSAqcG9zOw0KPiArCXN0cnVjdCBzZ3hfY2dyb3Vw
ICpzZ3hfY2c7DQo+ICsJdW5zaWduZWQgaW50IGNudCA9IDA7DQo+ICsNCj4gKwkgLyogQ2FsbGVy
IGVuc3VyZSBjc3Nfcm9vdCByZWYgYWNxdWlyZWQgKi8NCj4gKwljc3Nfcm9vdCA9ICZyb290LT5j
c3M7DQo+ICsNCj4gKwlyY3VfcmVhZF9sb2NrKCk7DQo+ICsJY3NzX2Zvcl9lYWNoX2Rlc2NlbmRh
bnRfcHJlKHBvcywgY3NzX3Jvb3QpIHsNCj4gKwkJaWYgKCFjc3NfdHJ5Z2V0KHBvcykpDQo+ICsJ
CQlicmVhazsNCj4gKwkJcmN1X3JlYWRfdW5sb2NrKCk7DQo+ICsNCj4gKwkJc2d4X2NnID0gc2d4
X2Nncm91cF9mcm9tX21pc2NfY2coY3NzX21pc2MocG9zKSk7DQo+ICsJCWNudCArPSBzZ3hfcmVj
bGFpbV9wYWdlcygmc2d4X2NnLT5scnUpOw0KPiArDQo+ICsJCXJjdV9yZWFkX2xvY2soKTsNCj4g
KwkJY3NzX3B1dChwb3MpOw0KPiArDQo+ICsJCWlmIChjbnQgPj0gU0dYX05SX1RPX1NDQU4pDQo+
ICsJCQlicmVhazsNCj4gKwl9DQo+ICsNCj4gKwlyY3VfcmVhZF91bmxvY2soKTsNCj4gK30NCj4g
Kw0KPiArc3RhdGljIGludCBfX3NneF9jZ3JvdXBfdHJ5X2NoYXJnZShzdHJ1Y3Qgc2d4X2Nncm91
cCAqZXBjX2NnKQ0KPiArew0KPiArCWlmICghbWlzY19jZ190cnlfY2hhcmdlKE1JU0NfQ0dfUkVT
X1NHWF9FUEMsIGVwY19jZy0+Y2csIFBBR0VfU0laRSkpDQo+ICsJCXJldHVybiAwOw0KPiArDQo+
ICsJaWYgKHNneF9jZ3JvdXBfbHJ1X2VtcHR5KGVwY19jZy0+Y2cpKQ0KPiArCQlyZXR1cm4gLUVO
T01FTTsNCj4gKw0KPiArCWlmIChzaWduYWxfcGVuZGluZyhjdXJyZW50KSkNCj4gKwkJcmV0dXJu
IC1FUkVTVEFSVFNZUzsNCj4gKw0KPiArCXJldHVybiAtRUJVU1k7DQo+ICt9DQo+ICsNCj4gKy8q
Kg0KPiArICogc2d4X2Nncm91cF90cnlfY2hhcmdlKCkgLSB0cnkgdG8gY2hhcmdlIGNncm91cCBm
b3IgYSBzaW5nbGUgRVBDIHBhZ2UNCj4gICAqIEBzZ3hfY2c6CVRoZSBFUEMgY2dyb3VwIHRvIGJl
IGNoYXJnZWQgZm9yIHRoZSBwYWdlLg0KPiArICogQHJlY2xhaW06CVdoZXRoZXIgb3Igbm90IHN5
bmNocm9ub3VzIEVQQyByZWNsYWltIGlzIGFsbG93ZWQuDQo+ICAgKiBSZXR1cm46DQo+ICAgKiAq
ICUwIC0gSWYgc3VjY2Vzc2Z1bGx5IGNoYXJnZWQuDQo+ICAgKiAqIC1lcnJubyAtIGZvciBmYWls
dXJlcy4NCj4gICAqLw0KPiAtaW50IHNneF9jZ3JvdXBfdHJ5X2NoYXJnZShzdHJ1Y3Qgc2d4X2Nn
cm91cCAqc2d4X2NnKQ0KPiAraW50IHNneF9jZ3JvdXBfdHJ5X2NoYXJnZShzdHJ1Y3Qgc2d4X2Nn
cm91cCAqc2d4X2NnLCBlbnVtIHNneF9yZWNsYWltIHJlY2xhaW0pDQo+ICB7DQo+IC0JcmV0dXJu
IG1pc2NfY2dfdHJ5X2NoYXJnZShNSVNDX0NHX1JFU19TR1hfRVBDLCBzZ3hfY2ctPmNnLCBQQUdF
X1NJWkUpOw0KPiArCWludCByZXQ7DQo+ICsNCj4gKwlmb3IgKDs7KSB7DQo+ICsJCXJldCA9IF9f
c2d4X2Nncm91cF90cnlfY2hhcmdlKHNneF9jZyk7DQo+ICsNCj4gKwkJaWYgKHJldCAhPSAtRUJV
U1kpDQo+ICsJCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJCWlmIChyZWNsYWltID09IFNHWF9OT19S
RUNMQUlNKQ0KPiArCQkJcmV0dXJuIC1FTk9NRU07DQo+ICsNCj4gKwkJc2d4X2Nncm91cF9yZWNs
YWltX3BhZ2VzKHNneF9jZy0+Y2cpOw0KPiArCQljb25kX3Jlc2NoZWQoKTsNCj4gKwl9DQo+ICsN
Cj4gKwlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiAgLyoqDQo+IEBAIC01MCw2ICsxNzAsNyBAQCBj
b25zdCBzdHJ1Y3QgbWlzY19yZXNfb3BzIHNneF9jZ3JvdXBfb3BzID0gew0KPiAgDQo+ICBzdGF0
aWMgdm9pZCBzZ3hfY2dyb3VwX21pc2NfaW5pdChzdHJ1Y3QgbWlzY19jZyAqY2csIHN0cnVjdCBz
Z3hfY2dyb3VwICpzZ3hfY2cpDQo+ICB7DQo+ICsJc2d4X2xydV9pbml0KCZzZ3hfY2ctPmxydSk7
DQo+ICAJY2ctPnJlc1tNSVNDX0NHX1JFU19TR1hfRVBDXS5wcml2ID0gc2d4X2NnOw0KPiAgCXNn
eF9jZy0+Y2cgPSBjZzsNCj4gIH0NCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUv
c2d4L2VwY19jZ3JvdXAuaCBiL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L2VwY19jZ3JvdXAuaA0K
PiBpbmRleCA4Zjc5NGUyM2ZhZDYuLmY2MmRjZTBjYWM1MSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94
ODYva2VybmVsL2NwdS9zZ3gvZXBjX2Nncm91cC5oDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9j
cHUvc2d4L2VwY19jZ3JvdXAuaA0KPiBAQCAtMjAsNyArMjAsNyBAQCBzdGF0aWMgaW5saW5lIHN0
cnVjdCBzZ3hfY2dyb3VwICpzZ3hfZ2V0X2N1cnJlbnRfY2codm9pZCkNCj4gIA0KPiAgc3RhdGlj
IGlubGluZSB2b2lkIHNneF9wdXRfY2coc3RydWN0IHNneF9jZ3JvdXAgKnNneF9jZykgeyB9DQo+
ICANCj4gLXN0YXRpYyBpbmxpbmUgaW50IHNneF9jZ3JvdXBfdHJ5X2NoYXJnZShzdHJ1Y3Qgc2d4
X2Nncm91cCAqc2d4X2NnKQ0KPiArc3RhdGljIGlubGluZSBpbnQgc2d4X2Nncm91cF90cnlfY2hh
cmdlKHN0cnVjdCBzZ3hfY2dyb3VwICpzZ3hfY2csIGVudW0gc2d4X3JlY2xhaW0gcikNCg0KSXMg
dGhlIEByIGhlcmUgaW50ZW50aW9uYWwgZm9yIHNob3J0ZXIgdHlwaW5nPw0KDQpbLi4uXQ0KDQo+
IEBAIC01NzIsNyArNTgzLDcgQEAgc3RydWN0IHNneF9lcGNfcGFnZSAqc2d4X2FsbG9jX2VwY19w
YWdlKHZvaWQgKm93bmVyLCBlbnVtIHNneF9yZWNsYWltIHJlY2xhaW0pDQo+ICAJaW50IHJldDsN
Cj4gIA0KPiAgCXNneF9jZyA9IHNneF9nZXRfY3VycmVudF9jZygpOw0KPiAtCXJldCA9IHNneF9j
Z3JvdXBfdHJ5X2NoYXJnZShzZ3hfY2cpOw0KPiArCXJldCA9IHNneF9jZ3JvdXBfdHJ5X2NoYXJn
ZShzZ3hfY2csIHJlY2xhaW0pOw0KPiAgCWlmIChyZXQpIHsNCj4gIAkJc2d4X3B1dF9jZyhzZ3hf
Y2cpOw0KPiAgCQlyZXR1cm4gRVJSX1BUUihyZXQpOw0KPiBAQCAtNjA0LDcgKzYxNSw3IEBAIHN0
cnVjdCBzZ3hfZXBjX3BhZ2UgKnNneF9hbGxvY19lcGNfcGFnZSh2b2lkICpvd25lciwgZW51bSBz
Z3hfcmVjbGFpbSByZWNsYWltKQ0KPiAgCQkgKiBOZWVkIHRvIGRvIGEgZ2xvYmFsIHJlY2xhbWF0
aW9uIGlmIGNncm91cCB3YXMgbm90IGZ1bGwgYnV0IGZyZWUNCj4gIAkJICogcGh5c2ljYWwgcGFn
ZXMgcnVuIG91dCwgY2F1c2luZyBfX3NneF9hbGxvY19lcGNfcGFnZSgpIHRvIGZhaWwuDQo+ICAJ
CSAqLw0KPiAtCQlzZ3hfcmVjbGFpbV9wYWdlcygpOw0KPiArCQlzZ3hfcmVjbGFpbV9wYWdlc19n
bG9iYWwoKTsNCj4gIAkJY29uZF9yZXNjaGVkKCk7DQo+ICAJfQ0KDQpJIHdpc2ggd2UgY291bGQg
cHV0IHRoZSByZXN1bHQgb2YgZGlzY3Vzc2lvbiBhcm91bmQgInBlci1jZ3JvdXAgcmVjbGFpbSIg
dnMNCiJnbG9iYWwgcmVjbGFpbSIgd2hlbiB0cnlfY2hhcmdlKCkgc3VjY2VlZHMgYnV0IHN0aWxs
IGZhaWxzIHRvIGFsbG9jYXRlIHRvIHRoZQ0KY2hhbmdlbG9nOg0KDQpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sa21sL2EyZDYzM2RhLTZhYjgtNDlkMC1iY2E1LTFlOWViN2MzZmM5YUBpbnRlbC5j
b20vDQoNCkJ1dCBwZXJoYXBzIGl0IGlzIGp1c3QgbWUgdGhhdCB0aGlua3MgdGhpcyBiZXR0ZXIg
dG8gYmUgY2xhcmlmaWVkIGluIGNoYW5nZWxvZywNCnNvIHVwIHRvIHlvdS4NCg0KKGJ0dywgbG9v
a3MgYW5vdGhlciByZWFzb24gdG8gc3BsaXQgdGhlICJjZ3JvdXAiIEVQQyByZWNsYWltIGZ1bmN0
aW9uIG91dCBhcyBhDQpzZXBhcmF0ZSBwYXRjaCwgYnV0IGFnYWluLCB1cCB0byB5b3UuKQ0KDQoN
Cg0KDQoNCg==

