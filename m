Return-Path: <cgroups+bounces-7362-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2CFA7C318
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 20:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97AF83BADE8
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C09521B9C1;
	Fri,  4 Apr 2025 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="00IvK2uO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F26121ABC6
	for <cgroups@vger.kernel.org>; Fri,  4 Apr 2025 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743790396; cv=none; b=RR3jPiLAu1DeHKvVyEDYRb9O0M7SdfbP9ZFM5xn8FOkBWJ47mc4kaaZB5qqqrCYPrM8QnDpeKKutr+G78yXAFI/ekT0YFdIYu9eOX0BKWBx+kQGTmdbHG5qhfgym16Oq/vw1vH9k9f7TKzcjQGSVOqP/3H8d3XgU6mtY4PKCobU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743790396; c=relaxed/simple;
	bh=7rBihDPp9FTk+9h+YN3X6UN632wm8kddI1fTY9fA6gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5iXCs6u5YlbMz3g28sX14GHaPRqBiLv+aVc3WIe6SkosmWnhLGEW2NCmDTJZzKuFR6CWkfdqK+axkd3g7GXteIrVSPdAL/FkI/cSBDRkyZ7zKu3EF5isi6huaEQUglCcrh8rNrOK/5d4SIyWkqiKIQe7FNbJzJsDS6aDf7RCnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=00IvK2uO; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c56321b22cso214608485a.1
        for <cgroups@vger.kernel.org>; Fri, 04 Apr 2025 11:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1743790393; x=1744395193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8cyC/DPxNVy17Lz/zroH2kHExcb4tpekU11b2nuA7o=;
        b=00IvK2uOxq9Q2JG5F9RkhRyG5fPiDlKFA/3mwiN6pe5S/pqfySzSSMAI41NUHBJWOs
         6eOKHpJoFSy1IEZnL+wu1ks9V8UhCHQmYcmxjMeuTFsOst7r2nQb1Mb75JUCxabo7Pzw
         X51zHaB97rOp+l/yb3dk25G/99beROhMgUA0B0DhLOwUptUET1viYggNNIkDloJpTWWG
         lwNN9SzhVCmO6/eiW0YiJmV+0JkfULRoleyvsxEgpmYJi9wCUhDQYTiEIRULlo9PjIed
         Tjs/vxe4Pxrq3kA2AZVCtnS/xVBvmm4lljSDEhDyMTpF1ZYY4AAmmXwwCXTzGBU3J2Nc
         mGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743790393; x=1744395193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8cyC/DPxNVy17Lz/zroH2kHExcb4tpekU11b2nuA7o=;
        b=wCb0gAZKorT2472s2DpZ6HEZWGai8DEgDFHbQEdj2OBUEGaCweVWQZTN7VxBjqadCE
         xrKsnRr6cJiLEQXlu+o1MRR558CBKFQPFeA72/R+GbSPvagi74haZ8xraXJNDxpCXk6V
         JR5J2Mzo445POX7tM1W2hmNWqhIcHIsgrvCxFeVLuWkgF2w6CbKXWeeRd1oXXUTYOesQ
         dA6ryidfZDS2AZ7NFjQRowfmRdVzgb1aBMAtjU3ZXp4FjZjg+fs4UPZoBGc4EFbbM8VZ
         i84Pv4LZww0+ZHDEO2TgiI4Wa7s3sL5KsnZYOPGbUFazdRL8o1kP5S5LHX1CM/6VwjKw
         fK6g==
X-Forwarded-Encrypted: i=1; AJvYcCXuJZPNpSMLLf9Wr4uveECQhIR1XfZ3Tj20C1FUDEREUUSd67TC82w204gQyQd7/ox1MzZv0W+F@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0OZk9P+YEj1wXLerIrUumsdTObYJSRV2PsVQY/k5HIkZON7Oh
	rBAalz7jIsgh0TqBsIV/SHeUl9BJEErIseFDckAzVTrGRM4uzRHaHsUTwf8+3u0=
