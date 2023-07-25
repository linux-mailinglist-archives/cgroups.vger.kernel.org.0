Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D03761FEC
	for <lists+cgroups@lfdr.de>; Tue, 25 Jul 2023 19:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjGYRQP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jul 2023 13:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjGYRQO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jul 2023 13:16:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9286B6;
        Tue, 25 Jul 2023 10:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690305373; x=1721841373;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=acChHG7yYZ3Qqd5Vg1It58EizdosOgoh5agGHaDhu4o=;
  b=lBsDnsctn7FsqH7Q949bxMYiqpL+5ohu9V6c5Luc3qk5mslqyktsp8m3
   ZPMfXHzFOHAlxQzbOuyZuIWSXryMRbTCAKjnpj/TUbL7J7+KAk4tv4fLs
   JijIQl5SHvdhAztCleoZ5hUXJdoLIOFNeT2jb6k98+N89K5Jo0iuipNI4
   hddvqnAugFTNrwoPFZ6bQY07o6l+c5YHgNu8uklV/fb36AkMT1yeZRmc2
   4/DnL6zwEHx39TPquWwI+qQWtYR0Vk5QkOJ6UVEMnhKkU85DhicO2twca
   E2CGGs9btYfS3Hs6mBSZ97fT5ebQhVxJDIVGhEP4Z57KhvpLVBYK6wyJ6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="352693873"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="352693873"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 10:16:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="761288262"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="761288262"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.48.113])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 25 Jul 2023 10:16:07 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, X86-kernel <x86@kernel.org>,
        "Sohil Mehta" <sohil.mehta@intel.com>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
        zhanb@microsoft.com, anakrish@microsoft.com,
        mikko.ylinen@linux.intel.com
Subject: Re: [PATCH v3 00/28] Add Cgroup support for SGX EPC memory
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
 <6bedc9fe-88b5-8382-aa65-ded66b58aa2c@intel.com>
Date:   Tue, 25 Jul 2023 12:16:06 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.18nd84c7wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <6bedc9fe-88b5-8382-aa65-ded66b58aa2c@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 24 Jul 2023 14:09:21 -0500, Sohil Mehta <sohil.mehta@intel.com>  
wrote:

> Hi Haitao,
>
> On 7/12/2023 4:01 PM, Haitao Huang wrote:
>
>> I appreciate your comments and feedback.
>>
>
> Nit: You missed emailing the cover letter to x86@kernel.org. I think a
> few other people included in the individual patches are also missing in
> the cover letter.
>
> In general, it might be useful to keep the email list consistent across
> the cover letter and the individual patches.
>
> -Sohil

Thanks

I'll change to use the same set of lists and addresses for all patches and  
cover letters in next version.
BR
Haitao
