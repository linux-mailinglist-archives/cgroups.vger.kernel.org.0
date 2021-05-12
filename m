Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C79C37B2FB
	for <lists+cgroups@lfdr.de>; Wed, 12 May 2021 02:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhELAWj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 May 2021 20:22:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:13618 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhELAWi (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 11 May 2021 20:22:38 -0400
IronPort-SDR: C2Sg/73Hd0AFf2XUEHcRlh2NOjXYxtDah2nymdgBheBKh5PpN1CNb1v6Rjsb6XLidpmJlJ4c48
 BjCPaQmmE8pQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="199264489"
X-IronPort-AV: E=Sophos;i="5.82,292,1613462400"; 
   d="scan'208";a="199264489"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 17:21:30 -0700
IronPort-SDR: rM7zeb9+stx+bgPkZ2OaWPPFKRgQubvw+1mQDheiayUvSaOInIZ50YHbi/JNnS0WhENyCrrA0H
 RXyVpmoTAmRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,292,1613462400"; 
   d="scan'208";a="622066382"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 11 May 2021 17:21:30 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 11 May 2021 17:21:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 11 May 2021 17:21:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 11 May 2021 17:21:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqIjJwibx+I8amnUHus9gxVOPw3E+0qelTDbASlh9wjxEt5mN+YlCVI6bTYR48nqs83c9LR9QYb/Kybr7nP1kZ0lp9DiC6eiB6YRFkMdKndJX+oCks6+cE4GIVpQpue5eYTVOwr/fU4k/dyDlFvhx3AxUT3g2ivVSYjr4cUlnUdqM2b5DYTnGbvYENT2Sl5R9ARTeuMGwr/gg7UZTAZRVkkQPilwlPzv0OMtAFv23Kp40y/svyUIaRzcNm2/HBN3nMB0oexWJVJlmzUPy2Ezib9lpwPedzlAOOnD5/ilBbEBiBuQUO5Hw7abWRpHPIFwqtYsfSGnSiQMbJVqZ+NEOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OHOCCzWfjeTLJO++P6b1F+xs1LwTd11q0EmTgb8ww4=;
 b=NHfPUxVCUJ3hrG0IPdbPonisz5cKVOK0u0pCHldmp5NWwOarrc8Hsoe3sj8nM62f0jQ3P6DYPThYTGUat1NimoCkXfN9eruun9SIzlnYsBUtQ8c3gbO4TPp1Qw+oBGZ41ClLHZybb1/JeDjRC56ki+dFMuLYrqMpssV8DD08qIKhL9f3U8z3AFvqEuoRVqJ/AxoMYazaOGNAKN9Lx4XP51UJl0RvVY0K/ZZn8azZwUbr+OwY8lZ3Dq2MS21L4fY6rtJ+liKl8qzIvsRYRg5Q65NAE9IBFZfmRDYT+EOUQb1w97ts2ZKxKkFd/xZpXk2eOc6pYlHO46YH8wLzcbeBRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OHOCCzWfjeTLJO++P6b1F+xs1LwTd11q0EmTgb8ww4=;
 b=ZR8guL5VR9yjD8FtuQmYH6U7QhhMNh/EEgH8vj4pf1kHHIT+QmP9PiFDYm2sBLiZRnb929eWsV24xydrHfOXw/MtqQS95ix9XL5+pWzjCgW6eFfzsLqHUBn+YdNGiCJ2zrV2AgGyYKHPrOIZ9MscDYCJ556Tm9zD8N8VUMd1P6Q=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR11MB1839.namprd11.prod.outlook.com (2603:10b6:300:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 12 May
 2021 00:21:24 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4108.032; Wed, 12 May 2021
 00:21:24 +0000
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
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAACiXgIAAVBgAgAAaMwCAAAESAIAABy2AgAAgOYCAFdCAgIAAppUAgADsNgCAACqygIAHsmaAgAAzsYCAAAjdgIAAD/yAgAAcQgCAADqggIAAk6nQgABIUACAASsnkIAAYWwAgALs9qCAAdeZgIACip7wgAo7TwCAACbZAIAARiUAgAARxQCAAS/XgIAACnOAgAAiwQCAAL24AIAAVNoAgABEgACAAo33AIADeaeAgAESCjCAAKImAIAAgzaAgAAT/gCAAAjoUA==
Date:   Wed, 12 May 2021 00:21:24 +0000
Message-ID: <MWHPR11MB188623FB741481D489D259798C529@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder> <YJOZhPGheTSlHtQc@myrica>
 <20210506122730.GQ1370958@nvidia.com> <20210506163240.GA9058@otc-nc-03>
 <MWHPR11MB188698FBEE62AF1313E0F7AC8C569@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210510123729.GA1002214@nvidia.com>
 <MWHPR11MB1886E22D03B14EE0D5725CE08C539@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210511143840.GL1002214@nvidia.com>
 <MWHPR11MB188601321993CA43E3058C4D8C539@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210511233950.GQ1002214@nvidia.com>
In-Reply-To: <20210511233950.GQ1002214@nvidia.com>
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
x-ms-office365-filtering-correlation-id: 2ceb8081-8c4d-4567-47cb-08d914dbe041
x-ms-traffictypediagnostic: MWHPR11MB1839:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB183995330AEFA55CF95BBE128C529@MWHPR11MB1839.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 114AIOE0F80iq/EyBcnssPzEvuucjqLBJQKKKs0xJToQis9bfcumMKWXVpNP5hNfrz/2CYQOE5a8TKjx17hE11Njho40IbsvR6r/4+RbOx1KYRXcFS+dNGqEtYHpnMLiYyAoomIzg1UixVTwegY8sfTdH2Y0e7q88oSRTEBwJxD+FFsnFqg1DNsm6nCB+rIEKAouWtab9V/3XuL1DTsS7r41B7XGhEFF3sKjhimNY1U85JuJODELzjhmI/dtTBAp0ALw3+62ItvuOWTUHTuLfQRCvqDEHSWZGiJ/iC0+q1ySNmX/o53qm2u4uLmGRIeIJghBDOZSfYBtXkB17YV25jK6l34bMNVXroP2SBbU6PQftyL9kKqaAAooz/d/YiZWsvdNiXHwtzU3BQvX1Ju1cI54HbpxZB3S6s4cdkPXniDSKwo2+2xAxg7e1pReEbheAwk6wqBOPAHbBs6Z8THyTDHdbwd4xKHMwajIEJZUInkTwKuI88cii5vj6KzYIxlWNXXwbiw/VTC5gLuKbUGXacNXYCOgKqH8MWxcuRq7ytNNc2WN4neO1IJFxvl6i0Wm/Y15h+A8ExKKHb223TyPlblrjqJznWHIM5qaz3qDhKA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(396003)(366004)(39860400002)(8936002)(7696005)(76116006)(66556008)(64756008)(478600001)(66446008)(186003)(52536014)(66476007)(6506007)(66946007)(316002)(54906003)(55016002)(4326008)(6916009)(71200400001)(122000001)(2906002)(9686003)(38100700002)(5660300002)(7416002)(33656002)(8676002)(26005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?o5IDbt0hLLvxGknoI64cEu2eGi0jHq+A9Kq8Qg3vcbtZt1HKRqWp9rW95my0?=
 =?us-ascii?Q?53dVTYTcgKIK7j1r+BL42IbN4Ii9/y7eQvAqISDaZI6QIogDtzS1/y20Wob8?=
 =?us-ascii?Q?9Yve1uKqD9+lxfzBiTyLxjBVz98lvgeizUvcmolaCg2h4RV2apwVP7mxr1S4?=
 =?us-ascii?Q?6W9EfC9zNkVGBTonwdcJ+O/XE7EpfQk48SHtkZh29Ev3J9a+N1x3sf43z9rj?=
 =?us-ascii?Q?J0c9Y7jT5Mk5YeQaMsLWDVGBjOVGC4WXhxT28orbahtx4k1C9A9iaFiPYv20?=
 =?us-ascii?Q?jhgqExF14hIIYN7k+PY1HOGH8UdZ1nbf6qO5ZneaArzOPppNLyPKPpmYs9o8?=
 =?us-ascii?Q?2jPnFTb/u5EbIiUhYw9n3bqB9RLraFJS/aBISEylqL8VtKm2FlNoWXpBDmYe?=
 =?us-ascii?Q?XBRFLoo5624wlxWXeLHZOr+ARCkiFpGe67AM3At6FnRKQ5xE8wjyMAa4zgx1?=
 =?us-ascii?Q?geTN4u/t9HcqTn/v6dOvYbGhAMvpzTRLjo0RIF7QhHlffeL6Nc2au3SLhkFO?=
 =?us-ascii?Q?cti96E4TPBIONKwaKuEe0vuuaisf26KcI1syT5SAxIni31eHhyfqhxG49SLT?=
 =?us-ascii?Q?yIgbQqA9VksmtqOO9FQlMH9o4NMd35/SbhOhFM5DhzWzlbVNYnrSyON+aQDi?=
 =?us-ascii?Q?gqRhvX7fXLL6Yg6F/+12lx8Bl1XldAkOioDsyseZxEBU86OAD84BNebQoHA9?=
 =?us-ascii?Q?3m9/aT7nHMN05LR/B7xZIxV4+WaHIh7XsPIECWnZrR4pMremKHs3WvkutaiP?=
 =?us-ascii?Q?J/FCB9NI9lGBqpoC1gQF2lni/EBb004Fsv1kNKwmp0hmFIH4YFmb5pgp+gth?=
 =?us-ascii?Q?7hDrz0eqPDdtlF+7VfMyFvc/lypg1xL/28n2CP50U9aM5vZxI+OEymvJMERN?=
 =?us-ascii?Q?LE2iZkBxCgJQtB7xz7B2mRV64vQtBSfNoTLBRr62gproFuIrYZ93l5eG2Sab?=
 =?us-ascii?Q?HaQTcGkm4v9wUZZQLjm7QtXxWZw6rXR5YlyAnAOHxPP5XEfMTD2HL2uF5guV?=
 =?us-ascii?Q?oaRuUG4kO7QqHwBkRG6J/xXE6aORfrbZVfbcDC21/c5uDcDBzj917GP8br+1?=
 =?us-ascii?Q?mRyzEdhqiSXn0fYs8iOYSeQ9dPn3sPpfT0j3qPRluon2SyDC9Y7WLsO7gW2i?=
 =?us-ascii?Q?vbeZaBEgaJ6OUchhrNUQMrPkgU0AHedmZmXg6Jiz/Akg3p5ofj7p5nSTaCMW?=
 =?us-ascii?Q?457RueCro+dZ18aWm/69AyFb6QgNyjh4KRyLdKmLc+yvzr7VHnpJBVLnvNmo?=
 =?us-ascii?Q?kPy1Y/JUNPDOpzjBTfnbb6rGWTS2WVQ2NTJ0P5NE4j4GTw7xozMx+PW0IT1q?=
 =?us-ascii?Q?VcNx+/6Mbz8/CAf+tKqWMSYR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ceb8081-8c4d-4567-47cb-08d914dbe041
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 00:21:24.1594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hkTdt3Pw0N88QBVk+2bpXxr1R9lPXPC0OvKqSpx2eHiFgSeoo60ejC20sCBBlAdd5jvBM+Oz6gqAbsudEYJ9qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1839
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, May 12, 2021 7:40 AM
>=20
> On Tue, May 11, 2021 at 10:51:40PM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Tuesday, May 11, 2021 10:39 PM
> > >
> > > On Tue, May 11, 2021 at 09:10:03AM +0000, Tian, Kevin wrote:
> > >
> > > > 3) SRIOV, ENQCMD (Intel):
> > > > 	- "PASID global" with host-allocated PASIDs;
> > > > 	- PASID table managed by host (in HPA space);
> > > > 	- all RIDs bound to this ioasid_fd use the global pool;
> > > > 	- however, exposing global PASID into guest breaks migration;
> > > > 	- hybrid scheme: split local PASID range and global PASID range;
> > > > 	- force guest to use only local PASID range (through vIOMMU);
> > > > 	- for ENQCMD, configure CPU to translate local->global;
> > > > 	- for non-ENQCMD, setup both local/global pasid entries;
> > > > 	- uAPI for range split and CPU pasid mapping:
> > > >
> > > >     // set to "PASID global"
> > > >     ioctl(ioasid_fd, IOASID_SET_HWID_MODE, IOASID_HWID_GLOBAL);
> > > >
> > > >     // split local/global range, applying to all RIDs in this fd
> > > >     // Example: local [0, 1024), global [1024, max)
> > > >     // local PASID range is managed by guest and migrated as VM sta=
te
> > > >     // global PASIDs are re-allocated and mapped to local PASIDs po=
st
> > > migration
> > > >     ioctl(ioasid_fd, IOASID_HWID_SET_GLOBAL_MIN, 1024);
> > >
> > > I'm still not sold that ranges are the best idea here, it just adds
> > > more state that has to match during migration. Keeping the
> > > global/local split per RID seems much cleaner to me
> >
> > With ENQCMD the PASID is kept in CPU MSR, making it a process
> > context within the guest. When a guest process is bound to two
> > devices, the same local PASID must be usable on both devices.
> > Having per RID split cannot guarantee it.
>=20
> That is only for ENQCMD. All drivers know if they are ENQCMD
> compatible drivers and can ensure they use the global allocator
> consistently for their RIDs.
>=20
> Basically each RID knows based on its kernel drivers if it is a local
> or global RID and the ioasid knob can further fine tune this for any
> other specialty cases.

It's fine if you insist on this way. Then we leave it to userspace to
ensure same split range is used across devices when vIOMMU is
concerned. Please note such range split has to be enforced through
vIOMMU which (e.g. on VT-d) includes a register to report available
PASID space size (applying to all devices behind this vIOMMU) to=20
the guest. The kernel just follows per-RID split info. If anything broken,
the userspace just shoots its own foot.

>=20
> > > It does need some user visible difference because SIOV/mdev is not
> > > migratable. Only the kernel can select a PASID, userspace (and hence
> > > the guest) shouldn't have the option to force a specific PASID as the
> > > PASID space is shared across the entire RID to all VMs using the mdev=
.
> >
> > not migratable only when you choose exposing host-allocated PASID
> > into guest. However in the entire this proposal we actually virtualize
> > PASIDs, letting the guest manage its own PASID space in all
> > scenarios
>=20
> PASID cannot be virtualized without also using ENQCMD.
>=20
> A mdev that is using PASID without ENQCMD is non-migratable and this
> needs to be make visiable in the uAPI.
>=20

No. without ENQCMD the PASID must be programmed to a mdev MMIO
register. This operation is mediated then mdev driver can translate the
PASID from virtual to real.

Thanks
Kevin
