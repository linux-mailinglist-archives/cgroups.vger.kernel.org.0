Return-Path: <cgroups+bounces-4065-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B946944A86
	for <lists+cgroups@lfdr.de>; Thu,  1 Aug 2024 13:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255B21C21A91
	for <lists+cgroups@lfdr.de>; Thu,  1 Aug 2024 11:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E357C18FC75;
	Thu,  1 Aug 2024 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVKlo7I+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0620718E051;
	Thu,  1 Aug 2024 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722512451; cv=none; b=loVtCbbbvjN/X/QNIcbH8vCCpD22OurkHCTP1iVDDpBuzK0Nz05lB7f3QazoyesSoncnP/K/lJzJfz5dbZ8H4wKeuA0Tdtrbod4zmTtFsbGYbluswo6C7egvqjmQR2SAcdjFQV3Pqu0tGEjsz6kmKYawAch7AGklYbumJkHuuhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722512451; c=relaxed/simple;
	bh=mz53Znxhu4njp0b5GbjEvsbrkbMH+RLvtS17yyEemDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1bScslDHrsArmUV86ZJn0FTfsAsT+9q5VA91/yCTo+HKr6PbwKD8ojbVHSPuQS01iYiv5TRliNKkaHtjSaV+Bm3z7JTtZhOVkJ32s/4epp44WzQsUC2+PsIJuz1DLxw4NU677Z1h+eSiD2KAaIa/SEb0lQi/BI28lakuONXun8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVKlo7I+; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a91cdcc78so409934366b.3;
        Thu, 01 Aug 2024 04:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722512448; x=1723117248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4h0C3m16RHauZJhat03rjfnW666/JF+l3iulFI7afA=;
        b=YVKlo7I+6A+suqSPMNy+L5WufvNXwLG7QyuJOenMZDhMz4o86uTsbaN3hSSG5TmUE+
         gi/vUwvwQZeTrxzQqi/xiZHYBUHwWdu0OypNE3gz4ro3hzqs8A2Oki7wFVV2KynHUN+f
         baDjjdAD55CX051SW/FdwUmsMMzwcAR6r3Fpo3xSXb1HySg6i5cx+crZRswCOVBsuIv5
         /w2FptqirKTqSYW+T5Jm3RFiySKLPebrmtRK3MHrfYkE7MoM77wrUx5I/BGoYRIkNBwB
         cj4pzFtfIX/iFSupW43DNCVyaMG++9ehZqJxKl0KkiokoxBH+U3bM1mx3AwZzFFT4TQt
         mQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722512448; x=1723117248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4h0C3m16RHauZJhat03rjfnW666/JF+l3iulFI7afA=;
        b=oBwVAWLsDSq51iju2JC04tk+iqC0vt9vRV0vfSpZN+6V6tuf8iDLuxxktQWc9U+wNz
         kOXrSMCODbQbw5/qdlNVaGKVnYfFB2nW/D0Ko5awrGCnXH4v3Cx4kAiMNu1F4vy7qptE
         1LT/zd+dNo6NLxvtklctCkAQ8gY0SaXKIrNAoIj23ZTOAxpp9RfoFEXi4mRw68Lk7tVa
         KR8XuQaFpUPhkSSjNQmFcT6nv4lTnZuybCi+yjd7Ex6lqN49ICv0+MbyUcSUVI+jkkUw
         vUdqUQMPfNqGQx0VDabyRbBSGdO4pnipDIuZyfemWdXu16mt/kHnfTtAxmOuemE7yVRZ
         3WVg==
X-Forwarded-Encrypted: i=1; AJvYcCWCdD6L96tMrsqAR2jrPaVBkfkX6QjMEdwziOayTuQ53nt8/1/s0wfKy98SA4VyL5zOQOuIiijdT97HmuKgydaj14mlVvNKPeCr2eJusTAZL4wBHixgjk91h+1jj6BlURgbcdN//w==
X-Gm-Message-State: AOJu0Yww2KKt8/514CKPUNOkpZVX1tQWGG7Bb0NQ7aXX2lzWQa8IMh4F
	7eAGZlBRg3nmf/pqI2fbaGv1RhyfsFXVZxcrDK7Dz5KTbhq2yGuADpda8kl4zpl5mNvfmg5eXZr
	VfYKivndwWPNv8exhYjj3IIrYyos=
