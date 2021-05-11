Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749A237A30B
	for <lists+cgroups@lfdr.de>; Tue, 11 May 2021 11:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhEKJLO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 May 2021 05:11:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:16238 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230442AbhEKJLO (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 11 May 2021 05:11:14 -0400
IronPort-SDR: zfVpAgcpeJ4UXEJpZQjQce4iXM3HvyW7SdL3lJK0FKdDM/KUzCyMX8+tDamGALYz+WfXbPoaq4
 FXv60m4QHx9g==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="186837499"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="186837499"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 02:10:07 -0700
IronPort-SDR: S7hcPfWeHpeAkvDz8veKFTB55Rin6BWBgCIax7w8aN3qurKRZOsYgGFUFFkWKdJZKLmBqW31cc
 exk1Co8TnD3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="624624832"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga005.fm.intel.com with ESMTP; 11 May 2021 02:10:07 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 11 May 2021 02:10:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 11 May 2021 02:10:06 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 11 May 2021 02:10:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQgOr5FuD7x5DKsHQN6GAcLDy1hhevtcsEADwURfgIykFyGmr20iwF2xzkV3PZ8sj6zOxe4nt72AUZ4SQwE+EVjZKp7w/1A8c/FiyYFKbnCn4z74RryFXWcQkMrCaMloTYWs0dwmg5P7wJ2Btt+RcQ8UcV83I5/2+vCdY93o2/f0TQjb8kQoK6oDF4WiqW/hNJfpGQg7+aln0kSG4n6Eqwu7kcas3f0DVSPWRPtweOhOisYUYGjP9e36VwGDOqw8tlkWgmBOYD1anZTvuwJ3GsDIkIxOqG1PAt9v9LX8OEkBDEmhEXg28fYX5WZnuEoKZJ9JOk017Ovk8oQUv/58AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry7toOJ219gcXsK/gZLY3pxGSnprkLFqVd1XYoF+5+I=;
 b=its1VW6CmXCVmfkZfrkB9tznWalAXjE+UthZMrMOgKGE9K2/qMivZ5qfTCz2i/zgjTCh6Ap2NvM4zER4q0wYC2mNuVva/T/apqj2TGRaujgPCHBCSzbqNDiXmKOQ0fy+NvJa+XcbdiEoXgwwM0DOEkr6YSInHlgdc2kSOs9zD+7mxME21ftwFiiPxZJdBnqtq1nMQd4GvNMiA5rPlD7ha4Tu6/Mq8do3LKTID03t9l09PfsWbBaK+rlNPjVTgJmTqidlm6Fd2ITLguMnjjNRo6PZcOrtZUTAHUXCBr7lc/zzp4aIffB7fhYhGeyxa3HrMZ0PF2jWtr1Jm6QlmLjI7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry7toOJ219gcXsK/gZLY3pxGSnprkLFqVd1XYoF+5+I=;
 b=T8GtLyq95awciJXYhHkD4Jzk8KflKR1u2JbYdZxPuPbWwj3vw663VEodFL8nk13M0a8Gj65JNvAd3mo8hpFAc6a/MDNvPYSr+AoBdjLxSwbWxLER0y4VjOqU6ziPI+D81ilnHVmSCHyT3Qo15KdnVEd91dbi6G2OMXYULTJfEz4=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Tue, 11 May
 2021 09:10:03 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 09:10:03 +0000
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
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAACiXgIAAVBgAgAAaMwCAAAESAIAABy2AgAAgOYCAFdCAgIAAppUAgADsNgCAACqygIAHsmaAgAAzsYCAAAjdgIAAD/yAgAAcQgCAADqggIAAk6nQgABIUACAASsnkIAAYWwAgALs9qCAAdeZgIACip7wgAo7TwCAACbZAIAARiUAgAARxQCAAS/XgIAACnOAgAAiwQCAAL24AIAAVNoAgABEgACAAo33AIADeaeAgAESCjA=
Date:   Tue, 11 May 2021 09:10:03 +0000
Message-ID: <MWHPR11MB1886E22D03B14EE0D5725CE08C539@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210504180050.GB1370958@nvidia.com>
 <20210504151154.02908c63@jacob-builder> <20210504231530.GE1370958@nvidia.com>
 <20210505102259.044cafdf@jacob-builder> <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder> <YJOZhPGheTSlHtQc@myrica>
 <20210506122730.GQ1370958@nvidia.com> <20210506163240.GA9058@otc-nc-03>
 <MWHPR11MB188698FBEE62AF1313E0F7AC8C569@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210510123729.GA1002214@nvidia.com>
In-Reply-To: <20210510123729.GA1002214@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd26b662-8918-4423-01e5-08d9145c9017
x-ms-traffictypediagnostic: CO1PR11MB5089:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB50892A692D625E62F94B74128C539@CO1PR11MB5089.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LPJgvjFztkyy6dyHDFWXgHYbw9fiqBs+SsK0yHHd7SY4HddEUgGpDtwL7okLu3LSfazAH3liQ6xcIGlG6F3vR96ATLXgkvWgi6//LNrE7IjztjWykknL/GZxNnwYsC5WHpQdtO7L8YD2IBTAEpk7pga5GS+DX6P9brjUV/hFytZUhJRrSUytBYGH5E5LY5t5m+dQ15iVZ7+n3b1XFzzfKU4oltGuKRZy2F+zMereOR6qosdrUj9UCES/4DudAJUobVm/8YUykT/6VNdBHoJ1pooAQoMvHapCRCbOUw0QjH2WACSkIoz2xIz6hLAzzOln3I5Zwu9rGWnsEMV5WKuQg41FhrkenxfvvCF/tc0ULZqKk0nDgCkxZ0BUCXjOn6htUd9zJFaU0OmatrYBYKOllbjbCP5Xk4BCVyH3Rr1C7y/LfJTE6lddigJLbQiX8sVq6AUffnJ/MEUMwjtG6pH9d6g9/Tdz1RaUXK0Z34eiLJfBzf5+7TXcnDGFmyJfCNi3oumld12H2E2v7OQWBm+XBhkNWN9i6vjEZhEr8vd7Tm/XXpIIjdiRrIqPsWiUsxeSpURJq53mta7RpX4y6IaiB/UaAfxG3/gPGMBSgpCIAeE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(396003)(39860400002)(366004)(8676002)(7696005)(86362001)(8936002)(122000001)(4326008)(38100700002)(33656002)(64756008)(66476007)(6506007)(52536014)(478600001)(9686003)(186003)(54906003)(6916009)(316002)(66446008)(2906002)(71200400001)(83380400001)(55016002)(5660300002)(76116006)(66946007)(7416002)(26005)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ku/iVwYE1XaBycwEP02GhUHvkqzYaEK5QVRUTKj6dRKQ51kEuSEo3hJVXMH7?=
 =?us-ascii?Q?SLa9b8Mgxd3EN14jgyKhILtF1U/ChnnWPtPAyeX7saOiW8UiGriTNjYmJjqS?=
 =?us-ascii?Q?8WngqP22gZEG3atoDJlNKeAHWDAf8itRyRnEQYVivTwC8rjgzDc0+RgH81MW?=
 =?us-ascii?Q?mMTzTIBLr896K+9h8ycRwuE0gGPA9uXsFYnV7/+uCKVR+ihe5epWsfLqHQOx?=
 =?us-ascii?Q?cFYs824mOiZeSM+4pZEBwmlnO6gVk/xD3UKfTsmtmjYD4QKmxRmLZlTnRMAJ?=
 =?us-ascii?Q?4WDee3RPAttvk1eQZtFHkG2D8vs4GxQtxjnsYUAFlziI1pFTfk2QLM1VArWc?=
 =?us-ascii?Q?gTN/puq6gu4e4CNHWeDpzSOUEoHJIaFlLEM/ElLg67iIBHWYs7pXqcan2rPy?=
 =?us-ascii?Q?UklgAFEGR/uSthmXijPLga2JdDhG5KVJdohf83mODqaPz2F6lPaO0c85HzSy?=
 =?us-ascii?Q?6UumVZ47BesoWBhaxHag6t1mSoiQpM310PjLRp/uIwSDVnu/rRLj40yJ26/p?=
 =?us-ascii?Q?F5cqb54iK2TEl0qWT/ITTvWD+W6dtnyq1wVrk6p1joD5mCo9/OiXLc+o9nmU?=
 =?us-ascii?Q?NbhdJrnglgzW44D7FxSxDg/F4EyVbuJNW8lLJMiVwtmeLa5Z1Id2fT3WzX/W?=
 =?us-ascii?Q?+lUnUhm2HrzkAvnX0B4lfw/kVow092p4wj6mMWn/dI4Hehx5HzBxiTDcJnYh?=
 =?us-ascii?Q?7BuTtpqKvbuZ6vSwJ1b/4WgatLsv4r53XK0pM0bAIbolx6aNRooq9m4muY6E?=
 =?us-ascii?Q?Fbwh6zPKI6bdS/1xASq7/nq/IMHbwMbQxbtNBDctHwcd1852eyRrAwh7BN2t?=
 =?us-ascii?Q?xqjatjEILGZTka7j/g7GqQ8rfthE+DnWdB0g788qnX8Xcw/VG0yNdxb7G2Br?=
 =?us-ascii?Q?AZDg4FW7IyAyq0jwoqEcWVX+nBlZHN4dYk1PRB93d/epx0Ql5cv8UuCvUgTG?=
 =?us-ascii?Q?QOfqDSzQyK5fcvpBgRkpLpFdhKkaTw5KLdT7r2IaFDodhZn4gUV+Lr3qAMAt?=
 =?us-ascii?Q?Dx+tiS4zyZUofoEko6T4rqb5TnaN69Ba9AOn7cU4T1zf91KB4XxI7xZDUbAH?=
 =?us-ascii?Q?dCqChfrUAYOWmP5Ya1lk4jRg8L0acYLYHVoT/dgMiUaqOqkg7JJycpP+O+c9?=
 =?us-ascii?Q?Q7Lqk1XlskotpoHDnzNUELBp9GUZxYCgwFk39oNTSuzsZaIAKFCHZH23CJbl?=
 =?us-ascii?Q?iMRt8EI7cJKdrA2aYHWfXhWfbjT7Ki1UOwaVi5/+hxYBjrPSnsHKIOxJSMSq?=
 =?us-ascii?Q?b7jJfdlUeLtxCSnY3OPUHPg5Nm8/tlflsWjMn1KSlg7OoainZPz24Ql6o5L2?=
 =?us-ascii?Q?aU5NdNBTxtnU5LebFwZaGmrh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd26b662-8918-4423-01e5-08d9145c9017
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 09:10:03.5340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N6L/6TSkfPSwP8uSFAEWNHxUSE+XyYpQAaGnfbGKRagBe5TQCZj/sThhS9ulFz/QI9v4KyjnMemgRkYtbgwYgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5089
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Jason Gunthorpe
> Sent: Monday, May 10, 2021 8:37 PM
>=20
[...]=20
> > gPASID!=3DhPASID has a problem when assigning a physical device which
> > supports both shared work queue (ENQCMD with PASID in MSR)
> > and dedicated work queue (PASID in device register) to a guest
> > process which is associated to a gPASID. Say the host kernel has setup
> > the hPASID entry with nested translation though /dev/ioasid. For
> > shared work queue the CPU is configured to translate gPASID in MSR
> > into **hPASID** before the payload goes out to the wire. However
> > for dedicated work queue the device MMIO register is directly mapped
> > to and programmed by the guest, thus containing a **gPASID** value
> > implying DMA requests through this interface will hit IOMMU faults
> > due to invalid gPASID entry. Having gPASID=3D=3DhPASID is a simple
> > workaround here. mdev doesn't have this problem because the
> > PASID register is in emulated control-path thus can be translated
> > to hPASID manually by mdev driver.
>=20
> This all must be explicit too.
>=20
> If a PASID is allocated and it is going to be used with ENQCMD then
> everything needs to know it is actually quite different than a PASID
> that was allocated to be used with a normal SRIOV device, for
> instance.
>=20
> The former case can accept that the guest PASID is virtualized, while
> the lattter can not.
>=20
> This is also why PASID per RID has to be an option. When I assign a
> full SRIOV function to the guest then that entire RID space needs to
> also be assigned to the guest. Upon migration I need to take all the
> physical PASIDs and rebuild them in another hypervisor exactly as is.
>=20
> If you force all RIDs into a global PASID pool then normal SRIOV
> migration w/PASID becomes impossible. ie ENQCMD breaks everything else
> that should work.
>=20
> This is why you need to sort all this out and why it feels like some
> of the specs here have been mis-designed.
>=20
> I'm not sure carving out ranges is really workable for migration.
>=20
> I think the real answer is to carve out entire RIDs as being in the
> global pool or not. Then the ENQCMD HW can be bundled together and
> everything else can live in the natural PASID per RID world.
>=20

OK. Here is the revised scheme by making it explicitly.

There are three scenarios to be considered:

1) SR-IOV (AMD/ARM):
	- "PASID per RID" with guest-allocated PASIDs;
	- PASID table managed by guest (in GPA space);
	- the entire PASID space delegated to guest;
	- no need to explicitly register guest-allocated PASIDs to host;
	- uAPI for attaching PASID table:

    // set to "PASID per RID"
    ioctl(ioasid_fd, IOASID_SET_HWID_MODE, IOASID_HWID_LOCAL);

    // When Qemu captures a new PASID table through vIOMMU;
    pasidtbl_ioasid =3D ioctl(ioasid_fd, IOASID_ALLOC);
    ioctl(device_fd, VFIO_ATTACH_IOASID, pasidtbl_ioasid);

    // Set the PASID table to the RID associated with pasidtbl_ioasid;
    ioctl(ioasid_fd, IOASID_SET_PASID_TABLE, pasidtbl_ioasid, gpa_addr);

