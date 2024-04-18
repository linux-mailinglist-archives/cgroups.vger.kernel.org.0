Return-Path: <cgroups+bounces-2598-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5888AA4A2
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 23:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0721D2854B3
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 21:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FC3194C81;
	Thu, 18 Apr 2024 21:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8OI2S0S"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F744180A7E;
	Thu, 18 Apr 2024 21:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713474936; cv=none; b=ewvS+bcTTX1aRwxVdMoFOIBe8Fupz980oCMzSedTGhuWewoKZfaTJXXMrJDauhnHeEzRitnR1IdtLL8xwQJRxRehMxEQZAhA1AqZxF2kUoHRWV7gSB8X08iEOYJrLWMi/zgc8Yi+m6HUVHfgvnlUM9oYjrYLyWgsPX71ToSckxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713474936; c=relaxed/simple;
	bh=5ytwZ3cfWJmZrXKU0GRDOoEF4XeAUAcRXfTIjBJRjmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yvrg10i7j1YB6vIYtZwgnkAiBDh1xEIOpMZJFJlnECCPPNtu0SdNigHeU+M3kKJuFTW/h5YZeJNF1L1+swo96QDKhFLQEtJ6NE2vKfW7sUlj0zkGzxQp/S6cdZmdhMBeNde3JFsUaz0eaiMM85XLVqKBehKSfah/pJVzUZkOovM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8OI2S0S; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e2bbc2048eso12003635ad.3;
        Thu, 18 Apr 2024 14:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713474934; x=1714079734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6DT+/uHX76vAoe8Nox+BNf0yRb++O2cYsiA+2lRAAU=;
        b=c8OI2S0SnzjCalFckTXgyBLulIdmM8oB2eiD0s2fZii2GpjRysSyIpjBzsLVYVLopB
         ZLP9oSqC0KJYP77JCl8OzJZwHOWx+fbJwYHiAbsBubSdlANnyrSXAonJ/lMzB0hlWQnD
         wx5hR+dbpgGDC1OnwDrGHlF+/0e0Kz5M7GTFxsgAR5L+qLgGVcSugfsZNOQjtw6lVudv
         kpYvivjIzLDqFfp/ZvDtoTKCALlYk3IXYK/4UjiHpmfIGuJ4IeUfnVlqjkX913ocbf4r
         gqP4bH2s6DZiqM04nISH9ElVj4XbMvf/m7dvfBr9qLZoRPs1FoNjgNSvYxtp5/eOPYrj
         Ms/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713474934; x=1714079734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6DT+/uHX76vAoe8Nox+BNf0yRb++O2cYsiA+2lRAAU=;
        b=ogoQx+DPHSaco1YPgGEKOLo4+yj+hA1cm4oemLLRfVzcv+TCmjJJFKn+FPd8A4v/+j
         xdlXw+JUdU4lRB9W5CZhV+EdMSRY80LVBUnH17EC/pD0v0UhVqazpTOUAPmMJ9Z9qN2C
         hAC8a3XE6yk37dJmC0P/TpTR0r9sXKMx+R1C7hLbG10D/rXGkJvmqGYTLClXLeuUtjPI
         k45Irdt65Pg2KoJSzQX0HqymWFyRo6EX0E0yeXVmCPrb0pQJoH4OE1DjhyPWA1kpK7ww
         2xACkmBi1bQOKmbgopHQJO/oVXq7ROIc15G2RX76Br7D4OiAAeTM8eyU8OYnNTfj1WKT
         vgdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkLoIqQveJ5pfsbvMflkgJKMUFpZAnLJGhAYPkXviPWZl1bbOqm5K+oO2aSdAc3NP3ecRlynw3rprN50y+7aOCkWKpdq6kAMbikx2Uf3ofGJS0cp0J5kRitnCXQC2p9mtmkbLybEQXJrkLseuO/+vgkDQuJ/7ONwbwpNBYUA==
X-Gm-Message-State: AOJu0YzDslr1fMrrXHEKEcgio4eorcdd9sku83AZYmlwzguyzRotxskB
	YOeA2ROZU90Pv5kVWFXxUiLLu4LhT6IbWmNckargyNZKoOXZx5E1
X-Google-Smtp-Source: AGHT+IEioWklFEee85ZpymAJHFHHlrLqBFD3nxO91qEPXU1q2uXzgFRVGrx3OlWJBCY/+7TvQu/E1A==
X-Received: by 2002:a17:902:db07:b0:1e4:bd90:f1d4 with SMTP id m7-20020a170902db0700b001e4bd90f1d4mr310366plx.40.1713474934334;
        Thu, 18 Apr 2024 14:15:34 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902ed5400b001e0648dfd68sm1961787plb.296.2024.04.18.14.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 14:15:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 18 Apr 2024 11:15:31 -1000
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
Message-ID: <ZiGNc6EiuqsTJ2Ry@slm.duckdns.org>
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328990014.3930751.10674097155895405137.stgit@firesoul>
 <CAJD7tkbZAj3UQSHbu3kj1NG4QDowXWrohG4XM=7cX_a=QL-Shg@mail.gmail.com>
 <72e4a55e-a246-4e28-9d2e-d4f1ef5637c2@kernel.org>
 <CAJD7tkbNvo4nDek5HV7rpZRbARE7yc3y=ufVY5WMBkNH6oL4Mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkbNvo4nDek5HV7rpZRbARE7yc3y=ufVY5WMBkNH6oL4Mw@mail.gmail.com>

Hello, Yosry.

On Thu, Apr 18, 2024 at 02:00:28PM -0700, Yosry Ahmed wrote:
...
> I think this is an artifact of different subsystems sharing the same
> rstat tree for no specific reason. I think almost all flushing calls
> really need the stats from one subsystem after all.
>
> If we have separate trees, lock contention gets slightly better as
> different subsystems do not compete. We can also have different
> subsystems "customize" their trees, for e.g. by setting different
> time-based or magnitude-based rate-limiting thresholds.
> 
> I know this is a bigger lift, just thinking out loud :)

I have no objection to separating out rstat trees so that it has
per-controller tracking. However, the high frequency source of updates are
cpu and memory, which tend to fire together, and the only really high
frequency consumer seems to be memory, so I'm not too sure how much benefit
separating the trees out would bring.

Thanks.

-- 
tejun

