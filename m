Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948C35431EC
	for <lists+cgroups@lfdr.de>; Wed,  8 Jun 2022 15:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240919AbiFHNvR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Jun 2022 09:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240883AbiFHNvQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Jun 2022 09:51:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4050B62BEA;
        Wed,  8 Jun 2022 06:51:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B8DBF21AA6;
        Wed,  8 Jun 2022 13:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654696271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EdG9PlC0R8OmQU19nk71zBCMMuRv8NZuw8mGqBcI480=;
        b=K2HoctTtt/KhX6+mXecsJdmxEuLMLk9zl0bFw6P8GQqwSvXX6slsZPsrN89QwI/uB+DzRk
        2rc7JqmJgkntQCiSgzz+t+cOxr+UxCJIiMua+TwkAugUiSC+51i12hZ9WImmy5T6lsX3QU
        4J2vUnC1M74rqwRGtY9bdo+zosQvGM8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9363713A15;
        Wed,  8 Jun 2022 13:51:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Oi8kI0+poGKUZQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 08 Jun 2022 13:51:11 +0000
Date:   Wed, 8 Jun 2022 15:51:10 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     shisiyuan <shisiyuan19870131@gmail.com>
Cc:     tj@kernel.org, hannes@cmpxchg.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        shisiyuan <shisiyuan@xiaomi.com>
Subject: Re: [PATCH] cgroup: handle cset multiidentity issue when migration
Message-ID: <20220608135110.GA19399@blackbody.suse.cz>
References: <1654187688-27411-1-git-send-email-shisiyuan@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654187688-27411-1-git-send-email-shisiyuan@xiaomi.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello.

On Fri, Jun 03, 2022 at 12:34:48AM +0800, shisiyuan <shisiyuan19870131@gmail.com> wrote:
> Bug code flow:
> cset X's initial refcount is 1.
> 1. cgroup_attach_task()
> 2. [For thread1]
>    cgroup_migrate_add_src()
>    [For thread2]
>    cgroup_migrate_add_src()
>      cset X is thread2's src_cset , ref->2,
>      and its mg_preload_node is added to
>      mgctx->preloaded_src_csets.
> 3. cgroup_migrate_prepare_dst()
>    [For thread1]
>    find_css_set()
>      cset X is thread1's dst_cset, ref->3
>    put_css_set()
>      ref->2 because cset X's mg_preload_node is not
>      empty(already in mgctx->preloaded_src_csets).
>    [For thread2]
>    find_css_cset()
>      cset X is also thread2's dst_cset, ref->3
>      then drop src_cset, ref->1
> [cgroup_free] ref->0
> 4. cgroup_migrate_execute
>    [For thread1]
>    ref -> 0xc0000000(UAF)

I'm trying to understand when this happens.
You migrate a process with two threads while one of them exits?

This should be properly synchronized with cgroup_threadgroup_rwsem, so I
don't understand where does the [cgroup_free] between 3. and 4. come
from.

Do you have a reproducer for this?

Thanks,
Michal
