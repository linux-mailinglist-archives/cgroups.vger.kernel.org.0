Return-Path: <cgroups+bounces-8655-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8782DAEE098
	for <lists+cgroups@lfdr.de>; Mon, 30 Jun 2025 16:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760571884340
	for <lists+cgroups@lfdr.de>; Mon, 30 Jun 2025 14:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B83228BA96;
	Mon, 30 Jun 2025 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1BLxah6"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B15272633;
	Mon, 30 Jun 2025 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293560; cv=fail; b=awdb/LjdMOTD/NBzauyC/kLUaK+shsElbSso789NaT/d0OAlL179PZ6YY+dZuzfDNpBLpA4QMxeZbi8p4YH53KeelIy/+7GaxHajxGkNtNY5XcuYDvMrdO8PwzWPoelEkrpJNXf+mf2P+52rJVBo0YAZup/xnR3lY9DlE/vyCQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293560; c=relaxed/simple;
	bh=jllWxY9T7DwiVz96HKRSLwlNE3FUQdimAZ1tP8g/BEM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HiMtzPdomHbi7o805sCxo3SsJNnGZwhsY6mPrEUYwoF+acjMNTKtvv8S6xMVjH6GxeszPChSvnJVVTOZN+YjVGDcokExorhLiMjjrcqEkLhC2X6tBs4XZsp74giuHi45OGeU+u43lKgOoere9K0LVRDY515rPCD3MTPUr2cxMWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1BLxah6; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751293559; x=1782829559;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jllWxY9T7DwiVz96HKRSLwlNE3FUQdimAZ1tP8g/BEM=;
  b=b1BLxah6c68q3oqcfpRh9PfKP0rrTYQz6qci39puoRkH9eUHCJ8Sc/Ku
   /5lN9q5VZbiSm0mV29eV1x3i4ficUjrs9GXiknbmwLhMuz4ZdJkoSDK6Z
   tZTjcDV8QFRM1az/h7GXuHMxLkkitpujXUuiFrxJhaMQxGnRjgcbruKKe
   /ZIQSeHo5PAThvGmvwaaFOFSBBt48wT+Mn94TP+7eVlHkMus2qRhcqTNk
   DaK53fp7ZWJ5j0SlQYMZYRR29MsHS5rjzUbSn8PkX+n+JYLnpBjhk23yR
   /tZY0KzhHm6ToERbxIrpzkmdiJUs9pOUzAJEfbvFJB0d0oMGObg0xE9DS
   Q==;
