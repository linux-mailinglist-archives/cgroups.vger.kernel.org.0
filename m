Return-Path: <cgroups+bounces-2378-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AB489D179
	for <lists+cgroups@lfdr.de>; Tue,  9 Apr 2024 06:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 969CFB24DBA
	for <lists+cgroups@lfdr.de>; Tue,  9 Apr 2024 04:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8F056465;
	Tue,  9 Apr 2024 04:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nTI9L8cB"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2296683CB0;
	Tue,  9 Apr 2024 04:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712636607; cv=none; b=TSOLWTfiXD9hnooT8YOKObw3vueDkId/1CQCksv3h42fJWEK58WzFY81k0d3i667KpuI3s3I5+d6iYyIZ9oeF98O5ge3O9EYgYPWyLKGGDns/uHQl3kPucwpdm+ooQK+Nxz1gZ/lCYUkF8DMFZcj9McR8m7t+GoI1wIMDHXKyX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712636607; c=relaxed/simple;
	bh=SuQSgPe8CBiuq2s/IXE0JGCrExX0FOBruorD6DKwhDI=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=VVfDvZPXTbd3GlqPq1NhBm4H4+c2emf+sQGcgrwzpqBqgfaZR5xiqqwzqZqKHgHDo1W0eHK354foyTHlG3hP0jpsv9GwEkd6C888o0G/3q03JAWYf9NPAovbviz+DWXyr2PMG08QbAxC4+NQsVDly8ruAs4kw9V+zvcbq/3Farg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nTI9L8cB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712636606; x=1744172606;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=SuQSgPe8CBiuq2s/IXE0JGCrExX0FOBruorD6DKwhDI=;
  b=nTI9L8cBUe4UZYDCljqedY/9k5z4cQNHJ3Hi1bouyyOjMT8aZto0tXLr
   vgnVPkpcfMf90M0StmFh/c8xdwZ/54bUs6QSNcJaeRD3kZuzPUIHBnIzu
   FxNSVfsL12baT7GjsLGS7HhZAF3vwlw98pY0aUNpyZr9l8test982VJ2A
   cR9GY6a1wpezTAna7wjvWMc/Qx9fAyFujL5AJbmB2sdEREUGVgwkKgOKc
   9Ui8ZDxOKr5j3vmRbC1SAiJ+RoPq/1+FiUIFsOCs17IEitnha0p9/vpz6
   bGxa0EOTU7ZOeaVIla0YdDzgL5BdGVS1mTdVpjFj1GnEs27X3ofvwY6IV
   A==;
X-CSE-ConnectionGUID: nXg57YKOS6ek8UbTXoy9zg==
X-CSE-MsgGUID: E+CCpb21TfeHwyDazU9tyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="33344738"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="33344738"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 21:23:25 -0700
X-CSE-ConnectionGUID: OqeZOLAWSVm4WyyvVODuHw==
X-CSE-MsgGUID: eIudRArYTrG75Ijrlc2gPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="20182985"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 08 Apr 2024 21:23:23 -0700
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
Subject: Re: [PATCH v10 12/14] x86/sgx: Turn on per-cgroup EPC reclamation
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
 <20240328002229.30264-13-haitao.huang@linux.intel.com>
 <d25dbe76d48a0b6c74fa09b06f1ca3fdf234a190.camel@intel.com>
 <op.2lw8gfg2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <7a21c0de-ba59-4e76-8d67-70957f9db581@intel.com>
Date: Mon, 08 Apr 2024 23:23:21 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2lx047lrwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <7a21c0de-ba59-4e76-8d67-70957f9db581@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Mon, 08 Apr 2024 17:37:10 -0500, Huang, Kai <kai.huang@intel.com> wrote:

>
>
> On 9/04/2024 6:03 am, Haitao Huang wrote:
>>>>
>>  The misc root cgroup is a static similar to sgx_cg_root. So  
>> misc_cg_root()  won't be NULL
>> However, based on how css_misc() was check NULL, I suppose  
>> sgx_get_current_cg() may be NULL when cgroup is disabled (again not  
>> 100% sure but we handle it anyway)
>
> Could you help to check?  Sorry I am busy on something else thus won't  
> be able to do any actual check.
>
It's always non-NULL based on testing.

It's hard for me to say definitely by reading the code. But IIUC  
cgroup_disable command-line only blocks operations in /sys/fs/cgroup so  
user space can't set up controllers and config limits, etc., for the  
diasabled ones. Each task->cgroups would still have a non-NULL pointer to  
the static root object for each cgroup that is enabled by KConfig, so  
get_current_misc_cg() thus  sgx_get_current_cg() should not return NULL  
regardless 'cgroup_disable=misc'.

Maybe @Michal or @tj can confirm?

Thanks
Haitao


