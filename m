Return-Path: <cgroups+bounces-14011-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D2mGPo4lml4cgIAu9opvQ
	(envelope-from <cgroups+bounces-14011-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 23:11:06 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B726F15A93A
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 23:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 202D7302E78F
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 22:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6294033439D;
	Wed, 18 Feb 2026 22:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gHXlcvqR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6572FF641
	for <cgroups@vger.kernel.org>; Wed, 18 Feb 2026 22:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771452659; cv=pass; b=oXyGWQ2ax7gyrRsVWRzKa1m65bXQ4BlIlFzTC2QmEguVpuiyOms0HTleAGQHoYqTXR4dWuYHmuHfLOvOiInz8gCpccK6OSvmrHKE73eJ4uAoOYGigrgbwPjMC0LfiKMG9vmS98oNOULLG8xbdx8ya7QNerA3OuzpOS2iYBvW5dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771452659; c=relaxed/simple;
	bh=lPYt0pFhbd6M7kXSQtBzYZaVvT2A54L7thEUJD072Aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGBRs3Aa3Nz+1PAAOfryIvYzKYzxMfhacDuu+TWha4h6klKiUuXA+HJ2s5V5rW2sQuf+ScjNSvK7l7esLJZmNcuasuICLv1HVSi/W5vlRTt3xxUI88mIIkunfNz8l77O7j2dlzOO+AFxbbwxj0Aa5XzrXWaE8MGuX8uyyPp2IfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gHXlcvqR; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48373ad38d2so26165e9.0
        for <cgroups@vger.kernel.org>; Wed, 18 Feb 2026 14:10:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771452656; cv=none;
        d=google.com; s=arc-20240605;
        b=QFv9GFE4jdi7mLZ36zp/wFJunV8G5SiFZwc9vGV9ceCdzxiM2+Ry08JVv10STWjnpe
         qbQOB4neYsUzddjIQP+w3xjcre0fkTnBRSLxjiVi/MJ6JIbBXhWWZzZkVJ97rWv7so1F
         rFre2J0NVJP5vIXPXKf9UuHme++uc8dX3iezjydaA2BNk9Q1lLWAL25hCPWq0Zhg6xz3
         aWxYU6CBV0dTSY5sDLbRwK6Sj/ftaHt4jYl4QxoVaJbQy8Qfrf16V+pRKtZev7fGeQjG
         vmqU0vyCqQNWtDzC+B/1OpsPgTaNZNCQq6FK8SNybwbsxh9AkVcdZom65cMwE5Z4OeFp
         727Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GFceulQD+cH2ZvMG6LJDvnAg6v30pKU0WTiw2QCY5N0=;
        fh=cPdc12R/n5ZUoKrjiZkao4kj9NXnnQ2ynWtOLipJ374=;
        b=k2xJU+fjZ0jDHmyRWnTkGXgd3JuUxoqP1PBpKRxJZn3jPkVSWry8gVG553et+CsXcw
         9gtoSxkm5yZN/Qj8Jqa9veuuPebfAZgg4tT53EjD5rlTrLc0oa1On/UbbXkVcR7N++sH
         r4HZ+ofuJmYb13DXp224WhF18DI+RU5lJQT4vzeVzchZSlSGHUGEYMN2gOZPUNuyuPIK
         wY3hJjN34HuNEoCLTF4jiNAgVs/U9pyQwgvw8WWbY9DfcRo+3UqmEgqim/3uGrEG58Ad
         CT3OaYjCA88ODfJMIVREotJFC7wjDiR1hFZhQtXDMGnIJohnO/vTnimjFs2dErYxnTQK
         GBLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771452656; x=1772057456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFceulQD+cH2ZvMG6LJDvnAg6v30pKU0WTiw2QCY5N0=;
        b=gHXlcvqRsCXRFRWgKe2rCQ+pBr2va665XoRPpX94fX/z6KkXa7Eek/zmzIcgqrrMt7
         2D29ca6OTzPQtkc0XnawaXDloZM2bveVMyzqxPugfnwsquJ9FP+xvG0InyqiwPbgni3e
         ZktSpe5qmA2gHbik95BElCBIHX8gL9NTrEBeOOec+BZqkN3J0jhUQFJ49+rLFwnTQeUP
         Qz7fhSkiAWGqyzwRslZ/TDy9iUQtEC7Vr/g8et7rgSs1RVELu4iW5Bvh640XmcCfM71Y
         bPzzb/m3mUnqsbrHNrW+6eQ78RU8UFE/jo0JTlqDpraGUCgODweN06T8F4/6r1W5p9dp
         /R2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771452656; x=1772057456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GFceulQD+cH2ZvMG6LJDvnAg6v30pKU0WTiw2QCY5N0=;
        b=UiU19oApX2xw86fy9VvxJllq+3Dd+PdTZbYTYi85xVtQfPz45Xz8uJUOL0hrV+GuNv
         s7sNPjzveL0mbLv8h+uSrONJ//jlr7C0OevJTvrqjF4/XyyncH2bJGBCYEkuJjU/EkmT
         lQfMRQAjWuBCIVFKGd7tSc3QBrxWTy2PwFmJZs8+F6zR3M4OtaC2YjsRWNACrkFKT/Jt
         ILL2I3xOIEl42Xnz2XI5RmRKARvTTVquTuER9n3OyUdEdSKIgXCsrHA0bowD70RaeVlp
         d3Al78LaWWYMxRGG3f1jdD9h4qAGs1aYWHtNuAdnOa3uHtaiteSQVn3c2SV7/baS2wVc
         AqhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW952oBkEFXZ/9KvppDxgYaDFFsJ0MNLLYEqcW6Wx225/xLBBIWaRdCHwssEgT3QcfeLJJVspSW@vger.kernel.org
X-Gm-Message-State: AOJu0YzJp73DYye+DuIt1+L81fTpDP3J3yGBxt4PsfQuAP6Z8EA5p5dc
	8A5BIbZzfdPtSlo2K7lqJsLtsQI2X7O5msMsmzu/Xnje75MJhdw3K3qzNxcOtfHVgAF/5LhTLEN
	qBSynXSmL4f8cZNajwScVPNakgTB/q8Dy6lzqhaaW
X-Gm-Gg: AZuq6aJCHymGRq8Xi9ETUfuEMNHh1tj5YWOX/ZOTqB83C7BBLrQSW8bKSn26UPHCrZc
	8FNyqDZByTMgwg0PgZQHoy7YI2KfCg9fCe0o1hBl9R60W8F1Ga2E42fFNrLCzVNa9tS/yPD9L4f
	kPUSRsCbdo7XA3gX+fy9DAUrMd+ARRnKiHafu1BzwgXzJLYfI7AdetzC2hSy/ZG9wgL8f1i24AR
	NI5GZv/Tvy6q3zFgmZjnIU+wpppWMCHfcQaerM9fnaw/ERgZylTzT+nI+oy+Yt+Euut0E7tojaD
	CVp5L/+bwjbFSvW2tkaglFp2eDyUl02Z9VeE6f6Tu7law6rYOdKEN1oNq2U4qm4Yck2x6g==
X-Received: by 2002:a05:600c:3e06:b0:45f:2940:d194 with SMTP id
 5b1f17b1804b1-4839f8fbec9mr92205e9.2.1771452655867; Wed, 18 Feb 2026 14:10:55
 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218032232.4049467-1-tjmercier@google.com>
 <20260218032232.4049467-3-tjmercier@google.com> <e7b4xiqvh76jvqukvcocblq5lrc5hldoiiexjlo5fmagbv3mgn@zhpzm4jwx3kg>
 <CABdmKX1S4wWFdsUOFOQ=_uVbmQVcQk0+VUVQjgAx_yqUcEd60A@mail.gmail.com>
 <s4vb5vshejyasdw2tkydhhk4m6p3ybexoi254qjiqexzgcxb5c@ctazolc3nh6f>
 <CABdmKX2cQCneFyZhTWmWYz-RTmAOQcEKh5ZQewz25E6Xfok1tQ@mail.gmail.com> <CABdmKX0BJcsv0TaPSsGN2a4nkQaKF=cX8rnnoL5kPTHNfuKL7Q@mail.gmail.com>
In-Reply-To: <CABdmKX0BJcsv0TaPSsGN2a4nkQaKF=cX8rnnoL5kPTHNfuKL7Q@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 18 Feb 2026 14:10:42 -0800
X-Gm-Features: AaiRm50oJmkhv3JVc8QRZs9eNQOIt0sVOkSFuyILAnwFvxKBu7Elyj-9uDHYoK8
Message-ID: <CABdmKX0DGP9=OOPwU8WjqHnmRDfPnxoAjm8Rvy-D2GYQX0GE0A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kernfs: send IN_DELETE_SELF and IN_IGNORED on file deletion
To: Jan Kara <jack@suse.cz>
Cc: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-14011-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B726F15A93A
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 11:58=E2=80=AFAM T.J. Mercier <tjmercier@google.com=
> wrote:
>
> On Wed, Feb 18, 2026 at 11:15=E2=80=AFAM T.J. Mercier <tjmercier@google.c=
om> wrote:
> >
> > On Wed, Feb 18, 2026 at 10:37=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 18-02-26 10:06:35, T.J. Mercier wrote:
> > > > On Wed, Feb 18, 2026 at 10:01=E2=80=AFAM Jan Kara <jack@suse.cz> wr=
ote:
> > > > >
> > > > > On Tue 17-02-26 19:22:31, T.J. Mercier wrote:
> > > > > > Currently some kernfs files (e.g. cgroup.events, memory.events)=
 support
> > > > > > inotify watches for IN_MODIFY, but unlike with regular filesyst=
ems, they
> > > > > > do not receive IN_DELETE_SELF or IN_IGNORED events when they ar=
e
> > > > > > removed.
> > > > >
> > > > > Please see my email:
> > > > > https://lore.kernel.org/all/lc2jgt3yrvuvtdj2kk7q3rloie2c5mzyhfdy4=
zvxylx732voet@ol3kl4ackrpb
> > > > >
> > > > > I think this is actually a bug in kernfs...
> > > > >
> > > > >                                                                 H=
onza
> > > >
> > > > Thanks, I'm looking at this now. I've tried calling clear_nlink in
> > > > kernfs_iop_rmdir, but I've found that when we get back to vfs_rmdir
> > > > and shrink_dcache_parent is called, d_walk doesn't find any entries=
,
> > > > so shrink_kill->__dentry_kill is not called. I'm investigating why
> > > > that is...
> > >
> > > Strange because when I was experimenting with this in my VM I have se=
en
> > > __dentry_kill being called (if the dentries were created by someone l=
ooking
> > > up the names).
> >
> > Ahh yes, that's the difference. I was just doing mkdir
> > /sys/fs/cgroup/foo immediately followed by rmdir /sys/fs/cgroup/foo.
> > kernfs creates the dentries in kernfs_iop_lookup, so there were none
> > when I did the rmdir because I didn't cause any lookups.
> >
> > If I actually have a program watching
> > /sys/fs/cgroup/foo/memory.events, then I do see the __dentry_kill kill
> > calls, but despite the prior clear_nlink call i_nlink is 1 so
> > fsnotify_inoderemove is skipped. Something must be incrementing it.
>
> The issue was that kernfs_remove unlinks the kernfs nodes, but doesn't
> clear_nlink when it does so. Adding that seems to work to generate
> IN_DELETE_SELF and IN_IGNORED. I'll do some more testing and get a
> patch ready.

This works for the rmdir case, because
vfs_rmdir->shrink_dcache_parent->shrink_kill->__dentry_kill is invoked
when the user runs rmdir.

However the case where a kernfs file is removed because a cgroup
subsys is deactivated does not work, because it occurs when the user
writes to cgroup.subtree_control. That is a vfs_write which calls
fsnotify_modify for cgroup.subtree_control, but (very reasonably)
there is no attempt made to clean up the dcache in VFS on writes.

So I think kernfs still needs to generate fsnotify events manually for
the cgroup_subtree_control_write->cgroup_apply_control_disable case.
Those removals happen via kernfs_remove_by_name->__kernfs_remove, so
that would look a lot like what I sent in this v3 patch, even if we
also add clear_nlink calls for the rmdir case.

