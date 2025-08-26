Return-Path: <cgroups+bounces-9431-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1DDB370F8
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 19:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC9C164B54
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 17:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8972E2657;
	Tue, 26 Aug 2025 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eClFM8BX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F681C4609
	for <cgroups@vger.kernel.org>; Tue, 26 Aug 2025 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228046; cv=none; b=k4PpMu7aNMa9fccBUalRyKcX0n7FaIaoAfUkLoWh34/EftlXY3bCsG4IQmRNcPZRJq1qUFqk+gq2oKc4XOJZpkfjdhG0+ejhnbHGURlR6ACnQl3p8zYQM+XWbdXfjau+k+DUfk/bHy6yeMFGwtyQgMuef26kJMO7zvAQm5VTXfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228046; c=relaxed/simple;
	bh=+GzVzamkuKNwIJ6WvUw9cgc5JdUfyThfIW8HQ2cqMAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbLrznIiyr6WDGHP8tJlVq2KSaz6WYUP8ykH3Ijg5huWUNwpJYaLxuDsQqMR3Epl21/KxORIzrYYUGP0GewEO3nQAo7Fqcsj5AyHUpY2+39jyQp6uWfLA0JZh+6jb6baHUOGCVNUKplOlZNJQ++QlvqaOCVjlBldiqsaiH3m+bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eClFM8BX; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61c266e81caso4993298a12.3
        for <cgroups@vger.kernel.org>; Tue, 26 Aug 2025 10:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756228042; x=1756832842; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlLO2MjP0/NuaFssKev7jUfZlE2+YuCvYt9+3w8bnLY=;
        b=eClFM8BXuhjdIRJnSN0v2XgHqICc8MSZojMs14l029M7cPke+rkAj40PMcGg/XzIuS
         CyK0pFwMS0HRW06fYlXsdXO1EyOjn6QWLGzBO98zG6xxyxmZoMdZOvKQwJ4P8r/kfpYa
         4woICf3NQ8eAXdK5ayAyU4gOGu7YlFr7fwkMNZpR5Xxx5SPAzbRqhSGxbCrjhubSxQMf
         h5p7mNDucxgsHeV+619UhI1u1yEmlNLGsYFb26UPuNZ1QZTYaBEh40TgoXK2Zbcr5KQ8
         ey4HqlUs11oF0kLzr/7hNd5zOGXRDR/7qefIOcYx3KVnsv45pWOW0t/5F+pLyAU3cf1/
         Jqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756228042; x=1756832842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlLO2MjP0/NuaFssKev7jUfZlE2+YuCvYt9+3w8bnLY=;
        b=ewpDlUHKMjG3XmRwv/jr4um08+O58jdVKoxNm/oGiOJJRREdYi+WJ8jFJDZSrO/JOb
         e1xM7QIkNU+07gtilwMinflqpDCtf0BdxgbfUlf/CTQ1KVZmArRofD9usXo8+InkmNpi
         m0gmqfyUCOUGMmP8N81aLdOiVlZmOm8UxEcYLkYx9pL7EBXHmJs5mBNdd8K6fNzc60Zw
         nr5Ev17qcSs1op/s9yG7A/p+eU1t2pzyt1CHe63/TXIfsW66FRBGqEmNpEGgzX+rjDVk
         mQbkdmQfBm354raasFTEBIyPIcc49rh9pNpDsKboP6pUZCsg5hZ3vb0CcOqb14jjDC5j
         jzng==
X-Forwarded-Encrypted: i=1; AJvYcCVKrjGp51OysctBFUj4FOKTM6ZpCYzJe1RECVWG8OWvXrcTFR69kyv/SOB6JdBnjpzO7s7SjPF2@vger.kernel.org
X-Gm-Message-State: AOJu0YyvTZme2z7YDr3CTzjTQG1r4mv925MqSWwsK5KfDbTRmNPXxUSv
	9rQtqpJKpEOD1HVFGPk6qmPEVPIwjtC7elGHaaEtyRPwZOgh1sbD00p9VtiM8ELVOfXXhivrNGT
	vmpuJfYh7jyhbEUXyU5+S5XgJ2T42a375IsaoCXEBPA==
