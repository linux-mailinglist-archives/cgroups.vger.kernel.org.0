Return-Path: <cgroups+bounces-5306-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E33499B4099
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 03:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200F81C21DD8
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 02:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80261F426C;
	Tue, 29 Oct 2024 02:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ysfqQ2Ul"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D461E1326
	for <cgroups@vger.kernel.org>; Tue, 29 Oct 2024 02:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730169905; cv=none; b=DpBSN22nPF8A7wgN6YORMFDJs67NXgeKQtN8W8mkGEGLYm53fV1jP10PbUu7hJ9X7N8ePdPs2x5OIDCDfHI9/hv8zOFJD3PM45g1Lk1aSPoOVAKF7ZBPfp+cH5mT6DbTxaMP4HjT6+6xm8qZPO1UmFImX5b13Awy7sV99/UkFuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730169905; c=relaxed/simple;
	bh=pdsv2be4YefjpePCTFKVChgVxBfYJhO3wAqEmnHMSVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDx0A8qox85O2WmXyonEkeQnCO9t4aJDTAy2ET36ksc85LjJsR1slKtvbEDWnxKocjFw0KHrG8e3HdmiftNipECcFnTmfA046V2CS/rinsVb1H6DYEL3yiRQVTEZQ36V+gcYg5eCbeekxp0FucrutZBbwJnyKNND9juwR4QWBcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ysfqQ2Ul; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cbd00dd21cso30818836d6.3
        for <cgroups@vger.kernel.org>; Mon, 28 Oct 2024 19:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730169902; x=1730774702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEFOlJ3Dcj7i1Bu5K/HHn2QPSZuGacR1Km4lfVuIo74=;
        b=ysfqQ2UlLlaz7Bp51y8F3WltzqwcjKOgDF0MDJMc/S+Xp6GiwFIN4xXKixrBFYqclH
         6jUArVtOpjUbfR/Q8dQrRLrGZcCN6x/dg5WSCkJIRsUluxNcwpIdkxoEIq/KUF9F8Q9b
         aynSbTR7JnBjIPzrTzb/EIriU9zB2LvpnBsXIka0maAtG47vx2lh4oeWfOib7fD1JoEn
         VjJZcgU64SyKjUK5ji8WLGn/jGueCP3XNDrx1B1oXpaukyv9Aa5fX3VhBPEvzcJvM4Cn
         mn5KF8FWGL/H5nWDNnRoZwlVixoQ4JKAlJo+7jqomut1TriVUx4RMsjS9P1zLJ0FWpCf
         YCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730169902; x=1730774702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEFOlJ3Dcj7i1Bu5K/HHn2QPSZuGacR1Km4lfVuIo74=;
        b=JkCqbJ3q3+LfgbsufIspvBOG+nWp3j1BSmxoE1Qjis0gY5LdopGLuU+RI5GG4hFciN
         BleF7nrJsMQT4eVepUBuQnluFG9Cu5m2oeefztYntQUGVjvtH+5CzUUUHg9I4wKj+x47
         QFHqZ3dp9wTZoRcGyeCEGI9063ArQj/xtgmrUDQ/LUsLrpsTBIinnafBuMU9cK09Ps6f
         YCJsPv/qqKAlmAF7ct/ZqpB8IWBBuRbavdawTeoMax4QcvA6RNyq12N03MiYkOeDZ4X/
         OWh26XoKs4DdsEUhWNhE4n0SgHrg+AzviOab7OdU8SxqPiEuVk7MLerSJcWlWOhbJHsg
         k+7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXI0Qp06cCYHYIAG6uOabCv9CSj9ZdHNHBDfF+3pZSv1jlzKeeKokv9tTR1kedQxMWHxEdy8RhE@vger.kernel.org
X-Gm-Message-State: AOJu0YxR3jJ2zcj9knV4JVhD7GFcS/IfuUIUa+JaDUMARM4YtXNftYHr
	kDM5nkUIftxjdMdbODEfnhFLXTum6IOcYVNbKc5vpNxqA6Q2XLyhVAcil0b/9LarleMJm0UV8L3
	bY3PfmvefXxXiUZUGQLvcovWrJs8gellaiRDi
