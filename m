Return-Path: <cgroups+bounces-972-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DB2816424
	for <lists+cgroups@lfdr.de>; Mon, 18 Dec 2023 02:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF771C2099A
	for <lists+cgroups@lfdr.de>; Mon, 18 Dec 2023 01:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619F71FD1;
	Mon, 18 Dec 2023 01:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4KkVQ8l"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3C31FBE;
	Mon, 18 Dec 2023 01:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702863903; x=1734399903;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ag0+fFXJYaaMggNXhBJxhKzU1Clpx5Bl30HQtLfBbWA=;
  b=Z4KkVQ8lmj9/xTA1gEDKNmWlAECTSRqep1Ak4h2FHayZXMYNJtd3nbWv
   xH6WmZqEC/XL5PHPcrCnJQuKRtAV15tEqrLFnI2nXnlneUpmObAFhJAK4
   ixpzNv6eN65Vqh07i3TfimrdtwhtjM6PkhEw/CeWn0HslfFjXEcX9enko
   5/a1+eG70MYkM4O+/tsY5fo3qoaVgu5ANonvpqOqALqCnYO/Mf/qUpriV
   bQy/fOAvYGQd1mmCcnH/1NFZLHlmtCyv5iKt+u22guonUdwFa57zvlbp1
   B/l4PDDTjryIoo9lPSHdW2o/64iQGVA4mD2au/SDHAWZtnXKYU6Aam49W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="385866022"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="385866022"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 17:45:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="948603282"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="948603282"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2023 17:45:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Dec 2023 17:45:02 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Dec 2023 17:45:01 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 17 Dec 2023 17:45:01 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 17 Dec 2023 17:45:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TI9KUwNqujyIXHPVFEyz6mbJZfgR377P9k3bCYsv/cQV/wGrokVyo0/AHLiollVSu+/er9uFpmI4qd0TLROXtyCz8GIDFmsTEpffdMVp6MaEoMlC1w0AZmCIDiw4/Zrly/ScW2AbCVuIqW+aC+V3XcQbNH5TYhvpTo9UvI7FV0C6a0IZqa5ghtCoxqfxswdUX2yvDYuIY0RMEvQFa7LMPuHBByiFpAqydauJP5O1Pk9RH8T8o+owixsR0tvRYGg7EVNE5Z/CzsduScGU9wcS6U3qHPUD6rD0k4HW8PP75C1212hjAg28zUDhqr3ZWglG/CiNSiq/BN2MJLRscvAlKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ag0+fFXJYaaMggNXhBJxhKzU1Clpx5Bl30HQtLfBbWA=;
 b=eDPGl4y5JR5b7D510d/EGFpcqM+PahEVaazvMZw6flLO6h37hf83KVMaUnx1i/gYu/+BcM0SPAOjoFp1uSKD4RZlxAI0+iYFjBvkfSfrToR//Nw2I0euMK2b5lCCkVZu1J/bbzOGdPuXSCFq6X7HGSeXihRY6aSx8l3GZEleBYq6U0gC2UYJSZjutWlwkzIZBa9HtT5qZrtkezs3grMzXYflUoSRCGmG2C7dwPNSFeKmG8UhlAFfjSsitSlyNaVMPp/l8p/FNX/6EZEZurUDS58Sf2o/W7MxOkLle9CjqZ30bEPJak2xVIAKQgb+3GxHj7/b/6VMyIr9tO094c5UAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM6PR11MB4626.namprd11.prod.outlook.com (2603:10b6:5:2a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 01:44:57 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 01:44:57 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "jarkko@kernel.org"
	<jarkko@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "tj@kernel.org"
	<tj@kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
	"haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "anakrish@microsoft.com"
	<anakrish@microsoft.com>, "sean.j.christopherson@intel.com"
	<sean.j.christopherson@intel.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"yangjie@microsoft.com" <yangjie@microsoft.com>
Subject: Re: [PATCH v6 09/12] x86/sgx: Restructure top-level EPC reclaim
 function
Thread-Topic: [PATCH v6 09/12] x86/sgx: Restructure top-level EPC reclaim
 function
