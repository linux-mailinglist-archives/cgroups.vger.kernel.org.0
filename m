Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF107341909
	for <lists+cgroups@lfdr.de>; Fri, 19 Mar 2021 10:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCSJ7W (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Mar 2021 05:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhCSJ7C (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Mar 2021 05:59:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C473C06174A
        for <cgroups@vger.kernel.org>; Fri, 19 Mar 2021 02:59:01 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id g25so5156896wmh.0
        for <cgroups@vger.kernel.org>; Fri, 19 Mar 2021 02:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+ew0oK+98acMtQgKLGerzyoNXnWF03GfXmL2rWxicfk=;
        b=UdvS3qSDTfqH6Y/9ofxlqvCMdGhYTHBMlEKvkuSNFIAbXj3Iw7mjRPnscCsrtOHM5G
         MlOFed3B9j8sNv6cKE1CjkDG7IVfJZaejlQLQHjinhmn4md6lO9XFnLYwz+70nP+jRDQ
         Z5fs4LXC67m6l5OhlLif7iHkDnjNtHEEH8Un5AjM4d/DNim7CCkfGj9IPPbiGnACMtVL
         9Zuh84uDGYWvyZbcQ+M9KjO0nCzsdA+CCKhBixRmtofebvqO9UQMbXS2Ktix/fxZ3r4N
         ktpSWYrVOqT0PqvQqWuidhdHYwmu0PFpnGYb/SHBosxdSqn1KgYSTXs5RpmVr3XP5Hqg
         ixMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ew0oK+98acMtQgKLGerzyoNXnWF03GfXmL2rWxicfk=;
        b=Qdj9lRz2Y+XUHTrYpKihZDaqB+APdXG6ddgXWbMC6qQYBWAFFDe3J+BHd2LqfcWWLc
         CyqGs75GOuFkfgsYmpcBqZ6eAcs/hdMx3bG/4gladH03Vde9QHHDDaJBxCfGn/53EflB
         C+RB32nKcWyH1eD2LuGxifaMhWqU57emdEBg6NJcWkz6gZCpAtQriOawDSBMcD+5RHAQ
         4ulzj01PaUt+H18as67tavJHbYMkTdaGGkcHDXfCX6gjbYPUQKX2JN6Jha50yXQDOAko
         YjzVrAp2f3zxFhNf3nUuE51hF0QvQaUtHQYXnaOLsFxQducee309rjGLAqxeb8s5PVBv
         jkhA==
X-Gm-Message-State: AOAM533+41rQ81H8YneBMBgFUn/OVGFe03DbZibwUaybmUC1QBR2LwUy
        YE47XXCD9hbU1OVV9FQ/87OqeQ==
X-Google-Smtp-Source: ABdhPJywMEYo3x8bbMPypYbibw8Xew0V2G0kK4FRG8qDJBcGfhyk0lGzYJpIvJj3vaFynvVmrw/7UQ==
X-Received: by 2002:a7b:c087:: with SMTP id r7mr2960647wmh.110.1616147940350;
        Fri, 19 Mar 2021 02:59:00 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id k4sm9039154wrd.9.2021.03.19.02.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 02:58:59 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:58:41 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YFR10eeDVf5ZHV5l@myrica>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210318172234.3e8c34f7@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318172234.3e8c34f7@jacob-builder>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jacob,

On Thu, Mar 18, 2021 at 05:22:34PM -0700, Jacob Pan wrote:
> Hi Jean,
> 
> Slightly off the title. As we are moving to use cgroup to limit PASID
> allocations, it would be much simpler if we enforce on the current task.

Yes I think we should do that. Is there a problem with charging the
process that does the PASID allocation even if the PASID indexes some
other mm?

> However, iommu_sva_alloc_pasid() takes an mm_struct pointer as argument
> which implies it can be something other the the current task mm. So far all
> kernel callers use current task mm. Is there a use case for doing PASID
> allocation on behalf of another mm? If not, can we remove the mm argument?

This would effectively remove the mm parameter from
iommu_sva_bind_device(). I'm not opposed to that, but reintroducing it
later will be difficult if IOMMU drivers start assuming that the bound mm
is from current.

Although there is no use for it at the moment (only two upstream users and
it looks like amdkfd always uses current too), I quite like the
client-server model where the privileged process does bind() and programs
the hardware queue on behalf of the client process.

Thanks,
Jean

