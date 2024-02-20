Return-Path: <cgroups+bounces-1715-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E45FC85C586
	for <lists+cgroups@lfdr.de>; Tue, 20 Feb 2024 21:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683BF1F217AE
	for <lists+cgroups@lfdr.de>; Tue, 20 Feb 2024 20:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF2814A4E6;
	Tue, 20 Feb 2024 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TkLsZ3v2"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36386BFB8;
	Tue, 20 Feb 2024 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459768; cv=fail; b=KHYqid9HUlM2HB7SXYDzCdVRzotu8P9HndlBbMZEPL6KZ3UYTHz6WywGlivs+E7RTBgp1DsPPt3plS+SVcKuxWsOiupGvfSbiqLNlrquL/s8ftZiSwBj8TpsyCNdp6GvadaYwBcd9C5y0p9x7nKwR6XS5Cw+IpUCzBbnD1KynwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459768; c=relaxed/simple;
	bh=kWuh5OPm0QMuiHX5p4jx2tRJ+WarLh+Zbnzjt0kvIQE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QLasPgIeq7ldRR9hj5Z1++2t9nQYGKpcYx32UK3ETLDy9zZ/hJURJyVk0uYJmZJZmnOAMraVT9/EXCM1bCFJVNkrWf1QlyrwhYFiPhxYUIEwNEMgNgvahHhSIMlBgy+0mio7OXTYz2tYtZ0pORrrJo1T7tBoJYxxZZgm7g3ndxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TkLsZ3v2; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708459767; x=1739995767;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kWuh5OPm0QMuiHX5p4jx2tRJ+WarLh+Zbnzjt0kvIQE=;
  b=TkLsZ3v2WiVigOe1nZWSIaXFKj0BcoZXQzgGpVng2roAfXYoj2cJqQnV
   qpMPwqlRTRl53hTyVE6XM6fYeZhWKmiM4Tf5vUurH2FAc/py/QBKpOlYW
   yIJWNFrS4za7D8xYo85gERaZHveP8eFErw51AwxIysrCxJEL1JNPMXKMk
   /1dKBW1bHOrnoGBX/sK6nKgoTYxBfp2Fhuxl7xkOrFu7k2hX8OtZpsa+G
   iDBeW2rJnwJPc70koNYLmIdvORKhNVoRt7siv8UuhOe8r5i0d4QqwXzm0
   ShPWei5Ey8cCryfvEKzevsfPte96CafBc/0MVtUUoOQCtCFsOrWZc7wnE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="6414813"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="6414813"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 12:09:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9540984"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 12:09:26 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 12:09:25 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 12:09:25 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 12:09:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RClcvBf+zyOvUOzF+eG8ZNraW+ku+B+B1aNiiiVs/PNxACJPhM7IstNV5KRRhihq7wpC99Ar7KduxzzVTQ4Tl1qoSlbzYnN0b5DGUjcGmkyzFd7o8NPW7XEpWCmME2q/uKoItpInIXOjGCO1/bfeOW1N785VwcqHJnhQ4UWQ3UNI8rhrnXXZCVfA3WFeDDP4x4pyuG2xp7xgfrpQ9Bg/QRNnaYVa6+IAWd/6W10q31c3cxxBA7NMVguCfqf+4BnGHaFGO9XEVBp9UqdlB4svXSbUA9wyGpgR50NbGD+xW8bU3zJtkC4sCPR9cp9Z3tJxQK0GJ/6mf5pghDkaxmXy7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWuh5OPm0QMuiHX5p4jx2tRJ+WarLh+Zbnzjt0kvIQE=;
 b=MD9fCa1jDZ0GyiSmrAGeh1A0bwmpH3hsAxgBBt8Wj0F0BFAvF5lCd4GkzHM8rWgyIaLJXi2AYEtI0PWcxPbbsxMWRwVkn3EYXsP7BOz2/gDdmzGDkqkGftHZWFgLiPR5istCsoRPR8TF4d33tdy8vJB4l/bOGepOzN2ILNZFK2QvB56USg+LY81RDEel4Lv3uyteVjjnwYcLi81U1fo9VKOeviK8wVnlB9k7zaBdt/dj9KP8Jf7Uv5lc7cj/yKliMnlLEzJYQAgFmL/3YH+0J4VPDIp6uPsYizbUglat8swFzxNHiRw9S6NrqG3S1zJDnU/a6OZORoUEBG2/Lamdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5344.namprd11.prod.outlook.com (2603:10b6:5:393::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.40; Tue, 20 Feb
 2024 20:09:22 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab%6]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 20:09:21 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "mkoutny@suse.com" <mkoutny@suse.com>