X-CSE-ConnectionGUID: jsayIX2qSQybVZ9jnr4PQw==
X-CSE-MsgGUID: zoIkZAbJTASq+rT+Ytzzfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53383054"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="53383054"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 07:25:58 -0700
X-CSE-ConnectionGUID: ROsLq2H7TkeuDSPyqLgLtQ==
X-CSE-MsgGUID: WAfEOxOjRiuedL5t/XRKQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="153109144"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 07:25:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 07:25:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 07:25:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.68)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 07:25:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aP+Qx4h35P9jwg1iYHOmpLJxtsJge/QWHaHjqMTKM71BkjJmsgYnRGGMsVQ2mWoglGhhk4+F5lDP+RZTu/I9B/cgS0SgXsx7Nw+4aRGZxJA/+E6ON36KRvdAu1VHuir5Bm575fKc04tlODYrolW6I5eGKO7VNcg0YYh3veDHTj+6qP9x7PkWaWBIq53lmTrCi4nOwFILzFyuu/hEWiwO1I/w9baQBXJc3b4WS2QhPPD6XGxAIuRNjrEIaHVZXIH5h+hfLJfeXedf1+1EPFYTdVKpZsmvNxaVsU7Vt4w7YH4NngH71oirjgqxvMMoOnxZ25LArwyWjlooQ7ukn8VvHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6S5LUHDHM9cxiol8KcRNNZZSYOEnj4WqI55jsqy84k=;
 b=Tm0u88DnACEQHe8BHGiDn7yd77X215rJyfUXcOZJB8wPRSaImUalTVGlf3BLBPRHv6sRV0ZkZhIbJN3hISd31gAizlAYv1kgA3CtBBhxThug4RZ7yeUlqvJjyjjd3K52lVN1U1faYOQCAflGpkM4Yyny+redlB/TuWCDRvWo5IpbrctPdYn2syvH+Lk9NwHlr6zz2cjjGlOA3ugCQg7iveEX/s/Z+HlIG/OxgKNDOopwhJvkjZcorZKAJAdUhpM9VJvGGxLlY5KftoZ/8jbouuliRxLFt5yCrktxF/EOchQvCUe6v6yQHvHaKKjKrBpFa5JrYUVwyPnHKWQTpz780g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7894.namprd11.prod.outlook.com (2603:10b6:610:12c::17)
 by SA1PR11MB5828.namprd11.prod.outlook.com (2603:10b6:806:237::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 30 Jun
 2025 14:25:27 +0000
Received: from CH3PR11MB7894.namprd11.prod.outlook.com
 ([fe80::4d2:ecb9:b88:6c9a]) by CH3PR11MB7894.namprd11.prod.outlook.com
 ([fe80::4d2:ecb9:b88:6c9a%3]) with mapi id 15.20.8857.026; Mon, 30 Jun 2025
 14:25:27 +0000
From: "Wlodarczyk, Bertrand" <bertrand.wlodarczyk@intel.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: Shakeel Butt <shakeel.butt@linux.dev>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"inwardvessel@gmail.com" <inwardvessel@gmail.com>
Subject: RE: [PATCH v2] cgroup/rstat: change cgroup_base_stat to atomic
Thread-Topic: [PATCH v2] cgroup/rstat: change cgroup_base_stat to atomic
Thread-Index: AQHb5RcNKOjgP8rvyEWnUhbN1DoTcLQV00mAgAEXB3CAAFLRAIAEgU7Q
Date: Mon, 30 Jun 2025 14:25:27 +0000
Message-ID: <CH3PR11MB7894D2570AEA9AB67DBF706DF146A@CH3PR11MB7894.namprd11.prod.outlook.com>
References: <20250624144558.2291253-1-bertrand.wlodarczyk@intel.com>
 <ykbwsq7xckhjaeoe6ba7tqm55vxrth74tmep4ey7feui3lblcf@vt43elwkqqf7>
 <CH3PR11MB7894DDEE6C630D5A3A4D23A1F145A@CH3PR11MB7894.namprd11.prod.outlook.com>
 <aF7L8jRkWm1TrwSu@slm.duckdns.org>
In-Reply-To: <aF7L8jRkWm1TrwSu@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7894:EE_|SA1PR11MB5828:EE_
x-ms-office365-filtering-correlation-id: dd10b476-1db7-413d-3c27-08ddb7e1f594
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|42112799006|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?CMjhCplhT4BmUkDNfiXkKuyXRRO/mfBGABQm8Xd/PryJkdEbuyDqTnzVLz5g?=
 =?us-ascii?Q?mt8BIAUmI4Miy09iY2gbD27JHy4+yYKCx0D9lvbdz0mPzJLXoZUDhWJsVgwO?=
 =?us-ascii?Q?hbPtAmNjVbf9SP+iri6HODe3+Xo5ag/hjT5C8+fVsWlfNcnuSOGN9hFiXOB+?=
 =?us-ascii?Q?SHinvuC+qYYZ3Ov99462p+E9oQYKvCwdo5cME/qy9wF4BhCGNk7zvINJfvFc?=
 =?us-ascii?Q?kVGeV5uk20pBWTQGD5D9E7zXI+RhcBjxnjmven3RIStK+WdFC/dAuhpJvJLJ?=
 =?us-ascii?Q?dJVcUTzDavG27exKfqInffZAUUo/RstMOg3nOGmhzGaHf0CsZg3G4HTPky9f?=
 =?us-ascii?Q?R7cWMXi4eRDfLFNdF5FKTFyHQkYgtYlh/KJapK+tRVkQMVj0n51fJkuiBhXI?=
 =?us-ascii?Q?LP7Ecj+ZZJnv0De+cmWrCUW35nOK2k2IHMvMKIHkhUsFVGFf6vYPogep8ewj?=
 =?us-ascii?Q?VkPOTHtwpOi5TpbgyaQ3PQB1wgdn1kRdn2ARqVneHGtbM6nLGVsn4S1zuII0?=
 =?us-ascii?Q?3B71GE2HtlCv2A8L0rDJk6yGuRgYjKM4OfA68fhk6ZJeX4+rqhu3YGtTPlIz?=
 =?us-ascii?Q?+bZx78sGm4MmC3hkIUdVros7wxmQgj7z4ySxCHrqyuDdnH13UFSTj4sLr5qZ?=
 =?us-ascii?Q?SAc/jW/fAm7RuXPmhJTJtHK0Un9gVZYVxamrPBMRvozNzlSkGslp3pCkWM0t?=
 =?us-ascii?Q?FUHF7wgbuGiJ8fUu9kdq1UQd9vCdNAKwK1dMFynkzrJn1iNBX2LxaT+6uBkg?=
 =?us-ascii?Q?c0OAMqZd9kbpR4Z6jkOPOWCB1Prk14Zvipaf7y+QO80RMtS9detR3MUiOI2K?=
 =?us-ascii?Q?GFKHVetC7T+2Ki7pVtXvI5gpQOBZt1sEuB0p68GaVVwam3t7hfc3hnrB5BRS?=
 =?us-ascii?Q?lGWGBb5W7aZqcYltEFrCjYOF9nAYGTSNHlUjTUwNUKLdkzO3QXwce0N0I8Jd?=
 =?us-ascii?Q?aKOliv4YjakRjXbI6rhOyVEJAhGB+HwP064IoF9bi9Jtla5a2BC2TdXetswL?=
 =?us-ascii?Q?QoHU8K/925pnO4hb5vI6IcRpLlfIPI9y4Ai+Ud/TS1Ew3zY8y28oQ/TB5FSZ?=
 =?us-ascii?Q?fPTQEfSt+L2Q2iTOdC4Psex4QVVZuyb+NU7Jb4NkUhDYgm1qUrDLbvagAeBG?=
 =?us-ascii?Q?DY0v/DjSnfTJgLgLpJuoGUbyf9PyD1cNvygL67ItsVoh+wEiEZa+Uf0Ldm/9?=
 =?us-ascii?Q?VYovJJdMP/PZIzQdSGHtx4fxjiR6+8t/SGwvJdm7jmPyExIQcRJl7DYCb3BH?=
 =?us-ascii?Q?ok+hDwoxf5a5Oc1XzVqBe3E0qBqHFm3EKw3nKlhNJ41dUhVWFRbyl/deTf/U?=
 =?us-ascii?Q?tIiGmWP0Jj12I0kddtMfHgQkhsdpaOFBQ4Dd5K+hj5+zLON0F++GRcNxsy1S?=
 =?us-ascii?Q?alTTgO3jZmQMuGN2F/4VHZlowA50/yKcB8G+2sRr6ambxiD8KqvTbxq5/JX0?=
 =?us-ascii?Q?OLkkjQfCD9edzjHauTzrXEpGkUxCpwW27jQmZiK3yLdvkw1V/IkIDeSZPLCV?=
 =?us-ascii?Q?Tx1m5/JSNug/id8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7894.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(42112799006)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uqsGFuqsfURXX/8E/wUB1UQhh7u2afn01Mv0GRXvMrlmK4tZih90flXjQVaG?=
 =?us-ascii?Q?EaxgAH3HZkPnib340ewijNOebci1Y7GajY/8pgdyz+NDLmIK0H4zPnb4WLzi?=
 =?us-ascii?Q?e7gfMEQuMKEtf3gfKObkbLAQIBFh4LIJi6A5aPrF0Pg0PjsOqAuNFrO16zac?=
 =?us-ascii?Q?VMQkWr5XE0nj+//wjgAAG96zcfE03d2EK1CcjN3PbAK5rAmIxjTsPffgwhK7?=
 =?us-ascii?Q?MEgEwCh08OWCpSHVE72Zf5RM2v6ADG2NC/fOOWVKDZ/BlJo4pDz7mssCEKg9?=
 =?us-ascii?Q?oETgYwdne1xP5Y9v+IXLJu0F49h40+LXDle/rXqc/Ank5ibxeQzaTjvjTWV4?=
 =?us-ascii?Q?yh+YXw5nwrpoOhMUDsSWHTqNnZNenStoadXtzpbCJS3wxisQClC64xc8x8C8?=
 =?us-ascii?Q?afZbGJOUePX5XzGUTbRLQ3bmW/SfgQlx8zIzxh1vy8YNnfmFDXCRpolm8ni3?=
 =?us-ascii?Q?SjppJrlOF6FVIAO/cI++ct5YvHFYWmBk1Aw3DdIR9L9ZedOX8RYNywTmYOfD?=
 =?us-ascii?Q?zId8QgbSzQ0SFeDivFjg/fqDiU70mtE7Sfg1LfI2/WuwqUR1yLPbdpvleEbC?=
 =?us-ascii?Q?NkJ5MT/sNL0e6pxIVAIxki/O5U100HlUlsqVGoUz390NpqONyHVP2DHXRhjB?=
 =?us-ascii?Q?FP6d2iaY5WKocOWhsNdV0gXicT7Si71llj9Yv15yC7oziLVO0TacfDwUiYOB?=
 =?us-ascii?Q?tEMZu3eT1rBfPS9YdFbqP2SrmOd2kxx7ZFWHFT87I7H8SX2fE2a64eHZK5aX?=
 =?us-ascii?Q?8Uf7pHCBTU64V1rn6Dnftm3qo6IFcn0deP0C9b0IpU10t54MLCuWmU+QOzW+?=
 =?us-ascii?Q?VbeuEUm7C3e2yLGXRdRf+HOhMKqw7xIvb7Y8aTou4gd/NdgUiuzjE8wfv7yZ?=
 =?us-ascii?Q?BXjVCLbN5zIrQoCUWixoP42jsX+ZdNslkX8bRLfC8e/mVJ8n0fre2bhbsGCr?=
 =?us-ascii?Q?ixDvTv8nAXVEruahGaaw2G3Bmbl/eNF4QTi6KNcgVrUONArfjB6KZYLHf/3U?=
 =?us-ascii?Q?jBNxpwHOMQHBGjdZs5125sxPUiicJszMpq7n71hrPAPajb8Tw4OogUUB4YWe?=
 =?us-ascii?Q?yzhMTMxa5uCDe9/LetFYIebe/X1j+c82wadmXwSJoVSQ/Aw5aKaHOeI9UAnb?=
 =?us-ascii?Q?Qaj0spnzRgqNMm8C0QfspAfhJcnBmTRlZU2i1qLwtPOeGPemdVOOTjDe/9Os?=
 =?us-ascii?Q?qPEfiZmPBrv1DAk9CYHrdyu2S6vKIUHL0okVVyU7twmakf8RPLZDw+kkWLwG?=
 =?us-ascii?Q?ruxyIZYNpx5EtQG4wJELuSGrzB6rCjktpVrZbiQK6AkLO5u8ycBWRZNQvU2i?=
 =?us-ascii?Q?/14nTg5QOUYML4k4WFxR3xm4suZCud+u7AZA+m5MeEQu6azCUvEm3n7l+ktE?=
 =?us-ascii?Q?v8I1dept3sVg2fgpO4WouInosaRpLWVg1KRpzv18/UTpW5jPTiK3rK3+wjxw?=
 =?us-ascii?Q?Cx5B454m1LAtD3UAjYxV2HCPwIe1kLidMTs3HbYP0+Zh+3235ET0Xf24FRbr?=
 =?us-ascii?Q?kTtUeooJKfHXzhi8XreETRdGp8fdF1NNmtDqsujd0Jxb8kyD5T11HUErx1uc?=
 =?us-ascii?Q?YgpaBfIdcfcSiswnUNsY/49AJSZ/4dgs0dxKNYxyw7Lk9Dqh79EjE1bpeZLb?=
 =?us-ascii?Q?ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7894.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd10b476-1db7-413d-3c27-08ddb7e1f594
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 14:25:27.1659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CxR2kVetUAQK3pddGK8sImDX2/k8oYQI7wsSulMDmtEVLv7NoUMAjNzBFSul7hFU/ysWHJrAJNYnihx4OSQSv1S49xrDK9ZloLlrBRmVG6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5828
X-OriginatorOrg: intel.com



>  > Also the response to the tearing issue explained by JP is not satisfyi=
ng.
>=20
> In other words, the claim is: "it's better to stall other cpus in=20
> spinlock plus disable IRQ every time in order to serve outdated snapshot =
instead of providing user to the freshest statistics much, much faster".
> In term of statistics, freshest data served fast to the user is, in my op=
inion, better behavior.

> This is a false choice, I think. e.g. We can easily use seqlock to remove=
 strict synchronization only from user side, right?

Yes, that's second possibility to solve a problem.
I choose atomics approach because, in my opinion, incremental statistics ar=
e somewhat natural use case for them.

> I wouldn't be addressing this issue if there were no customers=20
> affected by rstat latency in multi-container multi-cpu scenarios.

> Out of curiosity, can you explain the case that you observed in more deta=
il?
> What were the customer doing?

Single hierarchy, hundreds of the containers on one server, multiple indepe=
ndent owners.
Some of them wants to have current stats available in their webgui.
They are hammering the stats for their cgroups.=20
Server experience inefficiencies, perf shows visible percentage of cpu cycl=
es spent in cgroup_rstat_flush.

I prepared benchmark which can be example of the issue faced by the custome=
r:
https://gist.github.com/bwlodarcz/21bbc24813bced8e6ffc9e5ca3150fcc

qemu vm:
               +---------+---------+
     mean (s)  |8dcb0ed8 | patched |
+--------------+---------+---------+
|cpu, KCSAN on |16.13*   |3.75     |
+--------------+---------+---------+
|cpu, KCSAN off|4.45     |0.81     |
+--------------+---------+---------+
*race condition still present

It's not hammering the lock so much as previous stressor, so the results ar=
e better for for-6.17 branch.
The customer has much bigger scale than 4 cgroups in benchmark.=20
There are workarounds implemented so it's not that hot now (for them).
Anyway, I think it's worth to try improving the scalability situation,=20
especially that as far as I see it, there are no downsides.
=20
There also reports about similar problems in memory rstats but I didn't loo=
k on them yet.=20


