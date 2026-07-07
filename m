Return-Path: <cgroups+bounces-17566-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OHFeJ4piTWqozAEAu9opvQ
	(envelope-from <cgroups+bounces-17566-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 22:33:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC7F71F8BB
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 22:33:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17566-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17566-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73B9030160C8
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2026 20:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E398B3BFE3E;
	Tue,  7 Jul 2026 20:32:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7CC29B78F
	for <cgroups@vger.kernel.org>; Tue,  7 Jul 2026 20:32:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783456349; cv=none; b=WCVKQCiHes2CvqrsEYBhHS4ypplkDqX2DJi/UP5C9UI7+ynV0lAC39WQAS8bGP9CdG3rHbidDR0vg28pY7e3sHByAARJuN7MTtzqMkxxka35zsdilJn7MSGXrdyq+XGVSsytlmhz6u9y9JWHhIqdS1aOJ9bvpp5tL1W8ssz8nvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783456349; c=relaxed/simple;
	bh=zT8GtYrRO0iXUvJJ5YLz+AiFnGj8CCUFC6wghT8SjjE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uuIYGEzEmbVdwSYPiueSnsMzCprophk9rf6HDZ2ub2NJSImUVrNLJ77GMjVhlWspAsIf4DMk2ORBGz7h9sRW+i9gA5HCffgOXaIcjJwdI3NGsRGzyzPfw8VoKSWemgRqk153AxVCS5h/cO6m7MBx7i7M6xDFjoY55UuzALscsCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6a178463cccso5877664eaf.0
        for <cgroups@vger.kernel.org>; Tue, 07 Jul 2026 13:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783456347; x=1784061147;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vHSxX8WRXSlMuntur4mrwQtdbE8h9YVG/xm3TSqULEE=;
        b=VGTmUX2/hnxKB5lukpLzqDPqFhHzS13CRFKjULh5wMPJN9w3p2IQw51XhvIoSac5NN
         VVUTnp5xlTnqmCnR18xc98XJjpsE04aEnIax53Ak565xOBT8BJK7HuEbO9Xjr8RXsq6a
         VB4K3YCyNFP9tS3lSel4xn3IMWLeP4lvChGbUUtR5MOd57KGEqNrhAX8p8wIRP9v9bEy
         t0AeUv6PAZil1sLbrYACgUY3M3WmDpbltSjnRJ3F3ZcXzr0sIvX7JPIipTYJxNgBv310
         nldj1kGZ+FKSc5jPeQQC0aKeNsC35nRM3LC+jMABMbnxmjhwQY7Z+dlLy+Ai9N3qma3a
         YMyw==
X-Gm-Message-State: AOJu0Ywln3FkerU1npsZbaG8sBWEKwMUxghgAT82ojmTULsjGArz2RUT
	cmZw/+jXlMV4T2RAsxklVDLaN4dTrvjgLm+0ERtyuuDVcAazSQHBBwkI5RQvHVkTSYW0wyvSEpa
	IqsXHpe+wZPGP7GIbMFKz8Q1cBYCefZ5OtNWp9NGDa8/DTzvWk4aen75pA9o=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:8105:b0:6a1:41ae:1bd3 with SMTP id
 006d021491bc7-6a3555304b2mr4656001eaf.42.1783456347571; Tue, 07 Jul 2026
 13:32:27 -0700 (PDT)
Date: Tue, 07 Jul 2026 13:32:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a4d625b.a1ad617e.25832.000b.GAE@google.com>
Subject: [syzbot] Monthly cgroups report (Jul 2026)
From: syzbot <syzbot+listd158f4de91eefe301a2b@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17566-lists,cgroups=lfdr.de,listd158f4de91eefe301a2b];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[cgroups];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDC7F71F8BB

Hello cgroups maintainers/developers,

This is a 31-day syzbot report for the cgroups subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/cgroups

During the period, 1 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 51 have already been fixed.
There are also 3 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 10116   Yes   WARNING in hrtick_start_fair
                  https://syzkaller.appspot.com/bug?extid=2cbf10efc23b22ff9c31
<2> 3854    Yes   possible deadlock in console_flush_all (4)
                  https://syzkaller.appspot.com/bug?extid=d10e9d53059eb8aed654
<3> 40      No    INFO: rcu detected stall in clone3 (6)
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

