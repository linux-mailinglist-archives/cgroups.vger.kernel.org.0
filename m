Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6721D76A202
	for <lists+cgroups@lfdr.de>; Mon, 31 Jul 2023 22:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjGaUfo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jul 2023 16:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjGaUfn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jul 2023 16:35:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B198172A;
        Mon, 31 Jul 2023 13:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690835741; x=1722371741;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=il+OrpNJkCiZXQXCAjNwn2LSF5pF/7jhhD8JXlD/k1Q=;
  b=lM4ae2yqx264rXk/G+jjkyTYzh9nYppQPp5OBGQ0aftWry10fq33z0s8
   xT0bUdgFLJZ3sCc3wNI89yEzIig1womQcFH2gEBNkgT1n79GT/VD3cc57
   E1GgYOFcdFWx3MHAZ5nG5+zCEM5CxBA9873uPQZRbhjKVh0LiDU0t65Dl
   2WCMQM8u3JU+/9s6yU+ELO1mokaiW/0K4gAnKkM7o6Rn2R14gl/lxvcBg
   pUrRNZgrGVWwfwJhBAebSmQgn+0EMrmHXJrVY7FpR6OFQPW0CnkT2FeSb
   i8MlwaYAPf7+v2vO2SZR8xlio16I5bdoiQGB729BA/sarZZo69UpgtrIk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="354043394"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="354043394"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 13:35:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="852170252"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="852170252"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.61])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 31 Jul 2023 13:35:38 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "mingo@redhat.com" <mingo@redhat.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tj@kernel.org" <tj@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>
Subject: Re: [PATCH v3 03/28] x86/sgx: Add 'struct sgx_epc_lru_lists' to
 encapsulate lru list(s)
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
 <20230712230202.47929-4-haitao.huang@linux.intel.com>
 <CU4GHCJTRKLZ.1RK23NWPHJGNI@seitikki>
 <op.17794m01wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <4f5496d2e0ea8edba430e7de7304bdd840616146.camel@intel.com>
 <op.18lc2zw6wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <9ffb02a3344807f2c173fe8c7cb000cd6c7843b6.camel@intel.com>
Date:   Mon, 31 Jul 2023 15:35:36 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.18yrhmgswjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <9ffb02a3344807f2c173fe8c7cb000cd6c7843b6.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 24 Jul 2023 18:31:58 -0500, Huang, Kai <kai.huang@intel.com> wrote:

...
>> > Although briefly mentioned in the first patch, it would be better to  
>> put
>> > more
>> > background about the "reclaimable" and "non-reclaimable" thing here,
>> > focusing on
>> > _why_ we need multiple LRUs (presumably you mean two lists:  
>> reclaimable
>> > and non-
>> > reclaimable).
>> >
>> Sure I can add a little more background to introduce the
>> reclaimable/unreclaimable concept. But why we need multiple LRUs would  
>> be
>> self-evident in later patches, not sure I will add details here.
>
> In this case people will need to go to that patch to get some idea  
> first.  It
> doesn't seem hurt if you can explain why you need multiple LRUs here  
> first.
>
Will add.

...
>
> I didn't get the CHECK in my testing.  Not sure why.
>
> Anyway, I guess the comment can be useful if it is to explain why we  
> need to use
> spinlock or whatever lock.  But
>
> 	/* Must acquire this lock to access */
>
> doesn't explain why at all, thus doesn't look helpful to me.
>
> I guess you either need a better comment, or just remove it (it's  
> obvious that a
> lot of kernel code doesn't have a comment around spinlock_t).
>

I'll remove the comments.
Thanks
Haitao
