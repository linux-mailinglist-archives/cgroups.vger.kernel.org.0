Return-Path: <cgroups+bounces-3256-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF71910A1B
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 17:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869F02810BA
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 15:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777FB1B0104;
	Thu, 20 Jun 2024 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BF7AP6Rc"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9506A1ACE94;
	Thu, 20 Jun 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897987; cv=none; b=iynP4O8SWYrExAL6bfCwTKzKmPt81NKEyGa7OBXgKdkPvLYyOQCPLgGi8ZTyye8CkNCiSHIQJSRFN4U8H6zjKY1n1GLeN86iFPIpsJzMXUBlieT4P8/r+vkpp3zPQ4dKDXGd28Zpn7ZG071HeYvpE1MaYN43Y0nmL3IcCJ8BO4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897987; c=relaxed/simple;
	bh=62VsBGjCS60/dcZu2tDPxW6nThjEg9CgcwxF1KZdk2A=;
	h=Content-Type:Cc:References:Subject:To:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=aiwgVGa1kZkm86Cri1waqbJyKFseYWsxUnAlHyiTeNX93HflTYaDYDeYY0sMVb8fwXz4kUBIvZt3d0gdkUvuFjHJ2qohC2+UiZdL0Ju+D82FfAb1GbBMd1fbNpaHLi5TmLecC1ElLuK4rtrOXmAPIQ7Dbc7Czw4fGFPwXR76qak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BF7AP6Rc; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718897986; x=1750433986;
  h=cc:references:subject:to:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=62VsBGjCS60/dcZu2tDPxW6nThjEg9CgcwxF1KZdk2A=;
  b=BF7AP6Rc0q4SG+Hh9J2zMR6NWygZbVW+Ey9tpn/e9H8hqOFURkgJvsP7
   PF1MT+pLObdxWGH4tMrgiRgGV0OGaNqOMVK2oTqNWd0938sp6a8ZFgMkn
   DjsvHTtU186aZot5v60SZdqWgokVeS8KoNB9G3dWVGFKsakAHqouYz/ci
   HPYcBv6U3REkzXZxcLWFZKTeu7/QY5g1T5+VOZ64dzE3durYtmGb7szoK
   Qv6R4UJaeO2nFBdC1tyIgdpOpAPxaqFKRRYexjZsCw3XwwA4RQdUgugR0
   45Y6boFGDKHzqng+kQcPpm+x6oagPZHBHre/o6nMCLZE6tTmo1KsbdF5o
   A==;
X-CSE-ConnectionGUID: XlMAHyUjQ3+08GpLZhROdw==
X-CSE-MsgGUID: 8jin4SFsTm+MiUurWkjvNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="16005786"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="16005786"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 08:39:45 -0700
X-CSE-ConnectionGUID: XW8b/AoKT0qs6sDXKUmqrg==
X-CSE-MsgGUID: k0Zos2SWTs+mCte5EQpUlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42393951"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.246.119.97])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 20 Jun 2024 08:39:42 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
References: <20240617125321.36658-1-haitao.huang@linux.intel.com>
 <20240617125321.36658-11-haitao.huang@linux.intel.com>
Subject: Re: [PATCH v15 10/14] x86/sgx: Implement async reclamation for cgroup
To: jarkko@kernel.org, dave.hansen@linux.intel.com, kai.huang@intel.com,
 tj@kernel.org, mkoutny@suse.com, chenridong@huawei.com,
 linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org, x86@kernel.org,
 cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, sohil.mehta@intel.com, tim.c.chen@linux.intel.com, "Huang,
 Haitao" <haitao.huang@linux.intel.com>
Date: Thu, 20 Jun 2024 10:39:41 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2pn8gfahwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <20240617125321.36658-11-haitao.huang@linux.intel.com>
User-Agent: Opera Mail/1.0 (Win32)


> +	if (cgroup_subsys_enabled(misc_cgrp_subsys)) {
> +		sgx_cg_wq = alloc_workqueue("sgx_cg_wq", WQ_UNBOUND | WQ_FREEZABLE,
> +					    WQ_UNBOUND_MAX_ACTIVE);
> +		return -ENOMEM;

Argh, missing if(!sgx_cg_wq), sorry for the brain fart. Tests pass only
because I made another silly mistake in checking return of this function.
:-(
Haitao

