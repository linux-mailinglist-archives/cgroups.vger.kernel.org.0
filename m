Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302587B603D
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 07:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjJCFJy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 01:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjJCFJy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 01:09:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3977A9;
        Mon,  2 Oct 2023 22:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696309791; x=1727845791;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=OUIez8Ogzr+c9hyQecnF675tecZjvzRqAbgkBev4cU8=;
  b=Vt+cbidYNsTo4JkCLYYAjLkr6WZDoHMTJXBtOwWRuRztQq3RIFUnTpxx
   BGGbEJlUMoSxuhxLti24/3062+PXdIv9DxWgzRsRdXQ+1zqmgW6C6y73D
   wfXnEuc5ay35HNhbGPaNqWADhN0SuT1er5mCkRr5q76oOcMk872SrTidp
   Ow3iHVIa/Z3KkZxPsSSsf2RIsdwB1FGhhoVIMpf0WzwessVeCJim/L5CB
   9UA9kcLXSqhTsh8m6YgI9bDGbOv0V293hunv7fA18hK2d1jOCYrYQHf+J
   lqqo0jgUEaaeKAgGaGMZx9r4EiFPkWY/dY4QiYu072dqBpUCgF/Vp/gga
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="382706587"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="382706587"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 22:09:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="700566974"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="700566974"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 02 Oct 2023 22:09:48 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Zhang, Bo" <zhanb@microsoft.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>
Subject: Re: [PATCH v5 08/18] x86/sgx: Use a list to track to-be-reclaimed
 pages
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-9-haitao.huang@linux.intel.com>
 <830b789caa2a6cfd735c83dee1aad3591b9272f0.camel@intel.com>
Date:   Tue, 03 Oct 2023 00:09:46 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2b73akfkwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <830b789caa2a6cfd735c83dee1aad3591b9272f0.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 28 Sep 2023 04:28:34 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Fri, 2023-09-22 at 20:06 -0700, Haitao Huang wrote:
>> @@ -314,18 +313,22 @@ static void sgx_reclaim_pages(void)
>>   		if (kref_get_unless_zero(&encl_page->encl->refcount) != 0) {
>>  			sgx_epc_page_set_state(epc_page, SGX_EPC_PAGE_RECLAIM_IN_PROGRESS);
>> -			chunk[cnt++] = epc_page;
>> +			list_move_tail(&epc_page->list, &iso);
>>  		} else {
>> -			/* The owner is freeing the page. No need to add the
>> -			 * page back to the list of reclaimable pages.
>> +			/* The owner is freeing the page, remove it from the
>> +			 * LRU list
>>  			 */
>
> Please fix comment style.

Sure

>
>>  			sgx_epc_page_reset_state(epc_page);
>> +			list_del_init(&epc_page->list);
>
> Is this still needed?  It seems list_del_init() has been done when the  
> EPC page
> is taken off from the global active list?
>

Good catch. I'll remove it.

Thanks
Haitao
