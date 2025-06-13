Return-Path: <cgroups+bounces-8514-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7076AD8459
	for <lists+cgroups@lfdr.de>; Fri, 13 Jun 2025 09:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13D1189BFD6
	for <lists+cgroups@lfdr.de>; Fri, 13 Jun 2025 07:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760302E2EF9;
	Fri, 13 Jun 2025 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J++g9obP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE042D3A7C;
	Fri, 13 Jun 2025 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800232; cv=none; b=IzIznQxOU+RT2pCb12utdBAEWLFNB8Gd/z+JMKQIFxqgEOwDzEkptfl9kky5NvtbeOXdH7Kj0UMVURulwdG8XA26Pax6CFQ3TZ5xAFuEzVXlFHtb7hgKMKBJUgJy0uuOSGZENT+4kL40jZZ278DRePGQoXvLuOVT6ZvRJUq5zuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800232; c=relaxed/simple;
	bh=lgZkCQolcGVeoldt7I+qAyGjXtMl8kWBTaIhmRsz7bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHrm2AflLcLEi3DVBOho18L4v1LecTcfnOqQjMy1zSHvS9Hha6FDQPKt65EGejC5e7G4Q7IUEKIMvpItln+Z7dkCzCb+8jRuWLdQwNrIFtthNFgRXMBNqldXoAkV2oC8RcUs8F3ognv1tnrASku/AcrbaulOEANPefRY+Qivs9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J++g9obP; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32b42935293so1220141fa.1;
        Fri, 13 Jun 2025 00:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749800228; x=1750405028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JMXW+Fubsd2ScoNgRtDk/k43gI4z7MQw3P6LblrECY=;
        b=J++g9obPQSt1Dm7C9KY3y71YVuBb5YCb/BC4GhTd6g4+yA+2U0w3uywkqJZgjTaImb
         BxLiWHWBfPbdXXN49HICKbvX3GOWs1N06gCO7wYCXQFYgbDk+9VcR0iOFU+f4wylrG5g
         vGLyPcr1QwN6iwW2CVJUhiCVcKssvJKXIblbYEcYjmaM3odb7mjllId7/eR2CH4B3eoX
         C0lesccJ78Fq92XLyGC8pwQKDPa9NBfenFoXT/9+6WtcQyMAkgHqFkE6WuPVshA0F76z
         7wZdH0dcZ/pp5oQTDrXmxlbEqpurtheiSo80cse4EOLyJ5dKxpOWMhH5FQQ2Q9Mp7y1m
         GAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749800228; x=1750405028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JMXW+Fubsd2ScoNgRtDk/k43gI4z7MQw3P6LblrECY=;
        b=Xb33getp1lbxY4flcmNXvT9VznveK+vp1j2kT8j/DSVA8hfo7WipMzA+tWP5itW+kf
         HHNpOYqBHvvy3/c0OLIZWNWTJ9EaFlg86GsteZuWLtCggmzc0xM3Dmrpwn1T558rEFbF
         TdArNfHs817mCClI/REwCLmUXa3oGYLjWf3wmXVfj7xMHtKR1Z+uvpiE3urWxOCPzYBj
         LfeRQiufovp8//hBIOZozJxudWXGLnxH+N2JmqlTz6kybWwU3cA69+VDUbWHTg41xe72
         kRBtX0UplT2UnVLkm0rfSIYhzieaAdhUP/38QkxXjbFwLU6YmILhwxL9F2WmQdrZQhg+
         dGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3lHuSpPTP/wj+5zNw07CVlehwC6E6bvnXv79YeMEwjeJ3TlvcHlpmAcyikHKM+GbtR/diBAbeHKV+PJj2@vger.kernel.org, AJvYcCViQlbQsfLSMEhp+giKsrAhNH+WlFMBC8uWqlL/jD4GWMSnLYVDyvfP+XvAieiJ4XXz70Hrk7YH@vger.kernel.org
