Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CFA354AC1
	for <lists+cgroups@lfdr.de>; Tue,  6 Apr 2021 04:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhDFCIu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Apr 2021 22:08:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:7906 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232976AbhDFCIt (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 5 Apr 2021 22:08:49 -0400
IronPort-SDR: pUjGu9N+JrS2vkpBSc+XBacdoPMLH4qIDtB9dHiSw8g8Lt2iiPt0DyVOnWAlAvOE9MC0mzAv1q
 mcjsjA2K0QIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="180093453"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="180093453"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 19:08:42 -0700
IronPort-SDR: TnHB3UOF9r4HVeMC9F9M9m+eCpkzPk8bZFEAauvbM25AHRiseiHPzFmVQI/RVZs/dl+VerzAAC
 jwVow7gkOTWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="597767424"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 05 Apr 2021 19:08:41 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 5 Apr 2021 19:08:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 5 Apr 2021 19:08:41 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.58) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 5 Apr 2021 19:08:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfC6XhGscMn2pdA0v/joAYdS51dvO+zOMB+PjRmhL0aE1GPxJqJdQMXPwz4ShESYWTCaCKyl6MA+zDktGUEeMF16aV7K7Xw2WY+IZz/qTpYt7DzXANNqMB4ySH56vu4tzjmkDc2nshKV6wle+QK5BlwEj058Xv2g0GRSlV/YMg/TUW1WoyInDS1/07srVvRhCEjBr02R/gcDcTN1eGe+TXTuRuNUgKxnN30X6ZDKCTy1h9tcgtWyg7wwAjfKh/HOkIfsd/LqPx20PsuFkVZx13W+YCra9kh0nLH77N9mZ7UP7ml0y54v+zAM+Vwl6rkTgM+K5LUvNO7kZdVkjecsLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJ+qzGDPaPVoZR1d7nDWgjZHHPys2puDxb2bS7JmC+k=;
 b=g/8nb9gBz4+NvtuZGplmpqNWlC+yUiwDu8clOoJjtPdwOer5CKX33PSVJ8ry1eOJbRNvhOA+FdA1jA87hJEkzawOhuRaxRAdmR42V23TZtS5eu/QQfG/ODAxImmGDX9wbis8u/9tc0UMv/KOXl6JuvN4NWKQQ7506tKq5gKVX3t4bwb/BBNDCfgF/+KJsRQBLRzCGlC2pugKsOgEDcmUMrgWWtJ/5BNaPDk6H0DJ9gNssQo+kIjdegTl8sWxvbP2bOzOIbVL3QjGGxefw+1YhaYVbj2IPs9EzerAPhHUDsIBtMG4bC5H5RftKr2WpQ2W+sPIfq1T8yfZgJgQig/HeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJ+qzGDPaPVoZR1d7nDWgjZHHPys2puDxb2bS7JmC+k=;
 b=XSuKjDnkD4m+EGBuDnfX3Qfo48yh0c6E+4a1/qMeGk7YTKbt6rqSITdyZ6toh5EIPB4hu9n8mtvk3x8VPdjYXwnMPbn78zYri/bl5zU9+iYml/BnU4lXfyeV7NL3yTY0FGPQPlr59QcyjKTBhrzj3+adcw48i2hospD68xLj7pA=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR1101MB2126.namprd11.prod.outlook.com (2603:10b6:301:50::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 02:08:22 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 02:08:22 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
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
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAAHeZAIAAF3gAgAABVICAAAfXAIAAANyAgAEpdBCABcWUAIAAEDLQgAAWYxA=
Date:   Tue, 6 Apr 2021 02:08:22 +0000
Message-ID: <MWHPR11MB18866B20CEDEE868D428AE228C769@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401114648.GX1463678@nvidia.com>
 <BN6PR11MB406858FAC3821B84CCC4D30DC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401131533.GD1463678@nvidia.com>
 <BN6PR11MB4068C1A040FF61B4A9ABBD9BC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134641.GG1463678@nvidia.com>
 <MWHPR11MB1886C0804A0240998C110EE58C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405233946.GE7405@nvidia.com>
 <MWHPR11MB188628BDB37A4EE36F3D99338C769@MWHPR11MB1886.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB188628BDB37A4EE36F3D99338C769@MWHPR11MB1886.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 018d1a88-b505-4ed7-90b2-08d8f8a0db1f
x-ms-traffictypediagnostic: MWHPR1101MB2126:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB212681B68498E138B8C9408C8C769@MWHPR1101MB2126.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uW3X4r8a7SGNzpeBQjRHCrBErOJMOVmg4RSP+s5WBbADg7EZ4rzhboEwv12RK3ZyOQOsakJ6liKmDXojeN3h1B7S063LiK4FPUaAHBe+tGeM8ey/kxiqjPIyBuQKGL8Q2jTRto3skVjHV3RxCuSLRlZrerczWx2B72Xy4o369iWQctovyKv3UnG0+wQBMCFe+tn9sHNxjerD8sci/gED3taBDDmDkWmpPv6aNhz7w1AmzUkJkHGLzZiRM0jUp7sB2VEtiMJXXuS5y3IIhBiVT7dvbzMFWWcCMIaOPDicfc+w2jo4ITe0gLNvE3YQhtRhvwebx+d5nk3H4V6U0di9YaNfY9erXZjt2dlFIb+DKjHTmnLDrawZd16GL14lP+p/U/Fu4O2498j7VYoW8Dw6tfb6bvFa3H7+KWI3OgmS+G5QFj2n0zmhFdoMVS9sETgH6caDDzHv6k3HrBOj9E7ZicdBLL8zfaT7uHdHhPRwf/yJihDqVmj7YxRz7DT8eIbkdfebUrDJCICF1Rb76RbSqtKwQF/5sVh9FpX3PNhz0j322r8BrXrk+ojFNwsa0QVcngFnQKerD/bXN6L0t/CuvpuJiihoA/WPI5SurzTQIIKp5zadj+kmP+Kp4qgbQBB+GCgsiSZ8HeToGzFyOZh7qu94HGirZGQBhG90tSN0grw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(396003)(346002)(136003)(7696005)(26005)(4326008)(52536014)(38100700001)(66476007)(6916009)(66946007)(316002)(8936002)(55016002)(6506007)(86362001)(9686003)(76116006)(186003)(83380400001)(54906003)(2906002)(33656002)(478600001)(7416002)(71200400001)(66556008)(5660300002)(8676002)(64756008)(66446008)(2940100002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?juSOh3pD9wNc0Be0Oh5Q6cpNIzIm456gH6/6cHYb0QWswmcQLcoboqwDMBNX?=
 =?us-ascii?Q?4UmWB+3RspyBiGfDM+5Ja9Cqg2uWZt302OPxbHxzFF3shyViaN4N+AHAyB8O?=
 =?us-ascii?Q?2nX2wcyg/5JsYshYcpvLRXoGX10SXGn9x2uJqQBY/G5pONfrWCbRApdcLSOL?=
 =?us-ascii?Q?K51z2kmBtsLpkbVNbuUjYAmJqfQLsvpdFfJXxzW6wemFrNvs+hyDGOhFZ5ml?=
 =?us-ascii?Q?sxZrEFkPdJzv22OseD6xKFbypaeWZXbowNSGM77ePhr0w+lHILle6vou9kfa?=
 =?us-ascii?Q?3KSSut3O3fqXHOaKUMQq6GalUgpGXaTVm+n8YfhdqInCRZSRFqpOi6vrrZfT?=
 =?us-ascii?Q?9KHaPAkCMcqzrxvNRUHmu/IFaXxfQjlNJrN8E0XBWEgd0pAOO6eSCRVRyPYh?=
 =?us-ascii?Q?X5P2oAqwh59MVoH/Yy2ha2o5hLgAMS+VHVjit1vgxV18yDyX+o2e3ji/jTMj?=
 =?us-ascii?Q?/O+RPOvxdfUTjqJ22EpzuQlHhtVnCdr4O8jrRDs6cS1Dj1okT17VPXsTFy7a?=
 =?us-ascii?Q?4Qzh7/swtQ3Vt0MLL28i6XkEO02Gq4yI60xVeGVxVyrkWlehKNa3geTv1JWd?=
 =?us-ascii?Q?GpNUv9p1AI1QpQLx00I6Yz9O7onq4IZhYhDyXMwPgiYwLMC3ELyli7YtArgL?=
 =?us-ascii?Q?ga6GoKWdeBrpWD7pl2/X8yYvAF64lYdKe8kW3bY4E0+B5/YHeyX852CPLdKs?=
 =?us-ascii?Q?ti3pOEWH+MtLG54HPZAYftH75ByLykEf6/A7suSMCVRwztnuahqESDs6Ckpb?=
 =?us-ascii?Q?s50zDVGeMVyZ4jJJtKIjSLSFtFIhtPdTz1iPikQJlX4IyeMjig9KbRTgrPiT?=
 =?us-ascii?Q?xEkKNMzONd7+Zo5qqKVRnTkBXNfiptWoXviIlBg4nYs7V2TSCVPQjo923aGO?=
 =?us-ascii?Q?g3mqSZr6nhCoqWQKo6ZwEBkWUp3717T1OmJTk6IVqJOHDeo+H9PoioVwEowR?=
 =?us-ascii?Q?WaQnUafYdYYnr7wy0Vn/+Es0/0d57VOgYjrW8WSHg/GtMGc5u5CjIIQazOWb?=
 =?us-ascii?Q?iWIy9W+4xHqSq63HUpGQfd4U06I9wc052tV5j8Jb2RUM6PkU+FVLfLRIr0rk?=
 =?us-ascii?Q?DTBeMPpBp0w+jXqznmlThANepyiv3pl8VIGi04i/vi7BR8ySShbAn/FOlVCY?=
 =?us-ascii?Q?MMRKfJUktWgZM1mYj1/6dYkIaYRgylgJW+Hw2UiESnHApqcg4KAijgdff79o?=
 =?us-ascii?Q?VZVyWPfFQfpTcFIKl5/pyraz8nNksw4wXQSP1sUsoSmBV/78YhhC2AtPjc/n?=
 =?us-ascii?Q?EwFwXregizupjV3KGR9ZOGhuouNU2PKGajtVu4KAYcDDkmu9c7T0pp9e9Www?=
 =?us-ascii?Q?ehiV03bQ9xyBbVxoGhfxjcPm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018d1a88-b505-4ed7-90b2-08d8f8a0db1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 02:08:22.5810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Na0P76ojx6cG/4kl1GIbRp0FBZFYuYAaEH1BBrG52PYIDLsqSzMxgY8Li24kea+6xPTSHNqa3FlpWDhOQNa4Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2126
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Tian, Kevin
> Sent: Tuesday, April 6, 2021 9:02 AM
>=20
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, April 6, 2021 7:40 AM
> >
> > On Fri, Apr 02, 2021 at 07:58:02AM +0000, Tian, Kevin wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Thursday, April 1, 2021 9:47 PM
> > > >
> > > > On Thu, Apr 01, 2021 at 01:43:36PM +0000, Liu, Yi L wrote:
> > > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > > Sent: Thursday, April 1, 2021 9:16 PM
> > > > > >
> > > > > > On Thu, Apr 01, 2021 at 01:10:48PM +0000, Liu, Yi L wrote:
> > > > > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > > > > Sent: Thursday, April 1, 2021 7:47 PM
> > > > > > > [...]
> > > > > > > > I'm worried Intel views the only use of PASID in a guest is=
 with
> > > > > > > > ENQCMD, but that is not consistent with the industry. We ne=
ed
> to
> > see
> > > > > > > > normal nested PASID support with assigned PCI VFs.
> > > > > > >
> > > > > > > I'm not quire flow here. Intel also allows PASID usage in gue=
st
> > without
> > > > > > > ENQCMD. e.g. Passthru a PF to guest, and use PASID on it with=
out
> > > > > > ENQCMD.
> > > > > >
> > > > > > Then you need all the parts, the hypervisor calls from the vIOM=
MU,
> > and
> > > > > > you can't really use a vPASID.
> > > > >
> > > > > This is a diagram shows the vSVA setup.
> > > >
> > > > I'm not talking only about vSVA. Generic PASID support with arbitar=
y
> > > > mappings.
> > > >
> > > > And how do you deal with the vPASID vs pPASID issue if the system h=
as
> > > > a mix of physical devices and mdevs?
> > > >
> > >
> > > We plan to support two schemes. One is vPASID identity-mapped to
> > > pPASID then the mixed scenario just works, with the limitation of
> > > lacking of live migration support. The other is non-identity-mapped
> > > scheme, where live migration is supported but physical devices and
> > > mdevs should not be mixed in one VM if both expose SVA capability
> > > (requires some filtering check in Qemu).
> >
> > That just becomes "block vPASID support if any device that
> > doesn't use ENQCMD is plugged into the guest"
>=20
> The limitation is only for physical device. and in reality it is not that
> bad. To support live migration with physical device we anyway need
> additional work to migrate the device state (e.g. based on Max's work),
> then it's not unreasonable to also mediate guest programming of
> device specific PASID register to enable vPASID (need to translate in
> the whole VM lifespan but likely is not a hot path).
>=20
> >
> > Which needs a special VFIO capability of some kind so qemu knows to
> > block it. This really needs to all be layed out together so someone
> > can understand it :(
>=20
> Or could simply based on whether the VFIO device supports live migration.

Actually you are right on this point. VFIO should provide a per-device
capability to indicate whether vPASID is allowed on this device. likely=20
yes for mdev, by default no for pdev (unless explicitly opt in). Qemu
should enable vPASID only if all assigned devices support it, and then=20
provide vPASID information when using VFIO API to allow pPASIDs.

>=20
> >
> > Why doesn't the siov cookbook explaining this stuff??
> >
> > > We hope the /dev/ioasid can support both schemes, with the minimal
> > > requirement of allowing userspace to tag a vPASID to a pPASID and
> > > allowing mdev to translate vPASID into pPASID, i.e. not assuming that
> > > the guest will always use pPASID.
> >
> > What I'm a unclear of is if /dev/ioasid even needs to care about
> > vPASID or if vPASID is just a hidden artifact of the KVM connection to
> > setup the translation table and the vIOMMU driver in qemu.
>=20
> Not just for KVM. Also required by mdev, which needs to translate
> vPASID into pPASID when ENQCMD is not used. As I replied in another
> mail, possibly we don't need /dev/ioasid to know this fact, which
> should only care about the operations related to pPASID. VFIO could
> carry vPASID information to mdev. KVM should have its own interface
> to know this information, as you suggested earlier.
>=20
> Thanks
> Kevin
