Return-Path: <cgroups+bounces-15435-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PP9F8mF52m+9gEAu9opvQ
	(envelope-from <cgroups+bounces-15435-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 16:12:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7F443BD05
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 16:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDB06303FFF6
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 14:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669C23D5655;
	Tue, 21 Apr 2026 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A+m1vzCE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FF53D7D64
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776780291; cv=none; b=Rxl+YKb4mOV0tmT21owyjqWQbu6Wke+ARUA4yoG+4y9m9tUM0gC6uuV3PNOyCIoz9tBebOVjf4jvaups50bEOqmNBxj+jIkHiey2MKjt+p/0hYUcx4kDHHumRW5nAA9ChhavKZBv33zyRYL56yVGIjJvEM1inO43TkFqRBYZvgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776780291; c=relaxed/simple;
	bh=c3qi+C9j2teO5dJ/2p/g8nyZ0x9/7MBmW2rmERbwa7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hx9mBa6ZpHLpcuhK/YeuNHgstR+alZg7jnhMQue+gJeexjmPtyg575UdL3lvj2t0PA/bzRdmbMqECAWzloICLWo38SCJ8EiNN23pgvQRbUd7m+7+wXTRYwB7etdDsIB0mBlTeZ/+zMZs+gXh1dCSDB1v4DnrfJjOqZPnE7e6J94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A+m1vzCE; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d70b3e159so2109183f8f.0
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 07:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776780288; x=1777385088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c3qi+C9j2teO5dJ/2p/g8nyZ0x9/7MBmW2rmERbwa7g=;
        b=A+m1vzCE10Uo6ZZd5KneN5nYV1PayCf5fJ2Az9qOtNTCXB5oF5cxrbuC1acWTdlUym
         0SUHQcSSBMKRzoVdJ3JDm93EUceICbnMK/5Dn9M5Zui8R8ZfylbiQdogYdwu+MEqPtD+
         gJCWKnRnZx4Ett2RFpyuko8jSBUodTlVl8Zj3IRomn7RdSrOwvIbkIvGj1qHje5AP0PO
         Zae0o8f9O+36wBfoAG9gx4nyKoYmPRxoHg4YJ2e0Rt/pe9GkUm3m/LyBiI+ZqLMTP1vw
         tnyzGFO04QX64r7sluMOvnOFqoK9ENiZLDrfvkagW+SUxep6h9D6jcJU4iXcRaFQK/V1
         BD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776780288; x=1777385088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3qi+C9j2teO5dJ/2p/g8nyZ0x9/7MBmW2rmERbwa7g=;
        b=amkX3aONrSblSpiHnw8k+JQ6kTatyifgi5wcI8594B9XoPF45XkHxld+ty9a43kh/J
         JWtuD9KqHol3B/L6hv4h7XocRuBAaFgFNZWaQPEe/J/zafiONdQrNpyqDLpIZrNbWwDQ
         oHbaRbP3HUgJsvFMqLBkLOtWNvmV1jHd+erbYZGs5wSFzfL+cT6xJ73vDQ4fFSvYdkUv
         QMynkzJ/knr5v5aB2Yjl2969ZiUz618lAa9Wi0uWBvK6Q5v5KqSRShw1gF+c56IE1d4X
         QkGZ+y/VtdF8Gix+Wx2Uc6vo9G6Pg0kucFKUrXV0I1+EjiST8lwASJR2Pjce6chGPgPJ
         8WsQ==
X-Forwarded-Encrypted: i=1; AFNElJ/URrMJjuIbAHuJF/3pLDBTc7Dc31P7FV+Z1QB7mDs3jg4dSh3HJlvy2maqZL7G4mIGPYSuOF+e@vger.kernel.org
X-Gm-Message-State: AOJu0YxWaXHVAR5fa6FiV4GZRx6w1JrWL9UxQkQvMMr937tk4l9TKjK7
	qJWDITx3F+DzuM0f3HCmSyicP8OOQmhNEA2TYbut9ScGRSN6Bbu7BXkwqdbzutz8LEzpaskJkEG
	PysuIErU=
X-Gm-Gg: AeBDies64eeEvNufoWVZVVlQhHKqIfRhFEUGaDcbhgQe69qhnAh5fABYNhRRHA+v6ty
	7tFNM79qlfRZHhABRTnLdHdRY02dI7m6qXtVuGvuB21lHYlS0sq8MYvne+1KRs28EyGIckXeL2C
	SpflD1O+czVskz+5Vf1XUOMB1bLD0nb1ZyecaJKucNYQ15tFa8xiqWQVvaxIFhOgfIoBbRqutTF
	zU66UGwElJsXYBGO+O5xyZCOv8NU3eTCKoPb3g9FZ+zhPW7nypl7lLCwkBdh+mSYzjmKmDDeL4R
	E2ydd2PrC7zaZDFi/8m87KcdVZAF7feUkUlqAtGtMf3gc3pV8zX2GuS31VBz48nQUqtF3EM57bv
	o1GreOV1x7xGUMRpir9/CFO8sEPdzE0ySQriRokeMEiTn8AM2Ai04vaGYqKbJcv+aSiBQ1VriR2
	mSGz8zKt1YXaoY4qsKsKYZwHjW
X-Received: by 2002:a5d:5d84:0:b0:43f:e7cc:706a with SMTP id ffacd0b85a97d-43fe7cc70aemr26677745f8f.22.1776780287794;
        Tue, 21 Apr 2026 07:04:47 -0700 (PDT)
Received: from blackbook2 ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a79esm39920268f8f.17.2026.04.21.07.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 07:04:47 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:04:45 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huawei.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] cgroup/cpuset: Skip security check for hotplug
 induced v1 task migration
Message-ID: <jafhpixtigxog273jww5bgemmvksgdtd5dug4zf4eax4rsdpla@5jb2nookh6rr>
References: <20260331151108.2771560-1-longman@redhat.com>
 <20260331151108.2771560-3-longman@redhat.com>
 <7i2hhyijet57lfwvz3ipzlwrze3i6bm343evgpjixmj6bj44kl@rhszdi6rlycg>
 <ec115c35-4484-483e-bd06-9ee35bd98a93@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mp3ophwyrjgastzv"
Content-Disposition: inline
In-Reply-To: <ec115c35-4484-483e-bd06-9ee35bd98a93@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-15435-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
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
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC7F443BD05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--mp3ophwyrjgastzv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3 2/2] cgroup/cpuset: Skip security check for hotplug
 induced v1 task migration
MIME-Version: 1.0

On Mon, Apr 20, 2026 at 01:44:39PM -0400, Waiman Long <longman@redhat.com> wrote:
> I believe the scheduler has a fallback mechanism in that particular case,
> but it can be any CPU. So I don't think we should rely on that.

I'd say that if the patch resolved a potential lockup it'd be worth it
but if there's a fallback to _run somewhere_, what's the issue?
(v1 behavior with hotplug is "path dependent" anyway.)

AFAICS the cpuset_hotplug_test.sh is v1-only and not touched in the
last 5 years. BTW I checked some old runs with v5.3-based SLES and there
doesn't seem to be the described issue.

Do you have more details why this should be changed?

Thanks,
Michal

--mp3ophwyrjgastzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaeeD+hsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ai8DQD8CJYHBfWhjklCerwc2ZK5
HGyokLjnK5Oh/FHFdvJFD14A/jI/AoUMIcEYZ3nsd7+bPniVYTTlJY4JTWV6Qi7t
TsEE
=dfsP
-----END PGP SIGNATURE-----

--mp3ophwyrjgastzv--

