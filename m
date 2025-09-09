Return-Path: <cgroups+bounces-9841-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E62DBB50692
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 21:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C5016364B
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 19:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECF73314B5;
	Tue,  9 Sep 2025 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EmcK3rFb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C7321A449
	for <cgroups@vger.kernel.org>; Tue,  9 Sep 2025 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447298; cv=none; b=BXSgcWAB55RNWik9Wn7JR1V3tV+2yIiTfc1YLlfaewgTkoHczzCK2ZdUy6NeVX3mPnKhHbwaSUhFo/+ggrRFWF8Us1CmpsgXUMt6kpfXlHrxO1m8KcCL5+I7yFSUKbiEd5wfr01cJyFSdQj7SKpZP8KyfxFz3KpQz5Md4wof9Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447298; c=relaxed/simple;
	bh=RrojLj/ktXW5xY/NIjNyQYgQaTHve7x8/XiMiaN71uM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOdt12GmfX3wGYrF8GHLCb9BrBRZjJ9tdwFRv3moZMO9fMob9efKDOAAVxs6Wk/v4ixtlppvIPK6DfXZjzWfZffjCPOMho0wdVEvsnnFgRqZLGPVJX3C3tiqq/1U8UCFr1xPOU1zCktxdrk7CMu+j7+9WDzJFbpSF7kATOGxTg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EmcK3rFb; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b4bcb9638aso120151cf.0
        for <cgroups@vger.kernel.org>; Tue, 09 Sep 2025 12:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757447294; x=1758052094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrojLj/ktXW5xY/NIjNyQYgQaTHve7x8/XiMiaN71uM=;
        b=EmcK3rFb1eYsPoWc+rnzqR8Upbp64gHyO1G3TDkoRkWIhKNtwRxl6TZhXiNESm4I9k
         Dch+FnmcOsK2gcXcr2UURbuCIJ4O0/1SjP2aN8fYlEVp7OCeTI8f14LefxwacXouX7o7
         xnP4Hw5OPL4xO4iiYHG+6P9ceI8ZnXHeJ1C8eU5CVF1tEUqGXFgBE6L4ePwp1qiM2A8T
         OzqGzPAQQGKnk0rS4HdyvQcBH7zNiolrc0tBeD3y46os+yKXYuVhbZ9L+6sKiOgi16GO
         xUHV6oZs2ks+Bua2Rvgk94r9F+KSQgweOgWYOiHgt5ObWWi6RoXliaWh2qBklasAYYVS
         9qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757447294; x=1758052094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrojLj/ktXW5xY/NIjNyQYgQaTHve7x8/XiMiaN71uM=;
        b=UqPsEuDyf992FjuVAWST2AaHpKhsWq31xKGD+cECFQjHaUfqjJ91yw20jMrEmtNcld
         5a7G8KuqFLhV6+WEzpGX5rTdwUqYGClKTiAFc2qGGMRgVl01fZK94f3GTQY3is+tpICd
         7VWQB3FRWQLO1mN9TacabOsxLH8wtiDlmqT4K8wJJhqVMe2J3+/jcpOuU0f/duE6lEwb
         o60LiO8fu09vw0ENHbEiuxaoMgXJ1244m4ruH18qc68Znr6UUGzwCzuU2C9v5jXK4gVj
         zRUgYmMcZewaOFdID9uFreKX09Rc3TlzuzxpFFpya19KYuaI/rNR+yTSeN1wWhUXwVi9
         uzvg==
X-Forwarded-Encrypted: i=1; AJvYcCVLUOdW0yzoBcaLyVoAf/UiaLBZ2tZ0nc3HYwgQ9rfP0hWzAlRuY+vjBZBNAr+4viNGezeJ9N2B@vger.kernel.org
X-Gm-Message-State: AOJu0YwrcP5zavDf9iq21/FV2p9DbU5DVfh5JgI3k2Lcpf0zJJ0oQxKc
	F2n7NsDSF7fe2Yen92JLg9CYfvx3as2ZeOAhUkEgU69H11hCiNEeFSoVzKOQo0lGcGD+EQOLyjG
	yZtF969wajjAE7l48ecLUS0imxdKcfhQlkcS5PUsU
