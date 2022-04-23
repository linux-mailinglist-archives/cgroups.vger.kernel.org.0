Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EA650C99C
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 13:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiDWLjx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Apr 2022 07:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiDWLjw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Apr 2022 07:39:52 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4084F1A04F;
        Sat, 23 Apr 2022 04:36:56 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id d198so7578145qkc.12;
        Sat, 23 Apr 2022 04:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BcOqG7n5x1u/kJMqwh39Y5RSFSmbFCI9uw/6+AwfTFk=;
        b=qlW47WTNgLqYAcdQ3gQ8iRhLrMlbmDGK/ktxmdC5/CTEfuYcbb7OiFFAn5n5VYS+Bi
         oPkHtXY6qBtgmJSMycJMB1vBF11Fu9xkA1gRnEczvQ6sC6UgXM8znkmjtKFDJSrHfyjG
         6+l57+4rEei5xuDysryuNlycKui7chxQPFtyFrqmn6DSfPh9IX+iKnrVJHEHhkWLYKe3
         69TpQX6L7eROiOY9PbBdZ8DVGfRd5TZCQ5fqbV4NRDA0QH3HqLgu4ROm21qT8Wh199C1
         DJ4nJxAVTcjYsoaJi/nGB5t081i/DqL6rvAUmkHBPnIGnWjGTZQ36fW4ucDk2H814eYc
         sJ5g==
X-Gm-Message-State: AOAM531le+yNYTR8udMKFuvjt6/qMIGeNy2FRXkEhWymRDVGAh8xMVkh
        TbUblsEhjeAkoaDPTN2r370=
X-Google-Smtp-Source: ABdhPJxuD1TVwkZ0HbifP6E6S0QwJLLQMTOA4Qo7MnFnODcBZD0xZcU2q1vPD/m7S/aMeB9RyKrfQw==
X-Received: by 2002:a05:620a:2495:b0:69e:e047:c6e7 with SMTP id i21-20020a05620a249500b0069ee047c6e7mr5094904qkn.737.1650713815298;
        Sat, 23 Apr 2022 04:36:55 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-119.fbsv.net. [2a03:2880:20ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id a63-20020ae9e842000000b0069e6722632bsm2246042qkg.39.2022.04.23.04.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 04:36:55 -0700 (PDT)
Date:   Sat, 23 Apr 2022 04:36:52 -0700
From:   David Vernet <void@manifault.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com
Subject: Re: [PATCH 3/5] cgroup: Account for memory_localevents in
 test_memcg_oom_group_leaf_events()
Message-ID: <20220423113652.ys5gd7vvwkvbdte4@dev0025.ash9.facebook.com>
References: <20220422155728.3055914-1-void@manifault.com>
 <20220422155728.3055914-4-void@manifault.com>
 <YmM26XBZxWy4Widc@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmM26XBZxWy4Widc@carbon>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 22, 2022 at 04:14:49PM -0700, Roman Gushchin wrote:
> On Fri, Apr 22, 2022 at 08:57:27AM -0700, David Vernet wrote:
> > The test_memcg_oom_group_leaf_events() testcase in the cgroup memcg tests
> > validates that processes in a group that perform allocations exceeding
> > memory.oom.group are killed. It also validates that the
> > memory.events.oom_kill events are properly propagated in this case.  Commit
> > 06e11c907ea4 ("kselftests: memcg: update the oom group leaf events test")
> > fixed test_memcg_oom_group_leaf_events() to account for the fact that the
> > memory.events.oom_kill events in a child cgroup is propagated up to its
> > parent. This behavior can actually be configured by the memory_localevents
> > mount option, so this patch updates the testcase to properly account for
> > the possible presence of this mount option.
> > 
> > Signed-off-by: David Vernet <void@manifault.com>
> > ---
> >  .../testing/selftests/cgroup/test_memcontrol.c  | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> > index ea2fd27e52df..d88e0ca3f3d1 100644
> > --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> > +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> > @@ -21,6 +21,7 @@
> >  #include "../kselftest.h"
> >  #include "cgroup_util.h"
> >  
> > +static bool has_localevents;
> >  static bool has_recursiveprot;
> >  
> >  /*
> > @@ -1091,6 +1092,7 @@ static int test_memcg_oom_group_leaf_events(const char *root)
> >  {
> >  	int ret = KSFT_FAIL;
> >  	char *parent, *child;
> > +	long parent_oom_events;
> >  
> >  	parent = cg_name(root, "memcg_test_0");
> >  	child = cg_name(root, "memcg_test_0/memcg_test_1");
> > @@ -1128,7 +1130,15 @@ static int test_memcg_oom_group_leaf_events(const char *root)
> >  	if (cg_read_key_long(child, "memory.events", "oom_kill ") <= 0)
> >  		goto cleanup;
> >  
> > -	if (cg_read_key_long(parent, "memory.events", "oom_kill ") <= 0)
> > +	parent_oom_events = cg_read_key_long(
> > +			parent, "memory.events", "oom_kill ");
> > +	// If memory_localevents is not enabled (the default), the parent should
> > +	// count OOM events in its children groups. Otherwise, it should not
> > +	// have observed any events.
> 
> Please, use /* */ style comments, it's a generic kernel style.

Ack, will fix in a follow-on patch.

> 
> > +	if (has_localevents) {
> > +		if (parent_oom_events != 0)
> > +			goto cleanup;
> > +	} else if (parent_oom_events <= 0)
> >  		goto cleanup;
> 
> How about something like this? IMO a bit more clear what's going on.
> 	if ((has_local_events && parent_oom_events == 0) ||
> 	    parent_oom_events > 0)
> 		ret = KSFT_PASS;

Agreed that's a bit clearer, I'll include this in the follow-on patch.
