Return-Path: <cgroups+bounces-7933-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C896AA3D9D
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 02:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44F3920AF5
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 00:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9FD293740;
	Tue, 29 Apr 2025 23:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnOSxA+l"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BF52DAF8E;
	Tue, 29 Apr 2025 23:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970709; cv=none; b=f3fbUuD4B7OXtD7Y+W1BCgkHrAwdPjvn30DvXrVl8yFhX38DLQHpY2JjVdGgsdAs79CM6+vHgWFhfoXVuVYcEjhwhEbDkP333frUstq0xgZ+f6jBBbRV+0uJBenn75qz/fMtLip6lSkYSDfWtaguvqNXRQw9vAF+Brms3DmIfYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970709; c=relaxed/simple;
	bh=sBCCEu0PzXtD/z8CcTyLp+IK0B/An2GSO48BkbxRwVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poDhDl02zEMJZLdJoGDQwFQhzF5gkAesSsB4x3qNulA66JwiRmq6Xl9PJziTTVb/e+gpKmIasHT1W14+SHTeXaA8hb108PuumGyKCq08C89sOWMuOiMHEODCfYmYdHDIy16BbfrJmbq9xdzTMdx7yBkWqSkWCoO5gU50YBfWetA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnOSxA+l; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6ecfbf1c7cbso115828206d6.2;
        Tue, 29 Apr 2025 16:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745970706; x=1746575506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgJMhFJq4ZUTkLgK4HQ4HBKsoTPMcSmHP2uL7gp3E7o=;
        b=cnOSxA+ls6kKEJaC93TvLN0JWzzOIBXoHKHvScVB92DVH28cOwuMaIuw4dP9c9SBfa
         gJZdipbscE6MV0gH6qrpW95t8HehrxC3dH3xYuviVhm6Tw+SOX7k/0RlIgOcXE0ZbQBY
         cTpdlfarjZpRAP2C0LFyxo97MX58FGuJHEmLgb8oz6cGnqOwupet8ueAfbOOfVbGb08b
         j0v1qXVjPRKBmUi1bUzRI2ficZ4/LGbGalGvsOphzd/5ksKvclg+tqdOPKG1RIJK1zj5
         dwRokShTdngaQhmeJXNFxVhlDbz5DX/mdQzbXzd2l8yriCoI2tdvSxuOeWI2+LCYSbUL
         nOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745970706; x=1746575506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgJMhFJq4ZUTkLgK4HQ4HBKsoTPMcSmHP2uL7gp3E7o=;
        b=Pr63Kt7S8MP3sKY7+8T4aJqaaZ75pO8w6nkk+ZcVfdmQ+nQJb0XWZMDzQ0L4S9tGBM
         0BgdP4is5sND84VOGZ9bacrR4O8WKjIlHLSOtNE+88NYHJ8wbrHECd9qiOsVEaGW4I7h
         ex3J0S02ErEUbec+d2Jt8RjaLnD/fgOwNK/4Ea3/7xrLL7iJyW8HWhcgLeXfv81S7qPB
         F9x41hxrsQx1Pjut+o+hYuvitrwz0+8aOtOCAsnCV+RTIgRT5wakKCQGQ/QS7atMLUPG
         w1CjGBV9ACdCiZld+4fZooG0+Z+s2Kxv9i0zPeozrj7QIXtGW7hr7KR+o1emDg6SKcwP
         0l9w==
X-Forwarded-Encrypted: i=1; AJvYcCV0n7FsWxvbHtTl7d6rNwnPp8SgRTa7KOumowBcNJgDvtEW0Qu1xMriqkifw2/pFct6mTzzowNKKVg=@vger.kernel.org, AJvYcCWrDWLzhk6SYnUZUQDGL2bC4iMhljubzCvK0ZilnMUT0KmuPGdV2sep4pSrIDUgc43KRYTF6/CX@vger.kernel.org, AJvYcCXwQV51vzWGTeKCoJ/ePVtypLmrpDRUD2eLSYF9qzCs1a24hTDUpA5msuVuGnc1faKuslu91qXC9tCFr1KH@vger.kernel.org
X-Gm-Message-State: AOJu0YyF0QPnWW/W19o/WSSKeqW+n0MIngQfrFHNIUBiE+052ClQHHgA
	mrsG8f1PLJJ0Pkucel5N/Vg6MZHC09QhsxKMtm+w/OKhCzrDmFpAHxoKtqyvjK78BgI60p5xOpy
	qjbYTGUyTUlNHt73JlVXLmTwcrwg=
X-Gm-Gg: ASbGncskSh6TXjkT6+umpp7gPOVTEQA1K48PYyie2I/OjP9ueWcPeEk9OO1G/TEkaMZ
	Cn6WbVWHAdAr7UmX5aqbiDawxiGayMXlBaMlguALZKpTIqqcIUSCMcGPiCEtLXZHp1AoIxKIr78
	I0hT9GLal3DHgDxOAHEeI15ek=
X-Google-Smtp-Source: AGHT+IHJjRFYguZCAOSMReICx0ON6O2vFOn6ON1tzk8HouhAX8NRmwnFIUzqGziJ7hrTHn025vdSyMxaH0CInlVPqOs=
X-Received: by 2002:a05:6214:130d:b0:6e8:9b26:8c5 with SMTP id
 6a1803df08f44-6f4fe053011mr13808786d6.10.1745970706693; Tue, 29 Apr 2025
 16:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429233848.3093350-1-nphamcs@gmail.com>
In-Reply-To: <20250429233848.3093350-1-nphamcs@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 29 Apr 2025 16:51:36 -0700
X-Gm-Features: ATxdqUGzJf3hFqFjw1dvxBqFD4iyh4yJTKCB2ByesYnjFgCzf21p8iLoeNdCFmM
Message-ID: <CAKEwX=Mea5V6CKcGuQrYfCQAKErgbje1s0fThjkgCwZXgF-d2A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/18] Virtual Swap Space
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com, 
	yosry.ahmed@linux.dev, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, len.brown@intel.com, 
	chengming.zhou@linux.dev, kasong@tencent.com, chrisl@kernel.org, 
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com, viro@zeniv.linux.org.uk, 
	baohua@kernel.org, osalvador@suse.de, lorenzo.stoakes@oracle.com, 
	christophe.leroy@csgroup.eu, pavel@kernel.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org, peterx@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 4:38=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> Changelog:
> * v2:
>         * Use a single atomic type (swap_refs) for reference counting
>           purpose. This brings the size of the swap descriptor from 64 KB
>           down to 48 KB (25% reduction). Suggested by Yosry Ahmed.

bytes, not kilobytes. 48KB would be an INSANE overhead :)

Apologies for the brainfart.

