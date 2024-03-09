Return-Path: <cgroups+bounces-2023-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 782FA877400
	for <lists+cgroups@lfdr.de>; Sat,  9 Mar 2024 22:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE52282ABE
	for <lists+cgroups@lfdr.de>; Sat,  9 Mar 2024 21:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A4D4F894;
	Sat,  9 Mar 2024 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EB+VOcDl"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAE64AEE8;
	Sat,  9 Mar 2024 21:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710018652; cv=none; b=ZGtzZK+Lxo7qPSQ2ge/TEDGVyTp1s2rhc0L3bQ5XOo8F1w+IVUu6Eku6L8gVq6FRx0DC8JNUowFCglaEUkx8MRTpWbCjmKBM22QhembCP1pCHFazOJrveuuq8qxWS2aoGsRZezr3N7RJK6MUp1UcA46MwkrWxMxg3q7xDOy3iJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710018652; c=relaxed/simple;
	bh=Rl7tD8xxzur5fGawhrLhrE5uAeLD7c995cPg+u795XM=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=afADBVGLXI+7tPYxqGtfGg3HYyANeooXO/rXLRmc+gfiCM+Zy1eK06ZwdSFksZdfhFurM5tIrVwCLGm2sSrWVXYGmPvKzVrGZJfO18j9p3eg/G4baJJ8ZUc6E0Rv4dmRqc/WM1eihdeRik2iWBVA39g2HPQ5sWxzt6Sxcl5SjkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EB+VOcDl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710018651; x=1741554651;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=Rl7tD8xxzur5fGawhrLhrE5uAeLD7c995cPg+u795XM=;
  b=EB+VOcDldo4hFjbBn4xV1XdKU3Rzn+84+B6jXe91Y/DOUKBPij4HHrVn
   9XgUZaeJWrxQymzScqfxsgA/v4K9LLyn23vS5Gsu7pNOtCpGUuy1EpRNo
   U1ILElCOHG7pnQ/n2HEJgeemmO3q/tmtMQlAr9TV8PSQcbBFHZWQWbXM0
   GAqFxzkVmQifgmtxM2O9F8A7LzFAV91Ji9SCq0gKihpo1m17uzYdIGPrM
   gAYnUTtcYLZ6NivK9MwthUO/XfoDU/ObbonzRXhoSm6oey0mk9vKFcr54
   mthR1hLSY1aZ7S1hL9XkiG4qbiAd4I6aZNM09IuuMjWSw1pvy3x6GJmjh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="4900907"
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="4900907"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 13:10:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="11215621"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 09 Mar 2024 13:10:47 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: =?iso-8859-15?Q?Michal_Koutn=FD?= <mkoutny@suse.com>, "Haitao Huang"
 <haitao.huang@linux.intel.com>
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
 <op.2jtkxougwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Date: Sat, 09 Mar 2024 15:10:44 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: Quoted-Printable
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2kdw36otwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2jtkxougwjvjmi@hhuan26-mobl.amr.corp.intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Tue, 27 Feb 2024 15:35:38 -0600, Haitao Huang  =

<haitao.huang@linux.intel.com> wrote:

> On Mon, 26 Feb 2024 12:25:58 -0600, Michal Koutn=FD <mkoutny@suse.com>=
  =

> wrote:
>
>> On Mon, Feb 05, 2024 at 01:06:27PM -0800, Haitao Huang  =

>> <haitao.huang@linux.intel.com> wrote:
>>> +static int sgx_epc_cgroup_alloc(struct misc_cg *cg);
>>> +
>>> +const struct misc_res_ops sgx_epc_cgroup_ops =3D {
>>> +	.alloc =3D sgx_epc_cgroup_alloc,
>>> +	.free =3D sgx_epc_cgroup_free,
>>> +};
>>> +
>>> +static void sgx_epc_misc_init(struct misc_cg *cg, struct  =

>>> sgx_epc_cgroup *epc_cg)
>>> +{
>>> +	cg->res[MISC_CG_RES_SGX_EPC].priv =3D epc_cg;
>>> +	epc_cg->cg =3D cg;
>>> +}
>>
>> This is a possibly a nit pick but I share it here for consideration.
>>
>> Would it be more prudent to have the signature like
>>   alloc(struct misc_res *res, struct misc_cg *cg)
>> so that implementations are free of the assumption of how cg and res =
are
>> stored?
>>
>>
>> Thanks,
>> Michal
>
> Will do.
>
> Thanks
> Haitao
>
Actually, because the root node is initialized in sgx_cgroup_init(), whi=
ch  =

only has access to misc_cg_root() so we can't pass a misc_res struct  =

without knowing cg->res relationship. We could hide it with a getter, bu=
t  =

I think it's a little overkill at the moment. I can sign up for adding  =

this improvement if we feel it needed in future.

Thanks
Haitao

