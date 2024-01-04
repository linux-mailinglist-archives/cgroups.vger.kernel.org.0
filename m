Return-Path: <cgroups+bounces-1083-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610178249F4
	for <lists+cgroups@lfdr.de>; Thu,  4 Jan 2024 22:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B581F21B4E
	for <lists+cgroups@lfdr.de>; Thu,  4 Jan 2024 21:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F152128E0D;
	Thu,  4 Jan 2024 21:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gv0a367Q"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414CD2C860;
	Thu,  4 Jan 2024 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704402124; x=1735938124;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=jNkbhszzShPbArPxx0L05m7z25QEwrp4u/6skEB2hTk=;
  b=Gv0a367Qp1IWVeihxWrbKGOoUtniuMwOkajAvtpXUlF7C65xwRq7n4nm
   eqYcNXSSXZJVnkvJBQizHK3PZr24isxyE9lgSvYyNwuVapVvSeyxdPQ12
   4OJ4RxpJh1uYhGWyxcEQZBfEo0YVEFmOysLfHo0WkIr2vYBrNaDE1Okm0
   QTQ00UuD2Cpy03mN7lVkUVBMSnBWekP+h92aPHxHElEgNpLo91oGsFE5O
   65Wn0Er/xWBFLOnXkH0FFNE6W0goc09F9QTEubZ6A/1ykKGtu00/WOpAq
   0Wz5r6RXzg/LQ76vFE7Q56jvk3GkkS52xTwLOd1tBeAXTy7WdA+L/LkN9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="376847776"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="376847776"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 13:02:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="1027567628"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="1027567628"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 04 Jan 2024 13:02:00 -0800
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "jarkko@kernel.org"
 <jarkko@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "hpa@zytor.com"
 <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "tj@kernel.org"
 <tj@kernel.org>, "mkoutny@suse.com" <mkoutny@suse.com>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bp@alien8.de"
 <bp@alien8.de>, "Huang, Kai" <kai.huang@intel.com>, "Dave Hansen"
 <dave.hansen@intel.com>
Cc: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "Zhang, Bo" <zhanb@microsoft.com>,
 "kristen@linux.intel.com" <kristen@linux.intel.com>, "anakrish@microsoft.com"
 <anakrish@microsoft.com>, "sean.j.christopherson@intel.com"
 <sean.j.christopherson@intel.com>, "Li, Zhiquan1" <zhiquan1.li@intel.com>,
 "yangjie@microsoft.com" <yangjie@microsoft.com>
Subject: Re: [PATCH v6 09/12] x86/sgx: Restructure top-level EPC reclaim
 function
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-10-haitao.huang@linux.intel.com>
 <c8fc40dc56b853fbff14ba22db197c80a6d31820.camel@intel.com>
 <op.2e0yod2lwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <431c5d7f5aee7d11ec2e8aa2e526fde438fa53b4.camel@intel.com>
 <op.2ftmyampwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <3c27bca678c1b041920a14a7da0d958c9861ebca.camel@intel.com>
 <op.2f0eo8r1wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <73ed579be8ad81835df1c309b7c69b491b7f2c8e.camel@intel.com>
 <op.2f523elowjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <4b28fc01-50cf-469b-8161-7d56b863b42b@intel.com>
 <op.2g1d81fqwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <2aee5f75-836e-4a47-a29c-b272150227a8@intel.com>
Date: Thu, 04 Jan 2024 15:01:59 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: Quoted-Printable
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2g1jdlojwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <2aee5f75-836e-4a47-a29c-b272150227a8@intel.com>
User-Agent: Opera Mail/1.0 (Win32)

On Thu, 04 Jan 2024 13:27:07 -0600, Dave Hansen <dave.hansen@intel.com> =
 =

wrote:

> On 1/4/24 11:11, Haitao Huang wrote:
>> If those are OK with users and also make it acceptable for merge
>> quickly, I'm happy to do that =F0=9F=99=82
>
> How about we put some actual numbers behind this?  How much complexity=

> are we talking about here?  What's the diffstat for the utterly
> bare-bones implementation and what does it cost on top of that to do t=
he
> per-cgroup reclaim?
>

For bare-bone:

  arch/x86/Kconfig                     |  13 ++++++++++++
  arch/x86/kernel/cpu/sgx/Makefile     |   1 +
  arch/x86/kernel/cpu/sgx/epc_cgroup.c | 104  =

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++
  arch/x86/kernel/cpu/sgx/epc_cgroup.h |  39  =

+++++++++++++++++++++++++++++++++++
  arch/x86/kernel/cpu/sgx/main.c       |  41  =

++++++++++++++++++++++++++++++++++++
  arch/x86/kernel/cpu/sgx/sgx.h        |   5 +++++
  include/linux/misc_cgroup.h          |  42  =

+++++++++++++++++++++++++++++++++++++
  kernel/cgroup/misc.c                 |  52  =

+++++++++++++++++++++++++++++++---------------
  8 files changed, 281 insertions(+), 16 deletions(-)

Additional for per-cgroup reclaim:

  arch/x86/kernel/cpu/sgx/encl.c       |  41 +++++++++--------
  arch/x86/kernel/cpu/sgx/encl.h       |   3 +-
  arch/x86/kernel/cpu/sgx/epc_cgroup.c | 224  =

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++--
  arch/x86/kernel/cpu/sgx/epc_cgroup.h |  18 ++++++--
  arch/x86/kernel/cpu/sgx/main.c       | 226  =

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------=
--------------------
  arch/x86/kernel/cpu/sgx/sgx.h        |  85  =

+++++++++++++++++++++++++++++++++--
  6 files changed, 480 insertions(+), 117 deletions(-)


Thanks
Haitao

