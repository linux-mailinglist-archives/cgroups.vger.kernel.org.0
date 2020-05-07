Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA4F1C984C
	for <lists+cgroups@lfdr.de>; Thu,  7 May 2020 19:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgEGRtz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 May 2020 13:49:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37628 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgEGRtz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 May 2020 13:49:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id z6so7834916wml.2;
        Thu, 07 May 2020 10:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uzx7yPipGDJlLzd9pOfuRh3M2JP+Q1gSc82f3ElJ8zY=;
        b=SjSHKjg5wPelS7nsNbolhH2TI4JkNmfUEucLnOJLJf9QiVPOv+0J+0kz490Frs4sLN
         L4C4uz6hdW4H4iOXTQruVf0a9f+Wz/Vn7+HPsLSQMxEvW6JFY2FaCUFswU6ktMkycw7c
         wIP0CTLq6TVyOPtC8T1TPcYqQssWpIxTIynuuwVQT/XvdJhv+fMeSg5pTVj8XMxL2DTz
         lKSqbeuADNCTDzCm+Pr4U04ZvzyL4s2GJ1Ty0OQzk+2F+OHGgXvzQ5iqn7Mxr1YFau1s
         K/zv+p267aAB/vR0iyVoE7xTV+zbNIIGpfvP35F8MAhBKN62AEmtbd2EAvIVfii/qRXp
         gixw==
X-Gm-Message-State: AGi0PuaJsDBQWRjK+DjXDwGhvF4g2jpATOzvk7mMbmc3heFbra7D00Oo
        yC0ra2weRcj53WT1ttdt0z4=
X-Google-Smtp-Source: APiQypIzr87jhEXZelDUSzpK7Ud4dOVfvMCNVoLIJsfeJx8v5mGHEwPPoIyxRblXb/5q9zF8hQSNcQ==
X-Received: by 2002:a1c:1fc9:: with SMTP id f192mr12578342wmf.129.1588873792788;
        Thu, 07 May 2020 10:49:52 -0700 (PDT)
Received: from localhost (ip-37-188-183-9.eurotel.cz. [37.188.183.9])
        by smtp.gmail.com with ESMTPSA id k133sm9875442wma.0.2020.05.07.10.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 10:49:51 -0700 (PDT)
Date:   Thu, 7 May 2020 19:49:49 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: effective memory.high reclaim for remote charging
Message-ID: <20200507174949.GN6345@dhcp22.suse.cz>
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

On Thu 07-05-20 10:00:07, Shakeel Butt wrote:
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

Ohh, right. As I've said weekend brain. I will have a proper look next
week. This just hit my eyes.

-- 
Michal Hocko
SUSE Labs
