Return-Path: <cgroups+bounces-9306-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9411BB30198
	for <lists+cgroups@lfdr.de>; Thu, 21 Aug 2025 20:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B7918897BB
	for <lists+cgroups@lfdr.de>; Thu, 21 Aug 2025 18:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3AA3431E5;
	Thu, 21 Aug 2025 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Wx6OpSke"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E9430C340
	for <cgroups@vger.kernel.org>; Thu, 21 Aug 2025 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799224; cv=none; b=fNsrazUuB2muO+Ajd/eor8oJpxIQrnnjZu1K16uBSArV4dD8tHEZTW/GzLS4VEIleWmM75HySulKjLdRBrnkwkg6im7Cnj7xzpANpLJ1ZJgV01ZqPoyUma3LVEugTngQ4ELPfBN7/t0NTvWACpFi2soivG9im2XhNyOn2EK82Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799224; c=relaxed/simple;
	bh=2IBX6VJaYzIt3d8MSLKvykSIMbupgv/nCD5znMsyLf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjDHuPk5RRejToWkD83eQy571MleOVjQoTCnssi5dDoS2jcJtjbxrEdyzhrk7A9SJWAFTMNVJvyodGnS3kJ6Pnm6m4T7pe0jEeTyHh6K+Ulls2So7DSUVh8WfIJXwAmcKi34+H4rlsEnJFkw2jCX13hr1BqTnPmNp41eR/MURs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Wx6OpSke; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e9505d08ca2so1061671276.3
        for <cgroups@vger.kernel.org>; Thu, 21 Aug 2025 11:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755799221; x=1756404021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0lia9zAzQkMkj0u6l/RsjUG2VG0X8+ajRHGScPdguQ=;
        b=Wx6OpSkep5WbG02axiChwnA6yhuDLwR7Q/b5tcRB9gZzMc5FuHDQbdKz4abnCyR1H2
         PGfdScqC0DT9ymNLeXnkQ1QJf/Xt6KCETxwolUP7NpZ+Da3QZ5vZkQ/fLUr3BW6VegWO
         9PRVLxZO1ntqvcUNaUBfk6OSO3cNQ/xUAmdI78QMUOqUJu4Q8wBWUAUUTr2x+BrHUlHY
         soQKF+El42/3tEPKUJW0Kd4WDY8jA7mmHAAnalx8HTcCGCY1tQuQ+o4llCxuOvafPYEe
         /2fxmx+yq87c+pthNnzoN0Q2IAfGbpv5IaNEBAc9R9VywPp/HYS8Hkj7/Bhdy8OnTASG
         IhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755799222; x=1756404022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0lia9zAzQkMkj0u6l/RsjUG2VG0X8+ajRHGScPdguQ=;
        b=R3MVyR873pynkkyhXlKVMvKxmNBcGDb3MRIWpaEORhWNHDesbRJggAgefLYfLEWy6c
         BcEx2xPBlVTOtoB2x1uSUVbuLbbAYjU3gfwLTjPCv97uv0DK3iDC3y/jSN1d2Do5H4uv
         tM6H5PGmfgEgAUXQl0kiKlMSX7WxxoaF/3JntN5/QGDjRh4IUvYa3TdqORzwJKLeL4Zl
         dKZTz+tjDCc0WwkNQ+431v7Yq07BGs4oX3DV+fm1I8ikkQBX96k+lS+cek9UtjEVPcf7
         NE4TDMpCr0iLPftbLwd/rzdM/5PP1V6Yo+r3yqYaRxgTIauKg4xqJ26m17YF0o9c5z7L
         2wYw==
X-Forwarded-Encrypted: i=1; AJvYcCUlYW2LJTMtlPl71HNeRLJafl1Rc3IMM1DVTT3XCmL5uU/JTIRIqE+g4C563Bo1Vtg+HL7TeiIY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsu1pV6+s9Q45eINVOvOSiShPWtHHZNHV3pOvUv21u1red+DdS
	cXappCrBP3hJIpKH3FEqr3VcdooaMcHdIn6rjtX1bklF3jbqNptw8uObhTVaqg3MzRyzOJvhHpD
	TXgMAcFczxuD3dM+fB/QnTZdoLJ9p3QqPNSvRM7ptLw==
