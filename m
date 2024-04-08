Return-Path: <cgroups+bounces-2369-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F3B89BED2
	for <lists+cgroups@lfdr.de>; Mon,  8 Apr 2024 14:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6821F23C87
	for <lists+cgroups@lfdr.de>; Mon,  8 Apr 2024 12:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDD17BAFD;
	Mon,  8 Apr 2024 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U267flYx"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FA37B3E5;
	Mon,  8 Apr 2024 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578835; cv=fail; b=QMcNYCEE+EptRRnozRJ2jg83qWgGPe/5mJKroVTVJ1/vT9Y/WeEqP8uIqWBQ9RtFiU/hxHdkRYkGWIwYNxA0QcprcutVDRZRXj0ypcunTQX78dSuQyPxuWJwgLOS/0TGNTy65686DFin5UaY/XCiXJj7JlSwDARxwu184edtgYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578835; c=relaxed/simple;
	bh=M4jyffjxjACJkEFti+xejKJpoK/sP+3cxWO1UXo6EK8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L/8EJi7/UJdtJYLMo8eJfhJWx1r1tnZYvFfhDFlNxIygbrWuGUBLdsDYuxm+6AHbX5e4WHK87MAALWuiHTjILSXem1jrILeUrE9JPLZu8Y9kAOu4Yj7r1tcDYZrM1Xx3NEjFHERu9REoE7nE+glHVfYLVZpuhInCz1OhvabMt/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U267flYx; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712578833; x=1744114833;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M4jyffjxjACJkEFti+xejKJpoK/sP+3cxWO1UXo6EK8=;
  b=U267flYx1TQpS6VHUkN+wxz4x5XSOnf0C1OCgFerOiTjyLKMhSnTbrAW
   6wBj/A9+cXUNuDI1Hkc+nDszCgspZw5zdA0wJP6FhuOA8tWSIsgNnQm/x
   UXbJngXCyPjDFvPxLZ8nhP8Rct3SUNTJfXGwmvSlOaaTm8eZsk071wXAq
   OUu8tPWRBLAfKjuzbtDs0iotPETgKYj6ZOeI0Ranginh9ovEK7Vl3z8w1
   nkaV7o1cLH+B12qBWVANtrHPm2bEfno2RO/heKinK9HAydLURBe6d8f+A
   NEYX7T1aOM3L8kXX3f57L4wzV4M499AwLdgAzRbJEkc358oeJHpR4E7Ym
   A==;
