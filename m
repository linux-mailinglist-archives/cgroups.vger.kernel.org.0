Return-Path: <cgroups+bounces-6928-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5434A5921B
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 11:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88523A821E
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 10:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95041227E83;
	Mon, 10 Mar 2025 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLmKmnDQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CC2227EB1
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604191; cv=none; b=BFYDHnYV0CVdyCLdOzPd04VJ/X/1WMjzL+kXWRT8lDUoEJjH3+cyZc/Ic8+oQwDSe2rnPCU2qAx5wUxfFFi2llHB5jnQysp+mGmnSazwxvjTjfDtAZZb00mgjqnEU6UTroUSdJOFQNZj/v3z4ddIw7rlNCkiFdHBh520uVzb3oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604191; c=relaxed/simple;
	bh=wGRxKiBJ9FQQRTK6oDzeSg0q1uR8lmPV8PHL2NFq+zA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBjgZcOHtFH05S5iOjhoGffOq/0MfyAUVN3tyxlZgvtNMZX5fnRgXCCM57FaN0RFntBQp57E9ddKwKNBpfo4fEUkd3bQV/EvvTQ9/vs6OCo03oAnau5azi/s4k70SITcj5bBeHpG9ynEAa+jbAj/5RvD/9KdlFv2QmDPEUepktA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLmKmnDQ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39130ee05b0so2442312f8f.3
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 03:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741604188; x=1742208988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGRxKiBJ9FQQRTK6oDzeSg0q1uR8lmPV8PHL2NFq+zA=;
        b=DLmKmnDQBOuLypJDQU9kqvcdvEuS0+IQ9xi0H0uM+0R6YcSGkUpNElz5RvxOFpwjaj
         +r3+0kScshHolPHLB0VkfuDfM0/8JnCGsOXCznuEZkbl71mm/x3xM5UQ9LSKLlELHDQQ
         j/EpX3wKIeIzDdkU9wc5xiB89b4lW/p1aPy+9SmxTMaS3iPY1XlQXDLIxp9YmnpOEHZA
         dDFCB4HSt1dNg51+jVwJoRodonrd/0z8ZA+fI/PO/clWk6ZnpsY8UOvc1j80wy/PN5L+
         tSCPxVFO/RLN1ceIGucHySvnZhbailrGcQGO+SMP9kUBhk0yWuKGHRUAmR0/Wp+F9MsW
         0QCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741604188; x=1742208988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGRxKiBJ9FQQRTK6oDzeSg0q1uR8lmPV8PHL2NFq+zA=;
        b=J553AQcNpgkfk7A2T0Ma3gpCuDIihXAmgTR7EUkF8rVuQ5L6b18PM+Dx+PCKR7GyFa
         /NV1L7DmGfZceooqx8mlGUf1UrtiEW6Aev7CedMnuyLFYt2NW60tOMrePr3TAuCIHgae
         02pyBSnpESfN4QRiql7NYcuNAzk0ThhQWB5MAqCwSga+/JZ1wqrEOCVuRd6BnoGfIr9S
         2MdryKG51EWpc9YpdzxernqXmKnkV4s43/9vKvN4XAUVqjzLZ023qEz1KliGKym3usaZ
         CE4a9rzYW2LWhpz4qvzJQQWjcwt4nXu0/gO+qpbqNAFZzz4TXu56/wAogxAktlXY2R8q
         bHjg==
X-Forwarded-Encrypted: i=1; AJvYcCVpqSrHcNzesV4qxmDf/I7+rKxZW9VlraZwKwvciTH2LPIAjg/Qrio1oJiDMIRB2womnfJjOsNq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Oz8ZfUsqRKHiT/aggjLDpbgUb8eLbnM/Yf/XCPRFfO+Q03Km
	tD7OtdKwFYu6FxbcsiTbG+0yoIJ51CJIlyWcuREWjNaoEp4jb7ToRm8I3Q5X95bJ+nKCxFNEIRm
	vNvXRT8MqBD+ss520DardkyLLZMKIhKIcylU=
X-Gm-Gg: ASbGncuYIsnEOPjCL82mXcOq6A2envO77Th8Tj6YifZKoEOyRr6r2vTUx/B9rN+o3w4
	WUwpwSvmXi4PkPLYQ4/8MeJDuVUifTmB0MqJv6HWncNYRE6Uv27t5zR9AKeD2maIK+7b5Drnip/
	g9ok5fl/fZ4wq9puTdv34tmKL0bg==
X-Google-Smtp-Source: AGHT+IGYDB/hh4zokMCikpkMPS3SEWZMqEvFe2ojibH66A319Zc73ywxFVPR2jPBB0VrzoRht/KJKUB7T8KTdt9OssE=
X-Received: by 2002:a05:6000:4013:b0:391:3f94:dc9e with SMTP id
 ffacd0b85a97d-3913f94dde0mr5331464f8f.16.1741604187611; Mon, 10 Mar 2025
 03:56:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202503101254.cfd454df-lkp@intel.com> <7c41d8d7-7d5a-4c3d-97b3-23642e376ff9@suse.cz>
 <CAADnVQ+NKZtNxS+jBW=tMnmca18S2jfuGCR+ap1bPHYyhxy6HQ@mail.gmail.com> <a30e2c60-e01b-4eac-8a40-e7a73abebfd3@suse.cz>
In-Reply-To: <a30e2c60-e01b-4eac-8a40-e7a73abebfd3@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Mar 2025 11:56:16 +0100
X-Gm-Features: AQ5f1JoUrD98AB14rnB1IKdkRt4DsRzn0OxlMkGJPDtUGy7hI_dYyPsJBkJXofA
Message-ID: <CAADnVQ+g=VN6cOVzhF2ory0isXEc52W8fKx4KdwpYfOMvk372A@mail.gmail.com>
Subject: Re: [linux-next:master] [memcg] 01d37228d3: netperf.Throughput_Mbps
 37.9% regression
To: Vlastimil Babka <vbabka@suse.cz>
Cc: kernel test robot <oliver.sang@intel.com>, Alexei Starovoitov <ast@kernel.org>, oe-lkp@lists.linux.dev, 
	kbuild test robot <lkp@intel.com>, Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 11:34=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 3/10/25 11:18, Alexei Starovoitov wrote:
> >> because this will affect the refill even if consume_stock() fails not =
due to
> >> a trylock failure (which should not be happening), but also just becau=
se the
> >> stock was of a wrong memcg or depleted. So in the nowait context we de=
ny the
> >> refill even if we have the memory. Attached patch could be used to see=
 if it
> >> if fixes things. I'm not sure about the testcases where it doesn't loo=
k like
> >> nowait context would be used though, let's see.
> >
> > Not quite.
> > GFP_NOWAIT includes __GFP_KSWAPD_RECLAIM,
> > so gfpflags_allow_spinning() will return true.
>
> Uh right, it's the new gfpflags_allow_spinning(), not the
> gfpflags_allow_blocking() I'm used to and implicitly assumed, sorry.
>
> But then it's very simple because it has a bug:
> gfpflags_allow_spinning() does
>
> return !(gfp_flags & __GFP_RECLAIM);
>
> should be !!

Ouch.
So I accidentally exposed the whole linux-next to this stress testing
of new trylock facilities :(
But the silver lining is that this is the only thing that blew up :)
Could you send a patch or I will do it later today.

