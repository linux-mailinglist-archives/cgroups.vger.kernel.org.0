Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D76377A3B
	for <lists+cgroups@lfdr.de>; Mon, 10 May 2021 04:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhEJC6a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 9 May 2021 22:58:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:51083 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229670AbhEJC6a (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 9 May 2021 22:58:30 -0400
IronPort-SDR: E6BOKqRC3jD8z47qhsrPSJiparxwyQBM0KDe7bSBSM5f61ZqzO2FJ99grDOktqP00D80wojYJw
 h8p8idKlE0Yw==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="263030892"
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="263030892"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2021 19:57:26 -0700
IronPort-SDR: 6K91kGL+MSn6CKe/D+S+5wlos8v6m0M5XDa+qOzvai4vrihr7gv1hyF8fEllhvE+Z003sBqTg7
 jQhqlwfqP/xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="621044664"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga006.fm.intel.com with ESMTP; 09 May 2021 19:57:21 -0700
Cc:     baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Auger Eric <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20210421162307.GM1370958@nvidia.com>
 <20210421105451.56d3670a@redhat.com> <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com> <20210421230301.GP1370958@nvidia.com>
 <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
 <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210423114944.GF1370958@nvidia.com>
 <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210426123817.GQ1370958@nvidia.com>
 <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210428090625.5a05dae8@redhat.com>
 <MWHPR11MB1886E0A7897758AA7BE509058C579@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210507110614.7b8e6998@redhat.com>
 <MWHPR11MB18862452FD4172DCA70C89B88C569@MWHPR11MB1886.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b0b5b9b3-083e-1c77-276d-d6eef84806a6@linux.intel.com>
Date:   Mon, 10 May 2021 10:56:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB18862452FD4172DCA70C89B88C569@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/8/21 3:31 PM, Tian, Kevin wrote:
>> From: Alex Williamson<alex.williamson@redhat.com>
>> Sent: Saturday, May 8, 2021 1:06 AM
>>
>>>> Those are the main ones I can think of.  It is nice to have a simple
>>>> map/unmap interface, I'd hope that a new /dev/ioasid interface wouldn't
>>>> raise the barrier to entry too high, but the user needs to have the
>>>> ability to have more control of their mappings and locked page
>>>> accounting should probably be offloaded somewhere.  Thanks,
>>>>
>>> Based on your feedbacks I feel it's probably reasonable to start with
>>> a type1v2 semantics for the new interface. Locked accounting could
>>> also start with the same VFIO restriction and then improve it
>>> incrementally, if a cleaner way is intrusive (if not affecting uAPI).
>>> But I didn't get the suggestion on "more control of their mappings".
>>> Can you elaborate?
>> Things like I note above, userspace cannot currently specify mapping
>> granularity nor has any visibility to the granularity they get from the
>> IOMMU.  What actually happens in the IOMMU is pretty opaque to the user
>> currently.  Thanks,
>>
> It's much clearer. Based on all the discussions so far I'm thinking about
> a staging approach when building the new interface, basically following
> the model that Jason pointed out - generic stuff first, then platform
> specific extension:
> 
> Phase 1: /dev/ioasid with core ingredients and vfio type1v2 semantics
>      - ioasid is the software handle representing an I/O page table

A trivial proposal, is it possible to use /dev/ioas? Conceptually, it's
an IO address space representation and has nothing to do with any ID.

Best regards,
baolu
