Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A4C7CB747
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 02:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjJQAKP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Oct 2023 20:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjJQAKO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Oct 2023 20:10:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD0593;
        Mon, 16 Oct 2023 17:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697501413; x=1729037413;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=VYDZT96kexfqaH+AR3VV1CdJlxfibH9c6rb9UionuyU=;
  b=DzLIBWiXq9+kxC61Ay+fyhuFLvpihfwCW6/F2xm9KNzqe/vYMRS/D+yY
   601uv0dYJzHYMT/yr4i9SyqcDZvFE218zjxYXhVTHoblUAO5dNKCaYPV3
   CMcLIW31qX7q2j0bfnNea1BMsYqH5bX/h/doaNVnySqtcI3rFR/t88wv8
   aanMKADkIkUD+/7k3sZ4nFx10NECWZw5VaLkOqlqBtgmHGx5352HYFJQ3
   i9Q/meg12a0bfjYueUv0jzfGbKKvWr+m68LM+75t7hp5NyAq/Ogyr9vLx
   2il8dwmlyZs68pWmyzPimxUTwvz62yVnYOyABO5R8eqUx24G+2zwzs0r6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="376036956"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="376036956"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 17:10:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="755882750"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="755882750"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.92])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 16 Oct 2023 17:10:10 -0700
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
 <op.2cpecbevwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <aa404549c7e292dd2ec93a5e6a8c9d6d880c06b3.camel@intel.com>
 <op.2cxatlafwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <35a7fde056037a40b3b4b170e2ecd45bf8c4ba9f.camel@intel.com>
Date:   Mon, 16 Oct 2023 19:10:09 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2cxmq7c2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <35a7fde056037a40b3b4b170e2ecd45bf8c4ba9f.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 16 Oct 2023 16:09:52 -0500, Huang, Kai <kai.huang@intel.com> wrote:
[...]

> still need to fix the bug mentioned above here.
>
> I really think you should just go this simple way:
>
> When you want to take EPC back from VM, kill the VM.
>

My only concern is that this is a compromise due to current limitation (no  
other sane way to take EPC from VMs). If we define this behavior and it  
becomes a contract to user space, then we can't change in future.

On the other hand, my understanding the reason you want this behavior is  
to enforce EPC limit at runtime. I just not sure how important it is and  
if it is a real usage given all limitations of SGX VMs we have (static EPC  
size, no migration).

Thanks

Haitao
