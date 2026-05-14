Return-Path: <cgroups+bounces-15951-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFhHAXgtBmpsfwIAu9opvQ
	(envelope-from <cgroups+bounces-15951-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 22:15:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB20546AC6
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 22:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DB3E301E207
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 20:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0507E3C09FE;
	Thu, 14 May 2026 20:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f1PuyjQw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17453988FB
	for <cgroups@vger.kernel.org>; Thu, 14 May 2026 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778789730; cv=pass; b=dJOJq/D51kF7DcTgLt+HMJ7YdP4jkWl/+yYZW9oBBxdiZrmQl03cU60BT3iLBYE2QZ0rsEX2pyU4rb3CNhuhM40lxanhJioZveL7NCYWbPwf/iswIHdVicJEtwK7477TzNoZ6USbLE9dnjeLtkFYVRLmG6L1Qp6OzqeUqioAojM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778789730; c=relaxed/simple;
	bh=L23g/GV6s5dbwKzNwqZYuRfdnx5W42pO/aIZUxIvmnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvPEzUs6n8Z1sBrfyPwbKEyukZMw/v+nX/BTnqb+KWmUNFUm60u9PjOQzSjaThVzgtk0Zkot9lQy1ajR6JoiV3BU2B0E+e0791TCgYkMzUHtxdq1klEbE49IOxvbNwBWEdfNuRtm3rWKmhUcHRKwYSJ6mOB7tXx1yEUxFDTrfVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f1PuyjQw; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2baca4df358so51361045ad.2
        for <cgroups@vger.kernel.org>; Thu, 14 May 2026 13:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778789728; cv=none;
        d=google.com; s=arc-20240605;
        b=ZAcREdYw0UXaInap8hC1RLENiCeVLM/lVE20AUU4UIYgDI3hv+11MPkcuaHm/oDZjV
         jkmGkfhZLZWtkVBfDYO8HfW8cghyO34LbNU7E9F+royMjzs7y++oqOlBnU2hpldR8yIn
         /UY70qP/SRnMXESS3CsuhCKqbQ76WXvc/bApvlsF371NFJzDZCI5g8+awgxYH9kS3xnI
         P+N9pLpnb/vG2krWSV+KnJft5jxg3HLaKoSaJr6QsERvcGJZv+MJC2VyHKK5EZF54QUN
         u5YCjRjGyLKhnMhor9CnDrS0xR6iu5gVE8KxZpm4hHPHe6n3XfuhKc5IUI4d7PDAyv8R
         Lghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dSkJycESPksBK1TkswZjGhIZC6pa0KpxZLEtY/1MYi0=;
        fh=kenepZ3HnmjnTR1ms2d8TrQj2LltVNChD7FKnbQ9vFI=;
        b=FFBoo52NIHQKoIfb/NqUHoOlgxE+EbfVWdG+zPpVI70u6oxezuqDeBmjTri4oXZSgS
         L7xskO1R2iRPY0k8zsDyztkN4VqSCLpZc7ZisqRa0S/UdqSU00MQ0mjGgqBVM/JCt1Fh
         arIlaNZ69nnjzkIgTcfS/Cy7kKbT+rApFQw9krF845wwmcivb6CeSImL9KzD7sGDTXWY
         erRHXKgbV2W7zYlVPuSqJqyyjRU2TuSlcA7ooFJ04HxTadFM2bcw4DFW+8Z1m8YnBnI6
         E9EX5tbLceWjLpbmwAtUKcsPxjfijd86fFebhEg1mdXcmu+QLnsvZvEirGHJK+JMo15K
         pcKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778789728; x=1779394528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSkJycESPksBK1TkswZjGhIZC6pa0KpxZLEtY/1MYi0=;
        b=f1PuyjQwJ2UPuKHYXu4AJK5jjx5qZA4xMN8oFmbMM5S8Ac7A8EiC4bFv8+yK3zvR58
         RprWQ6iZssF/m9KgvXeFW+e/fzXz+kFwBq0KrD4Gi9RSNABJXL/KRxqv69FLRbbZfium
         OtPKil4Kj04QLGDjz1ygQEO3t899yWsx+Qrt0cueifTj5DPn7bxlo2pF0kxZg9lR4ls6
         6bCpNlNg9E6Re+ogkUPfb7zhGQWImdudVZqXjBIyWFlx7ecR8ijcCmF8CKrT11IYwuEl
         fi3RvMyvB5buo0+DFYZV+OWp3hDZRXe8/92UMlTyLvVYMn4mdWrmlukj15scfYShu40H
         4oVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778789728; x=1779394528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dSkJycESPksBK1TkswZjGhIZC6pa0KpxZLEtY/1MYi0=;
        b=q0avuKkgQ1Bg7ze6cdWeVvNgq2mpHEQA7o5VqdpzrNd5CL5qV8mlW9SKYyiypP2K3a
         UIhvsYWaTYC2n0A4YffWThC0oOXFSgLUkT4gp7iyJBQ2IB2W5TzD9DdPGFU9p9cf2mrz
         bQrkR21ntl1ht5pmK4zYFylF46j3rZL4PG5GGHPAzY4gbs5/QZN5N625Pt5xyDAh2zhn
         H8iR87jpUBDFSwsFcdir+XPoU/YwU2ryE548Fxf4O3TuZOQsDgqxZ6cJ+RIMpGCfG6rg
         Xebpz3LvDgVjdO1gxxZUvh6rRk/CUrKTamWAm3AAPQsVwut/Ervexe1zcQxLGxlLnMIe
         7DZg==
X-Forwarded-Encrypted: i=1; AFNElJ+wU1DvYgJMV4WKx+J1RQJ+EqpW3BMubE1ohuPul8OvdB3dCfSIS2cxTqa2ccvPF3EJpr8ByYRD@vger.kernel.org
X-Gm-Message-State: AOJu0YymuqpKxTDm7q0MRF1pNOXcd6v++HsdYSmvh9YPajomvdJDdjne
	Tz3oatnG4zpq5S1gq+5LFXeks2QZyfu8I7ViwWHA+H+ihkDfvLqhKT4SWjNx56/yzsQ7Mk6Ju5B
	WqC2CyVYcl2yDWqgcqf+1H9C0U2HRGZY/Xis52ArE
X-Gm-Gg: Acq92OGfJC/x8w4xy2i/SGxrcxweN5KnAuxjV9fXDsupNZGXKIWkJRSKalM38lZH8sV
	yv1GFR+1/dswa0c4lNTAorBFfqqvCMSQigbvPBIkGje8lbOVzADS0d/cxJYRi2ceBALhJgEEXF+
	UcYI2Cfn1JhZEqF6814HSNBA01SHJyM4+javd+gaPgxIh2CLNswlzm7YgYFMy/vh7j3w+ffyccb
	rn0JVmUrJl0zeZP+QzqnhwyD/lmfshbChReqzbSyoG531kOHFB7b/3FDYRyN1PBFgbovhOFXMLo
	U334dLE=
X-Received: by 2002:a17:903:94e:b0:2b9:f59e:aca5 with SMTP id
 d9443c01a7336-2bd7e9e7777mr8938935ad.39.1778789727707; Thu, 14 May 2026
 13:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509213803.968464-1-atomlin@atomlin.com> <20260509213803.968464-4-atomlin@atomlin.com>
 <CAHC9VhQthq7y2akbQSdJwBEex1MQYWG49wcJK3b8gSQuQ_d1cQ@mail.gmail.com> <bscbywzzx4nmxzbuw2bkzltb7rrmgmzy5u4gqy5pfpmafcnlto@eznniiguusqb>
In-Reply-To: <bscbywzzx4nmxzbuw2bkzltb7rrmgmzy5u4gqy5pfpmafcnlto@eznniiguusqb>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 May 2026 16:15:15 -0400
X-Gm-Features: AVHnY4J6HtYDS9Lrpjl43i8SgHkaXzBYbs_PTjoO3Mw_C9TveMyo-g1mcK1Gb3Q
Message-ID: <CAHC9VhSWrJc=aE1Sg4xfv1ZMmh=JqZFLWGeG2SnzOFqXxcUbtQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] security: Expand task_setscheduler LSM hook to
 include CPU affinity mask
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: tsbogend@alpha.franken.de, jmorris@namei.org, serge@hallyn.com, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, stephen.smalley.work@gmail.com, 
	casey@schaufler-ca.com, longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, chenridong@huaweicloud.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, omosnace@redhat.com, kees@kernel.org, neelx@suse.com, 
	sean@ashe.io, chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, 
	nick.lange@gmail.com, cgroups@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9EB20546AC6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15951-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[alpha.franken.de,namei.org,hallyn.com,redhat.com,infradead.org,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com,huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,amd.com,ashe.io,abita.co,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[atomlin.com:email,mail.gmail.com:mid,paul-moore.com:url,paul-moore.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 3:49=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> =
wrote:
> On Mon, May 11, 2026 at 04:28:09PM -0400, Paul Moore wrote:
> [ ... ]
> > > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> > > ---
> > >  arch/mips/kernel/mips-mt-fpaff.c | 30 +++++++++++++++++-------------
> > >  fs/proc/base.c                   |  2 +-
> > >  include/linux/lsm_hook_defs.h    |  3 ++-
> > >  include/linux/security.h         | 11 +++++++----
> > >  kernel/cgroup/cpuset.c           |  4 ++--
> > >  kernel/sched/syscalls.c          |  4 ++--
> > >  security/commoncap.c             |  7 +++++--
> > >  security/security.c              | 11 ++++++-----
> > >  security/selinux/hooks.c         |  3 ++-
> > >  security/smack/smack_lsm.c       | 11 +++++++++--
> > >  10 files changed, 53 insertions(+), 33 deletions(-)
> >
> > I haven't looked too closely at this patch yet, but based on a quick
> > glance, can you help me understand why it is included with the other
> > two patches in one patchset?  The other two patches look like stable
> > level kernel bug fixes, while this patch introduces functionality to
> > an existing LSM hook; one of these is not like the others :)
> >
> > Unless there is something critical that I'm missing here, I would
> > suggest splitting this patch out from the other two bugfixes for
> > separate handling.  If there is a patch dependency issue you can
> > always mention that in the cover letter.
>
> Hi Paul,
>
> Thank you for taking the time to have a look.
>
> You raise a perfectly valid point.
>
> Please note, the cgroup-related BUG fix will be dropped from the next
> iteration of this series. As per Waiman Long (on Cc), a solution for the
> BUG was already proposed here [1].

That's good news.  I saw some discussion on that but didn't follow it
very closely.

> However, I suspect the MIPS-related patch will need to remain coupled wit=
h
> this feature patch. Because the first patch fundamentally alters the
> signature of the security_task_setscheduler() hook, the MIPS FPU affinity
> code must be updated concurrently to accommodate the new parameter.

I generally dislike when bug fixes depend on new functionality; it's
backwards in my opinion.  I would much rather see the MIPS bug fix
patch submitted as a standalone patch and then have the LSM hook
modification patch come separately, perhaps with a note that it
depends on the bug fix patch.

--=20
paul-moore.com

