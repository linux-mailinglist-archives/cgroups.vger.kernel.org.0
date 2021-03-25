Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2D7348DF5
	for <lists+cgroups@lfdr.de>; Thu, 25 Mar 2021 11:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhCYK12 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Mar 2021 06:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhCYK1J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Mar 2021 06:27:09 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C6CC06175F
        for <cgroups@vger.kernel.org>; Thu, 25 Mar 2021 03:27:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y124-20020a1c32820000b029010c93864955so2774756wmy.5
        for <cgroups@vger.kernel.org>; Thu, 25 Mar 2021 03:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u9AkdAVb0gsY6G2Oei9QB4lZ6Usat1kUEujoUhrt1js=;
        b=QSAmfgEVULSIhCaPdxWKJcVrRBjVBDsS0MmFMIPOq9bRxTAPOK04UvAqkTDtsAX5zl
         R3UjLwuRfcbW9sL8Lnxv/AScRo2vVP3gxjtftPodfxo+2+YeaHgnQ3z4djluByoM0eec
         qc73JgmFYVWwwYhqPgPTmV9EyuypESanyM8URvd1xSs2qwrJSJz1FFUOod8S5BH6ox+n
         eRa4xcqneXr4ob4p7geLCd86atWQTyDU7x6Nc0CVtPADzPOiUwMFjeJ+KtMUKwhiImbi
         u1O/kLwY+2mpo4dgm4IN7Whnq6O8CmsBxKKazHidEBCbWK2UVMzSUm0wPTRy0H9KXhlJ
         j8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u9AkdAVb0gsY6G2Oei9QB4lZ6Usat1kUEujoUhrt1js=;
        b=rsjEEKhx56g+woQnvE0F5JaHuZaTSNtUyYtUK3UUKo+kWft1maR1+wRJBQExMG+x5P
         +T4c9hCjsXU2kGGuIc/eywyN1siRIu0lk200rReo53Gk1o4TA0J9HEH/PbS6P8+azyX3
         d8hsK8EDLxEA85WsnQa3ONMpZYKxCULalYEClFD5+Aigb0Qi8eFgUwKziO1UGCpbt3xW
         xPmXQjUiFBrzE+kpQ8egYGS0LuTT9w+f0vbjDQgbPt+JLkjZiz4ZXLsTyAKMJVKCwcPB
         gUYK/foWJOYEKHFSLzWFGh4+Fo3js/BWE8ppX7uo7/rRrnatedCqx4mx2u1/FKKLWz3H
         qrPg==
X-Gm-Message-State: AOAM532Z+XjDtZ6pNc8cD4YV21j5jlW0/QaK+Yk1t4L85R4Vrq0nTp8+
        EDpXGnIG3GF8ovlHP5eY7Waslg==
X-Google-Smtp-Source: ABdhPJzcCvskJZ6yQh4gQM1EDi3CeuNOCBqf1v+7r9Xt7it043Y7/pJ2ysEv0jO72DGabGGkwgvQ8Q==
X-Received: by 2002:a05:600c:4ed1:: with SMTP id g17mr7173757wmq.67.1616668026900;
        Thu, 25 Mar 2021 03:27:06 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id p18sm6532434wrs.68.2021.03.25.03.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 03:27:06 -0700 (PDT)
Date:   Thu, 25 Mar 2021 11:26:48 +0100
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
Message-ID: <YFxlaGyJkTM1m9IX@myrica>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210318172234.3e8c34f7@jacob-builder>
 <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com>
 <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <YFhiMLR35WWMW/Hu@myrica>
 <20210324100246.4e6b8aa1@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324100246.4e6b8aa1@jacob-builder>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 24, 2021 at 10:02:46AM -0700, Jacob Pan wrote:
> > And a flag IOMMU_SVA_BIND_SUPERVISOR (not that I plan to implement it in
> > the SMMU, but I think we need to clean the current usage)
> > 
> You mean move #define SVM_FLAG_SUPERVISOR_MODE out of Intel code to be a
> generic flag in iommu-sva-lib.h called IOMMU_SVA_BIND_SUPERVISOR?

Yes, though it would need to be in iommu.h since it's used by device
drivers

> > Also wondering about device driver allocating auxiliary domains for their
> > private use, to do iommu_map/unmap on private PASIDs (a clean replacement
> > to super SVA, for example). Would that go through the same path as
> > /dev/ioasid and use the cgroup of current task?
> >
> For the in-kernel private use, I don't think we should restrict based on
> cgroup, since there is no affinity to user processes. I also think the
> PASID allocation should just use kernel API instead of /dev/ioasid. Why
> would user space need to know the actual PASID # for device private domains?
> Maybe I missed your idea?

No that's my bad, I didn't get the role of /dev/ioasid. Let me give the
series a proper read.

Thanks,
Jean
