Return-Path: <cgroups+bounces-15528-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNvDOflo8GkITAEAu9opvQ
	(envelope-from <cgroups+bounces-15528-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 09:59:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A28747F797
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 09:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91C53300B9D0
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 07:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6813B3101A2;
	Tue, 28 Apr 2026 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RqtvEQIe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B367301704
	for <cgroups@vger.kernel.org>; Tue, 28 Apr 2026 07:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777363121; cv=none; b=ggOfNJjPWYj50HtDdckoJlBQWsyOMvGiCcqnLChQWjP7dcw5RxK83MUha6Wu6C/12OJv2CI/HT670kTGpOvFWJEjBe8qJedIZ50WAhiMGlX6GOgYCPVK81XzH4ipBwxIdhg1OC6PHkRBACawmEGRdQ8W85lJ5QXLZAUi2x6a7iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777363121; c=relaxed/simple;
	bh=ZdxLpRAvrey223q59Wjm8MO81du/WkAqqYDf+kSiL60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unaK0sWtJJdcdCqVycdGg83EwrdSUSV0s8THLicaGm5SiAODYuN/nfxyeR1HawR5ZNZ8b3rD87JCljDTr7e+sAJvHpaXldHSXPolN6HKfAHXNWRUJUTzwmG9b6pvpJVwc0uMnWdjB7116t3UF+dtaptGTU/RQ3dhjTvJbBHiJr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RqtvEQIe; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43fe62837baso6433175f8f.3
        for <cgroups@vger.kernel.org>; Tue, 28 Apr 2026 00:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777363118; x=1777967918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qagrd0tizvJjaLYUYS0sYCos+nfO9AiOSWAVzoIEd+Y=;
        b=RqtvEQIeHwu1UHw50y9bGDvymuf5R3u+zf08I7L3/T4BxB7L4vdox8hImx/vGEAbVx
         9pXk7WtZFSLEEBClhansU+n8kfP/H1pViMZ8n0k/maPszR6REmpcqjcPH7nQ/MjR88hX
         lpaQ9wNfi6yLxWrm1Yt6dFS9OToghrux8ILsYepTeRZqU4g2W69PwjV58MqXSWr0ZeNk
         +jbTGL2CDIrtV/pyVeyUPxMkMGoB5QCLrUYjquMQt2j6bboEqWzCIF8nG2EVaU6FsVy2
         1qtpzMS73pA+rGTiil5N1HRGy8l+7ho4NUtAP515rvZgGFyjkI0y5G9AJ1YczPVl8q+G
         BnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777363118; x=1777967918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qagrd0tizvJjaLYUYS0sYCos+nfO9AiOSWAVzoIEd+Y=;
        b=EjGjtQg7mV4TaxePH7ZW9nYCUAboVNRLgSxDIbbCAi5268QG1Mu5OJKl563t8TIyle
         Y7uU8otOl9q5vkpmPF/jrOt3iZj4QamS9zXa1GwtGzPiciD5HUaJDuOrsiJCs483ooA0
         qXXLJwcp0avP4NvlMWxbAHWrT8XTtcK67aosN+yla7lNGHA7C2AyCfNXsx9uxrh1SdC3
         J8cQCn7006O0DmWm5DQVnYlqWGwGnzYTcRK1o0lV5/AjScizBZsF5Zk4kQCWyRM2nJso
         OZTGozsVZvmVsNHjbjQuoQ6FLNXqcw6HsX2YoKisI1HG2WyHW7fXmRI2H/icl3rtOhTv
         NYSw==
X-Forwarded-Encrypted: i=1; AFNElJ/xpH9+1CM5nKhuwLAE0PAIpNQmrWvJqNMwl1Bg30CgATMhohy5FUh9e9Po+ohM8JOCAbn35+0o@vger.kernel.org
X-Gm-Message-State: AOJu0YwPRcingXlKaN7JVysv4NyA6+27Z8ybXkun9fAZNU3EcUU2FHk3
	Tezq3fYZuLHzZbLHAVNCLiBF18NP/VpxBPHz45LBHQAbo4MToYq5HpILuxEXcsVxJ14=
X-Gm-Gg: AeBDievg/75kHkTlStbBnRnrTv/KB7unciGPxwNdcxBKfxve64YJpoafu+MaQxXRVot
	ECaRkzu+Ii5kNqXywx4g8grtpd3mBb1NVnXnJlYvwD72PZCpiwLX/rioiYzh+O95kmO7smCy2+6
	ItDroFnXAnq8HMsu0c7WScDewfJICa15xKKdYzcfsCb0KrC2tPHYEjMG/5uX01FCx6NYPDnuiP4
	aX0iw08VMIlB5dENz8w7r+S7djzYXDDHYOTc9yGnDEPTiSQkooA50yENKSbefYJqsb63uFBKiO4
	ERLYODmsckV6+JOaTzU5sWZ1OxcZ4fgWbIznLYyF+q3qCrj6/efK/ceJfGIxlf0OWoEKB2bT0O0
	Yzmnld0tpJrMeHmnI/0IJiBPaqjRd4BdY52LU7/migBswlj2hkyTeHaqGckf3dyLQ5jZ7HJ0zP7
	6uYNDk9p+sLbqfqjQaQu4ALw6e19fVSV/0vBV1uCpUxB9hZIdo+6mIoA7k5NI=
X-Received: by 2002:a05:6000:2212:b0:43f:e413:43ae with SMTP id ffacd0b85a97d-446448b900emr3496914f8f.0.1777363117896;
        Tue, 28 Apr 2026 00:58:37 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463f5b50c1sm4186489f8f.17.2026.04.28.00.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:58:37 -0700 (PDT)
Date: Tue, 28 Apr 2026 09:58:35 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huawei.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Xie Maoyi <maoyi.xie@ntu.edu.sg>
Subject: Re: [PATCH] cgroup/cpuset: Creating or adding CPUs to partition not
 allowed without privilege
Message-ID: <7so4b76wg2apwwk3yh76q42jgwnpvlv7sursmsmzeyefhp4pbt@thybpp4litm6>
References: <20260428033439.783246-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v7j7lm3upsqvk6fp"
Content-Disposition: inline
In-Reply-To: <20260428033439.783246-1-longman@redhat.com>
X-Rspamd-Queue-Id: 3A28747F797
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15528-lists,cgroups=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]


