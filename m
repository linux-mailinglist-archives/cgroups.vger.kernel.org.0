Return-Path: <cgroups+bounces-3115-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0523E8FF030
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2024 17:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8473328BB54
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2024 15:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605E2199E98;
	Thu,  6 Jun 2024 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rlw+lGM2"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437131E494;
	Thu,  6 Jun 2024 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685532; cv=none; b=AY+SDucKsnk5fNKhdRgDnoxxiaxswAHx9QaleaHkWr10cHlcuhWspYfYVPD08Cw/5LM5DX3GSLEzb2xr01uiT1bhX/mWELTynW89S1ABYD5WmbVGGSfnHjoN699W3pgnglLLLD+MrvIzALferxelzLVa8VXN72QsNvNc37QyqwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685532; c=relaxed/simple;
	bh=ih5KlinNy99KtipdP5e9vfFOB8HH84JHruKk/DTM7Nc=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=NVn37fxvEjRze5UOqPB1ezjdXLpZGVOrdXB3HetqzBCVvn15J2aEYbIqH2D+q7ly2uYe8E6DMB6dXlHXKvyKcQj4JzCXPKCwO6OgFRKtsWHRXaC/9EFJ4fu37hsDueFJU9l1KxWgaknRUhF5JYo648T+YHwksaPhw5Eu+O3It4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rlw+lGM2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717685530; x=1749221530;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=ih5KlinNy99KtipdP5e9vfFOB8HH84JHruKk/DTM7Nc=;
  b=Rlw+lGM20SCbtTpGX9R9Y09o6a71J7ol1i6rtc+fDQ6YglQshpRiV5ck
   /GjOWtLKD3r3FAzunDpl0UGzq+Q7xZhaNC7s4ZhPjTZXqrKRJeVhZJL6G
   h8Jgzp0qJJ4VTpb//yeLTCv6MgTT2SkhLvccJn8iy5KKTlZaxoRTbFmQu
   o/wZDJb1mRz77/GK1LtNlDVNf66F5vmSKPnhNBeGJ41l1Gxwlnt/78qiJ
   0+oXRy+Ezi6SCzhnW5QFqmVlysXiVzMjbu8/Qm1vBv/Mlv30ESWCP8A0Y
   Ea0VXs3/CYt4y6Kd3/Z2iHJ34om1ADMl48Cg9Pvz+nkj3VZqkYBln/Rp7
   g==;
X-CSE-ConnectionGUID: 8sfd12fuTvOhlUO+eOjq+w==
X-CSE-MsgGUID: MjhTErU/S/SEOsOBdrC4Qw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="17292290"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="17292290"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 07:51:59 -0700
X-CSE-ConnectionGUID: 4AS7pECdTOShdbhz3z/Icw==
X-CSE-MsgGUID: Yob9KelaRo6dwLNTOd73AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="75459722"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by smtpauth.intel.com with ESMTP/TLS/AES256-SHA; 06 Jun 2024 07:51:57 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: jarkko@kernel.org, dave.hansen@linux.intel.com, kai.huang@intel.com,
 tj@kernel.org, mkoutny@suse.com, linux-kernel@vger.kernel.org,
 linux-sgx@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 sohil.mehta@intel.com, tim.c.chen@linux.intel.com, chenridong
 <chenridong@huawei.com>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v14 02/14] cgroup/misc: Add per resource callbacks for CSS
 events
References: <20240531222630.4634-1-haitao.huang@linux.intel.com>
 <20240531222630.4634-3-haitao.huang@linux.intel.com>
 <eeb1f936-2989-4de0-8353-b2373ce47474@huawei.com>
Date: Thu, 06 Jun 2024 09:51:55 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2ox8wt11wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <eeb1f936-2989-4de0-8353-b2373ce47474@huawei.com>
User-Agent: Opera Mail/1.0 (Win32)

On Thu, 06 Jun 2024 08:37:31 -0500, chenridong <chenridong@huawei.com>  
wrote:

>
>    
> If _misc_cg_res_alloc fails, maybe some types do not call ->alloc(), but  
> all types ->free() callback >will be called, is that ok?
>
Not sure I understand. Are you suggesting we ignore failures from  
->alloc() callback in _misc_cg_res_alloc() as it is per-resource, and have  
->free() callback and resource provider of the failing type to handle the  
failure internally?

IIUC, this failure only happens when a specific subcgroup is created  
(memory running out for allocation) so failing that subcgroup as a whole  
seems fine to me. Note the root node is static and no pre-resource  
callbacks invoked by misc. And resource provider handles its own  
allocations for root. In SGX case we too declare a static object for  
corresponding root sgx_cgroup struct.

Note also misc cgroup (except for setting capacity[res] = 0 at root) is  
all or nothing so no mechanism to tell user "this resource does not work  
but others are fine in this particular cgroup."

Thanks
Haitao

