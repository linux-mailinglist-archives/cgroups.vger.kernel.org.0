Return-Path: <cgroups+bounces-206-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0067E2FC9
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 23:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3AF1C20988
	for <lists+cgroups@lfdr.de>; Mon,  6 Nov 2023 22:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF462EB1F;
	Mon,  6 Nov 2023 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RHDRmJ65"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2AC2E648
	for <cgroups@vger.kernel.org>; Mon,  6 Nov 2023 22:24:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872B41BC;
	Mon,  6 Nov 2023 14:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699309442; x=1730845442;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nEo4XFze6SJivoconKEWFlj+qCo316IjE6eASevBY+E=;
  b=RHDRmJ65BIWDZwYEjTh5T6W9R9jUDuA1bAEGq9wPodtPLHQAwY3OZPE1
   EVBWDbUdIPLo3ytjpkGLW4DrLwEedS+96P+av13zIpOHcbly9t2ieoIXE
   0xS02ErSBemTp27RcyhAvuJtq2zeZ0Ks1zmb+g+0GajKlzxQgX6GXTjp/
   tpu15ln3HF7HrYDti2fwrQ5KP0fE3Yvq+uYwq9mQYGBZO4aVaBuHfWCcq
   BYaSpdfu2WJSyaSRfM9YfWCMH2J5BhvEX2L+wic2+rkACaj/lJuyoxPhB
   RuSIVLcGNyZbMMres6gqZLtiPmJlH9Kcx9UBcqjJTB4qejrrPiA15Kgtw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="8012275"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="8012275"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 14:24:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="853147693"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="853147693"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 14:23:59 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 14:24:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 14:23:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 14:23:59 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 14:23:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAa/6PyN1k+4Mph53qIXDZqzaSSjd2Bgoh8+EousfEVQsAJK8AyCVtLkwjoZqrWWkuYoe8RXVmaY65y8iW+xXY9S0wI0CS5lAhMaVkXBOZn2Ciy5nCCDPIj4+uRu/9yOqiBnILEpCnsA24TMeTTnT+j/9XQuFoKj3CQgVMrc7LZ5TJ0uLke06mGi6A3flf5LMxAKSIr8yx5W9s/8XmDeFSIASc6+PELowOHkSNxAhoTGrayGBzHpIGCDCvmEvXi03Tpr1g2McGu6Kq26GN5vLtLzpCPpeqGAW7g+rgwKkiyiwf54nrGzYNgyHFAsrtrBzrug73g68MzTPlrhuhEmzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEo4XFze6SJivoconKEWFlj+qCo316IjE6eASevBY+E=;
 b=aIpB0XYb9dfDPnXAxnnokglqhYMsZNxyWhJ226AW4yNuZ7A7Xx3t4Z+EL2YoG9jyk6/Y7JgE7NeP9Ib2maYTwmgYWtOry++GpPSPaEZODcKNT20V8zWK6SXvv31Uu2iejQX5JnmQWBCcSOqSDD7ZzN3tfyQR5gUNXzrqIXlxLSvg2yIKWvPImNkfLL9VcILqm7mEIM4kk+QLkqaFCluo+re07G7fktgR67lc3NuUhXNVdX0sX+JZN1613QW33rD1NCZyGuJvi9eiX2FRCsntKkc9Z7TdvSPu6m/c7bQGOgTQQ6Y1AR8ATWe4Vw+xFvpF3sDCDM5ki2GAp7zgVJlWWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB7872.namprd11.prod.outlook.com (2603:10b6:208:3fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 22:23:52 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%6]) with mapi id 15.20.6954.021; Mon, 6 Nov 2023
 22:23:52 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "hpa@zytor.com" <hpa@zytor.com>, "linux-sgx@vger.kernel.org"
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
	"Christopherson,, Sean" <seanjc@google.com>, "Zhang, Bo"
	<zhanb@microsoft.com>, "kristen@linux.intel.com" <kristen@linux.intel.com>,
	"yangjie@microsoft.com" <yangjie@microsoft.com>,
	"sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>, "Li,
 Zhiquan1" <zhiquan1.li@intel.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>
Subject: Re: [PATCH v6 04/12] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Topic: [PATCH v6 04/12] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Index: AQHaC13a8dHEeRpnz0q8yAogc4UDz7Bt6RWA
Date: Mon, 6 Nov 2023 22:23:52 +0000
Message-ID: <9f4374bcab0ffba024204d97a2bf1f3a1128bdd5.camel@intel.com>
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
	 <20231030182013.40086-5-haitao.huang@linux.intel.com>
