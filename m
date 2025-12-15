Return-Path: <cgroups+bounces-12356-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F87CBCF7E
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 09:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 73DF73006FE9
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 08:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE3929BDBD;
	Mon, 15 Dec 2025 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIBW0vTl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4222765D4
	for <cgroups@vger.kernel.org>; Mon, 15 Dec 2025 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765787697; cv=none; b=CB97jBvhaKKP9pAuPfzT4fakeRt0/J6xAgzYlrrUgFMTP1KihyxsULOEB5n7jhSlnCqAONADKVVgn0l4HyzyCzj1jYdv8dI81oarlF89obdI4HtcE3t9keQsBtEAi6Y+sKo8o1aKLPqMbVHJrcUPjxmT5GGPWvoE3OxHN2kaO8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765787697; c=relaxed/simple;
	bh=zBgyeGbHN2SodTK0wWtpIL1GUBJVvlQwCc+Aeou2HCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYCpvocRgJsYk9ZviUL4IfugQBiRWs8JfDWe24tHSSJrSgKgFk6q40ZXnGf2Hp7FBLlwQtnl5ZOaIOIsyqaApKOyMJIvNcd7KGV3+aAYjSzjzugtP891ubMSQpT8xkqc8mdIrLKknMC/KC5oAtRozAhSbXVPW6q3nYWxj3cmmSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIBW0vTl; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so5501717a12.0
        for <cgroups@vger.kernel.org>; Mon, 15 Dec 2025 00:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765787694; x=1766392494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBgyeGbHN2SodTK0wWtpIL1GUBJVvlQwCc+Aeou2HCw=;
        b=BIBW0vTlyCAC7hQIC9vtHWK73YeQa5uVP7fJiUyDdaywDzIKMXkMD5ffuQ/aLjrSUw
         tyWO0NnTndMEXjFCvRK8h9YugmkkZ2BzEf1iW1DDvzQeGg97nb/pikXYXprfOOXmVr+g
         pXpRUV5OaEj0iKxIJU2izI4+WWxC1fc/t0yFGLv7L96MrBT+IJVyEh31Od1pV4cmB+qS
         6xP+CYpWf6CMzewly2iqT3uNjikymblWjqJFClQ5rEd0V3BlNpiQlAEX0uSG7n8MdtDT
         ObrA8/Zy/s0Vq8PgagpC+ElNSxQ4/bRSCIKvaKP74MrBrQOzDA8OAKm8XS2SOo8Mq6Ce
         0+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765787694; x=1766392494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zBgyeGbHN2SodTK0wWtpIL1GUBJVvlQwCc+Aeou2HCw=;
        b=CFkjs0LSjdbJ4aNuK0bYN9Agttz3l9fyxShZL7V1C6rb4KRtc57ZVmqQ/6MA0K8nRE
         u+drLvWaOeuqqcP9k7xZCp9onfYg4gYRQskZVEH/2UqJpvqSuRTEB8qTTXB9bdzkist6
         gGRAoSlhfwB0TWQ7BtFeGvYdYYp1noyKoUI+l6UaM9AHFpYmtnkaMavY1u36qrha6a47
         XelOK8oscjy1Db4bY546A7YicU1oHUTRXdQjo6Fp9RnVskbHHpXTI8uISl+p6eD0U9Ts
         oo5a4PJUUVjyembulSHB+kbXbvBxbUYi1QHgfT5zl2UDUg7Xur52leUSHgnIIH8Wo8Vn
         bhsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp/6nCF+BvusFtz2xqw8KiwviEKHceNzWZf0IhDobQ+v/dd2xUAAkEyfQOZGFPFhZjDeAHHNIU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7LTp0l5vFIF2qyeXOT4JN1GkJ4MI2ZfNk1EpxN1nJAKs5HFzp
	V7+24SsvjoLxszo9p3jBgm28g8acpnavHQgwmRbzdzz7oiukPuxS7CfRoDAouxrFB+nQt9nLCN0
	J9DWbSoNga8iIy0jXfkY6NXT+EcAeudg=
