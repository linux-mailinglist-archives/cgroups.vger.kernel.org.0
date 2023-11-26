Return-Path: <cgroups+bounces-560-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 576DA7F93D0
	for <lists+cgroups@lfdr.de>; Sun, 26 Nov 2023 17:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5FE1C20ACC
	for <lists+cgroups@lfdr.de>; Sun, 26 Nov 2023 16:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F15D52B;
	Sun, 26 Nov 2023 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Af+UlocV"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC20FE3;
	Sun, 26 Nov 2023 08:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701016341; x=1732552341;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=C1szmEvCxxp64F0iuaAQ1E2knC5KLnUYXFCFe3nV1KE=;
  b=Af+UlocVkTSShDLcOqH+0uPkMMSYGUT7uX1irolSvU5z9rp6qUjSh3Ae
   4yRFA1Yy/tfC2BsN4cK8xmdfWmmbwJeIzy8jVH1OoJ+sQH7jjVR+JG909
   I2zt80PmbKi8orFeCdGoneMAfRMEic5RLjvV08dgkZPmjv+qcUhXETwsQ
   t1ehA+QUQ61tGWQPtR3SaQB7fU33VqqwI8ZtGCn00gW+T58hepUOf1mZ1
   x4fcz5zGmTp/mYIghGQXhkTCAXFfQwT/R9ixJMITyXNulM19XgfzITaf3
   DM0kpI2SRtEwrhFa5dqpSSXNkCjoTIO75t6dHRPJFpHUktlq+2mbgwM4+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="377624607"
X-IronPort-AV: E=Sophos;i="6.04,229,1695711600"; 
   d="scan'208";a="377624607"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 08:32:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,229,1695711600"; 
   d="scan'208";a="9407085"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.124.112.56])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 26 Nov 2023 08:32:16 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "tj@kernel.org" <tj@kernel.org>, "jarkko@kernel.org" <jarkko@kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "cgroups@vger.kernel.org"
 <cgroups@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com"
 <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "linux-sgx@vger.kernel.org"
 <linux-sgx@vger.kernel.org>, "Mehta, Sohil" <sohil.mehta@intel.com>,
 "bp@alien8.de" <bp@alien8.de>, "Huang, Kai" <kai.huang@intel.com>, "Haitao
 Huang" <haitao.huang@linux.intel.com>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
 <yangjie@microsoft.com>, "sean.j.christopherson@intel.com"
 <sean.j.christopherson@intel.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
 "anakrish@microsoft.com" <anakrish@microsoft.com>
Subject: Re: [PATCH v6 04/12] x86/sgx: Implement basic EPC misc cgroup
 functionality
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-5-haitao.huang@linux.intel.com>
 <ad7aafb88e45e5176d15eedea60695e104d24751.camel@intel.com>
 <op.2dz4d5b2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <34a337b96a5a917612c4ec4eff2b5a378c21879b.camel@intel.com>
 <op.2d0ltsxxwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <op.2d0n8tjtwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <d9ad4bac3ac51fe2e8d14931054f681a8264622c.camel@intel.com>
 <op.2e0xhigjwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Date: Mon, 27 Nov 2023 00:32:14 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2e0yv0bnwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2e0xhigjwjvjmi@hhuan26-mobl.amr.corp.intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Mon, 27 Nov 2023 00:01:56 +0800, Haitao Huang  
<haitao.huang@linux.intel.com> wrote:
>>> > > > > Then here we can have something like:
>>> > > > >
>>> > > > > 	void sgx_reclaim_pages(struct sgx_epc_cg *epc_cg)
>>> > > > > 	{
>>> > > > > 		struct sgx_epc_lru_list *lru =			epc_cg ? &epc_cg->lru :
>>> > > > > &sgx_global_lru;
>>> > > > >
>>> > > > > 		sgx_reclaim_pages_lru(lru);
>>> > > > > 	}
>>> > > > >
>>> > > > > Makes sense?
>>> > > > >
>
> The reason we 'isolate' first then do real 'reclaim' is that the actual  
> reclaim is expensive and especially for eblock, etrack, etc.
Sorry this is out of context. It was meant to be in the other response for  
patch 9/12.

Also FYI I'm traveling for a vacation and email access may be sporadic.

BR
Haitao