X-Gm-Gg: ASbGncsx3b+uBMPSykqxsEkeU/K4aLCMquLnxhrfLGRxTQN/jokeyfldKoEEzdfxysB
	4Cfbdcm58BFRQwAjUZcPhF9FFBzRrGzwZVNwUJjzALFalyIYv/o7rce7W4wC6EStMj5x8A2x7W2
	D+nGo2vxbw1nunjF579rpVEdr1xVDG5/1EHzhVh2pu9KvO1eAuWPnvWhe9m2QKOme0JXRNdmffQ
	pRxzCdefPctknUx3yluFJVL/t65hv7k8Qv9aKGBWAMK
X-Google-Smtp-Source: AGHT+IEpsuLg57KeWm89BZgtIm9RkiFt9/IvL1pt8dPdyEbMc9G1YFKO2IdV8XoDjVFZgzs9MuDgCYFK40OVoWDMZKk=
X-Received: by 2002:a05:622a:55:b0:4b1:22f0:8016 with SMTP id
 d75a77b69052e-4b625170bbbmr869751cf.2.1757447293887; Tue, 09 Sep 2025
 12:48:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909065349.574894-1-liulei.rjpt@vivo.com> <fszpgct7ywqy6qq3qnjflol3theovmgnau2wgdqqdxin4q7ezm@zumgw533hxon>
In-Reply-To: <fszpgct7ywqy6qq3qnjflol3theovmgnau2wgdqqdxin4q7ezm@zumgw533hxon>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Sep 2025 12:48:02 -0700
X-Gm-Features: AS18NWCnZI1Tq2lGwilQ5dvnko06eauIx4vwc90RQw36tzlJKEe_P08UvcGzo3g
Message-ID: <CAJuCfpFaTj8PsXkoYRQKQ0sOu+mKikUAE8Wbcx+YpZXZ4M7cMA@mail.gmail.com>
Subject: Re: [PATCH v0 0/2] mm: swap: Gather swap entries and batch async release
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Lei Liu <liulei.rjpt@vivo.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Chris Li <chrisl@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
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

On Tue, Sep 9, 2025 at 12:21=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Sep 09, 2025 at 02:53:39PM +0800, Lei Liu wrote:
> > 1. Problem Scenario
> > On systems with ZRAM and swap enabled, simultaneous process exits creat=
e
> > contention. The primary bottleneck occurs during swap entry release
> > operations, causing exiting processes to monopolize CPU resources. This
> > leads to scheduling delays for high-priority processes.
> >
> > 2. Android Use Case
> > During camera launch, LMKD terminates background processes to free memo=
ry.
>
> How does LMKD trigger the kills? SIGKILL or cgroup.kill?

SIGKILL

>
> > Exiting processes compete for CPU cycles, delaying the camera preview
> > thread and causing visible stuttering - directly impacting user
> > experience.
>
> Since the exit/kill is due to low memory situation, punting the memory
> freeing to a low priority async mechanism will help in improving user
> experience. Most probably the application (camera preview here) will get
> into global reclaim and will compete for CPU with the async memory
> freeing.
>
> What we really need is faster memory freeing and we should explore all
> possible ways. As others suggested fix/improve the bottleneck in the
> memory freeing path. In addition I think we should explore parallelizing
> this as well.
>
> On Android, I suppose most of the memory is associated with single or
> small set of processes and parallelizing memory freeing would be
> challenging. BTW is LMKD using process_mrelease() to release the killed
> process memory?

Yes, LMKD has a reaper thread which wakes up and calls
process_mrelease() after the main LMKD thread issued SIGKILL.

>

