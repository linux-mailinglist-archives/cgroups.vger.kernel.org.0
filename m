Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC3D350B52
	for <lists+cgroups@lfdr.de>; Thu,  1 Apr 2021 02:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhDAAhV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 31 Mar 2021 20:37:21 -0400
Received: from mail-dm6nam11on2050.outbound.protection.outlook.com ([40.107.223.50]:51297
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231620AbhDAAhJ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 31 Mar 2021 20:37:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZ9q4wjDlT/Kn7UczQDvA6HqVQLWwsoMcqdJPuE8xdMZ1TWe+FotHr9D7zSiIQ2dSxGLIJgugWyhKcL6rc6PmxA7xxdew5ncHdw1V2SbDmiwyJtsZVuYZiIrJoQakrgeSLSC3Hu2URQV85jy/T3QED7uWLdi+MXjJFT/qN57W13Uk2RdrfZ6nsCcFP1d7o4ieZh/ocEgM/NW3Phe4hmiYWnb0LTdL0ooCquoMN+N0hHdom9RbOCEdWCmg/cn8ckZSt2ynW5o93dSgsNDuhfmVOQUpz9FLJx47RsG3nNMg7zLwgzsKQRYAiQ/GavclP4mhdBPUlcN1b/3fmrSBELzQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKdXEPLNEd+5l+BBdzRUMb69nRkfKn+b/iMCBHYXxjY=;
 b=itsVOByFRvEM8aLdaGyMa6YdPFuCJU1HHDXVRU0p7AAB4izBS28pQsDPYWLUJ7gLvqc4Eki6Na671yz4wiRS9CxmUUINzIV2lhGX5MoQwRO1BxhqdOyNl49GFlBh1d8vAEZolkZWDlXWuogJbB0TTiINmqQKeoraEWV25bJSDwd4Xo/32Sih8D5+1IfmEH0x1R8MuvLivbCEli+Mvfs7Fdp1BZaO9uuzgwFt0bUESu1BT0USzerV9Q1tNHA2EjRjeE34fzlpb6RIIgQolEi/auYulSM5dFZHDC/n1cgU8HQ6oi29REG2iHTBacpTex1sZ8iF0p59ILqusLLz8QSjOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKdXEPLNEd+5l+BBdzRUMb69nRkfKn+b/iMCBHYXxjY=;
 b=Tr89xhSCZ3W77CkWKGiSolYOAGeRs5sKMowiQZmqG8J7J35NyijVFXmsH/ExtGY+TH9vJtDZNbXY3rJRZDNFi7K9ruPNy+YI8Vd8vT8vnHg1hiwIvwSY/rtBNE7Kv1L8QkWf05U3Jw/pjEXsOKS+kVqoOjiJ3I5aHWALRd/Sl0a/h9vikdh5Qw2VUg2lNig0fw/5n4bCUwZ582M4ahxtgeSlM24fka3CwvTSsGv5pgpTxlJ2QRG2LT56TmJLDS7lqgGwKLNnsLcijCGzoivrP05yZbgIfmLLZ1VUPm/EPH5cCagPKgAP3zuvuiPM3bBXSDiRauiolym/daIzgHKLug==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3306.namprd12.prod.outlook.com (2603:10b6:5:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 1 Apr
 2021 00:37:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 00:37:07 +0000
Date:   Wed, 31 Mar 2021 21:37:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210401003705.GS1463678@nvidia.com>
References: <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB18867EC048E3E3FA37F9C38F8C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132740.GB1403691@nvidia.com>
 <BN6PR11MB40688BB2693A657D411E33C8C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331123801.GD1463678@nvidia.com>
 <20210331164621.5f0b0d63@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331164621.5f0b0d63@jacob-builder>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0135.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0135.namprd13.prod.outlook.com (2603:10b6:208:2bb::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.16 via Frontend Transport; Thu, 1 Apr 2021 00:37:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRlKb-006Yq5-73; Wed, 31 Mar 2021 21:37:05 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29d2027c-b48c-4c1e-60f8-08d8f4a64739
X-MS-TrafficTypeDiagnostic: DM6PR12MB3306:
X-Microsoft-Antispam-PRVS: <DM6PR12MB33061BD29D64B6B31596EC8FC27B9@DM6PR12MB3306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lKC97Fi/a8vhGxbSgeUEdI2buRnZ5NL2TRIjbX+unlIiufXYZi7fxvq+LGqiqYqhwDpPYwvDGBydWv3rThEcOA9xr2I7bZlKnBOJLO6vkujqpSfGhCBaLG4XuXjLcFsx8McBd0ZVhHjL6tfxRnMlzJoPWBafg7o1nvKNc4kEnctX2MVoPEDMXIgGA85TrvZKkfFWGR6DyZyJ/NwtOYZevGZ1WopXdWzcLOb6RTuLAiQqA0f1kTHFlCv7D11nf7aaN0YYThjiOIsJDljjFMCgPhKbhL+dimndzR9VybhChx9fGof3fpLvUtCePYm4vBmSpKkjyLFejbdFJFVYEjZntiSeSPuaOG0xmHCYTcJ7z0Q/LjYrCVIE6qEAH9YRIFHvkjLRYAhRWErfvm0PSYCGWUAuCS1ZSbq3QlVX9YHUa0anYmx4C9htoQZk7+Ae8OBD3KnTF+vMPqVZqJsz6puNW2pzwK/bqrSNlhiULwpWOgzuRozrLfgo1PR0zOO5S2GqJph8gyxtxNYRT/NjgPDO2Ge0+tmvXfCSJZhzcwmYdPCBSOnIMxqhyW/7XZHqenukZOrsswioeJpXU1YPwCkXqGQms9Fh/s5Ozcg8tL7rXiXyfZMEzv6dAuCo9w0yi4ao6ixzm+aAuC8r9EiJ5zBU6mbGGY80H9vrHmN3BbLAyOs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9786002)(9746002)(8676002)(110136005)(36756003)(7416002)(2906002)(66476007)(66556008)(8936002)(83380400001)(186003)(498600001)(86362001)(54906003)(1076003)(33656002)(38100700001)(4326008)(5660300002)(26005)(66946007)(2616005)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uWj5Zs5LK8i/Z/NEXKSlBgx1ouM1ad1RI3cEEIwPMx9XVi+hq2IMy7+gXoqM?=
 =?us-ascii?Q?igSvG8YcfQNG1zyB+VE/ino/qqontjG13bD7zygwAgbtR6LKsBewZeYqgvZ6?=
 =?us-ascii?Q?sM105IzwEwhuGv8vfoRtRQjKbSKnBG9JTyF4puK91yXs+qenLE0WPAsI+1df?=
 =?us-ascii?Q?BtylgRDCw/tuJts3pcZgpxn++1PqKYvUqmChU4nPdoS6vPCbGwVQB6nBBJYg?=
 =?us-ascii?Q?BxXo/OMdK/mtpN+fzTKd1qluQZQaKvNN8qzgNroK5w7jk2Q9p0exOwtHdNIm?=
 =?us-ascii?Q?ZqGi6W70tUucv9BufbqUdrA+mvQHxm7uKkTH3AjLoT4DLuxGSK8KTSORJivg?=
 =?us-ascii?Q?fXzfauMaJKyiNl2QWsLul5tv05o2ukh8nQfH6paR+fBdB2XYPtp52EzyMl2H?=
 =?us-ascii?Q?ZhuLtRQ9lPfURPyqYlPkbwXyBOUYMVel/w+yTXwnPM5ZaTBvi4xDV+KRf6aQ?=
 =?us-ascii?Q?Fc+wjw4+o//3H9pye/LKQ7X+wO26yPI/jvbdPumUmA8ujYMEbwjmK8r7e7jB?=
 =?us-ascii?Q?bi9nr9uu/LBNxOVvsYeaexGaKCQqthvxzHfLXMRxU5aftrc0xmUdvctGhkLx?=
 =?us-ascii?Q?XmYCwP6hshvrDnx2dFPpG8LAbnV/Cikyr5cOu75q8Q0TsxhPQ9NGxVGGP8gl?=
 =?us-ascii?Q?rqea8gbDfdHdOhvtHKBuitlXyN8B/pFmKzSm48bShg2WcAXSeiqYVkLEPqUH?=
 =?us-ascii?Q?NIpTe8/mBXQHyfvTPoNoLcU0FCESIeLlwQXGnuoTEwbj71Y23+/nXqhlag6E?=
 =?us-ascii?Q?LcJj1gwoVtianwqvrAji4oCo1zdANPNtaC8sNL/wMByo0rs7v07suHZvfPsD?=
 =?us-ascii?Q?ad69WFmfKvAzMBpX+cRqwifYdQX91BAQRGOB57oYhGIFHxhYQYsOxHfEqKHq?=
 =?us-ascii?Q?pyPs07jby7EYGYYXeUnWDEZ816SWf9Zlg2nT/TW2MwLmmIsnG+GcyPrwATHF?=
 =?us-ascii?Q?UsKbpzliO5E/74znaz9Alw/HsF3H0y7BdPjS6biIMhGzsRBQdTFz+k01SBQU?=
 =?us-ascii?Q?GgNdga7pRq8P4Kpun5ZCNgtPEMfGd/V9L0ls5FA14WLIM6FNvp983fbs2jw7?=
 =?us-ascii?Q?OK/YNG1UUrisuktXCqm6/nmRU0RSgs93/DWEpWvlsR6QeCgA7Nj8E7YHEyRf?=
 =?us-ascii?Q?LeX7xiajx0gRw76dxlbOu55bGnadr5jcPd6bpwJabTq2nca8jwSidP1M7J1e?=
 =?us-ascii?Q?xdRzSd33n/4emCSv5GjOmZ16mq42KzZX0iQ1yOU1UFZdRtTt96YlA2HAhrlX?=
 =?us-ascii?Q?H40Q9iC++eBbeD2o/Ew4foxYZAxMH4ACVYWkXd0HUyAZr7YKtykqwD4Z4HOd?=
 =?us-ascii?Q?KwnZFEiDiXA6jZgIV7DjtQ36VPSjXRbqq8Bz+A9E0VAEbQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d2027c-b48c-4c1e-60f8-08d8f4a64739
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 00:37:07.2234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNg/+g8bIjeHi9Cut38BSyke9JvnIhFxO3T9ooXvkIZkEfarbWtHC9XVvfaShYbK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3306
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 31, 2021 at 04:46:21PM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Wed, 31 Mar 2021 09:38:01 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > > > Get rid of the ioasid set.
> > > >
> > > > Each driver has its own list of allowed ioasids.  
> >  [...]  
> > 
> > The /dev/ioasid FD replaces this security check. By becoming FD
> > centric you don't need additional kernel security objects.
> > 
> > Any process with access to the /dev/ioasid FD is allowed to control
> > those PASID. The seperation between VMs falls naturally from the
> > seperation of FDs without creating additional, complicated, security
> > infrastrucure in the kernel.
> > 
> > This is why all APIs must be FD focused, and you need to have a
> > logical layering of responsibility.
> > 
> >  Allocate a /dev/ioasid FD
> >  Allocate PASIDs inside the FD
> >  Assign memory to the PASIDS
> > 
> >  Open a device FD, eg from VFIO or VDP
> >  Instruct the device FD to authorize the device to access PASID A in
> >  an ioasid FD
> How do we know user provided PASID A was allocated by the ioasid FD?

You pass in the ioasid FD and use a 'get pasid from fdno' API to
extract the required kernel structure.

> Shouldn't we validate user input by tracking which PASIDs are
> allocated by which ioasid FD?

Yes, but it is integral to the ioasid FD, not something separated.

> > VFIO extracts some kernel representation of the ioasid from the ioasid
> > fd using an API
> > 
> This lookup API seems to be asking for per ioasid FD storage array. Today,
> the ioasid_set is per mm and contains a Xarray. 

Right, put the xarray per FD. A set per mm is fairly nonsensical, we
don't use the mm as that kind of security key.

> Since each VM, KVM can only open one ioasid FD, this per FD array
> would be equivalent to the per mm ioasid_set, right?

Why only one?  Each interaction with the other FDs should include the
PASID/FD pair. There is no restriction to just one.

> > VFIO does some kernel call to IOMMU/IOASID layer that says 'tell the
> > IOMMU that this PCI device is allowed to use this PASID'
>
> Would it be redundant to what iommu_uapi_sva_bind_gpasid() does? I thought
> the idea is to use ioasid FD IOCTL to issue IOMMU uAPI calls. Or we can
> skip this step for now and wait for the user to do SVA bind.

I'm not sure what you are asking.

Possibly some of the IOMMU API will need a bit adjusting to make
things split.

The act of programming the page tables and the act of authorizing a
PCI BDF to use a PASID are distinct things with two different IOCTLs.

iommu_uapi_sva_bind_gpasid() is never called by anything, and it's
uAPI is never implemented.

Joerg? Why did you merge dead uapi and dead code?

Jason
