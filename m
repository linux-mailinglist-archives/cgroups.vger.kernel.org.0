Return-Path: <cgroups+bounces-1103-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED3C825DBA
	for <lists+cgroups@lfdr.de>; Sat,  6 Jan 2024 02:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881461C23574
	for <lists+cgroups@lfdr.de>; Sat,  6 Jan 2024 01:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82748137C;
	Sat,  6 Jan 2024 01:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ARAFEXx0"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE90A136F;
	Sat,  6 Jan 2024 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704505537; x=1736041537;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=I7ISMq5q/B01ovQP1nPBuwY/StwXPNKBMHk+gR7gvYU=;
  b=ARAFEXx0RqAecQeGLXCaCMAKjIXuUYM9fKXb8bHfDxHqy8776jO7q+M7
   I45hx1Yddpl1lNo6DfeKrldqMBy0ifmKeeA04e5A6Zlgvt+Oy7A76v/Pg
   TJcWVnz998neg7W1LQtuz4zw+VtMz5/d952ai0MB5KTSFTJoNo9lm7/pS
   d9/Kt1zcbDbh35wEo61YRBMSjldIQ5kTImXlgqzuTnWVL0/1/QQUsKCEH
   Fc5Lm8L4FZjKHUooHqh/IiN7JlUcKZfkodFWqQ1npWYB2QO6V93CzAZOk
   8Inqb0rHse3r/Rf1iSaFRz8F8n3pXN/1o8Chm20HJ4kCLuQ5TOR/cI9+h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="396510003"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="396510003"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 17:45:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="899805978"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="899805978"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 05 Jan 2024 17:45:23 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
 x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, sohil.mehta@intel.com, "Dave Hansen"
 <dave.hansen@intel.com>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, "Sean Christopherson" <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v6 07/12] x86/sgx: Introduce EPC page states
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-8-haitao.huang@linux.intel.com>
 <0f3ae753-031f-4f33-b577-8c863b4621a1@intel.com>
Date: Fri, 05 Jan 2024 19:45:23 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2g3q5xxfwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <0f3ae753-031f-4f33-b577-8c863b4621a1@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Fri, 05 Jan 2024 11:57:03 -0600, Dave Hansen <dave.hansen@intel.com>  
wrote:

> On 10/30/23 11:20, Haitao Huang wrote:
>> @@ -527,16 +530,13 @@ void sgx_mark_page_reclaimable(struct  
>> sgx_epc_page *page)
>>  int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
>>  {
>>  	spin_lock(&sgx_global_lru.lock);
>> -	if (page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED) {
>> -		/* The page is being reclaimed. */
>> -		if (list_empty(&page->list)) {
>> -			spin_unlock(&sgx_global_lru.lock);
>> -			return -EBUSY;
>> -		}
>> -
>> -		list_del(&page->list);
>> -		page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
>> +	if (sgx_epc_page_reclaim_in_progress(page->flags)) {
>> +		spin_unlock(&sgx_global_lru.lock);
>> +		return -EBUSY;
>>  	}
>> +
>> +	list_del(&page->list);
>> +	sgx_epc_page_reset_state(page);
>
> I want to know how much if this series is basically line-for-line
> abstraction shifting like:
>
> -	page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
> +	sgx_epc_page_reset_state(page);
>
> versus actually adding complexity.  That way, I might be able to offer
> some advice on where this can be pared down.  That's really hard to do
> with the current series.
>
> Please don't just "introduce new page states".  This should have first
> abstracted out the sgx_epc_page_reclaim_in_progress() operation, using
> the list_empty() check as the implementation.
>
> Then, in a separate patch, introduce the concept of the "reclaim in
> progress" flag and finally flip the implementation over.
>
> Ditto for the sgx_epc_page_reset_state() abstraction.  It should have
> been introduced separately as a concept and then have the implementation
> changed.
>
> On in to patch 10 (which is much too big) which introduces the
> sgx_lru_list() abstraction.
>

Sure. I'll try to refactor according to this plan.
Thanks
Haitao

