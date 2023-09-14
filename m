Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4C27A0A84
	for <lists+cgroups@lfdr.de>; Thu, 14 Sep 2023 18:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbjINQNV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Sep 2023 12:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjINQNT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Sep 2023 12:13:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB611BE1;
        Thu, 14 Sep 2023 09:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694707995; x=1726243995;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=esb42FKt68BhUbXDb04GFC6pySSzSlbs9XWMViBbL70=;
  b=Kn1fxF/Sa+wYzUbqmOtDHI7sdnB5SCzYPPqLCXBlTXzSS3bJxqWUXMHk
   pMBVF9nRgVFJ45R08u8jOcIljXB6V6BdOmY1GvRk2c0/w6Sc7vjzmDDFQ
   yM5P5bI67naE+dgSoGmEgQu9cO8IYphUG6t7P6MnN6Bguu/pt78uFdRax
   jfuWWzLdSCj92TbRtzIA3YxVQhLuNvLpBESP3QMKdWa40aSW4MhSvCXoR
   qSr2oalFZ5Qn7CXFG8sRl7RdXwdqe2zpB4ASNDgmQyFg/aVG4XvIVM07e
   RiHAWFkSiG+h990s7jBfjj4OkqLNCO/t0iFQiOGUzRFnsqslnxt7AOWtx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="369299488"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="369299488"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 09:13:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="747805802"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="747805802"
Received: from spswartz-mobl.amr.corp.intel.com (HELO [10.209.21.97]) ([10.209.21.97])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 09:13:13 -0700
Message-ID: <7c418047-dd0b-76e9-dcfd-f00c76eeae46@intel.com>
Date:   Thu, 14 Sep 2023 09:13:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 03/18] x86/sgx: Add sgx_epc_lru_lists to encapsulate
 LRU lists
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
Cc:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Zhang, Bo" <zhanb@microsoft.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
 <20230913040635.28815-4-haitao.huang@linux.intel.com>
 <851f9b3043732c17cd8f86a77ccee0b7c6caa22f.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <851f9b3043732c17cd8f86a77ccee0b7c6caa22f.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/14/23 03:31, Huang, Kai wrote:
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Cc: Sean Christopherson <seanjc@google.com>
> You don't need 'Cc:' Sean if the patch has Sean's SoB.

It is a SoB for Sean's @intel address and cc's his @google address.

It is fine.
