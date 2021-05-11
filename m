Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBD137B1BE
	for <lists+cgroups@lfdr.de>; Wed, 12 May 2021 00:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEKWww (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 May 2021 18:52:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:20660 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKWwv (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 11 May 2021 18:52:51 -0400
IronPort-SDR: shkgEBmcpBAYJxH7GGADMObhAoMS0DsVZ7sIJ5++TiSjFYKlx4+a95HtoODYk+BNXSVfjQOIm5
 gK3cYFECoUZA==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="187005739"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="187005739"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 15:51:43 -0700
IronPort-SDR: SDD4ISjeves7zSjxsrF0JZ8jUYNrToNiNPHk4dKMXE8BBwJvVIiC8wZdHI654BPPh2b2y14NY4
 D93T/u/2fGVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="436880471"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 11 May 2021 15:51:43 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 11 May 2021 15:51:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 11 May 2021 15:51:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 11 May 2021 15:51:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=el5UIpNAfL49Y16ATKu09OB9haOKlNiGrv2YeOFSYwmayv9/m9g9fRhwH6HfPbnyCkgSpwGU79UccsBMfX4YPMQuDLcvyOi5ukPNcwG1jSD8IesEMN/bJT+Sg0enP2iLGRdWWw+l9cq5xH3ZDhHAtsh9WS6am5MMtLMc8MKZ5s9i3qhgLgDC1+3LTU3XMDF7cCS8cKGH9iU8RxEugzK2WGAD0M3fR3k+yDt8rHrC5quZiyNj4PfLKVDoA+oJ9XWgQ4iKpLMmOIdrN2RtEZIjCArUeu6Gjvj8LLr4PtspAIoXebbyCVDx1MIrZT2fQqlm0iMpttu7uWDsuUTuA4byHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbHlBRAFJGFTLevQUSTmwuM5z1WZgVO7H6SFZJRM+n8=;
 b=MbUu+eymcmGxc+rONPzoDCpsC/c+UGFBIAkZy7dfuvFIUmO47qWdzQQhINjEtWOp0XQ+jD95m8TcmnXYMYNFBRteMJfTCtnhzm7lSZ/lmk8dM4fp6Wvis8q5b45WjqUyvDPBxWxzIgaoVypMHLEC6pXkyS4znqn/W43UZ9jHRl9puf9tYx9+qRPFVkI7hAswjaXQMNPY+2b/rteKEJOfSECgdXaTwcaIZbbR1lFNvPyYNSOEnvzxhcpxUYI75yQDr9LKPmBPumjxARmFxTMkW4Xv4EBBmfi9LchPMoR9zD2zd5TqI/08ORPA8ii58Tn53lP8CcDYJJ145ab1PxudxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbHlBRAFJGFTLevQUSTmwuM5z1WZgVO7H6SFZJRM+n8=;
 b=Dm+tg0f6Vk7daHFG2I04Ibzq5BE+8E2MnGKsD9ItpIiWnbYaDc3+fFHOs+7m2qY5YQj8IeRqRy84Kal4uSne+OyuSrb3sQMJ4r9sFnEFOEJiU7lxKs4mQFIxfxUOGGcoIhplF/PvastYVWn0izuUpRHx/UmF+yfAVkl/rccNvxQ=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB5155.namprd11.prod.outlook.com (2603:10b6:303:95::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 11 May
 2021 22:51:40 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 22:51:40 +0000
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
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAACiXgIAAVBgAgAAaMwCAAAESAIAABy2AgAAgOYCAFdCAgIAAppUAgADsNgCAACqygIAHsmaAgAAzsYCAAAjdgIAAD/yAgAAcQgCAADqggIAAk6nQgABIUACAASsnkIAAYWwAgALs9qCAAdeZgIACip7wgAo7TwCAACbZAIAARiUAgAARxQCAAS/XgIAACnOAgAAiwQCAAL24AIAAVNoAgABEgACAAo33AIADeaeAgAESCjCAAKImAIAAgzaA
Date:   Tue, 11 May 2021 22:51:40 +0000
Message-ID: <MWHPR11MB188601321993CA43E3058C4D8C539@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210504231530.GE1370958@nvidia.com>
 <20210505102259.044cafdf@jacob-builder> <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder> <YJOZhPGheTSlHtQc@myrica>
 <20210506122730.GQ1370958@nvidia.com> <20210506163240.GA9058@otc-nc-03>
 <MWHPR11MB188698FBEE62AF1313E0F7AC8C569@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210510123729.GA1002214@nvidia.com>
 <MWHPR11MB1886E22D03B14EE0D5725CE08C539@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210511143840.GL1002214@nvidia.com>
In-Reply-To: <20210511143840.GL1002214@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [101.80.65.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddc84db9-4f98-49a4-c9b9-08d914cf5773
x-ms-traffictypediagnostic: CO1PR11MB5155:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB515568BB8B2171D17FADDACE8C539@CO1PR11MB5155.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qEDExeK5uYJa9sYDGgkHakV2v9MnnnAkTZ2fxX4JvLJjBDroCIASrBB3ICWWX3bj4Wx4XBhCOMf3TqJWzz3TJCshkxv3vofAavRyVP5bPypHk+3FTW/2hrCAp0wnjiMqwLC16TEiyGzTy4RsKQh4vj01DXEZyf6iO7dhxIDLhKVwmCU9I2IkVsSJ2/rYcFxqyA0Exf1AftBUwqnXKuSwYpJJ62FAxZpENz5aB7/FX6anL1x+yoQ0rl5MIByAuq3UL6EXYZ/O+yewQz+3Bt/r/LIY0o/8HxtAlFV5FCkbO71iOBcKUoCS/ocU5sVWCJ/y2lQ14uaYeTp3wEFDQz0IXz6X0wb1gT2zACjjwEGwRq1xGzbJy2tyMH250H4auDaRtitMRSYiB4DUgt3e5cdZcTp+llJ55ScopuEktrap3ng7WGu6ELZCG7LGcLYkg+j45Iw9s0mRG2tn1Z5Vg+8dHCRw3HS3GBefRNpJhdp7J7dd8bl2yQZizzZBzTE7lkTiTiSQcixqcEuwBQp8JhlCris93xjDzTB4DiZ47fWqOKI1Ln/Bej21Bkz/Dfo4XGNud4pxcgoeYd2Z/8St7Rl89ce/C8LOHQVRGvPuRB5334E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(39860400002)(346002)(366004)(55016002)(66476007)(66556008)(4326008)(64756008)(66446008)(8676002)(66946007)(86362001)(26005)(52536014)(54906003)(316002)(9686003)(478600001)(5660300002)(33656002)(2906002)(6916009)(71200400001)(76116006)(186003)(83380400001)(8936002)(7696005)(7416002)(6506007)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1vD/hwYyWdbA3wwFaA7YUbQdurARWytbw6cOVoirnLXkZWqylWxBJLEWnp+d?=
 =?us-ascii?Q?Bwydo1qPAHtzOWWhkmBvEnLFUmy4pstHdYXpowS0ykWjuTpxmGFs+KeYzcui?=
 =?us-ascii?Q?V85JCbYv2DmUOsC9/WPnxHNaJ0Rz4w/XF+X1TYipb1ukHQoX3IlbR+U8Vfap?=
 =?us-ascii?Q?kXkTP8Y23p+IeHSWVKtEAtW7vvOL8CVlZSRBgWty7/6AMxCYZ4MPLO/SzLop?=
 =?us-ascii?Q?4gIzibKa0xo6JyBZohDqp4IVi6QUrLhi9OP/aP5yxlO6NVsJdxRUEiHkM22P?=
 =?us-ascii?Q?aSdmI7dotIzMFAZufb4RciYI3p5OjDu8HSgWCSYY0GjPnLNENIH8ftB1KO9N?=
 =?us-ascii?Q?C3WHTr6Kp971izDvk+fEWTZ3/XT/rjrL0FH1x+yFQJGq9UvAzoMb62ixlxlG?=
 =?us-ascii?Q?s9uq3OHj0srE8QmBJOLQk87XG6/zQv5ujBaVOJgCyVwQCt9kt9lepC6wWV3r?=
 =?us-ascii?Q?ybDiXFdXcK5k9lMhVT3XtcUB0dKF8lgspZ2mXu0cGh6iz+4jSxzqvNXI6+Zi?=
 =?us-ascii?Q?YKAteG6WxrpnRvRDwt5W24lRJsyP9gAMucwKZC6Lxy1IDCW4Ljbdig2fe9v3?=
 =?us-ascii?Q?aQHEZw6uFdyKfTZ/AlSkGaIaFiQ/kTTj6K4SZADnoMk1ZzI+uQW5pvG28XNP?=
 =?us-ascii?Q?bSMRviVDr0F67fCBsb6V/R0NfD6VmZIZ1kwqu75/jmGeUKyW7RadmFEJa54/?=
 =?us-ascii?Q?JvVmtCDYMb5schtE8qyH1rvE1CkjtMugx0lTWLgkHbkkacjlxjUrYehuMhYZ?=
 =?us-ascii?Q?QmpGeVTnUFa5P+yn/csY8fYhUeHDsxZr6lRfCVIeqSj0zuRjmJiOokGsE+iu?=
 =?us-ascii?Q?hOb958YGvfgAKZmugXH03FKutgsc0vUYxMd3cY9FkNIXJIESO2LCtm4e4Dwi?=
 =?us-ascii?Q?2LFvvwwsmckNzCS67v1AhGdWcVwvyYLkmHHViSyvkoxW7wOj5n0C83togT9t?=
 =?us-ascii?Q?IY/htduqiZSuEko/yE5g9oxwFQCSEf3er28l4DGOd6CpW5mbu08Bpl5/zYH8?=
 =?us-ascii?Q?Y8Oc5c+Azmvqttf+rORk0JKswWaih0BtTEYhAi/V459KeWBtvuJNeyS9LiUA?=
 =?us-ascii?Q?lGbu8VS/8Cc6n+nfXPekYkPlBOPKpiGk7Kv0OGdwM7k6hcB4yJbkPLg9W19g?=
 =?us-ascii?Q?WY2zWU1LlGtiEHnGCQG+CSMkL3V+h5MAMUFGpQMibJe14t9nb7k6WCaTdggg?=
 =?us-ascii?Q?9mIlRRlp2FyH51yAGqP5Rgs8wS7zwY+6QqytyF60iFiCsMGmTH2ps4BfJlCG?=
 =?us-ascii?Q?frfbVzWHcvYeqjGHObtf6NPV5yIJSmiAshCVOAF1zE7Y0XDnO9LXZXqWv1v/?=
 =?us-ascii?Q?jPM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc84db9-4f98-49a4-c9b9-08d914cf5773
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 22:51:40.5848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ctpZ6AmOaG/IRK3pdz1PEct3SvuzZpnHwtGx7ACmN4zO6EfB90Ol8DJQeX6mKBKR89DWLZMXO8WjK31g+rrv1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5155
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, May 11, 2021 10:39 PM
>=20
> On Tue, May 11, 2021 at 09:10:03AM +0000, Tian, Kevin wrote:
>=20
> > 3) SRIOV, ENQCMD (Intel):
> > 	- "PASID global" with host-allocated PASIDs;
> > 	- PASID table managed by host (in HPA space);
> > 	- all RIDs bound to this ioasid_fd use the global pool;
> > 	- however, exposing global PASID into guest breaks migration;
> > 	- hybrid scheme: split local PASID range and global PASID range;
> > 	- force guest to use only local PASID range (through vIOMMU);
> > 	- for ENQCMD, configure CPU to translate local->global;
> > 	- for non-ENQCMD, setup both local/global pasid entries;
> > 	- uAPI for range split and CPU pasid mapping:
> >
> >     // set to "PASID global"
> >     ioctl(ioasid_fd, IOASID_SET_HWID_MODE, IOASID_HWID_GLOBAL);
> >
> >     // split local/global range, applying to all RIDs in this fd
> >     // Example: local [0, 1024), global [1024, max)
> >     // local PASID range is managed by guest and migrated as VM state
> >     // global PASIDs are re-allocated and mapped to local PASIDs post
> migration
> >     ioctl(ioasid_fd, IOASID_HWID_SET_GLOBAL_MIN, 1024);
>=20
> I'm still not sold that ranges are the best idea here, it just adds
> more state that has to match during migration. Keeping the
> global/local split per RID seems much cleaner to me

With ENQCMD the PASID is kept in CPU MSR, making it a process
context within the guest. When a guest process is bound to two
devices, the same local PASID must be usable on both devices.
Having per RID split cannot guarantee it.

>=20
> This is also why I don't really like having the global/local be global
> to the ioasid either. It would be better to specify global/local as
> part of each VFIO_ATTACH_IOASID so each device is moved to the correct
> allocator.

this was my original thought. But for above reason this has to be
a global enforcement in this ioasid fd.

>=20
> > When considering SIOV/mdev there is no change to above uAPI sequence.
> > It's n/a for 1) as SIOV requires PASID table in HPA space, nor does it
> > cause any change to 3) regarding to the split range scheme. The only
> >  conceptual change is in 2), where although it's still "PASID per RID" =
the
> > PASIDs must be managed by host because the parent driver also allocates
> > PASIDs from per-RID space to mark mdev (RID+PASID). But this difference
> > doesn't change the uAPI flow - just treat user-provisioned PASID as 'vi=
rtual'
> > and then allocate a 'real' PASID at IOASID_SET_HWID. Later always use t=
he
> > real one when programming PASID entry (IOASID_BIND_PGTABLE) or
> device
> > PASID register (converted in the mediation path).
>=20
> It does need some user visible difference because SIOV/mdev is not
> migratable. Only the kernel can select a PASID, userspace (and hence
> the guest) shouldn't have the option to force a specific PASID as the
> PASID space is shared across the entire RID to all VMs using the mdev.

not migratable only when you choose exposing host-allocated PASID
into guest. However in the entire this proposal we actually virtualize
PASIDs, letting the guest manage its own PASID space in all scenarios
(being SR-IOV or SIOV) though the size of PASID space might be different.=20
The PASID chosen by guest may be used as the hw PASID when the=20
PASID space is delegated to guest (e.g. SR-IOV in scenario 1), or is=20
mapped to a different PASID allocated by guest (e.g. in this mdev=20
case or ENQCMD in scenario-3). From uAPI p.o.v the userspace just=20
needs to attach its own pasid to ioasid while the kernel will decide=20
the real hwid underlyingly (being same or different one). Migration=20
only needs cover guest-allocated PASIDs, with all host-side PASIDs=20
are hidden from userspace and reconstructed in the new machine=20
post migration (following common virtualization practice).

The only exception where we return host-allocated PASID to userspace
in scenario-3 is because Qemu needs such information to update CPU
PASID translation table through KVM. Earlier you suggested that this
must be explicitly done through userspace instead of implicit notification
between ioasid and kvm in kernel.

>=20
> I don't see any alternative to telling every part if the PASID is
> going to be used by ENQCMD or not, too many important decisions rest
> on this detail.
>=20
> Jason

Thanks
Kevin
