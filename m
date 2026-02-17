Return-Path: <cgroups+bounces-13981-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOJdIT/BlGkwHgIAu9opvQ
	(envelope-from <cgroups+bounces-13981-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 20:27:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4837E14FA49
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 20:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8FF63046086
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 19:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B38377561;
	Tue, 17 Feb 2026 19:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HvnoZR8z"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04666374735
	for <cgroups@vger.kernel.org>; Tue, 17 Feb 2026 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771356474; cv=pass; b=HJXzFPswMZMPlShx03vJMRpAb+DCfI5y/gQr3rS7ndXz1EfIsDWre4qc/iMyKopQYKOikiDNlDsxbebAJavtOm7wgAb9oRlpNFv0zC0c52nKllw/36JK8Em/WxvMEiRtGZfeYCW6GA3YnUn/JAS75cfoZf0bzh9A9N36h6M0L/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771356474; c=relaxed/simple;
	bh=2AkZD/xZt0VUvR9sJ0sGJHU4a65qrHn4YVu35A++2Jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHWcpbKTIRwcp/UMQBBFIbpK5E+ffFwZzbBOAGvnv5+nXdPxl+LVS6vyyoyD8eOaKnoMiD2QvCe24LIoFI1Ima0eT+gqB93tQqcpdcJgCVY+mWj5e2AQYlVXXV9J+pioWzvJiJKsUu7dITTAq3v3nPeZrjk/tPSuonDwyuZMWjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HvnoZR8z; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48373ad38d2so10395e9.0
        for <cgroups@vger.kernel.org>; Tue, 17 Feb 2026 11:27:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771356471; cv=none;
        d=google.com; s=arc-20240605;
        b=JKg0dFNg7iN28CGbmqwrDzumesftW7uNnS8vO7t+Kx0fKBF7fW46eMfraMlVbuzRnn
         06c+OEVxUXYKz2OikEPRN5G7WO2sL6prRB/26ZYV2nS3WOhg/OUKbNv85PP8J329xxAe
         d9rDI31m6iTaaikH+KGzXqEATDC+Ff5A8cspb3entL24ra70AIuTBqR0CbIAlYa/wZ4x
         gCb3f+3L0DO/82s59gxiUt5AJPl1wGVNLrMKmHTK2tNE6+csbEs/VfXVhZLT4cQshTF1
         Mw6hDhqSJmUBr2uJXTiR6/YyiUaMMJi9gKKjWThKUagBPizNjzriPur9uk+hNRulo3DP
         Nkbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SbtQMFsGPA/6ldfqUOLBsftSiaWAN1XegIGnQQjLLP8=;
        fh=EW7ylYyp0hKbsCQFKu4CyLnZi5lZEBLELZLWftaD3aQ=;
        b=AWL40lWZ/xmUwkotrTQoTPf4/dwU2WQS1QMR8R8wbwnbo2iRnRBqIom78bBZZ4fu2Y
         SMeFV9jdRK5Lvx9xL5j2FGwB+we+v1y9f010sMPYQTHSvFnuliyk2DVuZi81fJvtnRlD
         /ZTaWju9x/iq43vH2RAVwJZY0aMJvSPq5oaztysKvyJWq701usjODhYwz2gj9exje6jN
         TH15dMvTdcg8kSK2lyfElPkCt9AIiIvJAweKd7xR+CSMFsOlVfE2jmZCPwuQ0+URn+Lj
         MlIWt2x5+SMuUrI3u8niaYBWTWR7aWet4ApttHLItc+qR2/HNNg/1ff6iVUUiT81j2XA
         85/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771356471; x=1771961271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbtQMFsGPA/6ldfqUOLBsftSiaWAN1XegIGnQQjLLP8=;
        b=HvnoZR8zfyEtT1CmYYfXEd0xZVj6smvvAGDvaTQENlihM6gnmvZajkehm3vadtH7Hp
         qg0dQLuTPri+dn9JwfsYHYW9Rmbpdxia0Sgny3asuglp0d8zRuMVLdChgN/1W2WPA9Dp
         Ty/akPoO/mprHf0Vl4gr9gxLNSIqCJT+DzOEXRDeKFET1VJ3vJ69iUKfFSCWqIISsK6r
         91m29W4YLDaBcOLbgI3SidxtX2pgsQmtjBuDauuRnNkFSWfTm0VE/KqYWHv3VvWrTt8S
         sUSTRr7pxadlKu/F/e1ud05UJ/o72NKYHWknk9YA53Dm0hhIfwHQPVD1LPS/1AHrY67c
         jJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771356471; x=1771961271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SbtQMFsGPA/6ldfqUOLBsftSiaWAN1XegIGnQQjLLP8=;
        b=qnWXMne8Z1YIZC4dE0G5rJ4CA7/RUjlZz0NjgCDlrMuo62tX9JC3Rfi+ZfSvUqJfDw
         ccTIgZYGgDi7bRe95mOc+oo7GXhJjPZgWO6mU00L/1vu1fKZcisNo73WSiMyWgKcoqcp
         4lWOBMjeb1etfphCh0hKbFNVHIVbalebg/W9hlRYigxG0dE1Twlu6gXjs9DK5Qxakh2O
         Bf4u08qnLto5YPx3TxLohRNNLI3lqZHUTEeS9ORDMe2SgmYZG8zaH+b4/sRedc9e4k/7
         qzjZwdbArpeGSHAkKav5Mj6ttKd62wvXGtfce3wXxmjQY9Uit08Ie/+a0bTZpm35dN5X
         VN9A==
X-Forwarded-Encrypted: i=1; AJvYcCXHgxKAgptmv3yZPikhR2Lod1oYwVBTcb37egrfStS1G6WgFgQWjE3goG6o+9NT3xy/R8aF48Xh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4MInEAQYrnIWxFzTSkhy3zSraQMuIdt35KgXJsyGoWfdhGo4S
	5+ow78o7VrDWv7mwPT+zbT5BYW0NObnNlbGSsI6MgVr7r6tahGusbBgkQiuRqmkdRaDlX+uiNDA
	+Jny84kLLGyJOUN93GYCc7u89e7WlubN+sgd0k6Az
X-Gm-Gg: AZuq6aKbIVkGw8XcJ6MZgRo3ez/PyKf3N31XWkWbHcaG/dmfKJu3t/9adzwudqSwk9g
	0saJGa6dCA6uThtjyoPf+4eJGtts+MijNR1uIHzK1A/Slp7V8J0Sdbcj8KlZMPkOS3ate1QbDTk
	nAA+QPv5TAXJUCQVgGk06iQeavdGjB/5vsfKISHbt5LWQoDQu4QbYGKth46Y17BPerAdBEjylUM
	+pQB853Is6YCC38LAQgoJ02VpxVe8YMCBSfI1hBKNE8xYXifAvIo8IexRRcqodNyCMOUTyuA9KZ
	PwykekvyF2ph5BnGlLbNIoBcroQB0GRXWk/8JWomAvXtVqeHOs5t5QTngIiIbBiYsFIiwA==
X-Received: by 2002:a05:600c:6a0f:b0:477:86fd:fb49 with SMTP id
 5b1f17b1804b1-48388809dd1mr1315515e9.10.1771356470995; Tue, 17 Feb 2026
 11:27:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212215814.629709-1-tjmercier@google.com> <20260212215814.629709-2-tjmercier@google.com>
 <aZNFTR_gc6j116rw@amir-ThinkPad-T480>
In-Reply-To: <aZNFTR_gc6j116rw@amir-ThinkPad-T480>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 17 Feb 2026 11:27:38 -0800
X-Gm-Features: AaiRm50lkIkI0vTw0pKWrhRFJ18Z83k0MjgydYcYSeBtbsOtDjpOH99UjI76ZFk
Message-ID: <CABdmKX2DD4iapAGtdjJyb7CAHiS9RaD3pbuAnd=1tvudxfJkKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kernfs: allow passing fsnotify event types
To: Amir Goldstein <amir73il@gmail.com>
Cc: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, jack@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-13981-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4837E14FA49
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 8:27=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, Feb 12, 2026 at 01:58:12PM -0800, T.J. Mercier wrote:
> > The kernfs_notify function is hardcoded to only issue FS_MODIFY events
> > since that is the only current use case. Allow for supporting other
> > events by adding a notify_event field to kernfs_elem_attr. The
> > limitation of only one queued event per kernfs_node continues to exist
> > as a consequence of the design of the kernfs_notify_list. The new
> > notify_event field is protected by the same kernfs_notify_lock as the
> > existing notify_next field.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
>
> Looks fine
> Feel free to add
> Acked-by: Amir Goldstein <amir73il@gmail.com>

Thanks Amir.

>
> > ---
> >  fs/kernfs/file.c       | 8 ++++++--
> >  include/linux/kernfs.h | 1 +
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> > index 9adf36e6364b..e978284ff983 100644
> > --- a/fs/kernfs/file.c
> > +++ b/fs/kernfs/file.c
> > @@ -914,6 +914,7 @@ static void kernfs_notify_workfn(struct work_struct=
 *work)
> >       struct kernfs_node *kn;
> >       struct kernfs_super_info *info;
> >       struct kernfs_root *root;
> > +     u32 notify_event;
> >  repeat:
> >       /* pop one off the notify_list */
> >       spin_lock_irq(&kernfs_notify_lock);
> > @@ -924,6 +925,8 @@ static void kernfs_notify_workfn(struct work_struct=
 *work)
> >       }
> >       kernfs_notify_list =3D kn->attr.notify_next;
> >       kn->attr.notify_next =3D NULL;
> > +     notify_event =3D kn->attr.notify_event;
> > +     kn->attr.notify_event =3D 0;
> >       spin_unlock_irq(&kernfs_notify_lock);
> >
> >       root =3D kernfs_root(kn);
> > @@ -954,7 +957,7 @@ static void kernfs_notify_workfn(struct work_struct=
 *work)
