Return-Path: <cgroups+bounces-12780-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EC9CE02E2
	for <lists+cgroups@lfdr.de>; Sat, 27 Dec 2025 23:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A68C30087BC
	for <lists+cgroups@lfdr.de>; Sat, 27 Dec 2025 22:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACEF221FBD;
	Sat, 27 Dec 2025 22:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQ6uKXz8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042183A1E7E;
	Sat, 27 Dec 2025 22:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766875919; cv=none; b=hvM+n2TLsKR9CGvJYH1eQReMl9KUAm6wmr2RftFmghhRdGgNwDy74QqUSCoISGJ7BARzUmODavQ8vGF62TVdDHGlAHk4pUb2v7u4C844/PODYQ3RVhiJtcqTcQUPH5AuXiRVmV+bVkmV4ceZgrPuU5CZni3j33UhTJs2wLjRmhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766875919; c=relaxed/simple;
	bh=EMYRB+PjNg/uZeUCzx+ySaY14xwN69l12wO2VZsHNtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moNo755C+N6Dki1buaeJg8zIx70M/WJFQoMsEHpIHoSzeYUba+yqCR5sxL4g0FN54ueOMrbFVcRh5X4daOgTNw4HcBIBhqPqYcJwVEUed2ETHMCxchMGrHb6a2FliNameFNp5cPe3csYNp5U8OzAmxpYsyBfhWgMmID2xdvzTxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQ6uKXz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FEBC4CEF1;
	Sat, 27 Dec 2025 22:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766875918;
	bh=EMYRB+PjNg/uZeUCzx+ySaY14xwN69l12wO2VZsHNtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PQ6uKXz8GT1DM7zOV/K6+6GZ/fu57ZHQJVCFd44VZ1G+BRyvE3dsnbKCo3AAiQHSh
	 cICAn9VcAkRSrRGBXtZmmdTJJ0CoIYazbwkmR0gBMtTZrBO93W2Gs1VFkzmzutOA1l
	 EGa8IY6JapxvfF/4w8C5eWky7rNavYK6Pgt/IsJY7wzJ8hEM+EG2GRJQ0oMPgZTNRH
	 /miuqBPs0ZywdYTOhZHHGuAlsxR2lJgIPC6hXWMFYIB0//FAQ0pd/goZBUhs/40JDf
	 MGnBAJIJF8SC4FVyiVfxIWv9jXzrjV63+GYdLdfrTRLyoxfNBcoaDaaLpFvqhPGhRs
	 X5Dj4quim1/aA==
Date: Sat, 27 Dec 2025 12:51:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cgroup-v2/freezer: Print information about
 unfreezable process
Message-ID: <aVBjDYPQcKEesoKu@slm.duckdns.org>
References: <20251223102124.738818-1-ptikhomirov@virtuozzo.com>
 <20251223102124.738818-4-ptikhomirov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223102124.738818-4-ptikhomirov@virtuozzo.com>

Hello,

On Tue, Dec 23, 2025 at 06:20:09PM +0800, Pavel Tikhomirov wrote:
> +static void warn_freeze_timeout(struct cgroup *cgrp, int timeout)
> +{
> +	char *buf __free(kfree) = NULL;
> +	struct cgroup_subsys_state *css;
> +
> +	guard(rcu)();
> +	css_for_each_descendant_post(css, &cgrp->self) {
> +		struct task_struct *task;
> +		struct css_task_iter it;
> +
> +		css_task_iter_start(css, 0, &it);
> +		while ((task = css_task_iter_next(&it))) {
> +			if (task->flags & PF_KTHREAD)
> +				continue;
> +			if (task->frozen)
> +				continue;
> +
> +			warn_freeze_timeout_task(cgrp, timeout, task);
> +			css_task_iter_end(&it);
> +			return;
> +		}
> +		css_task_iter_end(&it);
> +	}
> +
> +	buf = kmalloc(PATH_MAX, GFP_KERNEL);
> +	if (!buf)
> +		return;
> +
> +	if (cgroup_path(cgrp, buf, PATH_MAX) < 0)
> +		return;
> +
> +	pr_warn("Freeze of %s took %ld sec, but no unfreezable process detected.\n",
> +		buf, timeout / USEC_PER_SEC);
> +}

This is only suitable for debugging, and, for that, this can be done from
userspace by walking the tasks and check /proc/PID/wchan. Should be
do_freezer_trap for everything frozen. If something is not, read and dump
its /proc/PID/stack. Wouldn't that work?

Thanks.

-- 
tejun

