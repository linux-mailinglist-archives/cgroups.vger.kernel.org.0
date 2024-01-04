Return-Path: <cgroups+bounces-1078-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0BD8248B8
	for <lists+cgroups@lfdr.de>; Thu,  4 Jan 2024 20:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD82F1C21696
	for <lists+cgroups@lfdr.de>; Thu,  4 Jan 2024 19:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449542C191;
	Thu,  4 Jan 2024 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kaVJ8KjB"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED7A28E26;
	Thu,  4 Jan 2024 19:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704395482; x=1735931482;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=DBk487czzork4gcCBMCfVeAOw7RW7zZUuFillY2fezs=;
  b=kaVJ8KjBBZYQ4Nn30niCl6ol+HZ9+vAiIW7yxqbQdKUyAN1h/FAq9p/8
   W9TRWcvITUihqT6QBKMRWAIAhRCyoNJHo8JJehMpVbbfvQVQz4qmlNcwD
   Hw7gqzjYTPkBfnO3PWMmLP3LKnUN3d5i/DEGslJC+TBDfX8o8/wueSWd2
   A4GsAnBODRMac6tq8EmCKBWqwSbIw+Ftg+XRe0y60FLS7INNGB5xS5odS
   3haix0LBHS25ETisC3bRSXn0r1RFEondJ3XmwnlOsfp/hkAafyzPARt3F
   GJySZmf6Lz8+gUeSPG87QoU6VNmxhdc/ghlIlmx72xQgptQKmHOkspq46
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="4710001"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="4710001"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 11:11:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="22602012"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 04 Jan 2024 11:11:18 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "jarkko@kernel.org"
 <jarkko@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
 <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "tj@kernel.org"
 <tj@kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bp@alien8.de"
 <bp@alien8.de>, "Huang, Kai" <kai.huang@intel.com>, "Dave Hansen"
 <dave.hansen@intel.com>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>, "anakrish@microsoft.com"
 <anakrish@microsoft.com>, "sean.j.christopherson@intel.com"
 <sean.j.christopherson@intel.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
 "yangjie@microsoft.com" <yangjie@microsoft.com>
Subject: Re: [PATCH v6 09/12] x86/sgx: Restructure top-level EPC reclaim
 function
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-10-haitao.huang@linux.intel.com>
 <c8fc40dc56b853fbff14ba22db197c80a6d31820.camel@intel.com>
 <op.2e0yod2lwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <431c5d7f5aee7d11ec2e8aa2e526fde438fa53b4.camel@intel.com>
 <op.2ftmyampwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <3c27bca678c1b041920a14a7da0d958c9861ebca.camel@intel.com>
 <op.2f0eo8r1wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <73ed579be8ad81835df1c309b7c69b491b7f2c8e.camel@intel.com>
 <op.2f523elowjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <4b28fc01-50cf-469b-8161-7d56b863b42b@intel.com>
Date: Thu, 04 Jan 2024 13:11:15 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2g1d81fqwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <4b28fc01-50cf-469b-8161-7d56b863b42b@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

Hi Dave,

On Wed, 03 Jan 2024 10:37:35 -0600, Dave Hansen <dave.hansen@intel.com>  
wrote:

> On 12/18/23 13:24, Haitao Huang wrote:> @Dave and @Michal, Your
> thoughts? Or could you confirm we should not
>> do reclaim per cgroup at all?
> What's the benefit of doing reclaim per cgroup?  Is that worth the extra
> complexity?
>

Without reclaiming per cgroup, then we have to always set the limit to  
enclave's peak usage. This may not be efficient utilization as in many  
cases each enclave can perform fine with EPC limit set less than peak.  
Basically each group can not give up some pages for greater good without  
dying :-)

Also with enclaves enabled with EDMM, the peak usage is not static so hard  
to determine upfront. Hence it might be an operation/deployment  
inconvenience.

In case of over-committing (sum of limits > total capacity), one cgroup at  
peak usage may require swapping pages out in a different cgroup if system  
is overloaded at that time.

> The key question here is whether we want the SGX VM to be complex and
> more like the real VM or simple when a cgroup hits its limit.  Right?
>

Although it's fair to say the majority of complexity of this series is in  
support for reclaiming per cgroup, I think it's manageable and much less  
than real VM after we removed the enclave killing parts: the only extra  
effort is to track pages in separate list and reclaim them in separately  
as opposed to track in on global list and reclaim together. The main  
reclaiming loop code is still pretty much the same as before.


> If stopping at patch 5 and having less code is even remotely an option,
> why not do _that_?
>
I hope I described limitations clear enough above.
If those are OK with users and also make it acceptable for merge quickly,  
I'm happy to do that :-)

Thanks
Haitao

