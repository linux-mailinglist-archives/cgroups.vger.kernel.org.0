Return-Path: <cgroups+bounces-4377-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0A4958B48
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 17:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15FEBB22960
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 15:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DC7196C67;
	Tue, 20 Aug 2024 15:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoF2/Lbf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552BC194145;
	Tue, 20 Aug 2024 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167714; cv=none; b=Z4F9RSme6OvXy1SMGA1ZnEPl69j7b5ZKrYy+6uvtmeICeNe5Vzrnu9bgkZKtoh/3IMRkwzw44VNbvBr2w74AGG9M/+3h58pcNVAa+H0X8eNyvg5mzDJA/FMDr8prK7TWeu71ycoU+UD/+dBxvv5tf0TWipjDYEkjhmkN5ccydY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167714; c=relaxed/simple;
	bh=y5Ia15R1fE4O56YNp2nFk/C9bDA7ReCdChu+/M43J94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0cF85eyDsQOGJXJdhgFfkbDu+BcLgXT54DgZsvBZoQ5HwlHWBarKPlMeFC+2m33L8JfOtGEU5OC/sHFuK1IRgtOca1rNrMvNuTg6+gX7JUlL/i/1eE9srSfl1BGAN6CaUlvlmSdGQszv6ggNTKtTL91fWYa8xYQJAlaM15zRqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoF2/Lbf; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6bf784346b9so26116456d6.2;
        Tue, 20 Aug 2024 08:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724167712; x=1724772512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5Ia15R1fE4O56YNp2nFk/C9bDA7ReCdChu+/M43J94=;
        b=MoF2/LbfUBB9X2s7RCC42cs2uHIZYy3h4nk7t8Sn0S4ksMz/2AWFQKS/GE6oAxUA8c
         ZhnUlyNRwwgfLFGaB5B7mYJtvXyqT01mDiyGD1Mowl5ZvXd/zSo97MGdcT1G0J2J+Lr1
         rUAvHDZX9s3Yh9gQu/CvcSzrTrlvDIPrbHn9ZzTMky3vp840jnMF35QseKAF8SWNtrpr
         lKav47U+x7cKCwrBODGwRtzT8Fxy/mi5TScnZlrUvjV741tookvQFBM8RemXZEqL68+Y
         Cccj/40PPj9O9vnmeeBbWkEoIdhOD5V4ZxADxwmOkekCwrwAC4wGxGcs2fWt3XrkDyJI
         UuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167712; x=1724772512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5Ia15R1fE4O56YNp2nFk/C9bDA7ReCdChu+/M43J94=;
        b=cJLJxbWd/J63ICbjN2mSTw+tTE1RBBXVy1VaQYonvKBS3esWLn4tmIOPKkxVEMzq6K
         wxSG6JJ3BsmYsUQsfnakDrMCaPez2kP0NFJS6h6gxT/7xLNulourC8zzDMdGynfGSMuU
         y2myQ+1bXUQ/M9nZarexs2AsQ/E1x+RPcp9PdcIBv50YijrUaqZ3PSNNW3S80r+xqCJE
         fxWgYkcyUgiEYz6KMfJx3QYywUmMLpM8Q/3fV8vrVRZP+alttKoY+VKTRZadFjKMaqeC
         NCiTzRiYQ6smyUwB7l+oYqEMWTzjOKETsuytFMyD5dgjq6m3Iuxb1iw9rTzKkZe+xv5C
         v7Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXAJ3lLqf/BGkj7NzAL2Ng1t06cYa1jk5fmd1xvVFC3cuJWdcHT1zCIrk6tT8ZszFcEUdhb+FtrxZyn2vRAYdKJpPqyx+R5LiHvVriVLW7UAQOGJuj4NuGPqUGamiqToRcBQAZGvg==
X-Gm-Message-State: AOJu0Ywq+Oog27dEpd1fmUqfd+W7OqWkBQ09dZMk2pRUp27rC5qew5pO
	LF7rHKOl28PbEmPLy5yzfd6fp8nrb2RYn1oY3xduif4+rLJsW11GXb6re+2kuzs9+gFaKUVGjG9
	PWn4v/dAYo8uN1j24kwqFE7xMypg=
X-Google-Smtp-Source: AGHT+IEqV9KEp2q8t9Yhwj+Novgkh6GlV2kQA5X+VhM+qBpbdD4m3xNHVA7TQ8IloKWoot40nDKdLpQ//xqy6n5FrqE=
X-Received: by 2002:a05:6214:4608:b0:6bd:70ce:e413 with SMTP id
 6a1803df08f44-6bf7cdef914mr179802206d6.30.1724167712113; Tue, 20 Aug 2024
 08:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814171800.23558-1-me@yhndnzj.com> <CAKEwX=NrOBg0rKJnXGaiK9-PWeUDS+c3cFmaFFV0RrE8GkNZZA@mail.gmail.com>
 <CAJD7tkZ_jNuYQsGMyS1NgMf335Gi4_x5Ybkts_=+g5OyjtJQDQ@mail.gmail.com>
 <a2f67cbcc987cdb2d907f9c133e7fcb6a848992d.camel@yhndnzj.com>
 <CAKEwX=MDZdAHei3=UyYrsgWqyt-41_vOdCvTxj35O62NZhcN2A@mail.gmail.com>
 <20240815150819.9873910fa73a3f9f5e37ef4d@linux-foundation.org>
 <CAJD7tkZ3v9N1D=0SSphPFMETbih5DadcAiOK=VVv=7J6_ohytQ@mail.gmail.com>
 <CAKEwX=Pz4Pe-CAevBvxUCpPZJ-fRseLN4T35Wt3mb84gqCY25w@mail.gmail.com>
 <CAJD7tkaY3FsL-9YeDuVG=QtCK-dgm71EJ2L_T3KfGUa9VW_JkA@mail.gmail.com>
 <20240819180131.27b0ea66dd50b83c85102540@linux-foundation.org> <CAJD7tkY5u4vYRytMb+nuW3VhA9xHEPVux=vv_+k9oA1haFxa9A@mail.gmail.com>
In-Reply-To: <CAJD7tkY5u4vYRytMb+nuW3VhA9xHEPVux=vv_+k9oA1haFxa9A@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 20 Aug 2024 11:28:21 -0400
Message-ID: <CAKEwX=M-BDNNJo5-LXj3iR51BksH4t-fZhFDD4Kt_DvNqj7oUQ@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: respect zswap.writeback setting from
 parent cg too
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Yuan <me@yhndnzj.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 9:07=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
>
> It's commit 501a06fe8e4c ("zswap: memcontrol: implement zswap
> writeback disabling"). It landed in v6.8.
>
> I suspect there aren't many users that depend on the old behavior so
> far, so I would prefer to get this backported so that it's less likely
> that more (or any) users start depending on the old behavior.

Agree - let's backport it then. In hindsight, I feel like this is
already what users assume. We don't rely on the assumption internally,
but at least one client of ours has asked for clarifications about
this.

