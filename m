Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F37D5E7ADE
	for <lists+cgroups@lfdr.de>; Fri, 23 Sep 2022 14:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiIWMfb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Sep 2022 08:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiIWMfa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Sep 2022 08:35:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B71B26568;
        Fri, 23 Sep 2022 05:35:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F72EB830BB;
        Fri, 23 Sep 2022 12:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABEEC433C1;
        Fri, 23 Sep 2022 12:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663936525;
        bh=3r2wiqPJEGMQeTatuC93iDIV1398/9COo5jylaVOY+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E+EN5df202vHqXLDYSVC1uhaLfC6/J7KoA4fwMzFZ61yHAcozUlJ+pBWfg3QRN1Xp
         ueGwNx7KZEKAyXTv6hmUdHPXH5jlRBnpRNaorl2tqexCc+FOJr6kH97LotQKa1qdA0
         o09nCtFBEcazUAFcbsj5tb4usF6b2YIVU/z/g3SXzZwPxBsPolXNPsiSW1Y2sPnTgB
         LZyeExXwHZNC8OSrSd+pN+h5jjanirgpVIINjhYpFkKP2WRTVHmOxtBD0ql32GXAzl
         n1tv6ua+1yFAgX4IWunnF8Z3Bt17Hwo2azTFSvT5HWFx4IQ6KAhynzmUn12coRCsHz
         bja1m1pDoBorg==
Date:   Fri, 23 Sep 2022 15:35:21 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [RFC PATCH 01/20] x86/sgx: Call cond_resched() at the end of
 sgx_reclaim_pages()
Message-ID: <Yy2oCRfLrePCWjx7@kernel.org>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
 <20220922171057.1236139-2-kristen@linux.intel.com>
 <Yy2naAZfiAyP5H/a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy2naAZfiAyP5H/a@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 23, 2022 at 03:32:43PM +0300, Jarkko Sakkinen wrote:
> On Thu, Sep 22, 2022 at 10:10:38AM -0700, Kristen Carlson Accardi wrote:
> > From: Sean Christopherson <sean.j.christopherson@intel.com>
> > 
> > Move the invocation of post-reclaim cond_resched() from the callers of
> > sgx_reclaim_pages() into the reclaim path itself.   sgx_reclaim_pages()
> > is always called in a loop and is always followed by a call to
> > cond_resched().  This will hold true for the EPC cgroup as well, which
> > adds even more calls to sgx_reclaim_pages() and thus cond_resched().
> 
> This would be in my opinion better:
> 
> "
> In order to avoid repetion of cond_sched() in ksgxd() and
> sgx_alloc_epc_page(), move the call inside sgx_reclaim_pages().
> 
> This will hold true for the EPC cgroup as well, which adds more
> call sites sgx_reclaim_pages().
> "
> 
> This way it is dead obvious and is better description because
> it enumerates the consequences (i.e. call sites).

Forgot 3rd call site: sgx_reclaim_direct(), which is used by
SGX2 ioctls. The call sites of sgx_reclaim_direct() do not
call cond_resched(). You should address why adding this call
to those flows is fine.

BR, Jarkko

