Return-Path: <cgroups+bounces-1276-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 283248427F8
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 16:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46E2BB215B7
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 15:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B943682D71;
	Tue, 30 Jan 2024 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lca1CCHr"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3D8811E0;
	Tue, 30 Jan 2024 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628208; cv=fail; b=lmT/m0lt1dBAa6NfstrAXKyaLQuYfxxZIO0rmWYqeQhgT5meVq272Yer4mFK6yG6SLG0XnQERq1ayvxoAObTE1q424UJucUE1qAE0c5y6zyhHNjN806z65cdZspEcqnVKLucF5Ay19Frf8AdgSNQJVMdJPzqhTeDPESt7s2Z9EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628208; c=relaxed/simple;
	bh=oUV1F8lWcqndslM7Mvgxqjsv7KPAhYLlcW1Hqn8ITGs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EedmtVcr9EkVewBJyAy0dBsvhzESmtfna6nW7uoV73PYCf8FfetJeLyA8BlXm7MrRpn+YnGMyUslEwidGkAL+ohPjs/UtVhbWW0Gpqq9jo+n+oWovBUXOOg36HhEpBFkd5QUdCovDOmEkgVRbg1/mVmfJnjrY/0XS9JY/TUWDtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lca1CCHr; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706628207; x=1738164207;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oUV1F8lWcqndslM7Mvgxqjsv7KPAhYLlcW1Hqn8ITGs=;
  b=Lca1CCHrjFGaSC0v4QoohguNi+Gv64AcBrCzGF5ZgbAMWUvS6ob05Gv7
   dEVZpW9O++z6sEA54M3cssLOHJ+OLyJBb9smw9E4Mve8Yp6NssU2fIdVp
   t/dq7vO1fu1BTWWLibJ2daxWf/lT0b+Z1Yvs9WXJAxp7eXqrjVFDaxqQl
   0G6glYna3t8wW8cGlIjwGh9go0IeL9RIcCYu0BPM8ED9uKs6h7NGC3udb
   dli12kv62LHRMwvPycpXX8JftLz/6nSGHFulKNX0Hhq2KNtIwMWP1PYEI
   VQ5q6xbGbtlRcxTZQvVn5Hv+rFHyoJQmovSTIVSQHTj+aBGAsbBispN7a
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="24782157"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="24782157"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 07:22:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="22463075"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 07:22:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 07:22:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 07:22:22 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 07:22:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJ8z7WdlGWtxVAJ1wgk4fkomvBdYgFJI36aRzPz4kKnIitR2T1aT/i4Akd/0Zw8J1U5+2wBLv+6dOmV8RIwmxxzyebinVAg5DA8H9T34wf91VXaDTWbIRma7ybsbMaTSVOsFEaVOlVJrbqjMb9Dy00f1XvsYr9QKLbAwT6eGdU7hH7XivJRL3q160t15+zs+lFKbf4qwFMw0sK/aue+2zOR0bpbGrkz9MSuDuQSaA2FSjf+iRUqU/yBMuqwFk5meeichFLa2OEzInswO/pR6ArQw4QafU7bzMDZ7CmGbIoznRFG6TZZxprM/+dehcvTjx+t3om+MRXMOiEzdCneoSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AD0nDsZgnHV+K3ruAFHLIBjC7TDy7jUELJHyWXMUcys=;
 b=cVoHot6RDBy2GI/JWjl/rwzR9t+/cQog8QojOrCWNsNx99M5FYWc1LuEm93tMYYjaI+2i5QN0KSsqmQV526v69AiHpDHlv52k27oTo5iH+4NkmayNBH4iLH6mx1GME5vK52/9EWoznkXRzgKl9TEfjsEgPHDOrirOpA8bW0PxWq7goHAwB0mXbVf+sXbheEnNSY7S7gVKbxZyQYFV9cpaXVY6gaS1Hj7rPFqu876f2MBBDdoKiTSZhPiqRyZx49vslKIuStq+sT4Y+XV0hlpe5EpnYuFjlVa4LnpzQd/gl+ozzxdEb2ghXbWw8+JN+B4/qvURixp3Aif+lTuLJ1uRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA1PR11MB7110.namprd11.prod.outlook.com (2603:10b6:806:2b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 15:22:17 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::124d:fbd5:113b:16ec]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::124d:fbd5:113b:16ec%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:22:17 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: Haitao Huang <haitao.huang@linux.intel.com>, "jarkko@kernel.org"
	<jarkko@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tj@kernel.org" <tj@kernel.org>,
	"mkoutny@suse.com" <mkoutny@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-sgx@vger.kernel.org"
	<linux-sgx@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>
CC: "Li, Zhiquan1" <zhiquan1.li@intel.com>, "kristen@linux.intel.com"
	<kristen@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>, "Zhang,
 Bo" <zhanb@microsoft.com>, "anakrish@microsoft.com" <anakrish@microsoft.com>,
	"mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"yangjie@microsoft.com" <yangjie@microsoft.com>, "chrisyan@microsoft.com"
	<chrisyan@microsoft.com>
