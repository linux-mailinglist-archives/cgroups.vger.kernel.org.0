Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2752968FA0A
	for <lists+cgroups@lfdr.de>; Wed,  8 Feb 2023 23:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjBHWDa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Feb 2023 17:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjBHWD2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Feb 2023 17:03:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9B722DCE;
        Wed,  8 Feb 2023 14:03:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 06194346E1;
        Wed,  8 Feb 2023 22:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675893802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RQV4Rg+rxKSLEejj3EobTgqtBroMYBCoiGQS4TDitEs=;
        b=H0iy8tmDDQdBeQtaT0hVpMy0C0LFYb0gfPffGYJgv/No4r1/lgD7VBtsFY5aekxWd8lN2x
        LvXJ4TZekdMl+ea3WPzw4EzBlSavSQ1JTYb/96HtR7QB+DdhrRRkQnb0FiIAlmwuwUZZNQ
        YW4x//NtUzWGuvK0OuIudgHgZ16mwu0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C21AF13425;
        Wed,  8 Feb 2023 22:03:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D+pnLikc5GM7TgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 08 Feb 2023 22:03:21 +0000
Date:   Wed, 8 Feb 2023 23:03:19 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Kairui Song <ryncsn@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH 2/2] sched/psi: iterate through cgroups directly
Message-ID: <Y+QcJ2OvTmJzrObn@blackbook>
References: <20230208161654.99556-1-ryncsn@gmail.com>
 <20230208161654.99556-3-ryncsn@gmail.com>
 <Y+P0wLTdZcOPiKPZ@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+P0wLTdZcOPiKPZ@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 08, 2023 at 02:15:12PM -0500, Johannes Weiner <hannes@cmpxchg.org> wrote:
> Please name these psi_groups_first() and psi_groups_next().

One more suggestion: s/next/parent/ to avoid impression of (sub)tree
iteration and consistence with cg-related iters.

Thanks,
Michal