X-Gm-Gg: AY/fxX5KDP4tKLMyY6Xhbj5octrccaNCPLxqPNLNCEAzySsRX7Ax/eKQ905VJxqyS70
	S8MFWoWOFhfkXMJjbRomKW7v5p4r5c5zB8fse7jMr1uMcnyUmCv8spTolOQUuigHgPeTgZAGBv9
	DEBF24UPXkNdhiFgPMbyKIJ2Sq0MJKUHRHIw8zYjthAH0ExvGh58+QHZgMSMmUj6nOkR3urUiov
	ct0k+jorZWj2zvW8MoZu06bXpFuKfQngHeshfIyLKn+75MjLFZchYjfTcq07Rzicpt9lmC5SVjL
	9XtJr6GU2B+cD/snalP6blYNkZs=
X-Google-Smtp-Source: AGHT+IEdPsw6LWLnZVtbzbSshokghbt3uunpoIWpZ93Gd6GvGnig9P1J7Eq6pzuEQ16kDkQJ8DmhLycdKIVNGPz3TCY=
X-Received: by 2002:a17:907:9618:b0:b71:ea7c:e4ff with SMTP id
 a640c23a62f3a-b7d235c7ea3mr895067366b.6.1765787693758; Mon, 15 Dec 2025
 00:34:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215-mz-lru-size-cleanup-v1-1-95deb4d5e90f@tencent.com>
 <3edf7d6a-5e32-45f1-a6fc-ca5ca786551b@huaweicloud.com> <CAMgjq7DVcpdBskYTRMz1U_k9qt4b0Vgrz3Qt5V7kzdj=GJ7CQg@mail.gmail.com>
In-Reply-To: <CAMgjq7DVcpdBskYTRMz1U_k9qt4b0Vgrz3Qt5V7kzdj=GJ7CQg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 15 Dec 2025 16:34:16 +0800
X-Gm-Features: AQt7F2r4063AFjyBxwSsydfHRTXqRFdqQ-4Mr0P5UbG-7JLS5WKSYc4t3qrG5Lw
Message-ID: <CAMgjq7CLw3Sq780qDo_ANtNxNC9EgB+5bKbAAQD5YLDPMcSZMQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm/memcontrol: make lru_zone_size atomic and simplify
 sanity check
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, Hugh Dickins <hughd@google.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 4:29=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Mon, Dec 15, 2025 at 3:38=E2=80=AFPM Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> >
> > On 2025/12/15 14:45, Kairui Song wrote:
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > commit ca707239e8a7 ("mm: update_lru_size warn and reset bad lru_size=
")
> > > introduced a sanity check to catch memcg counter underflow, which is
> > > more like a workaround for another bug: lru_zone_size is unsigned, so
> > > underflow will wrap it around and return an enormously large number,
> > > then the memcg shrinker will loop almost forever as the calculated
> > > number of folios to shrink is huge. That commit also checks if a zero
> > > value matches the empty LRU list, so we have to hold the LRU lock, an=
d
> > > do the counter adding differently depending on whether the nr_pages i=
s
> > > negative.
> > >
> > > But later commit b4536f0c829c ("mm, memcg: fix the active list aging =
for
> > > lowmem requests when memcg is enabled") already removed the LRU
> > > emptiness check, doing the adding differently is meaningless now. And=
 if
> >
> > Agree.
> >
> > I did submit a patch to address that, but it was not accepted.
> >
> > For reference, here is the link to the discussion:
> > https://lore.kernel.org/lkml/CAOUHufbCCkOBGcSPZqNY+FXcrH8+U7_nRvftzOzKU=
BS4hn+kuQ@mail.gmail.com/
> >
>
> Thanks for letting me know, I wasn't aware that you noticed this too.
>
> From my side I'm noticing that, lru_zone_size has only one reader:
> shrink_lruvec -> get_scan_count -> lruvec_lru_size, while the updater
> is every folio on LRU.
>
> The oldest commit introduced this was trying to catch an underflow,
> with extra sanity check to catch LRU emptiness mis-match. A later
> commit removed the LRU emptiness mis-match, and the only thing left
> here is the underflow check.
>
> LRU counter leak (if there are) may happen anytime due to different
> reasons, and I think the time an updater sees an underflowed value is
> not unlikely to be the time the actual leak happens. (e.g. A folio was
> removed without updating the counter minutes ago while there are other
> folios still on the LRU, then an updater will trigger the WARN much
> later). So the major issue here is the underflow mitigation.
>
> Turning it into an atomic long should help mitigate both underflow,
> and race (e.g. forgot to put the counter update inside LRU lock).
> Overflow is really unlikely to happen IMO, and if that's corruption,
> corruption could happen anywhere.

BTW, I think maybe we can add a few more WARN_ON at LRU destruction time?

