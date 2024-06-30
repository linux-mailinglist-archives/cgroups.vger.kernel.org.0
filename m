Return-Path: <cgroups+bounces-3459-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F7F91D0CC
	for <lists+cgroups@lfdr.de>; Sun, 30 Jun 2024 11:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4899D1C20BBF
	for <lists+cgroups@lfdr.de>; Sun, 30 Jun 2024 09:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E782012D74F;
	Sun, 30 Jun 2024 09:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="s1kNaRKi"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FC0282F1;
	Sun, 30 Jun 2024 09:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719739319; cv=none; b=Xg/esLczxD9CJLTBl+MS0Jur+J7yVYg852jILPqP+ad12ZzhGH5FWDGUDOYri7P+DyqiIGOfA3kO1BtkqQmCVoOKz1sFfp1cojDoI2FdbiV+Wz39hS/trt41BwB6npcM8MgYdcQrOE5wU0YFLrBqrnWFTR/Zy5vM//Fx+45o5qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719739319; c=relaxed/simple;
	bh=ZmtVjDRRyORkx9G9mXFhcB5uwPsYT4bl0KVeYtguxFc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=IP3J0E4xLH0NfUbduWM1uQZdjpcY94vsiiQackFS+9D2jWmjM/G1bXi1cE3PoSjN539cJeCfxB/jkr1/x4Wav4O1WGQ5uEeUyY4Gf0TssPgOwM7umOs1jyu9aQjHxhLx5MYRixGuAweZ9IHqTo0AdAdQL+BZc2CRbHron/xdBms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=s1kNaRKi; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719739262; x=1720344062; i=markus.elfring@web.de;
	bh=4Ox+CoqQktM+04G5AXkVhtsqqZbwKD/erYL39VQd7P4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=s1kNaRKi40Si4giCINn+Ikl4gUS88NJQ2VXrZL+SevS/mvbBtyqoL71Hm4DiHTXY
	 nOhi6GxRzONTi+mDTTJa8A2wRAd4Wyw3WhaQIcpQOULoqPM+YKmb6BWJ90Si0FmQv
	 cIPcpjW9P0lN4VyaV3oUJQaNL6YaroocwtB9Bs7AXXYoGlCzJODYklv6YlmheZ1Kk
	 Y9xenLnqUI75QVCJXOKTJ2GIVXClSynEt1OsYWcEBYNW2Gr56wZeMa0U+O+Oy67zI
	 49Fh4g2/e1MSiY7jPCjF1iNVmzYORjOJTZ6moLjRkXLip8T6TUSpjr0RPAnBJP8il
	 Zir7RbvryfeDS4vU4g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8n46-1sLI6q2nLi-00yxNJ; Sun, 30
 Jun 2024 11:21:02 +0200
Message-ID: <e5a78840-b623-485c-b467-828a5a0b7d37@web.de>
Date: Sun, 30 Jun 2024 11:20:58 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chen Ridong <chenridong@huawei.com>, cgroups@vger.kernel.org,
 Aditya Kali <adityakali@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Serge Hallyn <sergeh@kernel.org>, Tejun Heo <tj@kernel.org>,
 Waiman Long <longman@redhat.com>, Zefan Li <lizefan.x@bytedance.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240628013604.573498-1-chenridong@huawei.com>
Subject: Re: [PATCH V4] cgroup/cpuset: Prevent UAF in proc_cpuset_show()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240628013604.573498-1-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ac2MgSGc6rRBaSoWAit1GqrwjITEH7Ep6A42evXWX0nvXHJkGIa
 kquVJmXCPA3twtKNxnZ8hXVKkhKCKUiga+Ya2xXnoWBTXwwWZAPTJt3MOKi98T4vgfMSHWL
 N3O/EdaIrH20bpC/0CCab1N0vax7wud/wxwsF3nVHwGC16BOP9MFXi3zAxMpo93/Zz/T00D
 J9J3+UqDxgbDC01ZGcj+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OahtbHllBVo=;z4fl6hb25KLpKAsYKSrsQ3SOooU
 BZnJoLKEMl6tWgGMgwS0yXDKejjMXPu44ds0crSQs9fR4CLZFc4PuJifEdmDQA8v1RNhgUIUZ
 6PQ3eAKP2Hy8/BI9ZkTRz7w+FgL7RAMWFDNi5zQwDIxym6sAXnCJUoRSjWfLCWQq/DAvTbysM
 eHIzJKMf8TJOPRrdcq9Cq7ACFxLI8TrJZKC1ACz5tut2viPbKHS4Kn1bd+MQK5jKACmDMxk+Y
 F95Na66X31XPG1mnw7vgEcDoZj9FtihPO4voCAr42mr1VzXLFBoHI3unmw34w+WyOHd2/NRg6
 5t2sZkayBrFn/LNscMQA/CEBZ1b3ke1Ocg/EHR0Edi3tF6e5c5NjCoZ1FHGazo6YeWIcokT1P
 df6tuVWxaOI2DSFlWpMwGj7R/PxRQnLbUlT/CqZ2HLzP/nYF+Hz1x4zjkuyE6pPjZy3Ell7Ac
 4KKBdyBlEq74n/h6JKTO7r+1WD+P048poq4M8Hw2X20zR+VCUuGIlRm/RlbZ8wa5VnXxz3ohf
 Zssq+VgKx60kRcpx7/uC0Em4ZRgH4h1A+gtqsdFVeBUaU7l/rOKz+gPpmQvaL0ZjX0mh00qEP
 iCmhRq/a2k/uTNrXQM1F27SVW2b8jc2ckZ8dmNuUz5Pb6N7ul+aT9piU2w4Maq/tGWCFP5Mj0
 e/P9rzztza8D565WCR3Q4z1lCtKMe00fu6vgnmY7FRAb6WNm0r672gvHukOixjIcNNIIeugGU
 jscjIg6UA39xkckvzF0nzmzxnHicoNGWA8QuLuPUQh5h7/Ysb+9BhCol6W6LMT1cgxKwZu+/E
 8qYkAD908SgTKo+oea8GOWhRqxbvGH8F0xOKTEek5FphU=

=E2=80=A6
> +++ b/kernel/cgroup/cpuset.c
=E2=80=A6
> @@ -5051,10 +5052,14 @@ int proc_cpuset_show(struct seq_file *m, struct =
pid_namespace *ns,
>  	if (!buf)
>  		goto out;
>
> -	css =3D task_get_css(tsk, cpuset_cgrp_id);
> -	retval =3D cgroup_path_ns(css->cgroup, buf, PATH_MAX,
> -				current->nsproxy->cgroup_ns);
> -	css_put(css);
> +	rcu_read_lock();
> +	spin_lock_irq(&css_set_lock);
> +	css =3D task_css(tsk, cpuset_cgrp_id);
> +	retval =3D cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
> +				       current->nsproxy->cgroup_ns);
> +	spin_unlock_irq(&css_set_lock);
> +	rcu_read_unlock();
=E2=80=A6

Under which circumstances would you become interested to apply statements
like the following?

* guard(rcu)();
  https://elixir.bootlin.com/linux/v6.10-rc5/source/include/linux/rcupdate=
.h#L1093

* guard(spinlock_irq)(&css_set_lock);
  https://elixir.bootlin.com/linux/v6.10-rc5/source/include/linux/spinlock=
.h#L567


Regards,
Markus

