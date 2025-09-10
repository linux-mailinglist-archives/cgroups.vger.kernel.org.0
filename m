Return-Path: <cgroups+bounces-9945-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D68AB51CFB
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 18:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93DB47BA58F
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 16:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB6232CF8D;
	Wed, 10 Sep 2025 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRi+0Wwv"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392A0327A07
	for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520318; cv=none; b=lZAqoou0IN8Q4rgTCyifYm0K5t0hs4fwDmJ/AgOOTB3frYChX5Y/MS0mbLJgIWXmodcMsWhRUhkSyoNfZjM3viUQyHGs1XNhBRwza8ynVGQr7w6J/jujPFOxADuIS7MQNJG/V8J5UlzDwXGeqHh5gdDsHsNAnVtHD4WWo4tf7dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520318; c=relaxed/simple;
	bh=8WHl/xIk0nqS5I1TpDNZJdY1fN/wk3GEsK4eg0cV/S8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBE7UTzrl+g1V0Dyt1dpHJFTSpO71XIlK6b8hHD8L0n92XAMzJev/5jntxJY5UgGBRHNTeVb7yVJ+4mRDiiFtTjCNedBXizQejFMoOSqZ3pAlvvMmKNXNB6ZM0oiNIVmHCKsAZbOKEp6hQj4L/q7+8+TbBU2IFfwufZoEvN5yVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRi+0Wwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECF8C2BCAF
	for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 16:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757520317;
	bh=8WHl/xIk0nqS5I1TpDNZJdY1fN/wk3GEsK4eg0cV/S8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KRi+0WwvygaUhJCBEOTVhyTuslflCWp9uhW8xwngxKn4mR15CCCbVZ9yZzxDdo6zk
	 8NHXLh5/w7IIgQ866U0CKjI756prCvZaI0vgLNcgVJ0qiHqWngJ8mcWZBTu/tJwl0K
	 o9BbDPIJkkQaeCA6g1bPj0A8ZhY0SFd6IT9XaqBr1nIiamx6ib+XmS1595Sf8wK0Wu
	 Hk9SICmEjnaruuBrZbmHQzKiIXBfH7clKvEm4jpYM4Bgh54vpU4rzXI1Ng8XkcWLUD
	 Yah6wIHTD3kq7PzOUHWg/K0CfVgfM+ugDv5oUyVKIjBhfono0MaJbsJ/VuMfPJOYSo
	 r4xFFJ2g/C7Sg==
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45de2856648so78395e9.1
        for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 09:05:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZH0upJnAOMCGTkp1nOrtOG7Sfb3hLNm6R6SiGwCCr8fm7zKG4njL6Jn4KqUc2guRjavxUwyKf@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ5+a+Lvw5JvpkEkdQiEIvgqDTr9dDy8OduK9az9XWe7YZ7DSB
	/u1xnvxrLxkr+x8UtX97vIUWsxkCjhmXkV1seERTcixdw3JpjOWj7AIWn4BK34bxnGoLnHWKuOr
	t6AR0MISdq8u+fVVmuDQhU+cLJ0+iUxeMC1zFyzDg
X-Google-Smtp-Source: AGHT+IESOq3n3tIz+SwaQTKfvhmB5ATjB2l2io1gR8G1FJKmUxjLskCRKoulqMeYibuDjpYJTXNcvjM6lLzPh7yScNE=
X-Received: by 2002:a05:600c:12c9:b0:45d:cfca:a92d with SMTP id
 5b1f17b1804b1-45df74af1b6mr1417885e9.2.1757520316107; Wed, 10 Sep 2025
 09:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909065349.574894-1-liulei.rjpt@vivo.com> <fszpgct7ywqy6qq3qnjflol3theovmgnau2wgdqqdxin4q7ezm@zumgw533hxon>
 <CAJuCfpFaTj8PsXkoYRQKQ0sOu+mKikUAE8Wbcx+YpZXZ4M7cMA@mail.gmail.com> <b74b1e28-8479-4b14-9210-5b4334d3ce22@vivo.com>
In-Reply-To: <b74b1e28-8479-4b14-9210-5b4334d3ce22@vivo.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 10 Sep 2025 09:05:02 -0700
X-Gmail-Original-Message-ID: <CAF8kJuMJCHJwNtnPiBKz=OJg8L7m7MVWydWRoQMK1HpiFvLDpQ@mail.gmail.com>
X-Gm-Features: AS18NWAODLU4l_N1iDuC58AkueksUH14mA7pKjigM1COfFIYTDTArxE3zeEj-wg
Message-ID: <CAF8kJuMJCHJwNtnPiBKz=OJg8L7m7MVWydWRoQMK1HpiFvLDpQ@mail.gmail.com>
Subject: Re: [PATCH v0 0/2] mm: swap: Gather swap entries and batch async release
To: Lei Liu <liulei.rjpt@vivo.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
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

On Wed, Sep 10, 2025 at 7:14=E2=80=AFAM Lei Liu <liulei.rjpt@vivo.com> wrot=
e:
> >> On Android, I suppose most of the memory is associated with single or
> >> small set of processes and parallelizing memory freeing would be
> >> challenging. BTW is LMKD using process_mrelease() to release the kille=
d
> >> process memory?
> > Yes, LMKD has a reaper thread which wakes up and calls
> > process_mrelease() after the main LMKD thread issued SIGKILL.
>
> Hi Suren
>
> our current issue is that after lmkd kills a process,|exit_mm|takes
> considerable time. The interface you provided might help quickly free
> memory, potentially allowing us to release some memory from processes
> before lmkd kills them. This could be a good idea.
>
> We will take your suggestion into consideration.

Hi Lei,

I do want to help your usage case. With my previous analysis of the
swap fault time breakdown. The amount of time it spends on batching
freeing the swap entry is not that much. Yes, it has a long tail, but
that is on a very small percentage of page faults. It shouldn't have
such a huge impact on the global average time.

https://services.google.com/fh/files/misc/zswap-breakdown.png
https://services.google.com/fh/files/misc/zswap-breakdown-detail.png

That is what I am trying to get to, the batch free of swap entry is
just the surface level. By itself it does not contribute much. Your
exit latency is largely a different issue.

However, the approach you take, (I briefly go over your patch) is to
add another batch layer for the swap entry free. Which impacts not
only the exit() path, it impacts other non exit() freeing of swap
entry as well. The swap entry is a resource best managed by the swap
allocator. The swap allocator knows best when it is the best place to
cache it vs freeing it under pressure. The extra batch of swap entry
free (before triggering the threshold) is just swap entry seating in
the batch queue. The allocator has no internal knowledge of this batch
behavior and it is interfering with the global view of swap entry
allocator. You need to address this before your patch can be
re-considered.

It feels like a CFO needs to do a company wide budget and revenue
projection. The sales department is having a side pocket account to
defer the revenue and sand bagging the sales number, which can
jeopardize the CFO's ability to budget and project . BTW, what I
describe is probably illegal for public companies. Kids, don't try
this at home.

I think you can do some of the following:
1) redo the test with the latest kernel which does not have the swap
slot caching batching any more. Report back what you got.
2) try out the process_mrelease().

Please share your findings, I am happy to work with you to address the
problem you encounter.

Chris

