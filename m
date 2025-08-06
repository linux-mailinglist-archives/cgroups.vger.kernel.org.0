Return-Path: <cgroups+bounces-8997-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 028F3B1C331
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 11:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14F0189FFFF
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 09:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993F7288CA1;
	Wed,  6 Aug 2025 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yqH5iT5D"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCCB28982B
	for <cgroups@vger.kernel.org>; Wed,  6 Aug 2025 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754472170; cv=none; b=o5YueLcKjxHelwezW/Ein7vpRWPSS97BSCuxB2Xe2QingPX+CZeN2jQP80dOsftYPL5owMxjbUun7BpJ/4Nsa4HORKcVkSOJtaZkwcPGHjUOGO0JIUf5MQCSTtwUeSg9KpOCtFgYBGkLS/7IStSqUQaQf5JLO8S2ZrlEIMekZTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754472170; c=relaxed/simple;
	bh=XjDPLc5/WGRQW8rxnHkXlCo9U7biztDlbJgoFDjgDyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFO1KGWOQalwXklSlC+0jtseeuuVBYySscksqU5B3z9pWS9L1Ww3Un356dwjuOCEPIELGKhBokIM4tgQoxGcQXY9wnkL8Fk+U2lM51ztiJqof0/T8cTIOtCEKOeyh7i86wTLZcuJMbRXrhw60n9IiXLpOUX4s71g4W1GK/Tn9xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yqH5iT5D; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-615460d9897so7636442a12.0
        for <cgroups@vger.kernel.org>; Wed, 06 Aug 2025 02:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754472166; x=1755076966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eZ8Cxbl+PdyaltjEvWGRoEfuwACW3Jt5gpyDRZMeagQ=;
        b=yqH5iT5DfqJ9H16GcHkFJoreKfdoLCFAKMrjT9CMcblyBaeH6My3LlR98hcjqoKCiu
         O3HiQSsB8gc8ZkpPJxlRGv3LYmymbTwLAXt70znmaLOitUV+ASLLts0tjZhVfex7AOIq
         XSAk6mLHnvsy1uWjWcyBLqb9op+jB7kVPLN4iYqHYuV8src59ONzyGNWpIY8M/TAMKDX
         qavuZcSPd+uM2CVVMjPEIGCzAuMRP0wE4FdwzL3UvPkYD9IL/jWsH4V1vMoXEQ6xRlWv
         LSfUGEv8tY06kwc8fevphblFutAhLMEC/DjgRNHUp+zxQqHAAfw5nzVnARB76OsqoT58
         kUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754472166; x=1755076966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eZ8Cxbl+PdyaltjEvWGRoEfuwACW3Jt5gpyDRZMeagQ=;
        b=w+k7wk6XNOi91qTD+ohjA/twecsJsonKhLbtSMtpezVwyAkPSz6AcN9NN/mteH11P3
         AJhhKrkWF3XzHrQCq4BsjiMWDTfCdhptCWeMucKOD8lLEqNeF7x31FuvN14Ngis/3xnK
         rFNQtB0Mnprvg6+LpP/x4gn7IREsxkURRWk4iM7LKjd2iUpfdk0ZofU//XSrjE91I8RZ
         uApxEGnKqqrvd2QjlsvOkAuimkF7Jsk4/yOf7JGVT+uZIdy+ownln9iMJ5denPqaUyYP
         LVJYRf5wrI2KdKwVWgm1a4m29iTezfI1pU+vskE5Dv0I3MH+WtQJlkz7+hXfU+mes8XL
         04Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXihVY9zjqeLB9NiWzunQMgD1ZeiEIO4PPvIx1WfD7jTkZdQoWuZaOduRNebr5HaLMXLxPYqMxI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+HKIGOyEM79JQcA75kaSO81YL1bb++ZnI1lyjxcaoVyByjhAz
	Ec8BDkafHREj4aYhzOIDyFh9lqGYyN4vktD7ECOHImIMAurDJVyHzt/m/T+7md6Ka5ZmBvRlofC
	ivMlB1a7KtOmiWajLA2IByIigouPqSDdQatR7T509vA==
