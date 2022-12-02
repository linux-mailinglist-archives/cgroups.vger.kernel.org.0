Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC14064105C
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 23:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbiLBWK1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 17:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiLBWK0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 17:10:26 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65177EC83B;
        Fri,  2 Dec 2022 14:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670019025; x=1701555025;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kff4S1vyf+hWj1GXzPubNZckk1uQ/dFn8K1E9qFptjk=;
  b=gMvbzBqDLpKA5i7dJC5HoH5F16MU8pJNXCZDNhEAVrL+cb9y/ookBjcp
   lnmlJYY10vLIX332z1gctOlnVNGCIKruFWyQk5PmK+jSWDUWRcud2GVmf
   X1sgm23k4qb17CGnU0pWsSi7Kxe8rui5235qqnxCoSpLU7nzug+jAWSe0
   2oaFVJ0niQSlQ8ZXV8uxSFhUjyAULFCFrV3WXYGB3AYBxZTBpCZpETrEY
   yYlNtDDxToA1bWMVYgFu7C/HhOzXf/WAe5eFRZa/E1kA+MMr2VVtxPn3E
   8/jbDCwebvsUSy9SbbMr/JTlr4K8vqweoVgv9K8yqARU1gNZccWYqRqMg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="317913157"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="317913157"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 14:10:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="622850146"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="622850146"
Received: from rsnyder-mobl.amr.corp.intel.com (HELO [10.209.68.71]) ([10.209.68.71])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 14:10:17 -0800
Message-ID: <e71d76b2-4368-4627-abd4-2163e6786a20@intel.com>
Date:   Fri, 2 Dec 2022 14:10:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 04/18] x86/sgx: Use sgx_epc_lru_lists for existing
 active page list
Content-Language: en-US
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-5-kristen@linux.intel.com>
 <ad1bcb0f-661d-a701-2175-c8750d8af8d8@intel.com>
 <d17c270bcbf631736d52b762dad8a6758d7dc951.camel@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <d17c270bcbf631736d52b762dad8a6758d7dc951.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/2/22 13:51, Kristen Carlson Accardi wrote:
> I know - and originally the addition of unreclaimable was added later,
> but when I posted the RFC I felt there was some misunderstanding about
> what this data structure was and how it would be used because the
> addition of the unreclaimable bits came later. So I stuck both lists in
> one so it'd be a better view of what the data structure would look
> like.

You're not insane for thinking that.

But, it's really OK to introduce an abstraction that *looks* silly on
its face at first.  You can easily just make up for it by saying:

	struct silly_abstraction {
		struct list_head list;
	}

	Oh, boy does my structure look silly.  It's a structure with a
	single list_head.  Why oh why would I do something silly like
	that?  Well, for now, the code has but one list.  Soon, I'll
	add a whole smorgasbord of lists.  Bear with me for now.

