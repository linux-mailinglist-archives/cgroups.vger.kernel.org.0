Return-Path: <cgroups+bounces-216-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB55D7E48F4
	for <lists+cgroups@lfdr.de>; Tue,  7 Nov 2023 20:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07581C20B24
	for <lists+cgroups@lfdr.de>; Tue,  7 Nov 2023 19:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523F8358B7;
	Tue,  7 Nov 2023 19:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l9ABqdz9"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761D13158C
	for <cgroups@vger.kernel.org>; Tue,  7 Nov 2023 19:08:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B5B10A;
	Tue,  7 Nov 2023 11:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699384094; x=1730920094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Umu6Vs+KmLXdWw21B7JEUtRxN8UDsP4Gv8pfLsEOGEA=;
  b=l9ABqdz9E4glTNYl8AlKxbB/6MAPEsl5RqFAlXEDD0puUSACY90VdZSP
   Ie56bNtg6ZoeLkC47ngp1GWS3vbTC4L5eb3yWcgGauwINXoFjg+jf4Azd
   EnosziH4K2nQN/7cZyeuVxO4IbkBG6zs+ai+rh6wsj5hJLduul4STjIuw
   Mm1le4p5bwmm/LPKbrG/GO7SEWUhYC0+4kdB3LzOVjSS/E1n48TlJcWHu
   Wy7V8qjy9DkTiQbkIfSOKUENXGTi42tsGm+wjDuEOQ4RAYaOB9+OSsjwY
   NLdOke3H0lB2wYUWvDGFca3vVCer48V83xcDgzDOx466mMuzZdDdhJ61W
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="393491580"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="393491580"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 11:08:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="4094910"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2023 11:08:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 11:08:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 11:08:12 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 7 Nov 2023 11:08:12 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 7 Nov 2023 11:08:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ss6v1FhEd6hb8fHAW7tR7km+T5Lb/6JtvZDm8C0iHDY9rP8uuek7b/Kh/DwasHnenDegsiD/W2Ov2MzJVh0aJFUhE3owMbKtDMzGtg0yXiff6OogzfM87OOuEH/NvhEw0Xx3tWSQ5nt9ESq5z1wkp9t0FeE4UxV7ZKm78nC85W1fQ6dRNbB1+2e4YA2Pa1g7o0uJqCzJygkZtwIY+SWR/51dA2vtyiCjX3lPlpIZQPit33lxZQ1Enyqs7hc5ixjBcV4h8u2y6QrgwPByRqYD+V4iOLlxNanFaebaXquwnqM1zUtLRBHDYDnwmc7MuM70V4Y3ehrwklYyjk+r5aOqLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Umu6Vs+KmLXdWw21B7JEUtRxN8UDsP4Gv8pfLsEOGEA=;
 b=ic1z7NZehPOzoBUURbdAApGFRUk9gBIfIuNYrbPWnYtqJ5IThgOG6fHyKTSxiwRFjr4fyZ2jx5gQZ+2NZ7fQ3QHFawktb18Msv65nYgdAzQRjNmBErmDlrk+sTHO8RD1PW2XhW5syLNJx/Uqj8F52Qed/+2BzhzZO964jUfv67btB9OzKoCWklQhgeUM3dt30bA+rZ5XDblJJtEP3KKHe66dvPhiX3OD2Ozu64ZK0EXf/LvmEahaUu9pcs4Lfjfk/iAlBNqcOIk0f2hr34v40J2VoChj4H6tOvqHe4nRI8RcWzOPpPXsS1BEE8pPOUJu77HNsJwb85Zvw8H6p+bkLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13)
 by DM4PR11MB6456.namprd11.prod.outlook.com (2603:10b6:8:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.30; Tue, 7 Nov
 2023 19:08:00 +0000
Received: from PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::64e:c72b:e390:6248]) by PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::64e:c72b:e390:6248%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 19:08:00 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: Haitao Huang <haitao.huang@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "jarkko@kernel.org" <jarkko@kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "mkoutny@suse.com"
	<mkoutny@suse.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"tj@kernel.org" <tj@kernel.org>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"bp@alien8.de" <bp@alien8.de>
