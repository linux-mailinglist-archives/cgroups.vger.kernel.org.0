Return-Path: <cgroups+bounces-15314-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG2YDKmU32l9WQAAu9opvQ
	(envelope-from <cgroups+bounces-15314-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 15:37:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4729404E7E
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 15:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BAAE3019067
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 13:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDA334214F;
	Wed, 15 Apr 2026 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gx5XogfU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D42C2BDC3F
	for <cgroups@vger.kernel.org>; Wed, 15 Apr 2026 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776260253; cv=none; b=LSuwWuwKeih+CMlRbzPYQf3A4JP02MJ2h4b6jhadDeHRPh3ruI6W4RuCeIiYqe8M9ExyJF2FaO0YfEdHl+1dribOq3sUQky9cXxNnlS1LgdYne+T2gfd1hAdW1UrjVlWBXq9XjTJUIikx94K1wn4lTDhKtsQyvUODyxortgePAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776260253; c=relaxed/simple;
	bh=1UdAUPi001wp94FfqwFP2mABCGqvSXFEk05dXCEhWxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCF1Cu5RzgNO74drH+Yz14adHESyOXp9kipFBIz0P7j0+aLggVncJ9vupXqMaZU3xAtBDKUI/wPXB7BNk+ZPx3eWrK37yTUhH+Q+O/IB1AiPbDUu2uNwfqzkz8q/4fnP2flbmXKyc2nLqTPZNNEfYrBgYTfdPQbYYyMYWF5uLGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gx5XogfU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso55194985e9.0
        for <cgroups@vger.kernel.org>; Wed, 15 Apr 2026 06:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776260250; x=1776865050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3HGShUqwXmU53xc4UmjBc1ReH1MKh0qjB6rxMysh+Q=;
        b=gx5XogfUnl5tBtMnk74bL4O/oJEO6EGxp5FXXq4xF/6AxX92BqYlOQAaSkMYIkufzN
         QIGXeC1FuVzvF7/bCabiRZhCbNQKbJ40Tbf8yGM785VYQzFP0YZc1GpvX0HdvuYZhFAX
         Ixv4j51OVbt1nCNVdrJEqiYp0BCyj3sKTjZ5kvWGwA0WDDKC1YuJrdsUU3JZrxwYinnY
         Ix6FStnVsXmgZwWg0CfmaK3Hk2vTzYqqY3J74pSSzTsh3ka841wU6pd/b5WriCBwZycX
         WyDT427LMSgU7JYoGto8NPNI8+vrwRnjp1uEXKTsppR7b60nNr0sbSyU3zAToCxQA7+L
         jv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776260250; x=1776865050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3HGShUqwXmU53xc4UmjBc1ReH1MKh0qjB6rxMysh+Q=;
        b=J/5IP4Tr5ys9mLQNwgI+W7tI2QO3hIHkpKv5L4cKsklENavI71XRda7CHLA0LLH5o0
         q3XQazmdY78iVuIGEwrxTz3WOcQN2b3gGoDbcq6slA75Rlb/ux3CbrLeZ94ePRnpNeZ5
         E90U8OGV/KK3Q8jW4aMJHq0AY53Ul8RaqUgZWU4wQbngRrTwX0nuyHkwzLTYBRJeACxY
         354oLBIimrNj+g986LVrjzIxBcj8aGyXXJc5wtKYcOmHwRpwo8HMVvTfFShQd+XpURKH
         6NVMZdWdLd4+2QrvvEy9jmpkcVlXF2s4kJ9lQreFEnDaLHAbuTNcIfpXhLMso9Rmx0Mu
         0wvA==
X-Forwarded-Encrypted: i=1; AFNElJ+ZvOSBlTLxt50AHUcNke4Z8wOPjuigw34Srsgvw+/cJnP9H2KaeIVCiZyYYARp0L/cUSuyD0kU@vger.kernel.org
X-Gm-Message-State: AOJu0YxY8IFOL1+QRWWO0/ZOE9m2czON/dtQ4b7K8KVde1P8PtS765VE
	VYBYvRpbykdLtFOxZMmbM09xiMWXukroUfa6UXeR1VkAFyHPBLISzqU39Aryh5zJFeo=
X-Gm-Gg: AeBDieshEoXheo9FLlJnPxjECZ6gdxmrseOGrHvulFhKNgoqJMEmMVxiyWSRuJ+Yt/f
	knBPU9OTSRKXf4MY+QH6TwGYCMzVWHtMXHdr/e8vzuOzX3pk6WFmZ4sexWRDuH5eyLwcMFJOYEx
	zotivj/gFHiVFDN0Qek5ajCtQrmLSHw4wdz1oE3UqjeQimbfzBhM6KDmky8zjSUTQc5kqoZKvZ7
	9ckNH4SnssVFLNR1dyt+So0KjnwHsWjKzvGwsCHlPeRFceibIsPY5m8Fiy70dpFM66qcfSArigf
	E/7wywJ3Tomxq0a0qHHo0neu9554mVXl/NoQV8A2CF07jFn+qrCepZd3pYbQ4RmuyPFYKLQh5u2
	n0uqJRelx2XYyfU2eSjVI7Arb3bKMZXiMmU6b+9P/w+RkPTcobz0IZ0R/hxfDNJhpsx5lKAl5Hf
	yJGe40j621KtvoN0I7nSMSVgPn5xdMLTpmrufotp2WFp/PotPVC1P/8w==
X-Received: by 2002:a05:600c:c0c8:b0:488:af14:f1de with SMTP id 5b1f17b1804b1-488d67b8de8mr221931205e9.4.1776260250430;
        Wed, 15 Apr 2026 06:37:30 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1513csm144847375e9.2.2026.04.15.06.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:37:30 -0700 (PDT)
Date: Wed, 15 Apr 2026 15:37:28 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: cuitao <cuitao@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup/rdma: fix strncmp prefix match in parse_resource()
Message-ID: <hh55ocozzvg6uyfjmwu2hldksmrq33kdqo5hpxi2q4nszztj2s@nmacfk64ks65>
References: <20260414020936.306853-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rff5pgdcxrgpjs5m"
Content-Disposition: inline
In-Reply-To: <20260414020936.306853-1-cuitao@kylinos.cn>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15314-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4729404E7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--rff5pgdcxrgpjs5m
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] cgroup/rdma: fix strncmp prefix match in parse_resource()
MIME-Version: 1.0

Hello.

On Tue, Apr 14, 2026 at 10:09:36AM +0800, cuitao <cuitao@kylinos.cn> wrote:
>  	}
> -	if (strncmp(value, RDMACG_MAX_STR, len) == 0) {
> +	if (strcmp(value, RDMACG_MAX_STR) == 0) {

Have you tested this? (When 'max' isn't the last assignment.)

That value/c string is taken out of the whole line (see
rdmacg_parse_limits), so it wouldn't be necessarily equal to
RDMACG_MAX_STR. So bounded compare is still somewhat needed:

	if (strncmp(value, RDMACG_MAX_STR, strlen(RDMACG_MAX_STR)) == 0) {

Thanks,
Michal

--rff5pgdcxrgpjs5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCad+UlBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AiP2gEA0bGpAFwDh3O629PPoLMK
UWXSuHl6hYAFDiLH7wUGFLEA/3+i89WTIOB1ILbPODiJIc39P4H14zNz/FmugCna
exkP
=7wZy
-----END PGP SIGNATURE-----

--rff5pgdcxrgpjs5m--

