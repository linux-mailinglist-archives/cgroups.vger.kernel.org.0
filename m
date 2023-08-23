Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A38785199
	for <lists+cgroups@lfdr.de>; Wed, 23 Aug 2023 09:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbjHWHdW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Aug 2023 03:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjHWHdW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Aug 2023 03:33:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0118E4A;
        Wed, 23 Aug 2023 00:33:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 93E4E221F3;
        Wed, 23 Aug 2023 07:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692775998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0SctbqgZjFFOicN/oLKPgrVMYfxZTnrl4bohndLZhFw=;
        b=hCXFa9a5NNinjYOciz1NJlp40rerbNvpu4j7TEmXTMQ7b/kHiHRYrRtrQdx0wxJ9Qk0XW3
        TY0lUbZdY3FxijHgvhI3EJy+T4gupko+GkbciMQzNq+K3sJ3p88yJRGydrsJL5ojb26tLo
        +FZLVZ+yG3y6bDmDpf4RHgjJQYLrVbk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77C401351F;
        Wed, 23 Aug 2023 07:33:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bV0JGz625WTJQQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 23 Aug 2023 07:33:18 +0000
Date:   Wed, 23 Aug 2023 09:33:17 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: memcg: use non-unified stats flushing for
 userspace reads
Message-ID: <ZOW2PZN8Sgqq6uR2@dhcp22.suse.cz>
References: <20230821205458.1764662-1-yosryahmed@google.com>
 <20230821205458.1764662-4-yosryahmed@google.com>
 <ZOR6eyYfJYlxdMet@dhcp22.suse.cz>
 <CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 22-08-23 08:30:05, Yosry Ahmed wrote:
> On Tue, Aug 22, 2023 at 2:06 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 21-08-23 20:54:58, Yosry Ahmed wrote:
[...]
> So to answer your question, I don't think a random user can really
> affect the system in a significant way by constantly flushing. In
> fact, in the test script (which I am now attaching, in case you're
> interested), there are hundreds of threads that are reading stats of
> different cgroups every 1s, and I don't see any negative effects on
> in-kernel flushers in this case (reclaimers).

I suspect you have missed my point. Maybe I am just misunderstanding
the code but it seems to me that the lock dropping inside
cgroup_rstat_flush_locked effectivelly allows unbounded number of
contenders which is really dangerous when it is triggerable from the
userspace. The number of spinners at a moment is always bound by the
number CPUs but depending on timing many potential spinners might be
cond_rescheded and the worst time latency to complete can be really
high. Makes more sense?
-- 
Michal Hocko
SUSE Labs
