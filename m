Return-Path: <cgroups+bounces-17246-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VeZCH7z7O2rRhQgAu9opvQ
	(envelope-from <cgroups+bounces-17246-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 17:46:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEF96BFC21
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 17:46:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=PC4XpCk9;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17246-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17246-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0915300CC39
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 15:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761DA3CC7EA;
	Wed, 24 Jun 2026 15:45:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5803016F5
	for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 15:45:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782315933; cv=none; b=LBfL/yV9Uv/prfFFRtivEd01RwMddJ0ocdAc3XWltrAud+4uUwiHEm0qWs2ghkzHKmAzMoAipbVFqC+VNZWtylrft3o57Z8YeWS/8d8VZXr2Z+S6wWxRP4/xX0hqbpsz1jrndzbFn+YNmyeM+CGFqkcormr3Y2DKORbLfpEq7mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782315933; c=relaxed/simple;
	bh=RAgF1FFgNlfrdTEPiMpeZp2hIOVJKZIIQ2OLT1gYqKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3pXpEYcHKhGDsZyHDFW2ChwcK5/A1ZClhEKF1uJwDoeatdUG0ZoBSgsQNH4+EJ1nrMzFJfhldjgWAcaNIzDydx3VSzCf+1NaRb/KjH1KZk5Rfo682DscVoVSGz08Uv+06k3WcomDE1pZBzyfoB+C8bk/2HlRKXkb500gX5qEao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PC4XpCk9; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4926046fbc5so24575e9.0
        for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 08:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782315930; x=1782920730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qZ7EIwRMMtpttBcQvtyW0LvRDRIObg2LOmo61ZATMkk=;
        b=PC4XpCk9ZdgAHBuZmiVPyzVa4otR1zjUYRDHtlAkdlMIPD19zg5U86gPApNbveseXM
         WrPLBuRWMvbjMIT06IEOXF0r4oUp2VjWSZOl9k7ugiYecEyru0YFSyeifGMQRMPnkXqr
         YZcPfo7ZvRVf9qAwDI65JZy/0b7CwaETeic6vsxBNPSc1QgaYA+GxR5q6W63kT872etx
         4an3UMeoNfoxcXoUC6bdM7XfAruu+vYXCxcuIdUQB2B/ErhR6GuJ0ThKKJioyWkmCpcJ
         Ou1S+qZ2NT+S9vz1EcTGQiyHaJ1egKPPWm0FyCmZP8Jsq82aFO95auiyvd26P+WNFJNT
         Yp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782315930; x=1782920730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZ7EIwRMMtpttBcQvtyW0LvRDRIObg2LOmo61ZATMkk=;
        b=f8S+QY5co7VXBjGWhRpOq4QLWDl81jjCNV5Uw4WrNkFYwRMJst2UnH5iii/VlmqYnT
         SbjjX0lG946M4Io/4mb/uzqpCCnQdsdSRo4L8R4VHM+21xNweyTOy42kZe9xUCxeHnyD
         MJdC2tdmpSu82Zwgk0/0XiyE9qe29qMT5rSnDzR6HD18BEbdLQSRVC8GnKcX8Y2Byn48
         Ff1ewiaHVprsw/5+hQhxKq8STIAFrYdZFdcaT7YozFqHms+y3o7B0u7d7TU2u9Jjt0sO
         KsDs8TnE74+2IoIzHkLLgECk6BiuLkPbHN5uqg1jDrNi5+d/tA7JM02rhwT0DQWplZm2
         UEaw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ce2IW/KqozU9aRQX8+Pe1b0x5FqVaJk1r3zHTXlC5ZDk2ckmfV9ZE9Sl8YN7XUfI4FhpdIXh5@vger.kernel.org
X-Gm-Message-State: AOJu0YzyahDTdR/PDQnYpj05Td562KZDn7CJf1+Z1a0NECKXXiqPYgwK
	zmWW1dGFZV8tJDlrXUqJU4qEkg1jAe5bQgzepDUDGjvQvZ3gRPfXXuUtbFBZzTqhWsc3sVbhVK2
	RKuq9jvs=
X-Gm-Gg: AfdE7cnQflIE0E9ZhJias9Oc0uOIxWQzFnOjYWyqYMD6Yu5F19yOV/XvcTITEFWf5Vq
	VUzx9yF9xmN/03Z684CMgq/DsYcrRUYTRuzzX8KCTP4BD+9UJt69FoKbelv79J2ewayl6lRrsWM
	vat2SDa4fD2Jjt8YJVPWvXcInCmgOnF3Mqu9Txa0HWEDifHFNc2WepJCXl1ZkFIjNSbDBXwssYn
	elYJN3v3yuLZAVW+MtMuDFlfkW4JyBtBfWB1sadSIcsLJ2m4p4AbxPXXHhEN2hNx+tL8dGlXz3D
	XN/2wfbWKkD+R9kAOSQ4qLpH3ADrwPW3Qo2SU+cZ+/0/5wLGYYKWZx0JKoVLrmKewgOuKqXKHVb
	vMk6MWsAE8KccIYB6mVxsS+HuM2SJSAqdCORilKInnZyvG7IJS4ytgO9P24MQFPcH9pskdIy/h4
	Tp0VjHFCh/s3wYMmd+fw==
X-Received: by 2002:a05:600c:3111:b0:492:38c9:b265 with SMTP id 5b1f17b1804b1-492632b6ef8mr14978345e9.15.1782315930241;
        Wed, 24 Jun 2026 08:45:30 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926403573csm1307185e9.7.2026.06.24.08.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 08:45:29 -0700 (PDT)
Date: Wed, 24 Jun 2026 17:45:27 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>, 
	Guopeng Zhang <guopeng.zhang@linux.dev>
Subject: Re: [PATCH-next v5 6/6] cgroup/cpuset: Support multiple
 source/destination cpusets for cpuset_*attach()
Message-ID: <ajutWBoJqkhktkvX@localhost.localdomain>
References: <20260602023203.248077-1-longman@redhat.com>
 <20260602023203.248077-7-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="itlyjlmnqgc2pen7"
Content-Disposition: inline
In-Reply-To: <20260602023203.248077-7-longman@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17246-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:chenridong@huaweicloud.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:peterz@infradead.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CEF96BFC21


--itlyjlmnqgc2pen7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH-next v5 6/6] cgroup/cpuset: Support multiple
 source/destination cpusets for cpuset_*attach()
