Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D32756C7B
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 20:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjGQStx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 14:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjGQStw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 14:49:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22708124;
        Mon, 17 Jul 2023 11:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689619790; x=1721155790;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=vHqFAb6Vl7dA36hMqfVx3NL//FFkWSCEjQFuIaxEHj0=;
  b=JGcumQHKAfej9OfBNuWTssmjNqroOz3pWOZqr8dHcchCtTy70hnElRcM
   5vU4/1390LyNb6biCvbYFZcVAeFsPLNG67+vIUaNUKsHxNFkfzh66a0lU
   nPnmdhaTqSLOEdtVbrwxHHNcPAjXfwIKrM0YErvxYpSThhzlYkUV/hyzI
   jEnetacAhziVngbtgET8ZcPjFdI73ta+PCbtXRwhO00jaxvl137OHTSk9
   t/nwPBMvK+dI3q3MDO9jBBsS6GQb+twNGFl8DMym0M6GQ3DGfSvb60ViH
   GafsECD20kS3O2diCc+jrOd+2QdW4lzTqOBiZaaUNtor/rpC9O/SgEQku
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="429772798"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="429772798"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 11:49:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="726661096"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="726661096"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.48.113])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 17 Jul 2023 11:49:47 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Jarkko Sakkinen" <jarkko@kernel.org>, dave.hansen@linux.intel.com,
        tj@kernel.org, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, cgroups@vger.kernel.org,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Dave Hansen" <dave.hansen@intel.com>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com
Subject: Re: [PATCH v3 17/28] x86/sgx: fix a NULL pointer
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
 <20230712230202.47929-18-haitao.huang@linux.intel.com>
 <CU4GJG1NRTUD.275UVHM8W2VED@seitikki>
 <ffe26e8b-9f2a-4f06-aadf-9dfb1421be76@intel.com>
Date:   Mon, 17 Jul 2023 13:49:45 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.178o87ejwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <ffe26e8b-9f2a-4f06-aadf-9dfb1421be76@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 17 Jul 2023 10:49:03 -0500, Dave Hansen <dave.hansen@intel.com>  
wrote:

> On 7/17/23 05:48, Jarkko Sakkinen wrote:
>> On Wed Jul 12, 2023 at 11:01 PM UTC, Haitao Huang wrote:
>>> Under heavy load, the SGX EPC reclaimers (ksgxd or future EPC cgroup
>>> worker) may reclaim SECS EPC page for an enclave and set
>>> encl->secs.epc_page to NULL. But the SECS EPC page is required for EAUG
>>> in #PF handler and is used without checking for NULL and reloading.
>>>
>>> Fix this by checking if SECS is loaded before EAUG and load it if it  
>>> was
>>> reclaimed.
>>>
>>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> A bug fix should be 1/*.
>
> No, bug fixes should not even be _part_ of another series.  Send bug
> fixes separately, please.


I sent the two bug fixes separately now. Do you want me resend this series  
without those?
Thanks
Haitao
