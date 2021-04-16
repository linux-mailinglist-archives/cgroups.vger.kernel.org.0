Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15CB362125
	for <lists+cgroups@lfdr.de>; Fri, 16 Apr 2021 15:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhDPNix (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Apr 2021 09:38:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45755 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244083AbhDPNiu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Apr 2021 09:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618580305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ORKl8cG3pXQFZT6dMTWhjbu3j7T6kEqKkWZLykCofkk=;
        b=jOKyVHfYnzyH0SBAiOMIXt+uuFwBDeuRDnRItNJBmv3CW+5i6G2guHfDrtGaEUR1HD0RWd
        HBFiv7cvsrWugjZjLI9z3EIDri5l0/hEvyfRTFTkNv7SBR1GJmPz0RZ7zxyuYmrpW64+qm
        XCIICJo5hSGzZIix/65xzL9yy/icIFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-rdYtHHQlPP-nLVltZYYZvA-1; Fri, 16 Apr 2021 09:38:21 -0400
X-MC-Unique: rdYtHHQlPP-nLVltZYYZvA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FFCA107ACCA;
        Fri, 16 Apr 2021 13:38:18 +0000 (UTC)
Received: from [10.36.113.21] (ovpn-113-21.ams2.redhat.com [10.36.113.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3276A19D9F;
        Fri, 16 Apr 2021 13:38:04 +0000 (UTC)
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
To:     Jason Gunthorpe <jgg@nvidia.com>
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
References: <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <YGW27KFt9eQB9X2z@myrica>
 <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134236.GF1463678@nvidia.com>
 <BN6PR11MB4068C4DE7AF43D44DE70F4C1C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401160337.GJ1463678@nvidia.com>
 <4bea6eb9-08ad-4b6b-1e0f-c97ece58a078@redhat.com>
 <20210415230732.GG1370958@nvidia.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <b1492fd3-8ce2-1632-3b14-73d8d4356fd7@redhat.com>
Date:   Fri, 16 Apr 2021 15:38:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210415230732.GG1370958@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

On 4/16/21 1:07 AM, Jason Gunthorpe wrote:
> On Thu, Apr 15, 2021 at 03:11:19PM +0200, Auger Eric wrote:
>> Hi Jason,
>>
>> On 4/1/21 6:03 PM, Jason Gunthorpe wrote:
>>> On Thu, Apr 01, 2021 at 02:08:17PM +0000, Liu, Yi L wrote:
>>>
>>>> DMA page faults are delivered to root-complex via page request message and
>>>> it is per-device according to PCIe spec. Page request handling flow is:
>>>>
>>>> 1) iommu driver receives a page request from device
>>>> 2) iommu driver parses the page request message. Get the RID,PASID, faulted
>>>>    page and requested permissions etc.
>>>> 3) iommu driver triggers fault handler registered by device driver with
>>>>    iommu_report_device_fault()
>>>
>>> This seems confused.
>>>
>>> The PASID should define how to handle the page fault, not the driver.
>>
>> In my series I don't use PASID at all. I am just enabling nested stage
>> and the guest uses a single context. I don't allocate any user PASID at
>> any point.
>>
>> When there is a fault at physical level (a stage 1 fault that concerns
>> the guest), this latter needs to be reported and injected into the
>> guest. The vfio pci driver registers a fault handler to the iommu layer
>> and in that fault handler it fills a circ bugger and triggers an eventfd
>> that is listened to by the VFIO-PCI QEMU device. this latter retrives
>> the faault from the mmapped circ buffer, it knowns which vIOMMU it is
>> attached to, and passes the fault to the vIOMMU.
>> Then the vIOMMU triggers and IRQ in the guest.
>>
>> We are reusing the existing concepts from VFIO, region, IRQ to do that.
>>
>> For that use case, would you also use /dev/ioasid?
> 
> /dev/ioasid could do all the things you described vfio-pci as doing,
> it can even do them the same way you just described.
> 
> Stated another way, do you plan to duplicate all of this code someday
> for vfio-cxl? What about for vfio-platform? ARM SMMU can be hooked to
> platform devices, right?
vfio regions and IRQ related APIs are common user interfaces exposed by
all vfio drivers, including platform. Then the actual circular buffer
implementation details can be put in a common lib.

as for the thin vfio iommu wrappers, the ones you don't like, they are
implemented in type1 code.

Maybe the need for /dev/ioasid is more crying for PASID management but
for the nested use case, that's not obvious to me and in your different
replies, it was not crystal clear where the use case belongs to.

The redesign requirement came pretty late in the development process.
The iommu user API is upstream for a while, the VFIO interfaces have
been submitted a long time ago and under review for a bunch of time.
Redesigning everything with a different API, undefined at this point, is
a major setback for our work and will have a large impact on the
introduction of features companies are looking forward, hence our
frustration.

Thanks

Eric


> 
> I feel what you guys are struggling with is some choice in the iommu
> kernel APIs that cause the events to be delivered to the pci_device
> owner, not the PASID owner.
> 
> That feels solvable.
> 
> Jason
> 

