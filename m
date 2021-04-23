Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13415368F2D
	for <lists+cgroups@lfdr.de>; Fri, 23 Apr 2021 11:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhDWJHb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Apr 2021 05:07:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:45789 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230007AbhDWJHb (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 23 Apr 2021 05:07:31 -0400
IronPort-SDR: 0pLZsJb3EoRPAxpA8dQRhTjfG9YxVmKEVTHDpGBd+vOpcCv8xyXh7GxkBDvpzgyX4JFQnxiQDH
 TvPsoba3TGmQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="192851771"
X-IronPort-AV: E=Sophos;i="5.82,245,1613462400"; 
   d="scan'208";a="192851771"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 02:06:54 -0700
IronPort-SDR: c+yvmujciFt6g/xKocRTY9Jy7nPkPmiiqv7GAu2eTfV/6Hv5wWH2VVgYQtQMFAg2bDmNE2p9gl
 XvWJEjqvZXYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,245,1613462400"; 
   d="scan'208";a="424181497"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga007.jf.intel.com with ESMTP; 23 Apr 2021 02:06:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 23 Apr 2021 02:06:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 23 Apr 2021 02:06:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 23 Apr 2021 02:06:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UO9RgjiMRhUe3dOdO8QovTXLIUMkcLx9CHlhb0UGQGQqqFwJMRo7YsrqE8S2fxSdcDoBPftAWQVI+OclzITPsMTlSrDKjxwnmHqzyI9lqyQPIGttYa07nU56+f19RuK+6B/QrOIlNqV+f//JozL4kWiWpheuKuaMSZIxcTF9YkUL+3zsTrg0bcGjpbsOf8oqM9S4oZX736sU0e/rdc/mLzpu2UvZ3DjBYFUW1UsiBspUid50sVt/Gw4S3rlQj032UvqLEdKgDHpyA+4clSQ7ffLv+rg2eLXTEzJxkX/jazyp73877my6pbvuagBsGIDa0VydaBeiMbq7+Q7SrA4HrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZY/fsiSco6i483sTBPZUc1lvSlDhpfwkAWclbYetwIU=;
 b=WP1XECfe/rr4T4wu/lY1Inbnod8xvufqQm0ytZC71XZU+1XDAluA4EtQwVF/NPBGPtOUzmJzI60NBbxT2usWnm9hg9kuP5K3KTbsEd14OPWQfOENgGeWoH4qGhuz8o9GRm1uIYCthNwWBM8ZQMQKxp2l6/YsJa5keKd9uUQ7yg1pLIJmLgZ5l3i2R5rIwDji0v/WIMGgfU6dpWylu6i4Xulx+LBpZ57dFqYtckgyDCTF+AGoksz+ho4asHN9iUk85jhVf5cBuDJmEwp13UGVWZZohjuABq1hFIE+a+FNUZeMVV+8nilyGIHldrzsY52dT+mdr6BekHwLMLi/IwyjWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZY/fsiSco6i483sTBPZUc1lvSlDhpfwkAWclbYetwIU=;
 b=YcIzM+HCHEbybzrsmwXq6+AKyobvUYWj+NycfZlTiSWBoX7F0Yde0GVE1yKg2J2ugLr6/5XUGbIeeNNqYnF0kyuF48+qgZwytd9FnWwrap8IjmrxxWIvwUMBunPDDYshYma03UZBGaSqz+lVMbhq8NBZ4ABra5SRUlUaK3rzfIk=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB5043.namprd11.prod.outlook.com (2603:10b6:303:96::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Fri, 23 Apr
 2021 09:06:45 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4042.026; Fri, 23 Apr 2021
 09:06:45 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Auger Eric <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAACiXgIAAVBgAgAAaMwCAAAESAIAABy2AgAAgOYCAFdCAgIAAppUAgADsNgCAACqygIAHsmaAgAAzsYCAAAjdgIAAD/yAgAAcQgCAADqggIAAk6nQgABIUACAASsnkA==
Date:   Fri, 23 Apr 2021 09:06:44 +0000
Message-ID: <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210415230732.GG1370958@nvidia.com>
 <20210416061258.325e762e@jacob-builder> <20210416094547.1774e1a3@redhat.com>
 <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210421162307.GM1370958@nvidia.com> <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com> <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
In-Reply-To: <20210422121020.GT1370958@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2384bf6-f38b-412e-b200-08d906371e70
x-ms-traffictypediagnostic: CO1PR11MB5043:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB5043FDAC0BD90BFB44CFD5EA8C459@CO1PR11MB5043.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zMo4hXnlLMaC7bdYgfg685gYUZla+0nxbt/34Ffn7U7+LhzsKhxurVGDdeSND8CpRi5wljxW7MWHzuyGwV97e1K6ePg2ScHmC8yU1Fqg1xiW+9xXjW25kcVTD84gZ6JH8l2E4sq03NxqGlN9N7il5QzfK6Q59YtJ2j48D4h1p3/nMGqVdGKN8osTCyo+lYpw0ieS+jllGhkdgwdOY2UX/4qXmvcqvi24mstomuj0NrtKSr4JCX3kbRBgePHbGINIjfIyfhNF4fHy/DTxD4Zva6wwAf+BEqyJM3kkCXsZhwyFZOJVG2GA+tbVySQlDjQg3oeLyzb44+poRj6Y5XCJH+kmyxXK/oDVWsXHzByWya5+r7ofYk94TcBlyixgwsp6eViFrT4/FS1YRJ1J9kYzDPZ8ccKy8zt0anOskdPgv/LNP5So1NCEp4xec8kIRWg22+C2+2V/JQWSDQHQ9iNtEov8J99MsYyiXoS5+9r8bXllv30nKiYhQjG/ezi3Hnkbty5VAMqAQi3AsPal2eazEd06pdbrh3GswtjNTZSN72z6FklT4pnczrmD58S5d3DQH6ZaQ3qBJ9j78lTUhE7HTxSCGUAR6/RNYw4+wGx1YvE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(396003)(346002)(376002)(7416002)(122000001)(6506007)(55016002)(9686003)(86362001)(2906002)(4326008)(66446008)(64756008)(71200400001)(7696005)(38100700002)(76116006)(6916009)(8676002)(66556008)(66476007)(66946007)(52536014)(8936002)(478600001)(54906003)(26005)(316002)(83380400001)(5660300002)(186003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?X0H5G+k802zDFlMImClOAR2u+3Pti1tpisjU/bwPaiqitMjOirnE9rG8ColS?=
 =?us-ascii?Q?BvauLr7CynSGeu0PBelF3v1SpPwLKX8I114Hs3g855BmL69cbkHSohwXFGsT?=
 =?us-ascii?Q?wF1x9gWqownduKngMaar4TbVN7gUpq3wlpPWK1MHzyt0inxPtTIGG7dY4CQM?=
 =?us-ascii?Q?bOJ3x1pLDKATHwWQsliT1eqhUNlSw33gsmSrCMfPXwxT7SaVc+zFlWreMJ6u?=
 =?us-ascii?Q?e2LMdnyPyU5RmGj8cbtgka1oPP0jeRIR7oZqU3NTzZjx/Y13xc/eBfxt6k2M?=
 =?us-ascii?Q?hrvLVTkWrMLvxLPZ8WNCJ+tBKTjW6/R9ZCp+mYN15mV41c+Z1oiVjzSaBogu?=
 =?us-ascii?Q?QHzt/B3ztVfyy4U00vPoLskd0mfrlDj17BbbTmRoXJ74wtAoVgxDm2YDnFFi?=
 =?us-ascii?Q?RCJea/wxdhz6PE8CoDzHeJ2rlx2m1Sc54UfY247RBnFTYAEaJLINPCfz1/Cu?=
 =?us-ascii?Q?lCzUlpjvkdMAxn92J/KOgXKW6So39WRqgq3NJWXprAXjs8TymyH3s/bcfAzN?=
 =?us-ascii?Q?5kmlywlM1gcZkkSWTgTFmQJtJBdMMURmUm5UVFiIzoTBEP5aAJkIFzY/t5FI?=
 =?us-ascii?Q?TVXaStym+j/ydWPCWi8mI3xB4gigap8Xc4S9pwIHW7+WMNv7fZVr5LVY7HsV?=
 =?us-ascii?Q?mrSC+FNoRfEKWqyQdD1Whl3Lyspkz90XAyAGIrruHYMFp1hGwPb8SMCB5tfY?=
 =?us-ascii?Q?xHCv4a1hlmrOqvTI7FKbtkVBAkcWX+XsUIV46jAap78ZXlP/vzIiAijJETxG?=
 =?us-ascii?Q?/8zj5AN4eeyDxerl4PAtCA4OwlZQT1/wVpI5dMmMgl9AJX8FCCK8hBw+k2ma?=
 =?us-ascii?Q?C9IUYF63jXjB4OhtmuWO5Pw/eBCWaCPPdYSvqaBoNAsoUKGOSD9VE2/Tu/aO?=
 =?us-ascii?Q?Mo+A3iEKwbrelmWWPXcF/xpBKIUJaJSD/BFJOcMac4U7b0e+dC1Uw8Gd7Z1i?=
 =?us-ascii?Q?xWERA0Dd3IQ/jPxxDJIGPA5yfXfg83IYyEIeQTR1oR/K5D8e3/cQlmXlasKd?=
 =?us-ascii?Q?FqxQhCPx0p6/wx0wkw29qt3Ls8kWCES5htGcsx2VFwO6IxUEaw51VAw+DLXH?=
 =?us-ascii?Q?Q7PuJOEPLBt1HjvUuyZcbqY/u3kh5a3wDMh2BJ0gLoJsXrvOa2Rs6IIXlaaK?=
 =?us-ascii?Q?sBfVKtcYyb7r8PBedGX/1m9MYapmJXMyANX34paM2UvqA7V7/+zlfr4tq3HK?=
 =?us-ascii?Q?2PcVuPD/B1yQKTOjvHMXZTPv+TVF2vRyFvPfcugL3NxtgBrG5kBAwraval3m?=
 =?us-ascii?Q?pbPAC+pe1HMuQWQpZEn2PJdn2QTKqfEQ91Mz9FVYMZAjLZhDA5IR0htZE8wn?=
 =?us-ascii?Q?akwR1FEUIRsAScVT7Kh/YFXD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2384bf6-f38b-412e-b200-08d906371e70
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 09:06:44.7758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mvfxkedzbCixvtep2c+sc643tQGkqkD11bGWioBpmeDf8lpeD27C1fVzdkOv4qrDyhTiB0YvvlTh9jcqgKZk+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5043
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, April 22, 2021 8:10 PM
>=20
> On Thu, Apr 22, 2021 at 08:34:32AM +0000, Tian, Kevin wrote:
>=20
> > Another tricky thing is that a container may be linked to multiple iomm=
u
> > domains in VFIO, as devices in the container may locate behind differen=
t
> > IOMMUs with inconsistent capability (commit 1ef3e2bc).
>=20
> Frankly this sounds over complicated. I would think /dev/ioasid should
> select the IOMMU when the first device is joined, and all future joins
> must be compatible with the original IOMMU - ie there is only one set
> of IOMMU capabilities in a /dev/ioasid.

Or could we still have just one /dev/ioasid but allow userspace to create
multiple gpa_ioasid_id's each associated to a different iommu domain?=20
Then the compatibility check will be done at ATTACH_IOASID instead of=20
JOIN_IOASID_FD.

This does impose one burden to userspace though, to understand the=20
IOMMU compatibilities and figure out which incompatible features may
affect the page table management (while such knowledge is IOMMU
vendor specific) and then explicitly manage multiple /dev/ioasid's or=20
multiple gpa_ioasid_id's.

Alternatively is it a good design by having the kernel return error at=20
attach/join time to indicate that incompatibility is detected then the=20
userspace should open a new /dev/ioasid or creates a new gpa_ioasid_id
for the failing device upon such failure, w/o constructing its own=20
compatibility knowledge?

>=20
> This means qemue might have multiple /dev/ioasid's if the system has
> multiple incompatible IOMMUs (is this actually a thing?) The platform

One example is Intel platform with igd. Typically there is one IOMMU
dedicated for igd and the other IOMMU serving all the remaining devices.
The igd IOMMU may not support IOMMU_CACHE while the other one
does.

> should design its IOMMU domains to minimize the number of
> /dev/ioasid's required.
>=20
> Is there a reason we need to share IOASID'd between completely
> divergance IOMMU implementations? I don't expect the HW should be able
> to physically share page tables??

yes, e.g. in vSVA both devices (behind divergence IOMMUs) are bound
to a single guest process which has an unique PASID and 1st-level page
table. Earlier incompatibility example is only for 2nd-level.

>=20
> That decision point alone might be the thing that just says we can't
> ever have /dev/vfio/vfio =3D=3D /dev/ioasid

yes, unless we adopt the vfio scheme, i.e. implicitly managing incompatible=
=20
iommu domains in /dev/ioasid.

>=20
> > Just to confirm. Above flow is for current map/unmap flavor as what
> > VFIO/vDPA do today. Later when nested translation is supported,
> > there is no need to detach gpa_ioasid_fd. Instead, a new cmd will
> > be introduced to nest rid_ioasid_fd on top of gpa_ioasid_fd:
>=20
> Sure.. The tricky bit will be to define both of the common nested
> operating modes.
>=20
>   nested_ioasid =3D ioctl(ioasid_fd, CREATE_NESTED_IOASID,  gpa_ioasid_id=
);
>   ioctl(ioasid_fd, SET_NESTED_IOASID_PAGE_TABLES, nested_ioasid, ..)
>=20
>    // IOMMU will match on the device RID, no PASID:
>   ioctl(vfio_device, ATTACH_IOASID, nested_ioasid);
>=20
>    // IOMMU will match on the device RID and PASID:
>   ioctl(vfio_device, ATTACH_IOASID_PASID, pasid, nested_ioasid);

I'm a bit confused here why we have both pasid and ioasid notations togethe=
r.
Why not use nested_ioasid as pasid directly (i.e. every pasid in nested mod=
e
is created by CREATE_NESTED_IOASID)?

Below I list different scenarios for ATTACH_IOASID in my view. Here=20
vfio_device could be a real PCI function (RID), or a subfunction device=20
(RID+def_ioasid). The vfio_device could be attached to a gpa_ioasid=20
(RID in guest view, no nesting), a nested_ioasid (RID in guest view, nestin=
g)=20
or a nested_ioasid (RID+PASID in guest view, nesting).=20

// IOMMU will match on the device RID, no nesting, no PASID:
ioctl(vfio_device, ATTACH_IOASID, gpa_ioasid);

// IOMMU will match on the device (RID+def_ioasid), no nesting, no PASID:
ioctl(vfio_subdevice, ATTACH_IOASID, gpa_ioasid);

// IOMMU will match on the device RID, nesting, no PASID:
ioctl(vfio_device, ATTACH_IOASID, nested_ioasid);

// IOMMU will match on the device (RID+def_ioasid), nesting, no PASID:
ioctl(vfio_subdevice, ATTACH_IOASID, nested_ioasid);

// IOMMU will match on the device (RID+nested_ioasid), nesting, PASID:
ioctl(vfio_device, ATTACH_IOASID_PASID, nested_ioasid);

// IOMMU will match on the device (RID+nested_ioasid), nesting, PASID:
ioctl(vfio_subdevice, ATTACH_IOASID_PASID, nested_ioasid);

>=20
> Notice that ATTACH (or bind, whatever) is always done on the
> vfio_device FD. ATTACH tells the IOMMU HW to link the PCI BDF&PASID to
> a specific page table defined by an IOASID.
>=20
> I expect we have many flavours of IOASID tables, eg we have normal,
> and 'nested with table controlled by hypervisor'. ARM has 'nested with
> table controlled by guest' right? So like this?
>=20
>   nested_ioasid =3D ioctl(ioasid_fd, CREATE_DELGATED_IOASID,
>                    gpa_ioasid_id, <some kind of viommu_id>)
>   // PASID now goes to <viommu_id>
>   ioctl(vfio_device, ATTACH_IOASID_PASID, pasid, nested_ioasid);
>=20
> Where <viommu_id> is some internal to the guest handle of the viommu
> page table scoped within gpa_ioasid_id? Like maybe it is GPA of the
> base of the page table?
>=20
> The guest can't select its own PASIDs without telling the hypervisor,
> right?
>=20

If the whole PASID table is delegated to the guest in ARM case, the guest
can select its own PASIDs w/o telling the hypervisor. I haven't thought
carefully about a clean way to support this scheme, e.g. if mandating=20
guest to always allocate PASIDs through hypervisor even in this case
would it make the uAPI simpler...

Thanks
Kevin
