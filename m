Return-Path: <cgroups+bounces-9307-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85947B301D6
	for <lists+cgroups@lfdr.de>; Thu, 21 Aug 2025 20:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3621A1CE5452
	for <lists+cgroups@lfdr.de>; Thu, 21 Aug 2025 18:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71F8284687;
	Thu, 21 Aug 2025 18:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ag5Xgjuj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DAD19EED3
	for <cgroups@vger.kernel.org>; Thu, 21 Aug 2025 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800177; cv=none; b=huz1olIQH5yYtuCZEkciKawJZBnTyo3/30TKkH9HETexICa5POb4tMRy8LoyEIWm3/UMVaHnuIxbbOBmsNRDjZZ2LU0su47xmu/XbHIQpHFdv869YU9lhu5RjxKDbuPhinDFNvOnOvIhGIvwuJGE+EBxNdccJ6prHbWCyoUCOCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800177; c=relaxed/simple;
	bh=hDqzdK67aNuhe/bUVwwb1jo/Xv67HuCol2GYLCffAlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WiA4Jx9c0SBB3/7VZno7ML/XplW5jh6BtLL6zoH4tBL6SVgjupMEaX3bGszPP99yUtzuZ1uq7oqJDAU8x5PkFfY9PAcVb65YuU8/C3wlmIn0K5A9OGtXlx1Aa2f3P4vuND9M9pKRydlwkLiugcd88+WdAtnpo/vZno5b6nGcVBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ag5Xgjuj; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e9503150139so1323500276.2
        for <cgroups@vger.kernel.org>; Thu, 21 Aug 2025 11:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755800174; x=1756404974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9/oELP0413f2vQDazoVmFhVHsn1S2Y0CDApUKooico=;
        b=Ag5XgjujgLGH2DxRTsthry3A8MVn3DRbcq8cECYcXwuBui0EM5A2ulsBffqN6ivaU1
         R/JbE5qppBMPLJ8/1GYWeKEdDwEN03t0yPcRqHPQ4PXlzDg61d1VrsJAssDEPUDayoS4
         FyRau2m+IliAHNhRRu1xzmOg7SK8A+97C2mjsHRdbyarwiOQdT9KRE80xrD6DwF7xDw0
         6+fFY+x5RZY+ceG5Yrg2S/Rqzb7ZyYzNyJ0NH4tudTGDMMkAQA6CX/Gxh9Fpgx1eP+Ny
         AsTPF0PuWhU5oc8hldv2GW4UQ6qZ4N5i+zc8ELMJR6EOIj8A/Gynnu8P+Tsr1SgB4Rm9
         vTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755800174; x=1756404974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9/oELP0413f2vQDazoVmFhVHsn1S2Y0CDApUKooico=;
        b=oZb1BsrSH4IohT91JypscGu22pT3gllSdWU68pOM2JuV59NeO6hWtz68CjKQPMC5w+
         11wKX4kF5S/nobmfiTP3zMAoXHNHeSKWCezvGimaaIPlDdjL5TVgjrCOmDhaCjNfPXVu
         iYmsnginlxlgU+yJOfKVDtkLIFVbOId0LdB7v6oAMov66/+yNykTY2W0iVo4y02Q53GG
         KXbbigPRyUyNLNsEqcjHy8YDO9sjCc+SRSkkZ8/TSdMQT3tTQ+A1FIOsLi6teZa2xS2z
         Oni9yz+D64BiwV4sy6NMSJae38zDTAix9AXrVjzFY9rZqigHyvIZtrc9cafL6MVgvy4p
         AP8g==
X-Forwarded-Encrypted: i=1; AJvYcCUQLHrH6cUiZ2ivj2XdEdobdEV0PNzW1RLzTeNL1rI3D04Ydj11qH0FC9CZKSGQb+yTd1UkJou3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Zu74T+q7qP1e9wmhqNL/spR61/lYKm/y9YBxCdDLP64FpjeN
	p95g+iU1ygwJbarPgXKCgIUraGBckgAu3ah+EvRQch2tnNyL13ODaHwrj2fdoiNGxlIgJnGrbdp
	TGsTaAG8dRdQ0a1rzetOUG645OgMUVuI2X4ciTMtCsA==
X-Gm-Gg: ASbGncs3hbmP6dsTeHzZcUJhSGV5dNE3jtG1qqBPi8+TnW7ysR1mxi6RXR1eBHrbFEP
	bIEhR5+DFxTxxvl3Fc5CUKrBsush2AoPmYWY5iPATARmNzyYJnGpJE6H7PcfwIftEwzpTy0Zn32
	IJ6NnHBQa7D8S9a+Rn5mevUkrWQY71XP5WViZ6uPqOH3xw+pOKXx6yVDGuaBjSfJJ31iuKZP7+v
	bkuajndplhYtIbBIe9y+8U=
