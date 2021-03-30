Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644C934DDAE
	for <lists+cgroups@lfdr.de>; Tue, 30 Mar 2021 03:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhC3Bhe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Mar 2021 21:37:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:23740 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230509AbhC3BhM (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 29 Mar 2021 21:37:12 -0400
IronPort-SDR: YX9Pcr3i0iWHUK70psVXbcnIZxAXWECh7pRkFwXkbIOa2+I0VFd1bWeIMNDRuzFVSR2Q8XuFAU
 uF0+N551iETg==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="178794678"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="178794678"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 18:37:10 -0700
IronPort-SDR: DAq3BOq63HR36KpRxjjD/Tskz1GtEd0jOFtS4u809OyrahHovcPE45wck/WBrvsWG2MVMHm/WA
 b7CqysoCVR3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="411366567"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga008.fm.intel.com with ESMTP; 29 Mar 2021 18:37:09 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 29 Mar 2021 18:37:09 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 29 Mar 2021 18:37:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 29 Mar 2021 18:37:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 29 Mar 2021 18:37:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3jSQOJD2AELzzxgA5gb/khIUvevxAlcDSNe2W346WPzXB/njVKH4X/0P1qQj0akR7gHataNmIAp7ELQLTZxgVLvWV7OXD1oaw4UMCfco9ZJ8M260L0QzwjC026UFH6GR9nhMtz+f/q+aaVY+ecNv8RsojP/NjI16X4D81Ia1hLb/hdCM4D2zMJ+GLP0HE2gkpO2mZ8vge9tejNhJeeX5saNplC7BtuLUzgtXDNcwhbq2mDRqJ3maPhI0Ytu8rdnwpjrCngp/v5/ntkodT1p8E7FuMuyxOiXIBeP/zOWzORKrf8qinbT8abKbxgmiaExKj8WLNx1xMANvV3ch2EDiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdkHWlLZVWbmowEFXz5ft+/3LXDayE8Wc7U1U+7L7cI=;
 b=mA0Oz6UvmcAlKOjZyMI2KE3UIdqS5G9r+QroGGkJhz9jxPQM3CltgnT6SvTvaokfDvl0aBFJjVZmMXep0QtN5yawEqm3R/KjHlbNpJcQTHq8lh4IOmaud3cTScOf3sq+SsvmrLc+tbAlGkFJqYrpbSyc7H5I1TgR5wgqphukKPXOe2+m7s9g9bZ4VJvW/0OhbroUjTMSDqWU/3B6gW3UmXjEGshiqar7j3BT0cMXU9QV5T16h7xhfjb6vqx3p5/vgvmm2SZMRcnibYzQB1sWmyNXZiwTRnZ72JJ3ljvsprY4YWTzqEPBIjO4faG5KsqFWX+yFWoB01ykgkNdn+3org==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdkHWlLZVWbmowEFXz5ft+/3LXDayE8Wc7U1U+7L7cI=;
 b=bdK+9ya/HGBnsE+oNNS/y5E/1/NCnEUAwU7ul2Sa6iU2BHR27pOzlibm+aXZqSoGwYWmii3Z1X7ftYZkfOKAE3z8rr/r+zUvj+raSJu3/jjAuCl3GNoC/kKXPDk7xTTQzpA2OeBXqBpXyE3F2dVm5pn8g1Co22G/rZHC6bHaOvU=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR1101MB2368.namprd11.prod.outlook.com (2603:10b6:300:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 01:37:06 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 01:37:06 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQw
Date:   Tue, 30 Mar 2021 01:37:05 +0000
Message-ID: <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210318172234.3e8c34f7@jacob-builder> <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com> <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com> <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com> <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
In-Reply-To: <20210329163147.GG2356281@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d95e420c-a2b8-46c6-2fb6-08d8f31c5399
x-ms-traffictypediagnostic: MWHPR1101MB2368:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2368E87D6BF0BDCA842A484A8C7D9@MWHPR1101MB2368.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TUzgiBOynposWtwjYxhsfUeR5DQpBoIAaxB+7o3bSY5FCdeQBuPg3WdWQU++KKF65YTBFsRMQG/OA/Fft4jrLCEIAV3vlGWWLQHIm9SXgdLsqe8JzLyv2lFOH1l22V1zWNdwqOGQYYyqc5yeYIBc54YWDx+uadWG7cAVuKcXUVcvfts6d0pY0AEFfb5smXrZ1pmZJH56vEwlbHRruAfyIK/LPY4fNy2dzUvy2iPYVVqGk/Gxxo0GWKZ69oF3eE9HJpW0gNAkyZsjrUBUmNsaJ5sEkcQs44j+fbJG8xNS6//VBxdNwhw4lcM0cEQBU0rvJ65vFEZj6jrBfD4ohbLhDVo32AA9tUzS34neJq2pcmHRQvagMFajemYXrx4kmVCSppcBcd7vUVPCa/WEdZtH2jSjua3DEaZbVQzFeva6UGG1bBjwhZWv+V2D1vdTYl1Qw+Nkr7nAZwsL/FxKMtBQsLyJosEa67QbmN6EZMfTYxkVFm9DIt21nEuujj1q4lgk003U4OIDT1W1/yHgSwnmz4CJ61sPmgRWjmULSYrFSI6d9QYyvRe2pQD+tTw//8/c4ZmH8T2dl9KXG/RxVFO9e4XWyzdssAufLv0BtZbPgtyfwByu4WjXRaM7qXT2+9BBGO6+Lv3Ge+yA0enoK2leYOpkdVDAOz8bmi2m1UTjRCw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(346002)(39860400002)(366004)(5660300002)(86362001)(4326008)(71200400001)(478600001)(7416002)(55016002)(9686003)(7696005)(8676002)(8936002)(83380400001)(38100700001)(6506007)(2906002)(52536014)(76116006)(66556008)(66946007)(66476007)(110136005)(64756008)(33656002)(66446008)(26005)(316002)(186003)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OmhA7/QLPIVqxM1m87x3os6llPm3iJjDZpHI8gYCYxL4Y8AtNOsoavbSAsPz?=
 =?us-ascii?Q?VH1rHGwrJlw0t8Djk6DHvUged6tDfGHRamYgEwyXgBDFIIBv8a9lHKtpsaoX?=
 =?us-ascii?Q?Ltv1TThU9AOMmjLFvuDHQvpTvv2pIJ8VwnlmWkqi2G8h99JGNB40TCevxp2D?=
 =?us-ascii?Q?5/KDaTvKSsWUq39/1eNRohe0YJvHF4m0LlNT0gl0b5IIhEPL/2iSje9/UGUK?=
 =?us-ascii?Q?17+7IJoUcptbfshK5YmVDXHzSM5Xg0g6B3Ck9j2GROqQwaVO+piZcFyTnqaB?=
 =?us-ascii?Q?iouAs/IeiZ8djBsXcDpxWtjqI0QZIg9oDs+crwbrMb7NC6r9H6zD8Vlsr3Rk?=
 =?us-ascii?Q?+dyMWsj5WVZsZUmVaYyhF9LY41myEuDDnPryKTphu3iju+96V/uOAZpPEQ8j?=
 =?us-ascii?Q?2rmCXLAd5l/I6HiVzlZGu5ziKAzbq1O4sw5AtNfoMvjwWjs9tvYA5uJ4SmCM?=
 =?us-ascii?Q?Izno363lCCU+ist/EzfYFkaaQJZZpOEb6b1KOYSvCT/qIsKD5apVa1FK1c3s?=
 =?us-ascii?Q?X5xlIncgldtaxlaBSt/n5XfpdZ0jfXuhn+9MZq/jE9pcwDCIldP4pDpZmh2N?=
 =?us-ascii?Q?e/iwISkpY2kdPHDoRWNQRmA0d3meiHomoRm4uozhP13g8pXFeB+eczW7TxKS?=
 =?us-ascii?Q?nUl2lkWkhXMUQSurVa2bvtVlD+EZAjVbySmVoEaL+j1/A+U/aUO/KxxBAbxF?=
 =?us-ascii?Q?iwXRFO/X+m1ghyKkBRsm1UMzH7WysmlTw2fmPkcI5Q2sdnvKVXCxj7hqezlu?=
 =?us-ascii?Q?ZXyq06+7DoD2cpvqh1ZQUAcs5o0XUvwISTmyGXhlHxWO9M3VMONra7b1pzMM?=
 =?us-ascii?Q?Sa5Cs18V58VE8Fe07ESmkdLmJAS3TyJcDkUp6hBlb/QLrbUOCNeWN28SV4m2?=
 =?us-ascii?Q?aOq2ZZx1/rTiTucBtiAzIQxlsDcI4H15oVcgAUbcl6X+N7lOC+7vA6+PAFvi?=
 =?us-ascii?Q?Fk543bV1vketgwFy/HDy3p38282OxhiZdB4uC0bkPQ81CHpeKOFFE7QnSAzT?=
 =?us-ascii?Q?z1cYdi7LpG7YCxO8LPKd/5yaUMRyMZXtg0k7R9fEbE8+a50K2Zam11CWngEN?=
 =?us-ascii?Q?E8Ve2OZs+vQ1SfOdyVXUI/zyNOUv9nVRyJ3feNR4KP657ELZBJfaM1M61nj+?=
 =?us-ascii?Q?5ixaExn8853Wo440bctulCBrAH//JQq25vA368TCOkwZ5ltuKFigjMwZz8h0?=
 =?us-ascii?Q?66REwEcMj6PjOxPbRkRUmet2rNPW1GhU+cPnx7tQzAuEG3vN9JETSmvRQunY?=
 =?us-ascii?Q?0fugwnsYqSXtU39JAAnKr6RFWLCkLE8xGGLe6wX59fDJi41NBfY4TCKReiZq?=
 =?us-ascii?Q?95lYWI8df8wibuNsiOcuTuXR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95e420c-a2b8-46c6-2fb6-08d8f31c5399
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 01:37:05.8427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lwXGlk6qWC0ODbRPYdrTJas9ZGUnBw/GCW7ncaNc51P0F9Pew/iRBVDpNGZs6b33SMRo9m/PkrVSwDjoZ5O5bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2368
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 30, 2021 12:32 AM
>=20
> On Wed, Mar 24, 2021 at 12:05:28PM -0700, Jacob Pan wrote:
>=20
> > > IMHO a use created PASID is either bound to a mm (current) at creatio=
n
> > > time, or it will never be bound to a mm and its page table is under
> > > user control via /dev/ioasid.
> > >
> > True for PASID used in native SVA bind. But for binding with a guest mm=
,
> > PASID is allocated first (VT-d virtual cmd interface Spec 10.4.44), the
> > bind with the host IOMMU when vIOMMU PASID cache is invalidated.
> >
> > Our intention is to have two separate interfaces:
> > 1. /dev/ioasid (allocation/free only)
> > 2. /dev/sva (handles all SVA related activities including page tables)
>=20
> I'm not sure I understand why you'd want to have two things. Doesn't
> that just complicate everything?
>=20
> Manipulating the ioasid, including filling it with page tables, seems
> an integral inseperable part of the whole interface. Why have two ?

Hi, Jason,

Actually above is a major open while we are refactoring vSVA uAPI toward
this direction. We have two concerns about merging /dev/ioasid with
/dev/sva, and would like to hear your thought whether they are valid.

First, userspace may use ioasid in a non-SVA scenario where ioasid is=20
bound to specific security context (e.g. a control vq in vDPA) instead of=20
tying to mm. In this case there is no pgtable binding initiated from user
space. Instead, ioasid is allocated from /dev/ioasid and then programmed
to the intended security context through specific passthrough framework
which manages that context.

Second, ioasid is managed per process/VM while pgtable binding is a
device-wise operation.  The userspace flow looks like below for an integral
/dev/ioasid interface:

-----------initialization----------
- ioctl(container->fd, VFIO_SET_IOMMU, VFIO_TYPE1_NESTING_IOMMU)
- ioasid_fd =3D open(/dev/ioasid)
- ioctl(ioasid_fd, IOASID_GET_USVA_FD, &sva_fd) //an empty context
- ioctl(device->fd, VFIO_DEVICE_SET_SVA, &sva_fd); //sva_fd ties to device
- ioctl(sva_fd, USVA_GET_INFO, &sva_info);
-----------runtime----------------
- ioctl(ioasid_fd, IOMMU_ALLOC_IOASID, &ioasid);
- ioctl(sva_fd, USVA_BIND_PGTBL, &bind_data);
- ioctl(sva_fd, USVA_FLUSH_CACHE, &inv_info);
- ioctl(sva_fd, USVA_UNBIND_PGTBL, &unbind_data);
-----------destroy----------------
- ioctl(device->fd, VFIO_DEVICE_UNSET_SVA, &sva_fd);
- close(sva_fd)
- close(ioasid_fd)

Our hesitation here is based on one of your earlier comments that
you are not a fan of constructing fd's through ioctl. Are you OK with
above flow or have a better idea of handling it?

With separate interfaces then userspace just opens /dev/sva instead=20
of getting it through ioasid_fd:

- ioasid_fd =3D open(/dev/ioasid)
- sva_fd =3D open(/dev/sva)

Thanks
Kevin
