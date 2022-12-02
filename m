Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F716410CF
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 23:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiLBWrW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 17:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiLBWrW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 17:47:22 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DB6F81AF;
        Fri,  2 Dec 2022 14:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670021241; x=1701557241;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dkeEf5B8jsEg+YW2ca5IJz8BTxuatCkhH7aEzKzYhwA=;
  b=TRNbU7MVQUdwEggN+76jch2KRChrRRo3V3RX5kL7BIqKFJN9CldpjVbE
   l1TfsmWW0yDjZE28Vehc9QFZB39aW/A0TQCOb9kgXVlFZ1Kr2WfrcaKvY
   a5MlTrmdf3hFoLaNGPmbbsgQ+gK485IxmevJi5nI9D5O3Q/nVsp6fHBys
   qULMp1CnAq+ZuW36Q6EuXfLuMHITmqg/7tgIfcE8sPUyNe+dDG+bfNUIE
   eKGIYRkGpOjXTL8SebjLKsb4k3EmpICiNYuIYpgUc9zIM7msU0OD5XBHv
   NCvAFixpgW4GjjyLM4fjk4FdpNpjYInGC8e7m8ESclV6AX+mg4SfTjmcU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="295754253"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="295754253"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 14:47:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="751441167"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="751441167"
Received: from rsnyder-mobl.amr.corp.intel.com (HELO [10.209.68.71]) ([10.209.68.71])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 14:47:20 -0800
Message-ID: <8b7f6993-2135-a9f9-63c5-c9c6112ef676@intel.com>
Date:   Fri, 2 Dec 2022 14:47:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 02/18] x86/sgx: Store struct sgx_encl when allocating
 new VA pages
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        zhiquan1.li@intel.com
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-3-kristen@linux.intel.com>
 <3a789b1c-4c70-158b-d764-daec141a5816@intel.com>
 <abfc00a2ab1d97f8081c696f78e2d0ced23902b4.camel@linux.intel.com>
 <2015ae96-5459-1f82-596b-f46af08ef766@intel.com>
 <Y4p9nKV+jpLnOVwD@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y4p9nKV+jpLnOVwD@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/2/22 14:35, Sean Christopherson wrote:
>> That seems like it's going the other direction from what an OOM-kill
>> would need to do.
> Providing a backpointer from a VA page to its enclave allows OOM-killing the enclave
> if its cgroup is over the limit but there are no reclaimable pages for said cgroup
> (for SGX's definition of "reclaimable").  I.e. if all of an enclave's "regular"
> pages have been swapped out, the only thing left resident in the EPC will be the
> enclave's VA pages, which are not reclaimable in the kernel's current SGX
> implementation.

Ooooooooooooooooooooh.  I'm a dummy.


So, we've got a cgroup.  It's in OOM-kill mode and we're looking at the
*cgroup* LRU lists.  We've done everything we can to the enclave and
swapped everything out that we can.  All we're left with are these
crummy VA pages on the LRU (or equally crummy pages).  We want to
reclaim them but can't swap VA pages.  Our only recourse is to go to the
enclave and kill *it*.

Right now, we can easily find an enclave's VA pages and free them.  We
do that all the time when freeing whole enclaves.  But, what we can't
easily do is find an enclave given a VA page.

A reverse pointer from VA page back to enclave allows the VA page's
enclave to be located and efficiently killed.

Right?

Could we add that context to the changelog, please?
