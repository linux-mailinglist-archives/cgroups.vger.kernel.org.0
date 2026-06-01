Return-Path: <cgroups+bounces-16533-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QD2fOKjiHWoPfwkAu9opvQ
	(envelope-from <cgroups+bounces-16533-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 21:51:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9F9624C90
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 21:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 150143012276
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 19:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C023812F2;
	Mon,  1 Jun 2026 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="b+2bAmOL"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A172236E0;
	Mon,  1 Jun 2026 19:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780343452; cv=none; b=imhWIJGYekrk0/Dq/TrQRUoO7P46vb14leN9zlRkKMNvlizd/AV3pOH6xW24taodyml+RDAUUmN70xZU41BaqsrGoPwP1TilKhJ0+Xn5sRBWPCNHtsSFjnnj0HI8H2fJxoi1QJmqUG4PKaF/oNZD/Pwz9wu9Imm+Uz3lDnemOfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780343452; c=relaxed/simple;
	bh=YCZUBDgLKbXvdGJKXGqAH2YjatTTYaPhjWooGwyti0U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u2AiGhLVt3ToK2pWIaOnOSlcCsIzy38ObZgIS9UvaGvDJ1G8WrUwn9gXLVQtjOBmSZPL0ydlWNSQtLWFa+waEkp6IsDqM09u90aSIlAi01W2VOcWqFjCj8nrEzPtCurluYD3groV1l0tcsmO1gGAj/ry2hsI2znSkRiHRPIKkkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=b+2bAmOL; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780343412; x=1780948212; i=spasswolf@web.de;
	bh=gvDdvUgWHcvBAQb46Ha5FY2/dd4fQqbw3DL/6s/kMq8=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=b+2bAmOLvcSjkuakdGJbdfqxPFNYgwUqUuPyHSoiNf94qAstQeYMJmLe68gX3uam
	 KYsM208HYKceipFTz1F6PvOHJdpYwsV97mltLTaPgCgOn9p9N4i7ZDeocNJ8fuRG2
	 yvgXbiAJDtKuIYU4+8lE9Dhtq16ud3hfM7Ar3IkxPXgR2HANigzBMCjEpHClzM1Ma
	 yMT1pzncmKHU9GObXPDx25NZQFBIsMUH3X1x2DBmWqrXqSVakmje32l/Q2Q51dOUD
	 /Cl7NBiksm5p8dFndEu2wqPBTH+xT2mIjQMj53WB4pnYHMZWLgF4JlTT5UJgA9M08
	 BQQ92BjUuU45oSKJpw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTOlk-1wr98i1NXQ-00PcU4; Mon, 01
 Jun 2026 21:50:12 +0200
Message-ID: <056b51878b4b720087e86f50e4ad46f6f31e205b.camel@web.de>
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
Date: Mon, 01 Jun 2026 21:50:10 +0200
In-Reply-To: <a2602616eec07521be1f76508dfc2632c8c571de.camel@web.de>
References: <a9f6c0bcd262e764453b95eb7397871825e11559.camel@web.de>
		 <20260601190256.1815778-1-tj@kernel.org>
	 <a2602616eec07521be1f76508dfc2632c8c571de.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xbFwrr3NPR+qzd7pjqcrMh2/n7dRAXViQYC328Aa8+wYWUlW5HN
 UG0/bCUWnhpaRjHJ3kunnU4NJj+bMRPCMahIHj83KE2z8BekbwRrsFzHriyM7tTDjGSkD5E
 OJfcruWYsMWkK5T+8hvlrhTg7nRxyaIlhWsoe7zaHEpkCuEJUJU4gWkidEKzwNClymcBeKY
 0fhfWTj/MpW2fYwdwAFKA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZsUoNbZzZpM=;h+sXaOOxZMduDE09KVTrSTAKSOp
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
	TAGGED_FROM(0.00)[bounces-16533-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 3E9F9624C90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am Montag, dem 01.06.2026 um 21:07 +0200 schrieb Bert Karwatzki:
> Am Montag, dem 01.06.2026 um 09:02 -1000 schrieb Tejun Heo:
> > cgroup_apply_control_disable() defers kill_css_finish() while a css is
> > still populated, relying on css_update_populated() to fire the deferre=
d
> > kill once the populated count reaches zero.
> >=20
> > This deadlocks when a controller is rebound out of a hierarchy. Mounti=
ng
> > an implicit_on_dfl controller such as perf_event as a v1 hierarchy ste=
als
> > it off the default hierarchy, and rebind_subsystems() kills its
> > per-cgroup csses while they are still populated. The migration run in =
the
> > same step keeps the old css for a controller no longer in the hierarch=
y's
> > mask, so no task is migrated off the dying csses. Their populated coun=
t
> > never reaches zero, the deferred kill_css_finish() never fires, and th=
e
> > next cgroup_lock_and_drain_offline() hangs forever under cgroup_mutex.
> >=20
> > That migration is already a no-op pass over the rebound subtree. Add
> > cgroup_rebind_ss_mask so find_existing_css_set() resolves the leaving
> > controllers to the root css. Their tasks are migrated there, the
> > per-cgroup csses depopulate, and cgroup_apply_control_disable() kills
> > them synchronously. The deferral stays correct for the rmdir and
> > controller-disable paths it was meant for.
> >=20
> > Fixes: 1dffd95575eb ("cgroup: Defer kill_css_finish() in cgroup_apply_=
control_disable()")
> > Reported-by: Mark Brown <broonie@kernel.org>
> > Closes: https://lore.kernel.org/all/41cd159c-54e5-45e0-81df-eaf36a6c02=
8e@sirena.org.uk/
> > Reported-by: Bert Karwatzki <spasswolf@web.de>
> > Closes: https://lore.kernel.org/all/4e986b4ed7e16547805d54b6e67d09120b=
c4d2f2.camel@web.de/
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > ---
> > Hello, and thanks a lot for all the reproduction information. It made =
this
> > much easier to track down.
> >=20
> > Bert, Mark, would you mind giving this a try on your setups?
> >=20
> >  kernel/cgroup/cgroup.c | 35 +++++++++++++++++++++++++++++++----
> >  1 file changed, 31 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > index bdc8deedb4f7..7f4861109e48 100644
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -197,6 +197,14 @@ static u32 cgrp_dfl_implicit_ss_mask;
> >  /* some controllers can be threaded on the default hierarchy */
> >  static u32 cgrp_dfl_threaded_ss_mask;
> > =20
> > +/*
> > + * Set across rebind_subsystems() to the controllers leaving a hierar=
chy.
> > + * Guarded by cgroup_mutex. Makes find_existing_css_set() resolve the=
m to the
> > + * root css so the affected tasks are migrated there before
> > + * cgroup_apply_control_disable() kills the per-cgroup csses.
> > + */
> > +static u32 cgroup_rebind_ss_mask;
> > +
> >  /* The list of hierarchy roots */
> >  LIST_HEAD(cgroup_roots);
> >  static int cgroup_root_count;
> > @@ -1083,7 +1091,15 @@ static struct css_set *find_existing_css_set(st=
ruct css_set *old_cset,
> >  	 * won't change, so no need for locking.
> >  	 */
> >  	for_each_subsys(ss, i) {
> > -		if (root->subsys_mask & (1UL << i)) {
> > +		if (unlikely(cgroup_rebind_ss_mask & (1UL << i))) {
> > +			/*
> > +			 * @ss is leaving this hierarchy and its per-cgroup
> > +			 * csses are about to be killed. Resolve to the
> > +			 * surviving root css so the tasks are migrated there.
> > +			 */
> > +			template[i] =3D cgroup_css(&root->cgrp, ss);
> > +			WARN_ON_ONCE(!template[i]);
> > +		} else if (root->subsys_mask & (1UL << i)) {
> >  			/*
> >  			 * @ss is in this hierarchy, so we want the
> >  			 * effective css from @cgrp.
> > @@ -1853,11 +1869,17 @@ int rebind_subsystems(struct cgroup_root *dst_=
root, u32 ss_mask)
> >  		struct cgroup *scgrp =3D &cgrp_dfl_root.cgrp;
> > =20
> >  		/*
> > -		 * Controllers from default hierarchy that need to be rebound
> > -		 * are all disabled together in one go.
> > +		 * Controllers leaving the default hierarchy are disabled
> > +		 * together. cgroup_rebind_ss_mask makes cgroup_apply_control()
> > +		 * migrate their tasks to the root css, so the per-cgroup csses
> > +		 * are unpopulated when cgroup_finalize_control() kills them.
> > +		 * Clear it before cgroup_finalize_control(), which does no
> > +		 * css_set lookup.
> >  		 */
> >  		cgrp_dfl_root.subsys_mask &=3D ~dfl_disable_ss_mask;
> > +		cgroup_rebind_ss_mask =3D dfl_disable_ss_mask;
> >  		WARN_ON(cgroup_apply_control(scgrp));
> > +		cgroup_rebind_ss_mask =3D 0;
> >  		cgroup_finalize_control(scgrp, 0);
> >  	}
> > =20
> > @@ -1871,9 +1893,14 @@ int rebind_subsystems(struct cgroup_root *dst_r=
oot, u32 ss_mask)
> >  		WARN_ON(!css || cgroup_css(dcgrp, ss));
> > =20
> >  		if (src_root !=3D &cgrp_dfl_root) {
> > -			/* disable from the source */
> > +			/*
> > +			 * Disable from the source, migrating its tasks to the
> > +			 * root css first (see cgroup_rebind_ss_mask).
> > +			 */
> >  			src_root->subsys_mask &=3D ~(1 << ssid);
> > +			cgroup_rebind_ss_mask =3D 1 << ssid;
> >  			WARN_ON(cgroup_apply_control(scgrp));
> > +			cgroup_rebind_ss_mask =3D 0;
> >  			cgroup_finalize_control(scgrp, 0);
> >  		}
> > =20
>=20
>=20
> Bert Karwatzki

Your fix works for me. No more hangs after cgroup_fj_function_perf_event i=
s run.
Let's hope this solves Mark's problems, too.

Tested-By: Bert Karwatzki <spasswolf@web.de>

Bert Karwatzki

