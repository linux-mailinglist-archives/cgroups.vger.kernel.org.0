Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93817B6075
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 07:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjJCFnB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 01:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjJCFnB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 01:43:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70564B3;
        Mon,  2 Oct 2023 22:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696311779; x=1727847779;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=uAJwvd5rkN3CyloFuRAemOFuMERw5zaXzLS6W9DhdyY=;
  b=bdxGN7cJf1abbXCUoprl2W5eT9vyx8Z2Q8sM9mDAT32+/apuDBQTcBdM
   j7jw1kbSGAuJOTDv9cshccgpXvxZ0lIpIQVAL1ZCEIGpNWKeCZjUdoLkz
   FWb63l2rJ8xyvVmdgxpvrKYZo0SJ9E8wbrgFYKZIXEbfbHbvqu9slXHBO
   Dl1LlBEWvZy/FjCVViN/7eQnjHViWi3iPXoYpZ/01Ro7h/Ak0SaqcbwgP
   go7WEH34dOYqZ9YxwGRstSHFDnxS1L56sjMEZj1++zzYqazHwpHClXamy
   WtrcsXLCvf7B+w2HiCSDvJ7hyMoXLyHctitZxj5AkyOMVk1Rm2n8Nl6+4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="4362925"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="4362925"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 22:42:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="821113872"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="821113872"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 02 Oct 2023 22:42:44 -0700
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
Subject: Re: [PATCH v5 11/18] x86/sgx: store unreclaimable pages in LRU lists
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-12-haitao.huang@linux.intel.com>
 <8263fc876ae932c4744c7870af90cfb01b8426e2.camel@intel.com>
Date:   Tue, 03 Oct 2023 00:42:45 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2b74tjevwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <8263fc876ae932c4744c7870af90cfb01b8426e2.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 27 Sep 2023 06:57:18 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Fri, 2023-09-22 at 20:06 -0700, Haitao Huang wrote:
>> From: Sean Christopherson <sean.j.christopherson@intel.com>
>>
>> When an OOM event occurs, all pages associated with an enclave will need
>> to be freed, including pages that are not currently tracked by the
>> cgroup LRU lists.
>
> What are "cgroup LRU lists"?
>
Will reword it. At them moment there is only one global sgx_epc_lru_lists.
>>
>> Add a new "unreclaimable" list to the sgx_epc_lru_lists struct and
>> update the "sgx_record/drop_epc_pages()" functions for adding/removing
>> VA and SECS pages to/from this "unreclaimable" list.
>
> Sorry I don't follow the logic between the two paragraphs.
>
> What is the exact problem?  How does the new "unreclaimable" list solve  
> the
> problem?
>
>
Currently they are not tracked in a list managed by the ksgxd (future  
cgroup worker). So add a list to track them.
Thanks
Haitao
