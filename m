Return-Path: <cgroups+bounces-2655-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41C48AD728
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 00:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFC71F2113C
	for <lists+cgroups@lfdr.de>; Mon, 22 Apr 2024 22:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDCF1E526;
	Mon, 22 Apr 2024 22:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aywPYZa4"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCB32135C;
	Mon, 22 Apr 2024 22:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713824208; cv=fail; b=Iyub0uxLSBb3978Mt1ddmmS7LkXDMSmSvOZ1bYoJoDdYlro4zYCYkqan7x33gH4Zln0VF7nYx0BuJwkE4tdI7b9sF8At4ha8w0yDu1oRnHywpp8GW2pz5pFiDq3idmE8d/me3IZD+TiWYdQ3CRWma0Yr/L7lc40mc9vzRdOQLus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713824208; c=relaxed/simple;
	bh=91YeN0quD3yoizOT2xV9Ck5IIHDl/G4rSJr8jEa4YOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mx+t8eLOGMeXJE3a3lEuCumwbGKJNRBPc35OlFQPY0o18MyesDrd1ucYNyfkVIwA2issUPcgLaM8/GwWPDklDgmqHvpb88hQm3ZpgrHTGIZk1agEiSwGEhFw3PbrfZPnTqvg1LWwjQOARG7rmIbeE5Y4EP90H84hHNFSNZy0e/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aywPYZa4; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713824207; x=1745360207;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=91YeN0quD3yoizOT2xV9Ck5IIHDl/G4rSJr8jEa4YOc=;
  b=aywPYZa4aHoRoZtPw/+spYiFVPE+C268ESduLwIej4JnAEArMC9wucuf
   PrFZH1mYidEhWe23pqCXfzlg/yq7nk/iEF72+giz8QCkcANipv40/tBzT
   BgAO/YAZC826Cgyz/jgTFl1kl+FOLGkvglTYNY6kPKocViPTC5b3Ax7kA
   spGOXGdglrPuuJTvD0vfeg+DpSVlHaNgArHIxrbRiIWLr5pZxmMPzlTES
   pD7p9qcfsH8YWmUj3Lwtns+cKnFhmjGyT5ZCbg9WKpjyn2PJ68Ah1ZQEX
   akQUQAFXzEQ6IIv7AOo6io2vFefNapQG9lUA93SOrgCWYyOQQewGnEw6e
   A==;
X-CSE-ConnectionGUID: qx2PwUwISditvskqEcih8g==
X-CSE-MsgGUID: vyAsnTWKQ7a2uxc0C9jhug==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="19996148"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="19996148"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 15:16:45 -0700
X-CSE-ConnectionGUID: q8DGMYg4TxCpH/NAlOke4Q==
X-CSE-MsgGUID: e07lNfw6Qg+Ylf5Q+Ofr1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="28671051"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 15:16:44 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 15:16:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 15:16:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 15:16:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceVUX1xT7fSZWHcekpN1EQj81bc6JWUYY1MdxRbHjlTYlMgMatHir2DPwhL+v/v+0GEVBsFUHxRNe9gLJ4k29yFjcsB4Dlmqb4Lf+c9ghyaGfiN8fZtGIscgWGPz3fEbZibQ7wh45lorM/+d9hzRN6rDmoeUGHtVdDSz5k3Fz2Pe9nszJzvtGykmFdegUXomwSY/wRk6Qb0g11UKz9PU8Rsw+sH1mmxkVs9OuZ+Wbli0G7+ChKOxKY9IJz6EoIQUxgbnPb2T71BEwZFh0U7Inem6qy4fFmjb4EUAf/U9OoRXlLhFdEIflr4i4PFQ2RLOD7YhhHGbK4yzhBN6fiiHdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91YeN0quD3yoizOT2xV9Ck5IIHDl/G4rSJr8jEa4YOc=;
 b=ndwE0vs7MiMnkMqZ/PDYSJ3pq4tuflUe+Hb3aGoICvde7wa/MdW5ynZbD/poX7cj2PXsiBdMRmoEdEfJZAPriTcDppQUvuDxSSUtQ/jQN60LX+13np38rfeqr892tTKlgnoSiQS8v0SmFbhy5OhpKBBAKJ5HjQ7+SfxsJp5Imr6mbORMYSJ6PTIOmlYDz0XPJq1ledPQKnK/VNl2JMa/2PikqcP6cAMSK5gWPsrjzX6rJlzBIq5DK8V4AkXNpLdyE64B9ZDNB0jmm5wKvK57q24uK55DBXqnTiGB1snBjshCBUCPr8QzxY3XRX60ufXyazK8xO2dYlz06WZo+P2rfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB8122.namprd11.prod.outlook.com (2603:10b6:510:235::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Mon, 22 Apr
 2024 22:16:34 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7519.018; Mon, 22 Apr 2024
 22:16:34 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "tj@kernel.org" <tj@kernel.org>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "mkoutny@suse.com" <mkoutny@suse.com>, "Mehta,
 Sohil" <sohil.mehta@intel.com>, "haitao.huang@linux.intel.com"
	<haitao.huang@linux.intel.com>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"bp@alien8.de" <bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v12 09/14] x86/sgx: Implement async reclamation for cgroup
