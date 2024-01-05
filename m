Return-Path: <cgroups+bounces-1094-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304068255F5
	for <lists+cgroups@lfdr.de>; Fri,  5 Jan 2024 15:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6BB1C23258
	for <lists+cgroups@lfdr.de>; Fri,  5 Jan 2024 14:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1B62DF87;
	Fri,  5 Jan 2024 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3VHuMCq"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4088F4A;
	Fri,  5 Jan 2024 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704465868; x=1736001868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GgyqztMwZYzha76gD8nEpDu6CYIYIn6/9uBQgpVtcd0=;
  b=H3VHuMCqLzpWDuDUdPn3dJ8oeNays+0LcK+DBYdf16WWTZsGkxWSnM2t
   0gehmoFGc7Y2Iy5xDqakRkvwk1j3QTBaJEStzmTykjAd/dk4JH+tsdQzq
   ZQhNKSWHJ4WD5fSirCN+a3Kw7GzocICclOKruvbT5eu5ibNqQkikXvqUe
   IY2+BsEjIbW9WFiSShPWfABQA774f7XjAsdfIIo5ZtZ2Wt6V1t3BLUfM4
   hhB3zhCd1fxei1ijvNlMEZ1LJibPf7+9mwDdIXnDOwSQ8RYK+jM33HyNi
   T8Kh79j4JmjgBPhZJqGWFWYpPOqwE+J6/mLp4p/wYCoG8RuBxrMrO8zYi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="394691374"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="394691374"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 06:43:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="22508281"
Received: from lmurph2-mobl1.ger.corp.intel.com (HELO himmelriiki) ([10.252.51.171])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 06:43:32 -0800
Date: Fri, 5 Jan 2024 16:43:23 +0200
From: Mikko Ylinen <mikko.ylinen@linux.intel.com>
To: Haitao Huang <haitao.huang@linux.intel.com>
Cc: "Mehta, Sohil" <sohil.mehta@intel.com>,
	"jarkko@kernel.org" <jarkko@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"tj@kernel.org" <tj@kernel.org>,
	"mkoutny@suse.com" <mkoutny@suse.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "Huang, Kai" <kai.huang@intel.com>,
	Dave Hansen <dave.hansen@intel.com>,
	"seanjc@google.com" <seanjc@google.com>,
	"Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>,
	"anakrish@microsoft.com" <anakrish@microsoft.com>,
	"sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
	"Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"yangjie@microsoft.com" <yangjie@microsoft.com>
Subject: Re: [PATCH v6 09/12] x86/sgx: Restructure top-level EPC reclaim
 function
Message-ID: <ZZgVi7rHAAzyzbz5@himmelriiki>
References: <c8fc40dc56b853fbff14ba22db197c80a6d31820.camel@intel.com>
 <op.2e0yod2lwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <431c5d7f5aee7d11ec2e8aa2e526fde438fa53b4.camel@intel.com>
 <op.2ftmyampwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <3c27bca678c1b041920a14a7da0d958c9861ebca.camel@intel.com>
 <op.2f0eo8r1wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <73ed579be8ad81835df1c309b7c69b491b7f2c8e.camel@intel.com>
 <op.2f523elowjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <4b28fc01-50cf-469b-8161-7d56b863b42b@intel.com>
 <op.2g1d81fqwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.2g1d81fqwjvjmi@hhuan26-mobl.amr.corp.intel.com>

On Thu, Jan 04, 2024 at 01:11:15PM -0600, Haitao Huang wrote:
> Hi Dave,
> 
> On Wed, 03 Jan 2024 10:37:35 -0600, Dave Hansen <dave.hansen@intel.com>
> wrote:
> 
> > On 12/18/23 13:24, Haitao Huang wrote:> @Dave and @Michal, Your
> > thoughts? Or could you confirm we should not
> > > do reclaim per cgroup at all?
> > What's the benefit of doing reclaim per cgroup?  Is that worth the extra
> > complexity?
> > 
> 
> Without reclaiming per cgroup, then we have to always set the limit to
> enclave's peak usage. This may not be efficient utilization as in many cases
> each enclave can perform fine with EPC limit set less than peak. Basically
> each group can not give up some pages for greater good without dying :-)

+1. this is exactly my thinking too. The per cgroup reclaiming is
important for the containers use case we are working on. I also think
it makes the limit more meaningful: the per-container pool of EPC pages
to use (which is independent of the enclave size).

> 
> Also with enclaves enabled with EDMM, the peak usage is not static so hard
> to determine upfront. Hence it might be an operation/deployment
> inconvenience.
> 
> In case of over-committing (sum of limits > total capacity), one cgroup at
> peak usage may require swapping pages out in a different cgroup if system is
> overloaded at that time.
> 
> > The key question here is whether we want the SGX VM to be complex and
> > more like the real VM or simple when a cgroup hits its limit.  Right?
> > 
> 
> Although it's fair to say the majority of complexity of this series is in
> support for reclaiming per cgroup, I think it's manageable and much less
> than real VM after we removed the enclave killing parts: the only extra
> effort is to track pages in separate list and reclaim them in separately as
> opposed to track in on global list and reclaim together. The main reclaiming
> loop code is still pretty much the same as before.
> 
> 
> > If stopping at patch 5 and having less code is even remotely an option,
> > why not do _that_?
> > 
> I hope I described limitations clear enough above.
> If those are OK with users and also make it acceptable for merge quickly,

You explained the gaps very well already. I don't think the simple
version without per-cgroup reclaiming is enough for the container case.

Mikko

