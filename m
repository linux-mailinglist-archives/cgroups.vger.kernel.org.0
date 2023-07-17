Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895A2756848
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 17:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjGQPtH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 11:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjGQPtG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 11:49:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D5E138;
        Mon, 17 Jul 2023 08:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689608945; x=1721144945;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n7mERhm1vnG8xMeSAl/fiQX+qVVEGB1U/K7jVm6Ihyw=;
  b=QOynNXqX7fQtk/dHh3Eep4/zFJpsvridcXO1G7LPFwJqBnir8ERrswzM
   zlE6jQJcAnwYcEyTl1kR4cSyXMpmcEiasRHb05YbOO9h6rPG9UH+QvubM
   QCiNGR6lj5uhI8vD59Ehgk7A1yOwIOZwyEuolZXdmMDeDQtCPpJfup8p4
   I/RGD16UeR19dzDZt/++2RdnUXyRDBP7W/4PWH84UNamtb55YfBniI1qB
   OTe5Jsl3bOVEMtxpnWuuwNnTHZ2oE8quG5lNGrcUsxRjjinyn+wbc+r7U
   VlhWwuk77yZbk16WN6Y017LhAitJi7n8//pPg62ibNZDa40D2/P8E8nm7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="345555742"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="345555742"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 08:49:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="758465932"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="758465932"
Received: from reklass-mobl.amr.corp.intel.com (HELO [10.251.9.216]) ([10.251.9.216])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 08:49:04 -0700
Message-ID: <ffe26e8b-9f2a-4f06-aadf-9dfb1421be76@intel.com>
Date:   Mon, 17 Jul 2023 08:49:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 17/28] x86/sgx: fix a NULL pointer
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
 <20230712230202.47929-18-haitao.huang@linux.intel.com>
 <CU4GJG1NRTUD.275UVHM8W2VED@seitikki>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CU4GJG1NRTUD.275UVHM8W2VED@seitikki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/17/23 05:48, Jarkko Sakkinen wrote:
> On Wed Jul 12, 2023 at 11:01 PM UTC, Haitao Huang wrote:
>> Under heavy load, the SGX EPC reclaimers (ksgxd or future EPC cgroup
>> worker) may reclaim SECS EPC page for an enclave and set
>> encl->secs.epc_page to NULL. But the SECS EPC page is required for EAUG
>> in #PF handler and is used without checking for NULL and reloading.
>>
>> Fix this by checking if SECS is loaded before EAUG and load it if it was
>> reclaimed.
>>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> A bug fix should be 1/*.

No, bug fixes should not even be _part_ of another series.  Send bug
fixes separately, please.
