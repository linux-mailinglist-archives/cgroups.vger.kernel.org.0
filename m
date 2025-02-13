Return-Path: <cgroups+bounces-6550-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AEFA34D46
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 19:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E91A1887602
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 18:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E0424168B;
	Thu, 13 Feb 2025 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1hdXR3SS"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A83218F2FC;
	Thu, 13 Feb 2025 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470406; cv=none; b=OCfnWfvbiCxsfGWElnjJQs5F1nVRe5iZfwoS7d0Kpg1juyQx87ZaYZ9MMYh0C0TsYt7PyjAG4ZsV2fUJhyJ6wrpJQQVh3agkDDQmWr1e1AaChhYWJ5TTUca1bS3vFVL+MFEGC6/LHlH2Z91s0O82SVNaSja05T0MSjGtLr6gDmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470406; c=relaxed/simple;
	bh=KhQ5pIUvGHNGqvTWgKzFALgA+RVPd/dKhvRIXrwv1E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBznrpseFDn7nm7L36g1jhRdBgic2IVD6q1Qi7WwS3NS8ThdiXfyl4SmlWLrbi+KKeEJYVPU5E5F8QYmo7Q/V82Z8CvUEt3NrswAVdh/IfPh83lh2Nca974JgjxocIlgIkT1+kiyHq1ie9GovgsjXGWw9p1+C+fxRn67cL+TBbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1hdXR3SS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA2FC4CED1;
	Thu, 13 Feb 2025 18:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739470406;
	bh=KhQ5pIUvGHNGqvTWgKzFALgA+RVPd/dKhvRIXrwv1E8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1hdXR3SSe3t8L83nJTFyxWi/2606ekdBtj1k4qle83P5v2nPfyk/LN3CeXDocjhmv
	 r6UCfOXtt8wVHk1vlM6C4CViQfAA0xSz7jQI+FIDsv0/DmgxUlTODc3E7fbd1X0gDK
	 cCmMWRde94kEqplAn7ixDcQ884vIH1dvNanKvhBU=
Date: Thu, 13 Feb 2025 19:13:22 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tejun Heo <tj@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>, tglx@linutronix.de
Subject: Re: [PATCH v8 0/6] kernfs: Use RCU to access
 kernfs_node::{parent|name}.
Message-ID: <2025021343-ranking-applause-aa5f@gregkh>
References: <20250213145023.2820193-1-bigeasy@linutronix.de>
 <Z64e6gdsFL9i7Cl3@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z64e6gdsFL9i7Cl3@slm.duckdns.org>

On Thu, Feb 13, 2025 at 06:33:46AM -1000, Tejun Heo wrote:
> On Thu, Feb 13, 2025 at 03:50:17PM +0100, Sebastian Andrzej Siewior wrote:
> > This started as a bug report by Hillf Danton and aims to access
> > kernfs_node::{name|parent} with RCU to avoid the lock during
> > kernfs_path_from_node().
> > 
> > I've split the individual fixes in separate patches (#1 to #4). I've
> > also split the ::parent and ::name RCU conversation into a single patch
> > (#5 and #6).
> 
> Greg, the whole series looks good to me. Probably ready to iterate in tree
> even if there are more updates to make?

Give me a chance to catch up with my pending patch review queue, I've
been in CRA meetings lately and am way behind...

Don't worry, it's not lost.

thanks,

greg k-h

