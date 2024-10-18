Return-Path: <cgroups+bounces-5161-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F47C9A3E75
	for <lists+cgroups@lfdr.de>; Fri, 18 Oct 2024 14:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318E0286255
	for <lists+cgroups@lfdr.de>; Fri, 18 Oct 2024 12:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8514207A;
	Fri, 18 Oct 2024 12:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="bYkYiKHn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D652AF16
	for <cgroups@vger.kernel.org>; Fri, 18 Oct 2024 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254691; cv=none; b=YzC3iqd+9Psz0IeI0GJ+DmozVoBy6NMuL/dafYA+evdj2SUGCWLJE1HJzd/zZYtBRrZMp64mXgTAdH+e5LtxQhKGaD1VGaehWtwdAkZI/e72mHcT1y61ErWJyK5wFP/UnECxr00nBZ6tswimlFgW342ZLukm7e0WkDkXbvF3wBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254691; c=relaxed/simple;
	bh=YepgUkJ2lToDPFN225mu6ARD4Ji0n/Z2/yUcAuje8jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqOasnZpYq3dchddF2WdFbpBt8tCA+lyE5/KC00wUpsAqezyhowHanXh+ZZErDaAEsYPWuLUQ5l/X9wgqGB68/GJnOH9OFO8p1hI3ap5mQ5jhIOwUvn+xs3o40ZC6nc5ktyx713PpjWMJmO1/fBUHrTQfJePJusXNNJ0HxvNzYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=bYkYiKHn; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b1457ba751so166913885a.3
        for <cgroups@vger.kernel.org>; Fri, 18 Oct 2024 05:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1729254687; x=1729859487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ljwrlb/z0YLznPxkxUIrF1QefOIilHj7zulCESswlBA=;
        b=bYkYiKHnlAYEYRD7neztBhrxGYXee2IBDMkJBh75+yl7aoNSWqdpQFbDiRoThk3GAJ
         2SC+cHGeBIDiKWLu4CqmBltkNHPNzUl353tISrgnqABBD8SxXyYpUcr2C9WbNC97zXbA
         hef/jM0H1oZy2iYhVWxVxGeVJTQ2AvVUMDscukLc6MhPijAGpojEdtSRge5MsZ4JRieK
         dJRPe9f05PsTOwaDRfxe1aSIqbJtmhQyN+ubf6Ut/bZLoM+Y/Sar7KZYCirhLEW8vTEQ
         HJ7TeY31lqStrdufY+dZ1/vI+k2XXTzYoelxtrof6JV6CRQwlBSMq6ukpnWSZSx4ifRL
         Ik0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729254687; x=1729859487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ljwrlb/z0YLznPxkxUIrF1QefOIilHj7zulCESswlBA=;
        b=I3VLHkndmJIA7nn/GRURLQuI977O50wBTJSe+D1JkILt4o3asoQz8dQk5CRPmiZbCe
         i8HGeWANDIkE2ByeWLaEhT36fQ6SEPlnykOWffeCJSvahQ6axQ6yIyEHUIhymnm3nIne
         Xwpt5rj3frmisjVLXU0xkoigmwlDVF0RrDUPpp6nSY6K5SJmoFrxV4WN+auFTyE14Kya
         PY7w6wbGRlEB0VWggIMGoYs2jr4wzDAH6/gfIVjX17uGbjtW8ACjuJNDgkq/Hg1Y6zRP
         IIJDVBKq6PPyDvw0772bOerkXvJO6eFf8Ka8R1L8xu2hMXhzrVf6I+pEA6OzOmqqa+0R
         1QEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeS1iO1KOgXifBUojeDiqaI1JgIoQJR1wJWY62JJke12pgGRu98ibTvgJovEH/aFEbqLma/wwA@vger.kernel.org
X-Gm-Message-State: AOJu0YwuZ/H87ttbi6D1rxttE3cz7lQiH28anKrXMgQwDmI3eGg6uuj8
	E2mJxUZykAO+9YRmW0CPItI2y4xNtxGhZpaXGtXlbslKQY3VmYSLqpIU1m5Ewa8=
X-Google-Smtp-Source: AGHT+IEpkqPl93VHak2DLYK90RodDlnBgH2nXjIf3o6uxKklx+2vSWQ80oe+0osSbgMlMBVXosCFnQ==
X-Received: by 2002:a05:620a:468f:b0:7b1:3bf8:b3cc with SMTP id af79cd13be357-7b157b5a96amr270233785a.17.1729254687596;
        Fri, 18 Oct 2024 05:31:27 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b15700b3f3sm63750785a.136.2024.10.18.05.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 05:31:26 -0700 (PDT)
Date: Fri, 18 Oct 2024 08:31:22 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, nphamcs@gmail.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, lnyng@meta.com
Subject: Re: [PATCH 0/1] memcg/hugetlb: Adding hugeTLB counters to memory
 controller
Message-ID: <20241018123122.GB71939@cmpxchg.org>
References: <20241017160438.3893293-1-joshua.hahnjy@gmail.com>
 <ZxI0cBwXIuVUmElU@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxI0cBwXIuVUmElU@tiehlicka>

On Fri, Oct 18, 2024 at 12:12:00PM +0200, Michal Hocko wrote:
> On Thu 17-10-24 09:04:37, Joshua Hahn wrote:
> > HugeTLB usage is a metric that can provide utility for monitors hoping
> > to get more insight into the memory usage patterns in cgroups. It also
> > helps identify if large folios are being distributed efficiently across
> > workloads, so that tasks that can take most advantage of reduced TLB
> > misses are prioritized.
> > 
> > While cgroupv2's hugeTLB controller does report this value, some users
> > who wish to track hugeTLB usage might not want to take on the additional
> > overhead or the features of the controller just to use the metric.
> > This patch introduces hugeTLB usage in the memcg stats, mirroring the
> > value in the hugeTLB controller and offering a more fine-grained
> > cgroup-level breakdown of the value in /proc/meminfo.
> 
> This seems really confusing because memcg controller is not responsible
> for the hugetlb memory. Could you be more specific why enabling hugetlb
> controller is not really desirable when the actual per-group tracking is
> needed?

We have competition over memory, but not specifically over hugetlb.

The maximum hugetlb footprint of jobs is known in advance, and we
configure hugetlb_cma= accordingly. There are no static boot time
hugetlb reservations, and there is no opportunistic use of hugetlb
from jobs or other parts of the system. So we don't need control over
the hugetlb pool, and no limit enforcement on hugetlb specifically.

However, memory overall is overcommitted between job and system
management. If the main job is using hugetlb, we need that to show up
in memory.current and be taken into account for memory.high and
memory.low enforcement. It's the old memory fungibility argument: if
you use hugetlb, it should reduce the budget for cache/anon.

Nhat's recent patch to charge hugetlb to memcg accomplishes that.

However, we now have potentially a sizable portion of memory in
memory.current that doesn't show up in memory.stat. Joshua's patch
addresses that, so userspace can understand its memory footprint.

I hope that makes sense.

