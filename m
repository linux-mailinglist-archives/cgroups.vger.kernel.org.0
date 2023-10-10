Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741D47C023B
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 19:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjJJRHG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 13:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbjJJRGq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 13:06:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D4E10D5;
        Tue, 10 Oct 2023 10:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696957583; x=1728493583;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=xpxagVahSuuVfh54QbO0O0LxyEGgv5d6nUjRC7qUNxI=;
  b=dUnmCnnLcpJy+1ROY+fg+2z3L6jT81ICzo4ExJfOWEbDsUCyT1wh4V8d
   FpFAUR/UAzvRjtBaK4SF1Hc+LNcMRUe6XA/mRieVnVyFHc07Inasa1Nsk
   YoVcYDmzuntBf4m7WZZAKIBBxMAx/7LKGGV5ccYRz9/siGFBVBTHd1LT1
   pnumf8fS8jEzRfRD+SLqYRkgBTUr8OXkIqD7VGG2JvOOdGy2+9J/PciF0
   IWqiO4DtoPyhjaG5yILltzESVYIdloVTyUr1LD8WYUaXMvy8MJcPzbtZ8
   ntIv9+LeJx1HnAfi3ODdmKjThuhH2S+MG6dIHMJREHD02zXFsm0NdInFF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="450953603"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="450953603"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 10:06:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="819323024"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="819323024"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 10 Oct 2023 10:05:30 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "tj@kernel.org" <tj@kernel.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Zhang, Bo" <zhanb@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-13-haitao.huang@linux.intel.com>
 <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
 <op.2ckqmgs9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <fc6aa778ddbde9536cafe48b847cf6c45b640ea4.camel@intel.com>
 <op.2ckr5yetwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <badbe0da60a2b35e8eace98714c6f7d4bcd6f202.camel@intel.com>
Date:   Tue, 10 Oct 2023 12:05:29 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2cly3ffmwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <badbe0da60a2b35e8eace98714c6f7d4bcd6f202.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 09 Oct 2023 21:12:27 -0500, Huang, Kai <kai.huang@intel.com> wrote:

>
>> > > >
>> > > Later the hosting process could migrated/reassigned to another  
>> cgroup?
>> > > What to do when the new cgroup is OOM?
>> > >
>> >
>> > You addressed in the documentation, no?
>> >
>> > +Migration
>> > +---------
>> > +
>> > +Once an EPC page is charged to a cgroup (during allocation), it
>> > +remains charged to the original cgroup until the page is released
>> > +or reclaimed.  Migrating a process to a different cgroup doesn't
>> > +move the EPC charges that it incurred while in the previous cgroup
>> > +to its new cgroup.
>>
>> Should we kill the enclave though because some VA pages may be in the  
>> new
>> group?
>>
>
> I guess acceptable?
>
> And any difference if you keep VA/SECS to unreclaimabe list?

Tracking VA/SECS allows all cgroups, in which an enclave has allocation,  
to identify the enclave following the back pointer and kill it as needed.

> If you migrate one
> enclave to another cgroup, the old EPC pages stay in the old cgroup  
> while the
> new one is charged to the new group IIUC.
>
> I am not cgroup expert, but by searching some old thread it appears this  
> isn't a
> supported model:
>
> https://lore.kernel.org/lkml/YEyR9181Qgzt+Ps9@mtj.duckdns.org/
>

IIUC it's a different problem here. If we don't track the allocated VAs in  
the new group, then the enclave that spans the two groups can't be killed  
by the new group. If so, some enclave could just hide in some small group  
and never gets killed but keeps allocating in a different group?

Thanks
Haitao