Thread-Index: AQHaC13fVBhlQReaAU+BOIqG+a/nT7CCsVeAgApC3oCAASUwAIAXMJEAgAILHwCAA7PlAIADh+IA
Date: Mon, 18 Dec 2023 01:44:56 +0000
Message-ID: <73ed579be8ad81835df1c309b7c69b491b7f2c8e.camel@intel.com>
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
	 <20231030182013.40086-10-haitao.huang@linux.intel.com>
	 <c8fc40dc56b853fbff14ba22db197c80a6d31820.camel@intel.com>
	 <op.2e0yod2lwjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <431c5d7f5aee7d11ec2e8aa2e526fde438fa53b4.camel@intel.com>
	 <op.2ftmyampwjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <3c27bca678c1b041920a14a7da0d958c9861ebca.camel@intel.com>
	 <op.2f0eo8r1wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2f0eo8r1wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM6PR11MB4626:EE_
x-ms-office365-filtering-correlation-id: b0ce346c-a224-4207-f34d-08dbff6af08e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ktXNXNwDNxCb8+4pcnKRnF9PO6ddp+mBA4ByhV5FGuswGvmg8RXGgVIwf3QHLLAUmBwDPAoAGT2WpSuqQ9zUhWoQJzD6mbUWBjFYGV1KIsT9P+6vMc4BzuAqWg1wF/tckxkwkOwa9H+Mgeke9c0e4MERMBJaMTDlwwY7gHzkZdyFxyZucN9aYKmjb6RjXXj/bZykdWo2NBT9blWUqZOEKC+O+CciJvgJ6VnD6/UvX+TV0d2KHqG5D6LyE30pvBNAPAGTzgL1jCFvY5WXApErJCUFRuoQV55tdO6JmQ0O1ACMbZ1mSCwXZQF5H09niPcgevASbNWmLVAcmV5keesJQmdeqJ/fiPYuDMvQmyaTWTuGMVHUZXn85UtomkHfIZ0I4QCLy9rQZPX6Pky4USOB3z/QYMp4zU4V/OsKZGVyhEIwaUTJ1v1wkWhvhgF2SA1liYoyRpHwhk+4gBbt/ls/lZV9ZZxcx9hBlVch8sA0hqqEvXGzBrUv4sYJq+TPn5qd30G5lrw19u/j3jyE7hGfymqgzqBk1nAXId8BDze4B93+CeAbU200QEgpvA5r+kDErHZ6mHQcmiUaALKnDatXWD6WRVrNPvbCY/VfIxORYp9MV2bEK+JFjozYLgmgjm1/pHX4hZLFCY39FvAJOQnkDZnJucy2RvDBGWpBNrQbPGE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(5660300002)(83380400001)(26005)(6506007)(2616005)(6512007)(66946007)(4326008)(41300700001)(7416002)(2906002)(966005)(71200400001)(6486002)(478600001)(316002)(110136005)(54906003)(8936002)(8676002)(91956017)(76116006)(66446008)(64756008)(66556008)(66476007)(36756003)(86362001)(82960400001)(122000001)(38100700002)(921008)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTBUdk81ckxqTDNNd2dreExReFpOSm5hY1RVbHFVMndTczBPcEtwaDVyVWQx?=
 =?utf-8?B?U1ZyL1Q5OVZUWmlRS1kwZFlVU3VZRVNhdElsdVAycnhIZ3FBSDhuV1NHZnBl?=
 =?utf-8?B?dEt1VGdKWXdpSnZnT1JMREtTc2JYb0xXbzF2RVREaVBjY2d2NG8yOXRBaFlh?=
 =?utf-8?B?cnp2ZzFRK3lheDZlcFlrWDRJK3RxNHQ1YXVTNHZoNW9BejVaa2hOSjlPbE5C?=
 =?utf-8?B?Sjk5bFlJZlE4cmlKWWZ4cVVLOUdnbjExclV6YmFHdEg5WFJHYWE1ZHFEWEt0?=
 =?utf-8?B?YXhkUWhZUGVRUzJKMVFxUGwyeW5VR2RiVWJTcldWZ0ZHN0l1SFEyUnMycVlj?=
 =?utf-8?B?RldOd2ZuQVYwbW54WXFrZVlldHVZMytsZDBmdUlJeWRsMlk4WkxheXg5TWps?=
 =?utf-8?B?RW1HVGhSTmpJVVgyRVJPcDdRNFh6YmJoaG9Pd2FRWkF4ZkgxR3YxSmJRcXRL?=
 =?utf-8?B?NUFpWklSVVhhRVF6SXhhS3hrM0x6czNtSmFtcDk2OExoUFJGRWh6SGg5MVpp?=
 =?utf-8?B?MHZBRW00OHYrKzl2aml6NExqRGRFa1AxUUNabzd5QXhCZ2M2V1NqL3FueEVF?=
 =?utf-8?B?TUNmSXpWbDR0dW50MkZmR1JsTzRmQ2dhT2ttMms2dXpyQW00NXpyMGdBdjdr?=
 =?utf-8?B?MXZEbkQyaFB6S0NBMGtac1RoTHczNkJVWGZSaTZPdEM4MmNkMk1PMlNwWWUw?=
 =?utf-8?B?c1VFamF6L1pGL3l0cDZLaWhuR2hEbXppdFNYWkhickJiV1FLSWhEN1g0Qm5k?=
 =?utf-8?B?d09LRExxVmFHZm55VGlCZlRvaWdRanE4MllFUElNeU0yUjRLcStjQTFhY3B4?=
 =?utf-8?B?MkNiWHhvWkJmQTdKc2V5c3l6RDBmWS9XZW9VdzhrMkozK2x4b1IwK0VnMU5R?=
 =?utf-8?B?amNvSHBoejB6WHlGd0R2U1NqVnFuWmMyYU1hVWhwZ1BTZi9kWGdtUEhiSTRF?=
 =?utf-8?B?VFZzSmphNEYxaUNhc0tpVzBlbFZuUTFSZmZzQVEzZTN3bEdRTzRMbk54NDJk?=
 =?utf-8?B?ZWRhYTZ2UjZ1NWRUQWVTamJFZ2I2YkIxSFB4YkxpYTR5akJrMFk3WWRlMFpz?=
 =?utf-8?B?ZUp2UThhazZ1TUs1ZmlkcmF1bmJsTW9vTXdKcEZHK25KQmxXdS9HaU5iZlo0?=
 =?utf-8?B?QnJQdTVTYnVLeXVQaU4wVDZ1TFptRGpZSmkwYzRrcGIxUm5zUDU1WXkxYTF2?=
 =?utf-8?B?WUhWYitoUFFVanNWNzQ1N3hvbzFhSzVkOXBvOUt4alJvc2I5TjNyaXZ4VWs0?=
 =?utf-8?B?TkdscHlUY3hDZ3dqMmh0ZzI4OG12ZWg3VHhmSC9SeHVtcnpCV3dkWmZJTHBp?=
 =?utf-8?B?SG9wdVlYa0R1ZHZvS2poUHBScTdNYWNNdkhmZFRpeGp6ZkJtMkhXVHpxdzlh?=
 =?utf-8?B?bnB5Mlo2ZFpsVDMyMXBSYXJQS3RxU0RaLzJLYXdEMVZtOWZobGg0ajhHQUtO?=
 =?utf-8?B?cHAzdUYyRDRvR1NvVlZ5ZytZUmsrM3QzRVNjMFBmelpKQVc4WHFxRVp1VXEv?=
 =?utf-8?B?WUc3bnpEM2pxNVRlbENDZnVWOUtQaVprRER3blFZdDFNL2JiZjVOM3hZMG8y?=
 =?utf-8?B?c3JZWlQxeno4Ti95dXRXNlkyRWYzeGVLaHF1dEVkdUd4YUxvaGpMVHdlMDMz?=
 =?utf-8?B?dnB4MFhMazBKaVBTUGlXUk5tMHQ0b3ZBYTU4blg3VXAwcG9QeU9HempwR2xr?=
 =?utf-8?B?cEtHNUhXRmUyeFRYdFREU3pwaDU4S1NmcW55UVQvWjNxZmlNaFlsbUNRMEtF?=
 =?utf-8?B?K2xWS2lXdFNtbUN5aXRkdno5NHVZY0RuUWJwUUU2NGtyODV6RktyMy9Maitk?=
 =?utf-8?B?ZnBsZ3BPL2lERzNSTGZIbXN0SGduaEdYcTlxak5pQmFjY1RVUkYzNDFyN0Vu?=
 =?utf-8?B?aUZTVi80TVRwSGd5bHNsYTlIUS9lejV4U3J5U0lHZitIYU9NN296c1VJMmox?=
 =?utf-8?B?NjkxSEg1dUllM1dzendwZW1CTHpBdUd6ZkdCYlE4N0gyNXh6emNlcUErM1Ir?=
 =?utf-8?B?MWtsdXNRZFdkMkFCMDcyWDZVV1h4QlhvZFZCdWhVaTlOS2RERjl3SmQ3WU5V?=
 =?utf-8?B?RHNYaHNEd0EvVmgzQUNndkNyaUV4YzQwQTU5UTNENTUrWUV4c0t0ZDErN1Y2?=
 =?utf-8?B?MkVpZ1JmOFdyZno4Q0Fnb3ltd3ZNMHZaaUtFM0pTUHIxdElyM1lFVUljL3RG?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92A40F4D62483A43987223390902070F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ce346c-a224-4207-f34d-08dbff6af08e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 01:44:57.0045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BsGxIfm60A9DaGliQC3kN/cLzjZk5/c+VKkgbcY3KSwrJJq57O4+n55QljzZGc4Gie38oNNFonrjlliPjosdgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4626
