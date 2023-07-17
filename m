Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4334375669A
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 16:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjGQOj3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 10:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjGQOj2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 10:39:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340171B6;
        Mon, 17 Jul 2023 07:39:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C688461070;
        Mon, 17 Jul 2023 14:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAB7C433C7;
        Mon, 17 Jul 2023 14:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689604766;
        bh=jQupSR0cXaId81B1Mtbxu7kk9Li8dlHjg4WKD/ovjs0=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=A9NGmVEsJX3Q0g0VVdhcmbnI6LA5zdNI75Kr/PbREnqbsfYEgd3TMgoBSDx07rAPo
         claZfcAgKGqqjSbGrRHCRymlCCP7DI7Lri2tjqxlrN0h2sxw6kO+aknAg8oafQpH33
         cr49Eaae8sEDtjQFPCYxgLsqym2U5TfuHbqS0aNCZR9OebxfJGkozc1QyoDysBzq0U
         Xm5cHXOR7aV+dXTGTEF0mxUbKhzVrUK+EpPIlSoqClWYzGeQhxSen5xVxm9gDAZUXK
         6RLgAoZ50mZhSl16QJmWDzRaKcBBmPo4y5FhZIhOzK0FKqsOjnIUy9AG8vPXFVVsmG
         eA++hXcIFxnlQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Jul 2023 14:39:21 +0000
Message-Id: <CU4IWFX753SR.2X9WTBXIHJKBV@seitikki>
Cc:     <kai.huang@intel.com>, <reinette.chatre@intel.com>,
        "Kristen Carlson Accardi" <kristen@linux.intel.com>,
        <zhiquan1.li@intel.com>, <seanjc@google.com>
Subject: Re: [PATCH v3 03/28] x86/sgx: Add 'struct sgx_epc_lru_lists' to
 encapsulate lru list(s)
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <cgroups@vger.kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
X-Mailer: aerc 0.14.0
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
 <20230712230202.47929-4-haitao.huang@linux.intel.com>
 <CU4GHCJTRKLZ.1RK23NWPHJGNI@seitikki>
 <op.17794m01wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.17794m01wjvjmi@hhuan26-mobl.amr.corp.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon Jul 17, 2023 at 1:23 PM UTC, Haitao Huang wrote:
> On Mon, 17 Jul 2023 07:45:36 -0500, Jarkko Sakkinen <jarkko@kernel.org> =
=20
> wrote:
>
> > On Wed Jul 12, 2023 at 11:01 PM UTC, Haitao Huang wrote:
> >> From: Kristen Carlson Accardi <kristen@linux.intel.com>
> >>
> >> Introduce a data structure to wrap the existing reclaimable list
> >> and its spinlock in a struct to minimize the code changes needed
> >> to handle multiple LRUs as well as reclaimable and non-reclaimable
> >> lists. The new structure will be used in a following set of patches to
> >> implement SGX EPC cgroups.
> >>
> >> The changes to the structure needed for unreclaimable lists will be
> >> added in later patches.
> >>
> >> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> >> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> >> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> >> Cc: Sean Christopherson <seanjc@google.com>
> >>
> >> V3:
> >> Removed the helper functions and revised commit messages
> >> ---
> >>  arch/x86/kernel/cpu/sgx/sgx.h | 17 +++++++++++++++++
> >>  1 file changed, 17 insertions(+)
> >>
> >> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h =20
> >> b/arch/x86/kernel/cpu/sgx/sgx.h
> >> index f6e3c5810eef..77fceba73a25 100644
> >> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> >> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> >> @@ -92,6 +92,23 @@ static inline void *sgx_get_epc_virt_addr(struct =
=20
> >> sgx_epc_page *page)
> >>  	return section->virt_addr + index * PAGE_SIZE;
> >>  }
> >>
> >> +/*
> >> + * This data structure wraps a list of reclaimable EPC pages, and a =
=20
> >> list of
> >> + * non-reclaimable EPC pages and is used to implement a LRU policy =
=20
> >> during
> >> + * reclamation.
> >> + */
> >> +struct sgx_epc_lru_lists {
> >> +	/* Must acquire this lock to access */
> >> +	spinlock_t lock;
> >
> > Isn't this self-explanatory, why the inline comment?
>
> I got a warning from the checkpatch script complaining this lock needs =
=20
> comments.

OK, cool, not a big deal.

BR, Jarkko
