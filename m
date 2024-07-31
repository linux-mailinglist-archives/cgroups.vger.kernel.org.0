Return-Path: <cgroups+bounces-4023-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CE49423C3
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 02:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57CD2B23902
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 00:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9751146B5;
	Wed, 31 Jul 2024 00:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dl9J8SP8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA33DA41;
	Wed, 31 Jul 2024 00:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722385321; cv=none; b=ctlkx0qBOEARTRAVUW7SxZmtDJdtnjU62+VCQo45NBOisYLFWsWi8HKCSIsi1SJcOVM6pnAj6WYsuMdbMdfTkRYK4KKVeLORXxHbjCeL4KXNwWr/ger7rJakeuE3yGA8EApqNiHHEJccVt6hb67eB3cwXLd5Ltmgh+RGiYv+Ocw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722385321; c=relaxed/simple;
	bh=Be7IDsaltHpOt9duyrEi4EFaUTA1FF7S9nmfFfk6XqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAdWBmP/jRZHtltgt83z0gWG6KPuP+2FobHAwFbxcQtoOVeQWdKtwcQovM5Dx2yX/iqRHoORTNxnlBNGV5NysYSw0CV6uwx6GcQ3bONVev3n+S7ZKhhdUStIfj0ewpx8NWfoGoPaYOghr79+TzMDRGH78v1PcYDvHvlh7PGjFhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dl9J8SP8; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-260e5b2dfb5so3403720fac.3;
        Tue, 30 Jul 2024 17:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722385319; x=1722990119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zv44PSmRmGyba/q7aqW6v9CZMieeVvkEwzEJWnLLESM=;
        b=Dl9J8SP8M+Gdmj7lDr71rx9wIVzPLH+V5n3d6b6ZDKgQkU24272Z2ZVQAvXUYYDcP0
         T2qKOFB9qzGQA9/kMSRAmqyWjn9eEdwKo2D9BycpUhqFHliRvs/SPFBDcPf4i9hDXdH2
         zypDHsYVETT0bhuSstMSo3zrJw7XYG1X5vgOrnbbQ2YOk6/s+yqFwypwoHfAMib2eavx
         oALz3StQseeEstgc86KzUzlhEmqfNu3cBy1G+M+ID2YjC+N1HXDTUlHm+vX0/NjAhI8k
         b4OTrWfEa3F3NEtnhSiYE0+1nE0T/K69A5SntJR44bNaImeQwgrM9dmo5e/6n7JOWtNb
         x2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722385319; x=1722990119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zv44PSmRmGyba/q7aqW6v9CZMieeVvkEwzEJWnLLESM=;
        b=CXJP/OmLi2YPlYE0LUUD1Hi1szQgKg6+6agh+UrgvIKiaDlGLqBlvDYusMZXeeFmgz
         x9RbibY9qkGCzRyvI5MJSbBR+kaYhkKoX7iDCHNWjKSwnbVrViKUeNNHEu3pzRJQXzBg
         Jl10zNlnzQuurQjFUqPSe2Ye+2CQwBxRRoRAjSOqyoPSzwMl2aNR/cVDN+uOBhVrO41c
         MziW+SUe2VyKsfWmYjKA/+ZwvSCJMQRGg0Z/IzEOgdAk2g9sBVxOegWU4mH2fn/ieI3Q
         ac1wpwAwzX+WTpzKrUgedFi26fdh27bqOa1HyQsmXbA54kZ6cZ/oLSpJwTXI4/M1pqgn
         ap/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5CtstFfImaXDt7uV5dZoUlKnyGDNxUWsATJReSDmkleDdJ/1DAquyCb2mY7YOmnvh86+Te24GMClb3kdZyJYZsV76DKHR1TsP+b8pS19+Zo/NicOcPICmDyUAVUjHwX08aIBZwOGLb8qy+9bp6G2076rM6cSkhAjfXwPQnD3/uQ==
X-Gm-Message-State: AOJu0YwtqZzbD8tVZNgL3Lup+zs1xwSBtDNJLtTzqM1BjhvxmLHmlgXD
	XBWX3LeNtN3NjR6Pt3OHPGIP5Pomc00Ec4xj7ahCDmmsa7OLn6S9
X-Google-Smtp-Source: AGHT+IECKNlAjXtfcAK0zmXQoFMslDGFB+xQk5ohSw3tBFUqgfYx07tAWgxn0a3I0E9wCntSi6E+Og==
X-Received: by 2002:a05:6870:b28c:b0:260:fdda:5068 with SMTP id 586e51a60fabf-267d4cfe2a2mr14910412fac.4.1722385318809;
        Tue, 30 Jul 2024 17:21:58 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead816722sm8987381b3a.106.2024.07.30.17.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 17:21:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jul 2024 14:21:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH-cgroup v7] cgroup: Show # of subsystem CSSes in
 cgroup.stat
Message-ID: <ZqmDpLTm6tKhAmYv@slm.duckdns.org>
References: <20240715150034.2583772-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715150034.2583772-1-longman@redhat.com>

On Mon, Jul 15, 2024 at 11:00:34AM -0400, Waiman Long wrote:
> Cgroup subsystem state (CSS) is an abstraction in the cgroup layer to
> help manage different structures in various cgroup subsystems by being
> an embedded element inside a larger structure like cpuset or mem_cgroup.
> 
> The /proc/cgroups file shows the number of cgroups for each of the
> subsystems.  With cgroup v1, the number of CSSes is the same as the
> number of cgroups.  That is not the case anymore with cgroup v2. The
> /proc/cgroups file cannot show the actual number of CSSes for the
> subsystems that are bound to cgroup v2.
> 
> So if a v2 cgroup subsystem is leaking cgroups (usually memory cgroup),
> we can't tell by looking at /proc/cgroups which cgroup subsystems may
> be responsible.
> 
> As cgroup v2 had deprecated the use of /proc/cgroups, the hierarchical
> cgroup.stat file is now being extended to show the number of live and
> dying CSSes associated with all the non-inhibited cgroup subsystems that
> have been bound to cgroup v2. The number includes CSSes in the current
> cgroup as well as in all the descendants underneath it.  This will help
> us pinpoint which subsystems are responsible for the increasing number
> of dying (nr_dying_descendants) cgroups.
> 
> The CSSes dying counts are stored in the cgroup structure itself
> instead of inside the CSS as suggested by Johannes. This will allow
> us to accurately track dying counts of cgroup subsystems that have
> recently been disabled in a cgroup. It is now possible that a zero
> subsystem number is coupled with a non-zero dying subsystem number.
> 
> The cgroup-v2.rst file is updated to discuss this new behavior.
> 
> With this patch applied, a sample output from root cgroup.stat file
> was shown below.
...

Applied to cgroup/for-6.12.

Thanks.

-- 
tejun