X-Gm-Message-State: AOJu0Yye2YshHNf6yqi2boCE/fY5Lb1MdFlPwQXtvTwGrHmVuXZUaG+m
	GVrQqvxOPfKnKxOCW4Q4t6ZfTT8vtLYHVMvIfmMLMkHnihuuSg676VfRVcDJAlYlKhM4aaWBmOM
	iujW+mctoIf4BePtyGGaq1+ALbysFsnmgqMQnfBVhDA==
X-Gm-Gg: ASbGncsl/3oYuQ+81DyMR3Cl0DHZxWk5kD2nSg2gWYtAvryLrvN619StF4lABMKg9MO
	kXQlq5zzGBFRBJNGoTVAFCH5M/0+LTnkDng6fOVpRVB3HDSeFjBs0aZaOBA3j6q4FKvW+KBiUmV
	wBrwkbSer+j+FKJ5FR0STCacl8GiDAqh1JYCe54T7Yavk=
X-Google-Smtp-Source: AGHT+IFMuNXpkWg337BKT0ddarpu8Q4pCBucJjSwDblfnCzSGAj33wZ3yIdKu2WNBM7imca3M/FSbtyTNri2JvwjQi4=
X-Received: by 2002:a2e:a781:0:b0:32a:de39:eb4c with SMTP id
 38308e7fff4ca-32b3ea8365emr4291071fa.18.1749800227901; Fri, 13 Jun 2025
 00:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612103743.3385842-1-youngjun.park@lge.com>
 <20250612103743.3385842-3-youngjun.park@lge.com> <CAMgjq7BJE9ALFG4N8wb-hdkC+b-8d1+ckXL9D6pbbfgiXfuzPA@mail.gmail.com>
 <CAKEwX=PsGKS5JHqQ-G29Fg8xLssPhM+E-4wV_QakhqrDOsV36g@mail.gmail.com>
 <CAMgjq7Aq1LW9wFgyQ4oCS5Su23X62S+5ZW_d5OydJj-pp2n21Q@mail.gmail.com>
 <CAKEwX=PD+P_wugkAJ83ti6YRo4-6QNM7HDFs+KDURVwx2JrnZg@mail.gmail.com> <aEvPBSObBrrQCsa3@yjaykim-PowerEdge-T330>
In-Reply-To: <aEvPBSObBrrQCsa3@yjaykim-PowerEdge-T330>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 13 Jun 2025 15:36:49 +0800
X-Gm-Features: AX0GCFvxU12N2ikQf07wfssB5TNdh0YDBnXk-zYOmBRR-5m8A5AUKNKIwDo2D0g
Message-ID: <CAMgjq7BzQ8bKKXuHB=TiQnkdSdCuABXrRf8Z8w2QkjpD44jdgA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm: swap: apply per cgroup swap priority
 mechansim on swap layer
To: YoungJun Park <youngjun.park@lge.com>
Cc: Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shikemeng@huaweicloud.com, bhe@redhat.com, baohua@kernel.org, 
	chrisl@kernel.org, muchun.song@linux.dev, iamjoonsoo.kim@lge.com, 
	taejoon.song@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 3:11=E2=80=AFPM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> On Thu, Jun 12, 2025 at 01:08:08PM -0700, Nhat Pham wrote:
> > On Thu, Jun 12, 2025 at 11:20=E2=80=AFAM Kairui Song <ryncsn@gmail.com>=
 wrote:
> > >
> > > On Fri, Jun 13, 2025 at 1:28=E2=80=AFAM Nhat Pham <nphamcs@gmail.com>=
 wrote:
