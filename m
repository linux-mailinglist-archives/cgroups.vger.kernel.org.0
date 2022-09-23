Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A936B5E7B2A
	for <lists+cgroups@lfdr.de>; Fri, 23 Sep 2022 14:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiIWMwP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Sep 2022 08:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiIWMwO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Sep 2022 08:52:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78005128A0D;
        Fri, 23 Sep 2022 05:52:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1378C61B83;
        Fri, 23 Sep 2022 12:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7DCC433C1;
        Fri, 23 Sep 2022 12:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663937532;
        bh=dyFwuPI8nAiWa2PCvqNDg4TRnPGIRnPb/48dH0S+ycU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UHyAyizWcDm5F8vFKzB+NUJxPhn+P4LLK8HMa9sPb7dyF72IiA0jLonx49XBNIL19
         +u1awv2DDm8jiRbWj2FDv8yYZ/4HduenQtxyCtUPspfANTtEfOXKO0e1FZCoX5zjLR
         N1aStGHm+IMHCHmPpDE3EejhcsKwn0DN2t1j64OuOoQbjqTKYdkUlGbnU59T/YwCvo
         azxTnT0u/gpNI7x4zr8JjkXGEW0yTxklnOjWCVrJpFve9JDqa189PuCnxmUudz0+E7
         0d+GQOKLg6wU5Z+vP93ktmMvv2KWpGiRYYYtPRX9Kiy5oT/MZFCJseL/MDxMYhugI5
         TM7c/e+rWP9HQ==
Date:   Fri, 23 Sep 2022 15:52:08 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [RFC PATCH 03/20] x86/sgx: Track owning enclave in VA EPC pages
Message-ID: <Yy2r+MN28I54R9an@kernel.org>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
 <20220922171057.1236139-4-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922171057.1236139-4-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 22, 2022 at 10:10:40AM -0700, Kristen Carlson Accardi wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> In order to fully account for an enclave's EPC page usage, store
> the owning enclave of a VA EPC page.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>

Why this change fully accounts enclave's EPC page usage?

BR, Jarkko
