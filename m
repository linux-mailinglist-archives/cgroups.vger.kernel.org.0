Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219AE5E7BD5
	for <lists+cgroups@lfdr.de>; Fri, 23 Sep 2022 15:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiIWN3O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Sep 2022 09:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiIWN3M (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Sep 2022 09:29:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A9713BCCD;
        Fri, 23 Sep 2022 06:29:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B53FB62206;
        Fri, 23 Sep 2022 13:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42B8C433C1;
        Fri, 23 Sep 2022 13:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663939750;
        bh=7GWKDuhtbW6r2KpVH7DUjRqYL50U4cTrwdK0ewzhHyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PF8GTxss/DpOVvSfm+7chSANkuylKwulE1LNRSBPBiW14DpRbT7vPLrg6k4lMMr+L
         Z0Xs2Lb4q4kS9mHeFZkRDnHi2UBksryOXNpcR9i2WD7OXqy7NEdu7M/VNYGhOJdX5T
         UWDglCD4n5vVQ1P4bdGE9UmNlC4zNQRfB3L15FvFvf9RmZVEKWGIVkJb9GB36Ulc7X
         qS3dP/aEMri9L0r0IjxWGdda/rpQDSLoZktYMD2KAItuJbaXBeKTnbLSLAjmjXFZOx
         2wLWLESfVZ1NPzxHg/Nk6eWw2PMBA26nT7zbAmFnln/39oy9FfDDDgUFyaiXjENOww
         vK8FKTsBYcdSQ==
Date:   Fri, 23 Sep 2022 16:29:06 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [RFC PATCH 05/20] x86/sgx: Introduce unreclaimable EPC page lists
Message-ID: <Yy20ov/Pcxo3tBSn@kernel.org>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
 <20220922171057.1236139-6-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922171057.1236139-6-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 22, 2022 at 10:10:42AM -0700, Kristen Carlson Accardi wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Add code to keep track of pages that are not tracked by the reclaimer
> in the LRU's "unreclaimable" list. When there is an OOM event and an
> enclave must be OOM killed, the EPC pages which are not tracked by
> the reclaimer can still be freed.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>

This could have some description of what is actually happening in
this patch.

BR, Jarkko
