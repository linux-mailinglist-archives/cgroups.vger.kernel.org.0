Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6747CD33B
	for <lists+cgroups@lfdr.de>; Wed, 18 Oct 2023 06:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbjJREuY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Oct 2023 00:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjJREt7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Oct 2023 00:49:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDBD55B2;
        Tue, 17 Oct 2023 21:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697604098; x=1729140098;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=F/dSfCnfGZ0vy8R6NzqQ9H0Paj53OwpGh0/vX+zt4EU=;
  b=l+Nei83eiXQqaeLM/51Ss2RoqbJMGj0GhxQd60bDHe1wHLgDuYUbQ14k
   ddVktWDlsIHgLNYBedZ8g8XoKNaY3LUMiDL3gQVuJ6ak6m9iPdydcuVTY
   yNZSVUkLZcmIXYaEk8sMAtBcwoLehj/JcGbGmaa2iFTEif8qUl52KyzBp
   t3wExoaLZGWk3HzxodciPgyeSvBH1IA1kkXuQE43YvWjhI9EZS46la0Ks
   hDL9AYjZOn2hagpTqEED5LBHKGJDEhIJQWmRhVo37xxETy/Yq8irdfrXL
   jRlaCLM0xsZB9dWuxiEDoq5XNYhKMYLiehWcGp79PEDb5drspVt4WfxBr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="383158307"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="383158307"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 21:39:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="791453312"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="791453312"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.92])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 17 Oct 2023 21:39:27 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     =?iso-8859-15?Q?Michal_Koutn=FD?= <mkoutny@suse.com>
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
References: <op.2clydbf8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <631f34613bcc8b5aa41cf519fa9d76bcd57a7650.camel@intel.com>
 <op.2cpecbevwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <aa404549c7e292dd2ec93a5e6a8c9d6d880c06b3.camel@intel.com>
 <op.2cxatlafwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <35a7fde056037a40b3b4b170e2ecd45bf8c4ba9f.camel@intel.com>
 <op.2cxmq7c2wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <915907d56861ef4aa7f9f68e0eb8d136a60bee39.camel@intel.com>
 <op.2cyma0e9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <6lrq4xmk42zteq6thpyah7jy25rmvkp7mqxtll6sl7z62m7n4m@vrbbedtgxeq4>
 <hl3elk273qrxqfajgn6izxwx2kkjq3osrbbtf77pvwcxvqy225@ryev3txohsm7>
Date:   Tue, 17 Oct 2023 23:39:27 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: Quoted-Printable
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2cztv1bewjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <hl3elk273qrxqfajgn6izxwx2kkjq3osrbbtf77pvwcxvqy225@ryev3txohsm7>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 17 Oct 2023 14:13:22 -0500, Michal Koutn=FD <mkoutny@suse.com> w=
rote:

> On Tue, Oct 17, 2023 at 08:54:48PM +0200, Michal Koutn=FD  =

> <mkoutny@suse.com> wrote:
>> Is this distinction between preemptability of EPC pages mandated by t=
he
>> HW implementation? (host/"process" enclaves vs VM enclaves) Or do hav=
e
>> users an option to lock certain pages in memory that yields this
>> difference?
>
> (After skimming Documentation/arch/x86/sgx.rst, Section "Virtual EPC")=

>
> Or would these two types warrant also two types of miscresource? (To
> deal with each in own way.)

They are from the same bucket of HW resource so I think it's more suitab=
le  =

to be one resource type. Otherwise need to policy to dividing the  =

capacity, etc. And it is still possible in future vEPC become reclaimabl=
e.

My current thinking is we probably can get away with non-preemptive  =

max_write for enclaves too. See my other reply.

Thanks
Haitao
