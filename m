Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51159366C90
	for <lists+cgroups@lfdr.de>; Wed, 21 Apr 2021 15:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241548AbhDUNUA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Apr 2021 09:20:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:10075 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242388AbhDUNTY (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 21 Apr 2021 09:19:24 -0400
IronPort-SDR: kLSJgliNLTzQI7GwtyBQt7anvLb2PFnu3s1y1/OOQt85Amxb/dPUAj26nrK8lHfHQRs0aS6G24
 C30WmpseHflQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="195809014"
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="195809014"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 06:18:10 -0700
IronPort-SDR: Lf6yWT/H8h50QOveOXQVM6VtS+Nq3fk1GV0TN2dfbMmKdER1o1aCJgpa/GN1xZeyXZRlngFfYh
 8oqSEtCc00mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="455338117"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 21 Apr 2021 06:18:10 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 21 Apr 2021 06:18:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 21 Apr 2021 06:18:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 21 Apr 2021 06:18:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLHkVNDmVF8zbqmXr4nQKRWkjKtm3Sa08yNcXM82GAm/r67TB0VVGy5Pu/oRCN9lqLfw4nfyg5Pn3Z2s3o1/KyCNcLwMKNZWMLd0AhJPse2lo+Jkh7Y8hlZwEYaK8LUeOLE9rZkPOoJLA1O7McjdNmUf1739RHLxz5e20D28liVZxe8lloGSH89LDBsgAJFM+PJ9hkVzdUmi2G6a9bwLtV//tuzmI7preOyhpe0FzdmF2Mlt8D7jAUSLVoxBcqCFrqvt79QCwKbGTvkGN/UNi4tfD9MbMkZc+X7CMIenJFDCAdEQf6Fm1tlsPaQdAtDeAqkwuwgLU75btaP1ltGVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iCgFGwbRMoxJ1yBtYt64IDT68n8YGGBP8kxtDkAkyM=;
 b=m7ky3DGZdsGOlKdS2ofluMdB2Jho/lO8Vz3+aJnzKrdwbvXU+ifDQOTqDwF1RNf57HLGfTouY3zvabUcg3KBNm59afY0g5N02uvSdIP8Yh3CqjjG84qh+cMHuEcX4TArR0vAnJh+KcwAr7Q1eThOf4jsdAt55fzNkTxdgTsjr9R38eMv/rHqHXMNXIowHkKnFn3IoA9LL7N7CvYka4Sb3pZTrD6G3xiVPSaayJG3XN0oOK154siN5iCPRtj/7ml7SAmOnBXllZqeCm6T15sjTLZsnCKY8yMJbDWhCmDTuUIS2ZGc5FFr4XOYditzkVT3XwHY/NvPgS2nk6ZKeEWOyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iCgFGwbRMoxJ1yBtYt64IDT68n8YGGBP8kxtDkAkyM=;
 b=IY1tbjhUF9k6lxYVF1W3LVaaXm/KiaY2qzRgCoUwm3fvL1q+DA7fkqSmDVdMknLQMHnIyCUtB5WAAg720Qj7FqkYAnqHb9gIjge5DogpOHWEEVwZdTqW5QXTjA7hBppzG+NMMbCneNi5O0bUrpzDKhidO6txdb4kUAbTawOZHRc=
Received: from BN6PR11MB4068.namprd11.prod.outlook.com (2603:10b6:405:7c::31)
 by BN6PR11MB1619.namprd11.prod.outlook.com (2603:10b6:405:10::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 21 Apr
 2021 13:18:08 +0000
Received: from BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d]) by BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d%3]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 13:18:08 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Auger Eric <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZuc1/oaTFwUU0WheDxUmLBHiqqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAmFuAgADGxQCAAR7PEIAAZiYAgAECgOCAACyd0IAAWUMAgAASa2CAAAjaAIAAAHQwgAAm8oCAFdCAgIAAppUAgADsNgCAACqygIAHqReA
Date:   Wed, 21 Apr 2021 13:18:07 +0000
Message-ID: <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
References: <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
        <20210331124038.GE1463678@nvidia.com>
        <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
        <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
        <YGW27KFt9eQB9X2z@myrica>
        <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
        <20210401134236.GF1463678@nvidia.com>
        <BN6PR11MB4068C4DE7AF43D44DE70F4C1C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
        <20210401160337.GJ1463678@nvidia.com>
        <4bea6eb9-08ad-4b6b-1e0f-c97ece58a078@redhat.com>
        <20210415230732.GG1370958@nvidia.com>   <20210416061258.325e762e@jacob-builder>
 <20210416094547.1774e1a3@redhat.com>
