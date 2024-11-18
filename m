Return-Path: <cgroups+bounces-5623-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFD29D19A2
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 21:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5851F2142A
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 20:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78BC1E7653;
	Mon, 18 Nov 2024 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="B/G1UJ6J"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0C21E5732
	for <cgroups@vger.kernel.org>; Mon, 18 Nov 2024 20:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731961662; cv=none; b=En+obCM53URZdgHNUh5DUhp216KiNggVU7/yqZv7TB6LAPBNsNW+iv4337T/uZ/fwcji/0ueo5q/Ib3RHbElbbO5nusLbqumLfWBTwvrAAuRvzB/nlRxHEv3zFDQaMQi3/XV/4N0uzamKg7FHxYKAwlUd2LZEoW9NHhdQGIFT64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731961662; c=relaxed/simple;
	bh=a3QVwlKH8NJSHaPzE4WZjNX233TZpQNVSY/HX3mH8+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZOa+0R/hoMMjLLiJgN8JVqZr/t2Ew3mWZapPXNWMwUusaRiBvA2QZvj7n3izncLzvpPBVwjS59hQWmqvLobc+Ra0O57pMXMxuyg1d5yDXzcGBA3zp/Xs2Sra+yGMRuoiPAgzN5FHYTMqlpBSxtz9Km0lCUz+Lui1+MMxBVinx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=B/G1UJ6J; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-463575c6e51so34354621cf.0
        for <cgroups@vger.kernel.org>; Mon, 18 Nov 2024 12:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1731961658; x=1732566458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3nxx+7qrTCUTgF8wRPbLSF+iqg1a4HrwDqR95ENSuQ=;
        b=B/G1UJ6JpLfkHNgTDh16udNu/k0klQPnRsX1gkuYuueecFF5cXnpo4Vkox1CnCKoIZ
         dJEPRctptZB6URlXdXLgDUSrAdbC/Jp6hyC55R85DO7ngBq5L16igBUCLohVM9CPxvYn
         9KAJrRjRwmJ5U5r9GH7YxfnQo/FHSAOrAuF3MnszELVBZOa3Nt2B60iuadyFmx15mn99
         TYzJuvvfnj8reiJAzVsqHy9HAlGdv86HUtRDKco0E3llKuOdwKP9yt93XxktQSLmr38b
         C0NCgbc5ZjsNGA8s0LoQHVa2v33zdv0+WaGcNphoaoKRA9XrwvQRhsx4RH/EEkNCN0ve
         Y7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731961658; x=1732566458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3nxx+7qrTCUTgF8wRPbLSF+iqg1a4HrwDqR95ENSuQ=;
        b=mV4IEqf+gv8IxvdrYpSRV4LVC/qz4TyHrmfpnA3aEXh6W3NxRb6nHT1QheRx59Qbl/
         8Vx0sQOwdj8l+vrgli3uIDFTtmOOYs//qj66TNYVOd8C+eFqQUYECZs3o47wH7YgTxJk
         nhR2l0U8lsEZCReYChZ3DVEkYhG2d5eg9Swdytj2ajZBM72ZYV8lDhc2fCRhwr44eQhl
         cDw/GRSrkwxW3pG3bFnE3dXSAhmpzbTwH62806UodWLc7alHCEGiFBShfHmBnuWk0eNh
         LENEjn5geTtWXl4tQjtbohJ8L7x+JpWyC+2NMdabw7D4gOqMwFQv5iXTjKOAJkBmcME0
         oHOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhnD24+dr8f6Aj9tGJ9NfJ7UZnzwnzeANyoWT0h8iajkX1r67Rm8h4aOgK4FRxpHkEgakaPtah@vger.kernel.org
X-Gm-Message-State: AOJu0YwKeVLjHqIz4yeAL8OnvLIqO4GLNLVsi15h/Oxp0dLBCkkF1zPr
	l10Meg8qaJCElcgCAkJaP40ka3yVTk8a9QInUxBS5D8bW7dU3EOMNs+HzlIZfBRFOrmlWAHmnVw
	z4p+i1N+9v9t+NUPJdzJ1z+8ihcEuP7OaGerbZA==
X-Google-Smtp-Source: AGHT+IEVnem2aUWUfWPU86vXVaI52L5T1uqMRPM6WN6TPqoknhSkQ2b3QpTvZt2EMklkAGUIuUVQ4/bXMBR3sUHYFxI=
X-Received: by 2002:a05:622a:4c8c:b0:463:4be4:b03f with SMTP id
 d75a77b69052e-46392d6cbffmr14403641cf.11.1731961658470; Mon, 18 Nov 2024
 12:27:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <20241116175922.3265872-7-pasha.tatashin@soleen.com> <9868242c-ce91-421c-8f55-1185a66657ce@collabora.com>
In-Reply-To: <9868242c-ce91-421c-8f55-1185a66657ce@collabora.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 18 Nov 2024 15:27:01 -0500
Message-ID: <CA+CK2bBfi5pgkVbdTDw-r7xym3FDsb66LL3qiMpujHTsbN8KXg@mail.gmail.com>
Subject: Re: [RFCv1 6/6] selftests/page_detective: Introduce self tests for
 Page Detective
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com, 
	shuah@kernel.org, vegard.nossum@oracle.com, vattunuru@marvell.com, 
	schalla@marvell.com, david@redhat.com, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 17, 2024 at 1:25=E2=80=AFAM Muhammad Usama Anjum
<Usama.Anjum@collabora.com> wrote:
>
> On 11/16/24 10:59 PM, Pasha Tatashin wrote:
> > Add self tests for Page Detective, it contains testing of several memor=
y
> > types, and also some negative/bad input tests.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  MAINTAINERS                                   |   1 +
> >  tools/testing/selftests/Makefile              |   1 +
> >  .../selftests/page_detective/.gitignore       |   1 +
> No need to add a new directory. Please just add the tests in
> selftests/mm/ directory.

Thanks, I will move this to selftests/mm/ directory in the next version.

>
> >  .../testing/selftests/page_detective/Makefile |   7 +
> >  tools/testing/selftests/page_detective/config |   4 +
> >  .../page_detective/page_detective_test.c      | 727 ++++++++++++++++++
> >  6 files changed, 741 insertions(+)
> >  create mode 100644 tools/testing/selftests/page_detective/.gitignore
> >  create mode 100644 tools/testing/selftests/page_detective/Makefile
> >  create mode 100644 tools/testing/selftests/page_detective/config
> >  create mode 100644 tools/testing/selftests/page_detective/page_detecti=
ve_test.c
>
> --
> BR,
> Muhammad Usama Anjum
>
>

