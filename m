Return-Path: <cgroups+bounces-2547-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C27C8A76E1
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 23:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05FAE283AE5
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 21:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C31713792A;
	Tue, 16 Apr 2024 21:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+VTSnLy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EBC6CDD2;
	Tue, 16 Apr 2024 21:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713303484; cv=none; b=hGLPxis048KkGbba35yPpHFCmj4oDNGfqmWvsQxa34eL/FlU+te62V6lCs1LWI+AG4WFx1MayaA4J9DnvUq4goPrqJLnejJ/1+I9U2XDK0DMotbTGC2SyTFKtGpqGiK3xUe1fAoWJRoF9usNGStn1OJn+ba/EJ/Nn3owSW5Isb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713303484; c=relaxed/simple;
	bh=B+n5iLr1/2SxcAwtyZ5duth3iMrBAHfrJUv5OU0YCRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/cnenK7FqAc1CHWZ6MPN320Yk4cZXsgM0CfVQ09E3iUzo6x/D+ua4/AxHA1sYLCebG61f5VCLJYK/swQc9UTUXtXp9H3wJe+1GrRriN171DU+trWqks0vpHTnsw08Lutz49jtW//++KhRG5DKHKnnLeqSGSXXkV7OygFl4ZHzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+VTSnLy; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ecf406551aso4003268b3a.2;
        Tue, 16 Apr 2024 14:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713303482; x=1713908282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u61spwe0Do5c8jGaqkZhY8ilzLdgZGrdaCrcO7X9sXs=;
        b=f+VTSnLyR7dh8obDPMNbQFtmiIn4OcPeh2sNMjzbE2fsO52EKBDJVHq1Ne4NyLv924
         8a7GFT8QIDdMk2XYsIDSo6+mantwOt1CfuE52x0Yul6lLcLHO7uqVkh+J20jlH5sW6qY
         GqVC7lTNbkOk01+YVQi0Go2cEXZj8ypl3TYHu+lE667cDlIhNw+egK5QmNOZ8UgKEDJN
         mqyqp0t4kUUaGqhroJHvAshHc+Lktj2/M1r15NcTU4MAM72RyF2Q4JFwfjbUKiWAC8Eh
         j6fGx3kCZhe4cbwloRVPSZRyXSpJ0YApGk6XLqEyq+niHYsvP4+Pu6GgJ70rvH5kHBy1
         dOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713303482; x=1713908282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u61spwe0Do5c8jGaqkZhY8ilzLdgZGrdaCrcO7X9sXs=;
        b=pt5pvsICxOKO/5SjuIcNVo1XAwEPfXSLp91ZBQ+2joDAoaF0XSctm9snz3o/CFjbkC
         sLflstnWAmUFkUZPTBjFd706/SqG6FRs2tfB1fXAfDt13lURA7I3FDbxSBuzzVZKGhVZ
         dUBHObyJPQr+ozC8K/31sNqr9RHsLRrw6NsHFvLT2dn1+WYZiX80hpe0dK1B7qXOyfrF
         iWMvI4FlOxrAs/b8o05ezm2PvvN4E9fCiF6dZU7t9KwfFKfSAlG0/5ReNRHc55ybNRZH
         P+faS+ZshrUVz8Y+QFXfS5TgKaNttIdtylL3cEPBFjGXoC7A8LbNnBnkC1U5IOU7aQQc
         F2Zg==
X-Forwarded-Encrypted: i=1; AJvYcCU/QFLNkdhz0HZVGMRzKYm4nzQCw8/k5Q/tK3x5Gsl/O6/OF52exj44bmR5jVHoukVztUhdqAxYXM5RGdwrBF0DvGdb8hPd4RWatJUQkwuQyiruWk+SF4w9UceViQFWKy60aRGt2VXU/B6OZiRoDPw/lcVNkB0NCYWgVAqPVQ==
X-Gm-Message-State: AOJu0YzG8ra15BqPubhjEDJmT0F3pidlgBcqnhVGggkz0pAZYcQ1viZN
	vBtXwxuQgEE5aEWor6DWMIdUyt8rjiJ069wz84vyEpXsL57iqR8B
X-Google-Smtp-Source: AGHT+IGAqWMvfZR/RZZ3R9FQipVdZf1WSHwhlqc3pdo9y+G0wImIbOKtoUwycS9QWma+oi01TF8WBA==
X-Received: by 2002:a05:6a00:b44:b0:6e6:9af4:409a with SMTP id p4-20020a056a000b4400b006e69af4409amr16443625pfo.33.1713303482049;
        Tue, 16 Apr 2024 14:38:02 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id k195-20020a6284cc000000b006e4e93f4f17sm9874856pfd.117.2024.04.16.14.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 14:38:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Apr 2024 11:38:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: hannes@cmpxchg.org, lizefan.x@bytedance.com, cgroups@vger.kernel.org,
	yosryahmed@google.com, longman@redhat.com, netdev@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	shakeel.butt@linux.dev, kernel-team@cloudflare.com,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	mhocko@kernel.org
Subject: Re: [PATCH v1 0/3] cgroup/rstat: global cgroup_rstat_lock changes
Message-ID: <Zh7vuBRbA9rT5OCO@slm.duckdns.org>
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171328983017.3930751.9484082608778623495.stgit@firesoul>

On Tue, Apr 16, 2024 at 07:51:19PM +0200, Jesper Dangaard Brouer wrote:
> This patchset is focused on the global cgroup_rstat_lock.
> 
>  Patch-1: Adds tracepoints to improve measuring lock behavior.
>  Patch-2: Converts the global lock into a mutex.
>  Patch-3: Limits userspace triggered pressure on the lock.

Imma wait for people's inputs on patch 2 and 3. ISTR switching the lock to
mutex made some tail latencies really bad for some workloads at google?
Yosry, was that you?

Thanks.

-- 
tejun

