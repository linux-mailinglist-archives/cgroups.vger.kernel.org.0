Return-Path: <cgroups+bounces-1101-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11788825B67
	for <lists+cgroups@lfdr.de>; Fri,  5 Jan 2024 21:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0EA91F22ADA
	for <lists+cgroups@lfdr.de>; Fri,  5 Jan 2024 20:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EDD36087;
	Fri,  5 Jan 2024 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivuNopkJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B5A36085;
	Fri,  5 Jan 2024 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704485617; x=1736021617;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=PVHLn5vPAitcFffraizXuxXVSgSAYNW4jjDAjS3SzWI=;
  b=ivuNopkJcizvHX9SvQ/4dBoLYeTk0sEovJQJID1p7TUaB4mZ5kjYSCjx
   RrEqOZbWY5CmQgF3ZSEBSEp6alF5b7MhSksAhlfpKtIPMfe80kdXhlcTa
   sv65lIpnDqR19Mk4P2hAxDwVNMi93i+mLjM35CS9veEYuEh0XCpx2njZE
   lQVp2Qr/kuslkz57SYeb+kEHzjmXcyv1Qmxa367QC5lK1LH4NmD775UoJ
   69UIZimUPg/0983sSTtkapyQobZXSKw2m2JD7KG8zRH21XjuBDKA+PlAk
   3NDQT02goReKPYPlUrfG3IfSMgrF/UZzRixYkPbKnXeAQp2TVBRB/1ZFO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="394751620"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="394751620"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 12:13:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="1112175221"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="1112175221"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 05 Jan 2024 12:13:32 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
 x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, sohil.mehta@intel.com, "Dave Hansen"
 <dave.hansen@intel.com>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com
Subject: Re: [PATCH v6 00/12] Add Cgroup support for SGX EPC memory
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <772cb101-33e3-4b55-a311-142b22575e7c@intel.com>
Date: Fri, 05 Jan 2024 14:13:31 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2g3bstxxwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <772cb101-33e3-4b55-a311-142b22575e7c@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Fri, 05 Jan 2024 12:29:05 -0600, Dave Hansen <dave.hansen@intel.com>  
wrote:

> There's very little about how the LRU design came to be in this cover
> letter.  Let's add some details.
>
> How's this?
>
> Writing this up, I'm a lot more convinced that this series is, in
> general, taking the right approach.  I honestly don't see any other
> alternatives.  As much as I'd love to do something stupidly simple like
> just killing enclaves at the moment they hit the limit, that would be a
> horrid experience for users _and_ a departure from what the existing
> reclaim support does.
>
> That said, there's still a lot of work do to do refactor this series.
> It's in need of some love to make it more clear what is going on and to
> making the eventual switch over to per-cgroup LRUs more gradual.  Each
> patch in the series is still doing way too much, _especially_ in patch  
> 10.
>
> ==
>
> The existing EPC memory management aims to be a miniature version of the
> core VM where EPC memory can be overcommitted and reclaimed.  EPC
> allocations can wait for reclaim.  The alternative to waiting would have
> been to send a signal and let the enclave die.
>
> This series attempts to implement that same logic for cgroups, for the
> same reasons: it's preferable to wait for memory to become available and
> let reclaim happen than to do things that are fatal to enclaves.
>
> There is currently a global reclaimable page SGX LRU list.  That list
> (and the existing scanning algorithm) is essentially useless for doing
> reclaim when a cgroup hits its limit because the cgroup's pages are
> scattered around that LRU.  It is unspeakably inefficient to scan a
> linked list with millions of entries for what could be dozens of pages
> from a cgroup that needs reclaim.
>
> Even if unspeakably slow reclaim was accepted, the existing scanning
> algorithm only picks a few pages off the head of the global LRU.  It
> would either need to hold the list locks for unreasonable amounts of
> time, or be taught to scan the list in pieces, which has its own  
> challenges.
>
> tl;dr: An cgroup hitting its limit should be as similar as possible to
> the system running out of EPC memory.  The only two choices to implement
> that are nasty changes the existing LRU scanning algorithm, or to add
> new LRUs.  The result: Add a new LRU for each cgroup and scans those
> instead.  Replace the existing global cgroup with the root cgroup's LRU
> (only when this new support is compiled in, obviously).
>

I'll add this to the cover letter as a section justifying the LRU design  
for per-cgroup reclaiming.
Thank you very much.

Haitao

