Return-Path: <cgroups+bounces-9839-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB780B504CA
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 20:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F21E3BCAD3
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 18:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AB92E7BD9;
	Tue,  9 Sep 2025 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7gUZ61G"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0665139D
	for <cgroups@vger.kernel.org>; Tue,  9 Sep 2025 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757440890; cv=none; b=L6o390w2Q3L2wIijGepuKJFr86p18Irmh29IYubYQagqOoJiF6Xhm2zCytAhsF8yPCd9gjeCOJQGLqF5xOuoKvQr73INM9i4a0LPWxTwppp+6WJwRsw46ApB2oOpUNCqKwio8Agd8KjtWIenZbB5tSTJ7DOQQUnsFAYWAG3qWaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757440890; c=relaxed/simple;
	bh=5ilK8ia7UPhfVMvyxiXK2/ObZT0rv1xyPRWOvrYgFLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtsdUzPrAahYE5bDwcdqchSiOuJe6SP1uqXFE/zGvbiX+L1ihZBSIHP0+YU2vOZzuO8+CRDzKIGPeyJO2N5v+Iopug1zzfjxHQtGCA3sgRuuBe/5vUde/9GSxx/hhk7s8sb5EhKCkspZwgDswCeg4kVRoR0UJjBrMeN/d0pBZU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7gUZ61G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6C1C4CEF4
	for <cgroups@vger.kernel.org>; Tue,  9 Sep 2025 18:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757440890;
	bh=5ilK8ia7UPhfVMvyxiXK2/ObZT0rv1xyPRWOvrYgFLg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A7gUZ61GSZHU6YDGEoeo6YaMEpuViXK5JJnpfKsLC3OdC/7OsNL1VMEFWk7WUc6nR
	 8xXTYol0G1LFeXmksDKOTVh2icvAU2FJTUdyJlbbG0y+/CZYE3LlMHlCk/4H+ZJphv
	 HDkMq0ck8Md86nJaZSdKg4n8ONb5a6hhU/KNQmQy6GcCyp/V7dwziUS95LTYo2E22c
	 YQGuiLlKALHda9ECCXEllwsWZ6u9aV1KdnP+z1d+A/uW71NpEKf6fB/RvUiEeZuvuB
	 V5dD9qONFZlZbDBJgxJuI5LDQdYn9w4i7pz+0xbSwYlC1CJOvlURSG5/lBccebrShG
	 kM81WQmbKjqFg==
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45de2856648so9315e9.1
        for <cgroups@vger.kernel.org>; Tue, 09 Sep 2025 11:01:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXeFhG+I7Yej0BT5c3x8C09pGAcsYlFQuxSzUSEY+VUldRRZFQWyQ8u0gxhgEaQIBia2cvyxl3G@vger.kernel.org
X-Gm-Message-State: AOJu0YwFNfAFeUazpl6D/Gml3v4J0WIxdB5pjC9JHNdO4njT5yt3+18v
	vfE+uglEyYkTsp5xvNL1eE18Z4QdESxpRAiNnmD8VM1gdV2/Db7XogkuaUAxCRh8gppA1j1zAyE
	2N2UJzm6Q+8JX3fM6F+VWVuJE1WGt4GSMI39XtiTO
X-Google-Smtp-Source: AGHT+IEHiqW6W81fKTiUrSgccv+699732yqAFTxOHwHdOHXueJL7aAAseuYOZ6okifCTYPp/jMJ7ubGR/z4jzyU8EOo=
X-Received: by 2002:a05:600c:33a9:b0:45d:f51c:193 with SMTP id
 5b1f17b1804b1-45df758d891mr14615e9.7.1757440888599; Tue, 09 Sep 2025 11:01:28
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909065349.574894-1-liulei.rjpt@vivo.com> <CAMgjq7Ca6zOozixPot3j5FP_6A8h=DFc7yjHKp2Lg+qu7gNwMA@mail.gmail.com>
 <CAGsJ_4xiTteQECtUNBo+eC9uu8R3CgVT2rpvGCGdFqc3psSnWQ@mail.gmail.com> <CAF8kJuM4BEeHnkhw5bSM6ap23paChMBZtqCY6ksie+8EghYb8g@mail.gmail.com>
In-Reply-To: <CAF8kJuM4BEeHnkhw5bSM6ap23paChMBZtqCY6ksie+8EghYb8g@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 9 Sep 2025 11:01:16 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNJEchVPWQhbKqePA7NBJsznVEzhfp1D-bxsC64aFfttA@mail.gmail.com>
X-Gm-Features: AS18NWChhVMZpbE3ggz7fev2b5EP2VFRMFP1IX5t70ZHFiaCFFddAwgtajoPUoU
Message-ID: <CAF8kJuNJEchVPWQhbKqePA7NBJsznVEzhfp1D-bxsC64aFfttA@mail.gmail.com>
Subject: Re: [PATCH v0 0/2] mm: swap: Gather swap entries and batch async release
To: Barry Song <21cnbao@gmail.com>
Cc: Kairui Song <ryncsn@gmail.com>, Lei Liu <liulei.rjpt@vivo.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, 
	Hao Jia <jiahao1@lixiang.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Usama Arif <usamaarif642@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Fushuai Wang <wangfushuai@baidu.com>, 
	"open list:MEMORY MANAGEMENT - OOM KILLER" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 9:15=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Tue, Sep 9, 2025 at 2:24=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
> > I feel the cover letter does not clearly describe where the bottleneck
> > occurs or where the performance gains originate. To be honest, even
> > the versions submitted last year did not present the bottleneck clearly=
.
> >
> > For example, is this due to lock contention (in which case we would
> > need performance data to see how much CPU time is spent waiting for
> > locks), or simply because we can simultaneously zap present and
> > non-present PTEs?
>
> I have done some long tail analysis of the zswap page fault a while
> back, before zswap converting to xarray. For the zswap page fault, in
> the long tail a good chunk is a bath free swap slot. The breakdown
> inside  shows a huge chunk is the clear_shadow() followed by
> memsw_uncharge(). I will post the link to the breakdown image once it
> is available.

Here is a graph, high level breakdown shows the batch free swap slot
contribute to the long tail:
https://services.google.com/fh/files/misc/zswap-breakdown.png

The detail breakdown inside bath free swap slots:
https://services.google.com/fh/files/misc/zswap-breakdown-detail.png

Those data are on pretty old data, before zswap uses the xarray.

Now the batch freeing the swap entries is gone. I am wondering if the
new kernel shows any bottleneck for Lei's zram test case.

Hi Lei, Please report back on your new findings. In this case, with
removal of swap slot cache, the performance profile will likely be
very different. Let me know if you have difficulties running the
latest kernel on your test bench.

Chris

