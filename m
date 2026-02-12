Return-Path: <cgroups+bounces-13893-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNkBEuGqjWkK5wAAu9opvQ
	(envelope-from <cgroups+bounces-13893-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 11:26:41 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6887812C773
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 11:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFFF5300B458
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 10:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E41F2DEA87;
	Thu, 12 Feb 2026 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XeviEHRC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43312DB797
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770891995; cv=none; b=TE3Y+oOgl8/kbU5f1xTebi3KOP/sJcNQdPIflJVxjRPWo1Fm9zfVqiSAGNNXJJNRKYacz0b6BuDOFFpEWbY8SpSdo6/DVsOFPfQaDOrVkOkIWBm7yJm4CiO1s50/Nltuk+dUVproZkDhJQzmesHI4WjDyhX04CzBUMcKIMEyS4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770891995; c=relaxed/simple;
	bh=7lrT8ca/WW4Fm/idiqIKhyx8k+KZaFJexiXo1fc8v4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nx7UKXeruOtN3BSFbae7kpUfoV74Hh5fs5/LBxRGb/CnTaf3yu/tUEwH+VTdeCiX8sxEmmHHccJqslvFgPNEfFmNSyHAV4O3fp0l5G18aLmy1VzIF7M+zOFn+CesvdrCqUgYCtXLZ3NC0R4WzwD8PFFFJvPbm24dvGlsCE5pAwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XeviEHRC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47ee0291921so60532135e9.3
        for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 02:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770891992; x=1771496792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7lrT8ca/WW4Fm/idiqIKhyx8k+KZaFJexiXo1fc8v4A=;
        b=XeviEHRC0jHKRw4rabMzgU0YH/t55Fsgv7e6WAZ/Dp723wmXcbRzIHabp2iXNCSwPE
         VPLGQ/AWk7uwYdoCwomsRU3IYLaCjW4q1vMFhOA4ifIDBJvka6pN9Q62PKJr2EaQdN3S
         xSHTi42hSU6XsLCvBcVzv2cesb2euWd+ymyMPPtkAFg02cQmDVVVj7YfyYGZlmHJILNt
         +4TskdTs3Bj+qIgydhOw1oehc5Qdr3ZT657E0FbvtrQA4Dok9DLt/0AtSuQKmJpYnAnf
         A36p5zlLYuX6CP154HSRmWrUXw+TU6hwk2hjaNIUKUlitla7nmmSDj/nFCNpyAYEiabU
         xToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770891992; x=1771496792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lrT8ca/WW4Fm/idiqIKhyx8k+KZaFJexiXo1fc8v4A=;
        b=T5q2CxbL0rI+H35IEr6VxyPFGSH+72qJ8o0/9MA+RmkPQfG8FmSJO7KmOYu0g7hlpg
         WsICLWbGgk/CJPw5BIvyqfxKkszOBOjojMCwiBFDk7L7F1DbSbvuAC/OHSSd5RuTrnVz
         V3gwaq8BAczPMNQOC39Kj8UAHLdrNC6sDPJqhW4LwxYFqtE3r7zQmbLpCwgVwNcxRXKi
         9uR0vhkLPxrpivZLhbgNA4+xrr9smZhtBSu9f8mVocfs/wr6LoLhkqjSLGLp8rwGtG13
         QAotktezCMrv7q3CRNAeYYQPnMNsHpSoBMO4VeZaZZ0uzGCUZ1W33ehbHJNk1Zf8ggdV
         wsNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbRUOLWm6/G7APnwVliN/rQ5XcrDch8KZ8TH4hKooqwJhLB80TX1pG2IHFEL23xDdHvS+UAXfU@vger.kernel.org
X-Gm-Message-State: AOJu0YyZw5J8fQVDbn0IHqmnkdzdln6zivBf8ZegXXieD7mV6ccrosvm
	i/XcK2Y91Hoh7jDXy4s5+Fivg548sN3C9vPRySPyEv6bRZk/NAKmDUcqagN91tqqvUQ=
X-Gm-Gg: AZuq6aKaSjKsgieHoHJhK7tIclTFVBH0Jbqu4e1tI9+PCigXbBbQL+ct7Sl2ZWP6Uzi
	5MgUWXAX3CzrdRClR0xuH8QR6OF3lFkIUp+m0cToIvG+24SeMu3D4cIijK/z9QBcicUn8hj3VqQ
	UoHKXvHeAUD8iEqb2Mw6vksCO/GR1OEQdB7ctqAAefG2+hU2HTOLF6PQLucYkrNPVWdvzZLkcAy
	Bm9k1W8TSA079McruXhvysZyTDoXgx4zdVWfyJxBd0iuY0ualiPw9AXSVnhdIVRB5dQxo8gNutg
	a43MhJT1JLzfxlq0WgPccUcVp+0P1+CfYhqHhYH3LZYL9w7CXzMSa3AelA9Nj5moQMgSMfM/YY2
	9aqjD7dHBHMJQsqbi1m5xg+VsbsrtN01t7QNzBfE6NAfhhU6mFCzZUegeiLgqrT41Jfm7+D+/Zm
	AL5Z8V288V4rPeoEKbLRS1RRVe1+ExuGZu4TD1Aj0gxno=
X-Received: by 2002:a05:600c:c494:b0:475:de14:db1e with SMTP id 5b1f17b1804b1-4836570e54cmr32039815e9.24.1770891992143;
        Thu, 12 Feb 2026 02:26:32 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4378e72c203sm4467424f8f.2.2026.02.12.02.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 02:26:31 -0800 (PST)
Date: Thu, 12 Feb 2026 11:26:29 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Breno Leitao <leitao@debian.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, thevlad@meta.com, kernel-team@meta.com
Subject: Re: [PATCH] blk-cgroup: add CONFIG_BLK_CGROUP_DEBUG_STATS option
Message-ID: <jf2bkbvk3h5j3mqfldu66egbvbeq62mzdenuimpgn7d4tfkrpx@b2s6zzdgmgyh>
References: <20260204-blk_cgroup_debug_stats-v1-1-09c0754b4242@debian.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ndpqitjmtn3vcpwo"
Content-Disposition: inline
In-Reply-To: <20260204-blk_cgroup_debug_stats-v1-1-09c0754b4242@debian.org>
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
	TAGGED_FROM(0.00)[bounces-13893-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: 6887812C773
X-Rspamd-Action: no action


--ndpqitjmtn3vcpwo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] blk-cgroup: add CONFIG_BLK_CGROUP_DEBUG_STATS option
MIME-Version: 1.0

Hello Breno.

On Wed, Feb 04, 2026 at 08:15:12AM -0800, Breno Leitao <leitao@debian.org> wrote:
> Add a Kconfig option to enable blkcg_debug_stats by default at compile
> time. When CONFIG_BLK_CGROUP_DEBUG_STATS is enabled, additional debugging
> information is shown in the cgroup io.stat file, including cost.wait,
> cost.indebt, and cost.indelay for iocost, as well as latency statistics
> for iolatency.

This seems to be toggleable quite easily anytime at runtime (not sysctl
but modprobe config), not a boot cmdline where CONFIG_ default could
step in.

This only guards printing of already collected stats (sometimes even
without kernel consumers), not sure if it's that useful.

blk-cgroup isn't modularized since 32e380aedc3de ("blkcg: make
CONFIG_BLK_CGROUP bool") v3.5-rc1~42^2~92 exposing it like a module
parameter is historical artifact.

So I'd dare to propose removing it altogether and print those stats
everytime. Readers of the nested-keys format should survive that.
(I don't even see the param documented.)

And if there were eager readers that'd be affected performance-wise,
more conventional would be to make this only boot cmdline parameter that
could static-branch also the stat collection spots (for some more
benefit). And then would also a CONFIG_urable default make sense.

WDYT?

Michal

--ndpqitjmtn3vcpwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaY2q0BsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ag0eAEA11t6G6sXuJd5qgGckJt+
kYrhlMR5UyfYWqtl83O1icQBAIls9699cgxyP41vPeyz0q1GPr+XgPvxnly87RCO
ticG
=bajm
-----END PGP SIGNATURE-----

--ndpqitjmtn3vcpwo--

