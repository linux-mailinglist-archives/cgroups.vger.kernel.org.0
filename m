Return-Path: <cgroups+bounces-1692-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABB485A3BE
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 13:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD3C1C20DA8
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 12:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395452E834;
	Mon, 19 Feb 2024 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c9qpjYlO"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1A82E83F;
	Mon, 19 Feb 2024 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346848; cv=fail; b=ID3XX23JYSeTJj2x841pnrnSWK64UOL9CV15SCuWTnjR2VUxQYWxRviBTA4R2VxqzozcM5Vn7d2oS37+7fyZI3eL74Q7xZr4ZKTosVy/UbEUa05PZi4w0G7BOhzfTMjAx6faAslwOSy/jKTWLjSIgcuAn2JFNHU9c/Pjg5xPVwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346848; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QkBiNv3e/cHuqLk2xXFtv1Gep4YSFdDpYZGpf3p7AlqVb8zfmcB5JHwaslzDZMQ3vZALFrhOFlsQHJU4rFzpieTI8R3qEfb5g5GV9weem6CX7BA4irNr4H1qrdn7xdNvv7NUwr7P8uEbWMFZVUKVdi+5c2lrrQYbJy7IkXic5mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c9qpjYlO; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708346843; x=1739882843;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
  b=c9qpjYlOxLWGN23w/SMJZ/kt8fYV3kYLZC58KgkcUmWgvmoim7BECSyS
   IejWVuEoNcrdHpIbYCvmNd3itEU02Pm6wT3xYh5mFY82HrLpo/HfIxHRM
   xFkaKxpHrQrWb/+g+4AoipQnOeEITqA4HtuL35JGuLnC/pTJmAGDGG3n0
   la2Eq1ZvVTU1yMRSL5huVWE2p5j+qOR2RpouJIVwiM8jndM0R22nWtJVU
   Nb/EDSjriikpZjUe0mgVFAIMENGWPzSFj54yP+XpsPvpf+d7h87sd6ltW
   UFSNsgWc755cAlA74myvy90PT1foNPnuPUMzer34dtTb82VgJDt5prEgT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="12972605"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="12972605"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:47:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="9139179"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2024 04:47:22 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 04:47:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 19 Feb 2024 04:47:20 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 19 Feb 2024 04:47:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GT9EqBiiO18me5C5ry710JRW/gKheWuuQ/p3jFBqCpVFMw0SvwcIptai+dFnquul2S6NI997k6ZzsYnGiCRI1dADpz/1cTi5iL6JD0wY6eMoHqBMmcU2Qsw4525Drm2I1vW+WcBbRJWaXIojx3Qp2b2q+k4Cj5SgGrmq2sVnCKYhpu0XZNFZcqchcBiabot7APGhuTXMTxHDyaJk2ubxrr2Lwu9a7o4UMBwTl1cJUL1Jvpn02w+UqSQkuVzkxiARF36cj3A3e0LL0UjIggIphJ1XsHdNQ+h9fDXtdouChUp51tvGHDcOfKj1z4GGlAGW6LrvlV/nSo/jA4d0RpfF3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=R5gBNzDzeM+zfR6S2Ht8hm+DXcxrjzxdqD+HdG7vYmgBdWCktSb/1yRtlS4jidguofnLS8gIhYry8wSmXQg03UiGbfq8Oynzxz0Wn+lPSR3PX5kKdYQ0edIkDB3g5YlfzboqmbLC+QldJZPapAUOjtYWx7yuphksiU2jkSQ11pRo7z2wohhLdMjtCdfA71+Fajk1dpU8pbLfeSOgqL/8vNYjayFT9N6Hi5V5p2kS/UzAJvg0U7BIiju/BCnc8j6gUCpYSnnEaa1Ua4M+56YEkpMhwPAfrmEUyZ0gAbdHvMF5smek8yimWxEb/7oqvg4AmZr/oplbHWuG0cSFIcwfiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CYXPR11MB8753.namprd11.prod.outlook.com (2603:10b6:930:d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 12:47:18 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab%6]) with mapi id 15.20.7292.033; Mon, 19 Feb 2024
 12:47:17 +0000
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
Subject: Re: [PATCH v9 04/15] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Topic: [PATCH v9 04/15] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Index: AQHaWH7JS7HLEvEawkSsgoMSbBSyMbERsmaA
Date: Mon, 19 Feb 2024 12:47:17 +0000
Message-ID: <c3fd19a9bf79fc873d2f1e8685382b15b40cfc95.camel@intel.com>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
	 <20240205210638.157741-5-haitao.huang@linux.intel.com>
