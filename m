Return-Path: <cgroups+bounces-8987-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EC5B1C160
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 09:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE013BC09F
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 07:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA5821B9E1;
	Wed,  6 Aug 2025 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VChw75VL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFC021859A
	for <cgroups@vger.kernel.org>; Wed,  6 Aug 2025 07:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754465626; cv=none; b=Q6ROrIIuynky20MNarTnVrbSBTOW2oxlftSMKf1mSrGWgHqbtyQrbSoqlIa6wjPvFyiCIt2RwxQb9lNvDXvMNca2e1oV25J3FkSfyFnJ/J+00QDwGW1A3pdbFsC7Y2KePbqsodKnNYsCQ0P18vT2xA4HgTJVxItNkhzw08wJWzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754465626; c=relaxed/simple;
	bh=s8rlzYmz4iwePlgb3helKr8vtnaDaeilcyW3MpNEcCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ij0RUO3Gu/X0k3dCm9t6dQleinvFwNMFx50mSbwtoWjq9OQhvNUhsqSOvD5KjglcdbJ4BdbLMrSVF59VeUTwPgeNEnffk60NNQiukWyMKBTlNa00UqaUUjNbOyaXBSafCGZ+2O4ineseCJ9P+nuMrMqXLTy8PYGWtDs6Hp6Nl/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VChw75VL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-74264d1832eso6149931b3a.0
        for <cgroups@vger.kernel.org>; Wed, 06 Aug 2025 00:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1754465622; x=1755070422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y6QkmT+leuKWjylaXUxOSu0eJ5GXAXHONEWqn2hIXhY=;
        b=VChw75VLT/Q0rY0caxnnH1X+pZXqjnzpXXLcjx4hArqimkXD29w0/1Of60JE7PhbgE
         DE3LnTD4swaKUXhDLIw3g/ZqNUk946oU34x39e84nTNI8MHEjVnbHZnzw49hk02vAQ+4
         iIc1oYYvxfVZY4h66T4etnLTBCZ1mZ8C/e/gXANevSB1iqYG7phzw55/RWQben3M3DJZ
         ZZ40avEzLzJl5dUHBeidPBLVRj4I3ulLH7WsZ1wyvAd0d0z9rMl45FsmLIsJgqlPKveP
         Qn4yEu7PWYqIJ7E3vXDw9m5IEWB7muo8ob7jx9SkJBYxJO/wqFJmXKp3J5UKLbg+B5U3
         VtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754465622; x=1755070422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6QkmT+leuKWjylaXUxOSu0eJ5GXAXHONEWqn2hIXhY=;
        b=gTzbhJQ4YQyzCCidCrykNH+dPRiHXeCoX/CXJo9LXWNgVTvCA/9N7pJQ7elPWL3uFO
         yrUWO/kwIVW7kADXYRyJoVYdZpyxwtuWAzB6Bs3l2l9pONkKZqwyUb64xFQJf3WuQ51P
         I7rKZEufhlbgn5cTRAVjMjG3uJeic1I4f54umTWo3FRNEc5/EvJHOSm40ckPv7Bt8pqZ
         d/2HkH0ILyLS41D88pHc+a91aq+R7XsR65bWfy+5h9/XwwTg6kaAJSrDigTrqTM2URd6
         /xTkYk/rUxN6T0w0ivql7FHyhBHO253plO7h4l5VN951zeM6yNdJsMswIqRlMgm+/bTp
         52lA==
X-Forwarded-Encrypted: i=1; AJvYcCVUQT/lXuCrE0NIHKTQgx2R9DBrh5gmPORadYPO5KL5IM2BPdBGynu/ejRMf8nv64wkoIXuAuJr@vger.kernel.org
X-Gm-Message-State: AOJu0YxSiPd0bQdtVM3hB4j5UtCZ0gw55bflV9PyQDURNz3mDvHPV4KO
	Dp0sOwQAT+ieUQ7B7ErqPqXAmBRslj0JDPDkC4/KVxcYRxjnMOjqjk00Kglw2rtaGQ==
