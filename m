Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD97E6CFD4E
	for <lists+cgroups@lfdr.de>; Thu, 30 Mar 2023 09:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjC3Hte (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Mar 2023 03:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjC3Ht0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Mar 2023 03:49:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37579659E;
        Thu, 30 Mar 2023 00:49:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 82C051FE96;
        Thu, 30 Mar 2023 07:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680162547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zl6vnuhb0+tm4UNYVkua6ap4lB/Vnj1JGtAkmTbyth8=;
        b=OtqKKjzUcmO/o0IDfFsZZQhAvhs/NKY4kJjUmP4UIDS3us0gtfDjwpZ5/hrmfHWxHHPzpI
        dZ7X131mCHa/QAdw7J0fEZfW35910RAIMN0WuPe7lYwebuRZiekoQnwdQ8sA+rGDGkzp83
        p1Te8uGBUwpnjYZ5L8u7t6zIzW2B6cI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A2651348E;
        Thu, 30 Mar 2023 07:49:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EG8lH/M+JWRDAgAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 30 Mar 2023 07:49:07 +0000
Date:   Thu, 30 Mar 2023 09:49:06 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
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
Message-ID: <ZCU+8lSi+e4WgT3F@dhcp22.suse.cz>
References: <20230328221644.803272-1-yosryahmed@google.com>
 <20230328221644.803272-5-yosryahmed@google.com>
 <ZCQfZJFufkJ10o01@dhcp22.suse.cz>
 <CAJD7tkb-UpKm2QbjYzB=B=oGk6Hyj9cbUviZUPC+7VsvBecH7g@mail.gmail.com>
 <20230329192059.2nlme5ubshzdbpg6@google.com>
 <ZCU1Bp+5bKNJzWIu@dhcp22.suse.cz>
 <CAJD7tka0CmRvcvB0k8DZuid1vC9OK_mFriHHbXNTUkVE7OjaTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tka0CmRvcvB0k8DZuid1vC9OK_mFriHHbXNTUkVE7OjaTA@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 30-03-23 00:13:16, Yosry Ahmed wrote:
> On Thu, Mar 30, 2023 at 12:06 AM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > So the real question is. Do we really care so deeply? After all somebody
> > might be calling this from within a spin lock or irq disabled section
> > resulting in a similar situation without noticing.
> 
> There are discussions in [1] about making atomic rstat flush not
> disable irqs throughout the process, so in that case it would only
> result in a similar situation if the caller has irq disabled. The only
> caller that might have irq disabled is the same caller that might be
> in irq context before this series: mem_cgroup_usage().
> 
> On that note, and while I have your attention, I was wondering if we
> can eliminate the flush call completely from mem_cgroup_usage(), and
> read the global stats counters for root memcg instead of the root
> counters. There might be subtle differences, but the root memcg usage
> isn't super accurate now anyway (e.g. it doesn't include kernel
> memory).

root memcg stats are imprecise indeed and I have to admit I do not
really know why we are adding more work for that case. I have tried to
dig into git history for that yesterday but couldn't find a satisfying
answer. It goes all the way down to 2d146aa3aa842 which has done the
switch to rstat. Maybe Johannes remembers.

Anyway, back to this particular patch. I still do not see strong reasons
to be verbose about !in_task case so I would just drop this patch.
-- 
Michal Hocko
SUSE Labs
