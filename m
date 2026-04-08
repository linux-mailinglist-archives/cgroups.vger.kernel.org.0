Return-Path: <cgroups+bounces-15195-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMmhOPtQ1mm8DQgAu9opvQ
	(envelope-from <cgroups+bounces-15195-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 08 Apr 2026 14:58:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ABC3BC7CA
	for <lists+cgroups@lfdr.de>; Wed, 08 Apr 2026 14:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0651E300CE7F
	for <lists+cgroups@lfdr.de>; Wed,  8 Apr 2026 12:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F503BBA01;
	Wed,  8 Apr 2026 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b7svNVQA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD48244661
	for <cgroups@vger.kernel.org>; Wed,  8 Apr 2026 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652862; cv=none; b=lspqJiQ6iuPegshl5Io6IQ2jEOfnjhFEie118nZwGLt6wAcJQPurSqbzjB74bEbXEADBYCPYOOrZdGf86ZY0gIrRwFia08APBYICjyk8YKq6FoWBAda8Wll6dhzi17U6osc53YIKwrL3vEZmndktrOwNm4H47EgkyDWCu7EVA38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652862; c=relaxed/simple;
	bh=YV/Yor/rq2jIgRl3HRiIG9WvBjXmctxJ8UEBfcCNCaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZ/8PJZvR+DaH+fLh9Y40LmJhxzcdZ6zODyUyNLYDzpLlDN/870gumjRne+Gt5eRz6h6dqnmR34Jf41nYJOqjNDCliXHCe7OWb91PoglGD5kq/wonzoodwhxLiqLVIDabs2YKCY5dNlP7uBUJ/uuR2wUrhj7KtpqD+2Datyo2B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b7svNVQA; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cfac48bc7so3420099f8f.0
        for <cgroups@vger.kernel.org>; Wed, 08 Apr 2026 05:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775652860; x=1776257660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YV/Yor/rq2jIgRl3HRiIG9WvBjXmctxJ8UEBfcCNCaM=;
        b=b7svNVQAuH0I2MF2lnlZ95vqA7m/5C8MX5WZ+sNkxMZRDbXArwiGJSm6zfoop/4h5a
         5qxf2RzlBEWViY3DZS+X7arzhkn3JfCqCz1twVe9JHmIUFzXc8NjKiEeh+UQkvgT39Ji
         XTUeASxiGFcmPUxwtVVYHpt4uZzW0Cpf929O6eFkr/Plhh3qmP17whqdXuZi938dcyI0
         qnl/AanbWt0MhxkJRM2hmqRYBIx1K8bYxpngCbtQUja0XYfbYbf9Hl/DZX8x3ACyHRR3
         bdP/YHMI/nrLKxsTBnOYQnlUuoXx8JvMhHBg1MSmcJI5LM/kFbxycfIP7EI4/vmiz5li
         Z2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775652860; x=1776257660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YV/Yor/rq2jIgRl3HRiIG9WvBjXmctxJ8UEBfcCNCaM=;
        b=B3wzG4oOaPIWAOK9wWu2k1TlEbsWp7L1eK+cGFgWJR+GNULDXOwKgz5I7unK8f7Yv5
         909EpsuLSMdT+4lcXoHPl4nitdI83Q42rNpHb8YcsNIJNAxIesg3v1p3yXbf+FPU1ie8
         7yokb9R+osi8xXCcAW/eCYmXIeOrgZhkInY8qV7QZE4miqX853bwm+x/2QlVltPe9UGP
         KfWrK3TvaSG9yrvC8lDnCRiRj/1GazVTPY2vZ9+sWdES/5v4RA2nBS5xNfh50EJp2vUX
         1NHVsDiOXqTXM+dhAXFBYNyelWoxefeQw8cxhvasxy2IfDRlWilxj8DzKN3N9NBBgpp3
         qzag==
X-Forwarded-Encrypted: i=1; AJvYcCVjsHFfJzim/Id3TY9anX9ycnQYgQdumBGoNsDb8Viz/wRO7ACnyrzIwUOSIbcnoAJvhR0VZIpP@vger.kernel.org
X-Gm-Message-State: AOJu0YzyeDOZKTDHlMalcOShKDKBM4ykRV2lklu5+/zdahIUnDnMbm73
	y4i88SXHVWmvWj048e4nWdFA7tbmS/hglwhfJDv+CxVwxnenGGr9FtwppcaWMbsqyv4=
X-Gm-Gg: AeBDiev4+wZ18VwFEplomnZlfpkMVjEILwpIOL3B85xW9PG9Febp7MryWiyKneU1Reb
	UW5mLPmRtJ0Ep7l6O5HbtgDRZDIbxcALTWdaYI+X+5oKzZ5jzYyh3IhdJEoCYkumHxxljgYJcZh
	8V+ii3L8Z2bBSum70ZbxNUOSIrfqgARr6WzEdUm52t48JNsd8msJSxadJZCqSuD2PjP2w2aay6T
	GqNmCGQkMqQ92f3bWbsOMdhzFsaCeHUtXBYL+OpJuhl1AItgJDgW3vT8QlrpLuH7909xRZR3wXT
	BcrB/I3mbtICEHBvZzywjWJw/7y/vdIbJub+K5RouiUelBKvZUh/3UbR0PF5vbuIKW3dJ4zCHgG
	AhxUfo/wiaZhlODlb8OPk0rDzXLEMQCS4V8xrDzola152x8ScrEehkK9pavVesqyFqB59WRXtlx
	9M8IKAhL/JP/AmC0IAB/jtzJiORiE2s0BcoPY2jAJM+L4=
X-Received: by 2002:a05:600c:638e:b0:487:575:5e1 with SMTP id 5b1f17b1804b1-488997adbbcmr298382215e9.24.1775652859878;
        Wed, 08 Apr 2026 05:54:19 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488b64f03afsm199949905e9.0.2026.04.08.05.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 05:54:19 -0700 (PDT)
Date: Wed, 8 Apr 2026 14:54:17 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	cgroups@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	tj@kernel.org, hannes@cmpxchg.org, tom.hromatka@oracle.com, 
	kamalesh.babulal@oracle.com, Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH 0/1] netlink: Netlink process event for cgroup
 migration
