Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11E5379A07
	for <lists+cgroups@lfdr.de>; Tue, 11 May 2021 00:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhEJW1n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 May 2021 18:27:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:65501 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231368AbhEJW1f (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 10 May 2021 18:27:35 -0400
IronPort-SDR: ACj4mbbfIcAwS4u1dCJGNoEOCL41bCs1O8kcJy1hngtYf7Q95vMzHM5U2u07QRsooR43Xi0zQB
 lj8bM/YwYZ9w==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="199370758"
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="199370758"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 15:26:29 -0700
IronPort-SDR: yCwHeJ6rRkGtKNof8GEjqbaKxAz/e7UvMdOJ0H5gQ+/vROArz2qCNRf+ThKjmZy9CsF3QLI59T
 YjeHavqKiVRA==
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="430065112"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 15:26:29 -0700
Date:   Mon, 10 May 2021 15:28:54 -0700
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
Message-ID: <20210510152854.793ee594@jacob-builder>
In-Reply-To: <20210510163956.GD1002214@nvidia.com>
References: <20210505180023.GJ1370958@nvidia.com>
        <20210505130446.3ee2fccd@jacob-builder>
        <YJOZhPGheTSlHtQc@myrica>
        <20210506122730.GQ1370958@nvidia.com>
        <20210506163240.GA9058@otc-nc-03>
        <MWHPR11MB188698FBEE62AF1313E0F7AC8C569@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210510123729.GA1002214@nvidia.com>
        <20210510152502.GA90095@otc-nc-03>
        <20210510153111.GB1002214@nvidia.com>
        <20210510162212.GB90095@otc-nc-03>
        <20210510163956.GD1002214@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jason,

On Mon, 10 May 2021 13:39:56 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> I still think it is smarter to push a group of RID's into a global
> allocation group and accept there are potential downsides with that
> than to try to force a global allocation group on every RID and then
> try to fix the mess that makes for non-ENQCMD devices.
The proposed ioasid_set change in this set has a token for each set of
IOASIDs.

/**
 * struct ioasid_set - Meta data about ioasid_set
 * @nh:		List of notifiers private to that set
 * @xa:		XArray to store ioasid_set private IDs, can be used for
 *		guest-host IOASID mapping, or just a private IOASID namespace.
 * @token:	Unique to identify an IOASID set
 * @type:	Token types
 * @quota:	Max number of IOASIDs can be allocated within the set
 * @nr_ioasids:	Number of IOASIDs currently allocated in the set
 * @id:		ID of the set
 */
struct ioasid_set {
	struct atomic_notifier_head nh;
	struct xarray xa;
	void *token;
	int type;
	int quota;
	atomic_t nr_ioasids;
	int id;
	struct rcu_head rcu;
	struct misc_cg *misc_cg; /* For misc cgroup accounting */
};

To satisfy your "give me a PASID for this RID" proposal, can we just use
the RID's struct device as the token? Also add a type field to explicitly
indicate global vs per-set(per-RID). i.e.

ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
		       int type, void *private)
Where flags can be:
enum ioasid_hwid_type {
	IOASID_HWID_GLOBAL,
	IOASID_HWID_PER_SET,
};

We are really talking about the HW IOASID, just a reminder.

Thanks,

Jacob
