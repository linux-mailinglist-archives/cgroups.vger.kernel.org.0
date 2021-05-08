Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47484377067
	for <lists+cgroups@lfdr.de>; Sat,  8 May 2021 09:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhEHHcZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 8 May 2021 03:32:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:57221 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhEHHcZ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 8 May 2021 03:32:25 -0400
IronPort-SDR: MJLBBfu/9ksZEktuIMYaG263t9ogAsKWiFzyZ+bMPE3KXulfd6jjPWevabEDMyum2GiHNTCrQF
 pGDxjkoozwzA==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="196873288"
X-IronPort-AV: E=Sophos;i="5.82,283,1613462400"; 
   d="scan'208";a="196873288"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2021 00:31:24 -0700
IronPort-SDR: 6WSpicDIbf68Q3uRvvzNXixpWejQ9eQb6BWltDotQac7o3wY+DtZdqxKJGJewWWQpp5EmDge6C
 z48RiuM8GOQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,283,1613462400"; 
   d="scan'208";a="391350200"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 08 May 2021 00:31:22 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 8 May 2021 00:31:21 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 8 May 2021 00:31:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Sat, 8 May 2021 00:31:21 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Sat, 8 May 2021 00:31:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aj+Ki+VOmJ9HuT2go6KPvxL4LR7JkAGsfsU+98ki4UgfdQ6wuU/geOj8p9867/WYPN3z8mOnTjn/ReeWS7Y/htRri4P47sEIz/+YcbztcVEZNyPMZefH0i9WEbqmqVUqUdhR4/kAmefaiRrt6n9/d148ZZ2RXiRaK7joTxxlbKfxh9qUZjwQmKOaUXBkf5ilDc9rXBkFY7CmbPqF9mwWN95F7V+iATyQu/W2o2oLvzBoewHaVO8qLdor9/7YtvzB+le9zdH+F6tzz48s2HKJUoTNThcpWY46IA3JbNe172Kl3zI3vKK7+nJdKhT++75R5oeH/8ly/5mRZaHCAsZdxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftc+eb/EoO9EFb6GQNuUVZYAdBI/Nu/+QxkOv588uhM=;
 b=oFvMOQhcHQiBAcrBStevzhZN6fmAQkwMTg0ad1hD0q5KKqkSU1hwVJgV6QJkML+T/vpi537d+d4ntGEBEJnt/DAVLU4K6AHffOjAxHFIl8W15+4jhxT3dVwtMAg0OXCKQArgI3WZOkF0zwkWdUMWEGyk97XsEFfI+HgIyuGHR0oTYpZvVsMpFtTfPaqaDwK+EJFAgoegJia9b7gzXpU/D+1g8Cau0xALdfqGJpd4wddphJtZ98aeFnKSVzXEQM8KV/b4nmGuvIeHOx6q8ZqdpQF30KHjPdr5W352JULw48n/jMW2MkqOidXr1F8h9tbxmQGNWYJj/uxXIiGBVWijaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftc+eb/EoO9EFb6GQNuUVZYAdBI/Nu/+QxkOv588uhM=;
 b=PlwpRFtAmyxTur7RKanrUNMNllsDB7BBi3u01Jc3XXFUvRATkPBVcRFbLi44rfLN1K8T2uUUSDpbLoEn86FIs39feydr99s+cz14hJLsSLkwz0YlnBUIxlev7dXk0BqpAV+BqZymkeygebRc/Z4gK84FElSRPWp9Q/hPIxBuWFQ=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MW3PR11MB4633.namprd11.prod.outlook.com (2603:10b6:303:5b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Sat, 8 May
 2021 07:31:19 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4108.030; Sat, 8 May 2021
 07:31:19 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
        "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
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
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAACiXgIAAVBgAgAAaMwCAAAESAIAABy2AgAAgOYCAFdCAgIAAppUAgADsNgCAACqygIAHsmaAgAAzsYCAAAjdgIAAD/yAgAAcQgCAADqggIAAk6nQgABIUACAASsnkIAAYWwAgALs9qCAAdeZgIACip7wgADDb4CADZr84IAAq3oAgADfcZA=
Date:   Sat, 8 May 2021 07:31:18 +0000
Message-ID: <MWHPR11MB18862452FD4172DCA70C89B88C569@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210421162307.GM1370958@nvidia.com>
        <20210421105451.56d3670a@redhat.com>    <20210421175203.GN1370958@nvidia.com>
        <20210421133312.15307c44@redhat.com>    <20210421230301.GP1370958@nvidia.com>
        <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210422121020.GT1370958@nvidia.com>
        <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210423114944.GF1370958@nvidia.com>
        <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210426123817.GQ1370958@nvidia.com>
        <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210428090625.5a05dae8@redhat.com>
        <MWHPR11MB1886E0A7897758AA7BE509058C579@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210507110614.7b8e6998@redhat.com>
In-Reply-To: <20210507110614.7b8e6998@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c2935db-5606-4ee3-7b48-08d911f345aa
x-ms-traffictypediagnostic: MW3PR11MB4633:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4633279A950D4615F4C990D88C569@MW3PR11MB4633.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L7/SaiU8Mly8ZZ6ca+G4G0OUQ2f0dnF9dpiUm9Qibz0AgKYnRYI4w+fSDcQJrOlWs3bAwoVM6fnqYdefNjHAlhQczaPcSwaJitGwk5JZCtTpqTDBfl1nsaffOaiOigYncPmEzVTc7AETJMEivE903VMn9fEpnVqezbem7LHwdHDTbeC/KQi4vVSPrAxJu1i42sXY8Hc5gRytvx1odMgX4n5Cxz/81EN1796rPCYiGRqHVxiPpHWajY5T29ImcdK8Nyohmn7ln2g/wIbX9IwgIa7UN/xUpk0fe2sLCyAWfBjXT62XFxsc23t8OjurXQ87OuKKvS6ztEOwYrxZojYScaFmjKYHFnwIGcqpDilZzp5uMu2WbnMkXTzeDNiqSWYz7AEYseind0dtSIuwDlBsqWIv50yh/VlyfR2c6PyKIJqomReOuJIwpPJj3swBxz0i+9RlWnZ/RUEFzDGJv/5+PllDTVboCEWFv4Rj4VSqNizJcs8AbJYXdtdHjB8hOsZhLTOmTkdo0zYc9kdFQofZbQp0W00CZSFs1I+b/ZjbPBjCpRQal6F4IjeWbqPogoIxIfub+bgynxZ00T1F2Bltefbiu5+rHd0QLv9mi6Pg76E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39850400004)(376002)(366004)(346002)(8676002)(316002)(26005)(71200400001)(33656002)(8936002)(76116006)(186003)(54906003)(86362001)(83380400001)(7696005)(5660300002)(6916009)(38100700002)(4326008)(122000001)(66476007)(66946007)(66556008)(66446008)(64756008)(6506007)(52536014)(55016002)(7416002)(2906002)(9686003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+HPrM+mD72dardnYA7YdU6MCWxFq93lHilDcwTVaLZw0BCZGqs0HmbuZ2pk+?=
 =?us-ascii?Q?rH1WltA2YRUzKZUROnN+i0R0lmdgQMeYTr2m2LIkTlXakkxU4+PtffixgImG?=
 =?us-ascii?Q?Ow+d0IpWWy0KzYJWFk31+4UgMm2Ma6cqhftuhWByiLR62ZqxiX233xE3Hplb?=
 =?us-ascii?Q?jbG25iXoexc52AQhSK9SXRRp1Nx0p8BzwJOIsr3euu1+5Ltv6rVDBO3Ve8ZI?=
 =?us-ascii?Q?si0VH1YpyEgCK/GHu6o11nbYG2RewTglPjfEVt6rSoUStR8QLrke8aRvJvlS?=
 =?us-ascii?Q?zl4UbZ0veJCDKTMlaxaKVdbXDb5H4UZiNFfa+vmaRsxuWLEsrgrhKe9BNj+L?=
 =?us-ascii?Q?0+7R+3zpYMBW5CO9G1YIEORYjBDea80t+QgQCd6sc5WiPqTE00jftYAMiYSS?=
 =?us-ascii?Q?yAsqif+oJzzJ1YTiX88DflhV5uETQzwzAo/yHQm1/xDS7y8rTKL9LaX5BTb6?=
 =?us-ascii?Q?ya6k/HFWuhtdw6AjOSF9Bz0Mj3ueuI90m7UHuawDfNNgTxZmSuDUpuUnOrn9?=
 =?us-ascii?Q?51WS9/0GpuhSZCq1JrcU/Mn8kYafwS7r4DT4V2/Dn+CyZDA7U4m9d/7C8BUO?=
 =?us-ascii?Q?xinDm9KHM3GGRfNrSU3Heqln2tXMiZtfVZefJGh2+jsXgfodliFR5cXDId9b?=
 =?us-ascii?Q?P2sws1CEJ+cMJpcLfvhP/W1hnVAthLGwfUm1v0+e0ttTNSEtk9IVLioz7xK7?=
 =?us-ascii?Q?YkaUepsPNW9q9APh+0tYrVY6DqYNdiihXadBEcXaI5cK3r9S45CobzGlKV4S?=
 =?us-ascii?Q?r256wjJZ9D5Vmgr/2Wt4wQdaiWZfjyvzlWUr7RsvW8SUl7Y4CzKiPkM7G6Kq?=
 =?us-ascii?Q?qyj3bpPzwJADHZimAXkQiNtiAYnra2Et1QH+Qu/mfNUO5qLBsFQetLR4g+x0?=
 =?us-ascii?Q?uADOBIsn0pnoDAeIL5TDgoGnN3PeKPiDoNxz3pPOADpekLYkn+ACx0m94MkI?=
 =?us-ascii?Q?BUbHSz5B08VMg3CmMcqbxHswILK9FX6bPkdSHs06dey+bwBVtzRY2y7ns/tV?=
 =?us-ascii?Q?5fkx2tk01SFRt8dMnRQW6A2bOHtvHsV5n/u5t9tfhU09xW2JaSSp9KvdiDxr?=
 =?us-ascii?Q?vjJCcRnSsIot6Ctr8kVquEw5LQ/2HSyTZA+qpsDiXW8h/x6WIHzRHGMmAu+R?=
 =?us-ascii?Q?dkR7X28oJD/gIDb761XjCi18TwQbHUwaW0uk2yTp2Je2WzH7DT+mQwu3Gjma?=
 =?us-ascii?Q?NXePY4A/vKLiq1jMjo6JiBsFHW3ToGEnQmxrL/XHxo0CeK/QQAgYPU94YkuG?=
 =?us-ascii?Q?06fpDgwvhxNcG+JZMSl97VQc72vHVuS4/OtYYBwPjIx+fYQptUUOejiuA6Jr?=
 =?us-ascii?Q?I8FLFfDdqg9Pw41Vc/3mXLTw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2935db-5606-4ee3-7b48-08d911f345aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2021 07:31:18.9783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sP2aqHWvOpcDUbevza2tX41F8oysXfT0L+4kyXr6UUvGnVnDW48T4mIciOX+N+Wsj6bjfY7vjL8UlDK3mPpPQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4633
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Saturday, May 8, 2021 1:06 AM
>=20
> > > Those are the main ones I can think of.  It is nice to have a simple
> > > map/unmap interface, I'd hope that a new /dev/ioasid interface wouldn=
't
> > > raise the barrier to entry too high, but the user needs to have the
> > > ability to have more control of their mappings and locked page
> > > accounting should probably be offloaded somewhere.  Thanks,
> > >
> >
> > Based on your feedbacks I feel it's probably reasonable to start with
> > a type1v2 semantics for the new interface. Locked accounting could
> > also start with the same VFIO restriction and then improve it
> > incrementally, if a cleaner way is intrusive (if not affecting uAPI).
> > But I didn't get the suggestion on "more control of their mappings".
> > Can you elaborate?
>=20
> Things like I note above, userspace cannot currently specify mapping
> granularity nor has any visibility to the granularity they get from the
> IOMMU.  What actually happens in the IOMMU is pretty opaque to the user
> currently.  Thanks,
>=20

It's much clearer. Based on all the discussions so far I'm thinking about
a staging approach when building the new interface, basically following
the model that Jason pointed out - generic stuff first, then platform=20
specific extension:

Phase 1: /dev/ioasid with core ingredients and vfio type1v2 semantics
    - ioasid is the software handle representing an I/O page table
    - uAPI accepts a type1v2 map/unmap semantics per ioasid
    - helpers for VFIO/VDPA to bind ioasid_fd and attach ioasids
    - multiple ioasids are allowed without nesting (vIOMMU, or devices
w/ incompatible iommu attributes)
    - an ioasid disallows any operation before it's attached to a device
    - an ioasid inherits iommu attributes from the 1st device attached
to it
    - userspace is expected to manage hardware restrictions and the
kernel only returns error when restrictions are broken
        * map/unmap on an ioasid will fail before every device in a group=20
is attached to it
        * ioasid attach will fail if the new device has incompatibile iommu
attribute as that of this ioasid
    - thus no group semantics in uAPI
    - no change to vfio container/group/type1 logic, for running existing
vfio applications
        * imply some duplication between vfio type1 and ioasid for some tim=
e
    - new uAPI in vfio to allow explicit opening of a device and then bindi=
ng
it to the ioasid_fd
        * possibly require each device exposed in /dev/vfio/
    - support both pdev and mdev

Phase 2: ioasid nesting
    - Allow bind/unbind_pgtable semantics per ioasid
    - Allow ioasid nesting=20
        * HW ioasid nesting if supported by platform
        * otherwise fall back to SW ioasid nesting (in-kernel shadowing)
    - iotlb invalidation per ioasid
    - I/O page fault handling per ioasid
    - hw_id is not exposed in uAPI. Vendor IOMMU driver decides
when/how hw_id is allocated and programmed properly

Phase3: optimizations and vendor extensions (order undefined, up to
the specific feature owner):
    - (Intel) ENQCMD support with hw_id exposure in uAPI
    - (ARM/AMD) RID-based pasid table assignment
    - (PPC) window-based iova management
    - Optimizations:
        * replace vfio type1 with a shim driver to use ioasid backend
        * mapping granularity
        * HW dirty page tracking
        * ...

Does above sounds a sensible plan? If yes we'll start working on=20
phase1 then...

Thanks
Kevin
