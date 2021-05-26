Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229B1391FD1
	for <lists+cgroups@lfdr.de>; Wed, 26 May 2021 20:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbhEZTAp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 May 2021 15:00:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234818AbhEZTAp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 May 2021 15:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622055553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DoYRZh+gg2Z2kIQtfA8WYSEBkw/ZAfL87pNCe/N+cRg=;
        b=f4KYIMqj7pbnnX08zgNtvF0we0zfwaYE0th69zItCL0oylq9a3WG8+VWjM1kuivCN6KBBF
        58GpQ1aficjp1PuvnFHet6uLrKzFl99zVd2LXV7VBJE6aq8JdCPn+rea7DSwxpjfcOrfJ5
        beGqOxu///hUmDiwcZu8IhpuMx4tMS8=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-Dfsqttn-OlOyH5tfNcQaRQ-1; Wed, 26 May 2021 14:59:11 -0400
X-MC-Unique: Dfsqttn-OlOyH5tfNcQaRQ-1
Received: by mail-ot1-f72.google.com with SMTP id h28-20020a056830035cb02902a5ea00385cso1196001ote.4
        for <cgroups@vger.kernel.org>; Wed, 26 May 2021 11:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DoYRZh+gg2Z2kIQtfA8WYSEBkw/ZAfL87pNCe/N+cRg=;
        b=lhtfcCECybdw1AWtcWiQk9PmoKZDPDIGO+cjQIQ8hn2NswBOuG4IblpCDZWWW4P9md
         XSC0HhvXwRJ/oT5EEwQRJaULVPwMQIosWtr3ktsk6S8HVo6X8fmi4+k3IoL08pylZvC0
         MvTZ190F6bXz6/yjuDhmZoD1dpdiz05vDRMoeAtOpVD8OBjdoJINWkcipOHqeSt7sFIR
         1mEVJA+h1Iy5HRVtIzXfJlQoyQJA4uxUtbI1A5MfJO/cnAIqvO41pQaTZQAUNvjtKMz7
         Xx/3YtqyBI0d4E9AkdB4r6BesGJIYHhQ2AMxXCwfdEcRtqJvvdDmooYWCvB5hbmkHgje
         2PzQ==
X-Gm-Message-State: AOAM531GwF7i3d9qAMjH7X+KZozCLRKR3ncwoQwBlu4vRMl3hE38I5D0
        y3HFwCCLppCmpB9a1Mso/I4rhVNFCkyke6hQ+6Hw+4NtwwqI75xqRyhe1MupyoUkdJ860yZ4HGR
        ElFPoVcWqVEawq3OEVw==
X-Received: by 2002:a9d:170e:: with SMTP id i14mr3484584ota.356.1622055551226;
        Wed, 26 May 2021 11:59:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo3tyzehBt9NJTGiTbwUqpbdhoOW/Rc6ORs95QCF1BRJHbfzK/B96RXUwLS1GYrraEl5xI2A==
X-Received: by 2002:a9d:170e:: with SMTP id i14mr3484559ota.356.1622055550969;
        Wed, 26 May 2021 11:59:10 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id w198sm10395oie.26.2021.05.26.11.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 11:59:10 -0700 (PDT)
Date:   Wed, 26 May 2021 12:59:05 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Kirti Wankhede <kwankhede@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
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
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210526125905.61e00a18.alex.williamson@redhat.com>
In-Reply-To: <6f9dad1a-4e15-1703-d6f4-1b51b7fde15a@nvidia.com>
References: <20210422233950.GD1370958@nvidia.com>
        <YIecXkaEGNgICePO@yekko.fritz.box>
        <20210427171212.GD1370958@nvidia.com>
        <YIizNdbA0+LYwQbI@yekko.fritz.box>
        <20210428145622.GU1370958@nvidia.com>
        <YIoiJRY3FM7xH2bH@yekko>
        <20210503161518.GM1370958@nvidia.com>
        <YJy9o8uEZs42/qDM@yekko>
        <20210513135938.GG1002214@nvidia.com>
        <YKtbWo7PwIlXjFIV@yekko>
        <20210524233744.GT1002214@nvidia.com>
        <ce2fcf21-1803-047b-03f0-7a4108dea7af@nvidia.com>
        <20210525165252.6959d9da.alex.williamson@redhat.com>
        <6f9dad1a-4e15-1703-d6f4-1b51b7fde15a@nvidia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 26 May 2021 23:40:02 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 5/26/2021 4:22 AM, Alex Williamson wrote:
