Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DA16CFC37
	for <lists+cgroups@lfdr.de>; Thu, 30 Mar 2023 09:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjC3HGw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Mar 2023 03:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjC3HGt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Mar 2023 03:06:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08D365B5;
        Thu, 30 Mar 2023 00:06:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 654981FE87;
        Thu, 30 Mar 2023 07:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680160007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QLfYeLt+TXwV+pwToLzrHHrJTaYboOCW9UaiwVxS7lA=;
        b=mAI7MPiHSl8rJ93izo+zY41ldY7Q5UIHq3cnqnGtElFi7az9dtYt0NrZYGnhHulCp4xuiB
        tCKde3AIvlhN6fTukiLKYF3ViOCSzqBHTGWpE8aQCHMCXW6+8GcWX7Keeil3ozJ3OOGTHK
        IGmmNg/5vANvb4KhA3aiQh5XlXtsXR4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4169A1348E;
        Thu, 30 Mar 2023 07:06:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yVwIDQc1JWR+bAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 30 Mar 2023 07:06:47 +0000
Date:   Thu, 30 Mar 2023 09:06:46 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2 4/9] cgroup: rstat: add WARN_ON_ONCE() if flushing
 outside task context
Message-ID: <ZCU1Bp+5bKNJzWIu@dhcp22.suse.cz>
References: <20230328221644.803272-1-yosryahmed@google.com>
 <20230328221644.803272-5-yosryahmed@google.com>
 <ZCQfZJFufkJ10o01@dhcp22.suse.cz>
 <CAJD7tkb-UpKm2QbjYzB=B=oGk6Hyj9cbUviZUPC+7VsvBecH7g@mail.gmail.com>
 <20230329192059.2nlme5ubshzdbpg6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230329192059.2nlme5ubshzdbpg6@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 29-03-23 19:20:59, Shakeel Butt wrote:
> On Wed, Mar 29, 2023 at 11:41:39AM -0700, Yosry Ahmed wrote:
> > On Wed, Mar 29, 2023 at 4:22 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Tue 28-03-23 22:16:39, Yosry Ahmed wrote:
> > > > rstat flushing is too expensive to perform in irq context.
> > > > The previous patch removed the only context that may invoke an rstat
> > > > flush from irq context, add a WARN_ON_ONCE() to detect future
> > > > violations, or those that we are not aware of.
> > > >
> > > > Ideally, we wouldn't flush with irqs disabled either, but we have one
> > > > context today that does so in mem_cgroup_usage(). Forbid callers from
> > > > irq context for now, and hopefully we can also forbid callers with irqs
> > > > disabled in the future when we can get rid of this callsite.
> > >
> > > I am sorry to be late to the discussion. I wanted to follow up on
> > > Johannes reply in the previous version but you are too fast ;)
> > >
> > > I do agree that this looks rather arbitrary. You do not explain how the
> > > warning actually helps. Is the intention to be really verbose to the
> > > kernel log when somebody uses this interface from the IRQ context and
> > > get bug reports? What about configurations with panic on warn? Do we
> > > really want to crash their systems for something like that?
> > 
> > Thanks for taking a look, Michal!
> > 
> > The ultimate goal is not to flush in irq context or with irqs
> > disabled, as in some cases it causes irqs to be disabled for a long
> > time, as flushing is an expensive operation. The previous patch in the
> > series should have removed the only context that flushes in irq
> > context, and the purpose of the WARN_ON_ONCE() is to catch future uses
> > or uses that we might have missed.
> > 
> > There is still one code path that flushes with irqs disabled (also
> > mem_cgroup_usage()), and we cannot remove this just yet; we need to
> > deprecate usage threshold events for root to do that. So we cannot
> > enforce not flushing with irqs disabled yet.
> > 
> > So basically the patch is trying to enforce what we have now, not
> > flushing in irq context, and hopefully at some point we will also be
> > able to enforce not flushing with irqs disabled.
> > 
> > If WARN_ON_ONCE() is the wrong tool for this, please let me know.
> > 
> 
> If I understand Michal's concern, the question is should be start with
> pr_warn_once() instead of WARN_ON_ONCE() and I think yes we should start
> with pr_warn_once().

Yes, I do not really like the WARN_ON here. It is an overkill. pr_warn
would much less intrusive but potentially incomplete because you won't
know who that offender is. So if you really care about those then you
would need to call dump_stack as well.

So the real question is. Do we really care so deeply? After all somebody
might be calling this from within a spin lock or irq disabled section
resulting in a similar situation without noticing.
-- 
Michal Hocko
SUSE Labs
