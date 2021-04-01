Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED31A351CEB
	for <lists+cgroups@lfdr.de>; Thu,  1 Apr 2021 20:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbhDASXC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Apr 2021 14:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238607AbhDASOu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Apr 2021 14:14:50 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB89C0613B5
        for <cgroups@vger.kernel.org>; Thu,  1 Apr 2021 05:05:20 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so2713488wmd.4
        for <cgroups@vger.kernel.org>; Thu, 01 Apr 2021 05:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VYLRwOTaWYW2z/hdkbfC5Hb+/bml3aFiLVAb7iH5y5U=;
        b=T5/EZgsNWYvWOQYgR1iqHUswyZyy/ySbnJl+K6AMxf53GW61QFhYWgQJGadYeU9aLg
         bPKC1laCu3/Ih0DCjVXgv1dGJ0uZTBGRg75RCrmrdwxatAAzAR/MajoHaiA8mNXuMiKb
         W98rgPel0JxE3vIjfE5Z/0Ud5sXoegvU55MZUrDfgbWuV+ST3HE9afJFEB49yIGk4vpi
         vIZAVgzScOJBo/yxQvP/GaRKKOto4df7lSqS6tRCj2KDrmxMGLF7Bj1KPg7H5JCjGWCf
         fbWE/CS2GIv8VcBwAmcWsOhOnxQU2234Q4saAAdEl9WUBzi2deDEOuHfMUoJfCvlVreb
         fq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VYLRwOTaWYW2z/hdkbfC5Hb+/bml3aFiLVAb7iH5y5U=;
        b=e2SdoCKm0582ReZm6519+ooCUKGGEa7shUWwdZUpsYi9KR0CTciLIb7owl85L5ekj1
         leNK7oshEM9eUreiElbefeg2LwFxZXHVPYqjSxmPzO8yBeYgCdH28DNWjq+HY9jGwmN/
         Yq1a7Gw3mRNT462NE/Kp5DTia5rpuTwSKfueL7KEMgM0W1g+nIeprdRICP2sad5vTyJe
         VLdaB6nyMQIteQdw4r8TPABL3D791EMMtucunJKV706b1LtNYpT3u0Gbg++109R62a44
         ISmahoIG5Z4u05F6rz9k2arkpyz5Lnvy+xfrWfSeu3CjUh2AWIE1WjJO8az0i+rj9Ck2
         CDDQ==
X-Gm-Message-State: AOAM531EtX8NfdJvMRzbHhDIsSxKvtBkpLMe8Wbh03e57AqZyrbeFNUK
        UOc5AqGcJ8KHRPfKrJDbgQ2Qhw==
X-Google-Smtp-Source: ABdhPJy0qG57PkM01e01Hu/6+A5S1r7E+S8pF/AryMmiCAAjTaPoWTsGUnnh6jY5cr49ITAArntJUg==
X-Received: by 2002:a7b:c38d:: with SMTP id s13mr7702836wmj.44.1617278718807;
        Thu, 01 Apr 2021 05:05:18 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id o5sm9470674wrx.60.2021.04.01.05.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 05:05:18 -0700 (PDT)
Date:   Thu, 1 Apr 2021 14:05:00 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
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
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YGW27KFt9eQB9X2z@myrica>
References: <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 01, 2021 at 07:04:01AM +0000, Liu, Yi L wrote:
> > - how about AMD and ARM's vSVA support? Their PASID allocation and page
> > table
> >   happens within guest. They only need to bind the guest PASID table to
> > host.

In this case each VM has its own IOASID space, and the host IOASID
allocator doesn't participate. Plus this only makes sense when assigning a
whole VF to a guest, and VFIO is the tool for this. So I wouldn't shoehorn
those ops into /dev/ioasid, though we do need a transport for invalidate
commands.

> >   Above model seems unable to fit them. (Jean, Eric, Jacob please feel free
> >   to correct me)
> > - this per-ioasid SVA operations is not aligned with the native SVA usage
> >   model. Native SVA bind is per-device.

