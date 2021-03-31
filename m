Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22166350573
	for <lists+cgroups@lfdr.de>; Wed, 31 Mar 2021 19:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbhCaRcC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 31 Mar 2021 13:32:02 -0400
Received: from mail-bn8nam11on2079.outbound.protection.outlook.com ([40.107.236.79]:47296
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229787AbhCaRby (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 31 Mar 2021 13:31:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4KQryjyr6oKSU6ZOhuwgsKGGmDutr1z63rUZxptS+PhByrsFFGpMwvPwiSN2fKcbt0EOidQhtFnI0DJvYircB/gGiQcnhk3bHwowbMyGGiUi+PxeZ7UVuiBk4YakK7Ykx56FffYbB3iuLXOWTVIbJgHycck4EBVYPNs0TPF6/fimLAU+ba4HlecraMIpot/G5yuSNGoGiMcIZ4OjnDUb80TZgenMUwTqi4dL/FpiBevsb5+rZVpcWWfE/YpAUH22S+FVHOTXj3w0V+jh8yhp7/ZbqvQXQBQhNhq042yubxq6ip9aGvUdTrPVMeVf70AvSTUzT8DCGO9/mw41kBbHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvuoyXnpUpGAsZ/jLIeEpJ+ywWHGEHmghfuuM3cvyZk=;
 b=JOnld7lX+2oWNyxlOxNR4679KrMIbppLBRbuJXBzDWP8OXJdiMNWR0LZmhyXmTMvpxMfzHVUg9OVIS7IgxxpC2/lZBAl4phR6q9enunw9gJGUNL7+XwM+e9KaVVZs9mnTxBTFopAuxWSgRyFPLMR1cBPT2mz862M0vyQe+E6rH6amSLk7DNUgnyormBCW8T9Xv+w1oOEXPK+bCbs6DBFFDhyTliaQHcBj+21xBpPB3bojkKBydP05IR9u4Yof1qrnDDB772K0+ytTNi9FwvouiBq6g1LfckkVSYf13gEG5GS2O82cp/BQJo/+UGEJjyL7TgPZ1hK5mzwARu352tA8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvuoyXnpUpGAsZ/jLIeEpJ+ywWHGEHmghfuuM3cvyZk=;
 b=i/jGObYyQhbJacVe+Jk1gx+MRTM/7lymrearON1zC8J2WvXGeYetmY62dZeDrW5eFWODcsMvrWsKi9q+LDotPxe4u/hmg6pzEWiWRWHc5hqPV0IaYNRldqTezjctiSQekDJ7dZIvFYr36iLVrT1KNn0oFNWyBK6p7dpIr89UEnApPObuNNIogbqSMqwW19lk5w6ZrDQRB88GJKoQwK9+FXDxgwLN8d6PM96sqqd0Z73fYfSolITryRHhs+PXXZpqjvz0TBYoFtUv6qrnpwMZQf0ufUPAWQHU6N9wPdeHTkjCtRnJgsfyoWZ8JZ8i1qzG/o1wvXyojzstDYoGTTGNSA==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2951.namprd12.prod.outlook.com (2603:10b6:a03:138::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.32; Wed, 31 Mar
 2021 17:31:51 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43%6]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 17:31:51 +0000
Date:   Wed, 31 Mar 2021 14:31:48 -0300
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
Message-ID: <20210331173148.GN1463678@nvidia.com>
References: <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <20210329155526.2ad791a9@jacob-builder>
 <20210330134313.GP2356281@nvidia.com>
 <20210330171041.70f2d7d0@jacob-builder>
 <20210331122805.GC1463678@nvidia.com>
 <20210331093457.753512d4@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331093457.753512d4@jacob-builder>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR18CA0023.namprd18.prod.outlook.com
 (2603:10b6:208:23c::28) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR18CA0023.namprd18.prod.outlook.com (2603:10b6:208:23c::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Wed, 31 Mar 2021 17:31:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lReh2-006OvY-Gv; Wed, 31 Mar 2021 14:31:48 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c5b8aa9-0b36-4480-905b-08d8f46ade8a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2951:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2951093FC2DC89AE4892F3B8C27C9@BYAPR12MB2951.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gsO4RPMdfGNapaQvlC6AhrMFxoIXL/iYXSbkS5MWmrFWgm1m9OwvhVepsyqO2iN4FBtfhXqRP8tWT7XhjPkp29SQ/cGXJh6My+3mz9oVQ66lZ1ZUCylGTJA3hC/QOlIff0WYBbytTRQzr0nzKaP6RjgcZ4OUk/paI6AqUpu0QlSLdvLILqOi/EzGYmtwFdkGfVHd9WDaUd4hAxbGsV0vV6s/JEN1WPauA7KbRpUtTA+oOjr/X2bRl5PzFAKSUP0BcVgXKFMfpsG3khWmth4LBYILGU3+Pj8JEXPRgbio4KrP89fB+uKKLB5cPbACXf1DucFX7zho7OSjd5AC17P2vngqKkpplyBl05S7g5GQtsCIhOaMB1h4l6cRy+m0+rgTvnC1oDgl1ZowhJskcyKkpvJkRFhl1LJDzulufyBSxLcE4jycsUQJpfnVKJ5vDIfC+5qwzRBRzGKXX2GoHbU4bwVWsMYNK46fGL/J0NOEgzZ1S3YVvpA0N2W+eLgSnib7+lyZNyt+eP2gWLnGryAq4AfMVG3fIfKOiphsiQHB1TPzIzuRRw5/DoJQwbNN4UT4s3eTzljTlkCinAcqeJHaxdErvG6eL7n+fkExN80B7Yb7KJoSm/9HWKgh/fgg+A5F8+J2yUFhZh/uEvT51dbJdBJbmWYyf9LxHGRlcI/0+tM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(5660300002)(316002)(26005)(83380400001)(186003)(66946007)(36756003)(54906003)(478600001)(66476007)(7416002)(66556008)(38100700001)(2616005)(9746002)(9786002)(6916009)(86362001)(8676002)(4326008)(8936002)(1076003)(2906002)(426003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fmNTwdKIY7Z8nz1/UfObf29qHRRWqR3F8VCpgIjISVpJxV1joCmfU1RvCuzO?=
 =?us-ascii?Q?zxXpHUA63GgC+4NIl21/2LY/Jk8Qk1Rf+UPQq0zQ2DtLvw5OclZ5zHqhrmkv?=
 =?us-ascii?Q?MAY0J+Uf9PPuDpRIvWtdO/cBAxCaDO9+lax4dL9TG/gd37QvcbjSbXLlbtvo?=
 =?us-ascii?Q?2TS6Xpiwe/MqrhLnvl3nXNVNkTQdRpCHE015GKXdiIs4uRgdrtV8OaNpFpP4?=
 =?us-ascii?Q?L3iiR5u7NC/z06l4xMfuhyJ68l0m9tDfu30jV5BdXjLIz5ZQ3RnOdvwryovm?=
 =?us-ascii?Q?py1a9tJ0A8BvPsX7mHqSBzdgoa3N1M3ykJvU0Bw7hUNt0Mqs3XDz3XiuJ4Ag?=
 =?us-ascii?Q?MT4BmD0vI0EENOUbVqielMlSJpT5zl4eJDK/nzV+n2IwhC6EHFKsu5yhYSOT?=
 =?us-ascii?Q?05pY53VaMTMxNZgAbrh1hUiFY+Q2eYURZhA2lf7lPl1S8ZsIplx+bne1L0op?=
 =?us-ascii?Q?TC3zjEcSzo81Qs+DjI144XL/vhQi3BspFVJ3ccz9ZmHCnnugjUSI/Am+EedS?=
 =?us-ascii?Q?gZtEkVswV6a5D9CfOiQTgZLj4SxeFMUujpHeeCP5mkUF/LEFUVQlfWbs4xNB?=
 =?us-ascii?Q?sypsUrGAuYrq5AUt2tLxwTL77WdgmU7nru1O0tgvQgbXxphsCRndwy5HKY3m?=
 =?us-ascii?Q?ttcBZaHdUiDOrVHWGf99Gm2NG/5JDESJbf4CTPyoXWIJg5gnIZ7wQY7ghIGd?=
 =?us-ascii?Q?LThSJ1a0ZSHyBrsHXBWiQzQq9E4YVfr7a6vxMn3tFY0rDPQNiufkTB2QmcPW?=
 =?us-ascii?Q?8GmCe9R4srdbko78HbUlYd5c73oy4qdscEJbKLFexe0U4sEI7eanwNNUyMnq?=
 =?us-ascii?Q?WzgUEHeuw30C5U0NWOX4p0wM0j/2OBy3MolDlmXOT3dw5TAKTg/qVTXVbwfY?=
 =?us-ascii?Q?H4o44r1A9cBhE/Pp8XZtQHMUPlgl4J+xxqiU6ob+i7DuOujTe2Qnf/fZMosq?=
 =?us-ascii?Q?Tfl/MiAJaR1D3uv0DGERytsIj+R5AV1Z50bdwnh1qaIEhVShuzQ/9jR1SBIY?=
 =?us-ascii?Q?50/3zYWTsG1c4h50IoAZWNDZI7Gq0tXdwJPrOc1fK1LYWUJJEOQcCM/7lK5i?=
 =?us-ascii?Q?u8WPOHHsXcznE8PJih6X95unSjCUUHxoczeCrxe72z4ij3Jk9g3L4wMs2lSb?=
 =?us-ascii?Q?VMwFgxGTuDDEBDjsUoSOmCYtrA6N5bwR55Q1B9/cmje5e6X1Mr8TQnUfZ+u5?=
 =?us-ascii?Q?P7UQKSHCEjpJYk4bnjysuisTOyBRVxOFgf/OsY9zs9YHtCREumJXusrlUI3Q?=
 =?us-ascii?Q?374pxXu/CxoWMtUc5ZdWcV8C008bRLmJam06WHzxjuikG0QuEQ0osclRD8Rc?=
 =?us-ascii?Q?N5dGI/vmRarawR2KPbmI3ZXfgclCXXpTQ2ykagZSgROhlg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5b8aa9-0b36-4480-905b-08d8f46ade8a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 17:31:51.7064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMVgSCkhStMouQqvELFbaNPLY7a9iqntzv7/Dd3yOVOO4dxmb2NjVopd8wMRsm2J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2951
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 31, 2021 at 09:34:57AM -0700, Jacob Pan wrote:

> "3.3 PASID translation
> To support PASID isolation for Shared Work Queues used by VMs, the CPU must
> provide a way for the PASID to be communicated to the device in the DMWr
> transaction. On Intel CPUs, the CPU provides a PASID translation table in
> the vCPUs virtual machine control structures. During ENQCMD/ENQCMDS
> instruction execution in a VM, the PASID translation table is used by the
> CPU to replace the guest PASID in the work descriptor with a host PASID
> before the descriptor is sent to the device.3.3 PASID translation"

Yikes, a special ENQCMD table in the hypervisor!

Still, pass the /dev/ioasid into a KVM IOCTL and tell it to populate
this table. KVM only adds to the table when userspace presents a
/dev/ioasid FD.

> > Doesn't work submission go either to the mdev driver or through the
> > secure PASID of #1?
> 
> No, once a PASID is bound with IOMMU, KVM, and the mdev, work
> submission is all done in HW.  But I don't think this will change
> for either uAPI design.

The big note here is "only for things that use ENQCMD" and that is
basically nothing these days.

> > Everything should revolve around the /dev/ioasid FD. qemu should pass
> > it to all places that need to know about PASID's in the VM.
> 
> I guess we need to extend KVM interface to support PASIDs. Our original
> intention was to avoid introducing new interfaces.

New features need new interfaces, especially if there is a security
sensitivity! KVM should *not* automatically opt into security
sensitive stuff without being explicitly told what to do.

Here you'd need to authorized *two* things for IDXD:
 - The mdev needs to be told it is allowed to use PASID, this tells
   the IOMMU driver to connect the pci device under the mdev
 - KVM needs to be told to populate a vPASID to the 'ENQCMD'
   security table translated to a physical PASID.

If qemu doesn't explicitly enable the ENQCMD security table it should
be *left disabled* by KVM - even if someone else is using PASID in the
same process. And the API should be narrow like this just to the
EQNCMD table as who knows what will come down the road, or how it will
work.

Having a PASID wrongly leak out into the VM would be a security
disaster. Be explicit.

> > We should try to avoid hidden behind the scenes kernel
> > interconnections between subsystems.
> > 
> Can we? in case of exception. Since all these IOCTLs are coming from the
> unreliable user space, we must deal all exceptions.
>
> For example, when user closes /dev/ioasid FD before (or w/o) unbind IOCTL
> for VFIO, KVM, kernel must do cleanup and coordinate among subsystems.
> In this patchset, we have a per mm(ioasid_set) notifier to inform mdev, KVM
> to clean up and drop its refcount. Do you have any suggestion on this?

The ioasid should be a reference counted object.

When the FD is closed, or the ioasid is "destroyed" it just blocks DMA
and parks the PASID until *all* places release it. Upon a zero
refcount the PASID is recycled for future use.

The duration between unmapping the ioasid and releasing all HW access
will have HW see PCIE TLP errors due to the blocked access. If
userspace messes up the order it is fine to cause this. We already had
this dicussion when talking about how to deal with process exit in the
simple SVA case.

> Let me try to paraphrase, you are suggesting common helper code and data
> format but still driver specific storage of the mapping, correct?

The driver just needs to hold the datastructure in its memory.

Like an xarray, the driver can have an xarray inside its struct
device, but the xarray library provides all the implementation.

Jason
