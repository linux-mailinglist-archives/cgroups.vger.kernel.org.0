Return-Path: <cgroups+bounces-1238-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC4883DE88
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 17:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDFA1C21797
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 16:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F76F1D54C;
	Fri, 26 Jan 2024 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E85DPW04"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3433A1869;
	Fri, 26 Jan 2024 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286091; cv=none; b=ke/HyvOH5L5gUYHkulXmiq2WxqloO+4cU7eRKwpKbdxPmsN0KtLxpeF7SyzJV36E/pjhvpTr+RnDgbYPd1T6eewiPXjgcJicakXxpf5fzACuFLZ8W8b040H26xNSIXDQoq7DBoXaCajah0zYTwQ5tP9F3nd+3DHXots9bik+jw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286091; c=relaxed/simple;
	bh=qADy1ppHLODrkpaiBhX12RYbvSDcazYVsUJT8jx33Cg=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=NM05dWjxd4uVqEWFiWyHuauhRkEe9557oAWyQM/JFYw0RZgspEyQNp6nHCEh+MYVsrbZnHU3Y6zwkUH/B55d5701ITQ/WJ1zON7PPJhaPYZZha3OPGfVPJ5tujaZHrjY8kbFPp7bhKCF13zNTuvc5LqGnAoBEpt8RNvGGXbxSc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E85DPW04; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706286090; x=1737822090;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=qADy1ppHLODrkpaiBhX12RYbvSDcazYVsUJT8jx33Cg=;
  b=E85DPW04VnbFN3dcBqFdJuz4rTChKdl44hw9MK/poVgt15CZ6zffeQ5+
   kz68KSAozXYrxOh4J4GSKOYk5Y3P8Kbwcyv6ALIreNk80PVqgvrBGPGi7
   5c59d5f6hCljNtrYJ3t6kh1Kspt+86x1nEpY/c9ZbVdnZnQ+igbGsyhnH
   kSkdVu/BEYFsRWTxKTpDqlP/QOR/UWNEfO2qwmtQo5ZPkFE8/9c1Zsr6c
   I0A/Y0qBEREEVtxoLAWiv7eCulAncw8gaiBJD5mJZS7D43pZdW2buHZo1
   Mg1v/iY5ey5TV5jPwldTOznABQK797WAt+YTXfKla9NcCb97hA/fJW1Dg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9884190"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9884190"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 08:21:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="857438086"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="857438086"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 26 Jan 2024 08:21:25 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "hpa@zytor.com" <hpa@zytor.com>, "linux-sgx@vger.kernel.org"
 <linux-sgx@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "jarkko@kernel.org" <jarkko@kernel.org>, "cgroups@vger.kernel.org"
 <cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "Mehta, Sohil"
 <sohil.mehta@intel.com>, "tj@kernel.org" <tj@kernel.org>, "mingo@redhat.com"
 <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "Huang, Kai"
 <kai.huang@intel.com>
Cc: "kristen@linux.intel.com" <kristen@linux.intel.com>,
 "yangjie@microsoft.com" <yangjie@microsoft.com>, "Li, Zhiquan1"
 <zhiquan1.li@intel.com>, "seanjc@google.com" <seanjc@google.com>,
 "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>, "Zhang, Bo"
 <zhanb@microsoft.com>, "anakrish@microsoft.com" <anakrish@microsoft.com>
Subject: Re: [PATCH v7 09/15] x86/sgx: Charge mem_cgroup for per-cgroup
 reclamation
References: <20240122172048.11953-1-haitao.huang@linux.intel.com>
 <20240122172048.11953-10-haitao.huang@linux.intel.com>
 <195eff7f2814b918a570b8c2c9e21288ac9df4b7.camel@intel.com>
Date: Fri, 26 Jan 2024 10:21:22 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2h5w1w0awjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <195eff7f2814b918a570b8c2c9e21288ac9df4b7.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Fri, 26 Jan 2024 08:37:25 -0600, Huang, Kai <kai.huang@intel.com> wrote:

>
>>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Reported-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>
>> ---
>
> Non-technical staff:
>
> I believe checkpatch requires you to have a "Closes" tag after  
> "Reported-by"
> otherwise it complains something like this:
>
>   WARNING: Reported-by: should be immediately followed by Closes: with a  
> URL
>   to the report
>
> Not sure how strict this rule is, but seems you forgot to run checkpatch  
> so just
> a reminder.

Yeah I did remember run checkpatch this time and last time :-)
Here is what I see from documentation[1]:"The tag should be followed by a  
Closes: tag pointing to the report, unless the report is not available on  
the web". So it seems to allow exceptions.
Mikko mentioned this issue to me in private IM so this is not available on  
web.

Thanks
Haitao

https://docs.kernel.org/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

