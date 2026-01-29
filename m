Return-Path: <cgroups+bounces-13513-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dsXOFCJfe2k5EQIAu9opvQ
	(envelope-from <cgroups+bounces-13513-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 14:22:42 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAC3B0573
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 14:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9037A3008D78
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 13:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC4E27A91D;
	Thu, 29 Jan 2026 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gBq3VVX/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389D8274FE8
	for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769692960; cv=none; b=HIPrAB3PN9LddjTUuQQzC9vI5pmu4P+5dyp1d/wjpEjREPo0+sxlizD6pbKhjWNmiJNnQyVoJFr2UU/bHYfPdD/MY7txa9hU853vnxNIB7y5adBiOSGpm2V1skuALTPiJ65VKm5H3igx/zk2gEqnlLe2tWMUYF0DHQ8emU3a/+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769692960; c=relaxed/simple;
	bh=2wHfYg/lyIGZe1ek1ETbVGXl47R8USy/V/E0njKUunM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8eedMCmU4i86ilY5XxLqBrjWUKV13wdQh6dCZnzv1qlfILfraqVG14y5VV/qCaczt7UbUQm9oppScJSsNNAH8zdDiwO24g94p3HthYtzQCJzYqgmjk9Xv21KGlyf56j6iLPPkpa8HWHU0V3t9N53IW0VdiULmSPY43MnZ876mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gBq3VVX/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fbc305552so961919f8f.0
        for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 05:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769692955; x=1770297755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xhlnpxMmRlxceCPqRQsQ5wiSzhcIg8jwSHkDE4vwcgw=;
        b=gBq3VVX//Ra/pP/IgmJ2U2d29wKiA3QTx8U7Q3m4quYbihelIkOtgS2Xme8gxkEHB1
         qCKY9yWTupwzoYNrj3uLmzegw6CKJk3r2zBYievehybKCSFy6Rffid+ydnyHdsA00/Sv
         r29Uy8OK7TbfcogQnCY0iO65tPaWz94IwigcejDfRALt2a090MZ/9k/QVJDU8eN3clnH
         vVFxBPq2KSDR05+7LnTKZQcs7nWZx/2LnZ9Z01iO8cydrUoNj3WTgqhtxZ+c8F63DukR
         gadlZcFrs9KVOm8MMpjR93lTEisJuYUq67eL+3LeAzTmjTSsAvwHkBtJazdLrf9mGASO
         bMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769692955; x=1770297755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhlnpxMmRlxceCPqRQsQ5wiSzhcIg8jwSHkDE4vwcgw=;
        b=hIR7QOLM4MF3eumNdXpsu1M49Cxgxvv16HGxeRhg1xPOfXdJ+JrkNUA+upmYfd3NkQ
         fvJdhipwy/th23w43EtwRya+HsGnBuWDaVakjwxYQcr7zvrFtkLOP9a3byEiXnrdlla4
         NsVqT/BTXfFnjEwhpQQ2h/CF8IPZcTsv2eAHtinrTjQEQaNovaSpVLpfJFzch/pf4IVq
         X0vnNEQkUrruZ4xil5MQ3cxSuudp9PF9GoAf7Pbyx5vjQuJtaJMLrvIpEMoyrnKrFsML
         +xMCV1JvM4D84qczGXnW6OjtvNrspfm6huBseqK4DIvKWFz++iM6Hjxc7+cRcog6exQW
         WmTw==
X-Forwarded-Encrypted: i=1; AJvYcCWS8c7aC2tzRJppA7Z/2JF57SJtg3x7rVEIzpDO33ZUlNbZGHe3q/1Y8QBmQWgXPsz7upPEsDSj@vger.kernel.org
X-Gm-Message-State: AOJu0YzKsmFBIjKZCZ1Z0RvS3Ndu7b75Jz5BWrbn2wzo2EtYiRul7nzj
	j5Two0ME6yhS0wNvyELyDAKx4E2EA+Qzc6O3s5KCsPWDy1iwgR4gRh7OegJoRhkN2OYoYouo3t8
	Ndm9u
X-Gm-Gg: AZuq6aKK7ykxlYHRyBxOAIIGNvbF2Q0VYwJ5BgStVdGmy1Et+NxynDy0Lg6+IA84B5q
	tQ2UNXr0H8thIwvDAS49xiiHhuTyetaxs0r2hArul/hLVrJE87bqoB/m9rl49O/iDXAqfbxMMPj
	3TypG8Bf3MBmidQBhwhAKincsGcwVuylC/PdBJL4zHNB+9BqrB57sjrFAGEB5IbnDXTEe91nG4K
	UJ5dZJUPlsqtwoS9krJxEb5HWt3B8TFvZvAo3mEPRtwpmKt562cZz5r2Qgx3zZ5nu0m2P+8tTyP
	R7/t8lphgER/Ia8IU2cvK70WhfI2aGKu9BAwVRa6n9pOTsSEivyfQLR0zmT9OIFaPAeN8OWgxG6
	oJz5sOSrQ7R7uj5Rq0EtXhI7WFIZ4FfsnjHdC/dCFn1gPAJDkGW+NQiJ3eBzKncD9dP7D5PI00E
	d7DPBtycG6Sh2PFL5u4MtY3dUkAQPYJkU=
X-Received: by 2002:a05:6000:1ace:b0:435:a4a9:6f79 with SMTP id ffacd0b85a97d-435dd0283d2mr11433817f8f.8.1769692955415;
        Thu, 29 Jan 2026 05:22:35 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e4762sm14167283f8f.6.2026.01.29.05.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 05:22:34 -0800 (PST)
Date: Thu, 29 Jan 2026 14:22:32 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, brauner@kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] cgroup: avoid css_set_lock in cgroup_css_set_fork()
Message-ID: <roisfgpkd7tapp7cfjavmih2e2riwh2nczv4nqk25gik7of4pa@3ohyptw6nvb3>
References: <20260122112951.1854124-1-mjguzik@gmail.com>
 <CAGudoHErB_Dm8kTRDa8cNOe4aRgc6kAV0bnT90Pp_Uda+_DqDQ@mail.gmail.com>
 <uwuworxk3warxfnvr7g3gnrh5g7bnnkq5uhbsnoh42muv7zeax@y7ddpcbhwarw>
 <CAGudoHFaUjm7_Eh6VOOGvfscdekk7v2uNPjfLkZfAkR9aCA1Ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jz64ja35xy3hxb6p"
