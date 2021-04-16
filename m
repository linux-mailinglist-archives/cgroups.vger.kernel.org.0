Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CB33626A1
	for <lists+cgroups@lfdr.de>; Fri, 16 Apr 2021 19:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241167AbhDPRVv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Apr 2021 13:21:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:13987 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233606AbhDPRVu (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 16 Apr 2021 13:21:50 -0400
IronPort-SDR: usxTo4F52PJ5piVi/n2nXzVZwhG8GKREy7wmGHSiRp7UbRKi+csBEhp2pSiHRbfHFA4AknM074
 oUiAPb5sa/Uw==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="215611395"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="215611395"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 10:20:54 -0700
IronPort-SDR: 7aKIREIfd33fUejts9JO8C/JGcYaQKmRX9TIcVRpgZbxyjn9wJ5qbogVNvpiG7jHljOCuydnji
 hk70wzrofMfg==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="425664043"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 10:20:53 -0700
Date:   Fri, 16 Apr 2021 10:23:32 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Auger Eric <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
        "Jiang, Dave" <dave.jiang@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210416102332.6f71e53e@jacob-builder>
In-Reply-To: <20210416094547.1774e1a3@redhat.com>
References: <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
        <20210331124038.GE1463678@nvidia.com>
        <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
        <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
        <YGW27KFt9eQB9X2z@myrica>
        <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
        <20210401134236.GF1463678@nvidia.com>
        <BN6PR11MB4068C4DE7AF43D44DE70F4C1C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
        <20210401160337.GJ1463678@nvidia.com>
        <4bea6eb9-08ad-4b6b-1e0f-c97ece58a078@redhat.com>
        <20210415230732.GG1370958@nvidia.com>
        <20210416061258.325e762e@jacob-builder>
        <20210416094547.1774e1a3@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Alex,

On Fri, 16 Apr 2021 09:45:47 -0600, Alex Williamson
<alex.williamson@redhat.com> wrote:

> On Fri, 16 Apr 2021 06:12:58 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > Hi Jason,
> > 
> > On Thu, 15 Apr 2021 20:07:32 -0300, Jason Gunthorpe <jgg@nvidia.com>
> > wrote: 
> > > On Thu, Apr 15, 2021 at 03:11:19PM +0200, Auger Eric wrote:    
> > > > Hi Jason,
> > > > 
> > > > On 4/1/21 6:03 PM, Jason Gunthorpe wrote:      
> > > > > On Thu, Apr 01, 2021 at 02:08:17PM +0000, Liu, Yi L wrote:
> > > > >       
> > > > >> DMA page faults are delivered to root-complex via page request
> > > > >> message and it is per-device according to PCIe spec. Page request
> > > > >> handling flow is:
> > > > >>
> > > > >> 1) iommu driver receives a page request from device
> > > > >> 2) iommu driver parses the page request message. Get the
> > > > >> RID,PASID, faulted page and requested permissions etc.
> > > > >> 3) iommu driver triggers fault handler registered by device
> > > > >> driver with iommu_report_device_fault()      
> > > > > 
> > > > > This seems confused.
> > > > > 
> > > > > The PASID should define how to handle the page fault, not the
> > > > > driver. 
> > > > 
> > > > In my series I don't use PASID at all. I am just enabling nested
> > > > stage and the guest uses a single context. I don't allocate any
> > > > user PASID at any point.
> > > > 
> > > > When there is a fault at physical level (a stage 1 fault that
> > > > concerns the guest), this latter needs to be reported and injected
> > > > into the guest. The vfio pci driver registers a fault handler to
> > > > the iommu layer and in that fault handler it fills a circ bugger
> > > > and triggers an eventfd that is listened to by the VFIO-PCI QEMU
> > > > device. this latter retrives the faault from the mmapped circ
> > > > buffer, it knowns which vIOMMU it is attached to, and passes the
> > > > fault to the vIOMMU. Then the vIOMMU triggers and IRQ in the guest.
> > > > 
> > > > We are reusing the existing concepts from VFIO, region, IRQ to do
> > > > that.
> > > > 
> > > > For that use case, would you also use /dev/ioasid?      
> > > 
> > > /dev/ioasid could do all the things you described vfio-pci as doing,
> > > it can even do them the same way you just described.
> > > 
> > > Stated another way, do you plan to duplicate all of this code someday
> > > for vfio-cxl? What about for vfio-platform? ARM SMMU can be hooked to
> > > platform devices, right?
> > > 
> > > I feel what you guys are struggling with is some choice in the iommu
> > > kernel APIs that cause the events to be delivered to the pci_device
> > > owner, not the PASID owner.
> > > 
> > > That feels solvable.
> > >     
> > Perhaps more of a philosophical question for you and Alex. There is no
> > doubt that the direction you guided for /dev/ioasid is a much cleaner
> > one, especially after VDPA emerged as another IOMMU backed framework.  
> 
> I think this statement answers all your remaining questions ;)
> 
> > The question is what do we do with the nested translation features that
> > have been targeting the existing VFIO-IOMMU for the last three years?
> > That predates VDPA. Shall we put a stop marker *after* nested support
> > and say no more extensions for VFIO-IOMMU, new features must be built
> > on this new interface?
> >
> > If we were to close a checkout line for some unforeseen reasons, should
> > we honor the customers already in line for a long time?
> > 
> > This is not a tactic or excuse for not working on the new /dev/ioasid
> > interface. In fact, I believe we can benefit from the lessons learned
> > while completing the existing. This will give confidence to the new
> > interface. Thoughts?  
> 
> I understand a big part of Jason's argument is that we shouldn't be in
> the habit of creating duplicate interfaces, we should create one, well
> designed interfaces to share among multiple subsystems.  As new users
> have emerged, our solution needs to change to a common one rather than
> a VFIO specific one.  The IOMMU uAPI provides an abstraction, but at
> the wrong level, requiring userspace interfaces for each subsystem.
> 
> Luckily the IOMMU uAPI is not really exposed as an actual uAPI, but
> that changes if we proceed to enable the interfaces to tunnel it
> through VFIO.
> 
> The logical answer would therefore be that we don't make that
> commitment to the IOMMU uAPI if we believe now that it's fundamentally
> flawed.
> 
I agree the uAPI data tunneling is definitely flawed in terms of
scalability.

I was just thinking it is still a small part of the overall
picture. Considering there are other parts such as fault reporting, user
space deployment, performance, and security. By completing the support on
the existing VFIO framework, it would at least offer a clear landscape where
the new /dev/ioasid can improve upon.

Perhaps similar to cgroup v1 vs v2, it took a long time and with known
limitations in v1.

Anyway, I am glad we have a clear direction now.

Thanks,

Jacob

> Ideally this new /dev/ioasid interface, and making use of it as a VFIO
> IOMMU backend, should replace type1.  Type1 will live on until that
> interface gets to parity, at which point we may deprecate type1, but it
> wouldn't make sense to continue to expand type1 in the same direction
> as we intend /dev/ioasid to take over in the meantime, especially if it
> means maintaining an otherwise dead uAPI.  Thanks,
> 

> Alex
> 


Thanks,

Jacob
