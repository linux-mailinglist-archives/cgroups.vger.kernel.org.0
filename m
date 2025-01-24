Return-Path: <cgroups+bounces-6289-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 202AFA1BF13
	for <lists+cgroups@lfdr.de>; Sat, 25 Jan 2025 00:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7226B1697A0
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 23:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E7F1EE7CF;
	Fri, 24 Jan 2025 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQaopvJq"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49EE1E3DE3;
	Fri, 24 Jan 2025 23:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762078; cv=none; b=rtlyPuHsZnLLtpLipACm1KwGUddJrDrAwSUQAZ1sxlPQ+iiKummX91Mdfp2x11e5fhI3pRdoWC5sB3n0cdHc3R0DqVBC73korGrFtkJFJjnBIq3zIDBgOxhblhTURJ6JThnU5RxedocdX1LgkoZTWayMGHDbNh3zDjrOYQOlI8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762078; c=relaxed/simple;
	bh=6rceZtujyCmy7GhYqAC5OMAdRD9CKglVVl7ZlEVyVuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=li7Cy4NnrK5liWXy77pMp0v2qtZtUXh7BSZJNgDJcN8CvC2oGNkIQgPlmpaJKs3Kl97rsj3f3tAFhfL2fd3ZKxXNJK6+I2o7OnBR3x12Neb9CimqPY8K4kMYxamjAOexxK6izyuvUM9I7+oGRGr3APnpdi/JuwGYcKUgbQU1uto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQaopvJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A791C4CED2;
	Fri, 24 Jan 2025 23:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737762078;
	bh=6rceZtujyCmy7GhYqAC5OMAdRD9CKglVVl7ZlEVyVuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQaopvJqwUZWLvapwlN06/LFhU7bpXYch0hNXT8xODD8mGGE9vec5hhLOw5RObJzg
	 hnlkHARYLlZJqyRJlLBHutMkEzzjIeFY31yTLa6ZMDliNENtVuMqm7yFKeTCFA/gBN
	 l/iybIvz5XfrhhDPPy/gYSxirk2KQJaF7aAxitydH+wtz6JiqgraWnemEqehg4+vRr
	 /TLy88sbcMPtXm2Jb6m4iffP8/N6JdsSn00qbUM3ZiM3JQmZ0bYEN0u70cAkM0tn5i
	 BYX+KRzyQHA1wKz/4g4EFca7Oqt1uy4hG3SrnT3f/zGpCZd8Mwe5E8VbdVHUZ9bBu2
	 Km4vwz5sQoWQw==
Date: Fri, 24 Jan 2025 13:41:17 -1000
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
	tglx@linutronix.de,
	syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 6/6] kernfs: Use RCU to access kernfs_node::name.
Message-ID: <Z5QlHcCErrALjWfG@slm.duckdns.org>
References: <20250124174614.866884-1-bigeasy@linutronix.de>
 <20250124174614.866884-7-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124174614.866884-7-bigeasy@linutronix.de>

Hello,

On Fri, Jan 24, 2025 at 06:46:14PM +0100, Sebastian Andrzej Siewior wrote:
> Using RCU lifetime rules to access kernfs_node::name can avoid the
> trouble kernfs_rename_lock in kernfs_name() and kernfs_path_from_node()
> if the fs was created with KERNFS_ROOT_INVARIANT_PARENT.

Maybe explain why we want to do this?

> +static inline const char *kernfs_rcu_get_name(const struct kernfs_node *kn)
> +{
> +	return rcu_dereference_check(kn->name, kernfs_root_is_locked(kn));
> +}

Can you drop "get" from the accessors? Other accessors don't have it and it
gets confusing with reference counting operations.

Thanks.

-- 
tejun

