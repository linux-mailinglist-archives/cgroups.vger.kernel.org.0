Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C971F360A3A
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 15:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhDONME (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Apr 2021 09:12:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41543 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230202AbhDONMD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Apr 2021 09:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618492300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uJFJJborCVJEMqUuUmQ0ihhHIFtN58LgRcEx9fJY0yk=;
        b=YfdYhD1KXOQofVDi6ddoyfUiLfmOSpXtVQo48PGgsItO1LiUx5Bi46thUvFlk12UnUU5rl
        Cjjp7LYpRteqZB7Wtz1KvjifuKM/0sZQQ9SA5V1Q9mEUmsuW+csMfblwdqfiW8Fl7JO0I1
        B2Zwi1X8/2q0XKteF2uCgdI0xB/S12A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-8zek38_XN6qIhkiadECvyA-1; Thu, 15 Apr 2021 09:11:36 -0400
X-MC-Unique: 8zek38_XN6qIhkiadECvyA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 279A710054F6;
        Thu, 15 Apr 2021 13:11:33 +0000 (UTC)
Received: from [10.36.114.81] (ovpn-114-81.ams2.redhat.com [10.36.114.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0911660C22;
        Thu, 15 Apr 2021 13:11:21 +0000 (UTC)
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
To:     Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
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
References: <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <YGW27KFt9eQB9X2z@myrica>
 <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134236.GF1463678@nvidia.com>
 <BN6PR11MB4068C4DE7AF43D44DE70F4C1C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401160337.GJ1463678@nvidia.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <4bea6eb9-08ad-4b6b-1e0f-c97ece58a078@redhat.com>
Date:   Thu, 15 Apr 2021 15:11:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210401160337.GJ1463678@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

On 4/1/21 6:03 PM, Jason Gunthorpe wrote:
> On Thu, Apr 01, 2021 at 02:08:17PM +0000, Liu, Yi L wrote:
> 
>> DMA page faults are delivered to root-complex via page request message and
>> it is per-device according to PCIe spec. Page request handling flow is:
>>
>> 1) iommu driver receives a page request from device
>> 2) iommu driver parses the page request message. Get the RID,PASID, faulted
>>    page and requested permissions etc.
>> 3) iommu driver triggers fault handler registered by device driver with
>>    iommu_report_device_fault()
> 
> This seems confused.
> 
> The PASID should define how to handle the page fault, not the driver.

In my series I don't use PASID at all. I am just enabling nested stage
and the guest uses a single context. I don't allocate any user PASID at
any point.

When there is a fault at physical level (a stage 1 fault that concerns
the guest), this latter needs to be reported and injected into the
guest. The vfio pci driver registers a fault handler to the iommu layer
and in that fault handler it fills a circ bugger and triggers an eventfd
that is listened to by the VFIO-PCI QEMU device. this latter retrives
the faault from the mmapped circ buffer, it knowns which vIOMMU it is
attached to, and passes the fault to the vIOMMU.
Then the vIOMMU triggers and IRQ in the guest.

We are reusing the existing concepts from VFIO, region, IRQ to do that.

For that use case, would you also use /dev/ioasid?

Thanks

Eric
> 
> I don't remember any device specific actions in ATS, so what is the
> driver supposed to do?
> 
>> 4) device driver's fault handler signals an event FD to notify userspace to
>>    fetch the information about the page fault. If it's VM case, inject the
>>    page fault to VM and let guest to solve it.
> 
> If the PASID is set to 'report page fault to userspace' then some
> event should come out of /dev/ioasid, or be reported to a linked
> eventfd, or whatever.
> 
> If the PASID is set to 'SVM' then the fault should be passed to
> handle_mm_fault
> 
> And so on.
> 
> Userspace chooses what happens based on how they configure the PASID
> through /dev/ioasid.
> 
> Why would a device driver get involved here?
> 
>> Eric has sent below series for the page fault reporting for VM with passthru
>> device.
>> https://lore.kernel.org/kvm/20210223210625.604517-5-eric.auger@redhat.com/
> 
> It certainly should not be in vfio pci. Everything using a PASID needs
> this infrastructure, VDPA, mdev, PCI, CXL, etc.
> 
> Jason
> 

