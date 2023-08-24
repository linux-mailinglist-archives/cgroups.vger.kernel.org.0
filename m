Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB323786824
	for <lists+cgroups@lfdr.de>; Thu, 24 Aug 2023 09:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbjHXHOV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Aug 2023 03:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbjHXHNw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Aug 2023 03:13:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFE7E4B;
        Thu, 24 Aug 2023 00:13:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D13A922C73;
        Thu, 24 Aug 2023 07:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692861228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cL+xkHg3gVScj/qvNoq2aVyQCfwu6YNOsJXQogUGOQI=;
        b=qb8NuamNvZBFYTTN0FOFT3Ibgam1CmlB83kK5rDCRNJ33KCnGr21xK0VtE/ya4rUb/TBQF
        Octr+nFbz3nKd9GIf+gxbBOanAltvASnflTM5oIEWXbXNsTw55b1+9NG4YtLwiDoecBWWH
        XRQcqtauBjN1w1a6QfonjTxSnwFUhTo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B513F138FB;
        Thu, 24 Aug 2023 07:13:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kYj3KSwD52QZHQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 24 Aug 2023 07:13:48 +0000
Date:   Thu, 24 Aug 2023 09:13:48 +0200
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
Message-ID: <ZOcDLD/1WaOwWis9@dhcp22.suse.cz>
References: <20230821205458.1764662-1-yosryahmed@google.com>
 <20230821205458.1764662-4-yosryahmed@google.com>
 <ZOR6eyYfJYlxdMet@dhcp22.suse.cz>
 <CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com>
 <ZOW2PZN8Sgqq6uR2@dhcp22.suse.cz>
 <CAJD7tka34WjtwBWfkTu8ZCEUkLm7h-AyCXpw=h34n4RZ5qBVwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tka34WjtwBWfkTu8ZCEUkLm7h-AyCXpw=h34n4RZ5qBVwA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 23-08-23 07:55:40, Yosry Ahmed wrote:
> On Wed, Aug 23, 2023 at 12:33 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 22-08-23 08:30:05, Yosry Ahmed wrote:
> > > On Tue, Aug 22, 2023 at 2:06 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Mon 21-08-23 20:54:58, Yosry Ahmed wrote:
> > [...]
> > > So to answer your question, I don't think a random user can really
> > > affect the system in a significant way by constantly flushing. In
> > > fact, in the test script (which I am now attaching, in case you're
> > > interested), there are hundreds of threads that are reading stats of
> > > different cgroups every 1s, and I don't see any negative effects on
> > > in-kernel flushers in this case (reclaimers).
> >
> > I suspect you have missed my point.
> 
> I suspect you are right :)
> 
> 
> > Maybe I am just misunderstanding
> > the code but it seems to me that the lock dropping inside
> > cgroup_rstat_flush_locked effectivelly allows unbounded number of
> > contenders which is really dangerous when it is triggerable from the
> > userspace. The number of spinners at a moment is always bound by the
> > number CPUs but depending on timing many potential spinners might be
> > cond_rescheded and the worst time latency to complete can be really
> > high. Makes more sense?
> 
> I think I understand better now. So basically because we might drop
> the lock and resched, there can be nr_cpus spinners + other spinners
> that are currently scheduled away, so these will need to wait to be
> scheduled and then start spinning on the lock. This may happen for one
> reader multiple times during its read, which is what can cause a high
> worst case latency.
> 
> I hope I understood you correctly this time. Did I?

Yes. I would just add that this could also influence the worst case
latency for a different reader - so an adversary user can stall others.
Exposing a shared global lock in uncontrolable way over generally
available user interface is not really a great idea IMHO.
-- 
Michal Hocko
SUSE Labs