2) SR-IOV, no ENQCMD (Intel):
	- "PASID per RID" with guest-allocated PASIDs;
	- PASID table managed by host (in HPA space);
	- the entire PASID space delegated to guest too;
	- host must be explicitly notified for guest-allocated PASIDs;
	- uAPI for binding user-allocated PASIDs:

    // set to "PASID per RID"
    ioctl(ioasid_fd, IOASID_SET_HWID_MODE, IOASID_HWID_LOCAL);

    // When Qemu captures a new PASID allocated through vIOMMU;
    pgtbl_ioasid =3D ioctl(ioasid_fd, IOASID_ALLOC);
    ioctl(device_fd, VFIO_ATTACH_IOASID, pgtbl_ioasid);

    // Tell the kernel to associate pasid to pgtbl_ioasid in internal struc=
ture;
    // &pasid being a pointer due to a requirement in scenario-3
    ioctl(ioasid_fd, IOASID_SET_HWID, pgtbl_ioasid, &pasid);

    // Set guest page table to the RID+pasid associated to pgtbl_ioasid
    ioctl(ioasid_fd, IOASID_BIND_PGTABLE, pgtbl_ioasid, gpa_addr);

3) SRIOV, ENQCMD (Intel):
	- "PASID global" with host-allocated PASIDs;
	- PASID table managed by host (in HPA space);
	- all RIDs bound to this ioasid_fd use the global pool;
	- however, exposing global PASID into guest breaks migration;
	- hybrid scheme: split local PASID range and global PASID range;
	- force guest to use only local PASID range (through vIOMMU);
	- for ENQCMD, configure CPU to translate local->global;
	- for non-ENQCMD, setup both local/global pasid entries;
	- uAPI for range split and CPU pasid mapping:

    // set to "PASID global"
    ioctl(ioasid_fd, IOASID_SET_HWID_MODE, IOASID_HWID_GLOBAL);

    // split local/global range, applying to all RIDs in this fd
    // Example: local [0, 1024), global [1024, max)
    // local PASID range is managed by guest and migrated as VM state
    // global PASIDs are re-allocated and mapped to local PASIDs post migra=
