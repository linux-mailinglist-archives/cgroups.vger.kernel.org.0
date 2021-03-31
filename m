Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A72350087
	for <lists+cgroups@lfdr.de>; Wed, 31 Mar 2021 14:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbhCaMlJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 31 Mar 2021 08:41:09 -0400
Received: from mail-bn8nam12on2060.outbound.protection.outlook.com ([40.107.237.60]:63624
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235554AbhCaMkm (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 31 Mar 2021 08:40:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dzdx+1aUTa0KbMQgn3U7AozgJPhi+OfLroDM3F9gWJKWsEhy7Z67zVZhz7ZldjEBwF7Q8opDQYKOXpCtrYiWQNjrpKhZukqJ/F0XG7OqCC3Gq5A0ESGipBnoZrSgf7G2UVWvrxa/fssFPXLd0JexYM23hyfDCI2l7DdExeZnQBNILAmCo2zEYZiI9ia65KqKg8/tdgrAXNhcpwTti8febOvp4uZWuWI12LUKJDxczxjgsstw+JjgRn23tkp3LCx9eP4ms/rChS0xgqjXOv+fEBwf7Fe1FJ6fHyIuOwoSnvk0F3LSimzTOqXJzMTaMcwUl9uf8VSEhwU5Cx8P0dS5dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcVKM3D0ij7l3aTGUl9pb88zuUPJWgEg/62O3PYsYfs=;
 b=Ade1ujgDsK9zZY7faySWJ6ZsSDy6qqXVwQ2sHTItkgIOM4QnVCjbzD4kBx5EHs/uKPf6mcMDBxNDAYl7aVIpoKqWoRwfadI/LdJdMhlg/u3bJ7Txgr6H6MmLu7GSeGCC05ASUy19gmrkEoTLVe6DpuGPD3byaRqKSPXT7a2kE4XIN6f31zLuh+RuXhOLttuWoP24MbXnaFIkSS/+o4h/OIx9nUvac8WdmcorigrHgQDporLF3o5FqMKzEJXrk/6IUtxDRWC/POtH/86w5XcDSEzEGn/UsjxywXemZ6jv63m1snTAug/y06g6+02m/5tRBv71h4zEUN9f7GNfEJa0YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcVKM3D0ij7l3aTGUl9pb88zuUPJWgEg/62O3PYsYfs=;
 b=NnJTukkU5ayOMTbYGAT1LwJSvW6Qo/WbPMWtpjCoV+phePmxXSfLcHcUYe+3GPrFkcLf5WFENHQ6+wBDUpfFQRzaVxXsAfSndhdADkEDZrPXRDePpbHrJtxEnhMNQ5sLkvI2TwX7v57kMwhv/+RIly3uBnTwBznf0Zuo4N2E7Is9nqMnd8iKIgLkfm1VDfMYK+tJ3sn1YIYWQWQ4yXMigaVrOQ2Mk1JzBi0uHB3SqZdars7+pegP7bYsYTV8TMYZDfluNXaUnE5gla9FUsOqmeFKsYXeC1pbMGw2Vtcu7cmcRDv63PUCI/zqS4kazzVOGjdTeiVDMBHw+xlkB3dDzA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 31 Mar
 2021 12:40:40 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 12:40:40 +0000
Date:   Wed, 31 Mar 2021 09:40:38 -0300
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
Message-ID: <20210331124038.GE1463678@nvidia.com>
References: <20210319124645.GP2356281@nvidia.com>
 <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR01CA0031.prod.exchangelabs.com (2603:10b6:208:71::44)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR01CA0031.prod.exchangelabs.com (2603:10b6:208:71::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Wed, 31 Mar 2021 12:40:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRa9G-006KF6-RJ; Wed, 31 Mar 2021 09:40:38 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7be03f98-6c17-4733-f284-08d8f4423120
X-MS-TrafficTypeDiagnostic: DM6PR12MB4338:
X-Microsoft-Antispam-PRVS: <DM6PR12MB433810CCCEE1703C873C584FC27C9@DM6PR12MB4338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdLerwXpr2Kih52K/zNFZddvkUmns+5pJgCD+zr0cN6rEvg+wt8tPN5jkLg9f4o15WeBbCzwObswqI4z1fPfzD9otWyjNoX33AewlPAiOLMe+h2JVY/15AGOWare4kz3WmB2Wq0cmpPVesbw8JLLl4KmFKLqFKKdrVYTqkgoSE7QGgfSpWCyLPhztThJi0Ej/pHwdqEdHeuuomn3u2NdtfBQnpCydtAr19GXA288gBWhSBayUTWqC4fk7+OBqdE9K3NsF/bZtVOVrF4c3XogzFjdU98u6enquydSro3HKnN31aHLzUHFwxLr1ybl/cbNKn0T2maRUG/NqTQNhLhFPv/Cq+W9e5WROVM+81Xkwhu9309V3U0MNuluMlEmoqLb3wDg2qUbl+xANLAj3dv+ijossdP/A9nowE/FGIMKni72iuElV/6bjTuKb0gmFk3ObK6yZQfrxrIO45srBAVrCBQscoent/dfyqSgy3qrJB2i1yp6+XtDcdG9M0tfhB3BXTgPx3yMdZ759O9sB1Zx3P7W3m5Ly2yQbmLD9CVqrzd5Qai4r8cs6jRKh18WlJubBhMcCwwureMdzvIqXN/zxZIM6LJDKaFPYt+Nt7awTET8hRUzN1wnKVwrcAfUydsL8SdOQ+YGzraMIZ3wfv4Uo67WbmvLMUQiNafia9qjpqY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(6916009)(8676002)(8936002)(426003)(7416002)(316002)(186003)(54906003)(2906002)(83380400001)(5660300002)(2616005)(478600001)(26005)(4326008)(38100700001)(86362001)(1076003)(4744005)(36756003)(66946007)(9786002)(9746002)(66556008)(66476007)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?B6WjoLl/W18Yz4q+1d7unSalLiOqEGWzxifmbw9+yQ7yPv++uHC/6+Y0Fl+W?=
 =?us-ascii?Q?f56vaZLV8YmUzO7cP9NkJ41/GI7gVZA3zuwUFkiFChuukZR7yZzF2/gv7I1+?=
 =?us-ascii?Q?qY6JDChQdGbSzRb8KYWF8tvsmEQAx2ZchvE3bgnxObbBNSiI1N1hi2Pykcap?=
 =?us-ascii?Q?i1c7uUU1nNYPYXEPSEhdOYi7txnfx3V77+P5fW8p2Uf6/OjU4Ii8b8lu/s2e?=
 =?us-ascii?Q?i+GiA4XZilidkt68hpL6lYlKqNbYmXt0HfIEK4fiN/1uouMTlpKPzD66oYQk?=
 =?us-ascii?Q?v6Zia49vbNrh/SIQ8XwbRFDzP2DrQ62Rrtd9NiB41oomDe56Zx1soCD6+anK?=
 =?us-ascii?Q?Mp81pUgsZ20UG9orlopjOMO62Atg60mqTmjj5gDUsoQbC959cSEOaVY3oAu7?=
 =?us-ascii?Q?c8zESPvxS2T4pEGTme/oSIRujDdnjyNwMfOTHGrPnnjDBNEMw2rTRzxkBZtL?=
 =?us-ascii?Q?RdPLaeAclh3JpnH2/D0d9cB7aOs91/Kk+SuQ0HcbJVkERJGVglUvPMPJ0Pqp?=
 =?us-ascii?Q?M9krH81wQAEASf79g6niJ3DMnc6GZBwN86vt2HfZDrRpAZQJWdGtPVO7IQfE?=
 =?us-ascii?Q?oIU+3zxan9MiZyuiT8c7B8PotRPDr9Ih1DGnW5HtyS7fU6mXdRgHvbC1pTTy?=
 =?us-ascii?Q?7HxCUqwHX4UUZ1V1CgZBbk0kPHN1k0UHaZxAHerfKRG96aErgZ0u72GW20e0?=
 =?us-ascii?Q?sxrgELvfrkct5BTrRhpGodz+fEQx+L/L80+gyKBlypYiEqCwfr9a1pV2vTX7?=
 =?us-ascii?Q?mAyYXUmjPdmh5yCusqOzNqL4hbCWq0/UAk0IC+ZRAu1lvygssi8umeGEkuN1?=
 =?us-ascii?Q?hBXKFNtyfq29eCZkPRp1JoJZabWa7KAAJupdH5jGVg+BiGRL7XZpH+gXFA/a?=
 =?us-ascii?Q?7EFdBaRxChXprkTvGWJYAkHuTt5/T73EDVF8EGMHebRXDC2gue006q2uRH8n?=
 =?us-ascii?Q?whQv+7u9smimPzmsND4HTVjryrqPYGQmdMg90/bfTOsJTwGmOs0kNcVY0CbV?=
 =?us-ascii?Q?p5/QQVrjMI6yuCg0o5OXUY1ytbkSflOx4AMk/UKrvi44Ae6B2bfQuRPskn/Q?=
 =?us-ascii?Q?sg1EZQTaGoFAIsndgOH3iLZEidAAfjvGO3+z9el+javz4m5v2UKTMW6JZ171?=
 =?us-ascii?Q?rbg2Ao/9y+h4Czy3FC4rcZZu1GPN3wvbLE5GKhVEakE2fcyfIov9MCKBrz3H?=
 =?us-ascii?Q?AIPTXGezIqjpjsA/XyVCQNaYlZyabrFe6Y6HcBCbfv8nvNwRdnL90o+mI4tY?=
 =?us-ascii?Q?9e/ty9d+hYsvCVLT/VfkfDrWrrVF9cyNTVb6Y/4PiHbxVJR+3EarMvp055Gw?=
 =?us-ascii?Q?NAJY/ccKyGpgMEcgFqQetrumM2bNuzwU1eVF+uQquEbfGw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be03f98-6c17-4733-f284-08d8f4423120
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 12:40:40.6224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOshOvDRgy0EHY+nrAEhGinrIErh88wRdx18J6IRFOGZ1x1JijZY1l4ZkLmBKpfC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 31, 2021 at 07:38:36AM +0000, Liu, Yi L wrote:

> The reason is /dev/ioasid FD is per-VM since the ioasid allocated to
> the VM should be able to be shared by all assigned device for the VM.
> But the SVA operations (bind/unbind page table, cache_invalidate) should
> be per-device.

It is not *per-device* it is *per-ioasid*

And as /dev/ioasid is an interface for controlling multiple ioasid's
there is no issue to also multiplex the page table manipulation for
multiple ioasids as well.

What you should do next is sketch out in some RFC the exactl ioctls
each FD would have and show how the parts I outlined would work and
point out any remaining gaps.

The device FD is something like the vfio_device FD from VFIO, it has
*nothing* to do with PASID beyond having a single ioctl to authorize
the device to use the PASID. All control of the PASID is in
/dev/ioasid.

Jason
