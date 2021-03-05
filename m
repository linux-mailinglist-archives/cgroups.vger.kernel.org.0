Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4128432E3AF
	for <lists+cgroups@lfdr.de>; Fri,  5 Mar 2021 09:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhCEIbh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Mar 2021 03:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhCEIbN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Mar 2021 03:31:13 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196CDC061756
        for <cgroups@vger.kernel.org>; Fri,  5 Mar 2021 00:31:12 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j2so1110375wrx.9
        for <cgroups@vger.kernel.org>; Fri, 05 Mar 2021 00:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XWbZV1xuaSmzet0/YcZif2T8HeoxQ88xDpPUR5wIaRM=;
        b=WDBYUW0qE+cgv+jlzpk/LkkEv5rrFExd/rNVN6CPNPszS2oiEe6l8WDOoPwMpJbJ9g
         ifcqD6jPV1lLiR4Yi/mjqfHszxBdJMcLo3KXRTXr9C02Sobabk+4owE0Z41bxe8ob0sf
         TXbIB7FE2gA0+Sjn4it3R8bHCBwJgU43j8xHmxrRaiGMOzXVU8OS4NipVF5fqrdwQXA2
         IIaotAllyZPnmz7mAt2JSTHTtIeJjXlLVUCSIhhKMkEA1E/BRRB28/j/UfjP/wIKBQS/
         GOSaXt0wygQ1kOygpUpLV5Q/GAhYxDax8i6p2F354NInZNYmwDxkG0X/3YVqPpdEXq1x
         imog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XWbZV1xuaSmzet0/YcZif2T8HeoxQ88xDpPUR5wIaRM=;
        b=s17BNMhhgOiSMuBB5bw9/g7tkAYK10TNTkowweTatDPYx55QHXUd7/jAJkbCIy+jNP
         6rnQKtHBH6NeKNV0cNXnjUd8YyH7vky7dKctM/C2fecWDwFhXRbV2zfZ/H6M8M4j031a
         JcQMBVkDgdvx2s02RMF4W0yPNUxhXvcwc6v6jG6NW8f7THy3Eu0Xd1ym0Fscx+2/0KNK
         We+5BJXbcQbIUYahrqA/9as20MbFWT/QkK8BUFmPdFTbBnziry9qKGcz5dvsyCU/9qvT
         NsfuzowOChoXf4Q5hlBRxMf919mlc5xQdk1BNEpxjnvOj8iiSdHQ+l5ZSZ3lXBmGSIzu
         IoAA==
X-Gm-Message-State: AOAM531ewOQDI5GhGJa5pPsJl4KqmU7ese5jtegLR9HfZp/6bJGm2TzO
        U6Zr14lsiULNQJGuWXEUQNfUQQ==
X-Google-Smtp-Source: ABdhPJzCbiuywdjtJ3FXU0Unm3zTVBYkDhWcAaYi2hSBAzjPryfkwbpNyTtMVd+8AZFWxtio6jLxmw==
X-Received: by 2002:adf:ded1:: with SMTP id i17mr8168897wrn.349.1614933070664;
        Fri, 05 Mar 2021 00:31:10 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id w25sm3254177wmc.42.2021.03.05.00.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 00:31:10 -0800 (PST)
Date:   Fri, 5 Mar 2021 09:30:49 +0100
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
Message-ID: <YEHsOR/XjDxQapE6@myrica>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
 <YD+u3CXhwOi2LC+4@slm.duckdns.org>
 <20210303131726.7a8cb169@jacob-builder>
 <20210303160205.151d114e@jacob-builder>
 <YECtMZNqSgh7jkGP@myrica>
 <20210304094603.4ab6c1c4@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304094603.4ab6c1c4@jacob-builder>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 04, 2021 at 09:46:03AM -0800, Jacob Pan wrote:
