Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DBF352767
	for <lists+cgroups@lfdr.de>; Fri,  2 Apr 2021 10:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhDBIWe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Apr 2021 04:22:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:1213 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229522AbhDBIWc (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 2 Apr 2021 04:22:32 -0400
IronPort-SDR: B+NgqlJFdtmxKXxb0eZn5Bhs8ml2hG7G6nll+QnkbD6vjhtkckEKiV2QpZJq9xCmX9EVRDokza
 qgyP1Lb7AaiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="179949982"
X-IronPort-AV: E=Sophos;i="5.81,299,1610438400"; 
   d="scan'208";a="179949982"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 01:22:30 -0700
IronPort-SDR: 2crRJvln5awoHIY3DB7DM7g/N/1WYmWlPhp2To+YzTItAVjoWav5hKhiMSZ5pck6qqZSuLMD06
 zWLfP/doGKQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,299,1610438400"; 
   d="scan'208";a="596657406"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 02 Apr 2021 01:22:30 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 2 Apr 2021 01:22:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 2 Apr 2021 01:22:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 2 Apr 2021 01:22:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 2 Apr 2021 01:22:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rai8AxMN65pxk0Xb8TVWOgGXB3+Mc2Sch+l6nVkHhRw9Yvn5FAEHNDG06CG8iAn0OZhQnVbLV2wVH619Pglhz0DmkJ4dKuOmiXodw5Zs0aDd8LKB8n2e2TVZxUpTt0BfKURYxfAaZrbJGRTnK0/n1tSBP2xLvt+R9ZU3Yo93pCJKqoKpNWdD43H5Y16vxwDd9xobBMKcwqMwL03OJ8DHdK1s1DQhMmmfTNVTPSdewwHmCUpbx/WhjlcibRe2uBvOhtVa8DEYcyfXU0hoiS5BSzvvn+tsDkc606XcII4LPixEutef/CaNTXn8VMC6CYk3LZwXz2ZrSu9yAhafuFYLfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VusmaX7Q1WBEhTczFXap0omSnLIBW7wEZc8f3ATgVr0=;
 b=lX4Fe5tdcz7Yxxo6SxB2dA1yPgxJtLjm12jAp4PCKd9ppC7bb/LxuTA1OqVrD7vAEVuOmp6S80pBWL3pBJ092QnqSJ2E9CwyGTe/ISNqtabsqWm8+TToqlhM/Ex9m8mUMd0LbiEhpjIwMD38ECoQd6WQ65nn5kpq2dmJZbeF+7ZqYdurIDAyhiuxy49TaptlXsHxhqrndGVRo2gwcwuXHd0zP5V0RJ3M+kNII9F9p4y7kvSFn4MBzRdb43yugJjRuLUlwaBzgbV9rQL9zZrdi3JmGmNpfeOXbY+URF1zxM7T63dXf0FTYjjifYL0I4WDfeA7VNQnScLLdkvmTCW3NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VusmaX7Q1WBEhTczFXap0omSnLIBW7wEZc8f3ATgVr0=;
 b=fKoh+xpWV++sSCesW9H+Kiz6H9HqMENFBsclT9RX3WL0/9D6qLgB2X6oKKpWTpGLas23B2VhQHMZpNYNx3VPtUD5BQn0P/pGm+3TO3PfC6OI7TQm/lv+i1Grl13Rnv9G9ZwHhiid9r73NU/9tEZfUThKSTENN00p7HOaP3wGMY0=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR11MB1327.namprd11.prod.outlook.com (2603:10b6:300:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Fri, 2 Apr
 2021 08:22:28 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.3999.030; Fri, 2 Apr 2021
 08:22:28 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
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
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACABFtkwA==
Date:   Fri, 2 Apr 2021 08:22:28 +0000
Message-ID: <MWHPR11MB1886CAD48AFC156BFC7C1D398C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
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
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5b7ba21-3f3e-487b-595f-08d8f5b07401
x-ms-traffictypediagnostic: MWHPR11MB1327:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB13278E7A84EC4777877F01418C7A9@MWHPR11MB1327.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g9xs5GHqoOvo4kOKlHHkaDyADmKUNDl+QYiU+i4492oZQisEINAmmhC3RkbRGRipc5gIj1GvgavtPImx/GRpMP8RCjA5z4OfNFDSLk9xzWwlAvEsHiRviaaxWflPK8a1flIqOQUrUjciblhJQ2E8KSG+Sx4/WI1HPnEmdL0Nx8sCb2VinC+CDqe1C6mVHkqSlNnyhgMr64bKbMHciJvssTnetSLOOYMR8ovAAsXR+sowIROmXfeLgFWfEr0xZBMflJr/lJPZw+sn3dmGQrqGngLSHUNfM+GaWhWPEaUMPLMSo4FGEzmw20jvRqI1nFx5ltX03B5rioiBZt5ZBPFg12MrxcOZjUcC8OtD2qqwGvRnDnm1ObR1R0fs0U39jb97PHzRy5qOWxu8/UyV0+JMuKTXduJD6ytMJa6o/s4uLJkXjtiJBQOM4IYd72p7ZFMchPhibdHSMqdnNL7/Jv3M4laFcmDnxwPNOIfK/EdYuB7hl8gr1DIvPxmnY5CMJoXx0kReTodLLZZO3c37dn8uZhL2rJWykplqh6G1+GsCfMPk7McQikaaG8VBTfy11VSI3BEDm+OAyjZLOUUHIGAHG0t38Hb+5SdHqz9IWk/OKLsKZacOPzG/oKHaklqnzfXEol2S+/fTLX0WP9v6/yE7G5wWkZ15a6f0taC1p/4cjaw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(39860400002)(396003)(136003)(83380400001)(55016002)(5660300002)(38100700001)(66556008)(26005)(66476007)(316002)(6916009)(66446008)(64756008)(52536014)(54906003)(8936002)(9686003)(8676002)(33656002)(186003)(6506007)(86362001)(4326008)(66946007)(76116006)(2906002)(478600001)(7696005)(7416002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OPuqJhROTQ6nchvXbUIzlGsAxCgKmtFSal0QZNfGrQ3CsPguSiRgTSL/1n9A?=
 =?us-ascii?Q?qhWkSPUJkfM9agDksXqfbXLbOiasrUiLjKaMfGnwZxnvIOhcPBGrz2LwELuz?=
 =?us-ascii?Q?qGIF90zOthyLyUKzWm9svSzgbb3YdUYOexivzLwcOlEC9od1lqj/qJgZ8uYJ?=
 =?us-ascii?Q?yEq9NqDKTgBPEmZYqPe5iMdfEkXJefBJzZtiPNDp3+QeMNqU+NWL3DoGDuJq?=
 =?us-ascii?Q?EJJ3bIruAdMmDVgp1W4No3niKNnLty6s/3PLrWq6MKDM1vazk52nTlENrp9u?=
 =?us-ascii?Q?baa/P89iGuWIggWi/ByIULpiuW4tjhL9IKilz+0rHdjrWsSmBVBIe+D6AMJk?=
 =?us-ascii?Q?lp/vICU1Win6l5lE8L2UffY7QnNHbWWdNSeWfijGe25VM/r8MgXnKwkD8skQ?=
 =?us-ascii?Q?+jsHFqxuNOfUz9S5p5NOs8Mjrxq4BPFmnAMXidmLe03x2Jt76ozqHT3ms5Vq?=
 =?us-ascii?Q?5JQe2kBneRawpFPWqySSZ/Pdbh1yCHUQU2RZekXgsLYFpu4yMxccQfcpETnE?=
 =?us-ascii?Q?35f0cj/Qzwt+g2LPrg5SWBHJMPUnwDxhRrKi94cj8uYxIb5DQdYWVwMUgdDd?=
 =?us-ascii?Q?Pm2THeLwphesO0j/OsTk8ZxyCf3UGTuKeBzoK1Hs0vuAIq65ZFOswShJ1SLy?=
 =?us-ascii?Q?HJsMe+y9sphWq4cvNFy5ELh0jyqajM4U12U6hHUR//0K94etYSG378NIgJ/0?=
 =?us-ascii?Q?fqPr6uCZAIBr+XxXu7FUSEiPEyF/zZ34U48cw5bDIRbUANS+J2vlDCqJVk1L?=
 =?us-ascii?Q?kFCCHgfPkzy6dvRV9PWC03xBafSEV6Fg17PcaG6vBNlQvEQVDC4fValNzcxq?=
 =?us-ascii?Q?P7c+Vk/RQhpkep9JeTH6o9a1loMdr/gpKEIOK4iZPJbdCP+pNQr36DquSmmB?=
 =?us-ascii?Q?m5Cnu8MhfNsJmfL6he4HEzsQOcHMawP6N6mEzpzU7F89JSZnRJklXjfVxebL?=
 =?us-ascii?Q?iKYnXnjK7g+jCjcsqkGZS+cF55UogTm/o6/9XJRQoxdEqi90nK7dwXD+2SpB?=
 =?us-ascii?Q?I1bIQJN3XDJcrcP2kW2pxDLSN3pxBKigWQOhQ6/O4c1GyBwM0UmvaYKSxECJ?=
 =?us-ascii?Q?tDD3nhhrMhszuhebxvI1lXzCdmaKAMCPP5p3l3lwaarXVJmnBvp/dgXOb+Jd?=
 =?us-ascii?Q?EwwZ/7M/zpJn1z2b22DN4USONTMSXwH/LcKUoIecao34wyX50elddaTnuE3S?=
 =?us-ascii?Q?fgccElsNi0nCRVmDIDcso4TwtrRlD7s+uT65nHsjB7QXkym5Tup5/b0byM5K?=
 =?us-ascii?Q?Ee+LNn7EWipfwPQAGkjfkiAqA7SDEv3KvMkPXgweoZWpP/MJnKUlvRBE4q+j?=
 =?us-ascii?Q?KFnNj2v23V1Q9e2lTxdMB3Ph?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b7ba21-3f3e-487b-595f-08d8f5b07401
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2021 08:22:28.1590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oLpuzb4KUwAeZqoKsatcHHvz8dewF6sMjtqP6y2UGhqKzbKou9uXhDoQd4NoQFd0CuHe6ey3DtANPAkNzkzNtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1327
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 30, 2021 9:29 PM
>=20
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

I agree with you on consolidating things in one place (especially for the
general SVA support). But here I was referring to an usage without=20
pgtable binding (Possibly Jason. W can say more here), where the=20
userspace just wants to allocate PASIDs, program/accept PASIDs to=20
various workqueues (device specific), and then use MAP/UNMAP=20
interface to manage address spaces associated with each PASID.=20
I just wanted to point out that the latter two steps are through=20
VFIO/VDPA specific interfaces.=20

Thanks
Kevin
