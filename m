Return-Path: <cgroups+bounces-7138-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9907CA67A02
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 17:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5989D3A7651
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 16:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E142116ED;
	Tue, 18 Mar 2025 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="gowYnnJz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBFE20F070
	for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742316198; cv=none; b=kxhLAXeoi4fnXbk0zIn8ShyllNghBEk3IJPQ7hnTYf/lKg0g9ZsyVYPR+cVIvirk33y/8nQVn1yIgHlDMkCu8vD90H5gaiyuYTIuh3e8JnI0Tsmi2TQ7YJHOILQnRCcyy4WIQwwf6EIGYFDqCpXhTSMVpCXEgfp7YJETeCZj5nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742316198; c=relaxed/simple;
	bh=EsbgIYtjbfNeElRzR6OisnRntRlhSoTM036q0hXfBZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6pe6DEU7IvCWeG0LrWXf9qzmS/SxTAVREiZD7Iz7fYdlBvBS5irCO/K8mgydwNzaRUR/c7LnbBeS4BB5LV/c5xaqMos5XUyAVC+1DAkTanvFKZmKzjpxlSXqUUTYa1YcbveUnUFnmEyV1C1jrMKlJoP1z2TVyfR7SNJvyNNnw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=gowYnnJz; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-474f0c1e1c6so55614321cf.1
        for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 09:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1742316192; x=1742920992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9CLAy0aRkMC+3t0gCpzgmh226XJDIlR7r1Y/Y+7ry4=;
        b=gowYnnJzXSONBI2Ig6zTHQe4j6yag4HBZr+QmqtGUtdQTGNtFMqajMKPAWMejUc8LW
         4OSH48gkxrc04bsnf1MOTenuMQgzYSAVKv+QliIwYxWfx4PLftuNlpMXWkh9Sn7jXJJ3
         orZEnhTVgDVCdah6u7KMUbMk3MKKGiMYRW+t1Dj8aQuaVRE7kJIWDpt56kIpLz369fLm
         JrUhWW4SNMC6t6wkL1RheLmN4A+DkO+8ubJVRWppTE0ArrN0JLUIfNQWKT+bnBTjC6h2
         xM/gjQveoeFS4KNHD+gkGID2tmtlH/RMY1UAQYTXkw9+ZWQ9X7vYe7Ie9M6Lft5bD9nA
         cGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742316192; x=1742920992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9CLAy0aRkMC+3t0gCpzgmh226XJDIlR7r1Y/Y+7ry4=;
        b=R0cN3AZ0uF9JM8HJ12ItcrMghsJATQiIElq//CHk64uskqBpz4sBaWMyz5g0ujhgoA
         6FhlEJ6RWp2c57YnQ1vWEjeLTfMNwUjXk3itRvUBiS7fheYARB+q7mSgSByKiH6latb6
         heNQbyS8PpQa7nXFy+ttFB92pXi+0ld/vN8KuDL6X3MBhnTTwf374lG4/8lDohULbO4L
         6BaTb5lioapKtu3XXSz5l/QJGOPKi1IVd8CTMv1fHo6OrRZp5W8lvSRAPu6SdwipbBKc
         rgLKsmf9Infi36BIUeANOYpPY4UFVoIaFm9veu2Qwf55lI4J9WFNmfJcjF2/G6YEfSHs
         X4dg==
X-Forwarded-Encrypted: i=1; AJvYcCXk/mNxoRtdCyW+gslGqgCQCzW076uqrQxcu824H0RI1j7RLlZaCIoW/H9X5oaRs1dxullTvS+E@vger.kernel.org
X-Gm-Message-State: AOJu0YxeBZlOBHglECf8z7BgYY+hsGaOX57IVuU1MQygl2qS3W+jCJ/C
	afdVTt/q+TE+1NzJxV/nikhL46zvp+3UeDa5Jzkz0CBjru1DeJDZpSKfdJcU3vI=
X-Gm-Gg: ASbGncv4RPrvgaU4PDXrPpCFzOWrIO6dxA0xNkslkBM4lCNv4n1GsCPd+YHOVwAZ5tK
	4WWHWvATRgvTr4ynps4wuXM26lNu62aICYnKtQo0Y/sUCat+w0NtPwAEM4WhKocCmBFWK7AjwcI
	9DUTVTeEqtONuoyouvLdJmCpYHL9edtGIfGJLiJ1wGEstS04fNWGZ8cXUeX4X2rLcRU0bHksgqj
	nNfPE5rtnoXPMrBghuzyY41YIiqXw1YkbdZhXzDCZ1gXWcXMt9LUvLxrrMfmMCPOciANsCWD6mZ
	/qT4CBFh5TKvs4QyftSwMr/vV8lTXKEC04+ndM9U6Zg=
X-Google-Smtp-Source: AGHT+IEzTYUQvFIqJGczT4BQNneYiwp+YHih+8M1aGN1FxBK+xc18mlXInT5tBAGDIgXKIv4Q5neOA==
X-Received: by 2002:ac8:5955:0:b0:476:7199:4da1 with SMTP id d75a77b69052e-476c81d94b1mr252892281cf.46.1742316192210;
        Tue, 18 Mar 2025 09:43:12 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb7f3d0fsm69107731cf.59.2025.03.18.09.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 09:43:11 -0700 (PDT)
Date: Tue, 18 Mar 2025 12:43:10 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, corbet@lwn.net,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH 2/2] cgroup: docs: Add pswpin and pswpout items in cgroup
 v2 doc
Message-ID: <20250318164310.GB1867495@cmpxchg.org>
References: <20250318075833.90615-1-jiahao.kernel@gmail.com>
 <20250318075833.90615-3-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318075833.90615-3-jiahao.kernel@gmail.com>

On Tue, Mar 18, 2025 at 03:58:33PM +0800, Hao Jia wrote:
> From: Hao Jia <jiahao1@lixiang.com>
> 
> The commit 15ff4d409e1a ("mm/memcontrol: add per-memcg pgpgin/pswpin
> counter") introduced the pswpin and pswpout items in the memory.stat
> of cgroup v2. Therefore, update them accordingly in the cgroup-v2
> documentation.
> 
> Signed-off-by: Hao Jia <jiahao1@lixiang.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

