Return-Path: <cgroups+bounces-474-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9027F0AD9
	for <lists+cgroups@lfdr.de>; Mon, 20 Nov 2023 04:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F831C20754
	for <lists+cgroups@lfdr.de>; Mon, 20 Nov 2023 03:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6E31FB4;
	Mon, 20 Nov 2023 03:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPedXI0E"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDAD137;
	Sun, 19 Nov 2023 19:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700450218; x=1731986218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NTNC+qkED1gI+6X6cRKEYHcUQJBWENBEwoAndkGb7tw=;
  b=JPedXI0EllyIkKukbSJgH0gX/oKycWBMK/F9FkEkwkz+VjGhdyYJf0ad
   hFbRsG03GIq3t3weXULiBNgyTNT3O1m75J0kbQ+hk6xplW66YPG+w9LWN
   3ABwFn0GVdMy5bmWO+QsgG+3ryK0/3YGdlYcILCAzWMXu08XJdcWAaTkd
   9H4Gq5U5lq4mm0AAXjpxe8AGq4hfW0Jo1fga8hCJbIdtu5m9pssZzTsZZ
   rBCehkbLOq+oiIl4kzZBZMcv2/KsxEx+EJwbj4Rou0vKoVuiLE7fdCGfm
   mK3T4Gdo4LmKTRLCrndao5T63bEsCKz2vNCvvlX5CJJ4TrIXMXbcruTQN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="13094883"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="13094883"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 19:16:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="939666714"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="939666714"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2023 19:16:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 19 Nov 2023 19:16:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 19 Nov 2023 19:16:56 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 19 Nov 2023 19:16:56 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 19 Nov 2023 19:16:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miZHydIJNIAT4pVpNMkgnAUoUp/62mA65muAXLpEYoQPqII6ZNzpziOMufEt7c3p+QrzmgGSgHf5kXbqy9jHpWzp6I/COOYtAgDQIz2FiZDJf2pBbgDq+j58lSAxRJlD1HahgvSYhe0FHXwrWf8/ZTc+yEWhN5p1ZCC8S2p9sivHIg+a7Lr6dL0J6rah+DI7Uz8hHrldikqW4kH8botPmSnfa5BmZwQHqSYuJZ1pO4+XITXP7tsK+oB4cfpp2P6N1664M7fTBE1M/mkucG7L00/cMIDiksMwcbI5Tgm+RFKxAyOIo1meFjDPzpHc0GHjnvxNxZ+JsZH0gtp2+yC5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTNC+qkED1gI+6X6cRKEYHcUQJBWENBEwoAndkGb7tw=;
 b=AE9lpTr+S2cF+dBzGhv3CdXjb91Tb+4ngi0DAmUIxsHPLjEv9lApV3j2OmCqt+vKqe3r+rdCguUr/iaijAh1GUmDsZyVRi1Xbyx/dXH/JzJmL6T4gbwObwml91TVH9l1eUspzJDONAEKljlqqE0fzHcKSmrh6Bv+JlJwLcgz+WCchLHzB8MAcrXGvmFqJWNSsOfUYOvdjZ7+8ng629BT8CJ72HjoKmka8CppH4C4ulWCqjjbIyI45XtKLZT579vLO2WW0vhfKZeipigrRls44wjJk5LUC5pNFsz5Zr/9K5kdcE09RgwpUfwXHgSvR+3sQezbytIUdF3ttZQxNOcBXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ1PR11MB6082.namprd11.prod.outlook.com (2603:10b6:a03:48b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 03:16:43 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 03:16:42 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "tj@kernel.org" <tj@kernel.org>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
	"haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"bp@alien8.de" <bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>, "sean.j.christopherson@intel.com"
	<sean.j.christopherson@intel.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"anakrish@microsoft.com" <anakrish@microsoft.com>
Subject: Re: [PATCH v6 04/12] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Topic: [PATCH v6 04/12] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Index: AQHaC13a8dHEeRpnz0q8yAogc4UDz7BtPX+AgAByoYCAADd4gIAAMb8AgAAOl4CAFIFKgA==
Date: Mon, 20 Nov 2023 03:16:42 +0000
Message-ID: <d9ad4bac3ac51fe2e8d14931054f681a8264622c.camel@intel.com>
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
	 <20231030182013.40086-5-haitao.huang@linux.intel.com>
	 <ad7aafb88e45e5176d15eedea60695e104d24751.camel@intel.com>
	 <op.2dz4d5b2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <34a337b96a5a917612c4ec4eff2b5a378c21879b.camel@intel.com>
	 <op.2d0ltsxxwjvjmi@hhuan26-mobl.amr.corp.intel.com>
	 <op.2d0n8tjtwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2d0n8tjtwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ1PR11MB6082:EE_
x-ms-office365-filtering-correlation-id: 3df48dc9-5c3c-443b-e232-08dbe9771e4d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rimKokR58DK1h1hSbdoiO18UM5m0Xg23/RjGddxtbOh3/NxTOZjXGZJ3KQsF7QTN6y1YyvslVbV6aWVuZ8pNjxEHHIE1fwBboeiWcrunV9bZ5S3WosOrvdRKFGRqXQgTZedFHgF7gtK7E5VdIw5GZzBYCDl5NpCLFMIFRt/yUDnQIiX0O5H8evlNLRuA2Y9RbWKyeNv3BoC4O+LAbhrOnsBb/ilgOUhfXzzFDmeUjax8lM8GTR7xYNTbYiHqX4FZyXzqCQh1/VqHM2VSRONxv2RWGEJEAEDam44IBo0t6ykch6ZuUcjUh19cuZSDJEEFpgPPi4ODvdFQ89nMykJseDe3rbpDUS8/IqH97VoZUO6b3Xk1TgdXBw5lta9vTpd8R6WY9/HNbUlDusSuifUPJfSAec9nQ9byI9GNLQsCbFo8TomBqQXyNbfeE6f+mZd3JqAmJfqxNXXz+F7jcpZu6AdwjohZND9f2AnfKZPSM5hoP9/qPZqaizhzDP+Su1D+FYjbeBEOSkPfABcapcvgSgXm3Hx7KLY0JYkYj2P0m+yq8lAGr/7nptj/VeHRMJBDNg2kuOzE9aa6WHarxP1yvV9xmyVrekJNfdueh0yYIEnU8veMhmlC+kDgPeECQVF4luehNVClqw0zoaSleix1tMhxeT7CXc5kW3NRwj/vMhg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(921008)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(76116006)(91956017)(110136005)(38100700002)(122000001)(36756003)(38070700009)(82960400001)(86362001)(6512007)(71200400001)(83380400001)(2616005)(6506007)(6486002)(966005)(2906002)(478600001)(316002)(26005)(5660300002)(4326008)(8676002)(41300700001)(8936002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlhFRlJHVlF5bVVibTR1N00wN3d2TURuS0N1RFMxbWtKelF4QkJZMVBvbi9o?=
 =?utf-8?B?Q1FOdEpqcFNLdkVPOTYzMXJCMElIZURodVhkb1djOC84TFhIeWpOYnlpemlY?=
 =?utf-8?B?blJwckRwK0tUMnFFTDAyN2gwbytoUnVVN3JUdHE3S3hxRFIreWRPNlY4bmpi?=
 =?utf-8?B?SXFQRnFnMzloNWFMbHZyem9VcWJWb2xVUGRub3RjLzk1QlRRbDZyWFB1OElx?=
 =?utf-8?B?Z1pUT0hyOWdGaVRtRm9qNGNmZ0d5ZzNXU0hkTUFaamhJY2pHZGcvdkg1NkE3?=
 =?utf-8?B?b3dCcm8zTytIejdCcGYwNzhLM0xBSXE5Y0U4RFR6ZWpIRXVLOUtKOHFrMDJS?=
 =?utf-8?B?WUxsRkUra1JVN2dTUSsvRmtZbXVUcFB3dnh6ZkV6bDZReWtTRjFCUUpTZVRQ?=
 =?utf-8?B?aVhjeHZNUjB5NitNQ2t5UHdjWnZPR0o5Qjh1MVdsSjdMVnZpcm1yK0Z6REJi?=
 =?utf-8?B?M0dHVlZCT1dYV1VBbDZ3K1J1Nk82cTdjUElmdnQ3M3RkMkdzdkNvOGV6bUY4?=
 =?utf-8?B?Y29lbU9SNXhQc0NRK0NOU2l1L3BGOEZseEx6LzhOMHhBOXBjVGNMMmMvR2Fy?=
 =?utf-8?B?SU9rR2pCQVp4aGJKS1UyMXNKV09DME9yeTI3T1hsZmcwWDhDeWdXdEZBNDlp?=
 =?utf-8?B?dkt3NHc1dG8wb05XdG1mdThsdUI3a0I5Qm5WeUo4d3U1dWNXOFNQTlVYVUpH?=
 =?utf-8?B?RENvUHZVTzVuRkg3Z1RjdW9jOUJpVXFLa3NpZTc0LzVtTjhIK1RBWTRXUEtQ?=
 =?utf-8?B?cG5JSENEaTVoT0kwcFh2WFRjaVg4THAyYS95akZlVnB5YndBQ2NVL0hFMjgr?=
 =?utf-8?B?QUxCa21WYUFMeTlKMjI0b3ZRZTVJWkZoL0I3WU1iTjRySlJOZFJ4WEJhb1JK?=
 =?utf-8?B?cDNpazE5M0FFU1pTQjU4VWRyQndpTzd0cmtjbEtsRlVmRWE2STlNVzNLcm16?=
 =?utf-8?B?WWNlTmo0RzArZmxibHJFZHZObE90dnVJZjY1Q1dUOWFjZUNvaTNqWjY3STRk?=
 =?utf-8?B?Sy8rZW9MVzFjQjJKL0V5bERDTnNVcGdNb0JoTjdTTFErTVc3bVo4ajJDandY?=
 =?utf-8?B?MnpkaWZEM0dQRUZveEN4K1MvTXVsYThUZktiY0pOOWFSTnc0ZjZxVCs2Yk9j?=
 =?utf-8?B?OXViOVkyN0dlaENpRTU0a3V1Z3U3UmhxYkIyM2g4NjkrK1d4cXRqZGpVc01V?=
 =?utf-8?B?V3lSZ29nbDN2RGlqeTU0RUorQmFwK05PTzVycFBzbTdET3k5bzZLVytZN0oy?=
 =?utf-8?B?QWdHd3pkV1dZTFgvY1dMUTdRU1JSRGpXc3ByeFVDeTFKMXdhZDFleEYrTWY5?=
 =?utf-8?B?ZWM5WnQ0UnBHUFIvMXRNVE5EbG1KMnVnR2hBQlpNajBoNmVWdnBxRmg5a0Vs?=
 =?utf-8?B?L2lZc1VsL0J5ZnNzTXRjU3dEbGl4UW1HWVh0RUhValFiV0pxbzRNYmlaK3lq?=
 =?utf-8?B?YlNUTnlER2JLT3Z6dzIxNWdCeTdVNXFVZlJUZzc0NGJ3aUdzbG9Ca25ablI3?=
 =?utf-8?B?RENhREtLQkgvMTVMblo5Wi85VFZTTTMraC8xblJIQ2YraTY3WS9lUmJwbGFt?=
 =?utf-8?B?VjdLNW1NOE9UMFBvVUtFYkhBNkRhNDRBdmwzUUsrbjhUbzJpbnI4KzM2UVJ5?=
 =?utf-8?B?RXB5WTJSWTlyRnBHcmNGYk0rbDUwMEYyYjFJbExjNU5FUGU5UExEMnZNR2lZ?=
 =?utf-8?B?RnJDLzYxRElKcFRBYlVUWHUwMjlKdStmb3FXZXJNWjJnZGJKZVVYL1dZQ3NL?=
 =?utf-8?B?eVI4Y2lIWC9jSWkvZmZkblFGL2FjTnQwTi9BUmQyODN4Zy9oKzRkVWZ2UFNn?=
 =?utf-8?B?QzZHZnNYL1cwWlUwbTFVTjRNSDlCTGdrMXovTmFxK1JZZUlTdlNJbExOWTRv?=
 =?utf-8?B?dHpTc0xITzFXZDJ1eGcxNFBITjhGN0p5bnd2RWwyY3prVVRsVStONGxFVHJV?=
 =?utf-8?B?M2xOeW1SM1dxUEpLV253dDVWNzlndDYzWnFqc3IxZ1Ztc0YydThXRkxlU3hN?=
 =?utf-8?B?Y0J2aGYzOGNvemYxMHFRcXN4Q3loaEVjQlpHVmRPdTcwZnpJTjlHZ3hnNjBv?=
 =?utf-8?B?VGlzc3J0NHdGazZySTBnUllyYnVwNXdsU0R1V2hncm54VTd2OTI1UmJ1cklu?=
 =?utf-8?B?WFVOa0ZRMjZOQWIzdE1TRmU3SmlVakRSMTlxWTg3TGM4b1JoWkpXODdGR3JN?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3DD1DD9A284074D9F0C367AADA0F5D4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df48dc9-5c3c-443b-e232-08dbe9771e4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 03:16:42.1765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y9506SGH122ZvP0cFd69vsam8/0VWxx2VorbZltrL52XwPGr9FyeXNkKADuAjAHOdZwfRlJ0huiahSeQARt43Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6082
X-OriginatorOrg: intel.com

PiA+ID4gDQo+ID4gDQo+ID4gVGhhdCdzIHRydWUuIEkgd2FzIHRoaW5raW5nIG5vIG5lZWQgdG8g
aGF2ZSB0aGVtIGRvbmUgaW4gc2VwYXJhdGUgY2FsbHMuICANCj4gPiBUaGUgY2FsbGVyIGhhcyB0
byBjaGVjayB0aGUgcmV0dXJuIHZhbHVlIGZvciBlcGNfY2cgaW5zdGFuY2UgZmlyc3QsIHRoZW4g
IA0KPiA+IGNoZWNrIHJlc3VsdCBvZiB0cnlfY2hhcmdlLiBCdXQgdGhlcmUgaXMgcmVhbGx5IG9u
bHkgb25lIGNhbGxlciwgIA0KPiA+IHNneF9hbGxvY19lcGNfcGFnZSgpIGJlbG93LCBzbyBJIGRv
bid0IGhhdmUgc3Ryb25nIG9waW5pb25zIG5vdy4NCj4gPiANCj4gPiBXaXRoIHRoZW0gc2VwYXJh
dGUsIHRoZSBjaGVja3Mgd2lsbCBsb29rIGxpa2UgdGhpczoNCj4gPiBpZiAoZXBjX2NnID0gc2d4
X2dldF9jdXJyZW50X2VwY19jZygpKSAvLyBOVUxMIG1lYW5zIGNncm91cCBkaXNhYmxlZCwgIA0K
PiA+IHNob3VsZCBjb250aW51ZSBmb3IgYWxsb2NhdGlvbg0KPiA+IHsNCj4gPiAJaWYgKHJldCA9
ICBzZ3hfZXBjX2Nncm91cF90cnlfY2hhcmdlKCkpDQo+ID4gCQlyZXR1cm4gcmV0DQo+ID4gfQ0K
PiA+IC8vIGNvbnRpbnVlLi4uDQo+ID4gDQo+ID4gSSBjYW4gZ28gZWl0aGVyIHdheS4NCg0KTGV0
J3Mga2VlcCB0aGlzIGFsaWduZWQgd2l0aCBvdGhlciBfdHJ5X2NoYXJnZSgpIHZhcmlhbnRzOiBy
ZXR1cm4gJ2ludCcgdG8NCmluZGljYXRlIHdoZXRoZXIgdGhlIGNoYXJnZSBpcyBkb25lIG9yIG5v
dC4NCg0KPiA+IA0KPiA+ID4gDQo+ID4gPiA+ID4gPiAgc3RydWN0IHNneF9lcGNfcGFnZSAqc2d4
X2FsbG9jX2VwY19wYWdlKHZvaWQgKm93bmVyLCBib29sIHJlY2xhaW0pDQo+ID4gPiA+ID4gPiAg
ew0KPiA+ID4gPiA+ID4gIAlzdHJ1Y3Qgc2d4X2VwY19wYWdlICpwYWdlOw0KPiA+ID4gPiA+ID4g
KwlzdHJ1Y3Qgc2d4X2VwY19jZ3JvdXAgKmVwY19jZzsNCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4g
PiA+ICsJZXBjX2NnID0gc2d4X2VwY19jZ3JvdXBfdHJ5X2NoYXJnZSgpOw0KPiA+ID4gPiA+ID4g
KwlpZiAoSVNfRVJSKGVwY19jZykpDQo+ID4gPiA+ID4gPiArCQlyZXR1cm4gRVJSX0NBU1QoZXBj
X2NnKTsNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gIAlmb3IgKCA7IDsgKSB7DQo+ID4gPiA+
ID4gPiAgCQlwYWdlID0gX19zZ3hfYWxsb2NfZXBjX3BhZ2UoKTsNCj4gPiA+ID4gPiA+IEBAIC01
ODAsMTAgKzU4NywyMSBAQCBzdHJ1Y3Qgc2d4X2VwY19wYWdlICpzZ3hfYWxsb2NfZXBjX3BhZ2Uo
dm9pZA0KPiA+ID4gPiA+ID4gKm93bmVyLCBib29sIHJlY2xhaW0pDQo+ID4gPiA+ID4gPiAgCQkJ
YnJlYWs7DQo+ID4gPiA+ID4gPiAgCQl9DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ICsJCS8q
DQo+ID4gPiA+ID4gPiArCQkgKiBOZWVkIHRvIGRvIGEgZ2xvYmFsIHJlY2xhbWF0aW9uIGlmIGNn
cm91cCB3YXMgbm90IGZ1bGwgYnV0ICANCj4gPiA+ID4gZnJlZQ0KPiA+ID4gPiA+ID4gKwkJICog
cGh5c2ljYWwgcGFnZXMgcnVuIG91dCwgY2F1c2luZyBfX3NneF9hbGxvY19lcGNfcGFnZSgpIHRv
ICANCj4gPiA+ID4gZmFpbC4NCj4gPiA+ID4gPiA+ICsJCSAqLw0KPiA+ID4gPiA+ID4gIAkJc2d4
X3JlY2xhaW1fcGFnZXMoKTsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBXaGF0J3MgdGhlIGZpbmFs
IGJlaGF2aW91cj8gIElJVUMgaXQgc2hvdWxkIGJlIHJlY2xhaW1pbmcgZnJvbSB0aGUNCj4gPiA+
ID4gPiAqY3VycmVudCogRVBDDQo+ID4gPiA+ID4gY2dyb3VwPyAgSWYgc28gc2hvdWxkbid0IHdl
IGp1c3QgcGFzcyB0aGUgQGVwY19jZyB0byBpdCBoZXJlPw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+
IEkgdGhpbmsgd2UgY2FuIG1ha2UgdGhpcyBwYXRjaCBhcyAic3RydWN0dXJlIiBwYXRjaCB3L28g
YWN0dWFsbHkgIA0KPiA+ID4gPiBoYXZpbmcNCj4gPiA+ID4gPiBFUEMNCj4gPiA+ID4gPiBjZ3Jv
dXAgZW5hYmxlZCwgaS5lLiwgc2d4X2dldF9jdXJyZW50X2VwY19jZygpIGFsd2F5cyByZXR1cm4g
TlVMTC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBBbmQgd2UgY2FuIGhhdmUgb25lIHBhdGNoIHRv
IGNoYW5nZSBzZ3hfcmVjbGFpbV9wYWdlcygpIHRvIHRha2UgdGhlDQo+ID4gPiA+ID4gJ3N0cnVj
dA0KPiA+ID4gPiA+IHNneF9lcGNfbHJ1X2xpc3QgKicgYXMgYXJndW1lbnQ6DQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gCXZvaWQgc2d4X3JlY2xhaW1fcGFnZXNfbHJ1KHN0cnVjdCBzZ3hfZXBjX2xy
dV9saXN0ICogbHJ1KQ0KPiA+ID4gPiA+IAl7DQo+ID4gPiA+ID4gCQkuLi4NCj4gPiA+ID4gPiAJ
fQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoZW4gaGVyZSB3ZSBjYW4gaGF2ZSBzb21ldGhpbmcg
bGlrZToNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAJdm9pZCBzZ3hfcmVjbGFpbV9wYWdlcyhzdHJ1
Y3Qgc2d4X2VwY19jZyAqZXBjX2NnKQ0KPiA+ID4gPiA+IAl7DQo+ID4gPiA+ID4gCQlzdHJ1Y3Qg
c2d4X2VwY19scnVfbGlzdCAqbHJ1ID0JCQllcGNfY2cgPyAmZXBjX2NnLT5scnUgOg0KPiA+ID4g
PiA+ICZzZ3hfZ2xvYmFsX2xydTsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAJCXNneF9yZWNsYWlt
X3BhZ2VzX2xydShscnUpOw0KPiA+ID4gPiA+IAl9DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gTWFr
ZXMgc2Vuc2U/DQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIGlzIHB1cmVseSBn
bG9iYWwgcmVjbGFtYXRpb24uIE5vIGNncm91cCBpbnZvbHZlZC4NCj4gPiA+IA0KPiA+ID4gQWdh
aW4gd2h5PyAgSGVyZSB5b3UgYXJlIGFsbG9jYXRpbmcgb25lIEVQQyBwYWdlIGZvciBlbmNsYXZl
IGluIGEgIA0KPiA+ID4gcGFydGljdWxhciBFUEMNCj4gPiA+IGNncm91cC4gIFdoZW4gdGhhdCBm
YWlscywgc2hvdWxkbid0IHlvdSB0cnkgb25seSB0byByZWNsYWltIGZyb20gdGhlICANCj4gPiA+
ICpjdXJyZW50Kg0KPiA+ID4gRVBDIGNncm91cD8gIE9yIGF0IGxlYXN0IHlvdSBzaG91bGQgdHJ5
IHRvIHJlY2xhaW0gZnJvbSB0aGUgKmN1cnJlbnQqICANCj4gPiA+IEVQQyBjZ3JvdXANCj4gPiA+
IGZpcnN0Pw0KPiA+ID4gDQo+ID4gDQo+ID4gTGF0ZXIgc2d4X2VwY19jZ190cnlfY2hhcmdlIHdp
bGwgdGFrZSBhICdyZWNsYWltJyBmbGFnLCBpZiB0cnVlLCBjZ3JvdXAgIA0KPiA+IHJlY2xhaW1z
IHN5bmNocm9ub3VzbHksIG90aGVyd2lzZSBpbiBiYWNrZ3JvdW5kIGFuZCByZXR1cm5zIC1FQlVT
WSBpbiAgDQo+ID4gdGhhdCBjYXNlLiBUaGlzIGZ1bmN0aW9uIGFsc28gcmV0dXJucyBpZiBubyB2
YWxpZCBlcGNfY2cgcG9pbnRlciAgDQo+ID4gcmV0dXJuZWQuDQo+ID4gDQo+ID4gQWxsIHJlY2xh
bWF0aW9uIGZvciAqY3VycmVudCogY2dyb3VwIGlzIGRvbmUgaW4gc2d4X2VwY19jZ190cnlfY2hh
cmdlKCkuDQoNClRoaXMgaXMgZmluZSwgYnV0IEkgYmVsaWV2ZSBteSBxdWVzdGlvbiBhYm92ZSBp
cyBhYm91dCB3aGVyZSB0byByZWNsYWltIHdoZW4NCiJhbGxvY2F0aW9uIiBmYWlscywgIGJ1dCBu
b3QgInRyeSBjaGFyZ2UiIGZhaWxzLg0KDQpBbmQgZm9yICJyZWNsYWltIGZvciBjdXJyZW50IGNn
cm91cCB3aGVuIGNoYXJnZSBmYWlscyIsIEkgZG9uJ3QgdGhpbmsgaXRzIGV2ZW4NCm5lY2Vzc2Fy
eSBpbiB0aGlzIGluaXRpYWwgaW1wbGVtZW50YXRpb24gb2YgRVBDIGNncm91cC4gIFlvdSBjYW4g
anVzdCBmYWlsIHRoZQ0KYWxsb2NhdGlvbiB3aGVuIGNoYXJnZSBmYWlscyAocmVhY2hpbmcgdGhl
IGxpbWl0KS4gIFRyeWluZyB0byByZWNsYWltIHdoZW4gbGltaXQNCmlzIGhpdCBjYW4gYmUgZG9u
ZSBsYXRlci4NCg0KUGxlYXNlIHNlZSBEYXZlIGFuZCBNaWNoYWwncyByZXBsaWVzIGhlcmU6DQoN
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvN2ExYTUxMjUtOWRhMi00N2I2LWJhMGYtY2Yy
NGQ4NGRmMTZiQGludGVsLmNvbS8jdA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC95ejQ0
d3Vrb2ljM3N5eTZzNGZjcm5nYWd1cmtqaGUyaHprYTZrdnhiYWpkdHJvM2Z3dUB6ZDJpbGh0N3dj
dzMvDQoNCj4gPiANCj4gPiBTbywgYnkgcmVhY2hpbmcgdG8gdGhpcyBwb2ludCwgIGEgdmFsaWQg
ZXBjX2NnIHBvaW50ZXIgd2FzIHJldHVybmVkLCAgDQo+ID4gdGhhdCBtZWFucyBhbGxvY2F0aW9u
IGlzIGFsbG93ZWQgZm9yIHRoZSBjZ3JvdXAgKGl0IGhhcyByZWNsYWltZWQgaWYgIA0KPiA+IG5l
Y2Vzc2FyeSwgYW5kIGl0cyB1c2FnZSBpcyBub3QgYWJvdmUgbGltaXQgYWZ0ZXIgY2hhcmdpbmcp
Lg0KDQpJIGZvdW5kIG1lbW9yeSBjZ3JvdXAgdXNlcyBkaWZmZXJlbnQgbG9naWMgLS0gYWxsb2Nh
dGlvbiBmaXJzdCBhbmQgdGhlbiBjaGFyZ2U6DQoNCkZvciBpbnN0YW5jZToNCg0Kc3RhdGljIHZt
X2ZhdWx0X3QgZG9fYW5vbnltb3VzX3BhZ2Uoc3RydWN0IHZtX2ZhdWx0ICp2bWYpDQp7DQoJLi4u
Li4uDQoNCiAgICAgICAgZm9saW8gPSB2bWFfYWxsb2NfemVyb2VkX21vdmFibGVfZm9saW8odm1h
LCB2bWYtPmFkZHJlc3MpOyAgICAgICAgICAgICANCiAgICAgICAgaWYgKCFmb2xpbykgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAg
ICAgICAgICAgICAgICBnb3RvIG9vbTsNCiAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAg
ICBpZiAobWVtX2Nncm91cF9jaGFyZ2UoZm9saW8sIHZtYS0+dm1fbW0sIEdGUF9LRVJORUwpKSAg
ICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgIGdvdG8gb29tX2ZyZWVfcGFnZTsNCgkN
CgkuLi4uLi4gICAgwqANCn0NCg0KV2h5IEVQQyBuZWVkcyB0byAiY2hhcmdlIGZpcnN0IiBhbmQg
InRoZW4gYWxsb2NhdGUiPw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCj4gPiANCj4g
PiBCdXQgdGhlIHN5c3RlbSBsZXZlbCBmcmVlIGNvdW50IG1heSBiZSBsb3cgKGUuZy4sIGxpbWl0
cyBvZiBhbGwgY2dyb3VwcyAgDQo+ID4gbWF5IGFkZCB1cCB0byBiZSBtb3JlIHRoYW4gY2FwYWNp
dHkpLiBzbyB3ZSBuZWVkIHRvIGRvIGEgZ2xvYmFsICANCj4gPiByZWNsYW1hdGlvbiBoZXJlLCB3
aGljaCBtYXkgaW52b2x2ZSByZWNsYWltaW5nIGEgZmV3IHBhZ2VzIChmcm9tIGN1cnJlbnQgIA0K
PiA+IG9yIG90aGVyIGdyb3Vwcykgc28gdGhlIHN5c3RlbSBjYW4gYmUgYXQgYSBwZXJmb3JtYW50
IHN0YXRlIHdpdGggbWluaW1hbCAgDQo+ID4gZnJlZSBjb3VudC4gKGN1cnJlbnQgYmVoYXZpb3Ig
b2Yga3NneGQpLg0KPiA+IA0KPiBJIHNob3VsZCBoYXZlIHN0aWNrZWQgdG8gdGhlIG9yaWduaWFs
IGNvbW1lbnQgYWRkZWQgaW4gY29kZS4gQWN0dWFsbHkgIA0KPiBfX3NneF9hbGxvY19lcGNfcGFn
ZSgpIGNhbiBmYWlsIGlmIHN5c3RlbSBydW5zIG91dCBvZiBFUEMuIFRoYXQncyB0aGUgIA0KPiBy
ZWFsbHkgcmVhc29uIGZvciBnbG9iYWwgcmVjbGFpbS7CoA0KPiANCg0KSSBkb24ndCBzZWUgaG93
IHRoaXMgY2FuIHdvcmsuICBXaXRoIEVQQyBjZ3JvdXAgbGlrZWx5IGFsbCBFUEMgcGFnZXMgd2ls
bCBnbyB0bw0KdGhlIGluZGl2aWR1YWwgTFJVIG9mIGVhY2ggY2dyb3VwLCBhbmQgdGhlIHNneF9n
bG9iYWxfbHJ1IHdpbGwgYmFzaWNhbGx5IGVtcHR5Lg0KSG93IGNhbiB5b3UgcmVjbGFpbSBmcm9t
IHRoZSBzZ3hfZ2xvYmFsX2xydT8NCg0KSSBhbSBwcm9iYWJseSBtaXNzaW5nIHNvbWV0aGluZywg
YnV0IGFueXdheSwgbG9va3Mgc29tZSBoaWdoIGxldmVsIGRlc2lnbg0KbWF0ZXJpYWwgaXMgcmVh
bGx5IG1pc3NpbmcgaW4gdGhlIGNoYW5nZWxvZy4NCg0K

