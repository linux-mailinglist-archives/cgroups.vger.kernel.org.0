Return-Path: <cgroups+bounces-2548-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 063558A776E
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 00:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282D31C20BE2
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 22:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160226EB5B;
	Tue, 16 Apr 2024 22:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fo6VLwwE"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D43317736;
	Tue, 16 Apr 2024 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305079; cv=none; b=QxgnBnMDEwYJBrLzv/OhvtnC6lRcsjgFo9uIdC6t3Nuxps5p2Z/MDt5yHCXmchBW0MBOPxgYTaCXfGSnXPZkJeDBl2VfberAK4akEEJCAJEysI3MwWQzaEMerIBDbB18w7YLkZPP9fZzkYvs2KLFyrVwMpU0ELKMQxSlFLGBueI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305079; c=relaxed/simple;
	bh=GT4TAO+AcnC+KrR6ZpTHekrlkH55bFRukihzryTd7Q8=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=GpvVgNfstKdQeVvZZi954Ri3waiCAOSvPlZiQxepz5ya/MDqQWKy7b4lpIr2txEQPv+1LQbGbvN5G3nlOAK7avO/fmlu8j2qFg9y8krFpzwXdeC2++bW/Uzz8UB+HVNy/JfhVHPwCYBk1BhXOnlA56uuLFh96ol8u8APZujviHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fo6VLwwE; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713305078; x=1744841078;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=GT4TAO+AcnC+KrR6ZpTHekrlkH55bFRukihzryTd7Q8=;
  b=Fo6VLwwExl+4KCdZ7tANPtXVXWd7GR+VGuJGZemL+tObHEG0HwDvpYd/
   roZ9jgm/kXV+El7k2k6r7tKi1OLCLUQF4Xb9dEe0oafPohSdsazIl14T3
   0UgbbAKSskpmrrImIq3//ZU++GEXZqrkd5sbvYJjiIB2k+r345LjJyvF8
   pg0idLsNH0LNbkPdogXYAWor2LT1+HDO9Ks96tuZtMzaYjjQSYAxshgtV
   EN2rPv7l4S6eBxxrIsTndr9IxHWLrngFKTPBO3B8PAbJIbt+DgmHA9e59
   KxTrKJL47/0/+ilayqH1ay3Qr7TdYVHRVpU0pa7Jgr/qa1eofvPbPyPfG
   w==;
X-CSE-ConnectionGUID: 8xHqRt38RouW/aFjtzFWPw==
X-CSE-MsgGUID: MeGHkAQzQTmJBNW7H5Ta4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12555940"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="12555940"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 15:04:37 -0700
X-CSE-ConnectionGUID: XVbumuTmSQyXej/LtzOGgg==
X-CSE-MsgGUID: oQb40XoFRc+SlFx7cfoCwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22814229"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 16 Apr 2024 15:04:26 -0700
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
Date: Tue, 16 Apr 2024 17:04:21 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2mccxje2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <D0LODQCRSTRA.2KSPCDB0FLK0X@kernel.org>
User-Agent: Opera Mail/1.0 (Win32)

On Tue, 16 Apr 2024 11:08:11 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Tue Apr 16, 2024 at 5:54 PM EEST, Haitao Huang wrote:
>> I did declare the configs in the config file but I missed it in my patch
>> as stated earlier. IIUC, that would not cause this error though.
>>
>> Maybe I should exit with the skip code if no CGROUP_MISC (no more
>> CGROUP_SGX_EPC) is configured?
>
> OK, so I wanted to do a distro kernel test here, and used the default
> OpenSUSE kernel config. I need to check if it has CGROUP_MISC set.
>
>> tools/testing/selftests$ find . -name README
>> ./futex/README
>> ./tc-testing/README
>> ./net/forwarding/README
>> ./powerpc/nx-gzip/README
>> ./ftrace/README
>> ./arm64/signal/README
>> ./arm64/fp/README
>> ./arm64/README
>> ./zram/README
>> ./livepatch/README
>> ./resctrl/README
>
> So is there a README because of override timeout parameter? Maybe it
> should be just set to a high enough value?
>
> BR, Jarkko
>


 From the docs, I think we are supposed to use override.
See: https://docs.kernel.org/dev-tools/kselftest.html#timeout-for-selftests

Thanks
Haitao

