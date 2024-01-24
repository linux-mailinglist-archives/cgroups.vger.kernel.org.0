Return-Path: <cgroups+bounces-1228-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C654C83A4F2
	for <lists+cgroups@lfdr.de>; Wed, 24 Jan 2024 10:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 594F5B29DC7
	for <lists+cgroups@lfdr.de>; Wed, 24 Jan 2024 09:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6074117BC6;
	Wed, 24 Jan 2024 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OWjdUa2N"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA0F17BBA
	for <cgroups@vger.kernel.org>; Wed, 24 Jan 2024 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087559; cv=none; b=C0xbjeUgxajk8caqlDfq+Edf6aP8A79/9HhaBs2IbF9LYb9+1izMuldh07Sg6ye/0+nmYXwODCIg9kBPUvV3kU+QJeel4HaB8KrkalaFmngMMKMM0yKcrc9mntx0NukaOOyRe+53sR/wNVp2DHOvjmXkFeHChBlZONqHNAGL+zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087559; c=relaxed/simple;
	bh=sg2x6RglKOa/ZHOjgcmXB6to1BOsPavab2cnbypTlek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmdXOSCVNzW3J4MMp1rEWPZ/UhElb12dN8fvOE/mS0MZiNRr3Uut4PX9ZNDSknL+0L7WZ0RYznAJWEBDTt8cmUP+bIOEEp5swna8+TyGEreTITlIPMCVI+ZHHCPgH9a9XtZQ+uE8pbcqI1n9FGmhk1MHvCqXFrgKBnK2bTNgbkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OWjdUa2N; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51008c86ecbso1790654e87.2
        for <cgroups@vger.kernel.org>; Wed, 24 Jan 2024 01:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706087555; x=1706692355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDGWWvngYrXMHFwGpStoErGRJgClfXa6zjwKTrnmtoY=;
        b=OWjdUa2NIhXeHySf7Qo3s8I5abVSICUB85/n9bqnTNODGNQGCSRu9LQUSfZxCuci9A
         +u6v4QLNnMzf2CvM2wLCx5E3LnIPHcf5bx2oQ2Hbo2PykI0/TYt8TEdwjvvyTAb1zGdM
         MYbJDI7IRElZf8UbDaAL4G4to9r8sfMg7nQMsmq7BsqHsgwx2fVjN9PulhSVOZuJtcqS
         bnRka8WonoiEE3K/Uu+aa99a/3qvJHnU9KrubvDQSFkY69q/w/cPkFxI9X/EBwPM1aTW
         BzGagcYs/yWELYCmbKG7ofY1Cewcyer9IMlK6Tyb/drzp8+Kbd6/l1XkSjxq37H+FDsa
         t2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706087555; x=1706692355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDGWWvngYrXMHFwGpStoErGRJgClfXa6zjwKTrnmtoY=;
        b=mSMxUrJNRedthdBcMsb+4ASGjqbNf7safg2SNcF+CRxyGxQbfH9hYb1wp8hE05m8bJ
         gqHeNwN29UOQeto1fQjfZw+gaQieXgbZHeE/Kt/ZD8i1pXnTMiedqOjHjrXBN2PRci4B
         aZju8AJJLruOjXKhvP63jz4udW0vfyGdNG71qo+OEqLeV6+redR5prh+heoghy3sUlLv
         iUmYEB9UJiwAtDvyuuUii+E6o7gYI/dUnRUNcOqjVMedJfnf4XO3jPEer3RxGTFklmiz
         ANzKvw4zT5YP/BmFGaNWpsLzPdhIaf5srQeI8eiTrpBXPJvMkiV1FgAdPWgt/3zbQLX3
         ITAw==
X-Gm-Message-State: AOJu0Yw2SjoLqBWAzriltG/GFfZ2sOIdcuL49P+mIjB3S4/gDbPUb3+4
	Y1KKWG6+s2jqKHNmaRuAT6KVQVrNkpzrU5rpp4MbZjw3tSjLHVJXNrtl2B50g9UbDsWQriT06kv
	BLrm5cOhiJZ9INba6jtF7+aM38cdP/sVvYvMU
X-Google-Smtp-Source: AGHT+IFfLbd/FARYk6hM3cTdPgBQ12QvsaQkut9PupCddCOicPnR9Oc8j2wvTSCWe9Y4/ZeUwERHZdpt7K9X51TdCA8=
X-Received: by 2002:ac2:5384:0:b0:50f:732:c4d5 with SMTP id
 g4-20020ac25384000000b0050f0732c4d5mr2849591lfh.64.1706087555324; Wed, 24 Jan
 2024 01:12:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401221624.cb53a8ca-oliver.sang@intel.com> <CAJD7tka0o+jn3UkXB+ZfZvRw1v+KysJbaGQvJdHcSmAhYC5TQA@mail.gmail.com>
 <Za9pB928KjSORPw+@xsang-OptiPlex-9020> <CAJD7tkYtKdLccKbFVoVo9DH8VtHHAXNMEz5D-Ww5jHhDy-QxbA@mail.gmail.com>
 <ZbDJsfsZt2ITyo61@xsang-OptiPlex-9020>
In-Reply-To: <ZbDJsfsZt2ITyo61@xsang-OptiPlex-9020>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 24 Jan 2024 01:11:59 -0800
Message-ID: <CAJD7tkYdvnOhj4a_mzx-w9Zzx8Eg8zFjQxi2+kxR0hD05b3GTg@mail.gmail.com>
Subject: Re: [linus:master] [mm] 8d59d2214c: vm-scalability.throughput -36.6% regression
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, Shakeel Butt <shakeelb@google.com>, 
	Chris Li <chrisl@kernel.org>, Greg Thelen <gthelen@google.com>, 
	Ivan Babrou <ivan@cloudflare.com>, Michal Hocko <mhocko@kernel.org>, 
	Michal Koutny <mkoutny@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Waiman Long <longman@redhat.com>, Wei Xu <weixugc@google.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, ying.huang@intel.com, feng.tang@intel.com, 
	fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 12:26=E2=80=AFAM Oliver Sang <oliver.sang@intel.com=
> wrote:
>
> hi, Yosry Ahmed,
>
> On Mon, Jan 22, 2024 at 11:42:04PM -0800, Yosry Ahmed wrote:
> > > > Oliver, would you be able to test if the attached patch helps? It's
> > > > based on 8d59d2214c236.
> > >
> > > the patch failed to compile:
> > >
> > > build_errors:
> > >   - "mm/memcontrol.c:731:38: error: 'x' undeclared (first use in this=
 function)"
> >
> > Apologizes, apparently I sent the patch with some pending diff in my
> > tree that I hadn't committed. Please find a fixed patch attached.
>
> the regression disappears after applying the patch.
>
> Tested-by: kernel test robot <oliver.sang@intel.com>

Awesome! Thanks for testing. I will formalize the patch and send it
out for review.

