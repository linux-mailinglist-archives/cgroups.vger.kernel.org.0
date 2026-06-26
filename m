Return-Path: <cgroups+bounces-17342-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DcxEJf3GPmo5LgkAu9opvQ
	(envelope-from <cgroups+bounces-17342-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 20:37:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BB06CFB7A
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 20:37:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XsgvWSZL;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17342-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17342-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5C033027B4E
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 18:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08243B841D;
	Fri, 26 Jun 2026 18:37:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA8D3B8405
	for <cgroups@vger.kernel.org>; Fri, 26 Jun 2026 18:37:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499026; cv=pass; b=RBL/1SJ9BDr8sC6eFDIHeAkZjKBsoBrAlsOccp5EyPo4lIvhQVKzbEVkiOl6UlEBMGO1snc7mBVn0NB7BnxBGRIHNLWgsMjPfMkWrAWVvBgGXd9EbOALQM9zcc4WWFgkfFliFCcTZLkc4JM7A5O6K07n5iJShWhpOgndm0OXwG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499026; c=relaxed/simple;
	bh=OfOa8rqqXCKRNRLH/nmiHKh0iPBKtZJR4R6D2Wg9rRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQzrpbPoV15vfuPu1J+5+lnHYHsdImovxzisFtVP6fNJD6EofdeiWjwuxbTXjfbysQwZiCnsvbQG9jfR+4QTl2HmVY5JccnC5a99KnBMs+5U8ci4Mfs/8IT3LgWhyY68GzdtgNfP1/PP/heIxVpHc0tPQ3Nr3GKwLwFpDZTZqFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsgvWSZL; arc=pass smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso16707805e9.2
        for <cgroups@vger.kernel.org>; Fri, 26 Jun 2026 11:37:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782499022; cv=none;
        d=google.com; s=arc-20260327;
        b=pWq4vTHMdGP2nM4xG1ozpICeuiewLXfMbWJuLFPYqyTAg1K2GgdRLwm03u7DDLw3lo
         FEHoHblrzKDFICHiSLf/1H7kPVKTzJFNx3P4CPvqrh6+6EBa3QjAmuuWf8298Rfh144o
         V6eI+TPdu+omik/pUqcOW72yVeS0BTH7o/iSRUJZYN51lYVj4C+4Hup99AL+Q+JnwklA
         ehcZehwZMNN23rqKTTVdzrL5W2lSkOCHwaxdxF1XboFFQnaV3d/xEPFuUdjWR0flzcs3
         U954q/1g32gWaxkIA9NSV1vt/iOVoot6IYdwt6DUfn+wdKxzya2Ws5HpcMeVM0FrvV6R
         UCTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HOOeJEgGJirHLvCIZDna3WzBVXhg0OXljifTzHlO340=;
        fh=07xrVQQFIRI19R4hQ2m7rGkK/6gXHdvj3le0GMREyII=;
        b=Gn9ZJjqcwg88M+7L89dpa4aUmP0ctoHGTnKX4OfNrvVusm9oTPw+CM1LkAk5GAvbP/
         fRArj0fpmgpPUjTIJeGAq2RBkDV06M98xzzJz5jfwWKdAkEHteVbFepov18kGTOe0u/w
         GQQ6BnUiCngz/OAv60YHGcgsdc2B2BcjOdyjWp/TZvNugeNIpn9lmwkn00VuW88c8S3m
         2xw++4swUBd3TcULxKF/zcoM7chMUSGPvnd0tVtXPDJA0b0A+hovbrang5MaKNydxu6w
         v0WJ9I8263aQRuglkv7qRKBphyFDe8hQ12YF+IQph6KGS4eaLW9bpXcjJ+xpSpgdr/Ky
         uPYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782499022; x=1783103822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOOeJEgGJirHLvCIZDna3WzBVXhg0OXljifTzHlO340=;
        b=XsgvWSZL4OJdDStOy8iZ02jKrcxWhZV2B0bWwznTt+6Q2cRxehpKw2ry2J3vOZWL9T
         oO6Ee/cKEyqeS4g8NMdkwRE0vP18VHsvSG6VvIC7O3KOeSdxcvmELH9XChtIkFAIlJzk
         E1I7YBx11WmHrrGvVxJWVKGx+aO+uz2ocA3UM7QJ0MDk+E35HEq5B1rqjPH2DjEZm78K
         uwOwGu6rtUF7Pp6Ikp8PE9A/8z2V6U5eZgaMyhHuUfDu9jHwSQqzw76NvjU22bnEgN2X
         4PZaWb9oJ4a1l8lO2rrOgEOWcKHqTGHgzKCbA22yaz1a7mlKUJfealBTKJ7gQGXLJ2BJ
         0jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782499022; x=1783103822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HOOeJEgGJirHLvCIZDna3WzBVXhg0OXljifTzHlO340=;
        b=b6pkwZSpT+JGwlHIZbCPUvTPFedQv1jCT7oPeF4194fyZcQn+RGdzitYWd54cpqye2
         NyhdCFPP+9IotOXPqy6x03jiNWU0JvY5psMey2dRKlAwm6RXBjak029lDOmenxWwFxcd
         pww/gCE3G+LxysFACQmKzAkQpdAoJhGUC3Ri8D99LdGSE738TBPYXtc6NpTxrwwJXjWk
         G7mbuLrFauC5pQG4EzX+1Lg1B7FDgtA0kyl7+aUoHEQUqBaJRbv9JLn3GshQtx+8a1+Q
         mzVC3pogY1qULQ0V822626lcIi6dytqpQ43pZi479FcbQixGIff56r35k+hXYxNJDsuq
         bMYQ==
X-Forwarded-Encrypted: i=1; AFNElJ/pEi0ZM3Fi2Usz6NnZ4m0usse6Tt4uPhJyk6gB8jQA2niiZsf6cGycL8I0RyM6kO3J2GSBac8b@vger.kernel.org
X-Gm-Message-State: AOJu0YyDxVfy1+u6mFMV75d7w46QOhRDM2s483z1OfnNXv0kMZt2thXi
	mHcIaaqqioK4NZHV0WG3+PC0RrbgF7O2FOzCu6n2cwsxfrHyXUzuPSXtZH5dH5tj5yBd8a9QD0C
	UhYW4VaZRur1xevT5BJbzkg9XbcEzp5g=
X-Gm-Gg: AfdE7cl9+SRsC/gyd86aDIsipsgqRn4yREx9RQ4vLeuQxdDFF+FOtoiNuWPgOzg5kZm
	6K2ana/Ap3QQaNq6A9TVpmmkeqHmMnp7/o6DxU15i4DhOopQyLf39V35i27+ZdJP69yQOUk4c1F
	oCx7nDDP0jcsTy8v/bH3FG920LWnOgQOcGbAslUz0tlksKt8fnf/pe2PmJ35pdDv91YqhK3b4Eh
	CjNiY2LxPdiJdz68ZS9kZYhm9VUAEAyEmhQlgrVXEYEYfQuBUWkJFWnxZe8lSZ4R666jc9OEE3k
	fEzn+utpUst9VHQeNkWi5hn1dpHY
X-Received: by 2002:a05:600c:3b19:b0:490:3c15:7146 with SMTP id
 5b1f17b1804b1-4926687e6eamr128170845e9.19.1782499021866; Fri, 26 Jun 2026
 11:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626102358.1603618-10-alex@ghiti.fr> <20260626143244.3382853-1-usama.arif@linux.dev>
In-Reply-To: <20260626143244.3382853-1-usama.arif@linux.dev>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 26 Jun 2026 11:36:50 -0700
X-Gm-Features: AVVi8Ce_QPTWquN2d0lbnXchc4ZFxAYS-iAJXfFBvlstHcQ-UH4eG8289oGmnbI
Message-ID: <CAKEwX=OKsjtStcuvhQ3WCGYoTJHT6eagBq1mZqX+DdbLm_BFLQ@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] mm: zswap: per-node kmem accounting for zswap/zsmalloc
To: Usama Arif <usama.arif@linux.dev>
Cc: Alexandre Ghiti <alex@ghiti.fr>, alexandre@ghiti.fr, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:usama.arif@linux.dev,m:alex@ghiti.fr,m:alexandre@ghiti.fr,m:akpm@linux-foundation.org,m:baohua@kernel.org,m:bsegall@google.com,m:cgroups@vger.kernel.org,m:chengming.zhou@linux.dev,m:cl@gentwo.org,m:david@kernel.org,m:dennis@kernel.org,m:dietmar.eggemann@arm.com,m:mingo@redhat.com,m:hannes@cmpxchg.org,m:juri.lelli@redhat.com,m:kasong@tencent.com,m:kent.overstreet@linux.dev,m:kprateek.nayak@amd.com,m:liam@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:ljs@kernel.org,m:mgorman@suse.de,m:mhocko@kernel.org,m:rppt@kernel.org,m:minchan@kernel.org,m:muchun.song@linux.dev,m:peterz@infradead.org,m:qi.zheng@linux.dev,m:roman.gushchin@linux.dev,m:senozhatsky@chromium.org,m:shakeel.butt@linux.dev,m:rostedt@goodmis.org,m:surenb@google.com,m:tj@kernel.org,m:vschneid@redhat.com,m:vincent.guittot@linaro.org,m:vbabka@kernel.org,m:weixugc@google.com,m:yosry@kernel.org,m:yuanchu@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17342-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[41];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92BB06CFB7A

