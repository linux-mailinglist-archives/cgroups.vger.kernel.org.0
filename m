Return-Path: <cgroups+bounces-5079-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C50BF996901
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2024 13:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBBBA2831CE
	for <lists+cgroups@lfdr.de>; Wed,  9 Oct 2024 11:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8421922E4;
	Wed,  9 Oct 2024 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsCDDUHG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF476191F89;
	Wed,  9 Oct 2024 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474052; cv=none; b=eDsq8IuxLRjQ3Ie7eW/cHSqq+A4mN5WJo8nEY3l+yctCiG123dWd+YCrOMplgaPyreUeiso+0oWGSj/QgYE64CDHxeUQVQGwv8ZWfbSf3hYY/3q2U20x/6ew2S508d3ZLXUGlWHouvzgsptDQwvjtgBiSUu0th4usnQbtfM2OrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474052; c=relaxed/simple;
	bh=FT2KMG5h53JZOhVzRMt4RSbRREYJm88cj1GsvDfUpTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tl6KZxg1euoE3lF5+ti9CLaYz4uYjBXDcEUaoSoeUXLl6knwL0jtYQ7cBukrppz9xKxTKC1debw7SdeOTd4IoMEl+yTKo5Kg99sf9KwDbHvAr9O9W6Vd+cezHuaZWOuQ/Zaw7u9exxfzsEXsCWbOaUhU0wdWTRb9v3NvIgCTX5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsCDDUHG; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b10e800ba9so32891385a.1;
        Wed, 09 Oct 2024 04:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728474050; x=1729078850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OythqGlQpGAGT38/tfPAfmPoMpgRaqUCqi1/W2DvSl8=;
        b=dsCDDUHGPjqD8N5nmZRliXc8461+S76VDH9rPkkWX9J+3m7YTiggPKMOKcfB3ILw6B
         Fh0pvudke3xb4DNORusubRUZerjS7uoizJAT1A3RE49ZR3DCfvsLVj1mNdpnLqZTin70
         uTroij6NKukCXJuq9DhuRL9+eyq+ZvEmpYML4AVvBH+XHciT9w1xl6mLSGZyT5KR9G/j
         aO3ckkpjj3g4skmPiDlMnDwKUVXiDYCtU3oPtUBrh0UQkmkT1DskEJ9990EoRzI9nMMp
         KOMMpJBDhP8OZnRTMI6BDJiNXdQRISNHKblr3kOmiOsAM+2GQd9jU+yIxc200f6zPwbk
         pmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728474050; x=1729078850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OythqGlQpGAGT38/tfPAfmPoMpgRaqUCqi1/W2DvSl8=;
        b=jncU/Oufcq2xOJkFFvywxveMHbjwAVVe7UL9ob05sIj+39DBHNMK5a0KHE7pAyNvsc
         xA0P3viW5Mwq4GMw7p6xwW2ceIyGXqZEkRZElf4EPPQRMXbuDh1J7GkzMQmfgqmHnoWU
         t2kirsmIA8RzIDL5iXuqMlK2SxuM+SsQHYyK6NXCw/A34NPFewMTD1aiw12q4zGHy/YK
         Dc+fHS0qXRq2l+rp5cHSzRpDI+ncuepxN8leYZgiXQh42C/wHR2AIqkGR7In7NMibHL2
         CNRs+01F/9X6iWV/qRO5PxRnE0GNlZRomU8g0EiJjehEnWGXAD+AnCjg/IjC9wrLbty2
         cd3g==
X-Forwarded-Encrypted: i=1; AJvYcCU4KZTtsAH+qSSSSMNuWsdZYfn444GDRu67ksF/tqBWXEl2oFIyqDsPRzZzw4rXLQC3+I1ZIOPX3EBGtkzc@vger.kernel.org, AJvYcCXmTJxhXG3ZdAiC/U3JhmATY797jKaioLxBRIb8Y32cIptxDUlVTAZx54P5SEwLvOjTpiSShgr+@vger.kernel.org
X-Gm-Message-State: AOJu0YxtXnoxAHr4N/SAbrVhOo7R2wblyLHK//fQWrpJd5x9zeWGe1JN
	r7uT5MRRkzxm85TbaPO0q279ESrNPSnSBZgJEoBNjrvH6Rkw6BB3jICpU07svBcDvrS+M0B5+hK
	Q1uI+Eu6OpB2dLlcyVMKDtH7SPOI=
