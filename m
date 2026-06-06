Return-Path: <cgroups+bounces-16683-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7THjG7MTJGrn2gEAu9opvQ
	(envelope-from <cgroups+bounces-16683-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 06 Jun 2026 14:33:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D1A64D6D7
	for <lists+cgroups@lfdr.de>; Sat, 06 Jun 2026 14:33:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16683-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16683-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C152301DE2D
	for <lists+cgroups@lfdr.de>; Sat,  6 Jun 2026 12:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13243859F6;
	Sat,  6 Jun 2026 12:32:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368771B4F09
	for <cgroups@vger.kernel.org>; Sat,  6 Jun 2026 12:32:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749143; cv=none; b=Mwsqgqf6mgyT6fgpMUTJLYH0KAKBPhxxdbkLDbRvfyrUqg7MH7iCK9oskl7so9NDYQM7NJ6DobQ4QDuO/8Xh9YGcPT6EdDD6p3p48G0GckGL3Y0TV3KiPPIHC8Hn/UxlxLW4WTu2dNxojXJlsy+Nw2Ml5zOz9xIYhCfd5gQJwZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749143; c=relaxed/simple;
	bh=gxageYX/Ts8Mnw+iWYCZ0YL6y0ScPmQ7as7GnYqPBOc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VnDL3GoCS2QAZYT/qdixDQkITFPGRX/IEKNygNpb6JI5MbC7sSWyXIqTFqvHgtmvztwUBEH4LrDWwfBf/fnLQZ99EbVxYl/1t3KoYoUy6DWOdo7VJfpeMCyiFjqTwoemvLSaC4tH/JTPDASBXnc0yJFe6XV9NvxI1rEGeprbpqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-69e47dbf2a7so5151739eaf.1
        for <cgroups@vger.kernel.org>; Sat, 06 Jun 2026 05:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780749141; x=1781353941;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QmmLR1B5Gue5VrE00N4HV98WpxJ9ic+QZwNefcNHjlU=;
        b=K2LGzoLk/Lfbk7Bmsbh98CrRmaCEel4rox+jrB2l1j/ZDhIXQcL1Vb1bjtnQEzJHvT
         mQDPsCJk54T65piHV1jbBr6gZoq12UPsaF9Tm8qdEUGB6xuTwtNpZux9dYqy4lJ1NTgF
         e6Q8rM4/EQpK3jJHxfa8OgWR5XwM0oU8tqtzI0SaHrfn4aoGLQl6ofhR1fMMrL/oS+Hw
         T6nmHq0uG5F2ihvO0w7pQzvN2CUY1dVHkEbO5S//u8qpeCdyQoEMqldJlV8mZWmLMHa6
         cQFZD74ZGX10mWGXVtg6UtZICkm1RtWIC3SvOqQvRw6CZUZOyJADpIiQ/KqGjhU3xATP
         mfog==
X-Gm-Message-State: AOJu0YxMqGTubCwtfTTCpyHn19pB7Kp8mqTa8QaxW32MTrrdmbrBHYru
	TUtCFXdwnh6qBOfcf/YQhxVp9OiwCoqs63wrFSOXWEs9GB5TvCDuWpgMaUzU4Vs4qs9bB/vqE0/
	5nyZjHDj87Pv+SG8z1C5DoAoksMeKaqemw6SYSbAK4jtdmYJZKQMEHFL5NxA=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1786:b0:69e:5d9:7e49 with SMTP id
 006d021491bc7-69e6d508a05mr3103341eaf.34.1780749141303; Sat, 06 Jun 2026
 05:32:21 -0700 (PDT)
Date: Sat, 06 Jun 2026 05:32:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a241355.e4db5ad2.3b7dfb.0005.GAE@google.com>
Subject: [syzbot] Monthly cgroups report (Jun 2026)
From: syzbot <syzbot+liste515dd9d79291762c6ef@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16683-lists,cgroups=lfdr.de,liste515dd9d79291762c6ef];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goo.gl:url,googlegroups.com:email,syzkaller.appspotmail.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4D1A64D6D7

Hello cgroups maintainers/developers,

This is a 31-day syzbot report for the cgroups subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/cgroups

During the period, 1 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 49 have already been fixed.
There are also 2 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3833    Yes   possible deadlock in console_flush_all (4)
                  https://syzkaller.appspot.com/bug?extid=d10e9d53059eb8aed654
<2> 39      No    INFO: task hung in cgroup_subtree_control_write (2)
                  https://syzkaller.appspot.com/bug?extid=bb2e19a1190a556c01b1
<3> 32      No    INFO: rcu detected stall in clone3 (6)
                  https://syzkaller.appspot.com/bug?extid=774c2dfaebdf78f984c5

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

