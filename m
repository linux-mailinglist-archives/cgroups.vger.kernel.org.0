Return-Path: <cgroups+bounces-7169-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 690B2A69901
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 20:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430871B811CF
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 19:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2B52144B4;
	Wed, 19 Mar 2025 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="KzHR6tAw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6A220FAAB
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411806; cv=none; b=YPNUQhlmb3N50WZENv3ZjMpgxPv+f8Dm5BQnmOt4XD8hI0CYQc1U5Ql7hS/OqANM6DGwal1ZeqQbX3D4BtOppnKOb1g2MTOPhpdW6C+Y0mADWENnqUDVZmLFT062SOYt66aanG+lOcmoxFXu+fF3Bi+fHz6KblTCcN4zvJemMD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411806; c=relaxed/simple;
	bh=tXLoUo6DziRJgG2bIsKtUTPmu7pJFqeAmmvjt5Rxncc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bk0Z4M2BBUz2l/MTyrqnIQE+fIkT5/AVUVfZo9mRtakgEjoZByVpBv4Mt502yEU0haRbi9pdUWdjdAXIR+wDsgE3cKkPPVvm4LjTwrltPrSmBcoflyJVmp0INAUKUbngTr5e/MdMRUP9CNZmCdZxZrD456498qsUJRs1MkaHufI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=KzHR6tAw; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-476a720e806so476921cf.0
        for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 12:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1742411802; x=1743016602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LwZYITC3Gbppixi2KZZqHp5PUuDT5djtLXFC/0w6SVQ=;
        b=KzHR6tAwBp5jiEYYpndyc+S7n6Erl/dddcvUayvNgaJI7RL7170ucTPs9xu9ExtiUu
         WRmXVk+HoZJqzU9hhlf3UWtgfP1OTLkN7oII0OdpjEKowaI5JOCUrzpXgHckA6Fxy/0e
         e2cQ5YI0G1/a+eviUWSTjlXkE7U1umvJLXg2+6mejctZWg2B/PQfyYk5aVIYnR7NFi3/
         jXJitGMW3J9zRwoKIfWnjqql0b2cNWNLC68HtT1MTgufx4jBGAeyk1epDMfUBVy2ZIBr
         +qyuB/DhNUgOdUmLhBREIXy/Xh53MKjkjkK84oPRaw9c5dRZsMOHQ964yVIS7u5AhIoY
         9Zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742411802; x=1743016602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwZYITC3Gbppixi2KZZqHp5PUuDT5djtLXFC/0w6SVQ=;
        b=RRWuwEFjowt4OA0ytqv0Cg8PaAdx2FbbqZGpI+3Ljo4EG5julrXErBz2UlAMMcbv7T
         c3c+7j9N/gY/fIkCJQ5olWJzHhsmVFoFjLG02/hDEJcFlU/jj0ZhIlyinUnmyE8wGoz9
         toihqkHsjTfHNsKoG2yrXmcKMrKUQNS7Z4i0KGl7kS1eaeqffFdTUDDHl+NkQfo9eWkH
         S8Gd9vWuWjwL23mxsNWHpmrTLXCHcxoCq+YgDHBUW0cFSWFlsTTxdSb7dMyIwUqCbH0m
         P99UGcxbApXJzg52daem01CeguiZJJ4DLmej9vzIoq5qUDK0kFvwqvY4HiNuvDPCkjCL
         Wp0A==
X-Forwarded-Encrypted: i=1; AJvYcCXJ3AuzYO/GxeBTxnvqNpuviDQX7iK+1okupd0yAM6mKFvMJaOgsMfCDt5h798lPaR+DovxNM9n@vger.kernel.org
X-Gm-Message-State: AOJu0YycMW9CxjlPNIBWjMHEqnItB7MxENuaiEenmV9D8hXDC7eq/eg6
	YDIR9wMtBRnGRPU7ZmcT+pgsVW3cXMA+NcUFffL+60NJFadG9K671otUjJuRn7g=
X-Gm-Gg: ASbGncuR7H0gjUXD/oAQj1GamWZICWJZoqt6XNGMFkpOfyPolzrCRzM5poCkDpxYGSG
	TsQXYwYiHQHW4T3puPf1X68627nwesMRXeXUJ5+8I0V5j4r1I0CgQ24qxysOLgClptCUoRrGtnO
	H75YY36n/VcqAqh0atnlqD+1eqd73AxlHgodJjyf7WRV8TTulAKh4ZDcjhNASccaHJXwkEY78ae
	XRGr91u8n4wqy6FxHZNacOASvfjp2ufsbCUVS3qisAmIx6j6UckdXA1/c/oyOewM82ceIzu4b9M
	SqcqjYlqN6FaXO71SkndEOkxEbl/bMd+GzrRXSUGzTo=
X-Google-Smtp-Source: AGHT+IEL7dBxtUf8JbHdoTqCi0756jwzQ5qz/ECZoCAsd0Rnq2Y+/GuVS5qghsIL92pasrWy7R7xjA==
X-Received: by 2002:a05:622a:1149:b0:476:980c:10a4 with SMTP id d75a77b69052e-477082dee45mr67738901cf.23.1742411802648;
        Wed, 19 Mar 2025 12:16:42 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47705ec40b9sm15493031cf.3.2025.03.19.12.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 12:16:42 -0700 (PDT)
Date: Wed, 19 Mar 2025 15:16:38 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Greg Thelen <gthelen@google.com>, Tejun Heo <tj@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
Message-ID: <20250319191638.GD1876369@cmpxchg.org>
References: <20250319071330.898763-1-gthelen@google.com>
 <Z9r70jKJLPdHyihM@google.com>
 <20250319180643.GC1876369@cmpxchg.org>
 <Z9sOVsMtaZ9n02MZ@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9sOVsMtaZ9n02MZ@google.com>

On Wed, Mar 19, 2025 at 06:35:02PM +0000, Yosry Ahmed wrote:
> On Wed, Mar 19, 2025 at 02:06:43PM -0400, Johannes Weiner wrote:
> > (btw, why do we not have any locking around the root stats in
> > cgroup_base_stat_cputime_show()? There isn't anything preventing a
> > reader from seeing all zeroes if another reader runs the memset() on
> > cgrp->bstat, is there? Or double times...)
> 
> (I think root_cgroup_cputime() operates on a stack allocated bstat, not
> cgrp->bstat)

That was the case until:

commit b824766504e49f3fdcbb8c722e70996a78c3636e
Author: Chen Ridong <chenridong@huawei.com>
Date:   Thu Jul 4 14:01:19 2024 +0000

    cgroup/rstat: add force idle show helper

Now it's doing this:

void cgroup_base_stat_cputime_show(struct seq_file *seq)
{
	struct cgroup *cgrp = seq_css(seq)->cgroup;

	if (cgroup_parent(cgrp)) {
		...
	} else {
		/* cgrp->bstat of root is not actually used, reuse it */
		root_cgroup_cputime(&cgrp->bstat);
		usage = cgrp->bstat.cputime.sum_exec_runtime;
		utime = cgrp->bstat.cputime.utime;
		stime = cgrp->bstat.cputime.stime;
		ntime = cgrp->bstat.ntime;
	}
}

and then:

static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
{
	struct task_cputime *cputime = &bstat->cputime;
	int i;

	memset(bstat, 0, sizeof(*bstat));

	/* various += on bstat and cputime members */
}

So all readers are mucking with the root cgroup's bstat.