--v7j7lm3upsqvk6fp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/cpuset: Creating or adding CPUs to partition not
 allowed without privilege
MIME-Version: 1.0

Hi Waiman.

On Mon, Apr 27, 2026 at 11:34:39PM -0400, Waiman Long <longman@redhat.com> =
wrote:
> Creation of a cpuset partition or adding more CPUs to an existing
> partition will take CPUs away from other cpusets outside of the
> partition leaving less CPUs for the others. So it is a privileged
> operation that non-privileged users shouldn't be allowed to do.
>=20
> Currently, remote partition code has check for CAP_SYS_ADMIN capability
> before allowing such operations, but not for local partition.

Remote partitions need such a check because their CPUs are sourced from
the global supply (top level) without=20

> This leaves a security hole in case cpuset.cpus.partition of a cpuset
> is chown'ed to a non-root user and its parent cpuset happens to be a
> partition root.

I wouldn't say this difference between remote and local partitions is a
security hole [1].

Consider this -- cgroup a is created by root (admin) and its resources
are constrained by root's policy. However, what happens in a subtree is
irrelevant from that top level view.

# setup			// owner
a/cpuset.partition=3Droot	// root
a/cpuset.cpus=3D0-3	// root
a/cgroup.procs		// user, they can organize subtree as needed

For example the user may want to create a (sub)partition with some of
the CPUs they got:

user$ mkdir a/b

a/b/cpuset.partition=3Droot	// user
a/b/cpuset.cpus=3D0-1		// user

This should be a valid configuration and behavior, no?

Thanks,
Michal


[1] And thanks to the need of cpuset.cpus.exclusive chain down the tree,
    the capability check for remote partitions may be too restrictive
    too. But I don't not plead for its removal now.

--v7j7lm3upsqvk6fp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCafBolxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AjUaQD/WWAf7wbM6SpsqgVsTUGg
g0IHvtsWG+gcAF7OSxg8BaAA/3tsjCKLTBgl9yGrabUcfcBzpM3PrGtwFSexQPAC
Lj0E
=1WQo
-----END PGP SIGNATURE-----

--v7j7lm3upsqvk6fp--

