Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457981C96F8
	for <lists+cgroups@lfdr.de>; Thu,  7 May 2020 19:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgEGRAX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 May 2020 13:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726222AbgEGRAW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 May 2020 13:00:22 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F14C05BD09
        for <cgroups@vger.kernel.org>; Thu,  7 May 2020 10:00:20 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a21so7078532ljj.11
        for <cgroups@vger.kernel.org>; Thu, 07 May 2020 10:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9a51Q0KJvE3zrPblIKzTSl+tjTR3Bde3DH99HzeKLKI=;
        b=ibg8qmwWjVbS3FUiaxBOHr54QL17/uXAfjcKOSAWUMg75VnfQ93AsgVqCEi9PMtWa9
         HLbY16J7t69k2RWxnYhd/nFAHBX8h3Z1/xTqVnT0oYVo74D17A5Y3MTeNlGz7fBMpBG+
         gIkD5dglHn0fGdlGpiGoATeuiRXrUnkhRv3NyDPc1iSW2Qf4f/L7pnSVxV7/3Jf6IesD
         QsrAE1xP8S7h0EEY6/UjSupjkRjY7AKKm3ZQRAphuMi58y8g3fwNHfqtC76KvN2c5JHo
         J8kqfHofQwpOmg+u3p8lOMam4gk5lYN/2zzv/jGpP+lwgauKVKvj70nyhy4XNmrlLN6i
         QWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9a51Q0KJvE3zrPblIKzTSl+tjTR3Bde3DH99HzeKLKI=;
        b=F/PtLA7oPBVmkuME+OtI1v0Klcgr9ZOJ8t21b3uFRPm/mPGU41LbVdGcQ/C16m3wla
         TuOzB8XghWktd6iDURPW4WNEoGXNZR8LXVw1gb8Tpc3nJ6c+q2fMMPb9NuVKj8zZJPbI
         9AJqSqfQKhg9853SC+Ju6Y1UL22phj9kOGOvjNX050HgoEl2XlmZZpYjh8GUGLVoUA6i
         60jhDwUBI1P6voNKLZJWrT2ghwCDZ2OhP4M6GOv6prTv2CNFjmlzdZvFpTlfBAPpYSJq
         rVLZvyQUfcenQgdkUTM9M5KJoMV194+mKVHfHjpcYfLMEhBABUctfVmKSLGqRo5M5wzK
         yIbQ==
X-Gm-Message-State: AGi0PuYtksRyZCwXVZtjXhZrVqUa0Oph1V0Nm5GRXTGvz8RCyuoIn6ov
        WpLPJkS4+dohs+CRcYudEiqMkPVRIioAPIjOjvU2aQ==
X-Google-Smtp-Source: APiQypIyhbO51v7FfjXwxImM/+MjAA3HzPk6zunC+xStgsr9vkliLLFc7Iea0dnB3vM4lCl1ShWZ4lFbSgpYKbYdzdE=
X-Received: by 2002:a2e:9713:: with SMTP id r19mr9127689lji.89.1588870818402;
 Thu, 07 May 2020 10:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200507163301.229070-1-shakeelb@google.com> <20200507164653.GM6345@dhcp22.suse.cz>
In-Reply-To: <20200507164653.GM6345@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 7 May 2020 10:00:07 -0700
Message-ID: <CALvZod5TmAnDoueej1nu5_VV9rQa6VYVRXqCYuh63P5HN-o9Sw@mail.gmail.com>
Subject: Re: [PATCH] memcg: effective memory.high reclaim for remote charging
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 7, 2020 at 9:47 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 07-05-20 09:33:01, Shakeel Butt wrote:
> [...]
> > @@ -2600,8 +2596,23 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >                               schedule_work(&memcg->high_work);
> >                               break;
> >                       }
> > -                     current->memcg_nr_pages_over_high += batch;
> > -                     set_notify_resume(current);
> > +
> > +                     if (gfpflags_allow_blocking(gfp_mask))
> > +                             reclaim_over_high(memcg, gfp_mask, batch);
> > +
> > +                     if (page_counter_read(&memcg->memory) <=
> > +                         READ_ONCE(memcg->high))
> > +                             break;
>
> I am half way to a long weekend so bear with me. Shouldn't this be continue? The
> parent memcg might be still in excess even the child got reclaimed,
> right?
>

The reclaim_high() actually already does this walk up to the root and
reclaim from ones who are still over their high limit. Though having
'continue' here is correct too.

> > +                     /*
> > +                      * The above reclaim might not be able to do much. Punt
> > +                      * the high reclaim to return to userland if the current
> > +                      * task shares the hierarchy.
> > +                      */
> > +                     if (current->mm && mm_match_cgroup(current->mm, memcg)) {
> > +                             current->memcg_nr_pages_over_high += batch;
> > +                             set_notify_resume(current);
> > +                     } else
> > +                             schedule_work(&memcg->high_work);
> >                       break;
> >               }
> >       } while ((memcg = parent_mem_cgroup(memcg)));
> > --
> > 2.26.2.526.g744177e7f7-goog
> >
>
> --
> Michal Hocko
> SUSE Labs
