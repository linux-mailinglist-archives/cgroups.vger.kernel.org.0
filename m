Return-Path: <cgroups+bounces-3909-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7358193CEFC
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 09:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6E41F21CE1
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 07:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964B217622D;
	Fri, 26 Jul 2024 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="q7MC09p+"
X-Original-To: cgroups@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC0537E;
	Fri, 26 Jul 2024 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721980088; cv=none; b=QkWXg1dTku4bg3j/iDJzWCAMhpRbJfATXKrY3cwfGca+EMz8jVFDB9SISH8q1TmNxDw68lO4QGuVYoGOcgX5+d7QgrppTf1l6Z7NImgoZjWC4LHC8vZZ6RJ590eNfRuc2GWg5CLd7vvxNq/sM0vWSyfgpmfnKwZz/d4e+iltHxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721980088; c=relaxed/simple;
	bh=Io3MLN8ABzJsoyXEYl+t1LrvCKwLqSGhMvFrPZPQFlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KF/kQ400Wczq17rl3drYdc+eS1sdPOzViGjJn4XtwzrZ/S8/qDQd5wRPmgDGGcNYbcIdA0fxrAcYwnkkqMMAqsgwk5r/1rbeg/ZghaSKb+L6FiUwm4YqfxxsQ1Fm4Qo3k1SkWstFwLnicg8W8rDzwNSWJkn6D7kDeIBDXDqr0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=q7MC09p+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KRXV+2D2YqZxeiX9oHriPbK3frTai+MmN2o6Yfvo09c=; b=q7MC09p+VaEj2zsnd5iAXq9+ax
	kUGlREHkHijCuN+7zRrUjZQOLf2Bd8bfUJc8TmgG1udPYqYlrbmXUftQa929gRis+iijRO86smKXZ
	QCplKj6pOGzica+BEBZpKhUZ4eVm8kAhAgc4U3555faGCllakJqMp1eLFDnlvXJGm8ZKaQWFbLq8Z
	BxnOKXF5OlJ1I9SjeRWAR2V3SEm35HkNeHwP74suNhhL/3zbeMqiuNBMEPWIw/JVjowsNUjI8e9jD
	OKd+ernEgJTflUdVe13Ebo2dKPQkec+tB2qp2mRIq4LgPQTxdz5vB21oWqPuubuW3UtsYS+NESx0e
	QNTGSxgw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXFgK-00000002AXG-0V3K;
	Fri, 26 Jul 2024 07:48:04 +0000
Date: Fri, 26 Jul 2024 08:48:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Michal Hocko <mhocko@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg_write_event_control(): fix a user-triggerable oops
Message-ID: <20240726074804.GE99483@ZenIV>
References: <20240726054357.GD99483@ZenIV>
 <ZqNLEc54NVP40Kpn@tiehlicka>
 <ZqNMfL6JmgHCJwBv@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqNMfL6JmgHCJwBv@tiehlicka>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jul 26, 2024 at 09:13:00AM +0200, Michal Hocko wrote:
> On Fri 26-07-24 09:06:59, Michal Hocko wrote:
> > On Fri 26-07-24 06:43:57, Al Viro wrote:
> > > We are *not* guaranteed that anything past the terminating NUL
> > > is mapped (let alone initialized with anything sane).
> > >     
> > 
> > Fixes: 0dea116876ee ("cgroup: implement eventfd-based generic API for notifications")
> > 
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Btw. this should be
> Cc: stable

Point, except that for -stable it needs to be applied to mm/memcontrol.c
instead...

