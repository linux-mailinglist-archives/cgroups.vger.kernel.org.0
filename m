Return-Path: <cgroups+bounces-5666-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC70E9D67DC
	for <lists+cgroups@lfdr.de>; Sat, 23 Nov 2024 07:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69CC281ACD
	for <lists+cgroups@lfdr.de>; Sat, 23 Nov 2024 06:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D7D165EE8;
	Sat, 23 Nov 2024 06:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J7W9H0gX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C97481C4
	for <cgroups@vger.kernel.org>; Sat, 23 Nov 2024 06:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732344453; cv=none; b=CMxrm0ov3QUhT0UBECmL1OV7vCv4jIsekYAOUbyGye+oVq5XhL79X+ezHquFQuUZ+faESKmjYOD9lxKcuA7ZrVCKnbzZRZhUa4VMS5DxvoQ7mNZpuz0+IcFNFU2Dq3x40gdbm24iu0LBKzy0pi9CK3TGIMp5HH0ed2ls3wrZXf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732344453; c=relaxed/simple;
	bh=YVACDs1RtLKGWVhnz3UkHS1/ASXsfVYyPBlgFQOfk1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AEpmQ0FczUfYHLLnYuv2Tf9c63MFhaYvx6iOj5gaZIBOMQW3BlkxUET6g70El7rse4UgAhyOXFpN2dK8AUzlobNOKB69iDGTV1kTKVNO5bPcQJBcjOrazml/uZU6CwB6Tk+xOUzAvQFP0af9rPDyx6F2po62xPwr3cVEt61WpSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J7W9H0gX; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d40263adbaso19931346d6.0
        for <cgroups@vger.kernel.org>; Fri, 22 Nov 2024 22:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732344451; x=1732949251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymgflkDUVyug1wPOQFiRQ2YqU/Q7TymF7PGNQguc3+A=;
        b=J7W9H0gXc6p/sVL6ara+6/g1UEdGRRHDLJBYwIbyzzUs7YLTniANK9Vugk6i8LPxTo
         tv4PLglnGDNZF6MZy4iHAJaZbEWlimd7BgJv3F39wMfbK6ypS/EVnDBrjj56W76/6vjr
         QIcCt+nppa+53E9pQXFKweFSwoD50jUzxn3vmAWmy4cQ3Zd5qYywwoi/CC4U12kiLf43
         meBJkrwpvkN3j+jmpFTeiv+WCfZ2eSyc0KuFwm2Q6VM94/r742S65WKN8oY+IlIJXKFD
         IiyNKhryBC9LVY62N3Dh590XiWwmAo9CKs+wGiJ7gh07GcKvi2wg/59LW6q2tgSHV1zz
         mKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732344451; x=1732949251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymgflkDUVyug1wPOQFiRQ2YqU/Q7TymF7PGNQguc3+A=;
        b=adjPUGtI0h24BlDsLgE3MdOIIi6aXwQPKyIV9qjKLU5/IyuC5t5CK6hL2nIQMLqEvT
         XugKtODOI4RJtUv3gBXnX9RiF//pcQqHBX7GYQ59LWzu5fnjbIHvCuIcMpPj+szJJkWs
         Et0WfRD2RQpi+6oJEdPnPL2AbUIf0X56ByTcjQ6UZLc+RDL7SorqDLyGJ1heDeln9Ubr
         t4m/0GekRSARfBdF391A1Qby63Lo4SBAF9GRPVE0SvQRnUDg2Dw8LP2Ci3cbZdYLskBO
         rTkkQJUVxCS1gB2OSKQ836ol4I5IERtOC0T75zwcI/hN3ULIGCOO1cRWjPTp3BMCsWJS
         i5PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAKFf4KNTWFBh/U6neTg0tB2xVMOmfnfcg8zGrFx2aRMW8ceVCYJZSZDpfENJDgIzVuSncXxwD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5tntVVBOyua85dWf+NR1hjMw9a8KAe93Y/TaDMZY+7ixrpQVl
	2Xo0FfUimEiG6n9paBHYm06SN+ajevmk9mipQ5pm6HboGXctFAXKK3WlY/JS6oW51lzFl5WJiBL
	miEwk5GThd0lX+kkA6lH59mlkmDPcXUiIk65A
