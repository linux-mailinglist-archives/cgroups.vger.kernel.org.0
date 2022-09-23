Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0125E7AD5
	for <lists+cgroups@lfdr.de>; Fri, 23 Sep 2022 14:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiIWMdH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Sep 2022 08:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiIWMcr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Sep 2022 08:32:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899AC1F61A;
        Fri, 23 Sep 2022 05:32:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E74866240F;
        Fri, 23 Sep 2022 12:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E6BC433C1;
        Fri, 23 Sep 2022 12:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663936364;
        bh=Fev/xAbFy6dCF9ucIYtx19kMsRsV2B9GzILLEMxl7KU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8VrLusZ5uePvQXxY5Mcd7BGi1YUArVfDQPr1NkwhErQ0EigpIyVeNCaC68a2fuxI
         dcPh5rTB8eooSjAoj0sQvmq6Y10oempGoRFrFXZJDPcPCIQvbIggRJS+16m0upMLdD
         /J9yLiwnUENhZ8NoRmXgZ9Ann7bcrOjt4O6+Qi8U/gj4IgGqmzWqpMTbUOAz6Myx/P
         666EfrDI/guIroOhYeWlaxz1Vbvy0ZgvKxc1zvlJV7Fm+bGmx6H+e3t/eRPv0gdZ0z
         RwXkofn7VRGdJpGtwKU6sCGr2zyYf6m8P+SSnTyDnbZSf22aIQk8gGNKBcDGXpKQRC
         n1wa9E/VBs53w==
Date:   Fri, 23 Sep 2022 15:32:40 +0300
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
Message-ID: <Yy2naAZfiAyP5H/a@kernel.org>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
 <20220922171057.1236139-2-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922171057.1236139-2-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 22, 2022 at 10:10:38AM -0700, Kristen Carlson Accardi wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Move the invocation of post-reclaim cond_resched() from the callers of
> sgx_reclaim_pages() into the reclaim path itself.   sgx_reclaim_pages()
> is always called in a loop and is always followed by a call to
> cond_resched().  This will hold true for the EPC cgroup as well, which
> adds even more calls to sgx_reclaim_pages() and thus cond_resched().

This would be in my opinion better:

"
In order to avoid repetion of cond_sched() in ksgxd() and
sgx_alloc_epc_page(), move the call inside sgx_reclaim_pages().

This will hold true for the EPC cgroup as well, which adds more
call sites sgx_reclaim_pages().
"

This way it is dead obvious and is better description because
it enumerates the consequences (i.e. call sites).

BR, Jarkko

