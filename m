Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C072F35541F
	for <lists+cgroups@lfdr.de>; Tue,  6 Apr 2021 14:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241857AbhDFMnL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Apr 2021 08:43:11 -0400
Received: from mail-bn7nam10on2058.outbound.protection.outlook.com ([40.107.92.58]:22912
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238409AbhDFMnD (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 6 Apr 2021 08:43:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSnCifPqHieNQRrKCsRXyYfFx2N5fRkMsQ35bYqkNaP1i9uyfU1Hts13OBbLjSvt0jusIL8nNOY3CQtMYPdrziTnT7uzXN6Fj1YTqhKFubLjnWbbYGhswUQuwQJkaRJaIMnOTFTfrJV4vA0VNCdU92qjUZRW2yp+NMKqy7pvzQN3DeLSh/caYU9HKFSuylaTkb3qPQgEITg/1tv9j24YDfrehWkGyRPg9sDF4IrmIyImpKsY+BkqdyvtZT2jQEYtqQ0xk4Cm+6WwnxhdcppmohoVEi6mT4SZKh1cQvJKEodtxcS56Ho/kPpk6Og02p1EY1X0HF1jd/cMX8RTFNdMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVcvhKEC4qVlKMK+ZPuj7FsiS/N0B9kV0o9VQC6v6JQ=;
 b=PTNDRphfUxD+dG0WZ428xvHv6ZHWPUm15DGwFhwusRrY6+5qXtLYXaR6mduHoSzh1EgpZpFgff27eQxgpXmEcENMl/GdEggofuD7Ts6D+qtZce7Ff3n9E8GHB2I/F5l4c1B2QVjXLML8dEm35MXJdIXxt3m1QLT2dkZZsiUnXxkE6xm5Ygbv6YWicCk0gouX7PfdtmzrfH0wYRUAKhy0n5c9bT6SqTFcmxDwJggQP1RKrIy8iNFEChTJzLp3mngggDfXdhFnJHGytDV/ELaBA70WN1T8kBB3E7dJ9yxFfqTjupyE2NEUM1IH8p1NOWd/oRxI3oQoG/mHkDI1euF+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVcvhKEC4qVlKMK+ZPuj7FsiS/N0B9kV0o9VQC6v6JQ=;
 b=J8e6UMs1zenWhtP/PzleJ1l6xG9UN8/aN2326f4syh43eIr3OZoKrhGTWds98aY+s/qH7Uo8UHLZmyGSTH+jXz8xEVQSOmr5M03JDrXe4cmz7LoW/Ck4gIQYA/iGrNSUjHtdPd6K935TPOv2FhqJA+RkvTjMoFilRaTzoKZy8oRxPuh+HsB6vHvqBHIZxBtKKgYxjjMETXQZj88+2+lBU9DmjGN5C6oWXZ+84kbg4T85RLG2blvGzIrP+BKw8l/Lhebyl4nRSLlvKKAwGiDF+4vf/igzGWY1aiLDDUjj6VkSZ1lc5JrpZlsQ8jtnqbwiCVQxF5lo26EyMLLlZw6YSg==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 12:42:53 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 12:42:53 +0000
Date:   Tue, 6 Apr 2021 09:42:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
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
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210406124251.GO7405@nvidia.com>
References: <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <MWHPR11MB1886CAD48AFC156BFC7C1D398C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405234230.GF7405@nvidia.com>
 <fa57bde5-472f-6e66-3521-bfac7d6e4f8d@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa57bde5-472f-6e66-3521-bfac7d6e4f8d@redhat.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:208:23d::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR06CA0010.namprd06.prod.outlook.com (2603:10b6:208:23d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Tue, 6 Apr 2021 12:42:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lTl2h-00179Z-Ub; Tue, 06 Apr 2021 09:42:51 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2806513-9232-4b9a-a8ba-08d8f8f97ed6
X-MS-TrafficTypeDiagnostic: DM6PR12MB2858:
X-Microsoft-Antispam-PRVS: <DM6PR12MB285837D5D6D9385D308EA952C2769@DM6PR12MB2858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9e4iIFwd365NTcB0jp8NDiyOCGmMctfj1jJ4sqYa4kYyZxxO1Ur4RXhPRlnsSszq5E7H2Ng733Q+DFD2l8sBA1X+tkU6wIcn/JPFhB/a1Q1mc0QUNim2l4Mmm2ud7LtYsusyc6QerxYKMhyg4sQx5iFD2nteKxY4EpXyhCETCNwroGBfD7golg1Hah3r+mn2Dq85iBJ3PrvSNPQLWPpiFI+kDzkO6cqRLzth/VxYPW/KV7JXBbcZS5hw2dBB3w/88K68viQETV6HqOM7o0LISrQElAlQWPB9y0P67MM3BpDqrKiMyMvx+BXAeRsAcij6PR+EY7RnJtn4KJMRZ/u4x9hzNXjKn63A50LZVZLzLayDbO9y/MpRRp5ZeXeVpyFx1Zw1/WC2aM+HhXApfVYpPPgjlZJSxX5gEk1omTo4eK7z7LamcsXZpYN8kvE1p8sbaZcWo6qMjfwFQMx8uNkQDhb0Xt27gs+Am23/5kcVPSsGgsjAV44zMT3J8SGFw75bCO9LMcPXdOrY9VxXv3YlsgxxtFepPIs/B0Zh2oSPuPJSLK5dwF9fWOei6Bxg+YrldGWq7JYcIHK0VPsG+C2FcwVZ9mjf+8pSD+FJKvTnyeL6Kqwg/eShxzKngCa+LuS4J6HynT0Xer9cYp41Ks8A0YWHcsFqni2XMpF2mDtRT58=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(1076003)(86362001)(33656002)(54906003)(9746002)(9786002)(66476007)(66946007)(36756003)(5660300002)(2906002)(6916009)(8936002)(38100700001)(316002)(7416002)(426003)(8676002)(4326008)(83380400001)(478600001)(66556008)(26005)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tRaf1I2ysbmPmWLk3tbfI/nOmUeK0L3UvnHBjedVbD3Q8jIHCnojpoK33DON?=
 =?us-ascii?Q?7oXYKsxru/rNMFabPivRY8S4QBPIBqsiZGN+6gG5QUxLZAQCjRqyy7F+ELxP?=
 =?us-ascii?Q?1PfRAfaHXrjLJJZ9ObscuC3Zt1y5YniQwzPDNUwGAAn3L54WNzpkmZa9LRG+?=
 =?us-ascii?Q?IVgAQRK/QAkV56PUi6kRHSrp6io9Q330GkTUKBx4ycJPVRomx2PRs9A3G0cu?=
 =?us-ascii?Q?WDY3aLLgrnU+Tw+YgWzke6IrWhYKZwozQ9AdUbhpf1DlD0EwGYxWQ3juRu6D?=
 =?us-ascii?Q?Zp5Yhgu9PxGWF732cEhC8IRRWrGkf2ulbiHv4QKr88xTIO1BbQlhVhde92ek?=
 =?us-ascii?Q?b40mNceQqcZyEimEdAqd8fTPJKRSGTcLsEeHE/ZB/C6JQgBs7SEE30klRSfm?=
 =?us-ascii?Q?R3wgweCRbu7E6gnw2/QUL0R2UPERKN/b6ff6ek27HYZjJ1f5zLNzd9wUdNFf?=
 =?us-ascii?Q?hWjh0FE6xEtpgtPT2PefiHKcZOhxMtuQc4H5F5HzhhXma3kzjBkMuJxP6Dzv?=
 =?us-ascii?Q?jIXFmK3EvmtLlEEcec2GUSiXIbzPDtwVR8az9SNncD+eCbIv5Y/hsa1Jk8Na?=
 =?us-ascii?Q?F6DzhPIdWRJ0TZidRPZxAYDyUUXG84qg9djlHZeDKquGYQQhCxwGMhb7W8YI?=
 =?us-ascii?Q?l8s2AlZuxD6uLg/Sm+9pg9f1HsmdODYM78Ll2VACeuZgbJ4HVFOmZxurbdZV?=
 =?us-ascii?Q?9G+vRAQV+dayShsji37Kc5s2ukWBFTCV8MXUaALdHM3mCjB14W/kRn809+Ja?=
 =?us-ascii?Q?7fSv6sN32129OyNzkaYhKxTVyhxQr0yigaGDZvnkHQ2mx/LvjaLHr8zV66Or?=
 =?us-ascii?Q?JxG0Q/kNUsyLfpyy4rrrkHnda71ltfOuPOMJ+R2GzoROWlKH84Kl++7ucZb+?=
 =?us-ascii?Q?C3yznT6bggOaEEMALs/stohI3To93Prfm1VHt8AMPWc3NOFL6tfSYfVpK5Ym?=
 =?us-ascii?Q?MR25DG+xVb/+w71/cfNJcivELACXX/C75TA5ZMy2cY1Y7UcAPEEjytpPgA6W?=
 =?us-ascii?Q?H/8cfGJhMcm1RFQn3BSRxb8NwlcH/n2WFLQyyKB3uzKpDQrvNCQWx4+Ohq7A?=
 =?us-ascii?Q?v1mZ/X2EpP2o2Afu66oAtEcUbA5yStvT4WogZS7pIrO7P3bMNDhNAeFMaLaP?=
 =?us-ascii?Q?P2D50AhkQm9Dt5I9w3c8c4zNN6PElAHkFhXps76Bfk1uJeb7K5kIMGcbtLPJ?=
 =?us-ascii?Q?OJ+NQ2RcX23pu5TezREr6YjID0hXj3PZSb1ffeiQxeo9O7WkZfxcnHL7J0b5?=
 =?us-ascii?Q?DzNhNPiOEnfHuL4ugv+fblGrW0/tClL0WIqOedKdvvFVvhmKVeAubrXJo//t?=
 =?us-ascii?Q?Wh2YQHNxElHps2TP0uenjjlwHk2PB+8LD7SV3c7t92wS3A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2806513-9232-4b9a-a8ba-08d8f8f97ed6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 12:42:53.7084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuPU1gTOp/QXIS6XdXyrwIrXQ00ObxGPfy3fUtvDyATqhjmTtQ+PtK37mAGCdlQI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2858
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 06, 2021 at 09:35:17AM +0800, Jason Wang wrote:

> > VFIO and VDPA has no buisness having map/unmap interfaces once we have
> > /dev/ioasid. That all belongs in the iosaid side.
> > 
> > I know they have those interfaces today, but that doesn't mean we have
> > to keep using them for PASID use cases, they should be replaced with a
> > 'do dma from this pasid on /dev/ioasid' interface certainly not a
> > 'here is a pasid from /dev/ioasid, go ahead and configure it youself'
> > interface
>  
> So it looks like the PASID was bound to SVA in this design. I think it's not
> necessairly the case:

No, I wish people would stop talking about SVA.

SVA and vSVA are a very special narrow configuration of a PASID. There
are lots of other PASID configurations! That is the whole point, a
PASID is complicated, there are many configuration scenarios, they
need to be in one place with a very clearly defined uAPI

> 1) PASID can be implemented without SVA, in this case a map/unmap interface
> is still required

Any interface to manipulate a PASID should be under /dev/ioasid. We do
not want to duplicate this into every subsystem.

> 2) For the case that hypervisor want to do some mediation in the middle for
> a virtqueue. e.g in the case of control vq that is implemented in the
> VF/ADI/SF itself, the hardware virtqueue needs to be controlled by Qemu,
> Though binding qemu's page table to cvq can work but it looks like a
> overkill, a small dedicated buffers that is mapped for this PASID seems more
> suitalbe.

/dev/ioasid should allow userspace to setup any PASID configuration it
wants. There are many choices. That is the whole point, instead of
copying&pasting all the PASID configuration option into every
subsystem we have on place to configure it.

If you want a PASID (or generic ioasid) that has the guest physical
map, which is probably all that VDPA would ever want, then /dev/ioasid
should be able to prepare that.

If you just want to map a few buffers into a PASID then it should be
able to do that too.

> So do you mean the device should not expose the PASID confiugration API to
> guest? I think it could happen if we assign the whole device and let guest
> to configure it for nested VMs.

This always needs co-operating with the vIOMMU driver. We can't have
nested PASID use without both parts working together.

The vIOMMU driver configures the PASID and assigns the mappings
(however complicated that turns out to be)

The VDPA/mdev driver authorizes the HW to use the ioasid mapping, eg
by authorizing a queue to issue PCIe TLPs with a specific PASID.

The authorization is triggered by the guest telling the vIOMMU to
allow a vRID to talk to a PASID, which qemu would have to translate to
telling something like the VDPA driver under the vRID that it can use
a PASID from /dev/ioasid

For security a VDPA/mdev device MUST NOT issue PASIDs that the vIOMMU
has not authorized its vRID to use. Otherwise the security model of
something like VFIO in the guest becomes completely broken.

Jason
