Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6A5379DF6
	for <lists+cgroups@lfdr.de>; Tue, 11 May 2021 05:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEKDzR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 May 2021 23:55:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:36670 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhEKDzR (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 10 May 2021 23:55:17 -0400
IronPort-SDR: LqEMSbAqPHTjZvTYzvcaY2k7SAMAO/OAnS5s6JRTlGuasQSRN55t6V12VSrhiAuSLwxPR1+XtV
 DOdH5nJjqCEg==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="179611174"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="179611174"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 20:54:08 -0700
IronPort-SDR: BGkUROo0isoG62lW2JllWLXLCmesj1plEIE8OeOyfJmGo/B2YJ6alU7HCdoy+34HdAxDy4SOl8
 qxbcEgvx9lNw==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="408616471"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 20:54:08 -0700
Date:   Mon, 10 May 2021 20:56:32 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Auger Eric <eric.auger@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210510205632.13ff7308@jacob-builder>
In-Reply-To: <20210510234500.GI1002214@nvidia.com>
References: <YJOZhPGheTSlHtQc@myrica>
        <20210506122730.GQ1370958@nvidia.com>
        <20210506163240.GA9058@otc-nc-03>
        <MWHPR11MB188698FBEE62AF1313E0F7AC8C569@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210510123729.GA1002214@nvidia.com>
        <20210510152502.GA90095@otc-nc-03>
        <20210510153111.GB1002214@nvidia.com>
        <20210510162212.GB90095@otc-nc-03>
        <20210510163956.GD1002214@nvidia.com>
        <20210510152854.793ee594@jacob-builder>
        <20210510234500.GI1002214@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

On Mon, 10 May 2021 20:45:00 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, May 10, 2021 at 03:28:54PM -0700, Jacob Pan wrote:
> 
> > To satisfy your "give me a PASID for this RID" proposal, can we just use
> > the RID's struct device as the token? Also add a type field to
> > explicitly indicate global vs per-set(per-RID). i.e.  
> 
> You've got it backwards, the main behavior should be to allocate PASID
> per RID.
> 
Sure, we can make the local PASID as default. My point was that the
ioasid_set infrastructure's opaque token can support RID-local allocation
scheme. Anyway, this is a small detail as compared to uAPI.

> The special behavior is to bundle a bunch of PASIDs into a grouping
> and then say the PASID number space is shared between all the group
> members. 
> 
> /dev/ioasid should create and own this grouping either implicitly or
> explicitly. Jumping ahead to in-kernel APIs has missed the critical
> step of defining the uAPI and all the behaviors together in a
> completed RFC proposal.
> 
Agreed, the requirements for kernel API should come from uAPI.

> Jason


Thanks,

Jacob
