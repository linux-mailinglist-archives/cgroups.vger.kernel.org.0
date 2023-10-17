Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335F17CC1FC
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 13:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjJQLtW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Oct 2023 07:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjJQLtW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Oct 2023 07:49:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211CEED;
        Tue, 17 Oct 2023 04:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697543361; x=1729079361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yC4cz3ihcA96cBD2ueuoEZVThf+uaD16uw3EeuzEiU8=;
  b=mfNxvWYYCfN3N40Rzt7Hg2goMqYMrjPrv8joUAymZNroJoksZamWW47T
   ojak8nHEEhIeeCktfEchI/gHc67O3zwBI3AEMtDMAyt+5/SPuUp+q94HZ
   jPJTCdH/U38VadNjeyilku81z6K6liEDw5BazufvnII72YwnrURJkVJw5
   t6DvUgKOLopi3bIp/QeXvBR2Lt8NLpNlKNzJqYgqCQjZenvRruJVqMJYB
   FKDAXa3+HDQqbRknfjr3mUR9l7TavIA8OEb8J6pmAGFuV+q6+Kg3f1asw
   KqVA7WJv55bdtZwwX05NT2396Zl1v3+yecx/fCHJUCoGAP7EitpO+7L76
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="365113163"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="365113163"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 04:49:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="785457902"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="785457902"
Received: from kkoning-desk.ger.corp.intel.com (HELO himmelriiki) ([10.249.37.197])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 04:49:13 -0700
Date:   Tue, 17 Oct 2023 14:49:04 +0300
From:   Mikko Ylinen <mikko.ylinen@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Bo Zhang <zhanb@microsoft.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Zhiquan1 Li <zhiquan1.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Message-ID: <ZS50sCxte6fz0iqv@himmelriiki>
References: <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
 <ZSSZaFrxvCvR1SOy@google.com>
 <06142144151da06772a9f0cc195a3c8ffcbc07b7.camel@intel.com>
 <1f7a740f3acff8a04ec95be39864fb3e32d2d96c.camel@intel.com>
 <op.2clydbf8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <631f34613bcc8b5aa41cf519fa9d76bcd57a7650.camel@intel.com>
 <op.2cpecbevwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <aa404549c7e292dd2ec93a5e6a8c9d6d880c06b3.camel@intel.com>
 <op.2cxatlafwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <ZS2r7-EAEovpV4BN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS2r7-EAEovpV4BN@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 16, 2023 at 02:32:31PM -0700, Sean Christopherson wrote:
> Genuinely curious, who is asking for EPC cgroup support that *isn't* running VMs?

People who work with containers: [1], [2]. 

> AFAIK, these days, SGX is primarily targeted at cloud.  I assume virtual EPC is
> the primary use case for an EPC cgroup.

The common setup is that a cloud VM instance with vEPC is created and then
several SGX enclave containers are run simultaneously on that instance. EPC
cgroups is used to ensure that each container gets their own share of EPC
(and any attempts to go beyond the limit is reclaimed and charged from
the container's memcg). The same containers w/ enclaves use case is
applicable to baremetal also, though.

As far as Kubernetes orchestrated containers are concerned, "in-place" resource
scaling is still in very early stages which means that the cgroups values are
adjusted by *re-creating* the container. The hierarchies are also built
such that there's no mix of VMs w/ vEPC and enclaves in the same tree.

Mikko

[1] https://lore.kernel.org/linux-sgx/20221202183655.3767674-1-kristen@linux.intel.com/T/#m6d1c895534b4c0636f47c2d1620016b4c362bb9b
[2] https://lore.kernel.org/linux-sgx/20221202183655.3767674-1-kristen@linux.intel.com/T/#m37600e457b832feee6e8346aa74dcff8f21965f8
