Return-Path: <cgroups+bounces-3471-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEA991E666
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2024 19:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30AA284A8C
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2024 17:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313CA16E872;
	Mon,  1 Jul 2024 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8cBSGbZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92E816D320;
	Mon,  1 Jul 2024 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854219; cv=none; b=Y45tluXdPujBaHd/z0snt9HFL/Deq0OZhV5Xzz3/hWcpyk6gc5Wcweujw9Fk3/AVQ+YTr77EYoDf+KMUoH1oYz+KNigA4tIhIn9GEQu10uvMQWjsZ8wFXfPIvThbo/kOsUpguWaW47sf7+bVUTRYTOS7EPNjRrt1pJm+GTi/xY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854219; c=relaxed/simple;
	bh=wct5vNI47XDciF30TAqYAVuLi5pgVoANW3WfbRItRHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxRdDapprCtMikYInaWkOPsK0wCbGYgA/BtwmmAU0XwbMPn91yd9rsavZnuYKhQyQosBoEWXHkktWKVVyUFC58cTqyIOC6X8ms93Ah3AVUOs7LOBne1oetqJ3Peg0iQpFnS0yeaTRQiCCi1lWTDgvobxUiw/FExGMu1gFGx7ysI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8cBSGbZ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-706a1711ee5so1770876b3a.0;
        Mon, 01 Jul 2024 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719854217; x=1720459017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NW1M0Ip7gkuh5lAEgwQS+vcr8qXg4b9p75Ny3XbaFzY=;
        b=B8cBSGbZshLODGltR7JDQikrJAfw01U+Di3g6+tGEeSJH0hEGWzUSjuayba4U1ry1u
         PMp6FMDk2yqB1OldF25y7WUSvNsh/+auZo4IXupxDilcC1vvgcmNNsr61I/4xQDnMehq
         s0JBb8NT5PADdMQdhYnwEVrhGOtIySJD1M0AthtGhQO1UZ/iIsP1msXHgjBkKEOVSygF
         Avben9mxj7XKl8AzoEZgt5swIf6JG6vfccI5Ggq+IrRmyow/qifEaN6p2M4wJvRkEqgb
         N0gGt4Zq8KVx9Nl2J1e+JJmczSc6VenCxtiV+TdJVNazC2hrMRnF8eymmnyKqLLbDS3W
         JUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719854217; x=1720459017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NW1M0Ip7gkuh5lAEgwQS+vcr8qXg4b9p75Ny3XbaFzY=;
        b=P1BSbkzYdWBAeqoYeVvQ3ScS3tOmn+6B1r9M8jRrwV7gYEh9kkVywmAZtYmPw/COzW
         k7Ru8BjO3w7s9Ns+9uhMWDk8YzQggq3Q2lnPWA6TMaJePYN68KE3ZHsivjMVMlWGayV3
         lGbWE+o3FxpfsycPDyNXfFg8GatzWzCtYJl9xexFagiLaeBvS73x5EFUvQ4OEfSEC0eC
         FKzu0YY3TlVazK6jp7OHFfiztzh2MZ+xZRHDhcRAGjJ7pLdV1NQYYJbworwGEKh5mCdD
         DcDEoVpc0Bf07s79cRlE+1odIO1g5goOqgB6oj8SDuCFYrYlrG6Yb9JJISiom0XnuqPj
         EMEw==
X-Forwarded-Encrypted: i=1; AJvYcCXGkAznowS5EvN00cQF6gTz0bk4uyXMiwVh5kp8VQJQ7BvvD/udXp1iBSJJpK6g2DWuwkq5M5G/PPIqwekgAHK0CMIMkk0Z6BzsFhU/afE20HkHiS55Y22KuVuRRFrhhUEtk5ui8A==
X-Gm-Message-State: AOJu0Yy8t/GrFyhmEO2LReTWG5AEYmB/gi6xmrfsFyQTIecfFw9SqlCK
	nHbvXr6ADmtNlkL4flnvBiRImh7Sxsxd5BIAjNYcGhcy8rLvX+HE4bdMcw==
X-Google-Smtp-Source: AGHT+IHcOCIm+E0lMDh19+DC0q4HN7EwqGpQVP9WWnn0IE1kY/CL70dUyNM3sjX+6acvpE1Cwu9M1A==
X-Received: by 2002:a05:6a00:22cf:b0:706:6331:f56c with SMTP id d2e1a72fcca58-70aaaf32f31mr5208224b3a.32.1719854216917;
        Mon, 01 Jul 2024 10:16:56 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804b8ebebsm6767339b3a.214.2024.07.01.10.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 10:16:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 1 Jul 2024 07:16:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huawei.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup/rstat: add force idle show helper
Message-ID: <ZoLkhvoXZhoYLWsc@slm.duckdns.org>
References: <20240701140441.721997-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701140441.721997-1-chenridong@huawei.com>

Hello,

On Mon, Jul 01, 2024 at 02:04:41PM +0000, Chen Ridong wrote:
> +#ifdef CONFIG_SCHED_CORE
> +static void cgroup_force_idle_show(struct seq_file *seq, struct cgroup_base_stat bstat)

Please pass bstat as a pointer. We don't want to copy the whole thing on
stack.

> +{
> +	u64 forceidle_time = bstat.forceidle_sum;
> +
> +	do_div(forceidle_time, NSEC_PER_USEC);
> +	seq_printf(seq, "core_sched.force_idle_usec %llu\n", forceidle_time);
> +}
> +#endif

And maybe move #ifdef and #endif inside the function body so that we don't
need #ifdef in the caller?

>  void cgroup_base_stat_cputime_show(struct seq_file *seq)
>  {
>  	struct cgroup *cgrp = seq_css(seq)->cgroup;
>  	u64 usage, utime, stime;
>  	struct cgroup_base_stat bstat;
> -#ifdef CONFIG_SCHED_CORE
> -	u64 forceidle_time;
> -#endif
>  
>  	if (cgroup_parent(cgrp)) {
>  		cgroup_rstat_flush_hold(cgrp);
>  		usage = cgrp->bstat.cputime.sum_exec_runtime;
>  		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
>  			       &utime, &stime);
> -#ifdef CONFIG_SCHED_CORE
> -		forceidle_time = cgrp->bstat.forceidle_sum;
> -#endif
> +		stat = cgrp->bstat;

Where is @stat defined? Is the patch even compile tested?

Thanks.

-- 
tejun

