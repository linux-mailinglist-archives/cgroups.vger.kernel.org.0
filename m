Return-Path: <cgroups+bounces-15370-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDWJLnMm5mmgsgEAu9opvQ
	(envelope-from <cgroups+bounces-15370-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 15:13:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A95742B53A
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 15:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01A8D3095BE4
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 13:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355243A1685;
	Mon, 20 Apr 2026 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F9NJi5Ct"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8A839FCAD
	for <cgroups@vger.kernel.org>; Mon, 20 Apr 2026 13:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690348; cv=none; b=GnSkGsbhz5G/Y70Qgt7fPtF5D8qI1dDSSC79O+EjOOi3TOB0jj8+vgwIHX10z4dGj4k4YIdh3/fID3nvRix+TEg4KpPTF9TxcCXHTxQcU8U7Wzkn6nnz4PciOYRzrnVmbF43UFbm4wY/Ky5cYNqWd0vHl1qMgqIQ4HrGclGMAAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690348; c=relaxed/simple;
	bh=Nu2Pefha1gDmL12wkzKji3C9AsqZUbHibfRXuFalpbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tu3cGOSN7h4ZDTmRrXOAVVf5JgeWAVza/NaZ2VX2ozfmNZSnIDOzIEJJaBLLtbZwjL26A+a+tz6ZADZnrWroGD1vgaeXEEzzdND/zQ5NcSBbSdVSIn4UpK3tvz5V1RY+NKN+l+rrqy0OUXWaD7gVfaUAaAwJNaTLJWoZd8oUUXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F9NJi5Ct; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48896199cbaso32120565e9.1
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2026 06:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776690344; x=1777295144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nu2Pefha1gDmL12wkzKji3C9AsqZUbHibfRXuFalpbU=;
        b=F9NJi5Ct6eDJY7cjDho4Hjlt/GExvMTKiYODWIbhltAJ16v9GYBidsjIt0puJ7C09O
         ifmbY9Q30vXWNOjL7kHiji+mjBybDU9uWGg4RiHodp4MQGmG7CBng18fTDturlE555i2
         RhHhw7o/rwXxIMakyEWyIkFrS1p2EXlP/hEUcK/NhSRDeHgX/1yvnhIPyQionV/3y+H6
         1hGH6jIPS8NDNWka8pRCyq7Fz+swOEM6YYB4xgOYiuhNBCZKbltXRkYhFlg40xFeLiAL
         qJepNOXH18YK/Yd+i+cwHfSE8jbIl12eVRFJomEaFT74jylRzpkWYGqQKsDNTsjB/3Kr
         vWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776690344; x=1777295144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nu2Pefha1gDmL12wkzKji3C9AsqZUbHibfRXuFalpbU=;
        b=pU6oBYrzdOCL2pFDUoWh73qcM+H9wlBynocGjyd5x/7z9dYy4Pmq0RNgBIwQNeNxoC
         02c8OXUPU6+MtF4UfyDJI2QrH71wo422StdaLjN/u+OFfFjPKAjL4Xq8NYVsDnlqVtCg
         658SWn24dEcYYY785MKOs0HsIwpharuoy5xG1kVlXifW1/M5fAZ0E37S/QJL1tB0XhOq
         Di5h2q4D8dfQi5JK89jmxQjehNsL45eyNJ1shPnParNo5mjKBLijRtgOUxLECoSoUIN9
         s9zwnYU2mLKaxr5eExQL3UDUAWx8Da7kK/V1bRBuR42x6HPvoon/mVpLvmUzPOTKDABK
         YlmA==
X-Forwarded-Encrypted: i=1; AFNElJ8gObwrY3iYX3nF5/VwtojkiuMM+P48l9qD5LW9YNlGA1zVsOjYI0gQvZS8UQoc9fZan+awZ0K+@vger.kernel.org
X-Gm-Message-State: AOJu0YyO7ixTkdIgZvrIN40gPPfohwsFqHrN35w8CH+BEyKJVXUm7XM0
	A9wPb1/iBEPjWvnK433JpaJPpM+D5IRtYlBPpeOFWEBpF0LKsWPoNyAkD+YJ25Iv5x8=
X-Gm-Gg: AeBDievoDSnR4NRqcGW7QV2qsQh+e9L4ModeufTLmXLIueFDqMO5wFy7fE9y5Iu/nbn
	cVbRCCjlDC386gqm85x+dTTjh90SfGrZTrz52uWvHl9fXNOGvaQi+tHSXTIlwy7I92qZfwLbD2C
	h07YtvUqEg+5U0YQVfUEl0wWc9WtuLbpw18SqJ8W2nxHqUE/3DEPENn2n4z7LaOZSAig/8E4KOa
	Kg1Dy+FF8m1zLYOOC/BAexEKddNvfFZcndCxYr/Fv8+UpY9rYUK7W/RndBgnzx/WDQFYCP71dgZ
	dHhTdgPLCIgRrwIjzSHYbKVHLqnD2IXB5wgoQtP3iNPToYssGzu8GrO24xdWrYtrbt92Vf6IZwd
	V1VhDSObiUoDZLG60kX218OiTQDkFkG5xG6+wTSDnTLMoWp+oMc1UZpbSrCr1KEvoJHoKgGplMV
	gnzpozTfWPEyaqfSFbRRSElRGx4BsV9ialzW3QrQTU32fK851FI/zNog==
X-Received: by 2002:a05:600c:c0d5:b0:488:c683:be89 with SMTP id 5b1f17b1804b1-488fb74dffemr145738565e9.9.1776690344224;
        Mon, 20 Apr 2026 06:05:44 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc181c6dsm263519475e9.6.2026.04.20.06.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:05:43 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:05:41 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, cgroups@vger.kernel.org, 
	longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org
Subject: Re: [PATCH] cgroup/cpuset: Skip cpuset_top_mutex for cpuset.mems
 writes
Message-ID: <of6dm4a6wv6rvy5fhd2s3lhm3jghnbys5jb67m5v5vo6whj3ea@lotj2x5ctdg2>
References: <20260418100220.3717207-1-sunjunchao@bytedance.com>
 <7249e345-8218-4232-9fc1-4109039a9aad@huaweicloud.com>
 <53e18c70-a670-47cd-ba17-2d6f1adde1c8@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="35oam5qhwkgwpyvo"
Content-Disposition: inline
In-Reply-To: <53e18c70-a670-47cd-ba17-2d6f1adde1c8@bytedance.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-15370-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 1A95742B53A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--35oam5qhwkgwpyvo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/cpuset: Skip cpuset_top_mutex for cpuset.mems
 writes
MIME-Version: 1.0

On Mon, Apr 20, 2026 at 12:24:11PM +0800, Julian Sun <sunjunchao@bytedance.=
com> wrote:
> > Has any regression been observed that prompted you to make this change?
>=20
> No regression has been observed.

It'd be good if you had a case that's support this modification. Is
there a particular contender for which it's worth skipping the
cpuset_top_mutex? (To me it seems all relatively cold.)

> I sent this patch because I recently noticed the global cpuset_top_mutex
> while looking at the cpuset locking. After checking what it is used for, =
it
> looked like the cpuset.mems path does not need to take it.

For inspiration, you can take a look at the enum cgroup_attach_lock_mode
where we use different selection of locks in different callers,
however, all of these had some benefited scenario when they were
introduced.

Regards,
Michal

--35oam5qhwkgwpyvo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaeYkmRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AgXXQEAmeMI5/s7qpNPiExO3EXT
ftB9mNqQ319icWHIWaQwBS8BAPJ9FtFlIThOZziAClf6EsfBCb9t1LlGfKRcrDsm
IbkE
=yRXW
-----END PGP SIGNATURE-----

--35oam5qhwkgwpyvo--

