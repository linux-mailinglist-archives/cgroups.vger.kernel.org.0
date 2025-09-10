Return-Path: <cgroups+bounces-9920-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E31A2B51C04
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 17:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2D407A5A6E
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 15:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C0A261B93;
	Wed, 10 Sep 2025 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJB9N6CB"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5A232A803
	for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518850; cv=none; b=GstVIxuMfqAB4mCYsnuTcXCmZV8fKshIQNaveTG8X2zZaaWullKbUEUYWDDCjTYSyB7oORaSCFHhOng7iq7EoC9gS6S+tUiDlU0kq6y7bU22jUt+/8pvV4wssy+J6BkmqZ3iirk2R7DDjRxOEgTqlzF0UaxQn4DSEEoZZjpoZtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518850; c=relaxed/simple;
	bh=bRgAHBWf24BTGFBuYhLJzHxAVS+bdjD+/zjBvEVUqW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JE1b1vog36nY5f1m6a/GCbDAL+ddBvK+6O9PTs3R8HznWTnxwIswFFejeF+emDr4SpLEOxYmlWyEd676/bYA2a655KxUphz3zRGXiL7JOdDDUXcxvVARCr8guGlOYhhstBfrCn3J13hXSGZPbKqdgTl5zNpSe9mCyS1Mc3O7HdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJB9N6CB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8632C116B1
	for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 15:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757518849;
	bh=bRgAHBWf24BTGFBuYhLJzHxAVS+bdjD+/zjBvEVUqW4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lJB9N6CBRUrn0/7+dsnofUa3sQYlW4usI9eBVBYDZ14O7KLmPj55mT/dhx857vhKU
	 cd/LAHfomT2aoYZfphTzXIk4YlgjAd/wWzvHoaT75GJON/439x6OR1NFcgqRUBdk1a
	 FpmHRzJEn5THeOJhj5+wMX9OqO8WQejFi7g0elWE3FJ/UD4M78HUizONAo3D+Qn2GQ
	 jwq/IyZXQJXy7bFHFSJRHkL/XZUPh/2OFeMdJFjlf1tF39f4A6ZoFoFx/xQTA3k3B8
	 kWkW+0+HUsraSGv2x6HS4o37Ji72XlYRIc26KVEj/dcOl0xsFuXuR/wIAMRe2DMoWe
	 ZYUnxCAq9bTOg==
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45de2856648so75135e9.1
        for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 08:40:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJthEjVAmn5eKswRHt58PrlWlnrLv6W0I6KLCMoz8BSzR2uMm4pTk0jSGlXfAc7JjMmmQ+0Zk0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8eXdylD1R61OF4jgEULNWM5dDO64/VqjjM1d/nkahU2qeQQ6H
	g7It8wElmTXOTw2TVxsJKSBAA6RXlAtuH/59vnA6W20TnHtqGAlKxVVp0yc6bmoyYZ9850iQP8F
	sDDU3tZG3d93kab0pPgT4QAZl6tkDbqZIKvtSds8d
X-Google-Smtp-Source: AGHT+IFzQFxctqHRUP+7gGGNT/cgajA5FhoYSBtLF9Qnh83FEO2IIPJiyqIgLr5qEirjnieHoVaR1O9ffHFb7IrurfM=
X-Received: by 2002:a05:600c:a59a:b0:45b:92a6:4972 with SMTP id
 5b1f17b1804b1-45df74f7e52mr1533855e9.6.1757518848231; Wed, 10 Sep 2025
 08:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909065349.574894-1-liulei.rjpt@vivo.com> <fszpgct7ywqy6qq3qnjflol3theovmgnau2wgdqqdxin4q7ezm@zumgw533hxon>
 <CAJuCfpFaTj8PsXkoYRQKQ0sOu+mKikUAE8Wbcx+YpZXZ4M7cMA@mail.gmail.com>
In-Reply-To: <CAJuCfpFaTj8PsXkoYRQKQ0sOu+mKikUAE8Wbcx+YpZXZ4M7cMA@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 10 Sep 2025 08:40:36 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPmp9_uS_AE2FkAy+--PhCadspSRO6osEvK9gTqWEn_ng@mail.gmail.com>
X-Gm-Features: AS18NWAa_U7BDSFPnyN8FeQb4fRXFRsmriu4wTPjiduKLAM37lIhjuNUw2KPbFA
Message-ID: <CAF8kJuPmp9_uS_AE2FkAy+--PhCadspSRO6osEvK9gTqWEn_ng@mail.gmail.com>
Subject: Re: [PATCH v0 0/2] mm: swap: Gather swap entries and batch async release
To: Suren Baghdasaryan <surenb@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Lei Liu <liulei.rjpt@vivo.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, 
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

On Tue, Sep 9, 2025 at 12:48=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
> > > Exiting processes compete for CPU cycles, delaying the camera preview
> > > thread and causing visible stuttering - directly impacting user
> > > experience.
> >
> > Since the exit/kill is due to low memory situation, punting the memory
> > freeing to a low priority async mechanism will help in improving user
> > experience. Most probably the application (camera preview here) will ge=
t
> > into global reclaim and will compete for CPU with the async memory
> > freeing.
> >
> > What we really need is faster memory freeing and we should explore all
> > possible ways. As others suggested fix/improve the bottleneck in the
> > memory freeing path. In addition I think we should explore parallelizin=
g
> > this as well.
> >
> > On Android, I suppose most of the memory is associated with single or
> > small set of processes and parallelizing memory freeing would be
> > challenging. BTW is LMKD using process_mrelease() to release the killed
> > process memory?
>
> Yes, LMKD has a reaper thread which wakes up and calls
> process_mrelease() after the main LMKD thread issued SIGKILL.

I feel this is a better solution to address the exit process that is too sl=
ow.

We are basically optimizing the exit() system call, I feel there
should be something we can do in the userspace before exit() to help
us without the kernel putting too much complexity into exit().
process_mrelease() souds fit the bill pretty well.

Chris

