Return-Path: <cgroups+bounces-14059-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN8KB/aWmGlaJwMAu9opvQ
	(envelope-from <cgroups+bounces-14059-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 18:16:38 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5DC169A78
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 18:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11C93306BD29
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 17:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2351932AABD;
	Fri, 20 Feb 2026 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7lquW24"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E3632A3FF
	for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771607771; cv=pass; b=eUOXInyA9qymLj8OxHot1oeEQF/rrJesorNWYQBpltUTl7zOjspHAt2gY9lv6qd9Rq/If1rROuXUgStWCPK6H/wktwFK/aK620yRpFqZo1ayXfJPZXmHCy3zfXQ6ryh3TEw7UnFtAOexH/7iEyODhmH3SII9CB0Ncknme6zzy3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771607771; c=relaxed/simple;
	bh=qUpADLv3fW4c6VKkfzK/U52QH49WpAV8Od6WUnTJ06g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fF6Wob3DHtggsmnB1WruKAgF7cUiUPS/Ohrl5EMrozGSx/6BRbbX7fYvT5t7aBI2tS//k/uy7FfQrqjR5WLNJhShzPZWjhNK9XntKUUvLQ3tzvCEj6/948bTIkXR26cmQMMionp6T11fs6q/POg6nf+xWz6vbP8QujzkZ46mGVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7lquW24; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6597a7bd7d6so3064802a12.3
        for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 09:16:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771607769; cv=none;
        d=google.com; s=arc-20240605;
        b=EVFEnUTkv8Sq6mLNpHpuWbIhgnsswELiKCCsgE5gkRhFBy9aX5gI4DlrpTUHnYokrc
         AWMNhFmCsAiDM1ryM1UatXLrFqMXmK+iBZLDKXEcgw8ygrFD8bxgO9DTSHlZprsWgocq
         fEJKr7E4SEzhaPPDqioOwWMnnFZ48T1QgAxhWZTI+neMAeA4jypcTb12N7hoSscZh7Lw
         TS36lE6qZ8/KQoh7g13fzyPuoy7ROSvt5WtdEBRCn5juAJdX/HPLrsLyilQsFQH/j18O
         GwhYyy1VQzJirdsj2kgANNnI4ZcQDIXrcIR24zixinhxj6p7+Yw6jHjMb/G6o8RwUEfB
         VIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+FIG9q/M+yTBjTrAHAw7SaWHpsPSmQOUIDS7bx4BpBE=;
        fh=eh6MzEl93B7jjFW+YYvc3IEMZnEjU7r5OsAQLOwnadU=;
        b=PYdOMDvzdkrtYyxMviEDXnIZsCM/nO2e9BWpgdsTvkXVb4ogehz9Js7qoOHyaY5kSb
         ORo5enByhG445enc1zDmZ6RLZrA9vo01brmR1yOP2esLm9aGFtnHaWwQFAyiXWXRtDzB
         uOkk2yrKYmXSyWgli/OjLFCcu4sIMLMKlyg0uerbQR4arHn61wXeRkSWuyhdXqrWDAv3
         D6wvA/vrTZhDTSUyKaw6SPqVfAeFqiZwffjCyoBHItKT8nuvlpt3aKQL90pxpYJhuB7D
         xfDHIzrrnAOXBGMmw7PE3lcNhIXIqTJer9HrdPL+SHK7Q7Qje2oK0BeXlIUnNLXHT6VB
         4raw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771607769; x=1772212569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FIG9q/M+yTBjTrAHAw7SaWHpsPSmQOUIDS7bx4BpBE=;
        b=T7lquW24vMSRjgoEygIGRyE08/+q4o+RUfMXAZBhrE/0bR2snow2U7+jW02AKYKsl3
         0YinK1VhhMdJbjruFy0rRj7VFT1eAKRxExNJgq+w/96MK3FpoSSbHoiwo568oGgUFcV/
         BadXZPqH8QETK/iUAk+5JN3M8UF9i2vEDzFR1Lh/p/SNlEEaxzxLlhOKAd5iMABhg67Y
         g/Ad2mlze4BV1iucz8EwJBH6ee0Zlnk+ZY8V/3L7z0QnrI3Se4T5q+ukxFzE+g1cD60d
         vQVR09MX8uP3WurKjZkhRDQEA3klgP4YGhWfAa8WAIkHgux/rUjyFrQD1qx6bzq5Ytka
         qlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771607769; x=1772212569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+FIG9q/M+yTBjTrAHAw7SaWHpsPSmQOUIDS7bx4BpBE=;
        b=TNzKs1+QZ1QUydpph4yBMkkDdK1J5YlAjV2A9OfpkYIlfgYMB8kb38RkbcXy4P/NC+
         amudayHb1i1qHKYX2SjBsptps4UUmxy+rDJNVdV0gl7yFyImhOZtHnv1p/Y6num9JrlD
         KcXbpkbQ+OOxZWlr3i9qmQxV4Zag87EAw0uc/eMgeRl5amS3ifk1e/IxQJPP0m5T6xO3
         9fkPqV2eLibi0B5t/NZ4k2oWnyWas8JWjjOLXP1Ai1tftqVWFj88tB8/Dm4jYrtpL3qP
         fU50Eh4AAcaVlrxQzB9lGwb4P0ZpDO5wARMExvupxDmhHF6S9iunOuRIuUofEY94pyWN
         SNRw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ8jMtl7sABdIw5acB98PH18KJr005ypGFFUfVFQiGrgbiSbtzd9S2onHnmbzKnHWJ6tMiYoWT@vger.kernel.org
X-Gm-Message-State: AOJu0YwmMesXf0gZND7W17M5uVQbhEBUbjjyjlZUfyKIU7UlAlCVAg4j
	paXUqbqHjH15bHJJGZEb8k+kUVhViT9wTZnsT82TZO6N0CKE3pC/YCKsuX1yrnjrJLFTFMkz9MG
	J58sr7f4ZEVuU2E//unb0V5gyYtWEiV4=
X-Gm-Gg: AZuq6aIeq5uFYSo2nHKVA8OnXyWSFu3PcUQ7spzM8NvyIN0smJ6Mtj6vm/nh1SyKVKk
	U9ebIkpd5W33sBA1W2hDsRWT8oPX58FNo/ozolrfZVIMhNGyRIeHJEetysvqbTun2Bc9p9sYRJO
	Na4ZCtBk43av7DgLnVxgbGOPvJkBt5IIEWNcZSm2iJ0E+4ON/KmdGEtR2CcD+2r5+ez7Ai7voTH
	VYBW0NsLMB1PHNwgsyGQjMTQYe1CTESWNOVCUNOo8oxzjw2aFI3ETEaZOHp+Xni59UAd1f8C8U6
	t1pwvBc+WZfZeKY/MyrFCI0gQF3uBgUZnGZPdZO2tA==
X-Received: by 2002:a05:6402:50d2:b0:64b:58c0:a393 with SMTP id
 4fb4d7f45d1cf-65ea4f07f63mr241574a12.30.1771607768401; Fri, 20 Feb 2026
 09:16:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220055449.3073-1-tjmercier@google.com> <20260220055449.3073-3-tjmercier@google.com>
 <aZh-orwoaeAh52Bf@slm.duckdns.org>
In-Reply-To: <aZh-orwoaeAh52Bf@slm.duckdns.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Feb 2026 19:15:56 +0200
X-Gm-Features: AaiRm51-NxZivWP9n79oFDzWvBAa9d7rBDJz7DAiXkp5nty2l6CfzMRpgIoYHak
Message-ID: <CAOQ4uxjgXa1q-8-ajSBwza-Tkv91tFP-_wWzCQPW+PwJMehEWA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14059-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,memory.events:url]
X-Rspamd-Queue-Id: AF5DC169A78
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 4:32=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, Feb 19, 2026 at 09:54:47PM -0800, T.J. Mercier wrote:
> > Currently some kernfs files (e.g. cgroup.events, memory.events) support
> > inotify watches for IN_MODIFY, but unlike with regular filesystems, the=
y
> > do not receive IN_DELETE_SELF or IN_IGNORED events when they are
> > removed. This means inotify watches persist after file deletion until
> > the process exits and the inotify file descriptor is cleaned up, or
> > until inotify_rm_watch is called manually.
> >
> > This creates a problem for processes monitoring cgroups. For example, a
> > service monitoring memory.events for memory.high breaches needs to know
> > when a cgroup is removed to clean up its state. Where it's known that a
> > cgroup is removed when all processes die, without IN_DELETE_SELF the
> > service must resort to inefficient workarounds such as:
> >   1) Periodically scanning procfs to detect process death (wastes CPU
> >      and is susceptible to PID reuse).
> >   2) Holding a pidfd for every monitored cgroup (can exhaust file
> >      descriptors).
> >
> > This patch enables IN_DELETE_SELF and IN_IGNORED events for kernfs file=
s
> > and directories by clearing inode i_nlink values during removal. This
> > allows VFS to make the necessary fsnotify calls so that userspace
> > receives the inotify events.
> >
> > As a result, applications can rely on a single existing watch on a file
> > of interest (e.g. memory.events) to receive notifications for both
> > modifications and the eventual removal of the file, as well as automati=
c
> > watch descriptor cleanup, simplifying userspace logic and improving
> > efficiency.
> >
> > There is gap in this implementation for certain file removals due their
> > unique nature in kernfs. Directory removals that trigger file removals
> > occur through vfs_rmdir, which shrinks the dcache and emits fsnotify
> > events after the rmdir operation; there is no issue here. However kernf=
s
> > writes to particular files (e.g. cgroup.subtree_control) can also cause
> > file removal, but vfs_write does not attempt to emit fsnotify events
> > after the write operation, even if i_nlink counts are 0. As a usecase
> > for monitoring this category of file removals is not known, they are
> > left without having IN_DELETE or IN_DELETE_SELF events generated.
>
> Adding a comment with the above content would probably be useful. It also
> might be worthwhile to note that fanotify recursive monitoring wouldn't w=
ork
> reliably as cgroups can go away while inodes are not attached.

Sigh.. it's a shame to grow more weird semantics.

But I take this back to the POV of "remote" vs. "local" vfs notifications.
the IN_DELETE_SELF events added by this change are actually
"local" vfs notifications.

If we would want to support monitoring cgroups fs super block
for all added/removed cgroups with fanotify, we would be able
to implement this as "remote" notifications and in this case, adding
explicit fsnotify() calls could make sense.

Thanks,
Amir.

