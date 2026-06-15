Return-Path: <cgroups+bounces-16983-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vbUXAGl3MGqITQUAu9opvQ
	(envelope-from <cgroups+bounces-16983-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 00:06:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9519068A47E
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 00:06:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=paul-moore.com header.s=google header.b=BJDCw6rF;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16983-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16983-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=paul-moore.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7F0730A3EEF
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 22:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9183B71C6;
	Mon, 15 Jun 2026 22:03:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA613B71B0
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 22:03:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781561000; cv=pass; b=sT2SE54fFp2/W9K1cCn+mNLSar1+Ybb3UM9vEhN7kHh/4tcESiquZY/a09vIs86ZLJgfT0mfjJtaMV10yD1qEfvNPUgNp/YfkEisaiVWXDrkBC5RGeQvk5fRW5IyjBC4XOLgeWXA1eslTjMH3QSPz0bgoJl+vqBvpkIevBhsXXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781561000; c=relaxed/simple;
	bh=EmFKaOA4oNrlRBvxBZ9rHktVxwJtkaco4eJBdSabd3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stQVeMW4ML1F484eNSW/5APQvXyj2fM/5R+5fTmdBXq3bvNW4S1bPDq+vziR0wKwua6u/84Qj0vjDkXTei29HzKT2jMg1srVBG23LXFU57uyje01tI7VVIsxi6zFFlBVTnKl7U06kuv0LqURrcTCG3SXUZ62H2Jc1WTGxk48FrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BJDCw6rF; arc=pass smtp.client-ip=209.85.216.45
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36babe2c4bdso2311964a91.1
        for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 15:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781560998; cv=none;
        d=google.com; s=arc-20240605;
        b=HVo6jmpEUMjAqzBHQgazjH68HPXjdRFzGoufiwGengX0SLqbJcC4m/Wq2Iy2aADdw9
         ul23e1bIUD4ghUjds7kh5CfQB6yX0boVvwKa022DMSN7xlr15bWKCknZVx2qTv/o4L1J
         bTyMOzXjySGSPNBi1dOFG3yfpOZ8Eg/HYrR5cHsGQ9RLSHfJ8P4Zdtprzt4DYnnvGror
         I7GFoFg2v5hSW5U4zPOEeQIAgke07UqffwnBB1ZvhaxkBeFYkmETJ+UQhMgZH0z0g36v
         rdj0Lh5fcrGPlJXRr62cIsAKLLOQv0nY1+WMySXKrBnbHJX/Piub56wVC8BfiEo774Sq
         GDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wlUiFVf+F3ja4t9u45sKndzLjC4xR7XGyYPH3sd+NYE=;
        fh=620n3s7rPxCTrlB1LY84W1OytchzPTiKpc0YVNken+k=;
        b=TUPw8jW77m3Qonz9ON3j4RMmCFT75Pwe0PkinZe8t5GVg3LBZZTWLs/p891LwV7tVI
         +4P0oSJWRXrqE2PRHZokMYdK37NU6lmA7MoG5keoTi4Ye+hVZD79Dnj/b5Co6SobQvZ1
         g+Axaq+cgBAoxZtUBqK0/PQxloe5xx9uUUtH2nnGy99pviAsa+gH0EwYOe11Zx8Zboi/
         KvJVIuOjq9erskWG6PADHDji420OejMivStmy5WOlD3eWqWglSVaj0jXVlv85S3fRyd4
         vqUWlg+6JWEsHFhEa7sLrixafIcrGpaYr2hPZV7aupnCN53xyMQdSbPFRURzdOLBHPcy
         08eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1781560998; x=1782165798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlUiFVf+F3ja4t9u45sKndzLjC4xR7XGyYPH3sd+NYE=;
        b=BJDCw6rFumNKx1ZbmdQRzwmpdly4t68vMzh62PCU+SCpV2yNZCUodou4EdDx/Qx/MW
         6uqjkPcrhEixJmavhk0DxWbhFDZR6Ex++CRCCuuwVmXO4Oa3rzjm3nBbdFcVNypyppAu
         b4zj7rSqzAj8uFRh0O/3B5yoknz35ttIPmwb/1KKWMah3EJkJNZutoqrUj6nPJGS3ZcG
         Cvhq67+/rF3lat4Nwclq1vhvdOUm0JkDpMEC0c8BWgcN6b9IoWnboCiqP+wWbNyVOK7d
         hkX69MERi9QInOruF7yjj8dzkr/v69LsZ8kg533CZ5rzzjIz4XNw+lzP+R5YRw7VvQVU
         bKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781560998; x=1782165798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wlUiFVf+F3ja4t9u45sKndzLjC4xR7XGyYPH3sd+NYE=;
        b=PEj4UIFeM4QiKhBzSCqWI5sWoAjnvCjDpP36+HCedX57XgATl++LYo/Nxg3+BrbP/a
         k2RMSau7pRXxeU/rAJvajMGlshicTs/2OUXUZhoxL7hQmSO+H/ofFeooMCDGOgrlvfyv
         hZKYtqQvv6124h7fJgK5NRORVBJIzOieeGPM6gp1l5QiZbaeCPIyW70f+50txBQ0EOhz
         YnEd9Z5wZtERyNLXAZcFd+z1zfV1uH5JKmps6iAShMUYTuIIWI1QtMg6cF/p+NkrqiN4
         wM6S5LixefZQ2oTtps200fu99TFzcHebG1NJymGOEGGgFz/fqI7dH4qFO7Q6gI1Fbajf
         nt9g==
X-Forwarded-Encrypted: i=1; AFNElJ+NPicyjPXqUAVD7BnO3puXLtcKD/PVgOf8zTX+bI5JBPIgAQLFtp/VkYnWO1KJqBhzKTYnfIEB@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfolj3gRzXNUM3PYShBqAqZmziuFXnx/S1sYEFetQy7CSQ6zfp
	MVqYuDERaK5MYG+uIgmjKNI2OnbwpPvvnJAldcZ03lJxN4ZCl0mmvYmYWsp2uAjOOJ2KgcCIOxJ
	nUUUZr/NDeJITsnAJ1gr1wCJE/TbVO0aSiInWZILi
X-Gm-Gg: Acq92OGktLnDN+vzXfD9VNoXPXhLcp6lv4yWfZsgxLu+K6kmODVz48N+JHwd2zwUuLr
	JxYA2Wsi0vvC8/qnTZ+vdUmUJXSuQzPuoV/lGkUYfJKCx5XThSt0Cxp06w9irVQexx3Q4jAOCDO
	xBKnsh0qdPvzz9pxxbttfJr7IzzFPHbFFTJdR8F0H0HZSMXjeh+HWF4AwUUzF0hfmIvNErO+hkZ
	Y6lcTgpHp7/uCIWj2/7PNspXlZxH5b2GqKoUiy/mqNFOHK9rimT9uaaIWWLPDDz5wEGYc/OoW0/
	EUKz27I=
X-Received: by 2002:a17:90b:6cc:b0:366:10f1:3d91 with SMTP id
 98e67ed59e1d1-37c5280310fmr980748a91.1.1781560998051; Mon, 15 Jun 2026
 15:03:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526142838.774711-1-atomlin@atomlin.com> <20260527085221.GQ3126523@noisy.programming.kicks-ass.net>
 <bgjagepcfb7gz6jawatu6kpfmecw46gwg5cvb6r7dl3dn7bt4l@rtymdaslx7ef>
 <20260527155404.GV3126523@noisy.programming.kicks-ass.net>
 <ov33cu2wosubbfufcmfyoinfatecskjgmkvqyit33komlcla2d@2qgj45724bql>
 <20260527195858.GC3493090@noisy.programming.kicks-ass.net>
 <6hqq5oxvlcpmjvyns42dy2vtfvvixy7q4xyyjrrn46jrvsx5ar@gkmjsteqlpzd> <exlgb3dg2kwxgna6gx2qixexvwjjul7z2ya7npal2gz4jjtr7m@h4oxgd74gsbp>
In-Reply-To: <exlgb3dg2kwxgna6gx2qixexvwjjul7z2ya7npal2gz4jjtr7m@h4oxgd74gsbp>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 15 Jun 2026 18:03:06 -0400
X-Gm-Features: AVVi8CfvZsjFK88VKetzhE6sTJzGZThz-uSnhi3jqg2JCvabtyn_WzFIJ4i1dgo
Message-ID: <CAHC9VhSROg6RGUN4_ZVBoEwYjRnKvyjnkbx2D88c09KiTgY3KQ@mail.gmail.com>
Subject: Re: [PATCH v3] security: Expand task_setscheduler LSM hook to include
 CPU affinity mask
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: tsbogend@alpha.franken.de, jmorris@namei.org, serge@hallyn.com, 
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	stephen.smalley.work@gmail.com, casey@schaufler-ca.com, longman@redhat.com, 
	tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, 
	chenridong@huaweicloud.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, omosnace@redhat.com, kees@kernel.org, neelx@suse.com, 
	sean@ashe.io, chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, 
	nick.lange@gmail.com, cgroups@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16983-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[paul@paul-moore.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:atomlin@atomlin.com,m:tsbogend@alpha.franken.de,m:jmorris@namei.org,m:serge@hallyn.com,m:mingo@redhat.com,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:stephen.smalley.work@gmail.com,m:casey@schaufler-ca.com,m:longman@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:chenridong@huaweicloud.com,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:kprateek.nayak@amd.com,m:omosnace@redhat.com,m:kees@kernel.org,m:neelx@suse.com,m:sean@ashe.io,m:chjohnst@gmail.com,m:steve@abita.co,m:mproche@gmail.com,m:nick.lange@gmail.com,m:cgroups@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stephensmalleywork@gmail.com,m:nicklange@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[alpha.franken.de,namei.org,hallyn.com,redhat.com,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com,huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,amd.com,ashe.io,abita.co,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9519068A47E

On Mon, Jun 15, 2026 at 11:22=E2=80=AFAM Aaron Tomlin <atomlin@atomlin.com>=
 wrote:
> On Wed, May 27, 2026 at 09:19:11PM -0400, Aaron Tomlin wrote:
> > On Wed, May 27, 2026 at 09:58:58PM +0200, Peter Zijlstra wrote:
> > > On Wed, May 27, 2026 at 01:41:52PM -0400, Aaron Tomlin wrote:
> > >
> > > > > > The actual use case here is multi-tenant workload isolation and=
 visibility.
> > > > > > Passing the evaluated cpumask to the BPF LSM allows operators t=
o write a
> > > > > > simple eBPF program to detect spatial boundary overlaps (e.g., =
logging an
> > > > > > event if a requested mask intersects with platform-reserved cor=
es).
> > >
> > > Why isn't cgroups good enough to enforce this? If you create a cgroup
> > > hierarchy per tenant, and constrain them using the cpuset controller,
> > > they should not be able to escape, rendering this event impossible.
> >
> > Hi Peter,
> >
> > You raise a very fair point. The cpuset cgroup controller is indeed the
> > kernel's primary vehicle for spatial enforcement, and under normal
> > circumstances, it successfully prevents a tenant from escaping their
> > designated cores.
> >
> > The cpuset controller does govern resource limits, but does not audit
> > intent. When __sched_setaffinity() is invoked, the kernel compares the
> > requested in_mask against the task's allowed cpuset. If there is only a
> > partial intersection, the kernel silently truncates the requested mask =
to
> > fit the cpuset, without raising any alarm.
> >
> > The BPF LSM hook, conversely, receives the raw, untruncated in_mask,
> > affording operators the visibility to detect, audit, and even reject th=
ese
> > violations of intent before the kernel silently sanitises the input.
> >
> > This patch does not seek to replace the cpuset controller, but rather t=
o
> > complement it by providing auditing capabilities.
> >
> > > > We are not creating a bespoke BPF hook here; rather, we are rectify=
ing a
> > > > historical blind spot within the API. The existing LSM hook is invo=
ked
> > > > during sched_setaffinity(), yet it presently receives only the task=
_struct
> > > > pointer. Consequently, the security module is essentially asked, "S=
hould
> > > > Process A be permitted to alter Process B's affinity?" without bein=
g
> > > > informed of the proposed affinity itself. Providing in_mask simply
> > > > furnishes the existing hook with the requisite payload to make an i=
nformed
> > > > decision.
> > >
> > > It occurs to me that this same argument would require to also pass in
> > > the new sched_attr, no? That way the LSM can inspect the new policy
> > > before it becomes effective.
> >
> > I agree, the underlying logic does indeed extend perfectly to sched_att=
r.
> >
> > Presently, the LSM is equally oblivious as to whether a process is
> > requesting a benign transition to SCHED_BATCH, or attempting to escalat=
e
> > its privileges by requesting a real-time policy such as SCHED_FIFO with
> > maximum priority. Just as with the CPU mask, providing the sched_attr
> > payload would rectify this parallel blind spot, allowing BPF policies t=
o
> > inspect and mediate scheduling attributes before they become effective.
> >
> > If you are amenable, I should be more than happy to expand the scope of=
 the
> > forthcoming patch to include this. Alternatively, we could address the
> > sched_attr expansion in a separate, subsequent patch. Personally, I wou=
ld
> > favour the latter approach, but please do let me know your preference.
> >
> > I very much look forward to hearing Paul's thoughts on whether this ali=
gns
> > with the broader LSM vision.
>
> Hi Paul,
>
> I am writing to politely follow up on the discussion above regarding the
> proposed enhancement to the sched_setaffinity LSM hook.

Generally speaking I wait until all dependencies land in Linus' tree.
I've lost a lot of time in the past sorting out issues only to have
one of the dependencies rejected.

> As you will see from the thread, Peter Zijlstra and I have discussed the
> architectural justification for this change. While the cpuset cgroup
> controller effectively handles spatial enforcement, it silently truncates
> requested affinity masks. Passing the raw in_mask to the LSM hook enables
> security modules (such as the BPF LSM) to audit and mediate the actual
> intent of the request before the kernel sanitises the input, a capability
> that cgroups inherently lack.

The issue of resource control comes up from time to time within the
context of LSMs, and my general comment is that we likely need to see
a more comprehensive approach to what access control on resource
limits would look like from a LSM perspective.  We've seen a lot of
quick changes to solve very specific problems, but I have yet to see a
good proposal of what it would look like for a more comprehensive
approach.

There is also another issue to consider: none of the in-tree LSMs
currently use these new parameters, raising questions about their
purpose, maintainability, etc.  While this is not necessarily a deal
breaker, it does go along with my comment above about taking a more
holistic view of LSM resource controls.

To summarize, I haven't thought about this too much yet because there
are other fires/patches that don't (currently) have the dependency
issues of this patch.  I would also feel a lot better if there was an
in-tree user of this parameter and some discussion of how this might
fit into a more holistic approach to controlling resource limits in
the LSM subsystem.

--=20
paul-moore.com

