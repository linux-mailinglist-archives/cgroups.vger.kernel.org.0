Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B516CC6E6
	for <lists+cgroups@lfdr.de>; Tue, 28 Mar 2023 17:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjC1Pnw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 11:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjC1Pnh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 11:43:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C122111142;
        Tue, 28 Mar 2023 08:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FBBC61856;
        Tue, 28 Mar 2023 15:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76B9C433EF;
        Tue, 28 Mar 2023 15:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680018121;
        bh=bjTXX9yzs6ldEzyQm2t7OD6dEAou4tttEBMCj7d1qu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CaGmLRhSoe2tN/e+4Xm68kM9m9ONdejVT4hYPdtwJZHav25P4Glr1fKvju+8rHoTv
         Ks5VTIw++WHNYpnfjS2KGT3wsn7Pt371wkiy90PmbIxs6rCKUd2H3c/elL02bnMM04
         1lewV3w1Xo3Jz6Ybp3Byh2sBZTzShbe/Ny1G7i6cE5JQtAwtpNwmvbtPOykFU8a5OE
         Gj7RPr4ej+xgNjTg4WuC34Dm+J/SjFesBsV+4mUTUDN1SqPlv4JALXnUNl/eIS2krJ
         VI/KOhHK7DDkgCCpbSeduub2XAMT1m2XqcVlmwyWY39xkBNOb/mUStiuN9rjiWCaO1
         iP0X5N+yIKT5A==
Date:   Tue, 28 Mar 2023 17:41:56 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, gscrivan@redhat.com
Subject: Re: CLONE_INTO_CGROUP probably needs to call controller attach
 handlers
Message-ID: <20230328154156.kcm4nha2jeej74rr@wittgenstein>
References: <20230328153943.op62j3sw7qaixdsq@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230328153943.op62j3sw7qaixdsq@wittgenstein>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 28, 2023 at 05:39:52PM +0200, Christian Brauner wrote:
> Hey,
> 
> Giuseppe reported that the the affinity mask isn't updated when a
> process is spawned directly into the target cgroup via
> CLONE_INTO_CGROUP. However, migrating a process will cause the affinity
> mask to be updated (see the repro at [1].
> 
> I took a quick look and the issue seems to be that we don't call the
> various attach handlers during CLONE_INTO_CGROUP whereas we do for
> migration. So the solution seems to roughly be that we need to call the
> various attach handlers during CLONE_INTO_CGROUP as well when the
> parent's cgroups is different from the child cgroup. I think we need to
> call all of them, can, cancel and attach.
> 
> The plumbing here might be a bit intricate since the arguments that the
> fork handlers take are different from the attach handlers.

But note, as Johannes already pointed out somewhere else, that there's
probably a lot of code that doesn't apply to the CLONE_INTO_CGROUP case
so it might also make sense to just move the missing pieces into the
fork handlers.
