Return-Path: <cgroups+bounces-6287-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B094A1BEF2
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 00:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28BF3A1D7C
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 23:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550B01DB361;
	Fri, 24 Jan 2025 23:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+YMbEdv"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1143E1607B4;
	Fri, 24 Jan 2025 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737760534; cv=none; b=aLokQCWy40bojdSrCp9L1X8YvNGMUUuLDJAQZn44/eWpX+ffT5RXJx14ru5QmbYts7dfDTXsg+zeHtrrlcvVpaO34uieEaQ5u0BNyvZ2227OrnZxJw4A0JfNOA2y/ByUFB+cSmT1e7FVnAxz2DoztpuBUyz7o4Q85o2+OeScV+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737760534; c=relaxed/simple;
	bh=WhGADjkrbCEjiSFeTveagOuG8tWA8lDXdBSKLQpAjlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBeWod1xghau87Gc9WTM5duWoEL8QJhXQbZlbg76y5CEY3saP+pKBVGob8V50wxRgLe3Bf0iuMveK+eDSgfdZEfq/aHQT0TQKuyq25A04XXC+ENnHgBsphBCFPlKAQh+sv7/4CIeeBhhF0qABUAP9UqwZRV4heSh0mR9phhBwrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+YMbEdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C99DC4CED2;
	Fri, 24 Jan 2025 23:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737760533;
	bh=WhGADjkrbCEjiSFeTveagOuG8tWA8lDXdBSKLQpAjlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+YMbEdvwOcWXpIwRTi1BZVtLp+9EtQJ+LQjum81Spiv03uYFa+YQOx9Z90Zm0Gga
	 OcKiub03InXb7EDb15vU0Gu5pGt/VLAMuS16W8wUfL4MoQywtmSq///xs8+fM2QnNn
	 DSgWkdBvlFETDIF4em8dY01d6NEKyvA3NRlgt9uKyPuQglw/u3gvM426dUjJuB8xzD
	 6cU2g2IdmhUdcIuD422TxaSbU8enbEAnUP3AMs0QRsC9A9fXBNyoHmajybZYnW9txQ
	 z7713EL2FdUTgrLUw9b16+qCfFe3Jlso7Uq7sNrNJc07CXbTpUR3FJaHNvfYHQPGdh
	 Yi4Z/10hRjZVA==
Date: Fri, 24 Jan 2025 13:15:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>, Zefan Li <lizefan.x@bytedance.com>,
	tglx@linutronix.de
Subject: Re: [PATCH v4 4/6] kernfs: Don't re-lock kernfs_root::kernfs_rwsem
 in kernfs_fop_readdir().
Message-ID: <Z5QfFLaywTAdmHoh@slm.duckdns.org>
References: <20250124174614.866884-1-bigeasy@linutronix.de>
 <20250124174614.866884-5-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124174614.866884-5-bigeasy@linutronix.de>

Hello,

On Fri, Jan 24, 2025 at 06:46:12PM +0100, Sebastian Andrzej Siewior wrote:
...
> to avoid holding a global lock during a page fault. The lock drop is
> wrong since the support of renames and not a big burden since the lock
> is no longer global.

It's still a pretty big lock. Hopefully, at least name accesses can be
converted to rcu protected ones later?

> Don't re-acquire kernfs_root::kernfs_rwsem while copying the name to the
> userpace buffer.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

