Return-Path: <cgroups+bounces-5173-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E839A70C3
	for <lists+cgroups@lfdr.de>; Mon, 21 Oct 2024 19:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3B91C22BFE
	for <lists+cgroups@lfdr.de>; Mon, 21 Oct 2024 17:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3F91EBA05;
	Mon, 21 Oct 2024 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AosBQXMP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C581C330C;
	Mon, 21 Oct 2024 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530896; cv=none; b=dylFkmmmS8AFB/yQw1eTynw/4XRipTIsYuXWF+jGrQGMZIuSZqv5UpVAl/Y9y4fk0dB53rFv7NrSMwYCmRwuPTCsx+I7BszehZ+OtA3uliFbAvA0fYLJdRzAgxJATaesWHwDsN/yCroWvecveaa1zHCqIZvwwYv1JSiLq5eejlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530896; c=relaxed/simple;
	bh=B6n5AIigxmtSGMA2rqNWorBAT8emm7EL7dKIb9/88wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZYUQIWKrZXhAMVxTYZEGXzR0fIvjiZ4vr8A8A9oDwBE5y7stq3Zm6d8r0I9mSpAETmprMGbIm3WidkKp1k+YToivUTBAKWVnJWU7gUQVLRycz9fcukzJ/3P8jYVq1RA3V5FZ8ygClcVt/tiXnOOo8lUoRv5QedMFyN51U/rXrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AosBQXMP; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso3268414f8f.0;
        Mon, 21 Oct 2024 10:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729530893; x=1730135693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6n5AIigxmtSGMA2rqNWorBAT8emm7EL7dKIb9/88wU=;
        b=AosBQXMPuu58VO4YcBuTH5DcWSLsC5v7y+Qmpar7o1G+/lVESNj+heKFga3Q1ojgJs
         /BU1yizA37ROOSHwWbu299uQzQPjbXpg0j4eLwHlVapseSS1LzQ9WnhVQY2O4oqzYQpI
         oFojfToydlLmr1OrRk05KqUTtkD1ACE1f7sHhbn+2WXfxHgNinE8+aLmUw/2Y63DHF7U
         RK86vDzHS2qEN753JnKv3u6LE5sgnREJKdxDrCHjVTPwqup3DR2DNQLBvgJGIspQank8
         q1a0lhqINz52RpA1JrJBXa6NIAiDaepvjh5nedoeHPfiZSbXkSgDjo0dHrzviM6X6T/O
         lP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729530893; x=1730135693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6n5AIigxmtSGMA2rqNWorBAT8emm7EL7dKIb9/88wU=;
        b=hXtgxsTE9Yr8UNu33xXUqaBXfUZxlW+ejHlU1JhNwrRvwIY7k49qrk1xYToDc2por1
         8f6xdN27sa+0NncaBV8b/C1KcwpxVV+jPkxJ+eXeP6Ems4w4CqIrYhWeMQu0SoFlYTEJ
         3FUDuriQstoSjum2ntnSFGZfHXCDq/9hFy4JsUX++e5B65s46d3ucRwKG/N9waF72JNO
         LUFuZhHqYifwJpRE4TiLK4TMQ4dA0xSoxgKP5Y2IGVvmsE+oLwMNZu2CW470X/qNj1b4
         yFqaIiAOnb2QUkCuXdOBpF7o3dazRLa2btvVekNeeV7/U+rOHlhaJRNqtlkh/tXjWqvj
         jwTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa+zhyjDNN1VxN5siKS8wyd+XMyLGanouuI+ixA+cmryIN+ZpN2bCFEzdJbBgvTESPjjs=@vger.kernel.org, AJvYcCV+JgdM5U0RVjdhBkGB+lpWXSBpu+Zdu54ND3Vuu0GVcsPMJgdCP6SQPGI8PUAvcrtwrhQFyNAtmA==@vger.kernel.org, AJvYcCWMCWcCaC+4iAXxk/mJDcenNWGfSZqLqH3uQ2054dDB8dmAkLKLvDmnfTq4zZMl/jrdX6a1g/DjvjVjNGbF@vger.kernel.org
X-Gm-Message-State: AOJu0YzBgwWU6SycZBBmcxLtH7DKhkmseBTznVdWS1IEeAxzJoRLDmR8
	lpfhbLQ7wNJq2LOS2v6+pg5oHydH75mo4iXABH7K/ISUR2y7K6ew9L/Jn2B7E6HzlKHZwEHOT/Q
	Tk9QqA1aPCHCL9afqx5pLN7D2L/gAmrek
X-Google-Smtp-Source: AGHT+IHgxzWLkB3jf49EyTw342Xk24EJmgZq7abf/IdFQITy0RMxkGbtzrqCX8t9ox7L090ek+sufwflfK41Egy5TU4=
X-Received: by 2002:a5d:67cd:0:b0:37d:4318:d8e1 with SMTP id
 ffacd0b85a97d-37eab6e3db3mr7317838f8f.23.1729530891030; Mon, 21 Oct 2024
 10:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007152833.2282199-1-visitorckw@gmail.com>
 <ZwQJ_hQENEE7uj0q@slm.duckdns.org> <aci6pn57bqjfcshbak7ekxb7zr5zz72u3rxyu4zbp5w3mvljx2@b4rn2e4rb4rl>
 <af842df1791423386f3aef25f3f94c5b39b5e332.camel@gmail.com>
In-Reply-To: <af842df1791423386f3aef25f3f94c5b39b5e332.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 21 Oct 2024 10:14:39 -0700
Message-ID: <CAADnVQLSU5WDkjtFVLYqj8+AOUCz-Pi6v4VaexviQPy7DKtXDw@mail.gmail.com>
Subject: Re: Using union-find in BPF verifier (was: Enhance union-find with
 KUnit tests and optimization improvements)
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Tejun Heo <tj@kernel.org>, xavier_qy@163.com, 
	Waiman Long <longman@redhat.com>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, jserv@ccns.ncku.edu.tw, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 1:09=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2024-10-17 at 15:10 +0800, Shung-Hsi Yu wrote:
> > Michal mentioned lib/union_find.c during a discussion. I think we may
> > have a use for in BPF verifier (kernel/bpf/verifier.c) that could
> > further simplify the code. Eduard (who wrote the code shown below)
> > probably would have a better idea.
> >
> > On Mon, Oct 07, 2024 at 06:19:10AM GMT, Tejun Heo wrote:
> > > On Mon, Oct 07, 2024 at 11:28:27PM +0800, Kuan-Wei Chiu wrote:
> > > > This patch series adds KUnit tests for the union-find implementatio=
n
> > > > and optimizes the path compression in the uf_find() function to ach=
ieve
> > > > a lower tree height and improved efficiency. Additionally, it modif=
ies
> > > > uf_union() to return a boolean value indicating whether a merge
> > > > occurred, enhancing the process of calculating the number of groups=
 in
> > > > the cgroup cpuset.
> > >
> > > I'm not necessarily against the patchset but this probably is becomin=
g too
> > > much polishing for something which is only used by cpuset in a pretty=
 cold
> > > path. It probably would be a good idea to concentrate on finding more=
 use
> > > cases.
>
> Hi Shung-Hsi,
>
> [...]
>
> > Squinting a bit get_loop_entry() looks quite like uf_find() and
> > update_loop_entry() looks quite link uf_union(). So perhaps we could ge=
t
> > a straight-forward conversion here.
>
> I'll reply tomorrow, need to sleep on it.

I don't like the idea.
Let's keep get_loop_entry/update_loop_entry as-is.

