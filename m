Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3355634DFE5
	for <lists+cgroups@lfdr.de>; Tue, 30 Mar 2021 06:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhC3EP3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Mar 2021 00:15:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:27125 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhC3EPN (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 30 Mar 2021 00:15:13 -0400
IronPort-SDR: +Al+CPYI61qnYt9gsvh92g6iLn+5V2H0TiHSkblvLs8MwLlNjM7OdQhTuPZwq/AabbZqWzXD7J
 VUSOaecrG+mg==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="179225926"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="179225926"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 21:15:12 -0700
IronPort-SDR: YB8KWETdmd27LPcW+p6JeUuauVgQvl/ijmPHs9UCojgoUFlK2kYIAMAcSB9bIOzFgCWgSmf+rt
 8NsxAdbB6jGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="376686631"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga003.jf.intel.com with ESMTP; 29 Mar 2021 21:15:12 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 29 Mar 2021 21:15:12 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 29 Mar 2021 21:15:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 29 Mar 2021 21:15:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 29 Mar 2021 21:15:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bE00WimATfgUx7QeKYpsE0LS089Iez/Un8Qz7gsA/kSZFxLmPNJ0JyClQSCn5aIT24A9qVDRK1/NJV4IuFfCsxc4tKW7/BZBxFrKmEDIClQ7fDnt+D12kNFj4IizLDJ4og6AH0bpvlAxSqd9/g16eASztGEbSdRNIEzvIBxsFJ7rrq5flspiGKWsxYUhm6uJyo4v0okRyFV/DYi+uxOFmR26CMDUrJLyhCN3JKj7WoBfy3es9roOf7HHZVR8IL3qmhVy5G/Hej4z6mcJg1//cWkxfHnzSN03j0Us/VAh7i6KFv8c/r0ezXFAUnAqpC/4Y5MNV2SjUT4DT3DhQQZ/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFA6xuSFwqCh2jRQ1W/fJGod0am5lOr7teRQc1bVMKg=;
 b=BTnB8WZlrUeZlYHRioT81/1Jrtm45l7/hiq49vQ60KyKjteimy1vRsLdMvNfY1ybhKq5RGtyeji4qxLaSdJV/n2bdJN19G/hQXEuaemopQ1JV7jskTCAu7YPfr7n+AWl7l3kyb37AvJU4keDxNpBz56U9HJH9n0EgcxywuU73bVXEd0P6D9RbOKucka1zLMEL+GYTg+Tg/c9kkcxvNZU68ovrqEi8bIPzSgDY5sofqnRdft33xPzfc2cdgSEFjSB26/ZqxIAxv3P6J8YIwvmdy92H8/XIP6Z6SUCidZi8MX79Sji3fjF3TBKmADFuHvBLEElCPs4Ellu3umC/ZJWFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFA6xuSFwqCh2jRQ1W/fJGod0am5lOr7teRQc1bVMKg=;
 b=zJ8sw1LZAj5V/LjX++XcuKOmM+chFy51IOvX5hPi1gyd/dtjwkdwGvcAESAz8zONnqRmn2sHqUv9WZYfrZZjND35Cz+6rzs5fHzV+ESIxO/MRFt5h1Cy0y7Ov7jUBr6AaTf6ZQ5aXTkuCoPdxsmcpnemC5NjkpE3ytPmp3qxV+E=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB5137.namprd11.prod.outlook.com (2603:10b6:303:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 04:14:58 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 04:14:58 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
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
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAoO8AgAAZ0eA=
Date:   Tue, 30 Mar 2021 04:14:58 +0000
Message-ID: <MWHPR11MB18867EC048E3E3FA37F9C38F8C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210318172234.3e8c34f7@jacob-builder> <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com> <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com> <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com> <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f56487f-bef3-456c-3a48-08d8f33261b0
x-ms-traffictypediagnostic: CO1PR11MB5137:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB51373F3DA62CDFC70B7916C88C7D9@CO1PR11MB5137.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0zNF+BuFBGb6pCHBRQcVUNMD1WXsyOu6NE6aF+t64kcUssdVl7mcrgyQMaaLW0MzQXfNhDJp11ma057Ca+5FF6pC1vZsDmswMSxlr8HRmMaK5IyunaKLGid6hZmNtVYHwEE0w0wxhK2VP6dDvhsPUz/Zh6Are/lSD4Gfn7wv7oS2kbaEDGYCzve41J1YSuD4ll6WVDHszyPTsbJS+xXYzZ1/Ikt5y3NZ9kaiq6NF56AJV6MpSfigZJpCWadrlawzbE5USwCt/58a/tNNRQIFbbJ4pkzl0iGsoU45mP+3m7RqgQY+W22pHiROinSyhDiQ2OLuO3JC0NQAEa5NK7JQiz37lX8tVrZlTPAGL764SULcmELcImXJuty1w9wvp/+JHaBBe684XMG1GnCMQLusz5lKvUVrHAEZAWcVqEp6C9uZ9PRc6Lnx3AyIQDWz8mVCaF1Vz31QNsXmK7mv8kqQuNa4gse5Nxe0/3dF6OR12RDM7GNIrVPUVSN5y4tXL0cs4fifEHA43E3mIRyNB+UkNLHGsXmIPdQJweZNR+9s5LoLFy3eXBl6wiEoDgVmmn7tljLD/rfuqjmMb9Q6vnZyLjrBME1NkN1MXX5nXwfrjIGBMHvJLm0/DCJkJ2/vqiX7V8hCJgPCBRFrh57t5Si5+XGiXXKX1F9YU3Xl7NmJAPU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(346002)(396003)(366004)(64756008)(8676002)(76116006)(66446008)(54906003)(8936002)(316002)(38100700001)(5660300002)(9686003)(83380400001)(66556008)(52536014)(26005)(7696005)(478600001)(86362001)(6506007)(55016002)(2906002)(7416002)(4326008)(186003)(71200400001)(33656002)(110136005)(66946007)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uPvQEsAmlS42d2kaghPpV+BOn3AYQa5lzTJ1HEzqBrwmwzV4WT+wO76FKacv?=
 =?us-ascii?Q?LrtGpZ1Y1eq5nYrZ84xEqxkuUO0/1nfjzzG/lJGS5SE5WoNrOdIobLDXu5mv?=
 =?us-ascii?Q?o6lZggm1Rx+J9FncVZKhYDsuFqGGAwLm1skDIYkLz6yCABDQUunuwEV5/5v8?=
 =?us-ascii?Q?2bf+04NQt3+aXtSbIAz/fTTIDsgikMwteUL9u2BnQXmD6kKwS88TLdABlGaC?=
 =?us-ascii?Q?6A9jDlUyG5MrhCmq2dZVGUN+ahTdf0pdbl0QmUUCo0DQdudhS5cDJr/uyXSp?=
 =?us-ascii?Q?fsBLlc7qzVgI4dxhNoVYI+s9c6osZewpZI6nu+2BxPWXfgITzO/cEMDz+YfI?=
 =?us-ascii?Q?gbvXwOPx1iBnaIjZNMQzEXqWb/lLKtynX1ud0enbEDeFXR2nH+Orjk+AODC0?=
 =?us-ascii?Q?tmgPFoFqUTzxD+jrO/sIKBTuiffrOTaKequnES6dyeQbIgpmQQ/N9GxXZPtZ?=
 =?us-ascii?Q?yhuidt3FCsjAkXybVkoGNfMgA/F8UIe7hzlIhL1alSnkLxncKZPtqQL5QF7M?=
 =?us-ascii?Q?TGd/JLLPKYEYC28arQi+QWauf1wvzJiiV8v0g5JV4ek5CjR5vsIUWAd7+c2k?=
 =?us-ascii?Q?PbdZTeBh4j/CgBxQHvI/IpKss9DzvlY0awih+xVI7ue0YPP91PrGsQpmFCYO?=
 =?us-ascii?Q?tBMPZKOYonzVaErsVSK1d49k29EhctqBlYLG8qQjRgLha5gOwF3fYoiMDjka?=
 =?us-ascii?Q?z+Rzbv3uns27S896MeiN9QBLPjGgusGvjGRvFOCywzJZpCcuS49YkXgq22vX?=
 =?us-ascii?Q?VkB78+o14gUkiAJ2XKYepUBJByzA/fmwB1GHO8wIpDxjMBUD3Xzjgh/I6v+r?=
 =?us-ascii?Q?BgB+ak38OAFg38KB2Pnzwh2GdmUKqV8LLOimmEPrMasJfImqiwl+W4RUBrlR?=
 =?us-ascii?Q?mSfXJiYqMRNO3b6bcmKyghG720/oFNya5tlC84ofhc0K41PVrV7lB7++KltJ?=
 =?us-ascii?Q?Rb/ePDb67N2opVv4dTKp9MVU+/rkAy5W6z+l6MdWVQEiEVAyM+2f8/xML5Aq?=
 =?us-ascii?Q?xC3Vc1LRz5dM6hc+4AiXobNZwhcmEYj3GTloDyR26kEFypo3R17MKFiBcWZv?=
 =?us-ascii?Q?C+PNLMNdY4jS46SYMEDWcpW8cR/Uzg5xbSbDELIFTCNO9/yZaOQtbdHLocVs?=
 =?us-ascii?Q?q0lNh+Ij4Saw4zrJtuK4rgrI6AmVpnHY8ZUEr6RowEd5Y8EGYdfGDuTGgePD?=
 =?us-ascii?Q?qplgnCHpxp9S3fLS6lkhRW+eVR3o4B4jJ7MpM4wDRZug8oWL1V72sMsriRYo?=
 =?us-ascii?Q?DTupkX8lWX+SErcjNqjlCM9pLzyL17amxeIUXz61MIl1GERfsBqwS4BgSzki?=
 =?us-ascii?Q?5q0Y7XR5xLmXEbcxRhbL58cP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f56487f-bef3-456c-3a48-08d8f33261b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 04:14:58.4599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oPZgcICfM0uf4z5RcEJOWiT3Zo96SCvzNhEsV/4t0wtGv1qX4tZeePoWm4/C1sp7SfSFbTG5D5oY34exhIoXlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5137
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Tian, Kevin
> Sent: Tuesday, March 30, 2021 10:24 AM
>=20
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, March 30, 2021 12:32 AM
> > > In terms of usage for guest SVA, an ioasid_set is mostly tied to a ho=
st mm,
> > > the use case is as the following:
> >
> > From that doc:
> >
> >   It is imperative to enforce
> >   VM-IOASID ownership such that a malicious guest cannot target DMA
> >   traffic outside its own IOASIDs, or free an active IOASID that belong=
s
> >   to another VM.
> >
> > Huh?
> >
> > Security in a PASID world comes from the IOMMU blocking access to the
> > PASID except from approved PCI-ID's. If a VF/PF is assigned to a guest
> > then that guest can cause the device to issue any PASID by having
> > complete control and the vIOMMU is supposed to tell the real IOMMU
> > what PASID's the device is alowed to access.
> >
> > If a device is sharing a single PCI function with different security
> > contexts (eg vfio mdev) then the device itself is responsible to
> > ensure that only the secure interface can program a PASID and a less
> > secure context can never self-enroll.
> >
> > Here the mdev driver would have to consule with the vIOMMU to ensure
> > the mdev device is allowed to access the PASID - is that what this
> > set stuff is about?
> >
> > If yes, it is backwards. The MDEV is the thing doing the security, the
> > MDEV should have the list of allowed PASID's and a single PASID
> > created under /dev/ioasid should be loaded into MDEV with some 'Ok you
> > can use PASID xyz from FD abc' command.
> >
>=20
> The 'set' is per-VM. Once the mdev is assigned to a VM, all valid PASID's
> in the set of that VM are considered legitimate on this mdev. The mdev
> driver will mediate guest operations which program PASID to the backend
> context and load the PASID only if it is within the 'set' (i.e. already
> allocated through /dev/ioasid). This prevents a malicious VM from attacki=
ng
> others. Though it's not mdev which directly maintaining the list of allow=
ed
> PASID's, the effect is the same in concept.
>=20

One correction. The mdev should still construct the list of allowed PASID's=
 as
you said (by listening to IOASID_BIND/UNBIND event), in addition to the ioa=
sid=20
set maintained per VM (updated when a PASID is allocated/freed). The per-VM
set is required for inter-VM isolation (verified when a pgtable is bound to=
 the=20
mdev/PASID), while the mdev's own list is necessary for intra-VM isolation =
when=20
multiple mdevs are assigned to the same VM (verified before loading a PASID=
=20
to the mdev). This series just handles the general part i.e. per-VM ioasid =
set and=20
leaves the mdev's own list to be managed by specific mdev driver which list=
ens
to various IOASID events).

Thanks
Kevin
