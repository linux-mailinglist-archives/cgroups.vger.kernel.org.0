Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367C6642E1F
	for <lists+cgroups@lfdr.de>; Mon,  5 Dec 2022 18:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiLERDo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Dec 2022 12:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiLERDl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Dec 2022 12:03:41 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684FE164AD;
        Mon,  5 Dec 2022 09:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670259820; x=1701795820;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wzh0rMbXm1tFMjnwOYEXWNfHVTuu3YxI67jkP6aqejU=;
  b=mErQh0+Nr4urRtDNhHkmMI4B2Ism3tvGWs8RweSNig4/Q4mV3WCPvuWC
   agVqr7WehlM2VicV5gKbCi3daRahBaHp+FQ/WtC3KDty+axflE2YjTrCb
   KpgO+nLDYOupOuGQD0YJrfdcYA52DuAUHFFk2w08IURS9pAQdDJ8lrl0N
   73CTz3/Hp9S3OmS85W4G+/WDSDaUP5Wr9SSl78veo2Gk0RGj7y6FCW+OB
   R9clRnnYtQ4Ocm3OahsFfitv7dsGeOE98kB9up5k5gx0Ha7NV968HyaEm
   A12RECSIwyzPb+tuYw5voiBL6DgEsy7txb81BQaBMe8efnz5r2DPUsfyB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="378564175"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="378564175"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 09:03:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="645888119"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="645888119"
Received: from jcavitt-mobl.amr.corp.intel.com (HELO [10.209.116.98]) ([10.209.116.98])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 09:03:15 -0800
Message-ID: <6668e428-8e4a-0a44-d77c-a540c04d72ed@intel.com>
Date:   Mon, 5 Dec 2022 09:03:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 07/18] x86/sgx: Use a list to track to-be-reclaimed
 pages during reclaim
Content-Language: en-US
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-8-kristen@linux.intel.com>
 <0646275c-0ab9-2fad-8db1-7098656d6e1d@intel.com>
 <931e48dc399eddf8ad9f9dec8783f57df776daa9.camel@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <931e48dc399eddf8ad9f9dec8783f57df776daa9.camel@linux.intel.com>
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

On 12/5/22 08:33, Kristen Carlson Accardi wrote:
> The helpers were added because Jarrko requested a queue abstraction for
> the sgx_epc_lru_lists data structure in the first round of reviews. the
> simple one line inlines are effectively just renaming to make the queue
> abstraction more obvious to the reader.

Jarkko,

Do you have any issues with zapping these helpers?  I really don't think
they add to readability.  The "reclaimable" versus "unreclaimable"
naming is patently obvious from the structure member names.  I'm not
sure what value it adds to have them in the function names too.


