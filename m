Return-Path: <cgroups+bounces-5261-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9004A9AFB4F
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 09:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16A81C21A5B
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 07:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75A51B393A;
	Fri, 25 Oct 2024 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2y+gCVAi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6867915B13D
	for <cgroups@vger.kernel.org>; Fri, 25 Oct 2024 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842085; cv=none; b=Z3RyNg5yPlqFn3hc9V8tfnwPO7iXdvs2PYioNiRk5snlOnLNzZUXBw6gS8CNGUDEbxl2lQ4e6eEb8bavl4eXi7j/v8bEXkG/NFTMkyXcWOGw8xW7lALQk2ZoR7xS3ZFaS/OgLGTgQGd+f7vQglrbuVxaHbBYqkpvL9cEHdvOyog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842085; c=relaxed/simple;
	bh=AiFj6HMw0y/O5aggx5/oK92kDrhsx1ofZsrKfgYwmio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPqPGSjBPoKjJ/piMPBKW6yYwLcwk5LUHDWy6HCMcOiTOyMPZCw80TnWt0ji6TLyWdaqSPz5ve8rbAmQP5b/2vUk0idzlcyT1+ZBxyJYIH652X9j3ikKdl4dZsB63wc7cdF2USe1AhoFtdRhcPy86STRqzgVyN3noCHQPh1+Wf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2y+gCVAi; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so5054825a12.1
        for <cgroups@vger.kernel.org>; Fri, 25 Oct 2024 00:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729842082; x=1730446882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiFj6HMw0y/O5aggx5/oK92kDrhsx1ofZsrKfgYwmio=;
        b=2y+gCVAipACsk8KY1UZ4yR5I5dH4J7Pf3gRngUnMoZktanFsl99hUyF29QqBU5KX3U
         mHYHZ4LxzusMLTOBmmoH2lL2ew5DUOgrLbFouDzwdSAbkw9conD+1Szw+2VRE/O9IKn6
         54dvm9BO/xRO7HwIeDMCPAvGy6xf0dqDYI2vodNSbBivGqBFORrfhe411pklw+LGtcEB
         C1RvTs6I+8vuWAlhIlLBGj9qqIraSOOCS9BH3dQA438SXoYwk3tL8wOyiN780cjumBDr
         jtVpQuwMBQe/7CKbT9EKnr5INlf7xeIyIM14iQMoO5TYrp9r28hWyRhkM8/RTsLW4KKB
         sYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729842082; x=1730446882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AiFj6HMw0y/O5aggx5/oK92kDrhsx1ofZsrKfgYwmio=;
        b=oGMDMfxu7OvIKY+Vestiyvx6kjaVHEtp5oMiiWQFO93mtdNHZVBCNgdCRAPLz97m0f
         urdGlk/wL0u1NdQWXV+sTS+4TdZPij+Y+V7MZyx6E6swvzOjBY7kiJeHDManincBQwi9
         ceF0gp3sQ/90jP1U2q3XiXFKIITPRIZ7S6384VXuc/68J2ajYleFI0vL4i4lEIGz1jd/
         y/FUvxlOI1twGuth2NwghwgNoeX+diHHa9jlxaVgLc+bdxSHtN210EU0GpC9Ipq2joCh
         +WiYqxWcu48SFqEfa8Hw5e6QvJ+hc+iW3tCWed61uMOr58agWLvPN03NSdY4W5lSdPJh
         ULwA==
X-Forwarded-Encrypted: i=1; AJvYcCUIhZijKij2k3bB4CoyMFOKWnOxihhaDKmI6+UJuavDxXcU3ot8gA+LK9NwowomglfcdeshQdFj@vger.kernel.org
X-Gm-Message-State: AOJu0Yws3zACYkEE5GBCcv4yiY+j9lsgw0xBW/SYD0CuYQ1TFNx2qSOx
	oaJWpsNWcCjRgKY7R5s9qXS8ghQyJdZboUA6M0GuKtO9+HBb1c19ZVM9usw5lZJBLKx7KHqkVWP
	AOAQD1/xcs2s2XbBb1eDZzjmYdSasvbDDmbHu
X-Google-Smtp-Source: AGHT+IH5aRnkOHWC5g1Il1wQQtRvZd/XkZ6q+mhHsKeIe3heNWwjIkZHInx3cnk7oLTlMqdXaMEy0uk/Pc9VvCjZR+M=
X-Received: by 2002:a17:907:3d89:b0:a9a:eeb:b26a with SMTP id
 a640c23a62f3a-a9ad199c380mr466230966b.1.1729842081325; Fri, 25 Oct 2024
 00:41:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025002511.129899-1-inwardvessel@gmail.com>
 <20241025002511.129899-3-inwardvessel@gmail.com> <CAJD7tkZaMH04mBK649iHRhdTwRJh8teSOcc1mg=y8fRey2zHzA@mail.gmail.com>
 <gujcp2vtzatyn73xmidsca25d24kmbtwa6cr52mjlsrxvm7cdf@vbgax2a67pwz>
In-Reply-To: <gujcp2vtzatyn73xmidsca25d24kmbtwa6cr52mjlsrxvm7cdf@vbgax2a67pwz>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 25 Oct 2024 00:40:45 -0700
Message-ID: <CAJD7tkZyttpQk7AYftikVtA6O7w2Wmo9Eu_EwEsusOtNKFnSQA@mail.gmail.com>
Subject: Re: [PATCH 2/2] memcg: use memcg flush tracepoint
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: JP Kobryn <inwardvessel@gmail.com>, hannes@cmpxchg.org, akpm@linux-foundation.org, 
	rostedt@goodmis.org, linux-mm@kvack.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 6:16=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Oct 24, 2024 at 05:57:25PM GMT, Yosry Ahmed wrote:
> > On Thu, Oct 24, 2024 at 5:26=E2=80=AFPM JP Kobryn <inwardvessel@gmail.c=
om> wrote:
> > >
> > > Make use of the flush tracepoint within memcontrol.
> > >
> > > Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> >
> > Is the intention to use tools like bpftrace to analyze where we flush
> > the most? In this case, why can't we just attach to the fentry of
> > do_flush_stats() and use the stack trace to find the path?
> >
> > We can also attach to mem_cgroup_flush_stats(), and the difference in
> > counts between the two will be the number of skipped flushes.
> >
>
> All these functions can get inlined and then we can not really attach
> easily. We can somehow find the offset in the inlined places and try to
> use kprobe but it is prohibitive when have to do for multiple kernels
> built with fdo/bolt.
>
> Please note that tracepoints are not really API, so we can remove them
> in future if we see no usage for them.

That's fair, but can we just add two tracepoints? This seems enough to
collect necessary data, and prevent proliferation of tracepoints and
the addition of the enum.

I am thinking one in mem_cgroup_flush_stats() and one in
do_flush_stats(), e.g. trace_mem_cgroup_flush_stats() and
trace_do_flush_stats(). Although the name of the latter is too
generic, maybe we should rename the function first to add mem_cgroup_*
or memcg_*.

WDYT?

