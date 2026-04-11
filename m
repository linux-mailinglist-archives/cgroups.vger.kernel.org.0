Return-Path: <cgroups+bounces-15219-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJSkOGLN2WmftAgAu9opvQ
	(envelope-from <cgroups+bounces-15219-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 11 Apr 2026 06:26:10 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 114C23DE542
	for <lists+cgroups@lfdr.de>; Sat, 11 Apr 2026 06:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8783F302F9AF
	for <lists+cgroups@lfdr.de>; Sat, 11 Apr 2026 04:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927022DCBE3;
	Sat, 11 Apr 2026 04:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kkaDeRGb"
X-Original-To: cgroups@vger.kernel.org
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24D91E8332;
	Sat, 11 Apr 2026 04:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775881564; cv=none; b=ALYC0MNGS3i/WFjwgtSWb1wuUf51DSq0XZDTaoH7O8PXc6V7OiPV3JYxgFspEXZtN9OtDH7InAjK8LjuegY8o7u/pqrj2vBZtgPZysjsCsZUYD3T5BlGoBFGvifFMqEMHW38avuYRu0DFNCeGfU9yjmQ3jTDhEs8ju5ShomZQg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775881564; c=relaxed/simple;
	bh=i8ECkSpTHbdKnr+q+VhTGQbRZqS3ney23LDjnFzvsUU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=nEOOLwiH5yMS5EhgUaMMIp4AhVOSGugPT3kQSNIZv3vAwV3Jq2o8Y9y8FE/XuHGGzXYgZ5DKud4N87wffw9ntBVwoG/L7dny/BIKa38omDffV3dTWihO/A7qaSpY5qG2+F9H0iJaJpy59plg96wl16ek4Qq3KgLOjAasAHtXX4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kkaDeRGb; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1775881551; bh=K1kn5EOLSpbs0c/uaDu497Dr1rBVxMHC6uE5Jvub4KI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kkaDeRGb2OWwKonQwlBP+sdCFo45sYwrJN/jty5tBuRuDjohNT5DMaIK3/QhykGlp
	 0TODtCUhKJc8boxq3rPni3M/fjq4l5Iygdou+A/lp64vGzvpuuytgbmp/V82eUpElt
	 FvnnZ7Bw21QTuWotNFUc2teLSZ5d/YIySh5azl2s=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 66F36E3B; Sat, 11 Apr 2026 12:25:47 +0800
X-QQ-mid: xmsmtpt1775881547t2kvuohn0
Message-ID: <tencent_851B66256EBA58BB8933329E6D1BD54BBE08@qq.com>
X-QQ-XMAILINFO: MFA3rFz8fXqrm7QwfSDRR/rxICBlFpPOIBIQQRyCcNas2ayUSVgO6H7sI12vnm
	 r1nbAINbonOjhqZmGzpZuZALnMkJ5DrFpWG0tc/w7NhngJGrZfX9G6/WzZEj+eyPpIKXfkFJ9CGp
	 FSSbuf6DOSPELz/RPTAxW6ajIbmNhUy45radSB7wX/4pq5Y9X+FFlL3MS8PfkCbtSyE2wJ00NHEn
	 rUVRrN5/GXl1ouhaOWcnm2i7JUfJypUpJcB9E94wv8gE2KQ/vbVvHpP7bc+UKbeJdOs1sZESRwfj
	 hKjFwJBlTUGSHFk/uzLIP1bfe4JLy1HA9bz9bT9Ag+7uMzB6CQKauh9VgVUxcSRs1RdWYkfr9rCz
	 0QoKsMCCxeOP6pvL3FNLUsUULymgv+WAxTKRMoI37Gpibvj+KZUJBqB/irglfUvvGhmz3A0xsHFb
	 GVzvSHicXKr8c7e+UJ6aiqYRD64H2GljCyFi6tqi/TMLn2hzlBgmQdjp3kymqc2NTUw536UAYXQ0
	 pSpZrbOJmv0wNRnMShAEyNopVtbwoaje+iJYcS7MvTUb2mfFxCW+WdUzFWz68PCuN+cwix2KE++r
	 8izjK5YrpBXPFL0p3lFGtKkMVDXilzfQTFs6jDj3vkrdZikkwkJa7ZxwepPJFcI4vi+EqyqJTG92
	 0h0PnBpWrwNsLsxgJOw+xcmbZqd4q1xLeeuEvj2+6b6r6cety8NwPD+oT1t91zGODh7VZG7hCSbq
	 9xgjrSlbmIyKa862gEzTBQo3Bozx3fCFoVNYeMYOhs/jzIGTNDKqdGWiAskCXyZVvrhkDZGFSDaK
	 YeaTYxnwklMMNkT/ON8wXT6pWax6gqRNen3CKEIlZXGAo2KVqSP1a6baoQJBlsu7oNZwOc0UvyhS
	 je5LXP7e6npSudX+Yke/MzQiFb82O3tp2P0yvFg0zonMpcV9hv8GDX/bTgZbZls5xt0B2nJiUESb
	 nXkxRYSb+riqDmCwbJPR8ua5cDkK8Qu0TeD1G0JHxsEZzplAQ7Vo4auxzx5PgqsullPo+FiKb2Zo
	 qazN8DcA==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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
Date: Sat, 11 Apr 2026 12:25:47 +0800
X-OQ-MSGID: <20260411042546.163772-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <adlL_QXVAgCBH9L8@slm.duckdns.org>
References: <adlL_QXVAgCBH9L8@slm.duckdns.org>
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
	TAGGED_FROM(0.00)[bounces-15219-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:dkim,qq.com:mid]
X-Rspamd-Queue-Id: 114C23DE542
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 09:14:05 -1000, Tejun Heo wrote:
> >  static ssize_t pressure_write(struct kernfs_open_file *of, char *buf,
> >  			      size_t nbytes, enum psi_res res)
> >  {
> > -	struct cgroup_file_ctx *ctx = of->priv;
> > +	struct cgroup_file_ctx *ctx;
> >  	struct psi_trigger *new;
> >  	struct cgroup *cgrp;
> >  	struct psi_group *psi;
> > +	ssize_t ret = 0;
> >
> >  	cgrp = cgroup_kn_lock_live(of->kn, false);
> >  	if (!cgrp)
> >  		return -ENODEV;
> >
> > +	ctx = of->priv;
> > +	if (!ctx) {
> 
> This test likely isn't necessary but that's pre-existing.
Where?
Are you referring to the check for of->released within:
'kernfs_fop_write_iter()->kernfs_get_active_of()'? This check is not
performed under the protection of the cgroup_mutex; consequently, it
is susceptible to race conditions, rendering the value unreliable, as
it could be updated at any moment.
> 
> > +		ret = -ENODEV;
> > +		goto out_unlock;
> > +	}
> > +
> >  	cgroup_get(cgrp);
> 
> We don't need get/put if we don't drop the mutex, right?
I believe that is indeed the case; the cgroup_get() call here is intended
to facilitate subsequent operations, such as executing an smp store.

Edward
BR


