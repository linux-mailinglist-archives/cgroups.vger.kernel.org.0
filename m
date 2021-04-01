Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC3F351CF3
	for <lists+cgroups@lfdr.de>; Thu,  1 Apr 2021 20:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbhDASXG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Apr 2021 14:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbhDASVD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Apr 2021 14:21:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20621.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::621])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62AFC05BD13;
        Thu,  1 Apr 2021 05:54:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiV/xwtLcLqLB5hg2X6IhR52B1jkYL8VLKgjA1GgacgD+u/Ju5HFfAHP96B9BjNPZsrlGb0jHfto5Vyc/YmyJJZjpoW1/goGnCICeRcOJwDQKylws1+8UvaMvBKYL1hldQ9Bh4df/nWXgzeoODTBRC1vlGph37C0/Zg0MReXj70ie4PGjbMwBfLJYhlMqVT5+u5caQ2ZeV3X0yqv0BFHyspFkuqyiQJ/h+aBET9gMMYFEr+DXLajtKEYBpGoT6t+QSpLiBxZuTnytxHrDTka+Oosk1GJqKnxaFJU1g3KrIX+9cHawjgPMGCkbFFGWHNvPm3L0xgXvD4Tg531VXcALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7N5icP71ZD/v1I/EQgOUCK1AgmVSlEGNRoPkTN5V5k=;
 b=Xkikj/1stgv9lzBXJU85UfyfmRC6j0ee9Myl6xqm9hJNH2ouAsKrXzxx980O30M2lyTTWs3ey9cpm1NwK5Cry6qNcUDS377qgC6hfCi4ijTpUl9Ovc4DEHiB4O9+XtkzOppoELwusAFIDm/lyN3eEzeZisdCFwG8fbNJ+HDRUe7G0e8PQ4O/4esamA6wNiEjx1/nC6natNG4ol4jcZlhTTdr1rnnivKEZjmo+xNyqjTcQdtdtMP3SLadnbmiff4parnZBihq/bHwglj/7/tqSyXhe2oMnpmWBDHgn6VLkJSmZsHYnhsk8DD+1UA9ZyvkkuI7QuF9jgpkobNbbPIKHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7N5icP71ZD/v1I/EQgOUCK1AgmVSlEGNRoPkTN5V5k=;
 b=rIqHp5jhJY4wEpOXp2JGc4edsmgedQRL8ekFflVLhIvM/lbXg0+HI/JoVx19qsOZq+7v3TCqNAhTpC0Nqw74WTcS3YXIhd3rEYEdcW+napx6eZTyHIHNUoBN20YAwpZz7Ip4RCcqTtqXiWqNATIb1wJd3LiNkQGuF0J8I6+Oam26VQL5sA4iwdpxSc9ZjBJUlvrimRrbIZeljCPm5WhA2TP12K/7eY/qLN5UO6PUJR2Y5aGMcva2vac/ozOlYJc4yBHgohiqUSWznj4XcAeUUoro0xeUoby8O3u1Q72PRLEusMAYgo/cIJl7DmbJ2JP8Mt4/F1MhrSSojA7QX4d28A==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3210.namprd12.prod.outlook.com (2603:10b6:5:185::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 1 Apr
 2021 11:54:31 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 11:54:31 +0000
Date:   Thu, 1 Apr 2021 08:54:29 -0300
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
Message-ID: <20210401115429.GY1463678@nvidia.com>
References: <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR15CA0049.namprd15.prod.outlook.com
 (2603:10b6:208:237::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR15CA0049.namprd15.prod.outlook.com (2603:10b6:208:237::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend Transport; Thu, 1 Apr 2021 11:54:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRvu9-006jCs-3G; Thu, 01 Apr 2021 08:54:29 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dac22d92-0fb5-445a-ed2f-08d8f504e8d1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3210:
X-Microsoft-Antispam-PRVS: <DM6PR12MB32100BBC92166C64A9A6C459C27B9@DM6PR12MB3210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xHI572SjzSrVQWFsJ1ln8iyoRlbfOp05m9c5HNSUBwWlwDe+2UnAwyBkbdbE2xPuDMHAg5UGSThSOo6cfKkSjlB6s53RyLnCDDddfHFhLlSo0+5M1l3SEcqGk6RQIBcwle2Oj7alG4s1qVfPC9jt5uQRIoZ+vAnX7BfoA83dXbdtZwZ4YbSd/RWUXLnl/4xiwibV0BAJPzr8DYiE4PVG9O9iU7e8H7oQiOybL1aJcY7yzBW7h92EdP6zaWIvSOt5p4pFV8Liafs8ThGEJB7gix8azOkAxEzNFEl3hhoHif/MpCuVgANUT6E1R7zpuQmXFtWaFjeo4+wrLVdQNdq8ozU2cm227V3YDF1x1QtW48dFeaCIZZXQQnTkxdDuUrxEIOEjgD1NQRRrQpIIG682WlWzb3g/yO6Urf9kjoYIFvrKDm/l7wnz4mz0HuonSA3+jGLA5sd9m1ce+dhIugJz5rez1Y07wjG/iZzgK5m/Ts3tFgrhW4wh9XmKFU/z/kMJH9J2aBsuvUOhDnLcFizhFkvwE8Q/l/koJgVbN463w/jsEaxkhalt8fgX3LVheQi51azbtk1xjMPtkuIZijI8l5p/CgONdEYTcyW+IzLh++biZCq5nWlLy8UL9TcBjx9Lc6lALl1mZRbaXwydYUoLTO6hv3hozaGIdAxLT+d3QAQ0KSQeazVPl/E7ZlmAS7Zw9JPHNJPS2R00RnlK04IvXnks4uh5vm4KB4otS8K21gePLyRKlWvTVi3aN5daaUrt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(33656002)(2616005)(86362001)(54906003)(38100700001)(66946007)(36756003)(1076003)(5660300002)(478600001)(6916009)(186003)(9746002)(316002)(9786002)(426003)(966005)(26005)(83380400001)(8936002)(7416002)(66556008)(8676002)(4326008)(2906002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gOWT3/YPIIi9n4fcaSimZWlf2wSseb0agBmwMW3mZ3UV366j9pkZXbT3ywEJ?=
 =?us-ascii?Q?QdfQGWYVFW+YnGr+R/YQhS+NEOWNXl01j4huatbEwzr4eWqrOnDF1W06twvy?=
 =?us-ascii?Q?qHL6kxQ5t/LLNCf2IBlXHqwq2x2SLUGXeJgLRLs0l93Mnlo1kMVSOG0vV2fS?=
 =?us-ascii?Q?1ZFvCkhEi/lMRiJD1HT17uJ6PB7myTgY3TwPHogCqeMjlMLlicH7EXUZOr4e?=
 =?us-ascii?Q?JkDZLFVtnQkvgBnM3ymI2T0yq+HS2YiSlqMHYPU6MOUBaoNfFDQmFs1aF7Hc?=
 =?us-ascii?Q?6x23MPOVHG94J2tclfEUbYHTVe8RRbkeUfEzahy+QkpRIx1wR0u3wiiRuvBZ?=
 =?us-ascii?Q?zrm+qcXXKTzRKaH3xRtiIXbiSopOGaurMBrk+M9SOFywXwQBmg5byqH9jOqX?=
 =?us-ascii?Q?JcRdLfZUYMHCSooNZVd+AtXwGR25L6Y1oRN9IeXOR5FPtjG8ZUW3vjWhsF9h?=
 =?us-ascii?Q?tyov8eu1Rs9BX/y+d6nqyqr/L30ixhb/PnNgXK+VADjHy/0G/Vg+7LiUFrb4?=
 =?us-ascii?Q?Efw58tj+E2WKnGIaCWUWtGgm4fj2UmwDakBvw/u7orquq5sVddbcQibJbGGz?=
 =?us-ascii?Q?u27v+6NIpRrZMMzW37ywME0D8cN4NO4/2oexOLr6urJqxp9sp9d863NsI6Wj?=
 =?us-ascii?Q?ZnM+GmKoZq8E4jnCl+0FRksWJbBy6iYJXQyKQeitbwNDRawusL3kqyTsz+aj?=
 =?us-ascii?Q?zK7pTKzfwwXFDDKnnloiPXZat/8V2qmUSx5t2KBNbJiZXTGzESKdjUZYn1k9?=
 =?us-ascii?Q?om1n1DpRWtrbOpQUpkyw9DP+ovwYwfk0+35PEtcCQeBji2pGOBSCV97HdY98?=
 =?us-ascii?Q?oCfbbs0Ex9IiPpaHEPMPPa4olUGNs5NhQGomdQ1OgvuMmnZ+XH86JZoJPPIg?=
 =?us-ascii?Q?648FYTDNInOBbxnHTvF/nhgd69vvLL28pU+CxUnvdyz3+V3/dbXOhITYv1AS?=
 =?us-ascii?Q?cbaAcMCzUzdPB+BD0yjLn1Wf00EN/Q2ybQmzCnnMwkK9XmZfOFeQmfRPhIjG?=
 =?us-ascii?Q?DGLz+zUK8eqgi6KQTDNGjatXMwVUVh6GdvVAgyI55dxsSa52JyUeEsMIqY1U?=
 =?us-ascii?Q?KEMVtUjPQgAuC3B3miAvXY9fs7Eo5UpUg/OPqDmF/xM9b7+pY6peru2xA4GW?=
 =?us-ascii?Q?c0BMDDgxDgZUYMrXmn9LggoxDCD7LCCK+FOX9RSwse3RxjFIzL9inUNOQorD?=
 =?us-ascii?Q?VVSniLQ5zbHjKu4Jma+acFltwBoXjGDvBh9jfEFjmAPzPsh8NnwLVy0hUaBj?=
 =?us-ascii?Q?CG8SbasA37zR5S0OSmjQ1lZlUUNmf8iZODoVom5W/6zDUzp4UOKV4Guaeq9y?=
 =?us-ascii?Q?3nmZf2bPaxlqzjF7/DpxZRccEgE3EW7HUhyHSbRuoo4HTQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac22d92-0fb5-445a-ed2f-08d8f504e8d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 11:54:31.2178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LX3fxe1V7rf1GgGPdsuvdgnt8AoQdGFRbUlnKuJAsqD52LdgfsH+hCC2u5pXuxW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3210
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 01, 2021 at 07:04:01AM +0000, Liu, Yi L wrote:

> After reading your reply in https://lore.kernel.org/linux-iommu/20210331123801.GD1463678@nvidia.com/#t
> So you mean /dev/ioasid FD is per-VM instead of per-ioasid, so above skeleton
> doesn't suit your idea.

You can do it one PASID per FD or multiple PASID's per FD. Most likely
we will have high numbers of PASID's in a qemu process so I assume
that number of FDs will start to be a contraining factor, thus
multiplexing is reasonable.

It doesn't really change anything about the basic flow.

digging deeply into it either seems like a reasonable choice.

> +-----------------------------+-----------------------------------------------+
> |      userspace              |               kernel space                    |
> +-----------------------------+-----------------------------------------------+
> | ioasid_fd =                 | /dev/ioasid does below:                       |
> | open("/dev/ioasid", O_RDWR);|   struct ioasid_fd_ctx {                      |
> |                             |       struct list_head ioasid_list;           |
> |                             |       ...                                     |
> |                             |   } ifd_ctx; // ifd_ctx is per ioasid_fd      |

Sure, possibly an xarray not a list

> +-----------------------------+-----------------------------------------------+
> | ioctl(ioasid_fd,            | /dev/ioasid does below:                       |
> |       ALLOC, &ioasid);      |   struct ioasid_data {                        |
> |                             |       ioasid_t ioasid;                        |
> |                             |       struct list_head device_list;           |
> |                             |       struct list_head next;                  |
> |                             |       ...                                     |
> |                             |   } id_data; // id_data is per ioasid         |
> |                             |                                               |
> |                             |   list_add(&id_data.next,                     |
> |                             |            &ifd_ctx.ioasid_list);
> |

Yes, this should have a kref in it too

> +-----------------------------+-----------------------------------------------+
> | ioctl(device_fd,            | VFIO does below:                              |
> |       DEVICE_ALLOW_IOASID,  | 1) get ioasid_fd, check if ioasid_fd is valid |
> |       ioasid_fd,            | 2) check if ioasid is allocated from ioasid_fd|
> |       ioasid);              | 3) register device/domain info to /dev/ioasid |
> |                             |    tracked in id_data.device_list             |
> |                             | 4) record the ioasid in VFIO's per-device     |
> |                             |    ioasid list for future security check      |

