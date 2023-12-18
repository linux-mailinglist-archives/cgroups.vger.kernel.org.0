Return-Path: <cgroups+bounces-976-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC648178C7
	for <lists+cgroups@lfdr.de>; Mon, 18 Dec 2023 18:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C248B1C24E3C
	for <lists+cgroups@lfdr.de>; Mon, 18 Dec 2023 17:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4795A878;
	Mon, 18 Dec 2023 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GfPGXu6b"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB426498B7;
	Mon, 18 Dec 2023 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702920769; x=1734456769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4oSlzXrGumApmOxCKuJUTQ+F3TdnkbybnKrRfJmNmwA=;
  b=GfPGXu6bt/eJs8Au2xoP3j3Gnh4bp+ORKxUgG6eKGdX6AXgcDr3yFgul
   GULYGwAEX59zueZLz+PE3WZ9QAuQydnWdFnjrzlBEpceapWVq672iCwxb
   ITOXyaVPqn/0nYXkzW6EIlZCQ2bpqpBlRE8ELIHBIetvPeSCtDJmBinwT
   L9OvXtXRY8GfTjh0/80N7wBhGQUZ7Ln2m4GwCqhceXLjvZUBwAGgsNKD8
   1Tw3EhK3/+tkzG/UIeIEHEEmyVJl5t85RPVIMroxFHRRwJhVlOmilDNTk
   0MENoy5afAKYXrTEneDbj8YZLcN85D8/Ws1oBRTpurDEqq3HAvkZrczGq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="8909211"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="8909211"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 09:32:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="751829307"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="751829307"
Received: from tvonhert-mobl1.ger.corp.intel.com (HELO himmelriiki) ([10.252.33.220])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 09:32:14 -0800
Date: Mon, 18 Dec 2023 19:32:05 +0200
From: Mikko Ylinen <mikko.ylinen@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "Mehta, Sohil" <sohil.mehta@intel.com>,
	"jarkko@kernel.org" <jarkko@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"tj@kernel.org" <tj@kernel.org>,
	"mkoutny@suse.com" <mkoutny@suse.com>,
	"haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"seanjc@google.com" <seanjc@google.com>,
	"Zhang, Bo" <zhanb@microsoft.com>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>,
	"anakrish@microsoft.com" <anakrish@microsoft.com>,
	"sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
	"Li, Zhiquan1" <zhiquan1.li@intel.com>,
	"yangjie@microsoft.com" <yangjie@microsoft.com>
Subject: Re: [PATCH v6 09/12] x86/sgx: Restructure top-level EPC reclaim
 function
Message-ID: <ZYCCFXZiMpaaYPKv@himmelriiki>
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-10-haitao.huang@linux.intel.com>
 <c8fc40dc56b853fbff14ba22db197c80a6d31820.camel@intel.com>
 <op.2e0yod2lwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <431c5d7f5aee7d11ec2e8aa2e526fde438fa53b4.camel@intel.com>
 <op.2ftmyampwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <3c27bca678c1b041920a14a7da0d958c9861ebca.camel@intel.com>
 <op.2f0eo8r1wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <73ed579be8ad81835df1c309b7c69b491b7f2c8e.camel@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73ed579be8ad81835df1c309b7c69b491b7f2c8e.camel@intel.com>

On Mon, Dec 18, 2023 at 01:44:56AM +0000, Huang, Kai wrote:
> 
> Let's focus on enabling functionality first.  When you have some real
> performance issue that is related to this, we can come back then.
> 
> Btw, I think you need to step back even further.  IIUC the whole multiple LRU
> thing isn't mandatory in this initial support.
> 
> Please (again) take a look at the comments from Dave and Michal:
> 
> https://lore.kernel.org/lkml/7a1a5125-9da2-47b6-ba0f-cf24d84df16b@intel.com/#t
> https://lore.kernel.org/lkml/yz44wukoic3syy6s4fcrngagurkjhe2hzka6kvxbajdtro3fwu@zd2ilht7wcw3/

I don't think setting a hard limit without any reclaiming is preferred.

I'd rather see this similar to what the "sgx_epc.high" was in the RFC
patchset: misc.max for sgx_epc becomes the max value for EPC usage but
enclaves larger than the limit would still run OK. Per-cgroup reclaiming
allows additional controls via memory.high/max in the same cgroup.

If this reclaim flexibily was not there, the sgx_epc limit would always
have to be set based on some "peak" EPC consumption which may not even
be known at the time the limit is set.

From a container runtime perspective (which is what I'm working for Kubernetes)
the current proposal seems best to me: a container is guaranteed at most
the amount of EPC set as the limit and no other container gets to use it.
Also, each container gets charged for reclaiming independently if a low
max value is used (which might be desirable to get more containers to run on the
same node/system). In this model, the sum of containers' max values would be
the capacity.

-- Mikko

