Return-Path: <cgroups+bounces-6173-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 207F3A12DCF
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 22:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C29B188A695
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2025 21:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DD91DA11B;
	Wed, 15 Jan 2025 21:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3w27ilVJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE40156F57
	for <cgroups@vger.kernel.org>; Wed, 15 Jan 2025 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736977027; cv=none; b=DFTDM0PNSYB+Ey2jvklhhFF2rd7jqcXV+5tIf9YplyWh6n6Qso+7REHA5vhJnLvMRW86BrfZrIC17cwB208tHfDL6YszXH2zmJpEq9iP+xMXZIcAzCuiudiTt4+m+FlStcEOmkQooca0rhfXzlMV2tFrSVwv0Sf0dmf0J99J0dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736977027; c=relaxed/simple;
	bh=E/YG1SikZgbficxZx6EXIAM4E0Uakc+XtGWZn1+3N/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAtfTGT+EsZuaV7nkdTymG//INtYG/2TnV0tSRBuhS4dVD1mL861ILagKPU+qEnbWCjfoNlNScrpvQnaRkhSWrEUB2CIurWcV46jmmsSFPZASQEDix/huDBVsd7pZ2nXDNYxHRDvMlkuDvX2h2o2QzlngD0tYZKa6M+uf5d1pTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3w27ilVJ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b700c13edaso11223885a.3
        for <cgroups@vger.kernel.org>; Wed, 15 Jan 2025 13:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736977025; x=1737581825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CizrBrhzcDgrTIqS9kYZgWrDglRMWmTQxzWdQcUOOw=;
        b=3w27ilVJAgHQb0eMOLKRWb1WMMSXk5SKm+YoPAET2gQ9eACUlvltVim52WQuB8yDHb
         /hk2gHbQvRw1hRrDwaDJm3QaQZNsuMChesf+nCdup18WfjFP641Vw/tTtoCn4RKVd4fK
         O3qh40HN7CtKfK8uNNd3AoEKW/UwS8mPtYnc8EM2GOYzYrhUeWgl3pgHUg/per3iUkV0
         PKO0NOwkOLWWVXXSbI+Lx63yzS6pibzqbzhjavLkbQdhksOsIWGzFzJCI/AAKDzfG7Jp
         YtQJzK2RjCqZAdRaN+hKFlJfuB9CHyljSQYI3m837m4m+DK7B2JD/9hxtpb4Xj6RmfgQ
         rERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736977025; x=1737581825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CizrBrhzcDgrTIqS9kYZgWrDglRMWmTQxzWdQcUOOw=;
        b=kb3Lt1GEXnsjCcFHnCjcLmGC8h4Xqwt83KmKHrS5+hvoATglVNOxb+U89Af4kmOKwe
         WTjjMMkWf+Y2Ucr0MDumvTnxv+PE/uNP2NAmvWmUQGnRoMcJwhw2pqPh6SatManqBd0V
         03ULrywA33pCpj+N47eOx7vzlVLs/Nar0Zwdd3PO6PBcWwMFpqgF294NcAqI3b/hAtyH
         LvhGuISMvwxwtuhXBTNr4urtjEwh09cvxTyiOA66J96r5tBUq13rW7EDo2QQFP2uftcy
         RQkaNlIOgS1T0WhyfyUQ7ufYadaQS/+mgMWEr+6L+waB6xOROcNf+pZFWDmSbl9KCyFf
         R92A==
X-Forwarded-Encrypted: i=1; AJvYcCWvSMafSViwCgV2+LxDceg9ewS4zFpP0+XZZJXXtMi646q5husRIkCZx+IskcevigAXMJhCwh08@vger.kernel.org
X-Gm-Message-State: AOJu0YxiWObxD0DbPysgN+Bci1VFtfOZi2fuLAsvCu2WYD8eSH57B1IC
	OW6TjrqBGzZCKKcBKcoNIV7hxM2FBGGsElFvj5erb+TnhQfEyLXsz7Yd5HLe8+iU3CIN/TLZxPr
	YZpVqKuMBA+C8CpsZtr0FzKAMQ2h0CupFdrQx
X-Gm-Gg: ASbGncuQ7vKz3ACx6M8Ep/4b/pljkHSeOYzZNQN8ThLl6iM62RbFiBBiZRiAf1rceQk
	UxyDq65QkJA+LR4NDLypI+pmX6bwwgZzI8sg=
