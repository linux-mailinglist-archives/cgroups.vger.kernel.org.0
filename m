Return-Path: <cgroups+bounces-15303-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ5eKpv23mkNNAAAu9opvQ
	(envelope-from <cgroups+bounces-15303-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 04:23:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 040223FFB8E
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 04:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACC143040768
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 02:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4C278F4A;
	Wed, 15 Apr 2026 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IOjTynhS"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC2B3090C1
	for <cgroups@vger.kernel.org>; Wed, 15 Apr 2026 02:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776219760; cv=none; b=obRqcVvoGTR3Hbe6fqibKqGyh7fnppgAwZUUc/NNq2IBu8dTE4SZee6V0ya8yKscJDocpbWbEaxt+R+EbWh8rUOW5oPdLzOljYIYzag33QDngTtFboRpsqKaANv5AxTgCxhbI+rmqHiXkFKGTlj9P1R5sxHBRG7A6NvJfjb1hPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776219760; c=relaxed/simple;
	bh=jdSheN3HpBEtv6EP089OLg7gp2WBe8q9pFmRKgZtS8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjqVJH+fbM2zAwg67NdbpiP0mRccV8ze2RJlzS1ZjKcS12e2kl5C/dCboy75FCNE7tc8TL3sdrJfKd5I/Ij27jFPGe4CGyEhJ9e8JaCUzxTs4TcbNQoRRgg0yqXyj0i+RKwbGD1E6kb0Oxa0Zrod/Qmx07YjupYSgXv771r0vxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IOjTynhS; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e657c791-0768-452e-9a21-ae5dd13aa706@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776219755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SxdlTa6h3czNPKK/Gx4JCfQxJJmMB+PRQCNkrNojt5w=;
	b=IOjTynhSxRbXbBSIhYqt2yRd7gag1Ol6pIPFPPWfKEsMNn0st+gT7Nx2aN/4/2E9c0tByV
	o2/VyHreSZkVVP70OUwZcbozDNSPvno3Q4trUeesMZXyk/tXVVMWMlHl+WLb4/JQU3iAJb
	UrympiKJEuVbJBeZ/4t3uteVtAH3I6k=
Date: Wed, 15 Apr 2026 10:22:05 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [mm?] [cgroups?] WARNING: bad unlock balance in
 lruvec_stat_mod_folio
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: syzbot <syzbot+1a3353a77896e73a8f53@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org,
 muchun.song@linux.dev, roman.gushchin@linux.dev,
 syzkaller-bugs@googlegroups.com, zhengqi.arch@bytedance.com, yosry@kernel.org
References: <69d54494.050a0220.3030df.0002.GAE@google.com>
 <ad1tV5WpFhxbQ86N@linux.dev> <358c60e1-fa91-40a1-9e00-84c93340c04e@linux.dev>
 <ad5134-5FkAKDqtP@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <ad5134-5FkAKDqtP@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=4e6c8be618ab359];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15303-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost:email,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups,1a3353a77896e73a8f53];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 040223FFB8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/15/26 1:15 AM, Shakeel Butt wrote:
> On Tue, Apr 14, 2026 at 11:52:13AM +0800, Qi Zheng wrote:
>> Hi Shakeel,
>>
>> On 4/14/26 6:28 AM, Shakeel Butt wrote:
>>> +Qi & Yosry
>>>
>>> On Tue, Apr 07, 2026 at 10:53:24AM -0700, syzbot wrote:
>>>> Hello,
>>>>
>>>> syzbot found the following issue on:
>>>>
>>>> HEAD commit:    cc13002a9f98 Add linux-next specific files for 20260402
>>>> git tree:       linux-next
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=10d8946a580000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=4e6c8be618ab359
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=1a3353a77896e73a8f53
>>>> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
>>>>
>>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>
>>> Let's wait for the reproducer. I can only think of cgroup_subsys_on_dfl() check
>>> returning different value in get_non_dying_memcg_start() and
>>> get_non_dying_memcg_end() to cause this uneven rcu unlock. However I can't think
>>> why and how that can happen.
>>>
>>
>> My AI bot told me that the cgroup_subsys_on_dfl_key can be dynamically
>> modified at runtime during a rebind:
>>
>> rebind_subsystems()
>> --> if (dst_root == &cgrp_dfl_root) {
>> 		static_branch_enable(cgroup_subsys_on_dfl_key[ssid]);
>>      } else {
>> 		dcgrp->subtree_control |= 1 << ssid;
>> 		static_branch_disable(cgroup_subsys_on_dfl_key[ssid]);
>>      }
>>
>> However, when I actually tested it, I hit the following error:
>>
>> mount: /tmp/cg-rb-repro: mount point is busy.
>>
>> Indeed, there are already many child cgroups under the cgroup v2 root
>> (the VM just booted):
>>
>> root@localhost:~# find /sys/fs/cgroup -mindepth 1 -maxdepth 2 -type d | head
>> -50
>> /sys/fs/cgroup/sys-kernel-debug.mount
>> /sys/fs/cgroup/dev-mqueue.mount
>> /sys/fs/cgroup/user.slice
>> /sys/fs/cgroup/user.slice/user-0.slice
>> /sys/fs/cgroup/sys-kernel-tracing.mount
>> /sys/fs/cgroup/init.scope
>> /sys/fs/cgroup/system.slice
>> /sys/fs/cgroup/system.slice/systemd-networkd.service
>> /sys/fs/cgroup/system.slice/systemd-udevd.service
>> /sys/fs/cgroup/system.slice/system-serial\x2dgetty.slice
>> /sys/fs/cgroup/system.slice/wpa_supplicant.service
>> /sys/fs/cgroup/system.slice/system-modprobe.slice
>> /sys/fs/cgroup/system.slice/systemd-journald.service
>> /sys/fs/cgroup/system.slice/unattended-upgrades.service
>> /sys/fs/cgroup/system.slice/system-systemd\x2dgrowfs.slice
>> /sys/fs/cgroup/system.slice/ssh.service
>> /sys/fs/cgroup/system.slice/dhcpcd.service
>> /sys/fs/cgroup/system.slice/systemd-resolved.service
>> /sys/fs/cgroup/system.slice/dbus.service
>> /sys/fs/cgroup/system.slice/systemd-timesyncd.service
>> /sys/fs/cgroup/system.slice/system-getty.slice
>> /sys/fs/cgroup/system.slice/systemd-logind.service
>> /sys/fs/cgroup/dev-hugepages.mount
>>
>> So it seems impossible to rebind memory in a production environment
>> using systemd?
>>
>> Then I disabled systemd:
>>
>> set `init=/bin/bash`
>>
>> and found that I could successfully run the following commands:
>>
>> root@(none):/# mkdir -p /tmp/cg-rb-repro
>> root@(none):/# mount -t cgroup -o none,name=rb none /tmp/cg-rb-repro
>> root@(none):/# mount -t cgroup -o remount,memory none /tmp/cg-rb-repro
>> [   65.903125][  T241] option changes via remount are deprecated (pid=241
>> comm=mount)
>> root@(none):/# mount -t cgroup -o remount,name=rb none /tmp/cg-rb-repro
>> [   73.405829][  T242] option changes via remount are deprecated (pid=242
>> comm=mount)
>> root@(none):/# umount /tmp/cg-rb-repro
>>
>> So it seems this race condition does exist. Should we fix it?
> 
> This only succeeded because there weren't any active cgroups. Were you able to
> trigger the warning as well. If not, I think we should just wait for

Nope.

> reproducer from syzbot before doing anything.

OK, Let's wait for syzbot to reproduce it.

> 