X-Gm-Gg: ASbGnct/OYYTo/HlJydKto4S0/k3L1ut4QuniDvyKIz16Z/EeRgu3n2vTMsyGaQOrzQ
	zAxB8Staed3HjC8ZxbSxP7ePbpRvL
X-Google-Smtp-Source: AGHT+IEkDB9TYGxxMJwZU3/JVtCFBD87cfOIXWCVX3m/odh7EtLSO0xYG3/4XTBX7kGJq+bQhEf7xk72q9otkdJWVxs=
X-Received: by 2002:a05:6214:410:b0:6d4:1bad:7405 with SMTP id
 6a1803df08f44-6d450e6a990mr87224516d6.3.1732344450249; Fri, 22 Nov 2024
 22:47:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123060939.169978-1-shakeel.butt@linux.dev>
In-Reply-To: <20241123060939.169978-1-shakeel.butt@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 22 Nov 2024 22:46:53 -0800
Message-ID: <CAJD7tkYAch4TpO0JSpjmg6k3VVw-0x_acf2P2JBveaD3mXPxgA@mail.gmail.com>
Subject: Re: [PATCH] mm: mmap_lock: optimize mmap_lock tracepoints
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	Axel Rasmussen <axelrasmussen@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 10:10=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> We are starting to deploy mmap_lock tracepoint monitoring across our
> fleet and the early results showed that these tracepoints are consuming
> significant amount of CPUs in kernfs_path_from_node when enabled.
>
> It seems like the kernel is trying to resolved the cgroup path in the

s/resolved/resolve

