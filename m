Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F865356150
	for <lists+cgroups@lfdr.de>; Wed,  7 Apr 2021 04:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbhDGCHD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Apr 2021 22:07:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40265 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239066AbhDGCHD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Apr 2021 22:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617761214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eTZmJYI/IOE6eZrevZtsuKN2bM+b1mDhI0WPZSfz0LQ=;
        b=G3TZXjtlMrQ82v2jOE3+uJ4bYtpNVTECX0od4JC59dB8MJNy9wmOHeqZgyM6VNQpZzQN5g
        vd/A5ApgpUmc4wnoMHJfWU4afwjWOIzIDzHX474Mjo85xkk53yB32Q+teTB3UP2iq+rwrp
        cL/Tm7f3qjZ5JngN6gNFkJU1bRpCM50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-QSgasZZhPcmqG8yYOFuXrA-1; Tue, 06 Apr 2021 22:06:50 -0400
X-MC-Unique: QSgasZZhPcmqG8yYOFuXrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB315107ACCD;
        Wed,  7 Apr 2021 02:06:47 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-182.pek2.redhat.com [10.72.13.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9838910023B5;
        Wed,  7 Apr 2021 02:06:33 +0000 (UTC)
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
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
References: <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder> <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder> <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <MWHPR11MB1886CAD48AFC156BFC7C1D398C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405234230.GF7405@nvidia.com>
 <fa57bde5-472f-6e66-3521-bfac7d6e4f8d@redhat.com>
 <20210406124251.GO7405@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <acbd03f2-5c7e-d38e-92b6-cedc02429889@redhat.com>
Date:   Wed, 7 Apr 2021 10:06:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210406124251.GO7405@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


ÔÚ 2021/4/6 ÏÂÎç8:42, Jason Gunthorpe Ð´µÀ:
> On Tue, Apr 06, 2021 at 09:35:17AM +0800, Jason Wang wrote:
>
>>> VFIO and VDPA has no buisness having map/unmap interfaces once we have
>>> /dev/ioasid. That all belongs in the iosaid side.
>>>
>>> I know they have those interfaces today, but that doesn't mean we have
>>> to keep using them for PASID use cases, they should be replaced with a
>>> 'do dma from this pasid on /dev/ioasid' interface certainly not a
>>> 'here is a pasid from /dev/ioasid, go ahead and configure it youself'
>>> interface
>>   
>> So it looks like the PASID was bound to SVA in this design. I think it's not
>> necessairly the case:
> No, I wish people would stop talking about SVA.
>
> SVA and vSVA are a very special narrow configuration of a PASID. There
> are lots of other PASID configurations! That is the whole point, a
> PASID is complicated, there are many configuration scenarios, they
> need to be in one place with a very clearly defined uAPI


Right, that's my understanding as well.


>
>> 1) PASID can be implemented without SVA, in this case a map/unmap interface
>> is still required
> Any interface to manipulate a PASID should be under /dev/ioasid. We do
> not want to duplicate this into every subsystem.


Yes.


>
>> 2) For the case that hypervisor want to do some mediation in the middle for
>> a virtqueue. e.g in the case of control vq that is implemented in the
>> VF/ADI/SF itself, the hardware virtqueue needs to be controlled by Qemu,
>> Though binding qemu's page table to cvq can work but it looks like a
>> overkill, a small dedicated buffers that is mapped for this PASID seems more
>> suitalbe.
> /dev/ioasid should allow userspace to setup any PASID configuration it
> wants. There are many choices. That is the whole point, instead of
> copying&pasting all the PASID configuration option into every
> subsystem we have on place to configure it.
>
> If you want a PASID (or generic ioasid) that has the guest physical
> map, which is probably all that VDPA would ever want, then /dev/ioasid
> should be able to prepare that.
>
> If you just want to map a few buffers into a PASID then it should be
> able to do that too.
>
>> So do you mean the device should not expose the PASID confiugration API to
>> guest? I think it could happen if we assign the whole device and let guest
>> to configure it for nested VMs.
> This always needs co-operating with the vIOMMU driver. We can't have
> nested PASID use without both parts working together.
>
> The vIOMMU driver configures the PASID and assigns the mappings
> (however complicated that turns out to be)
>
> The VDPA/mdev driver authorizes the HW to use the ioasid mapping, eg
> by authorizing a queue to issue PCIe TLPs with a specific PASID.
>
> The authorization is triggered by the guest telling the vIOMMU to
> allow a vRID to talk to a PASID, which qemu would have to translate to
> telling something like the VDPA driver under the vRID that it can use
> a PASID from /dev/ioasid
>
> For security a VDPA/mdev device MUST NOT issue PASIDs that the vIOMMU
> has not authorized its vRID to use. Otherwise the security model of
> something like VFIO in the guest becomes completely broken.


Yes, that's how it should work.

Thanks


>
> Jason
>

