Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFFD3747A2
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 20:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbhEESBp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 14:01:45 -0400
Received: from mail-bn8nam11on2065.outbound.protection.outlook.com ([40.107.236.65]:4904
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235293AbhEESBY (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 5 May 2021 14:01:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTGKIu9XiaueSzBevT3kv5loLFYDgLtbRKwDQPqKGhzSX3pKTsEoJKwc7GzE+yHdXXIM3pAuceZZGjPUJRVqmhWblluPAlyLlzAOAjjUwc9vMUQ7kl/YBpSIanY1cARXUyVbUad8djNiXGBs7/WQ82q1nBcRbtL/b3PDRK0lgkPY9XphtwsOJegZPlgU908CPFx62zKlm7a7NYIjfEsixuLUPta9Ui2nQgB+Rf4Jlv5QrJj9FuqS5H7Y6yYicyA6YhVHGMzoHXHHgAwmc9xyKKJHU2chLWFChdzc5zQgO+OnDH5acXG4wCPNSqRVIsjtT3ovZhZFMnPNh+gErIRIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7t3qOLU0208V35Nz1Weuft1zIeK/D1DjiNEntiBlHlI=;
 b=e5H70Wnj57VCNSnLMO9LlOtJ1vc/1APB5Vga+Gz6qA66BZi8OUV0TP00ivrNAJQxfnmAQ10P+o9OJWtrqnPhz01aZYkeKWakjoEy75RuXtbDVd0TUwCQPa0EPJlsT9Hz9nQxwSwBlvuhYJ8xfWYDsF+BtqzdkmFyxrkNxjT2lyNLutphxFQp9+uRg4gYbeDQdqlvvXaDdGd4q5mOXPMVV8sxqJOK92l5oyZzStLkXXEbzfuvkzFRKgSkfPqbVei6BH2nqfV1pV5qBt5PmqLGa3Y6hzLM15xg9yfP18w78H1+kN+CaB20zmiHqYic1ueHgs2+MgBhBfguhW5MPc6XDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7t3qOLU0208V35Nz1Weuft1zIeK/D1DjiNEntiBlHlI=;
 b=p6YTqGr4cSwlIiSywQVS2Ya5rd6JeSHLYQnDMfNRQp8Br7vzBzuGgqIORz66AjjrwUthlFcjfBrSiUDC3+JGyUIz7386ERCHIcxkkOdP6Rl51QfN32/2W9CMoo9+ipMxRZrFsJ9yiWgFrnrPaKWnJzvkhLqqgU3CkP+iB56rk00hxGFoUhXQBe27ZUiEUW8INaoP+sbPeZa/AA0ngBv5tTAMJwsoHo78nGiHFAaR6EShTF6B/My1WrUExpFJ+rwEvoqQalO76ZCkPCQC6PuuicY/7lLPFNRKOz18tsxbiFEwDk7OoQVM96WmdCd+nE8XmnZUyYbINWX3mwBoJiCWpw==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Wed, 5 May
 2021 18:00:25 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 18:00:25 +0000
Date:   Wed, 5 May 2021 15:00:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
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
Message-ID: <20210505180023.GJ1370958@nvidia.com>
References: <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210423114944.GF1370958@nvidia.com>
 <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210426123817.GQ1370958@nvidia.com>
 <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210504084148.4f61d0b5@jacob-builder>
 <20210504180050.GB1370958@nvidia.com>
 <20210504151154.02908c63@jacob-builder>
 <20210504231530.GE1370958@nvidia.com>
 <20210505102259.044cafdf@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505102259.044cafdf@jacob-builder>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR01CA0063.prod.exchangelabs.com (2603:10b6:208:23f::32)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR01CA0063.prod.exchangelabs.com (2603:10b6:208:23f::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 18:00:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1leLot-0017t2-O1; Wed, 05 May 2021 15:00:23 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4031f73-d8dc-48e0-57fa-08d90fefa86d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4267:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42672470A65FA02F2A6C9ED0C2599@DM6PR12MB4267.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d5CQdFNQQjeuYy8D/orZ0wQmnGbKXk0y1vW4hs4xxs1uQnXixDbvCnmTTvIxlCISqPlA0O65+EOYjVHO32bnZfCLOYNdZPGhc1Tr7B2ASh7b6bQXvATtsm+tDEaDZDCFojxs30P4U3mlqSIIIiDk5JjGL5qxT78I9svHfbCXhEPhvDFSqMoVw8dF4vAft86/eVC7XW7dTdbEqGb2tLKaCy71GWoDF0RxtqjidoQ4ghMWO4ua1NqpZvonC6LG/YxUYQbgUdJqCQgmfTOS/H5Xh04j+e/Rr/IaPnLnSq8CZI7yNr1NCUEm/CFbMQBAhUKqh9U4jUiTC948Sb6QlJ4uWx1xGqyEei2Oxuk1tyuoX/7RlYppGq8nViDZXwCP8wIhyxxBnM2CfgJhkXsvbjnlIRgdna2E8/pjqvcR9WGGpQ2TK9qgz19B7Li0n6++fyPzuc5JthU1RU27XizXna1R9vHbWaL2ClbhxOKZU58GWkZ3HHu11YR8UO0BXk2BUV6/OjJuN/4vp0lninj4PJ8q/z9TZuh12aq8GCX54kT7zlpqn5w9/cyfiXbMZ6m6rSRHA2oBFzMkP3/h1bU/GQ5657pDiofvKtGiG8g7qbnWz2s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(33656002)(8936002)(54906003)(478600001)(2616005)(7416002)(316002)(6916009)(36756003)(1076003)(4326008)(2906002)(5660300002)(186003)(38100700002)(86362001)(426003)(66946007)(66476007)(66556008)(9786002)(9746002)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nh1GIgXZFE47ywyoovY4BlzzANuKo2+kE/f8uDBA0mRerTYALBtMils5OIF/?=
 =?us-ascii?Q?wa4NVQ6pJtRcqbEKo05SF55kDvbzQY+eZrslUhEgNWPpUfQPrjSqLew1HbmB?=
 =?us-ascii?Q?rVnS9Ho03Xp/o8dr4vylE7LdqmEir60SK8pbT9kJMTcQaa0iKTu8+YyvNlpt?=
 =?us-ascii?Q?TSjfTveHII9BFoZ10L7PB8uO5XBpH+C+3Bxaq2lei7dFAVTbtiFK0AiZrylf?=
 =?us-ascii?Q?5tsNyf+4Vipk7saI6gf9Sz3bfW9VyllVLVVGirpy812Pq7rxdD02S/H+wHBS?=
 =?us-ascii?Q?XTVpvPMxHMn2TWOaHAIthynw4P1vFN9/n4dKSrXWqFk+KiPMvVOegBP/toSJ?=
 =?us-ascii?Q?Z5l2XcN/Nc9otPqlKI+bLPk3zTPHvTRoyPpKZ1ksgeZACpQQUxolK5mjptRQ?=
 =?us-ascii?Q?xBpHDeieBx5YuCTAd7ruI2ows6gQHQjx65obzezGZGJFGnVilORW6mJqEmLS?=
 =?us-ascii?Q?9i3YoIiwRtDkaUedcZtIE0QTTZBAHy1XqazOMtZdl/zqsKsd+3gggGwM+UZ0?=
 =?us-ascii?Q?wH+E0xqpR7FgbJg6716v7aFyvWqdi981hybRHzSVnoEAkeDZ5LXikg99tH33?=
 =?us-ascii?Q?kHO/5nquT9R63YVTQJN84crN5mQGaWXXqLU2iKIPJFsqUCDbqfVacJCQmIue?=
 =?us-ascii?Q?L2tX2d9pTfwqRFdeDgKy8WokYALmS/AMazifatPa9Cityr/qgF5xcSNMSMa3?=
 =?us-ascii?Q?IiyUQr/hHwwcgxmgyBvkqUPcP3JgK37MRh+wZgPyGsedF41Ort2JK5EZGNe1?=
 =?us-ascii?Q?L87rd/aO/xP4kdsLT1GIry/WzuowbPDTMuiHsY3brnSyDyFf+OQB9yKhpd6I?=
 =?us-ascii?Q?rnFSCbKuY4rXA/QQdKz7HV+8RZY9XLXirUpNscCWEImg4jF3Z96wXowwCv8T?=
 =?us-ascii?Q?qpvyVeF/y8+P1ki9uo0biaA8XLsNytY9jG/hBSRDbWvwsokbybDRmrBE7+Uf?=
 =?us-ascii?Q?jZqKsku0gufr2XAEnfSEuCY44yP+Qv/HKLKso93yNkIvbjtmyVAvdK+Lww96?=
 =?us-ascii?Q?6tegdQ7GYx04g5YREA8AHp5hlNejLCL5LC66m80eff1qTnaQGMM4LX1YEbn+?=
 =?us-ascii?Q?WWJEMn2Qj+owGXPZbpdiQrbHU1PiDkXRbWRUdLk6BNDKxrGzaxFi7CQK1pST?=
 =?us-ascii?Q?UT+kMjGSPJFt2fykui3PvDIjce6eZZCC54mmR1TDJhQxfWaumB+vUMUZdYA8?=
 =?us-ascii?Q?MNyIVDnDwEo9XOmh7UHaGQBQI8Qvm43HXneddNDUyiUC+IPNW1dvHpQ7W3Um?=
 =?us-ascii?Q?NYSoV7c9V5glaFzAvHWXO0Vhk3fXPenZMnjz5mqCE6Wv/Q90ywn3pUaW3DJp?=
 =?us-ascii?Q?bAhlmZw4QcczKzUaWuIBtrtH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4031f73-d8dc-48e0-57fa-08d90fefa86d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 18:00:24.9982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7v5mi8CtfDsuvdcwgvhyaid9Up6UUbGgldp4YQJN0b7f4EAB2fEN7bcwC074F62
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 05, 2021 at 10:22:59AM -0700, Jacob Pan wrote:

> Global and pluggable are for slightly separate reasons.
> - We need global PASID on VT-d in that we need to support shared
> workqueues (SWQ). E.g. One SWQ can be wrapped into two mdevs then assigned
> to two VMs. Each VM uses its private guest PASID to submit work but
> each guest PASID must be translated to a global (system-wide) host PASID to
> avoid conflict. Also, since PASID table storage is per PF, if two mdevs of
> the same PF are assigned to different VMs, the PASIDs must be unique.

From a protocol perspective each RID has a unique PASID table, and
RIDs can have overlapping PASIDs.

Since your SWQ is connected to a single RID the requirement that
PASIDs are unique to the RID ensures they are sufficiently unique.

If the IOMMU driver has additional restrictions then it should raise
the PASID table up higher in the hierarchy than at the RID.

I think what you are trying to explain is that the Intel vIOMMU has a
single PASID address space shared globally by the vCPU because ENQCMD
uses the global vGPU translation table.

That is fine, but all this stuff should be inside the Intel vIOMMU
driver not made into a global resource of the entire iommu subsystem.

Systems that work this way just cannot have multiple iommu drivers
competing for PASID.

> - The pluggable allocator is to support the option where the guest PASIDs
> are allocated by the hypervisor. 

And if the hypervisor allocates the PASID then again the specific
vIOMMU itself is concerned with this and it has nothing to do with
global behavior of the iommu subsystem.

> For ARM, since the guest owns the per device PASID table. There is no need
> to allocate PASIDs from the host nor the hypervisor. Without SWQ, there is
> no need for global PASID/SSID either. So PASID being global for ARM is for
> simplicity in case of host PASID/SSID.

It isn't clear how ARM can support PASID and mdev but that is an
unrelated issue..

Jason