CC: "Zhang, Bo" <zhanb@microsoft.com>, "chrisyan@microsoft.com"
	<chrisyan@microsoft.com>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "yangjie@microsoft.com" <yangjie@microsoft.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>, "Li, Zhiquan1"
	<zhiquan1.li@intel.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"seanjc@google.com" <seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"tj@kernel.org" <tj@kernel.org>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "mikko.ylinen@linux.intel.com"
	<mikko.ylinen@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>
Subject: Re: Re: [PATCH v9 08/15] x86/sgx: Implement EPC reclamation flows for
 cgroup
Thread-Topic: Re: [PATCH v9 08/15] x86/sgx: Implement EPC reclamation flows
 for cgroup
Thread-Index: AQHaWH7Wr4F7uI4dL02icaTavGjkgLETFBIAgAA5jYCAAHLBAA==
Date: Tue, 20 Feb 2024 20:09:21 +0000
Message-ID: <964423dcf745ba5aab0f41a7da6cf5e04562a54b.camel@intel.com>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
	 <20240205210638.157741-9-haitao.huang@linux.intel.com>
	 <fa091e657c2d3f3cc14aff15ad3484e0d7079b6f.camel@intel.com>
	 <2ni2jychs6oe4ckplvbg7usrn7f4fsa2fi3ys6lrtyhbprpr7c@hokylc73dlwi>
