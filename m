Return-Path: <cgroups+bounces-5544-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE7C9C7B34
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 19:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7559B1F28296
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 18:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590AA215035;
	Wed, 13 Nov 2024 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ur1FBx9p"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E332144BA;
	Wed, 13 Nov 2024 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731522484; cv=none; b=IjtUblJLMrwNlziTk2agNi+ovim5n5I0E9wNIvDPHtLmGkCzlzN7EtyAJIL7Q81JqpSzYF+xHMTxkCC1k/gNI67cIj4B41yzwrBOX6yiwJUv3iqxjzh421N9VlrBpXpZuntFFCxngzEhV78LghpzSdPoGkJGnnhR/NzsLhrDtzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731522484; c=relaxed/simple;
	bh=UrcLbEfaW4xoJUMdEqFk+yWLavjER+djSJ8hu7z9JAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmRiU/ohk0CjjMwQMn+/MqhE9k+TpnyYq3R1/btvrPd9c+CWc+PZcqUgwH66vNixnMTcLRHjxUxRnPg2IxMiBSuvSP9aojrhlvGqbPiwIxxvCCspYS/oal8DUk3NT1OddcjQKYQfDqzzZUvLQV7p00ejMGR48Pv9Krix9cISW2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ur1FBx9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729CCC4CECF;
	Wed, 13 Nov 2024 18:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731522483;
	bh=UrcLbEfaW4xoJUMdEqFk+yWLavjER+djSJ8hu7z9JAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ur1FBx9pzpeRH88qFg8vZoi6rG6171PkOJfKa5GzYe1qKkQE4CGP+NhtcJUIGQrRZ
	 /wpjsXfMnpzlP3uF8nPJHy3clTB/M8R0+kWoEOuSBy4dEMMg8DnhCoxWp57jZUuDiY
	 GGfYIJk89CbSrvm5tajTjro2uUApn1S6+WT8SrBeAjKQZRaiJJedKG2AvST7qZAHAZ
	 CLMxUDoIx9eXZLDH8wtUx03SDC9/dBcYQNWrVPmlm/YYSvfpUJ7mvmVtmtUALNGN4G
	 d8jT/vUsR9PH+Li/DYmblx7sY2dseksAWC/X5g6+YILaTJhhxlpSyEszk4eFOwhHv2
	 vU08bqIMaVC/w==
Date: Wed, 13 Nov 2024 08:28:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>, tglx@linutronix.de,
	syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 2/2] cgroup, kernfs: Move cgroup to the RCU interface
 for name lookups
Message-ID: <ZzTvsueQ_THOT6EW@slm.duckdns.org>
References: <20241112155713.269214-1-bigeasy@linutronix.de>
 <20241112155713.269214-3-bigeasy@linutronix.de>
 <ZzOlhANLYxFaIix2@slm.duckdns.org>
 <20241113074331.B48iqBgp@linutronix.de>
 <20241113120706.rotCvUqt@linutronix.de>
 <20241113132333.ayhH2ZH-@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113132333.ayhH2ZH-@linutronix.de>

Hello,

On Wed, Nov 13, 2024 at 02:23:33PM +0100, Sebastian Andrzej Siewior wrote:
...
> > That is the easy part. kernfs_path_from_node() is different as it
> > requires the parent pointer. In order to distinguish the RCU from the
> > non-RCU version I need kernfs_root for the flag and depending on it, the
> > lock so the parent does not go away.
> > 
> > Would it work to add the pointer to kernfs_root into kernfs_node? This
> > would shrink kernfs_elem_dir by a pointer but the union would remain the
> > same size due to kernfs_elem_attr so the struct would grow.
> 
> The kernfs_node is released via RCU. That means if the RCU read section
> starts before kernfs_root() then we should always get a stable pointer,
> pointing to the same kernfs_root node since it is always the same one.
> Even if the `parent' pointer is replaced. Wouldn't we need __rcu
> annotation then for the `parent' pointer then?

Yeah, I think this is the better direction. Just make both the parent and
name RCU protected, drop the rename rwlock and use RCU deref for both
->parent and ->name so that the code path doesn't have to diverge.

Thanks.

-- 
tejun

