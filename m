Return-Path: <cgroups+bounces-7166-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17151A69772
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 19:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786BD1B6112D
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 18:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13927205E36;
	Wed, 19 Mar 2025 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="sHu2dfGW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1CF1A0730
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407612; cv=none; b=SBUtH0iPhZk9HTg1ZHiqTCiXHeKddRhNW6ume3GzcedglNEz0pworhHQNRKkTvNWtYZappWkefsyxoT4eQRPeHe6r1Gw1bj8OZyJeeIPPAMHW2Pb4nui+sK4+JUO1Vp5SltuQXeqrF1ir0n0+8CSwxPRv8dT9r3UlhvFIkS17/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407612; c=relaxed/simple;
	bh=PSoiUXOsPCOJzGfaX6x9D+rZ847fmNdDd34M+1viIaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJuRDODoRWuLUkjcALpB2q1jlqt5PzyLE0ckqpuw6amaFu1w+Rz3RnnsTYO7M4/rC4Ksn3a2+fHo0l2mDG6JEcU1VUFVJG3oeocGgp2+y2adWeo7tI5rEAF5nWOwsxm3t0mcxnhJeOhcA5Y2oqtj/9V6VSUU0tecb99hpxBvOGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=sHu2dfGW; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7be8f281714so778004385a.1
        for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 11:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1742407608; x=1743012408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1NubMu+PJrXrK7FSH6frb72hGV0SUS0LkaEj4SuXE4k=;
        b=sHu2dfGWlOP6m6/nT4M5C/KNBJIryr7QX48KN/dOZWuOhuBSbKix+A462/LukjrhUN
         wZMpL4xfZo2r3T+qXD+OCX+SpsN//7Z0glmZxfOokqF4S8cAHdUDrb+8OUVpq5Q7eJrp
         5l8PsA3c/ore+3KUzO5oL4xBDWuSkOfnMl6/BvPQ2LSSuFnTLvZ7idkEC4kCoyybjFAq
         UjuHK6oU2Y12mPjgbOEgb0dOT0ajn5iePzaYhuXIrya+aTgMWRpiD3IMpHKa/mgp4Ob1
         sT98UO1iz19iU6cBPoTiGnwKD9WbQanar6YtQYqcQppcx99d/BtNFBfoW8+0ozxXmsIc
         QJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742407608; x=1743012408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NubMu+PJrXrK7FSH6frb72hGV0SUS0LkaEj4SuXE4k=;
        b=lUjIq6otnEf6G/qx4T2YLatJEaRqwHeS3FfGzLRKRs0Rwp2A0dhrr8qznjM1PFUFps
         Xm4hwCUBhgUF9Rjlu8Qgb/aNygvndNjfiBZKQ9AnQ1ADscHWc4Vuem2hi9ztKZxFxggr
         BTvD6fpfrBnUu7z9zC+L+78T8029oYkZdvl9fy3L8ilw5grB8VhE8P4Po0C7OVXGx1ia
         7g05ogaVAgRYZoT18icSmJOzVV2vOfVyyJfgORrvJ77MW8oylkdtpfq7OSZt3GwyqyjT
         5Ykq21ZiOg/nO/YBGizEzIVfKwz9aGHIaEAR1EydV0Ws6MDb+aPmiiefYUZgx4ONteyk
         z7PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt81xXP9UtIhc2favFSEgHevg46ZJ7+ffHlutuiLR1aiFgun0hpr+KKYlKUtc43G9vTg2oRfXU@vger.kernel.org
X-Gm-Message-State: AOJu0YzZnqzZnH4peSlreP8aBuOKudQuJLiMsd0+gPCsnxxgJfW8bQYR
	F+mSDb50YRMAMTfRAWgbI+gCintJqcYtioeyuACtczBrWADDqYXX+Lm9bdM09NI=
X-Gm-Gg: ASbGncuHaBVWt5d3gZgO/9nAS2zIrFWtXLdoXGOCzy2RT0sstHloG0KssdDOiZ0Owp3
	pT1o7J7KfNzO949s4xpHlmsJEMuK972yGj4jxjssIntdMlbRCaIydsNway9vmKeZR2JvJyevaui
	tWVtlXMTapBvcT6i8IhaV9SNq2TyZAwDLUJd4v37z2QP/90ddhmNZ9tJrppzPn5p4fsydOe7uJg
	LugdXGR0VFUCPISThJovBV8L0eOluuK8YaCUonMF0pG8nvPr3eHjQofg5YfBc1bzfQxZoIW3pNO
	X5G9gXhr3O94xLGlXBkxY0xySXXHVQzGanrZjinxsr0=
X-Google-Smtp-Source: AGHT+IHiSAMT4qpEHY5hxrStqDgNaN2Q83H85X1DL7R0E0NeRn5pbKUwIbbATANiD9rmFjdJm9FC3A==
X-Received: by 2002:a05:620a:408a:b0:7c5:5909:18ca with SMTP id af79cd13be357-7c5a83ca625mr516096485a.26.1742407608056;
        Wed, 19 Mar 2025 11:06:48 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c9c669sm884839585a.64.2025.03.19.11.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 11:06:47 -0700 (PDT)
Date: Wed, 19 Mar 2025 14:06:43 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Greg Thelen <gthelen@google.com>, Tejun Heo <tj@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumzaet@google.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
Message-ID: <20250319180643.GC1876369@cmpxchg.org>
References: <20250319071330.898763-1-gthelen@google.com>
 <Z9r70jKJLPdHyihM@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9r70jKJLPdHyihM@google.com>

On Wed, Mar 19, 2025 at 05:16:02PM +0000, Yosry Ahmed wrote:
> @@ -365,9 +352,8 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
>  void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>  	__acquires(&cgroup_rstat_lock)
>  {
> -	might_sleep();
> +	cgroup_rstat_flush(cgrp);
>  	__cgroup_rstat_lock(cgrp, -1);
> -	cgroup_rstat_flush_locked(cgrp);
>  }

Might as well remove cgroup_rstat_flush_hold/release entirely? There
are no external users, and the concept seems moot when the lock is
dropped per default. cgroup_base_stat_cputime_show() can open-code the
lock/unlock to stabilize the counts while reading.

(btw, why do we not have any locking around the root stats in
cgroup_base_stat_cputime_show()? There isn't anything preventing a
reader from seeing all zeroes if another reader runs the memset() on
cgrp->bstat, is there? Or double times...)

