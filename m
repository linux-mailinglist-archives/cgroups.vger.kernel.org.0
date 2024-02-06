Return-Path: <cgroups+bounces-1379-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 178EA84AD33
	for <lists+cgroups@lfdr.de>; Tue,  6 Feb 2024 05:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3954F1C22A12
	for <lists+cgroups@lfdr.de>; Tue,  6 Feb 2024 04:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5944B2F46;
	Tue,  6 Feb 2024 04:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U9+Yh2Lz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985B7745DB
	for <cgroups@vger.kernel.org>; Tue,  6 Feb 2024 04:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707192115; cv=none; b=DhQ08hKnlWzwIvFSVcKGu3Uu4lHZVNVSyzYmeOpURhSfRqlMls9V/yUTCVBKjFHdBkpC9bw/8NyiS+BVb5nNaQrXGm3alpCS2Hsy/g4751hhOlDsSeCLh1S8ZJsXHWMgCI3OPSXHGAci0CgSGWc/uNyH2jgQEg00mwvKq8ieMrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707192115; c=relaxed/simple;
	bh=XYPlJCC6y1QEgjgTJDcgPQGNblckOrO8DnCFLZ9O1hA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gyVxxNUx7ShsTUddED9yeMG88D2WX61WQ61KfwLiFMwYmTM/YY8iFSdibUtiwhpMM3iqB60mpU0jw+2WTuxf1iG1pvuJp+nW1mhF+sxei411DdVCsZEZOkRDRj1Wbk3lWwBmljKUQczmrx459hn8sLNVdAdjHOQblfPNi0LGEJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U9+Yh2Lz; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6d54def6fso4858513276.3
        for <cgroups@vger.kernel.org>; Mon, 05 Feb 2024 20:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707192112; x=1707796912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYPlJCC6y1QEgjgTJDcgPQGNblckOrO8DnCFLZ9O1hA=;
        b=U9+Yh2LzENEgO683BoA8DFNrvx5VEhXXcKowOZj12XwL6R7BCO+QaCYu34je+8410l
         EPug61MkYI7pmtccf+b64z5q0kTv5sUha49lcKqsrEEA2TfaTFDRMWlf5hN2aVSbgiri
         Ju/Tbzn6d+K103ejfHCu4W8cjBR52EN15AW7qj+I1FiE+or1Jtq9FJlmwteftH4BICZA
         kEKmfc7yz4AzHVfV284G+3V16Od52O5ja1ipO6I47i18F90y+8tCYy/nnISKXIuiS6Jo
         E1/kU3YVKo13ogLrgWxlCkBfjDVCuAwM75s/BuQW8n86Hw7WWk3+6ehEMAqwUrZfz0Yl
         QZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707192112; x=1707796912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYPlJCC6y1QEgjgTJDcgPQGNblckOrO8DnCFLZ9O1hA=;
        b=YwSWUmDko9kMMfIVb6eKKnz7yPk/nD9yMTFIY1OTpEy6mBkAEWnjZh+C/dDoCcvLrw
         zwxR8NsJrLFayj0jT4l60RsVYVWuSrB1P5z2UyJPckIgi8obXvia4XrYguCUodT9BjiC
         FU/+LASFJMz580Orhu9/b1IkXQeNmwzMzfAKoN9A3ygmI5jW8M/msjmCdzd77I/LDvHO
         iZ0N35C/9ThZmvsebQ7cbyNgCPkAoyc0maotRv5EoS+TxJVrhYI5xAAGDvduLJmlgO1v
         UPNt8JHzmmjOhGPWlBrofF84i9cbO1CxMfu2yEmTMuxg9Qf4DO157HQp5BS0fwj5WyCw
         afIg==
X-Gm-Message-State: AOJu0YznFzBnGnRAgyXhAzSbDGGOUvbZeJXM1ElRfWrJSPT3p2BExhST
	ArwnlEpCCXZH7x17dRK4tv+ZgON/0hYoptvn+WJq6Zkfkue0iNbrub+Wb+E5yVhACz/fDgSaTk/
	F8JSFNu1A9dPjaSVrU0v9DJ+H8UA5nLWgyatt
