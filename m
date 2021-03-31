Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A799434FA72
	for <lists+cgroups@lfdr.de>; Wed, 31 Mar 2021 09:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbhCaHis (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 31 Mar 2021 03:38:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:58335 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234137AbhCaHil (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 31 Mar 2021 03:38:41 -0400
IronPort-SDR: 4XQhZCSyAZBiKww5OD+VIB76OUTMEh7KgRWgRqYfuAvkNU2LqfgNii/JbvDLx76BOguJ1KEmAM
 PJk6K6pbVsEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="179067239"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="179067239"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 00:38:40 -0700
IronPort-SDR: ASrtrsTw0W8OVbgAluko4l8EzLt8PPJV0YqrnXS5vPYKc9KsxEbhEw8jgRi3Wgot5a0TYG2/wm
 93l8x+rhdpZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="393924760"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga002.jf.intel.com with ESMTP; 31 Mar 2021 00:38:38 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 31 Mar 2021 00:38:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 31 Mar 2021 00:38:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 31 Mar 2021 00:38:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNaUoHazrsXS27JunOeGsNTIkefkEB+HWhN0f6FSxGUtLYY5CZ9+YQxAC/G90jzHoAhwMEmyGL2vL5CVY8UkRzMSZSodrwGQge2a6UaN77IVUnoycoxIzEHoxEGiIyIJbAFsL3NpT1cT7fqTywvb20NmNWDB6hpSLbeYQSpZWwGo2irdIKV9Pq29P1NOuG01SxiwY0CLTEPto7G8uK1V+XhO8YWaUnnaZ0LAJw5GFwUBtBaH9uSIACvch6Ujt6+hI9ufQkq2/V1kxNB6E0wcbUC0CVMaZk1emADfTNpumaKtqcBEB1mUUUQqkGX9UJIfeT/+uDTD5omDgQf0bzgOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfZzyYOvAgqrnoGy4DGuutNufYd5UpeVnhF9GtZcpq8=;
 b=AxLNeIbuDFofnJ08+yY3PuKxemOTKRz+bC/gAIn+O0e/5s0jfd+390jU4CF3R339OwvS/KNYVOvl/SMYOwudra6okFcOORqnPl4ZzO0EJYDlVyFlwAHBej7J5Bp69zVrigplGimMAaZZogDG9jDN91de31yRMNFSDbHc2DamD+1tK6bcA/oOqfOiDxgUOxxuN/dardnB/nO41cFaI0ZK44hfeG7ZyqUFPxf5qVnmfYxGRFA8mp6G2PUtb0WCKmQd1jlwfAuM4ghKwaPCpMRZKzbBrD7vAfCK+5L2AaC4Br8hdWxPrYjKZNf6mmXBpQKq9mZH2e7KdGQ1IELplYc7Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfZzyYOvAgqrnoGy4DGuutNufYd5UpeVnhF9GtZcpq8=;
 b=M2ZqP5AsYo/KWYNJELyXeJQn+IFAqaRuNN1lcfb5V0jsWIbURJR0u3buSyRrqVtC72a8TcJrmHBHumaaH1z9Gf5jelDAouk8kTdbZnPXDeqTpHxppNfx3xiE69+wiiRoE00KM8mOD9Kakp2/K9ZBOVt7F3oiJWNj90NS7l6dm1I=
Received: from BN6PR11MB4068.namprd11.prod.outlook.com (2603:10b6:405:7c::31)
 by BN7PR11MB2754.namprd11.prod.outlook.com (2603:10b6:406:b3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 31 Mar
 2021 07:38:36 +0000
Received: from BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d]) by BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d%3]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 07:38:36 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
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
Thread-Index: AQHXDZuc1/oaTFwUU0WheDxUmLBHiqqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAmFuAgADGxQCAAR7PEA==
Date:   Wed, 31 Mar 2021 07:38:36 +0000
Message-ID: <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
References: <20210318172234.3e8c34f7@jacob-builder> <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com> <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com> <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com> <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
In-Reply-To: <20210330132830.GO2356281@nvidia.com>
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
x-ms-office365-filtering-correlation-id: 48baf416-4ff3-480e-bca2-08d8f417fe8d
x-ms-traffictypediagnostic: BN7PR11MB2754:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB2754C671D291DCFBC2575928C37C9@BN7PR11MB2754.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +REA4Sh6AwB1+VF12w0yoRSz1zOHYycON0EeCqRIUSw3aNJJn5OEslGJ191ooUF6HPUfmRDLy6WNooAeYybhnay880nbvMtwvayQWog77mqLD1J+Fb2XK+AMCTnyyCs1d3uhPymWUaNUWTbWd0qVCGa9cOtnf4DhrywZkRd67pkSsfVDcsVrWaRmTgsFbZZZEwo8/72tncccHeCCyFdpvIsCNd/iRLAt92w7catzUmSfwiD8G0spIbV389Z+iXHxBb5mk74gRX5aGOdvb4CF8MWf5X/jBKdG3FeRt2V4Uf4UeuK5PloJg3jhmrBVm4UMt0ioy1pI5gRvPchU4M+QLtDkntNPxHqtKEUWtSCG9HeZqXEIXyAd7TlS3LgobvRah58nRIwXpq+74okOjbJQ8WeO1jvq/Xc95C/s7FBqIl6yRNo253ovK0XkqitYgpkKn6BraCILcU2vNiRi2p6jy0nNWTGiWxPUUeCv2frM5BOQfk6RNBYYKDkIo0lWlgGFjgERQ1MvVEpvT1CRDdQ6KkmPlrXJw80aOtc85DRzjwDGOUbAovsfEFXTX9fmlEuk4juiMIpEJRPQF0MyB5pj1xam1HCxRg5e+5+mRgHLuLrERHJYFcYLaEpsNFJu/Zz2ewXYGCTKeT6JXdQHUfDxltuOl1hcG0V/C7yisP2u0To=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4068.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(396003)(346002)(376002)(8676002)(7416002)(66946007)(6636002)(7696005)(54906003)(38100700001)(110136005)(83380400001)(52536014)(5660300002)(8936002)(76116006)(2906002)(66446008)(66556008)(478600001)(9686003)(33656002)(186003)(6506007)(4326008)(71200400001)(26005)(66476007)(86362001)(55016002)(64756008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bZuICoOgt+4AfebhrvdzHr/Vsq0+/qFqZdMGOt5BWtDhxw+0Bh3O8f4wfMqs?=
 =?us-ascii?Q?7ZbuHyNroG6yyyOLmWn6F6giO5BkG/cbqGoyF1ozS8Gh+uY12BLDah8o6U2P?=
 =?us-ascii?Q?6cFvftADW5r1Q9bH6tFzW9u6uh6/FcbXUGgVPYHj+KX1/PNmpOm9SLg4Jzlg?=
 =?us-ascii?Q?c/o3cbWRAgPg+pDNEt/Y/qUikOfRV0eHWayvR31YtmS4P4IpceTkHjwU3Cg5?=
 =?us-ascii?Q?apj5c5yTtPbyVGToknFlAyJDdglilZUjl2wLWoNKxkge1mh1go+vRCNJu0Ky?=
 =?us-ascii?Q?Km2opgurX4A3nUMioe/Q/vneZBrXf51n3FnO281W/x/yy8y8d/tZtsLfemEO?=
 =?us-ascii?Q?4hPYfv/KVtfgcrsXBpFOhC4kDm1PDpy5+baVmKF1mzwJGcvbS0saSN+ftT2c?=
 =?us-ascii?Q?MDIY6WfnffV0Z78DZ5uST+u8s5uH8QSQ50tBqYWsMwF2JjBuJ+t8Mgaq1zUa?=
 =?us-ascii?Q?govj0bU3K1+bhZde14n9/xSARIU9rXcByFnc2HqhJZXnpTLRIlcEzfM9013v?=
 =?us-ascii?Q?xWnu8ylNTgiXslzpE2sN5mO78DXJE3Ox1Q3HDSCUoSSWA94PJ4fYGr4X/GCM?=
 =?us-ascii?Q?B5fw3k9petmeBJO9CUKy+NKGCwxO45bLwOBYVSUAGWcHZrH1kWLbCjlONwL5?=
 =?us-ascii?Q?eXKfO0FCrc2lL3fe+A+cyX+5LaALoIb1E+Uj/M1TNJNy3JurcOU995O60Zou?=
 =?us-ascii?Q?C6DaKXUXIyMoSEW05Ys4lhJ3e/+ZYwHAFm8OWRv5hlNsw53sF/z5N1dczOOe?=
 =?us-ascii?Q?VeW2VuJevNp+zc/RxN41c9rtDByN3uGNbxkci2sRyxu3grX6jczty7BUd+eh?=
 =?us-ascii?Q?tVdigl3+NSPC8+OBrDYX5Dfs2TffiBt9Gaa6meRnzMBTQIV0hUvPeFNTZ3Ez?=
 =?us-ascii?Q?ITAnaAkNvlTi+7EEUsnVYnznTN/I6/ZjzmrtJzz4vM99rRHLLt6h+QxU5ChP?=
 =?us-ascii?Q?crF1E9k14eVfj+H4XDzPSju0YqqhxHETIhOJbFcoDlK7VK9Izg0pTxTBUh6U?=
 =?us-ascii?Q?MPBWuNhNVd4doUSBFk2o4uj40BnHPDTx/Yk9D3YUZbIKiQqHlaYgubV9wh/A?=
 =?us-ascii?Q?vMFC57DEh6iZ51TG78e55558ACrREQcY0udaUd0JN3jvPooxAL1bziEQIeXF?=
 =?us-ascii?Q?AGonVkDKawvAU7EXfv6negRyN73RhA/cwv0GIN2vxHON3WI7nH1GaME06ZBu?=
 =?us-ascii?Q?TcCwoTbJtCYvTHpDo6HwZjp4oGflg5Gy72QAqTm06fsml4AhgJ/vXSUCH6OK?=
 =?us-ascii?Q?b8hhQ5e4Orm+aZm6S8x9bjzKSLFMTYD3jDR/1GjWwvZjy3X9n8+FmzW7aPYI?=
 =?us-ascii?Q?NNlBO3RMFV+PPJgxV15adAuN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4068.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48baf416-4ff3-480e-bca2-08d8f417fe8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 07:38:36.3293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yh0ziNUEDKk6HLb9vkij/2GQ2MUY/PjfhsgOFfbrSYAe1iS3zDsJEKd9pVjZpmvyV7b8HjshaP+f9cp4qAoOww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2754
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 30, 2021 9:29 PM
>=20
> On Tue, Mar 30, 2021 at 01:37:05AM +0000, Tian, Kevin wrote:
[...]
> > Hi, Jason,
> >
> > Actually above is a major open while we are refactoring vSVA uAPI towar=
d
> > this direction. We have two concerns about merging /dev/ioasid with
> > /dev/sva, and would like to hear your thought whether they are valid.
> >
> > First, userspace may use ioasid in a non-SVA scenario where ioasid is
> > bound to specific security context (e.g. a control vq in vDPA) instead =
of
> > tying to mm. In this case there is no pgtable binding initiated from us=
er
> > space. Instead, ioasid is allocated from /dev/ioasid and then programme=
d
> > to the intended security context through specific passthrough framework
> > which manages that context.
>=20
> This sounds like the exact opposite of what I'd like to see.
>=20
> I do not want to see every subsystem gaining APIs to program a
> PASID. All of that should be consolidated in *one place*.
>=20
> I do not want to see VDPA and VFIO have two nearly identical sets of
> APIs to control the PASID.
>=20
> Drivers consuming a PASID, like VDPA, should consume the PASID and do
> nothing more than authorize the HW to use it.
>=20
> quemu should have general code under the viommu driver that drives
> /dev/ioasid to create PASID's and manage the IO mapping according to
> the guest's needs.
>=20
> Drivers like VDPA and VFIO should simply accept that PASID and
> configure/authorize their HW to do DMA's with its tag.
>=20
> > Second, ioasid is managed per process/VM while pgtable binding is a
> > device-wise operation.  The userspace flow looks like below for an inte=
gral
> > /dev/ioasid interface:
> >
> > - ioctl(container->fd, VFIO_SET_IOMMU, VFIO_TYPE1_NESTING_IOMMU)
> > - ioasid_fd =3D open(/dev/ioasid)
> > - ioctl(ioasid_fd, IOASID_GET_USVA_FD, &sva_fd) //an empty context
> > - ioctl(device->fd, VFIO_DEVICE_SET_SVA, &sva_fd); //sva_fd ties to
> device
> > - ioctl(sva_fd, USVA_GET_INFO, &sva_info);
> > - ioctl(ioasid_fd, IOMMU_ALLOC_IOASID, &ioasid);
> > - ioctl(sva_fd, USVA_BIND_PGTBL, &bind_data);
> > - ioctl(sva_fd, USVA_FLUSH_CACHE, &inv_info);
> > - ioctl(sva_fd, USVA_UNBIND_PGTBL, &unbind_data);
> > - ioctl(device->fd, VFIO_DEVICE_UNSET_SVA, &sva_fd);
> > - close(sva_fd)
> > - close(ioasid_fd)
> >
> > Our hesitation here is based on one of your earlier comments that
> > you are not a fan of constructing fd's through ioctl. Are you OK with
> > above flow or have a better idea of handling it?
>=20
> My reaction is to squash 'sva' and ioasid fds together, I can't see
> why you'd need two fds to manipulate a PASID.

The reason is /dev/ioasid FD is per-VM since the ioasid allocated to
the VM should be able to be shared by all assigned device for the VM.
But the SVA operations (bind/unbind page table, cache_invalidate) should
be per-device. If squashing the two fds to be one, then requires a device
tag for each vSVA ioctl. I'm not sure if it is good. Per me, it looks
better to have a SVA FD and associated with a device FD so that any ioctl
on it will be in the device level. This also benefits ARM and AMD's vSVA
support since they binds guest PASID table to host instead of binding
guest page tables to specific PASIDs.

Regards,
Yi Liu
