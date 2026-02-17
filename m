Return-Path: <cgroups+bounces-13982-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aINhMMDclGnPIQIAu9opvQ
	(envelope-from <cgroups+bounces-13982-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 22:25:20 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28430150BDF
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 22:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 197D6301CCD1
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 21:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6242F5A2D;
	Tue, 17 Feb 2026 21:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f49CF+u7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D062DAFDA
	for <cgroups@vger.kernel.org>; Tue, 17 Feb 2026 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771363516; cv=pass; b=E+wfMq0NJ3EFFUCwdatJkZcJZyCEKGu8+yser09cdL68xFXgMFZTaJBGuJtkvaQeu97h6E/3YiDo3PSGTtv+goPy3/AQickVinDyvCyEzaXaecMRIcpl8X8dDfEsbGhIfCRVDAn33ZI/bkAa9+gw0Fh6d/4ETpz3gLwOaE0eElM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771363516; c=relaxed/simple;
	bh=fbhIDMncw2o3OGAnMUfavkAE0+3CvTo4wLCTth3BWak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIZ/PO7+uMVU2Vxap8U8U/IuwtV+U3leWO1KJH70/K5OXkQHeDCWDmcXbgpt3vy1H7naVaKXkEnZm/Xmn8MDy0SQ/rk85SM7w9AeyXs5qr1vY3k7yuhaPhpya/T3mxpAs+tpTQ0t30yQ/gt28VyTh37C7oQoG9P3rXgi8g//0Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f49CF+u7; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65bf2f59d64so3277769a12.1
        for <cgroups@vger.kernel.org>; Tue, 17 Feb 2026 13:25:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771363513; cv=none;
        d=google.com; s=arc-20240605;
        b=CnDjuh6qTo/verPueEnPAijnRTWdfyIXl7piT3NcOzdtJLwcf3xx/vp0fel+GgLK6G
         /JZsvaFPyh1SZfHtGPA08TOw0c1mivwXuIRDQaSKj28Mf9z4IWadzBrvmHsYee9issb4
         wzlJ1pIRDIAiG/gXkvh94VCJJiT1TlqQHbHHKd9rWBwHsnzBGGJUWVoYGODoPBeRQrOo
         YzitqXwTOY6Ad9A3zS4aAJ1yZAdioRIs1XMvkevRbV6911yWTtdhBWPAKC1Br54KvaZX
         lsGWP/h7fJyy3k4tRfhmuH3zjbwEzyFJ9JgDrs94mQFzP3Gdd413E1lUj2ueUc4v4SBN
         qxMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fw82UQHVg2xZhGg7XycSDFADTgXvBB91CaL/8gvyO6E=;
        fh=kkUCZZUtB71aU/VaeTDWf94h4KuBNpQoayC2tzcrcho=;
        b=jE01bIoSYJ9UmZDe4BLtafASsoKDumbceVzucAqI6YYt78CsTfKjoPZyAnpyh85G2N
         O1W9mstj4vQRf+XEmmN16W8QtiTGqZFZ/IRD519JsLXIrKbplgTgBldwWKdyrotvTMi7
         2dgSRvr252Nth/OljE0g8PBLeq9ruo/KUzUJbQRpsTqxmFnqU/IAtVzYGGXyAU1ElEXG
         C5+uxLcQBmh2iW47gnBCAWO7RYTeEzXItXUSFjoFe68Mrfl/zl0zroQAZTSHgKQz43yC
         utOlhot+UGkuxY5Q33dHu6qUXWzYvQjJga0dQ/OCju+gma2GvBr2Dn3xGLTX93pgzjxJ
         wQLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771363513; x=1771968313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fw82UQHVg2xZhGg7XycSDFADTgXvBB91CaL/8gvyO6E=;
        b=f49CF+u7bli/lg89u2KWVg0LvTfCJMOkprhcrZD2dZZq9Zr5cUtDiQAjRKx4wItrwa
         ftbEI/4kDdDR9QAx8zPtuRTLzCiAX2Ue0UobiIfLOp1bBLWopmjUfYc1kNYw7w3Q4dH8
         Gpo8ABTt/oHx1wNWjE8e3i+1LxKPV6Tpy9F24as0Cvz+TTTAxQXDhZTEpXSPDo2iG7a9
         KhDLhwDYaIDuy8Elb4lDBB1mcX+B9/6cHS/bXjsMEmGk/crL+2fYp67PYvXZ7jdcnDRb
         zv4PY3UIhfmhi8QTjlFgSMR44NmcFOAN/3K+lprpGqbx6KjMQbxRnf14W2Eu9D3hn7f+
         S9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771363513; x=1771968313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fw82UQHVg2xZhGg7XycSDFADTgXvBB91CaL/8gvyO6E=;
        b=sYVnISMhqw+5CUk2DDyGgkgf/vJNNWCOGy/57awDTPdQre1Su8CX70NzvqD1vNakvR
         kQyBD2BATDogA/GidhZziqTOUN3foZ3a2QcD0uMYevWMXLEaJO0td2AVbzJtXkhMfJX9
         5Ck/82oNwOfQV7IN8FaKZSkZ26WlXIUcyQwY2cjm21qv1gDqL02PMNL/N4M2br3DTdWu
         sjjI6oS983UMATfNS2W+ByKKmC9EXIpmhLvi6AejooTtc4/HFypWuYtKdDyeo60PW79H
         zPzY5KJ4aoEaYhTtfW9Jt/traKNFWPqaakbrIJPsRpbVWDTvL96fD5XAzHCisJsgoTiZ
         rLbg==
X-Forwarded-Encrypted: i=1; AJvYcCUZvOOCr7rhU4wMsMkqTzlk3cdcaGDXi2h6lSJrIEEqM3PHQWzvGq7HQz/0TF/Pn9TFd+qXZ+P4@vger.kernel.org
X-Gm-Message-State: AOJu0YxprHfbyvJYgwiDaBZVQ8FCpqqEPn4yDZVjVrp9rJFLSJ0soVdx
	GbVrWcVWDHb+xItYRTC/1kL3X+tnsuTbJYIT53q7rtJtkGyP72AxwWJMYyILfWwGbuJRuNOuu2b
	+jepn2A7vCqKiX5DpiXAbEN2nGlWI4N0=
X-Gm-Gg: AZuq6aKYgPpqjB9185qeLaPbRr/dqW7uvg6DhSWIKJ3bfncwrvEqZwKDISG2WLMaVWr
	bBpcaqk3hKgZ/oHXmtWqflUWdfSkuHIpognL35Haf48+JiaQId+okG1TdRa5qK3ep6tNlbUPUGg
	DtXn1kRiTueJzdGuQriqBhlue0O+G1nF44nAO4J2QpsOWytWqxk83Bc1YizfGQHBgQ/Xgba5RrJ
	e8wWga3BUay74JKoGA4vz/U3UYVtq/k0w6qmiGfzaDp+44IwMT45/cmFOWeZidWU9ZcrHQEYhnT
	vd++EmXMAZ093a8FSOw=
X-Received: by 2002:a05:6402:1470:b0:65c:63f0:a92 with SMTP id
 4fb4d7f45d1cf-65c63f00e8bmr1535827a12.23.1771363513152; Tue, 17 Feb 2026
 13:25:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212215814.629709-1-tjmercier@google.com> <20260212215814.629709-3-tjmercier@google.com>
 <aZRAkalnJCxSp7ne@amir-ThinkPad-T480> <CABdmKX3wsWphRTDanKwGGiUWoO0xTaC8L_QxjHzhpxfZn256MQ@mail.gmail.com>
In-Reply-To: <CABdmKX3wsWphRTDanKwGGiUWoO0xTaC8L_QxjHzhpxfZn256MQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 17 Feb 2026 22:25:01 +0100
X-Gm-Features: AaiRm51TQrPoY4M1hB7zomqcMjNss-PCU-arAe40VL9qb1hRq1aV4JYHGiHMROc
Message-ID: <CAOQ4uxgrP=VdTKZXKcRE8BeWv6wZy7aFkUF-VoEpRSxVnHZi2w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kernfs: send IN_DELETE_SELF and IN_IGNORED on file deletion
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13982-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,memory.events:url]
X-Rspamd-Queue-Id: 28430150BDF
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 9:26=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> On Tue, Feb 17, 2026 at 2:19=E2=80=AFAM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Thu, Feb 12, 2026 at 01:58:13PM -0800, T.J. Mercier wrote:
> > > Currently some kernfs files (e.g. cgroup.events, memory.events) suppo=
rt
> > > inotify watches for IN_MODIFY, but unlike with regular filesystems, t=
hey
> > > do not receive IN_DELETE_SELF or IN_IGNORED events when they are
> > > removed.
> > >
> > > This creates a problem for processes monitoring cgroups. For example,=
 a
