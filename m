Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8137F68F9F5
	for <lists+cgroups@lfdr.de>; Wed,  8 Feb 2023 22:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjBHV5U (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Feb 2023 16:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjBHV5T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Feb 2023 16:57:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BDB29434;
        Wed,  8 Feb 2023 13:57:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 080A120D06;
        Wed,  8 Feb 2023 21:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675893437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R2mYp1Col1qvN/xaX0VnWrTW38RiNgAM0en+DKPJ/Mc=;
        b=tV14ilvCkDpWV8xRNwzMQDPZSjnAg+2lNdLsFTQh7F++domXSJfT/KBw44/SU8cTabNdXf
        3YGlGIDYBNgdX2Vmx2dV0c6RKLxrAGEeKVtAxV00qsjBSEeVvnK39r7pYqbTXEq3XJkumd
        7VQy9xDVfrBv5ZwR3YnlvOVMhUidcHM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1E5213425;
        Wed,  8 Feb 2023 21:57:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X3g1Lrwa5GM9TAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 08 Feb 2023 21:57:16 +0000
Date:   Wed, 8 Feb 2023 22:57:14 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Kairui Song <kasong@tencent.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kairui Song <ryncsn@gmail.com>
Subject: Re: [PATCH 2/2] sched/psi: iterate through cgroups directly
Message-ID: <Y+QaunjOmvJf3NTU@blackbook>
References: <20230208161654.99556-1-ryncsn@gmail.com>
 <20230208161654.99556-3-ryncsn@gmail.com>
 <20230208172956.GF24523@blackbody.suse.cz>
 <Y+P17OVZZWVpYIb0@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+P17OVZZWVpYIb0@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 08, 2023 at 02:20:12PM -0500, Johannes Weiner <hannes@cmpxchg.org> wrote:
> Hm, I don't think it does. It sets up *iter to point to the parent for
> the _next() call, but it returns task_dfl_cgroup()->psi. The next call
> does the same: cgroup = *iter, *iter = parent, return cgroup->psi.

You are right.

> It could be a bit more readable to have *iter always point to the
> current cgroup - but no strong preference either way from me:

A casually reading half-brain finds this more idiomatic :)

I just hope the "preloading" of the parent via iter isn't crucial to the
performance change.

Kairui, I like this reorganization and its effect!

Michal
