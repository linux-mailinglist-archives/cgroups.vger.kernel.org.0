Return-Path: <cgroups+bounces-13857-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B0bN0OXjGnhrQAAu9opvQ
	(envelope-from <cgroups+bounces-13857-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 15:50:43 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFBE125541
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 15:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C286C301E3DA
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 14:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE3D23EAB0;
	Wed, 11 Feb 2026 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="GwZo8z3P"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBD21FDA92
	for <cgroups@vger.kernel.org>; Wed, 11 Feb 2026 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770821420; cv=pass; b=KfzkllD0anOjHRXOo/wdrEXNLCm5BekjrU09wIcDYpALPp/Z6ZSKxSGepuZMKg3l2C/MQItPWmIUYcTRX2DjJLy5M6ZB343UbGqAde3GhUYF7/ofJQvVjWx7zexk3A9Mkfg0j9f+asx/eis4l17ZZ8ujvgOonPt9MWzkQ4xEr34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770821420; c=relaxed/simple;
	bh=PIZO4zWbF+NUU+GCLHSS8RQAVJrGdA7z/NBa9GU35+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYnaGCif22VMC6awyJ4KRe4NEXnSEyiALCNktdEOKU4EdWoLehXjTnhcNaApx7J582xI+rp7ykPvZC5M1MS9QCLGYc1csGVdPEAGqZeA8fKuG1/PXr6btkwBQkaq22o6E1hTSqEq7nmQiUyU2OY1ctD9fDO1mAM0hLW6u4Qz408=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=GwZo8z3P; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59e4a04f059so5125107e87.2
        for <cgroups@vger.kernel.org>; Wed, 11 Feb 2026 06:50:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770821417; cv=none;
        d=google.com; s=arc-20240605;
        b=cqSNMoUZFH2qkykzZTN4C7CzHMliI+5AE7lc9GIlz5ZPkqdn86KyoyQ2QC3NcnlvRE
         GeiHRnrpvtQB5ptdRMIhG0GQfoS/CPkKdNKWjHbRitEXO4NSnAo0VFfuRLKzepDHvoLe
         mv6FHJsFOd2fFdst8Kz2GmEiIqHf1MfP3C9z9W9UvO32uLmFdTkvhSlO1ZRblcWQBtpD
         zTLDSvOAvYCp6/Zw/LvOz+ZXkFiNMKvqS4htzKjaJokEkI2R5rinmw5cZNfn6/bGFa4C
         +wMv7e9vyMTOiOPqjciyJRR1Xh9faeKGAdWi4KPwE6R24mY8q7fFEwJUfONozl9Ms7Z5
         S5GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RAC+65n1y5536yQ1ZiRJeZwn2G0HSBvLr2Csp67WCk0=;
        fh=XvYpOJrMurihHh6su9dre5DGTKrBz5hd2gHuWlKyAcg=;
        b=BTp921Gl7pI15YlHv1Mgf6P/0mQjPEp3GdrduKdINYNigQl5Lk8zNx/96kTuFbqF9A
         4FXXt14Fzhjb9KVeuWYs4nYkDlW3M6zsnF3OVsltIxYAFkJmxrH8wA1Fg6RyLh16ZjHL
         r1IPIMSLF8c8jtUq/AtOUYmGrzpM9qnEBDmBRviRKBKCzdhO4nnFCYyDyTrIUXD2mACz
         V1U9qOqlzO2Zy6qB3ODW0qqshl/CoZkXovasiKAWDqZpo3Kz3mh/eKMGxDozqNDpop1o
         B9HjLTXLauajLI+yx3BS5V99aVyldhuZ9eGn1qwcTcyDPbRvXzWZEPGSqKgsqMJFtx4K
         cMfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1770821417; x=1771426217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAC+65n1y5536yQ1ZiRJeZwn2G0HSBvLr2Csp67WCk0=;
        b=GwZo8z3PM8FeUV92W3i3UxB5osFH5fFcKb5cB19gJN3jB6qMHhK6QHLWc2vqaxvMfB
         +p5jdgPac6eTAsHv9sgM4WdN07YLCjb5XxYY1NtL0RIMrUPG0mWK0dfHaK30QRAlcp1/
         iQWDx8SYzbGz4MIgvihYQv4fpnO7m/w87I0jTK0Zxclw+h8pL+En1T6dcSjQwDP5HIpC
         5zz6pSgXVCiqkq06UEaIJ67+vcu+sabzF7IW12E4kBSwqvXfzQKlpd9Gkv3OBu4BNQgq
         HcH9QF5C73bEt/oENxedk+KfRaKmNaCcONXjAZ+sE75Hd+sm0YA4Pe7V1OAV0c3r1y4t
         Xf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770821417; x=1771426217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RAC+65n1y5536yQ1ZiRJeZwn2G0HSBvLr2Csp67WCk0=;
        b=wJcLvkbnIRToShyvNWo2Qa411NlxqDtot3rRwYQGeSQ/SVVs2pj59XxWeG0ZqutPSE
         g7uHkBIHSXSkd81Rr4ud5tP8bY0l76czpmBbEsxaRaZ2v3JD0yEktqhcyYmIVZ8NiLZu
         d4NNxt4eU3veeFWj9uETI5tWZA9EaOnb+JXUn5PxYBS//K9Ut54M5lDtd6QjuMGgGjuO
         KUCiU3DnuzBtcgWdDcCdlQ82pCnzoZA/VdBoQQ4O5qBNlj6PHgXTy8kNMHp9hWUOJ10O
         wu3QhG0LCsgMAoxCraC85pixfaQCKTafhDL0AcycYtD1i25oRuwGdoQte4GsEuIJX8a+
         XtbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXor6IsaMrY8XIhehKf385cdYBPj3En2+OP8uFvc2iv0sv5RhOgghUqmIa4MXLt+taUfLKaGka5@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh2nb7KUlzhABNWJ1RYBXR1jmSkVKhQ3W7MTAJD4x8/vC5a666
	BxHSVxaSX4vxMsaNFOkmi2wL2LaXumkdWvqQC0ihLxK6BxqDpznrrM/iVwYRTKVeJhwQy/1bZ6T
	bvqNWDZXR91zpvxfTF3qNXnOSIb2+8Hn8t9u32Z9+Qw==
X-Gm-Gg: AZuq6aKdTRcKZ4xWO6h1IhYmnLxYq4ibVx139tPbo6m2xlLMsBRv7cZqs5YDV2m82Z0
	6kpiB9yVq5/f1cfLntoiEkU8qkiVitjgEk0k8OcK2qZ2IGmmRydv9QhJjllOJX5N9K5wareUGwJ
	d8jknbX+05GYxvOvlL9c62C/3tDrXH6dVNeR3ScHUD0dlVQniEmk2wOGqRd62OjndgcPORGqi2Q
	f+04pIWvrGK0DuRAeoMs8zsYDt5YU8o5L6soXUOfy/Cu2Zt9kq3N8Y0CX7TqaZ5S8ztH1VCOxKh
	5uE8iazKJTzke8M/Pg==
X-Received: by 2002:a05:6512:1194:b0:59e:708:cf56 with SMTP id
 2adb3069b0e04-59e5c3ee06emr1300142e87.26.1770821417457; Wed, 11 Feb 2026
 06:50:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114110837.84126-1-yizhou.tang@shopee.com> <guqq2cm3mk5qf45rcman3twiu7vax4sgkrhj23jrjb26tt3sk3@bh2h6s7givfq>
In-Reply-To: <guqq2cm3mk5qf45rcman3twiu7vax4sgkrhj23jrjb26tt3sk3@bh2h6s7givfq>
From: Tang Yizhou <yizhou.tang@shopee.com>
Date: Wed, 11 Feb 2026 22:50:06 +0800
X-Gm-Features: AZwV_QhP2qypkkBWSmBbgy6MSHPCepLJ3_C7202fgqAdyJeO3YQmLs4TKMN5fFU
Message-ID: <CACuPKxnY0Uo6RU5Cw2_fS=hQcjUBwiA+G3U-LUaviVYyf0Pojw@mail.gmail.com>
Subject: Re: [PATCH] docs: Fix blk-iolatency peer throttling description
To: Jonathan Corbet <corbet@lwn.net>
Cc: tj@kernel.org, axboe@kernel.dk, hch@lst.de, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[shopee.com,reject];
	R_DKIM_ALLOW(-0.20)[shopee.com:s=shopee.com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yizhou.tang@shopee.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13857-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[shopee.com:+]
X-Rspamd-Queue-Id: 5FFBE125541
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 9:37=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Wed, Jan 14, 2026 at 07:08:37PM +0800, Tang Yizhou <yizhou.tang@shopee=
.com> wrote:
> > From: Tang Yizhou <yizhou.tang@shopee.com>
> >
> > The current text states that peers with a lower latency target are
> > throttled, which is the opposite of the actual behavior. In fact,
> > blk-iolatency throttles peer groups with a higher latency target in ord=
er
> > to protect the more latency-sensitive group.
> >
> > In addition, peer groups without a configured latency target are also
> > throttled, as they are treated as lower priority compared to groups wit=
h
> > explicit latency requirements.
> >
> > Update the documentation to reflect the correct throttling behavior.
> >
> > Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
>
> Not a big deal but it could've been confusing.
>
>
> Acked-by: Michal Koutn=C3=BD <mkoutny@suse.com>

Hi Jon, just checking in, do you think this patch is ready to be merged?

Best regards,
Yi

