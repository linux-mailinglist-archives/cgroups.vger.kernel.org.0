Return-Path: <cgroups+bounces-1102-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B390825DB7
	for <lists+cgroups@lfdr.de>; Sat,  6 Jan 2024 02:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D333284BA0
	for <lists+cgroups@lfdr.de>; Sat,  6 Jan 2024 01:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45241381;
	Sat,  6 Jan 2024 01:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VI7q91wf"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21464137C;
	Sat,  6 Jan 2024 01:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704505345; x=1736041345;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=bMoRKMaHUhGWhQFkewu39nHY6z+TvlhmsJ2tDh2e0gE=;
  b=VI7q91wf8GsCuUibEnk5UCk352Hm4O1I9XivHEvcb7pmdNTi897NF8QJ
   OU0YgljcqNULSrI/dbKqDZnlJnzQpxK/SynhpXeYE/hD0wcqF2YN0vEnQ
   FkTVuE+iRCNw4be7eJh8q1Ol7R+ccfR3C9+JQvw36MkqAuGNDiy1w6rjU
   taMI0IMnFKrxG89AyWBx9miYeMjMwzeBwuhzr8qPlMaXtTP1yMScuNzoQ
   wrpSf7BHtdDdTTiiI9OCVlMKskvdJSqRSMP0CGojlILLia1Z+S8CP0JoD
   +FpDtNFCcajFiEmY11CLsqOKcSKWXx+5TugDR/DrZWdAmlkA8G3cdYhBz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="396509714"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="396509714"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 17:42:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="899805470"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="899805470"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 05 Jan 2024 17:42:22 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: =?iso-8859-15?Q?Michal_Koutn=FD?= <mkoutny@suse.com>
Cc: jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
 linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org, x86@kernel.org,
 cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, sohil.mehta@intel.com, zhiquan1.li@intel.com,
 kristen@linux.intel.com, seanjc@google.com, zhanb@microsoft.com,
 anakrish@microsoft.com, mikko.ylinen@linux.intel.com, yangjie@microsoft.com
Subject: Re: [PATCH v6 01/12] cgroup/misc: Add per resource callbacks for CSS
 events
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-2-haitao.huang@linux.intel.com>
 <5qfjx2vvirtffkro5u6zdbbwia2bhhbjxwgij2igdnxk5hysaq@kpqboajvuzbc>
Date: Fri, 05 Jan 2024 19:42:21 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: Quoted-Printable
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2g3q0ve0wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <5qfjx2vvirtffkro5u6zdbbwia2bhhbjxwgij2igdnxk5hysaq@kpqboajvuzbc>
User-Agent: Opera Mail/1.0 (Win32)

On Fri, 05 Jan 2024 03:45:02 -0600, Michal Koutn=FD <mkoutny@suse.com> w=
rote:

> On Mon, Oct 30, 2023 at 11:20:02AM -0700, Haitao Huang  =

> <haitao.huang@linux.intel.com> wrote:
>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>>
>> The misc cgroup controller (subsystem) currently does not perform
>> resource type specific action for Cgroups Subsystem State (CSS) event=
s:
>> the 'css_alloc' event when a cgroup is created and the 'css_free' eve=
nt
>> when a cgroup is destroyed.
>>
>> Define callbacks for those events and allow resource providers to
>> register the callbacks per resource type as needed. This will be
>> utilized later by the EPC misc cgroup support implemented in the SGX
>> driver.
>
> I notice now that the callbacks are per resource and per cgroup.
> I think that is an overkill that complicates misc_cg allocation code
> with parent's callbacks while freeing is done by own callbacks.
> It's possibly too much liberal to keep objects' lifecycle understandab=
le
> in the long term too.
>
> For some uniformity, I'd suggest struct blkcg_policy array in
> block/blk-cgroup.c as the precedent. (Perhaps indexed with static enum=

> misc_res_type instead of dynamic index assignment as
> blkcg_policy_registeer() does.)
>
> I hope you don't really need per-cgroup callbacks :-)
>
> Michal

Sure I can do that. IIUC, you are suggesting something similar how  =

capacity is set via misc_cg_set_capacity for each resource type. Here we=
  =

make a misc_cg_set_ops() which stores the ops pointers in a static array=
,  =

then use them indexed with the resource type.

Thanks
Haitao

