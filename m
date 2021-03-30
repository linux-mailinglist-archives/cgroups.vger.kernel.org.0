Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BE134E977
	for <lists+cgroups@lfdr.de>; Tue, 30 Mar 2021 15:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhC3Nnf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Mar 2021 09:43:35 -0400
Received: from mail-bn7nam10on2071.outbound.protection.outlook.com ([40.107.92.71]:54490
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229633AbhC3NnR (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 30 Mar 2021 09:43:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4cNzaqpBaWZUdmC340g+xoNbqZjZ2SAxgiZ9OiHyEIhaaNUTEOmsmzdMSxtZJ4CVOmn7HhC9W4iKArEG8W/e/9xdPzaEKowseqGRriLvMSM2qlxigdn2RZgTYNRuCCH0utsgwN2TICEeFHa546gXLk1s/N+HlctPwEP3YQ32X4l2TLIrYoyP/5lNzFN2DpobehhEp2BOaWtUHytIKFJSpvXj0tS+7XjF/hZPIvkQ2tfyicp/OWI+b65GCOPpKdecDQWNtHp2uaVfDogLvLZCUrKnpB3IEmV7t6NgZTNjTaNiZqJrT8yPCkjIwyYy1IzgeKdLl/3iYDvSVyYsvcuvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQZ3yU6L6mhMe9nejkBp/Bqv223Gaj1HrOxUg5nE3pc=;
 b=SANBrKgycnMFUMOqzOkCC2eVJPITvWJRuIJCPQQbj/+Dsgw7MPdq7cW7ISMt3u/voClfZJYUgsQuqe3FfLvIlZJTlAXQHoTLkRUDyqMsf8xftw9M4mJx2YQfpWJEQqA6dUEHlZHp1P4PUvFhQifNXgMDzRegPVmuwZmjxQLLedoJlYksGm1TwEYRaHZ0FGosv1rIyJ99XkynWL357unul2tU+JG912xS+NY1GoEVuCO6Crhyfak2NpjDwQ+5ShaPrMt2eMiWnyVNoZ5lVEJWn6GMmqhZJdsmNYF6M9+KmqnNhXXaUv0VNtFk5EbQoXjjSrjI/Vmr6Y+HibiCa8SZYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQZ3yU6L6mhMe9nejkBp/Bqv223Gaj1HrOxUg5nE3pc=;
 b=IcntDo6o8TCXtJfNw+AwdI81ftfw/18UPjCtmdziKabU/d6KFiLfwo0tz2+NgTRvTjkeiU77AxyZfQjyPc+TOz2h/kvnavnw2AJBMw13n1kA1NP8fB2sWo4YgjwHwru1RbGVgmI3Ti/yfCETi12xwY+/hjxVdxYIwPK6BsbtMIP2Y+q3dv54zpZFMbAzeqkGc/rBvxnSAkFhgNzDIXMt2otKyID5FeoHHVVDSzr/younDEMCEzXHxYMqDhmWbgYDGznTzYIA37xq8EPD6AMxtrqw2kr6e9H2P05ge3wl5YiyVIJB3eJhCCtFPGeP1iAaAy9rnjGWcZiv3D8qlmssuA==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4796.namprd12.prod.outlook.com (2603:10b6:5:16a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.31; Tue, 30 Mar
 2021 13:43:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 13:43:15 +0000
Date:   Tue, 30 Mar 2021 10:43:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210330134313.GP2356281@nvidia.com>
References: <20210318172234.3e8c34f7@jacob-builder>
 <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com>
 <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <20210329155526.2ad791a9@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329155526.2ad791a9@jacob-builder>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0120.namprd13.prod.outlook.com (2603:10b6:208:2b9::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.18 via Frontend Transport; Tue, 30 Mar 2021 13:43:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lREeH-005tc9-Hm; Tue, 30 Mar 2021 10:43:13 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4864f82a-3ba8-426d-43d1-08d8f381c49b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4796:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4796250C8570EC5ED9CB6EF2C27D9@DM6PR12MB4796.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PWNLKAtcdJLBECr+lGndZg8lCJhDmgMW8U0fv271orOKl+HIRkRoL9NwXxG0oI/RuD4dKm0UkNyHYryzxZyw1fIqKtxgLn3guY55SGisR1VKPSLEQtct0MusQ98DC9Ce7euH+vx8sRYXZKK8gO+eLDNlC/mndluukN7Ime9aTEgdJEAgCa6+uNGIDV9ZWzPG7l9oQ2xP7XExf46uM7a668DlT+nq3AX43qxL12z4rMDpCL2iEfxjdzDpfNeyGISz6FmgZ7OHSfyK1qGAg4vURvzsKvua2oCVtx0JaHts18T4ztsGy40i9j464GBQARb3JiYHtoDL+zTFFmv4IiziX5d0tAkg+uYG7uoo7CuOYxdCTTF+REuVoQ4Y+dNrpU4ui7XUGnvs7deTH8JhBkwK4NYU1btSttbP8m5upEQY4GpXqsJvJtEHNeUeyo3wiIjqgxnM0E9EBeaDEjxSNgwWVX5kz5ZXMxH6mLPKPiZhC7OEs/6FN25fnPd3gvup8Q5WceE4m62ZWP188AGN4/ZPNrZHZFXVQvqJQMQ+CU2ddqHuqMypZqZvbWec/5XAytEDohK/7HuklIf5s4cHSlse6JYIbwhNUbwcZIgZL+BmnaRtUiCP6DtoPBeV2sPqNb/kXI8nDC7HKwD2rEGPRvu1bRFJnNOos5+cERrWEFTtnzWEAdNGvoZODFZl2siuNEDVTWVVFfOOyl1QgtORmo3I8sjsm4ZBwJbiR29uYhQy1VuiLlpZ2ywM/puJ6yqiATwW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(66556008)(1076003)(186003)(2906002)(966005)(5660300002)(8936002)(54906003)(426003)(86362001)(38100700001)(7416002)(2616005)(66946007)(9786002)(9746002)(316002)(26005)(8676002)(66476007)(6916009)(33656002)(36756003)(478600001)(83380400001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mNAFufbXLUkpeXe5uwY+DHhnOQZhJKtZhJ0U0F82KNyX+luikupzOqTUo4TF?=
 =?us-ascii?Q?qrxo9dpUaoey3Fk6oXDKu47p6Ey3Ug6f8dnayI+pk4JtjhauZL575gF1P7qp?=
 =?us-ascii?Q?n+d9WNe2UjKXW2OsYGA6/3Jk9949H5kqXjxyLbSbHPfLQRBbdQw7DoDrWqS0?=
 =?us-ascii?Q?ivJcwGE/Z79JivwAFy27CEOJ+tQZ5KYqqFTs+nf5Lx6paGsDDEcrEcoeYV5n?=
 =?us-ascii?Q?vDVR1aNAMfKBa+OOqrhdY655l4UXn5I+Rr9ba5sX/zMsiYmYg4hPVVGQnKgn?=
 =?us-ascii?Q?yohbUGOvVPU5ESxcS3BFuuPrIOroiv70KDFsXdYyQJngCwmcrTdsTKNQ/Gsi?=
 =?us-ascii?Q?beHVqHdyLH8RjCQXAjPLiNqj3qPJLr/fQS25aFcrro3g1d/1RMlSLWyvouLp?=
 =?us-ascii?Q?zXJhWqOs7MkX0XU63R3x0xuuYhkillSwoZGoCGdAJuo9reXw1hiec3bxlNsm?=
 =?us-ascii?Q?IQdoilnXc5zlIOhFwkNeDhsArBNWYR2NULFco+iQhHCQH+Z2Us5vIFCfzYEs?=
 =?us-ascii?Q?wdGkmuhpLafxssvgE484940AZNLmH5n6w/ZhO2dkmfaujPUIQ9od7BtPdA9z?=
 =?us-ascii?Q?dEtNgM/sWitIxromzdOtBDocj2n9JyzLI0R3e0jR3hk4gou42d0WbhPdDuKV?=
 =?us-ascii?Q?RwIeqLlrJfi1hK6nk65yUitTFvmdE97QVCs3mCz6PDw2GL/pexsG7LAv9qRq?=
 =?us-ascii?Q?zJXHcEbQ9ab/LH2xpq9pllmWF16pMwsiwFwLdmXqpVtMrlwyUJI3cxyVhvWS?=
 =?us-ascii?Q?x/r5AQBrVBSBdtTU0e7wpLzxbN70DBS+K/XaI7MJS65fOEcOHENucVozCzwz?=
 =?us-ascii?Q?0zpy3zdsuGaHqCwuqv78pR56snoaDyH3MiEz+Keh9oX4MpWwCKsuQ4o+2fmA?=
 =?us-ascii?Q?CGvudEOeaUGsTH0wfkmYeMSly7F4etvA1F0+2h7unEl9HJ6WSlJ09elrpgpf?=
 =?us-ascii?Q?zPH13Q77xFlXqwmMXlI2HB863rNwiil/idyViQulsz95qRuZZrVLUhKyZuuG?=
 =?us-ascii?Q?eW2AsI57MJyYWEVpSPPyzeUKf8ygvA638XKuiakW8P5Dn1UC3yW76tcwl09p?=
 =?us-ascii?Q?nEeMtc6FaIhDKCSHJQcgGaJPZMN7eQ9zoj5LVZvZbQimAr7iCC7W6hAVcAfc?=
 =?us-ascii?Q?xWhGjmLDuEBd3KqpbKrc0YRPsFBFzZauWHwqZ9vBEvSP7WUoTfg70/SLqTXN?=
 =?us-ascii?Q?Mha4albjLy3lr9pSNg5QeIpXtxVR9mm4C8dOOsdb6aCkeC9pogVZ7qRx4MPo?=
 =?us-ascii?Q?7Ypc5J2X8iXM6tVREFSAdwEVxwWm3T3n7n9CAv6oxFd+78qUaF9uCIrJwjlf?=
 =?us-ascii?Q?tciimquBFmAQ0RtJmZf46IfFO0IycvJ9bwmZ2PBL3V0HsA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4864f82a-3ba8-426d-43d1-08d8f381c49b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 13:43:15.3422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AsOmUCHsyB4qWeujXgP2vwcaY5WXu7s+8GsftOQuEGxC6UoeAFAq7WOHCuDXLWu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4796
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 29, 2021 at 03:55:26PM -0700, Jacob Pan wrote:

> In one of the earlier discussions, I was made aware of some use cases (by
> AMD, iirc) where PASID can be used w/o IOMMU. That is why I tried to keep
> ioasid a separate subsystem. Other than that, I don't see an issue
> combining the two.

That sounds like nonsense. A freshly created ioasid should have *NO
DMA*. Every access to it should result in a PCI error until a mapping
for the address space is defined. It is called IO *address space* for
a reason.

So, what exactly do you do with a PASID without an IOMMU? You
certainly can't expose it through this interface because you can't
establish the first requirement of *NO DMA*.

While there may be an interesting use case, it looks to be kernel-only
and not relavent here.

> it matters when it comes to which interface to choose. Use /dev/ioasid to
> allocate if PASID value cannot be hidden. Use some other interface for bind
> current and allocate if a PASID is not visible to the user.

I just view it as a shortcut, it has less to do with "hidden" and more
to do if the shortcut is a valuable savings. If you swap four ioctls
with one ioctl I'd say that is not enough of a win <shrug>
 
> Yes, I think we are on the same page. For example, today's uacce or idxd
> driver creates a hidden PASID when user does open(), where a new WQ is
> provisioned and bound to current mm. This is the case where /dev/ioasid is
> not needed.

So that is a probelm for uacce, they shouldn't have created PASIDs at
open() time, there is no option to customize what is happening there.

> Sorry, I am not following. In the doc, I have an example to show the
> ioasid_set to VM/mm mapping. We use mm as the ioasid_set token to identify
> who the owner of an IOASID is. i.e. who allocated the IOASID. Non-owner
> cannot perform bind page table or free operations.

As I said to Kevin this seems very over complicated.

Access to the /dev/ioasid FD is the only authorization the kernel
needs.

> Yes, each PF/VF has its own PASID table. The device can do whatever
> it wants as long as the PASID is present in the table. Programming of the
> pIOMMU PASID table entry, however, is controlled by the host.
> 
> IMHO, there are two levels of security here:
> 1. A PASID can only be used by a secure context
> 2. A device can only use allowed PASIDs (PASID namespace is system-wide but
> PASID table storage is per PF/VF)
> 
> IOASID set is designed for #1.

#1 sounds like the mdev case, and as I said to Kevin each and every
mdev needs its own allow'd PASID list. There is no need for an ioasid
set to implement that.

> > If a device is sharing a single PCI function with different security
> > contexts (eg vfio mdev) then the device itself is responsible to
> > ensure that only the secure interface can program a PASID and a less
> > secure context can never self-enroll. 
> 
> If two mdevs from the same PF dev are assigned to two VMs, the PASID
> table will be shared. IOASID set ensures one VM cannot program another VM's
> PASIDs. I assume 'secure context' is per VM when it comes to host PASID.

No, the mdev device driver must enforce this directly. It is the one
that programms the physical shared HW, it is the one that needs a list
of PASID's it is allowed to program *for each mdev*

ioasid_set doesn't seem to help at all, certainly not as a concept
tied to /dev/ioasid.

> No. the mdev driver consults with IOASID core When the guest programs a
> guest PASID on to he mdev. VDCM driver does a lookup:
> host_pasid = ioasid_find_by_spid(ioasid_set, guest_pasid);

This is the wrong layering. Tell the mdev device directly what it is
allowed to do. Do not pollute the ioasid core with security stuff.

> > I'd say you shoul have a single /dev/ioasid per VM and KVM should
> > attach to that - it should get all the global events/etc that are not
> > device specific.
> > 
> You mean a single /dev/ioasid FD per VM and KVM? I think that is what we
> are doing in this set. A VM process can only open /dev/ioasid once, then
> use the FD for allocation and pass the PASID for bind page table etc.

Yes, I think that is reasonable.

Tag all the IOCTL's with the IOASID number.
 
> > Not sure what guest-host PASID means, these have to be 1:1 for device
> > assignment to work - why would use something else for mdev?
> > 
> We have G-H PASID translation. They don't have to be 1:1.
> IOASID Set Private ID (SPID) is intended as a generic solution for guest PASID.
> Could you review the secion Section: IOASID Set Private ID (SPID) in the
> doc patch?

Again this only works for MDEV? How would you do translation for a
real PF/VF?

So when you 'allow' a mdev to access a PASID you want to say:
 Allow Guest PASID A, map it to host PASID B on this /dev/ioasid FD

?

That seems like a good helper library to provide for drivers to use,
but it should be a construct entirely contained in the driver.

> We also had some slides from last year. Slide 3s-6 mostly.
> https://static.sched.com/hosted_files/kvmforum2020/9f/KVM_forum_2020_PASID_MGMT_Yi_Jacob_final.pdf

I think you are trying to put too much into a giant ioasid
core. Responsibility needs to rest in more logical places, it will
simplify everything.

Jason
