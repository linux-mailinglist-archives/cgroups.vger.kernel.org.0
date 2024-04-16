Return-Path: <cgroups+bounces-2510-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6AB8A632D
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 07:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2311C216E3
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 05:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6E83B781;
	Tue, 16 Apr 2024 05:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xf4VI0t3"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7520E1118E;
	Tue, 16 Apr 2024 05:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713246168; cv=fail; b=Rx7ba9Q7vQcj8ElGdVBPP13HeTRWKvuh8esgOJTOOO57tYuUn0Ve4LNWUxxqBeOUqO4y7t2rrpTJTV3RSV4eHGxcCt1+IkvmLmiGtUwQTmZBMwxAe8/t3kvryz5ywwsQ9T+ox9vazNFSs8H9KWHY8suE5lBQPYhWGrKJcN9Tcpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713246168; c=relaxed/simple;
	bh=bn2NMZV6I+lwgjaQsA0KIcBVK5irzouQ6hPjyu1V94w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a+OpgHDzJWP4vL6l5pCZXjW1DJjMP76hwvJMnCkP0VEld8Ie6Mqw9bwjE8JkdfY+qCJoVmklQeHAsovBR/X9QPjDZZew04ms1vMO66sWuvOBR2tmMTrWcDzkeuF0vaxl0S9IzTASWWk0JOgMVV4cIq72X5yITvhwkKP1jd8/A98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xf4VI0t3; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713246167; x=1744782167;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bn2NMZV6I+lwgjaQsA0KIcBVK5irzouQ6hPjyu1V94w=;
  b=Xf4VI0t3sfdJfHlJD8UtL+uoyhVQ0q+qEcx43gbrddCYV3y+pqvz6Cz9
   TMHH8y/uatDFiQzeA1CnzuIDPbMRIK5lJb45v3e0HIzY4/FFzWu3jvZln
   tSEnjXOyQjXqYNgE/Ml9QYJrvIhEAci4eM6p5TE6KaYx5HrMl1+2pNB8O
   +aCWBQWfvbFIS7ej4cpQwTtP/8xAK8a/TKHy9vLLC+RGSa0BPmUHwoUaT
   tw+8MI6XTKbuKgprqjTIPrVFD9zt8wFAfsLJzmXJi/w6gQDLbOzY81w4e
   SDUrAYDkd/0o/e7/mp/si05MUlxMhRWBSmNZKS2wsHK07fKy+h1vSQBWD
   w==;
