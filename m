Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCDC356157
	for <lists+cgroups@lfdr.de>; Wed,  7 Apr 2021 04:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243543AbhDGCIq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Apr 2021 22:08:46 -0400
Received: from mga04.intel.com ([192.55.52.120]:5387 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241715AbhDGCIp (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 6 Apr 2021 22:08:45 -0400
IronPort-SDR: aoKVXqSc8+ereLAU5IZSxzfU941WOKsv4YNTeNBLXRxKKvb7crl8rAHQxH5SKbcqFklbdpREPo
 XmKi27YWrOiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="191035223"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="191035223"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 19:08:37 -0700
IronPort-SDR: NKWEOGoE6bt53nGN3hcdMkfpugMSd/0dtoJX3Te9yulBdL/yE9iydjpzPSghmwO/d3swSR4vQz
 dXtc4fy6mA7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="396471872"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 06 Apr 2021 19:08:36 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 19:08:36 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 19:08:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 6 Apr 2021 19:08:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 6 Apr 2021 19:08:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIutksaVoNhTlJBwtAvhsERMNqv1d3YRmcfYQmuF0bmNR0w8nMFNVBK+9MkylukW7aeEAH3UhK+Pz+SP89WsDAX5MncneGQn01DD2RrSdOIQ6Nf/iX0VxlwV79cr91G+VZitIm9AZWAuKup6ZanNYnUyW8UMbKClnfobmFZTv2VeZYyQ0ocgLbvhw+STTP2iLvJ60uanzxwDCfuzS6FICFeQ6kXy4W5hvmX3OeF1ZvwnTozQghvj0FwyNA1RWEZymgvzYiI5o6eBQ8NPJnoTUF3yDvm/0xjZNhNsJB3c2/qL+I5tzCPHN7L40x5BiYdaJHG0t8eq95uKs9SZjTj+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYNLOue8ViC5Xongpu43C4H6SAvo+nlYV6d8yzF/GyY=;
 b=fXy22f13xFxnq5Mo3SQk6L8XrEA4WW3LNoocPQ+YdjgTwH5imwQKqnOABQb0fPUz7EcjOMwHm00RJOZauQT7f7ShGCcOyjYMilcLFjNV/brtKZVnPl2Kv2EZ+lD+1dwmVVcyyWmDNRWqwy28NhOm+kuvZuAJx3dCcGqviEOwisRWdlQ4KaID6gjKSGEGyqd6u74tcykKpEGr9Z9canGM3WmSxO9SqRsbyN1ZmKK2dOlyVx/svrrJ+G+y7QtM6YGCoxchdpETfka/zbEoxHLvt1/Ec9j5Xv0Xfx7avJ4dud3mW/aUIeDZuQzFnKIOc1cwWgBhe4qVkTOjjfasnoX2XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYNLOue8ViC5Xongpu43C4H6SAvo+nlYV6d8yzF/GyY=;
 b=UU8K7aFA38h2bS8OD/sQL3cBrrqM5Bsx5DsGhhtSXjNcRl0nyzer056lA3Ee94ubyhtL9dUH9A7EnQhvBJmrJPf4qtasFjshECFVwptXIV3g/oCMcdLkQ/A4Ue8JtIlKMLqCMfaMHL187onSf4a3/YWO8Y8/hbip/n3tizy0dAw=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MW3PR11MB4521.namprd11.prod.outlook.com (2603:10b6:303:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 02:08:33 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4020.016; Wed, 7 Apr 2021
 02:08:33 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Li Zefan" <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "Wu, Hao" <hao.wu@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACABFtkwIAFviUAgAAWTgCAAMF9gIAA2thw
Date:   Wed, 7 Apr 2021 02:08:33 +0000
Message-ID: <MWHPR11MB1886CB8F558C6C17F921F77F8C759@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder> <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder> <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <MWHPR11MB1886CAD48AFC156BFC7C1D398C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405234230.GF7405@nvidia.com>
 <MWHPR11MB1886CF7C11ECE0396A0215078C769@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210406123451.GN7405@nvidia.com>
In-Reply-To: <20210406123451.GN7405@nvidia.com>
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
x-ms-office365-filtering-correlation-id: 90b94278-60e2-40dc-e573-08d8f96a0bdd
x-ms-traffictypediagnostic: MW3PR11MB4521:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4521482C53A7AE12C66A5CAD8C759@MW3PR11MB4521.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tf3kb/7bMGna9Wkrpvo9S3eBKmq7iB48amT52KBegeNBj+rj+dlLslFb8k8iM57Zx0bd50Q7XLgTvtBtHjuFJwc3fmLl4IcDVJPCKOZWxX1Jw21oW18o1byWN954MxOmcVIH2I/vh3COJO1gQAX0xkNCZ/UTovCY1Qol6ZzY3Gu3I0dlF2zAEiQHTYsihyJMATxWZh5aHjlFVaO1I2a/voFCG5LE69NffSOM6pHS1XPO/J4HvtAtac+JKEXefNz/xb50j5UvGMh/tvTZbKHXQPGeE+Hb6nik5yqF5sn3VEVqVu73hNmMrQjsTzdwlRrFPiQe+Lpt/7VnDYh1jUv28DxbzdujrlbEi3zS+DPpDFjD3rCyNB6VrJge7pE5of8lqgXgTj6TbiYqeSHbXSQL1x9CJr8CxCCxFn7jL4A2Os5y4ps11BTQTUagwK9b5Uy0hmyuec1XX2YfNzqr5gyaZgfCzFK2u8oWoBIfF9XGvdExL3zYhnuP426mx7fqWYy0gXSVd6GIswIa47iMzjNHl9Ue87zhc5LCUV6s2CF8wPzjedXAGHXz6DeTaQss4XA26PENMuH0nCq8tpn+SPrIYVCpiHw+xdyxGGk/5uh4OoBR5gx6iiwQoDAKoofBUQRVtlavSnt09Zlajkaipy87gcvZsiDMRCq2tTlA6MEbmL8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(346002)(376002)(39860400002)(186003)(8936002)(38100700001)(7416002)(2906002)(76116006)(478600001)(7696005)(316002)(54906003)(6506007)(33656002)(71200400001)(26005)(9686003)(66446008)(66556008)(6916009)(8676002)(64756008)(4326008)(66946007)(5660300002)(52536014)(86362001)(55016002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?F2eUXMK4C/IiG2EYCkwzgzs5LZhs5CKx3X6/qq/ft9aBQOiitZj2xphnJj4V?=
 =?us-ascii?Q?sv7I/iK0JLZ6aL5tNRIut6VCMiMz0IBq5dfzJwtzNY7Ggy4/jpSSBzrhwpbm?=
 =?us-ascii?Q?/YXYzlZC8e8toqck/vs9S3SiZOqgwu77qChZrGzCyhbAbLFqX8dbVQyeyFiy?=
 =?us-ascii?Q?zW91FrHN08zOR3TGuMz82pDI7SAJcw3JG8HFof9kVY7pD/0ZIly0yeeG+nsE?=
 =?us-ascii?Q?EzRt5O5fHh1y/TeL+cRIjyZ7Pj57gdDmblXCEO/HBTIMomZx1HbBtWmyPhAQ?=
 =?us-ascii?Q?xRAp5Cr7oclqRdNbmH47/Qbmd+3uOblZq3FmTv7SK19AsCImZSJi7MQwodMe?=
 =?us-ascii?Q?LHfHL8CxlPSd/3k5c0GUaxmEiwTYdk9zkUiTX02HG5i+h+iorkj1ktW5CEaj?=
 =?us-ascii?Q?trCrXBLn8welL/RTvzvWrqYVYrg2fsLgqqa2abnYga0EJ0Ioldwl6ZbhXTjb?=
 =?us-ascii?Q?45ynYf+IWiKCJCxjM6X++frKijIqVd14rjPAELFXqjfyv31WlyDW5KtTOvq8?=
 =?us-ascii?Q?ox1ugIdjXBjJIBf7IMcQMPql7EqNudbRwsuSN7FMXPSbPIcXa1ve7+iMuRv4?=
 =?us-ascii?Q?OUmcUrhxXz6FXClAI/2jLyQ64l7NM3kGbYlvBC8u86yZtLxmuIJ6qqGifM5H?=
 =?us-ascii?Q?KtTSfS9hlctwu2mUzMemX/a/lghVSLxj/sSfG8RgbhlApw5z1umZNvk4KiyN?=
 =?us-ascii?Q?O2fujdz1pZz17OQ8R5zbbZIladfukO8CNjrRBqNTiDdRz1FWwQiOWF3KY5Cd?=
 =?us-ascii?Q?Z0EXPQsgmo+qEvo3A0MYMeSnHREKG2oNk1KFeuVkWKCYN/KTvEihpFaaeuBg?=
 =?us-ascii?Q?SDOPSOGIEZF3bCywaxQ1cYaChkvNSja/o47YGY5TwFfEKLPzUVprrIAX2sId?=
 =?us-ascii?Q?DyhHw4h5N0kCGUWgt53fJzid5XS16rfdBEnYSoWA6khpTpelkm25xvBWH7Im?=
 =?us-ascii?Q?1r+bIiZc4nhVlB0I2eajc/NYKiq2kunvI7PjH0XU5kVnHi82uk/FfVh2vwvK?=
 =?us-ascii?Q?Fliy1mDej6b7gmB7vzsJykDpR17EkSxoU+6xoi3fp64Pm+21Q60L0n9rbArR?=
 =?us-ascii?Q?5BKh+QqrYG7Ab91jagky8DJuIi4MS+qDvaMh8k5mVchqtYDRqJxMUrTIG/0U?=
 =?us-ascii?Q?TssCyCO0wzbWp0B8/C5TVm4LGYRu6w2NPmF/uNt5SiXJuikU5Tc0uit996F8?=
 =?us-ascii?Q?IC1Qa9o/d0G/0zs5tGsrTRVWQAYVfi/e/f+2xWrUDCW1e89QX2iaZOaXATXP?=
 =?us-ascii?Q?aU/QMRflMNNUN0/adOl0mi5WMgwtC/6+YvYPcZkS4Er7oeWFHocg+BEGz+tC?=
 =?us-ascii?Q?OsD276wAUqvbtfxpSkieXZZm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b94278-60e2-40dc-e573-08d8f96a0bdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 02:08:33.2856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDc0RqNucGFtPygegVc20THvDj7H/lb/20D7uoDzJwOP7V4+hDip/wE2l+IrjF4sClu31H1SR1/428dJ98v/Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4521
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, April 6, 2021 8:35 PM
>=20
> On Tue, Apr 06, 2021 at 01:27:15AM +0000, Tian, Kevin wrote:
> >
> > and here is one example why using existing VFIO/VDPA interface makes
> > sense. say dev1 (w/ sva) and dev2 (w/o sva) are placed in a single VFIO
> > container.
>=20
> Forget about SVA, it is an irrelevant detail of how a PASID is
> configured.
>=20
> > The container is associated to an iommu domain which contains a
> > single 2nd-level page table, shared by both devices (when attached
> > to the domain).
>=20
> This level should be described by an ioasid.
>=20
> > The VFIO MAP operation is applied to the 2nd-level
> > page table thus naturally applied to both devices. Then userspace
> > could use /dev/ioasid to further allocate IOASIDs and bind multiple
> > 1st-level page tables for dev1, nested on the shared 2nd-level page
> > table.
>=20
> Because if you don't then we enter insane world where a PASID is being
> created under /dev/ioasid but its translation path flows through setup
> done by VFIO and the whole user API becomes an incomprehensible mess.
>=20
> How will you even associate the PASID with the other translation??

PASID is attached to a specific iommu domain (created by VFIO/VDPA), which
has GPA->HPA mappings already configured. If we view that mapping as an
attribute of the iommu domain, it's reasonable to have the userspace-bound
pgtable through /dev/ioasid to nest on it.


>=20
> The entire translation path for any ioasid or PASID should be defined
> only by /dev/ioasid. Everything else is a legacy API.
>=20
> > If following your suggestion then VFIO must deny VFIO MAP operations
> > on sva1 (assume userspace should not mix sva1 and sva2 in the same
> > container and instead use /dev/ioasid to map for sva1)?
>=20
> No, userspace creates an iosaid for the guest physical mapping and
> passes this ioasid to VFIO PCI which will assign it as the first layer
> mapping on the RID

Is it an dummy ioasid just for providing GPA mappings for nesting purpose
of other IOASIDs? Then we waste one per VM?

>=20
> When PASIDs are allocated the uAPI will be told to logically nested
> under the first ioasid. When VFIO authorizes a PASID for a RID it
> checks that all the HW rules are being followed.

As I explained above, why cannot we just use iommu domain to connect=20
the dots? Every passthrough framework needs to create an iommu domain
first. and It needs to support both devices w/ PASID and devices w/o PASID.
For devices w/o PASID it needs to invent its own MAP interface anyway.
Then why do we bother creating another MAP interface through /dev/ioasid
which not only duplicates but also creating transition burden between=20
two set of MAP interfaces when the guest turns on/off the pasid capability
on the device?

>=20
> If there are rules like groups of VFIO devices must always use the
> same IOASID then VFIO will check these too (and realistically qemu
> will have only one guest physical map ioasid anyhow)
>=20
> There is no real difference between setting up an IOMMU table for a
> (RID,PASID) tuple or just a RID. We can do it universally with
> one interface for all consumers.
>=20

'universally' upon from which angle you look at this problem. From IOASID
p.o.v possibly yes, but from device passthrough p.o.v. it's the opposite
since the passthrough framework needs to handle devices w/o PASID anyway
(or even for device w/ PASID it could send traffic w/o PASID) thus 'univers=
ally'
makes more sense if the passthrough framework can use one interface of its
own to manage GPA mappings for all consumers (apply to the case when a
PASID is allowed/authorized).

Thanks
Kevin
