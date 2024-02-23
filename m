Return-Path: <cgroups+bounces-1822-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 827ED86189C
	for <lists+cgroups@lfdr.de>; Fri, 23 Feb 2024 18:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217AC1F25632
	for <lists+cgroups@lfdr.de>; Fri, 23 Feb 2024 17:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C73712BF08;
	Fri, 23 Feb 2024 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZmQUb5Pw"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDBA128833;
	Fri, 23 Feb 2024 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707639; cv=none; b=nN4KBQXZhYAPsVfz6Mw9160op2BeLpR3bBXyI0nKv5rCgGXgnvYznzfn9dWg6fUXAkH9YiXkb1rX0oqSp0npaI/NpCVuUA/tgJTnx0Cg8aOyTKgReSoBHTRjKf9Hl8i3YjG0vrODIiCtWHwjc6jFXQLyWBRG+yBDFNJ/iBxAZY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707639; c=relaxed/simple;
	bh=LGoVk6is+8EOUaT6DBqIftn7bdpMxDIZS3roVQ+bxRM=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=YyurgBvQkGxPGGIUvzK8+1Z0oxn2Pv0P52rzZZ3ew8WMLl+USI2dAr5R1MeCh79/C+gZ7jkHr+WKCeeSTMTecj+1K490v381D1n/Rh2baqn7eQEaWxR6KIN9j/Bn3C+P63E3+ppMVKgNTELyJDKgSQxuyvzFcADWvBkgFNWKIls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZmQUb5Pw; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708707638; x=1740243638;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=LGoVk6is+8EOUaT6DBqIftn7bdpMxDIZS3roVQ+bxRM=;
  b=ZmQUb5PwEeopoFrMmRGEm3Ri/fixtzZQws1fDciolX88NSDg5R/33I8q
   O8d+/ZFuhIMi7C3iM3UZOcuHxuNcRxe16avSuWGcT0gurQewDIdYQs8sU
   D+x1a6UWNjcC/fBhT24GXvuK0lecsl5wMlLHYpbHHgGLWsHIx1t5vFekC
   emrTA4IUorIoAOTPrNKJO5//PO8MAa3MPNOLoV1AD0eQyUJcVeV0J1YQl
   eHut2GZhTJ5WPdecoWtUhSEx8EA+LcxGqw071Eq3dreSTKUbmlQZNvq1V
   LMklk9++fsLD20lJSY6fEaPlZqK+zpUTy+naZivJOEajIkziRicowEhAO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="2906473"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="2906473"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 09:00:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="5902920"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 23 Feb 2024 09:00:35 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "mingo@redhat.com"
 <mingo@redhat.com>, "jarkko@kernel.org" <jarkko@kernel.org>, "x86@kernel.org"
 <x86@kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
 <hpa@zytor.com>, "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
 "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, "mkoutny@suse.com"
 <mkoutny@suse.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "tj@kernel.org"
 <tj@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, "Huang, Kai"
 <kai.huang@intel.com>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
 <anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
 <yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
 "chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v9 10/15] x86/sgx: Add EPC reclamation in cgroup
 try_charge()
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-11-haitao.huang@linux.intel.com>
 <c5d03171473821ebc9cb79e3dad4d1bf0074e674.camel@intel.com>
 <op.2jjzaqdwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <4db8493b-35a2-474f-997c-5e6ac1b8bd11@intel.com>
 <op.2jkfeezjwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <c913193c0560c4372d2fdb31e9edb28bcb419f50.camel@intel.com>
Date: Fri, 23 Feb 2024 11:00:32 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2jlti6g9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <c913193c0560c4372d2fdb31e9edb28bcb419f50.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Fri, 23 Feb 2024 04:18:18 -0600, Huang, Kai <kai.huang@intel.com> wrote:

>> >
>> Right. When code reaches to here, we already passed reclaim per cgroup.
>
> Yes if try_charge() failed we must do pre-cgroup reclaim.
>
>> The cgroup may not at or reach limit but system has run out of physical
>> EPC.
>>
>
> But after try_charge() we can still choose to reclaim from the current  
> group,
> but not necessarily have to be global, right?  I am not sure whether I am
> missing something, but could you elaborate why we should choose to  
> reclaim from
> the global?
>

Once try_charge is done and returns zero that means the cgroup usage is  
charged and it's not over usage limit. So you really can't reclaim from  
that cgroup if allocation failed. The only  thing you can do is to reclaim  
globally.

This could happen when the sum of limits of all cgroups is greater than  
the physical EPC, i.e., user is overcommitting.

Thanks

Haitao