X-Google-Smtp-Source: AGHT+IHQs+XI0qiDLBdYO6OpEO2UI/si9y8p5hNXubv9yjzLeMiJXV7WVmkKgnzX2Iyq1NZxVBG50KqKIm+Dezq7+1g=
X-Received: by 2002:a25:b10d:0:b0:dc2:554f:ef41 with SMTP id
 g13-20020a25b10d000000b00dc2554fef41mr503561ybj.13.1707192112288; Mon, 05 Feb
 2024 20:01:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202233855.1236422-1-tjmercier@google.com>
 <ZcC7Kgew3GDFNIux@tiehlicka> <CABdmKX3HbSxX6zLF4z3f+=Ybiq1bA71jckkeHv5QJxAjSexgaA@mail.gmail.com>
 <ZcE5n9cTdTGJChmq@tiehlicka> <CABdmKX0Du2F+bko=hjLBqdQO-bJSFcG3y1Bbuu2v6J8aVB39sw@mail.gmail.com>
 <ZcFG2JoXI7i8XzQY@tiehlicka> <CABdmKX0t1LXj80Awe20TrmY5gQB6v2E4bGfW8WXr2i84o+k6ow@mail.gmail.com>
 <ZcFQMru5_oATGbuP@tiehlicka>
In-Reply-To: <ZcFQMru5_oATGbuP@tiehlicka>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 5 Feb 2024 20:01:40 -0800
Message-ID: <CABdmKX35GV3VFar0_pNR_vAXLpvxo+APALXMharsXh6TO+0mrQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm: memcg: Use larger batches for proactive reclaim
To: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Efly Young <yangyifei03@kuaishou.com>, 
	android-mm@google.com, yuzhao@google.com, mkoutny@suse.com, 
	Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 1:16=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Mon 05-02-24 12:47:47, T.J. Mercier wrote:
> > On Mon, Feb 5, 2024 at 12:36=E2=80=AFPM Michal Hocko <mhocko@suse.com> =
wrote:
> [...]
> > > This of something like
> > > timeout $TIMEOUT echo $TARGET > $MEMCG_PATH/memory.reclaim
> > > where timeout acts as a stop gap if the reclaim cannot finish in
> > > TIMEOUT.
> >
> > Yeah I get the desired behavior, but using sc->nr_reclaimed to achieve
> > it is what's bothering me.
>
> I am not really happy about this subtlety. If we have a better way then
> let's do it. Better in its own patch, though.
>
> > It's already wired up that way though, so if you want to make this
> > change now then I can try to test for the difference using really
> > large reclaim targets.
>
> Yes, please. If you want it a separate patch then no objection from me
> of course. If you do no like the nr_to_reclaim bailout then maybe we can
> go with a simple break out flag in scan_control.
>
> Thanks!

It's a bit difficult to test under the too_many_isolated check, so I
moved the fatal_signal_pending check outside and tried with that.
Performing full reclaim on the /uid_0 cgroup with a 250ms delay before
SIGKILL, I got an average of 16ms better latency with
sc->nr_to_reclaim across 20 runs ignoring one 1s outlier with
SWAP_CLUSTER_MAX.

The return values from memory_reclaim are different since with
sc->nr_to_reclaim we "succeed" and don't reach the signal_pending
check to return -EINTR, but I don't think it matters since the return
code is 137 (SIGKILL) in both cases.

With SWAP_CLUSTER_MAX there was an outlier at nearly 1s, and in
general the latency numbers were noiser: 2% RSD vs 13% RSD. I'm
guessing that's a function of nr_to_scan being occasionally much less
than SWAP_CLUSTER_MAX causing nr[lru] to drain slowly. But it could
also have simply been scheduled out more often at the cond_resched in
shrink_lruvec, and that would help explain the 1s outlier. I don't
have enough debug info on the outlier to say much more.

With sc->nr_to_reclaim, the largest sc->nr_reclaimed value I saw was
about 2^53 for a sc->nr_to_reclaim of 2^51, but for large memcg
hierarchies I think it's possible to get more than that. There were
only 15 cgroups under /uid_0. This is the only thing that gives me
pause, since we could touch more than 2k cgroups in
shrink_node_memcgs, each one adding 4 * 2^51, potentially overflowing
sc->nr_to_reclaim. Looks testable but I didn't get to it.

