Return-Path: <cgroups+bounces-6178-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DC1A13150
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 03:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB5E188949A
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 02:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57834481A3;
	Thu, 16 Jan 2025 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxEFtrV/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6747224A7EE;
	Thu, 16 Jan 2025 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736994165; cv=none; b=OE88ZlXG3B/g7I9jF9/gKWXjpEO/TgifBk5iFWdfG9p6Q6aF58k1C1qyHmigeTtjAnf7s2DVqm3f6pfxIsmV+CVeRM0bnSj4vCkyj6upEANJRTwodaEhnXhkKA4OKKcUKRw87tz2n68XApjuWUxzpeDvX23E+6oOO40KetH+XJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736994165; c=relaxed/simple;
	bh=JG5PwZAne8XlSGNWsx/HK3rGAQ9E85RzEK5Z61yXxbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVhnqc8U6/VR9hNadmwC/0IefMrIRJW7sflDiE4TMLB/O65aPZjz0JpGOZYFssdDZYJpm2Q0AkENgZ4A970MWsXsrAd5rkWF2/BUNYMAr8j6R7k7sZ7hVp6/Ys75zBnI746VmCfRnmv0tPEaXjXnHCnzRkt2a0IKZodpAWJamuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxEFtrV/; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385d7f19f20so202504f8f.1;
        Wed, 15 Jan 2025 18:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736994161; x=1737598961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CCoBm1y8pOX5q7ZU8+TocUYP0UhOzxurJN+MoqKRGw=;
        b=QxEFtrV/vo9llP85RIZnWDsnawoMuo5pYrKENAp0b1xdlHUbAJ1edxF0fafUFNvKu1
         BmWdk5okljQXh7aszGSmPdlvNwD0xRJqrNyIJmQyRlXEUpe3mV8QdTT4hijr1xn/inTp
         wKi7YAwKCr8ryQS3QTpAtwavApyRoilQsJwudyYWBdw60y7UApLoukkLAju2ZiTlHK2a
         f764J4wSa9hx2VXcYphw7AftRGQJOSUdfhxx5lpKr6XLp1YRaIzCPUHoztsk5YQdwkNA
         HS2QGcX9kAQsb1i4ttJ/W4yXbcWq73RX8N5uceFcLymRHUy8zfdTp/vbJFt6F1rx/OBr
         A52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736994161; x=1737598961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CCoBm1y8pOX5q7ZU8+TocUYP0UhOzxurJN+MoqKRGw=;
        b=M3Us8C/OG4OTdjwfa869RnQc7nYcOdVTF998x60+Add8nbagAeH6NnbteWswDtwqSX
         b0ikTN3UIEe2rcRXVxRnq5Z0Kwr6Cu6FudJqT28+m7JA0lEt3VwrjdDAuRiWsV1huKip
         526TrvOyAapuRzKqN7DGyvsNodvwfQTD3r4tpWGCVSIH9WEp77BTAB8bt4Uu6N65dfU7
         Os14yxUuamMzJJuBOE6qWoZ7W7+qHIxcHc5KY7GvW1F7SjUtE9gC0wdkJUHA9Wq/FQ4v
         mN+NV91ETkb18LrXC8VLP5j0FpTg+FB0lh0n78M/W3qiCeJAdT3GQGoNHodD82xHm/jm
         QYCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf1k6/7Cr3sPXUCo+xGAkqWObHAq0gdc0SY/V40wLT+WIndbv3xRNG2Gr3EnMqBf781fuHgwBV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn3IaGPmhCIhFSCv1zGcr0Y9mkCBLRe2gozp3mUhnB2wUhfqcc
	x76kTOrqPZV3SPhYNF054G45RvpjJWj00zGpqfqDAwOMfKWStpQl1lBDiXzAIVeDy30Ep9a0Lb6
	SHxbG4DxfWF+PoARQAWlsD2Drd7w+Pt6n
X-Gm-Gg: ASbGncseW9JhpmLRYu2Zm7+RUyHnA28ThdZJ4oExU7nk7HFi/C1NRh+TEImH75TGe/7
	IcVbtaS+DB1KRkeAMzD+jlXqPKhRZir2F+fAZee47SXpYEz7lsGAZkA==
X-Google-Smtp-Source: AGHT+IEKtVuajWZgwoOaUg+OTfmnKZcUaMvweNO4Ybs9RNl3uzalHNeEM+EZaVIZssyRHPill9de9h23TNze52Bju+0=
X-Received: by 2002:a05:6000:178e:b0:385:fd24:3303 with SMTP id
 ffacd0b85a97d-38be9ceac10mr3199495f8f.0.1736994161574; Wed, 15 Jan 2025
 18:22:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
 <20250115021746.34691-5-alexei.starovoitov@gmail.com> <svm77mp6vx5uui7zzzvfo27oijq6nh3ceqfdc676to6oruidaq@p7ddlyjwwwrw>
In-Reply-To: <svm77mp6vx5uui7zzzvfo27oijq6nh3ceqfdc676to6oruidaq@p7ddlyjwwwrw>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 15 Jan 2025 18:22:28 -0800
X-Gm-Features: AbW1kvbmtlUFtOVTN9tBFoUufcUMkk4E5svlUJ9HTwowBMUBZJ_jZip0odkQM_0
Message-ID: <CAADnVQLEfjETi+L3PXwTz7i+MnT4FT1ohoAL555N_Mdhd+vqBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/7] memcg: Use trylock to access memcg stock_lock.
To: Shakeel Butt <shakeel.butt@linux.dev>, joshua.hahnjy@gmail.com, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	SeongJae Park <sj@kernel.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, 
	Tejun Heo <tj@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 4:12=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Jan 14, 2025 at 06:17:43PM -0800, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Teach memcg to operate under trylock conditions when spinning locks
> > cannot be used.
> >
> > local_trylock might fail and this would lead to charge cache bypass if
> > the calling context doesn't allow spinning (gfpflags_allow_spinning).
> > In those cases charge the memcg counter directly and fail early if
> > that is not possible. This might cause a pre-mature charge failing
> > but it will allow an opportunistic charging that is safe from
> > try_alloc_pages path.
> >
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>
> > @@ -1851,7 +1856,14 @@ static void refill_stock(struct mem_cgroup *memc=
g, unsigned int nr_pages)
> >  {
> >       unsigned long flags;
> >
> > -     local_lock_irqsave(&memcg_stock.stock_lock, flags);
> > +     if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> > +             /*
> > +              * In case of unlikely failure to lock percpu stock_lock
> > +              * uncharge memcg directly.
> > +              */
> > +             mem_cgroup_cancel_charge(memcg, nr_pages);
>
> mem_cgroup_cancel_charge() has been removed by a patch in mm-tree. Maybe
> we can either revive mem_cgroup_cancel_charge() or simply inline it
> here.

Ouch.

this one?
https://lore.kernel.org/all/20241211203951.764733-4-joshua.hahnjy@gmail.com=
/

Joshua,

could you hold on to that clean up?
Or leave mem_cgroup_cancel_charge() in place ?

