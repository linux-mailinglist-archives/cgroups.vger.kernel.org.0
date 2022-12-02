Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E51F641011
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 22:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbiLBVhK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 16:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbiLBVhJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 16:37:09 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D8AEF8B5;
        Fri,  2 Dec 2022 13:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670017028; x=1701553028;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=DguheD/f9S21J80UEfRyncUNc3fn53UTu3Kx4IOdBY8=;
  b=G79X/5G63TmqnfKDquhvGQOrH8AipiyBITvvHcsPWJdPDZTvjz77IBxy
   U0eEKzzpOTY2BuH8E2/yXGcZxWDcUqBngNn7Dziy3wgZ0CiGsZLkxdqpj
   M8a9UdLNpRvwhfelKiSm45ikQFl18gyGfyvj/CPABLk9mVC8YKti5AjGy
   sR6TJrVm2RWXxuiNJvioh624PdT51llIauxU6KaZ97TtjfaG6bonhI2ps
   vvbZEc475NIkYoGmIdI4W3gIxKElIwTHivRDndo3VVOnenSQNsylw+ctu
   vHI8LH7xHJ/m7BVdmiOBFBOC0lPPBVIafxlwHb+f7Ul/sktERMF4L7mDT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="316076195"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="316076195"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:37:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="974060170"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="974060170"
Received: from kcaskeyx-mobl1.amr.corp.intel.com (HELO [10.251.1.207]) ([10.251.1.207])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:37:06 -0800
Message-ID: <da690a45a36038399c63ddac8f0efed9872ec13e.camel@linux.intel.com>
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
Date:   Fri, 02 Dec 2022 13:37:05 -0800
In-Reply-To: <37de083d-a63b-b2ff-d00a-e890a1ba5eea@intel.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
         <20221202183655.3767674-2-kristen@linux.intel.com>
         <37de083d-a63b-b2ff-d00a-e890a1ba5eea@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 2022-12-02 at 13:33 -0800, Dave Hansen wrote:
> On 12/2/22 10:36, Kristen Carlson Accardi wrote:
> > From: Sean Christopherson <sean.j.christopherson@intel.com>
> >=20
> > In order to avoid repetition of cond_resched() in ksgxd() and
> > sgx_alloc_epc_page(), move the invocation of post-reclaim
> > cond_resched()
> > inside sgx_reclaim_pages(). Except in the case of
> > sgx_reclaim_direct(),
> > sgx_reclaim_pages() is always called in a loop and is always
> > followed
> > by a call to cond_resched().=C2=A0 This will hold true for the EPC
> > cgroup
> > as well, which adds even more calls to sgx_reclaim_pages() and thus
> > cond_resched(). Calls to sgx_reclaim_direct() may be performance
> > sensitive. Allow sgx_reclaim_direct() to avoid the cond_resched()
> > call by moving the original sgx_reclaim_pages() call to
> > __sgx_reclaim_pages() and then have sgx_reclaim_pages() become a
> > wrapper around that call with a cond_resched().
> >=20
> > Signed-off-by: Sean Christopherson
> > <sean.j.christopherson@intel.com>
> > Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> > Cc: Sean Christopherson <seanjc@google.com>
> > ---
> > =C2=A0arch/x86/kernel/cpu/sgx/main.c | 17 +++++++++++------
> > =C2=A01 file changed, 11 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/arch/x86/kernel/cpu/sgx/main.c
> > b/arch/x86/kernel/cpu/sgx/main.c
> > index 160c8dbee0ab..ffce6fc70a1f 100644
> > --- a/arch/x86/kernel/cpu/sgx/main.c
> > +++ b/arch/x86/kernel/cpu/sgx/main.c
> > @@ -287,7 +287,7 @@ static void sgx_reclaimer_write(struct
> > sgx_epc_page *epc_page,
> > =C2=A0 * problematic as it would increase the lock contention too much,
> > which would
> > =C2=A0 * halt forward progress.
> > =C2=A0 */
> > -static void sgx_reclaim_pages(void)
> > +static void __sgx_reclaim_pages(void)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sgx_epc_page *ch=
unk[SGX_NR_TO_SCAN];
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sgx_backing back=
ing[SGX_NR_TO_SCAN];
> > @@ -369,6 +369,12 @@ static void sgx_reclaim_pages(void)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0}
> > =C2=A0
> > +static void sgx_reclaim_pages(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__sgx_reclaim_pages();
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cond_resched();
> > +}
>=20
> Why bother with the wrapper?=C2=A0 Can't we just put cond_resched() in th=
e
> existing sgx_reclaim_pages()?

Because sgx_reclaim_direct() needs to call sgx_reclaim_pages() but not
do the cond_resched(). It was this or add a boolean or something to let
caller's opt out of the resched.

