Return-Path: <cgroups+bounces-205-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9210A7E2FB1
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 23:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0BA01C208C6
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 22:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE0F2EB15;
	Mon,  6 Nov 2023 22:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fGcGKm/q"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD5F2EB09
	for <cgroups@vger.kernel.org>; Mon,  6 Nov 2023 22:18:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB72D73;
	Mon,  6 Nov 2023 14:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699309122; x=1730845122;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yc+E55xLBfD+uB9jMKlw/5p9DN7zfwtt/cf81a7djwg=;
  b=fGcGKm/q+EB2rHhxDLTV7yMp5yVgCG2YO0ge6M9zFSlRO5x9ZNub4gc9
   OO4Pta74FIGpT2gJktNqn/2G2rl317gXMkxHEzra8GP4msnETQFxlvHc4
   Gh5TBz1lyH6cwlgqIbD9QOVCcPSx8Kbr4HpiZ/zRStMwP1hPrGfgeP8lI
   2VSTP+0KaoHZRLDv0Hbj3iG1ivycGLIzu4qO7vdiPXSN+OMUI2mj3tFY1
   El0+qS6RPUNwmEYUle/xkS3CfP7jXlHFgGTruLq+ZHlgYqxBEfH8FadcE
   FHAhfu0HiVGcCHogpeeKXUd3BPuMp1LiizOcVUQRjpRd3lvcFF5t/oH4K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="2300820"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="2300820"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 14:18:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="791585093"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="791585093"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 14:18:40 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 14:18:39 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 14:18:39 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 14:18:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BA4yCmgEb55DDRcwhYzEgQexXPPssvWoFIaJIxvTTgZ5KzZWmNjH6jBBoxq8aDDC5anELTUd9mSQ++zxQFsAOadQPtYZ/qluzScsDF799ru4yIoNohmIGkO3p5o4aQ0iAfiy3jEm5czu/xxYyDA8kagoBzE4KoWaVZQQTHGjrCKFkkoT0sUCvDbbxhYRqUDijNjzJDGFa+zvCbVZ1cSmCZneIP9QZD49If3JK6QnApFTAtI96ZvDQ2sEnMCN05sOYbg2YMvVr4GmMq4Sc7V9ObN8V7S+2qJ+59sZIQu//0piHoVNwIZRDDgLneuuGrcl0+BoxThRfjD+tMuydPC+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yc+E55xLBfD+uB9jMKlw/5p9DN7zfwtt/cf81a7djwg=;
 b=I7EYDUkMgVj2NV1jdM0c5ilhRQA/UHnsZvy1pOvf+u8cvdkzuwmkIpnPLjScxKDCU/taDtanhW1+JEcpv1fBsNWx9wM4BtDGrPTBJxXeMz+6T4XHLy+lRwjilsto+veysusLllkQdM5ikmcMRkdCPCsyOCftNsybvkPzYuCLTaCFneYOYQl86DyXIj70ZvCCLQq9bxz/IDV6c18PqTlwLnB3i35zQV0g4Q3C3I9MqkaWd58MbR/1lhuOmg5OP5+5Dj4I6rZKdcpgRnhQb2HCndjXyRkj1tmIAyGoDZH3uA3+CZiqIeKv/iDD7qMx4YylYsGJ5fImzTEaL9JpdPz9eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA1PR11MB5898.namprd11.prod.outlook.com (2603:10b6:806:229::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 22:18:31 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%6]) with mapi id 15.20.6954.021; Mon, 6 Nov 2023
 22:18:31 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "mingo@redhat.com" <mingo@redhat.com>, "jarkko@kernel.org"
	<jarkko@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
	"haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "tj@kernel.org" <tj@kernel.org>,
	"Mehta, Sohil" <sohil.mehta@intel.com>, "bp@alien8.de" <bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"Christopherson,, Sean" <seanjc@google.com>, "Zhang, Bo"
	<zhanb@microsoft.com>, "kristen@linux.intel.com" <kristen@linux.intel.com>,
	"anakrish@microsoft.com" <anakrish@microsoft.com>,
	"sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>, "Li,
 Zhiquan1" <zhiquan1.li@intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>
Subject: Re: [PATCH v6 04/12] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Topic: [PATCH v6 04/12] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Index: AQHaC13a8dHEeRpnz0q8yAogc4UDz7BtPX+AgAByoYCAADd4gA==
Date: Mon, 6 Nov 2023 22:18:30 +0000
Message-ID: <34a337b96a5a917612c4ec4eff2b5a378c21879b.camel@intel.com>
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
	 <20231030182013.40086-5-haitao.huang@linux.intel.com>
	 <ad7aafb88e45e5176d15eedea60695e104d24751.camel@intel.com>
	 <op.2dz4d5b2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2dz4d5b2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA1PR11MB5898:EE_