X-Google-Smtp-Source: AGHT+IGvq30QUdJ2Ae3lQEO36wJYwLrAji75UF3q3P+jQkl895vx2DLPN9vA1jIrFJbik/B0ppK5WjmLrJ6gbLUaeTw=
X-Received: by 2002:a05:6402:14d0:b0:5a1:5692:b5f9 with SMTP id
 4fb4d7f45d1cf-5b700f8a256mr1773662a12.38.1722512447847; Thu, 01 Aug 2024
 04:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801045430.48694-1-ioworker0@gmail.com> <2527d5a4-de1f-4c93-b7ee-fdd6fbe2a6f0@kernel.org>
In-Reply-To: <2527d5a4-de1f-4c93-b7ee-fdd6fbe2a6f0@kernel.org>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 1 Aug 2024 19:40:10 +0800
Message-ID: <CAK1f24knBez71sEvcfFoFuyvap+=3LzsRrmW-+fLsqV3WkyMBA@mail.gmail.com>
Subject: Re: [BUG] mm/cgroupv2: memory.min may lead to an OOM error
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: akpm@linux-foundation.org, 21cnbao@gmail.com, ryan.roberts@arm.com, 
	david@redhat.com, shy828301@gmail.com, ziy@nvidia.com, libang.li@antgroup.com, 
	baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vlastimil,

Thanks a lot for paying attention!

On Thu, Aug 1, 2024 at 6:35=E2=80=AFPM Vlastimil Babka (SUSE) <vbabka@kerne=
l.org> wrote:
>
> On 8/1/24 06:54, Lance Yang wrote:
> > Hi all,
> >
> > It's possible to encounter an OOM error if both parent and child cgroup=
s are
> > configured such that memory.min and memory.max are set to the same valu=
es, as
> > is practice in Kubernetes.
>
> Is it a practice in Kubernetes since forever or a recent one? Did it work
> differently before?

The memory.min is only applied when the Kubernetes memory QoS feature gate
is enabled, which is disabled by default.

