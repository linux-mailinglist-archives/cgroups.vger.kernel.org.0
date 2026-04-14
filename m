Return-Path: <cgroups+bounces-15295-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONIXKWp23ml3EgAAu9opvQ
	(envelope-from <cgroups+bounces-15295-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 19:16:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B2B3FCF40
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 19:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B48943026625
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 17:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A250138F249;
	Tue, 14 Apr 2026 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lDiQZ3kP"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBB9368976
	for <cgroups@vger.kernel.org>; Tue, 14 Apr 2026 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186959; cv=none; b=FOJ2tZKPBIwt28Hc2+fsvnWkhcT/TtcRff7ic+4Ruo8vHSUVd+km0iy4L6Ix/FynSDE9P+6WDUw057B01BPTa2ME82GL7lc+Gfby8esifwk1nmVRv5WvJk6y2WVB1KihuYzsiyGo0U0Sjz9Zre3gK9gLNx5tiKrNbbb1M9xd+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186959; c=relaxed/simple;
	bh=+yOuWfkJMZGUjL1CffCk8qUOBnhgBBIANB0U4RMqN9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCWMZ/iHtL4r7EAEdoIO+9AcHdrxP1zFPRNONq3zxa06O8suls/UXfWzR+8M3VhKBkIUwa0pxA/kWl98ovLzB9vmgrQ4C2pb4IJnvxzG2mo4IWurQDg/qyEnh2c6eRK/zJ2LZiz1/dLy2OiNOLLOpb+bE4bimTH02ENkLRqqu9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lDiQZ3kP; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 14 Apr 2026 10:15:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776186955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sdGaJ1kfPvwvrDDRsofvgKCgSPPMcVc4q17G+sHRwG8=;
	b=lDiQZ3kP1q4ljLOtXGUeSiDgZVrlt+imZNexfUnsxU8YhLd0XOmGT3pF3uPDUsOcutbWli
	5ZTtF5pRjNh1RX0UPL9rPW9f6duLdOvWhexGPRDTf58BbbvLhT6pW9XxzFkUcmLusLBSjg
	qZkttKYp+ZoKBxjOq9VWWerfHYKqDJ4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: syzbot <syzbot+1a3353a77896e73a8f53@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, syzkaller-bugs@googlegroups.com, zhengqi.arch@bytedance.com, 
	yosry@kernel.org
Subject: Re: [syzbot] [mm?] [cgroups?] WARNING: bad unlock balance in
 lruvec_stat_mod_folio
Message-ID: <ad5134-5FkAKDqtP@linux.dev>
References: <69d54494.050a0220.3030df.0002.GAE@google.com>
 <ad1tV5WpFhxbQ86N@linux.dev>
 <358c60e1-fa91-40a1-9e00-84c93340c04e@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <358c60e1-fa91-40a1-9e00-84c93340c04e@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=4e6c8be618ab359];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15295-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost:email,linux.dev:dkim,linux.dev:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,syzkaller.appspot.com:url];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups,1a3353a77896e73a8f53];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: C5B2B3FCF40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 11:52:13AM +0800, Qi Zheng wrote:
> Hi Shakeel,
> 
> On 4/14/26 6:28 AM, Shakeel Butt wrote:
> > +Qi & Yosry
> > 
> > On Tue, Apr 07, 2026 at 10:53:24AM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    cc13002a9f98 Add linux-next specific files for 20260402
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=10d8946a580000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=4e6c8be618ab359
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=1a3353a77896e73a8f53
> > > compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Let's wait for the reproducer. I can only think of cgroup_subsys_on_dfl() check
> > returning different value in get_non_dying_memcg_start() and
> > get_non_dying_memcg_end() to cause this uneven rcu unlock. However I can't think
> > why and how that can happen.
> > 
> 
> My AI bot told me that the cgroup_subsys_on_dfl_key can be dynamically
> modified at runtime during a rebind:
> 
> rebind_subsystems()
> --> if (dst_root == &cgrp_dfl_root) {
> 		static_branch_enable(cgroup_subsys_on_dfl_key[ssid]);
>     } else {
> 		dcgrp->subtree_control |= 1 << ssid;
> 		static_branch_disable(cgroup_subsys_on_dfl_key[ssid]);
>     }
> 
> However, when I actually tested it, I hit the following error:
> 
> mount: /tmp/cg-rb-repro: mount point is busy.
> 
> Indeed, there are already many child cgroups under the cgroup v2 root
> (the VM just booted):
> 
> root@localhost:~# find /sys/fs/cgroup -mindepth 1 -maxdepth 2 -type d | head
> -50
> /sys/fs/cgroup/sys-kernel-debug.mount
> /sys/fs/cgroup/dev-mqueue.mount
> /sys/fs/cgroup/user.slice
> /sys/fs/cgroup/user.slice/user-0.slice
> /sys/fs/cgroup/sys-kernel-tracing.mount
> /sys/fs/cgroup/init.scope
> /sys/fs/cgroup/system.slice
> /sys/fs/cgroup/system.slice/systemd-networkd.service
> /sys/fs/cgroup/system.slice/systemd-udevd.service
> /sys/fs/cgroup/system.slice/system-serial\x2dgetty.slice
> /sys/fs/cgroup/system.slice/wpa_supplicant.service
> /sys/fs/cgroup/system.slice/system-modprobe.slice
> /sys/fs/cgroup/system.slice/systemd-journald.service
> /sys/fs/cgroup/system.slice/unattended-upgrades.service
> /sys/fs/cgroup/system.slice/system-systemd\x2dgrowfs.slice
> /sys/fs/cgroup/system.slice/ssh.service
> /sys/fs/cgroup/system.slice/dhcpcd.service
> /sys/fs/cgroup/system.slice/systemd-resolved.service
> /sys/fs/cgroup/system.slice/dbus.service
> /sys/fs/cgroup/system.slice/systemd-timesyncd.service
> /sys/fs/cgroup/system.slice/system-getty.slice
> /sys/fs/cgroup/system.slice/systemd-logind.service
> /sys/fs/cgroup/dev-hugepages.mount
> 
> So it seems impossible to rebind memory in a production environment
> using systemd?
> 
> Then I disabled systemd:
> 
> set `init=/bin/bash`
> 
> and found that I could successfully run the following commands:
> 
> root@(none):/# mkdir -p /tmp/cg-rb-repro
> root@(none):/# mount -t cgroup -o none,name=rb none /tmp/cg-rb-repro
> root@(none):/# mount -t cgroup -o remount,memory none /tmp/cg-rb-repro
> [   65.903125][  T241] option changes via remount are deprecated (pid=241
> comm=mount)
> root@(none):/# mount -t cgroup -o remount,name=rb none /tmp/cg-rb-repro
> [   73.405829][  T242] option changes via remount are deprecated (pid=242
> comm=mount)
> root@(none):/# umount /tmp/cg-rb-repro
> 
> So it seems this race condition does exist. Should we fix it?

This only succeeded because there weren't any active cgroups. Were you able to
trigger the warning as well. If not, I think we should just wait for
reproducer from syzbot before doing anything.


