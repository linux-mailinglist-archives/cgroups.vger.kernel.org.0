Return-Path: <cgroups+bounces-1246-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE04C83E3D6
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 22:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA1B28737C
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 21:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7E9249F4;
	Fri, 26 Jan 2024 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kSbqh9Wd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1102724B29
	for <cgroups@vger.kernel.org>; Fri, 26 Jan 2024 21:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706304063; cv=none; b=LPyewVAExN7OUrCFO0D4O+82L/hmevQPh/qB3QH9X2AGLhllgmvWuUwb3LOZQyMX69TUW3TumCiK9WMP5Zkqjc0sMTcN6dp0iwdx0O4yO8p5oBrZmy/GnJVhAA8QQLkvjz0zzmxRmbc4Ww8MRTHPJ37vHRzGKkOwvONg5O7zOLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706304063; c=relaxed/simple;
	bh=jqSQ6/JqtbJ7/Z4GvmSnpd6osmjgOZaJXviYh+bhU2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkVO9J0I7a2WrBYcQwNDgC8f8VuJuLSlEKYpHLbYGt3Y72FFujet9EZNM75wkooUQGz08/z0c19+FZdwKQDMKA6uI/jViaeHCWjIwbZDYOQtO1WwASeCDnH0q7CMyq5CO9HXVWA8oCCBvs4h15XRVO4cgO5tN3ZSirl7VU0eZcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kSbqh9Wd; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5fc2e997804so9249477b3.3
        for <cgroups@vger.kernel.org>; Fri, 26 Jan 2024 13:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706304061; x=1706908861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqSQ6/JqtbJ7/Z4GvmSnpd6osmjgOZaJXviYh+bhU2c=;
        b=kSbqh9WdjGyT1UGrfEzwGQc8VI/hk3+HrnAM61tz+aUJq0sRga23uPUefTE6HEtWKB
         148wRpWZ0WUpPPee25txZoKouZJYjxeOCLAMJxu/w9cGdsJ+1bNi3FwNoGVoXRh+O3eW
         59gZSzYfSa+RfJ2mamEaowm3nJH8zZgsMM9okKNqOEC00MiJoHKrgxrsDC9Brh4aBwvj
         b9yLQcgu0l8OSdv2ew/IAodBzAgVCC6vc9gLoTk4LPhkecNoNPxSGWecDGyitN6WQbIu
         AEHdD9Q65kN4R1PE9zZz6kUX6W5L0crbpE2FuN21EnPBsk+Up5vTw0X7w1XKhFzYUwPQ
         rSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706304061; x=1706908861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqSQ6/JqtbJ7/Z4GvmSnpd6osmjgOZaJXviYh+bhU2c=;
        b=DVIcvtplTsb5lt4pYNCfWggQirThWg11dYcj2eJA0VAoRQn5tNtEc4/yMF0OHJKWos
         sVCmjP7m6aDPesDFI76eHXjRErUa28icvqMVXHvg0rwJkWgSH33g6FFtjF5GQlM7VaRk
         xlu4qCPMYXtYCCzwmHVfXIFh0Tb/J4zFIF2LINg4z4Zs1/vyh5BWTkhswgJgE0nKT8UQ
         J1cnJrJO4yInz8e3UGMibMOsP8Z7It8S3xMg2qCZv9m7QhJ0AinCLDYm8Zq2y91yuvRq
         KzCpP9GFuwOtuOGo76oUeJhipjb92B0y+uCDaUH+8inFo0aX6XBIkP/0dHvqufvEVVsR
         Gyrg==
X-Gm-Message-State: AOJu0YyAMiof+KaBb6GbPUg51V3F/3OvDQYauVONohdpbyZ0y/ypTiNn
	c0iF1vajCg7ViimAWkC9IW8k7qudaufUjZnI5Irls3X+NqcLMdPOHbO4vWix6sa7SYSsM1p0g8i
	qZnlNo2wlTSScab9rdSoUbAaldMELDN9KbdLpOCkN0g/7tOiC3lZ+Bl5V/g==
X-Google-Smtp-Source: AGHT+IEInO9IEFlzJRr6meAiSq4E2PgTyFNhUdgistQTybmuwE3VxXUiMiP/g5jRNnh4t1nO1wKJjTxi1oFnyckHOss=
X-Received: by 2002:a05:690c:f8d:b0:5eb:3851:2bba with SMTP id
 df13-20020a05690c0f8d00b005eb38512bbamr522536ywb.41.1706304059761; Fri, 26
 Jan 2024 13:20:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126203353.1163059-1-tjmercier@google.com> <20240126210642.GK1567330@cmpxchg.org>
In-Reply-To: <20240126210642.GK1567330@cmpxchg.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 26 Jan 2024 13:20:48 -0800
Message-ID: <CABdmKX2mZwVHSvJekT8UNt2a0WiiNnTTW-ZV=ZHvx0D1PoJuhQ@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: Don't periodically flush stats when memcg is disabled
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, android-mm@google.com, 
	Minchan Kim <minchan@google.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 1:06=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Fri, Jan 26, 2024 at 08:33:52PM +0000, T.J. Mercier wrote:
> > The root memcg is onlined even when memcg is disabled. When it's online=
d
> > a 2 second periodic stat flush is started, but no stat flushing is
> > required when memcg is disabled because there can be no child memcgs.
> > Most calls to flush memcg stats are avoided when memcg is disabled as a
> > result of the mem_cgroup_disabled check [1] added in [2], but the
> > periodic flushing started in mem_cgroup_css_online is not. Skip it.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/mm/memcontrol.c?h=3Dv6.8-rc1#n753
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D7d7ef0a4686abe43cd76a141b340a348f45ecdf2
> >
> > Fixes: aa48e47e3906 ("memcg: infrastructure to flush memcg stats")
> > Reported-by: Minchan Kim <minchan@google.com>
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
>
> With what Shakeel pointed out resolved:
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks Shakeel and Johannes. v2 is here, hopefully fixed up correctly:
https://lore.kernel.org/all/20240126211927.1171338-1-tjmercier@google.com/

