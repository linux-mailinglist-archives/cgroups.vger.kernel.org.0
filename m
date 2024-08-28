Return-Path: <cgroups+bounces-4540-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C58C6962EE4
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 19:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048A21C21731
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 17:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F701A7AE3;
	Wed, 28 Aug 2024 17:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yl1hoI1/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B6E1A705D
	for <cgroups@vger.kernel.org>; Wed, 28 Aug 2024 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867375; cv=none; b=njMsvKDVcylO9s0UC4Q8HRKHzSsiR9N61lqD1hHPjK91ZhoVGdyFMhaRi0M+fgfgS3Z/vs5GNJhXnYUZNEk4DidUWAOiLtonJBt/4fT7oIALfM2DHVfwniuM6LO8Mj/ANLkGKqVUwazXLLEZ0ls6i4BHBS1RpleLUyp8dnw2iV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867375; c=relaxed/simple;
	bh=aDE3/DKrfhnHsPGNKsCJRM7x+xvPEnRxpqQ1AnnBWEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlAz8KF0N/m6lz9mRfrxUG9VSNYDv/RhDZMqFcssoWnuX8dGGyFFdIJZrAFDHySStgufotPyJh4Be45ywKdjuyYm6Zc5zrUfANyPl2Xh6p8DgNbaXP1ISp6zeEhHLrLeoibfmLqkhd8TV4dUgLV8d1+229Pn3AI8c9yeYPrncLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yl1hoI1/; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4567deb9f9dso20371cf.1
        for <cgroups@vger.kernel.org>; Wed, 28 Aug 2024 10:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724867372; x=1725472172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDE3/DKrfhnHsPGNKsCJRM7x+xvPEnRxpqQ1AnnBWEM=;
        b=Yl1hoI1/AKZX+2PZgX9yFpOqwy3oYnjGxeseiv5tD4RxStrr2bEhMA8xc1fI4/8ptP
         +ieCH5CLO6d1rBVhAhY5YF7FVXYulCngzSIFQW4mwNjQFoCXVa1VbitJce1ZQ56PalIl
         wfqb/csg23vsR5VxWra4TdE44B1XP8Z3bBMSL/GWCmlPx/UIb+gT9U/VNYV5QJuHGth6
         tovIzlyPBc6kANsG6nexaEtvXZRFoEBIDzd9pcTp1Pr6bCZcU1X8dESXAlVy4PpJwf5F
         4NJgkM4liEgm0A5ha5rpR0a3YG2b/jjP/irsFjBIJGCxArMWvAhZ7EBUlc6kCcLhM9tj
         zroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724867372; x=1725472172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDE3/DKrfhnHsPGNKsCJRM7x+xvPEnRxpqQ1AnnBWEM=;
        b=QgblLlrVT4LhSvuJOwTAitkDVWTKHN79d0cNwiF9sxjLFQi043H3Ut5E/WAZZSiyvc
         LGgT3UUKyaVEG83yV0F7xdKl7t1iqiKaua7WktuXnxfuKWgG2qMGhUHlVPkq6cLBDiRz
         Lv01Tvk4/8fmLvJbV4xpVN8vQYvPltJO1oraRXOCExPveqV7bww1EETNuaFO/Re+mSg7
         ymOzrjFlsnbY8sVugtfkF8KdHTxnvb9U61VBAd8FKk0diRv92piMLdZThyIts4qAp0xr
         h9WkJysO5D4QIz1MpUoyekXM1p1pjlamudpXV+Z6u8HyAARoncOUTrNfBuPWdXC+V9s/
         rUpg==
X-Forwarded-Encrypted: i=1; AJvYcCWmTJpJBjp6FDLjyVk4Q8bOQ8ZABkaK8703w3nvV5bAzgYcZG4Ia1Op4OoBuPyoOLYwlCyqpWLy@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmkaadx8kXIQmZ+9E3jCLltiMCn0FsaRKvO/gtxCyQ7xDH/aZP
	7pleMr1gKFy+wTM4P9JrAhaaFXumUBhXUOmtX6W8LmlhDS3goIB8fFFrNouePIkwzUeYsQEj2OV
	DqLABjoEVCGbFHYwGuDELq+Gc4/vsABFht8VUfPuHN7KQknXmGA==
X-Google-Smtp-Source: AGHT+IG4aL6108P6ITzETjngxN9DfIkjrJd7iPcDgQ+blSAFzi8AqbC0n0lCxGYQ4Dl+bUU1WJUlKUcFIvJPftTyGXg=
X-Received: by 2002:ac8:7d4c:0:b0:453:5668:444e with SMTP id
 d75a77b69052e-4567fbbbc61mr100361cf.2.1724867371883; Wed, 28 Aug 2024
 10:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827230753.2073580-1-kinseyho@google.com> <20240827230753.2073580-5-kinseyho@google.com>
In-Reply-To: <20240827230753.2073580-5-kinseyho@google.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 28 Aug 2024 10:49:20 -0700
Message-ID: <CABdmKX0kVYj6a8wntFoi1nZ0UfjKR9Y-oLfoOO_a_XhisuN-xg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v3 4/5] mm: restart if multiple traversals raced
To: Kinsey Ho <kinseyho@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 4:11=E2=80=AFPM Kinsey Ho <kinseyho@google.com> wro=
te:
>
> Currently, if multiple reclaimers raced on the same position, the
> reclaimers which detect the race will still reclaim from the same memcg.
> Instead, the reclaimers which detect the race should move on to the next
> memcg in the hierarchy.
>
> So, in the case where multiple traversals race, jump back to the start
> of the mem_cgroup_iter() function to find the next memcg in the
> hierarchy to reclaim from.
>
> Signed-off-by: Kinsey Ho <kinseyho@google.com>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

