Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069C839099D
	for <lists+cgroups@lfdr.de>; Tue, 25 May 2021 21:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhEYT2N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 May 2021 15:28:13 -0400
Received: from mail-bn7nam10on2071.outbound.protection.outlook.com ([40.107.92.71]:30944
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232448AbhEYT2N (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 25 May 2021 15:28:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLj6k6o3/0j9rPhSCoG5hsDLD79axjoJ3shlYgI9H7mEHggFhO6UJhKoc2qbKLEMMs5eo5dIvwrfwFEXjlR0d7LsGW/X1/1XrkitvaovzdSbmjvDXdYYuaAEeOgLnrDpu9fXusugKPLIVws2doHy1PRL+Q5Qk8GGtnLz1k/I/7xeMNlT+1v27tCKjtkxsu+W7TTQygpClBPmEkvQO2X1nDB0PUsRkGPZ/Y37m84lN4YlqJA4JfsVHC56VUrThlJVx4WX5KQqoHnv0SwF/HCOUulTWkE8mWkYSJtnpLwZiDtaIQAGcX6cfLYtWm1/Z6RpWhME7Tps5Y8nezc2xDWQjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ2rh5R80Fu86zeJeWHYHobMTDww4dFTkVxhue1JBiA=;
 b=BQaq4QN1Z5PNU2GlSzcN9xB6QN0xHu33dAr67LALDxG2yb5jpQJF71Tzox4HtYeupLLvmZkhayR6GcmA7I/+rd4N8PoGes37DhJgHkFUVAmAJbGcc+H3RJ2mByOXXbFlNWuyadcvlWm4olnp7mjktmJF/5MjJDzTSsuhY9Z+yZ/sGr443j3nQQQN1YWD/zjDFmIby9VvmlTzGtI3ySUNnoQcKAyMQwFQV3NrSOezvjW6n7rL68L8M3E3zbA2DA/xK0iNSGFUoOxduvughuD4Ei1/Tnr9H6aSbglBEciJbLvlXTK/rgDWushS+pX1Q+kQ7bc69dbh0Ssq5xf37/gi4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ2rh5R80Fu86zeJeWHYHobMTDww4dFTkVxhue1JBiA=;
 b=ZB3aRVBFgL8Sx3UaZrotBW7y3o8YtuAcS4TiVrsvMriFhqb/+dQHkQGnrCw8KIKIeEv3oPCM2rGxadSsGMtSUo32jU7CxysDG9Q//elNyakiTXr//NKGrmp8jJjzlqHAuL8saX4+6eWxHdjHz4bXadZmiKVuluK5HX+3UMHLlbE8toAZ4an9P6IENODkvfxm73KmrScV07GTMnNFpHRN0t+mWqD9aAhoAJdSaOMGNtQSkPJCr0pMUiokGNcVQyon5SuZpdeJ/b+XNd8I0y/wLGLxPSgm55N4UfrWsWTN05QqxqVxkMoNakL2Vp6zPEgVFoSjuyUvmVD4NEFPYMM0ig==
Received: from DM6PR14CA0061.namprd14.prod.outlook.com (2603:10b6:5:18f::38)
 by BN6PR1201MB2465.namprd12.prod.outlook.com (2603:10b6:404:a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 19:26:41 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::86) by DM6PR14CA0061.outlook.office365.com
 (2603:10b6:5:18f::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 25 May 2021 19:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Tue, 25 May 2021 19:26:40 +0000
Received: from [10.40.101.125] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 25 May
 2021 19:26:34 +0000
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
To:     Jason Gunthorpe <jgg@nvidia.com>,
        David Gibson <david@gibson.dropbear.id.au>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Auger Eric <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20210422233950.GD1370958@nvidia.com>
 <YIecXkaEGNgICePO@yekko.fritz.box> <20210427171212.GD1370958@nvidia.com>
 <YIizNdbA0+LYwQbI@yekko.fritz.box> <20210428145622.GU1370958@nvidia.com>
 <YIoiJRY3FM7xH2bH@yekko> <20210503161518.GM1370958@nvidia.com>
 <YJy9o8uEZs42/qDM@yekko> <20210513135938.GG1002214@nvidia.com>
 <YKtbWo7PwIlXjFIV@yekko> <20210524233744.GT1002214@nvidia.com>
X-Nvconfidentiality: public
From:   Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <ce2fcf21-1803-047b-03f0-7a4108dea7af@nvidia.com>
Date:   Wed, 26 May 2021 00:56:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210524233744.GT1002214@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3d7ba62-4f3c-4fdb-932c-08d91fb305fd
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2465:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2465C2E4CF54452554A59796DC259@BN6PR1201MB2465.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wF37nI3K4zKtT5iWpzHYXlTCojcL2tfABxlG+dHtsfmgS7n/UPWXm09KIQ8t373K3ZRJI5c8AveG9r8ICPh+vxiNrOT9sIX6v+wOG/sM22jfSSjcs6DHZAroaBQB7uFqUVv+KLjCvuwkHrZ8KhKa6UOMrCf6/cXgjNcKZf9xjQC3bldyM5lEoI+BzfSZKZcWp3yfT13Bs7ZyWtcp6vTkq8xsiuqaHLK7zwgvDrHeYE8N/wV1TLoWospaG6wv3W5hQg3S3rRT3kXKh6HUPL7bWHUFPse149i0AQy0T8Sb2Uib/Ixc1OtfPfxi1d77FQA0bPEkjm9mpFpv6cGiqB0iwoaFGOe0ALcfMaR9SDIYARtNvpTX0E2H/8ZmLN0tUzq7ttF/4DzAfY0N3gd3OwSDJWHX5jkb4thsQ8IfMrhumaHhCaf/5KdaJ0+GrLOrn3HQvaYmR18oCTUlDstPUfskkA3X53MRpBZm6p2JZTEXSwb5+1PDYS8cOtFtofAXrW557962oOqLpxJGLqFAmazfbtJ1hAeClHF38Ou+1YeT9ykT9fAxyP0O0Qrw78Sq7P1K5aLESe97iW7B5qvaPjqbKiSeME3beGwLd772hvRJKkSgfvD6jzAh1h4v/jdO67Yq6DgnPwp0LC3Adk52g1Otjz8js0JJxjMcSJv8D4xKD1fSMAIzI2jIIrHTHtTwJh6q
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(36840700001)(46966006)(70206006)(8936002)(36756003)(4326008)(70586007)(47076005)(7416002)(82310400003)(82740400003)(26005)(2906002)(356005)(16526019)(426003)(8676002)(2616005)(36860700001)(53546011)(7636003)(478600001)(31696002)(86362001)(31686004)(110136005)(83380400001)(316002)(6666004)(16576012)(54906003)(5660300002)(336012)(186003)(36906005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 19:26:40.8667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d7ba62-4f3c-4fdb-932c-08d91fb305fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2465
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 5/25/2021 5:07 AM, Jason Gunthorpe wrote:
> On Mon, May 24, 2021 at 05:52:58PM +1000, David Gibson wrote:
> 
>>>> I don't really see a semantic distinction between "always one-device
>>>> groups" and "groups don't matter".  Really the only way you can afford
>>>> to not care about groups is if they're singletons.
>>>
>>> The kernel driver under the mdev may not be in an "always one-device"
>>> group.
>>
>> I don't really understand what you mean by that.
> 
> I mean the group of the mdev's actual DMA device may have multiple
> things in it.
>   
>>> It is a kernel driver so the only thing we know and care about is that
>>> all devices in the HW group are bound to kernel drivers.
>>>
>>> The vfio device that spawns from this kernel driver is really a
>>> "groups don't matter" vfio device because at the IOMMU layer it should
>>> be riding on the physical group of the kernel driver.  At the VFIO
>>> layer we no longer care about the group abstraction because the system
>>> guarentees isolation in some other way.
>>
>> Uh.. I don't really know how mdevs are isolated from each other.  I
>> thought it was because the physical device providing the mdevs
>> effectively had an internal IOMMU (or at least DMA permissioning) to
>> isolate the mdevs, even though the physical device may not be fully
>> isolated.
>>
>> In that case the virtual mdev is effectively in a singleton group,
>> which is different from the group of its parent device.
> 

That's correct.

> That is one way to view it, but it means creating a whole group
> infrastructure and abusing the IOMMU stack just to create this
> nonsense fiction.

I really didn't get how this abuse the IOMMU stack.
mdev can be used in 3 different ways:
1. non-iommu backed mdev devices where mdev vendor driver takes care to
DMA map (iommu_map) and isolation is through device hardware internal
MMU. Here vfio_iommu_type1 module provides a way to validate and pin
pages required by mdev device for DMA mapping. Then IOMMU mapping is
done by mdev vendor driver which is owner driver of physical device.

2. iommu backed mdev devices for SRIOV where mdev device is created per
VF (mdev device == VF device) then that mdev device has same iommu
protection scope as VF associated to it. Here mdev device is virtual
device which uses features of mdev and represents underlying VF device,
same as vfio-pci but with additional mdev features.

3. iommu backed mdev devices for PASID with aux feature. I would not
comment on this, there has been a long discussion on this.

I don't think this is abusing IOMMU stack, atleast for 1 and 2 above.

Thanks,
Kirti


> We also abuse the VFIO container stuff to hackily
> create several different types pf IOMMU uAPIs for the mdev - all of
> which are unrelated to drivers/iommu.
> 
> Basically, there is no drivers/iommu thing involved, thus is no really
> iommu group, for mdev it is all a big hacky lie.
> 
>> If the physical device had a bug which meant the mdevs *weren't*
>> properly isolated from each other, then those mdevs would share a
>> group, and you *would* care about it.  Depending on how the isolation
>> failed the mdevs might or might not also share a group with the parent
>> physical device.
> 
> That isn't a real scenario.. mdevs that can't be isolated just
> wouldn't be useful to exist
> 
>>> This is today's model, yes. When you run dpdk on a multi-group device
>>> vfio already ensures that all the device groups remained parked and
>>> inaccessible.
>>
>> I'm not really following what you're saying there.
>>
>> If you have a multi-device group, and dpdk is using one device in it,
>> VFIO *does not* (and cannot) ensure that other devices in the group
>> are parked and inaccessible.
> 
> I mean in the sense that no other user space can open those devices
> and no kernel driver can later be attached to them.
> 
>> It ensures that they're parked at the moment the group moves from
>> kernel to userspace ownership, but it can't prevent dpdk from
>> accessing and unparking those devices via peer to peer DMA.
> 
> Right, and adding all this group stuff did nothing to alert the poor
> admin that is running DPDK to this risk.
> 
>>> If the administator configures the system with different security
>>> labels for different VFIO devices then yes removing groups makes this
>>> more tricky as all devices in the group should have the same label.
>>
>> That seems a bigger problem than "more tricky".  How would you propose
>> addressing this with your device-first model?
> 
> You put the same security labels you'd put on the group to the devices
> that consitute the group. It is only more tricky in the sense that the
> script that would have to do this will need to do more than ID the
> group to label but also ID the device members of the group and label
> their char nodes.
> 
> Jason
> 
