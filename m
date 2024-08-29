Return-Path: <cgroups+bounces-4565-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71891964624
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 15:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2CA11F2562A
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 13:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBA118CC16;
	Thu, 29 Aug 2024 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JfbvytNj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF711A76A4
	for <cgroups@vger.kernel.org>; Thu, 29 Aug 2024 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937365; cv=none; b=BBssZCV5F21MtazzOe32QJyRSAuCj/0R7fJy2OfiftlCuIPrEXIKlv+Rm+mnd74LxfD+oCLItFm5F6mLy98kPVoJT0Ej6H0Kpr6DNDoPhOj/D5PLXqfuweGKgyk8ymK64oHvHKaaX9vZpvDEwtE41/6E3Y5esT+cSH6urZBavW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937365; c=relaxed/simple;
	bh=e/WUvS7o+iUBTbPcXTgn+ASDZHn5Ivg8BT5PmvfYugo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmuQgmeJkbQmsW74oT9YyhUxfhf6VrKD8N95TYXHfv3cYD105lvbrU/sdNG20izOBof3MKl+rsaU3JKmHRj3niqOMl28ivCvtyHnSy6HEHFANY5C6/NGh9n4eXsC9qsBaBryHpjPpmCgssbDNUXQo0iB9k5lo8b6qdE7/yIYbv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JfbvytNj; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5334879ba28so887102e87.3
        for <cgroups@vger.kernel.org>; Thu, 29 Aug 2024 06:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724937362; x=1725542162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/WUvS7o+iUBTbPcXTgn+ASDZHn5Ivg8BT5PmvfYugo=;
        b=JfbvytNjMyJ3bYzq5obHkcTimJBJ63V8/arNphVq2tSXPpTeugNjzWIAjveTwYstQz
         Qxf2CKnEysgTCsN8O5xCY7M5cBJk+ujlG/in4Jb4rEK/PSM/CDG1C6CJGf1ljwtEmsoX
         /OpMWkns2FlLN5DWXH/OlT1jCq0FCM1g3OMldSMYxcUpa9obS1vW3ekr28fhuGLjEo0O
         +plXvEeeYIyey7hIU4/s7RCIxeGIyxjHYU5/aYlaQz9LOLDo5a7oEeQ0mjVfY54kMO9u
         EP8Ar0nTMbrUUgwnmKnUKoK3TxePD+iIxwOA4//GtX/JxSKD3zlbp/QUNYqiumPHhl51
         EkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724937362; x=1725542162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/WUvS7o+iUBTbPcXTgn+ASDZHn5Ivg8BT5PmvfYugo=;
        b=VXSWsq+ow9yw7mNJgFmB0gDyE8IZ6n2u7FaqjCsl8W8p0g+xOhj1mRk5YsuIhf+le2
         sdnNp95ohL0znET3D63uGssUI+ihn6zdo+dkE3G0Err1CODhxaHyHex4jHlGracfDPzH
         0tN0beBOcGYDP4Dgfy93lqB+5Goo82VwKE2oyz4zlRv/8TDpa2QbnFGYpL0aPRNgh/QU
         2waplHxWaJR25dfWvYlyQzXCH/yEIy6vcocPrdtIKIBZbuRpmDSvc0w0nknJp16Dxmso
         1mvawcE5i2VNrjc8kAJ3aUncwFL1ICpuqyZMCw20tf2jVBmb6k5pOo/MTUBK+t9UTxVR
         bSQg==
X-Forwarded-Encrypted: i=1; AJvYcCWLWJAPDd6BQygbxnCzfyjkcT+ZN+GbBi4nw0Wb3JwHE7hNpHReXDRVrOGsjZJrn/9zYxeh2vNa@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6x3SUKsWJiP6QwG83X9frMiDvvnn81ThuzSf15srPpJYVpuJw
	wfxsSkwgeNcNaaZeUvfkqTZqvQAGwp8IQWQbTqh+whbKjqLTwo9PLuVWELTRXymyG6PDtxxfSRG
	8TlBpANozEfWOb+lye7feAZjZ/rbfi60792G0Ug==
X-Google-Smtp-Source: AGHT+IHjyGQz5NP4fFZPSi+bp5f5hV+whwoKce2ggHgKq4FyBIX3MhcdolfSvWRE7Ugmvx17JWG6SjaJw25/lF7vaJk=
X-Received: by 2002:a05:6512:1248:b0:52e:7ef1:7c6e with SMTP id
 2adb3069b0e04-5353e5bddaemr1965579e87.51.1724937361579; Thu, 29 Aug 2024
 06:16:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829101918.3454840-1-hezhongkun.hzk@bytedance.com>
 <ZtBMO1owCU3XmagV@tiehlicka> <CACSyD1Ok62n-SF8fGrDQq_JC4SUSvFb-6QjgjnkD9=JacCJiYg@mail.gmail.com>
 <ZtBglyqZz_uGDnOS@tiehlicka>
