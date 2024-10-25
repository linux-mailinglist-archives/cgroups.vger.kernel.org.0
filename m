Return-Path: <cgroups+bounces-5269-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED909B0C35
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 19:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A3F1C21D79
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 17:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E7520BB29;
	Fri, 25 Oct 2024 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mC3Ndhkb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040A620264D
	for <cgroups@vger.kernel.org>; Fri, 25 Oct 2024 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878859; cv=none; b=bRDGmwWR2XoDqD108zSD28mLW+rqkpDRqBB87uAPrcGaw3F4Fgdk3Wvqlixhai+QjhqaIl50k+z4vo6TUIPAT/Vbeg8bgattQmUNrqSkXhaU/+CDaO6nfYvsSD18lNvTReyYjZLEUMx9phd1o89rMFT2ordDYYTYE2PlDkS0rL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878859; c=relaxed/simple;
	bh=UB6uQYVr357KlU1yaKbSTfdrnH8GB1kL1brpApqQur0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVZr6f/q/QprKqY7KK7qdq2AFqUTrwz3/qKAvupE3mdWjbbxGAtm3iUxOisUiYXHR3k1RTlWHumTCrFBQUNdvANUXiTi3WJ6YtkDqV+M1i1c0uO5GgR33yjeP43MD07A+X9i+P8/ltqZXU7odzU3EopHxunueq1byrgNXRvyAkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mC3Ndhkb; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c9634c9160so2559676a12.2
        for <cgroups@vger.kernel.org>; Fri, 25 Oct 2024 10:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729878855; x=1730483655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLhL761LORBHkdChYyd01T9RJGPpx3zgweo3IcacCF8=;
        b=mC3NdhkbbYj+QXI0TsjrB3qzilyBTgklMV07vpF84OkjAxgQonklAmYz8TsHpblCyX
         VTZTpENdu585qdklgq+rVnB8sGg5GT5XKJsfbR3tZmpqUKAj4R6nvDcgr5R4O6x0qCcc
         Jqmdub82gkI08xjBqh6yA8ve+8qt4d1VZ2t2Tsqx4fQovsOHtZCyUX8rSKN9ceTY0fLe
         vLXZQRqIEZPwQPkDj3kaQBpnLRUvPTAj172BTdc0AJkipNdhOo8Pafw7cnR+haA8zFn0
         f02cYwvWLnhabCGzaAZrzkr6dBiv/gt18WXZslA1v5Je9xTP6Kv93j1g+bx+vUb7BxcR
         Epeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729878855; x=1730483655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLhL761LORBHkdChYyd01T9RJGPpx3zgweo3IcacCF8=;
        b=UpG+IfWEQLaUeyJUY6rTqL93yGPufwzt3b/S8MKyLTRimZ7grkAS0D9a/gFm3b1jQc
         wwT2i4U5qjufAcMNL9U0lFWiSXuJQ3LNFDMKp4sNX2kSf3agreLNEtHsag2h3eUoQ6/T
         4wGR2CGxVPn1EI0B1x2qpQdnQ46TTpnGlS/00ja9meEvpIn9SfH965BHR8FvSck4EYGj
         HienbI/FUZzIjsaqZl/zn1FmAJPjPGUE6UdMoXeepMK+htK18fp40A6WQoIulRI4qsHu
         InwLX2qURuND2BI8zJDUqTpS69hnlyD6Zv6JjGKf/YgGRgwgZFozn26dR4s7TXhOuTpV
         NolA==
X-Forwarded-Encrypted: i=1; AJvYcCWsfn2aVY0ytFILO/ZByEEmsjqaiyH7wdOst7pcC2wubsZbP8YWfGQH0rBHylvFGYSwAFiBjkML@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5+PDLjWYhPDd7d5WDSIp3VhGBmTbRg8S+CJcMpahofxZl683s
	Ibmx2beuS/Az4COyGdE+zcL3q6x38saXDM9TyFmoGTbcn6mVrU51uchw8CUdFmFcjS2ahMvyKZR
	TeV8wKZqK4Fh17b6+3la5gemEJsN+9jy4BEC5
X-Google-Smtp-Source: AGHT+IHkJAJuOX/pyLg2QsbuOF3P/GYnzGXE2uzjMFMMhmPjkp/NkPYtGL3AMxaX2lKRotQBlGoxbStk9EkimPSCZ54=
X-Received: by 2002:a17:907:9617:b0:a99:43e5:ac37 with SMTP id
 a640c23a62f3a-a9ad273744bmr519527566b.15.1729878854963; Fri, 25 Oct 2024
 10:54:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025002511.129899-1-inwardvessel@gmail.com>
 <20241025002511.129899-3-inwardvessel@gmail.com> <CAJD7tkZaMH04mBK649iHRhdTwRJh8teSOcc1mg=y8fRey2zHzA@mail.gmail.com>
 <gujcp2vtzatyn73xmidsca25d24kmbtwa6cr52mjlsrxvm7cdf@vbgax2a67pwz>
 <CAJD7tkZyttpQk7AYftikVtA6O7w2Wmo9Eu_EwEsusOtNKFnSQA@mail.gmail.com> <3da0f38a-51f1-43fa-a625-6bb1fe992920@gmail.com>
