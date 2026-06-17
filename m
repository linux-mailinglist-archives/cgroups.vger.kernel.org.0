Return-Path: <cgroups+bounces-17036-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KXbQGR+UMmpy2QUAu9opvQ
	(envelope-from <cgroups+bounces-17036-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:33:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1C3699BCE
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:33:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=Q7LZUnOp;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17036-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17036-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 570E33038BBA
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 12:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477EC39A07E;
	Wed, 17 Jun 2026 12:26:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96416411676
	for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 12:26:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781699196; cv=none; b=K4+ZZ2ipJg+bUphSm2Zk074Z7JPSnhdnCZ5cH+3WMaNzapcjTiJ8xbcwB3v3h+aRXfWQDvZU3p1k/8VVreD9uRAchGuSO61Byh9FeVbuMluahqmYBdmjtDcyBoJAwLJlKJNgkwwMRXw43Ln6qt/nMQgBsGbatp4P7YlE4Smlddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781699196; c=relaxed/simple;
	bh=kK1vbYx6jnfGfT+EdfnTvxaElwnej3ZgdqtKk3tUgWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyKnrOCwuyUo3Pe6iozflEYVNMqkJnWVCQFZXq48mIdG74Rf0FjHDDHD7SZSE/9Z3onperuo0ZzZMVBjQ1TYmql/We+st/QMhw2ByULQgKa9TwCo2oxDqSiz4MqN3+u8Vqm4fI/CsDvocRcjnsOu+7YmMlU5rBnG4F2CV5MG6dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q7LZUnOp; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so39665475e9.1
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 05:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781699191; x=1782303991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KplI5DIltMOxeWE/hVG9qMzqxTkTYf7x6780RRs6dfI=;
        b=Q7LZUnOpUxI0uy4HL0ufX0xIrqXluqgYAfwmt7o/sejz3tHPZy4hCrIs90QSngtmEQ
         XKJBW91Q+LKkT5IrFRYN+Vie3oC1RiUYw9No9umzYApXjxMHzU9msY/k2RC8cBZ0ARal
         Hl34xgkWT+1BdnbgVq35PsTAQs3bKp9GUJi1p43L2ivoC2E9sTsA1rV08eOaNWOzYaaM
         6v6nELaqO/mYuXMEZmLmIWqEPOxa4XwKKLvbWAlDL6GjYHRxVdqZm1EBAokSIdoWzNPz
         tmKuZY667xo+Ue5+NJjN7L3mvEyuWQeXC35/S+OAvwVcnfeCXFOTdZXloM552/yvKHCs
         Prog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781699191; x=1782303991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KplI5DIltMOxeWE/hVG9qMzqxTkTYf7x6780RRs6dfI=;
        b=nmPmpBKBS1nEgO9JLibcwiZ65GugsOfy3GpqwlauNtSy45+T7tpi5BjxAYpwzU2c4x
         4NihOKfq5LMXse6d8JKuq/+TaOoucK//UBaWLFdmo0KmcxMrfDgXIA/f+1klotEBrBX5
         3ZhzNr1OV04aJZF9JWF9YdDamdvhjEl3Fd9WTG1+6KozVUwjXUbZFl6oTtaypOJBp5C4
         +UUSYHJBYhXd9UJhlAB2K6CunM2QxfFRp4Q0vXqwTGYTgd5j5fhvxVNd8zD3Sc5GQEwn
         4kqhHytmPueLvsJJz1t5BUFiwdYCrLQ0/3/WSDTfF+6q//p35ni3IakiKeNdr4GDbTpF
         Lt2g==
X-Forwarded-Encrypted: i=1; AFNElJ/xUqBK0lILbvlyCWSmv2UX5qNDZhDj5wsB5Xnn0PN9czB3h/FoifNoWtpZTGoFrd6psI7Sr9Ni@vger.kernel.org
X-Gm-Message-State: AOJu0YwTtFxRIYojDcHB/iZ0G9YGv1KPHv7PDtauA8kxPVZzAwZqO2Eg
	MMtsk3INtC59eOTTSGjhTCHOrkink3xWinWVbHhsmvVDFD2v5zka6Dkb0YmtfNV1Ob4=
X-Gm-Gg: Acq92OGIxXNtXUwHhxWPOMBrrCKI4wUC0i7IjrsgXGWjinI1uqVVeR4Aa1l97jYtIAG
	B2xYT09i+iSXKsfII9ICXlKnwOnBVRjWZ/ocbYnuJOaK9y0lo19BDgTqQcJ0DhJYc1ANCC5xs2E
	0iFfvIB9gR1+54xa4QoQv/IBgTd4yZQHRNFTFXDfNEoWCjelsXFO4XHoHCUqBoIzdU4/Zp0/Yfb
	LCmAi2yVf0vmYb99zTq7KkvoG+r72leIPWCoW5+KYQ2Ti635wvFZlUsUQuzQpx085OTYXAE2UM7
	rGrXiZSdjpV8fQm/rPq8yaV6du6F/efGRf+2gZk3ysckXt8YLYNXI1sS2OWxm45/a4JUM/KEMfV
	mF3MvwKg2kj+n4sGol4X9FfXfFcFscPi9MsQN9k0mcH5pisacBJGaUDQHw6nKE83h9pp61/7iAD
	NFIMnNSYLK23KheBUBQw==
X-Received: by 2002:a05:600c:a148:b0:490:44eb:c1ec with SMTP id 5b1f17b1804b1-492333dafe8mr43904695e9.27.1781699190703;
        Wed, 17 Jun 2026 05:26:30 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a458f2sm150801395e9.3.2026.06.17.05.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 05:26:30 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:26:28 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Li Wang <li.wang@linux.dev>
Cc: akpm@linux-foundation.org, tj@kernel.org, longman@redhat.com, 
	roman.gushchin@linux.dev, hannes@cmpxchg.org, yosry@kernel.org, jiayuan.chen@linux.dev, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, shuah@kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v7 5/8] selftests/cgroup: replace hardcoded page size
 values in test_zswap
