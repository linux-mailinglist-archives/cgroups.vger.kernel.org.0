Return-Path: <cgroups+bounces-6221-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1B4A14F37
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 13:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC488165EDE
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 12:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C8D1FF1B1;
	Fri, 17 Jan 2025 12:34:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486C41FECA7
	for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117245; cv=none; b=LzGks9X3mt+WqfLmgqjJeZVx1c6ylYprT+9q2I92Zq8wYc39R4Bsn0sOXHGiIZdO+UaAjLEbEJ5XkDPJpJxRvTLrXzavYQfRW/8ccPgRTwmJ9CqaP5Tts08EFgrxiixIThaodbggiXxzC3A0l/JTyLw171gBl3XI3imdRUszVW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117245; c=relaxed/simple;
	bh=f6UH6L4B+hKtCwzKAlYd+xmm5Ot1kU+xbkfzuFhko94=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Hr993dGSlWMjI3j6R+SZAS8jRMBYVjq8qsy3wQcUCG+gVZICEimFTX5r0Vo9nwHLKrRyrtIp7QNX64GTk8gnzuM3f54q24keNJNdXdCqpKpnO4oQ5zv1jrnP/+lz9j7QybRJrAAdWEAGbic7aQRN3YUEL0aUISaKQabQnhH4vBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3cde3591dbfso16302785ab.0
        for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 04:34:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737117243; x=1737722043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QvZtm/UtggZQ4vZzY3P7eWyMLxgL/oSk0kGt7oXniJs=;
        b=G8fnolY1I6l6j+qwYHBEHodtNgORP2xcgB3g+wz7kSuW/N3ZwxFyDrNuAi1n11w4Lg
         dq6zUZVuDdmwRPmnwgIkEmcLmjAkjAlnPLrRDsbhQTKMOJ+snYnNl39R73uxedUHXoFa
         xhpzyfSlEp8j/ogaSYLCtFWSA98ZlVStmvJzLc4YjDSFGR9zZSxhMdKx111oA+uKHa+y
         2AogxaOnNK+XxNrp/td39j5DDIiqqJJVu4fdfzJC6T9cg9E3Z/BHRd/hIHCDRRa44CJQ
         yaN+HWkt+SrnYA8CzEqDdXwEqQftgxshxOuRN6lTlWGh1JBvVSaMf7lnA9cvjYAtXW+Q
         fLyg==
X-Forwarded-Encrypted: i=1; AJvYcCWxomxNUigde15k7VVPWLVvT3rkts8o1pdf3O4pfmXICn3OXuHrREAmeMbEBzjUQIgrCZUKDZJy@vger.kernel.org
X-Gm-Message-State: AOJu0YxG6+LnBxJhPao6eSs4DBe5Dd6iV0kojRAQSD7zeuTuCAW3rI6c
	B6RKuKGISpE6pyMZkXDKn3bzbiIGOzT26qBE94qhbv6OVQmH9bR3Gjp/kOztx+MOxqaDITlwYy5
	ot5lXl6iP5SuUtNrr1aD+BJOu05VonJdJ5/M1SjM4VtbwrcyAhx5Q0lY=
X-Google-Smtp-Source: AGHT+IGSN+89+ev6I1KKIKrYVVMo2ys84hMSR+T3BfDaLgnUIIaFdFWMTnr/kHWhlVvZWahKwsOImXHsCYbnOPCcr/MWQDnXuHB1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148e:b0:3ce:7cc9:9f46 with SMTP id
 e9e14a558f8ab-3cf748b4d2dmr14934665ab.9.1737117243572; Fri, 17 Jan 2025
 04:34:03 -0800 (PST)
Date: Fri, 17 Jan 2025 04:34:03 -0800
In-Reply-To: <0000000000001e66f5061fe3b883@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678a4e3b.050a0220.303755.0005.GAE@google.com>
Subject: Re: [syzbot] [cgroups?] possible deadlock in console_lock_spinning_enable
 (5)
From: syzbot <syzbot+622acb507894a48b2ce9@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	elic@nvidia.com, gregkh@linuxfoundation.org, hannes@cmpxchg.org, 
	hawk@kernel.org, jasowang@redhat.com, jirislaby@kernel.org, 
	john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org, 
	len.brown@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-serial@vger.kernel.org, mingo@redhat.com, mkoutny@suse.com, 
	mst@redhat.com, netdev@vger.kernel.org, parav@nvidia.com, pavel@ucw.cz, 
	rafael@kernel.org, rostedt@goodmis.org, songliubraving@fb.com, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit bc0d90ee021f1baecd6aaa010d787eb373aa74dd
Author: Parav Pandit <parav@nvidia.com>
Date:   Tue Jan 5 10:32:02 2021 +0000

    vdpa: Enable user to query vdpa device info

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1440c2b0580000
start commit:   619f0b6fad52 Merge tag 'seccomp-v6.13-rc8' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1640c2b0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1240c2b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1cb4a1f148c0861
dashboard link: https://syzkaller.appspot.com/bug?extid=622acb507894a48b2ce9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175029df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f29a18580000

Reported-by: syzbot+622acb507894a48b2ce9@syzkaller.appspotmail.com
Fixes: bc0d90ee021f ("vdpa: Enable user to query vdpa device info")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

