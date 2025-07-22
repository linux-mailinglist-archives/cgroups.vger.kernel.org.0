Return-Path: <cgroups+bounces-8844-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 506F8B0DF2D
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 16:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5FC8178310
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 14:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14052EAB7E;
	Tue, 22 Jul 2025 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uEPDA2hh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0404E2EACFD
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195048; cv=none; b=PMAI285I5qLgDxP+2M9vhoWHDAygg/ohYp9cXSWwhE6+t46eQHvjuB/rU/v5NjQOYXMcqHsz76/A2jeSYZ0p/z8gYpL5T57PW9N1cRY9r64r710P4gS6hcPQESMvXo5hUm7hkNoa0TfiOCEX7yVFO5HRrVwIN1bgjvOvph5Lea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195048; c=relaxed/simple;
	bh=ogGcW5syfHAy99iS0KaNWz31X1S4P+kdHYMMRHVaghw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUPOt89noI01P84hmHyhUcVwM4Vjv4JMTxbwlQtk+xvY453wa/SnpJy32Lz5PADxhG0JqQuOg6yV3iREOf7IKnvrvVSL2Z5olDGRM+WL8WJOlFfK2ZTy+fEG4TJ2CSNG1ZW7FAgdljVIGVmEW5hkPEYkqQs7NalcZ3MwJqHgKhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uEPDA2hh; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab53fce526so80250561cf.2
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753195046; x=1753799846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogGcW5syfHAy99iS0KaNWz31X1S4P+kdHYMMRHVaghw=;
        b=uEPDA2hh3+hfZRP2i8+wlNDmQJKiJVvJGkS1Q8fFwdGAqNBgqwLo4AYVxCMOLziRCD
         Nt1fA8pJu9NoM6EmanaeMMeKbi7jb3gg83G134+43V4XSZeZ59LklXCElE76iUrv7cEL
         RRwv7KofUqSQZtWl6HD+s9REWcyRuuPll+/ILM3++QnJL7GKnuj/E+7HLyDDHbxtEHil
         Lft8B42T1ivBzeTFvOu9TkKJ2Kqa8U0ONSYZ+JA0S6Me/ZXaUVApGDvRXV0Ah472/pfP
         25biVFyMjnc0Df/67lujZlMaM74K3+V2mLgL8+HCwEYuW5sUuOr0YSzZV1L1Kq3U8IFk
         NfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195046; x=1753799846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogGcW5syfHAy99iS0KaNWz31X1S4P+kdHYMMRHVaghw=;
        b=r2nIRTcQa5QMBfzUvjL8slg8UiWIUzGjut1xeXERMvPXJLE72eM+GmHvKLTsWLbLo2
         /w5k9LXjYVUd9YCvCkrFJoWnE7UydDrOHk71jxwOYqPIedlImc/xXIeRJqxtIxtvim77
         IP1iiECL9KQmI7R2j4iJOtZ1yMB57XgC+pwp4YWdhegYeXB9g5U1+4PTknDiAQ4ePl8A
         +5oNpK5+o4g9eap+tUMYruBV1t4FgveytlYBJdfbM5auRl9ui3Y9uz+TmiMSReliULVt
         hvMqhsAnKqDfjC0qw8v9nKde/pRJWcN71CvIyX938k4xiJkGZhf8OMwkzhd8JJWYDocq
         K3TQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/BKCdWHnOWqEhf+3S7B3e2BBASGtkdaSMe+OosCJyjPa9EJwz7qPqE9ee/Yz/VVl7dTpWpe5l@vger.kernel.org
X-Gm-Message-State: AOJu0YwOZUhMw3VGEzX3VJaf63m1ufuevseUmO2QjBdxWINKAdr4uYax
	TfxcXZekBSYoZDwrITVj3orYIowP/+J4TFn4jofo+ST3JGaTNgpuTnjzh7EIYq+5qXBPiHB2cul
	Xi9STfD3Fzqt+gtYNTlqyPQ7u0xVTSMDkiOL50/xh
X-Gm-Gg: ASbGncuO7mI0NP2kNxrnQuKVqzK521041/Fgv8u3Gnmh9sNhSZ5gy5aqiqgQrR1VWwX
	eA+/kUMwVGL2kOYuZwhbFsGlmcHs3XferPWkK/ljXRh4o2ZkPNqFm000kReFoZZ08GN7sdcOyzp
	akaM4LfLBtKP0WPVv+oAcTkNVUvKw6atv/48L7UQ1qDXN60Q6r7Zwz19xBugnz2350HOVTinRAe
	RBOzg==
X-Google-Smtp-Source: AGHT+IHh/lY3G2VVyGGsILbI95GYxwwe31jY4DMEtEPuVbiqIy2WoiqiCRLo4vbR/BymSRXtvDDARRkbJMlep7SRIZY=
X-Received: by 2002:a05:622a:5815:b0:4a7:6ddf:f7d6 with SMTP id
 d75a77b69052e-4ab93c7d56amr387332941cf.10.1753195045666; Tue, 22 Jul 2025
 07:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-5-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-5-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:37:14 -0700
X-Gm-Features: Ac12FXw_PVmGWG71LBM_RvH4ODSBv72aWxnT33PfI7UhVcDC69sZUBCPONqRMjA
Message-ID: <CANn89i+p45mE7MTEmf+_fYA_fKXnzMRXiDXNDdkrHVimcYMFRA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 04/13] net: Call trace_sock_exceed_buf_limit()
 for memcg failure with SK_MEM_RECV.
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
> Initially, trace_sock_exceed_buf_limit() was invoked when
> __sk_mem_raise_allocated() failed due to the memcg limit or the
> global limit.
>
> However, commit d6f19938eb031 ("net: expose sk wmem in
> sock_exceed_buf_limit tracepoint") somehow suppressed the event
> only when memcg failed to charge for SK_MEM_RECV, although the
> memcg failure for SK_MEM_SEND still triggers the event.
>
> Let's restore the event for SK_MEM_RECV.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

