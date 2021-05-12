Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03F037B31A
	for <lists+cgroups@lfdr.de>; Wed, 12 May 2021 02:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhELAlX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 May 2021 20:41:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:61587 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229920AbhELAlX (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 11 May 2021 20:41:23 -0400
IronPort-SDR: /xFcCLO4A8+SRzpDE2fSpKsddqii/yU/BNGLeZ3DKn4uhzI2d60LJCoZyDBQLSJ3raYC7VAk83
 ZIXW8vY0aLXw==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="186721282"
X-IronPort-AV: E=Sophos;i="5.82,292,1613462400"; 
   d="scan'208";a="186721282"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 17:40:10 -0700
IronPort-SDR: fOyv004Yriyqn3SQqnDGYP5nydIpF4lK3oEVuWMaZ9Ja5yAAw5LVkRba6Nyy/VjcMDqtP1h4sl
 4BT+232YtbOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,292,1613462400"; 
   d="scan'208";a="434844713"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 11 May 2021 17:40:09 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 11 May 2021 17:40:09 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 11 May 2021 17:40:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 11 May 2021 17:40:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 11 May 2021 17:40:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3mPSehUonwRu787wQj04sOkxDEmN9VPsQibcEw5CVJiohQv9aKxDGrTleeU3CjvyZJjTYM7DDM+cUzOQiniRIxRROF89rd3oghjsUD+6hsSl/sy5gsyAxIjebdKZGatgt4UjGWaIVjznkiTDPbunAjxsr2csw9zJJfWVQQGunyqF96s2gLUWRwnU65tX9g433ih1TCinFL2zRrO4Oj1AMBlG23hEaqJVCgb2XEU+Qrb+LbN57f10HC4QAUv3aFvsNAT4ekPnFiOk7n/iLMAIb2CvgcWRNsMagIc1zqPbfixw6wk+LI9n/e4l/mKXSHqqDKLM/iQNF3WwwngGZFICg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ol8tdKdXEMiUCLvEiPres2Ur7dwmUvIMjcVrRkVNYT4=;
 b=EPYQAe8dMYyVoAQF1DiEZII8chKqsNUJFPj3VPdcIWfAgKupLF3+CFq/n2Mp71LPtEJUnV8b2JP2f1672gcf6z0AHahEy/NxDp4ETSajBN556F1XWJrK4LKyaMIuuzdgzOluc73bPLvio8sCl02cMXJXr4+hpBrEoxntezuXGL5+awoZQBtXKbnth3gRhvW2LW1VSZeNK6EzanPopM8HO8gL6SsWgE6eWAd0OaFxTRSv2yVaHUpfyHqoottwVPB8etfCECXsHXmFoUbZs/o1Aq2aAkosCJoe8XwrJZwrN6/Hn4FCPfySRjr872kyArWeVD53QqBMJ6qeC0Y9dll1rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ol8tdKdXEMiUCLvEiPres2Ur7dwmUvIMjcVrRkVNYT4=;
 b=LqRuuxdhkOLWFORIjABHybYg8bb1PhALB4URXIcoT+dZ3WCBosTnDc9JPkUV7BCL8NXdNfeMWcShp1Ml4hu+LyHCQtBZfnMXOFUmblzfP12BikeKOLjb2rExwdcGgYAf/VZ8pVPB+3gBVIHX1sPY3tAz8nljUrjRMtYxBXcBvzI=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR1101MB2271.namprd11.prod.outlook.com (2603:10b6:301:52::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 12 May
 2021 00:40:04 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4108.032; Wed, 12 May 2021
 00:40:04 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Li Zefan <lizefan@huawei.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "Wu, Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAACiXgIAAVBgAgAAaMwCAAAESAIAABy2AgAAgOYCAFdCAgIAAppUAgADsNgCAACqygIAHsmaAgAAzsYCAAAjdgIAAD/yAgAAcQgCAADqggIAAk6nQgABIUACAASsnkIAAYWwAgALs9qCAAdeZgIACip7wgAo7TwCAACbZAIAARiUAgAARxQCAAS/XgIAACnOAgAAiwQCAAL24AIAAVNoAgABEgACAAo33AIADeaeAgAESCjCAAKImAIAAgzaAgAAT/gCAAAjoUIAAA8iAgAAAOiA=
Date:   Wed, 12 May 2021 00:40:04 +0000
Message-ID: <MWHPR11MB1886C5A82E4846A86F4D31988C529@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <YJOZhPGheTSlHtQc@myrica> <20210506122730.GQ1370958@nvidia.com>
 <20210506163240.GA9058@otc-nc-03>
 <MWHPR11MB188698FBEE62AF1313E0F7AC8C569@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210510123729.GA1002214@nvidia.com>
 <MWHPR11MB1886E22D03B14EE0D5725CE08C539@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210511143840.GL1002214@nvidia.com>
 <MWHPR11MB188601321993CA43E3058C4D8C539@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210511233950.GQ1002214@nvidia.com>
 <MWHPR11MB188623FB741481D489D259798C529@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210512002515.GR1002214@nvidia.com>
In-Reply-To: <20210512002515.GR1002214@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 798a93a7-4e94-4010-bd39-08d914de7c0e
x-ms-traffictypediagnostic: MWHPR1101MB2271:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB22716FF7B1C99ABCB961B3698C529@MWHPR1101MB2271.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UOCSvkmE/kchnlbSvQfRiDDzuTf0sUUC+5rCe33fUO+M9Tf3ClVirZcTF9k/4V2zw6csKNcsZqYy1O95i02BD/C4KgZzB7bQyMbNPFEsWAE7KAifV3fPeaWUh4AsjKR8qIK62vL0IJzAuUQbscpPsPNbBO++/2jTLCNEYP+48SYGxG50F8H7NCcH2Datc4aOJYpzhMp+74HMjgiS9RpvB/j0F0O9QGGFhaJPgJm5vqb0OgJ3UWS7jyeUDnbdMSG0qPPSM+nG8OTfD/fujn1M6d2/92ZL0v/AXEvsY2y+YkeKjgm+dG3onmw5fyJA8P0VVyVjD88nB+o0UIkI5pwDUw67IrRYAWP45+ldM6tAHsiWQPyIWWXUxPZyjq9xdN5gFiDRHov5EK4HJdT+5bkS3NFbd4U0SgUQTdWKjJm2+dRZ/xZk+r9LfsFM4DJoWC/5WWUdMXG6VT8FEIFEnB9uTrOi810thg1PssRjSmgGWHmEkGXCqWgGDK4LnyXeXxLK1kFOiDyJRBu9hX62l/8RVKz/nUaDg/qfzYwXfm+65qiA/DBnNsMa7ydvXe0PMzy4eT4p9SKwdU9mYHF4dS7bEK5TTECNFHh8jhLHdS/u7GE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(39860400002)(396003)(376002)(7696005)(71200400001)(66946007)(76116006)(6916009)(64756008)(186003)(54906003)(7416002)(66556008)(86362001)(66446008)(66476007)(478600001)(2906002)(33656002)(8936002)(122000001)(4326008)(55016002)(8676002)(52536014)(26005)(316002)(9686003)(38100700002)(83380400001)(5660300002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ODSFmnfF2iis5HkZh6QarS9AAd4Yjxqcu2ZVfm36XDFCZcbWS7tu5BRIDeRg?=
 =?us-ascii?Q?KyVYCx87ifK7hGifFAc2nTfOGKSUUUChT7ijIUcnjcSH+80s/EwF3vQnBsGE?=
 =?us-ascii?Q?kOIjeqJrQ0dXRrWEfGG0jMsNVD/EJL2N7lHSuNWsst5kEnxPzDozAKRi85hP?=
 =?us-ascii?Q?6ZNog1IzTq/sEMb6QYwfeFbmb5KXVsv+9iscFC27syxvxSSElnF94cagaqwk?=
 =?us-ascii?Q?xBzdJhfx3GgPP1senALTDPIVIUr8B1hAdcJ/m6jRGaHEx1Nol6issNm3OENo?=
 =?us-ascii?Q?InzLVymCz6UfxzZO3jzKeoKJzpGm3BFEwTFCRN5kUbouyttvOlMkkvS21gl6?=
 =?us-ascii?Q?pbsIo0K/fT0AB+d+hyGA+zbLX5iU6sHL4i/DPcmk38aGtzqUQieME7Xal0CD?=
 =?us-ascii?Q?qpYtip2GPexe4Xon1yNDeZ5tCtl4h9lNs0EOXZor9vqOg3YOQ1cpxdXFsAi4?=
 =?us-ascii?Q?GBns5Wo1T9VX5jUycyubduDy38rhElE+3gnaAZrQkFv9pRidOgQ0e5hOGoRd?=
 =?us-ascii?Q?hwQcPO3+SK4TSVfUqKDW8VlXG0oQ/YUjb1htfANno1IWTYjhgWWJoz92Zl93?=
 =?us-ascii?Q?hgGkANOobKscyHq7GZBeYzoA/TAE4kMJjb8vmxvodXzYxmTkipKzWuwmX3W8?=
 =?us-ascii?Q?p5Ha8Dql6DROy9LnWi9SPsdGdLR8rra7L/zprLtbTigAXVF1fQi1RhPHvJlS?=
 =?us-ascii?Q?KLb5975HBEJ33JA1HPYtRZPP8nOcSqaKY1ewub9GxjDnkO755qIuXSCrDo+3?=
 =?us-ascii?Q?HtEHwUAee00+aZexM7/iXLiaJVfZI+5S0s0xs/vGoYvOch9PzMVihPbyFv37?=
 =?us-ascii?Q?C6WVQrpBdQ4nTd6dWMMIMNjINgaCao5Sg9H/qCUD6WUHx2ZmayvlEs1aD8wh?=
 =?us-ascii?Q?Uj9hN5bCqjL1HP9lwkVbOaFaQcSlaPq6N5P0eFzuKF9nwJIXshoGVkfk93Vf?=
 =?us-ascii?Q?8qAzo3KfkSD/umrb55C1G1HKBe+7/KE+2JvUhQH8Cs+tVp8VtDkmuLv2uNFF?=
 =?us-ascii?Q?IW9ZyorVjwvyh60fzb+mIxHGSY/5Rn+7mQDwDNs7NDogED30AycBKa1W1aPq?=
 =?us-ascii?Q?OPPwpGUC76uUQpcs0zZewyjpR1mvUh4iXyeEGE2hp5j4ptxUVLpNxITUf55u?=
 =?us-ascii?Q?YXpjTEKa1gbGLEGq58CGZstBTSvev/jsXqMwFh/2P09ZIms6J2XA8IpsUMBm?=
 =?us-ascii?Q?1HkxIG6i3M79hf3gzj3FpkEz+yfpMDItYpey+SIbALAUcbY5g5oBIuEcxTny?=
 =?us-ascii?Q?xSTvcIV0hHGlQn+au2NtbsdzWbjlU/P45dFx8LweOe+ULFz97C8Bv8FVw5Ut?=
 =?us-ascii?Q?iujLfW10faTU+3AQC6s6sxii?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798a93a7-4e94-4010-bd39-08d914de7c0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 00:40:04.5292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KELDRJ246CsNud8+xmFAEHCw+a8H6SFTz59t5SRIXu+cZxJgJLSyeHk29MkJT+GoH5bwf5Jzqc4UQy7BW6b9+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2271
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, May 12, 2021 8:25 AM
>=20
> On Wed, May 12, 2021 at 12:21:24AM +0000, Tian, Kevin wrote:
>=20
> > > Basically each RID knows based on its kernel drivers if it is a local
> > > or global RID and the ioasid knob can further fine tune this for any
> > > other specialty cases.
> >
> > It's fine if you insist on this way. Then we leave it to userspace to
> > ensure same split range is used across devices when vIOMMU is
> > concerned.
>=20
> I'm still confused why there is a split range needed.

a device could support both ENQCMD and non-ENQCMD submissions.

for ENQCMD path, CPU provides a PASID translation mechanism (from
guest PASID to host PASID)

for non-ENQCMD path, guest driver directly programs untranslated=20
guest PASID to the device MMIO register.

the host kernel only setups host PASID entry which is hwid for a said
ioasid page table.

If we don't split range, we have to assume guest PASID =3D=3D host PASID
otherwise non-ENQCMD path will fail. But expose host PASID to guest
breaks migration.

If we want to allow migration, then need support guest PASID !=3D host
PASID and make sure both entries point to the same page table so
ENQCMD (host PASID) and non-ENQCMD (guest PASID) can both work.
It requires range split to avoid conflict between host/guest PASIDs
in the same space.

>=20
> > Please note such range split has to be enforced through
> > vIOMMU which (e.g. on VT-d) includes a register to report available
> > PASID space size (applying to all devices behind this vIOMMU) to
> > the guest. The kernel just follows per-RID split info. If anything brok=
en,
> > the userspace just shoots its own foot.
>=20
> Is it because this specific vIOMMU protocol is limiting things?

When range split is enabled, we need a way to tell the guest about the
local range size so guest PASID is allocated only within this range. Then
we use vIOMMU to expose such information.

>=20
> > > > > It does need some user visible difference because SIOV/mdev is no=
t
> > > > > migratable. Only the kernel can select a PASID, userspace (and he=
nce
> > > > > the guest) shouldn't have the option to force a specific PASID as=
 the
> > > > > PASID space is shared across the entire RID to all VMs using the =
mdev.
> > > >
> > > > not migratable only when you choose exposing host-allocated PASID
> > > > into guest. However in the entire this proposal we actually virtual=
ize
> > > > PASIDs, letting the guest manage its own PASID space in all
> > > > scenarios
> > >
> > > PASID cannot be virtualized without also using ENQCMD.
> > >
> > > A mdev that is using PASID without ENQCMD is non-migratable and this
> > > needs to be make visiable in the uAPI.
> >
> > No. without ENQCMD the PASID must be programmed to a mdev MMIO
> > register. This operation is mediated then mdev driver can translate the
> > PASID from virtual to real.
>=20
> That is probably unworkable with real devices, but if you do this you
> need to explicitly expose the vPASID to the mdev API somehow, and still
> the device needs to declare if it supports this, and devices that
> don't should still work in a non-migratable mode.
>=20

It's not necessary. For real devices we use alias mapping for both guest/ho=
st
PASID as explained above. Then we can have the guest to always register its=
=20
vPASID with ioasid (just like map/unmap GPA to HVA), and then let host driv=
ers=20
to figure out whether that vPASID can be used as a real hwid. When it's con=
sidered
virtual and a real hwid is allocated by the host, the mapping is saved unde=
r this
ioasid to be queried by device drivers if translation is required.=20
=20
From this angle, the previous IOASID_SET_HWID possibly should be renamed=20
to IOASID_SET_USER_HWID.

Thanks
Kevin
