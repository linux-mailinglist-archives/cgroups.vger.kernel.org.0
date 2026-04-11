Return-Path: <cgroups+bounces-15222-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id swTdLuDs2WnSvwgAu9opvQ
	(envelope-from <cgroups+bounces-15222-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 11 Apr 2026 08:40:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 107423DE8C1
	for <lists+cgroups@lfdr.de>; Sat, 11 Apr 2026 08:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AFF43027B6C
	for <lists+cgroups@lfdr.de>; Sat, 11 Apr 2026 06:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B2F31A556;
	Sat, 11 Apr 2026 06:40:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82692212FAD
	for <cgroups@vger.kernel.org>; Sat, 11 Apr 2026 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775889625; cv=none; b=s8MKPNkfyoWqtWFbB3A+51zRWEU/3cqlIQQ4h6qC2X0FOOGYFwnmzvaDUTeFY8jRiqp2i1nHMvd8J8QNw+uwH6Tb/DDfuArULrRO014BIMh6eZJEJtS/umI6HJIQUIy6QbGQvibnH1lteSw/tjpVGzAcJ1OXycHHlHMP0r4jQj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775889625; c=relaxed/simple;
	bh=dbb6aTKaKbiMB2sn+6KmRfNJzQQBQNdvIVbM3TLMQ4A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ANYgXekazSxgJmBIOUEz+g/0ulSPpt3YR/gpp1C2WkeGaCQgVseJd84c1gz5GVKhB/hlLLNC0D0RCqswONIq0fo8UqZP5UQgNW3Vb0RbXu4Ilm4A63iVXoMUm/nSXn9xWJIGekKEDxJQtyPWSdS9DeydAApJinoDRORgfk358VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-66308f16ea1so4247509eaf.2
        for <cgroups@vger.kernel.org>; Fri, 10 Apr 2026 23:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775889623; x=1776494423;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jsSF9DtpaRe65xxA9jUXk6g0C0ICjz59ZSKLowAmLxY=;
        b=rXW3opoPezSKRW4nBUE/fvad30s/rwcKuJkDil84Qv9mwsfdQ1dn2i4h8E1roIXYjd
         I+CN2e+8cYVnHo+stJ7Od2GLLIAMt00GekLCLttppxTkHvz36ignN0zmaGe4kJ0WdQqP
         CWpmdKqxDYF2g1J9/wGOkdwYvuSlD3bK6XcVgYEnLrmkzX2gawDYQ246x+pASBsrRVVk
         eZm5kOydAekDmApH7jbDAdzqAyvcW2KZbhv573iMDFdM6+apAcSGGyehm3S1F06JC5xK
         tJ1wRVxH8mEa/wTQYawJ86WXZMO2MiZRdWaxraUPrWHDPiCPqor3cCsUidIA5niJezET
         ihpA==
X-Gm-Message-State: AOJu0YwW7HyG8yAzeUhYeP9gOz12k/s4d1iREVXRVjnH3/9aRid+oNE/
	+tXQvj57kOJrlwaJVJ1n8KO3LaQEtxjyeXoygOAwBeYsccUJn8/ZeNeVxSM1RZWVrc4KmXoMoBe
	IPjgXfP62uCsAV+7TNMESXNfFZTQhSnAcS86Zzr4hbkryn2iX50/ixrhoTdE=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:60e:b0:685:2a2d:cccb with SMTP id
 006d021491bc7-68be5b5ed9emr2898920eaf.12.1775889623655; Fri, 10 Apr 2026
 23:40:23 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:40:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69d9ecd7.050a0220.3030df.003e.GAE@google.com>
Subject: [syzbot] Monthly cgroups report (Apr 2026)
From: syzbot <syzbot+list98c0d38a716dbe5645c6@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-15222-lists,cgroups=lfdr.de,list98c0d38a716dbe5645c6];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email,syzkaller.appspot.com:url,goo.gl:url]
X-Rspamd-Queue-Id: 107423DE8C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello cgroups maintainers/developers,

This is a 31-day syzbot report for the cgroups subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/cgroups

During the period, 5 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 48 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3831    Yes   possible deadlock in console_flush_all (4)
                  https://syzkaller.appspot.com/bug?extid=d10e9d53059eb8aed654
<2> 8       No    possible deadlock in copy_process
                  https://syzkaller.appspot.com/bug?extid=327400a7d1255e319efb
<3> 4       No    KASAN: wild-memory-access Read in lookup_swap_cgroup_id (2)
                  https://syzkaller.appspot.com/bug?extid=e12bd9ca48157add237a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

