Return-Path: <cgroups+bounces-4410-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E223395AC54
	for <lists+cgroups@lfdr.de>; Thu, 22 Aug 2024 06:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2031F23027
	for <lists+cgroups@lfdr.de>; Thu, 22 Aug 2024 04:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14EA1CA89;
	Thu, 22 Aug 2024 04:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZUTdksn"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3582E416;
	Thu, 22 Aug 2024 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724299267; cv=none; b=Gm/ZbaeInhGkz4RcGpT21LRzExd4nPNkcq/+WxDPTgJUITJxsCFWNGiQgW/R0Ne3pGakLEze8vBbfup2QqmLhrxPRZKO8mn+m2Db1/wjcg72He+dfPOXWANiMcml0IiTjRNj04KJvolHwnnJLidOVDAf9SxwQvD6fyXLCK/bEd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724299267; c=relaxed/simple;
	bh=F/gSLtnKYiZ+iHz/9zkLaDxiaF4alUERFDL39holi40=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=fNujtI0BoY5sA+qhlGsgcjUHVgFvFiLBqRokKZpuOmKIG4qj0iYXnkywSLLC9AE5UwrbM8FwHE2pPTO9Ar20oSPi0Ump3KgMVZyL5eiTfMpmER0W0rsqCtPgDDtCwF8jtx/dYYo8TSMy8wIQ2lNiaXLQ9lPr5B6ZQRiHrf74No4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZUTdksn; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724299266; x=1755835266;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=F/gSLtnKYiZ+iHz/9zkLaDxiaF4alUERFDL39holi40=;
  b=WZUTdksnv/dblUFuXguSuD2YPePL+ptGid+Kvw/LpvkKCwdn4R0p1miN
   swk2IGeay21ONHyrsqk0I2i0t32SdRfJZJi0mSnP73PnecDgOievdmn4P
   lSftQ9+k0xYNrlV8yLc8DwR12imc+k5V8JFXqedM5rv3BDKJpkiBHf2bu
   ci5JO+ROTMCfULbJPThSb01tRJ94nBLaxUTli/1yaw6UnJlv8sarbkIkO
   A90QM5tvfR+Swvscl0bOA308gbWPKxdn+bNFsXLW/ms8m7Mfm8d6yQjXw
   h/bnbqpW00nO2Ti3WtpxoJlzUPZ4/AIPiyAl6XKpzE/LOPrL6IZ73oXIR
   w==;
X-CSE-ConnectionGUID: 7Ts3LtA1QSedT9+9L64VXA==
X-CSE-MsgGUID: cw0bsFtvQ0iH7caB8WWNRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="26561838"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="26561838"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 21:01:05 -0700
X-CSE-ConnectionGUID: Yt8gNyoYQSuimIeoYG0wlw==
X-CSE-MsgGUID: LJUScDFqQImHR1DrzI32DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61167903"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.246.119.97])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 21 Aug 2024 21:00:56 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: jarkko@kernel.org, dave.hansen@linux.intel.com, kai.huang@intel.com,
 tj@kernel.org, mkoutny@suse.com, chenridong@huawei.com,
 linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org, x86@kernel.org,
 cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, sohil.mehta@intel.com, tim.c.chen@linux.intel.com, "Haitao
 Huang" <haitao.huang@linux.intel.com>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v16 09/16] x86/sgx: Add basic EPC reclamation flow for
 cgroup
References: <20240821015404.6038-1-haitao.huang@linux.intel.com>
 <20240821015404.6038-10-haitao.huang@linux.intel.com>
Date: Wed, 21 Aug 2024 23:00:53 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2svz3rfywjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <20240821015404.6038-10-haitao.huang@linux.intel.com>
User-Agent: Opera Mail/1.0 (Win32)

> +static struct sgx_cgroup *sgx_cgroup_next_descendant_pre(struct  
> sgx_cgroup *root,
> +							 struct sgx_cgroup *cg)
> +{
> +	struct cgroup_subsys_state *next;
> +
> +	rcu_read_lock();
> +	for (;;) {
> +		next = css_next_descendant_pre(&cg->cg->css, &root->cg->css);

I  messed it up in a last minute change and rebase. Above should be:

+	struct cgroup_subsys_state *next = &cg->cg->css;
+
+	rcu_read_lock();
+	for (;;) {
+		next = css_next_descendant_pre(next, &root->cg->css);

Fixed in a branch here:  
https://github.com/haitaohuang/linux/tree/sgx_cg_upstream_v16_plus
Will include in next version or update if needed.

> +		if (!next) {
> +			next = &root->cg->css;
> +			break;
> +		}
> +
> +		if (css_tryget(next))
> +			break;
> +	}
> +	rcu_read_unlock();
> +
> +	return sgx_cgroup_from_misc_cg(css_misc(next));
> +}
> +
BR
Haitao

