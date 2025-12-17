Return-Path: <cgroups+bounces-12461-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FF6CC9B91
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 23:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F04AA30198CB
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 22:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C2B3115A2;
	Wed, 17 Dec 2025 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="cywIUXl1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAFC1D90DD
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 22:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766010994; cv=none; b=sMtDJEKcYwZbxjQ2M6/fwlw0A7EGi/Q27ibsgTWP54Dh0dkFCkXcFb9x97084KIskUmCAkU7LXSFtTrPVgVIdPq4/ji+6Bec+MUlDZmI0Rfp3lsCquQwnt9Yr69SEAdsU3uwEIDpD9l6L5bivQiofu+ca3Wi3Mb5A0/WUlUHG7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766010994; c=relaxed/simple;
	bh=ZlT3KqTofwvBhqMe18ZKfZ4B3GbTBwIPlOKEwMBXdOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tR7aLZ/KkEkbwOjXNxbhTaVQqVbhzbhkk++fepybVqFQHVegLna87v6hxvFH+6y2kKHDsmr1VEO+VrfLvWSs3vWWTpUplfTdTtbocwN/q4MdbcZHXNRtvtW/Xy4I/0n4D5yBjQS3LuHdIJfO/NJ/e/WdYKPZ+r+guim7c0Athy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=cywIUXl1; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4edb6e678ddso87093451cf.2
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 14:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766010991; x=1766615791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kR/+xgf6Jhz+E5StwKcRK1JFVZohgr4tToC9Isegfuo=;
        b=cywIUXl1d+0/ikwRqhwvJtnNsFXsCVQzp1s+Ab8De2GklVPa3KvBj0421B78pa4NEV
         nZjAd51OxqyheOnHMineFg3nmqM8jQnyOT00Jksf1Eh9fJZYCB3Ley3MwkiI9S3YriZ/
         //0GPu2pSORy+WaDv5NOIgc69l649t3ryWbdpR4ROmW6+JQFqp5fKrca28n1i8WduJrG
         OPckdvp7ImGWK91rA72kOR5Nq39XUowhcGYo4OEyojKArPAlHQrBQaumCjcCX+VYdWvq
         AEnUrMWDiXFzqPy1QuR/SMqEKucLwmCiIVzOnfH7Gm7qpJ/NRhSnkLsmPsmttuidxl3q
         yH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766010991; x=1766615791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kR/+xgf6Jhz+E5StwKcRK1JFVZohgr4tToC9Isegfuo=;
        b=e1ZRj1FUYvmLmsL+f+X9oczEi0l+HDqzmKa5FVMR7tae1TmZQ0sUaLROJLbwlp6eSJ
         RFPjpbRJqo2bPGvmBSxWH5fMA4W2NcVKNOXeAjZgVWG0hIHfp42wGPVl89dimUBFvTnO
         Hcgl0X207uiYReLcK2zhGE6Hc5klkAmgt2RPlHTWgXv2HAifa99tFlLyzk9ph5aFqZ5z
         CrGWQ90pomL74hoNrbCjSxK98nQKJg+69xBlBolPYRWY8pqNJ/fQyDE31HabMFOpIP1R
         JwVt3+5hQjlkVEYxWnQ2xTznOx+t2n51l8gO+gVxIG4SlGPmZMefK1nR6c8bk2s78zGn
         Ckpw==
X-Forwarded-Encrypted: i=1; AJvYcCVhSSmKkL+lGh65BgClWeStwrgiVk9QwK4gbh/ywRFaGUWrQffgG0Ffx4EWNPi//d5yqACls1XL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0sVweQxKe82aMSKs3gOn2NYQzFxvw0qlQ0eNQypNy4D/WWp8q
	zKGxIXSyblic3oy9HKeYKlb2WN/mdm0c9XMVTcB3KgtI+0OpO71tkZs1yv+Lm+6Oslc=
X-Gm-Gg: AY/fxX6zYf3MXH4f8fPOHsBk9bdsnIfp7msU9J//mI4fwF0OCXfYB3UKXMwo2Jug1Ko
	siQ4CQAQ5JmwEaxti/R/IgiCIi6nokXrtsQAi2lRKLkljwGv2oeIhXXKX4l2VOF41QpYRli+sZP
	gfwEdCmiBS3F7U2FqqmYPk3npnJ8Al3rf7zCtOgJsWVWUgNFm32/FrAeWZ6fx0LKsOmLE/jwKsf
	/tiO/cbbwwI7MYwfcUpGuyQcosi9Qn6cDI5OooaNPf+VFEUeevpwNbnsgQafRfMmLgrzgU/ePAU
	S9k61bP3oPRUybVHplYjNoVt8W0leyLL8UNzaVmrD7Tleoy1yI2kxhXHK2kWP4bhk/+Rc67VxFm
	0K5qmMhALmhyQUQETXVfD9p9GLiwDZ8FvMPq6aFEwHHEOXim62VHTtJTqJDhaJq1kpb5fzgvPpu
	eooRMACma83g==
X-Google-Smtp-Source: AGHT+IFEnoIqNTzn/beBrrTTMm5NCOBdf6XqjRvcyNax+rsawQ6zsZEDQLLD5Cw+412x47E2IhWIYQ==
X-Received: by 2002:a05:622a:4d89:b0:4ec:ee2e:1c20 with SMTP id d75a77b69052e-4f1d05a9294mr251307421cf.47.1766010991640;
        Wed, 17 Dec 2025 14:36:31 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88c5dc728afsm4765666d6.12.2025.12.17.14.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 14:36:30 -0800 (PST)
Date: Wed, 17 Dec 2025 17:36:30 -0500
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
Subject: Re: [PATCH v2 22/28] mm: workingset: prevent lruvec release in
 workingset_activation()
Message-ID: <aUMwbhEN8WLvSNXb@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <195a8cb47b90e48cd1ec6cb93bc33a8e794847f6.1765956026.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <195a8cb47b90e48cd1ec6cb93bc33a8e794847f6.1765956026.git.zhengqi.arch@bytedance.com>

On Wed, Dec 17, 2025 at 03:27:46PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. So an lruvec returned by folio_lruvec() could be
> released without the rcu read lock or a reference to its memory
> cgroup.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the lruvec in workingset_activation().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

