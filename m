Return-Path: <cgroups+bounces-2265-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C51B89477A
	for <lists+cgroups@lfdr.de>; Tue,  2 Apr 2024 00:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA472833C9
	for <lists+cgroups@lfdr.de>; Mon,  1 Apr 2024 22:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC64456473;
	Mon,  1 Apr 2024 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A34oIFey"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BDA33982;
	Mon,  1 Apr 2024 22:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712012110; cv=none; b=leP6AQYPq/TPbDgmGaiJL1Aaiya+hK0xDTGsoMUJ62SYlFT/gEvEv4w/2pDAANQAcbFk2Xgmf8CEz5kyMgCmORMH2CRjbaGxrk4Tr79nFFnAJ4er81iVz7k/E/v7c9WQf25BmnJA79dWz8LhHcXT9W0eHlQ/viFoESDCaq5PCvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712012110; c=relaxed/simple;
	bh=30gWJyaHRF80+3efAwmOoPWr9DWWUI7WAK4YaLcCZOc=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=X1uhAzzBpZXNqFMZ9oCTJFNFJF6dujSNMWCEc1fuC4uwvXZMKCxQy0+xgAGKaJKsH4a2pjt+wUKSEgzoRQ5M9+6GgN6GoruYF/k0Y+QCHAKDcr8MleYVPTGl5O1m8WJIxFyg/4QLapbSHWOt+B/mXYqw3dv1Z0JpJJpt7j99OOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A34oIFey; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712012109; x=1743548109;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=30gWJyaHRF80+3efAwmOoPWr9DWWUI7WAK4YaLcCZOc=;
  b=A34oIFeyZyz1OurneqWBAsyCjROWBzwO+9F7mhd+8F1U0Gu5wuQwLixV
   uxbcdxUZ1+vN3oiLIXBz8si5gK0fKhpu/NUPGzZnUogTl7ub0Tns6liEw
   hZCx5Dw7HvEY75f77VZ9sKynBwYJrGXjdVABCVlfC6Zako6JBCs/bRD/F
   Jaf+GI65ofsf0CGLY/+TeZgBUq/xl0CtA0Xt06KX8+hBRBreFMVwwAEvz
   Bp28JuUGiZpX5+7equuiID4LcxRpK6fhP0VKB2tOlo/AtD33KHccZeXHd
   Gv+CXIqHiWm6VCXrFfDRx+aMjW6WEhgH7IUMB8V/n3XtavyGBxJ9TJZDn
   w==;
X-CSE-ConnectionGUID: JEayBrwWQjavic3XzCdT8g==
X-CSE-MsgGUID: letfgcqiT0aLQUntDZf+QQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7058405"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="7058405"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 15:55:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="18321991"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 01 Apr 2024 15:55:06 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: anakrish@microsoft.com, bp@alien8.de, cgroups@vger.kernel.org,
 chrisyan@microsoft.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 kai.huang@intel.com, kristen@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-sgx@vger.kernel.org, mikko.ylinen@linux.intel.com, mingo@redhat.com,
 mkoutny@suse.com, seanjc@google.com, sohil.mehta@intel.com,
 tglx@linutronix.de, tim.c.chen@linux.intel.com, tj@kernel.org, x86@kernel.org,
 yangjie@microsoft.com, zhanb@microsoft.com, zhiquan1.li@intel.com
Subject: Re: [PATCH] selftests/sgx: Improve cgroup test scripts
References: <D071SWVSOJLN.2C9H7NTS4PHGI@kernel.org>
 <20240331174442.51019-1-haitao.huang@linux.intel.com>
 <D08UQJ2XQY6L.1XEOEJ6HIUJ8Y@kernel.org>
Date: Mon, 01 Apr 2024 17:55:02 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2lkm90y3wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <D08UQJ2XQY6L.1XEOEJ6HIUJ8Y@kernel.org>
User-Agent: Opera Mail/1.0 (Win32)

On Mon, 01 Apr 2024 09:22:21 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Sun Mar 31, 2024 at 8:44 PM EEST, Haitao Huang wrote:
>> Make cgroup test scripts ash compatible.
>> Remove cg-tools dependency.
>> Add documentation for functions.
>>
>> Tested with busybox on Ubuntu.
>>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>
> I'll run this next week on good old NUC7. Thank you.
>
> I really wish that either (hopefully both) Intel or AMD would bring up
> for developers home use meant platform to develop on TDX and SNP. It is
> a shame that the latest and greatest is from 2018.
>
> BR, Jarkko
>

Argh, missed a few changes for v2 cgroup:

--- a/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
+++ b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
@@ -15,6 +15,8 @@ CG_MEM_ROOT=/sys/fs/cgroup
  CG_V1=0
  if [ ! -d "/sys/fs/cgroup/misc" ]; then
      echo "# cgroup V2 is in use."
+    echo "+misc" >  $CG_MISC_ROOT/cgroup.subtree_control
+    echo "+memory" > $CG_MEM_ROOT/cgroup.subtree_control
  else
      echo "# cgroup V1 is in use."
      CG_MISC_ROOT=/sys/fs/cgroup/misc
@@ -26,6 +28,11 @@ mkdir -p $CG_MISC_ROOT/$TEST_CG_SUB2
  mkdir -p $CG_MISC_ROOT/$TEST_CG_SUB3
  mkdir -p $CG_MISC_ROOT/$TEST_CG_SUB4

+if [ $CG_V1 -eq 0 ]; then
+echo "+misc" >  $CG_MISC_ROOT/$TEST_ROOT_CG/cgroup.subtree_control
+echo "+misc" >  $CG_MISC_ROOT/$TEST_CG_SUB1/cgroup.subtree_control
+fi