X-Gm-Gg: ASbGncvh7ZXXUQXhp2dooQiwQD9ETw2oN+cphutaF44H6cu6nFhWlwIWZI4EcoPZGkD
	E9f4k6bRm1K+Hd4rSTXUoC/QzmQm0P28uhC5pPOTqFWhlEo+f7nkEEew5M1yNPOW3X/MN7QZmxZ
	iMnciwLhl5HTVv9SJeurBGWpePZj7PZTw/a2bgWDEyas9Z2nRrgwlt6EsVFtqE2mS8TwG1FpNOX
	LH6NsHxjxWQ
X-Google-Smtp-Source: AGHT+IHZiFSlHaDYSx8oxyHmCj/KbihWFMT9IF+j+/jr/Ilj6ZzdxoI20FyXRZA9RZCJDjjSM6r7mSJmwQpFWryxS5s=
X-Received: by 2002:a05:6902:3411:b0:e90:6c6c:dc3a with SMTP id
 3f1490d57ef6-e951c33207dmr490273276.34.1755799221387; Thu, 21 Aug 2025
 11:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
 <20250820111940.4105766-4-sunjunchao@bytedance.com> <aKY2-sTc5qQmdea4@slm.duckdns.org>
 <CAHSKhtf--qn3TH3LFMrwqb-Nng2ABwV2gOX0PyAerd7h612X5Q@mail.gmail.com> <aKdQgIvZcVCJWMXl@slm.duckdns.org>
In-Reply-To: <aKdQgIvZcVCJWMXl@slm.duckdns.org>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Fri, 22 Aug 2025 02:00:10 +0800
X-Gm-Features: Ac12FXwQ52FAG0PW2wUzBrp0izeD42MUA03rmCmMwjxx7EXlVIqi8U_EajVPCpg
Message-ID: <CAHSKhtdhj-AuApc8yw+wDNNHMRH-XNMVD=8G7Mk_=1o2FQASQg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] memcg: Don't wait writeback completion
 when release memcg.
To: Tejun Heo <tj@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 22, 2025 at 12:59=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, Aug 21, 2025 at 10:30:30AM +0800, Julian Sun wrote:
> > On Thu, Aug 21, 2025 at 4:58=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote=
:
> > >
> > > On Wed, Aug 20, 2025 at 07:19:40PM +0800, Julian Sun wrote:
> > > > @@ -3912,8 +3921,12 @@ static void mem_cgroup_css_free(struct cgrou=
p_subsys_state *css)
> > > >       int __maybe_unused i;
> > > >
> > > >  #ifdef CONFIG_CGROUP_WRITEBACK
> > > > -     for (i =3D 0; i < MEMCG_CGWB_FRN_CNT; i++)
> > > > -             wb_wait_for_completion(&memcg->cgwb_frn[i].done);
> > > > +     for (i =3D 0; i < MEMCG_CGWB_FRN_CNT; i++) {
> > > > +             struct wb_completion *done =3D memcg->cgwb_frn[i].don=
e;
> > > > +
> > > > +             if (atomic_dec_and_test(&done->cnt))
> > > > +                     kfree(done);
> > > > +     }
> > > >  #endif
> > >
> > > Can't you just remove done? I don't think it's doing anything after y=
our
> > > changes anyway.
> >
> > Thanks for your review.
> >
> > AFAICT done is also used to track free slots in
> > mem_cgroup_track_foreign_dirty_slowpath() and
> > mem_cgroup_flush_foreign(), otherwise we have no method to know which
> > one is free and might flush more than what MEMCG_CGWB_FRN_CNT allow.
> >
> > Am I missing something?
>
> No, I missed that. I don't think we need to add extra mechanisms in wb fo=
r
> this tho. How about shifting wb_wait_for_completion() and kfree(memcg) in=
to
> a separate function and punt those to a separate work item? That's going =
to
> be a small self-contained change in memcg.
>

Do you mean logic like this?

    for (i =3D 0; i < MEMCG_CGWB_FRN_CNT; i++)
        wb_wait_for_completion(&memcg->cgwb_frn[i].done);
    kfree(memcg);

But there still exist task hang issues as long as
wb_wait_for_completion() exists.
I think the scope of impact of the current changes should be
manageable. I have checked all the other places where wb_queue_work()
is called, and their free_done values are all 0, and I also tested
this patch with the reproducer in [1] with kasan and kmemleak enabled.
The test result looks fine, so this should not have a significant
impact.
What do you think?

[1]: https://lore.kernel.org/all/20190821210235.GN2263813@devbig004.ftw2.fa=
cebook.com/
> Thanks.
>
> --
> tejun


Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>

