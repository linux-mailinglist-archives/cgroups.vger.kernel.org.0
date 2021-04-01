Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F83351E47
	for <lists+cgroups@lfdr.de>; Thu,  1 Apr 2021 20:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbhDAShy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Apr 2021 14:37:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:21439 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237825AbhDASdj (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 1 Apr 2021 14:33:39 -0400
IronPort-SDR: Ln5mp+JK/DSC8JIs9+RlJggEH1Z/YiVin4eURTZd3aRtN/UPR3dbBNBR2PmBeOP8pjsNBHFs8Z
 Bk/Dhp4DdglQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="172270780"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="172270780"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 06:10:51 -0700
IronPort-SDR: P0Co626Nb60sBjbiBFZZOY5DCxm3HC9T2wxb4kgPo3TK+bk71UEB5mA2C/WuJf0yZPO4Y2e3DL
 El642EceMzuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="412678277"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga008.fm.intel.com with ESMTP; 01 Apr 2021 06:10:50 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 1 Apr 2021 06:10:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 1 Apr 2021 06:10:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 1 Apr 2021 06:10:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzM94p0kRq1mBEmzXKAaTapyuegnT3DyLb1hmaZuBpdXNrYDkpDSGn1OrZf59WPGtkOd45klV84kz6CWOPJCU+puKJrPyrDKc9LZHj5CCKpwYLtOwdoia2GFyhzRxXJk++nJYH5p1fF+yjlQZ6BScJX13DCnTswCur2ql0shDPUSbu9rlrxxr7OufKTyAxrDuvgr5JDweKOptRRvPcs4uLFu+s3fXroinLFZCkJAuppGPfvaksSUdBXc0Ij5y4DH39kDv5EmTFt1/+6kDaLA+TvlOMNXU/OErfCQopPZXM+RrR1QXkjo9t8nW+GZigdTHxC4Kyvx70I+3QG9MNRpQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/7vLWC2v/7rHFXrU6lEbUmMu7vl7X1aHBDTI8ba3Js=;
 b=RcOU7HTCcx2lYQ+/RSQ5J5qAXVf9X7AqGqquSyYq0TnkW0E25h5KT3lvUUeZ76Vy6CtgpTPXO07RYo5bzjaxkwa5TeLg2wnc6zWZQ3CRzTq9F626C9ppuXQokCIasATU3pHTEhTNIBkSSHr4Urlb/3+U0Ww/LK1bFe/p4b5R9ONqlwL10BlSmjRmsLxqo2SDhFTwyxMiV0VWBM3MVlVx08LqboVkzpgwPxsZBloMB2+w9MYCBQcV8WHYNp+m/jJGSSdKRRo5EHe3p1pZtn+wHOrCeqro5ppUJMHWkZOWlRisWuK9U+jfy7XxvoBGTl+QATJ6CaHhsrOl3BjEJouwEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/7vLWC2v/7rHFXrU6lEbUmMu7vl7X1aHBDTI8ba3Js=;
 b=ObN4cbxzx4M0AyvVyHT1Fq901ePWRlhJ4k5sBc5KRLE27LHF/FeW6xgPLs57PgTIXFJyiSEOIKncjYtOLbixiB2VbOTEFunbX4XkrxL5BnpgINWBm3vTdTCAgKfZFLzWCClWzb2Viy6M8QYbZs7DFyxBtWSC3K+aXn/Ic1XSI7g=
Received: from BN6PR11MB4068.namprd11.prod.outlook.com (2603:10b6:405:7c::31)
 by BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 1 Apr
 2021 13:10:48 +0000
Received: from BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d]) by BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d%3]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 13:10:48 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
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
Thread-Index: AQHXDZuc1/oaTFwUU0WheDxUmLBHiqqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAmFuAgADGxQCAAR7PEIAAZiYAgAECgOCAAIDKAIAAErow
Date:   Thu, 1 Apr 2021 13:10:48 +0000
Message-ID: <BN6PR11MB406858FAC3821B84CCC4D30DC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
References: <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder> <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder> <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401114648.GX1463678@nvidia.com>
In-Reply-To: <20210401114648.GX1463678@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25d7a807-6c69-4435-f78e-08d8f50f9167
x-ms-traffictypediagnostic: BN9PR11MB5433:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR11MB5433805D0C4B26F59E38C1B5C37B9@BN9PR11MB5433.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sE/1TO9x2Gv3QoESYRFuVTno9cJxchOSaybf7uokUmALBd4pMTctuI4fdDrK2ppMcjjhwKoGhokxBtyQzFlTLalOYpgwcS9ga+JoDsYYgtGua8kAtlOiwZvf0LzJJPhk6WbsszTmTzVB6C1AGm90lS8UmyHZ932HRBrWYzo9zh2pGqOq6KLhJcyQsLLpPF4IluzyS8qU3MPdfoCbqYeD5f3HH1+wtw6MSXkWcHgKxo9YY7/SUsSVFbT/ppK/eQNRQLUy3ntn9R1TSAc5C6fTNAXvlDXL12bgZMgmuJe2QR/hXq6zHU6tDr3uWPKEYeexCx4uWkUBxadXR6QUMzhdBne2kTq9Iesph6nVv8j+c6XCjmZuQ3z1iXCKM8teLKSGHDQGIvtqp7T4jnZurLFdtPJCDUZ10K/5NxfJje8utb4oYmYBXhJKyGneObmLzftWd7EVQBMidO1AHs7VP0sDfEk3RMP5r407iD+9vhbZxVucCIvY/p0lx2Rd8UiaH5FhnrHg0raKpe5v3pY5+Fw+3XWmT86eJ4QwrlMlkcN7phhj3sZ7Rn8VczbXXNf7Jp7QaWVmqFpOrjdbcGN/RTftqJ9Rr6sQNgpRhbqEvi+g4U/5tA9y+Q/uwrdSyr9skmxJvoCTWPGdQ4vjWYE304SryGFDJT1aLVB2YM7pPkvltXY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4068.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(39860400002)(396003)(316002)(8936002)(6506007)(8676002)(52536014)(5660300002)(6916009)(76116006)(64756008)(54906003)(66476007)(478600001)(66446008)(66556008)(71200400001)(7416002)(7696005)(4326008)(26005)(66946007)(186003)(2906002)(9686003)(55016002)(86362001)(38100700001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zmckRoiQZ8CRquCgv0UW9n3fqeqDb4hE/Gi8nGmilqfujUYY3t/1IVjAuClW?=
 =?us-ascii?Q?H6KwndXXzz58b4hBUXwzQ0SLfVb3sImypAhOANfllIH38PoqK0UTKE03ZepF?=
 =?us-ascii?Q?2U9maBZkk8Iu1LhrxTmfW8fCrp938WcDHkxoc6EHp4zdR8UpS+SXQ/Qu+y1B?=
 =?us-ascii?Q?yDOSZ9zGZkpF0ewXvwEc4YGxB35w5hIL6APWrZTiXoPZgoe6VU9K2rd2MqF4?=
 =?us-ascii?Q?vp2occ+WzbA4nkCPSeLcnAX8JXc56rlDUSElQ0c2pWsjEce4Vj1ZCe9voE9F?=
 =?us-ascii?Q?fgUdCMYWdBFkqrdUaCHnmCu28BXScIdH3qNI4sySxikYwucP8SWK61Lhn8Yk?=
 =?us-ascii?Q?pqGDM6M3z0W/lPCWTOH6w+OG3HM/+uhhKb++3a0i9VJA9VUQdCWev00J+x5Q?=
 =?us-ascii?Q?lDDo7132fnyHV4dwj1+TAEr+xe+A3timnm1MJ3stOgAY5WlAGU507sxKty7P?=
 =?us-ascii?Q?YKUvjM8vVSkI8M2gLfjHqS9H4/DGfIvUBymR3W78AUTb4PTG5EGIEyK1jOfw?=
 =?us-ascii?Q?Uxu1YFcjx03w8CdhMl+o48CjUwlRBjZEsI2GR9yXY6Tg1v0vrjIekTh2vORH?=
 =?us-ascii?Q?0HJfztqGTvnAVSjnu0nZAQJBnnB+bAEdrabAuIazZJV59EKAFxkTdU/eGKVp?=
 =?us-ascii?Q?sGMSQwp2Lz2pATPDMhtq41L8Irv4Tj1Oy0cuaPFRj187PAT49+yQiCYMn4Yl?=
 =?us-ascii?Q?lf7hxL15fEQ0mD/3ysLSelftYnTSOJKxntXBJcjsHkF9kIigW1zOg5hvTPQP?=
 =?us-ascii?Q?GcIw9qb9ugpITaNn4REoVj/PiE0qupdKNHqb38N8CoavDLiu4/a8/sm5Ogg7?=
 =?us-ascii?Q?NZZlgSWoutadmyNbND6dGtiaAzkb5GNWRROp2MNHUTBT8qtowhf2K6BtC0GX?=
 =?us-ascii?Q?3z8p6phsseHqYdgkOTBRADSSo88P+trIrgSOCJbFnkP1KVZ7UeWefXbQVFzj?=
 =?us-ascii?Q?Z/1wqP3rU3L1cgGTOT4UrysEBAvOzEWwXp6pd6wDEjwlAzOSQyocaUvN9sDr?=
 =?us-ascii?Q?tXTob902F4FeESV9NZL6sYRdQvAefBihBBPQCn0KmWjuSHZP1EHDQmi2Ey8i?=
 =?us-ascii?Q?JQ0Iueem5L7Bz6h860Wkd5ibpsCEqA242yDZeojiRiYjkh/jJiVSyoSfeCDy?=
 =?us-ascii?Q?uXIKBIQLd0DgfEO91zEgDGKObBhwkzCf9VlyQhpYMwgfaoztdTbW7wRerPc6?=
 =?us-ascii?Q?JpxMYimOnvVDMNdZo0dIcfMY/d7NwyPKhAiVMuNZbkqTrWzB8KGrAifgI/ku?=
 =?us-ascii?Q?rL4IlJ1cGdMaY0KWYyq4VkEGboG5gmBdcQ7UolnO60TcFEHapsp4LOxl0J0M?=
 =?us-ascii?Q?/xw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4068.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d7a807-6c69-4435-f78e-08d8f50f9167
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 13:10:48.4300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uo1/StE/pCQg3z+A83nC+RBTS8BTt6kFa5ZP3vhPlmkEBrF3eZz0DEKYqxD9BVZwGC/JfkVytP8T/6R+CK8d1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5433
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, April 1, 2021 7:47 PM
[...]
> I'm worried Intel views the only use of PASID in a guest is with
> ENQCMD, but that is not consistent with the industry. We need to see
> normal nested PASID support with assigned PCI VFs.

I'm not quire flow here. Intel also allows PASID usage in guest without
ENQCMD. e.g. Passthru a PF to guest, and use PASID on it without ENQCMD.

[...]

> I'm sure there will be some small differences, and you should clearly
> explain the entire uAPI surface so that soneone from AMD and ARM can
> review it.

good suggestion, will do.

> > - this per-ioasid SVA operations is not aligned with the native SVA usa=
ge
> >   model. Native SVA bind is per-device.
>=20
> Seems like that is an error in native SVA.
>=20
> SVA is a particular mode of the PASID's memory mapping table, it has
> nothing to do with a device.

I think it still has relationship with device. This is determined by the
DMA remapping hierarchy in hardware. e.g. Intel VT-d, the DMA isolation is
enforced first in device granularity and then PASID granularity. SVA makes
usage of both PASID and device granularity isolation.

Regards,
Yi Liu

> Jason
