Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36438341E95
	for <lists+cgroups@lfdr.de>; Fri, 19 Mar 2021 14:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhCSNmB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Mar 2021 09:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhCSNmA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Mar 2021 09:42:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37BDC06174A
        for <cgroups@vger.kernel.org>; Fri, 19 Mar 2021 06:41:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k8so9156098wrc.3
        for <cgroups@vger.kernel.org>; Fri, 19 Mar 2021 06:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DAYPn6BONqpHEbUgtaq686MIszfpE7Ws+kMTTaVpKdw=;
        b=IOd4Cob2v4qwcVrJJUnC6ZJVxIF2WBZVUhabq0Mv+BS0jxbHyUnYBlGulXszdU4mh5
         JXzpsK3jKuoU/S5b9nKYFRf5F0sT8Ih0u+BBZ97AbRXwrnLfybJJGTeRgA19XHDBH/6A
         EIDPKhijEx951g3qBOvaySlcB+XCF59BiLWj7FAAa+dfvbhhKPrkAChUBce435eNngqn
         R+HJqOzXYp0v+9UH9mxi/ExOXRx5qD4c7l8r5Po2L8As98VwmoUM9fKmxEPZfPe/fd7Q
         UbCXx9Q/ZuSWaZ1C6p/tiwNnPCGMuVJaU5azJ48KpQKEX3nEV8O7VaIWzhCFinZ0/Xoq
         OHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DAYPn6BONqpHEbUgtaq686MIszfpE7Ws+kMTTaVpKdw=;
        b=A+bmtj5xCVeGnKbWPt7Ln8Dj8Sp0wp9wrgEWBni6u3gVL27q6I9fSbnWYLf5z5d9ZG
         JOL5MUsHFcJo7OV71wFDL8RjdIWphI7fwVN9cTL824h3T9ey4xfr85wwNlg+5yQx6w3P
         Kl4tpBlSQuLF8we4SUTqolN8PD01AW4GkOfSig+O/XlW3u1fiw3ojOr3FkA83W4bw3e9
         Drc6cO+K5Gzo9TFhbwAw877KUe4vgc3mB1G3q00GWIehDIDnMLzaAmy77CucYagRqTBi
         9F2KShbK2iRlfIWqk8i0CnMWEVmi+f3MwkfU41RV15vMnSF3cRb1TTL++yolt60EW+k1
         2mbw==
X-Gm-Message-State: AOAM5336oPtCar163nf2Kb0KIiyd4zH9Jr/o+TejQ2EafssDRSb80bQF
        4pWuvbbKEg0H0yJrGlwissIePAhLTQjQHw==
X-Google-Smtp-Source: ABdhPJyQGtsZyiZINsYu1PPARQsbLsQTm4cSQr/DP78vQm+uFeco8MqdIu7fVUjhkFhpApMilBcfpQ==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr4678213wrn.174.1616161310724;
        Fri, 19 Mar 2021 06:41:50 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id l21sm6625021wmg.41.2021.03.19.06.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 06:41:50 -0700 (PDT)
Date:   Fri, 19 Mar 2021 14:41:32 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
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
Message-ID: <YFSqDNJ5yagk4eO+@myrica>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210318172234.3e8c34f7@jacob-builder>
 <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319124645.GP2356281@nvidia.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 19, 2021 at 09:46:45AM -0300, Jason Gunthorpe wrote:
> On Fri, Mar 19, 2021 at 10:58:41AM +0100, Jean-Philippe Brucker wrote:
> 
> > Although there is no use for it at the moment (only two upstream users and
> > it looks like amdkfd always uses current too), I quite like the
> > client-server model where the privileged process does bind() and programs
> > the hardware queue on behalf of the client process.
> 
> This creates a lot complexity, how do does process A get a secure
> reference to B? How does it access the memory in B to setup the HW?

mm_access() for example, and passing addresses via IPC

> Why do we need separation anyhow? SVM devices are supposed to be
> secure or they shouldn't do SVM.

Right

Thanks,
Jean
