Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CB9352723
	for <lists+cgroups@lfdr.de>; Fri,  2 Apr 2021 09:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbhDBH6O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Apr 2021 03:58:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:11108 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233521AbhDBH6K (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 2 Apr 2021 03:58:10 -0400
IronPort-SDR: 625tC8niCGWl8Z/ppJcgK7lajFD0KPKsm+Z/+VUBFRnT8VIZ73G8IBl56XW8+Q+cwVAgpYJKp6
 MpB0A8Qt/f0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="253750586"
X-IronPort-AV: E=Sophos;i="5.81,299,1610438400"; 
   d="scan'208";a="253750586"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 00:58:06 -0700
IronPort-SDR: kPm3FI5VA4Hu53HlyKS3kbrVw8VHGTvSyLLIL/zKnW+/NQc/lY/KUfvghjYyS3hIsA1+UKQ8pV
 cJTtETpgCReg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,299,1610438400"; 
   d="scan'208";a="413073268"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 02 Apr 2021 00:58:06 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 2 Apr 2021 00:58:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 2 Apr 2021 00:58:05 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 2 Apr 2021 00:58:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wj4u5SHqCgS3koni4e438NWx1WbHTRU0wd9/UB16eNXXSi5RbCerAVx15mCYIDIhsRhEuZV9uYoPCiaKvoTO2XNK2Iys6gYvM4AJAkyHiX0gnxrcU5LIB2dggvM/KM7aKtfIInHxjaKzcJfJoMtbN0a/nsUQUZdWBo1r9ilETJ+458n99DSyuVd7fT8P431qkOPusPjaWP/QA4hOk4CXFzFrPTKvf68+ScZTUk0FEPvLHMMTjdwZICL9D6XBljUAx9fN8qP3ISZSpNZOMwXLP4fV4114ygtn4MELVP5Iti47rYsIjA5obiTpfTxpxi5EyCmx/iy1Pw6WAcWKEHN1rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWeTTys4ZZr6EAedqZXjJE18StmzLqZyNClmd4mJuic=;
 b=P/JyEIsYGg+OMeOrV2pbnsdrlxPjNsTDmRnI243pIJvQ5Q5RKMMy903ZPUQTyWTJ8igW3CN2knYRnYKxJ5lfGCkNNxvCMquSLxE4XVBSuuTinVPDXnuZlVVdqggjoe0nLjKBYrukbE/zhSnOa0P5p+r6sAZHlUg7sexVM6BseiycEP4/11sxus1jjA9atFYn3fmYauV+qIpn+dEhp3AKuL3T9B6lxE2nuwuODNrJ9+EfRpbqtUbVO2aCM6EbvIxaeDPG65q3zlHVu98arzuHXN2lu1V6SJWQhd5x9RJNseSsAF2BkOzA3zvtYVnEoc5g0uznz/5W/gAq+baFWtqojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWeTTys4ZZr6EAedqZXjJE18StmzLqZyNClmd4mJuic=;
 b=L2gICMo2IRqqXvoh/GtEHsIP9pQE9L0nkkdbUh9mefeDpSQX8zug4d1Oi/hqkwwpoziUi5RjkWUpzBe3oaUqaYMln//C68AYLHVsauRQlb0ZffvwWok8C4BqW5rQrxGX2vXCBBe0MfSwWyJSHT9/OW5NztkOqEi/ag6BwzKFmWs=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR11MB2062.namprd11.prod.outlook.com (2603:10b6:300:2a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 2 Apr
 2021 07:58:03 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.3999.030; Fri, 2 Apr 2021
 07:58:03 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
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
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAAHeZAIAAF3gAgAABVICAAAfXAIAAANyAgAEpdBA=
Date:   Fri, 2 Apr 2021 07:58:02 +0000
Message-ID: <MWHPR11MB1886C0804A0240998C110EE58C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401114648.GX1463678@nvidia.com>
 <BN6PR11MB406858FAC3821B84CCC4D30DC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401131533.GD1463678@nvidia.com>
 <BN6PR11MB4068C1A040FF61B4A9ABBD9BC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134641.GG1463678@nvidia.com>
In-Reply-To: <20210401134641.GG1463678@nvidia.com>
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
x-ms-office365-filtering-correlation-id: bdeac603-795d-4391-d636-08d8f5ad0ab7
x-ms-traffictypediagnostic: MWHPR11MB2062:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB206298A0771639CCA533ED5A8C7A9@MWHPR11MB2062.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mANVuvykxv/Gkt2ZPYfLm88tzSrNZPb/CfXGhCnzX8xX+ggDr9yXIdRSTUv3UPxwt/emPTu7Qn9lCO7oX7ySv9NeLKhCeDZ0XNpsVPQKsjcUrBH6SZ00p5+jPxPMSv1FsyyndY+uFwNOOiSOkni+eMLCqstnfB1T4Mtrt6SiwoY4fQeNwkxMX51uoc63JXhDrLqZvOi3gbyAI1Owc24Xm85ydLHIiGtVXAqAPpB/sAmdD0kLLYUdB44LqllfEGIAoA9X9Qq172jYoBIZEZTPbVZVGVbzLWCxkmyxuxsfpVGrsR3ikQ/Op9VzBezU4+p8Ys3PLTDAlPt/6xZ6/8mUqgPJr3t9FCPpttRTExF8bfApbWPNBVHpuGIU4UvSOC/FD/Z/VGUrhFz80AxSC9xp+9vP9WQVlTKnV0/8MkAC2wgizqlJBoKw0GGgxkcmCdGSi+9dr7w3DMXKIxWlAJNO3GWZzwvEsBFHSfIs7dUyKbVqFBjyffesdoR0ObJN5rKRsZpl+U/njDGF4YK+fhmEmefAHA+Xsk81GJjmNw/k5nQVzz72o0tQqkrYHsCjKKXAUeNU5qSVMc5YHLSt+zz/6+D5BnA6e660IJbpx9DnLGbcf6gV5pu1gVVM0XiurafIRUhRAlKxflaNdg+lzMsSGCG10DqAEZuV7QXG6+oZhpo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(136003)(39860400002)(376002)(66446008)(66946007)(64756008)(66476007)(66556008)(52536014)(7696005)(316002)(76116006)(6506007)(86362001)(83380400001)(33656002)(6636002)(8936002)(9686003)(478600001)(55016002)(7416002)(8676002)(38100700001)(110136005)(54906003)(71200400001)(5660300002)(186003)(26005)(2906002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wm7ckqy4DQvteq0FCX1cKXlWtowxgVR6U0JQDLHFlsfRVFVWxDpNnXxN6sND?=
 =?us-ascii?Q?+0Be4YoZzqDh8mIXwBAjahIkCctKET+kMWopfLwGDhoj/F2xQeeZsNqFXHaS?=
 =?us-ascii?Q?yKbQ5cJFUxGnjLoW1DU5u8S7qktWLCXbOTtYBYmS9xaeYMkEviFq9LM1AjeB?=
 =?us-ascii?Q?V6kw+2BPvWImVKlG0TteoJtDMNmHaaqNw4DHAaPOeVNadcQW3xv2itTNc5HN?=
 =?us-ascii?Q?tq7mtPnUcXYbVHZzCCugIyBTy7308x+aec4Vz4X0IJd12tJFMAnwXRTNudKt?=
 =?us-ascii?Q?R+o8CbenmCeOgsUvuYUp36o2YQXMUSsOgHqDxipXQiPc/BCIBE2DYWzhbw34?=
 =?us-ascii?Q?/vt1c3Wii4nhXd+KsZu2gceGLt2hykZcUjxlbli62xWwedDs6JxxAFTLpywd?=
 =?us-ascii?Q?iDvcZwE3n5iptFzlj95fGXzGPvY5kdQPV8lUROXEdAM+KkIuuKhpTxpLup/m?=
 =?us-ascii?Q?abZpOMWOdMuAA/ZdDkSssoKt4xgCGKZPJQRIZXdKI2aGYdlqqNdvdXipd+WS?=
 =?us-ascii?Q?qPnEmSnFCiec7zc+EHukNdwjr/Hso5nJ40G/qmNwiOaBvoEk00eIkjuoOjis?=
 =?us-ascii?Q?WEtJ9pMvfq0AXJadl4ZaAaKpaeE6968GeFYjtxXlCWsZCXVN6OFvVjg/7V53?=
 =?us-ascii?Q?t2Bjf1PY+oE3ZVcx2a+I/rNeI7zXx2scDA+c9Wxp8+uVFzfB/r3Z3aKoNwrE?=
 =?us-ascii?Q?PP1zd0jQf/RMu0yxkdP3v5/epqIK65iD3W0xfeWWgFUBqbcA4pOkw9RMttkR?=
 =?us-ascii?Q?riYOQN2IbmyRyK9oAHv0cPm8zVicKs8bd9nvPmePmgEjh7KSmIRga6zj18rF?=
 =?us-ascii?Q?And0SyfrJ/qIHDGLv5ZbL1smgeGSELZZQR4u+CDLDHY7wZJxQgnA+bYFAEYz?=
 =?us-ascii?Q?/kykAoLb6X4kSIMB4dpNbEKcLjY0PISIXj1khvnuVaAH5hSECbLRQC5zRXXf?=
 =?us-ascii?Q?2qV8WXl8tbQqC0JhwuVP3JxU0XQxx5ex1Ml5PXBlqShhmRHnkCGmte4syzqi?=
 =?us-ascii?Q?kqh71Xx+5UJL1A1K95kMp6Zx/1K3kCIuc85R0DJWB0YAF9smbz9W5H5bE7WT?=
 =?us-ascii?Q?Y+phTne6eH3B6qRdrVjAg6WfSiiYOIbOz0T6EuSbpH4dvDAbwyALq49RR1PO?=
 =?us-ascii?Q?tOXibcaP8BBvdhiNHoSnioYZCjp+gGrAeud5o/qF9ul5Od+I7tU0TUymUaBP?=
 =?us-ascii?Q?GfWBhIfPgDzlZCTee7CyiJAuA67RZYJzhbJFg+xaGc/ysepiOS0s7sQXBMF8?=
 =?us-ascii?Q?mwn4Gt1MPKUcbUsah9NiekfnP2hKRSHLBldnZqClxkwWHDAnjWzrmAfvkwSF?=
 =?us-ascii?Q?pt0wXZ17GXxogbvdBB5W1mWr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdeac603-795d-4391-d636-08d8f5ad0ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2021 07:58:02.8393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cjqgiz0//4pYKUyrLMGJW6RiJ1FKn2jyLFDAchxohURKVVeH5N6aPkakQx5UraWJcYCCUHrrtvXYOAP4bUQRxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2062
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, April 1, 2021 9:47 PM
>=20
> On Thu, Apr 01, 2021 at 01:43:36PM +0000, Liu, Yi L wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Thursday, April 1, 2021 9:16 PM
> > >
> > > On Thu, Apr 01, 2021 at 01:10:48PM +0000, Liu, Yi L wrote:
> > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > Sent: Thursday, April 1, 2021 7:47 PM
> > > > [...]
> > > > > I'm worried Intel views the only use of PASID in a guest is with
> > > > > ENQCMD, but that is not consistent with the industry. We need to =
see
> > > > > normal nested PASID support with assigned PCI VFs.
> > > >
> > > > I'm not quire flow here. Intel also allows PASID usage in guest wit=
hout
> > > > ENQCMD. e.g. Passthru a PF to guest, and use PASID on it without
> > > ENQCMD.
> > >
> > > Then you need all the parts, the hypervisor calls from the vIOMMU, an=
d
> > > you can't really use a vPASID.
> >
> > This is a diagram shows the vSVA setup.
>=20
> I'm not talking only about vSVA. Generic PASID support with arbitary
> mappings.
>=20
> And how do you deal with the vPASID vs pPASID issue if the system has
> a mix of physical devices and mdevs?
>=20

We plan to support two schemes. One is vPASID identity-mapped to
pPASID then the mixed scenario just works, with the limitation of=20
lacking of live migration support. The other is non-identity-mapped=20
scheme, where live migration is supported but physical devices and=20
mdevs should not be mixed in one VM if both expose SVA capability=20
(requires some filtering check in Qemu). Although we have some=20
idea relaxing this restriction in the non-identity scheme, it requires=20
more thinking given how the vSVA uAPI is being refactored.

In both cases the virtual VT-d will report a virtual capability to the gues=
t,
indicating that the guest must request PASID through a vcmd register
instead of creating its own namespace. The vIOMMU returns a vPASID=20
to the guest upon request. The vPASID could be directly mapped to a=20
pPASID or allocated from a new namespace based on user configuration.

We hope the /dev/ioasid can support both schemes, with the minimal
requirement of allowing userspace to tag a vPASID to a pPASID and
allowing mdev to translate vPASID into pPASID, i.e. not assuming that
the guest will always use pPASID.

Thanks
Kevin
