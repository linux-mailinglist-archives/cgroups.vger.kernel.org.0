Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6489A39FFFC
	for <lists+cgroups@lfdr.de>; Tue,  8 Jun 2021 20:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbhFHSiH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Jun 2021 14:38:07 -0400
Received: from mail-mw2nam12on2063.outbound.protection.outlook.com ([40.107.244.63]:58592
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234911AbhFHSgG (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 8 Jun 2021 14:36:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkGRWBw/2rdGCIyeMtYsMyy/+66LubeFPeeaPwgnOMMDvQwuIi10mnbxSdig8Fs0wErGg3fB+UqFudEQo7HEl8qvvEHDqbDQizOQ+x0SJJ+vWFvdOrFgd9XZzOjf4H0T4DlOiCgcuyZDn0JNzze1OfIwPOb9jOBKxNJf+CQvSGoKJax1zdftOr4KRsetP61nG1xVo0Y3H8vXgzCk5qf2m9bygqOPSFTpZ72mp0tokl/3qD5Q0VE//zm33J8EQUlUG57mD7KW8J0hIFu4gQcfQo4tXZP6U3FRHsoDBWBLaxNw2RWjMq8vL4wCPZEeQ1rlrvzI5I76ypAKFNnlMw0WbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3usotIniC0C7CyC1ncqRPWaIZKf+w7Z7CRDIonHkg8=;
 b=kqfu0d+hS+54L89Sqiieuvxb0FQ7OtlzhS0kScdkFdxfZ2aNEKzfg4X/9fQlFqaN4lO3VwSGW9SN1vrOOXL95RightmmvAgWyhYsphISAeg4gewphFKqY+7e6ONEj5r519v/I1LB4ILFecvxlu63rhygxrzuDCE1AFRVrnqYStL0DiGamMWLtBsVApIWtisJziWwSzKJNuRjIvkCCYj2hKz6H3rwxv9QCR17u3qo8EHtvM2Q+LWRMbtM2zFUCEUPN/ZERfJ9IQzT3r5WOWiwkL7NBEdif5bmMsHdIGzyCNLTHh3s33m2QVLBS4AISunbWld9ddOUOZ3NOf1q7i3Qzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3usotIniC0C7CyC1ncqRPWaIZKf+w7Z7CRDIonHkg8=;
 b=Uj163r9/fXqFUVG7mH0af1V82npGHw87QLaudYqp5LVp2KHOkUn823pV16BfvbNO9chauG06/DN6M80lJZzaDNeSSJsa82NtlEVfJNliRLiTtOB23+MAY6Eun++Twt6fGfrISxJ3YOALl9qm4g4SIivqbCbaOLkGa1dxHsOjteAKx8AG/md6h6q6y50hTevCUioIYLATHrBZyLPkxTm+ec7ihzWrgc3Mgd/m1FekFG0jMNKOkgi/+4tmnUl1o+bpAda6/40v4r+Cki9WaXzmPGZZbaZDr8V2XTfkcy4BGtBL+D6ROTSHiDWwpJ/XfuCasBRzKf6hiyrm838v8qecsA==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none;gibson.dropbear.id.au; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5030.namprd12.prod.outlook.com (2603:10b6:208:313::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Tue, 8 Jun
 2021 18:34:11 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 18:34:10 +0000
Date:   Tue, 8 Jun 2021 15:34:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
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
Message-ID: <20210608183409.GL1002214@nvidia.com>
References: <20210513135938.GG1002214@nvidia.com>
 <YKtbWo7PwIlXjFIV@yekko>
 <20210524233744.GT1002214@nvidia.com>
 <ce2fcf21-1803-047b-03f0-7a4108dea7af@nvidia.com>
 <20210525195257.GG1002214@nvidia.com>
 <YK8m9jNuvEzlXWlu@yekko>
 <20210527184847.GI1002214@nvidia.com>
 <YLWxlZC4AXJPOngB@yekko>
 <20210601125712.GA4157739@nvidia.com>
 <YL69b0UuDm72QbDO@yekko>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL69b0UuDm72QbDO@yekko>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAP220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAP220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24 via Frontend Transport; Tue, 8 Jun 2021 18:34:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lqgYD-0048DX-IP; Tue, 08 Jun 2021 15:34:09 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06431da4-426a-4ec2-df6b-08d92aac01d1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5030:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB503054143CDAA823BD7E791EC2379@BL1PR12MB5030.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1HNotF34XQbPMS0m3vrSwYeilPQsJm0Z4nIL9LNduIjut0XvPjxflrOsPLzYZdOhDAZtwnv3DexHc+/2ucIgpvFtLzF5blYVVBPe/FgmmrFrC/9iKJ3KK/BmJSbAoZEDH5HuH/s/aCRHYAd0tl+gckfvfXBG6LsRTL0p9aUcaLdGJnhMD5HGFiagWA9/v61gDSxMInE5uCUX3xlQV0xFKykDaKMUeoyBMu2mmQOPk+aw+ZRb/r1fmHO8QDnl1rViiXDstdh6EIM5vqHNDh4EvCGlxFbSuAlamWZJWH6wyEH4GrXBiu0p0Y/NEw22Xzs7PcZiZGJ+hDWP29w+9fQ4lSl9I4Hw1zKQsmMzIYusNu3a/o72PNWs+JZnjEdP79o3M8uCNkMre1HSJIM9b1IJ32mwsfMe+RX7Xs3L0fkcSQHQDoNkm2u7cXAgVdzMu3w1LgkQKgC0xXEZ2gx+f6fE/zrtcM0wPfuPNIncGv1VcKeKz/EZ6PDSamVUv+R/2F5prfP1KM7nDsUZ4giuYuyob8l4l5To+0XUjKLLY2NyGdrE2A2wKDL7xkPezh92NRvu8BYKT/vQs8Kpbw206Bh1iEKoWcVfP0jZlozsPg1VAzc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(8676002)(8936002)(66476007)(498600001)(5660300002)(66556008)(2906002)(26005)(38100700002)(186003)(86362001)(7416002)(9786002)(4326008)(9746002)(1076003)(2616005)(36756003)(33656002)(54906003)(426003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9+ksggWW2HmfxM7C9x//HLXYBkUxEtrBOSEp5IY4O0ZPwD6HssXTDZZcp5fw?=
 =?us-ascii?Q?pN6Am93M4AoH9HfWjbx93q7k98jcr8j1hZoAOZfxxTM+eBLY3FU0A+3SQMGe?=
 =?us-ascii?Q?kzOVhNt8gvig/mzpW1gjFb5T9SgoVdRwtLJmkV0+C2LhhOqz5yc6IwU92Twm?=
 =?us-ascii?Q?X5zUZYRx8SyT728LfEO+BT8b/t6/JcdsLjW0xO3CZeUOZmxqicJWF6NedJHA?=
 =?us-ascii?Q?IiI5KpkBhZhczIFcqOuqLTKEIsKmNTlkqoX/NS0lR6aPyn4z8Nt4eef8OTNg?=
 =?us-ascii?Q?6FWEvNnjuE2m1sPqUSA3mPOj1RpQla7lWDp5aKztHyw4SxVc91xgd1WmqPma?=
 =?us-ascii?Q?ZXuaWN6k5sjcKuX3ZiU3V88/GGR5eEZyUIlXB/kxX4SNfZ+ahcsCEmu20aEw?=
 =?us-ascii?Q?2FORcyhFHaKkPKIiWQA8QS25hOOXsxpyIzww3L+bySRN9Cf2SkhgzihBnWwe?=
 =?us-ascii?Q?oK5dYnCGl5TChK0yzF+5+hi67Zttun7vzD7GW8sL2tSo2Vt+QS+7G3psz//p?=
 =?us-ascii?Q?SEvwzNseiT6SrU+jM9M7uVdK+oQK0xDUovSWsWgXLScRD3CJfF4k4XcXBoqR?=
 =?us-ascii?Q?FGs1zvLeWMJYUiwUZW76Bm3WSRUQu17WZwW/4DoNaokDK91XNLk/P42qBYqu?=
 =?us-ascii?Q?/Gp7E8quZYNCB17Oo/OEePzyYFAB8gQaEX6Q5pMlH7dOO60EpyU3jW8iACFk?=
 =?us-ascii?Q?1UPA+KUBGG9IFudzGDxO47wqvYNTgQQ+bUpYucsK/X05RBTEoA9yqCKaU99a?=
 =?us-ascii?Q?7lN+t+q5g7TE2NHQtr7gNnOG/4LWds/7oyU7isB9kPA7pMQRq0HA3MqYKQ1v?=
 =?us-ascii?Q?XK/dYIDIXl9ORho8WBXElLMOrKi0tLAtRgqRZLDSqunMG/jtRMyltWTD1Rpq?=
 =?us-ascii?Q?T3G4gueLHjHk/NsH9ScjpDGPaR+Hj4gfYu88VEnGUe8t/WFS9d7RDTKaSGS8?=
 =?us-ascii?Q?cwKCSfYt9bW8naVawDmm/7+ZlfQnS+uZVv9a32e4PnFchXFM2p3awkCY1yZE?=
 =?us-ascii?Q?Yjwz28h4fBDvUAkCGjXv+/cw3IaiUMI1sVxbz4lsxXyzG+xojtjLtudz5vno?=
 =?us-ascii?Q?ibUdswR1Pah3o7V5ALAZVzhs2S4xlt5HO5yE976lNaHw6gukGLVktodLfkg1?=
 =?us-ascii?Q?qEJ3+2ycLkgtolUrI/96h3czMPFKtTmA5ATcIZ7J9lqx1+cg/6AY+9CB2yi+?=
 =?us-ascii?Q?BmfMqEGqCY3benldBXpBNZ/Rh05G0e/J7Bl3gs4YvzHYIcColJ/AwHWaI7r9?=
 =?us-ascii?Q?gPbCHwdK/sxrQQx+Slze6eATew1/U2YVbJKjeOmS8UyU4LC5amAXe80j/z8p?=
 =?us-ascii?Q?GFRsTekMGztE2jl1V3gNGBRc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06431da4-426a-4ec2-df6b-08d92aac01d1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 18:34:10.6801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrJH+yKzxu76yDlxcc0C5PGZ8rbCHHL/JBMFIVQiK5v5KZvjnK9buCkH5s4BAdcR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5030
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jun 08, 2021 at 10:44:31AM +1000, David Gibson wrote:

> When you say "not using a drivers/iommu IOMMU interface" do you
> basically mean the device doesn't do DMA? 

No, I mean the device doesn't use iommu_map() to manage the DMA
mappings.

vfio_iommu_type1 has a special code path that mdev triggers that
doesn't allocate an IOMMU domain and doesn't call iommu_map() or
anything related to that.

Instead a mdev driver calls vfio_pin_pages() which "reads" a fake page
table and returns back the CPU pages for the mdev to DMA map however
it likes.

> Now, we could represent those different sorts of isolation separately,
> but at the time our thinking was that we should group together devices
> that can't be safely isolated for *any* reason, since the practical
> upshot is the same: you can't safely split those devices between
> different owners.

It is fine, but the direction is going the other way, devices have
perfect ioslation and rely on special interactions with the iommu to
get it.
 
> > What I don't like is forcing certain things depending on how the
> > vfio_device was created - for instance forcing a IOMMU group as part
> > and forcing an ugly "SW IOMMU" mode in the container only as part of
> > mdev_device.
> 
> I don't really see how this is depending on how the device is
> created.

static int vfio_iommu_type1_attach_group(void *iommu_data,
					 struct iommu_group
					 *iommu_group)
{
	if (vfio_bus_is_mdev(bus)) {

What the iommu code does depends on how the device was created. This
is really ugly.

This is happening becaus the three objects in the model:
driver/group/domain are not being linked together in a way that
reflects the modern world.

The group has no idea what the driver wants but is in charge of
creating the domain on behalf of the device.

And so people have been created complicated hackery to pass
information from the driver to the group, through the device, so that
the group can create the right domain.

I want to see the driver simply create the right domain directly. It
is much simpler and scales to more domain complexity.

Jason