X-CSE-ConnectionGUID: oaGL+VIBT72n2CQZQxNPeA==
X-CSE-MsgGUID: TRyYIHQaQuudUDCZnuwOPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="10822847"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="10822847"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 05:20:32 -0700
X-CSE-ConnectionGUID: i8hQeeRbQQ2Kk6gB7rN7+g==
X-CSE-MsgGUID: aoz6kTC4T3SVvAG3fnJmhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="24358329"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 05:20:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 05:20:31 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 05:20:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 05:20:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 05:20:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQSXhWRSEJZYSYriYytYjSQG2YmurGWAyZZoPvxq/ElxV4hymq9MaYqlIVi2N5q6njC1o78Lue46PLhkh5t8Dm2aKRUrLQt490MDGUo3sDRLvj4xHJf5sY+t+a8ciciutoWS3p4U9OCWAD+G64lK3W7xKRZt8YpvmpcC/hdfK1mP2Z/2zVAHFAS0G1XXVEPh5fM79rQoAGgQewYij5Md4LoKGJJiglnsCeH+j+Vc/LMA8Ga9K5p2iSSicdEy2gOlVR/KPkRQFqBu80Bd4WvyzLkFPu+biHyfBkoyGhJ5Wv8+IlvFh7+UI5Qawb7ul4kjD7est+hvCLx/lmybqVaSKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4jyffjxjACJkEFti+xejKJpoK/sP+3cxWO1UXo6EK8=;
 b=XvncJwfgQS6HCCNKut7EtXq08hosZcZHkLNe03b4g2iYIJsQBSnPfwMD7y+l7nU67OHINYeAvdFANBTQaKL+QeIK1g0B67s5m3H1dKVT3+NzwW981LwlkxQrY66R2uCm5S1bsm4nfqzj3pMBauDQ6alV+eXlGqc/k8kvSWbrD2pa2z8qnpW2+uzt6ZIbvgAQRab/vJrcKmmsEfIKcR0jZqPVLEmZeumYGD8+XuBFyxYRapvv0bRIlo0H0k0fa1VoAMmJw7TkpwmpXEEf+weVg/LCUdtWGtjOnNMlQo6aHh8kqOOf5xJD9fZETwFLwUH5dAIIjpff6xSOsr+HGAosBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA1PR11MB8492.namprd11.prod.outlook.com (2603:10b6:806:3a3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10; Mon, 8 Apr
 2024 12:20:23 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 12:20:23 +0000
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
Subject: Re: [PATCH v10 12/14] x86/sgx: Turn on per-cgroup EPC reclamation
Thread-Topic: [PATCH v10 12/14] x86/sgx: Turn on per-cgroup EPC reclamation
Thread-Index: AQHagKYKcC4zjW/mDkq0Hd0XGeUmBrFeXPIA
Date: Mon, 8 Apr 2024 12:20:23 +0000
Message-ID: <d25dbe76d48a0b6c74fa09b06f1ca3fdf234a190.camel@intel.com>
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
	 <20240328002229.30264-13-haitao.huang@linux.intel.com>
In-Reply-To: <20240328002229.30264-13-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA1PR11MB8492:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OJFq9/qyv5ladg8s6Mt7kT99AKXXUMIDsHMyl1faJiMVbuWzV0uDRDFSFHc1cxkMi3QWNak6oJsYRTXK0/8JXHXb3RbYTIPlrJEK2YY9ibDnmEtaXBQqGKZTgJkuvUCUK0uhRQHZa97fos/KPXegRT9Kmddp99wDLgJClfgeV/b0rdzsY6ANhY2lFnN7D2pr8U4zhoCpXZur+jurHDgSa2fUhZ75iwX2SaKqb2G4h69UgBXPpnhMBWyzd2K+fXh5aW91W2FvAP/KPNt2VNu1+REszcnG5J0MIF4uWftfOinIGqMIkR/GA2XjSffQQjI6MOEPCk0UvwythyVlpOfQZo3rA8tvzxMKbGom2UpUvvkJFJRsrlUwFLrMaIjwyMhKHOgRrohR9sCvBWNU2yrEF9ODsle40gJX9WVxQ6IO/iN7SXivaQ6EXvnhOObkYTTkXKNJP+ICmyur/DdQ1V4cSjIIoUMmfmVOBsmPrA96ySRLVpo05FVuHh8tCTgz1Zd4IKupTUJiLylfFXGjfSxEhbuecmGeZb6zRpfgMjL6jjWQvLSmbI8SU48tMGvu+O0bTqey+jP+q47Mn9wq/TwYY+SDlO5PoeLe/vKDzH/3ONU2gFHS7d5+bQdUY1NgI4TUl5wZovfsAhPevAYF3Rq4WEM1kz/TlEYV+VgDauC5w6pGC0E2Q3pXWqKZswDyBqGJXbEroHrPJ0nzYsvaJlyD8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2pPLzR5cldqZk1XYTVhQXI0V3B3Y2Rhazg1VXQ3TkxlTGtTWkhEd1VxVEUx?=
 =?utf-8?B?TW5LY0tLMkpaTmhWVDN2NXY4eWdDR1ZhQWJ6NVZjdmZ1Z0lmdm95NHRxTXFx?=
 =?utf-8?B?MG9SSUFmVERtTzBvTTVJVUpTcWdERW01bXZNbXRyV0ZENUIxSll1QWVZcXA3?=
 =?utf-8?B?a3REMkFWdWQ2MmxZM3NrSjhya1pIa1QzZVZxbGV2RjZiZWhvcFNtSkxMQzN3?=
 =?utf-8?B?WDcvVXJkZ09JbjRVbzYxR1R0Sit3Mjh2MXM1S0VUM0Y0dW8yb1Z3VWN6SVBJ?=
 =?utf-8?B?eEN1VzFrM2hud1RZNm1TNkxIdDBzcHloTU5IQ3FJbjJ5Y3laenpOMkxkQ3FI?=
 =?utf-8?B?czlVYnlvK285Nk1rRUFVMWl5UUE5OVJoeUZpVnRrZE40SVZqNUM1SlFaTXg1?=
 =?utf-8?B?dmMwUTlYbHVZeVZ2V3pxNTEvMzJIZHhDamdRa1lZazY1dWFxK2xZWFdsVVhk?=
 =?utf-8?B?WldKZ21iQ0pLYU41VHMzSkhxL2Z2Vjk0SXpjbktTL1hLSS85a0pydHN5bUpH?=
 =?utf-8?B?Y1VzUDJGdkJxdVVXMUVVVmpNLzVxUC9YSmRJS3Iybk9vbURVaEpjUERxZnFn?=
 =?utf-8?B?L3JaMGhZeGEwRlJ6YTBrdEJRTFN2VzY0RU1jRE5EbTlUZnBsMk44RXdXVFN1?=
 =?utf-8?B?UEVDNU02T3JUYmFLQVdDcC9BTUZLMnZ1VlNTTGREa0psYllONnMxVUhSODRT?=
 =?utf-8?B?aTVWSTNzekJsV2NjSHVFNFNwOWxnOHAzZ0xBZ2x5THN0QXkrK0h4Z09yaGFa?=
 =?utf-8?B?TUJXUGhFVkkxd0IwdCtzQXNPRDRxNXZpbGN3QkR5TkFocTV3OUlDcUd1S1NZ?=
 =?utf-8?B?Y3dZdXhLVmhabytyTmJ4cXBudFhja0pkbXQwZERjazZlcWRsT0Z2bFRZb2dz?=
 =?utf-8?B?LzVwQm5jMFZXaGVXSXV1SlVxTmpTSHl3Y2swcnFCc2QvT1g1aWVEUEpUMFUr?=
 =?utf-8?B?Um5nSEF1QUV5QmVxOUhOY21BaTQ0WHM4NUJhS04xR0NmMnJMV05TSm54SEph?=
 =?utf-8?B?eWFkZGdYK21Td0ZRZkdJOG8wRm96emNUT0h2c2QzYkNMVmZqNytiQmw2RzVH?=
 =?utf-8?B?b0h4cDNjcFg5YmlJZVcxcUZkSllQalExdzVNaDRodndjZTE2T0JFTitRRmo0?=
 =?utf-8?B?RElSMVNVaTFta2NYUHVwL3hkcVZLbHhNMWFudm4xZmN4eTZnMmpNRFN6ZWhY?=
 =?utf-8?B?Wmh1Tkx5SHI3YzduOEZQdHNTbW5maEplYnNjOFRXVlV4S1FydC9hUlBoT1Fm?=
 =?utf-8?B?WWw1aVdWbS82TnFBNDlaUUQrVzFqa2srdytKVCt0a1laRnQyUVJ4ckFDTXo4?=
 =?utf-8?B?ejdWRXhXVVpBMGl5RDF6TVBUSGF1K0FvT1BOR3pOZEVINGFyZXFTQTNUbktX?=
 =?utf-8?B?azIwNytBa0RuRndqL3BBK3BGZ1FnZ3hzR2JucE1OUDhIWVF2N0hmNHVBQVM5?=
 =?utf-8?B?T1prZU5mcklWRVVPUTZvaEx2Y0dFT3ZlcUpwWS9ETHY5TTc3aWN5SzBCM0Vp?=
 =?utf-8?B?QnpFZ1hpVlFBa0pZZHpTSVFBYkh2YWdWY2JrTUs4ZStxNk0rcTB4QldrK2t3?=
 =?utf-8?B?cVFKT0M1c3NZYXFUV1dNUUF2NEk5OWN1TDZIRDY4NktjV3RYN0syRUtWcU5r?=
 =?utf-8?B?V1BEMC96Y05iYkpkY0lJR1FlY1VZcDMyOGpyUjBocWdoRURGUTdjNmMwTFYw?=
 =?utf-8?B?Ym9aV0lmb3Y2a1FhNW9NK1FYTXBJWmQ0YWVybDlndGxOVHBNd1FmMms2ODNk?=
 =?utf-8?B?WFRmUnlLUllISktIY01ITWNRS25IS3VOZlQxNnlsNnlSb0R2RzVCTjNCWlpI?=
 =?utf-8?B?c0krSk1tc1V0b3BYY2k3WlgwMm55eGU5VkVnRVQycEFodlRNcHhUVkg0bHlT?=
 =?utf-8?B?UUkycXVVMmg4V0ZLdDc4TDJKVC8xV2wvR3pxdFJYeDE2WTRWMk9ZVlVDNU1a?=
 =?utf-8?B?aFBoNTgrcXlDQ0ZkenhRSElDckM1ZmVBNFVyU3F3K2hReEFEbWlVbGlNdGhL?=
 =?utf-8?B?S1BoSDh6VDRTTCtEM21BVVNtZWYzd2xKQ0lBb1UyMFB5THRTN2krY2hRdXc1?=
 =?utf-8?B?cGlwdEsxNWs0YTExRHM1SDNyaEg0aVFmQ3BGcEhDdXZma3c3RWRlc0xjKzFw?=
 =?utf-8?B?NFdkRTRMWDNwRVFPS2Nnem44YTRlK1hWU0JNbGRGUnRSV3FzLzdZWFJUUHNP?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <370230C514716245A0DFBD1C8E4F10FF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630a4cb8-141f-4e53-c539-08dc57c643f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 12:20:23.4207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9j1jtTbeUgd/Swd9XS9qqHiyCsDlqfipF3lI5fzyAJNAOZ9yijktmSffu4//Ko5XePEfl7oiO1XNTg71wxwpLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8492
X-OriginatorOrg: intel.com

DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L2VwY19jZ3JvdXAuaA0KPiArKysgYi9h
cmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9lcGNfY2dyb3VwLmgNCj4gQEAgLTI4LDYgKzI4LDEwIEBA
IHN0YXRpYyBpbmxpbmUgaW50IHNneF9jZ3JvdXBfdHJ5X2NoYXJnZShzdHJ1Y3Qgc2d4X2Nncm91
cCAqc2d4X2NnLCBlbnVtIHNneF9yZWNsDQo+ICBzdGF0aWMgaW5saW5lIHZvaWQgc2d4X2Nncm91
cF91bmNoYXJnZShzdHJ1Y3Qgc2d4X2Nncm91cCAqc2d4X2NnKSB7IH0NCj4gIA0KPiAgc3RhdGlj
IGlubGluZSB2b2lkIHNneF9jZ3JvdXBfaW5pdCh2b2lkKSB7IH0NCj4gKw0KPiArc3RhdGljIGlu
bGluZSB2b2lkIHNneF9jZ3JvdXBfcmVjbGFpbV9wYWdlcyhzdHJ1Y3QgbWlzY19jZyAqcm9vdCwg
c3RydWN0IG1tX3N0cnVjdCAqY2hhcmdlX21tKQ0KPiArew0KPiArfQ0KPiAgI2Vsc2UNCj4gIHN0
cnVjdCBzZ3hfY2dyb3VwIHsNCj4gIAlzdHJ1Y3QgbWlzY19jZyAqY2c7DQo+IEBAIC02NSw2ICs2
OSw5IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBzZ3hfcHV0X2NnKHN0cnVjdCBzZ3hfY2dyb3VwICpz
Z3hfY2cpDQo+ICANCj4gIGludCBzZ3hfY2dyb3VwX3RyeV9jaGFyZ2Uoc3RydWN0IHNneF9jZ3Jv
dXAgKnNneF9jZywgZW51bSBzZ3hfcmVjbGFpbSByZWNsYWltKTsNCj4gIHZvaWQgc2d4X2Nncm91
cF91bmNoYXJnZShzdHJ1Y3Qgc2d4X2Nncm91cCAqc2d4X2NnKTsNCj4gK2Jvb2wgc2d4X2Nncm91
cF9scnVfZW1wdHkoc3RydWN0IG1pc2NfY2cgKnJvb3QpOw0KPiArYm9vbCBzZ3hfY2dyb3VwX3No
b3VsZF9yZWNsYWltKHN0cnVjdCBzZ3hfY2dyb3VwICpzZ3hfY2cpOw0KPiArdm9pZCBzZ3hfY2dy
b3VwX3JlY2xhaW1fcGFnZXMoc3RydWN0IG1pc2NfY2cgKnJvb3QsICBzdHJ1Y3QgbW1fc3RydWN0
ICpjaGFyZ2VfbW0pOw0KDQpTZWVtcyB0aGUgZGVjaXNpb24gdG8gY2hvb3NlIHdoZXRoZXIgdG8g
aW1wbGVtZW50IGEgc3R1YiBmdW5jdGlvbiBmb3Igc29tZQ0KZnVuY3Rpb24gaXMgcXVpdGUgcmFu
ZG9tIHRvIG1lLg0KDQpNeSBpbXByZXNzaW9uIGlzIHBlb3BsZSBpbiBnZW5lcmFsIGRvbid0IGxp
a2UgI2lmZGVmIGluIHRoZSBDIGZpbGUgYnV0IHByZWZlciB0bw0KaW1wbGVtZW50aW5nIGl0IGlu
IHRoZSBoZWFkZXIgaW4gc29tZSBoZWxwZXIgZnVuY3Rpb24uDQoNCkkgZ3Vlc3MgeW91IG1pZ2h0
IHdhbnQgdG8ganVzdCBpbXBsZW1lbnQgYSBzdHViIGZ1bmN0aW9uIGZvciBlYWNoIG9mIHRoZSAz
DQpmdW5jdGlvbnMgZXhwb3NlZCwgc28gdGhhdCB3ZSBjYW4gZWxpbWluYXRlIHNvbWUgI2lmZGVm
cyBpbiB0aGUgc2d4L21haW4uYyAoc2VlDQpiZWxvdykuDQoNCj4gIHZvaWQgc2d4X2Nncm91cF9p
bml0KHZvaWQpOw0KPiAgDQo+ICAjZW5kaWYNCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5l
bC9jcHUvc2d4L21haW4uYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L21haW4uYw0KPiBpbmRl
eCA3ZjkyNDU1ZDk1N2QuLjY4ZjI4ZmYyZDVlZiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2Vy
bmVsL2NwdS9zZ3gvbWFpbi5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L21haW4u
Yw0KPiBAQCAtMzQsNiArMzQsMTYgQEAgc3RhdGljIHN0cnVjdCBzZ3hfZXBjX2xydV9saXN0IHNn
eF9nbG9iYWxfbHJ1Ow0KPiAgDQo+ICBzdGF0aWMgaW5saW5lIHN0cnVjdCBzZ3hfZXBjX2xydV9s
aXN0ICpzZ3hfbHJ1X2xpc3Qoc3RydWN0IHNneF9lcGNfcGFnZSAqZXBjX3BhZ2UpDQo+ICB7DQo+
ICsjaWZkZWYgQ09ORklHX0NHUk9VUF9TR1hfRVBDDQo+ICsJaWYgKGVwY19wYWdlLT5zZ3hfY2cp
DQo+ICsJCXJldHVybiAmZXBjX3BhZ2UtPnNneF9jZy0+bHJ1Ow0KPiArDQo+ICsJLyoNCj4gKwkg
KiBUaGlzIHNob3VsZCBub3QgaGFwcGVuIHdoZW4gY2dyb3VwIGlzIGVuYWJsZWQ6IEV2ZXJ5IHBh
Z2UgYmVsb25ncw0KPiArCSAqIHRvIGEgY2dyb3VwLCBvciB0aGUgcm9vdCBieSBkZWZhdWx0Lg0K
PiArCSAqLw0KPiArCVdBUk5fT05fT05DRSgxKTsNCg0KSW4gdGhlIGNhc2UgTUlTQyBjZ3JvdXAg
aXMgZW5hYmxlZCBpbiBLY29uZmlnIGJ1dCBkaXNhYmxlZCBieSBjb21tYW5kIGxpbmUsIEkNCnRo
aW5rIHRoaXMgYmVjb21lcyBsZWdhbCBub3c/DQoNCj4gKyNlbmRpZg0KPiAgCXJldHVybiAmc2d4
X2dsb2JhbF9scnU7DQo+ICB9DQo+ICANCj4gQEAgLTQyLDcgKzUyLDExIEBAIHN0YXRpYyBpbmxp
bmUgc3RydWN0IHNneF9lcGNfbHJ1X2xpc3QgKnNneF9scnVfbGlzdChzdHJ1Y3Qgc2d4X2VwY19w
YWdlICplcGNfcGFnDQo+ICAgKi8NCj4gIHN0YXRpYyBpbmxpbmUgYm9vbCBzZ3hfY2FuX3JlY2xh
aW0odm9pZCkNCj4gIHsNCj4gKyNpZmRlZiBDT05GSUdfQ0dST1VQX1NHWF9FUEMNCj4gKwlyZXR1
cm4gIXNneF9jZ3JvdXBfbHJ1X2VtcHR5KG1pc2NfY2dfcm9vdCgpKTsNCj4gKyNlbHNlDQo+ICAJ
cmV0dXJuICFsaXN0X2VtcHR5KCZzZ3hfZ2xvYmFsX2xydS5yZWNsYWltYWJsZSk7DQo+ICsjZW5k
aWYNCj4gIH0NCj4gIA0KDQpIZXJlIHlvdSBhcmUgdXNpbmcgI2lmZGVmICBDT05GSUdfQ0dSVVBf
U0dYX0VQQywgYnV0IC4uLg0KDQo+ICBzdGF0aWMgYXRvbWljX2xvbmdfdCBzZ3hfbnJfZnJlZV9w
YWdlcyA9IEFUT01JQ19MT05HX0lOSVQoMCk7DQo+IEBAIC00MDQsNyArNDE4LDEwIEBAIHN0YXRp
YyBib29sIHNneF9zaG91bGRfcmVjbGFpbSh1bnNpZ25lZCBsb25nIHdhdGVybWFyaykNCj4gIA0K
PiAgc3RhdGljIHZvaWQgc2d4X3JlY2xhaW1fcGFnZXNfZ2xvYmFsKHN0cnVjdCBtbV9zdHJ1Y3Qg
KmNoYXJnZV9tbSkNCj4gIHsNCj4gLQlzZ3hfcmVjbGFpbV9wYWdlcygmc2d4X2dsb2JhbF9scnUs
IGNoYXJnZV9tbSk7DQo+ICsJaWYgKElTX0VOQUJMRUQoQ09ORklHX0NHUk9VUF9TR1hfRVBDKSkN
Cj4gKwkJc2d4X2Nncm91cF9yZWNsYWltX3BhZ2VzKG1pc2NfY2dfcm9vdCgpLCBjaGFyZ2VfbW0p
Ow0KPiArCWVsc2UNCj4gKwkJc2d4X3JlY2xhaW1fcGFnZXMoJnNneF9nbG9iYWxfbHJ1LCBjaGFy
Z2VfbW0pOw0KPiAgfQ0KDQouLi4gaGVyZSB5b3UgYXJlIHVzaW5nIElTX0VOQUJMRUQoQ09ORklH
X0NHUk9VUF9TR1hfRVBDKS4NCg0KQW55IHJlYXNvbiB0aGV5IGFyZSBub3QgY29uc2lzdGVudD8N
Cg0KQWxzbywgaW4gdGhlIGNhc2Ugd2hlcmUgTUlTQyBjZ3JvdXAgaXMgZGlzYWJsZWQgdmlhIGNv
bW1hbmRsaW5lLCBJIHRoaW5rIGl0DQp3b24ndCB3b3JrLCBiZWNhdXNlIG1pc2NfY2dfcm9vdCgp
IHNob3VsZCBiZSBOVUxMIGluIHRoaXMgY2FzZSB3aGlsZQ0KSVNfRU5BQkxFRChDT05GSUdfQ0dS
T1VQX1NHWF9FUEMpIGlzIHRydWUuDQoNCj4gIA0KPiAgLyoNCj4gQEAgLTQxNCw2ICs0MzEsMTYg
QEAgc3RhdGljIHZvaWQgc2d4X3JlY2xhaW1fcGFnZXNfZ2xvYmFsKHN0cnVjdCBtbV9zdHJ1Y3Qg
KmNoYXJnZV9tbSkNCj4gICAqLw0KPiAgdm9pZCBzZ3hfcmVjbGFpbV9kaXJlY3Qodm9pZCkNCj4g
IHsNCj4gKyNpZmRlZiBDT05GSUdfQ0dST1VQX1NHWF9FUEMNCj4gKwlzdHJ1Y3Qgc2d4X2Nncm91
cCAqc2d4X2NnID0gc2d4X2dldF9jdXJyZW50X2NnKCk7DQo+ICsNCj4gKwkvKiBNYWtlIHN1cmUg
dGhlcmUgYXJlIHNvbWUgZnJlZSBwYWdlcyBhdCBjZ3JvdXAgbGV2ZWwgKi8NCj4gKwlpZiAoc2d4
X2NnICYmIHNneF9jZ3JvdXBfc2hvdWxkX3JlY2xhaW0oc2d4X2NnKSkgew0KPiArCQlzZ3hfY2dy
b3VwX3JlY2xhaW1fcGFnZXMoc2d4X2NnLT5jZywgY3VycmVudC0+bW0pOw0KPiArCQlzZ3hfcHV0
X2NnKHNneF9jZyk7DQo+ICsJfQ0KPiArI2VuZGlmDQoNClRoaXMgI2lmZGVmIENPTkZJR19DR1JP
VVBfU0dYX0VQQyBjYW4gYmUgcmVtb3ZlZCBpZiB3ZSBpbXBsZW1lbnQgYSBzdHViIGZ1bmN0aW9u
DQpmb3Igc2d4X2Nncm91cF9zaG91bGRfcmVjbGFpbSgpLg0KDQo+ICsJLyogTWFrZSBzdXJlIHRo
ZXJlIGFyZSBzb21lIGZyZWUgcGFnZXMgYXQgZ2xvYmFsIGxldmVsICovDQo+ICAJaWYgKHNneF9z
aG91bGRfcmVjbGFpbShTR1hfTlJfTE9XX1BBR0VTKSkNCj4gIAkJc2d4X3JlY2xhaW1fcGFnZXNf
Z2xvYmFsKGN1cnJlbnQtPm1tKTsNCj4gIH0NCg0K