> > > service monitoring memory.events for memory.high breaches needs to kn=
ow
> > > when a cgroup is removed to clean up its state. Where it's known that=
 a
> > > cgroup is removed when all processes die, without IN_DELETE_SELF the
> > > service must resort to inefficient workarounds such as:
> > > 1.  Periodically scanning procfs to detect process death (wastes CPU =
and
> > >     is susceptible to PID reuse).
> > > 2.  Placing an additional IN_DELETE watch on the parent directory
> > >     (wastes resources managing double the watches).
> > > 3.  Holding a pidfd for every monitored cgroup (can exhaust file
> > >     descriptors).
> > >
> > > This patch enables kernfs to send IN_DELETE_SELF and IN_IGNORED event=
s.
> > > This allows applications to rely on a single existing watch on the fi=
le
> > > of interest (e.g. memory.events) to receive notifications for both
> > > modifications and the eventual removal of the file, as well as automa=
tic
> > > watch descriptor cleanup, simplifying userspace logic and improving
> > > resource efficiency.
> >
> > This looks very useful,
> > But,
> > How will the application know that ti can rely on IN_DELETE_SELF
> > from cgroups if this is not an opt-in feature?
> >
> > Essentially, this is similar to the discussions on adding "remote"
> > fs notification support (e.g. for smb) and in those discussions
> > I insist that "remote" notification should be opt-in (which is
> > easy to do with an fanotify init flag) and I claim that mixing
> > "remote" events with "local" events on the same group is undesired.
>
> I think this situation is a bit different because this isn't adding
> new features to fsnotify. This is filling a gap that you'd expect to
> work if you only read the cgroups or inotify documentation without
> realizing that kernfs is simply wired up differently for notification
> support than most other filesystems, and only partially supports the
> existing notification events. It's opt-in in the sense that an
> application registers for IN_DELETE_SELF, but other than a runtime
> test like what I added in the selftests I'm not sure if there's a good
> way to detect the kernel will actually send the event. Practically
> speaking though, if merged upstream I will backport these patches to
> all the kernels we use so a runtime check shouldn't be necessary for
> our applications.
>

