Return-Path: <cgroups+bounces-16532-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cH9lD7jZHWpsfQkAu9opvQ
	(envelope-from <cgroups+bounces-16532-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 21:12:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9272E6247A8
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 21:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 121B0302BB91
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 19:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5B73672A1;
	Mon,  1 Jun 2026 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="T+UOAqH9"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C007360EE1;
	Mon,  1 Jun 2026 19:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340854; cv=none; b=XR/nGWuLxROlnC5hYYguTcNu6WfIJdxhuz0195fgQfJnvUtkptqVz0RG/YEgPDOLh1V4s1hw9Qiv9MoWGNrv18vFPium1mxnbVI2eNfRsds1DV/63QIMQzgBSjRpTFLPNusK71t1BumqG1geSPC1c8N641gt+cPrbBAHU1IazJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340854; c=relaxed/simple;
	bh=FV6OsTzPhCWB+PkUCcu4Co6NJShUK9rxMxE+0ZQj1w0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gYlCgpjOIIhQrdA02a42kpGgm7C/j94N5wIB82eYuZ65D4VVLnnIodJo+X1tisNc8cDRfUZtuHCnkhf4eWMGSKl3Mn6RSlby9tdA+3Lj6ZXpCYGtxs13ZXDNZpRqQxCX+QPVpD7ipE97rCyKqLy7A2opIqFQLwEikdgIOrbRirU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=T+UOAqH9; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780340841; x=1780945641; i=spasswolf@web.de;
	bh=nXup5w7JPKReLo5qYob0BVyDwmCUAq2ZIruxsV1oLIY=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=T+UOAqH9ZFMIjSTU7P+pQL7pmi0SMnjreTNlzkybPt2Hrg94vj5hB4Dl99GnQoQI
	 chfy/Oy7dyDuZ98z2JY2PJ0CUIps8z3Zqqmmx+8xDdQiS/55C4NeftNojHDiK6nv4
	 FuLCJZ+P8ID4AvRW2q+FQVxbcIXilP7mh6n0rtMhe7jycORqp6K0o9o7yr4YI6+Js
	 jn3A9DFUoL7036g4FE4AyneRlAPrQUMFqvSdVys3HPAs6DFbzbkHPrvqil+qLSM0m
	 88HHklqmH6TEShjfjQGlqD6AGw/ejX/nAmbX2K9oeLwhIZAtItmCCA7IWGjWXtI/8
	 i6nr4J2GKoXgsEQH9Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFayq-1wVnCZ0TNu-00AKVS; Mon, 01
 Jun 2026 21:07:21 +0200
Message-ID: <a2602616eec07521be1f76508dfc2632c8c571de.camel@web.de>
Subject: Re: [PATCH] cgroup: Migrate tasks to the root css when a controller
 is rebound
From: Bert Karwatzki <spasswolf@web.de>
To: Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, spasswolf@web.de, Johannes Weiner	
 <hannes@cmpxchg.org>, Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, 
 Sebastian Andrzej Siewior	 <bigeasy@linutronix.de>, Petr Malat
 <oss@malat.biz>, kernel test robot	 <oliver.sang@intel.com>, Martin Pitt
 <martin@piware.de>, Aishwarya.TCV@arm.com
Date: Mon, 01 Jun 2026 21:07:19 +0200
In-Reply-To: <20260601190256.1815778-1-tj@kernel.org>
References: <a9f6c0bcd262e764453b95eb7397871825e11559.camel@web.de>
	 <20260601190256.1815778-1-tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+UzFA1omgt9qZ+uyc+VGhjExyvYGYJ8Ceezuh4GneiYtEJotyFp
 p5WdFbNY/EWHAs0hKQtvKWLYYrTFK+sJvf1zUE5iM09cRDRC3+8ottGtXGsXfF8dP+h9HBr
 MbR0V1yIwZe+KTchdDopOFbSNPI9ajUt+wJlgYroeZ4/IsPCHvRCqkOV8cZEA/lhwTPV1Md
 Wj6eh6H9d2S+WKkfhEvhw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TgPhYpR/QBk=;6APh9Pq0Vu0jPuZ3ExNUqE8vYZJ
 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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16532-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,web.de,cmpxchg.org,suse.com,linutronix.de,malat.biz,intel.com,piware.de,arm.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spasswolf@web.de,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[web.de];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9272E6247A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am Montag, dem 01.06.2026 um 09:02 -1000 schrieb Tejun Heo:
> cgroup_apply_control_disable() defers kill_css_finish() while a css is
> still populated, relying on css_update_populated() to fire the deferred
> kill once the populated count reaches zero.
>=20
> This deadlocks when a controller is rebound out of a hierarchy. Mounting
> an implicit_on_dfl controller such as perf_event as a v1 hierarchy steal=
s
> it off the default hierarchy, and rebind_subsystems() kills its
> per-cgroup csses while they are still populated. The migration run in th=
e
> same step keeps the old css for a controller no longer in the hierarchy'=
s
> mask, so no task is migrated off the dying csses. Their populated count
> never reaches zero, the deferred kill_css_finish() never fires, and the
> next cgroup_lock_and_drain_offline() hangs forever under cgroup_mutex.
>=20
> That migration is already a no-op pass over the rebound subtree. Add
> cgroup_rebind_ss_mask so find_existing_css_set() resolves the leaving
> controllers to the root css. Their tasks are migrated there, the
> per-cgroup csses depopulate, and cgroup_apply_control_disable() kills
> them synchronously. The deferral stays correct for the rmdir and
> controller-disable paths it was meant for.
>=20
> Fixes: 1dffd95575eb ("cgroup: Defer kill_css_finish() in cgroup_apply_co=
ntrol_disable()")
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/all/41cd159c-54e5-45e0-81df-eaf36a6c028e=
@sirena.org.uk/
> Reported-by: Bert Karwatzki <spasswolf@web.de>
> Closes: https://lore.kernel.org/all/4e986b4ed7e16547805d54b6e67d09120bc4=
d2f2.camel@web.de/
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> Hello, and thanks a lot for all the reproduction information. It made th=
is
> much easier to track down.
>=20
> Bert, Mark, would you mind giving this a try on your setups?
>=20
>  kernel/cgroup/cgroup.c | 35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index bdc8deedb4f7..7f4861109e48 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -197,6 +197,14 @@ static u32 cgrp_dfl_implicit_ss_mask;
>  /* some controllers can be threaded on the default hierarchy */
>  static u32 cgrp_dfl_threaded_ss_mask;
> =20
> +/*
> + * Set across rebind_subsystems() to the controllers leaving a hierarch=
y.
> + * Guarded by cgroup_mutex. Makes find_existing_css_set() resolve them =
to the
> + * root css so the affected tasks are migrated there before
> + * cgroup_apply_control_disable() kills the per-cgroup csses.
> + */
> +static u32 cgroup_rebind_ss_mask;
> +
>  /* The list of hierarchy roots */
>  LIST_HEAD(cgroup_roots);
>  static int cgroup_root_count;
> @@ -1083,7 +1091,15 @@ static struct css_set *find_existing_css_set(stru=
ct css_set *old_cset,
>  	 * won't change, so no need for locking.
>  	 */
>  	for_each_subsys(ss, i) {
> -		if (root->subsys_mask & (1UL << i)) {
> +		if (unlikely(cgroup_rebind_ss_mask & (1UL << i))) {
> +			/*
> +			 * @ss is leaving this hierarchy and its per-cgroup
> +			 * csses are about to be killed. Resolve to the
> +			 * surviving root css so the tasks are migrated there.
> +			 */
> +			template[i] =3D cgroup_css(&root->cgrp, ss);
> +			WARN_ON_ONCE(!template[i]);
> +		} else if (root->subsys_mask & (1UL << i)) {
>  			/*
>  			 * @ss is in this hierarchy, so we want the
>  			 * effective css from @cgrp.
> @@ -1853,11 +1869,17 @@ int rebind_subsystems(struct cgroup_root *dst_ro=
ot, u32 ss_mask)
>  		struct cgroup *scgrp =3D &cgrp_dfl_root.cgrp;
> =20
>  		/*
> -		 * Controllers from default hierarchy that need to be rebound
> -		 * are all disabled together in one go.
> +		 * Controllers leaving the default hierarchy are disabled
> +		 * together. cgroup_rebind_ss_mask makes cgroup_apply_control()
> +		 * migrate their tasks to the root css, so the per-cgroup csses
> +		 * are unpopulated when cgroup_finalize_control() kills them.
> +		 * Clear it before cgroup_finalize_control(), which does no
> +		 * css_set lookup.
>  		 */
>  		cgrp_dfl_root.subsys_mask &=3D ~dfl_disable_ss_mask;
> +		cgroup_rebind_ss_mask =3D dfl_disable_ss_mask;
>  		WARN_ON(cgroup_apply_control(scgrp));
> +		cgroup_rebind_ss_mask =3D 0;
>  		cgroup_finalize_control(scgrp, 0);
>  	}
> =20
> @@ -1871,9 +1893,14 @@ int rebind_subsystems(struct cgroup_root *dst_roo=
t, u32 ss_mask)
>  		WARN_ON(!css || cgroup_css(dcgrp, ss));
> =20
>  		if (src_root !=3D &cgrp_dfl_root) {
> -			/* disable from the source */
> +			/*
> +			 * Disable from the source, migrating its tasks to the
> +			 * root css first (see cgroup_rebind_ss_mask).
> +			 */
>  			src_root->subsys_mask &=3D ~(1 << ssid);
> +			cgroup_rebind_ss_mask =3D 1 << ssid;
>  			WARN_ON(cgroup_apply_control(scgrp));
> +			cgroup_rebind_ss_mask =3D 0;
>  			cgroup_finalize_control(scgrp, 0);
>  		}
> =20

I'll try this right away, but I found out another thing. My real problem s=
eems
to be the perf_event test, the test after perf_events hangs, no matter wha=
t
test I run:

cgroup_fj_function_perf_event: pass  (0.206s)
cgroup_core01: HANG=20

Bert Karwatzki

