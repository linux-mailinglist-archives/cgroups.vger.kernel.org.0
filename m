Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4503671FF
	for <lists+cgroups@lfdr.de>; Wed, 21 Apr 2021 19:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244996AbhDURwk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Apr 2021 13:52:40 -0400
Received: from mail-bn8nam12on2049.outbound.protection.outlook.com ([40.107.237.49]:6791
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235242AbhDURwk (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 21 Apr 2021 13:52:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtikV1Rj5AeF1VX+dPPbqaFW0xU/kh4GN4Mjj5nq2RLUTo441iG3sIga6irmnGkDv6ilNwjQ+fP6tM0FIVDnYVUrgbKL8OWSC5v3lq1Wy3TkcNHWv191/ZTvFVWLbngt+xUeLM6f3i6RkNyV4cBQCpdcGgYEAPSg1Ht/B7bWCi7cq7k9r+58uUaEgQhRY9lz5gpEQtZc1uF5nrznHjo8bfrnDBlPWqA/W42sLEJAw+/ELTiG8vYXnSbsTOBF/GPM5/MK9ltuNzF2TQP2HOg7UyDc2VN9uSn5Q14rJ1PSPsttcdt/1z5NBC1WFURTfI8mJUttSQEspuDwyUgh41mj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpSJ5skAT76bfSWLlCPUo8FROtI5wdyyLtOzDx3PG20=;
 b=E1mkxEPlJbgpGNyJAnvZ/xgb+8Vxrtbc5+YC7VZKmIDLf0Q/qv6rk0WwGA6tKQsztzOtO1cu9Eej5ckx5GbzdlhmQcQHKJ/ZAH6r1hEwGROii8O21CRbN2rVkl3ikn/WGeq26UTENWDFG2j46Of1ouIwwMx0SRVdEeSykBPgQ6jRDuJp9cQB66k7/orQ3NFLa656p8/N/Wh1dluDoj1LEYGeOerubwlooCvKNG3wWJWD1PVKlRCv930bWxbKBppGR6w8UESKal2biq2P7+PknTg97/jt09orvlooBs10ZJzrnzUhqxKkQ8ezI4erJZvH1Vg9eDUiqh9DyKsqYilgtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpSJ5skAT76bfSWLlCPUo8FROtI5wdyyLtOzDx3PG20=;
 b=UGpu6HypLD1mw7A7rXMV7M6oEt+0YiEmgoR+4+NtDG9h8lcgV8yPlBmHQOerJRReiHjx+ui0MHJVR3u4AYFSMFbNZ4oN7cPmH3GIS4o2dTGJVj/keWP9b3zTm9zKVb8NIO9fUS3hPQLkK4/4GwUYVkuNX4Gm200rq0BaL7CkAWib06qhDWOSMou82mOm5wzcHbPkw/HQKZvT7jAaT26eRCNvpukviHXTW2sKcs/lqyiwHrgxjnTTEMuI+2XFGUhO/steh3WGhUuQLhiQp5F4kKaRuY4e3bmrL5WXaZTk7ILwoJg2QGxBYnES6s15zErlTyOXrLYTHZ2/d3iEv6kTtg==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 21 Apr
 2021 17:52:05 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 17:52:05 +0000
Date:   Wed, 21 Apr 2021 14:52:03 -0300
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
Message-ID: <20210421175203.GN1370958@nvidia.com>
References: <20210401134236.GF1463678@nvidia.com>
 <BN6PR11MB4068C4DE7AF43D44DE70F4C1C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401160337.GJ1463678@nvidia.com>
 <4bea6eb9-08ad-4b6b-1e0f-c97ece58a078@redhat.com>
 <20210415230732.GG1370958@nvidia.com>
 <20210416061258.325e762e@jacob-builder>
 <20210416094547.1774e1a3@redhat.com>
 <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210421162307.GM1370958@nvidia.com>
 <20210421105451.56d3670a@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421105451.56d3670a@redhat.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR16CA0045.namprd16.prod.outlook.com
 (2603:10b6:208:234::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR16CA0045.namprd16.prod.outlook.com (2603:10b6:208:234::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 17:52:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZH19-009apO-GC; Wed, 21 Apr 2021 14:52:03 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bf78f60-cd89-4fd0-d0b4-08d904ee2c8e
X-MS-TrafficTypeDiagnostic: DM6PR12MB2858:
X-Microsoft-Antispam-PRVS: <DM6PR12MB285861EBAAF81949B875A380C2479@DM6PR12MB2858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BFz8nq2O1WzkNQbEo81H5xgGV7lLIs1XJDpQq10NNgEB8ltt/seA07eCzb0A3L056ruoHJkEGqju+fF2CVJn8rT8vLvmksBiyjXPcetFoKFdIZKxNosDfs1TxtkKeXWiUtytBdpp+BJJixhkysJrY2B9TGzqXX+EfbbStxbZ3p8bNquQmCRoPxnz6tsHX3supEzShqko/+1On1SOmMPotLEpf2pNPB2ddT5m6TWoi9RD672I7M7cpY34AUe4FYLqBhgpvsc0yDFF9T7YZ+e4FaW1yCZd8SoBECoLXMs39J/+KFzh9qJPKamGftsjrblvRIXy6zEOGeSkdMasjnytptj730xzJR4676+LCxpw2iVT/VJIKNSXhAW7Rxl7JgmKlZQGxceX4WRehuPP3S46sjtF+eIMnlMdGZxWeUGrYbirRvYcLALv5spxD+bppo+Ild5S1kNFbf+6FmYlmIFCovovizWHv4+4WlddPHW60OwxubR8IhUba82FB6aYcRrcVf0BguhYlc2Pb7emSrQvMeKQCFnCrEOQnvu3kNqK5yflr5sbUrBdw+/rTLto6j7EsBL2Q1MObNBdt18sgJ0f4N6M318EBILwux7PmuGdHw0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(5660300002)(6916009)(33656002)(1076003)(7416002)(83380400001)(86362001)(316002)(66946007)(66476007)(66556008)(2616005)(426003)(186003)(36756003)(4326008)(8676002)(478600001)(38100700002)(9746002)(26005)(54906003)(2906002)(9786002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0AAjQ6EdHr/yq4PCUo6AKHQfXUEpS208nr9UUmEuwAxUsM23Psm9nIFCxcAJ?=
 =?us-ascii?Q?11wTAFGgKxNkZFCAY+2GoAsKXVg1gXVXw8ww+HDvKmgmB3Pzuu1D6p61iSqL?=
 =?us-ascii?Q?RLbfHCPSJbZuP3iRnOsnQp1zcJCb0WXLyBNTtw/0SqgCOdFAmLhJaft93CGN?=
 =?us-ascii?Q?5FOd5JFcogBmN8h79pvNbTsy8AS+hR+TFeEmfwSSDmqymWp52WTo3VsSIxv1?=
 =?us-ascii?Q?5dWQmCY7KSFYSExBQrANlaDlfpTCofl664fLQbR/WwyeLhAocZkQfXjfjtja?=
 =?us-ascii?Q?HVipBMOLaFcfFSXOrkqqmGdEDcF5gJvKvS+S3paoEucI7NP3/j28LuiNm/8u?=
 =?us-ascii?Q?4xj7veiMaUO6xsbRvwgMWKYP2pKwQgSItDVCv1RulVBtBF0oFPQ7eYIapNF4?=
 =?us-ascii?Q?z8GzvbjQN7/ytzxWTbrFK6cszIcqSKA5YunD5palSPutSIP9Jp5EfThocd0W?=
 =?us-ascii?Q?KtVvI8FyacU4qzMIlkEOpVhAWdo7zptD62YbaRyx/YZ0k9vVoLda0FYEabTZ?=
 =?us-ascii?Q?0AXgvnz85d279ZTxQsz1B+leRKgzE86F2WsIU+JuEIKj7aPLyrrRAeKSZaqz?=
 =?us-ascii?Q?phJktOJEIKFQhX6F1PUy87FBpoOMnJS81B/E9Ja3I9CbqjPQuBB0A156rQWs?=
 =?us-ascii?Q?XhSSbM/hi2L4M+4Oa/HWw0iHnQfeJIuspif0lAc31cw7HWEVzfetTtUZrD1E?=
 =?us-ascii?Q?K6647MNIyePiSPNQJFHSLjUY9JZb7FdRO8sacEAAHk0/EPX2r5J7RQUv6UUm?=
 =?us-ascii?Q?L6NYvVcUeFvmsCJXOzwfcuzvbjBf7KASf0UYubxJFzQ4jUb2uPIEr+ncHibH?=
 =?us-ascii?Q?XNtHVlFplPjXp8rXEWQgXePQTES+E31DaFwMqoSttwkN4fsSN3Da5C9t4AMh?=
 =?us-ascii?Q?oYBSHr23by7JLd7prFKJZfTBW1BRAR4xbVimBBR2pPxaf6zLSJZYSyqdMen0?=
 =?us-ascii?Q?IUDD0b7FvlupwrJen9K8SMRwFq01UJRM/61u0+5m2z1iHtVWYDhg//mIh2Dw?=
 =?us-ascii?Q?LCemJ9qV/BuMzDdb8BczCPBcE1GA7uFrb3mc8RAhHdLoA+yjQDVqkGoP+dR0?=
 =?us-ascii?Q?aQFqJw2/aLmo/0Gzo2P9hC08FMepnvVxEhupVq1uzhdHvgyfG4MRnMUJ3pgD?=
 =?us-ascii?Q?aupdj3MbubhQFEYoI855N/OXAwMzYxAC/0Xdf+xpiO/zcNAdV3A/ylB2xOOM?=
 =?us-ascii?Q?gFr0n7//fgZexfE/0dtW2fg1pZ2bwxF+N0jEHBkrYqt6ktpsLYbnrI9hRUtw?=
 =?us-ascii?Q?1ob6+uvGtnkmOlDJWFuPWnVl9Is16QF9VP1WpO+2XLX7+5ahEU4wNp9NSRJT?=
 =?us-ascii?Q?eA5U+/cjJumdOYc78sVHhNe6rcKih6UWrnFSnm0vlTvPtA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf78f60-cd89-4fd0-d0b4-08d904ee2c8e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 17:52:04.8379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DaPg9k7TDPi4ATtuPZDMLRqZYfkJETbhg1J75pjloIH4NVUcuFigclVBC3fUnbV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2858
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 21, 2021 at 10:54:51AM -0600, Alex Williamson wrote:

> That's essentially replacing vfio-core, where I think we're more

I am only talking about /dev/vfio here which is basically the IOMMU
interface part.

I still expect that VFIO_GROUP_SET_CONTAINER will be used to connect
/dev/{ioasid,vfio} to the VFIO group and all the group and device
logic stays inside VFIO.

The appeal of unifying /dev/{ioasid,vfio} to a single fops is that it
cleans up vfio a lot - we don't have to have two different code paths
where one handles a vfio_container and the other a ioasid_container
and the all the related different iommu ops and so on.

Everything can be switched to ioasid_container all down the line. If
it wasn't for PPC this looks fairly simple.

Since getting rid of PPC looks a bit hard, we'd be stuck with
accepting a /dev/ioasid and then immediately wrappering it in a
vfio_container an shimming it through a vfio_iommu_ops. It is not
ideal at all, but in my look around I don't see a major problem if
type1 implementation is moved to live under /dev/ioasid.

For concreteness if we look at the set container flow with ioasid I'd
say something like:

vfio_group_fops_unl_ioctl()
 VFIO_GROUP_SET_CONTAINER
  vfio_group_set_container()
     if (f.file->f_op == &vfio_fops) {
          // Use a real vfio_container and vfio_iommu_driver
          driver->ops->attach_group()
             tce_iommu_attach_group()
     }

     if (ioasid_container = ioasid_get_from_fd(container_fd)) {
         // create a dummy vfio_container and use the ioasid driver
	 container = kzalloc()
         container->iommu_driver = ioasid_shim
         driver->ops->attach_group()
             ioasid_shim_attach_group(ioasid_container, ...)
                 ioasid_attach_group()
                     // What used to be vfio_iommu_attach_group()

Broadly all the ops vfio need go through the ioasid_shim which relays
them to the generic ioasid API.

We end up with a ioasid.h that basically has the vfio_iommu_type1 code
lightly recast into some 'struct iommu_container' and a set of
ioasid_* function entry points that follow vfio_iommu_driver_ops_type1:
  ioasid_attach_group
  ioasid_detatch_group
  ioasid_<something about user pages>
  ioasid_read/ioasid_write

If we have this, and /dev/ioasid implements the legacy IOCTLs, then
/dev/vfio == /dev/ioasid and we can compile out vfio_fops and related
from vfio.c and tell ioasid.c to create /dev/vfio instead using the
ops it owns.

This is a very long winded way of saying ideally we'd do
approximately:
  git mv drivers/vfio/vfio_iommu_type1.c drivers/ioasid/ioasid.c

As the first step. Essentially we declare that what is type1 is really
the user interface to the internal kernel IOMMU kAPI, which has been
steadily evolving since type1 was created 10 years ago.

> The interface of making that selection might change to accept an
> external /dev/ioasid file descriptor, of course.  Maybe you can
> elaborate on how the vfio device and group uAPI live (or not) in
> this new scheme were /dev/ioasid is the primary interface.  Thanks,

They say in vfio. You'd still open a group and you'd still pass in
either /dev/vfio or /dev/ioasid to define the container

Though, completely as an unrelated aside, I admit to not entirely
understanding why the group is the central element of the uAPI.

It is weird that the vfio "drivers" all work on the struct vfio_device
(at least after my series), and it has a file_operations presence via
vfio_device_fops, but instead of struct vfio_device directly having a
'struct device' and cdev to access the FD we get it through a group FD
and agroup chardev via VFIO_GROUP_GET_DEVICE_FD

If we were to revise this, and I don't see a huge reason to do so, I
would put a struct device and cdev in struct vfio_device, attach the
vfio_device directly to the ioasid and then forget about the group, at
least as uapi, completely.

Or at least I don't see where that gets into trouble, but I'm not too
familiar with the multi-vfio in a process scenario..

Jason