That's besides the point.
An application does not know if it running on a kernel with the backported
patch or not, so an application needs to either rely on getting the event
or it has to poll. How will the application know if it needs to poll or not=
?

> > However, IN_IGNORED is created when an inotify watch is removed
> > and IN_DELETE_SELF is called when a vfs inode is destroyed.
> > When setting an inotify watch for IN_IGNORED|IN_DELETE_SELF there
> > has to be a vfs inode with inotify mark attached, so why are those
> > events not created already? What am I missing?
>
> The difference is vfs isn't involved when kernfs files are unlinked.

No, but the vfs is involved when the last reference on the kernfs inode
is dropped.

> When a cgroup removal occurs, we get to kernfs_remove via kernfs'
> inode_operations without calling vfs_unlink. (You can't rm cgroup
> files directly.)
>

Yes and if there was a vfs inode for this kernfs object, the vfs inode need=
s to
be dropped.

> > Are you expecting to get IN_IGNORED|IN_DELETE_SELF on an entry
> > while watching the parent? Because this is not how the API works.
>
> No, only on the file being watched. The parent should only get
> IN_DELETE, but I read your feedback below and I'm fine with removing
> that part and just sending the DELETE_SELF and IN_IGNORED events.
>

So if the file was being watched, some application needed to call
inotify_add_watch() with the user path to the cgroupfs inode
and inotify watch keeps a live reference to this vfs inode.

When the cgroup is being destroyed something needs to drop
this vfs inode and call __destroy_inode() -> fsnotify_inode_delete()
which should remove the inotify watch and result in IN_IGNORED.
IN_DELETE_SELF is a different story, because the inode does not
have zero i_nlink.

I did not try to follow the code path of cgroupfs destroy when an
inotify watch on a cgroup file exists, but this is what I expect.
Please explain - what am I missing?

> > I think it should be possible to set a super block fanotify watch
> > on cgroupfs and get all the FAN_DELETE_SELF events, but maybe we
> > do not allow this right now, I did not check - just wanted to give
> > you another direction to follow.
> >
> > >
> > > Implementation details:
> > > The kernfs notification worker is updated to handle file deletion.
> > > fsnotify handles sending MODIFY events to both a watched file and its
> > > parent, but it does not handle sending a DELETE event to the parent a=
nd
> > > a DELETE_SELF event to the watched file in a single call. Therefore,
> > > separate fsnotify calls are made: one for the parent (DELETE) and one
> > > for the child (DELETE_SELF), while retaining the optimized single cal=
l
> >
> > IN_DELETE_SELF and IN_IGNORED are special and I don't really mind addin=
g
> > them to kernfs seeing that they are very useful, but adding IN_DELETE
> > without adding IN_CREATE, that is very arbitrary and I don't like it as
> > much.
>
> That's fair, and the IN_DELETE isn't actually needed for my use case,
> but I figured I would add the parent notification for file deletions
> since it is already there for MODIFY events, and I was modifying that
> area of the code anyway. I'll remove the parent notification for
> DELETE and just send DELETE_SELF and IGNORED with
> fsnotify_inoderemove() in V3.

I do not object to adding explicit IN_DELETE_SELF, especially
because that would be usable also in fanotify, but I'd like to
understand what's the story with IN_IGNORED.

Thanks,
Amir.

