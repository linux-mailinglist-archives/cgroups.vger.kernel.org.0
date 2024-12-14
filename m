Return-Path: <cgroups+bounces-5894-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CA59F1BE0
	for <lists+cgroups@lfdr.de>; Sat, 14 Dec 2024 02:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B149188E4AB
	for <lists+cgroups@lfdr.de>; Sat, 14 Dec 2024 01:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41506D531;
	Sat, 14 Dec 2024 01:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gq4V08CC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD4E3C14;
	Sat, 14 Dec 2024 01:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734139848; cv=none; b=H/aK3ItgTOuhsv8I0Pzp2J/0zCWHPMZWqGtXbfajF+Iq4C56twrAkuNSouuMtYzumwrZIr95PlCaLU0Q07IGkrLuPqbFS5j55IKlD2HJpydnl3X4s2lwMmcz91FvOG3sokZ4M7i2iNQOQ94L0WX627ZvH7sxdtg+fk2Ol8cpCkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734139848; c=relaxed/simple;
	bh=28Fjkn9YkOg3RuhmQiqVg0l5FNU6YiPtoIBkT3kcHLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duHdKCYNsxNiY+AxDYqeUhQaSIGNel71rD+8OOi2gsrZaPkMa6k3nG7RGCySsT1uVOAbYzaTE7QwePJIeSz4bIrdUunWt/5DsMnVSN2FzWwyDdMwQl5GMEV0r7C3XAOmgRIGhFg2eo82vCdCPNfQYh4XRUHaBhGtuuQmJl1lTOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gq4V08CC; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6dcc42b5e30so14958526d6.1;
        Fri, 13 Dec 2024 17:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734139845; x=1734744645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28Fjkn9YkOg3RuhmQiqVg0l5FNU6YiPtoIBkT3kcHLY=;
        b=Gq4V08CCiBosZODcJlNgrZyRSD8yW3+n7PiGkAxVuv92NF1SbuLzfqyv5I17UGgkf0
         MBLkKwxKa/TYP1fOXnDA7lLBLnLEGJC2UaFWp5J6W8lrK6OqUJ4u9XqrOLnCQDvvkA48
         gUqMv94EyL3LTX+d5QpVX1GkfXI9e1y2DGeYp4pVw25JpcGjCJfz0a1fwr4VTBMLAJE9
         WhxvNW7XJ54fTg0wBBgWOdfjYEYv5sdeOa/4DLzknhrNRpHW+WKuEQ9w4Jdf8VYBeK9T
         WuT2SKfhGjxD8SCShLyO4mERrJQozuQZ3DP26bkgZwkrRDkuL1vwYB5z22Q2YDZfydlI
         NwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734139845; x=1734744645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28Fjkn9YkOg3RuhmQiqVg0l5FNU6YiPtoIBkT3kcHLY=;
        b=NM5VFCjPcTPOf6dvFb8BSRu6d+dSaeZi3gofZgMRD/IckaUfx34r3YW2BWTUvZgwOx
         k0Ika6JlIBjBnP4yXeVNeXikxYiuYFzhu8V5f/xzvfWinL6+YP2EBo9eK1tND+dhQZXw
         3N0v2yIamTVo1m1p3Zsjc64Vp9wc8t7IRlzGSiee1wTNVDXWaVR372IObvfQSAFZ6JSu
         0GPLHx5a8NJgd/W0ScYs0OqJrGYUoxuL0BpUFLDIs0SX2uYisIdYlzETcf5C6fTaSDgV
         Ho4vItfmCGC4ybhaS7hKECstg+0NaVj46oQ+pumjA+L7BLYemZEApy8+y/gQ9uzxZCqO
         6wig==
X-Forwarded-Encrypted: i=1; AJvYcCW6dbRBlNG+Ev2Rr42590+mjgKWYk8DubtHzY1P/JItKxBjF9cXPaseJORpbLRCw6vCS6nU1cpfpNNF2DWn@vger.kernel.org, AJvYcCWABV0E9x6z8nIKZDFPILUHYEa3cUPbtBMTfHFxmkjXA7wYSuFvbraJtAUE6BOjz0MUnkicqxKx@vger.kernel.org
X-Gm-Message-State: AOJu0YwLLtM10VugCiYvDSubrXYfZbiN4V0Ka33jMsZRnb7bFifi6+SW
	vuv0t1IsSim/yX/MKZdhr48MV92IKoGKN/PMOL7BuU/YO4jMHp/V3u7J1FEyA5JqSpkpm+6wv+Q
	Lx0+b+gjPSKfsPH6AKXAm/cVUlgA=
X-Gm-Gg: ASbGncvYq/mPkaJGMPEMhUDf2HfDbfbQuCtu44YhYSQnWYQAElDykxuLvZmr0nWxySx
	zw8z+kEcWBY9cU2Ho0YhGPYtdi1ziPVZzsemBECHENfqtwsDtYHoG
X-Google-Smtp-Source: AGHT+IH+9L1ksju6SQtsNiqm1uMZ4TS9SOCaHNdscWSKxxPmJo3W+JINm4LcZMWh/ABDH9KI6aF3YOV0rTWqCjBE6qc=
X-Received: by 2002:a05:6214:da5:b0:6d4:85f:ccb7 with SMTP id
 6a1803df08f44-6dc70f96cc5mr97548466d6.0.1734139845573; Fri, 13 Dec 2024
 17:30:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211203951.764733-1-joshua.hahnjy@gmail.com> <20241211203951.764733-4-joshua.hahnjy@gmail.com>
In-Reply-To: <20241211203951.764733-4-joshua.hahnjy@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 13 Dec 2024 17:30:34 -0800
Message-ID: <CAKEwX=NjwuTZ21ZiTsT+qJFUHURrWGUbN0C+B48-cCDTOOyBYg@mail.gmail.com>
Subject: Re: [PATCH 3/3] memcg/hugetlb: Remove memcg hugetlb try-commit-cancel protocol
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: shakeel.butt@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	sj@kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 12:40=E2=80=AFPM Joshua Hahn <joshua.hahnjy@gmail.c=
om> wrote:

I'm assuming this is V3?

>
> This patch fully removes the mem_cgroup_{try, commit, cancel}_charge
> functions, as well as their hugetlb variants.
>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

