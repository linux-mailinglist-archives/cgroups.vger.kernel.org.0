Return-Path: <cgroups+bounces-13995-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8F7vDEt5lWl8RwIAu9opvQ
	(envelope-from <cgroups+bounces-13995-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 09:33:15 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 682461541A1
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 09:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2EFDB3007AEF
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 08:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701DF31A81A;
	Wed, 18 Feb 2026 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV0DEnxP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D206A2EA169
	for <cgroups@vger.kernel.org>; Wed, 18 Feb 2026 08:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771403514; cv=pass; b=rPYox3aFjwskOGvjFyrg/7IZAdtUciphOLbZh2bvFHr7buG8mSGfRWedaCNY3w22Pyn67GXsytR1sFsPbVEJI22tgzy+13QklT4ufoHUADq7uuMZ5V3HalNnwCvgr0xlU6ZImyo4rBMfjXVEKBZ894meU9NLPj/im/axERbkWLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771403514; c=relaxed/simple;
	bh=g34/cXMgvqM8CAz3Jm7hMSLsp37KovcyCljYWpgZMh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEVP6P6cHlkJESW75vEYmmQpJcyXpH7tCeCFrAfIAkjXeWl0mX5Mwf3TK45buOE4cSzjt6FfnQYOnIYeRPtVStbpFkrXFki2N+TjoapQrcEqd6aH9NLaWY6TTC2f+rTp6FoRZ9a+/yVhwPF/m0p+LB2p10Hy6yS9QKA/NxILLjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cV0DEnxP; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65a36583ef9so1096834a12.0
        for <cgroups@vger.kernel.org>; Wed, 18 Feb 2026 00:31:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771403511; cv=none;
        d=google.com; s=arc-20240605;
        b=bELZPmsgU9dOxU+3aXe+/7LUC7H4uKvB40PNiAHzhLrgX175OiFE/OuT76Hn8aPUfU
         61nxiw54LxKykd4E+HlSQs9AcOcfPSMwjO88sJixoS/kbrjTgLzAT/VBn8xFe4ji9E/J
         a/p6X87+OD4CJZ6sVTuE8Htf42fRt+mudwMv+2noXX4SLNNvjc6Ao5uOTms1H9bsy/lh
         u1s1d7Eb+VIC7Y610U7eDbmY2H+qRKRMqglP9Xnf794TYQGkf6seg8GoyCFsn2UuAA6Z
         8u7ffb2e+DwkF8aO9N5yAxoov7eEQJnq8hUjmoX0nIIE7tghbQw72SkmYQ9qpULNoJ/Q
         F+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T3U76qnvucsTLQ+BdD/Esd8/yZzq4QLRxWdPKbrqOpc=;
        fh=bkuJsyGGNaMI2iEBgxMN1ZmCIePgCwIY+e6PdHxtFPk=;
        b=Mq0vVaNS6YoVUlMTRb0eovYeT9eCjrOazJOu20VEBQHi70xmN4i8HsXoPPfs8XYZhq
         Q9gOaMxR91MCCJyMihKEDT5mWgtHSY+UGIZcVOoOkd/XeCT4v3gXMBNKRNWCUQPPRcSr
         Bg5A+rwWG27HSGQwnUTlU7uR5kV/7v+VYCWosWnYoVmBpIGLvy6xQJTBNqA3wwKXfu/F
         Y2O85RlHAJZZLgWHmLTgTBLgCQWojwYpWqHgSY3Ma8e9JmC5vpWCGoa7A1Nq/bZo3/oh
         eQAyl9Ntp+NtRLu+x0xpZQMuiIbeaYRMQuKw9W/K0XZw6kOkGJSu/g4OlPrrJNORYg7P
         NrZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771403511; x=1772008311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3U76qnvucsTLQ+BdD/Esd8/yZzq4QLRxWdPKbrqOpc=;
        b=cV0DEnxPnsQlkkqBoKaJBnR9i1cJOj5Ru4XBw6d/4t6WYqZol6c/Rbg8DXX1lSuzMt
         NIQhNbv+VUpFyMhdhKtwNP3b2U0XLEzOBaw1HWYP8hYbBtKZjLTYgOAn1jTebwrv0oYt
         D3KOnJZzFbY/lbxTkUlkuF2Tym2dUh1C+/yPV+o183OvaoTKivCEx6dupgrq4JyJNpAm
         ITiNuqapI/kBnRVks42K/JqKr5BbX6fY9dVENXb0XoStRY0/xJtwLIWEgrhRYhJR/Izb
         t/JqDZaAVKQOXy/nIXzHstKYshLIGZ660aXxQy5QwSgrfGJCd0PB8YfuAs+lUvGxPApY
         Izeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771403511; x=1772008311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T3U76qnvucsTLQ+BdD/Esd8/yZzq4QLRxWdPKbrqOpc=;
        b=BzENb+nKw85WWcESYuabEeoVw4tg3WPNajLqN/Eu/EzPLMyFLf1OIdKaDgxvNuYmID
         T6aTMv5v47f0PBg7Ze3AjTNtVmoIBObbFHEIxdIL+spA2QQW6ZE6qOX7Sw7IFtp4jn3s
         dlLShQikzECUQQovvsU/yA23D7dzXb+Wt0C/jW9d/4rbfIpLr57KqhnTukxGa2N8kqwO
         Ai+73ntXbvI/Gef76mto2dBvQbPXV8iGjI/iuVXUCcBSOJVOsvCbTTdVEkJy5QGXOVm0
         QzclHaSf+qy3H0t3FqMErN8RhPicuQorH0IU51o+LiAGfyBq6hp3lE/fm7UquJWqGpk1
         X+XA==
X-Forwarded-Encrypted: i=1; AJvYcCU/fSiKTUGs/oZrYz+2z92Mh2yNGQTSeMxeiAxjz7j76+Z9iwxtiPkljyFc9o7W+nr7KlzvWFo6@vger.kernel.org
X-Gm-Message-State: AOJu0YxMB09uVgvkG4Abh36/V3K/JbaGmn9N9aRXqAJqfr6072ehUhtZ
	yWAp7d0LZhvxz8Cl1NB7U1aZ10zWBjCx2OfzzJoOSjgELReW0Gw998auFp+9V8Y/lTP6/e70M44
	4VK4VmEHibUHQLQqozS/XfXo3gCheQ/o=
X-Gm-Gg: AZuq6aKh+3AbleFmTx5lgldxbQ5Ry7Sg/gVduJ89JDxmBjbrG9lWplHSsKwlmF3u5iY
	KxA1EkZzRI92RHKI0kyTBNhW4SsgLB0IpgmKhKsLbX9er2zF5HTTmKhV5agYkWV8kbJSvJn1Ija
	rEcr6+qteVQjKVu/k+QLesBVaDX9YBFElsuRMiQcS5LVxRhU4lvmg/wka03MUcrqdpLHAA8qXAU
	ipWiMslCA8epNppAv+GA1/1bKhPXKtGKqOtXNJxFPUxnxyQpIK1VZR/rqA58h0CX2NcCyjOsyxp
	jQR9pTws
X-Received: by 2002:a05:6402:1141:b0:65a:4207:fbf0 with SMTP id
 4fb4d7f45d1cf-65c7720cc7bmr375715a12.15.1771403510892; Wed, 18 Feb 2026
 00:31:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218032232.4049467-1-tjmercier@google.com> <20260218032232.4049467-4-tjmercier@google.com>
In-Reply-To: <20260218032232.4049467-4-tjmercier@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 18 Feb 2026 09:31:39 +0100
X-Gm-Features: AaiRm53vob00Ykj2SozMaQzwl7X3rV4VFQLdOBL-uAsZ0fNoE8t3B9B1XVNGy1c
Message-ID: <CAOQ4uxh4js=3yk_RxjY5AZmC4kCMVJzbq+4Wnn3mky-_i75QMw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selftests: memcg: Add tests IN_DELETE_SELF and
 IN_IGNORED on memory.events
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13995-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 682461541A1
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 5:22=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> Add two new tests that verify inotify events are sent when memcg files
> are removed.
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Acked-by: Tejun Heo <tj@kernel.org>

Feel free to add:
Acked-by: Amir Goldstein <amir73il@gmail.com>

Although...

> ---
>  .../selftests/cgroup/test_memcontrol.c        | 122 ++++++++++++++++++
>  1 file changed, 122 insertions(+)
>
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/tes=
ting/selftests/cgroup/test_memcontrol.c
> index 4e1647568c5b..2b065d03b730 100644
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
> @@ -1625,6 +1626,125 @@ static int test_memcg_oom_group_score_events(cons=
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
> +       char *memcg =3D NULL, *child_memcg =3D NULL;
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
> +       if (cg_write(memcg, "cgroup.subtree_control", "+memory"))
> +               goto cleanup;
> +
> +       child_memcg =3D cg_name(memcg, "child");
> +       if (!child_memcg)
> +               goto cleanup;
> +
> +       if (cg_create(child_memcg))
> +               goto cleanup;
> +
> +       fd =3D inotify_init1(0);
> +       if (fd =3D=3D -1)
> +               goto cleanup;
> +
> +       wd =3D inotify_add_watch(fd, cg_control(child_memcg, "memory.even=
ts"), IN_DELETE_SELF);
> +       if (wd =3D=3D -1)
> +               goto cleanup;
> +
> +       cg_write(memcg, "cgroup.subtree_control", "-memory");
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
> +       if (child_memcg)
> +               cg_destroy(child_memcg);
> +       free(child_memcg);
> +       if (memcg)
> +               cg_destroy(memcg);
> +       free(memcg);
> +
> +       return ret;
> +}
> +
> +static int test_memcg_inotify_delete_rmdir(const char *root)
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
>  #define T(x) { x, #x }
>  struct memcg_test {
>         int (*fn)(const char *root);
> @@ -1644,6 +1764,8 @@ struct memcg_test {
>         T(test_memcg_oom_group_leaf_events),
>         T(test_memcg_oom_group_parent_events),
>         T(test_memcg_oom_group_score_events),
> +       T(test_memcg_inotify_delete_file),
> +       T(test_memcg_inotify_delete_rmdir),

How about another test case:
- Watch the cgroup directory (not the child file)
- Destroy cgroup
- Expect IN_DELETE_SELF | IN_ISDIR

I realize that this test won't pass with your implementation (right?)
but that is not ok IMO.

If we wish to make IN_DELETE_SELF available for kernfs,
it should not be confined to regular files IMO.

Thanks,
Amir.