X-Google-Smtp-Source: AGHT+IE3bh28/Gt8RcxbTvDGB2ZwCKqcAEFwLVbLaQ1ETaz0DQgFhU7c2HeE+tfwYm/vwZ38OnbEAKkCkSN20XXIc+A=
X-Received: by 2002:a05:6902:2086:b0:e95:16fe:f257 with SMTP id
 3f1490d57ef6-e951c2e8178mr706872276.15.1755800174337; Thu, 21 Aug 2025
 11:16:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
 <20250820111940.4105766-4-sunjunchao@bytedance.com> <aKY2-sTc5qQmdea4@slm.duckdns.org>
 <CAHSKhtf--qn3TH3LFMrwqb-Nng2ABwV2gOX0PyAerd7h612X5Q@mail.gmail.com>
 <aKdQgIvZcVCJWMXl@slm.duckdns.org> <CAHSKhtdhj-AuApc8yw+wDNNHMRH-XNMVD=8G7Mk_=1o2FQASQg@mail.gmail.com>
In-Reply-To: <CAHSKhtdhj-AuApc8yw+wDNNHMRH-XNMVD=8G7Mk_=1o2FQASQg@mail.gmail.com>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Fri, 22 Aug 2025 02:16:00 +0800
X-Gm-Features: Ac12FXzSKuEp-w5_Lomw3unO-QADLCAsMZrvOlvz_slkZscwz7__XKmzGfNsSag
Message-ID: <CAHSKhtcxL0qN2M_yfA7N3yF1JrzRaMafQ+fnjmFzaxPCLSda0g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] memcg: Don't wait writeback completion
 when release memcg.
To: Tejun Heo <tj@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 2:00=E2=80=AFAM Julian Sun <sunjunchao@bytedance.co=
m> wrote:
>
> Hi,
>
> On Fri, Aug 22, 2025 at 12:59=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> > On Thu, Aug 21, 2025 at 10:30:30AM +0800, Julian Sun wrote:
> > > On Thu, Aug 21, 2025 at 4:58=E2=80=AFAM Tejun Heo <tj@kernel.org> wro=
te:
> > > >
> > > > On Wed, Aug 20, 2025 at 07:19:40PM +0800, Julian Sun wrote:
> > > > > @@ -3912,8 +3921,12 @@ static void mem_cgroup_css_free(struct cgr=
oup_subsys_state *css)
> > > > >       int __maybe_unused i;
> > > > >
> > > > >  #ifdef CONFIG_CGROUP_WRITEBACK
> > > > > -     for (i =3D 0; i < MEMCG_CGWB_FRN_CNT; i++)
> > > > > -             wb_wait_for_completion(&memcg->cgwb_frn[i].done);
> > > > > +     for (i =3D 0; i < MEMCG_CGWB_FRN_CNT; i++) {
> > > > > +             struct wb_completion *done =3D memcg->cgwb_frn[i].d=
one;
> > > > > +
> > > > > +             if (atomic_dec_and_test(&done->cnt))
> > > > > +                     kfree(done);
> > > > > +     }
> > > > >  #endif
> > > >
> > > > Can't you just remove done? I don't think it's doing anything after=
 your
> > > > changes anyway.
> > >
> > > Thanks for your review.
> > >
> > > AFAICT done is also used to track free slots in
> > > mem_cgroup_track_foreign_dirty_slowpath() and
> > > mem_cgroup_flush_foreign(), otherwise we have no method to know which
> > > one is free and might flush more than what MEMCG_CGWB_FRN_CNT allow.
> > >
> > > Am I missing something?
> >
> > No, I missed that. I don't think we need to add extra mechanisms in wb =
for
> > this tho. How about shifting wb_wait_for_completion() and kfree(memcg) =
into
> > a separate function and punt those to a separate work item? That's goin=
g to
> > be a small self-contained change in memcg.
> >
>
> Do you mean logic like this?
>
>     for (i =3D 0; i < MEMCG_CGWB_FRN_CNT; i++)
>         wb_wait_for_completion(&memcg->cgwb_frn[i].done);
>     kfree(memcg);
>
> But there still exist task hang issues as long as
> wb_wait_for_completion() exists.
> I think the scope of impact of the current changes should be
> manageable. I have checked all the other places where wb_queue_work()
> is called, and their free_done values are all 0, and I also tested
> this patch with the reproducer in [1] with kasan and kmemleak enabled.
> The test result looks fine, so this should not have a significant
> impact.

BTW, the test case is like this =E2=80=94 it ran for over a night.
    while true; do ./repro.sh && sleep 300 && ./stop.sh; done

sjc@debian:~/linux$ cat stop.sh
#!/bin/bash
#

TEST=3D/sys/fs/cgroup/test
A=3D$TEST/A
B=3D$TEST/B
echo "-memory" > $TEST/cgroup.subtree_control
pkill write-range

sync
sleep 5
sync
sleep 5
echo 3 > /proc/sys/vm/drop_caches

rmdir $A $B

> What do you think?
>
> [1]: https://lore.kernel.org/all/20190821210235.GN2263813@devbig004.ftw2.=
facebook.com/
> > Thanks.
> >
> > --
> > tejun
>
>
> Thanks,
> --
> Julian Sun <sunjunchao@bytedance.com>


Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>