MIME-Version: 1.0

Hello Waiman.

On Mon, Jun 01, 2026 at 10:32:03PM -0400, Waiman Long <longman@redhat.com> =
wrote:
> This problem is less an issue when enabling the cpuset controller as all
> the newly created child cpusets will have exactly the same set of CPUs
> and memory nodes except when deadline tasks are involved in migration
> as the deadline task accounting data can be off.
>=20
> It can be more problematic when the cpuset controller is disabled as
> their set of CPUs and memory nodes may differ from their parent or with
> the moving of multi-threaded process from different threaded cgroups.

When I generalize that it can be an issue for any threaded controller
that somehow relies on the _difference_ between old and new thread
membership.

So I checked some: pids and perf_events look alright (no
diff-dependency) but I noticed the very same issue is tackled in
sched_change_group/scx_cgroup_move_task and that there is a member
inside task_struct allocated for this state tracking already:
  task_struct::scx::cgrp_moving_from

> Fix that by tracking the set of source (old) and destination cpusets
> in singly linked lists and iterating them all to properly update the
> internal data. Also keep the current cs and oldcs variables up-to-date
> with the css and task iterators.

So there would be more than a single use for something conceptually
like:

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 004e6d56a499a..740c02f220c75 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1326,6 +1326,9 @@ struct task_struct {
 #ifdef CONFIG_PREEMPT_RT
        struct llist_node               cg_dead_lnode;
 #endif /* CONFIG_PREEMPT_RT */
+#ifdef CONFIG_CGROUPS_MOVING_FROM
+       struct cgroup                   *cgrp_moving_from;
+#endif
 #endif /* CONFIG_CGROUPS */
 #ifdef CONFIG_X86_CPU_RESCTRL
        u32                             closid;
diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 1a3af2ea2a794..5b63afe83f333 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -240,9 +240,6 @@ struct sched_ext_entity {
        bool                    disallow;       /* reject switching into SC=
X */
=20
        /* cold fields */
-#ifdef CONFIG_EXT_GROUP_SCHED
-       struct cgroup           *cgrp_moving_from;
-#endif
        struct list_head        tasks_node;
 };
=20
diff --git a/init/Kconfig b/init/Kconfig
index 2937c4d308aec..d7e7d4477f862 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1186,6 +1186,7 @@ config EXT_GROUP_SCHED
        depends on SCHED_CLASS_EXT && CGROUP_SCHED
        select GROUP_SCHED_WEIGHT
        select GROUP_SCHED_BANDWIDTH
+       select CGROUPS_MOVING_FROM
        default y
=20
 endif #CGROUP_SCHED
@@ -1288,6 +1289,7 @@ config CPUSETS
        depends on SMP
        select UNION_FIND
        select CPU_ISOLATION
+       select CGROUPS_MOVING_FROM
        help
          This option will let you create and manage CPUSETs which
          allow dynamically partitioning a system into sets of CPUs and

I think this could simplify the before-after state tracking generally,
WDYT?

Michal

--itlyjlmnqgc2pen7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCajv7kRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AgcJwD/bg/SvG8VumQlUebbvHIr
L1N7bJj/7LlKGZ3dYy8NebAA/itwcBWrkx3By3y8dBJOz4d5knPVRBXHIh5DGkHT
P9wN
=N/q4
-----END PGP SIGNATURE-----

--itlyjlmnqgc2pen7--

