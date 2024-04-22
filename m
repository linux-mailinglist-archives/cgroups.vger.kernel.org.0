Return-Path: <cgroups+bounces-2653-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C37D8AD4F8
	for <lists+cgroups@lfdr.de>; Mon, 22 Apr 2024 21:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7801C2155A
	for <lists+cgroups@lfdr.de>; Mon, 22 Apr 2024 19:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249FC155343;
	Mon, 22 Apr 2024 19:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDVPB+RK"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AFF155337;
	Mon, 22 Apr 2024 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814733; cv=none; b=s2FJOkOUH5XwrTPN5Of8vAMUMaeX26rU8ylSh+ZBEGxp3egLuwpSkM6aIZz87tqooeNgNsDxKDgEtqo3WuWmlXWZQelhB4t46hXPcQzot6o6Y5AXnT4LXm2pMS8YPnHBcxYwckxA4um4a2ufMXeqHFJIL6i0eFuDPIoHWPFR3QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814733; c=relaxed/simple;
	bh=2GRFl6WMleWf91SC8vfssaS1Has6aTi33GaASl85sXM=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=lLjpIshkB6AJdBKcMx+fpTp1MjErdM9eyauzKJtGakhQOY15erAacQKw3a9Y6gf7HTJ2LqTNR5maAUTILIqkmrUwpEzJD7+arAvWCXV1bLmlez3s5kVMyR6v2oBYKUgoZm0TU9+YnZprqQ9lRvQDuiCzNkjfnWjmRJm4iQG0AkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IDVPB+RK; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713814732; x=1745350732;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=2GRFl6WMleWf91SC8vfssaS1Has6aTi33GaASl85sXM=;
  b=IDVPB+RKVn8/241gQnuf2TCERhjYgKPdRBaCvI9XOSw1PQcLD/sbH0TO
   PAvigSPFlvDRslMT3kj/PWxVloPxDjhfKPmm/4Gpw5nwbsubvv+eZum6i
   d/t2YzWuFUHX1zySJ55npCJ7EOyXVm7M0SEUNctmnrI1BwKVRDcGnYQ4+
   iKJZ1pdXi0bkQ3B9+lnny0MJXB9Py/PryxUX8Pjrb87X6yY/n65y/oAsV
   2PFQGDwnpAEAFuy3LJiwved7dkisS/FxsPk85j8nWAolrb1jkwpGAAS81
   cZb8HD+lgWb8pPJWn6LNlDFDFq5AvNPr1vuhCTCgqqUNomGECG4nUJUhX
   Q==;
X-CSE-ConnectionGUID: lRyTJZY5QD6/8WWnjjKHmg==
X-CSE-MsgGUID: dWQeUNsXRo+qhYjDe5dESQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="31862685"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="31862685"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 12:38:51 -0700
X-CSE-ConnectionGUID: wxQAfcSZQH6z1pluyFm5Xw==
X-CSE-MsgGUID: LUyg5N3USu2ioIEx+8xN4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="28777816"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.125.85.20])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 22 Apr 2024 12:38:49 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: dave.hansen@linux.intel.com, kai.huang@intel.com, tj@kernel.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
 x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, sohil.mehta@intel.com,
 tim.c.chen@linux.intel.com, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v11 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
References: <20240410182558.41467-1-haitao.huang@linux.intel.com>
 <20240410182558.41467-15-haitao.huang@linux.intel.com>
 <D0JXP8HZLEQZ.3PHVXZI140VIH@kernel.org>
 <op.2l81wdjdwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <D0KXLFE83H9V.3GNOZNN4II125@kernel.org>
Date: Mon, 22 Apr 2024 14:38:46 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2mm96wwswjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <D0KXLFE83H9V.3GNOZNN4II125@kernel.org>
User-Agent: Opera Mail/1.0 (Win32)

Hi Jarkko

On Mon, 15 Apr 2024 14:08:44 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> I did run the basic test by manually creating the cgroup so you could
> add tested-by from my side to the other kernel patches expect this one
>
> I've reviewed it enough rounds and given various code suggestions etc.
> For me it is "good enough" or has been for a while. I just want this
> test to work so that people doing kernel QA will automatically get it
> to their testing cycle. That is why proper integration to kselftest
> framework is a must

May I have your "Reviewed-by" tag also for the patches #8-13?

Not sure if I missed any other comments/issue you raised. I think all are  
addressed in v12. I will refine the test scripts (patch #14) in v13.

Thanks
Haitao

