Return-Path: <cgroups+bounces-14088-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAEbKlDZmWkkXAMAu9opvQ
	(envelope-from <cgroups+bounces-14088-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 17:12:00 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DA63916D3E9
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 17:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57BA4300C541
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 16:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A002E22AB;
	Sat, 21 Feb 2026 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUq9u3+l"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC5E2DFA32
	for <cgroups@vger.kernel.org>; Sat, 21 Feb 2026 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771690305; cv=pass; b=dJfg1CEC32Vy/r4g6+6toRHizin4IHINGbKi6ifPikvYu4r2r7R4rF9WZJjJuln7NKK8V1dQBekzl+9oSEaidDFxSe0k4II7JKaz56TLMeKX9GfMpXr/SWfyu2pt28E+jNVC9G1b6j9xX0Iq+Y65zVqr/EXB1OAeTgHJ4triO6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771690305; c=relaxed/simple;
	bh=WFk2dMGDXodWdBOsas5Wh8VEIYFRodTYZpiky7YPwy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5PySLYujkPzSYAHKcPpMbFOss3Z/Tt6dGSI6t22wMedmalQJcAJiDF21+YjAbaQUUn5bs8QRhoNe0r+OMUXlVWBWqmaPhOtjAGEEnXbFlZ4Oy4b2mNd9c/T7uJq6mhNZn32yuBoet6xpdChmZMkdtctbNeOmmgs//cd2FFP1Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUq9u3+l; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9080841899so104044166b.3
        for <cgroups@vger.kernel.org>; Sat, 21 Feb 2026 08:11:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771690301; cv=none;
        d=google.com; s=arc-20240605;
        b=N0jtbBwobL9VjiMG9wXWbkxeMxLqxfS05LZbSIFTQcyiGbtCfL3VFLKxXk46khVd5d
         gZEHA5hAqXpYphpNtVmABxsc8oor0SNwLRYXSVKuKDEsBQhTShiE1aHRj1FqYgOy8bBA
         V0zCk/Ze0y/M3kNn6RCa/z7yk9HAps4r1XJhRzT+tiuQDVKDY0h4+/08shPoku/Ia02o
         EsEAt+vwLXagdjaYatXg4Oqa2YG8q/jSX5Bnx5LqIxYYO8+kUXyf0M16Ng8spsHYhnIi
         bm2684a8dzsS7iH7szke3xKaKa8JtOrzBpn1ZFXURMRiSpIIBBYiV3Q7RJdSdP0/wiBQ
         BD8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WFk2dMGDXodWdBOsas5Wh8VEIYFRodTYZpiky7YPwy4=;
        fh=OnUbzGFKM6EcwQKF1ggNjMAHP9XW8uxBWOln5uNsgO0=;
        b=HkjLePG3RysnT1p1t87zljH9saPcnj2RepmGOWBpEN/MZGox27dwMryDJSkY3SVSYq
         JEcgZO9nOWdM/fsvAenqoHBKQ+dh3c1NlSr3u5SsWWSIlr5OtfqVCRlp5pJzbP4iZ/gN
         6rYdGtZtZH7o+YAMjQearyuIeyp40OMX0q50iRlUiUEy+BxDLkrpCx12xzjbdklyfV4h
         zqMpUkG7XA3zBCI7u4GZ+0RnMmP2JG05i/L5suvGb39yZmjbUjlUSokeOiHcGTq/0NFF
         ZxDfS2QFr3i9Tyh/268XijB6pfTC+rUIzrTzQOVW43htGszcoukc1vPDMf/AQws/XkFj
         aokw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771690301; x=1772295101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFk2dMGDXodWdBOsas5Wh8VEIYFRodTYZpiky7YPwy4=;
        b=mUq9u3+llNJriYI2iwd1k/lQn3+8PEXC+MxxmLdX0Vc+O7L2bRz6K6Vg2tqRQK0zTP
         xSIO3mrf4GBmMe+1tX76JdAyziIp1yvfGsfTbbnP11I6HREYNrbrtWeF6ZmurwzUFMla
         RKnzD6D8LboyPVC5h6EJE+QZOI/yOpXWZDJQKCPyO1YFzqJ7Uu10iwSSQgKdtS1UmA/9
         wj5g4w7bzma9fUx1ocFMwjUouGaUi4gN4uskGBC0e9Wt0uA1bSYORgn8Y6iJuOJJ7vAL
         unam2Y5dvjZUsDfOIbju6Br2uv4rOQvBrTBqQ5nCLsuIUoS8zK9fKuv6N7zJYah6ag6/
         7+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771690301; x=1772295101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WFk2dMGDXodWdBOsas5Wh8VEIYFRodTYZpiky7YPwy4=;
        b=ZY2p/hhcUYxfHzIsx9Rsn/pvVh6YEUfX7sHD23OnSiek+u1QTjr93PHXN5tHvxIzO7
         VRkmNHqyirI64BoJ77YiXGz6l0zw8FTn9qHUrZAsigHbmTOSnvlYr38RDA4agpQBAEM6
         OBaEFRxv5+i1nncePD50PP/AkoYphcK0qN4gYPsjxguzJjKxhVBd1HxyEClZoYqsCEo6
         GJ9hP5VU2Mqa1vu/zrnGefC2UsceQH8g/znRDjvDi2QRspHSnsDInaqnjGO1v6gBNGYq
         WN8dwMiAe7PtTDx6vO8YOHZ21KOz68cL8rVDWPrTZfvEi9rNeCegwwASXwYU7n2zpNgJ
         wFhw==
X-Forwarded-Encrypted: i=1; AJvYcCXWRWMWvIpRtERMliKYEG+Q05RaDzTXX7eceBZy7TwkTsoVVTrMzp8GUQi3SJnTfOPwPkk6jtie@vger.kernel.org
X-Gm-Message-State: AOJu0YwL8amEMCkPt8deKy+ptQGlR4bwfgSNFTzd0HjT1S0CvTLPDazV
	wQXMEgtXcU5cekxM7rTpGU1UaxxPp627SAncvCuOGPZeRqh84rE9zZwAL+CcSX/TQ6lqvkJrksq
	xoCPQFD92Y5XPn+IBB6a9VVR2nnZpPUw=
X-Gm-Gg: AZuq6aJ0NJB8ySiPyIo7TWL2HiDN6TPc6yfyH2xlBWu85vRegDu/WKXjgWEUP4aoEUD
	rkcXTtKQh6QV8teckyi1jPy+wNhaDwxPkj6v6/AvHUQALdJBVuXqFqr//WB/2y1hpG5Zwqr7xmR
	6PgBGsOm1lb+rmm+6b4qzQ9igAJyU4ECLYn3n+Hzwn3N65wcs9d1Om+9mWHEW7pTyfAGRP8DGKy
	PCvPB+Edaq121J18wOulbg/wgRir7G6PLsv4Eaz/aVIy7SzsO1eFqE54qvsxZkHeL7FoWmOW9Jb
	YauW3bD8096Kz9OQufQyBYLcmtN0Zj25t2dw9ciZ
X-Received: by 2002:a17:906:474a:b0:b87:7938:7b77 with SMTP id
 a640c23a62f3a-b9081b4adbfmr135784766b.30.1771690300450; Sat, 21 Feb 2026
 08:11:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220055449.3073-1-tjmercier@google.com> <20260220055449.3073-3-tjmercier@google.com>
 <aZh-orwoaeAh52Bf@slm.duckdns.org> <CAOQ4uxjgXa1q-8-ajSBwza-Tkv91tFP-_wWzCQPW+PwJMehEWA@mail.gmail.com>
 <aZi6_K-pSRwAe7F5@slm.duckdns.org> <CAOQ4uxjZZSRBwZ2ZL31juAUu0-sAUnPrJWvQuJ2NDaWZMeq0Fg@mail.gmail.com>
 <aZju-GFHf8Eez-07@slm.duckdns.org>
In-Reply-To: <aZju-GFHf8Eez-07@slm.duckdns.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 21 Feb 2026 18:11:28 +0200
X-Gm-Features: AaiRm50siD9H0RcvpiyV5fyHjGmjcm9TLE2lBYwftlepNHL-uvxe1pX7UaXUvqc
Message-ID: <CAOQ4uxgzuxaLt2xs5a5snu9CBA_4esQ_+t0Wb6CX4M5OqM5AOA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14088-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DA63916D3E9
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 12:32=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Amir.
>
> On Fri, Feb 20, 2026 at 10:11:15PM +0200, Amir Goldstein wrote:
> > > Yeah, that can be useful. For cgroupfs, there would probably need to =
be a
> > > way to scope it so that it can be used on delegation boundaries too (=
which
> > > we can require to coincide with cgroup NS boundaries).
> >
> > I have no idea what the above means.
> > I could ask Gemini or you and I prefer the latter ;)
>
> Ah, you chose wrong. :)
>
> > What are delegation boundaries and NFS boundaries in this context?
>
> cgroup delegation is giving control of a subtree to someone else:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/tree/Docume=
ntation/admin-guide/cgroup-v2.rst#n537
>
> There's an old way of doing it by changing perms on some files and new wa=
y
> using cgroup namespace.
>
> > > Would it be possible to make FAN_MNT_ATTACH work for that?
> >
> > FAN_MNT_ATTACH is an event generated on a mntns object.
> > If "cgroup NS boundaries" is referring to a mntns object and if
> > this object is available in the context of cgroup create/destroy
> > then it should be possible.
>
> Great, yes, cgroup namespace way should work then.
>
> > But FAN_MNT_ATTACH reports a mountid. Is there a mountid
> > to report on cgroup create? Probably not?
>
> Sorry, I thought that was per-mount recursive file event monitoring.
> FAN_MARK_MOUNT looks like the right thing if we want to allow monitoring
> cgroup creations / destructions in a subtree without recursively watching
> each cgroup.

The problem sounds very similar to subtree monitoring for mkdir/rmdir on
a filesystem, which is a problem that we have not yet solved.

The problem with FAN_MARK_MOUNT is that it does not support the
events CREATE/DELETE, because those events are currently
monitored in context where the mount is not available and anyway
what users want to get notified on a deleted file/dir in a subtree
regardless of the mount through which the create/delete was done.

Since commit 58f5fbeb367ff ("fanotify: support watching filesystems
and mounts inside userns") and fnaotify groups can be associated
with a userns.

I was thinking that we can have a model where events are delivered
to a listener based on whether or not the uid/gid of the object are
mappable to the userns of the group.

In a filesystem, this criteria cannot guarantee the subtree isolation.
I imagine that for delegated cgroups this criteria could match what
you need, but I am basing this on pure speculation.

Thanks,
Amir.

