Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDAF356163
	for <lists+cgroups@lfdr.de>; Wed,  7 Apr 2021 04:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348085AbhDGCXS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Apr 2021 22:23:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:46648 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234067AbhDGCXS (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 6 Apr 2021 22:23:18 -0400
IronPort-SDR: ZIMbPhpe/8Zx6ZA9JjkITyaV5Ho+fUcFQLFWSHuYcBX1FFlGdnMaVHiYMq41u2BovGH5nCPf+f
 pSbib79O8kLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="193245723"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="193245723"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 19:23:09 -0700
IronPort-SDR: DD6Qu7Nn+Y3nD53sBNk2t8scCZzeQhkcJSDp7lYsPKUQrpZvzfWiEyQArq3r9Hp98Lr8TQqZA6
 jtorwJI8IgiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="396475417"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga002.jf.intel.com with ESMTP; 06 Apr 2021 19:23:09 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 19:23:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 6 Apr 2021 19:23:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 6 Apr 2021 19:23:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOOPMHeHov+DiQWjnXwuq7khvQte3WzoVKIgWlSN4BfPqxvYAdM8G2yvImBtQliF15yYr3ViTCrAo/wC9NY+x1ELiLi0PZJZ2ykT+nNdwaPN5McIlJJGw2gOH3ZdCuyH0T/b9YPcaGyPLQconAq8oXa/4I2ifAKquD/CfIf77D1NmbKlpOMvVaw/JNn1mFEnlfsslhsW+ee6hIYrrCdSHk5B9h/732OxCAUs+J06N7/btTV5opV9PW2K3tdWw8nOnkA+1UYNTRBVR2qW0SBGJtm4K6OyVP4GapH8zsl3wo1jYRlnOUfnJjodkK4TCqXRlbdkJhw8KtxDDpZIh5hAcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v99zA+dNTwHdIILhWG0hCwNHQNvFCtkE/1VDw4vyNAc=;
 b=R3u17vHh5KNAm98IoCle2oskBFk5l0f5pG8tJQtk+XrPVDndQLIfEFJZnkUmWxUF8xuNm5WTFjlbWGxQbNlBlUS0c/KITZ5LYGshA7fQ8ggGdYJthyyA7jTuxWTre+uS+94AjqbX/sIqB/Qh2knDExZSKJOWX/2gSZI66sCTunHa8J8vXzd2GiWOu/8gIrABEqKAcFIEK9QbkmuoNEaZ5ga09AqUODRvlFG281qGGL69XsEip11d4ZSPiQCMMVMq/GREiHzm/V80RcUb5eOVA0+Y3BaDBXUbCCY+vo9rDvvunryxBPQBgbA+4NrJxQIOzEfYJFKrR17OoMqc9e+qgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v99zA+dNTwHdIILhWG0hCwNHQNvFCtkE/1VDw4vyNAc=;
 b=mXaojgGPV5hL+6UV+dZWxDlI1uwdg9XnWbuH3OfIcDsHWjjng7+yE6gNpQQUo1oHPSD2Iz8abEKPBlnxtZuwLwINZlGj0zr/41xCrbjy3Choh82b6PIS6WFiAdnn2k1vqgXmLoRNxxj3zzZZrLO5qFQ+BrFcMv+UGhmUMuJGxjE=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 02:23:06 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4020.016; Wed, 7 Apr 2021
 02:23:06 +0000
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
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAAHeZAIAAF3gAgAABVICAAAfXAIAAANyAgAEpdBCABcWUAIAAEDLQgADEkoCAAOlxwA==
Date:   Wed, 7 Apr 2021 02:23:06 +0000
Message-ID: <MWHPR11MB188665040BFD2D7606E8983D8C759@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401114648.GX1463678@nvidia.com>
 <BN6PR11MB406858FAC3821B84CCC4D30DC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401131533.GD1463678@nvidia.com>
 <BN6PR11MB4068C1A040FF61B4A9ABBD9BC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134641.GG1463678@nvidia.com>
 <MWHPR11MB1886C0804A0240998C110EE58C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405233946.GE7405@nvidia.com>
 <MWHPR11MB18863645C2C63A89BBA200B08C769@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210406122117.GM7405@nvidia.com>
In-Reply-To: <20210406122117.GM7405@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [101.88.226.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3c06a68-09b1-40ef-850c-08d8f96c1446
x-ms-traffictypediagnostic: CO1PR11MB4979:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB49797D027E4FD0651329248E8C759@CO1PR11MB4979.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 11a30OvOZfVkS1kAypNTVAtRV4Lc5O579cU3vMOlDGdPeWRVbpT9XU1RkizbXJmZPTBYBzqMbqlRwrFG/suJFnRXyYmC1VQDX9tg65kspzEBc4rHGwTsVkf+V/Ob9G/ad6mLv0xYpMuky5rbr2mbTNWkBArelCkxIWSw4de+IFiitwL4IemeO67NqEGs7StW2D1mZij2RCNw+F6UavJ6VEZXB4L4rftMHVkDq26Sub/+puJIpCCTJ79llkuY4s3jn+TcoQ8/T+70Gt/gK6qfEqqVvq7ViY8XDqfHEBWU2KgGlmS8SWa8WpwIhzcOGW8cxiaKelCwLyprZqMPIiVTOwPgU+EpIcgJJyQ6MhCp8f5I7xGMv8nJbpzNxoKQzzcMW5y6GhiXSD1oO+AELFc69lWQpqdsMqG/ubpHQdJi68pSV/s6MoUS/pw1mUx7gGLiwAjR4X08G3aV2IxrV0LVOaBs/Zk5+n9STPaY72LjmixQ5sODT2N0kYVdjNDgNWeBu0T9/ordshbdlBwyGJs/TH9Gw+DNTVvFQJRs8DCiDWJi1j/TDNLploFBWNmD4EFQ7PuI0T5dTjS2EWUTl9AysvbLUubvxYjfdXbfhD3buIaof9XFbrTEOTkxVaBXaClPvvaNIYwiERi3o5BdFZ9urRlqfqnKHopFk8s4e6C3olY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(136003)(396003)(346002)(186003)(76116006)(38100700001)(7416002)(54906003)(2906002)(478600001)(7696005)(8936002)(33656002)(6506007)(71200400001)(26005)(55016002)(86362001)(66446008)(316002)(64756008)(9686003)(6916009)(8676002)(4326008)(5660300002)(66946007)(66556008)(52536014)(83380400001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Yy8ZEnsRmFYAHCuMZqAytqXabD7bLr3OLKW6WJHJhxY8v3+XHKC7oNbS4LQJ?=
 =?us-ascii?Q?/8NPotR6FJOGqvBQNGFna12uJdMROlsIxxPQfZZVDI1+mDeQPyYHW433ijsu?=
 =?us-ascii?Q?HHAGzTFM5ai535nlInBgrfMGjBDSa8q8GAr+76OkRGNqZN2tmhjZ0SChLxZ1?=
 =?us-ascii?Q?wv6DrU/rCxlshh/CP1jzlmpw3qSvPhLjdKwiGJpBWzs/RwuZsoPHfq9Rt48k?=
 =?us-ascii?Q?VxTUz+dD51UUzgYgVK3mH1T8inm8oHLrJtclVlukGsO5vJoXTEakE/e7geeV?=
 =?us-ascii?Q?GQ2GM6SJfb0Y2XwkDFizYm3MBTI26TpJGnXoVL/xOki7TcVLRDFKxhezRaqh?=
 =?us-ascii?Q?To2Bx2QTyLOBW2sjYyoTkN5ztBwlp95pzCbKf9+cgAAcKj9x83NkPGsGjr6F?=
 =?us-ascii?Q?2Tadcqq5EkgdIcwVapjZB9uJ/H+/dqxW0ZeZJ3grs3UwiC3hp2NcUU2Ondaz?=
 =?us-ascii?Q?MK4BYAzBpMe6eqQZV2FsxBdM9ZUMNctIBYWuXIZfYqSun6zNgBd9OTNvMgx8?=
 =?us-ascii?Q?OZBjmKrBgVGle3yAIK1X77Udrax1lAe74doKrumK0qo/3SFG9kbZWGcYgOuG?=
 =?us-ascii?Q?0t0b7aN6JWYwX9OxcMMDSTC+ESv9GD9k0ri/zVpq7C5RVBU3kc/1r05E/hLA?=
 =?us-ascii?Q?q1agYC3RatMfWm/xMjhxruLdID7x23MPnKmqNmaZ8t+JXf6A/yPEOJJ1ZsAQ?=
 =?us-ascii?Q?fr7T4M+cYFFS9fOCnPQ/qxpvgFDTHTsg2AQ2efHTEQdoKZiJ6NUkk2gnXD17?=
 =?us-ascii?Q?jvUSAdSH8RO+OK50cUhnejjVYifa2LQmUApmlyDhtFg+JQYG+R+KhOuIR3VF?=
 =?us-ascii?Q?4KL+Cb0xaUevDfPus/RDcM7/JGzeaS86/XMOVpudPzFZlxQKRyjjcbdOXQsp?=
 =?us-ascii?Q?aERDSmZ/nz8/PGt5Zqn/6qnDDjJhbJ4saHeQRTfAF+alQhGbYKq3ADpZwzk7?=
 =?us-ascii?Q?oYNln1fim5i1G5LJo1BWkjRuFh5KkcmYyRTt2UVx/rSeh5fwad9ebnuSra5S?=
 =?us-ascii?Q?I6x/TaXFPQkSWOTFgX5XOhpXJzKsno/A9Nx56XaVwfibL0tDyixpM0oAIG2M?=
 =?us-ascii?Q?nReBVdNDtj36n14kG+s/DD5GD+rVRS6HxmLexvIveioXu6OVL6f+QDEk4Oyl?=
 =?us-ascii?Q?59YuUnlyHnoUoJdAtvqULS38VawlbkLU47pvcpn4EDb927ftyHr7zJZqBrj3?=
 =?us-ascii?Q?Fsb3rOpthbIx7IOM3QxIzKuSCN4pNA/wcYz648gMfdFgX9FJwyLkCHlQAUD/?=
 =?us-ascii?Q?H+UJgA8ulw6yjG4cMJAvyHCsMqf2VibNJi4bO9t7siW3nu4f74fTykVfbeBI?=
 =?us-ascii?Q?SYCwQeMjDfUNrScxcWrc8IeZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c06a68-09b1-40ef-850c-08d8f96c1446
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 02:23:06.4295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +fq2uQooWbMksTr84JH91rVT+sHe5ojVsH/OHuRFyJRsauMOuNq+sf8evc0axncJqyfYv5Wloi3XmqxYXexqlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4979
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, April 6, 2021 8:21 PM
>=20
> On Tue, Apr 06, 2021 at 01:02:05AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Tuesday, April 6, 2021 7:40 AM
> > >
> > > On Fri, Apr 02, 2021 at 07:58:02AM +0000, Tian, Kevin wrote:
> > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > Sent: Thursday, April 1, 2021 9:47 PM
> > > > >
> > > > > On Thu, Apr 01, 2021 at 01:43:36PM +0000, Liu, Yi L wrote:
> > > > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > > > Sent: Thursday, April 1, 2021 9:16 PM
> > > > > > >
> > > > > > > On Thu, Apr 01, 2021 at 01:10:48PM +0000, Liu, Yi L wrote:
> > > > > > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > > > > > Sent: Thursday, April 1, 2021 7:47 PM
> > > > > > > > [...]
> > > > > > > > > I'm worried Intel views the only use of PASID in a guest =
is with
> > > > > > > > > ENQCMD, but that is not consistent with the industry. We =
need
> to
> > > see
> > > > > > > > > normal nested PASID support with assigned PCI VFs.
> > > > > > > >
> > > > > > > > I'm not quire flow here. Intel also allows PASID usage in g=
uest
> > > without
> > > > > > > > ENQCMD. e.g. Passthru a PF to guest, and use PASID on it
> without
> > > > > > > ENQCMD.
> > > > > > >
> > > > > > > Then you need all the parts, the hypervisor calls from the vI=
OMMU,
> > > and
> > > > > > > you can't really use a vPASID.
> > > > > >
> > > > > > This is a diagram shows the vSVA setup.
> > > > >
> > > > > I'm not talking only about vSVA. Generic PASID support with arbit=
ary
> > > > > mappings.
> > > > >
> > > > > And how do you deal with the vPASID vs pPASID issue if the system
> has
> > > > > a mix of physical devices and mdevs?
> > > > >
> > > >
> > > > We plan to support two schemes. One is vPASID identity-mapped to
> > > > pPASID then the mixed scenario just works, with the limitation of
> > > > lacking of live migration support. The other is non-identity-mapped
> > > > scheme, where live migration is supported but physical devices and
> > > > mdevs should not be mixed in one VM if both expose SVA capability
> > > > (requires some filtering check in Qemu).
> > >
> > > That just becomes "block vPASID support if any device that
> > > doesn't use ENQCMD is plugged into the guest"
> >
> > The limitation is only for physical device. and in reality it is not th=
at
> > bad. To support live migration with physical device we anyway need
> > additional work to migrate the device state (e.g. based on Max's work),
> > then it's not unreasonable to also mediate guest programming of
> > device specific PASID register to enable vPASID (need to translate in
> > the whole VM lifespan but likely is not a hot path).
>=20
> IMHO that is pretty unreasonable.. More likely we end up with vPASID
> tables in each migratable device like KVM has.

just like mdev needs to maintain allowed PASID list, this extends it to
all migratable devices.

>=20
> > > Which needs a special VFIO capability of some kind so qemu knows to
> > > block it. This really needs to all be layed out together so someone
> > > can understand it :(
> >
> > Or could simply based on whether the VFIO device supports live migratio=
n.
>=20
> You need to define affirmative caps that indicate that vPASID will be
> supported by the VFIO device.

Yes, this is required as I acked in another mail.

>=20
> > > Why doesn't the siov cookbook explaining this stuff??
> > >
> > > > We hope the /dev/ioasid can support both schemes, with the minimal
> > > > requirement of allowing userspace to tag a vPASID to a pPASID and
> > > > allowing mdev to translate vPASID into pPASID, i.e. not assuming th=
at
> > > > the guest will always use pPASID.
> > >
> > > What I'm a unclear of is if /dev/ioasid even needs to care about
> > > vPASID or if vPASID is just a hidden artifact of the KVM connection t=
o
> > > setup the translation table and the vIOMMU driver in qemu.
> >
> > Not just for KVM. Also required by mdev, which needs to translate
> > vPASID into pPASID when ENQCMD is not used.
>=20
> Do we have any mdev's that will do this?

definitely. Actually any mdev which doesn't do ENQCMD needs to do this.
In normal case, the PASID is programmed to a MMIO register (or in-memory
context) associate with the backend resource of the mdev. The value=20
programmed from the guest is vPASID, thus must be translated into pPASID
before updating the physical register.

>=20
> > should only care about the operations related to pPASID. VFIO could
> > carry vPASID information to mdev.
>=20
> It depends how common this is, I suppose
>=20

based on above I think it's a common case.

Thanks
Kevin