In-Reply-To: <3da0f38a-51f1-43fa-a625-6bb1fe992920@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 25 Oct 2024 10:53:39 -0700
Message-ID: <CAJD7tkZ=YB66T4-j-qKxzYktiKqmfufg_eTjHo_6W7eQjqSXmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] memcg: use memcg flush tracepoint
To: JP Kobryn <inwardvessel@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, hannes@cmpxchg.org, akpm@linux-foundation.org, 
	rostedt@goodmis.org, linux-mm@kvack.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 10:05=E2=80=AFAM JP Kobryn <inwardvessel@gmail.com>=
 wrote:
>
>
> On 10/25/24 12:40 AM, Yosry Ahmed wrote:
> > On Thu, Oct 24, 2024 at 6:16=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> >> On Thu, Oct 24, 2024 at 05:57:25PM GMT, Yosry Ahmed wrote:
> >>> On Thu, Oct 24, 2024 at 5:26=E2=80=AFPM JP Kobryn <inwardvessel@gmail=
.com> wrote:
> >>>> Make use of the flush tracepoint within memcontrol.
> >>>>
> >>>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> >>> Is the intention to use tools like bpftrace to analyze where we flush
> >>> the most? In this case, why can't we just attach to the fentry of
> >>> do_flush_stats() and use the stack trace to find the path?
> >>>
> >>> We can also attach to mem_cgroup_flush_stats(), and the difference in
> >>> counts between the two will be the number of skipped flushes.
> >>>
> >> All these functions can get inlined and then we can not really attach
> >> easily. We can somehow find the offset in the inlined places and try t=
o
> >> use kprobe but it is prohibitive when have to do for multiple kernels
> >> built with fdo/bolt.
> >>
> >> Please note that tracepoints are not really API, so we can remove them
> >> in future if we see no usage for them.
> > That's fair, but can we just add two tracepoints? This seems enough to
> > collect necessary data, and prevent proliferation of tracepoints and
> > the addition of the enum.
> >
> > I am thinking one in mem_cgroup_flush_stats() and one in
> > do_flush_stats(), e.g. trace_mem_cgroup_flush_stats() and
> > trace_do_flush_stats(). Although the name of the latter is too
> > generic, maybe we should rename the function first to add mem_cgroup_*
> > or memcg_*.
> >
> > WDYT?
>
> Hmmm, I think if we did that we wouldn't get accurate info on when the
> flush was skipped. Comparing the number of hits between
> mem_cgroup_flush_stats() and do_flush_stats() to determine the number of
> skips doesn't seem reliable because of the places where do_flush_stats()
> is called outside of mem_cgroup_flush_stats(). There would be situations
> where a skip occurs, but meanwhile each call to do_flush_stats() outside
> of mem_cgroup_flush_stats() would effectively subtract that skip, making
> it appear that a skip did not occur.

You're underestimating the power of BPF, my friend :) We can count the
number of flushes in task local storages, in which case we can get a
very accurate representation because the counters are per-task, so we
know exactly when we skipped, but..

>
> Maybe as a middle ground we could remove the trace calls for the zswap
> and periodic cases, since no skips can occur there. We could then just
> leave one trace call in mem_cgroup_flush_stats() and instead of an enum
> we can pass a bool saying skipped or not. Something like this:
>
> mem_cgroup_flush_stats()
>
> {
>
>      bool needs_flush =3D memcg_vmstats_needs_flush(...);
>
>      trace_memcg_flush_stats(memcg, needs_flush);
>
>      if (needs_flush)
>
>          do_flush_stats(...);
>
> }
>
>
> Yosry/Shakeel, do you have any thoughts on whether we should keep the
> trace calls for obj_cgroup_may_zswap() and periodic workqueue cases?

..with that being said, I do like having a single tracepoint. I think
with some refactoring we can end up with a single tracepoint and more
data. We can even capture the cases where we force a flush but we
don't really need to flush. We can even add vmstats->stats_updates to
the tracepoint to know exactly how many updates we have when we flush.

What about the following:

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7845c64a2c570..be0e7f52ad11a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -584,8 +584,14 @@ static inline void memcg_rstat_updated(struct
mem_cgroup *memcg, int val)
        }
 }

-static void do_flush_stats(struct mem_cgroup *memcg)
+static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
 {
+       bool needs_flush =3D memcg_vmstats_needs_flush(memcg->vmstats);
+
+       trace_memcg_flush_stats(memcg, needs_flush, force, ...);
+       if (!force && !needs_flush)
+               return;
+
        if (mem_cgroup_is_root(memcg))
                WRITE_ONCE(flush_last_time, jiffies_64);

@@ -609,8 +615,7 @@ void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
        if (!memcg)
                memcg =3D root_mem_cgroup;

-       if (memcg_vmstats_needs_flush(memcg->vmstats))
-               do_flush_stats(memcg);
+       __mem_cgroup_flush_stats(memcg, false);
 }

 void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
@@ -626,7 +631,7 @@ static void flush_memcg_stats_dwork(struct work_struct =
*w)
         * Deliberately ignore memcg_vmstats_needs_flush() here so that flu=
shing
         * in latency-sensitive paths is as cheap as possible.
         */
-       do_flush_stats(root_mem_cgroup);
+       __mem_cgroup_flush_stats(root_mem_cgroup, true);
        queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIM=
E);
 }

@@ -5272,11 +5277,8 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
                        break;
                }

-               /*
-                * mem_cgroup_flush_stats() ignores small changes. Use
-                * do_flush_stats() directly to get accurate stats for char=
ging.
-                */
-               do_flush_stats(memcg);
+               /* Force a flush to get accurate stats for charging */
+               __mem_cgroup_flush_stats(memcg, true);
                pages =3D memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZ=
E;
                if (pages < max)
                        continue;

