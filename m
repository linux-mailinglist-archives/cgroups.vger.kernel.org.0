Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C26B351899
	for <lists+cgroups@lfdr.de>; Thu,  1 Apr 2021 19:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbhDARqI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Apr 2021 13:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbhDARlA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Apr 2021 13:41:00 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB9DC05BD21;
        Thu,  1 Apr 2021 06:01:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvSyXFxzJ/eaUP2Wd5uuxUMf/uCNHXrBHiXWELP/rzDpc/cNAz+y3IUzwasi4b6GJGDQAK9xiphm//hLuJI0OARRCl+GIf3MUyH2O/Cdhjh+pZnJVQvo5lmk6Spp894vjX0K5ejzr+EYGtE9trsZKKNPEB6Rc+1yVU0MU+GUI+fTBUHBJgET2PkK8FOyIFM6ATb0H06HWPgQXKW9NRnk9NCBApkN+B4M7oiq9UzIz5UhXFUt25lt0MAOzsBuJEAs8UZGLiQ8L9/91tCVRrN0/IYywBZ9pxB051ftBZyfsyJjTlI9tl6rGfBFc5CatiBZfpmwSouCXkQNaJmLDTpklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB7ETdOOSqNiwN0jeb2a8uAGrb0Crvt+uIkVaGv4B/g=;
 b=iNTD2d9PSQ3YxIioKfVUJ4p3Fznn0fNMpifPXj12HqeyJjf7xB2x7w8UAtPdjx2P41aeRZMuPrx2Cu9BqqdUZe5gB0u7GVmrAYQDlGxe69JWeMBVy3jVu0Dtd5BfLCoX+atp64B6BES03Yoi0VhrH4rSjQ5is0DoBr5KAFmMBMEwvQ+F5X8xg42MhTdFNI5wWGGSca1kLmqWiKyT7gRouyyEbnc1YBML2DjUiXdbu8R4UvN9h03f24qhZdcwpqYO8nDU7h79cKxcamqFJjpGLu/mRx5KQll/Cnerk5FOKQVAEGTFq1pWtfRRqEfbJ0Xyfm903Vvj89apC2jHXkHY3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB7ETdOOSqNiwN0jeb2a8uAGrb0Crvt+uIkVaGv4B/g=;
 b=iPfpRV6LrLzrf5O/1m9biJLk5b3xUOR8KcqzPKhAFyra/baTxbPBO/0Kc4FB4veUdsq1yVW12xIbp6vQ/BzQ/8L0jTNql+s6h/IxwVZMW0E+x13nxwYrD0B13Wll2lQ2kPnb77zgwB7wb8j3I976TJ41A4fms0xMvs7ykQtJcdhiRDicRyDHSwIJ6WkAOvztq0dx09g7gWTWyxbQGSCO8oAdi8yJI+Vmp6kCDLW7iYlEGOi8pbeLfV8VBNaMbL6Yl8pGRmhCR9/N+qTkTNg0qXqUWVvgV5wzlaAH9rrfuFJlZNk5+nr66vhCw3zNQ9sr66wMS5WFppRNQMz8BqVY/w==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Thu, 1 Apr
 2021 11:46:50 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 11:46:50 +0000
