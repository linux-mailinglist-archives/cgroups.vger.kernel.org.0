Return-Path: <cgroups+bounces-8842-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C91B0DEDE
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 16:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61BBB188E96B
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 14:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADB42EA750;
	Tue, 22 Jul 2025 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GLocIx/T"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D562EA726
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194832; cv=none; b=rIQskhL9iGNfkdrsjir8rGbBKbw1dE8bZGo01QESEv4LStNOtBxCu6QPM2uZ0GMQaiJg8P5OzRStBBdtFE0rMp4vAo4fKG7wWKxefRmCpFv7ysKoyL5ss9rwbnhUU/+TyJp+5PgljpHZCHUG/0Ts0ivVbhBPxshi3J9ut3JFbdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194832; c=relaxed/simple;
	bh=1XuOmXMmaaWqnvpqCFWTGZCIySJ+eeucJi/seDLbNI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFTFr6AOUUwWaTk2iI7tfezj4dhTbIA4FMAwdkRyCD5Zxi4TDhhk1yk1npto32DHjnBI6FXoIFDy6ofzqkSsu12NFZEaBtoFwilMKzipYm9mOEJn/ZSZagQdsQfGhPAimTpXoP87dvlX0qv25S+1Um//wof6Pi5YUMBHWHMHNQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GLocIx/T; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ab554fd8fbso52562661cf.1
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 07:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753194829; x=1753799629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XuOmXMmaaWqnvpqCFWTGZCIySJ+eeucJi/seDLbNI8=;
        b=GLocIx/TNETMKHDgXLps1y/0xTwxSr7htq0UfhsD5A8Lh93DkCOuCMaOCoJdA76sya
         5gmRyqf44oPeZzGaSQf4vlaZpaULrqaK4yISNmv8p8UVVCxLNaMRyZdFWIlGs1oGXX2Q
         6es+qa+PU8LZeJJQc6R8+g+6SHwqyRS268SufdyNkV5IEzf+KLcRPDvDy75jXeg+lpX7
         2cY9kPYSbsnljl0hup8diYFXfVUnXhVQtfa69mfkZRvGziZiqcyHCeqXiEL/QPnfp+54
         cPUSKg77bcdtaSikQFQl7NE/VBis2Tz6ZSVytbu8lKx89ruOi4s6JfjNovdvJReSv+N3
         rjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753194829; x=1753799629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XuOmXMmaaWqnvpqCFWTGZCIySJ+eeucJi/seDLbNI8=;
        b=SoOZG+88N31viUd21aY8/IgpbS8SuXxLpCZjzXPo6eqiJ0NR7N2cUpVvyCNvkvc9na
         yVKKt1ZP2zIlLoE87fmPPx79CzHsXUpxDonQkhsB3fvQGSS/ZoJDZwvYjYAt4k0EjhF9
         lr4BpGZO7vfXl6w1HUFclVass7tyiIpVQdgV58SO59Q5TSbFsJlu0xiw4ljYkzYVPFIm
         qmTjewKQDos3hyeW4tG1Q3nZ7LhZWSolOMhI/lQEZGJmu3aA6zsDAXSuao/80vulHxIx
         49dnPB3p45aCVGr+h/KJU6VdLuzenhep2sLaxM6nJZNRPfsXJ27965e3gcZYR88ix15v
         BLlw==
X-Forwarded-Encrypted: i=1; AJvYcCX7mL0NPfHZQ3pt2C57wSRK4uLS3ZkmaDBiuq91csoWRNghFtBhjQ9rFQI0pMxJSznkgyPDew0V@vger.kernel.org
X-Gm-Message-State: AOJu0YxKtrCTX3WoNvoD2xrCkopIuWHV0JA9LoAxAVuKcFbSwh6F81MB
	Sg0jdTPB+tzQJs4OhCdSsYw9l/r1zXYbpbjk/r+sK7ic46XfQkHyM+KAjLGUzYoF85Ym7IFQXgs
	8hwvioIJuCpXWYlnLtda/vDVPa86D2mCT75+MJLTc
X-Gm-Gg: ASbGncsCbudAZWRNJtME8bLhjOn2nR6d0Dk/9QJyAlfG6qGhf8FbHeXNuQFS70iX/OZ
	djMVRBTfkXhCCiJxj0aMTuMo72pstnu4zkYeQSgfRmyZ1tk0nz8Mo8+dURuiywTWnv5fRnGBvNK
	ij0dKPPywAuo9pp1Z3AjTEMHFiDN0jMIn01Ap5keem725WOsDszXfn9/F2Usvla38UKyC+i6GD/
	9WXQQ==
X-Google-Smtp-Source: AGHT+IE5/xC629Z41/ewG1rGRd/vRIyn4/fPdY4AoJKCJUc80AhvNP/9QCPniM9G42/4UNQXgbiL4QSwJejVESK33OU=
X-Received: by 2002:a05:622a:248e:b0:4aa:105c:a0d5 with SMTP id
 d75a77b69052e-4ae5b8c53e8mr53665791cf.16.1753194828653; Tue, 22 Jul 2025
 07:33:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-3-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-3-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:33:36 -0700
X-Gm-Features: Ac12FXxIYBSQCB7BH6twTSCxBz7O9cZS9s2CNGBOnfVcy_wDobXLwLt6phukhSA
Message-ID: <CANn89i+ju=N_JNoCqSMaa7eG-70aXk6ZuNGdjc39cpUFQVvhEQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 02/13] mptcp: Use tcp_under_memory_pressure()
 in mptcp_epollin_ready().
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
> Some conditions used in mptcp_epollin_ready() are the same as
> tcp_under_memory_pressure().
>
> We will modify tcp_under_memory_pressure() in the later patch.
>
> Let's use tcp_under_memory_pressure() instead.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