X-CSE-ConnectionGUID: 3qEuzku4QVuv1PFPFWJ52g==
X-CSE-MsgGUID: 6nLJG/y7SECJDyPlyRZehA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="12508756"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="12508756"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 22:42:46 -0700
X-CSE-ConnectionGUID: YiYqFX7IQteUIAHOf0RK7w==
X-CSE-MsgGUID: a2RhAwCKRS+3NkYZ0rZ4uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26705068"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 22:42:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 22:42:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 22:42:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 22:42:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXLA90dWc0B1nWsPK9xJdXkgRS/1rWGc25YDmI55vWskIlPcBiv12DGlmzkklNjq8BmdkhYRbom3whNVQzlOiPO9VLrjh+QUrlPXxRuJheLoGVPx5TQ7AnqgBKmypFuwb1t90NtvvUBCKt0G50dc6egve+h61k+R6YVMzKzIMPg8LPwW8kReUifQmIQlYmgqVpD8G52kC4gJXHnE/+aXmtpA3AD5jYikgB9zssAKh5ua71VQ8PLx+QNUz4eKgISBDzbczrbEjwAU0cv0Prpyf1u/oeK03asB1PquqkaQLpGbuaEuomwZDIVJVEofYXrv2E3qDeaezewcsWPu2nMKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bn2NMZV6I+lwgjaQsA0KIcBVK5irzouQ6hPjyu1V94w=;
 b=MUk7y9cLM6OyyoBRlQfxFattv6ZeoJiqmh1mySbHa1qaxZJQ2OlAU9Zr93A60mjIxsLwwT7deDQU2Hfa+TUpQbKJJsAirI4VXtL1+uwo4DZT6tBeqJKzTHtGAJPTVUY9+P+SCglEVSIGCYhckVcD5J4Y5nQGGOy9a6//NaKIAHnmGriha1TJZc7m7KN021sBysZUvvG7p2CgWSMCiESUZkkTbSCA3Lge2sVDbA5AFEwoQTdR8zH4c+yxNKfkRLhIK0oRVrwlSpqa3FYw6yO9rV12wzK+Eno3PNxWRHg9J45cbZ0Qt2+GIWH+Cv/FWXwMgikADuhQ9Qv0Y40JWqRmnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Tue, 16 Apr
 2024 05:42:41 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 05:42:41 +0000
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
Subject: Re: [PATCH v12 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
Thread-Topic: [PATCH v12 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
Thread-Index: AQHaj60LuNtVIY8cMkWpQupQhd9OlbFqWy+AgAAHP4A=
Date: Tue, 16 Apr 2024 05:42:41 +0000
Message-ID: <6b056faa6de2ba3a15c2e5dd576e96e3f85375ba.camel@intel.com>
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
	 <20240416032011.58578-15-haitao.huang@linux.intel.com>
	 <op.2ma195shwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2ma195shwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB7529:EE_
x-ms-office365-filtering-correlation-id: 9f2a62ca-6b11-457f-8cb9-08dc5dd80898
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eAdy9wxIIXAAk88ls9JMJXtvhoyHoBAqifp3st6O1+sK00G2KCb39Xtn3DHvViFti9nLx78NCUx2hVZMw6pPghImHJUzVSOzOxkFSdIB54N+79lnS11NxsetDtrlUajvl/bHq60107TcGvNlgWt2FkHUgWn+i+QBMcmsspDUYJ5J/RcrwGwfTF5fsEBmsmqDbWyRb6lbIfB/QY+rts/mGeTQWRLH2VjvH0r6HSmAiyYbvnD942/Z9GV71Svw+nfrYNG+SCdrAdfSzwl9VfidnkOJbmGWSLnaq6x3a43zcEkMijbVdyJNNQrCPdLnmJjGR8esvFQi/Fnfw4J4+S2hjWoaH18MGK9WlYQN4YBIGnC6s5rhT96RjUvvW0o/IukFnPVZfwJxMtsLEWCCcEv+pGlMqFAsqKU2i6X58e1R1ecfDPESAMED9fMh5lry5LSUPwh6jHN1eKQOcveZAUXJsdFHHbun83tNwha1Rghx6e1sr44Xny7ThYZMfKGppv48Iyc3FbkfY0WYGcQrnLHvBTtZ5YoF1d4a5T+krmUSzUPbDtgFD11yOMLZmv1V5K6NGFzoO9N/4y+mZNG3Hd4kLVZkyD65nwI6XAfNw93acy+Sd+xdHW1Lulh/MF5Yg3IMs7fjn63pnvLr9lMak6tf5/gu5WEZoSO5YjmK4NfhoufPC4BW93zgihnWXoaM86uk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWxNcVcxbllHRm91dWhtNXVGMDJCQ1ZZT0pIQjRrM0NFSEd2cTFFU054Skdy?=
 =?utf-8?B?UVhwcURBU0gzd05EdC9HZ3FEbjMwVlY0aHRpSzFtZnFGSzgrT05GTHI3UDF2?=
 =?utf-8?B?cWRyOHNFY3kvbWVUNTlwR0xiUC9Tc2VVVmVDYU96OWtsTk9LclNKTjJPY2sx?=
 =?utf-8?B?bEdZNkZJS1VaNDRWNlFCdFJlcmhxMmZ6MzZXSUtGMVVNOTltaVBVUlN3Yjc4?=
 =?utf-8?B?WmNyVG9xRUlKQVVVdEtiV2l5bU5pUmFxWVU2UEZOblp5ZGZueUg5eDJRc2JW?=
 =?utf-8?B?ZTROVnFJZFFuMG1TUmRmcGhDdTUwclFjU0xBNXJ3S21QR0tKY0hqZ0RVZm85?=
 =?utf-8?B?cWRaem5vNm16UjR1SVZRa1hNQS9pMWphby9HWU8xakpLNFFtTnBrYlpoTUZq?=
 =?utf-8?B?NG00S1dMMXUzUzRUR0FTdytuMDZaaU0xL1JuZ2NvTUt6WTdiN0FZK0VwZmFJ?=
 =?utf-8?B?cmdZakRMclNsaE5iVUd5Y1RRRDNzdnI1eTRxa3VEUWVHNDFjanFtSEVJbFNv?=
 =?utf-8?B?UFdkVnVqbHFTNnRlTEk3Ui9hZ2VBS25KaEYzQnYyVE1QYnVUNlNzc0VSeFlh?=
 =?utf-8?B?dFF4UFdQNzNIckp6ZVhndXRjemJ0WWYwNHNnVGxCb2xkOExLYnIzZXQ2K0Rh?=
 =?utf-8?B?ZUJZanJaeXpEMUdBVlZNcWQ5Q0lJYnMzNmJ3VFZGV3I2YnNUb2N5S2l2eEVu?=
 =?utf-8?B?aEc0clplVGFlRkV6UGRHa3VXeTZGMERBQkZHQ2wvbTIrYTNCMzEvRlZQQ1pp?=
 =?utf-8?B?L0xHdEpuRVc2OFNiT3RTSWdXQUo2cXQzdW5VYkF0Y1hBdnBmNHFWTmk3cWxY?=
 =?utf-8?B?NEREK2twTjMxL3NJRERabkJxMlc1WUI0Q3hoN3IvZTNzVzNhMm5PYXpUclBW?=
 =?utf-8?B?YkcxS1FZZnVGSStnL3dyT08xcjNmU3FJbVYwaUtCbzdlK1JOOHRtTnlTMlA4?=
 =?utf-8?B?N1p4QlhoUmI3OTVlNDl3NDVLTE9tNCsrclQ3Wk90SUdnQytDSm4ycWNKUWRo?=
 =?utf-8?B?YW5Ra1VlaDA4RDVDSk9rQXo3a044RHNFeFkvZkxDSExUNEpGZmtrMks1MHV5?=
 =?utf-8?B?SFJTREpNRmh4R2J1RXdjUjJWVlh6dmhZd3hWeDZFZmxVSUtrbXYrSWVNM1FO?=
 =?utf-8?B?UE0zK0FLQ2puQjJEaENsenMzQjFWWTIvQk5seTZxQU8yZUpHVk9XQUczZEVU?=
 =?utf-8?B?RnJEbnlEOERuUS93VHFLdmRGSVlONklHRkNxbkl5SVNEa1lNcWFxR1JNNko0?=
 =?utf-8?B?aHU2WXhNTk80NjNnZE1wNXlIWEdYdlZybmtQQzhoQTAvK1hYR3ViRmdLSXll?=
 =?utf-8?B?R25kRlNhQXlicVJLaXRWZnBuaVlteklGczVpbFU0OW5uWUZFTlRSQ0p6c1h4?=
 =?utf-8?B?bTVXQlFra0ZncUdYUzFOZU9IUnhkOGM2Sm90WTJyQkNhRVRtcXdyb29XVXVX?=
 =?utf-8?B?K2c2dFpRZE1mcFhKNmlRUGZBaElVSTN5dHpndDR2TjdzeHhEN09zOFJZaUJS?=
 =?utf-8?B?R0wrVUNDNVhhVTJsM05iVlZXSURxQ3lqMHVjMklSMFRZRDk3S25xODRZbnNT?=
 =?utf-8?B?Ly9JaXBCSXVZNC9SVGFmelcvbTltOTJicHUwN1BnMnFpT3d6SDY3TC9HbDdp?=
 =?utf-8?B?b2tQZ1dKNG0zV2psZ3d2ZkNQUGl5TlR1a01sR3UxcVVUVTloV3Q2MEExbUJj?=
 =?utf-8?B?aVpXeUtkSHkwSURIaERlb2ZIM2NjZjVXTFFHWU4vM3ZhaGJWYUVDRi8yMUJJ?=
 =?utf-8?B?NUx6TmRHcCtiays4QzV3akttU2NmV2UrcDBWSXJwcWplOUo1Y3RPNlJxMWFk?=
 =?utf-8?B?M0pFY3ViZ3JpUlliRmh0eVEyemVIOVd3L2xUSHdvd1puVDNBYVNWT2pjbDdr?=
 =?utf-8?B?MzNObTdaUXlTUnJWalRBYllyTEpOMHNaR04vY2xmWmZ2MzMyK29Pc21GMGJJ?=
 =?utf-8?B?NmFlNEdiUUN1Vk5VR2t6MXRqOVZNZEduUHVKWHlCbWRHWDNyem9LVGpsYzVV?=
 =?utf-8?B?TXlHcHBlMU56cTJCdFpTMmVKczBUbG94MlZ4eUZnRFdPdWpkL1I1TE9YYzRD?=
 =?utf-8?B?ZjlGbEtjUngzblNNNGdleFhUYmdQaWE1amZLQm5ZeFkrTlVETkErSmY1S2Y5?=
 =?utf-8?B?YjRNSVgxK1QyUXdsemFXMXlrNW9lb2lZcFo5SkRiMXlqdmNhRm9IZ29WZ1NC?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37C27FD07396A143A52BB71E9315798E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2a62ca-6b11-457f-8cb9-08dc5dd80898
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 05:42:41.8088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XfDQWirpSDwVHsV6Esjb4bJOkEGcxBrL/eIWy3SqqtuBfUJfA/3CEXMUQZN+MeSYL2ZguUnlulTXZTQf8fVozQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7529
X-OriginatorOrg: intel.com

PiANCj4gSSdsbCBzZW5kIGEgZml4dXAgZm9yIHRoaXMgcGF0Y2ggb3IgYW5vdGhlciB2ZXJzaW9u
IG9mIHRoZSBzZXJpZXMgaWYgbW9yZSAgDQo+IGNoYW5nZXMgYXJlIG5lZWRlZC4NCg0KSGkgSGFp
dGFvLA0KDQpJIGRvbid0IGxpa2UgdG8gc2F5IGJ1dCBpbiBnZW5lcmFsIEkgdGhpbmsgeW91IGFy
ZSBzZW5kaW5nIHRvbyBmcmVxdWVudGx5LiAgVGhlDQpsYXN0IHZlcnNpb24gd2FzIHNlbnQgQXBy
aWwsIDExdGggKG15IHRpbWUpLCBzbyBjb25zaWRlcmluZyB0aGUgd2Vla2VuZCBpdCBoYXMNCm9u
bHkgYmVlbiAzIG9yIGF0IG1vc3QgNCBkYXlzLiDCoA0KDQpQbGVhc2Ugc2xvdyBkb3duIGEgbGl0
dGxlIGJpdCB0byBnaXZlIHBlb3BsZSBtb3JlIHRpbWUuDQoNCk1vcmUgaW5mb3JtYXRpb24gcGxl
YXNlIGFsc28gc2VlOg0KDQpodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL25leHQvcHJv
Y2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMuaHRtbCNyZXNlbmQtcmVtaW5kZXJzDQo=

