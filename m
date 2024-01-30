Return-Path: <cgroups+bounces-1281-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4255842C2A
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 19:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69C21C21DCC
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 18:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2968B7992F;
	Tue, 30 Jan 2024 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F8yIP0wd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705A869DE4
	for <cgroups@vger.kernel.org>; Tue, 30 Jan 2024 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640947; cv=none; b=CdcuVGpfwBiiXaGFMwGsvjlJfkSLqDvnQ7jDVkNwAyIiyHq4VRVEn4hkooTQbGnYrKiPHtLynAS71XeGEtvIxgJ7g40+I7krlwiGjTonBD1zr+TmotLBXp9mzDmogLzJAKBHEMDozo8y7hlkXV5YwRLS7byRCp2t//bDZFncFdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640947; c=relaxed/simple;
	bh=Fv/bTQ1xMvf2SnP8rg7hnK7lCBHHXhYmdjHeTk9P6G8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CXPw4vbd8oG+DxVVpF78GWfVGhxEPgBwZrTxnMpbKTsskO9R8kGEDm7iJRobpSidL4MDe6OFJzfKYO5ksZ2Q2nYPDB3URMwc3ZzQW7HQ0aiENSIM7zxu2y/JirmC1H7/SO4zxLaytra3AGV2EGz9p6pK13BUK4gTM96wsrB/y6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F8yIP0wd; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6531fa07fso6507629276.2
        for <cgroups@vger.kernel.org>; Tue, 30 Jan 2024 10:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706640945; x=1707245745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fv/bTQ1xMvf2SnP8rg7hnK7lCBHHXhYmdjHeTk9P6G8=;
        b=F8yIP0wdLqMQSIeRBUEeIKuMOFHz1mm/OScxL0vyxE5sZq4r1RIyxh2vUQ07+XwGzK
         aa0MKae9HfTMjR5RWxvl7LDtnxmOfppJIoMBsRpODsvwsEtrmqg2rXCR18Ouhc/TZDEe
         AVNPo8ocP8wITgzabtV9JChleFPotYWMxab43OpIVobw144/4KM5OphvUkBnOYODKJeF
         rKjpl2OUeDNtHA0QxJ44BPBlj/WCN+/iB/umCplAVjbCj30USI22yA6pGHlwaDOQsvy/
         +h+5HDQGQxqnNU46BKs5HSNSBEnASzj5Z0lIWQKe9OWqstj9negPcP2ah0a/p+QFOnoR
         fXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706640945; x=1707245745;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fv/bTQ1xMvf2SnP8rg7hnK7lCBHHXhYmdjHeTk9P6G8=;
        b=vjQPyfJ+suWgI4C2fyykmZ/rVBxKu1UhqV/PEmP+z68Qv6djm+w26JJCb5iDVXU72C
         3SWAJILSui9YiOG3wBOc22EcW20TPbn/2PBGMBEu2uG5PrrzZK8Ng+tCCvCLfvvY2+20
         XraE4zPZWr6KH1TQTiq8fZCPlvQ3UGdVM/Nyu3p7XwB1DgQFqJEvgUQFcSaEDmAd6KZw
         gLlRO4D4XWkDfoIsjkxIvfsmeBtDRQQLA36Yv82kmCaN+A4bYcnDKN+Lp1dHuqr86spJ
         fD0gtlPx9T5qZdIT0YhrqIUadbz9V6GengOBoZyW1c0N77z4tBBgDQHo0/UjtHkYt7qe
         PQTg==
X-Gm-Message-State: AOJu0YyZ6RjZ0VHq+pGVAAwtpSqmrlUjoVzlI60jdnKZtvTSwNG9dT07
	3r1lFC+wUIudC6nj/XCaP1fLNUwHhKcPcwf9isvsfwUt1OPJUXv4Im40cCQpFcQWxDb8VdSK+hZ
	intF7u9HSJ7W4UVjOXQ==
X-Google-Smtp-Source: AGHT+IGkYCoroPgQ0vC/qjOZHRglhy7FVefWVZSNBL/apsveQNFhYpaPcmuSmn1r9c0pb5X44+CYburGBcOpRHsF
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:2406:b0:dc2:260b:64d9 with
 SMTP id dr6-20020a056902240600b00dc2260b64d9mr576357ybb.10.1706640945579;
 Tue, 30 Jan 2024 10:55:45 -0800 (PST)
Date: Tue, 30 Jan 2024 18:55:43 +0000
In-Reply-To: <CAKEwX=OwsEcSnw5V_zivdFzGLLVA_PC+Acv+5sozkCJU1NHpeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129224542.162599-1-nphamcs@gmail.com> <20240129224542.162599-2-nphamcs@gmail.com>
 <ZbhKoJ5BcP_RhMt4@google.com> <CAKEwX=OwsEcSnw5V_zivdFzGLLVA_PC+Acv+5sozkCJU1NHpeg@mail.gmail.com>
Message-ID: <ZblGL3BgB3MAL57Z@google.com>
Subject: Re: [PATCH 1/3] selftests: zswap: add zswap selftest file to zswap
 maintainer entry
From: Yosry Ahmed <yosryahmed@google.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, hannes@cmpxchg.org, 
	tj@kernel.org, lizefan.x@bytedance.com, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 10:37:15AM -0800, Nhat Pham wrote:
> On Mon, Jan 29, 2024 at 5:02=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Mon, Jan 29, 2024 at 02:45:40PM -0800, Nhat Pham wrote:
> > > Make it easier for contributors to find the zswap maintainers when th=
ey
> > > update the zswap tests.
> > >
> > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> >
> > I guess I had to check the zswap tests at some point :)
>=20
> We sorely need more zswap tests :)
>=20
> I'm one of the offenders of adding new features without including
> tests, so no judging anyone of course, and admittedly zswap is quite
> intertwined with other parts of MM, so it's kinda hard to write
> unit-ish tests for zswap only. I often had to resort to scripting
> stress tests to iron out bugs.
>=20
> But there are still tests that we can write to verify public API
> (cgroup's zswap options come to mind), simple tests that cover crucial
> code paths, etc. that we should probably add in. At the very least
> this can be a quick/sanity check for developing and backporting
> patches into the production system.

Agreed. I am yet to take a close look at the existing tests tbh, but I
took a quick look before and there is room for improvement (and little
bandwidth to act on it).

