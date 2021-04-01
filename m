Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325AC351CEE
	for <lists+cgroups@lfdr.de>; Thu,  1 Apr 2021 20:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbhDASXF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Apr 2021 14:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbhDASTD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Apr 2021 14:19:03 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE69FC08EC68;
        Thu,  1 Apr 2021 06:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lp1ToBwc5T2/525d6R8INpD9M0vB0VudvPAte11dvk6LjZaiX7DExexJ1pagl+G5avBe3VXTsCI/aK5svHOudjGmWffm/h8UfJiMvIH3RZNcht9R7FMR6cipCLJf7hpv5s4SCl99Ping2edvbl0j9Cj7lavTrRHCpzoMs9GTGaig9M4euUHeaSS4A1t0aZq0dSQYqvvTfi+Od5FDKnYXL+XlrjIFo6/emppARLN+smekxp1f/Y5/8pHSCxwTdjXMrLIuppWA7wGM38pzae+iCsFmGrVKnGzQmUBlV0vfH5l0dxzm8OwqzJwU2J5jNOMcIpLiIvBLIqDKTrSuaBPwag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsmoWToKgEuO9q8+ezLJ1l1ZNZ7WRArJNMv+HLs4XY8=;
 b=IrEuGXCEDeZ+4NthOpFOAUuducOwtX00Rac8+cFfDasVKZBlW6YddB7V6sQgYnVENE2ma2y7qBnvXzUK4Sg6+C9m9BI87tkYjJQPM7OIvVi+r16QQOv3E0NnkMDI64YYb6HWmon2MLR3/ZzoLbCcrkAII+kxmkIJ74nMRY5cXmdERjWb1PwBPIf8Tcq/BEaPmg0gDVhXzUu/tMwb/92aU968+kb1/kruHFwsf0up35o+ds/LfjpJmYoXOYuhhQdxzPeg8y3y0eTtsLLsAWUGXx0zgW19IAJaXjf/01m1K591kIqEk57LDOdek8Q94aqHtZgE3M+weAQ1E0BKSIzlDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsmoWToKgEuO9q8+ezLJ1l1ZNZ7WRArJNMv+HLs4XY8=;
 b=d6F6d3zM6tSVvQhCQhG2PZxTAGJ49JvXYr4+36eB8HNI8ut52fXZybYS4+Axm16RrrQpNzeSJW9EcyvnvsjS+7WndNDKK7cRlyYU8uvZMrqovBqBC++wdWuiHgVtZkrCEsaJVzWhSLH8SXZf77ZbYzfsTaT4sNphBf3/wmurKOxcMZlwvTMxmy08sgATMwESg7M3ND0dRk2kKYRIZqDvB0sMc6P9RsmyVw08P/L2HTjdZSrI8q1RFVrJYCjEfmoaG/A/+Eu39HFHt5bJjB4OmcW1cp0791wi77/uOVElejZMzQWrpHezQaGI/Lq4UJ102HRHxfuDKM6XqAYWQcNVQw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2487.namprd12.prod.outlook.com (2603:10b6:4:af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 1 Apr
 2021 13:46:43 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 13:46:43 +0000
Date:   Thu, 1 Apr 2021 10:46:41 -0300
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
Message-ID: <20210401134641.GG1463678@nvidia.com>
References: <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401114648.GX1463678@nvidia.com>
 <BN6PR11MB406858FAC3821B84CCC4D30DC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401131533.GD1463678@nvidia.com>
 <BN6PR11MB4068C1A040FF61B4A9ABBD9BC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR11MB4068C1A040FF61B4A9ABBD9BC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0366.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::11) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0366.namprd13.prod.outlook.com (2603:10b6:208:2c0::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Thu, 1 Apr 2021 13:46:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRxej-006l8a-0o; Thu, 01 Apr 2021 10:46:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07b1138b-5466-46f8-bd74-08d8f514956a
X-MS-TrafficTypeDiagnostic: DM5PR12MB2487:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24876248B1DE5DAF24357174C27B9@DM5PR12MB2487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iyL1AdWckrDcijz3IoQRtPbV2QRqOtUkE0V6X8PtzW9q4MYQHwaGm3WagaGEjdEpXX8LLxjNMxPZpv5vugB9AT58a6AWTw1av0PtgjDwrWat1UMmIXfwxjtqXy3Q9M68PSx9zi3M0tFms0ObtDDyCl4nh3NDS9MouiliZe9u/wi5Q07vr0vgF8/wqV/zlRsp4qOtiFTVGVFBKQapSVAJWfEn4qZ0VYdqn8G7S4l4cDQQREspmvz3TFxnsKJHA5dVhQEgkuKyFjwy253Vmb+TzNKoSn1k55wMI+w4Z6pWgR19pYVGc2xeMpjx8TfI4dG03KnZ8Xyg9Z0iqrR/RNKz2lasp+52l3VUMdHoym9dBiMpqQ0G/OPfwAnX1lt090bL0ag4DpZWWmBNjhRmKIHM2ZjemmzEt65jkwQ5sGf33nLWye3jviORLtzo85AGPStPu+MysZLOnzyhySHOQKnvBP0vrwJibxcA6lC1nBIid/kO0izDhpdvJiaYUHrAUitYg6b/XWLosU3kb50mwJS0hhjrs6rJqVZ/LJlinsy6NjChWTxFsmqHB84FgHHaeF7D2deRf0OoAfhH2m4Ln4Qkt8/2OXfqK7GCMySPfGTVi3u1sDV4xFbsoRMGvU8tFrCMIjFtVqmbzj20GQCa8R8doClszPbWVbrOVOR3gXceemA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(66556008)(426003)(38100700001)(9786002)(66946007)(2616005)(1076003)(316002)(36756003)(9746002)(6916009)(478600001)(2906002)(7416002)(66476007)(26005)(186003)(54906003)(8676002)(8936002)(5660300002)(33656002)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nJNvbc/lh7Uh7bilBSPZKdCq/ed3Yf62n6UNA1+UblagLIHx3T7j4VkVrF2v?=
 =?us-ascii?Q?TOmof/C+AJrn1qLBx4sEIb5XK/+6L9ABHBjP6zsJL2l1SpWrw5zwGrQYZ6xq?=
 =?us-ascii?Q?w8UEnlB1VGFEZ7J/kvYqfzAhzikXlrNC730DYeRPsg3Lh6w05VLejo+N5RV8?=
 =?us-ascii?Q?yxvfDljle0CDEj6BmOpt/ArSl7QCA2FETL7s+VYfk7KJ/4SD67LG809I0K44?=
 =?us-ascii?Q?+CKSo/uRPy1uliANJZP0UwXYV27QEPOQ586cbYwqmt5dHjboeZS9MAB4SAeP?=
 =?us-ascii?Q?Vc9IABc+lSOBEvL5uARIp+oWF1bCxLUWLS9vq9Fip1w18o6HgPYqktszl9Wl?=
 =?us-ascii?Q?M/QCNEDg90HNf+q5+Fu0C7+jRaZg1v+9an0zYiWWaGLHukBHNnJO0xqbXHul?=
 =?us-ascii?Q?mjXSNdR8LQuw4yIVs0bo19jYm4rMkjz49OZluGWdGBr45cjdqYdDIAqq4hg8?=
 =?us-ascii?Q?OeLIj9XtT0P+yvx9Q9XFHiPH+TxRwXXJJ6cXnFCLwCkFCVpBfAVrYIJrbUli?=
 =?us-ascii?Q?zJgFVcjegGmEshEGkybWqkdr12CRI7x0V+awpgfIPYWLCTHwAlLdYGn83j/y?=
 =?us-ascii?Q?WY7mVfSvhMlv23M29ilDxaXkcD/UhI2Wt/uaZRIZu3EP3WHFl6BqSusJpehd?=
 =?us-ascii?Q?GBbuy3FmQqAhx2MbLTncvk/dOLXNM6MqFrh3On8bZIvKmYdl0VS0HfFWvoij?=
 =?us-ascii?Q?zfaln9pYh5Al4LismLpkXg8iHM2diiVI/u+BfNRMpjjq6l5Sg8rcwXP2y0nW?=
 =?us-ascii?Q?EbHKDnBnYv87Ib5IAiyX9dOUCIb4kZM+d1HMejmkUoEcf2hotkQl/+7LpyC6?=
 =?us-ascii?Q?/ZS8OE5LJ9lyGcOJHn2zVnDODupeKtltoY06IYiomWrriBQ8xLcGS8f897iO?=
 =?us-ascii?Q?559QP33IV+3hTLkDJRgukOPRya2K9QqhTBqkI/EJYUoSgF0LMOm6l5wiPLrW?=
 =?us-ascii?Q?1MtSOPu7l4sjd2vCKT7GdpVVz08x1CHEsV+B7g2BocPP31XOWB7yJ5ROBLAw?=
 =?us-ascii?Q?5rMlXhthIIsueDbuKNosSmGCj8eUq+IogRVuHjOv26U/Y86ppjxh7miziLoI?=
 =?us-ascii?Q?Q505gDAq52+024bQYJy+NvbwPbZWWb3mA/FQZu0euG8TQ6Nk5xY0EQOtwJ9d?=
 =?us-ascii?Q?6im7b9VCyEsVx4MNdBmzTKF2kRjZRNR3IeivQfVlPncVqbpveGFp/xgYQGwO?=
 =?us-ascii?Q?hSqCRsf469f7+AEfwJaOjypxrl42WSR1eWADKdOE4c9E/7gHlq1bamxtmgU/?=
 =?us-ascii?Q?34Pio6rSGuVBtTCg6zqhgpoEDYgUzTTHJb62uD4cbyL2v8OcNJlMxRRjj8NC?=
 =?us-ascii?Q?ECzKKN7WKdY1P2B0pmi4jPE1j89QrvmZxeXrNfqWqzXibg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b1138b-5466-46f8-bd74-08d8f514956a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 13:46:43.0954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUvgX9+xjWAOMdJwvP2vg3B17UdIwzX85jL1QaOFK4J0UIdj6m9Qu2JrTghM9ny8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2487
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 01, 2021 at 01:43:36PM +0000, Liu, Yi L wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, April 1, 2021 9:16 PM
> > 
> > On Thu, Apr 01, 2021 at 01:10:48PM +0000, Liu, Yi L wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Thursday, April 1, 2021 7:47 PM
> > > [...]
> > > > I'm worried Intel views the only use of PASID in a guest is with
> > > > ENQCMD, but that is not consistent with the industry. We need to see
> > > > normal nested PASID support with assigned PCI VFs.
> > >
> > > I'm not quire flow here. Intel also allows PASID usage in guest without
> > > ENQCMD. e.g. Passthru a PF to guest, and use PASID on it without
> > ENQCMD.
> > 
> > Then you need all the parts, the hypervisor calls from the vIOMMU, and
> > you can't really use a vPASID.
> 
> This is a diagram shows the vSVA setup.

I'm not talking only about vSVA. Generic PASID support with arbitary
mappings.

And how do you deal with the vPASID vs pPASID issue if the system has
a mix of physical devices and mdevs?

Jason
