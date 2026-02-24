Return-Path: <cgroups+bounces-14218-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKp+BHO2nWlyRQQAu9opvQ
	(envelope-from <cgroups+bounces-14218-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 15:32:19 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFFB188647
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 15:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ACA5C307CF11
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 14:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABAD3A0E88;
	Tue, 24 Feb 2026 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEvp4urk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ly4rHx4T"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7C73A0B33
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771943440; cv=none; b=PPXt+SQo1DkD3XZFeDUarjgWd9vbOoQfYQul+TkA7lUBZ9SIr452mLQ5h8/oMD+iR+b2PNZBxIBIOBND2BGA3CXrM8aPDW7odpahHbzIUh6kEtnH+vRxfagQ3PXZWINO5MBYxbbIGLDMMVYC269mfQ/NH4GkJ/OP/z+kQJIoed0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771943440; c=relaxed/simple;
	bh=EEO0ys2jLJe5ulVjIcEO8N1XDhyXJJarAZ+2McMcLNg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=VlcwNP31W1Z1lIMWq9jFd2lueJk38lTihpc5FGb89qjq/Ayo0LssiBLjwpMF698pjL2VkJMJvOgOQD7mi9AHsVzuV4MjS6arFAC60+hrZm20F4KCYRRk5Gh1Kav2wa+1IQ5o+rEhCxYJgo7v+BIsMlYHQJOPUPWd4UEELDK2PmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bEvp4urk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ly4rHx4T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771943436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PntXmeV8m0dM1k7TVZ2v1lGJtL7bc61s3VFGBHlJexM=;
	b=bEvp4urkM/BCJjOz/CZn4iuc5qr5GYCVRbVn/zz5Vegov6i9nGiO4GYC66h8ErPOPBg4tr
	fT9raCF7dkWALvRoiRltW4EsYx6A+07dwWFOtp0aIxMiPyoi5h4aKC88DivewTthoSkd11
	FoP0/CqdOA25SzH/EJJG2g+vOWapKMA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-Ru-tbz1JPXeo64LsHVX_Jw-1; Tue, 24 Feb 2026 09:30:35 -0500
X-MC-Unique: Ru-tbz1JPXeo64LsHVX_Jw-1
X-Mimecast-MFC-AGG-ID: Ru-tbz1JPXeo64LsHVX_Jw_1771943434
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c70ed6c849so4588079485a.1
        for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 06:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771943434; x=1772548234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PntXmeV8m0dM1k7TVZ2v1lGJtL7bc61s3VFGBHlJexM=;
        b=Ly4rHx4T2bBKnM02f1fMFG6lTuPhUoNQEkhxH3d7w9rDesHLb22Ge1nOmUKV52gkjb
         DY47yuUSN0e7Z13PFaXuWcLghnolABFuaY/zGJTvJkJN26aEwnq8AhEfZQO/2ni/tETC
         C0tmdEcBPNSkuxOYYKPyGuejkGDbBwUWi7XbwM6ENTudq1GFWlunF4RnzMP/0ExLG9mg
         /qKiq/Yn9KupbV10A3zKQkdd76mGU5brRG/BaKpB48tDCVwoCE8lwoQBSrfIs4Jg4mU1
         oR34Ql3C8GLnNPVdiensh/sMnFVi4vBGFtGthHZPhintllCoYWqZe1kY0cRpItL/jlIP
         xG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771943434; x=1772548234;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PntXmeV8m0dM1k7TVZ2v1lGJtL7bc61s3VFGBHlJexM=;
        b=jKfKMliqtMPBMIxPhD0Txubef5zuQKk/GZDCssT2/Qj6q7JakSBU6AJcxE0LN1srcH
         +7KDKEHiAGea9s/Uw1AmvKY0NFPpGP2fv1JDD31XEaM+FPw4hjiVWqkvUc/kMkFqlt/2
         5bwWSj+8gDyQlmQPf5dtSygT4NI0DEueI6SWd7RImvspxTrwu43fVo/0J8+rCc7LVfEd
         gEZYzhFs/7c1SGQw5c6dMNPHyqbw/11UUlfcglopqb+OjQMZ4NOI6j6i5J0uewF7lPku
         yrdilsS+dPFFcf9AzO76T25lDOA0e5y1HkK98Upk6tonE+hIUoyhYLz5ttNxVkFxe8hp
         Lbqg==
X-Forwarded-Encrypted: i=1; AJvYcCWS03Aq71/wJE2pW2Gti1DchLRpACX//o4rugWXdKMbrfJSBbMG0X74bSzbf5S4hL5l+Y7UMbhC@vger.kernel.org
X-Gm-Message-State: AOJu0YzPhqlxA09Dp6pWqiHfqV5oibUcmVBABVgK1BBXyX2Bjz8FyRLe
	LOH/yvAt9ZemJ6HEWRwez+VCHe3Vv9hQu9oUI+5DpBW19XOV22ToqPRLg2H7DGMurXWOnhQzJk9
	hBMF7RQyZYkoCWGLKxALuJ88zGMdhATFHc7b1Hh921Z3Bt/EcEtXSTp/Do8M=
X-Gm-Gg: AZuq6aLMBnM024MV+mdwZfem1dylqy8mVBTRMF9pQxrBW61OfiRDzmgG21nvyRkZdaG
	9NW+/5fgcP6r3l57WEtgV+hz1KyZDZ2GwmvS/Z6NeCnGkRAg4Hqmjwk7ugMjESY8bheGUH3n+L8
	k21FvlGhujj4QfopZgvp8SRr1IA7KaI0PNBiyn6tpfUCku6DJ0qq0LVVLVnP4o8BX83ffOe33vl
	4rjKVocxh7NZxQpjJC3OyyAqsbPcUkcm2QPdA5oiypYk9U1PjdxgAY84LwyY6l1Shg4A+XSma3H
	1tH32WTFQwZme7Bp3iW33nb0m4NJw93aYL13ILy33KaYApicKXtjXxvULXRjwnnywN5bgPUitb6
	KDaxuw8wdvxA5PEe6P7nmC4Cir7F8dGv41X4Kump0hxcNAVFmZo5ANYdHuyl5h/BZs2Hm
X-Received: by 2002:a05:620a:2104:b0:8c0:ceb0:890a with SMTP id af79cd13be357-8cb8c9cc122mr1275948485a.16.1771943434224;
        Tue, 24 Feb 2026 06:30:34 -0800 (PST)
X-Received: by 2002:a05:620a:2104:b0:8c0:ceb0:890a with SMTP id af79cd13be357-8cb8c9cc122mr1275939085a.16.1771943433499;
        Tue, 24 Feb 2026 06:30:33 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997c691113sm117137576d6.1.2026.02.24.06.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 06:30:32 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <daaedee9-a41d-4d26-a182-cb709304a4ab@redhat.com>
Date: Tue, 24 Feb 2026 09:30:30 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [cgroups?] general protection fault in
 rebuild_sched_domains_locked
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 syzbot <syzbot+460792609a79c085f79f@syzkaller.appspotmail.com>,
 cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 mkoutny@suse.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
References: <6992351f.050a0220.2757fb.0035.GAE@google.com>
 <544a0eb5-3c03-463b-911b-6f3b8037f8e1@redhat.com>
 <30efbec6-b80d-471f-a445-5b7f06dd0f49@huaweicloud.com>
 <02712184-b1b7-4501-9e6e-b8d4432fb11f@redhat.com>
 <09d89416-2160-486e-8675-ffe898ac2612@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <09d89416-2160-486e-8675-ffe898ac2612@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a512b4a06724b76a];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14218-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups,460792609a79c085f79f];
	RCPT_COUNT_SEVEN(0.00)[9];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: ECFFB188647