In-Reply-To: <20210416094547.1774e1a3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 600a13fc-732c-4689-f235-08d904c7e7ae
x-ms-traffictypediagnostic: BN6PR11MB1619:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB16196D4C1606CCC6E582BD87C3479@BN6PR11MB1619.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +6y6+8WA9p8SUah+oaw6NAN3oQBYgb37DNvplgGBdGVcFP5p75EGR+X+Kghcxyog5vdl6XessZ9YLIetN2+saXARe0yyDHD5XwKgQH/Z/EAODIkCtr/XLVaQ9flYMAKnYsB8Flkqqx9U+TTGBRBv1lVk4DxGVWjJPWvBWV2uABgJpyReOhi8KAqCDRG26YzluAE7jwa3HTkTy94R6AaOgDR3CKNwrF97geQwAjpWG3raS+EVENr2CsunMBFhNX3UpC3mxACRE64grPBINX5TBaWPGcHLKvz6M1bGsD4K0YuS3aCC0F2kEzwccF40kryU3w6OYbtdiqqtHSUw/TTTwl1UDYzyFM9Mq0LUP0PaL2ShexiL5x3rq0ndRE/sY0o54+ZjkiAkljUnrkaf500q0CfIbeSEG9IbLBUQF5wV9PSJQGFQnT+XcPqau2taDYlqKB46wN33WpLGy409818la9uKiOZiaQfgST2J+6BA6sUq0chpXD/hcjfLMtNjWLJkxuR2IRfTQO65tDQsghtLqicwXlN2Y3aPbH+xgGJrpectPFBInfGEg0CbuwjTnwk8/8JsTQ5KUB4yw4JZn2V3o2udO5ng4X/wi58pnXxTo2E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4068.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(39860400002)(376002)(136003)(8676002)(7416002)(8936002)(66476007)(66556008)(66446008)(64756008)(122000001)(478600001)(2906002)(38100700002)(7696005)(26005)(54906003)(186003)(110136005)(66946007)(76116006)(71200400001)(52536014)(9686003)(55016002)(33656002)(316002)(5660300002)(4326008)(6506007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?APkYj4wmrQXjRPZUoH0qQ0kKWWDnQoOcnWNdeErqChbhOrixdiyjuOxWoDHz?=
 =?us-ascii?Q?0AghubWYT1LDg1b7RonAjNd0iatdwBgyRS/jS4A/7IQ137HoeXcBLcjB6ymb?=
 =?us-ascii?Q?jzKXr1r70rMVSZBtdap2GdRwUgclXB6BuIbseORvrEu9KBMiuLys1Om8+nTY?=
 =?us-ascii?Q?zfw67Atdln6qHRB2SS3+rqzBD6Ynw8sIa/eEyZPH6wzFhIdH+8MvQLXCUQR0?=
 =?us-ascii?Q?hvEWFqd0gHWAC31BuyaRBTxHea7pf1/4TylsEG/Fg9eCAgcz7YL3S5mUEeWw?=
 =?us-ascii?Q?5+fY8AJbGRyhmePjgzb8QLD+tGjP5t7xaIlJ1pD13zNNMiA7ED7GQHDyEbhx?=
 =?us-ascii?Q?BEBo9cMhSPXlHWNEBQijTn5DXDGVKMRGKl6hw/kcoqYEEczpHdXm4EVbER5y?=
 =?us-ascii?Q?9Lyd0UG0tVTbiZy5e5VnP4K2zo1xBcCI/wTRIFZ+pS32ZvtxA+5QtygUoBjm?=
 =?us-ascii?Q?g/wua4zUrP64CZMGi14LVWn5Xad8eWeex8Qu2AOTi++1DnWkguD0QKYMhbus?=
 =?us-ascii?Q?+pdx4agpcT9IU19AMdePu1tf/uDIaNMavoczdrx1Nvm4HZ8bmScL4WtUAxGr?=
 =?us-ascii?Q?U5HCSkX79xwabrrd9ji9CQxG55yLcNcrb76EVvb8M95+ZxgWJJ8nGf3tVe2u?=
 =?us-ascii?Q?vu3BCzFRtu5rcHNjdDrjKBWcK9T/JOwK29XYoRBecP5oNjqMqig8HCnHWQxw?=
 =?us-ascii?Q?1Q6QwZImyKraabkRl1i5dl3Kry2ev73P7LoawggFbXhDvO4gfeZW0G1feQxo?=
 =?us-ascii?Q?19ERKDl4Q8SOP7LiWPqYno87njY5Db842P0CoDr/wlJArZ/LjZHmgu2OXqT1?=
 =?us-ascii?Q?WR/dlYyz/IW8S8WBiPMCV6J2yexZcG5JFjbul47Fd2xKEeSBhzFdacG7J9P8?=
 =?us-ascii?Q?RxvIgKMY61YYe2cYeTBL44lls90WBqUxoqKRyrekiNgq5ES01WGqbBi84xpG?=
 =?us-ascii?Q?IpJ6SZIucQ9cXGqPIXRANG5UB1kjdXi7UrbsMXOhQpdrtljeWm/8jndnmall?=
 =?us-ascii?Q?SjBDNL3ziwGxWI6M/Pz6hsU4SMdHsRKMEVkwMHxeh3RPw5h3KSWQ3ZfZPeOb?=
 =?us-ascii?Q?aEoHCbbKc4MCaXouOHtqwGhHkUlvvO3q8R2XIyZ8+d816SZspnyD3xphrxwM?=
 =?us-ascii?Q?uzLTzsNQ1aVMbxKCw45Df2EdrLMJToGGw7JyURPR22px02Qj3RvUcTkrxGSV?=
 =?us-ascii?Q?UupoxTHLbDYEE72PoF2cJzKjrmnnH061BN/vAgbgIKS/JT4UphmWnK2LSJtN?=
 =?us-ascii?Q?9JRj7iwzqWwypVxQlUaZim9dHTBi7jI1Ube5pAznS2HzHclRVx1rq/+Q+sK1?=
 =?us-ascii?Q?nnme0iYm04GC9IWpH6CvuqtX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4068.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600a13fc-732c-4689-f235-08d904c7e7ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 13:18:08.0001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CmzCTAR6JoqPvgQrLsYf+hH5Z4bWVL5YcNevJ9U12s/OoL9juETPL0ftUNng52hQmdDY5TuYPnYQf5gHyRjdhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1619
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Alex,

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Friday, April 16, 2021 11:46 PM
[...]
> > This is not a tactic or excuse for not working on the new /dev/ioasid
> > interface. In fact, I believe we can benefit from the lessons learned
> > while completing the existing. This will give confidence to the new
> > interface. Thoughts?
>=20
> I understand a big part of Jason's argument is that we shouldn't be in
> the habit of creating duplicate interfaces, we should create one, well
> designed interfaces to share among multiple subsystems.  As new users
> have emerged, our solution needs to change to a common one rather than
> a VFIO specific one.  The IOMMU uAPI provides an abstraction, but at
> the wrong level, requiring userspace interfaces for each subsystem.
>=20
> Luckily the IOMMU uAPI is not really exposed as an actual uAPI, but
> that changes if we proceed to enable the interfaces to tunnel it
> through VFIO.
>=20
> The logical answer would therefore be that we don't make that
> commitment to the IOMMU uAPI if we believe now that it's fundamentally
> flawed.
>=20
> Ideally this new /dev/ioasid interface, and making use of it as a VFIO
> IOMMU backend, should replace type1.=20

yeah, just a double check, I think this also requires a new set of uAPIs
(e.g. new MAP/UNMAP), which means the current VFIO IOMMU type1 related ioct=
ls
would be deprecated in future. right?

> Type1 will live on until that
> interface gets to parity, at which point we may deprecate type1, but it
> wouldn't make sense to continue to expand type1 in the same direction
> as we intend /dev/ioasid to take over in the meantime, especially if it
> means maintaining an otherwise dead uAPI.  Thanks,

understood.

Regards,
Yi Liu

