Return-Path: <cgroups+bounces-3030-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C788D2820
	for <lists+cgroups@lfdr.de>; Wed, 29 May 2024 00:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35DF11C25286
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 22:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B22B13E057;
	Tue, 28 May 2024 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l0fNCeBq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742E013E3FD
	for <cgroups@vger.kernel.org>; Tue, 28 May 2024 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716935898; cv=none; b=OBjGxLAYM6WoLHZ6r7wpsQBmEEcjbhUKLm9Td6HApkuj1/EK0YOq9ltPLeKhbWHhSVah2wrI8itXD8BCBWZ3X1CK5yy7AxSrgeBx8amjMcHSUbscukrcN/UG7x5zPea90oAewU1LYyWW/fwL+Bezjj0fCX+LPbf7FKlHaXgi+SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716935898; c=relaxed/simple;
	bh=hpkQZ9t7zvhQj4+igQU1dTDSRG7tKhoQg25721PahJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkBW5HJDVkBhwCAwOk184aGdQFj/UNXsA13r09U7CLb12ZKyYIJToWiFEoZqFLy70wGu+mC5QOA4UVIXD87muRxlxrlONz2O3R4Ktl9MF0zTxSWAK1iGxuvoUwhzxUN4VoSTK4S8TM6KTaUTy5wih+BEnKyKmycG3z/Cwr40cwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l0fNCeBq; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57869599ed5so1596927a12.2
        for <cgroups@vger.kernel.org>; Tue, 28 May 2024 15:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716935895; x=1717540695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpkQZ9t7zvhQj4+igQU1dTDSRG7tKhoQg25721PahJU=;
        b=l0fNCeBqyyuvbSSYVnUd0J3fZ3RpLmsVyWx7I1s2HW5BYX/5N+q92yY/y4GEYbuzGT
         nSma6wJVV1CpOhufm8PYMzQzQsHXLCTd3HQhoCOEV5h3RPf3/jK8CHn2hrsbFALQGECs
         6dWt0W6HmGWoEcone0cHPMVRmZ/Kn4D0XtH/7zX8fFf1+ZRj7BBADqjpidgnguxtXIsE
         EWqNrfCfbU4wcOQSWiBw681NH/nt6t8s1jgp+zxXDTw5abrrER0fEx9aPu8KhwHdUKfV
         Rh+n87IrHEFT+Uy6N+8KvYVdpU5pkvlK6L+NQ+KEINlODKTel6tBhmUYDhyJSR5NjyyH
         EgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716935895; x=1717540695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpkQZ9t7zvhQj4+igQU1dTDSRG7tKhoQg25721PahJU=;
        b=YmKBUYGucike+7CNoHhXb41eEN1w8N4w3ZEjs4h+ryRTSk8wTK3A9zTb9v1nI1sdP+
         6+HGB+1aGFYHS0JRNmqGj/ba5PxzkqQpQPdMeezkqrqzdFrEVBvAIf0DPsVOcxY2dqV3
         rsjIG19F/gDIVxiBtDI0YGYMnMYmtg/zxsw6AEHBSnKMBtUMUcUS9bnV9U23Ij0TOgPl
         R+0AOFvfXsfrmS8Av+GoMaYN9pFlgmS4HOGG5a3YgqegzcDvuuRI2OysRsWTQyXX/WwC
         tTnuYGiNck4HIQWcysMYE7UFcKK8FTDhTF7Hg4ZWnq5nds7znW97IoykUezFThEUjUjg
         wnjA==
X-Forwarded-Encrypted: i=1; AJvYcCVuQvJLpb13bSJKS3U8hbJg7kdcbmo20WNgyTCYEsJe+6uuktDbDWTvUdNab+D/Pe9NvzpDjoES58l10ZlLtdZT5wfy0cbQCA==
X-Gm-Message-State: AOJu0YxnXNZn2yXfWe6mtsLSbIrxdIKqUoj4SQAlYaHlL9Qo4k6Szuwd
	rBpDMqW56NsN/dLjcW/1wpEjkuolNxheddufBBcdMaiIrHpKtisFyMNfEp++pnZ+eV/xouj3PQ0
	ZUSTg7U8f5nhm7CRGXwPtdS3V++HrrBeOCYU2bqfQwyjAaPq0uobY
X-Google-Smtp-Source: AGHT+IEsVUGpcPGETt1gDvOlijxZMYBiZFSrD6yh381w8L/v31vySeYx081bOW31Ob5Xt+nyVEDzv27lWgmrnj/FqDQ=
X-Received: by 2002:a17:906:55d1:b0:a59:c319:f1db with SMTP id
 a640c23a62f3a-a62640779b9mr865808266b.1.1716935894616; Tue, 28 May 2024
 15:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528163713.2024887-1-tjmercier@google.com>
 <ZlYzzFYd0KgUnlso@slm.duckdns.org> <zrvsmkowongdaqcy3yqb6abh76utimen5ejrnkczd4uq3etesl@jv3xb4uso4yk>
In-Reply-To: <zrvsmkowongdaqcy3yqb6abh76utimen5ejrnkczd4uq3etesl@jv3xb4uso4yk>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 28 May 2024 15:38:01 -0700
Message-ID: <CABdmKX2vmpFS=j_FoFOadHRVVWaWUsReJYv+dJNHosk1uE_Dvw@mail.gmail.com>
Subject: Re: [PATCH 1/2] cgroup: Fix /proc/cgroups count for v2
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 2:42=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Tue, May 28, 2024 at 09:43:08AM GMT, Tejun Heo <tj@kernel.org> wrote:
> > I agree that this can be a useful metric but am not sure /proc/cgroups =
is
> > the right place to put it. Its use of v1 controller names, listing of
> > controllers that don't exist in v2 and the unnecessary column are rathe=
r
> > ugly and unnecessary.
>
> At the same time, the info provided currently is incorrect or at least
> misleading (when only v2 hierarchy is mounted, it mixes the counts) --
> that's what T.J.'s patch attempts to rectify in my understanding.
>
Yeah, I meant this more as a fix for the current interface which would
still be wrong if we added a new file. I intended to find and add a
Fixes: line too, but I forgot!

> > In v2, cgroup.controllers and cgroup.subtree_control govern which
> > controllers are available and enabled in the subtree.
>
> Yes, users could sum up cgroup.controllers contents for true v2
> fingerprint.
>
This usually gets close but doesn't capture zombies, where /proc/cgroups do=
es.

memcg is enabled in every cgroup in this example, so just find all
dirs and count them without checking cgroup.subtree_control
# find /sys/fs/cgroup/ -type d|wc -l ; grep memory /proc/cgroups
440
memory 0 465 1

Last year I found a driver bug that was causing thousands of zombies
which I only noticed from the huge difference between these two
values.

> > I think it would make sense to introduce something in a similar
> > fashion. Can't think of a good name off the top of my head but add a
> > cgroup. file which lists the controllers in the subtree along with the
> > number of css's.
>
> BTW, there is the 'debug' subsys that has (almost) exactly that:
> 'debug.csses' -- it's in v1 fashion though so it won't show hierarchical
> sums.
>
> Michal