> >               if (parent) {
> >                       p_inode =3D ilookup(info->sb, kernfs_ino(parent))=
;
> >                       if (p_inode) {
> > -                             fsnotify(FS_MODIFY | FS_EVENT_ON_CHILD,
> > +                             fsnotify(notify_event | FS_EVENT_ON_CHILD=
,
> >                                        inode, FSNOTIFY_EVENT_INODE,
> >                                        p_inode, &name, inode, 0);
> >                               iput(p_inode);
> > @@ -964,7 +967,7 @@ static void kernfs_notify_workfn(struct work_struct=
 *work)
> >               }
> >
> >               if (!p_inode)
> > -                     fsnotify_inode(inode, FS_MODIFY);
> > +                     fsnotify_inode(inode, notify_event);
> >
> >               iput(inode);
> >       }
> > @@ -1005,6 +1008,7 @@ void kernfs_notify(struct kernfs_node *kn)
> >       if (!kn->attr.notify_next) {
> >               kernfs_get(kn);
> >               kn->attr.notify_next =3D kernfs_notify_list;
> > +             kn->attr.notify_event =3D FS_MODIFY;
> >               kernfs_notify_list =3D kn;
> >               schedule_work(&kernfs_notify_work);
> >       }
> > diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> > index b5a5f32fdfd1..1762b32c1a8e 100644
> > --- a/include/linux/kernfs.h
> > +++ b/include/linux/kernfs.h
> > @@ -181,6 +181,7 @@ struct kernfs_elem_attr {
> >       struct kernfs_open_node __rcu   *open;
> >       loff_t                  size;
> >       struct kernfs_node      *notify_next;   /* for kernfs_notify() */
> > +     u32                     notify_event;   /* for kernfs_notify() */
> >  };
> >
> >  /*
> > --
> > 2.53.0.273.g2a3d683680-goog
> >