In-Reply-To: <20231030182013.40086-5-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA1PR11MB7872:EE_
x-ms-office365-filtering-correlation-id: a43c21ed-8310-4a0b-b3cf-08dbdf170e6a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QbxOs6dfrzJaXYqEknIdYu7kCtTS2jRi0URHhSoj0aanSEolC3xtda7bpwbVCl8wCkjSsRX/GAa2mUrRDUyJ56pvUp8AWrejUlLZJCRtdUODDEEz2PCdZ0hoyXlAJXJMM56vANvBV+fgvnUl6kv9rJ4UM3uGVQvJt0eXBnxiMGJUsJ30iDwnQgapdehS2WOX/lMmaagA9+vWEP0dKdu6GEe7JE4uX/BEJu+P/hAZ5d8UYMSbhENDbLFYMZPbEC4C6q7PdzxI3P76eqYsoRmlnLitotHhNx4G47FuP9tjcAOS52L6Tj9vrTVd05pKClIivC4VvauD+U1QU9lswdYh1lI6GubEfMmmhi/kLticRfGvuoWyu4mMXKMy5tKxNR14Kf84gXmbxCm6qbdAtDsdIMAw8xoj5tX9a78GwcHKT+RYb2IpW2J33t8ylalmrtLPtotadlj/svld/p5nGnkU1EoU2Qg5+h1RjohRl+slhcF2f4I7hcY3Hpgeyg6jc/K/JK+GHXobZRbVTLQfJrk+AzWxSv44xLE/lx9jXLgusFbhddLBnqQrPahHOo/DnQ0LYyVmvoITIqHQunBxOS+Msf2x02TMKwF0zrXtXUcY2T0EdWXCDs0Reim9EQ6v5fr6f9h9Rg4cP67XjfZqliOW/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(230922051799003)(451199024)(1800799009)(186009)(26005)(6512007)(6506007)(2616005)(122000001)(38100700002)(36756003)(82960400001)(86362001)(6486002)(4744005)(5660300002)(71200400001)(2906002)(7416002)(4001150100001)(8936002)(83380400001)(8676002)(4326008)(921008)(38070700009)(66446008)(64756008)(66476007)(76116006)(54906003)(66946007)(316002)(508600001)(66556008)(110136005)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHFRckM4d25TK01TR1BJbENMYktFRlBqZ1g3MDcweGNXTnlIT3dKVWliYmJn?=
 =?utf-8?B?bVhpVUxMZDhOb1I5cUx2KzVMR1BJZnpEVVR0NnZhb1VpdnBrZmlVUm9aZWpG?=
 =?utf-8?B?bE9ONFNvSlBvcExKWFZ4OHhPcTFLTFJnSHYzS2M5a040TUFZbnkzNW9XWkdC?=
 =?utf-8?B?QS9QRSt2R2hhSno4UkR1Ty9kV0dKVzVnekhVaHBvUDRCTUdIRjE1TG9pbmlS?=
 =?utf-8?B?Z29XT0pEWFBVcHJJOGU0RTZlRUhTY2dUME0wMDJxZXJoZEYxc2NLSlR0WGw2?=
 =?utf-8?B?YjJzYkR4K3greHdwYlFMeEZDcm83a1dlVWlkcUdocFFrY2lleFlHVkUrR2R3?=
 =?utf-8?B?UTl6R01hQW94NnNMVm42TGJYem9wcVBLNWkzL0QxMmFkRVJ6bU5TRTdmTXR3?=
 =?utf-8?B?bzNkL1RhdkIyYXhpZzJEdTlnQ2wrSW1YQzR2NDZJSEx0aGh0WjFVWVlvSFJG?=
 =?utf-8?B?T2I2amxFV1lmQUFFN2tSNUtKSjNUUnNwbkRod3B6WXRtblF0MFZnM1lVV3Zh?=
 =?utf-8?B?T2s5aHdkTW50b29MTitOL3VKa3VHMGNUWTdIVjNGWVZnMERJUzJmQ3JOT3BP?=
 =?utf-8?B?SXNOSk50YUJYWnZOYVJjMDJuMEpVamtpeDgrZ0V3TW94dUdhTHdLSTFVR0Vo?=
 =?utf-8?B?eU93VitvSFhVMGZvK2xTVlQ2RkZaWEVrcFJPM09tOGVGTFM2dzZxT3p4U3lK?=
 =?utf-8?B?TDRSQ29VWjhqNHJUbmVDZWx2MWJsKzI3M0E3bmtqUFVBNDFCdm81VmhSUzFi?=
 =?utf-8?B?ZzgxY0tDQ3FtbXE3b0tFN2FXRWhvb0FLT2Z5aGR5NndrSjNnZEd3dXVoSldJ?=
 =?utf-8?B?VWs1Nmo4YllVS3l2b2tTMGZOMS8zYkdEei9ETTI4bG9iaTJpelV4bmRBaWUw?=
 =?utf-8?B?TXJFZVpyOTdTbkVaRU1yL2pTL2tVdndrK0NobDdHcUdSR2xrSy9QT3duTlBq?=
 =?utf-8?B?OXUySVBzbkhMbi9KZ01FcXJNY2dEK3V5MG9wL0QxTVlNOGJTSnZFMTRnRWNZ?=
 =?utf-8?B?K1RWNEhZeE1GdEtMWHVPQjU4RS9NVDNtdmx4ay9HcnI4SDhmdW0vM2g0YnNo?=
 =?utf-8?B?bkJjTmJFTXppSW5PTWJ2dldWYi9JSlI0VGs0RDJ3NlIycitkemZiMWZCakox?=
 =?utf-8?B?Zk8veXY5QzN1NzlvdjlGNUpBNUJ4NmwzbUVhK3Y2MHFNQ1pWOEdkU0Rkb0E5?=
 =?utf-8?B?YnovVC9rSW05NTloOHo3Njh3cDBBMzZWM2lGaGxtM01JZmxaM3ZEVUNPelhq?=
 =?utf-8?B?ZmowUlB4V3dPMHMremV2U28zc0YvSURaTDRYRjJ4Z0NVeDQ1ZTM5ckVJMVRH?=
 =?utf-8?B?MXBsenB3VmcvdC9Qd29FaDgrMGNSdmU5OVpubWNnYlZRbUV0ZTN2RmZ6aTNr?=
 =?utf-8?B?MXJLY3hEbE9YOXpxWngwUi9iYWNHYW00NVdNVnl4ZzBTR1BPREROVmFSaE15?=
 =?utf-8?B?Ty9mN2VPMm1wQ21jN1dEUCt5TllPQldPamZ0dnZOVngrMUFVV0FjSWFHQThM?=
 =?utf-8?B?UjhsVERWdDZpUDlVcUhiSXRNR1E5VndPL21LRmY5VmgwcnNFV2pNcGlQSmsx?=
 =?utf-8?B?MmdqRXR3UWhyZHNSd0hMODM5dlZ4UGhOYWNvRWVaMUZGTzNyUUpEWVh5NUJU?=
 =?utf-8?B?bmIrRUl4cHN2SllvZFZialoxOGNhME9nSnlYTWhONitEaDd1aDNmRS90RGI1?=
 =?utf-8?B?RGRoRHJmbW1hdzY2VTNxWHVmQlRMaHY1SUpVVjB1eVdpK2NVT2IrRitUK0tj?=
 =?utf-8?B?TFVLUVBqcHNybG1SMG1rTUF6a2tzNW1aVFJTYlpEUUx0TU15TThxeDVuVnI3?=
 =?utf-8?B?Wkp3UkNPeldKdXZhSGFZbzdMNDZmY3h1WUJvUW5sRTVSQksxOGE2RXVod3V6?=
 =?utf-8?B?eWdzY0FuamdaMlRxNTVnK2l1VWpRanhMRDVIb0hiOTFlL3VwSERidlIvM3Z2?=
 =?utf-8?B?WWdmT2JvTXNFb3FTa1NBbG9pL2wxTmNQRlppZDNsV3NLQ0liNnd0dmpaOWZs?=
 =?utf-8?B?ZkpueXdzUTNoTURERHdmVldyQ2pPZitYWFBWYkYzajFNc3lKUUZxUGxGVXIw?=
 =?utf-8?B?SkxOMm4zOWFNYW9JSTVEQ0NDNkplamxrTG8xVXFPTnlzMUJpcVFJendDTmxy?=
 =?utf-8?B?RUVpNkVzeFJscERjalN5WEt0R0NnYnNwa3pwM294ZlI2cTZFdk1mdjdrS2pF?=
 =?utf-8?B?d1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9C1B765728288458D4E06C997A004BB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a43c21ed-8310-4a0b-b3cf-08dbdf170e6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 22:23:52.2078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FUA0lSFn1yhWPEG4xuhZt+E8bMcl1LKYjPzWBgOW0W7u+Dw/5T9lGuqQDdhMJoW8hgl/i2CD9MPvX252Y++ioQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7872
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDIzLTEwLTMwIGF0IDExOjIwIC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
ICtzdGF0aWMgaW50IF9faW5pdCBzZ3hfZXBjX2Nncm91cF9pbml0KHZvaWQpDQo+ICt7DQo+ICsJ
c3RydWN0IG1pc2NfY2cgKmNnOw0KPiArDQo+ICsJaWYgKCFib290X2NwdV9oYXMoWDg2X0ZFQVRV
UkVfU0dYKSkNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCj4gKwljZyA9IG1pc2NfY2dfcm9vdCgpOw0K
PiArCUJVR19PTighY2cpOw0KPiArDQo+ICsJcmV0dXJuIHNneF9lcGNfY2dyb3VwX2FsbG9jKGNn
KTsNCj4gK30NCj4gK3N1YnN5c19pbml0Y2FsbChzZ3hfZXBjX2Nncm91cF9pbml0KTsNCg0KVGhp
cyBzaG91bGQgYmUgY2FsbGVkIGZyb20gc2d4X2luaXQoKSwgd2hpY2ggaXMgdGhlIHBsYWNlIHRv
IGluaXQgU0dYIHJlbGF0ZWQNCnN0YWZmLiAgSW4gY2FzZSB5b3UgZGlkbid0IG5vdGljZSwgc2d4
X2luaXQoKSBpcyBhY3R1YWxseSBkZXZpY2VfaW5pdGNhbGwoKSwNCndoaWNoIGlzIGFjdHVhbGx5
IGNhbGxlZCBfYWZ0ZXJfIHRoZSBzdWJzeXNfaW5pdGNhbGwoKSB5b3UgdXNlZCBhYm92ZS4NCg==

