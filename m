Return-Path: <cgroups+bounces-3159-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546D7904682
	for <lists+cgroups@lfdr.de>; Tue, 11 Jun 2024 23:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B78E6B21D34
	for <lists+cgroups@lfdr.de>; Tue, 11 Jun 2024 21:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9626B15383D;
	Tue, 11 Jun 2024 21:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jpbaeYku"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D269150991;
	Tue, 11 Jun 2024 21:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718143012; cv=fail; b=GNTJRKT6K3aMx881ekGkrWb97KXlIwflkQJS0ONhQMhauFbzQ/OOdNoMy6EGWvOd1h57sE5hNN84Jdtb9/4gc2LuD8HbOj+yCEjecDRqCxJ5DoPghstGq5kaPWjtCeESsSLTls7+ZmKN6i1LL3mg5jeyQqtsPLHy0eLwRbBdbnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718143012; c=relaxed/simple;
	bh=/fbGtEGJitKfQ0h3MJNfwd6Z/hLzqpBwSTf+VXlMqcc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UvS0ikiJRb7oUh73Dyc/HIVygfMyV7+ZN6U1tSqidyIh0ZAMstFOG6r3XL1t1jA2rBcaXC9DIGyHgvrNueuivM2NlpAmQIXZ8WdGujmJ1R5XvHSpxeGHKRZHLVJlUR0DXLrzT6RcP77Wh6MO7wgOsDhBzEN2rip6nc8+OXhguKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jpbaeYku; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718143010; x=1749679010;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/fbGtEGJitKfQ0h3MJNfwd6Z/hLzqpBwSTf+VXlMqcc=;
  b=jpbaeYkuoUn1OdomM7dikW7D2SSGMjErInkb+n/hY97BAIprIPGq1st9
   Ethi6r/csgBjQzPLv09HbFmwEhlIDzVMMcnecKD1LqHsl8cV/CGn6E9+2
   duYKPez8XKCyFIOO6x5S2xmhMWGvEZX2SeLdj0d0s5QUW+Vksk/SDDhVU
   3PW1G/35+K8B3JYlplEeZmDTevIWwIRgNAnlELsp4HUm1WgvkMfebXXlD
   p5e2hlYsESemh4pHxjZXwRNIFV5zjVhcblTc/hIsEkD3RxmJyjRhus42C
   TbWrkT1UqH6/bW2J8Utd9JEb3BzvvjBd23uZEg0BRe+xEqiIvDegErPgb
   Q==;