X-Google-Smtp-Source: AGHT+IGadMPMDftUZZ1Cy9aXiE6CqdJ86cdL8uLSBK0+zEKACimk3BxqR9gWNGe1f/1AiI0+hqPp5ulJ5BoXOgeiZH8=
X-Received: by 2002:ad4:5d4e:0:b0:6d8:899e:c3bf with SMTP id
 6a1803df08f44-6df9b2d37a0mr500483466d6.34.1736977024924; Wed, 15 Jan 2025
 13:37:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241224011402.134009-1-inwardvessel@gmail.com>
 <cenwdwpggezxk6hko6z6je7cuxg3irk4wehlzpj5otxbxrmztp@xcit4h7cjxon>
 <3wew3ngaqq7cjqphpqltbq77de5rmqviolyqphneer4pfzu5h5@4ucytmd6rpfa>
 <3348742b-4e49-44c1-b447-b21553ff704a@gmail.com> <CAJD7tkbhzWaSnMJwZJU+fdMFyXjXBAPB1yfa0tKADucU7HyxUQ@mail.gmail.com>
 <babbf756-48ec-47c7-91fc-895e44fb18cc@gmail.com>
In-Reply-To: <babbf756-48ec-47c7-91fc-895e44fb18cc@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 15 Jan 2025 13:36:28 -0800
X-Gm-Features: AbW1kvbW5LvYu8-fNVnjNchSkPu-0y59Nwd4frxavtQZbYj1NLjv2El8eSdshWk
Message-ID: <CAJD7tkZAc_ZBpUL2+X6zjBCQxU+EHjQy+jZMDg5C8XTT5vXm=w@mail.gmail.com>
Subject: Re: [PATCH 0/9 RFC] cgroup: separate rstat trees
To: JP Kobryn <inwardvessel@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 11:39=E2=80=AFAM JP Kobryn <inwardvessel@gmail.com>=
 wrote:
>
> Hi Yosry,
>
> On 1/14/25 5:39 PM, Yosry Ahmed wrote:
> > On Tue, Jan 14, 2025 at 5:33=E2=80=AFPM JP Kobryn <inwardvessel@gmail.c=
om> wrote:
> >>
> >> Hi Michal,
> >>
> >> On 1/13/25 10:25 AM, Shakeel Butt wrote:
> >>> On Wed, Jan 08, 2025 at 07:16:47PM +0100, Michal Koutn=C3=BD wrote:
> >>>> Hello JP.
> >>>>
> >>>> On Mon, Dec 23, 2024 at 05:13:53PM -0800, JP Kobryn <inwardvessel@gm=
ail.com> wrote:
> >>>>> I've been experimenting with these changes to allow for separate
> >>>>> updating/flushing of cgroup stats per-subsystem.
> >>>>
> >>>> Nice.
> >>>>
> >>>>> I reached a point where this started to feel stable in my local tes=
ting, so I
> >>>>> wanted to share and get feedback on this approach.
> >>>>
> >>>> The split is not straight-forwardly an improvement --
> >>>
> >>> The major improvement in my opinion is the performance isolation for
> >>> stats readers i.e. cpu stats readers do not need to flush memory stat=
s.
> >>>
> >>>> there's at least
> >>>> higher memory footprint
> >>>
> >>> Yes this is indeed the case and JP, can you please give a ballmark on
> >>> the memory overhead?
> >>
> >> Yes, the trade-off is using more memory to allow for separate trees.
> >> With these patches the changes in allocated memory for the
> >> cgroup_rstat_cpu instances and their associated locks are:
> >> static
> >>          reduced by 58%
> >> dynamic
> >>          increased by 344%
> >>
> >> The threefold increase on the dynamic side is attributed to now having=
 3
> >> rstat trees per cgroup (1 for base stats, 1 for memory, 1 for io),
> >> instead of originally just 1. The number will change if more subsystem=
s
> >> start or stop using rstat in the future. Feel free to let me know if y=
ou
> >> would like to see the detailed breakdown of these values.
> >
> > What is the absolute per-CPU memory usage?
>
> This is what I calculate as the combined per-cpu usage.
> before:
>         one cgroup_rstat_cpu instance for every cgroup
>         sizeof(cgroup_rstat_cpu) * nr_cgroups
> after:
>         three cgroup_rstat_cpu instances for every cgroup + updater lock =
for
> every subsystem plus one for base stats
>         sizeof(cgroup_rstat_cpu) * 3 * nr_cgroups +
>                 sizeof(spinlock_t) * (CGROUP_SUBSYS_COUNT + 1)
>
> Note that "every cgroup" includes the root cgroup. Also, 3 represents
> the number of current rstat clients: base stats, memory, and io
> (assuming all enabled).

On a config I have at hand sizeof(cgroup_rstat_cpu) is 160 bytes.
Ignoring the spinlock for a second because it doesn't scale with
cgroups, that'd be an extra 320 * nr_cgroups * nr_cpus bytes. On a
moderately large machine with 256 CPUs and 100 cgroups for example
that's ~8MB.

>
> As I'm writing this, I realize I might need to include the bpf cgroups
> as a fourth client and include this in my testing.

