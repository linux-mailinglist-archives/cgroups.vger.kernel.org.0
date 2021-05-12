Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5180437B2FF
	for <lists+cgroups@lfdr.de>; Wed, 12 May 2021 02:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhELA01 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 May 2021 20:26:27 -0400
Received: from mail-dm6nam11on2077.outbound.protection.outlook.com ([40.107.223.77]:14784
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229637AbhELA00 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 11 May 2021 20:26:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1Fifjn28CdVRDKRT236KYsvztqqRHmcIPL1QsoLEXVuY9Z40h+6XISC23x4cF0GhlA1WR79ZRHSnWbXJbzZO3wpxwSlSmRHTyckKtxpCvL7H1Tbflt3ILAJp06klaWlXR/6PegAcCIlcfFN9W55bEVkWAL4p9MIS8Y7LSRhg1I2QopVJ1TFl7RrbMptXPVjefQ+bHtAYzowygQ2in9tx1B/d9R+pO5WS3frZS2m6F/Z9w/bLH+v4/t5f3HgzFfBVncYimEvOD/789lrSFB9NQVsgW5g81xa+ch1DhY5tQwKusdlcM00EOEcxlLjXPd3keKVyps81klM72a4q3etiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMSZFvU8qZDP0H5FQuurn4Yqnfl6o3plyNnSza9qP28=;
 b=ZTnpegHNwFvONhhFHtF700teFQbntmyljmBeJmnLlunvz5+0shfkrsD7+SksXO+pYsqknQvPnC2mrMgNll6NC+pciEhQfC35EcEBfV7EQ+2k6AQmkLkxwZOIMjzlctGOXl0+LZJotVzSeHesISl238qM5f30CL3Z1L4YSS6dMpDiUvDcY0i8oeQyJykWRsnsMUqdzgcCYdwvXT3OjeMOx5DuQe1hTxBzpwGiB59o2fGTrjHjxNb7t8OByUrwLdV1VUV/VfwkOsrgk0yE8vKt7KcRKb3XOMlph+xHej8Jhoqp9aDmOOsHfd2FxWdKSXo6kXF4kvbGo5yMu2C6sxvOBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMSZFvU8qZDP0H5FQuurn4Yqnfl6o3plyNnSza9qP28=;
 b=QYUQJVDQjOgzjQE97iWTIyLjP9gV7DrO3PzXBe6erXgf70P12NN+bgwkMqSOnBQx15je1R9fkBxqqk1YfC6Dv2lP3rrbvNQCGKlJfd+H/AYcGerv30ne3IQFQPnZyjQ87clQNKfV/IfLdItbpamhPJ9vaNcPfUTKV1jH+mUgzN6ferboYDepH0u+7fXs1StemW7jJMP10j175EGFIBL93/GesZNSQbK+ioMYgUsodx4Jdc89LU2O/MHN9raS7Rb5g1fbPUdHGdI/vbY4jO20afxJdafbDnzR/RbmtlC+Vnle+BGc9NT5k6TlZ7YYr1dPr6mUouqXFLZfaNp68pK8+Q==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3307.namprd12.prod.outlook.com (2603:10b6:5:15d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.31; Wed, 12 May
 2021 00:25:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 00:25:17 +0000
Date:   Tue, 11 May 2021 21:25:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Li Zefan <lizefan@huawei.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "Wu, Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210512002515.GR1002214@nvidia.com>
References: <YJOZhPGheTSlHtQc@myrica>
 <20210506122730.GQ1370958@nvidia.com>
 <20210506163240.GA9058@otc-nc-03>
 <MWHPR11MB188698FBEE62AF1313E0F7AC8C569@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210510123729.GA1002214@nvidia.com>
 <MWHPR11MB1886E22D03B14EE0D5725CE08C539@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210511143840.GL1002214@nvidia.com>
 <MWHPR11MB188601321993CA43E3058C4D8C539@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210511233950.GQ1002214@nvidia.com>
 <MWHPR11MB188623FB741481D489D259798C529@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB188623FB741481D489D259798C529@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR15CA0021.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR15CA0021.namprd15.prod.outlook.com (2603:10b6:208:1b4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 12 May 2021 00:25:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lgcgd-005cwb-OM; Tue, 11 May 2021 21:25:15 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81036c3f-82d9-4821-d364-08d914dc6aec
X-MS-TrafficTypeDiagnostic: DM6PR12MB3307:
X-Microsoft-Antispam-PRVS: <DM6PR12MB33075F54516E4563B1C8CEC6C2529@DM6PR12MB3307.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PXB7JPxwz1xDzP56vHC3udzuylXpwlntCAr9Z1XzKjBEhnSb6Vm6DJEZngfBJ7gLih9FdiRZkpiyMQ6aQWY45fvM26tT57j/PS0g4yHsQdMqyGeRhQzdDhj9KoXIDQyI3hK3connLRMWbCnDnmim5xuPqc/VPpsi7h509AL0WAKfvlSVa+TKz+SdXEHs0ggDEu7t6p0Xgn4AZ41ks1KfI3LWxVRtSNLD39zH8Uvtc9MmcyOev4MOKhsdXUObwQKFKQgn2GRQcptpqZhjYOsLUXWqWngiokqH77+YeRw5R6WLcaPTuFEB7n3QJ+L7isYj6IiCUMoEh0HRmiSQT1OCKY1T5vmVngSYtF9kF2TTgSEsbyVSaOMNs9Lts6pmlVn/cXTC1x9N58ZMWOBdO8GwEmjUg7MLI5y0FhthqAGNn+XHn9hSTjFHVvpu4KCkvEF/VC5FjTDcjmeXme+dhz1zC8bzI7/Wvz1+Fyh+Y0/sNagvKNVxH31dMdsxZU1apuJIXjwA+4JWBc7ViuTDfZSi4rjOyMlD/sXXlQg8tvt4zcMNd661SFJNxmftcuumEdxcoHT4YuoPSeaAdvJhR0B+itmVoVAXVN7JVyHdYq4Keko=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(83380400001)(66946007)(8936002)(26005)(2906002)(36756003)(9746002)(9786002)(6916009)(86362001)(66476007)(54906003)(66556008)(7416002)(186003)(4326008)(478600001)(316002)(33656002)(426003)(8676002)(2616005)(1076003)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6u1kxPWlnU/mPUOe2hqbHTxByWYod4lmrqYKVd5t21Mk8O/Tja48bjJe/Wvw?=
 =?us-ascii?Q?C00MCKBjIra96Hsm9fQdSPh7qTcPLtYhvsFmmpNfSsnmvGUCrTTWkmBqt0ZC?=
 =?us-ascii?Q?HjNocVbhKU2emSCXONX8QlNqSPh13iNhEzLXKwoakRdDdhQtOL0/tPYWE3Lh?=
 =?us-ascii?Q?qRbd5LC+6mURsUwKQpzffgRvjXvx9rv0dycQJcMzXQ9emS+R/DCSzHc2+E5t?=
 =?us-ascii?Q?luwNBACfJ6Vzuirhoi8zZCw8ItjB9KG9xS3tYswd6J8+BOfQ8jSUHd3ABkV9?=
 =?us-ascii?Q?vq5VM8nP1jEwWplrQkuXzFphWnIegQdf68J/LmT7vILle+NLxVxVm8ssQRsJ?=
 =?us-ascii?Q?zVs0R6XyAojXTmW5IKr30zVLdEjpz5n6LYkSPlk9ZUyVNcPNALw9Elnr5EYj?=
 =?us-ascii?Q?Uk3YDOvPN+NcOMCWKKmq4vMAr3Jy+Y1tCX0z+ujtTZTfk/qkaskE8jm0W37q?=
 =?us-ascii?Q?QHJ4yuNjbaxTYMN0vYS8JeiBrDwqwZdVBSYlwUWNtfExbgY6h69yhAb6u/eT?=
 =?us-ascii?Q?LDV0ukbBXGv3/iubdYjdvF+/ykeC8aUz+Dj3ub2VDaIf2fiShRHnpfBUKThI?=
 =?us-ascii?Q?E33yQQoDwjx25YCbYuWCL72o9ho60wsnJc1XiZ2tHWCYK/6m60dNSFjHkjMt?=
 =?us-ascii?Q?8T5MyaPPIG8onPu6J7GlHlk7zwVx/x6UJjKV5eL4CP5Vs7kRklqMFNmz0Yob?=
 =?us-ascii?Q?RN5I/ew3swzo5Wo9omhBC4JJTg1qc2GhqrVIAjg5bnBuhRnWjYuaDWvDWEov?=
 =?us-ascii?Q?OJ2gUNd1k+jG5mp7N4fkWXseP5QGGcLDOB7E6hn8zUR0s4pe/VORvn4+Og68?=
 =?us-ascii?Q?TXpS5L967ssa0litQi7IeTkLQI4bmTDL0j5BHzYpvEovTdQ4Y/7xWCWRqSRn?=
 =?us-ascii?Q?HtxeefSgf8980woqofsPlcI5G7SXokwLPSosQn5EDY8t5wdl/bzCZq1rl+C1?=
 =?us-ascii?Q?9pE832oMm6rULLDyYC76bDTZPjYoEEtPHo09fJf4nWWEr1pE18muW+ARt68v?=
 =?us-ascii?Q?0bHvAo8ULspNM20AFiYysPcK+irSiTKnFJU7Nez+z+PTLeoLuDOwzKS0ubCG?=
 =?us-ascii?Q?YXHGGsDZKFNF5IbUN9IG7PYulgIvUgcrE2eqQlnwIKo2qwP9v4q98FQwu9Gp?=
 =?us-ascii?Q?LK3GecH0NvyiGkexoGFnm+2IFGV0e/kjrOfSWXuZwlNe/GdBCSHC0K9tHcLY?=
 =?us-ascii?Q?qRwOtXKUDJc+jJUHUe/PvTUbXp3/RZ6Zi0FxWlb3GlN5J0PTRjyRe+qHsgSa?=
 =?us-ascii?Q?QDF9gMHv2KKNBO8noEq+ig0vxSNw3b5VfMLE7NnKrugEJyPnPQ6NYmZbFvBq?=
 =?us-ascii?Q?/cEEEooQqLgcL1eNQasUH9ik?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81036c3f-82d9-4821-d364-08d914dc6aec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 00:25:17.3709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D5O30OufMEBnUg3pNiMm3Rs4XxlGa2+3+jGOh4QLIW9zCcPK+M0lhNUlsK7U1Tsl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3307
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 12, 2021 at 12:21:24AM +0000, Tian, Kevin wrote:

> > Basically each RID knows based on its kernel drivers if it is a local
> > or global RID and the ioasid knob can further fine tune this for any
> > other specialty cases.
> 
> It's fine if you insist on this way. Then we leave it to userspace to
> ensure same split range is used across devices when vIOMMU is
> concerned. 

I'm still confused why there is a split range needed.

> Please note such range split has to be enforced through
> vIOMMU which (e.g. on VT-d) includes a register to report available
> PASID space size (applying to all devices behind this vIOMMU) to 
> the guest. The kernel just follows per-RID split info. If anything broken,
> the userspace just shoots its own foot.

Is it because this specific vIOMMU protocol is limiting things?

> > > > It does need some user visible difference because SIOV/mdev is not
> > > > migratable. Only the kernel can select a PASID, userspace (and hence
> > > > the guest) shouldn't have the option to force a specific PASID as the
> > > > PASID space is shared across the entire RID to all VMs using the mdev.
> > >
> > > not migratable only when you choose exposing host-allocated PASID
> > > into guest. However in the entire this proposal we actually virtualize
> > > PASIDs, letting the guest manage its own PASID space in all
> > > scenarios
> > 
> > PASID cannot be virtualized without also using ENQCMD.
> > 
> > A mdev that is using PASID without ENQCMD is non-migratable and this
> > needs to be make visiable in the uAPI.
> 
> No. without ENQCMD the PASID must be programmed to a mdev MMIO
> register. This operation is mediated then mdev driver can translate the
> PASID from virtual to real.

That is probably unworkable with real devices, but if you do this you
need to explicitly expose the vPASID to the mdev API somehow, and still
the device needs to declare if it supports this, and devices that
don't should still work in a non-migratable mode.

Jason
