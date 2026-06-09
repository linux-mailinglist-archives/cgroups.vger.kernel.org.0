Return-Path: <cgroups+bounces-16781-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /ubKOs4OKGr09AIAu9opvQ
	(envelope-from <cgroups+bounces-16781-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 15:02:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C9066057B
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 15:02:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=LgTse6Wc;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16781-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16781-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BDE283040054
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 12:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E862341930F;
	Tue,  9 Jun 2026 12:58:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C2F29430
	for <cgroups@vger.kernel.org>; Tue,  9 Jun 2026 12:58:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781009886; cv=none; b=e4qtAHCPF9jHR8TE/ZSk1jPLw0xbK+MkZDZmI87IWb4PkgzV5rKlhUuuOrgyXZVYh/zPhjBxKcqXGtA9jnLrW8YLbOJGZ7jTYMdF/JSLO+/HSm/DtVE9Os26G8BXQhU+GIdoy9KaF1R3Ka9V1MIBDPcYTEIonPhQJR06M6OdpvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781009886; c=relaxed/simple;
	bh=gYpQhDPjIE70r6t1FCbngDxSnN6WqnNYJh7MaxFEamo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9R1vhMzbLcI40JPK8dbLp1oOjPNnLH+49eiZwocx9VcjzD46i206fMxKUS1acAIqusvOBq/n8mxcGPwsFgiHIzIgOILEeWK3C29K2ONHBWertaw9gwMuhsbdcriEwTaUmRSMv8FMoVtvAWPymLeHidrYEvpbmTHgxR3sKnqStA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LgTse6Wc; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso62358485e9.2
        for <cgroups@vger.kernel.org>; Tue, 09 Jun 2026 05:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781009884; x=1781614684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gYpQhDPjIE70r6t1FCbngDxSnN6WqnNYJh7MaxFEamo=;
        b=LgTse6Wct17eJ8MXo/c/ZUC0zN6MsphJEVfJMYVvyNuGeR8NH06urVQjC2VeHXWnUm
         2qgsTlFUFAZV0aZXY0Sv/nZ+PGYiNpM2wVYc1kc1RZmJqC+hvStppAva8rvW22/nXqkU
         0ubtpCfu3WamUweF5NUIjA9TYBTmA+agypK6mF4EZmGieGLOqAVH58ISQsS3jDDS88Pe
         YRvJprHfbUCD0RulLtJ85SgY3XcF41jnPrBH1R2et3ia3w84CPfGs75YJ/9LJdr9xUpi
         KVi554D/NHua+qqMPFPLba7VQPLfS3oOPRCfPbyZrTmU0kpbcSIV1Qhu8GIJzpPZc+B/
         VSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781009884; x=1781614684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYpQhDPjIE70r6t1FCbngDxSnN6WqnNYJh7MaxFEamo=;
        b=paDF53nJLRz2XtJEHYkgQxVXcnNopkf2B99VToSKQiqrR3JshfU4I+cj7s0P5L951a
         WUFveI96vkcEXVz/XDdNeTvN8V70NhAWjSQr9vKCqCzaufV2sJHWXe954HOXuZEtovaC
         kBVVCU5VhaBS4sGD8TMDNPqjq7X3b73Q5g8FNUuMBG4BcuMrsDlthmM1hxzLVWeMr7UT
         JTS8YGGcg+0DDpefYvnLtM6jAeXIZsqIYy7CKnvzPjCN4xnyy7bK54GcS0UWfDxFjwGE
         FMVCaSXuA6GaWolll5MjyEkLw4v4Es5bdqxQenx4V1HsH7rAx39Ew11oa2ns8FrYkQb3
         MMdg==
X-Forwarded-Encrypted: i=1; AFNElJ9KYzg1PvgJLozwf4LOiG2HkvOy/WeUVS/NRiHX+S68Pz1jHsB7YFU1kXnhrzGZFljioLbUviVx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9G00qySSn+rCcdhJLMYyLB6Cg+IhzTNlRyFRMgYwQZdqrJbeH
	lcD6tnlsTglMAf7DLLYtjCHNKLIkH8S4FxT4uJfQFOZU6Uhy7+hemqjeqgxE0I956wY=
X-Gm-Gg: Acq92OEI2/y2RDtwlCuFTd49ksbe9LObdOylHizSYOQw4Z/3MCgI8NUAtdYF2r4jSa0
	KE2mOmQtZpgCSVkhxD1XeV3/4u3m/T1kNvqjhxDkdr+dDXExc+23L4mYkYgy9/Obr+RD74EOzb6
	xDIqCH4PIy5UvXGH4KhS2fDLO2xdctZzEQX0Pl64btTMmft2cNGzeQo6u05b6HFABhjmBcOxCtf
	3pUynam7jvFF8pbQDtjE7YKvgTqMuck1VtzTUh36DwdEEn8vD57caiqvvFaHQd0ViUA/Sq1q5Ik
	esuZ1Oy8VP6sn6cAIrpPNhmJLgHZ59EC9Qw3LBYU/x7wETwliD35ueRtEfAB7w7y48fdoS0AjBH
	+jhDti2RyHnYLI5NWcfuJYCWuIG72T8OUqoJI+Fbaz6RljNAs6Fj13cVdsWBwxGbiLYpZUyoelM
	EJBeEzARz9azrCy5OPQgUVGstdANYw+o5vQG2i878=
X-Received: by 2002:a05:600c:4e09:b0:488:9bf8:7f17 with SMTP id 5b1f17b1804b1-490c25acd18mr365025535e9.14.1781009883789;
        Tue, 09 Jun 2026 05:58:03 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e4b5asm478588225e9.13.2026.06.09.05.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 05:58:03 -0700 (PDT)
Date: Tue, 9 Jun 2026 14:58:01 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Longxing Li <coregee2000@gmail.com>
Cc: syzkaller@googlegroups.com, tj@kernel.org, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Kernel Bug] INFO: task hung in cgroup_drain_dying
Message-ID: <aigMzVNsQpz_J0oQ@localhost.localdomain>
References: <CAHPqNmxGfjsKGEJJaSCrJqoU9WHY3q8CX1oTA7GV5BBHvDzgpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ihxr3wswm62bdgvw"
Content-Disposition: inline
In-Reply-To: <CAHPqNmxGfjsKGEJJaSCrJqoU9WHY3q8CX1oTA7GV5BBHvDzgpg@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:coregee2000@gmail.com,m:syzkaller@googlegroups.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16781-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[localhost.localdomain:query timed out];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[cgroups@vger.kernel.org:query timed out];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.com:dkim,suse.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,localhost.localdomain:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0C9066057B


--ihxr3wswm62bdgvw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [Kernel Bug] INFO: task hung in cgroup_drain_dying
MIME-Version: 1.0

Hello Longxing.

On Tue, Jun 09, 2026 at 07:42:06PM +0800, Longxing Li <coregee2000@gmail.com> wrote:
> We would like to report a new kernel bug found by our tool. INFO: task
> hung in cgroup_drain_dying. Details are as follows.

Thanks but I see no attachment.

(Greater if you could add description as plaintext [1])

> Kernel commit: v7.0.6
> Kernel config: see attachment

Do you have lockdep enabled (CONFIG_PROVE_LOCKING)? That may help
debugging here.

Thanks,
Michal

[1] https://docs.kernel.org/process/email-clients.html#general-preferences


--ihxr3wswm62bdgvw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaigN1RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AhZrgD+P0VUps1OYR3GP4gMDF5s
kPqNeatXmFHPDVwijR/aI+QA/2gC+JVJFTUYWhVdYUVQtKLD09eFYxDYG/wVYz3L
zt8I
=/Xo2
-----END PGP SIGNATURE-----

--ihxr3wswm62bdgvw--

