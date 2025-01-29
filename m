Return-Path: <cgroups+bounces-6379-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 601CDA22521
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2025 21:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C10F3A30C4
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2025 20:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075461E2847;
	Wed, 29 Jan 2025 20:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBiSdO5t"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4334199EBB;
	Wed, 29 Jan 2025 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738182545; cv=none; b=BpsRXQSoBKFuna/MjxNYYD6Mu0XKPCh9+FzNJ4NgdGqL2x9UHxK8G64uwACYUyOIqekrByKP2zTy+aFpcGyCcZNHPU31TnvzdcmAhZFJYonQ7965wtZjcQbXxKJdVDlgASfgzTpPzv2xeNtwfM05qN7FqiSl0iMtl6wcMkDRVKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738182545; c=relaxed/simple;
	bh=7c0BhK33Y8biHBtDAej3fXyQRvPWekaU6HWTBIgNjSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRl/ubmdk7Ne5gxJXbMo9RgdQwUjFvKX4pilpVc+68RmqBdxih8W93IsIRdYjcvu4byMdTpcbkDI+LVJf7IARw18/zPZM2NwWtxRqn4ZkM5nqGitkUbwjnZLMGI96iMWCVTQ7+4t59xwMIlXRFm9e167pHZ6vvgokMivOuQe6yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBiSdO5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2637C4CED1;
	Wed, 29 Jan 2025 20:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738182545;
	bh=7c0BhK33Y8biHBtDAej3fXyQRvPWekaU6HWTBIgNjSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QBiSdO5tLLfaCjdxu1nBodq1W2b+feTFKpJECfu8xiNakdNTCnmR4F6OBfGYtQ44c
	 qd8QPRho9s45dSiSldT7HtuLZIP4pMBIWy8GKIkxSu0tkr4wKxfc3N3DotH0vLnHHr
	 kf3oAH7oseWs3l1gRqKWCYPGd6GqHpOxhAjwI8EUKBqKOr4JH1f0ulOPM8U8SlVyRw
	 OJB+xDtwuBCSI72Qg3aiVXmTwvB6TJX5l52UJOW80thGB73EcQIFD2yZXtdrjGpXy4
	 3XqJNlimblzKbfIY2519pE7pozCJN68AhtBIEHvhD3LkVpsro1ZRfZmTQ9lJtiPjpI
	 z2yNW/fZlXd8Q==
Date: Wed, 29 Jan 2025 10:29:03 -1000
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
Subject: Re: [PATCH v5 5/6] kernfs: Use RCU to access kernfs_node::parent.
Message-ID: <Z5qPj1P6ymCbvJSK@slm.duckdns.org>
References: <20250128084226.1499291-1-bigeasy@linutronix.de>
 <20250128084226.1499291-6-bigeasy@linutronix.de>
 <Z5k-sxSKT7G2KF_Q@slm.duckdns.org>
 <20250129132311.rQM6LtB2@linutronix.de>
 <Z5pdSZ6akuLnfGMI@slm.duckdns.org>
 <20250129202614.eK7sf6Jt@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129202614.eK7sf6Jt@linutronix.de>

On Wed, Jan 29, 2025 at 09:26:14PM +0100, Sebastian Andrzej Siewior wrote:
...
> > Hmm... I would have gone with using the same accessor everywhere but am not
> > sure how strongly I feel about it. I don't think it's useful to worry about
> > the overhead of the extra lockdep annotations in debug builds. Ignoring that
> > and just considering code readability, what would you do?
> 
> It is your call. I would prefer to open code that part that we do only
> rely on RCU here but sure understand that you don't care about the
> details and want to have only one accessor.

It's kinda nitpicky. Let's just keep what you did.

Thanks.

-- 
tejun