You would provide a function that does steps 1&2 look at eventfd for
instance.

I'm not sure we need to register the device with the ioasid. device
should incr the kref on the ioasid_data at this point.

> +-----------------------------+-----------------------------------------------+
> | ioctl(ioasid_fd,            | /dev/ioasid does below:                       |
> |       BIND_PGTBL,           | 1) find ioasid's id_data                      |
> |       pgtbl_data,           | 2) loop the id_data.device_list and tell iommu|
> |       ioasid);              |    give ioasid access to the devices
> |

This seems backwards, DEVICE_ALLOW_IOASID should tell the iommu to
give the ioasid to the device.

Here the ioctl should be about assigning a memory map from the the current
mm_struct to the pasid

> +-----------------------------+-----------------------------------------------+
> | ioctl(ioasid_fd,            | /dev/ioasid does below:                       |
> |       UNBIND_PGTBL,         | 1) find ioasid's id_data                      |
> |       ioasid);              | 2) loop the id_data.device_list and tell iommu|
> |                             |    clear ioasid access to the devices         |

Also seems backwards. The ioctl here should be 'destroy ioasid' which
wipes out the page table, halts DMA access and parks the PASID until
all users are done.

> +-----------------------------+-----------------------------------------------+
> | ioctl(device_fd,            | VFIO does below:                              |
> |      DEVICE_DISALLOW_IOASID,| 1) check if ioasid is associated in VFIO's    |
> |       ioasid_fd,            |    device ioasid list.                        |
> |       ioasid);              | 2) unregister device/domain info from         |
> |                             |    /dev/ioasid, clear in id_data.device_list  |

This should disconnect the iommu and kref_put the ioasid_data

Remember the layering, only the device_fd knows what the pci_device is
that it is touching, it doesn't make alot of sense to leak that into
the ioasid world that should only be dealing with the page table
mapping.

> +-----------------------------+-----------------------------------------------+
> | ioctl(ioasid_fd,            | /dev/ioasid does below:                       |
> |       FREE, ioasid);        |  list_del(&id_data.next);                     |
> +-----------------------------+-----------------------------------------------+

Don't know if we need a free. The sequence above is backwards, the
page table should be setup, the device authorized, device
de-authorized then page table destroyed. PASID recycles once everyone
is released.

Include a sequence showing how the kvm FD is used to program the
vPASID to pPASID table that ENQCMD uses.

Show how dynamic authorization works based on requests from the
guest's vIOMMU

Jason