X-Gm-Gg: ASbGnctaI7Pn6VgmJ0cX/8jOQbjoydhqsq86x8mMEGKh6z6Md1Vw2GUFXc1ed4Z3mTn
	5f7LuGqj4mIlV25o9xLqksKF9YaGRMCwYh5BdwO7ti3aqElqIQIRtx40VR9x5CXFsxHXHyvLYWH
	IQndWVAJNKhnblPJuix1mNJCsTprNL1xf2CSimSYfFkc3K87otDRsnThzdZYUAewHwia021bwLQ
	9tuPLWhBVQxXAhZ14tdQQstd+HQf3R9P43NuC3/x7SWvilyZH68qK47qXh6+OCqU9F1mDhOGdPz
	8agTFGeFM35qh2X7J4YAGWrv9tRT83Cik0uMkk2B7rE=
X-Google-Smtp-Source: AGHT+IFDO9K2q73ZkHXh1q8bIV9QQbY3HITlSzjerFez+hyaMApgOpAFEuI1ij3Hx9STu1KB7K29hg==
X-Received: by 2002:a05:620a:1aa6:b0:7b7:142d:53a8 with SMTP id af79cd13be357-7c774a3c100mr536465685a.19.1743790393005;
        Fri, 04 Apr 2025 11:13:13 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c76e96a1fcsm247409785a.54.2025.04.04.11.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 11:13:12 -0700 (PDT)
Date: Fri, 4 Apr 2025 14:13:08 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] memcg: Don't generate low/min events if either
 low/min or elow/emin is 0
Message-ID: <20250404181308.GA300138@cmpxchg.org>
References: <20250404012435.656045-1-longman@redhat.com>
 <Z_ATAq-cwtv-9Atx@slm.duckdns.org>
 <1ac51e8e-8dc0-4cd8-9414-f28125061bb3@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ac51e8e-8dc0-4cd8-9414-f28125061bb3@redhat.com>

On Fri, Apr 04, 2025 at 01:25:33PM -0400, Waiman Long wrote:
> 
> On 4/4/25 1:12 PM, Tejun Heo wrote:
> > Hello,
> >
> > On Thu, Apr 03, 2025 at 09:24:34PM -0400, Waiman Long wrote:
> > ...
> >> The simple and naive fix of changing the operator to ">", however,
> >> changes the memory reclaim behavior which can lead to other failures
> >> as low events are needed to facilitate memory reclaim.  So we can't do
> >> that without some relatively riskier changes in memory reclaim.
> > I'm doubtful using ">" would change reclaim behavior in a meaningful way and
> > that'd be more straightforward. What do mm people think?

The knob documentation uses "within low" and "above low" to
distinguish whether you are protected or not, so at least from a code
clarity pov, >= makes more sense to me: if your protection is N and
you use exactly N, you're considered protected.

That also means that by definition an empty cgroup is protected. It's
not in excess of its protection. The test result isn't wrong.

The real weirdness is issuing a "low reclaim" event when no reclaim is
going to happen*.

The patch effectively special cases "empty means in excess" to avoid
the event and fall through to reclaim, which then does nothing as a
result of its own scan target calculations. That seems convoluted.

Why not skip empty cgroups before running inapplicable checks?

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b620d74b0f66..260ab238ec22 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5963,6 +5963,9 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 
 		mem_cgroup_calculate_protection(target_memcg, memcg);
 
+		if (!mem_cgroup_usage(memcg, false))
+			continue;
+
 		if (mem_cgroup_below_min(target_memcg, memcg)) {
 			/*
 			 * Hard protection.

> I haven't looked deeply into why that is the case, but 
> test_memcg_low/min tests had other failures when I made this change.

It surprises me as well that it makes any practical difference.

* Waiman points out that the weirdness is seeing low events without
  having a low configured. Eh, this isn't really true with recursive
  propagation; you may or may not have an elow depending on parental
  configuration and sibling behavior.

