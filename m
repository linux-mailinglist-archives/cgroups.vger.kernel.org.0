Return-Path: <cgroups+bounces-15285-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qE0xKbS13WlRiAkAu9opvQ
	(envelope-from <cgroups+bounces-15285-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 05:34:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F4F3F5478
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 05:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC7C33035D72
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 03:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE8F3290A0;
	Tue, 14 Apr 2026 03:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecjj8Qxf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C73B2DAFAF
	for <cgroups@vger.kernel.org>; Tue, 14 Apr 2026 03:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776137365; cv=pass; b=LN1HsEd+MiuXes0+31v78sbOh9kI4ZKjikMNbsXf/ZdfEBXB8VhCil6qUgrYqJZQMIDr7HYfSnd7XQ9KCk/mEj17akKzKpVdbNP1lsZf6HaxqT3N1Gs/muE3HZrfDaM5Bk4zg5NuWor+O4ccJs3rQksw6O0IhxTs1zMCEVb+c3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776137365; c=relaxed/simple;
	bh=02XAKz/14kc6zksPNYP7oVuf6DQGS1WSgbuT+EiabeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/EvlPQiuhhDxJIMSrYoH4c8FGpQeE37xitrnrBY22iw7TvH7FKqVLlXy83uv2rnsSZP6VF546feNX96W0ltH+tAJhsMEOzPAZcQLLN90e1YA+WmOGjQRjqJkzZUPLJ8rR74gfdLc+2qVAFh1RKTwleOktUCNI/SisATEXiElv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecjj8Qxf; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-671a901584eso1712441a12.0
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 20:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776137363; cv=none;
        d=google.com; s=arc-20240605;
        b=KkoxBG7cKM60f7lTGnfvihgl1lnYr162p48iUurCFFGuSJ6kIR+RN3THQwg7PdXvYU
         YynX7s+bxcSqf73byNx8qowdCWmuI6ypsmnTdPX7dWE7LxjIz73B3W+m9XCfW8GhtZ2o
         vDQzeOvsbNFzPEXPfG2chBvdhypCLsa9U88J9ScebGClViatlrw0+Hi161qTdZ7oyndn
         HK4tuv3SZEvLd0LdDrd6PErqUUzgWYeiWZF8TWZ3K1OszxjtUK201+j+KZv7hyKoLKh4
         bgi7FxxLm5Oq8XDIpKzlHD99fSrn2INj+qLLrZh5D1L3mpk21en9YCUV056QW/f6G5P0
         ucQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9IgEcKdFGPBfiWmGanmcMdBmry9woiQGfJg0pQl8nak=;
        fh=Y46yJ+320iTOWjqNAWdRvm7FrTf5teLoAODE+QeU7+M=;
        b=CbVlfOSicnoRN81pmAup7K4UZy/uMj0BtcDPs/1iPVB/4gFKyCPw6mSjb0vDq+9wOR
         +PdIfoRfOndIMFw2L4U0qxyf4j7zZ/uc+Iu96APeyp1PqgzgWAsMwF4zSwzUfnjoYuOh
         z0rJUJJ3XHruf64dpmIs3zw5AF3NBJVEmDvak2AlBkf9tVHb+FPJlU0PhswUhg+FmVFC
         iUwYRaeAS7gm9joahHYbpawjGtSI3pqnRtSUY6hGN+fuMsRGT9aD/ZPNvcEMWxR5S/te
         VClCSvV+INXDe/QNQtp4B0cgbfGrGDHd3+GTxeE6o7LgdwjKLHSt1oki0xLQ77G8xpf0
         m9hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776137363; x=1776742163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IgEcKdFGPBfiWmGanmcMdBmry9woiQGfJg0pQl8nak=;
        b=ecjj8QxfO+rMnQFYOxQV86Jd652ldg0OD4W28l93J4/sj8NQ+ZfQEh0EHaWD4XEvuI
         05FA9dC/aeNhXL0T0RQTA+Uz0EcAf/sSzOaMA5OuwVfGdh2U8VS7F20Vow4dB1RGoyO6
         jod3M3+DM6/ei+b3V3vGG1WvDyGbTTHoerXlUq0KQ88gDfmLgCT9QWUYlXvYJa2yQnwz
         VB91bqZMN40QaLyQJ+Wo07uRpstQJvhzdLlJPItFYcnOVz9aMrMauAuQnO6Fdp8eOcnh
         7g+6JrNdXZFyRniEGzHbbfkPBdD+izGJ72XpIkYrHmc/Mx47Kz1QBaT1qfVkT9I/IIsE
         l/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776137363; x=1776742163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9IgEcKdFGPBfiWmGanmcMdBmry9woiQGfJg0pQl8nak=;
        b=f0CzXED+cb5wmxOGsd6tYVaUlCLV2RmVxdjxEtEUKX/B9SkaqTFmN0ggwAjNG7Kyiu
         7+VhmHMClc4LEadY1ulEHg4u+rjy7i7J5LGpPnimnfxGRUoL7FenwCyRsLcnp0dh4jSC
         gKDSFdGFvRbw1YyFfNcWTYpOf59lV+7osKLlzQJ5L2WvaffLZDPvGb+QEpZHxQ601ZHk
         /+j8nDa/+5rjAC4ra+Q+kyY1ujW7vHuVIu3q+Eo+E18+FgQ/DQiF5kxg1uCfk/koCBOk
         cnh+4HjTW9N7trkIQT3ZoqttUlUW5a9YEzkOasejd5AUWQXcppVNV4/9/PbGaN2NjysF
         MbdQ==
X-Forwarded-Encrypted: i=1; AFNElJ+GkoqBFdAnBMIOaRUdNrd8EGMKwTP/JqrqL5aCBBY4IuReXgASVsJoHWCyXNwLWCZN4SmkEvvk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/KXt64BoVE0ofo3lDOUIW40JzNQhCIZAcDE5zUa2ZrcrHPLWW
	DmtPhxIXIB1wOit4JLn30iPJfLsMUI6VeaWz/D8ZiiMbARnHGaVB2sSPls/Jfrzc5l3DUW587G9
	kcheb+q3AnKuIOitOPEmv2yv7etTCsv0=
X-Gm-Gg: AeBDietycQ88ps2gMsWEraqcXHP3keXHlaGlBj2hkpf5z2sSXVTEe99xQIkem0C/np+
	VmdEeejg4CCXZbxD0IhHusD+XwVo0rlFaM4JcqiJXog7wE6QXYbRJ9wpvlMVtdgYz0sD+vvc/HT
	77Qb3XVybbe6UhAFVmM9KzlEMUHZZ0hM2hRu759HgUnoPE5Q6YVLpjQ40ui/hbj3ynGxg26N8W1
	ibgnV3hiD73Ca9UOt3d8BxxplQv14lgIPqa+KRbeXOGlVh9YBAaiFYx61NLiWQviWVXAlR/MMdA
	DKgi2UMzi97tOQtdMy7ooHrYsWkY7V91CFLn4jVD
X-Received: by 2002:a05:6402:a54d:20b0:670:8d90:e861 with SMTP id
 4fb4d7f45d1cf-6708d90f131mr5258361a12.6.1776137362474; Mon, 13 Apr 2026
 20:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <acQrQYHJgqof0yx4@yjaykim-PowerEdge-T330>
 <CAKEwX=NnHxpQKp9qBg2=r_euyjgxw2nHXjbgof3MymHTgJmRAQ@mail.gmail.com> <ad2rYH9tUPthHFoj@yjaykim-PowerEdge-T330>
In-Reply-To: <ad2rYH9tUPthHFoj@yjaykim-PowerEdge-T330>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 14 Apr 2026 11:28:46 +0800
X-Gm-Features: AQROBzBcwys1sJE14-sqswOYWhGVy-YykuPt2kRn0gHSFefB_BbHyO5y_ejkPqk
Message-ID: <CAMgjq7BO6SLZPfNXDh1F-7RAOqDAfqMQ4PM=qjAq1mCsWyD0LQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: YoungJun Park <youngjun.park@lge.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com, 
	cgroups@vger.kernel.org, chengming.zhou@linux.dev, chrisl@kernel.org, 
	corbet@lwn.net, david@kernel.org, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jannh@google.com, 
	joshua.hahnjy@gmail.com, lance.yang@linux.dev, lenb@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, matthew.brost@intel.com, 
	mhocko@suse.com, muchun.song@linux.dev, npache@redhat.com, pavel@kernel.org, 
	peterx@redhat.com, peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org, 
	rakie.kim@sk.com, roman.gushchin@linux.dev, rppt@kernel.org, 
	ryan.roberts@arm.com, shakeel.butt@linux.dev, shikemeng@huaweicloud.com, 
	surenb@google.com, tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15285-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,lge.com:email]
