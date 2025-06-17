Return-Path: <cgroups+bounces-8547-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0501ADC10C
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 06:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB8A173EC8
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 04:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD52221F09;
	Tue, 17 Jun 2025 04:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elMGTWUG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C80157493;
	Tue, 17 Jun 2025 04:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750135617; cv=none; b=NWgp5AWr4RvNfDWT2vao2bxC8lRFPu2BTUyeTEHgHY7snML/qosKuP6oUeRpRFXayU7wkHnQtX0s/GRrgiKCIUlv6AN3iEAKdNrpOx07DQVG5N/kKXqJ5ya+tTBOxXKL/zbw4ETC2E8pjIFZjg3ZlQ+er0JuTL12KqJyNqVpFXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750135617; c=relaxed/simple;
	bh=djZGuBBs2bsUg5GxthdovqBoIv6XV8G/LNNBeQWCUR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtS/Qq8p/z4m7LRZDzhmXq2gP8BE0OexP8VjytPM8lAomZmn+Q2u9FB9On8BLkyqb1DcqLuIzHfa6dNHtvXm/mm45h5JY25DxWRir3jTIr8odv4zV3NESSJr6VumtX2HPtZoWFQIYk1RjYd3aLr6nOBwy+smFr2WOan3zl5VicQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elMGTWUG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235f9ea8d08so51305495ad.1;
        Mon, 16 Jun 2025 21:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750135615; x=1750740415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gwf6lWVh6vwPUXI7y6Hbn0uM9RsO0bm1Y2buQTA5FFU=;
        b=elMGTWUGeXTeHumBWL9OJl6ftvOSXAVIkFnStgn5xj0hyrQ0wiQVM8h50gJOSBF7P1
         e3cnDQuinXw0t5XIT41A320yQECPER2xTM7ps1jjGW5n+ZASLd8EY0GZrs8jLf38yQL/
         NG1kbuMhC4MdVKjyiTZ2tW0BLeii1DASM6XQk2SNReDzMb3NaUkalT9GRCc0R3Lu94Ho
         qZi9H+rMBsRYeBVWC+GwGQAvq3LLxv5/rKvGhpiwqJZkpCCZzglYtkwZfOu9Iah4xOpa
         eDqriJbE+q3jnVOb31s30bt4fDUwtrxbQ3izsgI6nHy3heVS4KIy1Cm5qGR8yBdV2jCf
         tBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750135615; x=1750740415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gwf6lWVh6vwPUXI7y6Hbn0uM9RsO0bm1Y2buQTA5FFU=;
        b=pXacfPgF9u1b81MT5kLs9NSlyEcXJ2PJVf6IZspHd5GKTeuE82ajYG0VHG0+5G+3fw
         3docQyjrwxGYP9NthwrBhKhxMlaWHtPNrF5YjrmRti6GbeZYKbIrcwZFUx2kYnF8OWVz
         Gkworrmr3LGWdzVoFN+Ulg1UMtWevXoF2scv9yhdr9GhtmfaiRW3urUr/NKvUW31QyDf
         22Ir40jRG22lbmSEUTTbmJM/zGcryKs4QyZVaWk49XFS4XvMlsL1y20k5b0RVHw3a0FU
         nAp7zlSXFjViMGkTU2BWB2gPOIhtlUGtXmP1NyUfLb3x+J6XIbDGbh+7YpuNm8YseKVH
         TDSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDA8UBXu+8m/cHZYUuCGHQaf2b/aCLNyvKll7yAxd0B30RWQ29+h3da1qmsmYmGHI8aUpy10gHVH4qJFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8xD9PSiFy8sHJdVwDeVIeK+zSgjdhZAA/YfTT26dkzm+9kv0d
	CZjxCqv8hkkZaQQ0Zo0TlzPRfXV6rQz3dk9diGKEpOBREVtm7RJh28Ci
X-Gm-Gg: ASbGncshC7c8FBnMtZTwmqwXphBkJyu5ripX8C8+im4d4grNTRokKOiJX9lDbUdQ28T
	ZUtwUt/BPocxJ92+XSLIMpWcQ37g8F4lJO9kyx2GLtb9cIQ3vMsYYAcmwoHQEwqnMNp7ZT54+Si
	kjpFV1s4ZCRAbUT5iXGIaukxbwfSzKbBd+hzMFTlJ5A2JNTq7QtH22PxZb/MuTHKzaA4LrJxLZV
	8PmlU+EPooxf+kI4NudzImBUwcG4x4a6UUCo8uzppCie5uW6WqOcGLMmvrcUN1wSqhyqBSrfrBW
	x0iGdXAls3YLjrxTvZfD/kuavl/GWOQNBAg8EbJru9G7o35zyCFqNKVv1uLxfevhjC5denDa9Ke
	BbQ/kA2X5lEIa7uSzRXr0VznNlRmiETgXT9pifVi6+wbIrw==
