Return-Path: <cgroups+bounces-3718-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F5C9333EA
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 23:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9792CB243B5
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 21:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E2013B2B1;
	Tue, 16 Jul 2024 21:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u2mznDst"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C967441A
	for <cgroups@vger.kernel.org>; Tue, 16 Jul 2024 21:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721166893; cv=none; b=E98JGHlPFV9Iyw3PdJNk2xBgG0Hugh+O1hFSLfGd2/3Tcu/TxPdrn+fMNo8UNVwzIAXsRhIEEjph4vEAMbj0UDr5EVJ2FOwX9RENMBX8+YfMYLOAL1fUVugMY8waM7hvW4xHCYIBTpcq7TF/gWee5M+YsSgrqMVCOM1OG4TiQLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721166893; c=relaxed/simple;
	bh=5e4Ng28q28DDq+Mos/gXCE7nX4lxZLwJsuTxdK0ZCgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UkAYNW8099OypXJ4SPDG3YBuoiuUdPR/eu2E4pQARPDBpJ+aiMxI5UzpDvQBlNAwLcu406Zfwh9SJIMS8FnmkJP4bLLaEUGzrhR6PnTV/TMq1TAxJhYI/cR1cCL9zJqqDA/PCCNWQQ1bZSfR6y8SFbZOOrIMb+02Sq2k9lom3UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u2mznDst; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77c1658c68so646262866b.0
        for <cgroups@vger.kernel.org>; Tue, 16 Jul 2024 14:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721166890; x=1721771690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCz2Kt6Np14OnybqMGjWHHC2wl/sK9b6rMuszryzTDE=;
        b=u2mznDstPsA5ZTNUgb0ciOTi34ZKY31aksJLu44aEZNCnH6EL0ur0jSuNV7w0SQbMk
         77Gb1dN2MjQERkLex44VuhdzAOqorSbqQfXCnEf5rVDMzaViLSZh4JMdVyMhaGGYC8JM
         vWSPLnZ3xDOrtghoPCrNas+sxMd7fgM6FD+7dlZM6v7hz3OwGmAdnrtsiiDjyYZsWd1L
         zJKywWGJoCUyc9ofh6mOLQXaoIYKBsaf/uEPJrmv/v0TlEB5AG9fAo6WMojyIkvb2AJ6
         1FpE/MymZkhqUNlLvsn8G+6QbI/DKeWd7mpR0NIAsJPfDxvE2QSczvXWpXl4K4b718gf
         sHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721166890; x=1721771690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCz2Kt6Np14OnybqMGjWHHC2wl/sK9b6rMuszryzTDE=;
        b=cxMniwm4E4MFETsaktMZkXjbVoOzohw2QoBhsrNK5wDdMxCIdba9MNHkiRnoS0Xh71
         XA8/37HsuaisHYSz373gJzo07kzM68jxh7BakFkaVDnD+9Hj2CXjSEynGtOclY8mfsVL
         92R2zWj+2q0E44SzAP2SZ0gHXtdIixxhw/y+1KM7cCgkwySn8tcDIyrIF0UTAuk/CSr1
         1qnsqq0HS90gyCRUe8860Idux1LEh/nxj+GFo2jIQbtYa+OU5IDZYbP04y1V6lK+EdAe
         wFb5O3bHRW9PTr8ykumOmG9b+/qJqwHoaDI0LNtmZDU6oIB24Y38tmsVrSZNG5iP+P98
         05xw==
X-Forwarded-Encrypted: i=1; AJvYcCXBNKWE81+wprN5rfTD6l5w9Q/frHgkIN7ZGKyMkiwKo/dINrzzA8t4BOb1d9PZK0uqmxu+Ds+MJHWaBRjDV9QTl1ZTk/sOfw==
X-Gm-Message-State: AOJu0YxCb2CivlUmLBRl1V98z6KvEmIywbOI9yG4ccRGpsGs741Bua8o
	wFNTx7vDWumvtvMGPAcaiHfGqolFeAo4jjMJwDQ1MVKB+0fmc2+U0gX74DuPyojmQFDNxnnd+Js
	eP1kYzQ8ZO58S5y4Rjy2BJ9uIr4XjDyZyiX1z
