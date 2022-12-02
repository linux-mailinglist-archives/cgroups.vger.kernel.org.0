Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E28664101A
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 22:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbiLBVkb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 16:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiLBVka (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 16:40:30 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3522AE5A8B;
        Fri,  2 Dec 2022 13:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670017230; x=1701553230;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=NuDVEcz+ZwrxpvyK1gNkgUCJxIW8h0yVGClVY+eE7s8=;
  b=T8Kd0PqA/x5Ex0q76P7Dk4IGJsKrWS0chB9dPU2MzD03rr0xga3o6/jX
   +il7IaGjLQ0aGSBMMhPsK3WFw8e9mUa7pU56knff+3227LhdcR8pKJ4M7
   yw+axMA6JMJsgSaBfN06+yp+/JQw8bWDF+SZD0l1BmBtLKL/BCr+gI5yN
   P3dq18srfRSnvsAov1IxYh7hSjD1Mn+CQrIc9L7ywHzPjrehpigcg6Yhy
   aPlmOs+eWCRV1CyT4jgnG0impu+yNf1jIKJNAdciFxhw1HDidxQ/Dna4m
   bFD9GszPkQWizhLrOxR06D1DtPS4kZp4jv/Qq/EPKb0vc+bSCXM2d8WCy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="317196856"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="317196856"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:40:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="595586009"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="595586009"
Received: from kcaskeyx-mobl1.amr.corp.intel.com (HELO [10.251.1.207]) ([10.251.1.207])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:40:27 -0800
Message-ID: <abfc00a2ab1d97f8081c696f78e2d0ced23902b4.camel@linux.intel.com>
Subject: Re: [PATCH v2 02/18] x86/sgx: Store struct sgx_encl when allocating
 new VA pages
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, jarkko@kernel.org,
        dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
Date:   Fri, 02 Dec 2022 13:40:26 -0800
In-Reply-To: <3a789b1c-4c70-158b-d764-daec141a5816@intel.com>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
         <20221202183655.3767674-3-kristen@linux.intel.com>
         <3a789b1c-4c70-158b-d764-daec141a5816@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 2022-12-02 at 13:35 -0800, Dave Hansen wrote:
> On 12/2/22 10:36, Kristen Carlson Accardi wrote:
> > When allocating new Version Array (VA) pages, pass the struct
> > sgx_encl
> > of the enclave that is allocating the page. sgx_alloc_epc_page()
> > will
> > store this value in the encl_owner field of the struct
> > sgx_epc_page. In
> > a later patch, VA pages will be placed in an unreclaimable queue,
> > and then when the cgroup max limit is reached and there are no more
> > reclaimable pages and the enclave must be oom killed, all the
> > VA pages associated with that enclave can be uncharged and freed.
>=20
> What does this have to do with the 'encl' that is being passed,
> though?
>=20
> In other words, why is this new sgx_epc_page-to-encl mapping needed
> for
> VA pages now, but it wasn't before?

When we OOM kill an enclave, we want to get rid of all the associated
VA pages too. Prior to this patch, there wasn't a way to easily get the
VA pages associated with an enclave.


