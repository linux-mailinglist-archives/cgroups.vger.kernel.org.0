Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71742391EBB
	for <lists+cgroups@lfdr.de>; Wed, 26 May 2021 20:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhEZSLu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 May 2021 14:11:50 -0400
Received: from mail-co1nam11on2055.outbound.protection.outlook.com ([40.107.220.55]:12736
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232870AbhEZSLu (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 26 May 2021 14:11:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+d7BMRq+vUpiGL79d8JTsQBtzp8RnaZCpX0LoNPJBVohBSXbElwkQJNyA77wl+hFg08RbyfEzhSKN6vzV9Jk39QmA4Ok7bkwF5NyHvqz1zCYmdFO5aLl2KQ3OhR7ZJLjFs2ngYwT5Ar4ZlcBQ9MaEjtfKmrTmdXF3SiMs8LSp9gkRHJb3vsZ5KFwaOKiABcnC6CstWx+X7TrYDSZ/GDQk2avNxIefGicUnoQMDhkr4sdt2jQDbaNLbRNOjl/Ff5ia/Y0cIFu5reLXzUnb22DlF2PVmFDjrwoaRSDHkoT5Ql37Fv6qEOoOdbwhuvFkFLCdnUnhsG/akrFK6YElSNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0XVL//L5kNQF28/pBy3nYSAekRS7X1lV3wJ+fMoxx0=;
 b=S8rwPyIsybotdyfNUEEydE0Tq4/NSVfxTdQ/q6hEhc0qtcL9VKGhYdds0bsAKT8ZhComiFVkGBywuuoQHVPgLEVHDXjkCdBTuqqSvgbhdVbO9RwaPlx41LIXkGpPU7iCjMBzuCMBnxuqRrMVCbnuaAQL78Sg0fawmSjhWIP5FKxZ5iaSlG9c+/TmIAkcwyaZ9NN2BtJahmTbdt50cSWyXCUToApmfMrYWaSznXLiYL/2jIMaggVpltGRCO3MHUnyQOohETP1SzaP6uQzFlD2u6qQ449InpZ+LEjK025NJR47332WLY8hSS2r1V0N3MHM214GifIrJu2cTiqOqKb6Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0XVL//L5kNQF28/pBy3nYSAekRS7X1lV3wJ+fMoxx0=;
 b=XRNirzhA8xtJfqbBIvAtnrux6Cv1pxx16UQKPiE5+EYvW+Z6Ltjci1aJNx21oE4C63VyVtr9FfU1Y0Vq97694G0kb7jMim9B1Z72kGlvCVeL1fFg9pVDqQmT5yeX2sCap0YDCkwNdrKm2+c5bQthdlfLJdEmLA/gEI6recFkVBUaYLBc2MSqBHLlemgXZaqxfxC4FIQzJVkR9PInBbG4Wq+ivAGjpwMY756wOO24VQCQ+Xl2osR8zX3QHjcYX4pOaVz+Ml0o5WA0mNyAdI3hNUYfjQC96lFRqL9xbE8QAw+6+y0UuDf/uIrrnE4HSHUQusW4hkiDeFRZhrazkoJjpQ==
Received: from MWHPR14CA0019.namprd14.prod.outlook.com (2603:10b6:300:ae::29)
 by SN6PR12MB4686.namprd12.prod.outlook.com (2603:10b6:805:d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Wed, 26 May
 2021 18:10:16 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::bf) by MWHPR14CA0019.outlook.office365.com
 (2603:10b6:300:ae::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Wed, 26 May 2021 18:10:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Wed, 26 May 2021 18:10:16 +0000
Received: from [10.40.101.125] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 May
 2021 18:10:06 +0000
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Li Zefan" <lizefan@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "Wu, Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
References: <20210422233950.GD1370958@nvidia.com>
 <YIecXkaEGNgICePO@yekko.fritz.box> <20210427171212.GD1370958@nvidia.com>
 <YIizNdbA0+LYwQbI@yekko.fritz.box> <20210428145622.GU1370958@nvidia.com>
 <YIoiJRY3FM7xH2bH@yekko> <20210503161518.GM1370958@nvidia.com>
 <YJy9o8uEZs42/qDM@yekko> <20210513135938.GG1002214@nvidia.com>
 <YKtbWo7PwIlXjFIV@yekko> <20210524233744.GT1002214@nvidia.com>
 <ce2fcf21-1803-047b-03f0-7a4108dea7af@nvidia.com>
 <20210525165252.6959d9da.alex.williamson@redhat.com>
X-Nvconfidentiality: public
From:   Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <6f9dad1a-4e15-1703-d6f4-1b51b7fde15a@nvidia.com>
Date:   Wed, 26 May 2021 23:40:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210525165252.6959d9da.alex.williamson@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc3a8143-ff52-416f-e5fd-08d9207183c3
X-MS-TrafficTypeDiagnostic: SN6PR12MB4686:
X-Microsoft-Antispam-PRVS: <SN6PR12MB46867F2B4D76CC9560215E8DDC249@SN6PR12MB4686.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vD68mP7DJv5WMB48ywgGrade9l8IQ7u8KkCpQnl1h8xlODmphNsH/f3Xn0RAkj8pyN5lRKWeRM/fOARvi7JUeu+a8slrjzD0m/mkCDpMod+tkRbezLtPNw3DxkvPbManGGnibvRLvYBRD5E3d20RCby7bjDO7D0vbHce+CQj2YErUv02qLA6vlqm4RsXl7/sJPySs0FJMI50rg52ZNonH2AYp1iCkgJorGU1gbmB3rC27dxg22EFNLMRROGAOu3095eK4mTFLqI2arBpZ67UX0ogpR/R4eikfguNm4wycr3or9uq1FSSOXb8pmjyJuiT0VwDX64vdxvYoyekjwB2zXMaJ3PX3wi+v5TOg58TOW85hJHIBGfiWy4ljqQdmQ4nx7Tw5S3ZyiYRLXu1hmRPmuVxbIgVdQsjooeW/gR91gYcbaG5rMT3XBWlNXot0dlHgmz7Yz9kkPYu9MRD3kn/oTgYH8wZtm9WIiBlr0VKJsGq2n787Zv31WUImneaw7Llphn70QOcH33z4Wko1n5aEiKp4uhuZfUAaPtyT1ItVfKSV3nton07yl4wXxesY4gfWphRNN71Q1P/ceNpkeOtFA4Ck7avJkxOR/vd/2pngoBHumrAEiOQ+7Z0dSnvM6MKMTOHEAjCSVlFDGLhNyGBROs4uuUVrE0tMrCRCM/QAWG7LwjGmdidI2JbkaapQi3A
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(36840700001)(46966006)(2616005)(356005)(186003)(83380400001)(70206006)(70586007)(82740400003)(478600001)(5660300002)(36756003)(36906005)(7416002)(4326008)(6916009)(16526019)(26005)(2906002)(336012)(82310400003)(8676002)(31696002)(54906003)(426003)(6666004)(7636003)(31686004)(16576012)(8936002)(316002)(86362001)(47076005)(36860700001)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 18:10:16.2813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3a8143-ff52-416f-e5fd-08d9207183c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4686
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 5/26/2021 4:22 AM, Alex Williamson wrote:
> On Wed, 26 May 2021 00:56:30 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> On 5/25/2021 5:07 AM, Jason Gunthorpe wrote:
>>> On Mon, May 24, 2021 at 05:52:58PM +1000, David Gibson wrote:
>>>    
>>>>>> I don't really see a semantic distinction between "always one-device
>>>>>> groups" and "groups don't matter".  Really the only way you can afford
>>>>>> to not care about groups is if they're singletons.
>>>>>
>>>>> The kernel driver under the mdev may not be in an "always one-device"
>>>>> group.
>>>>
>>>> I don't really understand what you mean by that.
>>>
>>> I mean the group of the mdev's actual DMA device may have multiple
>>> things in it.
>>>      
>>>>> It is a kernel driver so the only thing we know and care about is that
>>>>> all devices in the HW group are bound to kernel drivers.
>>>>>
>>>>> The vfio device that spawns from this kernel driver is really a
>>>>> "groups don't matter" vfio device because at the IOMMU layer it should
>>>>> be riding on the physical group of the kernel driver.  At the VFIO
>>>>> layer we no longer care about the group abstraction because the system
>>>>> guarentees isolation in some other way.
>>>>
>>>> Uh.. I don't really know how mdevs are isolated from each other.  I
>>>> thought it was because the physical device providing the mdevs
>>>> effectively had an internal IOMMU (or at least DMA permissioning) to
>>>> isolate the mdevs, even though the physical device may not be fully
>>>> isolated.
>>>>
>>>> In that case the virtual mdev is effectively in a singleton group,
>>>> which is different from the group of its parent device.
>>>    
>>
>> That's correct.
>>
>>> That is one way to view it, but it means creating a whole group
>>> infrastructure and abusing the IOMMU stack just to create this
>>> nonsense fiction.
>>
>> I really didn't get how this abuse the IOMMU stack.
>> mdev can be used in 3 different ways:
>> 1. non-iommu backed mdev devices where mdev vendor driver takes care to
>> DMA map (iommu_map) and isolation is through device hardware internal
>> MMU. Here vfio_iommu_type1 module provides a way to validate and pin
>> pages required by mdev device for DMA mapping. Then IOMMU mapping is
>> done by mdev vendor driver which is owner driver of physical device.
>>
>> 2. iommu backed mdev devices for SRIOV where mdev device is created per
>> VF (mdev device == VF device) then that mdev device has same iommu
>> protection scope as VF associated to it. Here mdev device is virtual
>> device which uses features of mdev and represents underlying VF device,
>> same as vfio-pci but with additional mdev features.
> 
> What features would those be?  There are no mdev specific parts of the
> vfio uAPI.
> 
> The mdev device is a virtual device, by why it it virtual in this case?
> Aren't we effectively assigning the VF itself (mdev device == VF device)
> with a bunch of extra support code to fill in the gaps of the VF
> implementing the complete device model in hardware?
> 
> We're effectively creating this virtual device, creating a fake IOMMU
> group, and trying to create this association of this virtual device to
> the real VF in order to shoehorn it into the mdev model.  What do we
> get from that model other than lifecycle management (ie. type selection)
> and re-use of a bunch of code from the driver supporting the 1) model
> above?
> 

Yes, the lifecycle management which is in mdev is not in vfio-pci variant.

> This specific model seems better served by a device specific peer
> driver to vfio-pci (ie. a "vfio-pci variant").  You effectively already
> have the code for this driver, it's just in the format of an mdev
> driver rather than a vfio "bus driver".  The work Jason references
> relative to Max aims to make these kinds of drivers easier to implement
> through re-use of vfio-pci code.
> 
> There are certainly other solutions we could come up with for selecting
> a specific device type for a vfio-pci variant driver to implement other
> than pretending this model actually belongs in mdev, right?  Thanks,
> 

Sure and would like to see type selection mechanism to be implemented in 
vfio-pci variant.

Thanks,
Kirti