> > > >
> > > > On Thu, Jun 12, 2025 at 4:14=E2=80=AFAM Kairui Song <ryncsn@gmail.c=
om> wrote:
> > > > >
> > > > > On Thu, Jun 12, 2025 at 6:43=E2=80=AFPM <youngjun.park@lge.com> w=
rote:
> > > > > >
> > > > > > From: "youngjun.park" <youngjun.park@lge.com>
> > > > > >
> > > > >
> > > > > Hi, Youngjun,
> > > > >
> > > > > Thanks for sharing this series.
> > > > >
> > > > > > This patch implements swap device selection and swap on/off pro=
pagation
> > > > > > when a cgroup-specific swap priority is set.
> > > > > >
> > > > > > There is one workaround to this implementation as follows.
> > > > > > Current per-cpu swap cluster enforces swap device selection bas=
ed solely
> > > > > > on CPU locality, overriding the swap cgroup's configured priori=
ties.
> > > > >
> > > > > I've been thinking about this, we can switch to a per-cgroup-per-=
cpu
> > > > > next cluster selector, the problem with current code is that swap
> > > >
> > > > What about per-cpu-per-order-per-swap-device :-? Number of swap
> > > > devices is gonna be smaller than number of cgroups, right?
> > >
> > > Hi Nhat,
> > >
> > > The problem is per cgroup makes more sense (I was suggested to use
> > > cgroup level locality at the very beginning of the implementation of
> > > the allocator in the mail list, but it was hard to do so at that
> > > time), for container environments, a cgroup is a container that runs
> > > one type of workload, so it has its own locality. Things like systemd
> > > also organize different desktop workloads into cgroups. The whole
> > > point is about cgroup.
> >
> > Yeah I know what cgroup represents. Which is why I mentioned in the
> > next paragraph that are still making decisions based per-cgroup - we
> > just organize the per-cpu cache based on swap devices. This way, two
> > cgroups with similar/same priority list can share the clusters, for
> > each swapfile, in each CPU. There will be a lot less duplication and
> > overhead. And two cgroups with different priority lists won't
> > interfere with each other, since they'll target different swapfiles.
> >
> > Unless we want to nudge the swapfiles/clusters to be self-partitioned
> > among the cgroups? :) IOW, each cluster contains pages mostly from a
> > single cgroup (with some stranglers mixed in). I suppose that will be
> > very useful for swap on rotational drives where read contiguity is
> > imperative, but not sure about other backends :-?
> > Anyway, no strong opinions to be completely honest :) Was just
> > throwing out some ideas. Per-cgroup-per-cpu-per-order sounds good to
> > me too, if it's easy to do.
>
> Good point!
> I agree with the mention that self-partitioned clusters and duplicated pr=
iority.
> One concern is the cost of synchronization.
> Specifically the one incurred when accessing the prioritized swap device
> From a simple performance perspective, a per-cgroup-per-CPU implementatio=
n
> seems favorable - in line with the current swap allocation fastpath.
>
> It seems most reasonable to carefully compare the pros and cons of the
> tow approaches.
>
> To summaraize,
>
> Option 1. per-cgroup-per-cpu
> Pros: upstream fit. performance.
> Cons: duplicate priority(some memory structure consumtion cost),
> self partioned cluster
>
> Option 2. per-cpu-per-order(per-device)
> Pros: Cons of Option1
> Cons: Pros of Option1
>
> It's not easy to draw a definitive conclusion right away,
> I should also evaluate other pros and cons that may arise during actual
> implementation.
> so I'd like to take some time to review things in more detail
> and share my thoughs and conclusions in the next patch series.
>
> What do you think, Nhat and Kairui?

Ah, I think what might be best fits here is, each cgroup have a pcp
device list,  and each device have a pcp cluster list:

folio -> mem_cgroup -> swap_priority (maybe a more generic name is
better?) -> swap_device_pcp (recording only the *si per order)
swap_device_info -> swap_cluster_pcp (cluster offset per order)

And if mem_cgroup -> swap_priority is NULL, fallback to a global
swap_device_pcp.

This seems to fit what Nhat suggested, and easy to implement, since
both si and folio->memcg are accessible easily.

