Return-Path: <cgroups+bounces-14061-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBX9EmqdmGmWKAMAu9opvQ
	(envelope-from <cgroups+bounces-14061-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 18:44:10 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75100169CBB
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 18:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1212A300B9EB
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 17:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBCD366059;
	Fri, 20 Feb 2026 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8fDZ5ig"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88E1366046
	for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771609445; cv=pass; b=r1bdmN7GVqKJphhJb19hyfv8UyyX9vaXZZrP0hpOrqKArrYO9Q9HQENW9zPxxdz/sYHc5kX7wg196zCQG6OzsUBOOzTDJJhmaLYOh2Twum08QYcgs0KDL1vymci5DVcQ4Ef/UzEDUCg7lPx3zJPg+9exdN8DTP7jGzvf5PGcCiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771609445; c=relaxed/simple;
	bh=B4Z1qVLBCGWcijfUcZ0E5ZLSN2ZLUxfaTWpanT2cb1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nU8SPsGFvEtUgXF6kMEuurhOBbct2TqeRcNw2cIVNp3qBf0SmrqPfEqSAUeCDPVjxzCYp+o4XrcAHitQxIMekWkARVZMKesJ7JOSgqOQYJpRXo7gmpqpGcjbYdorVdohkvtQ/j1Isz7thP0oGMDYt4wH8vAbDqvS1RBlTISi+o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8fDZ5ig; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8f7a30515aso281630966b.0
        for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 09:44:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771609442; cv=none;
        d=google.com; s=arc-20240605;
        b=GVxRazi+wpiB2ti3xfPBlx46IUlm6tUB+byQqlrV60c7RY3BRx6QiXhZqH2upJ1P/I
         Ik0sGhj5Ge/008tEHZyGJkl+GewlyYCL1YMJp240ueVhuLHrgD5wCUSAw1TwMP1Ue8ty
         nZj51qBGVWRIqIkPA7w6sEGQ61Gzu02XUXF885TLX0A6Trd9axFL8W1X0IRVql5pRoGP
         oyNy3yOrE5qpE+H9l0qc/Lt0rwuN1PvfdXPVcZu2j3QTQzTe2vxpbIwIB7wnJBMQvFK7
         QBnCmMwFsU1/nS51RRM5bZPZHbF7xOyVI/Prv070i0niVcIPlfjpfBx2DKk1UCc7Rdz/
         9M5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CKefpqt8YPMOlnxoTebgDHlgo2RmH3VSClTRGTDZyAk=;
        fh=Ic8281VgHB8NSkL64BG/SKuhfoQlwcMcCuUSvwrW1PA=;
        b=cIAQRpvkRRqXclBc6He/u1H7yyiOZ8DftzKON4l4gXu6isNUKTcsiNHEOWTi2zKwPL
         wmeU9ZRHB+17elc2lzD5/4EXd34ovVwV6NUh0G+liyxcplFmBzJEe4D8XKaSjclcnj9F
         t9NmS0CjqcHtS81Zr2gyqqls7z+6istsrXsj4TSy2r2ynmtU+q3FyGCSa39cR0pj2ddW
         DQLJqk9b/tAFUn803ZfktPGEDl6S3Bs2c8EpyrNFMMoT8fZKpEvADOZIQkOlf1WOhujq
         R9iYJk3lJOn9QG4p7RfPaZ/BlOAkjoYb1Pw9B6ninPPNokip+LUCzZQUR1SescasGAsk
         o15A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771609442; x=1772214242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKefpqt8YPMOlnxoTebgDHlgo2RmH3VSClTRGTDZyAk=;
        b=c8fDZ5igMeq1VUHwqJ58N5sonmzT3RIi9MFJ+sq+dD/OfYF4liIvkNK1q+DHN7apIT
         tK+thPoXY+FTcXvn7RFiZM1CxlIR4D3PAn2TceNc9G4pFNcnZTmXd+AbYBt1Wj9gO8lh
         JgDCQSRRh3MCr2/PKjiAjufAZ1O4JOeptJVOgADkv4OJGNQ9MHQzofbz058qkNHWmt+T
         Sp4OfR4IZapwEOduVev15bHZjjOMAZIRkyYvM/PCZxHHys5P3FO5OvJQnPPkxDPVHq6F
         RvZX+WC6GmmPzfy8dhz0tuRGH9I8Lwm0apKboYREKCyUlhItu0Co56yRAaDCiIFQgt4L
         Cn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771609442; x=1772214242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CKefpqt8YPMOlnxoTebgDHlgo2RmH3VSClTRGTDZyAk=;
        b=UjZMVbqmUyern5D5KXyJE/4Q5CDlr1skBb1Km/pQhc14Eu5Gbrjqv3D6a+tAl0wExW
         KMDO/4T/yYEKRNpKnoRyaSDZjOV4amhK7FzjJqyWqzuuMSrlN/yKw599LXz/fjVnCabw
         ulMkiFzvcyvzExIvsItEmIZQmKETcFKBxejPjmNO0QNF+JVzDkzlrT7rcJGEOZrtrsvp
         mtL/mOS2XwKMWcYBVIiELQrsARKv0hW+Ff1+vALZsXMCipI/FycldZxnPHN9Wcn1Bf5W
         toyQVPIpq+CmgUmFr0KOfTNROEmFFMIsAGufCIEZAMMLfzyVjZ+r1UqoAst0fEZmdK2B
         kg5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxA+Zv1iRscAsR6lg11u/89AWg2gi4oelBXOtkURlG0Y89bOpSIdUROkkyOcYUvu6OLmxk2eCK@vger.kernel.org
X-Gm-Message-State: AOJu0YyLh1dBbJEcqBmf8EIkxVbss2Ee0vNGLD5yIBeT+wFW7WcZvepW
	Qjhp4QfJL/eutPxcFkYX5MZG15S50Phckg16Oad1GmobPofAWxtZCTEmM/lU80utxxsza2Pgo1M
	sHWwsBq7Rei18egI63CYBXYoHuTO3Nic=
X-Gm-Gg: AZuq6aJQqsoDVMVIMIhGPOh0PsqRozUCaxD8j/ZoKCm6W0/D4GKDexhBi72LL/kvvuA
	qKlVFPeAXz2po7GivFrsABw1JIl9jLfvbdc6tlPAmHekyDdv8IEHO2Vir7zY47PO4/KCdmHfbqU
	C9/mUm+E5CEElCC2edL2mK4XzY1V0NnfEu7iwIebeDBWlw7V0yMyrzfrxtilPM4DNKZMSI1cf4t
	+lWBJvEdB3HZ+p03qasM674U/C5p8vgJgprGzdmuefsh8MvMv2LnBRh8f2cePT0pwBMgvG7YEvh
	f/2o5FSs6hBnc9voZD4KkgGq9nk6FSTWsCy2Vhyzug==
X-Received: by 2002:a17:907:7fa4:b0:b88:448c:be08 with SMTP id
 a640c23a62f3a-b908196ba0bmr21965166b.5.1771609441753; Fri, 20 Feb 2026
 09:44:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220055449.3073-1-tjmercier@google.com> <20260220055449.3073-4-tjmercier@google.com>
In-Reply-To: <20260220055449.3073-4-tjmercier@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Feb 2026 19:43:50 +0200
X-Gm-Features: AaiRm53Yd2hoByeyKZRhB94VwnmInZ2nkUk-ViEeYttOzbObERE3K1f4CUtv2ZM
Message-ID: <CAOQ4uxiPqUzBQAk8Tic7aFMsHtajEWENCTg+CQPMy5XtmS4kBQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14061-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75100169CBB
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 6:55=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> Add two new tests that verify inotify events are sent when memcg files
> or directories are removed with rmdir.
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Acked-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  .../selftests/cgroup/test_memcontrol.c        | 112 ++++++++++++++++++
>  1 file changed, 112 insertions(+)
>
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/tes=
ting/selftests/cgroup/test_memcontrol.c
> index 4e1647568c5b..57726bc82757 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -10,6 +10,7 @@
>  #include <sys/stat.h>
>  #include <sys/types.h>
>  #include <unistd.h>
> +#include <sys/inotify.h>
>  #include <sys/socket.h>
>  #include <sys/wait.h>
>  #include <arpa/inet.h>
> @@ -1625,6 +1626,115 @@ static int test_memcg_oom_group_score_events(cons=
t char *root)
>         return ret;
>  }
>
> +static int read_event(int inotify_fd, int expected_event, int expected_w=
d)
> +{
> +       struct inotify_event event;
> +       ssize_t len =3D 0;
> +
> +       len =3D read(inotify_fd, &event, sizeof(event));
> +       if (len < (ssize_t)sizeof(event))
> +               return -1;
> +
> +       if (event.mask !=3D expected_event || event.wd !=3D expected_wd) =
{
> +               fprintf(stderr,
> +                       "event does not match expected values: mask %d (e=
xpected %d) wd %d (expected %d)\n",
> +                       event.mask, expected_event, event.wd, expected_wd=
);
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
> +static int test_memcg_inotify_delete_file(const char *root)
> +{
> +       int ret =3D KSFT_FAIL;
> +       char *memcg =3D NULL;
> +       int fd, wd;
> +
> +       memcg =3D cg_name(root, "memcg_test_0");
> +
> +       if (!memcg)
> +               goto cleanup;
> +
> +       if (cg_create(memcg))
> +               goto cleanup;
> +
> +       fd =3D inotify_init1(0);
> +       if (fd =3D=3D -1)
> +               goto cleanup;
> +
> +       wd =3D inotify_add_watch(fd, cg_control(memcg, "memory.events"), =
IN_DELETE_SELF);
> +       if (wd =3D=3D -1)
> +               goto cleanup;
> +
> +       if (cg_destroy(memcg))
> +               goto cleanup;
> +       free(memcg);
> +       memcg =3D NULL;
> +
> +       if (read_event(fd, IN_DELETE_SELF, wd))
> +               goto cleanup;
> +
> +       if (read_event(fd, IN_IGNORED, wd))
> +               goto cleanup;
> +
> +       ret =3D KSFT_PASS;
> +
> +cleanup:
> +       if (fd >=3D 0)
> +               close(fd);
> +       if (memcg)
> +               cg_destroy(memcg);
> +       free(memcg);
> +
> +       return ret;
> +}
> +
> +static int test_memcg_inotify_delete_dir(const char *root)
> +{
> +       int ret =3D KSFT_FAIL;
> +       char *memcg =3D NULL;
> +       int fd, wd;
> +
> +       memcg =3D cg_name(root, "memcg_test_0");
> +
> +       if (!memcg)
> +               goto cleanup;
> +
> +       if (cg_create(memcg))
> +               goto cleanup;
> +
> +       fd =3D inotify_init1(0);
> +       if (fd =3D=3D -1)
> +               goto cleanup;
> +
> +       wd =3D inotify_add_watch(fd, memcg, IN_DELETE_SELF);
> +       if (wd =3D=3D -1)
> +               goto cleanup;
> +
> +       if (cg_destroy(memcg))
> +               goto cleanup;
> +       free(memcg);
> +       memcg =3D NULL;
> +
> +       if (read_event(fd, IN_DELETE_SELF, wd))
> +               goto cleanup;


Does this test pass? I expect that listener would get event mask
IN_DELETE_SELF | IN_ISDIR?

Thanks,
Amir.

