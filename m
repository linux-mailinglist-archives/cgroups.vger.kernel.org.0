Return-Path: <cgroups+bounces-5471-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA739C0DB9
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2024 19:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397111F22AE8
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2024 18:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92938216A15;
	Thu,  7 Nov 2024 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHc/Vz3C"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6F8215C6D;
	Thu,  7 Nov 2024 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004088; cv=none; b=aNE5L4Kib3tdhX9XGryh6fsO5CQ+jZfKRvEvPFG9iRFoOTPC1KIe3jzFkmUltejD2Q1VBuQbavMkNKME9Z3x8mUGOnhSz7PtyajK1qotBakZBP+8aqO2GOdb7Wv96z1MIkWuAxRTxMGtCERRc2RxdQqY1uRr7S+ZXWyUXl3rffw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004088; c=relaxed/simple;
	bh=q0y9Ud73LqQhwuyN5EYgcTOcG4RR/oexyr3NTsuez9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fi65drhnLHnSHZJ8Oyl5nVgWG/ov0gBGIqAaACPRan28gDZqRtLcvmoLXDkSm4TCLTm59EKF07ugkMd6222lwFK9lj60VS84/NrWBKNTIVHQZuZYxHT4urK8pZFi14ZH8WbCZ1aaUM+TfBMBrGJSY5bEfkkDWlV2pfRXbwJCPcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHc/Vz3C; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso172649866b.3;
        Thu, 07 Nov 2024 10:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731004085; x=1731608885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVfDmuHs5p+fa/eZewzS61BcpvU/96M31o+p3JFZkE4=;
        b=UHc/Vz3CibD4VZ/PQK8TjHY3HQYciIJFwE0t3BY4tnAK71e7+3lwL6t24u3ctMq1vU
         OU11Do4FVdpy8bqKwcvFOGsPQLtzGq2wQJnsLTeFFYFBAqsXN4T4u+IsAl5EbkS6zFvO
         DWlFNN6Uand2MH26rtqZ/UL4tzFLrUukNAJG8L8NlU9afRyztI7G2Vf5zIl7xGQhV825
         BhcjpS2sblMGF3A3czLtRmkR7voQHJwQtnZeC62itu18+xUKFqAumzMjF6eVvigZJha7
         ANrpKnICUTkZdYz6OnpQfls8DZh9MEIujiiTypdQHs96lWNkHhnLJQxwN3nj2B7bjO1x
         Reyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731004085; x=1731608885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVfDmuHs5p+fa/eZewzS61BcpvU/96M31o+p3JFZkE4=;
        b=SrACeHOq1eUCainOyx0P1j5WAqJECmIVg0p63AYUBmViz7HEiFc+qj8ve163UZpslB
         fv6r9/C/Uk0qNsjy10UqL5nsLnyU1cTvLqKtCGc6G+ax6pG/oqeNaiifPQpTDoUuZAHS
         I0iyxWhmfnAT727+2GXFVZbsE0jBUPECX7uvLzszdzNITT6d0SVthhgyCzC3ikWc0XJj
         wvmHI5n/GEpN+0syZSsPD2/fRufwY6y3Ri5cCQpYfg6Mr+4HqTiNzQzs+RmT8a/P5w0s
         /RXWDS2S0mcyVH/ecL71YTfMw1FQSYBC0+dM/d7cvio0ahkQ50xkPbHiX8Om1r274rl1
         04jw==
X-Forwarded-Encrypted: i=1; AJvYcCWFZEF8Sga07UgZbPMpgKitOJqJjhrlUoDVrgeMtXXXl+tGkJwfzXM8dddUJx+m5hAtsAJAtMDd@vger.kernel.org, AJvYcCWbhaHE8yKzwxnm6W3KTE1exzFv3t6aZzcb7wF5enlq5ZdPrc3cWqJlqJtFXLT5ID8vzyGn1d2beAoMS3OO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+F1DIzvFH+CLFgtImtFr9J46MsJwBBOfnYsFe/uo2rCHt/CdU
	BAcRbPpkBCL1hXNci1CKi+oUglVUmsuUqNWtpv3UCovCyROmem6AUKr3vWGdYGJ/72G2BGNMGEh
	VfiSTmSBarpyltzBinZa6pl7+rX6wyFFg
X-Google-Smtp-Source: AGHT+IGslwSAq9MKLCz5wDbzj4kAH/gRj6dZGwgC/ErBas1EoEfksgehPaVh61S2Yyo9MRL9FoNIMTkD5gDBNsZaKPA=
X-Received: by 2002:a17:907:31c3:b0:a9a:522a:eddd with SMTP id
 a640c23a62f3a-a9eeae9b963mr113080266b.11.1731004084816; Thu, 07 Nov 2024
 10:28:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106221434.2029328-1-joshua.hahnjy@gmail.com>
 <20241106221434.2029328-3-joshua.hahnjy@gmail.com> <o7dpwewfztqpkidrhvpdm57ikid4yswygag5gkjplfwdfkl54l@bs6oh2t4jp7z>
In-Reply-To: <o7dpwewfztqpkidrhvpdm57ikid4yswygag5gkjplfwdfkl54l@bs6oh2t4jp7z>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Thu, 7 Nov 2024 13:27:53 -0500
Message-ID: <CAN+CAwNSMXP-Z5PVL_Q129nN-aP80XB0Y-Sm+C-XdHBinvWoxw@mail.gmail.com>
Subject: Re: [PATCH 2/2] memcg/hugetlb: Deprecate hugetlb memcg
 try-commit-cancel charging
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 6:50=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> Please cleanup mem_cgroup_cancel_charge() and mem_cgroup_commit_charge()
> as well as there will be no users after this patch.
>

Hi Shakeel,

Thank you for your feedback. Unfortunately, it seems like even after this
patch removes the references from hugetlb.c, there are still some
references from other files.

mem_cgroup_cancel_charge:
  - memcontrol-v1.c~__mem_cgroup_clear_mc(void)

mem_cgroup_commit_charge:
  - memcontrol.c~charge_memcg(struct folio *folio, struct mem_cgroup...)

In fact, in my patch, I add an extra call to charge_memcg. I think for this
case, it makes sense to just extract out the functionality from
mem_cgroup_commit_charge (3 lines) and expand it out inside charge_memcg,
and get rid of mem_cgroup_commit_charge.

On the other hand, handling mem_cgroup_cancel_charge seems to be a bit
different. Now, all of its references are purely in memcontrol-v1.c.
I think in this case, it makes sense to migrate the function declaration
& definition into memcontrol-v1.c, and remove it from memcontrol.c.
Perhaps at a later date, a cleanup in memcontrol-v1 may find that it makes
sense to remove the function, but for now, I think we should just move it.

I hope this makes sense. Thank you again for your feedback!
Joshua

