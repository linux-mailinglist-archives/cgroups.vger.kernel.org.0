Return-Path: <cgroups+bounces-3400-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B22F391A603
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 14:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9891F243DA
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 12:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB0213DBB3;
	Thu, 27 Jun 2024 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UIEa7gHc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B62F482C6
	for <cgroups@vger.kernel.org>; Thu, 27 Jun 2024 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489680; cv=none; b=q7bDaGIyL4YsN8mU+/5ILRECSbOnlKDbO88A0IJDelXEe3ll5bUs8C+D72lC6xlTwxOcZOBS0iNVQzwx8Zb3cgCj4irEIEYEYB8XIqA1Jyrt7fZ/EC/91dkKTsBdyaMDteJi+bod8wXYZUbN7++pDTtLdGOFSoHbR2cYCTvBvm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489680; c=relaxed/simple;
	bh=k9j+/cSs2PAYgdkbCUNnS381bOcAZnMsEBwA3t2khoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQEdVXaG6sYERdtde9iOa1TlDeW2xQ0ChbG1apNZqma25ybj0OH011lwyjVDtVXwEn9ou5S5raR70KOpqad4yHtmNyYJtnbpWCWP9iP++htO85l1GsprQsIG/BZHHGXjn75dSOqBa8cR5QXPo65BEAED1WihqrnKn3rL3lLGQ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UIEa7gHc; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57d203d4682so1836712a12.0
        for <cgroups@vger.kernel.org>; Thu, 27 Jun 2024 05:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719489677; x=1720094477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9j+/cSs2PAYgdkbCUNnS381bOcAZnMsEBwA3t2khoI=;
        b=UIEa7gHcrwugAMEYzSzJCjbW0OiXjDs7N5LdtsJ57bZLSOaVei+elRSK+wXrgy35ct
         hDd1ng86EDZPFuZCK+BqWFSqMPOi+A+Vo9lv0YUvK2BerZjJvQp6CYn7eApra+yJ/qUe
         FvVfcbeOKhF5cT5gnoqpzVhy3EOqRoM6LzMMv/usZ2sV4kONKssnBlcRGE18sNWaru3L
         EBNotLGqy5NLmUgoCo8OCHZWFXsREtMMwU1vHsWJM1SYow+AnOdnUM7osuUFZTlfMdMC
         uWAQGZ5n061aAMH2u1ig+5IOzq4Yw0hOKLlce8NBzDIKkugOYwpLPWgZGLbRJZF2m7dJ
         q2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719489677; x=1720094477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9j+/cSs2PAYgdkbCUNnS381bOcAZnMsEBwA3t2khoI=;
        b=vx05SfAYqjzsFYIMyVE7VlcDXkjeAv7BXtZ58wi8ye9nHKl0pWutBkxhhtcAnxD/Ka
         a/2hnijX8GGFtq10Txur6lYNl33WJ2jZu0I8xu2h5QB7kKoLC0BBYStrkRfR/n3x8Z+N
         D5x8Z8kgpziIn1OZSrqIHZHY9S28XapyBt3cjVrf9rpN9O/kwaoWpL3ONBqa5HOe6nYo
         5mcsyJLsOeL1xtmiGJ5MdWGuvj/WaHRO+YNhq31F15qY6nIaVwfpJipNiq+vKwIcxuZK
         B4zymmfTf6zF8pGXN1TBo3Zjrx4nuvxqS+4ygSVKKmZasgqfYJwQuHKRRIOd051A0LtL
         xG5A==
X-Forwarded-Encrypted: i=1; AJvYcCVvM6unWAkpgJGdWTgDNKSpTRSm//lYJ3aYC+CUgZhryrjWwEhnqD5JmYJlFjNv7bmudNQitk4s6x2Kc/XpEROptYg6PwH5OQ==
X-Gm-Message-State: AOJu0YzZvUQsyTFvmsssMNIm6z+IkTAtQc3QRN9S/BqdcEDNHXHgkXV6
	cEIWzAgm/miKs+4/XuEcEzPlgG6iMiq3L6KtZyeqejGXnpZCP3jMacZMT39alUyxOmZIfnmPmz7
	10bif5kB9T9UfESR8VtqdAzRDJ9zoQRjiPj+w
X-Google-Smtp-Source: AGHT+IFF8Hiiq5pYK9NbSKbcRGMGJtjP5zoG6SUD3CzR5idX+/EYVlkwu3pidiz4GSLWh9u4DpKft3r0SyrDpQHzrFs=
X-Received: by 2002:a17:907:c78d:b0:a72:5f9a:159a with SMTP id
 a640c23a62f3a-a727f680828mr594305966b.2.1719489676985; Thu, 27 Jun 2024
 05:01:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626094232.2432891-1-xiujianfeng@huawei.com>
 <Zn0RGTZxrEUnI1KZ@tiehlicka> <CAJD7tkZfkE6EyDAXetjSAKb7Zx2Mw-2naUNHRK=ihegZyZ2mHA@mail.gmail.com>
 <Zn1Tg6_9NyxJE7Tk@tiehlicka>
In-Reply-To: <Zn1Tg6_9NyxJE7Tk@tiehlicka>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 27 Jun 2024 05:00:18 -0700
Message-ID: <CAJD7tkb9-qzYGOMHu1DfCSsWmRfCuK5Vi3NBmTz6d-dvaeAAtw@mail.gmail.com>
Subject: Re: [PATCH -next] mm: memcg: remove redundant seq_buf_has_overflowed()
To: Michal Hocko <mhocko@suse.com>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 4:56=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 27-06-24 04:33:50, Yosry Ahmed wrote:
> > On Thu, Jun 27, 2024 at 12:13=E2=80=AFAM Michal Hocko <mhocko@suse.com>=
 wrote:
> > >
> > > On Wed 26-06-24 09:42:32, Xiu Jianfeng wrote:
> > > > Both the end of memory_stat_format() and memcg_stat_format() will c=
all
> > > > WARN_ON_ONCE(seq_buf_has_overflowed()). However, memory_stat_format=
()
> > > > is the only caller of memcg_stat_format(), when memcg is on the def=
ault
> > > > hierarchy, seq_buf_has_overflowed() will be executed twice, so remo=
ve
> > > > the reduntant one.
> > >
> > > Shouldn't we rather remove both? Are they giving us anything useful
> > > actually? Would a simpl pr_warn be sufficient? Afterall all we care
> > > about is to learn that we need to grow the buffer size because our st=
ats
> > > do not fit anymore. It is not really important whether that is an OOM=
 or
> > > cgroupfs interface path.
> >
> > Is it possible for userspace readers to break if the stats are
> > incomplete?
>
> They will certainly get an imprecise picture. Sufficient to break I
> dunno.

If some stats go completely missing and a parser expects them to
always be there, I think they may break.

>
> > If yes, I think WARN_ON_ONCE() may be prompted to make it
> > easier to catch and fix before deployment.
>
> The only advantage of WARN_ON_ONCE is that the splat is so verbose that
> it gets noticed.

Right, that's exactly what I meant.

> And also it panics the system if panic_on_warn is
> enabled. I do not particularly care about the latter but to me it seems
> like the warning is just an over reaction and a simple pr_warn should
> just achieve the similar effect - see my other reply

If pr_warn()'s usually get noticed in a timely manner (by testers or
bots), then I think pr_warn() would be sufficient. If they can go
unnoticed for a while, I think WARN_ON_ONCE() may be warranted to
avoid the possibility of breaking a userspace parser.