X-Gm-Gg: ASbGncvrqMMQKzvInG1io8VoRamqEwfj4Bvop+lcqMLIsy9RO8RoF8lqNj07e50BSI4
	KZIWqsou0Q7wkHvEukREXMu3KPU8otqy1xuu8SwvNRczIuiA3OB7KYbZ5A3CYLrjZnBTgqC0GH0
	LpQKb/4lQJc08Lb7xOeeX5lWMN0jEXi/rkMbda4Inr0rsxvqpA8egDLCQhvOb+sxPUlUrYaVcNb
	SoPPSJh4uVQuJNyQwUTMOOAL0a3oOLx/SAoLafVj09azhGnJ3GXT73Ut/CgLEaIxLnlvYY4H7bx
	7rDWtRR40VzKbCugMG0p1Zit7EbAaBj3R1Pybyml/KWaxqYaLvBKc5ZBa625VmbPPx0SQeAhcK8
	PSLUfqxKCZ5sKRzt/TvleTmT1hP6m1rC0yAhQJiI4JGo=
X-Google-Smtp-Source: AGHT+IG448uyN0NVsDWe4oIm+CVEKb9fP1UL0cwxq9mjP7jR2d2c7ST2cbJQK+cDvXU/Y903bJXWLg==
X-Received: by 2002:a05:6a00:80e:b0:76b:ef0e:4912 with SMTP id d2e1a72fcca58-76c2b038195mr2333305b3a.20.1754465621377;
        Wed, 06 Aug 2025 00:33:41 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbce56sm14784943b3a.82.2025.08.06.00.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 00:33:40 -0700 (PDT)
Date: Wed, 6 Aug 2025 15:33:27 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: xupengbo <xupengbo@oppo.com>
Cc: vincent.guittot@linaro.org, bsegall@google.com, cgroups@vger.kernel.org,
	dietmar.eggemann@arm.com, juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
	peterz@infradead.org, rostedt@goodmis.org, vschneid@redhat.com
Subject: Re: [PATCH v2] sched/fair: Fix unfairness caused by stalled
 tg_load_avg_contrib when the last task migrates out.
Message-ID: <20250806071848.GA629@bytedance>
References: <CAKfTPtDexWX5N0jaMRqVQEnURSaPhVa6XQr_TexpU2SGU-e=9A@mail.gmail.com>
 <20250806063158.25050-1-xupengbo@oppo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806063158.25050-1-xupengbo@oppo.com>

