Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D6B36C99C
	for <lists+cgroups@lfdr.de>; Tue, 27 Apr 2021 18:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237782AbhD0Qks (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Apr 2021 12:40:48 -0400
Received: from mail-bn8nam11on2071.outbound.protection.outlook.com ([40.107.236.71]:6318
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237796AbhD0Qkl (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 27 Apr 2021 12:40:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmASETcHAvoVd+Qk53dUuUGIB4qWowI5b4Ku4hWkXRM3WfwPvLH+rE8Rvg+wFN8TOZxr1jcsxIh8G3eqs1cptP0RyP/2dTc6fUJDo+hbBwAHyZ7aBlNTk3m86zKf/WEu2yJ7oQhG2RG5Xl5wOq92OPo9FIEyMPrlnDLpR9mDEHhMCtGe39mt7B9bcGy2vNO2YLn6iNQgMUUOBNNx9DkeXcBluSIjRJ8dU7WV6f20Z3na38O2EZy7UTtzVFlPuS3FDELZAdNLuUc6hUXsQn0CizlyiGEfSOTBb0krdNZSpW2Q5ovhQG3rUpm8ktykaAzt2XY2qRGrYZFyPawO4ypnRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCBSDtTz9Mi9G/WR1q00RSBZ0mrGjOiilxBNVEhL9Dc=;
 b=McfrlmmtzXol7/2nnwIskYKUTbx9P8g5zHkdnEx0VFV97meHllZL38L9PVtBad+WVkYjzffJqAyx4evz9dX9NdOn7iaIV46wlFoB1ny8y9EJFPO2gCfKCogs4LDf/YM/4KxB3UPj6A4BTUXCXwC/W4wmZfkfWogqVDA6aciACBcCynwxw3zAZwi1NYfKfZPsqYtMNM6l5YhvvwqTjuEMPvSS2HUWLsr9LqtY3s/AH3GKayB5bWL51BuRBp8mbqdocfRJnZPIcw2muEopD3WJELqHviMzzmMFlIe++hY9f/F+r7ridBjWp9/tKgkquxVG9R1ulo18KBJGk+MMMpI+nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCBSDtTz9Mi9G/WR1q00RSBZ0mrGjOiilxBNVEhL9Dc=;
 b=Bxd7u7/6xqV8QR/QYST/eDZZKz3gjc0z4SYiGkg2i4CtpUfOqYzQSebbg+b1ov3hgo/qy618v9UK+V4KhUAjalvwjtCQwyLYGyc8ntUkY4g4UM2wd7hReZ6B/PIsQbyBtDcxBCnBw1r0vx9FZVWgLuo1yzmSADibQzCM7wjwmVhjBJ1WBAdegmRqbLORop4aQKBc2zF+TzX0Cia/OtV72kuI+76j4kBdXObW0q23OwkZ+o/TQaFmqF55sLu1HDo4kO6uIKfhflu4vgEdSQmupZIe2WnwJ4VQD1XQzSn8/EzrnsiNMYQ/17qX6XvtmKiIl5ugTe9bMylISpYNnnnH+g==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none;gibson.dropbear.id.au; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2581.namprd12.prod.outlook.com (2603:10b6:4:b2::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Tue, 27 Apr
 2021 16:39:56 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 16:39:56 +0000
Date:   Tue, 27 Apr 2021 13:39:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
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
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210427163954.GC1370958@nvidia.com>
References: <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com>
 <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com>
 <20210422233950.GD1370958@nvidia.com>
 <MWHPR11MB1886A98D9176B5571530EF1D8C459@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YIec/Rt7OxvfFw7W@yekko.fritz.box>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIec/Rt7OxvfFw7W@yekko.fritz.box>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:610:38::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR05CA0051.namprd05.prod.outlook.com (2603:10b6:610:38::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.16 via Frontend Transport; Tue, 27 Apr 2021 16:39:55 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lbQkc-00DZci-4Y; Tue, 27 Apr 2021 13:39:54 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bb06bc4-d9af-42e5-070a-08d9099b16d7
X-MS-TrafficTypeDiagnostic: DM5PR12MB2581:
X-Microsoft-Antispam-PRVS: <DM5PR12MB258158B33EE6B4B8F46B1E8FC2419@DM5PR12MB2581.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CEibGDpBtb2aawuBuQisgBfGXGHMfMeuDG75xx7ZToszIitU0npWefZqt5asA/HPtGLYv1DFog0n9irOANQKIJf1xdSQe4Wl7KnTn4o/5O7zZcsFRc1gOx+MmCeezy71bmtPpN/CyShHg1rVJThewAByyytJEEcyXjMh8em7dY/+w8u7gDLc6fjS06khZqWZuoQkrmWpI/Rmlj18pXtnEt0Hin9QI+a/fJ5tPG/tdHL43ERN6rJYbFyxoFye7Dh7MViQP5EFpo7aoGRyIYZF9e7P0CI6/JtdKh+9Wky2r/+K/OL76KUW7al810ngIL8MsrNlpwVXhFAx7acYHJDtiusAADY5FMdnaLDqod3DrfwoXMEaF+b3xBHjJmW4Ed+W5ipboYVW2EROOwvPZTufOK2gW+abdid2Jl+l6qi6UreNhALWYMSS2bIGIsxhdyJDpQVkN5MbJCaNhFXWOTIED3VUsJ4GI4DhFnWHYFAH1kfGmoZ0t0R7h+rALBNuN1lFTQE/9OJRrXRHF7OyeTUpPSaSxRPMHXSrkFx5l9ABj03rB3CUZ7XlSFZOcF1JYVGGaw8EBS4KReznIAjBxNcKURaiYXEkH5HEBPly+9u9CHQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(38100700002)(186003)(8936002)(2616005)(1076003)(426003)(66476007)(66556008)(26005)(8676002)(66946007)(5660300002)(7416002)(9786002)(2906002)(9746002)(4326008)(36756003)(6916009)(478600001)(316002)(54906003)(86362001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wSpayi0ox2nw91PnJ5bwbb4Srn3eodiu4PiXilByVMpEq1oNSZkvDprGBhCv?=
 =?us-ascii?Q?ykjoQXbCqnrpzQeqrRyz4xABKFzpbf6kvW3Kr57RCzGEmuBQbyPsAfNTciG/?=
 =?us-ascii?Q?IHEpMbftYmqMXBdb5D0+kJj/ZPt+86WaL8LYEEdP0dLB0hBfOc+s5R5oV7MT?=
 =?us-ascii?Q?ptgGzPzUC7edvuahO/7rV2vk8Pl2zKfoJ9IKs0kc++HtHLHj55wybBAQ94mU?=
 =?us-ascii?Q?vZatpupZ6ZLHSfAv4tBL4O/oAhXl2fxnGV6Mb+zRPKsCe5KGxc+O/+nI4Dn+?=
 =?us-ascii?Q?jkaaZlDmKfZsgq/z9w5kyKpuvsnmv1pSDYy6P9MQzcSXUJTue/pe5UzV5WZs?=
 =?us-ascii?Q?nXARyQqN2+rqoZAkGO/rVDVl3I4+eSVeY8qbDWNjtjQa7H1QDRJOrGRZJnaR?=
 =?us-ascii?Q?wIdXV+atN0nN6sGBZR6cKEAgGDGd5raGIgIg6CCLATN7RlEgNrYMQpNeXuys?=
 =?us-ascii?Q?O9qSeu4Izz79BNRarYhxRwarwuitLBzCLbq40LHPQPZXeIiZfCJXudLkdUcr?=
 =?us-ascii?Q?oipuIu5WVbXz0RsWqurFol5Y4+F0cbKaAsOmPr9UTtNyT3ZmmeUkbEX8NGbF?=
 =?us-ascii?Q?6uKFeovcboXY5nk07yZDM7IYcTkzHqY1EBWSQSukPQHvperq7vvvIQ3McNh2?=
 =?us-ascii?Q?GugtUftg1j2YbkBwUS0i1CnIFO7KQc0Kff+K2tqyDuISNw48BguNQY0P6zk3?=
 =?us-ascii?Q?PIqBdwDYfVTyuIB04CintFNinGfBQqfoKsIMGYdTmPn1unrqD3pvL4wQBBY2?=
 =?us-ascii?Q?/DrrvKck25UiiiIBKiAhfoE0eN8g9YdXFarirP0zfuXBQee2+D8QQ+qjXn/9?=
 =?us-ascii?Q?70zvrIMFyUxGHhPVVUs/THEsN1Ou8X/jdEfmMSbNqbo6VYF/xmLfs2LvMR2+?=
 =?us-ascii?Q?pcMEypGU6mRJKblPs1tYDf5yql9AkN0R2yHniL7KM5IGpMM8GITljuV4h9+m?=
 =?us-ascii?Q?qWn5tlqNGiMf9P30MBBC0Hoe884AonADgE+bmNsNw7t4cjGYVur48+mRdY2a?=
 =?us-ascii?Q?E3CcDXf2lYXUqQetVDm/PgSbBT+0D77oOcI6OPhBGvla9Wr8gOfsirk1fTgd?=
 =?us-ascii?Q?zdWVKm7UKubI1/kUPXYPzevetD3ON7r1BODbyCHAHBa7P3A0aKC0WT/66hN8?=
 =?us-ascii?Q?XzzZhQvyyyTpa0gnf+vaPhImSaLuctgVS4srcX0H6FXHu274AOAYf6DMJKOr?=
 =?us-ascii?Q?melIuFn8A2If+N/7bnQRwLQWR7SNE8Wh6uVIjuHzRQxMgEwxtcB1P0Kt1QUr?=
 =?us-ascii?Q?eM6Rg7E9/uyUHlXq2ccbBlXip9S1oh4jraM8Jg0zFKcRgUj4yNhppfotc0/t?=
 =?us-ascii?Q?2yq6zV2jOCSAGOcELoAywFrv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb06bc4-d9af-42e5-070a-08d9099b16d7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 16:39:56.0795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0xDPGnTNw7K4hU43ptUgHQXCCsWZv31a7t4B0ZO061cW5t4wr5ZU4weEQs6rEgG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2581
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 27, 2021 at 03:11:25PM +1000, David Gibson wrote:

> > So your proposal sort of moves the entire container/group/domain 
> > managment into /dev/ioasid and then leaves vfio only provide device
> > specific uAPI. An ioasid represents a page table (address space), thus 
> > is equivalent to the scope of VFIO container.
> 
> Right.  I don't really know how /dev/iosasid is supposed to work, and
> so far I don't see how it conceptually differs from a container.  What
> is it adding?

There are three motivating topics:
 1) /dev/vfio/vfio is only usable by VFIO and we have many interesting
    use cases now where we need the same thing usable outside VFIO
 2) /dev/vfio/vfio does not support modern stuff like PASID and
    updating to support that is going to be a big change, like adding
    multiple IOASIDs so they can be modeled as as a tree inside a
    single FD
 3) I understand there is some desire to revise the uAPI here a bit,
    ie Alex mentioned the poor mapping performance.

I would say it is not conceptually different from what VFIO calls a
container, it is just a different uAPI with the goal to be cross
subsystem.

Jason
