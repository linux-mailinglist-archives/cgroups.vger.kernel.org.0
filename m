Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE271368014
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 14:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbhDVMK6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 08:10:58 -0400
Received: from mail-bn7nam10on2047.outbound.protection.outlook.com ([40.107.92.47]:21676
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230510AbhDVMK6 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 22 Apr 2021 08:10:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bezNjf6t1YZiQOXFw1k/r2H5eBeDCTLAOGDjkcj3kBoA/hDiuD73QbB3ie7t/xn+XDxeEG/sR3tuFDXd54E4vGEe2N2IdMAgJmv9F8HX+K3NQhbSEEog425RlX70HXnQacz3FYYKw97k95dIRaq/X1Lz2Lcu65qFeJBT9pfuPGbYhsvM86iHLaL+isQ3xtpJLBQ+SG33aIVB4bOdr5vHhYngATlPKnbtvcmEF+dfGqQUOUN7eHzWVRkhCa+xFayBuqQuW1XlfzD7GPX2OoP9mAVcPNeIiTWuY69wStPhKtEQSUmPG+BYYfQzrsqynEs1ubi1M/L8UZ2hiMAb4QIPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeZlekQPQn37lMdede0eVSjq/MRzoRbjxrpbSDohj7s=;
 b=XAsX1JXyS8L/t4gQiVLrokjieaR9bf7GeLdehj2L5YgKNA3BKjTejmiWCpy/FtcJBkaFDciGWbvUmrTo+rfrMvyFLCS6y/AB1vSVJOQw17hoQMdoWMnk5cKvQjGI9a1udPuor6svoTThI2K8+sRDuT2ObHgyQRy24g0XTfP4t9ZrJWzCeEGrLazr+JPdyXzKxB0b92tOKZ+tdv4zdSXUQd1isHBS+NbteCC9ObMPTEOjUdexxPxQmlpV6MXLuX40T6mORyEOYMzgSpOVicqfARniHMm7LErAGSDJ8DnRS3vyH6iixS+n7jGL6SfikUD30iq3koCfHI2/qgSaQSaq+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeZlekQPQn37lMdede0eVSjq/MRzoRbjxrpbSDohj7s=;
 b=lraMJk8/2sgD9Vt3FhmJKC3pKQyeqZiFR/iPJ/XBvtK8kU7uwDo8ncLi3QKGrKaEz8vNCUTbPZ/fI+C1qpaobJ0i22ZqnD1gdyRtspKRYNw4bYuiLhw+roZSAjpQZ/9JkkAJR51RLdH4iRYW7tETi99Q5BRVn0u4oFCv7gQlxX2SCnr49auoITokGfkj5EtTri/tCYTlBqTfZotLFWN5lQrEOv+uI6KIgVBVxc+kMeE/jCGr6E2qj47jDQHr3rBwlr5nIQqG9nPtNScKTn9TdlZqqtzkrIH6vY3Zvjc35qPBF9CbHBCL272fFQ0psU7cancn2blPW4OcmrTaFIYrPw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4009.namprd12.prod.outlook.com (2603:10b6:5:1cd::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 12:10:22 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.023; Thu, 22 Apr 2021
 12:10:22 +0000
Date:   Thu, 22 Apr 2021 09:10:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Auger Eric <eric.auger@redhat.com>,
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
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210422121020.GT1370958@nvidia.com>
References: <20210415230732.GG1370958@nvidia.com>
 <20210416061258.325e762e@jacob-builder>
 <20210416094547.1774e1a3@redhat.com>
 <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210421162307.GM1370958@nvidia.com>
 <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR01CA0059.prod.exchangelabs.com (2603:10b6:208:23f::28)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR01CA0059.prod.exchangelabs.com (2603:10b6:208:23f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend Transport; Thu, 22 Apr 2021 12:10:21 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZYA0-009wx4-4D; Thu, 22 Apr 2021 09:10:20 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 488f0d67-f463-431b-4365-08d905879a3e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4009:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4009F4893DC3704092F19304C2469@DM6PR12MB4009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bCX6oedk3+sK7R/Wrim5/3FbEetCmsC0ott4Rhs0xqnWliOgqFg9lJzkYT5gajhkWPNZ4HTaLcpkAhOyje+7QmQtaU11QTG2kNuws+WMGkUiN7I3Uv8LnrNpo6GKzuJz3M6d5IzntyBwXdTycgn8MwquXFePIbop6R4LU1YDvkUZhKpRPHe1pFo5PyAge3kvP6E5NgJGqCzH+hDH97IMjHN6E+fUKR2jZagsjOl+9ioTGhc7HoQ8G3QTglSNu51a0fiMwXIA0RJ5KiXhijWJefswsN1Wvw5T4/NcNtGk+uuGZp6HEesI7ymTmnnbl5YtybmoGX5uQ5qRxuKUfP+3GfYW2HHHtcKxXfKjrz+I12ReDfNrGwyj5Co4Wpp6CGKajDUVpyC5vbYiS86RWTEZMRClEAOZOVAoLVQ+OyZq/K2oRFbwxK4HvXuDodspfPAmsUMK60o/7h8m/HLC1U4xKVH5YV1QrPfoidkL/a9/CyNOZ2E7v0PjmWZm78PV/+4CAd7WgtzkntQBVSVDUZ/2STcbSEuxnNAOsxUEqGBQ3+69oyP9cZURRgTxoR4GwU2F+pqUsU4KNsuZ3jz5yyt5xsUVKl3+9mlArDcPv+E0o60=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(26005)(186003)(5660300002)(86362001)(33656002)(426003)(2616005)(2906002)(38100700002)(316002)(54906003)(36756003)(66476007)(66556008)(1076003)(8936002)(83380400001)(9746002)(9786002)(66946007)(6916009)(8676002)(4326008)(7416002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yHh52nX8tRhwIJRyXBWdLU/9ziAH6wkkVlqbeSvppq4pIAwTMgT7a9eLQQf3?=
 =?us-ascii?Q?GUWp6yVR+Lwb8SwiNQvMpEkrKG/g19Lbfrs7g2D3FqbscvvrX+3AR7jhUk9V?=
 =?us-ascii?Q?H3vziad88N+2+DRfDn77E6YLmCdM694ta2aH6hfPTwRjbMuTPM4fuJgzYZE5?=
 =?us-ascii?Q?PcXeAumakzBf3B+RkaAeflYC3l+K79bgRut/78MeuwCcD07LNvAsFDRTQtZ2?=
 =?us-ascii?Q?0eOs4ADF26SEdtSq95OA/sSC8jFZPnXG4bBBN8nv7j9ZSo+y8nJ7+elZJFVl?=
 =?us-ascii?Q?A+SBwYy9xx31f4hmzcJXc8Qwlns38KJbm+3OSyDqgg02x8rXm3Wih4QGZGGW?=
 =?us-ascii?Q?eP33esFL3lVjRYJSqcYtvBoa0MzeMhB7iIKZU+AhtHN8iOR20u917voptbIH?=
 =?us-ascii?Q?QNIDnyWRVlq+NGIw3WLdNJM2n//qrIZ4yxmik41Zvb5jP51Qw+E//OEERvgZ?=
 =?us-ascii?Q?J2vLtSFXYqNNkzo24mbf8W7vLw5NFVhxoK/gxsIhYbf4RshpU42wrn9nNWJK?=
 =?us-ascii?Q?g3t2KeHhCms4wDL3gE8uMYbIqMexGZ2BvLD39m56H/66Tx+wL6beKkC970Fb?=
 =?us-ascii?Q?j6GfZtuHOnarVpsG0ph6TWjlEuBFzgGE3OPQtHzHTZq4FGw7A/nVjg0odg4D?=
 =?us-ascii?Q?P0Z0LVLeYGfhvuDDF5rsbFfx/DP+vQZTTffDlG6SDv/Pjc6LmftBs+WUCDMV?=
 =?us-ascii?Q?+CmnNjcn4DoVbbH2jVU/pg/IZZu/lOy7cghNmWL5HBr3qgHog9ouZJkv7Cfd?=
 =?us-ascii?Q?P4Iv2qJqHLV5kiUB71sEu1uAfWYXZIxmXR9WrIVB9YblqcSFC+4EBgildbuh?=
 =?us-ascii?Q?urVIfWtYGl3KHIUOPRbkFYrgY3jKzX0fHQkON0D/IbIp8BiluXDNoOHsADIp?=
 =?us-ascii?Q?dmiQj6rG/ntvcRs1uvLgMTjuMug4ZxhD3RpWbwIhzEBeq0JDrJFCJJ8a8oR2?=
 =?us-ascii?Q?VgAgT2QEK270DKb9Uyg6/JPPRXahQXc6plM+RMQq0gS6QCNBdOX4ZQOaN4V/?=
 =?us-ascii?Q?TmjODDzpK+WfloPZw+sifVmAodwwExbfXQS0k0yREdFi2woKWfR73CR9VJ1r?=
 =?us-ascii?Q?+3I896smVLtRMVwMub1rUuJkBxPfC1PMz5f2WuDFqsj8MOTfw2a8J6srnwOC?=
 =?us-ascii?Q?EiUS4O98UNJEOj9NB6urvAdf51WHhzjctAv0FjL6/SzzhS5IcCzncMexyjuJ?=
 =?us-ascii?Q?qU6OsRp5M4+M/l+qZ+F7HrGcb+VaeynvbAXmv+mqcKuOK6Bps/kZ/Ze65Qyp?=
 =?us-ascii?Q?beHbM1+imU9wNLkUj423uWlAXFoQqm2sCtvjZm4YLGBRylP45HH0BRYSiVmG?=
 =?us-ascii?Q?AoSfc8IHRsLl50pFKbqn4frJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488f0d67-f463-431b-4365-08d905879a3e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 12:10:21.9289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zY55nDOE+S493esMBv9QHN3f2e3QIHASQUOSlUnWgN/ey69QwIzc3yx6yqjAvIb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4009
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 22, 2021 at 08:34:32AM +0000, Tian, Kevin wrote:

> The shim layer could be considered as a new iommu backend in VFIO,
> which connects VFIO iommu ops to the internal helpers in
> drivers/ioasid.

It may be the best we can do because of SPAPR, but the ideal outcome
should be to remove the entire pluggable IOMMU stuff from vfio
entirely and have it only use /dev/ioasid

We should never add another pluggable IOMMU type to vfio - everything
should be done through drives/iommu now that it is much more capable.

> Another tricky thing is that a container may be linked to multiple iommu
> domains in VFIO, as devices in the container may locate behind different
> IOMMUs with inconsistent capability (commit 1ef3e2bc). 

Frankly this sounds over complicated. I would think /dev/ioasid should
select the IOMMU when the first device is joined, and all future joins
must be compatible with the original IOMMU - ie there is only one set
of IOMMU capabilities in a /dev/ioasid.

This means qemue might have multiple /dev/ioasid's if the system has
multiple incompatible IOMMUs (is this actually a thing?) The platform
should design its IOMMU domains to minimize the number of
/dev/ioasid's required.

Is there a reason we need to share IOASID'd between completely
divergance IOMMU implementations? I don't expect the HW should be able
to physically share page tables??

That decision point alone might be the thing that just says we can't
ever have /dev/vfio/vfio == /dev/ioasid

> Just to confirm. Above flow is for current map/unmap flavor as what
> VFIO/vDPA do today. Later when nested translation is supported,
> there is no need to detach gpa_ioasid_fd. Instead, a new cmd will
> be introduced to nest rid_ioasid_fd on top of gpa_ioasid_fd:

Sure.. The tricky bit will be to define both of the common nested
operating modes.

  nested_ioasid = ioctl(ioasid_fd, CREATE_NESTED_IOASID,  gpa_ioasid_id);
  ioctl(ioasid_fd, SET_NESTED_IOASID_PAGE_TABLES, nested_ioasid, ..)

   // IOMMU will match on the device RID, no PASID:
  ioctl(vfio_device, ATTACH_IOASID, nested_ioasid);

   // IOMMU will match on the device RID and PASID:
  ioctl(vfio_device, ATTACH_IOASID_PASID, pasid, nested_ioasid);

Notice that ATTACH (or bind, whatever) is always done on the
vfio_device FD. ATTACH tells the IOMMU HW to link the PCI BDF&PASID to
a specific page table defined by an IOASID.

I expect we have many flavours of IOASID tables, eg we have normal,
and 'nested with table controlled by hypervisor'. ARM has 'nested with
table controlled by guest' right? So like this?

  nested_ioasid = ioctl(ioasid_fd, CREATE_DELGATED_IOASID,
                   gpa_ioasid_id, <some kind of viommu_id>)
  // PASID now goes to <viommu_id>
  ioctl(vfio_device, ATTACH_IOASID_PASID, pasid, nested_ioasid);

Where <viommu_id> is some internal to the guest handle of the viommu
page table scoped within gpa_ioasid_id? Like maybe it is GPA of the
base of the page table?

The guest can't select its own PASIDs without telling the hypervisor,
right?

> I also feel hiding group from uAPI is a good thing and is interested in
> the rationale behind for explicitly managing group in vfio (which is
> essentially the same boundary as provided by iommu group), e.g. for 
> better user experience when group security is broken? 

Indeed, I can see how things might have just evolved into this, but if
it has a purpose it seems pretty hidden.
we need it or not seems pretty hidden.

Jason
