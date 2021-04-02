Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E781C352932
	for <lists+cgroups@lfdr.de>; Fri,  2 Apr 2021 12:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhDBKBr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Apr 2021 06:01:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:38953 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhDBKBr (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 2 Apr 2021 06:01:47 -0400
IronPort-SDR: 1uMCiC0ZCLwsm92s7Oj7KpW/A+gl5qigV+vB54WNW1LwrZXTQ3UfhT5hkczcaizWL/Taqksj+1
 sk4/nYQGP6AQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="191918452"
X-IronPort-AV: E=Sophos;i="5.81,299,1610438400"; 
   d="scan'208";a="191918452"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 03:01:46 -0700
IronPort-SDR: Mv53InbaPu7iauoCxnLkoAy81UkZZw7STIemxqq6sWKiUQi868nOIS5DkLRyhyA0kznLlHctlC
 kfHhXh+NHXUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,299,1610438400"; 
   d="scan'208";a="607924696"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 02 Apr 2021 03:01:46 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 2 Apr 2021 03:01:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 2 Apr 2021 03:01:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 2 Apr 2021 03:01:45 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 2 Apr 2021 03:01:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxgfM650EBzax4m7Eq1GcDmoKRBPMXjkVWW5v6tDJJ2vZtWOeW5K5OE8phP6qaXayEZjZZqNhzp6eyD6RWldPw+/WtacmoDp2WLoj/RnVY/hrbEpRnOsD6ZnSFy+JxlSubzR6+Qwl1txPvc2gT/kE2tYxLnYnpoYClvHX50d8TasevzRsKlDDCx+GO3ObNTBi/T6lTh5/mJH4JujDF6fmjKMT91ckCHvV1XxG/5TWPUrSvjaIhejE0fIj0IiNdcfDWFl/dewWbcebELXzooSNBrMnDySxQmg5kZUXIzTVIemg+HuzEMyEnI8e510FQ8YKqh4O4l6O41x5R54ra8vkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2+pUGcyJQZPzqywFMVsmg6lef56Lc7Hz+KF3cEc9iY=;
 b=IdEuSIPoFUJ59L0z5i3EdkkiO0gt2+gNJxl+DGZysZB8vw0BzmqE4wxxsg2oESM1ygvp4ah/pRtjsWeCrVId4gorQk2oZib0WyMT3HC3HyyW/bpAyYF75uTzJb0kX3tK6t4PpYTVj/I4i1nXiJ8x0m8XH8REZTW64MQL4wVEofvRKCKguI3WDPnHgVe0Gp9aKkvcpOMXzyvQrIt95OV6pcOzeWr1BrfZvotnI+b890CtPMLtfSZZ0U0J5vP39Q1duQeqTOjZSPf47WKQlIt0H8+CPMCETegeljW5Zyt0Ga2pZpgjynsAxCudByFQ8uJxOBTZuDmJByG7U/imcU7Omg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2+pUGcyJQZPzqywFMVsmg6lef56Lc7Hz+KF3cEc9iY=;
 b=UPNtXLDw52oZK/T4JsK20itUGfCqePaI+JOvSdpm8RnIlCj5FnNwkoc3JaL8Ik91AqQzubEpkAWzS7VSUwfrgDYzb4Pj7qyJRkIYGO8t0i8UahVpim1u3KL/r+oTEf+UW7HYUe+RQmbhIJjchZs8E3gMXcucAWHRBwTjGZEisMM=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR11MB1472.namprd11.prod.outlook.com (2603:10b6:301:d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 2 Apr
 2021 10:01:43 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.3999.030; Fri, 2 Apr 2021
 10:01:43 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAAHeZAIAAF3gAgAABVICAAAfXAIAAANyAgAEpdBCAACimEA==
Date:   Fri, 2 Apr 2021 10:01:43 +0000
Message-ID: <MWHPR11MB1886D080DDCF9B50CBDEAEEA8C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401114648.GX1463678@nvidia.com>
 <BN6PR11MB406858FAC3821B84CCC4D30DC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401131533.GD1463678@nvidia.com>
 <BN6PR11MB4068C1A040FF61B4A9ABBD9BC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134641.GG1463678@nvidia.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b5ec106-c7d9-4e0c-4e5c-08d8f5be51aa
x-ms-traffictypediagnostic: MWHPR11MB1472:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1472E31479201BE48CDB3CF78C7A9@MWHPR11MB1472.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H1ILzkatdNufeMSV504M++a36u2GhUna9JsyPuSv25ZTP7ISaOSwAyTLjyqi+NW/K6GpTtvaAqQk4mPpYMHwIqoVeAnu502Zc+FpQHc3dxsdkN9breFCy8crMmlse+ougmDAl3O4jyLtU+USS2pN2RHd1xBT/Nmew70Y1lcC+QD+zz3xxoE2FJNDbphirzEhsaJj0KGoZ230coZft/2iuZ24czToaiRjpNiC6qzpxRcu5NKaFN/fcMeSl0g9l81rW0OFOlbnHUH2+4Yks2pPhap5uZKVI+FdY0JKHwldj5Nfz4xo5RTwk6ViT2WK+w0VVNQeBVC/bWdN48XJNWB70+EZBh2Q6K0IA6KZunM7psjl/ol63BJYoJ7kUlXr2zYBx4OgshwYb0MWpC5f2c42sXy48oj+H2mQd4srSlPNC4lDSwTmriWxzQnf/IJMDpFv5sai3pmvTVMxR5DApxah6/nt9OHMBiBzjV6JxP2zk1y4OvN29LvgtfkuQkYa/c2vILSDG7zAzIad5LJoLuo/owm4sfeaU91woa+K54apGLR+lbIKwYphsgTfBBHhqAsnNKJpwLRGjYiXz5D373kvb+o2mMtLEI/SmLr1vkDh4rgB1QH23zXdxKc/hqGdb39r+Lt5jr9lTON7kV+XUvshG754gZ1pPIJtv7/hNj4yV2E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(5660300002)(33656002)(8936002)(54906003)(76116006)(38100700001)(316002)(71200400001)(7696005)(478600001)(110136005)(66946007)(26005)(55016002)(4326008)(7416002)(83380400001)(8676002)(86362001)(66446008)(64756008)(186003)(2906002)(52536014)(9686003)(6636002)(66556008)(66476007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8voTeBcwRMh5pdO2c8O9YLddNnNFmj+VuhqEn32/uNxlPl5+5fxjQjPFseXp?=
 =?us-ascii?Q?gPfX66XhC39yrD6T3/fvu/aIl/gity1uXOTt3w3dTx1zZw6c+AKd3czNHype?=
 =?us-ascii?Q?CMS3uDuJCSRCVUAbpNzwG6quRz4DiDjxtbF7jSMThC801ZbBDhON4WAQOVqC?=
 =?us-ascii?Q?ZjaaCTGMpTMy6WwBgAMeQPzWCEyPqYBxq9gTKYSy/uMtI4NQeaka1lc+vVqe?=
 =?us-ascii?Q?a2CzmBM8d3VMett1WD1lkMnrAagWFPI2COJfKZ8IG4+qGUHvFF/l3SWE1Xeg?=
 =?us-ascii?Q?k9immBHxBBDJlgOyo5z7cuCZieMcW72/HInnEsVZMIAskmhSUaDXRRVLzfcr?=
 =?us-ascii?Q?U+Ew6LnTv0Bk03oD29WVzpxxM2kykpi4LX1UcMv2Igzkb5DcLlwL+fGoqobF?=
 =?us-ascii?Q?nEo6FBd0da9eOa6mO2LKMLUZS+0XrD8rkkLE45QAPlfcGb+jOrUbGeinrPM4?=
 =?us-ascii?Q?22JaBgTiM4eIugsmjqBmrFtnjvOu2nyz7K1+l7WLSnT9twW+YMuLrkccb4pq?=
 =?us-ascii?Q?DUj4BteZt9E4g9ti8UD8QO7GlIcLa0fQwEwtf70JidAxgsfrOYWL4yW8vher?=
 =?us-ascii?Q?dJMwcDBggfbcaVGvZyZ7FR6pOa1CxihVVWaAzAlRf9rihxy4NOyoEehLPe/u?=
 =?us-ascii?Q?Enyu7PT4iO1RMzzfyvyEtQVsvyyWJjpbVxnky+oeKX7FCR+JfEj/60yd2hZx?=
 =?us-ascii?Q?j01lKV1lIaRlRhkd7RSeu+g2/1fBvDv8FGyMaoNi290DD+3df7R/8bLOQpua?=
 =?us-ascii?Q?TLM5Ukxw/H1FlssaPiOnj2vALXEScr8FAlPstmGmbfBVlUE3Qa2LSjlBh26d?=
 =?us-ascii?Q?bKsB8IGLqN3cQDtEpQH8qA5+9uhoSXPyGEkPOssV7eK9xNEHvzmToFPy/ikJ?=
 =?us-ascii?Q?RnChV6bzgSN+F9GiPsMkaKVCFFuxk56S46HWrcL9xJrog7FQfhfqxMd3L0GK?=
 =?us-ascii?Q?sHqqhPczueuKoMM1BDLvCkN6pyJeO/6H/UPzwmD95cBhyyZl27aVlafL/881?=
 =?us-ascii?Q?MwRiFp6padrgj6QvWDQbT4096V5UJOU8n+KkRDYMAjwNFSfPtjxrXzym9jD+?=
 =?us-ascii?Q?0Cedj/JgMnBj9JysKpki7F24b6XeYEFT5hpKEUxDFRWri7yyfkJSGQKNLSNR?=
 =?us-ascii?Q?u/bScEmO2LQPTJlvbsFndwocDCwLueiPXJWKTVKtXE+CzNPY5s0FPiFfb3Yn?=
 =?us-ascii?Q?bqo01HGXsr/aGNAjMJhas5xAScaPXYI5E4if+/AdMUnN3VjHxteZ7WwQ5Gjv?=
 =?us-ascii?Q?K3RFwPoPqZq8jR2Kbh2VU2KqXKxMwa/7y6EDOPorY47LsfRzgIQpnNu8nBAV?=
 =?us-ascii?Q?dFL8weTFb+bOZjChr4bTEDEa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5ec106-c7d9-4e0c-4e5c-08d8f5be51aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2021 10:01:43.3793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Qop+08KwgIUDWQV9lsTwSHXjoYoiWoErdX3N/2FamSVAVZmB6eJU4dGpnCMDbMFAiTPxsRwzu0e+y+ZQLXcLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1472
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Tian, Kevin
> Sent: Friday, April 2, 2021 3:58 PM
>=20
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, April 1, 2021 9:47 PM
> >
> > On Thu, Apr 01, 2021 at 01:43:36PM +0000, Liu, Yi L wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Thursday, April 1, 2021 9:16 PM
> > > >
> > > > On Thu, Apr 01, 2021 at 01:10:48PM +0000, Liu, Yi L wrote:
> > > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > > Sent: Thursday, April 1, 2021 7:47 PM
> > > > > [...]
> > > > > > I'm worried Intel views the only use of PASID in a guest is wit=
h
> > > > > > ENQCMD, but that is not consistent with the industry. We need t=
o
> see
> > > > > > normal nested PASID support with assigned PCI VFs.
> > > > >
> > > > > I'm not quire flow here. Intel also allows PASID usage in guest w=
ithout
> > > > > ENQCMD. e.g. Passthru a PF to guest, and use PASID on it without
> > > > ENQCMD.
> > > >
> > > > Then you need all the parts, the hypervisor calls from the vIOMMU, =
and
> > > > you can't really use a vPASID.
> > >
> > > This is a diagram shows the vSVA setup.
> >
> > I'm not talking only about vSVA. Generic PASID support with arbitary
> > mappings.
> >
> > And how do you deal with the vPASID vs pPASID issue if the system has
> > a mix of physical devices and mdevs?
> >
>=20
> We plan to support two schemes. One is vPASID identity-mapped to
> pPASID then the mixed scenario just works, with the limitation of
> lacking of live migration support. The other is non-identity-mapped
> scheme, where live migration is supported but physical devices and
> mdevs should not be mixed in one VM if both expose SVA capability
> (requires some filtering check in Qemu). Although we have some
> idea relaxing this restriction in the non-identity scheme, it requires
> more thinking given how the vSVA uAPI is being refactored.
>=20
> In both cases the virtual VT-d will report a virtual capability to the gu=
est,
> indicating that the guest must request PASID through a vcmd register
> instead of creating its own namespace. The vIOMMU returns a vPASID
> to the guest upon request. The vPASID could be directly mapped to a
> pPASID or allocated from a new namespace based on user configuration.
>=20
> We hope the /dev/ioasid can support both schemes, with the minimal
> requirement of allowing userspace to tag a vPASID to a pPASID and
> allowing mdev to translate vPASID into pPASID, i.e. not assuming that
> the guest will always use pPASID.
>=20

Per your comments in other threads I suppose this requirement should
be implemented in VFIO_ALLOW_PASID command instead of going=20
through /dev/ioasid which only needs to know pPASID and its pgtable
management.

Thanks
Kevin
