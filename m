Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9434D7A2DE7
	for <lists+cgroups@lfdr.de>; Sat, 16 Sep 2023 06:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjIPEU3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 16 Sep 2023 00:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238431AbjIPEUC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 16 Sep 2023 00:20:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A251BD2;
        Fri, 15 Sep 2023 21:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694837997; x=1726373997;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=gIPyWiuFfzCzD4q9eXt3xfBm9DVJMh2r9IPir+knJEA=;
  b=FAzDEN9rRR2HqihsDZKXnLrKWzQYeYI4y+RCHEq7iDU0vBJ0kUtkrAC2
   nuqHsAIMjMb7jfJ+ngrOuWRYCj7BCv7COjGIs5K/BtYmsXRGYQdM9HxBl
   GlyLW2opqLI99XC1xek0V3w01fpRSMqQuZTpZ8WvkBU26+RXggxPkNCeK
   xSTbGr1GTZbgEmxdFbUIo4N5dMLPmFFB7lOBLjDnO5r7RYKFPmTtP4to6
   SObrY4GTnbZy9W/Wqm+/fHUMBmTOIlS36oF+FolRGohDIoUOAcEiJJ2al
   frxc36LGjLNw53ChmzHSsxidtt61BL1lOLOXEDrL/L5FUnMrAJkDa3OVd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="358798227"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="358798227"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 21:19:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="748404890"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="748404890"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 15 Sep 2023 21:19:54 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc:     zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
        zhanb@microsoft.com, anakrish@microsoft.com,
        mikko.ylinen@linux.intel.com, yangjie@microsoft.com
Subject: Re: [PATCH v4 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
References: <20230913040635.28815-1-haitao.huang@linux.intel.com>
 <20230913040635.28815-13-haitao.huang@linux.intel.com>
 <CVHWE8HC4SHA.FU2XVIXN6WB7@suppilovahvero>
Date:   Fri, 15 Sep 2023 23:19:53 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2bcjnfkmwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <CVHWE8HC4SHA.FU2XVIXN6WB7@suppilovahvero>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 13 Sep 2023 10:34:28 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

>> +++ b/arch/x86/kernel/cpu/sgx/encl.h
>> @@ -39,6 +39,7 @@ enum sgx_encl_flags {
>>  	SGX_ENCL_DEBUG		= BIT(1),
>>  	SGX_ENCL_CREATED	= BIT(2),
>>  	SGX_ENCL_INITIALIZED	= BIT(3),
>> +	SGX_ENCL_OOM		= BIT(4),
>
> Given how the constants are named before maybe SGX_ENCL_NO_MEMORY would
> be more obvious.

Will do.
Thanks
Haitao
