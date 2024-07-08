Return-Path: <cgroups+bounces-3563-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6005692A17D
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 13:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C108282D8B
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E067E782;
	Mon,  8 Jul 2024 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpM29nd7"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8E37C081;
	Mon,  8 Jul 2024 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439334; cv=none; b=EO9QYmM9IHW+zJrHRpAka9p1ehdUt2NKC5Jclx9X0BoTqmwvTHGASteg+2fGYAKmzzaFJq/DnGcFa/PkwN9YKaDBn2Ncb3+j/j3MD/A64bPAZamfuk4r7VMUP79DlYzJyybUbkBdpOyu8NypQo+cmAWVaYFp5bOFaXA6RN7q/3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439334; c=relaxed/simple;
	bh=aS0g16LlmzLraDi70hLNiR0Upx3Nm/PgrSsD8O55+6g=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=GZ1WWxol95gNWLVbKIrzhUinweriSDulIwhftxF9Fb80E+vSJaMg0ZHEumdE/i1vckllEID5dxG8Iti3UyoqRp2Lc/54dajK0coQ2c/r0wadVpTCE4a6TbnnZNJ+c42KEP3yJUGqI0ahQtgDKVQhRsH3jhgfNpxZisSnxKbCZCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpM29nd7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720439333; x=1751975333;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=aS0g16LlmzLraDi70hLNiR0Upx3Nm/PgrSsD8O55+6g=;
  b=kpM29nd7JY84iSogDdXuUk6eRUtnrdFUbQGQEbVxuzwqpbPYO+FNFWOh
   A6Jvo1/qa7yTxxMdjzBDfEOsgH8v+d4zKOIymdxlERnb6FI2eUL4+IZx8
   sz5sc5fTSw3x6+aJ+nCTkqR4rDBXg1KhvkqpV/hYkivRwiiknIbCmsk/1
   SrwKKvHsUGIfm8R1UpNfVqJbf5xhzBkyXVkDmyIVGrPDjnoyyhglXRtIv
   WmHJfkCyjqXN0dJGq3252feDSeedGLaGWEgbfLp5I0R5zBtaaKhIK4VzT
   vqf3kl9YcZj7IaRoiCRUbPGHI88sEps/tHXJQR1DV/HNTGkJeKhE3j1hO
   g==;
X-CSE-ConnectionGUID: b2GEv2xQSOOM18TU/FlEUw==
X-CSE-MsgGUID: E6hW8TUbSxuqJkGl5IHjZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="28242067"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="28242067"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 04:48:52 -0700
X-CSE-ConnectionGUID: C1CYfNmxQCSddArW/f0+uQ==
X-CSE-MsgGUID: hSjjsO+8TOKCW6pXb2WBXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="52680457"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.246.119.97])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 08 Jul 2024 04:48:50 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
 corbet@lwn.net, kamalesh.babulal@oracle.com, "Xiu Jianfeng"
 <xiujianfeng@huawei.com>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 -next] cgroup/misc: Introduce misc.peak
References: <20240703003646.2762150-1-xiujianfeng@huawei.com>
Date: Mon, 08 Jul 2024 06:48:48 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2qk9rmcawjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <20240703003646.2762150-1-xiujianfeng@huawei.com>
User-Agent: Opera Mail/1.0 (Win32)

On Tue, 02 Jul 2024 19:36:46 -0500, Xiu Jianfeng <xiujianfeng@huawei.com>  
wrote:

> Introduce misc.peak to record the historical maximum usage of the
> resource, as in some scenarios the value of misc.max could be
> adjusted based on the peak usage of the resource.
>
Acked-by: haitao.huang@linux.intel.com
BTW, from SGX point of view, I think it also makes sense to show peak  
usage in the root group.
Thanks
Haitao

