Return-Path: <cgroups+bounces-11563-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D83C304BD
	for <lists+cgroups@lfdr.de>; Tue, 04 Nov 2025 10:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB2D421448
	for <lists+cgroups@lfdr.de>; Tue,  4 Nov 2025 09:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF78A311C1E;
	Tue,  4 Nov 2025 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PASA8VN6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5D62C3254
	for <cgroups@vger.kernel.org>; Tue,  4 Nov 2025 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248100; cv=none; b=Ye4pEMu0v0O0zi5wp4susq7zQ1+4WBsSdCbdlMyNRlcubogtknc+xefKJcjBcBjCta05cRjyrLq+stxwHMv3XGshx0nuP8XERTBUIEEmbkd0JJwUE46WPZoL9euskiVSOXA+frC1iTnaBSOfbEMWbpOHZrsjotDDDuFTz5FjCUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248100; c=relaxed/simple;
	bh=qWUGGQt5BOBYCU7cJdvg7HLtAGyl1naRvP7koMC91kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUBX/YXhU9x0v0iXscJnORrOIBxTcFLkhbQKojv00KLS7oH54Qjownj+LAzr+91O1noYrPcmQtdL0gAyYYKSVpbGb4AubNnjSbWKi1H0ke1QJBZzpZy48WEC9L9TrztGKLJ5Vz0EXnJ/mu30ta3T2b+q1q96Mx9hfn6jWJAaCQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PASA8VN6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429b9b6ce96so3446311f8f.3
        for <cgroups@vger.kernel.org>; Tue, 04 Nov 2025 01:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762248097; x=1762852897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N3yPk3l2QmZ5sg7FNMBQuG7a498LlywoxhRJU9RTRgg=;
        b=PASA8VN60LWvBEA+Zf5lTNSO1D4/omSdR/JPG2Jme2M+HEmg5I9cj55UsEqRJkmUSA
         Kwq1JpCDqNGtrqlPfU3s4Z5WhmxUK4bA4gY1KT0MK1avaeYdLZmK2oDMNtW2zpVPJl1O
         pbuRhriTmljFDbNJxgdsxxLhZhH6V/cLud2yfAdjEjgH9Bn/edGdd512g4IJPQZEQN5R
         Hc5Trnw6CkRQTDcCqyCrVggi+0cbD8MJi0IwXmE6EZm3UzACEsm28o+nWyMXSR2W2pwL
         lquiRe1hqQgnZ2+zn2D0gVt5C8vtP6GlLMBU6lFtL007nrGBO/X06cLP5AX/7EOUN/0s
         NTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762248097; x=1762852897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3yPk3l2QmZ5sg7FNMBQuG7a498LlywoxhRJU9RTRgg=;
        b=LvUbjtcBa+6ifV2Ao63X5fJz2WNK3q9dNnIffYTpUfWvJSnFLaiw+0G5YvUGih93jq
         mY4tlgGqCON6kOz2ttkeaDq9tNggOffrKi1znBcFvPIl6jLqVAa5umXHjU0fEPrlcbFu
         2hpT5KQ5FCaVD5b2Q+w9NJ42LyF5av4qKVgL0pDnAKzJIXvLhC+nl//YjoKIXAayZDYw
         WzK/hK171/hPrWL0Vej1JsOdZifimHN3yYWGZY8bbaDBLNZw67ULNEd8YJzayu7uwjOq
         SjFXKc2HNWf1aSXn9B0tbM5EBkjA114Ll/RRQJ4irTNzViMEondORX4FZ8R5ysW8Ihon
         K0aw==
X-Forwarded-Encrypted: i=1; AJvYcCWUj7boVY6qjbh6UVuNK90I2o7sq2eCdgs3HCHz28VGRZdSZV2tqJb/WkT3F+Cx1aLYu6opzUKm@vger.kernel.org
X-Gm-Message-State: AOJu0Ywos+IZ3zXm3O8ea7B7YEssoLzl220UVzwRvlO/J4b6Jm2T3FF0
	dep4qw0r8vj7IGCre1+K4aV/N+ajUFPOAeAa178b3+qKDzAONqib2jpsvahnaFrdtnE=
