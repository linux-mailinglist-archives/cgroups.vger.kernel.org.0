Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934AF351B6A
	for <lists+cgroups@lfdr.de>; Thu,  1 Apr 2021 20:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbhDASIe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Apr 2021 14:08:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:1677 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234759AbhDASCL (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 1 Apr 2021 14:02:11 -0400
IronPort-SDR: 3OxDQmdjFeSSHi0uqNbtYVRzPxPZ1xjYES1HBY+uCee+o8y6dr1f9Hro8ylUkgHra9ddBBrtt+
 ZEnWuuERuNQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="256228976"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="256228976"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 06:38:51 -0700
IronPort-SDR: jEOy2zBWUTt1C8k/h0rKvwNUlC7hfNpsUjPVaKWSE6GFzvUkq2MCsOY04DjpYGg5z0OrJ98Nvi
 AS/8LFBIFT8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="394523192"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga002.jf.intel.com with ESMTP; 01 Apr 2021 06:38:51 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 1 Apr 2021 06:38:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 1 Apr 2021 06:38:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 1 Apr 2021 06:38:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNrf906VsD/keDOn08b5RgbWi21Fwwhj3pfBvoU+dhRuZHwZP+MvHeRV6GJAFQzY7jlRIhg0HNT2EpoZaC4Ya7NnZtuK5ROPotJbc+afGTQH74FJIVqcQk/qlo7PPWvAnkqEzz8I5p6NbK6Fc1prE9WP+gjFpSCUoXkUsWGtLzrQaAZRhjCmqCwRHICBYt66x7TMhjThbYgM7TmC1nTqlkwa+7GLR49cauUdRjELHUq72MXHqF8AKQ/1g4u4ZfhjzbL6abUvsoay+yZ39d6bUJGeV6568NFZzbzw/M/hNgC8jF/aRS1IuoHZyr2AcwyH9uk6i/caHLSRllBfA83/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4aCZLcmRmvwTsMYLoQIOWyZA3fv3wdRCpydHL9DfLI=;
 b=X0trWTmyNE/ptjZRETJOTVlarUnvQIFsHQIAfaD+0TK40gSaI+Gdo2ZgCbTIWUm3tDUzPm9gIKc+yrCjC+qxdmPKPwVBXXxNAy1YvXQn1uuBJWOxSbsaMFD/w1rF7GNQC0SbJTAaxi5wJVxBJzKSmFCvz7KItpHrYSuE5C1Ci1Wk1hIFv7WZNOLyGvDv5taxWMWvRuwklLwwT++1WZmuQfImPGdv4QlvOTFU4jW8DYIyEXWNBJjAtXnD6d7hPV+4KRR6sDwfdf9FcE1l5VdPgcjOcDLs8/1+dNqTWLTqE1KFoPrufPr2J5ryKg4vwEiHIPU0bCtCiAUYXrbkOZlJLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4aCZLcmRmvwTsMYLoQIOWyZA3fv3wdRCpydHL9DfLI=;
 b=Y2s0s9ndwp8QV+8vcu6anQzNVejo5EoYUt0qEUKawmESsOtMexzwI0l0wkoRxqdfkNRQOcNSUd4zI20YHN0Pex/Sj/7I5NJVzH7O1hbtHMFtDMbnSboP5hlguESpYF4nSIzreyNyuyF7uiJqE2CCTafPJfX2XsJ5pWHY+t4RKuM=
Received: from BN6PR11MB4068.namprd11.prod.outlook.com (2603:10b6:405:7c::31)
 by BN6PR1101MB2145.namprd11.prod.outlook.com (2603:10b6:405:51::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 1 Apr
 2021 13:38:46 +0000
Received: from BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d]) by BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d%3]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 13:38:46 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
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
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZuc1/oaTFwUU0WheDxUmLBHiqqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAmFuAgADGxQCAAR7PEIAAZiYAgAECgOCAACyd0IAAWUMAgAASa2A=
Date:   Thu, 1 Apr 2021 13:38:46 +0000
Message-ID: <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
References: <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com> <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <YGW27KFt9eQB9X2z@myrica>
In-Reply-To: <YGW27KFt9eQB9X2z@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9344cd4a-79c0-4314-6f49-08d8f51379c7
x-ms-traffictypediagnostic: BN6PR1101MB2145:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1101MB2145CCB977871AB42A82F36AC37B9@BN6PR1101MB2145.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bsDfV7YJc2Gw/eNdla+en6LxKVylTIbDy+UFi6lRroFxSo1nH8ChtqVPkRo/8YYupphmNcIRdsNxMqSVSDUEn+OZKsHT5lx7peKlojvv/lEtoDQpm2slwppJ2+p3osdW2zw3dcydoqCYcQrvlsCzNTZHN8SpgiyT6jRKtOASoZg2FFt9A2Q+Y1fYEJ3WJTNrvFKOdnkjJ8DEUBsAk5qMY7PBa+Xw1p+tQUSsxNHDlUWiHDnsGr8YPHEtELGrqEpryzq2YKuLhekCH9jwIKQ1VG7Nqauwf5M0Z9T+dMYNGDuU8CXHR67Gd5Gti+rQdhqYLHnBLAaFZl4p81MH1e2ZqHjkwKsWIpjndS8tgmCCySjsl+3kT/PtdZo11JYU7sKNemZBKEYI8WdZTwbm6VAOub+W11LUpXL8Ry4AKprcyptERI5qAIAWFORSTMp415lwagY4o+EiBTlCapJgxhvTUCY01HvEExKOopQAycSnhIxFjyhLz7ZzOEGBfobNOvz/yJBNV0HguokYPx/lwGKWGZJiUcysgG7Z/uoAba8QMdzZKNC/Pd/Itz7kX1F155xZK2YalLTGxuAWMtGcaYHI+qwikvaOp7xndNpDxw3VD5whYgMMpqqD6p2QDonvxlGLFqwtIpDCZkA1w/Ztm8LqQ6bQocRCqyrPYMsS+TdiNpc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4068.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(366004)(396003)(39860400002)(7416002)(5660300002)(316002)(71200400001)(38100700001)(478600001)(9686003)(4326008)(55016002)(86362001)(52536014)(66556008)(8676002)(7696005)(8936002)(6506007)(6916009)(4744005)(76116006)(186003)(66946007)(33656002)(66446008)(64756008)(66476007)(26005)(2906002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fBqjycj9eIoB16H7khX1xdPpJTy/m+tqPtipBuSpQOL2LPRX3ZckwM8hJ/7f?=
 =?us-ascii?Q?nBZHRO/8aRsVyrgibCfA9zMqOHExNwRLvCR89FzGUo+6srBOBf+wZMMwbV70?=
 =?us-ascii?Q?KfRmRW2Z7FT+HeRKviSdgUuVxadQcFeBwPnV9mDj4Bxj+feo4YiGFZcatn5K?=
 =?us-ascii?Q?zLZwl1ojN3DdYpYNI/AKYv9WvVBPAjgrgyPP9IG2G/lG+EDmJzQJQMzuGjU6?=
 =?us-ascii?Q?otDCQxVmPJopdpUqWkk8voeaBAp82FgBDZ4tGj+YBPNRf4akibshKtlQnLi3?=
 =?us-ascii?Q?Zgp3Gqw1JaBr+moHcuQwkI9SEAbVjm+mD6lmzM0nHnDvW5Rpsx5U4GAxeNFh?=
 =?us-ascii?Q?5wIcqeH+AzseRPKGY6Ck2zSW6Phe+0MvELT+An++uRzBZ7QbWVdPVcYwNjNp?=
 =?us-ascii?Q?/6n/Nnk2aUCQDiI6F6bpnPHexGiBp71IzP9Z9b3ZPg6jCpRPL5WOLsMRu2KR?=
 =?us-ascii?Q?bKgioIzVFe79dD8dSFAyCBjkd6j6d/T2/U2AckKpz/K8u4Yydt1cRVKgFp59?=
 =?us-ascii?Q?MGa07CWBf5gIyw6y3bqJjkcaU1MwLsvNd1uDvGHRqVFBMV+u0CTJ+LFo/TI4?=
 =?us-ascii?Q?21gtzahecM16GWw6Ap1pCASpt/NGT32tp0Iof1fmjLSuVfY3I1tSvDYyYThE?=
 =?us-ascii?Q?p20fwTdShZRNGakah9IN8k/nxyVDw9dPXBrdplRzwPso1dP61NJKun8GHMOu?=
 =?us-ascii?Q?UXHYfY9VdcMY5Ew8orG/oPS/g3U5AkcO0zEHjXMSGMQUXmJWC7xZK3/CXD7o?=
 =?us-ascii?Q?HP7OZgMGCUFutjZ9ovRwBic5C73N/BEmGcKq0PBvTu8czRZ4HUyUVmyujLQw?=
 =?us-ascii?Q?4RGVISazRwFJ5Mqmlc8A+4yYtfdw3Byw7tOG0fAaVq/J5elQtWz0CI7fXoiR?=
 =?us-ascii?Q?Bfx5owNRklLAV6ye4XpCHSHkF4din40WMRhdWccxoNddWAiOmI+sm0fkGzIR?=
 =?us-ascii?Q?xur+O/qnfNKQ+bX532O8XjL5LTSHGB6TnBJwEo5nNTg2BQ39p5+cCbiqQyVH?=
 =?us-ascii?Q?t/o3/rgnivgrd6g9awzFG+Ym8DwIpZjzJvG5VxyQf3z2qsonRjpZx0vW7a88?=
 =?us-ascii?Q?OltU1WPhJjxBrznNRyrw97wIansHEt4MRAdZF2wF7B/L62bl/mDCAgeP9tX4?=
 =?us-ascii?Q?Mvvku0aL5Tkz9WE3uzpwrov20WZ5asn+/W1ZBZMepzF/4EVjRof8SzqdbiyG?=
 =?us-ascii?Q?twPq8XCIQGtbeMNoHpAVxfXwCO9R5qOkPm80I3pfpt0Si5OfMVLbKoWzxlvf?=
 =?us-ascii?Q?GIxoJyWS3qsoV4g1rK2IuO4K+67NhjqOK7DmQPMZ88G12Bk9efWnezt0u2XM?=
 =?us-ascii?Q?JqkptOf1hSuPIshmkVcs2q0U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4068.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9344cd4a-79c0-4314-6f49-08d8f51379c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 13:38:46.7273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ICUTsduh1uGBXjpEwmdecOdmPOCY4pFD330t+0/Q6khAZSVG3sQah2TglLTsp8740XUwx7MfrE/d3UuD2lbDTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2145
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Thursday, April 1, 2021 8:05 PM
[...]
>=20
> Also wondering about:
>=20
> * Querying IOMMU nesting capabilities before binding page tables (which
>   page table formats are supported?). We were planning to have a VFIO cap=
,
>   but I'm guessing we need to go back to the sysfs solution?

I think it can also be with /dev/ioasid.

>=20
> * Invalidation, probably an ioasid_fd ioctl?

yeah, if we are doing bind/unbind_pagtable via ioasid_fd, then yes,
invalidation should go this way as well. This is why I worried it may
fail to meet the requirement from you and Eric.

> * Page faults, page response. From and to devices, and don't necessarily
>   have a PASID. But needed by vdpa as well, so that's also going through
>   /dev/ioasid?

page faults should still be per-device, but the fault event fd may be store=
d
in /dev/ioasid. page response would be in /dev/ioasid just like invalidatio=
n.

Regards,
Yi Liu

>=20
> Thanks,
> Jean
