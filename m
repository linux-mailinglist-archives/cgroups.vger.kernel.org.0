Return-Path: <cgroups+bounces-17676-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U3a+EVwaVGpZiAMAu9opvQ
	(envelope-from <cgroups+bounces-17676-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 00:51:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F22746352
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 00:51:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RwNt9zUz;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17676-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17676-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 266AA300FC6B
	for <lists+cgroups@lfdr.de>; Sun, 12 Jul 2026 22:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30D9382F25;
	Sun, 12 Jul 2026 22:51:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F690346E40
	for <cgroups@vger.kernel.org>; Sun, 12 Jul 2026 22:51:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783896664; cv=none; b=iJ1aVJViGzJV6+dFvWJX+fJy4XE7dvs84CTGWA7mPASstYtHiYAur1/ardk2lU7L7cmzzOYMmrqBh65lIRBQtA8do9wgXjBToYrkmbkURMCkYiEzvfOPC8voUt56u5Ko4qQSSniGSC61ZHVTP9t4lio39Guq7le98cXt+mPhQvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783896664; c=relaxed/simple;
	bh=Lvl9qfl/E52K7QLGUBXDQqfvmlRKuGOCnos3jpYClP4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=nxmVk4hpQWvaHQ77OHfCMKXYs5sl/qXUSH1JM/X/BquFp9RD8gALL5RvnJ9C19LOeim0Vst/GfqJWGL3y7bOnq+VrAv6/y5eaG/4xAl8MPZakxixzTxdiw8bYUy9+LF5gRJlBf9SK5wEEuzzCjVGHjbhprUTfah3qKIiYqe4HhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwNt9zUz; arc=none smtp.client-ip=209.85.128.169
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81e69a2db34so38026297b3.0
        for <cgroups@vger.kernel.org>; Sun, 12 Jul 2026 15:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783896662; x=1784501462; darn=vger.kernel.org;
        h=content-type:autocrypt:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TJc6i8enkbXcBPC7Ck8EluErz+n+7CzeRLxf3P6RurQ=;
        b=RwNt9zUz0yaOfH+upf7GRErYU9ZheAc7V+lYP0BXPm+35CbZ9lIdXnsozYcxUek7HM
         Snt+TicFcQkhh8CazuXfkwa5lTM6jsUeH7AQYVD/st6vPA1QrDLl7VPG+KUHi5VN1qRB
         vJpUEBzy5pySnuiwK33UROJ8VmJj0ayk0eBl3cFXGkO2SlhSWFBmIttLlgfPxkGJpSJn
         0jgH2AZGgo91TmVxp/byhPo1TsSsU05ucgOYb3k+7PY6wiRMq4dS2o1CidzVHi62pRk8
         3nE6aQk8LMMo342D6E037kBkDP2u38Y33JQtzxILXEaCxbYEAYE9H+SQ/tpyspmpLFIl
         gBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783896662; x=1784501462;
        h=content-type:autocrypt:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TJc6i8enkbXcBPC7Ck8EluErz+n+7CzeRLxf3P6RurQ=;
        b=arvdeIK+SCnqJWpBTM/6LpKRp/IQCxT06W9ai95mS9zCKrQOhsX0YCKijd/hduT9tl
         2ZT1Jl6SJ8BNj4JJmn5lLzFORq7FtBxNg++pfqBZiZuDZZDof2Guzw0DZ8W/cLMCdSjy
         GP01NDbeMUNDuQLQbsrhAYYNDUSfAcCmPf8LD3sbzUU+Uv8zjMRMoZ7BWdZjNM9QXIR+
         587hTGJyUAMspAdvduOWUf+W9WntLiySOHI8iKtbhnw//B83A/2fRb08eOSZKiGY88Tg
         Jv23iUaJz8d5EQFIUfhFCjZeC1P2z3f8CehY0WmM1h+oflryRb1Y5uCN+5RftKNiylhU
         7W8Q==
X-Gm-Message-State: AOJu0Yw0nNkb9qpb7kipPTxeUdveyZfnyxDITyjkR7pKXuIel36JEDpQ
	6AgnJCQ5aSiCZMeXrJZd58HIOVLxvPlzyh/cX5qL77SpBGVOrXCm/JhpoZhzvQ==
X-Gm-Gg: AfdE7cmTQQzksp3hgpp6GTc0k5nWBBZ3qaI/X4bHAESFP4po4WtqFrBTv8XW9EpLtNx
	XpR4CrLqPduuqqgUNFVsFlAFSPQvnrYY9BWa01af8TN1YYb3SwgQBseDIwtPa4+qw+Opt4ikE3W
	G498WZL6NYJ0mrwbtLUI8sVPuT2uLbX32dURYaNWn+QbpaxfKkjj3GImpV0iBt9ge1eith4SyqZ
	Q9RBWh5Y9rswpWG6HvdqRXFLdaKVlk99sSCRnNFhq2S3Cnn61Ucwr8b8kfWZ8xuF1jgIwrrVARw
	KSw6/Ml4obD6Dq9XlJJHLI+WrRmwQNlWyLfEvC/47F0wRyINbYUH10ZaVr2XSKLeVt1Dyirz+/S
	fGpXMy7rlEp2BY2p83zH78bWYiOmRpzLB5qyhbYXTvandAAbRMIcfA2zkcJwFAumoTW6uW64428
	I5d3q9S6FNxJzrA1E=
X-Received: by 2002:a05:690c:4b90:b0:81d:78e2:2a8b with SMTP id 00721157ae682-81e90030f47mr51404197b3.7.1783896662234;
        Sun, 12 Jul 2026 15:51:02 -0700 (PDT)
Received: from [10.138.10.6] ([185.98.168.14])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6be98397sm100947477b3.6.2026.07.12.15.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 15:51:01 -0700 (PDT)
Message-ID: <d83a6cc2-73bf-46fd-9ec2-abd667828d6e@gmail.com>
Date: Sun, 12 Jul 2026 18:50:57 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Demi Marie Obenour <demiobenour@gmail.com>
Subject: Implementing a control group manager that isn't a persistent daemon
To: Linux cgroups development <cgroups@vger.kernel.org>
Cc: Alyssa Ross <hi@alyssa.is>,
 Spectrum OS Development <devel@spectrum-os.org>
Content-Language: en-US
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------m95a235L8206E0EafVABCIbB"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-17676-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[demiobenour@gmail.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	FORGED_RECIPIENTS(0.00)[m:cgroups@vger.kernel.org,m:hi@alyssa.is,m:devel@spectrum-os.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[demiobenour@gmail.com,cgroups@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84F22746352

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------m95a235L8206E0EafVABCIbB
Content-Type: multipart/mixed; boundary="------------E5nSkM05pLhFvO3uMbWqDQjK";
 protected-headers="v1"; hp="clear"
Message-ID: <d83a6cc2-73bf-46fd-9ec2-abd667828d6e@gmail.com>
Date: Sun, 12 Jul 2026 18:50:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Demi Marie Obenour <demiobenour@gmail.com>
Subject: Implementing a control group manager that isn't a persistent daemon
To: Linux cgroups development <cgroups@vger.kernel.org>
Cc: Alyssa Ross <hi@alyssa.is>,
 Spectrum OS Development <devel@spectrum-os.org>
Content-Language: en-US
Autocrypt: addr=demiobenour@gmail.com; keydata=
 xsFNBFp+A0oBEADffj6anl9/BHhUSxGTICeVl2tob7hPDdhHNgPR4C8xlYt5q49yB+l2nipd
 aq+4Gk6FZfqC825TKl7eRpUjMriwle4r3R0ydSIGcy4M6eb0IcxmuPYfbWpr/si88QKgyGSV
 Z7GeNW1UnzTdhYHuFlk8dBSmB1fzhEYEk0RcJqg4AKoq6/3/UorR+FaSuVwT7rqzGrTlscnT
 DlPWgRzrQ3jssesI7sZLm82E3pJSgaUoCdCOlL7MMPCJwI8JpPlBedRpe9tfVyfu3euTPLPx
 wcV3L/cfWPGSL4PofBtB8NUU6QwYiQ9Hzx4xOyn67zW73/G0Q2vPPRst8LBDqlxLjbtx/WLR
 6h3nBc3eyuZ+q62HS1pJ5EvUT1vjyJ1ySrqtUXWQ4XlZyoEFUfpJxJoN0A9HCxmHGVckzTRl
 5FMWo8TCniHynNXsBtDQbabt7aNEOaAJdE7to0AH3T/Bvwzcp0ZJtBk0EM6YeMLtotUut7h2
 Bkg1b//r6bTBswMBXVJ5H44Qf0+eKeUg7whSC9qpYOzzrm7+0r9F5u3qF8ZTx55TJc2g656C
 9a1P1MYVysLvkLvS4H+crmxA/i08Tc1h+x9RRvqba4lSzZ6/Tmt60DPM5Sc4R0nSm9BBff0N
 m0bSNRS8InXdO1Aq3362QKX2NOwcL5YaStwODNyZUqF7izjK4QARAQABzTxEZW1pIE1hcmll
 IE9iZW5vdXIgKGxvdmVyIG9mIGNvZGluZykgPGRlbWlvYmVub3VyQGdtYWlsLmNvbT7CwXgE
 EwECACIFAlp+A0oCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJELKItV//nCLBhr8Q
 AK/xrb4wyi71xII2hkFBpT59ObLN+32FQT7R3lbZRjVFjc6yMUjOb1H/hJVxx+yo5gsSj5LS
 9AwggioUSrcUKldfA/PKKai2mzTlUDxTcF3vKx6iMXKA6AqwAw4B57ZEJoMM6egm57TV19kz
 PMc879NV2nc6+elaKl+/kbVeD3qvBuEwsTe2Do3HAAdrfUG/j9erwIk6gha/Hp9yZlCnPTX+
 VK+xifQqt8RtMqS5R/S8z0msJMI/ajNU03kFjOpqrYziv6OZLJ5cuKb3bZU5aoaRQRDzkFIR
 6aqtFLTohTo20QywXwRa39uFaOT/0YMpNyel0kdOszFOykTEGI2u+kja35g9TkH90kkBTG+a
 EWttIht0Hy6YFmwjcAxisSakBuHnHuMSOiyRQLu43ej2+mDWgItLZ48Mu0C3IG1seeQDjEYP
 tqvyZ6bGkf2Vj+L6wLoLLIhRZxQOedqArIk/Sb2SzQYuxN44IDRt+3ZcDqsPppoKcxSyd1Ny
 2tpvjYJXlfKmOYLhTWs8nwlAlSHX/c/jz/ywwf7eSvGknToo1Y0VpRtoxMaKW1nvH0OeCSVJ
 itfRP7YbiRVc2aNqWPCSgtqHAuVraBRbAFLKh9d2rKFB3BmynTUpc1BQLJP8+D5oNyb8Ts4x
 Xd3iV/uD8JLGJfYZIR7oGWFLP4uZ3tkneDfYzsFNBFp+A0oBEAC9ynZI9LU+uJkMeEJeJyQ/
 8VFkCJQPQZEsIGzOTlPnwvVna0AS86n2Z+rK7R/usYs5iJCZ55/JISWd8xD57ue0eB47bcJv
 VqGlObI2DEG8TwaW0O0duRhDgzMEL4t1KdRAepIESBEA/iPpI4gfUbVEIEQuqdqQyO4GAe+M
 kD0Hy5JH/0qgFmbaSegNTdQg5iqYjRZ3ttiswalql1/iSyv1WYeC1OAs+2BLOAT2NEggSiVO
 txEfgewsQtCWi8H1SoirakIfo45Hz0tk/Ad9ZWh2PvOGt97Ka85o4TLJxgJJqGEnqcFUZnJJ
 riwoaRIS8N2C8/nEM53jb1sH0gYddMU3QxY7dYNLIUrRKQeNkF30dK7V6JRH7pleRlf+wQcN
 fRAIUrNlatj9TxwivQrKnC9aIFFHEy/0mAgtrQShcMRmMgVlRoOA5B8RTulRLCmkafvwuhs6
 dCxN0GNAORIVVFxjx9Vn7OqYPgwiofZ6SbEl0hgPyWBQvE85klFLZLoj7p+joDY1XNQztmfA
 rnJ9x+YV4igjWImINAZSlmEcYtd+xy3Li/8oeYDAqrsnrOjb+WvGhCykJk4urBog2LNtcyCj
 kTs7F+WeXGUo0NDhbd3Z6AyFfqeF7uJ3D5hlpX2nI9no/ugPrrTVoVZAgrrnNz0iZG2DVx46
 x913pVKHl5mlYQARAQABwsFfBBgBAgAJBQJafgNKAhsMAAoJELKItV//nCLBwNIP/AiIHE8b
 oIqReFQyaMzxq6lE4YZCZNj65B/nkDOvodSiwfwjjVVE2V3iEzxMHbgyTCGA67+Bo/d5aQGj
 gn0TPtsGzelyQHipaUzEyrsceUGWYoKXYyVWKEfyh0cDfnd9diAm3VeNqchtcMpoehETH8fr
 RHnJdBcjf112PzQSdKC6kqU0Q196c4Vp5HDOQfNiDnTf7gZSj0BraHOByy9LEDCLhQiCmr+2
 E0rW4tBtDAn2HkT9uf32ZGqJCn1O+2uVfFhGu6vPE5qkqrbSE8TG+03H8ecU2q50zgHWPdHM
 OBvy3EhzfAh2VmOSTcRK+tSUe/u3wdLRDPwv/DTzGI36Kgky9MsDC5gpIwNbOJP2G/q1wT1o
 Gkw4IXfWv2ufWiXqJ+k7HEi2N1sree7Dy9KBCqb+ca1vFhYPDJfhP75I/VnzHVssZ/rYZ9+5
 1yDoUABoNdJNSGUYl+Yh9Pw9pE3Kt4EFzUlFZWbE4xKL/NPno+z4J9aWemLLszcYz/u3XnbO
 vUSQHSrmfOzX3cV4yfmjM5lewgSstoxGyTx2M8enslgdXhPthZlDnTnOT+C+OTsh8+m5tos8
 HQjaPM01MKBiAqdPgksm1wu2DrrwUi6ChRVTUBcj6+/9IJ81H2P2gJk3Ls3AVIxIffLoY34E
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT

--------------E5nSkM05pLhFvO3uMbWqDQjK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello!

I'm currently implementing a control group manager that isn't a
persistent daemon.  Instead, it's a command-line tool.  The system
I'm working on uses s6 instead of systemd, and s6 doesn't have native
control group support.

The current plan is to offer a few options:

1. Create a cgroup if it doesn't exist.  If it does, wait for it to
   be empty.  Then execute a program in that cgroup.

2. Create a program in a cgroup, without waiting for the cgroup to
   be empty.
  =20
2. Kill all programs in a cgroup.

Unfortunately, I'm not able to wait for a cgroup to become empty.
I don't seem to be getting EPOLLPRI or EPOLLERR events.  What
is the proper way to get those events?  Is there a kernel version
with a bug in this area?
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)