X-Rspamd-Queue-Id: 03F4F3F5478
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 11:05=E2=80=AFAM YoungJun Park <youngjun.park@lge.c=
om> wrote:
>

Hi All,

> On Sat, Apr 11, 2026 at 06:40:44PM -0700, Nhat Pham wrote:
> > > 1. Modularization
> > >
> > > You removed CONFIG_* and went with a unified approach. I recall
> > > you were also considering a module-based structure at some point.
> > > What are your thoughts on that direction?
> > >
> >
> > The CONFIG-based approach was a huge mess. It makes me not want to
> > look at the code, and I'm the author :)
> >
> > > If we take that approach, we could extend the recent swap ops
> > > patchset (https://lore.kernel.org/linux-mm/20260302104016.163542-1-bh=
e@redhat.com/)
> > > as follows:
> > > - Make vswap a swap module
> > > - Have cluster allocation functions reside in swapops
> > > - Enable vswap through swapon
> >
> > Hmmmmm.
>
> I think this would be a happy world, but I wonder what others think.
> Anyway, I'm looking forward to the future direction.
>

Yeah, I agree with this.

And I do think swapoff of the virtual space itself is also necessary,
we really need a failsafe, e.g. a clean way to drop the swap
cache and data, kind of like drop_caches or shrinker fs are
commonly used.

