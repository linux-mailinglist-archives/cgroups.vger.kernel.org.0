Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FCD3621A8
	for <lists+cgroups@lfdr.de>; Fri, 16 Apr 2021 16:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbhDPOFx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Apr 2021 10:05:53 -0400
Received: from mail-co1nam11on2072.outbound.protection.outlook.com ([40.107.220.72]:59872
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235875AbhDPOFw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 16 Apr 2021 10:05:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/VNDTmuq+VSzfcccKsUmQlznCxqebqlsYn4AlL7Pnk8OoATrnRVQjF+NWm4ooHFMTpvdoNzmsIpGQmTxux0aAr82poFbru3Z9tbohj+jZAphE3fzAjbjh9j3FgfWWAFa42PuLtyBeOlW5HQRc3xOyz209MlvOGw1vt/TW/WkT3r5Ql3005vgfDwIuXTo6DcZ3JmsloVaZ2fF7DGRDnWhkf1rq2s3qsahAgASsR287ZEdRzVamo4O4JqOsSkbv8LJt1QOLJ1DJRvZFFQywzc0J2VnzMbt/z8M6EAvzi2XXP2VcwWXFkj1JAh9qr1KHqirM0dGntcwl0KNZYt4e+xDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0NgyUKoUtcHRz74mviqvi9/LcKudual4GKXJDqQC5c=;
 b=Wqo+W/ydPeeJ27ZAB6M1TRy05Pf8qnmjXEP5YL0Fuk7HPO6cdKmOGi1XG6sjEgUkuFmWbURiPVksWt2zflobR29+CxVR8AAPDGB56rIi/S4Dhj2BAdqRxTYr11gXaaPA6IZm0XClIqiF825ivCOChgpidt6K8SpZl/w8X5AB7X+6LnQt+lzR8ibn8Cckq1hbvRt4+c1I6I0NGWApSyW7215Y/TEuiDeuSJMheLlLYMyjkJ5inQBFztFmJksxishU9PFWRA3b/ZU5kj7icaV1iGPHKMEb3sDKVR431x9sgSHJn2Lu4+MEcDZIe1oLXXRyjTbTpotg/quqKjhJHecXow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0NgyUKoUtcHRz74mviqvi9/LcKudual4GKXJDqQC5c=;
 b=Cz3z0QxDUMf2fWt5ha2QRgfG/61V3tNtxPcXrBifbBL/VCfYY/Z3di26sFm+JgcODnivN1w7i6AsqpQ///WGv0Goe4icuw2VZaC7IB8Rajy91RL/NGNDpQ5p/BrFlWnbv2vwXJAdKO8vY6n4XVn/aT92ZF+Tq7I+BK99O8lWFC6+D3rHa9/FIzL4OMlkC00arktCJicR8/JeDXbWP42YZsoMNTekiobH5VzMtDo7bPP3vF6zU0oQq/QFmV9UNpF0pvFCGu/1RRLxhPl32oFqMUX2lvUhUVQ4GthBzuRA0rEHLPC+13otjTh64x6L2Et448Zl6I6JXjH6bnBKhCFeXw==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1435.namprd12.prod.outlook.com (2603:10b6:3:7a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 14:05:26 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.024; Fri, 16 Apr 2021
 14:05:25 +0000
Date:   Fri, 16 Apr 2021 11:05:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
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
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210416140524.GI1370958@nvidia.com>
References: <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <YGW27KFt9eQB9X2z@myrica>
 <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134236.GF1463678@nvidia.com>
 <BN6PR11MB4068C4DE7AF43D44DE70F4C1C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401160337.GJ1463678@nvidia.com>
 <4bea6eb9-08ad-4b6b-1e0f-c97ece58a078@redhat.com>
 <20210415230732.GG1370958@nvidia.com>
 <b1492fd3-8ce2-1632-3b14-73d8d4356fd7@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1492fd3-8ce2-1632-3b14-73d8d4356fd7@redhat.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:208:160::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR13CA0006.namprd13.prod.outlook.com (2603:10b6:208:160::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.6 via Frontend Transport; Fri, 16 Apr 2021 14:05:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lXP64-007JYX-D8; Fri, 16 Apr 2021 11:05:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79750cba-b6d1-4110-9a1e-08d900e0aeca
X-MS-TrafficTypeDiagnostic: DM5PR12MB1435:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1435EA9FDB2516C0E235284BC24C9@DM5PR12MB1435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2zh8v8ja3Zam2E9DphnttBy2LaT2rv3pRX61GYFFgwKG3c0JKAHnbxS8MOAmKVTSkaP3hTODk8Y85VRX7Eh3q9C3Y0VpP/6wPQxF691JRbk2Q+wQTt97rqh9XMc2DrIwrcDbV8kxBCgM24uSyfb0SsXRycPPIi8YNdCEMFTXIrpjCy7mSliMVOs47HIb+/wF7vje2mT9PlXE9ItXvUm+dQA8YUWF1TL3jbJmPllVvYo5VJGvjV3kShxS3yJa4rQghmzACyjykoV66vRARNBBnVWSkOcRQ9cq/75NX7WYBo9Gych3HkD10bVXmSAdL6n/ARgUZbJohS+a/xOA6n0JWER1z5yPpHnx0oMxUceLE3Qa8DkMOGXvwiqzjQ36f5MMcrUswwJtWsWauGUqXKsyGy7dNrdr5Jlp5HcXQ0I/KwoP4EE6Xaq9pMA3xsdClZPEWBGKpt/G1X8wKtYICYmXAy27IE483wNcjHvLlyUOTZ38vy7UL+oSuSh415jQswx6t+tjAk52t3+OdQ+xwkdO2Ru6rmNUlcdU9RkX29+a576oUdvxW53ZRULXzy5PaMQWXMDd1lKS/RpPdOTMR9fT4z4o1ARxE1eAxRO1AB4JFhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(316002)(54906003)(7416002)(2906002)(1076003)(86362001)(66556008)(36756003)(478600001)(66946007)(66476007)(38100700002)(4326008)(8936002)(26005)(9786002)(5660300002)(9746002)(8676002)(33656002)(186003)(2616005)(83380400001)(426003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/TWYtfMZZaJ99hsMqcBxcIXeuPq1W9YY4zcFXpajzbD7rqwHoBsKHMuzc91i?=
 =?us-ascii?Q?VSWg8OJgeDfL2DxS+wJ3Rxp3lEilLn5m/w4EIOVTy0O0D1gokGnPymGOjaqq?=
 =?us-ascii?Q?7C++kIX9e0SrlDY1JL1E5FUH5beUXxFjnPjnF0D4OTn59za2Tzcjwdvh7aha?=
 =?us-ascii?Q?aW2NNkuqB08pRrKPc7Q2W0E6YulLSX4s4JS8ev3DjxksiWTUYiFegKe0dUvp?=
 =?us-ascii?Q?8/t3IP4sn4PKEMMPUQFrQt1JJnxK443BB4Szc+uS+JfjefHsaFRrs4TngPcg?=
 =?us-ascii?Q?J9LYNuBFFA66B78aaMjEADUBObEZwDVauwlagY/anunqXvDs3aheOC+bVYKI?=
 =?us-ascii?Q?+i4wxwfoNjXP/9d/Gbj4S6B6OjhYpD0mDa5jtMxNYiTcrED5fP9O4HP0HxIg?=
 =?us-ascii?Q?TkytWwQlVd4op6qvFEX9AzqvRegiJ+VlHgm0olUFyZr58yqSxRfzn23LrJr8?=
 =?us-ascii?Q?F+oG70ErwwdFMLKgMl/eH0DG9fjA2perQ7QlPZYnSpbItSmNswN044Cg8Tia?=
 =?us-ascii?Q?bTpNSTz74dU+LlyVoQ3GKoemQSpuypsxsdxlYdY64LM6wJ0GsC+Q6rrKUWXL?=
 =?us-ascii?Q?l/wYVet5GFBbe6PhOp2IXQDxOaWnPrPalkykPyF3b7xk+TOyRlWqXUvNMZJm?=
 =?us-ascii?Q?egaKJWsRP7aCIoFWrALyK4IlLQBjWFTzoOCnfl3Ge3mlQC8RAMsR5bfNCja8?=
 =?us-ascii?Q?7I04YsWAUdeXqj8ZDI+sbpR3Rsd1Nwx7zrwD7BGBufNG9Kryn+5/wzSDuq89?=
 =?us-ascii?Q?HaaE4hkgVQqnAf/g2ulJCD6nJ4eTm+DY/CGgzqtpWEcVC6/f/0nJNK7ZmFqj?=
 =?us-ascii?Q?y2G+Ut8ndx0V2iQEQZDlyfyaeXQjA+XV5LQRH4cqibDggoInF0fRBRi8azka?=
 =?us-ascii?Q?NqSi2lOxtrlaK0EfZ3RQWq91H0BlgMQozpvyXP7hzh4bV3LDtg7tnRklVn8k?=
 =?us-ascii?Q?pkTbQhrqQGV7Vxotpl/G8UTxlolkGU31Uf2XL0XFsq4VgU+ZtWvgNuEz2xae?=
 =?us-ascii?Q?y8KTPVyywaM7iBoM6SfqFlcLGxvQWlE49lGsK2xoyvf5SAmGfdu1K3KM7mNJ?=
 =?us-ascii?Q?qAP4F6q/B4s1VV5RoWONjXviXpjM4HiALn7onAhu4W1ooKl2zDDzrV/fnY1s?=
 =?us-ascii?Q?uWROGuI/PSh66CvTAGsaaaq1prhZfrFIaMRdxi+v1MyDAF0GwjflMtr1ucBO?=
 =?us-ascii?Q?RhL8eG89iNAYQQCC7/4ohKR2IFyieedTsXVLRjbQyDf7SOa/IrZ8n2TT6gOJ?=
 =?us-ascii?Q?kD1LvXp2y70XV5Hsg1Mj1upeIFOX+LXhhTJKHdL7WcC9n/KBv0Y/Sd3Qgv6+?=
 =?us-ascii?Q?7NPgmaxIjH8JSBhUbsOP+u99?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79750cba-b6d1-4110-9a1e-08d900e0aeca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:05:25.7382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2aYk3OAURXsy1Y9iSq999Gbl1jQKYsn7lpxzO4gfo9pHe757xK33loPRFhPXIzX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1435
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 16, 2021 at 03:38:02PM +0200, Auger Eric wrote:

> The redesign requirement came pretty late in the development process.
> The iommu user API is upstream for a while, the VFIO interfaces have
> been submitted a long time ago and under review for a bunch of time.
> Redesigning everything with a different API, undefined at this point, is
> a major setback for our work and will have a large impact on the
> introduction of features companies are looking forward, hence our
> frustration.

I will answer both you and Jacob at once.

This is uAPI, once it is set it can never be changed.

The kernel process and philosophy is to invest heavily in uAPI
development and review to converge on the best uAPI possible.

Many past submissions have take a long time to get this right, there
are several high profile uAPI examples.

Do you think this case is so special, or the concerns so minor, that it
should get to bypass all of the normal process?

Ask yourself, is anyone advocating for the current direction on
technical merits alone?

Certainly the patches I last saw where completely disgusting from a
uAPI design perspective.

It was against the development process to organize this work the way
it was done. Merging a wack of dead code to the kernel to support a
uAPI vision that was never clearly articulated was a big mistake.

Start from the beginning. Invest heavily in defining a high quality
uAPI. Clearly describe the uAPI to all stake holders. Break up the
implementation into patch series without dead code. Make the
patches. Remove the dead code this group has already added.

None of this should be a surprise. The VDPA discussion and related
"what is a mdev" over a year ago made it pretty clear VFIO is not the
exclusive user of "IOMMU in userspace" and that places limits on what
kind of uAPIs expansion it should experience going forward.

Jason
