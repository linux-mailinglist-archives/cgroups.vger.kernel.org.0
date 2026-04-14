Return-Path: <cgroups+bounces-15287-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMaoNMi93WlRigkAu9opvQ
	(envelope-from <cgroups+bounces-15287-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 06:08:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 393923F56FA
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 06:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3CCD302A2DF
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 04:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E3331E82F;
	Tue, 14 Apr 2026 04:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="iDnhtRgv"
X-Original-To: cgroups@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECDC82899;
	Tue, 14 Apr 2026 04:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776139712; cv=none; b=BpH4xCsT1fstwHvqQfn76ETDwRs+JkzhypbpNaw4VxIQPB+tjjnzanxO4kjW/YaAgNbmknLyL85A3fGBevGIalO6KCFAcYHi9KYxZfhaoam6E1veDLX3fYPfm9JE+48/6lfBZTvkuEqv7lOwUU9TG8Ugmofv1iCmX3lpiZYE42o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776139712; c=relaxed/simple;
	bh=Wal3X0WKwfC+xF1/wEK5hoZxivM9kgFFcCModMZ4F7A=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=HlI0I4b1ViHovgB9dQpAvmCQLTwl32X5d/wmT+VUiSadqSiLued8X6GhIhQjho2rjkG+wkefDMFgZ7x/4JiFnU9IQS4rTT/mfQgoasypFUL2u8CbwdWJ9FULRAtezVDypxV49haMVC6S8FcTfP8hrk1pCUuPhe3PpSs0BdNvkvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=iDnhtRgv; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1776139699; bh=jDxj1RyW3LKj5kxEQPvRDRYWLdHTe/C4xrEIc86Y/+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iDnhtRgvS+h/sKIt5TXCENrCZYMfk0mvP9EHKUMuI0rlHINOFGd0oh3rhz3FFSQV6
	 8nI9thBCPspiB3Gf8O6gvKMMvURac/LhOfb+w8LZG6AmJL5rDNArPWtQR7c3Fp1mUW
	 1C0Ic81DSX1u3L9r8t6OE+xLzBsrV37N9raLePqo=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 20F318E3; Tue, 14 Apr 2026 12:08:15 +0800
X-QQ-mid: xmsmtpt1776139695tbp3jyorj
Message-ID: <tencent_4ED99363237E896983BEC4571777B767C605@qq.com>
X-QQ-XMAILINFO: NQp/UN4soYLTp2KDxyYOlHLbOwApRKLiaQXecH44QghRpha+1pdwBRLmBLt4Md
	 AYkaIBtYjt4yOj97GiP95BmwpKZxoGvU31agdSbXqAlAw5u4ZRAaYRe5PxEEjax1WRCKKgw3v9Of
	 ib6Rk5woKt+Mi1PBpQlkLxPMBy8bcb/gM55uFKknK7KIelzoweLl9c4LfBmyAFLMl4t/82KkxrYI
	 Fjy/NrD8PI0BP5Y0ggjFYDeR5gPJ5TU7DqZQw0Z/pVIWt73nl+LRvh96T+0xYqA7Jwm0VoU0nhk0
	 FLui0QXH2jjw62mcudAQQap39yK+IntQExSsuvSZmMbVyGAekUEAKOo+EUZciwGpQFGqrlSrUWzL
	 b6NVbq8SjFWOlBMYDPUFvjhVfwvAzC30sBCfgSn4sO+oJsWZeAcUw2/ruAvirVh7zCsHOMVrb8Y5
	 Q7bqNrClVSCJy1XoJglN/ZGrLXubZpj/CrI9VLaNgfSpZ1ybGqkTp58T30NCHPjJRGrov4Iiw3Dh
	 t3PTL5p2feGCLgjD5luNlDlGSpJms/XgLyrikFIhDnXQrOigVjkYtrwcWNZ/uASQz+8Xcn5B0GWJ
	 SBjgkhXL5FN7zZCxR1I+oelBhAaqJK8KdH/tSLUi/K4jLDEljk2dRbRnkM6CiwQTO8FvjIOHgUKW
	 ZGPsJiQFyg+Oq17KBjJcD5cyHPWaJmuR3yuXx+rSmuc5KyfOl7V0nR7E1xc91YCwLzEt3EENdtSp
	 H78xqdNreDmtqeIjMunHOZRMRkx21DT4alV83RyzDufoa82cfhV4mDe//UuhRlStTO1WOmpcieFQ
	 1RrQpmNA5jDGNrKzFPH8ExaNkJU1a6Tjn/C9XytKhzfJ0BMcsTc30GWgLtQXDY3xlLIfIUo6oSKO
	 NsTatvdIyGJncP/3EIXRAQ++3BdZIlP7nZazi6ZkOFhzLvlamNnooK2Ro7eNwGaCMYYNiibCiNl2
	 n8VUzsULA9vkKD22tn1DyrOEyEhe5zVAKgZN5lzRSZQwqstr3IlDIXcTcxx+dITzkTdtGwa5Hse/
	 uY1EP9gA==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Edward Adam Davis <eadavis@qq.com>
To: chenridong@huaweicloud.com
Cc: cgroups@vger.kernel.org,
	eadavis@qq.com,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	mkoutny@suse.com,
	syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	tj@kernel.org
Subject: Re: [PATCH v4] sched/psi: fix race between file release and pressure write
Date: Tue, 14 Apr 2026 12:08:15 +0800
X-OQ-MSGID: <20260414040814.259161-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <febf75a0-5fc7-4fad-b43b-3c4bc2543531@huaweicloud.com>
References: <febf75a0-5fc7-4fad-b43b-3c4bc2543531@huaweicloud.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-15287-lists,cgroups=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,qq.com,cmpxchg.org,suse.com,syzkaller.appspotmail.com,googlegroups.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[eadavis@qq.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[qq.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[cgroups,33e571025d88efd1312c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 393923F56FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 10:29:20 +0800, Chen Ridong wrote:
> CPU0: write memory.pressure               CPU1: write cgroup.pressure=0
>   ==================================       ==================================
> 
>   kernfs_fop_write_iter()
>     kernfs_get_active_of(of)
>     pressure_write()
>       cgroup_kn_lock_live(memory.pressure)
>         cgroup_tryget(cgrp)
>         kernfs_break_active_protection(kn)
>         ... blocks on cgroup_mutex
> 
>                                         cgroup_pressure_write()
>                                         cgroup_kn_lock_live(cgroup.pressure)
>                                         cgroup_file_show(memory.pressure, false)
>                                           kernfs_show(false)
>                                             kernfs_drain_open_files()
>                                               cgroup_file_release(of)
>                                                 kfree(ctx)
>                                                   of->priv = NULL
>                                         cgroup_kn_unlock()
> 
>       ... acquires cgroup_mutex
>       ctx = of->priv;        // may now be NULL
>       if (ctx->psi.trigger)  // NULL dereference
> 
> IIUC, for rmdir, 'of->priv cannot be NULL' may be true, but for the other patch
> shown above, it might not be.
Marvelous!

Edward
BR


