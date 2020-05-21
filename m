Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1A01DD489
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 19:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgEURhF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 13:37:05 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35792 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgEURhF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 13:37:05 -0400
Received: by mail-ed1-f65.google.com with SMTP id be9so7234055edb.2;
        Thu, 21 May 2020 10:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=16rYke2VtirNB4gM0beG8w5PFV57NvRuYqspSwtCjSg=;
        b=Taeljh1dC3qu3um7KYkLOJAZGhcsKfAEbku6ImjAjN0ijw0IPAQJk6Mr2DCFC5zHKy
         cAvq7tr2A0E4/56VBx2QJLgAA3t3FkcTCH4tIX3UQX3nQ/lkhzp01nG8svrrUo2AI3KU
         UOd08TtEGmAjC0QrR2g9euEJxZUW6MaJjlbvuffymlOGpqSSBG5rnmtP6sxZA7qWvYrb
         OkmWP5ivdQekwhRk+VJmaiHAzJNWgHQY83Pw+DzHfLh3+5d+KHTLV1NCGAgkh9K+4wRQ
         E2gV7fyxFTjhxnVTf8+J5AVa/AstRdU8s8pO5cu4NToOvZr8PQg4DRbDcNxjV9BFtFvm
         qXwA==
X-Gm-Message-State: AOAM530s2ysX4Cft8bujE4H2eHRdW8NgV9e5BJGjHmRsElETbKC9CH3t
        mIrORDxKIs3Py+Mjx/8YSrI=
X-Google-Smtp-Source: ABdhPJxIpAKEHjfSswIXBqOwMluDhwqe6aqxhPJc5pVjLhTX7Zqxuv8zlixxjQkThK5S7DqUFJfFFw==
X-Received: by 2002:a05:6402:1d2d:: with SMTP id dh13mr8182661edb.169.1590082623404;
        Thu, 21 May 2020 10:37:03 -0700 (PDT)
Received: from localhost (ip-37-188-180-112.eurotel.cz. [37.188.180.112])
        by smtp.gmail.com with ESMTPSA id lw27sm5659285ejb.80.2020.05.21.10.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 10:37:02 -0700 (PDT)
Date:   Thu, 21 May 2020 19:37:01 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200521173701.GX6462@dhcp22.suse.cz>
References: <20200520143712.GA749486@chrisdown.name>
 <20200520160756.GE6462@dhcp22.suse.cz>
 <20200520165131.GB630613@cmpxchg.org>
 <20200520170430.GG6462@dhcp22.suse.cz>
 <20200520175135.GA793901@cmpxchg.org>
 <20200521073245.GI6462@dhcp22.suse.cz>
 <20200521135152.GA810429@cmpxchg.org>
 <20200521143515.GU6462@dhcp22.suse.cz>
 <20200521163833.GA813446@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521163833.GA813446@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 21-05-20 12:38:33, Johannes Weiner wrote:
> On Thu, May 21, 2020 at 04:35:15PM +0200, Michal Hocko wrote:
> > On Thu 21-05-20 09:51:52, Johannes Weiner wrote:
> > > On Thu, May 21, 2020 at 09:32:45AM +0200, Michal Hocko wrote:
> > [...]
> > > > I am not saying the looping over try_to_free_pages is wrong. I do care
> > > > about the final reclaim target. That shouldn't be arbitrary. We have
> > > > established a target which is proportional to the requested amount of
> > > > memory. And there is a good reason for that. If any task tries to
> > > > reclaim down to the high limit then this might lead to a large
> > > > unfairness when heavy producers piggy back on the active reclaimer(s).
> > > 
> > > Why is that different than any other form of reclaim?
> > 
> > Because the high limit reclaim is a best effort rather than must to
> > either get over reclaim watermarks and continue allocation or meet the
> > hard limit requirement to continue.
> 
> It's not best effort. It's a must-meet or get put to sleep. You are
> mistaken about what memory.high is.

I do not see anything like that being documented. Let me remind you what
the documentation says:
  memory.high
        A read-write single value file which exists on non-root
        cgroups.  The default is "max".

        Memory usage throttle limit.  This is the main mechanism to
        control memory usage of a cgroup.  If a cgroup's usage goes
        over the high boundary, the processes of the cgroup are
        throttled and put under heavy reclaim pressure.

        Going over the high limit never invokes the OOM killer and
        under extreme conditions the limit may be breached.

My understanding is that breaching the limit is acceptable if the memory
is not reclaimable after placing a heavy reclaim pressure. We can
discuss what the heavy reclaim means but the underlying fact is that the
keeping the consumption under the limit is a best effort.

Please also let me remind you that the best effort implementation has
been there since the beginning when the memory.high has been introduced.
Now you seem to be convinced that the semantic is _obviously_ different.

It is not the first time when the high limit behavior has changed.
Mostly based on "what is currently happening in your fleet". And can see
why it is reasonable to adopt to a real life usage. That is OK most of
the time. But I haven't heard why keeping the existing approach and
enforcing the reclaim target is not working properly so far. All I can
hear is a generic statement that consistency matters much more than all
potential problem it might introduce.

Anyway, I do see that you are not really willing to have a
non-confrontational discussion so I do not bother to reply to the rest
and participate in the further discussion.

As usual, let me remind you that I haven't nacked the patch. I do not
plan to do that because "this is not black&white" as already said. But
if your really want to push this through then let's do it properly at
least. memcg->memcg_nr_pages_over_high has only very vague meaning if
the reclaim target is the high limit. The changelog should be also
explicit about a potentially large stalls so that people debugging such
a problem have a clue at least.
-- 
Michal Hocko
SUSE Labs
