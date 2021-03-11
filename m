Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37A13380F2
	for <lists+cgroups@lfdr.de>; Thu, 11 Mar 2021 23:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhCKWxf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 Mar 2021 17:53:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:44677 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhCKWxS (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 11 Mar 2021 17:53:18 -0500
IronPort-SDR: IMqukzmAhFaQgJrcBIODLP5YjqoPPS50dfdBkSlQZGMQ1LeY7TEOth9Ftb/Mr0H+9UIDJ3fInh
 laelCMkgQdMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="273792716"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="273792716"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 14:53:14 -0800
IronPort-SDR: BnU1jTB+qrvPQr9QBSa1HELuTsIJnS5daNkpyismq4WJ6r58rUNJ+KBsbgbfqudFcqDQrCbdJE
 AMHvxLTGZ7SA==
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="448439603"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 14:53:14 -0800
Date:   Thu, 11 Mar 2021 14:55:34 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
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
        Jonathan Corbet <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [RFC PATCH 18/18] ioasid: Add /dev/ioasid for userspace
Message-ID: <20210311145534.6fe9bb9a@jacob-builder>
In-Reply-To: <20210310192301.GC2356281@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1614463286-97618-19-git-send-email-jacob.jun.pan@linux.intel.com>
        <20210310192301.GC2356281@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

Thanks for the review.

On Wed, 10 Mar 2021 15:23:01 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Sat, Feb 27, 2021 at 02:01:26PM -0800, Jacob Pan wrote:
> 
> > +/* -------- IOCTLs for IOASID file descriptor (/dev/ioasid) -------- */
> > +
> > +/**
> > + * IOASID_GET_API_VERSION - _IO(IOASID_TYPE, IOASID_BASE + 0)
> > + *
> > + * Report the version of the IOASID API.  This allows us to bump the
> > entire
> > + * API version should we later need to add or change features in
> > incompatible
> > + * ways.
> > + * Return: IOASID_API_VERSION
> > + * Availability: Always
> > + */
> > +#define IOASID_GET_API_VERSION		_IO(IOASID_TYPE,
> > IOASID_BASE + 0)  
> 
> I think this is generally a bad idea, if you change the API later then
> also change the ioctl numbers and everything should work out
> 
> eg use the 4th argument to IOC to specify something about the ABI
> 
Let me try to understand the idea, do you mean something like this?
#define IOASID_GET_INFO _IOC(_IOC_NONE, IOASID_TYPE, IOASID_BASE + 1,
sizeof(struct ioasid_info))

If we later change the size of struct ioasid_info, IOASID_GET_INFO would be
a different ioctl number. Then we will break the existing user space that
uses the old number. So I am guessing you meant we need to have a different
name also. i.e.

#define IOASID_GET_INFO_V2 _IOC(_IOC_NONE, IOASID_TYPE, IOASID_BASE + 1,
sizeof(struct ioasid_info_v2))

We can get rid of the API version, just have individual IOCTL version.
Is that right?

> Jason


Thanks,

Jacob
