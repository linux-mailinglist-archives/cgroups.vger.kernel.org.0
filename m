Return-Path: <cgroups+bounces-14065-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OI8Fo6hmGkPKQMAu9opvQ
	(envelope-from <cgroups+bounces-14065-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 19:01:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE821169F2B
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 19:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BDE73011C58
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 18:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108C928314E;
	Fri, 20 Feb 2026 18:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqeJPybR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A92C23AB8D
	for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771610502; cv=pass; b=nO1HZo+bhh9vVikLPt8Y9AkCRfWVTWb4UEL1UC5c72HxDWfg7e/FtwIn5QGdsMDvCcJJb6+xBwc0AFm33qMCbLAOyWPP7oLq8hhn5SKeJlFGJj14en2g8Pd4ER6r31/ZZi8Eb80LLNK11PpEGbxWBTpluFSBicf+BxnXGTiemQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771610502; c=relaxed/simple;
	bh=/ExTJNGlpE5IqT17n1+JjF2Vry3iY2HGRkuHp4SOpO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/TsiOXHbmYzI8yF4JeAyl7RjfvHOLNqiR0J3J4lLsfXNccoVnkZH73uGjY1ZQ3ozqLHXy5y+8TTYXAUkJ8UYaw0KmB65paiZE/xCgZcRWoJWL30voLpjUwuXahp6e7TLP6EUN0FNLo2jpX65zm2p2xaJ1lrdYjkRPcUGQETI8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqeJPybR; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65a380b554bso4489335a12.2
        for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 10:01:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771610500; cv=none;
        d=google.com; s=arc-20240605;
        b=ITEOPanP67v/HzwWSc6q3Ditc0hhUxWwZSNUSkjwuUBarKF18AH+R0N6LuQxqqVhAw
         2UDg0eTIgtSrjLTUNu7IIu+ahKvTCrTA7FxgABTkc6khC27M1fnLUsbr++Cnj37FDV9S
         htk2RRYDFqjrvh1m6HL8b2HGezxiiAiV7CK0iYUE6cqzdF0R1+ezkr9ixqOkyUmW3buf
         RneLlJ50HTD0CcIKBcGh7ZIAmq/FfqggtaE1e2Dvd+5OLkLQmzPLll27Puen+I4A++xd
         4H6G5Gp5N6gVNmjWhVpVobfYFQ/fyJzOan43O0Vgq1Vy2gOJA4xvQwm7lRhGq8YcVZIo
         A68g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mXWsRVT7W81X5HarW7ujq+K0yQZiRQ3sefS+9HVuiEs=;
        fh=Vzr6L+cHvwdNXO8LMaLG3elmmvKFBGeOTJ+LnZsW3e4=;
        b=Pgx7NRc2fUUEh85DY97D4kH6BrHk6rAJbb49w12eQfXHJz2NEaBD6MjM4tUAgo0679
         WE8qOqcPDHCbUh7T0YUEwz/P+ihGAkyVC+qkH67zUz9FMwlsqkiVyZj4tOXD+/mHuhpn
         C++B3iMqwpYvSzJIHwoR3eajk4Yp662DiuitYE612EvINuZVQsdshfJ4tyzSS5V8ZtGc
         mCKtnPFQQ+pAtG4X+scpwg4JTgy8fvKfSLQ1jNvV5DWAsfYLQGmpdCvl0nVEZ8kbC8pL
         l/h4iOb04L7xA9pnxYocaOYex+0PsICKDqo9MW7WTtHDAc8JFCcXnEMtf4DkK2mKtvQj
         E/9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771610500; x=1772215300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXWsRVT7W81X5HarW7ujq+K0yQZiRQ3sefS+9HVuiEs=;
        b=QqeJPybRLGSHeMJ/OFsJM09BDSFsYFbQ3t4OkN4vv5GyuFG+FCJoIAHfCYEW9ZcNMx
         Esb3AwxclKidVoXWhkLwmsGRkqkgJGeMGzPmJtLsaLdk7pnC+a58b7p91+dX8DOuV4pi
         djMi+T2rX8Egzcf+pncVov8yaCbVXBvdXbfUcQC79mDurp117cjXbRSWY8rZtM1MhEUo
         bPYU82soriTLtcc3dwJRvsh+1cCI7qtVIJ0+VNZtm+k1FMPp0uoBXxaMDVeDw9LfNJDi
         thY1ISYHcx5roiKcN5jUqvt4djY2DHtPjuYJUAYJAtsY5eLxoPU+bRmQmVhOMWQHO1hl
         1fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771610500; x=1772215300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mXWsRVT7W81X5HarW7ujq+K0yQZiRQ3sefS+9HVuiEs=;
        b=cEj/s0LeX8aiyssPuiN6+SIAigUZPytmuaRs2HjSFaeT41kcNlKC9XTprzHG7JjM7m
         NXVXc+PgtsZVSmvBx00byJJG+YyIvIHdsCqBenCptuYk1oAghBWvgoD27pI7LbgPWsed
         j8KNMvsYWUG3CVlcrSUjUB14+hUugu8fLRf2DW6vt9Bav5gP/atak2Dl2+zpBPBPZd2r
         zNq1yzqv7lIBZfGFH+OIexFAdzf+qHtpNtUUUiFd1ZQk+QndvSk9GLwA7u7e8uodZ01Z
         A+okm16b5r8m2/uTqUhYwIcUb9RmiSUYqceKI+XpXVS9ROCGBLlJUTYe8pE1ORSI9ShQ
         wlXg==
X-Forwarded-Encrypted: i=1; AJvYcCXtLZAxEZSMcUpkXRL+d/4CXJjobPe7ycfG+29+Ez/eqZObzKWjc2XwNK69EfGJwzve2F+gLkhY@vger.kernel.org
X-Gm-Message-State: AOJu0YzZPNWV2btYvnxKx17XRo5nEYA9+LOh/AlAK7No7tWNxUT15IYs
	cUvib9G7gR+JclnWQoBTTuuUpG+8tVykk/g68ypuymTRX8Xg2z8FFezGmb1oUHNmTGbgFjlr6iI
	KVQCHUPCsATQE3lWsE8mn5b7ULouduoQtMY8B
X-Gm-Gg: AZuq6aIZUU88/nbj+94gC9MPk7OcQ+r/H4QO8w/63bvFGZh3qlTw6GyfcI61H+uT+Gl
	PJhkD7coJyUNQf2fhfjeEHg0jPeztwT3LS2nCLcUXXaTBOKk2jEqZcMCo2V57C+Do9u9DmTd3BB
	S2I1GrgiY5PBUY7p5GGljqqKjTf1nFvIo7Vz45704+p84yBL4kzdSk5GkDYBHz8SkU0g6iAUQgx
	WJyy4ofFsrUylBZ/hR37Uh9Wfqsth0wagy13d7wHLrCBXLBgLsbsQ5Z9QsvAbz+gnJur2pG//p1
	zk/Snbkvdcs82Yq5S8kwaILZaIsD5aF8+a9KX68fKA==
X-Received: by 2002:a17:907:1c89:b0:b88:5182:b869 with SMTP id
 a640c23a62f3a-b9081a490f8mr28173866b.23.1771610499642; Fri, 20 Feb 2026
 10:01:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220055449.3073-1-tjmercier@google.com> <20260220055449.3073-4-tjmercier@google.com>
 <CAOQ4uxiPqUzBQAk8Tic7aFMsHtajEWENCTg+CQPMy5XtmS4kBQ@mail.gmail.com>
 <CABdmKX3Pd8sJpzuQD0tfKCznOy3=cDoAOEnN-COQa59weUFrqw@mail.gmail.com> <CABdmKX0H5Bx7qsk7JmOEnA2NZBHXd+QSYuwXHQGvaN6ppM38NA@mail.gmail.com>
In-Reply-To: <CABdmKX0H5Bx7qsk7JmOEnA2NZBHXd+QSYuwXHQGvaN6ppM38NA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Feb 2026 20:01:28 +0200
X-Gm-Features: AaiRm5108EmSEAIlvJnftlLPzXZCKopsIxjc3etyrxL3lbPc5X0FWzsfY5M1N74
Message-ID: <CAOQ4uxi8-nc2+b5kjZshaDdfhmt994zUDqJ32B5b+600_Ep48A@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selftests: memcg: Add tests for IN_DELETE_SELF and IN_IGNORED
To: "T.J. Mercier" <tjmercier@google.com>
Cc: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14065-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: EE821169F2B
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 6:53=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> On Fri, Feb 20, 2026 at 9:46=E2=80=AFAM T.J. Mercier <tjmercier@google.co=
m> wrote:
> >
> > On Fri, Feb 20, 2026 at 9:44=E2=80=AFAM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > >
> > > On Fri, Feb 20, 2026 at 6:55=E2=80=AFAM T.J. Mercier <tjmercier@googl=
e.com> wrote:
> > > >
> > > > Add two new tests that verify inotify events are sent when memcg fi=
les
> > > > or directories are removed with rmdir.
> > > >
> > > > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > > > Acked-by: Tejun Heo <tj@kernel.org>
> > > > Acked-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >  .../selftests/cgroup/test_memcontrol.c        | 112 ++++++++++++++=
++++
> > > >  1 file changed, 112 insertions(+)
> > > >
> > > > diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/too=
ls/testing/selftests/cgroup/test_memcontrol.c
> > > > index 4e1647568c5b..57726bc82757 100644
> > > > --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> > > > +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> > > > @@ -10,6 +10,7 @@
> > > >  #include <sys/stat.h>
> > > >  #include <sys/types.h>
> > > >  #include <unistd.h>
> > > > +#include <sys/inotify.h>
> > > >  #include <sys/socket.h>
> > > >  #include <sys/wait.h>
> > > >  #include <arpa/inet.h>
> > > > @@ -1625,6 +1626,115 @@ static int test_memcg_oom_group_score_event=
s(const char *root)
> > > >         return ret;
> > > >  }
> > > >
> > > > +static int read_event(int inotify_fd, int expected_event, int expe=
cted_wd)
> > > > +{
> > > > +       struct inotify_event event;
> > > > +       ssize_t len =3D 0;
> > > > +
> > > > +       len =3D read(inotify_fd, &event, sizeof(event));
> > > > +       if (len < (ssize_t)sizeof(event))
> > > > +               return -1;
> > > > +
> > > > +       if (event.mask !=3D expected_event || event.wd !=3D expecte=
d_wd) {
> > > > +               fprintf(stderr,
> > > > +                       "event does not match expected values: mask=
 %d (expected %d) wd %d (expected %d)\n",
> > > > +                       event.mask, expected_event, event.wd, expec=
ted_wd);
> > > > +               return -1;
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int test_memcg_inotify_delete_file(const char *root)
> > > > +{
> > > > +       int ret =3D KSFT_FAIL;
> > > > +       char *memcg =3D NULL;
> > > > +       int fd, wd;
> > > > +
> > > > +       memcg =3D cg_name(root, "memcg_test_0");
> > > > +
> > > > +       if (!memcg)
> > > > +               goto cleanup;
> > > > +
> > > > +       if (cg_create(memcg))
> > > > +               goto cleanup;
> > > > +
> > > > +       fd =3D inotify_init1(0);
> > > > +       if (fd =3D=3D -1)
> > > > +               goto cleanup;
> > > > +
> > > > +       wd =3D inotify_add_watch(fd, cg_control(memcg, "memory.even=
ts"), IN_DELETE_SELF);
> > > > +       if (wd =3D=3D -1)
> > > > +               goto cleanup;
> > > > +
> > > > +       if (cg_destroy(memcg))
> > > > +               goto cleanup;
> > > > +       free(memcg);
> > > > +       memcg =3D NULL;
> > > > +
> > > > +       if (read_event(fd, IN_DELETE_SELF, wd))
> > > > +               goto cleanup;
> > > > +
> > > > +       if (read_event(fd, IN_IGNORED, wd))
> > > > +               goto cleanup;
> > > > +
> > > > +       ret =3D KSFT_PASS;
> > > > +
> > > > +cleanup:
> > > > +       if (fd >=3D 0)
> > > > +               close(fd);
> > > > +       if (memcg)
> > > > +               cg_destroy(memcg);
> > > > +       free(memcg);
> > > > +
> > > > +       return ret;
> > > > +}
> > > > +
> > > > +static int test_memcg_inotify_delete_dir(const char *root)
> > > > +{
> > > > +       int ret =3D KSFT_FAIL;
> > > > +       char *memcg =3D NULL;
> > > > +       int fd, wd;
> > > > +
> > > > +       memcg =3D cg_name(root, "memcg_test_0");
> > > > +
> > > > +       if (!memcg)
> > > > +               goto cleanup;
> > > > +
> > > > +       if (cg_create(memcg))
> > > > +               goto cleanup;
> > > > +
> > > > +       fd =3D inotify_init1(0);
> > > > +       if (fd =3D=3D -1)
> > > > +               goto cleanup;
> > > > +
> > > > +       wd =3D inotify_add_watch(fd, memcg, IN_DELETE_SELF);
> > > > +       if (wd =3D=3D -1)
> > > > +               goto cleanup;
> > > > +
> > > > +       if (cg_destroy(memcg))
> > > > +               goto cleanup;
> > > > +       free(memcg);
> > > > +       memcg =3D NULL;
> > > > +
> > > > +       if (read_event(fd, IN_DELETE_SELF, wd))
> > > > +               goto cleanup;
> > >
> > >
> > > Does this test pass? I expect that listener would get event mask
> > > IN_DELETE_SELF | IN_ISDIR?
> >
> > Yes, I tested on 4 different machines across different filesystems and
> > none of them set IN_ISDIR with IN_DELETE_SELF. The inotify docs say,
> > "may be set"... I wonder if that is wishful thinking?
>
> Oh, very intentional:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/f=
s/notify/inotify/inotify_fsnotify.c?h=3Dv6.19#n109

LOL yeh ok :)

Thanks for checking

Amir.