Date:   Thu, 1 Apr 2021 08:46:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
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
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210401114648.GX1463678@nvidia.com>
References: <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0384.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0384.namprd13.prod.outlook.com (2603:10b6:208:2c0::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.9 via Frontend Transport; Thu, 1 Apr 2021 11:46:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRvmi-006j6M-4H; Thu, 01 Apr 2021 08:46:48 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c07f9a3e-b78f-440e-06e5-08d8f503d5fc
X-MS-TrafficTypeDiagnostic: DM5PR12MB1884:
X-Microsoft-Antispam-PRVS: <DM5PR12MB18847B5208F8DBE4151E06E5C27B9@DM5PR12MB1884.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5MaWb4gjwcgh4Wl0+ohnyg6PdPGI7q/qOu77yGP1+2eLDBIlF3aJ+nXVHs0KxdaIO6xZMNe7A0yNFch/+brjyOE3CeRbbgYJuJNHC0Tadao28d/dD8/INNvrDAIxCIw8y3kYepBqlCGtwLsPH2LqM0NxHWjZktX0Mph2MT5NL6TI2Orrk9/TXDsaXXATkau87HB6NHA9Pq/3EYDJyKnR1uW6AfwJlQvqww5/r/dC6pqPCwz6t7dpopXdXbPZmyroculQrEKWjL+/O7rkva/oNGX102tM6VlX5IYp8j6HrTTboZGZMOgzkXmjZcXGbXsCfRvtQ96pqGS8Act8oWGEaQG+5X6HXbF5pzjbib0KfP9qGfCW3Qt2H6OETVTYxyiorttKz5cG/n95GOWzm1HjqhCv0mt6JXxoQDaF/Km0ALlh/MHQTzJLAJf3wvZ5yLHR/+/FfCz2MjMEjlHCSQlr7/cjPxXCrG2GVN3SYqZvrDJLULymikEJ9akLW5CKnh9zAeE3EJPmvOxSU33jo2At+9YN6JHlRLeUOOABRmrKE6/cpPu1uWvBBOMQ0G9KLUPtp55ueRVvrSc7Kweh+N+e/YtlC+XdwfVf8qaiSAnivAuixb4OiJAlw3oEsubmOEYzJ2BWyGWfvzsAMWNY8mBdIhriizqE7/j+t4YO1YP2OA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(26005)(83380400001)(8936002)(4326008)(6916009)(426003)(2906002)(478600001)(66476007)(9786002)(38100700001)(66556008)(66946007)(9746002)(86362001)(8676002)(33656002)(1076003)(5660300002)(36756003)(2616005)(7416002)(316002)(54906003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?V4GcDEQu7Z+V6pQGKMi57Nag6rWfAu5Sgf7jho0/ZOYWhUBcLtrbBen00Jff?=
 =?us-ascii?Q?XbhvnwF0SUQoed7d4a3STJ2uQzhNwDGy6JnsWEcTwGgRerwtwA4GKPMg0clW?=
 =?us-ascii?Q?L+/NwAhj4fm+qVz4LLDtviuthWCJ0D2EWDOYyqqp2evpRlYC2QKUwLbyAfXL?=
 =?us-ascii?Q?SbHfuv9kC5Rqkh0YWRrTczcBzv/mx/LB38hohrckDuCIyN+73FA0+lCdFi5c?=
 =?us-ascii?Q?CzIX/9RZdZy0FWSNS46zhXM5qqQNkGTdNDKIH2TVxNCfPpDu8pr9cbHfQK6j?=
 =?us-ascii?Q?pa6Ix/Ulj4htNJE9Pnww8o/qV4DIrPpqAX4jQFUWOEsE4PKt9inJhUoTEp6J?=
 =?us-ascii?Q?18k3ssmltyNSGHhNbgN6gInYiKPG+cl4EHyJghlUXC+txdIPSn9DFx5cb/D1?=
 =?us-ascii?Q?dilcNJ6Dt9jypZ5PHI1FXCYWr7IQv2+GvII34mP3pBfEt4OpJURBwGm/A2RI?=
 =?us-ascii?Q?8GSeAMtUm2OXZfGKLt1vzO6/F0LU3yYh2hH1VvY1m5WPveunhf8awJyu2n8s?=
 =?us-ascii?Q?MjG2KpYUkdrvnhdsrERUklFUSCFFoTNrjwnWsZV2bMP1g0OB9Mji55s4yS4/?=
 =?us-ascii?Q?OZ/rdRbQtoolozz7SNs/eIM1F1MTSKPd5vBo4zIV/YKXPUq89PL34zdccCkx?=
 =?us-ascii?Q?Fja9hj2PRrAGyJZZC3ESDGyuZQP4LavAmi8Vswf/FW8kznPLq42a3k3TtxiE?=
 =?us-ascii?Q?ZcQzkiP1SBcA9w79fk/uj111NNmv11cT+q50OHqoIsgvJ6+Cy2sbW10UZndz?=
 =?us-ascii?Q?lS1f1GTS0FnCNeIKWuWpm2uOHWtWIj0veZSEquKmpjJWeAV3/dHU0gpsXevz?=
 =?us-ascii?Q?u878ucVMkH8Yq4zZY5+6NN4o+5R37PJKM5/dFlHu+VuyDjUKuIDwAJLepGhk?=
 =?us-ascii?Q?kycN5fln4ctdaZHoGgXOhPgQHnYD7EJUInQZQwy9syf6j/lJDwVoQoEydp9V?=
 =?us-ascii?Q?PpBbOsKQYzkFoi/GjF2KlEGoRl5IxJqIA556pN/5tYLQGBIVikRCe4aKzrmX?=
 =?us-ascii?Q?qJaXDjnPuts9aeR5hl1Ok3/HKHba2CcFMsjdujy/l81MOUDTvKcWE5SUttmU?=
 =?us-ascii?Q?VY2OUtRgEpLPoa2t0BfmwdxT//ZZKacFZHo2DtAj2luGxU7C+m9dmncy3SNt?=
 =?us-ascii?Q?i3X438FgTnYstDa11q2Zpb0LZUa3MBUpXujWg34dMwmFzNK+ZQ+W+C198bqb?=
 =?us-ascii?Q?2b6dLNFolbC6sSaTqsH7P+bFxZ1/ssNmzj4CLtoVoCFSU7iZeOiNliOQCL0D?=
 =?us-ascii?Q?bc7Og8o9MjX9GN9eEYCTRxgOiTD3hMJoorWc0PzWwFBNJ9iNwU0lcDEtMYIF?=
 =?us-ascii?Q?rlW7uLp38/ZF+veljmUWC7zpi7LMPFTrFAcpV+1gditYdw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c07f9a3e-b78f-440e-06e5-08d8f503d5fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 11:46:50.1573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +g/TTE7GfYiMg5BZNhN9UQels9Cd8ERUxLsh7GIMvGBiL4gY+B0ogp6h9cgeien+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1884
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 01, 2021 at 04:38:44AM +0000, Liu, Yi L wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, March 31, 2021 8:41 PM
> > 
> > On Wed, Mar 31, 2021 at 07:38:36AM +0000, Liu, Yi L wrote:
> > 
> > > The reason is /dev/ioasid FD is per-VM since the ioasid allocated to
> > > the VM should be able to be shared by all assigned device for the VM.
> > > But the SVA operations (bind/unbind page table, cache_invalidate) should
> > > be per-device.
> > 
> > It is not *per-device* it is *per-ioasid*
> >
> > And as /dev/ioasid is an interface for controlling multiple ioasid's
> > there is no issue to also multiplex the page table manipulation for
> > multiple ioasids as well.
> > 
> > What you should do next is sketch out in some RFC the exactl ioctls
> > each FD would have and show how the parts I outlined would work and
> > point out any remaining gaps.
> > 
> > The device FD is something like the vfio_device FD from VFIO, it has
> > *nothing* to do with PASID beyond having a single ioctl to authorize
> > the device to use the PASID. All control of the PASID is in
> > /dev/ioasid.
> 
> good to see this reply. Your idea is much clearer to me now. If I'm getting
> you correctly. I think the skeleton is something like below:
> 
> 1) userspace opens a /dev/ioasid, meanwhile there will be an ioasid
>    allocated and a per-ioasid context which can be used to do bind page
>    table and cache invalidate, an ioasid FD returned to userspace.
> 2) userspace passes the ioasid FD to VFIO, let it associated with a device
>    FD (like vfio_device FD).
> 3) userspace binds page table on the ioasid FD with the page table info.
> 4) userspace unbinds the page table on the ioasid FD
> 5) userspace de-associates the ioasid FD and device FD
> 
> Does above suit your outline?

