Return-Path: <cgroups+bounces-1887-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E2386A1C3
	for <lists+cgroups@lfdr.de>; Tue, 27 Feb 2024 22:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A1C1F22AE0
	for <lists+cgroups@lfdr.de>; Tue, 27 Feb 2024 21:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B03614EFED;
	Tue, 27 Feb 2024 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="naYL5/wK"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA2914C593;
	Tue, 27 Feb 2024 21:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709069755; cv=none; b=Jhq3GasqMEj7sS+p2OuXhD5lKaarnCpLDqPmKTOWdkeEVpC4S8l0DJwNHIhbSRoH1nfzITPGLbpD43JjzPlSTj1D4YiC3A3bz/X9pU7lj5d7p5jcXUgSr0VhlUUbym+x44fZvp8oocHrke2/BZ5CPZQv6J1TwZHr+pavnqJ1hUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709069755; c=relaxed/simple;
	bh=3KypCAxJS3Tqg2q5+LI4MfZmK0r5vprErdy8tQBgUdI=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=JMmS+g+q1oSvuJuyGmiBikMxq0rzmHHowRNwjNp19TUdPeAbIV44vndkXRy2kltUmmLQZ4aTb49svdw54Dt3emuR1OnzIVm5yXLQM926YOZttr5fdTF7JpVnlUkIHVQG4ljWYXPBCpfkEhV6YXy1Ci9Xq7oJmzUoDXrYgurg10k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=naYL5/wK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709069754; x=1740605754;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=3KypCAxJS3Tqg2q5+LI4MfZmK0r5vprErdy8tQBgUdI=;
  b=naYL5/wKNfFujApE63Eh0RMoUnxhz0kKGoJYJ+QgpotHLc41xeqs02bJ
   rauNI22C/QAt+Nnt3I8IuY+MHHLHMj1xMffCO3b1C9cG+iGx4uhmmibjR
   ohYseImqYF/VbelYmiVdQAFXV+vfoG0bzSmM2sNkSvyzXeYXwkiHTzBrt
   ONl1la1LljFvrfYmhKkc97ggZIaVKFCDAnCDhEDlp3MjyR+QL8dZlzVhG
   NAwd9Ii5BYiMzQLfmeD2otQmgNqzPPDfWJ/Q8z30msm0i7xCXnsUZ0dje
   Cwel7ZP4ZtL27hg0anSz0or0wcwMsehSrl9lXHWn7p5sLdX/DXLyQ1+Km
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3599961"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="3599961"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 13:35:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="7160006"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.122.136.251])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 27 Feb 2024 13:35:39 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: =?iso-8859-15?Q?Michal_Koutn=FD?= <mkoutny@suse.com>
Cc: jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
 linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org, x86@kernel.org,
 cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, sohil.mehta@intel.com, tim.c.chen@linux.intel.com,
 zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v9 04/15] x86/sgx: Implement basic EPC misc cgroup
 functionality
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-5-haitao.huang@linux.intel.com>
 <7u3intene6yvlkuks5bix3tx27wog3da6ki5w2l5flaod5mjrq@flgmfdd4fbei>
Date: Tue, 27 Feb 2024 15:35:38 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: Quoted-Printable
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2jtkxougwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <7u3intene6yvlkuks5bix3tx27wog3da6ki5w2l5flaod5mjrq@flgmfdd4fbei>
User-Agent: Opera Mail/1.0 (Win32)

On Mon, 26 Feb 2024 12:25:58 -0600, Michal Koutn=FD <mkoutny@suse.com> w=
rote:

> On Mon, Feb 05, 2024 at 01:06:27PM -0800, Haitao Huang  =

> <haitao.huang@linux.intel.com> wrote:
>> +static int sgx_epc_cgroup_alloc(struct misc_cg *cg);
>> +
>> +const struct misc_res_ops sgx_epc_cgroup_ops =3D {
>> +	.alloc =3D sgx_epc_cgroup_alloc,
>> +	.free =3D sgx_epc_cgroup_free,
>> +};
>> +
>> +static void sgx_epc_misc_init(struct misc_cg *cg, struct  =

>> sgx_epc_cgroup *epc_cg)
>> +{
>> +	cg->res[MISC_CG_RES_SGX_EPC].priv =3D epc_cg;
>> +	epc_cg->cg =3D cg;
>> +}
>
> This is a possibly a nit pick but I share it here for consideration.
>
> Would it be more prudent to have the signature like
>   alloc(struct misc_res *res, struct misc_cg *cg)
> so that implementations are free of the assumption of how cg and res a=
re
> stored?
>
>
> Thanks,
> Michal

Will do.

Thanks
Haitao

