Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9757B580091
	for <lists+cgroups@lfdr.de>; Mon, 25 Jul 2022 16:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiGYOQ7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Jul 2022 10:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbiGYOQ6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Jul 2022 10:16:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C774DF12;
        Mon, 25 Jul 2022 07:16:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E203DB80ED0;
        Mon, 25 Jul 2022 14:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98914C341C6;
        Mon, 25 Jul 2022 14:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658758614;
        bh=p9/gFb1902RLnmreUeNFAHcbKgrOvbu9N0D0jG7+uBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AkOKY3UMzdkfecaitmz6IXmVhF5eNwiBrQE/mS4uiWu2IL70SzLVLCisC10ETcVtI
         enMoVGVUa76JLUafYZ7b+snwHVt6YHktjb+0COvfAyK44Jc/bmBGa0ivJ5KLrmz4jY
         RuCK5I8BIFEWanDSM1IHJImxMAj3y5K+Z1ulenmactWnPMMG2huJGlONVz0agoXahA
         /KtXIk8smhLeMBRh2brDlTf56bx9iirwtnFhOOkLn/Crgy7zEFiAxUXXQuzv62r3z3
         mJRjANXJft/74cvd9pymtRgZBano2iJxOsLU02p72Ymcsgjc3Bewp86Gs2F1WP+dEi
         m2LhCzQRgnEOQ==
Date:   Mon, 25 Jul 2022 16:16:49 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH RESEND 3/3 cgroup/for-5.20] cgroup: Make !percpu
 threadgroup_rwsem operations optional
Message-ID: <20220725141649.ou7tsntv4xnqtbmc@wittgenstein>
References: <YtDvN0wJ6CKaEPN8@slm.duckdns.org>
 <YtDvU4jRPSsarcNp@slm.duckdns.org>
 <YtDvl7Qjc5zI3e/b@slm.duckdns.org>
 <YtwFjPnCtw8ySnuv@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YtwFjPnCtw8ySnuv@slm.duckdns.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jul 23, 2022 at 04:28:28AM -1000, Tejun Heo wrote:
> 3942a9bd7b58 ("locking, rcu, cgroup: Avoid synchronize_sched() in
> __cgroup_procs_write()") disabled percpu operations on threadgroup_rwsem
> because the impiled synchronize_rcu() on write locking was pushing up the
> latencies too much for android which constantly moves processes between
> cgroups.
> 
> This makes the hotter paths - fork and exit - slower as they're always
> forced into the slow path. There is no reason to force this on everyone
> especially given that more common static usage pattern can now completely
> avoid write-locking the rwsem. Write-locking is elided when turning on and
> off controllers on empty sub-trees and CLONE_INTO_CGROUP enables seeding a
> cgroup without grabbing the rwsem.
> 
> Restore the default percpu operations and introduce the mount option
> "favordynmods" and config option CGROUP_FAVOR_DYNMODS for users who need
> lower latencies for the dynamic operations.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Michal Koutný <mkoutny@suse.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Dmitry Shmidt <dimitrysh@google.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> ---

Seems sane,
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
