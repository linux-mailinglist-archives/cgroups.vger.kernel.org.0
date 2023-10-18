Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9117CE458
	for <lists+cgroups@lfdr.de>; Wed, 18 Oct 2023 19:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjJRRYY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Oct 2023 13:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjJRQZh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Oct 2023 12:25:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFD711D;
        Wed, 18 Oct 2023 09:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697646335; x=1729182335;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=3SzZhMSgWPufMQv3UDQZF8yioB50y/KqV65kuToF9No=;
  b=JgmRUzClX6MKH0AEVqBGTXpTtU7/rKrOw/bMSsiMHE9Tz5bt5FcU8kiE
   +vetL7brflYzmYNbgOqaO/9CCfRZs85bkDNMQvrvzSuIq7qmbb5sD239A
   MrxKtI4stKJtbvaAiGaCejVDd0+hicAPruhDD2bI7ZZnrVQ45DxBMsaVM
   KFTpMUubFMMsWJfSANPGHRAhvqEiVWA5/e5tyL6/KUQ6Iye7WVDEnv018
   enPnsS0iRtTm2PnRVjccyTonw0OjUpMhbipbxV6QHTXSQVPIVYhx/ty5C
   brp1J7+lPCQQOGXrhbDyvcNhc0AXdy05Zd/eGfsOf8Gsiqs4QyqZi8jCc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="366306231"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="366306231"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 09:25:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="756643245"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="756643245"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.92])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 18 Oct 2023 09:25:29 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Dave Hansen" <dave.hansen@intel.com>,
        =?iso-8859-15?Q?Michal_Koutn=FD?= <mkoutny@suse.com>
Cc:     "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Bo" <zhanb@microsoft.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
References: <op.2cxatlafwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <35a7fde056037a40b3b4b170e2ecd45bf8c4ba9f.camel@intel.com>
 <op.2cxmq7c2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <915907d56861ef4aa7f9f68e0eb8d136a60bee39.camel@intel.com>
 <op.2cyma0e9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <6lrq4xmk42zteq6thpyah7jy25rmvkp7mqxtll6sl7z62m7n4m@vrbbedtgxeq4>
 <op.2cztslnpwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <11413ca0-a8a9-4f73-8006-2e1231dbb390@intel.com>
 <op.2c0nt109wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <7a1a5125-9da2-47b6-ba0f-cf24d84df16b@intel.com>
 <yz44wukoic3syy6s4fcrngagurkjhe2hzka6kvxbajdtro3fwu@zd2ilht7wcw3>
Date:   Wed, 18 Oct 2023 11:25:28 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: Quoted-Printable
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2c0qkqrowjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <yz44wukoic3syy6s4fcrngagurkjhe2hzka6kvxbajdtro3fwu@zd2ilht7wcw3>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 18 Oct 2023 10:52:23 -0500, Michal Koutn=FD <mkoutny@suse.com> w=
rote:

> On Wed, Oct 18, 2023 at 08:37:25AM -0700, Dave Hansen  =

> <dave.hansen@intel.com> wrote:
>> 1. Admin sets a limit
>> 2. Enclave is created
>> 3. Enclave hits limit, allocation fails
>
> I was actually about to suggest reorganizing the series to a part
> implementing this simple limiting and a subsequent part with the recla=
im
> stuff for easier digestability.
>
>> Nothing else matters.
>
> If the latter part is an unncessary overkill, it's even better.
>

Ok. I'll take out max_write() callback and only implement non-preemptive=
  =

misc.max for EPC.
I can also separate OOEPC_killing enclaves out, which is not needed if w=
e  =

only block allocation at limit, no need killing one enclave to make spac=
e  =

for another. This will simplify a lot.

Thanks to all for your input!

Haitao
 =