Thread-Topic: [PATCH v12 09/14] x86/sgx: Implement async reclamation for
 cgroup
Thread-Index: AQHaj60Hm4kuVj4TEkStIzrrR8Dgw7Fu03YAgAEjfYCAAEAagIAAKb6AgAMWJgCAAQrQgIAAZFmA
Date: Mon, 22 Apr 2024 22:16:34 +0000
Message-ID: <914371bd0673870c03e5f4c37db5a2a08fc50aa4.camel@intel.com>
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
	 <20240416032011.58578-10-haitao.huang@linux.intel.com>
	 <640866c5-9fe0-4f7b-a459-7a685dbe4092@intel.com>
	 <op.2mhn6ti6wjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <4be309656cb4e03793703098bbebab3dee93077e.camel@intel.com>
	 <op.2mh5p7fawjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <e8d076fb097774f1f0fe3365883e6cf5a823fc4f.camel@intel.com>
	 <op.2mm0u7uswjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2mm0u7uswjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB8122:EE_
x-ms-office365-filtering-correlation-id: 56dceda7-9e95-4cf7-c029-08dc6319df0a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?YUVka1kyUU95VDNJVWJXNnFLZnEyYytBZU1pMkg2RDlEZ1hGRWh3UUYxc0F4?=
 =?utf-8?B?dVkrbmx4N1VBanpnVTdLSjYxYkJkb0ZPRXlDTCs2OURnWDhDMUtoRCtRbGF0?=
 =?utf-8?B?WjhVdmN1OWsvQWMrcERtbGtwdmpaeElFUFUvdmduUHc0dEU3VDVqK0tHdkxV?=
 =?utf-8?B?K0ExR1p2S0VvU1k5RzkrUm9UekV4bWdYRW5Uc2t5Z0Nhak1UeEdzdFd2YWZB?=
 =?utf-8?B?VlNrMzN3d3FtTVpHbFplbC9wVHpEdVJ2T3kyck1pSGRhZ3FUZUNLQzVVc25D?=
 =?utf-8?B?WVBDZkZTL3dJd3JBQTduL0JxTjlMZGc5Q2ZPajR1WjNmZE01M1ZNMVV0R2U5?=
 =?utf-8?B?TkgvZVNxbXIzUSsxcXZCOWppS29ITjZYeVUzVm0yL1JlaTJ5TklSSllCN1lz?=
 =?utf-8?B?cHZjeUJ3azNTc0g2SmcrMmY2S1lHNFFQd1FjZ014Yi80QXN5cTlMMkxKa0tj?=
 =?utf-8?B?WGk2UklXajY3cGNQWmx2WHZoQ0l4R2pEWXRnZUlCSm9JWFpUOG1xa2liQklI?=
 =?utf-8?B?enU0MjJTL2V4K2RzNFA4RU1pbVU5QjdIdnVGeml4TG9tNndjWVR0MEtKODU1?=
 =?utf-8?B?QTA1NDFMdXduUmpjeTkwM254WlRnL3ErOEYvbTVnTXV1S1FwNWoyMVZyb2Nz?=
 =?utf-8?B?d0lZUkFhT1ZuR0xVS2JmVG1QMDk5TEhGdzc4bW82OWFPMWg0NlZnRWF6Z0Qv?=
 =?utf-8?B?RzY5cEpKT0p1OGx2cVc1RDVlaGMrUFhvY01lVGkrRVVueThYSVNCdExkbWNx?=
 =?utf-8?B?Vm5vT2U3OGRxaEwxQzFmajB6Y3R0NG92dExGUk54SjJlL3FvRFJtOGRjRGd1?=
 =?utf-8?B?TnQ5K1VEdWdnV1NDZ2tOS0g4bVd3QnFWMy9haFJVL1FTWUNMeUNBNjFvZUc4?=
 =?utf-8?B?NkE5aXlqNUFHbnlGU0hiS25aenJYTXRuSlJRdXNlbWhhdmR3eXJ3T2pqUTBZ?=
 =?utf-8?B?S09WRkNCeXlWYUdnZ0pXUUNLbDdabDByNVNqcTZ4c3gxUUJ3WTRUOHMrckZv?=
 =?utf-8?B?Y3l2dW1zU3phYnBDSEtvQ2xmUUhocmdNdGdlUC8zRW1lNVdxOXRjaDBmUDN1?=
 =?utf-8?B?UlFMeWY3Q1pudVZGWWVTS3NEdjJYelJpZHk1TlNVdjdpUUVTK1NTUDF6VEd2?=
 =?utf-8?B?UldFU1J0OUFxU3Q1ZC9MdUVBR0N3NnIrMjNESWVNcGhURXNVNGZCdjR1UVgx?=
 =?utf-8?B?WWY1VnZTQWdNYmdWKy80bDNKdkdjeUZRcEZ1Q2Z2WktDWFpaYU9BTTZpT2Ja?=
 =?utf-8?B?YVl3Wm5Rbms1UlIrc21XbENPRW5FL2NsWVVnbG03Rm9taHZ4UGNwODdsemNW?=
 =?utf-8?B?Vnh3c3BuSjJRdE9tRHErNkpvV1FWL2p4SkE0UVR5UjJIVDZyYzlScE12MWpY?=
 =?utf-8?B?UE4yT2ZjUTN6VjNaTTlBNHNCd1R6Q1BtZEw4YnV5dWcweUxpZHM2dFVxbnlI?=
 =?utf-8?B?SlVia3F1MU9QcWk4QVk2REJVRlNJK1U0V2c5NlF6Snc5TGZUT2l4dXNIYjVa?=
 =?utf-8?B?ZTJKckNKTlF4eS9oMENSOStORHY4aVdPaUZzVGZNUFZMVXdnd3BuaW8xQU9E?=
 =?utf-8?B?YmdqL3J3eENhVXA2VkowVjFGUThZYWp6bkhBSmRpUndoQ1orbzYxaklCSUhF?=
 =?utf-8?B?OVFTbXNsQ1dNTkJGa1JpVlVyS3N4eEx4QmZMTFo0M0dXVjZseHRaV1BhM2xw?=
 =?utf-8?B?QXMrQzRtNWlnY0szTTlsRHJNOUFGVzI2ekYrbUJJTmk1bHE5K1ZJSlNwbUlH?=
 =?utf-8?B?dVFQa25seDdUc3A0dUZmcmYyVVV4UU5PKzFpTUpwVnpZcll2aUlET3g4dnBZ?=
 =?utf-8?Q?6LdYlLkfjFOMoPCRE5WsSTrkdhVJR3OM4u0HI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djVKaWhPeHBFOVNjOEpQSWlPUHJ6RTZvbmx6VE5xeEUyUm9FUFhZbXFpUkRW?=
 =?utf-8?B?ejNWTk8yWHVUUzB1UXRvVisvbllBWlp1MGVaKy9EQzl6MnoyTk9RbEZNWld5?=
 =?utf-8?B?WGZ4dFdYRnpTYVg0L2FHY1JoZmZLbE5FczFEczBzRmRESUNHVXU2b09BZUpj?=
 =?utf-8?B?d0orM3RMaWJvQkJCcDFPK3RLNzdjZTVZYnNubDlzY1RmUHJnMUh0K2FFUUpk?=
 =?utf-8?B?VDE5anR0NmNTRlluV2RYVDhKdmh6K0pSdFA4RU5mSzRseXcxcHVNdVRrNm5v?=
 =?utf-8?B?R1J6aWdEUTB6eG5GL3ROdFdmTm1JL0ZJOS9WQmVlUjZvSWI5allpR1kxbllX?=
 =?utf-8?B?UTJRNVN6NFp0Z2VrMG94WnFXNFpmeFc3eVNmVW03TVRJOHg2R3pMUjJXNEJQ?=
 =?utf-8?B?VzVQcEJKWmNWR29xSXk1bFdvYzhTV0ZEU08vbE1wRGNTT3RFcXhRdTdDaGph?=
 =?utf-8?B?VTBKMjNJSnJTdnFWaEhZZG04cEpBajZBNVdlM0VKYXNhY1ROOENyaXZBRFlP?=
 =?utf-8?B?Y1hhZFFIYUxXc0NVQzhzODF3b2JrU1E5MlF2RWt4VGhlOFkwYkhzK1ZGWlNU?=
 =?utf-8?B?ZzZWY0lrTXJIUVd2U0FyOHZxdGJMeXh5MzM4VUY2MVFHa3daV0Y1cExBaWhQ?=
 =?utf-8?B?bG0vamN0d3h2NDlaZDJVUklveFR6L09IVGx6SnIzRXdpK2ZsNnBILzlOaDZv?=
 =?utf-8?B?QWVQM2ZpbXZzeGprL2VoWWZmc1Y0LzFrZFFHbU0wZENKL0NpbTB4WUc1SHZB?=
 =?utf-8?B?M3lLV3EvQXB1ZzBXZnJQQ2RwcVZ1NUxPVHpHVlFkMG84OXQ4bXhTK2w0Z2E3?=
 =?utf-8?B?aWpqWjZGbnFMN0k5NWZ3ellEcWlYdko3ZkNrS1huU0hwTjJlTW9OcHhCdm5q?=
 =?utf-8?B?QnpWNURlbHA3amI1RGMzQjluUEd5bVdlV1BxLy9pMElXRGdzazAzUGZaV3ly?=
 =?utf-8?B?RVFHemtkc1hRWkVjdllGd1Npa3p6S2QxekF6UFU2UytMUmw1YjUza0pLQ0p3?=
 =?utf-8?B?eDNJOGU2VVJrMlZodFhvZGJxcDU5U2V4UEhGeEFRTEZZeE5vaU9pWnNleVJL?=
 =?utf-8?B?dFlMRVV3WmZCQ1d0YmNUUEduYkNNcWd3enV5M3hrdnNHa3R3VmZxM0NSL3V3?=
 =?utf-8?B?M0dKcm1xaXY1MEZxbGhNZFlBSGxzVWphZVNBYkh1Q1BCMUlaaTNKemRhS2p3?=
 =?utf-8?B?ZjNtbmxWQXlVaFhZRWZzVlRQcldZbVl5UXRtS1M2TEk5SmRuOWY4MXFOODhy?=
 =?utf-8?B?Q09wVjh3SEd6WGNXb1dzRUluUUgwZXpwSmhqeXJnU08wa1ovOFArRVNlbHBi?=
 =?utf-8?B?MnkwK1gvdWhjZTVMN1RwTldUaEI3NDlUVm4rTW9sRTJqTUZRMzVqK0Fpbm1F?=
 =?utf-8?B?enVUTGRERjZyVkJOSmpualhMdDczTHdqWTNjY2lLMlFtdmdnTGgwWWZhUHhK?=
 =?utf-8?B?eGhBdXFjNHlWTzQzUENEam01VzM3RmNZYkQxM2F4bklYUXFWencrY0hJd2Rl?=
 =?utf-8?B?TDJTOU9oQnhhZlFCVXR5aGNZYS9aNmJTcXByUlcxbGRrUUUxeEE2Q2FhZmlD?=
 =?utf-8?B?VjUveDdUWkdERTRDc3h2VnlRaENrNDVmbFFmN1BSSXk4UytkZGNTVXVLN0Jo?=
 =?utf-8?B?NVliV0JsQzB0YXRvb200UUxtMVNwbFA1Vlcwc0dkYVQ0Qk1FNnFBSjFCcFo3?=
 =?utf-8?B?alJORzJ4UVgwbWZrQVVjckN3UnBidFJUREpnNlcvR3pNSG0wdk1QWTg0dHJ3?=
 =?utf-8?B?NC9tZkcweDJBR3RBMENURFNkWkVkYlpSS0Q1bis2dkN1N1BJYndJRVpON0J5?=
 =?utf-8?B?NTUyTnN2UFNlcGxnZzJDVVdqcFRNd3lYeFhYRFRmWDl2Y2xWWWlLUmRONzNV?=
 =?utf-8?B?Q2U5MEFjZGlPZzU4bm9uem5JS25QVE4xNFlGanZObzVOMVcwSVB1N3p4U0N1?=
 =?utf-8?B?cENvT2ZQUERBbkVKbUp4SWtKN0hBV3FOZ05VR3paenY2TUs2MXh0UnZpaHp3?=
 =?utf-8?B?UkhYWWxRRklwZWc5RzMxSnIyMlRWTDJQeFdnVGFFbXJrb3BXcGtpcDR4VkdH?=
 =?utf-8?B?aVYxWi9xak5IUVlZMm9rQ1hPZ09jV2M5cys0OWJPQU5URFFmU0FFVUxvazEy?=
 =?utf-8?B?QzduMXVDTHlpSThTZk9aSmZZYnRvNkwwaVZUN1g2ZytvMWF0SnMrSzMrRW5M?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B333F2A0A3C8F49A45E4A3B52C2F5A4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56dceda7-9e95-4cf7-c029-08dc6319df0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 22:16:34.6629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZKhdNjTUBUBBcZN37HIB3bipx5DB9dbQhSAk/THUUJ/o8eDXe99pGlIJu0DNt1Mg0SeqpbP9AelV2lM+ufZuqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8122
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA0LTIyIGF0IDExOjE3IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIFN1biwgMjEgQXByIDIwMjQgMTk6MjI6MjcgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBPbiBGcmksIDIwMjQtMDQtMTkgYXQgMjA6MTQg
LTA1MDAsIEhhaXRhbyBIdWFuZyB3cm90ZToNCj4gPiA+ID4gPiBJIHRoaW5rIHdlIGNhbiBhZGQg
c3VwcG9ydCBmb3IgInNneF9jZ3JvdXA9ZGlzYWJsZWQiIGluIGZ1dHVyZSBpZiAgDQo+ID4gPiBp
bmRlZWQNCj4gPiA+ID4gPiBuZWVkZWQuIEJ1dCBqdXN0IGZvciBpbml0IGZhaWx1cmUsIG5vPw0K
PiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gSXQncyBub3QgYWJvdXQgdGhlIGNvbW1hbmRs
aW5lLCB3aGljaCB3ZSBjYW4gYWRkIGluIHRoZSBmdXR1cmUgd2hlbg0KPiA+ID4gPiBuZWVkZWQu
ICBJdCdzIGFib3V0IHdlIG5lZWQgdG8gaGF2ZSBhIHdheSB0byBoYW5kbGUgU0dYIGNncm91cCBi
ZWluZw0KPiA+ID4gPiBkaXNhYmxlZCBhdCBib290IHRpbWUgbmljZWx5LCBiZWNhdXNlIHdlIGFs
cmVhZHkgaGF2ZSBhIGNhc2Ugd2hlcmUgd2UgDQo+ID4gPiA+IG5lZWQNCj4gPiA+ID4gdG8gZG8g
c28uDQo+ID4gPiA+IA0KPiA+ID4gPiBZb3VyIGFwcHJvYWNoIGxvb2tzIGhhbGYtd2F5IHRvIG1l
LCBhbmQgaXMgbm90IGZ1dHVyZSBleHRlbmRpYmxlLiAgSWYgIA0KPiA+ID4gd2UNCj4gPiA+ID4g
Y2hvb3NlIHRvIGRvIGl0LCBkbyBpdCByaWdodCAtLSB0aGF0IGlzLCB3ZSBuZWVkIGEgd2F5IHRv
IGRpc2FibGUgaXQNCj4gPiA+ID4gY29tcGxldGVseSBpbiBib3RoIGtlcm5lbCBhbmQgdXNlcnNw
YWNlIHNvIHRoYXQgdXNlcnNwYWNlIHdvbid0IGJlICANCj4gPiA+IGFibGU+IHRvDQo+ID4gPiA+
IHNlZSBpdC4NCj4gPiA+IA0KPiA+ID4gVGhhdCB3b3VsZCBuZWVkIG1vcmUgY2hhbmdlcyBpbiBt
aXNjIGNncm91cCBpbXBsZW1lbnRhdGlvbiB0byBzdXBwb3J0IA0KPiA+ID4gc2d4LWRpc2FibGUu
IFJpZ2h0IG5vdyBtaXNjIGRvZXMgbm90IGhhdmUgc2VwYXJhdGUgZmlsZXMgZm9yIGRpZmZlcmVu
dCANCj4gPiA+IHJlc291cmNlIHR5cGVzLiBTbyB3ZSBjYW4gb25seSBibG9jayBlY2hvICJzZ3hf
ZXBjLi4uIiB0byB0aG9zZSAgDQo+ID4gPiBpbnRlcmZhY2VmaWxlcywgY2FuJ3QgcmVhbGx5IG1h
a2UgZmlsZXMgbm90IHZpc2libGUuDQo+ID4gDQo+ID4gIndvbid0IGJlIGFibGUgdG8gc2VlIiBJ
IG1lYW4gIm9ubHkgZm9yIFNHWCBFUEMgcmVzb3VyY2UiLCBidXQgbm90IHRoZQ0KPiA+IGNvbnRy
b2wgZmlsZXMgZm9yIHRoZSBlbnRpcmUgTUlTQyBjZ3JvdXAuDQo+ID4gDQo+ID4gSSByZXBsaWVk
IGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIHByZXZpb3VzIHJlcGx5Og0KPiA+IA0KPiA+ICINCj4g
PiBHaXZlbiBTR1ggRVBDIGlzIGp1c3Qgb25lIHR5cGUgb2YgTUlTQyBjZ3JvdXAgcmVzb3VyY2Vz
LCB3ZSBjYW5ub3QganVzdA0KPiA+IGRpc2FibGUgTUlTQyBjZ3JvdXAgYXMgYSB3aG9sZS4NCj4g
PiAiDQo+ID4gDQo+IFNvcnJ5IEkgbWlzc2VkIHRoaXMgcG9pbnQuIGJlbG93Lg0KPiANCj4gPiBZ
b3UganVzdCBuZWVkIHRvIHNldCB0aGUgU0dYIEVQQyAiY2FwYWNpdHkiIHRvIDAgdG8gZGlzYWJs
ZSBTR1ggRVBDLiAgU2VlDQo+ID4gdGhlIGNvbW1lbnQgb2YgQG1pc2NfcmVzX2NhcGFjaXR5Og0K
PiA+IA0KPiA+ICAqIE1pc2NlbGxhbmVvdXMgcmVzb3VyY2VzIGNhcGFjaXR5IGZvciB0aGUgZW50
aXJlIG1hY2hpbmUuIDAgY2FwYWNpdHkNCj4gPiAgKiBtZWFucyByZXNvdXJjZSBpcyBub3QgaW5p
dGlhbGl6ZWQgb3Igbm90IHByZXNlbnQgaW4gdGhlIGhvc3QuDQo+ID4gDQo+IA0KPiBJSVVDIEkg
ZG9uJ3QgdGhpbmsgdGhlIHNpdHVhdGlvbiB3ZSBoYXZlIGlzIGVpdGhlciBvZiB0aG9zZSBjYXNl
cy4gRm9yIG91ciAgDQo+IGNhc2UsIHJlc291cmNlIGlzIGluaXRlZCBhbmQgcHJlc2VudCBvbiB0
aGUgaG9zdCBidXQgd2UgaGF2ZSBhbGxvY2F0aW9uICANCj4gZXJyb3IgZm9yIHNneCBjZ3JvdXAg
aW5mcmEuDQoNCllvdSBoYXZlIGNhbGN1bGF0ZWQgdGhlICJjYXBhY2l0eSIsIGJ1dCBsYXRlciB5
b3UgZmFpbGVkIHNvbWV0aGluZyBhbmQNCnRoZW4gcmVzZXQgdGhlICJjYXBhY2l0eSIgdG8gMCwg
aS5lLiwgY2xlYW51cC4gIFdoYXQncyB3cm9uZyB3aXRoIHRoYXQ/DQoNCj4gDQo+ID4gQW5kICJi
bG9ja2luZyBlY2hvIHNneF9lcGMgLi4uIHRvIHRob3NlIGNvbnRyb2wgZmlsZXMiIGlzIGFscmVh
ZHkNCj4gPiBzdWZmaWNpZW50IGZvciB0aGUgcHVycG9zZSBvZiBub3QgZXhwb3NpbmcgU0dYIEVQ
QyB0byB1c2Vyc3BhY2UsIGNvcnJlY3Q/DQo+ID4gDQo+ID4gRS5nLiwgaWYgU0dYIGNncm91cCBp
cyBlbmFibGVkLCB5b3UgY2FuIHNlZSBiZWxvdyB3aGVuIHlvdSByZWFkICJtYXgiOg0KPiA+IA0K
PiA+ICAjIGNhdCAvc3lzL2ZzL2Nncm91cC9teV9ncm91cC9taXNjLm1heA0KPiA+ICAjIDxyZXNv
dXJjZTE+IDxtYXgxPg0KPiA+ICAgIHNneF9lcGMgLi4uDQo+ID4gICAgLi4uDQo+ID4gDQo+ID4g
T3RoZXJ3aXNlIHlvdSB3b24ndCBiZSBhYmxlIHRvIHNlZSAic2d4X2VwYyI6DQo+ID4gDQo+ID4g
ICMgY2F0IC9zeXMvZnMvY2dyb3VwL215X2dyb3VwL21pc2MubWF4DQo+ID4gICMgPHJlc291cmNl
MT4gPG1heDE+DQo+ID4gICAgLi4uDQo+ID4gDQo+ID4gQW5kIHdoZW4geW91IHRyeSB0byB3cml0
ZSB0aGUgIm1heCIgZm9yICJzZ3hfZXBjIiwgeW91IHdpbGwgaGl0IGVycm9yOg0KPiA+IA0KPiA+
ICAjIGVjaG8gInNneF9lcGMgMTAwIiA+IC9zeXMvZnMvY2dyb3VwL215X2dyb3VwL21pc2MubWF4
DQo+ID4gICMgLi4uIGVjaG86IHdyaXRlIGVycm9yOiBJbnZhbGlkIGFyZ3VtZW50DQo+ID4gDQo+
ID4gVGhlIGFib3ZlIGFwcGxpZXMgdG8gYWxsIHRoZSBjb250cm9sIGZpbGVzLiAgVG8gbWUgdGhp
cyBpcyBwcmV0dHkgbXVjaA0KPiA+IG1lYW5zICJTR1ggRVBDIGlzIGRpc2FibGVkIiBvciAibm90
IHN1cHBvcnRlZCIgZm9yIHVzZXJzcGFjZS4NCj4gPiANCj4gWW91IGFyZSByaWdodCwgY2FwYWNp
dHkgPT0gMCBkb2VzIGJsb2NrIGVjaG9pbmcgbWF4IGFuZCB1c2VycyBzZWUgYW4gZXJyb3IgIA0K
PiBpZiB0aGV5IGRvIHRoYXQuIEJ1dCAxKSBkb3VidCB5b3UgbGl0ZXJhdGVseSB3YW50ZWQgIlNH
WCBFUEMgaXMgZGlzYWJsZWQiICANCj4gYW5kIG1ha2UgaXQgdW5zdXBwb3J0ZWQgaW4gdGhpcyBj
YXNlLMKgDQo+IA0KDQpJIGRvbid0IHVuZGVyc3RhbmQuICBTb21ldGhpbmcgZmFpbGVkIGR1cmlu
ZyBTR1ggY2dyb3VwIGluaXRpYWxpemF0aW9uLA0KeW91IF9saXRlcmFsbHlfIGNhbm5vdCBjb250
aW51ZSB0byBzdXBwb3J0IGl0Lg0KDQoNCj4gMikgZXZlbiBpZiB3ZSBhY2NlcHQgdGhpcyBpcyAi
c2d4ICANCj4gY2dyb3VwIGRpc2FibGVkIiBJIGRvbid0IHNlZSBob3cgaXQgaXMgbXVjaCBiZXR0
ZXIgdXNlciBleHBlcmllbmNlIHRoYW4gIA0KPiBjdXJyZW50IHNvbHV0aW9uIG9yIHJlYWxseSBo
ZWxwcyB1c2VyIGJldHRlci4NCg0KSW4geW91ciB3YXksIHRoZSB1c2Vyc3BhY2UgaXMgc3RpbGwg
YWJsZSB0byBzZWUgInNneF9lcGMiIGluIGNvbnRyb2wgZmlsZXMNCmFuZCBpcyBhYmxlIHRvIHVw
ZGF0ZSB0aGVtLiAgU28gZnJvbSB1c2Vyc3BhY2UncyBwZXJzcGVjdGl2ZSBTR1ggY2dyb3VwIGlz
DQplbmFibGVkLCBidXQgb2J2aW91c2x5IHVwZGF0aW5nIHRvICJtYXgiIGRvZXNuJ3QgaGF2ZSBh
bnkgaW1wYWN0LiAgVGhpcw0Kd2lsbCBjb25mdXNlIHVzZXJzcGFjZS4NCg0KPiANCj4gQWxzbyB0
byBpbXBsZW1lbnQgdGhpcyBhcHByb2FjaCwgYXMgeW91IG1lbnRpb25lZCwgd2UgbmVlZCB3b3Jr
YXJvdW5kIHRoZSAgDQo+IGZhY3QgdGhhdCBtaXNjX3RyeV9jaGFyZ2UoKSBmYWlscyB3aGVuIGNh
cGFjaXR5IHNldCB0byB6ZXJvLCBhbmQgYWRkaW5nICANCj4gY29kZSB0byByZXR1cm4gcm9vdCBh
bHdheXM/wqANCj4gDQoNCldoeSB0aGlzIGlzIGEgcHJvYmxlbT8NCg0KPiBTbyBpdCBzZWVtcyBs
aWtlIG1vcmUgd29ya2Fyb3VuZCBjb2RlIHRvIGp1c3QgIA0KPiBtYWtlIGl0IHdvcmsgZm9yIGEg
ZmFpbGluZyBjYXNlIG5vIG9uZSByZWFsbHkgY2FyZSBtdWNoIGFuZCBlbmQgcmVzdWx0IGlzICAN
Cj4gbm90IHJlYWxseSBtdWNoIGJldHRlciBJTUhPLg0KDQpJdCdzIG5vdCB3b3JrYXJvdW5kLCBp
dCdzIHRoZSByaWdodCB0aGluZyB0byBkby4NCg0KVGhlIHJlc3VsdCBpcyB1c2Vyc3BhY2Ugd2ls
bCBzZWUgaXQgYmVpbmcgZGlzYWJsZWQgd2hlbiBrZXJuZWwgZGlzYWJsZXMNCml0Lg0KDQoNCg==