X-Google-Smtp-Source: AGHT+IHTw+1l4kal7Bv7qZ7wvC2+kvhvsc/LAHM0Zuw4nFe9XqKPu/1wDnPR1J6Mf9j/jTHeIvYP9hl/h3LgMVKFAVE=
X-Received: by 2002:a05:6214:31a0:b0:6cb:27e6:393f with SMTP id
 6a1803df08f44-6d18587e82bmr157493876d6.36.1730169902229; Mon, 28 Oct 2024
 19:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029021106.25587-1-inwardvessel@gmail.com> <20241029021106.25587-3-inwardvessel@gmail.com>
In-Reply-To: <20241029021106.25587-3-inwardvessel@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 28 Oct 2024 19:44:25 -0700
Message-ID: <CAJD7tkb+Qx+0NCn5BcSv31Hq8TKhSRFfQKQ9BFBE2kNATyswPQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] memcg: add flush tracepoint
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, hannes@cmpxchg.org, akpm@linux-foundation.org, 
	rostedt@goodmis.org, linux-mm@kvack.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 7:11=E2=80=AFPM JP Kobryn <inwardvessel@gmail.com> =
wrote:
>
> This tracepoint gives visibility on how often the flushing of memcg stats
> occurs and contains info on whether it was forced, skipped, and the value=
 of
> stats updated. It can help with understanding how readers are affected by
> having to perform the flush, and the effectiveness of the flush by inspec=
ting
> the number of stats updated. Paired with the recently added tracepoints f=
or
> tracing rstat updates, it can also help show correlation where stats exce=
ed
> thresholds frequently.
>
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  include/trace/events/memcg.h | 25 +++++++++++++++++++++++++
>  mm/memcontrol.c              |  7 ++++++-
>  2 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/include/trace/events/memcg.h b/include/trace/events/memcg.h
> index 8667e57816d2..dfe2f51019b4 100644
> --- a/include/trace/events/memcg.h
> +++ b/include/trace/events/memcg.h
> @@ -74,6 +74,31 @@ DEFINE_EVENT(memcg_rstat_events, count_memcg_events,
>         TP_ARGS(memcg, item, val)
>  );
>
> +TRACE_EVENT(memcg_flush_stats,
> +
> +       TP_PROTO(struct mem_cgroup *memcg, s64 stats_updates,
> +               bool force, bool needs_flush),
> +
> +       TP_ARGS(memcg, stats_updates, force, needs_flush),
> +
> +       TP_STRUCT__entry(
> +               __field(u64, id)
> +               __field(s64, stats_updates)
> +               __field(bool, force)
> +               __field(bool, needs_flush)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->id =3D cgroup_id(memcg->css.cgroup);
> +               __entry->stats_updates =3D stats_updates;
> +               __entry->force =3D force;
> +               __entry->needs_flush =3D needs_flush;
> +       ),
> +
> +       TP_printk("memcg_id=3D%llu stats_updates=3D%lld force=3D%d needs_=
flush=3D%d",
> +               __entry->id, __entry->stats_updates,
> +               __entry->force, __entry->needs_flush)
> +);
>
>  #endif /* _TRACE_MEMCG_H */
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 59f6f247fc13..c3d6163aaa1c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -590,7 +590,12 @@ static inline void memcg_rstat_updated(struct mem_cg=
roup *memcg, int val)
>
>  static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool forc=
e)
>  {
> -       if (!force && !memcg_vmstats_needs_flush(memcg->vmstats))
> +       bool needs_flush =3D memcg_vmstats_needs_flush(memcg->vmstats);
> +
> +       trace_memcg_flush_stats(memcg, atomic64_read(&memcg->vmstats->sta=
ts_updates),
> +               force, needs_flush);
> +
> +       if (!force && !needs_flush)
>                 return;
>
>         if (mem_cgroup_is_root(memcg))
> --
> 2.47.0
>

