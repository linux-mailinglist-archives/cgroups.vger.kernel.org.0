Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7DA7AF8C3
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 05:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjI0Dmv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Sep 2023 23:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjI0DgT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Sep 2023 23:36:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C3A16E90;
        Tue, 26 Sep 2023 18:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695779807; x=1727315807;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=B4V8UJd1VttRqhaNTVjHfz83p7oeLXpMegVFKtP+eNI=;
  b=UxZtPrFhuK534xBdP0e4E4LeFaPVRj7IZ8qoYMbOkc5f7KJguxJE2sCM
   O1kilq1J4ZIbAmyX/EPVdEDAdehmKkwWuSCJNr6g2PmSqkQjX1mUXomnZ
   Mva4bMlHKR171LZwDpFQymnGENaT/lcI7WK6bySsk/urxR803AeCg6XXQ
   hV5ZUAhk2NBxGLRkw3oe/1tn2WGIhtGrnu51l5dN7WaE/sMHivf7Q23O0
   pjml3dhCCltjIv/Uac334GapizwZkQMkyCZbSmOzlw7BzS0esBiyIpDbH
   2vFX6VTVLIbs0swVKuiLWQq4bEkHVWbZZ1dXPSFgCNZoSftmN0W6E+EQE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="384488449"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="384488449"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 18:56:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="784156380"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="784156380"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 26 Sep 2023 18:56:44 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Jarkko Sakkinen" <jarkko@kernel.org>, dave.hansen@linux.intel.com,
        tj@kernel.org, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com
Cc:     zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
        zhanb@microsoft.com, anakrish@microsoft.com,
        mikko.ylinen@linux.intel.com, yangjie@microsoft.com
Subject: Re: [PATCH v5 01/18] cgroup/misc: Add per resource callbacks for CSS
 events
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-2-haitao.huang@linux.intel.com>
 <CVS5XFKKTTUZ.XRMYK1ADHSPG@suppilovahvero>
 <op.2buytfetwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <CVSVH3ARQBRC.1QUTEQE3YNN5T@qgv27q77ld-mac>
 <CVSVJ8DYAME8.SMTH7VYG7ER@qgv27q77ld-mac>
Date:   Tue, 26 Sep 2023 20:56:43 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2bwqct0rwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <CVSVJ8DYAME8.SMTH7VYG7ER@qgv27q77ld-mac>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 26 Sep 2023 08:13:18 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

...
>> > >>  /**
>> > >> @@ -410,7 +429,14 @@ misc_cg_alloc(struct cgroup_subsys_state
>> > >> *parent_css)
>> > >>   */
>> > >>  static void misc_cg_free(struct cgroup_subsys_state *css)
>> > >>  {
>> > >> -	kfree(css_misc(css));
>> > >> +	struct misc_cg *cg = css_misc(css);
>> > >> +	enum misc_res_type i;
>> > >> +
>> > >> +	for (i = 0; i < MISC_CG_RES_TYPES; i++)
>> > >> +		if (cg->res[i].free)
>> > >> +			cg->res[i].free(cg);
>> > >> +
>> > >> +	kfree(cg);
>> > >>  }
>> > >>
>> > >>  /* Cgroup controller callbacks */
>> > >> --
>> > >> 2.25.1
>> > >
>> > > Since the only existing client feature requires all callbacks,  
>> should
>> > > this not have that as an invariant?
>> > >
>> > > I.e. it might be better to fail unless *all* ops are non-nil (e.g.  
>> to
>> > > catch issues in the kernel code).
>> > >
>> >
>> > These callbacks are chained from cgroup_subsys, and they are defined
>> > separately so it'd be better follow the same pattern.  Or change  
>> together
>> > with cgroup_subsys if we want to do that. Reasonable?
>>
>> I noticed this one later:
>>
>> It would better to create a separate ops struct and declare the instance
>> as const at minimum.
>>
>> Then there is no need for dynamic assigment of ops and all that is in
>> rodata. This is improves both security and also allows static analysis
>> bit better.
>>
>> Now you have to dynamically trace the struct instance, e.g. in case of
>> a bug. If this one done, it would be already in the vmlinux.
>I.e. then in the driver you can have static const struct declaration
> with *all* pointers pre-assigned.
>
> Not sure if cgroups follows this or not but it is *objectively*
> better. Previous work is not always best possible work...
>

IIUC, like vm_ops field in vma structs. Although function pointers in  
vm_ops are assigned statically, but you still need dynamically assign  
vm_ops for each instance of vma.

So the code will look like this:

if (parent_cg->res[i].misc_ops && parent_cg->res[i].misc_ops->alloc)
{
...
}

I don't see this is the pattern used in cgroups and no strong opinion  
either way.

TJ, do you have preference on this?

Thanks
Haitao
