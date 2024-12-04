Return-Path: <cgroups+bounces-5751-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD45A9E315F
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 03:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38BE2B26D80
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2024 02:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726F5848C;
	Wed,  4 Dec 2024 02:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hk40L39Y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45D127453;
	Wed,  4 Dec 2024 02:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733279021; cv=none; b=Z8KvFUt3MgfUKQ9PjyInzUeYXRMDCbGmgGhdKWCoWGE61K2ErSPYY4iGG6wyMceCd4YaTDZg95dnJ4E47e9Y16EhkvvHDbeDYDZzdR7/3idmeWEwy7SIlV/4uPlKq33X5zJ/ojjpQ6USJD8PgqZstb8HFoRsfwRYDQFYlDr+VS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733279021; c=relaxed/simple;
	bh=55obrpIWgWy3J7/RbHbslApWkwqDE0PRWcjgLrlPw1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3iGgqqzp597f0whNdVwPjejRQhiCf4HIp9qXLiQ1JvzZkvEX+tGCETuDR/Ln5NEyf7wYoh5AECwHfECWFMdXUGE3IFMrz3nDQswLx7TwW7hGhVa6EzoWoIVbCJn0wtjshUDhgFVuejivcAK9N2lddXdBoocQbbB5WgCZrajxWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hk40L39Y; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d8a7c1a579so18729496d6.1;
        Tue, 03 Dec 2024 18:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733279018; x=1733883818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5eTGbVG1HfhIoKlt720PIeFcwXBaYyG1vENHl85c38=;
        b=hk40L39Ytj8ngVPrWrgk6TZXHRAsX9AtLEgLB9LRdRub3k2Tk0j4BnC+AMB/FYVtSJ
         eR8fQj1i5AaYldudqJQOtvjSPjlSHT3uJFqMVeKC8kq56SiM9oh/N6vIKX5suaInsY+F
         3Yr8EIcziRdoRTNcjThZjCE7YBTFaiONDA0qWx/+3Ywe6r011gqKMHjhNzsQ9wf73VFQ
         pGuiKlck4bhPAyYtT64+ljat7t9AqrN1FiwfSl/t0Zu86KVw3jybERUs+zrpzn27VRE6
         F7MHaQW/4Oj1UaXGTuahDiDou1T/vD/lyXBGS74de1bcjBmOSmab+I5pjtpZiZsblF0f
         c7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733279018; x=1733883818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5eTGbVG1HfhIoKlt720PIeFcwXBaYyG1vENHl85c38=;
        b=Fi8PzXR6RmDB7oNC6GGd09IxXO+Btsz5VzPDlGyBETBGFJ2HIHSmZrf38rYJ/iG1+/
         tCZfnCRjx1tx727M3fqC8LMOK506E46LhVe29GhWSs6i9YU2voGw9e047+xtX4n9a+lN
         e3Y6kx3Rjcyg0KrsmXeqcWHCn8l/3MlU7+xeoPen/HBZ33mxytllFObfAGt1/5O7ujPL
         59Qutg4bugK9NbGq++zHWgDhzO7iCZlsNVrnpUln622/jruJAVXuoo6YzZTnhpf7vOhU
         eQ/C1NFPO3au/mslosqSMKZPZGsX+XUVQfHyaaV2lTpkabaYJ0AMeSodvj+y1iHbe8Ig
         YjEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfmkFSiUeOG02sxXHrMVhVWuLLc8ESSUNSbx0loEHMQwFVz/BRqHcHJTL0RNIfK5eiqaGdkziK@vger.kernel.org, AJvYcCWoAurDYSUQSiGUs6MOLsNmXR8BKYKDbWRLW//PE5b+rY+ABPeEtCY0D5xHM6AOPBFII0VeysAIA66oTbBl@vger.kernel.org
X-Gm-Message-State: AOJu0YyQVn1CVn1LP8vEpmVneRl1Io8une1M4Ihmsr0ATjFClroPi+dB
	hwniPlx/6UzSDsEM/ybfFPPV5b72gdh/u9MbFH95q8WTn4AUvDnoqDmlwt2tLZTzI+q0Y3LIV7/
	fKbUjQecP6UJRsKEiTIKhOubue3E=
X-Gm-Gg: ASbGncsqdV/RR39Y7AKu1zOoZyvCCU0GCNdwD9lceeqBKAKxUhYCZjkSUdiZXlYZnBq
	85lF91tugCRgq5Xs+H4gyoAvIfJAdlkvYyQ==
X-Google-Smtp-Source: AGHT+IGdbbr+2LKvySUkG3K5Nao9hhs5gdvjzsl9x1b7AJuxomG8ixaN/jFIs2swyo2ayS6V/BmRCpOW37QTtc51fyg=
X-Received: by 2002:ad4:5ca8:0:b0:6d8:b229:7b3d with SMTP id
 6a1803df08f44-6d8b6f4ab95mr72977006d6.0.1733279017385; Tue, 03 Dec 2024
 18:23:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108132904.6932-1-laoar.shao@gmail.com> <20241108132904.6932-4-laoar.shao@gmail.com>
 <7pad3qmmmy2hgr5yqwwytj3wyjm3d5ebbqy4ix6boxkd34fc7c@ebdjg75tfgiq> <ghu7irmizgbyso5hjemwsgscfoigdtzufpfckxkvdqibeo63uo@kvzncpy2rlit>
In-Reply-To: <ghu7irmizgbyso5hjemwsgscfoigdtzufpfckxkvdqibeo63uo@kvzncpy2rlit>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 4 Dec 2024 10:23:01 +0800
Message-ID: <CALOAHbAmQ_4c7EuOb-7CT5g10hH12-jYm5_1joeWkcADg40g0g@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] sched, psi: Don't account irq time if
 sched_clock_irqtime is disabled
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, hannes@cmpxchg.org, 
	surenb@google.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 6:15=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
>
> On Tue, Dec 03, 2024 at 11:01:41AM GMT, Michal Koutn=C3=BD <mkoutny@suse.=
com> wrote:
> > On Fri, Nov 08, 2024 at 09:29:03PM GMT, Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > > sched_clock_irqtime may be disabled due to the clock source. When dis=
abled,
> > > irq_time_read() won't change over time, so there is nothing to accoun=
t. We
> > > can save iterating the whole hierarchy on every tick and context swit=
ch.
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > ---
> > >  kernel/sched/psi.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>
>
> On second thought, similar guard may be useful in psi_show() too. Since
> there's a difference between zero pressure and unmeasured pressure (it'd
> fail with EOPNOTSUPP).

I'll update the psi_show() function in the next version.

>
> (How common is it actually that tsc_init fails?)

This is not a common scenario, but it can occur randomly across a large fle=
et.

--
Regards
Yafang