tion
    ioctl(ioasid_fd, IOASID_HWID_SET_GLOBAL_MIN, 1024);

    // When Qemu captures a new local_pasid allocated through vIOMMU;
    pgtbl_ioasid =3D ioctl(ioasid_fd, IOASID_ALLOC);
    ioctl(device_fd, VFIO_ATTACH_IOASID, pgtbl_ioasid);

    // Tell the kernel to associate local_pasid to pgtbl_ioasid in internal=
 structure;
    // Due to HWID_GLOBAL, the kernel also allocates a global_pasid from th=
e
    // global pool. From now on, every hwid related operations must be appl=
ied
    // to both PASIDs for this page table;
    // global_pasid is returned to userspace in the same field as local_pas=
id;
    ioctl(ioasid_fd, IOASID_SET_HWID, pgtbl_ioasid, &local_pasid);

    // Qemu then registers local_pasid/global_pasid pair to KVM for setting=
 up
    // CPU PASID translation table;
    ioctl(kvm_fd, KVM_SET_PASID_MAPPING, local_pasid, global_pasid);

    // Set guest page table to the RID+{local_pasid, global_pasid} associat=
ed=20
    // to pgtbl_ioasid;
    ioctl(ioasid_fd, IOASID_BIND_PGTABLE, pgtbl_ioasid, gpa_addr);