X-Google-Smtp-Source: AGHT+IES3JanLGHOqo1V63xOcHE62kJ3TKusfZClZfSOdERJWLtKmwCffG/GZvC+YncOi67AYw3+Ew==
X-Received: by 2002:a17:902:fb90:b0:234:9374:cfae with SMTP id d9443c01a7336-2366afe7d06mr128134785ad.19.1750135614694;
        Mon, 16 Jun 2025 21:46:54 -0700 (PDT)
Received: from ?IPV6:2601:648:8100:3b5:c6ef:bbff:fec0:9e95? ([2601:648:8100:3b5:c6ef:bbff:fec0:9e95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88c239sm70416975ad.11.2025.06.16.21.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 21:46:54 -0700 (PDT)
Message-ID: <fd40f2db-66e2-4bc1-9a16-4a301d807a88@gmail.com>
Date: Mon, 16 Jun 2025 21:46:52 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [cgroups?] WARNING in css_rstat_exit
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 syzbot <syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
References: <684c5802.a00a0220.279073.0016.GAE@google.com>
 <vjqyx3bkhyomb6zafk5xmjpfsitmqll3wcoean3orwpl7vkgb3@pbo33km36ek2>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <vjqyx3bkhyomb6zafk5xmjpfsitmqll3wcoean3orwpl7vkgb3@pbo33km36ek2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/16/25 2:49 AM, Michal Koutný wrote:
> +Cc: JP

Thanks. Looking into this.

> 
> On Fri, Jun 13, 2025 at 09:55:30AM -0700, syzbot <syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    27605c8c0f69 Merge tag 'net-6.16-rc2' of git://git.kernel...
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=103b1e0c580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=89df02a4e09cb64d
>> dashboard link: https://syzkaller.appspot.com/bug?extid=8d052e8b99e40bc625ed
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/79ab1e186123/disk-27605c8c.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/d37bf85b966d/vmlinux-27605c8c.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/eed2865abf8f/bzImage-27605c8c.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 5887 at kernel/cgroup/rstat.c:497 css_rstat_exit+0x368/0x470 kernel/cgroup/rstat.c:497
>> Modules linked in:
>> CPU: 0 UID: 0 PID: 5887 Comm: kworker/0:5 Not tainted 6.16.0-rc1-syzkaller-00101-g27605c8c0f69 #0 PREEMPT(full)
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
>> Workqueue: cgroup_destroy css_free_rwork_fn
>> RIP: 0010:css_rstat_exit+0x368/0x470 kernel/cgroup/rstat.c:497
>> Code: 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 0e 01 00 00 49 c7 85 70 05 00 00 00 00 00 00 e9 00 ff ff ff e8 c9 07 07 00 90 <0f> 0b 90 e9 3e ff ff ff e8 bb 07 07 00 90 0f 0b 90 e9 30 ff ff ff
>> RSP: 0000:ffffc9000b6afbc0 EFLAGS: 00010293
>> RAX: 0000000000000000 RBX: ffff888057c7a800 RCX: ffff888124754000
>> RDX: ffff8880308b8000 RSI: ffffffff81b514e7 RDI: ffffffff8df26da0
>> RBP: ffff888057c7a808 R08: 0000000000000005 R09: 0000000000000007
>> R10: 0000000000000000 R11: 0000000000000001 R12: ffff888057c7a820
>> R13: 0000000000000000 R14: 0000000000000003 R15: dffffc0000000000
>> FS:  0000000000000000(0000) GS:ffff888124754000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000001b31b10ff8 CR3: 0000000079092000 CR4: 00000000003526f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   css_free_rwork_fn+0x80/0x12e0 kernel/cgroup/cgroup.c:5449
>>   process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
>>   process_scheduled_works kernel/workqueue.c:3321 [inline]
>>   worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
>>   kthread+0x3c5/0x780 kernel/kthread.c:464
>>   ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
>>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>>   </TASK>
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup


