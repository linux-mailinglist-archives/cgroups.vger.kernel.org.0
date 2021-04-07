Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9715357506
	for <lists+cgroups@lfdr.de>; Wed,  7 Apr 2021 21:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355647AbhDGThJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Apr 2021 15:37:09 -0400
Received: from mail-dm6nam12on2066.outbound.protection.outlook.com ([40.107.243.66]:27360
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345628AbhDGThI (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 7 Apr 2021 15:37:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLaPi+MpVQsMg23AsBHoYsDaUic+nK7PL9PMIprtKIS+K14OOnftv1dJS3eqwSQaa5VCmJjepq0gp6xw5vtUOGZyrVoezjuLPApSDRIxKwbGoVqNL4Dou+A6Dm4Gyg9OJxeAF6FTNVRmr12IEKZjZv1l0FPO/wbZKL3KbHnM7fELyLVQwNlOk8iDWjDqpbdXhGyzh7Q0JSFeneur3KrdoftINkQfhn34Nm0WENZF2YQL4ctuMuOTivTEfUngskPPeGMQFrzbau0xYcT4LuD4CVkZQsu/nhXntZgU86Yr6i/hKtkRr/6t3VOKtwzpcoEqFIq/TISceXUp0HQlebc3ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euujbp5ifWbE/nYFGO+RbLm5+vvP3TSgbVZNDwFKczM=;
 b=isYoftzxRFsMJCqZcEJ/ReeGbsZaL5y/L/HxQI0KXEMsQS/RnZ3bTLqxzcjF+F9EHtPYoIclhaVlWsWDzh0cbs9jcnVU/8D/njNsEnF4GfSt74OG6Eo3jIeRar87By3Va5bacdqPjrgPYSt/gR5z+KtVnThu7R3SMeOoUFDwFpvtv/Weogigbuo73JUDMK1T6r5s0CIXlbEtF/DLhe4gR7vvT//aZe1cE1+VNWcc0hahZghpjA83ZTjn2Oa+0Qjs6br8SUXz80oEy7o7AVkbu7firp5BDn9D1vc2QPBmKgjbVwu+rj2FRV98ibCC9JTNDOQRlU/6yV4wzHu65Ar+LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euujbp5ifWbE/nYFGO+RbLm5+vvP3TSgbVZNDwFKczM=;
 b=THDHycEP+i9Xg0ob2ax4wnW29tB8MYSz8ME+Iz03t8lRsJi5fk1gIVnw11IiL0vii8NBFZa0agCwg2a0PVWQXxmHneNftOAPqyez3zATYiFaFiCdnrhcWLMmU8/s4Ric+v/dTd8NI6CxUQVWUz42QNkMwkA7S/xdlOcMywTOMy5+NMM4ymUNFx5xj3lvqrApRO0lIhAjHdBxk0IFRSWswrHIojxhogFThhT1uOWoYYJ29CaaebB87wKP4V3/sm9naEk8ZE14+oIbtCU2+zTzNuHaL0Xv60iFYuX7ASsrIrHuUaPlE1x9cphpiS29pMQgFe1cmsueOv10XDo1+oTymA==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1548.namprd12.prod.outlook.com (2603:10b6:4:a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.29; Wed, 7 Apr 2021 19:36:56 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 19:36:56 +0000
Date:   Wed, 7 Apr 2021 16:36:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "Wu, Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210407193654.GG282464@nvidia.com>
References: <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <MWHPR11MB1886CAD48AFC156BFC7C1D398C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405234230.GF7405@nvidia.com>
 <fa57bde5-472f-6e66-3521-bfac7d6e4f8d@redhat.com>
 <20210406124251.GO7405@nvidia.com>
 <MWHPR11MB1886A7E4C6F3E3A81240517B8C759@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YG39ZtnTuyn5uBOa@myrica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG39ZtnTuyn5uBOa@myrica>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0305.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::10) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0305.namprd13.prod.outlook.com (2603:10b6:208:2c1::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend Transport; Wed, 7 Apr 2021 19:36:55 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUDyw-002LOZ-Mw; Wed, 07 Apr 2021 16:36:54 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f69ebeb-ff10-4f61-bc0f-08d8f9fc80ab
X-MS-TrafficTypeDiagnostic: DM5PR12MB1548:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1548CFA68C409C0C6503FC4BC2759@DM5PR12MB1548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: st9BVS9EMJPnXTHmaDcNaoD0CMT2u3o3pLCIxUZrVzi/RQCFf7MLstH2qb4nHITlhQSkujSMx8Rzw43FUtBFeBiRuH0N1f2dDNi0fHWR6KrWlNKFO+EhfBsWwKX9yfga/3m89Wq1xDNjlowjOKFpOrr2cS9kNZbaou8neYk9n/2+BkDMMop1sxWhfBreOQNeUC1+7ctYpYK0rnFj3viMv9sarfmSii4ZMDNO/E3R6SZa6la120cfxBxB/pAUctKtrl03fpl5e0eIgRxXeZTHI37KLOgE6UNlybcKJvgdRgbyxqcfxebnJvZxMykClBJa3gcGOUB0rlGlZd2UmLBJhO2jf9JS+Gi91BuZwvG8JV+d11HjBK989Lp1MTqLoRWBZKnroW2FZP95ERJw07CkM1yKHaVyDQKxCbal7onYIRg18n1lNFVpWhK+6A5fN2GObRY9w+nerV+uiLAI+5Vexvip7YeBkI5T8Gu4pqDROH1MXA7L10iXjUkRa9jka+Bae+ffk1fUQf5PSZKhNGEFxhI7yGiKLZ6mkPdft7EynfJwXUnSuenJ71q+ypX7FXjMFsDbOsQAX43OWIqFNw0flxnOObyCO1s82yWIJozBM2jOYd8nyqbOSR1atxqidHm42UAy13l1d+v5PTJ6T6kyxSTgeKDV+sFK0zw2WtgPiw0J6iZZrLtJXxFBbDIh0Iva
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(4326008)(8676002)(38100700001)(9786002)(66946007)(66556008)(66476007)(8936002)(7416002)(426003)(186003)(26005)(86362001)(36756003)(6916009)(478600001)(316002)(9746002)(33656002)(2616005)(54906003)(2906002)(1076003)(5660300002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?c15cYL6TS4ZwNivccLxMyUFXzlmac/920XGLffvEI0xu0gbT9Uzb7qio2Ffz?=
 =?us-ascii?Q?WGqvAI8qOvdXA8HZVXZywu2d7L6SgvRVEDq65RIbjpa9jimUASmsfY+tDBms?=
 =?us-ascii?Q?aFxpVM9octgvnfUiNqbLs4gjkOX8LpEg7eRfcRHoqjfdjtthProMZ73UOD/c?=
 =?us-ascii?Q?OZmkj3lY/r4tbojlctqRWQK2nFYrSNivqd5JAzjKan/GqmEg7SHZRruyjIhL?=
 =?us-ascii?Q?gNFXqrCirrGbGeOagCmHtYKNpFlaMby4N9gglU4HZDqw7DxNbSM8bEQLqyWS?=
 =?us-ascii?Q?kog9qSPARxTygAlWt2/EGkWbWVzyh6yrDUy2tWtNHKiRJNUJ6P7RRLrzazZu?=
 =?us-ascii?Q?uKl+TXXpSyHuya4eyITuQlZ1w9LCbIbcvTXgJCh8DeJZPV+iz/Uey0CSpwla?=
 =?us-ascii?Q?NcseHKeiI2+9YgA1fFEX8Fw+IkV4T+UW/hkywa8S1tSR+b5KViZFrJ7l0VXe?=
 =?us-ascii?Q?W2oWQbDwjmrL2Kcbb37leFlUw7OpgIsAFSiDGXXx9Wwf82jGo6oKjGx9DPd5?=
 =?us-ascii?Q?qj4vtyy1eKAtThTrrTlpnCa4pLsNl/uJf2aYQ8WHl5PINovwh1N9V29ZN7j7?=
 =?us-ascii?Q?zowwnsx2Hun9bqt+/mf06DRvbEuinahxJ6iNbqs6u3RJVjrt+YrYVGAJPYIY?=
 =?us-ascii?Q?g7Dn/g2bP0k0/PUb26Nl4erePzER8cFJMvMMx6v1/wi3F6SF29/ZGDVeHB75?=
 =?us-ascii?Q?dQNdqVoQdI++rRYfpyVQgSKRki/ex8agEaMR64WJTytmmYqzPV9fUBrmnDEJ?=
 =?us-ascii?Q?LH3opclymLqfh+OQw8m9p9ON5ycB7fO2yXB7skWnPY8au7kxRm1zllyzfBba?=
 =?us-ascii?Q?GZFhd9YFzqD6ssHD6VI/UxMnMkcM++EBUUZr6Fa+UEDGMAqfqAWwsk73uV9r?=
 =?us-ascii?Q?N7cTRarv27BHe8QAvcn7UAJtMBZccrrgpSeANvxaTQOKeuBrx5KE+e3aTebF?=
 =?us-ascii?Q?/mquIl7yy1FhPvtwdjqFRUSUuNJuPzjWL/ULrl8VeBrLN7VtZ/noisY+XiRI?=
 =?us-ascii?Q?YR4lC3hss02p4RE8Ad+zF+CLE7Myn17Dz7AjHHFMknpJ2OFkNjgUYx0Uix/J?=
 =?us-ascii?Q?nshhRyNjHtzhPdr5NL8PHkM0Ob8O09oUeZYZ6fnhJIlAsMpQAIhLULirIPvL?=
 =?us-ascii?Q?aGFnAHvqMWhk7XFCdxQSYvJLQ3aZARV09mpFIXe2Zm/zq+m6DZcKR5uoWeNb?=
 =?us-ascii?Q?8wyCS72kxKXE9ypMIoEK2DW3MfittXv/OfA0iEGnRtGP7ouyoxLUIn6i56Tv?=
 =?us-ascii?Q?xif6BNNDZKhNnqj3Xc2N9F8rqE8pFuSKrAIdURcc0fc1TnC5KQe3wxmdv6Gj?=
 =?us-ascii?Q?TiTk++//ugkao5Bu5DT+E180gT7ggZZ+FBIwYi7aZIMv5w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f69ebeb-ff10-4f61-bc0f-08d8f9fc80ab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 19:36:56.0887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAmoSmU5xsq8wHhWKXbS/WedxtBNHemApeSU8AQUZa0Lk103AQ2jDyfgA9gMbjbt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 07, 2021 at 08:43:50PM +0200, Jean-Philippe Brucker wrote:

> * Get a container handle out of /dev/ioasid (or /dev/iommu, really.)
>   No operation available since we don't know what the device and IOMMU
>   capabilities are.
>
> * Attach the handle to a VF. With VFIO that would be
>   VFIO_GROUP_SET_CONTAINER. That causes the kernel to associate an IOMMU
>   with the handle, and decide which operations are available.

Right, this is basically the point, - the VFIO container (/dev/vfio)
and the /dev/ioasid we are talking about have a core of
similarity. ioasid is the generalized, modernized, and cross-subsystem
version of the same idea. Instead of calling it "vfio container" we
call it something that evokes the idea of controlling the iommu.

The issue is to seperate /dev/vfio generic functionality from vfio and
share it with every subsystem.

It may be that /dev/vfio and /dev/ioasid end up sharing a lot of code,
with a different IOCTL interface around it. The vfio_iommu_driver_ops
is not particularly VFIOy.

Creating /dev/ioasid may primarily start as a code reorganization
exercise.

> * With a map/unmap vIOMMU (or shadow mappings), a single translation level
>   is supported. With a nesting vIOMMU, we're populating the level-2
>   translation (some day maybe by binding the KVM page tables, but
>   currently with map/unmap ioctl).
> 
>   Single-level translation needs single VF per container. 

Really? Why?

Jason
