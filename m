Return-Path: <cgroups+bounces-2386-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 885DE89DFFC
	for <lists+cgroups@lfdr.de>; Tue,  9 Apr 2024 18:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7505B30443
	for <lists+cgroups@lfdr.de>; Tue,  9 Apr 2024 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882F413AD20;
	Tue,  9 Apr 2024 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QpPZDmJ+"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DE5132810;
	Tue,  9 Apr 2024 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676853; cv=none; b=HDjcxDxtH5lKVvOwtKWuTlwK6vYIaU3lUeiqVMqMk1NEo752XA54bNT7Xrd+0KGYNH1tyk/ATAxRy8x9+UNe6S9tbmS2Tt8Z66glMmgj9MPaLFEbCwKnec9Ww1yWIJ237HHHJV/CC8G/SOi0SDo5nDMiRaInD8VgGGV6bePQTCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676853; c=relaxed/simple;
	bh=SKP9bud4MroCBJFTuzACnKofp1hr8bEO55fdp0WdI7I=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=Mf/YhMB8rw5uDd42nJCrIm6c8NZFdYpqCgJc0Wl2/56OMvT3jZsuyQk9qyp+Fd/a4Wo+bVH5Iruhvno3rgh6kiVRp9x6AzFspjHppoS8uKRhmZ20ps0xhSZcCTbgY63VTKsl5/Pb/QCDq5UZjcgz1cbumFSalP0tYwYBGIxegHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QpPZDmJ+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712676852; x=1744212852;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=SKP9bud4MroCBJFTuzACnKofp1hr8bEO55fdp0WdI7I=;
  b=QpPZDmJ+2iHrF2m7AC60tJ57RH2Azrt2HGJmMFfY3qSj2/hye9GlsdOh
   elYBE89EhbQtcCM9dbgA+4rx0TmG1uxOMJYAftk9xgqGTV3u2dt84IrQ9
   f46K6H+bl50j/hTwJFlKE9kTjfA6jB/lYhukHaVmALM24YrkkKjUoH+nm
   GcYY7k8FhGjzp5HrMxXKoOSRvyuMOrQYBz7wbPMi316Up/NXxHyujMWEs
   T6kSrqG5basrePOweBNCmynhnXm8XPXcn1MSrboYl0wXSR0rdZLuZ4brH
   kkRgY/d5HX+zf8jIXYGp1stfgwIwwgFLJg0cHUOea7BCE49lrEiYTJWP/
   Q==;
X-CSE-ConnectionGUID: OlydURoZRdGYVBIhIvI0wQ==
X-CSE-MsgGUID: oJa2alEISTCJUpYhtEz0sA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11838557"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="11838557"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 08:34:11 -0700
X-CSE-ConnectionGUID: TkSTvptyR4GiFWtkEhaNzg==
X-CSE-MsgGUID: M0JWISEzQiCBC9uUvH2QfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="20347653"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 09 Apr 2024 08:34:08 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: =?iso-8859-15?Q?Michal_Koutn=FD?= <mkoutny@suse.com>
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
Date: Tue, 09 Apr 2024 10:34:06 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: Quoted-Printable
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2lyv641jwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <imqjuxgmm5updfnl75molzixlq52ttlufd6sn2vpcevaby5l7f@22j23whlbvux>
User-Agent: Opera Mail/1.0 (Win32)

On Tue, 09 Apr 2024 04:03:22 -0500, Michal Koutn=FD <mkoutny@suse.com> w=
rote:

> On Mon, Apr 08, 2024 at 11:23:21PM -0500, Haitao Huang  =

> <haitao.huang@linux.intel.com> wrote:
>> It's always non-NULL based on testing.
>>
>> It's hard for me to say definitely by reading the code. But IIUC
>> cgroup_disable command-line only blocks operations in /sys/fs/cgroup =
so  =

>> user
>> space can't set up controllers and config limits, etc., for the  =

>> diasabled
>> ones. Each task->cgroups would still have a non-NULL pointer to the  =

>> static
>> root object for each cgroup that is enabled by KConfig, so
>> get_current_misc_cg() thus  sgx_get_current_cg() should not return NU=
LL
>> regardless 'cgroup_disable=3Dmisc'.
>>
>> Maybe @Michal or @tj can confirm?
>
> The current implementation creates root css object (see cgroup_init(),=

> cgroup_ssid_enabled() check is after cgroup_init_subsys()).
> I.e. it will look like all tasks are members of root cgroup wrt given
> controller permanently and controller attribute files won't exist.
>
> (It is up to the controller implementation to do further optimization
> based on the boot-time disablement (e.g. see uses of
> mem_cgroup_disabled()). Not sure if this is useful for misc controller=
.)
>
> As for the WARN_ON(1), taking example from memcg -- NULL is best
> synonymous with root. It's a judgement call which of the values to sto=
re
> and when to intepret it.
>
> HTH,
> Michal
Thanks for the info.

The way I see it, misc does not have special handling like memcg so ever=
y  =

task at least belong to the root(default) group even if it's disabled by=
  =

command line parameter. So we would not get NULL from  =

get_current_misc_cg(). I think I'll keep the WARN_ON_ONCE for now as a  =

reminder in case misc do have custom support for disabling in future.

Thanks
Haitao

