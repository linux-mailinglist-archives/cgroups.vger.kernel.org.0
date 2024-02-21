Return-Path: <cgroups+bounces-1732-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D05085D686
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 12:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06A4CB2401C
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 11:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155733F8E0;
	Wed, 21 Feb 2024 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ys4UfY2g"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BD83EA94;
	Wed, 21 Feb 2024 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513843; cv=fail; b=HdgBPnLyBNvIYJxqG+v7wEt8LJaRIEXA0XEnRMNWimvDUJeGQpu+roKOiJwejOQYq5oXdi5wSlW9G8RrRUfl17R45laFTXv1ypXKHRypdMyEm5Y4BYHKQgiEIRacEKxD7rr1APZnVvNrkMQ5S9ki4SMH6sjRxsHw4xHf31dadVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513843; c=relaxed/simple;
	bh=qYYDmE5GR6nCpJ3iW23uuo1CjLddUICNIE8gMPXTis4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XOFBnJsY6eQRsZ8jkmdri9U34OwLmAloxTaDsRhjXcNhgGPvLY9kCeXfvTuH06Vq6jqAXaUAnHHpu82psomckvIDhW+QRMUHVKnnCjoezzH/SXisVacInP/N9VuIhDvJPr4pv71lYn330XiGkcbOGHyL5aNHkvBHLLwdHqQpO6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ys4UfY2g; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708513843; x=1740049843;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qYYDmE5GR6nCpJ3iW23uuo1CjLddUICNIE8gMPXTis4=;
  b=Ys4UfY2gBeR7zGSdIwLBZB1CfCHjJ4ZQonp6PxAkzTiH32YOWPWnrQry
   N9Wil8skaVSNIEp0zCpcciKJG5Hmd2OKhH0uywo1iQCN13rUpHu4q5ee9
   BHIFkPpgHp5sAV8o+pgbzF67NlXR3dn6PtUWvt2Rm/rCFL0Z5BWc/8EAw
   qhtUE5lexp/mEe579wi/ht/sD4ukCECnRjhkllCq26lIxlHsyh7roJCuR
   SxW8U+a85uZYoZZM5uGcbIkACvEUsAvW+3V+WfjXYz4Ijwf+9MbAcnVP1
   UzXxGxmY5Tllfsv09TMTf7tAihf/9Ab/+S9kY7IPXYzOZz/2R3Dl/ROhN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="6481804"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="6481804"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 03:10:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="9748659"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 03:10:40 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 03:10:40 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 03:10:39 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 03:10:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nhlg4k2palOXT/s0dxO65+SBCPnRAqs16/sk9ujQma+UasOdqkEd93wTtgk1qY2FvtTf/skksZurA23A8k7ZnWLTcEIrFealbTFyf8eRCtrzDasP+eBpn2OqO4f/Zp8ikoc+rvBAwlmn9DaLnWpG/cyFsGblH3vftdNxxBVMhT481cC+Q3I2bssq5fUv0DmP8uj/c4xddsiZbjFEJKNCn8Fl500qh+/fhInIfxrjSDiOurFn4CFrbtZayIa1CShyyKvlxLfgSliP/+h5USO6/Yib0oFLmIZUZzFBn4E0BT2FZWM/L0dAHZrTDmk1SM3pDhNRL2Qma6pl8hhsYYAWvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYYDmE5GR6nCpJ3iW23uuo1CjLddUICNIE8gMPXTis4=;
 b=cflKn0cOyPqwxngrwAo754tI5CyRJaSdJkLEdT8vDIWwU/02DbUoBtCSAYTkYLkSaLwFrhZ7HlBsAiX0WXBs8VXoMteSPoxO90fD6XZ5TViGnKYtFV6FKJK17h/GDMQKFnANOljnS9aIQ/OzikOl06ov1hNcnw66ip9Yl1FOZD9JuRdjW6frPxjaYfTRyarpNyAWm3P12GH6hk2/fwToG2ID6wZ2RUo8iIYeSflyYxz9APtqz9k9k/SzGCp60yE07OHpK7epdBpM/7Z/GIOmSYRM5/SB+vYYe+ZiTs3ohB2PemBoT/mTv7SEhJNsQF3dNya4IPUiGrbyPfdePBw34w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB7764.namprd11.prod.outlook.com (2603:10b6:610:145::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 11:10:37 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab%6]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 11:10:37 +0000
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
Subject: Re: [PATCH v9 12/15] x86/sgx: Expose sgx_epc_cgroup_reclaim_pages()
 for global reclaimer
