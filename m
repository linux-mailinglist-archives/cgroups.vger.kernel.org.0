Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9685E641025
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 22:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbiLBVpY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 16:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiLBVpX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 16:45:23 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE541DB6B4;
        Fri,  2 Dec 2022 13:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670017522; x=1701553522;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f+JtP3YBSpbvSEOM6o4SFDk1XVrfF1sDpnt2nGAMCzw=;
  b=LKeXG9zKM2kRPWsXOBmdL133hb4AaMTPH/9JBpT1FbCTqubKjfYHEv6h
   J6cWBrscLuahh1GhOYAtmBLVR+hPM6JoSdHens8mfd5Eqzv1kdbkLXsYI
   JsAwuh9snxv0O7EX07gjfnL+XxKZTpFcWLkcCoSH/o5MWrsfyvFZHxXIs
   SNkQMWR+seDc5AU/U7/GXMW/sepadsCLz+VoBRaUB/xjfY5WHlTGouvzo
   +zgdF3x5huJDzqP7NQyxiJlb0D19cJjvOnFLIJDqZgTz2X7huU7GVKEBd
   lX4+kGu34THQwnoJxpQtKH7/qPfcshIH/u6hca1b70L7kk7c6sz9qcAZh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313689059"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313689059"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:45:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="733955426"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="733955426"
Received: from rsnyder-mobl.amr.corp.intel.com (HELO [10.209.68.71]) ([10.209.68.71])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:45:21 -0800
Message-ID: <746adf31-e70c-e32d-a35d-72d352af613b@intel.com>
Date:   Fri, 2 Dec 2022 13:45:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 01/18] x86/sgx: Call cond_resched() at the end of
 sgx_reclaim_pages()
Content-Language: en-US
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-2-kristen@linux.intel.com>
 <37de083d-a63b-b2ff-d00a-e890a1ba5eea@intel.com>
 <da690a45a36038399c63ddac8f0efed9872ec13e.camel@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <da690a45a36038399c63ddac8f0efed9872ec13e.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/2/22 13:37, Kristen Carlson Accardi wrote:
>>> +static void sgx_reclaim_pages(void)
>>> +{
>>> +       __sgx_reclaim_pages();
>>> +       cond_resched();
>>> +}
>> Why bother with the wrapper?  Can't we just put cond_resched() in the
>> existing sgx_reclaim_pages()?
> Because sgx_reclaim_direct() needs to call sgx_reclaim_pages() but not
> do the cond_resched(). It was this or add a boolean or something to let
> caller's opt out of the resched.

Is there a reason sgx_reclaim_direct() *can't* or shouldn't call
cond_resched()?
