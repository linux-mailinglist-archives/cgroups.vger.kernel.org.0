Return-Path: <cgroups+bounces-10354-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A452DB91B84
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 16:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7251E7B11BF
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 14:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AE0254B09;
	Mon, 22 Sep 2025 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="awP7csTI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2AF22D9F7
	for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551368; cv=none; b=qsJmhdZhEg8VNz8hfeNuqI+kuFPySAfgfkt45jQWaInIksZGFWh9xGDKkYicMqYUn86xMRtX2BdORKQpjLHighqA0QZG/Y5/3FGMBcPDWmQKLc4nru7tcKKK5euZ+CdbZ4pavxCaK86NyFG7UujER5u5CGcUBkZsUXHe0YU4tG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551368; c=relaxed/simple;
	bh=oUj350T6EOY4u5853/0XWCIRgQCJC/nctqpOg3WNCLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcZdcnQs047AhFv40x/szJT7uq3YulMDhQ1IaJXLCUGBFG7Ow+XPEHpkgrntY4d7SMsEOAzVp78Xt/S6fMYJ/BxyctuQWUSUrnu/4Y4Urdwa3yBJca0uhTP4dDWZsz7fSoDKaC4LX/xubHYvZvQyd5jPXh3yvtI/mRa3fc5mDJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=awP7csTI; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-73f20120601so17123087b3.2
        for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758551366; x=1759156166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHqdFBeIkyqzt8Mc+yBevveD8rkxvyWh5nDLvmBZJ5c=;
        b=awP7csTIB9calTgbWnLK/CFeTk4/gtSN9ljH9LykOEz+odxqzYmc621QaOAQP+yb1q
         gx2w0d39gpVO/w0CjP4h+GA8myFWS7ehJmA3bdB7eeJAZ9Wgal/Xxr8lK+Q9/GEaIpLn
         fyXzQjNd6tQU8gRgogPCNpFlSBavotEnb2fyTdsryyP+WWmxz41Sj7pvdw9CvekDobKh
         BXvMEOPFPcRbecNsAuyUn8B+6ustav0FKiZePtvoCNRJGIhoscnFDHiC5WivszGLtgbN
         MHrwv3jMZ3au+N/2Xv+iZYRLZZMxYPyx0qBLR+y5FjOuzUUsaOS1TcKwsSCs3iPe9uUc
         2LGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758551366; x=1759156166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHqdFBeIkyqzt8Mc+yBevveD8rkxvyWh5nDLvmBZJ5c=;
        b=QwBJ40cNeRoDsH3Xc7RU9k1zBB7jtc/tmlnbxMHwqL31vVv/QILhUXZbP4hHCaMPLd
         AK5s6zQCIOoRdL+Cs/8BNOf74pN8K8lZtxOZB1k/dw35pn9WStABpjmjfb1zXSS2NdSR
         pC7YmlmdQsPxxo7ZvrIEOQpfPPXJ9t/B3yMVMI0n0ivDFi/oj4K3YWVwPfe6x4xvmIkL
         VqghLMX5SHbvh1EMOg+7hZqvXtlBpnFyzomScBqYSXNLszaybFlv2hXP9RwjH+HAjH7W
         RhxOFTcYu21Mozduy+WvQOd9VhVcwdQlbvFu7BrWkRiiFPqZ0wpMeCYuMjfiXaTM2YVM
         A4sg==
X-Gm-Message-State: AOJu0YyjBh9LAyA0lqvL3OyJeJD0YHhuL54/7xdesC8Z2BUo+LoOQL4r
	jnZaudETRVa+y34SvTI+j9+X2VUJLjTeiQh2P9G1Um7PwAP5j6goA/XAOYVr9Cc+aa4qccGWQkN
	6R5xs1+xxGC8Uc7FkFIs/lxtLb5jQoWmu712yKf/Dqp8RunAu7ExEOkZVvxOI
X-Gm-Gg: ASbGncu5beY1wkR0F3KlEe6Z5yH+BYcGZc2hsI7cKcLgEMXYBJ0GAFDipFYnB0lx0a2
	h5+A3931ua/hQZ5pXFWJXU78v1caz68tC0xb/mt/2f8V9j6+9D308wEs1PBNHcCCWqwFPaDAIZ7
	/VN9pfvpZr9/XjDAtl/zGo5PhANK9LupvOe+HOHayGQWW6u3PVp4wDwZpNtoM9zeMHj3+AmfmR7
	Wwvf9d9
X-Google-Smtp-Source: AGHT+IHJ2lJmsHlAxcqszjCgu/K4P3zLcQJ5uNA7XJd9iurFBQKMVNe95iJrTTyw5mOlZmwRrwMEpFmq5dIm49cJsWI=
X-Received: by 2002:a05:690c:60c3:b0:742:a0be:e3f1 with SMTP id
 00721157ae682-742a0beec20mr110975537b3.13.1758551366130; Mon, 22 Sep 2025
 07:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922094146.708272-1-sunjunchao@bytedance.com> <20250922132718.GB49638@noisy.programming.kicks-ass.net>
In-Reply-To: <20250922132718.GB49638@noisy.programming.kicks-ass.net>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Mon, 22 Sep 2025 22:29:23 +0800
X-Gm-Features: AS18NWAs6wAemc8c5yHBO8lN5G0tRCe88xdDCZ4rxbtmuK7NE8PZDJxRhF7dHJk
Message-ID: <CAHSKhteGasUZa8u6_YUhwH3V_b_QLwBu7dDAEob4SBC7K8KTGQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 0/3] Suppress undesirable hung task warnings.
To: Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	akpm@linux-foundation.org, lance.yang@linux.dev, mhiramat@kernel.org, 
	agruenba@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 9:27=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Sep 22, 2025 at 05:41:43PM +0800, Julian Sun wrote:
> > As suggested by Andrew Morton in [1], we need a general mechanism
> > that allows the hung task detector to ignore unnecessary hung
> > tasks. This patch set implements this functionality.
> >
> > Patch 1 introduces a PF_DONT_HUNG flag. The hung task detector will
> > ignores all tasks that have the PF_DONT_HUNG flag set.
> >
> > Patch 2 introduces wait_event_no_hung() and wb_wait_for_completion_no_h=
ung(),
> > which enable the hung task detector to ignore hung tasks caused by thes=
e
> > wait events.
> >
> > Patch 3 uses wb_wait_for_completion_no_hung() in the final phase of mem=
cg
> > teardown to eliminate the hung task warning.
> >
> > Julian Sun (3):
> >   sched: Introduce a new flag PF_DONT_HUNG.
> >   writeback: Introduce wb_wait_for_completion_no_hung().
> >   memcg: Don't trigger hung task when memcg is releasing.
>
> This is all quite terrible. I'm not at all sure why a task that is
> genuinely not making progress and isn't killable should not be reported.

Actually, I tried another approach to fix this issue [1], but Andrew
thinks eliminating the warning should be simpler. Either approach is
fine with me.

[1]: https://lore.kernel.org/cgroups/20250917212959.355656-1-sunjunchao@byt=
edance.com/

Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>

