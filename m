Return-Path: <cgroups+bounces-15248-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHVMHf9Q3GlYPQkAu9opvQ
	(envelope-from <cgroups+bounces-15248-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 04:12:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B663E6BF0
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 04:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED22F300F536
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 02:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832162264A9;
	Mon, 13 Apr 2026 02:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Dqnn4TTR"
X-Original-To: cgroups@vger.kernel.org
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6911CFBA;
	Mon, 13 Apr 2026 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776046315; cv=none; b=F6n1cB3Qe+slziybvuBZe6F2hgpjn8UrB1YOWljsYlNcDgCKp5FYozRcPxGuTb/jxyvI6+G274AQK6UMaI39q846G79hUPNKtiisl0KVLHu9ZDzgNhgQy0F9a3GWpIMDZ+fkbjvu4r1LU9G8H1un/theT3+0//+SF8Kfefd9a+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776046315; c=relaxed/simple;
	bh=BLCYUSkITLNCjlz6KHAxEj3mDBoQbpYrpLJmsq6rXW0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Wy5qYm/JcJXMWkR5OoxUWdxZvF6MZN/DELMxZZK3V4eKyOVPWhNmttnIuyfFoSEsIt0eIN0qk4UJZkwM6CWJ9LsGjSXMCf7aAngHzVpn7RXrxNeq5KudXGl+WBY970gWnNJVXi9F/nFWxSlYojXrDC0LJNXY8f+QXLBgfu8Z9cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Dqnn4TTR; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1776046304; bh=eLLP4J7rlZpRObI0kLpCJZLG7wzcYY4JfqYgqmhhgps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dqnn4TTRqSDqUbmeB8tjRrWsCPds/jf83637rLAt7QHVECd/REuTJrmF/RUvTG+Ng
	 VpLYYqaYDoiNJvgpjuUgiumk69YTh6XLpcykv1TXZ5uokf+EqXekqtdSvoFsIb8mQ6
	 UpPrvG1iE1WWE9v7S2WpmRGV8gMteY6/4KYuNQWA=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 2E904C01; Mon, 13 Apr 2026 10:11:41 +0800
X-QQ-mid: xmsmtpt1776046301trymcbfk9
Message-ID: <tencent_71D4D2F5C6460999EEE5AEC14C8767C74606@qq.com>
X-QQ-XMAILINFO: NGX5+lQVxpC+t4Pv1/1dFKdCR451Uz5Imh2csx/8CGgtTuUKAWPphm5nCEKXgl
	 beOJxD4FvQ+75F38bGkx+vOMEbEfJ1WUZLwn+qVO4lnQ21MZoe8R37Wbhk1GMSwHgQnuMiMIpfSn
	 B3b+aKsGwSAoXXN3ep++qecHADm2JuFa/d2DWbYq+lX4/9GXTY4JV5TqMz1X5e+VXPT8eSa69Kv+
	 sZhtXLCNrCckFFBdKTcK59DysigqTfbyuWx8K2rP0oyLNmA1W133OPf906mm5SNl2uJiLHALFhZY
	 8cjMCEz3xKltxBogFc+lvbNzTpJQwzQcnLVG/8HB+zPbsyDjlcWgDrx+rygU0ZZjZCTfYZdE+QDP
	 UE/t2XKdgfwsMJJhtkhaA3GCBebQ/pl2nhDN3zAV2zk1HjY7ek6qRg4jVPqONtxfmY79RvJtn37r
	 wAmbMQ9MBd3dfNKHHRmcGXrvVCcqcy6vmtyZFA8czN6Gy1BqcUxQ64Oeh19od7nQ3e/MiXgGPalv
	 yDf/VzGkOqtVUg40cCPfsQ8NsJR0ym1nRCrx6xF1+sdCPk0FcxhLZNrd8UJ0ZDVRAj+mOAc/4Yky
	 bP3cpa10joWK+8nuY7wgNtkPxCaQXJgXqqZoOLuEPudCD+uWMQnoeUwh6NntlB9Y6judMJyTEBMW
	 /K3ZQZjwPH+iAm64ClJD5BZL5DkIR8W4D/D03V81ePMXjAbUDNhSOxHbUvG0SU5sI1lzsRyTQc1K
	 bTp1bqRTycfo8KqPcB4HDLFDtScQVRUH6BnWyiiFPqC9XXJUdwvXuKMjP/QXTlY4UeLRmQygo7Cs
	 a/m/CtzGP9nepdrb94AahD2TrNWZzdh7BYWcLr6yp7rKST8C/vzD6/y3ZYdfzT5QKWCf4V03Oy6l
	 e8pflE17gY4Hve5wEn6A/2ao1sE9owCa8nyZfE8vYQfwGyaZa+NGDv1MdnRRUPTqc84CdbyBaGNP
	 QohilgXpDd9kd4J+1BjSUnYXpifhk3mT+sNZXxuXZBqN5oW8v11EJ6oCw6iBhWGYFdVIxdVmZCpe
	 NL0urXh2EeciEpUxuoiPgbsxQEv0VHlwgrIgU3UXBRD3nnr82h7ZJ7Om4Uwqk=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
Subject: Re: [PATCH v2] sched/psi: fix race between file release and pressure write
Date: Mon, 13 Apr 2026 10:11:41 +0800
X-OQ-MSGID: <20260413021140.219718-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b586bd09-8b47-415d-a183-7385a678c723@huaweicloud.com>
References: <b586bd09-8b47-415d-a183-7385a678c723@huaweicloud.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,qq.com,cmpxchg.org,suse.com,syzkaller.appspotmail.com,googlegroups.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15248-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[qq.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[qq.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eadavis@qq.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups,33e571025d88efd1312c];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 70B663E6BF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 09:51:19 +0800, Chen Ridong wrote:
>On 2026/4/11 12:25, Edward Adam Davis wrote:
>> On Fri, 10 Apr 2026 09:14:05 -1000, Tejun Heo wrote:
>>>>  static ssize_t pressure_write(struct kernfs_open_file *of, char *buf,
>>>>  			      size_t nbytes, enum psi_res res)
>>>>  {
>>>> -	struct cgroup_file_ctx *ctx = of->priv;
>>>> +	struct cgroup_file_ctx *ctx;
>>>>  	struct psi_trigger *new;
>>>>  	struct cgroup *cgrp;
>>>>  	struct psi_group *psi;
>>>> +	ssize_t ret = 0;
>>>>
>>>>  	cgrp = cgroup_kn_lock_live(of->kn, false);
>>>>  	if (!cgrp)
>>>>  		return -ENODEV;
>>>>
>>>> +	ctx = of->priv;
>>>> +	if (!ctx) {
>>>
>>> This test likely isn't necessary but that's pre-existing.
>> Where?
>> Are you referring to the check for of->released within:
>> 'kernfs_fop_write_iter()->kernfs_get_active_of()'? This check is not
>> performed under the protection of the cgroup_mutex; consequently, it
>> is susceptible to race conditions, rendering the value unreliable, as
>> it could be updated at any moment.
>>>
>>>> +		ret = -ENODEV;
>>>> +		goto out_unlock;
>>>> +	}
>>>> +
>>>>  	cgroup_get(cgrp);
>>>
>>> We don't need get/put if we don't drop the mutex, right?
>> I believe that is indeed the case; the cgroup_get() call here is intended
>> to facilitate subsequent operations, such as executing an smp store.
>> 
>
>Sorry, I don't quite understand why get/put is needed. Could you elaborate a bit
>more?
Oh, I had overlooked the fact that acquiring the live kn lock simultaneously
performs a cgroup_get; therefore, after extending the scope of the mutex,
the original explicit get/put operations are no longer necessary. I will
issue a new version of the patch shortly to address this specific point.

Edward
BR


