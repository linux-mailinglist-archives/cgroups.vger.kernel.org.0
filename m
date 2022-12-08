Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02A56472C4
	for <lists+cgroups@lfdr.de>; Thu,  8 Dec 2022 16:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLHPWV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Dec 2022 10:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiLHPVw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Dec 2022 10:21:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0D53C6ED;
        Thu,  8 Dec 2022 07:21:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F16361F7E;
        Thu,  8 Dec 2022 15:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A86C433B5;
        Thu,  8 Dec 2022 15:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512909;
        bh=tVhThTBTlto5XgoPkDUpcJfWLSIca0Vm8CQvc7flH4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BCxpw+coCm32MFSOsv6tLA547eDwyk4iQhTiUW/Ytxds1Zu2n21wyNNnkRPAo/Ldt
         A2P2emB8IohSGVOuAZDyQ3onEcJTxkkXJcOUswbVaOZuAxfoKxx65R9yLJgsopJBkZ
         EwvrLquzFwnulvZ2qde9ZHEHmvbnfUEyxE74AIclMW5UI7Du9BESExsk5brwHxJfbL
         8Y+SR98pX/6rtfEV3yck316uUZVBoJNwGRgB+XSuud9/61/BzRfGXC5Jq1NOT3RZVX
         yWMu2AF2a1wNGB3z5CI1Ho5arosZAu8/JM9KpaUyKdUMN81d+MfZzdj22UrUNsPqWI
         xoHky3O1Tw7uQ==
Date:   Thu, 8 Dec 2022 15:21:44 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v2 14/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Message-ID: <Y5IBCOuF8X7jEK3+@kernel.org>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-15-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202183655.3767674-15-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Dec 02, 2022 at 10:36:50AM -0800, Kristen Carlson Accardi wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Introduce the OOM path for killing an enclave with the reclaimer
> is no longer able to reclaim enough EPC pages. Find a victim enclave,
> which will be an enclave with EPC pages remaining that are not
> accessible to the reclaimer ("unreclaimable"). Once a victim is
> identified, mark the enclave as OOM and zap the enclaves entire
> page range. Release all the enclaves resources except for the
> struct sgx_encl memory itself.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>

Why this patch is dependent of all 13 patches before it?

Looks like something that is orthogonal to cgroups and could be
live by its own. At least it probably does not require all of
those patches, or does it?

Even without cgroups it would make sense to killing enclaves if
reclaimer gets stuck.

BR, Jarkko
