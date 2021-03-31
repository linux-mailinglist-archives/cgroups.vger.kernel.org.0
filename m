Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC2B350663
	for <lists+cgroups@lfdr.de>; Wed, 31 Mar 2021 20:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbhCaSdk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 31 Mar 2021 14:33:40 -0400
Received: from mail-dm6nam12on2052.outbound.protection.outlook.com ([40.107.243.52]:51713
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234627AbhCaSd3 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 31 Mar 2021 14:33:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsMc/IzjsXn6tFz2EF+xPaNa6E0v8euMH34xMtluvyy1OgKcZFoxTaOMNw2/gL1jECUKhUuc4U3IXLuHowy5IQSBZ7MALuo6BdwSSqGZXdlRGu3yCf6vXzlC2retKZp2YcKnTUQ9K0k9LyIyRj5EKO00HL4rdt12NZ1BB/KFSrcDqXQJ+P1/KJBqR+iXgePCIbNYl1cUiXwbp3BU0PMXLsoPCEm0fgg2Z6K+60/t8G+ZTvHh2WEJC6IZ5RHllQOa/i/n8wvLRQszbji4tQ8tCxN5aNMYrCwZVByKSysJToUShYmkUgTvy+O9773pnGTLE42R6UUVBKSpEWe58XLtfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYZRs2QksBNC78z+UTsQttx7YMW9PTlD6PmKAEmWUjM=;
 b=L+0f0902vGDmnkH1Zl5hxUg19ZkVPvxKzDbluzo6cpq6dOIDfCD/NuY/NcFpswXR0ev99lDPxNG/qfhZDsrylOksWFsk4NmVyvrc/cILUfrEIuAEPbZbNgb5Swe6ZOFzyg8Lr/gT6cWPsDCB0gTh7jvFoAVvgm1FKY1e3hJ5u9l5y3npGqtP/UUiSWgeRlPAOFRWpd5ndEXgRd+vWV7nUiV+bZYhQkbauxluU2nnqGdmGUoXVkCCm+u9dTEYMwx/6eFttaG5Ep/FmeQjXNX/IR3Wm5v/V2Chrke2G94UEM5Bv1sj2ExFMLNIYh8TSvqs4TiSS7IzlS9eTC1KeD6akA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYZRs2QksBNC78z+UTsQttx7YMW9PTlD6PmKAEmWUjM=;
 b=qUCqD3hJhFhUN/QFxhRxACSOam6RJaBh/Xt44ruQTiWQpmehE9hBK8wyK92IlhPZLUpKFPc48/Oot983CJx6SFPa5H+grHPrkq7Er1HFR3Kr7bSrdgVl2YcEm0yLakgjI1JR/1PQZvjViJNFXtcvxhQMc77yEUu+KoJ59PXaNh6ME182P/Lnhkg3rAmVO0XaIk+3XlJ2z2qcbAyjNvx24CWNtGsHmAVUIhqbQEUq51GdqqqMotz3R/YGyNnBTq71SUR2p43n1rW82PHcbMI3Pj38PIQJUM0LLDFvKePi++E18OjyhekGCW4ZMUyGy4k90nuP31zys8DSbwunyJeJ2w==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BY5PR12MB4050.namprd12.prod.outlook.com (2603:10b6:a03:207::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 31 Mar
 2021 18:33:27 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43%6]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 18:33:27 +0000
Date:   Wed, 31 Mar 2021 15:33:24 -0300
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
Message-ID: <20210331183324.GR1463678@nvidia.com>
References: <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <20210329155526.2ad791a9@jacob-builder>
 <20210330134313.GP2356281@nvidia.com>
 <20210330171041.70f2d7d0@jacob-builder>
 <20210331122805.GC1463678@nvidia.com>
 <20210331093457.753512d4@jacob-builder>
 <20210331173148.GN1463678@nvidia.com>
 <20210331112030.174e77b0@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331112030.174e77b0@jacob-builder>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0150.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::35) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0150.namprd13.prod.outlook.com (2603:10b6:208:2bb::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.16 via Frontend Transport; Wed, 31 Mar 2021 18:33:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRfee-006R6L-SD; Wed, 31 Mar 2021 15:33:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b512e98e-92fe-4574-b47f-08d8f4737991
X-MS-TrafficTypeDiagnostic: BY5PR12MB4050:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4050AAAABF93D589C2FEA01DC27C9@BY5PR12MB4050.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: neqmqf1pYsHskTxW5aHJPNcM1kJcB004JmWHQd6uW9A3jVHTphBa98Yb7jeG32y+mBzgrcLWRiXsc1W1LRdiD/k7EgwbQEXfIM23uQuMdWYBSBjq6YpwsGk3t4eq4p0iXngOeLreo5r3P57Bf8jzZOxRx+M51q7DtZ8XugOZXG5nk2/Kt7gEryB/uxt1qavy7pN86OIedcDlL494QqRDpw8KK57F2bdHULtvNI4vK+cvBJMFdaPxihPt1nAr5FLEB8NA1d5OExYGp4SdxDgbZkBw0mGPV6tDfX8qqxhZAkkeseu2sCqfR077HicpRUDnZK9VZBYDEsJSRus5Ha5gJgwOzebm+/oYi6fHxLOJVEAD5UXpIBsmNiYNSgWv2Fg8Yf+rinroomAbiezQcaFRjiWeLUDd79yJzo3b91s3JZzMb+BBCt3MXtw02rxl03cqoX+qFzqZKv+TwhGodslED4PAYH9sF0uw1bdEXdUBY6PpAcSHlkKTou4+1RqO6xrAGSiPKC5qlmSOISoUldKOMtr8B6Ex/gmHOsk0yxkMa8Rz2AnyKZNtg2oBu4Nwf1D7A+iSAYgABjFkTxeYU5LriwGZh6qDNjrRnVeR/p8M4ScAaddP4ZdowBAj23Xut6sZEUgZjEBM5XPxxSaUzlX/obvsj3c5Iy0+TTZ8VgVX0Wtwu6uDjgMwhvzWm5Sq89at
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(86362001)(8936002)(8676002)(2616005)(66946007)(9786002)(7416002)(83380400001)(426003)(4326008)(9746002)(26005)(33656002)(316002)(5660300002)(54906003)(66556008)(66476007)(478600001)(38100700001)(6916009)(2906002)(36756003)(186003)(1076003)(87944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QvTa6TFd6nwkubmZp+LyEmmZqoo8yx7dma/9OMHDg5MVsx7e1SMcspnN43YH?=
 =?us-ascii?Q?cdyYRnEkspkl6wSfBVQYCFFUDMLaiAGb+ebBauNNuX0eVgnDoYLaMYTvHM4Y?=
 =?us-ascii?Q?TFiaqub5NJMQBHvJ5hKi2QFl6Nd/7vYNbaUIV05qhG6A2d4hSTAD0tRPd/Q8?=
 =?us-ascii?Q?T2TZ2CPBsraVjWvwdsAKpETq9bxuYi4iUxXrslUX63ANb2VrNY/qJtjV8Prh?=
 =?us-ascii?Q?3rxkTEPRYmvWg7KI/rXyOMiWvqprkeigo1Bmu9tADF+4MvfT1xOVZXUNFlTM?=
 =?us-ascii?Q?KLuMifN87tvtrxNBEnc2nATe5uGsx5ptRFBDSlI/7T3iQmgfKs8Ui8chca02?=
 =?us-ascii?Q?+F1JHqzZKWVyrzqr+6/tn8dXuONvlpQF4TPI6Cl+9H03XZdIbFCEd4G3xVkj?=
 =?us-ascii?Q?BgW47AYmmrxaf7BBTxKEO95OXz9+HbF23z9evsWyw0k2YU7RikrFShdXdEDw?=
 =?us-ascii?Q?0WACcKZCZiZ3MHB+nM3nJBQAABJjPzxaoFY4oTHgLPHhG1OUnAa+E1ZYU9kE?=
 =?us-ascii?Q?O7qo6rjKJzHfyQmZXbIcKSJo9FH7rJWUYBj4co/synwZyHYekdecyTUVBVjj?=
 =?us-ascii?Q?TBed5UNrkoiReSulC9Eqw3M+c9bO0ITbrIqetSrc0kezo98RyIG6MXvrKpXS?=
 =?us-ascii?Q?RcWDegfLgBjBMuB5luabIL7ALt81a+AqLox8Kgx8CfTmz77MFteVG1EqdWtH?=
 =?us-ascii?Q?qrDgQUzimp7jlyrVNmRrIFCd2rPEEc9pOsNLfSGosnqi4TYhXUOhNMAMStii?=
 =?us-ascii?Q?2/LVlUVKtRpDEYfmGh0J8QvJpf2bS1qe+cGTaTDTt0VPUbkx7YwPQE2J58tN?=
 =?us-ascii?Q?wqI4kF7Q7UKq6W8r04FV/06/UuNIAf13U9M6xB/3vLAGUswkTLGpYqRZ9BkZ?=
 =?us-ascii?Q?oEHeQYUH3q/4Vbqjg/Ord8eeV1Yf3VRFajn9+CQ0ZfXh0mowq40PII+RtpQq?=
 =?us-ascii?Q?+OhJ3T5HcqLrkHdp6OWn99bdSecg439df2aezhHOtq6sLWwpqwFki0Fe+sGx?=
 =?us-ascii?Q?xNv4jElU4rS1sOhVI3p9HOhgeFsJkKcYMMLl0gFuo6+Zw0UxdbohYgjiBK14?=
 =?us-ascii?Q?RQ/YAGR3Gklxah+MHcpgIlF6MljD0wVFBArcQeShlg16LnMuRTN0VHU3yigP?=
 =?us-ascii?Q?Ig1hpnsGS0lDzztvl04V6xT8xpOuVjBXgtTk7dbzHXWtQ51L/v4rOqterC4u?=
 =?us-ascii?Q?BjOsQR99cnZX6Lo0Cwch+Q6eFX6etwElwO3xCVVYz00mWy1av5/k7+CqiO6T?=
 =?us-ascii?Q?G+XrX0RQhEn6Am01koAVBM3INM6lhjWRYmmOjIk7FCd+MCtyX4qNVymqsx6I?=
 =?us-ascii?Q?UBeVMDh+Axo3Z1fWBmyJRMqvUzr8bMBs0QaiHF5H2l1SnQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b512e98e-92fe-4574-b47f-08d8f4737991
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 18:33:27.4021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15qkNHvOzzC+L2S8QVPQ1GHg2rb8pXfoLi4YHdV7y7gKJBWfese0pX4v+hPYZcvH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4050
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 31, 2021 at 11:20:30AM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Wed, 31 Mar 2021 14:31:48 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > > > We should try to avoid hidden behind the scenes kernel
> > > > interconnections between subsystems.
> > > >   
> > > Can we? in case of exception. Since all these IOCTLs are coming from the
> > > unreliable user space, we must deal all exceptions.
> > >
> > > For example, when user closes /dev/ioasid FD before (or w/o) unbind
> > > IOCTL for VFIO, KVM, kernel must do cleanup and coordinate among
> > > subsystems. In this patchset, we have a per mm(ioasid_set) notifier to
> > > inform mdev, KVM to clean up and drop its refcount. Do you have any
> > > suggestion on this?  
> > 
> > The ioasid should be a reference counted object.
> > 
> yes, this is done in this patchset.
> 
> > When the FD is closed, or the ioasid is "destroyed" it just blocks DMA
> > and parks the PASID until *all* places release it. Upon a zero
> > refcount the PASID is recycled for future use.
> > 
> Just to clarify, you are saying (when FREE happens before proper
> teardown) there is no need to proactively notify all users of the IOASID to
> drop their reference. Instead, just wait for the other parties to naturally
> close and drop their references. Am I understanding you correctly?

Yes. What are receivers going to do when you notify them anyhow? What
will a mdev do? This is how you get into they crazy locking problems.

It is an error for userspace to shutdown like this, recover sensibly
and don't crash the kernel. PCIe error TLPs are expected, supress
them. That is what we decided on the mmu notifier discussion.

> I feel having the notifications can add two values:
> 1. Shorten the duration of errors (as you mentioned below), FD close can
> take a long and unpredictable time. e.g. FD shared.

Only if userspace exits in some uncontrolled way. In a controlled exit
it can close all the FDs in the right order.

It is OK if userspace does something weird and ends up with disabled
IOASIDs. It shouldn't do that if it cares.

> 2. Provide teardown ordering among PASID users. i.e. vCPU, IOMMU, mdev.

This is a hard ask too, there is no natural ordering here I can see,
obviously we want vcpu, mdev, iommu for qemu but that doesn't seem to
fall out unless we explicitly hard wire it into the kernel.

Doesn't kvm always kill the vCPU first based on the mmu notifier
shooting down all the memory? IIRC this happens before FD close?

> > The duration between unmapping the ioasid and releasing all HW access
> > will have HW see PCIE TLP errors due to the blocked access. If
> > userspace messes up the order it is fine to cause this. We already had
> > this dicussion when talking about how to deal with process exit in the
> > simple SVA case.
> Yes, we have disabled fault reporting during this period. The slight
> differences vs. the simple SVA case is that KVM is also involved and there
> might be an ordering requirement to stop vCPU first.

KVM can continue to use the PASIDs, they are parked and DMA is
permanently blocked. When KVM reaches a natural point in its teardown
it can release them.

If you have to stop the vcpu from a iommu notifier you are in the
crazy locking world I mentioned. IMHO don't create exciting locking
problems just to avoid PCI errors in uncontrolled shutdown.

Suppress the errors instead.

Jason