Thread-Topic: [PATCH v9 12/15] x86/sgx: Expose sgx_epc_cgroup_reclaim_pages()
 for global reclaimer
Thread-Index: AQHaWH70a3rik42QmkCtB6571k9lNrEUvC6A
Date: Wed, 21 Feb 2024 11:10:36 +0000
Message-ID: <7a70ad00ce4d79977753d1c4ed748a395cc5057e.camel@intel.com>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
	 <20240205210638.157741-13-haitao.huang@linux.intel.com>
In-Reply-To: <20240205210638.157741-13-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH3PR11MB7764:EE_
x-ms-office365-filtering-correlation-id: e9173361-bb0b-4331-8dea-08dc32cdbb37
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HrChMXYDXiSY7IfcqpEDGjYriLBE0WekEgr4uUP50hm2dkGmsbnD+O1VZKo+JhWFDz4XpPfvx7noREuEVlx1VpNX+bXzL1sAHVfe5qsttTcsxsCNKnCQ8FJlF9cSjyxTIa3nLO0vJx+52/khlhRbi2O5OLI8f7ScDym3wsxhNxldtHAY4mw3bvDAigmIrxRq5UsOu331P1wEYctvq1aQG6XED++DuVAdP3OlmeGn4a2UnET2Cx248DnBQlb2Ew1V8FANge/x629uN1pswXIl3I2hMhYxokBP/xYJasmI/rFo7yqxYwqNf1CMYSSejJVDxJlul9h6YksMY+MMJfedUfidVUl5zWcuZ/FNVjpSeStFw3DryT8k/jsapTOWIvV43G3bv1DErT5oOm+h+rEC8+oghZPNNR620XWmtqTArLKax+OqSBNoSET7iMvuUhd7sJ7VStxa7h9qR8GacYolB3p4wJDuT8dXJUN6NVCDZYsMzEgeI+0JoYUP2TvQSJh/DA+85njdCrZEd90dA/7Y3FmO1CJzF4yuFxrFlP23dxSBtoZx3MH7DCqF6Idt0+/EhLq3N3/KH5A4BkE7eNTXIHfYJTinRrUwNC2salikcv/YwF8QEtafmQd8/pOIEpwbszW0uTTdH+ILjjBUNZg3yA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFAvMTcvbGI5bjFIejZJQmNtcGpwVFMxczZKTU03TXF3WmNqNHBFRkk5T05Z?=
 =?utf-8?B?OTYrbkRYbmVPdDVJNlZoWXM3cVFpeDQrRFBqMVlqRk1iV2hENWczcC9kcHJ0?=
 =?utf-8?B?d2t4S3FQa05YSE1iaEl1S3YrRUVtM3NLd2hPWWRoQmlVMWFuMkNBUS9vUzJK?=
 =?utf-8?B?R2ptQWVwKzBNd3VTc09xOGx5Y3FGMUV6SjZWY2dKaWM0L2pjRFMydjh1bGR6?=
 =?utf-8?B?Rm5sMXVTMVJwQUVtUDZQYzExMngrcGV6SlB3Zm1lU1AvNXNOdzc1VUYwQ2R6?=
 =?utf-8?B?ejBScDUvQ0FkWHFhN1ZHZFZlcHVoMkc5K2svWVhzZTlNTWlGeFpQbi9ia2h0?=
 =?utf-8?B?d0V0YlJpVHFQd3daUUxmeG1wVHRJcmtob0pDeGhlL3Y2N2ppeEl4VHFyUWQr?=
 =?utf-8?B?QWl4d1AzVE44RHBPb0FocGlxdTZocTdOVXVqc3Nrc2dFbkp3UjBBZWp0MHBB?=
 =?utf-8?B?UXdGd2ZOeUJJZnBLZ0ZJWE9pVTF6eXJzdHFoRUJ1OERTZlpLTk1CTXRWcVRz?=
 =?utf-8?B?cDhaMlFYRnkzV29WZmR1dTRjZW1oSEJBakpETGxyd3lVNG50amxTaXlLczZV?=
 =?utf-8?B?NUZ2SmZMMjhzUEJKdWYwcURoaEVTUFhhb0pscThralZoOG52bDBYTnQrVlZv?=
 =?utf-8?B?TmVxaGJVQnlaU0RwN1FCTGNROGlvUUYxbDkzbGpRYUZuOEhkcEVJb0ZkTHgv?=
 =?utf-8?B?aStreFpHb21MOUZVWDZ1VCszNWpscERIZ2VVR1dqbFZHOCtlUmc3akpuc1h3?=
 =?utf-8?B?TVVOTm5DNzVLc0hTUXBtczdpRDRXckYvMU9YdUhJU1NVUmJZZnNZakw4MGlT?=
 =?utf-8?B?VG9yd1ViLzNZSEQ0cGJjNFhRbC9seTJHbWRTeXRDR0thYnllSEtZUEZwR2to?=
 =?utf-8?B?blM5LzVNS2ZORW9NbFBNOWh2WGttMm1aRTArYjJGRGVSSzlRWVkvOVZ3dFlu?=
 =?utf-8?B?TlhNYXdoamtPdzlCakVEd0lwMHZPY3hkRFhHYVA1NlNtbkhzcEtCbHFnenFy?=
 =?utf-8?B?emxUZFNGTkVham1VN2ZOQi9FWmFwN1NJbDNCazMxenZjMXBjTkdaaVBwbjhF?=
 =?utf-8?B?VGQ2U2RkU0o4MHpyWTZaSHZDSUlCMDN5Q2xublQ3d05CcTNiaVUxSytLUFR0?=
 =?utf-8?B?WU1tbXdlV3lPVVFEenNrTlNDUVhWY1pDN3VrS3F2alh6cEtheGVkU2E3Ull5?=
 =?utf-8?B?T1p6NkhKVXVVODFwanpjTFkyY0o1UDJBSm5ZOVVxZzBSSVJsRlhwZWhHQWJ1?=
 =?utf-8?B?VU5NNVd4eUl3SlV5bVZtcEZkZG5WcFJJT0RxeTVkQUVYczdweHF0eEptWVlw?=
 =?utf-8?B?bkdjdTNvRlpSMEFQTWh3V1VyV2d5ZVNrNFM1dWM0ZmZreUw1algrYmQ3OU5t?=
 =?utf-8?B?dy9tMW9pYzErNkZBa0VwaVpkazRpdUZBem9ScmZKaHlNZkVGOHA3TUt5eVRZ?=
 =?utf-8?B?OFdIdkxxLzh2UnBGS2RqaHAwamVzaTJSOXJyT3FtOWhYVnJCazFjUElyZnFh?=
 =?utf-8?B?b1VpU1dGVEpHYUJHUS9NZmFqajNXNmUxM2tuSXlZM084NG54Q2dBMG9RQkwv?=
 =?utf-8?B?ZmxDaDMyNFhONEwwSkNUTzhhaHNKSXVZWUNtTkx2ZWt1N1FmUTFodC9qd05n?=
 =?utf-8?B?OTdtR3lBTVNVM0NsNm1nOEFzdUJEZkREMjljenM5bWtjaWpoZkRWNEI4WXA5?=
 =?utf-8?B?NGxYQ0M0YU5uMStxMnFpU1pmWXRZeGZOc0JaTEhMYWg3MHRmVE5Qd1BEZmdP?=
 =?utf-8?B?bWlWcDFmV2FZVTVZRG5oQ1pvNStnR09mdXh2ZnFKR2lnNFJYT0prVTVFS0Fo?=
 =?utf-8?B?RFU5bDNiSXFnZkFGbkJBMVB6SmRtbXhCVnBwS1RldTUvejR4SHhiT0Vha0tY?=
 =?utf-8?B?WHdFWEorSWhjZ0ZvbFFHSkd3OWZpZ0xJUDV1UmlmWVB3TlN4OVVpM0x0cDIw?=
 =?utf-8?B?T3ltOVhTcHMyWXh4UG1LSUpKMHZ0TmNBNDJodzFIOEgwQXArNHpvZnVYaU5R?=
 =?utf-8?B?SDYvemREd0F4czA0eXBEK1BpWUpTbTJSSk1tcWx5UWlkbkZVbHFKR2ZSUFRX?=
 =?utf-8?B?U1ZCWWE5SWdyNFJxUTZNN1ExMzBVb0x4VHloY0h0Wk5hc0Yrdmt4TGQ5bmFV?=
 =?utf-8?B?SU15V3dGZVdzalkzRXFmR0FLdEFEQ1poaWdHbHB5cWxJRTJqayttV0FxSXZO?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA93D67AC3942F459F52AB95EE8CEF90@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9173361-bb0b-4331-8dea-08dc32cdbb37
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 11:10:37.0113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SDRX/ILDyWa41RaFj/YTElsPVioxjYu5ZlyV06xMtch4dKPeo3+h5x3kUlV1McFsw12cXRKnSKoG+R87yhf3AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7764
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTAyLTA1IGF0IDEzOjA2IC0wODAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEZyb206IEtyaXN0ZW4gQ2FybHNvbiBBY2NhcmRpIDxrcmlzdGVuQGxpbnV4LmludGVsLmNvbT4N
Cj4gDQo+IFdoZW4gY2dyb3VwIGlzIGVuYWJsZWQsIGFsbCByZWNsYWltYWJsZSBwYWdlcyB3aWxs
IGJlIHRyYWNrZWQgaW4gY2dyb3VwDQo+IExSVXMuIFRoZSBnbG9iYWwgcmVjbGFpbWVyIG5lZWRz
IHRvIHN0YXJ0IHJlY2xhbWF0aW9uIGZyb20gdGhlIHJvb3QNCj4gY2dyb3VwLiBFeHBvc2UgdGhl
IHRvcCBsZXZlbCBjZ3JvdXAgcmVjbGFtYXRpb24gZnVuY3Rpb24gc28gdGhlIGdsb2JhbA0KPiBy
ZWNsYWltZXIgY2FuIHJldXNlIGl0Lg0KPiANCj4gQ28tZGV2ZWxvcGVkLWJ5OiBTZWFuIENocmlz
dG9waGVyc29uIDxzZWFuLmouY2hyaXN0b3BoZXJzb25AaW50ZWwuY29tPg0KPiBTaWduZWQtb2Zm
LWJ5OiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuLmouY2hyaXN0b3BoZXJzb25AaW50ZWwuY29t
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBLcmlzdGVuIENhcmxzb24gQWNjYXJkaSA8a3Jpc3RlbkBsaW51
eC5pbnRlbC5jb20+DQo+IENvLWRldmVsb3BlZC1ieTogSGFpdGFvIEh1YW5nIDxoYWl0YW8uaHVh
bmdAbGludXguaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBIYWl0YW8gSHVhbmcgPGhhaXRh
by5odWFuZ0BsaW51eC5pbnRlbC5jb20+DQo+IC0tLQ0KPiBWODoNCj4gLSBSZW1vdmUgdW5uZWVk
ZWQgYnJlYWtzIGluIGZ1bmN0aW9uIGRlY2xhcmF0aW9ucy4gKEphcmtrbykNCj4gDQo+IFY3Og0K
PiAtIFNwbGl0IHRoaXMgb3V0IGZyb20gdGhlIGJpZyBwYXRjaCwgIzEwIGluIFY2LiAoRGF2ZSwg
S2FpKQ0KPiAtLS0NCj4gIGFyY2gveDg2L2tlcm5lbC9jcHUvc2d4L2VwY19jZ3JvdXAuYyB8IDIg
Ky0NCj4gIGFyY2gveDg2L2tlcm5lbC9jcHUvc2d4L2VwY19jZ3JvdXAuaCB8IDcgKysrKysrKw0K
PiAgMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9lcGNfY2dyb3VwLmMgYi9hcmNo
L3g4Ni9rZXJuZWwvY3B1L3NneC9lcGNfY2dyb3VwLmMNCj4gaW5kZXggYWJmNzRmZGIxMmI0Li42
ZTMxZjg3MjdiOGEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L2VwY19j
Z3JvdXAuYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9lcGNfY2dyb3VwLmMNCj4g
QEAgLTk2LDcgKzk2LDcgQEAgYm9vbCBzZ3hfZXBjX2Nncm91cF9scnVfZW1wdHkoc3RydWN0IG1p
c2NfY2cgKnJvb3QpDQo+ICAgKiBAaW5kaXJlY3Q6ICAgSW4ga3NneGQgb3IgRVBDIGNncm91cCB3
b3JrIHF1ZXVlIGNvbnRleHQuDQo+ICAgKiBSZXR1cm46CU51bWJlciBvZiBwYWdlcyByZWNsYWlt
ZWQuDQo+ICAgKi8NCj4gLXN0YXRpYyB1bnNpZ25lZCBpbnQgc2d4X2VwY19jZ3JvdXBfcmVjbGFp
bV9wYWdlcyhzdHJ1Y3QgbWlzY19jZyAqcm9vdCwgYm9vbCBpbmRpcmVjdCkNCj4gK3Vuc2lnbmVk
IGludCBzZ3hfZXBjX2Nncm91cF9yZWNsYWltX3BhZ2VzKHN0cnVjdCBtaXNjX2NnICpyb290LCBi
b29sIGluZGlyZWN0KQ0KPiAgew0KPiAgCS8qDQo+ICAJICogQXR0ZW1wdGluZyB0byByZWNsYWlt
IG9ubHkgYSBmZXcgcGFnZXMgd2lsbCBvZnRlbiBmYWlsIGFuZCBpcw0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYva2VybmVsL2NwdS9zZ3gvZXBjX2Nncm91cC5oIGIvYXJjaC94ODYva2VybmVsL2Nw
dS9zZ3gvZXBjX2Nncm91cC5oDQo+IGluZGV4IGQwNjFjZDgwN2I0NS4uNWIzZThlMWI4NjMwIDEw
MDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9lcGNfY2dyb3VwLmgNCj4gKysr
IGIvYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvZXBjX2Nncm91cC5oDQo+IEBAIC0zMSw2ICszMSwx
MSBAQCBzdGF0aWMgaW5saW5lIGludCBzZ3hfZXBjX2Nncm91cF90cnlfY2hhcmdlKHN0cnVjdCBz
Z3hfZXBjX2Nncm91cCAqZXBjX2NnLCBib29sDQo+ICBzdGF0aWMgaW5saW5lIHZvaWQgc2d4X2Vw
Y19jZ3JvdXBfdW5jaGFyZ2Uoc3RydWN0IHNneF9lcGNfY2dyb3VwICplcGNfY2cpIHsgfQ0KPiAg
DQo+ICBzdGF0aWMgaW5saW5lIHZvaWQgc2d4X2VwY19jZ3JvdXBfaW5pdCh2b2lkKSB7IH0NCj4g
Kw0KPiArc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgc2d4X2VwY19jZ3JvdXBfcmVjbGFpbV9w
YWdlcyhzdHJ1Y3QgbWlzY19jZyAqcm9vdCwgYm9vbCBpbmRpcmVjdCkNCj4gK3sNCj4gKwlyZXR1
cm4gMDsNCj4gK30NCj4gICNlbHNlDQo+ICBzdHJ1Y3Qgc2d4X2VwY19jZ3JvdXAgew0KPiAgCXN0
cnVjdCBtaXNjX2NnICpjZzsNCj4gQEAgLTY5LDYgKzc0LDggQEAgc3RhdGljIGlubGluZSB2b2lk
IHNneF9wdXRfZXBjX2NnKHN0cnVjdCBzZ3hfZXBjX2Nncm91cCAqZXBjX2NnKQ0KPiAgaW50IHNn
eF9lcGNfY2dyb3VwX3RyeV9jaGFyZ2Uoc3RydWN0IHNneF9lcGNfY2dyb3VwICplcGNfY2csIGJv
b2wgcmVjbGFpbSk7DQo+ICB2b2lkIHNneF9lcGNfY2dyb3VwX3VuY2hhcmdlKHN0cnVjdCBzZ3hf
ZXBjX2Nncm91cCAqZXBjX2NnKTsNCj4gIGJvb2wgc2d4X2VwY19jZ3JvdXBfbHJ1X2VtcHR5KHN0
cnVjdCBtaXNjX2NnICpyb290KTsNCj4gK3Vuc2lnbmVkIGludCBzZ3hfZXBjX2Nncm91cF9yZWNs
YWltX3BhZ2VzKHN0cnVjdCBtaXNjX2NnICpyb290LCBib29sIGluZGlyZWN0KTsNCj4gKw0KPiAg
dm9pZCBzZ3hfZXBjX2Nncm91cF9pbml0KHZvaWQpOw0KPiAgDQo+ICAjZW5kaWYNCg0KSSdkIGp1
c3QgcHJlZmVyIHRvIG1lcmdlIHBhdGNoIHN1Y2ggbGlrZSB0aGlzIHRvIHRoZSBvbmUgdGhhdCBh
Y3R1YWxseSB1c2VzIHRoZQ0KZXhwb3NlZCBmdW5jdGlvbi4gIEl0J3MganVzdCBjb3VwbGUgb2Yg
TE9DIGFuZCB3ZSBkb24ndCBkZXNlcnZlIHRvIHJlYWQgdGhlc2UNCnJlcGVhdGVkIGNoYW5nZWxv
ZyBhbmQgbW92ZSBiYWNrIGFuZCBmb3J0aCBiZXR3ZWVuIHBhdGNoZXMgZHVyaW5nIHJldmlldy4N
Cg0KDQo=

