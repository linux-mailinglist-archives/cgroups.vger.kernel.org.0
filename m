Return-Path: <cgroups+bounces-17377-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MZpTC8S2QmpQAAoAu9opvQ
	(envelope-from <cgroups+bounces-17377-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 20:17:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 783BD6DDF5C
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 20:17:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KoP5xQMF;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17377-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17377-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16EE2302BA48
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 18:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA8637BE95;
	Mon, 29 Jun 2026 18:14:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178552737E3
	for <cgroups@vger.kernel.org>; Mon, 29 Jun 2026 18:14:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756881; cv=pass; b=CG4L9szjEjvFg2cMSz8D4vojvi2ROpp8tZ9NO5QDaClle2fRI9VEpKaVCCVI68RzdM0YCAGuD98aLDuP04zaiZGDc9OnWKZCDYLwaTaRdvH+PbKuSp0vMcm0jkPH/IIZk0v6exxP54l223LiztmnI7f7sLxU9bnx4AccOwAnS1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756881; c=relaxed/simple;
	bh=ErmLoO4HPr0xXn55FT+gIFkZ3yxLvuICRPkv0D2wKNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWTaE808o4Oj4BmCF7Vt87nfGfLLwc7kg0MMmDOHeyV+zxHC3YucGFes5uzZuyRos8jNlnzEAZL/0JNBPymF8unWFhYS1GjWnv2QreOmaQvd+U6NklwBnEnLgqPokhZM81pdG7hwWUj/O3t2+HpZWHFWrqhbpi4Wf7vF3OjOVcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoP5xQMF; arc=pass smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493a432c84eso17032185e9.3
        for <cgroups@vger.kernel.org>; Mon, 29 Jun 2026 11:14:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782756878; cv=none;
        d=google.com; s=arc-20260327;
        b=Vu7aSS+YJ6zEz1qWPXRMwpHHwjJHDkapBu9rvu+Ie8W5mjFN+bs4qfJcI/8DZebaG9
         db0FyZdy8qNxK9kPHwtYZWDhKEPeX9BuseGG/b2GxBtMj2OKv7Yrztj4xM5cNP0LM2uF
         F+K9/dfrShw1fg3HfuIOMQ8ZaJTGPM5bbYt8YzZpu2bbTkOa7IwCmdHKODp4zj3i66uv
         OlOuA7Rp4oFbYBitkCSRaJNxcSOPMUQt8+89VRZLRsoK9+CBrQidg6uSwMuDy1Lok9js
         /JcvNQ3vuZmKKzMCS3k78c2kqIUvD7NyMb1Zu0i66k99TYR60tN6Vo0oF9GQG6i51v4D
         u+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z6kHm/79xhhemc0kFX5LJiBZDJ+K1Gs2+S0vOgP3nJ0=;
        fh=G8PMsSggPFnm6ZZq3RIAt3StLcsA4zHfCmrkS8UnIjs=;
        b=pQkKDOVmukjycoKCi8AEpITa/kf+c4//HXKdd9oGf7+Pqnt2nCk2laYOA5bmGjuq5x
         JIayhI/hiV5jlHP+rkSm4wFKZ3stTzut/+3ZY4qESnIXzTtCKEicfaGLrgOI4doddMFF
         0hT6d+kk1mFOgtCZlbKYjUQ+W3SqWPOOiyXyF7LLpjkUDPWMHAVqHqUYCXZu2ZOP1Gzr
         zfsXbpHTZP7LDLTClPjZ3I+euayV+m3N4E7osxDrj1CJNySwsya8kd0GEVETVXIweGhK
         SVikhZqX6GNrqg8NU7i5bDvRPsiC80NWYydgKFGLYkv+ibvsqoj7GEysr0yaILqHdpQt
         sxuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782756878; x=1783361678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6kHm/79xhhemc0kFX5LJiBZDJ+K1Gs2+S0vOgP3nJ0=;
        b=KoP5xQMF97HTj+OGVVSZEasuP1IBp9SYPMD+FoiXrwisLDVz1ipMqlySqtKKrqAeba
         bdPVCREh081nV+Xs1DIWwbyr7godYnLeuo+LEZADQN9ib2fbT6w4dWAyAEWa195X7Bbt
         hMCBJ3i++bArxJErcGdFzmW/f4KpRAIYzH8NaYV6aNFqrkDXiMQWVp5XPrAWDJVgj1lR
         rEChxarLgZVVk85hvDWaqa5J+wELkt06aiCeTUOP3/lfWfuvr+qu1m4LWnx88fHbQXsP
         nDEMbzsMEdfPZTF9baNN84uV/gHAF9BwhkzEXORwQbu4fzi6ha4D7pzIDEV/atq7cIbH
         cMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782756878; x=1783361678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z6kHm/79xhhemc0kFX5LJiBZDJ+K1Gs2+S0vOgP3nJ0=;
        b=pklwNUNIMe91ibDXoXFDfL8a4p8qF5dpjU8UYHjWpCPLi9av+Z4+O6jgB1aGykeKiJ
         DPeCFPTVMyt3paHWKyek32HgjNr57pnxDr4GuOoZkLlLxN0JvGmZETnXOWyuHRGyyyK6
         kz+3mBGWi8MIkKyz29Ag8sPXEKacX8OepsJJD39Pdng307RD2ttNtw+xVBT/FcMqllwK
         tbSNvtCwq/39JdbjiZArWnaJ2VgMJCPJkKQWjTTeT8HD2iuUO1Y/I0xYYEUYkLeaYIDC
         4HuO7WLconWi4fADAnb7YD8bqoYLOemvfc3SjZKkA2FcJzt3MXYzrLlqOk2EHxxr28Bo
         PZQA==
X-Forwarded-Encrypted: i=1; AFNElJ9+lKPlL+3RBlEgo/EMjdqKjozyBL9DQX0xfmnBEKGTrdvx/Z3cwg1+C61mai5ekHQoPrE9fvEo@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9xlVuxU0PsapkqQajwsvBP1bGUP34SPYlZb2a7Pb2x9qIm6Pp
	X4Kw+wLIkeC42+Ypk6rwHSTg5vXmnf5P5yyytKVY2wmTdBSoMEX2JBy0FXJpqEb7Pq5gJ82GZZM
	g/M7A52NiRgdMtpo/QCm7hGWZvq4DLjI=
X-Gm-Gg: AfdE7cmI17QazXcSVrLcZqk04+Ie2tfo1Gs9T1sBe059XtkooMzlBdwu59vvC8p2XyN
	lNXc9jC8SApU15kSUMHH0oPErVnM26O1kzeboiH4iJNkHYdpIdwZG0JKJ7UbK/+QP81Xt1BoD8l
	LD4lY1QnoL1BENHRsPDc9RwyksaTPoWQ+0hHlyg+i+Tx85e/TfHDGhGDdECWK5UtGDt2gZbrjp/
	Sv7aC15uoEVZQnBjyaWXFZpYdqrNBQmFgurRCd9ebosBL5OIWekhHTYsLGPOAEMWCKba6XeHswi
	3JB8QwrUVh0At5ixMnaEx+KsIENX
X-Received: by 2002:a05:600c:3e86:b0:493:b877:fbc with SMTP id
 5b1f17b1804b1-493b8771027mr9738285e9.21.1782756878495; Mon, 29 Jun 2026
 11:14:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626143244.3382853-1-usama.arif@linux.dev> <9a8ba4d7-07ea-4ec5-b158-39fff4796f84@ghiti.fr>
In-Reply-To: <9a8ba4d7-07ea-4ec5-b158-39fff4796f84@ghiti.fr>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 29 Jun 2026 11:14:27 -0700
X-Gm-Features: AVVi8CdxW7dOj6xPHpW8RCxJsaYfTZ6ZpXAfESXVbullYLLBxsnotuCt4ayOILI
Message-ID: <CAKEwX=PWWSF8+LK3_ZDiKiBu79d69uzDL3kUsCaohmVe=v6Wwg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:alex@ghiti.fr,m:usama.arif@linux.dev,m:alexandre@ghiti.fr,m:akpm@linux-foundation.org,m:baohua@kernel.org,m:bsegall@google.com,m:cgroups@vger.kernel.org,m:chengming.zhou@linux.dev,m:cl@gentwo.org,m:david@kernel.org,m:dennis@kernel.org,m:dietmar.eggemann@arm.com,m:mingo@redhat.com,m:hannes@cmpxchg.org,m:juri.lelli@redhat.com,m:kasong@tencent.com,m:kent.overstreet@linux.dev,m:kprateek.nayak@amd.com,m:liam@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:ljs@kernel.org,m:mgorman@suse.de,m:mhocko@kernel.org,m:rppt@kernel.org,m:minchan@kernel.org,m:muchun.song@linux.dev,m:peterz@infradead.org,m:qi.zheng@linux.dev,m:roman.gushchin@linux.dev,m:senozhatsky@chromium.org,m:shakeel.butt@linux.dev,m:rostedt@goodmis.org,m:surenb@google.com,m:tj@kernel.org,m:vschneid@redhat.com,m:vincent.guittot@linaro.org,m:vbabka@kernel.org,m:weixugc@google.com,m:yosry@kernel.org,m:yuanchu@google.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17377-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,ghiti.fr:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 783BD6DDF5C

On Mon, Jun 29, 2026 at 6:14=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> Hi Usama,
>
> On 6/26/26 16:32, Usama Arif wrote:
> > On Fri, 26 Jun 2026 12:20:58 +0200 Alexandre Ghiti <alex@ghiti.fr> wrot=
e:
> >
> >> Update zswap and zsmalloc to use per-node obj_cgroup for kmem
> >> accounting, attributing compressed page charges to the correct
> >> NUMA node.
> >>
> >> But actually, this is incomplete because it does not correctly account
> >> for entries that straddle pages, those pages being possibly on 2 diffe=
rent
> >> nodes.
> >>
> >> This will be correctly handled by Joshua in a different series [1].
> >>
> >> Link: https://lore.kernel.org/linux-mm/20260311195153.4013476-1-joshua=
.hahnjy@gmail.com/ [1]
> >> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> >> ---
> >>   include/linux/zsmalloc.h |  2 ++
> >>   mm/zsmalloc.c            | 11 +++++++++++
> >>   mm/zswap.c               | 19 ++++++++++++++++++-
> >>   3 files changed, 31 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
> >> index 478410c880b1..30427f3fe232 100644
> >> --- a/include/linux/zsmalloc.h
> >> +++ b/include/linux/zsmalloc.h
> >> @@ -50,6 +50,8 @@ void zs_obj_read_sg_end(struct zs_pool *pool, unsign=
ed long handle);
> >>   void zs_obj_write(struct zs_pool *pool, unsigned long handle,
> >>                void *handle_mem, size_t mem_len);
> >>
> >> +int zs_handle_to_nid(struct zs_pool *pool, unsigned long handle);
> >> +
> >>   extern const struct movable_operations zsmalloc_mops;
> >>
> >>   #endif
> >> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> >> index 83f5820c45f9..17f7403ebe77 100644
> >> --- a/mm/zsmalloc.c
> >> +++ b/mm/zsmalloc.c
> >> @@ -1380,6 +1380,17 @@ static void obj_free(int class_size, unsigned l=
ong obj)
> >>      mod_zspage_inuse(zspage, -1);
> >>   }
> >>
> >> +int zs_handle_to_nid(struct zs_pool *pool, unsigned long handle)
> >> +{
> >> +    unsigned long obj;
> >> +    struct zpdesc *zpdesc;
> >> +
> >> +    obj =3D handle_to_obj(handle);
> >> +    obj_to_zpdesc(obj, &zpdesc);
> >> +    return page_to_nid(zpdesc_page(zpdesc));
> >> +}
> >> +EXPORT_SYMBOL(zs_handle_to_nid);
> > Does this need the same locking as the other handle-to-zspage paths?
> > zs_free() takes pool->lock before handle_to_obj() because zspage migrat=
ion can
> > update or move the object behind the handle. This helper does the same =
decode
> > without the lock, so zswap's uncharge path can race migration and charg=
e or
> > uncharge the wrong node, or observe transient zspage state.
>
>
> You're totally right, I missed this, thanks!
>
> Thanks,
>
> Alex

If we are to do this, is there a way to extend zsmalloc's interface so
that it returns the initial node placement together with the handle in
zs_malloc()?

That way, we can avoid going through the zsmalloc locks again. It's
quiet expensive, especially with compaction in the picture - the
pool->lock is a global rwlock :)

