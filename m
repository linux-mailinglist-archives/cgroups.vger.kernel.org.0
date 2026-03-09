Return-Path: <cgroups+bounces-14718-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PnjIq36rmnZKgIAu9opvQ
	(envelope-from <cgroups+bounces-14718-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 09 Mar 2026 17:51:57 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0516523D1C4
	for <lists+cgroups@lfdr.de>; Mon, 09 Mar 2026 17:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC574305D48C
	for <lists+cgroups@lfdr.de>; Mon,  9 Mar 2026 16:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC762874FE;
	Mon,  9 Mar 2026 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="enOEeJHq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4042741B6
	for <cgroups@vger.kernel.org>; Mon,  9 Mar 2026 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074722; cv=none; b=A6hbSkPgeLDTD9i9ttZBWts4NlH0sHo8SqCr9nr+w5dkKIwN/QNQD1ApyRoJcQ6IJn3GKfBSoou1Wqh3askKe+05NxdyIi0Tjy/w3vDXsIvZCOn43Od29TBajOBUYmAaTW5WFxWddaEBx3Q+DbNtR9Wpq/5qiVD3KAXpA7vllA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074722; c=relaxed/simple;
	bh=icjWP1L+DoRJUOSBMBCHZ0UgNuHL2LRNvLvlEm6xUEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdrM2onPsWwLTbmR1T+a/HHlRVJwTD+rVBsYJOawQPWJ7UtjclTEDPethClQJoJ1E6Z8kUy8pfwi01A3bFF9paNd8BNCF4ST3I6hDO4LKd4mlFEqfkIkLH2NGGeU1cKWCwbWHiwTgEXtruv0WV/GxGfekGoh8jWm0LtZ9Zd/fik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=enOEeJHq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48534237460so18820035e9.3
        for <cgroups@vger.kernel.org>; Mon, 09 Mar 2026 09:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773074719; x=1773679519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C4TrHsDF1RGNreebKCbrcf0d+wkWEPrj32T2lm3DYKI=;
        b=enOEeJHqOmpmU3RKhKiCoChpyREgkwdH269FQxg/xsYwnZyNj4YIbsCYnFUWU2YMsL
         OIq4x2bm9ZI7BFN2pyb2FiGyh9XSEDjqKfaIeSqolc9l5HEXEqwWQpIMDLmedAyQmUPp
         pm1iPR/YJKM3Xt+PjfYhnTyrl7SzIOrJ4uGZ6DLrykBZaOaisCqGXlJga9ue8NsHUPHE
         bNALsT9XvKTAIbxE/nlASx2EkZe24u9mnyVmx4rCDYwSrtO4fAg7tPr5d/x23NuPeZLb
         LpEX/N2AktNJ2KNu8ARri0ePI6+n7yh4SjGILTZQHlgBT05SyJeU0ZGwJZcR6mY0EcNh
         bagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773074719; x=1773679519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4TrHsDF1RGNreebKCbrcf0d+wkWEPrj32T2lm3DYKI=;
        b=HUFKhTzCVJAzEWzVUUwCQwnG/Bn7g+UE1prJBz639is/yT5hcKdERh47zRvKkGT7tH
         UcApwKIb5k3CUvWyx/lhOtnCeX+amq94wy5WUHVGme1CL0Zu1NEasH4KOoeIqsYXfQah
         aXdHKVV/vkxtBcwl+KDwB9u8tYMvvjFAH575Q992me16g6vBzRI4cjKo/fvpz12hZ3I/
         gZebcFW6323txdcYV8CuC7AdtjtxUSdLh4CQMWrjWHxMtBA8Gamh5iX6Z5qCjlf1jPqf
         OjdjoCw94DgldyZCdNL/5nVOgxzkfThR2PpixUEA1JTCzkleq0aX/YJGDhUZx4LOduQq
         2F/g==
X-Forwarded-Encrypted: i=1; AJvYcCVYwyUNWtr+8wqQeWQ8e6hYRlbIIYvoZXHa1LxTd9Bb9eRG+tGe8tfGKTezD6gjjpYUT14Hgr3J@vger.kernel.org
X-Gm-Message-State: AOJu0YzuW6g1/LBuqyj+/Ys7eHIyD4t1Hx9Ba/LzgzDxjZNbIkjgr9xt
	sLkZtTs9SjoljxvY4IwHAN4jQAkUzqPR3jy8bIj0ZlvQ4PrR7GaEyT6QZng6M8UUDr8=
X-Gm-Gg: ATEYQzz75MOr/TpXA79/ZwtFc2mLwBeeUp+qaCMPRGjCOcyZfOADHZSPUHEQoxlwZpl
	bNZEaO7ltj3iOo50ZW2/C9IcwST7fT3XHiq9y+wmqmXr7PkgEVizWd7xJK0/1MIOC9CZx8ZlOzc
	EqbxlM1A1Agk5gy8PfOhHBU+zOV/egQ/kU/5mI2pamNs4bRyGvpRykBV/8B0j5TqbDxGOQqILqr
	WM9U6ifWGE33cOygjRKZw7uQOu6N+6FdrtT1a+w5E2bIUFPuw2ZZ/nwxdQ0TGjSWMs8XciQCBUe
	H5XGn6frsOMdWmB3AejMizT4dONfiYevhTkNxFN1yPsxnDyzDyPod8We6Y716Aucg3L1PHDvaIr
	xfEsv+C4Ac3gxJrzjYatMCXMhEGarYao50+DAEhS60RiO8rroOsVH+IdwHMvEsX+SyRnBKF01HB
	R4p+GxYqcwJKdFMi4tg5BktfUNhnyseqch+fZ0/PPveXg=
X-Received: by 2002:a05:600c:3b17:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-4852695aeb9mr189560675e9.20.1773074718746;
        Mon, 09 Mar 2026 09:45:18 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541a8d4desm3471025e9.8.2026.03.09.09.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 09:45:18 -0700 (PDT)
Date: Mon, 9 Mar 2026 17:45:16 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Tejun Heo <tj@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH 2/4] cgroup: add bpf hook for attach
Message-ID: <ptsniiapf4wkho5qsjdbzog7zrago6bifqlsbauabosq4xnbna@vxvsno4cp4id>
References: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
 <20260220-work-bpf-namespace-v1-2-866207db7b83@kernel.org>
 <tmihfspwvvxv6sle27br4dgsbvepacnqj74zfscndkz722ssby@244dku2izea7>
 <20260227-ballverlust-abziehen-51ec7de2d16a@brauner>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-ballverlust-abziehen-51ec7de2d16a@brauner>
