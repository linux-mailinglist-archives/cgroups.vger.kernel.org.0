Return-Path: <cgroups+bounces-6401-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C791A233E2
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 19:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217C0163D8E
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 18:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A911F03C3;
	Thu, 30 Jan 2025 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3Uz7MHp"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C524D187346;
	Thu, 30 Jan 2025 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738262185; cv=none; b=V5elaUDVHQ0QpORDHEujVYrjj9sCJQYf4hAYc2Hm/uk3sTBIiGGK8p5IfvnFhaJPNun3sS7AXotPvoezNkMVArzTP0jtmzL/7EtnUhffdXqpnwUiTa66qgrbSpQAWGaTW6j1UlUempkXLvE83tu5vdAfOzX9/wIc43ZdDa4CYic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738262185; c=relaxed/simple;
	bh=0eZ7LZvDKD0s/Ct0/YjUWUvGQtk4v3YSBtDg2rsBqFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZE5dh+QFfcjjB9R5bhb4Opi/DGDcgVX8PxjgapF4503aBCs2t5BuUYxola4VRzYZh5mQS76eXhQQ1s8UM2FqseqRgqwJOVD7oj+I3LLZ4pliREEjIAEvvVVo0fnzMe7g48XLczsvUkh8/wJnysc/GHQLi7LMGDW7XT+Lxap323E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3Uz7MHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06964C4CED2;
	Thu, 30 Jan 2025 18:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738262185;
	bh=0eZ7LZvDKD0s/Ct0/YjUWUvGQtk4v3YSBtDg2rsBqFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3Uz7MHppz/qE0WxsYtSBUSe6ni8HNCQdC41vuK+iQawnDoGqke8LT/QUBzBL2xfC
	 CMlWfOZccN2ojhIJNNPEAoXUo0gy+oksW2aHD1WzADzACH6tQzy5n1JXB5aKY6EsWQ
	 8Hrk1FTULthRQC7uZ9gbOTQ55JdCZrSZfyPgZuPbDd+wyeByhq+vqBs0jjDtAlMlfb
	 kxj+KJtjgD+C2s4wSDKW7b5iy8FLDrHVoHvlr0IS07iLzIw+diUX4RRyGKMEuBaWTv
	 nowU7CuouJBHZEGZyBikvNCs1W9vKv9Zy5YRnCWjdI5xopXqefh3XdpQLcX9/F8uVT
	 ilz28SVAZiDwQ==
Date: Thu, 30 Jan 2025 08:36:24 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>, tglx@linutronix.de
Subject: Re: [PATCH v6 0/6] kernfs: Use RCU to access
 kernfs_node::{parent|name}.
Message-ID: <Z5vGqAxiaL_weoWU@slm.duckdns.org>
References: <20250130140207.1914339-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250130140207.1914339-1-bigeasy@linutronix.de>

On Thu, Jan 30, 2025 at 03:02:01PM +0100, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> This started as a bug report by Hillf Danton and aims to access
> kernfs_node::{name|parent} with RCU to avoid the lock during
> kernfs_path_from_node().
> 
> I've split the individual fixes in separate patches (#1 to #4). I've
> also split the ::parent and ::name RCU conversation into a single patch
> (#5 and #6).
> 
> v5…v6 https://lore.kernel.org/all/20250128084226.1499291-1-bigeasy@linutronix.de/
>   - s/rdt_kn_get_name/rdt_kn_name/
>   - s/rdt_get_kn_parent_priv/rdt_kn_parent_priv/
>   - s/kn_get_priv/kn_priv/
>   - The comment, that has been removed in kernfs_put(), is back.
>   - Using rcu_access_pointer() in kernfs_activate_one() and kernfs_dir_pos()
>     instead of kernfs_parent() where the pointer is not dereferenced but
>     just compared.
> 
> v4…v5 https://lore.kernel.org/all/20250124174614.866884-1-bigeasy@linutronix.de/
>   - rdtgroup:
>     - Add a comment to rdt_get_kn_parent_priv() regarding lifetime of
>       parent.
>     - Move individual rcu_dereference_check() invocations into
>       rdt_kn_parent() with a comment on lifetime.
>     - Use rcu_access_pointer() in kernfs_to_rdtgroup() instead
>       rcu_dereference_check(, true)
>   - s/kernfs_rcu_get_name/kernfs_rcu_name/
>   - Move all rcu_dereference_check() within kernfs into kernfs_parent()
>     and extend its checks to have all cases in one spot. Document why
>     each case makes sense.
>   - kernfs_notify_workfn(): Do unlocks in the reverse order of locks.
>   - Add kernfs_root_flags() and use it in cgroup's kn_get_priv() to
>     check the right KERNFS_ROOT_INVARIANT_PARENT flag.
> 
> v3: https://lore.kernel.org/all/20241121175250.EJbI7VMb@linutronix.de/
> v2: https://lore.kernel.org/all/20241112155713.269214-1-bigeasy@linutronix.de/
> v1: https://lore.kernel.org/all/20241108222406.n5azgO98@linutronix.de/

Whole series looks good to me.

Thanks.

-- 
tejun

