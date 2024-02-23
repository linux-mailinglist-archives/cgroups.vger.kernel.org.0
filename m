Return-Path: <cgroups+bounces-1821-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89599860F0E
	for <lists+cgroups@lfdr.de>; Fri, 23 Feb 2024 11:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A9D1C2236B
	for <lists+cgroups@lfdr.de>; Fri, 23 Feb 2024 10:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B025D467;
	Fri, 23 Feb 2024 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WCA4ljmu"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530255D486;
	Fri, 23 Feb 2024 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683514; cv=fail; b=Y8LT/DXo1zTZy9O3MuKQ+nIVAe6cpSptpg+tKtwD/vpkel2KwTQVoh8Opr1zvBayuzM55Z/80IJoL5pzgMdkb066a5ONJX1gDBGO3xJdvttqx99y32UP/smhTMqKlgYnVaIzsGJNeQZL8wK40r3nmgH2CfgoWsQxZLG62HEe6QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683514; c=relaxed/simple;
	bh=2Eb12Y0uqR90uM5XlZilzr/0Z6XEl72RgIZBmqTK5ak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iW/b5GT1u9wa5WMW4fG5YDa5EM3V6E4frvLn50WqrV1+FYbPJQsSyNOBxCegzq+VGtBskbL/CcpDeWFKgQ1ViteuP1/lqllkCIrMvc8FYWmgk5Qed3e8OfB6G4nWTpSqkMqDGyZiz3IBfwEGQPpgw8YrTeldjkPF2fNo6grA0qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WCA4ljmu; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708683507; x=1740219507;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2Eb12Y0uqR90uM5XlZilzr/0Z6XEl72RgIZBmqTK5ak=;
  b=WCA4ljmuiWMCsuDSfmpTRM+3fhQV4nnApRefg6scmzvYhpJAdyK0jpY6
   DSoNnGpvQ+QsxuMCjuoKqb5+U1s7BdrvviioDz0742vj7yOkAUorjAk55
   TuBiuqlrbEPX54jlaYP2kqiQNNhP4Xgg2usv0ofs3GK1z94YjOOttq3PW
   BtoBn0IAn94noa+/ozTweSN2RCSCQOclbU7oUuCtPP7cZ7r4ntTttXRu+
   No25FupfJoiNch93Vc5ttUSpDYUgrbgsIxjuaFGtV8COSUlDQAB3CADf0
   2xADWh4go7AcigVOqPNZG+l4cizVIL+YVdlDYxJ8nw0tPQEA33iBThJL0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2875697"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2875697"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 02:18:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6067067"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 02:18:24 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 02:18:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 02:18:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 02:18:22 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 02:18:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcSPlIqhCcUCC9cEM5sTRuarmrurHVPtIjGM0K5QNWm7IxWDHF/tPAjUyGabLlol98T19A3H+2hkm+aTMWA2BF+vF2XoBfO5Ad7+LmPPuM84KxYoUBlp1Iqwmk6f7r9yuMrTlgktWbZ48/+mWI+0gnyyIzBjRa/cDuyaHlSPOwFL6ZFNYEUM9RSPvGLa6uPAcskCgIDBznyy0OEJ4qiVKSYWWMq2NMS9LAZmNblphGBFNx5hopKVunDKS3FiKkxPABJbhGdbQtxgP9MxQcpwr2drfJp+bCXa0rebINn0mBbHZWEnXZqI4sgEbRrOD8mh09Zrnsg5b/2yOkzdVbWeJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Eb12Y0uqR90uM5XlZilzr/0Z6XEl72RgIZBmqTK5ak=;
 b=n4dS5Zk8glgTUE8dcjy8wSuD9oP7XaNpVrvjK0h7kD4sLvCQt0YpkW+L/8ia6oa+jyOazUxgYLzF0i1hvIvbaey7hQs9qYdd7t/HILq9wziSdvoO/YYZGJ3uJ++ynv3NEGCCLZLybUQqHnOgUw/sN1zGQnygUhnw/PHdS6/wGu4Beit3g1gcutd16rqIcNalrUllKaIWEalU5402bWCq1lEfL3XTFQ+nTpJobVS81k3UHAkUujp/6x36NRwESeA66WaS89zP3nzzdeu3Hav0umAIh3ZuOFD/VawEn5Iu7skP6tHK6AuCTf0bvidptPUz+Xc+WAllCin42bj8I80Lig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB6471.namprd11.prod.outlook.com (2603:10b6:8:c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Fri, 23 Feb
 2024 10:18:18 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.009; Fri, 23 Feb 2024
 10:18:18 +0000
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
Subject: Re: [PATCH v9 10/15] x86/sgx: Add EPC reclamation in cgroup
 try_charge()
Thread-Topic: [PATCH v9 10/15] x86/sgx: Add EPC reclamation in cgroup
 try_charge()
Thread-Index: AQHaWH7l75yVd20wEkCEiOebdvKVQLEUuuiAgAH4AACAAEeWgIAAGZYAgAC+JgA=
Date: Fri, 23 Feb 2024 10:18:18 +0000
Message-ID: <c913193c0560c4372d2fdb31e9edb28bcb419f50.camel@intel.com>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
	 <20240205210638.157741-11-haitao.huang@linux.intel.com>
	 <c5d03171473821ebc9cb79e3dad4d1bf0074e674.camel@intel.com>
	 <op.2jjzaqdwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <4db8493b-35a2-474f-997c-5e6ac1b8bd11@intel.com>
	 <op.2jkfeezjwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2jkfeezjwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB6471:EE_
x-ms-office365-filtering-correlation-id: dd4b2f82-0397-4af5-8282-08dc3458c11d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T+xhVwLasHQRCRYYRqWffrAVZCd6ELrEZSJV+vUe6vAD5sn3Jo9e7CyV2WOeQx2uwqVau8+2aIVnAFVBhjKka5NtNiP9JJayG3oHdkxdU7K/46nAsuQxIzpThcPn6dZAf8+8LEEoyTJz2M7OPJHOXKfXCWj+Njol8ChtQDKNpBkVG/DqJeX4Hf33Z20o4slodeO9rp2y/JTNUoZ170kJoUjZ35SnbaZ/2ygGACfM0kWTpdh5md26J+CVUez/yTijJN0e9x61d0k4RP1OgItk/6k6eBM57dJsFxyyoy3NmmutTGSPC43ClzZVdkcPxl2ZsBzlPpTdT3SuV5amWrIppS/4NSogyEzo6G5S741m/SR5hEw7AMrQycxSl+iWBlvuCDV+74ByEShWnd8KOQHTEPyJ70PJIYUEtbBF9idqFxBQEjJqPK022nIZxbIJaYzUOet4Ny1w+aD46Q6RnQavg+mDkgWkq0h5g/ubBdd/pZvs/FlMmGnY98FJEpF5S+M/XE5fG0ZkGVPob9lAnDBnESEBs3AvC0S3gSQx3JRZgefBUg8TqY4UDCRiPt/qi2HAg+6MNT8iu4czBANmszJQu6goRjFfq9bGd0g0c8EvsS8LT+ZQalAX9P5jMBDyQxlX7v3Lx7NaiZGA5NnY7hVtDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzd1aFl2NGdIR1lBNEhqWEQwamZwdXJaK1l2N1poZzFJMk9nd0JNU2VBSTUy?=
 =?utf-8?B?RDZ4RkEvcjFWWWxycXNDKzZLNG1CSzJYVUFtRkR3K2UwSkJvVlZQbnZlTUJW?=
 =?utf-8?B?MzkrSVhTWGpCSzE5ZkM0ZkNBV3VCOGYyNWM2NStUYkp1cjlDNmNsVzc5MVZi?=
 =?utf-8?B?Y24veHV2TTZTOUliWjlrTms2QytRSjZiSXNOZ0oxZDFLaE51eDFSMUNyeTFQ?=
 =?utf-8?B?M0w2eXI5dUpPMGgxS2JEUmxJYTJaSFlOc3RqZHBDemZmY2R6ZEROZWVIOHNu?=
 =?utf-8?B?NWVwRjNldU9MQklqK2RGUk9GdTB4VXJ5YUxnNkJDOTExaDhibHZXL0grc1pB?=
 =?utf-8?B?YTdFdWpUb214YVd5UW9kVHc0Q2lSMkdaTVJ4SVlJdTAydE41QVRVN21yem1U?=
 =?utf-8?B?NFZqZ3c2aFNrUmh6TjJKeVcyMjhRZ2VNbnFOQzlYenU5UldDaDZhWm42Si9V?=
 =?utf-8?B?Mm5XMXNpcGlsZExhdGJGcm9aU3hSY2dHK0o2WFBEOTdqcElDbXdCS3pGVy9R?=
 =?utf-8?B?WlZ6dVlhL0ZCQXUxS3ZrNUNmeWczR08rcGgrWWNYQ0cvTUxTZVRBWG9lSEZh?=
 =?utf-8?B?S0FmcjBkT0R4VGNHRjJJQzFaQW1WNCt0MGtPZHBvTmozL21zbnVSenM3ajZR?=
 =?utf-8?B?aVA4RzY5cHNzTXIyYTYya3dwbGN5cmtGajNXUVREeFdzakloNUtnK24wd01Y?=
 =?utf-8?B?SEtKMVVROEdPUlZqaWM4Njh6d2JqVU01R2oxLzl5eDhqUld3TmYreFZ1Umxm?=
 =?utf-8?B?M3FDUzlBTnVoc1hPUlBkMCtpVFB5TkxRZ1JDVGViU2lVdThDYVZpTDFVUzc3?=
 =?utf-8?B?bGFTQUJ2TW5zOElMYm1YSUxnREpWRS94YnczdU8ySnU5VDBlb1l3UmF4MjFG?=
 =?utf-8?B?SHJUZEc2SmVSWnNjUC9TZExlK0JtNXZxbHAxc01rbFcxWUUyZGxNNTFhNG9u?=
 =?utf-8?B?RWhiQkNna3U5ckloUUNNenhkUG0rYzNIZEVlUmVEcExSNmc5NE9rTGkxWXR5?=
 =?utf-8?B?U0FQMEo2czRmbzFvS3R1RXpoUWtlKzNhWG9COHhBa1JWU3hRK0taVXgwWFVK?=
 =?utf-8?B?T3haNnJBT2FlOC92VWx2eUpBTDVMTjBqM3dzRlpRV2NWMExhWFVxWElQVWdW?=
 =?utf-8?B?dUZXSGRDc283RHl2VUlRc1dGWG96OUhmeEhPcU10dzlZR3JvQ0hHWXh2RjZE?=
 =?utf-8?B?Ukh3bzJyMnpEWFV2cUY0TGh2MFdwM09Xa1pobW1nMlU3TmFXQmpqcXFMUEtz?=
 =?utf-8?B?MHlXOTFpTXVId1JKOGl0dnIvMGw1TU1jZlBrTDBKcWt3UVJEbmhFby9ZR0J6?=
 =?utf-8?B?MFgzSUpyeWw1Q2tjYm0yeFFUOE0rZmZjdlo4SGtmSUVXZmRqbzB0NGF0REtl?=
 =?utf-8?B?endNTWxHUXgrcGRYcS8xMjYzU3FlNHNPdk5kSzdvOUhFSG5YaDBsOEdwQnUr?=
 =?utf-8?B?MktVNTJuemNZaFh1RE5kVmJ1ZlhhT0pGUERtemVoOFhzSGRDcWIxT3Q4UHFQ?=
 =?utf-8?B?Q05wQVdyV1JVbFgra0MzUWxicUlWb2k3RGpqTVhZbWczTUpFWlJaNEZnazR0?=
 =?utf-8?B?V245N2htcFdjZzZuWDF2UjRReis4YVkyZ2l6VmRYUjF0cUVHOXFKWVI1S3Az?=
 =?utf-8?B?UWIrb1lRWmZiYnhBWnFDWHJFY0ZzVVBEVFZ3ZU5CZUFUa1BlNzBRb05CazdL?=
 =?utf-8?B?WVNqS0g4SU53TUpySjMxaXg4OTFmYUZJSUpRSkxONmNZZm5DMVE1dEVYVXEv?=
 =?utf-8?B?S2pQSGxueEoyRzlnb09xYU9TQkh3ZGJtRVlqVjhZRlBZcllBOXZ6Y0M5T0cy?=
 =?utf-8?B?MFlGbU9sdlU1NE1ITTVjcWVtRDUxUkRtbEVNQmRNcjd6OTdrbFZmMHkvNHBQ?=
 =?utf-8?B?aUpHeU1pWDB5RUZnY0xEcERzUUlNMlFGajZKME5GYkYyTzZjNCtPalYvMEdt?=
 =?utf-8?B?VktXZER3TVZ3NElnczRIWk5WbmlwcytuUlZUbnZoVWJ1VnhLOHRORHV3aml5?=
 =?utf-8?B?VjdpbituaFMrVTRpYVBSWE9rU1YxV1RTbjhpZENxQkRpVWhOVlFSTlV4Z0ZM?=
 =?utf-8?B?RnA0dTQ5RFArczZoYkhwWXp3VHRnZ29zVGpIVWtZdW5KRCsxMk8xNFpRWDJw?=
 =?utf-8?B?TVFsZUxOQmtSZFNpelhnYjlXSjVncVRTZ3pKN0pKdmZKbzlMRDBPUDZmVkt6?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE981EDC930DE045BEA766F6B7C797A1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4b2f82-0397-4af5-8282-08dc3458c11d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 10:18:18.1120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yr0NewHZGT73FYtrzzaWoGmTtuVVUUYJEIJkaldNHJQKfsYbSEehkkiGWsS3KZVTqEhfemRRpNiaxYQcFf48Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6471
X-OriginatorOrg: intel.com

PiA+IA0KPiBSaWdodC4gV2hlbiBjb2RlIHJlYWNoZXMgdG8gaGVyZSwgd2UgYWxyZWFkeSBwYXNz
ZWQgcmVjbGFpbSBwZXIgY2dyb3VwLiAgDQoNClllcyBpZiB0cnlfY2hhcmdlKCkgZmFpbGVkIHdl
IG11c3QgZG8gcHJlLWNncm91cCByZWNsYWltLg0KDQo+IFRoZSBjZ3JvdXAgbWF5IG5vdCBhdCBv
ciByZWFjaCBsaW1pdCBidXQgc3lzdGVtIGhhcyBydW4gb3V0IG9mIHBoeXNpY2FsICANCj4gRVBD
Lg0KPiANCg0KQnV0IGFmdGVyIHRyeV9jaGFyZ2UoKSB3ZSBjYW4gc3RpbGwgY2hvb3NlIHRvIHJl
Y2xhaW0gZnJvbSB0aGUgY3VycmVudCBncm91cCwNCmJ1dCBub3QgbmVjZXNzYXJpbHkgaGF2ZSB0
byBiZSBnbG9iYWwsIHJpZ2h0PyAgSSBhbSBub3Qgc3VyZSB3aGV0aGVyIEkgYW0NCm1pc3Npbmcg
c29tZXRoaW5nLCBidXQgY291bGQgeW91IGVsYWJvcmF0ZSB3aHkgd2Ugc2hvdWxkIGNob29zZSB0
byByZWNsYWltIGZyb20NCnRoZSBnbG9iYWw/DQoNCg==

