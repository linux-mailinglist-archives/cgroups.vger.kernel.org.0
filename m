Return-Path: <cgroups+bounces-14818-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHDRChRLtGk4kAAAu9opvQ
	(envelope-from <cgroups+bounces-14818-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 18:36:20 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 830982882CE
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 18:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADDF13255D8A
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 17:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76169241665;
	Fri, 13 Mar 2026 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QfPgFXCO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1543CCFDB
	for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773423200; cv=none; b=pVMVLfcwxNdVabs1J2mtvUAVt3knLM6SacLIG/xvcK3KS5bii3trTxiouk5x/hqUEXjBn8LqNosZeJ96q9Ph0pUFbyhjNBZLCg32LYxqEyIvqlC+LYDjXU6Ky6+e/YnzNdYB2z1LTy8zcELQU1nBUWqgbUgdmlQ/mf8mTpdZ9N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773423200; c=relaxed/simple;
	bh=1FvDrns+VIGibt6LZ2i1UDMFhT9gPnHDIu+JbLlvxuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYyoEnV4AnNjByJQyZ89USLfGt4CWj/bNcpiM2kzq3l7MWNNgXjQDmxPOxT6LDbKJDHtF7sF11OkMFo35tPrfgpHDR4aW96pAKnxj2LwpTbPd3yEyv+++KKZ8pa2CJ6pJ9DlvwIAscwHIMkp3FRKT8o8U8riWucN/apAc+trRt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QfPgFXCO; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439c944bb62so2005716f8f.3
        for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 10:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773423196; x=1774027996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VJae3vdCXODBTLWKk6GJMYHIzIpo0Y/QKoeFPWW1RnQ=;
        b=QfPgFXCOkyhAvoqEjfDEPs+kIc38kCq3u7ZeHtUPoyalR8YqVCxX6rwDYjJcgi8uhB
         S139Wm7ZoOnUZBWNOXKS4W0gszQJHNVQls0HK/IMHJ/msIU+eeFsdI8Ph/IDh0QlCo88
         Byq6+iOZxzDOwUuofhXkeaEljle9d9VzHGpazw8+NYbRrT0y0D0EnPJq2D61bgHyrz3t
         VI+qOMSUlNG3ksEEcwa+YS1xuUR4hP8vKhxxRhl4DqB/hKEwbvX7LFhc9fboU9N4XD4o
         Pncwv5J1mGLHMbNoT2VuIdgDDxErdIj+WYpruBa2g4tUY52SfqPCaV0TMoTHEWN3smDN
         jiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773423196; x=1774027996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJae3vdCXODBTLWKk6GJMYHIzIpo0Y/QKoeFPWW1RnQ=;
        b=i4xsNkZbu14aopacmSp4O4QuQeBRnxvRhRQaXJki84YQP9zmeLwexf4JMkeHyT1HQv
         aN855lQC0z/VYHsCy5oNtDDDzZ4iQbDHRwxoO/N0clVdTue4fk8rCRv0eKyAVdjrdB0e
         KGvGYr6daJWGMPxjlM7g3WzRRmO+WQT1yXAWmN7Jm8ceFX4lN8g3ndm+oz03IiHoucue
         w3mff0mc80JZB+L09eFPV5sqysmXD2fTQ++PpCK8j/gzuFiyPM3iuTqZUJSLjqvXdr4H
         bC0nk4qTxgBg+qfhf/6KTOZNS51zQhPvVLu5S1j6a4NDeYHximC24Hk783xhq+bobW6o
         bKCg==
X-Gm-Message-State: AOJu0YwawpwvSZuYsxJkjOxbRTGLqHMsS7HUa2ktqyj1Gpflltk/MM3e
	BcB5lC03dnBGOdj6HPodkThT8KR1yGgrjCktPvY/C6jGU3Ojdj/ZjDFjrzrgzaF12tk=
X-Gm-Gg: ATEYQzwGllp03/xz/oldKodOzSzQqIEMsHhwMP8Q7KCE+a/TWCvKxb8NNtJsODUGde0
	9zIrN/eMqsEJfE65vOQtoFWGbrFqqydgn8RxyQrmrIWMbd1/keX9w70e2irzMKa0x7SFjQ7rbd0
	UlGpI/ZO8GZ7AUicK7M8UhmFUu8JlSK79XSNQ7gGouMt0MMCs7/qlxGpN7PNtLL5eRspvuzkdpn
	Zo7rIZjPZFLx2SDuQJm7+o6YRrc6vUC0uiYj4Ltp+VT+3Y1LpEKQ7d1uJhfkHOVz5G+MAMx5R9n
	rMBMWbAYWJdcWHUmYDKAuvLulDlNFr1lyDPZannemdYauUEz8wvpHSSWycEDATbXsMNzFwKqTt5
	io6M3pqFD6l8dS97oG9VdpYPmFSB7SJkmGocNK7MOdEE/UZdgHOYaekI6pMrCEYpwIJpHHz1Oup
	3M9KvjGLZGF8/Vd25j3GnC4Ewm095ygVpTmgnDKAyQI0+ipYX7vNiFFQ==
X-Received: by 2002:a05:6000:1787:b0:439:c677:5145 with SMTP id ffacd0b85a97d-43a04d880e8mr8009601f8f.22.1773423196103;
        Fri, 13 Mar 2026 10:33:16 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43a03cfd18fsm10687099f8f.36.2026.03.13.10.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 10:33:15 -0700 (PDT)
Date: Fri, 13 Mar 2026 18:33:14 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: cgroups@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Ben Segall <bsegall@google.com>, Clark Williams <clrkwllms@kernel.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] cgroup: Move cgroup_task_dead() to task_struct clean up
Message-ID: <ydymxaffr2s7npif37msq5q467m2ql26ib6wifwoztuhqmg4ao@id5c532lhorb>
References: <20260311120829.rEHY-xh9@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="icf7bhdyxkpgumzx"
Content-Disposition: inline
In-Reply-To: <20260311120829.rEHY-xh9@linutronix.de>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14818-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: 830982882CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--icf7bhdyxkpgumzx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup: Move cgroup_task_dead() to task_struct clean up
MIME-Version: 1.0

Hello.

On Wed, Mar 11, 2026 at 01:08:29PM +0100, Sebastian Andrzej Siewior <bigeas=
y@linutronix.de> wrote:
> @@ -7084,6 +7031,7 @@ void cgroup_task_free(struct task_struct *task)
>  {
>  	struct css_set *cset =3D task_css_set(task);
> =20
> +	cgroup_task_dead(task);
>  	if (!list_empty(&task->cg_list)) {
>  		spin_lock_irq(&css_set_lock);
>  		css_set_skip_task_iters(task_css_set(task), task);

Erm, isn't this way too late?
I see that cset->dying_tasks is appended in do_cgroup_task_dead() (which
I was used to find in cgroup_exit()).

(Also, whole cgroup_task_dead() becomes single use thing so it could be
open-coded in the place where it belongs.)

Thanks,
Michal

--icf7bhdyxkpgumzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCabRKUxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AhC+wD6AwoXxqDMnAvLA0fFaR3n
RBbBzz+2eCAG2EiT+fz0vMwBAPJW2izPg9m5qc1JgR/a4wkmjgFaAPU3uckGFNu8
R/IP
=fA8G
-----END PGP SIGNATURE-----

--icf7bhdyxkpgumzx--

