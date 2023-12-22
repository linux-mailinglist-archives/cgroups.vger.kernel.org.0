Return-Path: <cgroups+bounces-1004-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A89C81CE16
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 18:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D423C1F23949
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE0028E0C;
	Fri, 22 Dec 2023 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwelBrAL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC47A2E64E;
	Fri, 22 Dec 2023 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d2f1cecf89so12507365ad.1;
        Fri, 22 Dec 2023 09:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703267279; x=1703872079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RC2nmy9L8LyAINHypbmeW9GD69Ys3nWf80PP+IKdzXQ=;
        b=QwelBrALk7lMs5eBmH9gCbegusN+gDtwwslNWYJ4Ih0GI4WwSALbpLoLQVTA22csfv
         Mk5wweIt+GoKMIlrlgS1Ag1Oaa5TG2L4mX5dMNVR3w4MGzHhjJjxLabvJ0bjT7Qhxqq4
         7b7wMsYQB9F7OTdh+FM3W/tgbZgiF89fBHqHZL1oTXM/RUej/cp0btU6UbdUQFrrxZcN
         hCIYDc9ChicaAJYosOShWfc9uCGEYBEDToSMn98aHg4Qr3U+w8GG3EXWEuHe85m151YP
         FkblTWneDQYoANn+1zoCax9kyDIAk+NbG3nIA+Jw7eVsbKBq8+yM2iRFjKA0RPBN1bJk
         ZxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703267279; x=1703872079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RC2nmy9L8LyAINHypbmeW9GD69Ys3nWf80PP+IKdzXQ=;
        b=QhMAtngi6vIh18VzVuodSWNwPiffqKTqEB7oZSqbbD4qep8HRLjI4I/cuM2IB+Vdix
         J0dm8EkBElh17m8QG9oQB/2u4M5Rur9vNM0PpyzxQGzVJSGEBcuu5ltENqURUDnzimby
         nBug9xCORINYpjFmal/1StF0wYBzJHm1IH9vcLeoOoTGZwRrFXY+4U90tmRc08AURU0x
         7TXO6iVTSh5fuskvdeOhYzNsIT/2nlIPJShKZqm83LedcQir1vl/9qSLrncH3jkjCs0C
         IyZ5UvbW2X8VXxS8QXTIzZCIlegr75Jkw2qFKCijJj+llJ4+OOVKodXwbjfvLNzJoZeN
         F/tw==
X-Gm-Message-State: AOJu0YyGjnxhGGhGpfCEKy3Ku/OCtjcKO1AXtOOxFy6g3l0oFjB68fci
	tKe6+gQ42qlnlGFI+4EddCk=
X-Google-Smtp-Source: AGHT+IHmWbwuqA6UjHxsQfcm84S5+SXz7T2BgTSx1k2FUH/6xOd0kqbfm1vS56CmaTn/5y0eHhun5w==
X-Received: by 2002:a17:903:24e:b0:1d3:ea13:aed4 with SMTP id j14-20020a170903024e00b001d3ea13aed4mr1141467plh.118.1703267278898;
        Fri, 22 Dec 2023 09:47:58 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902a38800b001d3e9937d92sm3808216pla.51.2023.12.22.09.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:47:58 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sat, 23 Dec 2023 02:47:55 +0900
From: Tejun Heo <tj@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, bpf@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/4] cgroup, psi: Init PSI of root cgroup to
 psi_system
Message-ID: <ZYXLy0AofQyasLkC@mac.lan>
References: <20231222113102.4148-1-laoar.shao@gmail.com>
 <20231222113102.4148-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222113102.4148-2-laoar.shao@gmail.com>

Hello,

On Fri, Dec 22, 2023 at 11:30:59AM +0000, Yafang Shao wrote:
> By initializing the root cgroup's psi field to psi_system, we can
> consistently obtain the psi information for all cgroups from the struct
> cgroup.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/linux/psi.h    | 2 +-
>  kernel/cgroup/cgroup.c | 5 ++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/psi.h b/include/linux/psi.h
> index e074587..8f2db51 100644
> --- a/include/linux/psi.h
> +++ b/include/linux/psi.h
> @@ -34,7 +34,7 @@ __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
>  #ifdef CONFIG_CGROUPS
>  static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
>  {
> -	return cgroup_ino(cgrp) == 1 ? &psi_system : cgrp->psi;
> +	return cgrp->psi;
>  }

How have you tested this change? Looking at the code there are other
references to psi_system, e.g. to show it under /proc/pressure/* and to
exempt it from CPU FULL accounting. I don't see how the above change would
be sufficient.

Thanks.

-- 
tejun

