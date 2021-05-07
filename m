Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1E43761AE
	for <lists+cgroups@lfdr.de>; Fri,  7 May 2021 10:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhEGIKI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 May 2021 04:10:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:53000 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235320AbhEGIKH (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 7 May 2021 04:10:07 -0400
IronPort-SDR: zz/ve6QJHLymPwKyiGD8r9k52twuggFFKh3W/7ApN2NeaD8BNDqKdU+roGNfUyjBPg+Uiy7/dp
 YltE8n/rcjFg==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="219575452"
X-IronPort-AV: E=Sophos;i="5.82,280,1613462400"; 
   d="scan'208";a="219575452"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 01:09:04 -0700
IronPort-SDR: fU/o1qdkipg1TFrGTjdVbw1wKan+PmGyZzmbbDS65g5W+1WrPaJ3cpgXD7MuX4PhNIJOVtG7UW
 xwGDqreWVmHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,280,1613462400"; 
   d="scan'208";a="452955524"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga004.fm.intel.com with ESMTP; 07 May 2021 01:09:03 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 7 May 2021 01:09:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 7 May 2021 01:09:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 7 May 2021 01:09:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOpxL4pUFIRS6HnPA4uBoPSkq8g0xmtcy+tAr032oyGC3dL9hAsv46AGfMVzdwjRxCXaa5bVNv/4labDE/YGXjBIPHhZiLHnAHVrZtKhWNpx2k/R1+ldalxPYaGgfn34rq/6CsJb7vRpJzw5sw8kyP2nCLMBvX853x8t4ONALZnZ60udUnE9SR4JPrrvHhSNPCxfFCsacMwBDxPfZID31FlVZRTO08dCXF8r4RMt0q9fh71XDcu/J+1JkCzW6qjlqqmkE2tCjveOwZrUpDS4vM/PrsmI3XRvqQj8djqwMdGa5W7TghGxxkhCJ0apRh1mvyu1YF6o51kIP7tArEGyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKlAyCWuOOlsywhJS5J8wOLBZVb4WXOd8E5/iTO+3p4=;
 b=AyoWizmKVu0fDN+gBMiWQOpTmi1ZS4jWsXRN2mnM5OpguPxTKo2UmIdW5zxYDZn9tEBal/U05gsYZGCQ7C+D4no7gKcENMVZPGTfYRFwKF2Bmnjjs1yJ2WSa2iMBNHIVTOaZhFXwdQ54kpeHPDomBxSTaRMCU/1mvYJAH1AX4OAbKQ+TD1EnIhsNxEfTwJWmvmKs6HdeFRnuk6S/EDS/SMraBxuhRyhzdnGcEqnH7J8hwLD698p3Ycp2GSQ5Z3HApXtdjMZVqNZWHpNdcKMxDNDa3lcbuDoCY7NEeD0rdDqJ22FhEq5EUB9D/e9tSoP5UUCRITUhK27DdAOQs1Iibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKlAyCWuOOlsywhJS5J8wOLBZVb4WXOd8E5/iTO+3p4=;
 b=WJqzF6PNdll3Gza4Bk+UCeyOVAPCqjDQs2lQvq0r14ncY1xk5bNhiNKBfzZraXg4rZggx5zGCu/sjwLH/4J2IRETQJB8BRpgl0nQS9e3F0SBjtsUsRLVu8jLIpt24hJObUdb9yaMRzrQFL3SWzitDIota/42ZARSqrhcMypd22I=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR11MB2064.namprd11.prod.outlook.com (2603:10b6:300:27::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.44; Fri, 7 May
 2021 08:09:01 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4108.027; Fri, 7 May 2021
 08:09:00 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     David Gibson <david@gibson.dropbear.id.au>,
        Alex Williamson <alex.williamson@redhat.com>,
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
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Alexey Kardashevskiy" <aik@ozlabs.ru>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAACiXgIAAVBgAgAAaMwCAAAESAIAABy2AgAAgOYCAFdCAgIAAppUAgADsNgCAACqygIAHsmaAgAAzsYCAAAjdgIAAD/yAgAAcQgCAADqggIABMLWAgAAMMYCAABwXgIAABlIAgAAsEgCAABE9AIAGpToAgADKIACAAOE64IAKH0EAgAQWJnA=
Date:   Fri, 7 May 2021 08:09:00 +0000
Message-ID: <MWHPR11MB18868EB21E0D8085D65ED7988C579@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com> <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com> <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com> <20210422233950.GD1370958@nvidia.com>
 <YIecXkaEGNgICePO@yekko.fritz.box> <20210427171212.GD1370958@nvidia.com>
 <MWHPR11MB1886F0818D30329172C420758C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210504171246.GZ1370958@nvidia.com>
In-Reply-To: <20210504171246.GZ1370958@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f28c83b-9db9-45cc-3f24-08d9112f5f50
x-ms-traffictypediagnostic: MWHPR11MB2064:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB206489961E3CB5EC65391A488C579@MWHPR11MB2064.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8UGpiF6iNICsUOrr9euh5FgrdDgFNpEpl74SZmasMXKAMWBT7YCiTSVDR4kKpCJXb4drHtZDM34E2RZ8bwTAG9cprqjJZds6ZNnC67+nadNCjKBPQMN2tLRnmWdQByAyvF1ISTYpcnhGytAEk3FW15CbHH18gJle1Ak/g7Vc68Rza4zlBXO4airNP6XsN6mo5p9jXXgyswhqOY5SN4tG4Z7BHPBiCQ04X/zcDhHWgZQxDC2VyqUuZBiTrSUnAw/Ha/gqQAJ7RsbjDSHyLYt3onMk29qoGtwl+i+Hz3XfuuzfFtSPALcZLYAwmAgWH5Q2Vq0VppXWAnatCtkj0wtfa1fGhuVojx0Wn2KhFOUIXEeCCgQW4B6CaxWR7IrQqcA/WeyY+7T/+RZ+Ar0yW/ojoY8JlSA9dHzQM+VsieLvp1UZGAGuSd1vltmO/wDMUxl5dWl3a01zwXX08O99pMCmhCUgmubAw+3BIeM16/cKvIBss/EsNWMAP0425YpOV3/fTAIjOZCvoYT2YX9TD2nkdPrW2J2d+izxhrbtvMthRReED2tfOoSx9/c9iED531JmzkqAzhNlREkDe7zQ+wlhNPeLGoFxYYpJ72SabUY7zXp8d/S/kfKPCFhxetAPKToxJZrNkqdCzFine1uyT4m4MQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(39860400002)(346002)(396003)(54906003)(7416002)(38100700002)(478600001)(55016002)(9686003)(122000001)(5660300002)(316002)(26005)(64756008)(66556008)(6506007)(7696005)(86362001)(33656002)(66446008)(66476007)(2906002)(186003)(4326008)(8936002)(83380400001)(76116006)(66946007)(52536014)(71200400001)(6916009)(8676002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nr8/ympeKSFpvPpPKwk0spOagr2Pct30Nzg0mX5QgVQ9QgZqXUZKh3mAOCfy?=
 =?us-ascii?Q?5t/jvV5Jl97jq5z81Vr0/AC1Fyg/y0P0O05v9M8SUZTxavOsUSkoGqylBoI5?=
 =?us-ascii?Q?uuIcxSxc2acs7ThuJ9wCR56jz0eNAg+gZ7QIHzIXpy53nZ9U6KX+q2qmLXxA?=
 =?us-ascii?Q?i2rzk0wXNnxytAu8/c2juZTz8Rm7DqBMzjGroKFh6/wAQA/EChBT3ppzUOmP?=
 =?us-ascii?Q?34wEQHL0Ejus0v9d0p1FU9BH7Wovv2jPeOJRPV6t/aBSUg2O6btUwsWbp5sm?=
 =?us-ascii?Q?HiAtrE3zGi9dls87z8A91podzeD0kA5KWSm8fAHdNBSbaxKOkfoSAV6a88Z5?=
 =?us-ascii?Q?v107aQBURKe12Z1mrjeGQHTaHQice6C7FKEqnprR5TNNZaXpyI2rndcuLHDR?=
 =?us-ascii?Q?UJKVlswxj6KnsuFFP8Y3/ySlXkiKf1FaXI8MH6hqsvlTM2L1Lm3Tn8OmIFMz?=
 =?us-ascii?Q?/sh7KtbhilovB4BNZNGDqFjIzh1s1zc/7YPY/zS6YrSWaIB4YW4e8oYR2of3?=
 =?us-ascii?Q?NhobiJACthMUPpT3iUwOUFm/PkAyaGfxuI0aSsnhJG+5g5sy30/dTh0f2pai?=
 =?us-ascii?Q?e/FjRpyGcL4GCIOeD5iUXl1IDo5cK77kEC2VCxuBRO6QXnVzYyhlelA7WznR?=
 =?us-ascii?Q?W3PPV3kcdb2zf2ABY8CpZXMBQ87T/XVPl4gQPBNM/Xnc/tCmZnrimEkTbUI6?=
 =?us-ascii?Q?lcynfB2sejcaSsjRI7xHvFYkfPdHnhvSgIyf+wIuPRJ0972wU2pzOLxUmufw?=
 =?us-ascii?Q?8fUaEp7K8qA2BxxEfekJBhEayyhxGlzM0ohX6zM74ctLKOclh2c0RrxNJ+3Y?=
 =?us-ascii?Q?vcRTYtQMZCvBA2kznc7DBmi8hf9sWXm1YIyaQ5+2uFhMGCLyAfqQR9n7nkD7?=
 =?us-ascii?Q?yoO/gejI0cqLhLznrQnDYVyfYv4zOu4wi6dggtGwMV8VHrQuWU8NrmNqJSoH?=
 =?us-ascii?Q?DfOd6zAfv55vTejmdzcHr5Fl54vj/JRKgz5hfWU4khfLIRz7qCbG3CDeixF3?=
 =?us-ascii?Q?HFFaruvejAL/j+chY/7TMGI/DYc/PyOpU6YTvadePFeTc3uCyGGWD4MsOueb?=
 =?us-ascii?Q?JBzLz6gO6DOaBfHGiLNn8T8xEgVIrvkKOQAe7oFmyr0anTwByVUFEwT78S+M?=
 =?us-ascii?Q?BYItfEak7cyrRb6DQ26inn2mGCYr5hy4x3jMtwaJ2X1kIBtj1djkpHUOlfK8?=
 =?us-ascii?Q?9EneX5MWf5HkccMf3VLNFE6UvP3BZ1luo9+Vv8X3dCg6EBKyxOdt/ULaE5EB?=
 =?us-ascii?Q?+8pMbuicAJSMG+jXzYheM2wqkk62moEdKrnIN23s88LiIvn2TrCi8LlFwPyX?=
 =?us-ascii?Q?LjfbtsEPFuBA39h0xKFhjxA0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f28c83b-9db9-45cc-3f24-08d9112f5f50
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 08:09:00.7366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6MGYrnKBN7+VJRDdauDqbaUedu/xTwlg9UR9T+4KxXUfVBp3gQuLBektt5egHyrjgRQOyBXaS9uu4SbO+mA4DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2064
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, May 5, 2021 1:13 AM
>=20
> On Wed, Apr 28, 2021 at 06:58:19AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, April 28, 2021 1:12 AM
> > >
> > [...]
> > > > As Alex says, if this line fails because of the group restrictions,
> > > > that's not great because it's not very obvious what's gone wrong.
> > >
> > > Okay, that is fair, but let's solve that problem directly. For
> > > instance netlink has been going in the direction of adding a "extack"
> > > from the kernel which is a descriptive error string. If the failing
> > > ioctl returned the string:
> > >
> > >   "cannot join this device to the IOASID because device XXX in the
> > >    same group #10 is in use"
> > >
> > > Would you agree it is now obvious what has gone wrong? In fact would
> > > you agree this is a lot better user experience than what applications
> > > do today even though they have the group FD?
> > >
> >
> > Currently all the discussions are around implicit vs. explicit uAPI sem=
antics
> > on the group restriction. However if we look beyond group the implicit
> > semantics might be inevitable when dealing with incompatible iommu
> > domains. An existing example of iommu incompatibility is IOMMU_
> > CACHE.
>=20
> I still think we need to get rid of these incompatibilities
> somehow. Having multiple HW incompatible IOASID in the same platform
> is just bad all around.
>=20
> When modeling in userspace IOMMU_CACHE sounds like it is a property of
> each individual IOASID, not an attribute that requires a new domain.

sure. the iommu domain is an kernel-internal concept. The userspace=20
should focus everything on IOASID.

>=20
> People that want to create cache bypass IOASID's should just ask for
> that that directly.
>=20

Yes, in earlier discussion we agreed on a scheme that ioasid module
will return an error to userspace indicating incompatibility detected
when binding a device to ioasid then the userspace should create=20
a new IOASID for this device. This has to be done 'explicitly'.=20

When I used it as the example for 'implicit semantics" is that the kernel=20
won't create another group-like object to contain devices with compatible=20
attributes and 'explicitly' manage it in uAPI like group_fd. If we anyway
rely on the userspace to have more intelligence on those hardware
restrictions, it's little sense to only explicitly handle group_fd in uAPI.

Thanks
Kevin
