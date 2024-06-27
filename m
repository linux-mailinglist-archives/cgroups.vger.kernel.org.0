Return-Path: <cgroups+bounces-3391-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF02391A2EC
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 11:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33138B22763
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 09:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E832F132492;
	Thu, 27 Jun 2024 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XfRHWX7c";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XfRHWX7c"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AEA4D5BD;
	Thu, 27 Jun 2024 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719481575; cv=none; b=OaJPpOrYroFRQHHht6MfzDEhqbXlTKOk8tW0YcxlhNQYs4lCyTKkYeolli/GlRoFgzVFBJx/dEaKecWqBMGPt+erZ5+5SQ7ODkTzbB7RKJEX3052KC3MY+bWTQQMcETlZ75sBDtceUHp6AFDZ9/PCGOBen+jX+J26gweSK33AbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719481575; c=relaxed/simple;
	bh=Vc1FxFKKZ4kIsqe09jMpdFUU4Nj/L8/uAl6xy6PikB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/bX9/hfKr6xLO/KIoRTyaH4lUCCC+82i5MwZPcMI1x5XFEGeuJCBCuAZ1yjfFOyR9Sxrv4P1FcPZiLUKH72nwVwI18HmHlxao06iglOxjqV/z1+efA4nbDhaUhv+odIthCKSx7uNqULTLWrKZCvP35B85skh9qqISob7M2H/bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XfRHWX7c; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XfRHWX7c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 924C221B7E;
	Thu, 27 Jun 2024 09:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719481571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jj9AAp3ne/E3keslQqD3JpnbJj5OzPPBYKAv+9+i9rI=;
	b=XfRHWX7cglF3W8E5nX9gSJv7E5pesHihnyJUsMKYEJeKevKm0ZL/gG4dxG9FXnptwZsTLi
	6WF7OGpdDftTUgrrNRmdqEuPfdQ3pwr+uZ6FegT1R/8s1kTZuvf6Tb9U0ZBqL5YFbVzQte
	W5YSmOo9gicDgDfV5cZJ3b/3ey4IvlM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=XfRHWX7c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719481571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jj9AAp3ne/E3keslQqD3JpnbJj5OzPPBYKAv+9+i9rI=;
	b=XfRHWX7cglF3W8E5nX9gSJv7E5pesHihnyJUsMKYEJeKevKm0ZL/gG4dxG9FXnptwZsTLi
	6WF7OGpdDftTUgrrNRmdqEuPfdQ3pwr+uZ6FegT1R/8s1kTZuvf6Tb9U0ZBqL5YFbVzQte
	W5YSmOo9gicDgDfV5cZJ3b/3ey4IvlM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 824E7137DF;
	Thu, 27 Jun 2024 09:46:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EEtfH+M0fWbFIAAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Thu, 27 Jun 2024 09:46:11 +0000
Date: Thu, 27 Jun 2024 11:46:10 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	longman@redhat.com, adityakali@google.com, sergeh@kernel.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] cgroup/cpuset: Prevent UAF in proc_cpuset_show()
Message-ID: <6mjie6enbm5ltei4fsanz64ofukbr4gvss7ywi5sjfjxjxing7@efuhtnqvfawd>
References: <20240626094101.472912-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kwcaihwcr7zw77fe"
Content-Disposition: inline
In-Reply-To: <20240626094101.472912-1-chenridong@huawei.com>
X-Spamd-Result: default: False [-8.11 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 924C221B7E
X-Spam-Flag: NO
X-Spam-Score: -8.11
X-Spam-Level: 


--kwcaihwcr7zw77fe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 09:41:01AM GMT, Chen Ridong <chenridong@huawei.com>=
 wrote:
> An UAF can happen when /proc/cpuset is read as reported in [1].
>=20
> This can be reproduced by the following methods:
> 1.add an mdelay(1000) before acquiring the cgroup_lock In the
>  cgroup_path_ns function.
> 2.$cat /proc/<pid>/cpuset   repeatly.
> 3.$mount -t cgroup -o cpuset cpuset /sys/fs/cgroup/cpuset/
> $umount /sys/fs/cgroup/cpuset/   repeatly.
>=20
> The race that cause this bug can be shown as below:
>=20
> (umount)		|	(cat /proc/<pid>/cpuset)
> css_release		|	proc_cpuset_show
> css_release_work_fn	|	css =3D task_get_css(tsk, cpuset_cgrp_id);
> css_free_rwork_fn	|	cgroup_path_ns(css->cgroup, ...);
> cgroup_destroy_root	|	mutex_lock(&cgroup_mutex);
> rebind_subsystems	|
> cgroup_free_root 	|
> 			|	// cgrp was freed, UAF
> 			|	cgroup_path_ns_locked(cgrp,..);

Thanks for this breakdown.

> ...
> Fix this problem by using rcu_read_lock in proc_cpuset_show().
> As cgroup root_list is already RCU-safe, css->cgroup is safe.
> This is similar to commit 9067d90006df ("cgroup: Eliminate the
> need for cgroup_mutex in proc_cgroup_show()")

Apologies for misleading you in my previous message about root_list.
As I look better at proc_cpuset_show vs proc_cgroup_show, there's a
difference and task_get_css() doesn't rely on root_list synchronization.

I think it could go like this (with my extra comments)

	rcu_read_lock();
	spin_lock_irq(&css_set_lock);
	css =3D task_css(tsk, cpuset_cgrp_id); // css is stable wrt task's migrati=
on thanks to css_set_lock
	cgrp =3D css->cgroup; // whatever we see here, won't be free'd thanks to R=
CU lock and cgroup_free_root/kfree_rcu
	retval =3D cgroup_path_ns_locked(cgrp, buf, PATH_MAX,
				       current->nsproxy->cgroup_ns);
	...

Your patch should work thanks to the rcu_read_lock and
cgroup_free_root/kfree_rcu and the `if (css->cgroup)` guard is
unnecessary.

So the patch is a functional fix, the reasoning in commit message is
little off. Not sure if Tejun rebases his for-6.10-fixes (with a
possible v4), full fixup commit for this may not be worthy.

Michal


--kwcaihwcr7zw77fe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZn003wAKCRAt3Wney77B
SanmAQC+BClDX+SIYfecEqNibSmzoe/yog4Ca+xRk1HMt39vcAEA+ZVJ66ekm3kZ
ZS9DDuzmjib9QKbmvBM7unrDKpsEvgQ=
=J1g9
-----END PGP SIGNATURE-----

--kwcaihwcr7zw77fe--

