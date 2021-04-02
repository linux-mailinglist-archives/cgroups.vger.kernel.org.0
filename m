Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC373526EC
	for <lists+cgroups@lfdr.de>; Fri,  2 Apr 2021 09:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhDBHa3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Apr 2021 03:30:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:31619 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229594AbhDBHa2 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 2 Apr 2021 03:30:28 -0400
IronPort-SDR: W8dwnoC3Ef+gRckGim0xE7QE2XsAF5eYXMD6Hg+EFtDEbCErTSB1U0S3GkW2diDPwd7vyfQAHY
 cbgjatBMaflg==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="192515123"
X-IronPort-AV: E=Sophos;i="5.81,299,1610438400"; 
   d="scan'208";a="192515123"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 00:30:26 -0700
IronPort-SDR: RpzmoFbVcB3/7jBBKvKhN7a3bKQ1xqp8B0dgSkc0X2Za19nGO/BPiHw0GetAE21NsoS/pr6H5T
 8HXnEnuk9DwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,299,1610438400"; 
   d="scan'208";a="394859081"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga002.jf.intel.com with ESMTP; 02 Apr 2021 00:30:25 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 2 Apr 2021 00:30:25 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 2 Apr 2021 00:30:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 2 Apr 2021 00:30:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 2 Apr 2021 00:30:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYxzkBikel6gMpNOSOCWsxItEuuthdM5DsRGHgkHvgm9yT2LdiBUhKCW5mV/ma9wqhSG+Lhz+djkBvpB3Du5ydwUbZxIPPa3We8viDtxeDEolYJGkGAvikt92e6iGZ6ZRff1gc1JZicsuZ9wcH1guqbd/7H2KlKYCElOeMa+LShV/WSlBmeYE/f2Hn/YCQcW7H2cm7DCEA4daQfgTBPa5reQTehmdi7LW6rRAMYnluXuSuD79LhNIxXhQLIMLvTFtD8/WTUtkI3uwsbwG0hpI7kXT6BmZu9PBJeTjCbOu1tnwzvOsCdV3sfo0RxbwvF+Ad+B4smPpv/Wwr02/74t5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OXDwSVGuinNLD0v+qFjy2ozkCsQU3XD1qBtJfbpKEI=;
 b=YVxJd5u2/0xPNuLOgSd6FtcKhn9FMCfdJqSi8qjeJbyvelD9D8o56isv7QYm87zmiZ58BT1Nn7yOwi3OqSmbgOplqyOZmYgMuDeuKRin49vSDGPZtq7Hgk9qS3jVVuMmFRnD0vkFkrjwMvQLBIGvyRAbXbOA5rPTWSpuKIu1USqnjkqaRKB54zNw9fsKsVAuxrOiBEqAtPpO3Sa+/vOoNVDy4EMY24uAJTq5cNhTweRlmKVBQOOhxP+PrOVcbryesJjaLdHDOieIWI3XJyA9rK4X44VovoY3pG4xGL6SqH8Wmr1Ml6XP6bgcj2/+4gSrCfsfksa01xAY5kYdUsRvhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OXDwSVGuinNLD0v+qFjy2ozkCsQU3XD1qBtJfbpKEI=;
 b=IQ6nL5Je6NBN7yBkJGIDDMTL6lCaaftBcazseRUh5ptFy0YUM8djtTN1R+EQw6lFmVLg0uMS8S3CaUVfnripCt+FqEXOohNWJX3F4Vi4wkzBX/zPKWUVomOW88B+A5+jT2jgQamn6AadIPxF/nabe60aHXNK1DI0H7GeYvaJzyo=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR11MB1343.namprd11.prod.outlook.com (2603:10b6:300:20::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 2 Apr
 2021 07:30:23 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.3999.030; Fri, 2 Apr 2021
 07:30:23 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Joerg Roedel" <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
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
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAACiXgIAAVBgAgAAaMwCAAAESAIAABy2AgAAgOYCAAPrDQA==
Date:   Fri, 2 Apr 2021 07:30:23 +0000
Message-ID: <MWHPR11MB18866AB35A13A139262347FD8C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <YGW27KFt9eQB9X2z@myrica>
 <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134236.GF1463678@nvidia.com>
 <BN6PR11MB4068C4DE7AF43D44DE70F4C1C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401160337.GJ1463678@nvidia.com>
In-Reply-To: <20210401160337.GJ1463678@nvidia.com>
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
x-ms-office365-filtering-correlation-id: 9d3acda4-b60d-463c-c69a-08d8f5a92d9c
x-ms-traffictypediagnostic: MWHPR11MB1343:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB13436F4501254572BF8BA6AE8C7A9@MWHPR11MB1343.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YV8fDYrMK7VyP9EFuYJam/G1TIR8hVT5Atc5GCRL/aa5JGvgaBYqN615z8nYGIg8IwSnW7W7WJyqn2Qv7GTSiw8TUW+kwQiNnwsrMrV3GV3lYLhrG/mMYEXWL47Pbf9I/zCB3vtV1D5jqU3jxBi2E42rqpnHstMx/fzzKGcQF68aNVojC0/za5+lKcY0KJcJIb0DbFmYOw9SjJPu4QoPktW4XTVK/JDudg5Sz8xf1g53fYPuKAWkQAWAki+lLX0Y2xOZqxPmgYzWnfswDhsO4G3wkxiOjrJtAuvZEzXMdqJtU5c3QZlbW14bjqmt5+XxvohLxNFAJtCCcqTF49XZYknIFYzurC7KB/r/Hxf7stXHlz4e4yiJYp2eFmaAIBmGAhSBAj4X76m5uFdB5swBYvjhxKpBSkdzonke/nLQc0PMuRjcGjdW44xpwSNqTUl1ua052kHfp6F3fvXlGw0reu86jBke/M1QgNeE9ZJWKKpy7vIZNYG60/Usy/TWs6ZGztYAKGd/5XnPQSUNB9tliuRNwy3YVkbD6IqphUZM0DhntYY9iGkAFUbsIYkeRxz+IdjU8s3q3At4ONxP7S2mP9jJQP15oFHurBWMLei7AwMnHJUMsdvmVZioCgFnzj0BvepFfAgyBlXva1/WrIv2mDH0CfRW1oNlxcAp+N7WKfMMUfo765NJZ5JbS6c+z3WMMv9s4Jd3SxslbCQlShB7YDsncjjsJZyrFCphuJtQEVk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(396003)(366004)(346002)(376002)(6506007)(5660300002)(76116006)(71200400001)(33656002)(6636002)(7696005)(110136005)(86362001)(38100700001)(8676002)(966005)(316002)(478600001)(83380400001)(186003)(9686003)(55016002)(26005)(7416002)(8936002)(54906003)(52536014)(4326008)(64756008)(66556008)(66446008)(2906002)(66476007)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pnp3OigTpDViMAwuYDzOBcBIMu9NLaPdG/Cu/4X2oVxADAb6GXQwlkQFP60w?=
 =?us-ascii?Q?knLlYg3y+qxdIWoH5KW4oz2K4GYf/CSvIC4aLomwz6rJhZSGRYBVJcg7n1M7?=
 =?us-ascii?Q?EbZzPTOZ3G/wTA3/ubSTJuVe6eVYlF7w8yvgT6KGkizlHXvPyK7apgGAnKFZ?=
 =?us-ascii?Q?yZatlc4pwuj30w7n3dzN7/igMEc5b24R6HgB6rJl/9vyD7CsW31XcNK4mRCi?=
 =?us-ascii?Q?vNax5nAUsmt+aOETe1OaF9DrFSId85BQ+6UpBPE9aX0qFGOXSLbydXGrQJyl?=
 =?us-ascii?Q?U2vogt/0AYznzAlfqnTz7i/WzZ7L0JKgOrkIiKa6QfOTJ9hsEg6LTi86Fgkf?=
 =?us-ascii?Q?h21mRmozD6kDaruCl1rjcLn6Jn8jbXWpEepAokM5JV2FGisupOV1xib7uF3e?=
 =?us-ascii?Q?qdkcmwlWwTSNLFfOAU2EUw6T3/1xRWWkJzg2G660zi+GXfNYoGjdhw00Ng22?=
 =?us-ascii?Q?e5i1goXvveJsBohMt0siBD2pvmgX2GGq2iPam8mvYBIzUMTv0ekxYZte7m2W?=
 =?us-ascii?Q?15pxoz3OUcahfbV19UilbYX7uHHELCZ8GQn/BnKLG4nRcdyjXrEPBA1g5OJw?=
 =?us-ascii?Q?mrjXD16644UUv9S2cfkQ2nj3mPJ92RasvrWE6qRu6rMsm8OgWD+0RFIltwO/?=
 =?us-ascii?Q?soQE34/ZLQIzV68AGYhbm72msRYA9/r1FNSUoEg+jCxbe/V3gyFrFKhMhPgG?=
 =?us-ascii?Q?H2fS9SLZ7bhL1Ivtac4nTM8lMiKzwLHxxzY9WaUDj3euhX2+A3GcMfyvw3ok?=
 =?us-ascii?Q?G2HNnBuDIgDz0nX1PCJcpAube4WUV7ynJQo4h4dZnYB3cpP9YRVeTwMYPnql?=
 =?us-ascii?Q?ieRvyz7zC4SB/B3Q3XFmBJuQsO7yhoK5ojDiSRiMst9WZKG4FQbtPR6wtiLM?=
 =?us-ascii?Q?ii1dcASmsoN70PZ2bLDhOb3sRVg4F2NY982ryvZm1WQTEFDKe8hVpJenF9xy?=
 =?us-ascii?Q?9GLaboxMHGrFd4jUPgL6SwSzZdxDvgoaG66ABZuwB9R62XRSapySDkk4ujq4?=
 =?us-ascii?Q?rH6DT1EfbuzFWuB4+cYsVzj3tsS7QkIWLcNtLEiZOtb7mRSM5NwMe+4zxzD+?=
 =?us-ascii?Q?pEgm4SgtkHU1tl6oq2d1ks8CM521ISCIsCHsstPIH2qhPBWKOj0U5sufaP4f?=
 =?us-ascii?Q?DLofdm4QOyeSnUg1S0OKOpV5HIEiaPpXv53j9quqdHktGxihK4vBNpwFdc0e?=
 =?us-ascii?Q?SR2iv0fYxNV3rMw4xoyF+t8QxGghkcMgSC3lS4tSeESfJI2m1OAkKATagWgY?=
 =?us-ascii?Q?zTzRgsYN2lLecagFtMWE62GTIz4cgvUeJbTG3UL6vFXgQ3Kf3iYQQsOQBrxn?=
 =?us-ascii?Q?B2p8toH/kZWRInWudzj6s2Rw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3acda4-b60d-463c-c69a-08d8f5a92d9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2021 07:30:23.4473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FnL68DT2dmjkZ9ZHAS7l/HX6TYnEer/DSYVDnEv4No1nmrcxtfL/mO1NQ8lpnkzf6lmNKZi3rg/x9A8psAROgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1343
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, April 2, 2021 12:04 AM
>=20
> On Thu, Apr 01, 2021 at 02:08:17PM +0000, Liu, Yi L wrote:
>=20
> > DMA page faults are delivered to root-complex via page request message
> and
> > it is per-device according to PCIe spec. Page request handling flow is:
> >
> > 1) iommu driver receives a page request from device
> > 2) iommu driver parses the page request message. Get the RID,PASID,
> faulted
> >    page and requested permissions etc.
> > 3) iommu driver triggers fault handler registered by device driver with
> >    iommu_report_device_fault()
>=20
> This seems confused.
>=20
> The PASID should define how to handle the page fault, not the driver.
>=20
> I don't remember any device specific actions in ATS, so what is the
> driver supposed to do?
>=20
> > 4) device driver's fault handler signals an event FD to notify userspac=
e to
> >    fetch the information about the page fault. If it's VM case, inject =
the
> >    page fault to VM and let guest to solve it.
>=20
> If the PASID is set to 'report page fault to userspace' then some
> event should come out of /dev/ioasid, or be reported to a linked
> eventfd, or whatever.
>=20
> If the PASID is set to 'SVM' then the fault should be passed to
> handle_mm_fault
>=20
> And so on.
>=20
> Userspace chooses what happens based on how they configure the PASID
> through /dev/ioasid.
>=20
> Why would a device driver get involved here?
>=20
> > Eric has sent below series for the page fault reporting for VM with pas=
sthru
> > device.
> > https://lore.kernel.org/kvm/20210223210625.604517-5-
> eric.auger@redhat.com/
>=20
> It certainly should not be in vfio pci. Everything using a PASID needs
> this infrastructure, VDPA, mdev, PCI, CXL, etc.
>=20

This touches an interesting fact:

The fault may be triggered in either 1st-level or 2nd-level page table,=20
when nested translation is enabled (in vSVA case). The 1st-level is bound=20
by the user space, which therefore needs to receive the fault event. The=20
2nd-level is managed by VFIO (or vDPA), which needs to fix the fault in=20
kernel (e.g. find HVA per faulting GPA, call handle_mm_fault and map=20
GPA->HPA to IOMMU). Yi's current proposal lets VFIO to register the=20
device fault handler, which then forward the event through /dev/ioasid=20
to userspace only if it is a 1st-level fault. Are you suggesting a pgtable-
centric fault reporting mechanism to separate handlers in each level,=20
i.e. letting VFIO register handler only for 2nd-level fault and then /dev/
ioasid register handler for 1st-level fault?

Thanks
Kevin

