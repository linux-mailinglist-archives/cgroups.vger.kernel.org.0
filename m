Return-Path: <cgroups+bounces-6342-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A118DA1DBC3
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 19:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC0B162EF5
	for <lists+cgroups@lfdr.de>; Mon, 27 Jan 2025 18:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202AA18A6D5;
	Mon, 27 Jan 2025 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAZ8clxr"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC61915ADA6;
	Mon, 27 Jan 2025 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738000855; cv=none; b=SIkoLPGpSfxJoDcH+JPZVoWScka2yTJFHbJ1uTxyKUKtioCRcDztf/MQeIul5QH69I66gZBr2IATt5Ddd0Um5v8QX99UyMKg3LwLAmoWMvP0JpWHqaX1QZWNRrcRuPX0R5ez1kVEW/31klgMii9bztcJmcLs8wpLXCQ0DLY2+dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738000855; c=relaxed/simple;
	bh=f9JYfVbdRnSaACTPiQhHrcEA77S8UEXNNyjQ+bmNyVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDUwKB1Kf0/sdCHdKnUiT1yxl26Uk7UiP5z8kBSEzagl8S6x7PHy9OSrwdlSCfvipGboo+p6IgQtpVbnjwxwcdGwOF8z4zKSN58YDgALJZFVLSwa8OntGB3MPJrRAyDwmWcYeXdcjKDBHLxCMyE6ir4CqAT3tFulvX+K5qOXF2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAZ8clxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56499C4CED2;
	Mon, 27 Jan 2025 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738000855;
	bh=f9JYfVbdRnSaACTPiQhHrcEA77S8UEXNNyjQ+bmNyVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TAZ8clxrp8C4dBKOT/gFGhP8BEfc5BQH6k4amFDPLP5S00Wlb4mtlkwtAu35BZ5sC
	 EfMMXpLiSM5DTlZ6QEzKmWyXA3m5czjit1Js+rigbvrZSmslV3j3MJn7EajIBF5WeH
	 zQjzg2IG8aWjId0qq0oedioSWIkhsqVJRdULDC/uhEUYYHwo7zAV1/fYK8jX7qxvKg
	 kowcvN5o815C48+N+pF1N+xuppl4y8fGUc0ysp+l0EhWpQX3zDmVrbNEYWKSC5F47E
	 NtYaFE0OKVVN3HIm95H48oMvPOeqMR18d6bCmdUolngKa3H/wZXe+7sGcTWKVsPFUd
	 liAOxonhlD/dA==
Date: Mon, 27 Jan 2025 08:00:54 -1000
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
Subject: Re: [PATCH v4 5/6] kernfs: Use RCU to access kernfs_node::parent.
Message-ID: <Z5fJ1m9ve8edEH1F@slm.duckdns.org>
References: <20250124174614.866884-1-bigeasy@linutronix.de>
 <20250124174614.866884-6-bigeasy@linutronix.de>
 <Z5Qjq73QhbaJyTjV@slm.duckdns.org>
 <20250127162543.Vr347xPN@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127162543.Vr347xPN@linutronix.de>

Hello,

On Mon, Jan 27, 2025 at 05:25:43PM +0100, Sebastian Andrzej Siewior wrote:
> > > -	return strscpy(buf, kn->parent ? kn->name : "/", buflen);
> > > +	return strscpy(buf, rcu_access_pointer(kn->__parent) ? kn->name : "/", buflen);
> > 
> > rcu_access_pointer() is for when only the pointer value is used without
> > dereferencing it. Here, the poiner is being dereferenced.
> 
> Is it? It checks if the pointer NULL and if so "/" is used otherwise
> "kn->name". The __parent pointer itself is not dereferenced. 

Ah, ignore me. I was misreading.

> > > +static inline struct kernfs_node *kernfs_parent(const struct kernfs_node *kn)
> > > +{
> > > +	return rcu_dereference_check(kn->__parent, kernfs_root_is_locked(kn));
> > > +}
> > 
> > AFAICS, all rules can be put into this helper, no?
> 
> This would work. kernfs_parent() is the "general purpose" access. It is
> used in most places (the kernfs_rename_ns() usage is moved to
> kernfs_parent() in the following patch, ended here open coded during the
> split, fixed now).
> 
> The "!atomic_read(&kn->count)" rule is a special case used only in
> kernfs_put() after the counter went to 0 and should not be used (used as
> in be valid) anywhere else. This is special because is going away and
> __parent can not be renamed/ replaced at this point. One user in total.
> 
> The "lockdep_is_held(&kernfs_rename_lock)" rule is only used in
> kernfs_get_parent(). One user in total.
> 
> Adding these two cases to kernfs_parent() will bloat the code a
> little in the debug case (where the check is expanded). Also it will
> require to make kernfs_rename_lock global so it be accessed outside of
> dir.c.
> All in all I don't think it is worth it. If you however prefer it that
> way, I sure can update it.

Hmm... maybe other people have different preferences here but I much prefer
documenting and enforcing RCU deref rules in a single place. It only adds
debug annotations that go away in prod builds while clarifying subtleties.
The trade-off seems pretty one-sided to me.

Thanks.

-- 
tejun

