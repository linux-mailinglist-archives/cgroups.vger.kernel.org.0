Return-Path: <cgroups+bounces-7137-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB17A679FB
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 17:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0073B26E8
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 16:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACE72116E0;
	Tue, 18 Mar 2025 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="RzSl3JxY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72CC21149C
	for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742316169; cv=none; b=XRhtViJsqduhosY9NgVksorV/Bdz7LrxptDjw0QQb7fJ0T3hcguPCQ+DyvpE1vQV/zN6z2+HDSPafv5o9i3KREDEhrMxPIIpvZCsdcv7wpPuSA33L1c74EGggW2RbgWMiqwBD2h6LMymsrSg+8rI6E3d1npiaNktdBCUTCYSdNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742316169; c=relaxed/simple;
	bh=LxSqXW2r5Vj9SoBZ1X29YQU2mvLmXT+ZtKFl/VWGIbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/MFbLO+Qi298Ak2SkS3MgFlQ/heofZv8jgVRXUyoQyXzoxHKVEcSfEKhy5JZKQ761nbSuYUwQr12xOe6bvkadZEfbYFt8VhZ0pnpMhKS7elMyTdLl1GW9J26LM1/e429b6PLKzQjU8cn8g94IuCNCxgGCGssTrqK+yYn53IJ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=RzSl3JxY; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7be8f281714so635581485a.1
        for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 09:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1742316165; x=1742920965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eBlIzcdc3Xvtj4gWy5HkVWkPOVhbX//nFVlD6LG7nRg=;
        b=RzSl3JxY9QVCzS2d+7n4EGAjakIaDYpVi325CHm0Z2UgIGd73/a7/XxcfsQOAeskwn
         UpbNObZnObtm0pOeexuRFWlWcdxcVwawZBss7yV9Y7AyVb5S4PFH3ced5nRK3bd+ndtD
         ARqrc9f1U2kqqruCnq1TbYm77hcALiWwZA0aHre9gNmN2e8ZWrsB1SD2JRBK2Zu2AnT0
         8nDyMaEnh5LeTiLKdbvrZH52iVlSCc91CPgRLJbNi509NeTcdTDuF3TpXZtI+qM81/y3
         Tivn8WztPGeLxWVjJTR85Ros+PgJt1Z6CvXTVrlquS6PcH/wOzENI4Qx3ac+C4CsY8SY
         5NXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742316165; x=1742920965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBlIzcdc3Xvtj4gWy5HkVWkPOVhbX//nFVlD6LG7nRg=;
        b=sVs3uWcoRiXpUgpIEhW+/dq2Pzk1f2fwE2S3QD2Xvv2WOz/gImSUpK31lEX7qhMYTG
         N5SRJgY9zQa2mQtf7H76LSAv5trSe5rvLMllB7QS3K8qexvPfJgFST0KSeP3jZfzDOCd
         l+6/p0NbAJZXC1IJW3oTzz3uVLF9lYfgNwL/09lEbg4AWKYigIkigoS6rzQj4jVvHQhZ
         S0yLB05Yh3puZey4jBAX+RvC62JSbuxUGNaeOeuAInJvpLE7BhW2X8O23/jH+EHcORpQ
         p9jVzrTqa/2begmhxg5iOd7FZqY67OOkDzUnskxXN4ELBoyGuS7rudUGXclxmHUIgpUJ
         MQfw==
X-Forwarded-Encrypted: i=1; AJvYcCUcIwZhHZayWicRB90KkA3HGatjt0bXGw2nhBcaA/PTEo+yBfa0NZFsRPZ1s5BRSkWDOED/v6+Z@vger.kernel.org
X-Gm-Message-State: AOJu0YzCD00pRO+/ZrZ49mHXEQ21ggLNU4l/sdaHOSzgwt3xIhvDmC8D
	eCdzCZcqwULyLuR/IJvvfC4FYICffKRsoLgphHuvqLWULJQViJ/dXygdE+j2LP0=
X-Gm-Gg: ASbGncscCn8AVvQ0EM1PTxr28DsoC2Spotc1u6tZbEqztjnVQs3OihoWcf0ty1jd6LV
	QKcMx0Z5dDNQGI4fXcMtfpLthhrDA2CvNAKnwkb1x5YccG62e8vCmRNv12qRrDW6jbMJpthiTOm
	nbpaPaUfl5QJ27oO+Yav459tbrys5AV6RAJyaHUbwF32frTGe11yBl/WwjbFBtTBYHnMuoFHzZj
	gKQTyYcJTxFizA9qZLZCGxZYFl2FAALpiTUe4zORdE8BlIad42McYdhMCeY6T+Wr1UfwyvRqH+5
	woPBBNbo66QMkk58EfTFHnYnMUt6Whgg92wvWlNHIfo=
X-Google-Smtp-Source: AGHT+IHQoOR0qOOsCpgqnzO8d96clCzHf4jUqi9AdgrkMbiVXfp1OVSHWbWSZQV6YMtBF7w2NI4VDw==
X-Received: by 2002:a05:620a:28c2:b0:7c5:5fa0:4617 with SMTP id af79cd13be357-7c57c8c0489mr2647132085a.40.1742316165654;
        Tue, 18 Mar 2025 09:42:45 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c4f50fsm739505985a.12.2025.03.18.09.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 09:42:45 -0700 (PDT)
Date: Tue, 18 Mar 2025 12:42:43 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, corbet@lwn.net,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH 1/2] mm: vmscan: Split proactive reclaim statistics from
 direct reclaim statistics
Message-ID: <20250318164243.GA1867495@cmpxchg.org>
References: <20250318075833.90615-1-jiahao.kernel@gmail.com>
 <20250318075833.90615-2-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318075833.90615-2-jiahao.kernel@gmail.com>

On Tue, Mar 18, 2025 at 03:58:32PM +0800, Hao Jia wrote:
> From: Hao Jia <jiahao1@lixiang.com>
> 
> In proactive memory reclaim scenarios, it is necessary to
> accurately track proactive reclaim statistics to dynamically
> adjust the frequency and amount of memory being reclaimed
> proactively. Currently, proactive reclaim is included in
> direct reclaim statistics, which can make these
> direct reclaim statistics misleading.
> 
> Therefore, separate proactive reclaim memory from the
> direct reclaim counters by introducing new counters:
> pgsteal_proactive, pgdemote_proactive, and pgscan_proactive,
> to avoid confusion with direct reclaim.
> 
> Signed-off-by: Hao Jia <jiahao1@lixiang.com>

This is indeed quite useful.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

