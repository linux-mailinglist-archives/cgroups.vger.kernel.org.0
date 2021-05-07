Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2712D376943
	for <lists+cgroups@lfdr.de>; Fri,  7 May 2021 19:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbhEGRHa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 May 2021 13:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29862 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236726AbhEGRH1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 May 2021 13:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620407187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aMtPDGFy4Ih0lIydf3qtNax2aFwdbLPaij5zXJDzDrA=;
        b=VJE7bQtDDy7i13TRikbgpNuqS7tdtE4u6tbM8xwZo+1pmHCDOghWAg57ppz7BbhlxSHubw
        UGNMPe/eYVlomULkKzP3jP/8mCabQydKccv7T+MFAo6pUML26FIuJtbH3TZFGwgZ81OPEe
        ZqM99uzM+VepjXJI1AXpSr9Awh62D0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-cdnh2p0CML6wPTPbIo9ppA-1; Fri, 07 May 2021 13:06:23 -0400
X-MC-Unique: cdnh2p0CML6wPTPbIo9ppA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 882E6107ACCD;
        Fri,  7 May 2021 17:06:20 +0000 (UTC)
Received: from redhat.com (ovpn-113-225.phx2.redhat.com [10.3.113.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F304060CCB;
        Fri,  7 May 2021 17:06:14 +0000 (UTC)
Date:   Fri, 7 May 2021 11:06:14 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
        "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
        Auger Eric <eric.auger@redhat.com>,
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
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210507110614.7b8e6998@redhat.com>
In-Reply-To: <MWHPR11MB1886E0A7897758AA7BE509058C579@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210421162307.GM1370958@nvidia.com>
        <20210421105451.56d3670a@redhat.com>
        <20210421175203.GN1370958@nvidia.com>
        <20210421133312.15307c44@redhat.com>
        <20210421230301.GP1370958@nvidia.com>
        <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210422121020.GT1370958@nvidia.com>
        <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210423114944.GF1370958@nvidia.com>
        <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210426123817.GQ1370958@nvidia.com>
        <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210428090625.5a05dae8@redhat.com>
        <MWHPR11MB1886E0A7897758AA7BE509058C579@MWHPR11MB1886.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 7 May 2021 07:36:49 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Wednesday, April 28, 2021 11:06 PM
> > 
> > On Wed, 28 Apr 2021 06:34:11 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > >
> > > Can you or Alex elaborate where the complexity and performance problem
> > > locate in VFIO map/umap? We'd like to understand more detail and see  
> > how  
> > > to avoid it in the new interface.  
> > 
> > 
> > The map/unmap interface is really only good for long lived mappings,
> > the overhead is too high for things like vIOMMU use cases or any case
> > where the mapping is intended to be dynamic.  Userspace drivers must
> > make use of a long lived buffer mapping in order to achieve performance.  
> 
> This is not a limitation of VFIO map/unmap. It's the limitation of any
> map/unmap semantics since the fact of long-lived vs. short-lived is 
> imposed by userspace. Nested translation is the only viable optimization
> allowing 2nd-level to be a long-lived mapping even w/ vIOMMU. From 
> this angle I'm not sure how a new map/unmap implementation could 
> address this perf limitation alone.

Sure, we don't need to try to tackle every problem at once, a map/unmap
interface compatible with what we have is a good place to start and
nested translation may provide the high performance option.  That's not
to say that we couldn't, in the future, extend the map/unmap with memory
pre-registration like done in the spapr IOMMU to see how that could
reduce latency.

> > The mapping and unmapping granularity has been a problem as well,
> > type1v1 allowed arbitrary unmaps to bisect the original mapping, with
> > the massive caveat that the caller relies on the return value of the
> > unmap to determine what was actually unmapped because the IOMMU use
> > of
> > superpages is transparent to the caller.  This led to type1v2 that
> > simply restricts the user to avoid ever bisecting mappings.  That still
> > leaves us with problems for things like virtio-mem support where we
> > need to create initial mappings with a granularity that allows us to
> > later remove entries, which can prevent effective use of IOMMU
> > superpages.  
> 
> We could start with a semantics similar to type1v2. 
> 
> btw why does virtio-mem require a smaller granularity? Can we split
> superpages in-the-fly when removal actually happens (just similar
> to page split in VM live migration for efficient dirty page tracking)?

The IOMMU API doesn't currently support those semantics.  If the IOMMU
used a superpage, then a superpage gets unmapped, it doesn't get
atomically broken down into smaller pages.  Therefore virtio-mem
proposes a fixed mapping granularity to allow for that same unmapping
granularity.

> and isn't it another problem imposed by userspace? How could a new
> map/unmap implementation mitigate this problem if the userspace 
> insists on a smaller granularity for initial mappings?

Currently if userspace wants to guarantee unmap granularity, they need
to make the same restriction themselves on the mapping granularity.
For instance, userspace cannot currently map a 1GB IOVA range while
guaranteeing 2MB unmap granularity of that range with a single ioctl.
Instead userspace would need to make 512, 2MB mappings calls.

> > Locked page accounting has been another constant issue.  We perform
> > locked page accounting at the container level, where each container
> > accounts independently.  A user may require multiple containers, the
> > containers may pin the same physical memory, but be accounted against
> > the user once per container.  
> 
> for /dev/ioasid there is still an open whether an process is allowed to
> open /dev/ioasid once or multiple times. If there is only one ioasid_fd
> per process, the accounting can be made accurately. otherwise the
> same problem still exists as each ioasid_fd is akin to the container, then
> we need find a better solution.

We had tossed around an idea of a super-container with vfio, it's maybe
something we'd want to incorporate into this design.  For instance, if
memory could be pre-registered with a super container, which would
handle the locked memory accounting for that memory, then
sub-containers could all handle the IOMMU context of their sets of
devices relative to that common memory pool.
 
> > Those are the main ones I can think of.  It is nice to have a simple
> > map/unmap interface, I'd hope that a new /dev/ioasid interface wouldn't
> > raise the barrier to entry too high, but the user needs to have the
> > ability to have more control of their mappings and locked page
> > accounting should probably be offloaded somewhere.  Thanks,
> >   
> 
> Based on your feedbacks I feel it's probably reasonable to start with
> a type1v2 semantics for the new interface. Locked accounting could
> also start with the same VFIO restriction and then improve it
> incrementally, if a cleaner way is intrusive (if not affecting uAPI).
> But I didn't get the suggestion on "more control of their mappings".
> Can you elaborate?

Things like I note above, userspace cannot currently specify mapping
granularity nor has any visibility to the granularity they get from the
IOMMU.  What actually happens in the IOMMU is pretty opaque to the user
currently.  Thanks,

Alex

