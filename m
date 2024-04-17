Return-Path: <cgroups+bounces-2558-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39C58A7AD6
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 05:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3397E282654
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 03:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFED747F;
	Wed, 17 Apr 2024 03:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpDJc3M/"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67980BA34;
	Wed, 17 Apr 2024 03:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713323112; cv=none; b=NGpqLbH6u2jJI0rTQ+6f3TRErtCrkEZfGRzmD/a8QmTQbfwPZSc+hpa5earPTc5x8lEtm9V6SMhRcFTtQZrDmjvL9JJ/AEc965EEYV2BiJ9HYo3vPp5oOSZzp6KqEVqwy6KoVC9nexqTVagDNCClwR74rV1HpG6E29IA86YkdYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713323112; c=relaxed/simple;
	bh=yNo/sEA9+IPA4jpZcFTeBPhClg9Mb+1/htRUayTG1QQ=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=Vhv83EirYcShXmqTmQhcHsDSnXuDylqgj4fRwMfrSEWx5Uzh2GfifGax07YdTcDmXCxkZsbf63ysvxUHtJVaAtBuahWb8wR1QtdU1UzwxFtCez9K0YpxKMMq2sAu8HGQxA2PSl8KCdkJ9XPBoFKB8Vf3VSu95puqTqcsKJrHSCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpDJc3M/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713323111; x=1744859111;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=yNo/sEA9+IPA4jpZcFTeBPhClg9Mb+1/htRUayTG1QQ=;
  b=lpDJc3M/1WThnoa8d1F46HGUhNkQL8H57ynYg4773oRWAtngeRyWDP0m
   sQihAk2T5oEZjBfbRXbgyG+N/Yg17zZx88VRkry0PMEzw1h2VG/SP8fI8
   iYjzbSXxbMw7aiLZbSs1F3sXXUpmSoi394YKtkZWzJ7c/Oc+xBxnJ+9cX
   nuzTmqaNNg/ZDtNlApbnKp3ro/Wkz+NHPIdmfeFhpPU6EDmncDVuwLStJ
   egFh0QntfoJ0c+KdBMNGQ8v4XkGXpl1XGU5KJpWvMuUYw3myCXPOC1tVh
   xGbvq9cWH9NTY3f41YwyGAW4jOSOCH0HG9l5Q6f76ZxdDNM9ZV+l5Y15O
   Q==;
X-CSE-ConnectionGUID: s4AfbYZlRiacGbgzr883DQ==
X-CSE-MsgGUID: n1bq0bIfQayY7yqHaANYzQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8720968"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="8720968"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 20:05:10 -0700
X-CSE-ConnectionGUID: zBmECAoyTxiWV7ddm8dO6g==
X-CSE-MsgGUID: 3qvoq9GzREubbuuFXyWiTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="22549765"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 16 Apr 2024 20:05:07 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: dave.hansen@linux.intel.com, kai.huang@intel.com, tj@kernel.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
 x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, sohil.mehta@intel.com,
 tim.c.chen@linux.intel.com, "Jarkko Sakkinen" <jarkko@kernel.org>, "Haitao
 Huang" <haitao.huang@linux.intel.com>
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
 <op.2mccxje2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <op.2mcdpygvwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Date: Tue, 16 Apr 2024 22:05:05 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2mcqursuwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2mcdpygvwjvjmi@hhuan26-mobl.amr.corp.intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Tue, 16 Apr 2024 17:21:24 -0500, Haitao Huang  
<haitao.huang@linux.intel.com> wrote:

> On Tue, 16 Apr 2024 17:04:21 -0500, Haitao Huang  
> <haitao.huang@linux.intel.com> wrote:
>
>> On Tue, 16 Apr 2024 11:08:11 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
>> wrote:
>>
>>> On Tue Apr 16, 2024 at 5:54 PM EEST, Haitao Huang wrote:
>>>> I did declare the configs in the config file but I missed it in my  
>>>> patch
>>>> as stated earlier. IIUC, that would not cause this error though.
>>>>
>>>> Maybe I should exit with the skip code if no CGROUP_MISC (no more
>>>> CGROUP_SGX_EPC) is configured?
>>>
>>> OK, so I wanted to do a distro kernel test here, and used the default
>>> OpenSUSE kernel config. I need to check if it has CGROUP_MISC set.
>>>
>>>> tools/testing/selftests$ find . -name README
>>>> ./futex/README
>>>> ./tc-testing/README
>>>> ./net/forwarding/README
>>>> ./powerpc/nx-gzip/README
>>>> ./ftrace/README
>>>> ./arm64/signal/README
>>>> ./arm64/fp/README
>>>> ./arm64/README
>>>> ./zram/README
>>>> ./livepatch/README
>>>> ./resctrl/README
>>>
>>> So is there a README because of override timeout parameter? Maybe it
>>> should be just set to a high enough value?
>>>
>>> BR, Jarkko
>>>
>>
>>
>>  From the docs, I think we are supposed to use override.
>> See:  
>> https://docs.kernel.org/dev-tools/kselftest.html#timeout-for-selftests
>>
>> Thanks
>> Haitao
>>
>
> Maybe you are suggesting we add settings file? I can do that.
> README also explains what the tests do though. Do you still think they  
> should not exist?
> I was mostly following resctrl as example.
>
> Thanks
> Haitao
>

With the settings I shortened the README quite bit. Now I also lean  
towards removing it. Let me know your preference. You can check the latest  
at my branch for reference:
https://github.com/haitaohuang/linux/tree/sgx_cg_upstream_v12_plus

Thanks
Haitao

