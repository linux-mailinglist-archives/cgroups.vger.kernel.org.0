Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C1434DE4B
	for <lists+cgroups@lfdr.de>; Tue, 30 Mar 2021 04:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhC3CY1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Mar 2021 22:24:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:48021 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230307AbhC3CYQ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 29 Mar 2021 22:24:16 -0400
IronPort-SDR: YpPkj7Z5hz8hwwcRX7vXIQRYDWT9jCmY32fggGBlg+9ivbi8M5Bbeg2GrZl9+w5yA5WLNuonJF
 C8/uK778cWug==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="253012681"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="253012681"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 19:24:13 -0700
IronPort-SDR: d2iHLO91QekZOvVeM7QiO4E3I5iB/d0rOM9LfAudtoqujXKqr+cjXeEs6NXL0zLi0VFAplyS45
 TunTFDT+tP5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="376659845"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga003.jf.intel.com with ESMTP; 29 Mar 2021 19:24:13 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 29 Mar 2021 19:24:12 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 29 Mar 2021 19:24:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 29 Mar 2021 19:24:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 29 Mar 2021 19:24:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ib5HluXWnt2EzoEUwfJLHrrwSqdoz6KZoNjSed3dMVgePcII4j01sX84wzeid6Swb7lGvHXZ2JY3IDjpoxFvUYYWaMk5a1EkfW0vtIX+NBBmsEqPl1lLUjLZN3kKSiNCU8I5Mhr7LDXWhN8KPU6VjZsSO0eUn36kJDqSr7EcuUj4SU5pd56pdg57pvj/I5jRfkKeIiqX2x33Mf6NZl2G/zmaNP/bbnzYd/OBvQbTEkIVSz+dGgg+7O261ZUniAbUa8obs8LlEcEiHG32LSnV9lgU4tzaTQf0ruoo37iPM4T4JF6bCHH1dSMOl5LJ3wWBZr273ahevipZ50kn+ryfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yifpqWXgVu+yqFKJ1gV498K9qIJTDYZf7ExZs6hCv+0=;
 b=fDnCa1hYcKhAOFBOVrmnOl3feNJNAGtfmCWgF32X9FR0ULvBrLmjKxXnZXCcFA0F/FQc99TuiZV9FpWB9o1vEyNDgPZILqDl1mTAJmF9epLcZUC/GK+OhbeLPRiO2FKRkjKMyU/BmubfycQtmWjzC73ha/jmoK0bCihs/i6OQyGV8WuWLppnQ1XXAWQDM7M2VJA770KqosGl/JjhxzGogVp2MQk+DTwu1Wfh2GrYG1BGRXzI8U/gusXMhYtIbV36rbnoGOnMIJf2OO7sDYl6ofgaQz3FS4SHwbWi82C9bmTZF8HyORfs1Dy20js9DMQkoxF3NG2h2/s12O1C/MLWtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yifpqWXgVu+yqFKJ1gV498K9qIJTDYZf7ExZs6hCv+0=;
 b=PHPa1wvqAJ+XpXWt6jWOU+7No5y8Cj/H37s+ITAFXpES49f9lUML/v4aQvQ+UBIjXmDpCeto6CFmtKzAq6YPeWAef5QllEk4o6nKG74+G7aS9IZBcRVNUQMDMVL+FrscTqAMN5+wjmbV6OuQDAbKQaHuXeQTE6dSpHkiRrM2gSs=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB4931.namprd11.prod.outlook.com (2603:10b6:303:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 02:24:10 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 02:24:10 +0000
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
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAoO8A
Date:   Tue, 30 Mar 2021 02:24:09 +0000
Message-ID: <MWHPR11MB1886F14B4C7C58C99F54FAFF8C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210318172234.3e8c34f7@jacob-builder> <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com> <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com> <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com> <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
In-Reply-To: <20210329163147.GG2356281@nvidia.com>
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
x-ms-office365-filtering-correlation-id: 9c228aca-4e43-4866-8b7e-08d8f322e6d7
x-ms-traffictypediagnostic: CO1PR11MB4931:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB4931F0D610BC7FE6672437238C7D9@CO1PR11MB4931.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aScb/Zl22S7HjTlOHk56Lm/X/arXTQnPhco86fsXDat56l8OOkLiwrFZwMCg5Ho3Y4EJiMQt7Ka8VIrnlzuqSei8QjY6K6jz0wtGI5XDMyit+563z0Dk+87LreTtf3kmp+pza1LSt0kgKHf5M8Z/dNztnvceaRbV1b6hK7pmb9CZDzDhXNbWcj9f0WC1vZE2QRSQnTJ1Z7T8ODnMiUrnRX+eYA9xI73r8sA7cJdgXBVGDXAZy7GCoXynQ3gZZpMPVFhmVrqB5PyMxaJCcYVV1lJmAukdZoz/QMt5GKAfJg8ZbGMO1vSfBOnqSlEEWMlF7HJsVFNXxJWbE/DHIcUzHv+eQLO68Q1CBSr8vx9XZ4OciZ8wh6bIuucLehCUriWA8iwDZv5MqAX9Eon7bf+AZwe9mO3//3+muunFu9AaFTcQm/bz/qMQ53PM0KFnooOLTx0FomxJRJJ9snyvHPC/cI95jqfJ3YbCWIHBqq9I43C4nDlYFs1lq/isQ8gtF/iLbSRjLCtA5wcAdAJHC4zW92bOP/2crq1glbpC5SLEroJ9BrajSS+LBPHzJJCwe++JmWqV2bTF2W2QAEibzJaKOO+nwaToQXx7Pdi4cOClEE43GVm82pSi4IN56VUHRd3qObWqlim1tWALgoDhEKQKuxBPIyHcfEey1xqUfEglAWE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(376002)(136003)(39860400002)(52536014)(38100700001)(86362001)(110136005)(54906003)(6506007)(5660300002)(83380400001)(76116006)(9686003)(26005)(33656002)(7416002)(478600001)(71200400001)(55016002)(66946007)(7696005)(66556008)(66476007)(64756008)(66446008)(8936002)(186003)(4326008)(316002)(2906002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4d2ry4K/0AcoFZBoYhODRLeruZddM/OfdUuK60NO1aPf1qMJHhtYpBC2uh3R?=
 =?us-ascii?Q?h+e6ktOoRBfPySJeTHDG7q5zndpB6dxczEYPqxdZctiobNN1PNTREEuma0qY?=
 =?us-ascii?Q?Fhfkvo/oR1SCQ9Jyev8R1kptqoVScqqnJLpPpsaV6Z/FvcX1fSIbcqAf8FQW?=
 =?us-ascii?Q?QFtxMP9pT4y4dr3uZDJObBcwSjw17oFjBRvqSoyNgneotW9flnI7CeugU/Zv?=
 =?us-ascii?Q?I2yg6IyEFVjQmH8YwWg/np2DgKqV2NbDmJLtG3KaoYCBvYDsQl9Ith264ROC?=
 =?us-ascii?Q?+o5KWUEAJysnGp+ouqbZpCEnajrS+3EYdVBpf7IWisH19D1wYWZhOvN+k8gZ?=
 =?us-ascii?Q?oI31OXHrjLDSB/EUOrniWRBcPm0EP2ywU11aiUDIvIwdaJBHmUb65yn/XbZZ?=
 =?us-ascii?Q?HI0Vc+m1mcbRmpdwKNuusRcmsY/MTGgZJb8GFMY9gQqUx/Qnv6HvbJmBtZw3?=
 =?us-ascii?Q?BVJLvLEC5XaLpL2Z8ZotS7zLpQBvg/qMK76bL6KNdVUAG0C1Gyx6+73gFIZv?=
 =?us-ascii?Q?XqVLzVof/dFxmAZYa1EOKlo5jT/GtW2FbLAjP7oFPUmxbIu0Sx2TK3kIdbAu?=
 =?us-ascii?Q?36hnKmNgiwLtxB1l2DycM8FM7HQHRHD453KYQq5Rzqzypq6E58kIPHUJZ3n/?=
 =?us-ascii?Q?NnCcXUD+zOo/Ty+uHVPKPudofWjNlHP96FoYvZexPv6/4MKLygzX+fAOI4Bf?=
 =?us-ascii?Q?ZQE0UjYC6swGWORiYLT2uS0zzWMt4KeblwJpHM9n2TuulShoyqQOrIjqZA6h?=
 =?us-ascii?Q?j9LuKo6SB4j97LyekM2X1xTa5PqSWhJKSpHTkHeo7d7Ue/tVz2Vi+k7k6lMd?=
 =?us-ascii?Q?iREkFfg78yNBD1ozaI0bPqdqtVf7n1Tb/DNmKgX8BDAcnV2pbWFP+pOQMsQp?=
 =?us-ascii?Q?Ai7QBxDorm4/L4VMBK2MxPxeH+G4U/bhA9GSimmyhNlRtJOqTGjmEI0dpO8Y?=
 =?us-ascii?Q?vRJKnGaZ2zZFHMceu1nIgdmHGDGEHvEjD403rsI+gLN8qOljwHnUbZnbFAl3?=
 =?us-ascii?Q?JrOnZdCo0YFarKsUE4CWznWXLdu907/nKh7A1XapW+hpbRn8c7231lvb9Xdo?=
 =?us-ascii?Q?T8r2wkRYl7TqALLyJLdGBVBxfHTgncBceEYnyYwPuU6BAeEOADyp/ktuiA4p?=
 =?us-ascii?Q?SySGU3xSxy8/QxaKlCRsFWnTJguusaZ7cJ+s0474SjIWOXEBKpKPVvTMQ4iH?=
 =?us-ascii?Q?au0ZtRHx4nPBc6UYnbOQ7H9gD3eQtf48yWwue9bOpmadU3dRyjpEetETKmC9?=
 =?us-ascii?Q?8BTz8NhH4aRg/3arlK+gdeSvZODU0E9RQcNamSe6v8eigriDnpxucpVvXqcL?=
 =?us-ascii?Q?OdlkgTRfmH7Fkt1eL92vv1aN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c228aca-4e43-4866-8b7e-08d8f322e6d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 02:24:09.9038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EiS8BCYIOQOf3CDQ5IrFgBN0hnOD0/lmFwMBjZXMb9RIUwrfrXsML9GD2M5u65d6QfAtdZGi7I+X6uYRQy0w3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4931
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 30, 2021 12:32 AM
> > In terms of usage for guest SVA, an ioasid_set is mostly tied to a host=
 mm,
> > the use case is as the following:
>=20
> From that doc:
>=20
>   It is imperative to enforce
>   VM-IOASID ownership such that a malicious guest cannot target DMA
>   traffic outside its own IOASIDs, or free an active IOASID that belongs
>   to another VM.
>=20
> Huh?
>=20
> Security in a PASID world comes from the IOMMU blocking access to the
> PASID except from approved PCI-ID's. If a VF/PF is assigned to a guest
> then that guest can cause the device to issue any PASID by having
> complete control and the vIOMMU is supposed to tell the real IOMMU
> what PASID's the device is alowed to access.
>=20
> If a device is sharing a single PCI function with different security
> contexts (eg vfio mdev) then the device itself is responsible to
> ensure that only the secure interface can program a PASID and a less
> secure context can never self-enroll.
>=20
> Here the mdev driver would have to consule with the vIOMMU to ensure
> the mdev device is allowed to access the PASID - is that what this
> set stuff is about?
>=20
> If yes, it is backwards. The MDEV is the thing doing the security, the
> MDEV should have the list of allowed PASID's and a single PASID
> created under /dev/ioasid should be loaded into MDEV with some 'Ok you
> can use PASID xyz from FD abc' command.
>=20

The 'set' is per-VM. Once the mdev is assigned to a VM, all valid PASID's
in the set of that VM are considered legitimate on this mdev. The mdev
driver will mediate guest operations which program PASID to the backend
context and load the PASID only if it is within the 'set' (i.e. already=20
allocated through /dev/ioasid). This prevents a malicious VM from attacking
others. Though it's not mdev which directly maintaining the list of allowed=
=20
PASID's, the effect is the same in concept.

Thanks
Kevin
