Return-Path: <cgroups+bounces-2432-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F8989FFD1
	for <lists+cgroups@lfdr.de>; Wed, 10 Apr 2024 20:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215AB1C25A3B
	for <lists+cgroups@lfdr.de>; Wed, 10 Apr 2024 18:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE62180A76;
	Wed, 10 Apr 2024 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GgK8ySu+"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A731802BC;
	Wed, 10 Apr 2024 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712773692; cv=none; b=oAIlpUoxZm+jTlMjBv36jm53ZaZRJ5UCl8p3AQ5NokynIq14jHNhSrX7NEVljQCCOHJEsRzMrDiHfPrGWbjU1NIrDsP35+bntrgxksTuHxTkDYYJwX9loHNWCP0ECddurMvLyx2sUxqly0KF7JwVN/rZBr8IUk32j78yKDewJvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712773692; c=relaxed/simple;
	bh=UZ42VS9dtADlg2+VEy0SyUfnbOwQEK+dXac4rGfc8xg=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=BwCp5vdMLnXQAaDGzK9jp8PozT5U///Xtiza6/CFbHfFhB5RJWejuuGUan4ESfnISgkZx0ODDtYg3s4hJQjd7dWWBXL3B8d28Xb3m63wCgrDnz1x/k+wLN9vF/0jgIDKQ6XhUetRqLD35OMefHlj12DPLuoK0bBK/mOGjJtXmHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GgK8ySu+; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712773691; x=1744309691;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=UZ42VS9dtADlg2+VEy0SyUfnbOwQEK+dXac4rGfc8xg=;
  b=GgK8ySu+LmK/AZndZkqBPgI3jjofqrk+Z6V/SxgFMtQhHpk8Sk1W/zAX
   BLLEJHC+yeKLxh2WRpjNSTi73+UimWzIlJHs+MG2am41tJaADX18rXrFW
   Hulp7k62CBHxkJXvSCFy/37ky3wbZZ2K8g9CNEBQLFQ3UhtNSEblsKq3O
   lD7MsPTBnQcWdnNz0hnp2XodZA/o03zE7BSgpWnUgPLqrJ2XqdvPFb85C
   2xfBJVLz8Pcr78mWJQZIGOuiecMeruynspPIiLPbjYJ5fC4hde7GEbl5S
   Pv6dLiA8c9fvdiLdcgH9vMLVUFoYHnm+ZpL5n9843i1nAIB1nYBPsOF0M
   w==;
X-CSE-ConnectionGUID: e7AW/aTUQ1K2nBtc9bVW3Q==
X-CSE-MsgGUID: xKrdm88KSMO/9Tli1OxfgQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18869346"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="18869346"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 11:28:10 -0700
X-CSE-ConnectionGUID: x+/R/9nSQg6TSrvNc6m2cw==
X-CSE-MsgGUID: zStVy4rMR+S1RH81HMv71g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="20682448"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 10 Apr 2024 11:28:07 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: =?iso-8859-15?Q?Michal_Koutn=FD?= <mkoutny@suse.com>, "Haitao Huang"
 <haitao.huang@linux.intel.com>
Cc: "hpa@zytor.com" <hpa@zytor.com>, "tim.c.chen@linux.intel.com"
 <tim.c.chen@linux.intel.com>, "linux-sgx@vger.kernel.org"
 <linux-sgx@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "jarkko@kernel.org" <jarkko@kernel.org>, "cgroups@vger.kernel.org"
 <cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "Mehta, Sohil" <sohil.mehta@intel.com>, "tj@kernel.org" <tj@kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "Huang,
 Kai" <kai.huang@intel.com>, "mikko.ylinen@linux.intel.com"
 <mikko.ylinen@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
 "anakrish@microsoft.com" <anakrish@microsoft.com>, "Zhang, Bo"
 <zhanb@microsoft.com>, "kristen@linux.intel.com" <kristen@linux.intel.com>,
 "yangjie@microsoft.com" <yangjie@microsoft.com>, "Li, Zhiquan1"
 <zhiquan1.li@intel.com>, "chrisyan@microsoft.com" <chrisyan@microsoft.com>
Subject: Re: Re: [PATCH v10 12/14] x86/sgx: Turn on per-cgroup EPC reclamation
References: <20240328002229.30264-1-haitao.huang@linux.intel.com>
 <20240328002229.30264-13-haitao.huang@linux.intel.com>
 <d25dbe76d48a0b6c74fa09b06f1ca3fdf234a190.camel@intel.com>
 <op.2lw8gfg2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <7a21c0de-ba59-4e76-8d67-70957f9db581@intel.com>
 <op.2lx047lrwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <imqjuxgmm5updfnl75molzixlq52ttlufd6sn2vpcevaby5l7f@22j23whlbvux>
 <op.2lyv641jwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Date: Wed, 10 Apr 2024 13:28:06 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: Quoted-Printable
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2l0yw4vnwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2lyv641jwjvjmi@hhuan26-mobl.amr.corp.intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Tue, 09 Apr 2024 10:34:06 -0500, Haitao Huang  =

<haitao.huang@linux.intel.com> wrote:

> On Tue, 09 Apr 2024 04:03:22 -0500, Michal Koutn=FD <mkoutny@suse.com>=
  =

> wrote:
>
>> On Mon, Apr 08, 2024 at 11:23:21PM -0500, Haitao Huang  =

>> <haitao.huang@linux.intel.com> wrote:
>>> It's always non-NULL based on testing.
>>>
>>> It's hard for me to say definitely by reading the code. But IIUC
>>> cgroup_disable command-line only blocks operations in /sys/fs/cgroup=
  =

>>> so user
>>> space can't set up controllers and config limits, etc., for the  =

>>> diasabled
>>> ones. Each task->cgroups would still have a non-NULL pointer to the =
 =

>>> static
>>> root object for each cgroup that is enabled by KConfig, so
>>> get_current_misc_cg() thus  sgx_get_current_cg() should not return N=
ULL
>>> regardless 'cgroup_disable=3Dmisc'.
>>>
>>> Maybe @Michal or @tj can confirm?
>>
>> The current implementation creates root css object (see cgroup_init()=
,
>> cgroup_ssid_enabled() check is after cgroup_init_subsys()).
>> I.e. it will look like all tasks are members of root cgroup wrt given=

>> controller permanently and controller attribute files won't exist.
>>
>> (It is up to the controller implementation to do further optimization=

>> based on the boot-time disablement (e.g. see uses of
>> mem_cgroup_disabled()). Not sure if this is useful for misc controlle=
r.)
>>
>> As for the WARN_ON(1), taking example from memcg -- NULL is best
>> synonymous with root. It's a judgement call which of the values to st=
ore
>> and when to intepret it.
>>
>> HTH,
>> Michal
> Thanks for the info.
>
> The way I see it, misc does not have special handling like memcg so  =

> every task at least belong to the root(default) group even if it's  =

> disabled by command line parameter. So we would not get NULL from  =

> get_current_misc_cg(). I think I'll keep the WARN_ON_ONCE for now as a=
  =

> reminder in case misc do have custom support for disabling in future.
>
Actually I think it makes more sense just add some comments instead of  =

WARN.
That's what I did in v11 now.

Thanks
Haitao

