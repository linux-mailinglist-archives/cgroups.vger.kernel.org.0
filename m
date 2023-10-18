Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E217CE124
	for <lists+cgroups@lfdr.de>; Wed, 18 Oct 2023 17:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjJRP0X (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Oct 2023 11:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjJRP0V (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Oct 2023 11:26:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E8EFA;
        Wed, 18 Oct 2023 08:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697642780; x=1729178780;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=F6u+KBYcn7BYk4Z2evWe0eujHOmh6t8u43JwYuaW7sM=;
  b=TA0KoY+/vNeLGlzTqI+ZFfs7fuo5Yyppr7jVf7aG72+PEbgHK58gP1BD
   2C3AsAmW0Sd/uW8ZVJ+9iJiGdD6jtn1GkcXZnsaP6/KN2aZJOXK6N8zIn
   FNU6pNdBdnE8whVJrj0P5JOZTD3gD2xF63hw9nPOo00pz2ZWbOBUPSZKy
   u6rJ2ltQ61IB/AK/Ukr8RjsaKeH45KWsy060SubbJzt5Vh9UfyDqalOX5
   fTExhlJ1wZwg/Fo9jK92ADep4VNq+1yQLPsmJI8QH+iJJSmQwsJUdY8Wj
   XxDsBSCM8PUFJ9qas+rMmtESlyF9F1chuxl4ATsGA1zaHR2YJiW9Itq/t
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="366293753"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="366293753"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 08:26:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="756625348"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="756625348"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.92])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 18 Oct 2023 08:26:16 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     =?iso-8859-15?Q?Michal_Koutn=FD?= <mkoutny@suse.com>,
        "Dave Hansen" <dave.hansen@intel.com>
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
References: <1f7a740f3acff8a04ec95be39864fb3e32d2d96c.camel@intel.com>
 <op.2clydbf8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <631f34613bcc8b5aa41cf519fa9d76bcd57a7650.camel@intel.com>
 <op.2cpecbevwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <aa404549c7e292dd2ec93a5e6a8c9d6d880c06b3.camel@intel.com>
 <op.2cxatlafwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <35a7fde056037a40b3b4b170e2ecd45bf8c4ba9f.camel@intel.com>
 <op.2cxmq7c2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <915907d56861ef4aa7f9f68e0eb8d136a60bee39.camel@intel.com>
 <op.2cyma0e9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <6lrq4xmk42zteq6thpyah7jy25rmvkp7mqxtll6sl7z62m7n4m@vrbbedtgxeq4>
 <op.2cztslnpwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <11413ca0-a8a9-4f73-8006-2e1231dbb390@intel.com>
Date:   Wed, 18 Oct 2023 10:26:15 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2c0nt109wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <11413ca0-a8a9-4f73-8006-2e1231dbb390@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 18 Oct 2023 08:55:12 -0500, Dave Hansen <dave.hansen@intel.com>  
wrote:

> On 10/17/23 21:37, Haitao Huang wrote:
>> Yes we can introduce misc.reclaim to give user a knob to forcefully
>> reducing usage if that is really needed in real usage. The semantics
>> would make force-kill VMs explicit to user.
>
> Do any other controllers do something like this?  It seems odd.

Maybe not in sense of killing something. My understanding memory.reclaim  
does not necessarily invoke the OOM killer. But what I really intend to  
say is we can have a separate knob for user to express the need for  
reducing the current usage explicitly and keep "misc.max' non-preemptive  
semantics intact. When we implement that new knob, then we can define what  
kind of reclaim for that. Depending on vEPC implementation, it may or may  
not involve killing VMs. But at least that semantics will be explicit for  
user.

Thanks
Haitao
