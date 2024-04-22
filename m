Return-Path: <cgroups+bounces-2643-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BDB8AC269
	for <lists+cgroups@lfdr.de>; Mon, 22 Apr 2024 02:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0191F215AD
	for <lists+cgroups@lfdr.de>; Mon, 22 Apr 2024 00:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2419B641;
	Mon, 22 Apr 2024 00:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8BbVQy2"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515C0184;
	Mon, 22 Apr 2024 00:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713745358; cv=fail; b=uLN1GBDYGQXv44xHx1u1fFjd7Y6QvQGoVeFTBesT3o8p2eitXdvbw20m44j1nGyoMpKVRp8S+EwTqstgAAWhrPlnne+mibzezhzbQLnAagdidTnMzMaddyoJqaVMy6Wcv3ZgktK6/rgwzy0XBVsO5s1YA6S9oBM6XiwwNykt16E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713745358; c=relaxed/simple;
	bh=NUjtwxnV2bA7dqCmPpvaSvfisgU9VR2g+i6CPbN4mRM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jVnJvdZRFVms9t6IVqpWMnj1sukTBRRky2bOxZ77MTQOey1Z9bUlmG8wqTEAdvjioQ4+nfoIIz8EVIWez2AsyhK7k1epxnc4vEdSQVJpoc/v3d83bx5pbaYo4bBuJEJWKShckQioGfweYHL6mbFOeuWquGg+Wh5cSxr6pckw8g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8BbVQy2; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713745357; x=1745281357;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NUjtwxnV2bA7dqCmPpvaSvfisgU9VR2g+i6CPbN4mRM=;
  b=e8BbVQy2kNHTXwIotlt2lkXhxFO43mTnfmRYDN9wOIp4d7dEf0GauUUd
   2EFoAtQnkQ+cMbdqkEStSPBKIcgc+EARhBQjL4gRgjDp6uu6ApHWbbHNF
   q+yZT/AHFoOvZXKaRd+2BJoVetZ5SZ6rVDcj2aGzv1bOpUzfd+G5r4Lg3
   CzIuaCIp8AgOsswDeaF7X8nC6AcYgmwgeKmd5iK+GcN6z+MvFKNaKCUyZ
   6SAAImbmTAiWSuqgk/9BfHngTIm5LHvoP4Jh2xBepz5SPSrYlEgOqABYH
   V79jwXtyI5hUAatsEXQrAGue8cwHO1cbH3L6UPYvXJTzmU6q2iqdz04br
   g==;
X-CSE-ConnectionGUID: ZDAYALEgQ5ShPP/GcLsVXQ==
X-CSE-MsgGUID: dnbYeFd+TZeQoYDQBwtqfQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="9132871"
X-IronPort-AV: E=Sophos;i="6.07,219,1708416000"; 
   d="scan'208";a="9132871"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2024 17:22:36 -0700
