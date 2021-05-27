Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68DC393567
	for <lists+cgroups@lfdr.de>; Thu, 27 May 2021 20:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbhE0S0t (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 May 2021 14:26:49 -0400
Received: from mail-dm6nam11on2060.outbound.protection.outlook.com ([40.107.223.60]:36192
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234155AbhE0S0t (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 27 May 2021 14:26:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miHLD1o/j8DAanruhuqMqHWuZR4z2W2XMPyEmqks++GOS3k3DI/YnwZ6+XpW/NFYqG81gPwbGWO3skyCMkVNw1Livbw/Id7YCt2kLnYsMT7WXPGsTeoFleYGuDrgT9h0/MjOuidRRPnjdjKpec5s7YS05ctmkNppKfpvOOw0QVQkFOjWw6oW7T7BlI7E4BlpiQbF7TjTlJPnWkm9IbMTKXpzTgG68SK+U7k4p35NR7CoZ37uxlWW7bm/znX2GUxY7UQsLKvOejnHrsvzl1aO97ReC7GWm5NHjYdY9q+O9Im5Le0z19zHH4VuDXSVvpVabKkqUrBVd5ZEIMpdHH8qTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHNJ/tHpoRmzUSCDLrlfwzUiIzLXw6x/NlDpR9tA5To=;
 b=Z4KMjoMmDlXfs3SB5lLQpCJktaiIU3nP18vvUDHuJz19x53/4Xe7vVCZLuoBGm8AnnfoYYZuB4337kqmiZjDVnde9gI5Fu9/e6IQALAyohoGkHAIPcpcj5VKABAqSukmDK+LLXXGVzh9OQimNi6m++o8fHiqyfKaqwKV+YctvA6jXyrveGDaVsQuDZtEJS7mnaxSXUIe6vKPIwvxFADvJXnOmuybeyS/q+uuT44aE77FE1mmE9k6gacB5+zvVVqwNu8GqRBQu04pVTfHLpHW8uY24dyA4bVBMGR021rF0TZpN4jZUXMkHqR4zEFNPT2BufAC1fGZNEO2/ncBSRZWuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHNJ/tHpoRmzUSCDLrlfwzUiIzLXw6x/NlDpR9tA5To=;
 b=KEsTRw5JhfE0s2RrUxdn8msH5OP6B2U0EW86gvU7ixZIdrBIUqNY+5CzeoLTvs/ccSX+/kLYfzerc2QrQilAOIH1SEuHo7VpGMVo+EPlSTlyMBiNOAAdZAG9i4eamBLT8cbaC+1SJPFztuFw2ZWq91qI3ZYhqQB1Ke4m2R9s4ySxg9bbpPtOY07QaMWtj8LBOTW5CtZNs2EaOkErwKftti1rCM1ZjXh66eLM5NJJqNLagESVVqby+TTgrUoUn0Vy3Jtg4ofBoXdlYN6RRM0IOPu3NIqf49QcYttx2QMykF4uh+OAhWbVo4LRM6JSr5+8TnWtzQ0MpSHRjX6ApjxIyQ==
Received: from BN9PR03CA0729.namprd03.prod.outlook.com (2603:10b6:408:110::14)
 by DM6PR12MB3292.namprd12.prod.outlook.com (2603:10b6:5:18c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 27 May
 2021 18:25:14 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::16) by BN9PR03CA0729.outlook.office365.com
 (2603:10b6:408:110::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Thu, 27 May 2021 18:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Thu, 27 May 2021 18:25:13 +0000
Received: from [10.40.101.125] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 18:25:04 +0000
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
To:     David Gibson <david@gibson.dropbear.id.au>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
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
References: <20210428145622.GU1370958@nvidia.com> <YIoiJRY3FM7xH2bH@yekko>
 <20210503161518.GM1370958@nvidia.com> <YJy9o8uEZs42/qDM@yekko>
 <20210513135938.GG1002214@nvidia.com> <YKtbWo7PwIlXjFIV@yekko>
 <20210524233744.GT1002214@nvidia.com>
 <ce2fcf21-1803-047b-03f0-7a4108dea7af@nvidia.com>
 <20210525195257.GG1002214@nvidia.com>
 <6b13399d-cf03-1e71-3624-c39d4d05e958@nvidia.com> <YK8nXKAJdfT5UVEu@yekko>
X-Nvconfidentiality: public
From:   Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <2476b70c-9320-a49c-efa5-fb7027e1b572@nvidia.com>
Date:   Thu, 27 May 2021 23:55:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YK8nXKAJdfT5UVEu@yekko>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99a934c6-bc0b-458f-fc6b-08d9213cc4f3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3292:
X-Microsoft-Antispam-PRVS: <DM6PR12MB329242D3F4E7D8C5D3FA38A3DC239@DM6PR12MB3292.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2qEzlDAfS7V7u9x6X0+WR6WzIvpYZcZFLSRWVXfoWyB69Z50UWXWNepeeioiOca0PYau02CSxUOu4HXVoGTWHapD5a5Y1sMYZ+X85pKuItTOLUxIdVxvwtqygpSETibEGMZPwkI4QAARKg3DIVEAzGEWriHlzeoHjkzjQ7anM/Goz6o77eJHzII6PZ1FoJTZnYX28eW20rjAdiz0wpkhYvjbyNoj4OI1jRwOnqdz8jqwOaGHP7HhQVgWKGZ0WCMDiWnOi8+NxQ5UJZUjHHRhPMtVdNXPusdjGUiirBfT23nbyfrFba5Ne9Gm204l+3NIbnNHHqFqQZ/eRv9aQLqCrSy7NAFG/QzXIvh38e4BxiZAQhrdC7+0NOYX+9OnOXTaqUBvQ6wY6oXydtUmQKKf+BSMq8h53pBN5flbE42Bl/WZjdUpYeUbO+57wvODuEg1u5TqaEO7QM9tlps/wVFC8autcz0XvfH/UTkjcRoWovWdskqwD/MEOIJvq43Sw3PaKqR9TOTrNXEz51VImJc1i3bUzyiq0myNOAsUZsO2E8UvN8SKIrnnKsEjBcRBEZjI2/kZBWhPsWZEwV7yGb/41Gl3ZZ6XsPRhORTDf3TYEsa3ekNwlS7UPAwhd9b3UM0vGO5rPwOeDVFsQVKJ/G/SSlNOUTgGVUD8nHl6Ph3KqCeIcDXWQvmnpP2xalXVChtZ
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966006)(36840700001)(107886003)(53546011)(70206006)(2616005)(70586007)(16576012)(36906005)(26005)(6666004)(356005)(31696002)(316002)(82740400003)(83380400001)(4326008)(8936002)(86362001)(54906003)(8676002)(31686004)(36860700001)(2906002)(5660300002)(478600001)(82310400003)(7636003)(7416002)(336012)(16526019)(36756003)(6916009)(47076005)(186003)(426003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 18:25:13.3845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a934c6-bc0b-458f-fc6b-08d9213cc4f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3292
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 5/27/2021 10:30 AM, David Gibson wrote:
> On Wed, May 26, 2021 at 02:48:03AM +0530, Kirti Wankhede wrote:
>>
>>
>> On 5/26/2021 1:22 AM, Jason Gunthorpe wrote:
>>> On Wed, May 26, 2021 at 12:56:30AM +0530, Kirti Wankhede wrote:
>>>
>>>> 2. iommu backed mdev devices for SRIOV where mdev device is created per
>>>> VF (mdev device == VF device) then that mdev device has same iommu
>>>> protection scope as VF associated to it.
>>>
>>> This doesn't require, and certainly shouldn't create, a fake group.
>>>
>>> Only the VF's real IOMMU group should be used to model an iommu domain
>>> linked to a VF. Injecting fake groups that are proxies for real groups
>>> only opens the possibility of security problems like David is
>>> concerned with.
>>>
>>
>> I think this security issue should be addressed by letting mdev device
>> inherit its parent's iommu_group, i.e. VF's iommu_group here.
> 
> No, that doesn't work.  AIUI part of the whole point of mdevs is to
> allow chunks of a single PCI function to be handed out to different
> places, because they're isolated from each other not by the system
> IOMMU, but by a combination of MMU hardware in the hardware (e.g. in a
> GPU card) and software in the mdev driver. 

That's correct for non-iommu backed mdev devices.

> If mdevs inherited the
> group of their parent device they wouldn't count as isolated from each
> other, which they should.
> 

For iommu backed mdev devices for SRIOV, where there can be single mdev 
device for its parent, here parent device is VF, there can't be multiple 
mdev devices associated with that VF. In this case mdev can inherit the 
group of parent device.

Kirti