On Fri, Jun 26, 2026 at 7:32=E2=80=AFAM Usama Arif <usama.arif@linux.dev> w=
rote:
>
> On Fri, 26 Jun 2026 12:20:58 +0200 Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> > Update zswap and zsmalloc to use per-node obj_cgroup for kmem
> > accounting, attributing compressed page charges to the correct
> > NUMA node.
> >
> > But actually, this is incomplete because it does not correctly account
> > for entries that straddle pages, those pages being possibly on 2 differ=
ent
> > nodes.
> >
> > This will be correctly handled by Joshua in a different series [1].
> >
> > Link: https://lore.kernel.org/linux-mm/20260311195153.4013476-1-joshua.=
hahnjy@gmail.com/ [1]
> > Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> > ---
> >  include/linux/zsmalloc.h |  2 ++
> >  mm/zsmalloc.c            | 11 +++++++++++
> >  mm/zswap.c               | 19 ++++++++++++++++++-
> >  3 files changed, 31 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
> > index 478410c880b1..30427f3fe232 100644
> > --- a/include/linux/zsmalloc.h
> > +++ b/include/linux/zsmalloc.h
> > @@ -50,6 +50,8 @@ void zs_obj_read_sg_end(struct zs_pool *pool, unsigne=
d long handle);
> >  void zs_obj_write(struct zs_pool *pool, unsigned long handle,
> >                 void *handle_mem, size_t mem_len);
> >
> > +int zs_handle_to_nid(struct zs_pool *pool, unsigned long handle);
> > +
> >  extern const struct movable_operations zsmalloc_mops;
> >
> >  #endif
> > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > index 83f5820c45f9..17f7403ebe77 100644
> > --- a/mm/zsmalloc.c
> > +++ b/mm/zsmalloc.c
> > @@ -1380,6 +1380,17 @@ static void obj_free(int class_size, unsigned lo=
ng obj)
> >       mod_zspage_inuse(zspage, -1);
> >  }
> >
> > +int zs_handle_to_nid(struct zs_pool *pool, unsigned long handle)
> > +{
> > +     unsigned long obj;
> > +     struct zpdesc *zpdesc;
> > +
> > +     obj =3D handle_to_obj(handle);
> > +     obj_to_zpdesc(obj, &zpdesc);
> > +     return page_to_nid(zpdesc_page(zpdesc));
> > +}
> > +EXPORT_SYMBOL(zs_handle_to_nid);
>
> Does this need the same locking as the other handle-to-zspage paths?
> zs_free() takes pool->lock before handle_to_obj() because zspage migratio=
n can
> update or move the object behind the handle. This helper does the same de=
code
> without the lock, so zswap's uncharge path can race migration and charge =
or
> uncharge the wrong node, or observe transient zspage state.
>

Can we just charge it to the page's node for now? Once Joshua's patch
series is in, we can correctly charge the node owning the data :)

FWIW, this is how these zswap entries are organized in the LRU too -
following to the OG page's node.