>
> > Hmm... I'm not sure that whether this behavior is a bug or an expected =
aspect of
> > the kernel design.
>
> Hmm I'm not a memcg expert, so I cc'd some.
>
> > To reproduce the bug, we can follow these command-based steps:
> >
> > 1. Check Kernel Version and OS release:
> >
> >     ```
> >     $ uname -r
> >     6.10.0-rc5+
>
> Were older kernels behaving the same?

I tested another machine and it behaved the same way.

# uname -r
5.14.0-427.24.1.el9_4.x86_64

# cat /etc/os-release
NAME=3D"Rocky Linux"
VERSION=3D"9.4 (Blue Onyx)"
...

>
> Anyway memory.min documentations says "Hard memory protection. If the mem=
ory
> usage of a cgroup is within its effective min boundary, the cgroup=E2=80=
=99s memory
> won=E2=80=99t be reclaimed under any conditions. If there is no unprotect=
ed
> reclaimable memory available, OOM killer is invoked."
>
> So to my non-expert opinion this behavior seems valid. if you set min to =
the
> same value as max and then reach the max, you effectively don't allow any
> reclaim, so the memcg OOM kill is the only option AFAICS?

I completely agree that this behavior seems valid ;)

However, if the child cgroup doesn't exist and we add a process to the 'tes=
t'
cgroup, then attempt to create a large file(2GB) using dd, we won't encount=
er
an OOM error; everything works as expected.

Hmm... I'm a bit confused about that.

Thanks,
Lance

>
> >     $ cat /etc/os-release
> >     PRETTY_NAME=3D"Ubuntu 24.04 LTS"
> >     NAME=3D"Ubuntu"
> >     VERSION_ID=3D"24.04"
> >     VERSION=3D"24.04 LTS (Noble Numbat)"
> >     VERSION_CODENAME=3Dnoble
> >     ID=3Dubuntu
> >     ID_LIKE=3Ddebian
> >     HOME_URL=3D"<https://www.ubuntu.com/>"
> >     SUPPORT_URL=3D"<https://help.ubuntu.com/>"
> >     BUG_REPORT_URL=3D"<https://bugs.launchpad.net/ubuntu/>"
> >     PRIVACY_POLICY_URL=3D"<https://www.ubuntu.com/legal/terms-and-polic=
ies/privacy-policy>"
> >     UBUNTU_CODENAME=3Dnoble
> >     LOGO=3Dubuntu-logo
> >
> >     ```
> >
> > 2. Navigate to the cgroup v2 filesystem, create a test cgroup, and set =
memory settings:
> >
> >     ```
> >     $ cd /sys/fs/cgroup/
> >     $ stat -fc %T /sys/fs/cgroup
> >     cgroup2fs
> >     $ mkdir test
> >     $ echo "+memory" > cgroup.subtree_control
> >     $ mkdir test/test-child
> >     $ echo 1073741824 > memory.max
> >     $ echo 1073741824 > memory.min
> >     $ cat memory.max
> >     1073741824
> >     $ cat memory.min
> >     1073741824
> >     $ cat memory.low
> >     0
> >     $ cat memory.high
> >     max
> >     ```
> >
> > 3. Set up and check memory settings in the child cgroup:
> >
> >     ```
> >     $ cd test-child
> >     $ echo 1073741824 > memory.max
> >     $ echo 1073741824 > memory.min
> >     $ cat memory.max
> >     1073741824
> >     $ cat memory.min
> >     1073741824
> >     $ cat memory.low
> >     0
> >     $ cat memory.high
> >     max
> >     ```
> >
> > 4. Add process to the child cgroup and verify:
> >
> >     ```
> >     $ echo $$ > cgroup.procs
> >     $ cat cgroup.procs
> >     1131
> >     1320
> >     $ ps -ef|grep 1131
> >     root        1131    1014  0 10:45 pts/0    00:00:00 -bash
> >     root        1321    1131 99 11:06 pts/0    00:00:00 ps -ef
> >     root        1322    1131  0 11:06 pts/0    00:00:00 grep --color=3D=
auto 1131
> >     ```
> >
> > 5. Attempt to create a large file using dd and observe the process bein=
g killed:
> >
> >     ```
> >     $ dd if=3D/dev/zero of=3D/tmp/2gbfile bs=3D10M count=3D200
> >     Killed
> >     ```
> >
> > 6. Check kernel messages related to the OOM event:
> >
> >     ```
> >     $ dmesg
> >     ...
> >     [ 1341.112388] oom-kill:constraint=3DCONSTRAINT_MEMCG,nodemask=3D(n=
ull),cpuset=3D/,mems_allowed=3D0,oom_memcg=3D/test,task_memcg=3D/test/test-=
child,task=3Ddd,pid=3D1324,uid=3D0
> >     [ 1341.112418] Memory cgroup out of memory: Killed process 1324 (dd=
) total-vm:15548kB, anon-rss:10240kB, file-rss:1764kB, shmem-rss:0kB, UID:0=
 pgtables:76kB oom_score_adj:0
> >     ```
> >
> > 7. Reduce the `memory.min` setting in the child cgroup and attempt the =
same large file creation, and then this issue is resolved.
> >
> >     ```
> >     # echo 107374182 > memory.min
> >     # dd if=3D/dev/zero of=3D/tmp/2gbfile bs=3D10M count=3D200
> >     200+0 records in
> >     200+0 records out
> >     2097152000 bytes (2.1 GB, 2.0 GiB) copied, 1.8713 s, 1.1 GB/s
> >     ```
> >
> > Thanks,
> > Lance
> >
>

