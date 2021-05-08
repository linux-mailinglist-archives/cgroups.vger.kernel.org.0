Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032AB377119
	for <lists+cgroups@lfdr.de>; Sat,  8 May 2021 11:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhEHJ6I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 8 May 2021 05:58:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:62490 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhEHJ6I (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 8 May 2021 05:58:08 -0400
IronPort-SDR: 5FW3KhVwWe7O4bl2KJSwLN3sYLtJm8EkxP2qlIEgybqipKQP2SMf2rO4QMKj/tjbvMEccHU6z7
 HflaSIMyfkUQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="196890136"
X-IronPort-AV: E=Sophos;i="5.82,283,1613462400"; 
   d="scan'208";a="196890136"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2021 02:57:06 -0700
IronPort-SDR: hSHgVmHM+W77+/hSei3yU3XKoknWXfmFT2m4UzCMkpWVWwPM2oVJzFujm9yEIwZXJEz1M8SQ8d
 Jo/IYguZ+Kew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,283,1613462400"; 
   d="scan'208";a="466463089"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 08 May 2021 02:57:06 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 8 May 2021 02:57:06 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 8 May 2021 02:57:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Sat, 8 May 2021 02:57:06 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Sat, 8 May 2021 02:57:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCdFPS8KBp6yFDzON0edcxr1Yh4o8vW1mFknZ1SUAWKIBMukB7nMZvDfg8TX0QSm9oYv+hWMgCXrNnTNcS/zN2liE8LUK7SBRve75XWFh9sJlh7kmRsVfEcwTtr39sjtrDvSeCPZtGgbtkhmh7T0ng6GOKW1KswAYt5tooKisfl9O22NcRVa6JAp7kE0IZIBw0UnqUiml6N3RmDxgYIu0yqUkgSKnEvWTrF6R+VYpAWPrYd0L0bfgwr8q3lDbsvsNMy5KZbztx/8S2hPNBf1pav5PCjK+MrE/QKGA+RyBUon0GLD00eKq3TklcV/IjSR/qMZGNnYYlU25mK+CJOFCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nxj1YXgPrxwGs+XWI8P0mgV1q4GSN84WI50RW4x0jIM=;
 b=JhJL5zPrpAsY/0X5jPZuUstxQWci5dbo96GwSXkzZTUonk+OE+c7IG251T5kyXTCVaEH0bU801dPPqOQ/riEPI5z9i7pX+Vgek7VOY2iZZz7zjFhs+BsTNoqadlvHfVTUZxgZ3dRsWVwF9q6PGwgoZMEj6+2RAm2TmUbBO10ZrXcGwkq3E9coJrv8ZK0we98g2eqPo7iIYyZ2cmugVcbY3nh30k7e3Yx6E4VAEUzoYY6Uy3g0WdPWNEHDwMBr98KPeR+hQl6nQ/plLQSFLJxKBn7nkkTOlxaWkj07BmN/EOkOwIEUfLkmSMZrcDDBbelmFLHFsU0/Dcfy3U1HlYggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nxj1YXgPrxwGs+XWI8P0mgV1q4GSN84WI50RW4x0jIM=;
 b=WGoIkIEeUBLIVmeXolDJ9qCzyCTWA7ji3OoRfW6kvkrT/kw5+jE8R6TcHkSPWbUXmJ6us48Odnuxglm6hIOlhECjGmQ8GDKKr0hvBs1p1qHhnHKMwPWBYzS2744F3MtynxrbD1MnpCtoCyyQsJram8qLaSH66al98xwMBGPvpWs=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MW3PR11MB4588.namprd11.prod.outlook.com (2603:10b6:303:54::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Sat, 8 May
 2021 09:57:00 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4108.030; Sat, 8 May 2021
 09:56:59 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Auger Eric <eric.auger@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAACiXgIAAVBgAgAAaMwCAAAESAIAABy2AgAAgOYCAFdCAgIAAppUAgADsNgCAACqygIAHsmaAgAAzsYCAAAjdgIAAD/yAgAAcQgCAADqggIAAk6nQgABIUACAASsnkIAAYWwAgALs9qCAAdeZgIACip7wgAo7TwCAACbZAIAARiUAgAARxQCAAS/XgIAACnOAgAAiwQCAAL24AIAAVNoAgABEgACAAo33AA==
Date:   Sat, 8 May 2021 09:56:59 +0000
Message-ID: <MWHPR11MB188698FBEE62AF1313E0F7AC8C569@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210504084148.4f61d0b5@jacob-builder> <20210504180050.GB1370958@nvidia.com>
 <20210504151154.02908c63@jacob-builder> <20210504231530.GE1370958@nvidia.com>
 <20210505102259.044cafdf@jacob-builder> <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder> <YJOZhPGheTSlHtQc@myrica>
 <20210506122730.GQ1370958@nvidia.com> <20210506163240.GA9058@otc-nc-03>
In-Reply-To: <20210506163240.GA9058@otc-nc-03>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1223d09-aa72-4f86-3bbf-08d912079f79
x-ms-traffictypediagnostic: MW3PR11MB4588:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB45887FAEDE44DD36455109078C569@MW3PR11MB4588.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jn/hpmf7Zu6+5iP/MDcqEm/E1aMhaaMMeMUjApPf9fMwQwjL2BZnhmsiZ9G64Nx2fPNqFdo7zCh6DMV6cllxG05NwxMef/njDJ/9c1E453gG7MmUMziS0ljksWN4En+TCP0OrwKRR4W3tnLHyZ9aBT8N5LdQ6bfQmuavdDaa68HFhRHSRZ8JbQ9RRYyf/8nL1JYf/Vpy5Ods8gDrQ7BD4D1asU/98Yi4bz14+2cYEJPfQ7tqF7VkT3nGMg1RugcoC9ZgCOp6mgaSFsv2SJm4gKQuFrbR3GUl+bq6WVL7dVaTDIq7owbaYH9tkYLA3X7HNItdsCTpeknikUfnDlDCttLLTqmvbILKy3B8A2TfYZWzE+cZI9j7z66R1JlZd0YmaB7XJfrybJ9KvAZ+qSckp3pgnlb4V6IApxcHt7KvIgoq878ZSdDLRoLUwwY3voPX/l4sgKZkCfGW0ddNEsyqJS80OufXsFPQ/UhcGCw4jwJyvROTpPWcjcbcDt12XkfLHIolJVnBRpSJ3aPDcVrtZvN8nuBG5ERchq73uNiiVrOQfH+cSb/OVU3hj7tkeGf7U7w91BDteBvxHXZs0wH6pJ+dmnY13G4GpvGIb29ehH0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39850400004)(396003)(376002)(346002)(366004)(122000001)(38100700002)(71200400001)(33656002)(55016002)(7696005)(2906002)(83380400001)(9686003)(110136005)(316002)(86362001)(8936002)(52536014)(76116006)(64756008)(66556008)(66476007)(66446008)(478600001)(54906003)(4326008)(66946007)(26005)(8676002)(186003)(7416002)(6506007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EDzuKcrEyD3mOYnbY86sG513CSn6xfNdt6N1S9/nKrJYeJI11aNXGViQLmvh?=
 =?us-ascii?Q?6cupP+TxVv/3cY/CPjHAjkH1R4VyM+mMNCqYTyenHifPtYuyUDfWKPa3Ni2p?=
 =?us-ascii?Q?fT6s+tdivZfoCIdO87HQebny0MsZVoKH+pwqNXB0kYFdKTP2TOE2Otxd5Poh?=
 =?us-ascii?Q?5nwl2G/PibDm01UgxN+sdJ38Utyhkb1IseIkGajfc94wfGJEx8k2o3+dBR0K?=
 =?us-ascii?Q?P4iuabs7cdZ+hQl0U8ntrmUojFCXllSJsWGE815khwivqSg3Or5LBPlOmeuL?=
 =?us-ascii?Q?HRAfHxRi4dQQ0/758hDkUzmyl3tbu/h3IC+QmvBgGpnod5KlEi3XJ/ZucIOL?=
 =?us-ascii?Q?vZaK68eKQgMDpKTYyFOctGjrBghYwIBzjzXWnmBomo9om7lF72X5qC5+Q3Qk?=
 =?us-ascii?Q?IRYZASMDovhG6osdHQ/9IZH53tWt4q2XjAeMGiwMdSrNkt4XUZy+jLzDWRXj?=
 =?us-ascii?Q?eWp9pvH258R7m6ct2mEYLwpPKf7Un9D7/En8KpKxB3MP8+DWlChxTIQPipV0?=
 =?us-ascii?Q?wFSQ6lg82pqVGnRh5KO4BfkfXSmXjHA61uIaMY2JxHjmzKhGL7Fp2Bh8onoR?=
 =?us-ascii?Q?04EkBhGawBjhtM+4ekoKldS1kqrDFzxyf8sJVLK0MkO01wxYxQK8/HKGGHFY?=
 =?us-ascii?Q?asTyeCe53VbhxyfmlvpN3IClOsoHbErSOtc7vJEOB3YuOByVZ1VSSy6uadv+?=
 =?us-ascii?Q?0ZT2roIQM9LHDNUDAuPk/IAsYFgWb1Aw3cx3wx0q5da4Mee1xYABW8UqsLcb?=
 =?us-ascii?Q?dx9DYgCsMo5yJTG6S95FXLBoGSZGSTip1+AbnpDyZMV7dBPFAoB1FoBdofLz?=
 =?us-ascii?Q?MkGqUGnRjsr0kO6OLnzn89q1SubdrS4ZQUu99v5AAokGu4dNdHfGEO3IXLWa?=
 =?us-ascii?Q?NSQu7kzyPr5k8VXWQ/ySdfcTtIujpkpDF2Z1WcvS1kOLdpnNALnNiD9hZiO4?=
 =?us-ascii?Q?+CwmiCoBuA2e4oFvxNcuJl8zYtomIYWDMl4HOmqW+xbOSZlicSl+qK25Jd+H?=
 =?us-ascii?Q?v1Z2FKt6mpItxHlFefRyBVg325oRPT7ZzhjUP6ve3vsoyBJuMMfAxPoZ6+2C?=
 =?us-ascii?Q?fIvYJnp+Ky2NOZDjlw2Q1OtZU8NqHIIfF4zgyexGYN1Kk2CejDo8N2EKMKMx?=
 =?us-ascii?Q?dN4IwP+ZF1cc+KhbwCBHzwNC6ZrOgbaNzHVDGLF22K3zpzJkGy5qX7UifDhN?=
 =?us-ascii?Q?l0HRE0oeysNfr4NyOrQ33VG5ETy2fH17Mow8JriHcGfYICteNq/8VuBsoJ8Z?=
 =?us-ascii?Q?oXYLtKMKdFczVMVTTFEQ+kwgnLYteYNr8zTzpRZxkbW52jEwpISmtPgN0qpf?=
 =?us-ascii?Q?wkc1G/Zb9XQYFQ0Cqn8nOLeB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1223d09-aa72-4f86-3bbf-08d912079f79
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2021 09:56:59.7050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QhnSCMXZLkffIePuaAmGx4A5mUPVU76Id+EJ8E4Z55dJ3YfroJhliF3rxq37NYscXVQ30l/HlDkcysE3lKhs7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4588
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Raj, Ashok <ashok.raj@intel.com>
> Sent: Friday, May 7, 2021 12:33 AM
>=20
> > Basically it means when the guest's top level IOASID is created for
> > nesting that IOASID claims all PASID's on the RID and excludes any
> > PASID IOASIDs from existing on the RID now or in future.
>=20
> The way to look at it this is as follows:
>=20
> For platforms that do not have a need to support shared work queue model
> support for ENQCMD or similar, PASID space is naturally per RID. There is=
 no
> complication with this. Every RID has the full range of PASID's and no ne=
ed
> for host to track which PASIDs are allocated now or in future in the gues=
t.
>=20
> For platforms that support ENQCMD, it is required to mandate PASIDs are
> global across the entire system. Maybe its better to call them gPASID for
> guest and hPASID for host. Short reason being gPASID->hPASID is a guest
> wide mapping for ENQCMD and not a per-RID based mapping. (We covered
> that
> in earlier responses)
>=20
> In our current implementation we actually don't separate this space, and
> gPASID =3D=3D hPASID. The iommu driver enforces that by using the custom
> allocator and the architected interface that allows all guest vIOMMU
> allocations to be proxied to host. Nothing but a glorified hypercall like
> interface. In fact some OS's do use hypercall to get a hPASID vs using
> the vCMD style interface.
>=20

After more thinking about the new interface, I feel gPASID=3D=3DhPASID=20
actually causes some confusion in uAPI design. In concept an ioasid
is not active until it's attached to a device, because it's just an ID
if w/o a device. So supposedly an ioasid should reject all user commands
before attach. However an guest likely asks for a new gPASID before
attaching it to devices and vIOMMU. if gPASID=3D=3DhPASID then Qemu=20
must request /dev/ioasid to allocate a hw_id for an ioasid which hasn't=20
been attached to any device, with the assumption on kernel knowledge=20
that this hw_id is from an global allocator w/o dependency on any=20
device. This doesn't sound a clean design, not to say it also conflicts=20
with live migration.

Want to hear your and Jason's opinion about an alternative option to=20
remove such restriction thus allowing gPASID!=3DhPASID.

gPASID!=3DhPASID has a problem when assigning a physical device which=20
supports both shared work queue (ENQCMD with PASID in MSR)=20
and dedicated work queue (PASID in device register) to a guest
process which is associated to a gPASID. Say the host kernel has setup
the hPASID entry with nested translation though /dev/ioasid. For=20
shared work queue the CPU is configured to translate gPASID in MSR=20
into **hPASID** before the payload goes out to the wire. However=20
for dedicated work queue the device MMIO register is directly mapped=20
to and programmed by the guest, thus containing a **gPASID** value
implying DMA requests through this interface will hit IOMMU faults
due to invalid gPASID entry. Having gPASID=3D=3DhPASID is a simple=20
workaround here. mdev doesn't have this problem because the
PASID register is in emulated control-path thus can be translated
to hPASID manually by mdev driver.

Along this story one possible option is having both gPASID and hPASID=20
entries pointing to the same paging structure, sort of making gPASID
an aliasing hw_id to hPASID. Then we also need to make sure gPASID
range not colliding with hPASID range for this RID. Something like
below:

In the beginning Qemu specifies a minimal ID (say 1024) that hPASIDs=20
must be allocated beyond (sort of delegating [0, 1023] of this RID to
userspace):
	ioctl(ioasid_fd, SET_IOASID_MIN_HWID, 1024);

The guest still uses vIOMMU interface or hypercall to allocate gPASIDs.
Upon such request, Qemu returns a gPASID from [0, 1023] to guest=20
and also allocates a new ioasid from /dev/ioasid. there is no hw_id=20
allocated at this step:
	ioasid =3D ioctl(ioasid_fd, ALLOC_IOASID);

hw_id (hPASID) is allocated when attaching ioasid to the said device:
	ioctl(device_fd, VFIO_ATTACH_IOASID, ioasid);

Then gPASID is provided as an aliasing hwid to this ioasid:
	ioctl(device_fd, VFIO_ALIASING_IOASID, ioasid, gPASID);

Starting from this point the kernel should make sure that any ioasid
operation should be applied to both gPASID and hPASID for this RID=20
(entry setup, tear down, etc.)  and both PASID entries point to the same
paging structures. When a page fault happens, the IOMMU driver=20
should also link a fault from either PASID back to the associated ioasid.=20

As explained earlier this aliasing requirement only applies to physical
devices on Intel platform. We may either have mdev ignore such=20
aliasing request, or have vfio device to report whether aliasing is allowed=
.

This is sort of a hybrid model. the gPASID range is reserved locally
in per-RID pasid space and delegated to userspace, while the hPASIDs=20
are still managed globally and not exposed to userspace.

Does it sound a cleaner approach (still w/ some complexity) compared
to the restrictions of having gPASID=3D=3DhPASID?

Thanks
Kevin