X-Google-Smtp-Source: AGHT+IGW/RE9FG08aT38nBo9K0MSxdlIbBWYtfLyJdRRkYarzPnOT79nNRhkN/dFnJT3lnlNuu99qI+QqLDF8Tot+U4=
X-Received: by 2002:a05:6214:3f86:b0:6cb:c832:7f9b with SMTP id
 6a1803df08f44-6cbc9118e57mr49861276d6.17.1728474049908; Wed, 09 Oct 2024
 04:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008061951.3980-1-laoar.shao@gmail.com> <20241008061951.3980-5-laoar.shao@gmail.com>
 <20241008142129.GB6937@cmpxchg.org>
In-Reply-To: <20241008142129.GB6937@cmpxchg.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 9 Oct 2024 19:40:13 +0800
Message-ID: <CALOAHbCg08ARz4-8=4+28gb+DnHxQFdxiJTLSoD6xAoea5E_FQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] sched: Fix cgroup irq accounting for CONFIG_IRQ_TIME_ACCOUNTING
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, surenb@google.com, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 10:23=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Tue, Oct 08, 2024 at 02:19:51PM +0800, Yafang Shao wrote:
> > @@ -5587,7 +5587,24 @@ void sched_tick(void)
> >       rq_lock(rq, &rf);
> >
> >       curr =3D rq->curr;
> > -     psi_account_irqtime(rq, curr, NULL);
> > +
> > +#ifdef CONFIG_IRQ_TIME_ACCOUNTING
> > +     if (static_branch_likely(&sched_clock_irqtime)) {
> > +             u64 now, irq;
> > +             s64 delta;
> > +
> > +             now =3D cpu_clock(cpu);
> > +             irq =3D irq_time_read(cpu);
> > +             delta =3D (s64)(irq - rq->psi_irq_time);
> > +             if (delta > 0) {
> > +                     rq->psi_irq_time =3D irq;
> > +                     psi_account_irqtime(rq, curr, NULL, now, delta);
> > +                     cgroup_account_cputime(curr, delta);
> > +                     /* We account both softirq and irq into softirq *=
/
> > +                     cgroup_account_cputime_field(curr, CPUTIME_SOFTIR=
Q, delta);
> > +             }
> > +     }
> > +#endif
> >
> >       update_rq_clock(rq);
> >       hw_pressure =3D arch_scale_hw_pressure(cpu_of(rq));
> > @@ -6667,7 +6684,25 @@ static void __sched notrace __schedule(int sched=
_mode)
> >               ++*switch_count;
> >
> >               migrate_disable_switch(rq, prev);
> > -             psi_account_irqtime(rq, prev, next);
> > +
> > +#ifdef CONFIG_IRQ_TIME_ACCOUNTING
> > +             if (static_branch_likely(&sched_clock_irqtime)) {
> > +                     u64 now, irq;
> > +                     s64 delta;
> > +
> > +                     now =3D cpu_clock(cpu);
> > +                     irq =3D irq_time_read(cpu);
> > +                     delta =3D (s64)(irq - rq->psi_irq_time);
> > +                     if (delta > 0) {
> > +                             rq->psi_irq_time =3D irq;
> > +                             psi_account_irqtime(rq, prev, next, now, =
delta);
> > +                             cgroup_account_cputime(prev, delta);
> > +                             /* We account both softirq and irq into s=
oftirq */
> > +                             cgroup_account_cputime_field(prev, CPUTIM=
E_SOFTIRQ, delta);
> > +                     }
> > +             }
> > +#endif
>
> This should be inside its own function - to avoid duplication of
> course, but also the ifdefs and overly detailed accounting code in the
> middle of core scheduling logic.
>
> #ifdef CONFIG_IRQ_TIME_ACCOUNTING
> static void account_irqtime(struct rq *rq, ...)
> {
>         ...
> }
> #else
> static inline void account_irqtime(...) {}
> #endif

Good suggestion. Will do it in the next version.

--=20
Regards
Yafang

