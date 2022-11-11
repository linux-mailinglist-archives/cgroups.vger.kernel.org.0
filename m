Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8F66262F0
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 21:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiKKUa7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 15:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiKKUa7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 15:30:59 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8095E14083
        for <cgroups@vger.kernel.org>; Fri, 11 Nov 2022 12:30:57 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so8687054pjc.3
        for <cgroups@vger.kernel.org>; Fri, 11 Nov 2022 12:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kn0Y+63FiU6va/fYBfDM/PWGy/IsvE7/E02gtmFvSYk=;
        b=LauIKZokprmiYiUpRTowA0fVwRhG1sb1N7oihtbcgMA7TwP9eoVi2520gPrIFZep7S
         pJnuHLwnDF2VDM9eUh55VHUYnGdkEFidW9/9bsNhC/qNPgf5eX6F0ZxcVaMrWioEO11Z
         fa5qR7RTnoLcaQeazMfqpw8iB6MHozM45QG6JrYFvfBOdc0XVnsHZcd16DoWgcdHSSln
         8az5drUooRNM39glR86z3JAW8CGKXl1Kw2nESRhfwUmp1h9lUnClNjf9EHo2ndngSttk
         n3MNlcC6AFIU5GIrmmoz6H9ekRsAIuImchViSew+lYdowbE8L1q+rheJT/HmOLIAP8o7
         NyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kn0Y+63FiU6va/fYBfDM/PWGy/IsvE7/E02gtmFvSYk=;
        b=bmcTEoNKdfj0gsl6su+fWYDPr8Yyy5hRZMcVhaGmg3KaRj1DOlVjKNceGQsWIuY7GV
         4RFm2vP0EmLL++Chg7ne6PsfO4MKRKYLvfdBjeiVaN+UT/Q3zU2AmOHAj1GLvnZoXe+G
         DBChxmlVcMB8PKG4Z0pI4V3yzrU2pTBg9l2kfWnYvdZ2vFMBJeedsxKQbRmcO+/+EVa4
         8S4kDsn2B9YRd6BkDCKnqVQ37Z5weBaw0X5n+5t7GRtuVoguFikhHZanzQc77KH798es
         VM5J8bfQMNBk0Wi6lUgFN1n9iKrCE5YFv35FkOS5aG8iJX15pn/B2bPM4iyUQAjm4GWz
         TOVA==
X-Gm-Message-State: ANoB5pmOwS3SFz52GKffdfNWcPkO2Q8nQwTWF1ORmYvJ9lxBwtqdLluC
        iHBOOTmdvsDfmewlNK5bVpGPRw==
X-Google-Smtp-Source: AA0mqf7CqYdnrdKJ1pWR4K+vZFpqBWn89jr1KmO9yQwHlIQx9KE98fE1wHs7/5adGaOYMdzGC9Xk1g==
X-Received: by 2002:a17:902:bd0a:b0:186:aad0:6b32 with SMTP id p10-20020a170902bd0a00b00186aad06b32mr4187678pls.77.1668198657032;
        Fri, 11 Nov 2022 12:30:57 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:54c6])
        by smtp.gmail.com with ESMTPSA id 34-20020a630d62000000b0046feca0883fsm1698177pgn.64.2022.11.11.12.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 12:30:56 -0800 (PST)
Date:   Fri, 11 Nov 2022 15:31:00 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Lu Jialin <lujialin4@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/memcontrol.c: drains percpu charge caches in
 memory.reclaim
Message-ID: <Y26xBGvyhehWfqML@cmpxchg.org>
References: <20221110065316.67204-1-lujialin4@huawei.com>
 <20221110144243.GA10562@blackbody.suse.cz>
 <CAJD7tkat6QAJkPJ-of0xYGbKJ1CyXeC0cMh+U9Nzmddm4pOZ9g@mail.gmail.com>
 <20221111100843.GG20455@blackbody.suse.cz>
 <CAJD7tkYWvR+2o==-R38hDBEM=k=2bta9kKRND3wxDLF1pWbp6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYWvR+2o==-R38hDBEM=k=2bta9kKRND3wxDLF1pWbp6A@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 11, 2022 at 10:24:02AM -0800, Yosry Ahmed wrote:
> On Fri, Nov 11, 2022 at 2:08 AM Michal Koutný <mkoutny@suse.com> wrote:
> >
> > On Thu, Nov 10, 2022 at 11:35:34AM -0800, Yosry Ahmed <yosryahmed@google.com> wrote:
> > > OTOH, it will reduce the page counters, so if userspace is relying on
> > > memory.current to gauge how much reclaim they want to do, it will make
> > > it "appear" like the usage dropped.
> >
> > Assuming memory.current is used to drive the proactive reclaim, then
> > this patch makes some sense (and is slightly better than draining upon
> > every memory.current read(2)).
> 
> I am not sure honestly. This assumes memory.reclaim is used in
> response to just memory.current, which is not true in the cases I know
> about at least.
> 
> If you are using memory.reclaim merely based on memory.current, to
> keep the usage below a specified number, then memory.high might be a
> better fit? Unless this goal usage is a moving target maybe and you
> don't want to keep changing the limits but I don't know if there are
> practical use cases for this.
> 
> For us at Google, we don't really look at the current usage, but
> rather on how much of the current usage we consider "cold" based on
> page access bit harvesting. I suspect Meta is doing something similar
> using different mechanics (PSI). I am not sure if memory.current is a
> factor in either of those use cases, but maybe I am missing something
> obvious.

Yeah, Meta drives proactive reclaim through psi feedback.

We do consult memory.current to enforce minimums, just for safety
reasons. But that's are very conservative parameter, the percpu fuzz
doesn't make much of a difference there; certainly, we haven't had any
problems with memory.reclaim not draining stocks.

So I would agree that it's not entirely obvious why stocks should be
drained as part of memory.reclaim. I'm curious what led to the patch.