CC: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
	"Christopherson,, Sean" <seanjc@google.com>, "Zhang, Bo"
	<zhanb@microsoft.com>, "kristen@linux.intel.com" <kristen@linux.intel.com>,
	"anakrish@microsoft.com" <anakrish@microsoft.com>,
	"sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>, "Li,
 Zhiquan1" <zhiquan1.li@intel.com>, "yangjie@microsoft.com"
	<yangjie@microsoft.com>
Subject: RE: [PATCH v6 04/12] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Topic: [PATCH v6 04/12] x86/sgx: Implement basic EPC misc cgroup
 functionality
Thread-Index: AQHaC13a8dHEeRpnz0q8yAogc4UDz7BtPX+AgAByoYCAADd4gIAAMb8AgAAOl4CAARxH4A==
Date: Tue, 7 Nov 2023 19:07:59 +0000
Message-ID: <PH7PR11MB5983039E8636155051E68BACF7A9A@PH7PR11MB5983.namprd11.prod.outlook.com>
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
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5983:EE_|DM4PR11MB6456:EE_
x-ms-office365-filtering-correlation-id: 5046911f-0d01-48c3-3808-08dbdfc4dbef
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hplI6q9rCQ4bJpJLZnDZlt7nJiA0Yu8Eabrn/7WP8RajtI7YgPx8dUiy4uiSMdsl4AbHZo0QHHC2dEwdMZHXrm4BcglqG8hitEHUEZAEwz1xf/l36BpMYOFtYV4Eguyo8kNSGfjHy3R0kaahiaSKHg0ZNUU43o0WZf01wNt72k4PUWgIsnOKw2P3gR+NVwmi0jUmiuTjbxTvM6wdNKaRGf6ZjkXZK1PxzpaCaZ6M/D/CvE45iMh65qQkwjy651FH8OPRLirsD50ZIe1WEQ4T6rLEBgqbMJA/TTGRGgqCezOWzliD6ckx+H2b+awpvH9ScdyttZ194JSJc4B60nVY/yW8GljN0w3cgsG0MGdDN3qEQlYBxiMdN4nFfcRaJXesSCwZNPevX2uMtV3M7CF7u80KlyFK55YiKhAYXK4emXi/GXbOj2IPhh0a8/4lE+xtek/KFt6SZO+lq0B0xhIKUtdnfLIXSzhf8lR0dV4J8KaeRQTPXnp0EnoflImKHqZ98SFcMhSN6lQ62HJ6BZlk51Ug9UtAZ79Q+QoIaTq/B9gHdBPjsB1qQLosWHeftMXio6NrBdHfp2pdpuPJwTEBsEQK0DbXInhLxl45vDxM8oVDeuOoWTYlb0mTGRVcZmsqGP2jCbvML0MLIiFs3jpooQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5983.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(4744005)(71200400001)(38100700002)(8936002)(4326008)(52536014)(316002)(7416002)(2906002)(8676002)(41300700001)(5660300002)(54906003)(478600001)(9686003)(6506007)(110136005)(64756008)(76116006)(66446008)(66476007)(66556008)(66946007)(7696005)(86362001)(33656002)(82960400001)(38070700009)(921008)(122000001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4TEpMGBddg8P3l0sbKUIqYHbRWLKabIq+uIEmMEvSLbQmGIz4kj8QydioxNG?=
 =?us-ascii?Q?Tnsm08NCcYz2pab4FcuDBELa5IfpHp6EalVtjmRkGVnkTWcyfYWzQbpGq6qX?=
 =?us-ascii?Q?tPrg+BWVdX7ZXdcX+ytc0zsrEmtHfhcGlNjQimyQLt5XVNBZYR5aqCU0GF4y?=
 =?us-ascii?Q?S2LJqJZt74Jx3hRLKh648gXA3gvWRp+0c2CrYP5auN+fcf1RfSV1HqRJrnPy?=
 =?us-ascii?Q?eAkLzvINhRAbZ8BhgEfT3SLQfRuOfQcF3ExDitfZ8VRnENTvycHAzmpKOQVT?=
 =?us-ascii?Q?E6WhjQnyxVnkvdmeiX0x+R31s6dIYwOC6lmna7ZgnzO6QiQxdFYcmkraTVZA?=
 =?us-ascii?Q?tg0sWGXUpbVEBp98V5DKixySIsSZYPj3G5nRZzuRVeZ15EwbGzL7KSG5q+uz?=
 =?us-ascii?Q?UdUjrnjrSP1NwBv2r9QlrLyRyXvTNmfpojxkXfZXx+TaMvpCFI2g6ZeV4tPK?=
 =?us-ascii?Q?uJZy964phPW4ARs0Elpp0hEr4hgvgD/X3Si2cVJebFksC5UOAL/YQXbZtDkk?=
 =?us-ascii?Q?tYO5HW/T9WC8H07TF0ihTMHE7CkW8KnuxsWbB0aZD0CZgoOdIcqDkXXgfbFI?=
 =?us-ascii?Q?8/JVjp+xhu0T3JK058Mz8XM4rSrs5kF7x+q3DPCFBcLkZgyrVBgeXM7l+gbM?=
 =?us-ascii?Q?1sCXr9UC0y1YJatOd4axDq8SLTfm6LYgKhsGG+WCdUC+9KDUcUbt62PtYdah?=
 =?us-ascii?Q?3SWdpez4uhY3a/nkE8koFpqGKKAJjogP9+MMbvWLpYbZcULOazCZXBnJ/wC5?=
 =?us-ascii?Q?g6gKhZZuJssF2bq+1QKwWHsaskjfwHsbCjgI71g1R81MzrFqMKY4ksEJcIDJ?=
 =?us-ascii?Q?7+R+PWF5qnRvNKKODFyY8Xvp10ZJThNq9mbClYoqkQDVVL+YHHHNsf9jMDs3?=
 =?us-ascii?Q?kwPgi+0GeViW1GJqPXbYh2A2O+ZbOEqpwtG3fUxxCtMtv/GP2BAyzvBO07/Z?=
 =?us-ascii?Q?O3+ZkyBvckC796z7t4/nTsS+cV0V/N8TuwsuN+u9BJTKTppx3V/iHgV6THov?=
 =?us-ascii?Q?lcHF7fyaQBGYdPAG94N+bx57u3J6nEev/rSU254nTFNz0REhj3Fh+/gaDlRe?=
 =?us-ascii?Q?qF4ovwowBlbGX0Tkfzk8VLG6/5yM8LgCl1+P/Ouk60J6Ohs3RxLHgu+pYi/R?=
 =?us-ascii?Q?afwkqwO1NYT9IrhMFAlMNo6swMNG7CkSk6+D5aGASkjr/0VDPHyBh9aUq8lK?=
 =?us-ascii?Q?b/r/2QJaegI0ON+l9cp6R37kDkfGyxqizvtYIEaBpU+b4tuc7CSqkXkdaV3d?=
 =?us-ascii?Q?conziUQJmvDw5DIYJM04lUK0CJuz3x0U39YSz/iWc999+WfpxGI+ngPEFcOa?=
 =?us-ascii?Q?xDhED3UYHwRWNFrFH7qc1UXK+pjrm8m+uOkQ4dUWG5qFVXRik9mmRo1mqWq8?=
 =?us-ascii?Q?re4SPM6Fw37hhxLmQAaN1F4X31HBmACAlsacGTkwUBRvSvUYEbL7GisAIopy?=
 =?us-ascii?Q?d9Xtn5dOmy3iHn5WTZKH80l/41jEv1jllWoh5F/API/PlDfVmmdv7V5p4nv5?=
 =?us-ascii?Q?H3SG8cnm80iRvkHSlpDvo5isCABVSpFCQZKnOQ6delvy94/BvtOLppGS9tQB?=
 =?us-ascii?Q?IEnzZZcSicw9QQte7Ycs8xKFkJUTEPUW5XJQg2OqsxrcLrU1Xq3eWF0HtE1J?=
 =?us-ascii?Q?f4W1jp4BlU/bSiuZ6VCppbesOtCqvEvy7otYoxFKcG8U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5983.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5046911f-0d01-48c3-3808-08dbdfc4dbef
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 19:07:59.8986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l820iyoelF9Nbk8LTreVKxbVCReti2vwRT5VnZ64IHQfJuGq3QiOj/+2vKPGUK8c2DQiBE4twx/VrfEkkocCUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6456
X-OriginatorOrg: intel.com

> I should have sticked to the orignial comment added in code. Actually
> __sgx_alloc_epc_page() can fail if system runs out of EPC. That's the rea=
lly reason
> for global reclaim. The free count enforcement is near the end of this me=
thod
> after should_reclaim() check.

Hi Haitao,

Sorry I have something else to do at this moment and will continue this ser=
ies next week.

