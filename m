Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B3D367578
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 01:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243929AbhDUXDk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Apr 2021 19:03:40 -0400
Received: from mail-co1nam11on2080.outbound.protection.outlook.com ([40.107.220.80]:22144
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232642AbhDUXDj (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 21 Apr 2021 19:03:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgU7nvZH/IeGc4yMv1KdPYkry7bHmzosK7TRxE2CaiQgeitHlUvjh6G9gURq3lrzGFuMMUFIDtpTK5zJPgopqsWJR91Ao39Or6TYQ9NGdLjp+JA0viNmipiehQyZx3GEF2idF0MQKah6kJrlQmvn0ei2BJpKhMn8EyP7G6iIezr9/QfqEwfRwVkiC+r5u8XT82m4N0Yg3Lfave2Vp8QYg80DFajWeTCC+AZxneg4YeGKiQDpQf2OSLh3eQRpkC002bQFiS7bhbE/UbYu7VHCSnnOPjREhynoYWhW/6j0X0o3rhfk65a9U+bZAiu9bVA9bO7iXxZBMK0yDOvlG9f9Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHy9OoWejvcw0XJuDfiajqiWpMWOLWv8yaffxEbZQmo=;
 b=UgFMLVnbO/a5pyhGQEoB7ZKOq0aqGcRDPh22D/RQO3nqnfE3hEmUlJRUE0CKiICoV4QvIEsAxwDWmcRcC2yTsV9uyc+d0y0AJm/zjSmWtHUHISakr3eSCiuy2Qz4RVhQ5AVLIIXGNSckeyACvoRfzK/dl3wbxdVN98s5/Bcz9CqNbsQNZnG1pHQa5Se2SLQGa15+VFSjeM5uj2d9Jyd0g5mzFx8MBxVvr0wE+nPRxTSfxR9gQ8e35u60+SbgnL8lnWEsHd+tAQDS/PAlqPb23MA4TC6OX3NtYQlNID7Q/3CbFpOVJiXjWJ/yFU9IXqIMWbJJ7hgDzYMHf9EwqlvenA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHy9OoWejvcw0XJuDfiajqiWpMWOLWv8yaffxEbZQmo=;
 b=HO08NuFMflY8iUhDr6jteD79+aJmwBSp/cD9UhkqUykvqFaQ3egzYWtfrgXuNp3z9RWg5yGR9NT37q6fII33oijwi+kKFhpMQisD0PVfVD5k75vQbkCoqjIx+P8RzMKtVU7MRZNDTBOZBksuahNEzVo6XaLWIErewvgosEixQO1+BTocuJfoCd7Ubii8hhZEhrjhumBz2vXT8Y7KFZVAfhqqOAMdRMohgAIytGR3Wb+FRc8YNnV1ogaouge9G09qwP6txLvn9BGrtWY0xBnbZlU+A22aqco3DKTXLZ6yC63l7fqSOipGWb110iexQxSdOoCbFMEWhxLnPyHvwrbrdg==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Wed, 21 Apr
 2021 23:03:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 23:03:04 +0000
Date:   Wed, 21 Apr 2021 20:03:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
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
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210421230301.GP1370958@nvidia.com>
References: <20210401160337.GJ1463678@nvidia.com>
 <4bea6eb9-08ad-4b6b-1e0f-c97ece58a078@redhat.com>
 <20210415230732.GG1370958@nvidia.com>
 <20210416061258.325e762e@jacob-builder>
 <20210416094547.1774e1a3@redhat.com>
 <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210421162307.GM1370958@nvidia.com>
 <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421133312.15307c44@redhat.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR19CA0033.namprd19.prod.outlook.com
 (2603:10b6:208:178::46) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR19CA0033.namprd19.prod.outlook.com (2603:10b6:208:178::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 23:03:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZLs5-009gTo-Ld; Wed, 21 Apr 2021 20:03:01 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3adefdbb-31a1-43cd-4238-08d905199df0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3305:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3305354233E9D38EAAA2EA2CC2479@DM6PR12MB3305.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gmlZ8b5oB0NwMs1aKZow2SJZ5P4UZxLuGexRWIsZATgQV6N9F3XuSOSgbUtCUPMR4Y63xl1kEYBSL0KCvhAwOAIXj6JXgWT+jzTvE7rdzwnupX/hizz6LJ4pXfpziYOqGxS1M41TIjMBVKX/Kph49mkovOdNxBRtFsicMoXLo+T3neNZC5eJaMFBdlxLs2RJyjSNppvenmZrgE7w6u2aozzYvrRVdUrtsNLEwIwVvngnyCR1IHJyzvwaHOXPt7tMWbr7jD4neSQXk//Vxl7e/QSXiQHEjNWxWekkOgQbA8ZhCH9gUJb8EKFM4VCmwOr9b8voE8Olr5fKlhVq2f9z3mhcuSx9BBUJ6l3SwWAa6JJAHMfE/uww109RKyLVlB6Oemj+hKclfshkpe6SULYr+kOxsge0eusMBC5g7d4dMCGPkv1iNbr9al3S8jGVwsUE4QXh05YXVU3ZfzYRzEPkNwDqUkTzYaHiVT3mcJRVFcLBUrGqGFppBskV4gTJjwX60E20/wI3Da/KrkZPnNU3Yi6hsXtKJjfsCqf1qTWrBw4ra0x3Qqc94Fzw2sZRRueNvZwNX+80mZrhYtNaQut4D/u1HHZmkz1ruCV3zOsWo5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(2906002)(54906003)(316002)(4326008)(2616005)(36756003)(66476007)(66556008)(66946007)(426003)(6916009)(86362001)(5660300002)(1076003)(8936002)(38100700002)(33656002)(9746002)(186003)(478600001)(9786002)(83380400001)(8676002)(7416002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sgan8NEYmUMcOo/JIWTNsEDdPjtAqAo5pVTgk6HLOE3fR3kwx4CZH+xtiZRs?=
 =?us-ascii?Q?TTteB+H32SUrnKRFgg/YdrxA7gqWGf2i9uYDzWVbDk3Es0YQHF01H9bCHrWC?=
 =?us-ascii?Q?VAscJDKhB8Nxdr3BlcKE4oLzwQsEZ+89QXwBAB1YQFi4QVKWlS84i1Ug0xTN?=
 =?us-ascii?Q?3/YKjf/ZLeJ09MgoBgQwk2AoMNq26zq9Q3UjKwVLtoglsIfulOhIw+kkYKNS?=
 =?us-ascii?Q?VNxnOPh5ctAZetpEJhtprG6/QjvguCIsUp2HloqrPZ0tcOxsy0DBIScPsczU?=
 =?us-ascii?Q?Va9mQ0dXk0RwfRCYL8emZt2fUfpRDQpa1X6oe95IlVCz/Wsj5m00MbLjm1cO?=
 =?us-ascii?Q?kuH6TGpp7cUznhMRq72yS9ioK4umfhQuEsrg3tx1JXUd1Fm5uRvw9lX7vKzp?=
 =?us-ascii?Q?bFPoxb534FqG3Fq02CQIvNEzyj2cGEYk79K53Zq129qgAyEXJaD2HnaUCD97?=
 =?us-ascii?Q?OXUORcEZHglbp9r+ncxAGFCiPB/GJpabd+eOP2SE07lpUnsWRu0WB6Uee0xx?=
 =?us-ascii?Q?GR5DP6+WPTcwD9NrJPtTLjdSSwkPQU7vz2Vr7v64GzHCBOO4hZJot0i62SYA?=
 =?us-ascii?Q?DbWtYRMNYl1mUKDgwSaCuX92NKBZ7VgJgErkoPCXpywJZjXeEX9ac0LXRTWT?=
 =?us-ascii?Q?9yHaGvx7qoqJLywOc0dWbNaMoLvRNANSI7l5LIvBgG9s2a5ezbWuQ73BzaB1?=
 =?us-ascii?Q?VKnVuR/q7QTz347no+sVu8w7eOuy6QbswTZVIyxswd4COZO9vWuZ/J17VPsE?=
 =?us-ascii?Q?mqhzAUZnj65RGyAMI1Z3y5AKkC4RvHH1T5gTtuiqYzP8BEe9FgBuWSjv9etP?=
 =?us-ascii?Q?R9Zt8zKZV5plJ9ubnQmqlUVneMYSY8yhMRvy6wXIevmYGOpZoqAGG461b1wP?=
 =?us-ascii?Q?r8Eh66GijyZO+nL+M/3vTFAPSM41N8V+MnJqmFt3TsNqRompZAHC1YM+ilNE?=
 =?us-ascii?Q?h1uqW86iw+zJbjwY48FEUGnNivPx9fl0/B745UUTuIM9FEiaYF43zZYAzFZD?=
 =?us-ascii?Q?mrrdGSP/1vyz3al4etFEQsZTQFTqtuqDcBjep1ZExll7cIfjw1utUgoJs7Sc?=
 =?us-ascii?Q?sJncadVHSO660L80dBsXQ2387BEV64AL6B0xz1RKSmbpqAO6JCQafawXCrpO?=
 =?us-ascii?Q?w8sy/aSICII20QsxSQwty8QH0IeE1Yq7mXAsE9psK5uyihuJBXjkbw8Wi4gT?=
 =?us-ascii?Q?KkFSLnwr5mMKAeTW1sgBA9jaVgVmuZLCbqH5igDcrkINNvtdO4SbaQschmkc?=
 =?us-ascii?Q?4UtymdAKkwRztNENpHsJu0Wqb1mwY7M5O02MFRlSEuvUO5I1RWYDOBodosVA?=
 =?us-ascii?Q?4b6gRks1eF4coV6cTqjB50dCVX3XxMxrLWvsu54X0PDoog=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adefdbb-31a1-43cd-4238-08d905199df0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 23:03:03.8601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXrgNoHuzuShJ0K14rrUqH7DFZsh5ix9K2rrGM7tNYIO2MPqKSG2mvhkM6vR58jf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3305
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 21, 2021 at 01:33:12PM -0600, Alex Williamson wrote:

> > I still expect that VFIO_GROUP_SET_CONTAINER will be used to connect
> > /dev/{ioasid,vfio} to the VFIO group and all the group and device
> > logic stays inside VFIO.
> 
> But that group and device logic is also tied to the container, where
> the IOMMU backend is the interchangeable thing that provides the IOMMU
> manipulation for that container.

I think that is an area where the discussion would need to be focused.

I don't feel very prepared to have it in details, as I haven't dug
into all the group and iommu micro-operation very much.

But, it does seem like the security concept that VFIO is creating with
the group also has to be present in the lower iommu layer too.

With different subsystems joining devices to the same ioasid's we
still have to enforce the security propery the vfio group is creating.

> If you're using VFIO_GROUP_SET_CONTAINER to associate a group to a
> /dev/ioasid, then you're really either taking that group outside of
> vfio or you're re-implementing group management in /dev/ioasid. 

This sounds right.

> > Everything can be switched to ioasid_container all down the line. If
> > it wasn't for PPC this looks fairly simple.
> 
> At what point is it no longer vfio?  I'd venture to say that replacing
> the container rather than invoking a different IOMMU backend is that
> point.

sorry, which is no longer vfio?
 
> > Since getting rid of PPC looks a bit hard, we'd be stuck with
> > accepting a /dev/ioasid and then immediately wrappering it in a
> > vfio_container an shimming it through a vfio_iommu_ops. It is not
> > ideal at all, but in my look around I don't see a major problem if
> > type1 implementation is moved to live under /dev/ioasid.
> 
> But type1 is \just\ an IOMMU backend, not "/dev/vfio".  Given that
> nobody flinched at removing NVLink support, maybe just deprecate SPAPR
> now and see if anyone objects ;)

Would simplify this project, but I wonder :)

In any event, it does look like today we'd expect the SPAPR stuff
would be done through the normal iommu APIs, perhaps enhanced a bit,
which makes me suspect an enhanced type1 can implement SPAPR.

I say this because the SPAPR looks quite a lot like PASID when it has
APIs for allocating multiple tables and other things. I would be
interested to hear someone from IBM talk about what it is doing and
how it doesn't fit into today's IOMMU API.

It is very old and the iommu world has advanced tremendously lately,
maybe I'm too optimisitic?

> > We end up with a ioasid.h that basically has the vfio_iommu_type1 code
> > lightly recast into some 'struct iommu_container' and a set of
> > ioasid_* function entry points that follow vfio_iommu_driver_ops_type1:
> >   ioasid_attach_group
> >   ioasid_detatch_group
> >   ioasid_<something about user pages>
> >   ioasid_read/ioasid_write
> 
> Again, this looks like a vfio IOMMU backend.  What are we accomplishing
> by replacing /dev/vfio with /dev/ioasid versus some manipulation of
> VFIO_SET_IOMMU accepting a /dev/ioasid fd?

The point of all of this is to make the user api for the IOMMU
cross-subsystem. It is not a vfio IOMMU backend, it is moving the
IOMMU abstraction from VFIO into the iommu framework and giving the
iommu framework a re-usable user API.

My ideal outcome would be for VFIO to use only the new iommu/ioasid
API and have no iommu pluggability at all. The iommu subsystem
provides everything needed to VFIO, and provides it equally to VDPA
and everything else.

drivers/vfio/ becomes primarily about 'struct vfio_device' and
everything related to its IOCTL interface.

drivers/iommu and ioasid.c become all about a pluggable IOMMU
interface, including a uAPI for it.

IMHO it makes a high level sense, though it may be a pipe dream.

> > If we have this, and /dev/ioasid implements the legacy IOCTLs, then
> > /dev/vfio == /dev/ioasid and we can compile out vfio_fops and related
> > from vfio.c and tell ioasid.c to create /dev/vfio instead using the
> > ops it owns.
> 
> Why would we want /dev/ioasid to implement legacy ioctls instead of
> simply implementing an interface to allow /dev/ioasid to be used as a
> vfio IOMMU backend?

Only to make our own migration easier. I'd imagine everyone would want
to sit down and design this new clear ioasid API that can co-exist on
/dev/ioasid with the legacy once.

> The pseudo code above really suggests you do want to remove
> /dev/vfio/vfio, but this is only one of the IOMMU backends for vfio, so
> I can't quite figure out if we're talking past each other.

I'm not quite sure what you mean by "one of the IOMMU backends?" You
mean type1, right?
 
> As I expressed in another thread, type1 has a lot of shortcomings.  The
> mapping interface leaves userspace trying desperately to use statically
> mapped buffers because the map/unmap latency is too high.  We have
> horrible issues with duplicate locked page accounting across
> containers.  It suffers pretty hard from feature creep in various
> areas.  A new IOMMU backend is an opportunity to redesign some of these
> things.

Sure, but also those kinds of transformational things go alot better
if you can smoothly go from the old to the new and have technical
co-existance in side the kernel. Having a shim that maps the old APIs
to new APIs internally to Linux helps keep the implementation from
becoming too bogged down with compatibility.

> The IOMMU group also abstracts isolation and visibility relative to
> DMA.  For example, in a PCIe topology a multi-function device may not
> have isolation between functions, but each requester ID is visible to
> the IOMMU.  

Okay, I'm glad I have this all right in my head, as I was pretty sure
this was what the group was about.

My next question is why do we have three things as a FD: group, device
and container (aka IOMMU interface)?

Do we have container because the /dev/vfio/vfio can hold only a single
page table so we need to swap containers sometimes?

If we start from a clean sheet and make a sketch..

/dev/ioasid is the IOMMU control interface. It can create multiple
IOASIDs that have page tables and it can manipulate those page tables.
Each IOASID is identified by some number.

struct vfio_device/vdpa_device/etc are consumers of /dev/ioasid

When a device attaches to an ioasid userspace gives VFIO/VDPA the
ioasid FD and the ioasid # in the FD.

The security rule for isolation is that once a device is attached to a
/dev/ioasid fd then all other devices in that security group must be
attached to the same ioasid FD or left unused.

Thus /dev/ioasid also becomes the unit of security and the IOMMU
subsystem level becomes aware of and enforces the group security
rules. Userspace does not need to "see" the group

In sketch it would be like
  ioasid_fd = open("/dev/ioasid");
  vfio_device_fd = open("/dev/vfio/device0")
  vdpa_device_fd = open("/dev/vdpa/device0")
  ioctl(vifo_device_fd, JOIN_IOASID_FD, ioasifd)
  ioctl(vdpa_device_fd, JOIN_IOASID_FD, ioasifd)

  gpa_ioasid_id = ioctl(ioasid_fd, CREATE_IOASID, ..)
  ioctl(ioasid_fd, SET_IOASID_PAGE_TABLES, ..)

  ioctl(vfio_device, ATTACH_IOASID, gpa_ioasid_id)
  ioctl(vpda_device, ATTACH_IOASID, gpa_ioasid_id)

  .. both VDPA and VFIO see the guest physical map and the kernel has
     enough info that both could use the same IOMMU page table
     structure ..

  // Guest viommu turns off bypass mode for the vfio device
  ioctl(vfio_device, DETATCH_IOASID)
 
  // Guest viommu creates a new page table
  rid_ioasid_id = ioctl(ioasid_fd, CREATE_IOASID, ..)
  ioctl(ioasid_fd, SET_IOASID_PAGE_TABLES, ..)

  // Guest viommu links the new page table to the RID
  ioctl(vfio_device, ATTACH_IOASID, rid_ioasid_id)

The group security concept becomes implicit and hidden from the
uAPI. JOIN_IOASID_FD implicitly finds the device's group inside the
kernel and requires that all members of the group be joined only to
this ioasid_fd.

Essentially we discover the group from the device instead of the
device from the group.

Where does it fall down compared to the three FD version we have
today?

Jason
