Return-Path: <cgroups+bounces-17376-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OsC3Esq0Qmr4/wkAu9opvQ
	(envelope-from <cgroups+bounces-17376-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 20:09:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4C26DDEE9
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 20:09:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TlN5QFQc;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17376-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17376-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1DCB3030D3A
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 18:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D911A370D5F;
	Mon, 29 Jun 2026 18:09:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3302F1FC9
	for <cgroups@vger.kernel.org>; Mon, 29 Jun 2026 18:09:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756551; cv=pass; b=MMWR3ee9KagTcANpjj/vX1QP28oEfGlJmQ/AKEjTOp9/64vcPzgAGApJA+p6WKkP8i45V55jbbY3XWt4BFNnYXMPyx7cwU6iQnS3xos2rEWQY4KNUaXtOkd31IQQxRJfU/Vj7qQxgMLbxg7Qf1l2XBmr3ItucHPA72wEwl0lkdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756551; c=relaxed/simple;
	bh=bLeddgmXqgAYMLvWUbcN5y/JEMVjBDwMlizQCFixcR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZPIwxp7QI8XKlsXQIgtA6WPiA3RgkZ0pfVqj8BvhJZ52TbXgjP/uUXLwTD3CF40l2qbYJO5WjlaJ6vPQ6bsheDDcDQ+0Dlko8sk/YHixv7oSyZfhvguGAuC90rrPk1pm1gh/K87bCzzMXo80wO3wPgt+Wn3n+8a6u6ABypdlNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlN5QFQc; arc=pass smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b5d61302so4699875e9.1
        for <cgroups@vger.kernel.org>; Mon, 29 Jun 2026 11:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782756548; cv=none;
        d=google.com; s=arc-20260327;
        b=Gdi+5NlbnwUSRbUGqPsfCSZTcvgpBjMFGxqNO2VtGpTL/hlAXEGGAP4WmAOzIl0rcI
         TMCwyrY1hvXZq27Vg3QDCrdaHMCHEq6PTmKlJBWDdzyVBK0ETWGx+qKps7be0e2iJwwI
         YkYNXRTlNCjU12/5zv9PwT7WDud4kBAxAtwuz9l6J30dY1JF4omkm6NcB533Fdmeh/NY
         Zl9dMpNABYa6u03hO3CYu3ynsltz/xvThtRjUMRMISwW05tVKS9uT+HHVdov5nWlIHnN
         sw99Qj+1DHXZXsdDNfI5FrBx6m5Eb2x/45284gPw430OuZmJqrQwEzfWD3gCSb2qeIjc
         F+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C5BN39BAWUPL0DXpa9ZBmFsdBxm9Skdfzb7mO2a9Vo8=;
        fh=9+2gNwqK148jUrPfzq7ausARBXoSo6m+QvSNME4kBIs=;
        b=O39iic9zBcV6T21JGDWEGoKTlMizICkCUYt6ZIt0lgUeGEnsFqdvPcB2QM3SVXIsN2
         QsPxibBAC+kZY6G/eWUv5wWbQ2Dy/li1BGVCv+PWGN8bWvjnjaC0ao4xHVXNo8NstRUV
         82vZQL8kPNsxcOB2KjOJ2hr02LY6/1LZisqFil79NBSmoVC98qcFL4Fqi39KvfHgfovy
         UGMNis4HCZQC7lY8cZYMw2pcbmN/rFSWraXU8coVRzoOMgVCLetNOaksOEh9OhmiEUo5
         RW6HOPU5uo/uDQR+4XOBvRoXcmGFpAkKaJY3oSIH3s1FFbKca4AS5OsYdQvyZY8bNuQY
         mIYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782756548; x=1783361348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5BN39BAWUPL0DXpa9ZBmFsdBxm9Skdfzb7mO2a9Vo8=;
        b=TlN5QFQc87Ndc0r50nrVxA2EVbK5pUnXkZ4CnI8voOBI6ID55vKjG9z1j/5Yu2BZPe
         eZ3p/Y3QlQUyzrBnbiyh7CBFcd5U3fsm3AvD5WBC6dG7aWkaZ0HfqiXAvEH7Dd3o3vkC
         xT82+vTGjlv0CG6HAO6vYi/SpdNNE2CK2mbt2jmB1MyLGzAQX8Qk94XgCi84JjMdilr1
         oR5W3Ei0UP+J14BrRQh/pep9LidGIEyrf4bhUDKSEBC8sCM5fY7lQxcrr03s89yvI7xB
         JOdb5sS/kGgasuRLLAgvzZBZGVKmwQifz3+4jZJgat5OUe5j5ySD8BnFmP2IncU5LIqf
         Ymrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782756548; x=1783361348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C5BN39BAWUPL0DXpa9ZBmFsdBxm9Skdfzb7mO2a9Vo8=;
        b=A2Yq+DpPE/e9f3+gW0m/6CT00sxRL3t2Nz1JH6K9pdzFy9vPNz35F89LWBTGavFC1d
         Lpdrou0A25tiHWBOXUzyjswkWc4nwCQBvzYEGvXkWz9zxKKuZEiwcm5fXq4VswaLYCBe
         oxu0e/SuZtE5+NxBtEEg9qfa4gdku/TSQYwW2bR4Jz2ueRyBN6e24ax/LXL/WJgyIgfw
         99uAUulOlxo0Bu8J+FEnLmP1xsBQjgiIHxT8gwnmzz7psCWvU+cjc700evCq1rIXHGt+
         hutZFqUpmcYIJka+suEt9/HWmQNbbbjn2qfDFk+sk0qeSAx+KFLpfoligXDL2GpiJmu0
         Bbuw==
X-Forwarded-Encrypted: i=1; AFNElJ+h37nUBzDeycRN6LUzomXofcVDtUyOHhOszOvDe0IIdmRXgDUQXINjr1s6ksKZD6mqVpjzr9Kp@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkt5WY5vbZG61f8w1fFiZmIBpiQInqV3tNrusmrvxaWyiYipIn
	PSIQpV/2EstVrj3p/LLEIRyJwSAWwhzNIsP/lnEC9W7uqMPgG8JVj2ueT87YlIhRl0RKASx8J/e
	InEnU2DKpzo98l3rrtsb8hLHII+kMKXk=
X-Gm-Gg: AfdE7ckV1TrbqtPh/GvLfzrd3UOPYolYswB3klnvxZDrGr2kOM5fS8J8bLr+aIsCvej
	ASalMhAoQdRPMR1ChbITCj9gmAIV+SyREROwiKYR9xPovURPuxs+DGLjbq1qtXWwr0V5Yy1koON
	RmIx9Rney3tMUx2HJj2tkUKnSsalt0vaHfuIExZt4FdY2jOzw5NBQvxnmKIINh5vvWE+9/GOVqq
	9D1wCzYEG0h97qy8J4xvR1wGqxC0U2+m/i2ej6MLC41nJEcLSxlx9EAqZZ7Y7WYLIVePVM+aaps
	zJkfseLBflsyWbRbr51644PumdCWCMPrqdbtzdw=
X-Received: by 2002:a05:600c:524e:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-493b8ce540fmr3942665e9.16.1782756548138; Mon, 29 Jun 2026
 11:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626102358.1603618-10-alex@ghiti.fr> <20260626143244.3382853-1-usama.arif@linux.dev>
 <CAKEwX=OKsjtStcuvhQ3WCGYoTJHT6eagBq1mZqX+DdbLm_BFLQ@mail.gmail.com> <044c3a58-7ed0-46f2-88ca-462691fd0b68@ghiti.fr>
In-Reply-To: <044c3a58-7ed0-46f2-88ca-462691fd0b68@ghiti.fr>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 29 Jun 2026 11:08:56 -0700
X-Gm-Features: AVVi8CcoJQQWpbkl9ynpS5plxoh7g9PlfXUI4G-QNEz9RykW8_jECswu4D7_5Z0
Message-ID: <CAKEwX=NU5W_NzXjEjzty2dHm09xZwLH=7SS1f9J5b8PHV2oZsg@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] mm: zswap: per-node kmem accounting for zswap/zsmalloc
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Usama Arif <usama.arif@linux.dev>, alexandre@ghiti.fr, 
	Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>, 
	Ben Segall <bsegall@google.com>, cgroups@vger.kernel.org, 
	Chengming Zhou <chengming.zhou@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Hildenbrand <david@kernel.org>, Dennis Zhou <dennis@kernel.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Kairui Song <kasong@tencent.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, "Liam R. Howlett" <liam@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Lorenzo Stoakes <ljs@kernel.org>, Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Qi Zheng <qi.zheng@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Wei Xu <weixugc@google.com>, Yosry Ahmed <yosry@kernel.org>, 
	Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:alex@ghiti.fr,m:usama.arif@linux.dev,m:alexandre@ghiti.fr,m:akpm@linux-foundation.org,m:baohua@kernel.org,m:bsegall@google.com,m:cgroups@vger.kernel.org,m:chengming.zhou@linux.dev,m:cl@gentwo.org,m:david@kernel.org,m:dennis@kernel.org,m:dietmar.eggemann@arm.com,m:mingo@redhat.com,m:hannes@cmpxchg.org,m:juri.lelli@redhat.com,m:kasong@tencent.com,m:kent.overstreet@linux.dev,m:kprateek.nayak@amd.com,m:liam@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:ljs@kernel.org,m:mgorman@suse.de,m:mhocko@kernel.org,m:rppt@kernel.org,m:minchan@kernel.org,m:muchun.song@linux.dev,m:peterz@infradead.org,m:qi.zheng@linux.dev,m:roman.gushchin@linux.dev,m:senozhatsky@chromium.org,m:shakeel.butt@linux.dev,m:rostedt@goodmis.org,m:surenb@google.com,m:tj@kernel.org,m:vschneid@redhat.com,m:vincent.guittot@linaro.org,m:vbabka@kernel.org,m:weixugc@google.com,m:yosry@kernel.org,m:yuanchu@google.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[41];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17376-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,linux.dev:email,vger.kernel.org:from_smtp,ghiti.fr:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C4C26DDEE9

