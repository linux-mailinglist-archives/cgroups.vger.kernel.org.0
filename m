Return-Path: <cgroups+bounces-2600-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9078AA4C2
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 23:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11671F21DEC
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 21:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED03A194C96;
	Thu, 18 Apr 2024 21:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/LjEpFB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E15165FA8;
	Thu, 18 Apr 2024 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713475945; cv=none; b=j9+IkPA2mDkxcdRaV7GBxcj7d7LeaOn8jSN4XtvBHUiTIfizv0MslwanuriTVIONEdwd3PoDaYzmj+vuAh5uZSOMdO8a2rYEEQXNGYUP67Hs4ML3I9joSb5+tFizepQZtwHSRl9aQ9LHg1H0EJjsNZntyyNZlJoXM5a4VAySaZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713475945; c=relaxed/simple;
	bh=mQ3kzqrthAoVvvIv+IB+r60HI0TY6Hnm+NcgaIVffpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHZUKmOhwy02dCaEay5DWDD5EHbEdCSEJCjfxbxeUPdGZZJlQ8P6XGQ6Q7Y3PSKpYk0CbnlEDQ/Zep3wywJVKQs+qnVVMuwzmGsHgiHJa53hBkCH783IgBhb8bRJZgIio8MN0C7Pap9R5cvH0N0YspS/ibyQji1+Z7QgJXq5OBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/LjEpFB; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso1280178b3a.0;
        Thu, 18 Apr 2024 14:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713475944; x=1714080744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRiieToRmsEDG6F1uvaO7TUM4yG+bNyfTeoysL7aDto=;
        b=Z/LjEpFBIrhBUfiekuLSZK7EbHH9zXEqa+GnIIwLa1ihfimY6HpltLL46QYoFoc+rt
         eGg8ef69EyyPU7LDrd+acS6kEaKtax6NqYSBim5cGUR/M9oTrD/TuerU+wU4qs6qGUIN
         SseAwKppd9GtjWzWtfQtyApasJ5WpUc/6e/DIkssr6LpyTkVuISZ5o4OQCeCEQ15TMQP
         q1qNDyvudQGnwRsrdsI2Xw12+GtCqJGw06d/VEhhlKbf66BIRg6d5s9ZopjKRM+wug38
         WLbmCggVrFj7Nv+B313MzNroFene9I2HcwFCxkvfV6MZDorOFNba+BQdSNCrxkydTmqD
         H2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713475944; x=1714080744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRiieToRmsEDG6F1uvaO7TUM4yG+bNyfTeoysL7aDto=;
        b=DMH/UNN2Fn8kU/8HrY4K+8PcFpwBTEO1DwKgt4mqUFc1Eo97QoDn9lJ6W8UIjHwKTk
         VuH2I/eARBqJEhck464ykuZX5mlpjlY5BAmLJVDPF4wGh6lm87jlh6I86gFpNZcXVqhX
         Geb6sqMFg/9SD4i5agUuuy1setPBKYkgfn+UCB7n2H4r4PiIw/AmE9prZsGtEn4VRHP+
         LG+l8PJbOYMD+0hWhMe413+zZKRz5hdgANByA0mVsLutSdzoDLGOZG9WfUeu0HzAQTCD
         8Cqu/yp4bzs3Cc4aJsDh3Z33h26gF8mAHXBvjwnbLcPTuvuV6abQK2qTbQNeg3LhcHur
         D2vg==
X-Forwarded-Encrypted: i=1; AJvYcCXYZIn1yyVfSgESR+RNMm8rgUGELV5TAhLSJCWYEt9L70IVxu05oyO5hvbYLjEE70A7kjgZYvwsX63+o+XK1trhA8s4Waub9WxAYpINNRcXlDbYrhroiIP9VAXiP3aZH30BwctxR8ydXVrguTqKw8+Kr5dUtoC1P8IjHRwZlQ==
X-Gm-Message-State: AOJu0YxQVSHDw8zfvoEugrMMxddZ5wVBxrAJtAm3oxXt1N8EXU+pvhUL
	L97FKA1clWCodnqpyowLSsmzdR4eh0gmVJkmorLra41tz51J76Co
X-Google-Smtp-Source: AGHT+IGg3Ek6H90kBqi4Eps3Bk5lZgzA2YB7ziqHSvYYmonDJgvHOrg3Gm3HnPEfyEYUlnbI/fcF3A==
X-Received: by 2002:a05:6a20:8409:b0:1a9:6c42:77f5 with SMTP id c9-20020a056a20840900b001a96c4277f5mr622170pzd.59.1713475943619;
        Thu, 18 Apr 2024 14:32:23 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id v3-20020a17090a00c300b002a005778f51sm2077328pjd.50.2024.04.18.14.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 14:32:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 18 Apr 2024 11:32:21 -1000
From: Tejun Heo <tj@kernel.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, hannes@cmpxchg.org,
	lizefan.x@bytedance.com, cgroups@vger.kernel.org,
	longman@redhat.com, netdev@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, shakeel.butt@linux.dev,
	kernel-team@cloudflare.com,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	mhocko@kernel.org, Wei Xu <weixugc@google.com>
Subject: Re: [PATCH v1 3/3] cgroup/rstat: introduce ratelimited rstat flushing
Message-ID: <ZiGRZSxsh4O85KlQ@slm.duckdns.org>
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328990014.3930751.10674097155895405137.stgit@firesoul>
 <CAJD7tkbZAj3UQSHbu3kj1NG4QDowXWrohG4XM=7cX_a=QL-Shg@mail.gmail.com>
 <72e4a55e-a246-4e28-9d2e-d4f1ef5637c2@kernel.org>
 <CAJD7tkbNvo4nDek5HV7rpZRbARE7yc3y=ufVY5WMBkNH6oL4Mw@mail.gmail.com>
 <ZiGNc6EiuqsTJ2Ry@slm.duckdns.org>
 <CAJD7tkZOV4rQQ0s=bZT=vO-OT4FxBG+R4nypUKcQTRGap4BGHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZOV4rQQ0s=bZT=vO-OT4FxBG+R4nypUKcQTRGap4BGHA@mail.gmail.com>

Hello,

On Thu, Apr 18, 2024 at 02:22:58PM -0700, Yosry Ahmed wrote:
> Outside of this, I think it helps us add controller-specific
> optimizations. For example, I tried to generalize the thresholding
> code in the memory controller and put it in the rstat code, but I
> couldn't really have a single value representing the "pending stats"
> from all controllers. It's impossible to compare memory stats (mostly
> in pages or bytes) to cpu time stats for instance.
> 
> Similarly, with this proposal from Jesper (which I am not saying I am
> agreeing with :P), instead of having time-based ratelimiting in both
> the rstat code and the memcg code to support different thresholds, we
> could have the memory controller set a different threshold for itself.
> 
> So perhaps the lock breakdowns are not enough motivation, but if we
> start generalizing optimizations in some controllers, we may want to
> split the tree for flexibility.

I see. Yeah, that makes more sense to me.

Thanks.

-- 
tejun

