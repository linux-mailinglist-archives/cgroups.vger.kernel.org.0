Return-Path: <cgroups+bounces-8401-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80912AC98A5
	for <lists+cgroups@lfdr.de>; Sat, 31 May 2025 02:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B724503B5B
	for <lists+cgroups@lfdr.de>; Sat, 31 May 2025 00:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C7E320B;
	Sat, 31 May 2025 00:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCmZhmzr"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26C1846F
	for <cgroups@vger.kernel.org>; Sat, 31 May 2025 00:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748651941; cv=none; b=SW079btSUqNb4UYAidXuIlzIWePvu8LkL6kXQuP3XlL6cUIDX92QkFK++67XB/L52dPdBHiWd+WrxxR+dGd6rrC6QpLyoqb14cSHLAAK1BMkyfUOA5HZI6PGY716wkglNTNZGaJ0mrUCtngNGRw97R1crl289gGbwOL+7LeKAdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748651941; c=relaxed/simple;
	bh=Q9PLx6uigXhGtzoA5kZnfTd0GvA+/ynEF+LALfL+zSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pL4Xtj4xdBeVYgqeX9hszny5SPpZqBjM574MNdYKuVrC+LKeYRAhXxQMirrqMDNT5Tz0pUx9qbBMR6q2FqBrDvehtEL6K+4aisFxXh9Mh25jG4DM31KMAQ5AZboIkeqJyambNtHY562mWzGiX00+M5H5ZmyqPCc4SzEw5O+X7s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCmZhmzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B67FC4CEE9;
	Sat, 31 May 2025 00:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748651941;
	bh=Q9PLx6uigXhGtzoA5kZnfTd0GvA+/ynEF+LALfL+zSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eCmZhmzrRUqyM9Xzv2jsY1qdS2z/d5WL+b2gHEwSgV6wfyyuMbrDRaAAqXSipO2OD
	 GdtenOkvQ3+NHf8dXaszui9yt8lN7fjG9D/mZqpUNtGfZZoPWvzb/44FCS96BxZWLx
	 Ed1r6KH9rg5Rg4Ny3aVkfvClBAegzB/mo7xqN3lcbNmWpzg00/chtl6I7KcJL+v+ky
	 ALkcAOLB33qhIJDxeUjbAHxu39svblgGDBySHMklxqCekc7EUAsmnLKulDdivwRS34
	 q/txof0jo+53oeYXyYd6jUmXDr2NJGXA6R7vzZ4kGQs9vgbh+cF+ZOVSUDF0sdlMBG
	 IyhCdivcNnnNQ==
Date: Fri, 30 May 2025 14:39:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: JP Kobryn <inwardvessel@gmail.com>, llong@redhat.com,
	klarasmodin@gmail.com, shakeel.butt@linux.dev,
	yosryahmed@google.com, hannes@cmpxchg.org,
	akpm@linux-foundation.org, cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH linus/master] cgroup: adjust criteria for rstat subsystem
 cpu lock access
Message-ID: <aDpPpE6WHY4GplkT@slm.duckdns.org>
References: <20250528235130.200966-1-inwardvessel@gmail.com>
 <eqodyyacsde3gv7mbi2q4iik6jeg5rdrix26ztj3ihqqr7gqk4@eefifftc7cld>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eqodyyacsde3gv7mbi2q4iik6jeg5rdrix26ztj3ihqqr7gqk4@eefifftc7cld>

Hello,

On Fri, May 30, 2025 at 11:58:05AM +0200, Michal Koutný wrote:
>   		ss->rstat_ss_cpu_lock = alloc_percpu(raw_spinlock_t);
> should work transparently on !CONFIG_SMP (return NULL or some special
> value) and the locking functions would be specialized for this value
> properly !CONFIG_SMP (no-ops as you write).

alloc_percpu() triggers warn when called with zero size, so we at least need
something guarding that. I applied as-is for now but further cleanups are
welcome.

Thanks.

-- 
tejun

