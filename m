Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289CF390B27
	for <lists+cgroups@lfdr.de>; Tue, 25 May 2021 23:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhEYVTq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 May 2021 17:19:46 -0400
Received: from mail-dm6nam08on2057.outbound.protection.outlook.com ([40.107.102.57]:7360
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232526AbhEYVTq (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 25 May 2021 17:19:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fg2QllQSAFbUWgY+b+/qYKfQnlitIV9IYcze/vbaWEh6Ohphhzxc9DGsF2IgELS93AWRLqFXRZ513tATv5uc0R8vP8ZuQvGjxpl3VUWj6hxmnb625w+GiTQX0W1840czVn0/WF7mq8ZdTeYXXU4arSOxSMYpjbhhdMf36/NyPzS9fWk4h4YTURWUlMrqTAXBwxmwqFJ4kqaxFE1WCPvDnCMLq+hEMr154WvULoCp9A+9gDihtZuxl52kHPqtExr34FSAgPdzo/49nFWxeA01GeT2GgV3URx4bRvnuVxG8dYOwoTOCgkrQAa57O/d5XGkORQMFiQPBNllHjW9pcN1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RG+TkWyAjgSfV57JTYBN5pfP9qi8Aer6pL70Iw1rpRc=;
 b=QIkQAut1orWelc9nyHhIHH0Fnmjy6Di5UAwt/0vZSkl8EcSEOoLKM9o1+5oZY2dgo2gvfZk4dM0C+F4PVRhO89Gj9QKknE9DpWSsw5MaVmjNz9ZkwnDeATSz9qbGz8qQm9XGDD2UGqDYi3In/TxifWPsoM2O8Xf68QEY/68q39DTXoDYo6vMUMq1TyZajSSwZx9snMB4OV+8uQZx4tDrKoGvnL2wqiHUj3QsWCinrEYruWnZWwz/MHC9orPOyrkHNfRJlQhPhClhgX4UrVwPLmXlNMngva/P0epL6j71HNjw8j5uj9fUqJpIb35M/Q1J2P0Vu3W0xlXTji58TgMc8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RG+TkWyAjgSfV57JTYBN5pfP9qi8Aer6pL70Iw1rpRc=;
 b=FLxNl4gntkYbUALm1qMFLZkQDuzm9x8AEpHHvFDu8F4xdDQT7csGgwLVECogKcF1Zay+1gG846omCt2RZm9SUBb4lQR0lMLLt8uoejDpg1t4bcWHg+laA0eregegOJCLZipIQKiJuPDXwZ28QV9OiyKO0WR826Y1PSp57DF9VO0qlVbGUtgkptcCAzBZeOQ0Ieb63Z3Rw8+cgqT+u4fA9QzNOzTYEcVtvV2fylgLSqYaIT/N21AIMrB4HicKcTDEwcRHrzMDYzXvdKcPW6il8sfzt5ktufenjzPbVZsbw5fWAoVfedHakZiQvQ7RIXxbOfxljpJ75Uvu/Gohg6kO9w==
Received: from DM5PR07CA0073.namprd07.prod.outlook.com (2603:10b6:4:ad::38) by
 CY4PR12MB1864.namprd12.prod.outlook.com (2603:10b6:903:11c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 25 May
 2021 21:18:14 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::ef) by DM5PR07CA0073.outlook.office365.com
 (2603:10b6:4:ad::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Tue, 25 May 2021 21:18:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Tue, 25 May 2021 21:18:14 +0000
Received: from [10.40.101.125] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 25 May
 2021 21:18:07 +0000
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     David Gibson <david@gibson.dropbear.id.au>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
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
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>, Neo Jia <cjia@nvidia.com>
References: <20210427171212.GD1370958@nvidia.com>
 <YIizNdbA0+LYwQbI@yekko.fritz.box> <20210428145622.GU1370958@nvidia.com>
 <YIoiJRY3FM7xH2bH@yekko> <20210503161518.GM1370958@nvidia.com>
 <YJy9o8uEZs42/qDM@yekko> <20210513135938.GG1002214@nvidia.com>
 <YKtbWo7PwIlXjFIV@yekko> <20210524233744.GT1002214@nvidia.com>
 <ce2fcf21-1803-047b-03f0-7a4108dea7af@nvidia.com>
 <20210525195257.GG1002214@nvidia.com>
X-Nvconfidentiality: public
From:   Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <6b13399d-cf03-1e71-3624-c39d4d05e958@nvidia.com>
Date:   Wed, 26 May 2021 02:48:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210525195257.GG1002214@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ef9629e-7a3c-4064-ad31-08d91fc29bb5
X-MS-TrafficTypeDiagnostic: CY4PR12MB1864:
X-Microsoft-Antispam-PRVS: <CY4PR12MB18648DA00528620B567A6840DC259@CY4PR12MB1864.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8Stdjbau3RHOHmQ3/1eiexTyTeCPe0TdRJsvBhZ7weHf365a+pPTHXFbGDggld5HhfyZqzhpDRWno4lcrcitEHN+GUNcp7CQGszUOppor1gJuM64cBcHzvkb4sCpZfx8BR2vjdMS0v7ubZ1y/Qz/XgyX2o7WcK62psALW8hX3Q2vX6jkf273tMEyTD0ELmA7mind6Bw3XHb9PzY9jLW/zZtS3W46K8X21ANv4kS0nNjeh3Ks2Q9//SsCNFcgzxFecQgsPOykQ29mFJiHfwXtjgwdUIAFfG/qEXouQyZNiQPlloBkxnrvkuDBxnhA4/WPMTEz/YT+PNS1smichO3LUVxuQ2RL6ozW0o1KS8lLayqA874ZOmrGe0/1C34D1/AXIFcuRdF08eAeNtVem/dIRSh5jkLjdcwnaU7TWoINC/aal6H1cz2YP6UuzdfJK0MXheoqGqtUrD3tIPaI7ACioHhRmBVDAWwZWAm6tm/WBq0Jpd8kMdfJ3nfpVm5fiX4FU6Cd9+bKGA8CL5ENFt/Wkx1tx2uQQETaNIeM0RYb7yuJxFawDMxkLf7xUMf/ENobaEa9IN6j8OGk69aUVm74okVZMVf3ErBrTvYdXWPpKAWaxAVlzWpVP7l+KpdsLzoXvR8su+Rb4bTYHRFpqRQz1tOAzgWRwkWgMUNhzF5CwXDpa8pV6B1qiykBsWigmCE
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(36840700001)(46966006)(6636002)(8936002)(8676002)(6862004)(2906002)(4326008)(47076005)(26005)(36756003)(107886003)(478600001)(70206006)(82310400003)(83380400001)(70586007)(356005)(186003)(6666004)(82740400003)(336012)(2616005)(86362001)(31696002)(426003)(4744005)(16526019)(54906003)(5660300002)(53546011)(7416002)(36860700001)(36906005)(316002)(31686004)(16576012)(37006003)(7636003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 21:18:14.5097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef9629e-7a3c-4064-ad31-08d91fc29bb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1864
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 5/26/2021 1:22 AM, Jason Gunthorpe wrote:
> On Wed, May 26, 2021 at 12:56:30AM +0530, Kirti Wankhede wrote:
> 
>> 2. iommu backed mdev devices for SRIOV where mdev device is created per
>> VF (mdev device == VF device) then that mdev device has same iommu
>> protection scope as VF associated to it.
> 
> This doesn't require, and certainly shouldn't create, a fake group.
> 
> Only the VF's real IOMMU group should be used to model an iommu domain
> linked to a VF. Injecting fake groups that are proxies for real groups
> only opens the possibility of security problems like David is
> concerned with.
> 

I think this security issue should be addressed by letting mdev device 
inherit its parent's iommu_group, i.e. VF's iommu_group here.

Kirti

> Max's series approaches this properly by fully linking the struct
> pci_device of the VF throughout the entire VFIO scheme, including the
> group and container, while still allowing override of various VFIO
> operations.
> 
> Jason
> 
