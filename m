Return-Path: <cgroups+bounces-5428-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D989BC092
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2024 23:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8BD1F228A8
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2024 22:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327451FCF4B;
	Mon,  4 Nov 2024 22:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AFtM6yb7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4420E1FCF4D
	for <cgroups@vger.kernel.org>; Mon,  4 Nov 2024 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757893; cv=none; b=AApkuUc6TlmUqYnoweTuN/pyLnX3oSwBUx6uZgx+jIjcvG5xmmrYBWum5g99M9d12C0j2++XdMpIpVxmnRiQ/oRAr5P69jYlGOs/x2RbfKR3MxDAPSn0IwCp/IitSFYv1KPCsXe6uPUp38tOZ4BjOT1CjyxPxUoihA5rUzo3RPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757893; c=relaxed/simple;
	bh=j71TcGeaDO5X0uMRUP0MLrRPmTi3MmdQEyXOiGX99tE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ew3bDvC5onuaZqixm5Qqqoxx3nyv+U2QaqrOBVLs3znE2CRX2a591Lk1gnIi4pekBowPYM3CWOSq6zR6FXLxxEaLHDJ0ovET6E4kooJnP5o1UZAuu2EVhMwJcATC7Klg1pzV7V9dpRu2t4RaVjJWXC03z1PsqmwcuFxebjxsxZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AFtM6yb7; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-84fed1ff217so2984303241.1
        for <cgroups@vger.kernel.org>; Mon, 04 Nov 2024 14:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730757890; x=1731362690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cc0tCbkyMIi3MpKCwFn2JsVOi2X3ZT24UpFB4EpKLs=;
        b=AFtM6yb76GkJ0TKPtV84eqtVMuZiNpGP4GIDavVlV/g103mn5VcpVzD0BpEh93juHx
         Vgxb+0C6kMGrUu2G9e920n0l7cVcCFElt/bcUyJnb8gQZfJboLZJqn1lIYtndPRtLrMP
         c4nVnrjOqNWYFXeFCpDSiUhKaayF6Ydd0dgIHcJnfLOQ+v+zF5egHqdLYxFjW5oKzq8S
         yO+01Q348ZeHpCupjHDs000f7GwQ48z1ZaPtQPQvIGs+olpIMZjr80OefO8a5HvR6zkg
         bXq9TwfZ2GOQ0013KBnglAtNvusuqZ7MwpOEeZGOS8c/uj/SLOKmtm2dSfcXB88zviVC
         zoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730757890; x=1731362690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cc0tCbkyMIi3MpKCwFn2JsVOi2X3ZT24UpFB4EpKLs=;
        b=QhwBnRTqXfDyrbKrcKqO4AX1mU97Wpr6El4TIiVRuyakEvE1UmEVbiBl+fUorVnvMb
         RlijXV4AmRFIDkUHIvmuSW/Zff/bXvC1I8Uz2zA++w1FI0prgtXUU26gsmhdJWnSu0g3
         Tg8+FI+XI2rFuSY+CTr7yTgRkIjGuvGXmo2HvU8WSHDr1oLtxKTqlT58QAtaG+5eYImn
         iIPK5VjhAPU0RHYWzcKtEXrzOGdERH6yq7JpijzZa3dyHy2X+r4eINY06GRXk+FLbdvf
         1dprj0okceA3bjuTne9L+BtNrnV99k1hQuwEV/vRwJ8af9rAAzs5xTtoHA5Ti1RxUfIb
         BjMg==
X-Forwarded-Encrypted: i=1; AJvYcCXcJwIY0oPSOlLYjhjcR4tMN9Px4i+BVe4veFJ+Y3kxYy3hSwgnXdmjrDsqRqjMsKvRbVgmIAuq@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt7NDP88RDtsLbBCMBKah9ZxxS++s1Ax4NKq9+YtrDOZeNwEmi
	/Lv/3N3sTcjO/c2s4YDUtjR0L5z0s2LKYVheDDZAZLyiWiQLSZl9BmmSpGuKSvwJDmd9AKsH35Y
	G0jV+x7kURUfe3zjovct4P3moPbrlF2ZapsvU
X-Google-Smtp-Source: AGHT+IHFoZwB9UJQ/W7UPJWTT6Mwf1OXIt2PanaSLVRWyM98+DOHGoOSiH002T//dMssG37gkEwNVD1jyiUDrfB47Us=
X-Received: by 2002:a67:eada:0:b0:4a3:c32a:dfbf with SMTP id
 ada2fe7eead31-4a961b8080dmr9219748137.9.1730757889902; Mon, 04 Nov 2024
 14:04:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-6-shakeel.butt@linux.dev> <iwmabnye3nl4merealrawt3bdvfii2pwavwrddrqpraoveet7h@ezrsdhjwwej7>
 <CAOUHufZexpg-m5rqJXUvkCh5nS6RqJYcaS9b=xra--pVnHctPA@mail.gmail.com>
 <ZykEtcHrQRq-KrBC@google.com> <20241104133834.e0e138038a111c2b0d20bdde@linux-foundation.org>
In-Reply-To: <20241104133834.e0e138038a111c2b0d20bdde@linux-foundation.org>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 4 Nov 2024 15:04:13 -0700
Message-ID: <CAOUHufbA6GN=k3baYdvLN_xSQvX0UgA7OCeqT8TsWLEW7o=y9w@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] memcg-v1: no need for memcg locking for MGLRU
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 2:38=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Mon, 4 Nov 2024 10:30:29 -0700 Yu Zhao <yuzhao@google.com> wrote:
>
> > On Sat, Oct 26, 2024 at 09:26:04AM -0600, Yu Zhao wrote:
> > > On Sat, Oct 26, 2024 at 12:34=E2=80=AFAM Shakeel Butt <shakeel.butt@l=
inux.dev> wrote:
> > > >
> > > > On Thu, Oct 24, 2024 at 06:23:02PM GMT, Shakeel Butt wrote:
> > > > > While updating the generation of the folios, MGLRU requires that =
the
> > > > > folio's memcg association remains stable. With the charge migrati=
on
> > > > > deprecated, there is no need for MGLRU to acquire locks to keep t=
he
> > > > > folio and memcg association stable.
> > > > >
> > > > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > >
> > > > Andrew, can you please apply the following fix to this patch after =
your
> > > > unused fixup?
> > >
> > > Thanks!
> >
> > syzbot caught the following:
> >
> >   WARNING: CPU: 0 PID: 85 at mm/vmscan.c:3140 folio_update_gen+0x23d/0x=
250 mm/vmscan.c:3140
> >   ...
> >
> > Andrew, can you please fix this in place?
>
> OK, but...
>
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3138,7 +3138,6 @@ static int folio_update_gen(struct folio *folio, =
int gen)
> >       unsigned long new_flags, old_flags =3D READ_ONCE(folio->flags);
> >
> >       VM_WARN_ON_ONCE(gen >=3D MAX_NR_GENS);
> > -     VM_WARN_ON_ONCE(!rcu_read_lock_held());
> >
> >       do {
> >               /* lru_gen_del_folio() has isolated this page? */
>
> it would be good to know why this assertion is considered incorrect?

The assertion was caused by the patch in this thread. It used to
assert that a folio must be protected from charge migration. Charge
migration is removed by this series, and as part of the effort, this
patch removes the RCU lock.

> And a link to the sysbot report?

https://syzkaller.appspot.com/bug?extid=3D24f45b8beab9788e467e

