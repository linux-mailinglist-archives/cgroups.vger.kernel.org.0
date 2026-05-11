Return-Path: <cgroups+bounces-15791-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKFmIPM7AmrYpQEAu9opvQ
	(envelope-from <cgroups+bounces-15791-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:28:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B64C515DC4
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CFFCA30055B6
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 20:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24F33845B0;
	Mon, 11 May 2026 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Pqf2D/XX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A80A382F14
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778531308; cv=pass; b=naQPMDTH9X/uQZaQMhPCPDhsl+/Lo8n+dvp9/VkNEms5OpKaOtuF+mWEpdtsjeXrgInoVBwPaZ2yQQiqpqfsvedfbs/xMa7hcO9cAeQVdaikmS4eWvfidHdl+xT/WOKS73Y+NHzoTLtQS+LgvtISuoINE6BCq2OnEb5/+O1EBOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778531308; c=relaxed/simple;
	bh=hTbYoner07O2PP3jB6etyoj2SkkDIbMpdGA9ETgA8QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOzVe/H30Zb8VX8fArt0umkbYzrGBnWezYKpb7HK/WN+qJ7QH6fvjRdvBhYUVI9/qMD3X9mekRriTFV+BbbddZy7G+3RTfFH3do8I/CNkKi7uXAvFjNBZyuPEWtwtGOywpuTwXheLvhsBM0zxbU3GIXKAfXvDBzHobtlzfV0hIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Pqf2D/XX; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bd1caeba6beso145834266b.3
        for <cgroups@vger.kernel.org>; Mon, 11 May 2026 13:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778531305; cv=none;
        d=google.com; s=arc-20240605;
        b=ePx6eiZWPAx4bQokNgwVMJcAu0Y10vcvTYbo6iuBgMgSejQmHgnlWnNKxceMp7B0W2
         CDNnPL5h+wnptUhkYaowvFGdrSjpbWJ2RM97jnI2UXwi7OrcKILGA/pBRfB6+Z+/+WNt
         JQHBFxcbjLr/gzNXRu1YjM3HG8Ka8cP+P6OyMapiiHGnF11cfDnX1T0QYywA5CkM+q9+
         vlmFKk4NiEjAYqlWVBakY6RzzByTCXa3bdFdlzkr8sZg4XEdZtJkmSRHyknVQEyyCZDy
         MWjpsI0RbYdC3tHqbYpvJZxHXU3vk+9l5W2m2knSlFdhfVoLKPUg8dR56brQ1cvWxtWt
         Zwcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ecxYhhOsIWnMbGYp6OiuSoqJt7k54RRM2T4m9yuOxg8=;
        fh=/8iAKoiU3RSep5nvXwO7GuPw8DbSi9dnnJc57WHufTs=;
        b=Rz/1YoiYLe8s1VBoIYumhRmWTUru5nPz9h61Jq5OQeWDjUafhyEI2V3CcnxiIeuLNt
         WxK8iCGuzPZPMeQgVc6n/QsYT6vCRCaZHVi/uu54uH0Jk/0S0sPUq0J2URFBRIYeEjXJ
         76N6VPhxUOf3F9zdz6WIrRxiAkD1FgStgRKFHL2i8V0irvGfwPqmhT4ID1LWcCt9t/cK
         TL62J5JcrLsZJYuU2qNnP8wRoCMnkI7nZfD4kGNe19FWEj0V+XmCNYtV6RLb6/SK/RiA
         LH8tQzAxaFGtmHDKIqo0qM/nFPNa0DwfES7G+wqa10nAL9wbP0J3mtMfKmCan8rVgUXF
         xvaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778531305; x=1779136105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecxYhhOsIWnMbGYp6OiuSoqJt7k54RRM2T4m9yuOxg8=;
        b=Pqf2D/XXkXoZWPZHQqMY9IBZsTPIzZc2s8hRWTLCIWWh/mCQNnoBCNusWpQOqSxv/M
         30btj8h0UrFnnMsiDnTkMr4mTshByweR1IFq8Cw7xpE5sbpgMjkfIWAIe6bmq2ud60M/
         lWdAm5DtQkIVu7LGk2lBHjld6eiUve2zjik9wv5Je1M48kL8miY1mC8QuCNlg0QUT9c4
         nSZfVBr2RZcJneAM++otv/6PpeB69KFfmV763eRrDzCDclvTtsgmy9FVK0C37xUfOBDB
         +8oxIhRLfsmOVYrtt2u1RAsjRCaJUQTwAW04tUyadp67+w3b8/KYFC5imeXFdAPE+sCl
         n2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778531305; x=1779136105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ecxYhhOsIWnMbGYp6OiuSoqJt7k54RRM2T4m9yuOxg8=;
        b=TqDdmzKVhAjnEMs2Dh8VhAxZ43v5plMlRZiYYLR35sxZw/NCBu+F+I8cDJkekA/sEc
         76NPSJzP0b+6lStRh8s5ST5GAU5N72BwdfnW5GLeKY7yhhS3D0FJMQn3X4pRm51ak8sM
         TWRHmYRK6RiWbuYz+HVTbNv1Pt3cuoiY6u/7wX/E0PIvx1uTcRq09wVt6beVVF/Dmwe9
         0fgzWHzWL2K+jH3SVGao5wm/Sz4TiSW7Mk1gTjcb9FYIWmNY3IpvHklVwxyC6GBkglc9
         7QT+A8t/M+lI+Ik+tav4CAA+lj8FBlY3+OjZLmL7H6RQSfkq/HOZIlbvz4tMBGoL4qRl
         7CiQ==
X-Forwarded-Encrypted: i=1; AFNElJ+1yUqizhot/s9LfS42uagVRh6s/YnGvnyVHjSZ21Q8L1hBZY/lyeQgwWM2XW+O2DvQMECCXkRJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxRCnLCSUJ8atvaSGHgLHSkXfQVC6Kys0cglOjTt+2+txD8ORsw
	CXOU6gKQVkF5Xj51k4Q2Wlzu6rj0lPQ6MeEqQHFGrXHralFFeInX2qdHJg5U6W/gew95nrGTHAU
	qAYaDhdnqn97R/nQMIW/hNP9rU4MibShlpZJ6Gg2q
X-Gm-Gg: Acq92OGhurngjmyGS8TraMZdmUH24GGARbHb2nr/M0lsiUR9oCCFe/bn/viC2Rx7XDM
	fUBvD+BdbJo32iU041FRkKFNidd+Zmh5KAWQRIkDOYwazgMXpUfJ+T7zMhbMLMjuhSuIacFq8uj
	qOgNrhZaisysPIRYPvt1+V6dWamE6izobWZ/WtCk2ZOYZbriZIcK/oqSiKOjs2WVNdJmak+3ymI
	wUFhBy3oI1QPP/5sylPxb0844HQn9h4nmrTllsRJEj26D+ZIsjM+p+O7+SEFaAF3UHGC8Q9fVuT
	vA/kRYbx/1ZSsLLdLQ==
X-Received: by 2002:a17:907:782:b0:bba:5bc9:534a with SMTP id
 a640c23a62f3a-bcaac45410dmr950342666b.31.1778531304034; Mon, 11 May 2026
 13:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509213803.968464-1-atomlin@atomlin.com> <20260509213803.968464-4-atomlin@atomlin.com>
In-Reply-To: <20260509213803.968464-4-atomlin@atomlin.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 May 2026 16:28:09 -0400
X-Gm-Features: AVHnY4IuuqYYRw63FqWoEIYPWMqlZqNzlszYso7NSfFe-A6xx0Cnf7u9P8UUKq4
Message-ID: <CAHC9VhQthq7y2akbQSdJwBEex1MQYWG49wcJK3b8gSQuQ_d1cQ@mail.gmail.com>
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
X-Rspamd-Queue-Id: 6B64C515DC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15791-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Sat, May 9, 2026 at 5:38=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> w=
rote:
>
> At present, the task_setscheduler LSM hook provides security modules
> with the opportunity to mediate changes to a task's scheduling policy.
> However, when invoked via sched_setaffinity(), the hook lacks
> visibility into the actual CPU affinity mask being requested.
> Consequently, BPF-based security modules are entirely blind to the
> target CPUs and cannot make granular access control decisions based on
> spatial isolation.
>
> In modern multi-tenant and real-time environments, CPU isolation is a
> critical boundary. The inability to audit or restrict specific CPU
> pinning requests limits the effectiveness of eBPF-driven security
> policies, particularly when attempting to shield isolated or
> cryptographic cores from unprivileged or compromised tasks.
>
> This patch expands the security_task_setscheduler() hook signature to
> include a pointer to the requested cpumask. Because this is a shared
> hook used for multiple scheduling attribute changes, call sites that do
> not modify CPU affinity are updated to safely pass NULL.
> To protect against unverified dereferences, the parameter is annotated
> with __nullable in the LSM hook definition, ensuring the BPF verifier
> mandates explicit NULL checks for attached eBPF programs.
>
> This change updates all in-tree security modules (SELinux and Smack) to
> accommodate the new parameter mechanically, whilst providing BPF LSMs
> with the necessary context to enforce strict affinity policies.
>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  arch/mips/kernel/mips-mt-fpaff.c | 30 +++++++++++++++++-------------
>  fs/proc/base.c                   |  2 +-
>  include/linux/lsm_hook_defs.h    |  3 ++-
>  include/linux/security.h         | 11 +++++++----
>  kernel/cgroup/cpuset.c           |  4 ++--
>  kernel/sched/syscalls.c          |  4 ++--
>  security/commoncap.c             |  7 +++++--
>  security/security.c              | 11 ++++++-----
>  security/selinux/hooks.c         |  3 ++-
>  security/smack/smack_lsm.c       | 11 +++++++++--
>  10 files changed, 53 insertions(+), 33 deletions(-)

I haven't looked too closely at this patch yet, but based on a quick
glance, can you help me understand why it is included with the other
two patches in one patchset?  The other two patches look like stable
level kernel bug fixes, while this patch introduces functionality to
an existing LSM hook; one of these is not like the others :)

Unless there is something critical that I'm missing here, I would
suggest splitting this patch out from the other two bugfixes for
separate handling.  If there is a patch dependency issue you can
always mention that in the cover letter.

--=20
paul-moore.com