Subject: RE: [PATCH v8 04/15] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Topic: [PATCH v8 04/15] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Index: AQHaUyGOl9vfNFvwQEi7DaOozhX++bDyd+Mw
Date: Tue, 30 Jan 2024 15:22:14 +0000
Message-ID: <BL1PR11MB59784620554CDAD5E2C2BF45F77D2@BL1PR11MB5978.namprd11.prod.outlook.com>
References: <20240130020938.10025-1-haitao.huang@linux.intel.com>
 <20240130020938.10025-5-haitao.huang@linux.intel.com>
In-Reply-To: <20240130020938.10025-5-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA1PR11MB7110:EE_
x-ms-office365-filtering-correlation-id: 627b2990-ed2a-4472-5584-08dc21a73d40
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mufuw/+xICGhP1ndMTH6xOqFO/2bdxfsC41ogLpjgdWYx/mjJp7bE6rk9utBSz9E4/XJnxLUTGcPuPsmdH/MVdXl/I9tA4K3KVsVm9o5tua+wfe4W8FRkuBW06xpDmG4i2ZTUQrewqunjCHXyFrrrzQj+obhS9vcVqKbOGphEoXv+yaEWm7o49vyf4P3QzINYBgq6zGfHED8x6aQrwSDJ1pt1PMzfBqLRid2TZJrebEadB9ra5Up9F91+aQIyUY99JCKsPRM/hVCl0VEfmclPr7+Oeb/R4bxaIB+RyCi07p/TbAvBJQDITqvGRQgimuDM6Xiq2t4i4BGY8mpT4/Ud1ximWJ6OVBf30yqU2BZ2QSyCIu6ntOuT697mckp7Z385vJJ7iGEUlAboFHPpGdsjjh1Wr+PHSxJFo9BqdKB4xmwspOD83NLEbewJ8VFBKlwyO9p7pg82mfQCeEeQj+480bUbhtQVGWuGNnjjB9L0SKT80O1nSPDQ3s2LADU8yGAhk3b3oTndhadeYEUla4HfN6i3GVMpx3Z+ReAAvBePZQYyAANasGcMLEUPzH2yoXhCkSiHPgN4BfuSAP9/ixUrJ/yau6FT5Tx0KmKfihOHGpyBXz95B7+B/0tYMWKjpvb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(82960400001)(38100700002)(122000001)(55016003)(110136005)(66946007)(66446008)(316002)(76116006)(86362001)(6506007)(54906003)(6636002)(7696005)(8676002)(66476007)(8936002)(921011)(64756008)(33656002)(9686003)(5660300002)(7416002)(52536014)(478600001)(4326008)(45080400002)(26005)(71200400001)(2906002)(6666004)(66556008)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sW2oVbiat7Ftp2/s8JTyYn5SuKxUvvm7oBqtxcBr7IRp1o3Xc2IQZUQb8582?=
 =?us-ascii?Q?zmjKV7Ewyv+eX5fNK11KUatj7OR7kQg774pgRkYKbP6I3Zzbu2wgABZINw2y?=
 =?us-ascii?Q?2qFScVle9dkQ8WdhsWqbaQFU+6Y45UrxlUQGMSoBarW1rD7izFCf0FZYFXOX?=
 =?us-ascii?Q?O3t+1+ZswJBxsBelP4LnXOvkgJg7u0b0QigPpmY7GRDElz6mQaR/Uq32i4kc?=
 =?us-ascii?Q?YR5tFiV+KVLmFI2agicTeAIzW//15TW0FBttnZqW5wkOMz9Iuk4jPxhXz2RC?=
 =?us-ascii?Q?zMD/PMM81qMzLOYfIgVhr4rSBH+CIVHCYbgfL3IQqZhrNbaUpQ+ESAw+GukK?=
 =?us-ascii?Q?ZJ7Aiw8nTuU993Qr2czoFBD0fZ/zDcMVE0REpaKFhM3+zucrdYSUop7liA21?=
 =?us-ascii?Q?JJrmuRNWeGQuB35nyPRQJ3WPovGh6rjV9lPrXwLxAKtwpMf147CxkKstU2v8?=
 =?us-ascii?Q?AUS2a6AN6bmHaiQrwr0dxxmV+F73GNtZP2V4h0wOSugjdtK5gkt1hF0OgghI?=
 =?us-ascii?Q?LCEwFgnzboEA2K0TAEQYny0w+Hcw0gjpejd01DGxYWXlnBWOuxVRAabM0qi3?=
 =?us-ascii?Q?9NfkSVUPX/4nULRC9YtLyC/FIPiX9nNYbcSBf6KrgYj7W9VwzCeq3XD28t7Y?=
 =?us-ascii?Q?1M6WU6GkcCujUcQiuaJV5diIsVsb/rNjeESHphqlx6p86AnJLpu0eBon5JDi?=
 =?us-ascii?Q?igbB3uTSm58wU6PWVqOv0g01nVAmxW2CGA/+yilegZmYQyXq3WtXanhPOwky?=
 =?us-ascii?Q?XPeqJw73XJYhbfrvc6G4wCNAObnZFIEkR+OThboVaOS6wM87kwEFvFksNhOD?=
 =?us-ascii?Q?E3xuZXqTm+MpUvZORIbxth8QqwPsB307F0T3pGuYIVZfMvgjYCQd+smENvPv?=
 =?us-ascii?Q?+cCHChYOdrqKJA3nCwJia+Pm/xJUkjhUWZwSthu448NYfBlDX38JO0EnCkBE?=
 =?us-ascii?Q?6jcd6UowFYO/yeNZ0DbkeT39s+raAGXM42jt6ry8v8mPmdhMzbJmOxFJLyG4?=
 =?us-ascii?Q?8IoMLbYtyRH6P2JaNuIbFTg1fAvBDXxiqWe2YPMi3pvkcm5iUm5IqnJbn1O9?=
 =?us-ascii?Q?1GAPiUoL/HqhZhwbFNigZvx/ODq0DkJLgNwsRv1h87sctu3Vrcz9wpHi8+Jt?=
 =?us-ascii?Q?DqmN4cjk61E5BM67iykQi0eCxfJnIHN9Uv3Tsvc6T8Iut9baPm3gkqJqrsQQ?=
 =?us-ascii?Q?yQMI3R7t//9XaUi66CCTvhiaIlnE5bsCM9v8znIGQrxS5p81gq5lxORuOSnm?=
 =?us-ascii?Q?u04z6mQQ/Afn+w0jpIErD4eF85tpYsiywK679LdhA3Qfj2B1ThP0zjvNLqQa?=
 =?us-ascii?Q?kFQCP8Cm3tOutaob1Ikl6wAy4fb6NAdXMOwNCKqvCXJj2BC+V1jrXxmcsE3/?=
 =?us-ascii?Q?BNfHZTX204C8VNyxFPpAZNEjK1NPZtUSnld3+2o/jYcsgjLr45SZaH80A+Ke?=
 =?us-ascii?Q?hKg+HT0ioTL3fnBy5Z57YWJI5lSnqAQPWDdgPXReoomFKUYKQG9Dgbyw6PWn?=
 =?us-ascii?Q?Xa/v++ZqGe2CITTx9FYLKEFO6pATFtVRADdVKlwTOKI5wkMHQqFB0exwA01D?=
 =?us-ascii?Q?9pREVaa5rLMvQWQzRibERpo2V/m6R8N+UGXXvaEv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627b2990-ed2a-4472-5584-08dc21a73d40
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 15:22:14.7549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PieDWbcswV/RlQFNhQeoIu3ACJVW3OpeQ2rmFIYZMcjjXF5BWRcxbfJQpJ8cUXQXVrbzQm5GLkdRUCg0Ph1x6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7110
X-OriginatorOrg: intel.com

