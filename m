Return-Path: <cgroups+bounces-2696-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FFA8B13B5
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 21:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4714B225AD
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 19:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC22E13B58E;
	Wed, 24 Apr 2024 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mmvq6rPf"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CD81386AA;
	Wed, 24 Apr 2024 19:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713987729; cv=none; b=D81YQWmn1BaUWr3wqI1Co/gqvhv6YeJC31ayWyI5ialtwdVDPKcX/tNr+9fWqL2LysIi37dAPEFLkHB4BKt0/pWDRf7jwgMLe7VSDuRCVyznSPuY7+W1cf5tqKybkcQwTTrE3ZmpAPYJJ3YlKiBxUZnLNRNKDy9dYX8NtZ4/5Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713987729; c=relaxed/simple;
	bh=SmGdTOXSTu0eJ97+MElF8nFJnR06zsOp19Qt7IFFhSw=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=rPdKbvbpfwKwOg3Vq7G5wp6tUlZmxBN4OsSl3r48f30FHqew44kW7rI6rhjPT1Vh3IPg4Q9ZpHApLsHx5fOqqU6hIP8xgd2hoh5d/WFEUoS9il/LViIvbBJTtLa7USDVLovbe/5FRzLgdjmTZsQ7ZHbEM/NE5Bvpen1kQA5MhUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mmvq6rPf; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713987728; x=1745523728;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=SmGdTOXSTu0eJ97+MElF8nFJnR06zsOp19Qt7IFFhSw=;
  b=mmvq6rPf4rQsAhjI720M4L3OOtUPWMJ4yMWSXRgAH8WJxQiUQ+FhRsXg
   maDjrVmU4zaxexqUr9CDsEmr3W6UKyy8nrYAKwBvTPwRheQn1tAHDBSIL
   NUZWTuS75Yr6Jn72cqWyyPtsPJnG8XFkHLqEjD+Rwmw07tzy1zekVUvCX
   lh/8T/WRkrPj5IyepRBYGTLOA7NNo9eGSDKwpJasaH4mQhQJc65pUAKI4
   2bbQMcmDG6Ftyz8juq2rOcPx9JJfEJ23q2EoFDTaGrZLIygWKhlsGk1K9
   f/wSaPjFKPUxi3j+zfRdr7V3MIdemCvlBO2HuvmVTUF10Nt/Jql22IbGi
   A==;
X-CSE-ConnectionGUID: 5sUE9eslQW602PrRHY32YA==
X-CSE-MsgGUID: AWYy+J5YS9qz+Ih+ACHIHA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9570992"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="9570992"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 12:42:07 -0700
X-CSE-ConnectionGUID: +5AZYzF3QfuZAYOPi9tPMg==
X-CSE-MsgGUID: 8T+28TDfTn2FXwjxuzXVPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="29619025"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.125.85.20])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 24 Apr 2024 12:42:04 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: dave.hansen@linux.intel.com, kai.huang@intel.com, tj@kernel.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
 x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, sohil.mehta@intel.com,
 tim.c.chen@linux.intel.com, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v12 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-15-haitao.huang@linux.intel.com>
 <D0LLS28WEXYA.G15BAG7WOJGR@kernel.org> <D0LLVE07V8O0.S8XF3CY2DQ9A@kernel.org>
 <op.2mbs1m05wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <D0LODQCRSTRA.2KSPCDB0FLK0X@kernel.org>
Date: Wed, 24 Apr 2024 14:42:03 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2mqzodbxwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <D0LODQCRSTRA.2KSPCDB0FLK0X@kernel.org>
User-Agent: Opera Mail/1.0 (Win32)

Hi Jarkko
On Tue, 16 Apr 2024 11:08:11 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Tue Apr 16, 2024 at 5:54 PM EEST, Haitao Huang wrote:
>> I did declare the configs in the config file but I missed it in my patch
>> as stated earlier. IIUC, that would not cause this error though.
>>
>> Maybe I should exit with the skip code if no CGROUP_MISC (no more
>> CGROUP_SGX_EPC) is configured?
> OK, so I wanted to do a distro kernel test here, and used the default
> OpenSUSE kernel config. I need to check if it has CGROUP_MISC set.

I couldn't figure out why this failure you have encountered. I think  
OpenSUSE kernel most likely config CGROUP_MISC.

Also if CGROUP_MISC not set, then there should be error happen earlier on  
echoing "+misc" to cgroup.subtree_control at line 20. But your log  
indicates only error on echoing "sgx_epc ..." to  
/sys/fs/cgroup/...//misc.max.

I can only speculate that can could happen (if sgx epc cgroup was compiled  
in) when the cgroup-fs subdirectories in question already have populated  
config that is conflicting with the scripts.

Could you double check or start from a clean environment?
Thanks
Haitao

