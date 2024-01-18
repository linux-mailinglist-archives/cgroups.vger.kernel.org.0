Return-Path: <cgroups+bounces-1175-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F2D831F87
	for <lists+cgroups@lfdr.de>; Thu, 18 Jan 2024 20:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F479285BA4
	for <lists+cgroups@lfdr.de>; Thu, 18 Jan 2024 19:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A602E401;
	Thu, 18 Jan 2024 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="fG0aH+Do"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2D82E3FD
	for <cgroups@vger.kernel.org>; Thu, 18 Jan 2024 19:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605569; cv=none; b=d3/Ng4qQn/xr0kEJQfrb1ZPMhpE35no5kxov/Rx/74O8HrfUNwLgx1KHfag3I6Y49HzlTc9CcGAHex5fqWqFNDhB89JruLUkui5IWe/AEWLWi7Ugn4gqgtxeH7CkKefBOsNORR7AclkrMAMvzBrkmZnZ8zN1n6Lpab5+gSZ6RDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605569; c=relaxed/simple;
	bh=LdQBpPSFJZHAxiRnzyNT29aUGLfrazztcyszNCh7pSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckuAFIR4O5eDQ/6/aGgbeyKtvjZjmgPE92IVtBKr+8lc04soSAbPdeQUJAl6B6CqPvUBJ8xjsksam7kmNTu6ObTubXaczVRPSy+W3E38c/z9IhGtLUqxismqlT0Use0hiueovwpgMjs3gkZ8tokNz03Dt1NDOVA2x7xDShb+w0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=fG0aH+Do; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-46988038b26so674333137.3
        for <cgroups@vger.kernel.org>; Thu, 18 Jan 2024 11:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1705605566; x=1706210366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9MU572EdVLdUkapQWYdIbhqtVcpdD79Cvhg2J7pciqk=;
        b=fG0aH+DoYij4ZEzRUztp/ojc8RpIIsAf7UwTvSnfWKcz0La4x+Ct3BW641mq4lVArJ
         BsNlKYaPYPTMvlQG36Tje9XJ8Gq2u0RgtbVloUNgICreHryw18K0YHR7wFnmz9txKzZy
         Dz+YDuThPHnuYA8rFddVdr65vxdD+BClcHyU30Xq8n/2KIrQg2nwarLwoVASABN+GIB8
         iqQJwn6vUg5IkGq73oeDyQsC4R8Lo0b9+TSAYxiJlb5ZtRH7ZAhAMZEhXQF628D6H79U
         b/UCF9+JxbnHY7qUpbNM9PGUDdxRyGzcO8IqB1h5r96qb4JU1Y4vPlks7XWWSusSKdC0
         laPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705605566; x=1706210366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MU572EdVLdUkapQWYdIbhqtVcpdD79Cvhg2J7pciqk=;
        b=Hg1IiIfkJlSb08GwEQjN9drN/8fsRqVEAnZqOos2sSHP9AIj2IqUjiiQryGvvNgkSH
         RXylCAzHA6oLaYadOPsEMPQMPiFHva1xoQ0WvDALfnI5jb4mFCuvgXJ05yT9jN6Gtb6P
         XartHcczTo+TlO26mt/2v68hqX6Ps6ESGX9YLS1Z3e3nc9+uJdwMemGDcJ/oUDFS7fYJ
         UtwIoQAzHdV57oLN4aZERXYrJ+D/XurJQbY8qOh8WYJZzjJpmzcS6MFOd5GLgL9YYb5Y
         oVD+EGOruW+vrl6Iz7Me5kD3mvh59XjMX/8x5q7m83dQaVg/+T3IykIX1WGtcqInaK2A
         Zo4g==
X-Gm-Message-State: AOJu0YwMYDnHpr57dHCqH3CBGjo2AOBUoOskdsatb5n8aL7QO+usMocq
	XRA51ICGRFk3Zceq+2QIqR0Q2VGtKskR1ka0Q3XYiPrHkBRT5HOKJtBmeHrWUIU=
X-Google-Smtp-Source: AGHT+IGKfTocm4eVWCtnjc03F2xb43OO+W4kEUU4mAbk31KIM3WqWdepd95bP8ts1QqIQXTIPbACQA==
X-Received: by 2002:a67:fe45:0:b0:468:1083:39ea with SMTP id m5-20020a67fe45000000b00468108339eamr1375691vsr.20.1705605566127;
        Thu, 18 Jan 2024 11:19:26 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:8773])
        by smtp.gmail.com with ESMTPSA id om9-20020a0562143d8900b00681a83650b9sm64917qvb.41.2024.01.18.11.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:19:25 -0800 (PST)
Date: Thu, 18 Jan 2024 14:19:24 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeelb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: writeback: ratelimit stat flush from
 mem_cgroup_wb_stats
Message-ID: <20240118191924.GN939255@cmpxchg.org>
References: <20240118184235.618164-1-shakeelb@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118184235.618164-1-shakeelb@google.com>

On Thu, Jan 18, 2024 at 06:42:35PM +0000, Shakeel Butt wrote:
> One of our workloads (Postgres 14) has regressed when migrated from 5.10
> to 6.1 upstream kernel. The regression can be reproduced by sysbench's
> oltp_write_only benchmark. It seems like the always on rstat flush in
> mem_cgroup_wb_stats() is causing the regression. So, rate limit that
> specific rstat flush. One potential consequence would be the dirty
> throttling might be decided on stale memcg stats. However from our
> benchmarks and production traffic we have not observed any change in the
> dirty throttling behavior of the application.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

