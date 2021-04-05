Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5F235495D
	for <lists+cgroups@lfdr.de>; Tue,  6 Apr 2021 01:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbhDEXml (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Apr 2021 19:42:41 -0400
Received: from mail-dm6nam10on2059.outbound.protection.outlook.com ([40.107.93.59]:53063
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241925AbhDEXmj (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 5 Apr 2021 19:42:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiphAT2sMPvLUqUBflUlUuVVM9pCLisYnkd6nvjNCkxDwPH6jk+JItWoQMwAFSPIj8Mwm2I9LwVI6jpX03B2Q2wCeunW3IQvePaoN4a/QTFnxLv/TJBSqkFhJ5sb6LMhk2D22a2BqIIUF4tnhwQD0lHtNn0jv+99k5FM0nC+RqXbdp8lvAnDJN7eveqmBMUHrx4gyinN4d22E/eiTdrwKhXT/fLgkkt0ZbKvZfC8KJNCdaacPb4ee3o82b9PtPuX+6KfeFI/qNpBy6eaOmzrWR+ndh0xQl08H1VKTqQqTMbDg+4YTStc0yrD5BXZeZh90vZMpHJ2IOmEhFkMbT8Jjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1RQeoDaVVHz6tzdTwIHAww8PRvtuS0cmUnaKDvh6LI=;
 b=V99GDD6HWPFD7FQfcirsR4qdCCvdQi/fGU3+t4PcfC4lM7mWWwCsQT1vzljQNwXnyOj3djwdKyWTZQNMM6dTwKA+dJh/JU7BJqSQXS+Hzn2P1bieFF4HI2Kl+BR7MepIFy7P6gaijVo2SdqNtMvK6HAjONv6010MeM7FK7BrPahE+C38d4rG/MuZ8yFcAzhey6ujZJ6wgsCeN67MH7VOhTkiuLlZX/GqIjtOi7veWCYnPqLdqsEUUw2twlUIAGS2cMSjxPtlR1iWtIEnuVr/lxNoIwSqGN8AEBTdDWF7deTtNlNtmVYi3Im3qvH6gEMyLCuGJYK1US8+PXWvnrQzpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1RQeoDaVVHz6tzdTwIHAww8PRvtuS0cmUnaKDvh6LI=;
 b=j2KiEIywQUSWO8QrYNXGpMwyJOLyKsl1OUQBMKwUEYz/30kn60QGFk59gpe/Uz6EjA0wgNMGrLgVFADl0pbnD3q48Q0q8gCEddCCZBweEM9ulugWwSDUVZvcmXLQuRev26XroeDcQGNHLeIMOolY9NIR6vOC+Z8saqgVS5SfwkzZT3ODIWLKvACvw0W+QdmRICh7geqVPYbwJDFa23CvTiOC1xVyI25vu45F6Ejv/bbXCTxorNdIOKlrYaWLP0OBZRb9Vdu5gbv9NPXxXakMLWEB15SEkz6UMRsXW0Tj+YYR6OqcMk7N0gm+o3aHF/JQf/q8mfmEMwAIj21F8IyiHA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Mon, 5 Apr
 2021 23:42:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 23:42:32 +0000
Date:   Mon, 5 Apr 2021 20:42:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210405234230.GF7405@nvidia.com>
References: <20210319124645.GP2356281@nvidia.com>
 <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <MWHPR11MB1886CAD48AFC156BFC7C1D398C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886CAD48AFC156BFC7C1D398C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR07CA0016.namprd07.prod.outlook.com (2603:10b6:208:1a0::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Mon, 5 Apr 2021 23:42:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lTYrW-000x33-Hj; Mon, 05 Apr 2021 20:42:30 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5942bc92-b181-45a9-4a62-08d8f88c7b2a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4356E31776505D47635B6F1AC2779@DM6PR12MB4356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LBZbXnu1+CjH0yP01nCiJq1cJOQWVqqDAjIbU3w1EW3BUOoLcfyvXzX2RtSBCExsUmqekgguyVS9M6hpFaZiZA6t/pzpjvVEen/jn7DEScfnq5AdLIzF72SD9DCX4Lpp9E0xetSRsBcFKymyQDL2DQn+NtgQ6i2lGcon/eref5Ydcc2s+mOriVOAe3d2B7QG4sbb93mmaAgSjkQQqX5LtHbNRrAqG6O1DXx5m3h4uGHL3lm/msm4oaJSrdQxt6mlXpfPYyWO+1kjt8bmcTVXimqX9/qWIxc/Co4iZ2FIcmuusCsXSNGadAAzLdKDqUSCvYX/OV0Q544+GkI+fs5T2r8kEeWuGmSjaVsX93jF9jMZF12BSDYBjTgQQPqMWDscQAgFMqF7LYmKFhWeD6m6yQhYUgzKfBdR2Mdb+E6Llb1tZo7XVdBNCIIAbLn/Yz4Wt5B3/oM95cNnIol4W8eQgLDHOIw75rSCYliTfv+5yGtOMeYhi3FaP3h7PNGwoEt+5AJOZPR+IBKpxskxX5om/GXM2gjqswZnf91ffZWxXHF4LniUD6lvTf5SZ8d4ExGW+gUaFmPORR2sfzP7Q8VJCn9jMvisXY/P7nN1CXaGapdFMXgriP4vWowck6w+07KhwitVCNAyGDPuJsDitDPscA+GHAxQH+r1SD9ngvMoRuc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(8936002)(86362001)(6916009)(4326008)(38100700001)(66476007)(8676002)(1076003)(186003)(33656002)(9746002)(5660300002)(66556008)(426003)(26005)(66946007)(316002)(2616005)(2906002)(36756003)(83380400001)(54906003)(9786002)(7416002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SOwpEA0nUgW528J3Y33UHixOc4m0HIuLdL3gSRpZ4GvMfmZ8xOm8ZjizXaAk?=
 =?us-ascii?Q?M+KGCU+2QsHSCwEwLhtuUzgvUddBtGf4LPYFLOT4wbsQI8Oq4sw5GppDmV+C?=
 =?us-ascii?Q?pKVB50sDXcT5fE1RGXqSgVBQJEhZ7JqU2pF1hhLC4M/EF9cUO/IWeaU5R6wi?=
 =?us-ascii?Q?evaToxhqKtQpxrKwY9tEadz21pLeA6TTfn3MVBsLXKNGaTptw8iJXghPbh9j?=
 =?us-ascii?Q?4x8AdFk4UjaJMkZ9lKDiNoFQeZJ/jNY3kYSWQySWTihah+MsKpkc3xfKLezM?=
 =?us-ascii?Q?lOwAYyu3vaZ++yL+FU9zQft7WTbfYnqrg1TcW0ixC870a5zK1zJej12VxTRP?=
 =?us-ascii?Q?b4wo0+wZwEZAW/D3lMxCSBiL06hzwZ22vMM3zzisKQHXGO5FlJ35I4nKJpFB?=
 =?us-ascii?Q?JrYrd3Ym9Sgr7cav1irDLCMacZMyAysBTEj9xAns5cyD+lbZ+SHJhKYvotLI?=
 =?us-ascii?Q?MQxCK9S5jFTbaWCi14yKMZzo6VctIu1Tdw8GD/WWs1kZTiXhZOXO8lRP4Jtu?=
 =?us-ascii?Q?6+dAvHKl9DE6jxJu1pImfrWlz7nejJoiVEOZ5S3X4fRit9pe3fsVmlBcVQnH?=
 =?us-ascii?Q?cnwNvRxM3E4GU68G8iR4yU9I4Ni4xDf6ecfbQ3/IZHDzcB8A02HClHOJqt4t?=
 =?us-ascii?Q?1IMY98K4nEtDvERJ7TwGmF+E0ovaWqIghuSfJQzs0Gys9HA1Vj19ukvJLFqN?=
 =?us-ascii?Q?qc/E8HMMb2PKQvVqC0qHOOH9nbwqFD1fOi6tdXYRtruABqTW7hIbOBMyg5zE?=
 =?us-ascii?Q?u/KuH1w9JK4TKvC3qZGNh3WkbkW0QVTWjXh+TMxPnj46+9sLhFeavUEWwLCW?=
 =?us-ascii?Q?8LKblNtDKEFBxaTB4TQsfc7/cLk+fzNDajHqYFGyjgXj8gTGLjfWUSkaMXZF?=
 =?us-ascii?Q?pzrSOsTCzSPcPAStzOhOkvMijlpBUjAs21m9ff13a+HqaodsxcX+kt84bLl1?=
 =?us-ascii?Q?T2Bji4CeWe8X6qRfoFsLtypA9xYjBq6CEJmOVM2YmGOKFpQDALIx6ucfu9FN?=
 =?us-ascii?Q?KPB/Omtuqcxp6C8PEwYdsLnc4dT+61xvZiCV5aU5XQ6CnZ4iNMWSPAvqq9WO?=
 =?us-ascii?Q?YbYPQYLLRn8cYmp9F/nZrc+/0YrKB//rFVU50/ZxbA0eTZdw5OCZla0qvAjb?=
 =?us-ascii?Q?WRa+HVYF/ejocJzrwumhhMlkMjlV+BpMlrxsbYjXjYbAC+mFQ2K02orbCCfS?=
 =?us-ascii?Q?4mcAX1X99PzEhadPHdJLorlkAwqHgd+p88YFzbJTz74rspmQNT3dpxF4mnfF?=
 =?us-ascii?Q?haOa0y5JP5itPqoik1mtSp8VQPxqZDwt0YXBuYvnYi3lrS47qan7UzLdhMev?=
 =?us-ascii?Q?nmdFCbxEW5NRl5gcZSpdL8BVk1Zxnle+VOeZHsc6bt9Lqw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5942bc92-b181-45a9-4a62-08d8f88c7b2a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 23:42:32.2361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +O+ywaV+Txz5L8s6xItXS0yIEW5Cr/C3011yCPztVxMT+VlnGTIAgXfV78O3n1w5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 02, 2021 at 08:22:28AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, March 30, 2021 9:29 PM
> > 
> > >
> > > First, userspace may use ioasid in a non-SVA scenario where ioasid is
> > > bound to specific security context (e.g. a control vq in vDPA) instead of
> > > tying to mm. In this case there is no pgtable binding initiated from user
> > > space. Instead, ioasid is allocated from /dev/ioasid and then programmed
> > > to the intended security context through specific passthrough framework
> > > which manages that context.
> > 
> > This sounds like the exact opposite of what I'd like to see.
> > 
> > I do not want to see every subsystem gaining APIs to program a
> > PASID. All of that should be consolidated in *one place*.
> > 
> > I do not want to see VDPA and VFIO have two nearly identical sets of
> > APIs to control the PASID.
> > 
> > Drivers consuming a PASID, like VDPA, should consume the PASID and do
> > nothing more than authorize the HW to use it.
> > 
> > quemu should have general code under the viommu driver that drives
> > /dev/ioasid to create PASID's and manage the IO mapping according to
> > the guest's needs.
> > 
> > Drivers like VDPA and VFIO should simply accept that PASID and
> > configure/authorize their HW to do DMA's with its tag.
> > 
> 
> I agree with you on consolidating things in one place (especially for the
> general SVA support). But here I was referring to an usage without 
> pgtable binding (Possibly Jason. W can say more here), where the 
> userspace just wants to allocate PASIDs, program/accept PASIDs to 
> various workqueues (device specific), and then use MAP/UNMAP 
> interface to manage address spaces associated with each PASID. 
> I just wanted to point out that the latter two steps are through 
> VFIO/VDPA specific interfaces. 

No, don't do that.

VFIO and VDPA has no buisness having map/unmap interfaces once we have
/dev/ioasid. That all belongs in the iosaid side.

I know they have those interfaces today, but that doesn't mean we have
to keep using them for PASID use cases, they should be replaced with a
'do dma from this pasid on /dev/ioasid' interface certainly not a
'here is a pasid from /dev/ioasid, go ahead and configure it youself'
interface

This is because PASID is *complicated* in the general case! For
instance all the two level stuff you are talking about must not leak
into every user!

Jason
