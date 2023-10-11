Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595D37C58D1
	for <lists+cgroups@lfdr.de>; Wed, 11 Oct 2023 18:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjJKQE7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Oct 2023 12:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjJKQE6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Oct 2023 12:04:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15079D;
        Wed, 11 Oct 2023 09:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697040296; x=1728576296;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=inxQ3IranDcT46Lz+YqsdFYxNjUb8dv9j72WAW4wQlI=;
  b=m27ZUF+o1gWw7R+i6U3fDCvmJeyvJwQFcnWSUSNK+SoR3wWWPdlDfwai
   jmb7ppkSV6aH+Np7wroDCs3cdv18De6aWVim8N1v7GXR480/sIv2x61Q4
   +DixMdzCB9MLPZ8DWYqHvzWDpCPafd5XCIJ8VZJSdfTs2v343weuu5ttO
   C+FK1ukKrFAAUqER3+ysnkTgvdo/dbeN0DyZSDKX6i+S936TwNA8oEuk0
   W7TCwOd3U6yrCIjgrxkYybmI171qYQUNgqHBPDpVvJTfNqBeV9hhdszwz
   YWEVKBVqBylnV00HXcJMYk8UWgGp/AVEDxcdVepe3ibL7JmCeng7io+DS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="451193463"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="451193463"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 09:04:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="877736596"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="877736596"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 11 Oct 2023 09:04:54 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Mehta, Sohil" <sohil.mehta@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Zhang, Bo" <zhanb@microsoft.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-13-haitao.huang@linux.intel.com>
 <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
 <op.2ckqmgs9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <fc6aa778ddbde9536cafe48b847cf6c45b640ea4.camel@intel.com>
 <op.2ckr5yetwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <badbe0da60a2b35e8eace98714c6f7d4bcd6f202.camel@intel.com>
 <op.2cly3ffmwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <8593359034d9173be5efd9c055ea782e44fbcdad.camel@intel.com>
Date:   Wed, 11 Oct 2023 11:04:53 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2cnqyfdzwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <8593359034d9173be5efd9c055ea782e44fbcdad.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 10 Oct 2023 19:31:19 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Tue, 2023-10-10 at 12:05 -0500, Haitao Huang wrote:
>> On Mon, 09 Oct 2023 21:12:27 -0500, Huang, Kai <kai.huang@intel.com>  
>> wrote:
>>
>> >
>> > > > > >
>> > > > > Later the hosting process could migrated/reassigned to another
>> > > cgroup?
>> > > > > What to do when the new cgroup is OOM?
>> > > > >
>> > > >
>> > > > You addressed in the documentation, no?
>> > > >
>> > > > +Migration
>> > > > +---------
>> > > > +
>> > > > +Once an EPC page is charged to a cgroup (during allocation), it
>> > > > +remains charged to the original cgroup until the page is released
>> > > > +or reclaimed.  Migrating a process to a different cgroup doesn't
>> > > > +move the EPC charges that it incurred while in the previous  
>> cgroup
>> > > > +to its new cgroup.
>> > >
>> > > Should we kill the enclave though because some VA pages may be in  
>> the
>> > > new
>> > > group?
>> > >
>> >
>> > I guess acceptable?
>> >
>> > And any difference if you keep VA/SECS to unreclaimabe list?
>>
>> Tracking VA/SECS allows all cgroups, in which an enclave has allocation,
>> to identify the enclave following the back pointer and kill it as  
>> needed.
>>
>> > If you migrate one
>> > enclave to another cgroup, the old EPC pages stay in the old cgroup
>> > while the
>> > new one is charged to the new group IIUC.
>> >
>> > I am not cgroup expert, but by searching some old thread it appears  
>> this
>> > isn't a
>> > supported model:
>> >
>> > https://lore.kernel.org/lkml/YEyR9181Qgzt+Ps9@mtj.duckdns.org/
>> >
>>
>> IIUC it's a different problem here. If we don't track the allocated VAs  
>> in
>> the new group, then the enclave that spans the two groups can't be  
>> killed
>> by the new group. If so, some enclave could just hide in some small  
>> group
>> and never gets killed but keeps allocating in a different group?
>>
>
> I mean from the link above IIUC migrating enclave among different  
> cgroups simply
> isn't a supported model, thus any bad behaviour isn't a big concern in  
> terms of
> decision making.

If we leave some pages in a cgroup unkillable, we are in the same  
situation of not able to enforce a cgroup limit as that we are are in if  
we don't kill VMs for lower limits.

I think not supporting migration of pages between cgroups should not leave  
a gap for enforcement just like we don't want to have an enforcement gap  
if we let VMs to hold pages once it is launched.

Haitao
