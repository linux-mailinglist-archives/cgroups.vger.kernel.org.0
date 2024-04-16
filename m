Return-Path: <cgroups+bounces-2530-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467E98A6F2D
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 17:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D4B28268A
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 15:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C3612FB02;
	Tue, 16 Apr 2024 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9wAM27U"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDA16D1AB;
	Tue, 16 Apr 2024 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279612; cv=none; b=kNcJbXDTQpgrnP91xiMqW7ZddA6eMlF9qbHRVXHjc4HRYzfVUrm4maRU+QjSYe4V9RTDNwQ5o2uVUrJ0G0WEhUyi4vzBPZLUdY5cSrsZQ+HwI9gsIBMW/v/W0UboIJ/WOWigBCLBrcapaqFf7c3C5+qxdDTWtwBKVzHd+Pv/vRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279612; c=relaxed/simple;
	bh=nrNGdspUY2MA4cZLzNPfyVJ3VvX44skwFLah1BoPykA=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=GrSN2WRE059DxhLmsPkfHemCXDEur90XIeqvWsqLRgq7nbUUgH8d0CzJAXCniX2Au2bpdZs95PKrRIwVBu0DO0CJV704SXveaA5IFVYSxFLUMe+rh6NrZNW6lucrYpT9zJgceceO04j4L5fNjnypQq4ulGFU2jnbY2wGn270RoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9wAM27U; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713279610; x=1744815610;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=nrNGdspUY2MA4cZLzNPfyVJ3VvX44skwFLah1BoPykA=;
  b=L9wAM27Up8BqTaNr1gzyGL+lUiJjLk3kEuO/tjd0Zvh9SpVLTTJh8moa
   /8RBGi2u02scbS/uBtRTTVIcQECcIk+5N+R8/z0NBqRBg8fkTgOEYUvRh
   vqkyXqqcG4k9PpZJPl5+tYPGgZHXUvf/1X/x+EYyvksDtuBh1xMpgst90
   x1Kys/Axu7hCJ9T6l/Cvfoo/dSZN4Ka4nBDxICHP20BmKtItTiBChdgWs
   eReu412BSoDudFHtuvCT5aAZ17R2EF7jPc1RRK/nIFqhoZ16rZ4ny2rJ5
   0/5/rdSKDkhPxyd0AFtJiS6yC1HACn/0FfdBx9RRKmGtk4krWpk08EIAU
   A==;
X-CSE-ConnectionGUID: ityWB6exQwWHuA96v46fQQ==
X-CSE-MsgGUID: RX64/b1bRkimA6QVwFAjnQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12510290"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="12510290"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 08:00:08 -0700
X-CSE-ConnectionGUID: oMifNSxhSkezhTO4NfCBOw==
X-CSE-MsgGUID: naXUZVRUTmCIJwM+7Ju1IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22341754"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 16 Apr 2024 08:00:06 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "hpa@zytor.com" <hpa@zytor.com>, "tim.c.chen@linux.intel.com"
 <tim.c.chen@linux.intel.com>, "linux-sgx@vger.kernel.org"
 <linux-sgx@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "jarkko@kernel.org" <jarkko@kernel.org>, "cgroups@vger.kernel.org"
 <cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "Mehta, Sohil"
 <sohil.mehta@intel.com>, "tj@kernel.org" <tj@kernel.org>, "mingo@redhat.com"
 <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "Huang, Kai"
 <kai.huang@intel.com>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "anakrish@microsoft.com"
 <anakrish@microsoft.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>, "yangjie@microsoft.com"
 <yangjie@microsoft.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
 "chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: [PATCH v12 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-15-haitao.huang@linux.intel.com>
 <op.2ma195shwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <6b056faa6de2ba3a15c2e5dd576e96e3f85375ba.camel@intel.com>
Date: Tue, 16 Apr 2024 10:00:04 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2mbtaekmwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <6b056faa6de2ba3a15c2e5dd576e96e3f85375ba.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Tue, 16 Apr 2024 00:42:41 -0500, Huang, Kai <kai.huang@intel.com> wrote:

>>
>> I'll send a fixup for this patch or another version of the series if  
>> more
>> changes are needed.
>
> Hi Haitao,
>
> I don't like to say but in general I think you are sending too  
> frequently.  The
> last version was sent April, 11th (my time), so considering the weekend  
> it has
> only been 3 or at most 4 days.  
> Please slow down a little bit to give people more time.
>
> More information please also see:
>
> https://www.kernel.org/doc/html/next/process/submitting-patches.html#resend-reminders

Thanks for the feedback. I'll slow down sending new versions.

Haitao

