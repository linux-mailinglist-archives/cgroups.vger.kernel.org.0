Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8278D64107B
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 23:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbiLBWRl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 17:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiLBWRh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 17:17:37 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DD02721;
        Fri,  2 Dec 2022 14:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670019457; x=1701555457;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=woJvw+26RYRp5fwYNc0dyE37E+dcjcSWCS7ZFowb7NY=;
  b=X2xtfO+TIVNNuxP1SyuVsbQa+6NVlQvN3eVgHqY5D5392IFpqYHUBTnq
   MlbfPlwtXm3BMmGv7RkzSqBhD+cO6P9l0ppJHtSkHzQwcLg6u35ucIFVy
   WkES56pdMBhl9AN0E3KKCNQEoaCUv8IKYSykDJEEKItlYyF/T4ItxsEL7
   iImSSVD+W0QKTA44E1tu0KEWkygp2rFEpiW9AaViADhwOmmYAQLpkhGno
   mMBULPjPYKW8c2GgflXmDItYj83HGtlbCKDQGBlGlUEdVKk8mlh4Jjd0d
   jZhR2t7+ohKNk/pe+E9VJrbcuOO4H7MKssECUXhF013IeB1c/UT5m0fs9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="314764568"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="314764568"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 14:17:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="677752478"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="677752478"
Received: from kcaskeyx-mobl1.amr.corp.intel.com (HELO [10.251.1.207]) ([10.251.1.207])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 14:17:34 -0800
Message-ID: <307b43aa5908c489913110287044e611f574db0a.camel@linux.intel.com>
Subject: Re: [PATCH v2 01/18] x86/sgx: Call cond_resched() at the end of
 sgx_reclaim_pages()
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, jarkko@kernel.org,
        dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
Date:   Fri, 02 Dec 2022 14:17:33 -0800
In-Reply-To: <746adf31-e70c-e32d-a35d-72d352af613b@intel.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
         <20221202183655.3767674-2-kristen@linux.intel.com>
         <37de083d-a63b-b2ff-d00a-e890a1ba5eea@intel.com>
         <da690a45a36038399c63ddac8f0efed9872ec13e.camel@linux.intel.com>
         <746adf31-e70c-e32d-a35d-72d352af613b@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 2022-12-02 at 13:45 -0800, Dave Hansen wrote:
> On 12/2/22 13:37, Kristen Carlson Accardi wrote:
> > > > +static void sgx_reclaim_pages(void)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__sgx_reclaim_pages();
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cond_resched();
> > > > +}
> > > Why bother with the wrapper?=C2=A0 Can't we just put cond_resched() i=
n
> > > the
> > > existing sgx_reclaim_pages()?
> > Because sgx_reclaim_direct() needs to call sgx_reclaim_pages() but
> > not
> > do the cond_resched(). It was this or add a boolean or something to
> > let
> > caller's opt out of the resched.
>=20
> Is there a reason sgx_reclaim_direct() *can't* or shouldn't call
> cond_resched()?

Yes, it is due to performance concerns. It is explained most succinctly
by Reinette here:

https://lore.kernel.org/linux-sgx/a4eb5ab0-bf83-17a4-8bc0-a90aaf438a8e@inte=
l.com/

