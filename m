Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60937354A1B
	for <lists+cgroups@lfdr.de>; Tue,  6 Apr 2021 03:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242044AbhDFBfq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Apr 2021 21:35:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51553 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242030AbhDFBfp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Apr 2021 21:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617672938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kwZ8XyyzRZCBrGqzegCVhhjQ1Q2Ym617/sTrzH4w1XI=;
        b=byXv0wBgeKoPa1BWCNAXfxIERfEsfOqyFT0OZWsTnTkg3yTkyL8yWoOWO92DkZ46G4HAko
        vnFoH9bAJgA2C1QzdBMN3M4Bb11GhJ4Qt1jm/C5hKUWmjYN8jwIjTNJu6B9FkyUDb9ucRX
        s7pJJJkp1ODQ5MgnJ66A7hiLKJoEOng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-M4zcdcyUNc24sYSeXmRvfQ-1; Mon, 05 Apr 2021 21:35:34 -0400
X-MC-Unique: M4zcdcyUNc24sYSeXmRvfQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D2DB81744F;
        Tue,  6 Apr 2021 01:35:32 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-96.pek2.redhat.com [10.72.13.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35FB519C78;
        Tue,  6 Apr 2021 01:35:18 +0000 (UTC)
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
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
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
References: <20210319124645.GP2356281@nvidia.com> <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com> <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com> <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <MWHPR11MB1886CAD48AFC156BFC7C1D398C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405234230.GF7405@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <fa57bde5-472f-6e66-3521-bfac7d6e4f8d@redhat.com>
Date:   Tue, 6 Apr 2021 09:35:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210405234230.GF7405@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


ÔÚ 2021/4/6 ÉÏÎç7:42, Jason Gunthorpe Ð´µÀ:
> On Fri, Apr 02, 2021 at 08:22:28AM +0000, Tian, Kevin wrote:
>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>> Sent: Tuesday, March 30, 2021 9:29 PM
>>>
>>>> First, userspace may use ioasid in a non-SVA scenario where ioasid is
>>>> bound to specific security context (e.g. a control vq in vDPA) instead of
>>>> tying to mm. In this case there is no pgtable binding initiated from user
>>>> space. Instead, ioasid is allocated from /dev/ioasid and then programmed
>>>> to the intended security context through specific passthrough framework
>>>> which manages that context.
>>> This sounds like the exact opposite of what I'd like to see.
>>>
>>> I do not want to see every subsystem gaining APIs to program a
>>> PASID. All of that should be consolidated in *one place*.
>>>
>>> I do not want to see VDPA and VFIO have two nearly identical sets of
>>> APIs to control the PASID.
>>>
>>> Drivers consuming a PASID, like VDPA, should consume the PASID and do
>>> nothing more than authorize the HW to use it.
>>>
>>> quemu should have general code under the viommu driver that drives
>>> /dev/ioasid to create PASID's and manage the IO mapping according to
>>> the guest's needs.
>>>
>>> Drivers like VDPA and VFIO should simply accept that PASID and
>>> configure/authorize their HW to do DMA's with its tag.
>>>
>> I agree with you on consolidating things in one place (especially for the
>> general SVA support). But here I was referring to an usage without
>> pgtable binding (Possibly Jason. W can say more here), where the
>> userspace just wants to allocate PASIDs, program/accept PASIDs to
>> various workqueues (device specific), and then use MAP/UNMAP
>> interface to manage address spaces associated with each PASID.
>> I just wanted to point out that the latter two steps are through
>> VFIO/VDPA specific interfaces.
> No, don't do that.
>
> VFIO and VDPA has no buisness having map/unmap interfaces once we have
> /dev/ioasid. That all belongs in the iosaid side.
>
> I know they have those interfaces today, but that doesn't mean we have
> to keep using them for PASID use cases, they should be replaced with a
> 'do dma from this pasid on /dev/ioasid' interface certainly not a
> 'here is a pasid from /dev/ioasid, go ahead and configure it youself'
> interface


So it looks like the PASID was bound to SVA in this design. I think it's 
not necessairly the case:

1) PASID can be implemented without SVA, in this case a map/unmap 
interface is still required
2) For the case that hypervisor want to do some mediation in the middle 
for a virtqueue. e.g in the case of control vq that is implemented in 
the VF/ADI/SF itself, the hardware virtqueue needs to be controlled by 
Qemu, Though binding qemu's page table to cvq can work but it looks like 
a overkill, a small dedicated buffers that is mapped for this PASID 
seems more suitalbe.


>
> This is because PASID is *complicated* in the general case! For
> instance all the two level stuff you are talking about must not leak
> into every user!
>
> Jason


So do you mean the device should not expose the PASID confiugration API 
to guest? I think it could happen if we assign the whole device and let 
guest to configure it for nested VMs.

Thanks


>