X-Gm-Gg: ASbGncsWW1Y83dVWCtppKYrnM4OaXnZcTQu/H0+kzbjWdJHAUN4NAhKjT47W0Wm7eU2
	H8B8v+4Qpsq91Kj1Xh2/vbb4VSwrNGjebm9VWr52qQtYEXYkBxQOb1vSHYRo5uay1uvJ0uVyJr5
	A/iCBuh77trUCo23S7pBQ0omaUqcRnyr6OQFH48mZgwZxCCV/0TB7jEw4PvFVDKNhniVCmo9Cfw
	S5XuTBCrMoxr9atSgonEjbfs2wU3GuzdH0Kin1fqCITqGoA7RraZg9Czu3nq+FClimcrPzwtP1+
	rfQMD95FYK8vBSe2I1Qh6faQywfMP5PPUgyWZceUp+rBEBO4bPHdlSmPtB4Rlj3shq/9DyOTZwg
	zTmoLIoRtpLPAMtHRuIZRaO3j/z6GzabBkzXNpGaQTJimUgBsmy43so82wd8eD6ALDIVW4HIkCp
	shwnc/fAm2
X-Google-Smtp-Source: AGHT+IF4ZP/JaUkTNJYjSED1IManQD1UidWfm51jaGkLr6fndksIOYSs9Z4q0DYHoyvlN+ZlPJfjhQ==
X-Received: by 2002:a05:6000:1acc:b0:429:d40e:fa40 with SMTP id ffacd0b85a97d-429d40efbe6mr5041355f8f.45.1762248096882;
        Tue, 04 Nov 2025 01:21:36 -0800 (PST)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f9d33sm3569518f8f.36.2025.11.04.01.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 01:21:36 -0800 (PST)
Date: Tue, 4 Nov 2025 10:21:35 +0100
From: Michal Hocko <mhocko@suse.com>
To: Leon Huang Fu <leon.huangfu@shopee.com>
Cc: linux-mm@kvack.org, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, joel.granados@kernel.org, jack@suse.cz,
	laoar.shao@gmail.com, mclapinski@google.com, kyle.meyer@hpe.com,
	corbet@lwn.net, lance.yang@linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH mm-new] mm/memcontrol: Introduce sysctl
 vm.memcg_stats_flush_threshold
Message-ID: <aQnFn6vPQ5D6STGw@tiehlicka>
References: <20251104031908.77313-1-leon.huangfu@shopee.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104031908.77313-1-leon.huangfu@shopee.com>

On Tue 04-11-25 11:19:08, Leon Huang Fu wrote:
> The current implementation uses a flush threshold calculated as
> MEMCG_CHARGE_BATCH * num_online_cpus() for determining when to
> aggregate per-CPU memory cgroup statistics. On systems with high core
> counts, this threshold can become very large (e.g., 64 * 256 = 16,384
> on a 256-core system), leading to stale statistics when userspace reads
> memory.stat files.
> 
> This is particularly problematic for monitoring and management tools
> that rely on reasonably fresh statistics, as they may observe data that
> is thousands of updates out of date.
> 
> Introduce a new sysctl, vm.memcg_stats_flush_threshold, that allows
> administrators to override the flush threshold specifically for
> userspace reads of memory.stat. When set to 0 (default), the behavior
> remains unchanged, using the automatic calculation. When set to a
> non-zero value, userspace reads will use the custom threshold for more
> frequent flushing.

How are admins supposed to know how to tune this? Wouldn't it make more
sense to allow explicit flushing on write to the file? That would allow
admins to implement their preferred accuracy tuning by writing to the file
when the precision is required.

-- 
Michal Hocko
SUSE Labs

