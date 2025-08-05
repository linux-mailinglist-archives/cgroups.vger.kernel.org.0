Return-Path: <cgroups+bounces-8984-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75235B1B80B
	for <lists+cgroups@lfdr.de>; Tue,  5 Aug 2025 18:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19CCD18A4249
	for <lists+cgroups@lfdr.de>; Tue,  5 Aug 2025 16:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4571291C1B;
	Tue,  5 Aug 2025 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxKJkYPi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FA5291C14
	for <cgroups@vger.kernel.org>; Tue,  5 Aug 2025 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410236; cv=none; b=eRvUOEhrAAMCC4OWkHHb+RiR4AyA4QOX62Ge6zK6EVVczTHHkkrLA1svOfmHCG1KCcZPCzSh0IqgiURiqPVb/ottr4tmJ8e9s2mQTSOfAvDTevvnmRKlfDasZ5+D1cg3NCKbrN1ijWF++pnhMiTW6xAn1wI+6BRvcyZvkM40+vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410236; c=relaxed/simple;
	bh=ywUt7nc/4k5dcYfqsRr+QoULjYvLNmWVhfkjZrJs2TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgHdD57kaQuVy5p1PTUFuOjwI2j5qaZ9bL+SIh1qZeNo9YL0MO/GnavaXnAjsSIz0a6F38h7K+yFHNvbwfULWbudUhppsX+RZClYA0je+phwwEO1BgMyzec6LM2RVM1dxX5vhVAxFD/atL2bJ7fxtAIRXzWg2vSh7Va0F0zZUSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jxKJkYPi; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af922ab4849so847697866b.3
        for <cgroups@vger.kernel.org>; Tue, 05 Aug 2025 09:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754410233; x=1755015033; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3xmBHxeVF7B3NdqpUT+81wO8TLLO5zf62m1mZ2iK588=;
        b=jxKJkYPiMZEaj5UNmYUyigz9SMH05QSTu9ByFdxAwTF0Ygaq4RNbyTO1+EuP30Cfkp
         2PglyIrlnpBzCUki7tOLWTzFRRWxKCFmNt7DcV9b2v6MpRLo5NiYNY142fX81mL2U+8g
         aVk1A177rHU8wt1NXCB+0FnXwzMWPSgKMzZenoUAzEhTN5IIDaCTvzayhBgN0sC3z+2o
         Odhwv+YveIHYFvmQFCRSqBvLQ9FH/922dt9SvY4TGyU7cdla7dWx/IWoFHrXBYZ921Gh
         OX1JIUbxMfeXFPs4OpvHgWh7eCX87ZnIuIIRc9f5jaX+2UVPywpwzAdEBWZivJcVl+4Q
         WHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410233; x=1755015033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xmBHxeVF7B3NdqpUT+81wO8TLLO5zf62m1mZ2iK588=;
        b=TeAG5vL2GrAvYTO9dumdF5mOtfv7Rr4/kmloXlA4IbytJRWeDWeYn9Uroo/oQr0uh7
         xDIxsWSADeWQDpByhEIFfFgT2fm8LB1KUo3iTaFOIRS9M2FVqfmHBXr/Z4s3XIKiDPNm
         9wcCkbxADJ/UiN5tfJo0C5fgTm26g7n4CIny9nhA+BsXG/pcPNjQCKejUX/giou89Hcd
         S1vtF5wHqJXj7jYgFse2+zJHIcP1FsshjDRlX50x+Lpj9h6AyeJtxhgWb+zuYCxjyf/I
         u5oa2h2wdbmAa+G2SRdhEGqGOLihpO1WTDKcSdSzeT2aL3hdfP14lEkDH3+bZkwey2Kh
         xgnw==
X-Forwarded-Encrypted: i=1; AJvYcCUCzIW2wXrGgGl4I4YBl2gM35oeVVVImMzxMfqQtaCQ9Y4wEKaE8V6Sj3ySy79LJ+3g0UOdZftC@vger.kernel.org
X-Gm-Message-State: AOJu0YzqIuozRCUUaGblwlMOsDPb30lGrgToa/vfAxJ88fFwNVscAf53
	41FeMoJPNYFL0syDREjSB8NcmGLML/ePI1KmvBVBTqM8AXqRRKfhH7Z1BrGe+ZNmjO8YAKkIbGs
	zJlCQiu2cEjHzuHag4ijXv7uQJ9DYyCROTVzCgNmYbQ==
