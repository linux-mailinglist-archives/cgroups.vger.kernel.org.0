Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D910A656504
	for <lists+cgroups@lfdr.de>; Mon, 26 Dec 2022 21:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiLZUoJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Dec 2022 15:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLZUoI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Dec 2022 15:44:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8503325EC;
        Mon, 26 Dec 2022 12:44:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4041FB80D68;
        Mon, 26 Dec 2022 20:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51726C433EF;
        Mon, 26 Dec 2022 20:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672087444;
        bh=VLhGkOHxbqetrgJSPLuZfKUGT1KN0pIDoxofw9mA2Jw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BaRZ3mCREa+kLUp5TDH7ap3HWYze/UUbPBAAOV501rVkFpg9IJfJfco0Mduf/PHuM
         WbmConD42iTDblIo9JtxYbuxDPU5LV969xNFTFJChhok3zLYN4OeG7Xh8XiSwbDDLq
         vFrxVIqMZU9AGAD/f1N5vbJsPUBuGgDPVdGNuv+w6DswNVS8v6JZItJmucQAi4BILf
         R9pBjahfOUYA9ib/VwrBG3df6NOyUcMYJ6isZYIyfjCS29DR4UU0RJf3ukanPAtPwd
         wjZUERuQRSJ4en+w/QHiEG/2bVBzhfMUrNPBsHyVpvLj1XLcpS8KRAoNi6F21B/S0Y
         Ru9W5pX2h0lYQ==
Date:   Mon, 26 Dec 2022 20:43:58 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        dave.hansen@linux.intel.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        zhiquan1.li@intel.com
Subject: Re: [PATCH v2 14/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Message-ID: <Y6oHjrLCbDzWh7nE@kernel.org>
References: <20221202183655.3767674-1-kristen@linux.intel.com>
 <20221202183655.3767674-15-kristen@linux.intel.com>
 <Y5IBCOuF8X7jEK3+@kernel.org>
 <cb5abce531c1b14118de419ba68c2a501b016873.camel@linux.intel.com>
 <e5aff02b-713c-ccd8-7211-d07ff6d7adb2@intel.com>
 <Y5duYxIHtSpK1qkj@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5duYxIHtSpK1qkj@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Dec 12, 2022 at 06:09:39PM +0000, Sean Christopherson wrote:
> On Fri, Dec 09, 2022, Dave Hansen wrote:
> > On 12/9/22 08:05, Kristen Carlson Accardi wrote:
> > > Aside from that though, I don't think that killing enclaves makes sense
> > > outside the context of cgroup limits. 
> > 
> > I think it makes a lot of sense in theory.  Whatever situation we get
> > into with a cgroup's EPC we can also get into with the whole system's EPC.
> > 
> > *But*, it's orders of magnitude harder to hit on the whole system.
> 
> ...
> 
> > If someone wants to extend this OOM support to system-wide EPC later, then go
> > ahead.  But, I don't think it makes a lot of sense to invert this series for
> > it.
> 
> +1 from the peanut gallery.  With VMM EPC oversubscription suport, no sane VMM
> will oversubscribe VEPC pages.  And for VA pages, supporting swap of VA pages is
> likely a more userspace-friendly approach if system-wide EPC OOM is a concern.

When swapping VA pages the topology of the VA page cache for swapped VA
pages is the main question. It is compromise between how long swap-in and
swap-out can take, and how generic solution it be, meaning how deep
hierarchies you want to build, or is just a flat list of parent VA pages
"good enough".

Also, there's the question whether it should be a global cache, per cgroup
and so forth.

Implementing any solution is not overly complicated. Locking in these
options is what puzzles me.

BR, Jarkko
