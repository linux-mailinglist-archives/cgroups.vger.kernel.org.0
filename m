Return-Path: <cgroups+bounces-2509-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1E58A62EA
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 07:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D0B284B5D
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 05:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546A839AFD;
	Tue, 16 Apr 2024 05:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IkdYmYYi"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD60622F14;
	Tue, 16 Apr 2024 05:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713244609; cv=none; b=AOJC9hwBCCIuNfUsnDNy9XpzTX+6FxdJyKoDzC3pPZ4qRcCzlH9OBeFLyWeOv86qe2xrFhpMbVEACqsrFlU52WPKTqc1MisyYP3himif7siI0CVeg7OE3MwdYG1R4aca3DDSsIoVoqj/ZziUkbbFT+uiAlpZtpj1ND4I7b+fTps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713244609; c=relaxed/simple;
	bh=jBy2IewRT35w0O16kw4HewqwsLV3SmbRvdNFWu+EpLI=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=BGpb4Ubq6zw7AMyGF49mVIjAUZHD+3V/5nHF9e/8Sr1d9FbHz53sEVpRkwcbnBJsM/IGFeD6eKOBqRkj0k8KjpooRU6stIVqu++2Ive1VV7AGYEIpbNb0fFm2TCiUR1Mny/8pQDzImNG0/rNVUjQCebdHI0idgVsQpg06kZB3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IkdYmYYi; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713244608; x=1744780608;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=jBy2IewRT35w0O16kw4HewqwsLV3SmbRvdNFWu+EpLI=;
  b=IkdYmYYi4rKyeYr7mBftrw/ZqBVU7XKG8c6GarVHs0qKI7wbiPg//sAJ
   3RAIsFXK88KdENS8qBfFOIJY1pVbnzDYoZc1tlgxM/FkBKNTZobAtEYsD
   BzWb2zGyWoyNMsm1HTd1xjOAfmGKr/laIQhRbrOC+I8h0YJuiASn8gN5R
   95I3D/fltSLJWPaszK2irJ72GjgDZLmXiKPqt4jz+nTq27U33MXr4daYf
   zd8ez1r8YFr00OrtTUSGJjUs4aO4A6xJ82N9V5C1tqWWVNkpoPOnoNKxl
   sm4rI96G5/IAcULWNjlX/unRkMfPRybkW6UFeTCukcu+XbqoOgAZ3Q35+
   w==;
X-CSE-ConnectionGUID: vk/UG/Q2RR6tHj/3Y5oZuA==
X-CSE-MsgGUID: iklVpIiyRYa9/NxIWU4MhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="19371125"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="19371125"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 22:16:47 -0700
X-CSE-ConnectionGUID: 3CF2FJ2aRjGB19ZOf7EivA==
X-CSE-MsgGUID: kQjCeKBwQNqqdCzYAwZLhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22216952"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 15 Apr 2024 22:16:44 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: jarkko@kernel.org, dave.hansen@linux.intel.com, kai.huang@intel.com,
 tj@kernel.org, mkoutny@suse.com, linux-kernel@vger.kernel.org,
 linux-sgx@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 sohil.mehta@intel.com, tim.c.chen@linux.intel.com, "Haitao Huang"
 <haitao.huang@linux.intel.com>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v12 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
References: <20240416032011.58578-1-haitao.huang@linux.intel.com>
 <20240416032011.58578-15-haitao.huang@linux.intel.com>
Date: Tue, 16 Apr 2024 00:16:43 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2ma195shwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <20240416032011.58578-15-haitao.huang@linux.intel.com>
User-Agent: Opera Mail/1.0 (Win32)


Missed adding the config file:

index 000000000000..e7f1db1d3eff
--- /dev/null
+++ b/tools/testing/selftests/sgx/config
@@ -0,0 +1,4 @@
+CONFIG_CGROUPS=y
+CONFIG_CGROUP_MISC=y
+CONFIG_MEMCG=y
+CONFIG_X86_SGX=y

I'll send a fixup for this patch or another version of the series if more  
changes are needed.

Thanks
Haitao