X-OriginatorOrg: intel.com

DQo+ID4gDQo+ID4gVGhlIHBvaW50IGlzLCB3aXRoIG9yIHcvbyB0aGlzIHBhdGNoLCB5b3UgY2Fu
IG9ubHkgcmVjbGFpbSAxNiBFUEMgcGFnZXMgIA0KPiA+IGluIG9uZQ0KPiA+IGZ1bmN0aW9uIGNh
bGwgKGFzIHlvdSBoYXZlIHNhaWQgeW91IGFyZSBnb2luZyB0byByZW1vdmUgIA0KPiA+IFNHWF9O
Ul9UT19TQ0FOX01BWCwNCj4gPiB3aGljaCBpcyBhIGNpcGhlciB0byBib3RoIG9mIHVzKS4gIFRo
ZSBvbmx5IGRpZmZlcmVuY2UgSSBjYW4gc2VlIGlzLCAgDQo+ID4gd2l0aCB0aGlzDQo+ID4gcGF0
Y2gsIHlvdSBjYW4gaGF2ZSBtdWx0aXBsZSBjYWxscyBvZiAiaXNvbGF0ZSIgYW5kIHRoZW4gY2Fs
bCB0aGUgIA0KPiA+ICJkb19yZWNsYWltIg0KPiA+IG9uY2UuDQo+ID4gDQo+ID4gQnV0IHdoYXQn
cyB0aGUgZ29vZCBvZiBoYXZpbmcgdGhlICJpc29sYXRlIiBpZiB0aGUgImRvX3JlY2xhaW0iIGNh
biBvbmx5ICANCj4gPiByZWNsYWltDQo+ID4gMTYgcGFnZXMgYW55d2F5Pw0KPiA+IA0KPiA+IEJh
Y2sgdG8gbXkgbGFzdCByZXBseSwgYXJlIHlvdSBhZnJhaWQgb2YgYW55IExSVSBoYXMgbGVzcyB0
aGFuIDE2IHBhZ2VzICANCj4gPiB0bw0KPiA+ICJpc29sYXRlIiwgdGhlcmVmb3JlIHlvdSBuZWVk
IHRvIGxvb3AgTFJVcyBvZiBkZXNjZW5kYW50cyB0byBnZXQgMTY/ICAgDQo+ID4gQ2F1c2UgSQ0K
PiA+IHJlYWxseSBjYW5ub3QgdGhpbmsgb2YgYW55IG90aGVyIHJlYXNvbiB3aHkgeW91IGFyZSBk
b2luZyB0aGlzLg0KPiA+IA0KPiA+IA0KPiANCj4gSSB0aGluayBJIHNlZSB5b3VyIHBvaW50LiBC
eSBjYXBwaW5nIHBhZ2VzIHJlY2xhaW1lZCBwZXIgY3ljbGUgdG8gMTYsICANCj4gdGhlcmUgaXMg
bm90IG11Y2ggZGlmZmVyZW5jZSBldmVuIGlmIHRob3NlIDE2IHBhZ2VzIGFyZSBzcHJlYWQgaW4g
c2VwYXJhdGUgIA0KPiBMUlVzIC4gVGhlIGRpZmZlcmVuY2UgaXMgb25seSBzaWduaWZpY2FudCB3
aGVuIHdlIGV2ZXIgcmFpc2UgdGhhdCBjYXAuIFRvICANCj4gcHJlc2VydmUgdGhlIGN1cnJlbnQg
YmVoYXZpb3Igb2YgZXdiIGxvb3BzIGluZGVwZW5kZW50IG9uIG51bWJlciBvZiBMUlVzICANCj4g
dG8gbG9vcCB0aHJvdWdoIGZvciBlYWNoIHJlY2xhaW1pbmcgY3ljbGUsIHJlZ2FyZGxlc3Mgb2Yg
dGhlIGV4YWN0IHZhbHVlICANCj4gb2YgdGhlIHBhZ2UgY2FwLCBJIHdvdWxkIHN0aWxsIHRoaW5r
IGN1cnJlbnQgYXBwcm9hY2ggaW4gdGhlIHBhdGNoIGlzICANCj4gcmVhc29uYWJsZSBjaG9pY2Uu
ICBXaGF0IGRvIHlvdSB0aGluaz8NCg0KVG8gbWUgSSB3b24ndCBib3RoZXIgdG8gZG8gdGhhdC4g
IEhhdmluZyBsZXNzIHRoYW4gMTYgcGFnZXMgaW4gb25lIExSVSBpcw0KKmV4dHJlbWVseSByYXJl
KiB0aGF0IHNob3VsZCBuZXZlciBoYXBwZW4gaW4gcHJhY3RpY2UuICBJdCdzIHBvaW50bGVzcyB0
byBtYWtlDQpzdWNoIGNvZGUgYWRqdXN0bWVudCBhdCB0aGlzIHN0YWdlLg0KDQpMZXQncyBmb2N1
cyBvbiBlbmFibGluZyBmdW5jdGlvbmFsaXR5IGZpcnN0LiAgV2hlbiB5b3UgaGF2ZSBzb21lIHJl
YWwNCnBlcmZvcm1hbmNlIGlzc3VlIHRoYXQgaXMgcmVsYXRlZCB0byB0aGlzLCB3ZSBjYW4gY29t
ZSBiYWNrIHRoZW4uDQoNCkJ0dywgSSB0aGluayB5b3UgbmVlZCB0byBzdGVwIGJhY2sgZXZlbiBm
dXJ0aGVyLiAgSUlVQyB0aGUgd2hvbGUgbXVsdGlwbGUgTFJVDQp0aGluZyBpc24ndCBtYW5kYXRv
cnkgaW4gdGhpcyBpbml0aWFsIHN1cHBvcnQuDQoNClBsZWFzZSAoYWdhaW4pIHRha2UgYSBsb29r
IGF0IHRoZSBjb21tZW50cyBmcm9tIERhdmUgYW5kIE1pY2hhbDoNCg0KaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC83YTFhNTEyNS05ZGEyLTQ3YjYtYmEwZi1jZjI0ZDg0ZGYxNmJAaW50ZWwu
Y29tLyN0DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL3l6NDR3dWtvaWMzc3l5NnM0ZmNy
bmdhZ3Vya2poZTJoemthNmt2eGJhamR0cm8zZnd1QHpkMmlsaHQ3d2N3My8NCg==