> > On Wed, 26 May 2021 00:56:30 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> On 5/25/2021 5:07 AM, Jason Gunthorpe wrote:  
> >>> On Mon, May 24, 2021 at 05:52:58PM +1000, David Gibson wrote:
> >>>      
> >>>>>> I don't really see a semantic distinction between "always one-device
> >>>>>> groups" and "groups don't matter".  Really the only way you can afford
> >>>>>> to not care about groups is if they're singletons.  
> >>>>>
> >>>>> The kernel driver under the mdev may not be in an "always one-device"
> >>>>> group.  
> >>>>
> >>>> I don't really understand what you mean by that.  
> >>>
> >>> I mean the group of the mdev's actual DMA device may have multiple
> >>> things in it.
> >>>        
> >>>>> It is a kernel driver so the only thing we know and care about is that
> >>>>> all devices in the HW group are bound to kernel drivers.
> >>>>>
> >>>>> The vfio device that spawns from this kernel driver is really a
> >>>>> "groups don't matter" vfio device because at the IOMMU layer it should
> >>>>> be riding on the physical group of the kernel driver.  At the VFIO
> >>>>> layer we no longer care about the group abstraction because the system
> >>>>> guarentees isolation in some other way.  
> >>>>
> >>>> Uh.. I don't really know how mdevs are isolated from each other.  I
> >>>> thought it was because the physical device providing the mdevs
> >>>> effectively had an internal IOMMU (or at least DMA permissioning) to
> >>>> isolate the mdevs, even though the physical device may not be fully
> >>>> isolated.
> >>>>
> >>>> In that case the virtual mdev is effectively in a singleton group,
> >>>> which is different from the group of its parent device.  
> >>>      
> >>
> >> That's correct.
> >>  
> >>> That is one way to view it, but it means creating a whole group
> >>> infrastructure and abusing the IOMMU stack just to create this
> >>> nonsense fiction.  
> >>
> >> I really didn't get how this abuse the IOMMU stack.
> >> mdev can be used in 3 different ways:
> >> 1. non-iommu backed mdev devices where mdev vendor driver takes care to
> >> DMA map (iommu_map) and isolation is through device hardware internal
> >> MMU. Here vfio_iommu_type1 module provides a way to validate and pin
> >> pages required by mdev device for DMA mapping. Then IOMMU mapping is
> >> done by mdev vendor driver which is owner driver of physical device.
> >>
> >> 2. iommu backed mdev devices for SRIOV where mdev device is created per
> >> VF (mdev device == VF device) then that mdev device has same iommu
> >> protection scope as VF associated to it. Here mdev device is virtual
> >> device which uses features of mdev and represents underlying VF device,
> >> same as vfio-pci but with additional mdev features.  
> > 
> > What features would those be?  There are no mdev specific parts of the
> > vfio uAPI.
> > 
> > The mdev device is a virtual device, by why it it virtual in this case?
> > Aren't we effectively assigning the VF itself (mdev device == VF device)
> > with a bunch of extra support code to fill in the gaps of the VF
> > implementing the complete device model in hardware?
> > 
> > We're effectively creating this virtual device, creating a fake IOMMU
> > group, and trying to create this association of this virtual device to
> > the real VF in order to shoehorn it into the mdev model.  What do we
> > get from that model other than lifecycle management (ie. type selection)
> > and re-use of a bunch of code from the driver supporting the 1) model
> > above?
> >   
> 
> Yes, the lifecycle management which is in mdev is not in vfio-pci variant.
> 
> > This specific model seems better served by a device specific peer
> > driver to vfio-pci (ie. a "vfio-pci variant").  You effectively already
> > have the code for this driver, it's just in the format of an mdev
> > driver rather than a vfio "bus driver".  The work Jason references
> > relative to Max aims to make these kinds of drivers easier to implement
> > through re-use of vfio-pci code.
> > 
> > There are certainly other solutions we could come up with for selecting
> > a specific device type for a vfio-pci variant driver to implement other
> > than pretending this model actually belongs in mdev, right?  Thanks,
> >   
> 
> Sure and would like to see type selection mechanism to be implemented in 
> vfio-pci variant.


A driver provided sysfs attribute would obviously fill the short
term gap, long term maybe this would be standardized via netlink.  It
seems a bit analogous to setting the MAC address for a VF on an SR-IOV
NIC or VF namespace configuration for an SR-IOV NVMe device.  Thanks,

Alex

