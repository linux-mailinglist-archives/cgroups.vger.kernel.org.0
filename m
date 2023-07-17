Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CA77564E1
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 15:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjGQN0t (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 09:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjGQN0h (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 09:26:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77D7171F;
        Mon, 17 Jul 2023 06:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689600378; x=1721136378;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=kSV+42buHlYkZswjzK71Zxt1+CC8bsivgjmnDWsyDDU=;
  b=Xo2NZXcTMJTAsxXzjFJdw7y4u2cy6k20NYPmeVW9cMay4C/N2oOiGu9x
   QfWDab74lkEYoWsqy7Lya3FnUeMHwQgx+uH84wmPHximhT8iaEaFbyty0
   n1JSTS04yTCnNyru//Ja6ADkEbpNOJEoeDz9B8p+GOYYeey4G7RfrAmlZ
   di8qh6mymvdt6dwWtvd1pEXXm37BGK2GT3B0opCFhWuH3s85s4xKYGkcd
   GU2u4RuRLEZc9rZBy/3f3b0/s6TqA1FJFsx5DFXz8NJdyMqyZKnBWG2B9
   91Qt9AC45Lrr/XL0VIJ3ZxYz2ZYbB/UTcMa8u5nX7UM2FITa/zbqu/TTE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="432098780"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432098780"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:23:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="717231362"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="717231362"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.48.113])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 17 Jul 2023 06:23:01 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Jarkko Sakkinen" <jarkko@kernel.org>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        "Kristen Carlson Accardi" <kristen@linux.intel.com>,
        zhiquan1.li@intel.com, seanjc@google.com
Subject: Re: [PATCH v3 03/28] x86/sgx: Add 'struct sgx_epc_lru_lists' to
 encapsulate lru list(s)
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
 <20230712230202.47929-4-haitao.huang@linux.intel.com>
 <CU4GHCJTRKLZ.1RK23NWPHJGNI@seitikki>
Date:   Mon, 17 Jul 2023 08:23:00 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.17794m01wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <CU4GHCJTRKLZ.1RK23NWPHJGNI@seitikki>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 17 Jul 2023 07:45:36 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Wed Jul 12, 2023 at 11:01 PM UTC, Haitao Huang wrote:
>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>>
>> Introduce a data structure to wrap the existing reclaimable list
>> and its spinlock in a struct to minimize the code changes needed
>> to handle multiple LRUs as well as reclaimable and non-reclaimable
>> lists. The new structure will be used in a following set of patches to
>> implement SGX EPC cgroups.
>>
>> The changes to the structure needed for unreclaimable lists will be
>> added in later patches.
>>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> Cc: Sean Christopherson <seanjc@google.com>
>>
>> V3:
>> Removed the helper functions and revised commit messages
>> ---
>>  arch/x86/kernel/cpu/sgx/sgx.h | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h  
>> b/arch/x86/kernel/cpu/sgx/sgx.h
>> index f6e3c5810eef..77fceba73a25 100644
>> --- a/arch/x86/kernel/cpu/sgx/sgx.h
>> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
>> @@ -92,6 +92,23 @@ static inline void *sgx_get_epc_virt_addr(struct  
>> sgx_epc_page *page)
>>  	return section->virt_addr + index * PAGE_SIZE;
>>  }
>>
>> +/*
>> + * This data structure wraps a list of reclaimable EPC pages, and a  
>> list of
>> + * non-reclaimable EPC pages and is used to implement a LRU policy  
>> during
>> + * reclamation.
>> + */
>> +struct sgx_epc_lru_lists {
>> +	/* Must acquire this lock to access */
>> +	spinlock_t lock;
>
> Isn't this self-explanatory, why the inline comment?

I got a warning from the checkpatch script complaining this lock needs  
comments.

Thanks
Haitao
