Return-Path: <cgroups+bounces-1202-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D560D8371CE
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 20:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57BF9B2C019
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 18:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668B8482E3;
	Mon, 22 Jan 2024 18:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CDSOMCTL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB261481AB
	for <cgroups@vger.kernel.org>; Mon, 22 Jan 2024 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947565; cv=none; b=Q1T5ikGOBxhjPp6LCdMQ2yjZ1UPFJgCYYEikWX0TqxuPcXzvTFY67sJEQZjFulXnhrzPtITv5n6DwggAZllQUpNpZAvXqhBVKGFpw/hyH0r57K79BeU8+afMecjJO38knTnFz/lmgOnJSPG1/+BVEgXO5q5CRgNMdukuxmZ88Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947565; c=relaxed/simple;
	bh=h4PO0st/1IuYHBIEltga1Ivy97tEPnri+qjxZXMW6hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAyu8JQoMcJpfSLH+Td09HVztPtohdygM2vr8AQCFwvilv55sOx73cl+hpy9smxke14LNuuPOdLNtifPHMsl8CeNzDWmQ1r37AUToGL1bCZL1v62PYzpPh8hMbutD5Z3uytaUOz/UHtnbFMtmhbozwrMJ28Le1GmLvt89EB6fVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CDSOMCTL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d5ce88b51cso11225ad.0
        for <cgroups@vger.kernel.org>; Mon, 22 Jan 2024 10:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705947562; x=1706552362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0Y9E+3pzP2s+EQdBjSE77FjET8jy9DFccLp3B3IzFI=;
        b=CDSOMCTLhpdPfghCsAKPFwC+4ARoHxLhob5RAo9m2XPGn96aumgVKHx1DKfEPioDTp
         B9WUp68IdZmQvFHk7vvIGpE+zVdoaCdjlsCMAdFBfoxpGjorsTOHvjQqiFzntala1Xza
         +G4Sgrxjt5AgAwewPkAjIErxJl09TCdGafkLG8qVJI4J2mgFhtQbeW+t3jyGbPoEvpWG
         ZBqErZgwLzeOJ4+gK6kZwpxh2AhcWftYeuMVaAWEOJUI2ZKA7EcIq3Onof2nZ5EI/ucT
         RobNz5DxN+cZavhGqrwnrME+Koj2pD6EJRcIftUUed9yjx+DIlXzNe1ZQQISkVfodvf3
         cB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705947562; x=1706552362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0Y9E+3pzP2s+EQdBjSE77FjET8jy9DFccLp3B3IzFI=;
        b=dZzxMH4OXukuvjJEo38GarSk3R+AkKojB6bVkAJOpGoTPP5qOf6gjeyevgJTEQunoY
         DxEU538zlzakvET5oFM0p0gRUskSUCXZFulBDxGpCJn4C9FmgXFxNPFIABsPVb9oc/Bv
         6t8o9qknn4l/PLTF1+elEGlUDLilJnequ6LgGFlfsnSaqZkBi23o2RboXwH5RkibtvTw
         xHpCodsUtcEi4J1Uampv1ZcszqAQhGnt/3ThuSwcQTxMb14CX5GeF/g3ec/r2p//1myb
         dYIKFuNUUhFmATDXqQWyrlHIv+hP11gUKnTpxB6gfcbRE9dV1SdAH/LgTnHT0ewch+oQ
         eIrw==
X-Gm-Message-State: AOJu0YwC5RFnw0poMIDnqbKH4lnFR2imrnxG2MaQN5hqQwkFC3YwKMfg
	WDvkp2AcjUwwmmfpmGXg/MAh9ZRkkzh76Vty/fb4ZieUjv70
X-Google-Smtp-Source: AGHT+IFeVSUQFJ2B79/oJNPkrOM8pRveuwd/OkPvv+mFDyuckhWdMgfmz1t4fln+zp+sRW8MxNoLyC5nZnyI1h1DfJY=
X-Received: by 2002:a17:902:fb46:b0:1d6:fb94:10d5 with SMTP id
 lf6-20020a170902fb4600b001d6fb9410d5mr10331plb.27.1705947562078; Mon, 22 Jan
 2024 10:19:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118184235.618164-1-shakeelb@google.com> <jazycqhefxn6oigmt6mitn2cfoonscbdwqxy5g7gs2j74w3ia5@qwcu3v7kmk4h>
In-Reply-To: <jazycqhefxn6oigmt6mitn2cfoonscbdwqxy5g7gs2j74w3ia5@qwcu3v7kmk4h>
From: Shakeel Butt <shakeelb@google.com>
Date: Mon, 22 Jan 2024 10:19:10 -0800
Message-ID: <CALvZod4XUrQMxptBo56Fm6-ETQy_DtVq-g4NKokVvSyGwDOnxg@mail.gmail.com>
Subject: Re: [PATCH] mm: writeback: ratelimit stat flush from mem_cgroup_wb_stats
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 7:20=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> Hello.
>
> On Thu, Jan 18, 2024 at 06:42:35PM +0000, Shakeel Butt <shakeelb@google.c=
om> wrote:
> > One of our workloads (Postgres 14) has regressed when migrated from 5.1=
0
> > to 6.1 upstream kernel. The regression can be reproduced by sysbench's
> > oltp_write_only benchmark.
> > It seems like the always on rstat flush in
> > mem_cgroup_wb_stats() is causing the regression.
>
> Is the affected benchmark running in a non-root cgroup?
>
> I'm asking whether this would warrant a
>   Fixes: fd25a9e0e23b ("memcg: unify memcg stat flushing")
> that introduced the global flush (in v6.1) but it was removed later in
>   7d7ef0a4686a ("mm: memcg: restore subtree stats flushing")
> (so v6.8 could be possibly unaffected).
>

Yes, the benchmark and the workload were running in non-root cgroups.

Regarding the Fixes, please note that the regression was still there
with 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing"), so I
would say that our first conversion to rstat infra would most probably
have the issue as well which was 2d146aa3aa84 ("mm: memcontrol: switch
to rstat").

So, the following fixes tag makes sense to me:

Fixes: 2d146aa3aa84 ("mm: memcontrol: switch to rstat")

