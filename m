Return-Path: <cgroups+bounces-3114-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2E68FE757
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2024 15:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3669B1F216B2
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2024 13:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C194195FC6;
	Thu,  6 Jun 2024 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QYRItamH"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817B513C826;
	Thu,  6 Jun 2024 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679600; cv=none; b=ToTFVnmYsmaSdSz18HajVgG0V7amGxSsKl+FX3XxGw57Z8mW0qZxmLxDl86IxbpDd2XDM35e3thzNX1pgsIsdcMKDjr8ypS9Orjz2diu4Q4Y/1WkNU3LDV0lOPaXR9DcYQXAzOPagh+zlhnH01/HZF5ZPcNrR1xHOG+F4tNxb7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679600; c=relaxed/simple;
	bh=nESjAB4tx2zRd+29Q+AUJBF7z0+xj30Zl54hm7wQYqM=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=dNiIfZ+LDZafK2RmnD0SWikXr7LIiR/oYbEXE4D5TBjUTRC05w1rwx0rA5geY7E4zfNcor2SWPceLBu2HuldAR1+4QS4QDHnMoTinL8oF/bpUVOv4okSdL43JvcBhfUJ10a7/pu6odxjL1jmkU0Yn24qzN3s1IOn7eYzWdizavc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QYRItamH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717679598; x=1749215598;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=nESjAB4tx2zRd+29Q+AUJBF7z0+xj30Zl54hm7wQYqM=;
  b=QYRItamHTqx79PqJFK/LoTnH0VliRXqVUhhsCrGUY38B34UsFvJWaEBt
   oJVbZ5iq2u0usBMdTPoOLuSzjVMSY4OFayO7d1scJDX/dWPv6TnJxaQdx
   6upMz1I+aVdMf5YL7xeYc/ffprxvGw3M4w85Ry+dUpSbK0rQvrUls7eWC
   4uOENQkf6rt7UAVLKByC/OUfYkbaIvS95NuIy0W+03d7wUI1R794I0kVx
   fyD6sJKKcsFJwHFNIT7EaSOc7KqC5JNTr+qd4GIOcjKDEOm+6U4OcG3rq
   gsxcFfX/nIXh5q80gNEdQ3A2IzegyILOcALq5YK+0X/vBZQrro2NBRwzc
   w==;
X-CSE-ConnectionGUID: LsNlCUhPQ1eNCLEzS1bf1g==
X-CSE-MsgGUID: 93y9JYhiR3G4Z9RwD+Q1mA==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="18169959"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="18169959"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 06:13:18 -0700
X-CSE-ConnectionGUID: IQ3g8wWeTRWUI5fQZFbMUQ==
X-CSE-MsgGUID: GFh6ApNLQK2cmiPkgo748A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="61153256"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 06 Jun 2024 06:13:16 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: dave.hansen@linux.intel.com, kai.huang@intel.com, tj@kernel.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
 x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, sohil.mehta@intel.com,
 tim.c.chen@linux.intel.com, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v14 14/14] selftests/sgx: Add scripts for EPC cgroup
 testing
References: <20240531222630.4634-1-haitao.huang@linux.intel.com>
 <20240531222630.4634-15-haitao.huang@linux.intel.com>
 <D1RKK8CENNXI.1KMNDADV9C1YM@kernel.org>
 <op.2owf5xiwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <D1SOT40TEXMI.A5J72PR5IWSP@kernel.org>
Date: Thu, 06 Jun 2024 08:13:14 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2ox4ccz7wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <D1SOT40TEXMI.A5J72PR5IWSP@kernel.org>
User-Agent: Opera Mail/1.0 (Win32)

On Thu, 06 Jun 2024 00:32:55 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Wed Jun 5, 2024 at 6:33 PM EEST, Haitao Huang wrote:
>
>> sgx_cgroup_try_charge() expects sgx_cg_wq, so it would break unless we
>> check and return 0 which was the initially implemented in v12. But then
>> Kai had some concern on that we expose all the interface files to allow
>> user to set limits but we don't enforce. To keep it simple we settled  
>> down
>                                               ~~~~~~~~~~~~~~
>
> Sure:
>
> "Keep it simple and corpse"
>
>> back to BUG_ON(). This would only happen rarely and user can add
>> command-line to disable SGX if s/he really wants to start kernel in this
>> case, just can't do SGX.
>
> Even disabling all of SGX would be a less catastrophical measure.
>
>> Yes I had a comment but Kai thought it was too obvious and I can't think
>> of a better one that's not obvious so I removed:
>
> Not great advice given. Please just document it. In patch, which
> BUG_ON() I don't want to see my R-by in it, until I've reviewed an
> updated version.
>
> BR, Jarkko
>

Sure. that makes sens.  So far I have following changes. I did not do the  
renaming for the functions as I am not sure it is still needed. Let me  
know otherwise and if I missed any more.

--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -329,7 +329,7 @@ const struct misc_res_ops sgx_cgroup_ops = {
      .free = sgx_cgroup_free,
  };

-void sgx_cgroup_init(void)
+int __init sgx_cgroup_init(void)
  {
      /*
       * misc root always exists even if misc is disabled from command line.
@@ -345,7 +345,8 @@ void sgx_cgroup_init(void)
      if (cgroup_subsys_enabled(misc_cgrp_subsys)) {
          sgx_cg_wq = alloc_workqueue("sgx_cg_wq", WQ_UNBOUND |  
WQ_FREEZABLE,
                          WQ_UNBOUND_MAX_ACTIVE);
-        BUG_ON(!sgx_cg_wq);
+        return -ENOMEM;
      }

+    return 0;
  }

--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -99,7 +99,7 @@ bool sgx_cgroup_should_reclaim(struct sgx_cgroup  
*sgx_cg);
  struct misc_cg *sgx_cgroup_reclaim_pages(struct misc_cg *root,
                       struct misc_cg *next_cg,
                       struct mm_struct *charge_mm);
-void sgx_cgroup_init(void);
+int __init sgx_cgroup_init(void);

  #endif /* CONFIG_CGROUP_MISC */


--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -1045,7 +1045,7 @@ static int __init sgx_init(void)
      if (!sgx_page_cache_init())
          return -ENOMEM;

-    if (!sgx_page_reclaimer_init()) {
+    if (!sgx_page_reclaimer_init() || !sgx_cgroup_init()) {
          ret = -ENOMEM;
          goto err_page_cache;
      }
@@ -1067,9 +1067,6 @@ static int __init sgx_init(void)
      if (sgx_vepc_init() && ret)
          goto err_provision;

-    /* Setup cgroup if either the native or vepc driver is active */
-    sgx_cgroup_init();
-
      return 0;

  err_provision:

--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -119,6 +119,7 @@ static inline void *sgx_get_epc_virt_addr(struct  
sgx_epc_page *page)
   * cgroup.
   */
  struct sgx_epc_lru_list {
+    /* Use this lock to protect access from multiple reclamation worker  
threads */
      spinlock_t lock;
      struct list_head reclaimable;
  };

--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -446,7 +446,8 @@ misc_cg_alloc(struct cgroup_subsys_state *parent_css)
      int ret;

      if (!parent_css) {
-        parent_cg = cg = &root_cg;
+        parent_cg = &root_cg;
+        cg = &root_cg;
      } else {
          cg = kzalloc(sizeof(*cg), GFP_KERNEL);
          if (!cg)

Thanks
Haitao