X-Rspamd-Queue-Id: 0516523D1C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14718-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.938];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello.

On Fri, Feb 27, 2026 at 02:44:27PM +0100, Christian Brauner <brauner@kernel.org> wrote:
> So calling this misconfiguration is like taking a shortcut
> by simply pointing to a different destination. But fine, let's say you
> insist on this not being valid.

I understand this in analogy with filesystem organization -- there's the
package manager that ensures files are put in right places,
non-conflicting and trackable.  Subtrees may be delegated (e.g.
/usr/local).  If root (or whoever has perms for it), decides to
manipulate the files, its up to them what they end up with.

> The implementation atop of a single superblock like cgroupfs is
> questionable.

(This is an interesting topic which I'd like to discuss some other
time not to diverge here.)

> But in general the point is that there's no mechanism to enforce cgroup
> tree policy currently in a sufficiently flexible manner.
> 
> > root detaching/disabling these hook progs anyway?)
> 
> I cannot help but read this as you asking me "What if you're too dumb to
> write a security policy that isn't self-defeating?" :)

I was just trying to express that there's only one level of root (user).
(Cautionary example are "containers" that executed as (host) root.
Lockdown neglected.)

> bpf has security hooks for itself including security_bpf(). First thing
> that comes to mind is to have security.bpf.* or trusted.* xattrs on
> selected processes like PID 1 that mark it as eligible for modifying BPF
> state or BPF LSM programs supervising link/prog detach, update etc and
> then designating only PID 1 as handing out those magical xattrs. Can be
> as fine-grained as needed and that tells everyone else to go away and do
> something else.

(These are too many new concepts for me, I must skip it now. I may catch
up after more study.)

> systemd will gain the ability to implement policy to control cgroup tree
> modifications in as much details as it needs without having the kernel
> in need to be aware of it. This can take various forms by marking only
> select processes as being eligible for managing cgroup migrations or
> even just locking down specific cgroups.

This is how I understand the goal could be expressed in current terms:

  a) allowlisting processes that can do migrations
     # common ancestor of all + access to each dst
     chown -R :grA $root_cgroup/cgroup.procs
     chmod -R g+w $root_cgroup/cgroup.procs

     # static:
       usermod -G grA user_of_pid
       (re)start pid
     # or in spawner:
       fork
       setgroups([grA])
       exec

  b) rules that are specific to cgroup (subtree)
    # applying same like above but to a $lower_group

    $ setfacl -R -m g:grB:w $lower_group/cgroup.procs
    setfacl: cgroup.procs: Operation not supported
    # here I notice why current impl isn't sufficient

Also, if I understand this correctly you semm to move from the semantics
where users (UIDs) are subjects to a different one where it's bound to
processes (PIDs).


> The policy needs to be flexible so it can be live-updated, switched into
> auditing mode, and losened, tightened on-demand as needed.

OK.
(I'd add that policy should be also easily debuggable/troubleshootable.)

> Ok, let's start with cgroup_can_fork(). The sched ext hook isn't a
> generic permission check. It's called way after
> cgroup_attach_permissions() and is a per cgroup controller check that is
> only called for some cgroup controllers. So effectively useless to pull
> up (Notice also, how some controllers like cpuset call additional
> security hooks already.).

There could be one BPF predicate (on the cgroup level) and potentially
pass per-controller data, so that function could employ (or not) those.
It's true that semantics would be a bit different because of implicit
migrations happening with controller en-/disablement.

What I don't like about the multiple hooks is that there'd be several
places to check when one is trying to figure out why a migration failed.


> On top of that this looks like a category mistake imho. The callbacks
> are a dac-like permission mechanism whereas the hooks is actual mac
> permission checking. I'm not sure lumping this together with
> per-cgroup-controller migration preparations will be very clean. I think
> it will end up looking rather confusing. But that's best left to you
> cgroup maintainers, I think.

This paragraph hinted me at (yet) another mechanism in the kernel (and
you also mentioned it with cpuset) -- the LSM hooks. Namely, if this was
security_cgroup_attach() hook, the logic could be expressed with other
existing modules, IIUC, one of them is BPF. Would that fulfil the
behaviors you're missing?

(I'm proposing this as potentially less confusing/known "evil" approach
to the scenarios considered above.)


Thanks,
Michal