X-Gm-Gg: ASbGncsKlooEdboyKAN7Wo0U9oZKlhvr1sBvgqdRwLyV93jNHOMPqSolE0xXoTlmOQ6
	y0g2u8AwcR+AbNp6VWfcd3O3Ssr1i73ROtGaTBswVLhckKewimeLZ0A0Nv1pjXL6OgiicRg7s6r
	mAYYD5N2My4iDgXiNZaW+bueRxbN4k/vy82jYkJbA+4y9JBrSlAtlHFJ9YK03AApFiHmHP0QDr+
	Yn7F1M3PTLpXylrvd0lK/KQwKYTZIW9pMCh
X-Google-Smtp-Source: AGHT+IH5W+hv/msC6rExWwiLgguba5dhm/ihYnpT1zWBg6HxYotiILQp73e1b2tJTMHl/VvkYzFwTVd7xmqaygIFwGo=
X-Received: by 2002:a17:907:7f0d:b0:ae0:bee7:ad7c with SMTP id
 a640c23a62f3a-af9904565e6mr188068166b.46.1754472165805; Wed, 06 Aug 2025
 02:22:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806071848.GA629@bytedance> <20250806083810.27678-1-xupengbo@oppo.com>
In-Reply-To: <20250806083810.27678-1-xupengbo@oppo.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 6 Aug 2025 11:22:33 +0200
X-Gm-Features: Ac12FXxHPZZcVOPKjgJc_OpCyPVwI9FBvM5bTacN09V_nzgfs_Dlg-CR2f2W6NU
Message-ID: <CAKfTPtCDCS_wzaOFzMLcfNafu8PpifXXpkpYYA-f1u1dPb7kng@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Fix unfairness caused by stalled
 tg_load_avg_contrib when the last task migrates out.
To: xupengbo <xupengbo@oppo.com>
Cc: ziqianlu@bytedance.com, bsegall@google.com, cgroups@vger.kernel.org, 
	dietmar.eggemann@arm.com, juri.lelli@redhat.com, linux-kernel@vger.kernel.org, 
	mgorman@suse.de, mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Aug 2025 at 10:38, xupengbo <xupengbo@oppo.com> wrote:
>
> On Wed, Aug 06, 2025 at 02:31:58PM +0800, xupengbo wrote:
> > > >On Tue, 5 Aug 2025 at 16:42, xupengbo <xupengbo@oppo.com> wrote:
> > > > >
> > > > > When a task is migrated out, there is a probability that the tg->load_avg
> > > > > value will become abnormal. The reason is as follows.
> > > > >
> > > > > 1. Due to the 1ms update period limitation in update_tg_load_avg(), there
> > > > > is a possibility that the reduced load_avg is not updated to tg->load_avg
> > > > > when a task migrates out.
> > > > > 2. Even though __update_blocked_fair() traverses the leaf_cfs_rq_list and
> > > > > calls update_tg_load_avg() for cfs_rqs that are not fully decayed, the key
> > > > > function cfs_rq_is_decayed() does not check whether
> > > > > cfs->tg_load_avg_contrib is null. Consequently, in some cases,
> > > > > __update_blocked_fair() removes cfs_rqs whose avg.load_avg has not been
> > > > > updated to tg->load_avg.
> > > > >
> > > > > I added a check of cfs_rq->tg_load_avg_contrib in cfs_rq_is_decayed(),
> > > > > which blocks the case (2.) mentioned above. I follow the condition in
> > > > > update_tg_load_avg() instead of directly checking if
> > > > > cfs_rq->tg_load_avg_contrib is null. I think it's necessary to keep the
> > > > > condition consistent in both places, otherwise unexpected problems may
> > > > > occur.
> > > > >
> > > > > Thanks for your comments,
> > > > > Xu Pengbo
> > > > >
> > > > > Fixes: 1528c661c24b ("sched/fair: Ratelimit update to tg->load_avg")
> > > > > Signed-off-by: xupengbo <xupengbo@oppo.com>
> > > > > ---
> > > > > Changes:
> > > > > v1 -> v2:
> > > > > - Another option to fix the bug. Check cfs_rq->tg_load_avg_contrib in
> > > > > cfs_rq_is_decayed() to avoid early removal from the leaf_cfs_rq_list.
> > > > > - Link to v1 : https://lore.kernel.org/cgroups/20250804130326.57523-1-xupengbo@oppo.com/T/#u
> > > > >
> > > > >  kernel/sched/fair.c | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > >
> > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > > index b173a059315c..a35083a2d006 100644
> > > > > --- a/kernel/sched/fair.c
> > > > > +++ b/kernel/sched/fair.c
> > > > > @@ -4062,6 +4062,11 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> > > > >         if (child_cfs_rq_on_list(cfs_rq))
> > > > >                 return false;
> > > > >
> > > > > +       long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> > > > > +
> > > > > +       if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64)
> > > >
> > > >I don't understand why you use the above condition instead of if
> > > >(!cfs_rq->tg_load_avg_contrib). Can you elaborate ?
>
> Sorry I was misled here, I think it should be if (cfs_rq->tg_load_avg_contrib ! = 0)

