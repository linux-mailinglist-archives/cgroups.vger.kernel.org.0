Return-Path: <cgroups+bounces-15224-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK1KKeMG2mnbxwgAu9opvQ
	(envelope-from <cgroups+bounces-15224-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 11 Apr 2026 10:31:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EF53DEF7B
	for <lists+cgroups@lfdr.de>; Sat, 11 Apr 2026 10:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B18C130382B2
	for <lists+cgroups@lfdr.de>; Sat, 11 Apr 2026 08:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A1B2E03F1;
	Sat, 11 Apr 2026 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="AnY7CzOo"
X-Original-To: cgroups@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633B1186284;
	Sat, 11 Apr 2026 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775896244; cv=none; b=i5bEcTyv24obYIFV1B9l8DfhnFSoYqe9HbzrBtg1lI4mO6RuHCbN5hnCYaqRzbj2QBrY6q38eswCzAtIglxy5MZWpEzIV2nVSY16KQj/fW7vYOe+AsSbf/saZOkq8Brs9Hu6T8J1fGE6CUiHYXq4w11BKZxXwWKfFe9tg3woYFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775896244; c=relaxed/simple;
	bh=skrY+U4oMTSySo317MfV/eYVkQ9N7AzQmaha3wtLzj8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=pmmHYM83xMMgfRtHd3298Wop46dgsyCyGpShGQgAXNIq1fPfSR/rkhjQAKVGeBX1VtNVgSQ+wuLCCQGnuMWgxN+x+343UstGOj41oI6tU2OPxAIhLf9CE5yFOc3Xk84rtkC5B326idXZIJsuu79njV89rJvfa1iKHH4noVQy6Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=AnY7CzOo; arc=none smtp.client-ip=43.163.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1775896238; bh=CL3cDx7qQIDgnhdqanC+XIrHjoanaRizBfsMbac3RHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AnY7CzOowSnDZ3gPAoFaAUvOIfiyUfD1t1yqSl4rmEKX3EWK3+oEcxY/Lr71QQ4N+
	 TcRw+64QxYmAsTgxsnIyj3VdaoijxKtBu5dKrmrGanxRQVD7/DGsw++QJqOnDm2KOH
	 WbemgLkMVunZBBVkhDgTGlwbHvTPUp/ci3PFTlNo=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 75638232; Sat, 11 Apr 2026 16:29:22 +0800
X-QQ-mid: xmsmtpt1775896162tby4ed9qv
Message-ID: <tencent_157925F8BA70BB65336B9E831B714BA11B08@qq.com>
X-QQ-XMAILINFO: OcN56dxiYj5TkOs9EAzJ6G55jQBi0zpe186eXCuj9rByzWLbsu80ECeJkfLaT0
	 Xrc2JkknhslCZzK6fhvCp2lcaAtDXrkwGTbNFLVFGOSFKzfpnJXwL9udTK8YwPfMXrM8rF9Pp8vV
	 hwzuf2PQc1f50NlJ4D29fhs5eimeESDA/1Xuv0lqUUibcK9RF/wyPBwr8/axyw8+MEZiPjh/9RCU
	 w0v+cpheQCimsAsEW3MLcG8CXpUqsnUhX5eCgSlSaLICWGExtNVIIUQrc4ACHfKP5BaxINv/Qc5w
	 M1uIWgQ+4JfrvRteZQzHlaNrBR4PBgTeW7hnJI0IPhIIb5M12ujQI3dLUi/HV5BBc6tuoejO0AJH
	 5JwNJUTB8SZNsgof/Eb3r5NELFbgnkk3GtVQCAPLkO8z0cDPx7TKK/bljNvwSIs2DohwMS8gr5vh
	 YkW11TZoAA6g5cU3S2muwI4ixu2kSG57M+ylfIXyPBARA7d++FEaoLFUIIJeiE0W/pj39+i1AxoR
	 0X88MPdrapobWVUt0cdddaWwLL0jHwMg0POwfhEyS0XWLqfwQ3w6nH6JKCVRpvbeU9/6+3pr0vbZ
	 BQgZv0hrQtRPvPmgHdBl4ya2lMA8ifDv3xuH+re0QlwzxD62YroY5b2ls8bmnS2FumuPILHDYWvJ
	 BNoF8IOYVmuxjhQTXX/egMME8enSqu/wIVnmYjj9cuPQ6f/EZU6s4Kcu6m8l+QeG7/a/PTx7sr/J
	 Sn3eUl2Vmbf1wRnoajiZqrOa4FFKKmhnpQdpfgfFXEo+YWJA8FJlzIqn+skC44jQ8k5h6SR+G+Ev
	 LuiEnamwqtWf48p8RZlr0kxdB4DxwUu4uwGy+xzl5kTCS9llY233D4CSO0vYlYs/LOmCnByqGPZ7
	 G6d7ZVjZHxqfkmzRPPDiiojrwugYdOZ6QnmzGpTolpWzPyumT4XlH27+T/zXIqCqK5s1JOLUZGmy
	 75pIUcxK6pJ/dpG6M7/Tis4kRQ5LeFC19m2+4n4brWY+eiG5o7swExHqk0TfO/Dm1zY/0Mvd0+8V
	 3BzlY2ffuV/tVqteGFKSjzuKAdDi8=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Edward Adam Davis <eadavis@qq.com>
To: tj@kernel.org
Cc: cgroups@vger.kernel.org,
	chenridong@huaweicloud.com,
	eadavis@qq.com,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	mkoutny@suse.com,
	syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v2] sched/psi: fix race between file release and pressure write
Date: Sat, 11 Apr 2026 16:29:22 +0800
X-OQ-MSGID: <20260411082921.172650-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <adn6xRNYwep9dQyQ@slm.duckdns.org>
References: <adn6xRNYwep9dQyQ@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-15224-lists,cgroups=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,huaweicloud.com,qq.com,cmpxchg.org,suse.com,syzkaller.appspotmail.com,googlegroups.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[eadavis@qq.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qq.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[cgroups,33e571025d88efd1312c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:dkim,qq.com:mid]
X-Rspamd-Queue-Id: 02EF53DEF7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 21:39:49 -1000, Tejun Heo wrote:
> > > > +	ctx = of->priv;
> > > > +	if (!ctx) {
> > >
> > > This test likely isn't necessary but that's pre-existing.
> > Where?
> > Are you referring to the check for of->released within:
> 
> No, I'm talking about of->priv. I don't think it can be NULL while a live
> cgroup kn is locked, can it?
If the lock is acquired before the execution of cgroup_file_release()
completes, it will not be NULL; however, if acquired afterwards, it
will invariably be NULL.

Edward
BR


