Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC7D37F945
	for <lists+cgroups@lfdr.de>; Thu, 13 May 2021 16:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbhEMOBI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 May 2021 10:01:08 -0400
Received: from mail-dm6nam12on2067.outbound.protection.outlook.com ([40.107.243.67]:24704
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234317AbhEMOAw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 13 May 2021 10:00:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g99g8q4qeb6aqiIXWyVAcKCg5qo/wmUmYe5DGBxbjhzzwm7KoIrhG49W3vlwW5q5yuUmnXBX6bNr6GNhGT++n26xftHtv8EedLAh+KW2Tam/a2LuFCLd0E0gOME7zH8IkSTI4BpRstolfr7i6fB3WA9xnpQhZMolvPRYAkpZXn58AbYpnrpArzUPlqCFsgyLghwfA1Vs5zhqzyxsx1x8XGkCsQr1N0bYQ5qDTbZkL7dk9X5JNk3+iLK35Jr0yWteA8QndUea2hdnyCCpidhx7AHKyYRDoYHQodUfcqjSD9H2619fC2jEdrq0ohS1Gpb/9qYUzFpAg0z2wjsdw/yR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxUAgRWq6rQGjwNbnUqXypkAkkQ4cafn78SEI8kEswE=;
 b=g0OAumj9ZF4a+8V1bw8dwCeEV7zpEg/sCBRwbMB/8hWf64duP+GQwfpccxSfrJI/hVmlMcPBaXWcc7R17Q9OGtRxYOrBO1p3CmwLcqkaMXPhE07BbWGdQf3KbYBwm9+g3joLHAUr7StICgExHs8Au6kzVrJI7LMysCTO9QUM7vZS6jJ0RMgr8/1W06PWxISh53xpNBssQD2b6m0G3og4G6frWjoLXky31emSne7Z4TL0yv+hRHTdyUJJIbXRDFvYnKtq21FU8bPkrvT1qvQWwX9C8lSWAxB3QvFwpDRl9VMcbQxU2WvHa3mhOD+jTlPnD1+nc4wpkhvY/E7eX/ZwoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxUAgRWq6rQGjwNbnUqXypkAkkQ4cafn78SEI8kEswE=;
 b=AK6aHuSWIwgfikM0i2PZh2yJWU8VHz8ofU4eFWm5aZPmC2B5xhlfMGJcA4A38bHeKiQre3uL1yQKyLUmgX+oQ1d3V1izBVlvazEhVAn0e6EzPuRHbCvHN+SntRLf1kZAA42uNjZYx5Stch1+vn/bRQvAFXD0g99qqpbc3asA8W7C2gwy1ml8NgleCQIMWNp+cdvEMHhF47PXMiPT2P9A+OV66OtUQOPsuZC8TdEXs+jExwdyCRCvbXYiwdeqXiNSFEW4IxfnjH/i/3PGW2dcNZqKVhYf94cmTIwxKQWg9u9A5jdGehc3W561Tu+xCpsyb0osPBa1RtChFPkZyxNO2w==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none;gibson.dropbear.id.au; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1340.namprd12.prod.outlook.com (2603:10b6:3:76::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30; Thu, 13 May
 2021 13:59:40 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 13:59:40 +0000
Date:   Thu, 13 May 2021 10:59:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
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
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210513135938.GG1002214@nvidia.com>
References: <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com>
 <20210422233950.GD1370958@nvidia.com>
 <YIecXkaEGNgICePO@yekko.fritz.box>
 <20210427171212.GD1370958@nvidia.com>
 <YIizNdbA0+LYwQbI@yekko.fritz.box>
 <20210428145622.GU1370958@nvidia.com>
 <YIoiJRY3FM7xH2bH@yekko>
 <20210503161518.GM1370958@nvidia.com>
 <YJy9o8uEZs42/qDM@yekko>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJy9o8uEZs42/qDM@yekko>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0041.namprd13.prod.outlook.com
 (2603:10b6:208:257::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0041.namprd13.prod.outlook.com (2603:10b6:208:257::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Thu, 13 May 2021 13:59:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lhBsJ-006pZw-06; Thu, 13 May 2021 10:59:39 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1533b63c-c975-4f01-b522-08d916175a3e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1340:
X-Microsoft-Antispam-PRVS: <DM5PR12MB13402F46CEFBC9E08DB82796C2519@DM5PR12MB1340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWjgYZ1f202a11lBPZTLmM/NTNmtofIhmSzbL1KK0JPckZQKo/sRR4I4PEQ7IS0LmaUBa1bHkLz2Ta9bLjnI0QfzIXgizuB7qh3bPO8JHaGMG1UHLakxyua8dS9yzvSzIL6d5DvVueyE56QCQKegF3BjmXRtnCJlCVsq21fBigMh+AxSf2U1PYKfPZ9aBmQUhYAQGjfbNd5kBb+zhn3VuIUwczVjkcwJWU7JX0lKdTqPImf8NCK8maR1FyDAk/gVeYh+X1Cc/YHITZzeER136+TgDicjO/BkkJ8t8LiBGZWxbVO2uPDg3ZNQQKTHeplSIMb9du7XIDj4hrwH1vvQuvfoHtBGsUsOsFA167+2+rOi9jT/FVOWLHr3bOvj4goOaRx6+F47COS+wLEG+LQs1FesrSL4BtPQqGQGcudivt08+tVW2ogfoC66CmTRT6F7Ex7Gx9y9Uw2C+fMLZd+2f4Aut3d/gUZU6saqEw/ZM3L/IScrdCXkKnk3kbElK/+8SWXuqB+21uEsOG1/lOJ14N6SJWd0xqSXUU1nzYV9OR5HzUsUCvZvjMNbRh/vdtHOn0ykakDZ/7vxql8PRGYIo0BZomnGqS6eVAUEAaJuhYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(2616005)(9786002)(26005)(9746002)(8676002)(8936002)(4326008)(33656002)(478600001)(86362001)(6916009)(186003)(66476007)(66946007)(66556008)(54906003)(7416002)(36756003)(5660300002)(316002)(38100700002)(2906002)(1076003)(426003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AEKSmJXmaajtadU/sj82eQ1vJmhprYKkxmlNBRHLMY7PCULGyf+Fs6HAy3lV?=
 =?us-ascii?Q?TE91H4vudiBt5ebKybclAdFDp543+vgRmyLEszBOCIp4hOLI/gR/GYUeEGLy?=
 =?us-ascii?Q?RL9H1+mU1pg8cqunVDXwHwqipdmEOhHDdynSBbrQSfUMip0TSQpkisGSgHZl?=
 =?us-ascii?Q?l/2O4ZiRTJTt9ghc812ZBRQpAlStfxDuWAmVKarJgrCR6EN7bCLLhSXanmuC?=
 =?us-ascii?Q?nTkD7j1l8DHxM4aS+AR7nDgxicHTdVbK3BvaTY/W/2URPhmg87hQPYRgmLy7?=
 =?us-ascii?Q?ieWVljjMzEhQiebFBJWXIa5izuYD/11PP/INo2om3YOB4YuEVZAh0F5KYbgh?=
 =?us-ascii?Q?a2b6Yo1dW4TBF+SQEbti/3YH/nIPw8SkKGvQmCL5ILwrFG/rewfugU1XRLNl?=
 =?us-ascii?Q?LcVcT57q6lZW5dVn5jwbvC9uySMvLXqbYcKcs+Rnza6m9KrPXGOkra+I7z7b?=
 =?us-ascii?Q?XhUGygm1Mv9aWKKELhPKqhqu1uUdhRossUfBQ8WjGffAFqQKtC8HNoUATVZO?=
 =?us-ascii?Q?23xr76e2jlrLjdiWXx6+MSYs2xdQerhIWAIM5AkaOM1uBuPvvQDWYdhFDiyM?=
 =?us-ascii?Q?uTt09pqL1IentVALxcpq/lFxDYyHuIc1BbC6SZPqza8PkiUbc6XEEb9r5kpc?=
 =?us-ascii?Q?hzc/Na+wC2PR7J5ZKRWzY4CDZweTdHJK7qVRfypfZ079clNu05deUfSluDov?=
 =?us-ascii?Q?ENXU4RHerl79eRZFAc2c+JdtELK2j0Nnfoj3+4dm1CGFUB/xiHY/ZrZBr9oO?=
 =?us-ascii?Q?EPNi5A019QvS+XeXnciisEv7G0+D/kh/DY+IbaGJHeHTHY0gPyS12YvmIeyI?=
 =?us-ascii?Q?8N4Fv3e8UhxUba+p13Ewc92duCGiwEV18Av2rYrfeDpdhi6D4QKKvRov3iGV?=
 =?us-ascii?Q?5x2ozvR+g1robvlGnOfUk5Fqr+JoyFZynbpW45csEkSBYYtToJYWhqhEc11X?=
 =?us-ascii?Q?wIRl/OXOOud5K0zb7rQTQV9/jIqy/sn0/4RYActK4L0250VN4p9Mp3sDbBz5?=
 =?us-ascii?Q?/BJZdq+h4t7/BrgDt2ItufvwrL9Y5aZE2Q9RwKU5lOQvJ/OOjmj/LFgxAq5g?=
 =?us-ascii?Q?6JrKSMzSNwNGnMf3Jy11QeRAuKuWsvHY+CdJeWcbch/R8uayjSNuwiZ/vsDG?=
 =?us-ascii?Q?bm8pti/R08+DZhmbuUyxeHZ1uszTCLTOvl2j2INswlvjuCW57QMedpXL0zrm?=
 =?us-ascii?Q?WGIlVxAiAVBg9jOD4oF4bINX7msCjblbHVhV0aOZ4wGvNXE/5e0XRJRC7QB1?=
 =?us-ascii?Q?5/trL5Aw1FNDe3q3oeiAIkPtk7H7FxKC0szZXhTrqclwDhoMYmDy54Sm4ksO?=
 =?us-ascii?Q?0rr1cqn5zD3L5ltG+hESOTM/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1533b63c-c975-4f01-b522-08d916175a3e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 13:59:40.6072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HM4VFYNb70juCl497m5Qv7Ax7LCxnrkh2EHktjsbBe9z+ptMX5YiOw6e1GnvMKlt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1340
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 13, 2021 at 03:48:19PM +1000, David Gibson wrote:
> On Mon, May 03, 2021 at 01:15:18PM -0300, Jason Gunthorpe wrote:
> > On Thu, Apr 29, 2021 at 01:04:05PM +1000, David Gibson wrote:
> > > Again, I don't know enough about VDPA to make sense of that.  Are we
> > > essentially talking non-PCI virtual devices here?  In which case you
> > > could define the VDPA "bus" to always have one-device groups.
> > 
> > It is much worse than that.
> > 
> > What these non-PCI devices need is for the kernel driver to be part of
> > the IOMMU group of the underlying PCI device but tell VFIO land that
> > "groups don't matter"
> 
> I don't really see a semantic distinction between "always one-device
> groups" and "groups don't matter".  Really the only way you can afford
> to not care about groups is if they're singletons.

The kernel driver under the mdev may not be in an "always one-device"
group.

It is a kernel driver so the only thing we know and care about is that
all devices in the HW group are bound to kernel drivers.

The vfio device that spawns from this kernel driver is really a
"groups don't matter" vfio device because at the IOMMU layer it should
be riding on the physical group of the kernel driver.  At the VFIO
layer we no longer care about the group abstraction because the system
guarentees isolation in some other way.

The issue is a software one of tightly coupling IOMMU HW groups to
VFIO's API and then introducing an entire class of VFIO mdev devices
that no longer care about IOMMU HW groups at all.

Currently mdev tries to trick this by creating singleton groups, but
it is very ugly and very tightly coupled to a specific expectation of
the few existing mdev drivers. Trying to add PASID made it alot worse.

> Aside: I'm primarily using "group" to mean the underlying hardware
> unit, not the vfio construct on top of it, I'm not sure that's been
> clear throughout.

Sure, that is obviously fixed, but I'm not interested in that.

I'm interested in having a VFIO API that makes sense for vfio-pci
which has a tight coupling to the HW notion of a IOMMU and also vfio
mdev's that have no concept of a HW IOMMU group.

> So.. your model assumes that every device has a safe quiescent state
> where it won't do any harm until poked, whether its group is
> currently kernel owned, or owned by a userspace that doesn't know
> anything about it.

This is today's model, yes. When you run dpdk on a multi-group device
vfio already ensures that all the device groups remained parked and
inaccessible.
 
> At minimum this does mean that in order to use one device in the group
> you must have permission to use *all* the devices in the group -
> otherwise you may be able to operate a device you don't have
> permission to by DMAing to its registers from a device you do have
> permission to.

If the administator configures the system with different security
labels for different VFIO devices then yes removing groups makes this
more tricky as all devices in the group should have the same label.

Jason