Message-ID: <ajKEZn0KP3KmyQd2@localhost.localdomain>
References: <20260424040059.12940-1-li.wang@linux.dev>
 <20260424040059.12940-6-li.wang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yjb7q5g62opqahpv"
Content-Disposition: inline
In-Reply-To: <20260424040059.12940-6-li.wang@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,redhat.com,linux.dev,cmpxchg.org,gmail.com,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17036-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:li.wang@linux.dev,m:akpm@linux-foundation.org,m:tj@kernel.org,m:longman@redhat.com,m:roman.gushchin@linux.dev,m:hannes@cmpxchg.org,m:yosry@kernel.org,m:jiayuan.chen@linux.dev,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,m:shuah@kernel.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mhocko@kernel.org,m:muchun.song@linux.dev,m:shakeel.butt@linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,localhost.localdomain:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE1C3699BCE


--yjb7q5g62opqahpv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 5/8] selftests/cgroup: replace hardcoded page size
 values in test_zswap
MIME-Version: 1.0

On Fri, Apr 24, 2026 at 12:00:56PM +0800, Li Wang <li.wang@linux.dev> wrote:
> @@ -752,6 +753,10 @@ int main(int argc, char **argv)
>  	char root[PATH_MAX];
>  	int i;
> =20
> +	page_size =3D sysconf(_SC_PAGE_SIZE);
> +	if (page_size <=3D 0)
> +		page_size =3D BUF_SIZE;
> +

I'd just fail the whole test if this fails. To have page_size always
represent what it says. (When can this fail anyway? Maybe nommu archs?)

(Rest looks good.)

--yjb7q5g62opqahpv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCajKSbxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AiB9QD+JZid1KLNr2xP2rppXnyG
ZyqJwgVUMqNZfB9Kc0L877YBAP851mEpZbHlmbTPoKRdoUXS0YKDMn1wPVRc2WSE
rWEA
=qqEb
-----END PGP SIGNATURE-----

--yjb7q5g62opqahpv--

