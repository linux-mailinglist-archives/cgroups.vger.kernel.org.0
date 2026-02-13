Return-Path: <cgroups+bounces-13951-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPCfCsZLj2nnPgEAu9opvQ
	(envelope-from <cgroups+bounces-13951-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 17:05:26 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6843137CF7
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 17:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDADA300DF60
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 16:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C9634B40C;
	Fri, 13 Feb 2026 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+XTz5vf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515A62737F9
	for <cgroups@vger.kernel.org>; Fri, 13 Feb 2026 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770998721; cv=pass; b=Ta5u0qv2ZBL6nlcDfyk5U3OOqJWkVcvP388E95jEwIxkxsT1KoXoU3kuxpyNiOPMSrcZLU0IolLS1tD4EULmdn4wYmblTi67Z6w82W+/BYo9rEL9x7lMr5j9T+v63VaBWNeGRHwJIoN/U1a3+WoNbsfyubETgqk1njgTCFeBi14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770998721; c=relaxed/simple;
	bh=zNaWJ++8SJ8WIIIFTQqrADggyRAr5B6kpmJREPVLRr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNziMyGzOx/sZxiqGM4WqMZr+0jbDg1VZrixo+QO9cy7R0ldqADLBILQ2QWSOz1W3hfn2N1kYnp/8ZTFT10RC9bkBSwuaslkr64vNqSNS1OJDSRxZZhT08qXN4hIKPZZAwEey+v/HHWckEPyyrHV/aYyVYrjAveCr03UICQWtbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+XTz5vf; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65808d08423so1646629a12.1
        for <cgroups@vger.kernel.org>; Fri, 13 Feb 2026 08:05:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770998719; cv=none;
        d=google.com; s=arc-20240605;
        b=Iyez3o6ExMFZmALScfJXhlOQBlUtPoBG74cpLVdXwv4cVb3qCYMsZdVGgebLc8ePYJ
         q4EcdkPYb821TlpWOs9lFs1iTUsm5rCfuxMauQxEBlLOHp4xXa1N/d/xNnv8kkAc/jvh
         knHqKvgBQrUtpUZFDB/6+hZDO4grhbiFOITev4xpMDBFPCKUmIjNACIYLe3kzTMSdjls
         iz7MH50BMhNZi5ctu77oQZn1pfwghU+bAx0wk4Ye4djgrh0Qg0FkQAI3GGdoX2E/B26y
         WGFPeVm7z7ki2t2lm3xQLpMKwk4Sd5NOyuQLH25a18+hB5P4oixy/I14bzkTxk3QtvTE
         yRgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MkwgwvPc/TGYeUZeINeLlvuSx+DqSyksHTVEFDYyaw8=;
        fh=iSGljgaUVe8HqfV7PbGOx42ouZZfkzT3Q60bYRrGajM=;
        b=gOUY3QNIfZukm6iR9mKJQKq5lxGxlLZtoDWl9g+5x/WtpZGd+kRYVeidpLR4qO+gd6
         Zrdlw925MqtHEFryqacng7XheagJCVK/SVxRcvKJ+abk+RpN0D/a7turGa+SwCFgVRpG
         WltHooz/dwzhF8l9c5WtuGdkLFjLHdcwBS43KK2c5KYzjGZdR3BTXEBMnURbbtPoslph
         EvDT5NIzOTHZ0wIUwl9X2hh1iXVB3ExE04OGd50F3U7r3d8PhteDPkbgZRDuodVmVtJV
         1ooE7ACYHM5R4eY+Uu5k3r3wI6skamjooreImanLcemlMdusE6z7ocHP4sSzOvISBczy
         xXWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770998719; x=1771603519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkwgwvPc/TGYeUZeINeLlvuSx+DqSyksHTVEFDYyaw8=;
        b=i+XTz5vfLo6DbzadepXEA6quUyyicbSNdjX9kSwJsrHxkdnaTmG8Y5+Ra+SC0mICMf
         U7r4z5r8RrXcB5W8VNaeTUGw9E0Dcfo06VT93i+wtN+/eUjcV2xSNVNBaqyc71XVe8gV
         /BFbNcKa6/Xq4zkbmhlAd7r6YaezRQch5TjKPtGhmMOcV1MjhyAUm1WWm5PE5b0zB0To
         4uHQWDTnNCyrEMpwdqlGCF7Y1hdZv0kxvPSGVdKd2WBjUV4dYQH5JYXTpIE0kEMgxiof
         TZ7s6YCUBPBCVZ9bIcXbIQd4ASoPPPxJyqf3IPV0+F5nItPfOBiHujrJyqSLhmLOlke/
         ilbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770998719; x=1771603519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MkwgwvPc/TGYeUZeINeLlvuSx+DqSyksHTVEFDYyaw8=;
        b=aaHNo8wfk3f9hdEIyJYcB3fCTmgVwFgCAvUShUw3pajIRcFbBEUfv7Z9h5VnFu4PkD
         VbI6s29DgBnD0N0GPLWawPFCdp/n1z0vhM1YjVTwkW/XN3bWIG3e/a8DX77HfnwlQxxZ
         SUf7YLOpYF9CJ3WAMt8ReC+qpwNDmrH6ATBGIoyAP73G+QNIYe2dPFS+he4VEKSU5DLh
         dfwfbmgcQpQ0CfZ9jCfRAtFhgYersH3YZFbfM4Dbx1Pxb7kyTvd647N22CX4w5tLIvO7
         EOVmazmvhfcHnzC6W8/RQHOIroq5urViM6gcNTUpe72t58gyTprv3MomVy76NfgkD7NS
         tqEw==
X-Forwarded-Encrypted: i=1; AJvYcCWuGBVCv0VakbZ4DxL9W4oAV7Yxn/70DsFUvOHPXXIxTDJfaVua1vmFAJ3VMikVCOq5aakotnbx@vger.kernel.org
X-Gm-Message-State: AOJu0YwGQk6bHPxteQRBZdssMI9P6PVzN4I2x6pKL1/CRnqDHm0VdA4g
	eSiUVswwOEoO/sMCcThym8Xx2NJkvWkgDx4KNn8hjUr8ubg8v6WelcDkFiYl5ZO0S4l8mE4+7jU
	8oD/f8hMq9CowgwXBTjPaBqHYrfZAkQs=
X-Gm-Gg: AZuq6aKgNeK/u6hq+Jm9Vzl5znLPws9euhM1sg+y7B1aXZPGGre3qjcVnEm0+FxcOxC
	fqU1aqzQlQIi5cmbUfSJ2apiRfZL3gK0HwTulpGgP2uCYFrRcpJf99e9l1TQ16VUdZkfGnXjFO3
	HVHfKrCD/gIxialTV+iZYgrTT7sQQ85m4fRpkCCPxVzJb94Fs2MlThG1cDDvYXX+oQraPpYgh4J
	zHHXfjfTyKJzLFJl6bg0xwkWjRPUuv+VJqkOngL8vZOQO1ZfIgQZxDYv2xBLbghWGk/LDeI3psy
	MVzQqpqI+OktJe36KYnbmWUPrwdv07BCrayB3wKa
X-Received: by 2002:a05:6402:2811:b0:658:b87a:6eba with SMTP id
 4fb4d7f45d1cf-65bb1179568mr1262757a12.16.1770998718382; Fri, 13 Feb 2026
 08:05:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69859728.050a0220.3b3015.0033.GAE@google.com> <CACT4Y+bd+PcL=XzkehM-bmsfAB95UA2y9jr5JY2ov8zVOp1DWA@mail.gmail.com>
 <aYYkvaqYGLXD3_P-@linux.dev>
In-Reply-To: <aYYkvaqYGLXD3_P-@linux.dev>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 14 Feb 2026 00:04:41 +0800
X-Gm-Features: AZwV_QhLIH0quixbRtysZ8YmE76vHilB5tNwj7k4LwVDO7mxrympCqPOI_9dgy0
Message-ID: <CAMgjq7DVNMSez70O-3v1ANuCcSzgwaXckusVcLyT6T=UD-WNOw@mail.gmail.com>
Subject: Re: [syzbot] [cgroups?] [mm?] KASAN: wild-memory-access Read in
 lookup_swap_cgroup_id (2)
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Dmitry Vyukov <dvyukov@google.com>, 
	syzbot <syzbot+e12bd9ca48157add237a@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f1fac0919970b671];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13951-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linux.dev:email,syzkaller.appspot.com:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups,e12bd9ca48157add237a];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: B6843137CF7
