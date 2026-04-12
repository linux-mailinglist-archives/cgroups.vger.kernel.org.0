Return-Path: <cgroups+bounces-15228-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9XLKKEgF22lH8QgAu9opvQ
	(envelope-from <cgroups+bounces-15228-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 04:36:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1323E288D
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 04:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E21D93019FF7
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 02:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC642517AF;
	Sun, 12 Apr 2026 02:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xugpyKvY"
X-Original-To: cgroups@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3E8C1F;
	Sun, 12 Apr 2026 02:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775961365; cv=none; b=NNhQUC3rFko01Bod/RATBKY9eV/JUAhCGRVx4l2D8OXUrKMYOjSoxcfvIxKOuzoHTIzztt/2Zkd9aCGGj+YtQNxWnL+4lr9zoMfyFQbrWzbzpIIXUTFLy7iqK/GSO0H3v7mAq+Tq19Oy2jTYJE60jm/pzERlPzLEDKWZADe3UDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775961365; c=relaxed/simple;
	bh=oZpygt5veg4gN1JIMbq9I2HufR4MBznrR5iw+Z5KkMU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=pg4lrT4kserzriKgloK3LdeK4k3Cggza3eZValqBqNYQ0nRX1GchbTTMQJjjC5u0BBJ7FOgXj4f3nOw7MJtW6ocIcbz8oN3mmi1PFBghdcO+NSZu3vcW1e8Tey7/4OlSPBj0+2gWPGc1JcxFlx9Pne/xQvWRI0oPXYTN8TXBops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xugpyKvY; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1775961351; bh=okJBsOlxDHpFAM7NhGEEhCt7HdGAI6TWwaqscffbuRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xugpyKvYq5y9B5HbFww+j3ah1HlT+7me5cRV948V26/bNVbeQkEep6FPdwWVf7Yc2
	 GL+NBduQmpSkyXi4WJ7u74l35sMrSk9fS0dxtOXURhytY1DWkwun30PCY12rVXtfqq
	 qKICCAjnLmSA60f6eaoPKlHR4nHYljMRR1uE67lw=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 81A95824; Sun, 12 Apr 2026 10:32:26 +0800
X-QQ-mid: xmsmtpt1775961146t2w2epghc
Message-ID: <tencent_A146D952E4866889986EDAAECA8CB1A7EA06@qq.com>
X-QQ-XMAILINFO: No7DFzN00JnRbsmVaoXCL+6dBLsVptj/dxRnlnWIBcChnvbzK2e0e8Zit2hwn1
	 LMBYvSero//VvgQkY1EN9PAQKVdr2vMFk2SdfATdrRLUFFPXJKcZNncoJn/Jt0nLufFaS6GeYRcO
	 ZNluQ72Ew/773ZS+Eq+XPwptGrs8ADtoXHtPeMGSNmqPZVGJ3NPhyWZYxuNZbiY8rhYqXr6u56WD
	 EJRshOkXXuV3j1zbiEA82JlesREnjmxik98SbvA9l2d6BUXOnED0XbvYO8/FlFW0xmTUF6bmufEr
	 FWmZ7Nhgekey+ZOVvXyVeqVSq/NhfNFDpqIoQdq/ewyNDmWKQgT9QxZt2+BLXRomaEmC0WEmMmkr
	 jCpYDGn3exn9KXMs9TLGaevheyTM8tSqbW6sh/hMDUlXqmMOSYSa+6M0unU8jKS/VD4HqRecRV2V
	 QQTo9ORJRiyhHatCjbTc8rN5+uWu1Vj9iqLopBo62ew1wAjxB+PAmbWUaKsCLN6QRAp/d4SM9m5E
	 srYbCs3iatW8uUzTrSrEoSdVdtCtUEWqpdGBR1uqhMVE3Sn+aDN1PBiXknSv28xubySeByS/ouRk
	 9W6PH+yFMDGJUv+J+EqeM1IuzHJgVLWph36suY11mkts0hrPKOtoOrVj5PGj3+LkEBQJWWHdpqyo
	 BQftQalxU+CVBx2VIzrz/XZiFpH1HC1A4nBhysv5xhPsZhkW/O8QfO+qYWLBFGkPLOO86DCiZocK
	 Sljf34VC9tqAjtyt1ZmuhJkUlYogwBBBTMIyUqJVwcsj5lJ8Xw2SToeO2bVh/Z4RgXozwWI3i6e2
	 ao2fSNPU8hvF8f9G2MmA3tS7bqzh4VOCe0ZDMmtT1SCytzwHPEq7MKM8lsYfdjPsFFUbxDNaxMz0
	 5X/ZLYfCHHw3bKWzAeqplJ/OjRCGwOiN3SyZhvXv++0q7ioNnMfVAweGux1z2enpURljF3haJGjy
	 A47XBDfZSK8JaI/N7MptiPCRfLN5qow8MW8/Aieur2XExNYevDU/AwwxrWFhYyyF0OzAtreHk=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
Date: Sun, 12 Apr 2026 10:32:26 +0800
X-OQ-MSGID: <20260412023225.190373-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <adqxrX8Huq1J4BLG@slm.duckdns.org>
References: <adqxrX8Huq1J4BLG@slm.duckdns.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-15228-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qq.com:dkim,qq.com:mid]
X-Rspamd-Queue-Id: 0D1323E288D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 11 Apr 2026 10:40:13 -1000, Tejun Heo wrote:
> On Sat, Apr 11, 2026 at 04:29:22PM +0800, Edward Adam Davis wrote:
> > On Fri, 10 Apr 2026 21:39:49 -1000, Tejun Heo wrote:
> > > > > > +	ctx = of->priv;
> > > > > > +	if (!ctx) {
> > > > >
> > > > > This test likely isn't necessary but that's pre-existing.
> > > > Where?
> > > > Are you referring to the check for of->released within:
> > >
> > > No, I'm talking about of->priv. I don't think it can be NULL while a live
> > > cgroup kn is locked, can it?
> >
> > If the lock is acquired before the execution of cgroup_file_release()
> > completes, it will not be NULL; however, if acquired afterwards, it
> > will invariably be NULL.
> 
> Hmmm? While the write is in flight the file can't be released and the cgroup
> couldn't have been dead if lock_live succeeded. This part is tangential
> anyway. Let's ignore for now.
I have once again walked through the entire workflow for the cgroup
deletion operation. Indeed, if the active kn lock can be successfully
acquired while executing pressure write, it indicates that the cgroup
deletion process has not yet reached its final stage; therefore, the
`priv` pointer within open_file cannot possibly be NULL.

I will submit the third version of the patch shortly.

Edward
BR


