Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE68B7C6F23
	for <lists+cgroups@lfdr.de>; Thu, 12 Oct 2023 15:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347250AbjJLN2J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Oct 2023 09:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343952AbjJLN2I (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Oct 2023 09:28:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5813CF;
        Thu, 12 Oct 2023 06:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697117287; x=1728653287;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=Gy2okrDMRW3GgiY3/crBu9Q7pncM9KlkB5/NL5Quijg=;
  b=Yn0JRNdd++zjwRyPCUWgitTdkYMA8iYhHwh8VR4paQm5ypD1k8s4AWc3
   MVc/wS1//p7hTOMDKVHAZbBIRSj9jtoLYNnXdRnLkwhukohiF9lVLaPXe
   tIF+UxaEx3KNBI0HU779It8pq5zzE78WwgZIiHsnhnfMRY5tLIcGfZtFc
   OvpR5mq9rwMM+yd0XRdX+4Svu35ER/lgBPruXrOoQRLOWmCosIOyDi9+3
   +0jIuJcesMFhU/8/ZU9k2d605WM9JsUj6zbQIWFThULnsPDC66OdmFkJt
   AoDmsDsRg+vplPUJg2DduWf+DS7+Sgc3cwhfUx4LC6nV2e+QWiYD/AlJC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="3521942"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="3521942"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 06:27:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="927987468"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="927987468"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 12 Oct 2023 06:27:39 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "Zhang, Bo" <zhanb@microsoft.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-13-haitao.huang@linux.intel.com>
 <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
 <ZSSZaFrxvCvR1SOy@google.com>
 <06142144151da06772a9f0cc195a3c8ffcbc07b7.camel@intel.com>
 <1f7a740f3acff8a04ec95be39864fb3e32d2d96c.camel@intel.com>
 <op.2clydbf8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <631f34613bcc8b5aa41cf519fa9d76bcd57a7650.camel@intel.com>
Date:   Thu, 12 Oct 2023 08:27:37 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2cpecbevwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <631f34613bcc8b5aa41cf519fa9d76bcd57a7650.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 10 Oct 2023 19:51:17 -0500, Huang, Kai <kai.huang@intel.com> wrote:
[...]
> (btw, even you track VA/SECS pages in unreclaimable list, given they  
> both have
> 'enclave' as the owner,  do you still need SGX_EPC_OWNER_ENCL and
> SGX_EPC_OWNER_PAGE ?)

Let me think about it, there might be also a way just track encl objects  
not unreclaimable pages.

I still not get why we need kill the VM not just remove just enough pages.  
Is it due to the static allocation not able to reclaim?


If we always remove all vEPC pages/kill VM, then we should not need track  
individual vepc pages.

Thanks

Haitao
