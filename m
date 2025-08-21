Return-Path: <cgroups+bounces-9302-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4564B2EB38
	for <lists+cgroups@lfdr.de>; Thu, 21 Aug 2025 04:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710875E7508
	for <lists+cgroups@lfdr.de>; Thu, 21 Aug 2025 02:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AED7248878;
	Thu, 21 Aug 2025 02:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kuOuIegl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFD9245033
	for <cgroups@vger.kernel.org>; Thu, 21 Aug 2025 02:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755743446; cv=none; b=mjHPbGf4EpP8QRgRn0HJWzhPQrzM6HR9D3zQMA/VYuemywbc2gLwN0JnqIFWcUpzcheN35ds4cAqyZFbONXKuj1bDoDRBkCD3d43geWXoyrrge21bCNWP2WEfoR/k2FZ7U1ZQt3/dFnFAuUI2IAkAF86q1QSWtinIgTakOmTEdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755743446; c=relaxed/simple;
	bh=02fqpgtmXVnZUvEZ4gXKpvgwB2e67UJkxB7WqjsBRcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFAYBgdlNOK8jKt4LYxtpynOhXt4kT5zRUpDQbs4ESIFZHICLW3jYo48gzqPyLV2R5GzrUmoFKrksMGsrWMiuIoEh+nDcz/nqEFHD+PQz5UZI948HeZqfPqWwMDmNPw8G/j65Uj56QIMN5GT/weHSclu64YExviaPouacONTAts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kuOuIegl; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e93498d435cso518281276.1
        for <cgroups@vger.kernel.org>; Wed, 20 Aug 2025 19:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755743442; x=1756348242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMION88G6TPbiFF7T9DSor/YV4Dhrggsi8E1Q94kAvM=;
        b=kuOuIeglY9D3SiBYMgeJ9y+wTzR9SEHyhhjNq2wchsR60nutnmDXXdhiOAJZ2Edft6
         05jI52cyjT7CEMpEPw8PHfLBgHHUDE6HWCPy6qNXotBAVF4H8YZKoxOhlCkyVm4a2L0i
         ohBL7Y3yst6ZfZTx9nzsg/iz/xGh70Y5WnGVbS4aicfr3Ob3mTwHIrswyeZFCxcLbSKu
         XS2O9+hyZk3MnKySi5Yny4zunB1UyRneaH2x6L1fDhDC7iszE7bgaZFn83gZzU8U7dCt
         EJUkyiciUtGXRMQtwfg3GNfoo8M470TL0rkDcmYxRGPCDyP3U7YWWFd6qjhwfupP264J
         Tgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755743442; x=1756348242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMION88G6TPbiFF7T9DSor/YV4Dhrggsi8E1Q94kAvM=;
        b=tKlEnMlb3W/HIZkKNkHgP2XFx4PwWv4u2upVD+bZB5huTGqBkLQMGrYAgaz72dGpIx
         xl9JuvaBh/t8wCdGfmfE3c4lSvHYTbcE7bi+opVPs+A2YVUBwn80F20WcJu8deUlXK49
         jmjkr6XdVRwkJe99eZbKnXJtWeymD3cNag+XXdWDsxMyaclJTuzRRNtalg/j55oVeTV8
         mGWdtGMd67+toEh1jhQnDTYeRuEySa9D6HC5C/jMZfwLpUkygtFDSbpqfWm6a9/TppUd
         PrhqXGNwyMdpRJFygTKM+tU0SLZIFJls8EuW/Fx7ncsJxm5J12bgR9piuGTNAQ1NQCbP
         7sSg==
X-Forwarded-Encrypted: i=1; AJvYcCXXd7Ugm2EyibrrJERxJ7Glm29OBINtULo2f59VZTDHjiCAtnBlp+gVDby2N3f2rSkMrF5PgN2L@vger.kernel.org
X-Gm-Message-State: AOJu0YwHy44EWJ75qtZXB1GVcnUywPMuxebj8DRWBnqg7DNO7g7ztpsn
	E+MPH3+51tX5y+osUWCFdYvNtUwRYvqfof48OxCMjruPRwBVZYPNk74gl16sy9aMa9+RDVdBK7P
	nsg41+N9RLySMIVomoAYb+GmsRooenYuuRqBMLzwwoNFjDBO0iLmVWTofuEq5
X-Gm-Gg: ASbGncsLRwpSilXeps5aB+k1vUA4U/0OvsHaLqy1UVk6o8NaGe8mH9/IP3q/YgqCo0Z
	z1LYzsnmHcnxGzotQM8Cp8dOCsYmmzi2NxQTeah69BenCi6q0vqIRMtoY+r2ox3GV/WvFy7erJh
	ht1zCtwZ4GAYyicR/VpPW+eeBnmK315/nbMKEgn83+b5E7tffCUgGB3+cuGZiZb2VW90iP2qyKq
	z9JayztPB6SoTFe9NILUp3h
X-Google-Smtp-Source: AGHT+IGHwdE1yoE0p0wXWL0FR3kNcqWuprB5S21pgTsnfmdOOr1XNkU1L5aco2yBQOW+mjqEWdEcfSMHAi8UfBwEZOE=
X-Received: by 2002:a05:6902:1208:b0:e94:ee5b:f698 with SMTP id
 3f1490d57ef6-e95088dc93emr1024460276.5.1755743442340; Wed, 20 Aug 2025
 19:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
 <20250820111940.4105766-4-sunjunchao@bytedance.com> <aKY2-sTc5qQmdea4@slm.duckdns.org>
In-Reply-To: <aKY2-sTc5qQmdea4@slm.duckdns.org>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Thu, 21 Aug 2025 10:30:30 +0800
X-Gm-Features: Ac12FXwn16lFOJCh2AxH5JioHJPOSpdJ0y3PAE3Dn4f0kUvtBjLfueMmyBwUcXs
Message-ID: <CAHSKhtf--qn3TH3LFMrwqb-Nng2ABwV2gOX0PyAerd7h612X5Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] memcg: Don't wait writeback completion
 when release memcg.
To: Tejun Heo <tj@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 4:58=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> On Wed, Aug 20, 2025 at 07:19:40PM +0800, Julian Sun wrote:
> > @@ -3912,8 +3921,12 @@ static void mem_cgroup_css_free(struct cgroup_su=
bsys_state *css)
> >       int __maybe_unused i;
> >
> >  #ifdef CONFIG_CGROUP_WRITEBACK
> > -     for (i =3D 0; i < MEMCG_CGWB_FRN_CNT; i++)
> > -             wb_wait_for_completion(&memcg->cgwb_frn[i].done);
> > +     for (i =3D 0; i < MEMCG_CGWB_FRN_CNT; i++) {
> > +             struct wb_completion *done =3D memcg->cgwb_frn[i].done;
> > +
> > +             if (atomic_dec_and_test(&done->cnt))
> > +                     kfree(done);
> > +     }
> >  #endif
>
> Can't you just remove done? I don't think it's doing anything after your
> changes anyway.

Thanks for your review.

AFAICT done is also used to track free slots in
mem_cgroup_track_foreign_dirty_slowpath() and
mem_cgroup_flush_foreign(), otherwise we have no method to know which
one is free and might flush more than what MEMCG_CGWB_FRN_CNT allow.

Am I missing something?

Thanks,
>
> Thanks.
>
> --
> tejun