Content-Disposition: inline
In-Reply-To: <CAGudoHFaUjm7_Eh6VOOGvfscdekk7v2uNPjfLkZfAkR9aCA1Ew@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13513-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2DAC3B0573
X-Rspamd-Action: no action


--jz64ja35xy3hxb6p
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] cgroup: avoid css_set_lock in cgroup_css_set_fork()
MIME-Version: 1.0

On Tue, Jan 27, 2026 at 07:18:44PM +0100, Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> Not sure what you mean here.

Let me add a patch for illustration.
Does that clarify? (How would that change your watched metric?)

=2E..
> It may need some tidy ups but for the purpose of this discussion we
> can pretend it landed.

That I follow.

> clone + exit codepaths are globally serialized as follows:
> - pidmap -- once per side
> - tasklist -- once on clone, twice on exit
> - cgroups -- twice on clone, once on exit
> - some lock for random harvesting, can probably just go
=2E..
> So ye, css very much can be considered a problem here.

Acknowledged.

>=20
> This comment:
> > - effect of css_set_lock in cgroup_post_fork().
>=20
> ... I don't get whatsoever.

I meant that css_set_lock is taken 2nd time in cgroup_post_fork() (also
after this rework it remains there).

And I'm wondering whether removal only in cgroup_css_set_fork() improves
parallelism because the tasks (before patching) are queued on the first
css_set_lock, serialized through the first critical section and when
they arrive to the second critical section in cgroup_post_fork() their
arrival rate is already reduced because they had to pass through the
first critical section. Hence the 2nd pass through the critical section
should be less contended (w/out waiting).

I understand it's good to reduce the overall hold time of (every
mentioned) lock but I'm unsure how much helps eliminating css_set_lock
=66rom two to one pass on the clone path.