In-Reply-To: <ZtBglyqZz_uGDnOS@tiehlicka>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Thu, 29 Aug 2024 21:15:50 +0800
Message-ID: <CACSyD1NWVe9gjo15xsPnh-JUEsacawf47uoiu439tRO7K+ov5g@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 0/2] Add disable_unmap_file arg to memory.reclaim
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, lizefan.x@bytedance.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 7:51=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 29-08-24 18:37:07, Zhongkun He wrote:
> > On Thu, Aug 29, 2024 at 6:24=E2=80=AFPM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Thu 29-08-24 18:19:16, Zhongkun He wrote:
> > > > This patch proposes augmenting the memory.reclaim interface with a
> > > > disable_unmap_file argument that will skip the mapped pages in
> > > > that reclaim attempt.
> > > >
> > > > For example:
> > > >
> > > > echo "2M disable_unmap_file" > /sys/fs/cgroup/test/memory.reclaim
> > > >
> > > > will perform reclaim on the test cgroup with no mapped file page.
> > > >
> > > > The memory.reclaim is a useful interface. We can carry out proactiv=
e
> > > > memory reclaim in the user space, which can increase the utilizatio=
n
> > > > rate of memory.
> > > >
> > > > In the actual usage scenarios, we found that when there are suffici=
ent
> > > > anonymous pages, mapped file pages with a relatively small proporti=
on
> > > > would still be reclaimed. This is likely to cause an increase in
> > > > refaults and an increase in task delay, because mapped file pages
> > > > usually include important executable codes, data, and shared librar=
ies,
> > > > etc. According to the verified situation, if we can skip this part =
of
> > > > the memory, the task delay will be reduced.
> > >
> > > Do you have examples of workloads where this is demonstrably helps an=
d
> > > cannot be tuned via swappiness?
> >
> > Sorry, I put the test workload in the second patch. Please have a look.
>
> I have missed those as they are not threaded to the cover letter. You
> can either use --in-reply-to when sending patches separately from the
> cover letter or use can use --compose/--cover-leter when sending patches
> through git-send-email

Got it, thanks. I encountered a problem after sending the cover letter, so
I resent the others without --in-reply-to.

>
> > Even if there are sufficient anonymous pages and a small number of
> > page cache and mapped file pages, mapped file pages will still be recla=
imed.
> > Here is an example of anonymous pages being sufficient but mapped
> > file pages still being reclaimed:
> > Swappiness has been set to the maximum value.
> >
> > cat memory.stat | grep -wE 'anon|file|file_mapped'
> > anon 3406462976
> > file 332967936
> > file_mapped 300302336
> >
> > echo 1g > memory.reclaim swappiness=3D200 > memory.reclaim
> > cat memory.stat | grep -wE 'anon|file|file_mapped'
> > anon 2613276672
> > file 52523008
> > file_mapped 30982144
>
> This seems to be 73% (ano) vs 27% (file) balance. 90% of the
> file LRU seems to be mapped which matches 90% of file LRU reclaimed
> memory to be mapped. So the reclaim is proportional there.
>
> But I do understand that this is still unexpected when swappiness=3D200
> should make reclaim anon oriented. Is this MGLRU or regular LRU
> implementation?
>

This is a regular LRU implementation and the MGLRU has the same questions
but performs better. Please have a look:

root@vm:/sys/fs/cgroup/test# cat /sys/kernel/mm/lru_gen/enabled
0x0007

root@vm:/sys/fs/cgroup/test# cat memory.stat | grep -wE 'anon|file|file_map=
ped'
anon 3310338048
file 293498880
file_mapped 273506304

root@vm:/sys/fs/cgroup/test# echo 1g > memory.reclaim swappiness=3D200 >
memory.reclaim

root@vm:/sys/fs/cgroup/test# cat memory.stat | grep -wE 'anon|file|file_map=
ped'
anon 2373173248
file 157233152
file_mapped 146173952

root@vm:/sys/fs/cgroup/test# echo 1g > memory.reclaim swappiness=3D200 >
memory.reclaim
root@vm:/sys/fs/cgroup/test# cat memory.stat | grep -wE 'anon|file|file_map=
ped'
anon 1370886144
file 85663744
file_mapped 78118912

> Is this some artificial workload or something real world?
>

This is an artificial workload to show the detail of this case more
easily. But we have encountered
this problem on our servers. If the performance of the disk is poor,
like HDD, the situation will
become even worse. The delay of the task becomes more serious because
reading data will be slower.
Hot pages will thrash repeatedly between the memory and the disk. At
this time, the pressure on the
disk will also be greater. If there are many tasks using this disk, it
will also affect other tasks.

That was the background of this case.

>
> --
> Michal Hocko
> SUSE Labs

