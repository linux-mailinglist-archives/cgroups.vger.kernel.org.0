Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591ED351B6C
	for <lists+cgroups@lfdr.de>; Thu,  1 Apr 2021 20:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbhDASIg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Apr 2021 14:08:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:62833 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238314AbhDASGE (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 1 Apr 2021 14:06:04 -0400
IronPort-SDR: nH/ctAkkex/3kK/2zACKkzxqQiFscgoq6yeb5GbAWSo//UHrTigHJiVzXkuCHOohfewuJcZBQ8
 xDoKHwwrJAmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="253582135"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="253582135"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 06:43:39 -0700
IronPort-SDR: pPJ73sFre6IHLbSVnnPjxoZg55NsNB7lud1i4iI5G3Ztuol0QNkbwl1/HfxS2y6O94pv7s9nz8
 i6tQPQuW0wYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="379321987"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 01 Apr 2021 06:43:38 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 1 Apr 2021 06:43:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 1 Apr 2021 06:43:38 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.51) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 1 Apr 2021 06:43:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLXdvTUW9B7I19dfPr9ffr8I1WbYC+4IHsRJFvsvbyrCPDkgWsGDE4o/dUdOrZWtkWQjrrR9PCV0AaLLLOw0MWvrRLAazJliSDRwtpa5ICDh2K2n82cqVyHuYL8a3tsPsKHi1Q7/29qxDNlTmMtaQfAdjUi/UpI52awpjZQoFH+HapF91GYaKqY8bEXaws04PKdm/QAv/+m+K609M3Qtaa3f8T+D8Xjows0FT+dICzKTvrsP1R/9IzclNxPmHIRRiBB8Snepw2mm2sT05Yb/K2yk7UNleiFctff1DjHSGVyS8gCs+V42BwJ9KIXCdmKPWvem+tqNVY4vYPkyKWt5aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CThGP1dhY/be4EXdHHIcLSxePjmSzukC4ztmKDvteHE=;
 b=HIHFTT2AIXBavdu8dcoKMjLxV11GraAuClU9Cm1QhSU7v0Orbi23KWjO0neoT/40D7iM0MwwfBM9dKjQTatC5ZJ9BVOV3wBxmdkXjSQwMUan6e4R/QbCGwu+jaoB2w/lUExfGQ6+xrKy3HlU1u7TyklT5Ir8XLaOGOW1alQ31wqMUtJ+Sepa60VWp29WcHfcC4xSBONqySiz0UD5NRZhUgm0tztDgRsHMB6qqK2q5CAl7trN0D2WnltVcwz8NFIEgg5BaT/+DAPmA9U3RTqdT+00LorvNIw+OygtcZNoI2+zjM4GkUlcajpdmggEx7KRMQBa3wazLIT33XvkenexLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CThGP1dhY/be4EXdHHIcLSxePjmSzukC4ztmKDvteHE=;
 b=dIy8FO6UtQYuXY5ZhZ8dnENSVBjTXUshRa/OCSxyX5kYb7dvPbqJ077TSWdhAD3iDj1PLzgQXeUiamPHlK148ZJ0TcsxDdNHsVFgEgb2caRb0UOgUMEm5fVjk6IYhJoER1lI2QH3aJRNeKjdBwYneuNMaB3cznnD1bwGq2lvmQw=
Received: from BN6PR11MB4068.namprd11.prod.outlook.com (2603:10b6:405:7c::31)
 by BN9PR11MB5338.namprd11.prod.outlook.com (2603:10b6:408:137::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 1 Apr
 2021 13:43:36 +0000
Received: from BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d]) by BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d%3]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 13:43:36 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
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
Thread-Index: AQHXDZuc1/oaTFwUU0WheDxUmLBHiqqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAmFuAgADGxQCAAR7PEIAAZiYAgAECgOCAAIDKAIAAErowgAAGEoCAAAbzsA==
Date:   Thu, 1 Apr 2021 13:43:36 +0000
Message-ID: <BN6PR11MB4068C1A040FF61B4A9ABBD9BC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
References: <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder> <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401114648.GX1463678@nvidia.com>
 <BN6PR11MB406858FAC3821B84CCC4D30DC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401131533.GD1463678@nvidia.com>
