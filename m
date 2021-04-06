Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0373A3549BD
	for <lists+cgroups@lfdr.de>; Tue,  6 Apr 2021 02:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241675AbhDFAhs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Apr 2021 20:37:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:2332 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230309AbhDFAhr (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 5 Apr 2021 20:37:47 -0400
IronPort-SDR: 2lOXcTkuyjtsHHXpvD42HNS2XQVv9ljA19cGLbQ/P1rMlWuCaMH8lre3ep39w4bYEGEstDLy7a
 OXaBQ1Wsha+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="189735386"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="189735386"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 17:37:40 -0700
IronPort-SDR: CBpVpxUAMyWu262HKEnI/S5KfB7WLBvNWw+WKISq4vS2wYw3RWzyqkfNy46lD9GgviE3WjyeWY
 iRM38bDE1cVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="448291843"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 05 Apr 2021 17:37:38 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 5 Apr 2021 17:37:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 5 Apr 2021 17:37:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 5 Apr 2021 17:37:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLuO4Ga0hNzovjn6I80g1qZEUhFE+w5Fphr1F1VT4CvF+9UKuaCln3Ntg46gydG+AXtiA5rV1wXkdKopSRlnkc6BV+FK5TM4wk2bNoMxQx+CZmG/CdyQ1aIcOEPO00XilY3n4cBDULMXUqv1i09NhD2vaOjaJ1colOxceSOQbUZoxiKy6thnjMBUSeqPocRvWC3tAP/tn0ZgCmdVI6r+NuzSvsgonrkd4N6CotAIMpb+knhXWowieCshe07XDPomHSOdN1vaAjyVHKLnXRgKx8zxbEW74D2NNZbzyGYfAd8rEQhw5BTQWW+QRcqgum6RLx/oFPquqY7lQwhDewcmwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyw4OneNeXJqKL9NBPjmYCJ76IrpWZauWPyDllAWzuw=;
 b=cza3FXBVgO+ttUTN1lOlKR1HancXR158/8bIe9L2E3yGjgFtZeWiOXRebiFxyXzB2Fi+nyEcbyFt6nqy/X5FSGX+Fc4Hil08PGsSjfnpyZcgxkva1AzF0eKz4n1a0WMVxtjvY4voGii9AsbWOE+v3Z5ytb2e8EOSUipUWpof7jmPLuVuVCjbjbzRGD7288rSRju8gUHCJoRLWteTAyM9OTzv+5J5+3Oib2EN9EYeChT36qwbZ5dJ2pQ5R9BlOwOu3VMyoCCDKFVV8J6QvfdYxj4z/1vYA4DESsAMZUgT/EooaexhhQyhKq3LJ/OmqI5CxoRK5zuq9TbrnE152BqcRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyw4OneNeXJqKL9NBPjmYCJ76IrpWZauWPyDllAWzuw=;
 b=Ppiujj22mWzJhwmUmkyj2GExLjOqXidQIHb3RhngltsxJYEe3cwtXI5ZhNjARtW1c4XFHlZMvZF19UXPMgfuZWS18Om7iMMY9KGtB1Hxlk8L3OhTR3ixXNVSxKZndEm5i+Rp+ciGNr1CH5zpcvUJV9JpVCaKW+hmYK/VDhaXEQ8=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB5139.namprd11.prod.outlook.com (2603:10b6:303:95::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 00:37:35 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 00:37:35 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
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
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAACiXgIAAVBgAgAAaMwCAAAESAIAABy2AgAAgOYCAAPrDQIAFzM0AgAAN9gA=
Date:   Tue, 6 Apr 2021 00:37:35 +0000
Message-ID: <MWHPR11MB18862BF4EA4DC0CFDE6CD2238C769@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <YGW27KFt9eQB9X2z@myrica>
 <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134236.GF1463678@nvidia.com>
 <BN6PR11MB4068C4DE7AF43D44DE70F4C1C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401160337.GJ1463678@nvidia.com>
 <MWHPR11MB18866AB35A13A139262347FD8C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405233526.GD7405@nvidia.com>
In-Reply-To: <20210405233526.GD7405@nvidia.com>
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
x-ms-office365-filtering-correlation-id: 80bd1b22-1892-4771-2509-08d8f8942c6e
x-ms-traffictypediagnostic: CO1PR11MB5139:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB51392D547A8D7A5FB57D2B7D8C769@CO1PR11MB5139.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5429ftMopp8pTp717tpwKDoETky8mh9bJMcpx8uSzDRQNla+A2Zy9krJl6EjZINnxwSb0NNUOdxigFkPyI8GhBpzY+O1OfeBZDpDP7KxrKYEtNQ3D2Nco7l0XxUmGnoUE+tb2AE/rT46QhxbNO/4q/XdpF8FwvTnx0jx91DrjTYYIkEBakJ+nOyYLlO7fXoTb9HVbtKd5aFABe0HmnXjRyJa9zD/aY490P04PbakDaFVkkmAba5F8xny0zX8Z034iyEhbfm7DehYYg14vjPXqjYGQf1ky4S/E+Y4gAgiXHyGUf7q7PO6EEn3ZDOL0QluYcoCHC64i8U9MVxn6SbdhwAhAc9X/OiJu/8WS6skNK94+Q1N5XS1Tu2TUMsxld1i5+vBQpm40x06qbmSOzh/l8LIvTL4ku8gCiN3vVEGbVPppeI6d0w93tatsHY2O+TnSVpOosUzCzVIZ15qFRErhklD8qA5icd3zci9hc08xcimOntS8ZkYKd8Lzjqdu0UAM6R7xuICa9Nydu/CXWaWHKyBekq051KatUAz5uAK23TOnIpePkTRGJiu45zh3QQl95ceeR6oC0G8IZsRoHnsJ+Or3nD/gtuzvbOCuSHa++LTkgNwvDrmJNRU+qQvQEr2E5n4pOB5ft1z5Vp3fQ3FVSTBzWrfrSMbuV5N3Il0ueQMHUTUY2wDnZr9NiBqq8uFh4GwCNb0VzFIxRMFP8Y3TlcRDgha34uNRVkgykZu/Kc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(346002)(136003)(366004)(8676002)(33656002)(86362001)(26005)(66476007)(76116006)(66446008)(9686003)(66946007)(8936002)(4326008)(7696005)(6916009)(186003)(7416002)(966005)(5660300002)(64756008)(71200400001)(66556008)(83380400001)(2906002)(6506007)(478600001)(52536014)(55016002)(38100700001)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6nnPR4PjWltzvBCNY2rdgu7VKloRFaTFQACs6cnn1ZhLpxXmlHB9F/5kV2sw?=
 =?us-ascii?Q?2EZnD7CRBfJlgia+aGJ254YXLw6Ik8UWLe7jcy3R9yRZe3q4LjJ65cQIOEmJ?=
 =?us-ascii?Q?kNfJ+bH1/Y4auK/7JjiOH1DV0UDx54RGQTcHuZGodwHbIAGxkDVQoPmzf7BM?=
 =?us-ascii?Q?h7v3rQ9CFqmPYt0h2bkpqXY0uSsW72hrpLuxz7uobxCJ3HHv3l4xyIM0yJF6?=
 =?us-ascii?Q?YJBtMW6kbJFmunXNU20XkxJCJg2cTg0HrDMhhPLV4Lk2vVrg0FgtJzP/wT5N?=
 =?us-ascii?Q?Old3pn93z5n1cFKluSGx2N9ZtebWq2iYCd6E1sZlE97Us3qtaJ8lYd8wcRwy?=
 =?us-ascii?Q?mZAhaG3FZypPLlP2RY7/VuzN3XRY7xgRiCOVnMq2aLEeh+mg+LT0G3ZG9fru?=
 =?us-ascii?Q?nX0zu9xerInWP0xfV7SAbJZaApb/JPkH26DSwyh3qyuXCiQXY9hJdJNBi676?=
 =?us-ascii?Q?B99XFbc//qyaS+ujz2TB1sG8zgPpY2UG4HSR5j1Q8dbgYzT5u2jL4qOvoWFg?=
 =?us-ascii?Q?u3qSvyrh1bDiq/RhxrXM7boeCgGwYET/8LxsBA+WWLeDvtsY40BJpABnXN0c?=
 =?us-ascii?Q?GJROh0BIwORZFVAOBgTIy4SpNp6UADCh3y4EURBrgyXzNVDpkfc+PcBMxxZ1?=
 =?us-ascii?Q?2oNLw4+bo21eMES2gYT6ZRzf2kDg+EvWVELJovqE9vjtoUe4Uquay0fh6Khn?=
 =?us-ascii?Q?9GRGayVri/irL9UU/emOV1shX5WzQxkE2LwCGY8Q3VSc0gFznA6nUn9xTHoD?=
 =?us-ascii?Q?80BtziFsOaRz2CAfYzHPcRMI4r9KokH12cizZpWExF8E3AiwjtYVV6gHr/Kd?=
 =?us-ascii?Q?V91of5YyyD8Amf9zJQmVXDn+VCOvHrwWI0s1hsu18boVivg/EBWaBsMRJphr?=
 =?us-ascii?Q?kejrpGCuPdpQLwe4misGP9TBpa0X1qkSn/ZTWvD6foam/WQjqh40SF0yp5o8?=
 =?us-ascii?Q?tBXwsY+f/aV/SCA0aEYJu/3yakX1TGUmXzoPTUNr38uZkYGu2vWwCjZ3ekaV?=
 =?us-ascii?Q?iHMskLA8rZHZH9a9I3FbHbtpB6vx8nsqJHOPJOedGhvCxhrOjEfGzmy+0dpp?=
 =?us-ascii?Q?2KkYX6pcQuUR2LZ2ycwtNSZBxTzTvMqE/R6izKWgyAfVz/CN/5mjEMMSjaH0?=
 =?us-ascii?Q?S/W8T7g4ntp1IdxFX4gOytv5v5qjvbAbZ+7GVOYYa/qqmLIrHciz87FsRVeP?=
 =?us-ascii?Q?EDRiIyDSVC0LVL8wCNoLrY71X701BOHVJ6CDsNkdnkBf7ZvR20UR12AvJolY?=
 =?us-ascii?Q?2Uoi40pt3g0EAKFIlhTjHSD2G42hVW4mlm7vGp3J+b9z/43I3JEtZPO8d2FU?=
 =?us-ascii?Q?D6x5TtRVF+/1ckdcTRn6nvBM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80bd1b22-1892-4771-2509-08d8f8942c6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 00:37:35.5050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /NC1TqiCytAXI4lbR/bAwBo11jgnABacWy3q4FX5Di1Xw9Sq0P7EWCMTkG+3bHp3ddyTLPBeIuwdo2k1uKYv3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5139
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, April 6, 2021 7:35 AM
>=20
> On Fri, Apr 02, 2021 at 07:30:23AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Friday, April 2, 2021 12:04 AM
> > >
> > > On Thu, Apr 01, 2021 at 02:08:17PM +0000, Liu, Yi L wrote:
> > >
> > > > DMA page faults are delivered to root-complex via page request
> message
> > > and
> > > > it is per-device according to PCIe spec. Page request handling flow=
 is:
> > > >
> > > > 1) iommu driver receives a page request from device
> > > > 2) iommu driver parses the page request message. Get the RID,PASID,
> > > faulted
> > > >    page and requested permissions etc.
> > > > 3) iommu driver triggers fault handler registered by device driver =
with
> > > >    iommu_report_device_fault()
> > >
> > > This seems confused.
> > >
> > > The PASID should define how to handle the page fault, not the driver.
> > >
> > > I don't remember any device specific actions in ATS, so what is the
> > > driver supposed to do?
> > >
> > > > 4) device driver's fault handler signals an event FD to notify user=
space
> to
> > > >    fetch the information about the page fault. If it's VM case, inj=
ect the
> > > >    page fault to VM and let guest to solve it.
> > >
> > > If the PASID is set to 'report page fault to userspace' then some
> > > event should come out of /dev/ioasid, or be reported to a linked
> > > eventfd, or whatever.
> > >
> > > If the PASID is set to 'SVM' then the fault should be passed to
> > > handle_mm_fault
> > >
> > > And so on.
> > >
> > > Userspace chooses what happens based on how they configure the PASID
> > > through /dev/ioasid.
> > >
> > > Why would a device driver get involved here?
> > >
> > > > Eric has sent below series for the page fault reporting for VM with
> passthru
> > > > device.
> > > > https://lore.kernel.org/kvm/20210223210625.604517-5-
> > > eric.auger@redhat.com/
> > >
> > > It certainly should not be in vfio pci. Everything using a PASID need=
s
> > > this infrastructure, VDPA, mdev, PCI, CXL, etc.
> > >
> >
> > This touches an interesting fact:
> >
> > The fault may be triggered in either 1st-level or 2nd-level page table,
> > when nested translation is enabled (in vSVA case). The 1st-level is bou=
nd
> > by the user space, which therefore needs to receive the fault event. Th=
e
> > 2nd-level is managed by VFIO (or vDPA), which needs to fix the fault in
> > kernel (e.g. find HVA per faulting GPA, call handle_mm_fault and map
> > GPA->HPA to IOMMU). Yi's current proposal lets VFIO to register the
> > device fault handler, which then forward the event through /dev/ioasid
> > to userspace only if it is a 1st-level fault. Are you suggesting a pgta=
ble-
> > centric fault reporting mechanism to separate handlers in each level,
> > i.e. letting VFIO register handler only for 2nd-level fault and then /d=
ev/
> > ioasid register handler for 1st-level fault?
>=20
> This I'm struggling to understand. /dev/ioasid should handle all the
> faults cases, why would VFIO ever get involved in a fault? What would
> it even do?
>=20
> If the fault needs to be fixed in the hypervisor then it is a kernel
> fault and it does handle_mm_fault. This absolutely should not be in
> VFIO or VDPA

With nested translation it is GVA->GPA->HPA. The kernel needs to
fix fault related to GPA->HPA (managed by VFIO/VDPA) while=20
handle_mm_fault only handles HVA->HPA. In this case, the 2nd-level
page fault is expected to be delivered to VFIO/VDPA first which then
find HVA related to GPA, call handle_mm_fault to fix HVA->HPA,
and then call iommu_map to fix GPA->HPA in the IOMMU page table.
This is exactly like how CPU EPT violation is handled.

>=20
> If the fault needs to be fixed in the guest, then it needs to be
> delivered over /dev/ioasid in some way and injected into the
> vIOMMU. VFIO and VDPA have nothing to do with vIOMMU driver in quemu.
>=20
> You need to have an interface under /dev/ioasid to create both page
> table levels and part of that will be to tell the kernel what VA is
> mapped and how to handle faults.

VFIO/VDPA already have their own interface to manage GPA->HPA
mappings. Why do we want to duplicate it in /dev/ioasid?=20

Thanks
Kevin
