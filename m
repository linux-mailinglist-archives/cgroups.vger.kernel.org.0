Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A6F34E91E
	for <lists+cgroups@lfdr.de>; Tue, 30 Mar 2021 15:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhC3N2y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Mar 2021 09:28:54 -0400
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com ([40.107.94.88]:20225
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232134AbhC3N2e (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 30 Mar 2021 09:28:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwWqsAC0U63fjnCD4zjOe5/d4vk7VB1rrWgA5LSNXGswH3Gob6q+hRQarTKyiNzc+4g+Pmg4maDw/jl33rw3ACjUPWce6MS1enTRdEhdqrcSMJNI/qQ++lf0l6gGw7fRgFXr6M+nRsATtYBfFVJwOKoA9/3DBSeb3eM9s4wAM+1cT6lhQ97RBDcSQsynWWubnXqcA2f1pYMOsak2pPNR53OyuCYdiodu1wfYkY7l3xr15zQ0Xhb9R71xc+zA04qqgiLWBUwam/7V8PKVuq/gxJhDVRSPZxHvAQ400glIwnnIdNpaT7zDOvpYTNUFtgQ8VCL9Fzt2OLk5VbzRGOsjWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lfXl4cz1xlfHrmfQhf/BPNVzp5g63nVf/w5S4m9QTs=;
 b=i4RZXhXvAwIzB5UHeCh4tm7dcPTV7MaPW6Gb0rXAKFFbvLfyT4kDGq8CFC0LQgSFv+CCfub1KyziTpLqrkmESUdRgcbVcGk0yNPl43atFgfYv6+9Q7kjUtOB6h3RejcHiG1zTEw08FmmngeO1pdWR6ZgGACGwPwGocQBcIQljCKfj9SX04ZuLmBaPMfzVl6TClXWzZVIEe7AVL5NkK+IKcQyMQe5R27XKdON+SeKDhry6/03gci3mFa/KgoLINe+AmKgOiMb5z5G95TLldjiC7lepr7yGWZBZHR0XyXN3PH3UB9lwv3gJYGO84tgPNpID8rzx4kqKPHTu4uPxuskww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lfXl4cz1xlfHrmfQhf/BPNVzp5g63nVf/w5S4m9QTs=;
 b=HMWm9OCHunVtKheavv9nsTt8RVVxLZxpxZLN569RqvohsUTdz4dtzLIF14K6TmT+wIlXfUgla+xgWhH6+9J/eCoqxA3B9LGLvFnjIK1SmFL6hewwitGCA7JUYw1V5mfwnYSUawVRBEf9IfpnXOKeyPf8IzTQyzRM0Y7nZNmrdplg8pZ+XncsgyWLB6aheIziXDtl9bBg/exNcGS2rBml2A9mo/D+ZJbp3uOyB3ZnSbhVpxfjFhhxKG3wrfIp9Qe7GEgnXoPIZkGX2Vzyc7RLUhS/bXIncma534NbwPqRbculbqXbZjKDC07Lj6brbXBdbygXzDmIhtBRc6BZyU5Wmg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Tue, 30 Mar
 2021 13:28:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 13:28:32 +0000
Date:   Tue, 30 Mar 2021 10:28:30 -0300
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
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210330132830.GO2356281@nvidia.com>
References: <20210318172234.3e8c34f7@jacob-builder>
 <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com>
 <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR15CA0066.namprd15.prod.outlook.com
 (2603:10b6:208:237::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR15CA0066.namprd15.prod.outlook.com (2603:10b6:208:237::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Tue, 30 Mar 2021 13:28:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lREQ2-005tMM-4d; Tue, 30 Mar 2021 10:28:30 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e05964e3-d021-4fc6-1a20-08d8f37fb657
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB020337D4867584544442FCA0C27D9@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jgTqikKe1Euvj1SaHYkSKG7f4nIsAiVxXRINx86CHSAE5o9smkJ1ZcCtlV0QDC2kT7ic1HTGZ8XoVJquNZMrZTNqdulDDUxPELxWv7PIdZC4Qe5lKuOokv0oh10T0k/4/sf4V4MXEwC4FTnLwFAS2z8cEg1c3x1FepQTj6AV1omhMHeBNsdVVWP62byPMY/arLyloeG4YZbIwi1uHr0/hMHa1f9054Uh5LZcZhRDrst7vftRoAzPXcGXYt6dVstkeEMtbJJV/IpUOkoKkswKEdD0Qo33U2vMfp3tP8fNW1axdqhKjJDU5Wbu5pXdyN7NN/no0CBVvx3ijL9jROFhBSRqB+AeEn2DJh13XbV2HkQHtOi5f41BQYk5OcQRMa38OIjdtbDxDsCmhhl3H1HkM45PHAC3/KTEmsLSgKGbU1n+Vqz6i4Tm2nL4hEZfIiQYTrDq9kdfDN9N4zlQ7cFGGFRB7BCvxfV+4zPba/lylT0LDQkiIQ13rlF9KcJpR2SGCQla8Prwufk/KCBR8uXqa2KIe/YAlncOuLFG9EU4jJjsSMsFau8dO+z0EhWtBrnMIQxqhNrSKLtZKnQOrlYO2fVHDKMPxrtrR4+5YadObTTl68ht01Xs/tJ3WrdzlP7bNE3wBVHZOR2tDERC7TVmOc3houKoJ2yHeWzWrzGSAoY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(4326008)(2906002)(86362001)(9786002)(186003)(66476007)(66946007)(36756003)(66556008)(26005)(7416002)(38100700001)(6916009)(83380400001)(9746002)(33656002)(5660300002)(426003)(478600001)(8676002)(316002)(8936002)(54906003)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Jrt75crcFFrKDhuFNEZNAFN7wa57vxIiU9aIc2LUAGEYinrszl6XuF3UEa5N?=
 =?us-ascii?Q?/GWooP+86lYxoAbJOUvf4QeTA1ycL1hfaGrk0SBIREUO+kYBOKhDO96Y1bze?=
 =?us-ascii?Q?kCYtjrlpFWcg+8bHSU0QJvOgsaemIGjU1qth8CGD7WCoDdwwNekNuFk7Rl32?=
 =?us-ascii?Q?MsbyLG0TeAqwQIoqG/ZSOPqM2HiXkbW6PAljhbOClbVpN/ekYAIH8qRATmA0?=
 =?us-ascii?Q?QwxEzYmdrXLbGAzzCwJk3PDP+dNp442n3hQBVnvOx1rGceZIKdf7r+LhJHHT?=
 =?us-ascii?Q?aliDvOWG+SiDKorIwkv9HJFqQBQ9GA1EOflp1Z2B/qQQrX9wWMwpjTXG0SEE?=
 =?us-ascii?Q?wVuTLAzBeHp6lYinZhODBqhTZmZYmsCPvM40+158ifroufFHPZbnMVfjCXLG?=
 =?us-ascii?Q?INPAZT0mVPfV5FjuF6HoYmxbKAtCQe+d/8m/Arv57Wn4OkXOxO7jpV7423Lr?=
 =?us-ascii?Q?WrJhLx8fx6F+oKcWzrAvqMRtpWUcNzXYakvi0s8971BDNEwC+wtDusj6ZRP7?=
 =?us-ascii?Q?a1jhTE3YWZQolp/O3iyNh6K0IC+NX9rvjv2WMmqIJ4klYXpNdRLWkWfWXJhg?=
 =?us-ascii?Q?rhIXVGAPnRNkHKP6oO14UfzS79GFSP+4VAbPyAsAjlNpQb1S8nYeUMdfn4oe?=
 =?us-ascii?Q?acmDh4+dUnjt/9bTcn+uBpTnKpwwQnKZDaHEt1pLFQBzTA9u+TYA7+w2Q9AT?=
 =?us-ascii?Q?/iXo2n9oWHs0RemyW8+pboUtfVKt7CKXe8Wi1Us6bPk+8xJSwHg1snnN22hG?=
 =?us-ascii?Q?MFu2W39+GKvIzjR7TfvcmGmftqdIx+voB9N7KP7TdqFNTi0BRbMZzbrgdJIN?=
 =?us-ascii?Q?zZhNd+P3RGalyyg3/k4V5/jKCtOONDdOlRJyrFJV4tUdREcoUMxk6puLfxpu?=
 =?us-ascii?Q?rqI7KDecpFwI5+M1KWhmjzombXPRv2JVO/QX0F3yM/Fj7nN9mVOU5PdCBXkm?=
 =?us-ascii?Q?wAbEmgKuC5IDal1oVN6TUqRbuoO+zCC870crXRyHEtthJRNkTAAaQSCwkA65?=
 =?us-ascii?Q?bOzqi134V4Vb+0UdvK5g4JgZxpd/CU4dWbxhuPMISYQ7nTm6gmdv35Of2jm8?=
 =?us-ascii?Q?j7NfZZ/H2kW2qgGSrqgSdJePPuxEJgs88LZb6ZGRaOCBd89hPnSnAFbjYPlm?=
 =?us-ascii?Q?9szmEwubwC4g/CqDN01KftkvBVGVcRTBzqOdmAkyyLUZb5Q6wGYHi4sO+5ms?=
 =?us-ascii?Q?lE96A7m7yv8zUZiLF8tKNcdWrClCL/k5HAmuHb0kt4i56Pzj2nxkkxnaZK81?=
 =?us-ascii?Q?IjOHl2nmvLQpPo3n7CIDsEJYSBs2o+ThCrr+Jj7ZvhGKkfjHck4ErxwC+bBk?=
 =?us-ascii?Q?4UUkNPuf63MAScnM3UwuQCw5l5p7f+0KZhoNy2cQdzGTnw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05964e3-d021-4fc6-1a20-08d8f37fb657
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 13:28:32.4249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHxzVB9Wbk9oOZkVx8ZM3yTZyLW8c8sXc+KQMlxpHodwolckjvyGW0Jkvqv92Y3E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 30, 2021 at 01:37:05AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, March 30, 2021 12:32 AM
> > 
> > On Wed, Mar 24, 2021 at 12:05:28PM -0700, Jacob Pan wrote:
> > 
> > > > IMHO a use created PASID is either bound to a mm (current) at creation
> > > > time, or it will never be bound to a mm and its page table is under
> > > > user control via /dev/ioasid.
> > > >
> > > True for PASID used in native SVA bind. But for binding with a guest mm,
> > > PASID is allocated first (VT-d virtual cmd interface Spec 10.4.44), the
> > > bind with the host IOMMU when vIOMMU PASID cache is invalidated.
> > >
> > > Our intention is to have two separate interfaces:
> > > 1. /dev/ioasid (allocation/free only)
> > > 2. /dev/sva (handles all SVA related activities including page tables)
> > 
> > I'm not sure I understand why you'd want to have two things. Doesn't
> > that just complicate everything?
> > 
> > Manipulating the ioasid, including filling it with page tables, seems
> > an integral inseperable part of the whole interface. Why have two ?
> 
> Hi, Jason,
> 
> Actually above is a major open while we are refactoring vSVA uAPI toward
> this direction. We have two concerns about merging /dev/ioasid with
> /dev/sva, and would like to hear your thought whether they are valid.
> 
> First, userspace may use ioasid in a non-SVA scenario where ioasid is 
> bound to specific security context (e.g. a control vq in vDPA) instead of 
> tying to mm. In this case there is no pgtable binding initiated from user
> space. Instead, ioasid is allocated from /dev/ioasid and then programmed
> to the intended security context through specific passthrough framework
> which manages that context.

This sounds like the exact opposite of what I'd like to see.

I do not want to see every subsystem gaining APIs to program a
PASID. All of that should be consolidated in *one place*.

I do not want to see VDPA and VFIO have two nearly identical sets of
APIs to control the PASID.

Drivers consuming a PASID, like VDPA, should consume the PASID and do
nothing more than authorize the HW to use it.

quemu should have general code under the viommu driver that drives
/dev/ioasid to create PASID's and manage the IO mapping according to
the guest's needs.

Drivers like VDPA and VFIO should simply accept that PASID and
configure/authorize their HW to do DMA's with its tag.

> Second, ioasid is managed per process/VM while pgtable binding is a
> device-wise operation.  The userspace flow looks like below for an integral
> /dev/ioasid interface:
> 
> - ioctl(container->fd, VFIO_SET_IOMMU, VFIO_TYPE1_NESTING_IOMMU)
> - ioasid_fd = open(/dev/ioasid)
> - ioctl(ioasid_fd, IOASID_GET_USVA_FD, &sva_fd) //an empty context
> - ioctl(device->fd, VFIO_DEVICE_SET_SVA, &sva_fd); //sva_fd ties to device
> - ioctl(sva_fd, USVA_GET_INFO, &sva_info);
> - ioctl(ioasid_fd, IOMMU_ALLOC_IOASID, &ioasid);
> - ioctl(sva_fd, USVA_BIND_PGTBL, &bind_data);
> - ioctl(sva_fd, USVA_FLUSH_CACHE, &inv_info);
> - ioctl(sva_fd, USVA_UNBIND_PGTBL, &unbind_data);
> - ioctl(device->fd, VFIO_DEVICE_UNSET_SVA, &sva_fd);
> - close(sva_fd)
> - close(ioasid_fd)
> 
> Our hesitation here is based on one of your earlier comments that
> you are not a fan of constructing fd's through ioctl. Are you OK with
> above flow or have a better idea of handling it?

My reaction is to squash 'sva' and ioasid fds together, I can't see
why you'd need two fds to manipulate a PASID.

DEVICE_SET_SVA seems like the wrong language too, it should be more
like DEVICE_ALLOW_IOASID which only tells the iommu and driver to alow
the pci_device to use the IOASID.

Jason
