Return-Path: <cgroups+bounces-14063-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI8EE6GfmGnJKAMAu9opvQ
	(envelope-from <cgroups+bounces-14063-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 18:53:37 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AED6E169E7D
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 18:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5904300D0EB
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 17:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF75365A13;
	Fri, 20 Feb 2026 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nXcuvZEX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9989B34DCFD
	for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771610014; cv=pass; b=SIcytq9jghzeiVCPIRCbZAgeksxXa4tGg8nDRus6lNVWjNJ+9wTjmUQrWazVRE+9fH8eswrhzKmWI/kRNZom9dDGO3HlWTgkQtl5sjz1gps4iIijYKZQkQLOq1VIKhvVqgqwVotPq0fLTQg2BrwE93GGywDftpnEHPPOb+D/8wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771610014; c=relaxed/simple;
	bh=6mvexzEJMyqKObc2kptqIRTofWhm/82iwmnJl33CcXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uzJshDmxj4bl+45x/FmtoZuXmMrJzRrTewYJ2Og0uF/K9si0WKKRMdQbQbQSqfCDLpvaJgHYzklMhcsEZMykme/0MrO92DVbFa7pRWAqE2OWlfT38+AqH4W5apZvp4bOMlMzwjNsqtMVvBun8EGKCIjoirs8go4qpbOBKp4vwGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nXcuvZEX; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48371d2f661so1485e9.1
        for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 09:53:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771610011; cv=none;
        d=google.com; s=arc-20240605;
        b=PoV1lFmwLsnPA6rhmScrjEi0V+qrRkXMOsZgkgKKofRgGuicuk0wUW08/T1k4sfyxd
         zJ5byI4Nic3POyM/tqOqgWYfz6vKVPaQ9X+D99QHiWRhjErHKZrKRdjEV4AwSNTNyaxv
         34z1CKwHyMxvNE9FeE6LnFMfy2iM2NAdYELNR9wmWCmCk39bHjk8+EKNXVMRBKz856/R
         gvtLoVcoLp04OzUHSIIpMYz/M3rtU5JGaASDXvFsQlHYojj4bdOdQW/TWt9CQG5CDJ8f
         sG32YH/n0J+oqum6HpFPaqivDlPnqd+eXJNBL9GOCy5ssgyOkaWs0zA+V1XLrvS39WfP
         1lcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zJXYxrDbswnHka6Gtr3ub6RBkdkqHTgw9iEO6yYMyQA=;
        fh=7X/ifYNdH8VA6MIrGG7YAnbMbhBIv5BAUz2pFVCuXdw=;
        b=Wgbwc/dyiYsKRoAPUR9Q3I+HUuCgkFOFNLYtBnCZZ1uSQJLrfkYsAXDY1KZ5s+TVtU
         1yQsu9/Dcq0WC6erBGx9QYG3t9ihRAqa9bDvvqbXHIwT0ME/OD1Vv0pe8US3fx1lSU3d
         3YBJnWhU8CB/vHmTVVMES02B5y9loP2wb1i4D68y2wxiQdb8qjes9pezS0iqS1tVle7y
         yag0xEiNr7LqLjAG39vByrRppvfFLR7Hdd8FhPatlKRLSLcespO1Qej8sGg42SYq1gyZ
         G9HJB+O8Nb8Uw+UouEQZYI3J7CVZsVrev1OquuJLCFv1CXxGpunnjpYo29Fc/Q5pltK9
         HVeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771610011; x=1772214811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJXYxrDbswnHka6Gtr3ub6RBkdkqHTgw9iEO6yYMyQA=;
        b=nXcuvZEXEWY34qR4P1PnDNzmW5L7fA/ROo55L2FZL2edN8qWc0KP6Ep0buoG4gHwf9
         163C3S5der9Bg61gCQNOJb32WMulYxfd+3NILzcEVGM+I1viLf+8znNnq62SYuvt/3HA
         xXMDUyOIU/al8/vp6NEAaHLJoMy/5njiZLrpIWDi8Ps9wmQbguh0mtUMVgKnyOMze1cx
         Tv7iVAkbrPc0shb7IQqiVAG1TW9ksSQ6UxwpNABLEyGSQWE2qeHzQ1ne08eLbGWoSYmI
         nAoPgBqdVe2MqFUb4blxRhIZdNL0J2GQ6meBDkZHL7KcaUgIvH18g4s594hKunwC2AGz
         QZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771610011; x=1772214811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zJXYxrDbswnHka6Gtr3ub6RBkdkqHTgw9iEO6yYMyQA=;
        b=c8GjajRqzWBPnTvjOG/ns5ldqgdxeDRXxJMF+8N+dCMaqvLODrFH+Q7ODcgTewjkE1
         GHZ0t4VW49vgizAveenIuBHcxSwRKtfs8aP2e9HuN3yr7WbvCN6IfUNFm6Fq275cD8TQ
         VLPV9tg7Cy/x9KhoIc0dqGyE9YiaTjwS9EwlcgemxNTqjxhZxE30NfHAkbYCgyQYhsNz
         d8JzPcYCsOF0LAjom0Fuxp7TwNjiokwkjxZt4fdBir+gJcYv+Ins+ke3HpExTkimjtK3
         Pqr+Vv7VOHhvXcZT7/EQ7MAgY5W4oE8Vxy6zTX3xzJ2a/f0gN/uTu335oM2bTAy+TE1Z
         U82g==
X-Forwarded-Encrypted: i=1; AJvYcCWTqwPY55qrGmOq1zlhWiSt0g2U6axXz+mOWrdWnIolzDzqiX6UdJZsIS+ZPQAKrAUt2ofAgl43@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7HSqZyGOfS+EOqkRmwiIm9qrwrjZHH1ZyRxXd/KHnorwrJPwK
	D4/VlXpGM5bW16mNZExBOg9uBcwKQW1+dq3164Scb1oLrqEpENM03ZEnX/2sOQSHf02mB57az3+
	KIDDO2f2tUGnTCoQQlkT6BDyRPNbItqXDXV+DnRuR
X-Gm-Gg: AZuq6aIW+pi+ZodDiFaYi0fyMeBPnKY6Cu+UDklvEJyL7xTutNrtmUtmUdPuAFqxqtG
	wVeJbv+d1fZrThYAaEI34SFHJzUQGkYZXZEj0muEN5wDOlS151WLWTQF+G5uPtFaOHX2DxsxkiD
	Mry08phC14sq40FeRxucQufXDgo+OEcusrVGLRBDtyTaUTNM/dCtJ/Y1MMCZkwba6RTb3VQMnCg
	l77z+6qo5zLdgQ/XvyA7flwh2n80AErc0yXZPlBafhNay+Q2N1QkIa5rRm34hApY2rghyaVzWDe
	69FEpnI00j2ZBMIIr983RCI4U2pD6Ku6jAOlUw==
X-Received: by 2002:a05:600c:5916:b0:47d:7428:d00c with SMTP id
 5b1f17b1804b1-483a4426fcfmr611355e9.17.1771610010645; Fri, 20 Feb 2026
 09:53:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220055449.3073-1-tjmercier@google.com> <20260220055449.3073-4-tjmercier@google.com>
 <CAOQ4uxiPqUzBQAk8Tic7aFMsHtajEWENCTg+CQPMy5XtmS4kBQ@mail.gmail.com> <CABdmKX3Pd8sJpzuQD0tfKCznOy3=cDoAOEnN-COQa59weUFrqw@mail.gmail.com>
In-Reply-To: <CABdmKX3Pd8sJpzuQD0tfKCznOy3=cDoAOEnN-COQa59weUFrqw@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 20 Feb 2026 09:53:18 -0800
X-Gm-Features: AaiRm523izsi0NGn8Sj7ziPjsd_zQLpE-spc-8PJpygVLLpqc8KPVf5Y_qsAi4o
Message-ID: <CABdmKX0H5Bx7qsk7JmOEnA2NZBHXd+QSYuwXHQGvaN6ppM38NA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selftests: memcg: Add tests for IN_DELETE_SELF and IN_IGNORED
To: Amir Goldstein <amir73il@gmail.com>
Cc: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14063-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AED6E169E7D
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 9:46=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> On Fri, Feb 20, 2026 at 9:44=E2=80=AFAM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Fri, Feb 20, 2026 at 6:55=E2=80=AFAM T.J. Mercier <tjmercier@google.=
com> wrote:
> > >
> > > Add two new tests that verify inotify events are sent when memcg file=
s
> > > or directories are removed with rmdir.
> > >
> > > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > > Acked-by: Tejun Heo <tj@kernel.org>
> > > Acked-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  .../selftests/cgroup/test_memcontrol.c        | 112 ++++++++++++++++=
++
> > >  1 file changed, 112 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools=
/testing/selftests/cgroup/test_memcontrol.c
> > > index 4e1647568c5b..57726bc82757 100644
> > > --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> > > +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> > > @@ -10,6 +10,7 @@
> > >  #include <sys/stat.h>
> > >  #include <sys/types.h>
> > >  #include <unistd.h>
> > > +#include <sys/inotify.h>
> > >  #include <sys/socket.h>
> > >  #include <sys/wait.h>
> > >  #include <arpa/inet.h>
> > > @@ -1625,6 +1626,115 @@ static int test_memcg_oom_group_score_events(=
const char *root)
> > >         return ret;
> > >  }
> > >
> > > +static int read_event(int inotify_fd, int expected_event, int expect=
ed_wd)
> > > +{
> > > +       struct inotify_event event;
> > > +       ssize_t len =3D 0;
> > > +
> > > +       len =3D read(inotify_fd, &event, sizeof(event));
> > > +       if (len < (ssize_t)sizeof(event))
> > > +               return -1;
> > > +
> > > +       if (event.mask !=3D expected_event || event.wd !=3D expected_=
wd) {
> > > +               fprintf(stderr,
> > > +                       "event does not match expected values: mask %=
d (expected %d) wd %d (expected %d)\n",
> > > +                       event.mask, expected_event, event.wd, expecte=
d_wd);
> > > +               return -1;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int test_memcg_inotify_delete_file(const char *root)
> > > +{
> > > +       int ret =3D KSFT_FAIL;
> > > +       char *memcg =3D NULL;
> > > +       int fd, wd;
> > > +
> > > +       memcg =3D cg_name(root, "memcg_test_0");
> > > +
> > > +       if (!memcg)
> > > +               goto cleanup;
> > > +
> > > +       if (cg_create(memcg))
> > > +               goto cleanup;
> > > +
> > > +       fd =3D inotify_init1(0);
> > > +       if (fd =3D=3D -1)
> > > +               goto cleanup;
> > > +
> > > +       wd =3D inotify_add_watch(fd, cg_control(memcg, "memory.events=
"), IN_DELETE_SELF);
> > > +       if (wd =3D=3D -1)
> > > +               goto cleanup;
> > > +
> > > +       if (cg_destroy(memcg))
> > > +               goto cleanup;
> > > +       free(memcg);
> > > +       memcg =3D NULL;
> > > +
> > > +       if (read_event(fd, IN_DELETE_SELF, wd))
> > > +               goto cleanup;
> > > +
> > > +       if (read_event(fd, IN_IGNORED, wd))
> > > +               goto cleanup;
> > > +
> > > +       ret =3D KSFT_PASS;
> > > +
> > > +cleanup:
> > > +       if (fd >=3D 0)
> > > +               close(fd);
> > > +       if (memcg)
> > > +               cg_destroy(memcg);
> > > +       free(memcg);
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +static int test_memcg_inotify_delete_dir(const char *root)
> > > +{
> > > +       int ret =3D KSFT_FAIL;
> > > +       char *memcg =3D NULL;
> > > +       int fd, wd;
> > > +
> > > +       memcg =3D cg_name(root, "memcg_test_0");
> > > +
> > > +       if (!memcg)
> > > +               goto cleanup;
> > > +
> > > +       if (cg_create(memcg))
> > > +               goto cleanup;
> > > +
> > > +       fd =3D inotify_init1(0);
> > > +       if (fd =3D=3D -1)
> > > +               goto cleanup;
> > > +
> > > +       wd =3D inotify_add_watch(fd, memcg, IN_DELETE_SELF);
> > > +       if (wd =3D=3D -1)
> > > +               goto cleanup;
> > > +
> > > +       if (cg_destroy(memcg))
> > > +               goto cleanup;
> > > +       free(memcg);
> > > +       memcg =3D NULL;
> > > +
> > > +       if (read_event(fd, IN_DELETE_SELF, wd))
> > > +               goto cleanup;
> >
> >
> > Does this test pass? I expect that listener would get event mask
> > IN_DELETE_SELF | IN_ISDIR?
>
> Yes, I tested on 4 different machines across different filesystems and
> none of them set IN_ISDIR with IN_DELETE_SELF. The inotify docs say,
> "may be set"... I wonder if that is wishful thinking?

Oh, very intentional:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/=
notify/inotify/inotify_fsnotify.c?h=3Dv6.19#n109

