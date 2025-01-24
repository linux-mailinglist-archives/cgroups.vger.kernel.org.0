Return-Path: <cgroups+bounces-6285-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E504A1BEE9
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 00:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476261696A8
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 23:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FAD1E3DE3;
	Fri, 24 Jan 2025 23:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH8QkCDV"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713961CEE9A;
	Fri, 24 Jan 2025 23:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737760279; cv=none; b=CzbCroBa13mSRhJL7rBI5aT/XKiHLuElIhkrZOzM9wmgyvCkraa+biYvIzxOqx1rXPH5TN+wrnupgtDxHfQVuoqkEbeap8g1u4XznyDX6lfmEvuEGC5G7yKEdWYYF1V2TLGUwYXbrIWt6kOfBRqOdp83bN44FfRXsh6g+EzZS04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737760279; c=relaxed/simple;
	bh=nv0vI486cv73MfG5K9pqVv8EUxQxxcsfkiBiqZpnuIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYntkG2yTobSzRpsmSeVnZKlO2nxOvWWlr2gMQ1xyIfrb7kY1CzyQvRU80WMJfdzcJYnApTlTvZvpz/qf72fSyK5XXHzn9oSDjIBIxTr63/YxyfYoEaLHyjnVWyQCvMLykEQmZoyCzGW7vzV/YXZXSkvCSUXEPs0A9/yHdcdwvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HH8QkCDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DF4C4CED2;
	Fri, 24 Jan 2025 23:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737760279;
	bh=nv0vI486cv73MfG5K9pqVv8EUxQxxcsfkiBiqZpnuIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HH8QkCDVWmyyqkHlXFOxuVMU2rOyTfx+Pk+V4AI0PFTljDHluDFWz+ClJmoxMIpK0
	 balgeB3Bv+3GrFGLWOl5kuqddfRMN+Jmak3shzsQKitxdJolJfFOUFqxZ+tQMEvdua
	 /NY/2tidF6zsmawPwZWiu573iMMej2q8SphpAg09jPS5MByHiT92At2g25dFdm9+E6
	 /IIdzJGSRRr9AOhDDRaAkm49+gbYDNYZuqv2WrfRCMcmCfnueKP4EuYZ/8ZyXaTFrI
	 DCAnvoxMnijY7dj1RhYkvSLZttznK6+PaIeU09Jn14INpwBUk1ithhwCOZITXXKs1Z
	 BzYT4w3F8FPaQ==
Date: Fri, 24 Jan 2025 13:11:18 -1000
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
Subject: Re: [PATCH v4 2/6] kernfs: Acquire kernfs_rwsem in
 kernfs_get_parent_dentry().
Message-ID: <Z5QeFgyBrxKxE-sg@slm.duckdns.org>
References: <20250124174614.866884-1-bigeasy@linutronix.de>
 <20250124174614.866884-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124174614.866884-3-bigeasy@linutronix.de>

On Fri, Jan 24, 2025 at 06:46:10PM +0100, Sebastian Andrzej Siewior wrote:
> kernfs_get_parent_dentry() passes kernfs_node::parent to
> kernfs_get_inode().
> 
> Acquire kernfs_root::kernfs_rwsem to ensure kernfs_node::parent isn't
> replaced during the operation.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This looks fine but wouldn't it be better to use kernfs_rename_lock instead?

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun

