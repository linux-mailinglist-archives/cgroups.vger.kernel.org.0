Return-Path: <cgroups+bounces-3006-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC8A8CF577
	for <lists+cgroups@lfdr.de>; Sun, 26 May 2024 20:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8446B20ACD
	for <lists+cgroups@lfdr.de>; Sun, 26 May 2024 18:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01403BBF0;
	Sun, 26 May 2024 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTgQyCyo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A4517557;
	Sun, 26 May 2024 18:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716748550; cv=none; b=USML1XQKR0/BHnNoPfrlzl9QXyVbA6xz2cQAzI5HVBujvg5nzDIQEQfsK4hrv/dMNInCEFFJ7VvudCJ3pL3lkHMoQc7nVvLfbfmiq3JszmH/baypfTzMwOpX69z34qhBRYY/rZeQADvkt02NMy1q0hb/owd2TRquE+2odPDgSnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716748550; c=relaxed/simple;
	bh=x599MtMMXIjZ9+ZdO3EgKOgqP7z8C4kDTbcjfF2iBPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/jrCHGlqPwoJo86PvyLMt6w6sFpNim7YNwApFuKJxrEhRgYCjSjfz0+wjEgpsPPCpSJ984MEaTCCogfacc9zieZWzL5XFr1ys4ntbKhMNf8v3LaSllEqUExcbZ99CcOz9f2/Mk9Py1npwdmKgkGqBefRpAhkl3WvaoGWUhaKw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTgQyCyo; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f8ecafd28cso2056092b3a.3;
        Sun, 26 May 2024 11:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716748548; x=1717353348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/c5kkg+NjP+yMcdy+LFw1ROXNUqtBFn3Haqcp8r1Q0=;
        b=DTgQyCyokHo9mOu2Q8DUvffwHnsaHJ6mOZgL97xaIsk3ieJemFkzs2xpUekCbhKZ/Y
         lqczuZIrMm50v5m+E3c4FOd7erNv41SloXsl73pUhbvimChNTw6jrXhkwSx0BjyfEcP3
         d7Xh6uGMKoJ+7feLRQ4TQJZdTKQvieQt7Ds1X4WcLctCIKlxzhHHvv7mH9hJqtR3VPUy
         WBgzQ7y0zMEF93eOhYPBw2osfuZ/xFGpv1wjXSIziify/aUU0pm8xJgdPi0TEUdARhPJ
         2BT4t862Wy24vDsIRRme+UojXzDvArVjd7MbLwkjinJIKxvZqSIxj0TNoDB7nQePYKaA
         J6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716748548; x=1717353348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/c5kkg+NjP+yMcdy+LFw1ROXNUqtBFn3Haqcp8r1Q0=;
        b=LkTp1W8F9r2GwJ7+zNesVMc3HBoHF8gsc6BYdqSt9fU5KSQBWnoyx0GQPj9baOHDFx
         w3eIpM145Z0RDwnDFfpFQXf0O3vfl0oBm0/L+CEMcck4VqPcSC+Im5QuxL+7XrDLFVVG
         e4kxSY5G8coh2OEqRQ9ArdmzVCYEkwozJ5aNiEmIbZ+kNtH1Kw7ji6aOqL5Q6d9ehZ5u
         sTaq9en5nwgwEleTAz6Q2fqGqTluXIw0J6HrV0TlhhBXzHBU89c4KghW3QqkB45uPh8+
         tew1STEf9EF/a6dw3kOFogj/VfPjTm5wwEEt1Cx7RGCxT2ncnnNmI7d+qNcZzR+7YMnx
         INqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlSG55+QEF49jkuJuZ3cyY7Q5FO9UywNev43wViKRuDiOEmiMec/3cTi7esyR9PV9n3Spas5vuXv4unQjY3w7DqCPO2NrH1QqJVyXaTBAfs0xMm1xfTBXPLbbcZmo4gsR6+1th7w==
X-Gm-Message-State: AOJu0YxiZh2dcMErEASL/Wu12nkJSqOQLWAHTpcs4/4xN+RHLoIctapj
	AGx+y2ybWUwfphI+Y+eHSl4Kt7s3p4OzNcbs/Yk3LPxnd9pwjTlRQSzrTQ==
X-Google-Smtp-Source: AGHT+IGNpdBCLsMn689I0y1Rwvc2wfI7ea34yLNQ9LlHyaRRg9OnHMtDLMqgXqlRI9SAmv+HvLUR6Q==
X-Received: by 2002:a05:6a00:4093:b0:6e6:9f47:c18c with SMTP id d2e1a72fcca58-6f8f41a9f2dmr7404240b3a.33.1716748547964;
        Sun, 26 May 2024 11:35:47 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fc36d22fsm3730817b3a.86.2024.05.26.11.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 11:35:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 26 May 2024 08:35:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: longman@redhat.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup/cpuset: Reduce the lock protecting
 CS_SCHED_LOAD_BALANCE
Message-ID: <ZlOBAmStNZZU6Z-N@slm.duckdns.org>
References: <20240525094648.1585086-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525094648.1585086-1-xiujianfeng@huawei.com>

On Sat, May 25, 2024 at 09:46:48AM +0000, Xiu Jianfeng wrote:
> In the cpuset_css_online(), clearing the CS_SCHED_LOAD_BALANCE bit
> of cs->flags is guarded by callback_lock and cpuset_mutex. There is
> no problem with itself, because it is consistent with the description
> of there two global lock at the beginning of this file. However, since
> the operation of checking, setting and clearing the flag bit is atomic,
> protection of callback_lock is unnecessary here, see CS_SPREAD_*. so
> to make it more consistent with the other code, move the operation
> outside the critical section of callback_lock.
> 
> No functional changes intended.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  kernel/cgroup/cpuset.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index f9d2a3487645..315f8cbd6d35 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4038,6 +4038,12 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
>  		set_bit(CS_SPREAD_PAGE, &cs->flags);
>  	if (is_spread_slab(parent))
>  		set_bit(CS_SPREAD_SLAB, &cs->flags);
> +	/*
> +	 * For v2, clear CS_SCHED_LOAD_BALANCE if parent is isolated
> +	 */
> +	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
> +	    !is_sched_load_balance(parent))
> +		clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);

The code looks weird to me. It's doing the same thing under the
is_in_v2_mode() block and the cgroup_subsys_on_dfl() block and the former is
also run when the latter condition is true. Looks like we can get rid of the
latter block? Waiman?

Thanks.

-- 
tejun