X-Rspamd-Action: no action

On Sat, Feb 7, 2026 at 1:30=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> +Kairui

Thanks for Cc. I just noticed it while cleaning my mailbox.

> On Fri, Feb 06, 2026 at 08:31:19AM +0100, Dmitry Vyukov wrote:
> > On Fri, 6 Feb 2026 at 08:24, syzbot
> > <syzbot+e12bd9ca48157add237a@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    18f7fcd5e69a Linux 6.19-rc8
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1428fc5a5=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df1fac0919=
970b671
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3De12bd9ca481=
57add237a
> > > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils f=
or Debian) 2.44
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > This happened before:
> > https://lore.kernel.org/all/67d04360.050a0220.1939a6.000e.GAE@google.co=
m/T/
> > and now 2 more times.
> > All reports look similar: exit_mm -> zap_p4d_range
> > And all access addresses look the same: top 13 bits are zeros, then
> > some garbage (0007fffffffffffc).
> > I am pretty sure it's telling us something, some kind of tricky race,
> > rather than a previous corruption. Swp entry is somehow invalid?
>
> Thanks for the report. It would be good to have a reproducer. I will dig
> deeper later but good to have eyes from Kairui who has recent changes
> in the area.

I've just checked the syzbot's console log for the two times it
catched the error:
https://syzkaller.appspot.com/text?tag=3DCrashLog&x=3D1428fc5a580000
https://syzkaller.appspot.com/text?tag=3DCrashLog&x=3D16c2c694580000

(from https://syzkaller.appspot.com/bug?extid=3De12bd9ca48157add237a)

In the first log, before the panic, console is full with:
get_swap_device: Bad swap file entry 4003ffffffffffff

Which indicates there is at least one, maybe a lot of invalid swap
entries of the same value in the page table. Unfortunately that's all
it can tell, maybe something corrupted the page table?

