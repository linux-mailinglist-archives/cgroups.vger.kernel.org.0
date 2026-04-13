Return-Path: <cgroups+bounces-15247-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id j7IKGylM3GkpPAkAu9opvQ
	(envelope-from <cgroups+bounces-15247-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 03:51:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EFD3E6B36
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 03:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8462F30078F1
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 01:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6641F8755;
	Mon, 13 Apr 2026 01:51:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCA627470;
	Mon, 13 Apr 2026 01:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776045093; cv=none; b=LaAMsxz56KXeH3Ys7Nkg7GOi7VNPZHKCD1kGG98/b4xfbYjsGkLVa/qWS6WQ9LFcyp10QS201aG7+Yzwk5YLPRI3VOrQju3Fydd2Nhldg8mHDmTrRTngByUYzBVjSXI0+6dYvR3JAWkSMgUcRjET+B6qZVTij6pA9OtzpB9tawo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776045093; c=relaxed/simple;
	bh=ggeuTUFoJhDYvuhCm63u5dkkOBpk4RdQGVwHJDuQ0oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/U0pf0weH4oAvCElnAeRd6AnV5mfDTwDPwMm6fBgPooPlKgFltoPkxDuKS9KnhQO7M0czlmEi3xIseBZmxZyg5BGuDtwcV6gTJwDJ4n4CMklAo3qxQ5sOBSK3uO+FsbrwmQQgPhrnTDF81Me7uGGtCrrut0QSo5aZcX5apjXMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fv9NH0S7HzYQth5;
	Mon, 13 Apr 2026 09:50:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E589840571;
	Mon, 13 Apr 2026 09:51:20 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgDXum8XTNxpcGvXAA--.1230S2;
	Mon, 13 Apr 2026 09:51:20 +0800 (CST)
Message-ID: <b586bd09-8b47-415d-a183-7385a678c723@huaweicloud.com>
Date: Mon, 13 Apr 2026 09:51:19 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/psi: fix race between file release and pressure
 write
To: Edward Adam Davis <eadavis@qq.com>, tj@kernel.org
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, mkoutny@suse.com,
 syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <adlL_QXVAgCBH9L8@slm.duckdns.org>
 <tencent_851B66256EBA58BB8933329E6D1BD54BBE08@qq.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <tencent_851B66256EBA58BB8933329E6D1BD54BBE08@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDXum8XTNxpcGvXAA--.1230S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyrKrW3ArWrXry5tr18Krg_yoW8Gr1rpr
	9YyayUtrWDJrykWw40ga4jvF1Iyw48JF15J3yUG3W3t3sIgr1fKr17urWj9a4rArsakr42
	vrs0vrWfur9YqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15247-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FREEMAIL_TO(0.00)[qq.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups,33e571025d88efd1312c];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 84EFD3E6B36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/11 12:25, Edward Adam Davis wrote:
> On Fri, 10 Apr 2026 09:14:05 -1000, Tejun Heo wrote:
>>>  static ssize_t pressure_write(struct kernfs_open_file *of, char *buf,
>>>  			      size_t nbytes, enum psi_res res)
>>>  {
>>> -	struct cgroup_file_ctx *ctx = of->priv;
>>> +	struct cgroup_file_ctx *ctx;
>>>  	struct psi_trigger *new;
>>>  	struct cgroup *cgrp;
>>>  	struct psi_group *psi;
>>> +	ssize_t ret = 0;
>>>
>>>  	cgrp = cgroup_kn_lock_live(of->kn, false);
>>>  	if (!cgrp)
>>>  		return -ENODEV;
>>>
>>> +	ctx = of->priv;
>>> +	if (!ctx) {
>>
>> This test likely isn't necessary but that's pre-existing.
> Where?
> Are you referring to the check for of->released within:
> 'kernfs_fop_write_iter()->kernfs_get_active_of()'? This check is not
> performed under the protection of the cgroup_mutex; consequently, it
> is susceptible to race conditions, rendering the value unreliable, as
> it could be updated at any moment.
>>
>>> +		ret = -ENODEV;
>>> +		goto out_unlock;
>>> +	}
>>> +
>>>  	cgroup_get(cgrp);
>>
>> We don't need get/put if we don't drop the mutex, right?
> I believe that is indeed the case; the cgroup_get() call here is intended
> to facilitate subsequent operations, such as executing an smp store.
> 

Sorry, I don’t quite understand why get/put is needed. Could you elaborate a bit
more?

-- 
Best regards,
Ridong


