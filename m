Return-Path: <cgroups+bounces-12454-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB6FCC9B01
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 23:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7573D30378A2
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 22:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD5930E0C3;
	Wed, 17 Dec 2025 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="jbpl2LpB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29079125B2
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 22:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766010086; cv=none; b=jEpPvmqRHmru146y/JA4vWWfJYAu1fiOjX/sMRXvvhwjrEH8M2M0msKQK59K7ptp7Q3jJgACTLSj+4n+fn8FGi+DNkEmB8T22mwq0zGyMcXfLr6TY1Kms30aypleshUFGQmFSCGF1CFsGxRdjalpsMOwNl0tHeANFfJmEcQAD8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766010086; c=relaxed/simple;
	bh=t6L0sxebcwn9zu3xbdY2GfKbbVOglg6cmtUjSw/ffTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRyAEOF1n+Pj5z2Lha4iI2rUPrr6jX+o+JRgqRiVY/R/LcNm05dmI4ACPEwShg/3ao/YXKc1ORRglMHCD7Gff7T04GghTk8SWMmPZo34hbgO1faAd3K5jcH2F1F6K4y5OhifL5b4xKgFXuYXlerC61x2RbvUZNSYORgEp0fIXGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=jbpl2LpB; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88a346c284fso1486d6.3
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 14:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766010083; x=1766614883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oGnYf/i4vTtA3NHOb9u9oip+bNsnJWL/dZIL0+rUq4U=;
        b=jbpl2LpBd1902EvwW7hc34aXaHJfQDavXl74H6mW5xqIN6B/a3qCp/pKSnil6LCRqp
         3SjntW7dDAUgPKIXFNLtcTjsIRsAF0KRxOP1w9m6g5znssD1KBtmiPcT+GnxeCQjWa8X
         InuOevAQjJTMbuowbWpxR1NVgPvby2AZsVELUQMjbrW2GK+0gklYm7VBhfq38k6bYeBD
         49lxLSq2pNjt1fmHhNn4Ox9pKx2dK67buUGdLJiUpMfEKwhGMlpMPcOOwUv7PQOaQjCz
         wVvBjuyPAAp03JzLK8gvzIPV/TNufxf6ZuJZlT4UA5HawBFBYXvcZDhjzcobHn6l3PvB
         mLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766010083; x=1766614883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGnYf/i4vTtA3NHOb9u9oip+bNsnJWL/dZIL0+rUq4U=;
        b=anMRfRkZosHaBqPgigfdJhoJjVSjlJAz9ioUFHIlt/h4GNFsAiW9uRnSsEG323dwWk
         KG1efTGwsdZlWlAYG4ruf4dTleUonOtcdYQG9wwr8GvoNEVefeGoqiCj/oVD38Q2wn+H
         KxsKexhq0CEWB9XBHTY2Wat3ijXIHuBczeihJtPOWG2V5DRt/bWprJhTAPR5GpdYC9/m
         q2USIfKuh42IvDgsMBR0r2JZbdX91mfXXqTqYL36/wzqgZBN/Cx5z2nQ+SpTZp0Djgte
         r7Um04/5TOL8s64p5hOKlnSdueEW2gIyqH/HxFnGAxklcDGz+aPJC7poF9RaDsJ4G+tg
         pMgA==
X-Forwarded-Encrypted: i=1; AJvYcCWTzS11zPXF+g+qcU8xWPkBzTLa71e7X4XXgPnEPCB1YpLNXTdaQGqp7W8NbDOEyp8uiIX/FXi8@vger.kernel.org
X-Gm-Message-State: AOJu0YwTBNrYGQEH+KagZNVuS6flUfD/sWNN46Bycg0BYsIzkp2rmprC
	MiOKbO3JaT0sv6Ij/XRZ3ecIgf6YBMy5YMn8NRowoEbqCKvPExvYUfeRg/JURolhjv0=
X-Gm-Gg: AY/fxX46Q17twN+NooxpvNRm6Fk+8eFbP9C4ZMBqWg7OQcS4ONJ/girzpnzNMLg920X
	QdsbfbikgxUXmYkUsR7IDh09v0RX28WUDgNaNRtNZ3HDrErO9W4rTocHNqkzL/yh1oBxIQ8sg3j
	HvPObPR/eu5ovGac1G6PppgrP7HvCEN03crKZq79o9rY11KZ2hCShkmNFzKnKIpUl8nR8tfTJ1A
	UhVbXywgrTUZPgLoQZazqxy9WqyoOrI7hIhJtyqVzRdp6kFD6Hrb8nlilXv74Z0peeerxwWzP3S
	U5uB4dLkDTpWZ15cOllr2GHMTbjxr+a5zKXkT/On2CfW02XRCYOGTaeriRiu8khy5Sxw68+0BSF
	RrGuV/XBZ578wQQqIIPgZ5mSJZIFdAUj6tTyuLIHVf1fm2SMvSE5UJrNE/C8h6wswdnXv2KL85t
	SmlkToXVkg4A==
X-Google-Smtp-Source: AGHT+IHfFMUnVIsHh0LQ17ZWwdIizXxNoFEmOTGePXiUrA0zdLFlUhgj4/j9oZuKo5TXQd0Vyw3FBw==
X-Received: by 2002:a05:6214:3317:b0:88a:449e:81a6 with SMTP id 6a1803df08f44-88a449e8527mr119918776d6.47.1766010082918;
        Wed, 17 Dec 2025 14:21:22 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88c5dc716besm4640426d6.2.2025.12.17.14.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 14:21:22 -0800 (PST)
Date: Wed, 17 Dec 2025 17:21:21 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	chenridong@huaweicloud.com, mkoutny@suse.com,
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 15/28] mm: memcontrol: prevent memory cgroup release
 in mem_cgroup_swap_full()
Message-ID: <aUMs4Qn-DCgFdB04@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <4dd1fb48ef4367e0932dbe7265d876bd95880808.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dd1fb48ef4367e0932dbe7265d876bd95880808.1765956025.git.zhengqi.arch@bytedance.com>

On Wed, Dec 17, 2025 at 03:27:39PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. To ensure safety, it will only be appropriate to
> hold the rcu read lock or acquire a reference to the memory cgroup
> returned by folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the memory cgroup in mem_cgroup_swap_full().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