X-CSE-ConnectionGUID: qSISEpYBQuy81hAa/jgv4w==
X-CSE-MsgGUID: a0X3y3qLSieT6EYIqJl9zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,219,1708416000"; 
   d="scan'208";a="24458630"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Apr 2024 17:22:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 21 Apr 2024 17:22:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 21 Apr 2024 17:22:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 21 Apr 2024 17:22:34 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 21 Apr 2024 17:22:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrAQZMCHkIwQslLHzr0nRN9JcKPs9oN6cxdUGRhq82tP5VDOTz6qLZouR9zVJSeVbD5Zd/FIgXw4OJc4L/P1zwiZEkySuXC1AYHfMKuhXHJiPeLD3sc3hSDr72SmTr0Q4NkIWirQ2njJ967o7wEIAiwfr9RJPQ/YGC8SLnM5/jmbWeGYD0XpM+ioX5+1hhf+e0Dy1pihN6ahi8tDfZwp4mY0JnC9HXT3jRmUzkt1frmAoAYhxjNJfwGa9z7VLCmuDVAU7Szil+VidLHSmNh2Yl9NSUElM0RrOB2lK1m+AvAGH849NeC8zE32UMev4LFg1daah+7UyL84Q5TI7vQ+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUjtwxnV2bA7dqCmPpvaSvfisgU9VR2g+i6CPbN4mRM=;
 b=jwBlZTjzkpQ7M3O1rdkrmF3joohrEQzRDwAfvI+P3e0mfYhKCFUZhX0my0QGkN7yXmfRR3PdGPDNSBuh0y3lZ5cLL5qEYY32If4rND45gmmivVq4BB0Pj3cmSRlna9aGxEODoJTY0IU4vLlG++9m6Cwpsj5fCzSjj6NVWyKGbbB3tdJ+MuR1bbbVo29k3I6/Mx5IKpd3N4A0tPXeWixbAXBEco/thYP37+yBk+lyz6Kv628hNlNb8FNhVFEWwU+jmHpNxO/Zjx3RpDjCPrJuO8sSmFb6Gv4iNPg+exppxTmdS0I9D07LWVxeJcrHtLA8WV09wt1JcZphy7rA8QJiCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB7852.namprd11.prod.outlook.com (2603:10b6:8:fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.16; Mon, 22 Apr
 2024 00:22:27 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7519.018; Mon, 22 Apr 2024
 00:22:27 +0000
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
Subject: Re: [PATCH v12 09/14] x86/sgx: Implement async reclamation for cgroup
Thread-Topic: [PATCH v12 09/14] x86/sgx: Implement async reclamation for
 cgroup
Thread-Index: AQHaj60Hm4kuVj4TEkStIzrrR8Dgw7Fu03YAgAEjfYCAAEAagIAAKb6AgAMWJgA=
Date: Mon, 22 Apr 2024 00:22:27 +0000
Message-ID: <e8d076fb097774f1f0fe3365883e6cf5a823fc4f.camel@intel.com>
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
	 <20240416032011.58578-10-haitao.huang@linux.intel.com>
	 <640866c5-9fe0-4f7b-a459-7a685dbe4092@intel.com>
	 <op.2mhn6ti6wjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <4be309656cb4e03793703098bbebab3dee93077e.camel@intel.com>
	 <op.2mh5p7fawjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2mh5p7fawjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB7852:EE_
x-ms-office365-filtering-correlation-id: bd8196a7-e8bf-47c3-ec3f-08dc62624a7d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005|921011|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?emtYblJRMXFCdFJYbnR5RXVpbHdUcXZpL2F6RTJBNU9nM1ZGN3YwcE1uQjRD?=
 =?utf-8?B?T0xpRllwdmVibDVuWjhON1FUNmNSRTdpZnR2R081bGcrSGJPTnRvYm9BTDQ4?=
 =?utf-8?B?TVNZRTk3VHkwdWhkUjBVS0JaOEVQSWVibU5rMUJ1QTNQZllrK2NwUm56M202?=
 =?utf-8?B?anFNaE1lRnM1bUppckdyY3dFbzk4MnlpR2FZK3E0Qm0yQ3NLY2NNdDlMZWh2?=
 =?utf-8?B?MDZwaU16UDdkZ0dwWnN5UlVjbGZYSWZXdjE4cmNVaXkrbjJEVTR6WXc0blJa?=
 =?utf-8?B?NGxZWUptTjA5bzdCUTltNldjaEE4SU1qQW1ONk1TRndxZE9vUmNDYnp5b2F5?=
 =?utf-8?B?TzRTWFVPWU5ENEY5elpKY1ArdkY1N0xIWEJNaGp6VTYrUWZ5MkhRcmpMak1C?=
 =?utf-8?B?TFpibGFNUFdxbWQvV2ZnZ2NUT1pLZXFiY21ldHNQbXZZU1c0MCtQbCtuZ1lK?=
 =?utf-8?B?UmptZHY4WHNrWVRvR3JEL3ZEZVd1NWRPemh1czFnTmVMcnNWZFpnNG8rL2Iz?=
 =?utf-8?B?SUlBTDdlK1dzT2pIeFBBYUZ1eERLQUZaY1RkMUU0OEdGY2hvWHl2cUFGcWFo?=
 =?utf-8?B?NW1LNlg3Um95ZVd3ZjR3NTdvTFJkL3pDSUUwUEkrLzNaSUJrbDZXWDlqeG5q?=
 =?utf-8?B?dlJ6Vnd3citCNGswS1MxeFR3Q3B2dkVkOFBJcWR0WDlMQXBVbUFleTFZa2U2?=
 =?utf-8?B?by9JcUd6OWhJNk5HSWxwYkFpbnhYYVRxdjZ4MzJjWDF0WWVaWUpJZEpGdjZk?=
 =?utf-8?B?NitCQnpjSFU3TTdTd3VsQjVISWlkSDdhRy9aNDBtOXhhRU8rVHF3YkVySVdH?=
 =?utf-8?B?aE0vNm1oTm54V0FTdUZlTEYrL3VENkIxZmFMcGZoUy9kL3ZQZDNmL3ZpeWFi?=
 =?utf-8?B?TWZVWVdmU1pnaXQ4UjRNTXNjVVBBSko1aDROcmFPZ1Zmc0hXdE5wakkvZm1n?=
 =?utf-8?B?NFg2cWdQbDVzcldsU3dyZTBjNFNxVnlPeVZidWNaeTBwSGduRFFrZ0xJYmtY?=
 =?utf-8?B?WmVzN2lQUCtjYnlRNzhiS0VvL3oxTjlaUlpyeHE5WFl2aGRnSXFuaHBOUC96?=
 =?utf-8?B?a3VjcXJwRnFRZmxMdGcwZmxaSDhhV3NZY1Zod1lyYWVUSnhxK3l2L05Cb0JT?=
 =?utf-8?B?eXJUTHo2cXRVZnVzSk52QUlhY3prOU9yTlozYm81dXFQRjNqZEVCV2lQUGVL?=
 =?utf-8?B?cktQL1Y3cys2cDJFaGkyZEloelNnM29HL25TSVNVWGNCQUJsWXg3Vkp2SWlC?=
 =?utf-8?B?YjNwR20zMk4zSElsRWtveHJMelE1d2dWV1hxOWpJUDFkc3gxTVU0Mm9qQkRq?=
 =?utf-8?B?Q1NvaXlvQjJCeEd0V0lWUnFpZzNEdWIydWdkR2VxREFtRnFUYkhwOS9lVG11?=
 =?utf-8?B?cWMrKzZaaEJ6aW5NME9NVkZ4OWQ2dGlJQnd3eTlZSlNIWGVPNkFEUExBUk9F?=
 =?utf-8?B?Q2lzb1Z1ZlVmVVRJT1d4Z0g4Ry8wMWJwemZBUWdZZWl0YkFRT0I2OXJyWUda?=
 =?utf-8?B?bklYcHQzS0paV3FpdFBBM1l4MUl3OWNBbFJoRGk5UGxYLy8vOWpBbVdMYVpV?=
 =?utf-8?B?dUdOQXVrVllqT2pXQktWRjJsUEJsYWpXdnl3M1N2QVRJOE01N3orNHBXa3Bm?=
 =?utf-8?B?QmhtMU9TYXFiV1VxQ2krQisrNmtTZzB1WWo4TnBvQ0ozTVA5d2NnVjJObFBh?=
 =?utf-8?B?WFgrWUVrUmp4aFJKT0NCSVl2dW91MVN5bExVZFAxQnVLOWVlWnJWRUhQTGJ2?=
 =?utf-8?B?SldTMTR6MGdPRVV1ekFGZjFBaDFZc2U2empOWngweHNJWFptekdZWjQzTXI3?=
 =?utf-8?Q?lAtQR4y7IQW8dFzT3QUR62CGJx0sPcmpUnOx8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUFHb3doejFRMjBGZEI1ZUJWdzl0UGJheUFBWVBUZmV4NjBhdDE1a1IxbFE0?=
 =?utf-8?B?eXlybzFLbWw5bXR3WHNZUW9lUjgwMHVHV01uOVAwNXFCK2QzM0VLcDBnMCta?=
 =?utf-8?B?QWx3MS9Db1EvZUY0UCtCTm81OVd1QmV4MzlEdElEWi9tb1Q4S0g2QzFzZTAx?=
 =?utf-8?B?ek5ablA4UFlqaFhIS2Z0MU1IUndia1VZaFIyaWxYK1krUDBxakFyQi8xOTJE?=
 =?utf-8?B?dTNZTWRCYmE1OGtOeUdDRlR4TlY2ZkhxV0FvQnUwZEk0TkRVWTIrZGRvUGpo?=
 =?utf-8?B?eHhVeUZ5ajNrZDVOdDNVTEpXUVoxRHVyUHJteTlmaWlxU2t0S2xFTDFyOTlK?=
 =?utf-8?B?Q3E5RXJ1T2l0b3Z0dUZwY1JDNmJpeGpGRVZ6UkVlUlQ0QXBBcElKcVN6TzJY?=
 =?utf-8?B?RDVWc3EwNDFlS1lGcEIzbEFiMVhhOFd1b3JqQzBuR1VyZ0hsbW0za01TTDJ2?=
 =?utf-8?B?N09YZWpqa1Y2V3pZNmM2dWcra3BOVTZKV0VvR0xpZXdOMkV4RlhxbVJyb0Mv?=
 =?utf-8?B?NnpqdC8wV05tN1ZHTTd3c0ZiWHNlL0ZDK2s1K2wyZXhlT1ZJWklpMjhSeHpX?=
 =?utf-8?B?U2R1UXdhUU14NTV1RCs0bzFBNUVmaXoxaFBRUWtyRXBXdk1WVXNiUFJ6Q3g5?=
 =?utf-8?B?QXJHQVUwcUFCZlRRdnI2d0ZkQnlpRExSL0VhN1JpYStGbCtyR2VPOFIyUnpY?=
 =?utf-8?B?R2NzZkxIWkEva09nNzVCWFY0SzZGZzJId3pxUERPVUtiNjArQ1YwYmFIdTNQ?=
 =?utf-8?B?SjJMeDRrNUVNYUR5dVhIMWxUbjhWeVNaZzdHQjNPV1pDVXdDNWNmTTVjTXZv?=
 =?utf-8?B?eVlVeHhaVVYvR0t1TERiQ2FHYWE5ZVFrVlBJSmlkSFkxZ0VnalJMSGpkK2Fz?=
 =?utf-8?B?VHJPOW80MFMyRG5nOFFKM2pSZGs2cmx6UUNKQkVyYnptcHdReGlHalFYSGtI?=
 =?utf-8?B?R24zVDZLUFJHTzAxOGxEeDhEcHFmSGtGci9sdkpLTG5Bc0VaWldLNWdmTzR4?=
 =?utf-8?B?dWtUSko0R2htYnZBTE5WMEo2ek1HR2tHd2RPSjc2dThPYVVyY3QwOXFZUERn?=
 =?utf-8?B?ZjdwVU5wQndnQzN0WmZxUGRvTFdPZmZHZTNHYW5Ub2dFZExKN21qQmJJQTM4?=
 =?utf-8?B?TVZ2U1hTMHRya1h3MGxpR0ZWbWNXZDgrUGhRcDhVZ2lVeThNbXNNM1ZEZDdY?=
 =?utf-8?B?TnVhWkJOTkZoNkpwV2JxeFF0d0J3WTNLci9RYnA3clVEbzhvbjJmSndURVMz?=
 =?utf-8?B?b01KeTRvbW1tb1RtaHdPVy9nVmNKdTRQMklnU2pBaVRyeERpRUVkZTZZMlN6?=
 =?utf-8?B?aGlTeEhkajNwcVgzalRhbEQyWGhEam4vU0d4YmsvTUlOVGtEVjlmSDJwSWFW?=
 =?utf-8?B?LzZWY1Y2c3pwL0lSdzBsMGdvWXhTTkJSVEtPVTM3a3VPQWtBM1VlVUt1Y2NN?=
 =?utf-8?B?ZkJFS3FDamNCOEV0eFhSaVdLencrM2U0a0x4Ukw3SWZiWGVoUkNJTnB6N1VK?=
 =?utf-8?B?L3NoVE5zU3QzSjl4QzAxZVRwcmdiTW5qUm00cVZWVHpVOVduc3oxdkkxaFBH?=
 =?utf-8?B?LzZLQ2NZQjZlSW45QVo4Z2tUSXJSajgvQXo3RlZHamo4L1QybmVBQ3ZjdDVX?=
 =?utf-8?B?Ym54UFAwT0VvL3NsdFhjNytyTnZFYTZZcEJTbU9RdWNna24wMmFDdzl1ZHl4?=
 =?utf-8?B?ZzJ0ckxBUVRaS0hWU1pyUmxsbTNxRTZ6Zit5NnV5RzhOM3J6TmVlcHAxcFhT?=
 =?utf-8?B?YVlyY0t0MTV5NkRiVjIzSWVzbWRSSmQwR1JXd1BIZVdtUHgwd0NLTmp6UnE1?=
 =?utf-8?B?OC9DTXJLdko4NHY3cDRJMGIxSi9sWWcrMVFoOE1ldVdFQ2gwNlpSTk1rUmJq?=
 =?utf-8?B?dkk3VnJQOU1yVzBmOUZYUis0MzJ4cUdWeDh4aVVCdkRlK3EzTm90L0h5N0li?=
 =?utf-8?B?Z2pKaHMwbE5rWmtoS2NOZGFnSUEwNmwzZUozbjF4TXRJK2FQenFNYmhEeFJz?=
 =?utf-8?B?UkZ1bVdHOWJBNkx3WWgwd0FBWS96RXAzeUZOWUNMRCszWitMblg4UUtrdzJT?=
 =?utf-8?B?bTk0OW9BSmNYZFNDMkJQUXdEdWZTM0JQR1BhVWNycVppWnRiRGMxZTBubE9C?=
 =?utf-8?B?KzlRMXZ3Tk96cDdmY1Z6TWxGYTJNb1VPQldVeXZ3UnNNckhZMVlXM0EvOWxI?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A53EBA600F42242B2C3DA60246902CA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8196a7-e8bf-47c3-ec3f-08dc62624a7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 00:22:27.5352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jRmrHtf5VlP+UB4IjIYJEnERuH2ka5C2WbFgRY6z3CwMcK4YdD+5UfUYFtdhLc8a26fbMJT3ApAvQ7X4wppvmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7852
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA0LTE5IGF0IDIwOjE0IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
ID4gPiBJIHRoaW5rIHdlIGNhbiBhZGQgc3VwcG9ydCBmb3IgInNneF9jZ3JvdXA9ZGlzYWJsZWQi
IGluIGZ1dHVyZSBpZiBpbmRlZWQNCj4gPiA+IG5lZWRlZC4gQnV0IGp1c3QgZm9yIGluaXQgZmFp
bHVyZSwgbm8/DQo+ID4gPiANCj4gPiANCj4gPiBJdCdzIG5vdCBhYm91dCB0aGUgY29tbWFuZGxp
bmUsIHdoaWNoIHdlIGNhbiBhZGQgaW4gdGhlIGZ1dHVyZSB3aGVuDQo+ID4gbmVlZGVkLsKgIEl0
J3MgYWJvdXQgd2UgbmVlZCB0byBoYXZlIGEgd2F5IHRvIGhhbmRsZSBTR1ggY2dyb3VwIGJlaW5n
DQo+ID4gZGlzYWJsZWQgYXQgYm9vdCB0aW1lIG5pY2VseSwgYmVjYXVzZSB3ZSBhbHJlYWR5IGhh
dmUgYSBjYXNlIHdoZXJlIHdlwqAgDQo+ID4gbmVlZA0KPiA+IHRvIGRvIHNvLg0KPiA+IA0KPiA+
IFlvdXIgYXBwcm9hY2ggbG9va3MgaGFsZi13YXkgdG8gbWUsIGFuZCBpcyBub3QgZnV0dXJlIGV4
dGVuZGlibGUuwqAgSWYgd2UNCj4gPiBjaG9vc2UgdG8gZG8gaXQsIGRvIGl0IHJpZ2h0IC0tIHRo
YXQgaXMsIHdlIG5lZWQgYSB3YXkgdG8gZGlzYWJsZSBpdA0KPiA+IGNvbXBsZXRlbHkgaW4gYm90
aCBrZXJuZWwgYW5kIHVzZXJzcGFjZSBzbyB0aGF0IHVzZXJzcGFjZSB3b24ndCBiZSBhYmxlwqAg
DQo+ID4gdG8NCj4gPiBzZWUgaXQuDQo+IA0KPiBUaGF0IHdvdWxkIG5lZWQgbW9yZSBjaGFuZ2Vz
IGluIG1pc2MgY2dyb3VwIGltcGxlbWVudGF0aW9uIHRvIHN1cHBvcnTCoCANCj4gc2d4LWRpc2Fi
bGUuIFJpZ2h0IG5vdyBtaXNjIGRvZXMgbm90IGhhdmUgc2VwYXJhdGUgZmlsZXMgZm9yIGRpZmZl
cmVudMKgIA0KPiByZXNvdXJjZSB0eXBlcy4gU28gd2UgY2FuIG9ubHkgYmxvY2sgZWNobyAic2d4
X2VwYy4uLiIgdG8gdGhvc2UgaW50ZXJmYWNlwqAgDQo+IGZpbGVzLCBjYW4ndCByZWFsbHkgbWFr
ZSBmaWxlcyBub3QgdmlzaWJsZS4NCg0KIndvbid0IGJlIGFibGUgdG8gc2VlIiBJIG1lYW4gIm9u
bHkgZm9yIFNHWCBFUEMgcmVzb3VyY2UiLCBidXQgbm90IHRoZQ0KY29udHJvbCBmaWxlcyBmb3Ig
dGhlIGVudGlyZSBNSVNDIGNncm91cC4NCg0KSSByZXBsaWVkIGF0IHRoZSBiZWdpbm5pbmcgb2Yg
dGhlIHByZXZpb3VzIHJlcGx5Og0KDQoiDQpHaXZlbiBTR1ggRVBDIGlzIGp1c3Qgb25lIHR5cGUg
b2YgTUlTQyBjZ3JvdXAgcmVzb3VyY2VzLCB3ZSBjYW5ub3QganVzdCANCmRpc2FibGUgTUlTQyBj
Z3JvdXAgYXMgYSB3aG9sZS4NCiINCg0KWW91IGp1c3QgbmVlZCB0byBzZXQgdGhlIFNHWCBFUEMg
ImNhcGFjaXR5IiB0byAwIHRvIGRpc2FibGUgU0dYIEVQQy4gIFNlZQ0KdGhlIGNvbW1lbnQgb2Yg
QG1pc2NfcmVzX2NhcGFjaXR5Og0KDQogKiBNaXNjZWxsYW5lb3VzIHJlc291cmNlcyBjYXBhY2l0
eSBmb3IgdGhlIGVudGlyZSBtYWNoaW5lLiAwIGNhcGFjaXR5DQogKiBtZWFucyByZXNvdXJjZSBp
cyBub3QgaW5pdGlhbGl6ZWQgb3Igbm90IHByZXNlbnQgaW4gdGhlIGhvc3QuDQoNCkFuZCAiYmxv
Y2tpbmcgZWNobyBzZ3hfZXBjIC4uLiB0byB0aG9zZSBjb250cm9sIGZpbGVzIiBpcyBhbHJlYWR5
DQpzdWZmaWNpZW50IGZvciB0aGUgcHVycG9zZSBvZiBub3QgZXhwb3NpbmcgU0dYIEVQQyB0byB1
c2Vyc3BhY2UsIGNvcnJlY3Q/DQoNCkUuZy4sIGlmIFNHWCBjZ3JvdXAgaXMgZW5hYmxlZCwgeW91
IGNhbiBzZWUgYmVsb3cgd2hlbiB5b3UgcmVhZCAibWF4IjoNCg0KICMgY2F0IC9zeXMvZnMvY2dy
b3VwL215X2dyb3VwL21pc2MubWF4DQogIyA8cmVzb3VyY2UxPiA8bWF4MT4NCiAgIHNneF9lcGMg
Li4uDQogICAuLi4NCg0KT3RoZXJ3aXNlIHlvdSB3b24ndCBiZSBhYmxlIHRvIHNlZSAic2d4X2Vw
YyI6DQoNCiAjIGNhdCAvc3lzL2ZzL2Nncm91cC9teV9ncm91cC9taXNjLm1heA0KICMgPHJlc291
cmNlMT4gPG1heDE+DQogICAuLi4NCg0KQW5kIHdoZW4geW91IHRyeSB0byB3cml0ZSB0aGUgIm1h
eCIgZm9yICJzZ3hfZXBjIiwgeW91IHdpbGwgaGl0IGVycm9yOg0KDQogIyBlY2hvICJzZ3hfZXBj
IDEwMCIgPiAvc3lzL2ZzL2Nncm91cC9teV9ncm91cC9taXNjLm1heA0KICMgLi4uIGVjaG86IHdy
aXRlIGVycm9yOiBJbnZhbGlkIGFyZ3VtZW50DQoNClRoZSBhYm92ZSBhcHBsaWVzIHRvIGFsbCB0
aGUgY29udHJvbCBmaWxlcy4gIFRvIG1lIHRoaXMgaXMgcHJldHR5IG11Y2gNCm1lYW5zICJTR1gg
RVBDIGlzIGRpc2FibGVkIiBvciAibm90IHN1cHBvcnRlZCIgZm9yIHVzZXJzcGFjZS4gDQoNCkFt
IEkgbWlzc2luZyBhbnl0aGluZz8NCg==