> fast path of the locking code path when the tracepoints are enabled. In
> addition for some application their metrics are regressing when
> monitoring is enabled.
>
> The cgroup path resolution can be slow and should not be done in the
> fast path. Most userspace tools, like bpftrace, provides functionality
> to get the cgroup path from cgroup id, so let's just trace the cgroup
> id and the users can use better tools to get the path in the slow path.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  include/linux/memcontrol.h       | 18 ++++++++++++
>  include/trace/events/mmap_lock.h | 32 ++++++++++----------
>  mm/mmap_lock.c                   | 50 ++------------------------------
>  3 files changed, 36 insertions(+), 64 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 5502aa8e138e..d82f08cd70cd 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1046,6 +1046,19 @@ static inline void memcg_memory_event_mm(struct mm=
_struct *mm,
>
>  void split_page_memcg(struct page *head, int old_order, int new_order);
>
> +static inline u64 memcg_id_from_mm(struct mm_struct *mm)

The usage of memcg_id here and throughout the patch is a bit confusing
because we have a member called 'id' in struct mem_cgroup, but this
isn't it. This is the cgroup_id of the memcg. I admit it's hard to
distinguish them during naming, but when I first saw the function I
thought it was returning memcg->id.

Maybe just cgroup_id_from_mm()? In cgroup v2, the cgroup id is the
same regardless of the controller anyway, in cgroup v1, it's kinda
natural that we return the cgroup id of the memcg.

I don't feel strongly, but I prefer that we use clearer naming, and
either way a comment may help clarify things.

> +{
> +       struct mem_cgroup *memcg;
> +       u64 id =3D 0;
> +
> +       rcu_read_lock();
> +       memcg =3D mem_cgroup_from_task(rcu_dereference(mm->owner));
> +       if (likely(memcg))
> +               id =3D cgroup_id(memcg->css.cgroup);

We return 0 if the memcg is NULL here, shouldn't we return the cgroup
id of the root memcg instead? This is more consistent with
get_mem_cgroup_from_mm(), and makes sure we always return the id of a
valid cgroup.

> +       rcu_read_unlock();
> +       return id;
> +}
> +
>  #else /* CONFIG_MEMCG */
>
>  #define MEM_CGROUP_ID_SHIFT    0
> @@ -1466,6 +1479,11 @@ void count_memcg_event_mm(struct mm_struct *mm, en=
um vm_event_item idx)
>  static inline void split_page_memcg(struct page *head, int old_order, in=
t new_order)
>  {
>  }
> +
> +static inline u64 memcg_id_from_mm(struct mm_struct *mm)
> +{
> +       return 0;
> +}
>  #endif /* CONFIG_MEMCG */
>
>  /*
> diff --git a/include/trace/events/mmap_lock.h b/include/trace/events/mmap=
_lock.h
> index bc2e3ad787b3..5529933d19c5 100644
> --- a/include/trace/events/mmap_lock.h
> +++ b/include/trace/events/mmap_lock.h
> @@ -5,6 +5,7 @@
>  #if !defined(_TRACE_MMAP_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
>  #define _TRACE_MMAP_LOCK_H
>
> +#include <linux/memcontrol.h>
>  #include <linux/tracepoint.h>
>  #include <linux/types.h>
>
> @@ -12,64 +13,61 @@ struct mm_struct;
>
>  DECLARE_EVENT_CLASS(mmap_lock,
>
> -       TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write=
),
> +       TP_PROTO(struct mm_struct *mm, bool write),
>
> -       TP_ARGS(mm, memcg_path, write),
> +       TP_ARGS(mm, write),
>
>         TP_STRUCT__entry(
>                 __field(struct mm_struct *, mm)
> -               __string(memcg_path, memcg_path)
> +               __field(u64, memcg_id)
>                 __field(bool, write)
>         ),
>
>         TP_fast_assign(
>                 __entry->mm =3D mm;
> -               __assign_str(memcg_path);
> +               __entry->memcg_id =3D memcg_id_from_mm(mm);
>                 __entry->write =3D write;
>         ),
>
>         TP_printk(
> -               "mm=3D%p memcg_path=3D%s write=3D%s",
> -               __entry->mm,
> -               __get_str(memcg_path),
> +               "mm=3D%p memcg_id=3D%llu write=3D%s",
> +               __entry->mm, __entry->memcg_id,
>                 __entry->write ? "true" : "false"
>         )
>  );
>
>  #define DEFINE_MMAP_LOCK_EVENT(name)                                    =
\
>         DEFINE_EVENT(mmap_lock, name,                                   \
> -               TP_PROTO(struct mm_struct *mm, const char *memcg_path,  \
> -                       bool write),                                    \
> -               TP_ARGS(mm, memcg_path, write))
> +               TP_PROTO(struct mm_struct *mm, bool write),             \
> +               TP_ARGS(mm, write))
>
>  DEFINE_MMAP_LOCK_EVENT(mmap_lock_start_locking);
>  DEFINE_MMAP_LOCK_EVENT(mmap_lock_released);
>
>  TRACE_EVENT(mmap_lock_acquire_returned,
>
> -       TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write=
,
> -               bool success),
> +       TP_PROTO(struct mm_struct *mm, bool write, bool success),
>
> -       TP_ARGS(mm, memcg_path, write, success),
> +       TP_ARGS(mm, write, success),
>
>         TP_STRUCT__entry(
>                 __field(struct mm_struct *, mm)
> -               __string(memcg_path, memcg_path)
> +               __field(u64, memcg_id)
>                 __field(bool, write)
>                 __field(bool, success)
>         ),
>
>         TP_fast_assign(
>                 __entry->mm =3D mm;
> -               __assign_str(memcg_path);
> +               __entry->memcg_id =3D memcg_id_from_mm(mm);
>                 __entry->write =3D write;
>                 __entry->success =3D success;
>         ),
>
>         TP_printk(
> -               "mm=3D%p memcg_path=3D%s write=3D%s success=3D%s",
> +               "mm=3D%p memcg_id=3D%llu write=3D%s success=3D%s",
>                 __entry->mm,
> -               __get_str(memcg_path),
> +               __entry->memcg_id,
>                 __entry->write ? "true" : "false",
>                 __entry->success ? "true" : "false"
>         )
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index f186d57df2c6..e7dbaf96aa17 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -17,51 +17,7 @@ EXPORT_TRACEPOINT_SYMBOL(mmap_lock_start_locking);
>  EXPORT_TRACEPOINT_SYMBOL(mmap_lock_acquire_returned);
>  EXPORT_TRACEPOINT_SYMBOL(mmap_lock_released);
>
> -#ifdef CONFIG_MEMCG
> -
> -/*
> - * Size of the buffer for memcg path names. Ignoring stack trace support=
,
> - * trace_events_hist.c uses MAX_FILTER_STR_VAL for this, so we also use =
it.
> - */
> -#define MEMCG_PATH_BUF_SIZE MAX_FILTER_STR_VAL
> -
> -#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                           \
> -       do {                                                            \
> -               if (trace_mmap_lock_##type##_enabled()) {               \
> -                       char buf[MEMCG_PATH_BUF_SIZE];                  \
> -                       get_mm_memcg_path(mm, buf, sizeof(buf));        \
> -                       trace_mmap_lock_##type(mm, buf, ##__VA_ARGS__); \
> -               }                                                       \
> -       } while (0)
> -
> -#else /* !CONFIG_MEMCG */
> -
> -#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                            =
       \
> -       trace_mmap_lock_##type(mm, "", ##__VA_ARGS__)
> -
> -#endif /* CONFIG_MEMCG */
> -
>  #ifdef CONFIG_TRACING
> -#ifdef CONFIG_MEMCG
> -/*
> - * Write the given mm_struct's memcg path to a buffer. If the path canno=
t be
> - * determined, empty string is written.
> - */
> -static void get_mm_memcg_path(struct mm_struct *mm, char *buf, size_t bu=
flen)
> -{
> -       struct mem_cgroup *memcg;
> -
> -       buf[0] =3D '\0';
> -       memcg =3D get_mem_cgroup_from_mm(mm);
> -       if (memcg =3D=3D NULL)
> -               return;
> -       if (memcg->css.cgroup)
> -               cgroup_path(memcg->css.cgroup, buf, buflen);
> -       css_put(&memcg->css);
> -}
> -
> -#endif /* CONFIG_MEMCG */
> -
>  /*
>   * Trace calls must be in a separate file, as otherwise there's a circul=
ar
>   * dependency between linux/mmap_lock.h and trace/events/mmap_lock.h.
> @@ -69,20 +25,20 @@ static void get_mm_memcg_path(struct mm_struct *mm, c=
har *buf, size_t buflen)
>
>  void __mmap_lock_do_trace_start_locking(struct mm_struct *mm, bool write=
)
>  {
> -       TRACE_MMAP_LOCK_EVENT(start_locking, mm, write);
> +       trace_mmap_lock_start_locking(mm, write);
>  }
>  EXPORT_SYMBOL(__mmap_lock_do_trace_start_locking);
>
>  void __mmap_lock_do_trace_acquire_returned(struct mm_struct *mm, bool wr=
ite,
>                                            bool success)
>  {
> -       TRACE_MMAP_LOCK_EVENT(acquire_returned, mm, write, success);
> +       trace_mmap_lock_acquire_returned(mm, write, success);
>  }
>  EXPORT_SYMBOL(__mmap_lock_do_trace_acquire_returned);
>
>  void __mmap_lock_do_trace_released(struct mm_struct *mm, bool write)
>  {
> -       TRACE_MMAP_LOCK_EVENT(released, mm, write);
> +       trace_mmap_lock_released(mm, write);
>  }
>  EXPORT_SYMBOL(__mmap_lock_do_trace_released);
>  #endif /* CONFIG_TRACING */
> --
> 2.43.5
>
>