In-Reply-To: <20240205210638.157741-5-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CYXPR11MB8753:EE_
x-ms-office365-filtering-correlation-id: 3b76ca5a-404e-49ee-a92b-08dc3148e7f9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PVoRKi5UfQz/BfHMqL9PmDjVJojH4N+sO/6HZ783+oP16yHyRnm6E67yamSW40WbOshTeHYZpVnMgD9Yx5Y60VDc5lb693PbmBH75AQYe9fRPvU900l/ZQWT6jtw7Aky78N3Go9H3Vi4Y+AOuJIWVbvc+CLTWk82GYvIuHDmIv6pqWCTltEQHA/bUZ68ELhP033gkJK6XPX1Bq42QMZKePA7AnzBuGVlmpJ86gnUGbFL++Peddo/YBXIJLAJCXxTPSFrTtK/kJ9QzfRE91KP3y6VUO7jmNgeULxkbljevNtNU5qEQrgcuh+EpOxcWJHeJhuRsEKGsEhG+J84ioIvEUgjVl/X907VEors1mpyHK5ZABoSapjviAXB2dfh2X5b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dVW2OkXk133ttSxDRPVSxX9W7JtKWJVz9rv4pola/y0++kUX+JawD6NF9Y?=
 =?iso-8859-1?Q?5rx8ABUVLmn2A9wOUIuAVZQkaIxi+bn4DhsTDidVy8L5M4cSH9mLYHZvYO?=
 =?iso-8859-1?Q?loVEqkRqK22Jvjd4RMeQeGtc7HbNw47jyfW5dDsLZEAaOgs5l5ydjYxA0O?=
 =?iso-8859-1?Q?U/LEhAYUvO+spCmK8/tbmM3Ii61kL5aok39dYP9TaYLhyPK1J5BqtfwMrA?=
 =?iso-8859-1?Q?6FfeA9DLIzNBfga/7lst9vctzSMubtM/HJ3aE1YKxhnSdfQBtfxpNF+aMu?=
 =?iso-8859-1?Q?oVS543qncGneHsBQANYzIZyJXEKGk45vboEZMtLrlScPvPLct2/uv42NMu?=
 =?iso-8859-1?Q?Eng1A/kbEdVXEcFFImOcDEgnOAth9rfGW46uD8k+GOfxchMGkoPUcRdbtl?=
 =?iso-8859-1?Q?SAAHDXr/lSb4jtp4rCQkq1KCjLRg3MVr4Ts1PlA4yDju7kTXnO9nTryyxZ?=
 =?iso-8859-1?Q?ayV04fgVOc/0N9aYlugdf8X/JOfAqmTLazHpD/axpDpwCWmZAK6EBwjxiR?=
 =?iso-8859-1?Q?K9rqtHa5kxvKZlRyWYDo6o793hfCdu1My0BbR8LpMOiiEsYKmU/9/PAM2+?=
 =?iso-8859-1?Q?x+wN0Ek1gHcoW7XsFFVAPWPPDY0Z6l6UnMDHenVgL7WhplPPk3i5SsIFqy?=
 =?iso-8859-1?Q?WzU5LZe/qIk1ZXcblB7YuV5Ieij3hnUJIwqcIMLWax6guN34UK1tK2hc5s?=
 =?iso-8859-1?Q?lTcaf1pcb7ywBWwmYaeFgWL6DyX1sYNED9F8p575aJ53f/PUWKhoMQ3SLl?=
 =?iso-8859-1?Q?/rKob4bUcOAwm8nDzJH6ELql2h66BakzZGoqEMPLJueuaQHGnoPFJHjtDZ?=
 =?iso-8859-1?Q?P8MAPU+khUVJGxylI9nHyADCBuZtV0lW8eH4bEdk3Ju794FVs7Q+mK//3s?=
 =?iso-8859-1?Q?KUhFxuSuUAtzWKoc1deXGJ8bNnW832b2gEvq6LbpwUHSolDaD3lZLdOBnQ?=
 =?iso-8859-1?Q?5s3RxqrgwEzLLbC9yuQmw23eBQCaEjXc6UL4gZeU3Hu6Bi3vtrEsWlGkS8?=
 =?iso-8859-1?Q?yDGZTDaoOH61mligPu20bEMR6ln/kM1nVPDqi6dJmLfBBkIF4x1Xc8xVWv?=
 =?iso-8859-1?Q?qOo2aUWJY8vAeLdJZ88RQ4+Gd5AidVLhlpi5fnSSoUBEJW1L5RQsyuPUTw?=
 =?iso-8859-1?Q?tACjSuyuUCBLVbDTILF29N2Oz8urYNzrp00K/dcAZ1j2ROkLo/vGzg5zWZ?=
 =?iso-8859-1?Q?sM2L/J86LLAZjg9vE7ejeoXcH6Fh4ZFTXAX3uiBfn0EinfjESIsZlzzgE9?=
 =?iso-8859-1?Q?dLCvX2hsQICmbP/lYKYKAyF7U7zlCSf/8O79Y94LMrZMRhEw3+Nj9DJtWb?=
 =?iso-8859-1?Q?NsDK/3uwG/XpYIXW25GwwVJOdvgSBJLOuAdhP7FaG/N4WayMzhGd0LHcfN?=
 =?iso-8859-1?Q?lf5Uhjwg14zlSqtKJelhGRsMhC1w0kBkoDrB98PA5B9hJkKRArEedx+Pdh?=
 =?iso-8859-1?Q?L5AUGGv/SnNu1cxHd1a7jGhjA2hFOp5YaOXeC8Uz5rTubfH9r0YU+EU9wR?=
 =?iso-8859-1?Q?VY/BMZ4puwLVc+FG+EbYHO9w7K6deKbbyS76M3NgCg5BO69Xb+xgZUtNcn?=
 =?iso-8859-1?Q?OGIDTUiPOSw6XZ1Rdfj6ETyBAZVZSSPmL8kz8J1e/jAhFceMsBLUNlwkvo?=
 =?iso-8859-1?Q?4uahE1X23v7t/Le6atzR3WkiZ3A7hvNyH9zswqaznTC7cIai+CTDn0YA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b76ca5a-404e-49ee-a92b-08dc3148e7f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 12:47:17.8746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qwBvDvkVaAPXqU4j60tNNSkpObV+iQLqZIAWhqvM8CnEltrNiD+F8yPkiHkJAT4zkpKy6+36jHies595/0C6XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8753
X-OriginatorOrg: intel.com



