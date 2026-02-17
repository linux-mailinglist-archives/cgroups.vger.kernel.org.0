Return-Path: <cgroups+bounces-13983-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BFlBpXslGnUIwIAu9opvQ
	(envelope-from <cgroups+bounces-13983-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 23:32:53 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7676151810
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 23:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6728B302D106
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 22:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3ED2F6907;
	Tue, 17 Feb 2026 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i+do5k0X"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6F22D781E
	for <cgroups@vger.kernel.org>; Tue, 17 Feb 2026 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367561; cv=pass; b=esCN2B/o1fB/t228QHl/Pdw3qkbyUrzOvvWUNNF5Xd6ws+F4iIjBs9Q1f8izibZvWZu32C+GJKjZYX3RVwwgJ4m0td77DJRAOVQ0/7HoXyRanrNEuFKmNu8Ybl5IQX0nOYdaDuP7tv/M8aMLxSsiJwKOdQXnRi/rUTb4i1fdWiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367561; c=relaxed/simple;
	bh=tyLWulTPYAWC5On0WxerMjv6uLHBMLdwWxyRIQpmlzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FyD5IHZVf4vohbBZpEbkuWAUvlSDSm3GMf5eOmPcLlt/UDCOPN9S8lN0lwk3szk4fc0n0gpnW5kXYXMVWhgE6ZkvSr8c379IhMc72tZyXYj3lh7nk6Wx9KuoW56+LGHAQZt8ABZAn0VQDQ9mNRAG+1CrJZe5W1BVS1ziFVjyHMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i+do5k0X; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48371d2f661so10815e9.1
        for <cgroups@vger.kernel.org>; Tue, 17 Feb 2026 14:32:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771367558; cv=none;
        d=google.com; s=arc-20240605;
        b=B4Go7d8aDBVT1FG8thzczZjiqwqQfyB27uq5pOFYLOyEyAVVpu+u+V1E6lJ/ciByTG
         II5pfkyCBN+mE29+9r9fsVpLn9GqH19XhzE3KV08aYEhk/p8TelfQ58PJPrza7PAfktn
         w4Cyo5sZzSTktkcfwPRhOfgTfb9+MyzYqwH4/out5gF9yHt3jCz3LE0PYEe5oQiDwIyk
         z+OubA/il7KsZwl6G50xA7zNzvzqfQl4OOKCTi++zOFf5/5Fsk/ivFmNN0cxPjlr62/M
         5DSqfF4pbKO73FsM50ulFFFi4TELGSo0KKTeRfCh+WkctoVYkeOyKiqX4XsTCHegyiyK
         cS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PZgh3X22+q3SSfXDKP9Q8wPN8AleeftUpwOLeBQmvDs=;
        fh=3jVbFVlo5StbjkT8EuVsw+QaIqOWLqR0crK8D4oTiGg=;
        b=GBts9cvGLKgAq6g/cCZKEK2czEUMNrcn5NQdHg55lNrcG50KZudzBI7Yzvx9+iA4C9
         EinhI2M9s/dMiXD0KEABRjnZBtRs4e8PcDCQQ4oYlD965gwv0/FJJbwbr3H8BUWI9pn6
         NW5Flbo55p+EbI3cdwZIkeEoqIM0ZfuKeaXxcKwDHmBK/pasf43JEUsjDg8hDqoeAKo0
         C2yYE9N9cNZ/+hnV8C7sV/KWXqSfUFBRPxDKtioMWyf+xNs7p/KZrbQYmy9PxD1tT+/v
         sfCsLeTWj3s0X41epgFV5+qb4GKEC0h/ZE6MYzYxfDpHHzFGfSul8cOSKdkcwezFOmlh
         SyjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771367558; x=1771972358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZgh3X22+q3SSfXDKP9Q8wPN8AleeftUpwOLeBQmvDs=;
        b=i+do5k0XpRqCjjw1YMR2fsJ72cb81KZvB0at+scJIo+8o3CDQnDs9Dd/BL+jfGCgmy
         0aJKF2FMV1f6LLX0j+sVbZeavMfElsFHtiTfLv1d3byrJqfcYrma3nS1pZ0RRYGWP60H
         lMFFKw+od1tRL+1OdxVNlaUF5YOJh6vsRp3ynOB91Bh+ErNLOI+dlortxRBWJS9GGHZS
         ineU/V/isnJNJhAo+v/DJz8N4LqQF25b2KegsvCgiHNleWYH50t7ojSTSsLCZClutvPS
         yg3WRoytF9xUcAFZOg0eyLv7Ke7bMPaV9hl4fBBjbwNLucORTlJtjyorV2hxgxe7V7b5
         1gHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771367558; x=1771972358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PZgh3X22+q3SSfXDKP9Q8wPN8AleeftUpwOLeBQmvDs=;
        b=XA1Q5WwhMfDiLEIHV+cLvm1pBSD85gq+4AsJFvQoZ5gWBEheiXFhDjGteLXzTmdI75
         yf+dvnMT6bO/WuGkPbIqSxGdHw+ahQiqBITFHGtBYUhpixqPLh6syvlW5aB37hPzfJm/
         +H4sv9T89AzLhTmJ8z2U71yXc38vriecq1BVpq4/5s/7nfw+ZA3BJn7MrwJory5hgRVC
         ECw+z5YTp0DKC943ixj2myPJDCtviIbvTfeidUwC/vjFob74FnERrGY8slxx1Eba+aoH
         sHjk6PR78/rAhSG9JpSYxQGEav6QtIhLkX1jab+8stMWVl8/2cjVVxxeCIL6IQ/GClKk
         u1Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWyVfRorT2/U1vqFk9LnGlXQTE17lhU8Ni1CVNUCFMFuBw4sri2lddCBBhd7Lge6X/b0v+M1yMl@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/bPVBper+SQeMn90JMPnakZYb+kRJcgNXmz0yWvpmnh1tSkEl
	e200IO6O8HnzvJgjgjk27vEJFW1U9Y7/4r4BHWAqatoXdH44ljEmSvio11Csnq5qHdMQyzUzML3
	HiIsdnGLvSExpEpRhBdnt9qocaJrLYX8w54hsL1ZP
X-Gm-Gg: AZuq6aKDonex0KV0RG4VOI2WoaOnj1+cj/Ol0Gca4crIMP4ZTO082vJq+PhC6u4yxik
	9B7y4ck0ofh8p4/Kn0Y0VT1896ZLwk1yfI5plTdWfrBRpjt+HpFiSfe+6S+25ELYYFpjenpmlfw
	Jl1uZQtx0kACHnzevaWDuKKFAm9lFLVsCvuXGidrk+EyCwBJu2OrZgm6yin7hcyC+0g50Av+qm3
	KSAFQC23+KgrMz6TC7lz5UOlCknI8lX6dBlAMQG07V9p4PhrQreqB8q9b2XtSzHum68oG6EsUhD
	K24OTT8mJbHbW/HQ2BRUoGiNL/JEBRIUpQXpAKHn5v0RvLm0+nLxjeKKdqdE/Cu17z8BZA==
X-Received: by 2002:a05:600c:8b61:b0:477:86fd:fb1b with SMTP id
 5b1f17b1804b1-48398c19fdamr325e9.11.1771367557747; Tue, 17 Feb 2026 14:32:37
 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212215814.629709-1-tjmercier@google.com> <20260212215814.629709-3-tjmercier@google.com>
 <aZRAkalnJCxSp7ne@amir-ThinkPad-T480> <CABdmKX3wsWphRTDanKwGGiUWoO0xTaC8L_QxjHzhpxfZn256MQ@mail.gmail.com>
 <CAOQ4uxgrP=VdTKZXKcRE8BeWv6wZy7aFkUF-VoEpRSxVnHZi2w@mail.gmail.com>
In-Reply-To: <CAOQ4uxgrP=VdTKZXKcRE8BeWv6wZy7aFkUF-VoEpRSxVnHZi2w@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 17 Feb 2026 14:32:25 -0800
X-Gm-Features: AaiRm52ioB3yC-2XCNzG1OujfUKMHheOLnjYrqdZdEBKlcd4a_WIoA6uKbp4XL4
Message-ID: <CABdmKX1ztzJ6B13uzdDtN-uVWbdWuYJ6PMvjGoAfu40MMHCpaA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kernfs: send IN_DELETE_SELF and IN_IGNORED on file deletion
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
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-13983-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7676151810
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 1:25=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Feb 17, 2026 at 9:26=E2=80=AFPM T.J. Mercier <tjmercier@google.co=
m> wrote:
> >
> > On Tue, Feb 17, 2026 at 2:19=E2=80=AFAM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > >
> > > On Thu, Feb 12, 2026 at 01:58:13PM -0800, T.J. Mercier wrote:
> > > > Currently some kernfs files (e.g. cgroup.events, memory.events) sup=
port
> > > > inotify watches for IN_MODIFY, but unlike with regular filesystems,=
 they
> > > > do not receive IN_DELETE_SELF or IN_IGNORED events when they are
> > > > removed.
> > > >
> > > > This creates a problem for processes monitoring cgroups. For exampl=
e, a
> > > > service monitoring memory.events for memory.high breaches needs to =
know
> > > > when a cgroup is removed to clean up its state. Where it's known th=
at a
> > > > cgroup is removed when all processes die, without IN_DELETE_SELF th=
e
> > > > service must resort to inefficient workarounds such as:
> > > > 1.  Periodically scanning procfs to detect process death (wastes CP=
U and
> > > >     is susceptible to PID reuse).
> > > > 2.  Placing an additional IN_DELETE watch on the parent directory
> > > >     (wastes resources managing double the watches).
> > > > 3.  Holding a pidfd for every monitored cgroup (can exhaust file
> > > >     descriptors).
> > > >
> > > > This patch enables kernfs to send IN_DELETE_SELF and IN_IGNORED eve=
nts.
> > > > This allows applications to rely on a single existing watch on the =
file
> > > > of interest (e.g. memory.events) to receive notifications for both
> > > > modifications and the eventual removal of the file, as well as auto=
matic
> > > > watch descriptor cleanup, simplifying userspace logic and improving
> > > > resource efficiency.
> > >
> > > This looks very useful,
> > > But,
> > > How will the application know that ti can rely on IN_DELETE_SELF
> > > from cgroups if this is not an opt-in feature?
> > >
> > > Essentially, this is similar to the discussions on adding "remote"
> > > fs notification support (e.g. for smb) and in those discussions
> > > I insist that "remote" notification should be opt-in (which is
> > > easy to do with an fanotify init flag) and I claim that mixing
> > > "remote" events with "local" events on the same group is undesired.
> >
> > I think this situation is a bit different because this isn't adding
> > new features to fsnotify. This is filling a gap that you'd expect to
> > work if you only read the cgroups or inotify documentation without
> > realizing that kernfs is simply wired up differently for notification
> > support than most other filesystems, and only partially supports the
> > existing notification events. It's opt-in in the sense that an
> > application registers for IN_DELETE_SELF, but other than a runtime
> > test like what I added in the selftests I'm not sure if there's a good
> > way to detect the kernel will actually send the event. Practically
> > speaking though, if merged upstream I will backport these patches to
> > all the kernels we use so a runtime check shouldn't be necessary for
> > our applications.
> >
>
> That's besides the point.
> An application does not know if it running on a kernel with the backporte=
d
> patch or not, so an application needs to either rely on getting the event
> or it has to poll. How will the application know if it needs to poll or n=
ot?

Either by testing for the behavior at runtime like I mentioned, or by
depending on certification testing for the platform the application is
running on which would verify that the selftests I added pass. We do
the former to check for the presence of other features like swappiness
support with memory.reclaim, and also the latter for all devices.

> > > However, IN_IGNORED is created when an inotify watch is removed
> > > and IN_DELETE_SELF is called when a vfs inode is destroyed.
> > > When setting an inotify watch for IN_IGNORED|IN_DELETE_SELF there
> > > has to be a vfs inode with inotify mark attached, so why are those
> > > events not created already? What am I missing?
> >
> > The difference is vfs isn't involved when kernfs files are unlinked.
>
> No, but the vfs is involved when the last reference on the kernfs inode
> is dropped.
>
> > When a cgroup removal occurs, we get to kernfs_remove via kernfs'
> > inode_operations without calling vfs_unlink. (You can't rm cgroup
> > files directly.)
> >
>
> Yes and if there was a vfs inode for this kernfs object, the vfs inode ne=
eds to
> be dropped.

It should be, but it isn't right now.

> > > Are you expecting to get IN_IGNORED|IN_DELETE_SELF on an entry
> > > while watching the parent? Because this is not how the API works.
> >
> > No, only on the file being watched. The parent should only get
> > IN_DELETE, but I read your feedback below and I'm fine with removing
> > that part and just sending the DELETE_SELF and IN_IGNORED events.
> >
>
> So if the file was being watched, some application needed to call
> inotify_add_watch() with the user path to the cgroupfs inode
> and inotify watch keeps a live reference to this vfs inode.
>
> When the cgroup is being destroyed something needs to drop
> this vfs inode and call __destroy_inode() -> fsnotify_inode_delete()
> which should remove the inotify watch and result in IN_IGNORED.

Nothing like this exists before this patch.

> IN_DELETE_SELF is a different story, because the inode does not
> have zero i_nlink.
>
> I did not try to follow the code path of cgroupfs destroy when an
> inotify watch on a cgroup file exists, but this is what I expect.
> Please explain - what am I missing?

Yes that's the problem here. The inode isn't dropped unless the watch
is removed, and the watch isn't removed because kernfs doesn't go
through vfs to notify about file removal. There is nothing to trigger
dropping the watch and the associated inode reference except this
patch calling into fsnotify_inoderemove which both sends
IN_DELETE_SELF and calls __fsnotify_inode_delete for the IN_IGNORED
and inode cleanup.

Without this, the watch and inode persist after file deletion until
the process exits and file descriptors are cleaned up, or until
inotify_rm_watch gets called manually.

> > > I think it should be possible to set a super block fanotify watch
> > > on cgroupfs and get all the FAN_DELETE_SELF events, but maybe we
> > > do not allow this right now, I did not check - just wanted to give
> > > you another direction to follow.
> > >
> > > >
> > > > Implementation details:
> > > > The kernfs notification worker is updated to handle file deletion.
> > > > fsnotify handles sending MODIFY events to both a watched file and i=
ts
> > > > parent, but it does not handle sending a DELETE event to the parent=
 and
> > > > a DELETE_SELF event to the watched file in a single call. Therefore=
,
> > > > separate fsnotify calls are made: one for the parent (DELETE) and o=
ne
> > > > for the child (DELETE_SELF), while retaining the optimized single c=
all
> > >
> > > IN_DELETE_SELF and IN_IGNORED are special and I don't really mind add=
ing
> > > them to kernfs seeing that they are very useful, but adding IN_DELETE
> > > without adding IN_CREATE, that is very arbitrary and I don't like it =
as
> > > much.
> >
> > That's fair, and the IN_DELETE isn't actually needed for my use case,
> > but I figured I would add the parent notification for file deletions
> > since it is already there for MODIFY events, and I was modifying that
> > area of the code anyway. I'll remove the parent notification for
> > DELETE and just send DELETE_SELF and IGNORED with
> > fsnotify_inoderemove() in V3.
>
> I do not object to adding explicit IN_DELETE_SELF, especially
> because that would be usable also in fanotify, but I'd like to
> understand what's the story with IN_IGNORED.
>
> Thanks,
> Amir.
>