>  struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)  {
> +	struct sgx_epc_cgroup *epc_cg;
>  	struct sgx_epc_page *page;
> +	int ret;
> +
> +	epc_cg =3D sgx_get_current_epc_cg();
> +	ret =3D sgx_epc_cgroup_try_charge(epc_cg);
> +	if (ret) {
> +		sgx_put_epc_cg(epc_cg);
> +		return ERR_PTR(ret);
> +	}
>=20
>  	for ( ; ; ) {
>  		page =3D __sgx_alloc_epc_page();
> @@ -567,8 +578,10 @@ struct sgx_epc_page *sgx_alloc_epc_page(void
> *owner, bool reclaim)
>  			break;
>  		}
>=20
> -		if (list_empty(&sgx_active_page_list))
> -			return ERR_PTR(-ENOMEM);
> +		if (list_empty(&sgx_active_page_list)) {
> +			page =3D ERR_PTR(-ENOMEM);
> +			break;
> +		}

(Sorry for replying from Outlook because I am in travel for Chinese New Yea=
r.)

Perhaps I am missing something but I don't understand this change.

An empty sgx_active_page_list means you cannot reclaim any page from it, so=
 why need to break?

>=20
>  		if (!reclaim) {
>  			page =3D ERR_PTR(-EBUSY);
> @@ -580,10 +593,25 @@ struct sgx_epc_page *sgx_alloc_epc_page(void
> *owner, bool reclaim)
>  			break;
>  		}
>=20
> +		/*
> +		 * Need to do a global reclamation if cgroup was not full but
> free
> +		 * physical pages run out, causing __sgx_alloc_epc_page() to
> fail.
> +		 */
>  		sgx_reclaim_pages();
>  		cond_resched();
>  	}

And why adding this comment, especially in this patch?

I don't see it brings additional clarity because there's only global reclai=
m now, no matter whether cgroup is enabled or not.=20

