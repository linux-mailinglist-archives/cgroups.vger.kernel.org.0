Return-Path: <cgroups+bounces-4258-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EB19522E4
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 21:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942641C21EF2
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 19:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DDE1BF32C;
	Wed, 14 Aug 2024 19:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4MzPhMb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090671BE876;
	Wed, 14 Aug 2024 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665206; cv=none; b=JlhitlXEx9LA39iGOyCrUCOeBFpQaE880P7zO+9UXauDtnXSCQMFLoLUsznGZG1M+4tsOJ8zViIPiAvD5uGcTEHx/jTF/xZIZX+qRppGeCh+1KwDopTMRFzOnWgcQDah9kNBYWWzpb4aTIwm7gfIicsqrsiued3lQ+dMP0Tls2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665206; c=relaxed/simple;
	bh=uSjIq/r4PyzwkgBNKf7ed3KQY3P7RYGC1hxdqs9TxZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAu95lJh6y1k4+f6aySalNSy+aAjihfxjUNXYz2YEADDEi5966waia9+7xm7aXQswqjqQk/IjmKzd2bKzy2MIcuaDfaJ+/yFsJyti/acglYbj4eqawlooKV2jVBR5+NVFb81voYsADKWEFzytxM42KLscyZ8KpJCaoJXJY9ux5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4MzPhMb; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-810177d1760so73742241.2;
        Wed, 14 Aug 2024 12:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723665204; x=1724270004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSjIq/r4PyzwkgBNKf7ed3KQY3P7RYGC1hxdqs9TxZU=;
        b=D4MzPhMbvr9paYVoA2OwCnfwtdSU9D8SgqO2/SVRxwchmoKb7aYV9n7cYqP5/1Pd4s
         pRI8UugehdSfJtir1DqeVCiR/UemsSBpOcA8oECs6Wz1/Ct8TCnR4dyJPKCQyWfa/J4/
         F0RuGkXj+z+jLGjMTnS/8IlKwK3oXL3w4n8p8ZoKTtEiFTsddzF/Tk/cslcOVEh/Byfp
         gAmXSnW5kdQ3AOm9SctYwJi9cPtiOvIVJ41L1a5PUslA9nRgJCcjxztbuhpHmOwYuM/O
         gmGNNbIPSwacJmkV4V/ix8wHTMlF9NsHtG3aV9nduon5YgQb3rQ2RvbWyP9bCOZ1DjI4
         RwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723665204; x=1724270004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSjIq/r4PyzwkgBNKf7ed3KQY3P7RYGC1hxdqs9TxZU=;
        b=JwCityBiOs7eguazeqVzkkeXNUyNGlBiKd0MCh6B19bD8r2iQ7TjKZtzQy5L2uTZJG
         qFyXLNEzLrf9i1zcUMyRb+6R06e9O81cMxJoTPlDhTXikI12p0TV+J50X5HtNIzuues5
         RivIQuKraxe7TBPp2W6EKElG9ofc0XUs1iMHZe5BHqZ6a9Rol60dMarobByis+AQc4V3
         6QrXpzJNO5VURJVTdKtmq6cKTe9XqcEJhavDhUuoBgTM5lEz5e4Nnl0Ox6cT3/Oyefa0
         Oos+hFxX1hjSqaYgdvxsIQ4aks9PaHbfS0YeKoSZKovJ3PgVsAD03phISiBFOch9JjUa
         AbVA==
X-Forwarded-Encrypted: i=1; AJvYcCXHF4lcGm2/00OcPncz04J4H9EtSNcJAfK9sjkY2SPVCMA1aha0IVXSkGhOzbelDywikYVXxK9D6BafkP1/lj8xBLGF8Tw16w==
X-Gm-Message-State: AOJu0YykH2iiiCHiH9sD6bSr4ecWX7x6nuYGbacR1bqFbCR4BcJeCjtr
	k7iY35OJ3VRk0mD4JMJ8ZLL7AZTJL5KK3hPHLzBG+SibcMfOpXZX+METZWq7YRB+6zXYDA5KxR7
	kRSOVYbRHADLecAczTnOKxsXiWRQ=
X-Google-Smtp-Source: AGHT+IHR7yvJf1nKzlrEXHh0Ga3j5OYz8Isj2xtCJg4nF2eIcstz6w70mKp2MjrfAcRRrMgJ3DE2iriimSCraF6uXDI=
X-Received: by 2002:a05:6102:d8c:b0:492:ae79:ffbb with SMTP id
 ada2fe7eead31-49759998bf4mr5177184137.24.1723665203752; Wed, 14 Aug 2024
 12:53:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814171800.23558-1-me@yhndnzj.com> <CAKEwX=NrOBg0rKJnXGaiK9-PWeUDS+c3cFmaFFV0RrE8GkNZZA@mail.gmail.com>
In-Reply-To: <CAKEwX=NrOBg0rKJnXGaiK9-PWeUDS+c3cFmaFFV0RrE8GkNZZA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 14 Aug 2024 12:53:12 -0700
Message-ID: <CAKEwX=Nbp40S2o_3gy9K84eWG4bnOxGm9AuAL4aEey22dpibLQ@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: respect zswap.writeback setting from
 parent cg too
To: Mike Yuan <me@yhndnzj.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 12:52=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Wed, Aug 14, 2024 at 10:20=E2=80=AFAM Mike Yuan <me@yhndnzj.com> wrote=
:
>
> May I ask you to add/clarify this new expected behavior in
> Documentation/admin-guide/cgroup-v2.rst?

(and a selftest too, if it's not too much to ask :))

