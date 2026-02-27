Return-Path: <cgroups+bounces-14472-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFlBHSOgoWl8ugQAu9opvQ
	(envelope-from <cgroups+bounces-14472-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 14:46:11 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DE21B7D7E
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 14:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 010403055D4A
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 13:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078F83ED12A;
	Fri, 27 Feb 2026 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1NUZVrV"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDFA3101A5;
	Fri, 27 Feb 2026 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772199872; cv=none; b=b3AirGREf1zGFOA152LrlTZkP6t5BnyUJiuR/5dw2j94vJbC1tFCf8R9yK3gaTpLoq9zXjQhHaAjYFPQhAgOlfmBEMn+kHK8QbMZon7k6apPTB54Ddd/EbPawD/WOXcBSiTfUzecK34zoL5QiYerEIx770J7jH+N5xRyb7K6Mro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772199872; c=relaxed/simple;
	bh=6xelK0GBgh31lbjdU70PNZPK3L3GDYg3a/OL3tCNEPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Js0XxUTv2nSvdpbQVlHmUqgQV7MI4QsZRvn6dcExEICOzixKRcakSc6SodwA78bfNI2wkKeiV7oc38hDtoFw9SLaP37h597+BsPHhBdyPlSo3Fl8yRe9TnXmiUVeWDBm6hoE1iWouiArNHkiP6EGL7zLkFTgG+YEYrilZIC/3KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1NUZVrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1412C116C6;
	Fri, 27 Feb 2026 13:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772199872;
	bh=6xelK0GBgh31lbjdU70PNZPK3L3GDYg3a/OL3tCNEPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z1NUZVrVWdzLjmIp9qPBZeEHHX8xdGP8ocd2+uRhnG3GTEzRyHduQl5SkNupPu7Q2
	 YCKlWmwb2wm1rVn9pifu/YNoE/TRjj2H5nUKAQRruxHYsRDPtvEJ9jo6kd/Xk0BiUg
	 cdZ9y0eEP+oasywT/iPUGPFBO9CyTRac/uxnV10Nga2XPJwOJsWTVem5gS4Rf3wF10
	 8UcR8EYCfauE1r5zqdQ9Hcc5uta/DcPChuvx0J9Th85hMumnzL8J91S5ZEnqYEAKcX
	 MkeDNyz07DFLTiilaijMrvwbcexozniYkGNQbFGov+AkmKF5tK8Vl8H03oL74ao3Fp
	 ShMbYyA7Qwdmg==
Date: Fri, 27 Feb 2026 14:44:27 +0100
From: Christian Brauner <brauner@kernel.org>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Tejun Heo <tj@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH 2/4] cgroup: add bpf hook for attach
Message-ID: <20260227-ballverlust-abziehen-51ec7de2d16a@brauner>
References: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
 <20260220-work-bpf-namespace-v1-2-866207db7b83@kernel.org>
 <tmihfspwvvxv6sle27br4dgsbvepacnqj74zfscndkz722ssby@244dku2izea7>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tmihfspwvvxv6sle27br4dgsbvepacnqj74zfscndkz722ssby@244dku2izea7>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14472-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1DE21B7D7E
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 04:47:11PM +0100, Michal Koutný wrote:
> Hi.
> 
> On Fri, Feb 20, 2026 at 01:38:30AM +0100, Christian Brauner <brauner@kernel.org> wrote:
> > Add a hook to manage attaching tasks to cgroup. I'm in the process of
> > adding various "universal truth" bpf programs to systemd that will make
> > use of this.
> > 
> > This has been a long-standing request (cf. [1] and [2]). It will allow us to
> > enforce cgroup migrations and ensure that services can never escape their
> > cgroups. This is just one of many use-cases.
> > 
> > Link: https://github.com/systemd/systemd/issues/6356 [1]
> > Link: https://github.com/systemd/systemd/issues/22874 [2]
> 
> These two issues are misconfigured/misunderstood PAM configs. I don't
> think those warrant introduction of another permissions mechanism,
> furthermore they're relatively old and I estimate many of such configs
> must have been fixed in the course of time.

logind has to allow cgroup migrations but for say Docker this shouldn't
be allowed. So calling this misconfiguration is like taking a shortcut
by simply pointing to a different destination. But fine, let's say you
insist on this not being valid.

> As for services escaping their cgroups -- they needn't run as root, do
> they? And if you seek a mechanism how to prevent even root from
> migrations, there are cgroupnses for that. (BTW what would prevent a

A bunch of tools that do cgroup migrations don't use cgroup namespaces
and there's no requirement or way to enforce that they do. Plus, there's
no requirement to only do cgroup management via systemd or its APIs.

Frankly, I can't even blame userspace for not having widely adopted
cgroup namespaces. The implementation atop of a single superblock like
cgroupfs is questionable.

But in general the point is that there's no mechanism to enforce cgroup
tree policy currently in a sufficiently flexible manner.

> root detaching/disabling these hook progs anyway?)

I cannot help but read this as you asking me "What if you're too dumb to
write a security policy that isn't self-defeating?" :)

bpf has security hooks for itself including security_bpf(). First thing
that comes to mind is to have security.bpf.* or trusted.* xattrs on
selected processes like PID 1 that mark it as eligible for modifying BPF
state or BPF LSM programs supervising link/prog detach, update etc and
then designating only PID 1 as handing out those magical xattrs. Can be
as fine-grained as needed and that tells everyone else to go away and do
something else.

There's more fine-grained mechanisms to deal with this. IOW, it's a
solvable problem.

> I think that the cgroup file permissions are sufficient for many use
> cases and this BPF hook is too tempting in unnecessary cases (like
> masking other issues).
> Could you please expand more about some other reasonable use cases not
> covered by those?

systemd will gain the ability to implement policy to control cgroup tree
modifications in as much details as it needs without having the kernel
in need to be aware of it. This can take various forms by marking only
select processes as being eligible for managing cgroup migrations or
even just locking down specific cgroups.

The policy needs to be flexible so it can be live-updated, switched into
auditing mode, and losened, tightened on-demand as needed.

> (BTW I notice there's already a very similar BPF hook in sched_ext's
> cgroup_prep_move. It'd be nicer to have only one generic approach to
> these checks.)

This feels a bit like a wild goose chase. But fine, I'll look at it.
/me goes off

Ok, let's start with cgroup_can_fork(). The sched ext hook isn't a
generic permission check. It's called way after
cgroup_attach_permissions() and is a per cgroup controller check that is
only called for some cgroup controllers. So effectively useless to pull
up (Notice also, how some controllers like cpuset call additional
security hooks already.).

The same problem applies to writes for cgroup.procs and for subtree
control. The sched ext hook are per cgroup controller not generically
called.

And they happen to be called in cgroup_migrate_execute() which is way
deep in the callchain. When cgroup_attach_permissions() fails it's
effectively free. If migrate_execute() fails it must put/free css sets,
it must splice back task on mg_tasks, it must call cancel_attach()
callbacks, thus it must call the sched-ext cancel callbacks for each
already prepped task, it must uncharge pids for each already prepped
task, it needs to unlock a bunch of stuff.

On top of that this looks like a category mistake imho. The callbacks
are a dac-like permission mechanism whereas the hooks is actual mac
permission checking. I'm not sure lumping this together with
per-cgroup-controller migration preparations will be very clean. I think
it will end up looking rather confusing. But that's best left to you
cgroup maintainers, I think.

