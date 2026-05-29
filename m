Return-Path: <cgroups+bounces-16432-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ca3Lt6KGWosxggAu9opvQ
	(envelope-from <cgroups+bounces-16432-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 14:47:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C11366026E4
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 14:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F369D3046557
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 12:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28CC2192F4;
	Fri, 29 May 2026 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WHgAe9QK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160C14964F
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780058779; cv=none; b=O6RwLsPr9K7b5GjaRc4wdugwa42qc/rVBJ1Zgr/7uhZdZZjIz6rEZGrwX8IHaRGC58Ikcruu2DbEL6uTdCXjfi7VLwzx0YyybwUge5KEOe9FUP3tiP9xGBFmlAYxRWPJ+e+MaeuujeiFQCejCIK6Uf5CTUFlWOqGguoQBP2O4Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780058779; c=relaxed/simple;
	bh=RGatjCTq0s6ODBYqXaugc6ZnbAdhEsOzrvwF2bDqjzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKykp3gREc/V9iGPeq7xGAvN8rlmiJxefuxmiYR9VNmgM62iBnKO9xd5L8ZzC19Dw2lnKGrDUajWbcMZpl7nsh0h5kJF6SNk0xPMNrWqYJ8br06ah+3TDA/8G1R9iRbMOSpuBbg6VHP8+p9vfvBM6tGecNUi1v3mA/LISPct7y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WHgAe9QK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49048e043e5so60920385e9.1
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 05:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780058776; x=1780663576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VVuXTuvU9z6/Xk/ij86jv4B5J+bvOgp3qXIop/gYcXg=;
        b=WHgAe9QKWcUAaRSkDzl1jIrfGNFTi1iph8+vKJPmV4aD3OgTlxSsIcfp9WyvPEQpK0
         RyKaqE37wNftnUN+MIjEmQWYKYEiIYgPvSvyT262rJqVotvC4g8xYQOiekDUYD1SGYfT
         ahRMqxwzDWf/enfr1ZEJLV2fLUYY/uVfmN5ZNPGAmpCEhjLfF7IWr9V2u0lI6xtLdIJA
         YMMKUwpw3bKVqjoetXl7n7EVxncESpyrcheePOrob7juihsPvKwezOuTbVLaizrPU5q/
         I/rYsxZXo31UTy3ZO0iK/rdzwo2iMXmHqRCZhy7ZsL2mAHucAbCbh3YyOR8ZUEJmngSt
         R5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780058776; x=1780663576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVuXTuvU9z6/Xk/ij86jv4B5J+bvOgp3qXIop/gYcXg=;
        b=ep2oKtAxks1p+HPiSBjK5STSHpi9aSLhmdiv/CLWffYiFifhFakPUM1WEwATve0wi2
         MNdPsaP7Ect88POs+NrEaeFn+3B6M1lo20yl2xVjt3LfkaiblIOm0B/w96qfDDaofY03
         h+VOIq6AH3piBpx4EwMAuAoIDj7/P5ozD1TX0wdBV6HOe8oaITxOrvwvFXS+P2n/gvA7
         0JRNIZ8GZjDl8/2fdbkwNQJDEJs8/3BfRoBULFltxMMmc0PMNrqLMA2NfqUf9cARjDBh
         yBm0J9I2CU+FR9TISaLR3CpKQkGoBb0fGvXWD1qnXl2qF6GKN43NOJ1V6F1zBTSFeNzr
         UO6w==
X-Forwarded-Encrypted: i=1; AFNElJ+3mV4U7HhNQl6z/vTC+cFLWFhhtVtbOeQK41HWikwmKuxT4v+bG573w3klT6x5FhDsaS37fo2i@vger.kernel.org
X-Gm-Message-State: AOJu0YxP/ebBfuTRNTzAk9BXvCUwDMsg560/V9zKf+syH34jM6BvrckQ
	iLzHaewSLFrexQ514PL96fOIm0Q/DnE708twwFdf2qU2eJD9KY0WygOvjUoeOk264pA=
X-Gm-Gg: Acq92OE8u+iHSWdMfnS52eMCdey7wmPAhMeoSUJWghCuvYaVYM5nW5cgpUkE4qQGzp9
	MCVcpOvr8CkdY5oWe6AV9NdMitA0294qDA5U7SRU6m4k0dC7IqSGZbiMgNz5oCeL9IDsgQsskFl
	np2CQjPeVzePGBvRtuKVTHqGsjRs4dWKBwK5fpGEcvBYeVinkYVL1IK0XFBt5Nl/51CT8MOyCr7
	pQROkDGxMNfB5NDMgP//dCOLEbkjmwCOTfPMuJ8rRHtsY7EVdubxTNMo52onzFJaR8elL2ZbqH3
	CSS/gdH3HXG93azilBl+d33c7/3W5Vegc5sPzrJRzQyFB6oIPzLSjS/Psa9iVvi1HvwyjTntigd
	7Io03kbBL4bHUkL8LermhDOWAroqZU5/VTCyEXi8yRD4uJdUi3ltUGJflcDTSGvVzo6CR1H7T6K
	Q8daspSnNRsZMK22OCZY1FcInIbA6gubnbCIKuacxfM0CNYDGy4mOi/cpxBwlal8oLUhBLEw==
X-Received: by 2002:a05:600c:c16b:b0:48a:563c:c8c0 with SMTP id 5b1f17b1804b1-4909d2e8ff7mr50079895e9.7.1780058776583;
        Fri, 29 May 2026 05:46:16 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909caa7faasm42612135e9.11.2026.05.29.05.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 05:46:16 -0700 (PDT)
Date: Fri, 29 May 2026 14:46:14 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: tj@kernel.org, hannes@cmpxchg.org, leon@kernel.org, jgg@ziepe.ca, 
	linux-rdma@vger.kernel.org, cgroups@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH rdma-next v2 0/3] cgroup/rdma: add MR memory size
 resource tracking
