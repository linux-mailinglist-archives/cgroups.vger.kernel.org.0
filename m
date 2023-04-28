Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0066F145B
	for <lists+cgroups@lfdr.de>; Fri, 28 Apr 2023 11:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345595AbjD1JoO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Apr 2023 05:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjD1JoO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Apr 2023 05:44:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047714497;
        Fri, 28 Apr 2023 02:44:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BA7B521EE2;
        Fri, 28 Apr 2023 09:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682675051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fiJTpK/XRgtTp6ZTdBZkBeDGODxz+KV44UNCy4wvN4k=;
        b=AGa/xCEjEb3qK0MkSqbET4JkZvo2UGTc8z/NuldzPCjYt42vE3dxHHEbB6d5sy76QyDlKB
        JZvN9n3qMA7C3W9yiQNLWfKs3iEzV/H7hFRrViMiISFVM6/YwbFIvopZPQ3WQxIfW9qSHl
        k/+k/CJqK0lRhf7+++JDZcpd7axXQv0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC0771390E;
        Fri, 28 Apr 2023 09:44:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tI34KWuVS2TmHwAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 28 Apr 2023 09:44:11 +0000
Date:   Fri, 28 Apr 2023 11:44:11 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, Chris Li <chrisl@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] memcg: dump memory.stat during cgroup OOM for v1
Message-ID: <ZEuVaxSUo7WxLn3K@dhcp22.suse.cz>
References: <20230426133919.1342942-1-yosryahmed@google.com>
 <20230426133919.1342942-3-yosryahmed@google.com>
 <ZElC127xlU2NtlqF@dhcp22.suse.cz>
 <CAJD7tkZ1cODXRuVQ3fWL0s=VsyKZqDPPNqFZec_COAXm0XfXWA@mail.gmail.com>
 <ZEqBesAJFfLZI65/@dhcp22.suse.cz>
 <CAJD7tkac7VKV6Ob8qQWzhm8Ayyk3xB0YCY6edL-TxpXV3aCzXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkac7VKV6Ob8qQWzhm8Ayyk3xB0YCY6edL-TxpXV3aCzXA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 27-04-23 15:12:46, Yosry Ahmed wrote:
[...]
> However, I still think this change is valuable. Like you mentioned,
> the OOM log is not set in stone, but we shouldn't just change it for
> no reason. In this case, for cgroup v1 users, the OOM log changed for
> no reason beyond a side effect of another patch. Upon upgrading our
> kernel we noticed the behavior change. This patch restores the old
> behavior without any cost really, and it makes the code a tiny bit
> more consistent.

Fair enough. Just make sure you go into more details about why this is
causing problems/inconveniences. I am slightly worried this might cause
problems to other people who would like to have the same report for both
v1 and v2 so we should at least have some solid argumetns to revert
rather than "it used has changed and we liked it more that way".

I personally do not care all that much. It kinda sucks to dump counters
that are not tracked or fully tracked in v1 because that can mislead
people and that would be a bigger problem from my POV.
-- 
Michal Hocko
SUSE Labs