On Wed, Aug 06, 2025 at 02:31:58PM +0800, xupengbo wrote:
> > >On Tue, 5 Aug 2025 at 16:42, xupengbo <xupengbo@oppo.com> wrote:
> > >
> > > When a task is migrated out, there is a probability that the tg->load_avg
> > > value will become abnormal. The reason is as follows.
> > >
> > > 1. Due to the 1ms update period limitation in update_tg_load_avg(), there
> > > is a possibility that the reduced load_avg is not updated to tg->load_avg
> > > when a task migrates out.
> > > 2. Even though __update_blocked_fair() traverses the leaf_cfs_rq_list and
> > > calls update_tg_load_avg() for cfs_rqs that are not fully decayed, the key
> > > function cfs_rq_is_decayed() does not check whether
> > > cfs->tg_load_avg_contrib is null. Consequently, in some cases,
> > > __update_blocked_fair() removes cfs_rqs whose avg.load_avg has not been
> > > updated to tg->load_avg.
> > >
> > > I added a check of cfs_rq->tg_load_avg_contrib in cfs_rq_is_decayed(),
> > > which blocks the case (2.) mentioned above. I follow the condition in
> > > update_tg_load_avg() instead of directly checking if
> > > cfs_rq->tg_load_avg_contrib is null. I think it's necessary to keep the
> > > condition consistent in both places, otherwise unexpected problems may
> > > occur.
> > >
> > > Thanks for your comments,
> > > Xu Pengbo
> > >
> > > Fixes: 1528c661c24b ("sched/fair: Ratelimit update to tg->load_avg")
> > > Signed-off-by: xupengbo <xupengbo@oppo.com>
> > > ---
> > > Changes:
> > > v1 -> v2:
> > > - Another option to fix the bug. Check cfs_rq->tg_load_avg_contrib in
> > > cfs_rq_is_decayed() to avoid early removal from the leaf_cfs_rq_list.
> > > - Link to v1 : https://lore.kernel.org/cgroups/20250804130326.57523-1-xupengbo@oppo.com/T/#u
> > >
> > >  kernel/sched/fair.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index b173a059315c..a35083a2d006 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -4062,6 +4062,11 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> > >         if (child_cfs_rq_on_list(cfs_rq))
> > >                 return false;
> > >
> > > +       long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> > > +
> > > +       if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64)
> > 
> >I don't understand why you use the above condition instead of if
> >(!cfs_rq->tg_load_avg_contrib). Can you elaborate ?
> > 
> >strictly speaking we want to keep the cfs_rq in the list if
> >(cfs_rq->tg_load_avg_contrib != cfs_rq->avg.load_avg) and
> >cfs_rq->avg.load_avg == 0 when we test this condition
> 
> 
> I use this condition primarily based on the function update_tg_load_avg().
> I want to absolutely avoid a situation where cfs_rq_is_decay() returns 
> false but update_tg_load_avg() cannot update its value due to the delta 
> check, which may cause the cfs_rq to remain on the list permanently. 
> Honestly, I am not sure if this will happen, so I took this conservative 
> approach.

Hmm...it doesn't seem we need worry about this situation.

Because when cfs_rq->load_avg is 0, abs(delta) will be
cfs_rq->tg_load_avg_contrib and the following condition:

	if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64)
becomes:
	if (cfs_rq->tg_load_avg_contrib > cfs_rq->tg_load_avg_contrib / 64)

which should always be true, right?

Thanks,
Aaron

> 
> In fact, in the second if-condition of cfs_rq_is_decay(), the comment in 
> the load_avg_is_decayed() function states:"_avg must be null when _sum is 
> null because _avg = _sum / divider". Therefore, when we check this newly 
> added condition, cfs_rq->avg.load_avg should already be 0, right?
> 
> After reading your comments, I carefully considered the differences 
> between these two approaches. Here, my condition is similar
> to cfs_rq->tg_load_avg_contrib != cfs_rq->avg.load_avg but weaker. In 
> fact, when cfs_rq->avg.load_avg is already 0, 
> abs(delta) > cfs_rq->tg_load_avg_contrib / 64 is equivalent to 
> cfs_rq->tg_load_avg_contrib > cfs_rq->tg_load_avg_contrib / 64,
> Further reasoning leads to the condition cfs_rq->tg_load_avg_contrib > 0.
> However if cfs_rq->avg.load_avg is not necessarily 0 at this point, then
> the condition you propose is obviously more accurate, simpler than the
> delta check, and requires fewer calculations.
> 
> I think our perspectives differ. From the perspective of 
> update_tg_load_avg(), the semantics of this condition are as follows: if
> there is no 1ms update limit, and update_tg_load_avg() can continue 
> updating after checking the delta, then in cfs_rq_is_decayed() we should
> return false to keep the cfs_rq in the list for subsequent updates. As 
> mentioned in the first paragraph, this avoids that tricky situation. From
> the perspective of cfs_rq_is_decayed(), the semantics of the condition you
> proposed are that if cfs_rq->avg.load_avg is already 0, then it cannot be
> removed from the list before all load_avg are updated to tg. That makes 
> sense to me, but I still feel like there's a little bit of a risk. Am I 
> being paranoid?
> 
> How do you view these two lines of thinking?
> 
> It's a pleasure to discuss this with you, 
> xupengbo.
> 
> > > +               return false;
> > > +
> > >         return true;
> > >  }
> > >
> > > --
> > > 2.43.0
> > >