Seems so

> If yes, I still have below concern and wish to see your opinion.
> - the ioasid FD and device association will happen at runtime instead of
>   just happen in the setup phase.

Of course, this is required for security. The vIOMMU must perform the
device association when the guest requires it. Otherwise a guest
cannot isolate a PASID to a single process/device pair.

I'm worried Intel views the only use of PASID in a guest is with
ENQCMD, but that is not consistent with the industry. We need to see
normal nested PASID support with assigned PCI VFs.

> - how about AMD and ARM's vSVA support? Their PASID allocation and page table
>   happens within guest. They only need to bind the guest PASID table to host.
>   Above model seems unable to fit them. (Jean, Eric, Jacob please feel free
>   to correct me)

No, everything needs the device association step or it is not
secure. 

You can give a PASID to a guest and allow it to manipulate it's memory
map directly, nested under the guest's CPU page tables.

However the guest cannot authorize a PCI BDF to utilize that PASID
without going through some kind of step in the hypervisor. A Guest
should not be able to authorize a PASID for a BDF it doesn't have
access to - only the hypervisor can enforce this.

This all must also fit into the mdev model where only the
device-specific mdev driver can do the device specific PASID
authorization. A hypercall is essential, or we need to stop pretending
mdev is a good idea.

I'm sure there will be some small differences, and you should clearly
explain the entire uAPI surface so that soneone from AMD and ARM can
review it.

> - this per-ioasid SVA operations is not aligned with the native SVA usage
>   model. Native SVA bind is per-device.

Seems like that is an error in native SVA.

SVA is a particular mode of the PASID's memory mapping table, it has
nothing to do with a device.

Jason