X-CSE-ConnectionGUID: 956sCbCrQBua/TfvW78KVw==
X-CSE-MsgGUID: GMUi6XbyQT2O3QIsR6NSxQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="25509976"
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="25509976"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 14:56:43 -0700
X-CSE-ConnectionGUID: mp4ix0GzT6afE0Eof9tIRw==
X-CSE-MsgGUID: mCn6dVjJSkS9aOhlSXkOmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="44003755"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 14:56:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 14:56:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 14:56:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 14:56:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 14:56:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJKG7oDr90b7ZzxyPAgSovOdGScxnCIw8q48E2CYOvmRwQ3htNb5ZevjuMTFECtx9W5Z6hv53Lru3N+ud7DL9aYfrq2auvzDywciOLuRMKYWmiUZbfUVyCebi2g8Z2hqSur5bm8mdpyxFq8iQ80rkl16VZsp5jxqAcEtID/9+qnHT6+6ONrgPMM10r02ZZl7oydL4+FLQWW3yuII10Ga8e8xTTWh1JQblodOBOl81JNadv99vyJuAKfmfumrOv85kKQyvymkJluVtpdm7c2z6fa17vZUBf09+fea0k1Dv+2t+1y7K3gvrte2QMM8sbSQLp5z/TtFJyevnzJDGX6IDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fbGtEGJitKfQ0h3MJNfwd6Z/hLzqpBwSTf+VXlMqcc=;
 b=ig6DQIBuqwOrAOnkCVULqn7yjiVt4ffNbaNH6Xmu8urChVTLQixjUG8rAEgyabqXkNiEJt7tHxvJDLuyf67uqyO2zs7bABaYUPjgrbbHDqKl8KF9tPUMQx3IqYb/Qws4xNadlzuJT03dnX2p5buKx9WlpL/EfyM/PYGudTw2zAKBvSdd2qOBQDLCNyUoDyZzTjCKzFHTR2upFkociaBrGird6FGRtqefw7D2NNMSgrxR2uX8Z9/Q9enIgrKAo+HHuRYBtFoDrgph5fMSkw1icQ9eaPQiF2Ryue4xc3ji9elSNHuDGQNKM4JO91VsyIwxJCMMDXc8oNeGCSwhebqxcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA2PR11MB5179.namprd11.prod.outlook.com (2603:10b6:806:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 21:56:38 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 21:56:36 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "hpa@zytor.com" <hpa@zytor.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "haitao.huang@linux.intel.com"
	<haitao.huang@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"tj@kernel.org" <tj@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"jarkko@kernel.org" <jarkko@kernel.org>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v14 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
Thread-Topic: [PATCH v14 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
Thread-Index: AQHas6mflFixkrFHt0yoIhH7CPXyGbG4LewAgAEmJ4CAAOqQgIAAgJ0AgAbnpYCAAO+QgIAAlqeA
Date: Tue, 11 Jun 2024 21:56:36 +0000
Message-ID: <29df5694f85ce2c72e8f5d300bfbb6d1b2cbc082.camel@intel.com>
References: <20240531222630.4634-1-haitao.huang@linux.intel.com>
	 <20240531222630.4634-15-haitao.huang@linux.intel.com>
	 <D1RKK8CENNXI.1KMNDADV9C1YM@kernel.org>
	 <op.2owf5xiwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <D1SOT40TEXMI.A5J72PR5IWSP@kernel.org>
	 <op.2ox4ccz7wjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <eb36980a-2a81-426b-82fb-7f598f7a0037@intel.com>
	 <op.2o7cxtg8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2o7cxtg8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA2PR11MB5179:EE_
x-ms-office365-filtering-correlation-id: 61c2093a-adb9-4d10-29e8-08dc8a615d70
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230032|376006|7416006|366008|1800799016|921012|38070700010;
x-microsoft-antispam-message-info: =?utf-8?B?LzkrS2UrODMrMTFhY3IyZ3Z2OVBlQlh3aHpLNlVNZy9RZU1NaW80cXQySWxT?=
 =?utf-8?B?UUFOMHlTUWxXMEtuUDJkTFM5amZPbHc0bldrekw4RWVLSG1hc0YyOTFxZWg2?=
 =?utf-8?B?VHBZTU13ZHd5Vm1kbWRremkzMGpON1pnejUxWUhSWm1xcFBDWERCTTRpbjRJ?=
 =?utf-8?B?aUtFWWFJeDFyeWlTbHBsWVpLTlQrL0JpT1l6WUVyR29wSWYwZldZckpDVTFM?=
 =?utf-8?B?Qy9EMjFCZUUyaTFZL0kxVHNvTjY5Z3VCUDJpSHBYL292TjhZUjFxbmlDN2Rm?=
 =?utf-8?B?ZVZkZGI3eGs2NGJ2b3I3TFJsdFkzZ1ZUVjFoNENEOFAxRm5KOXJDUG5INXVk?=
 =?utf-8?B?ZDRWamE1QmtQYVJJZXFCcXd3WjcvcVVrTXV0cEVqWTZXUi9ldnllYjVKcmZ5?=
 =?utf-8?B?eEd4Ym5ORFY3NGJSS2MvWDJqUERWVHJveTYvZ2l5WU42ZkZDV3BUb0t6N1Fz?=
 =?utf-8?B?TG52TVJkNUtzOStzcU84N3JjcUhVLzdhNVpMbjZIZGc4c2xLd2xzeVE4V0o3?=
 =?utf-8?B?N01aa3NEN1RDYXp6dEdwci92SFhpMWtCY0c4dlJwOEd3NFR2SGhiSXZBUVcv?=
 =?utf-8?B?VDBrd0lEc3JkYUdFK1dZYWhSalVaeUh6VG14bWRvMU5TOUR0SU8yQnFaNDBT?=
 =?utf-8?B?TXBoMEVaSlA5U3Zsd2hYT280RHpaeTZtVytvTXZJNVlqbjA4aFpxS09mckNK?=
 =?utf-8?B?bWV6ZGJwUFFJeExrV0Y5UFFNejRNaXFaV2JuMTlDQlNUN0ozMFV6ekpVRjR0?=
 =?utf-8?B?ZCtvOHh0bmxKYnVpS3VKSGZpUjJhQ21DODMrZEgvU1lNMUM5enlZeVh2Y3Nj?=
 =?utf-8?B?Y1FWZnBBZkVXK202cVo2VmMxemFOT3VoNWd4RzN3SndxTDVQR0tPNjdxUnBD?=
 =?utf-8?B?L1N0NEZRQ2prNlJlNnV1SFVqRFFvcWMvZmNqTFZDSjBObDlCTDcyWnM1YUQ4?=
 =?utf-8?B?MjZtalZuWlVyRWtycWJsUnpob1o2bEZLUkdXQkFPT29PYUduWGluazVaSmJr?=
 =?utf-8?B?RXA4U0Z3QjVoSkI1VXFVMDB0b1RxVGQ3TDc2RlYyWG9RS2ttcHp3RFA0R3Fk?=
 =?utf-8?B?MlF6aXM3RGlvK29JNjJaL05XOXR1MHpEcXJlOGpUcWsrMyt3TXJlR2hZb0VN?=
 =?utf-8?B?Y0EyZFRvY0tVYXVtZFEvNGJyVzhaWTJ6VnhTR09nWmJvWXN5cmJZOTc4VHFt?=
 =?utf-8?B?MkFicHRrTDRhdERhaklPcURXK2YyNnNXTWpVSXp3MzJTMi9FVFhVSnFsQzNi?=
 =?utf-8?B?SHJsdkNKSTJ4Qk5PQkZoY2FGWGJMZHVQSE5PUlZUdFJiYmNXUVZxQVEwbWEr?=
 =?utf-8?B?NWg3ZTlvVHFaVzY1cWJoM2hLbXpjbGpuUS9seTNPbllkbUYyUFRxU1hxUVRP?=
 =?utf-8?B?MFNzN2tmN2JRYktwd05hMlNORlI0djBtMkhVb2d2eDdHbWxRQUJJRHVUcEEw?=
 =?utf-8?B?STFNcVI3TjA3bUsrNXhUMEdSMHdqVWRaL3c0VytJeS9ET1RZNjRseTN6S2ty?=
 =?utf-8?B?M2NLZXdvRGNPdmJEVWxZZGEzWWExSURiSXpnajd1OG1neUs4SmcxbSs3ZTBp?=
 =?utf-8?B?V2lXT0lJQkYramlGaDVLVzhrWjlrMkptZFNQNm5NM2QvTWtzZTN0NmU4emJp?=
 =?utf-8?B?dnJkVHRQeUhsOUljcDE1cFFUUkNTcjN0VVdKVFdUd0xraUdzdWdtRFJQdjZ2?=
 =?utf-8?B?N1dHYkd0VWQ2RDFFTEFJMlYxdjVuenZxcjBXU3dRanJ4RWFMVXpacFhJbGkx?=
 =?utf-8?B?T21GM21pQm1KaHh6VlBUMVhmODR4UFVuZm5ZcTFNRWtZNDdmVzNkY3c2RXhM?=
 =?utf-8?B?R3A4OVA4aE1aNm92TjdPQkRrT3YrQXVEaXdyMS9QY1h4dzRLbVgxQVBDZDlP?=
 =?utf-8?Q?9W6nfHSAdzlXW?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(7416006)(366008)(1800799016)(921012)(38070700010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUN5bkhjbWhKd3BnMnhnWFp2ckFaOEJmZHZ2cDQvczE3MHlFdlBlWlUwbkpp?=
 =?utf-8?B?c3BxVDhxZVdQUTM5SUNvSllwMDlNWkY3QXJuTHBGRW5QMStrRW5Sam1vNEhL?=
 =?utf-8?B?WkVuUFNFQzZVbVdaaU5mZXZJSU0vZnJtMjlmS0hUbjFaUitpRnBNdDR2Ylpw?=
 =?utf-8?B?SFgwNE5TSDF6UVJHSytaTDJ3RkliS2w1TG5vZnRNSm12WU9HOU1vc1NSeUJ2?=
 =?utf-8?B?SVVPSEUrdFNrZjM1MEhDQXVsblpwaGd4d0F1RnN4UU15dlY4RTgzeGNSY3Jq?=
 =?utf-8?B?Ri8zOEhlRklLQmRwUUR1dVN0TGtvVk1Vd0svL2JzRXAzOExIK3FOZ1BNMU5q?=
 =?utf-8?B?MGcwL3B5c1dNKzdBZ1RPeGVtWForMlZRdEZSR0w5TldCTThncEthR05Zc0Fu?=
 =?utf-8?B?RVNIMUl4ZlhtbHpJbzIxNnl0NCttMTJvY2hYalJwZFZoOEd5WS9mSDA5T2R4?=
 =?utf-8?B?V0xZeERTK1ZaaXl1dTZvZFpSeUU4eFMvRWRIbW5WU2VGK2RHMnBGWWkzL3cx?=
 =?utf-8?B?eVlRYkhTN2RPUjU1MUlBNVdESGNHUVhFQ1lrTDluMTA1WkxMNlhZck4rd2Jh?=
 =?utf-8?B?VGtJQnZXcFhkY2JzYU1GQWdpSW1GbzFYVktwZ3BBSmFMVFRqa1FLWkJMTHN5?=
 =?utf-8?B?Zkp4RzNqL012M0dOU1BJenBYSklubmVQRTEzRUUzd2FyTENnSjNGckdmM2hZ?=
 =?utf-8?B?WDVsa0xiYkhIVGcxcGNjanJQUng0S0hrRStwVjUzS1hRV2d6TkJQWFR3ZkdK?=
 =?utf-8?B?bFpQelN0OGpZb1ppWnNhRDJEVTZFOEw5U0hLd3BUR1RnV2NlVHYyYUl2blJO?=
 =?utf-8?B?N05TR09Sc2diczl0S1phR2QzY0JQUUhuNGZwejQ0cUk1QklSSVRGN25tUzFr?=
 =?utf-8?B?ODgzaktsd2UyYVBhMkxGTGxEMHo3MjcwUWszMXU1UUpHeG4wcVJReEdhYVJu?=
 =?utf-8?B?NXEvKzZzN1hwUEhhTzhyQXFHL0xIT01IWXF1ZU9mL0FaaUNZQndOeFhxZGt4?=
 =?utf-8?B?WlJ4cXpwMUhmYzJpbkJOakdDKytjZzFMcjlQUDVNTFB4ekY1UExCM2gwQzlN?=
 =?utf-8?B?UVowY0s3M3ZyODM4NlduWjNpQld2WkM5VWZlTUt2L0RpK3B4bmswQUtxQnNP?=
 =?utf-8?B?NWRtVFJNQ0xOUUUxREJZU2lvWG5PeVpUajlhODhsQ0V4ZFhjQ3U4NTQ1Vkt2?=
 =?utf-8?B?aFhZaVBLa21xa1hoRWtyK3FqSlZidEpWT1pOcmxRcjhlSmduWUVxTlpHZktW?=
 =?utf-8?B?Q2E0c1laTmhtVFplWjJDcjFIN3l0ZmFoSjF6Vys5SkVOcTBZZVk5MWFzV3Fo?=
 =?utf-8?B?eWMxMmJTaEJocUwwOEpURVVxZjE4SmFNWHd6Y3NRNFhQK1hJUXRvVlMxY0lM?=
 =?utf-8?B?bUp2V0NjenZFUVVjaVBOYTdHcFZYUXBpR0w2d3Q5bm5WWnUyVDdaSXl3RkFW?=
 =?utf-8?B?d2p1eTFlS2hmbTVtYXFrdUhxdU10djNmTFBxU3hMNmx4ZWJ4ZjMxSWNsVUNV?=
 =?utf-8?B?TVM3bUNFSUsycXNsaHM5QVZ2emRSb3ZsWmhVcnVQY1JIOXJCbDU1eEMzRzR2?=
 =?utf-8?B?U3hDK0lLWkppMm51YjVPNnJNcVBEaTUyaEE1WDVuSEh5ZVVpdXphamFjNGFE?=
 =?utf-8?B?eEs3MDFrMVlRaWpqaGordlQ5aytNeFlOZTlic0xkdmVUY09EMVY4OXl1U3Nu?=
 =?utf-8?B?V3VnMXRuSEFnc2MycEoxek5JWlZlYXhSdjNTT01rMi9TaW1FMklHWTh6b21q?=
 =?utf-8?B?UkVBaDFMdEcrc1V5SVFqQkZCd3BBcXY2Rk1BTUk3MXdRVHBEb3krTnNJeXZm?=
 =?utf-8?B?c240M3Bhc2c0SkNCOEdpcERYY3FJZWVhRHhJZUVhdS8rNnhTMjYwc1h4eUxr?=
 =?utf-8?B?MlhUaWRTdERYRFZVTjIyVjdYMmtrTEdKYVAvR3lqbTRmc25zMHBYdGRkMzlV?=
 =?utf-8?B?UDVkZnNoT0J4NDVmejFjZVgwSGNTM2FiTTczZlZBYXJJUHBSQmNZbHZOZnB2?=
 =?utf-8?B?dnRKcGo3MDE1LzRYWEpCci9OclNBa1lEMlAwekgyeU1kRUJ2cFVac2R2Mk8y?=
 =?utf-8?B?ekIxM3JrVEcxenJlV2xiVjUvdEU5REVBQThxSFRiQ3Q4bUxJOFFGL2Q3OUxQ?=
 =?utf-8?Q?njkfHYhGsiduxkFVarOc1cz5W?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5A4E94FA462E0459DAB9CEA41D5C061@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c2093a-adb9-4d10-29e8-08dc8a615d70
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 21:56:36.3582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9236i+1VV4wcIN04cphx5e0mIzE3dGlSaNeLD91IP6fvdm7j/f7E8KPK/yj9d7ISTeWKLHVbKv5SCLeBxsFIBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5179
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA2LTExIGF0IDA3OjU3IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIE1vbiwgMTAgSnVuIDIwMjQgMTc6Mzk6NTMgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiANCj4gPiA+IC0tLSBhL2FyY2gveDg2L2tlcm5l
bC9jcHUvc2d4L21haW4uYw0KPiA+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvbWFp
bi5jDQo+ID4gPiBAQCAtMTA0NSw3ICsxMDQ1LDcgQEAgc3RhdGljIGludCBfX2luaXQgc2d4X2lu
aXQodm9pZCkNCj4gPiA+ICAgICAgICBpZiAoIXNneF9wYWdlX2NhY2hlX2luaXQoKSkNCj4gPiA+
ICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ID4gPiAgLSAgICBpZiAoIXNneF9wYWdlX3Jl
Y2xhaW1lcl9pbml0KCkpIHsNCj4gPiA+ICsgICAgaWYgKCFzZ3hfcGFnZV9yZWNsYWltZXJfaW5p
dCgpIHx8ICFzZ3hfY2dyb3VwX2luaXQoKSkgew0KPiA+ID4gICAgICAgICAgICByZXQgPSAtRU5P
TUVNOw0KPiA+ID4gICAgICAgICAgICBnb3RvIGVycl9wYWdlX2NhY2hlOw0KPiA+ID4gICAgICAg
IH0NCj4gPiANCj4gPiBEb2VzIGl0IG1ha2UgbW9yZSBzZW5zZSB0byBtb3ZlIHRoZSBzZ3hfY2dy
b3VwX2luaXQoKSB0byB0aGUgIA0KPiA+IHNneF9kcnZfaW5pdCgpPyAgVGhlIFNHWCBjZ3JvdXAg
b25seSB3b3JrcyBmb3IgdGhlIGRyaXZlciBzaWRlIGFueXdheS4gIA0KPiA+IEluIHRoaXMgY2Fz
ZSwgaWYgc29tZXRoaW5nIHdlbnQgd3JvbmcgaW4gc2d4X2Nncm91cF9pbml0KCksIHRoZSAgDQo+
ID4gc2d4X3ZlcGNfaW5pdCgpIGNvdWxkIHN0aWxsIGhhdmUgYSBjaGFuY2UgdG8gd29yay4NCj4g
PiANCj4gDQo+IHZlcGMgcmVjbGFtYXRpb24gaXMgbm90IGRvbmUgYnkgY2dyb3VwL2tzZ3hkIGJ1
dCB0cnlfY2hhcmdlKCkgd29uJ3Qgd29yayAgDQo+IGlmIHVzZXIgZXhwZWN0aW5nIGNncm91cCB0
byBsaW1pdCB2ZXBjIGFsbG9jYXRpb24uwqANCj4gDQoNCk9oIG9rLg0KDQo+IFdvdWxkIGl0IGJl
IG1vcmUgIA0KPiBjb25zaXN0ZW50IHRvIGp1c3QgZGlzYWJsZSB2ZXBjLCBpLmUuLCBvbiBzeXN0
ZW0gd2l0aCBNSVNDLCBzZ3gvdmVwYyAgDQo+IGFsd2F5cyBnbyB3aXRoIGNncm91cCBlbmFibGVk
Pw0KPiANCg0KWWVzIGZpbmUgdG8gbWUuDQo+IA0K