In-Reply-To: <20210401131533.GD1463678@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab588b82-73c2-4872-a3f6-08d8f514265b
x-ms-traffictypediagnostic: BN9PR11MB5338:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR11MB533859BA5AA522F164ED178BC37B9@BN9PR11MB5338.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mq6ezhVNfJSF0mOAR7bP/Yyh67Pei6ZHRzY77wMt4EWtYd3Ag9hya7bK4JHrs5G5wds5jiNx9cysC2P7Ye4ryBD1163RjSui9UA3vhJIpC46aVX/eeRHkMd2q5hx+7xQSvNbFAsxuCVBkJ0/67Smv2TbgaCTeBF9y6BMQMT7NnT7caual1uIkLwG69L5r6cVDt+E1WtQsLiodjdgVxtMnwx8H6MmjuDDahvOGMRmT5jpZvYYEa+C5HeIoO6V3zrchIN+NPFi/EnKVoua0ptin0RZ1rCcDJbjT3w+LZlt8j6KkgAhPdP3lY2DY6Ab3fr9d+yKhEtGMlXj/9xKEN0iU3nAl6xwbwArk9kuJzVydKjrgGa4/NLZJnatDwejFamgP84LOF2qLlSss0pazdPGxcqn+VU/1itLBCS/0c9esReqbrBvk5As6YQk/EP4xBimx/GBzZuDg8WrVi0ndrqrQI9bwyoDRevRTJfLsxKWtb5KkHDjnvcYHCROxbTqwALsPjmU8ZQhNiRv/mDka7w/X9dFS+fsLjdf25k2IvKzTthuN6UA5WkHE260ClhCaVYIJt1BYnC21Mw2LRRmuzaPNHvkoQh310KbeKcVvTvRCX8eZFwS0yI+NoCOLfNYKRu/o1AkcbR4flMlte4IjngDQaBQzSNclbBpsM0eI5phktLYobj21PxxdCL0YcmF32XvGwj7fVzceNsdHw5RB7/Bh2NmVQjguJM0UDy2crnSj24QCf1ofmxcZzOt+kHV/AN+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4068.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(39860400002)(136003)(346002)(6916009)(38100700001)(86362001)(33656002)(54906003)(316002)(186003)(64756008)(66556008)(7416002)(478600001)(4326008)(966005)(76116006)(66946007)(66446008)(6506007)(66476007)(9686003)(55016002)(7696005)(26005)(2906002)(8936002)(71200400001)(8676002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ZzJhq2YeSsT108F0RRzkdw7h0SzsmWsPSZsWxB1h5Egt415J5bGV8WkQJr3C?=
 =?us-ascii?Q?W6PAfso7naqILx72uzjkqVHP+fu8v+Dpuo5N0Qdlt205ZgVSh0EekqvSTWc5?=
 =?us-ascii?Q?bBer3gSKBCsoL+DkS8iEaPmkJnOSyHYpaQXEm/EYVpUrgcjQ2d5uSeoXt1Yo?=
 =?us-ascii?Q?jNbr6Jcf8ZoXxtp9q3LUQ7CetDLlkMnGnGrFf+KpzR3nNk1od8chhSKkvqtq?=
 =?us-ascii?Q?5XSYjGnV9+9R0ag/kQjfJW3OzcMhVBCHBCPK3SloOBa1ygI1bJa8hu4qR/yb?=
 =?us-ascii?Q?AqkUlCaZA9lx8l8actTqee3G822sv+iUZv7ef4UurZ++kh7pzErfw2XngeFT?=
 =?us-ascii?Q?vv8ADkMY5Heh5FkVziXyNKOkin+6Ifq0wIyujT7ZsvtS73oDi6WCm8W3t/wI?=
 =?us-ascii?Q?8VkDdswCumr414oEILWx/0NguBkYdF2aP4jxwekwI4/sz6FDOCIdu/UX0/jw?=
 =?us-ascii?Q?XzZldY0a+5aHdqjE/rZ8Ve7LSGh7kOQCf4KbvBPjlUX17cXCoH/IBAWbQ+6F?=
 =?us-ascii?Q?noIVjSg//Sz5jWGPSEDb46I+wnqLMgJgWy3nW+nF5xYukAlS79TfncrBfoZ4?=
 =?us-ascii?Q?yIdRD23+KhkeFR4vMpb7xr1/1DKps4Qx+U/LHCdFAOlo/dp1+4JMoqzb7dm1?=
 =?us-ascii?Q?/4KI8wYXY4Sjr1MoAK8ILQT00J0mfYPYYGVp8zUbEcSTHeMyi6jWzthau5Nk?=
 =?us-ascii?Q?Qk68Oad/p1lzMbaDfQLkFphXXO55iY6MSTWiwFmQ5Lcy8SgZ1ezlheezNZ3w?=
 =?us-ascii?Q?fSYMGYqjgjdVTyM12aV5bE0zwvQkrE55WeXnQ1cZgKNtmucT+uxA8E9SBdMp?=
 =?us-ascii?Q?gxwwx1a+4yw2JBbhxobxCNTZKc2EGc9hVUY8HteeNIOpfIIYbYr0wJyIm01J?=
 =?us-ascii?Q?WpU0NNOOdDfu9VZn7koREFjMOua1lPJY9e1yIOe38dhuIQtOMaer/tnfWHJR?=
 =?us-ascii?Q?NNLmEC4AtgKqekcbN+BI8z16oDghpbmJpDFhsXdD436Jz+9sEST/SjLLdYhs?=
 =?us-ascii?Q?RbRBe0anIXjnX2Iy+j9cQ6aThKxJFQ8SyB0WXRpxx6b3AKuO1yfOwExSAYPl?=
 =?us-ascii?Q?uU0zD/zjgPkaFiKq/GnDMST9vPANcSZ1XjcjOh+ugdzvuW9j+r7qIvk+sTG8?=
 =?us-ascii?Q?iDVE0Mp0PbI/bZzSZhDZnloyGPTBEekOcGUslgOLNWOqUFJgrvwndzXkOyA9?=
 =?us-ascii?Q?08/XgnfwTXY0E2BdJIT4lPx8tDjRnrsTa3HXelxF+Ss3u4hSaPmuygcejW1c?=
 =?us-ascii?Q?vpOIt3140GRG4dKmxH276XkHDLuJkfAXErh7eg26TW65vzEoYP7GmtM5kYX5?=
 =?us-ascii?Q?wJTOaSek4v8xZhoF/0ZOHLKx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4068.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab588b82-73c2-4872-a3f6-08d8f514265b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 13:43:36.2657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BHjtpmvrEI+mIVnTiahHEODpvLYFKTX2ApCuX0I/TmdeRm5xBYzwb1lLtsh5FoZuKxNEiGt7vtt7ekR6ZL+VZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5338
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, April 1, 2021 9:16 PM
>=20
> On Thu, Apr 01, 2021 at 01:10:48PM +0000, Liu, Yi L wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Thursday, April 1, 2021 7:47 PM
> > [...]
> > > I'm worried Intel views the only use of PASID in a guest is with
> > > ENQCMD, but that is not consistent with the industry. We need to see
> > > normal nested PASID support with assigned PCI VFs.
> >
> > I'm not quire flow here. Intel also allows PASID usage in guest without
> > ENQCMD. e.g. Passthru a PF to guest, and use PASID on it without
> ENQCMD.
>=20
> Then you need all the parts, the hypervisor calls from the vIOMMU, and
> you can't really use a vPASID.

This is a diagram shows the vSVA setup.

    .-------------.  .---------------------------.
    |   vIOMMU    |  | Guest process CR3, FL only|
    |             |  '---------------------------'
    .----------------/
    | PASID Entry |--- PASID cache flush -
    '-------------'                       |
    |             |                       V
    |             |                CR3 in GPA
    '-------------'
Guest
------| Shadow |--------------------------|--------
      v        v                          v
Host
    .-------------.  .----------------------.
    |   pIOMMU    |  | Bind FL for GVA-GPA  |
    |             |  '----------------------'
    .----------------/  |
    | PASID Entry |     V (Nested xlate)
    '----------------\.------------------------------.
    |             |   |SL for GPA-HPA, default domain|
    |             |   '------------------------------'
    '-------------'
Where:
 - FL =3D First level/stage one page tables
 - SL =3D Second level/stage two page tables

https://lore.kernel.org/linux-iommu/20210302203545.436623-1-yi.l.liu@intel.=
com/

>=20
> I'm not sure how Intel intends to resolve all of this.
>=20
> > > > - this per-ioasid SVA operations is not aligned with the native SVA
> usage
> > > >   model. Native SVA bind is per-device.
> > >
> > > Seems like that is an error in native SVA.
> > >
> > > SVA is a particular mode of the PASID's memory mapping table, it has
> > > nothing to do with a device.
> >
> > I think it still has relationship with device. This is determined by th=
e
> > DMA remapping hierarchy in hardware. e.g. Intel VT-d, the DMA isolation
> is
> > enforced first in device granularity and then PASID granularity. SVA ma=
kes
> > usage of both PASID and device granularity isolation.
>=20
> When the device driver authorizes a PASID the VT-d stuff should setup
> the isolation parameters for the give pci_device and PASID.

yes, both device and PASID is needed to setup VT-d stuff.

> Do not leak implementation details like this as uAPI. Authorization
> and memory map are distinct ideas with distinct interfaces. Do not mix
> them.

got you. Let's focus on the uAPI things here and leave implementation detai=
ls
in RFC patches.

Thanks,
Yi Liu

> Jason