X-Gm-Gg: ASbGnctB4/ogSnQP4LzVf5re7cXBB6/Z1OLze1gT/BS8gp9yfXqzbknclJn3l79YM/J
	zEMB9VgLh76EGAnbEICO/dX5NQiikdeLTb+ZkCfSN58+piRt8/sgpr03V3huI4lyeqec5jurr+n
	Sn8dEGFQM3GKJGRfHsQFopyR4VlW3r8lMF9HEh4uSgUJrF129zG1kZik7M587hpc1urNikdfA/3
	1HsXhG/ikPmwIfpYlsH25LYlJXSZfP1A9vA
X-Google-Smtp-Source: AGHT+IHUxDQmNqjsBB5QEssDePUIJzKjYiU54c9w3wPPFTq7eaaUJXP1qLpmkmaPp2yiN7oVC4MdBkFnSDJkoXB0TYw=
X-Received: by 2002:a17:906:730e:b0:af4:11e1:f877 with SMTP id
 a640c23a62f3a-af94001e7c6mr1304124666b.21.1754410232950; Tue, 05 Aug 2025
 09:10:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805144121.14871-1-xupengbo@oppo.com>
In-Reply-To: <20250805144121.14871-1-xupengbo@oppo.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 5 Aug 2025 18:10:21 +0200
X-Gm-Features: Ac12FXw3g9CYkYE-F87wCt7Mn5ALFWOdqTqdjw9J9ZtvHlGdjVzd66JJFa8Vx3o
Message-ID: <CAKfTPtA_czLC=EEeBvvKQzGv58v6NNk=z2qikjVNj6XrxyDG1Q@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Fix unfairness caused by stalled
 tg_load_avg_contrib when the last task migrates out.
To: xupengbo <xupengbo@oppo.com>
Cc: ziqianlu@bytedance.com, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Aaron Lu <aaron.lu@intel.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Aug 2025 at 16:42, xupengbo <xupengbo@oppo.com> wrote:
>
> When a task is migrated out, there is a probability that the tg->load_avg
> value will become abnormal. The reason is as follows.
>
> 1. Due to the 1ms update period limitation in update_tg_load_avg(), there
> is a possibility that the reduced load_avg is not updated to tg->load_avg
> when a task migrates out.
> 2. Even though __update_blocked_fair() traverses the leaf_cfs_rq_list and
> calls update_tg_load_avg() for cfs_rqs that are not fully decayed, the key
> function cfs_rq_is_decayed() does not check whether
> cfs->tg_load_avg_contrib is null. Consequently, in some cases,
> __update_blocked_fair() removes cfs_rqs whose avg.load_avg has not been
> updated to tg->load_avg.
>
> I added a check of cfs_rq->tg_load_avg_contrib in cfs_rq_is_decayed(),
> which blocks the case (2.) mentioned above. I follow the condition in
> update_tg_load_avg() instead of directly checking if
> cfs_rq->tg_load_avg_contrib is null. I think it's necessary to keep the
> condition consistent in both places, otherwise unexpected problems may
> occur.
>
> Thanks for your comments,
> Xu Pengbo
>
> Fixes: 1528c661c24b ("sched/fair: Ratelimit update to tg->load_avg")
> Signed-off-by: xupengbo <xupengbo@oppo.com>
> ---
> Changes:
> v1 -> v2:
> - Another option to fix the bug. Check cfs_rq->tg_load_avg_contrib in
> cfs_rq_is_decayed() to avoid early removal from the leaf_cfs_rq_list.
> - Link to v1 : https://lore.kernel.org/cgroups/20250804130326.57523-1-xupengbo@oppo.com/T/#u
>
>  kernel/sched/fair.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b173a059315c..a35083a2d006 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4062,6 +4062,11 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>         if (child_cfs_rq_on_list(cfs_rq))
>                 return false;
>
> +       long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
> +
> +       if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64)

I don't understand why you use the above condition instead of if
(!cfs_rq->tg_load_avg_contrib). Can you elaborate ?

strictly speaking we want to keep the cfs_rq in the list if
(cfs_rq->tg_load_avg_contrib != cfs_rq->avg.load_avg) and
cfs_rq->avg.load_avg == 0 when we test this condition


> +               return false;
> +
>         return true;
>  }
>
> --
> 2.43.0
>