yes I made a mistake. It should be
if (cfs_rq->tg_load_avg_contrib ! = 0)
or
if (cfs_rq->tg_load_avg_contrib)

>
> > > >
> > > >strictly speaking we want to keep the cfs_rq in the list if
> > > >(cfs_rq->tg_load_avg_contrib != cfs_rq->avg.load_avg) and
> > > >cfs_rq->avg.load_avg == 0 when we test this condition
> > >
> > >
> > > I use this condition primarily based on the function update_tg_load_avg().
> > > I want to absolutely avoid a situation where cfs_rq_is_decay() returns
> > > false but update_tg_load_avg() cannot update its value due to the delta
> > > check, which may cause the cfs_rq to remain on the list permanently.
> > > Honestly, I am not sure if this will happen, so I took this conservative
> > > approach.
> >
> > Hmm...it doesn't seem we need worry about this situation.
>
> yeah, I am worried about this situation, but I can't find any evidence
> that it exists.
>
> > Because when cfs_rq->load_avg is 0, abs(delta) will be
> > cfs_rq->tg_load_avg_contrib and the following condition:
> >
> >       if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64)
> > becomes:
> >       if (cfs_rq->tg_load_avg_contrib > cfs_rq->tg_load_avg_contrib / 64)
> >
> > which should always be true, right?
>
>
> It actually becomes:
>     if (cfs_rq->tg_load_avg_contrib > 0)
> if cfs_rq->tg_load_avg_contrib == 0 , it will be false. As it is an unsigned
> long, this condition is equivalent to :
>     if (cfs_rq->tg_load_avg_contrib)
>
> Sorry I just made a mistake.
> Thanks,
> Xupengbo
>
> > Thanks,
> > Aaron
> >
> > >
> > > In fact, in the second if-condition of cfs_rq_is_decay(), the comment in
> > > the load_avg_is_decayed() function states:"_avg must be null when _sum is
> > > null because _avg = _sum / divider". Therefore, when we check this newly
> > > added condition, cfs_rq->avg.load_avg should already be 0, right?
> > >
> > > After reading your comments, I carefully considered the differences
> > > between these two approaches. Here, my condition is similar
> > > to cfs_rq->tg_load_avg_contrib != cfs_rq->avg.load_avg but weaker. In
> > > fact, when cfs_rq->avg.load_avg is already 0,
> > > abs(delta) > cfs_rq->tg_load_avg_contrib / 64 is equivalent to
> > > cfs_rq->tg_load_avg_contrib > cfs_rq->tg_load_avg_contrib / 64,
> > > Further reasoning leads to the condition cfs_rq->tg_load_avg_contrib > 0.
> > > However if cfs_rq->avg.load_avg is not necessarily 0 at this point, then
> > > the condition you propose is obviously more accurate, simpler than the
> > > delta check, and requires fewer calculations.
> > >
> > > I think our perspectives differ. From the perspective of
> > > update_tg_load_avg(), the semantics of this condition are as follows: if
> > > there is no 1ms update limit, and update_tg_load_avg() can continue
> > > updating after checking the delta, then in cfs_rq_is_decayed() we should
> > > return false to keep the cfs_rq in the list for subsequent updates. As
> > > mentioned in the first paragraph, this avoids that tricky situation. From
> > > the perspective of cfs_rq_is_decayed(), the semantics of the condition you
> > > proposed are that if cfs_rq->avg.load_avg is already 0, then it cannot be
> > > removed from the list before all load_avg are updated to tg. That makes
> > > sense to me, but I still feel like there's a little bit of a risk. Am I
> > > being paranoid?
> > >
> > > How do you view these two lines of thinking?
> > >
> > > It's a pleasure to discuss this with you,
> > > xupengbo.
> > >
> > > > > +               return false;
> > > > > +
> > > > >         return true;
> > > > >  }
> > > > >
> > > > > --
> > > > > 2.43.0
> > > > >
>

