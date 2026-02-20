Return-Path: <cgroups+bounces-14072-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMjRJA7AmGnuLgMAu9opvQ
	(envelope-from <cgroups+bounces-14072-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 21:11:58 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 354D516A92C
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 21:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5692A300DE1C
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 20:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7937366055;
	Fri, 20 Feb 2026 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8mkqqus"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9D434C81F
	for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 20:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771618289; cv=pass; b=sgv934cxSkI0LLdFDN1i4qhNn3H7uH7KnntrIZkY6tVPaUsQ3KkcX0aJ8gyhWdvdZw592DfS91BmCusgplCqHNYMqbVguUZC3dwC+DFGVU97eJQlQ6ZzMny4OY9wVCOt1tuEAlTVQm+ubcTS1n25twIH+L/ClmiGG+W+MpPw660=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771618289; c=relaxed/simple;
	bh=8JIRve8c15z5WReqA76soUL+Zt57OlSrG42LMMnF8oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vrt6vh+MWzb3D77a7HjsLksotU/1cTQu/UCvIAgfGCaCo1UrlpLpnhOxayECFkDJe30358iiN/Jf1b/BFxpyYADYzN2iZ3tbzXt3Yy8p5aQ5x6FJwdwXCdxxT0Na+M/Pej0HpoO40zVNHwo3Cjag4jzhrkwNLgsqOt5JxzicU+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8mkqqus; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65a2fea1a1eso5632532a12.0
        for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 12:11:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771618287; cv=none;
        d=google.com; s=arc-20240605;
        b=DrOyDqpcKVS8/Z6sQKIItOpOiVlBjX0pg+G5dZAu5zvNOT74/PJDJu2pgZYW0KmP0R
         yxFZ+lzwFeJaS0m4gfycUU2XyMkFJ13TfySGJY2snINfV6WhttbFub0CMLZ9P01lH6xU
         6exOyUgZLfXilgWe5eFL2yoW55qPDGuTO5SRL7Plep6GKya2PL8NL+uELqwXT/SFfvxs
         7ItKpPjG2oDaAtjZsse5qNuEy1vA4fPFzjM0zcefFxaah7mC8RxejEcTB/mmLAxnCgbZ
         cSGTw1k8jG4IRl/ZHxI8EFXyD4ELeO+TXl9Kf1tBpW9v9uBiQGToRAkea3yzi4/vvXEo
         6dNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8JIRve8c15z5WReqA76soUL+Zt57OlSrG42LMMnF8oo=;
        fh=Qr/j0mq2yt52Pg9YYZHdtHfrWWxRluyh4IvhNdoJeyo=;
        b=PySzKSeIKcopKkiJpeFh+bf70QfLOQlBBVNxAM2iF/cD5B7PgSELL2zXNMrLtDZKX1
         xjQkJk6SMWtWZHBvnomgUl7Be7bc9VBleJJf0XuDJch18T1jhXatqV/VBQrfW19E3omn
         Xmz2aZJ9EjTssaVCdxW4ZDSD/CkWyDmjNTVDfDXAb93ubNKkosku69XX/3Ys9jQpi/2I
         qLjqJ9To199dLUVrsrGvIavuUgd82KEYYX8gTi7UnclaZYq1XzsHM6RB8LYhoCDf/Xgm
         DO2sYGpUrVhjY9233TB1QEcXLaX3vGjBwPviVsSb7EtBw0FuFwEVwKaXBy7ggHSjvAS1
         KT4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771618287; x=1772223087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JIRve8c15z5WReqA76soUL+Zt57OlSrG42LMMnF8oo=;
        b=f8mkqqusXyvhQHYJaW28XHtVosjcC4aCNi5gxBqXFpMFduCOtx9B4ESK58h4qjyURX
         qbdSwrNMJo1V38YR0AweM7yRTBdzEmfCrRbB6+uJNSAOAYLWRVr0QPhSIfPCYZMZGJD2
         HXOQ47u/T3UIOdn1rCIQ7gP0+OSV/ZwCtJqC0oUxradIsOcPcqFsQZRATEPAbyLstIaf
         0UVCLltkLCpFNLjhei+C/BzUpWD2X9/A0yVzKWHIFS6RPERFDv/ZC7h6+OrSsf006ydK
         Y9liG18m7K0QpNMGP3FJ3+3h+2cSaIToBz78h3p4z6Hp6bqTxisdE1uSEXqS+/TddAEp
         ymyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771618287; x=1772223087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8JIRve8c15z5WReqA76soUL+Zt57OlSrG42LMMnF8oo=;
        b=ZU1Yy6TTNRkTrtn2ulWCerppK2m6Bq2rPwPLgoXkwuTPviU5jGzNbVTGyQ7QVvg5PA
         pd8OgOsrHYq/1eJF21ZLjsdbQtVNA6+4Fcu+GW/cIdEhYkMFS3iINFiF/okZzNTZK+lp
         IVFK9NgYQ3p3Qke8YQlsa6d8U/iL4RLa2ViaxJEDhcpK746O88LPJXUyLrcZ0cFqAbG0
         0dv6w4VY8E34tZXcix4VN629AvD1la7wX0Bfwxat/ckUGwdR/1+KvzQ8ru9i8MJbnfLI
         cvZR8rrCLgsnpCPiQwU2eQwjEeZE2BnamilzkswmmhXj5o3iHnZLdXd3ti0huXqdepYe
         sR7w==
X-Forwarded-Encrypted: i=1; AJvYcCUn5bscg4s3VD8cCBjhZ/p0nuvNBYIz42cIDQMqo9JbSiCL5+e4Wxo30j8J5Q3k1HDKkqxv/V6V@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4kPBXriLSamr12JCxVNlL/NbiUrb9kVgvFIx4VukBczb8Xbfj
	6wQm0j61UYatmLFbv6EM0EZO0gRvKyrWJD6zXsaMR7j8InMMzcMr1FZtlNfUu6DXSrNERV3T+IT
	wF1YlekBpZw5enutzfrzaj3EqVhZnc6k=
X-Gm-Gg: AZuq6aLV/q3Y3ouANJJIBwTey8q7GCHcHcMoBvmsKGqAo+pAoNOJgtg+zzUXT8uopRG
	EqXlR7l/v3HVbV558bwWgYn5jN5n3l0+VfrmT85PThaJGuiMKwSz2g12Uv69k8kSyAwNmTiedKC
	D4WThNUCrZ2SPOAHcenGNWAq9BeNtdFqKLuC3LE7aGovYGedeSHLJRzfwbjn+KDjMRTAw4BVTY1
	zuZJaUPYaE8kTGR2LgZe4Cya/nNAvuasJUaGisBt82lkdXUNQd4Nddrwb/wtdw2HztWYhzrF4Vz
	B21z5yVrg7QHFW8GGqGmc1X1Xqf7ndXNrcNGH+zVRw==
X-Received: by 2002:a17:907:1b25:b0:b3a:8070:e269 with SMTP id
 a640c23a62f3a-b9081089466mr60024866b.14.1771618286359; Fri, 20 Feb 2026
 12:11:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220055449.3073-1-tjmercier@google.com> <20260220055449.3073-3-tjmercier@google.com>
 <aZh-orwoaeAh52Bf@slm.duckdns.org> <CAOQ4uxjgXa1q-8-ajSBwza-Tkv91tFP-_wWzCQPW+PwJMehEWA@mail.gmail.com>
 <aZi6_K-pSRwAe7F5@slm.duckdns.org>
In-Reply-To: <aZi6_K-pSRwAe7F5@slm.duckdns.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Feb 2026 22:11:15 +0200
X-Gm-Features: AaiRm51G-BEIzt0SxbA22TK8LiihbDavtfXN5tpD9EpODADyVmlHbWbL_HHf7gc
Message-ID: <CAOQ4uxjZZSRBwZ2ZL31juAUu0-sAUnPrJWvQuJ2NDaWZMeq0Fg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] kernfs: Send IN_DELETE_SELF and IN_IGNORED
To: Tejun Heo <tj@kernel.org>
Cc: "T.J. Mercier" <tjmercier@google.com>, gregkh@linuxfoundation.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14072-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 354D516A92C
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 8:50=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Feb 20, 2026 at 07:15:56PM +0200, Amir Goldstein wrote:
> ...
> > > Adding a comment with the above content would probably be useful. It =
also
> > > might be worthwhile to note that fanotify recursive monitoring wouldn=
't work
> > > reliably as cgroups can go away while inodes are not attached.
> >
> > Sigh.. it's a shame to grow more weird semantics.
>
> Yeah, I mean, kernfs *is* weird.
>
> > But I take this back to the POV of "remote" vs. "local" vfs notificatio=
ns.
> > the IN_DELETE_SELF events added by this change are actually
> > "local" vfs notifications.
> >
> > If we would want to support monitoring cgroups fs super block
> > for all added/removed cgroups with fanotify, we would be able
> > to implement this as "remote" notifications and in this case, adding
> > explicit fsnotify() calls could make sense.
>
> Yeah, that can be useful. For cgroupfs, there would probably need to be a
> way to scope it so that it can be used on delegation boundaries too (whic=
h
> we can require to coincide with cgroup NS boundaries).

I have no idea what the above means.
I could ask Gemini or you and I prefer the latter ;)
What are delegation boundaries and NFS boundaries in this context?

> Would it be possible to make FAN_MNT_ATTACH work for that?
>

FAN_MNT_ATTACH is an event generated on a mntns object.
If "cgroup NS boundaries" is referring to a mntns object and if
this object is available in the context of cgroup create/destroy
then it should be possible.

But FAN_MNT_ATTACH reports a mountid. Is there a mountid
to report on cgroup create? Probably not?

Thanks,
Amir.