Message-ID: <ahmG_ualxJT5WU_B@localhost.localdomain>
References: <20260529090733.2242822-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tcierihojdco2ko5"
Content-Disposition: inline
In-Reply-To: <20260529090733.2242822-1-cui.tao@linux.dev>
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-16432-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:email,suse.com:dkim,localhost.localdomain:mid]
X-Rspamd-Queue-Id: C11366026E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--tcierihojdco2ko5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH rdma-next v2 0/3] cgroup/rdma: add MR memory size
 resource tracking
MIME-Version: 1.0

Hi.

On Fri, May 29, 2026 at 05:07:30PM +0800, Tao Cui <cui.tao@linux.dev> wrote:
> The real scarce resource in multi-tenant
> deployments is pinned memory: how much physical memory gets registered
> through MRs.
> ...
> 3. Overlap with memory cgroup: mr_mem does not count process memory
>    usage; it represents a per-device DMA registration budget: the
>    amount of memory this cgroup may register through a given HCA.
>    This is a different dimension from what memory cgroup tracks.  An
>    administrator might set mr_mem limits differently per device, which
>    memory cgroup cannot express.
>=20
>    In particular, mr_mem tracks the registered memory range associated
>    with the MR rather than exact dynamically pinned pages (e.g. for
>    ODP MRs).  This is a stable, policy-oriented approximation of
>    registration footprint, not an attempt at precise physical page
>    accounting.

IIUC the pinned memory is regular RAM, i.e. it could be controlled with
memcg as needed. Or is there "physical" limit of what can be assigned to
a single device?

BTW, have a look at [1], it'd be good to converge to similar approach
(the current proposal allows distinguishing whether charging should
include or exempt memcg counting). Also it seems, that the dmem
controller could be a one-stop solution for all DMA charges. Please tell
me if there are any distinguishing factors between RDMA devices' memory
and these dmem memory regions.

Thanks,
Michal


[1] https://lore.kernel.org/r/20260519-cgroup-dmem-memcg-double-charge-v2-0=
-db4d1407062b@redhat.com/

--tcierihojdco2ko5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCahmKkhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AjxUgD+OExioWktiqQ9OzC9IpGL
l3Y0Srts+WHS89yla+uuu2IBALcEs0EwF6hOweZo9WWqnJ8ClpldY8i8TCukjmTp
iTQN
=I1f9
-----END PGP SIGNATURE-----

--tcierihojdco2ko5--