>=20
> Stability of cgroup placement aside, to my reading the lock is needed
> in part to serialize addition of the task to the cgroup list. No
> matter what this will have to be serialized both ways with the same
> thing.

Yes, the modification of css_set->tasks list still needs css_set_lock in
post fork.

>=20
> Perhaps said stability can be assured in other ways and the list can
> be decomposed, but that's some complexity which is not warranted.

The decomposition is not obvious to me :-/


--- 8< ---
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index bc892e3b37eea..a176fd60ba08f 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -413,11 +413,13 @@ static inline void cgroup_unlock(void)
  * as locks used during the cgroup_subsys::attach() methods.
  */
 #ifdef CONFIG_PROVE_RCU
+extern rwlock_t css_set_clone_lock;
 #define task_css_set_check(task, __c)					\
 	rcu_dereference_check((task)->cgroups,				\
 		rcu_read_lock_sched_held() ||				\
 		lockdep_is_held(&cgroup_mutex) ||			\
 		lockdep_is_held(&css_set_lock) ||			\
+		lockdep_is_held(&css_set_clone_lock) ||			\
 		((task)->flags & PF_EXITING) || (__c))
 #else
 #define task_css_set_check(task, __c)					\
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 5f0d33b049102..4e28e922e5668 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -83,15 +83,21 @@
  * css_set_lock protects task->cgroups pointer, the list of css_set
  * objects, and the chain of tasks off each css_set.
  *
+ * css_set_clone_lock synchronizes access to task->cgroups and cgroup->kil=
l_seq
+ * instead of css_set_lock on clone path
+ *
  * These locks are exported if CONFIG_PROVE_RCU so that accessors in
  * cgroup.h can use them for lockdep annotations.
  */
 DEFINE_MUTEX(cgroup_mutex);
-DEFINE_SPINLOCK(css_set_lock);
+__cacheline_aligned DEFINE_SPINLOCK(css_set_lock);
+__cacheline_aligned DEFINE_RWLOCK(css_set_clone_lock);
+
=20
 #if (defined CONFIG_PROVE_RCU || defined CONFIG_LOCKDEP)
 EXPORT_SYMBOL_GPL(cgroup_mutex);
 EXPORT_SYMBOL_GPL(css_set_lock);
+EXPORT_SYMBOL_GPL(css_set_clone_lock);
 #endif
=20
 struct blocking_notifier_head cgroup_lifetime_notifier =3D
@@ -901,6 +907,10 @@ static void css_set_skip_task_iters(struct css_set *cs=
et,
 		css_task_iter_skip(it, task);
 }