On Mon, Jun 29, 2026 at 6:38=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> Hi Nhat,
>
> On 6/26/26 20:36, Nhat Pham wrote:
> > On Fri, Jun 26, 2026 at 7:32=E2=80=AFAM Usama Arif <usama.arif@linux.de=
v> wrote:
> >> On Fri, 26 Jun 2026 12:20:58 +0200 Alexandre Ghiti <alex@ghiti.fr> wro=
te:
> >>
> >>> Update zswap and zsmalloc to use per-node obj_cgroup for kmem
> >>> accounting, attributing compressed page charges to the correct
> >>> NUMA node.
> >>>
> >>> But actually, this is incomplete because it does not correctly accoun=
t
> >>> for entries that straddle pages, those pages being possibly on 2 diff=
erent
> >>> nodes.
> >>>
> >>> This will be correctly handled by Joshua in a different series [1].
> >>>
> >>> Link: https://lore.kernel.org/linux-mm/20260311195153.4013476-1-joshu=
a.hahnjy@gmail.com/ [1]
> >>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> >>> ---
> >>>   include/linux/zsmalloc.h |  2 ++
> >>>   mm/zsmalloc.c            | 11 +++++++++++
> >>>   mm/zswap.c               | 19 ++++++++++++++++++-
> >>>   3 files changed, 31 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
> >>> index 478410c880b1..30427f3fe232 100644
> >>> --- a/include/linux/zsmalloc.h
> >>> +++ b/include/linux/zsmalloc.h
> >>> @@ -50,6 +50,8 @@ void zs_obj_read_sg_end(struct zs_pool *pool, unsig=
ned long handle);
> >>>   void zs_obj_write(struct zs_pool *pool, unsigned long handle,
> >>>                  void *handle_mem, size_t mem_len);
> >>>
> >>> +int zs_handle_to_nid(struct zs_pool *pool, unsigned long handle);
> >>> +
> >>>   extern const struct movable_operations zsmalloc_mops;
> >>>
> >>>   #endif
> >>> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> >>> index 83f5820c45f9..17f7403ebe77 100644
> >>> --- a/mm/zsmalloc.c
> >>> +++ b/mm/zsmalloc.c
> >>> @@ -1380,6 +1380,17 @@ static void obj_free(int class_size, unsigned =
long obj)
> >>>        mod_zspage_inuse(zspage, -1);
> >>>   }
> >>>
> >>> +int zs_handle_to_nid(struct zs_pool *pool, unsigned long handle)
> >>> +{
> >>> +     unsigned long obj;
> >>> +     struct zpdesc *zpdesc;
> >>> +
> >>> +     obj =3D handle_to_obj(handle);
> >>> +     obj_to_zpdesc(obj, &zpdesc);
> >>> +     return page_to_nid(zpdesc_page(zpdesc));
> >>> +}
> >>> +EXPORT_SYMBOL(zs_handle_to_nid);
> >> Does this need the same locking as the other handle-to-zspage paths?
> >> zs_free() takes pool->lock before handle_to_obj() because zspage migra=
tion can
> >> update or move the object behind the handle. This helper does the same=
 decode
> >> without the lock, so zswap's uncharge path can race migration and char=
ge or
> >> uncharge the wrong node, or observe transient zspage state.
> >>
> > Can we just charge it to the page's node for now? Once Joshua's patch
> > series is in, we can correctly charge the node owning the data :)
>
>
> Even if this patch accounting is incorrect, it is close to reality,
> using the original page's node would give results that are really off no?

The current policy is same-node-first, i.e we prefer the same node as
the original page for the compressed data too:

https://github.com/torvalds/linux/commit/56e5a103a721d0ef139bba7ff3d3ada6c8=
217d5b

So the accuracy of this guesstimation depends on how much fallback we
had to do...

>
>
> >
> > FWIW, this is how these zswap entries are organized in the LRU too -
> > following to the OG page's node.
>
>
> Oh, we should do something about that right? Because the compressed data
> is not necessarily on the original page's node.

At initial placement? Yes, it's fixable.

But the bigger problem is on migration of a zsmalloc object. That
requires moving zswap entry from one lru list to another :) I'm not
sure what synchronization method is safe here - at minimum we need to
take the LRU locks, but what about incoming writeback, zswap load,
etc.?

>
> Thanks,
>
> Alex
>

