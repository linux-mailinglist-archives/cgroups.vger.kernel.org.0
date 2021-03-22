Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42CC343CAB
	for <lists+cgroups@lfdr.de>; Mon, 22 Mar 2021 10:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCVJYV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Mar 2021 05:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCVJYV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Mar 2021 05:24:21 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC18C061756
        for <cgroups@vger.kernel.org>; Mon, 22 Mar 2021 02:24:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v4so15839058wrp.13
        for <cgroups@vger.kernel.org>; Mon, 22 Mar 2021 02:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VWtR8KlOcQ/dRYdCQQ3jM8KP7ad2PsBUuVXGD0LTdjA=;
        b=fRHQUYdDILcpfmFZPajioQDe1shm3v7+PmX5riSU+Vb7du56hShPmszeNHz0p/JF9y
         WTn6C5cEfg3ce/85Q7Kgah0vZQs2SFfUDSNZVFAQtr0wsI4SgRLyLibvoq7Da6+08ssd
         10TtaDTn5PcmmrJytU8mqDpFISfcb7jO/8AnkGDlwZjlCeIV7lUHeN2p8Z5W70DgtTSR
         yOICtMTkYMH0fw2uiuAreQp7KiLv2YZIglHPoO/CYtvH4r7U72jol+yJMW79TFddAWef
         53y1ZeP8GZWBt0HrJX17YbHxxhHzYno2MU+OuPWrsQ7wL8BCnLivBFxpPRGvZ7K9kz2y
         Mr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VWtR8KlOcQ/dRYdCQQ3jM8KP7ad2PsBUuVXGD0LTdjA=;
        b=LUiEb7ewiivfehHf/Ub359K8j69D1E3rebyVfwRnvkLLC5k+SFUfWq+rGuocGj2PGz
         FDmTqIkmQdJTL+fiz/7+2kG1jn8eH9OjptGubLXbYPwJbA6BrTsSAgISRGlUNhMP34SO
         Zva3bBJJEWxJHCTCABpN+2f8r5x2AnF2xZvnpt07OD/MGIVd1VUvCB3gERx5eu9xmKhh
         lwEHqEN9ozv+wDoD4iNypbCaJiso6zbkeqam0iPTwd74HflCW/uUmXNdbtl9QFVKeAA2
         qRiy83cVI0xzZKYjJEvUvwiXT2LVdG04L2keCzsF1WeRmHGUsQW/SxSzLiWQLqNQrILn
         kyEQ==
X-Gm-Message-State: AOAM531m/Fix4xk41XWIKQajlHpDY2x25FZhKzVVaKTx507JG2jdqdeR
        M4PodTYK8T2xCWNfYwZsuczsXQ==
X-Google-Smtp-Source: ABdhPJyWqQjRwjDKuYXT4l/U+wYd8vDYnHlFON2Z+w206Gu8iy4wPDPpZvHQprkb+ZsZNf5evw0SKg==
X-Received: by 2002:adf:fd91:: with SMTP id d17mr17275764wrr.0.1616405059461;
        Mon, 22 Mar 2021 02:24:19 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id g16sm20103641wrs.76.2021.03.22.02.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 02:24:18 -0700 (PDT)
Date:   Mon, 22 Mar 2021 10:24:00 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YFhiMLR35WWMW/Hu@myrica>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210318172234.3e8c34f7@jacob-builder>
 <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com>
 <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210319112221.5123b984@jacob-builder>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 19, 2021 at 11:22:21AM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> On Fri, 19 Mar 2021 10:54:32 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Fri, Mar 19, 2021 at 02:41:32PM +0100, Jean-Philippe Brucker wrote:
> > > On Fri, Mar 19, 2021 at 09:46:45AM -0300, Jason Gunthorpe wrote:  
> > > > On Fri, Mar 19, 2021 at 10:58:41AM +0100, Jean-Philippe Brucker wrote:
> > > >   
> > > > > Although there is no use for it at the moment (only two upstream
> > > > > users and it looks like amdkfd always uses current too), I quite
> > > > > like the client-server model where the privileged process does
> > > > > bind() and programs the hardware queue on behalf of the client
> > > > > process.  
> > > > 
> > > > This creates a lot complexity, how do does process A get a secure
> > > > reference to B? How does it access the memory in B to setup the HW?  
> > > 
> > > mm_access() for example, and passing addresses via IPC  
> > 
> > I'd rather the source process establish its own PASID and then pass
> > the rights to use it to some other process via FD passing than try to
> > go the other way. There are lots of security questions with something
> > like mm_access.
> > 
> 
> Thank you all for the input, it sounds like we are OK to remove mm argument
> from iommu_sva_bind_device() and iommu_sva_alloc_pasid() for now?

Fine by me. By the way the IDXD currently missues the bind API for
supervisor PASID, and the drvdata parameter isn't otherwise used. This
would be a good occasion to clean both. The new bind prototype could be:

struct iommu_sva *iommu_sva_bind_device(struct device *dev, int flags)

And a flag IOMMU_SVA_BIND_SUPERVISOR (not that I plan to implement it in
the SMMU, but I think we need to clean the current usage)

> 
> Let me try to summarize PASID allocation as below:
> 
> Interfaces	| Usage	|  Limit	| bind¹ |User visible
> --------------------------------------------------------------------
> /dev/ioasid²	| G-SVA/IOVA	|  cgroup	| No	|Yes
> --------------------------------------------------------------------
> char dev³	| SVA		|  cgroup	| Yes	|No
> --------------------------------------------------------------------
> iommu driver	| default PASID|  no		| No	|No

Is this PASID #0?

> --------------------------------------------------------------------
> kernel		| super SVA	| no		| yes   |No
> --------------------------------------------------------------------

Also wondering about device driver allocating auxiliary domains for their
private use, to do iommu_map/unmap on private PASIDs (a clean replacement
to super SVA, for example). Would that go through the same path as
/dev/ioasid and use the cgroup of current task?

Thanks,
Jean

> 
> ¹ Allocated during SVA bind
> ² PASIDs allocated via /dev/ioasid are not bound to any mm. But its
>   ownership is assigned to the process that does the allocation.
> ³ Include uacce, other private device driver char dev such as idxd
> 
> Currently, the proposed /dev/ioasid interface does not map individual PASID
> with an FD. The FD is at the ioasid_set granularity and bond to the current
> mm. We could extend the IOCTLs to cover individual PASID-FD passing case
> when use cases arise. Would this work?
> 
> Thanks,
> 
> Jacob
