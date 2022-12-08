Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB9B646C0E
	for <lists+cgroups@lfdr.de>; Thu,  8 Dec 2022 10:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiLHJmw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Dec 2022 04:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiLHJmu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Dec 2022 04:42:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F20645A26;
        Thu,  8 Dec 2022 01:42:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14C2861E38;
        Thu,  8 Dec 2022 09:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D33C433D6;
        Thu,  8 Dec 2022 09:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670492568;
        bh=ILluYFk8ruA2A/bk1cxa/lIB2gKjWFI9cFl4oDrdxrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oebvmlOr+e8UZbD4fsAMJ+eaZsraR4ciDGHpSy7JExefAdCV+POEWLIEKVMSdLfkG
         886wTMRPp2KywfgGwFTS/T2cDT8iD23b3nmJ+aZ//9OnYcxuJd3K3E+oFvdBdtSALO
         tOpLq1OeKSqVey2U94ENeeielKU7B6SLfHycwu06uKRJEXFj84O8nnsgd0laEFImJ2
         ZRRFQz6EDUBAliCjYW2Rz8U1w8gjCFBgWGMFvuCy0iwS4GYJ+bV3ahwnYVVcw3ERdy
         UlK6BfFwQkSXjmZHvr8aWsVZa16Eoi1WZ6mC4AUdEDF4VUcSPI3vaRIPRFX3UkhmTA
         jaIF16GyY5FOQ==
Date:   Thu, 8 Dec 2022 09:42:44 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        zhiquan1.li@intel.com, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v2 11/18] x86/sgx: Prepare for multiple LRUs
Message-ID: <Y5GxlPuH9b7B5AEy@kernel.org>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-12-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202183655.3767674-12-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Dec 02, 2022 at 10:36:47AM -0800, Kristen Carlson Accardi wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Add sgx_can_reclaim() wrapper so that in a subsequent patch, multiple LRUs
> can be used cleanly.

Nit: Patch is the transient form of a change. Once a change has been
committed, it is a commit.

Further, you should instead explain why subsequent changes require
sgx_can_reclaim() wrapper, than just claim it without argument.

Alternatively, you can consider squashing this to the subsequent
patch, which makes use of the wrapper.

BR, Jarkko
