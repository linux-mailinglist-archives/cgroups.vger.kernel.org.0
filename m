Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9AC1CDFC2
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2020 17:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbgEKP5H (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 May 2020 11:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726934AbgEKP5H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 May 2020 11:57:07 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58DBC061A0E
        for <cgroups@vger.kernel.org>; Mon, 11 May 2020 08:57:06 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i68so8355785qtb.5
        for <cgroups@vger.kernel.org>; Mon, 11 May 2020 08:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0mkmAQYTPxUwTzaufmQ28FUE0wAOW0XuP/PajjBfBuI=;
        b=oj6nl8Etq+Cp7D5OexjUrLRZfJ6Boh1fr3GR6ETsCeQgMNybVUKDK0SlyrXGit3FGs
         Kk4Yshjf2ZNzTx3DiZrm/f03A9DD5twUHxDzBbOQtkSX+qhqGRELd8hPWbxYR6XcP7c3
         AqZYcLK6CdIjDSO+xG1LoDdPVgEkch+Eb627llInyJOkzFEe2tTFHu4jBztuP60v8bx+
         EY2XURnrX3zUqwtOy1Iu5TwM6uN1XpzGxwBv+RXpvyYam2nJ8ocqSqgbtTUnSltdPVTU
         gEXP2FC/T77cVQ2cXgLbdF4X+1qS94vQvbOEXrkDdjbjGNU59A7GMlhFsW8TmO0UPNM1
         4WDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0mkmAQYTPxUwTzaufmQ28FUE0wAOW0XuP/PajjBfBuI=;
        b=fvKmmUNURThyFWofAVVuRCaGlo3wZvkHmJJTM/yG57g5027IwidPdk5iV6OFI8tnLE
         xwyRcMfZv7SOFXYb6/k850okZieSFz28Hg+/2dppYbpRdm4Fqoy/1D6STIzzqo0iVu4h
         eJ8dhylNNMk0GBGIeV76SfD8fkL7SX7mVkHo2pwbbK8hgB8jd8uohGzkESEtGuTjziGg
         eQWx7//Ki7cL5/5TJHFV9xSCLHZQDUv1UqR0q3mVcbd/9n4GFvC6z3J6nZu5kxx0Inbr
         1n11gpEY6QMoOX/dLgs4HS2ae3sP11Du0MDpXiIMaalWpm8aF1UaSL11OJlxajo4MjDz
         jlFQ==
X-Gm-Message-State: AGi0PuZxT79a3IbGZQ51qACE24Bj4FTtfguiHmu8EPTIFrQvJ/BzNddc
        q/7eCZ1/qqL7jJ/zsG48VpnIGA==
X-Google-Smtp-Source: APiQypKs7/83y9Fy2tkC+anfR2Z5fLWFUYcXTlQfFzq+XRDx4OvJDfxmyT3B/ozTjq84cb6AEEtRrQ==
X-Received: by 2002:ac8:4686:: with SMTP id g6mr17447463qto.144.1589212625970;
        Mon, 11 May 2020 08:57:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id q17sm8637971qkq.111.2020.05.11.08.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 08:57:05 -0700 (PDT)
Date:   Mon, 11 May 2020 11:56:46 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: effective memory.high reclaim for remote charging
Message-ID: <20200511155646.GB306292@cmpxchg.org>
References: <20200507163301.229070-1-shakeelb@google.com>
 <20200507164653.GM6345@dhcp22.suse.cz>
 <CALvZod5TmAnDoueej1nu5_VV9rQa6VYVRXqCYuh63P5HN-o9Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5TmAnDoueej1nu5_VV9rQa6VYVRXqCYuh63P5HN-o9Sw@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 07, 2020 at 10:00:07AM -0700, Shakeel Butt wrote:
> On Thu, May 7, 2020 at 9:47 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 07-05-20 09:33:01, Shakeel Butt wrote:
> > [...]
> > > @@ -2600,8 +2596,23 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> > >                               schedule_work(&memcg->high_work);
> > >                               break;
> > >                       }
> > > -                     current->memcg_nr_pages_over_high += batch;
> > > -                     set_notify_resume(current);
> > > +
> > > +                     if (gfpflags_allow_blocking(gfp_mask))
> > > +                             reclaim_over_high(memcg, gfp_mask, batch);
> > > +
> > > +                     if (page_counter_read(&memcg->memory) <=
> > > +                         READ_ONCE(memcg->high))
> > > +                             break;
> >
> > I am half way to a long weekend so bear with me. Shouldn't this be continue? The
> > parent memcg might be still in excess even the child got reclaimed,
> > right?
> >
> 
> The reclaim_high() actually already does this walk up to the root and
> reclaim from ones who are still over their high limit. Though having
> 'continue' here is correct too.

If reclaim was weak and failed to bring the child back in line, we
still do set_notify_resume(). We should do that for ancestors too.

But it seems we keep adding hierarchy walks and it's getting somewhat
convoluted: page_counter does it, then we check high overage
recursively, and now we add the call to reclaim which itself is a walk
up the ancestor line.

Can we hitchhike on the page_counter_try_charge() walk, which already
has the concept of identifying counters with overage? Rename the @fail
to @limited and return the first counter that is in excess of its high
as well, even when the function succeeds?

Then we could ditch the entire high checking loop here and simply
replace it with

done_restock:
	...

	if (*limited) {
		if (gfpflags_allow_blocking())
			reclaim_over_high(memcg_from_counter(limited));
		/* Reclaim may not be able to do much, ... */
		set_notify_resume(); // or schedule_work()
	};

In the long-term, the best thing might be to integrate memory.high
reclaim with the regular reclaim that try_charge() is already
doing. Especially the part where it retries several times - we
currently give up on memory.high unnecessarily early. Make
page_counter_try_charge() fail on high and max equally, and after
several reclaim cycles, instead of invoking the OOM killer, inject the
penalty sleep and force the charges. OOM killing and throttling is
supposed to be the only difference between the two, anyway, and yet
the code diverges far more than that for no apparent reason.

But I also appreciate that this is a cleanup beyond the scope of this
patch here, so it's up to you how far you want to take it.
