Return-Path: <cgroups+bounces-3384-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 455B79199B2
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2024 23:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16561F2401B
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2024 21:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43060193064;
	Wed, 26 Jun 2024 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiiMia5y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B9C18FDBC;
	Wed, 26 Jun 2024 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719436820; cv=none; b=XWPhiCFhWD4LowcQo7C3vXfY261b1XpPFIVHyUBr1fJfpXyh7naHSdCylIEOhnMyGuqfA1jsc5M5lBLVVSvuF7T9zVFCEyo0XpJPicwmoPgodC/5tADNDz1JvOd2I5mEa9Q+hurBqNfK5HFzqgBrUku0HF/+rDYhR5fdeZ7TxHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719436820; c=relaxed/simple;
	bh=UgdIGly+w0XtEuogACzmAyDBbBjW4St/b1Z4mohsyNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZDh5LTKnqIzsqxl0Ij00vzK3392Z7LiTY26JBOqCPwRfKbV3bjvPdtgQ9YJFkLPCUxDVTfoDOVEyOy8Si/iyyRIsbE3tFWsoSqK02M17/XpabD5zQHkQp6/avIIy6loPRcbIEslrn6SzxnlWJHx1gSjLkZ5XC2eZzFdxAh+Cgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiiMia5y; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f47f07acd3so58894345ad.0;
        Wed, 26 Jun 2024 14:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719436818; x=1720041618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phBOKqnUAkG5Cz/ZpFPdNat11AMKmpKoxQu9PcVKyz4=;
        b=YiiMia5yKzLzWx7DzlTwCM3uYV3HUyR0Ab4dYRAFy2nvoQBWnnyFwFz5QBXxFgscEA
         M4wMQKLBRZw7bunDTRhP4C2r2Lfg+4aAHsLOTKUl57ExagmAHCX9RHlh4oIMYSAw/QVs
         GWAddCID8YvL0FQiD0+gxyUkLNJ0ll1OZ22BiE1xRBrlMMyFZC4X9Cun7E/BLS9pTeoc
         svUj3R2gLs6lxp7/7YYGVf3AyOSZIbgZkSUbahGIHfqIuC1AMHwPtFZYmf7oqCue8VoH
         O5rJmjd5mMqU1PzVyGCU8gmy1hid1xtr+mptch/1OcW9EP8XKhbX6Cf2ghLM91BAMbgn
         vsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719436818; x=1720041618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phBOKqnUAkG5Cz/ZpFPdNat11AMKmpKoxQu9PcVKyz4=;
        b=dwOWJcboohY6rI4pWuewIzNJhLRg/3RWLRYU52/EZi4pWrQ3n0+HSI8gX5DqHVM2R9
         AfaKKDoLFVTCMryAf54Pfxs97btfEm6NTu0ckxh9MsL2cVK0JVw3DVasKI0E7spxSLpl
         OneFViJ8jt54IEgf3FEwwIFC8E8o07Mpx0WZlo26xrz35XuwhFOZdqqMghEY2HbjV81L
         HxI4j/s7yJHUu4X7Re89/iPhKrUBsF19rJhQdhQWGyu7uo0WrBC6E9wnXn0umFbr+4b1
         DFZr3ACt6CaYV0p4OPyLfrbRm7quk2arVcVuYDSg+5hYmNC/xxKE3685rs4TnnuWJ2OW
         ZRew==
X-Forwarded-Encrypted: i=1; AJvYcCWFuXly6tRX31hF8DDRpziRLRjg5i5yFlVTXYMSeNr1EWatxwO9bXg7ctNX/PVs4YZgjAx+ovzzMJ7NYdMqUjZslq01h1BZDVjLIdk0QZt5sb0UZVg9c11jUy2JX59sXqRB2dxlPw==
X-Gm-Message-State: AOJu0YzbmTR7t1u1od1EsStDXGdc5QXXm4jDL26CwjDx/SNQV5Bb3eJm
	pYLaCXspc8u9iyt3l2Ab2FCBUfwub7kT2ofOvc34P6x96Dv50QI0
X-Google-Smtp-Source: AGHT+IEqmyQjqn/dxmEW3QbnTrntFaLv58Ujhnh15mlGAYgKkGJy+dYcTlC2stmOfoXC9CBRrKcDZA==
X-Received: by 2002:a17:902:d50b:b0:1f9:e7b4:5def with SMTP id d9443c01a7336-1fa1d3e0157mr142311595ad.3.1719436817688;
        Wed, 26 Jun 2024 14:20:17 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebab6fffsm104443785ad.243.2024.06.26.14.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 14:20:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 26 Jun 2024 11:20:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huawei.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
	adityakali@google.com, sergeh@kernel.org, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] cgroup/cpuset: Prevent UAF in proc_cpuset_show()
Message-ID: <ZnyGD2D8riTOix-a@slm.duckdns.org>
References: <20240626094101.472912-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626094101.472912-1-chenridong@huawei.com>

On Wed, Jun 26, 2024 at 09:41:01AM +0000, Chen Ridong wrote:
> An UAF can happen when /proc/cpuset is read as reported in [1].
> 
> This can be reproduced by the following methods:
> 1.add an mdelay(1000) before acquiring the cgroup_lock In the
>  cgroup_path_ns function.
> 2.$cat /proc/<pid>/cpuset   repeatly.
> 3.$mount -t cgroup -o cpuset cpuset /sys/fs/cgroup/cpuset/
> $umount /sys/fs/cgroup/cpuset/   repeatly.
> 
> The race that cause this bug can be shown as below:
> 
> (umount)		|	(cat /proc/<pid>/cpuset)
> css_release		|	proc_cpuset_show
> css_release_work_fn	|	css = task_get_css(tsk, cpuset_cgrp_id);
> css_free_rwork_fn	|	cgroup_path_ns(css->cgroup, ...);
> cgroup_destroy_root	|	mutex_lock(&cgroup_mutex);
> rebind_subsystems	|
> cgroup_free_root 	|
> 			|	// cgrp was freed, UAF
> 			|	cgroup_path_ns_locked(cgrp,..);
> 
> When the cpuset is initialized, the root node top_cpuset.css.cgrp
> will point to &cgrp_dfl_root.cgrp. In cgroup v1, the mount operation will
> allocate cgroup_root, and top_cpuset.css.cgrp will point to the allocated
> &cgroup_root.cgrp. When the umount operation is executed,
> top_cpuset.css.cgrp will be rebound to &cgrp_dfl_root.cgrp.
> 
> The problem is that when rebinding to cgrp_dfl_root, there are cases
> where the cgroup_root allocated by setting up the root for cgroup v1
> is cached. This could lead to a Use-After-Free (UAF) if it is
> subsequently freed. The descendant cgroups of cgroup v1 can only be
> freed after the css is released. However, the css of the root will never
> be released, yet the cgroup_root should be freed when it is unmounted.
> This means that obtaining a reference to the css of the root does
> not guarantee that css.cgrp->root will not be freed.
> 
> Fix this problem by using rcu_read_lock in proc_cpuset_show().
> As cgroup root_list is already RCU-safe, css->cgroup is safe.
> This is similar to commit 9067d90006df ("cgroup: Eliminate the
> need for cgroup_mutex in proc_cgroup_show()")
> 
> [1] https://syzkaller.appspot.com/bug?extid=9b1ff7be974a403aa4cd
> 
> Fixes: a79a908fd2b0 ("cgroup: introduce cgroup namespaces")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Applied to cgroup/for-6.10-fixes w/ stable cc added.

Thanks.

-- 
tejun