X-Rspamd-Action: no action

On 2/24/26 1:56 AM, Chen Ridong wrote:
>
> On 2026/2/24 13:37, Waiman Long wrote:
>> On 2/23/26 11:03 PM, Chen Ridong wrote:
>>> On 2026/2/16 13:57, Waiman Long wrote:
>>>> On 2/15/26 4:05 PM, syzbot wrote:
>>>>> Hello,
>>>>>
>>>>> syzbot found the following issue on:
>>>>>
>>>>> HEAD commit:    37a93dd5c49b Merge tag 'net-next-7.0' of git://git.kernel...
>>>>> git tree:       upstream
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1649d073980000
>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=a512b4a06724b76a
>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=460792609a79c085f79f
>>>>> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for
>>>>> Debian) 2.44
>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152086e6580000
>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139c2eef980000
>>>>>
>>>>> Downloadable assets:
>>>>> disk image:
>>>>> https://storage.googleapis.com/syzbot-assets/0dedaafff2ad/disk-37a93dd5.raw.xz
>>>>> vmlinux:
>>>>> https://storage.googleapis.com/syzbot-assets/aa7fae081497/vmlinux-37a93dd5.xz
>>>>> kernel image:
>>>>> https://storage.googleapis.com/syzbot-assets/9096b39b53e1/bzImage-37a93dd5.xz
>>>>>
>>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>>> Reported-by: syzbot+460792609a79c085f79f@syzkaller.appspotmail.com
>>>>>
>>>>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
>>>>> R13: 00007fe00de15fac R14: 00007fe00de15fa0 R15: 00007fe00de15fa0
>>>>>     </TASK>
>>>>> Oops: general protection fault, probably for non-canonical address
>>>>> 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
>>>>> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>>>>> CPU: 1 UID: 0 PID: 5994 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
>>>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google
>>>>> 01/24/2026
>>>>> RIP: 0010:bitmap_subset include/linux/bitmap.h:433 [inline]
>>>>> RIP: 0010:cpumask_subset include/linux/cpumask.h:836 [inline]
>>>>> RIP: 0010:rebuild_sched_domains_locked+0x2aa/0x980 kernel/cgroup/cpuset.c:967
>>>>> Code: 7d 05 00 41 83 c4 01 89 de 48 83 c5 08 44 89 e7 e8 fb 76 05 00 41 39 dc
>>>>> 0f 8d 4c 04 00 00 e8 fd 7c 05 00 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 0f 85
>>>>> 1d 06 00 00 48 8b 04 24 48 23 45 00 31 ff 44
>>>>> RSP: 0018:ffffc90003ecfbc0 EFLAGS: 00010246
>>>>> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000020
>>>>> RDX: ffff888028de0000 RSI: ffffffff8200f003 RDI: ffffffff8df14f28
>>>>> RBP: 0000000000000000 R08: 0000000000000cc0 R09: 00000000ffffffff
>>>>> R10: ffffffff8e7d95b3 R11: 0000000000000001 R12: 0000000000000000
>>>>> R13: 00000000000f4240 R14: dffffc0000000000 R15: 0000000000000000
>>>>> FS:  000055555c694500(0000) GS:ffff8881246a5000(0000) knlGS:0000000000000000
>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> CR2: 0000001b2f463fff CR3: 000000003704c000 CR4: 00000000003526f0
>>>>> Call Trace:
>>>>>     <TASK>
>>>>>     rebuild_sched_domains_cpuslocked kernel/cgroup/cpuset.c:983 [inline]
>>>>>     rebuild_sched_domains+0x21/0x40 kernel/cgroup/cpuset.c:990
>>>>>     sched_rt_handler+0xb5/0xe0 kernel/sched/rt.c:2911
>>>>>     proc_sys_call_handler+0x47f/0x5a0 fs/proc/proc_sysctl.c:600
>>>>>     new_sync_write fs/read_write.c:595 [inline]
>>>>>     vfs_write+0x6ac/0x1070 fs/read_write.c:688
>>>>>     ksys_write+0x12a/0x250 fs/read_write.c:740
>>>>>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>>>>     do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
>>>>>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>>> RIP: 0033:0x7fe00db9bf79
>>>>> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48
>>>>> 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73
>>>>> 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
>>>>> RSP: 002b:00007fff27bcda88 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>>>>> RAX: ffffffffffffffda RBX: 00007fe00de15fa0 RCX: 00007fe00db9bf79
>>>>> RDX: 00000000000000f6 RSI: 0000200000000000 RDI: 0000000000000003
>>>>> RBP: 00007fff27bcdaf0 R08: 0000000000000000 R09: 0000000000000000
>>>>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
>>>>> R13: 00007fe00de15fac R14: 00007fe00de15fa0 R15: 00007fe00de15fa0
>>>>>     </TASK>
>>>>> Modules linked in:
>>>>> ---[ end trace 0000000000000000 ]---
>>>>> RIP: 0010:bitmap_subset include/linux/bitmap.h:433 [inline]
>>>>> RIP: 0010:cpumask_subset include/linux/cpumask.h:836 [inline]
>>>>> RIP: 0010:rebuild_sched_domains_locked+0x2aa/0x980 kernel/cgroup/cpuset.c:967
>>>>> Code: 7d 05 00 41 83 c4 01 89 de 48 83 c5 08 44 89 e7 e8 fb 76 05 00 41 39 dc
>>>>> 0f 8d 4c 04 00 00 e8 fd 7c 05 00 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 0f 85
>>>>> 1d 06 00 00 48 8b 04 24 48 23 45 00 31 ff 44
>>>>> RSP: 0018:ffffc90003ecfbc0 EFLAGS: 00010246
>>>>> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000020
>>>>> RDX: ffff888028de0000 RSI: ffffffff8200f003 RDI: ffffffff8df14f28
>>>>> RBP: 0000000000000000 R08: 0000000000000cc0 R09: 00000000ffffffff
>>>>> R10: ffffffff8e7d95b3 R11: 0000000000000001 R12: 0000000000000000
>>>>> R13: 00000000000f4240 R14: dffffc0000000000 R15: 0000000000000000
>>>>> FS:  000055555c694500(0000) GS:ffff8881246a5000(0000) knlGS:0000000000000000
>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> CR2: 0000001b2f463fff CR3: 000000003704c000 CR4: 00000000003526f0
>>>>> ----------------
>>>>> Code disassembly (best guess), 1 bytes skipped:
>>>>>       0:    05 00 41 83 c4           add    $0xc4834100,%eax
>>>>>       5:    01 89 de 48 83 c5        add    %ecx,-0x3a7cb722(%rcx)
>>>>>       b:    08 44 89 e7              or     %al,-0x19(%rcx,%rcx,4)
>>>>>       f:    e8 fb 76 05 00           call   0x5770f
>>>>>      14:    41 39 dc                 cmp    %ebx,%r12d
>>>>>      17:    0f 8d 4c 04 00 00        jge    0x469
>>>>>      1d:    e8 fd 7c 05 00           call   0x57d1f
>>>>>      22:    48 89 e8                 mov    %rbp,%rax
>>>>>      25:    48 c1 e8 03              shr    $0x3,%rax
>>>>> * 29:    42 80 3c 30 00           cmpb   $0x0,(%rax,%r14,1) <-- trapping
>>>>> instruction
>>>>>      2e:    0f 85 1d 06 00 00        jne    0x651
>>>>>      34:    48 8b 04 24              mov    (%rsp),%rax
>>>>>      38:    48 23 45 00              and    0x0(%rbp),%rax
>>>>>      3c:    31 ff                    xor    %edi,%edi
>>>>>      3e:    44                       rex.R
>>>> The cpuset.c:967 is:
>>>>
>>>>       966         for (i = 0; i < ndoms; ++i) {
>>>>       967                 if (WARN_ON_ONCE(!cpumask_subset(doms[i],
>>>> cpu_active_mask)))
>>>>       968                         return;
>>>>
>>>> The oops was caused by accessing doms[i] which was kmalloc'ed in
>>>> generate_sched_domains() by calling alloc_sched_domains() in
>>>> kernel/sched/topology.c. Looking at the console log just before the oops, I saw
>>>>
>>>> [  124.398850][ T5994] FAULT_INJECTION: forcing a failure.
>>>> [  124.398850][ T5994] name failslab, interval 1, probability 0, space 0,
>>>> times 1
>>>> [  124.434865][ T5994] CPU: 1 UID: 0 PID: 5994 Comm: syz.0.17 Not tainted
>>>> syzkaller #0 PREEMPT(full)
>>>> [  124.434909][ T5994] Hardware name: Google Google Compute Engine/Google
>>>> Compute Engine, BIOS Google 01/24/2026
>>>> [  124.434936][ T5994] Call Trace:
>>>> [  124.434947][ T5994]  <TASK>
>>>> [  124.434959][ T5994]  dump_stack_lvl+0x100/0x190
>>>> [  124.435026][ T5994]  should_fail_ex.cold+0x5/0xa
>>>> [  124.435062][ T5994]  ? rebuild_sched_domains_locked+0x51/0x980
>>>> [  124.435113][ T5994]  should_failslab+0xc2/0x120
>>>> [  124.435153][ T5994]  __kmalloc_noprof+0xe0/0x850
>>>> [  124.435195][ T5994]  rebuild_sched_domains_locked+0x51/0x980
>>>> [  124.435266][ T5994]  rebuild_sched_domains+0x21/0x40
>>>> [  124.435314][ T5994]  sched_rt_handler+0xb5/0xe0
>>>> [  124.435359][ T5994]  proc_sys_call_handler+0x47f/0x5a0
>>>> [  124.435413][ T5994]  ? __pfx_proc_sys_call_handler+0x10/0x10
>>>> [  124.435475][ T5994]  vfs_write+0x6ac/0x1070
>>>> [  124.435511][ T5994]  ? __pfx_proc_sys_write+0x10/0x10
>>>> [  124.435562][ T5994]  ? __pfx_vfs_write+0x10/0x10
>>>> [  124.435597][ T5994]  ? __pfx_do_sys_openat2+0x10/0x10
>>>> [  124.435664][ T5994]  ksys_write+0x12a/0x250
>>>> [  124.435696][ T5994]  ? __pfx_ksys_write+0x10/0x10
>>>> [  124.435730][ T5994]  ? do_user_addr_fault+0x8d6/0x12f0
>>>> [  124.435787][ T5994]  do_syscall_64+0x106/0xf80
>>>> [  124.435834][ T5994]  ? clear_bhb_loop+0x40/0x90
>>>> [  124.435875][ T5994]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>>
>>>> So it looks like the oops may be expected. It may not be a bug in the cpuset
>>>> AFAICS.
>>>>
>>> Hi Longman,
>>>
>>> Thank you for looking into this issue.
>>>
>>> Since partition_sched_domains_locked can handle the situation where 'doms' is
>>> NULL, I think we should make it robust and fix it.
>>>
>>> The fix can be implemented as follows:
>>>
>>> In cpuset.c at line 964:
>>>
>>>           for (i = 0; i < ndoms; ++i) {
>>> -               if (WARN_ON_ONCE(!cpumask_subset(doms[i], cpu_active_mask)))
>>> +               if (doms && WARN_ON_ONCE(!cpumask_subset(doms[i],
>>> +                                         cpu_active_mask)))
>>>                           return;
>>>           }
>>>
>> The problem is that doms is not NULL. It is 0xdffffc0000000000 as shown in the
>> dmesg log. So the null check here won't do any good in this particular case. In
>> fact, there is already a null check right after alloc_sched_domains() above.
>>
> Looking at the dmesg log:
>
> [  124.660383][ T5994] Oops: general protection fault, probably for
> non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
> [  124.672366][ T5994] KASAN: null-ptr-deref in range
> [0x0000000000000000-0x0000000000000007]
>
> The address 0xdffffc0000000000 appears to be the KASAN shadow offset, which is
> configured in:
>
> arch/x86/Kconfig:413
> config KASAN_SHADOW_OFFSET
> 	hex
> 	depends on KASAN
> 	default 0xdffffc0000000000
>
> This indicates that doms is actually NULL. In generate_sched_domains(), doms is
> first assigned to NULL.
>
> Indeed, there is already a NULL check right after alloc_sched_domains(), when
> doms is NULL, it returns ndoms = 1 and doms = NULL. Therefore, I believe we need
> to add 'doms' check in the rebuild_sched_domains_locked.
>
Right. The for loop shouldn't be run if doms is NULL.

Sure. Please send a patch to make this change.

Cheers,
Longman