> Hi Jean-Philippe,
> 
> On Thu, 4 Mar 2021 10:49:37 +0100, Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> 
> > On Wed, Mar 03, 2021 at 04:02:05PM -0800, Jacob Pan wrote:
> > > Hi Jacob,
> > > 
> > > On Wed, 3 Mar 2021 13:17:26 -0800, Jacob Pan
> > > <jacob.jun.pan@linux.intel.com> wrote:
> > >   
> > > > Hi Tejun,
> > > > 
> > > > On Wed, 3 Mar 2021 10:44:28 -0500, Tejun Heo <tj@kernel.org> wrote:
> > > >   
> > > > > On Sat, Feb 27, 2021 at 02:01:23PM -0800, Jacob Pan wrote:    
> > > > > > IOASIDs are used to associate DMA requests with virtual address
> > > > > > spaces. They are a system-wide limited resource made available to
> > > > > > the userspace applications. Let it be VMs or user-space device
> > > > > > drivers.
> > > > > > 
> > > > > > This RFC patch introduces a cgroup controller to address the
> > > > > > following problems:
> > > > > > 1. Some user applications exhaust all the available IOASIDs thus
> > > > > > depriving others of the same host.
> > > > > > 2. System admins need to provision VMs based on their needs for
> > > > > > IOASIDs, e.g. the number of VMs with assigned devices that perform
> > > > > > DMA requests with PASID.      
> > > > > 
> > > > > Please take a look at the proposed misc controller:
> > > > > 
> > > > >  http://lkml.kernel.org/r/20210302081705.1990283-2-vipinsh@google.com
> > > > > 
> > > > > Would that fit your bill?    
> > > > The interface definitely can be reused. But IOASID has a different
> > > > behavior in terms of migration and ownership checking. I guess SEV key
> > > > IDs are not tied to a process whereas IOASIDs are. Perhaps this can be
> > > > solved by adding
> > > > +	.can_attach	= ioasids_can_attach,
> > > > +	.cancel_attach	= ioasids_cancel_attach,
> > > > Let me give it a try and come back.
> > > >   
> > > While I am trying to fit the IOASIDs cgroup in to the misc cgroup
> > > proposal. I'd like to have a direction check on whether this idea of
> > > using cgroup for IOASID/PASID resource management is viable.  
> > 
> > Yes, even for host SVA it would be good to have a cgroup. Currently the
> > number of shared address spaces is naturally limited by number of
> > processes, which can be controlled with rlimit and cgroup. But on Arm the
> > hardware limit on shared address spaces is 64k (number of ASIDs), easily
> > exhausted with the default PASID and PID limits. So a cgroup for managing
> > this resource is more than welcome.
> > 
> > It looks like your current implementation is very dependent on
> > IOASID_SET_TYPE_MM?  I'll need to do more reading about cgroup to see how
> > easily it can be adapted to host SVA which uses IOASID_SET_TYPE_NULL.
> > 
> Right, I was assuming have three use cases of IOASIDs:
> 1. host supervisor SVA (not a concern, just one init_mm to bind)
> 2. host user SVA, either one IOASID per process or perhaps some private
> IOASID for private address space
> 3. VM use for guest SVA, each IOASID is bound to a guest process
> 
> My current cgroup proposal applies to #3 with IOASID_SET_TYPE_MM, which is
> allocated by the new /dev/ioasid interface.
> 
> For #2, I was thinking you can limit the host process via PIDs cgroup? i.e.
> limit fork.

That works but isn't perfect, because the hardware resource of shared
address spaces can be much lower that PID limit - 16k ASIDs on Arm. To
allow an admin to fairly distribute that resource we could introduce
another cgroup just to limit the number of shared address spaces, but
limiting the number of IOASIDs does the trick.

> So the host IOASIDs are currently allocated from the system pool
> with quota of chosen by iommu_sva_init() in my patch, 0 means unlimited use
> whatever is available. https://lkml.org/lkml/2021/2/28/18

Yes that's sensible, but it would be good to plan the cgroup user
interface to work for #2 as well, even if we don't implement it right
away.

Thanks,
Jean
