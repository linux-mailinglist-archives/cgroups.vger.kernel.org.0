Return-Path: <cgroups+bounces-8850-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70821B0DFE2
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 17:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9F51889071
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 14:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455A6289812;
	Tue, 22 Jul 2025 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Y0GlSAr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAA923ED5E
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196341; cv=none; b=F59Ksfu+Vggt1B+KgH9GsDVUaHddjsIeSzigvrym/raX/cSoRJ4Xm20gyg5pRY/ykLwkMcQ5jSDEnZgi30Ym9HD4J3MGIrZjV2yUpkz2ob47+yIbkiaN7iq7l8GV2of8qDkPcXzVoLJ3Br5SSPX8CVH3KoUIqare4PwWQJWDWZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196341; c=relaxed/simple;
	bh=CiqwsXqS9XffgcdUNt4OEyIxE8kyMoj+z790mtcu3ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/k4BuH7WoPA9ux8GOQbrw1b30NINkk0VUaK07SoHonldWzFeC0+gP5gGVWoPBe7kpow+CZRmKFDGfXPuAZ8n5otgKTCFzD0AT7J9XsjAqD+N4RFAkeiLZW1e0nOXts3aBThfMLOuRiDJ5FXXwHJTvxnkDh0EwYenaX4TdYT+9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Y0GlSAr; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab6e66ea68so74430861cf.1
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 07:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753196338; x=1753801138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiqwsXqS9XffgcdUNt4OEyIxE8kyMoj+z790mtcu3ik=;
        b=3Y0GlSAr8a8utCCIcJujOzlyTHCc3LmLw52nYSunHLEXJW3H0KCe6LXQnN18Q2qilM
         6/tPJA9w2oTay3yufSueM1yH7kPgE0SSuYAUUONwcM9uUNXzoOmo20p7UB/m7F/WqAQc
         ZNFVAMOCjaXORWHLrrkXe5c7xaSGy2w6VZPn1Nx+s0EweEC6phi1rafoHMz5NqlQ6P1T
         +snaxOLkCIrsExxcnw37+iH8L4oKDd9e8s9qJ6mGMmqZGDukPrghTzRoMxzyylTwFdB4
         sN/uj2FW2Pm5B8LXYyshytNAVOZe/IoXBCASeyGh5CCsbnZQnK3Qkvt+hQurZuqC5sKo
         iBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196338; x=1753801138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CiqwsXqS9XffgcdUNt4OEyIxE8kyMoj+z790mtcu3ik=;
        b=C+svIb34OhqJDCqLkgPGg9zlDhHpzb7EgdWXoeMQJaJehsi6azNQB3fl4l9azBTvR6
         DbPCVYY/IPYhw5ZG1bS/DPfogml5Z2Evx82bOBhb+wdWWz/HHQ0XZy19o0mcOv4GtwI3
         1jArrGn3hcgLxyXwQVa8jv92+fcZXGf6zEYHmADifm2zXDl5ceq3A2W7ezeZ9zultOtk
         /OUIRZuqe3wBM4j9Z/jUFvm01l+WFJq+h0j5ml0tKLTe3ExIO2uCyafZg9+tNrCcKaTK
         YKZFqoXdzYU6WtYWk7iM7sHsc/QxZurPcvptQGQMfwFHH1CXyGxPecUwZ+pwjlafIXTW
         HR/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWL+8GvYMJtP936sJfIdHTK/5DK+BVQkfkEUhCuml8I+Xf/9fpjVp+ICRYc2+UaWlDkDGO4XuuE@vger.kernel.org
X-Gm-Message-State: AOJu0YwjJd3kiZNeVYb5LWz7A87MV5ivwgTpiP8BnaJiYnQDWZV7SWO4
	CnPgyUMldAMeHrDVt/Av7ER7cfFBsWAGMyUUpArcaC8UqybtvDs44Ocu9LNJqVZXXWOJl1yFF/e
	D8UuW+u6Gt3R/lQTrnxa98aAJNTIqoqtmmsrBrfep
X-Gm-Gg: ASbGncvnd+EdYWecnFH4MiLHMg411HXLH3lDsmU2OKjOR0YE8f6a1mGzDOgiDsqDPiV
	Y7xE8ZFK+G9kYQNLpLrMIxZSuuSComTEfzFXvMbRMbzP8+lIMhW7OAMRCjJIRen6QQEY0jJbV2y
	tF4+KYkzy7UuKfaq+SneOtJZBq3EIOOY5L+1mmp43GB4c0AHJE35v00W45zgV73Iuyfv+3BP2JM
	vaeow==
X-Google-Smtp-Source: AGHT+IG2yg147JK4Oinx02ez69SdDMukiZsmWmT/iPx1WpvOc0p35m3lKJjL6O102z1pXoYruFzug+iTBIemqmhssxc=
X-Received: by 2002:ac8:7d12:0:b0:4ab:7125:99aa with SMTP id
 d75a77b69052e-4aba3e33f4bmr306580691cf.49.1753196338060; Tue, 22 Jul 2025
 07:58:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-11-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-11-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:58:46 -0700
X-Gm-Features: Ac12FXxT4R5nqDZoq6He5N2XHgjugFXTSeJd14lK7mmXsqA2ix7EK8BukOpBfNg
Message-ID: <CANn89iKo45xre19BCkTRQSym7WCWxAbXOD77+F35OJ0eubmdew@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 10/13] net: Define sk_memcg under CONFIG_MEMCG.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 1:36=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> Except for sk_clone_lock(), all accesses to sk->sk_memcg
> is done under CONFIG_MEMCG.
>
> As a bonus, let's define sk->sk_memcg under CONFIG_MEMCG.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