--------------E5nSkM05pLhFvO3uMbWqDQjK--

--------------m95a235L8206E0EafVABCIbB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmpUGlEACgkQszaHOrMp
8lNVkg//Xa8KQvJB6oSh/K1Ww3HmTYayegRNxDvQ+itoW4X7RUgIZHLHvouh1e1f
Uyjqit/C9hyjQxqY6LV2ZjLP/q1MtINjYqXmTzDvfopKLMPEd17xTHBMJg9o9VqI
7/jPb2E7/bWlX45SHU0EWWewZ8iMX16euLqT0pz1C2LmTYwjyCcP6X+hRFbJcTIy
EA4sa8O5fe/485yFIG000GKRW/QGAirkG+eHAGYd/El83/k4Rzlv9QhQHZ9xhMkY
98sZEAqUssouWLfseJMedMQWjqOAghiRs09NJz8D0oEdmrlsI/zR85CosFAuLOy3
GFhuRZ1zur5LCe4mLRx06XNHpqBrrXUWg167bDeL7c6y0TpuWFPeJJLMe8x8ifuH
wI3mhCNJ9/jA78q65FplztWPbe/455+ISauhReq940VQnwL9akfzqkRePPac8/df
w+G6uuJExu5bD7+X9h87omqhmRUIdJB7TVfIUElOYOEILS/odsTo1BRgiWtr9JZo
geS4/Soa8K2jJ8pexTaBWJ6UCTb4bbDrm5pqn9i1PYJsF7rGRI/Nu2Z6pFLX0xCN
tMBQ4/efND+cHMWeNGzcXsyXZFcDpL1pjHI8XVyvM5T6pDZXueA5NwwnCuQ47SAl
irplYPW+c+JVqKu8z8TX3oa+QfXlR0sj/cgzXKf4XkCxDsjm/+k=
=z63Z
-----END PGP SIGNATURE-----

--------------m95a235L8206E0EafVABCIbB--

