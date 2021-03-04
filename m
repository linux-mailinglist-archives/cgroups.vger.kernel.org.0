Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415BF32D009
	for <lists+cgroups@lfdr.de>; Thu,  4 Mar 2021 10:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbhCDJuz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Mar 2021 04:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237849AbhCDJuk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Mar 2021 04:50:40 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9450C061756
        for <cgroups@vger.kernel.org>; Thu,  4 Mar 2021 01:49:59 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u14so26898378wri.3
        for <cgroups@vger.kernel.org>; Thu, 04 Mar 2021 01:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iQerbh/hlkdrtsjN7CL+UDqe9kjn7+RgwXvAdE063Tw=;
        b=c1I+m/0DtFCg5CmzpYRMm65XG2djVckGjss/QdwbwALm2jelL+UcfSaOlKXASY2DFf
         8O7l1+7CFT5TntHXoE+osgboHAVci371/X+Qo9hR1VTwXxRaGzW78oKylgL4ZF8EqP+S
         JWnT0AW14TwIWZK/dJR1IFFmeMFA7IIJ+yRD88fK1onkRNqNGgxZ563tEk3qj4S7V0y6
         BiHCqu0Vf4ESb6a9dtNsXT57Q6X28Fp1sBU08nD36GWzxNFy2RUBGFYn+zT0Bf8h6vcX
         GawZr9AANuwyRlAQ8WM3BGRES39pOYipeDPR/+e+TdnTPreexow5BsnfGo+YRZFGZ3f0
         1hYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iQerbh/hlkdrtsjN7CL+UDqe9kjn7+RgwXvAdE063Tw=;
        b=CN4ke6GVuB+f7lfAYPPEOeGyF7ENh1J2MZxRW43lWWYks+pzLzf/axJgClPV09hLdz
         kAmYXaBpCV5+lxiZJCa14he2tFsTvYa6vkrFwlxMHBBJOaI/iiuvYZb+x/wLsly9s4pe
         NNv8B+tSn1bqPSj+kQLNOQcWBw8LF3S9rUf26jDQ8dMXAuNHkNg3ZWvPP7EGOpaNZnTE
         748CKiU+Y/y6S8HihHaf8C+5QXO7C25vYlwyst5N8OlFBXzg12TkM9Apo8Rd10/Nvj+Q
         rCju29bnLVpdT3LT7I3n+i5bzD4++JFtksN9z8duHs3+etew5xFztaEl2ew87V6GoXTM
         Fgwg==
X-Gm-Message-State: AOAM533bEO6O0GXi4VvOpMuNlcli1nNCMbcHt+HnXyA2Nwmx240rEu3E
        tZXWFF7ElqA6cqBdNRyfwHT4Pw==
X-Google-Smtp-Source: ABdhPJwX2IuPcmlP6UueA7sCigE+XrV1z418UQSV521K63EqIq7GZyzJyAA/3mJXGPgiM+HaLZ2JWA==
X-Received: by 2002:adf:e4c7:: with SMTP id v7mr2996353wrm.245.1614851398265;
        Thu, 04 Mar 2021 01:49:58 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id j16sm10609588wmi.2.2021.03.04.01.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 01:49:57 -0800 (PST)
Date:   Thu, 4 Mar 2021 10:49:37 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [RFC PATCH 15/18] cgroup: Introduce ioasids controller
Message-ID: <YECtMZNqSgh7jkGP@myrica>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
 <YD+u3CXhwOi2LC+4@slm.duckdns.org>
 <20210303131726.7a8cb169@jacob-builder>
 <20210303160205.151d114e@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303160205.151d114e@jacob-builder>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 03, 2021 at 04:02:05PM -0800, Jacob Pan wrote:
> Hi Jacob,
> 
> On Wed, 3 Mar 2021 13:17:26 -0800, Jacob Pan
> <jacob.jun.pan@linux.intel.com> wrote:
> 
> > Hi Tejun,
> > 
> > On Wed, 3 Mar 2021 10:44:28 -0500, Tejun Heo <tj@kernel.org> wrote:
> > 
> > > On Sat, Feb 27, 2021 at 02:01:23PM -0800, Jacob Pan wrote:  
> > > > IOASIDs are used to associate DMA requests with virtual address
> > > > spaces. They are a system-wide limited resource made available to the
> > > > userspace applications. Let it be VMs or user-space device drivers.
> > > > 
> > > > This RFC patch introduces a cgroup controller to address the following
> > > > problems:
> > > > 1. Some user applications exhaust all the available IOASIDs thus
> > > > depriving others of the same host.
> > > > 2. System admins need to provision VMs based on their needs for
> > > > IOASIDs, e.g. the number of VMs with assigned devices that perform
> > > > DMA requests with PASID.    
> > > 
> > > Please take a look at the proposed misc controller:
> > > 
> > >  http://lkml.kernel.org/r/20210302081705.1990283-2-vipinsh@google.com
> > > 
> > > Would that fit your bill?  
> > The interface definitely can be reused. But IOASID has a different
> > behavior in terms of migration and ownership checking. I guess SEV key
> > IDs are not tied to a process whereas IOASIDs are. Perhaps this can be
> > solved by adding
> > +	.can_attach	= ioasids_can_attach,
> > +	.cancel_attach	= ioasids_cancel_attach,
> > Let me give it a try and come back.
> > 
> While I am trying to fit the IOASIDs cgroup in to the misc cgroup proposal.
> I'd like to have a direction check on whether this idea of using cgroup for
> IOASID/PASID resource management is viable.

Yes, even for host SVA it would be good to have a cgroup. Currently the
number of shared address spaces is naturally limited by number of
processes, which can be controlled with rlimit and cgroup. But on Arm the
hardware limit on shared address spaces is 64k (number of ASIDs), easily
exhausted with the default PASID and PID limits. So a cgroup for managing
this resource is more than welcome.

It looks like your current implementation is very dependent on
IOASID_SET_TYPE_MM?  I'll need to do more reading about cgroup to see how
easily it can be adapted to host SVA which uses IOASID_SET_TYPE_NULL.

Thanks,
Jean
