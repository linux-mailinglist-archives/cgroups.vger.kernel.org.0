Return-Path: <cgroups+bounces-8366-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E016AC5F1C
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 04:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD937A14C2
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 02:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462831BC9F4;
	Wed, 28 May 2025 02:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cz6jtAEl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF811EB3E;
	Wed, 28 May 2025 02:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748398420; cv=none; b=le7hq62muJrzTQdajZuV5WnSnHcdGMQVPmyg7xiypf8K98zNCTmGrDxnssHvoIvwTGUtD/2AScO0e0f3XBSh0xGHm9wHdDSi3HC4Xh6Jrqct+wjRAOZM2NokoBBPp1RafY25YOI5+cqWFDXezGaPbWl5WQDB1TGXnur34cBXDPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748398420; c=relaxed/simple;
	bh=0vv8YDwrXvASiaI0Y21BNyVbZj1ZH1ZWyCc6Wy7jXU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIIdD2bInlcasphk0+lR38nVrdwUeEnFQiRLeEOGikQcM6DJMtR8LEYKgniZo2+oj7mJcwMISL+v93WxNTMJD0zRbrX3qxnJ623ieNu7a6ThL+ZMx/LIjGUXna5sz+v2DxX6X5Rt+AZOxeNMaIdX80N4erNwyY7iMtUS3BX3PvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cz6jtAEl; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fa956f0f16so40274556d6.3;
        Tue, 27 May 2025 19:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748398417; x=1749003217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vv8YDwrXvASiaI0Y21BNyVbZj1ZH1ZWyCc6Wy7jXU4=;
        b=Cz6jtAEld+PVJON90lYPp94AaESuKfpqXFqA0Plsy60eO9bx1BUlDqq3ACtHlVQ1RP
         8T8OhsndqGuWbmV6dk9eDWrEKuQVWWUAyErhPM2qEu2fme/TxVKdh3UgC/7SJIMfcX6g
         6QKtLWzAeyl5jfFCQqE/N1htJh1ikymIwyK5LMpAodCU56pLwE8UH9Jc08b4pTxwC2rB
         GTed3Pf4soa5+amNUbfY/rUCyjKKNvwhxOVdtfQK66RqUpDWByXVk7dIgsTtsoWxjWGu
         Lw0aRhrUjiyeYD/7nqmZudNPbcg833aYDKVJbdFiMqkCd/PIjnkZrG+QNm6eSLrGkDiY
         RIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748398417; x=1749003217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vv8YDwrXvASiaI0Y21BNyVbZj1ZH1ZWyCc6Wy7jXU4=;
        b=U09M8LF/BxhDQcMA/NUJWvpO7cNx48cQsW230hnqxTfIXHscWSf838B88gJbDAMfjq
         rghVpX+ynMCLhyFmN5+dkm9NeHuPkJg2hfRl+HwAW1NpR2DCMqbIgRBIkNnqsfG3Cqne
         ypUWw38rZ1xMl239X0e9Prv7Hs9j898hbvI5rRUtzuoSApSIOD3CFKH6164ciRC8NNqG
         TeZE07CqHjO7Q/t6vD0h9FZhqua6V/GPG4R2fDNU2dZ9ZDtR5emlaV26OwKg+1vqpYRE
         P+FLBCXNSKmPbfxIEKELKSw5P7Dx24MhOuqgMw61Iv8V4LQ3Uh11WjkBP8QWnHMmcfmn
         A+1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAWjtgI0D0qXLT/uVBSbJNTHUdZsFIcakKp6zGa6KmAhIPfrhB+zxljKVGv+ny03OxUe1SAkzQ@vger.kernel.org, AJvYcCWYpjXm/o3jASBgXkFF22C2qeh/zymvW5/QNWXAxxQxTXJUOKF3LZzyyeNt1V85tZni+srkGI1VQVA4rkA5@vger.kernel.org
X-Gm-Message-State: AOJu0YzIARXTRETztdSL+a+GWq7dS67gxesBxYdWqAmwBZENMR0ReJ0W
	eeJo1kkIKe4n3rSY9fln7To47dadz2+rZN21eZMfiIEvFbMbjrPRrY1YdXgLdamfTvwMEXaaKrj
	up9xW2fgaURsfbUAVzbb0iMC35b9i24Q=
X-Gm-Gg: ASbGnctuxbkggS7UiuVJt52fRqbL1g4VL6O8diMMfxij2FiTBhIbA7m84tx4pojT27Z
	NGTZLJKziXY9uJ1pC2U8KMy6yCO3MJbF40ChqQufVkqrYOW7rFvIYRC/3Zq8PmwJxW9STe9rHSm
	4WRJYM6zWPuCP3R05vMZs9DFNBxsoIH7fEnMVc/fRdUsvcQw9UXoVrIN4=
X-Google-Smtp-Source: AGHT+IEmn7LOIXOqzn94ygtrgYOdYuISQJpF/KL7y3Q6iZwh20kDfRclQ7Wn9Fm0BTI+5nzBDZcxtCzZgBc3XbPO7+w=
X-Received: by 2002:ad4:4ea9:0:b0:6f8:aa6f:438b with SMTP id
 6a1803df08f44-6fa9cfff0b8mr227915346d6.3.1748398417228; Tue, 27 May 2025
 19:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511030800.1900-1-laoar.shao@gmail.com> <20250511030800.1900-3-laoar.shao@gmail.com>
 <umy4kicwvlsaszajo62pcpgptcdqi2yp7pponvlch5h6tirabb@mhhq2en3piel>
In-Reply-To: <umy4kicwvlsaszajo62pcpgptcdqi2yp7pponvlch5h6tirabb@mhhq2en3piel>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 28 May 2025 10:13:01 +0800
X-Gm-Features: AX0GCFv7oMXfKN2u6YrYssepdLwylVhGKiw41GScgqmD-kM6FEB8melzxvcy-FI
Message-ID: <CALOAHbCuYS6gcc4zMT3Pgo1ZcueuCMsTd3xSi-FkhLb3fBU8gA@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] sched: Annotate sched_clock_irqtime with __read_mostly
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: mingo@redhat.com, peterz@infradead.org, hannes@cmpxchg.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	surenb@google.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	lkp@intel.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 11:33=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.c=
om> wrote:
>
> On Sun, May 11, 2025 at 11:08:00AM +0800, Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > Eric reported an issue [0] as follows,
> > : rebalance_domains() can attempt to change sched_balance_running
> > : more than 350,000 times per second on our servers.
> >
> > : If sched_clock_irqtime and sched_balance_running share the
> > : same cache line, we see a very high cost on hosts with 480 threads
> > : dealing with many interrupts.
>
> I'd say this patch could be independent from the "series".

I will send it separately.

>
> > While the rebalance_domains() issue has been resolved [1], we should
> > proactively annotate sched_clock_irqtime with __read_mostly to prevent
> > potential cacheline false sharing. This optimization is particularly
> > justified since sched_clock_irqtime is only modified during TSC instabi=
lity
> > events.
> >
> > Link: https://lore.kernel.org/all/20250423174634.3009657-1-edumazet@goo=
gle.com/ [0]
> > Link: https://lore.kernel.org/all/20250416035823.1846307-1-tim.c.chen@l=
inux.intel.com/ [1]
> >
> > Reported-by: Eric Dumazet <edumazet@google.com>
> > Debugged-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Eric Dumazet <edumazet@google.com>
>
> I can say
> Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>

Thanks for the review.

>
> but it'd be good to have also Tested-by: wrt the cache traffic
> reduction.


--=20
Regards
Yafang