X-Gm-Gg: ASbGncsRNScEfjS2YOoiEf3k5sjXSHXZVCcDTB7mg3/5DuSRTsRGs3It+4b1CyP8od6
	maPB3fJt6w8zoRFtvfQW7Kn6iGA3qmSBZqkC+cw72t8qL6Y9ypRO17i6REwlklIqNKDL8vcFVcR
	DJFox4qcYtBJaiYeZCDy5q/97gTS3gyt/JpM1rc6SNYhDYie6zmHjrKqhlTEJe0/9cTQ05PqmA2
	YszDJn3D79Ehm6XOAO19TjK1BjE49wJuUpc
X-Google-Smtp-Source: AGHT+IHsOpctQgmVCjjq5dHlSjInR6A/ntZmhGPHMrs80BhSJMw+bnBIclGQfPF1IClLrpJt//57iI/CKy4Pr+clCuc=
X-Received: by 2002:a05:6402:1e93:b0:61c:374e:d4ac with SMTP id
 4fb4d7f45d1cf-61c374ee1bemr10746613a12.5.1756228041612; Tue, 26 Aug 2025
 10:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826084854.25956-1-xupengbo@oppo.com>
In-Reply-To: <20250826084854.25956-1-xupengbo@oppo.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 26 Aug 2025 19:07:08 +0200
X-Gm-Features: Ac12FXz41DqtuNy56jAsyjKtPS-SaWIN6JtQzjR4zynSsHstIU9Ay5tJmjPW_Yw
Message-ID: <CAKfTPtAnXdFp0VTSiOSucU_E4Xj2emjRNn0ySCrgD7hiXP=1sw@mail.gmail.com>
Subject: Re: [PATCH v4] sched/fair: Fix unfairness caused by stalled
 tg_load_avg_contrib when the last task migrates out.
To: xupengbo <xupengbo@oppo.com>
Cc: ziqianlu@bytedance.com, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Aaron Lu <aaron.lu@intel.com>, 
	David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	xupengbo1029@163.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Aug 2025 at 10:49, xupengbo <xupengbo@oppo.com> wrote:
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

s/I added /Add/

> which blocks the case (2.) mentioned above.

s/blocks/ fixes/

> After some preliminary discussion and analysis, I think it is feasible to
> directly check if cfs_rq->tg_load_avg_contrib is 0 in cfs_rq_is_decay().
> So patch v3 was submitted.

You can remove the 3 lines above from the commit message. They should
have been put below with the version Changes.

>
> Fixes: 1528c661c24b ("sched/fair: Ratelimit update to tg->load_avg")
> Tested-by: Aaron Lu <ziqianlu@bytedance.com>
> Reviewed-by: Aaron Lu <ziqianlu@bytedance.com>
> Signed-off-by: xupengbo <xupengbo@oppo.com>

With the minor comments above

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> Changes:
> v1 -> v2:
> - Another option to fix the bug. Check cfs_rq->tg_load_avg_contrib in
> cfs_rq_is_decayed() to avoid early removal from the leaf_cfs_rq_list.
> - Link to v1 : https://lore.kernel.org/cgroups/20250804130326.57523-1-xupengbo@oppo.com/
> v2 -> v3:
> - Check if cfs_rq->tg_load_avg_contrib is 0 derectly.
> - Link to v2 : https://lore.kernel.org/cgroups/20250805144121.14871-1-xupengbo@oppo.com/
> v3 -> v4:
> - fix typo
> - Link to v3 : https://lore.kernel.org/cgroups/20250826075743.19106-1-xupengbo@oppo.com/
>
> Please send emails to a different email address <xupengbo1029@163.com>
> after September 3, 2025, after that date <xupengbo@oppo.com> will expire
> for personal reasons.
>
> Thanks,
> Xu Pengbo
>
>  kernel/sched/fair.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b173a059315c..81b7df87f1ce 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4062,6 +4062,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>         if (child_cfs_rq_on_list(cfs_rq))
>                 return false;
>
> +       if (cfs_rq->tg_load_avg_contrib)
> +               return false;
> +
>         return true;
>  }
>
>
> base-commit: fab1beda7597fac1cecc01707d55eadb6bbe773c
> --
> 2.43.0
>