Message-ID: <pd3vkzvgr233tkuocyvpgxc4kttsi5nlggcxuskvwi3mocoqkm@cfefi6hh74s6>
References: <20260407172339.2017158-1-prakash.sangappa@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w6njgpe33rkj2elt"
Content-Disposition: inline
In-Reply-To: <20260407172339.2017158-1-prakash.sangappa@oracle.com>
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
	TAGGED_FROM(0.00)[bounces-15195-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email]
X-Rspamd-Queue-Id: 83ABC3BC7CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--w6njgpe33rkj2elt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 0/1] netlink: Netlink process event for cgroup
 migration
MIME-Version: 1.0

Hi Prakash.

On Tue, Apr 07, 2026 at 05:23:38PM +0000, Prakash Sangappa <prakash.sangapp=
a@oracle.com> wrote:
> With cgroup based resource management, it becomes useful for
> userspace to be notified when a task changes cgroup membership.
> Unexpected migrations can lead to incorrect resource accounting
> and enforcement resulting in undesirable behavior or failures.
> Applications/userspace have to poll /proc to detect changes to=20
> cgroup membership, which is inefficient when dealing with a large
> number of tasks.

You may want to check [1] (and followup discussion).

> Add a new netlink proc connector event that gets generated when
> a task migrates between cgroups. This allows applications/tools
> to monitor cgroup membership changes without periodic polling.=20

This CN_IDX_PROC netlink API haunts me at night.
The hook(s) proposed above are IMO more future proof and robust approach
to the process migration that comes as a surprise (and possibly
interferes with intended resource management).

Thanks,
Michal

[1] https://lore.kernel.org/all/20260220-work-bpf-namespace-v1-2-866207db7b=
83@kernel.org/

--w6njgpe33rkj2elt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCadZP9RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AgU8AD+Lq0FLDIQZHhgVC785HWW
Qtb/ox0BmHLvlzH01RNT41cBALaawoqwRapWkOJoqX1g4Ia3MSSB4aQTvSOvvwmO
NrUD
=eVcv
-----END PGP SIGNATURE-----

--w6njgpe33rkj2elt--

