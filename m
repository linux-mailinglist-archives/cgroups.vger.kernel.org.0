Return-Path: <cgroups+bounces-2550-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD59E8A77BF
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 00:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E941E1C224EA
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 22:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F4983CC1;
	Tue, 16 Apr 2024 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kqnL2noq"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA5717736;
	Tue, 16 Apr 2024 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713306213; cv=none; b=RZ8MOf9XN8Kg4cpTbgVp1p9RPqyWB+/GN+/bXldqtppkWL9xLZooTvV36AkYFJ/4Nqw8wHqsq7RUo17Dvt8USl0ifqaF3MrwasST+wTT1L8p4cwOSshA9O+wumyEOWLt180mnDR1akc95n2R7RB392xCaMxuTwVNCT8JbDsuiec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713306213; c=relaxed/simple;
	bh=okXLK7U+p1w4VwcBREA6mmrKScpE7rX8NtMqNoLNqlM=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=RQylCrE1PXObJz2V0qQabaZhJNPWw0QdOMJkwMLBYO35Ky4woTRgctn9GrHggSNE+EWOlkZ5FOZ8uUVxDmNovKmpOXsCoXzOTSA6sSsmuSPCyXwXt12/cS/PNmhFqxt9B06mjJojCsRr9sy7sltufRDgNTZjyPA0s3wallSozjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kqnL2noq; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713306212; x=1744842212;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=okXLK7U+p1w4VwcBREA6mmrKScpE7rX8NtMqNoLNqlM=;
  b=kqnL2noqDN8NHOoLp9/HYRf+TSL0aOMJUzrxx+yVF66S5UqaLkgnq9i4
   R5ta6f0pUuYlHXw+AGoyPGHhYTNubGN85z9llYTJ3kImgvLDY156ThiJK
   7w0/tHBv8NYK8etM+XSsFwPUhLFsVyfR0agXJXRtIFy7QdfHLf6KHjgOf
   Q0nEq+nRPbobqgXSKY6k31aaKDdEYF+4g3GlXG+4Q0E0a4GJMrUcXEuaK
   YIl8CLLnJbfJtI1myb2B63MIESqNq+kHviRrqbCHlvRGeOKlBTmqnpAbq
   c/Wjem6qCM6w6HAbG7/MWR5eqKGmWk3uMWGt42cAXOLd+865NsEjPutCq
   g==;
X-CSE-ConnectionGUID: fGXt7pqKQnG3Z1D9fpV/rQ==
X-CSE-MsgGUID: Ngdx/Pr4TlOKvosoAR0KQA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8904724"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="8904724"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 15:23:30 -0700
X-CSE-ConnectionGUID: 18yM3tACRva6LkE+8aUm3A==
X-CSE-MsgGUID: YXErAy5LTPSGv9KOPZ32Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22816927"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 16 Apr 2024 15:23:18 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: jarkko@kernel.org, dave.hansen@linux.intel.com, kai.huang@intel.com,
 tj@kernel.org, mkoutny@suse.com, linux-kernel@vger.kernel.org,
 linux-sgx@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 sohil.mehta@intel.com, tim.c.chen@linux.intel.com, "Haitao Huang"
 <haitao.huang@linux.intel.com>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v12 05/14] x86/sgx: Implement basic EPC misc cgroup
 functionality
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-6-haitao.huang@linux.intel.com>
Date: Tue, 16 Apr 2024 17:23:14 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2mcds0jkwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <20240416032011.58578-6-haitao.huang@linux.intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Mon, 15 Apr 2024 22:20:02 -0500, Haitao Huang  
<haitao.huang@linux.intel.com> wrote:

> diff --git a/arch/x86/kernel/cpu/sgx/Makefile  
> b/arch/x86/kernel/cpu/sgx/Makefile
> index 9c1656779b2a..400baa7cfb69 100644
> --- a/arch/x86/kernel/cpu/sgx/Makefile
> +++ b/arch/x86/kernel/cpu/sgx/Makefile
> @@ -1,6 +1,7 @@
>  obj-y += \
>  	driver.o \
>  	encl.o \
> +	epc_cgroup.o \

It should be:

+obj-$(CONFIG_CGROUP_MISC)   += epc_cgroup.o

Haitao