In-Reply-To: <2ni2jychs6oe4ckplvbg7usrn7f4fsa2fi3ys6lrtyhbprpr7c@hokylc73dlwi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB5344:EE_
x-ms-office365-filtering-correlation-id: 70b78d78-385b-45af-56bb-08dc324fd385
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8D9sE4gQ3Yq5kU5qjEeS+L0GaKVaDhHBPuv8gQ6N5WV70lbk40k5z/43GZyK7VEqjgYl3seS29+EmBU4ZL7peeKuXdBfveZcY9MRHOACJOzqJms1ceRELOIR7CYksX9/bdE5bfFaMpcDVcgeYwTCAtcrvNY5Ge95UGATfriSzzTkvhD/FixV4V9KIBtRzguALgS4Ii5EYFHjotXtrYxQR6PN7pSheablHoOt3sVhmHgkf8X9M3s0SabY5WaBQ2u+v1Q6qJZms8WARGMgBtAP0zh5OlzD5/nLGYpM+by+Crp+OHRciTRmO/H/uDU+SF+L4DdfB6tzamvHEYe9elmeucJEGzPsZq2y25MU1busXpesvetr9YrH5I2zLntbiC6Q8iGElHtliLsxJ7m/eOdt9JxsXLK/LHlMCYkGsyoYjthyJNEayTVXb/aKGIeNAqaOYVkHeORlQnDzs61XhHQLb1Y8gniEaXXxea1GvihpMAVeaKT95K7lY74JGl1FFRmAZnCFfWxZ+siPWKr2Yh4O+6fdrtEgJh9zyutQS7ez3QTV7nv+S8YRHEWZT8OCqlEPY9mmp9SqA+j/xItaqD6PzRYUAh9nOyGmmtIgNqJ4Sw84SmjiHB0VYCDdy3kX5DAN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1QyWkFEeTRnZFR2VlJ1V3lsUkV4UzluWG1qSkgxdWw5dndPTncvb1V4STJR?=
 =?utf-8?B?NGZuZXNJTjVpS3NOMHJYTW1uWnU5eFJ2WkJ4M2trTU90VHRaSFAzb3FnMFBT?=
 =?utf-8?B?QmJueDJIVkhrUW1CcUpHK1ZGVzZyZC9GOGlGSlM5WlhQL0lxbmxiTExyT3Mr?=
 =?utf-8?B?eW1qOUlWQWcxb3JKeW0yVTZhcWNtMWUvM3JVZWxhTHVSUEp0UktaN3ErNkpX?=
 =?utf-8?B?Um9jaU1ZZ1laNXdSak5GUXV0NWxTbmxHNUU0L1NJbmE1K2lmUmt1U3hDcE9z?=
 =?utf-8?B?QkRWTzUrZkhaTFFZc2pOMVhUM2hBVlJUQ3pwNHBrQVpzSm1vRWRkYUhCTFJB?=
 =?utf-8?B?ZVUrUytPVFFLRHdrY2VTWk9BRGhYdmZDbHNJcUhSd3psUVdJeUpKRTlVRGQy?=
 =?utf-8?B?K2JsNmwzby8vOG5wa0RmMzV4Q0pndWFuL1F1d1N3Sklad1NsME1CcnI4dGdZ?=
 =?utf-8?B?WWViQzZDK0I1ZUNuNGlFd3BmUFBHRXdPcVEzSTRFd0l6SUo5QVZiVWJqWS9I?=
 =?utf-8?B?OFVkYXN0ejQ3WDdyanZITi82dm5zK3NpdHlYcitpekgzaVV6czRVQzVnVW1D?=
 =?utf-8?B?UGtHTmlJUE0zVytTV3hlSHpaeG91Q2FuTWJCcmdnQmZSNjRWeEdCcWFtVnpD?=
 =?utf-8?B?OWNRUE4zSDRNQUdPcmluckw3WUJkQkV0TlRua0d0ZnNXTjljbXNsRGxRTWVr?=
 =?utf-8?B?cEhXSE5mcGJscHdwOFRkT0RZd2J4eTlxUDJkZHJrR3FUUVBSaGpjbmdzSERr?=
 =?utf-8?B?L0dpUVUvMXJCcU9HbUMzaWtLK0x2ZWhidEtIcC9rcERDOGoya0xUbDNUa3pI?=
 =?utf-8?B?MVY1Nm1YNFo1Z2JKbjhyTXgxSGhmKzdZUllhOUlIb1ljZnk5YzNGQ0I5TGJ2?=
 =?utf-8?B?azgyb0ZHbkZ1V2V2TEpZT1ZUQUcvV0k2WW52RXRtc2p1bXE3bGNIUWNGaVFF?=
 =?utf-8?B?aXNTNFEwSUhYV0xhNFkzdjl5ZGk2MHJ1MUY0Sm1UdjRTMFJrWS9vL2hTMG51?=
 =?utf-8?B?VElmM0M4KytHZHMzMWxzdUtZNGlVMERKbVdwa2MycjFSbkk1TERGUUZxVHA2?=
 =?utf-8?B?RDFVRkJnSlZxZnpNK2lpZU1KT24zbFExTXNVdGpNaTdMRlpIaU13VXRKYTZt?=
 =?utf-8?B?TzZkNnRNMDEvOVJhQkp0bG9NSkNYTmd6bld6OXFqaUhhM1NoZlN5ZHc4NFIy?=
 =?utf-8?B?ZitOMGJXRW50V2I3ejZRYTI5U1V5SmNiR0RsUFBQTVpmQm0vZHFTMTBYWHdF?=
 =?utf-8?B?bm1VRjdFU2d1SW8xUkVMb3ltcjZtbGE4ZDVQTjl4OFYySUhmck8reXhPMGtm?=
 =?utf-8?B?MEdVcy9NS21IQkQ2Nmcvd0R3enBLaXJJclpKWXVqaERENWFFQW5pQ09BZzMv?=
 =?utf-8?B?Q3JhN2JQNzFqUjRMS1lBc3pwZzRKSWVtUjlremdmcE9IamR1YkdlV1R6WmVw?=
 =?utf-8?B?bG95clYzZnBFbHBHRk5VOFJMR3oyNVZkTXA5LzZFT0RBb09sbGczckNqNjI5?=
 =?utf-8?B?S2ozVnhsVkxXb0d4eUdPaytyY2VBQmhjMjBwaGNweHdQaUhyVmlxY0p1U28w?=
 =?utf-8?B?TEFPYVl5TUxBSUhQdzN2cVBSOVpyMlRPNVk3TEFObkJuVUpkbndKMWcxVnBG?=
 =?utf-8?B?b0JuMkhZNC9nYXZuMkxvVUVKSHhkbTV2Ykh2WFUxQ0dpczlyWDAxNlZLS0xW?=
 =?utf-8?B?QitHZnpqYUJaNmJvSEdSYW1wRE5IMm9mTnFoaUZkRzYzSCtraDNMY1ozRUs5?=
 =?utf-8?B?RXl4aUlCZ1VyNEdNUUNhcmMrbFBmU3hxRkEwaUd2cEVFSjNBK2wzUkppR3ZQ?=
 =?utf-8?B?NkYrdlErWWRsSk1tOE1DeFlWaTN6M3Nna0crY0tmWnNXbnplQzNjWFdRU3h2?=
 =?utf-8?B?NGdSMjZhMnJvOVdtVXBZaVphaFJxNmFuRWMwOVlWc25YbVFMa3RMOFZiVVcz?=
 =?utf-8?B?bzlaVVN1MCtQeDJXR2xKMEdPTmNuV2NLSUErbFRlWGprNzNTS3AySWhmM2NY?=
 =?utf-8?B?bEk5R1ZpQytOK1RMaXFFY2hKZ0ZnVHN1R29NS0hlYTh3bFp3SE9SUS9Edkpo?=
 =?utf-8?B?SndrcGNYdjlKMDg1Wno1c25TcVdZYmtsM2srRGVzQzk5VkF2Z0N4aHZ4clFl?=
 =?utf-8?B?WmNVVEJnZDRHRGIxbDBsajZwLzhpc2x6WHR4QVZtbGlueUdJQ0wyaGZRTXpz?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F345F9245F75D408CB0731A964D3BB5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b78d78-385b-45af-56bb-08dc324fd385
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 20:09:21.1664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: smIW1ZJU137w76M98hoep4CiR85zmrQJ2v4+/Z33m1e8fhX9iSVByoUpgH8INEfQLbvjhfftCxlQvvPWX8GpXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5344
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTAyLTIwIGF0IDE0OjE4ICswMTAwLCBNaWNoYWwgS291dG7DvSB3cm90ZToN
Cj4gT24gVHVlLCBGZWIgMjAsIDIwMjQgYXQgMDk6NTI6MzlBTSArMDAwMCwgIkh1YW5nLCBLYWki
IDxrYWkuaHVhbmdAaW50ZWwuY29tPiB3cm90ZToNCj4gPiBJIGFtIG5vdCBzdXJlLCBidXQgaXMg
aXQgcG9zc2libGUgb3IgbGVnYWwgZm9yIGFuIGFuY2VzdG9yIHRvIGhhdmUgbGVzcyBsaW1pdA0K
PiA+IHRoYW4gY2hpbGRyZW4/DQo+IA0KPiBXaHkgbm90Pw0KPiBJdCBpcyBkZXNpcmVkIGZvciBw
cm9wZXIgaGllYXJjaGljYWwgZGVsZWdhdGlvbiBhbmQgdGhlIHRpZ2h0ZXN0IGxpbWl0DQo+IG9m
IGFuY2VzdG9ycyBhcHBsaWVzIChjZiBtZW1vcnkubWF4KS4NCj4gDQoNCk9LLiAgVGhhbmtzIGZv
ciB0aGUgaW5mby4NCg==