=20
+enum css_set_move_flags {
+	CSET_MOVE_USE_MG_TASKS	=3D (1 << 0),
+	CSET_MOVE_SKIP_LOCK	=3D (1 << 1),
+};
 /**
  * css_set_move_task - move a task from one css_set to another
  * @task: task being moved
@@ -918,13 +928,23 @@ static void css_set_skip_task_iters(struct css_set *c=
set,
  */
 static void css_set_move_task(struct task_struct *task,
 			      struct css_set *from_cset, struct css_set *to_cset,
-			      bool use_mg_tasks)
+			      enum css_set_move_flags flags)
 {
+	/*
+	 * Self task cannot move and clone concurrently and disassociation
+	 * doesn't modify task->cgroups that's relevant for clone
+	 */
+	bool skip_clone_lock =3D task =3D=3D current || to_cset =3D=3D NULL;
+	skip_clone_lock |=3D flags & CSET_MOVE_SKIP_LOCK;
+
 	lockdep_assert_held(&css_set_lock);
=20
 	if (to_cset && !css_set_populated(to_cset))
 		css_set_update_populated(to_cset, true);
=20
+	if (!skip_clone_lock)
+		write_lock(&css_set_clone_lock);
+
 	if (from_cset) {
 		WARN_ON_ONCE(list_empty(&task->cg_list));
=20
@@ -946,9 +966,13 @@ static void css_set_move_task(struct task_struct *task,
 		WARN_ON_ONCE(task->flags & PF_EXITING);
=20
 		cgroup_move_task(task, to_cset);
-		list_add_tail(&task->cg_list, use_mg_tasks ? &to_cset->mg_tasks :
-							     &to_cset->tasks);
+		list_add_tail(&task->cg_list,
+			      (flags & CSET_MOVE_USE_MG_TASKS) ? &to_cset->mg_tasks :
+								 &to_cset->tasks);
 	}
+
+	if (!skip_clone_lock)
+		write_unlock(&css_set_clone_lock);
 }
=20
 /*
@@ -2723,7 +2747,7 @@ static int cgroup_migrate_execute(struct cgroup_mgctx=
 *mgctx)
=20
 			get_css_set(to_cset);
 			to_cset->nr_tasks++;
-			css_set_move_task(task, from_cset, to_cset, true);
+			css_set_move_task(task, from_cset, to_cset, CSET_MOVE_USE_MG_TASKS);
 			from_cset->nr_tasks--;
 			/*
 			 * If the source or destination cgroup is frozen,
@@ -4183,7 +4207,9 @@ static void __cgroup_kill(struct cgroup *cgrp)
 	lockdep_assert_held(&cgroup_mutex);
=20
 	spin_lock_irq(&css_set_lock);
+	write_lock(&css_set_clone_lock);
 	cgrp->kill_seq++;
+	write_unlock(&css_set_clone_lock);
 	spin_unlock_irq(&css_set_lock);
=20
 	css_task_iter_start(&cgrp->self, CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THRE=
ADED, &it);
@@ -6696,14 +6722,15 @@ static int cgroup_css_set_fork(struct kernel_clone_=
args *kargs)
=20
 	cgroup_threadgroup_change_begin(current);
=20
-	spin_lock_irq(&css_set_lock);
+	read_lock(&css_set_clone_lock);
+
 	cset =3D task_css_set(current);
 	get_css_set(cset);
 	if (kargs->cgrp)
 		kargs->kill_seq =3D kargs->cgrp->kill_seq;
 	else
 		kargs->kill_seq =3D cset->dfl_cgrp->kill_seq;
-	spin_unlock_irq(&css_set_lock);
+	read_unlock(&css_set_clone_lock);
=20
 	if (!(kargs->flags & CLONE_INTO_CGROUP)) {
 		kargs->cset =3D cset;
@@ -6893,6 +6920,7 @@ void cgroup_post_fork(struct task_struct *child,
 	cset =3D kargs->cset;
 	kargs->cset =3D NULL;
=20
+	// XXX could this be read_lock(css_set_clone_lock) ?
 	spin_lock_irq(&css_set_lock);
=20
 	/* init tasks are special, only link regular threads */
@@ -6907,7 +6935,8 @@ void cgroup_post_fork(struct task_struct *child,
=20
 		WARN_ON_ONCE(!list_empty(&child->cg_list));
 		cset->nr_tasks++;
-		css_set_move_task(child, NULL, cset, false);
+		/* child cannot run (another) clone, skip lock */
+		css_set_move_task(child, NULL, cset, CSET_MOVE_SKIP_LOCK);
 	} else {
 		put_css_set(cset);
 		cset =3D NULL;
@@ -6995,7 +7024,7 @@ static void do_cgroup_task_dead(struct task_struct *t=
sk)
=20
 	WARN_ON_ONCE(list_empty(&tsk->cg_list));
 	cset =3D task_css_set(tsk);
-	css_set_move_task(tsk, cset, NULL, false);
+	css_set_move_task(tsk, cset, NULL, CSET_MOVE_SKIP_LOCK);
 	cset->nr_tasks--;
 	/* matches the signal->live check in css_task_iter_advance() */
 	if (thread_group_leader(tsk) && atomic_read(&tsk->signal->live))

--jz64ja35xy3hxb6p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaXtfExsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhtegEA6l9Y7FsU359p9zA2olK5
wC1nBypomRyC1keiWrjf5iEA/3pO4eeXEmnJChcl1mSnQEvtEi8Aw/aB7juDDY3a
jrQA
=KNxN
-----END PGP SIGNATURE-----

--jz64ja35xy3hxb6p--

