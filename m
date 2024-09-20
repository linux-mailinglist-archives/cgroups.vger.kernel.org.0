Return-Path: <cgroups+bounces-4911-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFA197D1AF
	for <lists+cgroups@lfdr.de>; Fri, 20 Sep 2024 09:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4EC1F22A0E
	for <lists+cgroups@lfdr.de>; Fri, 20 Sep 2024 07:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CFF537FF;
	Fri, 20 Sep 2024 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IxpUOPVi"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B5546434;
	Fri, 20 Sep 2024 07:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726817074; cv=none; b=mHFL2yTvL84gFY/yT0Z4zQhRNO4JykAeHXz8sABD8hX0yBYE8GoKDebXvDLrzA+wDr8ujtNzsUwm2J61EWruOUt6hhmsq+coe9gDVdmHHzZLLY+c8WkXDiL828BaLg3c5PVSHSEohF3z/uSHj2RZ1pPHD0ihgkscZdkbJm0sax8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726817074; c=relaxed/simple;
	bh=REvvcaAYyuM2BvpPPxLPeps+t9nJzfzbmuPK3q+hSec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2G5bixRvgU0morXZECdm1yWlYadHQMRWqH6vLJeekOdbHwA2chHVFTWQNCHHC5kn5uXCVLjFUiS8FKrbcFQP8PFiBK2GO5zaJXX2JXvMKxZqcu6IUI4ym8J9mG9Y7241LtZMxlkmzrvTsyh9btdUE0MrK1e8zriuOnbbQJjybo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IxpUOPVi; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726817072; x=1758353072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=REvvcaAYyuM2BvpPPxLPeps+t9nJzfzbmuPK3q+hSec=;
  b=IxpUOPViSWwLo9LnMlA341WDGvsZyAibaiK5N7hzQHV5m/3c8z6Zst7u
   8FTobswP9gB2cmZRaxh9HtltK3R8dMpb2OvvD7joovMZoOiExRDfZMNxB
   XkJ4pzd6yWCjpEuacoMVwqw2ICrrrgt/NQZ2kV7jw8V/2Uc44WaU0qEck
   CkmPGpbbeC31c0ngaPmm26Hgs5KNlnUdbiF069+vhxYTdcXyXlm7FCMMm
   b/v83eIYFWUE3RgJdPLF+/ggqK2qEAtngQKhmeoJk4/AUGz78YCkPMy/p
   jmAjtheU+MV9CCeJ1BulsUM0tJgwxbf31Knydx20e+QMpWl//seQ4jMSX
   g==;
X-CSE-ConnectionGUID: MyAtZocdSJ2JbNuGNu1nqw==
X-CSE-MsgGUID: EqObz4CMQ/OJ05Bo+lShrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="13604624"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="13604624"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 00:24:31 -0700
X-CSE-ConnectionGUID: Qvb0hn/LQny34bMalp97hQ==
X-CSE-MsgGUID: EGxUXX3rQ66Q9nSgST0fOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="70515708"
Received: from alexta1x-mobl.ger.corp.intel.com (HELO desk) ([10.125.147.201])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 00:24:31 -0700
Date: Fri, 20 Sep 2024 00:24:23 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Waiman Long <longman@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Kaplan <David.Kaplan@amd.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] x86/entry_64: Add a separate unmitigated
 entry/exit path
Message-ID: <20240920072423.65uekxy3a6ueqxyy@desk>
References: <20240919-selective-mitigation-v1-0-1846cf41895e@linux.intel.com>
 <20240919-selective-mitigation-v1-1-1846cf41895e@linux.intel.com>
 <0402bea4-bb0a-4d67-9ae2-f534a6076861@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0402bea4-bb0a-4d67-9ae2-f534a6076861@redhat.com>

On Fri, Sep 20, 2024 at 02:57:34AM -0400, Waiman Long wrote:
> 
> On 9/19/24 17:52, Pawan Gupta wrote:
> > CPU mitigations are deployed system-wide, but usually not all of the
> > userspace is malicious. Yet, they suffer from the performance impact
> > of the mitigations. This all or nothing approach is due to lack of a
> > way for kernel to know which userspace can be trusted and which cannot.
> > 
> > For scenarios where an admin can decide which processes to trust, an
> > interface to tell the kernel to possibly skip the mitigation would be
> > useful.
> > 
> > In preparation for kernel to be able to selectively apply mitigation
> > per-process add a separate kernel entry/exit path that skips the
> > mitigations.
> > 
> > Originally-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> 
> For the current patch, not all x86 CPU vulnerability mitigations can be
> disabled. Maybe we should list the subset of mitigations that can be
> disabled.

Yes, will update that mitigations that can be bypassed are BHI, VERW,
Retbleed-IBRS, Retbleed-unret and IBPB.

Meltdown, Spectre-v1, eIBRS, GDS, SRBDS, retpoline and rethunk stays
enabled.