X-Google-Smtp-Source: AGHT+IH+L98WmINi2A/vrSb7b+4tKg+cB+n8wwUAWNPhhTY5kTA7Q7W01G2LTbnOXEgy7vUpJa5vdfkX9A2/O6+vCQ8=
X-Received: by 2002:a17:906:488:b0:a72:5bb9:b140 with SMTP id
 a640c23a62f3a-a79eaa73fc1mr237672566b.54.1721166889832; Tue, 16 Jul 2024
 14:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171952310959.1810550.17003659816794335660.stgit@firesoul>
 <171952312320.1810550.13209360603489797077.stgit@firesoul>
 <4n3qu75efpznkomxytm7irwfiq44hhi4hb5igjbd55ooxgmvwa@tbgmwvcqsy75>
 <7ecdd625-37a0-49f1-92fc-eef9791fbe5b@kernel.org> <9a7930b9-dec0-418c-8475-5a7e18b3ec68@kernel.org>
In-Reply-To: <9a7930b9-dec0-418c-8475-5a7e18b3ec68@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 16 Jul 2024 14:54:12 -0700
Message-ID: <CAJD7tkYX9OaAyWg=L_5v7GaKtKmptPpMGJh7Org5tcY4D-YnCw@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, tj@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 8:26=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel.=
org> wrote:
>
>
> On 28/06/2024 11.39, Jesper Dangaard Brouer wrote:
> >
> >
> > On 28/06/2024 01.34, Shakeel Butt wrote:
> >> On Thu, Jun 27, 2024 at 11:18:56PM GMT, Jesper Dangaard Brouer wrote:
> >>> Avoid lock contention on the global cgroup rstat lock caused by kswap=
d
> >>> starting on all NUMA nodes simultaneously. At Cloudflare, we observed
> >>> massive issues due to kswapd and the specific mem_cgroup_flush_stats(=
)
> >>> call inlined in shrink_node, which takes the rstat lock.
> >>>
> [...]
> >>>   static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
> >>> @@ -312,6 +315,45 @@ static inline void __cgroup_rstat_unlock(struct
> >>> cgroup *cgrp, int cpu_in_loop)
> >>>       spin_unlock_irq(&cgroup_rstat_lock);
> >>>   }
> >>> +#define MAX_WAIT    msecs_to_jiffies(100)
> >>> +/* Trylock helper that also checks for on ongoing flusher */
> >>> +static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
> >>> +{
> >>> +    bool locked =3D __cgroup_rstat_trylock(cgrp, -1);
> >>> +    if (!locked) {
> >>> +        struct cgroup *cgrp_ongoing;
> >>> +
> >>> +        /* Lock is contended, lets check if ongoing flusher is alrea=
dy
> >>> +         * taking care of this, if we are a descendant.
> >>> +         */
> >>> +        cgrp_ongoing =3D READ_ONCE(cgrp_rstat_ongoing_flusher);
> >>> +        if (cgrp_ongoing && cgroup_is_descendant(cgrp, cgrp_ongoing)=
) {
> >>
> >> I wonder if READ_ONCE() and cgroup_is_descendant() needs to happen
> >> within in rcu section. On a preemptable kernel, let's say we got
> >> preempted in between them, the flusher was unrelated and got freed
> >> before we get the CPU. In that case we are accessing freed memory.
> >>
> >
> > I have to think about this some more.
> >
>
> I don't think this is necessary. We are now waiting (for completion) and
> not skipping flush, because as part of take down function
> cgroup_rstat_exit() is called, which will call cgroup_rstat_flush().
>
>
>   void cgroup_rstat_exit(struct cgroup *cgrp)
>   {
>         int cpu;
>         cgroup_rstat_flush(cgrp);
>
>

Sorry for the late response, I was traveling for a bit. I will take a
look at your most recent version shortly. But I do have a comment
here.

I don't see how this addresses Shakeel's concern. IIUC, if the cgroup
was freed after READ_ONCE() (and cgroup_rstat_flush() was called),
then cgroup_is_descendant() will access freed memory. We are not
holding the lock here so we are not preventing cgroup_rstat_flush()
from being called for the freed cgroup, right?