-----
Notes:

I tried to keep common commands in generic format for all scenarios, while
introducing new commands for usage-specific requirement. Everything is
made explicit now.=20

The userspace has sufficient information to choose its desired scheme based=
=20
on vIOMMU types and platform information (e.g. whether ENQCMD is exposed=20
in virtual CPUID, whether assigned devices support DMWr, etc.).=20

Above example assumes one RID per bound page table, because vIOMMU
identifies new guest page tables per-RID. If there are other usages requiri=
ng
multiple RIDs per page table, SET_HWID/BIND_PGTABLE could accept
another device_handle parameter to specify which RID is targeted for this
operation.

When considering SIOV/mdev there is no change to above uAPI sequence.=20
It's n/a for 1) as SIOV requires PASID table in HPA space, nor does it
cause any change to 3) regarding to the split range scheme. The only
 conceptual change is in 2), where although it's still "PASID per RID" the=
=20
PASIDs must be managed by host because the parent driver also allocates=20
PASIDs from per-RID space to mark mdev (RID+PASID). But this difference=20
doesn't change the uAPI flow - just treat user-provisioned PASID as 'virtua=
l'=20
and then allocate a 'real' PASID at IOASID_SET_HWID. Later always use the=20
real one when programming PASID entry (IOASID_BIND_PGTABLE) or device=20
PASID register (converted in the mediation path).

If all above can work reasonably, we even don't need the special VCMD=20
interface in VT-d for guest to allocate PASIDs from host. Just always let
the guest to manage its PASIDs (with restriction of available local PASIDs)=
,
being a global allocator or per-RID allocator. the vIOMMU side just stick
to the per-RID emulation according to the spec.=20

Thanks
Kevin