Bare-metal SVA doesn't need /dev/ioasid either. A program uses a device
handle to either ask whether SVA is enabled, or to enable it explicitly.
With or without /dev/ioasid, that step is required. OpenCL uses the first
method - automatically enable "fine-grain system SVM" if available, and
provide a flag to userspace.

So userspace does not need to know about PASID. It's only one method for
doing SVA (some GPUs are context-switching page tables instead).

> After reading your reply in https://lore.kernel.org/linux-iommu/20210331123801.GD1463678@nvidia.com/#t
> So you mean /dev/ioasid FD is per-VM instead of per-ioasid, so above skeleton
> doesn't suit your idea. I draft below skeleton to see if our mind is the
> same. But I still believe there is an open on how to fit ARM and AMD's
> vSVA support in this the per-ioasid SVA operation model. thoughts?
> 
> +-----------------------------+-----------------------------------------------+
> |      userspace              |               kernel space                    |
> +-----------------------------+-----------------------------------------------+
> | ioasid_fd =                 | /dev/ioasid does below:                       |
> | open("/dev/ioasid", O_RDWR);|   struct ioasid_fd_ctx {                      |
> |                             |       struct list_head ioasid_list;           |
> |                             |       ...                                     |
> |                             |   } ifd_ctx; // ifd_ctx is per ioasid_fd      |
> +-----------------------------+-----------------------------------------------+
> | ioctl(ioasid_fd,            | /dev/ioasid does below:                       |
> |       ALLOC, &ioasid);      |   struct ioasid_data {                        |
> |                             |       ioasid_t ioasid;                        |
> |                             |       struct list_head device_list;           |
> |                             |       struct list_head next;                  |
> |                             |       ...                                     |
> |                             |   } id_data; // id_data is per ioasid         |
> |                             |                                               |
> |                             |   list_add(&id_data.next,                     |
> |                             |            &ifd_ctx.ioasid_list);             |
> +-----------------------------+-----------------------------------------------+
> | ioctl(device_fd,            | VFIO does below:                              |
> |       DEVICE_ALLOW_IOASID,  | 1) get ioasid_fd, check if ioasid_fd is valid |
> |       ioasid_fd,            | 2) check if ioasid is allocated from ioasid_fd|
> |       ioasid);              | 3) register device/domain info to /dev/ioasid |
> |                             |    tracked in id_data.device_list             |
> |                             | 4) record the ioasid in VFIO's per-device     |
> |                             |    ioasid list for future security check      |
> +-----------------------------+-----------------------------------------------+
> | ioctl(ioasid_fd,            | /dev/ioasid does below:                       |
> |       BIND_PGTBL,           | 1) find ioasid's id_data                      |
> |       pgtbl_data,           | 2) loop the id_data.device_list and tell iommu|
> |       ioasid);              |    give ioasid access to the devices          |
> +-----------------------------+-----------------------------------------------+
> | ioctl(ioasid_fd,            | /dev/ioasid does below:                       |
> |       UNBIND_PGTBL,         | 1) find ioasid's id_data                      |
> |       ioasid);              | 2) loop the id_data.device_list and tell iommu|
> |                             |    clear ioasid access to the devices         |
> +-----------------------------+-----------------------------------------------+
> | ioctl(device_fd,            | VFIO does below:                              |
> |      DEVICE_DISALLOW_IOASID,| 1) check if ioasid is associated in VFIO's    |
> |       ioasid_fd,            |    device ioasid list.                        |
> |       ioasid);              | 2) unregister device/domain info from         |
> |                             |    /dev/ioasid, clear in id_data.device_list  |
> +-----------------------------+-----------------------------------------------+
> | ioctl(ioasid_fd,            | /dev/ioasid does below:                       |
> |       FREE, ioasid);        |  list_del(&id_data.next);                     |
> +-----------------------------+-----------------------------------------------+


Also wondering about:

* Querying IOMMU nesting capabilities before binding page tables (which
  page table formats are supported?). We were planning to have a VFIO cap,
  but I'm guessing we need to go back to the sysfs solution?

* Invalidation, probably an ioasid_fd ioctl?

* Page faults, page response. From and to devices, and don't necessarily
  have a PASID. But needed by vdpa as well, so that's also going through
  /dev/ioasid?

Thanks,
Jean