x-ms-office365-filtering-correlation-id: 00192e04-4129-4800-9d90-08dbdf164f04
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XucshympddoUxZ4aOzmZlYaGPN3CUECcx5/4U6nSnKuboCSzcaMMt8592IqKY/OYbWv/4u7iw9KJH/x5ElvGKaDjGuBQGMCEHBqzSMNkpm8g0WkrBqsJwL6RYdFJ6H6AAuxNyntu+XkPAFyyoA7paVHUAIAAIs8TnNrO21IzeFZ9qNUkTRfq5X55divIjfrgeRjqVu0Id/h9Lex7qKLl39bIrnTUIVNnpqrUgFcINCpJ8gu1TY+dOxqNEeV2Dz/RrY4kpepJS0Fjs9fiHHss2KhLtFPAP1g6gj/Z+jDPXVUj03SmgEVQupuhDw1iLe5nwgwaFY3n3q0zIMBfwuQuPlC/GxWPh/CCUohhqOxmkf0lwPVQwtChD7eR5PByaNHq0dUTzUy12WojRE4PT/Q4ZFHondCEVgmLPglI1yTiFSGIWXu3MUS0EoF0DPQvhk4YiUDZ0i/JfD0P4xtCEWFt683xuExXV71BcWnSFq4qW2RkF5sVx8tV6S3tlRKsB13d4HT+718psVsTc1w/yu35Z9+Pm2KoWosowQ7hQZHDnglww3l8xn/AJjMNg08gHgRS4TgNXgTQC54WTWGaKZrWYXm5HMqGBkt8EvMyWC0piF0lrTPBqHIwpRK6ORD8LIXN0mrMzsaBNdORgUkEeCoAMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(83380400001)(921008)(38100700002)(86362001)(38070700009)(36756003)(82960400001)(26005)(122000001)(6506007)(110136005)(8676002)(8936002)(4326008)(71200400001)(41300700001)(6512007)(6486002)(478600001)(66946007)(66446008)(316002)(54906003)(64756008)(66476007)(66556008)(76116006)(91956017)(7416002)(5660300002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkxPc0VKTWdFRlA2UGZDMDdoUGt2UUgxRzgrU1hQN0FZRHArMFFqY1Fuakdo?=
 =?utf-8?B?SlJqRUQwd3Y3eEtYY0FPcDdyREtqNDdsblZKS0NRQnh5ZHpQQ1VXN2Qxd2sy?=
 =?utf-8?B?MXVISlg1TThVeEV3bERCaEFrU1ZMWEt1NXl6Zm9VdEJra1JMV0p5OVg2aEpK?=
 =?utf-8?B?WlB4ZzBKeW52MEFnSHZOTmNLNXNicnBEODh5djZhVkhuUEk0VXduVkF4RzlB?=
 =?utf-8?B?L0sxOEc3WFY1NnRXVWpONTk5V0V1b3IraXZENzVFRks5ZTlIVkpTazVZSXF4?=
 =?utf-8?B?RDArOHNoeUNKUzY2eTU2b0RobjBVQUdFcVZVWmFyMjZpQlkyNzlGcTBjTUh4?=
 =?utf-8?B?RGpuVkVRaUpqSnBqRlBvU05SV0tuWHlZTXFXTTBiQWNFRXkzNFpKa2dIRDFN?=
 =?utf-8?B?TGZrZ1ZGMHFkdkNmLzFDbFByUUtVTHIyakNpTGZwSEdDNVZoTm1xSjNscG5K?=
 =?utf-8?B?RVZwaUNxRE9iWFVySHlXK1Y4MU04VE5HSTNRbEg2YjhoeGEyRU9udEVtRTJE?=
 =?utf-8?B?aUhuZFI0cWJHZXFrUVU0VEk2SHM2NXBTLzZObllKMGltbm1KUkdBRzJvcFkv?=
 =?utf-8?B?blA5bzN2ZWZtQjhLemY3Y2hRb1FYKzRCM3pvRXRCNVpRWlRyL0hBOUpXL1Z3?=
 =?utf-8?B?d2QvSENWRGlkejlpR09vbzlxYW1zQnF2c2xaSVhyamhMZ2JiVldxR3JpNTR2?=
 =?utf-8?B?Nnl5MXBHRXRNMkowbThHUTdkeGtFajF1R1Yvc1VLT3VEYXdOK1cwRU0vZmwz?=
 =?utf-8?B?V1JJWjRjcE5CSVRwcXA1UTk0OTl2Q3NyZ0NEYitZWUJiMW11U3I4K1o0am1E?=
 =?utf-8?B?SU5TZ25USFVvQm1ZOWRxSkpuNUk5cEJZdlhNSG10QU5OSzJMY1N3ZGltSDBF?=
 =?utf-8?B?RWgrZ2VlSWJIYWhoRDVVVlJNQXE5aHp6eFp1Y2cvL1F1Q2ZRVzRLKzQrQ20y?=
 =?utf-8?B?MHpWdDVRMTFTbFAveW5OOG1JcXl2Q0U3UC8zaEhyYlQzVStnRUJrcEtsc0dr?=
 =?utf-8?B?Rjd4dXFYeGVNT2U1eXRqaUplOUlNbnBsYVltTk02TlNjZ0NOZEdmRFllcVhr?=
 =?utf-8?B?WXRFMWVQWWFvcStHaEY0UE1xa2x6NEZoMnZzOEZDVGpibkorNm9qVS9YMlFh?=
 =?utf-8?B?WWFMdmpzdU1qL1JtMkNBMmNwQ1BwcHR1OUlhTSt4R3kza3hHUnoxOWRESEps?=
 =?utf-8?B?c2FNWHpzNUpqR1NBTDV1ejJSN0pYREg1ZXhZNXppM2hiSEFmUzJ4eFh0T1hw?=
 =?utf-8?B?QS9FMk9XTUR2bXVYQUE1MnBWejEyVGhpZkhSN2kvSUdrcWpvM1IwMm9JYUFT?=
 =?utf-8?B?QXY1YzFVUnU1Nm1kQkdmTzJZbHJueVplL2NtV0NNSUtYaE1QSDZETUVmR3RN?=
 =?utf-8?B?OXZBQjB0ZnhhT2ZNUFpjMkl0dy9IUWZxeW5sYndtN1hVby9XY2dCSlF1bEd2?=
 =?utf-8?B?aTlWMHJlU1hsV2pqU2xGeEZ5TENxeXNOK0hjQWFOcHd6RWZzejJKV1BqNWM2?=
 =?utf-8?B?VU9BVFBVbDhZT3JKci9tY0U2QnJPamJhdklUNC81ajd0SGt2YjVSQ2JmdTVO?=
 =?utf-8?B?eFRRVlcrNlgya2ZzTlUybWFFa0V3c1J3enV6TVZMd0FDYWZnVTdsMm1NaGNU?=
 =?utf-8?B?OGgrME9JZVpOZ2tyREJPL212MGV4TnRMbkZpRmFHeDkzSEprK1p1VEhtb3FM?=
 =?utf-8?B?c25Vc2FGRlNEai8zYWptc1dKQXRmTkU5Tm4ramJxNUtUd0hPN25ySVpIVWZF?=
 =?utf-8?B?b2xlVml4M0hOTkIrSnBmK3NNOWJOS216SXVLL2tKQkw5aFFZRkN6MytGcmF5?=
 =?utf-8?B?SFRoTVprNGtkVzROeVdwaVRSZXJGOXhlK3VZcUwraE9VZWRnc1k5UW1pRzVC?=
 =?utf-8?B?RjNaTWZSN1dNMzdleHBjZnlzTklseFh6eWoxbzBjUGhRM1VCb2xlYlljbXor?=
 =?utf-8?B?RlFLTEkxdjJiL3pKc05sakpuUldZU1FkbjUrUnBmV2JXVi8zUDFWaFBBZXQy?=
 =?utf-8?B?TVJWRiswell4dVJyT05jUUY5cE5nQ0dnSFY1bnkrZndwTGovc0VGQkdlQ0No?=
 =?utf-8?B?OXFhWllVSDZlMHREVlNxdHI2L1ZkWmFDTEJqT0dOR1dUeUZuckV4cWo1UnN2?=
 =?utf-8?B?QkNuUTR5M2FKVDFJWUhpMXR2ZmxWakFTVzRiRGRFaUFIa09aaXVJaHJXN05q?=
 =?utf-8?B?ZlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C127169744B9B7418BE581B39501FBC6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00192e04-4129-4800-9d90-08dbdf164f04
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 22:18:31.0435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ceWoSe+55If+3yR5IfmBbnIxIzLlUHLrSECOaoGVsO6fcuMIwRn9XKO6xW284U22kmuO+onv4/s66KMlfR+41w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5898
X-OriginatorOrg: intel.com

PiANCj4gPiA+ICsvKioNCj4gPiA+ICsgKiBzZ3hfZXBjX2Nncm91cF90cnlfY2hhcmdlKCkgLSBo
aWVyYXJjaGljYWxseSB0cnkgdG8gY2hhcmdlIGEgc2luZ2xlICANCj4gPiA+IEVQQyBwYWdlDQo+
ID4gPiArICoNCj4gPiA+ICsgKiBSZXR1cm5zIEVQQyBjZ3JvdXAgb3IgTlVMTCBvbiBzdWNjZXNz
LCAtZXJybm8gb24gZmFpbHVyZS4NCj4gPiA+ICsgKi8NCj4gPiA+ICtzdHJ1Y3Qgc2d4X2VwY19j
Z3JvdXAgKnNneF9lcGNfY2dyb3VwX3RyeV9jaGFyZ2Uodm9pZCkNCj4gPiA+ICt7DQo+ID4gPiAr
CXN0cnVjdCBzZ3hfZXBjX2Nncm91cCAqZXBjX2NnOw0KPiA+ID4gKwlpbnQgcmV0Ow0KPiA+ID4g
Kw0KPiA+ID4gKwlpZiAoc2d4X2VwY19jZ3JvdXBfZGlzYWJsZWQoKSkNCj4gPiA+ICsJCXJldHVy
biBOVUxMOw0KPiA+ID4gKw0KPiA+ID4gKwllcGNfY2cgPSBzZ3hfZXBjX2Nncm91cF9mcm9tX21p
c2NfY2coZ2V0X2N1cnJlbnRfbWlzY19jZygpKTsNCj4gPiA+ICsJcmV0ID0gbWlzY19jZ190cnlf
Y2hhcmdlKE1JU0NfQ0dfUkVTX1NHWF9FUEMsIGVwY19jZy0+Y2csIFBBR0VfU0laRSk7DQo+ID4g
PiArDQo+ID4gPiArCWlmICghcmV0KSB7DQo+ID4gPiArCQkvKiBObyBlcGNfY2cgcmV0dXJuZWQs
IHJlbGVhc2UgcmVmIGZyb20gZ2V0X2N1cnJlbnRfbWlzY19jZygpICovDQo+ID4gPiArCQlwdXRf
bWlzY19jZyhlcGNfY2ctPmNnKTsNCj4gPiA+ICsJCXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOw0K
PiA+IA0KPiA+IG1pc2NfY2dfdHJ5X2NoYXJnZSgpIHJldHVybnMgMCB3aGVuIHN1Y2Nlc3NmdWxs
eSBjaGFyZ2VkLCBubz8NCj4gDQo+IFJpZ2h0LiBJIHJlYWxseSBtYWRlIHNvbWUgbWVzcyBpbiBy
ZWJhc2luZyA6LSgNCj4gDQo+ID4gDQo+ID4gPiArCX0NCj4gPiA+ICsNCj4gPiA+ICsJLyogUmVm
IHJlbGVhc2VkIGluIHNneF9lcGNfY2dyb3VwX3VuY2hhcmdlKCkgKi8NCj4gPiA+ICsJcmV0dXJu
IGVwY19jZzsNCj4gPiA+ICt9DQo+ID4gDQo+ID4gSU1ITyB0aGUgYWJvdmUgX3RyeV9jaGFyZ2Uo
KSByZXR1cm5pbmcgYSBwb2ludGVyIG9mIEVQQyBjZ3JvdXAgaXMgYSAgDQo+ID4gbGl0dGxlIGJp
dA0KPiA+IG9kZCwgYmVjYXVzZSBpdCBkb2Vzbid0IG1hdGNoIHRoZSBleGlzdGluZyBtaXNjX2Nn
X3RyeV9jaGFyZ2UoKSB3aGljaCAgDQo+ID4gcmV0dXJucw0KPiA+IHdoZXRoZXIgdGhlIGNoYXJn
ZSBpcyBzdWNjZXNzZnVsIG9yIG5vdC4gIHNldl9taXNjX2NnX3RyeV9jaGFyZ2UoKSAgDQo+ID4g
bWF0Y2hlcw0KPiA+IG1pc2NfY2dfdHJ5X2NoYXJnZSgpIHRvby4NCj4gPiANCj4gPiBJIHRoaW5r
IGl0J3MgYmV0dGVyIHRvIHNwbGl0ICJnZXR0aW5nIEVQQyBjZ3JvdXAiIHBhcnQgb3V0IGFzIGEg
c2VwYXJhdGUgIA0KPiA+IGhlbHBlciwNCj4gPiBhbmQgbWFrZSB0aGlzIF90cnlfY2hhcmdlKCkg
bWF0Y2ggZXhpc3RpbmcgcGF0dGVybjoNCj4gPiANCj4gPiAJc3RydWN0IHNneF9lcGNfY2dyb3Vw
ICpzZ3hfZ2V0X2N1cnJlbnRfZXBjX2NnKHZvaWQpDQo+ID4gCXsNCj4gPiAJCWlmIChzZ3hfZXBj
X2Nncm91cF9kaXNhYmxlZCgpKQ0KPiA+IAkJCXJldHVybiBOVUxMOw0KPiA+IAkNCj4gPiAJCXJl
dHVybiBzZ3hfZXBjX2Nncm91cF9mcm9tX21pc2NfY2coZ2V0X2N1cnJlbnRfbWlzY19jZygpKTsN
Cj4gPiAJfQ0KPiA+IA0KPiA+IAlpbnQgc2d4X2VwY19jZ3JvdXBfdHJ5X2NoYXJnZShzdHJ1Y3Qg
c2d4X2VwY19jZ3JvdXAgKmVwY19jZykNCj4gPiAJew0KPiA+IAkJaWYgKCFlcGNfY2cpDQo+ID4g
CQkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gCQ0KPiA+IAkJcmV0dXJuIG1pc2NfY2dfdHJ5X2NoYXJn
ZShlcGNfY2ctPmNnKTsNCj4gPiAJfQ0KPiA+IA0KPiA+IEhhdmluZyBzZ3hfZ2V0X2N1cnJlbnRf
ZXBjX2NnKCkgYWxzbyBtYWtlcyB0aGUgY2FsbGVyIGVhc2llciB0byByZWFkLCAgDQo+ID4gYmVj
YXVzZSB3ZQ0KPiA+IGNhbiBpbW1lZGlhdGVseSBrbm93IHdlIGFyZSBnb2luZyB0byBjaGFyZ2Ug
dGhlICpjdXJyZW50KiBFUEMgY2dyb3VwLCAgDQo+ID4gYnV0IG5vdA0KPiA+IHNvbWUgY2dyb3Vw
IGhpZGRlbiB3aXRoaW4gc2d4X2VwY19jZ3JvdXBfdHJ5X2NoYXJnZSgpLg0KPiA+IA0KPiANCj4g
QWN0dWFsbHksIHVubGlrZSBvdGhlciBtaXNjIGNvbnRyb2xsZXJzLCB3ZSBuZWVkIGNoYXJnZSBh
bmQgZ2V0IHRoZSBlcGNfY2cgIA0KPiByZWZlcmVuY2UgYXQgdGhlIHNhbWUgdGltZS7CoA0KPiAN
Cg0KQ2FuIHlvdSBlbGFib3JhdGU/DQoNCkFuZCBpbiBwcmFjdGljZSB5b3UgYWx3YXlzIGNhbGwg
c2d4X2VwY19jZ3JvdXBfdHJ5X2NoYXJnZSgpIHJpZ2h0IGFmdGVyDQpzZ3hfZ2V0X2N1cnJlbnRf
ZXBjX2NnKCkgYW55d2F5LiAgVGhlIG9ubHkgZGlmZmVyZW5jZSBpcyB0aGUgd2hvbGUgdGhpbmcg
aXMgZG9uZQ0KaW4gb25lIGZ1bmN0aW9uIG9yIGluIHNlcGFyYXRlIGZ1bmN0aW9ucy4NCg0KWy4u
Ll0NCg0KDQo+ID4gPiAgc3RydWN0IHNneF9lcGNfcGFnZSAqc2d4X2FsbG9jX2VwY19wYWdlKHZv
aWQgKm93bmVyLCBib29sIHJlY2xhaW0pDQo+ID4gPiAgew0KPiA+ID4gIAlzdHJ1Y3Qgc2d4X2Vw
Y19wYWdlICpwYWdlOw0KPiA+ID4gKwlzdHJ1Y3Qgc2d4X2VwY19jZ3JvdXAgKmVwY19jZzsNCj4g
PiA+ICsNCj4gPiA+ICsJZXBjX2NnID0gc2d4X2VwY19jZ3JvdXBfdHJ5X2NoYXJnZSgpOw0KPiA+
ID4gKwlpZiAoSVNfRVJSKGVwY19jZykpDQo+ID4gPiArCQlyZXR1cm4gRVJSX0NBU1QoZXBjX2Nn
KTsNCj4gPiA+IA0KPiA+ID4gIAlmb3IgKCA7IDsgKSB7DQo+ID4gPiAgCQlwYWdlID0gX19zZ3hf
YWxsb2NfZXBjX3BhZ2UoKTsNCj4gPiA+IEBAIC01ODAsMTAgKzU4NywyMSBAQCBzdHJ1Y3Qgc2d4
X2VwY19wYWdlICpzZ3hfYWxsb2NfZXBjX3BhZ2Uodm9pZCAgDQo+ID4gPiAqb3duZXIsIGJvb2wg
cmVjbGFpbSkNCj4gPiA+ICAJCQlicmVhazsNCj4gPiA+ICAJCX0NCj4gPiA+IA0KPiA+ID4gKwkJ
LyoNCj4gPiA+ICsJCSAqIE5lZWQgdG8gZG8gYSBnbG9iYWwgcmVjbGFtYXRpb24gaWYgY2dyb3Vw
IHdhcyBub3QgZnVsbCBidXQgZnJlZQ0KPiA+ID4gKwkJICogcGh5c2ljYWwgcGFnZXMgcnVuIG91
dCwgY2F1c2luZyBfX3NneF9hbGxvY19lcGNfcGFnZSgpIHRvIGZhaWwuDQo+ID4gPiArCQkgKi8N
Cj4gPiA+ICAJCXNneF9yZWNsYWltX3BhZ2VzKCk7DQo+ID4gDQo+ID4gV2hhdCdzIHRoZSBmaW5h
bCBiZWhhdmlvdXI/ICBJSVVDIGl0IHNob3VsZCBiZSByZWNsYWltaW5nIGZyb20gdGhlICANCj4g
PiAqY3VycmVudCogRVBDDQo+ID4gY2dyb3VwPyAgSWYgc28gc2hvdWxkbid0IHdlIGp1c3QgcGFz
cyB0aGUgQGVwY19jZyB0byBpdCBoZXJlPw0KPiA+IA0KPiA+IEkgdGhpbmsgd2UgY2FuIG1ha2Ug
dGhpcyBwYXRjaCBhcyAic3RydWN0dXJlIiBwYXRjaCB3L28gYWN0dWFsbHkgaGF2aW5nICANCj4g
PiBFUEMNCj4gPiBjZ3JvdXAgZW5hYmxlZCwgaS5lLiwgc2d4X2dldF9jdXJyZW50X2VwY19jZygp
IGFsd2F5cyByZXR1cm4gTlVMTC4NCj4gPiANCj4gPiBBbmQgd2UgY2FuIGhhdmUgb25lIHBhdGNo
IHRvIGNoYW5nZSBzZ3hfcmVjbGFpbV9wYWdlcygpIHRvIHRha2UgdGhlICANCj4gPiAnc3RydWN0
DQo+ID4gc2d4X2VwY19scnVfbGlzdCAqJyBhcyBhcmd1bWVudDoNCj4gPiANCj4gPiAJdm9pZCBz
Z3hfcmVjbGFpbV9wYWdlc19scnUoc3RydWN0IHNneF9lcGNfbHJ1X2xpc3QgKiBscnUpDQo+ID4g
CXsNCj4gPiAJCS4uLg0KPiA+IAl9DQo+ID4gDQo+ID4gVGhlbiBoZXJlIHdlIGNhbiBoYXZlIHNv
bWV0aGluZyBsaWtlOg0KPiA+IA0KPiA+IAl2b2lkIHNneF9yZWNsYWltX3BhZ2VzKHN0cnVjdCBz
Z3hfZXBjX2NnICplcGNfY2cpDQo+ID4gCXsNCj4gPiAJCXN0cnVjdCBzZ3hfZXBjX2xydV9saXN0
ICpscnUgPQkJCWVwY19jZyA/ICZlcGNfY2ctPmxydSA6ICANCj4gPiAmc2d4X2dsb2JhbF9scnU7
DQo+ID4gDQo+ID4gCQlzZ3hfcmVjbGFpbV9wYWdlc19scnUobHJ1KTsNCj4gPiAJfQ0KPiA+IA0K
PiA+IE1ha2VzIHNlbnNlPw0KPiA+IA0KPiANCj4gVGhpcyBpcyBwdXJlbHkgZ2xvYmFsIHJlY2xh
bWF0aW9uLiBObyBjZ3JvdXAgaW52b2x2ZWQuwqANCj4gDQoNCkFnYWluIHdoeT8gIEhlcmUgeW91
IGFyZSBhbGxvY2F0aW5nIG9uZSBFUEMgcGFnZSBmb3IgZW5jbGF2ZSBpbiBhIHBhcnRpY3VsYXIg
RVBDDQpjZ3JvdXAuICBXaGVuIHRoYXQgZmFpbHMsIHNob3VsZG4ndCB5b3UgdHJ5IG9ubHkgdG8g
cmVjbGFpbSBmcm9tIHRoZSAqY3VycmVudCoNCkVQQyBjZ3JvdXA/ICBPciBhdCBsZWFzdCB5b3Ug
c2hvdWxkIHRyeSB0byByZWNsYWltIGZyb20gdGhlICpjdXJyZW50KiBFUEMgY2dyb3VwDQpmaXJz
dD8NCg0KPiBZb3UgY2FuIHNlZSBpdCAgDQo+IGxhdGVyIGluIGNoYW5nZXMgaW4gcGF0Y2ggMTAv
MTIuIEZvciBub3cgSSBqdXN0IG1ha2UgYSBjb21tZW50IHRoZXJlIGJ1dCAgDQo+IG5vIHJlYWwg
Y2hhbmdlcy4gQ2dyb3VwIHJlY2xhbWF0aW9uIHdpbGwgYmUgZG9uZSBhcyBwYXJ0IG9mIF90cnlf
Y2hhcmdlICANCj4gY2FsbC4NCj4gDQo+ID4gPiAgCQljb25kX3Jlc2NoZWQoKTsNCj4gPiA+ICAJ
fQ0KPiA+ID4gDQo+ID4gPiArCWlmICghSVNfRVJSKHBhZ2UpKSB7DQo+ID4gPiArCQlXQVJOX09O
X09OQ0UocGFnZS0+ZXBjX2NnKTsNCj4gPiA+ICsJCXBhZ2UtPmVwY19jZyA9IGVwY19jZzsNCj4g
PiA+ICsJfSBlbHNlIHsNCj4gPiA+ICsJCXNneF9lcGNfY2dyb3VwX3VuY2hhcmdlKGVwY19jZyk7
DQo+ID4gPiArCX0NCj4gPiA+ICsNCj4gPiA+ICAJaWYgKHNneF9zaG91bGRfcmVjbGFpbShTR1hf
TlJfTE9XX1BBR0VTKSkNCj4gPiA+ICAJCXdha2VfdXAoJmtzZ3hkX3dhaXRxKTsNCj4gPiA+IA0K
PiA+ID4gQEAgLTYwNCw2ICs2MjIsMTEgQEAgdm9pZCBzZ3hfZnJlZV9lcGNfcGFnZShzdHJ1Y3Qg
c2d4X2VwY19wYWdlICpwYWdlKQ0KPiA+ID4gIAlzdHJ1Y3Qgc2d4X2VwY19zZWN0aW9uICpzZWN0
aW9uID0gJnNneF9lcGNfc2VjdGlvbnNbcGFnZS0+c2VjdGlvbl07DQo+ID4gPiAgCXN0cnVjdCBz
Z3hfbnVtYV9ub2RlICpub2RlID0gc2VjdGlvbi0+bm9kZTsNCj4gPiA+IA0KPiA+ID4gKwlpZiAo
cGFnZS0+ZXBjX2NnKSB7DQo+ID4gPiArCQlzZ3hfZXBjX2Nncm91cF91bmNoYXJnZShwYWdlLT5l
cGNfY2cpOw0KPiA+ID4gKwkJcGFnZS0+ZXBjX2NnID0gTlVMTDsNCj4gPiA+ICsJfQ0KPiA+ID4g
Kw0KPiA+ID4gIAlzcGluX2xvY2soJm5vZGUtPmxvY2spOw0KPiA+ID4gDQo+ID4gPiAgCXBhZ2Ut
Pm93bmVyID0gTlVMTDsNCj4gPiA+IEBAIC02NDMsNiArNjY2LDcgQEAgc3RhdGljIGJvb2wgX19p
bml0IHNneF9zZXR1cF9lcGNfc2VjdGlvbih1NjQgIA0KPiA+ID4gcGh5c19hZGRyLCB1NjQgc2l6
ZSwNCj4gPiA+ICAJCXNlY3Rpb24tPnBhZ2VzW2ldLmZsYWdzID0gMDsNCj4gPiA+ICAJCXNlY3Rp
b24tPnBhZ2VzW2ldLm93bmVyID0gTlVMTDsNCj4gPiA+ICAJCXNlY3Rpb24tPnBhZ2VzW2ldLnBv
aXNvbiA9IDA7DQo+ID4gPiArCQlzZWN0aW9uLT5wYWdlc1tpXS5lcGNfY2cgPSBOVUxMOw0KPiA+
ID4gIAkJbGlzdF9hZGRfdGFpbCgmc2VjdGlvbi0+cGFnZXNbaV0ubGlzdCwgJnNneF9kaXJ0eV9w
YWdlX2xpc3QpOw0KPiA+ID4gIAl9DQo+ID4gPiANCj4gPiA+IEBAIC03ODcsNiArODExLDcgQEAg
c3RhdGljIHZvaWQgX19pbml0IGFyY2hfdXBkYXRlX3N5c2ZzX3Zpc2liaWxpdHkoaW50ICANCj4g
PiA+IG5pZCkge30NCj4gPiA+ICBzdGF0aWMgYm9vbCBfX2luaXQgc2d4X3BhZ2VfY2FjaGVfaW5p
dCh2b2lkKQ0KPiA+ID4gIHsNCj4gPiA+ICAJdTMyIGVheCwgZWJ4LCBlY3gsIGVkeCwgdHlwZTsN
Cj4gPiA+ICsJdTY0IGNhcGFjaXR5ID0gMDsNCj4gPiA+ICAJdTY0IHBhLCBzaXplOw0KPiA+ID4g
IAlpbnQgbmlkOw0KPiA+ID4gIAlpbnQgaTsNCj4gPiA+IEBAIC04MzcsNiArODYyLDcgQEAgc3Rh
dGljIGJvb2wgX19pbml0IHNneF9wYWdlX2NhY2hlX2luaXQodm9pZCkNCj4gPiA+IA0KPiA+ID4g
IAkJc2d4X2VwY19zZWN0aW9uc1tpXS5ub2RlID0gICZzZ3hfbnVtYV9ub2Rlc1tuaWRdOw0KPiA+
ID4gIAkJc2d4X251bWFfbm9kZXNbbmlkXS5zaXplICs9IHNpemU7DQo+ID4gPiArCQljYXBhY2l0
eSArPSBzaXplOw0KPiA+ID4gDQo+ID4gPiAgCQlzZ3hfbnJfZXBjX3NlY3Rpb25zKys7DQo+ID4g
PiAgCX0NCj4gPiA+IEBAIC04NDYsNiArODcyLDggQEAgc3RhdGljIGJvb2wgX19pbml0IHNneF9w
YWdlX2NhY2hlX2luaXQodm9pZCkNCj4gPiA+ICAJCXJldHVybiBmYWxzZTsNCj4gPiA+ICAJfQ0K
PiA+ID4gDQo+ID4gPiArCW1pc2NfY2dfc2V0X2NhcGFjaXR5KE1JU0NfQ0dfUkVTX1NHWF9FUEMs
IGNhcGFjaXR5KTsNCg0KSG1tLi4gSSB0aGluayB0aGlzIGlzIHdoeSBNSVNDX0NHX1JFU19TR1hf
RVBDIGlzIG5lZWRlZCB3aGVuDQohQ09ORklHX0NHUk9VUF9TR1hfRVBDLg0KDQo+ID4gPiArDQo+
ID4gPiAgCXJldHVybiB0cnVlOw0KPiA+ID4gIH0NCj4gPiANCj4gPiBJIHdvdWxkIHNlcGFyYXRl
IHNldHRpbmcgdXAgY2FwYWNpdHkgYXMgYSBzZXBhcmF0ZSBwYXRjaC4NCj4gDQo+IEkgdGhvdWdo
dCBhYm91dCB0aGF0LCBidXQgYWdhaW4gaXQgd2FzIG9ubHkgMy00IGxpbmVzIGFsbCBpbiB0aGlz
IGZ1bmN0aW9uICANCj4gYW5kIGl0J3MgYWxzbyBuZWNlc3NhcnkgcGFydCBvZiBiYXNpYyBzZXR1
cCBmb3IgbWlzYyBjb250cm9sbGVyLi4uDQoNCkZpbmUuICBBbnl3YXkgaXQgZGVwZW5kcyBvbiB3
aGF0IHRoaW5ncyB5b3Ugd2FudCB0byBkbyBvbiB0aGlzIHBhdGNoLiBJdCdzIGZpbmUNCnRvIGlu
Y2x1ZGUgdGhlIGNhcGFjaXR5IGlmIHRoaXMgcGF0Y2ggaXMgc29tZSAic3RydWN0dXJlIiBwYXRj
aCB0aGF0IHNob3dzIHRoZQ0KaGlnaCBsZXZlbCBmbG93IG9mIGhvdyBFUEMgY2dyb3VwIHdvcmtz
Lg0K