> > > 2. Flash-friendly swap integration (for my use case)
> > >
> > > I've been thinking about the flash-friendly swap concept that
> > > I mentioned before and recently proposed:
> > > (https://lore.kernel.org/linux-mm/aZW0voL4MmnMQlaR@yjaykim-PowerEdge-=
T330/)
> > >
> > > One of its core functions requires buffering RAM-swapped pages
> > > and writing them sequentially at an appropriate time -- not
> > > immediately, but in proper block-sized units, sequentially.
> > >
> > > This means allocated offsets must essentially be virtual, and
> > > physical offsets need to be managed separately at the actual
> > > write time.
> > >
> > > If we integrate this into the current vswap, we would either
> > > need vswap itself to handle the sequential writes (bypassing
> > > the physical device and receiving pages directly), or swapon
> > > a swap device and have vswap obtain physical offsets from it.
> > > But since those offsets cannot be used directly (due to
> > > buffering and sequential write requirements), they become
> > > virtual too, resulting in:
> > >
> > >   virtual -> virtual -> physical
> > >
> > > This triple indirection is not ideal.
> > >
> > > However, if the modularization from point 1 is achieved and
> > > vswap acts as a swap device itself, then we can cleanly
> > > establish a:
> > >
> > >   virtual -> physical
> >
> > I read that thread sometimes ago. Some remarks:
> >
> > 1. I think Christoph has a point. Seems like some of your ideas ( are
> > broadly applicable to swap in general. Maybe fixing swap infra
> > generally would make a lot of sense?
>
> Broadly speaking, there are two main ideas:
> 1. Swap I/O buffering (which is also tied to cluster management issues)
> 2. Deduplication
>
> Are you leaning towards the view that these two should be placed in a
> higher layer?

IMHO the swap infra should be doing less, not more, so we can have
more flexible design, and different backends can implement their own
way to manage the data and layer. e.g. Having one backend being
flash friendly and it can do this without caring or affecting other devices
or backends.

> If it goes into ZSWAP, there would definitely be a clear advantage of
> seeing dedup benefits across all swap devices. It's a technically
> interesting area, and I'd like to discuss it in a separate thread if
> I have more ideas or thoughts.

Just branstorm... Why don't we just merge these identical pages like
KSM? Maybe at least zero folios might benefit a lot if we keep them
mapped as RO instead of recording them in swap, seems better in the
long term?

