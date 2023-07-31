Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF45A76A21D
	for <lists+cgroups@lfdr.de>; Mon, 31 Jul 2023 22:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjGaUo0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jul 2023 16:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGaUoZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jul 2023 16:44:25 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4253690;
        Mon, 31 Jul 2023 13:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690836265; x=1722372265;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=hu8JTDbJqIGr3TfklVY/QtEKkWMtllj5IhBurxsIJkA=;
  b=Ct9injIDoK03Q/rBDHWho/HkWMn9PamCrsNn8oYxp2dOiyTR5MoTeAXM
   1N94JNUF2oYCz0O08eahMoSUV7nnYgg3c9rFMxIsEAMvWgwpilS/gQRcx
   EXgELVBV/7UNX9AeTCQawZ05ftOl7fqnmEWyx+Xck1hbGvYHYFAHNtupi
   /YXqZLuIwGuMNPkD3zfYbQI7uRwzsEIV4KyF/E6rt1efIqXNyHSSIYS/Q
   3lCS0wwKqLqYZGCVfwJyFJP+FLlWTkPFR54MTwU/V9gNpEpNwkcsevnkP
   /P95Kg4Rf0EwsuthLPoGGR6jjTphTpB+HYU1fMXmzpAxJDQMWT9jD5V0/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="371831414"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="371831414"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 13:43:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="852171619"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="852171619"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.61])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 31 Jul 2023 13:43:55 -0700
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
Subject: Re: [PATCH v3 04/28] x86/sgx: Use sgx_epc_lru_lists for existing
 active page list
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
 <20230712230202.47929-5-haitao.huang@linux.intel.com>
 <CU4GIFHMTA8N.2GV3WIA7HAVOE@seitikki>
Date:   Mon, 31 Jul 2023 15:43:54 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.18yrvgbvwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <CU4GIFHMTA8N.2GV3WIA7HAVOE@seitikki>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 17 Jul 2023 07:47:01 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Wed Jul 12, 2023 at 11:01 PM UTC, Haitao Huang wrote:
>> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>>
>> Replace the existing sgx_active_page_list and its spinlock with
>> a global sgx_epc_lru_lists struct.
>
> Similarly as the previous patch, I would extend this story a tiny
> bit forward to see the connection with the follow-up patches.
>
Sure

I also feel it may flow better by moving all changes related to  
'unreclaimable' such as owner field for VA, flags for types of owners,  
storing unreclaimables to LRU, etc. to later after all changes dealing  
with reclaimables are introduced. The unreclaimables are only of concern  
when OOM is involved so it'd be better to do them right before OOM.

Thanks
Haitao
